Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B945A3D45D0
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 20:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780606665; cv=none; b=I44+kcLLB2Ly0Ae1gFI7ryspWeftFgUzScLQioLMcw0hdqW/jcTgEh5lif354OaM3DQc+uoMVW0VDL8kqIVJFKSfjQoHtuuudu1Qltdy/FnFnDgWDQW7rHLyGIS5/kqw7ppO63mi5DYU+wI/aTElExJnh577JkCub5yUYMjssMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780606665; c=relaxed/simple;
	bh=XC8494UVAjBNSWib0qTmhsIfL69TCHVRnNAUusulTRs=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hfxAv/i5HAu+4jV/Z3oCY8B+rTED5+u7HYSS4QP95jcOnTfVFq9YUSRfx9DYbUmtDr1FehTi4CqYanq6AeYJMLWeiFx+DgDSVROmvXZ/LMqHn00PmSuLwDXxO2mrcCnCFLq0vYJhUDqDWIBSQE5g6fcwKMOmLcGAkPjlX0vAeG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kO939egt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kO939egt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5411F00893
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 20:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780606664;
	bh=uslKnCPbHc/7G2k4pqvdMbnQoi/asrC0H21vHkbujmA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=kO939egtzH2aK3YW7dbi8P7EwPGHlGfBF6p/WHV5f1s7KhWmw4R6UZPV2/UKlID+2
	 qmpzjofJCgGlpL6EPSpdekx+7H/pPDhP5hsQL9nbJtqczbsFQ3Mw+8eQ5OQ/HK8B4l
	 oFLlMyAgssRp4gyow9Rd+ifHRrqROmkQk3TJd1i1NTA34mWflKIrRytseaN7TxBQO9
	 BkpsiVjllaYFFcWc9rzd11J0LZnDNenvEmCZM0WnLjXGO7icUcg3hgU/Xu+xPdoqqS
	 jce8qDrH72Nf/wVuGlct/rxXcyadQBPllMQROfnuzgjROhg+LlX/Qczy5riwvGUDip
	 n+hmg5emg/21g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 4/8] bpf, x86: refactor BPF_ST management in
 do_jit
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <20260604-kasan-v2-4-c066e627fda8@bootlin.com>
References: <20260604-kasan-v2-4-c066e627fda8@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:57:43 +0000
Message-Id: <20260604205744.3B5411F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Improper break scope in nested switch causes JIT to emit malfo=
rmed instructions for BPF_ST with BPF_DW targeting the 6th argument.
--

commit 4f81840cd1222105beefd9a592e593df3c32c344
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf, x86: refactor BPF_ST management in do_jit

This commit refactors BPF_ST instruction generation in the x86 JIT by
grouping memory access operations under a single fall-through block and
utilizing an inner switch on the BPF instruction size. This prepares the
code for adding KASAN checks.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 0981791014eb3..943a0f315cf2b 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
[ ... ]
> @@ -2300,41 +2300,50 @@ static int do_jit(struct bpf_verifier_env *env, s=
truct bpf_prog *bpf_prog, int *
[ ... ]
>  		case BPF_ST | BPF_MEM | BPF_DW:
> -			if (dst_reg =3D=3D BPF_REG_PARAMS && insn->off =3D=3D -8) {
> -				/* Arg 6: store immediate in r9 register */
> -				emit_mov_imm64(&prog, X86_REG_R9, imm32 >> 31, (u32)imm32);
> +			switch (BPF_SIZE(insn->code)) {
[ ... ]
> +			case BPF_DW:
> +				if (dst_reg =3D=3D BPF_REG_PARAMS &&
> +				    insn->off =3D=3D -8) {
> +					/* Arg 6: store immediate in r9 register */
> +					emit_mov_imm64(&prog, X86_REG_R9,
> +						       imm32 >> 31, (u32)imm32);
> +					break;

[Severity: Critical]
Does this break statement now only exit the newly introduced inner switch
rather than the outer switch?

In the original code, this break would exit the outer switch entirely and
skip the remainder of the BPF_ST logic. Now that it only breaks the inner
switch, execution appears to fall through to the common suffix below:

    insn_off =3D insn->off;
    ...
    EMIT(imm32, bpf_size_to_x86_bytes(BPF_SIZE(insn->code)));

Could this cause the JIT to incorrectly emit the user-controlled imm32 value
directly into the executable instruction stream as raw x86 instructions,
potentially leading to a kernel crash or arbitrary code execution?

> +				}
> +				EMIT2(add_1mod(0x48, dst_reg), 0xC7);
>  				break;
>  			}
> =20
> -st:			insn_off =3D insn->off;
> +			insn_off =3D insn->off;
>  			if (dst_reg =3D=3D BPF_REG_PARAMS) {
>  				/*
>  				 * Args 7+: reverse BPF negative offsets to
>  				 * x86 positive rsp offsets.
>  				 * BPF off=3D-16 =E2=86=92 [rsp+0], off=3D-24 =E2=86=92 [rsp+8], ...
>  				 */
> -				insn_off =3D outgoing_arg_base - outgoing_rsp - insn_off - 16;
> +				insn_off =3D outgoing_arg_base - outgoing_rsp -
> +					   insn_off - 16;
>  				dst_reg =3D BPF_REG_FP;
>  			}
>  			if (is_imm8(insn_off))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-kasan-v2-0=
-c066e627fda8@bootlin.com?part=3D4
