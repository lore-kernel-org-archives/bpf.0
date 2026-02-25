Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9AE33ADA9
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772019143; cv=none; b=sAE7VMgJs06M7D9x9BjvY5Xa58JcZYYzVc3GMnUR639rVKUF1YR6rPeLf0dklzJreXsWbz/2Mj9q6sXcRIGhACioWd/mwfrxlgly15S5GwSMMq120o9K/fpykiK6XA0Vy1YwOFGZ+S3YIn+8GnfwR0kD/ohKeD9Err6IK93rwQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772019143; c=relaxed/simple;
	bh=dertjUWoCoqTLHjFr802gNUMYAMUBvWXGSbi4fea2os=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Y+G4My+n6Jiyz0Xxa7tyvSbdqaWySDnZL4mj7TvrzOeBlhbpPYjtZCByxWRqDlDkue+/9mZcQYw5Vb+fkMOSA0GvpaUbYXqZi6hPOgkNniU261bHC9Pt+4Nf91YIxoeAu3j4/F1mO4IecSBypP9T+8xxr4JyKjiO3xI1mSqO55w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/EAetCC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/EAetCC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C78BC116D0;
	Wed, 25 Feb 2026 11:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772019142;
	bh=dertjUWoCoqTLHjFr802gNUMYAMUBvWXGSbi4fea2os=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=j/EAetCCmDn2Ym4UrJaJRe9tUfMQ7TfxOg9Tl37/0w+EkMpTJUdoOoCM8DsEpRWqf
	 O+C6jPQeZ0ybtyMhOoNYMSeUYPkG3OsflTVWs85HIrZdRZyycUSQfqEJIH3oO+pWpb
	 dGxmj0tcd/QrLfhy2/azP2+pLh51PrZi1ebVzFlSCHo/O73ewrKSdbOkBHXeieCBJX
	 7vPoo1cyWzTKXvq0x9zN3uhY2UXx9QFZqmcuuepP1ogj5bftlsTKaT+TW/SyGc1t50
	 4/QfKjzcT2b2nXShYjvL5sMmeBP9UwHCi0iYH3iU6kNTozKaWuwhkXeXL6uN34vV1F
	 nqn4fFtYDkYJw==
Content-Type: multipart/mixed; boundary="===============3041621592064433641=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d44beebe88d00a554d0bda86f0ceccf403cd0f127e82e4a52b2a2fa2ae0bf22b@mail.kernel.org>
In-Reply-To: <20260225153950.15331-1-adubey@linux.ibm.com>
References: <20260225153950.15331-1-adubey@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] powerpc64/bpf: Implement JIT support for private stack
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org,hbathini@linux.ibm.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,maddy@linux.ibm.com,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 25 Feb 2026 11:32:21 +0000 (UTC)

--===============3041621592064433641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c

[ ... ]

> +static void priv_stack_check_guard(void __percpu *priv_stack_ptr, int alloc_size,
> +								struct bpf_prog *fp)
> +{
> +	int cpu, underflow_idx = (alloc_size - PRIV_STACK_GUARD_SZ) >> 3;
> +	u64 *stack_ptr;
> +
> +	for_each_possible_cpu(cpu) {
> +		stack_ptr = per_cpu_ptr(priv_stack_ptr, cpu);
> +		if (stack_ptr[0] != PRIV_STACK_GUARD_VAL ||
> +			stack_ptr[1] != PRIV_STACK_GUARD_VAL ||
> +			stack_ptr[underflow_idx] != PRIV_STACK_GUARD_VAL ||
> +			stack_ptr[underflow_idx + 1] != PRIV_STACK_GUARD_VAL) {
> +			pr_err("BPF private stack overflow/underflow detected for prog %sx\n",
> +			bpf_jit_get_prog_name(fp));

Should "%sx" be "%s"? The trailing 'x' would be appended to the
program name in the error output.

> +			break;
> +		}
> +	}
> +}

[ ... ]

> +	priv_stack_ptr = fp->aux->priv_stack_ptr;
> +	if (!priv_stack_ptr && fp->aux->jits_use_priv_stack) {

[ ... ]

> +		priv_stack_ptr = __alloc_percpu_gfp(priv_stack_alloc_size, 16, GFP_KERNEL);
> +		if (!priv_stack_ptr) {
> +			fp = org_fp;
> +			goto out_priv_stack;
> +		}

[ ... ]

>  out_addrs:
> +		if (!image && priv_stack_ptr) {
> +			fp->aux->priv_stack_ptr = NULL;
> +			free_percpu(priv_stack_ptr);
> +		}
> +out_priv_stack:
>  		kfree(addrs);

When __alloc_percpu_gfp() fails above, goto out_priv_stack jumps
here. At that point, addrs is declared as:

    u32 *addrs;

without initialization and has not yet been assigned (the assignment
addrs = jit_data->addrs comes after the goto). This passes a garbage
pointer to kfree().

The x86 JIT has kvfree(addrs) at the out_addrs label (before
out_priv_stack), so the goto to out_priv_stack skips it. Should the
label ordering here be adjusted similarly, or should addrs be
initialized to NULL?

> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c

[ ... ]

>  		EMIT(PPC_RAW_STDU(_R1, _R1,
> -				-(bpf_jit_stack_size(ctx) + ctx->stack_size)));
> +			-(bpf_jit_stack_size(ctx) + (ctx->priv_sp ? 0 : ctx->stack_size))));
>  	}

The STDU frame size is now bpf_jit_stack_size(ctx) when priv_sp is
set, excluding ctx->stack_size. However, bpf_jit_stack_offsetof()
still computes NVR save offsets including ctx->stack_size:

    bpf_jit_stack_offsetof() {
        ...
        return (bpf_has_stack_frame(ctx) ?
            (frame_nvr_size + ctx->stack_size) : 0)
                - (8 * (32 - reg)) - BPF_PPC_TAILCALL;
    }

Similarly, bpf_jit_stack_local() returns
STACK_FRAME_MIN_SIZE + ctx->stack_size.

Since the STDU frame no longer reserves space for ctx->stack_size
when using private stack, these offsets point ctx->stack_size bytes
beyond the allocated frame. This would cause NVR saves in the
prologue and restores in the epilogue to write past the frame
boundary into the caller's stack.

The x86 JIT handles this by zeroing stack_depth in do_jit() when
private stack is active, which keeps all offset calculations
consistent. Would a similar approach work here, either zeroing
ctx->stack_size after setting up priv_sp, or updating the offset
functions to account for it?

[ ... ]

>  	/* Tear down our stack frame */
>  	if (bpf_has_stack_frame(ctx)) {
> -		EMIT(PPC_RAW_ADDI(_R1, _R1, bpf_jit_stack_size(ctx) + ctx->stack_size));
> +		EMIT(PPC_RAW_ADDI(_R1, _R1,
> +			bpf_jit_stack_size(ctx) + (ctx->priv_sp ? 0 : ctx->stack_size)));

Same issue here -- the ADDI restore is correct, but the NVR restores
emitted by bpf_jit_emit_common_epilogue() use
bpf_jit_stack_offsetof(), which still includes ctx->stack_size in
the offset and would load from the wrong location.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22393518231

AI-authorship-score: low
AI-authorship-explanation: The code shows typical human porting errors and organic review iteration across v1/v2, inconsistent with AI-generated code patterns.
issues-found: 3
issue-severity-score: high
issue-severity-explanation: Stack corruption from mismatched NVR save offsets affects every PPC64 BPF program using private stack, and kfree of an uninitialized pointer can crash or corrupt the slab allocator under memory pressure.

--===============3041621592064433641==--
