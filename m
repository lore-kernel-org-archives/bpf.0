Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12AF2BE7AB
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 19:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786216582; cv=none; b=d2zcXjnWVBM88tRGJw+olCSQy4ewtMHER0h6NHiElBRaEqdMqmbCmDXFkcFdp5RDKSuGbRStykQIjrxRDqXvISEZtZ9n4VXz5HkSQYB0YLn1NoQX38w6iGIoqXiy6DxpL8x/NrO2NEX8MO9AMYrp2A7WIfEdQ70SVN1PQ4h3JZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786216582; c=relaxed/simple;
	bh=1k3PRKvSp4V0Jh2lfQZADww5D/Dx6/ISO/nBJ2/7T+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/3mrr02cYGGd81aamCUP2ZWFBbh8uFHJI0uUeaKaI5hce1rtEZUOSl63gu0tVUSRP36+sXMRp9WM1UzFUo3frbBQNfiqlhpkGmckRvPktc/xO5UAcPpxaNORoPrsKu5W1MUyu+u+4x+ElUOwCG+ful77tweJHBRPncp5RnXB+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u9pDzhEQ; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u9pDzhEQ"
Message-ID: <75246a5e-f298-48e4-9492-49b13eca5e1d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786216568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mb9wu8GmsGvlp0KDE1lNiqOmE6iaBpXGmBN5mmc6LJY=;
	b=u9pDzhEQLU1ggIpMXS2kWbqypZQ+LTHy+MPUuVktSL0TMXMHOLSGJlYZfnnoRHnnbU9SBE
	ZaAmmk4TF+g5A11YWOvPal2jK5ol+zHOjk9MLOSQgjZJOQMT4ln3A5g2Y7iOiqeJ3eAHO8
	QOEtIUV6W/XCxtn7nQb1myekeB/0oos=
Date: Sat, 8 Aug 2026 12:16:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/4] selftests/bpf: map_kptr: expect BPF_ST
 reject msg on cpuv4 toolchains
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev, Vineet Gupta <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org
References: <20260807204434.1036279-1-vineet.gupta@linux.dev>
 <20260807204434.1036279-2-vineet.gupta@linux.dev>
 <20260807205315.949CF1F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260807205315.949CF1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/7/26 1:53 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The patch conditionally alters the expected verifier error message for BPF_ST toolchains, which eliminates the test's intended coverage (verifying that `map_kptr_match_type()` rejects scalar registers) on modern compilers and introduces brittleness tied to compiler optimization levels. As acknowledged in the commit message, the test now bypasses the original validation path, and changes in optimization (e.g., compiling at -O0) will break the `#ifdef` logic because the compiler may still emit `BPF_STX`. A more robust approach is to force the compiler to emit `BPF_STX` (e.g., by using a 64-bit constant that cannot be encoded as a 32-bit immediate, or by using `barrier_var()`), which preserves the intended verifier coverage without relying on fragile macro checks.
> --
>
> --- Patch [1]: [PATCH bpf-next v2 1/4] selftests/bpf: map_kptr: expect BPF_ST reject msg on cpuv4 toolchains ---
> commit 302e7847f20b43d2cf543bac72a29e4a57633dfa
> Author: Vineet Gupta <vineet.gupta@linux.dev>
>
> selftests/bpf: map_kptr: expect BPF_ST reject msg on cpuv4 toolchains
>
> This commit modifies the reject_scalar_store_to_kptr test to expect a
> different verifier error message on toolchains supporting BPF_ST. This
> avoids a test failure when the compiler folds the constant into a
> BPF_ST store immediate instruction instead of using BPF_STX.
>
>> diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
>> index f11848dfa78f9..5e25ca806060c 100644
>> --- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
>> +++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
>> @@ -386,7 +386,16 @@ int kptr_xchg_possibly_null(struct __sk_buff *ctx)
>>   }
>>   
>>   SEC("?tc")
>> +/*
>> + * A compiler with BPF_ST folds the constant into a store-immediate, which the
>> + * verifier rejects on a different path (and with a different message) than the
>> + * BPF_STX form.
>> + */
>> +#ifdef __BPF_FEATURE_ST
>> +__failure __msg("BPF_ST imm must be 0 when storing to kptr at off=8")
>> +#else
>>   __failure __msg("invalid kptr access, R")
>> +#endif
> [Severity: Medium]
> Does this conditionally altered expectation eliminate the test's intended
> coverage on modern toolchains?
>
> As noted in the commit message, the test now bypasses the original validation
> path on BPF_ST builds, meaning it no longer verifies that
> map_kptr_match_type() rejects scalar registers.
>
> This also appears to introduce brittleness. If the optimization level changes
> (such as compiling at -O0), the compiler might still emit BPF_STX, which would
> evaluate the wrong macro branch and fail the test.

The -O0 is not really working for most bpf programs. The current selftests are
using -O2 so let us stick with it (-O2).

>
> Would it be more robust to force the compiler to emit BPF_STX here, for
> example by using a 64-bit constant that cannot be encoded as a 32-bit
> immediate, or by using barrier_var()? This could preserve the intended
> verifier coverage across different toolchains and optimization levels.

The__BPF_FEATURE_ST macro in llvm is able to differentiate cpu v3 and v4. 
This should work for both gcc and clang if gcc follows clang macros.

>
>>   int reject_scalar_store_to_kptr(struct __sk_buff *ctx)
>>   {
>>   	struct map_value *v;

