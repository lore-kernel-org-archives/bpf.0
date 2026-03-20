Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266033CD8BB;
	Fri, 20 Mar 2026 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026147; cv=none; b=AZ21eYGm5w4FzAQFJqYTj1r1dN7N0L3XdWv3gZpOwi/fChLY8ev2w6JYlZ7TommknxcBOq89mSsf0ggGJK1haaWRhXr3QPZsnx6VAEnLxQc78nSrv+wJpviowl59m6P1fNaFFIFxUI7gYMHJ0cFF4pz4uZU8IunAD3mNinHtzpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026147; c=relaxed/simple;
	bh=OfqPN9mSDoWv8ARtiyLIw5c2e8KKvKcDWx3tLXQNcb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdvoV5G3TMXumVyKIZgX8FPUUYpWGCHY0p0En9toXT9wL+TDlcKDPlVWCtvS+Jc0S+xbYAzODlKjTa2YWvloQwokcjGjrCviJ5da1w/Krau7UOKNqvp/RWxPLR7sHcZlsG3rNQBa1O8Qa3UoIJ0P5jTTGPhFE2wWxWdkjbPAamA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oo2MuGlK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oo2MuGlK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BE4C19425;
	Fri, 20 Mar 2026 17:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774026146;
	bh=OfqPN9mSDoWv8ARtiyLIw5c2e8KKvKcDWx3tLXQNcb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oo2MuGlKgAX9A2COl7NtRyYUKFVEKK0O94zMonVfXhx3EMheLWC4Pp3kYfkTnSj1I
	 +liIuY/gm5iKc+0cpG5gzC4FJZYRE76K4WqEAJTZxVDE8kFkbCx0MmiIHcpiqcvNlE
	 lJWHAbJTqEnS6TItjLk/hQrtSy6shBVpoG937koVZwDzX/ZJCHgqS2pv0TM+BVWDHI
	 Nd/YxHhNcuVYBN8pXdzBd7AUCa3oGUnbCU2gW8w0gpXWF4H0fID8xp6ITvNvunrPG2
	 7R5MRUj0vKEVbGk3Ge5gbhKBsMzuGfXOuUHi3tP8ewN9NmJjrdKM1xdf3pN2K5+SjD
	 6JyGaud83gBHg==
From: Simon Horman <horms@kernel.org>
To: nb@tipi-net.de
Cc: Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	opendmb@gmail.com,
	john.fastabend@gmail.com,
	florian.fainelli@broadcom.com,
	daniel@iogearbox.net,
	arnd@arndb.de,
	bcm-kernel-feedback-list@broadcom.com,
	vikas.gupta@broadcom.com,
	bhargava.marreddy@broadcom.com,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	sdf@fomichev.me,
	ebiggers@google.com,
	hawk@kernel.org,
	andrew+netdev@lunn.ch,
	bpf@vger.kernel.org,
	pabeni@redhat.com,
	rajashekar.hudumula@broadcom.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/6] net: bcmgenet: convert RX path to page_pool
Date: Fri, 20 Mar 2026 17:02:01 +0000
Message-ID: <20260320170201.102889-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319115402.353509-2-nb@tipi-net.de>
References: <20260319115402.353509-2-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: bcmgenet: convert RX path to page_pool

Replace the per-packet __netdev_alloc_skb() + dma_map_single() in the
RX path with page_pool, which provides efficient page recycling and
DMA mapping management. This is a prerequisite for XDP support (which
requires stable page-backed buffers rather than SKB linear data).

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

> diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
> index cd7dddeb91dd..e3b9a5272406 100644
> --- a/drivers/net/ethernet/broadcom/Kconfig
> +++ b/drivers/net/ethernet/broadcom/Kconfig

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 482a31e7b72b..7410034d9bdc 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -2747,6 +2758,31 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
>  	netif_napi_add_tx(priv->dev, &ring->napi, bcmgenet_tx_poll);
>  }
>
> +static int bcmgenet_rx_ring_create_pool(struct bcmgenet_priv *priv,
> +					struct bcmgenet_rx_ring *ring)
> +{
> +	struct page_pool_params pp_params = {
> +		.order = 0,
> +		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
> +		.pool_size = ring->size,
> +		.nid = NUMA_NO_NODE,
> +		.dev = &priv->pdev->dev,
> +		.dma_dir = DMA_FROM_DEVICE,
> +		.offset = GENET_XDP_HEADROOM,
> +		.max_len = RX_BUF_LENGTH,
> +	};
> +
> +	ring->page_pool = page_pool_create(&pp_params);
> +	if (IS_ERR(ring->page_pool)) {
> +		int err = PTR_ERR(ring->page_pool);
> +
> +		ring->page_pool = NULL;
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
>  /* Initialize a RDMA ring */
>  static int bcmgenet_init_rx_ring(struct bcmgenet_priv *priv,
>  				 unsigned int index, unsigned int size,
> @@ -2765,10 +2801,17 @@ static int bcmgenet_init_rx_ring(struct bcmgenet_priv *priv,
>  	ring->cb_ptr = start_ptr;
>  	ring->end_ptr = end_ptr - 1;
>
> -	ret = bcmgenet_alloc_rx_buffers(priv, ring);
> +	ret = bcmgenet_rx_ring_create_pool(priv, ring);
>  	if (ret)
>  		return ret;
>
> +	ret = bcmgenet_alloc_rx_buffers(priv, ring);
> +	if (ret) {
> +		page_pool_destroy(ring->page_pool);
> +		ring->page_pool = NULL;
> +		return ret;
> +	}
> +

Does this leak pages if bcmgenet_alloc_rx_buffers() fails partway through?

If bcmgenet_alloc_rx_buffers() successfully allocates pages for the first
k iterations but then page_pool_alloc_pages() fails on iteration k+1, the
pages stored in cb->rx_page for iterations 0 through k-1 are never
returned to the page pool.

When the error path calls page_pool_destroy(), the pool detects outstanding
pages and defers cleanup, triggering periodic 'stalled pool shutdown' kernel
warnings from page_pool_release_retry().

Then bcmgenet_init_dma's error path calls bcmgenet_free_rx_buffers(), which
skips this ring entirely because ring->page_pool is NULL:

bcmgenet_free_rx_buffers() {
    for (q = 0; q <= priv->hw_params->rx_queues; q++) {
        ring = &priv->rx_rings[q];
        if (!ring->page_pool)
            continue;
        ...
    }
}

Should the error path iterate through the ring's cbs and call
bcmgenet_free_rx_cb() for each one before destroying the page pool?

The old code didn't have this issue because bcmgenet_free_rx_buffers()
iterated all rx_cbs globally without checking for a per-ring page_pool.

[ ... ]
