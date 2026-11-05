Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914822;
	b=J4WNB/3jHrOR1L2wIpfcl1+8ANDBDjqt20DQPCFjbWuA6rz9VHvX/lB2bxMll7zQLxl4
	 D0KzwTfGaG9OEguFSdNuF9k56ybvyThsFhXZuL8r5w8lu5iIGj15dJsLU9YpDWKCl2+/3
	 aelQJcZp3OzPcZW7Y31YxHBG63vr4yqCHxw+9793uTcruh04W5AYo9Tg+TFYzboUDFJfu
	 0NX+TWm3fczzWSo5FU23Nnhme/Wp8ZVoc+gqx0GDvPrbXCF50H8arlv63UCOizPALxkqw
	 kzZh24nSnGCzCmerL9Ltnhz0L9XJR9qfOelCNReRaFWmzB+0p9muP9o803WIZc6ZQZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914822;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Kza0UrgoLAHVi0TxF2LFJO+Blpx/tMzWpgOyCD0SczQ=;
	b=ydlE/vAmbGOAvqvz9xT9PBADBxATJl4yGxLQYkHiOY7DMKvrTI66tlhP33v06S2j5qhG
	 oCaj4hXGv0ss6RRnT68kYYQJ9Ulc2ij6hGrE2rqEFqgIDgYaPaSotjhR7lYxWEwUKkuxo
	 sKBzrBCRkCVG7Zq7dde4q+BIxyl2WmsikFQkNbqJWgzGPyUBKJ/l2fAuXGX2OZtMwBIY/
	 eVpW4XkrqQTstoEenUxouwdWpHmtplxsCknRpLDrCkYgAdceEfBGiLkLwuh4xeru2Cmov
	 1aM0rgxcHf7OLV5KQn9mGepepp7/rUt8CL2wV3+QEg+ENq+JSAvMEvsnJKS5h1mSY2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ip8NjVy2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE5A606A330
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ip8NjVy2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAE71F0089F;
	Thu,  5 Nov 2026 21:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914822;
	bh=Kza0UrgoLAHVi0TxF2LFJO+Blpx/tMzWpgOyCD0SczQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ip8NjVy2o0GKn6TTYXmp3OtjO9128tznIKo0Jkk6O6XlHY4RVhod17PAfR8vwNhtl
	 1bZwlif16XqHpbIQhghQ93rl760sB3UkDMinSxPrEkPK+tHC8FM5Ax2x1B1UvaOYd+
	 a2092V7F8gNjrua0YDmD7CJDYBpFGnPfRj3DdsoluvlfywvjkREllLOsnwqBgWbFr+
	 XgGT+pIDZULyaZQersUUtTfphUxlRUt0stgeidO2YxCjP8dmH2rCSNOzpNmVaxA2j6
	 JsI2pjmv+/3x946C84feygp6bdsgY19+VDlf02kuUqjZUnrT6DReICXyTVOn2SL0c/
	 r1wh1RPpGagrA==
Message-ID: <sashiko-outbox-200254@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 05/35] bpf: Add join of verifier states
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261105204513.2230344-6-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
 <20261105204513.2230344-6-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:40:22 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] bpf: join_reg() zeroing dst->delta breaks explore_alu_limits in =
join_check()
- [Medium] bpf: asymmetric unallocated and poisoned stack handling in join_=
func()
- [Medium] bpf: asymmetric out_stack_arg_cnt check in join_func() blocks va=
lid joins
--

commit c295ead9d4bf38d9324eb911d159793936c6f2a1
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Add join of verifier states

This commit adds the second half of kernel/bpf/join.c and builds it to
implement bpf_states_join(), which joins two BPF verifier states frame by
frame at an instruction and verifies that the joined state subsumes both
inputs.

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
> +static bool join_func(struct bpf_join_state *js, struct bpf_func_state *=
fd,
> +		      const struct bpf_func_state *fa, const struct bpf_func_state *fb,
> +		      u16 live_regs, int pass)
> +{
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
When !js->env->allow_uninit_stack (for programs loaded without CAP_PERFMON),
can this stack slot handling in join_func() and join_slot() cause asymmetric
behavior depending on which state has the larger allocated_stack?

First, when bpf_stack_nr_slots(fa) < bpf_stack_nr_slots(fb), the loop over
slots i in [bpf_stack_nr_slots(fa), nslots_b) only rejects special slots and
non-scalar spills:

	for (i =3D bpf_stack_nr_slots(fa); pass =3D=3D 1 && i < nslots_b; i++) {
		const struct bpf_stack_state *sb =3D bpf_stack_slot(fb, i);

		if (slot_is_special(sb) ||
		    (slot_has_spill(sb) && sb->spilled_ptr.type !=3D SCALAR_VALUE))
			return false;
	}

If fb has a live initialized slot at i >=3D bpf_stack_nr_slots(fa) (such as=
 a
scalar STACK_SPILL, STACK_MISC, or STACK_ZERO) while fa has not allocated
that slot, bpf_states_join() succeeds and leaves slot i unallocated in fd.
If a later path predicated on the branch that came from fb reads fp - (i + =
1)
* 8, check_stack_slot_within_bounds() will reject the valid program with
-EACCES because fd->allocated_stack is too small and !env->allow_uninit_sta=
ck.

Second, when bpf_stack_nr_slots(fa) > bpf_stack_nr_slots(fb),
bpf_clean_verifier_state() marks dead stack slots in fa as STACK_POISON
without growing fb->allocated_stack. For i >=3D nslots_b, join_func() passes
sb =3D NULL into join_slot(), which substitutes invalid_slot (all
STACK_INVALID) and checks:

	if (!js->env->allow_uninit_stack)
		return !memcmp(sa->slot_type, sb->slot_type, sizeof(sa->slot_type));

Because memcmp() treats STACK_POISON in sa and STACK_INVALID in invalid_slot
as unequal, dead stack slots in fa prevent joining the two states.

Should join_slot() treat stype_is_invalid() bytes (STACK_INVALID and
STACK_POISON) as equivalent when !js->env->allow_uninit_stack, and should t=
he
trailing loop in join_func() also reject non-invalid slots in fb when
!js->env->allow_uninit_stack?

> +
> +	if (fa->out_stack_arg_cnt < fb->out_stack_arg_cnt)
> +		return false;

[Severity: Medium]
Why does join_func() reject the join when fa->out_stack_arg_cnt <
fb->out_stack_arg_cnt?

In check_stack_arg_write(), grow_stack_arg_slots() grows out_stack_arg_cnt =
as
a high-water mark, and invalidate_outgoing_stack_args() or bpf_flow_return()
marks stack_arg_regs[0..out_stack_arg_cnt - 1] as NOT_INIT after a call
without resetting out_stack_arg_cnt to 0.

If state a reaches a loop header or join point before any call with stack
arguments (fa->out_stack_arg_cnt =3D=3D 0) and state b arrives after callin=
g a
function with stack arguments (fb->out_stack_arg_cnt > 0, with all slots
NOT_INIT), fa->out_stack_arg_cnt < fb->out_stack_arg_cnt prevents joining or
widening the two states.

Since slots beyond fa->out_stack_arg_cnt are implicitly NOT_INIT in both fa
and fd (and stack_arg_safe() in bpf_state_subsumes() already accepts that),
could join_func() allow fa->out_stack_arg_cnt < fb->out_stack_arg_cnt when
the extra slots in fb are NOT_INIT or incoming?

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
Can join_check() trigger a false verifier_bug() and return -EFAULT when
env->explore_alu_limits is enabled and join_reg() drops an inconsistent
scalar ID link?

In kernel/bpf/join.c:join_reg():

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

When env->explore_alu_limits is true and two SCALAR_VALUE registers ra and =
rb
have identical value ranges and the same non-zero delta (from BPF_ADD_CONST=
64
or BPF_ADD_CONST32), reg_value_equal(ra, rb) succeeds because memcmp(ra, rb,
offsetof(struct bpf_reg_state, id)) is 0.

If their IDs do not form a valid bijection across the state, jid_good(js,
ra->id, rb->id) returns false in pass 2, and join_reg() sets dst->id =3D 0 =
and
dst->delta =3D 0.

However, delta is located before id in struct bpf_reg_state. When
bpf_states_join() then calls join_check() -> bpf_state_subsumes() ->
states_equal() -> func_states_equal() -> regsafe(), regsafe() checks:

	case SCALAR_VALUE:
		if (env->explore_alu_limits) {
			return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) =3D=3D 0 &&
			       check_scalar_ids(rold->id, rcur->id, idmap);
		}

Because rold->delta (dst->delta =3D=3D 0) no longer matches rcur->delta
(ra->delta !=3D 0), memcmp() fails, causing join_check() to fire verifier_b=
ug()
and fail verification with -EFAULT.

Should join_reg() return false in pass 2 when js->env->explore_alu_limits is
set and dst->delta would be cleared alongside dst->id?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105204513.2230=
344-1-alexei.starovoitov@gmail.com?part=3D5
