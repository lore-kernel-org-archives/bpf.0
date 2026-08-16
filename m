Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2263A6B6F
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786922245; cv=none; b=pDRgyFl1FlEYq9HSMMbdEhi2TNw1P/R5L5jcOg/+AiVUaEINaJfN5MawFGRc0ixsOARbr87HVkJmLBgjCMdWTioT3dLbawI39z/Lw9AB9AC+0EJmsHfiXas6bPh6TmSADKthk9vw/stOubUIXw1lfDojJOKRtmZ20mILbSFOMGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786922245; c=relaxed/simple;
	bh=orlL/s+0UfGhO31zaJ/3W8YeQ3MSg7gTeXGZ5qRQ5EQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AGoxWAAiJ9jJMOMJwZrduQIl6WlIg9vrQPTLw/OyaVh/qLhjyH7amUu4y9j2iwvSsdI4hK3CDqxPoeEFIQjnQ9c2V2R/cnaz+tQc/oZCaq5s8l8mYoRl/xxGQnLBPatuD+N1Ov24g+n8zDv5RdEajAZ5B0O5ePbD5tzFEjX8/QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUDSP2hp; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUDSP2hp"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso3729442a91.2
        for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 16:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786922243; x=1787527043; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ucrgPcpj7nxeCtN9HT0N9KMvy3swFcYQyW8EFS22f1M=;
        b=FUDSP2hpoLQjY0jKVSxpDZcv6rMboedMDhXXYKAlPUChWJb7xZ2nqq69JxMDTFF/GP
         o26FLv5AtMmCsh+usjvPV1mAsz6BIspH5n1MzE44eWA3vvGd0vUAfBx1cavi0FFRsp4C
         KPYHfn6nnZUbWv5Zi/9ABQNDYlEd1FG3ymyt6o87p2PWIhNUYzs9J+Dy9BxKztSSmQ8o
         Rr/gWcHRwtumu8Knle6/sar7i5Z6B2Q/AYv4OM3HYVkYb9iaRHBbW1CcYnLWNiIvV9ox
         VvZv8XKxi1X9O9JA5IadI+vIqCS3Z8/j8004Wes9Bc6q0UBCpNpZzhbaEsXTkVYPUCZs
         N3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786922243; x=1787527043;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ucrgPcpj7nxeCtN9HT0N9KMvy3swFcYQyW8EFS22f1M=;
        b=hjOrdXrQQQlTh/1ocruDBm5u6j0vPU9tYAfBKX0nvg9vB3RRBAUtluNtnAH1kKni+q
         w3/zAbZkS9RQoiFhwGeS9axrmFSjC9oRnneAZcWIY9cvk2QeG8/etU8BeJ5ZVrmc7Il2
         8k1xtMRvG7ISPKeXmQYvjSSH1Lu1cI7TOQGeasWdf/iWGLxUrMJAz6Is78S6KFCevnpM
         y0/RAl8DJ6XdTjYn/oalpXbyxqFdUAUsOEzlyxYuo3eREtUMHlpa9S3p4oO07IOn9K3s
         zz2UQGVsrQqcV47ejboHRt7W/PNctFMM7/zAzPJB/g6L5piuQ0vT2FtsVUu4TutCqrey
         GOqQ==
X-Gm-Message-State: AOJu0YyL+fe2YtxZmD7AmKdu7DfwqgfpxRXc3RXRoUZ0XEgq7Y/us8w3
	2uu03lbytLu8FnK1GKRmWXJwqo1DVdcGnvSksbSgqIujZi/KQWOWzBIA
X-Gm-Gg: AR+sD139Fymb6NUj2khRYYFFT3zXknOCg5p3PzEhfvVzX6ADpn8cTuVSATkzyOml+E3
	ysvgCEMpUFkDAUzvim/4UEljs/6YZxKW5+r4jEH7OBC8ffxC8QG7OUfSom10CBs5+5W4HJDxDRG
	Gx4zZYE6vB9S7Y7EajlcOOj6cAWg9f6pBy6Hx9w3zWkvh9hKqst8vHrcDGakgoRtUXh3P35qMtL
	zl4H8J7UXmxSYYHGodDYNWWexkI6tlY8APa20Ak/r6EaJ7b8mxnoNBO6leo+mUyNK2TfCQqlp/v
	T6rZdeujqGSoduVc9cyXCIAXXlPOMJ1q042T/L30qUEk17IEYYXazyhDNuuY2cS9pcYescwwwOJ
	FvqT2+NfaHuv0P9yPOJQ18GKjOJiOFdNAT8QFs0CE/5pfolkgVjk9MXORWG7rRNcLjiaRS5ySUB
	xO49AMREjetp5S/W7AXKKE3a/IX39ROcUaYwbJVMgOUuzPpJR02/YaD2JrGKhfiswl7RO41mQi5
	db70lK2NUdJbRIG
X-Received: by 2002:a17:90b:2e90:b0:392:c80c:9202 with SMTP id 98e67ed59e1d1-3933b8a399dmr22513992a91.14.1786922243214;
        Sun, 16 Aug 2026 16:17:23 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531eca993sm2583640a91.14.2026.08.16.16.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 16:17:22 -0700 (PDT)
Message-ID: <cd62cd53be9bcea2d5b63fef8eece815f5095103.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Cover mixed arena and
 stack atomics
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>, Alexei Starovoitov
	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Kumar
 Kartikeya Dwivedi
	 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
	 <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Sun, 16 Aug 2026 16:17:19 -0700
In-Reply-To: <20260816-bpf-next-038-mixed-atomic-v1-v2-2-4644c1886dbc@mails.tsinghua.edu.cn>
References: 
	<20260816-bpf-next-038-mixed-atomic-v1-v2-0-4644c1886dbc@mails.tsinghua.edu.cn>
	 <20260816-bpf-next-038-mixed-atomic-v1-v2-2-4644c1886dbc@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-16 at 10:56 +0000, Yiyang Chen wrote:
> Add a verifier test with one atomic RMW instruction reached through
> PTR_TO_ARENA and PTR_TO_STACK paths. The verifier must reject the
> shared instruction with the existing incompatible-pointer diagnostic.
>=20
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> ---
> =C2=A0tools/testing/selftests/bpf/progs/verifier_arena.c | 39 +++++++++++=
+++++++++++
> =C2=A01 file changed, 39 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/t=
esting/selftests/bpf/progs/verifier_arena.c
> index b241bbcf54a8a..b22bab33301ab 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
> @@ -637,6 +637,45 @@ int non_arena_ptr_add_to_arena_ptr(void *ctx)
> =C2=A0
> =C2=A0#endif
> =C2=A0
> +static const struct bpf_insn addr_space_cast_insn =3D {
> +	.code =3D 0xbf,
> +	.dst_reg =3D BPF_REG_7,
> +	.src_reg =3D BPF_REG_7,
> +	.off =3D 1,
> +	.imm =3D 1,
> +};
> +
> +SEC("socket")
> +__description("arena and stack atomic at the same instruction")
> +__failure __msg("same insn cannot be used with different pointers")
> +__arch_x86_64
> +__load_if_JITed()
> +__naked void mixed_arena_stack_atomic(void)
> +{
> +	asm volatile ("					\
> +	r1 =3D %[arena] ll;				\
> +	r6 =3D r10;					\
> +	r6 +=3D -8;					\
> +	r9 =3D 0;					\
> +	*(u64 *)(r6 + 0) =3D r9;			\
> +	r7 =3D 8192;					\
> +	.8byte %[addr_space_cast];			\

I'm going to fix this to:

	r7 =3D addr_space_cast(r7, 0, 1);			\

as in the test case above.
Waiting for CI [1].

[1] https://github.com/kernel-patches/bpf/pull/13325

> +	call %[bpf_get_prandom_u32];			\
> +	if w0 !=3D 0 goto 1f;				\
> +	r8 =3D r6;					\
> +	goto 2f;					\
> +1:	r8 =3D r7;					\
> +2:	r9 =3D 1;					\
> +	lock *(u64 *)(r8 + 0) +=3D r9;			\
> +	r0 =3D 0;					\
> +	exit;						\
> +"	:
> +	: __imm_addr(arena),
> +	=C2=A0 __imm_insn(addr_space_cast, addr_space_cast_insn),
> +	=C2=A0 __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> =C2=A0static __noinline
> =C2=A0u32 __arena *check_arena_arg_nonglobal(u32 __arena *arg)
> =C2=A0{
