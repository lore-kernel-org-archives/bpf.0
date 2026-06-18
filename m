Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB51374A0D
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781806847; cv=none; b=B9Abmnicur5YEtf2A/LVvJTW58mq+6dLUQ1n7Kj1yHKR9CZqWzTW0QUfY4ohXUTvo3h4Sg0aFoNKOqxrzCBQVfBKLN4HnbhEdWvU4B68gKbGfcJTuwpSnZcWcpQxpAnctJ3dKe8inZFUxreJg2ZfXia875MYZZ+z189vKaBZZ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781806847; c=relaxed/simple;
	bh=9Q8XceuwfXu3J+N8u/LsL+GSsa6JZKhxnhTkscQL8IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQSTC2DJaRCqd4nXXrmBsRUoX1HL4sRp+dkXaxDHwLY0c8nOdNFdf22ZiWdPLHaVLfIoFR/ZbUyOdA3Tt55S/ZbSOp+F0MD3H6ymEW8ifhJk7HNdnA+AZTgjn/NbQh4xNHcS33b8tFPA5GixcInGYGLkCedGDuFdIQgJsDElDP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=vBKhf4Jv; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b="vBKhf4Jv"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30beb45c50cso138904eec.1
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 11:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1781806840; x=1782411640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8iJ+hPA9AmbIsay0hDv08UHV8Hjz9Hsxd24MLmTzII=;
        b=vBKhf4JvMMJjUSNMOSB/ngPWRQPpneorynY23PMArgBdeXxllA+uNcCTaE6Z3haU5Z
         kU7HKl4wH24CIuA9RL9Q7OOhv9+GpAguyJsl3vhOAuQstdlyUc4sHPd6zRMe0d9cRdip
         sKD3cPK/itBEHUSdP2r7Ar9u8ZyfMt1fsQBgn9WsuCX0B/sON9n0GERdsPsyypsRS+Dm
         W2thrdPIrG7/P1BASN0s4SCfHllEEtfAiWSGNoFmTUndLGX0SO2dg9B6sc07FEw7XJ3D
         B6w26f9prvz9MbE3sYtYbGvsw6NZUzzID0rtw1H0FjBzzth0soUnYmveCkXZyCqWpKPg
         ioMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781806840; x=1782411640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o8iJ+hPA9AmbIsay0hDv08UHV8Hjz9Hsxd24MLmTzII=;
        b=se8t0bTTOTrH935tPqUNAHDP6/wIgwQ6iBrDEaGx2BGLqFcqXf7GvTqaNDLHlKDCWH
         xNLyneTtopePgXGA11evnjZZUbE+2jr374K/yOKyHcZ/lPh3J9aXpu/R8RCmWMT7QQZw
         k34JpXulBlTPqHx96EZk8lVtJyDf7YODZCK8bNfabbx6b9Yy1GA7b8esiuWIz55PJOVK
         UsDE7guLmYByIlMci1fjY/aFCYrA46wPuwt6TM1KvIWbppPRga9eGveTrBnnI6MDGnpq
         VpNX/VgmQYZwL3aRJ6hFI53jmUFys8+rhVtrqv6Oe4eoDr0Dkd6gyTDURB2T6lCnXSM6
         6jeA==
X-Gm-Message-State: AOJu0YxqTAcH17YT2YfdpMjQlFPQxenK3fG2/eMZZt+EZ+5C8GCKah1Y
	LPC+q4rzN8EnnUroCL59t1J2C/JYL0RAh3/j8B9Ix8FBOKLrx4h631yYHhxreLlO0FAAqmaW9v4
	Gkse5
X-Gm-Gg: AfdE7cly7ifc9JflUW6KwH7aJRtV7lQQ0UT71vxBM2oWjSVo1T7uAY1gMrBeOagNzQX
	d0vvuutigpFody+whoZwYRrr6g9NKD8nzL61apnGgblr0TwSrQ2JMiYkZg4+IHNaEHHHcXBgoIW
	rfI8Vn0kQ+LY6I3xaSzfTKK+ySiF0UjEmMCPtipKK3LD6rSfADT6MoJk3gx1CTXSRZvkA+M2QNo
	BXFf5qy+Er8brZhmIrpynbqYKA6a7kEKeMlpOs9ElRKZuBjhhq8nmULHAwlrN5tqZctIU1aWtmC
	Uy/ludxMgrOZvK7Xk7l4zE7u5F0RO7A3n/G1poMtNVUdF38VHw98gUtJMKKB/hDcWJrm0tqLLzE
	F0WAXWUtd6Yi8nC5K/AJbrKBIl4GpxeMAZij4pZrLIZNrQpQj3jkXKhmv0KrmOn3JvujVucekOK
	l3
X-Received: by 2002:a05:693c:2d8f:b0:304:8860:74d6 with SMTP id 5a478bee46e88-30c06d89d7bmr168135eec.1.1781806840067;
        Thu, 18 Jun 2026 11:20:40 -0700 (PDT)
Received: from t14.. ([2001:5a8:47ec:d700:1b1d:38b6:64b7:ee72])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c06c33c88sm205950eec.19.2026.06.18.11.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 11:20:39 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Paul Chaignon <paul.chaignon@gmail.com>
Subject: [PATCH v2 bpf-next 1/2] bpf: Support BPF_F_EGRESS with bpf_redirect_peer
Date: Thu, 18 Jun 2026 11:20:32 -0700
Message-ID: <20260618182035.43811-2-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618182035.43811-1-jordan@jrife.io>
References: <20260618182035.43811-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have several use cases where a pod injects traffic into the datapath
of another so that the traffic appears to have originated from that
pod. One such use case is a synthetic flow generator which injects
synthetic traffic into a pod's datapath to enable dynamic probing and
debugging. Another is a transparent proxy where connections originating
from one pod are redirected towards another which proxies that
connection. The new connection is bound to the IP of the original pod
using IP_TRANSPARENT and its traffic is injected into that pod's
datapath and handled as if it had originated there. This can be used for
mTLS, etc.

We use bpf_redirect(BPF_F_INGRESS) to direct traffic leaving the proxy,
flow generator, etc. towards the target pod, ensuring that eBPF programs
that are meant to intercept traffic leaving that pod are executed.
However, this doesn't work with netkit.

With netkit, an ingress redirection from proxy to workload skips eBPF
programs that are meant to intercept traffic leaving the pod, since they
reside on the netkit peer device. One workaround is to attach the
same program to both the netkit peer device and the TCX ingress hook for
the netkit pair's primary interface, but

a) This seems hacky and we need to be careful not to run the same
   program twice for the same skb in cases where we want to pass that
   traffic to the host stack.
b) We're trying to keep the proxy redirection / traffic injection
   systems as modular and separated from Cilium as possible, the system
   that manages netkit setup and core eBPF programming.

It would be handy if instead we could redirect traffic directly from
one netkit peer device to another. This patch proposes an extension
to bpf_redirect_peer to allow us to do just that.

With this patch, the BPF_F_EGRESS flag tells bpf_redirect_peer to emit
the skb in the egress direction of the target interface's peer device
While the main use case is netkit, I suppose you could also use this
mode with veth as well if, e.g., there were some eBPF programs attached
to that side of the veth pair that needed to intercept traffic.

 +---------------------------------------------------------------------+
 | +-------------------------+         6. bpf_redirect_neigh(eth0)     |
 | | pod (10.244.0.10)       |           ------------------------      |
 | |                         |          |                        |     |
 | |              +--------+ |          |      +---------+       |     |
 | | 1. packet -->|        | |          |      |         |       |     |
 | |    leaves ^  | netkit |<===========|======| netkit  |       |     |
 | |           |  | peer   |=======(eBPF)=====>| primary |       |     |
 | |           |  |        | |          |      |         |       |     |
 | |           |  +--------+ |          |      +---------+       |     |
 | |           |             |          | 2. bpf_redirect        v     |
 | +-----------|-------------+          |___________________   +-------|
 |             |                                            |  | eth0  |
 |             | 5. bpf_redirect_peer(BPF_F_EGRESS)         |  +-------|
 |             |________________________                    |          |
 | +-------------------------+          |                   |          |
 | | proxy (10.244.0.11)     |          |                   |          |
 | | IP_TRANSPARENT          |          |                   |          |
 | |              +--------+ |          |      +---------+  |          |
 | | 3. packet <--|        | |          |      |         |<--          |
 | |    enters    | netkit |<===========|======| netkit  |             |
 | |    [proxy]   | peer   |=======(eBPF)=====>| primary |             |
 | | 4. packet -->|        | |                 |         |             |
 | |    leaves    +--------+ |                 +---------+             |
 | |    sip=10.244.0.10      |                                         |
 | +-------------------------+                                         |
 +---------------------------------------------------------------------+

Using the proxy use case as an example, in step 5 we would redirect
traffic leaving the proxy towards the pod's peer device using
bpf_redirect_peer(BPF_F_EGRESS).

As a bonus, since the skb doesn't have to go through the backlog queue
it can take full advantage of netkit's performance benefits. I set up a
test where outgoing iperf3 traffic is injected into the datapath of
another pod using either bpf_redirect_peer(BPF_F_EGRESS) or
bpf_redirect(BPF_F_INGRESS). I used Cilium's eBPF host routing mode
which skips the host stack and uses BPF redirect helpers to do all the
routing.

  (net.ipv4.tcp_congestion_control=cubic,mtu=1500,100GiB link,Cilium
   eBPF host routing mode)

BASELINE [bpf_redirect(BPF_F_INGRESS)]
  1. [iperf pod] ==bpf_redirect([pod b], BPF_F_INGRESS)==> [pod b]
  2. [pod b]     ==bpf_redirect_neigh([eth0])==>           eth0
  3. eth0        ==over network==>                         [host b]

  [ ID] Interval           Transfer     Bitrate         Retr
  [  5]   0.00-60.00  sec   231 GBytes  33.0 Gbits/sec  12060     sender
  [  5]   0.00-60.00  sec   230 GBytes  33.0 Gbits/sec            receiver

TEST [bpf_redirect_peer(BPF_F_EGRESS)]
  1. [iperf pod] ==bpf_redirect_peer([pod b], BPF_F_EGRESS)==> [pod b]
  2. [pod b]     ==bpf_redirect_neigh([eth0])==>               eth0
  3. eth0        ==over network==>                             [host b]

  [ ID] Interval           Transfer     Bitrate         Retr
  [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec    0       sender
  [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec            receiver

In this test, using bpf_redirect_peer(BPF_F_EGRESS) for the hop from
[iperf pod] to [pod b] led to ~18% more throughput compared to
bpf_redirect(BPF_F_INGRESS).

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 include/uapi/linux/bpf.h       | 19 +++++++++++--------
 net/core/filter.c              | 12 +++++++-----
 tools/include/uapi/linux/bpf.h | 19 +++++++++++--------
 3 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 89b36de5fdbb..c91b5a4bda03 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5079,17 +5079,19 @@ union bpf_attr {
  * 	Description
  * 		Redirect the packet to another net device of index *ifindex*.
  * 		This helper is somewhat similar to **bpf_redirect**\ (), except
- * 		that the redirection happens to the *ifindex*' peer device and
- * 		the netns switch takes place from ingress to ingress without
- * 		going through the CPU's backlog queue.
+ * 		that the redirection happens to the *ifindex*' peer device. If
+ * 		*flags* is 0, the netns switch takes place from ingress to
+ * 		ingress without going through the CPU's backlog queue. If the
+ * 		**BPF_F_EGRESS** flag is provided then redirection happens in
+ * 		the egress direction of the peer device.
  *
  * 		*skb*\ **->mark** and *skb*\ **->tstamp** are not cleared during
  * 		the netns switch.
  *
- * 		The *flags* argument is reserved and must be 0. The helper is
- * 		currently only supported for tc BPF program types at the
- * 		ingress hook and for veth and netkit target device types. The
- * 		peer device must reside in a different network namespace.
+ * 		If the *flags* argument is 0, the helper is currently only
+ * 		supported for tc BPF program types at the ingress hook and for
+ * 		veth and netkit target device types. The peer device must reside
+ * 		in a different network namespace.
  * 	Return
  * 		The helper returns **TC_ACT_REDIRECT** on success or
  * 		**TC_ACT_SHOT** on error.
@@ -6336,9 +6338,10 @@ enum {
 /* Flags for bpf_redirect and bpf_redirect_map helpers */
 enum {
 	BPF_F_INGRESS		= (1ULL << 0), /* used for skb path */
+	BPF_F_EGRESS		= (1ULL << 1), /* used for skb path */
 	BPF_F_BROADCAST		= (1ULL << 3), /* used for XDP path */
 	BPF_F_EXCLUDE_INGRESS	= (1ULL << 4), /* used for XDP path */
-#define BPF_F_REDIRECT_FLAGS (BPF_F_INGRESS | BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS)
+#define BPF_F_REDIRECT_FLAGS (BPF_F_INGRESS | BPF_F_EGRESS | BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS)
 };
 
 #define __bpf_md_ptr(type, name)	\
diff --git a/net/core/filter.c b/net/core/filter.c
index 2e96b4b847ce..ce2ef5d8ae44 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2529,16 +2529,18 @@ int skb_do_redirect(struct sk_buff *skb)
 	if (unlikely(!dev))
 		goto out_drop;
 	if (flags & BPF_F_PEER) {
-		if (unlikely(!skb_at_tc_ingress(skb)))
-			goto out_drop;
 		dev = skb_get_peer_dev(dev);
 		if (unlikely(!dev ||
 			     !(dev->flags & IFF_UP) ||
 			     net_eq(net, dev_net(dev))))
 			goto out_drop;
+		skb_scrub_packet(skb, false);
+		if (flags & BPF_F_EGRESS)
+			return __bpf_redirect(skb, dev, 0);
+		if (unlikely(!skb_at_tc_ingress(skb)))
+			goto out_drop;
 		skb->dev = dev;
 		dev_sw_netstats_rx_add(dev, skb->len);
-		skb_scrub_packet(skb, false);
 		return -EAGAIN;
 	}
 	return flags & BPF_F_NEIGH ?
@@ -2575,10 +2577,10 @@ BPF_CALL_2(bpf_redirect_peer, u32, ifindex, u64, flags)
 {
 	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 
-	if (unlikely(flags))
+	if (unlikely(flags & ~BPF_F_EGRESS))
 		return TC_ACT_SHOT;
 
-	ri->flags = BPF_F_PEER;
+	ri->flags = BPF_F_PEER | flags;
 	ri->tgt_index = ifindex;
 
 	return TC_ACT_REDIRECT;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 89b36de5fdbb..c91b5a4bda03 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5079,17 +5079,19 @@ union bpf_attr {
  * 	Description
  * 		Redirect the packet to another net device of index *ifindex*.
  * 		This helper is somewhat similar to **bpf_redirect**\ (), except
- * 		that the redirection happens to the *ifindex*' peer device and
- * 		the netns switch takes place from ingress to ingress without
- * 		going through the CPU's backlog queue.
+ * 		that the redirection happens to the *ifindex*' peer device. If
+ * 		*flags* is 0, the netns switch takes place from ingress to
+ * 		ingress without going through the CPU's backlog queue. If the
+ * 		**BPF_F_EGRESS** flag is provided then redirection happens in
+ * 		the egress direction of the peer device.
  *
  * 		*skb*\ **->mark** and *skb*\ **->tstamp** are not cleared during
  * 		the netns switch.
  *
- * 		The *flags* argument is reserved and must be 0. The helper is
- * 		currently only supported for tc BPF program types at the
- * 		ingress hook and for veth and netkit target device types. The
- * 		peer device must reside in a different network namespace.
+ * 		If the *flags* argument is 0, the helper is currently only
+ * 		supported for tc BPF program types at the ingress hook and for
+ * 		veth and netkit target device types. The peer device must reside
+ * 		in a different network namespace.
  * 	Return
  * 		The helper returns **TC_ACT_REDIRECT** on success or
  * 		**TC_ACT_SHOT** on error.
@@ -6336,9 +6338,10 @@ enum {
 /* Flags for bpf_redirect and bpf_redirect_map helpers */
 enum {
 	BPF_F_INGRESS		= (1ULL << 0), /* used for skb path */
+	BPF_F_EGRESS		= (1ULL << 1), /* used for skb path */
 	BPF_F_BROADCAST		= (1ULL << 3), /* used for XDP path */
 	BPF_F_EXCLUDE_INGRESS	= (1ULL << 4), /* used for XDP path */
-#define BPF_F_REDIRECT_FLAGS (BPF_F_INGRESS | BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS)
+#define BPF_F_REDIRECT_FLAGS (BPF_F_INGRESS | BPF_F_EGRESS | BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS)
 };
 
 #define __bpf_md_ptr(type, name)	\
-- 
2.43.0

