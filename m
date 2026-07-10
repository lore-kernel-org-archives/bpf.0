Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA529175A72
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 04:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783659489; cv=none; b=SfM18FgXnyV73pmSyrmWxcBPikK+m5TgheR+AJ0LRgLgFrtemrv0skn1FezMEQHcybwd+Zi7axbP1qDzvlE+bw/X3c3U0lexaPnqsgPPzM0EwWIAteUJhMVidmeuSUyxBpNIA7jEHyZKArjUzaMlA4DEpKvPZ5Ru3dxcrV0Htvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783659489; c=relaxed/simple;
	bh=P1UMRzs9QLebyk5H/EnBcVn9YsazciMm4Zr7HdyRLSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5o8jSjVbHfkNbCQ39nyP8d751ACdzlss2avnXViweirEJR6EFAh9VkBBXSM8S12aL4h5Z0i28A6grGUdD2aziPgYNM5FKLFrxXyUc7aR98T8OquDn9neJ/zZdYhurXzTFDgOJ7edf9BWlAR1p2TGh/H6rqLx0Fs3+wd29Wi8xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EreZvzcz; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EreZvzcz"
Message-ID: <afd1fcb8-e091-4fa8-8c2c-f52f495ed329@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783659484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/oquhOVHsPDAAPeKkJfF7eXDH8t5W8dd3Bt7/Cmyw4=;
	b=EreZvzczk5SKj7z2U+TVFaCW+N5xFwGNxRwXIycQd8XkBzoZ6mdsF035lTx50ctR1qhmtW
	2Y3w0JDdsOih5mrXHMQP+wJ6Ho8QAgIWvbAg1c/iI1u4uyDtYScnovrUetom9C+/CXd1fa
	FKQ9NKwWY9xeprKEtXzrPykozJ1LZuI=
Date: Thu, 9 Jul 2026 21:57:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 02/12] bpf: Add verifier support for 16-byte
 returns in R0:R2
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
 <20260708200949.2156169-1-yonghong.song@linux.dev>
 <ea6bd9922125d2e3967dae33a686cd7e42830b73.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ea6bd9922125d2e3967dae33a686cd7e42830b73.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/9/26 3:21 PM, Eduard Zingerman wrote:
> On Wed, 2026-07-08 at 13:09 -0700, Yonghong Song wrote:
>> LLVM 23 added support for returning a value in two registers for an
>> __int128, or a struct/union whose size is greater than 8 but not more
>> than 16 bytes. See LLVM patches [1] and [2].
>>
>> Before LLVM 23 the BPF backend could not return these values at all. A
>> by-value struct or union return (of any size) was rejected at compile
>> time with:
>>
>>    error: aggregate returns are not supported
>>
>> and an __int128 return failed later in the backend with:
>>
>>    fatal error: error in backend: unable to allocate function return #1
>>
>> Both are resolved in LLVM 23, which lowers such returns into the R0:R2
>> register pair.
>>
>> This patch is one of several preparation patches that build up
>> <=16 byte return support incrementally:
>>    - the verifier R0:R2 modelling in this patch,
>>    - the x86 JIT move and JIT-capability gate,
>>    - precision-backtracking and live-register tracking of R2,
>>    - forcing the JIT for such programs, and
>>    - guarding the trampoline paths.
>> Finally, the patch "bpf: Enable 16-byte aggregate return types" enables
>> support for 16-byte returns.
> Nit: I think the above paragraphs belong to a cover letter.

Will add this to the cover letter.

>
>> This patch adds handling for '>8' byte returns in several places: BPF
>> subprogram returns (the main program, and both global and static
>> subprograms) and kfunc returns.
>>
>>    [1] https://github.com/llvm/llvm-project/pull/190894
>>    [2] https://github.com/llvm/llvm-project/pull/206876
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   kernel/bpf/verifier.c | 93 ++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 88 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 3f34ce1a3107..03ffb5f839fa 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -424,6 +424,35 @@ static bool subprog_returns_void(struct bpf_verifier_env *env, int subprog)
>>   	return btf_type_is_void(type);
>>   }
>>   
>> +static bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int subprog)
>> +{
>> +	const struct btf_type *type, *func, *func_proto;
>> +	const struct btf *btf = env->prog->aux->btf;
>> +	u32 btf_id;
>> +
>> +	if (!btf || !env->prog->aux->func_info)
>> +		return false;
>> +
>> +	btf_id = env->prog->aux->func_info[subprog].type_id;
>> +
>> +	func = btf_type_by_id(btf, btf_id);
>> +	if (!func)
>> +		return false;
> `if (!func) return false` checks here and below are not necessary
> after BTF validation.

Ack. Will remove them.

>
>> +
>> +	func_proto = btf_type_by_id(btf, func->type);
>> +	if (!func_proto)
>> +		return false;
>> +
>> +	type = btf_type_skip_modifiers(btf, func_proto->type, NULL);
>> +	if (!type)
>> +		return false;
>> +
>> +	if (btf_type_is_struct(type) || btf_type_is_scalar(type))
>> +		return type->size > 8 && type->size <= 16;
>> +
>> +	return false;
>> +}
>> +
>>   static const char *subprog_name(const struct bpf_verifier_env *env, int subprog)
>>   {
>>   	struct bpf_func_info *info;
>> @@ -9459,10 +9488,17 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   		clear_caller_saved_regs(env, caller->regs);
>>   		invalidate_outgoing_stack_args(env, cur_func(env));
>>   
>> -		/* All non-void global functions return a 64-bit SCALAR_VALUE. */
>> +		/*
>> +		 * A non-void global function returns a 64-bit SCALAR_VALUE in
>> +		 * R0, or a >8 byte SCALAR_VALUE in the R0:R2 register pair.
>> +		 */
>>   		if (!subprog_returns_void(env, subprog)) {
>>   			mark_reg_unknown(env, caller->regs, BPF_REG_0);
>>   			caller->regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
>> +			if (bpf_ret_reg_pair(env, subprog)) {
>> +				mark_reg_unknown(env, caller->regs, BPF_REG_2);
>> +				caller->regs[BPF_REG_2].subreg_def = DEF_NOT_SUBREG;
>> +			}
>>   		}
>>   
>>   		if (env->subprog_info[subprog].might_throw) {
>> @@ -9825,6 +9861,13 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>>   	} else {
>>   		/* return to the caller whatever r0 had in the callee */
>>   		caller->regs[BPF_REG_0] = *r0;
>> +		if (bpf_ret_reg_pair(env, callee->subprogno)) {
>> +			if (callee->regs[BPF_REG_2].type == PTR_TO_STACK) {
> Let's consolidate all such checks in one place and not copy-paste them.

Will try to consolidate them together.

>
>> +				verbose(env, "cannot return stack pointer to the caller\n");
>> +				return -EINVAL;
>> +			}
>> +			caller->regs[BPF_REG_2] = callee->regs[BPF_REG_2];
>> +		}
>>   	}
>>   
>>   	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to callsite,
>> @@ -10745,6 +10788,18 @@ static void mark_btf_func_reg_size(struct bpf_verifier_env *env, u32 regno,
>>   	return __mark_btf_func_reg_size(env, cur_regs(env), regno, reg_size);
>>   }
>>   
>> +static void mark_kfunc_ret_reg_size(struct bpf_verifier_env *env,
>> +				    struct bpf_reg_state *regs, u32 size)
>> +{
>> +	if (size > 8) {
>> +		mark_btf_func_reg_size(env, BPF_REG_0, 8);
>> +		mark_reg_unknown(env, regs, BPF_REG_2);
>> +		regs[BPF_REG_2].subreg_def = DEF_NOT_SUBREG;
>> +	} else {
>> +		mark_btf_func_reg_size(env, BPF_REG_0, size);
>> +	}
>> +}
> This function makes R2 handling very asymmetric compared to R0:
> - mark_reg_unknown() for r0 is done in check_kfunc_call()
> - DEF_NOT_SUBREG for r0 is done in mark_btf_func_reg_size()
>
> I think the code should be structured to keep R0 and R2 processing
> uniform.

Ack

>
>> +
>>   static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
>>   {
>>   	return meta->kfunc_flags & KF_ACQUIRE;
>> @@ -13208,7 +13263,22 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   		if (meta.btf == btf_vmlinux && (meta.func_id == special_kfunc_list[KF_bpf_res_spin_lock] ||
>>   		    meta.func_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave]))
>>   			__mark_reg_const_zero(env, &regs[BPF_REG_0]);
>> -		mark_btf_func_reg_size(env, BPF_REG_0, t->size);
>> +		mark_kfunc_ret_reg_size(env, regs, t->size);
>> +	} else if (btf_type_is_struct(t)) {
>> +		/*
>> +		 * The returned struct comes back as raw register bits modeled
>> +		 * as an unknown scalar, so it must contain only scalars:
>> +		 * otherwise a pointer field would be laundered into a scalar
>> +		 * and escape provenance and reference tracking.
>> +		 */
>> +		if (!__btf_type_is_scalar_struct(env, desc_btf, t, 0)) {
>> +			verbose(env, "kernel function %s returns %s %s that is not composed of scalars\n",
>> +				func_name, btf_type_str(t),
>> +				btf_name_by_offset(desc_btf, t->name_off));
> Should this also check the size of the struct?

Later on, there is a size condition for struct (<= 16), so we should be okay here.

>
>> +			return -EINVAL;
>> +		}
>> +		mark_reg_unknown(env, regs, BPF_REG_0);
>> +		mark_kfunc_ret_reg_size(env, regs, t->size);
>>   	} else if (btf_type_is_ptr(t)) {
>>   		ptr_type = btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
>>   		err = check_special_kfunc(env, &meta, regs, insn_aux, ptr_type, desc_btf);
> [...]

