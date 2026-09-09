Received: from mta0.migadu.com (out-245.mta0.migadu.com [91.218.175.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513D85650F0
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972664; cv=none; b=QGVHsSXPvST0lb9sfiLeivtZfXoASYnlt2kCGi9jJZc3tYKz1f41+qwkP4CjYOi+cg0zNy3GXe7WiXkFiHQC7jpgSAcVEXex0UuArlKRINhAGbacdHtnakeKFzsMm1MQBi1GuvHJYGuUqt7i/Hfdyhjzx6XKezUystzX5TwAW1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972664; c=relaxed/simple;
	bh=xvg6jrua7YcjYhIBB+96DhfCUDRF5hIYwrUoSW1oPhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGzGtEqL7MuHMhlRg7v1UuE5lyG6FlzXHheYh2wxxyf23iyp0vxFvzpkE4+8sUaFEYAGWD71Q9csYVO63BFWiMYocAO+5f7ZbLjrY0kReLJZddTZ3qjHV58fJ4jNNOh0knOnUttAdgm/e6dAHODW/lRcxuVo667B5N/QrTwnxII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h53qANUs; arc=none smtp.client-ip=91.218.175.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h53qANUs"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xvg6jrua7YcjYhIBB+96DhfCUDRF5hIYwrUoSW1oPhU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788972658; v=1; x=1789577458;
 b=h53qANUsV1oweNrHwc1zS18jnVKo4i1R9dpbhZKpuU9goQYlT1F2MnX4lqxkKcyxTJcrVa17
 Z9DseHEoZS0CVNjr6qP4bg1+DPe/u1fR7aS4A2SJg83QfUjFe1odoyfrTLL7Y8Vut/3Bda3WCq7
 x3ly0OcMIqr2/KCq5dGiYod0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b25dfbf4724f5286;
	Wed, 09 Sep 2026 16:50:58 +0000
X-Mizu-Trace-ID: b25dfbf4724f5286
X-Migadu-Flow: FLOW_OUT
Message-ID: <b905f76e-471a-4626-93bb-c3bbdae86849@linux.dev>
Date: Wed, 9 Sep 2026 22:20:53 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 6/6] selftests/bpf: cover 32-bit sign-extension
 low-32 links
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260814231945.3884596-1-vineet.gupta@linux.dev>
 <20260814231945.3884596-7-vineet.gupta@linux.dev>
 <20260814232719.064EC1F000E9@smtp.kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <20260814232719.064EC1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/15/26 4:57 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The failure tests `sext_dest_driven_does_not_narrow_base` and `zext_dest_driven_does_not_narrow_base` contain backwards branch conditions, making them unconditionally pass regardless of whether the verifier bug is present.
> --
>
> --- Patch [6]: [RFC bpf-next 6/6] selftests/bpf: cover 32-bit sign-extension low-32 links ---
> commit f8b3195655d59866de20fa031cd9d9e1bbfbde94
> Author: Vineet Gupta <vineet.gupta@linux.dev>
> Subject: selftests/bpf: cover 32-bit sign-extension low-32 links
>
> This commit adds selftests for the BPF_FLAG_SUBREG_SEXT link in the BPF
> verifier. The tests verify various sign-extension behaviors, including
> deduction through links, zero-extension interaction, and in-loop behavior.
>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
>> index 2cc6f9e45aff3..ff71e168d4cc4 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> [ ... ]
>
>> @@ -826,4 +826,416 @@ l_out_%=:							\
>>   	: __clobber_all);
>>   }
>>   
> [ ... ]
>
>> +SEC("socket")
>> +__failure __msg("div by zero")
>> +__flag(BPF_F_TEST_STATE_FREQ)
>> +__naked void sext_dest_driven_does_not_narrow_base(void)
>> +{
>> +	asm volatile ("						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r6 = r0;		/* r6 low = unknown u32 */	\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r0 <<= 32;						\
>> +	r6 |= r0;		/* r6 = full 64-bit unknown (base) */ \
>> +	r7 = (s32)r6;		/* low-32 SEXT link */		\
>> +	if r7 != 0 goto l_out_%=;/* r7 == 0: low 32 bits are 0 */ \
>> +	if r6 != 0 goto l_out_%=;/* r6 may still have high bits set */ \
>> +	r0 /= 0;		/* must stay reachable */	\
>> +l_out_%=:							\
>> +	r0 = 0;							\
>> +	exit;							\
>> +"	:
>> +	: __imm(bpf_get_prandom_u32)
>> +	: __clobber_all);
>> +}
> [Severity: Medium]
> Are these branch conditions backward for a __failure test that expects a
> "div by zero" rejection?
>
> Since the test expects the division to be reachable for rejection, if the
> buggy verifier deduces r6 == 0, "if r6 != 0 goto l_out_%=" will evaluate as
> false and fall through to the division by zero, causing a rejection and
> making the test pass.
>
> If the verifier is correct, the fall-through is also reachable, causing a
> rejection and passing the test.
>
> Does this mean the test passes unconditionally regardless of whether the
> verifier bug is present, causing a regression in test coverage?

You are right, it seems to be the case.

> Should this check instead be "if r6 == 0 goto l_out_%="? This way, if the
> verifier makes the buggy deduction that r6 == 0, it takes the branch and
> the div becomes unreachable, allowing the verifier to accept the program and
> fail the test as intended.
>
> It looks like the identical condition also exists in the pre-existing
> zext_dest_driven_does_not_narrow_base() test just above this:
>
> 	w7 = w6;		/* low-32 ZEXT link */		\
> 	if r7 != 0 goto l_out_%=;/* r7 == 0: low 32 bits are 0 */ \
> 	if r6 != 0 goto l_out_%=;/* r6 may still have high bits set */ \
> 	r0 /= 0;		/* must stay reachable */	\

Yes the 2 tests are rewritten with a guard that is only taken in buggy path.

Thx,
-Vineet
