Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794117767;
	b=jKDhajpqd5CwUdiohCqX/K5WXmyjCpAMw0+csjhvtv1ymFPq287mJrh3cX9wqsyFkxlV
	 0yMf2D1ep/ros4MRptOquuBPV6qw5YHOZkLBaiG6OdVyXVoAIsnnQ5PU/aBiPKZCvyYIH
	 DgyY6dFqcnBrd2MS3F9CRaO0CnDWvwC2PDHnJH+2mKCSy6Vu5KEisH4eAisrxfUlq0M0W
	 C7+fwnueWx4dmqCDQN6sdv5iNQWPPwAH2NufbXbuk1SV7zhJq0x57qqBkbKKp83/pKWMi
	 yXzakA+u1nJpELPe67SfxLyXjBHSBk2YtzfxOlFLY5fAwBOPFF0ZohKo4uEnZ8FyWUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794117767;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UuTezmgm0nwGJO0HrodwpRqkq+69BJc87Weux93Kal4=;
	b=V3A3odMO31DMQG4wCNXAzVqtqLr555bXn5m8tLV+BpflT9iXcuhJZOj2qw60KKcEz3xK
	 2dsmGAw/F7UfzJMX/JBfQE4tbkmwblgaGePXL0/IdCUHZvJzutbB3lUWth66VnfQ1+kVF
	 un3jueXF+U51RPocbvkK3QEru+19n+PUrEXUYHc6qBM7v47L0JNoD9CtWen2pIkHSRP8a
	 ZY3dWc2Qb2D3VQFziGXxwOK7lB5H7JWWBuMZurY/o0GtEslBiVfWyE5lq17WtsbDDIh5W
	 USY3Yh2DKniicuLFtBKpnFYZsnLBFDWt9CGABNWniYKpRLJ1xYGVlanrvs5MJdGo5Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=evNrMhPH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1C6606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 06:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=evNrMhPH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6911F0089F;
	Sun,  8 Nov 2026 06:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794117766;
	bh=UuTezmgm0nwGJO0HrodwpRqkq+69BJc87Weux93Kal4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=evNrMhPHvhYJxZxKRBE6yF4F5ONTFFj/IDGk7BCx7T4MD0o+haAxFgBuGDtdtd6fD
	 B952mdQczbrPdLjMtpRDU0uP+gyLO4VcKGtt7e5/yS83+Jgd5sv6pJxidBGMqzbXVN
	 OLf7XRgxhBm3xhEHOJbMFUt4FQLO6mdYWK0y0RQWkpjZ6zThQluZCxNFPCrwGvbUHH
	 ZRLEZv/Bulu0WZdl825+2VBekLiOt3nZSdm2zy41kcpdVF9D9s7Dk2lPACDbpVVKOg
	 oLZcl9Qe+dEea6XL39THP+cBSyYlSbc7jZuwAZcMZ1fsYlH7Aso20O+42SErV/79gv
	 Mv9X52PEhblFw==
Message-ID: <sashiko-outbox-203594@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] bpf: Keep one basic block in the level 1
 log and print the way to it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261108053937.4134138-3-alexei.starovoitov@gmail.com>
References: <20261108053937.4134138-1-alexei.starovoitov@gmail.com>
 <20261108053937.4134138-3-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 06:02:45 +0000
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
- [Medium] bpf: preserve flow->from across subprogram calls in
  bpf_flow_call()
- [Low] bpf: clear env->prev_log_pos when resetting level 1 log in
  do_check()
--

commit 436e80edd288c8e9b5661dd9e9cfd3aca7f99381
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Keep one basic block in the level 1 log and print the way to it

This commit rewinds the level 1 verifier log before each basic block and
reconstructs and prints the path of basic blocks leading to a rejected block
on verification failure.

> diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
> index e6d1817ffa57d..c9458b3ad114a 100644
> --- a/kernel/bpf/flow.c
> +++ b/kernel/bpf/flow.c
[ ... ]
> @@ -2883,6 +2886,7 @@ static struct flow_state *flow_new_state(struct bpf=
_verifier_env *env, int prev_
>  		return NULL;
>  	s->prev_insn_idx =3D prev_insn_idx;
>  	s->seq =3D ++flow->seq;
> +	s->from =3D flow->from;
>  	env->total_states++;
>  	flow->live_states++;
>  	env->peak_states =3D max(env->peak_states, flow->live_states);
> @@ -3308,8 +3312,11 @@ int bpf_flow_next(struct bpf_verifier_env *env, in=
t *prev_insn_idx)
> =20
>  	env->insn_idx =3D s->st.insn_idx;
>  	*prev_insn_idx =3D s->prev_insn_idx;
> -	if (test_bit(s->st.insn_idx, flow->keep))
> +	if (test_bit(s->st.insn_idx, flow->keep)) {
> +		flow->from =3D s->seq;
>  		return bpf_copy_verifier_state(env->cur_state, &s->st);
> +	}
> +	flow->from =3D s->from;
>  	*env->cur_state =3D s->st;
>  	memset(&s->st, 0, sizeof(s->st));
>  	s->st.insn_idx =3D env->insn_idx;
> @@ -3317,3 +3324,89 @@ int bpf_flow_next(struct bpf_verifier_env *env, in=
t *prev_insn_idx)
>  	flow_free_state(env, s);
>  	return 0;
>  }
> +
> +/* A basic block on the way to the block that is rejected, up to the ins=
n that leads on */
> +struct flow_step {
> +	const struct flow_state *s;	/* the state at its head, if one is kept */
> +	int head, last;
> +};
> +
> +/*
> + * The state at @head with that @seq. If it is gone a state that came la=
ter took its place:
> + * the last one then.
> + */
> +static const struct flow_state *flow_find_state(const struct bpf_flow *f=
low, int head, u32 seq)
> +{
> +	const struct list_head *list =3D &flow->states[head].list;
> +	const struct flow_state *s;
> +
> +	if (!test_bit(head, flow->keep))
> +		return NULL;
> +	list_for_each_entry(s, list, node)
> +		if (s->seq =3D=3D seq)
> +			return s;
> +	return list_empty(list) ? NULL : list_last_entry(list, struct flow_stat=
e, node);
> +}

[Severity: Medium]
Does flow_find_state() look up the caller's basic block with a callee seque=
nce
number after a call to a static subprogram that is verified on its own?

When bpf_flow_call() parks the waiting caller state w, it does not save
w->from =3D flow->from.  Verifying the callee then overwrites flow->from wi=
th
the callee's kept state sequence numbers, and flow_apply_exit() creates the
resumed caller state at call_idx + 1 (or call_idx) via flow_new_state() usi=
ng
that overwritten flow->from:

kernel/bpf/flow.c:flow_apply_exit() {
	...
	if (!err)
		err =3D bpf_flow_deliver(env, &st, call_idx + 1, call_idx);
	bpf_free_verifier_state(&st, false);
	if (err !=3D 1)
		return err;
	...
	s =3D flow_new_state(env, w->st.last_insn_idx);
	...
}

If verification later fails in the caller, bpf_flow_print_way() steps back =
to
call_idx carrying the callee's seq in from.  When multiple states were kept=
 at
the caller's basic block, s->seq =3D=3D seq never matches in flow_find_stat=
e(),
so it falls back to list_last_entry() and prints the wrong state and incomi=
ng
edge for the caller.  Saving flow->from in w->from in bpf_flow_call() and
restoring flow->from =3D w->from in flow_apply_exit() would preserve the
caller's sequence number across the call.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fd333b1063c3d..20b1b9ff574c7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -22049,7 +22057,15 @@ static int do_check(struct bpf_verifier_env *env)
>  			break;
>  		/* What is known about how the state came to be is not kept with it. */
>  		bpf_diag_event_log_restore(env, 0);
> +		/* Neither is the text: the level 1 log has one basic block at a time.=
 */
> +		if (level1) {
> +			bpf_vlog_reset(&env->log, log_pos);
> +			env->prev_linfo =3D NULL;
> +		}

[Severity: Low]
Should this also reset env->prev_log_pos =3D 0 when rewinding env->log?

When a previous function verification pass leaves a small env->prev_log_pos
that happens to match log_pos after do_check_common() prints the "Validating
<func>() func#<n>..." header line for a global subprogram, print_insn_state=
()
on the first instruction of the basic block sees
env->prev_log_pos =3D=3D env->log.end_pos:

kernel/bpf/log.c:print_insn_state() {
	if (env->prev_log_pos && env->prev_log_pos =3D=3D env->log.end_pos) {
		/* remove new line character */
		bpf_vlog_reset(&env->log, env->prev_log_pos - 1);
		verbose(env, "%*c;", bpf_vlog_alignment(env->prev_insn_print_pos), ' ');
	} else {
		verbose(env, "%d:", env->insn_idx);
	}
	...
}

That strips the trailing newline from the "Validating ..." header line and
appends the initial state inline with a semicolon instead of printing
"<insn_idx>:".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108053937.4134=
138-1-alexei.starovoitov@gmail.com?part=3D2
