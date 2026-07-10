Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862382AEF5
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 01:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783647526; cv=none; b=S5wa2LrZP0Vnim8ErVfCUxP6oeyV0lDFdQ9UctrCzTGo91uCuOqAdopUmabBmw9tI2atud+aJknfwUwOhfrM7rKXQANwwTGeLgISG3OoyM7lkHYzNbrZStS2byw3tq5hs7a7PVc6slXHoG9jTXvTXZqdABP+Snixqrp9DFNj8fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783647526; c=relaxed/simple;
	bh=b9Op4a7FksieZYpZql5js3bioRefx1GAjYFq70Lb5/Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WGbkP2ckCK+0BlTR5xm5zPepH/gZvlDxJ3t8PkgICy+kw/w3+CodvY1P/qvE/CacUgWcBzAoftxXOgGAYXkuzv0nyyXyzmdWPKHe5pzctX6ne1Lrn2E/xFOk0awMIkMEQ4F2gKpIhs4cKkLbAsKN3EryDKrse4hxJwJDo83gYec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYio4Fib; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYio4Fib"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2caced6038eso5144685ad.0
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 18:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783647525; x=1784252325; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1vOUPtmuheHbHOd5insfi387P+JRAIXt84SVTXAPfAQ=;
        b=KYio4FibnZgxMLHOmNEx93iM4Wzt++qRWKq+9zAxWk/GALGN5ixSLYletLNNk1OxvA
         UTWpWNUu8xDADqp84iYGQibb9eGzhAzI+GPSyoKULLSlWAnmBYLFYOfGr7XRDnPDaxOf
         OJr98Qejkvzenb+IicgxUcMVb1cibwxRU3tXYnesJ/gKen0Ef2EaUdf7nrb0S6hzKUdD
         xZRAvt9elIMfl0PZLq8TSDcZ6spXCHEms+An3MKRocEnhZu4H5fSPKMw8C2hTiuYhc/5
         E/yU7vo8OgZQfXLd/Vktn8vgeYooI3REHSfXZHB+0z42V3wRb0+HSipwNW/5YXvI4dNT
         7qsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783647525; x=1784252325;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1vOUPtmuheHbHOd5insfi387P+JRAIXt84SVTXAPfAQ=;
        b=AGxr/U8fVe044TWZKJizRmrQNJ+nAlQTWSO5dU3tj3/6g9PZt1v0vjG+Sjekmn3AjB
         C1CT9JuyKuMPxgD6hLEB7LrPGDaed//IacIWKLsuTiqTKC9+1rvXKyrnZHHIcx9FZe6h
         z1aP7/9iWvxCnyf2+DO4Jk5weF30Jos6I/++uIpL4guEZ8L1DhMs2Q3tfwRHJgMheoyd
         53yPWiGiryBgEZc31ayQnexI848q6QSN1EP2wHEZ8bqZ9/G4K3rN9Q2XaXTVfJH4BTaR
         Ofu/Qtfm0ECO9kP39YB5FGpurK0FCpQ2hFvDT5tMquSg5ret4Kn3S9dKXFb7kf26ub4n
         EZzw==
X-Forwarded-Encrypted: i=1; AHgh+RoErXxZy6E4TmvTlF7rtZOpBsk1SZ1Zv/glYXJ2xWsQi3f+WSGSrQxk2BkkrOnfN2ZEYg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7wSpB1RhUAr2zRv9fJjPZW/C/f5DwxlIvZCBIvr83YLTlnX2x
	jnN64AJmwPmUi+5dfvIwHj7N5WakQ7EmWDRPsLBUxVeE1ChXa0bjAfBb
X-Gm-Gg: AfdE7ckN3Mamf6g16+XKT+jJOMvtT+kOT8oxaZMDh0llnc3jPzLQFA7aM4dzxdNmOhF
	OwpSXZ6pc1xzmbzEnzaTotz+dn4oXQHO32Je32/SBftfOcLOBPGcbtlGVc2mI0pfxtJ7HbNXlvu
	CJ9sginzlonu48Q3J2AMnPNO0mFmNOKQ8ItnmK0e+thBBdHl1xjYryHvM6Hd6a7gTbfzK7GtTPy
	8fUgMKAh+30xflzTP5jxVNHltY7PejPkmVNfrlh8AHHkm1AcLP5Up/7fKBf4v3FuHKxDs0zxjIG
	pLZuO0mdnueku98IqjJR9bQpq4Xf9f6dGieYWFIl0Q2d+tEqA47ZF4kzpQb3qeSZp0ryUJWx7Qm
	YWQzPOyErR0CCFOADwYUvuceOUO7wcIws7cy3ACdoXPHJUndq5tTl/rCgLVgTS/y/kGn4EDjuLP
	97SK860gB3oJRVU2YNH01RwxCTLZNJO+bhh+V3ws7fibkJRw2aWdY=
X-Received: by 2002:a17:903:32d1:b0:2ca:c847:8e41 with SMTP id d9443c01a7336-2ce82bb736amr13304605ad.11.1783647524839;
        Thu, 09 Jul 2026 18:38:44 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf7678sm52502025ad.20.2026.07.09.18.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 18:38:44 -0700 (PDT)
Message-ID: <6e8a7e39e2823970e7045585e6eed37bae3acf89.camel@gmail.com>
Subject: Re: [PATCH bpf-next 10/12] selftests/bpf: Add inline-asm and
 subprog tests for R0:R2 returns
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Thu, 09 Jul 2026 18:38:41 -0700
In-Reply-To: <20260708201030.2161016-1-yonghong.song@linux.dev>
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
	 <20260708201030.2161016-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-08 at 13:10 -0700, Yonghong Song wrote:
> Add inline-asm and subprogram tests for more coverage, including
> BPF-to-BPF cases, kfunc cases, backtracking and liveness. Both positive
> and negative tests are added.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

[...]

> @@ -93,4 +97,25 @@ void test_aggregate_ret(void)
> =C2=A0		run_prog(skel_union_c->progs.aggregate_ret_union_c_test, true);
> =C2=A0
> =C2=A0	aggregate_ret_union_c__destroy(skel_union_c);
> +
> +	skel_run =3D aggregate_ret_run__open_and_load();
> +	if (!ASSERT_OK_PTR(skel_run, "skel_run_open_load"))
> +		return;
> +
> +	/* Inline-asm variant: compiler-version independent, always runs. */
> +	if (test__start_subtest("asm"))
> +		run_prog(skel_run->progs.aggregate_ret_asm_test, false);
> +
> +	/* Struct-by-value kfunc returns, also compiler-version independent. */
> +	if (test__start_subtest("struct"))
> +		run_prog(skel_run->progs.aggregate_ret_struct_test, false);
> +
> +	/* Union-by-value kfunc return, compiler-version independent. */
> +	if (test__start_subtest("union"))
> +		run_prog(skel_run->progs.aggregate_ret_union_test, false);
> +
> +	aggregate_ret_run__destroy(skel_run);
> +
> +	RUN_TESTS(aggregate_ret_func);
> +	RUN_TESTS(aggregate_ret_kfunc);

This can be folded into tools/testing/selftests/bpf/prog_tests/verifier.c.

> =C2=A0}
> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_func.c b/too=
ls/testing/selftests/bpf/progs/aggregate_ret_func.c
> new file mode 100644
> index 000000000000..31e176103374
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
> @@ -0,0 +1,361 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +typedef unsigned __int128 u128;
> +
> +__naked u128 global_agg_good(void)
> +{
> +	asm volatile (
> +	"r0 =3D 0x1234;"	/* low 64 bits */
> +	"r2 =3D 0x5678;"	/* high 64 bits */
> +	"exit;"
> +	);
> +}
> +
> +__naked u128 global_agg_bad(void)
> +{
> +	asm volatile (
> +	"r0 =3D 0;"
> +	"exit;"
> +	);
> +}

C version of tests from a previous patch already checks global vs.
local functions. I suggest dropping that version from C tests and keep
in assembly only to reduce the duplication.

[...]

> +SEC("tc")
> +__success __retval(0)
> +int aggregate_ret_global_union(void *ctx)
> +{
> +	__u64 lo, hi;
> +
> +	asm volatile (
> +	"call %[global_ret_union];"
> +	"%[lo] =3D r0;"
> +	"%[hi] =3D r2;"
> +	: [lo]"=3Dr"(lo), [hi]"=3Dr"(hi)
> +	: __imm(global_ret_union)
> +	: "r0", "r1", "r2", "r3", "r4", "r5");
> +	if (lo !=3D 0x1234)
> +		return 1;
> +	if (hi !=3D 0x5678)
> +		return 2;
> +	return 0;
> +}

And here I'd only keep the C version.

> +__naked struct with_ptr global_ret_struct_ptr(void)
> +{
> +	asm volatile (
> +	"r0 =3D 0;"
> +	"r2 =3D 0;"
> +	"exit;"
> +	);
> +}

[...]

> +static __naked u128 agg_callee(void)
> +{
> +	asm volatile (
> +	"r0 =3D 1;"
> +	"r2 =3D 2;"
> +	"exit;"
> +	);
> +}
> +
> +SEC("tc")
> +__log_level(2)
> +__msg("Live regs before insn:")
> +__msg("0: .12345.... (85) call pc+2")
> +__msg("1: ..2....... (bf) r0 =3D r2")
> +__msg("2: 0......... (95) exit")
> +__msg("3: .......... (b7) r0 =3D 1")
> +__msg("4: 0......... (b7) r2 =3D 2")
> +__msg("5: 0.2....... (95) exit")
> +__naked int aggregate_ret_live(void)
> +{
> +	asm volatile (
> +	"call %[agg_callee];"
> +	"r0 =3D r2;"
> +	"exit;"
> +	:
> +	: [agg_callee]"i"(agg_callee)
> +	: __clobber_all);
> +}

Nit: usually we add such tests to compute_live_registers.c.

[...]

> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_run.c b/tool=
s/testing/selftests/bpf/progs/aggregate_ret_run.c

I think the test cases in this file are by a large degree redundant.
A single test case calling a kfunc returning a small struct and
checking returned values would suffice.

[...]
