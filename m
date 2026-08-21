Received: from mta0.migadu.com (out-153.mta0.migadu.com [91.218.175.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEA434E74D
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 23:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787356153; cv=none; b=gB5yRtw5xTt9o5qNoS/jjnPl3s6qVwvAezBzRw9ZvixsRjzi2VQCi/kp6fjCfiZvyDIBtzkQvIgh1iQvsq4C/vILF4Zt1h8fD1QoQzBljCHW2d1/2jNHWz1binAlsKI5oPe62RevkwH0TDUkcP66UBegNqSgRXOXzdP3PQkPguo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787356153; c=relaxed/simple;
	bh=PsebECZBSEMh/j0CVmoaocfy4hcuK5Ir6jTpWXywjUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GmSCDx4xe47xukycZHSKwF9jY6LiBp07Cg0lXXxJqAT6MRPXJ2ZZTmbES+s79mraslT3nuGwZ9CJmqMRyzqZGZlpsJ4fwiqr/JXc2kj9yWIDYKWtwSy7KBpnom6GCnEKy8saUazn/XVE1Gn9geDqqM5dmXDqZWgbeqS5WDB2ut4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T4HxTLFw; arc=none smtp.client-ip=91.218.175.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T4HxTLFw"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PsebECZBSEMh/j0CVmoaocfy4hcuK5Ir6jTpWXywjUE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787356148; v=1; x=1787960948;
 b=T4HxTLFwpHzBrjXt1MXAXfFleG1m9O1T94Tt/Brh21FxIEL9thUZ6Ns3uQtHHMPr+dg5oIME
 auKBxzmSLeth/DHqs/QFSMFgSDmEbLq2jEHcn77yxhL5ZQfkzl078XXMQH3J28PV8d6v0YCDdXz
 PDoPW94isQn20qIYCmjg1wjE=
X-Envelope-To: bpf@vger.kernel.org
Received: from [192.168.50.189] (67.169.75.212)
	by smtp.migadu.com with ESMTPS id dc4ae009e1ba8784;
	Fri, 21 Aug 2026 23:48:58 +0000
X-Mizu-Trace-ID: dc4ae009e1ba8784
X-Migadu-Flow: FLOW_OUT
Message-ID: <1d951995-9ef3-4429-9135-7e4acae3fe17@linux.dev>
Date: Fri, 21 Aug 2026 16:48:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: report placeholder tests as
 SKIP, not OK
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
References: <20260821201316.1059129-3-vineet.gupta@linux.dev>
 <a181212ec47fdfcbe52fde90fa8a3c6511f1d4497e98adf330d9f741f42aec37@mail.kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <a181212ec47fdfcbe52fde90fa8a3c6511f1d4497e98adf330d9f741f42aec37@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/21/26 2:00 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
>> index 5eacf1b43252..88b0bfba83bb 100644
>> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
>> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
>> @@ -106,6 +106,11 @@
>>    * __description     Text to be used for display and as an additional filter
>>    *                   alias, while the original program name stays matchable.
>>    *
>> + * __skip            Report the test as SKIP with the given reason instead of
>> + *                   running it. For placeholder programs that stand in for a
>> + *                   feature the toolchain or JIT cannot provide, so a run does
>> + *                   not report OK for coverage it never executed.
>> + *
>>    * __log_level       Log level to use for the program, numeric value expected.
>>    *
>>    * __flag            Adds one flag use for the program, the following values are valid:
>> @@ -139,6 +144,7 @@
>>   #define __failure		__test_tag("test_expect_failure")
>>   #define __success		__test_tag("test_expect_success")
>>   #define __description(desc)	__test_tag("test_description=" desc)
>> +#define __skip(reason)		__test_tag("test_skip=" reason)
>>   #define __msg_unpriv(msg)	__test_tag("test_expect_msg_unpriv=" msg)
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
>> index 41340877dc9d..e58ea69e3854 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
>> @@ -436,6 +436,7 @@ void kfunc_root(void)
>>
>>   SEC("socket")
>>   __description("cpuv4 is not supported by compiler or jit, use a dummy test")
>> +__skip("cpuv4 is not supported by compiler or jit")
>>   __success
>>   int dummy_test(void)
>>   {
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
>> index 07807757b518..794a7dfb0579 100644
>> --- a/tools/testing/selftests/bpf/test_loader.c
>> +++ b/tools/testing/selftests/bpf/test_loader.c
>> @@ -70,6 +70,7 @@ struct test_spec {
>>   	int arch_mask;
>>   	int load_mask;
>>   	int linear_sz;
>> +	const char *skip_reason;
>>   	bool auxiliary;
>>   	bool valid;
>>   };
>> @@ -456,6 +457,8 @@ static int parse_test_spec(struct test_loader *tester,
>>   			continue;
>>   		if ((val = str_has_pfx(s, "test_description="))) {
>>   			description = val;
>> +		} else if ((val = str_has_pfx(s, "test_skip="))) {
>> +			spec->skip_reason = val;
>>   		} else if (strcmp(s, "test_expect_failure") == 0) {
>>   			spec->priv.expect_failure = true;
>>   			spec->mode_mask |= PRIV;
>> @@ -1327,6 +1330,12 @@ void run_subtest(struct test_loader *tester,
>>   	if (!test__start_subtest_with_desc(subspec->name, subspec->description))
>>   		return;
>>
>> +	if (spec->skip_reason) {
>> +		printf("%s:SKIP: %s\n", __func__, spec->skip_reason);
>> +		test__skip();
>> +		return;
>> +	}
>> +
>>   	if ((get_current_arch() & spec->arch_mask) == 0) {
>>   		test__skip();
>>   		return;
> The commit converts 13 placeholder programs to use the new __skip()
> annotation, but two feature-gated placeholders with the identical
> pattern were not converted. Were these intentionally excluded?
>
> The preceding commit b1831d82fe2c states "Eleven of the thirteen
> feature-gated placeholder programs are called dummy_test", but grep
> finds fifteen such programs.
>
> tools/testing/selftests/bpf/progs/verifier_aggregate_ret.c has a
> compile-time gate at line 8:
>
>    #if defined(__clang_major__) && __clang_major__ >= 23
>
> with its #else arm at lines 166-172 supplying the same __success
> placeholder pattern that this commit converts everywhere else:
>
>    #else
>
>    SEC("socket")
>    __description("verifier_aggregate_ret: needs LLVM 23, dummy test")
>    __success
>    int dummy_test(void)
>
> Similarly, tools/testing/selftests/bpf/progs/verifier_percpu_addr.c has
> a gate at line 7:
>
>    #if defined(__TARGET_ARCH_x86)
>
> with its #else placeholder at lines 60-66:
>
>    #else
>
>    SEC("raw_tp")
>    __description("percpu addr dummy")
>    __success
>    int dummy_test(void)
>
> Both reach the modified test_loader.c code path via
> prog_tests/verifier.c (test_verifier_aggregate_ret and
> test_verifier_percpu_addr), so __skip() would work for them.
>
> The gates fire today, so the placeholders are what actually gets built
> and reported:
> - verifier_aggregate_ret.c: any toolchain older than clang 23
> - verifier_percpu_addr.c: every non-x86 build (arm64, s390x, riscv64,
>    loongarch)
>
> On those builds these two tests still report OK for coverage that never
> executed.

Bot is correct. The reason is the older baseline I first worked against 
had the aforementioned numbers. After rebase I did remember to rerun the 
numbers but obviously there was some snafu. I'll fix this in v2.

Thx,
-Vineet
