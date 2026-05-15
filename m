Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8341EF09B
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 06:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778826727; cv=none; b=igzC5DuXhg+ENUKCOYTnY6PGViVsuLgOgv0qtG0pK+Uw3x5KcPAWAzvlpx/3fqHpcYba0PMIwdckKnr8eYlhAPrLEHVyObFrIGBLUgbx/qRThwECcVkSVxd656aEyFhx+J3SG2GuUpe7j8eO2aq3xIbCX/ULr43tU9X4MFaYx1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778826727; c=relaxed/simple;
	bh=I6pCSfQUiqiIwbH8CnmjGoZjU5Lf/ddnxwDiHxeJNtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pylefqlYmPo9IKaSmHfJwuDJEYjqVHHwo3q+FbQXkhvbMsxbwnvY2EHUX+NmRFeNxgIMcuO7VBGU8m7i/Ki5qD2UcWSCXuvgpCj09W1A/5tIc2ok/PZr8VhbH+AgbnbTfsc+5TH/JHeoDHdNVYarASjnHBccpuySKEQR6LGx34Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ctYQIKJ+; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ctYQIKJ+"
Message-ID: <0243b1a5-6a36-4a1a-9d50-e23d45faf1a9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778826723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fKSs04TqDvw6DYh/XNv19etYM+3W12lX8DNZuop3hnY=;
	b=ctYQIKJ+4/J+iAKIyrliYS6Y0p+j3coN2HnIpKTpojqyoZqqpOSE8S7BT5t1ni216o76Im
	2uYiVP1tGc+YS+G+wtw7PaSoOrBuO8Qb1sW3K4hi1zDjj+dTxSQjaeXZWBCBUkfsn5z+Qa
	AV53lubR3lIj63chnW9lscRf8PXbjC0=
Date: Thu, 14 May 2026 23:31:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add test for stack arg
 read without caller write
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 kernel-team@fb.com, martin.lau@kernel.org, eddyz87@gmail.com, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260515015003.1187170-1-yonghong.song@linux.dev>
 <eae0af1b3acf0a3f60cbdb86d1b43161f2241f80a07c27c3fae2e929a389e87a@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <eae0af1b3acf0a3f60cbdb86d1b43161f2241f80a07c27c3fae2e929a389e87a@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/15/26 4:31 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c b/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c
>> index da34e8456b6c..99bc115f8380 100644
>> --- a/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c
>> +++ b/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
>> index d43a9b42034c..d45339b83795 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
>> @@ -152,7 +152,7 @@ __naked void stack_arg_pruning_type_mismatch(void)
>>   SEC("tc")
>>   __description("stack_arg: release_reference invalidates stack arg slot")
>>   __failure
>> -__msg("R{{[0-9]}} !read_ok")
>> +__msg("callee expects 6 args, stack arg1 is not initialized")
>>   __naked void stack_arg_release_ref(void)
> [ ... ]
>
>>   SEC("tc")
>>   __description("stack_arg: pkt pointer in stack arg slot invalidated after pull_data")
>>   __failure
>> -__msg("R{{[0-9]}} !read_ok")
>> +__msg("callee expects 6 args, stack arg1 is not initialized")
>>   __naked void stack_arg_stale_pkt_ptr(void)
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
>> index 1240cf8a40d6..c9fe4857da3f 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
>> @@ -112,6 +112,64 @@ __naked void stack_arg_pruning_load_after_call(void)
>>   	);
>>   }
>>
>> +/*
>> + * "bad_ptr": the first arg is 'long *', which is not a recognized pointer
>> + * type for static subprogs (not ctx, dynptr, or tagged).  btf_prepare_func_args()
>> + * sets arg_cnt = 7 / stack_arg_cnt = 2, then fails with -EINVAL.  The subprog
>> + * is marked unreliable but the call still proceeds for static subprogs.
>> + */
>> +__noinline __used __naked
>> +static void subprog_bad_ptr_7args(long *a, int b, int c, int d, int e, int f, int g)
>> +{
>> +	asm volatile (
>> +		"r0 = *(u64 *)(r11 + 8);"
>> +		"r1 = *(u64 *)(r11 + 16);"
>> +		"exit;"
>> +		::: __clobber_all
>> +	);
>> +}
>> +
>> +SEC("tc")
>> +__description("stack_arg: read without caller write")
>> +__failure
>> +__msg("callee expects 7 args, stack arg1 is not initialized")
>> +__btf_func_path("btf__verifier_stack_arg_order.bpf.o")
>> +__naked void stack_arg_read_without_write_1(void)
>> +{
>> +	asm volatile (
>> +		"r1 = 0;"
>> +		"r2 = 0;"
>> +		"r3 = 0;"
>> +		"r4 = 0;"
>> +		"r5 = 0;"
>> +		"call subprog_bad_ptr_7args;"
>> +		"exit;"
>> +		::: __clobber_all
>> +	);
>> +}
>> +
>> +SEC("tc")
>> +__description("stack_arg: read with not-initialized caller write")
>> +__failure
>> +__msg("R0 !read_ok")
> Is the expected error message correct here? Looking at
> stack_arg_read_without_write_1 (the test just above), it expects the
> new-style message "callee expects 7 args, stack arg1 is not
> initialized" when calling subprog_bad_ptr_7args without writing to the
> stack. This test (stack_arg_read_without_write_2) also calls
> subprog_bad_ptr_7args without properly initializing the stack args, but
> expects the old-style message "R0 !read_ok" instead.
>
> The commit message explains that invalidated stack arg slots are now
> caught by check_outgoing_stack_args() at the call site instead of at
> the callee's dereference, which led to updating the expected messages
> in stack_arg_release_ref and stack_arg_stale_pkt_ptr from "R0
> !read_ok" to "callee expects 6 args, stack arg1 is not initialized".
>
> This test writes to r11-8 and r11-16 (stack args for the 6th and 7th
> parameters), then calls subprog_bad_ptr_7args twice without rewriting
> the stack between calls. The pattern matches stack_arg_sequential_calls
> in verifier_stack_arg.c which expects the new-style error message.
>
> Should this test expect "callee expects 7 args, stack arg1 is not
> initialized" to be consistent with the other tests and the commit's
> stated behavior change?

I think it should be okay. The first subprog_bad_ptr_7args()
will go through arg checking in btf_check_func_arg_match().

But the second call subprog_bad_ptr_7args() will not go through
btf_check_func_arg_match() since the subprog btf_id has been
calculated in the first subprog_bad_ptr_7args() and the verifier
simply reuse the btf_id. Due to this, the validation
check_outgoing_stack_args() inside btf_check_func_arg_match()
is not triggered.

Since there is no intermediate r11-based store, the callee
gets a 'not initialized' value for r0 and eventually gets
an error message 'R0 !read_ok' indicating the return value
is not valid.

>
>> +__btf_func_path("btf__verifier_stack_arg_order.bpf.o")
>> +__naked void stack_arg_read_without_write_2(void)
>> +{
>> +	asm volatile (
>> +		"r1 = 0;"
>> +		"r2 = 0;"
>> +		"r3 = 0;"
>> +		"r4 = 0;"
>> +		"r5 = 0;"
>> +		"*(u64 *)(r11 - 8) = 0;"
>> +		"*(u64 *)(r11 - 16) = 0;"
>> +		"call subprog_bad_ptr_7args;"
>> +		"call subprog_bad_ptr_7args;"
>> +		"exit;"
>> +		::: __clobber_all
>> +	);
>> +}
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25896151874

