Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889301514F8
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776532262; cv=none; b=KdZ4FQtJnKP062OpokufH/sRW+WDtZFR6lAhpC3CNkSpOrpXHQKPn7gBm9l9LUrPNfqhHxLcqihs4A34BOWuamN6zLIIXNInmdJms+bi/2rDglQFffiTGMg8OtfsVAQhgEXnhP9GYGMxDTfmt2mjK31nmhnPKkXP2yeMRCOq38A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776532262; c=relaxed/simple;
	bh=8x2bzh+ihWnmJK0FnV2lp9dPZP3BnV2Hz1VZw3VDTxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4ZGV/GG1U4WQq8vwAXsVOCu449H26is8Y1kb3P8MYtMsRwo/Zpu6pc0045md8LmFQMYCnY7Qd8leq2TlFO9oWQrwa75/VY8yHTs1oDFWvNe56610Hx6bn/pnWQatyIPrG0oChI47S0aNcOfDL7jxb6oXJDeii6UNeTaw6iCXZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q6T0YN3T; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q6T0YN3T"
Message-ID: <86aa2e9c-c612-4a96-9d76-1dde1b396e16@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776532258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qXYV9vMW71yG4WmxcgT9G2bib9M6dnMYMZHRa2rLtU=;
	b=Q6T0YN3TqGCOLJxD0k0heo3Ve3EOcn3J7O+FcvWy2ZBCjn2d/e7Awns8yfZogYPaEX0y6P
	ndNiL3CIBvvtLwb514gn0mRM72ymbgRpc3ZhwDNJdhwdyK1/sQFFEqtaIBXJP9+6oFN/qE
	upWOM604V3Kgv1JCmupZG2N+cMsoPEQ=
Date: Sat, 18 Apr 2026 10:10:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 08/16] bpf: Support stack arguments for bpf
 functions
Content-Language: en-GB
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260417034739.2629927-1-yonghong.song@linux.dev>
 <20260417043525.6DAF1C2BCB6@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260417043525.6DAF1C2BCB6@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/16/26 9:35 PM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 5 potential issue(s):
> - [Critical] Verifier State Leakage in `copy_stack_state` when reusing states.
> - [Critical] Security / Liveness Tracking Bypass via `stack_arg_regs`.
> - [Critical] Use-After-Free via Type Mismatch in `bpf_get_spilled_stack_arg()`.
> - [Medium] Unnecessary Rejection of Valid Programs due to Dead Code Elimination.
> - [Low] Missing Parentheses in `bpf_get_spilled_stack_arg` Macro.
> --
>
> commit 6ec4a3fcb5e83a95626cd2bb13a60b2283e1c3e2
> Author: Yonghong Song <yonghong.song@linux.dev>
> bpf: Support stack arguments for bpf functions
>
> This commit adds support for passing more than 5 arguments to BPF subprograms
> by utilizing a dedicated stack area accessed via register r11. It introduces
> new fields to track incoming and outgoing stack arguments for bounds checking
> and precise verifier path tracking.
>
> Link: https://github.com/llvm/llvm-project/pull/189060
>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -508,6 +513,17 @@ struct bpf_verifier_state {
>>   	     iter < frame->allocated_stack / BPF_REG_SIZE;		\
>>   	     iter++, reg = bpf_get_spilled_reg(iter, frame, mask))
>>   
>> +#define bpf_get_spilled_stack_arg(slot, frame, mask)                   \
>> +	(((slot < frame->stack_arg_depth / BPF_REG_SIZE) &&             \
>> +	  ((1 << frame->stack_arg_regs[slot].type) & (mask))) \
>> +	 ? &frame->stack_arg_regs[slot] : NULL)
> Is there a type mismatch in this check?
>
> The mask parameter here is passed as 1 << STACK_SPILL, but
> frame->stack_arg_regs[slot].type is an enum bpf_reg_type, not an enum
> bpf_stack_slot_type.
>
> For pointer types, this expression can evaluate to 0. This would cause the
> iterator to silently skip pointers stored in the stack argument area. If an
> acquired reference is dropped via release_reference(), the copy in the stack
> argument area wouldn't be invalidated, potentially allowing a use-after-free
> if a program subsequently reads the spilled pointer back from r11.
>
> Also, this isn't a bug, but should the slot parameter be enclosed in
> parentheses to prevent operator precedence issues if a complex expression
> is passed in the future?

Yes, it is a bug. Will fix.

>
> [ ... ]
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
>> @@ -1266,9 +1275,20 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
> [ ... ]
>> +	for (i = 0; i < env->subprog_cnt; i++) {
>> +		struct bpf_subprog_info *subprog = &env->subprog_info[i];
>> +
>> +		if (subprog->max_out_stack_arg_depth > subprog->outgoing_stack_arg_depth) {
>> +			verbose(env,
>> +				"func#%d writes stack arg slot at depth %u, but calls only require %u bytes\n",
>> +				i, subprog->max_out_stack_arg_depth, subprog->outgoing_stack_arg_depth);
>> +			return -EINVAL;
>> +		}
>> +	}
> Could this reject valid programs if the compiler hoists a stack argument
> store above a branch that is later eliminated as dead code?
>
> If the compiler optimizes a store above a conditional check,
> max_out_stack_arg_depth would be updated. However, if the configuration
> constants cause the branch containing the actual function call to be
> eliminated, outgoing_stack_arg_depth would remain 0, leading to a rejection
> of a safe verification path.

We should be okay here. btf_check_func_arg_match() ensures func prototype
matches the number of outgoing parameters. Otherwise, it will fail:

                 if (i >= MAX_BPF_FUNC_REG_ARGS) {
                         struct bpf_func_state *caller = cur_func(env);
                         int spi = out_arg_spi(caller, i - MAX_BPF_FUNC_REG_ARGS);
                                 
                         /*
                          * The compiler may constant-fold stack arg values into the
                          * callee, eliminating the r11 stores. The BTF still declares
                          * these parameters, but no outgoing stack slots exist.
                          */
                         if (spi >= (caller->stack_arg_depth / BPF_REG_SIZE)) {
                                 verbose(env, "stack %s not found in caller state\n",
                                         reg_arg_name(env, argno));
                                 return -EINVAL;
                         }
                 }

>
> [ ... ]
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -1340,6 +1340,20 @@ static int copy_stack_state(struct bpf_func_state *dst, const struct bpf_func_st
>>   		return -ENOMEM;
>>   
>>   	dst->allocated_stack = src->allocated_stack;
>> +
>> +	/* copy stack args state */
>> +	n = src->stack_arg_depth / BPF_REG_SIZE;
>> +	if (n) {
>> +		dst->stack_arg_regs = copy_array(dst->stack_arg_regs, src->stack_arg_regs, n,
>> +					     sizeof(struct bpf_reg_state),
>> +					     GFP_KERNEL_ACCOUNT);
>> +		if (!dst->stack_arg_regs)
>> +			return -ENOMEM;
>> +
>> +		dst->stack_arg_depth = src->stack_arg_depth;
>> +		dst->incoming_stack_arg_depth = src->incoming_stack_arg_depth;
>> +		dst->out_stack_arg_mask = src->out_stack_arg_mask;
>> +	}
>>   	return 0;
>>   }
> Does this skip clearing the destination's stack argument fields if the source
> state has no stack arguments?
>
> If src->stack_arg_depth is 0, dst->stack_arg_depth, out_stack_arg_mask, and
> incoming_stack_arg_depth are not updated. When the verifier reuses an
> existing state during pop_stack() via bpf_copy_verifier_state(), the
> destination state might incorrectly inherit a stale stack argument
> initialization mask from a previously evaluated path.
>
> Could this allow a program to initialize stack arguments on one branch, and
> then safely perform a function call on a different branch without proper
> initialization?

Yes, you are right. dst->stack_arg_depth etc. should not under condition 'if (n)'.

>
> [ ... ]
>> @@ -4424,6 +4467,123 @@ static int check_stack_write(struct bpf_verifier_env *env,
> [ ... ]
>> +static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_state *state,
>> +				 int off, int value_regno)
>> +{
> [ ... ]
>> +	cur = env->cur_state->frame[env->cur_state->curframe];
>> +	if (value_regno >= 0) {
>> +		state->stack_arg_regs[spi] = cur->regs[value_regno];
>> +	} else {
>> +		/* BPF_ST: store immediate, treat as scalar */
>> +		struct bpf_reg_state *arg = &state->stack_arg_regs[spi];
>> +
>> +		arg->type = SCALAR_VALUE;
>> +		__mark_reg_known(arg, env->prog->insnsi[env->insn_idx].imm);
>> +	}
>> +	state->out_stack_arg_mask |= BIT(idx);
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Read a value from the incoming stack arg area.
>> + * off is a positive offset from r11 (e.g. +8 for arg6, +16 for arg7).
>> + * Callers ensure off > 0, 8-byte aligned, and size is BPF_REG_SIZE.
>> + */
>> +static int check_stack_arg_read(struct bpf_verifier_env *env, struct bpf_func_state *state,
>> +				int off, int dst_regno)
>> +{
> [ ... ]
>> +	arg = &state->stack_arg_regs[spi];
>> +	cur = env->cur_state->frame[env->cur_state->curframe];
>> +
>> +	if (is_spillable_regtype(arg->type))
>> +		copy_register_state(&cur->regs[dst_regno], arg);
>> +	else
>> +		mark_reg_unknown(env, cur->regs, dst_regno);
>> +	return 0;
>> +}
> Does this bypass liveness tracking for stack arguments?

This will be addressed in liveness.c.

>
> Because the state is copied directly without calling mark_reg_read(), the
> live field of stack arguments is never marked as read.
>
> During state pruning, stack_arg_safe() delegates to regsafe(), which
> contains a fast-path that unconditionally returns true if the old state's
> register was never marked as read. Could this cause the verifier to
> aggressively prune verification paths even if they contain completely
> different and potentially unsafe stack arguments?
>
I think we should be okay. mark_reg_unknown will mark register as SCALAR_VALUE.
It will do pruning properly in regsafe().

