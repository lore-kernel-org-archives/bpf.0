Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA664A498A
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547687; cv=none; b=O560rCurw3QA9B8jAA1Ys7d20VqZfUB+TWeX6r5HNCD69RaXFYg9tlAu4KGBuJIR1c8KmPbPnzkEKAmYCeo6GS2TXD6YZsw1bW0VzX0j1ZNlhKaAbW1gCTGO0bMU7UqxLAG60+Z7Q4HTJiAxTkR51TZk7D+HMUjzYQx8YlPBQHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547687; c=relaxed/simple;
	bh=9WeY4wdaYyjy5ueo/V24OoJ0xDUQLShcaUStzoL2cuY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lzYGA2LHxl8RI3nvqsypFeayrWSpAtrbFGJ1kjTfD6EMtIzFZHMLjDXls+q1dGHedF3FZmr9cEdPtt4084CB8iTtblQlf9rO1WKOBs023TMYFXJie5PZRU8pSxcMxRMfEcsJU+BX7BDWF3ZOoUfRBNUjk0UKsiDqtMfJUq9zFz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AALbx1h7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AALbx1h7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FBF1F00893;
	Fri,  9 Oct 2026 12:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791547683;
	bh=YMwIWVVzHS51g5vROdFKprGdLXZEwcCBGemsno6XYsA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=AALbx1h7QUp3XbdmvjfJQMPCu2KbUu2fNh9sUl0y8J5aFE2cYPo3RLMex/TVIoSDL
	 YTlKNL2c9Q30FSBJPS3ZeKTfv0w3cMioQUh3AlNSWFGJDbA56+Bs292hxqXC/3oZrm
	 RURIcFLfINjPtVchoX/8gIaOEBZkvAqcZC1CreGUl2Yy4MsbVj3CLetdeIgvLtPzrG
	 pnC8tLnCs6QnM3f5y8oBi8LuCMexjGctBmjD51Ws6MvsejexjbH0CcGHNDSKNh81Id
	 43wfLvgdXvyHFGOSEY8R+PVNQY55Ae4dT6F9PNcEDELfCtYlrkr75518x+xogSxkML
	 Y39NInJkPDgGA==
Content-Type: multipart/mixed; boundary="===============2689709681121741076=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d70a6efdaf710f840fae80da3db4d74f7fd2a7fc247d3f646f00c462053ebc8a@mail.kernel.org>
In-Reply-To: <20261009-scev-minimal-rebase-v3-34-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-34-bcba9bc53ac9@gmail.com>
Subject: Re: [PATCH bpf-next v3 34/51] bpf: use SCEV to widen bounded loops
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  9 Oct 2026 12:08:01 +0000 (UTC)

--===============2689709681121741076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: use SCEV to widen bounded loops

TL;DR:
- Loop widening may turn stack accesses variable-offset, so programs that
  loaded before (dynptr loops, pointer spills) could be rejected until a later
  patch fixes it
- nit: __FUNCTION__ vs __func__

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index 2d2a84156180..05dd8e439609 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c
> @@ -1638,3 +1646,1034 @@ int bpf_init_scev(struct bpf_verifier_env *env)
[ ... ]

> +int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
> +			   struct bpf_loop_iters *iters)
[ ... ]

> +		r_scev = header_env->reg2scev[r];
> +		reg = scev_reg_for_linear(cur_func, r);
> +		/* If SCEV for r is (linear <reg> <slope>) */
> +		if (is_simple_linear(scev, r_scev, &base_reg, &slope_imm) &&
> +		    reg && is_widenable_reg_type(reg)) {
> +			continue;
> +		}
> +
> +		/* rA = rA, loop does not change this reg */
> +		if (is_reg(scev, r_scev, &ra) && r == ra)
> +			continue;
> +
> +		/* (any 1 (any 2 (any 3 4))) */
> +		if (is_widenable_any(env, cur_func, header_env, r, r_scev)) {
> +			continue;
> +		}
[ ... ]

Can widening here break stack accesses that used to verify?

bpf_compute_loop_iters() accepts a linear or (any ...) register based only on
its SCEV shape and register type.  It does not look at how the loop uses the
register.  If the register is used to build a stack address (r2 = r10;
r2 += -16; r2 += r7), widening turns constant-offset stack accesses into
variable-offset ones, and that is handled less precisely in the main pass:

  - A variable-offset fill of a spilled pointer ends up in
    mark_reg_stack_read(), which falls back to mark_reg_unknown(), so the
    pointer becomes a scalar.

  - A variable-offset spill marks the slots STACK_MISC, so the stored value
    is lost.

  - dynptr, iterator, irq and res_spin_lock stack objects go through
    stack_slot_obj_get_spi(), which rejects a non-constant var_off with
    "has to be at a constant offset".

For example:

        *(u64 *)(r10 - 16) = r1;
        *(u64 *)(r10 - 8) = r1;
        r7 = 0;
        r8 = 0;
    1:  r2 = r10;
        r2 += -16;
        r2 += r7;
        r3 = *(u64 *)(r2 + 0);
        r0 = *(u32 *)(r3 + 0);
        if r8 != 0 goto 2f;
        r7 = 8;
    2:  r8 += 1;
        if r8 < 2 goto 1b;

Here r8 is (linear r8 1) and r7 is (any r7 8), so r7 is widened to {0,8}.
The fill through r2 now has a variable offset and yields a scalar, and the
load through r3 is rejected.  Before this patch each iteration was explored
with a constant r7 and the program verified.

The same happens with a C loop such as:

    for (i = 0; i < 4; i++)
        bpf_dynptr_from_xdp(ctx, 0, &dptrs[i]);

which now fails with "dynptr has to be at a constant offset".  Spilling
pointers through a widened stack pointer fails in the same way.

A later patch in the series, 42d577fd54e2 ("bpf: avoid widening registers
that hinder exact stack-slot tracking"), adds store_base_regs and makes
bpf_compute_loop_iters() refuse to widen such registers.  Until then, programs
that loaded before are rejected.  Should that check be part of this patch?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 60287049cfe4..a597a8c18972 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19916,6 +19921,178 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
[ ... ]

> +static int maybe_clamp_scev_regs(struct bpf_verifier_env *env)
> +{
> +	struct bpf_func_state *frame = cur_func(env);
> +	struct loop_stack_entry *entry;
> +
> +	if (frame->loop_stack_cnt == 0) {
> +		verifier_bug(env, "%s: loop stack empty at %d", __FUNCTION__, env->insn_idx);
> +		return -EFAULT;
> +	}

this isn't a bug, but should __FUNCTION__ be __func__ here?  checkpatch
flags the gcc specific spelling, and the other verifier_bug() callers in
verifier.c use __func__.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37923187511
--===============2689709681121741076==--
