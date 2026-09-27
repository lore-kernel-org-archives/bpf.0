Received: from mta1.migadu.com (out-147.mta1.migadu.com [95.215.58.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10165C613
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 00:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790469692; cv=none; b=HjDxa1VbJhEcjSy2EqTlXB3oSes8ZRqXNJvXPdspOoB3My+3ykL9YZTGvDEwZiO4jOz2Smwxq1iJg/0hfqxv/QHcLtVjdEJvPaoG39REbzEXBruuR80G3lTEmBBzujTBa/a4ddCM3BH39FLwQji2CiGJpwdY+xANmC0+U5X2oyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790469692; c=relaxed/simple;
	bh=b7ClxZJ/LFtdKSg/FJFKrKawBGXL9rJzxg1/R+esh+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibJowx7ofY4Mej3EbRob1LbHbkjrDzLsmFL0JY66Zysl8Hy7e+jrVqfCWFZPYv/3kIao6+J/Z+IwtlMmzDCj003/ewUT9mpEj3RzlN5Empe3kW5AALxuNTnUtjJauAG/qFC4heD4ri3w+Dla+0oouL15ILXxfQQMTBaAtpKOz1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EBGR+dQq; arc=none smtp.client-ip=95.215.58.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EBGR+dQq"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=b7ClxZJ/LFtdKSg/FJFKrKawBGXL9rJzxg1/R+esh+4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790469687; v=1; x=1791074487;
 b=EBGR+dQqQV2bDRubusqIiCP9+J+WI/yYGwUiVShF6DSUVv1Gn0EScgwCKgQ/GKzAKzjJ12Sj
 aDR2DycOz/dTP4dNLMjq7v+Iv8vI9ysa5iwYBeQci6r2ChNOqYymT41HgETxwSiq7biQL1yMfaM
 E5y2NhQp/JIYnw5c5HqzpzoI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 45e613fabf3ac06f;
	Sun, 27 Sep 2026 00:41:27 +0000
X-Mizu-Trace-ID: 45e613fabf3ac06f
X-Migadu-Flow: FLOW_OUT
Message-ID: <a20577c1-378d-4d38-b2b6-c37b950e7c08@linux.dev>
Date: Sat, 26 Sep 2026 17:41:20 -0700
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
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260926050006.2213110-1-yonghong.song@linux.dev>
 <20260926050042.2216692-1-yonghong.song@linux.dev>
 <20260926051542.D2B111F00893@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260926051542.D2B111F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/25/26 10:15 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] bpf: verifier bypass of resource leaks on unwinding without pad
> - [High] bpf: double free via bpf_unwind_resume returning to normal path in verifier
> - [Medium] bpf: precision tracking corruption when backtracking through bpf_unwind_resume
> - [Medium] bpf: CFG and liveness graph mismatch for bpf_unwind_resume
> --
>
> commit c4ed3d378ed3f7a547e662e1b6885fb3e54fef13
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Resume a covered call at its landing pad
>
> This patch introduces the ability for a BPF program to resume execution at a
> landing pad after an unwinding operation. It updates the verifier's control
> flow and state management to correctly account for these transitions, treating
> the landing pad as an ordinary second successor in the same frame.
>
>> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
>> index 0e38b9575328c..57665c67e66b3 100644
>> --- a/kernel/bpf/backtrack.c
>> +++ b/kernel/bpf/backtrack.c
> [ ... ]
>> @@ -434,8 +435,24 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>>   					return -EFAULT;
>>   			}
>>   
>> +			if (bpf_exc_pad_of_call(env, idx) == subseq_idx) {
>> +				/*
>> +				 * We came from this call's landing pad, which
>> +				 * runs in the caller's frame: on that path the
>> +				 * callee's frame was never entered, so there is
>> +				 * no frame to leave. The call clobbered r0-r5;
>> +				 * r6-r9 and the stack are the caller's own and
>> +				 * keep going back from here.
>> +				 */
>> +				bt_clear_reg(bt, BPF_REG_0);
>> +				if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
>> +					verifier_bug(env, "landing pad unexpected regs %x",
>> +						     bt_reg_mask(bt));
>> +					return -EFAULT;
>> +				}
>> +				return 0;
> [Severity: Medium]
> Does the BPF_CALL backtracking logic correctly handle bpf_unwind_resume()?

No. See below.

>
> When backtracking from a caller's instruction into a callee's pad and
> encountering bpf_unwind_resume(), it looks like backtrack_insn() processes it
> as a standard call without transitioning the backtrack frame (like
> bt_subprog_enter() does for BPF_EXIT).
>
> Could this leave the backtrack frame in the caller's context while traversing
> the callee, leading to precision tracking corruption?

Yes. I missed handling function bpf_is_unwind_resume_kfunc() which will
provide bt_subprog_enter().

>
>>   			/* callx calls static subprogs only */
>> -			if (subprog >= 0 && bpf_subprog_is_global(env, subprog)) {
>> +			} else if (subprog >= 0 && bpf_subprog_is_global(env, subprog)) {
> [ ... ]
>> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
>> index 4e2b6985bc964..cfd4fe4049cae 100644
>> --- a/kernel/bpf/cfg.c
>> +++ b/kernel/bpf/cfg.c
> [ ... ]
>> @@ -678,6 +687,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
>>   				mark_subprog_changes_pkt_data(env, t);
>>   			if (ret == 0 && bpf_is_throw_kfunc(insn))
>>   				mark_subprog_might_throw(env, t);
>> +			if (ret == 0 && bpf_is_unwind_kfunc(insn))
>> +				mark_subprog_might_unwind(env, t);
>>   		}
>>   		return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);
> [Severity: Medium]
> Is there a mismatch between the control flow graph and liveness tracking here?
>
> In visit_insn(), bpf_unwind_resume is processed as a standard kfunc call,
> which pushes a fallthrough edge into the CFG via visit_func_call_insn().
>
> However, in bpf_insn_successors() in liveness.c, it correctly acts as an exit:
>
>> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
>> index 4e0273a8ceee4..c9ee4f10f7255 100644
>> --- a/kernel/bpf/liveness.c
>> +++ b/kernel/bpf/liveness.c
> [ ... ]
>> @@ -364,6 +364,9 @@ bpf_insn_successors(struct bpf_verifier_env *env, u32 idx)
>>   		return jt;
>>   	}
>>   
>> +	if (unlikely(bpf_is_unwind_resume_kfunc(insn)))
>> +		return succ;
>> +
>>   	opcode_info = &opcode_info_tbl[BPF_CLASS(insn->code) | BPF_OP(insn->code)];
> Could this mismatch, where the CFG considers the path reachable but liveness
> sees 0 successors, violate verifier graph invariants?

Okay, the below is an optimization:

+	if (unlikely(bpf_is_unwind_resume_kfunc(insn)))
+		return succ;

let me remove it so the number of successor's will be consistent between
cfg and liveness.

>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index fc3df452de2e4..77176250f866c 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
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
> [Severity: High]
> Could returning PROCESS_BPF_EXIT here bypass resource leak and lock checks?
>
> If a BPF program acquires a resource like a spinlock and calls bpf_unwind()
> without a covering landing pad, pad < 0 evaluates to true. The verifier then
> pops the state and terminates the branch without invoking check_resource_leak()
> as process_bpf_exit_full() would normally do.
>
> Since do_check_insn() evaluates this kfunc before the active_locks check, could
> this allow the program to unwind while holding a spinlock, causing a kernel
> memory leak or deadlock at runtime?

Right, check_resource_leak() is a must here.

>
>> +	clear_caller_saved_regs(env, frame->regs);
>> +	mark_reg_unknown(env, frame->regs, BPF_REG_0);
>> +	*insn_idx = pad;
>> +	return INSN_IDX_UPDATED;
>> +}
> [ ... ]
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
> [Severity: High]
> Could this simulate a normal return from the subprogram and lead to a double
> free vulnerability?
>
> Here, bpf_unwind_resume is handled by calling process_bpf_exit_full() with
> exception_exit = false, returning to the normal instruction after the call.
>
> However, earlier in push_cleanup_pad_branch(), the caller's landing pad branch
> was already pushed using the pre-call state.
>
> At runtime, the callee's pad actually jumps to the caller's pad, not the
> instruction after the call. If a callee's pad frees a resource, the verifier
> will check the caller's pad using the pre-call state (where the resource was
> still allocated).
>
> Could this allow the caller's pad to free the same resource a second time,
> resulting in a use-after-free or double free vulnerability?

Yes, it is possible.
	outer_call:				inner_call:
		bpf_rcu_read_lock
		call inner_call
						bpf_unwind
					landing_pad:
						bpf_rcu_read_unlock
						...
						bpf_unwind_resume
	landing_pad:
		bpf_rcu_read_unlock
		...

The outer_call landing_pad uses states at the beginning of 'call_inner_call'
which does have bpf_rcu_read_lock. So this caused double bpf_rcu_read_unlock.

To fix this issue, for every function call which has landing_pad,
checkpoint the entry state (bpf_rcu_read_lock, bpf_prompt_disable, etc.)
and right before bpf_unwind_resume to ensure the state is the same
as entry state. This will prevent the above double free.

>
>>   			if (env->cur_state->active_locks) {
>>   				/* similar to static subprog calls callx is allowed under a lock */
>>   				if (!bpf_is_callx(insn) &&

