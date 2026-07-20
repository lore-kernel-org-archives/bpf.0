Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B6B3BF667
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 20:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579080; cv=none; b=b3ihcOwC0m4ZkrNfbkercpzhN7/VRDG64ErJoFLBWBhbOFK4Dk277FpcK/bALwDnJUP7aWeaPtc/8wlNeSwU21GV4EI5ker1A8js+9HSpWm0d2Y9NdVgHo6+SnNRvlRav7YVGHIqmxGm2TN6K7s1qTYwEyZQ+Jufd0EPc/rdE1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579080; c=relaxed/simple;
	bh=QM8Hkd0gMPdHJ/60YK8Qdb4OsDSzn4nGwT7SSTznQ4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l10DOn1+/9BrdfIvqAJF5TKxR34JR565lsMT4EBfyyTg/0PWzyeVMoOYuMTjiV8c+hQPNhVo5aMEoSPTXyXh1Vovon97v8Cx1haLtuKYxDecGfUsoLrPIs1JuFyQqR0/MngzMBXMnc5FuuHiUMRaX194UGI8MKrO8WcNE4xK+os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjHNde3w; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjHNde3w"
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-38e8adc1d70so470065a91.1
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784579078; x=1785183878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DuxloEjMIUr3usgKrRgUoqh61BlU8RAK2e67hxqdRj8=;
        b=SjHNde3wy9EDiajuErQyzpvkeaKM5SEtItxWkH6QNyaRFmQ4bLYdgufCGB/hsYDVnt
         3bDlOLVNA6nTO3qD0CWnrFDdKTXAUnmc/1CSwilvSWWS5lP+AoPkvjjFOhsXz0GxZ4fq
         9TQ4C2Pxudfi9WY7+dSMHPEbfcFX1UnhXJEXJ5azfSYe3t8ApMIrUgFs33gJHIyhmf8P
         aGQBlx2ricP4dsh8EjNaXDukXGe7yFoYIDoOA/DrBO7/8mWKZB5U7a4QqJANnthpwdqP
         5G5+hAiwKPDA4D7CnJf4hsW3RKIGyX++m8nFRgBwZRhCC01Za3JlR2pE52hH+Ai1Qoqc
         E1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784579078; x=1785183878;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DuxloEjMIUr3usgKrRgUoqh61BlU8RAK2e67hxqdRj8=;
        b=SHc1dRptxiZi2Z0530cGFt7LQXEu2Y+seYtZxyP2bWflPtRtUbd2tRHkXSaMJDxC11
         8TiI6V9kyUTonXfxA8PTr1yErtuA3FGQ58PVVdxMgfMiWVCCDEGKXJKF95Q+HBurSsb4
         KKzQGldPRoH45uOqM6nefuBp+biQaGffAHQgn7eyop9h1zq36aDUx+4GdV805T3YYTpe
         MU4dh+FlpvoE/1OFkRn09oW9UCyAwuT141+bv5jvpkeAQavl2GaJoDrXNhX8ggSapIDQ
         mGW3ohgcT+1n/pzd1i4yInpBB6U5ivx8YHWvptja7FYOM/+afuVHpBAwqeIqRN15I8dY
         DE2g==
X-Forwarded-Encrypted: i=1; AHgh+RojQa9dLCdd0WPmFvA0JlVUtzuHoW3Ae8VyzmCXRWHRzqOcH684Zt66KdF1WuWt2mURtNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVDLAtiKcRFdjz9DFxMAKPywBx5zlp6sjEyh0j8Yp/d74K8clU
	H5vrc3FoEdETliX9JH/8+WghalVK+7i3yeHJNCudQ1pkLBuhCUocVGmc
X-Gm-Gg: AR+sD10+KwNG7Qq56FyCmxjwDBQ8Bl3VNOMDHuYxlapHntzUKT/87ykQUwPY3VZXVXj
	3vMGr/gw1WxD71GGuC0KsztIelRwrl9qciWHciny0TDsuLNmNyTQ8WFs2G1wGfNFZCiIKFYjP2B
	6VPikNKtXGUlx0ZFHo4aUSLruOZSdjtSGrXVCJj8P37X2yvK7yN9w6FNQrDihamVqQCeFWAlaSC
	CelmstN3/xiJs4CZ+PCcvinuw95R3xFmHHARKz5wXlG4ygopRErArC2Z4ZjowcTy6SUJW4lvBSE
	GZ0C8/ordNYotfwHlKjIxTpq7xGHCoggFtB3u9Q6B/XwVp90lOIiMS4W7LbsvgrVkEqrdiW2GiZ
	bFYLTHWCWlbOQoT/KlspoerlJIIbKlxZSThtghlvsr4NsZOlp+vUdv/kDYjKKBxfk1vPdv/V7KC
	OtocSGig==
X-Received: by 2002:a17:90b:1350:b0:38e:6a96:447b with SMTP id 98e67ed59e1d1-38e6a96490bmr10631437a91.25.1784579078316;
        Mon, 20 Jul 2026 13:24:38 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e47fe75c1sm1737214a91.1.2026.07.20.13.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 13:24:37 -0700 (PDT)
Date: Mon, 20 Jul 2026 13:24:32 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me, horms@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH net] xsk: reject tx_metadata_len smaller than struct
 xsk_tx_metadata
Message-ID: <al6Czy7Gvhc41RsY@devvm7509.cco0.facebook.com>
References: <20260720155210.34229-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260720155210.34229-1-blbllhy@gmail.com>

On 07/20, Cen Zhang (Microsoft) wrote:
> xdp_umem_reg() validates tx_metadata_len for upper bound (<256) and
> alignment (%8) but not a lower bound.  xsk_skb_metadata() computes
> meta = buffer - pool->tx_metadata_len then unconditionally accesses
> the full 24-byte struct xsk_tx_metadata, so any value less than
> sizeof(struct xsk_tx_metadata) allows an out-of-bounds read.
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
> Add a lower-bound check in xdp_umem_reg() to reject tx_metadata_len
> values that cannot cover the full metadata struct.
> 
> Fixes: 341ac980eab9 ("xsk: Support tx_metadata_len")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
>  net/xdp/xdp_umem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
> index 58da2f4f4397..d16ad9d8f919 100644
> --- a/net/xdp/xdp_umem.c
> +++ b/net/xdp/xdp_umem.c
> @@ -208,7 +208,8 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
>  		return -EINVAL;
>  
>  	if (mr->flags & XDP_UMEM_TX_METADATA_LEN) {
> -		if (mr->tx_metadata_len >= 256 || mr->tx_metadata_len % 8)
> +		if (mr->tx_metadata_len < sizeof(struct xsk_tx_metadata) ||
> +		    mr->tx_metadata_len >= 256 || mr->tx_metadata_len % 8)
>  			return -EINVAL;
>  		umem->tx_metadata_len = mr->tx_metadata_len;
>  	}
> -- 
> 2.53.0
> 

This will make adding new tx metadata types harder (and will require all
userspace to be updated whenever we do so), will the following be
a bit nicer? (but, obviously, paying more per-packet at runtime)

(untested)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 46797645a0c2..b55b878949d5 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -260,9 +260,21 @@ xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
 	0)
 
 static inline bool
-xsk_buff_valid_tx_metadata(const struct xsk_tx_metadata *meta)
+xsk_buff_valid_tx_metadata(const struct xsk_buff_pool *pool,
+			   const struct xsk_tx_metadata *meta)
 {
-	return !(meta->flags & ~XDP_TXMD_FLAGS_VALID);
+	/* covers flags, XDP_TXMD_FLAGS_CHECKSUM & XDP_TXMD_FLAGS_TIMESTAMP */
+	if (unlikely(pool->tx_metadata_len < 16))
+		return false;
+
+	if (unlikely(meta->flags & ~XDP_TXMD_FLAGS_VALID))
+		return false;
+
+	if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
+		if (unlikely(pool->tx_metadata_len < offsetofend(struct xsk_tx_metadata, launch_time)))
+			return false;
+
+	return true;
 }
 
 static inline struct xsk_tx_metadata *
@@ -274,7 +286,7 @@ __xsk_buff_get_metadata(const struct xsk_buff_pool *pool, void *data)
 		return NULL;
 
 	meta = data - pool->tx_metadata_len;
-	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
+	if (unlikely(!xsk_buff_valid_tx_metadata(pool, meta)))
 		return NULL; /* no way to signal the error to the user */
 
 	return meta;
@@ -469,7 +481,8 @@ xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
 	return (struct xdp_desc_ctx){ };
 }
 
-static inline bool xsk_buff_valid_tx_metadata(struct xsk_tx_metadata *meta)
+static inline bool xsk_buff_valid_tx_metadata(const struct xsk_buff_pool *pool,
+					      struct xsk_tx_metadata *meta)
 {
 	return false;
 }
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index b970f30ea9b9..75b2c97e41e4 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -809,7 +809,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 		return -EINVAL;
 
 	meta = buffer - pool->tx_metadata_len;
-	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
+	if (unlikely(!xsk_buff_valid_tx_metadata(pool, meta)))
 		return -EINVAL;
 
 	if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
