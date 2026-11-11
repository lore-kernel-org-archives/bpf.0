Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416573;
	b=Ct/KTkQYgcFmGju3wHTpifjz3oAdmB3nYQchAF10vKRBPePaJ2kHjC+bLMUsjOexLxoC
	 9T8ppKr6qc6HR0kxO1QRkkA7ecAfE9DWnfrEIu6UQqoeT3vHt2lKdGzkrWkc+n0ihG3pO
	 lQwHYnPyukkZlvG79NZO3sEFZ5GTfXYzXEvcjgE/RDLvtTMf2GXs4oROY6lJ0JAwaVa8r
	 NKxUt73TCXkT9cGBAd/C3I2GKaiMwm1rWAuEBkdKMCTI5w17rC2jL9vUHltx18Zy/xDpF
	 CBVEsYhdZLxPo1UDrtbJcvmuHxgJRq6EAtjnohajeFFYF8DS9z0T4asEAHdb47wjAgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416573;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gjTiyQRPPSc2lFirhJYqEF6CfdglUAVtDkbJdWRZbgo=;
	b=cL5FWj1YWaWD4EHKcyNMe/mrrMGpK5jJ8O0Kjp3bU5gk4QuhiiawlRybi8rShB95cDPr
	 z0FL68Rdlu3Dar4QX660mx8LOLvdWQZiMILngIn8DS/myhEtRbmiEnYILGEOooDGXS7TK
	 mFonODWM06Pw++NmWtY3kgUor2RCx6wL4s183v3dCB/LKXXsLV2Xk+8llXjxupLhvrMBX
	 /8Z/UwrBwHhHy3r722vROzNrCKoHGqDpHen0o6/T13Do+nAL2NHmqY3yMrVVE1ZZ3KAE/
	 36znC5/B0xnK+rRTfsGVliNhVO0p359poJUhuRSF99KGQHPXBBXJ8HnDPu5ZauudGJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="foX0Wms/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD00606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=foX0Wms/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDF41F00A05;
	Wed, 11 Nov 2026 17:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416572;
	bh=gjTiyQRPPSc2lFirhJYqEF6CfdglUAVtDkbJdWRZbgo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=foX0Wms/bGocluMRF1tgp7McPwt+MfKR0E9r+9AUtdK1xZ9HLPDdh+5MXDl2Yu5h5
	 0a/OE28PiL5iBW1IKDP7NIeMHRetuo4Fp0wBlKkpDFHtr22tQPUo0Gg/st3GIa2WOi
	 CK6ti9cNdfjj8RHWu1ZHXS+pUC86nqAXF1Lgsn5Y3B5bhCnokli2EUVM6WjcTSLt3a
	 0g+ptn4TJlMaWKksr1PBkoD+EMz2bssT/b2YmOUlaySLlhaUZsJSb30RVLzodPlhAg
	 2lQMVsMcebDtkqAsuuD7zTw6C5XyZUck7mYHySikewfvcadc/BJ1lgiG1QEXO0AKQL
	 MuuSkPehMxl+Q==
Message-ID: <sashiko-outbox-209363@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 19/29] bpf: Allow a callee to release its
 caller's resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <94c4fd13b4c95090e159b905110781973e8e56ad.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
 <94c4fd13b4c95090e159b905110781973e8e56ad.1794399387.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 17:02:51 +0000
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
- [High] bpf: missing releases_inherited mark in release_context_state()
--

commit e5be88d9a8d47ae92f3e9f98a812d289864c60bf
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Allow a callee to release its caller's resources

This commit allows a subprogram in a program that throws to release
resources acquired by its caller, clearing the caller's hidden slot before
the call when needed and marking intermediate subprograms with
releases_inherited at the release site so they are verified in the context
of their callers.

> diff --git a/kernel/bpf/frame_desc.c b/kernel/bpf/frame_desc.c
> index 9854be9ab4781..d2ad02925f061 100644
> --- a/kernel/bpf/frame_desc.c
> +++ b/kernel/bpf/frame_desc.c

[ ... ]

> @@ -689,12 +690,76 @@ static int rel_add(struct bpf_verifier_env *env, u3=
2 insn, u16 acq, u8 reg, u8 f
>  	return 0;
>  }
> =20
> +/*
> + * What the call @insn of a subprog means for what acquisition @acq acqu=
ired
> + * is noted in the record of the two, see struct bpf_res_call. NULL when=
 there
> + * is no memory for one.
> + */
> +static struct bpf_res_call *call_note(struct bpf_verifier_env *env, u32 =
insn, u16 acq)
> +{
> +	u32 i, cnt =3D env->res_call_cnt;
> +	struct bpf_res_call *c;
> +
> +	for (i =3D 0; i < cnt; i++)
> +		if (env->res_calls[i].insn =3D=3D insn && env->res_calls[i].acq =3D=3D=
 acq)
> +			return &env->res_calls[i];
> +	c =3D kvrealloc(env->res_calls, array_size(cnt + 1, sizeof(*c)), GFP_KE=
RNEL_ACCOUNT);
> +	if (!c)
> +		return NULL;
> +	c[cnt] =3D (struct bpf_res_call) { .insn =3D insn, .acq =3D acq };
> +	env->res_calls =3D c;
> +	env->res_call_cnt =3D cnt + 1;
> +	return &c[cnt];
> +}
> +
> +/*
> + * The current insn releases @ref, which a frame below the current one o=
wns.
> + * Nothing tells a callee where the slot of its caller is, so it cannot =
clear
> + * one. There are two ways out:
> + *
> + *  - What the caller holds without a slot needs none cleared: its sites=
 say
> + *    where the handle is on the visits that find it held, and say nothi=
ng on
> + *    those that find it released.
> + *  - The caller clears its slot in front of the call when the callee re=
leases
> + *    the resource on every path and no throw finds the caller holding i=
t at
> + *    the call, see bpf_frame_desc_resolve().
> + *
> + * The functions between the owner and the current frame are verified in=
 the
> + * context of their callers from now on, so that every throw sees the fr=
ames
> + * below it as they are. The round of the main pass that finds one out i=
s done
> + * again, since it recorded the frames of its callers at the call, holdi=
ng
> + * what they held then.
> + */
> +static int foreign_release(struct bpf_verifier_env *env, const struct bp=
f_verifier_state *st,
> +			   const struct bpf_reference_state *ref, struct bpf_res_acq *acq)
> +{
> +	const struct bpf_func_state *below =3D st->frame[ref->frameno + 1];
> +	struct bpf_subprog_info *sub;
> +	struct bpf_res_call *c;
> +	int f;
> +
> +	for (f =3D ref->frameno + 1; f <=3D st->curframe; f++) {
> +		sub =3D &env->subprog_info[st->frame[f]->subprogno];
> +		if (sub->releases_inherited)
> +			continue;
> +		sub->releases_inherited =3D true;
> +		env->frame_desc_redo =3D true;
> +	}

[Severity: High]
Does release_context_state() also need to set sub->releases_inherited and
env->frame_desc_redo when a frame leaves an inherited RCU read or
preemption-disabled section?

foreign_release() marks sub->releases_inherited when a callee releases an
entry in st->refs[] so that a subprog that throws without returning is
verified in the context of its caller.  However, RCU and preemption-disabled
sections are tracked via entry_rcu_locks and entry_preempt_locks rather
than st->refs[]:

kernel/bpf/verifier.c:release_context_state() {
	for (fr =3D 0; fr <=3D state->curframe; fr++) {
		frame =3D state->frame[fr];
		if (frame->entry_rcu_locks > state->active_rcu_locks)
			frame->rcu_released_below +=3D frame->entry_rcu_locks - state->active_rc=
u_locks;
		if (frame->entry_preempt_locks > state->active_preempt_locks)
			frame->preempt_released_below +=3D frame->entry_preempt_locks -
							 state->active_preempt_locks;
    ...
}

For those sections, releases_inherited is only set in bpf_flow_return() when
the callee returns.  If a static subprogram calls bpf_rcu_read_unlock() on
its caller's RCU section and then calls bpf_throw() without returning, it
remains verified on its own without the caller's frames in env->cur_state.
When bpf_rcu_read_unlock() calls invalidate_rcu_protected_refs(), it does
not see STACK_ITER slots with MEM_RCU on the caller's stack, allowing an
RCU-protected iterator to outlive its RCU section across a sleepable call
before bpf_throw() unwinds the stack and invokes the iterator destructor
(use-after-free).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794399387.gi=
t.memxor@gmail.com?part=3D19
