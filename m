Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792987780;
	b=x221XsnigePLuJAXzKRVPaca+NvNlwt/u3elNY3zoYC0Xc9t7vFzgx1Ycz9OQZJK9TjU
	 8ruwJN8aYO4byFLbQIWFBTcR/oqQRz3GNboDWzHBKnU5CGJNlA7vUX9d7EnTOlefqsBnP
	 R+5yw7o/VMnWPBr3hsdGd2pqw6IASN7s5u2ewdUpMMVWC55ncORnXWU2/ouGgIJPkE7KL
	 XNjQ5ho+940chYqijdOLq9DFN2sd1+A8FG3lRdgjyf8FSstY49mbzL1OJkjwKWYWW0qyE
	 8c+VotY6jDHasIdGHipgd3ULZFz/y2GBs26PHFohdpXeR7vWQ1JFli0ZTxFMg53J6uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792987780;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=J2MW5fC9qxuSivJEI0W6lVciP30z4TZslZ/Qi4tvq3A=;
	b=DHMgU24PyFop6IZ2tGRf3tGozErjWNA+situUo/QXGEiZAk9Kg6RoSFcd8IdGqev7819
	 PBr6FhN64myJH+VfBK8MyGhEt9JE2xuAX/Y0v99YBhVfZEK2uKdc4OjU7UmCvnJos1ibf
	 iaTa2ZOAn8PKh+DW+6hlYvOUEAE0spU36H8uOsBIQkX2rqx9bi6+40/UI+BtKpFKY3NFd
	 obyr56vefLXXCtmKakqAPq1f0vZ/YzqEroRiumMxPN4K8QfzsFqXiDaqpoLeNUCw0jC7r
	 KJzWrRYa7cWKy0fMCPK6n9/Cxqs1/m7/LK8XVhajiBWP/nE17piUuuagUu+N/KbkZdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFPXFLzg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8440C606A31B
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 04:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFPXFLzg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76151F01825;
	Mon, 26 Oct 2026 04:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792987780;
	bh=J2MW5fC9qxuSivJEI0W6lVciP30z4TZslZ/Qi4tvq3A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mFPXFLzge3vVIB2gsKrUatZDgVKSHu4gPxcbc+PoKDVGp3PeZ6grKW1HozIkroyEp
	 /e5NECNH/nOyZhVUW1x6ROnWe+V16kXyx14KkjIJMNXg59r4GkM1hEM3q2TATPrxjv
	 NuyCdvuwvZFx2T/YGyGSxxtX6bIB3Re0eLenNaqYJJQcUOtGPMhHqg93GOiIYLnKuV
	 rM2u7oFrcTKRL3FXpoRmmeT7zeJcke0TNj65A6DIKkSzzbaaLHKpgLx9jfrODa6b6k
	 ZfS4SJcRtM4zEx//IiOmRTZ9D76y6j8yk8f2CqyuaI6JoaiwxXi7aoKI9vHDf0xnsF
	 DKkqDvLilK/8w==
Content-Type: multipart/mixed; boundary="===============4886789133155798941=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <87cbe06518075eddad931b5ac71cc5e60d4949b79d719df0383516bf63994506@mail.kernel.org>
In-Reply-To: <20261026025943.404450-52-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-52-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 51/81] bpf: Check stack and count calls of recursive subprogs at run time
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 04:09:39 +0000 (UTC)

--===============4886789133155798941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Check stack and count calls of recursive subprogs at run time

TL;DR:
- Nested run may reset the call budget, so recursion may never stop: possible
  RCU stall or soft lockup
- Frame size estimate may be too small, so the stack limit may be exceeded
- Possible misaligned 8-byte store; may_goto comment unclear

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index bb0aeda9f9cc..19d8191053b9 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> @@ -3640,6 +3641,32 @@ static noinline void bpf_prog_report_may_goto_violation(void)
>  #endif
>  }
>
> +/* Called by a recursive subprog that is out of budget, see bpf_insert_recursion_checks() */
> +u64 bpf_prog_report_recursion(void)
> +{

[ ... ]

> +	/* the loops of the run come to an end as well */
> +	if (prog->aux->may_goto_budget)
> +		this_cpu_write(prog->aux->may_goto_budget->count, 0);

This isn't a bug, but does this end the loops of the run as the comment and
the commit message say ("It ends the 250 ms of may_goto for this run, thus
the loops of the run exit too")?

The code only sets run->count to 0 and leaves run->start alone, so the time
slice of the run does not end.  Only frames entered after the report copy
count == 0 into their may_goto slot.  Frames that are already on the stack
keep their own counts and go on looping.

When one of those reaches 1 -> 0, it calls bpf_check_timed_may_goto().  If
250 ms have not passed yet, that function does:

	if (run)
		run->count = BPF_MAX_TIMED_LOOPS;
	return BPF_MAX_TIMED_LOOPS;

which puts the shared count back, and frames entered later loop normally
again.

For example, if the main prog has a may_goto loop that calls a recursive
subprog that runs out of budget, the loop still runs to the end of its
250 ms slice, and only the bail of each call gets cheaper.

Nothing becomes unsafe, since every frame is still bounded by its own
slice.  Should this also make bpf_check_timed_may_goto() see that the time
is up, for example through run->start, or should the comment and the commit
message be reworded?

[ ... ]

> @@ -3677,6 +3704,10 @@ void bpf_prog_begin_run(const struct bpf_prog *prog)
>  		this_cpu_write(aux->may_goto_budget->start, 0);
>  		this_cpu_write(aux->may_goto_budget->count, BPF_MAX_TIMED_LOOPS);
>  	}
> +	if (aux->call_depth) {
> +		this_cpu_write(aux->call_depth->calls, 0);
> +		this_cpu_write(aux->call_depth->reported, 0);
> +	}
>  }

Can a nested run of the same prog give the interrupted run a fresh call
budget?  bpf_prog_begin_run() clears calls and reported without checking
whether another run of the prog is already in progress on this cpu.  The
main prog does the same in its first insns, through the
BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0) that bpf_insert_recursion_checks() adds.

The comment above bpf_insert_recursion_checks() says:

 * Another run of the program on the same cpu, in interrupt or after
 * preemption, counts in the same counter. Then there is less for both.

That holds for depth, which is never reset.  For calls, the nested run sets
the counter back to 0, so the interrupted run gets more budget, not less.

For example, prog P recurses in process context, and a pinned bpf_timer of P
(BPF_F_TIMER_CPU_PIN) re-arms itself every millisecond:

bpf_timer_cb()
  bpf_prog_begin_run(t->cb.prog)
    this_cpu_write(aux->call_depth->calls, 0)

The interrupted run of P continues with a full BPF_MAX_LOOPS on every
expiry.  A second run that preempts a sleepable prog on the same cpu does
the same through the inline store at the main prog entry.  The same prog
can also nest on one cpu as a struct_ops, LSM or SYSCALL prog, or as a
networking prog that runs in process context with BH enabled.

The commit message says "a subprog that calls itself two times can run for
a very long time at a small depth".  With f() { f(); f(); } and 16 byte
frames, the depth budget allows 256 levels, which is about 2^256 calls.  If
a run of the same prog starts on that cpu more often than every
BPF_MAX_LOOPS calls (8M calls at about 2.7 nsec each is about 20 ms), the
outer run never runs out of calls.  It holds rcu_read_lock() and
migrate_disable() the whole time, which leads to an RCU stall or soft lockup
for a non-sleepable prog, and an unkillable busy task for a sleepable one.

The nested run also clears reported, so the interrupted run reports again.

may_goto has the same reset in bpf_prog_begin_run(), but
bpf_check_timed_may_goto() still applies the timestamp of each frame.  The
recursion budget has no such fallback.

Subprogs are first marked recursive by 0535bc235aed ("bpf: Verify programs
as a fixpoint over the control flow graph") later in this series.  Neither
this reset nor the one at the main prog entry is changed through the end of
the series.

Should calls be reset only when no recursive frames of this prog are on the
cpu (depth == 0), or should a nested run share what the interrupted run has
left?

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 937274c164e8..4a0b55c5fe35 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> @@ -647,6 +647,268 @@ static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta)
>  	return 0;
>  }
>
> +/*
> + * The room that the frame of a subprog takes besides its stack: what JIT saves at most.

[ ... ]

> +static u32 recursive_frame_size(struct bpf_verifier_env *env, int s)
> +{
> +	struct bpf_subprog_info *sub = &env->subprog_info[s];
> +	struct bpf_insn *insn = env->prog->insnsi;
> +	u32 size, used = 0, may_goto = 0, cb = sub->is_cb ? BPF_CALLBACK_OVERHEAD : 0;
> +	int i;

[ ... ]

> +	for (i = sub->start; i < (sub + 1)->start; i++) {
> +		if (insn[i].dst_reg >= BPF_REG_6 && insn[i].dst_reg <= BPF_REG_9)
> +			used |= BIT(insn[i].dst_reg);
> +		if (insn[i].src_reg >= BPF_REG_6 && insn[i].src_reg <= BPF_REG_9)
> +			used |= BIT(insn[i].src_reg);
> +		if (bpf_is_may_goto_insn(&insn[i]))
> +			may_goto = 16;
> +	}
> +	/* the return address, rbp, the registers that are saved */
> +	size = 16 + hweight32(used) * 8;

Is this an upper bound of the frame that the JIT builds on x86-64, as the
commit message requires ("recursive_frame_size() must be an upper bound of
the frame that the JIT makes")?

The function counts R6-R9 from the insns as they are when
bpf_insert_recursion_checks() runs, and reads stack_depth at that time.
The weight is fixed into si[s].recursion_weight and is not computed again.
bpf_check() calls it before the passes that can still make the frame
larger:

	/* after what makes frames larger: inlined bpf_loop() takes 3 slots and 3 registers */
	if (ret == 0)
		ret = bpf_insert_recursion_checks(env);
	...
	if (ret == 0)
		/* program is valid, convert *(u32*)(ctx + off) accesses */
		ret = bpf_convert_ctx_accesses(env);

The x86 JIT's detect_reg_usage() scans the final insns, and
push_callee_regs() pushes every callee-saved register that it finds.  Later
passes add registers and stack:

- bpf_convert_ctx_accesses() picks temporaries starting at BPF_REG_9 (then
  R8, R7) when dst_reg == src_reg.  Examples are SOCK_OPS_GET_FIELD in
  sock_ops_convert_ctx_access(), bpf_convert_data_end_access() for SK_SKB,
  SOCK_ADDR_STORE_NESTED_FIELD_OFF for sock_addr, and the treg = BPF_REG_9
  conversions for cgroup sysctl and sockopt.

- insert_arena_stack_get() for an arena_stack_entry callback sets
  sub->stack_depth = spill + MAX_BPF_FUNC_REG_ARGS * BPF_REG_SIZE (40 more
  bytes).  It also uses R6/R7/R8, and the arena exit path uses R6.

For example, a recursive static subprog that uses no R6-R9 and no stack has
an estimated frame of 16 bytes, so a weight of 256 and 256 frames for 65536
units.  If ctx conversion adds R9, each frame is really 24 bytes, so the
recursion uses 6144 bytes instead of the 4096 that BPF_RECURSION_STACK
promises.  The check never reads the stack pointer, so nothing else limits
this.

The call site comment "after what makes frames larger" is not accurate
either.  mark_recursive_subprogs() in 0535bc235aed does not exclude these
prog types, and at the end of the series bpf_insert_recursion_checks() is
still called before bpf_convert_ctx_accesses() and bpf_insert_arena_stack(),
with recursive_frame_size() unchanged.

Could the checks run after bpf_convert_ctx_accesses() (they insert no helper
calls, so they could go before bpf_do_misc_fixups(), with the may_goto bytes
already counted in stack_depth), or could recursive_frame_size() always
count all of R6-R9 on x86-64?

[ ... ]

> +	/*
> +	 * The calls are counted anew when a run begins. For async callbacks see
> +	 * bpf_prog_begin_run(). R0 has nothing at the entry.
> +	 */
> +	memcpy(buf, (struct bpf_insn[]){ BPF_LD_IMM64(BPF_REG_0, (long)depth) },
> +	       2 * sizeof(buf[0]));
> +	buf[2] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
> +	/* calls and reported */
> +	buf[3] = BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0);

Is this 8-byte store guaranteed to be 8-byte aligned?  struct
bpf_recursion_budget has three u32 members, so alloc_percpu_gfp() asks for
4-byte alignment, and pcpu_alloc() keeps it because PCPU_MIN_ALLOC_SIZE is
4.  The per-cpu address can then be 4 mod 8, and this becomes a misaligned
64-bit store on every run of the prog.

Some JITs that bpf_jit_supports_percpu_insn() allows have no
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS: riscv64 in its default
configuration, and loongarch with the default ARCH_STRICT_ALIGN=y.  On those
arches the verifier sets env->strict_alignment and would reject such an
access from a program, but here the kernel inserts the access itself.  It
traps and is emulated on every run, and on loongarch do_ale() calls
die_if_kernel() when unaligned emulation is disabled.

Would __aligned(8) on struct bpf_recursion_budget, or two BPF_W stores, be
better?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============4886789133155798941==--
