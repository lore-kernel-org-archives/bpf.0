Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986817;
	b=CSgfMCf7p8RVtI5XNCHJA7eq07FNVH0RIVloxK77VUrN2VjbjWMwXFUskKK9HA9i8jkA
	 vATkpwRUNhx9isZgevo1utyq6U/W/JWbImLDbU+4oTKhisvkhsCfGlOEZrtHf/5HAKXyY
	 xVcRz2IYZIw4mXkfd/LyUm19AXjOUooLqv6EMEv+Hiw5XkJ/3C5ss3KhAZfxpMmNgCyZ4
	 Zk+YHnRXxiVzNstrxfxMmY/r/qQX+liMHDrI0+a5TSJT8UWfgh4FAo4BytTtUyUqSt1PT
	 LD6yNF4OB9bagfriN7SrZuscyfwSHesrmm7q8JyuwMk+BipXJM6HyYCqvjiBBl1PuyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986817;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=sT/VwNX6vzlk57rRtc6M6DV45JCs5BdrEJd6M5vrkPU=;
	b=fVF0Cu1ODeYdtku4LTiEIQySBEFNXDvfA7OedRZsFpq1AWc5gZBHCqwtjGxag0H1WeQY
	 KdxdrWop9hlD3frf86Uajf++M/CpdNOQAS9PE7JCCjW5a9HE0yRPJynHt3ntpWdd+clcL
	 YM4q+VU8KsV1nobhJjwgCkVE3kQV1don28Ttw/+IMbN3LCGYTV9moRqdG1qLoDkAl6Ct1
	 XaTLR93FxR9MCt/oGwScgFSeRkhnjTm9qTwdVr0DNxUczbs6+YEQo2w3LHkPnmL+dYGob
	 DgmdjMpGdOwT11dVFLFUlE5TR8J3r5vvmu8cqtErcFwOEePBAZLCugdoyZ3apMzlIkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GBk6kpZH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B67606A31B
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GBk6kpZH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920BD1F01825;
	Mon, 26 Oct 2026 03:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986816;
	bh=sT/VwNX6vzlk57rRtc6M6DV45JCs5BdrEJd6M5vrkPU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GBk6kpZHjr29JAcvJkMPMZaGYVVCg1T1TUooJxetdJzopF4Grs0UiqyvdJLIXD8K0
	 nckVpi1oIvHC2NAJezPfGQociX2nKUQ1TYFAVgh5NWIbBqq2ybgsIm+AulLQcupawL
	 Kd5Hj9fs7CYDVaOMOKClvWzFXyOwIqXeN4xkIcio2RonYrqzFa7RXpyFINl9InBLu5
	 HSoIebBqHq5dRYECJIazPYl3//ztJECotEFGfA4dyKOvfUfT8EyfvYzSUD4I0//5L5
	 DhYcUJdz19a/XHVqBdE/AoIlpRjzTJUzDStQqiFBuE9mThIznLZhQEntNJ0wPs6BBq
	 62A7tJhxbBowQ==
Content-Type: multipart/mixed; boundary="===============5834216013433517412=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <4cb2464229b1698c5115bbfa785e78f4b9d4b83bfc0270e7add3a85c2dc2c995@mail.kernel.org>
In-Reply-To: <20261026025943.404450-44-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-44-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 43/81] bpf: Tell user space that a run of a prog was cut short
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:53:36 +0000 (UTC)

--===============5834216013433517412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Tell user space that a run of a prog was cut short

TL;DR:
- Possible build failure with CONFIG_BPF_JIT=y and BPF_SYSCALL=n:
  bpf_prog_report_unwound lacks a prototype
- The unwound bit may stay unset on x86 without ORC unwinder
- Unwinds in exception callbacks and epilogue-generated progs may go
  unreported

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> @@ -3463,6 +3464,7 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
>  void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
>  void bpf_prog_report_arena_violation(bool write, unsigned long addr, unsigned long fault_ip);
>  void bpf_prog_begin_run(const struct bpf_prog *prog);
> +u64 bpf_prog_report_unwound(u64 ret);

This prototype sits inside the large '#ifdef CONFIG_BPF_SYSCALL' block, and
there is no stub in the '#else /* !CONFIG_BPF_SYSCALL */' branch.  Both JITs
call the function unconditionally:

  arch/x86/net/bpf_jit_comp.c:bpf_unwind_target()
    return e ? ret_addr + e->fixup : bpf_prog_report_unwound(ret_addr);

  arch/arm64/net/bpf_jit_comp.c:bpf_unwind_fixup()
    return e ? e->fixup : bpf_prog_report_unwound(0);

Those files are built for CONFIG_BPF_JIT, which does not depend on
CONFIG_BPF_SYSCALL.  Doesn't an x86_64 or arm64 config with CONFIG_NET=y,
CONFIG_BPF_JIT=y and CONFIG_BPF_SYSCALL=n (cBPF JIT only) now fail with
'implicit declaration of function bpf_prog_report_unwound'?

kernel/bpf/core.c is obj-y and defines the function unconditionally, so with
CONFIG_BPF_SYSCALL=n it also has no prototype in scope, which
-Wmissing-prototypes would flag.

A static inline stub in the #else branch would clash with that definition.
Should the prototype move outside the CONFIG_BPF_SYSCALL block, for example
next to bpf_jit_bypass_spec_v4()?

I don't see a later patch in the series that changes this.

[ ... ]

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> @@ -3639,6 +3640,28 @@ static noinline void bpf_prog_report_may_goto_violation(void)
>  #endif
>  }
>
> +/*
> + * Nothing caught the unwinding. The prog or the async callback returns to the kernel.
> + * There is no return value that is right for every hook, so what to do about it is up
> + * to user space. Returns @ret: the caller has its return value there.
> + */
> +u64 bpf_prog_report_unwound(u64 ret)
> +{
> +#ifdef CONFIG_BPF_SYSCALL
> +	struct bpf_stream_stage ss;
> +	struct bpf_prog *prog;
> +
> +	prog = bpf_prog_find_from_stack();
> +	if (!prog)
> +		return ret;
> +	WRITE_ONCE(prog->aux->unwound, true);

Can this early return leave 'unwound' clear on valid x86 configs?

bpf_prog_find_from_stack() relies on arch_bpf_stack_walk(), which on x86 does
nothing unless CONFIG_UNWINDER_ORC is set:

  arch/x86/net/bpf_jit_comp.c:arch_bpf_stack_walk() {
  #if defined(CONFIG_UNWINDER_ORC)
          ...
  #endif
  }

On x86, bpf_jit_supports_unwind() and bpf_jit_supports_timed_may_goto()
return true unconditionally, and check_unwind_insns() only needs
bpf_jit_supports_unwind().  So with CONFIG_UNWINDER_FRAME_POINTER=y, progs
with unwind_exit still load and run, but every report path returns early:
this function for the main prog, the async callback path in
bpf_unwind_target(), and bpf_prog_report_may_goto_violation().
bpf_prog_info.unwound stays 0 and stderr stays empty.

Other users of the stack walk are gated on bpf_jit_supports_exceptions(),
which is IS_ENABLED(CONFIG_UNWINDER_ORC) on x86.  For example, the timed
may_goto budget setup in bpf_do_misc_fixups() checks it:

  if (!subprogs[i].stack_extra || !bpf_jit_supports_timed_may_goto() ||
      !bpf_jit_supports_percpu_insn() || !bpf_jit_supports_exceptions() ||
      ...

For the main prog the verifier already knows which prog it is.
bpf_insert_arena_stack() passes aux directly with
BPF_LD_IMM64(BPF_REG_1, (long)aux).  Could the main prog report do the same
and avoid the stack walk?

> +	bpf_stream_stage(ss, prog, BPF_STDERR, ({
> +		bpf_stream_printk(ss, "ERROR: The program was unwound\n");
> +	}));
> +#endif
> +	return ret;
> +}

[ ... ]

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> +/*
> + * Say so when the main prog unwinds. JITs make exit of that, see bpf_prog_can_unwind().
> + * It's done after bpf_do_misc_fixups(), that takes a call for a call of a helper.
> + */
> +int bpf_insert_unwound_reports(struct bpf_verifier_env *env)
> +{
> +	struct bpf_prog *new_prog;
> +	struct bpf_insn buf[3];
> +	int i;
> +
> +	if (env->prog->type == BPF_PROG_TYPE_EXT)
> +		return 0;
> +	for (i = 0; i < env->subprog_info[1].start; i++) {

Is an unwind_exit in an exception callback left unreported here?

The exception callback is subprog >= 1, so this loop over the range up to
subprog_info[1].start never looks at it.  The JITs don't report it either:
bpf_prog_can_unwind() returns false when aux->exception_cb is set, so x86
do_jit() and arm64 build_insn() emit a plain exit and bpf_unwind_target() /
bpf_unwind_fixup() never run.

The verifier accepts unwind_exit there, since it is checked at frame 0
through process_bpf_exit_full() -> check_return_code() with no
unwind-specific restriction.  bpf_throw() calls aux->bpf_exception_cb(), and
as the comment on bpf_prog_can_unwind() says, 'An exception callback returns
from the frame of the main prog'.  So nothing can catch that unwind_exit,
which is the same situation as for the main prog.

The commit message says 'The kernel sets the bit when a run is cut short'
and lists only the main prog and async callbacks.  With a panic in an
exception callback, the hook gets an arbitrary r0, bpf_prog_info.unwound
stays 0, and stderr is empty.  Should this case be covered, or called out in
the commit message?

> +		if (!bpf_is_unwind_exit(&env->prog->insnsi[i]))
> +			continue;

Can this test miss the main prog's unwind_exit when an epilogue is
generated?

This runs after bpf_convert_ctx_accesses(), and that pass can already have
replaced the main prog's exit insns, unwind_exit included, with a generated
epilogue.  The check there looks only at the code, not src_reg:

  kernel/bpf/fixups.c:bpf_convert_ctx_accesses() {
      } else if (insn->code == (BPF_JMP | BPF_EXIT) &&
                 epilogue_cnt &&
                 i + delta < subprogs[1].start) {
              /* Generate epilogue for the main prog */
              ...
              memcpy(insn_buf, epilogue_buf,
                     epilogue_cnt * sizeof(*epilogue_buf));

For a later exit it emits only a BPF_JMP32_A back to the first epilogue.
The epilogue from bpf_qdisc_gen_epilogue() (net/sched/bpf_qdisc.c), used for
the Qdisc_ops reset and destroy progs, ends with BPF_EXIT_INSN(), so its
src_reg is 0 and bpf_is_unwind_exit() is false.  bpf_testmod's
st_ops_gen_epilogue behaves the same way.

The verifier accepts unwind_exit in those progs, since check_unwind_insns()
has no prog-type limit and void return values are not checked.  In that case
no 'r1 = r0; call bpf_prog_report_unwound' is inserted, so a run that
unwinds to the kernel never sets bpf_prog_info.unwound and prints nothing to
stderr.  The commit message says 'unwind_exit in the main prog: a call that
the verifier adds before it', so is this case expected to be covered?

> +		buf[0] = BPF_MOV64_REG(BPF_REG_1, BPF_REG_0);
> +		buf[1] = BPF_EMIT_CALL(bpf_prog_report_unwound);
> +		buf[2] = env->prog->insnsi[i];

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============5834216013433517412==--
