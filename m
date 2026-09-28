Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D7B499F1E;
	Mon, 28 Sep 2026 22:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635015; cv=none; b=KX0NeGBKjZZnECqRUMLQcvV4UBQx1Z4WgL9ilikWP1iL+1rELBb2DDQ5599aqkTszXJIkWQGjZugX6pVDX5huUwlpc/geP2XWI30YImxz89UkltDe16ThqzdVVAytU8D0lDUCJBb46JSqkHzoMiPIo10MlF1UjBbY4wTTIC+0UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635015; c=relaxed/simple;
	bh=NqBNE51bJx4UPSYMjOt1UjkT6HegT2zBHYDaKQlQUAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsLk9yqhghn6QQCLHZDLxnsuPMLF0K7mwUr3riz2+Chm/1WcfaaI9HC0MIjlmI8hGO9T9swKfneI910no7zlFKGTkzORVj0Sp1mJuNYxBkJhhnLoovYK/VdzaTE6PZtD+1+tuUnKpmKmpq+mnhyeaWCqQQQpptYSmsfxTMf1Oek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ii9hsZaB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ii9hsZaB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDBA1F00899;
	Mon, 28 Sep 2026 22:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790635013;
	bh=fI+zezBWtJo4PhVH2Jn+7LYv6E+83YkjR2yJzrkGXm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ii9hsZaBEoKorMBwVo+0DoFtJwJsurfvBv+3dndeEYJx7kdW85xFgBI2b8F3b6pax
	 jv7bh13fK7lgyOnB+gqzEjIS/xqesNNSNHOlxVDpPXDesp7UpBDcmdV2z0dRyepu1q
	 ilWwq+mgksUVxjV1Y7krSkXE1/2rZvaMAc9Fm0s2HOGl7LedYMR1c+YqfCC9CeieRJ
	 iqDJzmruUBySalsHrI7lIGTIF26IGkQbzF1BJgnCNQFyVU8S0pBQbYZo0GHtu68qtk
	 0jEVEpthqudxx1woGIkVTtRVuUZECL7DdZicwN5IU+Zl9yFDAL5I2xdt2TrOn01irX
	 Hha0XCp7eQMYw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jv@jvosburgh.net,
	hawk@kernel.org,
	sdf@fomichev.me,
	emil@etsalapatis.com,
	liuhangbin@gmail.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	aleksander.lobakin@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/5] net: drop GSO skbs instead of handing them to XDP
Date: Mon, 28 Sep 2026 15:36:48 -0700
Message-ID: <20260928223648.2739371-6-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928223648.2739371-1-kuba@kernel.org>
References: <20260928223648.2739371-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb BPF paths have a number of helpers to fix up the GSO
state after packet modifications. XDP has no such support.

"Real" / driver XDP runs before the SW GRO, and drivers generally
disable HW-GRO when XDP is attached (with the exception of IDPF,
story for another time), so this is not an issue. We also try
to disable HW-GRO and elide SW GRO when generic XDP prog is
attached. These precautions are not 100% today, and IMHO fixing
that is impossible. Let's explicitly drop GSO skbs on input to XDP.

First example how things can go sideways today - bonding.
We only disable & elide GRO on the device to which program is
attached. Nothing reaches the devices below it, and for a stacked
device that is where the packets come from:

  ip link set dev bond0 xdpgeneric obj prog.o sec xdp

leaves every slave with GRO on and no xdp_prog of its own, so
netif_elide_gro() lets them coalesce as usual. bond_handle_frame()
then returns RX_HANDLER_ANOTHER, __netif_receive_skb_core() loops back
round to another_round with skb->dev switched to the bond, and the
program gets handed a packet which was never on the wire. HW-GRO is
the same story - while netif_disable_lro() walks the lower devices,
its HW-GRO counterpart never did (this is largely the point of
distinguishing between LRO and HW-GRO).

Example two - veth. Generic XDP on a veth gets there by a different route.
veth_xdp_set() takes NETIF_F_GSO_SOFTWARE away from the peer so that
no GSO skb is ever built for a device running XDP, but generic XDP does
not go through ndo_bpf, so none of that happens.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/xdp.h  | 16 ++++++++++++++++
 drivers/net/veth.c |  3 +++
 net/core/dev.c     |  4 ++++
 3 files changed, 23 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..5a234aab1e1c 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -291,6 +291,22 @@ static inline bool xdp_buff_add_frag(struct xdp_buff *xdp, netmem_ref netmem,
 	return true;
 }
 
+/**
+ * xdp_skb_feature_check() - can this skb be handed to an XDP program?
+ * @skb: skb about to be turned into an xdp_buff
+ *
+ * Return: true if the skb must not reach the program and has to be dropped.
+ */
+static inline bool xdp_skb_feature_check(const struct sk_buff *skb)
+{
+	if (likely(!skb_is_gso(skb)))
+		return false;
+
+	net_warn_ratelimited("%s: dropping coalesced packet before XDP, receive offloads are still on\n",
+			     skb->dev->name);
+	return true;
+}
+
 struct xdp_frame {
 	void *data;
 	u32 len;
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 71227d0389aa..5635037e3b60 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -756,6 +756,9 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 	struct sk_buff *skb = *pskb;
 	u32 frame_sz;
 
+	if (unlikely(xdp_skb_feature_check(skb)))
+		goto drop;
+
 	if (skb_shared(skb) || skb_head_is_locked(skb) ||
 	    skb_is_nonlinear(skb) ||
 	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
diff --git a/net/core/dev.c b/net/core/dev.c
index 096d1dedebfd..fbeb3df4c11f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -158,6 +158,7 @@
 #include <linux/once_lite.h>
 #include <net/netdev_lock.h>
 #include <net/netdev_rx_queue.h>
+#include <net/xdp.h>
 #include <net/page_pool/types.h>
 #include <net/page_pool/helpers.h>
 #include <net/page_pool/memory_provider.h>
@@ -5516,6 +5517,9 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	u32 metalen, act;
 	int off;
 
+	if (unlikely(xdp_skb_feature_check(skb)))
+		return XDP_DROP;
+
 	/* The XDP program wants to see the packet starting at the MAC
 	 * header.
 	 */
-- 
2.55.0

