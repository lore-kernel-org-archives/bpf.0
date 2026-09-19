Received: from mta0.migadu.com (out-124.mta0.migadu.com [91.218.175.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268702D781B
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 20:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789848296; cv=none; b=lzPdkEXZmriELRTf5VO0omAgHUWTHuaxnIImbSmlhDL3U9zG48NxSw0ZXn9zuyjGFDmpr7T55x4eOaSUBvmCLzJ4BgsSq/h9dN9L/eUFHWSlotOE1t3CnevfCy8ZMP7IF7yRnE2Hg1C7M4yCx90oyTZo2glHve6sz1sJcVmxpJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789848296; c=relaxed/simple;
	bh=6ojxJK45eDyYNjdM50kDOTthMos0BvPDaph6RD4IMQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8u1J0RaZKUcJ4N7kGB8VFiohgoV3Tg5rL9+dWHWPnseH0zvRY6GZW+JDegBIkTmAweMs/y2xSRJSo4/I+6c4J8IeHphQNUg04lMHRl+aS2npfgxjLUhceVQxwFNWYSUAYU7JzKuIfhOVjv81gdoLd+V7EbKlR4zC8MycGlIAGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MxCgd6eE; arc=none smtp.client-ip=91.218.175.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MxCgd6eE"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6ojxJK45eDyYNjdM50kDOTthMos0BvPDaph6RD4IMQU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789848292; v=1; x=1790453092;
 b=MxCgd6eESAvgQ+Q97UhWfTtqj0s0YPMhsZgKdG+LqlniMBxs4h3pvlsSdFiH2pdZz3Q8Kh90
 h+TZIeunPruHZf5FX2f2H6OoWD7cV5ofcy0CRUJdD70jVOjIQePul9nTuFIpLe48rXLEUr+GgoD
 tHZzJn6R9WljNThViYQtHE5E=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cc3a0503e38e1dc0;
	Sat, 19 Sep 2026 20:04:52 +0000
X-Mizu-Trace-ID: cc3a0503e38e1dc0
X-Migadu-Flow: FLOW_OUT
Message-ID: <5ba9b914-a978-49d3-bbcd-09111c888e90@linux.dev>
Date: Sat, 19 Sep 2026 13:04:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 11/20] bpf, x86: Dispatch exception cleanup
 pads at run time
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260918044253.3289522-1-yonghong.song@linux.dev>
 <b6634a3cbdbc27643a93d8a371677950b3cfbcd94169d268cd0cb1f3a4ae2a53@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <b6634a3cbdbc27643a93d8a371677950b3cfbcd94169d268cd0cb1f3a4ae2a53@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/17/26 10:44 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/arch/x86/net/Makefile b/arch/x86/net/Makefile
>> index dddbefc0f4398..9d574d972df37 100644
>> --- a/arch/x86/net/Makefile
>> +++ b/arch/x86/net/Makefile
>> @@ -6,5 +6,5 @@
>>   ifeq ($(CONFIG_X86_32),y)
>>           obj-$(CONFIG_BPF_JIT) += bpf_jit_comp32.o
>>   else
>> -        obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o bpf_timed_may_goto.o
>> +        obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o bpf_timed_may_goto.o bpf_cleanup_pad.o
>>   endif
>> diff --git a/arch/x86/net/bpf_cleanup_pad.S b/arch/x86/net/bpf_cleanup_pad.S
>> new file mode 100644
>> index 0000000000000..da4b448ecf095
>> --- /dev/null
>> +++ b/arch/x86/net/bpf_cleanup_pad.S
> [ ... ]
>
>> +SYM_FUNC_START(arch_bpf_run_cleanup_pad)
>> +	ANNOTATE_NOENDBR
>> +
>> +	pushq %rbp
>> +	pushq %rbx
>> +	pushq %r12
>> +	pushq %r13
>> +	pushq %r14
>> +	pushq %r15
>> +	/* Keep the pad's entry rsp congruent to a normal call's. */
>> +	subq $8, %rsp
>> +
>> +	movq 0(%rdx), %r15
>> +	movq 8(%rdx), %r14
>> +	movq 16(%rdx), %r13
>> +	movq 24(%rdx), %rbx
>> +	movq 32(%rdx), %r12
>> +	/* rbp is BPF r10, so this is the whole of the pad's frame setup. */
>> +	movq %rsi, %rbp
>> +
>> +	/* CALL_NOSPEC needs the target in a register; rcx is BPF r4, dead. */
>> +	movq %rdi, %rcx
>> +
>> +	/* BPF r0 on the way into a pad, not whatever the kernel left in rax. */
>> +	movl $BPF_PAD_ENTRY_R0, %eax
>> +
>> +	CALL_NOSPEC rcx
>> +
>> +	addq $8, %rsp
>> +	popq %r15
>> +	popq %r14
>> +	popq %r13
>> +	popq %r12
>> +	popq %rbx
>> +	popq %rbp
>> +	RET
>> +SYM_FUNC_END(arch_bpf_run_cleanup_pad)
> Will this build with CONFIG_STACK_VALIDATION enabled?
>
> arch_bpf_run_cleanup_pad() is declared with SYM_FUNC_START (an STT_FUNC
> symbol) and saves rbp with 'pushq %rbp', but never establishes a frame
> pointer with 'mov %rsp, %rbp'. Instead, it overwrites rbp with the BPF
> frame pointer (movq %rsi, %rbp) and then makes a call (CALL_NOSPEC rcx).
>
> objtool's frame-pointer validation (CONFIG_STACK_VALIDATION with
> UNWINDER_FRAME_POINTER) checks for two conditions in validate_call()
> and validate_return():
>
> tools/objtool/check.c:has_valid_stack_frame() requires cfi->cfa.base ==
> CFI_BP, which is only set when the function does 'mov %rsp, %rbp' to
> establish a frame. This function never does that, so the CALL_NOSPEC
> would trigger:
>
>      WARN_INSN(insn, "call without frame pointer save/setup");
>
> Additionally, the 'pushq %rbp' while cfa->base != CFI_BP sets
> cfi->bp_scratch = true, which is only cleared by 'mov %rsp, %rbp'.
> This flag is still set at the RET, where validate_return() warns:
>
>      WARN_INSN(insn, "BP used as a scratch register");
>
> The Makefile adds bpf_cleanup_pad.o unconditionally under
> obj-$(CONFIG_BPF_JIT), even though the feature is gated on
> CONFIG_UNWINDER_ORC per bpf_jit_supports_cleanup_pads(). This means
> in a CONFIG_STACK_VALIDATION=y build (frame-pointer unwinder), the
> object would fail objtool validation, and with CONFIG_OBJTOOL_WERROR=y
> the build would fail.
>
> The neighbouring arch/x86/net/bpf_timed_may_goto.S does not have this
> issue because it sets up a proper frame:
>
> arch/x86/net/bpf_timed_may_goto.S:
>      pushq %rbp
>      movq %rsp, %rbp
>      ...
>      leave
>
> rbp cannot be the frame pointer here because it must carry BPF r10 into
> the pad. This is the same situation arch/x86/kernel/ftrace_64.S handles
> with STACK_FRAME_NON_STANDARD_FP(ftrace_caller). Could either
> STACK_FRAME_NON_STANDARD_FP(arch_bpf_run_cleanup_pad) after SYM_FUNC_END
> or building the object only when CONFIG_UNWINDER_ORC is set (matching the
> feature gate) address this?

Yes, jit only supports CONFIG_UNWINDER_ORC for x86, and CONFIG_STACK_VALIDATION
requires CONFIG_UNWINDER_FRAME_POINTER.

>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index d4a980140b48d..9d0dd54773e83 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -357,6 +357,11 @@ struct jit_context {
>>   /* Number of bytes that will be skipped on tailcall */
>>   #define X86_TAIL_CALL_OFFSET	(12 + ENDBR_INSN_SIZE)
>>
>> +/* Throw-site spill: r15, r14, r13, rbx, r12 low to high, the layout the
>> + * prologue's pushes leave, so arch_bpf_run_cleanup_pad() reads both alike.
>> + */
>> +#define X86_CLEANUP_SPILL_SZ	(5 * 8)
> This isn't a bug, but could the comment format be updated to match the
> BPF subsystem style? The BPF subsystem guide requires the modern kernel
> multi-line comment style, where the opening /* is on its own line. The
> patch already uses this format for its other new multi-line comments
> (the "Lowest address of each spill area" block and the "Spill r6-r9 and
> r12" block later in do_jit), so is there a reason for the inconsistency
> here?

Will adjust comment.

>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35308528711

