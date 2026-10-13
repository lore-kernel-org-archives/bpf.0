Received: from mta0.migadu.com (out-93.mta0.migadu.com [91.218.175.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD9B3EB80D
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900453; cv=none; b=JCyRn4RrSMQxf1c3FZDvERRW2aAdn/iZshdemR8p6PC2Z3hKUy9kSCK2xCxc+RMH+GuJV8ZH4/WFJydUWNdw0vTwSiS8xM5M+oOh1l9ExrI7OwpDl4F/ay2gb5XvBoTNdAs1Yv76tYEAtsk4c8Jz500iXFMcbeleh5rJoNDNvrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900453; c=relaxed/simple;
	bh=5BlXIF0AyB1kJAXhkN5mj6wdVNbcBMnSUOhsmJfw7hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HLue3JPUf6MJPCQDGFTOzSRSLlPJhhXT0z6Fr/nFVROktRSz+heRJcpgndNGZjfUAwEB6Y0MRxTrVPW5hLXkFKMrBP7Da4Tv5d+1kZENGzrptxpxXPKblVCaessV3jgmi4koMopF0A0abjnKNySUM+Iu+ttgLIaggWV5daNpTOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=omcr5yoR; arc=none smtp.client-ip=91.218.175.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="omcr5yoR"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5BlXIF0AyB1kJAXhkN5mj6wdVNbcBMnSUOhsmJfw7hs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791900449; v=1; x=1792505249;
 b=omcr5yoRLuxNp/8lY2PqupyZRLBeff4lfU1Fbq3x0BX+7BHosJ4CuDeDyK5IM6U1ACN0f0aJ
 Af842HB/sE/pYFRezaA6pQs4zJfYGLyI1rxqHKm3K5cv2fdw6tMjgcgWgEsheREgym9CAJJujgs
 tvBXR1hlDB7+JSXr5O55Y088=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1dd4546aa31d3090;
	Tue, 13 Oct 2026 14:07:29 +0000
X-Mizu-Trace-ID: 1dd4546aa31d3090
X-Migadu-Flow: FLOW_OUT
Message-ID: <4193e7d0-ce1b-4732-bc8f-00badbfd08fd@linux.dev>
Date: Tue, 13 Oct 2026 07:07:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 06/11] selftests/bpf: Test trampoline args
 around a 16-byte aligned stack arg
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261013003429.1853052-1-yonghong.song@linux.dev>
 <20261013003459.1857895-1-yonghong.song@linux.dev>
 <sashiko-outbox-168812@kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <sashiko-outbox-168812@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/13/26 2:43 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] bpf: endianness assumption causes selftest failure on aarch64 big-endian
> --
>
> commit df1efd6b9c0e934bad453d07e6efe674bda8e1e6
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> selftests/bpf: Test trampoline args around a 16-byte aligned stack arg
>
> This commit adds tests for bpf_testmod functions taking a 16-byte aligned
> struct containing an __int128. It checks that the BPF trampoline packs
> these arguments correctly according to the BPF calling convention.
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
>> index 8086586d3e196..a2da219e14769 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
> [ ... ]
>> @@ -141,6 +143,20 @@ static void test_int128_args(void)
>>   	ASSERT_EQ(skel->bss->t_c, 3, "t:c");
>>   	ASSERT_EQ(skel->bss->t_ret, 6, "t ret");
>>   
>> +	ASSERT_EQ(skel->bss->s_g, 7, "s:g");
>> +	ASSERT_EQ(skel->bss->s_h_lo, 8, "s:h.lo");
>> +	ASSERT_EQ(skel->bss->s_h_hi, 9, "s:h.hi");
> [Severity: Low]
> Does this code assume a little-endian memory layout for the __int128
> argument?
>
> The test passes a 16-byte struct containing ((__int128)9 << 64) | 8.
> On big-endian architectures like aarch64 (when configured with
> CONFIG_CPU_BIG_ENDIAN), the most significant 64 bits (9) are placed at the
> lowest address, and the least significant bits (8) at the higher address.
> This hardcoded expectation for the little-endian layout appears to cause the
> test_int128_args selftest to fail its assertions on big-endian systems.

Ok, will fix due to possible arm64 big endian.

>
>> +	ASSERT_EQ(skel->bss->s_i, 10, "s:i");
>> +	ASSERT_EQ(skel->bss->s_ret, 385, "s ret");
> [ ... ]
>> diff --git a/tools/testing/selftests/bpf/progs/tracing_struct_int128.c b/tools/testing/selftests/bpf/progs/tracing_struct_int128.c
>> index 4638dfec1f38e..5520ee500c01d 100644
>> --- a/tools/testing/selftests/bpf/progs/tracing_struct_int128.c
>> +++ b/tools/testing/selftests/bpf/progs/tracing_struct_int128.c
> [ ... ]
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
> [Severity: Low]
> Is this direct array indexing in test_int128_stack_fentry() subject to the
> same endianness assumption?
>
> When the BPF trampoline projects the struct onto the u64 ctx[] array on a
> big-endian system, ctx[7] receives 9 and ctx[8] receives 8, rather than the
> little-endian projection expected here.

Ok, will fix due to possible arm64 big endian.

>
>> +	s_i = ctx[9];
>> +	return 0;
>> +}

