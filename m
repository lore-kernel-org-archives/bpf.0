Received: from mta0.migadu.com (out-89.mta0.migadu.com [91.218.175.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84C5372049
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786620778; cv=none; b=HuqyxsR5FUSVXoFCpHbSr+gzuS1q2DQgLFiIzZYyg37pDZRgq39ctoZ1okPVM4t22Dt6qfF0ahZ8+UYhDkoWXyioYRDRixHGp3TpRqkeVkEAgkaUdHz0FDmdcUOoP7PJOiYeGrAhvbFvZxlMnjWi5k1gpIZnaRnr6NjrlPSgDXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786620778; c=relaxed/simple;
	bh=cZkj5BPSYYoc5aDEyFKO1RL8X23y1PD207f7mnoVj0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DY5E/AG8Bi77VicUvded4PU4zGOXhmIJ5UmIdnlc6x7Q4febhF9ryIV1JgfOn5Fam6DPvr7I9p7x/GZsRuNq4fLnYeaJUGaIfTzUsWNnW6VAAxIP6tEu+dusOUhvBGl5M+FuHMjoNVTw0F1QhbFaj637ScAMsLKkGclh2A6JZpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nUo4vtEj; arc=none smtp.client-ip=91.218.175.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nUo4vtEj"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cZkj5BPSYYoc5aDEyFKO1RL8X23y1PD207f7mnoVj0k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786620773; v=1; x=1787225573;
 b=nUo4vtEjQNJe1GYAwtSsoCEMjyl4ePBV88Ry+gsDBMw4oCCG220HHGh937wG9/xWRL5WcwJ0
 sY8WEGjYCIyzNjEaBch/FKDg7gGchMPdvNN/USUk3Y59FZ6T20rQMAJ2e/n1h1DEa/EZLk5N5eB
 jUoBGXVrKMCD9QfBtY3xgRAQ=
X-Envelope-To: bpf@vger.kernel.org
Received: from localhost.localdomain (147.136.157.0)
	by smtp.migadu.com with ESMTPS id 40f3c96585ea3264;
	Thu, 13 Aug 2026 11:32:53 +0000
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Kenneth Lee <kennethbwlee@snu.ac.kr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Martin Willi <martin@strongswan.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next] net: xdp: don't assume an Ethernet header in generic XDP
Date: Thu, 13 Aug 2026 19:32:24 +0800
Message-ID: <20260813113229.381136-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kenneth Lee reported a bug [1]:

  skb_vlan_push got skb with skb->data not at mac header (offset 14)
  WARNING: net/core/skbuff.c:6474 at skb_vlan_push+0x5ec/0x8a0
   ____bpf_skb_vlan_push net/core/filter.c:3239 [inline]
   bpf_skb_vlan_push+0x216/0x8b0 net/core/filter.c:3229
   bpf_prog_run_data_pointers+0x17c/0x240 include/linux/filter.h:917
   tcf_bpf_act+0x31c/0x940 net/sched/act_bpf.c:50
   tcf_action_exec+0x2c1/0x720 net/sched/act_api.c:1147
   tcf_classify+0x6e4/0x1080 net/sched/cls_api.c:1860
   tc_run+0x31c/0x5d0 net/core/dev.c:4411
   sch_handle_ingress net/core/dev.c:4486 [inline]
   __netif_receive_skb_core+0x141b/0x2ec0 net/core/dev.c:6054

bpf_prog_run_generic_xdp() just assumes xdp->data is an Ethernet header:

	eth = (struct ethhdr *)xdp->data;
	orig_host = ether_addr_equal_64bits(eth->h_dest, skb->dev->dev_addr);
	orig_bcast = is_multicast_ether_addr_64bits(eth->h_dest);
	orig_eth_type = eth->h_proto;

But an L3 device (ARPHRD_NONE, ARPHRD_TUNNEL, ...) has no L2 header at
all - its mac_len is 0 and xdp->data is really the L3 header, so those
orig_* values are garbage.

When that garbage comparison says the header changed, we then do:

	__skb_push(skb, ETH_HLEN);
	skb->pkt_type = PACKET_HOST;
	skb->protocol = eth_type_trans(skb, skb->dev);

eth_type_trans() resets mac_header and pulls ETH_HLEN back, so skb->data
does not move at all, but we now have mac_len == 0 while
skb_mac_header(skb) == skb->data - ETH_HLEN.

tc ingress relies on mac_len == skb->data - skb_mac_header(skb) to get
skb->data onto the mac header, so __skb_push(skb, skb->mac_len) pushes
nothing, the program runs with skb->data ETH_HLEN past the mac header,
and bpf_skb_vlan_push() hits the WARN_ONCE above.  skb->protocol also
ends up parsed from uninitialised headroom.

So skip the Ethernet part entirely when the skb has no ETH_HLEN sized L2
header.  The program still runs and its action is still returned.

Refusing to attach XDP to L3 devices instead would not help: mac_len is a
property of the skb, not of the netdev, so an ARPHRD_ETHER device can see
mac_len == 0 too.

[1]: https://lore.kernel.org/bpf/20260812043643.808295-1-kennethbwlee@snu.ac.kr/

Fixes: 22b6034323fd ("net, xdp: Update pkt_type if generic XDP changes unicast MAC")
Reported-by: Kenneth Lee <kennethbwlee@snu.ac.kr>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/dev.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index b390c2edfb33..5c395460854f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5489,11 +5489,12 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 {
 	void *orig_data, *orig_data_end, *hard_start;
 	struct netdev_rx_queue *rxqueue;
-	bool orig_bcast, orig_host;
+	bool orig_bcast = false, orig_host = false;
+	__be16 orig_eth_type = 0;
 	u32 mac_len, frame_sz;
-	__be16 orig_eth_type;
 	struct ethhdr *eth;
 	u32 metalen, act;
+	bool has_eth;
 	int off;
 
 	/* The XDP program wants to see the packet starting at the MAC
@@ -5519,10 +5520,21 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 
 	orig_data_end = xdp->data_end;
 	orig_data = xdp->data;
-	eth = (struct ethhdr *)xdp->data;
-	orig_host = ether_addr_equal_64bits(eth->h_dest, skb->dev->dev_addr);
-	orig_bcast = is_multicast_ether_addr_64bits(eth->h_dest);
-	orig_eth_type = eth->h_proto;
+
+	/* xdp->data only points at an Ethernet header if this skb actually
+	 * carries one.  Devices with a different link layer (mac_len == 0
+	 * for ARPHRD_NONE/TUNNEL/RAWIP/PPP/..., IPOIB_ENCAP_LEN for IPoIB)
+	 * have nothing to inspect here, and must not have skb->mac_header
+	 * relocated by the ETH_HLEN fixup below.
+	 */
+	has_eth = mac_len == ETH_HLEN;
+	if (has_eth) {
+		eth = (struct ethhdr *)xdp->data;
+		orig_host = ether_addr_equal_64bits(eth->h_dest,
+						    skb->dev->dev_addr);
+		orig_bcast = is_multicast_ether_addr_64bits(eth->h_dest);
+		orig_eth_type = eth->h_proto;
+	}
 
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
 
@@ -5554,14 +5566,16 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 		skb->data_len = 0;
 
 	/* check if XDP changed eth hdr such SKB needs update */
-	eth = (struct ethhdr *)xdp->data;
-	if ((orig_eth_type != eth->h_proto) ||
-	    (orig_host != ether_addr_equal_64bits(eth->h_dest,
-						  skb->dev->dev_addr)) ||
-	    (orig_bcast != is_multicast_ether_addr_64bits(eth->h_dest))) {
-		__skb_push(skb, ETH_HLEN);
-		skb->pkt_type = PACKET_HOST;
-		skb->protocol = eth_type_trans(skb, skb->dev);
+	if (has_eth) {
+		eth = (struct ethhdr *)xdp->data;
+		if ((orig_eth_type != eth->h_proto) ||
+		    (orig_host != ether_addr_equal_64bits(eth->h_dest,
+							  skb->dev->dev_addr)) ||
+		    (orig_bcast != is_multicast_ether_addr_64bits(eth->h_dest))) {
+			__skb_push(skb, ETH_HLEN);
+			skb->pkt_type = PACKET_HOST;
+			skb->protocol = eth_type_trans(skb, skb->dev);
+		}
 	}
 
 	/* Redirect/Tx gives L2 packet, code that will reuse skb must __skb_pull
-- 
2.43.0

