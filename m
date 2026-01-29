Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD10B353EF8
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 02:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769652895; cv=none; b=iPOCO0tMbH1t9FX8dlaZUtcmPzk3BBwkEIkCzuGBlNWpSC5PpSffY08qk8KkUoRjPhMlPCWdaY8d1RijGy10FU9a2fJkrjQ3mRUs+tmYGKhGwCfZiHNKwHFpD3vBJU9JetQYExFSuqZDIsF4saYOdx/y5sO7N9pmtCHatPDjVyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769652895; c=relaxed/simple;
	bh=n9pz7+1+NKpgMncZsCmTTaJdk1R1oBU2yQKMemaSBUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/uQSCRyH96Db7Cj3TOo1GYPsuUJKjVp7hAT7jhnaMIoYaFT3H4MIOHBKh9HezjYQFazRGcqGWb3xpiTn/YaX+QxXM8g8KiTM0I796HTBlLRipZDsaJ3gOtOk/OTsJqon4pcNQ1NGouZJ3Df8wABL/tRBdrn3zDIwp/oStpJyk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NAjfjL5E; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NAjfjL5E"
Message-ID: <468425e6-64ba-4d9a-97c5-6a1d95b8223b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769652879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U2BY6G007NwO/MDDvGKm/iCoeh9ZJMPEhIs8za3797E=;
	b=NAjfjL5E159u815UKdfODq+5g/aiO52FnhABHQ15W6wXklV66fPaQRumaDIk3yRX4YJ1MY
	Pb1wPBkrIDLV6souYfZamhYrt1WJ5OSdI2bzFIx2sMIrVviyk3GhQ64G5JBPCDQOlA3oF1
	L3w4XZEMejw0a+nKLeCZA41FsNzyvKI=
Date: Thu, 29 Jan 2026 10:14:25 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Add bpf_arch_supports_fsession()
Content-Language: en-US
To: Menglong Dong <menglong.dong@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Xu Kuohai <xukuohai@huaweicloud.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
References: <20260128150112.8873-1-leon.hwang@linux.dev>
 <20260128150112.8873-2-leon.hwang@linux.dev> <3392533.aeNJFYEL58@7940hx>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <3392533.aeNJFYEL58@7940hx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 29/1/26 09:29, Menglong Dong wrote:
> On 2026/1/28 23:01 Leon Hwang <leon.hwang@linux.dev> write:
>> fsession programs can currently be loaded on architectures that do not
>> implement fsession support, which leads to runtime errors instead of a
>> clean verifier rejection.
>>
>> For example, running fsession selftests on arm64 before fsession support
>> is added results in:
>>
>> test_fsession_basic:PASS:fsession_test__open_and_load 0 nsec
>> test_fsession_basic:PASS:fsession_attach 0 nsec
>> check_result:FAIL:test_run_opts err unexpected error: -14 (errno 14)
>>
>> Introduce bpf_arch_supports_fsession() to explicitly gate fsession usage
>> based on architecture support. Architectures without fsession support
>> will now fail program load with -EOPNOTSUPP, allowing selftests to skip
>> cleanly instead of errors at runtime.
>>
>> x86 declares fsession support, while the default implementation returns
>> false.
>>
>> Fixes: 2d419c44658f ("bpf: add fsession support")
> 
> I were wondering how this problem happen, as I remember that
> I added such checking. When I look back, I found that the checking
> is lost during v3->v4. I recalled that the AI warned me about this
> part, but I thought that checking exists in my mind :/
> 
> It seems that we can't ignore the AI's warning easily. It mostly
> make sense.
> 
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  arch/x86/net/bpf_jit_comp.c                   |  5 +++
>>  include/linux/filter.h                        |  1 +
>>  kernel/bpf/core.c                             |  5 +++
>>  kernel/bpf/verifier.c                         |  3 ++
>>  .../selftests/bpf/prog_tests/fsession_test.c  | 32 ++++++++++++++-----
>>  5 files changed, 38 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 5a075e06cf45..070ba80e39d7 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -4112,3 +4112,8 @@ bool bpf_jit_supports_timed_may_goto(void)
>>  {
>>  	return true;
>>  }
>> +
>> +bool bpf_jit_supports_fsession(void)
>> +{
>> +	return true;
>> +}
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index fd54fed8f95f..4e1cb4f91f49 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -1167,6 +1167,7 @@ bool bpf_jit_supports_arena(void);
>>  bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
>>  bool bpf_jit_supports_private_stack(void);
>>  bool bpf_jit_supports_timed_may_goto(void);
>> +bool bpf_jit_supports_fsession(void);
>>  u64 bpf_arch_uaddress_limit(void);
>>  void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
>>  u64 arch_bpf_timed_may_goto(void);
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index e0b8a8a5aaa9..3b1eb632bf7c 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -3142,6 +3142,11 @@ bool __weak bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
>>  	return false;
>>  }
>>  
>> +bool __weak bpf_jit_supports_fsession(void)
>> +{
>> +	return false;
>> +}
>> +
>>  u64 __weak bpf_arch_uaddress_limit(void)
>>  {
>>  #if defined(CONFIG_64BIT) && defined(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE)
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index c2f2650db9fd..6f867ebf78d1 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -24872,6 +24872,9 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>>  	case BPF_TRACE_FENTRY:
>>  	case BPF_TRACE_FEXIT:
>>  	case BPF_TRACE_FSESSION:
>> +		if (prog->expected_attach_type == BPF_TRACE_FSESSION &&
>> +		    !bpf_jit_supports_fsession())
>> +			return -EOPNOTSUPP;
>>  		if (!btf_type_is_func(t)) {
>>  			bpf_log(log, "attach_btf_id %u is not a function\n",
>>  				btf_id);
>> diff --git a/tools/testing/selftests/bpf/prog_tests/fsession_test.c b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
>> index 0c4b428e1cee..a299aeb8cc2e 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/fsession_test.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
>> @@ -29,8 +29,16 @@ static void test_fsession_basic(void)
>>  	struct fsession_test *skel = NULL;
>>  	int err;
>>  
>> -	skel = fsession_test__open_and_load();
>> -	if (!ASSERT_OK_PTR(skel, "fsession_test__open_and_load"))
>> +	skel = fsession_test__open();
>> +	if (!ASSERT_OK_PTR(skel, "fsession_test__open"))
>> +		return;
>> +
>> +	err = fsession_test__load(skel);
>> +	if (err == -EOPNOTSUPP) {
>> +		test__skip();
>> +		goto cleanup;
>> +	}
>> +	if (!ASSERT_OK(err, "fsession_test__load"))
>>  		goto cleanup;
>>  
>>  	err = fsession_test__attach(skel);
>> @@ -47,8 +55,16 @@ static void test_fsession_reattach(void)
>>  	struct fsession_test *skel = NULL;
>>  	int err;
>>  
>> -	skel = fsession_test__open_and_load();
>> -	if (!ASSERT_OK_PTR(skel, "fsession_test__open_and_load"))
>> +	skel = fsession_test__open();
>> +	if (!ASSERT_OK_PTR(skel, "fsession_test__open"))
>> +		return;
>> +
>> +	err = fsession_test__load(skel);
>> +	if (err == -EOPNOTSUPP) {
>> +		test__skip();
>> +		goto cleanup;
>> +	}
>> +	if (!ASSERT_OK(err, "fsession_test__load"))
>>  		goto cleanup;
>>  
>>  	/* first attach */
>> @@ -94,6 +110,10 @@ static void test_fsession_cookie(void)
>>  	bpf_program__set_autoload(skel->progs.test6, false);
>>  
>>  	err = fsession_test__load(skel);
>> +	if (err == -EOPNOTSUPP) {
>> +		test__skip();
>> +		goto cleanup;
>> +	}
>>  	if (!ASSERT_OK(err, "fsession_test__load"))
>>  		goto cleanup;
>>  
>> @@ -111,10 +131,6 @@ static void test_fsession_cookie(void)
>>  
>>  void test_fsession_test(void)
>>  {
>> -#if !defined(__x86_64__)
>> -	test__skip();
>> -	return;
>> -#endif
> 
> Ah, I see you enabled the testing for arm64 in this patch. Maybe

The test was not enabled for arm64 in this patch, since
bpf_jit_supports_fsession() still returns false there.

The test only becomes enabled when bpf_jit_supports_fsession() returns
true, which happens in patch #2.

> we can move this part to the 3rd patch, or split it out to another
> patch?
> > TBH, I prefer the previous implement. In this way, the CI can
> still pass if x86_64 or arm64 return -EOPNOTSUPP, right?
> 
> Maybe you can test the not-supported case stand alone, such
> as:
> 
> #if !defined(__x86_64__)
> 	test__fsession_not_support();
> 	return;
> #endif
> 
> wdyt?
> 

With this patch, the test now depends on the runtime return value of
bpf_jit_supports_fsession() rather than a compile-time #if macro.

This makes the test more extensible: when another architecture (e.g.
LoongArch) adds fsession support in the future, it only needs to
implement bpf_jit_supports_fsession() in its JIT backend, which will
enable the test without touching the test code at the same time.

For architectures that do not support fsession, the existing subtests
will be skipped in the same way as before, so a separate
'-EOPNOTSUPP'-specific subtest is not necessary.

Thanks,
Leon

