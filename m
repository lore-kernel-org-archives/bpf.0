Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CF43AAF6B
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341328; cv=none; b=miua8T3C48fKSnJApb15D5Rfxli1ywl13xX06av7sXGSbln7J7kKWPKmMdXoX/za6lwVuBqLed3TDxHIuCFWqWxCTJ7w8kuldQ6x7tI2izJinfGQ5/qntjWqIfIh4UWw8yIgrSxvUyOi+JF8h+WpRYlBI3yzQi+HpXFVfgthO84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341328; c=relaxed/simple;
	bh=xz3GfScgjQn6YWdU113ZIQs64S4ynT5uCuPT+HFsPSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxzqLWl0yOzsao1YAKU+TkvtXa8VWDNwKOeVtKOttP+WztKEq52lD7X5cvx9h7bYa0M78shOG34H4+OwkouvfcoyzdXeRLCDIVD7fGqbxUGBSIag0Qr/IFkZhWiIWzcJTYlQ6rBPKB8Ty2WC+W0gWvMtfBEETAP/v5n9zMhBKEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1zErLkD; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1zErLkD"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2cf41b07aceso5768875ad.0
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 09:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785341322; x=1785946122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eoTOybwELG8BsdulcXSV9k7fS3IZ3nIiKDfqyFmy64o=;
        b=b1zErLkDmNbWt+zteJaDU7kApuC0meDjhOfJ4ScFBKyAeUTBtxe7F4AwTEUC/5eCCF
         m2tqwb2OEpmjBPG6piBQMF7kIvXVKTB63IWU1eQoe+tY0VaCh0CX5qkOJVMZngbjQJq9
         MPwMrlgdKa/SMdNOUQKbasdE39LTBtjAaaWYNN8jvnDbEiSfYcJwXhDwNfSN7D7TrpAd
         /MKbDG9v9vMSM5LPRXcw5kM4mPNcKwP3wi8OoqeF58mrvNrzkrD4jeLyeipKbFelxaQX
         rQjsFrzkdGCsAllJfmKWSLC0OuCY7INSH3SJP8IkpRooQtFIlHFU4dxIEnUpxTkRV5UL
         ukxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785341322; x=1785946122;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eoTOybwELG8BsdulcXSV9k7fS3IZ3nIiKDfqyFmy64o=;
        b=HYPHDzDkZJjC4ynAgm+9GOiKMs+jqmzfjSjjJ2D3q6G3m4hs688ur/EA9gFQlwAdgP
         btMNtswjKikDb34ZxW6VA8x8SE0t5iyQC/HRBUDNLUmcvgTeQWOwkIDPMVsLPX+e1mh+
         g5or6PZoQRrIArCRMTMAVX2+qOFN7J3ivPv8EkLsZGfqTDRbCxad+zJsFdXHkK61duYk
         z9IDRC9XZvZ8mYN3bTWXPC0LFJ/ayb7oAcl1vP8s/OpPJmqlqsbhLyTfJiIlISwZ8ZIM
         oMTHgbTUJtlccBRqhwxAsZK65nliHWnWDbennSpPB6bPtvBq2PPYWuc4B4Nv0rVZJeSO
         TZWg==
X-Gm-Message-State: AOJu0YyLz1u8LA+82RWUQVPlyabY5NYYlj2wWrkS9cpVjGFP/0PrcSNT
	HZ0dJ2D1VjAXeEYiOgC0o/RiRNzSZAOkpb9C7+Botwaq6YVfN7UAj/e+
X-Gm-Gg: AR+sD11Spf6JfdH6jBHGB2pduCeVEUk6O80fZ/1AXINDOCS3mCXhARQjAyKyUCJQ1fD
	yIgr+nGYV51zuL8/EaLYilJ7cwrbklA8rQva+aJo882mMET8QowL8CLDdmGdk44uA9ylOkkxIqb
	L2cbPgxiXkpCVS9Y2LWHuWQNu4WKcm6j2jjLPQ1gscQ5vckF+SSZZZzY0jTft7TSkIQRApZ9ezR
	ZKkpyIUW6AHLVr0i1JcM5raI3b8s0B8eWhLg2rtZDtG6QaMjYBhpeKxzcqe7dLo6mmMTsp0aAjK
	aZadgSQuN7+57xKjVwZKztFwDIP7ekbxjFHTtvAitxtkIKkV2LCmT1QcWKLX82FXU0XglJX26TW
	7CNhrYcW9qyb5Y9uAzHM+bprKMtpudh8auTeBuADCqu5kypmlsEXs3XZcZ0ayYxeKo7JsFuti6p
	ky5O6C5tfoV6R3iirkwht/Y5qNyj/Spd9yWjEvZJAQ/r8wZrQU0D9i8g==
X-Received: by 2002:a17:903:1a85:b0:2ca:ea56:7a58 with SMTP id d9443c01a7336-2d015d95234mr81144815ad.37.1785341322345;
        Wed, 29 Jul 2026 09:08:42 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a4596esm13695435ad.23.2026.07.29.09.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 09:08:41 -0700 (PDT)
Date: Wed, 29 Jul 2026 09:06:25 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net 4/6] xsk: validate launch-time metadata size
Message-ID: <amokauk_mQRaBg_w@devvm7509.cco0.facebook.com>
References: <20260727161959.885642-1-sdf@fomichev.me>
 <20260727161959.885642-5-sdf@fomichev.me>
 <20260728162039.4E6A21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728162039.4E6A21F000E9@smtp.kernel.org>

On 07/28, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Time-of-Check to Time-of-Use (TOCTOU) race condition in zero-copy TX metadata validation.
> 
> Pre-existing issues:
> - [Critical] struct xsk_tx_metadata has a layout mismatch between 32-bit and 64-bit architectures, breaking 32-bit userspace compatibility.
> - [High] Calling `skb_checksum_help()` on an empty or fragmented SKB in AF_XDP zero-copy path drops packets.
> --
> 
> --- Patch [4]: [PATCH net 4/6] xsk: validate launch-time metadata size ---
> commit 812dce9383d33c01b8fe81b1fbbcc8371998ca62
> Author: Stanislav Fomichev <sdf.kernel@gmail.com>
> 
> xsk: validate launch-time metadata size
> 
> This commit validates the launch-time metadata size by rejecting requests
> when the registered metadata area does not contain the complete field. It
> also snapshots the validated flags for the generic transmit path to avoid
> inconsistent decisions if user space changes the flags concurrently.
> 
> > diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> > index 46797645a0c24..68a7876013572 100644
> > --- a/include/net/xdp_sock_drv.h
> > +++ b/include/net/xdp_sock_drv.h
> [ ... ]
> > @@ -260,21 +260,28 @@ xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
> >  	0)
> >  
> >  static inline bool
> > -xsk_buff_valid_tx_metadata(const struct xsk_tx_metadata *meta)
> > +xsk_buff_valid_tx_metadata(const struct xsk_buff_pool *pool,
> > +			   const struct xsk_tx_metadata *meta, u64 *flags)
> >  {
> > -	return !(meta->flags & ~XDP_TXMD_FLAGS_VALID);
> > +	*flags = READ_ONCE(meta->flags);
> > +	if (*flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
> > +		if (pool->tx_metadata_len <
> > +		    offsetofend(struct xsk_tx_metadata, request.launch_time))
> > +			return false;
> 
> [Severity: Critical]
> This is a pre-existing issue, but the UAPI struct definition in
> include/uapi/linux/if_xdp.h has two __u16 fields followed by a __u64 field
> without explicit padding.
> 
> 64-bit kernels will read launch_time from offset 16, while 32-bit userspace
> writes it to offset 12.
> 
> This newly added validation explicitly expects the 64-bit structure size,
> which solidifies the layout incompatibility.
> 
> Does struct xsk_tx_metadata have a layout mismatch between 32-bit and 64-bit
> architectures that prevents 32-bit userspace compatibility?

Same as the other email, yes, adding padding here is probably a good idea,
will send separately.

> > +	return !(*flags & ~XDP_TXMD_FLAGS_VALID);
> >  }
> >  
> >  static inline struct xsk_tx_metadata *
> >  __xsk_buff_get_metadata(const struct xsk_buff_pool *pool, void *data)
> >  {
> >  	struct xsk_tx_metadata *meta;
> > +	u64 flags;
> >  
> >  	if (!pool->tx_metadata_len)
> >  		return NULL;
> >  
> >  	meta = data - pool->tx_metadata_len;
> > -	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
> > +	if (unlikely(!xsk_buff_valid_tx_metadata(pool, meta, &flags)))
> >  		return NULL; /* no way to signal the error to the user */
> >  
> >  	return meta;
> 
> [Severity: Medium]
> The snapshotted flags are validated for size compliance in
> xsk_buff_valid_tx_metadata() but then discarded, returning the
> un-snapshotted user memory pointer (meta) to the driver.
> 
> Later in the zero-copy driver path, xsk_tx_metadata_request() re-reads
> meta->flags directly from user memory:
> 
> include/net/xdp_sock.h:xsk_tx_metadata_request() {
>     ...
>     if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
>         ops->tmo_request_launch_time(meta->request.launch_time, priv);
>     ...
> }
> 
> Does this create a Time-of-Check to Time-of-Use (TOCTOU) race condition in
> the zero-copy TX metadata validation where userspace can concurrently enable
> launch time after the size validation?

It is explained in the commit message:

  Note that only xsk_skb_metadata is properly using the flags,
  __xsk_buff_get_metadata ignores them. Next commits address that.

> >  }
> [ ... ]
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index fcc6f17f35760..7855ee09c4b64 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -967,15 +967,16 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> >  {
> >  	struct xsk_tx_metadata *meta = NULL;
> >  	u16 csum_start, csum_offset;
> > +	u64 flags;
> >  
> >  	if (unlikely(pool->tx_metadata_len == 0))
> >  		return -EINVAL;
> >  
> >  	meta = buffer - pool->tx_metadata_len;
> > -	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
> > +	if (unlikely(!xsk_buff_valid_tx_metadata(pool, meta, &flags)))
> >  		return -EINVAL;
> >  
> > -	if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
> > +	if (flags & XDP_TXMD_FLAGS_CHECKSUM) {
> >  		csum_start = READ_ONCE(meta->request.csum_start);
> >  		csum_offset = READ_ONCE(meta->request.csum_offset);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but for zero-copy SKB
> construction (xsk_build_skb_zerocopy), the payload is populated strictly in
> fragments, leaving skb_headlen(skb) == 0.
> 
> When a user requests XDP TX metadata with checksum offload on a device
> that uses software checksum fallback (pool->tx_sw_csum),
> skb_checksum_help() fails immediately on such fragmented SKBs by returning
> -EINVAL, which drops the packet.
> 
> Does calling skb_checksum_help() later in this checksum block incorrectly
> assume the SKB has a linearized payload?

We treat skb path as a mostly test-fallback, so I think it is ok.
I'll add a headlen check just to give the users better signals..
