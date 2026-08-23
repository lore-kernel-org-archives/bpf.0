Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661D530D40F
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 16:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787503962; cv=none; b=gWw1tajloFroYldtfG5/zLlOgSDva217W5aJjXI2sdjBGY+RnEn58zO3x6/zN772chHgvffZtKwW+gj1tVnI1v51BtIpmBruPxKMIW5ITgQkaZ6q1/y/N1u7tQd4EpySKRZ4lZ1pecUAGpcvaS9DCGmWBoswtX9iEKOXdJ1bKrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787503962; c=relaxed/simple;
	bh=O9PxwSmVusrXX94TLnGEI17FO0wL7oDqX1+p1KixN9o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AYImWyE16Nq3KCgICIdIlPXIiBWdcCUQY6B+EWMCQcnlx0LbmCsjU03ZfioGr/y6tufu3hjqUtTE3Z3GpSZz735iWIn8UTkAXqPLkwumRmRzAFWfCgv6xuEEl5LbqeJlOilZzbDA2gPEj2KG0an0z5Q8ikmrI9cd/x9aNHo/zZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ul/FcHD/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ul/FcHD/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67C21F00A3A;
	Sun, 23 Aug 2026 16:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787503951;
	bh=DWEkWDtA/Inlp0lsgGGiuBs0pB7qdc3f66K6akQII7g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ul/FcHD/vVGB0ZhOUvEETovFXF5bJuiQoO8n+Q/gn4Z/+1u298Xh0ThV+MpCXsPHa
	 EH9DK4R2IKtzjfX8Iz1v/UQv/9h3rRkG7LE2zAVjCbNFn7zF0PZG29/GMlusPnkJqW
	 BStrybt7aZAf7fs4HnxSZ82x6ac3AoIiQ0AtRnk49lFDBC9jIPduQUKTP/7AybVnkJ
	 Fn2hCWxOYi57BYFRBbkGo6AzOWOlt7PPIji0h8dH0y6yajOYkofiWNT6QEplmMXyb0
	 Er1ON1+xRAV2qVWc+Uk02iWYra0mzNgI68wC5w1QyV14YYNtWTI2iuPhkHxgEXmXS8
	 eJ2c/oNiPM6Jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5] m68k, bpf: Add initial BPF JIT compiler
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuan-Wei Chiu" <visitorckw@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260823163812.3024812-1-visitorckw@gmail.com>
References: <20260823163812.3024812-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 16:52:30 +0000
Message-Id: <20260823165230.E67C21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Hardcoded jump offset in tail call implementation corrupts BPF fra=
me pointer on ColdFire processors.
- [High] Silent failure during the dry run of an extra_pass leaves the prog=
ram in an inconsistent state, deceiving the BPF core subsystem.
--

--- Patch [1]: [PATCH bpf-next v5] m68k, bpf: Add initial BPF JIT compiler =
support ---
commit 1c48a3daa4134e7c3b2c0ae3d4113bebafb9922b
Author: Kuan-Wei Chiu <visitorckw@gmail.com>

    m68k, bpf: Add initial BPF JIT compiler support

    Add a BPF JIT compiler for the m68k architecture.
   =20
    The JIT generates m68k machine code targeting m68020+ processors and
    coldfire parts with an mmu (ISA_B/ISA_C). It excludes plain 68000/68010
    and non-mmu coldfire processors, as it relies on 32-bit branch
    displacements (b<cc>.l) to handle large bpf programs.

> diff --git a/arch/m68k/net/bpf_jit_comp.c b/arch/m68k/net/bpf_jit_comp.c
> new file mode 100644
> index 0000000000000..e3a5dca70a3f3
> --- /dev/null
> +++ b/arch/m68k/net/bpf_jit_comp.c

[ ... ]

> +static void emit_tail_call(const struct bpf_insn *insn, struct jit_ctx *=
ctx)
> +{
[ ... ]
> +	emit_16(ctx, 0x2068);					/* movea.l d16(%a0), %a0 */
> +	emit_16(ctx, offsetof(struct bpf_prog, bpf_func));
> +
> +	emit_16(ctx, 0x4ee8);					/* jmp d16(%a0) */
> +	emit_16(ctx, 44);

[Severity: High]
Can this jump offset corrupt the BPF frame pointer on ColdFire CPUs?

The hardcoded offset assumes a 44-byte prologue. While standard m68k
uses a 44-byte prologue, looking at build_prologue(), ColdFire CPUs use a
48-byte prologue because the 4-byte movem.l sequence is replaced by an
8-byte sequence:

        if (CPU_IS_COLDFIRE) {
                emit_16(ctx, 0x4fef);                           /* lea -16(=
%sp), %sp */
                emit_16(ctx, 0xfff0);
                emit_16(ctx, 0x48d7);                           /* movem.l =
d2-d5, (%sp) */
                emit_16(ctx, 0x003c);
        } else {

Jumping to offset 44 on ColdFire jumps into the middle of the last
prologue instruction, skipping the initialization of the lower 32 bits
and zeroing of %d0. This stores uninitialized data into the upper 32
bits of the BPF frame pointer (BPF_REG_10), which can cause out-of-bounds
memory accesses and kernel panics on stack access.

> +
> +	if (ctx->target) {
> +		ctx->target[jmp_out_1] =3D (ctx->idx - jmp_out_1) * 2;
> +		ctx->target[jmp_out_2] =3D (ctx->idx - jmp_out_2) * 2;
> +		ctx->target[jmp_out_3] =3D (ctx->idx - jmp_out_3) * 2;
> +	}
> +}

[ ... ]

> +struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog)
> +{
[ ... ]
> +	build_prologue(&ctx);
> +	if (build_body(&ctx) < 0)
> +		goto out_off;

[Severity: High]
Does this error path leave the program in an inconsistent state if it
fails during an extra pass?

During an extra_pass (used for resolving subprogram addresses),
prog->jited is already set to 1 from the previous pass. The error
path jumps directly to out_off:

> +	build_epilogue(&ctx);
[ ... ]
> +out_off:
> +	kvfree(ctx.offsets);
> +	return prog;
> +}

This return does not clear prog->jited or prog->bpf_func. The BPF core
checks if (!prog->jited) and incorrectly assumes the compilation succeeded.

During the first pass, bpf_jit_get_func_addr() sets func_addr =3D NULL
without returning an error, successfully emitting an image with calls
to NULL. If the extra_pass fails (e.g. invalid subprogram offset), the
core will not abort and will execute the BPF program, calling a NULL
pointer and leading to a kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823163812.3024=
812-1-visitorckw@gmail.com?part=3D1
