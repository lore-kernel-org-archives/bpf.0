Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793150739;
	b=QPmMGDfjth8Xwq8vk1IQ9qrm+pXEna+IzMJfSjduqkiUAHw/Ms7mQ1mgi2FoenGo976M
	 qiRyulR90oIej+kYEOsV/C14VcKAYZ4NCaCI2TMP7o7SqdlVhO/Xt3HnYi8aQkIsMW+qR
	 TnoHVsjvTUrInOnleAIKcGPQ+KES6i0J5PYn5oU1mWOZ+rFCwL0t6dWhEtqFoFRtFREav
	 dXeSdsfwclKFlBT3NgrA22ms97GZFFaubyyrzpfPJYxsSTY5bNOfW+vyce/d5ZtGC+JxV
	 H9ZsHGvXhEEKdSuR+U2NLQ+OpzCVwf4aasFfHUg+CorOR/qKvHCMmwFVp+clBR23f/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150739;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=RBgZfqDB7GYp9PFiR5euDUE1UAd/kzXQrzqXLg1XATk=;
	b=yIY/y1bL+OLguq/D1sy/QgoRT4mRUgudl5EQDyDarhl9Q58D0QJETnza8gyq0lmM6srv
	 fQhSV2gkB55GVaAqsTN/ozqonW4DPcZRvgXUDdigcdv3yTLR/uxp7o++U/8hJpyiiJlUW
	 MTYXDPlqNxzZKi1nhDg9pb6XfeP+pNSte2xprz8kLJZcPt5YBzQWJiOFIYuidg/fHB1Eq
	 51sfQwNSvRKUUC3sD/RxSOr2ke7dC4QkoTA513hlEYBif343TFvSNzMmp225MdrYYexE9
	 Qb0kD7jpOxv5CDHP7B0HP4sHeYK/VSmRdcq/8ruvbn6q9XfIjjyjoXS1OMGhuG/rJxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=btiiZ3oG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4A2606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 01:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=btiiZ3oG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3759B1F01825;
	Wed, 28 Oct 2026 01:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793150738;
	bh=RBgZfqDB7GYp9PFiR5euDUE1UAd/kzXQrzqXLg1XATk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=btiiZ3oGkAtLQ4LOagpU9vF3am+zV9NOq7Bx/NLRKUxSXIZmGJEUArF2Q8V2MdGcp
	 +5g6FFvMSyBgV3A4TfwnfYd2EySGfBvb6xyLzxQI/2jcUy8t0hd46tMP6Erottp3dy
	 /CGWaVsiF76uphtGaAu2GoW64vOWK2KdvAh1jfRiAtYNHOd/c4H52akodxUaY577/m
	 Nz2qhbFApJJfxc39EGThJJPbZ2IEb2KXocts5sToiZ4Ofsfl7gkUVN394H9ElakX/4
	 6pgf7/sK1GReFohxGdqj2GlyJa1CP0EZ3BbuJoPBPrQdo/BfJEVBbsBUPgmqNZgl36
	 /Zr1vf7sQ4fzg==
Content-Type: multipart/mixed; boundary="===============8226136630849798558=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <89d5a613d296bb9e00c60395d44a45f8b39da90068939a82f8b27ce08557c584@mail.kernel.org>
In-Reply-To: <d81d996f09e0fd0b07816dcd0541f39c0f451a23.1793147364.git.memxor@gmail.com>
References: <d81d996f09e0fd0b07816dcd0541f39c0f451a23.1793147364.git.memxor@gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 09/11] bpf: Let the comparator of bpf_rbtree_add unwind
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 28 Oct 2026 01:25:38 +0000 (UTC)

--===============8226136630849798558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Let the comparator of bpf_rbtree_add unwind

TL;DR:
- bpf_rbtree_add() unwind pad may be skipped under fexit/kretprobe/graph
  tracing, leaving a freed node usable by the program
- unwound path may leave node->owner poisoned, and may run kptr destructors in
  NMI-unsafe contexts

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 648abe1ba63a..f8708b7181d7 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -2796,6 +2801,15 @@ static int __bpf_rbtree_add(struct bpf_rb_root *root,
>  	rb_insert_color_cached(n, (struct rb_root_cached *)root, leftmost);
>  	WRITE_ONCE(node->owner, root);
>  	return 0;
> +
> +unwound:
> +	/*
> +	 * The comparator left with unwind_exit. The node is not in the tree, and
> +	 * the caller has let go of it: drop it, as the error path above does.
> +	 */
> +	__bpf_obj_drop_impl((void *)n - off, rec, false);

Does this path leave node->owner set to BPF_PTR_POISON?  The function claims
the node before the loop:

	if (cmpxchg(&node->owner, NULL, BPF_PTR_POISON)) {

The normal exit replaces that with WRITE_ONCE(node->owner, root), but the
unwound exit never clears the claim.  For a non-refcounted node the drop
frees it, so that does not matter.

For a refcounted node with another live reference, __bpf_obj_drop_impl() only
drops the count and the object lives on with owner still set to
BPF_PTR_POISON.  Nothing resets it later, since bpf_obj_free_fields() does
nothing for BPF_RB_NODE and only bpf_rbtree_remove() or a successful add
writes owner.

The other reference can come from m = bpf_refcount_acquire(n) before the
add, or from the comparator calling bpf_refcount_acquire() on its argument
(the kfunc is KF_SPINLOCK_SAFE).  The verifier keeps that other reference as
owning after the unwind, but every later bpf_rbtree_add() of the object
fails at the cmpxchg, drops the caller's reference and returns -EINVAL.

The comment says "drop it, as the error path above does", but the error path
above never took the claim and this path did.  Would a
WRITE_ONCE(node->owner, NULL) before the __bpf_obj_drop_impl() call be
needed here?

Can this drop also run in a context where the verifier refuses
bpf_obj_drop()?  check_kfunc_call() rejects bpf_obj_drop() and
bpf_percpu_obj_drop() when btf_record_has_nmi_unsafe_fields() is true for
tracing program types, per commit 94c8d1c21be4 ("bpf: Reject bpf_obj_drop()
from tracing progs").  Every rbtree node type is covered, because
btf_field_is_nmi_safe() returns false for BPF_RB_NODE.

Before this patch, the only drop in bpf_rbtree_add() was the error path for a
node already in a collection, and that collection holds a reference of its
own.  Now a comparator that ends in unwind_exit makes the kfunc call
__bpf_obj_drop_impl() every time, and for a non-refcounted node that is the
last reference, so bpf_obj_free_fields() runs inline.

Nothing restricts this by program type: BPF_PROG_TYPE_TRACING gets
generic_kfunc_set, check_map_prog_compatibility() refuses BPF_SPIN_LOCK only
for is_tracing_prog_type() (which does not include BPF_PROG_TYPE_TRACING),
and neither check_cb_unwind() nor the new unwound branch in
check_kfunc_call() tests btf_record_has_nmi_unsafe_fields() or the program
type.

For example, a non-sleepable tp_btf or fentry program attached somewhere
NMI-reachable could allocate:

	struct { struct bpf_rb_node node; struct task_struct __kptr *t; }

store an acquired task in t, take the lock and call bpf_rbtree_add() with a
comparator that unwinds.  The verifier accepts this although it refuses
bpf_obj_drop() on the same object, and the pad then runs the task kptr
destructor (put_task_struct()) from that context.

Should the same btf_record_has_nmi_unsafe_fields() and program type check be
applied to a bpf_rbtree_add() whose comparator can unwind, for example in
check_cb_unwind() or in the unwound branch of check_kfunc_call()?

> +	bpf_unwind_leave();
> +	return r0;
>  }

Can this pad rely on the slot at the frame address of bpf_rbtree_add() or
bpf_rbtree_add_impl() still holding the BPF caller's return address?  Both
are ordinary traceable functions: helpers.o is built with ftrace flags and
btf_id_deny does not list them.

Several tracers that hook the return rewrite that slot:

  - an fexit, fmod_ret or fsession trampoline, which uses
    BPF_TRAMP_F_CALL_ORIG and calls orig_call + X86_PATCH_SIZE, so the body
    returns into the trampoline
  - a kretprobe or fprobe exit (the rethook trampoline)
  - the function_graph tracer, where ftrace_graph_func() sets
    *parent = return_to_handler

In each case bpf_unwind_leave() reads that address.  bpf_unwind_target()
finds no BPF extable entry for it and no EX_TYPE_BPF kernel entry, and
returns the address unchanged.  WARN_ON_ONCE(to == *slot) fires (a panic with
panic_on_warn), and the kfunc returns r0 the normal way.

The tracer then sends control to the BPF program's normal return address,
and the JIT emits nothing for unwind_goto, so the program carries on along
the path the verifier checked as "comparator returned".  On that path
ref_convert_owning_non_owning() has made the node a non-owning reference
that is valid in the tree until unlock, but the kfunc has already called
__bpf_obj_drop_impl() on it:

	__bpf_obj_drop_impl((void *)n - off, rec, false);
	bpf_unwind_leave();
	return r0;

Can the program then read and write a freed node?  For example, it could
bpf_kptr_xchg() an acquired reference into a kptr field of the dead object
(kptr_xchg_dest_types allows NON_OWN_REF), and that reference is never
released.

For helpers with pads, a missed unwind only loses the exception.
bpf_rbtree_add() is the first one whose two exits leave the object in
different states (in the tree, or freed), so for it a missed unwind leaves
the verifier's state wrong.

bpf_check_attach_target() already refuses everything but fentry on a subprog
that can unwind ("unwind_exit would return to the trampoline that called the
target"), but kernel functions with a pad get no such restriction, and the
rest of the series (through 5646f059f1bb) adds none.  Should return-hooking
tracers be kept off these kfuncs (notrace, a btf_id_deny-style list for
fexit/fmod_ret/fsession, and no kretprobe or graph tracing), or should the
pad tolerate a rewritten return address?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40612543702
--===============8226136630849798558==--
