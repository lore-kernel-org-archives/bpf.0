Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D383D349A
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784153654; cv=none; b=famtGPWeEs5xChWrkNZCeTQeaoGjBCJg7z7KDEAtv7W6JNafguleg71Ag+qThq4BVZA/GgyhoAlSfalL9atNeSXWmh0opRS+Z/uS3yRnPUPfAxconqfRhUiqn46OPqMmexJsdxDRilTHpf398ouTFqTEMtBCjmzH5BtLbj7uWQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784153654; c=relaxed/simple;
	bh=0XISBnDoS3yCH76EPutTBjIyx4UBxPfOdWUa9/QHXAY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hY9XOZmVbYOAA3tmBaqKzKXNk6G3s9O8aTCbLmQtKKvGJ9NUIyh+MDf51XoAOwg5WPCZoRsAEmIdPGUn4dJn6hUflCXI4bWHTtmDKxoZ5ShTZpFzc9AOrwPGgxGyKE8d+NeEnuDi/Q8ZZvSUrGsqwdYCHlSBBLlits+8/iNvJdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCmk8xw5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCmk8xw5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF3D1F000E9;
	Wed, 15 Jul 2026 22:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784153652;
	bh=vCsGiv70CWm2Dx2Tq4hoW4Ryd+w4ExWY1HRyzXaZyhU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fCmk8xw5zUCX3BR94M9Cu8Cb5OaBINJYrJNy6HPcRczaqb1J2FeEQia7PQPvl4V78
	 GLrf7LZM5TDBLJIx21qgEY/7TTj+IXGMdb/OKKWt+ywY73JFzcfRbshmgtuQ3zGpAa
	 egALdNRdXGPSN+yiiJbnzq/qzo0255PAXQe4tZPoJpvVlfcWrkG83EUqTl7saXZiPd
	 J9yB+ctpbg+Ifrt0SGnKj5hv/6BUsncPEpH2DtWlcPLLzS9MnYwfs9MsIM7sZXf2a8
	 PQ2WbcEIGTLJ/quuXrqx37yjr2mOpqGZ4NFmNx35WQe2Zskng0LZPmwLy9fJupeTHs
	 yPayVjy0Dnhmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 8/9] bpf, x86: Fix stack-passed arguments
 for indirect trampolines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260715220052.1590783-9-memxor@gmail.com>
References: <20260715220052.1590783-1-memxor@gmail.com>
 <20260715220052.1590783-9-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 22:14:12 +0000
Message-Id: <20260715221412.ACF3D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The patch correctly fixes the struct_ops stack argument offset b=
ug for x86, but leaves the exact same bug unfixed in the ARM64, RISC-V, and=
 LoongArch BPF JIT implementations.
--

--- Patch [8]: [PATCH bpf-next v1 8/9] bpf, x86: Fix stack-passed arguments=
 for indirect trampolines ---
commit 804aec167442bbd8ddbbc13495bc188618bbaeaf
Author: Tejun Heo <tj@kernel.org>

bpf, x86: Fix stack-passed arguments for indirect trampolines

This commit fixes a bug in the x86 BPF JIT where stack-passed arguments
for indirect trampolines (such as struct_ops) were read from the wrong
offset. It correctly adjusts the offset to account for only the caller's
return address being on the stack, which fixes callbacks that have more
than six arguments.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 2f25353f135bd..672fe54dfeb8d 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3074,6 +3074,7 @@ static void save_args(const struct btf_func_model *=
m, u8 **prog,
>  {
>  	int arg_regs, first_off =3D 0, nr_regs =3D 0, nr_stack_slots =3D 0;
>  	bool use_jmp =3D bpf_trampoline_use_jmp(flags);
> +	int stack_args_off =3D (use_jmp || (flags & BPF_TRAMP_F_INDIRECT)) ? 16=
 : 24;

[Severity: Medium]
This is a pre-existing issue, but does this same bug also need to be fixed
in the ARM64, RISC-V, and LoongArch BPF JIT implementations?

On ARM64, save_args() unconditionally hardcodes a 32-byte offset:

arch/arm64/net/bpf_jit_comp.c:save_args() {
    ...
    soff =3D 32; /* on stack arguments start from FP + 32 */
    ...
}

This seems to assume two 16-byte frames (FP+LR and FP+R9), but struct_ops
only pushes one, meaning stack arguments would start at FP + 16.

Similarly, on RISC-V and LoongArch, store_args() unconditionally skips 16
bytes for the traced function's T0 and FP frame:

arch/riscv/net/bpf_jit_comp64.c:store_args() {
    ...
    /* skip slots for T0 and FP of traced function */
    emit_ld(RV_REG_T1, 16 + (i - RV_MAX_REG_ARGS) * 8, RV_REG_FP, ctx);
    ...
}

For BPF_TRAMP_F_INDIRECT (is_struct_ops), the prologue aligns FP directly
to the caller's SP, so arguments start exactly at FP. Will these hardcoded
offsets cause the JIT to read 16 bytes past the actual arguments on these
architectures as well?

>  	int i, j, slot =3D 0;
> =20
>  	/* Store function arguments to stack.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715220052.1590=
783-1-memxor@gmail.com?part=3D8
