Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306017;
	b=JZa/Vp2yA1wlRzsRDyfp3di458jKRgnAOoDqq4O0K2CrcdhvzjALKhc4Eyspcfph6Id/
	 scB9KMGvZsNZuUbQul9t7Zgi0AuMDJYtf1TwBMlSxFOnCDmFBY91FLhGmWarzPMDilkDL
	 zTOByQZIRUlqRhTSY36/gx/stj9L6OMX88lSUyJ06wiSRWasGwStE4neXV2ghkTmjmASa
	 Hug6+mPiFNPcCwCMEIad43a278kWfc1jw3mnC6iIKK9SvWGkKVwF5f6qTPHK9MT3yVj+K
	 ceJ7x9RDjQ9vSEqVdmzmnoxI+UIcaEUQYEOhbmRkTTuJabZBrKwVXZ3ksd9xkDi1GSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306017;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:DKIM-Signature;
	bh=GaswSCLV3q+65kkcnbt/YINMYQtTyx4xy8mVtCeCf3U=;
	b=UlMiSoOmKjJBcVrbyVjp8nW685iwc30IiU4nGK4mhOuSCJNPA3Re8IZr6ZkLM9TskY+s
	 CQauxwN0Y5SYwnRCNFJKNds8WKESeKwut8r1sezv6Lxp4uK68Lq9KRJkk5sHfmLltEEh3
	 bRDCvgWqR73GgelVJ4IanyVae9TeZvjRmUHgSPmOSb7pIHNJZ+dsnKe4UHrlXUKsiBcnv
	 ojtlXwSZOJYFs3QGMRNX8Uk52oPD7NIKTYxnPnRTYhGQN+IdoAv61Vavym3JXiTxePEfs
	 k9aORlkz2yB4EeqFe8DOukO67Xid4pebXsc1D8WnFGKNq621NVPquME6Vqy/RSejL9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=D6fmTOMA;
	arc=none smtp.remote-ip=217.74.67.49
Received: from smtpo49.interia.pl (smtpo49.interia.pl [217.74.67.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2693660A2601
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 10:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2693660A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=D6fmTOMA
Received: from localhost (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Tue, 10 Nov 2026 11:20:12 +0100 (CET)
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
Subject: [PATCH RFC net-next v2 4/4] veth: use generic skb XDP handling
Date: Tue, 10 Nov 2026 11:19:41 +0100
Message-ID: <20261110101941.1059662-5-sst@poczta.fm>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1794306014; bh=GaswSCLV3q+65kkcnbt/YINMYQtTyx4xy8mVtCeCf3U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=D6fmTOMAcTAeJkEaC1PUovBaDkOypIR37EMS46BVIBM67AXibpfw1WS4w638qKBvD
	 6IgGCJz2I5xZiUB3EQhEsVexvAeKwaZ/TPEB9CktoUEZ2eRXOdJzed1/5QXZppWpuE
	 wNyT0l25rf9YDRGrdPsk+rymYfQtB/6l6PcX4leo=

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

veth currently runs XDP for skb-backed packets by constructing an
xdp_buff and then, for XDP_TX and XDP_REDIRECT, converting that
skb-backed xdp_buff into an xdp_frame. The backing memory is still
skb-owned, so veth has to pin the skb data and frags manually before
consuming the skb.

Use the generic skb XDP helper for skb-backed packets instead. This
keeps skb-backed packets on the skb generic XDP path: XDP_REDIRECT uses
xdp_do_generic_redirect() and XDP_TX uses generic_xdp_tx(). Packets that
already arrive as xdp_frames keep using the existing veth xdp_frame path.

veth still provides its own page_pool and xdp_rxq_info through struct
xdp_generic_ctx. It also keeps using struct veth_xdp_buff storage so
metadata kfuncs that need the skb continue to work after a possible skb
COW.

This changes what XDP_TX and XDP_REDIRECT do for skb-backed packets in
veth (packets the peer sent with ndo_start_xmit()):

  target              before                     after
  XDP_TX              xdp_frame, bulked to peer  skb via generic_xdp_tx()
  NIC via devmap      ndo_xdp_xmit(), bulked     netdev_start_xmit()
  cpumap              xdp_frame on remote ring   skb on remote backlog
  AF_XDP socket       copy, flush per poll       copy, flush per packet
  veth peer (devmap)  xdp_frame in peer's ring   skb in peer's ring

Packets that arrive as xdp_frames are not affected.

A failed skb XDP_TX is counted in the device's tx_dropped by
generic_xdp_tx(), so veth does not add it to xdp_tx_err as well.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
[sst: describe the redirect semantics change (Björn), document the
 XDP_TX error accounting and drop the unused xdp_tx_err update (Sashiko);
 set skb->mac_len before generic XDP, needed by the generic cpumap redirect]
Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/net/veth.c | 191 ++++++++++-----------------------------------
 1 file changed, 42 insertions(+), 149 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index a61842b2585b..049c95dbb8be 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -49,6 +49,10 @@ struct veth_stats {
 	u64	xdp_drops;
 	u64	xdp_tx;
 	u64	xdp_tx_err;
+	/* skb-backed XDP_TX is handled immediately by generic_xdp_tx().
+	 * xdp_frame XDP_TX is accounted from veth_xdp_flush_bq().
+	 */
+	u64	xdp_skb_tx;
 	u64	peer_tq_xdp_xmit;
 	u64	peer_tq_xdp_xmit_err;
 };
@@ -63,7 +67,6 @@ struct veth_rq {
 	struct napi_struct __rcu *napi; /* points to xdp_napi when the latter is initialized */
 	struct net_device	*dev;
 	struct bpf_prog __rcu	*xdp_prog;
-	struct xdp_mem_info	xdp_mem;
 	struct veth_rq_stats	stats;
 	bool			rx_notify_masked;
 	struct ptr_ring		xdp_ring;
@@ -654,10 +657,15 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
 	if (likely(xdp_prog)) {
 		struct veth_xdp_buff vxbuf;
 		struct xdp_buff *xdp = &vxbuf.xdp;
+		struct xdp_rxq_info rxq;
 		u32 act;
 
 		xdp_convert_frame_to_buff(frame, xdp);
-		xdp->rxq = &rq->xdp_rxq;
+
+		rxq = rq->xdp_rxq;
+		rxq.mem.type = frame->mem_type;
+		xdp->rxq = &rxq;
+
 		vxbuf.skb = NULL;
 
 		act = bpf_prog_run_xdp(xdp_prog, xdp);
@@ -669,19 +677,16 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
 			break;
 		case XDP_TX:
 			orig_frame = *frame;
-			xdp->rxq->mem.type = frame->mem_type;
 			if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
 				trace_xdp_exception(rq->dev, xdp_prog, act);
 				frame = &orig_frame;
 				stats->rx_drops++;
 				goto err_xdp;
 			}
-			stats->xdp_tx++;
 			rcu_read_unlock();
 			goto xdp_xmit;
 		case XDP_REDIRECT:
 			orig_frame = *frame;
-			xdp->rxq->mem.type = frame->mem_type;
 			if (xdp_do_redirect(rq->dev, xdp, xdp_prog)) {
 				frame = &orig_frame;
 				stats->rx_drops++;
@@ -741,71 +746,26 @@ static void veth_xdp_rcv_bulk_skb(struct veth_rq *rq, void **frames,
 	}
 }
 
-static void veth_xdp_get(struct xdp_buff *xdp)
-{
-	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
-	int i;
-
-	get_page(virt_to_page(xdp->data));
-	if (likely(!xdp_buff_has_frags(xdp)))
-		return;
-
-	for (i = 0; i < sinfo->nr_frags; i++)
-		netmem_inc_ref(skb_frag_netmem(&sinfo->frags[i]));
-}
-
-static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
-					struct xdp_buff *xdp,
-					struct sk_buff **pskb)
-{
-	struct sk_buff *skb = *pskb;
-	u32 frame_sz;
-
-	if (skb_shared(skb) || skb_head_is_locked(skb) ||
-	    skb_is_nonlinear(skb) ||
-	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
-		if (skb_pp_cow_data(rq->page_pool, pskb, XDP_PACKET_HEADROOM))
-			goto drop;
-
-		skb = *pskb;
-	}
-
-	/* SKB "head" area always have tailroom for skb_shared_info */
-	frame_sz = skb_end_pointer(skb) - skb->head;
-	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-	xdp_init_buff(xdp, frame_sz, &rq->xdp_rxq);
-	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
-			 skb_headlen(skb), true);
-
-	if (skb_shinfo(skb)->nr_frags) {
-		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
-		xdp_buff_set_frags_flag(xdp);
-	} else {
-		xdp_buff_clear_frags_flag(xdp);
-	}
-	*pskb = skb;
-
-	return 0;
-drop:
-	consume_skb(skb);
-	*pskb = NULL;
-
-	return -ENOMEM;
-}
-
 static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 					struct sk_buff *skb,
-					struct veth_xdp_tx_bq *bq,
 					struct veth_stats *stats)
 {
-	void *orig_data, *orig_data_end;
 	struct bpf_prog *xdp_prog;
 	struct veth_xdp_buff vxbuf;
-	struct xdp_buff *xdp = &vxbuf.xdp;
-	u32 act, metalen;
-	int off;
+	struct xdp_generic_ctx ctx = {
+		.page_pool = rq->page_pool,
+		.xdp_rxq = &rq->xdp_rxq,
+		.xdp_skb = &vxbuf.skb,
+		.xdp = &vxbuf.xdp,
+	};
+	int ret;
 
 	skb_prepare_for_gro(skb);
+	/* Generic XDP expects skb->mac_len to be set, as
+	 * __netif_receive_skb_core() does before running it: the generic
+	 * cpumap redirect pulls it before queueing the skb.
+	 */
+	skb->mac_len = skb->data - skb_mac_header(skb);
 
 	rcu_read_lock();
 	xdp_prog = rcu_dereference(rq->xdp_prog);
@@ -814,100 +774,36 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 		goto out;
 	}
 
-	__skb_push(skb, skb->data - skb_mac_header(skb));
-	if (veth_convert_skb_to_xdp_buff(rq, xdp, &skb))
-		goto drop;
-	vxbuf.skb = skb;
-
-	orig_data = xdp->data;
-	orig_data_end = xdp->data_end;
-
-	act = bpf_prog_run_xdp(xdp_prog, xdp);
-
-	switch (act) {
+	ret = __do_xdp_generic(xdp_prog, &skb, &ctx);
+	switch (ctx.act) {
 	case XDP_PASS:
 		break;
 	case XDP_TX:
-		veth_xdp_get(xdp);
-		consume_skb(skb);
-		xdp->rxq->mem = rq->xdp_mem;
-		if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
-			trace_xdp_exception(rq->dev, xdp_prog, act);
-			stats->rx_drops++;
-			goto err_xdp;
-		}
-		stats->xdp_tx++;
-		rcu_read_unlock();
-		goto xdp_xmit;
+		/* A failed transmit is counted in the device's tx_dropped
+		 * by generic_xdp_tx(), so it is not added to xdp_tx_err.
+		 */
+		if (!ctx.err)
+			stats->xdp_skb_tx++;
+		break;
 	case XDP_REDIRECT:
-		veth_xdp_get(xdp);
-		consume_skb(skb);
-		xdp->rxq->mem = rq->xdp_mem;
-		if (xdp_do_redirect(rq->dev, xdp, xdp_prog)) {
+		if (ctx.err)
 			stats->rx_drops++;
-			goto err_xdp;
-		}
-		stats->xdp_redirect++;
-		rcu_read_unlock();
-		goto xdp_xmit;
+		else
+			stats->xdp_redirect++;
+		break;
 	default:
-		bpf_warn_invalid_xdp_action(rq->dev, xdp_prog, act);
-		fallthrough;
 	case XDP_ABORTED:
-		trace_xdp_exception(rq->dev, xdp_prog, act);
-		fallthrough;
 	case XDP_DROP:
 		stats->xdp_drops++;
-		goto xdp_drop;
+		break;
 	}
 	rcu_read_unlock();
 
-	/* check if bpf_xdp_adjust_head was used */
-	off = orig_data - xdp->data;
-	if (off > 0)
-		__skb_push(skb, off);
-	else if (off < 0)
-		__skb_pull(skb, -off);
-
-	skb_reset_mac_header(skb);
-
-	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
-	 * (e.g. bpf_xdp_adjust_tail). Remove the old fragment contribution
-	 * from skb->len before updating data_len, then add the new one back.
-	 */
-	skb->len -= skb->data_len;
-	if (xdp_buff_has_frags(xdp)) {
-		skb->data_len = skb_shinfo(skb)->xdp_frags_size;
-		skb->len += skb->data_len;
-	} else {
-		skb->data_len = 0;
-	}
-
-	/* Synchronize the skb tail with XDP's updated linear area. */
-	off = xdp->data_end - orig_data_end;
-	if (off != 0) {
-		skb_set_tail_pointer(skb, xdp->data_end - xdp->data);
-		skb->len += off; /* positive on grow, negative on shrink */
-	}
-
-	skb->protocol = eth_type_trans(skb, rq->dev);
-
-	metalen = xdp->data - xdp->data_meta;
-	if (metalen)
-		skb_metadata_set(skb, metalen);
+	if (ret == XDP_PASS)
+		return skb;
+	return NULL;
 out:
 	return skb;
-drop:
-	stats->rx_drops++;
-xdp_drop:
-	rcu_read_unlock();
-	kfree_skb(skb);
-	return NULL;
-err_xdp:
-	rcu_read_unlock();
-	xdp_return_buff(xdp);
-xdp_xmit:
-	return NULL;
 }
 
 static int veth_xdp_rcv(struct veth_rq *rq, int budget,
@@ -943,7 +839,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 			struct sk_buff *skb = ptr;
 
 			stats->xdp_bytes += skb->len;
-			skb = veth_xdp_rcv_skb(rq, skb, bq, stats);
+			skb = veth_xdp_rcv_skb(rq, skb, stats);
 			if (skb) {
 				if (skb_shared(skb) || skb_unclone(skb, GFP_ATOMIC))
 					netif_receive_skb(skb);
@@ -959,6 +855,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 
 	u64_stats_update_begin(&rq->stats.syncp);
 	rq->stats.vs.xdp_redirect += stats->xdp_redirect;
+	rq->stats.vs.xdp_tx += stats->xdp_skb_tx;
 	rq->stats.vs.xdp_bytes += stats->xdp_bytes;
 	rq->stats.vs.xdp_drops += stats->xdp_drops;
 	rq->stats.vs.rx_drops += stats->rx_drops;
@@ -992,7 +889,7 @@ static int veth_poll(struct napi_struct *napi, int budget)
 
 	if (stats.xdp_redirect > 0)
 		xdp_do_flush();
-	if (stats.xdp_tx > 0)
+	if (bq.count > 0)
 		veth_xdp_flush(rq, &bq);
 	xdp_clear_return_frame_no_direct();
 
@@ -1138,13 +1035,10 @@ static int veth_enable_xdp_range(struct net_device *dev, int start, int end,
 			goto err_rxq_reg;
 
 		err = xdp_rxq_info_reg_mem_model(&rq->xdp_rxq,
-						 MEM_TYPE_PAGE_SHARED,
+						 MEM_TYPE_MIXED,
 						 NULL);
 		if (err < 0)
 			goto err_reg_mem;
-
-		/* Save original mem info as it can be overwritten */
-		rq->xdp_mem = rq->xdp_rxq.mem;
 	}
 	return 0;
 
@@ -1173,7 +1067,6 @@ static void veth_disable_xdp_range(struct net_device *dev, int start, int end,
 	for (i = start; i < end; i++) {
 		struct veth_rq *rq = &priv->rq[i];
 
-		rq->xdp_rxq.mem = rq->xdp_mem;
 		xdp_rxq_info_unreg(&rq->xdp_rxq);
 
 		if (delete_napi)
-- 
2.56.0

