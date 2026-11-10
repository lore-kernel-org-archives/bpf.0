Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306146;
	b=h1ydxqLE6MhBXXdFpC8B6TDoHFwQU2yHVM6XDr2t8vEBQ1joHKVRw9RLIPxSUb2+O4IH
	 d7x1wJnNobaD/i7vmFMKigB2BNFpVsw/6KMoRTNGQRKY/lEPhOX5z0slm96/rkMcfcMkz
	 nlYweqh27noWDrHidnr7I+/JYxkdjAd7wDwYsYzxDJTut3NpK3qnAJbE+6yMZ2IIcNKyF
	 RuoWqFBr6nMcf/WsUPv8tAzqfH2qGFfIBfIheaVS4s0THCdWCagtH82dlkD4FoQiGCZ41
	 0EQcQZw2nTjNO8cK9IaXyJamlVg61KVKclRMR/Qx4XVW+hj939VwZR0DVDAzFAVq8lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306146;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LMPjX8AbpIF5FGmOmEYcarTEEDEeUu0w0QUtfgtfYAo=;
	b=cYw8D4KpdqFBgkkuocc13I7/4sbGpG+Tt6HdBoowwP50NhHfTZJHm22/T543MMyWSl1R
	 /MGl6YTz4LGMYiKgPIMiIDYqhi9Pel6eGwDvkbBvHssmF+VorTk9aA5TzYNZ0Yq4Jrucy
	 LQjuh6xsDTOCJwQ1QxC18dWa27F7FqAllnZpt5uJogfH/vgwGlcT1BPOY6akSi8F1B5Us
	 fcxaKm8N1r+IOHj+HoRUlvN2bAJ+fPDfszyd4ucx9/Oq0wWRuMpsPwC6oflIk2tjqWdFC
	 74UwRNuqRX9KjKlYMwUCrjDH9BWyb1sg9zVGbtIgxkrvy1UDakAAXJBI5uFRlnLVMjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YeynSvjA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C2F60710C5;
	Tue, 10 Nov 2026 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YeynSvjA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC481F008A3;
	Tue, 10 Nov 2026 10:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794306145;
	bh=LMPjX8AbpIF5FGmOmEYcarTEEDEeUu0w0QUtfgtfYAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YeynSvjAsIPJmVCo4z4Qybl3edUP+UmJo0hSNfS0dJyIRDn+mrYfcTHaIqsFU02Wo
	 SGwsO9kcPuYi+n/YPWyZ3cPH5ws68G8+TrQfS8PUMwWGacsFSoc8Epka++o/PXsut7
	 3GKi+R5vt+2W3i3IwFMBG4U0oGBAqOY3q4ZjucPgvhe9cukQrstR6ZQcSUOqewHvhN
	 OXklR7gWs3cCo5qOxDkAsVbvMhuOltXiOsEsQxXMtpF5eSEUPpg1XaOZmpfnRwdkgv
	 9UnPCSUioofuo69BwnW4n53feHeC68tfvgOOFkQbSu+qt0CsR3mzVOFCKA5HUR1Qse
	 0pgXthcCdpHew==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	io-uring@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Weiming Shi <bestswngs@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Wei <dw@davidwei.uk>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stuart Clark <stuclar@meta.com>
Subject: [PATCH net-next v1 10/11] eth: fbnic: Support RX buffers it cannot split
Date: Tue, 10 Nov 2026 11:20:31 +0100
Message-ID: <20261110102039.1002605-11-bjorn@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110102039.1002605-1-bjorn@kernel.org>
References: <20261110102039.1002605-1-bjorn@kernel.org>
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

fbnic packs several headers, and several payloads, into one page. A
provider without MP_CAP_FRAG needs one descriptor per buffer. Give
such a buffer a single reference, program the queue so each header and
payload takes a buffer of its own, and drop packets that break this.

Header split is now set per queue, so link up changes only the drop
mode.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 119 ++++++++++++++++---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h |   2 +
 2 files changed, 102 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index bfaa284e497e..d96c957d6fba 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -761,8 +761,14 @@ static void fbnic_page_pool_init(struct fbnic_ring *ring, unsigned int idx,
 {
 	struct fbnic_rx_buf *rx_buf = &ring->rx_buf[idx];
 
-	page_pool_fragment_netmem(netmem, FBNIC_PAGECNT_BIAS_MAX);
-	rx_buf->pagecnt_bias = FBNIC_PAGECNT_BIAS_MAX;
+	/* A whole buffer has one reference. The packet takes it, so the buffer
+	 * may be reused before its BDQ entry is cleaned.
+	 */
+	rx_buf->pagecnt_bias = 1;
+	if (page_pool_supports_frag(ring->page_pool)) {
+		page_pool_fragment_netmem(netmem, FBNIC_PAGECNT_BIAS_MAX);
+		rx_buf->pagecnt_bias = FBNIC_PAGECNT_BIAS_MAX;
+	}
 	rx_buf->netmem = netmem;
 }
 
@@ -792,7 +798,8 @@ static void fbnic_page_pool_drain(struct fbnic_ring *ring, unsigned int idx,
 	struct fbnic_rx_buf *rx_buf = &ring->rx_buf[idx];
 	netmem_ref netmem = rx_buf->netmem;
 
-	if (!page_pool_unref_netmem(netmem, rx_buf->pagecnt_bias))
+	if (rx_buf->pagecnt_bias &&
+	    !page_pool_unref_netmem(netmem, rx_buf->pagecnt_bias))
 		page_pool_put_unrefed_netmem(ring->page_pool, netmem, -1,
 					     !!budget);
 
@@ -993,6 +1000,19 @@ static unsigned int fbnic_hdr_pg_end(unsigned int pg_off, unsigned int len)
 	return ALIGN(pg_off, 128) - FBNIC_RX_HROOM;
 }
 
+/* A buffer that cannot be split has one reference and takes one descriptor */
+static bool fbnic_bd_one_desc(struct fbnic_napi_vector *nv,
+			      const struct fbnic_ring *bdq, unsigned int idx,
+			      bool ok)
+{
+	if (likely(page_pool_supports_frag(bdq->page_pool) ||
+		   (bdq->rx_buf[idx].pagecnt_bias == 1 && ok)))
+		return true;
+
+	netdev_err_once(nv->napi.dev, "Bad descriptor for a whole RX buffer\n");
+	return false;
+}
+
 static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
 			      struct fbnic_pkt_buff *pkt,
 			      struct fbnic_q_triad *qt)
@@ -1007,6 +1027,17 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
 	/* data_hard_start should always be NULL when this is called */
 	WARN_ON_ONCE(pkt->buff.data_hard_start);
 
+	/* MAX_HDR leaves no room for a second header in a whole buffer, so
+	 * the device closes it, with PAGE_FIN, after the first.
+	 */
+	pkt->add_frag_failed = false;
+	if (unlikely(!fbnic_bd_one_desc(nv, &qt->sub0, hdr_pg_idx,
+					FIELD_GET(FBNIC_RCD_AL_PAGE_FIN,
+						  rcd)))) {
+		pkt->add_frag_failed = true;
+		return;
+	}
+
 	netmem = fbnic_page_pool_get_head(qt, hdr_pg_idx);
 	pkt->head = netmem;
 
@@ -1032,7 +1063,6 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
 			 len - FBNIC_RX_PAD, true);
 
 	pkt->hwtstamp = 0;
-	pkt->add_frag_failed = false;
 }
 
 static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
@@ -1046,8 +1076,20 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
 	netmem_ref netmem;
 	bool added;
 
+	if (unlikely(!fbnic_bd_one_desc(nv, &qt->sub1, pg_idx, !pg_off))) {
+		pkt->add_frag_failed = true;
+		return;
+	}
+
 	netmem = fbnic_page_pool_get_data(qt, pg_idx);
 
+	/* Without a header buffer, the packet is dropped. */
+	if (unlikely(!pkt->buff.data_hard_start)) {
+		page_pool_put_full_netmem(qt->sub1.page_pool, netmem, true);
+		pkt->add_frag_failed = true;
+		return;
+	}
+
 	truesize = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
 		   FBNIC_BD_PAGE_SIZE - pg_off :
 		   ALIGN(len, FBNIC_RX_PAYLD_ALIGN);
@@ -1608,6 +1650,13 @@ void fbnic_free_napi_vectors(struct fbnic_net *fbn)
 			fbnic_free_napi_vector(fbn, fbn->napi[i]);
 }
 
+/* No second header fits behind the first in a whole buffer */
+static u32 fbnic_whole_hdr_max(u32 hroom)
+{
+	return FBNIC_BD_PAGE_SIZE - ALIGN(hroom, FBNIC_RX_HDR_ALIGN) -
+	       FBNIC_RX_TROOM - FBNIC_RX_PAD;
+}
+
 static int
 fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_q_triad *qt,
 			  unsigned int rxq_idx, u32 rx_page_size)
@@ -1644,6 +1693,9 @@ fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_q_triad *qt,
 		return PTR_ERR(pp);
 
 	qt->sub0.page_pool = pp;
+	qt->hdr_max = 0;
+	if (!page_pool_supports_frag(pp))
+		qt->hdr_max = fbnic_whole_hdr_max(FBNIC_RX_HROOM);
 	if (netif_rxq_has_unreadable_mp(fbn->netdev, rxq_idx)) {
 		pp_params.order = get_order(rx_page_size);
 		pp_params.max_len = rx_page_size;
@@ -2672,6 +2724,14 @@ static void fbnic_enable_bdq(struct fbnic_ring *hpq, struct fbnic_ring *ppq)
 	fbnic_ring_wr32(hpq, FBNIC_QUEUE_BDQ_CTL, bdq_ctl);
 }
 
+static u32 fbnic_drop_mode(struct fbnic_net *fbn, bool tx_pause)
+{
+	if (!tx_pause && fbn->num_rx_queues > 1)
+		return FBNIC_QUEUE_RDE_CTL0_DROP_IMMEDIATE;
+
+	return FBNIC_QUEUE_RDE_CTL0_DROP_NEVER;
+}
+
 static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
 				       struct fbnic_ring *rcq, bool tx_pause,
 				       bool hdr_split)
@@ -2679,10 +2739,7 @@ static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
 	struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
 	u32 drop_mode, rcq_ctl;
 
-	if (!tx_pause && fbn->num_rx_queues > 1)
-		drop_mode = FBNIC_QUEUE_RDE_CTL0_DROP_IMMEDIATE;
-	else
-		drop_mode = FBNIC_QUEUE_RDE_CTL0_DROP_NEVER;
+	drop_mode = fbnic_drop_mode(fbn, tx_pause);
 
 	/* Specify packet layout */
 	rcq_ctl = FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_DROP_MODE_MASK, drop_mode) |
@@ -2693,20 +2750,32 @@ static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
 	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RDE_CTL0, rcq_ctl);
 }
 
+static u32 fbnic_rcq_hds_thresh(const struct fbnic_net *fbn,
+				const struct fbnic_ring *rcq)
+{
+	const struct fbnic_q_triad *qt;
+
+	qt = container_of_const(rcq, struct fbnic_q_triad, cmpl);
+	return qt->hdr_max ? : fbn->hds_thresh;
+}
+
+/* Only the drop mode: a queue start may write the rest of the register */
 void fbnic_config_drop_mode(struct fbnic_net *fbn, bool txp)
 {
-	bool hds;
+	struct fbnic_ring *rcq;
+	u32 drop_mode, rcq_ctl;
 	int i, t;
 
-	hds = fbn->hds_thresh < FBNIC_HDR_BYTES_MIN;
-
+	drop_mode = fbnic_drop_mode(fbn, txp);
 	for (i = 0; i < fbn->num_napi; i++) {
 		struct fbnic_napi_vector *nv = fbn->napi[i];
 
 		for (t = 0; t < nv->rxt_count; t++) {
-			struct fbnic_q_triad *qt = &nv->qt[nv->txt_count + t];
-
-			fbnic_config_drop_mode_rcq(nv, &qt->cmpl, txp, hds);
+			rcq = &nv->qt[nv->txt_count + t].cmpl;
+			rcq_ctl = fbnic_ring_rd32(rcq, FBNIC_QUEUE_RDE_CTL0);
+			FIELD_MODIFY(FBNIC_QUEUE_RDE_CTL0_DROP_MODE_MASK,
+				     &rcq_ctl, drop_mode);
+			fbnic_ring_wr32(rcq, FBNIC_QUEUE_RDE_CTL0, rcq_ctl);
 		}
 	}
 }
@@ -2771,26 +2840,38 @@ void fbnic_config_rx_frames(struct fbnic_napi_vector *nv)
 static void fbnic_enable_rcq(struct fbnic_napi_vector *nv,
 			     struct fbnic_ring *rcq)
 {
+	struct fbnic_q_triad *qt = container_of_const(rcq, struct fbnic_q_triad,
+						     cmpl);
 	struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
+	u32 payld_pg_cl = FBNIC_RX_PAYLD_PG_CL;
+	u32 payld_off = FBNIC_RX_PAYLD_OFFSET;
 	u32 log_size = fls(rcq->size_mask);
 	u32 rcq_ctl = 0;
 	bool hdr_split;
 	u32 hds_thresh;
 
+	/* At 4 KiB, PAYLD_OFF puts each payload in a fresh buffer, and
+	 * PAYLD_PG_CL closes it after the payload.
+	 */
+	if (!page_pool_supports_frag(qt->sub1.page_pool)) {
+		payld_off = ilog2(FBNIC_BD_PAGE_SIZE / FBNIC_RX_PAYLD_ALIGN);
+		payld_pg_cl = payld_off;
+	}
+
 	/* Force lower bound on MAX_HEADER_BYTES. Below this, all frames should
 	 * be split at L4. It would also result in the frames being split at
 	 * L2/L3 depending on the frame size.
 	 */
-	hdr_split = fbn->hds_thresh < FBNIC_HDR_BYTES_MIN;
+	hds_thresh = fbnic_rcq_hds_thresh(fbn, rcq);
+	hdr_split = hds_thresh < FBNIC_HDR_BYTES_MIN;
 	fbnic_config_drop_mode_rcq(nv, rcq, fbn->tx_pause, hdr_split);
 
-	hds_thresh = max(fbn->hds_thresh, FBNIC_HDR_BYTES_MIN);
+	hds_thresh = max(hds_thresh, FBNIC_HDR_BYTES_MIN);
 	rcq_ctl |= FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PADLEN_MASK, FBNIC_RX_PAD) |
 		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_MAX_HDR_MASK, hds_thresh) |
-		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PAYLD_OFF_MASK,
-			      FBNIC_RX_PAYLD_OFFSET) |
+		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PAYLD_OFF_MASK, payld_off) |
 		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PAYLD_PG_CL_MASK,
-			      FBNIC_RX_PAYLD_PG_CL);
+			      payld_pg_cl);
 	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RDE_CTL1, rcq_ctl);
 
 	/* Reset head/tail */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index d036c8399364..3077d9bbd587 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -65,6 +65,7 @@ struct fbnic_net;
 #define FBNIC_RX_HROOM \
 	(ALIGN(FBNIC_RX_TROOM + FBNIC_RX_HROOM_PAD, 128) - FBNIC_RX_TROOM)
 #define FBNIC_RX_PAD			0
+#define FBNIC_RX_HDR_ALIGN		128
 #define FBNIC_RX_PAYLD_ALIGN		128
 #define FBNIC_RX_PAYLD_OFFSET		0
 #define FBNIC_RX_PAYLD_PG_CL		0
@@ -165,6 +166,7 @@ struct fbnic_ring {
 struct fbnic_q_triad {
 	struct fbnic_ring sub0, sub1, cmpl;
 	struct xdp_rxq_info xdp_rxq;
+	u16 hdr_max;	/* Header bytes for whole header buffers, or 0 */
 };
 
 struct fbnic_napi_vector {
-- 
2.56.0

