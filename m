Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com [209.85.160.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF037F8DA
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875506; cv=none; b=u67YVfsdBgQqR6vMI81q9xkRdvl15RlnoKAPjM95dLwMAk7TXRZDcGU/Mb051mxd/A78cyauZhvbUxdl7YZIRznJtfsvYZOyYzJRV9Z58R577bBoNtkpCJ6yQGxO2o/Fu82hzViYGctkhuR4UGJW8ugFSp3IASP+tjQ0kW/UHgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875506; c=relaxed/simple;
	bh=cZIYcDfBSA2vCxhBpbusjqUzJv4vZW92FwUZ2AfApJE=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type; b=tZn4n7rfzRaRkB0L4kc2g5ThNkHCxfdDT7HE/J8cUa/DaQgcDBc+weFrI1l31b/BhX3Jf3PAIB1Kj2/d8vFj5OZ5zB6aGuE2lcPu66KhZTcOHAfUrQBn0ufzflwK6WJSy7Xhjob+tmTYUZ69JMrd1MtUMgfFbUWioJdvAI27//4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXD+Svh8; arc=none smtp.client-ip=209.85.160.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXD+Svh8"
Received: by mail-oa1-f68.google.com with SMTP id 586e51a60fabf-40423dbe98bso2387360fac.2
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 09:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776875504; x=1777480304; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZUh71n0Q6RWY3ShIg6hTY09S3jUTXCR0PyZUSnqcVx8=;
        b=mXD+Svh8eFuAXRU6BNeTTTGutG3/1Xl/qQeMlcY129MSwfBzAsdeH/alXqt6ZlYSXV
         FtQeNhvSb9GIkqm2KetNa8E777Ax2uxiDf45wo3T0JX4P/vQd+s0UC8sTE8Wy/W5Z4S7
         Mjt5ZKb9LWBfBdOUArhc10ysw6ZCrk5rsNqMgtqX5p6HSjlSrLYuzWF4C/lcKVnaUyxn
         u3rZJhvbWoXfA6OjxVerBQBIEQXSK3ZMaEXavVQGl+eegZRk4AIxMJupgUuoO3glU2BS
         /MjnhUUxLMqChE5GyAxLC7u5W9vMUwMEsjTVXRg0ioyYkuFfYddaQOQtNbSjHggJdQRZ
         hwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875504; x=1777480304;
        h=subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUh71n0Q6RWY3ShIg6hTY09S3jUTXCR0PyZUSnqcVx8=;
        b=V374dBdqNwYxhBdGKeHYg+S5uV0kLk3AbbZl6rlXh0bwZRuFRsvM1fZYpBFz1ovKHQ
         7Y6aJe3+3qgzCvDw5nqsJPATV992FmwYWTMU4e7HuEw72FTAdgaFN386tKXuog2Y5jSI
         ujnjrW58MIrSY1vfMxMj+UhpEl7oNlixb6mKag8nRF1B349N7JrNWAI0UNoexBYQe/x8
         mpwB37boBfes/hib+1dPwLVaaTNyeq3Taj/Hh/lhJ8fa7BeQsKF+xNTok1pmAjRi3AYc
         1iR5B2uLXI7P6lNU29nZ8xuIJuDE3GzoISN1EbJHqNrcEbk13RTNDyR++C7l8OAJ1UGB
         f3lA==
X-Gm-Message-State: AOJu0YyOJLAIlwFrIG6E9SUhoO55dVGzgSFBQ+8ltPJTNbz/wuBWK8Kb
	dnOA3nepuLNwj9zV4fqMaIewI7Enc14nDBtcyjC7RmT1Zi3prHr0QR6hu9TYv1Bz
X-Gm-Gg: AeBDievoX0dnCz4yultfyxnFyM2Yks6JYnFPv9GwSz3V5VNusEORjpSlAeOUXO5vVnC
	z8aT3veBmq1XcLVAl8sS/kiPjqFmhdIYVmv6hgtKyzb2bkXXrCUjhS7qJ48G2EpTMs3g/o0icK6
	regpjokNrNh5v+dEjAaRCmnU4W4xzs2P4QykmDzdJiquGhkz45YGiSz85JETYsJ7QHMHJpJnOwk
	aZ+q1mBzE0S3gGOs+thsMdhBVJyWgrbgYS6AZEhcWoyMkgs+X+BhrkjDr3Vp1+nZrnrvuAAfkNb
	+6BvMeEUqhAQQDJv4JSwmx65A7AsS57Cse+Cwo496kCRFShnTBxbPDKUAWGttxfjeL+OxL6qjr+
	GZEtgmAdwBhDzXxRJkYV+8Mk1ambjlx+p2vFNTLpeLYQk6l6McV9FsvZnZMChXtuRXSemjBpjZU
	LIQMja1PHHJcNI8LAT95Ri5kxMzFRM
X-Received: by 2002:a05:6871:1cd:b0:417:2daf:6aa1 with SMTP id 586e51a60fabf-42aded7a82bmr13421229fac.37.1776875495405;
        Wed, 22 Apr 2026 09:31:35 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:49::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b9acc056esm15535973fac.17.2026.04.22.09.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:31:35 -0700 (PDT)
Date: Wed, 22 Apr 2026 09:31:34 -0700
Message-ID: <e4d5cf5e4bdde4dc2a015967f97f89be.sdf.kernel@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
In-Reply-To: <20260422033650.68457-7-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v3 6/8] xsk: free the skb when hitting the upper bound
 MAX_SKB_FRAGS
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> From: Jason Xing <kernelxing@tencent.com>
> 
> Fix it by explicitly adding kfree_skb() before returning back to its
> caller.
> 
> How to reproduce it in virtio_net:
> 1. the current skb is the first one (which means xs->skb is NULL) and
>    hit the limit MAX_SKB_FRAGS.
> 2. xsk_build_skb_zerocopy() returns -EOVERFLOW.
> 3. the caller xsk_build_skb() clears skb by using 'skb = NULL;'. This
>    is why bug can be triggered.
> 4. there is no chance to free this skb anymore.
> 
> Note that if in this case the xs->skb is not NULL, xsk_build_skb() will
> call xsk_drop_skb(xs->skb) to do the right thing.
> 
> Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index c49b58199d2f..5e6326e076ab 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -776,8 +776,11 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  	addr = buffer - pool->addrs;
>  
>  	for (copied = 0, i = skb_shinfo(skb)->nr_frags; copied < len; i++) {
> -		if (unlikely(i >= MAX_SKB_FRAGS))
> +		if (unlikely(i >= MAX_SKB_FRAGS)) {
> +			if (!xs->skb)
> +				kfree_skb(skb);
>  			return ERR_PTR(-EOVERFLOW);
> +		}
>  
>  		page = pool->umem->pgs[addr >> PAGE_SHIFT];
>  		get_page(page);
> --
> 2.41.3
>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
