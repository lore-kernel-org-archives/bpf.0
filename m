Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794026927;
	b=n9gmVQ/YrHRLaxP/TEJ4fEw3PFLkRm10brMNB6esO3yesfLJPykkXmveo6jsaR5GhsV5
	 6m86AIlBamhNJuNKftOLM+5afXbwjFyRFEp4Es6s6ZCUmK0WL7E85fLWNofXNnOmYQbdg
	 WOiOC8E+2j9wW5/mM4tFEh+BIdLhdemftunUaIsTcwAeeZYpQERnzoa7vmvxdD2SU6vTV
	 9+HruVOssFIFgSTmoMLdPy4NgJUeBdisZpO6oQiYSxAWNccpY0EuzhKBsp94bDZij3kkE
	 REltLxwXt8OwBvwwj4imJ6wIyiYw5F+y4XbtLgcIrBn2rXHOkZMY6nxEmkgejUj1m2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794026927;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=W2x28yBDWH4YAnb0qPsGUozFGkg7BCUx2k5NO7DLYUo=;
	b=OK6G9M9b1WOK/lN6plPwK6ywStYiYxFA5gDzgK23eoBZQvoRAE0SBD/z6xED1FtIOzl1
	 Qn3eIhymNpg4Nip+jmzDFesliS0/JrinH4tirFZZ2bRYSfXrWkYV8bLUFAgJAPUgMa44W
	 0Hv/OapoAqizOvEeTyxJ+dhqP696DziL4NDhvlZ8kvIxQuIY3kM/TNUk+BIXZwXmmDqDL
	 dOBeZs0un8tPPM3gw0IZpYKg8PpHDnlz///mfy8r5D0YJx7ivkq2hEzRzbAdBr3Aq5PHb
	 rQwLLinjYxg3uQR3GWxe9D8LkXcrOsJjYWDrUgbevNaH19yPEze+eirsTIAdGZaRscA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oww0BMjq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381FB606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 04:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oww0BMjq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79EA1F0089F;
	Sat,  7 Nov 2026 04:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794026926;
	bh=W2x28yBDWH4YAnb0qPsGUozFGkg7BCUx2k5NO7DLYUo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Oww0BMjq2PgGGiuiXyFCM8GAH4h/T+jTwJHpjIQa1+ZGCSAwstGxnQg+rH1WLT8SD
	 zOU+DEVH9r84lAv+xXFhuBAtgKJ59yQyegBh3ekz0TgEtFJMVXQFNrTilipp/P0jqx
	 xHuSDq8k6KLuF3J8mRNXrA7IvhaIqKYv/3GNZY0r2mHjtmq1HtYJCaeeWoJ8Z6LGYM
	 dwt6CwBHJ/BKU4ajmP4ecgt8ntz30Sx+867Zy6fuwuvq9i0cMzO6wAVbM8Rn78bKzE
	 SBFqede6oMix6pq4hbOVunZb7jk6ANr+KeSGjczI9aEonTDXOLyHp2ScFGZYpmKvX0
	 jRngf8cprfq6g==
Message-ID: <sashiko-outbox-202593@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 22/46] bpf: Allow recursive subprogs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261107033758.1547725-23-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
 <20261107033758.1547725-23-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 04:48:46 +0000
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
- [Medium] bpf: off-by-one frame count for recursion in
  compute_call_depth()
- [Medium] bpf: spurious budget exit on loop back-edge in
  check_recursion_guard()
--

commit 7c6074f7480e70a1121bc45054dfaf6385da6057
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Allow recursive subprogs

This commit allows recursive static subprograms by detecting cycles in the
call graph, bounding their static stack accounting, and verifying the
runtime recursion guard exit path.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3c3d1c8ea4529..ef68796c04ddf 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -6143,11 +6175,17 @@ static void compute_call_depth(struct bpf_verifie=
r_env *env, struct bpf_call_gra
>  		for_each_set_bit(s, cg->live, cg->cnt) {
>  			if (dinfo[s].depth < 0)
>  				continue;
> -			depth =3D dinfo[s].depth + subprog_stack_size(env, s);
> -			arena_depth =3D dinfo[s].arena_depth + si[s].arena_stack_depth;
>  			for_each_set_bit(j, subprog_calls(cg, s), cg->cnt) {
>  				callee =3D &dinfo[j];
> -				frame =3D bpf_subprog_is_global(env, j) ? 0 : dinfo[s].frame + 1;
> +				depth =3D dinfo[s].depth;
> +				arena_depth =3D dinfo[s].arena_depth;
> +				if (!si[s].recursive || !si[j].recursive) {
> +					depth +=3D subprog_stack_size(env, s);
> +					arena_depth +=3D si[s].arena_stack_depth;
> +				}
> +				frame =3D dinfo[s].frame + !si[j].recursive;
> +				if (bpf_subprog_is_global(env, j))
> +					frame =3D 0;

[Severity: Medium]
Should this increment frame by (!si[s].recursive || !si[j].recursive),
matching the depth and arena_depth calculation above?

When a non-recursive subprogram s calls a recursive subprogram j,
!si[j].recursive is 0, so entering the recursion does not increment
dinfo[j].frame and edges within the recursion also add 0.  A recursion
therefore counts as 0 frames instead of 1 in dinfo[].frame, allowing a
static call chain with recursive subprograms to bypass the MAX_CALL_FRAMES
and MAX_CALL_FRAMES_INTERP checks in check_call_depth().

[ ... ]

> @@ -22106,6 +22294,21 @@ static int flow_drain(struct bpf_verifier_env *e=
nv)
>  	return err;
>  }
> =20
> +/*
> + * A subprog on a cycle of the call graph checks the stack at run time, =
see
> + * bpf_insert_recursion_checks(). When there is no room, or the time sli=
ce is over, it leaves
> + * at once with 0 in place of the result: it unwinds if it can, see bail=
_unwinds, otherwise
> + * it returns and callers have to be fine with that.
> + */
> +static int check_recursion_guard(struct bpf_verifier_env *env)
> +{
> +	struct bpf_subprog_info *sub =3D &env->subprog_info[cur_func(env)->subp=
rogno];
> +
> +	if (!sub->recursive || env->insn_idx !=3D sub->start)
> +		return 0;
> +	return push_budget_exit(env);
> +}

[Severity: Medium]
Does check_recursion_guard() push a spurious exit when sub->start is also a
loop header reached via an intra-subprogram back-edge?

In bpf_insert_recursion_checks(), bpf_patch_list_insert() redirects only
calls to the runtime recursion check, while intra-subprogram jumps to
sub->start land after the check.  Here, check_recursion_guard() calls
push_budget_exit() every time env->insn_idx =3D=3D sub->start without check=
ing
whether the state just entered the subprogram or looped back from inside
it.  If a loop headed at sub->start holds a reference, lock, or RCU read
lock across the back-edge, that branch reaches sub->bail_insn with the
resource still held and causes the verifier to reject the program.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107033758.1547=
725-1-alexei.starovoitov@gmail.com?part=3D22
