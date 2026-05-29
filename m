Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CE236CE19
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780094253; cv=none; b=SBD2Z+1mCWlm4+y3x+mNel+N/B9jYgVQS/n2xFKqvQ6oK2GZ1Omuf4MZXMPHHRu5YyEFisU7haImSF9uZMbghlS2xoBbSgMHXfi81aAtp+kvra5E/YIukjotoKAU93Af9+4imZxbxDSxJxkyXwM9HogbF4qxUhQu7o+VcMSyuKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780094253; c=relaxed/simple;
	bh=FginVhoNglPXigc//BEnYWTzVxWWHnXA48qMiUZpl3A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YtXEQj0ApsinVxzwQOuSSktYpIEXhaqBnfmB07Mydg5lrEI1S6vYu3KBPIKd5iX3+pMRap2RkYLWMMRrJTnJCi+rnpbn01eMkLRHR7onJOhUJFGXQf1Raxx8hTZAOKllT4Nn/OTcaZmTEjUNUyRPs4bHxenWDKIpKqO4sVXCO7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEKSqcnS; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEKSqcnS"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-69de4000a57so1994857eaf.0
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 15:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780094251; x=1780699051; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4KBaLHtpd4tBbBBMqaBEm/aPrD0ixQqzF08JWKnme4=;
        b=cEKSqcnSrD07a8UTMfvl8Dw4U8UIiEArFF4HeKPcflKZNSEIRe5CcKj3cmcrZcX3DI
         YvrLcf9hAxA78p92zJuBG6Rkq4ROuQJwHZkISwZ6u+l7Re5g+5dTWHNMUBrA3u+s037M
         nZfGRo1qrTwi1Fhg2LkM+dWvFTGmMQxyS6fjhKHFLimiGamxUMgHlflvZEREfttUuNJT
         KNh8NlHQASJjx7Fp2+C5pPZ8iFWVvogmH2X/UOB44G0+10xzni3D2wBMTmkmH21BWvBd
         xUyzXeOXwQdIMV6BQCiLJu5mKsqNv1+6GsiXrFfkl43LMtHNSaBxgeaZYVjG2ysOGD7p
         rHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780094251; x=1780699051;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X4KBaLHtpd4tBbBBMqaBEm/aPrD0ixQqzF08JWKnme4=;
        b=sd5FP5lDk/blFuXrdl016nzK3VNM0g9lHAMvF40LHWCQt24NHs+D5qcY/sRwUo8g8y
         Jl/0BzilS3HDz0BXNobIM6rD2J5CUxXisBLs1oeac4ImxBVpSjbHolouTB51eLZC0x5P
         ii+JYl0789JkNIj4S7t2tS3aDIeV8n4REYlCJWRiRxOMFCbRzulsKLYJYeZqiwbPLNqr
         26Z7ud4GIRAGPC/qif+//X3kIrjIPY9bakFiMMbO+OJFpOZgYPXKWxT9qfj8WbCe5iIR
         GYm0qnAYbrhbfayTLpqiQ13sdQM4GEFWWEGxB1+ovrPFcdCSzVq1q1RsTMvwf07FWFt+
         Leig==
X-Gm-Message-State: AOJu0YzEgHkT1t0flPp/IFD44tyeiRXSzc5nS+4Cfa7NjxxVfEcRdpav
	SLScbD5ZbEU+y0qwhdl1fmIH0oYKCE0NBcxA6LrvzadOaaR3xg+ZCPsF+RG5fw==
X-Gm-Gg: Acq92OE+qyEswldryR2Rzbz2e62t0xMoUnVUXU7+JekXiEZP4hVl8n0bg17dJ4/1bHj
	k8GC+fsdp6pyMWZUpjpg/v6xtczmW6t2e+1u907Z3kQFHlFkPALWM+N4/VV+WU5b1KxMQSSXg2E
	6Npusv/c7E6PLlnmvNZKG5KSmYeIk3UEH/I4MWnkXPLVsGu9aySs6INas1Piz7grG8WLWyNKxFX
	XSMZ4yeNF7KooqgwC3roZrCn2k7NhivzRelxgcK1jniXfSh3fNuRsfpDIzvEcQIX5o9JOI9uc2+
	65mzbMpxTY0KM8GYWrwQ6Y2ASVTHuEFT54ZbkyytQ1frXo5h4UfvjQ3lEthEYlBo67x8Auku3C4
	Td5VchHQF1nc1OOPivTsulsv3MhpPk2Ch8p1Hm8JzUwaPCCQH5ieVoCYghBnXjNC6g/Au3G12o6
	UTkAw7mGzuLBvoucEIrENZU8ezra5VlXI46Ese3nkRzjAlgKiy90uCm+WG25hpVmPuaksBfRDsX
	NS9RReNWum2gnbza7niT2Io
X-Received: by 2002:a05:6820:2d0b:b0:696:7f3d:a75d with SMTP id 006d021491bc7-69e0ff718femr609756eaf.27.1780094251002;
        Fri, 29 May 2026 15:37:31 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e067e911csm1753298eaf.5.2026.05.29.15.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 15:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 15:37:29 -0700
Message-Id: <DIVIQWQ6F4JO.2R4XIOS9DDDS@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/4] slab: Introduce kmem_cache_alloc_nolock()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc
References: <20260529202438.16408-2-alexei.starovoitov@gmail.com>
 <20260529212021.380AC1F00893@smtp.kernel.org>
In-Reply-To: <20260529212021.380AC1F00893@smtp.kernel.org>

On Fri May 29, 2026 at 2:20 PM PDT, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] Deadlock in NMI context due to synchronous freeing on memcg =
charging failure
> --
>
> commit 831b8a379d6dfbde2570286ba8453174bc236695
> Author: Alexei Starovoitov <ast@kernel.org>
>
> slab: Introduce kmem_cache_alloc_nolock()
>
> This commit introduces kmem_cache_alloc_nolock_noprof() and its wrapper=
=20
> kmem_cache_alloc_nolock(). It is designed to allocate an object from a
> specific cache and aims to be safe to call from any context, including NM=
I
> and IRQ-off environments.
>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index a2bf3756ca7d0..601986aaebdfc 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
> [ ... ]
>> @@ -5402,6 +5402,45 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gf=
p_flags, int node)
>>  }
>>  EXPORT_SYMBOL_GPL(kmalloc_nolock_noprof);
>> =20
>> +/**
>> + * kmem_cache_alloc_nolock - Allocate one object from a specific cache,
>> + * safe from any context (including NMI/IRQ-off), like kmalloc_nolock()=
.
>> + *
>> + * Returns NULL on failure (including the trylock paths that may transi=
ently
>> + * fail under contention).
>> + */
>> +void *kmem_cache_alloc_nolock_noprof(struct kmem_cache *s, gfp_t gfp_fl=
ags,
>> +				     int node)
>> +{
>> +	gfp_t alloc_gfp =3D __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags;
>> +	void *ret;
>> +
>> +	VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO |
>> +				      __GFP_NO_OBJ_EXT));
> [ ... ]
>> +	maybe_wipe_obj_freeptr(s, ret);
>> +	slab_post_alloc_hook(s, NULL, alloc_gfp, 1, &ret,
>> +			     slab_want_init_on_alloc(alloc_gfp, s),
>> +			     s->object_size);
>
> [Severity: Critical]
> Does this sequence risk a hard deadlock if called from NMI context?
>
> The function permits __GFP_ACCOUNT, but if memory cgroup charging fails
> inside memcg_slab_post_alloc_hook(), it synchronously aborts the allocati=
on:
>
> mm/slub.c:memcg_slab_post_alloc_hook() {
>     ...
>     if (memcg_alloc_charge_slab(s, alloc_gfp, lru, p, size)) {
>         for (i =3D 0; i < size; i++)
>             memcg_alloc_abort_single(s, p[i]);
>     ...
> }
>
> This calls memcg_alloc_abort_single(), which immediately attempts to free
> the object:
>
> mm/slub.c:memcg_alloc_abort_single() {
>     ...
>     if (likely(slab_free_hook(s, object, slab_want_init_on_free(s), false=
)))
>         __slab_free(s, slab, object, object, 1, _RET_IP_);
>     ...
> }
>
> Both slab_free_hook() (via kmemleak and kfence hooks) and __slab_free()
> will attempt to acquire non-NMI-safe spinlocks like n->list_lock. If the
> interrupted context was holding these locks, wouldn't this synchronous fr=
ee
> cause a deadlock, breaking the "safe from any context" guarantee?

sashiko should have said that it's a pre-existing issue,
since kmalloc_nolock() follows exact same pattern.
Also patch 3 switches __slab_free() to use trylock.
So not really an issue.

