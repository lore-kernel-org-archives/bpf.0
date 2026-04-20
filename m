Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5823F3C5538
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 19:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776713676; cv=none; b=aIpnmdNak4nk1Hg0f10ZNeFOQVoHDMG+biu/gwATNg9ui0N2/AqUSJ3DIyLk5AGq0rAVquZQmLMO1Y4Z2hwrFUeByTIGLkR2/TaiVwKiww6bxq32DoYD6uhb4xS/+hHO+TDpWGOG0j6opNzUa73xA9bxr9oI79M6m7+Zhng58fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776713676; c=relaxed/simple;
	bh=JSsKbyP1KNpH3VgRE1/5fzA0f6PCalqc1PPHjq93CEE=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type; b=NHMD1v9vs0g5vC7WgI96mU3Sj5IFT+EcfA1mTDBfk2MBeGqGQu8Yx3yKzRUgNrlJvPG+hmLRRKhvedvl+IGH4Pr74sDCOsq/3ljKZUGFi/Skh4Xf7KT7f9jBPgogOkfiFYnzhzdMvFNDT0Zp9+NCkLm/cJHldVtbVBcr2jnQVkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKoNcu/4; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKoNcu/4"
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7dbd23bc684so2052294a34.2
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 12:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776713674; x=1777318474; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/N6MVvai13qDwjLjyRX2yoaXM7uyr51YiE4c9y/nXV0=;
        b=VKoNcu/4jsmvBtOmsntBF9EbRwgMMuhysTUj+lIB7jcHEbbiWGsWIXwt+lMEbHKXoq
         +RD/Ah6RPZi+9WBueZW15HclScJXfEw6pIvxMGE3qZ1mNvQ0SRlbJBEyHXwi82glzeas
         N3N0wzd/FC4k6INEAG1Tju91lGJEOHx23LnOn9vcgksxfmz5T0lOoA5gAuyW1HG3lF89
         8GGmdYAjY/4u/bKsJ9HjqWbSE8i11rdN5XM0ZEc1fXuTMAZPFnfTzDTCPfNJoZbTKSK4
         56YeHqreEFj4a9Q8Aps8OrlanfvKWKNGizj42lGtcxK7DRCXway//dO2DyebsqB9h22A
         iwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776713674; x=1777318474;
        h=subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/N6MVvai13qDwjLjyRX2yoaXM7uyr51YiE4c9y/nXV0=;
        b=JJup1B7RMmGWpAWXSjbkf0zqc7qyZATAgwo8gx2c57R6GkQNK+Dfjdqr9ADPGI6IUb
         /DfRAAaoWfbqDhs7/vUPNUHAQ7o73/T5yaXVc719UKBSsxDVTriim3b7q3l9Zc1rZ5Mg
         OqrHOdxffLvQdCYxnqTxQbUcp2BNN0DVElv/p7rYyAb6pS3g0F4l6vCSUkmBHdDVL6jm
         qFbpJsEoJfpHeSNWk6VCTBeDr9hdvXuuFCG0fP+JZLFRt+uy31F+5hMYipQ3vguau2XH
         EVOo9diolewqNgNfevn/n8/NXDQ4g49ekPF4ZNX2pCxvDCVsAWnGbO/v2aRemZ2WRnVm
         WO8Q==
X-Gm-Message-State: AOJu0Yz7IYshYluX38DHLUXHc47Xq9ivhXhc/8b4HXTgBmcz5XZ6h2V/
	sTmoj5nkdhUctGSropfKIr4WQBsFesrx2NI3HV/wuZ2IMHuEDiX0d00b
X-Gm-Gg: AeBDievS70t8vw5E3QRpZrMSLXD81F436urBd1gbNpUPkdUAS+5Um96X06UUl5eKLFR
	MS0rlAQ1mQid68f8sCRlVFZfNC4944C/jmACs3YXsiwe5pAVXkKEDlnYsWUTf+CVOs5Z/BZuTkw
	eh1wdg+jsrnpYmhuABvywngGnrr/DP7/7ctBml7HC76gXlbFPVT1eXR85UBKO7LFo+mibfYyEpo
	hrGMuPbUoTA09YZ1vEiVGrWPurndqu3nrj05T+5PIeSAENB7QcggfAy0mCFVGShyNDdBL3K3Zy4
	qpICwKFHJx7r/zAOaPu4Ppdc/Rifl7W8kSV8hoLAffR26bHJ056xRKSNBw8m6t5W08cIpCaGC/s
	XYERl5ZdIYoJBh0JzY85jVQ0h4QrEn450WIbELc+SuP60U7xRStOM1eAAa+KBW5ud0i40HUQuZy
	lOntPl20f6TcuJKaeHvwaMaO/Vvjxh
X-Received: by 2002:a05:6830:6af8:b0:7d7:da02:1aa4 with SMTP id 46e09a7af769-7dc94fac1d6mr8621768a34.1.1776713674272;
        Mon, 20 Apr 2026 12:34:34 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:71::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc97518b58sm9283895a34.7.2026.04.20.12.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 12:34:33 -0700 (PDT)
Date: Mon, 20 Apr 2026 12:34:32 -0700
Message-ID: <eef5d62d475b0aeb93f6f84585f36972.sdf.kernel@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
In-Reply-To: <20260420082805.14844-4-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v2 3/8] xsk: fix use-after-free of xs->skb in
 xsk_build_skb() free_err path
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> From: Jason Xing <kernelxing@tencent.com>
> 
> When xsk_build_skb() processes multi-buffer packets in copy mode, the
> first descriptor stores data into the skb linear area without adding
> any frags, so nr_frags stays at 0. The caller then sets xs->skb = skb
> to accumulate subsequent descriptors.
> 
> If a continuation descriptor fails (e.g. alloc_page returns NULL with
> -EAGAIN), we jump to free_err where the condition:
> 
>   if (skb && !skb_shinfo(skb)->nr_frags)
>       kfree_skb(skb);
> 
> evaluates to true because nr_frags is still 0 (the first descriptor
> used the linear area, not frags). This frees the skb while xs->skb
> still points to it, creating a dangling pointer. On the next transmit
> attempt or socket close, xs->skb is dereferenced, causing a
> use-after-free or double-free.
> 
> Fix by adding a !xs->skb check to the condition, ensuring we only free
> skbs that were freshly allocated in this call (xs->skb is NULL) and
> never free an in-progress multi-buffer skb that the caller still
> references.
> 
> Closes: https://lore.kernel.org/all/20260415082654.21026-4-kerneljasonxing@gmail.com/
> Fixes: 6b9c129c2f93 ("xsk: remove @first_frag from xsk_build_skb()")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 6521604f8d42..4fdd1a45a9bd 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -889,7 +889,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  	return skb;
>  
>  free_err:
> -	if (skb && !skb_shinfo(skb)->nr_frags)
> +	if (skb && !xs->skb && !skb_shinfo(skb)->nr_frags)
>  		kfree_skb(skb);
>  
>  	if (err == -EOVERFLOW) {
> -- 
> 2.41.3

Now "!skb_shinfo(skb)->nr_frags" feels redundant? It's either
"skb && !xs->skb" and we own the kfree. or "xs->skb != NULL" and we
want xsk_drop_skb? Or am I missing something?
