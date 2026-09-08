Received: from mta0.migadu.com (out-133.mta0.migadu.com [91.218.175.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6A32F8E81
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 04:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841224; cv=none; b=d7cAkzKC4KkSmOVMtdpNvSiIxMBlyX0U32jKvhvwy4RlvmgM4lMbVa0r9BYCj+zdeY+S1jGQ+QShcd3+wTp8jKdeHLqUYJPrlpz5rAPqY40lCYQlEUtWosvhKgvBQAGPnS9EF4g/TBVioLPdQIfR4ef3VwIU0lgK3hF8t3cOyuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841224; c=relaxed/simple;
	bh=T8Hz4kT6XgrMnhx/eOb1oYi0pLxq2Kx6zJywCV+ZhwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFTTn79bHucS7foYG4JdsiFXR+lpmn9+wMpPMhnfcq1rcgEnHUQ0a513vcPRp6VtmnKNd3Li8TpqhmGFVOTjGjFj4QtkmMjCrFAqAeTxr567Su3zTadUJXF5vWK/hJ8EckJOd6D2+sq5na28zhOaPCqR2YYrJlf+2l8+vYIvgcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gZS9EljM; arc=none smtp.client-ip=91.218.175.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gZS9EljM"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=T8Hz4kT6XgrMnhx/eOb1oYi0pLxq2Kx6zJywCV+ZhwM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788841221; v=1; x=1789446021;
 b=gZS9EljMU1c8+Lwxp4R8Dq/isVRPaJa/86D/ejcp3NkbErKmhs0DtDEB03NGXa5KXUqmfaRg
 0UP1KsefBu92WYp/CHYBUQE4DW10YKwMo0JB16+d4JBEAotx0CV6kZN3RuhdjDBbKewDlYDdS7I
 rKPPnhpZDbqu0EtIXNjTPkPc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 534594481ca93f5b;
	Tue, 08 Sep 2026 04:20:15 +0000
X-Mizu-Trace-ID: 534594481ca93f5b
X-Migadu-Flow: FLOW_OUT
Message-ID: <7d825133-5f9f-4bab-9b3e-75f84d0601f6@linux.dev>
Date: Mon, 7 Sep 2026 21:20:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 04/12] bpf: Support __int128 as a by-value
 function argument
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
 <20260904051018.3978585-1-yonghong.song@linux.dev>
 <20260904053241.532E61F00A3D@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260904053241.532E61F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/3/26 10:32 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Out-of-bounds array write in `btf_prepare_func_args()` when an argument takes multiple register slots (like a 16-byte struct or `__int128`) and pushes `slots_used` past `MAX_BPF_FUNC_ARGS`.
> --
>
> commit 6ab0b55d70f74022fd34563ec7b71f1a649ea690
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Support __int128 as a by-value function argument
>
> This commit adds support for 128-bit integers as by-value function arguments
> in BPF. It handles __int128 similarly to a 16-byte struct, consuming two
> consecutive argument registers.
>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -8251,7 +8247,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>>   					i, btf_type_str(t), tname, t->size, 2 * BPF_REG_SIZE);
>>   				return -EINVAL;
>>   			}
>> -			if (!btf_struct_is_composed_of(env, btf, t, BTF_MEMBER_SCALAR)) {
>> +			if (btf_type_is_struct(t) &&
>> +			    !btf_struct_is_composed_of(env, btf, t, BTF_MEMBER_SCALAR)) {
>>   				if (!is_global)
>>   					return -EINVAL;
>>   				bpf_log(log, "Arg#%d type %s in %s() is not composed of scalars\n",
> [Severity: High]
> This is a pre-existing issue, but this patch enables __int128 arguments which
> trigger the same vulnerable path as 16-byte structs.
>
> Can this loop overflow the sub->args array when an argument takes multiple
> slots?
>
> Looking at btf_prepare_func_args() just below this hunk:
>
> 			nslots = (t->size + BPF_REG_SIZE - 1) / BPF_REG_SIZE;
> 			while (nslots--)
> 				sub->args[slots_used++].arg_type = ARG_ANYTHING;
>
> If a BPF program defines a subprogram with exactly 12 arguments, where the
> last argument is a 16-byte struct or __int128, slots_used would be 11 when
> processing the final argument.
>
> The 16-byte argument yields nslots = 2. The loop then increments slots_used
> twice without checking bounds mid-loop. Because sub->args is sized
> MAX_BPF_FUNC_ARGS (12), this writes to sub->args[11] and then out of bounds
> to sub->args[12].
>
> Since sub->args sits at the end of struct bpf_subprog_info, immediately
> followed by stack_arg_cnt, this out-of-bounds write corrupts stack_arg_cnt.
>
> Later, sub->stack_arg_cnt is set to slots_used - MAX_BPF_FUNC_REG_ARGS,
> which rewrites the corrupted enum value. Depending on endianness, this can
> result in an invalid enum value triggering a verifier_bug(), or an incorrect
> type expectation (like ARG_PTR_TO_CTX instead of a scalar).
>
> Could we add a bounds check inside or before the nslots loop to prevent
> slots_used from exceeding MAX_BPF_FUNC_ARGS?

Yes, this is the same problem as the previous patch. Will fix.

>

