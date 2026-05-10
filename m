Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33175128395;
	Sun, 10 May 2026 18:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778438867; cv=none; b=RZuAz/MoSEwD4ERpbZJxe+bz5ZxXxs/C55TgbJENavLRtX9Z1uJ/jB3g7HKJ4EY4Rw/9Tys4WKYrNqI0iih2A3lC58JztvUptK8mWt2cSH+hiugOndXr4WXj6+fXMXtRmF1qIrJ0RGcg3JvmH0eQw1rXk06kNWh1Fnnlc4u6xn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778438867; c=relaxed/simple;
	bh=SMga2nA30s9tTX18um4CeGX4MymcvD5L24qUMmp/89Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KumaiLexm7Lf+G7zpeYJKhRriS/0iCYn+kEKJmYan0iUAbQSpNqKXNTKBxcxKNEdB9aay0qNisuVQZdQ9w/2PtIkYet1l54S150kzI40dQHS7U4w96eil6rboIjjHInU0v91WYPZweKd+OyS4zg6tNkRTA5qVBes1kpfGSPYhGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwbISCgX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwbISCgX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196E3C2BCB8;
	Sun, 10 May 2026 18:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778438866;
	bh=SMga2nA30s9tTX18um4CeGX4MymcvD5L24qUMmp/89Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IwbISCgXL/wjzw9S0CbJaBpqEPBkeYE9k/SLJbQ7+Eofitt+DmPVikhbqkGuq5fZe
	 MVuQfVWbc8jj5MIUCzXZVyUgkC8wsB2OxF4UKi5evXR6Df31gvgMnUqclS7fWE6fqv
	 8DlwPXQNSy0yjwx0eeTlz2LgXELrcfgAAyXFhRJcz3Nej4pF5W/XoAu/l9zmy5khxx
	 e61xaLkoToBhyLtgshHMpoZHZYuNCCQigjwK8DOnKlWMqbhWtW2jzYZ7bqrvfZ3kyx
	 ULe8QSvDtvluLGKL6wpaT7tLxZpxvEiBUPKPuaLSyWaMb8fkj4LyigKE0H8XLb5vhZ
	 9x6Tk7IfuAVHA==
From: Jakub Kicinski <kuba@kernel.org>
To: nb@tipi-net.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	justin.chen@broadcom.com,
	horms@kernel.org,
	mohsin.bashr@gmail.com,
	opendmb@gmail.com,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	hmohsin@meta.com,
	davem@davemloft.net,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next v9 3/7] net: bcmgenet: add basic XDP support (PASS/DROP)
Date: Sun, 10 May 2026 11:47:23 -0700
Message-ID: <20260510184722.3955938-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506095553.55357-4-nb@tipi-net.de>
References: <20260506095553.55357-4-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: bcmgenet: add basic XDP support (PASS/DROP)

This patch adds XDP program attachment via ndo_bpf and executes XDP
programs in the RX path, handling XDP_PASS by building an SKB from the
xdp_buff and XDP_DROP by returning the page to the page pool.
NETDEV_XDP_ACT_BASIC is advertised in xdp_features.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 5bedc18685b0..ee1d4ecc2b87 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -2326,9 +2381,12 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>  	       (rxpktprocessed < budget)) {
>  		struct status_64 *status;
>  		struct page *rx_page;
> +		unsigned int xdp_act;
>  		unsigned int rx_off;
> -		__be16 rx_csum;
> +		struct xdp_buff xdp;
> +		__be16 rx_csum = 0;
>  		void *hard_start;
> +		int pkt_len;
>  
>  		cb = &priv->rx_cbs[ring->read_ptr];
>  
> @@ -2413,30 +2471,34 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>  			goto next;
>  		} /* error packet */
>  
> -		/* Build SKB from the page - data starts at hard_start,
> -		 * frame begins after RSB(64) + pad(2) = 66 bytes.
> +		pkt_len = len - GENET_RSB_PAD;
> +		if (priv->crc_fwd_en)
> +			pkt_len -= ETH_FCS_LEN;

Can this produce a negative pkt_len on short frames?

The earlier sanity check only rejects len < GENET_RSB_PAD:

    if (unlikely(len > RX_BUF_LENGTH || len < GENET_RSB_PAD)) {
        ...
        goto next;
    }

So len in the range [GENET_RSB_PAD, GENET_RSB_PAD + ETH_FCS_LEN - 1]
(i.e. 66..69) will pass that check.  When crc_fwd_en is set, the
computation then yields pkt_len in [-4, -1].

The driver already tracks such frames via rx_runt_cnt / rx_runt_fcs /
rx_runt_bytes in its MIB counters, so the hardware can deliver them.

> +
> +		/* Save rx_csum before XDP runs - an XDP program
> +		 * could overwrite the RSB via bpf_xdp_adjust_head.
>  		 */
> -		skb = napi_build_skb(hard_start, PAGE_SIZE - XDP_PACKET_HEADROOM);
> -		if (unlikely(!skb)) {
> -			BCMGENET_STATS64_INC(stats, dropped);
> -			page_pool_put_full_page(ring->page_pool, rx_page,
> -						true);
> -			goto next;
> -		}
> +		if (dev->features & NETIF_F_RXCSUM)
> +			rx_csum = (__force __be16)(status->rx_csum & 0xffff);
>  
> -		skb_mark_for_recycle(skb);
> +		xdp_init_buff(&xdp, PAGE_SIZE, &ring->xdp_rxq);
> +		xdp_prepare_buff(&xdp, page_address(rx_page),
> +				 GENET_RX_HEADROOM, pkt_len, true);

A negative pkt_len gets passed here as data_len, so
xdp_prepare_buff() sets xdp->data_end = xdp->data + pkt_len and
xdp->data_end is now below xdp->data.

>  
> -		/* Reserve the RSB + pad, then set the data length */
> -		skb_reserve(skb, GENET_RSB_PAD);
> -		__skb_put(skb, len - GENET_RSB_PAD);
> +		xdp_act = bcmgenet_run_xdp(ring, xdp_prog, &xdp, rx_page);
> +		if (xdp_act != XDP_PASS)
> +			goto next;
>  
> -		if (priv->crc_fwd_en) {
> -			skb_trim(skb, skb->len - ETH_FCS_LEN);
> +		skb = bcmgenet_xdp_build_skb(ring, &xdp);

With no XDP program attached, bcmgenet_run_xdp() unconditionally
returns XDP_PASS and bcmgenet_xdp_build_skb() is called, which does:

    __skb_put(skb, xdp->data_end - xdp->data);

The (ptrdiff_t) xdp->data_end - xdp->data is negative, but __skb_put()
takes an unsigned int, so it becomes a value near 4GB.  __skb_put()
does not bounds-check and unconditionally advances skb->tail and
skb->len by that amount.  The resulting SKB is then handed to
napi_gro_receive().

Would it make sense to tighten the length check to include ETH_FCS_LEN
when crc_fwd_en is set, or validate pkt_len >= 0 before calling
xdp_prepare_buff()?

The pre-patch code happened to be safe here because skb_trim() has
implicit underflow protection:

    if (skb->len > len)
        ...

So removing the skb_trim path drops that protection.
-- 
pw-bot: cr
