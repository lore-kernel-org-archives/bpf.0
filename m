Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306014;
	b=bjw4kYijHi64rpBPjoEtnfoppznaDbtaATOLsrao7tL817rqrDAsdVTVmR5eFSIuvJ7b
	 ekehNo/7QUMvQ/BFmgwRxtwTmc7WU0ES19nFSXVL7mTcEw6ALfaanpGZepxLOX38SGYHT
	 tckLhV/uKR24vul/MSawAQZdOdkAB2/MlvkJ/m4HwqL52/4kYQjMMyopdBKTkOYCw2z0A
	 151SeAzH7zdMK+rhh0meJ2tx0PFHTIfH3cRVpsnqrFmTIb+VLYjqiodp6fKdoKyG4TbvJ
	 pvJ100z+C16+7Cek2s7qjUYHXsrizRnkgbwOspIcGNcIB/0iaErAcqf+guFz8zkPFJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306014;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 DKIM-Signature;
	bh=aJR2Iqh0SywcSqzamY28JKadQIexO83nq3mwxFgjKto=;
	b=lVh05QJgaFlogwbOBUELnJKzb8rfLrAZyYR9iSepomeuJ+vKcd4b1y3kOHzmy5T72Hby
	 sfAMQdleYeiASICCqW+yPsE79ckNLsAxCjP1nqp0EOeJ+wxmhA9w2lHehwkxi221zcKah
	 ZyKVLI9PMaDHwWTQdlUk9ldhlU+BD2i/cStxCMPuYnbiWG/o/yPiMtO5f4JAPGMk8cg8M
	 Gvthc0WRaJUTkJto8+nAbgWUpS5vpd959W77U3RUwv38saOayuMGfRT1JOCICvl+3Y7mS
	 Gt01fHWCwaGEP6Zi6YFfTq24RUAiB2GEVx/9Mu824sIxAWKsTmLc5oKr7sxHkt1Jyhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=kaYiwyHl;
	arc=none smtp.remote-ip=217.74.67.75
Received: from smtpo75.interia.pl (smtpo75.interia.pl [217.74.67.75])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3602A60A261A
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 10:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3602A60A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=kaYiwyHl
Received: from localhost (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Tue, 10 Nov 2026 11:20:09 +0100 (CET)
From: Slawomir Stepien <sst@poczta.fm>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Tianyi Gao <tianyi@cloudflare.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	"huangjie . albert" <huangjie.albert@bytedance.com>,
	Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH RFC net-next v2 3/4] xdp: split generic XDP skb handling
Date: Tue, 10 Nov 2026 11:19:40 +0100
Message-ID: <20261110101941.1059662-4-sst@poczta.fm>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110101941.1059662-1-sst@poczta.fm>
References: <20261110101941.1059662-1-sst@poczta.fm>
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
	t=1794306011; bh=aJR2Iqh0SywcSqzamY28JKadQIexO83nq3mwxFgjKto=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=kaYiwyHleqZuCu5UlPuivXippBNuFeyBt2iKMXmbDLW6Y201TOqcZJV5IQxREaQve
	 qZ4JUg7nA66yUFyJOIROfXgmUrn5yZxb4E6uKATMSCwfH5NTsG/zm5d8Ho43Y+loLM
	 xk7ihZVDWpmNADIG0JahHbRaegucB6jB4QZhzwE8=

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

veth has its own page_pool and xdp_rxq_info and also embeds struct
xdp_buff into a larger context used by its metadata kfuncs. At the same
time, the skb-backed veth XDP path currently open-codes most of what
generic XDP already does and then converts skb-backed xdp_buffs into
xdp_frames for XDP_TX and XDP_REDIRECT.

Add a lower-level generic XDP helper, __do_xdp_generic(), that lets
callers provide a small context object. The context carries the
caller-provided xdp_buff storage, optional page_pool and optional
xdp_rxq_info, and returns the actual XDP action and redirect error to
the caller. A NULL page_pool keeps the existing behaviour and uses the
per-CPU system page_pool. A NULL xdp_rxq_info keeps deriving the rxq
from the skb device/rx queue.

This lets drivers such as veth preserve stats and redirect flush
decisions while using the generic skb XDP action handling.

Address also existing bpf_prog_run_generic_xdp() callsites
({cpu,dev}map) so they can keep on using netdev's xdp_rxq_info.

Both users decide with one predicate whether the program has to run on a
page_pool-backed copy of the skb: when it is shared or cloned, when it
has frags (XDP helpers must be able to release them), or when the XDP
headroom is too small. veth also used to require a page-frag head
(skb_head_is_locked()) because it turned the head into an xdp_frame;
skb-backed XDP does not do that, so this check is not needed. Generic
XDP now also copies shared skbs, which it previously ran on in place.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
[sst: merge the generic and veth CoW predicates into one
 skb_needs_xdp_cow() and drop the per-caller callback (Jakub); copy
 into a caller-provided page_pool with skb_pp_cow_data() as veth did,
 also for programs without frags support (fixes xdp_metadata)]
Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 include/linux/netdevice.h | 29 ++++++++++++
 net/core/dev.c            | 99 +++++++++++++++++++++++++++++----------
 2 files changed, 102 insertions(+), 26 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b251c4b5c9ce..56a77c8c67ba 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4355,10 +4355,39 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
 	dev_kfree_skb_any_reason(skb, SKB_CONSUMED);
 }
 
+struct page_pool;
+struct xdp_rxq_info;
+
+/**
+ * struct xdp_generic_ctx - caller context for skb-backed generic XDP
+ * @xdp: caller-provided xdp_buff storage
+ * @page_pool: optional page_pool used when skb COW is needed; the caller
+ *	must keep packets for programs without frags support within one page
+ * @xdp_rxq: optional rxq used to initialise @xdp
+ * @xdp_skb: optional pointer updated with the skb used for the XDP run
+ * @act: actual XDP action returned by the program
+ * @err: transmit or redirect error, valid when @act is XDP_TX or XDP_REDIRECT
+ *
+ * If @page_pool is NULL, the generic path uses the per-CPU system
+ * page_pool. If @xdp_rxq is NULL, the generic path derives the rxq
+ * from the skb device/rx-queue, preserving existing do_xdp_generic()
+ * behaviour.
+ */
+struct xdp_generic_ctx {
+	struct xdp_buff *xdp;
+	struct page_pool *page_pool;
+	struct xdp_rxq_info *xdp_rxq;
+	struct sk_buff **xdp_skb;
+	u32 act;
+	int err;
+};
+
 u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 			     const struct bpf_prog *xdp_prog);
 int generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog,
 		   u32 act);
+int __do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb,
+		     struct xdp_generic_ctx *ctx);
 int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb);
 int netif_rx(struct sk_buff *skb);
 int __netif_rx(struct sk_buff *skb);
diff --git a/net/core/dev.c b/net/core/dev.c
index 12595f6b9eba..81848e638173 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5668,11 +5668,11 @@ static struct netdev_rx_queue *netif_get_rxqueue(struct sk_buff *skb)
 	return rxqueue;
 }
 
-u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
-			     const struct bpf_prog *xdp_prog)
+static u32 __bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
+				      const struct bpf_prog *xdp_prog,
+				      struct xdp_rxq_info *xdp_rxq)
 {
 	void *orig_data, *orig_data_end, *hard_start;
-	struct netdev_rx_queue *rxqueue;
 	bool orig_bcast, orig_host;
 	u32 mac_len, frame_sz;
 	__be16 orig_eth_type;
@@ -5690,8 +5690,13 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	frame_sz = (void *)skb_end_pointer(skb) - hard_start;
 	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	rxqueue = netif_get_rxqueue(skb);
-	xdp_init_buff(xdp, frame_sz, &rxqueue->xdp_rxq);
+	if (!xdp_rxq) {
+		struct netdev_rx_queue *rxqueue;
+
+		rxqueue = netif_get_rxqueue(skb);
+		xdp_rxq = &rxqueue->xdp_rxq;
+	}
+	xdp_init_buff(xdp, frame_sz, xdp_rxq);
 	xdp_prepare_buff(xdp, hard_start, skb_headroom(skb) - mac_len,
 			 skb_headlen(skb) + mac_len, true);
 	if (skb_is_nonlinear(skb)) {
@@ -5774,15 +5779,31 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	return act;
 }
 
+u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
+			     const struct bpf_prog *xdp_prog)
+{
+	return __bpf_prog_run_generic_xdp(skb, xdp, xdp_prog, NULL);
+}
+
 static int
-netif_skb_check_for_xdp(struct sk_buff **pskb, const struct bpf_prog *prog)
+netif_skb_check_for_xdp(struct sk_buff **pskb, const struct bpf_prog *prog,
+			struct page_pool *page_pool)
 {
 	struct sk_buff *skb = *pskb;
 	int err, hroom, troom;
 
-	local_lock_nested_bh(&system_page_pool.bh_lock);
-	err = skb_cow_data_for_xdp(this_cpu_read(system_page_pool.pool), pskb, prog);
-	local_unlock_nested_bh(&system_page_pool.bh_lock);
+	if (page_pool) {
+		/* veth, the caller with its own page_pool, limits the MTU so
+		 * that the copy is linear even for programs without frags
+		 * support, and always copied into its page_pool.
+		 */
+		err = skb_pp_cow_data(page_pool, pskb, XDP_PACKET_HEADROOM);
+	} else {
+		local_lock_nested_bh(&system_page_pool.bh_lock);
+		err = skb_cow_data_for_xdp(this_cpu_read(system_page_pool.pool),
+					   pskb, prog);
+		local_unlock_nested_bh(&system_page_pool.bh_lock);
+	}
 	if (!err)
 		return 0;
 
@@ -5800,9 +5821,22 @@ netif_skb_check_for_xdp(struct sk_buff **pskb, const struct bpf_prog *prog)
 	return skb_linearize(skb);
 }
 
+/* Run the program on a private, page_pool-backed copy when it could otherwise
+ * change data someone else sees (shared or cloned skb), when frags have to be
+ * page_pool-backed so that XDP helpers can release them, or when the XDP
+ * headroom contract is not met. The head does not have to be a page frag:
+ * skb-backed XDP never turns the head into an xdp_frame.
+ */
+static bool skb_needs_xdp_cow(const struct sk_buff *skb)
+{
+	return skb_shared(skb) || skb_cloned(skb) || skb_is_nonlinear(skb) ||
+	       skb_headroom(skb) < XDP_PACKET_HEADROOM;
+}
+
 static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
 				     struct xdp_buff *xdp,
-				     const struct bpf_prog *xdp_prog)
+				     const struct bpf_prog *xdp_prog,
+				     struct xdp_generic_ctx *ctx)
 {
 	struct sk_buff *skb = *pskb;
 	u32 mac_len, act = XDP_DROP;
@@ -5820,15 +5854,17 @@ static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
 	mac_len = skb->data - skb_mac_header(skb);
 	__skb_push(skb, mac_len);
 
-	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
-	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
-		if (netif_skb_check_for_xdp(pskb, xdp_prog))
+	if (skb_needs_xdp_cow(skb)) {
+		if (netif_skb_check_for_xdp(pskb, xdp_prog, ctx->page_pool))
 			goto do_drop;
 	}
 
 	__skb_pull(*pskb, mac_len);
 
-	act = bpf_prog_run_generic_xdp(*pskb, xdp, xdp_prog);
+	if (ctx->xdp_skb)
+		*ctx->xdp_skb = *pskb;
+
+	act = __bpf_prog_run_generic_xdp(*pskb, xdp, xdp_prog, ctx->xdp_rxq);
 	switch (act) {
 	case XDP_REDIRECT:
 	case XDP_TX:
@@ -5910,27 +5946,27 @@ int generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog,
 
 static DEFINE_STATIC_KEY_FALSE(generic_xdp_needed_key);
 
-int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb)
+int __do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb,
+		     struct xdp_generic_ctx *ctx)
 {
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 
-	if (xdp_prog) {
-		struct xdp_buff xdp;
-		u32 act;
-		int err;
+	ctx->act = XDP_PASS;
+	ctx->err = 0;
 
+	if (xdp_prog) {
 		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
-		act = netif_receive_generic_xdp(pskb, &xdp, xdp_prog);
-		if (act != XDP_PASS) {
-			switch (act) {
+		ctx->act = netif_receive_generic_xdp(pskb, ctx->xdp, xdp_prog, ctx);
+		if (ctx->act != XDP_PASS) {
+			switch (ctx->act) {
 			case XDP_REDIRECT:
-				err = xdp_do_generic_redirect((*pskb)->dev, *pskb,
-							      &xdp, xdp_prog);
-				if (err)
+				ctx->err = xdp_do_generic_redirect((*pskb)->dev, *pskb,
+								   ctx->xdp, xdp_prog);
+				if (ctx->err)
 					goto out_redir;
 				break;
 			case XDP_TX:
-				generic_xdp_tx(*pskb, xdp_prog, XDP_TX);
+				ctx->err = generic_xdp_tx(*pskb, xdp_prog, XDP_TX);
 				break;
 			}
 			bpf_net_ctx_clear(bpf_net_ctx);
@@ -5944,6 +5980,17 @@ int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb)
 	kfree_skb_reason(*pskb, SKB_DROP_REASON_XDP);
 	return XDP_DROP;
 }
+EXPORT_SYMBOL_GPL(__do_xdp_generic);
+
+int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb)
+{
+	struct xdp_generic_ctx ctx = {};
+	struct xdp_buff xdp;
+
+	ctx.xdp = &xdp;
+
+	return __do_xdp_generic(xdp_prog, pskb, &ctx);
+}
 EXPORT_SYMBOL_GPL(do_xdp_generic);
 
 static int netif_rx_internal(struct sk_buff *skb)
-- 
2.56.0

