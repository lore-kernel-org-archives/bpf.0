Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BD5394781
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 22:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192781; cv=none; b=slGRpNeaMgvq/aHt00oIiCvCITEIbuYJTJE35LdqPhQPjNgKO7wA4NqgWSpwnsxiHUfkVnFMuQOkR3LfimaOmUG1kQzrUbnYbpFD3zDudeO5czKHr0QO7et0Z3vT+R9e2xlOoKWF0E3Uw/WDDf/rGhwSzxIwCHWswyT3nbv8n1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192781; c=relaxed/simple;
	bh=CjfXiBwQ4O/NbxBHjTtqoENPf8DfS2iFx0x6DHUiSBs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fS3pSwyc2j7IxTu+xkBtZv9djpwQwdS1girlNI0XSearYf3Y+RmxlxYIL5JSznZcNlsMRDjVl9YpWbdNGuCLbfpDt50xDc4J15GlIAvLZaqIjargP3cgDMERpLtYV4yfkiRHzowoJFw1A9U1KI4dP4t7nxE18cIDbgsVRjJ0fqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4rYl65P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4rYl65P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0ABC2BCB2;
	Thu,  7 May 2026 22:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778192780;
	bh=CjfXiBwQ4O/NbxBHjTtqoENPf8DfS2iFx0x6DHUiSBs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=K4rYl65PBFyH8dChf+Fu5fj/7tdTr7bwnN6SAyjvP/hbJ/PcuiOf+0P6VM7QeIXov
	 FuWsCYcqDGNjHewPVZbsdXzb7s6JJhg3m9D+PZar/Ri29pwVNHKND16P25plKfD6J5
	 My/XRbRMVKgnICbGLsdiJfkRo6iAVfoe5ohewSPjyQsGuiKLVY2vgO5tt66eQsV12G
	 wmuJap1/3ZbmaHDvNYNB0NO0JNH4loyqulieuSEkwNnY63ILUpI4246hMATJuomCBd
	 TCnyTCMau1yAM9BEuu+/XEbPRbX3xzvvzPmH+aiIzBJbmTC6MrzavCqYJEOupGka0j
	 3pfmrUjjjdlJQ==
Content-Type: multipart/mixed; boundary="===============4155976587465624892=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <11c51daec78a68837f719172ae1c21db8b3e98e0a76aa5bcd59c8b089760c40d@mail.kernel.org>
In-Reply-To: <20260507213008.1127429-1-yonghong.song@linux.dev>
References: <20260507213008.1127429-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 05/23] bpf: Support stack arguments for bpf functions
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  7 May 2026 22:26:20 +0000 (UTC)

--===============4155976587465624892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 321b9d69cf9c..1fba16fced28 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -427,6 +427,10 @@ struct bpf_func_state {
>  	 * `stack`. allocated_stack is always a multiple of BPF_REG_SIZE.
>  	 */
>  	int allocated_stack;
> +
> +	bool no_stack_arg_load;
> +	u16 out_stack_arg_cnt; /* Number of outgoing on-stack argument slots */
> +	struct bpf_reg_state *stack_arg_regs; /* Outgoing on-stack arguments */
>  };

The new field no_stack_arg_load is placed after allocated_stack, but
copy_stack_state() never assigns it.

The comment at line 417 says 'The following fields should be last. See
copy_func_state()', and copy_func_state() does this:

    memcpy(dst, src, offsetof(struct bpf_func_state, stack));

so any field after stack is not memcpy'd. copy_stack_state() copies
stack, allocated_stack, out_stack_arg_cnt, and stack_arg_regs, but
not no_stack_arg_load.

Consequence: whenever a state is cloned (e.g., via push_stack() at
conditional jumps), the pushed state inherits no_stack_arg_load=0
regardless of the source state's value.

This breaks the invariant the commit message describes: 'all stack arg
reads must be ahead of any stack arg write' and 'all stack arg reads must
be before any bpf func, kfunc and helpers'.

A BPF program can write to an outgoing stack arg (which sets
cur->no_stack_arg_load=true in check_stack_arg_write), then execute a
conditional jump which calls push_stack(). The pushed state's
no_stack_arg_load is reset to 0, so a subsequent stack arg read would be
accepted by check_stack_arg_read() when it should be rejected.

The same issue applies to state pruning: func_states_equal/stack_arg_safe
does not compare no_stack_arg_load either, so a state with
no_stack_arg_load=true can be pruned to an old state with
no_stack_arg_load=false incorrectly.

Should no_stack_arg_load be placed before stack (to be memcpy'd) or should
copy_stack_state() explicitly assign it?

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3bafb7ad2ba7..61d6663498f7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1362,6 +1362,18 @@ static int copy_stack_state(struct bpf_func_state *dst, const struct bpf_func_st
>  		return -ENOMEM;
>
>  	dst->allocated_stack = src->allocated_stack;
> +
> +	/* copy stack args state */
> +	n = src->out_stack_arg_cnt;
> +	if (n) {
> +		dst->stack_arg_regs = copy_array(dst->stack_arg_regs, src->stack_arg_regs, n,
> +						 sizeof(struct bpf_reg_state),
> +						 GFP_KERNEL_ACCOUNT);
> +		if (!dst->stack_arg_regs)
> +			return -ENOMEM;
> +	}
> +
> +	dst->out_stack_arg_cnt = src->out_stack_arg_cnt;
>  	return 0;
>  }

copy_stack_state() copies stack, allocated_stack, stack_arg_regs, and
out_stack_arg_cnt, but no_stack_arg_load is missing.

The field is declared in struct bpf_func_state after allocated_stack, so
it lives in the region that copy_func_state's memcpy excludes:

    static int copy_func_state(struct bpf_func_state *dst,
                               const struct bpf_func_state *src)
    {
        memcpy(dst, src, offsetof(struct bpf_func_state, stack));
        return copy_stack_state(dst, src);
    }

The memcpy stops at stack, so no_stack_arg_load is never copied. Every
state copy path through bpf_copy_verifier_state(), push_stack(), and
pop_stack() silently resets the flag.

The commit enforces the invariant 'all stack arg reads must precede any
stack arg write or any call within a frame' by setting
state->no_stack_arg_load = true in check_stack_arg_write() and in
do_check_insn()'s call branch, and checking the flag in
check_stack_arg_read().

When the verifier encounters a branch, push_stack() calls
bpf_copy_verifier_state() which loses no_stack_arg_load. A BPF program can
perform a write or call, conditionally branch, and after the branch perform
a stack arg read that should be rejected. The read passes verification
because the flag was reset to false on the restored state.

The commit message says this invariant is required because 'JIT may emit
mov insns for read/write with the same register and bpf function, kfunc and
helper will invalidate all arguments immediately after the call'. Bypassing
the flag allows JIT-generated code that reads stale or clobbered stack
argument slots at runtime.

Should copy_stack_state() add 'dst->no_stack_arg_load =
src->no_stack_arg_load;'?

[ ... ]

> @@ -4050,6 +4080,105 @@ static int check_stack_write(struct bpf_verifier_env *env,
>  	return err;
>  }
>
> +/*
> + * Write a value to the outgoing stack arg area.
> + * off is a negative offset from r11 (e.g. -8 for arg6, -16 for arg7).
> + */
> +static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_state *state,
> +				 int off, struct bpf_reg_state *value_reg)
> +{
> +	int max_stack_arg_regs = MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS;
> +	struct bpf_subprog_info *subprog = &env->subprog_info[state->subprogno];
> +	int spi = -off / BPF_REG_SIZE - 1;
> +	struct bpf_func_state *cur;
> +	struct bpf_reg_state *arg;
> +	int err;
> +
> +	if (spi >= max_stack_arg_regs) {
> +		verbose(env, "stack arg write offset %d exceeds max %d stack args\n",
> +			off, max_stack_arg_regs);
> +		return -EINVAL;
> +	}
> +
> +	err = grow_stack_arg_slots(env, state, spi + 1);
> +	if (err)
> +		return err;
> +
> +	/* Track the max outgoing stack arg slot count. */
> +	if (spi + 1 > subprog->max_out_stack_arg_cnt)
> +		subprog->max_out_stack_arg_cnt = spi + 1;
> +
> +	cur = env->cur_state->frame[env->cur_state->curframe];

This isn't a bug, but the local variable cur is assigned but never read.
Both call sites already pass state = env->cur_state->frame[curframe], so
cur is always identical to the state parameter. Should this line be
removed?

[ ... ]

> @@ -16961,6 +17135,14 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)

The register validation in check_and_resolve_insns() allows r11/BPF_REG_PARAMS
through for all instruction classes, but only BPF_LDX, BPF_STX, and BPF_ST
have explicit handling.

In v4 of this series (April 11), bot+bpf-ci@kernel.org raised a concern:

  If a BPF program uses r11 as src_reg or dst_reg in an ALU or JMP
  instruction, it would cause an out-of-bounds access to regs[11] (array
  is only regs[0-10]).

  Would it make sense to restrict the r11 exemption here to only the
  instruction classes that actually handle it (BPF_LDX, BPF_STX, BPF_ST),
  rather than allowing it globally?

The author acknowledged this was a bug and agreed to restrict the r11
exemption to only BPF_LDX, BPF_STX, BPF_ST. However, the current code does
not have any exemption for r11.

Looking at check_and_resolve_insns(), it checks 'insn->dst_reg >=
MAX_BPF_REG' without exception. Since BPF_REG_PARAMS == MAX_BPF_REG == 11,
this will reject all uses of r11 including legitimate LDX/STX/ST operations
on stack arguments.

Should check_and_resolve_insns() allow r11 for the specific instruction
classes that handle stack arguments (BPF_LDX, BPF_STX, BPF_ST)?

Reference:
https://lore.kernel.org/bpf/bcd1b7033de7f597d73b3991f8fc4d8b502fce451fc288d909ae72a717578a0d@mail.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25523765323
--===============4155976587465624892==--
