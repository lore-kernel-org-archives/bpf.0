Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE0819D8BC
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 10:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789208199; cv=none; b=U5uz/iurnIEHVN9oUl13G7zlN7KqKkr4v5OjbE3HoNlmw/FgAWX3BWS19O4i7mV1Ng9GC/7kW1+jueCFfCkd/m2Pcv2BG3Oy9eC5kTM9Fb1CAJ+44DLx87637l71g9HbwTm3B7aQJmiTERlP4jry1Bzbuv7pBTEt7urNtvnBzGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789208199; c=relaxed/simple;
	bh=4EufPJykpmbDazDM6aQTkEg7cpU6NMwlSpOvqbojqg8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UZQPZyRmvKCWnxkHQGvzs3leR32FkV2EoVBHm1hTkQTJNiVd5cXwv07xEC+5nz32j2CwTyAPfoqEQdt7TsvK0hWjZACEKM+mFKiqldTo4FWxcIPSXr5Svh2GBehTSwABOdEkzYfuhP3HBd+pyBNnLeoBblYOM6htgtLSsWpIbhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gst5tiOX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gst5tiOX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1391F00898;
	Sat, 12 Sep 2026 10:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789208191;
	bh=+r/MPhJ6vXnRNHC1s421HvsISrEaIBL+Dds9uXjROfk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gst5tiOXWxeA5nXmy0U9PSOOLJRmED4RJc0S0I/0bCkFfWpSlbRI0UEn1mGKuU0Bp
	 SIKXDLZDNcrc7yW0h530bcwPU1iI8EDtrY4LM3y8NR+T65jN/RC6hudTYNr+n2L5R3
	 1rfjuEwMbsCibjuQsks3oAxIgJ9C/hJx2+ThnSyZi7XuAEcKfkHnpGkEUCntvkE3jv
	 AsziyVVqIqER2+70CFQI8S8/Hez6ki0UK1UvsLvqyJmZyADtzYT0qHVlSNEB+/h5RR
	 K1u64h5Mkn5v9J4G0D1h5XSO4bQ97rysOrc+5pk4Sjr5evy1Y/JG0Q90/9QKpxKoiC
	 BZYAQYFkjiGLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: Skip detached progs in trampoline
 images that are still in use
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RmxvcmVudCBSZXZlc3QgKEFudGhyb3BpYyk=?= <florent.revest@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260912095924.866254-2-florent.revest@linux.dev>
References: <20260912095924.866254-1-florent.revest@linux.dev>
 <20260912095924.866254-2-florent.revest@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 10:16:30 +0000
Message-Id: <20260912101631.5B1391F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Multi-instruction text patching race on RISC-V and LoongArch allow=
s preempted tasks to resume in the middle of a patched jump sequence, causi=
ng corrupted execution or a kernel panic.

Pre-existing issues:
- [High] The patch reduces but fails to eliminate a Use-After-Free race con=
dition due to a preemption window between the newly added skip NOP and the =
invocation of `__bpf_prog_enter()`.
--

commit b13d0586f44d60d57190a44d87f26e74f8b81f65
Author: Florent Revest (Anthropic) <florent.revest@linux.dev>

bpf: Skip detached progs in trampoline images that are still in use

This commit extends the trampoline architecture to patch a NOP in front of
each BPF program call sequence with a jump over the sequence when the progr=
am
is detached. This skips execution of detached programs for tasks that are
still running inside an older trampoline image.

Link: https://lore.kernel.org/bpf/20260815071927.147049-1-zirajs7@gmail.com/

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index c18e005a41dbe..9c166bdfbc6a6 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -2429,6 +2430,10 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, s=
truct bpf_tramp_node *node,
>  	enter_prog =3D (u64)bpf_trampoline_enter(p);
>  	exit_prog =3D (u64)bpf_trampoline_exit(p);
> =20
> +	/* nop, patched to skip this prog when it is detached */
> +	skip =3D ctx->ro_image + ctx->idx;
> +	emit(A64_NOP, ctx);
> +
>  	if (node->cookie =3D=3D 0) {
>  		/* if cookie is zero, one instruction is enough to store it */
>  		emit(A64_STR64I(A64_ZR, A64_SP, run_ctx_off + cookie_off), ctx);

[Severity: High]
This is a pre-existing issue, but does this still leave a use-after-free
window between the newly added skip NOP and the __bpf_prog_enter() call in
invoke_bpf_prog()?=20

If a task on a preemptible kernel executes this NOP but is involuntarily
preempted before calling __bpf_prog_enter() (where rcu_read_lock or=20
rcu_read_lock_trace would be acquired), it hasn't blocked the RCU grace=20
periods yet.=20

If another CPU detaches the program, patches the NOP, and drops the program=
=20
reference during this preemption, the program could be freed. When the
preempted task resumes, could it load the now-freed program pointer and call
__bpf_prog_enter(p) on freed memory?

[ ... ]

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 4da2789009383..0e6f1ad36c2d5 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1696,13 +1696,19 @@ static void restore_stk_args(struct jit_ctx *ctx,=
 int nr_stk_args, int args_off,
>  	}
>  }
> =20
> -static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_node *n,
> -			   int args_off, int retval_off, int run_ctx_off, bool save_ret)
> +static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_image *=
im,
> +			   struct bpf_tramp_node *n, int args_off, int retval_off,
> +			   int run_ctx_off, bool save_ret)
>  {
> -	int ret;
> +	int i, ret;
>  	u32 *branch;
>  	struct bpf_prog *p =3D n->link->prog;
>  	int cookie_off =3D offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
> +	void *skip =3D ctx->ro_image + ctx->idx;
> +
> +	/* nops for move_imm+jirl, patched to skip this prog when it is detache=
d */
> +	for (i =3D 0; i < LOONGARCH_LONG_JUMP_NINSNS; i++)
> +		emit_insn(ctx, nop);
> =20
>  	if (n->cookie)
>  		emit_store_stack_imm64(ctx, LOONGARCH_GPR_T1,

[ ... ]

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index 151031e97a243..21f8ce2ec89ae 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -904,12 +904,18 @@ static void emit_store_stack_imm64(u8 reg, int stac=
k_off, u64 imm64,
>  	emit_sd(RV_REG_FP, stack_off, reg, ctx);
>  }
> =20
> -static int invoke_bpf_prog(struct bpf_tramp_node *node, int args_off, in=
t retval_off,
> -			   int run_ctx_off, bool save_ret, struct rv_jit_context *ctx)
> +static int invoke_bpf_prog(struct bpf_tramp_image *im, struct bpf_tramp_=
node *node,
> +			   int args_off, int retval_off, int run_ctx_off, bool save_ret,
> +			   struct rv_jit_context *ctx)
>  {
>  	int ret, branch_off;
>  	struct bpf_prog *p =3D node->link->prog;
>  	int cookie_off =3D offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
> +	void *skip =3D ctx->ro_insns + ctx->ninsns;
> +
> +	/* 2 nops for auipc+jalr, patched to skip this prog when it is detached=
 */
> +	emit(rv_nop(), ctx);
> +	emit(rv_nop(), ctx);

[Severity: High]
Is there a risk of a partial jump execution here if a task is preempted?=20

On preemptible RISC-V and LoongArch kernels, the patch emits a=20
multi-instruction NOP sequence (2 NOPs on RISC-V, 5 on LoongArch) before=20
each program invocation.=20

If bpf_arch_text_poke() patches this sequence to a multi-instruction jump=20
while a task is involuntarily preempted between these instructions, will th=
e=20
task resume and execute only the second half of the jump?=20

On RISC-V, this could cause it to execute jalr without the preceding auipc,
using an uninitialized or stale register and jumping to a garbage address.

[ ... ]

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 2853e87797a78..0d974da4f5093 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3217,16 +3217,21 @@ static void restore_regs(const struct btf_func_mo=
del *m, u8 **prog,
>  }
> =20
>  static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
> +			   struct bpf_tramp_image *im,
>  			   struct bpf_tramp_node *node, int stack_size,
>  			   int run_ctx_off, bool save_ret,
>  			   void *image, void *rw_image)
>  {
>  	u8 *prog =3D *pprog;
> -	u8 *jmp_insn;
> +	u8 *jmp_insn, *skip;
>  	int ctx_cookie_off =3D offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
>  	struct bpf_prog *p =3D node->link->prog;
>  	u64 cookie =3D node->cookie;
> =20
> +	/* nop, patched to skip this prog when it is detached */
> +	skip =3D image + (prog - (u8 *)rw_image);
> +	emit_nops(&prog, X86_PATCH_SIZE);
> +
>  	/* mov rdi, cookie */
>  	emit_mov_imm64(&prog, BPF_REG_1, (long) cookie >> 32, (u32) (long) cook=
ie);

[Severity: High]
This is a pre-existing issue, but similar to the ARM64 code above, does this
leave the same use-after-free window between the new skip NOP and the=20
__bpf_prog_enter() setup?

If a task executes the NOP but is preempted on a CONFIG_PREEMPT=3Dy kernel=
=20
before __bpf_prog_enter() acquires RCU protection, the detached program mig=
ht=20
be freed while the task is asleep. When the task wakes up, it would then ju=
mp
into a freed bpf_prog structure.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912095924.8662=
54-1-florent.revest@linux.dev?part=3D1
