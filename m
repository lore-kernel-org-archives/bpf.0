Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176962C11CA
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 19:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710849; cv=none; b=bQGpb8M9ORGlfmpTzbkelsqEM2mub2Olu+mPXGU59kSZ4zYeiqPa0NNH1KodyACLIGfq2Wa9arp+hEdPedFptchxAtg4HSOZQ7nt6xLJUpOM7rx2nkAageRNyFSyvpSJxJM7DCKKFgiZ4w/aFX4HgDi57Oo2zAYbBnUb8kqO5EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710849; c=relaxed/simple;
	bh=yyhlkcnBQirrNapppuVvQgqJU++T2xKS4kSnGHKNJAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m06AasrVQWE7t8vgflBDW6o+zWFTqoAufdvaaCyYKVKUzxJGffmvSjtdUTqKH4yk6HI3PlxX1Fsk2AJ1AsqviiB26BpI+/HZya81Afk0pzLDMeLikl9UNZ3QdOJmhbiBm4I2kjL8oUBz1KlE2uPBcBhgHMwEP0IFhSFwOYUr9qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SqxDYHD0; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SqxDYHD0"
Message-ID: <69937e6e-7292-42f2-988b-19b227beb0d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783710835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FlJFkPv3kNKg+GUuRWBr1UMWIqPNnYOMJMKqCieT5oE=;
	b=SqxDYHD04WpxmXJVg5ZvjhgJHNR+mSrDADeJMCm19n3MYSX092aINiQHjw8ti07fEiiGeH
	Z4S9vDuWSXqlLtThty8+DnXoUzIQGOo3b670EMw0OyXXms6eW7TS2x45KBlbkjxbpTVolE
	yl8ssUb9CeKbbY39kL019SyslNelMOA=
Date: Fri, 10 Jul 2026 12:13:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 3/3] selftests/bpf: Add tests for >8 byte return
 value and 128-bit arguments
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260710182204.1085329-1-yonghong.song@linux.dev>
 <20260710182219.1092246-1-yonghong.song@linux.dev>
 <20260710183802.D34681F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260710183802.D34681F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/10/26 11:38 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly added `test_int128_args` selftest will predictably fail on `aarch64` due to an unhandled ABI alignment requirement in the ARM64 BPF trampoline.
> --
>
> --- Patch [3]: [PATCH bpf v2 3/3] selftests/bpf: Add tests for >8 byte return value and 128-bit arguments ---
> commit c4e66c7551048f829ca6d77d8b1b2e6467e4525e
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> selftests/bpf: Add tests for >8 byte return value and 128-bit arguments
>
> The BPF trampoline preserves only 8 bytes of the target's return value
> (R0), so attaching an fexit/fmod_ret/fsession program to a function that
> returns a >8 byte value is now rejected by the verifier. Add a bpf_testmod
> function returning __int128 and an fexit program that targets it. The
> program is expected to fail to load with the "with a >8 byte return value
> is not supported for this attach type" message.
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
>> index 6f8c0bfb04155..d32198ee02dff 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
> [ ... ]
>> @@ -112,6 +113,39 @@ static void test_struct_many_args(void)
>>   	tracing_struct_many_args__destroy(skel);
>>   }
>>   
>> +static void test_int128_args(void)
>> +{
>> +	/*
>> +	 * __int128 arguments are passed in a register pair on x86_64 and
>> +	 * arm64, which the trampoline packs into two context slots. Other
>> +	 * architectures pass a __int128 differently (e.g. s390x passes larger
>> +	 * arguments by reference), so only exercise this on x86_64 and arm64.
>> +	 */
>> +#if defined(__x86_64__) || defined(__aarch64__)
>> +	struct tracing_struct_int128 *skel;
>> +	int err;
>> +
>> +	skel = tracing_struct_int128__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "tracing_struct_int128__open_and_load"))
>> +		return;
>> +
>> +	err = tracing_struct_int128__attach(skel);
>> +	if (!ASSERT_OK(err, "tracing_struct_int128__attach"))
>> +		goto destroy_skel;
>> +
>> +	ASSERT_OK(trigger_module_test_read(256), "trigger_read");
>> +
>> +	ASSERT_EQ(skel->bss->t_a, 1, "t:a");
>> +	ASSERT_EQ(skel->bss->t_c, 3, "t:c");
>          ^^^^
>
> [Severity: Medium]
> Will this test predictably fail on AArch64?
>
> The test calls bpf_testmod_test_int128_arg(1, 2, 3). According to the AAPCS64
> calling convention, a 16-byte aligned argument (__int128) must be passed in an
> even-odd register pair. Thus, the integer 'a' goes to w0, x1 is skipped for
> alignment padding, the __int128 'b' goes to x2 and x3, and the long 'c' goes
> to x4.
>
> However, the pre-existing logic in the ARM64 BPF trampoline fails to account
> for this padding. It solely calculates register usage based on argument sizes:
>
> arch/arm64/net/bpf_jit_comp.c:calc_arg_aux() {
> 	...
> 	for (i = 0, nregs = 0; i < m->nr_args; i++) {
> 		slots = (m->arg_size[i] + 7) / 8;
> 		if (nregs + slots <= 8) /* passed through register ? */
> 			nregs += slots;
> 	...
> }
>
> Because it incorrectly assumes the arguments use exactly 4 contiguous
> registers (x0 through x3), it only saves those.
>
> As a result, when the test's BPF program reads ctx[3] expecting 'c', it
> actually reads x3 (the upper 64 bits of 'b', which is 0).
>
> Would it be better to fix the ARM64 trampoline padding handling first, or
> exclude AArch64 from this test for now to prevent CI failures?

Another arch difference between x86_64 and arm64. x84_64 allows __int128 at
any position in an array. But arm64 allows __int128 must be even position.

I will fix it.

>
>> +	ASSERT_EQ(skel->bss->t_ret, 6, "t ret");
>> +
>> +destroy_skel:
>> +	tracing_struct_int128__destroy(skel);
>> +#else
>> +	test__skip();
>> +#endif
>> +}

