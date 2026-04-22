Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B636137F8AB
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875495; cv=none; b=pYt/Oo5BKOVcnHR8x0RWhuLu7WhTr3bIzWKSFgyDJ3O8Pn3Iw4f+I/xb/DOpjRkinqG9BykQyQcyLXRZMCqM6yCYihR2Fggsjc3MlqmKYWyUn/jD+gdy0bsgKP1yKTOen0uqYg1EYql9wPEXQw8IkZtWvteKXj/gbc2QfUkJW0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875495; c=relaxed/simple;
	bh=EhbGxSycWRGGPRefyE2yZ3qZMYiLgTkVaA9SF3zTDqM=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type; b=oou1wplPS5y+sJJYV9dfgjNOABooEVyrZsETjvmA1BRPBt+AvGi1E1K09/hxeXDAnTRQEiXuEdmGdowzU1S0pVSE6Ij8Wux+s52AMMt0BMWFpMRfgirXZXXOt83BT6dK2OOhJ4aasZiTDx5eLPiyzrXsONoB2SaxE4m9Cmuf0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edStutVr; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edStutVr"
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-4243bf9be36so2727282fac.3
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 09:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776875493; x=1777480293; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=psTO9IXagb9gvkh6TivZ2kclv53ax7Oa2qxYLSN87Vs=;
        b=edStutVr04h0IppyIN6HYAGwxl2Q6hEMmn2/TVhKb+tfx2flSK5BpRwgIuNoErQrkG
         nRRknpM0yAaHnCnnVNxSMwwEfuB6VY9lwXdbQaL+k77jF81TByQaLu9usXzkwQYju7EN
         noZ0uMRZ9Aj2RFxZEhC1qGE4QFEUD2evB5cyDxjkd0yIayss0yqI0x+r7QvMjtV5nfkr
         v2iD7gIjQGkFYlJ8gOIgd6+S3SR/ytn5wlKeYfCfiG3+f3fnUDstRAW+OqvgYepYObXS
         FrCqHBC0JPz9F5mo9gGnKVltwqhv33dy9R+zlpkYD4bUSFDHdUCkVeFLHTef/geZEnNf
         3N4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875493; x=1777480293;
        h=subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=psTO9IXagb9gvkh6TivZ2kclv53ax7Oa2qxYLSN87Vs=;
        b=YU2uDlEW1uyxzNSikgw+RuRwyPucsjK7OdB1twgEnz5jQ7IU91FGjy8PRvhkfJLi37
         tWn1FvjkEPSJwrADRlegor4xQ2G/nUNnQe4NRIoNBMSHqTImT26ZUWKRWI/2X9uRtkWL
         bsxwuxCBd9VDN/ibmsfCDYVRdO1HDa2gCGDtQQh2ZDquHWZez62S2IJnEYXrVBjVaEaC
         odDCxvDwfPnIxTMThG89fWU2kKVEvLKHCypbnxk4m3toR6cjFeYxTCLpWTP/fn9S0kV6
         P7KyxJQ37pPA0bAyFn0BvAWkIGhhtqrFY45VVeHTJ1yAwYRp59D8jK91Ja0uiRiRpeBJ
         YtOw==
X-Gm-Message-State: AOJu0Yx/0UDN++HfH0+gIB6+2nQgxgnZ2aUULQ7ZahQYyUrvyFidPprv
	Z4IWeiAgh4SpdG1yCulXT2znZaZXmbhzrOwgZiwFzLsE7c3Bh2r1q5Zz
X-Gm-Gg: AeBDietLFCzT1m5QOyajTxKCg25QtxZjmWUkmj+GzarYpej+bOmFiSwuSPrtrdBbi3h
	mVdjF2r8V5k/ZeScgZ2HilsUdi5X6PZ/O4UIsuTC3KVBA0Mfcog0bas8A/n9p/XM0ErthrQJqSI
	71kaMFC0kJHxRFp0DfOd8gANO2rWZ9Cgz0xGPnX6xOyj2WcmrPp7WBWhPQBGIjAkJC1F7rCaT54
	8fmiBUZsQ9EodQ25rwpL0DXUelyOOWLYYmS02oapTIWJBp6Ro7B9QT/qiHH+WdLpfP2H9/0+iRC
	vNvrYiUeRFELk6uq9VIENrQ2e3BdGvknrAlUF+fIgrWAlXOob0f6B8dFeroN1tKONhBYgkLTZRC
	YtaDgWVaGXxAc2a381Zkljp9NSEILvT0xJGkjD0VDroW5SXsVcxK8z0qX7pvzAHd61ySxksMCx9
	RuD8C/2EsU8yTU0ovoG2fliVFv+O0=
X-Received: by 2002:a05:6870:1767:b0:423:188a:f0c4 with SMTP id 586e51a60fabf-42abf2543a0mr13964157fac.3.1776875492480;
        Wed, 22 Apr 2026 09:31:32 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:8::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42fb269f69bsm4365305fac.12.2026.04.22.09.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:31:31 -0700 (PDT)
Date: Wed, 22 Apr 2026 09:31:31 -0700
Message-ID: <1b3207ae8f4cfdea6bf857ca4211b355.sdf.kernel@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
In-Reply-To: <20260422033650.68457-4-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v3 3/8] xsk: fix use-after-free of xs->skb in
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
> Fix by using a !xs->skb check to handle first frag situation, ensuring
> we only free skbs that were freshly allocated in this call
> (xs->skb is NULL) and never free an in-progress multi-buffer skb that
> the caller still references.
> 
> Closes: https://lore.kernel.org/all/20260415082654.21026-4-kerneljasonxing@gmail.com/
> Fixes: 6b9c129c2f93 ("xsk: remove @first_frag from xsk_build_skb()")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 6521604f8d42..d23d1b14b8b4 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -889,7 +889,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  	return skb;
>  
>  free_err:
> -	if (skb && !skb_shinfo(skb)->nr_frags)
> +	if (skb && !xs->skb)
>  		kfree_skb(skb);
>  
>  	if (err == -EOVERFLOW) {
> --
> 2.41.3
>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
