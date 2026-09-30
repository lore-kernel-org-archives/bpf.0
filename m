Received: from mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EF51D5160
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 02:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790734766; cv=none; b=gKFDDK01Fa7DebYOilnUOoZWSQuT0cGf7lDxlc7BDM6NO36xcn0j4nceqpbnUoKXe0fqnbgb9szJgJn2DVREnarigocOUrVihlppl0zA/1pSONd4D/I2ttEGkN+IttV0Ngj9ThbVzTS5+nQr2THmn5NloiSe75qkXzVYsh5/ox0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790734766; c=relaxed/simple;
	bh=+Gxp4j4ArX99tPanZVJPPT3WfHHy6FatDxvcmsSSvjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGqbEYrFmIduKgxqgh34KX5Wx+IGVa82A1QCjx0eli+pf1mfZ/0UUmaSlXku37mCImWrNKNRyPzTdOnsMTAAaEElzrEiWvh1CX3sJaRypYLJWQMQW+AqiyzE7j53jYSXRabUASaQGA9b5ZLBaXE1mYsEmYqe3GxPBaZ+oL+fLzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KWKgNxyV; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KWKgNxyV"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+Gxp4j4ArX99tPanZVJPPT3WfHHy6FatDxvcmsSSvjM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790734761; v=1; x=1791339561;
 b=KWKgNxyV1usIbcuXdGsEJ3/WtJADkfCpt8Mte8IM3F3Ta3Gvldl0xZQ+N72o1xti5JurGXRx
 cwx/u/KZsBAHjU6XzvBUUDj+RmnfQkUdxkNPqhbXdNjTQlmOaBYxxC4cNgSBp4Cu4tL/06E6rdH
 5+Hc7r//VGwhZQxlDr1cN/4M=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8fecc8257c5b5367;
	Wed, 30 Sep 2026 02:19:21 +0000
X-Mizu-Trace-ID: 8fecc8257c5b5367
X-Migadu-Flow: FLOW_OUT
Message-ID: <14eec737-664e-4f64-a926-03f7e1a3bbd8@linux.dev>
Date: Tue, 29 Sep 2026 19:19:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 21/22] selftests/bpf: Cover more accepted
 .bpf_cleanup exception shapes
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260929001752.3256460-1-yonghong.song@linux.dev>
 <f08a26944bc6dca7811bc09a4eecdaeb0b72b45c2034f2bf5cd32d0b6374e5c8@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <f08a26944bc6dca7811bc09a4eecdaeb0b72b45c2034f2bf5cd32d0b6374e5c8@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/28/26 5:52 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/exceptions_cleanup.h b/tools/testing/selftests/bpf/exceptions_cleanup.h
>> index d1d40314035e..616b479238c7 100644
>> --- a/tools/testing/selftests/bpf/exceptions_cleanup.h
>> +++ b/tools/testing/selftests/bpf/exceptions_cleanup.h
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
>> index 255f88d35aad..c06ec10359b9 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
>> @@ -4,6 +4,7 @@
>>   #include "exceptions_cleanup.h"
>>   #include "exceptions_cleanup.skel.h"
>>   #include "exceptions_cleanup_fail.skel.h"
>> +#include "exceptions_cleanup_shapes.skel.h"
>>
>>   /* foo3 unwound: every frame that has a pad ran it. */
>>   #define PADS_FOO3_UNWOUND \
>> @@ -82,4 +83,5 @@ void test_exceptions_cleanup(void)
>>   	exceptions_cleanup__destroy(skel);
>>
>>   	RUN_TESTS(exceptions_cleanup_fail);
>> +	RUN_TESTS(exceptions_cleanup_shapes);
>>   }
> A subsystem pattern flags this as potentially concerning: The only skip
> gate in test_exceptions_cleanup() is the -EOPNOTSUPP check on the main
> exceptions_cleanup skeleton, which tests bpf_jit_supports_cleanup_pads().
>
> RUN_TESTS(exceptions_cleanup_shapes) then loads entry_callx_region, which
> also needs indirect-call JIT support. progs/exceptions_cleanup_shapes.c
> guards that program only on the compiler and arch:
>
>      /* gcc has no indirect calls, and only these JITs emit them */
>      #if defined(__clang__) && \
>      	(defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64))
>
> On x86 the two capabilities are independent:
>
> arch/x86/net/bpf_jit_comp.c:
>
>      bool bpf_jit_supports_callx(void)
>      {
>      	return cfi_mode != CFI_FINEIBT;
>      }
>
>      bool bpf_jit_supports_cleanup_pads(void)
>      {
>      	return IS_ENABLED(CONFIG_UNWINDER_ORC);
>      }
>
> With a kCFI kernel on IBT hardware (cfi=auto resolves to CFI_FINEIBT in
> arch/x86/kernel/alternative.c), the main skeleton loads, so the skip
> branch is not taken. The verifier's require_callx_jit() then refuses
> entry_callx_region with -EOPNOTSUPP ("JIT doesn't support callx").
> test_loader's run_subtest() treats any load error on a __success program
> as ASSERT_OK(err, "unexpected_load_failure"), so this subtest fails
> instead of skipping, even though the host simply lacks the feature.
>
> Could the test check for callx support separately and skip on FineIBT
> hosts? The existing callx selftests (RUN_JITED(verifier_callx) in
> prog_tests/verifier.c and callx_func_ptr_map.c) do not skip on FineIBT
> either; they check only is_jit_enabled(). So this shape follows the
> existing convention, and the failure is limited to x86 FineIBT hosts
> (clang kCFI build plus IBT-capable CPU).

This really depends on the config. Currently CI config does not have
CONFIG_CFI so the test should be okay. This is just a CI test and we
can adjust later if config changed.

>
>> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
>> new file mode 100644
>> index 000000000000..1978fd1102f0
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
> [ ... ]
>
>> +/*
>> + * A precision chain crossing a resume: r6 is kept across a call whose only
>> + * way back is the callee's pad, then used as a variable stack offset.
>> + */
>> +static __used __naked __noinline __u64 prec_inner_frame(void)
>> +{
>> +	asm volatile (
>> +"1:"	"call bpf_unwind;"		/* cleanup region */
>> +"2:"
>> +	"r0 = 0;"
>> +	"exit;"
>> +"3:"					/* landing pad */
>> +	"call bpf_unwind_resume;"
>> +	"exit;"
>> +	CLEANUP_REC("1b", "2b", "3b")
>> +	::: __clobber_all);
>> +}
>> +
>> +static __used __naked __noinline __u64 prec_outer_frame(void)
>> +{
>> +	asm volatile (
>> +	"r1 = %[input] ll;"
>> +	"r6 = *(u64 *)(r1 + 0);"
>> +	"r6 &= 0x7;"
>> +	"r0 = 0;"
>> +	"*(u64 *)(r10 - 8) = r0;"
>> +	"*(u64 *)(r10 - 16) = r0;"
>> +	"call prec_inner_frame;"	/* comes back only through the pad */
>> +	"r2 = r10;"
>> +	"r2 += -16;"
>> +	"r2 += r6;"			/* variable stack offset: r6 must be precise */
>> +	"*(u8 *)(r2 + 0) = 1;"
>> +	"r0 = 0;"
>> +	"exit;"
>> +	:
>> +	: __imm_addr(input)
>> +	: __clobber_all);
>> +}
>> +
>> +SEC("?syscall")
>> +__success __set_global(input, 101) __retval(0)
>> +int entry_prec_across_resume(void *ctx)
>> +{
>> +	return prec_outer_frame();
>> +}
> A subsystem pattern flags this as potentially concerning:
> entry_prec_across_resume is meant to cover "a precision chain crossing a
> resume" (per the commit message), but does the verifier actually check the
> code after the call?
>
> prec_inner_frame always unwinds into its own pad. The pad ends in
> bpf_unwind_resume while curframe is 1. The resume handler in
> do_check_insn() ends the path there:
>
> kernel/bpf/verifier.c:
>
>      /*
>       * No need to walk into the caller: its pad was
>       * pushed as a branch at its call, and with no
>       * pad nothing of it runs.
>       */
>      if (env->cur_state->curframe)
>      	return PROCESS_BPF_EXIT;
>
> prec_outer_frame has no CLEANUP_REC over "call prec_inner_frame", so no
> pad branch is pushed there either. The fall-through of bpf_unwind in
> prec_inner_frame is never walked, because process_bpf_unwind() jumps
> straight to the pad. As a result, none of these instructions are ever
> verified:
>
>      "r2 = r10;"
>      "r2 += -16;"
>      "r2 += r6;"
>      "*(u8 *)(r2 + 0) = 1;"
>
> They never run either: bpf_unwind_rewrite() points prec_outer_frame's
> uncovered return at the epilogue.
>
> So the variable-offset stack write never runs mark_chain_precision() on
> r6. The resume-crossing branch in kernel/bpf/backtrack.c (the
> bt_subprog_enter() call made on a resume) is never exercised. Would the
> test still pass if "r6 &= 0x7" were deleted, or if the backtrack.c resume
> handling were broken?
>
> Both the comment "comes back only through the pad" and the header "r6 is
> kept across a call whose only way back is the callee's pad" appear
> inconsistent with this: nothing comes back. Could this shape be adjusted
> to cover the call in prec_outer_frame with a CLEANUP_REC and do the r6
> variable-offset access in prec_outer_frame's own pad, so a pad path
> verifies the use and precision is propagated back through the call?

Okay, will modify the test to have proper precision checking.

>
>> +/*
>> + * The jump_into_pad shape with the branch statically dead, so only a
>> + * speculative walk reaches the pad: a barrier rather than a refusal.
>> + */
>> +static __used __naked __noinline __u64 dead_jump_into_pad_frame(void)
>> +{
>> +	asm volatile (
>> +	"r6 = 0;"
>> +	"if r6 > 7 goto 4f;"		/* never taken: walked speculatively */
>> +"1:"	"call always_unwind;"		/* cleanup region */
>> +"2:"
>> +	"r0 = 0;"
>> +	"exit;"
>> +"3:"					/* landing pad */
>> +	"r7 = r0;"
>> +"4:"					/* ... and its second instruction */
>> +	"call bpf_unwind_resume;"
>> +	"exit;"
>> +	CLEANUP_REC("1b", "2b", "3b")
>> +	::: __clobber_all);
>> +}
>> +
>> +SEC("?syscall")
>> +__success
>> +int dead_jump_into_pad(void *ctx)
>> +{
>> +	return dead_jump_into_pad_frame();
>> +}
> A subsystem pattern flags this as potentially concerning:
> dead_jump_into_pad is meant to cover "a pad reached only by a speculative
> walk" (per the commit message), but does the verifier actually do a
> speculative walk here?
>
> The program has only __success, so test_loader loads it only in privileged
> mode, as root with all capabilities. The verifier sets:
>
>      env->bypass_spec_v1 = bpf_bypass_spec_v1(env->prog->aux->token);
>
> bpf_bypass_spec_v1() is true when bpf_token_capable(token, CAP_PERFMON)
> holds, which root satisfies. In check_cond_jmp_op(), the dead branch of
> "if r6 > 7" (pred == 0) is pushed only when bypass_spec_v1 is false:
>
> kernel/bpf/verifier.c:
>
>      } else if (pred == 0) {
>      	...
>      	if (!env->bypass_spec_v1) {
>      		err = sanitize_speculative_path(env, insn, *insn_idx + insn->off + 1,
>      						*insn_idx);
>
> So label 4 is never walked. bpf_exc_check_insn() never reports "runs both
> inside and outside a landing pad" on a speculative state, and the
> error_recoverable_with_nospec() && state->speculative recovery in
> do_check() never runs. The program loads because the verifier ignores the
> dead branch entirely, not because of the barrier logic. Would the test
> still pass unchanged if that recovery were removed and the error made
> fatal?
>
> The comment "never taken: walked speculatively" and the header "only a
> speculative walk reaches the pad: a barrier rather than a refusal" describe
> something that does not happen under the test's own settings.
>
> Could this also run the program unprivileged with CAP_BPF kept, so it
> loads but CAP_PERFMON is gone and bypass_spec_v1 is false? A syscall
> program is not a perfmon program type, so CAP_BPF is enough to load it:
>
>      SEC("?syscall")
>      __success __caps_unpriv(CAP_BPF) __success_unpriv
>      int dead_jump_into_pad(void *ctx)

Okay, I will try this one "__success __caps_unpriv(CAP_BPF) __success_unpriv".

>
> It could also check the verifier log for the nospec insertion.
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36502848904

