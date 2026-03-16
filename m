Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FCA2874FA
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 22:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773701596; cv=none; b=WWgS1rAaxm0p0ceYgvHiqpygkhs2Ucqdk+VprrXqsB+HiEMRtfMfUZKpELvGqJc3fey9ajEme1A/jwsrYaroyTVLzNJpOKvuU9r0iUyw7tRE7UEZA415resPo8nWiOIZMmuqLGDa+9EGE8v/3szqC5jxKiqQmuL7GXthD8BHNPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773701596; c=relaxed/simple;
	bh=r9nMZ4oL4c60qS4oEzPOBEWAd3FYOWHjGiDNryvAcx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RM2f7LEMrhm8r4oyq+Yau324K0wHUt09tGtMElIi5YuCuHH+X0kdSASypJLQ2w2gH1Oz87LI8vX0H6HWwD3tnzrMdeHXlQpbO1IfFxFzApdm4FgwFDenZRM0AUwJRUuNB5gQLSVS/X6FKnwEXRlrP8Cadoc/rwxOHl6jyYI5LwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHaPdn8F; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHaPdn8F"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-128d7db88b9so6109323c88.0
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 15:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773701594; x=1774306394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m/q5LNtkjNUM0D1hp5BMddjA+4zQ6koHk0bHDpjftyQ=;
        b=gHaPdn8F8gQOi8fztzjnazHoEItcmzQ3v9wiQdMRef1lGI9IId6t9+RV5N71R7hDVO
         miFkocr3DYCc50akivko0O13gsoODPwvLjf+do75gXwBERVJEbVcgyrclzjW02XYvHAB
         j6yBqY870hC1cbjbOCLuzQOdhVJShdqMskpRQecjbdEi7+lrMnf0GjXdhEBQhzwwWsZz
         otUy7hcy7fKjyKOe4cjRVShHIlywiqE7rb3z9u9VDL+wcwPnbUuAS+9LmB9ls/V0nw+S
         YxkFm9F8kPZAqr1Udjc3YX5wBxklF7Y6kIvxIOUqackDCo4hofxGytnYDGsZtI0UIlMs
         dgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773701594; x=1774306394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/q5LNtkjNUM0D1hp5BMddjA+4zQ6koHk0bHDpjftyQ=;
        b=cNKO8K6IiGwQyBVfhx0FS+1+aU2n30GNvRPvmvgwCf2Jacjzuot4J5XYPxaE1K9Ks6
         mkSJqUDcM22rhUeqJwX7L4a8QZygrSbQFLdg7d0CDO3J9gC4S6bgrSIKOE+f/AUE7AdJ
         MeGgobuDkpW4DLhsE0Mzd7k4OTcU7xn8Dc4Q8b3Hi4SbS8g6fgfIR6iHd8UtM4KgADPy
         CojR8hx9GDl0SM9uFwgtlVTpPm2Phulod6kXKi+6amQi6fqmpfCgPN4flkn59TenVQQ8
         y492U3Up1BjKaYrXXzNtQ30Qr8jCZeLtbU3fmTkpetJSudmUfViez/qIdp9BiJtzE/jd
         nwnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDpQ6RdhdQkBvShWVW/qmIHn2lzG/1j5a6rXlSXp0P1WNc3bTQKZLManNiTQtxi8La/1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhRTXk5Sh3ZcQfExsGbwb7kGBJcHnCvmowY50XJsA8tM3ba4es
	W1OzlzSJOGxc/pcmtKZIXInY8ahiXxllpl+JGquxx+38/zM84hD0ED4=
X-Gm-Gg: ATEYQzynsAG1qilz/M9T8PEdowd+dqwHAVVg5tZhDIv51sOGWhzk3CcbeOvzCjbdctv
	v5spZ/7kabQ92xpY9qUbhlddAD5mN2pvNF+LRGh29N70/FuxOBLnkkrbCEx93SV4TgnsvXtPEK7
	xwPgCZAmxR5+fNcNeKW4ckuU49OYBpNb7Axr6/GM2RbdHKeZRP7Y+8schYBHquuYa3g/j250Hsk
	s6GWK58xKpSvDLp0x3yeby9IZz9IP26Uv3UT9xR6zKBwqedeW/vtdquci7B0C7+bK1hYXuHgZFm
	KyU8ZgE+JeyXrxkCylmhRw/0s0jFi2iZVCg0vpOY03T/bYR0J9pp3fWB3BzBofyqe52uNhOn5y4
	f632rvAbUBCZRGg8gf47x+zGCYIpIadwN34OZDs4q8jsD6OBVfNUtnV6hXbDCpuue2qE9HEDzLm
	uQh7HzBT1OsBoMUZJWAPuYxn81T8OafMRnqAcehcbKriZYMuSM87Egw1U0j8MpefyDZ0khJUvss
	GvicxftAg55gKlpU0N3D3xubNOe
X-Received: by 2002:a05:7022:f97:b0:128:d4be:7433 with SMTP id a92af1059eb24-128f3dd31e1mr6140690c88.34.1773701593796;
        Mon, 16 Mar 2026 15:53:13 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f63b6a34sm16783483c88.14.2026.03.16.15.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 15:53:13 -0700 (PDT)
Date: Mon, 16 Mar 2026 15:53:12 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	larysa.zaremba@intel.com, aleksander.lobakin@intel.com
Subject: Re: [PATCH net 1/6] xsk: respect tailroom for ZC setups
Message-ID: <abiJ2C_q62bn7EC3@mini-arch>
References: <20260316174550.462177-1-maciej.fijalkowski@intel.com>
 <20260316174550.462177-2-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316174550.462177-2-maciej.fijalkowski@intel.com>

On 03/16, Maciej Fijalkowski wrote:
> Multi-buffer XDP stores information about frags in skb_shared_info that
> sits at the tailroom of a packet. The storage space is reserved via
> xdp_data_hard_end():
> 
> 	((xdp)->data_hard_start + (xdp)->frame_sz -	\
> 	 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
> 
> and then we refer to it via macro below:
> 
> static inline struct skb_shared_info *
> xdp_get_shared_info_from_buff(const struct xdp_buff *xdp)
> {
>         return (struct skb_shared_info *)xdp_data_hard_end(xdp);
> }
> 
> Currently we do not respect this tailroom space in multi-buffer AF_XDP
> ZC scenario. To address this, introduce xsk_pool_get_tailroom() and use
> it within xsk_pool_get_rx_frame_size() which is used in ZC drivers to
> configure length of HW Rx buffer.
> 
> xsk_pool_get_tailroom() is only reserving necessary space when pool is
> zc and underlying netdev supports zc multi-buffer. Since this function
> relies on pool->umem->zc setting, set it before ndo_bpf during zc
> configuration, so that driver that actually calls
> xsk_pool_get_rx_frame_size() inside ndo_bpf will get correct tailroom
> value.
> 
> Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  include/net/xdp_sock_drv.h | 21 ++++++++++++++++++++-
>  net/xdp/xsk_buff_pool.c    |  3 ++-
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index 6b9ebae2dc95..13b2aae00737 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -41,6 +41,19 @@ static inline u32 xsk_pool_get_headroom(struct xsk_buff_pool *pool)
>  	return XDP_PACKET_HEADROOM + pool->headroom;
>  }
>  
> +static inline u32 xsk_pool_get_tailroom(struct xsk_buff_pool *pool)
> +{
> +	struct xdp_umem *umem = pool->umem;
> +
> +	/* Reserve tailroom only for zero-copy pools that opted into
> +	 * multi-buffer. The reserved area is used for skb_shared_info,
> +	 * matching the XDP core's xdp_data_hard_end() layout.
> +	 */
> +	if (umem->zc && (umem->flags & XDP_UMEM_SG_FLAG))
> +		return SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +	return 0;
> +}
> +
>  static inline u32 xsk_pool_get_chunk_size(struct xsk_buff_pool *pool)
>  {
>  	return pool->chunk_size;
> @@ -48,7 +61,8 @@ static inline u32 xsk_pool_get_chunk_size(struct xsk_buff_pool *pool)
>  
>  static inline u32 xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
>  {
> -	return xsk_pool_get_chunk_size(pool) - xsk_pool_get_headroom(pool);
> +	return xsk_pool_get_chunk_size(pool) - xsk_pool_get_headroom(pool) -
> +	       xsk_pool_get_tailroom(pool);
>  }
>  
>  static inline u32 xsk_pool_get_rx_frag_step(struct xsk_buff_pool *pool)
> @@ -332,6 +346,11 @@ static inline u32 xsk_pool_get_headroom(struct xsk_buff_pool *pool)
>  	return 0;
>  }

[..]
 
> +static inline u32 xsk_pool_get_tailroom(struct xsk_buff_pool *pool)
> +{
> +	return 0;
> +}

Not sure it's needed? xsk_pool_get_tailroom is only used by
CONFIG_XDP_SOCKETS' version of xsk_pool_get_rx_frame_size.

>  static inline u32 xsk_pool_get_chunk_size(struct xsk_buff_pool *pool)
>  {
>  	return 0;
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 37b7a68b89b3..2cfc19e363e3 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -213,6 +213,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  	bpf.command = XDP_SETUP_XSK_POOL;
>  	bpf.xsk.pool = pool;
>  	bpf.xsk.queue_id = queue_id;
> +	pool->umem->zc = true;
>  
>  	netdev_ops_assert_locked(netdev);
>  	err = netdev->netdev_ops->ndo_bpf(netdev, &bpf);
> @@ -224,13 +225,13 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  		err = -EINVAL;
>  		goto err_unreg_xsk;
>  	}
> -	pool->umem->zc = true;
>  	pool->xdp_zc_max_segs = netdev->xdp_zc_max_segs;
>  	return 0;
>  
>  err_unreg_xsk:
>  	xp_disable_drv_zc(pool);
>  err_unreg_pool:
> +	pool->umem->zc = false;
>  	if (!force_zc)
>  		err = 0; /* fallback to copy mode */
>  	if (err) {

I'm not super familiar with the shared umem patch, but is it safe to
unconditionally undo pool->umem->zc = false here? xp_assign_dev_shared
looks at this umem->zc flag.. Presumably other places do as well on
teardown?
