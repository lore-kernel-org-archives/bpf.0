Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A3B36826B
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 01:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127869; cv=none; b=LVUAca5RUj/4htDTlnrAKEJIK4u3HdfaAmHiDUaPujIhgOiDljUr6FSWLjeSNMRXs84qBp3nhzfH6/arT6H9fVUqC+cn+pH+KrUSbeZZSELNVq6w8Ni8+kK4i8w+SUqEQkba/6RkqtZ86TTmv7FB4ngK99dzYUTrv7IXmHa+ovA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127869; c=relaxed/simple;
	bh=8xz0ExLsB6sX4u/cE2unS51zAuLarqz+5PnacSi8EB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hVH0WmRLK2/mzRmrOT2eph9NVt7x+unSwY5KgZgD5E/CY5/KdjDZF4GvKHP5CzkRPxpY7WFmfWJh+xV/ndzb2m5oLu9vL1ev3geAJGNvGYtdY3WyF0IPKsuL0nnWs9UnN6LImQ1I1K9HSQd59+R3VEEPwG3PeJi/4e6zULJPmW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q71YKsL/; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q71YKsL/"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-46ac6e5d8f7so290099fac.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 18:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790127864; x=1790732664; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FRQUG8hN+dY2qhxWr1OmoYBHJn+7xZ0epI4nG4+wrxE=;
        b=q71YKsL/Rthjv1dQxubDMqvYIIqtLiPPNPpjDHjsEtaoJSC84cTZtLVULSXVnCXjni
         JyRUMpYOh3b8qc21rY8VGBp14kuFOhOn9FVYOlZSiT+fRlAMJSIFJbQ7RGKZCIGATDBP
         dbpihZ6KWSp22RfqAwi1HtV2H7z3VXGy/tzapIzR28KPPPPPg8Hm939NwKfh5B99PGGf
         vbCOInqYchf4XaBZ7yMoHg9Vwn8j1NrSkqv1+mPDWUto6Yo82Ad+bYuVLLAVZz5dr9vl
         KEfGl4F0Pm65hkoH02BWqk84omzCTlMxn7vX385Oa/vJ0d0RJoTR2keYczkvIyTqXe3q
         05Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790127864; x=1790732664;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FRQUG8hN+dY2qhxWr1OmoYBHJn+7xZ0epI4nG4+wrxE=;
        b=HKdp1QSKpHUuuntS52oIdKmHoVJW3ZAOeFDKmQTooqCyCGf4eN4OK1hePUjSxP/Ctz
         Zw8RJswv3cAXB6lVNZsNDL5QYfx0MeOkqhFj/qSPa5TnDSAkRLFZfYRzPEXeAWKquwtT
         /rXPO2ys8ho2EN5LY8IKNgk/0TcAT4XClUCyV5I0iQYj401I25H3SA2SwBSbTNqmJK5q
         DlzJoNNBPNGs2kc5EpolLPYiSiOOHL9YQXlwtu54TvHY1Ag8hGFylMMoZ+xhOK4ObiHB
         s6aZWOryvtXnDL08jHWWDcNJy+RJiXEwOpW4Kkm+gDNsqLHO5uHDUlZw9nO1WD1dBoey
         vrdg==
X-Forwarded-Encrypted: i=1; AKwUvByj21vyeRUS9W9kMaV/axzKr9k4cMDMjAin2bxvZbwui6+P3L0AtDwzqOiJnfgBhpKo3l4=@vger.kernel.org
X-Gm-Message-State: AFuF++nMN3axE4cNsaZJwv3JgUj3V5AYP/cgpXcw707V9WcBtqaLOPSM
	7jMuqEc9SQQzvs7L5czpCr+KVR3frNowHvoz2VO4XhKcPQGJ/jLXDVqa
X-Gm-Gg: AYBFou13p1J1D5AIOgpyKxtsjUX0xFREtuHTqEofnAS38lfpNuVzqEgDBeHV6o2fsPA
	qaC1Ic37g1fRBa8rH8eXIWKzhEOKjQLl3wea4GKfJAWiLGrCah7HFaowKqhfACp+0SIpz5zQoON
	8n6kLzUTzLsUSmzSrJ6i9/VJ75hMBEC1wBs93lJJAVNcv+JZVJvxe2UOviogAS7pQOKyvFuCX/4
	j0Ek1Zgo0EF+Uz0J+fcu//u5hPMCWBNiGCmCAQhtlPxNwgO9Mv4wh18eTMiw8YkpQMPmwxJiYK8
	lIbDiWJy9kpppGasJRoayghFopgBeSLyLBTwRR0O92cHNKSqbhUEzf0Hk16fzmAZackrSHEB0lG
	FhSyX8K4BHaxH6gAf/AUrdAiJszhgNwAmKw3W0jY51og5W/cUZZJUNmRKXAFGDsWYFAmYBi+jZw
	3hroqYu5fS6M8q924pzrZb6pKHYaqT1j4iVSS3qJmfhWLiZziq+c8a1//44mKklRu17W59
X-Received: by 2002:a05:6870:d153:b0:449:bccf:bb6e with SMTP id 586e51a60fabf-490892d6b2amr1393358fac.7.1790127864410;
        Tue, 22 Sep 2026 18:44:24 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4908e126e79sm1113507fac.4.2026.09.22.18.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 18:44:23 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Tue, 22 Sep 2026 18:43:46 -0700
Subject: [PATCH net-next 8/8] eth: mpnic: add basic Rx handling
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-linux-mpnic-v1-8-236844f53072@gmail.com>
References: <20260922-linux-mpnic-v1-0-236844f53072@gmail.com>
In-Reply-To: <20260922-linux-mpnic-v1-0-236844f53072@gmail.com>
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
 drivers/net/ethernet/meta/mpnic/mpnic_csr.h  |   7 +
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c | 205 ++++++++++++++++++++++++++-
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h |  14 +-
 3 files changed, 213 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
index 96ed2386bd6a..423378ca802c 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
@@ -131,6 +131,10 @@ enum {
 #define MPNIC_RCQ_SIZE(i)		(0x294 + 1024 * (i))	/* 0xa50 */
 #define MPNIC_RCQ_SIZE_SIZE			CSR_GENMASK(4, 0)
 
+/* NIC_CORE_RIM */
+#define MPNIC_RIM_INTR_MASK(i)		(0x2c8 + 1024 * (i))	/* 0xb20 */
+#define MPNIC_RIM_INTR_MASK_MASK		CSR_BIT(0)
+
 /* NIC_CORE_TIM_PRV */
 #define MPNIC_TIM_CTL(i)		(0x100100 + 1024 * (i))	/* 0x400400 */
 
@@ -140,6 +144,9 @@ enum {
 #define MPNIC_RDE_CFG_MIN_HEAD_ROOM		CSR_GENMASK(18, 10)
 #define MPNIC_RDE_CFG_MAX_HEADER_BYTES		CSR_GENMASK(45, 32)
 
+/* NIC_CORE_RIM_PRV */
+#define MPNIC_RIM_CTL(i)		(0x100280 + 1024 * (i))	/* 0x400a00 */
+
 /* NIC_CORE_RBP_HP_GLBL */
 #define MPNIC_HPQ_IDLE(i)		(0x420000 + 2 * (i))	/* 0x1080000 */
 #define MPNIC_HPQ_IDLE_CNT		16
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
index 6d2123bee97b..9878ea5a2f8e 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
@@ -402,6 +402,34 @@ static void mpnic_fill_qt_bdqs(struct mpnic_q_triad *qt)
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
@@ -414,9 +442,90 @@ static void mpnic_flush_pg_ctxt(struct mpnic_pg_ctxt *ctxt, bool napi)
 	}
 }
 
-static void mpnic_put_pkt_buff(struct mpnic_pkt_ctxt *ctxt, bool napi)
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
+mpnic_pkt_prepare(struct mpnic_napi_vector *nv, u64 rcd,
+		  struct mpnic_rcq_state *state, struct mpnic_q_triad *qt)
+{
+	unsigned int pg_off = FIELD_GET(MPNIC_RCD_AL_BUFF_OFF, rcd);
+	unsigned int pg_idx = FIELD_GET(MPNIC_RCD_AL_BUFF_ID, rcd);
+	unsigned int len = FIELD_GET(MPNIC_RCD_AL_BUFF_LEN, rcd);
+	bool fin = FIELD_GET(MPNIC_RCD_AL_PAGE_FIN, rcd);
+	unsigned int frame_sz, pg_start, pg_end;
+	struct xdp_buff *buff = &state->pkt;
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
+	dma_sync_single_range_for_cpu(nv->dev, page_pool_get_dma_addr(page),
+				      pg_start, frame_sz, DMA_FROM_DEVICE);
+
+	xdp_init_buff(buff, frame_sz, &qt->xdp_rxq);
+	xdp_prepare_buff(buff, page_address(page) + pg_start,
+			 pg_off - pg_start, len, true);
+	net_prefetch(buff->data);
+
+	state->add_frag_failed = false;
+}
+
+static void
+mpnic_add_rx_frag(struct mpnic_napi_vector *nv, u64 rcd,
+		  struct mpnic_rcq_state *state, struct mpnic_q_triad *qt)
+{
+	unsigned int pg_off = FIELD_GET(MPNIC_RCD_AL_BUFF_OFF, rcd);
+	unsigned int pg_idx = FIELD_GET(MPNIC_RCD_AL_BUFF_ID, rcd);
+	unsigned int len = FIELD_GET(MPNIC_RCD_AL_BUFF_LEN, rcd);
+	bool fin = FIELD_GET(MPNIC_RCD_AL_PAGE_FIN, rcd);
+	struct xdp_buff *buff = &state->pkt;
+	unsigned int truesz;
+	struct page *page;
+
+	page = mpnic_page_pool_get(&state->payld, &qt->sub1, pg_idx);
+	qt->sub1.head = (pg_idx + 1) & qt->sub1.size_mask;
+
+	truesz = (fin ? page_size(page) : ALIGN(pg_off + len, 128)) - pg_off;
+
+	dma_sync_single_range_for_cpu(nv->dev, page_pool_get_dma_addr(page),
+				      pg_off, truesz, DMA_FROM_DEVICE);
+
+	if (!xdp_buff_add_frag(buff, page_to_netmem(page), pg_off, len,
+			       truesz)) {
+		state->payld.pagecnt_bias++;
+		state->add_frag_failed = true;
+	}
+}
+
+static void mpnic_put_pkt_buff(struct xdp_buff *buff, bool napi)
 {
-	struct xdp_buff *buff = &ctxt->buff;
 	struct page *page;
 
 	if (!buff->data_hard_start)
@@ -439,23 +548,97 @@ static void mpnic_put_pkt_buff(struct mpnic_pkt_ctxt *ctxt, bool napi)
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
+				mpnic_pkt_prepare(nv, rcd, state, qt);
+			break;
+		case MPNIC_RCD_TYPE_PAY_AL:
+			mpnic_add_rx_frag(nv, rcd, state, qt);
+			break;
+		case MPNIC_RCD_TYPE_META: {
+			struct sk_buff *skb = NULL;
+
+			if (likely(!(rcd &
+				     MPNIC_RCD_META_UNCORRECTABLE_ERR_MASK) &&
+				   !state->add_frag_failed))
+				skb = xdp_build_skb_from_buff(&state->pkt);
+
+			if (likely(skb))
+				napi_gro_receive(&nv->napi, skb);
+			else
+				mpnic_put_pkt_buff(&state->pkt, true);
+
+			state->pkt.data_hard_start = NULL;
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
 
+	for (j = 0; j < nv->rxt_count; j++, i++)
+		work_done += mpnic_clean_rcq(nv, &nv->qt[i], budget);
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
@@ -938,7 +1121,9 @@ static void mpnic_set_rde_cfg(struct mpnic_dev *mpd, struct mpnic_ring *rcq)
 			      MPNIC_RX_MAX_HDR));
 }
 
-static void mpnic_enable_rcq(struct mpnic_dev *mpd, struct mpnic_ring *rcq)
+static void mpnic_enable_rcq(struct mpnic_dev *mpd,
+			     struct mpnic_napi_vector *nv,
+			     struct mpnic_ring *rcq)
 {
 	u32 log_size = fls(rcq->size_mask);
 	u32 i = rcq->q_idx;
@@ -954,6 +1139,10 @@ static void mpnic_enable_rcq(struct mpnic_dev *mpd, struct mpnic_ring *rcq)
 	mpnic_wr64(mpd, MPNIC_RCQ_BASE_ADDR(i), rcq->dma);
 	mpnic_wr64(mpd, MPNIC_RCQ_SIZE(i), log_size & MPNIC_RCQ_SIZE_SIZE);
 
+	/* Store interrupt information for the completion queue */
+	mpnic_wr64(mpd, MPNIC_RIM_CTL(i), nv->v_idx);
+	mpnic_wr64(mpd, MPNIC_RIM_INTR_MASK(i), 0);
+
 	mpnic_wr64(mpd, MPNIC_RCQ_CTL(i), MPNIC_RCQ_CTL_ENABLE);
 }
 
@@ -972,7 +1161,7 @@ void mpnic_enable(struct mpnic_net *mpn)
 
 		for (j = 0; j < nv->rxt_count; j++, t++) {
 			mpnic_enable_bdq(mpd, &nv->qt[t].sub0, &nv->qt[t].sub1);
-			mpnic_enable_rcq(mpd, &nv->qt[t].cmpl);
+			mpnic_enable_rcq(mpd, nv, &nv->qt[t].cmpl);
 		}
 	}
 
@@ -1005,6 +1194,8 @@ static void mpnic_disable_bdq(struct mpnic_dev *mpd, struct mpnic_ring *hpq)
 static void mpnic_disable_rcq(struct mpnic_dev *mpd, struct mpnic_ring *rcq)
 {
 	mpnic_wr64(mpd, MPNIC_RCQ_CTL(rcq->q_idx), 0);
+	mpnic_wr64(mpd, MPNIC_RIM_INTR_MASK(rcq->q_idx),
+		   MPNIC_RIM_INTR_MASK_MASK);
 }
 
 void mpnic_disable(struct mpnic_net *mpn)
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
index ba118dd2f3de..936ad791a346 100644
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
@@ -61,15 +67,11 @@ struct mpnic_pg_ctxt {
 	u32		idx;
 };
 
-struct mpnic_pkt_ctxt {
-	struct xdp_buff buff;
-	u32 data_truesize;
-};
-
 struct mpnic_rcq_state {
-	struct mpnic_pkt_ctxt pkt;
+	struct xdp_buff pkt;
 	struct mpnic_pg_ctxt hdr;
 	struct mpnic_pg_ctxt payld;
+	bool add_frag_failed;
 };
 
 struct mpnic_ring {

-- 
2.52.0

