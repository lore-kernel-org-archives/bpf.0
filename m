Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA47314D37
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 00:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790296553; cv=none; b=qP5B6V8VlswUUu6/75RWlaPjU2ypPYFNSiGHN90h/MFiIOa/4g2d+agtQ5JYgreHyK7OdOOD9DwdwNaA7+aNHss2SDfMawgJnuo5N78bYuLC1lx0ijZMl+XK6Y5kOVSjw/51FoQPicjWBz9X+alOAOrvUUd47cJtCWsJEokLniU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790296553; c=relaxed/simple;
	bh=eYWXqK8XMgWc/vWc1QGjafJO0lis6NlMNB7CWP48bGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g9VquIvrhhqDHp0n3nRiV35FvHsV9DdOPfVCU4Z0CiXiH/5+CDoWEDcrlppOrO9IMaH2IDiLEApGQ8N9KxKQu+igSdwDxjfuF0APNsY6ug4ybgCbhgcoHclvkPu3PGiCT4rIwd30q1YGnwQvThoiGN2o1KuFhB3533IdbB/XzMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=syas1HJR; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syas1HJR"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b1ae739df5so102847eaf.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790296550; x=1790901350; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zu9USgrbA7+ji5Tmz6jfo0DudpWjRw2yjJIgDcGUkdQ=;
        b=syas1HJRBoxi1+aGruLkX5lCqvQCg2sYP/q6Rim14eGBrsKY4Ul+oMGOzFg/6dmuP6
         3EqhE/IgwtYYX9BCIITsjpckbe+udyv9nYW2t4sVqHvWMxeSg6frmeC9GCi4wynCEgIi
         tPexzOR/zVOIpH7XVkdnJiFPm0yZzQJEJHBsPp4UJwQzUA07irWx+eN9zymtMPf93ACw
         3xSzk1Q9Kkkr8vZaP0bTPDafZhKRBl97AgjQZ9ptvpa5hj5isyjM8zFTdEi1Lo0BlnCo
         W4oachWDxtLxr3Zl2x+bz6xriFWKMMbStb8p6KNbB819MlefOUYIVFOePqkd7e20IY96
         2fWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790296550; x=1790901350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zu9USgrbA7+ji5Tmz6jfo0DudpWjRw2yjJIgDcGUkdQ=;
        b=gSZHXFGp8tW0aG79sNvK53cZuRv9ebQBNgOTmeNLjo9esAKCY+0O8PcSOI9KZO5OKm
         iJdYKpNsEwEkYJ9ivT5JWmwQYewx+yJGylc/7MYbb/nUdCgF+67JGqgEiBwJj8jrsdbM
         3HEYRsHR9R6Q3iCDnx6rXQIKa2I9IVph3FJ4SBJbrycf2PceS/b14whwOap2Y12nxFQl
         Hlnw6JEKzmqykZvIe0jBAO5F6dxNivVJVdlQJvJIxsptItSjlHjcegFfeqQFC2LcHYrE
         +sqlFJDp8T0UAVfyqr/hN4l8SIqSunG7ILvZeMmA0kIiusN8zvH7ikaq5O+aWlcKPJ7M
         8wbQ==
X-Forwarded-Encrypted: i=1; AKwUvBz7Fudnja/Llorpz66ngQgq7VTBVswre0zHGcenUrA6PtusebCub8u/BXh4o0rZ6Asz0+8=@vger.kernel.org
X-Gm-Message-State: AFuF++matuIBBcm9dqKa73nl32N6Y8rgjgGtOpzJxjDKBaZot7kQ9FJl
	BCw0gpC2AlzabQPznQXyWvB9J69suHn1JhC1iC8XuXtENZXGKt0kq5HE
X-Gm-Gg: AYBFou1ywhshuuYrOhfmkbR9f4koiCJtSaoaYrzLag9DYbe9PkKBzTe359iPxeVqk0m
	ptoM9V80xAHAkNWXZO3y6mVFxSx/NUh31MmLAS+uN+ROW2qcGQUBTDsi9JCJxEAMelM2a0UPVNd
	LzPouS5KTeNQ4QUq18Nb+Y+53Hf19vO+obcYTDnIia1PMn1rZcZm1LIJpcj0fw64WgIepgjQ6FI
	9zTp85jPoW6uE5og50ap/GJEAN/KDuxTg25ukI2TEW56dx966aHpHbb8CwdINmtdpy6nuSbMIQf
	h5h82u54YBco2UAz2KKJYd3PDpzG84zYbrm7b3tN6o8Ji3O/HAm/earLT/OPHBF8ptuZHbfiEne
	fBeWLtbKnqHFCMh9Tdrq0KFeBZSnVfSUPb4zYlAfW2ztg9rrNhPisH03yh/Zg/pj9DpADHU5tbu
	inLhMva6iawTwzLSzUTSiIplypxHS8G9Qeq0NTqo/vMqOcpM6Cp7cWO3HqlFDPsqEaOTv4
X-Received: by 2002:a05:6820:f016:b0:6ca:36f9:178e with SMTP id 006d021491bc7-6d440df0ceemr3518302eaf.28.1790296549906;
        Thu, 24 Sep 2026 17:35:49 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:43::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d5e68338a6sm298361eaf.10.2026.09.24.17.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 17:35:49 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Thu, 24 Sep 2026 17:35:21 -0700
Subject: [PATCH net-next v2 8/8] eth: mpnic: add basic Rx handling
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-linux-mpnic-v2-8-4badc9b58b9e@gmail.com>
References: <20260924-linux-mpnic-v2-0-4badc9b58b9e@gmail.com>
In-Reply-To: <20260924-linux-mpnic-v2-0-4badc9b58b9e@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, 
 Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org
X-Mailer: b4 0.13.0

A frame arrives as a run of completion descriptors: one header
address/length descriptor, one address/length descriptor per payload
page, and a metadata descriptor that closes the frame. The frame is
assembled in an xdp_buff as the descriptors come in and handed to the
stack when the metadata descriptor arrives.

A page holds several frames, so rather than taking a reference per
frame the driver takes a batch of references when it starts handing the
page out and returns whatever is left over once the device moves on to
the next one. Payload fragments that turn out to be contiguous within
one page are merged so that a frame spread over a page does not eat one
skb fragment slot per descriptor.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
v2:
- skip Rx cleaning and BDQ refill when polled with a budget of 0
  (netpoll), page pool must not be used in that context
- keep struct mpnic_pkt_ctxt instead of replacing it with a bare
  xdp_buff, and move add_frag_failed into it
- give each Rx queue only the NAPI budget left over by the previous
  ones instead of the full budget
- sync Rx buffers for the CPU with page_pool_dma_sync_for_cpu() instead
  of dma_sync_single_range_for_cpu()
---
 drivers/net/ethernet/meta/mpnic/mpnic_csr.h  |   7 +
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c | 203 ++++++++++++++++++++++++++-
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h |   7 +
 3 files changed, 212 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
index 6455ec23b6c7..d6ab9df58168 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
@@ -130,6 +130,10 @@ enum {
 #define MPNIC_RCQ_SIZE(i)		(0x294 + 1024 * (i))	/* 0xa50 */
 #define MPNIC_RCQ_SIZE_SIZE			CSR_GENMASK(4, 0)
 
+/* NIC_CORE_RIM */
+#define MPNIC_RIM_INTR_MASK(i)		(0x2c8 + 1024 * (i))	/* 0xb20 */
+#define MPNIC_RIM_INTR_MASK_MASK		CSR_BIT(0)
+
 /* NIC_CORE_TIM_PRV */
 #define MPNIC_TIM_CTL(i)		(0x100100 + 1024 * (i))	/* 0x400400 */
 
@@ -139,6 +143,9 @@ enum {
 #define MPNIC_RDE_CFG_MIN_HEAD_ROOM		CSR_GENMASK(18, 10)
 #define MPNIC_RDE_CFG_MAX_HEADER_BYTES		CSR_GENMASK(45, 32)
 
+/* NIC_CORE_RIM_PRV */
+#define MPNIC_RIM_CTL(i)		(0x100280 + 1024 * (i))	/* 0x400a00 */
+
 /* NIC_CORE_RBP_HP_GLBL */
 #define MPNIC_HPQ_IDLE(i)		(0x420000 + 2 * (i))	/* 0x1080000 */
 #define MPNIC_HPQ_IDLE_CNT		16
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
index 389a9e5476c6..edb07b7f334b 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
@@ -405,6 +405,34 @@ static void mpnic_fill_qt_bdqs(struct mpnic_q_triad *qt)
 	__mpnic_bdq_commit_tail(&qt->sub1, ppq_i);
 }
 
+/* Take one of the references batched on the page at @idx. If the device
+ * has moved on to a new page, first drop the unused references left on
+ * the previous one.
+ */
+static struct page *
+mpnic_page_pool_get(struct mpnic_pg_ctxt *pg_ctxt, struct mpnic_ring *ring,
+		    u32 idx)
+{
+	struct page *page = pg_ctxt->page;
+
+	if (unlikely(pg_ctxt->idx != idx)) {
+		if (pg_ctxt->pagecnt_bias &&
+		    !page_pool_unref_page(page, pg_ctxt->pagecnt_bias))
+			page_pool_put_unrefed_page(page->pp, page, -1, true);
+
+		page = ring->rx_buf[idx];
+		page_pool_fragment_page(page, MPNIC_PAGECNT_BIAS_MAX);
+
+		pg_ctxt->page = page;
+		pg_ctxt->pagecnt_bias = MPNIC_PAGECNT_BIAS_MAX;
+		pg_ctxt->idx = idx;
+	}
+
+	pg_ctxt->pagecnt_bias--;
+
+	return page;
+}
+
 static void mpnic_flush_pg_ctxt(struct mpnic_pg_ctxt *ctxt, bool napi)
 {
 	long pagecnt_bias = ctxt->pagecnt_bias;
@@ -417,6 +445,87 @@ static void mpnic_flush_pg_ctxt(struct mpnic_pg_ctxt *ctxt, bool napi)
 	}
 }
 
+static unsigned int mpnic_hdr_pg_start(unsigned int pg_off)
+{
+	/* The headroom of the first header may be larger than
+	 * MPNIC_RX_HROOM due to alignment. So account for that by just
+	 * making the page offset 0 if we are starting at the first header.
+	 */
+	if (ALIGN(MPNIC_RX_HROOM, 128) > MPNIC_RX_HROOM &&
+	    pg_off == ALIGN(MPNIC_RX_HROOM, 128))
+		return 0;
+
+	return pg_off - MPNIC_RX_HROOM;
+}
+
+static unsigned int mpnic_hdr_pg_end(unsigned int pg_off, unsigned int len)
+{
+	/* Determine the end of the buffer by finding the start of the next
+	 * and then subtracting the headroom from that frame.
+	 */
+	pg_off += len + MPNIC_RX_TROOM + MPNIC_RX_HROOM;
+
+	return ALIGN(pg_off, 128) - MPNIC_RX_HROOM;
+}
+
+static void
+mpnic_pkt_prepare(u64 rcd, struct mpnic_rcq_state *state,
+		  struct mpnic_q_triad *qt)
+{
+	unsigned int pg_off = FIELD_GET(MPNIC_RCD_AL_BUFF_OFF, rcd);
+	unsigned int pg_idx = FIELD_GET(MPNIC_RCD_AL_BUFF_ID, rcd);
+	unsigned int len = FIELD_GET(MPNIC_RCD_AL_BUFF_LEN, rcd);
+	bool fin = FIELD_GET(MPNIC_RCD_AL_PAGE_FIN, rcd);
+	unsigned int frame_sz, pg_start, pg_end;
+	struct xdp_buff *buff = &state->pkt.buff;
+	struct page *page;
+
+	pg_start = mpnic_hdr_pg_start(pg_off);
+
+	page = mpnic_page_pool_get(&state->hdr, &qt->sub0, pg_idx);
+	qt->sub0.head = (pg_idx + 1) & qt->sub0.size_mask;
+
+	/* Short-cut the end calculation if the page is fully consumed */
+	pg_end = fin ? page_size(page) : mpnic_hdr_pg_end(pg_off, len);
+	frame_sz = pg_end - pg_start;
+
+	page_pool_dma_sync_for_cpu(qt->sub0.page_pool, page, pg_start,
+				   frame_sz);
+
+	xdp_init_buff(buff, frame_sz, &qt->xdp_rxq);
+	xdp_prepare_buff(buff, page_address(page) + pg_start,
+			 pg_off - pg_start, len, true);
+	net_prefetch(buff->data);
+
+	state->pkt.add_frag_failed = false;
+}
+
+static void
+mpnic_add_rx_frag(u64 rcd, struct mpnic_rcq_state *state,
+		  struct mpnic_q_triad *qt)
+{
+	unsigned int pg_off = FIELD_GET(MPNIC_RCD_AL_BUFF_OFF, rcd);
+	unsigned int pg_idx = FIELD_GET(MPNIC_RCD_AL_BUFF_ID, rcd);
+	unsigned int len = FIELD_GET(MPNIC_RCD_AL_BUFF_LEN, rcd);
+	bool fin = FIELD_GET(MPNIC_RCD_AL_PAGE_FIN, rcd);
+	struct xdp_buff *buff = &state->pkt.buff;
+	unsigned int truesz;
+	struct page *page;
+
+	page = mpnic_page_pool_get(&state->payld, &qt->sub1, pg_idx);
+	qt->sub1.head = (pg_idx + 1) & qt->sub1.size_mask;
+
+	truesz = (fin ? page_size(page) : ALIGN(pg_off + len, 128)) - pg_off;
+
+	page_pool_dma_sync_for_cpu(qt->sub1.page_pool, page, pg_off, truesz);
+
+	if (!xdp_buff_add_frag(buff, page_to_netmem(page), pg_off, len,
+			       truesz)) {
+		state->payld.pagecnt_bias++;
+		state->pkt.add_frag_failed = true;
+	}
+}
+
 static void mpnic_put_pkt_buff(struct mpnic_pkt_ctxt *ctxt, bool napi)
 {
 	struct xdp_buff *buff = &ctxt->buff;
@@ -442,23 +551,99 @@ static void mpnic_put_pkt_buff(struct mpnic_pkt_ctxt *ctxt, bool napi)
 	page_pool_put_full_page(page->pp, page, napi);
 }
 
+static int mpnic_clean_rcq(struct mpnic_napi_vector *nv,
+			   struct mpnic_q_triad *qt, int budget)
+{
+	struct mpnic_ring *rcq = &qt->cmpl;
+	struct mpnic_rcq_state *state;
+	unsigned int packets = 0;
+	__le64 *raw_rcd, done;
+	u32 head = rcq->head;
+
+	done = (head & (rcq->size_mask + 1)) ? 0 : cpu_to_le64(MPNIC_RCD_DONE);
+	raw_rcd = &rcq->desc[head & rcq->size_mask];
+	state = rcq->state;
+
+	while (packets < budget) {
+		u64 rcd;
+
+		if ((*raw_rcd & cpu_to_le64(MPNIC_RCD_DONE)) != done)
+			break;
+
+		dma_rmb();
+
+		rcd = le64_to_cpu(*raw_rcd);
+
+		switch (FIELD_GET(MPNIC_RCD_TYPE, rcd)) {
+		case MPNIC_RCD_TYPE_HDR_AL:
+			if (FIELD_GET(MPNIC_RCD_HDR_SUBTYPE, rcd) ==
+			    MPNIC_RCD_HDR_SUBTYPE_HDR)
+				mpnic_pkt_prepare(rcd, state, qt);
+			break;
+		case MPNIC_RCD_TYPE_PAY_AL:
+			mpnic_add_rx_frag(rcd, state, qt);
+			break;
+		case MPNIC_RCD_TYPE_META: {
+			struct sk_buff *skb = NULL;
+
+			if (likely(!(rcd &
+				     MPNIC_RCD_META_UNCORRECTABLE_ERR_MASK) &&
+				   !state->pkt.add_frag_failed))
+				skb = xdp_build_skb_from_buff(&state->pkt.buff);
+
+			if (likely(skb))
+				napi_gro_receive(&nv->napi, skb);
+			else
+				mpnic_put_pkt_buff(&state->pkt, true);
+
+			state->pkt.buff.data_hard_start = NULL;
+			packets++;
+			break;
+		}
+		}
+
+		raw_rcd++;
+		head++;
+
+		if (unlikely(!(head & rcq->size_mask))) {
+			done ^= cpu_to_le64(MPNIC_RCD_DONE);
+			raw_rcd = &rcq->desc[0];
+		}
+	}
+
+	rcq->head = head;
+
+	/* Allocate buffers, force dma_wmb(), and then start writing tails */
+	mpnic_fill_qt_bdqs(qt);
+
+	return packets;
+}
+
 static int mpnic_poll(struct napi_struct *napi, int budget)
 {
 	struct mpnic_napi_vector *nv = container_of(napi,
 						    struct mpnic_napi_vector,
 						    napi);
-	int i;
+	int i, j, work_done = 0;
 
 	for (i = 0; i < nv->txt_count; i++)
 		mpnic_clean_tcq(nv, &nv->qt[i], budget);
 
+	if (likely(budget))
+		for (j = 0; j < nv->rxt_count; j++, i++)
+			work_done += mpnic_clean_rcq(nv, &nv->qt[i],
+						     budget - work_done);
+
 	for (i = 0; i < nv->txt_count; i++)
 		mpnic_commit_cq_head(&nv->qt[i].cmpl);
 
-	if (likely(napi_complete_done(napi, 0)))
+	if (work_done >= budget)
+		return budget;
+
+	if (likely(napi_complete_done(napi, work_done)))
 		mpnic_nv_irq_rearm(nv);
 
-	return 0;
+	return work_done;
 }
 
 static irqreturn_t mpnic_msix_clean_rings(int __always_unused irq, void *data)
@@ -941,7 +1126,9 @@ static void mpnic_set_rde_cfg(struct mpnic_dev *mpd, struct mpnic_ring *rcq)
 			      MPNIC_RX_MAX_HDR));
 }
 
-static void mpnic_enable_rcq(struct mpnic_dev *mpd, struct mpnic_ring *rcq)
+static void mpnic_enable_rcq(struct mpnic_dev *mpd,
+			     struct mpnic_napi_vector *nv,
+			     struct mpnic_ring *rcq)
 {
 	u32 log_size = fls(rcq->size_mask);
 	u32 i = rcq->q_idx;
@@ -957,6 +1144,10 @@ static void mpnic_enable_rcq(struct mpnic_dev *mpd, struct mpnic_ring *rcq)
 	mpnic_wr64(mpd, MPNIC_RCQ_BASE_ADDR(i), rcq->dma);
 	mpnic_wr64(mpd, MPNIC_RCQ_SIZE(i), log_size & MPNIC_RCQ_SIZE_SIZE);
 
+	/* Store interrupt information for the completion queue */
+	mpnic_wr64(mpd, MPNIC_RIM_CTL(i), nv->v_idx);
+	mpnic_wr64(mpd, MPNIC_RIM_INTR_MASK(i), 0);
+
 	mpnic_wr64(mpd, MPNIC_RCQ_CTL(i), MPNIC_RCQ_CTL_ENABLE);
 }
 
@@ -975,7 +1166,7 @@ void mpnic_enable(struct mpnic_net *mpn)
 
 		for (j = 0; j < nv->rxt_count; j++, t++) {
 			mpnic_enable_bdq(mpd, &nv->qt[t].sub0, &nv->qt[t].sub1);
-			mpnic_enable_rcq(mpd, &nv->qt[t].cmpl);
+			mpnic_enable_rcq(mpd, nv, &nv->qt[t].cmpl);
 		}
 	}
 
@@ -1008,6 +1199,8 @@ static void mpnic_disable_bdq(struct mpnic_dev *mpd, struct mpnic_ring *hpq)
 static void mpnic_disable_rcq(struct mpnic_dev *mpd, struct mpnic_ring *rcq)
 {
 	mpnic_wr64(mpd, MPNIC_RCQ_CTL(rcq->q_idx), 0);
+	mpnic_wr64(mpd, MPNIC_RIM_INTR_MASK(rcq->q_idx),
+		   MPNIC_RIM_INTR_MASK_MASK);
 }
 
 void mpnic_disable(struct mpnic_net *mpn)
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
index 5e592dfd9f81..834eb9bfffd1 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
@@ -50,6 +50,12 @@ struct mpnic_net;
 /* Headers longer than this are split off into the payload queue */
 #define MPNIC_RX_MAX_HDR		1536
 
+/* A page is handed out to many packets, each of which takes one reference.
+ * Rather than a locked increment per packet the driver takes a batch of
+ * references up front and returns whatever is left when the page is done.
+ */
+#define MPNIC_PAGECNT_BIAS_MAX		(PAGE_SIZE + 1)
+
 #define MPNIC_MAX_JUMBO_FRAME_SIZE	9742
 
 /* The page a buffer descriptor queue is currently handing out. Records
@@ -63,6 +69,7 @@ struct mpnic_pg_ctxt {
 
 struct mpnic_pkt_ctxt {
 	struct xdp_buff buff;
+	bool add_frag_failed;
 };
 
 struct mpnic_rcq_state {

-- 
2.52.0

