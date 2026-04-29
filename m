Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD67033ADB5
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 22:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777503178; cv=none; b=b/WVxs7RjIctNPnS2YY/4ben+vjSiSxJSBHrSGQXK4RoMq3WNWlwjuINdpdTMlva95zZB9RqMevmbodFKBzctUNLkuHK3mDKNssCypNI/H9+kW9mcRXmEDnTpCMaBz55ayamRKt1AeQEhlg4ern7YlUcedWRclbzRz5LcFX1sO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777503178; c=relaxed/simple;
	bh=EYYrVTjNm+BnkQzQSz045VK5iqaIo/uyZAUZrj2VOfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DiVL09lQGbKAj6ms64d6J2wufPJlTf2p9Y2iRgi5dSDLuWl6oaT4ZaCEBHVDiZOfxry1SA2Z9YI3YuYjNoS1m+/3Q1Tyg/N1th+CWpqkT43Gyl6/IkCN3c+WKs4Sth6unp344WSdlOjm1C7BAdsOTVeK4VOgelS5eK08HLIPpLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=amY2GTDE; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="amY2GTDE"
Message-ID: <6b9f2ad0-e46e-4a0e-b395-c0ca45bf682c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777503173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LyMTqE9Gz5GoMVwdUuSlCQbEcg7mY9BMbxKLYr61Jjc=;
	b=amY2GTDENHa4D5wZkhT+2xnNW0c2SDLorScM460/J9r8ND4LQWoijQCKgzdS8V+wCtCKR7
	zc+h6M7Od6ZpMu2VgA0Y6bZXxkaxRaMCmyEzA8baOIbxlwxwi6Q0/b/wNF5Q6mjBB5GO8w
	ndnzLbkz1iNsYyLedKGId9DtMTtgF7Y=
Date: Wed, 29 Apr 2026 23:52:51 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 01/18] bpf: Support stack arguments for bpf
 functions
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260424171433.2034470-1-yonghong.song@linux.dev>
 <20260424171438.2034741-1-yonghong.song@linux.dev>
 <7a031b0dcbf54e34d6a6571256b1bb65b5617bcc.camel@gmail.com>
 <29308729-2a9c-4a4e-9b4f-a92bd185ee22@linux.dev>
 <abe6e8e7a0ac5d4c1fbbf35643577d53db81e891.camel@gmail.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <abe6e8e7a0ac5d4c1fbbf35643577d53db81e891.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/29/26 1:28 AM, Eduard Zingerman wrote:
> On Tue, 2026-04-28 at 17:47 +0100, Yonghong Song wrote:
>> On 4/28/26 7:29 AM, Eduard Zingerman wrote:
>>> On Fri, 2026-04-24 at 10:14 -0700, Yonghong Song wrote:
>>>
>>> [...]
>>>
>>> I didn't see this in the patch, hence the question: should or should
>>> not this feature be privileged bpf only?
>> It is priviledged only. See add_subprog_and_kfunc().
>> both bpf-to-bpf call and kfunc requires bpf_capable.
> I see, thank you.
>
>>> [...]
>>>
>>>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>>>> index d5b4303315dd..2cc349d7fc17 100644
>>>> --- a/include/linux/bpf_verifier.h
>>>> +++ b/include/linux/bpf_verifier.h
>>> [...]
>>>
>>>> @@ -508,6 +512,17 @@ struct bpf_verifier_state {
>>>>    	     iter < frame->allocated_stack / BPF_REG_SIZE;		\
>>>>    	     iter++, reg = bpf_get_spilled_reg(iter, frame, mask))
>>>>    
>>>> +#define bpf_get_spilled_stack_arg(slot, frame, mask)                   \
>>>> +	((((slot) < frame->out_stack_arg_depth / BPF_REG_SIZE) &&           \
>>>> +	  (frame->stack_arg_regs[slot].type != NOT_INIT))               \
>>>> +	 ? &frame->stack_arg_regs[slot] : NULL)
>>> can this be a static inline function?
>> We could but we have
>>
>> #define bpf_get_spilled_reg(slot, frame, mask)                          \
>>           (((slot < frame->allocated_stack / BPF_REG_SIZE) &&             \
>>             ((1 << frame->stack[slot].slot_type[BPF_REG_SIZE - 1]) & (mask))) \
>>            ? &frame->stack[slot].spilled_ptr : NULL)
>>
>> Should we do the same (as static inline function)?
> I think so, yes.
>
>>>> +/* Iterate over 'frame', setting 'reg' to either NULL or a spilled stack arg. */
>>>> +#define bpf_for_each_spilled_stack_arg(iter, frame, reg, mask)         \
>>>> +	for (iter = 0, reg = bpf_get_spilled_stack_arg(iter, frame, mask); \
>>>> +	     iter < frame->out_stack_arg_depth / BPF_REG_SIZE;              \
>>>> +	     iter++, reg = bpf_get_spilled_stack_arg(iter, frame, mask))
>>>> +
>>>>    #define bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, __mask, __expr)   \
>>>>    	({                                                               \
>>>>    		struct bpf_verifier_state *___vstate = __vst;            \
>>>> @@ -525,6 +540,11 @@ struct bpf_verifier_state {
>>>>    					continue;                        \
>>>>    				(void)(__expr);                          \
>>>>    			}                                                \
>>>> +			bpf_for_each_spilled_stack_arg(___j, __state, __reg, __mask) { \
>>>> +				if (!__reg)                              \
>>>> +					continue;                        \
>>>> +				(void)(__expr);                          \
>>>> +			}						 \
>>>>    		}                                                        \
>>>>    	})
>>> Tangential nit: I think this macro is getting a bit too complicated,
>>> we might want to introduce some proper reg_state iterator at some
>>> point, e.g.:
>>>
>>>     struct ret_iter it = new_reg_iter(state);
>>>     while ((reg = next_reg(&it))) { ... }
>> You mean have a static function with proper arguments and do the above?
>> I guess can do a followup later to simplify it.
> Yes, a structure describing an iterator over all
> registers/spills/stack-based arguments and to functions:
> one for initialization and one for moving the iterator.
>
> [...]
>
>>>> @@ -1378,9 +1382,21 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
>>>>    	struct bpf_prog *prog = env->prog;
>>>>    	struct bpf_insn *insn = prog->insnsi;
>>>>    	bool has_kfunc_call = bpf_prog_has_kfunc_call(prog);
>>>> -	int i, depth;
>>>> +	int depth;
>>>>    #endif
>>>> -	int err = 0;
>>>> +	int i, err = 0;
>>>> +
>>>> +	for (i = 0; i < env->subprog_cnt; i++) {
>>>> +		struct bpf_subprog_info *subprog = &env->subprog_info[i];
>>>> +		u16 outgoing = subprog->stack_arg_depth - subprog->incoming_stack_arg_depth;
>>>> +
>>>> +		if (subprog->max_out_stack_arg_depth > outgoing) {
>>>> +			verbose(env,
>>>> +				"func#%d writes stack arg slot at depth %u, but calls only require %u bytes\n",
>>>> +				i, subprog->max_out_stack_arg_depth, outgoing);
>>>> +			return -EINVAL;
>>> Is this an internal error condition?
>>> If it is, maybe use verifier_bug()?
>> It is not. For example,
>>
>> SEC("tc")
>> __description("stack_arg: write unused stack arg slot")
>> __failure
>> __msg("func#0 writes stack arg slot at depth 40, but calls only require 16 bytes")
>> __naked void stack_arg_write_unused_slot(void)
>> {
>>           asm volatile (
>>                   "r1 = 1;"
>>                   "r2 = 2;"
>>                   "r3 = 3;"
>>                   "r4 = 4;"
>>                   "r5 = 5;"
>>                   /* Write to offset -40, unused for the callee */
>>                   "*(u64 *)(r11 - 40) = 99;"
>>                   "*(u64 *)(r11 - 16) = 20;"
>>                   "*(u64 *)(r11 - 8) = 10;"
>>                   "call subprog_7args;"
>>                   "r0 = 0;"
>>                   "exit;"
>>                   ::: __clobber_all
>>           );
>> }
> But this is a very partial check, the max_out_stack_arg_depth is
> computed per-subprogram, not per-call. As far as I understand the
> design, it can't be computed per-call at all. Meaning that if there
> are, say, two calls:
> - foo(1,2,3,4,5,6,7)   // where foo expects only 6 parameters
> - bar(1,2,3,4,5,6,7,8) // where bar expects only 7 parameters
>
> In this case:
> - Verifier won't know which of the two calls is bogus, so won't be
>    able to point user to the instruction where error occurs.
> - This is not a safety condition, meaning that kernel state is not
>    broken if more arguments are pushed onto stack (and if it *is* a
>    safety condition, then we need to figure out something two check
>    both calls above).

You are right in the sense, we do not reject at any callsite
since we do not know whether it is exclusively used or shared.
For example,
    *(u64 *)(r11 - 24) = ...;
    if (...) {
      *(u64 *)(r11 - 16) = ...;
      *(u64 *)(r11 - 8) = ...;
      subprog_7args;
    } else {
      ...
    }

We cannot warn at subprog_7args() since it is not clear
whether '*(u64 *)(r11 - 24) = ...' is exclusively used
by subprog_7args or other, unless we keep track of
stack arguments. but I think this is not needed.

The above check is in function bpf_fixup_call_args()
where all subprog's have been processed. So we know
*maximum* stack arg count, e.g.,
     subprog_7args()
     subprog_9args()
We now the maximum stack argument count is 4 and
this maximum stack argument count will be used in jit.

If we see '*(u64 *)(r11 - 40)', we will know it will
not be used for any kfunc or bpf functions.

This is a little bit tying to JIT implementation.
In JIT, the stack args (excepting the first few based
on arch ABI) will consume some stack slot based on
native arch calling convention. for example, for x86_64,

       high address
       +-------------------------+
       | incoming stack arg N    |  [rbp + 16 + (N-7)*8]  (from caller)
       | ...                     |
       | incoming stack arg 7    |  [rbp + 16]
       +-------------------------+
       | return address          |  [rbp + 8]
       | saved rbp               |  [rbp]
       +-------------------------+
       | BPF program stack       |  (round_up(stack_depth, 8) bytes)
       +-------------------------+
       | callee-saved regs       |  (r12, rbx, r13, r14, r15 as needed)
       +-------------------------+
       | outgoing arg M          |  [rsp + (M-7)*8]
       | ...                     |
       | outgoing arg 7          |  [rsp]
       +-------------------------+  rsp
       low address

The native off is:
	native_off = outgoing_arg_base - outgoing_rsp - bpf_off - 16

So
   r11 - 8:   r9 = <...>
   r11 - 16:  outgoing arg 7
              native_off = outgoing_arg_base - outgoing_rsp
   r11 - 24:  outgoing arg 8:
              native_off = outgoing_arg_base - outgoing_rsp + 8
   r11 - 32:  outgoing arg 9:
              native_off = outgoing_arg_base - outgoing_rsp + 16

Then we have
   r11 - 40: native_off = outgoing_arg_base - outgoing_rsp + 24

This will have a problem as it may overwrite callee-saved regs.
So we need to reject it.

>    
> Thus, I'd suggest not to check this property at all.
>
> [...]
>
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -1361,6 +1361,18 @@ static int copy_stack_state(struct bpf_func_state *dst, const struct bpf_func_st
>>>>    		return -ENOMEM;
>>>>    
>>>>    	dst->allocated_stack = src->allocated_stack;
>>>> +
>>>> +	/* copy stack args state */
>>>> +	n = src->out_stack_arg_depth / BPF_REG_SIZE;
>>>> +	if (n) {
>>>> +		dst->stack_arg_regs = copy_array(dst->stack_arg_regs, src->stack_arg_regs, n,
>>>> +						 sizeof(struct bpf_reg_state),
>>>> +						 GFP_KERNEL_ACCOUNT);
>>>> +		if (!dst->stack_arg_regs)
>>>> +			return -ENOMEM;
>>>> +	}
>>>> +
>>>> +	dst->out_stack_arg_depth = src->out_stack_arg_depth;
>>> Given that this is capped by 12, does it make sense to maintain the counter?
>>> It might be simpler to always allocate an array of 12 elements.
>> The number of stack arguments is most 7. So yes, we can do it.
> Note from a short discussion with Alexei today:
> he does not think this is a big deal and also thinks that saving some
> space by allocating this array only when necessary would be a plus.
> I, on the other hand, still think that growing this dynamically is an
> over-complication.
>
> [...]
>
>>>> @@ -4417,6 +4446,109 @@ static int check_stack_write(struct bpf_verifier_env *env,
>>>>    	return err;
>>>>    }
>>>>    
>>>> +/*
>>>> + * Write a value to the outgoing stack arg area.
>>>> + * off is a negative offset from r11 (e.g. -8 for arg6, -16 for arg7).
>>>> + */
>>>> +static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_state *state,
> [...]
>
>>>> +	/* Track the max outgoing stack arg access depth. */
>>>> +	if (-off > subprog->max_out_stack_arg_depth)
>>>> +		subprog->max_out_stack_arg_depth = -off;
>>>> +
>>>> +	cur = env->cur_state->frame[env->cur_state->curframe];
>>>> +	if (value_regno >= 0) {
>>>> +		state->stack_arg_regs[spi] = cur->regs[value_regno];
>>> Nit: there is copy_register_state(), we should either use it here or
>>> drop it and replace with direct assignments everywhere.
>> Will use copy_register_state() to be consistant with our examples.
> It is a second time the issue is raised on the mailing list,
> so it might be worth it to have a small preparatory patch removing
> this function. It had a non-empty body once but now it is truly
> useless. Wdyt?

Sure. Will do.

>
> [...]
>
>>>> +/*
>>>> + * Read a value from the incoming stack arg area.
>>>> + * off is a positive offset from r11 (e.g. +8 for arg6, +16 for arg7).
>>>> + */
>>>> +static int check_stack_arg_read(struct bpf_verifier_env *env, struct bpf_func_state *state,
>>>> +				int off, int dst_regno)
>>>> +{
>>>> +	struct bpf_subprog_info *subprog = &env->subprog_info[state->subprogno];
>>>> +	struct bpf_verifier_state *vstate = env->cur_state;
>>>> +	int spi = off / BPF_REG_SIZE - 1;
>>>> +	struct bpf_func_state *caller, *cur;
>>>> +	struct bpf_reg_state *arg;
>>>> +
>>>> +	if (state->no_stack_arg_load) {
>>>> +		verbose(env, "r11 load must be before any r11 store or call insn\n");
>>>> +		return -EINVAL;
>>>> +	}
>>> I think the error message should be inverted, store should precede the load.
>>> But tbh, I'd drop it altogether, the check right below should be sufficient.
>> This is necessary. See
>>
>> SEC("tc")
>> __description("stack_arg: r11 load after r11 store")
>> __failure
>> __msg("r11 load must be before any r11 store or call insn")
>> __naked void stack_arg_load_after_store(void)
>> {
>>           asm volatile (
>>                   "r1 = 1;"
>>                   "r2 = 2;"
>>                   "r3 = 3;"
>>                   "r4 = 4;"
>>                   "r5 = 5;"
>>                   "*(u64 *)(r11 - 8) = 6;"
>>                   "r0 = *(u64 *)(r11 + 8);"
>>                   "call subprog_6args;"
>>                   "exit;"
>>                   ::: __clobber_all
>>           );
>> }
>>           
>> SEC("tc")
>> __description("stack_arg: r11 load after a call")
>> __failure
>> __msg("r11 load must be before any r11 store or call insn")
>> __naked void stack_arg_load_after_call(void)
>> {
>>           asm volatile (
>>                   "call %[bpf_get_prandom_u32];"
>>                   "r0 = *(u64 *)(r11 + 8);"
>>                   "exit;"
>>                   :: __imm(bpf_get_prandom_u32)
>>                   : __clobber_all
>>           );
>> }
>>
>>>> +
>>>> +	if (off > subprog->incoming_stack_arg_depth) {
>>>> +		verbose(env, "invalid read from stack arg off %d depth %d\n",
>>>> +			off, subprog->incoming_stack_arg_depth);
>>>> +		return -EACCES;
>>>> +	}
>> This is for this kind of failure:
>>
>> SEC("tc")
>> __description("stack_arg: read from uninitialized stack arg slot")
>> __failure
>> __msg("invalid read from stack arg off 8 depth 0")
>> __naked void stack_arg_read_uninitialized(void)
>> {
>>           asm volatile (
>>                   "r0 = *(u64 *)(r11 + 8);"
>>                   "r0 = 0;"
>>                   "exit;"
>>                   ::: __clobber_all
>>           );
>> }
> Consider your first example:
>
>      > __naked void stack_arg_load_after_store(void)
>      > {
>      >          asm volatile (
>      >                  "r1 = 1;"
>      >                  "r2 = 2;"
>      >                  "r3 = 3;"
>      >                  "r4 = 4;"
>      >                  "r5 = 5;"
>      >                  "*(u64 *)(r11 - 8) = 6;"
>      >                  "r0 = *(u64 *)(r11 + 8);"
>                                       ^^^^^^^^^
> wouldn't the second check 'if (off > subprog->incoming_stack_arg_depth)...'
> be triggered here?
>
>      >                  "call subprog_6args;"
>      >                  "exit;"
>      >                  ::: __clobber_all
>      >          );
>      > }

In this case, you are right. I need to have a different inline asm to
have a caller having one stack arguments.

>
>>>> +	caller = vstate->frame[vstate->curframe - 1];
>>>> +	arg = &caller->stack_arg_regs[spi];
>>>> +	cur = vstate->frame[vstate->curframe];
>>>> +
>>>> +	if (is_spillable_regtype(arg->type))
>>>> +		copy_register_state(&cur->regs[dst_regno], arg);
>>>> +	else
>>>> +		mark_reg_unknown(env, cur->regs, dst_regno);
>>> For stack writes we report error in such situations,
>>> should the same be done here?
>> We should be fine here.
> This is not a bug, sure, but it would be nice to have consistent
> behavior for similar situations.

Okay, I figured out a better solution like below:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2f412128d76a..5fa16287353c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4159,11 +4159,7 @@ static int check_stack_arg_read(struct bpf_verifier_env *env, struct bpf_func_st
         caller = vstate->frame[vstate->curframe - 1];
         arg = &caller->stack_arg_regs[spi];
         cur = vstate->frame[vstate->curframe];
-
-       if (is_spillable_regtype(arg->type))
-               copy_register_state(&cur->regs[dst_regno], arg);
-       else
-               mark_reg_unknown(env, cur->regs, dst_regno);
+       copy_register_state(&cur->regs[dst_regno], arg);
         return bpf_push_jmp_history(env, env->cur_state,
                                     insn_stack_arg_access_flags(state->frameno, spi), 0);
  }

and

@@ -952,7 +951,8 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
         if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
                 return false;
  
-       if (!stack_arg_safe(env, old, cur, &env->idmap_scratch, exact))
+       if (!stack_arg_safe(env, old, cur, &env->idmap_scratch,
+                           exact == NOT_EXACT ? RANGE_WITHIN : exact))
                 return false;

<btw, copy_register_state() will be replaced with simple assignment aftre refactoring>

In stack_arg_safe, with NOT_EXACT seems not enough for precision tracking, so
using RANGE_WITHIN can ensure proper pruning.


