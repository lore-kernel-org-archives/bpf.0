Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793134638;
	b=iwVBSGcJho8U++x1Q6AmrsUZR6bOge+9TZ+RQ4L65g7EMK7DxgYAq8mG8n03TwvQZK/B
	 77bxtKVFq+kbLnpv1u8xkEIwrLBfjP0vGfQ/SKX4MwGXyITXllPDr5U+NzCt/6cBzvBrW
	 j/35aZHR4rbZ/dUZw7hWFeysHPKT3KnYG6VgBs3AmeBOy51GgPT5Tfj2aOAKruMY99feb
	 amwt50mz11aBhHJpSLj9380BcNIm1zFbkgrICw7OHmRIBjqEd6rgELWGYYoj9teO+zwxi
	 O7DKvQU/D4vl6/CgXHaENUErx80NxsPhb+xeOZx5J33076bI3C2u70hw5OU3akWIvPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793134638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=LKsjM2T9GRGY3dZ7ISGzyvtBs1gcbUx8RZqfwdZKd4k=;
	b=p5L3+Oh4VFDLKcFsIe1YWgbiTAjVJtZVs/7udsGYyogcgWHYNCpytBp/f0Vz0pdK52+M
	 vkD/Kvu9v6BhyyRoVQqGERQB4cBnWj75HlkLsw4IvWfeNzcm3dcpIkVveoWJwOxEbMsFA
	 BrrRtS0IgptmpiNEN2FMdebJ6LLlIED5F2P9wWZT5BHCo1WhG2ArRrmJanRoU3HeH31yh
	 g8wrjjTkemjoy37lEC2vz2NBA/RRQN1q1SAkJPyIIGUQR/CfT4aXoztvIkk2h+kx8hOjI
	 UVsSp7HaTKh5zdjY/QB/UUQ2QYK/XRHFY9uRtJtlvE/hc4N6JxcK89mZIQrkpNzD9BQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b="ygfWoX/l";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03945606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 20:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03945606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=ygfWoX/l
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-679a2b540f3so351189d50.2
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:57:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793134637; cv=none;
        d=google.com; s=arc-20260327;
        b=R3FErj4A0zxctGCxAmwxdbu6QvmaFlc6uQ+sz53IELd3Pj7FI8oCOXBE7DzuXsth5e
         vrYJ1O7c9chewTl9JibGPppyiKATGPZfvVl6ZW8+tJrByaQMXFLZBStN//+CWaEA0Gwd
         fc9vvqe51tz8XhdhLSpMRp7vrBsqPrC0zWolWixZ0m7Y5IvKNcZ4Vi0qFySBvhDn8UD+
         j2hbNtBP+F3yt3Im2TyYLoSXtDCaAx0Adhi045ZZO1LkhXev8ak4LmTd+swbSeUQAbUz
         UsqkPhdS5Bp4t+6UnmqJVmZYc+oocRDp0wH2zB24QufH0RgCPjcDzZTgZGjvsZL5k1FC
         r1TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LKsjM2T9GRGY3dZ7ISGzyvtBs1gcbUx8RZqfwdZKd4k=;
        fh=GsizxCaGQ2nVZN5bHfNu+gnasnbmBAOTZ+FBDFs+xqE=;
        b=E+mUPyCdVZs/Bu0wQtYqcGE5Czg615jvf26mHRS5jByvljPpbyha5X/4v4/Si6MBEm
         WHzeVYtEE1PSxlwLzZb3NPILx/rCXAtPRHlXwlNRu8yyXdUQWCbWB9o3iwumKWXZvO2K
         aDMRLKHtvMS4r8+Gg2J5/3G6cSgoxSnijJKjdI/jaovlH869QexN+HMxaLJoj6OFnqrO
         7J+xp/HYtJBLWYIeeN1WwJo6XRWlh2bcbcucFshOuQZMCXmvK0S8pz7YKKuGZiDeTvNc
         DaPbZEMRBRlTkBPnoA90Umxv+fk9pIoH9txJRkzwTxRpVbQe0M6idqffh0trSkj7+A6E
         kfiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793134637; x=1793739437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LKsjM2T9GRGY3dZ7ISGzyvtBs1gcbUx8RZqfwdZKd4k=;
        b=ygfWoX/lbwTDg4vg8mkic2QklCvO+U+Nj9cufhZsRTmuEQNiqhX5b1UgSh45j11BXT
         YipgF2xmbZWT0rxLA+Nrz7O9qn1PUIq6AzeS+jEe+EgvnS5vRdAntizzrhhscBemb1Hv
         mcz/FkGUuEC5fYpbjmkZTaJHEMEy7ehNMXSA+l1WKIce5tyo17edeIVHVm8j42XFizor
         2X0Yi4lNgttP6/8WNA4yZO8Y05/K4NaEsBHlBiizxHCgDWJTN+hgRxwPRP2FnibttIVX
         dWwzo6RUeRjaBwFTCrhGpVjSsYW9p3zn+kJZJeZqwNkopvCt83N+rWaWuB4jz+wiIT4J
         Cobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793134637; x=1793739437;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LKsjM2T9GRGY3dZ7ISGzyvtBs1gcbUx8RZqfwdZKd4k=;
        b=VVW5VuSGpTyLM0b666ST5t4ID6FQ0qD6Ag9zLvN4toz/MP+mbqdPAPdeGohGJgjBWK
         MQAlTfywEn1WRCOPUyeoh9LkXNtQAhC3W7eA1R+JQS9UEySOO6lDaLinNY6RzKpMTuQf
         2Z91vTao4PqZ5qUp3Txus9/Vlt66LnMp3arHnYb+eKAnD/uUKLZ5MQY72f589IrQGVfa
         cYC9nZ0gJGBDOiseUibv6nb5ubNXE7uMmZf1N6hJ5GN32qyqJgRXCMerClyX+C2AwmyM
         uZ6+Nau3EAOlQc88Q+8VsG3CDPFTy0KLxStwHxFgDkhSdNUjQ/Z0URKmYVsm0wTBmIYe
         B2DQ==
X-Gm-Message-State: AFq9FYJMeqk/RX1l87ZZRtuPh2LQ0bauXEGTU42NC9y+stghi/w41UX3
	kLA4ePD+UQtkqJyG6RXFEzgc2Xdf8fgJxo2KakXTOyDliofaUd79SAZytIk5L2XfLzRku2zqXoZ
	w6VicLyou94UABc3GE05D2bgDzJ/Pe7nNY26zXluOOA==
X-Gm-Gg: AYBFou10/kmiP4fyK2C7GXLLlW6S7R3LAGf1AgkzE2hFHqfGP76FNoxXtFEV8jFUlBC
	4F9VqbSIUm2SuKRQ8juAliSYRBJsTfYgsBXYUzXtNzmVCDFKcJbuhdrHL4G6Xicc/caBLkiSqej
	gl3N0b9c6XjB7QWn1+RGQapaEI2Xsyd85dbaDv01QU7b6zvt3PovKcOYqSWEz9hQnk1UCbOJOSi
	qiJMe1PBQH2sULmyt7TND6UPaA2BwzdGx85xDQ6M/MWI+oiAljy1CKT3awGhSDygu29mfiXbhQu
	ik951JswDQgZd6szkolayiYou0YIHTi406c3+5ASMEsu7lE1bQ5YWKNfCevW1shbXzwijSg0ydQ
	BIdJpsImCfqfCNKrSkLyrFYPO8ev6ybkJuVUxGAqYfb49ysHfb07v
X-Received: by 2002:a05:690e:408f:b0:679:ba28:1279 with SMTP id
 956f58d0204a3-67a7b992be3mr479992d50.10.1793134636901; Tue, 27 Oct 2026
 13:57:16 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023002056.6647-1-emil@etsalapatis.com> <20261023002056.6647-6-emil@etsalapatis.com>
 <DMFVROPTON36.3LX4QMXFDA91K@gmail.com>
In-Reply-To: <DMFVROPTON36.3LX4QMXFDA91K@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Tue, 27 Oct 2026 20:57:05 +0000
X-Gm-Features: AclHuK8xv9ryDClT_nZevT8wTjsQF3oy0nNK95q8wI9z4B8PqU7yIBpZm7QjRGw
Message-ID: <CABFh=a704QpvYLiTq7h7VO0KK6bsFWRamz87mgS9=7=Mt=B_aw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 5/7] selftests/bpf: libarena: Refill local
 caches in batches
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 7:51=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Oct 22, 2026 at 05:20 PM Emil Tsalapatis <emil@etsalapatis.com> w=
rote:
> > +     if (buddy_alloc_bulk(buddy, size, BUDDY_CACHE_BATCH_ORDER,
> > +                          (void __arena * __arena *)slots->objects))
> > +             return NULL;
>
> This asks for one block of order + 3. When the existing chunks have free
> objects of this order, but no such block, it goes to buddy_chunk_get().
> Before this patch the existing chunks served such buddy_alloc().
>
> A sleepable prog takes another 1 MiB chunk.
> A non-sleepable prog loses 1 MiB of buddy->vaddr in every buddy_alloc():
>
>   buddy_alloc()                       the cache is empty
>     buddy_cache_refill()
>       buddy_alloc_bulk()              no free block of order + 3
>         buddy_chunk_get()
>           buddy_alloc_arena_vaddr()   buddy->vaddr +=3D 1 MiB
>           bpf_arena_free_pages()      deferred to a worker
>           bpf_arena_alloc_pages()     the range is still reserved: NULL
>     buddy_alloc_memory()              one object from the existing chunks
>                                       the cache is still empty
>
> After 1024 of them buddy_alloc_arena_vaddr() fails for sleepable progs
> too.
>
> Should the refill look at the existing chunks only,
> like buddy_alloc_nogrow() in your other series?

I think that'd be a fair policy, the downside would be that
consecutive allocations
would fall through the cache, but that's a fair tradeoff. It's easier
for a user to
preallocate memory into the allocator from the mapping as opposed to having
to deal with the fragmentation you're describing.
