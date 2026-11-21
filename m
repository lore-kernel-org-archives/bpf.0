Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795236368;
	b=VSogEage1guyPv7lH4VAlmPLsRf+ZY4UZCICiMHnzyo6C4kY/mHSEOferbBfUyVKG+Kd
	 TB70I1jRsk5O5fPJ3+lo6FgYpQEbHj4kYxPqb5UgA+eh4Ab3LWT+7VzvFzOEXtPkzpH4V
	 ypyIKJxLeJSZq2f4T1r+gzEm4qCOrO5KuyK0BEji6EgpCJbdMEogTEAP0bOhNDaMvgNuH
	 87hW7jYOznG/ZWdbXENoUXv98+Q/BC4d6+S+7gik+22KDLiWWfZ9lHAkqkYtgoB/DTEsd
	 BfthDHo1S/Qa9jFBYIbiMGGUrjH9BcHJDiGXLFSlmErbgiNtJiUY7ex7+VeRogvA31A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795236368;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U7ulZTntg5dgPIdC+5cJA+BkuwK05zl864zhf3/6FUQ=;
	b=BEVVihz/aVoQLiKXRfoZFGpi/eUnNK8BF/X5QmhsJH40ik00niZnlhvyAm1oARKsZ7QX
	 nS8BRkZZLiFwyosN4g9JFJVmrwuRKceA58qJCHgHZf+mEc+m2HuU5/2vFewG3wjfk0val
	 13e6n4KvPFlOk1p5poi8xCRYu/I6P+aLTTbZB4GKRmalxwVGvammsQpgrhqv3efQpXZbf
	 G7RZd2QblhT9yOtLUmSP1L+wxXVGjxao9kCytQE8+qLp1mXjLUsD+B6kjJqCPxxH2Ttkp
	 BcMybc9F9MMGl48eGjaFOaOn95b1q6WYFEWEnzkEuuaV4l/vilvt5XsV9XiTRBDx61g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lWSpZzrb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65209606A6B3
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 04:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lWSpZzrb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF371F000C0;
	Sat, 21 Nov 2026 04:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795236368;
	bh=U7ulZTntg5dgPIdC+5cJA+BkuwK05zl864zhf3/6FUQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=lWSpZzrbF2qT95aSVZBUpibMapMYu3dCvBAkxMnTHFz/RjBdlheJKk7kXEkSI1BqP
	 wh0Q54RTMHREWMTjpYPInkK5saNNN4waig7UB7zKtS0VTOqRPwF4rmS3YwYoQMaYJo
	 gqqs5aHAqDr7JMOpvhRh20SBnAt5iUur7cAI58B55uo9iCn/Rv2yd/f39AP6HGaOB1
	 1OJVBRSBX84ZbQunrElaQMxlTbIvt5TIshXP/2FTppZL+7nLtnaCG3NGGb4FUOWXV9
	 XjhqWKvyh5Efo9KaDoU1VZmSL1N+XZBEM3pYy4WQueuHkXOyDiIwqD83OeGvtrdKU1
	 3awXWikRSZXEA==
Message-ID: <sashiko-outbox-226643@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 33/49] bpf: Verify a static function once
 for each instance
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261120204959.614908-34-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
 <20261120204959.614908-34-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 04:46:07 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] bpf: uncharged instance cost in flow_grow_instance() after
  first instance
- [Medium] bpf: missing FLOW_AGAIN kind on re-queued call state in
  flow_apply_exit()
- [Medium] bpf: missed non-NULL marking for returned parent_id in
  bpf_flow_return()
--

commit 086da59f5b2496a96c0c9a8141af31c675e376ed
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Verify a static function once for each instance

This commit verifies static subprograms that do not depend on caller frames
once per instance, joining call states only at the subprogram entry point
and dividing a verification budget among functions with multiple instances.

> diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
> index c10fa54cdf91b..b5d65dd2d07a2 100644
> --- a/kernel/bpf/flow.c
> +++ b/kernel/bpf/flow.c
[ ... ]
> @@ -1345,6 +1358,301 @@ int bpf_flow_deliver(struct bpf_verifier_env *env=
, struct bpf_verifier_state *st
>  	return flow_add(env, s, false);
>  }
> =20
> +/* @x is an exit state of the instance of the call @w. @w can leave the =
instance. */
> +static int flow_apply_exit(struct bpf_verifier_env *env, struct flow_sta=
te *w,
> +			   struct flow_state *x)
> +{
> +	int call_idx =3D w->st.insn_idx, err;
> +	struct bpf_verifier_state st =3D {};
> +
> +	err =3D bpf_copy_verifier_state(env, &st, &w->st) ?:
> +	      bpf_flow_return(env, &st, &x->st, call_idx);
> +	if (!err)
> +		err =3D bpf_flow_deliver(env, &st, call_idx + 1, call_idx, false);
> +	else if (err < 0 && st.speculative)
> +		err =3D min(bpf_flow_edge_unproven(env, &st, call_idx + 1, err), 0);
> +	else if (err < 0)
> +		err =3D min(bpf_flow_edge_unproven(env, &x->st, x->prev_insn_idx, err)=
, 0);
> +	bpf_free_verifier_state(env, &st, false);
> +	if (err <=3D 0)
> +		return err;
> +
> +	/* The call is checked again in the frames of the caller */
> +	flow_unlink(env, w);
> +	flow_find(env, w);
> +	flow_link(env, w);
> +	return 0;
> +}

[Severity: Medium]
Should flow_apply_exit() set w->kind =3D FLOW_AGAIN before re-linking w, the
same way bpf_flow_deliver() does when again is true?

w was allocated with w->kind =3D=3D FLOW_AT after passing pre-instruction j=
oin
and flow_keep() handling at call_idx, and after do_check_insn() mutated the
state for the call (such as check_func_callx_set() clearing reg->func_set
and setting reg->subprogno to one subprogram from the set).  When
bpf_flow_return() returns BPF_EXIT_NEEDS_CALLER and w is re-inserted into
state_tree as FLOW_AT at a join point, flow_prune_or_join() can join w with
other states at call_idx (clobbering a split callx target register to
NOT_INIT) and flow_keep() does not take its FLOW_AGAIN early return,
re-running flow_keep_peeled() if call_idx is a peeled loop header.

[ ... ]

> +/* @s gets to the first insn. @t is there and does not subsume @s. */
> +static int flow_grow_instance(struct bpf_verifier_env *env, struct flow_=
state *t,
> +			      struct flow_state *s, struct bpf_loop *leftover_loop)
> +{
> +	u64 args =3D flow_readable_args(t->st.frame[0]);
> +	struct flow_instance *old =3D t->started_instance, *instance =3D old;
> +	int err;
> +
> +	if (!old->entry_state) {
> +		instance =3D flow_new_instance(env, t);
> +		if (!instance)
> +			return -ENOMEM;
> +		instance->cost =3D old->cost;
> +	}

[Severity: Medium]
Does copying instance->cost =3D old->cost leave the new instance uncharged
when old is the first instance of the subprogram?

In bpf_flow_call(), the first instance is free, so (*cost)++ increments
env->flow->cost[subprog] from 0 to 1 while leaving
t->started_instance->cost as NULL.  When that first instance has already
started (!old->entry_state) and a later call grows it into a second
instance here, instance->cost is also set to NULL and budget_func_cnt is
not incremented, so bpf_flow_next() never charges the cost of the grown
instances to env->flow->cost[subprog] and flow_may_add_instance() never
throttles them.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fac44fceccfbf..58a483fed88be 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -11700,6 +11706,9 @@ int bpf_flow_return(struct bpf_verifier_env *env,=
 struct bpf_verifier_state *cal
>  		reg->id =3D returned_id(reg->id);
>  		reg->parent_id =3D returned_id(reg->parent_id);
>  		reg->map_uid =3D returned_id(reg->map_uid);
> +		/* the function saw that a reference of the caller is not NULL */
> +		if (reg->id && !type_may_be_null(reg->type))
> +			mark_ptr_or_null_regs(caller, ret_regs[i], false);
>  	}
>  	return 0;
>  }

[Severity: Medium]
What if the callee checks a caller reference n for NULL and returns a
non-NULL child pointer derived from it, where reg->parent_id carries n's
reference ID and reg->id is 0?

For example, a recursive static subprogram verified on its own can take an
inherited PTR_MAYBE_NULL reference n, check if (!n) bpf_throw(), and return
a PTR_TRUSTED member loaded from n (which sets reg->parent_id to n's
reference ID in check_ptr_to_btf_access() while reg->id is 0).  Because
only reg->id is checked here, n in the caller keeps PTR_MAYBE_NULL; if the
caller then tests if (!n), mark_ptr_or_null_regs() drops n from
caller->refs[] via release_reference_nomark() without invalidating the
returned child register whose parent_id still refers to n.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120204959.6149=
08-1-alexei.starovoitov@gmail.com?part=3D33
