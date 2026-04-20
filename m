Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8442571C7
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 04:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776659782; cv=none; b=qCDSVPmfpWJACTBhJCNzB6WXHk2RFI1TpAMyJ12FemdIdaB1xfIpXARHOfQoLLj5MvGdy1lOO4Pwm/Hl7hrVoNy40uycuXQUMjehvEmycg5lIE5YMquznvuaO6P+nvxfpCnqu60wJQuTsW5wvmdwSNJcYKCH7SsoPmfC70lqPns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776659782; c=relaxed/simple;
	bh=eyUYTzQ0yFosHRs3osbsHNsFhMltBZmtIRP3PU/upBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oO6zpv6OyuleNK80jo/+9GfmNBk6W0FdOqp9/xsEK33XSpSCpapCJ34ePMpatypie6xzajogtOWVhKtCKqTWSwNWglBSsECEJ4GZQpbAcnx4x33dviAP7gdU4gjXxzbn1Kc5A7I7uX1t2ocuOZDxR7vRIOYIV8COnSE+6zFFgOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lfk8Gy7X; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lfk8Gy7X"
Message-ID: <961513ff-b3ba-4d27-b568-071a7c68e53f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776659778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X0tTM2sUcINSVv15KHtbAB/XUomP/HDb/mEQI/jpSI8=;
	b=Lfk8Gy7Xb0gZNMUmCXUpxVTdTKXcouXZsyxg02xvG4NsnweO50MCdmwGIbj4teEw1SXBae
	FFdijKn1wpp9ESbqcXnl2DQ+eX0ttPY5V32aMGprPkBIcdtN1jmLQXF28TxRMxoyiidJR+
	AaFB/yYgVeVTD1VvHaeFuGNN9vo+EdI=
Date: Sun, 19 Apr 2026 21:35:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 07/17] bpf: Support stack arguments for bpf
 functions
Content-Language: en-GB
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260419163352.734115-1-yonghong.song@linux.dev>
 <20260419191516.44EA1C2BCAF@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260419191516.44EA1C2BCAF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/19/26 12:15 PM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 3 potential issue(s):
> - [Critical] Missing precision tracking for stack arguments (`BPF_REG_PARAMS` / `r11`) leads to incorrect verifier state pruning and arbitrary out-of-bounds memory access.
> - [Medium] `BPF_PROG_TYPE_EXT` (freplace) programs are incorrectly rejected when targeting static subprograms with more than 5 arguments.
> - [Low] `stack_arg_safe()` strictly compares `stack_arg_depth`, preventing safe paths from being pruned and leading to state explosion.
> --
>
> commit 0c58d1bb907c4a6a387f1afd22baae9d43e95a55
> Author: Yonghong Song <yonghong.song@linux.dev>
> Subject: bpf: Support stack arguments for bpf functions
>
> This commit introduces support for passing more than 5 arguments to BPF
> subprograms by using a dedicated stack area accessed via register r11.
> It tracks these stack arguments separately from the regular stack to ensure
> proper verification and pruning.
>
> Link: https://github.com/llvm/llvm-project/pull/189060
>
>> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
>> index 8478d2c6ed5b6..235841d23fe3f 100644
>> --- a/kernel/bpf/states.c
>> +++ b/kernel/bpf/states.c
> [ ... ]
>> @@ -838,6 +838,44 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
>>   	return true;
>>   }
>>   
>> +/*
>> + * Compare stack arg slots between old and current states.
>> + * Outgoing stack args are path-local state and must agree for pruning.
>> + */
>> +static bool stack_arg_safe(struct bpf_verifier_env *env, struct bpf_func_state *old,
>> +			   struct bpf_func_state *cur, struct bpf_idmap *idmap,
>> +			   enum exact_level exact)
>> +{
>> +	int i, nslots;
>> +
>> +	if (old->incoming_stack_arg_depth != cur->incoming_stack_arg_depth)
>> +		return false;
>> +
>> +	/* Compare both incoming and outgoing stack arg slots. */
>> +	if (old->stack_arg_depth != cur->stack_arg_depth)
>> +		return false;
> Does this strict comparison of stack_arg_depth prevent safe paths from
> being pruned?
>
> Since stack_arg_depth tracks the allocated capacity rather than the
> active outgoing arguments tracked by out_stack_arg_mask, two branches
> that call subprograms with different stack argument requirements might
> end up with permanently different stack_arg_depth values.
>
> Could this unnecessarily increase verification complexity by failing to
> prune functionally equivalent states?

You are right. We should not compare stack_arg_depth, which is not tracking
arguments. The out_stack_arg_mask is the correct way to do comparison.

>
> [ ... ]
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 6aa4dc161a563..78c9322870a51 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>> +static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_state *state,
>> +				 int off, int value_regno)
>> +{
>> +	int max_stack_arg_regs = MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS;
> [ ... ]
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
>> +	if (is_spillable_regtype(arg->type))
>> +		copy_register_state(&cur->regs[dst_regno], arg);
>> +	else
>> +		mark_reg_unknown(env, cur->regs, dst_regno);
>> +	return 0;
>> +}
> Should check_stack_arg_read() and check_stack_arg_write() call
> bpf_push_jmp_history() with the INSN_F_STACK_ACCESS flag?
>
> When the callee uses a stack argument in a context requiring precision,
> backtracking is initiated. Because the INSN_F_STACK_ACCESS flag is
> missing, backtrack_insn() might silently return 0. This clears the
> destination register without propagating the precision requirement to
> the stack slot.
>
> Could this cause the verifier to incorrectly prune execution paths
> containing different, potentially unsafe scalar values, allowing
> programs to bypass verifier bounds checks and perform arbitrary
> out-of-bounds accesses? Note that the subsequent patch that tracks
> r11 registers in const_fold and liveness does not address this
> backtracking logic.

Yes, you are right. I will think of how to get backtracking work
for check_stack_arg_read() and check_stack_arg_write().

>
> [ ... ]
>> @@ -18808,7 +19097,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
>>   				goto out;
>>   			}
>>   		}
>> -		for (i = BPF_REG_1; i <= sub->arg_cnt; i++) {
>> +		for (i = BPF_REG_1; i <= min_t(u32, sub->arg_cnt, MAX_BPF_FUNC_REG_ARGS); i++) {
>>   			arg = &sub->args[i - BPF_REG_1];
>>   			reg = &regs[i];
> For freplace programs targeting static subprograms with more than 5
> arguments, do we need to initialize state->frame[0]->incoming_stack_arg_depth
> here or allocate stack_arg_regs?
>
> Currently it seems to only initialize arguments up to MAX_BPF_FUNC_REG_ARGS.
> If incoming_stack_arg_depth remains 0, an EXT program attempting to read
> its 6th argument via BPF_REG_PARAMS would fail verification in
> check_stack_arg_read() with -EACCES.

For freplace, considering the patch set is always very big, I would like
to delay this. I will add a check for freplace. If it has more than 5
parameters, will cause verification failure.

