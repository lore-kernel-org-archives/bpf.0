Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75B33DDB16
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389619; cv=none; b=LM9QGBqPPy/zNbWdFQwyt0TDYUqJYO7hnc17n3jaEdzF/rHnLT2Utn6n7LasJVMcqaHuU6nXp9r0K/xBAEABveiJr359FOXuRbNBWpmff1YDNeTUfc9QIFXfh1XkgLix5fOWQvrdm9R/ABiv4Hsq1TgkTMafgH2m5DAoGGBfEZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389619; c=relaxed/simple;
	bh=kb8OQF9pzdw6I8LUKPXHZwaCks3F/bEHpdkeizVPS28=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=l+r5oIZmDpAqX6HbbH23zcZXImNrs8Jm6+GD7Cil1KPyDDfTL/hEjIE67evXdx2IzQMc6x+wheuQ5YfM5R1XHxiXsrm9RUyVP1WdpmfNzeSMQMLQ6Vim4vpmDJKx8deySXAmk6aeeoGQ31fTzmU35NClw2Cbyc+PgA1Xn2+JU4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wj4hI9zv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wj4hI9zv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A6E1F000C4;
	Mon, 19 Oct 2026 06:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792389612;
	bh=mc3yofjsGmsDjU6vlN/g1BiQL4Mv5JvDJmIT6VPX3zQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Wj4hI9zvNXTei1GOh5GJGz4Q897EwvFTssx1J4os/zQjdyC0rHVyOLz8Ve6VPbAW4
	 eHWQygOzi+6UtqluEx6J5AaugVvFYRHPrFjCwIYB7Rf/92BwagjG0pqHTsacK97Ghw
	 yfnfG/sobRN5/LpgdxFAWvsO6V7ZDxnK5mVBJ+PCOHlwJ745PGJAvG5FaW5WzFkDaF
	 UzgR0kHkH40kcN5xKkalH3xeaznKN9SCg5ofRcTYJQ/xHJFN0bWZaeXSVct0tBndmj
	 zA3bGwQSgSccurSCaCBVkMqmnSs6svGQi0lPz3jwwlFI42u6r6OrRD6myhcr5zpObe
	 MgoRWAZ+USNag==
Content-Type: multipart/mixed; boundary="===============5652773211670720390=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20f3bd6c3cf293219b93c37bb50829f73843ea0ca9a2611bd0fc83289f9c7957@mail.kernel.org>
In-Reply-To: <20261019051846.3012089-5-alexei.starovoitov@gmail.com>
References: <20261019051846.3012089-5-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/5] selftests/bpf: Add tests for unwind_goto and unwind_exit
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 19 Oct 2026 06:00:11 +0000 (UTC)

--===============5652773211670720390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add tests for unwind_goto and unwind_exit

TL;DR:
- Two selftests may not test what they claim: callee_never_returns and
  no_pruning_after_the_call can pass without the checks they target
- private_stack_unwinds __jited() patterns may fail with call depth accounting
  on x86-64

> diff --git a/tools/testing/selftests/bpf/progs/verifier_unwind.c b/tools/testing/selftests/bpf/progs/verifier_unwind.c
> new file mode 100644
> index 000000000000..a235c6143e10
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_unwind.c
> @@ -0,0 +1,1047 @@

[ ... ]

> +/* What follows unwind_goto is dead code. unwind_exit still has to find the pad. */
> +SEC("tc")
> +__description("unwind: the callee never returns")
> +__arch_x86_64
> +__arch_arm64
> +__load_if_JITed()
> +__success __retval(42)
> +__naked int callee_never_returns(void)
> +{
> +	asm volatile (
> +		"call always_unwinds;"
> +		unwind_goto(2)
> +		"r0 = 1;"
> +		"exit;"
> +		"r0 = 42;"
> +		"exit;"
> +		:
> +		: __imm_unwind_goto(2)
> +		: __clobber_all
> +	);
> +}

The comment says unwind_exit still has to find the pad.  That depends on
the exception added to bpf_opt_hard_wire_dead_code_branches():

    /* unwind_exit of a callee that never exits needs it too */
    if (bpf_is_unwind_goto(insn) && aux_data[i + 1 + insn->off].seen)
        continue;

Can __retval(42) tell whether that exception is present?

Without it, unwind_goto(2) would become 'ja +2', because the fall-through
insn was never seen.  bpf_opt_remove_dead_code() would then drop the dead
insns and bpf_opt_remove_nops() would drop the resulting 'ja +0', leaving
'call; r0 = 42; exit' with no extable entry.

At run time, unwind_exit in always_unwinds calls bpf_unwind_target(), finds
no entry, hits WARN_ON_ONCE(!e) and falls back to ret_addr:

    if (WARN_ON_ONCE(!e))
        return ret_addr;

After dead code removal ret_addr is the pad ('r0 = 42'), so the prog still
returns 42 and the test passes.  The only sign of the problem is a warning
splat, which test_progs does not check for.

callee_never_unwinds below already uses __xlated() to pin the opposite
case, where the pad goes away together with unwind_goto.  Would something
like __xlated("1: unwind_goto pc+0") here show that unwind_goto stays when
only the fall-through is dead?

[ ... ]

> +/*
> + * After the call the two states differ only in the way the callee left.
> + * The second one must not be pruned, or nobody looks at the pad.
> + */
> +SEC("tc")
> +__description("unwind: the way the callee left is a part of the state")
> +__arch_x86_64
> +__arch_arm64
> +__load_if_JITed()
> +__failure __msg("R0 invalid mem access 'scalar'")
> +__naked int no_pruning_after_the_call(void)
> +{
> +	asm volatile (
> +		"r1 = *(u32 *)(r1 + %[len]);"
> +		"call same_regs;"
> +		unwind_goto(1)
> +		"exit;"
> +		"r0 = *(u64 *)(r0 + 0);"
> +		"exit;"
> +		:
> +		: __imm_const(len, offsetof(struct __sk_buff, len)),
> +		  __imm_unwind_goto(1)
> +		: __clobber_all
> +	);
> +}

Does this test exercise the new check in states_equal()?

    if (old->unwound != cur->unwound)
        return false;

It looks like it passes the same way with or without that check, because
the verifier never saves a checkpoint at the insn after the call in this
program.

unwind_goto is a prune point, but not a force checkpoint.  visit_insn()
only calls mark_force_checkpoint() for may_goto:

    mark_prune_point(env, t);
    if (bpf_is_may_goto_insn(insn))
        mark_force_checkpoint(env, t);

Without a force checkpoint, bpf_is_state_visited() only adds a new state
after at least 2 jumps and 8 insns since the last checkpoint:

    add_new_state = force_new_state;
    if (env->jmps_processed - env->prev_jmps_processed >= 2 &&
        env->insn_processed - env->prev_insn_processed >= 8)
        add_new_state = true;

With same_regs added by libbpf, the program is:

    0: r1 = *(u32 *)(r1 + len)
    1: call same_regs
    2: unwind_goto +1
    3: exit
    4: r0 = *(u64 *)(r0 + 0)
    5: exit
    6: r0 = 0               (same_regs)
    7: if r1 != 0 goto +1
    8: exit
    9: unwind_exit

check_cond_jmp_op() pushes the taken branch (insn 9) and continues with the
fall-through, so the first path reaches insn 2 after only 6 processed insns
(0, 1, 6, 7, 8, 2).  That is below 8, so no state is saved at insn 2, and
nothing before it saved one either.

When the unwound path comes back from insn 9 to insn 2, the explored state
list for insn 2 is empty.  Nothing can prune that path, so the verifier
always walks into the pad and reports "R0 invalid mem access 'scalar'".

If the unwound check were removed from states_equal(), would this test
still pass?  Today only pad_does_not_unlock would catch that, and only
because its first path happens to reach 8 insns before unwind_goto.

test_loader's default flags from testing_prog_flags() are
BPF_F_TEST_RND_HI32 and BPF_F_TEST_REG_INVARIANTS, not
BPF_F_TEST_STATE_FREQ.  The callx pruning tests in verifier_callx.c add
__flag(BPF_F_TEST_STATE_FREQ) for this reason.  Would adding the same flag
here save a state at insn 2 on the first path, so that a kernel without the
states_equal() check prunes the second path and the test fails as intended?

[ ... ]

> +/*
> + * x86-64 keeps the pointer to the private stack in r9 and saves it around a call.
> + * The value that is read back in the pad is there only when r9 is restored.
> + */
> +SEC("raw_tp")
> +__description("unwind: private stack, the callee unwinds")
> +__success __retval(47)
> +__load_if_JITed()
> +__arch_x86_64
> +__jited("	pushq	%r9")
> +__jited("	callq	0x{{.*}}")
> +__jited("	popq	%r9")
> +__jited("	jmp	L{{.*}}")
> +__jited("	popq	%r9")
> +__jited("	jmp	L{{.*}}")
> +__arch_arm64
> +__naked int private_stack_unwinds(void)

Can the x86-64 __jited() expectations fail on hosts that use call depth
accounting?

They require callq to be on the line right after pushq %r9.  In do_jit()
the BPF_CALL case emits push_r9(), then x86_call_depth_emit_accounting(),
then emit_call():

    if (priv_frame_ptr) {
        push_r9(&prog);
        ip += 2;
    }
    ip += x86_call_depth_emit_accounting(&prog, func, ip);
    if (emit_call(&prog, func, ip))

With CONFIG_MITIGATION_CALL_DEPTH_TRACKING=y and retbleed=stuff
(thunks_initialized), x86_call_depth_emit_accounting() adds a 'sarq $0x5,
%gs:...' instruction before calls to a BPF subprog.  A JITed subprog like
may_unwind_big_stack has no call thunk in its padding, so is_callthunk()
returns false and the accounting is emitted.

The disassembly then reads 'pushq %r9; sarq ...; callq ...', and
validate_msgs() reports a line mismatch for the callq pattern, so this
subtest fails on retbleed-affected machines such as Skylake booted with
retbleed=stuff.  The kernel itself is fine there.

Commit bf29346fc393 ("selftests/bpf: ignore call depth accounting for
retbleed in verifier tests") fixed the same pattern in
verifier_private_stack.c by putting __jited("...") between "pushq %r9" and
"callq".  Should this test do the same?

    __jited("\tpushq\t%r9")
    __jited("...")
    __jited("\tcallq\t0x{{.*}}")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39205301464
--===============5652773211670720390==--
