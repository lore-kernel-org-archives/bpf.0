Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4785D3BB57
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 05:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777094395; cv=none; b=akg5WrpBrnYALegv0n5gMOd1T3s0cXiXmWzpgzy/7c5apjrZT1ePkLAPxV6PUF6RZ+9js22mxzIft9ER5vnePpIRAMVUdRBVBevCK0XMc4PJyDS9vpsYvqu/cBMFKl7dJQ4wouASUSujGQ74AyzszMmXKSe+vVRjPamWBwV/Zik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777094395; c=relaxed/simple;
	bh=Jidc8V1QiyfAGdHzPqQHdNBsKQTfElgyli7kSjdwns4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYlpTsliiCnSlyz3k0XnD6rM9ovbe4pnaeyMfEnlxiwtNnzqUdJ9EpX8RZrQU8xmKsk3ymZN313P28lILLmnbqhejcWREaptUD34S9eFPqz9yKiU4C+zs9tUJ84E45ONECh7jEsoeiqnB3EijjydQZwttuOAtKNkKVumIB4NIoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wFFiaKZs; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wFFiaKZs"
Message-ID: <25f099ba-f571-4227-aa48-f64b690fe848@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777094391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nT6+6gDuHrC0o/q9M6ZqNfIiyirKnRaU99/v3vk1FpY=;
	b=wFFiaKZssi5n0HqE4j8YpH9EWAnvhd7Kbvr2cXs9t3LWQqQ2IhivfQw702VPqzjM7H6iVY
	nsEyBvnbA9hvx3UFpW4RPDRAlYGLhn58gVK3pev8yirwwBQaWshZcgl6zOfZI9yXIeZZd6
	9IgTmVWkThZnDt1HUg0fVCTGTpRUfo0=
Date: Fri, 24 Apr 2026 22:19:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 08/18] bpf: Support stack arguments for kfunc
 calls
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260424171514.2041929-1-yonghong.song@linux.dev>
 <623062b9f2f97ecc1146e935d3522ed7c42d32a5251111fae771ea8ad796ab98@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <623062b9f2f97ecc1146e935d3522ed7c42d32a5251111fae771ea8ad796ab98@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/24/26 11:00 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 6994536b4e04..43aeb04f488a 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -12304,7 +12314,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>>   					reg_arg_name(env, argno));
>>   				return -EINVAL;
>>   			}
>> -			ret = mark_chain_precision(env, regno);
>> +			if (regno >= 0)
>> +				ret = mark_chain_precision(env, regno);
>> +			else
>> +				ret = mark_stack_arg_precision(env, i);
>>   			if (ret < 0)
>>   				return ret;
>>   			meta->arg_constant.found = true;
> [ ... ]
>
>> @@ -12329,7 +12342,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>>   			}
>>
>>   			meta->r0_size = reg->var_off.value;
>> -			ret = mark_chain_precision(env, regno);
>> +			if (regno >= 0)
>> +				ret = mark_chain_precision(env, regno);
>> +			else
>> +				ret = mark_stack_arg_precision(env, i);
>>   			if (ret)
>>   				return ret;
>>   		}
> In the v6 review, Sashiko AI pointed out that setting reg->precise = true
> without calling mark_chain_precision() breaks data-flow backtracking. The
> concern was that if only the current state's flag is set, parent states and
> source registers that populated the stack argument won't be marked precise,
> potentially allowing incorrect state pruning when execution paths merge before
> the stack store.
>
> The author acknowledged this issue in the v6 discussion with "You are right.
> Let me think how to resolve this." However, the current v7 code still calls
> mark_stack_arg_precision() for stack arguments in check_kfunc_args().
>
> Does mark_stack_arg_precision() properly handle backtracking through parent
> states? Looking at the two locations where stack argument precision is tracked:
>
> check_kfunc_args() for is_kfunc_arg_const_mem_size():
>      if (regno >= 0)
>          ret = mark_chain_precision(env, regno);
>      else
>          ret = mark_stack_arg_precision(env, i);
>
> check_kfunc_args() for KF_ARG_PTR_TO_ALLOC_BTF_ID with is_ret_buf_sz:
>      if (regno >= 0)
>          ret = mark_chain_precision(env, regno);
>      else
>          ret = mark_stack_arg_precision(env, i);
>
> Is mark_stack_arg_precision() correctly marking parent states and the source
> registers that stored values into the stack argument slots, or does it only
> mark the current state as the v6 review suggested?

I think it does proper precision marking and backtracking. There is a test
for this, "selftests/bpf: Add precision backtracking test for stack arguments".
Please take a look.

>
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24902767240

