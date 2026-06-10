Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83E77E792
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 04:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781064386; cv=none; b=Ipg/C8pFoCQVRb9PY0dkXBSq904T566smy66+5OQLj5gDGXrzsLwL94kJSIU6bzuOKm/Xc0d222CPvz4EeYhG5NJdjJx5u0KAvCXWwVMqnKEyYJ3IwsbNcQUB1fF03maQ+j8tbZFrdu/UFLnbthgtCMIT6HkGsM2ucmsoApBB6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781064386; c=relaxed/simple;
	bh=JZrw7ysi0X7Inh0EvXclsD+NnRcIFeXSOLauRDEH2VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EruR7QaA7n0VduAsUvI8aAiP84yLBvpFvnZW9OdI3U/vlyKFW5Bf7N17hc/Z8bJ3cjqfVtsAFdHsdyUGv3MYGfdZlcKKL+egSrTvWnVyxqJ6sdvMQW0p6SJElgVa83pi3yUiGwlMzFSG0qbccf1yjceBHkdUGLdFPOl69ffKfzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y75w65Uv; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y75w65Uv"
Message-ID: <e0c62992-30a3-4491-8eac-691235a123f4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781064373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rdn+kNcU6xZomowNKeAN8NVKeZeF0fLdtvPfgntQFAA=;
	b=Y75w65Uv1mNCcp27qdtb1UL+JKZlD4m79y+0xvWW1siBk8R59+nU9k4SA9Fmmw0zqCQ6ao
	AlgEf2/KWC+YqyRZ/trB0RJvTOZ+9SpOhR0fQMepHYuxXqxQ5LKsSOnPxRRM2kbP5aPJ6w
	ojOM3DTR6mYaj52yZBrxwPVQZe/uTaU=
Date: Tue, 9 Jun 2026 21:06:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: Keep int return type for
 tailcall subprogs
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260609233407.2711577-1-yonghong.song@linux.dev>
 <20260609234251.C1A6F1F00893@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260609234251.C1A6F1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/9/26 4:42 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Incomplete application of compiler optimization mitigation in `classifier_0`.
> --
>
> commit 230de7228ec64290b0e30a90f68ca96dd2ee6dd0
> Author: Yonghong Song <yonghong.song@linux.dev>
> selftests/bpf: Keep int return type for tailcall subprogs
>
> This commit updates tailcall subprograms to prevent LLVM 23 from optimizing
> their return types from 'int' to 'void', which would cause verifier failures.
> It uses barrier_var() and __sink() to ensure the compiler retains the int
> return type.
>
>> diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
>> index ae94c9c70ab7d..6fde0ab921486 100644
>> --- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
>> +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
> [ ... ]
>> @@ -41,16 +44,22 @@ int classifier_0(struct __sk_buff *skb)
>>   static __noinline
>>   int subprog_tail1(struct __sk_buff *skb)
>>   {
>> +	int ret = 0;
>> +
>>   	bpf_tail_call_static(skb, &jmp_table, 1);
>> -	return 0;
>> +	barrier_var(ret);
>> +	return ret;
>>   }
>>   
>>   __auxiliary
>>   SEC("tc")
>>   int classifier_1(struct __sk_buff *skb)
>>   {
>> +	int ret;
>> +
>>   	count1++;
>> -	subprog_tail1(skb);
>> +	ret = subprog_tail1(skb);
>> +	__sink(ret);
>>   	return 0;
>>   }
> [Severity: Medium]
> In classifier_1() here, the return value of subprog_tail1() is captured and
> sunk using __sink() to prevent optimization. Should classifier_0() also be
> updated symmetrically to capture and sink the return value of subprog_tail0()?
>
> Looking at classifier_0() in the same file:
>
> __auxiliary
> SEC("tc")
> int classifier_0(struct __sk_buff *skb)
> {
> 	count0++;
> 	subprog_tail0(skb);
> 	return 0;
> }
>
> While the return value of subprog_tail0() is currently sunk elsewhere in
> tailcall_bpf2bpf_hierarchy_2(), leaving this callsite unsunk could
> potentially leave the code fragile to LLVM optimizations that might create a
> void-returning clone of subprog_tail0() specifically for classifier_0().

clone is possible. But I would say it is extremely unlikely.
In https://github.com/llvm/llvm-project/pull/165310, for all kernel functions,
I only find one clone (specialization) with thin-lto mode.


