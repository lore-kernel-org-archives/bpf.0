Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABC972622
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776537440; cv=none; b=BuhSAdItICoT0I0Wsv8qI0ZZjrgCf/vAjyA9daY0j/7A1G3MXDa/4gMjqdrCJbFg0fX7NT/dOgZtMYTtOJZVzZHAq6FA1kJsA6z2QLhtf4lotdzgPJ6HoV/+XV7MbAimIjh8xmm8T6FGd/tOsEtpNBZMyAZFFCzceWqO92t7HMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776537440; c=relaxed/simple;
	bh=nx3zDlm9hCsWYkM801Vxak6yVh5r9HPQl66Ijuxw/iU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMCTc1fupPO7flxLHeMK7nKA7IW3tZg4r/hOREzGfkE5pnkcBj4G32noL4QUak5ySk9pea2dn1eSq8R+erLVMGW/yhPIZnwHWoyGszltovnkOTWP0M3JNRya8pvb4Keg/muiH0w2NKDwXDZlm95Fis7bH3SfIdS1N7HlsNtO5Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M+itxSwt; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M+itxSwt"
Message-ID: <7318c25f-771b-4349-8e78-efb7d0e51822@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776537426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Fh3j2jqZqy0sjsQndG7QJgzpVbNfHViaoavOGxJ1vE=;
	b=M+itxSwtciUIovHSXmWJ9+bZzixWgmRN043d53LVwTWLgZAdi8SvmOXEm+v4vU707ORDUR
	9WL1zF5CuK5bV6ENS7CxpE204qQpvqcS8riZ/t5ygL0hjdnehoXbJiHNhGiylkublzz6AV
	GammBbXvrkeflY5Eo5DtDugVAczEXSI=
Date: Sat, 18 Apr 2026 11:36:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 16/16] selftests/bpf: Add verifier tests for
 stack argument validation
Content-Language: en-GB
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260417034838.2638137-1-yonghong.song@linux.dev>
 <20260417043846.66CFEC2BCB0@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260417043846.66CFEC2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/16/26 9:38 PM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 3 potential issue(s):
> - [Medium] Negative verifier tests for stack arguments use inherently invalid memory accesses, causing them to pass even if the verifier has bugs.
> - [Medium] `stack_arg_read_uninitialized` reads from `r11 + 8` instead of a valid negative offset, failing to properly test uninitialized stack argument slots.
> - [Low] Unused `subprog_8args` function defined in the test file.
> --
>
> commit 24b1eb352e7d04e7c35a9fbc88c6b91d08b17832
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> selftests/bpf: Add verifier tests for stack argument validation
>
> This commit adds inline-asm based verifier tests to directly exercise
> stack argument validation logic.
>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
>> new file mode 100644
>> index 0000000000000..d212b6c3cac75
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> [ ... ]
>
>> +__noinline __used
>> +static int subprog_8args(int a, int b, int c, int d, int e, int f, int g, int h)
>> +{
>> +	return a + b + c + d + e + f + g + h;
>> +}
> Is subprog_8args intended to be used in any of the tests? It does not seem
> to be called anywhere in this file.

Dead code. Will remove.

>
> [ ... ]
>
>> +SEC("tc")
>> +__description("stack_arg: read from uninitialized stack arg slot")
>> +__failure
>> +__arch_x86_64
>> +__msg("invalid read from stack arg")
>> +__naked void stack_arg_read_uninitialized(void)
>> +{
>> +	asm volatile (
>> +		"r0 = *(u64 *)(r11 + 8);"
>> +		"r0 = 0;"
>> +		"exit;"
>> +		::: __clobber_all
>> +	);
>> +}
> Should this read from r11 - 8 instead? Since outgoing stack arguments are
> at negative offsets from r11, reading from r11 + 8 is out of bounds and
> might be rejected for the wrong reason, rather than testing an uninitialized
> but valid stack argument slot.

The read must be 'r11 + 8' and store will be 'r11 - <positive_off>'.

>
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
>> +__description("stack_arg: release_reference invalidates stack arg slot")
>> +__failure
>> +__arch_x86_64
>> +__msg("R1 invalid sock access")
>> +__naked void stack_arg_release_ref(void)
>> +{
>> +	asm volatile (
> [ ... ]
>> +		/* Release the reference — invalidates the stack arg slot */
>> +		"r1 = r0;"
>> +		"call %[bpf_sk_release];"
>> +		/* Call subprog that dereferences arg6 — should fail */
>> +		"r1 = 1;"
>> +		"r2 = 2;"
>> +		"r3 = 3;"
>> +		"r4 = 4;"
>> +		"r5 = 5;"
>> +		"call subprog_deref_arg6;"
> Can this test pass even if the verifier fails to invalidate the stack slot?
>
> subprog_deref_arg6() performs an 8-byte read on the argument. Since BPF
> sockets only allow up to 4-byte reads, an 8-byte read is always invalid.
> If the reference isn't correctly invalidated, the valid socket pointer
> will still be rejected with "R1 invalid sock access".
>
> To properly test the invalidation, should the subprogram perform a valid
> 4-byte read instead?

4-byte stack argument is not supported.

>
> [ ... ]
>
>> +SEC("tc")
>> +__description("stack_arg: pkt pointer in stack arg slot invalidated after pull_data")
>> +__failure
>> +__arch_x86_64
>> +__msg("invalid access to packet")
>> +__naked void stack_arg_stale_pkt_ptr(void)
>> +{
>> +	asm volatile (
>> +		"r6 = r1;"
>> +		"r7 = *(u32 *)(r6 + %[__sk_buff_data]);"
>> +		"r8 = *(u32 *)(r6 + %[__sk_buff_data_end]);"
>> +		/* check pkt has at least 1 byte */
>> +		"r0 = r7;"
>> +		"r0 += 1;"
>> +		"if r0 > r8 goto l0_%=;"
>> +		/* Store valid pkt pointer to outgoing arg6 slot */
>> +		"*(u64 *)(r11 - 8) = r7;"
>> +		/* bpf_skb_pull_data invalidates all pkt pointers */
>> +		"r1 = r6;"
>> +		"r2 = 0;"
>> +		"call %[bpf_skb_pull_data];"
>> +		/* Call subprog that dereferences arg6 — should fail */
>> +		"r1 = 1;"
>> +		"r2 = 2;"
>> +		"r3 = 3;"
>> +		"r4 = 4;"
>> +		"r5 = 5;"
>> +		"call subprog_deref_arg6;"
> Similarly, does this properly test packet pointer invalidation? The test
> verifies 1 byte of the packet pointer, but subprog_deref_arg6() reads 8 bytes.
> If bpf_skb_pull_data() fails to invalidate the pointer, the 8-byte read would
> still be rejected as out-of-bounds, yielding the expected "invalid access to
> packet" message.
>
> Should the packet bounds check verify at least 8 bytes so that a valid read is
> guaranteed if the pointer isn't invalidated?

yes, I can do r0 += 8 instead.

>
> [ ... ]
>
>> +SEC("tc")
>> +__description("stack_arg: null propagation rejects deref on null branch")
>> +__failure
>> +__arch_x86_64
>> +__msg("R1 invalid mem access")
>> +__naked void stack_arg_null_propagation_fail(void)
>> +{
>> +	asm volatile (
> [ ... ]
>> +		"call %[bpf_map_lookup_elem];"
>> +		/* Store PTR_TO_MAP_VALUE_OR_NULL to outgoing arg6 slot */
>> +		"*(u64 *)(r11 - 8) = r0;"
>> +		/* null check on r0 */
>> +		"if r0 != 0 goto l0_%=;"
>> +		/*
>> +		 * On null branch, outgoing slot is SCALAR(0).
>> +		 * Call subprog that dereferences arg6 — should fail.
>> +		 */
>> +		"r1 = 0;"
>> +		"r2 = 0;"
>> +		"r3 = 0;"
>> +		"r4 = 0;"
>> +		"r5 = 0;"
>> +		"call subprog_deref_arg6;"
> Does the __msg() substring match accept the wrong failure mode here?
> Dereferencing an unrefined PTR_TO_MAP_VALUE_OR_NULL yields "R1 invalid mem
> access 'map_value_or_null'", while dereferencing SCALAR yields "R1 invalid mem
> access 'scalar'".
>
> The substring match "R1 invalid mem access" accepts both, allowing the test to
> pass even if null propagation fails and the register is still tracked as a map
> pointer. Should it match the exact scalar error, or perhaps test the non-null
> branch for success instead?

Will fix.

