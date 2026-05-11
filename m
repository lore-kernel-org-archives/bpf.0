Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6737E2609C5
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511811; cv=none; b=nmCcHEYu9f0AUPYHt9REuRvXaCXKh8+fIwE1uUN3ymewsEbf/sie+szytr14CsMATNQ0pAKEekAvjS+p6wg9S7hPmZipY6MmuMJMMrSwLYUnXCDyXe6YfVJedNHAhVOlMbAcRx1226qN4yWGYXnnQC+wieJU4mGiZ1Qd2z7WX+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511811; c=relaxed/simple;
	bh=FcCFzrHu4yPb9ChdGb3IYZ67Iw+sGK/r/8NLA62dU8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCdwY8+yioGfrw6SHgNhYHH7nsHPzv0Jh40ibX+iMgVqbzkAtH6MEMqQmPhhrH5jml6i48zC+kItDXJUT+axFXhqCW9jgdlu3c16gr/FEUk/7rulhv0mtfn+BnVMK/6pMh0RC6QJYBBsxRJg0uoFv+urCmg9AJr2MQHk5ckyS2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eODpyZXB; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eODpyZXB"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so3296070b3a.3
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 08:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778511810; x=1779116610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tXqTBRULBy1BYm3Ife8V4Q/X4vLGr/NnZVXSc/9oY2E=;
        b=eODpyZXB+piAdEsaL164XWOwf/5wl7HT4x42iT5dRtlpnJL4hQ2AuMC2E8ODxxmXbT
         VNuGTbCNngVmowss5J40i8UgBF2cFZGOa1aIJCVzLSS47YPjDa5kQTBJ2HqM+qI/RrT+
         3SiPFspCMpJbWKpnpAnR/syFsirVYEi0h5paF5SB9NnPBxPP/1FVxIVORpNrY9FXjzNN
         S6p4rkS/zATokSQqpNBHTmE7fUqMGW5VLt36A0rtTFSAO96c64FBWd58R456ImN+AIBS
         CYIYfVfGXCwEpmjW9fNuQj9LwXoSDRnD6trBMN3dPcjr9T5syOF5UApyZ98CdqcBpEhb
         jfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778511810; x=1779116610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXqTBRULBy1BYm3Ife8V4Q/X4vLGr/NnZVXSc/9oY2E=;
        b=saMalfXoXgtrnpOvmsymOXIcScEEWACKJjVbl+eKTt9ZI647QGD3JoHqAXwFfGJ0Jx
         rKnyAKlzqTW60EAyQwCDt4VI1Jvb4DLKvEIQLv656qMPjxaIFoMja0kWcEyXUcZLsxyT
         3HmL6P2idyJ/DiqTE9Et8Y1zXuclmkWWVZkVJpNOqJ3CrWxYmuXo5yhkxhHSLNLg5phP
         6EmIwW/PD+i1TE66nqEkUlhDI589SZRf6dEcsJi6jiJaTqU7IJAM3qzRZ3l3FrBO55Mt
         jaXloThLcx8IxWaedQQZaZkytU9vjD/Mn86cWjUlvinaABo+R9oudcvZXumGYXt/fIWq
         DWuQ==
X-Forwarded-Encrypted: i=1; AFNElJ84CgKRFlt89y+/atqNW+U6J311Epz2LWSPJnFy38N/K+SToQ+31YUGV0IS3PAVlHTNIjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXiux6kkMD/kYZxhMQAti+AhpYQhaaiHRVhZVyfklVRDyf31E1
	+NuDKsQ+memIjqkC7XwCMsVmB35DLc+aBUPD/xElpxpUAhukHyBEW7Jq
X-Gm-Gg: Acq92OHLzukMYhodRLS5h7U/T0RyTefFmykkRwuFvZpF25EF6txgeL6uQ2a4vfh8QIJ
	zATU4lCjnKd7PszOSm+jwV8mc2bVMT2RvynPuc2yGx//8ClCxOUFOgNZZYekgrnz09B4B8Os/bS
	5upqSnySkTy/RGFGwv5ffxZxCkaPLO4bO9i8Uqx4mooB8Zbu1QsRPU4cL3no1v8cJwhG7I3uBhx
	Iu7T9bQhrk6FSSdnCNvmBmKwZMSXlJGvkMMciM2wuvz8CwPIQbHvU4OM7qJfsVSGyoGCrgXLC2H
	d4XkvrHWt/XviU+WVqnFYufvXEYdINjyZfEQchvTp/AQpv4bftP3kAQpL9qe2rQPr6jJ8ouf1FY
	FwK0pDwtr84egwX7D3dWBdF6UpDirQ7p01yVKEHaNey0RSsalY9iEUTZoGwzjmqVmV8Hz0oLRES
	td79+NPaQEQ+dALyq/
X-Received: by 2002:a05:6a00:4c81:b0:81f:5037:a317 with SMTP id d2e1a72fcca58-83e3974c22bmr9701574b3a.11.1778511809130;
        Mon, 11 May 2026 08:03:29 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5b::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839685a8125sm20717422b3a.61.2026.05.11.08.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:03:28 -0700 (PDT)
Date: Mon, 11 May 2026 08:03:27 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net 1/4] xsk: cache csum_start/csum_offset to fix TOCTOU
 in xsk_skb_metadata()
Message-ID: <agHurBlnAgjVNq-u@devvm7509.cco0.facebook.com>
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-2-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260510012310.88570-2-kerneljasonxing@gmail.com>

On 05/10, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The TX metadata area resides in the UMEM buffer which is memory-mapped
> and concurrently writable by userspace. In xsk_skb_metadata(),
> csum_start and csum_offset are read from shared memory for bounds
> validation, then read again for skb assignment. A malicious userspace
> application can race to overwrite these values between the two reads,
> bypassing the bounds check and causing out-of-bounds memory access
> during checksum computation in the transmit path.
> 
> Fix this by reading csum_start and csum_offset into local variables
> once, then using the local copies for both validation and assignment.
> 
> Note that other metadata fields (flags, launch_time) and the cached
> csum fields may be mutually inconsistent due to concurrent userspace
> writes, but this is benign: the only security-critical invariant is
> that each field's validated value is the same one used, which local
> caching guarantees.
> 
> Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@smtp.kernel.org/
> Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 6bcd77068e52..cd039e397018 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -722,6 +722,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
>  			    u32 hr)
>  {
>  	struct xsk_tx_metadata *meta = NULL;
> +	u16 csum_start, csum_offset;
>  
>  	if (unlikely(pool->tx_metadata_len == 0))
>  		return -EINVAL;
> @@ -731,13 +732,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
>  		return -EINVAL;
>  
>  	if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
> -		if (unlikely(meta->request.csum_start +
> -			     meta->request.csum_offset +
> +		csum_start = meta->request.csum_start;
> +		csum_offset = meta->request.csum_offset;

Wondering if it's better to READ_ONCE(x) these?
