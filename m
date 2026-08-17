Received: from mta0.migadu.com (out-75.mta0.migadu.com [91.218.175.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EC612CDA5
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 03:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786938201; cv=none; b=lUFQw7RXcsYlLcVMRtoIzmZ+20TAyL/xkM5M+sAwvd+9MPYxxwsi3CIKxPSsVFon2HIC9jZSPVEM61Mcy59jJfUYmi6/3hXYWZRwT6amOoXUtQt7SsorR6mMGheJzryvta/Jg5okgWoeBxOjnlpqytDatRCcalGpgTtFDDyGo/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786938201; c=relaxed/simple;
	bh=5JlqAkFUoHoOaU/+L10rQGU7qGWtY5gdH8bdufLqrKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujf+3TvvgykS8SV4wwq57ZQ8FOASHaZIRKtAVQE1Itv4086njzmtBg2Wapwji3mhrt8fLQp9Ve1nrBOlNBc2mbIHtXOhnrusH/6mmmI8mZG5kJ2aZ9/xPV2Mc3J7UFMxhcB9s8P+UYjvHkIJ7/j+SOIIbHUrHemtoXdoo54gsQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yeuaz5C8; arc=none smtp.client-ip=91.218.175.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yeuaz5C8"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5JlqAkFUoHoOaU/+L10rQGU7qGWtY5gdH8bdufLqrKU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786938196; v=1; x=1787542996;
 b=Yeuaz5C8b+zHe/DN6ZO+YJWyEKZ6bu7scbXIb5fVCHxx3SwGiHqRfOrnhhpETGCbViPeTq5m
 4WjW6XXszRB+/dLtwuNL8rSeEsXQh9bDUSe4bXuqXZMK42m+8rWt4dIWlSRQCvXkmuIWKLk7nJK
 7MVkuK4sDBNCtsgjKPS3xyro=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:382:861c:7f36:14e1:cf55:e233:293b] (2600:382:861c:7f36:14e1:cf55:e233:293b)
	by smtp.migadu.com with ESMTPS id f13dca0dc2dac506;
	Mon, 17 Aug 2026 03:43:16 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <f7b9ae25-d882-4d33-a0a8-7e87fbbcae52@linux.dev>
Date: Sun, 16 Aug 2026 20:43:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 06/11] bpf: Add verifier support for 16-byte
 returns in R0:R2
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260813200240.1995795-1-yonghong.song@linux.dev>
 <3cb3f15f328c59186cf442c7fda68e83849dc9db3aee638a82bfeb47917b9266@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <3cb3f15f328c59186cf442c7fda68e83849dc9db3aee638a82bfeb47917b9266@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/13/26 2:11 PM, bot+bpf-ci@kernel.org wrote:
>> bpf: Add verifier support for 16-byte returns in R0:R2
>>
>> LLVM 23 added support for returning a value in two registers for an
>> __int128, or a struct/union whose size is greater than 8 but not more than
>> 16 bytes. See LLVM patches [1] and [2].
>>
>> Before LLVM 23 the BPF backend could not return these values at all. A
>> by-value struct or union return (of any size) was rejected at compile time
>> with:
>>
>>    error: aggregate returns are not supported
>>
>> and an __int128 return failed later in the backend with:
>>
>>    fatal error: error in backend: unable to allocate function return #1
>>
>> Both are resolved in LLVM 23, which lowers such returns into the R0:R2
>> register pair.
>>
>> This patch models that pair at calls to global and static BPF subprograms
>> and at kfunc calls: R2 is marked alongside R0 at the call, propagated out
>> of a callee at its exit, and held to the same scalar-only and no-stack-
>> pointer rules that R0 already is.
> This isn't a bug, but could the changelog be reworded in imperative mood
> to match Documentation/process/submitting-patches.rst? The other commits
> in this series follow that convention, so this one reads inconsistently.
>
>> @@ -9858,11 +9867,15 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>>   	struct bpf_func_state *caller, *callee;
>>   	struct bpf_reg_state *r0;
>>   	bool in_callback_fn;
>> +	u32 i, nregs;
>>   	int err;
>>
>>   	callee = state->frame[state->curframe];
>>   	r0 = &callee->regs[BPF_REG_0];
>> -	if (r0->type == PTR_TO_STACK) {
>> +	nregs = bpf_ret_reg_pair(env, callee->subprogno) ? 2 : 1;
>> +	for (i = 0; i < nregs; i++) {
>> +		if (callee->regs[ret_regs[i]].type != PTR_TO_STACK)
>> +			continue;
>>   		/* technically it's ok to return caller's stack pointer
>>   		 * (or caller's caller's pointer) back to the caller,
>>   		 * since these pointers are valid. Only current stack
> The new R0:R2 return-register loop is placed before the
> 'if (callee->in_callback_fn)' branch, so it runs for callback frames as
> well. A callback follows bpf_callback_t (return value in R0 only) and R2
> holds an incoming argument: set_loop_callback_state() and
> set_user_ringbuf_callback_state() both do
> 'callee->regs[BPF_REG_2] = caller->regs[BPF_REG_3]', i.e. the
> callback_ctx, which is PTR_TO_STACK for the common
> 'bpf_loop(n, cb, &local_var, 0)' idiom.
>
> bpf_compute_subprog_ret_regs() sets ret_reg_pair purely from the
> subprog's BTF return type and iterates every subprog, with no exclusion
> for subprogs used as callbacks. So a static subprog whose BTF declares a
> 9..16 byte return and which is passed to bpf_loop() or
> bpf_user_ringbuf_drain() gets ret_reg_pair = true, and at its BPF_EXIT
> the still-live callback_ctx in R2 is inspected as if it were the upper
> half of a return value.
>
> Consequence: the callback exit is rejected with 'cannot return stack
> pointer to the caller', a diagnostic that points at a register holding an
> argument rather than a return value, and it fires before the
> in_callback_fn R0 checks that would otherwise produce the accurate
> message. Impact is limited (any such program is already ill-typed with
> respect to bpf_callback_t, and compiler-generated code for a 16-byte
> return does write R2), so this is a misleading-rejection /
> modelling-scope defect rather than a memory-safety bug.
>
> Would it make sense to compute nregs after the in_callback_fn branch, or
> force nregs = 1 when callee->in_callback_fn, since a callback frame has
> no R0:R2 return convention?

The current callback function only returns one register. If the bpf
prog intends to return two registers, the upper R2 register is ignored.
The result may be incorrect. It is bpf prog users' problem.

>
>> @@ -9897,8 +9910,12 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>>   			return -EFAULT;
>>   		}
>>   	} else {
>> -		/* return to the caller whatever r0 had in the callee */
>> -		caller->regs[BPF_REG_0] = *r0;
>> +		/*
>> +		 * return to the caller whatever the callee had in the
>> +		 * return register(s)
>> +		 */
>> +		for (i = 0; i < nregs; i++)
>> +			caller->regs[ret_regs[i]] = callee->regs[ret_regs[i]];
>>   	}
> prepare_func_exit() has three call sites, and only the real BPF_EXIT one
> (process_bpf_exit_full()) establishes the callee's return registers. The
> other two are synthetic exits that explicitly set up R0 but not R2,
> because R1-R5 were already reset to NOT_INIT above them:
>
> In check_helper_call(), BPF_FUNC_tail_call inside a subprog: the
> caller-saved reset loop sets R1-R5 to NOT_INIT, then only
> 'mark_reg_unknown(env, regs, BPF_REG_0)' runs before
> 'prepare_func_exit(env, &env->insn_idx)'.
>
> In check_ld_abs() hidden BPF_EXIT inside a subprog: reset loop, then only
> 'mark_reg_known_zero(env, regs, BPF_REG_0)' before prepare_func_exit().
>
> For a static subprog with ret_reg_pair set, the new copy loop therefore
> propagates a NOT_INIT R2 into caller->regs[BPF_REG_2] on those paths.
> This is fail-safe (no uninitialised value is treated as readable), but it
> means a caller that reads the upper half of the 16-byte return is
> rejected on that path with an opaque 'R2 !read_ok', so a subprog with a
>> 8 byte return that contains a bpf_tail_call() or LD_ABS is unverifiable,
> and only R0 gets the conservative unknown-scalar treatment the commit
> message describes.
>
> Would symmetric handling be to mark R2 unknown next to R0 at both sites
> (the tail-called program only defines R0, so R2 is genuinely undefined
> there), or to reject the combination with an explicit message?

Okay, this is related to tail call. The tail call prog expects to return
R0 only. If the bpf prog intends to return R0:R2 (similar to main program),
it is user's problem.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31740414277

