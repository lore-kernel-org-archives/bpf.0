Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979973FFAD0
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 08:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783498611; cv=none; b=H03xFVlNB0O34Z12TygE/B2o4nafEl1GlzDybUMlktFBedhYUYQl/iLd9hHrFCofpO3YcT+kWUjT73u0kKh0FBVmQBXMBF3/b/RqFqfLRTL/KWTLdAisJRO9R5gtd7GxflvxvFBA1X7lQ7GeygF3ThdGGKPXoso8n91F85wKkpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783498611; c=relaxed/simple;
	bh=t+Iv3ukFeeFD1tOR3rwR+zdFwNcx2dIgsYM8mn6sGAU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eo50sACvCextmgaLW3XFBCCHlxwxy/SFOZJvvp8JjSzoBOiI5Ba9k4uiHEwte2GcfODRRAW+MvDxMnY07gZ6JeJO2qyv6NHuYPcUmG+iDknEGvSBbDVWqdJITWgqllJXBsLkaD6aJoAPpLDvIpr1PIDDzS6xnW41fy7vfdqkeVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfYBcQGy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfYBcQGy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8BB1F000E9;
	Wed,  8 Jul 2026 08:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783498610;
	bh=cE76Yrn1s8pq8xaHc4RUDy+vRCRYxKuduQgaHXlQi5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZfYBcQGyCaqaJ176J81q71HcCvDqtrznxauE9TsB2FfP8f8nsikaP8hD3M5O/eZGB
	 uGzGb17/BcG4YM73MM/IYfVTDRF1psu+FxaLxvgnMb/2lh+dt+vrAt6IHPk0myB5CE
	 LcLQhL/e7BGs0tJNsFSw0H0idlJHrrQca14yLso0ILa+3zTKqNexiAPFlEZaV9O96/
	 Pj1fpgWfE9cfyU8GcN0Hb6d02oHaFIR1eZEmO9ZmecHh4+P1npfs3VDei/wiZq9cam
	 Qd5fc3Ay5be2AdIFqLOzuOb9/DxAhHq9m85s9plIBzvQN2loYq/6xirxNBQ31sZ9D3
	 wPk3AGijyqQNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 06/10] bpf, x86: emit KASAN checks into x86
 JITed programs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708-kasan-v4-6-d5c177ab8227@bootlin.com>
References: <20260708-kasan-v4-0-d5c177ab8227@bootlin.com>
 <20260708-kasan-v4-6-d5c177ab8227@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 08:16:49 +0000
Message-Id: <20260708081650.5E8BB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] `emit_kasan_check` fails to save and restore the caller-saved =
registers %r10 (`BPF_REG_AX`) and %r11 (`AUX_REG`). This corrupts state dur=
ing atomic fetch operations and constant blinding, potentially leading to a=
rbitrary memory corruption or kernel crashes.
- [Low] Atomic read-modify-write (RMW) operations are incorrectly instrumen=
ted as KASAN reads instead of KASAN writes.
--

--- Patch [6]: [PATCH bpf-next v4 06/10] bpf, x86: emit KASAN checks into x=
86 JITed programs ---
commit ea72c3645f886fbb17349184882dfa35cd20282f
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf, x86: emit KASAN checks into x86 JITed programs

Insert KASAN shadow memory checks before memory load and store operations
in JIT-compiled BPF programs. This helps detect memory safety bugs such as
use-after-free and out-of-bounds accesses at runtime.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 959fcaa0cde9a..65a00e84799cd 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
[ ... ]
> @@ -2605,15 +2640,16 @@ static int do_jit(struct bpf_verifier_env *env, s=
truct bpf_prog *bpf_prog, int *
>  			}
>  			fallthrough;
>  		case BPF_STX | BPF_ATOMIC | BPF_W:
> -		case BPF_STX | BPF_ATOMIC | BPF_DW:
> -			if (insn->imm =3D=3D (BPF_AND | BPF_FETCH) ||
> -			    insn->imm =3D=3D (BPF_OR | BPF_FETCH) ||
> -			    insn->imm =3D=3D (BPF_XOR | BPF_FETCH)) {
> -				bool is64 =3D BPF_SIZE(insn->code) =3D=3D BPF_DW;
> -				u32 real_src_reg =3D src_reg;
> -				u32 real_dst_reg =3D dst_reg;
> -				u8 *branch_target;
> -
> +		case BPF_STX | BPF_ATOMIC | BPF_DW: {
> +			bool is64 =3D BPF_SIZE(insn->code) =3D=3D BPF_DW;
> +			u32 real_src_reg =3D src_reg;
> +			u32 real_dst_reg =3D dst_reg;
> +			u8 *branch_target;
> +			bool is_atomic_fetch =3D
> +				(insn->imm =3D=3D (BPF_AND | BPF_FETCH) ||
> +				 insn->imm =3D=3D (BPF_OR | BPF_FETCH) ||
> +				 insn->imm =3D=3D (BPF_XOR | BPF_FETCH));
> +			if (is_atomic_fetch) {
>  				/*
>  				 * Can't be implemented with a single x86 insn.
>  				 * Need to do a CMPXCHG loop.
> @@ -2626,7 +2662,17 @@ static int do_jit(struct bpf_verifier_env *env, st=
ruct bpf_prog *bpf_prog, int *
>  				if (dst_reg =3D=3D BPF_REG_0)
>  					real_dst_reg =3D BPF_REG_AX;
> =20
> +				ip +=3D 3;
> +			}
> +			if (!bpf_atomic_is_load_store(insn)) {
> +				err =3D emit_kasan_check(env, &prog, real_dst_reg,
> +						       insn, ip, false,
> +						       accesses_stack_only);

[Severity: Critical]
Does this KASAN check clobber %r10 (BPF_REG_AX) and %r11 (AUX_REG)?

If this is an atomic fetch operation and BPF_REG_0 is used, the JIT saves
BPF_REG_0 into BPF_REG_AX (%r10). However, the emit_kasan_check() function
emits a C function call without saving %r10 or %r11:

arch/x86/net/bpf_jit_comp.c:emit_kasan_check() {
	...
	/* Save r8 */
	EMIT2(0x41, 0x50);
	/* Save r9 */
	EMIT2(0x41, 0x51);

	/* mov rdi, addr_reg */
	EMIT_mov(BPF_REG_1, addr_reg);
	...
	/* call kasan_func */
	if (emit_call(&prog, kasan_func, ip))
		return -ERANGE;
	...
}

Since C functions can clobber %r10 under the System V ABI, could the
subsequent use of real_dst_reg (which points to %r10) lead to wild memory
accesses?

[Severity: Low]
Are atomic RMW operations incorrectly instrumented as KASAN reads?

The 6th argument to emit_kasan_check() is is_write. Here it is hardcoded to
false for mutating atomic RMW instructions. Should this be true instead, so
that KASAN diagnostics report out-of-bounds writes rather than out-of-bounds
reads?

> +				if (err)
> +					return err;
>  				branch_target =3D prog;
> +			}
> +			if (is_atomic_fetch) {
>  				/* Load old value */
>  				emit_ldx(&prog, BPF_SIZE(insn->code),
>  					 BPF_REG_0, real_dst_reg, insn->off);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-kasan-v4-0=
-d5c177ab8227@bootlin.com?part=3D6
