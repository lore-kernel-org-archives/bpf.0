Received: from mta0.migadu.com (out-50.mta0.migadu.com [91.218.175.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D426442B3B
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980043; cv=none; b=opH1NcoUTlbdmi9Z13Tio+yXT9hRXPzGlZyV9mkIPOOtg5Y258+V3zt9+XBNmzackWEVcVEh6NqB3DsQLzl8pwx/S6HXFFduRcqoj4VjsCHIXE0oOu3oUk+1dboPKRrnh1QkD8tU1aiHpbITtpFqNpJHFc9Al8LDA2WaP4c7+G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980043; c=relaxed/simple;
	bh=WUQ+a7+2bAgrNBeCJSK75snee7UUngWOdLcMWnHwg5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/hJNfhpJNO6XVeItgXqZJ2jZJbmTDSgRL7rEa3ZAH+lJzBq03QPgpPH9cjpPsRI8p7gNo6BdXksf26X9RaXxwhzv7nTI9SZ6nSql5VyF6yS0X+3rjAtR9/ngPLFnZge68DmKyZFP3cun0qcmPTWWhCGoyyIR5GHFRGVeBd8XOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y/6sTbNK; arc=none smtp.client-ip=91.218.175.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y/6sTbNK"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WUQ+a7+2bAgrNBeCJSK75snee7UUngWOdLcMWnHwg5A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786980039; v=1; x=1787584839;
 b=Y/6sTbNKAMEL//my7HSfCSBW+zC2yn4QPApS/KEChRd/365NQ6nNyxfi8QUZVxQJRDf7qTyt
 vV+gkEgKL1T5GkDn1RP26f4QzigA2ZUR4BrOzErZx6R9+lLxkc4fZXuQptM8DeKPxQnjOrfJrlC
 DXzV1U7cP0brC98H0v1ujbGY=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:5604)
	by smtp.migadu.com with ESMTPS id 389bdd2501501e2e;
	Mon, 17 Aug 2026 15:20:39 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <7a1dd845-1a05-4a1b-a18f-f0dfc7d7eaf1@linux.dev>
Date: Mon, 17 Aug 2026 08:20:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 02/10] bpf: Add helpers to describe the R0:R2
 return register pair
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260817042151.2286855-1-yonghong.song@linux.dev>
 <39fd72ee111c2f2a329c7bc32fe889598efc9e274bebb10c7aae0e09820da37e@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <39fd72ee111c2f2a329c7bc32fe889598efc9e274bebb10c7aae0e09820da37e@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/16/26 10:17 PM, bot+bpf-ci@kernel.org wrote:
>> 8 but <=16 bytes). It introduces bpf_compute_subprog_ret_regs() to
> derive this from BTF prototypes.
>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index bc2af02547fe..f70d5878fbff 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -819,6 +819,8 @@ struct bpf_subprog_info {
>>   	bool is_async_cb: 1;
>>   	bool is_exception_cb: 1;
>>   	bool args_cached: 1;
>> +	/* true if the return value is passed in the R0:R2 register pair */
>> +	bool ret_reg_pair: 1;
>>   	/* true if bpf_fastcall stack region is used by functions that can't be inlined */
>>   	bool keep_fastcall_stack: 1;
>>   	bool changes_pkt_data: 1;
>> @@ -1055,6 +1057,11 @@ static inline struct bpf_subprog_info *subprog_info(struct bpf_verifier_env *env
>>   	return &env->subprog_info[subprog];
>>   }
>>
>> +static inline bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int subprog)
>> +{
>> +	return subprog_info(env, subprog)->ret_reg_pair;
>> +}
>> +
> [ ... ]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index b3c474ba7140..f1f1268d29c6 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -385,27 +385,70 @@ bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subprog)
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
>> +}
>> +
>> +static int bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
>> +{
>> +	const struct btf *btf = env->prog->aux->btf;
>> +	const struct btf_type *type;
>> +	int subprog;
>> +	u32 size;
>> +
>> +	if (!env->prog->jit_requested || bpf_prog_is_offloaded(env->prog->aux))
>> +		return 0;
>> +
>> +	/*
>> +	 * Skip the main program: its return value is the program's exit code,
>> +	 * read out of R0, so it never uses the register pair. An extension does
>> +	 * have a real prototype for subprog 0, but bpf_check_attach_target()
>> +	 * refuses to replace a function returning more than 8 bytes.
>> +	 */
>> +	for (subprog = 1; subprog < env->subprog_cnt; subprog++) {
>> +		type = subprog_ret_type(env, subprog);
>> +		/*
>> +		 * This runs before btf_validate_return_type(), so apply the same
>> +		 * type filter here.
>> +		 */
>> +		if (!type || !(btf_type_is_struct(type) || btf_type_is_scalar(type)))
>> +			continue;
> Does the comment's claim about applying "the same type filter" hold?
>
> btf_validate_return_type() accepts void, int, or enum types via:
>
> kernel/bpf/btf.c:btf_validate_return_type() {
>      /* We always accept void or scalars. */
>      if (btf_type_is_void(t) || btf_type_is_int(t) || btf_is_any_enum(t))
>          return 0;
>
>      return -EOPNOTSUPP;
> }
>
> The new filter instead accepts struct/union or scalar (int or enum, but
> not ENUM64):
>
>      if (!type || !(btf_type_is_struct(type) || btf_type_is_scalar(type)))
>
> btf_type_is_scalar() is defined as btf_type_is_int() || btf_type_is_enum(),
> and btf_type_is_enum() excludes BTF_KIND_ENUM64.
>
> The filters differ in several ways. btf_validate_return_type() accepts
> void and ENUM64 (via btf_is_any_enum()) but rejects struct/union at this
> commit. The new filter accepts struct/union but filters out void and
> ENUM64.
>
> The divergence is harmless since every dropped type is at most 8 bytes and
> would need only one register anyway. But the comment implies an equivalence
> that does not exist, and specifically suggests structs are validated
> elsewhere when btf_validate_return_type() at this commit still rejects
> them with -EOPNOTSUPP.
>
> Would describing what the filter actually needs be clearer? Something like
> "only struct/union and integer/enum returns can exceed 8 bytes and need
> sizing" rather than claiming parity with btf_validate_return_type()?

You are right. I missed enum64. I think the above 'if' condition should be
   
  if (!type || !(btf_type_is_struct(type) || btf_type_is_int(type) || btf_is_any_enum(type)))

>
>> +		if (verifier_bug_if(IS_ERR(btf_resolve_size(btf, type, &size)), env,
>> +				    "cannot size return type of subprog %d", subprog))
>> +			return -EFAULT;
>> +		if (ret_regs_cnt(size) > 1) {
>> +			subprog_info(env, subprog)->ret_reg_pair = true;
>> +			env->prog->jit_required = 1;
>> +		}
>> +	}
>> +
>> +	return 0;
>>   }
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31995069373

