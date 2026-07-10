Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF26F422545
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783698252; cv=none; b=kLANhMdf6yREHwloaizrkkKZAaXkRcURVD8P304C7CpkyNObdcAwwKqzqlZGf2kwjeAS0U2v+yP7tzs3aou3t8RJ4oF/L46C/lkHjvZCB06oxRh6WyFeUbWOaiwF5CXvNl37hP7uXPYxZPKrRb/rEqwvAs+wOZ/3PGod/HBY+5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783698252; c=relaxed/simple;
	bh=TCjdOlVN5VsiVS5G9/zcGIlOX2Mrnnty8wmg/bxHoes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfPF5QvVy9szPC4jTEhtk3YvJYUv5iqmiwW2J7MT4AxOkGGCLRMNSS64BT3W4C3S5d7HahL6hQb/y+ckitVmBkBsKvi9N6QrkFCEExY8lxvDrvaq9BsvYLCcu0Pg5GjgQ8YRsYQjKyE5RWE/eQhF5QqlKE2CI2VC7dVOETwLK1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b0GhkuCD; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b0GhkuCD"
Message-ID: <8a01331a-8296-4860-a8f0-cdf3cfcfe19a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783698236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GPGeJudEf6et3fiACcWKhIe5Vz9K7dJmFGcd3lJV1/0=;
	b=b0GhkuCDsJEXZhnUAC0ATR9h47by6XDiwIcAYguNALAbc+Wi/P119LqgpL7e4ps5QNvtKL
	sBEKJbP7xIc3RekBDWlEAZtEWeH0fcYCBoVDqX2MpV/vVYFAnyq2mm4ubmv4j1b/09Spwp
	y99cjoqs2u573I55KSrkAz5rgNIE2xU=
Date: Fri, 10 Jul 2026 08:43:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add test for >8 byte return value
 on fexit attach
Content-Language: en-GB
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20260710144404.2579671-1-yonghong.song@linux.dev>
 <20260710144409.2580215-1-yonghong.song@linux.dev>
 <9401462c-ea70-4541-acb0-78cf2e6c34dc@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <9401462c-ea70-4541-acb0-78cf2e6c34dc@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/10/26 8:29 AM, Leon Hwang wrote:
> On 2026/7/10 22:44, Yonghong Song wrote:
>> The BPF trampoline preserves only 8 bytes of the target's return value
>> (R0), so attaching an fexit/fmod_ret/fsession program to a function that
>> returns a >8 byte value is now rejected by the verifier.
>>
>> Add a bpf_testmod function returning __int128 and an fexit program that
>> targets it. The program is expected to fail to load with the
>> "with a >8 byte return value is not supported for this attach type"
>> message.
>>
>> __int128 is only available on 64-bit targets (where the compiler defines
>> __SIZEOF_INT128__). Guard the testmod function and the test with
>> __SIZEOF_INT128__ so a 32-bit build still compiles; on such builds
>> the subtest is simply not run.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   .../selftests/bpf/prog_tests/tracing_failure.c      | 12 ++++++++++++
>>   tools/testing/selftests/bpf/progs/tracing_failure.c |  6 ++++++
>>   .../testing/selftests/bpf/test_kmods/bpf_testmod.c  | 13 +++++++++++++
>>   3 files changed, 31 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
>> index f9f9e1cb87bf..6c199f5ff4db 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
>> @@ -76,6 +76,14 @@ static void test_fexit_noreturns(void)
>>   			       "Attaching fexit/fsession/fmod_ret to __noreturn function 'do_exit' is rejected.");
>>   }
>>   
>> +#ifdef __SIZEOF_INT128__
>> +static void test_fexit_int128_ret(void)
>> +{
>> +	test_tracing_fail_prog("fexit_int128_ret",
>> +			       "with a >8 byte return value is not supported for this attach type");
>> +}
>
> Seems that this subtest can be simplified to
>
> static void test_fexit_int128_ret(void)
> {
> #ifdef __SIZEOF_INT128__
> 	test_tracing_fail_prog("fexit_int128_ret",
> 			       "with a >8 byte return value is not supported for this attach
> type");
> #else
> 	test__skip();
> #endif
> }
>
> Then, no '#ifdef' below.

Thanks. Let me test this.

>
> Thanks,
> Leon
>
>> +#endif
>> +
>>   void test_tracing_failure(void)
>>   {
>>   	if (test__start_subtest("bpf_spin_lock"))
>> @@ -86,4 +94,8 @@ void test_tracing_failure(void)
>>   		test_tracing_deny();
>>   	if (test__start_subtest("fexit_noreturns"))
>>   		test_fexit_noreturns();
>> +#ifdef __SIZEOF_INT128__
>> +	if (test__start_subtest("fexit_int128_ret"))
>> +		test_fexit_int128_ret();
>> +#endif
>>   }
>> diff --git a/tools/testing/selftests/bpf/progs/tracing_failure.c b/tools/testing/selftests/bpf/progs/tracing_failure.c
>> index 65e485c4468c..f7a095767679 100644
>> --- a/tools/testing/selftests/bpf/progs/tracing_failure.c
>> +++ b/tools/testing/selftests/bpf/progs/tracing_failure.c
>> @@ -30,3 +30,9 @@ int BPF_PROG(fexit_noreturns)
>>   {
>>   	return 0;
>>   }
>> +
>> +SEC("?fexit/bpf_testmod_test_int128_ret")
>> +int BPF_PROG(fexit_int128_ret)
>> +{
>> +	return 0;
>> +}
>> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> index 30f1cd23093c..902dbf658250 100644
>> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> @@ -161,6 +161,15 @@ bpf_testmod_test_arg_ptr_to_struct(struct bpf_testmod_struct_arg_1 *a) {
>>   	return bpf_testmod_test_struct_arg_result;
>>   }
>>   
>> +#ifdef __SIZEOF_INT128__
>> +noinline __int128
>> +bpf_testmod_test_int128_ret(int a)
>> +{
>> +	bpf_testmod_test_struct_arg_result = a;
>> +	return (__int128)a;
>> +}
>> +#endif
>> +
>>   __weak noinline void bpf_testmod_looooooooooooooooooooooooooooooong_name(void)
>>   {
>>   }
>> @@ -514,6 +523,10 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
>>   
>>   	(void)bpf_testmod_test_arg_ptr_to_struct(&struct_arg1_2);
>>   
>> +#ifdef __SIZEOF_INT128__
>> +	(void)bpf_testmod_test_int128_ret(i);
>> +#endif
>> +
>>   	(void)trace_bpf_testmod_test_raw_tp_null_tp(NULL);
>>   
>>   	bpf_testmod_test_struct_ops3();

