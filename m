Received: from mail-wm2-f1.google.com (mail-wm2-f1.google.com [74.125.225.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B47305968
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 20:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785874494; cv=none; b=Ix9lcaxnbeHjpqARNfvnwVCOqnjikuQeUcx3FIfP53diADcLhg9L6zEFJf33XjJVrhVDlPouQ88IvaBNDi+JpIorqiYHnSCImKga6bJ1Hbx1n7Am8HB+1XXKBasHczZ1+KwHyUtsmE2q4LE0QALF3Ny5d6sKs5WhCBtN9abDX5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785874494; c=relaxed/simple;
	bh=OOzvlEsue/z36UCVUhMjGidTpzQit6SMK2xkZ82iEcw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=aIu8ViWddk1nEXGOnd2Q3nkFZIJy/SH/7dxSo6J9Qat0fx+oQgyBN2LTmFYLDm5ofjlzec9wg1B2qQBLDihBFpqgoYilavtS819avEjkMnDRPuXGWeQwBoF5I93J63LtwB8tblwmviJ0JFeeniEt8EyiE3rFkKPXrPPCK9+3jCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPdLRK/T; arc=none smtp.client-ip=74.125.225.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPdLRK/T"
Received: by mail-wm2-f1.google.com with SMTP id 5b1f17b1804b1-492367f3094so698575e9.0
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 13:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785874491; x=1786479291; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0Hc9Qph+nzqPbcigZWQqDpHId53Plqm5cECJUjTE8do=;
        b=UPdLRK/TP8/CoJq7eCTmZ07orhvKEM2qeJmYfO8368VueE8ZscZLb5M/YbZrL14Sf3
         MkmEbx4S0Y1a6zGl7dcIqr4vhBp2z+IZYUpavX5H7Y/4GehG33dT+vsNTnQFNdhU+MBT
         8LhBVzqfWE3Lce+pLNHiRpsfW/6Ybo2BO2s8WhYYT8xYWaiIpVwN9zpkiisQzYJlRd0A
         K6GlfT6ut32WZA5Lz85ur39sMDM6dw+foDRPyQkLAtvffsmxc0HUrfA0JcPVOtWBmamk
         Jy7bsFhsxwG1tMp0XnbOEPJHr1vZ//nJEhyJDEEScqzkretDBaRMqqQpVKMCVIWk26SW
         pGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785874491; x=1786479291;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Hc9Qph+nzqPbcigZWQqDpHId53Plqm5cECJUjTE8do=;
        b=d9CvZ1eQYq5D0xc50HQ/5DX+hk+TooVIooOz1aqxrl70qWKvIRBeUcLK0DNjJ7qt5B
         NjOsCgFo0gzZL0ZK6SzBQxgOl0O26ZeY0hyQ5ezSpzqT6IM4CA2Q/jBy0D4k40kid2tJ
         NPRxg618ET84V8Rcf5ki9H1D1hGcbvP9k7VMSjGjaO1uGuI23BJnAYax5XWZ2v+KxfKc
         bWYkppqWTE9mgczrurJNYwFGL2Swo2bojdiQUh4Et+iyoF29fFlmVsWRv98QQPGXbo5P
         IcdEcYhylmYPAB7wC2cWK5SrD4A9ApwQZFcy6asyta9HuvZz67pPD8R+UAC5EDIZJUpc
         hgsg==
X-Forwarded-Encrypted: i=1; AHgh+RrQ7mI/mUgq/DPsWJb6UJfLn0Lzgxr05ZB14yivUivCINPOGvw4+STsnQS6MjcqRuq4QV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzqgFY+yLCYTlnEpF+C74e+4idyjpqIEd5nkOA5LbdInCiN9+N
	LZ2ZOV/rSeOsqUeaN+20ClwZLtmyOnnXiMDa36ZKHnIkA0WUSuqMF2hZ
X-Gm-Gg: AR+sD10qzdPT4IlX9gqVUE9gj/aEeO5jGNEDFln5Wyuqvy6jxPEIvU4WsBXVkz3hW81
	IVFQ1YFY5a6UYysZ/CfAoj+xJpv2isEQneOkS1QjACrbkYFEcBOtbtC9efhlsh3R31xuaEJBAI7
	r5su+kD96HW5mqd7preAdRZYOApUhFzqe5/4NyF0VTkNPFMvEGh3mcysBhIiyzQjrs0Ki7IE0/e
	OFKx1Cg8CCYKyEWebNrhF2Gt7S1ZBi/m6/vIACkrO27ulryWWWfYRRlb1f14maotp70A+2WInzc
	gp/fkKCKO9B8lNILUMsLbCKVAw6bVNRjaRkYWMwj0uObguPeXFa8s4ROVX5WBG6WgnyCWGNsfzo
	wCH0ry/XSKZ2cdqnfsVqAoBYZErjwZthW0aMpi8NHeBFKdzX6drbJZe3VCFB8Jd3E+FkUv+L17x
	OASKSI91oMFGnrHHVRysxSIyiPWTkb9OqzdmWpPe3sowXy5MbPDgkFNb7oPaxmLynfSJUaS4l07
	0SKMG4lbIjoUWp01vHYy/cQHzyeJGxYMe86mzS4YbUPAes4dHBN3knp6tg57wF4iwaPCv4ggVmH
	YLYS/AquVeyISyLUnXLVFahSCF2UY7ncQa9K3LkVliw47YAqbw==
X-Received: by 2002:a05:600d:105:b0:495:52db:7e8 with SMTP id 5b1f17b1804b1-4994e7e0d93mr5923055e9.19.1785874490768;
        Tue, 04 Aug 2026 13:14:50 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994dfcc737sm26234655e9.1.2026.08.04.13.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:14:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Aug 2026 22:14:49 +0200
Message-Id: <DKGFO6NR1WR4.JUGJA7Q941BU@gmail.com>
Cc: "Tejun Heo" <tj@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 5/9] selftests/bpf: Add kfunc __arena and
 __arena_nullable argument tests
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260803125115.2264733-1-memxor@gmail.com>
 <20260803125115.2264733-6-memxor@gmail.com>
 <7f0d996cbfb2703450b9974d18c9f60ac2a3a959.camel@gmail.com>
In-Reply-To: <7f0d996cbfb2703450b9974d18c9f60ac2a3a959.camel@gmail.com>

On Tue Aug 4, 2026 at 10:01 PM CEST, Eduard Zingerman wrote:
> On Mon, 2026-08-03 at 14:51 +0200, Kumar Kartikeya Dwivedi wrote:
>
> ...
>
>> +SEC("syscall")
>> +__arch_x86_64
>> +__success __retval(0)
>> +int arena_arg_forms(void *ctx)
>> +{
>> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
>> +	u64 __arena *val;
>> +	u64 ret;
>> +
>> +	val =3D bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
>> +	if (!val)
>> +		return 1;
>> +
>> +	/* PTR_TO_ARENA argument */
>> +	*val =3D 41;
>> +	ret =3D bpf_kfunc_arena_arg_test((u64 *)val);
>
> Thinking a bit more about the PTR_TO_ARENA vs SCALAR_VALUE in the
> patch #1. Looking the test cases added, the use case is to pass
> pointers annotated with __attribute__((address_space(1))) to such
> functions, e.g. obtained as:
> - a return value from bpf_arena_alloc_pages
> - or a nested pointer in some arena located structure:
>   struct foo {
>     int __arena *ptr;
>   };
>   ...
>   sturct foo __arena *foo =3D ...;
>   bpf_kfunc_arena_arg_test(foo->ptr);
>
> The way these kfuncs are currently generated in vmlinux.h,
> they lack the address space annotation, and hence you need
> to explicitly do the casting, as here:
>
>   ret =3D bpf_kfunc_arena_arg_test((u64 *)val);

For now they are in bpf_testmod, but your point stands regardless.

>
> This is both inconvenient *and* adds a useless address space cast
> instruction (translation of the cast).
>
> Which leads to several conclusions:
> - We should reach a consensus regarding KF_ARENA* usage, as these
>   kfuncs would clearly benefit from having __arena annotations on
>   parameters (on the BPF side, on the host side these should be
>   declared as plain pointers).

Yes, but even if we do, for the time begin, we won't have support for
automatically emitting it until resolve_btfids changes are done. That said,=
 I
can manually add the annotation for now.

> - In patch #1, it appears that there is no need to allow PTR_TO_ARENA
>   for parameters passed to such a function. At-least I don't see a C
>   code not involving manual casts that would require such support.

This one I don't understand. Why wouldn't we get PTR_TO_ARENA typed paramte=
rs as
arguments?

>
> ...

