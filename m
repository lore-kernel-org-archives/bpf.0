Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC63335A397
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178470; cv=none; b=MkSJod9HYWgstfSNxlpMgjZPcPJMsfQt8BKgHg+VO6lx0uNZ8u3mPZmJ9h11QG7bXmzEmRgBRztVBxAM9jeOXqX4by5IyMMksh9wZn2METvfqz/KKP0bsLF80G9LGy1vEDFEjMyphn4vI7dyJQY/QF1MoARAgo8FvnpjZm13BxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178470; c=relaxed/simple;
	bh=kugXFntQiGrBA5LktHgKLzXFY9CjzatEh5uzKMEFpVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quYs6+nh2hUvN/9StjLnEPVeuxDSGkm8gLLLtseCxgF7sMk43Kr+Rf2rwA6858Mw5/jWuhekNoftcmyyoFHdOs2egOLFONRI8K8rkzu0IXMkew5FeBq8bsJAhrLP0lVlQbYhqIJ1waWkhWUFHjB/L/ntv9YaHS7K0brALInFUzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gw1PdunN; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gw1PdunN"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-128b9b7e3edso1073031c88.0
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 14:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773178469; x=1773783269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wk9iz62e9Zzbp1FSdoEUGk+EwY4bkDsWcYwExbvR3YA=;
        b=Gw1PdunNxpjLtMwSELRxIy+VD5w5fbSqgjtINFTvllS7MnNtHejkqVO9OkpEcGMjgd
         lfm8u/RBxtUkwMwz2LaPlUo4355/As0n0Z/vEHT97PtSfgw54MvJai2jYQv53gKIK/Sk
         NvD6Tm6gogdK9YMxTBsddZoMkYdSOV+eWPZHNg2UfQVjE4il67bag+oUqovGL4BfDAp/
         thEvGy4yGs+g7eDjCJYZvjAuy2favu67KrU3u3Ck9d5xHzScWnxQnht+cRKqUVXKKJIQ
         l66RjqQ3U78SxXKqfnz6iEaG8zAvaPDv3dyTlOX5Mfb+4ofcstCw0HYz8ge9NGsOFd8Q
         citA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773178469; x=1773783269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wk9iz62e9Zzbp1FSdoEUGk+EwY4bkDsWcYwExbvR3YA=;
        b=CUMW32/LA0l1rWb/yoZX0/nvvbPC14Mi2esdp2PLcaYq/dthKZcr04dsGFuQ6Ew2gC
         cM1YzhnnkwrVIDZbJUbeMRAVV9TisLq8OzhE5jVz5kFYpJc4WREdEMFJJbFuB7wAu55N
         r5Gkn46EmT0N4zS8s3GFjJcT3dCZ49XD83n6T8vu48/yGLbCsaRncVbnX4oSYqB/H9Zf
         RvP0t6PKXOTAtjHqPn/IUwMUTW/W5OkqswObv1jqkLzBkvHu7wXf0Yu97KnJzXLGxyOa
         Qr0K9jv4Ve+RJ2Eaq/ErKRsFRbuudXcZVEmv8RQ7nf5u05qcT9b+rei4a2sKKF5AmhCF
         2KVw==
X-Forwarded-Encrypted: i=1; AJvYcCUsgj0vjb6zH6lvd71pzkRIXXJvwZMI/E6z0B/NBxAikGjo2+F/b64GackE5XAiZLwiOwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFDf4PziQo19LdsheZT4dJ6X+D40AFTVTroRSyqdVl2wNl3/sH
	uCJTMyC9E/fzH6ecyrU4YTYkZBCIEZXKifO+vue+QQfI8FVIUbeb+AE=
X-Gm-Gg: ATEYQzwjBEjwdAI8lUrySVWe8pBhsxZAfnzhTWgTCKmNLIq4ot1J+5AoWe1UbQ0TA1f
	iSI0Ndk+A9crHG9ZDYDP+YO6JRYyKt9T/Iuf6WxFnvShDjRG/AEqh/mMUwxf6zUgv0GdoRL6/0c
	EhMeKm2NDnLcwEL+uyinh8pYefNpLbbFjJY7WSQbQM8U8bs1NUeOX9RjxsRxGbNThjXyJrzFr+2
	aS4f3zy5lSdg8qmcmsxuPXoZ1+EQxWCgdL1wznIUG9ujysM/IpKJVaaJ2cP40mZCuYCcpWAuH47
	JtPBky7ikkk9wHj+GfQ8AMraIF6OVgUfTQspok1gM4M0LFv2hJ0glPoR6hjkr1FDnZEVwxWq+nR
	eJ3FfjYTsdwZviOaYtS0ZTuYpxQ4zMSq27EHfKPLST+3Y2tm+dxIMJl4l8jwphcJsl+dz1jbZHr
	euLnvtSJaKNkYl0LAJu7n//ZqiZAdfuEGBJWCegGSpOW3OCkS80vLnXAFaf5X7+DCZ0P5BGNs++
	wWwKHvxhgpuZLoAXw==
X-Received: by 2002:a05:7022:78e:b0:128:d4be:7415 with SMTP id a92af1059eb24-128e784b788mr143093c88.34.1773178468586;
        Tue, 10 Mar 2026 14:34:28 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128e7cd6aafsm89761c88.14.2026.03.10.14.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:34:28 -0700 (PDT)
Date: Tue, 10 Mar 2026 14:34:27 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net-next] xsk: remove doubled defines
Message-ID: <abCOYwySxuQnkq_k@mini-arch>
References: <20260310134327.422540-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310134327.422540-1-maciej.fijalkowski@intel.com>

On 03/10, Maciej Fijalkowski wrote:
> Seems we have been carrying around doubled defines for unaligned mode
> logic. Remove one of them.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  include/net/xsk_buff_pool.h | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index 0b1abdb99c9e..ccb3b350001f 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -174,13 +174,6 @@ static inline void xp_dma_sync_for_device(struct xsk_buff_pool *pool,
>  	dma_sync_single_for_device(pool->dev, dma, size, DMA_BIDIRECTIONAL);
>  }
>  
> -/* Masks for xdp_umem_page flags.
> - * The low 12-bits of the addr will be 0 since this is the page address, so we
> - * can use them for flags.
> - */
> -#define XSK_NEXT_PG_CONTIG_SHIFT 0
> -#define XSK_NEXT_PG_CONTIG_MASK BIT_ULL(XSK_NEXT_PG_CONTIG_SHIFT)
> -
>  static inline bool xp_desc_crosses_non_contig_pg(struct xsk_buff_pool *pool,
>  						 u64 addr, u32 len)
>  {
> -- 
> 2.43.0
> 

All consumers seem to be in net/xdp/xsk_buff_pool.c, so why not remove
the defines from xsk.h instead?
