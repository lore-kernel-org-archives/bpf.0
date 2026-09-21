Received: from mta0.migadu.com (out-162.mta0.migadu.com [91.218.175.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9525B47607A
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000888; cv=none; b=qqesmPYXtsSBkSsI8ytoePQciNpf6UO4DFnitN8OBKkwB6azVR1aRSPbxnqtLY/cfz7ljU2Tm4MW+DeWbINw61U0kQtmBLeUyboJ3cNw9NNoC3/sARfpuGX+sU/iLM8Ytu54zx6P+0/40IKLCqknIB90ZC1CqQS3n1sMwH+t4qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000888; c=relaxed/simple;
	bh=ih6Yu4XBs0puH6DOyZ5KATBQVhCyAaxoAkXDW7P9v2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hwa5fvRe/J+m8HaHlkzIDW5PFzSxtzLSzOL8UYZutvwGSHabgmPOc1Bb05MXkfRXDtkqpNRiUMcBrUAXIiuf0lxa+tQZp2ug8pRbW5KL6Bi2m9M5lmEdrW1v/wGCLoqfXcGCHuh+FfwambT0bYVbuJ6Ct2Qv6+UlHopjYP9ccas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wifvy7pW; arc=none smtp.client-ip=91.218.175.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wifvy7pW"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ih6Yu4XBs0puH6DOyZ5KATBQVhCyAaxoAkXDW7P9v2g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790000883; v=1; x=1790605683;
 b=wifvy7pWfIBgDWbJUX8oREsP7s2hZMzQPjOoZPnpvGivtMhlkfdfWw8peU13Me4GXLEr9So2
 UaYnWtTmNXU6hcNLIH0WIi+HJbazxVkYqkM+CS/rUsAPb90e22bnr6x5q9YJYBWCzivRRkA6TBh
 Dl3vMVhKyGfjSdck474D4Ow0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0e8f6080b91588b3;
	Mon, 21 Sep 2026 14:28:02 +0000
X-Mizu-Trace-ID: 0e8f6080b91588b3
X-Migadu-Flow: FLOW_OUT
Message-ID: <82cb15a8-cca3-418c-bea4-e932a8e5aa17@linux.dev>
Date: Mon, 21 Sep 2026 07:27:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 19/20] selftests/bpf: Cover the exception
 cleanup shapes the chain does not reach
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260920054403.874319-1-yonghong.song@linux.dev>
 <37c6c163cd23d9760d1d08616706cb1ee8c4ae4799150a8ad36544453670161a@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <37c6c163cd23d9760d1d08616706cb1ee8c4ae4799150a8ad36544453670161a@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/19/26 11:46 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
>> new file mode 100644
>> index 000000000000..493f8e030652
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
> [ ... ]
>
>> +/* 2. A callee called from both a covered and an uncovered site: the pad
>> + * belongs to the call site, not the callee. Either site can throw, and the RCU
>> + * lock between them is what an unwind out of the uncovered one leaks.
>> + */
>> +static __used __noinline __u64 shared_callee(__u64 x)
>> +{
>> +	if (x > 100)
>> +		bpf_throw(THROW_COOKIE);
>> +	return x + 1;
>> +}
>> +
>> +static __used __naked __noinline __u64 shared_frame(void)
>> +{
>> +	asm volatile (
>> +	"r1 = %[input] ll;"
>> +	"r6 = *(u64 *)(r1 + 0);"
>> +	"r1 = %[outer_input] ll;"
>> +	"r1 = *(u64 *)(r1 + 0);"
>> +	"call shared_callee;"		/* uncovered: no pad for its unwind */
>> +	"call bpf_rcu_read_lock;"
> Does the shape 2 header comment accurately describe what the code does?
>
> The comment states "the RCU lock between them is what an unwind out of
> the uncovered one leaks", but the uncovered call to shared_callee()
> happens before bpf_rcu_read_lock() is invoked. When the uncovered site
> throws (which prog_tests/exceptions_cleanup.c tests in the
> shared_callee_uncovered_throw subtest with outer_input = 101, input = 1),
> active_rcu_locks is 0 and there is nothing to leak.
>
> The verifier would also reject a throw with the lock held via
> check_resource_leak() in kernel/bpf/verifier.c, which checks at
> unwind_finish() and refuses with "bpf_throw cannot be used inside
> bpf_rcu_read_lock-ed region" if active_rcu_locks is set.
>
> The lock sits between the two call sites so that only the covered one
> unwinds with it held, making the pad's bpf_rcu_read_unlock() observable.
>
> Should the comment describe that the lock is taken between the two sites
> rather than before the uncovered one?

Yes, will change comment like
   ... the RCU lock is taken between them, so only the covered call unwinds holding it.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35492765538

