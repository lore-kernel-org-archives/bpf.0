Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDE5274658
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764572; cv=none; b=T3+DDf7vCEq23vYL9oCxQnKrg50QRnfDI59KFkQOo+CWRW0alFST5DkGE8EII7TyshKeVfNt0KXT0m5l1wyQATvlQRjsgdUR2ahoV6j3ECz2Y8VKgaKE5htZl3bn9rlsVoQVfBQOEqW0SZJMKGD5cfF/xUvI9e7QORxXp3PUoz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764572; c=relaxed/simple;
	bh=jpud3Ct6zPwbDCvat5ZmocIM5EB3dlGrttTljuUa7zg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j1QN0oZdL5JlIv0F7ZRpSZzXD5gH+0ptMX+nchpD4jS04uBGFwF0LiVFwa/u53ZmzIc+zrxqHJRn2TIn3+Q84VGQCZlWHG3ej20Qc5Jwyi9KS8IvoJQT1o7xKV9cwR3QLq5r+p0kOedTsPu42dsYCAbL8fOHQR8A9xgB2dczTus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMLc1FeJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMLc1FeJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14051F000E9;
	Mon,  3 Aug 2026 13:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785764570;
	bh=ObQK0K8pWK39tbeBXd5IYC8bVkyp3qxReF2OUUUC0pc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GMLc1FeJV6Q763XMiRiT4ffnBCZdC3BRMPtniFKgsBZGPkJrBaIg19adRSRdYLPgM
	 VrEKvZy1RiWXmI8ZM0JqCmhpPt5UTkoqq4jRT4UMMFX9PPCN075OEa4t2oMw1SXXH+
	 3wOWSoK/amRkcy9S78YU4VtxPWR2SWXnz79XnROpYwW5+Wb3/7mU8dnCMPOHs5fh5j
	 LHRBOY3KvYeA5CHi2KOgTpUTy6TBYZYMpssZR1ILF71EFbJOtFT6arMh+a4rP9/hP1
	 BxhzF6ilaPb11FVpuWx1YIPe999Pm7PN47SNJfkV1YMnNAgJVqbgG0iUtPegxt050S
	 RdlBPrArjdedQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 8/9] bpf, x86: Fix stack-passed arguments
 for indirect trampolines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803125115.2264733-9-memxor@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
 <20260803125115.2264733-9-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 13:42:48 +0000
Message-Id: <20260803134250.A14051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The fix for stack-passed arguments in indirect trampolines was o=
nly applied to x86, leaving identical bugs in ARM64, RISC-V, and LoongArch.
--

--- Patch [8]: [PATCH bpf-next v3 8/9] bpf, x86: Fix stack-passed arguments=
 for indirect trampolines ---
commit 010f92af9c8f5bd1141eaf8fc752e0f9df18e07d
Author: Tejun Heo <tj@kernel.org>

bpf, x86: Fix stack-passed arguments for indirect trampolines

This commit fixes the stack offset for arguments passed on the stack
when entering an indirect trampoline on x86. The adjustment accounts for
the fact that only the caller's return address is on the stack, not the
origin function's return address.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index f70689b27845f..4b3e5d8a4a563 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3075,6 +3075,7 @@ static void save_args(const struct btf_func_model *=
m, u8 **prog,
>  {
>  	int arg_regs, first_off =3D 0, nr_regs =3D 0, nr_stack_slots =3D 0;
>  	bool use_jmp =3D bpf_trampoline_use_jmp(flags);
> +	int stack_args_off =3D (use_jmp || (flags & BPF_TRAMP_F_INDIRECT)) ? 16=
 : 24;

[Severity: Medium]
This is a pre-existing issue, but since we are fixing the stack-passed
arguments for indirect trampolines on x86 here, should we also address
the same issue on other architectures?

For instance, on ARM64, in save_args() in arch/arm64/net/bpf_jit_comp.c,
the offset is hardcoded assuming both parent and patched function frames
were pushed:

    soff =3D 32; /* on stack arguments start from FP + 32 */

For indirect trampolines, only one frame is pushed, so the arguments would
start at FP + 16.

Similarly, in RISC-V's store_args() in arch/riscv/net/bpf_jit_comp64.c:

    emit_ld(RV_REG_T1, 16 + (i - RV_MAX_REG_ARGS) * 8, RV_REG_FP, ctx);

And in LoongArch's store_args() in arch/loongarch/net/bpf_jit.c:

    emit_insn(ctx, ldd, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP,
              16 + (i - LOONGARCH_MAX_REG_ARGS) * 8);

Both of these hardcode the offset relative to FP, ignoring that FP is
aligned with SP for indirect trampolines.=20

If a struct_ops callback is invoked with enough arguments to force
stack-passing on these architectures, will they read garbage values instead
of the actual arguments?

>  	int i, j, slot =3D 0;
> =20
>  	/* Store function arguments to stack.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803125115.2264=
733-1-memxor@gmail.com?part=3D8
