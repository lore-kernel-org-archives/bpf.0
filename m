Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046C121FF23
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 20:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772051714; cv=none; b=Ezda0fPC2SGMR724rNqJutfsYNOpSu7koUfH1QjXUqcgEduCnotONRR9fVVKI2Sl73tqPiwjrz3EFLliwbPN+JHs439lrsnAy5UdOKW8WcloCKmBgV/g5VY9YhCeCrvmLDfo3X7VJj4zbwiyP5OlVuVLPQ7nB55b5PA+F+hCpKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772051714; c=relaxed/simple;
	bh=e0r3/PS0HD8MVO62a3bxSxV4kemPjRLsQmHi+/fzruA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=oG3eBCk0YSByFMZi0gzknJsaimrThNFIf05/HyUCTRtZ8nY8UL3Hi+aRVWt61E66qycY1PL/PaPRSEi4wRyznOz5VKPSvcoC+kaBUf7HKR6d/ajdXfjLHyCJ8hH1myI0GPZSQStKk7Z/QdXGk1KIr2Uja97PdbRcQKLFdfydT/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVesk7qc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVesk7qc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A7BC116D0;
	Wed, 25 Feb 2026 20:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772051713;
	bh=e0r3/PS0HD8MVO62a3bxSxV4kemPjRLsQmHi+/fzruA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=hVesk7qchHZ6t9Yzp5mQ/vmVNbOnAdQyGLEGWLaMx5b3jNOwtsT298ZNArS2AbRKF
	 V9Ccq2FZOiR2Hl5Bk0YCmexktaH08/OtsWpSd7ywN/k8L/0T+JVji0lSrj1mIGQm2w
	 zmrxrkRut1oB87oOfPYIsWzrczMi9CeuBrw3axtJcnmw9WPUyww9NKm7fwe2J27mmC
	 SpYcFD5bshWhflezwTChe85KIhsetiXrClxoTnzhkER7/KTO/hMOsn87N/jKF657rC
	 TBDOF1QDS91BYXkE5FNLgbGKuatfGmNgaEc3IzTx4coCZcpgQGRoeLcG/JGoKInN6f
	 0zn1RA1s+jQXQ==
Content-Type: multipart/mixed; boundary="===============8260834179809546704=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e4ce5ae55b41231ac40edee888d793b574eb9fab2036264dd615117c6c0e9fbb@mail.kernel.org>
In-Reply-To: <20260226005440.9570-1-adubey@linux.ibm.com>
References: <20260226005440.9570-1-adubey@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] powerpc64/bpf: Implement JIT support for private stack
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org,hbathini@linux.ibm.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,maddy@linux.ibm.com,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 25 Feb 2026 20:35:12 +0000 (UTC)

--===============8260834179809546704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c

[ ... ]

> @@ -209,6 +264,9 @@
>  	cgctx.is_subprog = bpf_is_subprog(fp);
>  	cgctx.exception_boundary = fp->aux->exception_boundary;
>  	cgctx.exception_cb = fp->aux->exception_cb;
> +	cgctx.priv_sp = priv_stack_ptr;
> +	if (priv_stack_ptr)
> +		cgctx.stack_size = 0;

This zeros ctx->stack_size before the JIT passes, which is correct
for the kernel stack frame allocation (skipping BPF stack space on
the kernel stack).

However, emit_fp_priv_stack() also reads ctx->stack_size to compute
the BPF frame pointer offset within the private stack allocation:

> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c

[ ... ]

> +static void emit_fp_priv_stack(u32 *image, struct codegen_context *ctx)
> +{
> +	/* Load percpu data offset */
> +	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), _R13,
> +			offsetof(struct paca_struct, data_offset)));
> +	PPC_LI64(bpf_to_ppc(BPF_REG_FP), (__force long)ctx->priv_sp);
> +	/*
> +	 * Load base percpu pointer of private stack allocation.
> +	 * Runtime per-cpu address = (base + data_offset) + (guard + stack_size)
> +	 */
> +	EMIT(PPC_RAW_ADD(bpf_to_ppc(BPF_REG_FP),
> +			bpf_to_ppc(TMP_REG_1), bpf_to_ppc(BPF_REG_FP)));
> +	EMIT(PPC_RAW_ADDI(bpf_to_ppc(BPF_REG_FP), bpf_to_ppc(BPF_REG_FP),
> +			PRIV_STACK_GUARD_SZ + round_up(ctx->stack_size, 16)));
> +}

Since ctx->stack_size was set to 0 earlier in bpf_int_jit_compile(),
the ADDI immediate here becomes PRIV_STACK_GUARD_SZ + 0 = 16.
This places BPF_REG_FP at the bottom of the usable stack area
(just past the overflow guard), rather than at the top.

The commit message describes the intended layout:

    BPF frame pointer = Priv stack allocation start address +
                        Overflow guard +
                        Actual stack size defined by verifier

But the "Actual stack size defined by verifier" term is lost because
ctx->stack_size is already zero at this point.

BPF programs access the stack at FP-8, FP-16, etc.  With FP at
offset 16 from the allocation base, FP-8 lands inside the overflow
guard and larger offsets go below the allocation entirely.

For comparison, x86 in do_jit() pre-computes the offset before
zeroing:

    priv_frame_ptr = priv_stack_ptr + PRIV_STACK_GUARD_SZ +
                     round_up(stack_depth, 8);
    stack_depth = 0;

And arm64 in build_prologue() does not zero ctx->stack_size at all,
instead using it directly:

    priv_stack_ptr = prog->aux->priv_stack_ptr + PRIV_STACK_GUARD_SZ;
    emit_percpu_ptr(priv_sp, priv_stack_ptr, ctx);
    emit(A64_ADD_I(1, fp, priv_sp, ctx->stack_size), ctx);

The v1 of this patch also had it correct, pre-computing in
bpf_jit_build_prologue():

    priv_frame_ptr = (void*) ctx->priv_sp + PRIV_STACK_GUARD_SZ +
                     round_up(ctx->stack_size, 16);

It appears the "Minor refactoring" in v1->v2 moved the
cgctx.stack_size = 0 earlier in the pipeline and removed the
pre-computation step, but did not account for emit_fp_priv_stack()
needing the original stack depth.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22413899411

AI-authorship-score: low
AI-authorship-explanation: Code follows established powerpc JIT patterns with architecture-specific constructs; commit history references specific CI-bot fixes consistent with human iterative development.
issues-found: 1
issue-severity-score: high
issue-severity-explanation: BPF frame pointer is miscalculated due to using zeroed ctx->stack_size in emit_fp_priv_stack(), causing all BPF stack accesses to write outside the allocated private stack region, resulting in memory corruption.

--===============8260834179809546704==--
