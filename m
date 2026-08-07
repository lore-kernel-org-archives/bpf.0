Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A602C3EEACF
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786137365; cv=none; b=Wn9KTZPQehY/vley/nlhZW51agh1HBmLxRJQhd35eyjmWGhQlYxztSApKpKrj+9qefn6UfXdjCDiHsmJuCUZY8O4SKMsXqX0Ynr4V7v4Hx992MzJ3NOJ6pWnGSX9TxXs+nrVuoxVS5zFu7oFGvapl1gm5Yo7g0bXHJ1wrxEL7Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786137365; c=relaxed/simple;
	bh=v4IYmJri4vxmmibVnQ6R1r9bIw3Fx0W6fjLWwxmd7+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QmTm19rJtan72rmFriNtTk/zyOY86Dy9rdaNW+/tsEpkLhWgXX6jXiV2kKG+iiIaGdy6y6GkL2bo12BJFArGcHJRA6v62QoDVO8NepPWEs/3LJwb7FU/Sxhg9w8WxXu3etn4ILSlerfRP+Va+kU0YTplz8gCPk3DJ/n6/uboebE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=imsuWnwg; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="imsuWnwg"
Message-ID: <ef1f26aa-77e7-4c49-9650-fb974114d6b0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786137353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/00kpmjXBCD6iXf1S9pefgezRk5hMJEGyJKyhMv22g=;
	b=imsuWnwg6+Wki4UZn8OoF29Y9p332EKxpMDgeCW/Qo5D7B9TZFWBCFBPf3seSTuIj2M1S+
	P6VzGGir856LJFAIH0rWonkGHErmNEeQy7Y9KI0/RhhovBbAfqvdvxSN1J1nYN5LF2lBS9
	Cd2FWcDKPPyqpVy+xwACvdPwrEukNRo=
Date: Fri, 7 Aug 2026 14:15:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/4] selftests/bpf: map_kptr: expect BPF_ST
 reject msg on cpuv4 toolchains
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260807204434.1036279-1-vineet.gupta@linux.dev>
 <20260807204434.1036279-2-vineet.gupta@linux.dev>
 <20260807205315.949CF1F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
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
>
> Would it be more robust to force the compiler to emit BPF_STX here, for
> example by using a 64-bit constant that cannot be encoded as a 32-bit
> immediate, or by using barrier_var()? This could preserve the intended
> verifier coverage across different toolchains and optimization levels.

That was exactly in v1 and reviewers suggested this approach !

Thx,
-Vineet
