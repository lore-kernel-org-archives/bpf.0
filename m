Received: from out-181.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD8E2EB5A6
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786206929; cv=none; b=bkYEBygemSrbZeF47Jl3pHC7Ez88KrN17GEy85PjZtk2D/71eH70iajzTmDl5iHwAQhfc5nYW4/MKhzRe8iz6rUw8arOn4cuVBEmR/rO04Pa1moMQLhwg50rhk0CzxfDGkvAyG3+sOHnJ7cs9onhgAd9J+BVqRjtePbESX+yLeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786206929; c=relaxed/simple;
	bh=18DJpk9wXtyyBNNK67us14vlzm1+nFDu9lSHZjc7L8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lz/6syWAyNfgrlTb2drlbkWjg5c1BtwoXCa5qENy83e3L7cVqxKbF61HE88cm8b8OCI/fIMlaCS38K40te3lsYHOX2yfSUKsjTS8eDTJiZb4dx0vc1p2fyqNVT7F1tJKUcZL/tDJ7uC0DQtbPpezqwGu+CZHQrFa5kDM7o368po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OXTDi25A; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OXTDi25A"
Message-ID: <a541a346-17e1-427f-ab06-5019cefe0db0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786206925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIugQcjB5OO+H2rP7M3ggR3iV4DyJuRB2BEzkRQcojY=;
	b=OXTDi25A1XFEls4s30L7Nk2fQ8WcXAJ2GgKn2ukkvTfs0N7dW6EaVcBHTOqvlAfgh1InQO
	757wFSTdXpPcfcCl3dVZpr+B3v3ac/lOp3asRiJUkj/ZFaVYMwWCwmc8Hbiz5KnL70bhDf
	jhhyveUZDCcpr8PEQV/H1k5ucoEqXu4=
Date: Sat, 8 Aug 2026 09:35:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 11/13] selftests/bpf: Add inline-asm and
 subprog tests for R0:R2 returns
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260804203522.1869244-1-yonghong.song@linux.dev>
 <20260804203618.1878749-1-yonghong.song@linux.dev>
 <20260804205243.5F7E71F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260804205243.5F7E71F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/4/26 1:52 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The inline assembly tests verifying kfunc struct returns and __int128 values incorrectly assume little-endian register packing, which will cause deterministic test failures on big-endian architectures.
> --
>
> --- Patch [11]: [PATCH bpf-next v2 11/13] selftests/bpf: Add inline-asm and subprog tests for R0:R2 returns ---
> commit 43d5815a2f48399212b5d17d74ef9350c219fc0e
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> selftests/bpf: Add inline-asm and subprog tests for R0:R2 returns
>
> Add inline-asm tests, which do not depend on the compiler lowering a
> register-pair return and so run regardless of the LLVM version, covering
> what the C tests cannot reach.
>
>> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_run.c b/tools/testing/selftests/bpf/progs/aggregate_ret_run.c
>> new file mode 100644
>> index 0000000000000..fac813531b4fe
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_run.c
> [ ... ]
>
>> +SEC("tc")
>> +int aggregate_ret_asm_kfunc_test(struct __sk_buff *skb)
>> +{
>> +	__u64 a = skb->len;
>> +	__u64 b = skb->len ^ 0xdeadbeefULL;
>> +	__u64 lo, hi;
>> +
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
>> +	if (hi != a + b)
>> +		return 1;
>> +	if (lo != a - b)
>> +		return 2;
> [Severity: Medium]
> Does this assume little-endian register packing for the __int128 return value?
>
> On big-endian architectures, the high bits typically occupy the first register
> (R0) and the low bits occupy R2, which would cause this check to fail when
> testing kfunc __int128 returns.

For x86_64, arm64 and 64bit riscv, only arm64 supports both little and big
endian. For simplificty, I will guard the above (and below) for little endian
so x86_64, arm64 and 64bit riscv all covered properly with selftests.

>
> [ ... ]
>
>> +SEC("tc")
>> +int aggregate_ret_struct_test(struct __sk_buff *skb)
>> +{
>> +	__u64 a = skb->len;
>> +	__u64 b = skb->len ^ 0xdeadbeefULL;
>> +	__u64 lo, hi;
>> +
>> +	/* struct { u64 hi; u64 lo; }: R0 = hi, R2 = lo. */
>> +	asm volatile (
>> +	"r1 = %[a];"
>> +	"r2 = %[b];"
>> +	"call %[kfunc];"
>> +	"%[lo] = r0;"
>> +	"%[hi] = r2;"
>> +	: [lo]"=r"(lo), [hi]"=r"(hi)
>> +	: [a]"r"(a), [b]"r"(b), [kfunc]"i"(bpf_kfunc_call_test_ret_pair)
>> +	: "r0", "r1", "r2", "r3", "r4", "r5"
>> +	);
>> +	if (lo != a + b)
>> +		return 1;
>> +	if (hi != a - b)
>> +		return 2;
>> +
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
>> +	if ((int)hi != ~(int)b)
>> +		return 4;
> [Severity: Medium]
> Will this check fail deterministically on big-endian systems?
>
> The test expects the 32-bit integer b to be in the lower 32 bits of R2. On
> big-endian platforms, b would occupy the upper 32 bits of R2, leaving the
> lower 32 bits as padding.
>
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
>> +
>> +	return 0;
>> +}
> [Severity: Medium]
> Could the layout of this 8-byte struct in R0 differ depending on endianness?
>
> The hardcoded cast to (int)lo reads the lower 32 bits of R0. On big-endian
> architectures, the first member of the struct (a) is located in the upper 32
> bits, so reading the lower 32 bits will yield b instead, causing a spurious
> test failure.
>

