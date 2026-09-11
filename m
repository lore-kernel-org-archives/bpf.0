Received: from mta0.migadu.com (out-55.mta0.migadu.com [91.218.175.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82752EAB6F
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 04:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789100973; cv=none; b=EEpiD14uaZRE43WmcJUWhGbPx+ln7Sdm3g/1+kDHOKTExlgRdpwtV8JNnPZdRTDgXaz98r4axt1CuN1vifZWUuI0AuXjRpp+1nbD7Ne/ja4HrZYNY1lIMeql53vtc1rbEPWe6t9vPL3rcsAsYqEG2sK7CuBYNRjmbScBmVStHHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789100973; c=relaxed/simple;
	bh=d3ip24AT2UUraNkutcdkAzwuAPj40b2p4ICb/6OTYJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QIu5GxX+qax4oonFoDZZmP1+xhhFWT1QucAwW/WxoLGwi6vR4Si1sYsZTRVnH3iPLQPVE4sjnIe0ewdMeiI2WF407kDQAj+/6+w4dk+vz5TNTQ1MMd6bUiDtke+afeNcQJNujv5IyxEMThA+W+kbpgie/i8IpT9uUogf1UG+zOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=twAm11Wx; arc=none smtp.client-ip=91.218.175.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="twAm11Wx"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=d3ip24AT2UUraNkutcdkAzwuAPj40b2p4ICb/6OTYJ0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789100969; v=1; x=1789705769;
 b=twAm11WxQM7w9cqTiHs79Cg20SvMKLpLv701S8PvYUFM1tTy1EjO8Wv5HpFW1aIs1DDG8AQJ
 LSdHnoate27bgg/2IMNIKoZN90glmUF/V0Nq6eszw+PjrNcNevdRjDiE4998FEwktSAAIlATz9n
 oaRQnaXsAqn9Ct5yOL63rzvY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7b867455830121f6;
	Fri, 11 Sep 2026 04:29:29 +0000
X-Mizu-Trace-ID: 7b867455830121f6
X-Migadu-Flow: FLOW_OUT
Message-ID: <ccb524ec-1438-4c31-90d5-c01c37b0e858@linux.dev>
Date: Thu, 10 Sep 2026 21:29:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 03/12] bpf: Support by-value struct arguments
 up to 16 bytes
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260909062538.4003426-1-yonghong.song@linux.dev>
 <0a9ac5bad4c131e896916f00fe93d4d7c6accef6711d1ee477969a8a7d330ae9@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <0a9ac5bad4c131e896916f00fe93d4d7c6accef6711d1ee477969a8a7d330ae9@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/9/26 12:13 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 104a91f5ffd5..4502b888b668 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -8125,6 +8125,9 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>>   	for (i = 0, slots_used = 0; i < nargs; i++) {
>>   		u32 tags = 0;
>>
>> +		if (slots_used >= MAX_BPF_FUNC_ARGS)
>> +			goto too_many_slots;
>> +
>>   		err = btf_scan_decl_tags(env, btf, fn_t, i, is_global, &tags);
>>   		if (err)
>>   			return err;
> [ ... ]
>
>> @@ -8253,6 +8256,33 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>>   			sub->args[slots_used++].arg_type = ARG_ANYTHING;
>>   			continue;
>>   		}
>> +		if (btf_type_is_struct(t)) {
>> +			u32 nslots;
>> +
>> +			if (!t->size || t->size > 2 * BPF_REG_SIZE) {
>> +				if (!is_global)
>> +					return -EINVAL;
>> +				bpf_log(log,
>> +					"Arg#%d type %s in %s() has size %u, only 1 to %d bytes "
>> +					"can be passed by value\n",
>> +					i, btf_type_str(t), tname, t->size, 2 * BPF_REG_SIZE);
>> +				return -EINVAL;
>> +			}
>> +			if (!btf_struct_is_composed_of(env, btf, t, BTF_MEMBER_SCALAR)) {
>> +				if (!is_global)
>> +					return -EINVAL;
>> +				bpf_log(log, "Arg#%d type %s in %s() is not composed of scalars\n",
>> +					i, btf_type_str(t), tname);
>> +				return -EINVAL;
>> +			}
>> +
>> +			nslots = (t->size + BPF_REG_SIZE - 1) / BPF_REG_SIZE;
>> +			if (slots_used + nslots > MAX_BPF_FUNC_ARGS)
>> +				goto too_many_slots;
>> +			while (nslots--)
>> +				sub->args[slots_used++].arg_type = ARG_ANYTHING;
>> +			continue;
>> +		}
>>   		if (!is_global)
>>   			return -EINVAL;
>>   		bpf_log(log, "Arg#%d type %s in %s() is not supported yet.\n",
>> @@ -8260,11 +8290,33 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>>   		return -EINVAL;
>>   	}
>>
>> +	if (slots_used > MAX_BPF_FUNC_REG_ARGS) {
>> +		if (is_global) {
>> +			bpf_log(log,
>> +				"global function %s() needs %d > %d argument slots, "
>> +				"stack args not supported\n",
>> +				tname, slots_used, MAX_BPF_FUNC_REG_ARGS);
>> +			return -EINVAL;
>> +		}
>> +		if (!bpf_jit_supports_stack_args()) {
>> +			bpf_log(log, "JIT does not support function %s() with %d argument slots\n",
>> +				tname, slots_used);
>> +			return -EFAULT;
>> +		}
>> +		sub->stack_arg_cnt = slots_used - MAX_BPF_FUNC_REG_ARGS;
>> +	}
>>   	sub->arg_cnt = slots_used;
> This isn't a bug, but now that slots_used is always >= nargs, is the
> pre-loop nargs-based block still needed? Looking earlier in the function:
>
> 	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
> 		if (!bpf_jit_supports_stack_args()) {
> 			bpf_log(log, "JIT does not support function %s() with %d args\n",
> 				tname, nargs);
> 			return -EFAULT;
> 		}
> 		sub->stack_arg_cnt = nargs - MAX_BPF_FUNC_REG_ARGS;
> 	}
>
> 	if (is_global && nargs > MAX_BPF_FUNC_REG_ARGS) {
> 		bpf_log(log, "global function %s has %d > %d args, stack args not supported\n",
> 			tname, nargs, MAX_BPF_FUNC_REG_ARGS);
> 		return -EINVAL;
> 	}
>
> The new block above recomputes stack_arg_cnt from slots_used. Since every
> parameter consumes at least one slot, whenever nargs > MAX_BPF_FUNC_REG_ARGS,
> slots_used > MAX_BPF_FUNC_REG_ARGS as well, so the assignment
> `sub->stack_arg_cnt = nargs - MAX_BPF_FUNC_REG_ARGS` in the earlier block
> is always overwritten by the new `sub->stack_arg_cnt = slots_used -
> MAX_BPF_FUNC_REG_ARGS` assignment.
>
> Also, the two blocks order their tests differently. The earlier block tests
> bpf_jit_supports_stack_args() before is_global, while the new block tests
> is_global first. On an architecture without stack-arg JIT support, a global
> function needing stack args therefore fails with -EFAULT and "JIT does not
> support function f() with 6 args" when the sixth slot comes from a sixth
> parameter, but with -EINVAL and "global function f() needs 6 > 5 argument
> slots, stack args not supported" when it comes from a two-slot struct.
>
> Could this new block be the only place that sets stack_arg_cnt and applies
> the global/JIT checks, or does the earlier nargs-based block serve a
> purpose I'm missing?

As you mentioned, actually we do have some issues. The above nargs and is_global
chcking is before going through all arguments. So they works. But we should
check again after all arguments processing since some arguments may have
two registers.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34320399441

