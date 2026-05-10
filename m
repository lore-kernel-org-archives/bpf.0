Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A3D364055
	for <bpf@vger.kernel.org>; Sun, 10 May 2026 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778434032; cv=none; b=M879SpNGpuLM1PLdEtrn4TLyeYkLKIMl4tNlOWcnqR/qQGSNETtjfb5oVHTRTIPe52ZBS37+VWxFCh+ar508TS+8GQmQXjnr/w33BNOHcjLRKKfxKSK67RGYzDG0pACO1kU6NF/tLB09zEAJyAYmQAB4qBgJ6gf/8e4DvZ643rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778434032; c=relaxed/simple;
	bh=uYJf/fmThD1CeAo60tdkW4DDSx/ccX1sTJC+8jDECCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cmWAwn4JxrGU5TIpJnj93tAFNCCD8OlPqqAWjZ40rO9kMwIyi+xxhkVJiMjv5l1Nw4u4C7S9qOXntHQ3rTHriNY39IpA9IlH6RG7Pf21wnw6nhttaA/OhXVzvGSsZgi7+YNQifLzmaNDShsOQwEOzzorZF2vHoNl6dIGi8bqs2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rvZnrjxB; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rvZnrjxB"
Message-ID: <70fba969-110a-4fc1-98d9-eca6886b7344@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778434029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXKf9f+/fTkDL0Pc21zWYaCPlzX2spyn36crpyBLueU=;
	b=rvZnrjxBvedDXCuwwUIs/I8tYVHIo0U+OHZX+GgTL52If7xlgBYUEPG6yZbMVGEwt4mx7z
	aJhdz6bmE++6531LSzKhGXvK9y8AuXJ25SPE3Fx2ty1grlYBXZTDRO1KGVA6FBS14kx7Ah
	KFVDlPp+weyqpROlvbJ+bBRrjbO+LvI=
Date: Sun, 10 May 2026 10:27:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 19/23] selftests/bpf: Add verifier tests for
 stack argument validation
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260507213145.1139004-1-yonghong.song@linux.dev>
 <b03ce38af2e3d574b5a79963da1a4db70e896e6712b2bf2e9fce69178433540d@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <b03ce38af2e3d574b5a79963da1a4db70e896e6712b2bf2e9fce69178433540d@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/7/26 12:11 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
>> new file mode 100644
>> index 000000000000..b4f680e3b6a1
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> [ ... ]
>
>> +__noinline __used
>> +static long subprog_deref_arg6(long a, long b, long c, long d, long e, long *f)
>> +{
>> +	return *f;
>> +}
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
> The Sashiko AI bot and bpf-ci raised concerns in v6 and April 24 versions
> about test fragility in this test and similar ones. Since
> subprog_deref_arg6 is standard C (not __naked), LLVM determines which
> register is used for dereferencing. If a future LLVM version chooses a
> different register, the tests will fail because the verifier error will
> mention the new register instead of R1.
>
> In v6, you mentioned using a regex like __msg("R{{[0-9]}} invalid mem
> access 'scalar'"), but the current code removed the register prefix
> entirely. While this may be intentional to avoid specifying a register,
> could the tests benefit from either using regex to match the register
> dynamically, or making subprog_deref_arg6 a __naked function to guarantee
> the register choice?

Okay, I will use regex ("R{{[0-9]}}") to get more clarity for the message.

>
> Reference: https://lore.kernel.org/bpf/20260419172100.A89FEC2BCAF@smtp.kernel.org/
>
>> +SEC("tc")
>> +__description("stack_arg: release_reference invalidates stack arg slot")
>> +__failure
>> +__msg("invalid mem access 'scalar'")
>> +__naked void stack_arg_release_ref(void)
> [ ... ]
>
>> +SEC("tc")
>> +__description("stack_arg: pkt pointer in stack arg slot invalidated after pull_data")
>> +__failure
>> +__msg("invalid mem access 'scalar'")
>> +__naked void stack_arg_stale_pkt_ptr(void)
> [ ... ]
>
>> +SEC("tc")
>> +__description("stack_arg: null propagation rejects deref on null branch")
>> +__failure
>> +__msg("invalid mem access 'scalar'")
>> +__naked void stack_arg_null_propagation_fail(void)
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25523765323

