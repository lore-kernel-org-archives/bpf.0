Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795161658;
	b=wa5wIcx9JRwR/K5v3yPQPi8mHIAdqrr7iE2nVP+ykMl3pNoAronW9JUSdx6uY3W9TiNO
	 RjtjoyJPpdqZ06ohdRS6pugKWFtbGP6k6/19XmUkHdb+md5mE+gLKu1Mcbzl79k2Tcjio
	 sLmpnvL/yJ/mddeLjgyZa9QIfK75Y8sfIZwCQSFOld81Fy5BmiqmSmlubWWr3wnrXgykc
	 jiYCY1hsc7U3FxT2Pih9F4QHRkEjFNAQ6LcM1izdBKZ20Z1bKB2REiIUDz8n3y0x8sG0y
	 xTzduj46qWNAQSe7C1NCO5JO8EwFHA3f/dWvSJiXfUpMe8xnNPYUAEOvueX1RVptLUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795161658;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Hk/Xcg3UjGViGduwXELCLPNgZ110H5oYD1DOTnTWLN4=;
	b=fgJssChh7ZL0M4kov+5EgqRixY4LsaMdhV1evCT0quw+bHh/y+HoHh6M5HjjsFtlZmgi
	 Y5Rt9FewijxpAx4rwfn/csixDZSHdZeSvsm6ysuIBmTXo6Q9KIegcWlFaN8MdQTqJrkAm
	 eCV7Je1RryWCCqK/dwXqOC/951+GRXJC/iT6xpju0BW9U236ySiT3liTp9OaiQ4GE7qrq
	 gwuk0i2KW70gpr7m3xI3fD2uU8WvMzZAe1rO0uk3NYDW/grahBD51vJtomoTIaOcj/jct
	 i3UutIDmNPqAuMFO50h3qwxHIiuMWzojRgri+x5Orq6L9a1GD6uKgDY1YjB6uvnSV9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B9tjpKTt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A9F606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B9tjpKTt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786351F000D0;
	Fri, 20 Nov 2026 08:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795161657;
	bh=Hk/Xcg3UjGViGduwXELCLPNgZ110H5oYD1DOTnTWLN4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=B9tjpKTt+MA0WLDD7vsfDOi41n/thxoz/A5gCOU/x1sSWliHO0rrQt3ESz4cDAiUt
	 TZPBU0/bV/CAfveYELu0GVZiYuIYtrejt9bm4kXMQ9oCkQA2uhzskh4yz5aUd6hbq0
	 A2PvqUN7xsJ/gLOSuVtW36TUORizbazYqDlTwFLw3XSw7K4UQArGtLnXYSlGk400zq
	 T3wsV/Ykfukjn80sq1uWsY5naxkQQBD8HCgCddxlDoiiAB8SeOmD0PfG+CQJDJyFTR
	 mDev39kwX9T5b3yRmJ2f8kzF4I7oC80ajQp12/xq4Rh8j9o8kLUQwo4POG2jYp/QZj
	 EHfjj0DnJFEwg==
Message-ID: <sashiko-outbox-224673@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 05/49] bpf: Limit the cost and the memory of a
 load
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261120074430.2704488-6-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
 <20261120074430.2704488-6-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 08:00:57 +0000
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
- [High] bpf: missing env argument in bpf_free_verifier_state() call in
  free_states()
--

commit ca42d04453901ed3278a751f03b001046243fce1
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Limit the cost and the memory of a load

This commit replaces per-pass verifier complexity caps with load-wide cost
and memory limits, and switches stack liveness function instances from a
hash table to a per-callsite array.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f079435dd25c5..363ba494cb9a3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -1742,11 +1742,27 @@ static void free_func_state(struct bpf_func_state=
 *state)
>  	kfree(state);
>  }
> =20
> -void bpf_free_verifier_state(struct bpf_verifier_state *state,
> -			    bool free_self)
> +/* @st is new or has grown */
> +void bpf_charge_state(struct bpf_verifier_env *env, struct bpf_verifier_=
state *st)
> +{
> +	/* with the struct that holds it */
> +	u32 bytes =3D 2 * sizeof(*st) + ksize(st->refs), fr;
> +	struct bpf_func_state *f;
> +
> +	for (fr =3D 0; fr <=3D st->curframe && (f =3D st->frame[fr]); fr++)
> +		bytes +=3D kmalloc_size_roundup(sizeof(*f)) + ksize(f->stack) +
> +			 ksize(f->stack_arg_regs) + ksize(f->loop_stack);
> +	env->mem +=3D bytes - (s64)st->bytes;
> +	st->bytes =3D bytes;
> +}
> +
> +void bpf_free_verifier_state(struct bpf_verifier_env *env, struct bpf_ve=
rifier_state *state,
> +			     bool free_self)
>  {
>  	int i;
> =20
> +	env->mem -=3D state->bytes;
> +	state->bytes =3D 0;
>  	for (i =3D 0; i <=3D state->curframe; i++) {
>  		free_func_state(state->frame[i]);
>  		state->frame[i] =3D NULL;
[ ... ]
> @@ -22013,7 +22035,7 @@ static void free_states(struct bpf_verifier_env *=
env)
>  {
>  	struct bpf_verifier_stack_elem *elem;
> =20
> -	bpf_free_verifier_state(env->cur_state, true);
> +	bpf_free_verifier_state(env, env->cur_state, true);
>  	env->cur_state =3D NULL;
>  	while ((elem =3D env->head)) {
>  		env->head =3D elem->next;

[Severity: High]
Does the second bpf_free_verifier_state() call in free_states() also need
env passed as its first argument?  Leaving it at two arguments breaks the
build until commit "bpf: Put a barrier where no mask fits" replaces the
loop later in the series:

kernel/bpf/verifier.c:free_states() {
	bpf_free_verifier_state(env, env->cur_state, true);
	env->cur_state =3D NULL;
	while ((elem =3D env->head)) {
		env->head =3D elem->next;
		bpf_free_verifier_state(&elem->st, false);
		kfree(elem);
	}
	bpf_flow_reset(env);
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120074430.2704=
488-1-alexei.starovoitov@gmail.com?part=3D5
