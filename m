Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC95E238D27
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777095197; cv=none; b=WsVPRhikW6Ba0b+PSdGUp0yhYODCHPH0bUrqkFmJVrxZpJ+hYwhGkKQaF1kix+qgsI4s5vLB4U/yOvHxZqRA1BcreGVuwTRAFeam8l7POBGJxPMbjJW+zpF5KjDi0mkR5l73SyHd91tV0Ix8W3o82MtzGmnW0H21q/0dP+DyErQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777095197; c=relaxed/simple;
	bh=Ln4zPxtoWprng2ZcKoxIRPz3bcFh0PFr2hhfgp6quSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TL+Vw0iKx9hDnPy/1gTAz/ptWAwLCuh28EhrHUt/TB5dI6W0+ym4tYc5/5CbnLGtplol8m2tpC/1SMcr55rGKA9lVivbb4WBSqFx1LAfZjFGQo6g+R9UaQ5xnp0b/KeOOA5PdTAEN0DPjM3Lb8K/LA08C8oDAsj03tvAs4jazdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DYePPtES; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DYePPtES"
Message-ID: <7ed5f790-de74-4bab-bcb4-abcca122d841@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777095193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jxJVDOwWhOMzKzIKoywwX3r5KzqfHmIf/grVb0l2voU=;
	b=DYePPtESdsT7P5t86dJxi6+WJTzbhQY5f/qK8Q8czUI+m1HtET2/EhNsdIuUTYQe8TINaH
	V1mVgaBfLhSle7Y8glPp/Vqal7T7ycQEBvsldnqweNuk0tXiMx4bSXB4vvd5ESSzl4YstA
	BzmqUkE97k5tzNqbvjey/EQHXZGvmyA=
Date: Fri, 24 Apr 2026 22:33:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 13/18] selftests/bpf: Add verifier tests for
 stack argument validation
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260424171703.2054695-1-yonghong.song@linux.dev>
 <e4650e8672368d1d36d1fcfba86d9494fd1dd23d131f79b378812170625a22fa@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <e4650e8672368d1d36d1fcfba86d9494fd1dd23d131f79b378812170625a22fa@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/24/26 10:48 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
>> new file mode 100644
>> index 000000000000..6b596ad63774
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
>> @@ -0,0 +1,456 @@
> [ ... ]
>
>> +SEC("tc")
>> +__description("stack_arg: pruning with different stack arg types")
>> +__failure
>> +__flag(BPF_F_TEST_STATE_FREQ)
>> +__msg("invalid mem access 'scalar'")
>> +__naked void stack_arg_pruning_type_mismatch(void)
>> +{
>> +	asm volatile (
>> +		"call %[bpf_get_prandom_u32];"
>> +		"r6 = r0;"
>> +		/* local = 0 on program stack */
>> +		"r7 = 0;"
>> +		"*(u64 *)(r10 - 8) = r7;"
>> +		/* Branch based on random value */
>> +		"if r6 s> 3 goto l0_%=;"
>> +		/* Path 1: store stack pointer to outgoing arg6 */
>> +		"r1 = r10;"
>> +		"r1 += -8;"
>> +		"*(u64 *)(r11 - 8) = r1;"
>> +		"goto l1_%=;"
>> +	"l0_%=:"
>> +		/* Path 2: store scalar to outgoing arg6 */
>> +		"*(u64 *)(r11 - 8) = 42;"
>> +	"l1_%=:"
>> +		/* Call subprog that dereferences arg6 */
>> +		"r1 = r6;"
>> +		"r2 = 0;"
>> +		"r3 = 0;"
>> +		"r4 = 0;"
>> +		"r5 = 0;"
>> +		"call subprog_deref_arg6;"
>> +		"exit;"
>> +		:: __imm(bpf_get_prandom_u32)
>> +		: __clobber_all
>> +	);
>> +}
> Does the error message string match the expected register output?
>
> During v6 review, sashiko-bot raised a concern about test fragility:
> since subprog_deref_arg6 is standard C (not __naked), LLVM determines
> which register is used to dereference f. If a future LLVM version
> chooses a different register, the verifier error will mention that
> register instead of R1, causing the test to fail.
>
> You acknowledged the issue and said you would use a regex like
> __msg("R{{[0-9]}} invalid mem access 'scalar'") to match the register
> dynamically. However, the current code uses __msg("invalid mem access
> 'scalar'") without any register prefix.
>
> The same pattern appears in stack_arg_release_ref,
> stack_arg_stale_pkt_ptr, and stack_arg_null_propagation_fail. Should
> these tests use the regex pattern to avoid compiler-dependent failures,
> or be rewritten to make subprog_deref_arg6 a __naked function?

Yes, I removed the "R{{[0-9]}}' stuff since I thought "R{{[0-9]}}"
will be equivalent to ignore it since we do not have a definite register
any more.

There is an option to use __naked function for subprog_deref_arg6
(see patch "selftests/bpf: Add precision backtracking test for stack arguments").
It becomes more complicated so I prefer the current result.

>
> Reference:
> https://lore.kernel.org/bpf/20260419172100.A89FEC2BCAF@smtp.kernel.org/
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24902767240

