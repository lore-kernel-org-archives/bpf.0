Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793150482;
	b=XLvcfUiPJ/ixSpfy2ocdB7J0Sii/7ajxb3r6+2r33xeIT6ahVJ3U0fDS9S9nr6qsE0Y5
	 R+E0r6CMOkIbV3mZVjK+xcGRcFnz1rqi+j5XzFKHIxA/bPEqSlWqA4edWz9AYx52B/gCW
	 RZmEhJBtnWLU716hE7A8rnzOpD3oAGxiXKZ1xcPmlo4WpbwmGsKulU2LnE0pZy3kx35Vx
	 zHlF9jP/tBXaeWrqCRigeVxqddagu5mr2BzaMeV4mfoURqs7AMVfklwDDbbNHFQlB1pHd
	 8BuUSKG9KFeQsvyGzTq/ZjnV8TTDBha5nVjJGPmBbUjOvmKwoR41OQ6KszqKX2C9Q8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150482;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5fX7iPaxo8W+0QMR0uNLxxMcUdE3O6fpqck33aW7dPA=;
	b=JVB3KwgvdY1igWT6IYKPVvZOWSYnxQcF132b08GzngE12rkOtXa5o/VScUhPiRZbakuL
	 ehsnW/hW/U+kEc4FkF8DxFF1gfaCxLTPkaSrFKBDBxEWfPAsKmoq+bJ3nij3GKHz2EKiz
	 XkqTZjNMZRaeBg7d4+W0RDW6LBbmIPXt0nP/AgzbdxpwWS7U7NSaL0zmYcCKV52Nd+Xp+
	 uuY2qt9m471PfCXK8jJvZGTCEcj3dPnpMgpwRziTUKPM/N4VYw/0bmXJBelLt1FbsU62o
	 SkTv3NDKHlVwHhI7g2wj88WvICRaEK0ptreU0eSHLu1StXUp62x7Hj/uv8UhfOlaFsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dh1Ei0Xc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0CE606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 01:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dh1Ei0Xc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EE51F01825;
	Wed, 28 Oct 2026 01:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793150482;
	bh=5fX7iPaxo8W+0QMR0uNLxxMcUdE3O6fpqck33aW7dPA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dh1Ei0Xcpv03VIoVhPqucRGSuYpG9uuQy9nwInrrjcrQdqiOO11foD7nBDpbAmnpC
	 YHopwaewcQig7eYk4OlQuWZ43ZZdZGqfrnjhPPyL+nf6UY+89qbk8Ghp0p5OytkpS2
	 +Jcg4F2oc6zCfXVEZF12gPuUzRVwu3uYu7kx9faOXs9vYlbOSNQ/Po1PpfvpNXkpVF
	 qTznzfCQksO2ew5J3gD/ClHOU7JPP64YM3+dvOg4MiqOMHwfn5a7bLPeCR40lGm4dy
	 nwgGXbVnykjHUTvDtHqPiX4TAFFzi9EAcAk+6qcgz4rFEd3W9qS66lGvOuDLSh9Cps
	 HEmvk1dAra9BQ==
Message-ID: <sashiko-outbox-187313@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 09/11] bpf: Let the comparator of
 bpf_rbtree_add unwind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <d81d996f09e0fd0b07816dcd0541f39c0f451a23.1793147364.git.memxor@gmail.com>
References: <cover.1793147364.git.memxor@gmail.com>
 <d81d996f09e0fd0b07816dcd0541f39c0f451a23.1793147364.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 01:21:21 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] bpf: clobbered R2 on bpf_rbtree_add() callback unwind causes U=
AF
- [High] bpf: __bpf_rbtree_add() leaves node->owner poisoned on comparator =
unwind
--

commit 55e1518aab2a62c50b8098afe20794d027a69689
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Let the comparator of bpf_rbtree_add unwind

This commit allows the comparator callback of bpf_rbtree_add() and
bpf_rbtree_add_impl() to unwind via unwind_exit. When the comparator
unwinds, the kfunc drops the uninserted node before leaving to the landing
pad, and the verifier invalidates non-owning references and releases the
caller's owning reference on revisit.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 648abe1ba63ae..f8708b7181d72 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -2784,7 +2788,8 @@ static int __bpf_rbtree_add(struct bpf_rb_root *roo=
t,
> =20
>  	while (*link) {
>  		parent =3D *link;
> -		if (cb((uintptr_t)node, (uintptr_t)parent, 0, 0, 0)) {
> +		bpf_call_cb(cb, node, parent, 0, 0, 0, r0, unwound);
> +		if (r0) {
>  			link =3D &parent->rb_left;
>  		} else {
>  			link =3D &parent->rb_right;
> @@ -2796,6 +2801,15 @@ static int __bpf_rbtree_add(struct bpf_rb_root *ro=
ot,
>  	rb_insert_color_cached(n, (struct rb_root_cached *)root, leftmost);
>  	WRITE_ONCE(node->owner, root);
>  	return 0;
> +
> +unwound:
> +	/*
> +	 * The comparator left with unwind_exit. The node is not in the tree, a=
nd
> +	 * the caller has let go of it: drop it, as the error path above does.
> +	 */
> +	__bpf_obj_drop_impl((void *)n - off, rec, false);
> +	bpf_unwind_leave();
> +	return r0;
>  }

[Severity: High]
Does the unwound path in __bpf_rbtree_add() leave node->owner poisoned with
BPF_PTR_POISON when the object survives __bpf_obj_drop_impl()?

At the start of __bpf_rbtree_add() in kernel/bpf/helpers.c, node->owner is
transitioned from NULL to BPF_PTR_POISON before the traversal loop:

	if (cmpxchg(&node->owner, NULL, BPF_PTR_POISON)) {
		/* Only called from BPF prog, no need to migrate_disable */
		__bpf_obj_drop_impl((void *)n - off, rec, false);
		return -EINVAL;
	}

When the comparator callback cb exits via unwind_exit during the while (*li=
nk)
loop, control jumps to unwound after cmpxchg() has already set node->owner =
to
BPF_PTR_POISON, and before WRITE_ONCE(node->owner, root) is reached.

If the object contains a bpf_refcount field and another active reference to=
 it
exists (for example via bpf_refcount_acquire() before calling bpf_rbtree_ad=
d()
or inside the comparator before unwinding), __bpf_obj_drop_impl() decrements
the refcount and returns without freeing the object:

	if (rec && rec->refcount_off >=3D 0 &&
	    !refcount_dec_and_test((refcount_t *)(p + rec->refcount_off))) {
		return;
	}

Unlike bpf_rb_root_free(), which clears node->owner back to NULL before
dropping the reference:

	/* Ensure __bpf_rbtree_add() sees the node as unlinked. */
	smp_store_release(&node->owner, NULL);
	__bpf_obj_drop_impl(obj, field->graph_root.value_rec, false);

the unwound path in __bpf_rbtree_add() leaves node->owner set to
BPF_PTR_POISON on the surviving unlinked object, causing any subsequent
bpf_rbtree_add() or bpf_rbtree_add_impl() call on that object to fail the
cmpxchg() check with -EINVAL. Should node->owner be reset to NULL before
calling __bpf_obj_drop_impl() in the unwound path?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fd63ff36eb909..50c3d44c37e15 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -15738,7 +15738,21 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>  		id =3D regs[BPF_REG_2].id;
>  		insn_aux->insert_off =3D regs[BPF_REG_2].var_off.value;
>  		insn_aux->kptr_struct_meta =3D btf_find_struct_meta(meta.arg_btf, meta=
.arg_btf_id);
> -		ref_convert_owning_non_owning(env, id);
> +		/*
> +		 * The comparator unwound: the node never went in, and the
> +		 * kfunc dropped it on its way to the pad. The comparator was
> +		 * handed the node too, and may have unwound with it in r0, so
> +		 * every non-owning reference goes. Otherwise the node is in
> +		 * the tree now.
> +		 */
> +		if (env->cur_state->unwound) {
> +			invalidate_non_owning_refs(env);
> +			err =3D release_reference(env, id);
> +			if (err)
> +				return err;
> +		} else {
> +			ref_convert_owning_non_owning(env, id);
> +		}
>  	}

[Severity: Critical]
Can an unwinding comparator callback with a two-register return type clobber
caller->regs[BPF_REG_2] in prepare_func_exit(), causing check_kfunc_call() =
to
release the wrong reference ID and leave a dangling owning pointer to the
dropped node?

During verifier setup, bpf_compute_subprog_ret_regs() sets ret_reg_pair =3D=
 true
for any subprogram whose BTF return type is a 9-16 byte struct, and
btf_validate_return_type() allows static subprograms to return structs up to
16 bytes. Neither check_func_arg(), push_callback_call(), nor
check_cb_unwind() prevents the less callback passed to bpf_rbtree_add() or
bpf_rbtree_add_impl() from having ret_reg_pair =3D=3D true.

When such a callback executes unwind_exit, prepare_func_exit() in
kernel/bpf/verifier.c computes nregs =3D 2 (where ret_regs[] =3D { BPF_REG_=
0,
BPF_REG_2 }) and copies both registers from the callee frame into the caller
frame before rewinding *insn_idx to callee->callsite:

	callee =3D state->frame[state->curframe];
	r0 =3D &callee->regs[BPF_REG_0];
	nregs =3D bpf_ret_reg_pair(env, callee->subprogno) ? 2 : 1;
	...
	if (callee->in_callback_fn && !unwinds) {
		...
	} else {
		for (i =3D 0; i < nregs; i++) {
			u32 regno =3D ret_regs[i];

			bpf_diag_mod_begin(env, &caller->regs[regno], &callee->regs[regno],
					   BPF_DIAG_MOD_WRITE);
			caller->regs[regno] =3D callee->regs[regno];
			bpf_diag_mod_end(env);
		}
	}

If the caller passed &n1->node (with id =3D n1_id) in BPF_REG_2 while keepi=
ng a
copy of n1 in a callee-saved register (R6-R9) or stack spill, and the
comparator callback acquires an owning reference to a second node n2 of the
same BTF type (for example via bpf_refcount_acquire() or
bpf_list_pop_front()), places &n2->node (with id =3D n2_id) into BPF_REG_2,=
 and
executes unwind_exit:

1. prepare_func_exit() overwrites caller->regs[BPF_REG_2] with &n2->node
   (id =3D n2_id).

2. On the revisit of check_kfunc_call() at bpf_rbtree_add() with
   env->cur_state->unwound =3D=3D true, check_func_args() succeeds because
   caller->regs[BPF_REG_2] holds a valid owning pointer of the expected
   node type, and release_reference(env, id) releases n2_id instead of n1_i=
d.

3. At runtime, __bpf_rbtree_add() drops the caller's original node n1 via
   __bpf_obj_drop_impl(), while in the verifier state at the landing pad af=
ter
   unwind_goto, n1_id was never released and the caller's saved pointer to =
n1
   remains a valid owning PTR_TO_BTF_ID | MEM_ALLOC pointer to freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793147364.gi=
t.memxor@gmail.com?part=3D9
