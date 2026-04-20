Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867A133D6E1
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699847; cv=none; b=DxAIe+/tYEYLw47MsU1zcxLiMGcHUl7xjP/Zjfl2KEoY2ao6IFiQmEL/YIsk1RJHiAOKgKCZHIipbgShk4VLBNeeoY0FZM6I87rAyCojP/lzwLU7CDABbPjxRPl8RAxLt9//Zt9usgkxH+hYlQkC0+uDlErxYimHVvODDWmOZNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699847; c=relaxed/simple;
	bh=1k1hp7u43c9TkJzzlgOWfZ4UDE8HfeeU5PBzOa6ytCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyDCPqAQwopoYxx5YjHOYfmIN7L3z1f4WQvNeixvbMt8Es2VnwJN2o6GlKgdATqlpupDTOpMSsDV4b7TWypMbfQrEb9ho0TJSIDzH6D3dATyo0nTZEsinmz4luNOG4Ccs09z7KrZYzsb3q8ZjzEOiZdQ6y9uZ1sXGX58CW5lDgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddaCCu1m; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddaCCu1m"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7d7fdb922a5so2891042a34.3
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 08:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776699845; x=1777304645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HMCNN46uzvkkx+pdzNFwcf4+qGVUVpMcwYXyw94YpJA=;
        b=ddaCCu1mxfBzDYB2X/p0fburKPAT65PTMdudfokAeUhIlkTD4afM8MFwjvCsf3Cs6U
         iZYZJqq8dpZwcIJvzVdqYE0SoifFK+oFiSasZoVVXVT0ozrc+/pBG6lkhAYjjPgIwD8G
         2yTjPsH/2nlHlQ38YI3F15Q+fO4BMWE9aYHS4UTpgXDnq/oLWxCxfuXDcoathnrmCSrr
         SP0Z0F7/6mGnqoGNbjPR2yXwp8jNpu3SJMjv0SJj6oQBRoC3pXI5Xn4Jj5/7fiydOzF4
         f661Go+L7Po5qbqE4r30R+Oz0MK4ZjDNS3oFzRRfzscNdS1f0Zaw3GQwiAxSNKbUGXsu
         nBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776699845; x=1777304645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMCNN46uzvkkx+pdzNFwcf4+qGVUVpMcwYXyw94YpJA=;
        b=rHTWU8kx8RnjuoT4+lljpd78md/c9/ZMbGtGNNwzGFXfxewIpc+pLheZPG2LjCexDh
         jV9c26Egmv0BO8DTWVVjDe3jbLjGMal94IYFnxICyjLBYPng5AxlF+kbIz8vpCbXh2xV
         14ppbccuM3VraRXvtxqSpUsMtch6Tb3p+CUklYG3gqQYCo9fNNDnaJTFPkeS7wT6aCz4
         epJVWrYGCx4XrfzokCiazycbWJ+aRwi9Ikhm5j39xAWAuR2/ksXJIKTkm3+dTaCzs6EO
         A+qtNBT1P6ygCaSmHCm7PTK00EtiXf9ur7+Gi3R05oK2hZcePbJghKPaaYibpM49lznH
         zlrw==
X-Forwarded-Encrypted: i=1; AFNElJ9WClro81qfgqdEuUD0sLel/S6dWGbFPY123to5vAd67/+P0IHFAPG3wgpsxmK8uyjCkMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzygP0d6F2X0+hW8ioMYn/IUkvK2b/uj8ujucEhQp18VWatEm3I
	J1ZgfMtX2SIAdn21eYoFxAUQOkp+9cGFpruXDCPwlcUup6tBZP//3NhR
X-Gm-Gg: AeBDievxEhhoeNZ4OtecLRXeWt0Bmi6U/5JYuN6622U60jYUMdbr+rvJY/iVNZ7wCh9
	5Wz4mZoR5XSusCOygJjZwW4CvjUvOVQiseqJcPhNb6ZF38NdIt2zwi7dOOSR4iDrgiulZXgN7N5
	7S3BZE04aodpOiaZCvCDafNKSNGLOvspssoVeH/m0Kmkf9FNJDX8kEgrPmjcbkpv7qbPARvPsF4
	BQCNkkmyGRJ5oqcPZSf/F2IpBtHPBo/1Bad4fApc9zuzN+ND/auYkrOsOL0VtiNlYd1yw/qNyWU
	wwzU2jGU00B3rKIXTCegX5aEi9XJTgXW+YQq6JuWjG1MthnJD2+d5UAIqgIgprU7O7gT0s9B8ar
	rpHW4Nqg1sTmoSXeiDqBbZcmCtxx2Etb4VWX2r0F2oouQyzdCRchuE4aZmsCg86bo959odVU3nc
	3MYPCqGZNWxyH9zMVisHw7VzVC4bjVPL7w95igmA==
X-Received: by 2002:a05:6830:310d:b0:7dc:283:8988 with SMTP id 46e09a7af769-7dc951f3503mr8846792a34.19.1776699845320;
        Mon, 20 Apr 2026 08:44:05 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:7::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc975034e7sm8780521a34.6.2026.04.20.08.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 08:44:04 -0700 (PDT)
Date: Mon, 20 Apr 2026 08:44:04 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net 2/4] xsk: free the skb when hitting the upper bound
 MAX_SKB_FRAGS
Message-ID: <aeZJh5O7oWG6zYXt@devvm17672.vll0.facebook.com>
References: <20260418045644.28612-1-kerneljasonxing@gmail.com>
 <20260418045644.28612-3-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260418045644.28612-3-kerneljasonxing@gmail.com>

On 04/18, Jason Xing wrote:
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
> index 8fcde34aec7b..5d3dbb118730 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -778,8 +778,11 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
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

As mentioned for patch 1, need to do something with that
xsk_skb_init_misc... Otherwise we hit destructor with xsk_cq_submit_addr_locked
here as well
