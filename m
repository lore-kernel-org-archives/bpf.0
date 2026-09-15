Received: from mta0.migadu.com (out-15.mta0.migadu.com [91.218.175.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E544CC61D
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789498490; cv=none; b=Y+Z/fVETOD12dJEI+mPQCvp6sxxwBTEYFezQpOpfh5OrIPb753jOch351i0aII7Nds26V/WwQ/1S6rYgmuknv4rHDwitdou47SBLA0jelkjwMwsAXp9haipGEwnIcLH0DTmbiaz+wQ5uGI2NZaLvXFw8IjHyM5yTBLjnunX7GPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789498490; c=relaxed/simple;
	bh=hovUe/WX/Xvc7mu2ojrRXTIOfly7oym5Ht5obs3DmBo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=uWzW3ZgNvhQh+ZlzxESGgRw2P829x4lzRHpbA6ZJrtBBQ9nCh+70pT7JhRIfT8/k9QEY9MN9kz51vR2lrMfND5vyenvS7hCl6IUxk8EVwgK6HkkShWmV4lnfAZjk3mpBu3m7IVCgOnhnpNUEf+NotneDtUjsgAKT7ZQfQI+LrtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xSBz3dqD; arc=none smtp.client-ip=91.218.175.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xSBz3dqD"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hovUe/WX/Xvc7mu2ojrRXTIOfly7oym5Ht5obs3DmBo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789498484; v=1; x=1790103284;
 b=xSBz3dqDCpqEAaLxUwlWVl+Tximt/2xEhhY/qAJnq2eCJYhtyoq9I5m/oPTIoGyGi9L52hAy
 QPNX2FgJamWTMEam0l8kU8q6U/sFBUrtGDNoUGH53DmVpum4EKHE2YgYzc9HrvTkh8Fr3ZB/vq+
 h5tqkmgl9pvZWeyfgdkn3f0w=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ebf3973597a95056;
	Tue, 15 Sep 2026 18:54:44 +0000
X-Mizu-Trace-ID: ebf3973597a95056
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Sep 2026 18:54:40 +0000
Message-Id: <DLG49OX8KPDH.3VY54JMZ69Y4F@linux.dev>
To: <sashiko-reviews@lists.linux.dev>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v2 1/2] bpf: Skip detached progs in trampoline
 images that are still in use
From: "Florent Revest" <florent.revest@linux.dev>
X-Mailer: aerc 0.17.0
References: <20260912095924.866254-1-florent.revest@linux.dev>
 <20260912095924.866254-2-florent.revest@linux.dev>
 <20260912101631.5B1391F00898@smtp.kernel.org>
In-Reply-To: <20260912101631.5B1391F00898@smtp.kernel.org>

On Sat Sep 12, 2026 at 10:16 AM UTC,  wrote:
> > --- a/arch/arm64/net/bpf_jit_comp.c
> > +++ b/arch/arm64/net/bpf_jit_comp.c
> > @@ -2429,6 +2430,10 @@ static void invoke_bpf_prog(struct jit_ctx *ctx,=
 struct bpf_tramp_node *node,
> >  	enter_prog =3D (u64)bpf_trampoline_enter(p);
> >  	exit_prog =3D (u64)bpf_trampoline_exit(p);
> > =20
> > +	/* nop, patched to skip this prog when it is detached */
> > +	skip =3D ctx->ro_image + ctx->idx;
> > +	emit(A64_NOP, ctx);
> > +
> >  	if (node->cookie =3D=3D 0) {
> >  		/* if cookie is zero, one instruction is enough to store it */
> >  		emit(A64_STR64I(A64_ZR, A64_SP, run_ctx_off + cookie_off), ctx);
>
> [Severity: High]
> This is a pre-existing issue, but does this still leave a use-after-free
> window between the newly added skip NOP and the __bpf_prog_enter() call i=
n
> invoke_bpf_prog()?=20
>
> If a task on a preemptible kernel executes this NOP but is involuntarily
> preempted before calling __bpf_prog_enter() (where rcu_read_lock or=20
> rcu_read_lock_trace would be acquired), it hasn't blocked the RCU grace=
=20
> periods yet.=20
>
> If another CPU detaches the program, patches the NOP, and drops the progr=
am=20
> reference during this preemption, the program could be freed. When the
> preempted task resumes, could it load the now-freed program pointer and c=
all
> __bpf_prog_enter(p) on freed memory?

Discussed in the thread with Junseo's reproducer.

> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -1696,13 +1696,19 @@ static void restore_stk_args(struct jit_ctx *ct=
x, int nr_stk_args, int args_off,
> >  	}
> >  }
> > =20
> > -static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_node =
*n,
> > -			   int args_off, int retval_off, int run_ctx_off, bool save_ret)
> > +static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_image=
 *im,
> > +			   struct bpf_tramp_node *n, int args_off, int retval_off,
> > +			   int run_ctx_off, bool save_ret)
> >  {
> > -	int ret;
> > +	int i, ret;
> >  	u32 *branch;
> >  	struct bpf_prog *p =3D n->link->prog;
> >  	int cookie_off =3D offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
> > +	void *skip =3D ctx->ro_image + ctx->idx;
> > +
> > +	/* nops for move_imm+jirl, patched to skip this prog when it is detac=
hed */
> > +	for (i =3D 0; i < LOONGARCH_LONG_JUMP_NINSNS; i++)
> > +		emit_insn(ctx, nop);
> > =20
> >  	if (n->cookie)
> >  		emit_store_stack_imm64(ctx, LOONGARCH_GPR_T1,
>
> [ ... ]
>
> > diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_c=
omp64.c
> > index 151031e97a243..21f8ce2ec89ae 100644
> > --- a/arch/riscv/net/bpf_jit_comp64.c
> > +++ b/arch/riscv/net/bpf_jit_comp64.c
> > @@ -904,12 +904,18 @@ static void emit_store_stack_imm64(u8 reg, int st=
ack_off, u64 imm64,
> >  	emit_sd(RV_REG_FP, stack_off, reg, ctx);
> >  }
> > =20
> > -static int invoke_bpf_prog(struct bpf_tramp_node *node, int args_off, =
int retval_off,
> > -			   int run_ctx_off, bool save_ret, struct rv_jit_context *ctx)
> > +static int invoke_bpf_prog(struct bpf_tramp_image *im, struct bpf_tram=
p_node *node,
> > +			   int args_off, int retval_off, int run_ctx_off, bool save_ret,
> > +			   struct rv_jit_context *ctx)
> >  {
> >  	int ret, branch_off;
> >  	struct bpf_prog *p =3D node->link->prog;
> >  	int cookie_off =3D offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
> > +	void *skip =3D ctx->ro_insns + ctx->ninsns;
> > +
> > +	/* 2 nops for auipc+jalr, patched to skip this prog when it is detach=
ed */
> > +	emit(rv_nop(), ctx);
> > +	emit(rv_nop(), ctx);
>
> [Severity: High]
> Is there a risk of a partial jump execution here if a task is preempted?=
=20
>
> On preemptible RISC-V and LoongArch kernels, the patch emits a=20
> multi-instruction NOP sequence (2 NOPs on RISC-V, 5 on LoongArch) before=
=20
> each program invocation.=20
>
> If bpf_arch_text_poke() patches this sequence to a multi-instruction jump=
=20
> while a task is involuntarily preempted between these instructions, will =
the=20
> task resume and execute only the second half of the jump?=20
>
> On RISC-V, this could cause it to execute jalr without the preceding auip=
c,
> using an uninitialized or stale register and jumping to a garbage address=
.

Mh, yeah, this is an existing issue with ip_after_call too. Since the targe=
t is
always within the image here, a single jal/b would be enough: either keep t=
he
current multi-instruction site (2 slots on riscv, 5 on loongarch) and have
bpf_arch_text_poke() write nops first and the branch in the last slot, or l=
et
the JIT emit a single nop for these near jumps. Any preference from the
riscv/LoongArch JIT folks?

> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -3217,16 +3217,21 @@ static void restore_regs(const struct btf_func_=
model *m, u8 **prog,
> >  }
> > =20
> >  static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
> > +			   struct bpf_tramp_image *im,
> >  			   struct bpf_tramp_node *node, int stack_size,
> >  			   int run_ctx_off, bool save_ret,
> >  			   void *image, void *rw_image)
> >  {
> >  	u8 *prog =3D *pprog;
> > -	u8 *jmp_insn;
> > +	u8 *jmp_insn, *skip;
> >  	int ctx_cookie_off =3D offsetof(struct bpf_tramp_run_ctx, bpf_cookie)=
;
> >  	struct bpf_prog *p =3D node->link->prog;
> >  	u64 cookie =3D node->cookie;
> > =20
> > +	/* nop, patched to skip this prog when it is detached */
> > +	skip =3D image + (prog - (u8 *)rw_image);
> > +	emit_nops(&prog, X86_PATCH_SIZE);
> > +
> >  	/* mov rdi, cookie */
> >  	emit_mov_imm64(&prog, BPF_REG_1, (long) cookie >> 32, (u32) (long) co=
okie);
>
> [Severity: High]
> This is a pre-existing issue, but similar to the ARM64 code above, does t=
his
> leave the same use-after-free window between the new skip NOP and the=20
> __bpf_prog_enter() setup?
>
> If a task executes the NOP but is preempted on a CONFIG_PREEMPT=3Dy kerne=
l=20
> before __bpf_prog_enter() acquires RCU protection, the detached program m=
ight=20
> be freed while the task is asleep. When the task wakes up, it would then =
jump
> into a freed bpf_prog structure.

Same as first paragraph.
