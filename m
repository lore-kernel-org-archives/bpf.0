Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA08213D539
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 00:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786579761; cv=none; b=BlWbzetRK4TU19lnHZz21CLYQCZDbaPJzCIqgIHVxOTsFA63oJdT4jX2iCH6pgVtqT66QtvpMmJpFGlcqI0QImUkqQMYd5VCV2twqJ3WlhMNrvFYxroupzizSehIynYmKD4i6Xe/z1koDd69pXb8jqWYwdtLgAwOzp/+rrQqg4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786579761; c=relaxed/simple;
	bh=2NHEeGth8+jJkaI4XCqgm/dC8RdQgQok9DPE7YDHsCU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XMo4EnYRtsHGM9HpLhUAkq2rVWJ3nnKjBaLkr3y2XvBMhJDzgaiv4+e1Qk4R5xySmqVDH/JsJWO/TSZ2rSvbBjFI+7FoFeWjs+URUWTTZW+b4n2EOvuVX98+tZQt4QLoH95lVH4xjGHvQTcdW5iYbBjn4xb8qsbgSYtEmlSJNnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGIm+t7/; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGIm+t7/"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e347638adso248653a91.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 17:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786579759; x=1787184559; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Vwurny64T7j4KQFiaC/aeNetlzh2+QT6J9FjqtPV8UA=;
        b=lGIm+t7/Fb6Lw/77P62IWgZIpWwxMvUhXzzhf6VYuSXfO+v19V9zD57ueYJDsQVpvX
         ZuIIz86V9HNzqIYoKhjQTdnRLx8W9+IrnFh+/xoyksA1nQE4BH9xk4Omp4QeSQSBvIXz
         VyXBguWrbga/tXAIAx8E3lulF1fI/4hHn5aHdp40PZJ3eyaaUvQ9TyuRGrZPtlcAmgBd
         Er0UBHQVpjuNq+07wiCtmVPhi7CpGq1EPLaf31mZchLNnsKFFp5ns+Xme3ZbgyeBl+tY
         EvsS+idD7SFOHvAHHmi/dcwu+Fj6ANi8fhs4qDDMiBGfNLwo146z+FrD5xFHZKMv6n2U
         gl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786579759; x=1787184559;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vwurny64T7j4KQFiaC/aeNetlzh2+QT6J9FjqtPV8UA=;
        b=B8ysyQXGj7jWVaiIO5crBDXsF7zXs/b4Oou28NtsM45iZx5k6ohIrVjx41TAMskFX9
         1gn+UuYp/DUJX127K3lLOqEvQx/Qz9fz5qgvRUWatiUSTWK39dkECOOCxofKDceKzrzA
         YeONaQFLOj6vbGOEgBSI+0bQvKc7ZHyMPUuGIPlZEcHYDJgvEhCB/Azlrj2YyX/4bU/b
         n0lPZcR2NOu1t/2dWl/rGfOLbXH/W6wnrnUCiluBp/nBhi7uatJMNGf6Wmks43tmWCLN
         uLXVG8Ne5whIiG8qzx/ShM4y1UjKzMdN/DA4QV28Iov32NZOpm6SGWoKXky5JWJ96Osh
         G/9g==
X-Forwarded-Encrypted: i=1; AHgh+RpHIhR3aenwDRBimpUe2Ovk5M+oMlyZIuiob5X/p5ucXFcRKGRhXqVwqdY0gWavqpuVJz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ0ZcbKvhCPxjLt5b19e2RpVBezXfSck6omKcAe9PfEAIzb8wa
	5LkJFEXPsdH6Kq2NHmszGaZ4AwScm344S8Di31bzprG9XM8IIb0NyCez
X-Gm-Gg: AR+sD12n+YDTKsuXjY4EhHO1rbqFRP3H4W69cTK7IoVgzwvGMxphBkqnDlHbB9xlvcy
	UV4VIFcWkDPiZs1vZOqPRN1oRzWfxEao9iVd7VKZVIDJxqQ2i+ap26dGthHgmk1Ua6LBpf4i1QI
	/t3tNkGKnusx47nse2oomsTFdaRZx4AhEZ5x1BCumSUL9dKaVtSq0XrYOJdDfBXISEA6hJZupT7
	ja9/MQLXO8dEcdWj3l58xBMIwCgOZYd5o93pwm3seUwtVnRNl3puUSxQ1ZCUUUFuEpl1PiO73lb
	QuBkoLjQTf6LnagLCFpCG1W/1u0FCUrL0E4s8wc4H+ckE0Hfb1UApo6bf0deMRD+M5qBDjjOXj/
	9B1KMwNZdUCfvyqkegRMfo8riHN8iBBTJ/EE1SNmL6CAc2RU5X0NTMX2fvFPPJOLRJeKAnukQku
	mq7JOTXsEGUEgKm/RaCf8iSZhiUPHCqXKCYZHBoxV4gWG71kwnmk0R2HoN7rGaEQ/CGDNjhM62B
	jI4ZNaXPv1wo+Jo3EYjlI3RV9gW
X-Received: by 2002:a17:90b:1f88:b0:38e:bfe:81e9 with SMTP id 98e67ed59e1d1-3931dfd7b7fmr2652017a91.1.1786579758813;
        Wed, 12 Aug 2026 17:09:18 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931f478658sm620661a91.17.2026.08.12.17.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 17:09:18 -0700 (PDT)
Message-ID: <993b15a7ad6cca190ca7277727ad50f36a50b4c5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 11/13] selftests/bpf: Add inline-asm and
 subprog tests for R0:R2 returns
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Wed, 12 Aug 2026 17:09:15 -0700
In-Reply-To: <20260811001008.2383983-1-yonghong.song@linux.dev>
References: <20260811000911.2378679-1-yonghong.song@linux.dev>
	 <20260811001008.2383983-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-10 at 17:10 -0700, Yonghong Song wrote:
> Add inline-asm tests, which do not depend on the compiler lowering a
> register-pair return and so run regardless of the LLVM version, covering
> what the C tests cannot reach. aggregate_ret_func.c exercises BPF-to-BPF
> returns: a global subprogram whose R2 the caller may read, ones that leav=
e
> R2 uninitialised or holding a pointer, a static subprogram whose R2 stays
> precise under backtracking, R2 liveness across a call, and a >8 byte retu=
rn
> at program exit. Six kfuncs returning aggregates by value are added to
> bpf_testmod, and aggregate_ret_run.c calls them from inline asm to check
> what comes back in R0:R2.
>=20
> A negative arena test is added as well: a global subprogram with a
> register-pair return that leaves an arena pointer in R2 is rejected, sinc=
e
> an arena pointer is only a valid return value when it is returned in R0
> alone.
>=20
> Three cases cover the boundaries of the new convention:
>=20
> =C2=A0- A return value larger than 16 bytes does not fit in R0:R2 and is
> =C2=A0=C2=A0 rejected by btf_distill_func_proto(), ahead of the KF_FASTCA=
LL and
> =C2=A0=C2=A0 JIT-capability checks; one of the new kfuncs returns a 24-by=
te struct
> =C2=A0=C2=A0 for this. The equivalent for a BPF subprogram cannot be writ=
ten in C:
> =C2=A0=C2=A0 from LLVM 23 on, a by-value return larger than 16 bytes is l=
owered to an
> =C2=A0=C2=A0 sret pointer argument and the BTF the verifier reads says th=
e function
> =C2=A0=C2=A0 returns void, so the size bound in btf_validate_return_type(=
) only
> =C2=A0=C2=A0 guards hand-crafted BTF.
>=20
> =C2=A0- A static subprogram returning a struct that contains a pointer is
> =C2=A0=C2=A0 accepted, and the caller can use the returned pointer. Unlik=
e a global
> =C2=A0=C2=A0 subprogram, whose caller models the return as an opaque scal=
ar pair, a
> =C2=A0=C2=A0 static one is verified inline, so prepare_func_exit() hands =
the caller
> =C2=A0=C2=A0 real register state and the pointer stays tracked.
>=20
> =C2=A0- An extension cannot replace a function returning more than 8 byte=
s.
> =C2=A0=C2=A0 btf_check_type_match() does not catch this, since it compare=
s return
> =C2=A0=C2=A0 types by btf_type->info alone and both an __int128 and a __u=
64 are
> =C2=A0=C2=A0 BTF_KIND_INT with no vlen, so the rejection has to come from
> =C2=A0=C2=A0 bpf_check_attach_target(). The test reuses the freplace fail=
ure harness
> =C2=A0=C2=A0 in fexit_bpf2bpf.c, with aggregate_ret_target.c providing a =
target whose
> =C2=A0=C2=A0 global subprogram returns in R0:R2.
>=20
> The kfunc tests need the JIT to place the second half of a return value
> into R2, which bpf_add_kfunc_call() only allows where
> bpf_jit_supports_kfunc_ret_reg_pair() is true. In aggregate_ret_kfunc.c t=
he
> two tests that depend on getting past that check are tagged
> __arch_x86_64/__arch_arm64/__arch_riscv64; the others are rejected earlie=
r
> (on KF_FASTCALL, on a >16 byte return, and on reading R2 after an 8-byte
> struct return). In aggregate_ret_run.c the kfunc-calling programs are
> dropped from the object when the load reports -EOPNOTSUPP and their
> subtests are skipped, and the __int128 inline-asm test is split into a
> BPF-to-BPF half, which needs no JIT capability and runs everywhere, and a
> kfunc half.
>=20
> Five of the six new kfuncs return a struct or union by value and take
> arguments, so they join the x86_64/arm64 guard added in the previous patc=
h;
> see the comment there. That includes the one returning only 8 bytes: s390=
x
> hands back a by-value aggregate through an sret pointer whatever its size=
,
> so its declared arguments are displaced just the same and pahole skips th=
e
> function. The sixth returns 24 bytes but takes no argument, leaving nothi=
ng
> for the sret pointer to displace, and pahole does encode it there.
> Both objects calling the guarded kfuncs reference every one of them from
> __kfunc_btf_root(), so neither can load at all where those kfuncs are
> absent; the aggregate_ret_kfunc tests and the four aggregate_ret_run
> subtests are skipped as a group elsewhere. aggregate_ret_func.c calls no
> kfunc and keeps running everywhere.
>=20
> R0 holds bytes 0..7 of a return value and R2 bytes 8..15, so where a memb=
er
> sits inside a register depends on the endianness of the target. The check=
s
> in aggregate_ret_run.c that read a member out of half a register are buil=
t
> for a little-endian target only; arm64 is the one JIT implementing the pa=
ir
> that can be built big endian, and that configuration is left for later.

Nit: is such long commit message really warranted?
     commit messages seem to be too verbose all across this series.

>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

...

> +static void test_run(void)
> +{
> +	struct aggregate_ret_run *skel;
> +	bool kfunc_ok =3D true;
> +	int err;
> +
> +	/*
> +	 * Every program in this object shares __kfunc_btf_root(), so where the
> +	 * testmod kfuncs are absent the object cannot load at all -- including
> +	 * for the kfunc-free "asm" subtest.
> +	 */
> +	if (!has_ret_pair_kfuncs()) {
> +		run_subtest("asm", NULL, false);
> +		run_subtest("asm_kfunc", NULL, false);
> +		run_subtest("struct", NULL, false);
> +		run_subtest("union", NULL, false);
> +		return;
> +	}
> +
> +	skel =3D aggregate_ret_run__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_run_open"))
> +		return;
> +
> +	err =3D aggregate_ret_run__load(skel);
> +	if (err =3D=3D -EOPNOTSUPP) {
> +		kfunc_ok =3D false;
> +		aggregate_ret_run__destroy(skel);
> +
> +		skel =3D aggregate_ret_run__open();
> +		if (!ASSERT_OK_PTR(skel, "skel_run_reopen"))
> +			return;
> +
> +		bpf_program__set_autoload(skel->progs.aggregate_ret_asm_kfunc_test, fa=
lse);
> +		bpf_program__set_autoload(skel->progs.aggregate_ret_struct_test, false=
);
> +		bpf_program__set_autoload(skel->progs.aggregate_ret_union_test, false)=
;

Please find a way to avoid these special cases and rely exclusively on
RUN_TESTS(). We have other tests that rely on specific archs / compiler
version and such handling is not usually necessary.

> +
> +		err =3D aggregate_ret_run__load(skel);
> +	}
> +	if (!ASSERT_OK(err, "skel_run_load"))
> +		goto out;
> +
> +	run_subtest("asm", skel->progs.aggregate_ret_asm_test, true);
> +	run_subtest("asm_kfunc", skel->progs.aggregate_ret_asm_kfunc_test, kfun=
c_ok);
> +	run_subtest("struct", skel->progs.aggregate_ret_struct_test, kfunc_ok);
> +	run_subtest("union", skel->progs.aggregate_ret_union_test, kfunc_ok);
> +
> +out:
> +	aggregate_ret_run__destroy(skel);
> +}
> +

...

> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_func.c b/too=
ls/testing/selftests/bpf/progs/aggregate_ret_func.c

...

> +SEC("tc")
> +__success __retval(0)
> +__log_level(2)
> +__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
> +__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 4: (07) r1 +=3D -=
8")
> +__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 3: (bf) r1 =3D r1=
0")
> +__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 2: (57) r6 &=3D 7=
")
> +__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 1: (bf) r6 =3D r2=
")
> +__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 12: (95) exit")
> +__msg("mark_precise: frame1: regs=3Dr2 stack=3D before 11: (b7) r2 =3D 4=
")

Maybe add a log line showing that propagation process stopped here?

> +__naked int aggregate_ret_static_precise(void)
> +{
> +	asm volatile (
> +	"call %[static_agg_precise];"
> +	"r6 =3D r2;"		/* derived from the aggregate's second half */
> +	"r6 &=3D 7;"		/* keep it in [0, 7] to index the stack */
> +	"r1 =3D r10;"
> +	"r1 +=3D -8;"
> +	"r1 +=3D r6;"		/* ptr +=3D scalar marks r6 (hence R2) precise */
> +	"r0 =3D 0;"
> +	"*(u8 *)(r1 + 0) =3D r0;"
> +	"r0 =3D 0;"
> +	"exit;"
> +	:
> +	: __imm(static_agg_precise)
> +	: __clobber_all);
> +}
> +
> +SEC("tc")
> +__success __retval(0)
> +__log_level(2)
> +__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
> +__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 4: (07) r1 +=3D -=
8")
> +__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 3: (bf) r1 =3D r1=
0")
> +__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 2: (57) r6 &=3D 7=
")
> +__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 1: (bf) r6 =3D r2=
")
> +__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 0: (85) call pc+9=
")

And here.

> +__naked int aggregate_ret_global_precise(void)
> +{
> +	asm volatile (
> +	"call %[global_agg_good];"
> +	"r6 =3D r2;"		/* derived from the aggregate's second half */
> +	"r6 &=3D 7;"		/* keep it in [0, 7] to index the stack */
> +	"r1 =3D r10;"
> +	"r1 +=3D -8;"
> +	"r1 +=3D r6;"		/* ptr +=3D scalar marks r6 (hence R2) precise */
> +	"r0 =3D 0;"
> +	"*(u8 *)(r1 + 0) =3D r0;"
> +	"r0 =3D 0;"
> +	"exit;"
> +	:
> +	: __imm(global_agg_good)
> +	: __clobber_all);
> +}

...

> +SEC("tc")
> +__success __retval(0)
> +int aggregate_ret_global_struct(void *ctx)

Tbh, for this and similar tests I'd keep either C or asm versions,
keeping both seem excessive.

> +{
> +	__u64 lo, hi;
> +
> +	asm volatile (
> +	"call %[global_ret_struct];"
> +	"%[lo] =3D r0;"
> +	"%[hi] =3D r2;"
> +	: [lo]"=3Dr"(lo), [hi]"=3Dr"(hi)
> +	: __imm(global_ret_struct)
> +	: "r0", "r1", "r2", "r3", "r4", "r5");
> +	if (lo !=3D 0x1234)
> +		return 1;
> +	if (hi !=3D 0x5678)
> +		return 2;
> +	return 0;
> +}

...

> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_run.c b/tool=
s/testing/selftests/bpf/progs/aggregate_ret_run.c
> new file mode 100644
> index 000000000000..382ef3b90037
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_run.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +#include "../test_kmods/bpf_testmod_kfunc.h"
> +
> +typedef unsigned __int128 u128;
> +
> +/*
> + * Reference kfunc addresses to force those BTF to be emitted. Taking th=
e address
> + * (rather than calling) avoids any dependence on the compiler lowering =
an __int128
> + * or struct return value, which the BPF backend only supports from LLVM=
 23 on.
> + */
> +void __kfunc_btf_root(void)
> +{
> +	asm volatile (""
> +	:
> +	: "r"(&bpf_kfunc_call_test_i128),
> +	=C2=A0 "r"(&bpf_kfunc_call_test_ret_pair),
> +	=C2=A0 "r"(&bpf_kfunc_call_test_ret_li),
> +	=C2=A0 "r"(&bpf_kfunc_call_test_ret_ii),
> +	=C2=A0 "r"(&bpf_kfunc_call_test_ret_uu));
> +}
> +
> +#define I128_ASM_LO 0xABCDabcd12345678ULL
> +#define I128_ASM_HI 0x1234567890abcdefULL
> +
> +static __naked __noinline u128 make_i128_asm(void)
> +{
> +	asm volatile (
> +	"r0 =3D %[lo] ll;"	/* low 64 bits */
> +	"r2 =3D %[hi] ll;"	/* high 64 bits */
> +	"exit;"
> +	:
> +	: __imm_const(lo, I128_ASM_LO), __imm_const(hi, I128_ASM_HI)
> +	);
> +}
> +
> +SEC("tc")
> +int aggregate_ret_asm_test(struct __sk_buff *skb)

Same here, let's keep either C or an asm variant.

> +{
> +	__u64 lo, hi;
> +
> +	asm volatile (
> +	"call %[callee];"
> +	"%[lo] =3D r0;"
> +	"%[hi] =3D r2;"
> +	: [lo]"=3Dr"(lo), [hi]"=3Dr"(hi)
> +	: [callee]"i"(make_i128_asm)
> +	: "r0", "r1", "r2", "r3", "r4", "r5"

Nit: we have __clobber_common macro.

> +	);
> +	if (lo !=3D I128_ASM_LO)
> +		return 1;
> +	if (hi !=3D I128_ASM_HI)
> +		return 2;
> +
> +	return 0;
> +}
> +
> +/*
> + * R0 holds bytes 0..7 of a kfunc return value and R2 bytes 8..15, so wh=
ere a
> + * member sits inside a register depends on the endianness of the target=
.
> + * Although arm64 supports both little and big endian, for simplicity, o=
nly
> + * do little endian for now..
> + */
> +SEC("tc")
> +int aggregate_ret_asm_kfunc_test(struct __sk_buff *skb)
> +{

The tests below are very similar to those added in the patch
"selftests/bpf: Add C tests for 16-byte returns in R0:R2",
Maybe convert these to C and keep in the same file?

> +#if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
> +	__u64 a =3D skb->len;
> +	__u64 b =3D skb->len ^ 0xdeadbeefULL;
> +	__u64 lo, hi;
> +
> +	asm volatile (
> +	"r1 =3D %[a];"
> +	"r2 =3D %[b];"
> +	"call %[kfunc];"
> +	"%[lo] =3D r0;"
> +	"%[hi] =3D r2;"
> +	: [lo]"=3Dr"(lo), [hi]"=3Dr"(hi)
> +	: [a]"r"(a), [b]"r"(b), [kfunc]"i"(bpf_kfunc_call_test_i128)
> +	: "r0", "r1", "r2", "r3", "r4", "r5"
> +	);
> +	if (hi !=3D a + b)
> +		return 1;
> +	if (lo !=3D a - b)
> +		return 2;
> +#endif
> +
> +	return 0;
> +}

...
