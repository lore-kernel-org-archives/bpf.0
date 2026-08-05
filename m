Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34237425873
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 21:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785964549; cv=none; b=eRgC6Y/XHui1dh3yFOVWL6J38gsgaDKLlRqqImqWKO5X0WQYwNEmIFry57EsO0TwaaGEPXJ5Be6ESmMueaZzelKv8tFLDLwulEqcWeaUca7lYhmzN1ZOMHiv7S+poSn7zpmGLFyFEefCG58z+qGF+e0HBVczPTgCHwPQ8T3cg64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785964549; c=relaxed/simple;
	bh=aZ/0uMcZ/0xQUAKj1YkManrAOg1b6Sg7mo3lQGVxd0M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sZYGJJllfC4yJmQa1hv3bRnkJ5lJ++xhR2wR9SsBKvhHCfblFZ+HWL5e4OunJX0oCbngBCAg0Foi7D+/ei+i0gZU51i/rk8l0Tbo52xsUw++vUyMM2aPEtL53v8KBwJXmK88fwt8yfqKyOiebjM0+sG+3i7BPXhW7AoWobv3CQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuMORNOi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuMORNOi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3829B1F000E9;
	Wed,  5 Aug 2026 21:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785964537;
	bh=bp4ENuFkMfsccgNH6PaCpGXFeIolGOVKQCAjtYVGGbM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QuMORNOiZNoG1KeqFpHnJD8bOsbnzVIjHZsk3NoHNhU8sTQuCPe/gpZhFHrVO7IhJ
	 6uou0AyDYw+KiX/I2+YDFp0dGLvMZwOo1RBlOnWlu08DC8BeseQoB0FyafJwVw+Vln
	 uQpZMMCP3KW2U2jbHz79/m8MW58FME/DF+OqMYBWkxs5chub3TbQ2h6uF9XmEVE2g3
	 1bZNF26Po/iHM2Tsf2Hbe4RYCFbsFBTBzrBrUPbu7MHc4q0jTYNJnqZDnRSH2nkJy+
	 r9T5J0FEHqWgpEo6F+kXP26gGGYiG9OXMUNXdQpwXGqcrfs1qvtgCJTHbcPcloZFMW
	 XyyIc7Rt3PQFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 11/13] bpf, x86: Fix stack-passed arguments
 for indirect trampolines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260805210427.3218326-12-memxor@gmail.com>
References: <20260805210427.3218326-1-memxor@gmail.com>
 <20260805210427.3218326-12-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 21:15:36 +0000
Message-Id: <20260805211537.3829B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix for stack-passed arguments in struct_ops trampoline=
s leaves identical bugs unfixed on ARM64, RISC-V, and LoongArch
--

--- Patch [11]: [PATCH bpf-next v4 11/13] bpf, x86: Fix stack-passed argume=
nts for indirect trampolines ---
commit 08733054ec575a092fdc6b844fb5b2af4d47355a
Author: Tejun Heo <tj@kernel.org>

bpf, x86: Fix stack-passed arguments for indirect trampolines

This commit corrects the stack offset for reading stack-passed arguments
in indirect trampolines on x86. It adjusts the offset from rbp + 24 to
rbp + 16 to account for the single return address on the stack when the
trampoline is called through a function pointer.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index cb8ee0f3a6423..5c5c32aba2396 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3075,6 +3075,7 @@ static void save_args(const struct btf_func_model *=
m, u8 **prog,
>  {
>  	int arg_regs, first_off =3D 0, nr_regs =3D 0, nr_stack_slots =3D 0;
>  	bool use_jmp =3D bpf_trampoline_use_jmp(flags);
> +	int stack_args_off =3D (use_jmp || (flags & BPF_TRAMP_F_INDIRECT)) ? 16=
 : 24;

[Severity: High]
This is a pre-existing issue, but while fixing this for x86, are arm64,=20
riscv, and loongarch also affected by the same struct_ops stack-passed=20
arguments bug?

Looking at arm64 in arch/arm64/net/bpf_jit_comp.c:save_args(), the offset
seems unconditionally hardcoded to 32, assuming an fentry stack frame layou=
t:

soff =3D 32; /* on stack arguments start from FP + 32 */

Similarly for riscv in arch/riscv/net/bpf_jit_comp64.c:store_args():

emit_ld(RV_REG_T1, 16 + (i - RV_MAX_REG_ARGS) * 8, RV_REG_FP, ctx);

And loongarch in arch/loongarch/net/bpf_jit.c:store_args():

emit_insn(ctx, ldd, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP,
          16 + (i - LOONGARCH_MAX_REG_ARGS) * 8);

Do these architectures also need a similar adjustment for=20
BPF_TRAMP_F_INDIRECT to avoid reading out-of-bounds or garbage values from=
=20
the stack for struct_ops callbacks with more than 8 arguments?

>  	int i, j;
> =20
>  	/* Store function arguments to stack.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805210427.3218=
326-1-memxor@gmail.com?part=3D11
