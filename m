Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416246;
	b=FmmllDpMm4eQOjrKh/8LkG07tTXQdHenfI6p1YQmIYpg7otNVJq/eExJ3Ac/Zinachct
	 F7udMeIPIzDDOFd5I+omVR/Bex5fe/YPfk3fzAi27xnQS98vwEQypqPb8sjAqWw8ZepmW
	 GfiM+L77+Lqxq9K17V8nCJKrfXKfYgnq+sHedM4Vw5fFUs4lOzRPYveVz4BpPlHu4BrrS
	 NyVW3nLx5TnUS+hhzBxouxM9hbA5IR/jy1hor2gNG4xLAwiiInjv6n+nzObwy/bsmBEdA
	 VnTnhXKU+ZbjI3lWBFMcAcs7dt6pRJ5C9YZgFTbdTepYzLVQe/JYrHv0L1HA8OR/Dpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416246;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LlBk1/s/45HNGcge7s3+nymhLej8cYXgLl3/Nt5KdiE=;
	b=YHj3ZVnuZsLN08M8Jk9chU41mRafx/3XTjyLS+KfvC0y0xhvGJZTnBNMT2yetIppHhOg
	 6fRixaXJdW7V/nacCpmt5yBgjCT+wOqMixSvi1LTK0vxq2N6s9jiIxR2m1hdnVuBPEFfZ
	 nmzoMiVG3iGsWAa1CY8u1cZ6R3zmMLQxlo0Oy5janZ9aDPPmPA7WQWpeCCFEZuLaMHs7l
	 UdBDXvMY4ZYm3mTzWuW703k31ESbF8GZItlT+uWp8+UgSR3vQbvWEjR07qPAmI/6+Ish9
	 i/NjNHQlKK3PGjimrvXi+DAjLNwlvSXtX7/MJQl8Qp4tcYa6fhG+EqU0+LD/Op24vZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hkUUMTyN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AC1606A32D
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hkUUMTyN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F381F00A05;
	Wed, 11 Nov 2026 16:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416246;
	bh=LlBk1/s/45HNGcge7s3+nymhLej8cYXgLl3/Nt5KdiE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=hkUUMTyNVQd1LRx/sravcC+uOT1sOzAJt8dzzjEoWu3ILjECxUnS/ZkRWc7dpdwvJ
	 ErxjfVUgB/Bmu7T3eDqNW1fI/1Yk8cfdaeNvno6s18vpO6s9IQQtn2T729zs+h/0mU
	 NClbK71szwiop3g25uhiDjXCkPto9JxVP4dwDSN8idREz4QtsFWuLnhDD6G8qBavBz
	 28b+t9BlLzUzPvMnCcF4UGkfWyfXehPiF77y4lSEuvAunBcY4tjTowsZTC35Pec3pW
	 Ol++aKkCm53mACHD0qnrs2P6ILzDvTOOeQoC59kdsdgLM1RktIwk86NLzGiYcPSB1D
	 RXyys3FSkK6dg==
Message-ID: <sashiko-outbox-209348@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 20/29] bpf: Transfer a reference to the
 callee that releases it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <97453d9e1f65a31c7f6ffbc09a7eb9f89913c5f3.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
 <97453d9e1f65a31c7f6ffbc09a7eb9f89913c5f3.1794399387.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 16:57:25 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] bpf: reference transfer via dead args in
  bpf_frame_desc_record_call()
- [Medium] bpf: wrong consumed arg in foreign_release() when regs share
  ref->id
--

commit f7b2132e50e4597119ba4ba7d888e76f32a3bd7e
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Transfer a reference to the callee that releases it

This commit transfers references passed in argument registers from the call=
er
to a subprog that releases them, tracking the acquired reference in the
callee's frame descriptor or hidden stack slot and returning it if unreleas=
ed.

> diff --git a/kernel/bpf/frame_desc.c b/kernel/bpf/frame_desc.c
> index d2ad02925f061..6679f134b14ee 100644
> --- a/kernel/bpf/frame_desc.c
> +++ b/kernel/bpf/frame_desc.c
[ ... ]
> @@ -736,7 +742,7 @@ static int foreign_release(struct bpf_verifier_env *e=
nv, const struct bpf_verifi
>  	const struct bpf_func_state *below =3D st->frame[ref->frameno + 1];
>  	struct bpf_subprog_info *sub;
>  	struct bpf_res_call *c;
> -	int f;
> +	int f, k;
> =20
>  	for (f =3D ref->frameno + 1; f <=3D st->curframe; f++) {
>  		sub =3D &env->subprog_info[st->frame[f]->subprogno];
> @@ -745,6 +751,21 @@ static int foreign_release(struct bpf_verifier_env *=
env, const struct bpf_verifi
>  		sub->releases_inherited =3D true;
>  		env->frame_desc_redo =3D true;
>  	}
> +	/* every frame it was passed down through in a register is handed it by=
 the one below */
> +	for (f =3D ref->frameno + 1; f <=3D st->curframe; f++) {
> +		if (!ref->id || ref->type !=3D REF_TYPE_PTR || (acq->flags & BPF_RES_F=
_ARG))
> +			break;
> +		for (k =3D BPF_REG_1; k <=3D BPF_REG_5; k++)
> +			if (st->frame[f]->entry_arg_id[k - 1] =3D=3D ref->id)
> +				break;
> +		if (k > BPF_REG_5)
> +			break;
> +		sub =3D &env->subprog_info[st->frame[f]->subprogno];
> +		if (sub->consumes & BIT(k))
> +			continue;
> +		sub->consumes |=3D BIT(k);
> +		env->frame_desc_redo =3D true;
> +	}

[Severity: Medium]
Can foreign_release() mark the wrong argument register in sub->consumes when
two arguments at subprog entry share ref->id?

bpf_frame_desc_record_call() records reg->id in callee->entry_arg_id[k - 1]
for every non-scalar argument without checking reg_ref_off(), and
foreign_release() picks the lowest register k matching ref->id and breaks. =
If
a caller passes a pointer sharing ref->id in R1 that fails reg_ref_off() (s=
uch
as a bpf_skc_to_mptcp_sock() result or a variable-offset ringbuf pointer) a=
nd
passes the base reference in R2 that the subprog actually releases,
foreign_release() marks R1 instead of R2. On the next round,
bpf_frame_desc_record_call() fails reg_ref_off() on R1, sets entry_none on =
R1,
and never transfers R2.

Even when reg_ref_off() succeeds on both registers (for example, one call p=
asses
(&p1->field, p1) where the subprog releases R2, and another call passes
(&p2->field, p3) while keeping p2 in a hidden slot), matching R1 first caus=
es
the second call to transfer and hand back p2 on R1, and once both R1 and R2
are in sub->consumes, transferring p1 on R1 at the first call moves
ref->frameno to the callee so R2 finds no caller reference and sets
entry_none. bpf_frame_desc_resolve() then rejects the program.

[ ... ]
> @@ -869,6 +916,71 @@ int bpf_frame_desc_record_exit(struct bpf_verifier_e=
nv *env)
>  	return 0;
>  }
> =20
> +/*
> + * Frame @callee of @st is entered with its arguments in place, by the c=
all at
> + * insn @callsite of the frame below it when @st is given; a callback, a
> + * callx and a function verified on its own come with none.
[ ... ]
> + */
> +int bpf_frame_desc_record_call(struct bpf_verifier_env *env, struct bpf_=
verifier_state *st,
> +			       struct bpf_func_state *callee, int callsite)
> +{
> +	struct bpf_subprog_info *sub =3D &env->subprog_info[callee->subprogno];
> +	struct bpf_reference_state *ref;
> +	int i, k, acq, err;
> +	s16 adj;
> +
> +	if (!env->describe_frames || (st && st->speculative))
> +		return 0;
> +	for (k =3D BPF_REG_1; k <=3D BPF_REG_5; k++) {
> +		struct bpf_reg_state *reg =3D &callee->regs[k];
> +
> +		callee->entry_arg_id[k - 1] =3D 0;
> +		callee->entry_arg_acq[k - 1] =3D 0;
> +		if (reg->type =3D=3D SCALAR_VALUE || reg->type =3D=3D NOT_INIT) {
> +			if ((sub->consumes & BIT(k)) && !bpf_register_is_null(reg))
> +				sub->entry_none |=3D BIT(k);
> +			continue;
> +		}
> +		callee->entry_arg_id[k - 1] =3D reg->id;
> +		if (!(sub->consumes & BIT(k)))
> +			continue;
> +		for (i =3D 0, ref =3D NULL; st && i < st->acquired_refs; i++) {
> +			ref =3D &st->refs[i];
> +			if (ref->frameno =3D=3D callee->frameno - 1 && ref->acq && ref->type =
=3D=3D REF_TYPE_PTR &&
> +			    !(env->res_acqs[ref->acq - 1].flags & BPF_RES_F_ARG) &&
> +			    reg_ref_off(reg, ref->id, &adj))
> +				break;
> +			ref =3D NULL;
> +		}
> +		if (!ref) {
> +			sub->entry_none |=3D BIT(k);
> +			continue;
> +		}
> +		err =3D rel_add(env, callsite, ref->acq - 1, k, 0, adj, 0);
> +		if (err)
> +			return err;
> +		acq =3D acq_add(env, sub->start, ref->res - 1, k, BPF_RES_F_ENTRY, adj=
, 0);
> +		if (acq < 0)
> +			return acq;
> +		callee->entry_arg_acq[k - 1] =3D ref->acq;
> +		ref->frameno =3D callee->frameno;
> +		ref->acq =3D acq + 1;
> +	}
> +	return 0;
> +}

[Severity: High]
Can bpf_frame_desc_record_call() transfer a reference through an argument
register that is dead at sub->start?

In setup_func_entry(), set_callee_state() copies R1..R5 from the caller to =
the
callee without filtering by env->insn_aux_data[sub->start].live_regs_before,
and bpf_frame_desc_record_call() runs before bpf_clean_verifier_state() scr=
ubs
dead registers at sub->start. If an unused argument register Rk still holds=
 a
copy of the caller's referenced pointer at the callsite (for example, R1 st=
ill
holds a copy of the pointer while the subprog only reads and releases R2),
foreign_release() sees entry_arg_id[k - 1] =3D=3D ref->id and sets BIT(k) in
sub->consumes. On the next round, bpf_frame_desc_record_call() transfers the
reference via the dead register Rk, emitting an ITEM_RELEASE before the call
that reads Rk and an entry store at sub->start that writes Rk into the
callee's hidden slot.

Because Rk is not in live_regs_before at the callsite or sub->start and is =
not
in env->frame_desc_regs, bpf_do_misc_fixups() can pick Rk as a scratch
register when expanding a preceding timed_may_goto in the caller, overwriti=
ng
Rk at runtime with the per-CPU struct bpf_timed_may_goto pointer:

kernel/bpf/fixups.c:bpf_do_misc_fixups() {
    ...
			u16 live =3D env->insn_aux_data[i].live_regs_before | env->frame_desc_re=
gs;
			int reg, save_off =3D 0;

			/* a register that is dead here holds the address of the count */
			for (reg =3D BPF_REG_0; reg <=3D BPF_REG_9; reg++)
				if (!(live & BIT(reg)))
					break;
    ...
}

At runtime, the caller's ITEM_RELEASE compares its hidden slot against the
clobbered Rk and fails to clear the caller's slot, while the callee's entry
stores the per-CPU timed_may_goto address into the callee's hidden slot. Wh=
en
the callee later releases the real pointer via R2 and throws, the unwinder
passes the per-CPU timed_may_goto pointer from the callee's slot to the
resource destructor and then double frees the object from the caller's
uncleared slot. Checking env->insn_aux_data[sub->start].live_regs_before &
BIT(k) in bpf_frame_desc_record_call() would ignore registers that the call=
ee
never reads.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794399387.gi=
t.memxor@gmail.com?part=3D20
