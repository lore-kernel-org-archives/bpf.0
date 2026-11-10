Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306136;
	b=nBnKZWyJE6j+lnHfjCri2ZOAfoY3Jj6kqXUGSgotYJNGghUIVwFr2f8foh3uYAJ/310y
	 dnlSFZCa7LOXeEk9u3uCFeq1mw6YSIgvqQLinxFKBqQ3XQ9pLbAHS5dV8Q5gxObiXpWZm
	 W2b6+A+AmiuHtsgC6JFOIEwVbfD30AU08wikdSQP2TQaK0u6DFyieKLi4F0y9enJQtxOh
	 CePirykTUyzkeL+8/CSOWES60ImomzCXJEobhWWii54L6gOkT7Q+CJxuptSPOBtf3eX6Y
	 vPjV0nbgr21oOpWXECOUTrSQExp7oXjGJx/T93ZPLaQvqvJUPtdxAOUA3PjofBW4AEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306136;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0dnYHlLssALnREz+GarZKWC5f+wiKTxiShBtKJKkBxQ=;
	b=5Sl3F3DxZCvh8I+dp7R5939SVRJ2VTP1tfTCDAyVMeFKGBuDGmtgml1SqXy4/JLEtLyH
	 659RGJHh/x779kqWyDwwvJk+EJbTtwAhXs1ZiNBen+lR1/KwJS/repLOo3y4tt1l9aOEe
	 JdaIkm0yNzN6uwnSdCpIBAekQptYP4IUfIIgxXSVoTzYO+3j3zo2aO5rke5S6RcREVO/a
	 0CDbXBCFv7+4v4ESmZfbDxvRTti0W8LdTF/uM4c7LEsFeaD/sE/Zkvd5wAHCdplFit5sn
	 2WaW2FAGQkQfy7vZ+aXidj9bTF2b49hrxbSruhezDZK9eVQNf7foaoe2FJBuSClH4/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mo7x+LyF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64870606A33D;
	Tue, 10 Nov 2026 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mo7x+LyF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9381F008A6;
	Tue, 10 Nov 2026 10:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794306136;
	bh=0dnYHlLssALnREz+GarZKWC5f+wiKTxiShBtKJKkBxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mo7x+LyFFDvWneH3EisAHQCKKouVKa4XT3E0/vfNRUHxncWCCfPwL/BhrXqFMk5A/
	 lkg/whflT6ivaW6PPWZdRD9EWB9hwZSKDvgAbrl+fFFiacKXuEjH70UuPm1l6SkuD2
	 ktAwl/g1wN5vzDW1kWr0KKOZYoYpA014wEAI4cuzXGfYq7HYN+XHt+nz1B4GGOEsC4
	 LtENlHlpQuxbWzHms64T8u6Nbue0VECsqkI2c+DXhTp665Aw0GR5NchQYp9S+UHbHA
	 XUxHmdb1gm6Ngjfb9Jo9y5rDjZNR7O/o2lMHCU5D1gsmmdb4HKRv8J4VwYLueK1A9z
	 XnuNkhiadu50Q==
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
Subject: [PATCH net-next v1 09/11] eth: fbnic: Use netmem for RX headers and XDP_TX
Date: Tue, 10 Nov 2026 11:20:30 +0100
Message-ID: <20261110102039.1002605-10-bjorn@kernel.org>
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

fbnic reaches header and XDP_TX buffers through struct page, which a
provider net_iov does not have. Use netmem for both, and set up the
xdp_buff with xdp_init_buff_netmem(), so XDP_PASS copies heads that
must not leave the RX poll.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 47 +++++++++-----------
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h |  3 ++
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 51d573c9c5b8..bfaa284e497e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -665,14 +665,14 @@ static void fbnic_clean_twq1(struct fbnic_napi_vector *nv, bool pp_allow_direct,
 	unsigned int head = ring->head;
 
 	while (hw_head != head) {
-		struct page *page;
+		netmem_ref netmem;
 		u64 twd;
 
 		if (unlikely(!(ring->desc[head] & FBNIC_TWD_TYPE(AL))))
 			goto next_desc;
 
 		twd = le64_to_cpu(ring->desc[head]);
-		page = ring->tx_buf[head];
+		netmem = ring->tx_netmem[head];
 
 		/* TYPE_AL is 2, TYPE_LAST_AL is 3. So this trick gives
 		 * us one increment per packet, with no branches.
@@ -681,8 +681,8 @@ static void fbnic_clean_twq1(struct fbnic_napi_vector *nv, bool pp_allow_direct,
 				 FBNIC_TWD_TYPE_AL;
 		total_bytes += FIELD_GET(FBNIC_TWD_LEN_MASK, twd);
 
-		page_pool_put_page(pp_page_to_nmdesc(page)->pp, page, -1,
-				   pp_allow_direct);
+		page_pool_put_netmem(netmem_get_pp(netmem), netmem, -1,
+				     pp_allow_direct);
 next_desc:
 		head++;
 		head &= ring->size_mask;
@@ -766,15 +766,14 @@ static void fbnic_page_pool_init(struct fbnic_ring *ring, unsigned int idx,
 	rx_buf->netmem = netmem;
 }
 
-static struct page *
+static netmem_ref
 fbnic_page_pool_get_head(struct fbnic_q_triad *qt, unsigned int idx)
 {
 	struct fbnic_rx_buf *rx_buf = &qt->sub0.rx_buf[idx];
 
 	rx_buf->pagecnt_bias--;
 
-	/* sub0 is always fed system pages, from the NAPI-level page_pool */
-	return netmem_to_page(rx_buf->netmem);
+	return rx_buf->netmem;
 }
 
 static netmem_ref
@@ -1003,12 +1002,13 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
 	unsigned int hdr_pg_idx = fbnic_rcd_bd_idx(&qt->sub0, rcd);
 	unsigned int frame_sz, hdr_pg_start, hdr_pg_end, headroom;
 	unsigned char *hdr_start;
-	struct page *page;
+	netmem_ref netmem;
 
 	/* data_hard_start should always be NULL when this is called */
 	WARN_ON_ONCE(pkt->buff.data_hard_start);
 
-	page = fbnic_page_pool_get_head(qt, hdr_pg_idx);
+	netmem = fbnic_page_pool_get_head(qt, hdr_pg_idx);
+	pkt->head = netmem;
 
 	/* Short-cut the end calculation if we know page is fully consumed */
 	hdr_pg_end = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
@@ -1017,16 +1017,16 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
 
 	headroom = hdr_pg_off - hdr_pg_start + FBNIC_RX_PAD;
 	frame_sz = hdr_pg_end - hdr_pg_start;
-	xdp_init_buff(&pkt->buff, frame_sz, &qt->xdp_rxq);
+	xdp_init_buff_netmem(&pkt->buff, frame_sz, &qt->xdp_rxq, netmem,
+			     &pkt->ext);
 	hdr_pg_start += fbnic_rcd_bd_page_offset(&qt->sub0, rcd);
 
 	/* Sync DMA buffer */
-	dma_sync_single_range_for_cpu(nv->dev, page_pool_get_dma_addr(page),
-				      hdr_pg_start, frame_sz,
-				      DMA_BIDIRECTIONAL);
+	page_pool_dma_sync_netmem_for_cpu(qt->sub0.page_pool, netmem,
+					  hdr_pg_start, frame_sz);
 
 	/* Build frame around buffer */
-	hdr_start = page_address(page) + hdr_pg_start;
+	hdr_start = netmem_address(netmem) + hdr_pg_start;
 	net_prefetch(hdr_start + headroom);
 	xdp_prepare_buff(&pkt->buff, hdr_start, headroom,
 			 len - FBNIC_RX_PAD, true);
@@ -1073,8 +1073,6 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
 static void fbnic_put_pkt_buff(struct fbnic_q_triad *qt,
 			       struct fbnic_pkt_buff *pkt, int budget)
 {
-	struct page *page;
-
 	if (!pkt->buff.data_hard_start)
 		return;
 
@@ -1093,8 +1091,7 @@ static void fbnic_put_pkt_buff(struct fbnic_q_triad *qt,
 		}
 	}
 
-	page = virt_to_page(pkt->buff.data_hard_start);
-	page_pool_put_full_page(qt->sub0.page_pool, page, !!budget);
+	page_pool_put_full_netmem(qt->sub0.page_pool, pkt->head, !!budget);
 }
 
 static struct sk_buff *fbnic_build_skb(struct fbnic_napi_vector *nv,
@@ -1121,7 +1118,7 @@ static long fbnic_pkt_tx(struct fbnic_napi_vector *nv,
 	unsigned int tail = ring->tail;
 	struct skb_shared_info *shinfo;
 	skb_frag_t *frag = NULL;
-	struct page *page;
+	netmem_ref netmem;
 	dma_addr_t dma;
 	__le64 *twd;
 
@@ -1139,9 +1136,9 @@ static long fbnic_pkt_tx(struct fbnic_napi_vector *nv,
 		return -FBNIC_XDP_CONSUME;
 	}
 
-	page = virt_to_page(pkt->buff.data_hard_start);
-	offset = offset_in_page(pkt->buff.data);
-	dma = page_pool_get_dma_addr(page);
+	netmem = pkt->head;
+	offset = (u8 *)pkt->buff.data - (u8 *)netmem_address(netmem);
+	dma = page_pool_get_dma_addr_netmem(netmem);
 
 	size = pkt->buff.data_end - pkt->buff.data;
 
@@ -1150,7 +1147,7 @@ static long fbnic_pkt_tx(struct fbnic_napi_vector *nv,
 						 DMA_BIDIRECTIONAL);
 		dma += offset;
 
-		ring->tx_buf[tail] = page;
+		ring->tx_netmem[tail] = netmem;
 
 		twd = &ring->desc[tail];
 		*twd = cpu_to_le64(FIELD_PREP(FBNIC_TWD_ADDR_MASK, dma) |
@@ -1165,8 +1162,8 @@ static long fbnic_pkt_tx(struct fbnic_napi_vector *nv,
 			break;
 
 		offset = skb_frag_off(frag);
-		page = skb_frag_page(frag);
-		dma = page_pool_get_dma_addr(page);
+		netmem = skb_frag_netmem(frag);
+		dma = page_pool_get_dma_addr_netmem(netmem);
 
 		size = skb_frag_size(frag);
 		data_len -= size;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 6ee3cce3d942..d036c8399364 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -82,7 +82,9 @@ struct fbnic_net;
 struct fbnic_pkt_buff {
 	struct xdp_buff buff;
 	ktime_t hwtstamp;
+	netmem_ref head;
 	bool add_frag_failed;
+	struct xdp_buff_ext ext;
 };
 
 struct fbnic_queue_stats {
@@ -123,6 +125,7 @@ struct fbnic_ring {
 	union {
 		struct fbnic_pkt_buff *pkt;	/* RCQ */
 		struct fbnic_rx_buf *rx_buf;	/* BDQ */
+		netmem_ref *tx_netmem;		/* TWQ1 */
 		void **tx_buf;			/* TWQ */
 		void *buffer;			/* Generic pointer */
 	};
-- 
2.56.0

