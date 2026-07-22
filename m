Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A80377018
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784743236; cv=none; b=rsguwR8d2fGXssUXW6vIJ2NmauBb1Cwx09ySLW0QjDaM1Y7Q4EitrhBZ3a5I8ay2jYtrsLvCuBe5QbKOdpJfiffJI90k0n+8v9OkvLmkWeZ8OMefs+z352hobN1qiyNOFdj/pGbXmJotmjjRyntWtfqB7wXxspczIPFJACCEfy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784743236; c=relaxed/simple;
	bh=vkmMMSfEVfKjCsYxYnqoa8Dbu5CQcYm0Ucx4nKWpc20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrPkrTFxvK/YzzoEYbo8dPrHgXJtey3yA5I7Hb3L/jr/98LscYt2gh7Uln66DOLVlvn5R3IX3JB3vnkwWjbSx6xHVpueWXHGjiEr3sUTAkxAHgvG4uD31EsyEiOwYvNgWdpGzqG6MbjWdMEh6dx8g3njOK/Y5g8w0pMeIijrjRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a46eIdug; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a46eIdug"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-38de693676dso8989377a91.0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 11:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784743233; x=1785348033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=455QrxqnsisFydYmxFbkhDq8b3Ie23cEcUJG/V3TVHA=;
        b=a46eIdugsuduTGrsB11SIePM/Jov5Sn06dyFxJPktuCR7RWhM0Py7Iec/918y7m4KS
         8iFKOHWNmcNypEZrWUU3ZVh/vvozlPuS0ev5N10+Mnsb2IZMLaWgAOa1ogvOzGn5HG7t
         4uobGjpQkMFTMwnE+QyVIELY+90sIbX09AXUsF+9sMN6X5J5ML6na+vsRkold4UnNP/G
         MQY6qfhahqPJeFv+sNApJLKGQt58HgadSYjCFdIjP/wYeflMf1OfvkJvJBxneB820Bvz
         bqJ8fKxmp5X3YL9eQdZ2jsEzfNY5P8GEeAIr+A87o0h5nABppNOBOag45tBxIA3Eihbg
         6rkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784743233; x=1785348033;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=455QrxqnsisFydYmxFbkhDq8b3Ie23cEcUJG/V3TVHA=;
        b=RbvxLgDZuzVPlsJSne/oN46/W8XaFZ+fHaW0Xt9092jg384p0xhCsgpzI5OvqAOoIS
         VTvjhquSWgF7zT/yK+Hq3g5m3GT2YXVQ4Hv71Nuz6OZcGXsoLCDAoFrYMuMQcNCSUAky
         JYwGvwNOUk6jFiPPf5HoNqfvc4rLKiCMl21p03X8gqpVeE05TvgnQXdUWbjiBXcZooB8
         wBdNW9lGthsJY4T+4nK8nBQbmj3yRY1WYnFeYRM4/7MPn3dbhkYP7zLTIz083TdiJEJn
         oLH+GVzJiJcWlf7+dAEu2OSq7Jnx6xY9gU3z+shT+fE4vi7Jwlo7ANmFlrmscqYg/LgC
         vaMw==
X-Forwarded-Encrypted: i=1; AHgh+RpHuT/wMkBPaNbvyHzYvwpEpqe4e2+zppHHUciaxgttXerkIls1WMgpvAN3lzbK+/VsVE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpSv7wO+4I1V5NF9D7ouUFgPSGUZDWWhSq/07HbG/Opm1eJK8O
	BrUIwDhYN4mWWkVP0EuQ3NvDOM5DtAsZZy8khwyIQwcFlxku3f5DpkzN
X-Gm-Gg: AR+sD12MQSASNPDrzQjeGuRDWVLTb7DDy5ezguz7W8U0QYiYkVY5mHMy5g00HElmLmc
	MU0XoISlVT08bJ1mqN0gqwtcRUdEUsqsuzG75H1cAS7q62dE9NQAIztiiA74KwOETwESu4sfGRh
	956kuB1r/jAgjX9kpRMhmoNKwXaGfehW6QtYts0eD1GCBa/nTj01UvLtGUHe3WrjOR8Bvwy+dZF
	1FBzrr5+2vdsjc15ppHOyDbKYSe335MVY+6pvsrFgX0jcLS0KANphVGsPBqHQ9oX5AHyg+bJNPU
	hUIHAkM1OKWFULOLR9znHKyUJR2N/Mq2YMgbO9p8bWTWP/mQ7U9RNMubCwhyZCDEZKt5VAK6WWr
	8h9HEjVmvv9BMiJq+jb9st3YweUXWP5elW4dR4O44J/XsxufWhC9dX9s71/vXAETatxcl3RF2C6
	AwyNy3JA==
X-Received: by 2002:a17:90b:6cc:b0:387:e0cb:c8da with SMTP id 98e67ed59e1d1-38e4b56bbc3mr23417439a91.35.1784743232483;
        Wed, 22 Jul 2026 11:00:32 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:54::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38ea59459a6sm1069785a91.2.2026.07.22.11.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:00:30 -0700 (PDT)
Date: Wed, 22 Jul 2026 10:55:17 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me, horms@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH net v2] xsk: reject undersized tx_metadata at runtime
 validation
Message-ID: <amEBJTKhUJHaAsBG@devvm7509.cco0.facebook.com>
References: <20260722041326.75199-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260722041326.75199-1-blbllhy@gmail.com>

On 07/22, Cen Zhang (Microsoft) wrote:
> There is no metadata length check before accessing struct xsk_tx_metadata
> fields in both xdp_umem_reg() (registration) and
> xsk_buff_valid_tx_metadata() (runtime).  Thus, an invalid small
> tx_metadata_len (e.g. 8 bytes) passes registration and later causes an
> out-of-bounds read when xsk_skb_metadata() accesses fields beyond the
> declared metadata region.
> 
> KASAN reports this as:
> 
>   BUG: KASAN: vmalloc-out-of-bounds in xsk_skb_metadata+0x4b2/0x500
>   Read of size 8 at addr ffffc90000f11000 by task exploit/148
> 
>   xsk_skb_metadata (net/xdp/xsk.c:837)
>   xsk_build_skb (net/xdp/xsk.c)
>   __xsk_generic_xmit (net/xdp/xsk.c)
>   xsk_sendmsg (net/xdp/xsk.c)
> 
> Fixing at registration time would break backward compatibility with older
> userspace applications, so apply a runtime length check in
> xsk_buff_valid_tx_metadata() that validates tx_metadata_len against the
> fields required by the enabled flags.
> 
> Fixes: 341ac980eab9 ("xsk: Support tx_metadata_len")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Link: https://lore.kernel.org/all/20260720155210.34229-1-blbllhy@gmail.com/
> Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
> V2:
>  - Change to runtime per-flag length check as suggested by Stanislav.

Hmm, the AI review points out another set of TOCTOU issues :-/ I wonder
whether want to go all in and rewrite the users to have a copy
of metadata? Something like the following below, build tested only,
any issues with that?

(xsk_tx_metadata_to_compl (!meta) check is still buggy? not sure)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 17f213cc93e4..94f2a32917d2 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -604,7 +604,7 @@ struct igc_xdp_buff {
 
 struct igc_metadata_request {
 	struct igc_tx_buffer *tx_buffer;
-	struct xsk_tx_metadata *meta;
+	struct xsk_tx_metadata meta;
 	struct igc_ring *tx_ring;
 	u32 cmd_type;
 	u16 used_desc;
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index e6e9441fc3d4..ec51a5b1051d 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2961,7 +2961,7 @@ static void igc_xsk_request_timestamp(void *_priv)
 		 * metadata area. It is the location to store the value of
 		 * tx hardware timestamp.
 		 */
-		xsk_tx_metadata_to_compl(meta_req->meta, &tstamp->xsk_meta);
+		xsk_tx_metadata_to_compl(&meta_req->meta, &tstamp->xsk_meta);
 
 		/* Set timestamp bit based on the _TSTAMP(_X) bit. */
 		tx_flags |= tstamp->flags;
@@ -3059,7 +3059,7 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 	 */
 	while (budget >= 4 && xsk_tx_peek_desc(pool, &xdp_desc)) {
 		struct igc_metadata_request meta_req;
-		struct xsk_tx_metadata *meta = NULL;
+		struct xsk_tx_metadata meta = {};
 		struct igc_tx_buffer *bi;
 		u32 olinfo_status;
 		dma_addr_t dma;
@@ -3071,7 +3071,7 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 		olinfo_status = xdp_desc.len << IGC_ADVTXD_PAYLEN_SHIFT;
 
 		dma = xsk_buff_raw_get_dma(pool, xdp_desc.addr);
-		meta = xsk_buff_get_metadata(pool, xdp_desc.addr);
+		xsk_buff_read_metadata(pool, xdp_desc.addr, &meta);
 		xsk_buff_raw_dma_sync_for_device(pool, dma, xdp_desc.len);
 		bi = &ring->tx_buffer_info[ntu];
 
@@ -3079,7 +3079,7 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 		meta_req.tx_buffer = bi;
 		meta_req.meta = meta;
 		meta_req.used_desc = 0;
-		xsk_tx_metadata_request(meta, &igc_xsk_tx_metadata_ops,
+		xsk_tx_metadata_request(&meta, &igc_xsk_tx_metadata_ops,
 					&meta_req);
 
 		/* xsk_tx_metadata_request() may have updated next_to_use */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
index 8aeab4b21035..1721a0a9220a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
@@ -66,7 +66,7 @@ static void mlx5e_xsk_tx_post_err(struct mlx5e_xdpsq *sq,
 bool mlx5e_xsk_tx(struct mlx5e_xdpsq *sq, unsigned int budget)
 {
 	struct xsk_buff_pool *pool = sq->xsk_pool;
-	struct xsk_tx_metadata *meta = NULL;
+	struct xsk_tx_metadata meta = {};
 	union mlx5e_xdp_info xdpi;
 	bool work_done = true;
 	bool flush = false;
@@ -99,13 +99,13 @@ bool mlx5e_xsk_tx(struct mlx5e_xdpsq *sq, unsigned int budget)
 		xdptxd.dma_addr = xsk_buff_raw_get_dma(pool, desc.addr);
 		xdptxd.data = xsk_buff_raw_get_data(pool, desc.addr);
 		xdptxd.len = desc.len;
-		meta = xsk_buff_get_metadata(pool, desc.addr);
+		xsk_buff_read_metadata(pool, desc.addr, &meta);
 
 		xsk_buff_raw_dma_sync_for_device(pool, xdptxd.dma_addr, xdptxd.len);
 
 		ret = INDIRECT_CALL_2(sq->xmit_xdp_frame, mlx5e_xmit_xdp_frame_mpwqe,
 				      mlx5e_xmit_xdp_frame, sq, &xdptxd,
-				      check_result, meta);
+				      check_result, &meta);
 		if (unlikely(!ret)) {
 			if (sq->mpwqe.wqe)
 				mlx5e_xdp_mpwqe_complete(sq);
@@ -116,7 +116,7 @@ bool mlx5e_xsk_tx(struct mlx5e_xdpsq *sq, unsigned int budget)
 			if (xp_tx_metadata_enabled(sq->xsk_pool)) {
 				struct xsk_tx_metadata_compl compl;
 
-				xsk_tx_metadata_to_compl(meta, &compl);
+				xsk_tx_metadata_to_compl(&meta, &compl);
 				XSK_TX_COMPL_FITS(void *);
 
 				mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 562d20830b94..217134559d41 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2707,7 +2707,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 
 	for (; budget > 0; budget--) {
 		struct stmmac_metadata_request meta_req;
-		struct xsk_tx_metadata *meta = NULL;
+		struct xsk_tx_metadata meta = {};
 		dma_addr_t dma_addr;
 		bool set_ic;
 
@@ -2732,7 +2732,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 
 		tx_desc = stmmac_get_tx_desc(priv, tx_q, entry);
 		dma_addr = xsk_buff_raw_get_dma(pool, xdp_desc.addr);
-		meta = xsk_buff_get_metadata(pool, xdp_desc.addr);
+		xsk_buff_read_metadata(pool, xdp_desc.addr, &meta);
 		xsk_buff_raw_dma_sync_for_device(pool, dma_addr, xdp_desc.len);
 
 		/* To return XDP buffer to XSK pool, we simple call
@@ -2761,7 +2761,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		meta_req.set_ic = &set_ic;
 		meta_req.tbs = tx_q->tbs;
 		meta_req.edesc = &tx_q->dma_entx[entry];
-		xsk_tx_metadata_request(meta, &stmmac_xsk_tx_metadata_ops,
+		xsk_tx_metadata_request(&meta, &stmmac_xsk_tx_metadata_ops,
 					&meta_req);
 		if (set_ic) {
 			tx_q->tx_count_frames = 0;
@@ -2775,7 +2775,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 
 		stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
 
-		xsk_tx_metadata_to_compl(meta,
+		xsk_tx_metadata_to_compl(&meta,
 					 &tx_q->tx_skbuff_dma[entry].xsk_meta);
 
 		tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
diff --git a/include/net/libeth/xsk.h b/include/net/libeth/xsk.h
index 82b5d21aae87..e2fa6bf6b1b3 100644
--- a/include/net/libeth/xsk.h
+++ b/include/net/libeth/xsk.h
@@ -205,7 +205,7 @@ __libeth_xsk_xmit_fill_buf_md(const struct xdp_desc *xdesc,
 	BUILD_BUG_ON(!__builtin_constant_p(tmo == libeth_xsktmo));
 	tmo = tmo == libeth_xsktmo ? &__libeth_xsktmo : tmo;
 
-	xsk_tx_metadata_request(ctx.meta, tmo, &desc);
+	xsk_tx_metadata_request(&ctx.meta, tmo, &desc);
 
 	return desc;
 }
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index ebac60a3d8a1..eb2645a88934 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -163,7 +163,7 @@ static inline void xsk_tx_metadata_request(const struct xsk_tx_metadata *meta,
 					   const struct xsk_tx_metadata_ops *ops,
 					   void *priv)
 {
-	if (!meta)
+	if (!meta || !meta->flags)
 		return;
 
 	if (ops->tmo_request_launch_time)
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 46797645a0c2..925c25bad57c 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -259,31 +259,42 @@ xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
 		XDP_TXMD_FLAGS_LAUNCH_TIME | \
 	0)
 
-static inline bool
-xsk_buff_valid_tx_metadata(const struct xsk_tx_metadata *meta)
+static inline int
+xsk_buff_read_tx_metadata(const struct xsk_buff_pool *pool,
+			  void *data,
+			  struct xsk_tx_metadata *meta)
 {
-	return !(meta->flags & ~XDP_TXMD_FLAGS_VALID);
-}
-
-static inline struct xsk_tx_metadata *
-__xsk_buff_get_metadata(const struct xsk_buff_pool *pool, void *data)
-{
-	struct xsk_tx_metadata *meta;
+	struct xsk_tx_metadata *p;
+	u64 flags = 0;
 
 	if (!pool->tx_metadata_len)
-		return NULL;
+		return 0;
+
+	/* covers flags, XDP_TXMD_FLAGS_CHECKSUM & XDP_TXMD_FLAGS_TIMESTAMP */
+	if (unlikely(pool->tx_metadata_len < 16))
+		return -EINVAL;
+
+	p = data - pool->tx_metadata_len;
+	flags = READ_ONCE(p->flags);
+
+	if (flags & ~XDP_TXMD_FLAGS_VALID)
+		return -EINVAL;
 
-	meta = data - pool->tx_metadata_len;
-	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
-		return NULL; /* no way to signal the error to the user */
+	if (flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
+		if (pool->tx_metadata_len < offsetofend(struct xsk_tx_metadata, request.launch_time))
+			return -EINVAL;
 
-	return meta;
+	memcpy(meta, p, min(pool->tx_metadata_len, sizeof(struct xsk_tx_metadata)));
+	meta->flags = flags;
+	return 0;
 }
 
-static inline struct xsk_tx_metadata *
-xsk_buff_get_metadata(struct xsk_buff_pool *pool, u64 addr)
+static inline void xsk_buff_read_metadata(const struct xsk_buff_pool *pool,
+					  u64 addr,
+					  struct xsk_tx_metadata *meta)
 {
-	return __xsk_buff_get_metadata(pool, xp_raw_get_data(pool, addr));
+	if (xsk_buff_read_tx_metadata(pool, xp_raw_get_data(pool, addr), meta) < 0)
+		meta->flags = 0;
 }
 
 static inline void xsk_buff_dma_sync_for_cpu(struct xdp_buff *xdp)
@@ -469,21 +480,18 @@ xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
 	return (struct xdp_desc_ctx){ };
 }
 
-static inline bool xsk_buff_valid_tx_metadata(struct xsk_tx_metadata *meta)
+static inline int
+xsk_buff_read_tx_metadata(const struct xsk_buff_pool *pool,
+			  void *data,
+			  struct xsk_tx_metadata *meta)
 {
 	return false;
 }
 
-static inline struct xsk_tx_metadata *
-__xsk_buff_get_metadata(const struct xsk_buff_pool *pool, void *data)
-{
-	return NULL;
-}
-
-static inline struct xsk_tx_metadata *
-xsk_buff_get_metadata(struct xsk_buff_pool *pool, u64 addr)
+static inline void xsk_buff_read_metadata(const struct xsk_buff_pool *pool,
+					  u64 addr,
+					  struct xsk_tx_metadata *meta)
 {
-	return NULL;
 }
 
 static inline void xsk_buff_dma_sync_for_cpu(struct xdp_buff *xdp)
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index ccb3b350001f..71992b9e680d 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -141,12 +141,12 @@ void xp_dma_unmap(struct xsk_buff_pool *pool, unsigned long attrs);
 struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool);
 u32 xp_alloc_batch(struct xsk_buff_pool *pool, struct xdp_buff **xdp, u32 max);
 bool xp_can_alloc(struct xsk_buff_pool *pool, u32 count);
-void *xp_raw_get_data(struct xsk_buff_pool *pool, u64 addr);
+void *xp_raw_get_data(const struct xsk_buff_pool *pool, u64 addr);
 dma_addr_t xp_raw_get_dma(struct xsk_buff_pool *pool, u64 addr);
 
 struct xdp_desc_ctx {
 	dma_addr_t dma;
-	struct xsk_tx_metadata *meta;
+	struct xsk_tx_metadata meta;
 };
 
 struct xdp_desc_ctx xp_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr);
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index b970f30ea9b9..dbe4ddae30e8 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -802,19 +802,17 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 			    struct xdp_desc *desc, struct xsk_buff_pool *pool,
 			    u32 hr)
 {
-	struct xsk_tx_metadata *meta = NULL;
+	struct xsk_tx_metadata meta = {};
 	u16 csum_start, csum_offset;
+	int ret;
 
-	if (unlikely(pool->tx_metadata_len == 0))
-		return -EINVAL;
-
-	meta = buffer - pool->tx_metadata_len;
-	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
-		return -EINVAL;
+	ret = xsk_buff_read_tx_metadata(pool, buffer, &meta);
+	if (ret < 0)
+		return ret;
 
-	if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
-		csum_start = READ_ONCE(meta->request.csum_start);
-		csum_offset = READ_ONCE(meta->request.csum_offset);
+	if (meta.flags & XDP_TXMD_FLAGS_CHECKSUM) {
+		csum_start = READ_ONCE(meta.request.csum_start);
+		csum_offset = READ_ONCE(meta.request.csum_offset);
 
 		if (unlikely(csum_start + csum_offset +
 			     sizeof(__sum16) > desc->len))
@@ -833,9 +831,9 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 		}
 	}
 
-	if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
-		skb->skb_mstamp_ns = meta->request.launch_time;
-	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
+	if (meta.flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
+		skb->skb_mstamp_ns = meta.request.launch_time;
+	xsk_tx_metadata_to_compl(&meta, &skb_shinfo(skb)->xsk_meta);
 
 	return 0;
 }
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 1f28a9641571..c9f05835e433 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -735,7 +735,7 @@ static void *__xp_raw_get_data(const struct xsk_buff_pool *pool, u64 addr)
 	return pool->addrs + addr;
 }
 
-void *xp_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
+void *xp_raw_get_data(const struct xsk_buff_pool *pool, u64 addr)
 {
 	return __xp_raw_get_data(pool, __xp_raw_get_addr(pool, addr));
 }
@@ -773,7 +773,7 @@ struct xdp_desc_ctx xp_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
 	addr = __xp_raw_get_addr(pool, addr);
 
 	ret.dma = __xp_raw_get_dma(pool, addr);
-	ret.meta = __xsk_buff_get_metadata(pool, __xp_raw_get_data(pool, addr));
+	xsk_buff_read_metadata(pool, addr, &ret.meta);
 
 	return ret;
 }
