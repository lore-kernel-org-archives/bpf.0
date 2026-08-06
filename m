Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0292A41D203
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786050611; cv=none; b=BJC8ilZU6XarW/LI7Yx9OBWgAttaYoU4XaSNckFpb+CMDvfvbb3imrhnXMAfKCprl7zc+Y5+Y+gplFO/ffaffP+xfS+RIegkT+qIAjFZn8JDr4jwnAe9cLXFTZUqrxOUcLS/afYg9WtdsENb9E565v6OqBxjhGO6D8h5i9uR3Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786050611; c=relaxed/simple;
	bh=3uC53TGj24ENV4GVRI1QRghP3hLrt3xbg6mDjIwNy/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d/joK6fmRkL18Ei8Fjd7dPUjT2Vw4wmANiJt+q/TlscBXWsj9g/+nbCiWy1MucavGfa0JMQbt3Wa6a0FHKNG6nASjCqIMZw70ceKano39nVXx/0yt4p5gkxJIbGzSQwUA7Uic0RivaPJ6vSLSkm/0f5KuURi681QQKFHJdHZIp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mqi6agzl; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mqi6agzl"
Message-ID: <39401518-a0af-49f9-a247-1e3793bb0648@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786050607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e39FPgvRuNUsT5Tht2Tl3jSVxrlqWgMlgFYM5FLFaBI=;
	b=Mqi6agzldykWo28uj3U0dfCETkgEkjMSAZ+pRnq4ugaCq+yPIuABxPVK/xp/LVce1C4GxC
	U6s1ISu5lXC9OD8CRdJgk8tSdOA5Uwywf3OJSr0XM6gTUC/o/+GKOAQkSWuuPfEuJcr347
	1wNb0qs28VaMBCiDSQpLoZu37KgCdMQ=
Date: Thu, 6 Aug 2026 14:09:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 3/6] selftests/bpf: Verify arena type tags in
 resolve_btfids test
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260805230648.2354989-1-ihor.solodrai@linux.dev>
 <20260805230648.2354989-4-ihor.solodrai@linux.dev>
 <20260805231755.966CC1F000E9@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260805231755.966CC1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/5/26 4:17 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Missing NULL pointer check on the result of `btf__type_by_id()` causes a segmentation fault when a kfunc symbol is missing.
> --
> 
> --- Patch [3]: [PATCH bpf-next v2 3/6] selftests/bpf: Verify arena type tags in resolve_btfids test ---
> commit 833ac8bbb8ac1055e25790da1396864987e31541
> Author: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> selftests/bpf: Verify arena type tags in resolve_btfids test
> 
> This commit extends test_resolve_btfids() to assert that resolve_btfids
> emits the address_space(1) type attribute on the return type and arguments
> of kfuncs marked with KF_ARENA_RET, KF_ARENA_ARG1 or KF_ARENA_ARG2.
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
>> index ac51fd4548214..8482f00046d4c 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> [ ... ]
>> @@ -227,6 +260,39 @@ void test_resolve_btfids(void)
>>  	check_kfunc_set(&test_kfunc_set);
>>  	check_kfunc_set(&test_kfunc_set_rev);
>>  
>> +	/*
>> +	 * Check resolve_btfids wrapped exactly the arena-flagged return/args
>> +	 * with the address_space(1) type attribute, and left other
>> +	 * pointers/returns untouched.
>> +	 */
>> +	for (i = 0; i < ARRAY_SIZE(kfunc_symbols); i++) {
>> +		const struct btf_type *fn, *proto;
>> +		const struct btf_param *params;
>> +		const char *name = kfunc_symbols[i].name;
>> +		u32 fl = kfunc_symbols[i].flags;
>> +		__u32 nr;
>> +
>> +		fn = btf__type_by_id(btf, kfunc_symbols[i].id);
>> +		if (!ASSERT_TRUE(btf_is_func(fn), name))
>> +			continue;
> 
> [Severity: Medium]
> Could this cause a segmentation fault if a kfunc symbol is missing?
> 
> If resolve_symbols() fails to find a kfunc in the parsed BTF file, the
> symbol's id remains -1. When -1 is passed to btf__type_by_id(), it
> returns NULL.
> 
> Since btf_is_func() unconditionally accesses the info member, passing a
> NULL pointer to it would crash the test program before the ASSERT_TRUE
> evaluates.
> 
> Should we check if fn is NULL before passing it to btf_is_func()?

We are fine with the test program crashing here. Wontfix.

> 
>> +		proto = btf__type_by_id(btf, fn->type);
>> +		if (!ASSERT_TRUE(btf_is_func_proto(proto), name))
>> +			continue;
> [ ... ]
> 

