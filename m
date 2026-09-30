Received: from mta0.migadu.com (out-117.mta0.migadu.com [91.218.175.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5172A3AC00
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 00:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790728114; cv=none; b=uq5x2mjPOr+r4Ldt+MB6oP1aMIOoG9Q6eMGl6BNKqkmN2wY8iBQYnX/fvnFUA/ZAaP9sPNCFR2jjr1cWoGe51uOHA3mOkoT1atFtZoQJOcfzphJO+rfB4TT3JfcsYBx5WVnQGnOtHtk8WbYSxBCce1dypRX/x2jNmD/Uda2KxYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790728114; c=relaxed/simple;
	bh=H6OmdGKh1eVXFrmLOMRLKUgkSisn7WiU4uvfXhKG8pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L2B0RmCbvn7TG+DxPCuObvL7CZFmN2QfC2Bb2w/mC0zIy5qjjjGl1+8DE3eauWcb9m9ja384AV9J+YFg6STKMkqyjo5FmjKsB89kTU8HpsRsLymt3AiwIpl8ryGo4QvQNv1/KwFxCPeeeKqb8nY5LGw8XlIhtgCDERD16BNuP+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lWGQYODn; arc=none smtp.client-ip=91.218.175.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lWGQYODn"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=H6OmdGKh1eVXFrmLOMRLKUgkSisn7WiU4uvfXhKG8pM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790728109; v=1; x=1791332909;
 b=lWGQYODnY0L2818lC0V00K6qM4dnxBeMHZtYPsnyDLu8EZz3ZKFWivN0VLzQ991Z9S/cyWLv
 qy2CCH86/asTGdeeOqts1/K7kG/6sczGZIH1p3d+UHOkol096+AHvQ+7LaoHpC1WukZbMeE4rgB
 HotdOOTvySLfDzEfBag/l6sk=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 71debd812362a652;
	Wed, 30 Sep 2026 00:28:29 +0000
X-Mizu-Trace-ID: 71debd812362a652
X-Migadu-Flow: FLOW_OUT
Message-ID: <5c4797c6-8fdb-4072-a134-31784b8e8481@linux.dev>
Date: Tue, 29 Sep 2026 17:28:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 07/22] bpf: Resume a covered call at its
 landing pad
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260929001601.3242665-1-yonghong.song@linux.dev>
 <20260929001638.3248952-1-yonghong.song@linux.dev>
 <20260929003106.3A0211F00893@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260929003106.3A0211F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/28/26 5:31 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] bpf: landing pad state desync via discarded memory mutations allows OOB access
> --
>
> commit 41b3c5e14924fae7175095b7012838a14c2e5ffc
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Resume a covered call at its landing pad
>
> This commit allows a covered call to resume at its landing pad when bpf_unwind()
> is invoked by a subprogram. It pushes a cleanup pad branch with the caller's
> pre-call state and handles bpf_unwind() by returning PROCESS_BPF_EXIT for
> nested frames.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index fc3df452de2e4..ee074d4a936b5 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -19167,6 +19186,57 @@ enum {
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
>> +static int process_bpf_unwind(struct bpf_verifier_env *env, int *insn_idx,
>> +			      bool *do_print_state)
>> +{
>> +	struct bpf_func_state *frame = cur_func(env);
>> +	int pad = bpf_exc_pad_of_call(env, *insn_idx);
>> +	int err;
>> +
>> +	if (pad < 0) {
>> +		err = check_resource_leak(env, false, !env->cur_state->curframe,
>> +					  "an unwind with no landing pad");
>> +		if (err)
>> +			return err;
>> +		if (env->cur_state->curframe)
>> +			return PROCESS_BPF_EXIT;
> [Severity: Critical]
> When process_bpf_unwind() returns PROCESS_BPF_EXIT here, the verifier stops
> exploring the callee and discards its state. Does this discard any memory
> mutations made by the callee to pointer arguments before calling bpf_unwind()?

You are right. It is my mistake. The key problem is here (in v7):

+static int push_cleanup_pad_branch(struct bpf_verifier_env *env, int insn_idx)
+{
+	struct bpf_verifier_state *branch;
+	struct bpf_func_state *frame;
+	int pad = bpf_exc_pad_of_call(env, insn_idx);
+
+	if (pad < 0)
+		return 0;
+	branch = push_stack(env, pad, insn_idx, false);
+	if (IS_ERR(branch))
+		return PTR_ERR(branch);
+	frame = branch->frame[branch->curframe];
+	/*
+	 * The state at that call with the caller-saved registers gone: the
+	 * callee's epilogue put r6-r9 and the stack back on the way out.
+	 */
+	clear_caller_saved_regs(env, frame->regs);
+	mark_reg_unknown(env, frame->regs, BPF_REG_0);
+	return 0;
+}

esp.
   branch = push_stack(env, pad, insn_idx, false);
it ignored the state change in callee, e.g., a value in stack
may get changed. This will make verification incorrect due to
such changed value.

>
> Since the CPU unwinds the stack without undoing memory writes at runtime,
> could this desynchronize the verifier state from runtime state and allow
> out-of-bounds memory accesses?

Yes, see the above.

>
>> +		/*
>> +		 * The main program's frame returns at once, which is the
>> +		 * program returning. Mark r0 the zero the fixups leave after
>> +		 * the call, and leave through the exit, which is what holds
>> +		 * that zero to the program type.
>> +		 */
>> +		mark_reg_unknown(env, cur_regs(env), BPF_REG_0);
>> +		mark_reg_known_zero(env, cur_regs(env), BPF_REG_0);
>> +		return process_bpf_exit_full(env, do_print_state, false);
>> +	}
>> +	clear_caller_saved_regs(env, frame->regs);
>> +	mark_reg_unknown(env, frame->regs, BPF_REG_0);
>> +	*insn_idx = pad;
>> +	return INSN_IDX_UPDATED;
>> +}
>> +
> [ ... ]
>
>> @@ -19421,7 +19491,29 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
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
>>   			mark_reg_scratched(env, BPF_REG_0);
>> +			/* An unwind out of this call resumes at the pad. */
>> +			err = push_cleanup_pad_branch(env, env->insn_idx);
>> +			if (err)
>> +				return err;
> [Severity: Critical]
> push_cleanup_pad_branch() pushes a branch using a snapshot of the pre-call
> state. If the callee modified a stack variable (e.g., an array index) and then
> unwound the stack, does the verifier evaluate the landing pad with the original
> unmodified value?
>
> Could a BPF program use this to bypass bounds checks by mutating an index in
> the callee before unwinding, causing the verifier to optimize out the checks
> in the landing pad while using the out-of-bounds value at runtime?

You are right. See the above explanation. Will fix.

>
>>   			if (bpf_in_stack_arg_cnt(&env->subprog_info[cur_func(env)->subprogno]))
>>   				cur_func(env)->no_stack_arg_load = true;
>>   			if (bpf_is_callx(insn))

