Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405885;
	b=GH3WXEDgHzKl42soJjvjFZe3rA460LA9kt6Kt8o+Eia8/N2NLv6N4miQq8bjUQm02TGe
	 fRmYslRPr8eQHBBePWVp1W3Tbv/oBGnATi6kCXW8KvGqE6j4nV+/tgN7tvKOuoSrm6e2c
	 QYQ+dtt3KD+T71w8k8iNDxYC/yTrjP1RyI58eOcTjR/vtxuGcwI9e7nXUA7C8lVLJX9Hh
	 lG7Ri7AQINrTXjNyqlfQpT2G4HQn+0ar8vQ1yZSiYE0yK7OiQCDDGTBdimfZaLET7xlMN
	 X6iRtL9pmEr1u8tRX81pqbmLaPZP3YxmHQs6nm1h9a/ZtvsqgUgB69TYj0I+M5pmVkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405885;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=qmnAe/uuz4meYXOMf+ulwH5PlSUZDHSybFY0xpzNXj0=;
	b=HSoLTnIcE4+HJ12aPggnZgCmgZIuskJ0toyU0Aj9lgZyhipNUcgcJIj7chAW9mV77TU4
	 UoUpbqr4VaJawd/WiyQP1+ocE/uVsj5Eejnvs/btQq2CtKeSysEz/Tc6CeGvviinhdK5a
	 9+yysLGspGO6PsZ7yrW+1rKlG25HZnYftszr7VFq377fdlClGuI8LTDaIz2qW5YnABB7x
	 UZXoZFoA7JZzF51bPnD7CxQryp3J2erynNvJKmMZKuZuxD7xYU7gJkvGajRrK7HF79JjJ
	 kopglk9zUQceoqHloNdcoAVtYdO+jC5IofwV4EZIe/ri2AIefWpsI1ZuiMNlmOETxpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=niB9fWd+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C34606A324
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=niB9fWd+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87181F00A05;
	Wed, 11 Nov 2026 14:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405885;
	bh=qmnAe/uuz4meYXOMf+ulwH5PlSUZDHSybFY0xpzNXj0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=niB9fWd+CfRis/NEFEJTQuBLYQefw49BVxuAvc6jBIe+X7n5DpHr6QvruqtF0IVht
	 QyznWdrFln5hK+K3l+uLCerDKiCQkPpLthJprK17Q75ktsSYQpRr8F7V2VyFR9nHlv
	 hndczoS5WYt8xWRbwkX1ukYR8VBbbvaGR+SN40b7CbeNJMJ196tFuhWBAZVpjH1cSA
	 i77RwejbUW4gXVK54kND9nahnUEbfNbXDsk3XStiTpbphentDf6xCL+lZh1HYnDDQx
	 ZTMk0imjpYiNBea0YUCF8qwi0Kty8r8V9KmE1tuSBrpp5PCU6V1th6XOi8zIfbYLyC
	 fCvdUlUpWRGPQ==
Content-Type: multipart/mixed; boundary="===============7196426098078100193=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <fbcf1e1082338ac37230e03970cd090626e93dd43313f9e404bab690c50f071d@mail.kernel.org>
In-Reply-To: <6d427c6ccc0de0dcfa3e0cb95bd66e9d71c2074b.1794399387.git.memxor@gmail.com>
References: <6d427c6ccc0de0dcfa3e0cb95bd66e9d71c2074b.1794399387.git.memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 18/29] bpf: Allow a callee to leave resources with its caller
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 14:04:44 +0000 (UTC)

--===============7196426098078100193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Allow a callee to leave resources with its caller

TL;DR:
- Possible IRQs left disabled after bpf_throw: unwinder may restore
  callee-created caller-stack IRQ flags in wrong order
- Commit message claims a lock taken in one subprog and dropped in another now
  loads, but it is still rejected
- Possible spurious rejection when a subprog returns a reference while holding
  a lock

>     bpf: Allow a callee to leave resources with its caller
>
>     [ ... ]
>     These programs are rejected even if no throw can find the resource held,
>     although they load today. An example is one subprog that takes a lock and
>     another that drops it, with an assertion elsewhere in the program.
>     [ ... ]
>     A lock at a fixed address, an iterator and saved IRQ flags are always
>     where a site finds them. Subprogs that take and drop these for their
>     callers therefore load if every visit to a throw finds them held, or
>     none does.

The commit message presents "one subprog that takes a lock and another that
drops it" as something this patch makes loadable.  Is that accurate at this
commit?

After take_wlock() returns, prepare_func_exit() sets the lock reference's
frameno to the caller.  When drop_wlock() then calls bpf_spin_unlock(),
process_spin_lock() -> bpf_frame_desc_record_release() still runs the
unchanged check:

	if (ref->frameno != st->curframe) {
		verbose(env, "frame_desc: insn %d releases what another frame holds, which is not supported in a program that throws\n",
			insn);
		return -EINVAL;
	}

With inline verification this compares frameno 0 against curframe 1, and with
independent verification it compares -1 against curframe 0, so the program
is rejected either way.  The same applies to an iterator, IRQ flags or a
dynptr that a callee creates for its caller and a different subprog later
destroys.

The lock_wrappers selftest added in d084772089f5 only seems to load after
0bbb9cb47a2c "bpf: Allow a callee to release its caller's resources", which
replaces this check with foreign_release().  Could the changelog be limited
to what this commit enables (a subprog takes a resource and leaves it with
its caller, which the caller then releases), or point to the follow-up
commit?

> diff --git a/kernel/bpf/frame_desc.c b/kernel/bpf/frame_desc.c
> --- a/kernel/bpf/frame_desc.c
> +++ b/kernel/bpf/frame_desc.c

[ ... ]

> @@ -547,30 +554,37 @@ int bpf_frame_desc_record_acquire(struct bpf_verifier_env *env, int idx, int reg
[ ... ]
> -	return acq < 0 ? acq : ref_set_acq(env, st, idx, acq);
> +	if (acq < 0)
> +		return acq;
> +	/*
> +	 * A stack object is held by the frame that has it in its stack, which
> +	 * its sites find it in: the slot of a callee that created it there
> +	 * would be gone with the callee.
> +	 */
> +	if (owner != st->curframe) {
> +		ref->frameno = owner;
> +		if (!env->res_acqs[acq].elsewhere)
> +			env->res_acqs[acq].elsewhere = env->insn_idx + 1;
> +	}
> +	return ref_set_acq(env, st, idx, acq);
>  }

Can this leave interrupts disabled after a throw?  With the -EXDEV rejection
gone, a callee can now create a stack object in its caller's stack and have
it assigned to the caller (ref->frameno = owner).  The unwinder still seems
to assume that whatever an outer frame holds was acquired before anything an
inner frame holds.

bpf_unwind_release_frames() walks the frames innermost first, and in the
LOCKS phase bpf_unwind_release_frame() restores IRQ flags saved with
interrupts disabled first, and the one saved with interrupts enabled last.
That is only correct if every IRQ save held by frame N-1 is older than every
save held by frame N.  A callee can now save IRQ flags into its caller's
stack after saving its own:

  static __noinline void callee(unsigned long *cf)
  {
          unsigned long mine;

          bpf_local_irq_save(&mine);  /* IRQs on: mine = enabled, held by frame 1 */
          bpf_local_irq_save(cf);     /* IRQs off: *cf = disabled, now held by frame 0 */
          bpf_throw(0);
  }

  SEC("tc") int prog(struct __sk_buff *ctx)
  {
          unsigned long f;

          callee(&f);
          return 0;
  }

callee() has a PTR_TO_STACK argument, so func_is_on_its_own() refuses it and
it is verified inline.  check_kfunc_call() -> mark_stack_slot_irq_flag() ->
bpf_frame_desc_record_acquire() -> acquired_class() finds objframe 0, so
ref->frameno = 0 and elsewhere is set.  At the throw, `mine` is described in
the bpf_throw site of frame 1 and `f` in the call site of frame 0.  Every
visit agrees, so a->slot stays false and the new elsewhere check in
bpf_frame_desc_resolve() never fires.  For bpf_throw, check_resource_leak()
passes check_lock = !bpf_jit_supports_exception_cleanup(), which is false on
x86-64 and arm64, and check_reference_leak() ignores REF_TYPE_IRQ, so the
throw is not rejected.

At runtime, in bpf_unwind_release_desc():

  if (locks && late != (res->kind == BPF_RESOURCE_IRQ_FLAG &&
                        !arch_irqs_disabled_flags(*(unsigned long *)handle)))
          continue;
  bpf_unwind_release(res, handle);

Frame 1 restores `mine` in pass 1, which turns IRQs on.  Frame 0 then
restores `f` in pass 0, with local_irq_restore(disabled), which turns IRQs
off again.  bpf_throw_unwind() calls the exception callback without a
further fix-up, so the tc program returns to the networking stack with
interrupts disabled.  The correct order is `f` first, then `mine`.
bpf_res_spin_lock_irqsave(lock, cf) after an IRQ save on the callee's own
stack hits the same problem.

The same assumption is behind resource_goes_first() ("A stack object may use
a referenced object the frame holds as well: it goes first").  A callee that
holds a file reference and creates a file dynptr reader (or an iterator built
on a reference) in its caller's stack has the reference released in its own
frame's OBJS walk before frame 0 frees the reader.

The new selftests only cover a callee that creates an iterator for its
caller (throw_iter_from_callee, iter_from_callee), and no commit later in the
series seems to change kernel/bpf/unwind.c or this ownership rule.  Should a
stack object created for a caller be rejected while the creating frame holds
anything of the LOCKS phase, or should the unwinder order releases across
frames by acquisition?

[ ... ]

> @@ -748,71 +762,89 @@ int bpf_frame_desc_record_section(struct bpf_verifier_env *env, u8 kind, s8 delt
[ ... ]
>  int bpf_frame_desc_record_return(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
>  				 int idx, int callsite, const struct bpf_reg_state *r0)
>  {
[ ... ]
>  	ref = idx < 0 ? NULL : &st->refs[idx];
> +	if (ref && !ref->res)
> +		ref = NULL;
> +	if (ref && ref->type == REF_TYPE_PTR && ref->id &&
> +	    !(env->res_acqs[ref->acq - 1].flags & BPF_RES_F_ARG) &&
> +	    reg_ref_off(r0, ref->id, &adj)) {
> +		acq = acq_add(env, callsite, ref->res - 1, BPF_REG_0, 0, adj, 0);
> +		return acq < 0 ? acq : ref_set_acq(env, st, idx, acq);
>  	}
> +	if (r0->type != SCALAR_VALUE || !tnum_equals_const(r0->var_off, 0))
> +		env->insn_aux_data[callsite].res_none = true;

Can a subprog that returns a reference in R0 while also holding a lock still
have that R0 reference kept in a hidden slot?

bpf_frame_desc_record_return() is now called once for each resource handed to
the caller.  The call for the R0 reference takes the acq_add() branch above,
but the call for the lock (not REF_TYPE_PTR) falls through to the res_none
test.  R0 is a non-NULL pointer on that visit, so res_none is set on the
callsite even though R0 carries the reference that the callsite's R0
acquisition records.

If a caller site later needs a slot for that acquisition,
bpf_frame_desc_resolve() calls acquires_sometimes(), which returns
aux->res_none, and the program is rejected with "insn %d acquires a resource
on some paths only, or one of a type that cannot be released", even though
the call acquires in R0 on every visit.  For example, since
bpf_list_pop_front() is KF_ACQUIRE | KF_SPINLOCK_SAFE:

    static __noinline struct node *pop_locked(void)
    {
        bpf_spin_lock(&glock);
        n = bpf_list_pop_front(&ghead);
        return n ? container_of(n, ...) : NULL;  /* returns holding glock */
    }
    ...
    n = pop_locked();
    bpf_spin_unlock(&glock);
    if (n && cond) bpf_obj_drop(n);
    bpf_throw(0);   /* visits disagree on n: its acquisition needs a slot */

The same caller loads if pop_locked() unlocks before it returns.  The
comment says "A reference that R0 carries is acquired by the call, like the
reference a kfunc returns", and a kfunc's R0 acquisition can have a slot.

This is a spurious rejection rather than a safety problem, but would setting
res_none only when no handed reference is carried in R0 avoid it?  The code
is unchanged at the end of the series.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43027088527
--===============7196426098078100193==--
