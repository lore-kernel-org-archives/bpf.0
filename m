Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2387927FD75
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394828; cv=none; b=U1rR+ZhbWOI8f9acwgkTt0xgGtx3cW+ihMa1HqCDeOECyY1UE4Tw59VY4W34LKEtdco87mxjBAlpBKf1y2n9xAzPVzgVDmHIN/QyhofF5SGfE6kRCB64xB5CuWlqnfqYgo0RyFEwUuYGx0AAS+Eny3P51EED6gie7QB48YJZzxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394828; c=relaxed/simple;
	bh=GKAoa7pUyahBEdOPKbHQ/gfmK6YWIHAkNW4tChVUmtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZiEN2w000o8i0Q51iEqwJj4qCESe8893tMnVpmTOUGhuVl1syXAT7/A4Ym+xgawNRb6VQtkwpzPNYfA8gZDBPwvK/loNEa2D9jTMD9wBS/r+FfHTg0rR/rzqPNPaYizBgS4thOYMuhgJERjfzCrAeTDyNKSYmXbKo9RYflJn2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jklp+w98; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jklp+w98"
Message-ID: <29308729-2a9c-4a4e-9b4f-a92bd185ee22@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777394822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjL6ik1GTg3sGjYfU1dXKxrHuOo3x5XRWCxnakQn/dg=;
	b=jklp+w98bTMPJO1ZgN6LN4gbMJLg3bTtuT8V2DowhyIyE1P0jwKgC/F4tAl7OGb6FPia/3
	u/+Y8BRkqowwEMmyejYZ55PkUeGY1aqjdCqKVWZxCtPzNt4znQQ1/c9j9gAynKm6Z0r+Wt
	y4+8pkHmwrGgfgwMKFpogXGASn4e1DU=
Date: Tue, 28 Apr 2026 17:47:00 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 01/18] bpf: Support stack arguments for bpf
 functions
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260424171433.2034470-1-yonghong.song@linux.dev>
 <20260424171438.2034741-1-yonghong.song@linux.dev>
 <7a031b0dcbf54e34d6a6571256b1bb65b5617bcc.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <7a031b0dcbf54e34d6a6571256b1bb65b5617bcc.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/28/26 7:29 AM, Eduard Zingerman wrote:
> On Fri, 2026-04-24 at 10:14 -0700, Yonghong Song wrote:
>
> [...]
>
> I didn't see this in the patch, hence the question: should or should
> not this feature be privileged bpf only?

It is priviledged only. See add_subprog_and_kfunc().
both bpf-to-bpf call and kfunc requires bpf_capable.

>
> [...]
>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index d5b4303315dd..2cc349d7fc17 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
> [...]
>
>> @@ -508,6 +512,17 @@ struct bpf_verifier_state {
>>   	     iter < frame->allocated_stack / BPF_REG_SIZE;		\
>>   	     iter++, reg = bpf_get_spilled_reg(iter, frame, mask))
>>   
>> +#define bpf_get_spilled_stack_arg(slot, frame, mask)                   \
>> +	((((slot) < frame->out_stack_arg_depth / BPF_REG_SIZE) &&           \
>> +	  (frame->stack_arg_regs[slot].type != NOT_INIT))               \
>> +	 ? &frame->stack_arg_regs[slot] : NULL)
> can this be a static inline function?

We could but we have

#define bpf_get_spilled_reg(slot, frame, mask)                          \
         (((slot < frame->allocated_stack / BPF_REG_SIZE) &&             \
           ((1 << frame->stack[slot].slot_type[BPF_REG_SIZE - 1]) & (mask))) \
          ? &frame->stack[slot].spilled_ptr : NULL)

Should we do the same (as static inline function)?

>
>> +
>> +/* Iterate over 'frame', setting 'reg' to either NULL or a spilled stack arg. */
>> +#define bpf_for_each_spilled_stack_arg(iter, frame, reg, mask)         \
>> +	for (iter = 0, reg = bpf_get_spilled_stack_arg(iter, frame, mask); \
>> +	     iter < frame->out_stack_arg_depth / BPF_REG_SIZE;              \
>> +	     iter++, reg = bpf_get_spilled_stack_arg(iter, frame, mask))
>> +
>>   #define bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, __mask, __expr)   \
>>   	({                                                               \
>>   		struct bpf_verifier_state *___vstate = __vst;            \
>> @@ -525,6 +540,11 @@ struct bpf_verifier_state {
>>   					continue;                        \
>>   				(void)(__expr);                          \
>>   			}                                                \
>> +			bpf_for_each_spilled_stack_arg(___j, __state, __reg, __mask) { \
>> +				if (!__reg)                              \
>> +					continue;                        \
>> +				(void)(__expr);                          \
>> +			}						 \
>>   		}                                                        \
>>   	})
> Tangential nit: I think this macro is getting a bit too complicated,
> we might want to introduce some proper reg_state iterator at some
> point, e.g.:
>
>    struct ret_iter it = new_reg_iter(state);
>    while ((reg = next_reg(&it))) { ... }

You mean have a static function with proper arguments and do the above?
I guess can do a followup later to simplify it.

>
>
>>   
>> @@ -739,10 +759,13 @@ struct bpf_subprog_info {
>>   	bool keep_fastcall_stack: 1;
>>   	bool changes_pkt_data: 1;
>>   	bool might_sleep: 1;
>> -	u8 arg_cnt:3;
>> +	u8 arg_cnt:4;
>>   
>>   	enum priv_stack_mode priv_stack_mode;
>> -	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
>> +	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_ARGS];
>> +	u16 incoming_stack_arg_depth;
> Can this be inferred from arg_cnt?
> Also, the verifier keeps doing '/ BPF_REG_SIZE' on this number,
> would it be more convenient to keep it as count?

This should work. Let me try.

>
>> +	u16 stack_arg_depth; /* incoming + max outgoing */
>> +	u16 max_out_stack_arg_depth;
>>   };
>>   
>>   struct bpf_verifier_env;
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 77af44d8a3ad..cfb35a2decf6 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -7880,13 +7880,19 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>>   	}
>>   	args = (const struct btf_param *)(t + 1);
>>   	nargs = btf_type_vlen(t);
>> -	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
>> -		if (!is_global)
>> -			return -EINVAL;
>> -		bpf_log(log, "Global function %s() with %d > %d args. Buggy compiler.\n",
>> +	if (nargs > MAX_BPF_FUNC_ARGS) {
>> +		bpf_log(log, "Function %s() with %d > %d args not supported.\n",
>> +			tname, nargs, MAX_BPF_FUNC_ARGS);
> Nit: I'd report it as "kernel supports at-most %d parameters for regular functions, while function %s is declared to accept %d parameters"
>       just to make the rules a bit more explicit.

Okay.

>
>> +		return -EINVAL;
>> +	}
> [...]
>
>> @@ -1378,9 +1382,21 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
>>   	struct bpf_prog *prog = env->prog;
>>   	struct bpf_insn *insn = prog->insnsi;
>>   	bool has_kfunc_call = bpf_prog_has_kfunc_call(prog);
>> -	int i, depth;
>> +	int depth;
>>   #endif
>> -	int err = 0;
>> +	int i, err = 0;
>> +
>> +	for (i = 0; i < env->subprog_cnt; i++) {
>> +		struct bpf_subprog_info *subprog = &env->subprog_info[i];
>> +		u16 outgoing = subprog->stack_arg_depth - subprog->incoming_stack_arg_depth;
>> +
>> +		if (subprog->max_out_stack_arg_depth > outgoing) {
>> +			verbose(env,
>> +				"func#%d writes stack arg slot at depth %u, but calls only require %u bytes\n",
>> +				i, subprog->max_out_stack_arg_depth, outgoing);
>> +			return -EINVAL;
> Is this an internal error condition?
> If it is, maybe use verifier_bug()?

It is not. For example,

SEC("tc")
__description("stack_arg: write unused stack arg slot")
__failure
__msg("func#0 writes stack arg slot at depth 40, but calls only require 16 bytes")
__naked void stack_arg_write_unused_slot(void)
{
         asm volatile (
                 "r1 = 1;"
                 "r2 = 2;"
                 "r3 = 3;"
                 "r4 = 4;"
                 "r5 = 5;"
                 /* Write to offset -40, unused for the callee */
                 "*(u64 *)(r11 - 40) = 99;"
                 "*(u64 *)(r11 - 16) = 20;"
                 "*(u64 *)(r11 - 8) = 10;"
                 "call subprog_7args;"
                 "r0 = 0;"
                 "exit;"
                 ::: __clobber_all
         );
}

>
>> +		}
>> +	}
>>   
>>   	if (env->prog->jit_requested &&
>>   	    !bpf_prog_is_offloaded(env->prog->aux)) {
>> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
>> index 8478d2c6ed5b..3e59d1c3a726 100644
>> --- a/kernel/bpf/states.c
>> +++ b/kernel/bpf/states.c
>> @@ -838,6 +838,34 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
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
>> +	nslots = min(old->out_stack_arg_depth, cur->out_stack_arg_depth) / BPF_REG_SIZE;
> this is not safe, e.g. it will accept cur with one argument as
> equivalent for old with two arguments.

Good catch! Will fix.

>
>> +	for (i = 0; i < nslots; i++) {
>> +		struct bpf_reg_state *old_arg = &old->stack_arg_regs[i];
>> +		struct bpf_reg_state *cur_arg = &cur->stack_arg_regs[i];
>> +
>> +		if (old_arg->type == NOT_INIT && cur_arg->type == NOT_INIT)
>> +			continue;
>> +
>> +		if (exact == EXACT && old_arg->type != cur_arg->type)
>> +			return false;
>> +
>> +		if (!regsafe(env, old_arg, cur_arg, idmap, exact))
>> +			return false;
>> +	}
> regsafe() seem handles NOT_INIT and EXACT in the same way,
> I don't think there is a necessity to do the handling explicitly here.

I agree that NOT_INIT and EXACT tracks are redundant. I keep them there
for performance reason. But I guess the return is minimum, so I will just
do regsafe() then.

>
>> +
>> +	return true;
>> +}
>> +
> [...]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index ff6ff1c27517..bcf81692a22b 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -1361,6 +1361,18 @@ static int copy_stack_state(struct bpf_func_state *dst, const struct bpf_func_st
>>   		return -ENOMEM;
>>   
>>   	dst->allocated_stack = src->allocated_stack;
>> +
>> +	/* copy stack args state */
>> +	n = src->out_stack_arg_depth / BPF_REG_SIZE;
>> +	if (n) {
>> +		dst->stack_arg_regs = copy_array(dst->stack_arg_regs, src->stack_arg_regs, n,
>> +						 sizeof(struct bpf_reg_state),
>> +						 GFP_KERNEL_ACCOUNT);
>> +		if (!dst->stack_arg_regs)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	dst->out_stack_arg_depth = src->out_stack_arg_depth;
> Given that this is capped by 12, does it make sense to maintain the counter?
> It might be simpler to always allocate an array of 12 elements.

The number of stack arguments is most 7. So yes, we can do it.

>
>>   	return 0;
>>   }
> [...]
>
>> @@ -4417,6 +4446,109 @@ static int check_stack_write(struct bpf_verifier_env *env,
>>   	return err;
>>   }
>>   
>> +/*
>> + * Write a value to the outgoing stack arg area.
>> + * off is a negative offset from r11 (e.g. -8 for arg6, -16 for arg7).
>> + */
>> +static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_state *state,
>> +				 int off, int value_regno)
>> +{
> Nit: Maybe replace value_regno with pointer to a register state?
>       Just for consistency.

yes, we can do it.

>
>> +	int max_stack_arg_regs = MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS;
>> +	struct bpf_subprog_info *subprog = &env->subprog_info[state->subprogno];
>> +	int spi = -off / BPF_REG_SIZE - 1;
>> +	struct bpf_func_state *cur;
>> +	struct bpf_reg_state *arg;
>> +	int err;
>> +
>> +	if (spi >= max_stack_arg_regs) {
>> +		verbose(env, "stack arg write offset %d exceeds max %d stack args\n",
>> +			off, max_stack_arg_regs);
>> +		return -EINVAL;
>> +	}
>> +
>> +	err = grow_stack_arg_slots(env, state, -off);
>> +	if (err)
>> +		return err;
>> +
>> +	/* Track the max outgoing stack arg access depth. */
>> +	if (-off > subprog->max_out_stack_arg_depth)
>> +		subprog->max_out_stack_arg_depth = -off;
>> +
>> +	cur = env->cur_state->frame[env->cur_state->curframe];
>> +	if (value_regno >= 0) {
>> +		state->stack_arg_regs[spi] = cur->regs[value_regno];
> Nit: there is copy_register_state(), we should either use it here or
> drop it and replace with direct assignments everywhere.

Will use copy_register_state() to be consistant with our examples.

>
>> +	} else {
>> +		/* BPF_ST: store immediate, treat as scalar */
>> +		arg = &state->stack_arg_regs[spi];
>> +		arg->type = SCALAR_VALUE;
>> +		__mark_reg_known(arg, env->prog->insnsi[env->insn_idx].imm);
>> +	}
>> +	state->no_stack_arg_load = true;
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Read a value from the incoming stack arg area.
>> + * off is a positive offset from r11 (e.g. +8 for arg6, +16 for arg7).
>> + */
>> +static int check_stack_arg_read(struct bpf_verifier_env *env, struct bpf_func_state *state,
>> +				int off, int dst_regno)
>> +{
>> +	struct bpf_subprog_info *subprog = &env->subprog_info[state->subprogno];
>> +	struct bpf_verifier_state *vstate = env->cur_state;
>> +	int spi = off / BPF_REG_SIZE - 1;
>> +	struct bpf_func_state *caller, *cur;
>> +	struct bpf_reg_state *arg;
>> +
>> +	if (state->no_stack_arg_load) {
>> +		verbose(env, "r11 load must be before any r11 store or call insn\n");
>> +		return -EINVAL;
>> +	}
> I think the error message should be inverted, store should precede the load.
> But tbh, I'd drop it altogether, the check right below should be sufficient.

This is necessary. See

SEC("tc")
__description("stack_arg: r11 load after r11 store")
__failure
__msg("r11 load must be before any r11 store or call insn")
__naked void stack_arg_load_after_store(void)
{
         asm volatile (
                 "r1 = 1;"
                 "r2 = 2;"
                 "r3 = 3;"
                 "r4 = 4;"
                 "r5 = 5;"
                 "*(u64 *)(r11 - 8) = 6;"
                 "r0 = *(u64 *)(r11 + 8);"
                 "call subprog_6args;"
                 "exit;"
                 ::: __clobber_all
         );
}
         
SEC("tc")
__description("stack_arg: r11 load after a call")
__failure
__msg("r11 load must be before any r11 store or call insn")
__naked void stack_arg_load_after_call(void)
{
         asm volatile (
                 "call %[bpf_get_prandom_u32];"
                 "r0 = *(u64 *)(r11 + 8);"
                 "exit;"
                 :: __imm(bpf_get_prandom_u32)
                 : __clobber_all
         );
}

>
>> +
>> +	if (off > subprog->incoming_stack_arg_depth) {
>> +		verbose(env, "invalid read from stack arg off %d depth %d\n",
>> +			off, subprog->incoming_stack_arg_depth);
>> +		return -EACCES;
>> +	}

This is for this kind of failure:

SEC("tc")
__description("stack_arg: read from uninitialized stack arg slot")
__failure
__msg("invalid read from stack arg off 8 depth 0")
__naked void stack_arg_read_uninitialized(void)
{
         asm volatile (
                 "r0 = *(u64 *)(r11 + 8);"
                 "r0 = 0;"
                 "exit;"
                 ::: __clobber_all
         );
}

>> +
>> +	caller = vstate->frame[vstate->curframe - 1];
>> +	arg = &caller->stack_arg_regs[spi];
>> +	cur = vstate->frame[vstate->curframe];
>> +
>> +	if (is_spillable_regtype(arg->type))
>> +		copy_register_state(&cur->regs[dst_regno], arg);
>> +	else
>> +		mark_reg_unknown(env, cur->regs, dst_regno);
> For stack writes we report error in such situations,
> should the same be done here?

We should be fine here.

>
>> +	return 0;
>> +}
>> +
>> +static int check_outgoing_stack_args(struct bpf_verifier_env *env, struct bpf_func_state *caller,
>> +				     int nargs)
>> +{
>> +	int i, spi;
>> +
>> +	for (i = MAX_BPF_FUNC_REG_ARGS; i < nargs; i++) {
>> +		spi = i - MAX_BPF_FUNC_REG_ARGS;
>> +		if (spi >= (caller->out_stack_arg_depth / BPF_REG_SIZE) ||
>> +		    caller->stack_arg_regs[spi].type == NOT_INIT) {
>> +			verbose(env, "stack %s not properly initialized\n",
>> +				reg_arg_name(env, argno_from_arg(i + 1)));
> Nit: error message is a bit confusing, I'd change it to better reflect the rules, e.g.:
>       "function %s expects %d arguments, stack argument %d is not initialized".

Okay.

>
>> +			return -EFAULT;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
> [...]

