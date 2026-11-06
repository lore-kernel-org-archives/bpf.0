Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939157;
	b=txkg136C+kKs6U8F+n8H9OUIenEOow3i1QJ/Jre8HTnpWYq00DFeARvBdyozutPe4NIr
	 EEJyWCr43k9Lzgh9BouGBsR+8M9+bH1yadN0717nOhRzDWWChYofd0XnHHA32yLZ8yS+3
	 3Z64r1n/MfpB+Eh0uYOjgzZVbVZ2ch0a13msB3ofarZ+/FA9LTPfImvrRF1C30x4CTzx3
	 2uHr4HRwd6tSaJQF+/7n7V5Cn1vwVdkhHodlJCkZye0cH3sLs/c0ZhXjtIxW1z4BVK0XM
	 SH0pwO0LNbKGh5bQQhNw7IeUmvk+wrDmc30+FP4aD/w4/HFuxXVtgJGPVvuwm3lxduQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939157;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cCY6hNVQJFK89SsysKQuAmCQuLX90zeOHtaAr1LFwGg=;
	b=nGLShwha2g/86xmNLp+i40TiY4r1DxBHaC9cLJrC1w+nVLWQlQP/jd1GFvc9aZFdS3C+
	 MBCBZis8uyjn8Ltbn+WlQfd9tacMsRf1ZZsYNXod/XoMiD0ZcX3yo3nyv0/CzEvNWjsld
	 sl5nmk/5S3fbE6O1HrItvhBfXN9m3vW2q7XcMPipC6M04wZfI2JiXRoT/4HKAYuLGP0gO
	 hv9nfCc05Fd4MZgtv3SZKqNZJ3FF1C7MzIs6Qyh8w5Y8rJRiTQQRhv/TKXDAuT69Yof5v
	 g72NWIITt9q+Z8jWq90h4K79JrP3aP/1ZgxFh6bfbgjk37Lvk7dbgwUvgrQh7RPxh1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+ZKZInp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621C3606A328
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+ZKZInp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4AF1F0089F;
	Fri,  6 Nov 2026 04:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793939157;
	bh=cCY6hNVQJFK89SsysKQuAmCQuLX90zeOHtaAr1LFwGg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=F+ZKZInpNRefJv6oy93MgNch7KGoFW0oN8VPNUrbBTS0Z8sD8pbCK/RC4JfHiaff4
	 xhblHI9U6+n3vUyUUfKAl3p/sjWaWBh2TqHMS//JRZOtsCNRB/gapJWR1GfagqhSRR
	 yGYn07EcBbS718xruiV0SzSg4HNv36x8n8SKOfaQ6Bqz5/Z8j82qWDJxBYvmj6wDhy
	 XoFJBl1qUyxrHEioiQpzwxDJI+y5rl65Y40FRclI403jA2tKu2iPLSqgwe80mts16O
	 17Kdhxv0sWv5ONaqgPjyvCTBLx6RUGgs5JxJ5tS8ZpoPkdFP7hniskdGDBXtY3ubiW
	 apOshX/DEP6aQ==
Message-ID: <sashiko-outbox-200717@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 05/45] bpf: Add join of verifier states
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261106035111.3315285-6-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
 <20261106035111.3315285-6-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 04:25:56 +0000
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
- [Medium] bpf: asymmetric unallocated and poisoned stack handling in join_=
func()
- [Medium] bpf: join_reg() zeroing dst->delta breaks explore_alu_limits in =
join_check()
- [Medium] bpf: asymmetric out_stack_arg_cnt check in join_func() blocks va=
lid joins
--

commit 1d1d176d0db968688ddcdf9cb26ad2c24d9339f4
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Add join of verifier states

This commit adds the second half of kernel/bpf/join.c and enables building =
it.
It implements bpf_states_join() to merge two verifier states frame by frame=
 at
a single instruction and verifies that the joined state subsumes both input=
s.

> diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
> index fe513b7a8e884..4da051767e1d9 100644
> --- a/kernel/bpf/join.c
> +++ b/kernel/bpf/join.c
> @@ -398,3 +398,250 @@ static bool join_slot(struct bpf_join_state *js, st=
ruct bpf_stack_state *ds,
>  	bpf_mark_reg_not_init(js->env, &ds->spilled_ptr);
>  	return true;
>  }
> +

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
As reported by Sashiko on v2 [1], how does bpf_states_join() -> join_func()=
 ->
join_slot() handle stack slots when !env->allow_uninit_stack?

First, in the loop over slots that exist only in fb (for i >=3D
bpf_stack_nr_slots(fa)), join_func() only rejects special slots and non-sca=
lar
spills, without checking !js->env->allow_uninit_stack. If fb has a live
initialized slot at i >=3D bpf_stack_nr_slots(fa) (such as a scalar STACK_S=
PILL,
STACK_MISC, or STACK_ZERO) while fa has allocated_stack <=3D i * 8, the join
succeeds and leaves slot i unallocated in fd. If the program later reads sl=
ot
i under a condition that only holds along path b, won't
check_stack_slot_within_bounds() falsely reject a valid program with -EACCES
when !env->allow_uninit_stack?

Second, when bpf_clean_verifier_state() marks dead stack slots in fa as
STACK_POISON via __clean_func_state(), and slot i is unallocated in fb (so
join_slot() substitutes invalid_slot with STACK_INVALID), join_slot() runs:

	if (!js->env->allow_uninit_stack)
		return !memcmp(sa->slot_type, sb->slot_type, sizeof(sa->slot_type));

Won't memcmp() treat dead STACK_POISON bytes in sa and unallocated
STACK_INVALID bytes in sb as unequal, causing dead stack slots to prevent a
join when !env->allow_uninit_stack?

> +
> +	if (fa->out_stack_arg_cnt < fb->out_stack_arg_cnt)
> +		return false;

[Severity: Medium]
As reported by Sashiko on v2 [2], should join_func() reject the join whenev=
er
fa->out_stack_arg_cnt < fb->out_stack_arg_cnt?

Since out_stack_arg_cnt is an allocation high-water mark grown by
grow_stack_arg_slots() in check_stack_arg_write(), it is not reset to 0 when
invalidate_outgoing_stack_args() or bpf_flow_return() marks
stack_arg_regs[0..out_stack_arg_cnt - 1] as NOT_INIT after a call returns.

If state a reaches a loop header or branch target before any call with stack
arguments (fa->out_stack_arg_cnt =3D=3D 0) and state b arrives after a call=
 with
stack arguments whose slots are now NOT_INIT (fb->out_stack_arg_cnt > 0),
won't this check prevent joining or widening the states even though slots at
i >=3D fa->out_stack_arg_cnt are implicitly NOT_INIT in fa and fd?

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
As reported by Sashiko on v2 [3], can bpf_states_join() trigger verifier_bu=
g()
in join_check() when env->explore_alu_limits is true?

In join_reg() for SCALAR_VALUE:

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

Two SCALAR_VALUE registers ra and rb with equal ranges and the same non-zero
delta pass reg_value_equal(ra, rb). If their IDs do not form a valid biject=
ion
across the state (so jid_good(js, ra->id, rb->id) is false in pass 2),
join_reg() clears dst->id =3D 0 and dst->delta =3D 0.

When join_check() subsequently calls bpf_state_subsumes() -> states_equal()=
 ->
func_states_equal() -> regsafe(), regsafe() checks:

	if (env->explore_alu_limits) {
		return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) =3D=3D 0 &&
		       check_scalar_ids(rold->id, rcur->id, idmap);
	}

Because delta lies before id in struct bpf_reg_state, won't memcmp() fail w=
hen
comparing dst->delta (0) against ra->delta (non-zero), causing join_check()=
 to
hit verifier_bug() and return -EFAULT?

[1] https://lore.kernel.org/r/20261105204513.2230344-6-alexei.starovoitov@g=
mail.com
[2] https://lore.kernel.org/r/20261105204513.2230344-6-alexei.starovoitov@g=
mail.com
[3] https://lore.kernel.org/r/20261105204513.2230344-6-alexei.starovoitov@g=
mail.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106035111.3315=
285-1-alexei.starovoitov@gmail.com?part=3D5
