Received: from mta0.migadu.com (out-87.mta0.migadu.com [91.218.175.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4047C4F405C
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569579; cv=none; b=YmF6iG166+CvyV+O1IIiOWpoJRVD29CeoeO8aGRfs0NG1Cn43bC8PcT6UJTFQ1xwfDP43HpzHd19HUppohU+Js7l14J5U8La0mGRvp9z+yg41lPwZGK5QXROWHrLV4kfC5lQqtMQ9TFJ2yBfoloW2hlGOtb5ITywiimAnV8q8Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569579; c=relaxed/simple;
	bh=8QryxlV+6DrDBD5DgfUI2UwSedPXiMspTrjhKUVcm1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aa8tTbUFOfO5xNWvvq7vr2aT+ecOvCZg+/RXaR9ZPvbnutWlwsXFSJnv0fXnSLwe/wcvbg9aPNYxDvVDFmy0RcNBLGO083WCDJYVJ5K6bVBrpyrQggUBpKdWlISRNfooxZ7D5BdLfsQnuU5JrNQ4BAtRV2g/fOp51+ceAnqQS8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sJ75LbMl; arc=none smtp.client-ip=91.218.175.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sJ75LbMl"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8QryxlV+6DrDBD5DgfUI2UwSedPXiMspTrjhKUVcm1c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791569574; v=1; x=1792174374;
 b=sJ75LbMlG5FepUFr6/sXTjo9AAN5GuTwQYKqM6d6aGUr2tXOZqYtkT9HYkBOBRMdwAbK5u1/
 BoV1WVbFR7K2ZvpSpS3Roz+Jv8ACv/+Fc7IrfFs1PyjtuH3gJ2o4G8xN7+0X4kqWRghIb61UVgZ
 cMARta2/yys8VaPRXyV09d/I=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b8f0ae7a855160db;
	Fri, 09 Oct 2026 18:12:53 +0000
X-Mizu-Trace-ID: b8f0ae7a855160db
X-Migadu-Flow: FLOW_OUT
Message-ID: <1547e6f7-9944-411c-9701-3b7f504fe576@linux.dev>
Date: Fri, 9 Oct 2026 20:12:53 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: Test trampoline args around a
 16-byte aligned stack arg
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261009064206.1238047-1-yonghong.song@linux.dev>
 <20261009064228.1240628-1-yonghong.song@linux.dev>
 <sashiko-outbox-164968@kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <sashiko-outbox-164968@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/9/26 8:51 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] bpf: endianness mismatch when reading __int128 in selftests on big-endian
> - [Medium] selftests/bpf: data race on bpf_testmod_test_struct_arg_result
> --
>
> commit 44831c6b1a0172e1d0713d17a8e105c4b30d6d64
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> selftests/bpf: Test trampoline args around a 16-byte aligned stack arg
>
> This commit introduces two new bpf_testmod functions to test trampoline
> argument handling for 16-byte aligned stack arguments, specifically targeting
> __int128 structures. It also adds fentry and fexit programs to verify that
> arguments are correctly packed in the context array according to BPF
> conventions on x86-64 and arm64.
>
>> diff --git a/tools/testing/selftests/bpf/progs/tracing_struct_int128.c b/tools/testing/selftests/bpf/progs/tracing_struct_int128.c
>> index 4638dfec1f38e..5520ee500c01d 100644
>> --- a/tools/testing/selftests/bpf/progs/tracing_struct_int128.c
>> +++ b/tools/testing/selftests/bpf/progs/tracing_struct_int128.c
>> @@ -15,4 +15,49 @@ int test_int128_arg_fexit(unsigned long long *ctx)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * The arguments come packed in the BPF convention whatever holes the
>> + * kernel convention left between them: an eightbyte each, and two for the
>> + * struct holding an __int128.
>> + */
>> +long s_g, s_h_lo, s_h_hi, s_i, s_ret;
>> +
>> +SEC("fentry/bpf_testmod_test_int128_stack")
>> +int test_int128_stack_fentry(unsigned long long *ctx)
>> +{
>> +	s_g = ctx[6];
>> +	s_h_lo = ctx[7];
>> +	s_h_hi = ctx[8];
> [Severity: Medium]
> Will this little-endian assumption cause the selftest to fail on big-endian
> systems? On big-endian arm64 (aarch64_be), the high 64 bits of the 16-byte
> struct would be at the lower memory address, so reading ctx[7] as the low
> 64 bits and ctx[8] as the high 64 bits might be reversed.

Okay, I will use __BYTE_ORDER__ to guard. The same for below.

>
>> +	s_i = ctx[9];
>> +	return 0;
>> +}
>> +
> [ ... ]
>
>> +long b_f_a, b_f_b, b_g, b_h, b_i_lo, b_i_hi, b_ret;
>> +
>> +SEC("fentry/bpf_testmod_test_int128_backfill")
>> +int test_int128_backfill_fentry(unsigned long long *ctx)
>> +{
>> +	b_f_a = ctx[5];
>> +	b_f_b = ctx[6];
>> +	b_g = ctx[7];
>> +	b_h = ctx[8];
>> +	b_i_lo = ctx[9];
>> +	b_i_hi = ctx[10];
> [Severity: Medium]
> Does this have the same endianness mismatch on big-endian architectures?
> Extracting the 16-byte struct here from ctx[9] and ctx[10] also seems to
> assume a little-endian memory layout.
>
>> +	return 0;
>> +}
>> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> index 54a5fc39e0e27..23a2c88d3e7c1 100644
>> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> [ ... ]
>
>> +noinline long
>> +bpf_testmod_test_int128_stack(u64 a, u64 b, u64 c, u64 d, u64 e, u64 f,
>> +			      u64 g, struct bpf_testmod_struct_int128 h, u64 i)
>> +{
>> +	bpf_testmod_test_struct_arg_result = a + b * 2 + c * 3 + d * 4 + e * 5 +
>> +		f * 6 + g * 7 + (u64)h.a * 8 +
>> +		(u64)((unsigned __int128)h.a >> 64) * 9 + i * 10;
>> +	return bpf_testmod_test_struct_arg_result;
>> +}
> [Severity: Medium]
> Can concurrent execution of tests (like test_progs -j) lead to a data race on
> this global variable? If one test thread computes the result in
> bpf_testmod_test_int128_stack() and another thread overwrites
> bpf_testmod_test_struct_arg_result in a different function before the first
> returns, it could cause the BPF fexit hook to read an incorrect return value
> into s_ret, leading to flaky ASSERT_EQ failures.

I will double check this. One thing we could do is to have the *same* inputs.

>
>> +
>> +/*
>> + * x86-64 has no register left for f after e, so f goes to the stack and g
>> + * takes R9 back; h goes to the third stack slot and i, aligned to 16
>> + * bytes, to the fifth and sixth. arm64 has registers up to g, puts h in
>> + * the first stack slot and i in the third and fourth.
>> + */
>> +noinline long
>> +bpf_testmod_test_int128_backfill(u64 a, u64 b, u64 c, u64 d, u64 e,
>> +				 struct bpf_testmod_struct_arg_2 f, u64 g, u64 h,
>> +				 struct bpf_testmod_struct_int128 i)
>> +{
>> +	bpf_testmod_test_struct_arg_result = a + b * 2 + c * 3 + d * 4 + e * 5 +
>> +		f.a * 6 + f.b * 7 + g * 8 + h * 9 + (u64)i.a * 10 +
>> +		(u64)((unsigned __int128)i.a >> 64) * 11;
>> +	return bpf_testmod_test_struct_arg_result;
> [Severity: Medium]
> Since this function also writes to the unprotected global variable
> bpf_testmod_test_struct_arg_result and immediately returns it, could this
> contribute to the same data race when multiple test processes run
> trigger_module_test_read() concurrently?
>
>> +}
>>   #endif

