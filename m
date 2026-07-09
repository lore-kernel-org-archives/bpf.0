Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E39D408028
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 11:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783595301; cv=none; b=t3YqReJbMwT46sv4tajaFtI7RP0iQVYf0SQa74WuIqRTAniFdEpCbP36x91YIhQAxSgCYDIamJhpWPxs5tQBLtcXDiQ8alUl1gIaDfMIlK0vJ78g8kazVm8gEen3c1LBwmLuY68TwjVDpJ9NXKXb08uqosILZ4aiLyETdPWFS5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783595301; c=relaxed/simple;
	bh=6XGu/MbOijR7v9MmCWHL9muKY7eLu2Qttxz9FRjV5Ac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E7IgYHUPvEcXtV1m8nb3t8ZI3RwSIa8xB4XZDWgJS6X0JdfjCeXPvA04dbJhdF06ZxdsYDCPTX6iHRR9KSZLiPk9D9J24102b82JLEEyLUMOFrj6nds8//n6m1I/tdM2eR3ndNSEgyYuJBg3wzJAl9EtWSK0kMG5Atw8dA6ndSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQ7wAJsK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQ7wAJsK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BED51F000E9;
	Thu,  9 Jul 2026 11:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783595299;
	bh=s37Ee96tbNthRwDfRPTJE+8Z+6fHhS9biIRaLzpe2Uo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aQ7wAJsKfvZITCuHHbKdJb4LHhNHaj/TkzcrwhlBsT3AxHSIuDAwfSnsDj7JTZ1ht
	 nO0f3iaCzKkFXswKtXcpBZTYUgEcHX8u80NROJJCVocJMfbj3sF8XrHBE7rQGdNbiV
	 HyZc6THn2V+fAMohSuNkm9qMG5HyH7kMqOKZzitBPKRKb6RcRb/V4OzzxAqvOAXV7Z
	 sY07Mt0KIjcmfQEQ6/ZYoX9/x3esrg9k0Y3Akh3hvXPznCWHSiOp8S+F6JNt3lTC+w
	 eMPWECDn2AATwRX6C2Jz0tm/pm0AGyRhs+InHZe4uomLwhpFxgmXh43rkwT0ZOUm7z
	 ze942px0z70ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 05/10] bpf, x86: refactor BPF_ST management
 in do_jit
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260709-kasan-v5-5-1c64af8e4e1e@bootlin.com>
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
 <20260709-kasan-v5-5-1c64af8e4e1e@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 11:08:18 +0000
Message-Id: <20260709110819.6BED51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `emit_st()` helper absorbs `Arg 6` pseudo-store and `BPF_REG_P=
ARAMS` translation, causing invalid KASAN instrumentation for BPF_ST instru=
ctions.
--

--- Patch [5]: [PATCH bpf-next v5 05/10] bpf, x86: refactor BPF_ST manageme=
nt in do_jit ---
commit b88dd49e34d6904772392eec8dfdeba3542805c4
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf, x86: refactor BPF_ST management in do_jit

This commit extracts the x86-64 BPF_ST instruction emission logic into a si=
ngle
emit_st() helper function. It is intended to prepare for KASAN checks being
inserted before memory loads and stores.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index d35f58350d710..959fcaa0cde9a 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1410,6 +1410,64 @@ static void emit_st_index(u8 **pprog, u32 size, u3=
2 dst_reg, u32 index_reg, int
>  	*pprog =3D prog;
>  }
> =20
> +static void emit_st(u8 **pprog, struct bpf_insn *insn, int dst_reg,
> +		    s32 outgoing_arg_base, u16 outgoing_rsp)
> +{
> +	s32 imm32 =3D insn->imm;
> +	u8 *prog =3D *pprog;
> +	s32 insn_off;
> +
> +	switch (BPF_SIZE(insn->code)) {
[ ... ]
> +	case BPF_DW:
> +		if (dst_reg =3D=3D BPF_REG_PARAMS && insn->off =3D=3D -8) {
> +			/* Arg 6: store immediate in r9 register */
> +			emit_mov_imm64(&prog, X86_REG_R9, imm32 >> 31,
> +				       (u32)imm32);
> +			*pprog =3D prog;
> +			return;
> +		}
> +		EMIT2(add_1mod(0x48, dst_reg), 0xC7);
> +		break;
> +	}
> +
> +	insn_off =3D insn->off;
> +	if (dst_reg =3D=3D BPF_REG_PARAMS) {
> +		/*
> +		 * Args 7+: reverse BPF negative offsets to
> +		 * x86 positive rsp offsets.
> +		 * BPF off=3D-16 =E2=86=92 [rsp+0], off=3D-24 =E2=86=92 [rsp+8], ...
> +		 */
> +		insn_off =3D outgoing_arg_base - outgoing_rsp -
> +			insn_off - 16;
> +		dst_reg =3D BPF_REG_FP;
> +	}

[Severity: High]
Does hiding the BPF_REG_PARAMS translation inside emit_st() conflict with t=
he
stated goal of adding KASAN instrumentation before the call?

If KASAN checks are inserted in do_jit() before emit_st() is called, wouldn=
't
they attempt to instrument Arg 6 (which uses register r9, not memory)?

Additionally, wouldn't any KASAN checks added before this helper use the raw
BPF_REG_PARAMS pseudo-register before it is translated to BPF_REG_FP, causi=
ng
instrumentation against an unmapped register (which evaluates to rax)?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-kasan-v5-0=
-1c64af8e4e1e@bootlin.com?part=3D5
