Received: from mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D1E35B636
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 04:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788842073; cv=none; b=oY1xdRr7qZ7FFyFhhJDBKKfhkatIFerbQTtVdvjL+kVZOiPednodkAhTCzC17/VoylSopfDvpXoP3e24QWUM9arRtTVkdMe2Ko/UDtPUnIpMM6va1KGn84OEzjyLwjVaUSXewWmpWo3TkP7IpqZXQ4ngMddbMAq4IefIN91opec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788842073; c=relaxed/simple;
	bh=FBkzH4FmxyiJ6UaujWPJajf3UHHUncF3YTnhmZXwvyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTmNpQUnhU0OA5ZD79VgjjwcJoFMxKVf8ScmgFtiDjgnJgtQ5VfPTRZFeMwfWp2zm9vKSEaTHt/83JY/UPF2ZjfTWmo0ACe++iN2ubv7g31X9jYldlyGZhWVjLdlhi67tNGL8+g4ffL7IS3LeaI1xvdy1F5841xZ8q5GmjT0wVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bjmQZRHx; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bjmQZRHx"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FBkzH4FmxyiJ6UaujWPJajf3UHHUncF3YTnhmZXwvyY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788842069; v=1; x=1789446869;
 b=bjmQZRHxsZPNsQmLFJEK+D+nwqubzVFYD4oMyJ0fIqXiN+tNq9FmQ+ME4M2SnGj0vssAppWy
 W9ftWTTS+tdddbOMCjZcFZkfkmx+rIbewUrT4YWch2MSw0z71Fx6NdBUfiZBVQn4vfd7Y49WkHx
 cJZHIPVaUxx5mDbqQpmoO6OM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fbfda56459243b19;
	Tue, 08 Sep 2026 04:34:29 +0000
X-Mizu-Trace-ID: fbfda56459243b19
X-Migadu-Flow: FLOW_OUT
Message-ID: <6f0c3bd3-72b6-4b95-8243-0e3afc8aadb3@linux.dev>
Date: Mon, 7 Sep 2026 21:34:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 10/12] selftests/bpf: Add C tests for by-value
 arguments up to 16 bytes
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260904051049.3982644-1-yonghong.song@linux.dev>
 <ad847760e5ace756d56643446a1eabb99354e2dfbdb394f0800c382933237420@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ad847760e5ace756d56643446a1eabb99354e2dfbdb394f0800c382933237420@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/3/26 11:09 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_int128_arg.c b/tools/testing/selftests/bpf/progs/verifier_int128_arg.c
>> index 044fc4a80055..b10fb4aeb405 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_int128_arg.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_int128_arg.c
> [ ... ]
>
>> @@ -28,4 +153,43 @@ int aggregate_arg_int128_c_test(struct __sk_buff *skb)
>>   	return 0;
>>   }
>>
>> +#if defined(__BPF_FEATURE_STACK_ARGUMENT)
>> +
>> +static __noinline __u64 take_spilled_pair(int a, int b, int c, int d, struct pair p)
>> +{
>> +	return (__u64)a + b + c + d + p.lo + p.hi;
>> +}
>> +
>> +SEC("tc")
>> +__arch_x86_64 __arch_arm64
>> +__success __retval(0)
>> +int aggregate_arg_spilled_struct_c_test(struct __sk_buff *skb)
> Should aggregate_arg_spilled_struct_c_test() include the __load_if_JITed()
> tag?
>
> The test calls take_spilled_pair(int a, int b, int c, int d, struct pair p)
> which has 5 BTF parameters but 6 argument slots. btf_prepare_func_args() in
> kernel/bpf/btf.c expands the 16-byte struct into two slots:
>
>      nslots = (t->size + BPF_REG_SIZE - 1) / BPF_REG_SIZE;
>      while (nslots--)
>          sub->args[slots_used++].arg_type = ARG_ANYTHING;
>      ...
>      if (slots_used > MAX_BPF_FUNC_REG_ARGS) {
>          ...
>          sub->stack_arg_cnt = slots_used - MAX_BPF_FUNC_REG_ARGS;
>
> This path is reached for a static callee too: check_func_call() calls
> btf_check_subprog_call() -> btf_check_func_arg_match() ->
> btf_prepare_func_args() before the bpf_subprog_is_global() branch in
> kernel/bpf/verifier.c, and then propagates the count into
> caller_info->stack_arg_cnt. So bpf_in_stack_arg_cnt() returns 1 for
> take_spilled_pair().
>
> bpf_fixup_call_args() then rejects the program outright when the JIT is
> not used:
>
>      for (i = 0; i < env->subprog_cnt; i++) {
>          if (bpf_in_stack_arg_cnt(&env->subprog_info[i])) {
>              verbose(env, "stack args are not supported in non-JITed programs\n");
>              return -EINVAL;
>          }
>      }
>
> This is in kernel/bpf/fixups.c, inside #ifndef CONFIG_BPF_JIT_ALWAYS_ON,
> reached whenever prog->jit_requested is 0.
>
> On the harness side, test_loader.c derives the runtime from the sysctl
> and only skips programs that asked for the JIT:
>
>      int current_runtime = is_jit_enabled() ? JITED : NO_JITED;
>      ...
>      if ((current_runtime & spec->load_mask) == 0) { test__skip(); return; }
>
> and spec->load_mask defaults to JITED | NO_JITED. __arch_x86_64 and
> __arch_arm64 only constrain spec->arch_mask, not load_mask.
>
> So with /proc/sys/net/core/bpf_jit_enable == 0 and CONFIG_BPF_JIT_ALWAYS_ON=n,
> the program is loaded, rejected with "stack args are not supported in
> non-JITed programs", and the __success expectation fails.
>
> The idiom for this is __load_if_JITed() (bpf_misc.h). The sibling file
> progs/verifier_aggregate_ret.c tags every one of its __success __retval
> cases with __load_if_JITed() for exactly this reason. Adding
> __load_if_JITed() alongside __arch_x86_64 __arch_arm64 here would turn
> the JIT-off run into a skip.
>
> The same tag also appears to be missing on the stack-argument cases added
> later in the series (progs/aggregate_arg_kfunc.c:
> aggregate_arg_kfunc_last_regs, aggregate_arg_kfunc_straddle), and on the
> pre-existing progs/verifier_stack_arg.c __success cases.

Yes, will add __load_if_JITed().

>
>> +{
>> +	__u64 a = skb->len ^ MIX_A;
>> +	__u64 b = skb->len ^ MIX_B;
>> +	struct pair p = { .lo = a, .hi = b };
>> +	int n = skb->len;
>> +
>> +	if (take_spilled_pair(n, n + 1, n + 2, n + 3, p) != a + b + 4 * n + 6)
>> +		return 1;
>> +
>> +	return 0;
>> +}
>> +
>> +#endif
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33840714551

