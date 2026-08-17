Received: from mta0.migadu.com (out-235.mta0.migadu.com [91.218.175.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B19143636A
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977982; cv=none; b=ITPnsb8OQp5WYSo6Er4F2VUcCzjtV21HrXN0Jy/ECwdrU6thJIuD7KKAUcTjFrJopTbzFIpmU9S/liN6sr4CcLx3nhIhJszTaSLuTbbGsJSkEBk/2ROxkGXMg0TDeS+4yvvTQwicPEWUzKOSTzBTnN1F5CBG4iJXkzCBKDTXQC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977982; c=relaxed/simple;
	bh=7F0zooi2QVxzxthLrYZpvTOFobdXpnJ4oBoLO28N8uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RatyaWOk22fdtq9oNGBcBfg2U4LKBfI5NLRVHzJHzAlOimmRwsxgMNbZ3GS3M15NSYmFZ53Qdn4id4uERznNnWeTuuEaH/XoaLkyXmmFT9Mx3SUaoglTDbRN8hdySl34mY7OCMFkSuDbi7pFHC2y6oUppQfhJFh7G0YGzTUgiXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YWm92I8z; arc=none smtp.client-ip=91.218.175.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YWm92I8z"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7F0zooi2QVxzxthLrYZpvTOFobdXpnJ4oBoLO28N8uk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786977978; v=1; x=1787582778;
 b=YWm92I8z5U4aczwLH/uREkjYG6yN+9DnRk0ZXuZIfVclqhwEZ2SIFAz2PF/QhW50OnleEWNi
 dXgwVaMhn9oJaZl2o60yNPAc8urOfG81T0e7+GjZTgAvgok81C/BoNCRj3P7S1soEoLj2EvniW2
 H+3VeV7x8MWhQ9vY0jjZ0oU4=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:5604)
	by smtp.migadu.com with ESMTPS id 733ad8e6f54186f1;
	Mon, 17 Aug 2026 14:46:08 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <14a7e7c2-36f7-4aa2-9b20-cc54700a9f1b@linux.dev>
Date: Mon, 17 Aug 2026 07:46:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: reject stack-argument callback subprograms
Content-Language: en-GB
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260816204501.493914-2-Jeremy.Jean@oss.cyber.gouv.fr>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260816204501.493914-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/16/26 1:45 PM, Jérémy Jean wrote:
> Helper callbacks enter BPF subprograms through bpf_callback_t, whose
> runtime ABI supplies five arguments. BTF validation nevertheless permits
> static callback subprograms to declare more than five arguments when JIT
> stack arguments are supported.
>
> This lets verifier state for a callback use outgoing stack argument slots
> prepared at the helper call site. The helper does not pass those slots. On
> x86-64, callback loads of arguments seven and later therefore read the
> helper native frame instead of the synthetic values checked by the
> verifier. KASAN reports a slab OOB write.
>
> Reject callback subprograms with incoming stack arguments when processing
> callback calls. Add a verifier regression test using bpf_loop() and a
> nine-argument callback.
>
> Fixes: 0f6bd5e7a804 ("bpf: Support stack arguments for bpf functions")
> Assisted-by: Codex:gpt-5
> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>   kernel/bpf/verifier.c                         |  4 +++
>   .../selftests/bpf/progs/verifier_stack_arg.c  | 33 +++++++++++++++++++
>   2 files changed, 37 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fdc5fbb1f78c..29aa4911c7f7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9285,6 +9285,10 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
>   	err = btf_check_subprog_call(env, subprog, caller->regs);
>   	if (err == -EFAULT)
>   		return err;
> +	if (bpf_in_stack_arg_cnt(&env->subprog_info[subprog])) {
> +		verbose(env, "callback subprog cannot have stack args\n");
> +		return -EINVAL;
> +	}
>   
>   	/* set_callee_state is used for direct subprog calls, but we are
>   	 * interested in validating only BPF helpers that can call subprogs as
> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> index 7e0ce5db28a0..5acc3b63ca84 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> @@ -27,6 +27,13 @@ static int subprog_7args(int a, int b, int c, int d, int e, int f, int g)
>   	return a + b + c + d + e + f + g;
>   }
>   
> +__noinline __used
> +static int callback_9args(__u32 index, void *ctx, long a3, long a4,
> +			  long a5, long a6, long a7, long a8, long a9)
> +{
> +	return a9;
> +}
> +
>   __noinline __used
>   static long subprog_deref_arg6(long a, long b, long c, long d, long e, long *f)
>   {
> @@ -79,6 +86,32 @@ __naked void stack_arg_two_subprogs(void)
>   	);
>   }
>   
> +SEC("tc")
> +__description("stack_arg: callback with incoming stack args")
> +__failure
> +__msg("callback subprog cannot have stack args")
> +__naked void stack_arg_callback_many_args(void)
> +{
> +	asm volatile (
> +		"r6 = 0;"
> +		"*(u64 *)(r11 - 32) = 0;"
> +		"*(u64 *)(r11 - 24) = 0;"
> +		"*(u64 *)(r11 - 16) = 0;"
> +		"*(u64 *)(r11 - 8) = 0;"
> +		"r1 = 1;"
> +		"r2 = %[callback_9args];"
> +		"r3 = 0;"
> +		"r4 = 0;"
> +		"call %[bpf_loop];"
> +		"r0 = 0;"
> +		"exit;"
> +		:
> +		: __imm_ptr(callback_9args),
> +		  __imm(bpf_loop)
> +		: __clobber_all
> +	);
> +}

I build with latest bpf-next and selftest with llvm23 and I got a selftest build
failure:

progs/verifier_stack_arg.c:96:3: error: inline assembly requires more registers than available
    96 |                 "r6 = 0;"
       |                 ^
   CLNG-BPF [test_progs] verifier_value_or_null.bpf.o
1 error generated.

The reason probably due to '__imm_ptr(callback_9args)'. The following change can fix the build:

index 5acc3b63ca84..f55a433b9202 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -108,7 +108,7 @@ __naked void stack_arg_callback_many_args(void)
                 :
                 : __imm_ptr(callback_9args),
                   __imm(bpf_loop)
-               : __clobber_all
+               : __clobber_common, "r6"
         );
  }

I then tested without your verifier.c change, I get the following test failure:

     All error logs:
     tester_init:PASS:tester_log_buf 0 nsec
     process_subtest:PASS:obj_open_mem 0 nsec
     process_subtest:PASS:specs_alloc 0 nsec
     run_subtest:PASS:obj_open_mem 0 nsec
     libbpf: prog 'stack_arg_callback_many_args': BPF program load failed: -EINVAL
     libbpf: prog 'stack_arg_callback_many_args': failed to load: -EINVAL
     libbpf: failed to load object 'verifier_stack_arg'
     run_subtest:PASS:unexpected_load_success 0 nsec
     validate_msgs:FAIL:979 expect_msg
     VERIFIER LOG:
     =============
     func#0 writes 4 stack arg slots, but calls only require 0
     processed 21 insns (limit 1000000) max_states_per_insn 1 total_states 2 peak_states 2 mark_read 0
     =============
     EXPECTED   SUBSTR: 'callback subprog cannot have stack args'
     Summary: 1/18 PASSED, 0 SKIPPED, 1/1 FAILED

I think the error message "func#0 writes 4 stack arg slots, but calls only require 0"
is good enough. So the extra error message "callback subprog cannot have stack args"
is not necessary in my opinion.

> +
>   SEC("tc")
>   __description("stack_arg: read from uninitialized stack arg slot")
>   __failure

