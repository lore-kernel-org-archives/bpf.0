Received: from mta0.migadu.com (out-141.mta0.migadu.com [91.218.175.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287FE39022A
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 05:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789104875; cv=none; b=j5zzCHeSDKhNfs4Ld//ZQbqfI6XbQ1BCPpkLuArGvJlb4v62xhGQkDd0v3YqvNd8vtsfErIML/pjErq46JyqqKyujhMsVIePy9HMqNCyRKjMlhHA7KdtUJbWU+nx16V5JyFJFkbKA5RelQbcYpgObk7827jZR6DT65gA7qv57Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789104875; c=relaxed/simple;
	bh=sVEV/XK5D/oco1XqkmpUo65zt1a8V9JerTrhuFHJw6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMWr+1Wgpz2HyHcF/LLCDJfs8O0osdjJWL3IItH9CVbHjyz46SUtGi792aSnWaVt/MupefgOVwwJUh1DoH8TqRrkNDI+op65q0h1TxF1kWt/JUyq9dSZvbcFznKfeiuoL+hRcOySg57kRERNP4q1PWa7HyqKVWsZumWocMG30/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G4zKQY9q; arc=none smtp.client-ip=91.218.175.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G4zKQY9q"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sVEV/XK5D/oco1XqkmpUo65zt1a8V9JerTrhuFHJw6g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789104872; v=1; x=1789709672;
 b=G4zKQY9qaI3yjlu50QdOouUiJYgJ5lk6JSnQIk4tOXnUS6dKNKKKVn4f9YRvtokiJxGsLx71
 ahuJqvsKAK/65Lx6UMs9G7Qbe2tpJhujr5Eh9xlYz2HFUmZp5Yxj/Y4nJjuxR6ndrxQ2UWCDhdM
 AWaAsipVogXR8GsXwYcNN6wg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7b98c62012699b19;
	Fri, 11 Sep 2026 05:34:32 +0000
X-Mizu-Trace-ID: 7b98c62012699b19
X-Migadu-Flow: FLOW_OUT
Message-ID: <4ef9a3d4-7a79-4144-baff-e236f8eb7c5e@linux.dev>
Date: Fri, 11 Sep 2026 11:04:29 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 10/13] selftests/bpf: cover the low-32 link
 for narrowing stack fills
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
 <20260910164635.459558-11-vineet.gupta@linux.dev>
 <20260910170020.04A4E1F000FF@smtp.kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <20260910170020.04A4E1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/26 10:30 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly added tests for narrow stack fills hardcode memory offsets (e.g., `(r10 - 8)`) which are only correct on little-endian architectures. On big-endian architectures like s390x, these offsets do not point to the lower bits, causing the BPF verifier to reject the programs and resulting in test failures.
> --
>
> commit a42f9a6d4d49f17385f014eede55d6e82094a838
> Author: Vineet Gupta <vineet.gupta@linux.dev>
>
> selftests/bpf: cover the low-32 link for narrowing stack fills
>
> This commit adds five new BPF programs to test the verifier's handling of
> narrowing stack fills, specifically targeting low-32 links and sign-extension
> behavior.
>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
>> --- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> [ ... ]
>
>> +SEC("socket")
>> +__success
>> +__naked void zext_fill_narrow_from_wide_spill(void)
>> +{
>> +	asm volatile ("						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r6 = r0;						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r0 <<= 32;						\
>> +	r6 |= r0;		/* r6 = full 64-bit unknown */	\
>> +	*(u64 *)(r10 - 8) = r6;	/* slot linked to r6 */		\
>> +	r2 = *(u32 *)(r10 - 8);	/* narrowing fill, forms the link */ \
> [Severity: Medium]
> On big-endian architectures like s390x, won't reading 32 bits from offset -8
> target the upper 32 bits instead of the lower 32 bits?
>
> The bpf_stack_narrow_access_ok() check in the verifier expects to read the
> least significant bytes of the spill slot, which on big-endian are located
> at offset -4 for a 32-bit read. Could this hardcoded offset cause the verifier
> to reject the program and break the test on big-endian systems?

Goot catch. Fixed for BE and LE.

>> +	if w6 != 0 goto 1f;	/* narrows r6, propagates to r2 */ \
>> +	if r2 == 0 goto 1f;					\
>> +	r0 /= 0;						\
>> +1:								\
>> +	r0 = 0;							\
>> +	exit;							\
>> +"	:
>> +	: __imm(bpf_get_prandom_u32)
>> +	: __clobber_all);
>> +}
> [ ... ]
>
>> +SEC("socket")
>> +__failure __msg("div by zero")
>> +__naked void zext_fill_byte_forms_no_link(void)
>> +{
>> +	asm volatile ("						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r6 = r0;						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r0 <<= 32;						\
>> +	r6 |= r0;						\
>> +	*(u64 *)(r10 - 8) = r6;					\
>> +	r2 = *(u8 *)(r10 - 8);	/* 1-byte fill: no link */	\
> [Severity: Medium]
> Does this hardcoded 8-bit read from offset -8 target the most significant byte
> rather than the least significant byte on big-endian architectures?

Fixed.

>> +	if w6 != 0 goto 1f;					\
>> +	if r2 == 0 goto 1f;	/* not deduced */		\
>> +	r0 /= 0;						\
>> +1:								\
>> +	r0 = 0;							\
>> +	exit;							\
>> +"	:
>> +	: __imm(bpf_get_prandom_u32)
>> +	: __clobber_all);
>> +}
> [ ... ]
>
>> +SEC("socket")
>> +__success
>> +__naked void sext_fill_narrow_from_wide_spill(void)
>> +{
>> +	asm volatile ("						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r6 = r0;						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r0 <<= 32;						\
>> +	r6 |= r0;		/* r6 = full 64-bit unknown */	\
>> +	*(u64 *)(r10 - 8) = r6;	/* slot linked to r6 */		\
>> +	r2 = *(s32 *)(r10 - 8);	/* narrowing sx fill */		\
> [Severity: Medium]
> Similar to the previous cases, will this 32-bit read from offset -8 read the
> upper 32 bits on big-endian systems and cause verifier bounds tracking to fail?

Fixed.

>> +	if w6 != -1 goto 1f;	/* narrows r6, propagates to r2 */ \
>> +	if r2 == -1 goto 1f;	/* sign-extended, not 0xffffffff */ \
>> +	r0 /= 0;						\
>> +1:								\
>> +	r0 = 0;							\
>> +	exit;							\
>> +"	:
>> +	: __imm(bpf_get_prandom_u32)
>> +	: __clobber_all);
>> +}
> [ ... ]
>
>> +SEC("socket")
>> +__failure __msg("div by zero")
>> +__flag(BPF_F_TEST_STATE_FREQ)
>> +__naked void fill_kinds_reach_different_values(void)
>> +{
>> +	asm volatile ("						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r6 = r0;						\
>> +	r6 &= 1;						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r8 = r0;						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r0 <<= 32;						\
>> +	r8 |= r0;						\
>> +	*(u64 *)(r10 - 8) = r8;					\
>> +	if r6 >= 1 goto 2f;					\
>> +	r2 = *(s32 *)(r10 - 8);	/* sign-extending fill */	\
> [Severity: Medium]
> Will these narrow fills also fail verifier checks on big-endian machines due
> to the fixed -8 offset pointing to the wrong 32-bit half?

Fixed.

>
>> +	goto 1f;						\
>> +2:								\
>> +	r2 = *(u32 *)(r10 - 8);	/* zero-extending fill */	\
>> +1:								\
>> +	if w8 != -1 goto 3f;					\
>> +	if r2 == -1 goto 3f;	/* only the sign-extending path */ \

