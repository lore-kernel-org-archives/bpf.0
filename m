Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417206;
	b=qEh5svH8/m5AqARaTvgTcsNpoeeGpJxMZfbf4SszWRfhWVkjMVAL/HZy37vNqKvj+01V
	 DBTAqj2wnC8RG2deEvdmqAhP17jLz40hh4FFJ+9rjQEHq3DNaKPZ1N6PrWJXo5xEk8x1T
	 wnnQSXPFDsKFzP/Pgh2lSpynq9l2lumPUgskPbVmp3nSRQYOoNw99+6d0Hwd1EBoyCtcq
	 nLt1DvCpAKv2EJzRmqvdmn/a4v7MZMyesalHyi2QwI+Bj3fi/xdNjc3vEP7KqZGygiMGp
	 S5cVMhPyjJ/9cLQUE8A6P1Xm37B4Wb3MfoXuX3AcgWpaF4FfWYfsjK8/79faPV1IoiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417206;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4urN7bnI+kME9EWfBrwswN9c/1kLV016NFOvuONLt6g=;
	b=cEKNDtnVgrUawfHnX/giQuYdKk3bbeW0Kl3U765hUSYt/j3E2ljA+JfS5JJkMQ6uUWlP
	 CYyATfHgKstCDLzWZKw+Y6qlu6DNCAFoGXTzv8kgJtXKiqtRHerhjbPNc5L0KcqiAX5rm
	 CyZY2rn02pMhCUSdVkmCUYduVoXbElFLg+bu5lulh09wIRhCLWiG35KhkFcyQh5M8F//h
	 SLofGilBKaBG4mv+PeVusyAa81aFWVNj0ay8ZHTUyVj37Z4TYAJrXqqAFvfC5GqnvjrJM
	 zXAlWOxLuWCoLIk9HUnN1SkR4cU5fYHlEOWyzKKhJoPthoKHHm9jUFlvzTrmeCrhq3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZZiIDHsD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C62606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZZiIDHsD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598961F00A06;
	Wed, 11 Nov 2026 17:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417205;
	bh=4urN7bnI+kME9EWfBrwswN9c/1kLV016NFOvuONLt6g=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ZZiIDHsD+JN1l7LfNRHZEc43YinwJHCN9Vg88wYUwRL15JREDanw3l4d5NBjn5DJT
	 hORlYpSLKN5l8pPPjTmxkiblrR45snGgH3Tr5M7OF+2f2MukJ2QwYsPay/Qxaikyvp
	 Otl9E99VG5LQzhfNZLiSCD4l1gk7DLLcJXq8DPPlGw32/FCE7lonoQZJhg/D3mk40v
	 E9xszPmj5ktL1bwhLTECAIZwau7rFlprV8BNFvakXdovH6UtpOpEzxypzf0BkegFVu
	 yMsFp3/yB1t3T3sr0RrVcn/dLFs4hnT4xX7AuadpCCGCi6rcrWWt1s3LQPOmZwOgEu
	 /tqg6/3N1/82g==
Message-ID: <sashiko-outbox-209387@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 21/29] bpf: Support callx when a callee
 releases resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <0847523e18df54ccf22c46885001d309841a60c2.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
 <0847523e18df54ccf22c46885001d309841a60c2.1794399387.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 17:13:24 +0000
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
- [High] bpf: resource leak via bypassed lent check in
  bpf_frame_desc_record_callx()
- [Medium] bpf: hidden slot cleared without release in
  bpf_frame_desc_record_callx()
--

commit 10ca45cf5c85b803527fe102c801dcc6b5d2cc99
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Support callx when a callee releases resources

This commit extends frame descriptor tracking to support callx instructions
whose target subprogs transfer or release caller-held resources, rejecting
programs when targets disagree on whether an argument reference is consumed.

> diff --git a/kernel/bpf/frame_desc.c b/kernel/bpf/frame_desc.c
> index 6679f134b14ee..11b2546bc179f 100644
> --- a/kernel/bpf/frame_desc.c
> +++ b/kernel/bpf/frame_desc.c
[ ... ]
> @@ -981,6 +983,56 @@ int bpf_frame_desc_record_call(struct bpf_verifier_e=
nv *env, struct bpf_verifier
>  	return 0;
>  }
> =20
> +/*
> + * The callx at insn @callsite of the current frame calls @subprog, one =
of the
> + * subprogs it may call. What the frame puts in front of the callx runs
> + * whichever it calls: the insns that take what it hands over out of its=
 slot,
> + * and the one that empties the slot of what a callee releases without b=
eing
> + * handed it, see foreign_cleared(). So note what this subprog leaves wi=
th the
> + * frame:
> + *
> + *  - What the frame holds and passes it in an argument that it does not
> + *    release through. Another subprog may be handed it in that argument=
, and
> + *    the slot would be emptied for this one as well, see slot_can_be_ke=
pt().
> + *  - All that the frame holds, when the subprog releases nothing of its
> + *    callers'. It is not verified in their context then, so its return =
has
> + *    no frame to say so, see bpf_frame_desc_record_exit().
> + */
> +int bpf_frame_desc_record_callx(struct bpf_verifier_env *env, int subpro=
g, int callsite)
> +{
> +	const struct bpf_subprog_info *sub =3D &env->subprog_info[subprog];
> +	struct bpf_verifier_state *st =3D env->cur_state;
> +	const struct bpf_func_state *frame =3D st->frame[st->curframe];
> +	const struct bpf_reference_state *ref;
> +	struct bpf_res_call *c;
> +	int i, k;
> +	u8 lent;
> +	s16 adj;
> +
> +	if (!env->describe_frames || st->speculative)
> +		return 0;
> +	for (i =3D 0; i < st->acquired_refs; i++) {
> +		ref =3D &st->refs[i];
> +		if (ref->frameno !=3D st->curframe || !ref->acq)
> +			continue;
> +		lent =3D 0;
> +		for (k =3D BPF_REG_1; k <=3D BPF_REG_5; k++)
> +			if (!(sub->consumes & BIT(k)) && ref->type =3D=3D REF_TYPE_PTR &&
> +			    !(env->res_acqs[ref->acq - 1].flags & BPF_RES_F_ARG) &&
> +			    reg_ref_off(&frame->regs[k], ref->id, &adj))
> +				lent |=3D BIT(k);

[Severity: High]
Can a caller's hidden slot still be cleared before a callx to a subprog that
does not consume Rk, leaking the reference on a later bpf_throw()?

When one target of a callx consumes Rk, emit_release() emits instructions
before the callx that compare the 64-bit runtime value of Rk with the calle=
r's
hidden slot and zero the slot if they match.  However,
bpf_frame_desc_record_callx() only sets BIT(k) in lent when reg_ref_off()
succeeds in the verifier state at the callx.

If another path reaches the same callx to invoke a non-consuming subprog wh=
ile
Rk still holds the handle address at runtime, but its verifier state fails
reg_ref_off() (for instance, Rk is NOT_INIT after merging with a path that =
did
not set Rk, or after an earlier call to a no-op subprog cleared caller-saved
registers in the verifier while leaving Rk intact in hardware), BIT(k) is n=
ot
set in c->lent.  slot_can_be_kept() then accepts the program, the pre-callx
sequence zeroes the caller's hidden slot at runtime before the non-consuming
subprog runs, and a subsequent bpf_throw() fails to release the resource.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1f41095f4f1fa..51896b2001614 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11451,9 +11451,10 @@ static int setup_func_entry(struct bpf_verifier_=
env *env, int subprog, int calls
>  	err =3D set_callee_state_cb(env, caller, callee, callsite);
>  	if (err)
>  		goto err_out;
> -	/* a plain call hands the callee what it releases of the caller's, see =
frame_desc.c */
> +	/* the call of a subprog hands it what it releases of the caller's, see=
 frame_desc.c */
>  	err =3D bpf_frame_desc_record_call(env, set_callee_state_cb =3D=3D set_=
callee_state &&
> -					 bpf_pseudo_call(&env->prog->insnsi[callsite]) ? state : NULL,
> +					 (bpf_pseudo_call(&env->prog->insnsi[callsite]) ||
> +					  bpf_is_callx(&env->prog->insnsi[callsite])) ? state : NULL,
>  					 callee, callsite);

[Severity: Medium]
What happens if a callx invokes a subprog with sub->consumes & BIT(k) set o=
n a
path where Rk holds the runtime address of a caller-held reference without
satisfying reg_ref_off()?

Because sub->consumes & BIT(k) is set, bpf_frame_desc_record_callx() skips =
Rk.
In bpf_frame_desc_record_call(), if one callx path passes the caller's
reference in Rk (recording rel_add() at callsite, with the callee releasing=
 it
without needing its own hidden slot) and a second path passes the same runt=
ime
pointer in Rk in a form that fails reg_ref_off() (such as a pointer with a
variable offset in [0, 1] that is 0 at runtime, or an untrusted pointer from
bpf_rdonly_cast()) on a branch where the callee does not release it,
bpf_frame_desc_record_call() only sets sub->entry_none |=3D BIT(k) and leav=
es
the reference with the caller.

Because the callee's BPF_RES_F_ENTRY acquisition does not need a hidden slot
of its own, bpf_frame_desc_resolve() never checks sub->entry_none, and
handed_back is not set on exit.  The emit_release() instructions placed bef=
ore
the callx still zero the caller's hidden slot at runtime on the second path,
leaking the reference if the caller later throws.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794399387.gi=
t.memxor@gmail.com?part=3D21
