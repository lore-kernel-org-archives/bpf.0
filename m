Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271794;
	b=01ME63BuvOHBe/N2ZIDzoB3dIBBMNP5U264NkBck+k+dhuVOjr+dUyMkZ9d72Tsttt/z
	 NFV5Ev57RMnRZ31GiLEzVe6ft7wFkKztlPkPaU9V0a9hk2fMmKUKF6ut3agFT/dyOQ/kK
	 PkE5dHLz+s6tPO/54TFh4onIO3485HVLLP6cZRpI+1qN7tA3YJ+KI4odeuOsu0zIXlunM
	 ObOTq4tkzieHSRGMN8xc6p07/X1i1EYQHlYj4CvCzWYJ9373xBn10xmVikX9FqIhEp37D
	 f5MiqH5NWEo9UdpA2sX9urQ3eL54WJkX5JU7O8qGSjR9WgqaDFxPGnEjMZPnSN2H1KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271794;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=545u7uiG3kVUPKOQF3whnaC9dCIK6m5gTVc0hb4K0bM=;
	b=BzvLlSnZ6UAocTcNImOpa6KOr0TNT1hyJlxVuE5Liko0WDre8y8vzbRhIW9llDlUwrOJ
	 2+bVuc3I6tus8p3nuhNtZ/Ttaoy5/BkxId8PHfivijVuh+s+7t8+cr/l6/D6sVlzakbbQ
	 Mrv4mODB2BckljR44Yw9K5Qbbg9qgNIOxk/6L2AHm/Mhc3YeGWcCxs5YtHNULrWCuQaOR
	 nJ04QVXj3Vdl46tfPPRdF4NQoFjRXpAv7QMAXF2SEY7R352Y2MVeuw10EGczeMQBgMo7c
	 J5EUtjBi6JQACCIAgKNUoyCKIJ9VcjZOaw3FWiAr4AcVFv5+TtWe7/BN3VhIYXfMxZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ex9XiqAF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C69606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ex9XiqAF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AF51F0089F;
	Tue, 10 Nov 2026 00:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794271793;
	bh=545u7uiG3kVUPKOQF3whnaC9dCIK6m5gTVc0hb4K0bM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Ex9XiqAF1O4ErEOpYItIaKNI6CIT1XByWyLbr0jYZdsvaWIscSTwdmSm9uVzXisCj
	 qct37mJqRgbPE0Vx045hOPGrGAL+SRf4Vf+6LTX4skeBulykoIgOdBMbHdy80pODZL
	 s+NrwcNHDInpAriiphwFocP7nvTLMZbUpHQRmWKFLmMse4JOu5VYPLsSS9T2Vd2Q46
	 aR5g6DAnokgoLVNTJXKX0jw7fJxfE7In4kq9sa23NMI+4TYqNUq8MvnZhxygpr7Gma
	 qzlZVS9GupOrdHQ972ruo1PalROCO7USRwG8qw/kPr/knUvvWwGsJmvjPSbDXfEakk
	 kFhLjm6OZHSdw==
Message-ID: <sashiko-outbox-205901@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 02/20] bpf: Invalidate what a
 bpf_task_park() sleep may free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <6751e6b26413cb4ea40aa63fd6bbb211e54cae49.1794269506.git.memxor@gmail.com>
References: <cover.1794269506.git.memxor@gmail.com>
 <6751e6b26413cb4ea40aa63fd6bbb211e54cae49.1794269506.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 00:49:53 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] bpf: bpf_ringbuf_reserve() pointers kept valid across
  bpf_task_park()
--

commit 11efbb37e52ed0e418ad28fcbe4b8333ae9d9f8c
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Invalidate what a bpf_task_park() sleep may free

This commit teaches the verifier to reject bpf_task_park() calls while live
dynptrs or non-num iterators are on the stack, and to invalidate pointers
whose lifetime depends on the Tasks Trace RCU read section or disabled
migration dropped during the sleep.

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 20b1b9ff574c7..e90cc127aedb8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11222,6 +11222,98 @@ static void invalidate_non_owning_refs(struct bp=
f_verifier_env *env)
>  	}));
>  }
> =20
> +/*
> + * bpf_task_park() sleeps without the Tasks Trace RCU read section and t=
he
> + * disabled migration that a sleepable program otherwise runs under. A d=
ynptr
> + * or an iterator on the stack cannot simply be invalidated across such a
> + * sleep: the program must still release or destroy it, and an object th=
at
> + * stays usable may point at memory the sleep lets go. Refuse the park w=
hile
> + * any is live, except a bpf_iter_num, whose state lives entirely on the=
 stack
> + * and whose next and destroy touch nothing else.
> + */
> +static int check_park_stack_objects(struct bpf_verifier_env *env, int in=
sn_idx)
> +{
> +	struct bpf_verifier_state *vstate =3D env->cur_state;
> +	int i, spi;
> +
> +	for (i =3D 0; i <=3D vstate->curframe; i++) {
> +		struct bpf_func_state *frame =3D vstate->frame[i];
> +
> +		for (spi =3D 0; spi < bpf_stack_nr_slots(frame); spi++) {
> +			struct bpf_stack_state *slot =3D bpf_stack_slot(frame, spi);
> +			struct bpf_reg_state *st =3D &slot->spilled_ptr;
> +
> +			switch (slot->slot_type[BPF_REG_SIZE - 1]) {
> +			case STACK_DYNPTR:
> +				/* Report the slot the program named, not the second half. */
> +				if (!st->dynptr.first_slot)
> +					continue;
> +				verbose(env, "bpf_task_park() with a live dynptr at frame %d fp%d\n",
> +					i, -(spi + 1) * BPF_REG_SIZE);
> +				break;
> +			case STACK_ITER:
> +				if (!st->id)
> +					continue;
> +				if (st->iter.btf =3D=3D btf_vmlinux &&
> +				    !strcmp(iter_type_str(st->iter.btf, st->iter.btf_id), "num"))
> +					continue;
> +				verbose(env, "bpf_task_park() with a live %s iterator at frame %d fp=
%d\n",
> +					iter_type_str(st->iter.btf, st->iter.btf_id), i,
> +					-(spi + 1) * BPF_REG_SIZE);
> +				break;
> +			default:
> +				continue;
> +			}
> +			bpf_diag_res(env, insn_idx, "live stack object across bpf_task_park()=
",
> +				     "A dynptr or iterator on the stack may refer to memory that the=
 sleep in bpf_task_park() lets go, and the verifier cannot invalidate it wi=
thout losing the path that releases its reference.",
> +				     "Release or destroy the dynptr or iterator before calling bpf_t=
ask_park(), or move the park out of the loop that uses it.");
> +			return -EINVAL;
> +		}
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Invalidate what the sleep in bpf_task_park() may free. Keep only poin=
ters
> + * whose lifetime does not rest on the dropped protection: the stack and
> + * instruction metadata; the context and the maps the program references
> + * directly, which the invocation holds; the values of its array maps, w=
hich
> + * the map allocates and frees with itself, and which hold the program's
> + * global variables; arena memory, which the arena map holds and whose
> + * accesses tolerate faults; and pointers backed by an explicit
> + * verifier-tracked reference, found through their own id or the id of t=
heir
> + * parent. An inner map found through a map-in-map lookup is not kept, n=
or
> + * are its values: the outer map's element alone holds it, and its delet=
ion
> + * frees it after a grace period the sleeping program no longer delays.
> + * Everything else, values of maps that free elements on delete or on th=
eir
> + * owner's teardown, RCU and trusted pointers without a reference, per-C=
PU
> + * and local storage pointers, is gone after the call.
> + */
> +static void invalidate_regs_across_park(struct bpf_verifier_env *env)
> +{
> +	struct bpf_stack_state *stack;
> +	struct bpf_func_state *state;
> +	struct bpf_reg_state *reg;
> +
> +	bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, stack, 1 <<=
 STACK_SPILL, ({
> +		enum bpf_reg_type type =3D base_type(reg->type);
> +
> +		if (!is_pointer_regtype(reg->type))
> +			continue;
> +		if ((reg->id && find_reference_state(env->cur_state, reg->id)) ||
> +		    (reg->parent_id && find_reference_state(env->cur_state, reg->paren=
t_id)))
> +			continue;

[Severity: High]
Does this allow a PTR_TO_MEM | MEM_RINGBUF sample pointer from
bpf_ringbuf_reserve() to survive across bpf_task_park()?

is_acquire_function() treats BPF_FUNC_ringbuf_reserve as an acquire call,
so check_helper_call() records a REF_TYPE_PTR entry in env->cur_state->refs
for the returned register.  Unlike refcounted kernel objects,
__bpf_ringbuf_reserve() only sets BPF_RINGBUF_BUSY_BIT on the record header
and does not take a reference on the underlying struct bpf_ringbuf_map.

Because BPF_MAP_TYPE_RINGBUF can be used as an inner map in a map-in-map,
its lifetime during a sleepable program is only protected by the outer map
element and the Tasks Trace RCU read section.  If the inner ringbuf map is
removed and freed while bpf_task_park() sleeps, the preserved sample
pointer becomes dangling and a subsequent access or bpf_ringbuf_submit()
triggers a use-after-free.  Like bpf_ringbuf_reserve_dynptr(), should
bpf_task_park() be rejected while a ringbuf reservation is live?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794269506.gi=
t.memxor@gmail.com?part=3D2
