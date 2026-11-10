Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319248;
	b=x1kkH9oIPMi3MnchHmWKqiUD+FlVyveEp9Ctp/Xdf6YcD97nBzMkyJ8z+1pIVJJMiY8f
	 xW3+RyhQMEk9SCguOEmGNN+JaJhcPqUMClfx58iRpqOjvyKgeboolKZo/xQP6YnwTcYLA
	 KGmwXR37IY5KnEqYdm4yOseiVZ0y2DZk/pcJpEVf0L4dA5TtvxqI3ZYT9Sdh5q8nBvdp0
	 mkQBH/mmT9aVcwlXSncMhAL8DPzgKVQUg8yPqGNGpCrsL05lwuljqQX2fSg9h47VMPz+o
	 HDiW+zyOA4drBCId6ySWuPaYzNdJdrAIeJICDDZoEh9G/ZTONYVrMxS0sMEC7WW91LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319248;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3ssOTq0k8dhOqZtAYP2q7lGyoiGZLaZvlpqP26+6Bpw=;
	b=xyx5UJISMDotyShM6pyAECVmEFLZKrVZnd19nTUnaHAEwCEGUYW+MybSSTOtWLhQ0Wq5
	 YrQOAanVjjK9qdJPHCK3rCpuXUA945o2c+BPOZGDSxUL4a5jC33ybLxy98htFHlq9WYLM
	 MBobMZ6FlfhohpFF3ZnaLNowUXMYuIRnG2d7wt2M3JmWTti3QSKlhrEqq3Gq8Kf9zXv/I
	 PqWcX2LYspDeWHDSa5lu+Zgj55R6Mn2kUervgMbljLcSQVCLO6JD7ZM+zEzcnls6aMUhT
	 WHrsp/wHbWhOb0RNgSNegj4fKhTYBc7D6kpeOKUMDSXttn+K/p1g/UwoCgWzQweX3PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H3tR2POv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2CC606A321;
	Tue, 10 Nov 2026 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H3tR2POv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B410B1F0089F;
	Tue, 10 Nov 2026 14:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319248;
	bh=3ssOTq0k8dhOqZtAYP2q7lGyoiGZLaZvlpqP26+6Bpw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H3tR2POv+JfzMgRYCDP2gq5P9jyo+rzgufTROYUxhw8UPhN5oqJk8gBBF+XYTh9lB
	 JhxI5s4fnXpi4vfdZcww30hv7AFepCRBEUcobsRaaxcbLRW6pZ/AYo+DgSKNxKokSv
	 5NuIK+ZAJ4TQX/sx3dYls1b5nKmICdeyqhjCTDgBQJhM8MCL2XYTgI6C1sr4KPjs9y
	 zQjbJtHuYaGhDFByLFKYRv6dtsz2WUFwq4CQCGAUzRwjPRTElRkp7qFSddgsDRFj4M
	 uNvB4LG5ZCcO1QjZ06EIknhe8faya8uOqLAHBDSz6yBoffhz5f+HG81vW8QWFacW57
	 GN+BXnqcnVhXw==
Message-ID: <sashiko-outbox-207171@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/6] riscv, bpf: emit LR/SC loops when Zaamo is
 disabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261110-lrsc-only-v6-5-bafc3cc0fcae@mobileye.com>
References: <20261110-lrsc-only-v6-0-bafc3cc0fcae@mobileye.com>
 <20261110-lrsc-only-v6-5-bafc3cc0fcae@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 14:00:47 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] riscv, bpf: missing full fence for fetch/xchg LR/SC in
  emit_atomic_lrsc()
--

commit a367c50f4df6ecfbc1363d12bbca1b28cecbf767
Author: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

riscv, bpf: emit LR/SC loops when Zaamo is disabled

This commit updates the RV32 and RV64 BPF JITs to emit LR/SC loops for
BPF atomic read-modify-write operations when CONFIG_RISCV_ISA_ZAAMO is
disabled, and adds the second exception table entry needed when an arena
access faults on the sc instruction.

> diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_com=
p32.c
> index a9e0bd5cc81d2..ea1779a236341 100644
> --- a/arch/riscv/net/bpf_jit_comp32.c
> +++ b/arch/riscv/net/bpf_jit_comp32.c
> @@ -874,11 +874,67 @@ static int emit_load_r64(const s8 *dst, const s8 *s=
rc, s16 off,
>  	return 0;
>  }
> =20
> -static int emit_bpf_atomic(s8 dst, const s8 *src, const s8 *rs,
> -			   struct rv_jit_context *ctx,
> -			   const struct bpf_insn *insn)
> +/*
> + * Read-modify-write via lr/sc for kernels built without Zaamo. T0 holds
> + * the address. T1/T2 are not BPF registers; the address was copied out =
of
> + * lo(rd) before this is called, so clobbering T2 is fine.
> + */
> +static int emit_bpf_atomic_lrsc(s8 dst, const s8 *rs, s32 imm,
> +				struct rv_jit_context *ctx)
> +{
> +	bool is_fetch =3D (imm & BPF_FETCH) || (imm =3D=3D BPF_XCHG);
> +	bool xchg =3D imm =3D=3D BPF_XCHG;
> +	u8 aq =3D is_fetch ? 1 : 0;
> +	u8 rl =3D is_fetch ? 1 : 0;
> +	u8 old =3D RV_REG_T1;
> +	u8 tmp =3D RV_REG_T2;
> +	int lr_off, jmp_off;
> +	s32 op =3D xchg ? BPF_XCHG : imm & ~BPF_FETCH;
> +
> +	switch (op) {
> +	case BPF_ADD:
> +	case BPF_AND:
> +	case BPF_OR:
> +	case BPF_XOR:
> +	case BPF_XCHG:
> +		break;
> +	default:
> +		return -1;
> +	}
> +
> +	lr_off =3D ctx->ninsns;
> +	emit(rv_lr_w(old, 0, dst, aq, rl), ctx);
> +
> +	switch (op) {
> +	case BPF_ADD:
> +		emit(rv_add(tmp, old, lo(rs)), ctx);
> +		break;
> +	case BPF_AND:
> +		emit(rv_and(tmp, old, lo(rs)), ctx);
> +		break;
> +	case BPF_OR:
> +		emit(rv_or(tmp, old, lo(rs)), ctx);
> +		break;
> +	case BPF_XOR:
> +		emit(rv_xor(tmp, old, lo(rs)), ctx);
> +		break;
> +	}
> +
> +	if (xchg)
> +		emit(rv_sc_w(tmp, lo(rs), dst, aq, rl), ctx);
> +	else
> +		emit(rv_sc_w(tmp, tmp, dst, aq, rl), ctx);
> +
> +	jmp_off =3D ninsns_rvoff(lr_off - ctx->ninsns);
> +	emit(rv_bne(tmp, RV_REG_ZERO, jmp_off >> 1), ctx);
> +	if (is_fetch)
> +		emit(rv_addi(lo(rs), old, 0), ctx);
> +	return 0;
> +}

[ ... ]

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index 01fe66774f029..94e4ddc6d965c 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -573,6 +573,79 @@ static int emit_atomic_ld_st(u8 rd, u8 rs, const str=
uct bpf_insn *insn,
>  	return 0;
>  }
> =20
> +/*
> + * Read-modify-write via lr/sc for kernels built without Zaamo, matching
> + * the Zalrsc sequences in arch/riscv/include/asm/atomic.h. A relaxed op
> + * discards the old value. A fetch op (including XCHG) uses .aqrl and
> + * writes that value back to val. T2/T3 are not BPF registers; addr may
> + * already be T1.
> + */
> +static void emit_atomic_lrsc(u8 addr, u8 val, bool is64, s32 imm,
> +			     struct rv_jit_context *ctx)
> +{
> +	bool fetch =3D imm & BPF_FETCH;
> +	u8 aq =3D fetch ? 1 : 0;
> +	u8 rl =3D fetch ? 1 : 0;
> +	u8 old =3D RV_REG_T2;
> +	u8 tmp =3D RV_REG_T3;
> +	int lr_off, jmp_off;
> +	s32 op =3D imm =3D=3D BPF_XCHG ? BPF_XCHG : imm & ~BPF_FETCH;
> +
> +	lr_off =3D ctx->ninsns;
> +	ctx->ex_insn_off =3D ctx->ninsns;
> +	emit(is64 ? rv_lr_d(old, 0, addr, aq, rl) :
> +	     rv_lr_w(old, 0, addr, aq, rl), ctx);
> +
> +	if (op !=3D BPF_XCHG) {
> +		if (!is64 && op =3D=3D BPF_ADD)
> +			emit(rv_addw(tmp, old, val), ctx);
> +		else if (op =3D=3D BPF_ADD)
> +			emit_add(tmp, old, val, ctx);
> +		else if (op =3D=3D BPF_AND)
> +			emit_and(tmp, old, val, ctx);
> +		else if (op =3D=3D BPF_OR)
> +			emit_or(tmp, old, val, ctx);
> +		else if (op =3D=3D BPF_XOR)
> +			emit_xor(tmp, old, val, ctx);
> +
> +		ctx->ex_sc_off =3D ctx->ninsns;
> +		emit(is64 ? rv_sc_d(tmp, tmp, addr, aq, rl) :
> +		     rv_sc_w(tmp, tmp, addr, aq, rl), ctx);
> +	} else {
> +		ctx->ex_sc_off =3D ctx->ninsns;
> +		emit(is64 ? rv_sc_d(tmp, val, addr, aq, rl) :
> +		     rv_sc_w(tmp, val, addr, aq, rl), ctx);
> +	}
> +
> +	/* Branch offset is relative to this instruction, back to the lr. */
> +	jmp_off =3D ninsns_rvoff(lr_off - ctx->ninsns);
> +	emit(rv_bne(tmp, RV_REG_ZERO, jmp_off >> 1), ctx);
> +
> +	if (fetch) {
> +		emit_mv(val, old, ctx);
> +		if (!is64)
> +			emit_zextw(val, val, ctx);
> +	}
> +	ctx->ex_jmp_off =3D ctx->ninsns;
> +}

[Severity: Medium]
Does using .aqrl on lr and sc without a trailing fence provide the full
memory barrier required by BPF_FETCH and BPF_XCHG in
emit_bpf_atomic_lrsc() and emit_atomic_lrsc()?

Under RVWMO, lr.aqrl is a load whose .rl bit only orders prior RCsc
accesses, and sc.aqrl is a store whose .aq bit only orders subsequent RCsc
accesses.  A plain store before lr.aqrl and a plain load after sc.aqrl can
therefore be reordered across the LR/SC loop.

The Zalrsc sequence in arch/riscv/include/asm/atomic.h and emit_cmpxchg()
in arch/riscv/net/bpf_jit.h instead emit a plain lr (aq=3D0, rl=3D0), sc.rl
(aq=3D0, rl=3D1), and a full barrier after the retry branch:

arch/riscv/include/asm/atomic.h:ATOMIC_FETCH_OP() {
	__asm__ __volatile__ (
		"1:	lr." #asm_type " %1, %0\n"
		"	" #asm_op " %2, %1, %3\n"
		"	sc." #asm_type ".rl %2, %2, %0\n"
		"	bnez %2, 1b\n"
		RISCV_FULL_BARRIER
}

Both emit_bpf_atomic_lrsc() and emit_atomic_lrsc() should use plain lr,
sc.rl for fetch/xchg, and emit_fence_rw_rw(ctx) after the bne retry
branch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-lrsc-only-=
v6-0-bafc3cc0fcae@mobileye.com?part=3D5
