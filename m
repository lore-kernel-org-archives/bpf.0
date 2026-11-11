Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405893;
	b=5bt3zNOBEHXCiUyam4kVvmJOGiPdYTMpYlSGaIR35ja6/zfYwsZtxfRZbFfpGgL4pUhZ
	 TWseLydC1vTEPQDRAMrT9xbijvF9BXkC/5B8DJZDi7+qYP00/ok+sOu8ck+iaagTxpf78
	 WGMsskdI3q9vT3QUmdde75I6apo/0l+hMqWUQ/JtSmF6g5eCSwn7pl/fhWyjusIKaX3U5
	 nvz/My0GwTnQySKs2IMnT4QNV4ijopOZ3KOH9FBoielKqTkFzS39NkOPnsQXlOAAqauZy
	 UZuawtQsOoRR+Kc12Uj/Wv9VLmjO6meyJv5HbCTHJdUqyc89Jpn++6RSBghOKzfJ59w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405893;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=jGCIzGKf6N5BKhT0aD7clCQx8nPb+zZuOS4EUZefGGo=;
	b=H7OEmRrtaINo5aCHiOY/rqXYu5n/jFsk72c48gog3Xu6Keytc3TlrbQJLBjEhAPQSlEM
	 kwM5HoTPWuv+DaEUXhcLk+Y0J/V7VXoMiM/ZTpXLtLb43Q0yZuiN1Nesr2xrgrMvSokhd
	 YdHjp5/IZ+IZw2V8wL9HUarMMNUE8NDmTw1DEgnKVjUR+cQSNo30PNquSfkyKgH0jHJDj
	 ih9xkrPe3Laz5Kl0/qKIoJ+gyApAzisbc065eR+l8njBuZSb6TwuBtVg+cdeJ30rMoFI/
	 DuoFoXEVdnUKYR78+wjjFHoER5psDeDBdwmkJ8CKIaNCJOMSZKZelJK8FU87xd1UIZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mwO7SrwY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D1D606A331
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mwO7SrwY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE281F00A06;
	Wed, 11 Nov 2026 14:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405893;
	bh=jGCIzGKf6N5BKhT0aD7clCQx8nPb+zZuOS4EUZefGGo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mwO7SrwYYtivYzDFs2NhF6fJAWZCi7qhmseHMMhdufQtmrhuiUzgx24/A9jZzZzdL
	 bNIJ2SpRWCnqd1YokFKCuQnZzJx0Kold2WREszm31wfAVVOred5N94Aw8P5MF6U7g6
	 N1IBPGV72tUySPfchxv711qR4KYYQHd1vcDIl/2u1JYuFntrT05s6WVsAzqmJKvVeN
	 Mh0IxL22yHtKlkg8B5L3ReWvr4j+cuUBYPHh+abHwTg3pB9JWAYXE6y8dzJBrNrTBt
	 WMmp0yB7WIpiZWXOn2oXS+WRxAu/HG9MGyABXyp1ERHveuiYjnv6DQ1T53ZkBeEwoO
	 KnAYJcjCOIilQ==
Content-Type: multipart/mixed; boundary="===============9085444904980240592=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <f83bc7e57e703e2bc82d01d1f0c8abeaf70c38f41d4b6241e77efa5cf24bea3e@mail.kernel.org>
In-Reply-To: <0b8d0a69ecb9f74ed3e3645bc7dccbc022a83cc2.1794399387.git.memxor@gmail.com>
References: <0b8d0a69ecb9f74ed3e3645bc7dccbc022a83cc2.1794399387.git.memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 13/29] bpf: Track held resources in hidden stack slots
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 14:04:52 +0000 (UTC)

--===============9085444904980240592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Track held resources in hidden stack slots

TL;DR:
- Two aliasing references may be double-released by bpf_throw() unwinding
  (possible refcount underflow/use-after-free)
- Programs using callx or cross-frame resources may fail to load, breaking
  bisection
- Comment and message nits

> diff --git a/kernel/bpf/frame_desc.c b/kernel/bpf/frame_desc.c
> new file mode 100644
> index 000000000000..b0db3feeb9b0
> --- /dev/null
> +++ b/kernel/bpf/frame_desc.c

[ ... ]

> +int bpf_frame_desc_record_release(struct bpf_verifier_env *env, int idx)
> +{

[ ... ]

> +	for (i = 0; i < cnt; i++) {
> +		r = &env->res_rels[i];
> +		if (r->insn != insn || r->reg != regno)
> +			continue;
> +		/* the argument is taken the same way whatever it releases */
> +		if (r->flags != flags || r->adj != adj) {
> +			verbose(env, "frame_desc: insn %d takes the handle of what it releases differently on different paths\n",
> +				insn);
> +			return -EINVAL;
> +		}
> +		if (r->acq == ref->acq - 1)
> +			return 0;
> +	}

Can this lead to a double release of an object that has two references?

bpf_frame_desc_record_release() links a releasing insn only to the
acquisitions it was seen releasing on some verified path, and
emit_release() compares the handle against those slots in recording order
and clears only the first slot that matches.  Its comment says this is
enough because "two references to one object have equal handles in a slot
each".

That does not hold when one frame holds two references to the same object
from two different acquiring insns, A and B.  Two acquire kfunc calls on
the same kernel object do this, and so does bpf_obj_new() followed by
bpf_refcount_acquire().  Both slots then hold the same pointer.

Suppose one release insn Y releases A on one path and B on another, so Y
has rel entries for both.  At runtime Y can clear A's slot when the
verifier's path released B, because the handles are equal.  If the
remaining reference is then released by an insn that was verified only on
paths releasing A, that insn's rel list contains only A.  It compares A's
already-cleared slot, finds no match and leaves B's slot holding the
pointer.

After that nothing the verifier tracks is still held, but B's hidden slot
is non-NULL.  bpf_unwind_release_frame() releases every non-NULL slot:

    if (!handle || ...) continue;
    ...
    bpf_unwind_release(res, handle);

so a later bpf_throw() runs the destructor (put_task_struct(),
bpf_obj_drop_impl(), ...) again for an object whose references were
already dropped.  That looks like a refcount underflow and a use-after-free.

The verifier appears to accept such a program: the two paths keep
different reference ids at Y, so they are not pruned against each other,
and a branch whose condition is already known lets each path release the
remaining reference at a different insn.

Would it work for every release insn to compare all acquisitions of the
same class in the frame, to reject a release insn that may release two
acquisitions whose handles can alias, or to clear every matching slot
(which turns the double release into a leak)?

The later commit 026679e2eda5 ("Describe held resources at throw sites")
keeps hidden slots for resources whose location differs between visits of
a site, and the unwinder still releases every non-NULL hidden slot, so this
does not look fixed in the rest of the series.

[ ... ]

> +int bpf_frame_desc_emit(struct bpf_verifier_env *env)
> +{

[ ... ]

> +	for (i = 0; i < n && !ret; i = k) {
> +		u32 idx = items[i].idx;
> +
> +		for (k = i; k < n && items[k].idx == idx; k++)
> +			;
> +		if (verifier_bug_if(idx >= len || env->prog->insnsi[idx].code != (BPF_JMP | BPF_CALL),
> +				    env, "resource kept at insn %d, not a call", idx)) {
> +			ret = -EFAULT;
> +			break;
> +		}

Can a callx reach this check?

bpf_frame_desc_record_return() makes the call site the acquisition of a
reference that a subprog returns in R0:

    acq = acq_add(env, callsite, ref->res - 1, BPF_REG_0, 0, adj, 0);

The call site can be a callx.  check_func_callx() ->
check_func_callx_one() -> check_static_func_call() -> setup_func_entry()
records the callx insn as callee->callsite, and prepare_func_exit() passes
that callsite to bpf_frame_desc_record_return().  For a function verified
on its own, bpf_flow_return() passes call_idx, which is also the callx.
Nothing in this patch rejects callx when env->describe_frames is set, and a
static subprog returning an acquired reference is legal because
check_reference_leak() returns 0 in any frame other than frame 0.

A callx has code BPF_JMP | BPF_CALL | BPF_X (see bpf_is_callx()), which is
not equal to (BPF_JMP | BPF_CALL), so verifier_bug_if() fires and the load
fails with -EFAULT.  With CONFIG_DEBUG_KERNEL the BPF_WARN_ONCE() also
produces a WARN, which panics with panic_on_warn.

The trigger is a program on x86-64 or arm64, where
bpf_jit_supports_exception_cleanup() and bpf_jit_supports_callx() both
hold.  Some subprog in it calls bpf_throw(), so describe_frames is set, and
another place makes a callx through a function pointer to a static subprog
that returns, say, the result of bpf_task_acquire() or bpf_obj_new().  The
throw does not need to be reached with anything held.  Such a program
loaded before this patch and now fails with "verifier bug: resource kept
at insn N, not a call".

emit_items() itself handles the callx correctly, since it only emits
after-insns for an R0 acquisition, so only this check is too narrow.

This is fixed later in the series by acd08268bd12 ("bpf: Support callx
when a callee releases resources"), which also accepts
bpf_is_callx(&env->prog->insnsi[idx]) here.  This commit still breaks
bisection for such programs.

> +		after = emit_items(env, &items[i], k - i, buf, &before);
> +		/* the call of a subprog in front of it does not move with the call */
> +		ret = bpf_adj_moved_insn(&buf[before], before);
> +		if (ret)
> +			break;
> +		/*
> +		 * A callee that unwound returns right after the call and goes where
> +		 * the unwind_goto says: nothing may come between the two.
> +		 */
> +		if (after && idx + 1 < len && bpf_is_unwind_goto(&env->prog->insnsi[idx + 1])) {
> +			verbose(env, "frame_desc: the call at insn %d acquires a resource and may unwind, which is not supported in a program that throws\n",
> +				idx);

Does this message name the insn the user wrote?

idx is an index in the current image.  By this point
bpf_insert_loop_guards() (and append_budget_exit()) may already have
inserted insns, such as may_goto guards of 10-14 insns each plus budget
exits, so idx can be past the insn of the loaded program.  The other
frame_desc messages in this file print main-pass indices (a->insn,
env->insn_idx), which equal insn_aux_data[].orig_idx, and
bpf_patch_list_insert() also translates with
env->insn_aux_data[off].orig_idx for the same reason.

Should this use env->insn_aux_data[idx].orig_idx so that the -EINVAL
rejection points at the right call?  The end of the series still prints idx.

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index cf3cfc734ed4..4d85a42a18d5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -812,6 +813,10 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
>  	mark_dynptr_stack_regs(env, &bpf_stack_slot(state, spi)->spilled_ptr,
>  			       &bpf_stack_slot(state, spi - 1)->spilled_ptr, type, parent_id);
>  
> +	/* a referenced dynptr is a stack object the unwinder discards at its address */
> +	if (dynptr->type == BPF_DYNPTR_TYPE_INVALID && dynptr_type_referenced(type))
> +		return bpf_frame_desc_record_acquire(env, env->cur_state->acquired_refs - 1,
> +						     reg - cur_regs(env), false, false);
>  	return 0;
>  }

This isn't a bug, but is this comment accurate?  It says the unwinder
discards the referenced dynptr "at its address", while the code does
something else.

For a STACK_DYNPTR object, acquired_class() sets BPF_RES_F_DEREF and
obj_off = spi_off(spi).  emit_acquire_after() then emits
BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_FP, a->obj_off) and stores that
value in the hidden slot.  That value is the first word of the dynptr, the
ringbuf record or the file reader, not the dynptr's stack address.
unwind.c then calls bpf_ringbuf_discard_proto.func((u64)(long)handle, ...)
on that handle, and the dynptr may even be overwritten later without
affecting the slot.

The comment looks copied from the iterator and IRQ-flag sites, where "at
its address, which the call takes" is accurate because the slot holds the
object's address.  acquired_class() describes the dynptr case correctly
("The handle of a dynptr is the record or the reader, the first word of the
dynptr at @obj_off").  Could this comment say that the slot holds the
record or reader loaded from the dynptr after the call?

[ ... ]

> @@ -12702,9 +12818,26 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>  	invalidate_stack_slices(env, callee->frameno, INT_MIN, 0);
>  
>  	/* What the frame holds when it returns is the caller's to release. */
> -	for (i = 0; i < state->acquired_refs; i++)
> -		if (state->refs[i].frameno == callee->frameno)
> -			state->refs[i].frameno = caller->frameno;
> +	err = bpf_frame_desc_record_exit(env);
> +	if (err)
> +		return err;

Do programs that load at the parent commit get rejected here even when no
bpf_throw() can be reached while the resource is held?

On x86-64 with CONFIG_UNWINDER_ORC and on arm64,
bpf_jit_supports_exception_cleanup() is true, so bpf_check() sets
env->describe_frames for any program where some subprog has might_throw,
which includes any program using bpf_assert() anywhere.  The new calls then
reject cross-frame resources wherever they occur, not only at a throw:

- bpf_frame_desc_record_exit(), called from prepare_func_exit() and
  exit_func_on_its_own(), fails with "frame_desc: a subprog returns
  holding what R0 does not carry ..." for any ref owned by the returning
  frame that is not a single REF_TYPE_PTR carried in R0 (a bpf_spin_lock or
  res lock, saved IRQ flags, an iterator).  It also fails with "returns in
  other sections" for a subprog that enters RCU or preempt-disabled
  sections for its caller.

- bpf_frame_desc_record_release(), reached from process_spin_lock(),
  unmark_stack_slot_irq_flag() and release_reference_nomark(), fails with
  "releases what another frame holds" when ref->frameno != st->curframe.

- bpf_frame_desc_record_acquire(), reached from mark_stack_slots_iter(),
  mark_stack_slot_irq_flag() and mark_stack_slots_dynptr(), returns -EXDEV
  ("creates an object in the stack of another frame") for an iterator, IRQ
  flags or a ringbuf/file dynptr created through a pointer to the caller's
  stack.

For example, this loads before the patch and is rejected after it:

  static __noinline void lock_it(struct val *v) { bpf_spin_lock(&v->lock); }
  static __noinline void unlock_it(struct val *v) { bpf_spin_unlock(&v->lock); }
  SEC("tc") int prog(struct __sk_buff *ctx) {
          struct val *v = bpf_map_lookup_elem(&m, &(int){0});
          if (!v) return 0;
          lock_it(v); v->cnt++; unlock_it(v);
          bpf_assert(ctx->len > 0);
          return 0;
  }

In lock_it(), process_spin_lock() -> bpf_frame_desc_record_acquire() gives
the REF_TYPE_LOCK entry a non-zero ->res with frameno 1.  At its BPF_EXIT,
bpf_frame_desc_record_exit() returns -EINVAL because the type is not
REF_TYPE_PTR.  The throw is never reached with the lock held, and the
verifier guide says a BPF_EXIT from a static subprog with a lock held is
allowed.

The commit message lists these restrictions and says "Later patches lift
most of the first five".  The ringbuf/file dynptr case is not in that list.
The fixes come later in the series: 99e07a877ad7 ("bpf: Allow a callee to
leave resources with its caller") and 0bbb9cb47a2c ("bpf: Allow a callee to
release its caller's resources").  99e07a877ad7 itself says "These programs
are rejected even if no throw can find the resource held, although they
load today."  This leaves a bisection window in which existing programs
that use bpf_assert() or bpf_throw() fail to load on x86-64 and arm64.

Could the restriction apply only when a throw is reached with the resource
held, or could the series be reordered so that no intermediate commit
rejects programs that load today?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43027088527
--===============9085444904980240592==--
