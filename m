Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D07D3BF69D
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 21:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779831100; cv=none; b=C5Y9+505bo8c7jSuo5RLgW00w8KmaFM6YqDN3zO9FUNvANREpJ5qHBvgcdwo0wUv7yA7vPMX5lUHLKo1reCUweNVed37IX8eLR7HXGh6celgc1iRaJ2ne00wCNfirTqEeo1ExW4X50aN2LRuRtNBhLb9UNPCXdJhj6OES6cjVOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779831100; c=relaxed/simple;
	bh=AinUUBCBRe6Yo8LqHraeHPBtKvE7FSTiImxnhk70Lp8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YZfCwh4MYpIyJf/acHsbRki57LCiWp08Qy6yoVbi2ZQO1+MforyUJ+xX3CoUyysEtSZKeGrXrl63QEyu4TEybOdOIxYMFJABebDzEt/QQGtGCIhS3MOCTBKG7cdBNKvY+gP5oB/QcMHzgzGTX1UPs0dGmSfoCAmh2ARe9ta8Jyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/cWg+qI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/cWg+qI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382441F000E9;
	Tue, 26 May 2026 21:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779831097;
	bh=k3tmpVTqJiZ2+Z7a6j8VnENLTAkQa+/az/tvXUJGn0s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l/cWg+qIzacMh2/xyOXjQJJuocrLLVXDsF71iLK2AQKUJHnSnoZ3+wz0ucipjJscx
	 hIfle8jJs/KMaR6bh3U+h/bpR8iXLTdSw0iRn9o1lbm0TftXHf5ablDskx2m8LVxNA
	 i4Ah4UxT5n3rS0FS/OrRZvftfmFhqmN9u/4p+rC4+ydVY68iSpqE5pSmkkYhxHUCeL
	 7il6JMAe9kbY5pGgyrw+zPSK+8i9faNqJg64txQtFzyCvIJlJfskO4rVWh9JCPvZ18
	 gYK5bHE/g07RsQhw8aGW2WKjVk/pSii29/eRWZTqFUQjdeTExTwJWCy4PO+/x6rHc5
	 n17CMqOgAA5sA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next v2 5/6] bpf: report register diff summary
 for hot callchains
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260526-better-1m-reporting-v2-5-e7ec61c45d41@gmail.com>
References: <20260526-better-1m-reporting-v2-5-e7ec61c45d41@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 21:31:36 +0000
Message-Id: <20260526213137.382441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] O(N^2) state comparisons without cond_resched() can cause CPU lock=
ups
- [Medium] callchain_matches_state() does not check the leaf instruction in=
dex
- [Medium] print_hotspots() failure masks the primary -E2BIG complexity lim=
it error
- [Low] Integer overflow in state_diff_cmp sorting function
--

commit 33b39095313d5bead6d88744178c2d3f55d7b64b
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: report register diff summary for hot callchains

This commit introduces a feature to report the most frequently varying
locations (registers or stack slots) when a hot callchain ends. It modifies
states_equal() to identify the first differing location between states and
counts occurrences across explored states to approximate a diff summary.

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 8773381360095..79e76bc2d1712 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
[ ... ]
> @@ -1588,3 +1629,98 @@ int bpf_is_state_visited(struct bpf_verifier_env *=
env, int insn_idx)
>  	list_add(&new_sl->node, head);
>  	return 0;
>  }
> +
> +static bool callchain_matches_state(struct bpf_callchain *cc,
> +				    struct bpf_verifier_state *st)
> +{
> +	int i;
> +
> +	if (st->curframe !=3D cc->curframe)
> +		return false;
> +	for (i =3D 0; i < (int)cc->curframe; i++)
> +		if (st->frame[i + 1]->callsite !=3D cc->insn_idx[i])
> +			return false;
> +	return true;
> +}

[Severity: Medium]
Does this function need to verify the leaf instruction index=20
(st->insn_idx =3D=3D cc->insn_idx[cc->curframe])?=20

States for different instructions can hash to the same bucket via=20
(insn_idx ^ callsite) % env->prog->len. Without checking the leaf
instruction, a hash collision could cause states from different instructions
to be incorrectly matched, violating assumptions in func_states_equal()
which relies on live_regs_before for a specific instruction.

> +
> +struct state_diff_cnt {
> +	struct bpf_state_diff diff;
> +	u32 cnt;
> +};
> +
> +static int state_diff_cmp(const void *a, const void *b)
> +{
> +	return ((struct state_diff_cnt *)b)->cnt - ((struct state_diff_cnt *)a)=
->cnt;
> +}

[Severity: Low]
Can this subtraction overflow?=20

The cnt fields are unsigned 32-bit integers, and the function returns a
signed 32-bit integer. If the difference exceeds INT_MAX, the subtraction
will overflow into a negative value, resulting in an inverted sort order.

> +
> +static bool state_diff_eq(struct bpf_state_diff *a, struct bpf_state_dif=
f *b)
> +{
> +	return a->frame =3D=3D b->frame && a->slot =3D=3D b->slot && a->kind =
=3D=3D b->kind;
> +}
> +
> +int bpf_sample_state_diffs(struct bpf_verifier_env *env,
> +			   struct bpf_callchain *cc,
> +			   struct bpf_state_diff *top_diffs,
> +			   int *nr_diffs)
> +{
> +	struct bpf_verifier_state_list *sl_i, *sl_j;
> +	struct state_diff_cnt *diff_cnts =3D NULL;
> +	struct list_head *pos_i, *pos_j, *head;
> +	u32 leaf_insn, callsite, hash_idx;
> +	int i, cap =3D 0, nr_locs =3D 0;
> +
> +	leaf_insn =3D cc->insn_idx[cc->curframe];
> +	callsite =3D cc->curframe > 0 ? cc->insn_idx[cc->curframe - 1] : BPF_MA=
IN_FUNC;
> +	hash_idx =3D (leaf_insn ^ callsite) % env->prog->len;
> +	head =3D &env->explored_states[hash_idx];
> +
> +	list_for_each(pos_i, head) {
> +		sl_i =3D container_of(pos_i, struct bpf_verifier_state_list, node);
> +		if (!callchain_matches_state(cc, &sl_i->state))
> +			continue;
> +		list_for_each(pos_j, head) {
> +			struct bpf_state_diff diff =3D {};
> +
> +			if (pos_i =3D=3D pos_j)
> +				continue;
> +			sl_j =3D container_of(pos_j, struct bpf_verifier_state_list, node);
> +			if (!callchain_matches_state(cc, &sl_j->state))
> +				continue;
> +			if (states_equal(env, &sl_i->state, &sl_j->state, NOT_EXACT, &diff))

[Severity: High]
Can these nested list_for_each loops cause a CPU soft lockup?=20

A single hash bucket can accumulate tens to hundreds of thousands of cached
states for a single instruction in complex programs. Without cond_resched()
calls within these O(N^2) loops, billions of states_equal() comparisons
could execute, monopolizing the CPU and leading to a local DoS.

[ ... ]
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 54b7ad65b7fc1..d09c014462f13 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -17527,7 +17564,9 @@ static int do_check(struct bpf_verifier_env *env)
>  		insn_aux =3D &env->insn_aux_data[env->insn_idx];
> =20
>  		if (++env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
> -			print_hotspots(env);
> +			err =3D print_hotspots(env);
> +			if (err)
> +				return err;

[Severity: Medium]
If print_hotspots() returns an error (like -ENOMEM from kvrealloc()), does
this mask the primary -E2BIG complexity limit error?=20

Returning err directly will skip logging "BPF program is too large" and
return a misleading error code to the user, who might attribute it to system
memory exhaustion instead of hitting the verifier complexity limit.

>  			verbose(env,
>  				"BPF program is too large. Processed %d insn\n",
>  				env->insn_processed);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-better-1m-=
reporting-v2-0-e7ec61c45d41@gmail.com?part=3D5
