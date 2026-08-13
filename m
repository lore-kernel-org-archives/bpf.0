Received: from mta0.migadu.com (out-144.mta0.migadu.com [91.218.175.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52743F1AB8
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786644160; cv=none; b=duhRrMZSrDVb42A1QgKY8x3h6FzPCoCxye1H2JFs/SkG0Dmst/tgKN3DMxY/NnIXFHYZiZIYNruyEMTJFkOD5su9POxNuUw5okfA0oBPDkmyn6hSg8zhwH90B7EdUPDt7DGL9CYgBRz4pAaDU+lrRhqoxM5Xi525HzYRw3rdIXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786644160; c=relaxed/simple;
	bh=S/SF+04kEd4FCtwBv9FzbO1akY79MCOXyE2NKZqZ4dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eel6kt/pSP/tw06XJz8q81ut+7iryg4l3ElxN+T8R9ZMOJ0SxgmeEm59cAUxrCEkQFuMm1IW6QnbndvOytzf6/NiftNC3NKXtDg7a6EI8XSVstlY+sjijiVXcnx8J0hqZ8yEEwTI115QiMiu6rffa59bDf/SL2J3pxVKmnTIrNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lVi5Hf0P; arc=none smtp.client-ip=91.218.175.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lVi5Hf0P"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=S/SF+04kEd4FCtwBv9FzbO1akY79MCOXyE2NKZqZ4dQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786644152; v=1; x=1787248952;
 b=lVi5Hf0PihNN2iVPPzHXJIewYyMc1I6RSR3e0aY38L/+JQGn/+NqGdw6dcLrvdnIoTL6OJ2T
 PVfsfZZDDNso5FxoKg0PKVutq3jOl0TeedFlkMKhk0Gasa8nZS91kgEW2bhxRR92DmYm8P6i2AJ
 xhh5lRErPmdkHszYGxPSTUog=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:381:1f2d:e3e3:185d:58c3:4c79:68c] (2600:381:1f2d:e3e3:185d:58c3:4c79:68c)
	by smtp.migadu.com with ESMTPS id 85eb55b367fa1e24;
	Thu, 13 Aug 2026 18:02:22 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <05b6d121-8d29-4aa2-ae04-9d18a4fef5b5@linux.dev>
Date: Thu, 13 Aug 2026 11:02:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 02/13] bpf: Add helpers to describe the R0:R2
 return register pair
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260811000911.2378679-1-yonghong.song@linux.dev>
 <20260811000922.2380171-1-yonghong.song@linux.dev>
 <45edea4007f2b3b02caa34ed448060d43bf1f6c3.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <45edea4007f2b3b02caa34ed448060d43bf1f6c3.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/12/26 1:07 PM, Eduard Zingerman wrote:
> On Mon, 2026-08-10 at 17:09 -0700, Yonghong Song wrote:
>> LLVM 23 added support for returning a value in two registers for an
>> __int128, or a struct/union whose size is greater than 8 but not more than
>> 16 bytes: such a value comes back in the R0:R2 register pair, with R2
>> holding the upper half. See LLVM patches [1] and [2].
>>
>> Later patches teach the JIT, precision backtracking, live register analysis
>> and the verifier itself about that convention. All of them need to answer
>> the same question: does this subprogram return its value in a register
>> pair? Add the shared helpers up front so that those patches can be ordered
>> independently of each other:
>>
>>   - subprog_ret_type() resolves a subprogram's BTF return type. It is
>>     factored out of subprog_returns_void(). The verifier_bug_if(!func) and
>>     !func_proto checks it replaces are redundant, since
>>     check_btf_func_early() already rejects a func_info record whose type_id
>>     is not a BTF_KIND_FUNC pointing at a BTF_KIND_FUNC_PROTO. A check on
>>     prog->aux->{btf,func_info} is added instead: unlike
>>     subprog_returns_void(), which is only used for global subprograms, later
>>     callers ask about static subprograms too, and those may belong to a
>>     program loaded without BTF.
>>
>>   - ret_regs_cnt() maps the size of a return value to the number of
>>     registers holding it.
>>
>>   - bpf_ret_reg_pair() answers the question above. Its users query it at
>>     every subprogram call and at every subprogram exit, that is once per
>>     verifier state rather than once per subprogram, so the answer is
>>     precomputed into bpf_subprog_info->ret_reg_pair by
>>     bpf_compute_subprog_ret_regs() and the helper itself is a flag test.
>>     It lives in bpf_verifier.h because kernel/bpf/backtrack.c and
>>     kernel/bpf/liveness.c need it as well.
>>
>> bpf_compute_subprog_ret_regs() runs in bpf_check() right before
>> bpf_compute_live_registers(), which is the first of those users: by then
>> BTF func_info has been validated and the subprogram list is final.
>>
>> No functional change, bpf_ret_reg_pair() has no callers yet.
>>
>>    [1] https://github.com/llvm/llvm-project/pull/190894
>>    [2] https://github.com/llvm/llvm-project/pull/206876
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> I still think that bpf_compute_live_registers() can be used to compute
> this information w/o the need to resort to BTF.

Maybe it is possible. I think current bpf_compute_subprog_ret_regs()
is more clear. In llvm23, we have true signatures for bpf programs, so
we should have precise return types for each subprogram.

>
> ...
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 40150390dd50..58a177d26c46 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -382,27 +382,57 @@ bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subprog)
>>   	return aux && aux[subprog].linkage == BTF_FUNC_GLOBAL;
>>   }
>>   
>> -static bool subprog_returns_void(struct bpf_verifier_env *env, int subprog)
>> +/* Return type of a subprogram, NULL if it cannot be resolved */
>> +static const struct btf_type *subprog_ret_type(struct bpf_verifier_env *env, int subprog)
>>   {
>> -	const struct btf_type *type, *func, *func_proto;
>> +	const struct btf_type *func, *func_proto;
>>   	const struct btf *btf = env->prog->aux->btf;
>>   	u32 btf_id;
>>   
>> +	if (!btf || !env->prog->aux->func_info)
>> +		return NULL;
>> +
>>   	btf_id = env->prog->aux->func_info[subprog].type_id;
>>   
>> +	/* Both already validated by prepare_btf_func() at prog load. */
>>   	func = btf_type_by_id(btf, btf_id);
>> -	if (verifier_bug_if(!func, env, "btf_id %u not found", btf_id))
>> -		return false;
>> -
>>   	func_proto = btf_type_by_id(btf, func->type);
>> -	if (!func_proto)
>> -		return false;
>>   
>> -	type = btf_type_skip_modifiers(btf, func_proto->type, NULL);
>> -	if (!type)
>> -		return false;
>> +	return btf_type_skip_modifiers(btf, func_proto->type, NULL);
>> +}
>> +
>> +static bool subprog_returns_void(struct bpf_verifier_env *env, int subprog)
>> +{
>> +	const struct btf_type *type = subprog_ret_type(env, subprog);
>>   
>> -	return btf_type_is_void(type);
>> +	return type && btf_type_is_void(type);
>> +}
>> +
>> +/*
>> + * Number of registers holding a function return value: a value of up to 8
>> + * bytes is returned in R0, a value of more than 8 bytes and no more than 16
>> + * bytes (an __int128 or a struct/union of such size) is returned in the R0:R2
>> + * register pair, with R2 holding the upper half.
>> + */
>> +static u32 ret_regs_cnt(u32 size)
>> +{
>> +	return size > 8 && size <= 16 ? 2 : 1;
>> +}
>> +
>> +/*
>> + * Resolve the return convention of every subprogram once, so that
>> + * bpf_ret_reg_pair() is a plain flag test on the hot paths that use it.
>> + */
>> +static void bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
>> +{
>> +	const struct btf_type *type;
>> +	int subprog;
>> +
>> +	for (subprog = 0; subprog < env->subprog_cnt; subprog++) {
>> +		type = subprog_ret_type(env, subprog);
>> +		if (type && (btf_type_is_struct(type) || btf_type_is_scalar(type)))
>> +			subprog_info(env, subprog)->ret_reg_pair = ret_regs_cnt(type->size) > 1;
> Nit: there is a btf.c:btf_resolve_size() api function, it would be
>       better to use it instead of calculating the size ad-hoc.

Will use btf_resolve_size() to get type size.

>
> Should the jit_required flag be set here instead of the main
> verification pass?

Indeed, this is much better.

>
>> +	}
>>   }
>>   
>>   static const char *subprog_name(const struct bpf_verifier_env *env, int subprog)
> ...

