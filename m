Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3EB38F64D
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 04:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786077856; cv=none; b=fE7PjpDxmj4yZ6Mslth/4wMIZE4IO8MbYPprOVl9X0CkuG+RIHjhN0mtwR0dw/V0fZXxCoeSRydRQXuadfAHQNFdUETdCIUoBE6cmvKYQsHjDBlRDioft/p6hanWXlPA9LhxdemuO/bvTohmssw2EQ+jUuJtzpA5O+5KeIAim18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786077856; c=relaxed/simple;
	bh=6TLy9NCfKpazbzlVWfdFx1ijYknk5gN7s1QfIbczkr0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UL1i25u0igbM4+JwBh+fo9Pk4yKgZB0Lz+M6KZQ2vYa7Vc2eG6gZ3k8ujuNm13cJcgwLv5jeTzgMKtaBHixfowC51mOUXOnnvon38izi8cWFMcBmIuUQW+/vtdCZC5000w4pwcIWcCiqaeDz0qjQW7dYaDFPgXpxKbk6IqWQP5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMZtNVZ4; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMZtNVZ4"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d0407aedd6so33258445ad.0
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 21:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786077854; x=1786682654; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9y2425lEXLqJ/75VbJIdsm5rYMg6Aco3sQF8oJHj0hQ=;
        b=LMZtNVZ4YbTn5AbTnwOTkKUNWMy2DbP9McfL7L9CA/7nRUHs8idicMaWdAJAgZ2B3t
         NCkVPUrlh2u+QCpNtOaMYlIIj1TJPwxqo3+N8WEn0xbZn/nUTmgOXk96BElYnhdlcKJH
         II9LjDHwm+JfDKc23DiLupcChyBG0bVtDYiK2HI/Rxejz8y6VLKKSSvzEVRyBBte33qu
         JfU4GgE+WeNJRju2iXG67/oZqSVQ5G2PuH51w8L3w+BC8yMZ5wAV7mYAJJoB9MONhWCv
         P4knAu8tepRszrma4sYxDxfcxZqJd2QR7irjhM//z4Y73NadoLXzAWWRRQj19eRWDLte
         Q7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786077855; x=1786682655;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9y2425lEXLqJ/75VbJIdsm5rYMg6Aco3sQF8oJHj0hQ=;
        b=rgUqAMOokHww5fpXVugWR0HByUl6DhqjZtxsBrAD8AC1dGomDN31cb8/15O7FIZ1rM
         eFyFo2zVedgJkiCPBqMLqaAz4nDz6U/SilB7TvZvT+7f/BPACfLELJk1rgda0WmP9tUc
         PDA4OgSFIx9DQNCkrB1tdBBr96WyORotj8mHODgIYIfjXlg/l4LgOxTWU2pMghGyrmgh
         SuIS3xgDbi7rh3qG0lYXzj+QanumlTRQIpr4rPovS1i0JN8ndIDSO9n4CdIuRrl80dIj
         D6B1XYJDGtXpONemgI96ze/x3H6VgfJr+VZXXcqPAM/Veow6aI1JqobdAgQ7ap/+9/K3
         m+7w==
X-Forwarded-Encrypted: i=1; AHgh+Rrle/NPDrC3aNGe/qYjDu0+Z36AaymmfSyjZsD0ly2W/MP2WS436MEqQfX3Uwvm+QMN4LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvDREqGDxE97lAlQoED31Vx9dqHk5qTgQutkgU7YKIbv3k4eop
	hCeOL02ErS/PWC0jSH5wmqxViMR7JC+wr+8J7dPvcVhK9vj0qk6huEHV
X-Gm-Gg: AR+sD12GeRKgxnn3M2hc6pQvFDs+I/gO+FbzqPKM9N8923xgh9ZqAsXCqUic1FMCAiq
	MjgBcvw7i8LCgaMexM/+BjGgfSWTshJt/XSDyJRtFMdCx0Ehl7/K7gW64EzYzoMRvWLTbO5Kflt
	/RqrvzsUYwZX2T+RBiTyLy6dVWYvGQS54rvzQX2WmZiKMcdM9qm2T1q/xRuQQm7T8RLjzkKc+i2
	UVOHQ+7PVX++B3gu5bQPw26d5oJIlQwqMbFuHFmw2ndk4EsMeKiIYNMzlEoF3BJ5qWLwS2kDSAn
	5nzuKwOUPDyD7JxZRoPm/u8Sx46l8Q5i9v970cVU+2h1X4/OIGTlQQTKyzzGejH8+JtoCL7lINI
	p6B4wj09RWjszw5rCQX6fBOTDGYzBwCjTCBjkmKcr4sSBIdnG+66nfAvty2+ChUVaun1k2WenXE
	88VQGasF+A+WbbezibyUpaxQljYVIBj06wbsA2PzGCvl3RmchPvw6X6/jTVm7Val0NJiGEP61sj
	0UK0XHaF2x19Shg
X-Received: by 2002:a17:902:c40d:b0:2c9:9a19:df with SMTP id d9443c01a7336-2d0ca945b59mr224474795ad.18.1786077854498;
        Thu, 06 Aug 2026 21:44:14 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4e9a01sm2700685ad.77.2026.08.06.21.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 21:44:14 -0700 (PDT)
Message-ID: <8cb9a9537d806b3d8f9d5798d03fd290adf7e8ac.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 08/13] selftests/bpf: Add kfunc __arena and
 __arena__nullable argument tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis	 <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 06 Aug 2026 21:44:11 -0700
In-Reply-To: <20260805210427.3218326-9-memxor@gmail.com>
References: <20260805210427.3218326-1-memxor@gmail.com>
	 <20260805210427.3218326-9-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-05 at 23:04 +0200, Kumar Kartikeya Dwivedi wrote:
> From: Tejun Heo <tj@kernel.org>
>=20
> Add arena-argument kfuncs to bpf_testmod, which also exercises the
> argument rebasing on module kfuncs, and tests covering the accepted
> argument forms (arena pointer, low 32 bits as a scalar, full user
> address as a scalar), the exact rebase semantics via capture kfuncs
> returning the raw argument (zero low 32 bits arrive as the arena kernel
> base under __arena and as NULL under __arena__nullable), a NULL round
> trip through a nullable deref kfunc, five arena arguments in one call, a
> mixed __arena plus __arena__nullable call exercising both bitmasks on one
> call site, a kernel-side dereference of an unpopulated page recovering
> through the scratch page, and the rejections (no arena in the program,
> incompatible register type).
>=20
> The tests run on x86-64 and skip elsewhere, as programs with
> arena-tagged kfunc args fail verification where the JIT lacks support.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...

> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index b79bafca68f7..7eaee71783b6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -2,6 +2,7 @@
> =C2=A0
> =C2=A0#include <test_progs.h>
> =C2=A0
> +#include "arena_kfunc.skel.h"
> =C2=A0#include "cap_helpers.h"
> =C2=A0#include "verifier_align.skel.h"
> =C2=A0#include "verifier_and.skel.h"
> @@ -161,6 +162,13 @@ static void run_tests_aux(const char *skel_name,
> =C2=A0
> =C2=A0#define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL)
> =C2=A0
> +/*
> + * The test kfuncs live in bpf_testmod. Resolving kfuncs against module
> + * BTFs needs CAP_SYS_ADMIN, so run with full capabilities instead of
> + * through the verifier tests' capability-restricted runner.
> + */

Nit: useless comment.

> +void test_arena_kfunc(void)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { RUN_TESTS=
(arena_kfunc); }
> +
> =C2=A0void test_verifier_align(void)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { RUN(verifier_align=
); }
> =C2=A0void test_verifier_and(void)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { RUN(verif=
ier_and); }
> =C2=A0void test_verifier_arena(void)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { RUN(verifier_arena=
); }
> diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/test=
ing/selftests/bpf/progs/arena_kfunc.c
> new file mode 100644
> index 000000000000..d6c382ce81af
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c

...

> +SEC("syscall")
> +__arch_x86_64
> +__success __retval(0)
> +int arena_arg_rebase(void *ctx)
> +{
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> +	u64 __arena *val;
> +	u64 base, off;
> +
> +	val =3D bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +	if (!val)
> +		return 1;
> +
> +	base =3D bpf_kfunc_arena_cap_test(NULL);
> +	if (!base)
> +		return 2;
> +
> +	/* only the low 32 bits contribute */
> +	stash =3D 0xbadc0ffe00000000;
> +	if (bpf_kfunc_arena_cap_test((u64 *)stash) !=3D base)
> +		return 3;
> +
> +	off =3D (u32)(u64)val;
> +	if (bpf_kfunc_arena_cap_test((u64 *)val) !=3D base + off)
> +		return 4;
> +
> +	if (bpf_kfunc_arena_cap_nullable_test(NULL) !=3D 0)
> +		return 5;
> +
> +	stash =3D 0xbadc0ffe00000000;
> +	if (bpf_kfunc_arena_cap_nullable_test((u64 *)stash) !=3D 0)
> +		return 6;
> +
> +	if (bpf_kfunc_arena_cap_nullable_test((u64 *)val) !=3D base + off)
> +		return 7;
> +
> +	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
> +#endif
> +	return 0;
> +}
> +
> +SEC("syscall")
> +__arch_x86_64
> +__success __retval(0)
> +int arena_arg_nullable(void *ctx)

Nit: This test seem to test the same thing as the group of
     bpf_kfunc_arena_cap_nullable_test() in the previous test.
     I'd drop the one or the other.

> +{
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> +	u64 __arena *val;
> +	u64 ret;
> +
> +	val =3D bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +	if (!val)
> +		return 1;
> +
> +	*val =3D 41;
> +	ret =3D bpf_kfunc_arena_nullable_arg_test((u64 *)val);
> +	if (ret !=3D 41 || *val !=3D 42)
> +		return 2;
> +
> +	if (bpf_kfunc_arena_nullable_arg_test(NULL) !=3D 0xdeadbeef)
> +		return 3;
> +
> +	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
> +#endif
> +	return 0;
> +}

...
