Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A073835BDB2
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 04:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776400525; cv=none; b=Kp02xZr7e4dQBOwi1ojBMT9M/iFGYWOpRgpV/NpYbyrpMPuaPRgGERkhybsuJgTbeUA699TzCHSZL3mNivhTa6JhDy3IbNImdEojVAayKfPmrwO/uvWrC62hJNm0HjtP487XM2wXHwM7w9HL18SDUbdJtN7FyFtgEheiuzml9ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776400525; c=relaxed/simple;
	bh=C+5Xl+Kdj+3ac1o7INQNkrf+75kijR0gIbzD0erYzcM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o2n0g8IuVO7XGMsnzYJ1XfaZrjnLnFfbY9iy3S0Si3lY3KgGEo8iF4zaZWGokG1Zr/oYGxSgDHwTl8SCj/XqJ6SJnR/k6ZSFFhvKxjaFXeZ7oqvcokuasUUcsPa8fS74zsR14DuAViXmT5n3xlhHSYMS+vEO5roakjVJo0mrrT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=finG8nsu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="finG8nsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAF1C2BCB6;
	Fri, 17 Apr 2026 04:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776400525;
	bh=C+5Xl+Kdj+3ac1o7INQNkrf+75kijR0gIbzD0erYzcM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=finG8nsuo33mHwL/KEim06gnMaidAbmHUB9K8kKbHzC2c4q00OQrbO8A5aYp/2KCp
	 3ZCfBWZSxheyvQZZnBuC7I8kEuk2lzdkRr4sWoYHMQPa3XKyLsXvFPD29Cy1CPsv0z
	 qh71yu2vV4L+J3V4I8dU83z0w2udolCuoaTntCHQJIjh6PEZlPInLzo2WPF7gAkxyB
	 Y4VDEMpG1qXDc5D89HN8ySgzK9FX2kOoOJp99hBzdTfjKvj72E7b4wSu2sOWgMaz4o
	 PyrRZQwre5sYufdV/f1YQ25nmw/rUbphOrcy8uQ+i7uub2/mPuzIgMd+VQnZ/VhNnY
	 h5xrU7ebibh+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 08/16] bpf: Support stack arguments for bpf
 functions
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260417034739.2629927-1-yonghong.song@linux.dev>
References: <20260417034739.2629927-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Apr 2026 04:35:24 +0000
Message-Id: <20260417043525.6DAF1C2BCB6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [Critical] Verifier State Leakage in `copy_stack_state` when reusing stat=
es.
- [Critical] Security / Liveness Tracking Bypass via `stack_arg_regs`.
- [Critical] Use-After-Free via Type Mismatch in `bpf_get_spilled_stack_arg=
()`.
- [Medium] Unnecessary Rejection of Valid Programs due to Dead Code Elimina=
tion.
- [Low] Missing Parentheses in `bpf_get_spilled_stack_arg` Macro.
--

commit 6ec4a3fcb5e83a95626cd2bb13a60b2283e1c3e2
Author: Yonghong Song <yonghong.song@linux.dev>
bpf: Support stack arguments for bpf functions

This commit adds support for passing more than 5 arguments to BPF subprogra=
ms
by utilizing a dedicated stack area accessed via register r11. It introduces
new fields to track incoming and outgoing stack arguments for bounds checki=
ng
and precise verifier path tracking.

Link: https://github.com/llvm/llvm-project/pull/189060

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -508,6 +513,17 @@ struct bpf_verifier_state {
>  	     iter < frame->allocated_stack / BPF_REG_SIZE;		\
>  	     iter++, reg =3D bpf_get_spilled_reg(iter, frame, mask))
> =20
> +#define bpf_get_spilled_stack_arg(slot, frame, mask)                   \
> +	(((slot < frame->stack_arg_depth / BPF_REG_SIZE) &&             \
> +	  ((1 << frame->stack_arg_regs[slot].type) & (mask))) \
> +	 ? &frame->stack_arg_regs[slot] : NULL)

Is there a type mismatch in this check?

The mask parameter here is passed as 1 << STACK_SPILL, but
frame->stack_arg_regs[slot].type is an enum bpf_reg_type, not an enum
bpf_stack_slot_type.

For pointer types, this expression can evaluate to 0. This would cause the
iterator to silently skip pointers stored in the stack argument area. If an
acquired reference is dropped via release_reference(), the copy in the stack
argument area wouldn't be invalidated, potentially allowing a use-after-free
if a program subsequently reads the spilled pointer back from r11.

Also, this isn't a bug, but should the slot parameter be enclosed in
parentheses to prevent operator precedence issues if a complex expression
is passed in the future?

[ ... ]
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1266,9 +1275,20 @@ int bpf_fixup_call_args(struct bpf_verifier_env *e=
nv)
[ ... ]
> +	for (i =3D 0; i < env->subprog_cnt; i++) {
> +		struct bpf_subprog_info *subprog =3D &env->subprog_info[i];
> +
> +		if (subprog->max_out_stack_arg_depth > subprog->outgoing_stack_arg_dep=
th) {
> +			verbose(env,
> +				"func#%d writes stack arg slot at depth %u, but calls only require %=
u bytes\n",
> +				i, subprog->max_out_stack_arg_depth, subprog->outgoing_stack_arg_dep=
th);
> +			return -EINVAL;
> +		}
> +	}

Could this reject valid programs if the compiler hoists a stack argument
store above a branch that is later eliminated as dead code?

If the compiler optimizes a store above a conditional check,
max_out_stack_arg_depth would be updated. However, if the configuration
constants cause the branch containing the actual function call to be
eliminated, outgoing_stack_arg_depth would remain 0, leading to a rejection
of a safe verification path.

[ ... ]
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1340,6 +1340,20 @@ static int copy_stack_state(struct bpf_func_state =
*dst, const struct bpf_func_st
>  		return -ENOMEM;
> =20
>  	dst->allocated_stack =3D src->allocated_stack;
> +
> +	/* copy stack args state */
> +	n =3D src->stack_arg_depth / BPF_REG_SIZE;
> +	if (n) {
> +		dst->stack_arg_regs =3D copy_array(dst->stack_arg_regs, src->stack_arg=
_regs, n,
> +					     sizeof(struct bpf_reg_state),
> +					     GFP_KERNEL_ACCOUNT);
> +		if (!dst->stack_arg_regs)
> +			return -ENOMEM;
> +
> +		dst->stack_arg_depth =3D src->stack_arg_depth;
> +		dst->incoming_stack_arg_depth =3D src->incoming_stack_arg_depth;
> +		dst->out_stack_arg_mask =3D src->out_stack_arg_mask;
> +	}
>  	return 0;
>  }

Does this skip clearing the destination's stack argument fields if the sour=
ce
state has no stack arguments?

If src->stack_arg_depth is 0, dst->stack_arg_depth, out_stack_arg_mask, and
incoming_stack_arg_depth are not updated. When the verifier reuses an
existing state during pop_stack() via bpf_copy_verifier_state(), the
destination state might incorrectly inherit a stale stack argument
initialization mask from a previously evaluated path.

Could this allow a program to initialize stack arguments on one branch, and
then safely perform a function call on a different branch without proper
initialization?

[ ... ]
> @@ -4424,6 +4467,123 @@ static int check_stack_write(struct bpf_verifier_=
env *env,
[ ... ]
> +static int check_stack_arg_write(struct bpf_verifier_env *env, struct bp=
f_func_state *state,
> +				 int off, int value_regno)
> +{
[ ... ]
> +	cur =3D env->cur_state->frame[env->cur_state->curframe];
> +	if (value_regno >=3D 0) {
> +		state->stack_arg_regs[spi] =3D cur->regs[value_regno];
> +	} else {
> +		/* BPF_ST: store immediate, treat as scalar */
> +		struct bpf_reg_state *arg =3D &state->stack_arg_regs[spi];
> +
> +		arg->type =3D SCALAR_VALUE;
> +		__mark_reg_known(arg, env->prog->insnsi[env->insn_idx].imm);
> +	}
> +	state->out_stack_arg_mask |=3D BIT(idx);
> +	return 0;
> +}
> +
> +/*
> + * Read a value from the incoming stack arg area.
> + * off is a positive offset from r11 (e.g. +8 for arg6, +16 for arg7).
> + * Callers ensure off > 0, 8-byte aligned, and size is BPF_REG_SIZE.
> + */
> +static int check_stack_arg_read(struct bpf_verifier_env *env, struct bpf=
_func_state *state,
> +				int off, int dst_regno)
> +{
[ ... ]
> +	arg =3D &state->stack_arg_regs[spi];
> +	cur =3D env->cur_state->frame[env->cur_state->curframe];
> +
> +	if (is_spillable_regtype(arg->type))
> +		copy_register_state(&cur->regs[dst_regno], arg);
> +	else
> +		mark_reg_unknown(env, cur->regs, dst_regno);
> +	return 0;
> +}

Does this bypass liveness tracking for stack arguments?

Because the state is copied directly without calling mark_reg_read(), the
live field of stack arguments is never marked as read.

During state pruning, stack_arg_safe() delegates to regsafe(), which
contains a fast-path that unconditionally returns true if the old state's
register was never marked as read. Could this cause the verifier to
aggressively prune verification paths even if they contain completely
different and potentially unsafe stack arguments?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260417034658.2625=
353-1-yonghong.song@linux.dev?part=3D8
