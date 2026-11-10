Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271207;
	b=WmxL9c21Yoc4Yc97zAsG+0K0teXuL1BZuOtPqIuS/sO1qhG6TZ4hsFMZ52JUoW1WNfI0
	 c6t2cenOGFJ77hcByqYzevz26julS2rn59lzknalWZJbqa7zk4zzkYCGlC+jcthl/VuOI
	 WGb21g817GNW28zVlZDgwdtk/uTyUriqqSzkD95Uu2tVMvw272f4uAzppK/n9WugAKmnr
	 PFPy2skDmUp/1p7LfyAbFiV67dyHTzMqow6iqu4jCNltS1sX/+Av0JcbeEKe1+8pjaG89
	 nuDgLs9WbBLXZ2TlqIim3YYOVdooUjtwY0HSY5zDo7+6uQu0R+kuDPPBQ/mC6bnrfwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271207;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kKx45vgtDx3CxbUxjeWIU9qYl4HP3FC8zo9abTzBkCw=;
	b=PlIVd+RmdBUvaIT3ra+7GKQP7siwCNZ4NoxpDNHuWHu6dUf7eZ0H89XU6YrSQfprq51y
	 HmnswrUltF/ccUDTycWKXMIx7GWH0AWIfkyEZaOLHcMjRe0cK5h8R/DySzyQjNG1dM73p
	 xUKwJRpGGShU9dctu1YJ1Tcmi09FFb+sgL50Yivk7XOi0i+M/z9FQDA7oqC19XLmTq10s
	 4AgV37I6Hru53DfBdlCvftm8LdrxjT7ZhEOg1Ovh5uxfpMPcNVQmdg5vp8KktBUWNIkr+
	 7aGyzU/J234f1PrXucRnvq1Ko4yLbvoqFw2T8twtxVj/h3kmjxEMOdJRNiITxFo/LmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="g/s4O84K";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4022606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g/s4O84K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E4C1F008A2;
	Tue, 10 Nov 2026 00:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794271206;
	bh=kKx45vgtDx3CxbUxjeWIU9qYl4HP3FC8zo9abTzBkCw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=g/s4O84KihNuLEqzsfHB5ZtGcqN7tiF6mhxuLkQ4ulQcsxGHMN+ChIXH333dQgAsr
	 c3/I+1zNuBoomlzY8kPA3/CD4oSzqMqF7qHOgc9dscM/UCSC0Uioev+sZIOVd+16E8
	 ++txVj//sIFZ5YaTAHbfxAYevufOvGfavW96zJyPFHTe3EX46dQwQ7eayWg5zt4vgO
	 pyjUWCGKrPF7bu1zqi46sHvWZ5p9tW4bvo7eo4SQFDTsXAwrjIqoJmHrxaILvYJvO8
	 0neAKZywoT2aVEyILRFVj78EwILlnQtM9f4NlsW1Gf5reh3K2SlHvTKoxmYaSz7UM5
	 icMjDLUzwg2Yw==
Message-ID: <sashiko-outbox-205882@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 03/20] bpf: Refuse bpf_task_park() in
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <d7e8470a75a3ff4b2e65066f6ba6edb4e5bc14ef.1794269506.git.memxor@gmail.com>
References: <cover.1794269506.git.memxor@gmail.com>
 <d7e8470a75a3ff4b2e65066f6ba6edb4e5bc14ef.1794269506.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 00:40:06 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 2 related pre-existing issues it does not
introduce:
- [Critical] bpf: missing in_rbtree_lock_required_cb() check in
  check_func_arg() [1]
- [Critical] bpf: missing parent_id propagation in check_kfunc_call()
  [2]
--

commit 73a7888b7c16b7854db73a1efaa1ffed4dc01be8
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Refuse bpf_task_park() in callbacks

This commit rejects calls to bpf_task_park() inside synchronous,
asynchronous, and exception callback frames by walking the active frames in
the verifier state.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e90cc127aedb8..b42782c7f209d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11222,6 +11222,31 @@ static void invalidate_non_owning_refs(struct bp=
f_verifier_env *env)
>  	}));
>  }
> =20
> +/*
> + * bpf_task_park() is confined to the main body of the program and the
> + * functions it calls directly. A callback runs from kernel code that ho=
lds
> + * state of its own around the call, an iteration position, a work item =
or
> + * timer that owns the program only through Tasks Trace RCU, an exiting =
task,
> + * none of it audited against a sleep that drops the program's protectio=
n.
> + * Refuse the park in any callback frame, synchronous, asynchronous or
> + * exception. Asynchronous callbacks are verified as a state of their own
> + * with the callback as frame 0, so the walk over the frames sees them t=
oo.
> + */
> +static bool in_callback_frames(struct bpf_verifier_env *env)
> +{
> +	struct bpf_verifier_state *vstate =3D env->cur_state;
> +	int i;
> +
> +	for (i =3D 0; i <=3D vstate->curframe; i++) {
> +		struct bpf_func_state *frame =3D vstate->frame[i];
> +
> +		if (frame->in_callback_fn || frame->in_async_callback_fn ||
> +		    frame->in_exception_callback_fn)
> +			return true;
> +	}
> +	return false;
> +}

[Severity: Critical]
This problem wasn't introduced by this patch, but can an rbtree comparator
callback corrupt the tree via [1] because check_func_arg() skips
in_rbtree_lock_required_cb() for bpf_rbtree_add_impl()?

kernel/bpf/verifier.c:check_func_arg() {
	...
	case ARG_PTR_TO_RB_NODE:
		if (is_bpf_rbtree_add_kfunc(meta->func_id)) {
			if (reg->type !=3D (PTR_TO_BTF_ID | MEM_ALLOC)) {
				verbose(env, "%s expected pointer to allocated object\n",
					reg_arg_name(env, argno));
				return -EINVAL;
			}
			if (!reg_is_referenced(env, reg)) {
				verbose(env, "allocated object must be referenced\n");
				return -EINVAL;
			}
		} else {
			...
			if (in_rbtree_lock_required_cb(env)) {
				verbose(env, "%s not allowed in rbtree cb\n", meta->func_name);
				return -EINVAL;
			}
		}
}

While the outer __bpf_rbtree_add() is mid-traversal inside bpf_call_cb(),
the comparator callback can acquire an owning node reference (for example,
via bpf_list_pop_front()) and invoke bpf_rbtree_add_impl() with a second
comparator subprogram. The nested insertion links the node and rebalances
the tree under the already-held lock, leaving the outer __bpf_rbtree_add()
to finish linking with stale parent, link, and leftmost state when the
callback returns.

> @@ -16366,6 +16391,12 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>  	}
> =20
>  	if (is_bpf_task_park_kfunc(meta.func_id)) {
> +		if (in_callback_frames(env)) {
> +			verbose(env, "bpf_task_park() is not allowed in a callback\n");
> +			bpf_diag_policy(env, insn_idx, "kfunc bpf_task_park", "the call is in=
 a callback",
> +					"Call bpf_task_park() from the main program or from a function it c=
alls directly, not from a callback.");
> +			return -EINVAL;
> +		}
>  		err =3D check_park_stack_objects(env, insn_idx);
>  		if (err)
>  			return err;

[Severity: Critical]
This problem wasn't introduced by this patch, but does check_kfunc_call()
fail to track the lifetime of a returned PTR_TO_MEM register [2] when
the kfunc argument is a borrowed pointer?

kernel/bpf/verifier.c:check_kfunc_call() {
			...
			mark_reg_known_zero(env, regs, BPF_REG_0);
			regs[BPF_REG_0].type =3D PTR_TO_MEM;
			regs[BPF_REG_0].mem_size =3D meta.ret_mem.size;
			...
			if (meta.ref_obj.id) {
				err =3D validate_ref_obj(env, &meta.ref_obj);
				if (err)
					return err;
				regs[BPF_REG_0].parent_id =3D meta.ref_obj.id;
			}
}

For a borrowed pointer argument, meta.ref_obj.id is 0 and the parent
object's lifetime is recorded in meta.ref_obj.parent_id instead. Ignoring
meta.ref_obj.parent_id leaves regs[BPF_REG_0].parent_id unset, so releasing
or invalidating the underlying parent object does not invalidate R0,
allowing a use-after-free through the returned PTR_TO_MEM pointer.

[1] https://sashiko.dev/#/bug/linux-eb46b3eb-92d0-4fac-b401-30327c613b94
[2] https://sashiko.dev/#/bug/linux-3da483d6-33c8-4529-a20e-81cdfb7a8ed3

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794269506.gi=
t.memxor@gmail.com?part=3D3
