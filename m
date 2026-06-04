Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008DF31F986
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780607296; cv=none; b=rotxFS0VsGWb6BFg/lXI8dyqbslXHLAuSOLVn8oJvoW50YYnlcfCUBY5MkFMQsOfBZ0HjVlO/R1GVLYnh0hYVgg2gE7VUZS5WakMym+mNOxlwpSUGMdg7qudVlkQzcT+JKB6beKaDxDxKV+ZNWGsxLnRD2Wvsh3Gzb9qLJgLT6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780607296; c=relaxed/simple;
	bh=KYfcgyQwCJgI0fouX7IwFRGDY/twzQdE69SUqc7QLFo=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WUG/xTZXKMRe3af1xpSneUswh02C3trwXkabgXXm6BjKlFQMgWYUI/5s5fS3D7Te4Lq9y2g0gjWEutDMcU5U5vAQuxdjUtNqKVr7h0v+6znLsaAfmQEtCwrpOqVVMCi5jL+LPWgpawINK8jpxwXK3/e/+A0fmcmOzDCBdZhPaiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQnSko6C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQnSko6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A9F1F00893
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 21:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780607295;
	bh=TRfRsvcUNmcTJCC6fznUraASTOHjC7zu2YRnNUFNdk0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=OQnSko6CcNC8yMb+cKmHauVseT+AQrTpds3bmbgkhndtc0h3xuud9bumLY7uH5ahY
	 9m6M3EGyUcS2fZqldyeUXJjVmiqHUZ34BTubg4Lz//ufIahbn/yAArB5SO6dAsHuTL
	 4588TxyulPdSJ2LeqAmmFt5gQY1EXSVIeohvnWGFI+V+rIdZ2DLpsKbWokspZcGap9
	 sp7a5cw8GeDgnkle0txqEEHL31xK0qt/cNRX1PF3dj41iisrBi5u+TMQs/nW7NpWgq
	 9C/c6uA/NnwfCNc6rLHIRK3GinAUj5ZMAR95OQ8HEdTo35e42sQFXJcWZZ4eXQ4b8S
	 10tpVI+H/JzTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 5/8] bpf, x86: emit KASAN checks into x86
 JITed programs
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <20260604-kasan-v2-5-c066e627fda8@bootlin.com>
References: <20260604-kasan-v2-5-c066e627fda8@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 21:08:14 +0000
Message-Id: <20260604210815.78A9F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] The `emit_kasan_check` function clobbers caller-saved register=
s %r10 and %r11, leading to memory corruption and verifier bypass.
- [Low] Variable declarations immediately follow a switch case label withou=
t an enclosing block, causing a compilation error.
--

commit c55dfacae42be195cdf6611359a2142fdbe64733
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf, x86: emit KASAN checks into x86 JITed programs

Insert KASAN shadow memory checks before memory load and store
operations in JIT-compiled BPF programs.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 943a0f315cf2b..cb3c03edc4bde 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> @@ -2592,13 +2622,13 @@ static int do_jit(struct bpf_verifier_env *env, s=
truct bpf_prog *bpf_prog, int *
>  			fallthrough;
>  		case BPF_STX | BPF_ATOMIC | BPF_W:
>  		case BPF_STX | BPF_ATOMIC | BPF_DW:
> +			bool is64 =3D BPF_SIZE(insn->code) =3D=3D BPF_DW;
> +			u32 real_src_reg =3D src_reg;
> +			u32 real_dst_reg =3D dst_reg;
> +			u8 *branch_target;

[Severity: Low]
Will this cause a build failure? The C standard does not allow variable
declarations immediately following a case label without an enclosing block.

>  			if (insn->imm =3D=3D (BPF_AND | BPF_FETCH) ||
>  			    insn->imm =3D=3D (BPF_OR | BPF_FETCH) ||
>  			    insn->imm =3D=3D (BPF_XOR | BPF_FETCH)) {
> -				bool is64 =3D BPF_SIZE(insn->code) =3D=3D BPF_DW;
> -				u32 real_src_reg =3D src_reg;
> -				u32 real_dst_reg =3D dst_reg;
> -				u8 *branch_target;
> =20
>  				/*
>  				 * Can't be implemented with a single x86 insn.
> @@ -2612,7 +2642,19 @@ static int do_jit(struct bpf_verifier_env *env, st=
ruct bpf_prog *bpf_prog, int *
>  				if (dst_reg =3D=3D BPF_REG_0)
>  					real_dst_reg =3D BPF_REG_AX;
> =20
> +				ip +=3D 3;
> +			}
> +			if (!bpf_atomic_is_load_store(insn)) {
> +				err =3D emit_kasan_check(&prog, real_dst_reg,
> +						       insn, ip, false,
> +						       accesses_stack_only);

[Severity: Critical]
Does emit_kasan_check() preserve all caller-saved registers it needs to?

Looking at emit_kasan_check(), it emits pushes for rax, rcx, rdx, rsi, rdi,
r8, and r9 before calling C functions like __asan_loadX, but it does not
appear to save r10 (BPF_REG_AX) or r11 (AUX_REG).

For complex atomic operations, do_jit() saves BPF_REG_0 into BPF_REG_AX
just before this call:

    /* Will need RAX as a CMPXCHG operand so save R0 */
    emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);

If emit_kasan_check() calls a C function which clobbers r10, will this
corrupt the value restored into BPF_REG_0 and potentially break verifier
assumptions?

> +				if (err)
> +					return err;
>  				branch_target =3D prog;
> +			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-kasan-v2-0=
-c066e627fda8@bootlin.com?part=3D5
