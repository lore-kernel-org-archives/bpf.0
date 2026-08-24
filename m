Received: from mta0.migadu.com (out-47.mta0.migadu.com [91.218.175.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABD039280A
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787607070; cv=none; b=cQ3GLa1Hpwo+7cL6N0XnWltuZSVVU1oEtxdP46P80pp++W4FhU6CCyiiBaaV0t6NRTtJUK5PrbrR5nnQIKKhVaB7GOcYYv0sxjxnN5YytrQSMkgOtgCMnG6oaI0Spcv3XX0ieRW8x/B6EZ7GtatEnnTwJU3HOgm6+mQMvaJ/GIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787607070; c=relaxed/simple;
	bh=WZcBcfW1L70I1fxAaNA8stbBZTTedz2WeJJI5m9KWhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uRDDmF5ojPC47Lk1V5412OspyYNsF/fq1oYIdV6ltVe3S72406GJwleVeC3hbYrgu+Fgh2v3Ze8Qa31Bi9OUbIKiRGNrEWkzXHFjsJE2Z0fuctdSxUrWrBF6IlJtFiDs3BjFXeLyjBxeAy8u1R5ZZLrGC4SyDdL8VHbTnKpxADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p9KcRQZr; arc=none smtp.client-ip=91.218.175.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p9KcRQZr"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WZcBcfW1L70I1fxAaNA8stbBZTTedz2WeJJI5m9KWhc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787607063; v=1; x=1788211863;
 b=p9KcRQZrBucBIS/4YWq2uqyS83qwum6PI/oTK1fR+zxALAOEAMWP6atGaM1vQ0j0RSaIwaLU
 tEq77O0vVu1n9uMB2pwCbLwfHfb8ISPdfJv5mJMtbZj/OPJhjWu1zPLm7rOaMcmcEDmJcZbYW2a
 T87c9VVK/j47Ug0Oi6BqQ108=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1251:27:f67e:b349:d735:9d02] (2620:10d:c090:500::4:2c42)
	by smtp.migadu.com with ESMTPS id b8fd059c6c5c5754;
	Mon, 24 Aug 2026 21:31:03 +0000
X-Mizu-Trace-ID: b8fd059c6c5c5754
X-Migadu-Flow: FLOW_OUT
Message-ID: <d94a8330-79d4-485d-ae46-cc93c0ceac5e@linux.dev>
Date: Mon, 24 Aug 2026 14:30:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Enable some of the blocked
 cpuv4 instruction tests for bpf-gcc
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260824210142.3933580-1-vineet.gupta@linux.dev>
 <20260824210142.3933580-4-vineet.gupta@linux.dev>
 <20260824211401.3C3D91F000E9@smtp.kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <20260824211401.3C3D91F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/24/26 2:14 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly added `#ifdef __BPF_FEATURE_ADDR_SPACE_CAST` guard unintentionally drops 5 arena tests from the default test_progs flavour for clang.
> --
>
> --- Patch [3]: [PATCH bpf-next v2 3/3] selftests/bpf: Enable some of the blocked cpuv4 instruction tests for bpf-gcc ---
> commit ad6608dfd47ddd6a7068cdc6e0e6d467ec3558b8
> Author: Vineet Gupta <vineet.gupta@linux.dev>
>
> selftests/bpf: Enable some of the blocked cpuv4 instruction tests for bpf-gcc
>
> This commit relaxes clang-only checks in BPF selftests by adding specific
> feature checks like __BPF_FEATURE_LDSX to allow building under bpf-gcc.
> It also wraps arena tests with __BPF_FEATURE_ADDR_SPACE_CAST to skip them
> on bpf-gcc.
>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
>> index e58ea69e38549..75762e11b443f 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> [ ... ]
>> @@ -263,6 +257,14 @@ __naked void ldsx_ctx_8(void)
>>   	: __clobber_all);
>>   }
>>   
>> +#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
>> +
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_ARENA);
>> +	__uint(map_flags, BPF_F_MMAPABLE);
>> +	__uint(max_entries, 1);
>> +} arena SEC(".maps");
>> +
> [Severity: Medium]
> Does this inner guard unintentionally drop the arena tests for clang under
> the default test_progs flavour?
>
> The commit message notes that clang only defines feature macros like this at
> -mcpu=v4, but successfully assembles the inline asm at -mcpu=v3. Because of
> this, you kept the clang version checks on the file's main guard to avoid
> removing tests where they run today.
>
> However, since this inner guard lacks a || __clang_major__ >= 18 fallback,
> clang at -mcpu=v3 evaluates this as false,

Is this just by review or was it actually tested - I'm guessing former ...

> silently dropping the arena map
> and the subsequent 5 arena tests from the default test flavour.

... since clang (at least recent ones, I testet recent and a local jan 
build) defines this for all -mcpus

So this is invalid claim.

Thx,
-Vineet
