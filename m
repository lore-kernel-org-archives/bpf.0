Received: from mta1.migadu.com (out-17.mta1.migadu.com [95.215.58.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDF92628D
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 00:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790554651; cv=none; b=ILlkGeW+mtW7IyEA4ObQFJdx7/qgI+1jKTQ+hEcXlvhUJv0NOi9RaKjqegmP1eGgMfFbHUKfjpo95+Eso+ij95O0aJwOzLeG4Xgw/kMvS2LSF/8pi76VidG5Lycci2f5K4euXjQEeElYk2y6W26kgxct+tHgdym1fG/bixW19fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790554651; c=relaxed/simple;
	bh=VT+mhNBH5xTLY9nbMmmO3wwx5RO7Muta+Bfopbk5IlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4nyKQi49fEO3lcjO0/0bBotUJ7Cso3OtiAJQW64sePl3GsFrbM2huuEU3ZB6Yr0NNBwFRZGua1G5h5ffIrGe63yNsAti/WeyuKlZ+VbwLscJCDuZJwhkJr/DJsWZqdzZVjLQdtuU1CxWzGANmtcxrIrL0FNGyAO4X0++Iuly9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hJiAtc2K; arc=none smtp.client-ip=95.215.58.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hJiAtc2K"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VT+mhNBH5xTLY9nbMmmO3wwx5RO7Muta+Bfopbk5IlY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790554646; v=1; x=1791159446;
 b=hJiAtc2KlT7xQPUxCqNZwg0mXJ0rKJhZYfEctEHHBNXzoAE72mk3xEjS5JdaVtVhhm4byoi4
 8UzvjRdD1HKEwuWhJCo1in+1SrRz6IMD5G6IGomReBO9U26mMu3J8IJ50xPu4gZ2mIc6guj/D76
 aQQ68PFCdqSF1/spQ8KaYVro=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 044e12472f33e501;
	Mon, 28 Sep 2026 00:17:26 +0000
X-Mizu-Trace-ID: 044e12472f33e501
X-Migadu-Flow: FLOW_OUT
Message-ID: <e114594f-e79e-49df-ac7c-39fcc114aa1e@linux.dev>
Date: Sun, 27 Sep 2026 17:17:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 07/21] bpf: Resume a covered call at its
 landing pad
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260926050042.2216692-1-yonghong.song@linux.dev>
 <e0a07e78708d4f576ee9a50c2d7c2137b6f399d9de52917a7e59e4602716c1d7@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <e0a07e78708d4f576ee9a50c2d7c2137b6f399d9de52917a7e59e4602716c1d7@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/27/26 1:40 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 6d78c20e6507..0143688896b0 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -836,6 +836,7 @@ struct bpf_subprog_info {
>>   	s16 fastcall_stack_off;
>>   	bool has_tail_call: 1;
>>   	bool might_throw: 1;
>> +	bool might_unwind: 1;
>>   	bool tail_call_reachable: 1;
>>   	bool has_ld_abs: 1;
>>   	bool is_cb: 1;
> [ ... ]
>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 08aee86a155c..f291611fe578 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -5095,6 +5095,8 @@ BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_task_from_vpid, KF_ACQUIRE | KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_throw)
>> +BTF_ID_FLAGS(func, bpf_unwind)
>> +BTF_ID_FLAGS(func, bpf_unwind_resume)
>>   #ifdef CONFIG_BPF_EVENTS
>>   BTF_ID_FLAGS(func, bpf_send_signal_task)
>>   #endif
> Can a CAP_BPF program call bpf_unwind() at this commit? The kfuncs are
> registered in generic_btf_ids, which makes them resolvable, and the body
> at kernel/bpf/helpers.c is still __bpf_kfunc void bpf_unwind(void) { },
> so the call returns normally to the next instruction.
>
> However, the verifier assumes bpf_unwind() never falls through:
>
> kernel/bpf/verifier.c:process_bpf_unwind() ends the path with
> PROCESS_BPF_EXIT for an uncovered call, and jumps to the pad for a
> covered call. liveness.c keeps a fall-through edge, but do_check()
> never explores it. As a result, any instructions reachable only from
> after the call are skipped by the verifier and removed by
> bpf_opt_remove_dead_code().
>
> At run time the call returns and execution continues into whatever the
> JIT placed next, with r0-r5 clobbered, or off the end of the image.
>
> This is fixed later in the series by 7924e9e105cf "bpf: Dispatch cleanup
> pads by rewriting return addresses", which implements the real body via
> arch_bpf_stack_walk_ra()/bpf_unwind_rewrite(), and bpf_exc_keep_exits()
> puts 'r0 = 0; exit' after every bpf_unwind call.

As you suggested, I will move two BTF_ID_FLAGS's into commit
"bpf: Dispatch cleanup pads by rewriting return addresses".

>
> [ ... ]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index fc3df452de2e..77176250f866 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -19167,6 +19167,40 @@ enum {
>>   	INSN_IDX_UPDATED = 2,
>>   };
>>
>> +static int push_cleanup_pad_branch(struct bpf_verifier_env *env, int insn_idx)
>> +{
>> +	struct bpf_verifier_state *branch;
>> +	struct bpf_func_state *frame;
>> +	int pad = bpf_exc_pad_of_call(env, insn_idx);
>> +
>> +	if (pad < 0)
>> +		return 0;
>> +	branch = push_stack(env, pad, insn_idx, false);
>> +	if (IS_ERR(branch))
>> +		return PTR_ERR(branch);
>> +	frame = branch->frame[branch->curframe];
>> +	/*
>> +	 * The state at that call with the caller-saved registers gone: the
>> +	 * callee's epilogue put r6-r9 and the stack back on the way out.
>> +	 */
>> +	clear_caller_saved_regs(env, frame->regs);
>> +	mark_reg_unknown(env, frame->regs, BPF_REG_0);
>> +	return 0;
>> +}
>> +
>> +static int process_bpf_unwind(struct bpf_verifier_env *env, int *insn_idx)
>> +{
>> +	struct bpf_func_state *frame = cur_func(env);
>> +	int pad = bpf_exc_pad_of_call(env, *insn_idx);
>> +
>> +	if (pad < 0)
>> +		return PROCESS_BPF_EXIT;
>> +	clear_caller_saved_regs(env, frame->regs);
>> +	mark_reg_unknown(env, frame->regs, BPF_REG_0);
>> +	*insn_idx = pad;
>> +	return INSN_IDX_UPDATED;
>> +}
>> +
>>   static int process_bpf_exit_full(struct bpf_verifier_env *env,
>>   				 bool *do_print_state,
>>   				 bool exception_exit)
>> @@ -19404,6 +19438,20 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
>>
>>   		env->jmps_processed++;
>>   		if (opcode == BPF_CALL) {
>> +			if (bpf_is_unwind_kfunc(insn))
>> +				return process_bpf_unwind(env, &env->insn_idx);
>> +			if (bpf_is_unwind_resume_kfunc(insn)) {
>> +				/*
>> +				 * Mark r0 a known zero -- unknown first, as
>> +				 * the known-zero helper keeps the type it
>> +				 * finds, which here is NOT_INIT. The fixups
>> +				 * lower this to 'r0 = 0; exit', so the frame
>> +				 * returns a real zero.
>> +				 */
>> +				mark_reg_unknown(env, cur_regs(env), BPF_REG_0);
>> +				mark_reg_known_zero(env, cur_regs(env), BPF_REG_0);
>> +				return process_bpf_exit_full(env, do_print_state, false);
>> +			}
>>   			if (env->cur_state->active_locks) {
>>   				/* similar to static subprog calls callx is allowed under a lock */
>>   				if (!bpf_is_callx(insn) &&
> Both new kfuncs are handled before check_kfunc_call(), so
> bpf_fetch_kfunc_arg_meta() never runs for them. That function rejects a
> kfunc with -EACCES "calling kernel function %s is not allowed" when
> btf_kfunc_is_allowed() fails for the program type or the kfunc has no
> flags. bpf_add_kfunc_call() only resolves the BTF id and does not apply
> that filter.

You are right, we need bpf_fetch_kfunc_arg_meta check. Will fix.

>
> As a result, bpf_unwind() and bpf_unwind_resume() are callable from any
> program type that can make kfunc calls, including types that
> generic_kfunc_set is not registered for (it is registered for TRACING,
> SCHED_CLS, XDP, STRUCT_OPS, SYSCALL and CGROUP_SKB).
>
> It also skips the usual sleepable, RCU, preempt and IRQ-context checks
> in check_kfunc_call().
>
> ---
>
> At this commit a bpf_unwind_resume() call is verified as a frame exit
> with r0 = 0, but the comment says "The fixups lower this to
> 'r0 = 0; exit'". Does that lowering exist yet? No fixup for it exists in
> kernel/bpf/fixups.c at this commit.

Comment is not right. The fixup is in later patch
"bpf: Dispatch cleanup pads by rewriting return addresses".

>
> This call is also accepted anywhere, not only inside a landing pad. So a
> CAP_BPF program can place 'call bpf_unwind_resume' in its main path. The
> verifier treats the path as ended and never looks at the following
> instructions, which the dead-code pass then removes or sanitizes.
>
> At run time the real kfunc body runs WARN_ONCE(1, "exception cleanup
> resume was not lowered to a return\n"). That is a user-triggerable
> warning, and a panic with panic_on_warn. The call then returns normally
> with r0-r5 clobbered and falls into instructions that were never
> verified for this state, or off the end of the JIT image.
>
> This is fixed later in the series by 7924e9e105cf "bpf: Dispatch cleanup
> pads by rewriting return addresses", which adds the bpf_do_misc_fixups
> lowering, and 2a1e4ed1e9ae "bpf: Refuse a landing pad that does not
> resume", which rejects "resume at insn %d is not in a landing pad".
>
>> @@ -19422,6 +19470,10 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
>>   				}
>>   			}
>>   			mark_reg_scratched(env, BPF_REG_0);
>> +			/* An unwind out of this call resumes at the pad. */
>> +			err = push_cleanup_pad_branch(env, env->insn_idx);
>> +			if (err)
>> +				return err;
>>   			if (bpf_in_stack_arg_cnt(&env->subprog_info[cur_func(env)->subprogno]))
>>   				cur_func(env)->no_stack_arg_load = true;
>>   			if (bpf_is_callx(insn))
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346422430

