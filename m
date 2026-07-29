Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39988407567
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 21:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785361882; cv=none; b=WNSHMWmvuKbRNaeAYmFj5ITOPi82yXie45K+hICNra9l4FsJhN0HWFZd6B3z/dNfg5F2g/1KgbhO862Pdj+hRuqCWBDYyWeTFmAjNRLf4W0V6ZaExdeKkDArS5OpA2C+dcbes/kwRjgrBkQx2j4GCmNM/uVwvG47PP98x2CuSXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785361882; c=relaxed/simple;
	bh=XH2cRnEyG3WFJJLMA4y1Ub72cMRiYFAhpRCShVqGLtY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dUoditX/RgPASgToP8OzjPGx463JxYMkT/1AF7856OLO3FpR+dl+ObmVS1/BP5X0MihbLqBOESRnYs4g0+WCNCm+DbMAg//0EiwmPwfCI0hrMIrJvK1GQtEuxS3qCBJ1IogSPzLKjsRm1AP+uvttIEw2ITBglOpQRfk5+UUeyno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Cq8XtiL6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Cq8XtiL6"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cacb8416a1so15475565ad.1
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 14:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785361878; x=1785966678; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O2guFCAkBAx2hHFNWNlkg/xNUWWv/qQLs/yDyW8NQ/8=;
        b=Cq8XtiL6UZk4U30q6TZfMGGehpESak3J2bCxTo+MZiZlnIqfo/4F0Gs7Tbu698fjTV
         Km4uTzeJg2/E6CZ9h+p22PUPv6YPsHXTCdcOjiKe1IE8aOB7BL+aePx7KDmn/wh8/VTG
         6Avl/fOlXSzZQ87ni3Xp/N+WNPjoqodJ06/559NXMrunQDGcUID1EKVn0l2aMxMRTvko
         LCyDQEIP07AGU25+L6EfXxo1P9bLxFl/DkxxRhyE6K/IFBAHU8yZnrDA2rqpLjNklndP
         bwXqWcctBHheUG6nCwwVBBS2ek11IoeDL9+Bh4205EbPEl5CkjG/h9Tx261Hkmv2KyYZ
         62Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785361878; x=1785966678;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O2guFCAkBAx2hHFNWNlkg/xNUWWv/qQLs/yDyW8NQ/8=;
        b=mFggcQ300dcuMFaw7KyLyYPgzpCAl0gz9IH8Ff+MzIG+7WSbf/USWrFgHOcYrkpINm
         IAaV9nIM4xrXQDydXkVwip7Hu8A4WKS3CzsXvB0wlSV2ydj+0y4Lon1xpyClgWdi7S3y
         6R74OKoFt3/N/n2RHMSnwpbl9M1ArSEOng8nbP0dGKMOn9EE4+WsNlb9B9Xbl7icK0z3
         ZCCEUNwvLceCncPH1g5smyIpsa2u4p3iNBc0qRI3UPXu0OXtOQEsj4BH4SPPqrpJATec
         lXzrJClCBaAzuyTgq5yYGrm0TZdb3JJ4yyceUlvH77z8d/U71i72V59fJaFQDgYemkuk
         xTIQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYRYehBtqN8iBg5nPuh7SIZ5i9JCTYQEfD0vlXwHjm9YENQCMzVJqyhYj9oioRbn0i3xI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7aDflKAXYw+EnAqKrET+ozQSG/0z2Cvw1epXIFte0+Oyn0H/K
	t/CFhwxHm1t91fsYDZulMcE24Wweqy8POVc1RYc6cwQv7JEwNCzVU9g+ycYWHzD7yVg=
X-Gm-Gg: AR+sD13k1gLXbXbkNDnsCpg1ufg5ABQ2sK7qyyb+EmHiPnq0V27stIgtlcrWZw5Zh7Q
	n2uP/XJHwBCztTBO9g3Nrq7kBwZWOYbb+D9KR5QYySYWNOaGvpLJ9bjsxd+/P/B8GmRpoEbXYnh
	ltV4oUzPLMkYjD5pqlmRwSdufXUzrWznz6QnEMwzVhslEURh9UDMHJP/NTCjldMTsJDGUXSrDZ1
	1+nyDklcRvtlSefSihnFiPsjqxdU3hfN4qFh2pdNyqgx7GrQSB1o0VPOLjXhWsLzfGCgAMNepfg
	iyz180x251rkm2oo/gPH0NrkVo4VgLxLk5bNw4yurLbY0eb032fvAd1+Rfpc5EyeMkR4t9hfm8L
	uL0HhwJmHkyQ99aM66I6IHibvD9eoPEuwO3+WP7+SEFag0pFHLnGR+dleAVlBOo8ik0Hb4vMpSY
	yvQ0+Pre6ovWiaLisodKDeXjfcVG2wnNDbifz8WkbXocwT
X-Received: by 2002:a17:903:4b48:b0:2ca:ed57:8586 with SMTP id d9443c01a7336-2d035c93cdcmr651685ad.23.1785361877748;
        Wed, 29 Jul 2026 14:51:17 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:d447])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d3250asm12047375eec.20.2026.07.29.14.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 14:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 17:51:15 -0400
Message-Id: <DKBDYQP4ND1G.JRM39PEKKGBK@etsalapatis.com>
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

