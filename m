Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C76741D103
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 12:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547707; cv=none; b=TYd6o7OV5IpzEmAI3o7uYFpKsOfXUGOIlOV0h/uOrwtYs7t4AKlPuuNib3DzibwmGq4gG4cmV3T9go5YiebrRHKENfj73IgBw+K1P1RrVJynLMePyFthPM4+hqB1Apejg7D38Nnmj5gTfQN5X73Qw66SXp/ulLFTsnJvGu6ryos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547707; c=relaxed/simple;
	bh=bTkUDBTqkMR1dBFmEnhlUUmTiS+JtlMqaIWOoJtgals=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=PzveLFZpXnMD5D/XnjAHOI2kRyBagOw8CrJ3nE6bvZDE/E1dZx3oqe+9nc4kP0gxvlB8D/+35rKoVI5kfrh3jYrQkDOpVY+/6lZZfLy6XNv+JdAt2NgMXXx/ergunVeCHvirUvpAboNH+yguTEGXT2PiIPki6+f/GYhnir1uYE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOst67Qd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOst67Qd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D381F000FF;
	Fri,  9 Oct 2026 12:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791547698;
	bh=ODrTLw0B1i/92F9RVHk9QY7sseuVnL4PaD1fUMoViHM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fOst67QdtPIouxwvaEoEESSbhbF5o7113j0U6iNO/DS34Pe25pYfWzwyu16WeIqil
	 XRXxCFRf48UtQpOtBO9GKqPWRfnEsJHG8FhR+nN1E7Ttp7xpCZ9iZmoTA5Dzt5Nmff
	 DbvNbERH1Xnt5IGk3nhkX3csJQIxRgps+UIWF20NxU1MvUFsvJ49n7ZQFr1KpvUxuU
	 dzKPVwxw52y3VeuIRzARQfehocVeh7fS6Ah19pbWCQ2a3zqeA/tPhNxxtB4K+Nz2ia
	 zl3lGs4Q37+qhk19Fz4cOMUr+8BeNkmes7jiU7eBBv+XocdY6MM6y0H9R30u4tYb75
	 JjZm5SVp4Kv/A==
Message-ID: <sashiko-outbox-165481@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 35/51] bpf: avoid widening registers that
 hinder exact stack-slot tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009-scev-minimal-rebase-v3-35-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
 <20261009-scev-minimal-rebase-v3-35-bcba9bc53ac9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 12:08:17 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: call_params_mask clobbers callee-saved registers for kfuncs=
 with >5 args
- [Medium] bpf: bpf_needs_fixed_stack_off ignores module kfuncs and stack d=
ynptrs
--

commit c21aed6872d1b94060c148c7501830216020d7e4
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: avoid widening registers that hinder exact stack-slot tracking

This commit adds logic to avoid widening registers used by stack-accessing
instructions during SCEV-based loop analysis. This prevents replacing
constant-offset stack accesses with varying-offset accesses, preserving
verifier precision for spills, fills, and calls requiring fixed stack
offsets.

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index 05dd8e439609b..adad32d8cb124 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c
[ ... ]
> @@ -1100,6 +1100,70 @@ static void reset_scevs_at_indirect_writes(struct =
bpf_verifier_env *env, struct
[ ... ]
> +/* Mask of argument registers (R1..R5) a call at 'idx' passes by registe=
r. */
> +static u16 call_params_mask(struct bpf_verifier_env *env, int idx)
> +{
> +	struct bpf_insn *insn =3D &env->prog->insnsi[idx];
> +	struct bpf_call_summary cs;
> +	int n =3D bpf_get_call_summary(env, insn, &cs) ? cs.arg_slot_cnt : MAX_=
BPF_FUNC_REG_ARGS;
> +
> +	return n ? GENMASK(BPF_REG_1 + n - 1, BPF_REG_1) : 0;
> +}

[Severity: Medium]
Does this code overflow the bitmask into callee-saved registers when a
kfunc takes arguments on the stack?

bpf_get_call_summary() returns the total number of arguments in
cs.arg_slot_cnt, which can exceed 5 (MAX_BPF_FUNC_REG_ARGS) for kfuncs
that accept stack arguments.

Since GENMASK(BPF_REG_1 + n - 1, BPF_REG_1) does not cap 'n', an 'n'
greater than 5 will set bits for callee-saved registers (R6-R10).

If one of these unrelated registers happens to hold a stack pointer,
collect_store_base_regs() might erroneously record it as a base register
for the call. This could falsely prevent SCEV from widening unrelated
loops, causing the verifier to unnecessarily unroll the loop and
potentially hit complexity limits.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a597a8c189723..2f190abe34489 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -14257,6 +14257,55 @@ static bool kfunc_spin_allowed(struct bpf_verifi=
er_env *env, s32 func_id, s16 of
[ ... ]
> +bool bpf_needs_fixed_stack_off(struct bpf_verifier_env *env, int insn_id=
x)
> +{
> +	const struct bpf_insn *insn =3D &env->prog->insnsi[insn_idx];
[ ... ]
> +	/* Both initialized and uninitialized stack dynptrs need a fixed offset=
. */
> +	for (i =3D 0; i < ARRAY_SIZE(fn->arg_type); i++)
> +		if (arg_type_is_dynptr(fn->arg_type[i]))
> +			return true;

[Severity: Medium]
Does this loop miss dynptrs that are passed on the stack?

Because fn->arg_type is strictly bounded to 5 elements, this iteration
will skip checking a dynptr if it is passed as a 6th argument (or later)
on the stack.

If missed, collect_store_base_regs() fails to record the base registers,
allowing the SCEV pass to widen the stack pointer and turn its constant
offset into a variable range. The verifier will then reject the dynptr
call because it strictly enforces a constant offset.

> +
> +	/* vmlinux kfuncs only */
> +	if (!bpf_pseudo_kfunc_call(insn) || insn->off !=3D 0)
> +		return false;

[Severity: Medium]
Will this check skip BPF module iterators?

By returning false if insn->off !=3D 0, this explicitly ignores any kfuncs
exposed by BPF modules. Modules can provide their own iterators (like
bpf_iter_testmod_seq_new with KF_ITER_NEW).

Similar to the dynptr issue above, skipping these iterators means the
base registers won't be recorded. This causes the stack pointer to be
widened and leads to valid programs utilizing module iterators being
falsely rejected by the verifier.

> +	btf_id =3D insn->imm;
> +
> +	flags =3D btf_kfunc_flags(btf_vmlinux, btf_id, env->prog);
> +	if (flags && (*flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY)))
> +		return true;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-scev-minim=
al-rebase-v3-0-bcba9bc53ac9@gmail.com?part=3D35
