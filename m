Received: from mta1.migadu.com (out-138.mta1.migadu.com [95.215.58.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CBD4B04A3
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 03:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786937165; cv=none; b=eCU8hLxKzgX9YmUN006SFV0jCvq7bIYa3jNlF42qg4m8P9GgF9amqOQT0rq/O6D2GFv1o7//4bvIbyzNXiiJWF+ugi2ZGlcEliWCVNCluitIh9Jab8tl3AEdQvjQNxIdl2v3Ot9e9/3OAEaxqYraGxWtHOK3+5NQhiysDeuXHKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786937165; c=relaxed/simple;
	bh=dKdFh370qX/gR5MA0ABkPuW+ck5oud+iawGzj+U0BQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BR0qbfVgo1R8Cfnu7OcK7Fn3XHXZ1jTFGeXRPLNV6hZ5JIopTXW1TR5T2xHLXv+WSGD5RCByGv/R8iPqQm5XwnazbaODb/BH32P5LlquiQ7LNC9w9ZOPN1EQpcSr+hb9eZalMWUXhs+R7MyNj/tq28aG3Kqnoj0H9c1r+vw6j3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v0lTvAlc; arc=none smtp.client-ip=95.215.58.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v0lTvAlc"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dKdFh370qX/gR5MA0ABkPuW+ck5oud+iawGzj+U0BQg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786937160; v=1; x=1787541960;
 b=v0lTvAlcV4WgSii9mTtFKMcFtxNlq56qp0oyZmrSIctpoYTLyReijO0YmHWJ+Z/y0I36BfHh
 eKxsWj4OYJvMidJhcpB2ZF8QJZMqmSyKrxZHKXmg1+7puBX/B//HDXddMpNuD5iqIU6mPkuEi3T
 vtxueMAZ1kvf+MdfV5wGawp0=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:382:861c:7f36:14e1:cf55:e233:293b] (2600:382:861c:7f36:14e1:cf55:e233:293b)
	by smtp.migadu.com with ESMTPS id af8c28ccdce80c6a;
	Mon, 17 Aug 2026 03:25:50 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <287d4650-5580-4399-a340-ad7d33077f64@linux.dev>
Date: Sun, 16 Aug 2026 20:25:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 02/11] bpf: Add helpers to describe the R0:R2
 return register pair
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260813200220.1994468-1-yonghong.song@linux.dev>
 <53ea9e3097d059edd4ac58c59e33caffdce32e62674ddce7c6a94773d5723fe4@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <53ea9e3097d059edd4ac58c59e33caffdce32e62674ddce7c6a94773d5723fe4@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/13/26 2:11 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -814,6 +814,8 @@ struct bpf_subprog_info {
>>   	bool is_async_cb: 1;
>>   	bool is_exception_cb: 1;
>>   	bool args_cached: 1;
>> +	/* true if the return value is passed in the R0:R2 register pair */
>> +	bool ret_reg_pair: 1;
>>   	/* true if bpf_fastcall stack region is used by functions that can't be inlined */
>>   	bool keep_fastcall_stack: 1;
>>   	bool changes_pkt_data: 1;
>> @@ -1048,6 +1050,13 @@ static inline struct bpf_subprog_info *subprog_info(struct bpf_verifier_env *env, int subprog)
>>   	return &env->subprog_info[subprog];
>>   }
>>
>> +static inline bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int subprog)
>> +{
>> +	return subprog_info(env, subprog)->ret_reg_pair;
>> +}
>> +
>> +bool bpf_kfunc_ret_reg_pair(struct bpf_verifier_env *env, struct bpf_insn *insn);
>> +
>>   struct bpf_call_summary {
>>   	u8 num_params;
>>   	bool is_void;
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -382,29 +382,62 @@ bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subprog)
>>   	return aux && aux[subprog].linkage == BTF_FUNC_GLOBAL;
>>   }
>>
>> -static bool subprog_returns_void(struct bpf_verifier_env *env, int subprog)
>> +static const struct btf_type *subprog_ret_type(struct bpf_verifier_env *env, int subprog)
>>   {
>> -	const struct btf_type *type, *func, *func_proto;
>> +	const struct btf_type *func, *func_proto;
>>   	const struct btf *btf = env->prog->aux->btf;
>>   	u32 btf_id;
>>
>> +	if (!btf || !env->prog->aux->func_info)
>> +		return NULL;
>> +
>>   	btf_id = env->prog->aux->func_info[subprog].type_id;
>>
>> +	/* Both already validated by prepare_btf_func() at prog load. */
>>   	func = btf_type_by_id(btf, btf_id);
>> -	if (verifier_bug_if(!func, env, "btf_id %u not found", btf_id))
>> -		return false;
>> -
>>   	func_proto = btf_type_by_id(btf, func->type);
>> -	if (!func_proto)
>> -		return false;
>>
>> -	type = btf_type_skip_modifiers(btf, func_proto->type, NULL);
>> -	if (!type)
>> -		return false;
>> +	return btf_type_skip_modifiers(btf, func_proto->type, NULL);
>> +}
>>
>> -	return btf_type_is_void(type);
>> +static bool subprog_returns_void(struct bpf_verifier_env *env, int subprog)
>> +{
>> +	const struct btf_type *type = subprog_ret_type(env, subprog);
>> +
>> +	return type && btf_type_is_void(type);
>> +}
>> +
>> +static u32 ret_regs_cnt(u32 size)
>> +{
>> +	return size > 8 && size <= 16 ? 2 : 1;
>>   }
>>
>> +static void bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
>> +{
>> +	const struct btf *btf = env->prog->aux->btf;
>> +	const struct btf_type *type;
>> +	int subprog;
>> +	u32 size;
>> +
>> +	for (subprog = 0; subprog < env->subprog_cnt; subprog++) {
> Does this loop need to start at subprog 0?  The main program (subprog 0)
> delivers its exit code in R0 alone and never uses the R0:R2 calling
> convention, so checking its BTF return type can incorrectly trigger
> jit_required even though no R2 propagation is needed.

You are right. We only need to start from subprog 1.

>
>> +		type = subprog_ret_type(env, subprog);
>> +		if (!type || !(btf_type_is_struct(type) || btf_type_is_scalar(type)))
>> +			continue;
>> +		if (IS_ERR(btf_resolve_size(btf, type, &size)))
>> +			continue;
>> +		if (ret_regs_cnt(size) > 1) {
>> +			subprog_info(env, subprog)->ret_reg_pair = true;
>> +			/*
>> +			 * The R0:R2 return convention is only implemented in
>> +			 * the JIT: the interpreter propagates BPF_R0 alone out
>> +			 * of a subprogram, so a caller reading R2 would see a
>> +			 * stale value.
>> +			 */
>> +			env->prog->jit_required = 1;
>> +		}
>> +	}
>> +}
> Additionally, should jit_required be set for subprogs whose BTF prototypes
> are marked unreliable?  btf_check_subprog_call() can flag a mismatch with
> prog->aux->func_info_aux[subprog].unreliable = true, and check_func_call()
> only aborts on -EFAULT, so a static callee with an aggregate return can
> load today without using the BTF return type. Subprogs subsequently deleted
> by bpf_opt_remove_dead_code() (which runs after this pass) also don't need
> jit_required set.

We cannot just mark jit_required if BTF prototypes is marked unreliable.
This is too conservative. Marking unreliable may not have 2 return registers,
e.g., if a argument is 'int *p', the subprog will mark unreliable. but
it may not have 2 return registers.

>
> This changes behavior for existing programs: on CONFIG_BPF_JIT=n or
> net.core.bpf_jit_enable=0, such programs would now fail in
> bpf_fixup_call_args() with "program requires BPF JIT compiler but it is
> not available", whereas they previously verified and ran on the
> interpreter.

If jit is not enabled, let us just assume returning R0 only.

>
> [ ... ]
>
>> @@ -20333,6 +20381,9 @@
>>   	if (ret < 0)
>>   		goto skip_full_check;
>>
>> +	/* must precede the first bpf_ret_reg_pair() user below */
>> +	bpf_compute_subprog_ret_regs(env);
>> +
>>   	ret = bpf_compute_live_registers(env);
>>   	if (ret < 0)
>>   		goto skip_full_check;
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31740414277

