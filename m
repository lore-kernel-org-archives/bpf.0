Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163139;
	b=gi3o4dhzbLecSIB/jlg+cGrZHm7K2Za5F2/uQ2iO6I+JKsgcPAaB6usYm+Fi9D4MWEGD
	 PDgIz8pJgYEMIGOimb94UHlpdN+2psqS/Serq/ZmsxS8mAlNAyERMLi9UL6pFGol42fkl
	 qewd4uC4T3LrM4vbOdK2P2I4kWaI0Q56Okm7VdnR9K7s9eCI78ZpC6ZDCPg1cCBCYbO9H
	 OLPlzXgbtPcd3y3vImKTObPzG8St+lXoi0Rig9awqNmO/26CxBhdm5ih3mSHOqMcW9IdY
	 fDfk6dBOwumfzh/KHLCevCS2ODuMlZ+UotndcKJlDkCFnoxsd4VfND1tdZ/RndHj5Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163139;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=2Jh61W9YJ3JHmuulOZ8Gs75FY73MluttUA69OPYrw8U=;
	b=NgoRGPHv5mQXic6yWuqkHWKYJC7qec/1TsUnyAi4vBQdPqsAaPyJOhYj/JtmWd3E8hTt
	 MTEhcLOhVwskaA9IRISTf/+K8/3Yv99VfS2orWWMVnezjcr8D9JCneFAyhMEPwRGPGAYP
	 Ayh0F5nJyRgO9NTcSLKJzprOOGaQ0JCh0wJsr+lKUCWKZ+z2kWwtxZAVWFKJoH8kzlGNW
	 yQ6iKOUyhTaYffkmtVk8ypP9i63SgExOf+jyZCQ0M7tDszhlobm8sdi3eIgCaqOWK9CvP
	 CptDyHbg8yZFh/6LQelnP3bzjJmY0hqlNWtKcDkEMpGq/1luj5ABp9qfmU5r0U3v/pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QMv8SKID;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662DC606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QMv8SKID
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80EB1F000C4;
	Fri, 20 Nov 2026 08:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795163139;
	bh=2Jh61W9YJ3JHmuulOZ8Gs75FY73MluttUA69OPYrw8U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QMv8SKIDYhc4abHIUfDqhaDFMD6CEBdh8g/kNmRvVoVB+lBQbd0t7Lh2oiG9QtTab
	 b/LpIE+jKWcgBivsWOE14M4heGN0cDC9a3OullMgY1BXBb2xZGGpx2dCPOAo1uRP0v
	 n+VUJ6xth0+wezpcdqDufpdZLSuOR2rjJ1AUErsIB0cjff9HP38iD/0UmCzOyvzPlk
	 87KQ5Src4ukwh9LlHmZ5t3yojS7NT2rC4uTa1GJ6DYtbLHE3Ulj5657NBsttL0Yi/N
	 TEc1mBzyUiV5TJEiXWRhHX3COk7VOAPSUT8xVjg3gviVsEEPQ0HNfn4ZbW5MMT7Qho
	 8KAhELZXqtI9w==
Content-Type: multipart/mixed; boundary="===============5635143653485341256=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <444ad4786b76d8d3fa76ad4debd7c0cc3d4b1e02ee1cbec78a13d98846bee562@mail.kernel.org>
In-Reply-To: <20261120074430.2704488-9-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-9-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 08/49] bpf: Do not fail a check because a state has fewer values
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 08:25:37 +0000 (UTC)

--===============5635143653485341256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Do not fail a check because a state has fewer values

TL;DR:
- cut_range() calls undefined bpf_xreg_in_deps(), so the tree does not build
- the unread 'again' flag may let the split-off range be dropped, leaving
  unchecked values
- new env fields are never set or read; two comment nits

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1179,10 +1179,13 @@ struct bpf_verifier_env {
>  	bool uses_arena_sp;		/* the program has insns with BPF_REG_ARENA_SP */
> +	bool path_sensitive;		/* no joins, see run_path_sensitive() */
>  	u64 cost, mem;			/* see bpf_check_limits() */
>  	u64 max_cost, max_mem;
>  	u64 pass_max_cost;		/* see bpf_undo_precision() */
>  	bool aborted;			/* a thaw does not take it back */
> +	int err;			/* the first error */
> +	bool imprecise;			/* a state before the first error is imprecise */

Are these three new fields wired up anywhere?

path_sensitive is never written, and no file defines run_path_sensitive().
err is never written either, and its only use is the read in cut_range():

    env->imprecise |= !env->err;

imprecise is written there, but nothing reads it.  The same is true at the
end of the series (a50a112fb866).  env comes from kvzalloc_obj(), so
path_sensitive is always false and err is always 0.

The commit message relies on bpf_xreg_in_deps() ("It does that only if an
error depends on the register, see bpf_xreg_in_deps()"), but git grep -w
bpf_xreg_in_deps finds only its call in cut_range(), at this commit and at
a50a112fb866.  The parent commit already calls an undefined
bpf_flow_deliver(), so the tree did not build before this commit either.

Should the code that sets path_sensitive and err, reads imprecise, and
defines run_path_sensitive() and bpf_xreg_in_deps() be part of this commit,
or should the fields and the gate wait for the commit that adds it?

[ ... ]

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
> @@ -596,9 +596,8 @@ bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 half_sp
>   * fill a pointer, and a helper, a kfunc or a global subprog that gets a pointer to the stack reads
>   * memory. Such a read keeps the bytes of the slot alive, not what the verifier knows about them.
>   *
> - * A short load at an offset that is known here counts as a fill: the main pass rejects it when it
> - * finds a pointer. If only the main pass knows the offset, the load doesn't count. It is rejected
> - * too, or it reads unknown bytes if the state was cleaned between the spill and the load.
> + * A short load at an offset that is known here counts as a fill: it gets a part of a number.
> + * If only the main pass knows the offset, the load doesn't count.
>   */

This isn't a bug, but the rewritten comment no longer gives a reason for the
rule it describes.

bpf_stack_slot_filled() has one caller, the pointer-cleaning branch of
__clean_func_state(), which runs only for:

    env->allow_ptr_leaks && bpf_is_spilled_reg(slot) &&
    slot->spilled_ptr.type != SCALAR_VALUE

With this commit, check_stack_read() sends every privileged short load of a
spilled non-scalar slot down the variable-offset path.  There,
check_stack_range_initialized() accepts the STACK_SPILL bytes and
mark_reg_stack_read() produces an unknown scalar, which is the same result
the load gets after the slot has been cleaned to STACK_MISC.  A short load
can no longer tell a kept pointer from a cleaned one, whether or not
liveness knows the offset.

The old reason was removed, and the new one ("it gets a part of a number")
describes a spilled scalar, which this query never covers.  Meanwhile
liveness still makes the distinction:

    info.bytes_only = class == BPF_LDX && info.size < BPF_REG_SIZE &&
                      !ptr->off_cnt;

A short load at a known offset still marks the slot as filled, which stops
a spilled pointer from being cleaned and costs pruning.

Should "&& !ptr->off_cnt" be dropped, so that the comment can say a short
load never fills, or does the comment need a different reason?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -197,6 +197,7 @@ struct bpf_verifier_stack_elem {
>  	int prev_insn_idx;
>  	/* it goes there only if may_goto in front of prev_insn_idx does, see check_loop_guard() */
>  	enum bpf_guard_edge guard_edge;
> +	bool again;	/* see bpf_flow_deliver() */
>  	struct bpf_verifier_stack_elem *next;
>  };

Is this 'again' field ever read?  It is set in cut_range():

    env->head->again = true;

The only place that pops these elements is flow_drain().  It passes
guard_edge on explicitly but leaves 'again' out:

    if (!err && elem->guard_edge)
        err = bpf_flow_guard_edge(env, &elem->st, elem->insn_idx,
                                  elem->prev_insn_idx, elem->guard_edge);
    else if (!err)
        err = bpf_flow_deliver(env, &elem->st, elem->insn_idx,
                               elem->prev_insn_idx);

bpf_flow_deliver() cannot recover the flag with container_of(), since
do_check_block() also calls it with env->cur_state, which is not inside a
stack element.  A grep of kernel/bpf and include/linux at this commit and
at a50a112fb866 finds no other reference to the field.

So the second half of a split range reaches bpf_flow_deliver() looking like
an ordinary state on an edge from the jump to itself (insn_idx ==
prev_insn_idx).  The bpf_flow_deliver() removed by 32e8f52de3c8 merged an
arriving state into the states already recorded at insn_idx, and
flow_apply_exit() avoided calling it for a state that "was at the insn
before, it may be there still".  A cut state is in exactly that situation,
so that could undo the cut or absorb the 'back' half.

This tree has no definition of bpf_flow_deliver(), so the effect cannot be
confirmed here.  Should flow_drain() pass elem->again to the flow layer?
If insn_idx == prev_insn_idx is meant to be the signal, the field and its
comment can go.

[ ... ]

> @@ -4164,6 +4171,11 @@ static int check_stack_read(struct bpf_verifier_env *env,
>  	 * writes could still lead to unsafe speculative behaviour.
>  	 */
> +	if (!var_off && dst_regno >= 0 && size != BPF_REG_SIZE && env->allow_ptr_leaks) {
> +		ss = bpf_stack_slot(state, (-off - reg->var_off.value - 1) / BPF_REG_SIZE);
> +		/* a part of a pointer is a number, as with a variable offset */
> +		var_off = bpf_is_spilled_reg(ss) && !bpf_is_spilled_scalar_reg(ss);
> +	}
>  	if (!var_off) {

This isn't a bug, but the header comment of check_stack_read_var_off() now
says the opposite of what this routing does:

    * the offset is not fixed). We conservatively mark 'dst_regno' as containing
    * SCALAR_VALUE. That's why we assert that the 'reg' has a variable
    * offset; for a fixed offset check_stack_read_fixed_off should be used
    * instead.

The new routing itself works, since check_stack_range_initialized() and
mark_reg_stack_read() handle a constant var_off.  But a later reader could
add a real tnum_is_const() assertion there, or "fix" the caller back to
check_stack_read_fixed_off(), which would bring back the "invalid size of
register fill" rejection this patch removes.

Should the comment say that a constant offset into a spilled non-scalar
also comes here?

[ ... ]

> +static int cut_range(struct bpf_verifier_env *env, const struct bpf_insn *insn, u32 regno,
> +		     const struct bpf_reg_state *taken, const struct bpf_reg_state *not_taken)
> +{
[ ... ]
> +	env->imprecise |= !env->err;
> +	if (!env->path_sensitive && !bpf_xreg_in_deps(env, st, st->curframe, regno))
> +		return 0;

Does kernel/bpf/verifier.c build with this?  bpf_xreg_in_deps() is not
defined or declared anywhere in the tree, at this commit or at
a50a112fb866, and no commit in 8f72de1c4064..a50a112fb866 adds it.
scripts/Makefile.warn adds -Werror=implicit-function-declaration, so this
call is a build error.

The fields read on the same lines have the same problem.  Nothing assigns
env->path_sensitive or env->err, so !env->path_sensitive is always true and
every split depends on the missing function.  env->imprecise is written here
but never read.

The parent commit already lacks a definition of bpf_flow_deliver(), so this
may be a gap in how the series was extracted, but this commit still adds a
new call to an undefined function.

[ ... ]

> +	other = push_stack(env, env->insn_idx, env->insn_idx, false);
> +	if (IS_ERR(other))
> +		return PTR_ERR(other);
> +	env->head->again = true;
> +	other->frame[other->curframe]->regs[regno] = back;
> +	*reg = front;
> +	return 1;

Can the 'back' half actually be explored here?  cut_range() narrows the
current state to 'front' and pushes 'back' to the same conditional jump with
prev_insn_idx == insn_idx, relying on env->head->again.  Nothing reads
'again', and flow_drain() delivers the pushed state like any other:

    else if (!err)
        err = bpf_flow_deliver(env, &elem->st, elem->insn_idx,
                               elem->prev_insn_idx);

bpf_flow_deliver() takes only (env, st, insn_idx, prev_insn_idx), and
struct bpf_verifier_stack_elem is private to verifier.c.

In the last bpf_flow_deliver() in history (5395aa9bbeb5, kernel/bpf/flow.c),
a delivered state goes through flow_merge().  That function frees the
arriving state when a member of the set at that insn covers it
(flow_within() -> return 1), or joins it with members.  When the jump is a
flow point, the set there holds the state that arrived before the split, and
that state covers 'back'.

If delivery still works this way, 'back' is dropped or joined back into the
wide range, so values in 'back' (for example 0..3 in the commit message
example) are never checked past the jump.  Or the join recreates the
crossing range and the split repeats.  The self-edge prev_insn_idx ==
insn_idx also reaches the loop enter/leave logic in delivery without any
marker.

No commit in 8f72de1c4064..a50a112fb866 reads elem->again or changes
flow_drain().


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44698144269
--===============5635143653485341256==--
