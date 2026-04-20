Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5533538229B
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 06:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776665688; cv=none; b=QydYZi+ubx48r/aDe8jsxk0l6wzUJIbfXmE2FUZwKk2XORDpSs+/8pa58QzIupO/7Qt5WF/RNB2KoHg9xjQMhW9O3btkLsaYTBeY8BKpaL59a9EtC5Gvsg4y6En8Hbke4or//uBqyd8+YBJXh16EzpvNwhFvyATaPAKBPylxn28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776665688; c=relaxed/simple;
	bh=XuHEqy100BftAVlBJdvW9DVb6fg1wvB279gQtkjHb38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bdxe3hSK8kOz50jXAOi2Me2uJIKzR9RgAZxp866d5//J12uBcKbCxJDZkNwirJuma7xMZ5VqhNRbKU/kCOJ8iN4Ynp0vG1cqS0+l7WW0u3qKeq5DLSkyBKWNs3EaEDYD51c08LIlnVAZ1ILdUGlDMrYNUOp33ByKMvj0g3hXN2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L+wBdzYs; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L+wBdzYs"
Message-ID: <f93b6608-105d-4019-8254-fc89f58dc98f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776665675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lgYWeIja0bWfYK9dliaPLtzchWx5gzqPJr6ntKeKoSw=;
	b=L+wBdzYsmpinfXowuRwNKEF9jzTz+LKPrqG604276VqWJUj4OMSwnTPaWmiTdnpKjOBANv
	E5VqswYadsnMo9F+bCKf+6sn2VcD6L7l4COZr0D7KQW0lICWOMEmzWsDgGa6p+0GqcW8ZP
	8w1g5RdyxZ8VplA6jbEuRIFPqWmDQ4A=
Date: Sun, 19 Apr 2026 23:14:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 17/17] selftests/bpf: Add verifier tests for
 stack argument validation
Content-Language: en-GB
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260419163445.740437-1-yonghong.song@linux.dev>
 <20260419172100.A89FEC2BCAF@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260419172100.A89FEC2BCAF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/19/26 10:21 AM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Medium] Test fragility in `subprog_deref_arg6` error matching due to compiler register allocation
> --
>
> commit 3936b0a6dea45627278be80c25b20ff18f2821d4
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> selftests/bpf: Add verifier tests for stack argument validation
>
> This commit adds inline-asm based verifier tests to exercise BPF stack
> argument validation logic directly, including both positive and negative
> tests for tracking pointers, references, and null propagation.
>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
>> new file mode 100644
>> index 0000000000000..66dd11840a63e
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> [ ... ]
>
>> +__noinline __used
>> +static long subprog_deref_arg6(long a, long b, long c, long d, long e, long *f)
>> +{
>> +	return *f;
>> +}
> [ ... ]
>
>> +SEC("tc")
>> +__description("stack_arg: pruning with different stack arg types")
>> +__failure
>> +__flag(BPF_F_TEST_STATE_FREQ)
>> +__arch_x86_64
>> +__msg("R1 invalid mem access 'scalar'")
> Does this hardcode an assumption about Clang's register allocation?

Yes, it is possible that clang may pick a different register.
So as you suggested, I will use regex like below:
	__msg("R{{[0-9]}} invalid mem access 'scalar'")
which should fix the issue.

>
> Since subprog_deref_arg6 is standard C rather than a __naked inline
> assembly function, the compiler determines which register is used to
> dereference f. If a future LLVM version chooses a different register, the
> tests will fail because the verifier error will mention the new register
> instead of R1.
>
> Could these tests use __regex to match the register dynamically, or be
> rewritten so subprog_deref_arg6 is a __naked function to guarantee the
> register choice?
>
>> +__naked void stack_arg_pruning_type_mismatch(void)
>> +{
>> +	asm volatile (
>> +		"call %[bpf_get_prandom_u32];"
> [ ... ]
>

