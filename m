Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793151553;
	b=Rz69cfel1tgDE+wNE5WBW6abSs0vzyqeTcZx6Bna8jt8uzGYPCWzQhXRLyJp0F9UsBOs
	 7KfOyRC6A/YGTcIwP/sawieKC+dv4S4g2oSBWiV5v+bTrveed34qAzExxrMjtu4JImvoE
	 HtHH/0aecSFGQh2XBm1peStd4WMG759NWvELbP3fZLQQiB+eD0QrOOr6wrLubRNJi9wHA
	 oGlm+rjexzuxeC2NOGFELaE7oIQYvGNAIvtFhPJIRkbhrt/Ld+GgVb2gGGLQFEBT1NJQf
	 TZJ2EFx6dD6arEUP4/i9dgUQK6LJuokg8cemk12T4xuHIQwpDljULdV7taqyXQsGuiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793151553;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=PLmIBNYj7yUqLn8gc2g6C2SqsdmwreLoNUxIVKIuE20=;
	b=TloJSFKrWdRPgOWUmii2cVltAzFtJ+nLPCSAoP2VfNJv73iCj+Ldkt1MUn0rPi5Dbtsp
	 68ehcAkpuU0L6wpjaeEUvzxSFdoQC02mB07CiGrbiazUb1w9/lT19DlpgydRD+7U/JMZ8
	 qArng3B9aZ55Tz+Hx11S5H/TXiFn5krevm3LcbDEr+BtYMRtL2Dx0aaO/C5x6Wp89+soG
	 5KRVCare47gVWUHGTTRF4oXNdBXtF/Uva3SaNxLMZiL8hxUM6vfyXSBGctqHuBCemc+v8
	 YKA4eo+WWTcuFfICOIPY0P/Yiv6tM9ckpnG6OpUKs8QYkenBC1yn0fGok50zr+NOE2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ed8VBWQx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1E1606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 01:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ed8VBWQx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE6D1F01825;
	Wed, 28 Oct 2026 01:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793151553;
	bh=PLmIBNYj7yUqLn8gc2g6C2SqsdmwreLoNUxIVKIuE20=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ed8VBWQxsfYP5f2HGKHFPp1l5oTqoDgG2zgq+JbDwJnOL2iQjDQGY8UM8Xkd27R2B
	 ehOkMG/io3aeCTcKvF0sYt6sQNQj+hfDyyjREydvkAr22lp+iQjwIAyFJUP7kAdRwB
	 giftYntme8vhlZeQR/nw+zAi17Iul+TPoyXEuUlqSYF6HX4wu74FFTle4MPnq1pRt5
	 H/1B8z2rtS2fN1Kl7mSx0re2Hi9vTMlKQO3kU80Jr6Hw1378or5pMNdjb59UtdHonf
	 psISKSPaKGodzF2qo/qfJP2J3Wne8EQjviotfqSwDgBSZmRp2pQIQPhIMIHDxQmHoZ
	 0KXgGDTrlcydQ==
Content-Type: multipart/mixed; boundary="===============3081443181645041951=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <64d65cba8dd38be485a909c5b03c403ba78bfb67caf179deab641e22208908a8@mail.kernel.org>
In-Reply-To: <cc848a0c0e4839fe34514b89561884c082650881.1793147364.git.memxor@gmail.com>
References: <cc848a0c0e4839fe34514b89561884c082650881.1793147364.git.memxor@gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 03/11] bpf: Let a callback unwind into the pad of its helper
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 28 Oct 2026 01:39:12 +0000 (UTC)

--===============3081443181645041951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Let a callback unwind into the pad of its helper

TL;DR:
- Tracing (ftrace, kretprobe, fexit) may redirect a pad helper's return
  address, so unwind could fall through, possibly causing use-after-free or
  bad r0; not yet reachable
- Stale comment in backtrack.c (nit)

> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
> index 43d5740034c0..ce171be5e754 100644
> --- a/kernel/bpf/backtrack.c
> +++ b/kernel/bpf/backtrack.c

[ ... ]

> @@ -562,8 +567,16 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>  			from_subprog_call = subseq_idx - 1 >= 0 &&
>  					    (bpf_pseudo_call(&env->prog->insnsi[subseq_idx - 1]) ||
>  					     bpf_is_callx(&env->prog->insnsi[subseq_idx - 1]));
> +			/*
> +			 * unwind_exit of a callback goes back to the call of the
> +			 * helper, which passes R0 on to the pad after it: R0 is
> +			 * the callback's, as it is the subprog's after a call.
> +			 */
> +			cb_unwinds = !from_subprog_call && bpf_is_unwind_exit(insn) &&
> +				     subseq_idx >= 0 &&
> +				     bpf_is_sync_callback_calling_insn(&env->prog->insnsi[subseq_idx]);
>
> -			r0_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_0);
> +			r0_precise = (from_subprog_call || cb_unwinds) && bt_is_reg_set(bt, BPF_REG_0);
>  			r2_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_2);

This isn't a bug, but the comment at the top of the BPF_EXIT case says that
the precision of the return registers is never propagated for an exit from
a callback:

    * case, we need to propagate the precision of the
    * return registers, if necessary. In the latter we
    * never do that.

With this change, unwind_exit of a callback sets cb_unwinds, and
r0_precise = (from_subprog_call || cb_unwinds) && bt_is_reg_set(bt, BPF_REG_0)
does propagate r0 to the callback frame.

The new comment above cb_unwinds describes this, but the old sentence is
still there, so the same case has two comments that disagree.

Should the old comment say that the return registers of a callback are
dropped unless the callback left with unwind_exit?

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5601d2056218..ac9dbe082181 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11397,6 +11402,55 @@ static int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog)

[ ... ]

> +/*
> + * A sync callback is called by a helper or a kfunc, a C frame between the
> + * callback and the BPF code that called it. unwind_exit of the callback returns
> + * to the pad of its caller when there is one, and a helper or a kfunc that
> + * calls a callback has one where BPF_HAS_CB_PADS and insn_has_cb_pad(): it
> + * calls the callback with bpf_call_cb(), drops what it holds when the callback
> + * unwinds and leaves to the pad of its own caller with the r0 of the callback.
> + * So a call with such a callback that can unwind is a call of something that
> + * can unwind, and unwind_goto has to follow it.
> + */
> +static int check_cb_unwind(struct bpf_verifier_env *env, struct bpf_insn *insn,
> +			   int insn_idx, int subprog)
> +{
> +	if (!env->subprog_info[subprog].can_unwind)
> +		return 0;
> +	if (!BPF_HAS_CB_PADS || !insn_has_cb_pad(insn)) {
> +		verbose(env, "callback cannot unwind\n");
> +		return -EINVAL;
> +	}

Can a callback that unwinds through one of these helpers end up on the
fall-through path of the call instead of at the pad?

check_cb_unwind() accepts the unwind based on BPF_HAS_CB_PADS and
insn_has_cb_pad(), which are static properties. At run time the pad is only
reached if the return address slot of the helper still holds the address in
the BPF program. bpf_unwind_leave() does this:

    unsigned long *slot = (unsigned long *)__builtin_dwarf_cfa() - 1;
    unsigned long to = bpf_unwind_target(*slot);

    WARN_ON_ONCE(to == *slot);
    *slot = to;

bpf_unwind_target() looks up *slot in the BPF and kernel extables, and
several kinds of tracing replace or move that return address:

  - function_graph: prepare_ftrace_return() does *parent = return_hooker
  - kretprobe/rethook and fprobe exit handlers (kprobe.multi return, session)
  - a BPF fexit/fmod_ret trampoline: with BPF_TRAMP_F_CALL_ORIG it calls
    orig_call from the trampoline, so the helper returns into the trampoline

None of the helpers that get a pad later in the series is protected against
this. bpf_loop, bpf_for_each_map_elem and bpf_find_vma become plain noinline
functions through BPF_CALL_x, and bpf_for_each_array_elem, bpf_rbtree_add_impl
and the others are ordinary traceable functions.  None of them is in
btf_id_deny and none is notrace.

If the slot was redirected, bpf_unwind_target() finds no entry and returns the
address unchanged.  WARN_ON_ONCE() fires, the helper does a normal return,
and the tracer then returns to the instruction after the BPF call.

That instruction is unwind_goto, for which the arch backends emit no branch.
Execution continues on the fall-through path, which the verifier modelled as
a normal return of the helper.

On that path r0 holds what the callback unwound with, and the helper has
already done its pad-side work:

  - bpf_loop: the verifier thinks r0 is the scalar returned by bpf_loop(),
    but it can be a kernel pointer, which could be stored to a map, or a
    referenced pointer whose reference is never released.

  - bpf_rbtree_add: on the unwind path the pad has already freed the node
    with __bpf_obj_drop_impl().  On the fall-through path the verifier ran
    ref_convert_owning_non_owning() and treats the node as a live non-owning
    reference, so the program can read and write freed memory.

bpf_check_attach_target() already refuses anything but fentry on a subprog
that can unwind ("unwind_exit would return to the trampoline that called the
target"). Is there an equivalent for the kernel helpers with pads?  The
verifier has no say over function_graph or kretprobes at all.

This commit only adds the gate, since helper_has_cb_pad() and
kfunc_has_cb_pad() return false for now.  The path is opened later in the
series by:

  4e61c40fe5c0 ("bpf: Let the callback of bpf_loop unwind")
  7a687425732b ("bpf: Let the callback of bpf_for_each_map_elem unwind")
  59e3a600668d ("bpf: Let the callback of bpf_find_vma unwind")
  bee41eec3c39 ("bpf: Let the callback of bpf_user_ringbuf_drain unwind")
  ecd4c98df2ee ("bpf: Let the comparator of bpf_rbtree_add unwind")

No commit up to 5646f059f1bb adds a fix: no notrace or NOKPROBE marking, no
attach restriction, and no return_to_handler or trampoline handling in
bpf_unwind_target().

Would it work to make the pad helpers untraceable (notrace plus NOKPROBE, and
deny them in btf_id_deny for fexit/fmod_ret), or to have bpf_unwind_leave()
resolve the real return address through the ftrace/rethook shadow stacks?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40612543702
--===============3081443181645041951==--
