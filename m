Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E59844999A
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 19:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783627043; cv=none; b=CupP+0cFiYYP/lxC4kKLIdy+Z49eSiT68oGmTjniSMMcnjn4pEnQSYGfNxH0fegmhPYmGk5LphMob4565GTEQNNorl0E14m3HRMpqljF61ZdUloez1X3dreTNXAqWlDbaKepOW9gK+HR0ogLgjxcjhXUM67qYU1o7VT44xcC2cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783627043; c=relaxed/simple;
	bh=7mSDSVe1ihtK8CuWSfwLLXAjdvPaSbq2o+Yb8lJWrjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJUx87hgVHsUuiEzny5q8USgVhA+nkLsU+c9BLvym5gJROdSwwnzUQpypTjQOJ+Sj3RhzOGOqqq2+kd0BjZejXWByWQBAK27rDFdN0Ek3J00wq8pXmqN5u4RUi++3sAcbI6PYeTO/9xBlIxuScW+Lp8DgMXBV+map/UCsWCx5qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VBQGsO9w; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VBQGsO9w"
Message-ID: <1c92fd18-73e8-4fb0-9b7d-7cc943f7a9f5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783627040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=egztOJTU4NSZW6IcLd49xGTxM5RMw1TvOixu2gAEzgw=;
	b=VBQGsO9wHtSNAdCg9Fa2kkT4SpijnTVrXmmPEBPsk4Rg/aG9M8wJpSld4Dg8L6HlFUNfvA
	ryr8IkBujR0Jxe7xNrAW4rAWd9Wnla/nih1ZwG+14Ha8wh/5fxABfOBP25IBfmJ2I/1UNR
	X963etPnEs/gN0Wk/I4GnMCBBF3RtLQ=
Date: Thu, 9 Jul 2026 12:57:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 10/12] selftests/bpf: Add inline-asm and subprog
 tests for R0:R2 returns
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
 <20260708201030.2161016-1-yonghong.song@linux.dev>
 <20260708202830.4BBDE1F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260708202830.4BBDE1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/8/26 1:28 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Hardcoded little-endian assumptions in struct and `__int128` register unpacking will cause selftest failures on big-endian architectures like s390x.
> --
>
> --- Patch [10]: [PATCH bpf-next 10/12] selftests/bpf: Add inline-asm and subprog tests for R0:R2 returns ---
> commit dcf423ead16608630f40807ad0cde33d495c941d
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> selftests/bpf: Add inline-asm and subprog tests for R0:R2 returns
>
> Add inline-asm and subprogram tests for more coverage, including
> BPF-to-BPF cases, kfunc cases, backtracking and liveness. Both positive
> and negative tests are added.
>
>> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_run.c b/tools/testing/selftests/bpf/progs/aggregate_ret_run.c
>> new file mode 100644
>> index 0000000000000..d6300b31733d8
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_run.c
> [ ... ]
>
>> @@ -0,0 +1,160 @@
> [ ... ]
>
>> +SEC("tc")
>> +int aggregate_ret_asm_test(struct __sk_buff *skb)
>> +{
>> +	__u64 a = skb->len;
>> +	__u64 b = skb->len ^ 0xdeadbeefULL;
>> +	__u64 lo, hi;
> [ ... ]
>
>> +	asm volatile (
>> +	"r1 = %[a];"
>> +	"r2 = %[b];"
>> +	"call %[kfunc];"
>> +	"%[lo] = r0;"
>> +	"%[hi] = r2;"
>> +	: [lo]"=r"(lo), [hi]"=r"(hi)
>> +	: [a]"r"(a), [b]"r"(b), [kfunc]"i"(bpf_kfunc_call_test_i128)
>> +	: "r0", "r1", "r2", "r3", "r4", "r5"
>> +	);
>> +	if (hi != a)
>> +		return 3;
>> +	if (lo != b)
>> +		return 4;
> [Severity: Medium]
> The test expects the high 64 bits (a) in r2 and the low 64 bits (b) in
> r0. On a big-endian ABI, the most significant 64 bits (a) will be returned
> in the first register (r0).
>
> Will this cause the test to fail on big-endian architectures like s390x?

Good point. I need to test it for s390x.

>
>> +
>> +	return 0;
>> +}
>> +
>> +SEC("tc")
>> +int aggregate_ret_struct_test(struct __sk_buff *skb)
>> +{
>> +	__u64 a = skb->len;
>> +	__u64 b = skb->len ^ 0xdeadbeefULL;
>> +	__u64 lo, hi;
> [ ... ]
>
>> +	/* struct { u64 a; int b; }: R0 = a, low 32 bits of R2 = b. */
>> +	asm volatile (
>> +	"r1 = %[a];"
>> +	"r2 = %[b];"
>> +	"call %[kfunc];"
>> +	"%[lo] = r0;"
>> +	"%[hi] = r2;"
>> +	: [lo]"=r"(lo), [hi]"=r"(hi)
>> +	: [a]"r"(a), [b]"r"(b), [kfunc]"i"(bpf_kfunc_call_test_ret_li)
>> +	: "r0", "r1", "r2", "r3", "r4", "r5"
>> +	);
>> +	if (lo != a)
>> +		return 3;
>> +	if ((int)hi != (int)b)
>> +		return 4;
> [Severity: Medium]
> The bitwise extraction (int)hi assumes the 4-byte b is in the lower 32
> bits of r2. On big-endian, wouldn't b be placed in the upper 32 bits of
> the register, causing this assertion to fail?

The same as above. Need tests with s390x.

>
>> +
>> +	/* struct { int a; int b; }: 8 bytes, packed into R0; R2 is not used. */
>> +	asm volatile (
>> +	"r1 = %[a];"
>> +	"r2 = %[b];"
>> +	"call %[kfunc];"
>> +	"%[lo] = r0;"
>> +	: [lo]"=r"(lo)
>> +	: [a]"r"(a), [b]"r"(b), [kfunc]"i"(bpf_kfunc_call_test_ret_ii)
>> +	: "r0", "r1", "r2", "r3", "r4", "r5"
>> +	);
>> +	if ((int)lo != (int)a)
>> +		return 5;
>> +	if ((int)(lo >> 32) != (int)b)
>> +		return 6;
> [Severity: Medium]
> The bitwise extraction (int)lo and (lo >> 32) assumes a little-endian
> register layout for the returned 8-byte struct. On big-endian, wouldn't a
> be in the upper 32 bits and b in the lower 32 bits?

Will test as the above.

>
>> +
>> +	return 0;
>> +}

