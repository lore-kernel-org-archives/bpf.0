Received: from mta0.migadu.com (out-69.mta0.migadu.com [91.218.175.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F119339386
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 04:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841080; cv=none; b=DVuSTH5zQV1owTlrwagFsPGZyqHmDmQnhG3hAkZ6/LUIWfNtZ/CRafSjoT89oyIwXkq9Peok+eJBlzCqoem/ENb+cnk4+n2vJtvJFRsP9UOlsC/Qy1gNuUbjzBpBFHbxYubW9QdDbIkNwaLqI5XR1DNGgs/s/sCsxm4JET0lFfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841080; c=relaxed/simple;
	bh=4ppNIV+nF9U9d+XG0Dt5o5AhZslKWKfUTNBQ7E8NQdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oj9DVtMdsfapWmGjrl7r+7FGu9J2mx6ilY9C+L75rq3CA9mv9hM/kjH/otvqUMCHzDH/70cw8srJLm3SfJAPDLucGHOzbdUFuOLFbHkmUKc77yrmVwfziT0pbbjLsk+bt9BbHcEJsloicH6K4yCPxqlmmoaALLaF0QzF78cPfwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HtO/SMs7; arc=none smtp.client-ip=91.218.175.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HtO/SMs7"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4ppNIV+nF9U9d+XG0Dt5o5AhZslKWKfUTNBQ7E8NQdQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788841075; v=1; x=1789445875;
 b=HtO/SMs73az5HP+EY16/hvp/cnOsyTBnrMcX4/RCOwuiMyeTXpwy3/5cJh3wAhVrDQIUbW2O
 m0AlRsG1mwfbFbkb7jaaAKBSBF7R/MA2QU8d06IavokPRKV5w7O0mzSl9CbWW/X33x2DezTLwYc
 Pm0kvwUn9gU5GyxuOvLHbUJ4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id df0605ac32fe9fea;
	Tue, 08 Sep 2026 04:17:55 +0000
X-Mizu-Trace-ID: df0605ac32fe9fea
X-Migadu-Flow: FLOW_OUT
Message-ID: <6d6a8e4c-982d-4231-bd3f-54424671d016@linux.dev>
Date: Mon, 7 Sep 2026 21:17:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 03/12] bpf: Support by-value struct arguments up
 to 16 bytes
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
 <20260904051013.3978240-1-yonghong.song@linux.dev>
 <20260904052304.9AB2C1F00A3E@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260904052304.9AB2C1F00A3E@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/3/26 10:23 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Out-of-bounds array write in `btf_prepare_func_args` when an argument passed by value requires multiple slots, overflowing the `sub->args` array.
> --
>
> commit d1c6556d5925344f81e73a6b534000285b7cee65
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Support by-value struct arguments up to 16 bytes
>
> This commit adds support for passing struct arguments up to 16 bytes by value
> to global BPF functions. The arguments are split into multiple register slots
> based on their size.
>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 22828b489b778..dbd64cee1b27a 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -8103,6 +8103,14 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>>   	for (i = 0, slots_used = 0; i < nargs; i++) {
>>   		u32 tags = 0;
>>   
>> +		if (slots_used >= MAX_BPF_FUNC_ARGS) {
>> +			if (!is_global)
>> +				return -EINVAL;
>> +			bpf_log(log, "Arguments of %s() need more than %d argument slots\n",
>> +				tname, MAX_BPF_FUNC_ARGS);
>> +			return -EINVAL;
>> +		}
>> +
> [ ... ]
>
>> @@ -8231,6 +8239,31 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
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
>> +			while (nslots--)
>> +				sub->args[slots_used++].arg_type = ARG_ANYTHING;
> [Severity: High]
> Can this loop write out-of-bounds of the sub->args[] array?
>
> The bounds check for slots_used is only performed at the beginning of the
> outer for-loop in btf_prepare_func_args(). If a function argument is evaluated
> when slots_used is exactly MAX_BPF_FUNC_ARGS - 1, and this argument is a
> 16-byte struct requiring 2 slots (nslots = 2), the inner while loop will
> increment slots_used twice.
>
> This will cause an out-of-bounds write when setting arg_type for the second
> slot.
>
> Since struct bpf_subprog_info defines args as having exactly
> MAX_BPF_FUNC_ARGS elements, writing past the end will corrupt adjacent
> memory fields like stack_arg_cnt.
>
> Should the code verify if slots_used + nslots > MAX_BPF_FUNC_ARGS before
> entering this loop?

Yes, this is a bug. Will fix.

>
>> +			continue;
>> +		}

