Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792542100;
	b=lLZAVkbgJQE9rIYjFg2RTumYCJmQ57yzxRJCab3hlfiJKWqNHOvyAcIhEqaFk0K1vOW9
	 kMyNzEsMgiuvXwB/5mxAXBH6N4aNDc+426YbE7bQbUlGAru/Q8xJ4AbHkNuXu30dR43Mz
	 eLMg+uXnjTlP38FVU6AEfow/uBj/vpNtetS8YYk2E4jKxhxUaAijbZWzRnfZSpAXjdC8j
	 4rrJBkPP0VZ17cIaTD6N2Y0OAcGZwrLrNe1acus47Z8dBA9/Ls3+0Q1Tw+oD2sOX8IqIe
	 ytYcQ0HFub9BEyEqE/Ky1sfDg1inWVu2M1z6auRXGqYxOdHNTUGvLgIRTcdr2Ea20jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792542100;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CzZC5H+2BDeR4IeEvyojZq8pYockzsCAOlLkkLS40RE=;
	b=m7EmLfNPCq3Q02gUkVel98pcqc1ucEdgMjyv+EQ4QVgDpz/lUuJtUsrxmo0itR/BmdNh
	 g5jNH2F1HI7Zi+xmnJEtCEx+BnLeZErNkecBac7r2qgvJWP+DI3Y4GAs+li0GNagbPqUF
	 njjLystnwm+zVbjUIyM3LiDccD6Bll18/DylitahrVxP7jl0lvM1scq/hWBJEQ5jZm6Fj
	 sZ98c4SzCQkYx6R5NQ4rOXKm5fATaNnIe9QdEBi9uITLp7OXTVwA9wdOptxLpDVy/AP4n
	 iQN3y3l5+CC9Fn6lLCY6dPhHhN7dPNsZEBxSwCFh/qk3rJQ3Hx48rIPMVzAqA+bww9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EoQ3dTU7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B82606A31A
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 00:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EoQ3dTU7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F281F000C9;
	Wed, 21 Oct 2026 00:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792542100;
	bh=CzZC5H+2BDeR4IeEvyojZq8pYockzsCAOlLkkLS40RE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=EoQ3dTU7gtWJEvmQ7jPj7LsXZxoGgHBP8BdPS//rPGCE820CAnv9JPmBrljvrLm6b
	 CZN5Z72dyC4Psf/KID/jxS27wdvdhWoiOfXKkKlsk1UC4YVoJrZ1A9hcVn7MCNh4Ji
	 fjxZs/wEIkPujnAV3dAKQhABvboRLGip8jSscUs29+f4s2fOhnP0zbkOGlmsJmb/mg
	 +tbV3XV37As5nMYr8jx1AvSCfW1vWhS+wy0hCX2e8zXxwMxcGf6Fvzen4ftdIjw4Z7
	 uFU/YzooqXpcGjarMf25pUhn1FXpVSP6PV8Y79MM2xxaesSdKzXB442NgAt2mbEZJ9
	 FjhYHbu9dV/gw==
Message-ID: <sashiko-outbox-179630@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: pointer operands for 32-bit
 recurrences/latches
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261020234705.375067-2-eddyz87@gmail.com>
References: <20261020234705.375067-1-eddyz87@gmail.com>
 <20261020234705.375067-2-eddyz87@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 00:21:39 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: 32-bit linear SCEVs on pointers not rejected outside latch ch=
eck
--

commit 674e2a043732fe1343763547170250d3fb165111
Author: Eduard Zingerman <eddyz87@gmail.com>

selftests/bpf: pointer operands for 32-bit recurrences/latches

This commit adds two selftests checking that loop bounds are not inferred w=
hen
latch operands are pointers involved in a 32-bit comparison or a 32-bit
recurrence.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/te=
sting/selftests/bpf/progs/verifier_scev.c
> index 661ce9ca8f938..6f8c3980299c4 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_scev.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
> @@ -2971,6 +2971,62 @@ __naked void ptr_stack_other_frame(void)
>  "	::: __clobber_all);
>  }
> =20

[ ... ]

> +SEC("xdp")
> +__failure
> +__log_level(2)
> +__msg("scev: incompatible latch operands r6 (map_value), r7 (map_value)")
> +__msg("loop header at 11, can't compute iterations count at 14")
> +__naked void ptr_map_value_alu32(void)
> +{
> +	asm volatile ("					\
> +	*(u64 *)(r10 - 8) =3D 0;				\
> +	r2 =3D r10;					\
> +	r2 +=3D -8;					\
> +	r1 =3D %[map] ll;					\
> +	call %[bpf_map_lookup_elem];			\
> +	if r0 =3D=3D 0 goto 2f;				\
> +	r6 =3D r0;					\
> +	r7 =3D r6;					\
> +	r7 +=3D 4;					\
> +	r9 =3D 0;						\
> +1:"	LIMIT_ITERATIONS				\
> +"	w6 +=3D 1;					\
> +	if r6 < r7 goto 1b;				\
> +2:	r0 =3D 0;						\
> +	exit;						\
> +"	:
> +	: __imm(bpf_map_lookup_elem), __imm_addr(map)
> +	: __clobber_all);
> +}

[Severity: High]
In ptr_map_value_alu32(), w6 +=3D 1 is applied directly to a pointer regist=
er
while r6 is also the latch operand. The companion commit ("bpf: reject poin=
ter
operands for 32-bit recurrences/latches") rejects this via !latch->zext32 in
scev_value_compatible():

kernel/bpf/scev.c:scev_value_compatible() {
	...
	ra =3D scev_reg_for_read(env, st, a->ptr_reg);
	rb =3D scev_reg_for_read(env, st, b->ptr_reg);
	if (ra && rb && bpf_same_memory_origin(ra, rb) && !latch->zext32 && !latch=
->jmp32)
		return true;
}

However, what happens when a pointer register has a 32-bit linear recurrence
(such as r6 +=3D 1; w6 =3D w6; or w6 =3D w6; w6 +=3D 1;, which simplify() f=
olds into
(zext32 (linear r6 1))) while a separate scalar register controls the loop
latch?

When allow_ptr_leaks is enabled (as in SEC("xdp") with CAP_BPF), check_alu_=
op()
permits 32-bit BPF_MOV on a pointer without calling adjust_ptr_min_max_vals=
(),
converting r6 into a SCALAR_VALUE holding the low 32 bits of the runtime
pointer address.

Because scev_value_compatible() only checks the latch operands,
bpf_compute_loop_iters() accepts r6 as widenable even when coefs.zext32 is
true:

kernel/bpf/scev.c:bpf_compute_loop_iters() {
		...
		r_scev =3D header_env->reg2scev[r];
		reg =3D scev_reg_for_linear(cur_func, r);
		/* If SCEV for r is (linear <reg> <slope>) */
		if (reg && is_simple_linear(scev, r_scev, &coefs) && is_widenable_reg_typ=
e(reg)) {
		...
}

Subsequently, bpf_widen_scev_regs() widens the pointer offset using 32-bit
linear_bounds(), and on the backedge bpf_clamp_scev_regs() computes 32-bit
linear_bounds() from entry_reg (the loop-entry PTR_TO_MAP_VALUE with offset=
 0)
and intersects that small offset range with the backedge register reg (now a
SCALAR_VALUE holding the truncated 32-bit runtime kernel address):

kernel/bpf/scev.c:bpf_clamp_scev_regs() {
		...
		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
		bounds.r64 =3D cnum64_intersect(reg->r64, bounds.r64);
		bounds.r32 =3D cnum32_intersect(reg->r32, bounds.r32);
		...
}

Can this corrupt the verifier's scalar bounds for r6 by clamping a runtime
32-bit kernel address to a small offset range like [0, 1], and should
coefs.zext32 on pointer registers also be rejected in bpf_compute_loop_iter=
s(),
bpf_widen_scev_regs(), and bpf_clamp_scev_regs() (with corresponding selfte=
sts
covering w6 =3D w6 and non-latch pointer recurrences)?

> =20
>  /* Metadata and packet data have different origins. */
>  SEC("xdp")
>  __success

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020234705.3750=
67-1-eddyz87@gmail.com?part=3D2
