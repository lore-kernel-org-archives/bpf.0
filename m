Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7854A40E8FE
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596041; cv=none; b=kWagi4/BaKY0qDcH8XhJxDP168WGe5fBC+lz8hJ/AC6jI/wFLOVWDdvsQnTOUpZQ2zM7UvbJurAxAd6pYOMf4meKaojhBHMZyQsTwa5O6fJ+TL/ZJ5YBYyQQvi7EKM/GbdkOrt7wlTmDMZLQ6YB0bMS+4cTRNt3A2raZ7XbOPH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596041; c=relaxed/simple;
	bh=7pVHt9sIOw5rkIZmSn6n4JfHuLTh2SoGrGXuqbBxYQ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ERczHxoXgpo6Eo+hwyn56bvP1z/fPS12NzWTpOBzzAdDh7uZP/kMsUH1dQVUNvU7q5x/3fOCg6Lv2Nlh9R6h9GziPDYi2cyHYEqOtVpsiu2NXfv9+J38y0HFO0w5g3m+dpNcJdIRLvMLvLRlH/P1fxnC8qpVNh5FncQ2jSSyPno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olg+jli2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olg+jli2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02E71F000E9;
	Thu,  9 Jul 2026 11:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783596040;
	bh=L5DqgP+loBRgyo/aywiiaXvbb2zNBR6hArN7lJnwJkE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=olg+jli27qVjun/+jDsveu2t3uxMkn42aqS16RkSo4tk0dI5usM9VlluaXWq4iDeg
	 nQnz/yEVnA/9GtwZhrccsBwL2BNscYgBoudwOjbB8yQ+p+Sf9WKf4LB1pjPnZmup+d
	 49BFzy/9Ht8VK07+58ihDiIp7IakYqu4yL05lkEpqvSRrGBTUeIS7KXX9NXWoLrgsy
	 6tYixU8/beRPKLtPhQU43aIVQJt+WG722NipgN65fPsHnYhQ5SXrd3e3vWlkaW8lAZ
	 8jIdFsRghjJXYGKdOjgbibQFDXMBsW+uXpNVSDsQQEwGoAONlcjuHiEwzIqFuixYMo
	 DHbdjt5ww2LVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 06/10] bpf, x86: emit KASAN checks into x86
 JITed programs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260709-kasan-v5-6-1c64af8e4e1e@bootlin.com>
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
 <20260709-kasan-v5-6-1c64af8e4e1e@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 11:20:39 +0000
Message-Id: <20260709112039.F02E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] KASAN checks clobber caller-saved registers %r10 (BPF_REG_AX) =
and %r11 (AUX_REG), leading to memory corruption
--

--- Patch [6]: [PATCH bpf-next v5 06/10] bpf, x86: emit KASAN checks into x=
86 JITed programs ---
commit e841cd22d378b4b1ec9b5d8608f051fedbf3837f
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf, x86: emit KASAN checks into x86 JITed programs

This commit inserts KASAN shadow memory checks before memory load and store
operations in JIT-compiled BPF programs. This helps detect memory safety
bugs such as use-after-free and out-of-bounds accesses at runtime.

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
> +						       insn, ip, true,
> +						       accesses_stack_only);

[Severity: Critical]
Does this sequence clobber the temporarily saved BPF_REG_0 register?

The CMPXCHG loop saves BPF_REG_0 into BPF_REG_AX just before this block:

    /* Will need RAX as a CMPXCHG operand so save R0 */
    emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);

Immediately after, emit_kasan_check() emits a C function call to the KASAN
runtime. However, emit_kasan_check() does not push and pop BPF_REG_AX or
AUX_REG in its register save sequence.

Since those registers map to %r10 and %r11, which are caller-saved in the
x86-64 System V ABI, the KASAN C functions can overwrite them. The later
restore of BPF_REG_0 from BPF_REG_AX would then yield a garbage value.

Could this lead to memory corruption, especially if the verifier also
utilizes BPF_REG_AX for constant blinding across BPF_ST instructions which
are similarly instrumented by emit_kasan_check()?

> +				if (err)
> +					return err;
>  				branch_target =3D prog;
> +			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-kasan-v5-0=
-1c64af8e4e1e@bootlin.com?part=3D6
