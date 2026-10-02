Received: from mta0.migadu.com (out-252.mta0.migadu.com [91.218.175.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2FC442392
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790974204; cv=none; b=EFnIOjXxnfP1MgJAbX94vq11m1wcDer5YCKH4rJSSl98t3GRcC0H2rql+IsyZYJlhPFD2MpPIgRozEdd4hGmhghB27um/WQFY5MHqdUmTEy8T7zqV2QWWL2ZVx8XsI/q0DJ1H+1emOwPfR1z0Zqrs1bJdTcwHKpsDjavkXE7JWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790974204; c=relaxed/simple;
	bh=ZPf65Myl2eJmaSuCRmwkjhW/9RhzBR4xVfClE+kcfGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AwD6XUPAVqn9JioYQi1Rnw43QA0Xkhu9CVDiuWCqF9t3hoD93YgNMpj/czO3w5sCBoV5OtrkKpQcouDbHBYIA+09Nznwfpt7Tj2nLnvealzBEx8xnhgNeNstMno73LbpSTApGk6hkyFmzsFMnLexXeC5Z9iqkpUXSGQtnglPJeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y5M7dhlw; arc=none smtp.client-ip=91.218.175.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y5M7dhlw"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZPf65Myl2eJmaSuCRmwkjhW/9RhzBR4xVfClE+kcfGs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790974195; v=1; x=1791578995;
 b=Y5M7dhlw9+16P4rzdCHz0Cv/DZsaeRkLJ7X/0yK6aJe+jVymnhqXiH7Ba1bcnLnHdGUv4kUI
 TU2ghQzTI57/snI2WwBWxXMxKhdd79H02V6NGfudgOVuWYduL2NE/QipRQbYivQPhOMt36oJJMf
 JRijN/U3A/Mb/RNQ2xDI1Sr0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fbb1300ba3647103;
	Fri, 02 Oct 2026 20:49:55 +0000
X-Mizu-Trace-ID: fbb1300ba3647103
X-Migadu-Flow: FLOW_OUT
Message-ID: <5b7579be-e885-4b5d-9336-b4aaa2cc09d4@linux.dev>
Date: Fri, 2 Oct 2026 21:49:54 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 07/22] bpf: Follow an unwind to its landing
 pad in the verifier
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20261001133042.1339539-1-yonghong.song@linux.dev>
 <344ff8ec93e6d083a2e73cf866699be96593f5c7d7e46b704f7dc2d69e76cf48@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <344ff8ec93e6d083a2e73cf866699be96593f5c7d7e46b704f7dc2d69e76cf48@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/1/26 7:31 AM, bot+bpf-ci@kernel.org wrote:
>> bpf: Follow an unwind to its landing pad in the verifier
> TL;DR:
> - Global call that unwinds without a landing pad may hit a verifier bug
>    warning in backtrack_insn() on fentry/cgroup_skb programs
> - bpf_unwind() skips no_stack_arg_load, so a stale R9 arg-6 load may pass
>    verification
>
>> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
>> index 0e38b9575328..f5504334df90 100644
>> --- a/kernel/bpf/backtrack.c
>> +++ b/kernel/bpf/backtrack.c
> [ ... ]
>
>> @@ -434,6 +458,24 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>>   					return -EFAULT;
>>   			}
>>
>> +			if (bpf_exc_pad_of_call(env, idx) == subseq_idx) {
>> +				/*
>> +				 * We came from the landing pad of a call to a
>> +				 * global subprog, branched to from the state
>> +				 * the call returns in: as on its return, no
>> +				 * frame was entered here. The call clobbered
>> +				 * r0-r5; r6-r9 and the stack are the caller's
>> +				 * own and keep going back from here.
>> +				 */
>> +				bt_clear_reg(bt, BPF_REG_0);
>> +				if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
>> +					verifier_bug(env, "landing pad unexpected regs %x",
>> +						     bt_reg_mask(bt));
>> +					return -EFAULT;
>> +				}
>> +				return 0;
>> +			}
>> +
>>   			/* callx calls static subprogs only */
>>   			if (subprog >= 0 && bpf_subprog_is_global(env, subprog)) {
>>   				/* check that jump history doesn't have any
> Can the existing idx + 1 != subseq_idx check in this global branch now fire
> for a global call that unwinds with no landing pad?
>
>      verifier_bug_if(idx + 1 != subseq_idx, env,
>                      "extra insn from subprog");
>
> In that case unwind_out_of_global_call() takes the pad < 0 path into
> unwind_frames(), and when unwind_frames() reaches the main frame it pushes a
> history entry with no flags:
>
>      env->prev_insn_idx = env->insn_idx;
>      env->insn_idx = state->insn_idx;
>      err = bpf_push_jmp_history(env, state, 0, 0, 0, NULL, 0);
>      ...
>      return process_bpf_exit_full(env, do_print_state, false);
>
> The entry's prev_idx is the global call insn, so INSN_F_UNWIND is not set.
> For program types where return_retval_range() returns true (fentry/fexit,
> cgroup_skb, struct_ops), process_bpf_exit_full() -> check_return_code() calls
> mark_chain_precision(env, BPF_REG_0).
>
> The backtrack then reaches backtrack_insn() with idx at the global call and
> subseq_idx at either the same insn (call in main) or the call site in main
> (static frames popped first).  The INSN_F_UNWIND branch does not match, the
> bpf_exc_pad_of_call() == subseq_idx branch does not match because no pad
> covers the call, and the walk lands in the global branch above, where
> idx + 1 != subseq_idx is true.
>
> The result is a WARN_ONCE() (a panic with panic_on_warn) and a "verifier bug"
> message in the log, although the program is still accepted.  An example is an
> fentry or cgroup_skb program calling a global subprog that calls
> bpf_unwind() with no record covering the call, or main -> static A -> global
> G with no records.
>
> The selftests in the series all use SEC("syscall"), where
> return_retval_range() returns false and r0 precision is never requested at
> exit, so they would not reach this.  Nothing later in the series touches
> backtrack.c.
>
> Should the main-exit history entry get its own flag, or should this global
> branch handle that entry before applying the idx + 1 check?

Yes, this global branch should handle that entry before applying the idx + 1
check (global function) and we can add INSN_F_UNWIND to this jump history
to keep later continuing doing static function.

>
> [ ... ]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 80034429fdd0..c7a350be538e 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -19380,13 +19520,32 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
>>   					return -EINVAL;
>>   				}
>>   			}
>> +			if (bpf_is_unwind_kfunc(insn) || bpf_is_unwind_resume_kfunc(insn)) {
>> +				err = check_kfunc_allowed_only(env, insn, env->insn_idx);
>> +				if (err)
>> +					return err;
>> +				if (bpf_is_unwind_kfunc(insn))
>> +					return process_bpf_unwind(env, &env->insn_idx,
>> +								  do_print_state);
>> +				/*
>> +				 * The fixups lower this to 'r0 = 0; exit', and
>> +				 * the unwind goes on below this frame.
>> +				 */
>> +				return unwind_frames(env, do_print_state);
>> +			}
>>   			mark_reg_scratched(env, BPF_REG_0);
>>   			if (bpf_in_stack_arg_cnt(&env->subprog_info[cur_func(env)->subprogno]))
>>   				cur_func(env)->no_stack_arg_load = true;
> Does this early return skip the no_stack_arg_load assignment that every
> other call insn gets?
>
> For bpf_unwind() with a pad in the same frame, process_bpf_unwind() goes on
> at the pad in the frame that made the call, with no_stack_arg_load still
> false:
>
>      clear_caller_saved_regs(env, frame->regs);
>      mark_reg_unknown(env, frame->regs, BPF_REG_0);
>      *insn_idx = pad;
>      return INSN_IDX_UPDATED;
>
> On x86, do_jit() turns a load from BPF_REG_PARAMS at offset 8 (incoming
> arg 6) into a read of R9, which is caller-saved and clobbered by any call.
> check_stack_arg_read() relies on no_stack_arg_load to reject such a load
> after a call.
>
> So in a subprog with more than 5 args, would this sequence pass
> verification?
>
>      call bpf_unwind        // record covers it, pad P in this frame
>    P:
>      r1 = *(u64 *)(r11 + 8) // incoming arg 6
>      r2 = *(u64 *)(r1 + 0)
>
> check_stack_arg_read() gives r1 the type of caller->stack_arg_regs[0], which
> can be any spilled type, including a pointer such as PTR_TO_MAP_VALUE, but
> at run time r1 holds whatever bpf_unwind() left in R9.
>
> Would it work to move the mark_reg_scratched() and no_stack_arg_load lines
> above the unwind branch, or to set cur_func(env)->no_stack_arg_load in
> process_bpf_unwind() before going on at the pad?
>
> The unwind_out_of_global_call() pad path looks unaffected, since the
> PSEUDO_CALL path sets the flag before check_func_call().  do_check_insn()
> has the same ordering at the end of the series, where both kfuncs become
> callable.

Yes, you are right. The below:

  			mark_reg_scratched(env, BPF_REG_0);
  			if (bpf_in_stack_arg_cnt(&env->subprog_info[cur_func(env)->subprogno]))
  				cur_func(env)->no_stack_arg_load = true;

should be moved earlier so later some prog checking can inherit some
choices.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36872142096

