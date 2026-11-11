Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415319;
	b=rXUt4g7RDPkCA1u0NZsKaRJ4RMnsMME+atp+8opCDBP1IapGYheZ3OICA/SRryLVukCb
	 UNrGYgqEcbk7ITMm2YV6Sn1z4KoS1DCL66Fzob2Y35UI0uxdbQ6fSn/Dhv+O85ROazghR
	 oJ5LriGOQ20i1q2pfkc/X3GivcAuHPUrL26QbPElEM/09Y8jbt+afuslm8h+dki4nKn3l
	 6LUHFt0GoUnx8KcKquqxke+OzF/iK0oFKgoRuR8yBtXHrMnN3n1mRok6v/u5cK30hkxp8
	 KXviE1YFqBfWjb3+PH+4hBBdC9URURDV8louJr+KHPegzBvmfbTcIRn71eazKmVBsAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415319;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3wJVaWAxdyPeBxxRAWmSpeAfYmXVujhCIZBWJUL6Z9k=;
	b=p5M6b1f8MDF9AEkx08Nrwd6FRQe/5WLGwesJXUNq3v3DTByA3wmGH5si/F9WZ1I//1sw
	 XIj+mIDFq/WGtj+gUGdUFM6DpRyxVK260eUs9WlkxgZAkeaLq1lgv9BEslH/fbPkMEjyS
	 1/qRMRejR5e7n4ioaAY00SLwjOctWdYKYWBd57Z9CuLCDix8qjHxuhcBshcLkRds0fjpl
	 nCXO0T8k69yXyuwzxGpaTXci1jnVvkBDqr7S2yt7uI5X2Wy3yc86SMpV4kenM7Kurg+LF
	 z72FidYMnPnkJa0i+yOaXDnfgDkaJrmz20qzx6L2pWKC5IHrp+7N9JnVPkeIhzcwxPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VhdGDvv0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C96C606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VhdGDvv0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3BF1F00A08;
	Wed, 11 Nov 2026 16:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415319;
	bh=3wJVaWAxdyPeBxxRAWmSpeAfYmXVujhCIZBWJUL6Z9k=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=VhdGDvv04DqhkLkA6tQO3Byz9FjS5XkPzrHft2DR8TVDnK2EiiSWOc7ZuWkd+OWEM
	 /9hib4kx7F3GU/dJ/kLHF0Gtdso9qglhI7apdUa+AbID9DWTkjGohuPEWsPT4auwVL
	 cMmBhRAgZRmgkYnDL6irVzpMkrEBjDbp6ri3bntp0jBxACKCpf6qY3aeLvxn+XQJ0C
	 ypR4XGqTgoSpSHLDigSKL0lD7uneuQSnzeb+MaJziyeyPA5GmQaLUu45F7s5x4skVj
	 KsPntailRl+bAtluyNmXLC7JC77sGwYmd8XGBxvRVbhDccJ1JOurtxlcz0vPAo1jBX
	 FeXkal9DRNQzQ==
Message-ID: <sashiko-outbox-209307@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 18/29] bpf: Allow a callee to leave
 resources with its caller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <6d427c6ccc0de0dcfa3e0cb95bd66e9d71c2074b.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
 <6d427c6ccc0de0dcfa3e0cb95bd66e9d71c2074b.1794399387.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 16:41:58 +0000
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
- [High] bpf: cross-frame unwind ordering bug in
  bpf_frame_desc_record_acquire()
- [Medium] bpf: multi-resource tracking bypass in
  bpf_frame_desc_record_return()
--

commit 48230df87bf3a57835f6fce92009993e3192e84d
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Allow a callee to leave resources with its caller

This commit allows BPF subprograms in programs that throw to leave held
resources, caller-stack objects, or RCU and preemption section deltas with
their caller unless a hidden stack slot is required to track them.

> diff --git a/kernel/bpf/frame_desc.c b/kernel/bpf/frame_desc.c
> index 0ef7fda410ee1..9854be9ab4781 100644
> --- a/kernel/bpf/frame_desc.c
> +++ b/kernel/bpf/frame_desc.c
[ ... ]
> @@ -547,30 +554,37 @@ int bpf_frame_desc_record_acquire(struct bpf_verifi=
er_env *env, int idx, int reg
>  	/* no insns can put it into a slot then: R10 stands for no register */
>  	if (regno < BPF_REG_0 || regno > BPF_REG_5)
>  		regno =3D BPF_REG_FP;
>  	acq =3D acq_add(env, env->insn_idx, res, regno, flags, adj, obj_off);
> -	return acq < 0 ? acq : ref_set_acq(env, st, idx, acq);
> +	if (acq < 0)
> +		return acq;
> +	/*
> +	 * A stack object is held by the frame that has it in its stack, which
> +	 * its sites find it in: the slot of a callee that created it there
> +	 * would be gone with the callee.
> +	 */
> +	if (owner !=3D st->curframe) {
> +		ref->frameno =3D owner;
> +		if (!env->res_acqs[acq].elsewhere)
> +			env->res_acqs[acq].elsewhere =3D env->insn_idx + 1;
> +	}
> +	return ref_set_acq(env, st, idx, acq);
>  }

[Severity: High]
Can assigning ref->frameno =3D owner here reverse the unwind release order
when the callee throws before returning?

In bpf_unwind_release_frame(), the ordering passes (releasing
BPF_FRAME_ENT_FIRST iterators and file dynptrs before regular objects in
BPF_UNWIND_PHASE_OBJS, and restoring disabled IRQ flags before enabled IRQ
flags in BPF_UNWIND_PHASE_LOCKS) run per frame as the unwinder walks from
the innermost callee frame to the outermost caller frame:

kernel/bpf/unwind.c:bpf_unwind_release_frame() {
    ...
	for (pass =3D 0; pass < passes; pass++) {
		for (first =3D 1; first >=3D 0; first--) {
			bpf_unwind_release_desc(ctx, pool, d, fp, first, pass);
			bpf_unwind_release_desc(ctx, pool, site, fp, first, pass);
		}
	}
}

If a callee acquires a referenced object (such as a cgroup via
bpf_cgroup_from_id()) in its own frame, initializes a borrowing iterator
(such as bpf_iter_css_task_new()) on the caller's stack, and throws before
returning, the callee frame is unwound first and drops the backing cgroup
reference before the caller frame unwinds and destroys the iterator,
causing a use-after-free.  Similarly, if a callee saves IRQ flags on its
own stack while interrupts are enabled and then saves nested IRQ flags on
the caller's stack while interrupts are disabled before throwing, unwinding
the callee frame first enables interrupts and unwinding the caller frame
second restores the disabled state, leaving local CPU interrupts disabled.

[ ... ]

> @@ -748,71 +762,89 @@ int bpf_frame_desc_record_section(struct bpf_verifi=
er_env *env, u8 kind, s8 delt
[ ... ]
>  int bpf_frame_desc_record_return(struct bpf_verifier_env *env, struct bp=
f_verifier_state *st,
>  				 int idx, int callsite, const struct bpf_reg_state *r0)
>  {
>  	struct bpf_reference_state *ref;
> +	struct bpf_res_acq *held;
>  	s16 adj =3D 0;
>  	int acq;
> =20
>  	if (!env->describe_frames || st->speculative)
>  		return 0;
>  	ref =3D idx < 0 ? NULL : &st->refs[idx];
> -	if (!ref || !ref->res) {
> -		if (r0->type !=3D SCALAR_VALUE || !tnum_equals_const(r0->var_off, 0))
> -			env->insn_aux_data[callsite].res_none =3D true;
> -		return 0;
> +	if (ref && !ref->res)
> +		ref =3D NULL;
> +	if (ref && ref->type =3D=3D REF_TYPE_PTR && ref->id &&
> +	    !(env->res_acqs[ref->acq - 1].flags & BPF_RES_F_ARG) &&
> +	    reg_ref_off(r0, ref->id, &adj)) {
> +		acq =3D acq_add(env, callsite, ref->res - 1, BPF_REG_0, 0, adj, 0);
> +		return acq < 0 ? acq : ref_set_acq(env, st, idx, acq);
>  	}
> -	if (!reg_ref_off(r0, ref->id, &adj)) {
> -		verbose(env, "frame_desc: the subprog called at insn %d returns holdin=
g what R0 does not carry, which is not supported in a program that throws\n=
",
> -			callsite);
> -		return -EINVAL;
> +	if (r0->type !=3D SCALAR_VALUE || !tnum_equals_const(r0->var_off, 0))
> +		env->insn_aux_data[callsite].res_none =3D true;
> +	if (ref) {
> +		held =3D &env->res_acqs[ref->acq - 1];
> +		if (!held->elsewhere)
> +			held->elsewhere =3D callsite + 1;
>  	}
> -	acq =3D acq_add(env, callsite, ref->res - 1, BPF_REG_0, 0, adj, 0);
> -	return acq < 0 ? acq : ref_set_acq(env, st, idx, acq);
> +	return 0;
>  }

[Severity: Medium]
When a subprog returns holding a non-R0 resource, does
bpf_frame_desc_record_return() miss setting held->multi if the caller frame
already holds a resource from the same acquisition?

If a caller invokes a lock-taking subprog twice, the first lock's
ref->frameno is already updated to the caller when the second call runs
ref_set_acq() in the callee frame, so ref_set_acq() does not set
env->res_acqs[acq].multi.  When the second call returns, the caller frame
holds two references with the same ref->acq, and in site_visit() both
references match the same env->res_locs[j] entry and increment loc->visits
twice for a single increment of site->visits:

kernel/bpf/frame_desc.c:site_visit() {
    ...
		for (j =3D 0; j < env->res_loc_cnt; j++)
			if (env->res_locs[j].site =3D=3D s && env->res_locs[j].acq =3D=3D ref->a=
cq - 1)
				break;
		if (j =3D=3D env->res_loc_cnt) {
    ...
			cur.visits =3D 1;
			loc[j] =3D cur;
			env->res_loc_cnt =3D j + 1;
			continue;
		}
		/* the places this visit finds the handle in as well */
		loc =3D &env->res_locs[j];
		loc->visits++;
}

If the resource has loc->fixed set (such as a resilient spin lock in a
1-element array map acquired via two distinct map-lookup pointers on one
path) and another path reaches the same throw site holding neither,
site->visits (2) equals loc->visits (2) with loc->cnt =3D=3D 1, so
bpf_frame_desc_resolve() leaves a->slot false, skips the a->elsewhere and
a->multi checks, and emits a site descriptor that unlocks an unheld lock if
the second path throws.  Calling ref_set_acq(env, st, idx, ref->acq - 1) on
the non-R0 return path and checking a->multi even when !a->slot would catch
this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794399387.gi=
t.memxor@gmail.com?part=3D18
