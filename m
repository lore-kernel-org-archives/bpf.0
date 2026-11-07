Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025098;
	b=I+NsKf9wjPk6UrrLy7eTnfRkY4HNRppMbwC9rSq7hxv4ciXV8xRIY7zFRkld3bxbpIgW
	 pXX/FJJHyx6uIfqN8nMGEXXjgeCbkQ2lx8CJSJ7+2UqszWaiSNQSAVHfTDr5UL2zZNfrZ
	 c3HZKBYo1XUKvp0LL9Tsz15qx2lv98216mJWslky9pF9bYMDno4NtCFBCgzXn/BF/GrjT
	 PlgapuPkLpZIeJ25kDN7TuB69vYfk3U49wsGM3M9C/NBhJ41O49Rw+gEAMTMbaiQCFnme
	 ANOFfADfqRwUEqCKwSGyNIZ8tmy56IEq8zEdq7vy9O929KrTyqs3bqzL2Z+BZx8+4Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025098;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=e4Ds/1y9A+6liBSgSvzId9S8zWIcGC5v6MFCRZU43/0=;
	b=B2ShvFfqzClSujC4/TU8QbQxf76+FhOxP4BhBT92G7jfQOIvJVnXBezon41LrsCBZv3R
	 EIK/cxY7WJCqWgkTIIDNm2Ha0dpO7QVGY6ovlsZEgEE7Qh4tlqkcBae37ayhCZC8zWPWP
	 ZlH+vDuwVOZsnM2fyM8iz47HhWVwg1Gi0AVHeo0ejCwLI9xyFWpM15C3Qlg7HvWm3GMao
	 VisrUqLliNh100r9Ila6aACV1t9lxo4VTnJinHIoJS30Mb6G+cY2FjUKJBVSH6VMLq5ru
	 4FrSee8BgtDsPw+OcHbIbsH/biF1JlKQ4pEoy8UgMJlpLe2FmPTWBJa03QRmMNwJGaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R52hsszF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69878606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 04:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R52hsszF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00901F008A1;
	Sat,  7 Nov 2026 04:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794025097;
	bh=e4Ds/1y9A+6liBSgSvzId9S8zWIcGC5v6MFCRZU43/0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=R52hsszFYobWCplW7c18xa0q65gH8FYO79OT1UIKLZChjy8PvuOT+Syt0KpecHIPT
	 dBxZsQOs7A7TsbZxodaRc7nC9SNm1dhFwHqIRAzS9l4iHJ4nZGTFyI0WLzjgrBv8Lb
	 lquPQbhf7GENZ5q7Ekc0a0h/ncNpitvB8MS10mKJ4c0rm92HaFS8jfi2prcHsKAZkE
	 FHYssmDtESqmRjyof8yim0VrQaGI0ipEKPSwmEVgCyuZ7PtdmIxzZdleCZHSOhGGUL
	 YU4upnPYKcKm6XK/FvUfuw9/QjrTVXR/BXV+Y5rT0A54+CUABj6+9MuI6sNSt+jmTF
	 Zl+BWKkw2qw0g==
Message-ID: <sashiko-outbox-202567@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 05/46] bpf: Add join of verifier states
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261107033758.1547725-6-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
 <20261107033758.1547725-6-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 04:18:17 +0000
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
- [Medium] bpf: join_reg() zeroing dst->delta breaks explore_alu_limits
  in join_check()
- [Medium] bpf: asymmetric unallocated and poisoned stack handling in
  join_func()
--

commit 81dc6f947daf4ec051f2b11325ec95b20b615ab2
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Add join of verifier states

This commit completes the state-joining implementation in join.c by adding
frame, reference, loop stack, and whole-state join logic along with a
subsumption check on the resulting state.

> diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
> index fe513b7a8e884..4da051767e1d9 100644
> --- a/kernel/bpf/join.c
> +++ b/kernel/bpf/join.c
> @@ -398,3 +398,250 @@ static bool join_slot(struct bpf_join_state *js, st=
ruct bpf_stack_state *ds,
>  	bpf_mark_reg_not_init(js->env, &ds->spilled_ptr);
>  	return true;
>  }

[ ... ]

> +	nslots_b =3D bpf_stack_nr_slots(fb);
> +	for (i =3D 0; i < bpf_stack_nr_slots(fa); i++) {
> +		const struct bpf_stack_state *sb =3D i < nslots_b ? bpf_stack_slot(fb,=
 i) : NULL;
> +
> +		js->place =3D MAX_BPF_REG + i;
> +		if (!join_slot(js, bpf_stack_slot(fd, i), bpf_stack_slot(fa, i), sb, p=
ass))
> +			return false;
> +	}
> +	js->place =3D -1;
> +	/* Slots that exist only in 'b' are STACK_INVALID in the result. */
> +	for (i =3D bpf_stack_nr_slots(fa); pass =3D=3D 1 && i < nslots_b; i++) {
> +		const struct bpf_stack_state *sb =3D bpf_stack_slot(fb, i);
> +
> +		if (slot_is_special(sb) ||
> +		    (slot_has_spill(sb) && sb->spilled_ptr.type !=3D SCALAR_VALUE))
> +			return false;
> +	}

[Severity: Medium]
When !js->env->allow_uninit_stack, does this loop drop live initialized
stack slots that exist only in fb?

For slots beyond bpf_stack_nr_slots(fa), the loop only rejects special
slots and non-scalar spills.  If fb has a live scalar STACK_SPILL,
STACK_MISC, or STACK_ZERO slot at i >=3D bpf_stack_nr_slots(fa), the join
succeeds (since stacksafe() only checks up to fd->allocated_stack, which is
copied from fa) and leaves slot i unallocated in fd, causing later reads on
path b to fail verification with -EACCES.  When fa and fb are passed in the
opposite order, join_slot() rejects the join at:

kernel/bpf/join.c:join_slot() {
	...
	/* the prog can't read uninitialized stack: slots of different kinds have =
no join */
	if (!js->env->allow_uninit_stack)
		return !memcmp(sa->slot_type, sb->slot_type, sizeof(sa->slot_type));
}

Conversely, when bpf_stack_nr_slots(fa) > bpf_stack_nr_slots(fb) and
bpf_clean_verifier_state() has marked dead slots in fa as STACK_POISON,
join_slot() substitutes invalid_slot (all STACK_INVALID) for the missing
slot in fb, and the memcmp() above rejects the join because STACK_POISON !=
=3D
STACK_INVALID, even though both represent dead/unallocated stack bytes.

[ ... ]

> +/* The result has to describe everything that an input describes */
> +static int join_check(struct bpf_join_state *js, struct bpf_verifier_sta=
te *dst,
> +		      const struct bpf_verifier_state *in, const char *which)
> +{
> +	struct bpf_verifier_env *env =3D js->env;
> +
> +	if (bpf_state_subsumes(env, dst, (struct bpf_verifier_state *)in))
> +		return 0;
> +	/* check_ids() has no room left: that says nothing about the join */
> +	if (env->idmap_scratch.cnt =3D=3D BPF_ID_MAP_SIZE)
> +		return 1;
> +	bpf_log(&env->log, "join:");
> +	print_verifier_state(env, dst, dst->curframe, true);
> +	bpf_log(&env->log, "input %s:", which);
> +	print_verifier_state(env, in, in->curframe, true);
> +	verifier_bug(env, "join of states at insn %u does not subsume input '%s=
'",
> +		     dst->insn_idx, which);
> +	return -EFAULT;
> +}

[Severity: Medium]
Can join_check() trigger a false verifier_bug() when env->explore_alu_limits
is set and join_reg() drops an inconsistent scalar link?

In struct bpf_reg_state, delta lies before id.  In join_reg(), two
SCALAR_VALUE registers with matching non-zero delta and identical ranges
pass reg_value_equal(ra, rb) when js->env->explore_alu_limits is true, but
if their IDs do not form a consistent bijection across the states, pass 2
clears both dst->id and dst->delta:

kernel/bpf/join.c:join_reg() {
	...
	case SCALAR_VALUE:
		if (js->env->explore_alu_limits && !reg_value_equal(ra, rb))
			return false;
		if (pass =3D=3D 1) {
			jid_note(js, ra->id, rb->id, scalar_link_consistent(ra, rb));
			return true;
		}
		join_range(js, dst, ra, rb);
		/* a link that exists on one side only is dropped */
		if (ra->id && !jid_good(js, ra->id, rb->id)) {
			dst->id =3D 0;
			dst->delta =3D 0;
		}
		return true;
}

When join_check() then calls bpf_state_subsumes(), regsafe() checks:

kernel/bpf/states.c:regsafe() {
	...
	case SCALAR_VALUE:
		if (env->explore_alu_limits) {
			/* explore_alu_limits disables tnum_in() and range_within()
			 * logic and requires everything to be strict
			 */
			return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) =3D=3D 0 &&
			       check_scalar_ids(rold->id, rcur->id, idmap);
		}
}

Because dst->delta is now 0 while the input register still has a non-zero
delta, memcmp() fails and join_check() hits verifier_bug() and returns
-EFAULT.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107033758.1547=
725-1-alexei.starovoitov@gmail.com?part=3D5
