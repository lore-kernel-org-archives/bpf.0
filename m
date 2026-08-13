Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8D84749E8
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786655469; cv=none; b=Kee64a51X51kGCN1fyp+U0wlAOmbf3GYZyE6EiQ+KhVQv4QmbeuEp2Fw4gF5yIBJFEAF9vmT0U1trJvjlrOyuDKnEf1H5lmnNT9xtxiNi0aXyjuO+DH5aUfFIS+raAH2dBjcOhwOgK/TZuIT1HG/8bG04Do49Wx6pi0q+Q1C/CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786655469; c=relaxed/simple;
	bh=39PztjpHaHCK7T2oFlVTslqbFJ7+t5QsZiodLeR7Jrs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AbwwokSRABjLeI0oIHlzS8CYSOgAN7U2O1/QEh58Ptnsp67W8HFEka48YLDwKZIvzTFL++y+HvjM/Y/zS+YxQG40fKULP+M/stn72ulNcC0b10vlirayUt8ePBiqXN6889IGsZZ5CXEYKmz2FlcN82bNB/OX6FeRpB5JnpE2hVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9XT3Ov/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9XT3Ov/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2E61F00A3A;
	Thu, 13 Aug 2026 21:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786655467;
	bh=j9aSXpm9pVBb79BHRmxlhA1PebeHP+wwtLS/ojqi+gk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=h9XT3Ov/P4dwMpYZMM5bKI6RyzgTZN5kstQEC5frmFBs+diMEFrGMYJaLRU/C4QXx
	 MaM0n3+EgTWzQX44hq8WY0HROaOpXk+sl3Cnryj5OtzN7CL2ZUD7GpY7kIUfQj6o4b
	 uCPAyQuHh8B1IEUcsTjBAuP43aEcAcLcr9PVbHyJ5iUUKWm/doWdtVxePKJKJdQBex
	 NcsN/Ziws1U7fL1KFTBzLEfDMXxnCF8BpnwbZ8Fqv9+52zg2uj85DztABC3PGup4Fj
	 8xr0ugWqyI6Rwoyb/QwFrdV8egZkWwRCoOcdk+0Mhz0S+khsjqDYg6Hj2t3dKIOskj
	 jfMcwWa3dzM2w==
Content-Type: multipart/mixed; boundary="===============3391158677554721720=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3cb3f15f328c59186cf442c7fda68e83849dc9db3aee638a82bfeb47917b9266@mail.kernel.org>
In-Reply-To: <20260813200240.1995795-1-yonghong.song@linux.dev>
References: <20260813200240.1995795-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 06/11] bpf: Add verifier support for 16-byte returns in R0:R2
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 21:11:07 +0000 (UTC)

--===============3391158677554721720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add verifier support for 16-byte returns in R0:R2
>
> LLVM 23 added support for returning a value in two registers for an
> __int128, or a struct/union whose size is greater than 8 but not more than
> 16 bytes. See LLVM patches [1] and [2].
>
> Before LLVM 23 the BPF backend could not return these values at all. A
> by-value struct or union return (of any size) was rejected at compile time
> with:
>
>   error: aggregate returns are not supported
>
> and an __int128 return failed later in the backend with:
>
>   fatal error: error in backend: unable to allocate function return #1
>
> Both are resolved in LLVM 23, which lowers such returns into the R0:R2
> register pair.
>
> This patch models that pair at calls to global and static BPF subprograms
> and at kfunc calls: R2 is marked alongside R0 at the call, propagated out
> of a callee at its exit, and held to the same scalar-only and no-stack-
> pointer rules that R0 already is.

This isn't a bug, but could the changelog be reworded in imperative mood
to match Documentation/process/submitting-patches.rst? The other commits
in this series follow that convention, so this one reads inconsistently.

> @@ -9858,11 +9867,15 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>  	struct bpf_func_state *caller, *callee;
>  	struct bpf_reg_state *r0;
>  	bool in_callback_fn;
> +	u32 i, nregs;
>  	int err;
>
>  	callee = state->frame[state->curframe];
>  	r0 = &callee->regs[BPF_REG_0];
> -	if (r0->type == PTR_TO_STACK) {
> +	nregs = bpf_ret_reg_pair(env, callee->subprogno) ? 2 : 1;
> +	for (i = 0; i < nregs; i++) {
> +		if (callee->regs[ret_regs[i]].type != PTR_TO_STACK)
> +			continue;
>  		/* technically it's ok to return caller's stack pointer
>  		 * (or caller's caller's pointer) back to the caller,
>  		 * since these pointers are valid. Only current stack

The new R0:R2 return-register loop is placed before the
'if (callee->in_callback_fn)' branch, so it runs for callback frames as
well. A callback follows bpf_callback_t (return value in R0 only) and R2
holds an incoming argument: set_loop_callback_state() and
set_user_ringbuf_callback_state() both do
'callee->regs[BPF_REG_2] = caller->regs[BPF_REG_3]', i.e. the
callback_ctx, which is PTR_TO_STACK for the common
'bpf_loop(n, cb, &local_var, 0)' idiom.

bpf_compute_subprog_ret_regs() sets ret_reg_pair purely from the
subprog's BTF return type and iterates every subprog, with no exclusion
for subprogs used as callbacks. So a static subprog whose BTF declares a
9..16 byte return and which is passed to bpf_loop() or
bpf_user_ringbuf_drain() gets ret_reg_pair = true, and at its BPF_EXIT
the still-live callback_ctx in R2 is inspected as if it were the upper
half of a return value.

Consequence: the callback exit is rejected with 'cannot return stack
pointer to the caller', a diagnostic that points at a register holding an
argument rather than a return value, and it fires before the
in_callback_fn R0 checks that would otherwise produce the accurate
message. Impact is limited (any such program is already ill-typed with
respect to bpf_callback_t, and compiler-generated code for a 16-byte
return does write R2), so this is a misleading-rejection /
modelling-scope defect rather than a memory-safety bug.

Would it make sense to compute nregs after the in_callback_fn branch, or
force nregs = 1 when callee->in_callback_fn, since a callback frame has
no R0:R2 return convention?

> @@ -9897,8 +9910,12 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>  			return -EFAULT;
>  		}
>  	} else {
> -		/* return to the caller whatever r0 had in the callee */
> -		caller->regs[BPF_REG_0] = *r0;
> +		/*
> +		 * return to the caller whatever the callee had in the
> +		 * return register(s)
> +		 */
> +		for (i = 0; i < nregs; i++)
> +			caller->regs[ret_regs[i]] = callee->regs[ret_regs[i]];
>  	}

prepare_func_exit() has three call sites, and only the real BPF_EXIT one
(process_bpf_exit_full()) establishes the callee's return registers. The
other two are synthetic exits that explicitly set up R0 but not R2,
because R1-R5 were already reset to NOT_INIT above them:

In check_helper_call(), BPF_FUNC_tail_call inside a subprog: the
caller-saved reset loop sets R1-R5 to NOT_INIT, then only
'mark_reg_unknown(env, regs, BPF_REG_0)' runs before
'prepare_func_exit(env, &env->insn_idx)'.

In check_ld_abs() hidden BPF_EXIT inside a subprog: reset loop, then only
'mark_reg_known_zero(env, regs, BPF_REG_0)' before prepare_func_exit().

For a static subprog with ret_reg_pair set, the new copy loop therefore
propagates a NOT_INIT R2 into caller->regs[BPF_REG_2] on those paths.
This is fail-safe (no uninitialised value is treated as readable), but it
means a caller that reads the upper half of the 16-byte return is
rejected on that path with an opaque 'R2 !read_ok', so a subprog with a
>8 byte return that contains a bpf_tail_call() or LD_ABS is unverifiable,
and only R0 gets the conservative unknown-scalar treatment the commit
message describes.

Would symmetric handling be to mark R2 unknown next to R0 at both sites
(the tail-called program only defines R0, so R2 is genuinely undefined
there), or to reject the combination with an explicit message?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31740414277
--===============3391158677554721720==--
