Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591213932EE
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541601; cv=none; b=YGAhUf7n7hLgGoHzgbBqWl9mzQ8rwHxQjl/aJQyzcxVNCyVud4khpgIrc1FirDToPQd+9Aiev247/hHhq2z5ms0ZkHmTfSbneLzw2ZtCZwrkhUJlbORjx21jqtVkhLumo4FRcsHXwulcLSL7IAiZqyLTAymav92/LxF4VzM+2u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541601; c=relaxed/simple;
	bh=gsH9J6GaRwNJkyfDAqMEK9atzsUMk0gvrCxD25UEMTc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UgxupYGVUYa2P1JwvBVWU4zcYF9O2SjbWUzZWJ+70QfIUoCcPev/NJiHMkZ7C2V1RWlyd163gaE2C0VuHX3V13a73m6RzGB3IUu8CP/y8m3gsctnXkZvvWYNjWABxOGIw67DvzQZOKOTYEuRTDcn8QwHcFrFT98yFln/4rMCB6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nk4YMLYO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nk4YMLYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA241F000FF;
	Sun, 27 Sep 2026 20:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790541599;
	bh=LykCT5LhkiQvM3sd5of96Ix/4cB6ScPSs9S6Rfgp5Ko=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Nk4YMLYOIUkIf6MG7snrU+rc42BaZc1uyZ0jVy+7ZPIuOmKrMdJkwT4H0PaIx2iaI
	 NCx/7gUIgWYbAooOsv6nBdPdJ2iYiPV6i6fUx6Thz2CmjsSGwPnYGPKyu3TFN2wZtW
	 7axDBKjTqDMjR32r35422Uhn06rq/bCS/riHdslNvf+rbTXqVwG12/VB25jK80doXu
	 wEJClYzGfBRw2qK3RKxNEyCVOE25pSZgsO47iccofXnHzqEOXoRKVvhRzwt5HBLkB0
	 tLay48Szhr5akEXxd/fU3XUrVBwxqe8DhWP7ayp3YaBNdJ1tRT5/qRxCzN5AFK3CkZ
	 WQ0r5sC1ijUZw==
Content-Type: multipart/mixed; boundary="===============7312893011573004264=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <699b29ac22154d64cba9488294b7931090b0c50650e99e555f278a1da854647e@mail.kernel.org>
In-Reply-To: <20260926050102.2218021-1-yonghong.song@linux.dev>
References: <20260926050102.2218021-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v6 11/21] bpf, x86: Dispatch exception cleanup pads at run time
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:39:59 +0000 (UTC)

--===============7312893011573004264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git arch/x86/net/bpf_jit_comp.c arch/x86/net/bpf_jit_comp.c
> index 6c7a0578760e..fb7e8ca1aab2 100644
> --- arch/x86/net/bpf_jit_comp.c
> +++ arch/x86/net/bpf_jit_comp.c
> @@ -2150,7 +2150,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  			dst_reg = X86_REG_R9;
>  	}
>
> -	if (bpf_insn_is_indirect_target(env, bpf_prog, i - 1))
> +	if (bpf_insn_is_indirect_target(env, bpf_prog, i - 1) ||
> +	    bpf_exc_insn_is_pad(env, bpf_prog, i - 1))
>  		EMIT_ENDBR();

Landing pads are only ever entered by a ret whose stack slot
bpf_unwind_rewrite() rewrote. Nothing jumps or calls to a pad indirectly
since bpf_unwind_resume() is lowered to 'r0 = 0; exit', and
bpf_exc_check_insn() forbids gotox inside a pad. IBT only checks
indirect JMP/CALL targets, not RET targets, so the ENDBR at each pad
head should not be needed.

The same patch sends pad-less frames to aux->epilogue_ip through the
same kind of rewritten ret, and emits no ENDBR there. That shows the pad
ENDBR does no functional work. Each extra ENDBR in the middle of a JITed
function is one more valid IBT landing site in executable kernel memory,
and the kernel normally keeps those to a minimum (objtool seals unused
ENDBRs).

Is there an indirect-branch path to the pad that is not visible here?

>
>  	ip = image + addrs[i - 1] + (prog - temp);

[ ... ]

> @@ -3278,6 +3279,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  		seen_exit = true;
>  		/* Update cleanup_addr */
>  		ctx->cleanup_addr = proglen;
> +		/* Where an unwind sends a frame with no pad. */
> +		bpf_prog->aux->epilogue_ip = (u64)image + proglen;

Eduard Zingerman raised an optimization suggestion in v5: use register
liveness information at landing pads to avoid spilling all registers
unnecessarily. The suggestion was to use register liveness information
at call sites and collect a union of registers alive at landing pads for
all callers of this particular function.

You acknowledged and said you would try to fix it to avoid saving
unnecessary callee saved registers. However, the current v6
implementation still appears to unconditionally spill registers for
exception_boundary programs without optimizing based on which registers
are actually live at landing pads.

Note: v6 significantly changed the implementation approach from v5, so
this suggestion may need re-evaluation in the context of the new design.
Does this optimization still apply, or does the new design address this
differently?

>  		if (bpf_prog_was_classic(bpf_prog) &&
>  		    !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
>  			if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))

[ ... ]

> @@ -4614,6 +4629,24 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp
>  #endif
>  }
>
> +void arch_bpf_stack_walk_ra(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp, u64 *ra),
> +			    void *cookie)
> +{
> +#if defined(CONFIG_UNWINDER_ORC)
> +	struct unwind_state state;
> +	unsigned long addr, *ra;
> +
> +	for (unwind_start(&state, current, NULL, NULL); !unwind_done(&state);
> +	     unwind_next_frame(&state)) {
> +		addr = unwind_get_return_address(&state);
> +		ra = unwind_get_return_address_ptr(&state);
> +		if (!addr || !ra ||
> +		    !consume_fn(cookie, (u64)addr, (u64)state.sp, (u64)state.bp, (u64 *)ra))
> +			break;
> +	}
> +#endif
> +}

arch_bpf_stack_walk_ra() pairs the unwinder's recovered return address
with the raw stack slot. On x86 ORC, unwind_next_frame() does

arch/x86/kernel/unwind_orc.c:unwind_next_frame() {
    ...
    state->ip = unwind_recover_ret_addr(state, state->ip, (unsigned long *)ip_p);
    ...
}

which turns return_to_handler (function_graph / fprobe exit on fgraph)
or the rethook trampoline (kretprobe) back into the original caller
address. But unwind_get_return_address_ptr() returns `(unsigned long
*)state->sp - 1`, i.e. ip_p itself, and that slot still holds the
tracer's trampoline address. Nothing checks that *ra == addr before
handing ra to the consumer.

bpf_unwind() is a normal __bpf_kfunc in kernel/bpf/helpers.c with no
notrace, so function_graph, kretprobe:bpf_unwind, or a kprobe.multi
return probe can hook its return. In that case the prologue replaces the
slot holding bpf_unwind's return into the BPF program. Then:

  bpf_unwind() -> arch_bpf_stack_walk_ra() -> bpf_unwind_rewrite()
    cnt == 1 frame, and the bpf_unwind call is covered by a cleanup record
    (mark_call_sites() marks bpf_is_unwind_kfunc() calls)
    -> *ra = rec->pad;   /* overwrites return_to_handler / rethook trampoline */

bpf_unwind() then returns straight into the pad and skips the tracer's
return trampoline. Its fgraph ret_stack entry (or rethook node) is left
behind. The next hooked function further up that returns through the
trampoline pops that stale entry.

For fgraph, ftrace_pop_return_trace() has no frame-pointer check on x86
(HAVE_FUNCTION_GRAPH_FP_TEST is not defined there). For rethook,
__rethook_find_ret_addr() picks the top node. Either way execution jumps
to the old BPF address after the bpf_unwind call, running on a different
function's stack, which leads to an oops or arbitrary control flow.

The arm64 version of this same walker, added later in the series
(8bd2af30a28e "bpf, arm64: Dispatch exception cleanup pads at run
time"), handles exactly this case:

arch/arm64/net/bpf_jit_comp.c:arch_bpf_stack_walk_ra() {
    ...
    if (state->flags.fgraph || state->flags.kretprobe)
        return false;
    ...
}

Its changelog says: "a frame whose return the function graph tracer or a
kretprobe has hooked holds the tracer's trampoline in its slot rather
than the address the unwinder reports, so the walk stops there." The x86
walker has no such check, and no later commit in the series touches
arch/x86/net/bpf_jit_comp.c.

Should the x86 version also check state flags or compare
READ_ONCE_NOCHECK(*ra) against the value the unwinder read, and stop the
walk when they differ?

> +
>  void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
>  			       struct bpf_prog *new, struct bpf_prog *old)
>  {


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346422430
--===============7312893011573004264==--
