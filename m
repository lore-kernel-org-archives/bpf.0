Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653CB4562AA
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873701; cv=none; b=FSw06QG0nznnn4v6hiZjTHbnl0E4lHM135rML3dxi1K7Xq9GVON+DwnaVDvUU16F1qV1z1omeONIL7bwYUpmcmUp+nTaja4ZJt8P2Jsg8PWJ34dMLrSAqhrtypBTVgVNkeVHEA0Pa8EeTp5Mo/w2NQ562nAcxWewIrt+ADSHTNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873701; c=relaxed/simple;
	bh=WhEDAknDWB6UzjIE5dL3vTbbKA40u2ju3T+87k0k0fQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MBLfsd1o4ax1CfWvl9B0L0llacPPv9ZrVnwrJpSrIVW9r24bMByWcdj6vvfd9io09rWkPk1gouW6wq3NryAAABw5It7aYWkGqPfPkbXRkS+OEeuALYeWBXDe1aC4WyUwloidJwbFjr8R+sAHAXaWw0FG+s3GvfaRUdqpr/HQtZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FneBKPoG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FneBKPoG"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2caed617615so3758455ad.3
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 13:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785873700; x=1786478500; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uOQ7xeXOqSCL8G2IAtjA8pQLstQ8M16xjG25FOQDhoA=;
        b=FneBKPoG0iJo1dS8XoFmipshcX5Z/S5BSMu1kBumkDFmZV1BU4eIjWAaev+eGVoOmz
         Sviwn2uli0g/LruEPiehu/Yg0nA8fP99d9mnu3hPtK3cGoR4dwufsXSOq3oymYLkTR6E
         V1JJMjT4MsxpmACEyqc+lGkEWMWoeVGMVGKlhNT/+Bbl5vTERf2tKQPVhYplyzxrkAbW
         yrpuSKVeAUSqRLspXzwzmWlD+cCdohkEslnDfeu3UvGD6xMIkWfme5NA189H0IwphS23
         ko7uS219dg+0qqpmPVXulhuwtEmLrD9R4qtXIy60ag+FhxnQlu36UYHVF4CfE0cb7/wl
         v8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785873700; x=1786478500;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uOQ7xeXOqSCL8G2IAtjA8pQLstQ8M16xjG25FOQDhoA=;
        b=VaaWYcb3khaZ1Xn2G4XUyFEBXp9M7QicbP3MPEyieQNpPo9FyZLZoBeBsrtdsv4ytG
         gLRI0zKzvNhXsFZ2zcc8ewp58vQvoSzKQQb2m5FT97Dk5kBEkiCsxsnz6ALOM9XHwGG2
         lXrMiUNRY9fGheA9BOQ4bkuvdycrNSQW2Dbs3ioER10+IFI6rH2+h1j77MO+gFtAfFA8
         Nbtv5il+1dH3yv2ZFnBJ7Z5JTSv9SFoXcL8cYW1oCkhuzUNejeOwgsNk/cUyMwVzQ+gK
         ND0n8ThwiVQnNgX6ALvTJqIro4lheuxR20MXeW0ESyVYRe18NRZL2+CUeBVGRW8ifHz7
         T5Mw==
X-Forwarded-Encrypted: i=1; AHgh+RqMz685Tl8gdj6912msXgZ+ogN2KMiN0pqGenV8+ShX32BoW2rvMrHNxt5R/YSr/VeQyPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA38Ffl3QFLuIvzrhUkpYk9I5N/BY5j8mpxm1SAIVghqv+hyuT
	kHwarBo/1GbEWw/HXv2r0h5HpYqZCnqBn/obI42O7WXvyghWHOSW/XRS
X-Gm-Gg: AR+sD13VJhQdgBOads6u/7c6Fw5JTfO380ddet9LKNKQGNC5pgSwY8oJRxmmbP6Oq4Z
	J3O0+/dR4YIWGqjqAoek5gho5hLltb1HUxOrdj8qjXlz8GmLU+fG0djN5BLr0GCXjl/tnUVWklE
	bZfHaY2N5vP7hACXBv88+VA75YiiKPGRWbnD9cm4l505H6AZKdXKduJYpPe8uEwUw6UQnywRPYN
	IHaE+J/0OoyDamZAWZW0ExLGJ7eBr1i9Nb0F3rKhureRNyVK+WL/z/tyCYX9t2qfSib/hQHyp+j
	gnmImASSNJHAZqvLNIQjtkSSlvdqEVba3EaVUG9flZv8Hfz0oUd+it/a6k3MAOTtblaTYiNiGLv
	63jWY39dwalESkQHDCZdY6ZrYr5B8OGu0upNQjrK+VfKYQR3z/k9u3WttgbGihi7BMXxokMgr/D
	2kGbtMFHMEIW8d/rBUsi5ASfrSDVSOONZSRhwH2RyKEOyjKaWl18IQ6rjiMokSTL3sT09JRKDv+
	ron1Pi2hyB5lbEo
X-Received: by 2002:a17:902:ea01:b0:2d0:8b28:517c with SMTP id d9443c01a7336-2d0ca712ed0mr12893895ad.3.1785873699712;
        Tue, 04 Aug 2026 13:01:39 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa492c7fsm12740905ad.43.2026.08.04.13.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:01:39 -0700 (PDT)
Message-ID: <7f0d996cbfb2703450b9974d18c9f60ac2a3a959.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 5/9] selftests/bpf: Add kfunc __arena and
 __arena_nullable argument tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis	 <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Tue, 04 Aug 2026 13:01:36 -0700
In-Reply-To: <20260803125115.2264733-6-memxor@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
	 <20260803125115.2264733-6-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-03 at 14:51 +0200, Kumar Kartikeya Dwivedi wrote:

...

> +SEC("syscall")
> +__arch_x86_64
> +__success __retval(0)
> +int arena_arg_forms(void *ctx)
> +{
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> +	u64 __arena *val;
> +	u64 ret;
> +
> +	val =3D bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +	if (!val)
> +		return 1;
> +
> +	/* PTR_TO_ARENA argument */
> +	*val =3D 41;
> +	ret =3D bpf_kfunc_arena_arg_test((u64 *)val);

Thinking a bit more about the PTR_TO_ARENA vs SCALAR_VALUE in the
patch #1. Looking the test cases added, the use case is to pass
pointers annotated with __attribute__((address_space(1))) to such
functions, e.g. obtained as:
- a return value from bpf_arena_alloc_pages
- or a nested pointer in some arena located structure:
  struct foo {
    int __arena *ptr;
  };
  ...
  sturct foo __arena *foo =3D ...;
  bpf_kfunc_arena_arg_test(foo->ptr);

The way these kfuncs are currently generated in vmlinux.h,
they lack the address space annotation, and hence you need
to explicitly do the casting, as here:

  ret =3D bpf_kfunc_arena_arg_test((u64 *)val);

This is both inconvenient *and* adds a useless address space cast
instruction (translation of the cast).

Which leads to several conclusions:
- We should reach a consensus regarding KF_ARENA* usage, as these
  kfuncs would clearly benefit from having __arena annotations on
  parameters (on the BPF side, on the host side these should be
  declared as plain pointers).
- In patch #1, it appears that there is no need to allow PTR_TO_ARENA
  for parameters passed to such a function. At-least I don't see a C
  code not involving manual casts that would require such support.

...
