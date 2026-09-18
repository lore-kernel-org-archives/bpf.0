Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCAE46F48F
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789710275; cv=none; b=MiobIJhyjIWnJZmtddORxdSG5SwaR/G8rCzmZf4oyriXcLfqdwNOcHKIIpm7tpwRgcbDGWXXj/V0cVQXXdZ9TNUbC/P+snwdDWucNeLlLji9eSoWFW1bz/5dZ79JlW0jg+CosxPfyimuujQlaO1SEsM3g1dUvweTuBaDzeJumYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789710275; c=relaxed/simple;
	bh=lBgiem29qc1U6d6gk13cOe10iyMzvn8AkT3Pm/o7MOs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=igKiEUfxWAWsU65oWlSYEl0DfozXO/b3fadav3C2ahR/8az+NMxcFDs/MfmahYDl64xcdIhUP36gXF3LIoAWIK8QL8sztiArBSkfgmR+Zod+YSHp6iav1pkt++2vCde/WRdE8CvDYmZW1UgSO/S3vBip8ctCJ7lhEZ5UoEopUfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coHLIx5e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coHLIx5e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5854F1F000FF;
	Fri, 18 Sep 2026 05:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789710273;
	bh=S2crpC/Fltd/Gygbm2gUXmXIkN9PgOX9Oi/3hX02ufU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=coHLIx5e5Q7nPQIaRYVVRP8Ynzk+Ig0Nql5uvESzmqdQJVeR+xZP2HQsRS2g6PHqa
	 8Pbw4bYSgctmIEcRKlY/1SpbqsHNn3LfRkeibBBczD4KVGOQ/KY2mBzr6s/XH7QPsj
	 K9006aeEKxwuhRY9mumgobLBj8AKvFqTU+CJ5+dW5crJHSM7r2g+LKRrDjsFSbjMwh
	 R8FlHVl6p1TaagrMGQuKYV0sC+mienvvPkRSrIaWhryTQ/byd6ZvsWD+Xdw1Fmw0o7
	 /owzwoSn1LbGcDwGQTPFKhFCQilmlz90nfpXuCVA0DD49SouLcWpB2J3C6m2MW8E7Y
	 24+Kiw6jjJHXg==
Content-Type: multipart/mixed; boundary="===============3909639057754140270=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b6634a3cbdbc27643a93d8a371677950b3cfbcd94169d268cd0cb1f3a4ae2a53@mail.kernel.org>
In-Reply-To: <20260918044253.3289522-1-yonghong.song@linux.dev>
References: <20260918044253.3289522-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 11/20] bpf, x86: Dispatch exception cleanup pads at run time
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 05:44:33 +0000 (UTC)

--===============3909639057754140270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/net/Makefile b/arch/x86/net/Makefile
> index dddbefc0f4398..9d574d972df37 100644
> --- a/arch/x86/net/Makefile
> +++ b/arch/x86/net/Makefile
> @@ -6,5 +6,5 @@
>  ifeq ($(CONFIG_X86_32),y)
>          obj-$(CONFIG_BPF_JIT) += bpf_jit_comp32.o
>  else
> -        obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o bpf_timed_may_goto.o
> +        obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o bpf_timed_may_goto.o bpf_cleanup_pad.o
>  endif
> diff --git a/arch/x86/net/bpf_cleanup_pad.S b/arch/x86/net/bpf_cleanup_pad.S
> new file mode 100644
> index 0000000000000..da4b448ecf095
> --- /dev/null
> +++ b/arch/x86/net/bpf_cleanup_pad.S

[ ... ]

> +SYM_FUNC_START(arch_bpf_run_cleanup_pad)
> +	ANNOTATE_NOENDBR
> +
> +	pushq %rbp
> +	pushq %rbx
> +	pushq %r12
> +	pushq %r13
> +	pushq %r14
> +	pushq %r15
> +	/* Keep the pad's entry rsp congruent to a normal call's. */
> +	subq $8, %rsp
> +
> +	movq 0(%rdx), %r15
> +	movq 8(%rdx), %r14
> +	movq 16(%rdx), %r13
> +	movq 24(%rdx), %rbx
> +	movq 32(%rdx), %r12
> +	/* rbp is BPF r10, so this is the whole of the pad's frame setup. */
> +	movq %rsi, %rbp
> +
> +	/* CALL_NOSPEC needs the target in a register; rcx is BPF r4, dead. */
> +	movq %rdi, %rcx
> +
> +	/* BPF r0 on the way into a pad, not whatever the kernel left in rax. */
> +	movl $BPF_PAD_ENTRY_R0, %eax
> +
> +	CALL_NOSPEC rcx
> +
> +	addq $8, %rsp
> +	popq %r15
> +	popq %r14
> +	popq %r13
> +	popq %r12
> +	popq %rbx
> +	popq %rbp
> +	RET
> +SYM_FUNC_END(arch_bpf_run_cleanup_pad)

Will this build with CONFIG_STACK_VALIDATION enabled?

arch_bpf_run_cleanup_pad() is declared with SYM_FUNC_START (an STT_FUNC
symbol) and saves rbp with 'pushq %rbp', but never establishes a frame
pointer with 'mov %rsp, %rbp'. Instead, it overwrites rbp with the BPF
frame pointer (movq %rsi, %rbp) and then makes a call (CALL_NOSPEC rcx).

objtool's frame-pointer validation (CONFIG_STACK_VALIDATION with
UNWINDER_FRAME_POINTER) checks for two conditions in validate_call()
and validate_return():

tools/objtool/check.c:has_valid_stack_frame() requires cfi->cfa.base ==
CFI_BP, which is only set when the function does 'mov %rsp, %rbp' to
establish a frame. This function never does that, so the CALL_NOSPEC
would trigger:

    WARN_INSN(insn, "call without frame pointer save/setup");

Additionally, the 'pushq %rbp' while cfa->base != CFI_BP sets
cfi->bp_scratch = true, which is only cleared by 'mov %rsp, %rbp'.
This flag is still set at the RET, where validate_return() warns:

    WARN_INSN(insn, "BP used as a scratch register");

The Makefile adds bpf_cleanup_pad.o unconditionally under
obj-$(CONFIG_BPF_JIT), even though the feature is gated on
CONFIG_UNWINDER_ORC per bpf_jit_supports_cleanup_pads(). This means
in a CONFIG_STACK_VALIDATION=y build (frame-pointer unwinder), the
object would fail objtool validation, and with CONFIG_OBJTOOL_WERROR=y
the build would fail.

The neighbouring arch/x86/net/bpf_timed_may_goto.S does not have this
issue because it sets up a proper frame:

arch/x86/net/bpf_timed_may_goto.S:
    pushq %rbp
    movq %rsp, %rbp
    ...
    leave

rbp cannot be the frame pointer here because it must carry BPF r10 into
the pad. This is the same situation arch/x86/kernel/ftrace_64.S handles
with STACK_FRAME_NON_STANDARD_FP(ftrace_caller). Could either
STACK_FRAME_NON_STANDARD_FP(arch_bpf_run_cleanup_pad) after SYM_FUNC_END
or building the object only when CONFIG_UNWINDER_ORC is set (matching the
feature gate) address this?

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index d4a980140b48d..9d0dd54773e83 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -357,6 +357,11 @@ struct jit_context {
>  /* Number of bytes that will be skipped on tailcall */
>  #define X86_TAIL_CALL_OFFSET	(12 + ENDBR_INSN_SIZE)
>
> +/* Throw-site spill: r15, r14, r13, rbx, r12 low to high, the layout the
> + * prologue's pushes leave, so arch_bpf_run_cleanup_pad() reads both alike.
> + */
> +#define X86_CLEANUP_SPILL_SZ	(5 * 8)

This isn't a bug, but could the comment format be updated to match the
BPF subsystem style? The BPF subsystem guide requires the modern kernel
multi-line comment style, where the opening /* is on its own line. The
patch already uses this format for its other new multi-line comments
(the "Lowest address of each spill area" block and the "Spill r6-r9 and
r12" block later in do_jit), so is there a reason for the inconsistency
here?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35308528711
--===============3909639057754140270==--
