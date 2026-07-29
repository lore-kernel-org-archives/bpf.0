Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CA04302EC
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 21:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785361922; cv=none; b=Oj5p5HUk2CeInRw0bDeV021n9KrCoEhbjH4ywkgaqpXYdpYnhOuqqsjr5Ff7coZw50rVIY0PUq3895ye+HXRmbJbVkL7FLJ8YqwLFgykB1mgOEQSjTEjudWin+W62B0LUtW29bzckFHXBrdBkWktslF7gYVsZOLjbYxX+YNSP3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785361922; c=relaxed/simple;
	bh=f1sNXUEhd5G+MN0jVhIrIwwozHXwZG5dNEjWm+ZL6jI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fElD6ry/RaegTe/W8B34tB536nu4smrY982DRxaq8GPm1WEFYQ8HDqIYi3RTz0x0RNMlaXYbq2B4qALx3FGPe+ySFib7QozF6MCZSrwEyna5ieYWJStxGITraonLiYeT39lT/6gWqsffYu97pPl/oB9jFK0pu08p7co/D9RkZGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=CF+tN1hX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="CF+tN1hX"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ceab75934dso17979775ad.2
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 14:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785361910; x=1785966710; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AraEorwOHfPmz/tjxiQ5QFMckGEZDI0HCLwYm0eDCS4=;
        b=CF+tN1hXVmUHvt8EmDE2yaV7gW30aFmDZNJ/90J0oEEFSebqjZRq4/GIsWEktjD+zl
         aRGwkWAo7LfloiCcslUS8IpkYa0BixTTdEnCkhZtGv2mCwS+MZVS5h5p/XXufyn82/47
         MN/xl/Zf7ta7yGQD4H14Va621UiwmINe+kv9yIJYSLxHYxxHoxZUpycsqpfb0ORsFmCI
         DT8FRZEfY5qxRDu//PVyVQC0mfCGk1E63DvFcVOzUQf12wnpE0Mqtdu9Pqh/jL/yAQJb
         +YdekgtmWhCSM2XE547Da+9OwoYyFA8tsckV3eLVE5n0MhhNRSG3suOd8O4gh3mv7aTH
         1/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785361910; x=1785966710;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AraEorwOHfPmz/tjxiQ5QFMckGEZDI0HCLwYm0eDCS4=;
        b=rmsijS7SB09smocGw4wj5rQ53w3/lougzbVcc5PvOmLd2bXMEw+NHRntl7nlU9Jz/r
         f9laDMKHW08igD48WaG1GeYh6L5Y2Uza9lMAsDH7Kbcb+F2FaiLbJx9/i1Lf8kTbZgH2
         6WOJ1emOs/2CLGZwExXHkhFC86e9zRN/ZqQUMWFyDUrK5flB68nwS+cTBbgNeMEGgDof
         rmvJI0FL1g+fC+NW/RF2x62/tbd8jk30ZVqxXJ3NCNJ50CZUWzhETss8MPqDG3pC41jK
         ZhY/C1IWkWg9VqglSR0+jZVxvyE2HbzAV9y0aNZSyednb8TBVGDK6eUyDGR7ta7tWGed
         scbA==
X-Forwarded-Encrypted: i=1; AHgh+RpfXaFZng8xiLBCW3IqZyGZ8jb4FzBF94qggI/Nbk0VlW3TC+XoLqRwiF9j7kTOCWiwryM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjs7GevjfDEWcz6O7oAHXgLaeQ/usdkk8y+IdaEfn7z8yw+EpE
	pT5hk4WNga7UXZM0Eh2cAU/u4CZv6LeTspHe6+YPxD8sX+P5x08tZ8LRtZTi9yXPbxM=
X-Gm-Gg: AR+sD10Q0XeyyPT2dEZkfBQoAys2PZlTMAGdOOR8hMoLa8k2XJUM7KaotETTvY4hKQk
	xt/A+u/eJZMACRrvp8xzMFc3Eomc0sYNpXaho0eTGICW4a8AMg//rgmTBEE81dZUe2kH2jH4Q8c
	w91LWKOAjqXxw8/eYSSbyVwCu+HfihkSo58/7chCuniJDgrm3AqchyqNc5fsR3nFrrtmcdI2NLu
	fLsUCwG6pWWGv+7/6e1wZRlQowkY83swCXrJoWDvybJklGcXrE+4ROQweYbzzGfKORTZTRUkl6d
	orSvnQoHWYKvS5fwf39r3Tv+zgXdZxvmDIXFF/n+D1aBraJ81/Ft2nmxm56Am2uDdXqOOAnVTXu
	3t5VaE4w9xtyjSCsi2ObQqrlzkT0kt0JhnY1RRJT1gXcLFoWKUWVXAXTAZ1roZcwB3T8e4dtXC0
	R0YGQnIIT0LrW0MhiAiDcK9zqy2+WIjXUM8ZIn/hSF4Vw9
X-Received: by 2002:a17:903:24f:b0:2c9:9a19:df with SMTP id d9443c01a7336-2d035be322emr868825ad.18.1785361910499;
        Wed, 29 Jul 2026 14:51:50 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:d447])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504baa01dsm14293935eec.12.2026.07.29.14.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 14:51:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 17:51:47 -0400
Message-Id: <DKBDZ5Q7KJ7Y.382DN71UKV1N6@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Puranjay
 Mohan" <puranjay@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: arena: fix mmap_lock deadlock on arena
 lock failure
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260728060517.95183-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260728060517.95183-1-jiayuan.chen@linux.dev>

On Tue Jul 28, 2026 at 2:05 AM EDT, Jiayuan Chen wrote:
> Reported by the Sashiko AI review.
>
> arena_vm_fault() returns VM_FAULT_RETRY when it can't take
> arena->spinlock, but it never took mmap_lock. The fault path assumes a
> VM_FAULT_RETRY handler already dropped mmap_lock and re-takes it on the
> retry, so mmap_lock gets taken twice and can deadlock:
>
> 	do_user_addr_fault()
> 	{
> 		fault =3D handle_mm_fault(...);   // calls arena_vm_fault()
> 		if (fault & VM_FAULT_RETRY)
> 			goto retry;   // re-locks mmap_lock
> 		mmap_read_unlock(mm);
> 	}
>
> Return VM_FAULT_SIGBUS instead, for two reasons:
>
> 1. We could keep VM_FAULT_RETRY, but then we'd have to drop the fault
>    lock first and cap the retry ourselves, the way __folio_lock_or_retry(=
)
>    does.
>
> 2. A failed raw_res_spin_lock_irqsave() already means a possible deadlock
>    was detected, so retrying just hits the same lock again.
>
> So returning VM_FAULT_RETRY here is overkill.
>
> Fixes: b8467290edab ("bpf: arena: make arena kfuncs any context safe")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> ---
> target to bpf-next since I think it is moderate.

Agreed, I think either branch is fine.

> ---
>  kernel/bpf/arena.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 34f023a537fe..555ee2531ef9 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -490,8 +490,12 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vm=
f)
>  	kaddr =3D kbase + (u32)(vmf->address);
> =20
>  	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
> -		/* Make a reasonable effort to address impossible case */
> -		return VM_FAULT_RETRY;
> +		/*
> +		 * A failed lock means a possible deadlock was detected. Don't
> +		 * return VM_FAULT_RETRY: this handler never took mmap_lock, but
> +		 * the fault path would re-take it on retry and deadlock. Fail.
> +		 */
> +		return VM_FAULT_SIGBUS;
> =20
>  	page =3D vmalloc_to_page((void *)kaddr);
>  	if (page) {

