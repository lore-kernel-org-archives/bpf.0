Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E48EAC7
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 01:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785030674; cv=none; b=n2fbiYJaAH13ld4YEgT8s8PE25w27i1XRrGA+ojkSkZEzi28oTq5GmPiSGB55gCpcgInT97Jzz+lBkzRsHeM3KTeOjeIYSiWD0Ic7g5BwFsyDhV0dciy3rMpYT+R4xI6rTzzOUWwfXUXRp0G1Cgz8kWu+3VRjsWE155Jr+G6IWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785030674; c=relaxed/simple;
	bh=N8Ino2vuIJu3F4DG32z+qe7Z5vpEo2YVYC7WI+Wip7c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SH1wIJFdA21gafTSavLUVLtukWrR3HVOwOk5whuobqcs5qNHSDEyi118Rm9vdhATuyY8962Exc9wH2ee/piuVDg5ChIUeUU4ORU8vjB3dkinGUGkD0LC6Py5lVxRYpmdqC+ZLdc1q2/3Qtw0WvUdhIs8Vf+aOeip3/8tTUra4kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZSfLSyg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZSfLSyg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CACC1F000E9;
	Sun, 26 Jul 2026 01:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785030672;
	bh=YHqeynC0GttooU9TziQRlx6yqY8p+qCiZRqMLeDHAGo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dZSfLSygbyc/AV8nNtSnpRMy5e567pyyQxnsfbFi3iNCVB18AHe3MPOjCyAebfK5e
	 tYa9fcM4kghVFZzRngcQs2e21sSmkYO8Pp9xpdbO1j4HOjc0sn5Jpgjl5U96XevybI
	 dVS1cuo5WPUQAllSeZMaAdzaJkVBC2OqlvBm1KByZHdvGpshCHHIR0J5oJOS15G+Si
	 Zs85ThRaNLdvIzFT6NGg77cL4utZk7a0K9mt5RNr1VNSFSiSLUGWDSqMgp06yNGtXp
	 SL96QaAqXAga/26XGS2lNHom7wnyipjJktoKvYoXRGLnYhmJMy+Z7S6T8xAoHuQd9N
	 3BOVAV7MZg04A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 8/9] bpf, x86: Fix stack-passed arguments
 for indirect trampolines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260726013105.3689867-9-memxor@gmail.com>
References: <20260726013105.3689867-1-memxor@gmail.com>
 <20260726013105.3689867-9-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 01:51:12 +0000
Message-Id: <20260726015112.7CACC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fixes the stack-passed argument offset for indirect stru=
ct_ops trampolines on x86, but leaves the exact same logical bug unfixed in=
 the ARM64, RISC-V, and LoongArch BPF JIT compilers.
--

--- Patch [8]: [PATCH bpf-next v2 8/9] bpf, x86: Fix stack-passed arguments=
 for indirect trampolines ---
commit 1625042935fc87b38acf83c8304433545d672f35
Author: Tejun Heo <tj@kernel.org>

bpf, x86: Fix stack-passed arguments for indirect trampolines

This patch fixes the calculation of stack-passed arguments for indirect
trampolines in the x86 BPF JIT compiler. It introduces stack_args_off
to properly handle the number of return addresses on the stack depending
on how the trampoline was called.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index dfb5335ad8374..4b349ae35ebf9 100644
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
This is a pre-existing issue, but does this same logical bug need to be fix=
ed
for ARM64, RISC-V, and LoongArch?=20

Looking at arch/arm64/net/bpf_jit_comp.c:save_args(), there is a hardcoded
offset that unconditionally assumes two frames were pushed:

    soff =3D 32; /* on stack arguments start from FP + 32 */

Similarly, in arch/riscv/net/bpf_jit_comp64.c:store_args(), there is a
hardcoded offset of 16 which skips the first 16 bytes of caller arguments f=
or
struct_ops:

    emit_ld(RV_REG_T1, 16 + (i - RV_MAX_REG_ARGS) * 8, RV_REG_FP, ctx);

And arch/loongarch/net/bpf_jit.c:store_args() shares the same hardcoded off=
set:

    emit_insn(ctx, ldd, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP,
                  16 + (i - LOONGARCH_MAX_REG_ARGS) * 8);

If a struct_ops callback with more than 8 arguments (or 6 on some
architectures) is executed on these platforms, could it receive out-of-boun=
ds
stack memory instead of the actual arguments?

>  	int i, j, slot =3D 0;
> =20
>  	/* Store function arguments to stack.
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726013105.3689=
867-1-memxor@gmail.com?part=3D8
