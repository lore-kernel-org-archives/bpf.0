Received: from mta1.migadu.com (out-94.mta1.migadu.com [95.215.58.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0995391849
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 06:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788415647; cv=none; b=sA59CfLOO2AixAYhiIL33JI25Zp300jkzoMXlqUfymgl5l8y2DIbB87KfSgrpuBsuthloZGNZ1LiJgDQQtfPCKXmW3Ejrl5D/Ayb69X2a4Pqwm7FoIiLG7BgKryVIJ6bzOJ0N0qev2DDQo6hqVIApZ8AmWKgSC7bhlQ22Xo1pCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788415647; c=relaxed/simple;
	bh=uyXoRZe35IzewVYHrg+LaD5Du+LGsexJrROOOIaAP1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LLX+prg7tjEn9DVALI1Z/5Suvk41pLIpsNsPCbtXXZR2GPOeGcTvHOo9MpOINvcrALEfvLI+uxjgFc166UL8ioqWLpKsztroqNj4+4WpD5dLP6R6c58F9Elto4VkRavoZMQ3Y/fuC1DChlqZv2Dt7U4/vCheftw1nK6BQYBuWI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CRfJQsDM; arc=none smtp.client-ip=95.215.58.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CRfJQsDM"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uyXoRZe35IzewVYHrg+LaD5Du+LGsexJrROOOIaAP1s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788415642; v=1; x=1789020442;
 b=CRfJQsDMaNTCQQ+CbsAbGc0ESUZKVoCk4JSOB/jRM7LFEI4BaaiJ81LBR+j8NF8jtVltVYrm
 Ms4ECeqqqNhiNx4FKktqsdAV/DEUSJ5Xn0mKQvu0xe4xfElrWTSodIP4fvpDtdSzjyl8xATHa+E
 qnNeuST8uMY0ZEVw3SA5cHWE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0b5c94524f8f234a;
	Thu, 03 Sep 2026 06:07:12 +0000
X-Mizu-Trace-ID: 0b5c94524f8f234a
X-Migadu-Flow: FLOW_OUT
Message-ID: <159a84e7-4d96-47ee-be42-3b9d0af50086@linux.dev>
Date: Thu, 3 Sep 2026 11:37:06 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 4/6] selftests/bpf: cover low-32 subreg-equal link
 for zero-extending movs
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260814231945.3884596-1-vineet.gupta@linux.dev>
 <20260814231945.3884596-5-vineet.gupta@linux.dev>
 <20260814232754.CF49D1F000E9@smtp.kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <20260814232754.CF49D1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/26 4:57 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Logic error in regression test rendering it ineffective
> - [Low] Multi-line comment style violation in BPF subsystem
> --

...

> +/*
> + * Dest-driven direction, zero-extend flavour: narrowing the LINKED register
> + * must not narrow the wide base.
> + *
> + * w7 = w6 shares only r6's low 32 bits; r7's high half is zero, r6's is
> + * unknown. Learning r7 == 0 therefore says nothing about r6, and
> + * sync_linked_regs() must not copy r7's state onto it. Rejected iff the base
> + * is left alone.
> + *
> + * This is the shape that catches a lost BPF_FLAG_SUBREG_ZEXT: if the flag is
> + * dropped while the shared ->id survives, the pair looks like a full 64-bit
> + * equality, the dest-driven guard is bypassed and r6 wrongly becomes 0.
> + */
> +SEC("socket")
> +__failure __msg("div by zero")
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__naked void zext_dest_driven_does_not_narrow_base(void)
> +{
> +	asm volatile ("						\
> +	call %[bpf_get_prandom_u32];				\
> +	r6 = r0;		/* r6 low = unknown u32 */	\
> +	call %[bpf_get_prandom_u32];				\
> +	r0 <<= 32;						\
> +	r6 |= r0;		/* r6 = full 64-bit unknown (base) */ \
> +	w7 = w6;		/* low-32 ZEXT link */		\
> +	if r7 != 0 goto l_out_%=;/* r7 == 0: low 32 bits are 0 */ \
> +	if r6 != 0 goto l_out_%=;/* r6 may still have high bits set */ \
> [Severity: Medium]
> Does this logic correctly catch a regression when a buggy verifier is tested?
>
> If a buggy verifier incorrectly narrows r6 to exactly 0, wouldn't it evaluate
> "r6 != 0" as statically false, and then fall through to the division by zero,
> just like a correct verifier that sees r6 with unknown high bits?
>
> Since both correct and buggy verifiers evaluate both branches and fall through
> to the division, wouldn't this test always pass?
>
> Would changing the branch to "if r6 == 0 goto l_out_%=;" correctly allow a
> buggy verifier to skip the division and incorrectly accept the program,
> failing the test?

Indeed this is not tight enough. Fixed and add the side-band comment for 
that.

>> diff --git a/tools/testing/selftests/bpf/progs/verifier_reg_equal.c b/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
>> index dc1d8c30fb0ee..e6fbbfaeedcb7 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
>> @@ -31,23 +31,25 @@ l1_%=:	exit;						\
>>   }
>>   
>>   SEC("socket")
>> -__description("check w reg not equal if r reg upper32 bits not 0")
>> -__failure __msg("R1 !read_ok")
>> +__description("w reg shares r reg low32 via subreg link even if upper32 not 0")
>> +__success
>>   __naked void subreg_equality_2(void)
>>   {
>>   	asm volatile ("					\
>>   	call %[bpf_ktime_get_ns];			\
>>   	r2 = r0;					\
>> -	/* Upper 4-bytes of r2 may not be 0, thus insn	\
>> -	 * w3 = w2 should not propagate reg id,	and	\
>> -	 * w2 < 9 comparison should not propagate	\
>> -	 * the range for r3 either.			\
>> +	/* Upper 4-bytes of r2 may not be 0. w3 = w2 is a 32-bit	\
> [Severity: Low]
> This isn't a bug, but does this multi-line comment follow the BPF subsystem
> style guide?
>
> The modern kernel multi-line comment style used in the BPF subsystem requires
> the opening "/*" to be on its own line.

This hunk is dropped in v2.

Thx,
-Vineet
