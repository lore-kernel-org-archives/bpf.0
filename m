Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795162942;
	b=4dqIkoGa/EVwhcxnIAP/+I5wMY7Dpp/Gdoh87x03oNPM0YgBMNbQdg/wbQhCYu5JpPWw
	 RX8HQAPtdMpMPBwfzAuTSsV+qs696E6Be92I9cULoBLgcXnH2XvZE9JB2Hm9qgvxho0jb
	 wdBO70jeYkY1ifMW1K3ZYzFgM0glnQr/FT03HKqlS1DKvaGgMA6RMEW0Yyim5EeXrnzEU
	 yA2VTaMxjv4G+qyWAG1mwqlbkf0u0kxT7idFjYokgl0ElVZ4OANPwx8PseblfX1D3oUbc
	 Q+rXfeBiT15MuIXYqN/xq61DHSzjwXsTSFC7J6GjOTV5pC+PcqIDKiVZDjJOw+F3kbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162942;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1boC+djJOeiEzNGTOC6jjTSbZYCD/ysQEZ/6nxAS2ig=;
	b=1VOx+7Xe/4wdL2bx4XLHffQDlH2geJ8wpHRcI43+rClWYd2JJEU+RIl+DMuDS/jRlK3R
	 LJetjJHzS+DRbBkeVbZH6JAx/jpng4zeNuVryTAAYc7vcUMRe/PRVowdpKbBcJ95bnEzy
	 XZPToOagr5W5Cl9yTaN0TRv1qtaGQjYYn51TA3RuibN7SXtylBFYivKf2qtM4CtZdI3tG
	 pvc9PMQo1wdZkuhx2wlwC3b/J3sYta1YlxkJ8uM7RvfnfboFhnzY+rsSdM/4RI06zwiFG
	 yQoS1bnAkgRzzuGIUMvYuAnvmZZrtwZCZF8s8yXtc1wZHMKYLXnC1ZcOvWL+k/OnceA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QVVu6ijJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D9B606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QVVu6ijJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE241F000D3;
	Fri, 20 Nov 2026 08:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795162942;
	bh=1boC+djJOeiEzNGTOC6jjTSbZYCD/ysQEZ/6nxAS2ig=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=QVVu6ijJDmU3/7xatrY3ikECXt7RYF8JQ44pKPLKLEiPvZwKkNE3l1ega0SsFCwYT
	 VN37VKFxEBb+4Tkmd516Jn+2yzGDt3U6iG4V7BV56OTkh6pLh/9a1pvCtkj9UIUqcV
	 NFmV813s9uoMLbGtU2ox2eYeQXVv6EiFeNhtIfK/uPkJ3jIrkVNIkZhHgfl+hWvqXS
	 jrOBQ7BUZp51iOKDDT9z4hcQ/+tQxlz70pCZ0ZsDjmxvH9OgFEEAduO0GxggnQsKsq
	 IhlpddJmxJMQmj22D6PA8HPdoC+Vz1GfTF7+OHpuWhsLItKN0g4qA85fVd88JdXRGK
	 J0ZWWTT/h9QKw==
Message-ID: <sashiko-outbox-224719@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 21/49] bpf: Compare states by join_key, then by
 value
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261120074430.2704488-22-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
 <20261120074430.2704488-22-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 08:22:21 +0000
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
- [High] bpf: pointer leak via atomic RMW on unreadable spill in
  stacksafe()
- [Medium] bpf: 8-byte overread of 4-byte refs[i].ptr on 32-bit in
  same_refs()
--

commit e3beba5c290061bf6cb6bccd8d16009036af5591
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Compare states by join_key, then by value

This commit groups non-joinable verifier state fields into join_key structs
for bytewise comparison and hashing, and simplifies register and stack
subsumption checks in states.c.

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index bb8fa008a8a5a..174b1a613fb98 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
[ ... ]
> @@ -295,6 +391,13 @@ static bool stacksafe(struct bpf_verifier_env *env, =
struct bpf_func_state *old,
>  		if (old_type =3D=3D STACK_INVALID || old_type =3D=3D STACK_POISON)
>  			continue;
> =20
> +		/* it can be filled into a register that is unreadable */
> +		if (old_type =3D=3D STACK_SPILL && old_slot->spilled_ptr.type =3D=3D N=
OT_INIT &&
> +		    (env->allow_uninit_stack ||
> +		     (cur_slot && cur_slot->slot_type[im] !=3D STACK_INVALID &&
> +		      cur_slot->slot_type[im] !=3D STACK_POISON)))
> +			continue;

[Severity: High]
Can this leak a spilled pointer when !env->allow_ptr_leaks?

This lets an unreadable spill (STACK_SPILL with spilled_ptr.type =3D=3D NOT=
_INIT)
in old subsume a spilled pointer in cur.  If the subsuming path executes a
64-bit atomic RMW on that stack slot (such as lock *(u64 *)(r10 - 8) +=3D r=
2),
check_atomic_rmw() checks the read with dst_regno =3D=3D -1:

kernel/bpf/verifier.c:check_stack_read_fixed_off() {
    ...
		} else if (dst_regno >=3D 0) {
			/* restore register state from stack */
			state->regs[dst_regno] =3D *reg;
			bpf_equations_fill(env, reg_state, spi, size);
		} else if (__is_pointer_value(env->allow_ptr_leaks, reg)) {
			...
			return -EACCES;
		}
    ...
}

Because is_pointer_regtype(NOT_INIT) is false, __is_pointer_value() returns
false for the unreadable spill, and the atomic write step scrubs the slot to
STACK_MISC.  A subsequent 64-bit load from the slot then reads the pointer
from the subsumed path as a SCALAR_VALUE.

[ ... ]

> @@ -398,6 +485,114 @@ static bool stacksafe(struct bpf_verifier_env *env,=
 struct bpf_func_state *old,
>  	return true;
>  }
> =20
> +static const struct bpf_stack_state *held_slot(const struct bpf_func_sta=
te *f, u32 i)
> +{
> +	return i < bpf_stack_nr_slots(f) && bpf_slot_is_held(bpf_stack_slot(f, =
i)) ?
> +	       bpf_stack_slot(f, i) : NULL;
> +}
> +
> +static bool same_refs(const struct bpf_verifier_state *a, const struct b=
pf_verifier_state *b)
> +{
> +	u32 i;
> +
> +	for (i =3D 0; i < a->acquired_refs; i++)
> +		if (a->refs[i].type !=3D b->refs[i].type || a->refs[i].id !=3D b->refs=
[i].id ||
> +		    memcmp(&a->refs[i].ptr, &b->refs[i].ptr, sizeof(u64)))
> +			return false;
> +	return true;
> +}
[ ... ]
> +u64 bpf_hash_join_key(const struct bpf_verifier_env *env, const struct b=
pf_verifier_state *st)
> +{
> +	u64 hash =3D bpf_hash64(&st->join_key, sizeof(st->join_key), env->hash_=
seed +
> +			      ((u64)st->instance_id << 32 | st->insn_idx));
> +	u32 fr, i, trip;
> +	const struct bpf_stack_state *slot;
> +	const struct loop_stack_entry *e;
> +	const struct bpf_func_state *f;
> +
> +	for (i =3D 0; i < st->acquired_refs; i++)
> +		hash =3D bpf_hash64(&st->refs[i].ptr, sizeof(u64), hash + st->refs[i].=
type);

[Severity: Medium]
On 32-bit architectures, does passing &refs[i].ptr with sizeof(u64) to
memcmp() in same_refs() and bpf_hash64() in bpf_hash_join_key() overread the
4-byte void *ptr union member?

Although the enclosing anonymous union in struct bpf_reference_state is 8
bytes wide because of struct { int parent_id; u32 ctx_arg; }, &refs[i].ptr =
has
type void * const * and a 4-byte sub-object size on 32-bit targets, which
triggers -Wstringop-overread and CONFIG_FORTIFY_SOURCE read-overflow checks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120074430.2704=
488-1-alexei.starovoitov@gmail.com?part=3D21
