Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0B52989B0
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 04:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776744925; cv=none; b=lV1/ocu3tFvYsIhj0XVPTOneoJoxVMyg79sYQRGmiWiyzj1P+hMPbKazxsFKJxCi+EMtLUMV9ONo3UzREhGqw3BbbtaHFiSgJJMZXR3MnGStuGnH4qx1sO2hDQm1W/ljx625nawfOby5oDIiunt2uc9QgkdEmZ0G+v+AQ2VckoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776744925; c=relaxed/simple;
	bh=HlZcS+7drJ5Y0ZOwVmaR05uNc4S2Tce84y+aZ2QQNwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HTasXuKBtwJd7LVGn3dNeR5wCMTzScnn5QJJOTWfF4VqFz/V4wjVBnryg/JrWTEeGjeeZHeMQ5Ae3FbY1iK8D6QP3uKJbc9UidlSrIUlwVuxB0yifeA5Q6mVay2hqrZzQ8Brs7neNiyx/et3G6KHozYaeqwIas2UFrgf/Wwm8EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h4KWC3Or; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h4KWC3Or"
Message-ID: <e12c07df-b5d1-4d04-9028-23db01063138@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776744921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPXA1KymVxU4NwMQzNBTyzNjhWYYKFTKUkUyRMeLkRI=;
	b=h4KWC3OrmD75fe5SlJ4Sb04VTj+hend+kw2cWLj3Gt9qZoSj7Ue2PATad1eZ4jc5YyzJx9
	tWwM44Dnf97PU8p+4smoG336kGpOl8PaKj83XLPkGrjzZXe+XogbqH3rGBye3mPU9hP52B
	a9ImdRcAYDzJ0GBZnnCSikhQZttiigk=
Date: Mon, 20 Apr 2026 21:15:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 07/17] bpf: Support stack arguments for bpf
 functions
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260419163316.731019-1-yonghong.song@linux.dev>
 <20260419163352.734115-1-yonghong.song@linux.dev>
 <DHYEVJXVGHP5.2CAI5PGRI0W8E@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DHYEVJXVGHP5.2CAI5PGRI0W8E@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/20/26 5:37 PM, Alexei Starovoitov wrote:
> On Sun Apr 19, 2026 at 9:33 AM PDT, Yonghong Song wrote:
>> Currently BPF functions (subprogs) are limited to 5 register arguments.
>> With [1], the compiler can emit code that passes additional arguments
>> via a dedicated stack area through bpf register BPF_REG_PARAMS (r11),
>> introduced in the previous patch.
>>
>> The compiler uses positive r11 offsets for incoming (callee-side) args
>> and negative r11 offsets for outgoing (caller-side) args, following the
>> x86_64/arm64 calling convention direction. There is an 8-byte gap at
>> offset 0 separating the two regions:
>>    Incoming (callee reads):   r11+8 (arg6), r11+16 (arg7), ...
>>    Outgoing (caller writes):  r11-8 (arg6), r11-16 (arg7), ...
> This part looks clean now.
>
>> A per-state bitmask out_stack_arg_mask tracks which outgoing stack arg
>> slots have been written on the current path. Each bit corresponds to
>> an outgoing slot index (bit 0 = r11-8 = arg6, bit 1 = r11-16 = arg7,
>> etc.). At a call site, the verifier checks that all slots required by
>> the callee have their corresponding mask bits set. This enables
>> precise per-path tracking: if one branch of a conditional writes arg6
>> but another does not, the mask correctly reflects the difference and
>> the verifier rejects the uninitialized path. The mask is included in
>> stack_arg_safe() so that states with different sets of initialized
>> slots are not incorrectly pruned together.
> But this part I don't understand.
> why do you need this bitmask?
> Even when they're written out of order stack_arg_depth is all you need.
> Then compare old->stack_arg_regs vs cur->stack_arg_regs.
> If one is not written its state will be NOT_INIT.
> so
>    *(u64 *)(r11 - 16) = r7;
>    // without *(u64 *)(r11 - 8) = r6;
>    call bar1;                // arg6 = r6, arg7 = r7
>
> will fail the verification.

I added bitmask to make it easy for early comparison for pruning
since maintenance of bitmask is light. But I think this probably
not necessary. Will remove.

>
>> @@ -1669,6 +1669,8 @@ struct bpf_prog_aux {
>>   	u32 max_pkt_offset;
>>   	u32 max_tp_access;
>>   	u32 stack_depth;
>> +	u16 incoming_stack_arg_depth;
>> +	u16 stack_arg_depth; /* both incoming and max outgoing of stack arguments */
> these two are ok. I'm assuming you don't want JIT to recompute them.
>
>>   	u32 id;
>>   	u32 func_cnt; /* used by non-func prog as the number of func progs */
>>   	u32 real_func_cnt; /* includes hidden progs, only used for JIT and freeing progs */
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 9fbbddc40d21..bb6d8cab3a35 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -372,6 +372,11 @@ struct bpf_func_state {
>>   	 * `stack`. allocated_stack is always a multiple of BPF_REG_SIZE.
>>   	 */
>>   	int allocated_stack;
>> +
>> +	u16 stack_arg_depth; /* Size of incoming + max outgoing stack args in bytes. */
>> +	u16 incoming_stack_arg_depth; /* Size of incoming stack args in bytes. */
> but incoming_stack_arg_depth looks odd.
>
> Callee should be accessing caller's stack_arg_depth and
> caller's stack_arg_regs.

Okay. Will reduce local caching and get the value from the caller.

>
>> +	u16 out_stack_arg_mask; /* Bitmask of outgoing stack arg slots that have been written. */
>> +	struct bpf_reg_state *stack_arg_regs; /* On-stack arguments */
>>   };
>>   
>>   #define MAX_CALL_FRAMES 8
>> @@ -508,6 +513,17 @@ struct bpf_verifier_state {
>>   	     iter < frame->allocated_stack / BPF_REG_SIZE;		\
>>   	     iter++, reg = bpf_get_spilled_reg(iter, frame, mask))
>>   
>> +#define bpf_get_spilled_stack_arg(slot, frame, mask)                   \
>> +	((((slot) < frame->stack_arg_depth / BPF_REG_SIZE) &&           \
>> +	  (frame->stack_arg_regs[slot].type != NOT_INIT))               \
>> +	 ? &frame->stack_arg_regs[slot] : NULL)
>> +
>> +/* Iterate over 'frame', setting 'reg' to either NULL or a spilled stack arg. */
>> +#define bpf_for_each_spilled_stack_arg(iter, frame, reg, mask)         \
>> +	for (iter = 0, reg = bpf_get_spilled_stack_arg(iter, frame, mask); \
>> +	     iter < frame->stack_arg_depth / BPF_REG_SIZE;              \
>> +	     iter++, reg = bpf_get_spilled_stack_arg(iter, frame, mask))
>> +
>>   #define bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, __mask, __expr)   \
>>   	({                                                               \
>>   		struct bpf_verifier_state *___vstate = __vst;            \
>> @@ -525,6 +541,11 @@ struct bpf_verifier_state {
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
>>   
>> @@ -739,10 +760,13 @@ struct bpf_subprog_info {
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
>> +	u16 outgoing_stack_arg_depth;
>> +	u16 max_out_stack_arg_depth;
> but you already have them in prog_aux?! another copy in bpf_subprog_info?!
> Remove one of them. JIT only need one set.

Okay.

>
>>   };
>>   
>>   struct bpf_verifier_env;
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index a62d78581207..c5f3aa05d5a3 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -7887,13 +7887,19 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
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
>> +		return -EINVAL;
>> +	}
>> +	if (is_global && nargs > MAX_BPF_FUNC_REG_ARGS) {
>> +		bpf_log(log, "Global function %s() with %d > %d args not supported.\n",
>>   			tname, nargs, MAX_BPF_FUNC_REG_ARGS);
>>   		return -EINVAL;
>>   	}
>> +	if (nargs > MAX_BPF_FUNC_REG_ARGS)
>> +		sub->incoming_stack_arg_depth = (nargs - MAX_BPF_FUNC_REG_ARGS) * BPF_REG_SIZE;
>> +
>>   	/* check that function is void or returns int, exception cb also requires this */
>>   	t = btf_type_by_id(btf, t->type);
>>   	while (btf_type_is_modifier(t))
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index fba9e8c00878..c4e0224ad2f2 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
>> @@ -1123,6 +1123,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>   
>>   		func[i]->aux->name[0] = 'F';
>>   		func[i]->aux->stack_depth = env->subprog_info[i].stack_depth;
>> +		func[i]->aux->incoming_stack_arg_depth = env->subprog_info[i].incoming_stack_arg_depth;
>> +		func[i]->aux->stack_arg_depth = env->subprog_info[i].incoming_stack_arg_depth +
>> +						env->subprog_info[i].outgoing_stack_arg_depth;
>>   		if (env->subprog_info[i].priv_stack_mode == PRIV_STACK_ADAPTIVE)
>>   			func[i]->aux->jits_use_priv_stack = true;
>>   
>> @@ -1301,8 +1304,10 @@ int bpf_jit_subprogs(struct bpf_verifier_env *env)
>>   	struct bpf_insn_aux_data *orig_insn_aux;
>>   	u32 *orig_subprog_starts;
>>   
>> -	if (env->subprog_cnt <= 1)
>> +	if (env->subprog_cnt <= 1) {
>> +		env->prog->aux->stack_arg_depth = env->subprog_info[0].outgoing_stack_arg_depth;
>>   		return 0;
>> +	}
>>   
>>   	prog = orig_prog = env->prog;
>>   	if (bpf_prog_need_blind(prog)) {
>> @@ -1378,9 +1383,20 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
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
>> +
>> +		if (subprog->max_out_stack_arg_depth > subprog->outgoing_stack_arg_depth) {
>> +			verbose(env,
>> +				"func#%d writes stack arg slot at depth %u, but calls only require %u bytes\n",
>> +				i, subprog->max_out_stack_arg_depth, subprog->outgoing_stack_arg_depth);
>> +			return -EINVAL;
>> +		}
>> +	}
>>   
>>   	if (env->prog->jit_requested &&
>>   	    !bpf_prog_is_offloaded(env->prog->aux)) {
>> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
>> index 8478d2c6ed5b..235841d23fe3 100644
>> --- a/kernel/bpf/states.c
>> +++ b/kernel/bpf/states.c
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
>> +
>> +	if (old->out_stack_arg_mask != cur->out_stack_arg_mask)
>> +		return false;
> shouldn't be neccessary.

Okay.

>
>> +
>> +	nslots = old->stack_arg_depth / BPF_REG_SIZE;
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
>> +
>> +	return true;
>> +}
>> +
>>   static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *cur,
>>   		    struct bpf_idmap *idmap)
>>   {
>> @@ -929,6 +967,9 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
>>   	if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
>>   		return false;
>>   
>> +	if (!stack_arg_safe(env, old, cur, &env->idmap_scratch, exact))
>> +		return false;
>> +
>>   	return true;
>>   }
>>   
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 6aa4dc161a56..78c9322870a5 100644
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
> copy is unnecessary.

Okay.

>
>> @@ -4220,6 +4254,13 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
>>   					}
>>   					if (type == STACK_INVALID && env->allow_uninit_stack)
>>   						continue;
>> +					/*
>> +					 * Cross-frame reads may hit slots poisoned by dead code elimination.
>> +					 * Static liveness can't track indirect references through pointers,
>> +					 * so allow the read conservatively.
>> +					 */
>> +					if (type == STACK_POISON && reg_state != state)
>> +						continue;
> wait what? Is this a real issue? Are you saying you have a test prog
> that passes FP derived pointers in arg 6, 7 and arg_tracking cannot detect it?
> Then it should be added properly in arg_tracking.
> This hack to allow reading poisoned slots is not ok.
> This is a serious issue.

Okay. The reason is that callee is not getting the proper state from caller.
I will do proper implementation here.

>
> pw-bot: cr

