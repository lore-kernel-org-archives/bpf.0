Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793794434;
	b=MaBr77NYdDY+NAycb2MZAs2ttCblOsx15z5vJTyb0xzIjFng0LbpZ2ZGCwQ5URPjRMzk
	 fG7JEewwAN0WOVA1t99/Is4XAp25h+fGQ0Y8evkDkFH2e6y+Bt9icwlieV0am2qPmJDDM
	 lVx8WpIg5wE1fU+a6mRRBSbWCxa6KGjc9Us/I/wPKHPI2hGs0uFbd1prPOiUEaUVK479L
	 gPr+H8R/m/hpDf8+P9c13ZJJ1li1Pyuf09sJ51zrr4AHp4/NiWaVez33grc/3vm0mdObf
	 cBVD5XOtpenCE6lW9k/6FEIhYf/C3/A37Un8vvQQ5W9pm0Pf13PTFqCyvxfYrEDo8bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793794434;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 DKIM-Signature;
	bh=wG6ehImCXqJJq6Q4xB8kVIpSfqa+LfpN95tF0siACuQ=;
	b=SGNzFpHqjv9qHPlUD2JeQT1PByjISOO+XM3TRtlKU9/rKHE8mGkgCfrO3iFlvRLSkYt1
	 A/ZYPVReR+NUzUt9nT8EcuYCrYBvArazf05iND+AHHpdTLKFyYCOKd9Q+/5TjT+I9g+8n
	 dnaokOsqX6DT4v+w9UXma3DaqAdO7vouDgl+V7vrmssgad4UnR7tkfeIdyOYNsd3JHcgz
	 9U/GSfeGJd7CZB4r0lK2cvYkVzpwIES3iD0lou9YEOPnqesitvnhv3Ib+0IPZ9dVt2SWB
	 RCM+i0tIPDYoNv5rYH9vZS6xU+IVECSK/FZnjIDKPSb5t3cFV7k92vzA7/wEhRwAxAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=M3LL+mYz;
	arc=none smtp.remote-ip=217.74.67.75
Received: from smtpo75.interia.pl (smtpo75.interia.pl [217.74.67.75])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681F2606A331
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 12:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 681F2606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=M3LL+mYz
Received: from localhost (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Wed,  4 Nov 2026 13:13:49 +0100 (CET)
From: Slawomir Stepien <sst@poczta.fm>
To: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	aleksander.lobakin@intel.com,
	ilias.apalodimas@linaro.org,
	toke@redhat.com,
	lorenzo@kernel.org,
	ihor.solodrai@linux.dev,
	tavip@google.com,
	maciej.fijalkowski@intel.com,
	sst@poczta.fm,
	syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
Subject: [PATCH v6 bpf 1/3] xdp: introduce xdp_convert_skb_to_buff()
Date: Wed,  4 Nov 2026 13:13:14 +0100
Message-ID: <20261104121316.1155680-2-sst@poczta.fm>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104121316.1155680-1-sst@poczta.fm>
References: <20261104121316.1155680-1-sst@poczta.fm>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1793794431; bh=wG6ehImCXqJJq6Q4xB8kVIpSfqa+LfpN95tF0siACuQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=M3LL+mYzWV6df9ojSc0RjGuYyvY9YaqEAzGmDTUEgiyScc74d+3e+CZASK3ByPV1q
	 yoXwOWHTuSpCoIM8o80xF3ON0g2oJzp0G9nKREXkijQRD/oDAp67z8Muj30s8AlD7e
	 ri01kbuGSo/jXzXcXx86gRU1jAQGmNaDp3m4iCaM=

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Currently, generic XDP hook uses xdp_rxq_info from netstack Rx queues
which do not have its XDP memory model registered. There is a case when
XDP program calls bpf_xdp_adjust_tail() BPF helper, which in turn
releases underlying memory. This happens when it consumes enough amount
of bytes and when XDP buffer has fragments. For this action the memory
model knowledge passed to XDP program is crucial so that core can call
suitable function for freeing/recycling the page.

For netstack queues it defaults to MEM_TYPE_PAGE_SHARED (0) due to lack
of mem model registration. The problem we're fixing here is when kernel
copied the skb to new buffer backed by system's page_pool and XDP buffer
is built around it. Then when bpf_xdp_adjust_tail() calls
__xdp_return(), it acts incorrectly due to mem type not being set to
MEM_TYPE_PAGE_POOL and causes a page leak.

Pull out the existing code from bpf_prog_run_generic_xdp() that
init/prepares xdp_buff onto new helper xdp_convert_skb_to_buff() and
embed there rxq's mem_type initialization that is assigned to xdp_buff.
Make it agnostic to current skb->data position.

The mem type is only consulted when the program releases fragments; the
head can not be freed from under the skb. All current users pass skbs
with fragments through skb_pp_cow_data() first, and when the CoW fails
the skb is linearized, so fragments seen here are always page_pool
backed. Hence set MEM_TYPE_PAGE_POOL unconditionally and warn under
CONFIG_DEBUG_NET if a non-linear skb shows up without pp_recycle.

This problem was triggered by syzbot as well as AF_XDP test suite which
is about to be integrated to BPF CI.

Reported-by: syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6756c37b.050a0220.a30f1.019a.GAE@google.com/
Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Co-developed-by: Octavian Purdila <tavip@google.com>
Signed-off-by: Octavian Purdila <tavip@google.com> # whole analysis, testing, initiating a fix
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # commit msg and proposed more robust fix
[sst: rebased onto bpf/master; set MEM_TYPE_PAGE_POOL unconditionally, add
 DEBUG_NET_WARN_ON_ONCE() and kdoc as agreed in v4/v5 review; dropped
 Tested-by/Reviewed-by as the code changed]
Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 include/net/xdp.h | 36 ++++++++++++++++++++++++++++++++++++
 net/core/dev.c    | 25 ++++---------------------
 2 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 07231adfb5f8..28bd78dbef20 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -389,6 +389,42 @@ struct sk_buff *xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					 struct net_device *dev);
 struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf);
 
+/**
+ * xdp_convert_skb_to_buff - build an xdp_buff on top of an skb
+ * @skb: skb to describe, packet data is taken from its MAC header onwards
+ * @xdp: xdp_buff to initialize
+ * @xdp_rxq: Rx queue info to attach to @xdp
+ *
+ * The memory type set on @xdp_rxq is only used to release fragments that
+ * the XDP program consumes; the head can not be freed from under the skb.
+ * A non-linear @skb is expected to have gone through skb_pp_cow_data(), so
+ * all of its fragments are page_pool backed.
+ */
+static inline
+void xdp_convert_skb_to_buff(struct sk_buff *skb, struct xdp_buff *xdp,
+			     struct xdp_rxq_info *xdp_rxq)
+{
+	u32 frame_sz, pkt_len;
+
+	/* SKB "head" area always have tailroom for skb_shared_info */
+	frame_sz = skb_end_pointer(skb) - skb->head;
+	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	pkt_len = skb_tail_pointer(skb) - skb_mac_header(skb);
+
+	xdp_init_buff(xdp, frame_sz, xdp_rxq);
+	xdp_prepare_buff(xdp, skb->head, skb->mac_header, pkt_len, true);
+
+	if (skb_is_nonlinear(skb)) {
+		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
+		xdp_buff_set_frags_flag(xdp);
+	} else {
+		xdp_buff_clear_frags_flag(xdp);
+	}
+
+	DEBUG_NET_WARN_ON_ONCE(skb_is_nonlinear(skb) && !skb->pp_recycle);
+	xdp->rxq->mem.type = MEM_TYPE_PAGE_POOL;
+}
+
 static inline
 void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
 			       struct xdp_buff *xdp)
diff --git a/net/core/dev.c b/net/core/dev.c
index 3ac700d37e59..4eeeb0182a6a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5667,35 +5667,18 @@ static struct netdev_rx_queue *netif_get_rxqueue(struct sk_buff *skb)
 u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 			     const struct bpf_prog *xdp_prog)
 {
-	void *orig_data, *orig_data_end, *hard_start;
+	void *orig_data, *orig_data_end;
 	struct netdev_rx_queue *rxqueue;
 	bool orig_bcast, orig_host;
-	u32 mac_len, frame_sz;
+	u32 metalen, act, mac_len;
 	__be16 orig_eth_type;
 	struct ethhdr *eth;
-	u32 metalen, act;
 	int off;
 
-	/* The XDP program wants to see the packet starting at the MAC
-	 * header.
-	 */
+	rxqueue = netif_get_rxqueue(skb);
 	mac_len = skb->data - skb_mac_header(skb);
-	hard_start = skb->data - skb_headroom(skb);
-
-	/* SKB "head" area always have tailroom for skb_shared_info */
-	frame_sz = (void *)skb_end_pointer(skb) - hard_start;
-	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	rxqueue = netif_get_rxqueue(skb);
-	xdp_init_buff(xdp, frame_sz, &rxqueue->xdp_rxq);
-	xdp_prepare_buff(xdp, hard_start, skb_headroom(skb) - mac_len,
-			 skb_headlen(skb) + mac_len, true);
-	if (skb_is_nonlinear(skb)) {
-		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
-		xdp_buff_set_frags_flag(xdp);
-	} else {
-		xdp_buff_clear_frags_flag(xdp);
-	}
+	xdp_convert_skb_to_buff(skb, xdp, &rxqueue->xdp_rxq);
 
 	orig_data_end = xdp->data_end;
 	orig_data = xdp->data;
-- 
2.56.0

