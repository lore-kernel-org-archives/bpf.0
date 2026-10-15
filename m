Received: from mta1.migadu.com (out-155.mta1.migadu.com [95.215.58.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593943E3DA2
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792079023; cv=none; b=VMdOxiEffKMSYCwwVz8aX1zbToKnN4BR+JxVgscHpiikeDcDx+IdONZS8ewoHmG1b0RcM/GnTjonz2+DCIxrbeKqKXzQw+jndTbRnbW0XcxHWn77NYVmJ4Tm0hcVIQfyWD/C/mY0q4DwF1psyyhnTUAUIuBNYsygx8xHrXG5Vhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792079023; c=relaxed/simple;
	bh=O/UcenkZl+cM9HIIrBgU2U8WddAR3guCcZ35M1yAgcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QWQPItOyPhKUNjwyES1Bqpbkh13XW/Z6/oYTuKvCpneJeYh/czj/Cg7ARIXtSrbuFFOKdCpCcILWZNEX70muw6NSTaDiaDFz/FkL+CRsO9kJIDlKTuvR6uK3AJ5UVuljzyTHpqZulTkJvMuHSuAfUYnO+2sbMkpW1N8x52mjcNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uXnhM5PE; arc=none smtp.client-ip=95.215.58.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uXnhM5PE"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=O/UcenkZl+cM9HIIrBgU2U8WddAR3guCcZ35M1yAgcw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792079008; v=1; x=1792683808;
 b=uXnhM5PEmv/2R9q9m2ZDLEiPtHByzfI7QgYLcifErojSKEXjcFBzkXptq9lUVi3QCCtXYPul
 JF+ksIfC1pJS2jvWLgoQqEh0j5CIHy2kj9o9HQwnMc/i+G9M5s7emGaW1lpIy/cqoS40N1VMfCf
 uSswip0eh/CNBnVEGdPmiwZk=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dee80e2dea1db48a;
	Thu, 15 Oct 2026 15:43:28 +0000
X-Mizu-Trace-ID: dee80e2dea1db48a
X-Migadu-Flow: FLOW_OUT
Message-ID: <3617adcb-de80-4caf-89c8-9bd0e4f7d154@linux.dev>
Date: Thu, 15 Oct 2026 08:43:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v11 07/26] bpf: Verify an unwind through landing
 pads and epilogues
To: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
References: <20261015040143.854070-1-yonghong.song@linux.dev>
 <20261015040219.858407-1-yonghong.song@linux.dev>
 <sashiko-outbox-172270@kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <sashiko-outbox-172270@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/14/26 9:29 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] bpf: precision tracking fails to backtrack from unwind landing pad
> - [High] bpf: global subprogram unwind pad bypassed if might_throw is true
> --
>
> commit d697ce1fb72f895b857d6e1eeaa219cab7a013bc
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Verify an unwind through landing pads and epilogues
>
> The commit adds support for verifying bpf_unwind() through landing pads and
> epilogues. It updates verifier control flow, state tracking, and precision
> backtracking to understand these non-linear execution paths.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 96f5ea8ea8bf8..fe24291260a0e 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>> @@ -19674,6 +19682,133 @@ enum {
>>   	INSN_IDX_UPDATED = 2,
>>   };
>>   
>> +static int unwind_frames(struct bpf_verifier_env *env, bool *do_print_state)
>> +{
> [ ... ]
>> +		/*
>> +		 * Mark the unwinding insn with the frame it ran in: backtracking
>> +		 * from the pad comes back to that insn and goes on in that frame.
>> +		 */
>> +		err = bpf_push_jmp_history(env, state, INSN_F_UNWIND, 0, frameno, NULL, 0);
>> +		if (err)
>> +			return err;
>> +		clear_caller_saved_regs(env, caller->regs);
>> +		mark_reg_unknown(env, caller->regs, BPF_REG_0);
>> +		env->insn_idx = pad;
>> +		if (do_print_state)
>> +			*do_print_state = true;
>> +		return INSN_IDX_UPDATED;
> [Severity: High]
> Does this code break precision backtracking?
>
> The jmp_history entry is pushed before env->insn_idx is updated to pad. This
> means the entry's idx will record the unwinding instruction instead of the pad
> target.
>
> During backtracking, when the verifier reaches pad, it calls
> get_prev_insn_idx() which uses st->jmp_history entries where idx matches the
> jump target. Because idx was recorded as the unwinding instruction,
> get_prev_insn_idx() will fail to find it and fall back to linear backtracking
> (pad - 1) instead of jumping back to the source instruction.
>
> Since exception landing pads are typically emitted out-of-line by the compiler,
> backtracking into pad - 1 jumps into completely unrelated code, corrupting
> precision tracking.

Landing pad backtracking into pad - 1 is incorrect.
In cfg.c, visit_cleanup_pad_edge() calls mark_jmp_point(env, w) on every pad.
So when backtracking happens, pad will goto unwinding insn instead pad - 1.

>
> [ ... ]
>> +static int process_global_call_unwind(struct bpf_verifier_env *env,
>> +				      int call_idx, bool *do_print_state)
>> +{
>> +	const struct bpf_insn *insn = &env->prog->insnsi[call_idx];
>> +	int subprog = bpf_find_subprog(env, call_idx + insn->imm + 1);
>> +	struct bpf_verifier_state *branch;
>> +	struct bpf_func_state *frame;
>> +	int pad;
>> +
>> +	if (!bpf_subprog_is_global(env, subprog) ||
>> +	    !env->subprog_info[subprog].might_unwind)
>> +		return 0;
>> +
>> +	/* The call returning normally is walked later. */
>> +	branch = push_stack(env, call_idx + 1, call_idx, false);
>> +	if (IS_ERR(branch))
>> +		return PTR_ERR(branch);
>> +
>> +	pad = bpf_exc_pad_of_call(env, call_idx);
>> +	if (pad < 0)
>> +		return unwind_frames(env, do_print_state);
>> +	frame = cur_func(env);
>> +	clear_caller_saved_regs(env, frame->regs);
>> +	mark_reg_unknown(env, frame->regs, BPF_REG_0);
>> +	env->insn_idx = pad;
>> +	*do_print_state = true;
>> +	return INSN_IDX_UPDATED;
>> +}
> [Severity: High]
> Can this fail to record the non-linear edge for backtracking?
>
> If a landing pad is found (pad >= 0), env->insn_idx is directly set to pad and
> the function returns. However, it seems a jmp_history entry linking pad back to
> call_idx is never pushed.
>
> Just like in unwind_frames(), this missing history entry causes
> get_prev_insn_idx() to fall back to linear backtracking (pad - 1) during the
> backtrack walk, which jumps into unrelated code and can severely corrupt
> precision tracking.

Actually, as mentioned in the first case, there is a mark_jmp_point
to link call_idx -> pad. So when backtracking happens, pad -> call_idx
should work properly.

>
> [ ... ]
>> @@ -19935,8 +20070,14 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
>>   				cur_func(env)->no_stack_arg_load = true;
>>   			if (bpf_is_callx(insn))
>>   				return check_func_callx(env, insn, &env->insn_idx);
>> -			if (insn->src_reg == BPF_PSEUDO_CALL)
>> -				return check_func_call(env, insn, &env->insn_idx);
>> +			if (insn->src_reg == BPF_PSEUDO_CALL) {
>> +				int call_idx = env->insn_idx;
>> +
>> +				err = check_func_call(env, insn, &env->insn_idx);
>> +				if (err)
>> +					return err;
>> +				return process_global_call_unwind(env, call_idx, do_print_state);
>> +			}
> [Severity: High]
> Does this check inadvertently bypass the unwind pad if the global subprogram
> can also throw?
>
> A global subprogram can be marked with both might_throw = true and
> might_unwind = true if it can call both bpf_throw() and bpf_unwind().

If bpf_unwind() exists in the bpf prog, then
bpf_throw() will be rejected in bpf_exc_check_prog(env).

-       if (env->cleanup_info_cnt) {
+       if (env->cleanup_info_cnt || bpf_prog_may_unwind(env)) {
                 ret = bpf_exc_check_prog(env);
                 if (ret)
                         goto skip_full_check;

So this is not an issue.

>
> When verifying a call to such a global subprogram, check_func_call() checks
> might_throw, pushes the normal return branch, and returns PROCESS_BPF_EXIT
> (which is non-zero) to simulate the exception exit:
>
> check_func_call() {
>      ...
>      if (env->subprog_info[subprog].might_throw) {
>          ...
>          return process_bpf_exit_full(env, NULL, true);
>      }
>      ...
> }
>
> Because check_func_call() returns PROCESS_BPF_EXIT, if (err) evaluates to true
> here, causing the verifier to return immediately and skip
> process_global_call_unwind().
>
> As a result, the unwind landing pad for this call is never pushed or explored.
> Dead code sanitization will replace the unvisited pad with a jump to itself
> (an infinite loop). If the global subprogram unwinds at runtime, it will jump
> to this unverified pad and enter an infinite loop, causing a kernel denial of
> service.
>

