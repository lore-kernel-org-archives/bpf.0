Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CCC48D87C
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865084; cv=none; b=fAF+K4PT9o/mnDkVprcVWb7tSOZJTWHxCqVDPB2S5mfBqRBoF40QdmCgDQZ24/b7zDvrXPGPG74/fUlOh0SlAyLgFIk4717gQO+WoVG6qrEzMbD8EQZAtoMYkXyBWHC2iCWg4DfnE1PHQTM79Efmq+o/iFg712O+rwVIvG5PqSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865084; c=relaxed/simple;
	bh=sq+03flbKqfyD3/UvxOKxJ/szGwJALSd/SzzwbY/Ziw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=s6Z9XvPUPc5bj86Lz55qKaLelYBupmCPF/5txopsWsheSQPkil1NJ+lv/vtm2TdtKNROX6BB0W5pTHFPyWHdpzlgh87P0h4yTq/OI6Kwpw7YFEL5SexE77MebnYrjJ92tupFqZR0Z3jd+T2K9Opg3AS2sznSbh0qclB2VUTXtKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXX9haa4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXX9haa4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BFB1F0089A;
	Thu,  1 Oct 2026 14:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790865080;
	bh=WYp0ZWoBDbwZgwvfWo97DlXQmT5qjMPCMSDz1Plrtdk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iXX9haa4dkrkhZWx4KbWgDWMj5iyw9gt/VqYEnJFabbZ1oKjxubIrgieLNZxBTxZU
	 hJFB7UlEW8m0YWP/NLz3NZiMPjeiLk1AZclriu9gxDlsqA6z22JG/D6ALaEJPo+1jP
	 lwNst0+ZH8uDkd4TxPcFyczPg43FK70P8SgsNCS2P5hyse6qkFRN/51CoqqppeaYwu
	 Jjx5ogCFOG6yPyGJb12mQFO1qqcL25nqxJ1VptkqErGqRRcim3F40X5h0cVbsRhcZ/
	 lL6QqrT1kEkNrhF9wb6nT9nbkrZNApchmS/xJfHbhShCNqbRFrO8ovL6HGE0djenaS
	 1oLt2Jkg3PwQg==
Content-Type: multipart/mixed; boundary="===============4050248945728442819=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <344ff8ec93e6d083a2e73cf866699be96593f5c7d7e46b704f7dc2d69e76cf48@mail.kernel.org>
In-Reply-To: <20261001133042.1339539-1-yonghong.song@linux.dev>
References: <20261001133042.1339539-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v8 07/22] bpf: Follow an unwind to its landing pad in the verifier
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  1 Oct 2026 14:31:19 +0000 (UTC)

--===============4050248945728442819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Follow an unwind to its landing pad in the verifier

TL;DR:
- Global call that unwinds without a landing pad may hit a verifier bug
  warning in backtrack_insn() on fentry/cgroup_skb programs
- bpf_unwind() skips no_stack_arg_load, so a stale R9 arg-6 load may pass
  verification

> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
> index 0e38b9575328..f5504334df90 100644
> --- a/kernel/bpf/backtrack.c
> +++ b/kernel/bpf/backtrack.c

[ ... ]

> @@ -434,6 +458,24 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>  					return -EFAULT;
>  			}
>
> +			if (bpf_exc_pad_of_call(env, idx) == subseq_idx) {
> +				/*
> +				 * We came from the landing pad of a call to a
> +				 * global subprog, branched to from the state
> +				 * the call returns in: as on its return, no
> +				 * frame was entered here. The call clobbered
> +				 * r0-r5; r6-r9 and the stack are the caller's
> +				 * own and keep going back from here.
> +				 */
> +				bt_clear_reg(bt, BPF_REG_0);
> +				if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
> +					verifier_bug(env, "landing pad unexpected regs %x",
> +						     bt_reg_mask(bt));
> +					return -EFAULT;
> +				}
> +				return 0;
> +			}
> +
>  			/* callx calls static subprogs only */
>  			if (subprog >= 0 && bpf_subprog_is_global(env, subprog)) {
>  				/* check that jump history doesn't have any

Can the existing idx + 1 != subseq_idx check in this global branch now fire
for a global call that unwinds with no landing pad?

    verifier_bug_if(idx + 1 != subseq_idx, env,
                    "extra insn from subprog");

In that case unwind_out_of_global_call() takes the pad < 0 path into
unwind_frames(), and when unwind_frames() reaches the main frame it pushes a
history entry with no flags:

    env->prev_insn_idx = env->insn_idx;
    env->insn_idx = state->insn_idx;
    err = bpf_push_jmp_history(env, state, 0, 0, 0, NULL, 0);
    ...
    return process_bpf_exit_full(env, do_print_state, false);

The entry's prev_idx is the global call insn, so INSN_F_UNWIND is not set.
For program types where return_retval_range() returns true (fentry/fexit,
cgroup_skb, struct_ops), process_bpf_exit_full() -> check_return_code() calls
mark_chain_precision(env, BPF_REG_0).

The backtrack then reaches backtrack_insn() with idx at the global call and
subseq_idx at either the same insn (call in main) or the call site in main
(static frames popped first).  The INSN_F_UNWIND branch does not match, the
bpf_exc_pad_of_call() == subseq_idx branch does not match because no pad
covers the call, and the walk lands in the global branch above, where
idx + 1 != subseq_idx is true.

The result is a WARN_ONCE() (a panic with panic_on_warn) and a "verifier bug"
message in the log, although the program is still accepted.  An example is an
fentry or cgroup_skb program calling a global subprog that calls
bpf_unwind() with no record covering the call, or main -> static A -> global
G with no records.

The selftests in the series all use SEC("syscall"), where
return_retval_range() returns false and r0 precision is never requested at
exit, so they would not reach this.  Nothing later in the series touches
backtrack.c.

Should the main-exit history entry get its own flag, or should this global
branch handle that entry before applying the idx + 1 check?

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 80034429fdd0..c7a350be538e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -19380,13 +19520,32 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
>  					return -EINVAL;
>  				}
>  			}
> +			if (bpf_is_unwind_kfunc(insn) || bpf_is_unwind_resume_kfunc(insn)) {
> +				err = check_kfunc_allowed_only(env, insn, env->insn_idx);
> +				if (err)
> +					return err;
> +				if (bpf_is_unwind_kfunc(insn))
> +					return process_bpf_unwind(env, &env->insn_idx,
> +								  do_print_state);
> +				/*
> +				 * The fixups lower this to 'r0 = 0; exit', and
> +				 * the unwind goes on below this frame.
> +				 */
> +				return unwind_frames(env, do_print_state);
> +			}
>  			mark_reg_scratched(env, BPF_REG_0);
>  			if (bpf_in_stack_arg_cnt(&env->subprog_info[cur_func(env)->subprogno]))
>  				cur_func(env)->no_stack_arg_load = true;

Does this early return skip the no_stack_arg_load assignment that every
other call insn gets?

For bpf_unwind() with a pad in the same frame, process_bpf_unwind() goes on
at the pad in the frame that made the call, with no_stack_arg_load still
false:

    clear_caller_saved_regs(env, frame->regs);
    mark_reg_unknown(env, frame->regs, BPF_REG_0);
    *insn_idx = pad;
    return INSN_IDX_UPDATED;

On x86, do_jit() turns a load from BPF_REG_PARAMS at offset 8 (incoming
arg 6) into a read of R9, which is caller-saved and clobbered by any call.
check_stack_arg_read() relies on no_stack_arg_load to reject such a load
after a call.

So in a subprog with more than 5 args, would this sequence pass
verification?

    call bpf_unwind        // record covers it, pad P in this frame
  P:
    r1 = *(u64 *)(r11 + 8) // incoming arg 6
    r2 = *(u64 *)(r1 + 0)

check_stack_arg_read() gives r1 the type of caller->stack_arg_regs[0], which
can be any spilled type, including a pointer such as PTR_TO_MAP_VALUE, but
at run time r1 holds whatever bpf_unwind() left in R9.

Would it work to move the mark_reg_scratched() and no_stack_arg_load lines
above the unwind branch, or to set cur_func(env)->no_stack_arg_load in
process_bpf_unwind() before going on at the pad?

The unwind_out_of_global_call() pad path looks unaffected, since the
PSEUDO_CALL path sets the flag before check_func_call().  do_check_insn()
has the same ordering at the end of the series, where both kfuncs become
callable.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36872142096
--===============4050248945728442819==--
