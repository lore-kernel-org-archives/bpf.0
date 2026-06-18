Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534F72E7369
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 03:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781754919; cv=none; b=aZoaCrNuR9Gz8ZGBL6k57n7+bDc7IeVJop5pxGSsH4DZjxm/8dtbb01sfyjYUGWYLRlQ39tNviZr63JnYUvTFP+ax1Z0lvlEyhswRmoqmX4pGeZkPCvwpf4xS4tEwX9eHCI5hsNz75E6LANtpo8FM0sCn7s+Vo6pk7z02rJkeus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781754919; c=relaxed/simple;
	bh=2SiXmnCMYy3vpUtyU6YpFLYMHVbwGOqHWxThN0TR/5Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lxkm+n1AerxgvDxoZAG7qMOnSJR0FBzlkRPdy/j56pu/tqTZClnLh+CB5MA7EJlrd7BTFN5edDQc4ZRDKnK/55vgbEXP0EDB+bJUdmOiEEB5ME2gpbT+uuKAWS+QAYo7vl9EQltb0BCSD3iX+qT5s8IUMxfoUWm4fRi/xFZeHUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWAht3qh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWAht3qh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3601F000E9;
	Thu, 18 Jun 2026 03:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781754918;
	bh=q/wDdDCvRV2RXlB6ouaxrRNdghIxcdwYVWLznJZmNcc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QWAht3qh17IgBBvqg24YCnKZr/qCBjX4Z6AWmTQVkh9B7k/w9Hj8HqYjA07s4Q4Kq
	 itmHXMsSsxLeXDle0DMF78ndItGtpIxzBrvs8BA8JOsf6iSt77xMdKIXCkzsowPFDz
	 WrxwRoVs7XzOEVzVhKjbAiS3scOMQvTPJMG6LZkd+4N8DrhuquyX3jN2CVJbs08lWj
	 nCUuSeFEMIhO3XYKA2OvEfAnGhIBVDEwLI1OP0KnAUqxt37lrnmKy8SxDsZF/6ytWe
	 37g4c01OxqNl3HwDM7sDsaFOKaH2V0Hs0LFuby9nymuF9R1r61SfcLBCPWYbX5aB+l
	 RxGh48VuAeDzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] LoongArch: BPF: Add exceptions (bpf_throw) support
Reply-To: sashiko-reviews@lists.linux.dev
To: "George Guo" <dongtai.guo@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260618033809.98253-4-dongtai.guo@linux.dev>
References: <20260618033809.98253-1-dongtai.guo@linux.dev>
 <20260618033809.98253-4-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 03:55:17 +0000
Message-Id: <20260618035517.CE3601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] `arch_bpf_stack_walk()` uses inline assembly to capture the li=
ve `$r22` register, incorrectly assuming it holds the unmodified BPF frame =
pointer.

Pre-existing issues:
- [High] Tail calls within exception programs (or arena programs) cause a k=
ernel panic (NULL pointer dereference) due to a hardcoded stack offset macr=
o.
--

commit 7327176c407071584a340964ddba1f924e66533a
Author: George Guo <guodongtai@kylinos.cn>

LoongArch: BPF: Add exceptions (bpf_throw) support

Implement BPF exception support, advertised via
bpf_jit_supports_exceptions(). bpf_throw() unwinds the stack to find the
exception boundary program's frame and then invokes its exception
callback with that frame's stack and frame pointers.

> diff --git a/arch/loongarch/kernel/stacktrace.c b/arch/loongarch/kernel/s=
tacktrace.c
> index 387dc4d3c4868..718c98b3f1fc4 100644
> --- a/arch/loongarch/kernel/stacktrace.c
> +++ b/arch/loongarch/kernel/stacktrace.c
[ ... ]
> @@ -40,6 +41,57 @@ void arch_stack_walk(stack_trace_consume_fn consume_en=
try, void *cookie,
>  	}
>  }
> =20
> +#ifdef CONFIG_UNWINDER_ORC
[ ... ]
> +void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp=
, u64 bp),
> +			 void *cookie)
> +{
> +	unsigned long fp;
> +
> +	/*
> +	 * Capture the live frame pointer ($r22/$fp) here, before handing off to
> +	 * the worker. The kernel is built with -fomit-frame-pointer, so $fp is
> +	 * an ordinary callee-saved register that is preserved across the call
> +	 * from the JITed BPF program into bpf_throw() down to here, and thus
> +	 * still points at the innermost BPF frame. The ORC frame-pointer
> +	 * fallback walks the BPF frames up to the exception boundary from it.
> +	 *
> +	 * This must be a thin wrapper with no large stack locals: the worker
> +	 * uses $r22 to address its frame, which would clobber the live $fp
> +	 * before it could be read. __builtin_frame_address() cannot be used
> +	 * either, as it is $sp-derived and would yield a kernel-stack frame.
> +	 */
> +	asm volatile("move %0, $r22" : "=3Dr"(fp));

[Severity: Critical]
Could the compiler clobber the live $r22 register before we capture it
here?

Since the kernel is built with -fomit-frame-pointer, bpf_throw() is
compiled as a standard C function and the compiler might use $r22 as a
general-purpose callee-saved register for local variables (such as the
cookie argument).

If $r22 is clobbered during bpf_throw(), this inline assembly will capture
the clobbered value instead of the unmodified BPF frame pointer. The
exception callback then blindly trusts this propagated value (passed via
$a2) to anchor its stack frame:

arch/loongarch/net/bpf_jit.c:build_prologue() {
    ...
    move_reg(ctx, LOONGARCH_GPR_FP, LOONGARCH_GPR_A2);
    emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_FP, -stack_adjust=
);
    ...
}

Could this allow a forged chain of frame pointers to dictate the callback's
return address, leading to a severe regression where arbitrary kernel code
execution is possible?

> +	walk_stackframe_bpf(consume_fn, cookie, fp);
> +}
> +#endif /* CONFIG_UNWINDER_ORC */
> +
>  int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry,
>  			     void *cookie, struct task_struct *task)
>  {

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index c410b02e64bef..22527428f0b34 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
[ ... ]
> @@ -203,7 +223,7 @@ static void build_prologue(struct jit_ctx *ctx)
>  	store_offset -=3D sizeof(long);
>  	emit_insn(ctx, std, LOONGARCH_GPR_S5, LOONGARCH_GPR_SP, store_offset);
> =20
> -	if (ctx->arena_vm_start) {
> +	if (ctx->arena_vm_start || is_exception_prog) {
>  		store_offset -=3D sizeof(long);
>  		emit_insn(ctx, std, REG_ARENA, LOONGARCH_GPR_SP, store_offset);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but does forcing REG_ARENA to be
pushed for exception programs expose an issue with the tail call layout?

When is_exception_prog is true, this adds an extra 8 bytes to the stack.
However, emit_bpf_tail_call() relies on a hardcoded stack offset macro:

arch/loongarch/net/bpf_jit.c:emit_bpf_tail_call() {
    ...
    int tcc_ptr_off =3D BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
    ...
    emit_insn(ctx, ldd, t3, REG_TCC, 0);
    ...
}

Since BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size) evaluates to a fixed
offset (stack_size - 80) regardless of whether REG_ARENA was pushed, does
this cause emit_bpf_tail_call() to incorrectly fetch the TCC integer
instead of TCC_PTR?

If it fetches the integer (often 0) and immediately dereferences it, would
tail calls within exception programs or arena programs cause a NULL pointer
dereference?

> @@ -212,6 +232,7 @@ static void build_prologue(struct jit_ctx *ctx)
> =20
>  	emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_adjust);
> =20
> +setup_bpf_fp:
>  	if (ctx->priv_sp_used) {
>  		/* Set up the private stack pointer and the BPF frame pointer */
>  		void __percpu *priv_stack_ptr;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618033809.9825=
3-1-dongtai.guo@linux.dev?part=3D3
