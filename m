Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792513939;
	b=my59uTsOC3JovJFhPcVwnyxE7SLTsU5+7E0QSf/xhQuVSUa7hCooHrkdAhfJ5tPJdhvB
	 xfZyxmo65AhaBgJFlSGz3eSYwiXDEgKFB4A1AjpAewpUIphhe8gTNwHrxhKNK5AgZSBsI
	 gWt6eJ7l1tzKZbsNgIyAHt2ME8OxgtNMiRakCd4ctiWz8sjpdXLynqYCK6e/VBSC+6zdB
	 0o6LSMx7Xs17F06Ix4KwqQLbGidPXwtDXBk9rek48WkP8fpVOaFSpxga/S8YxLQ/rl0cT
	 OoKgo/9WcudlngZ4bOrhHoAPzrBxExx1zzzSUmkEpoD9UIi/nYxZSAAvZq/YZPEDt5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513939;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5yksFe/4JkAnws6SOBos0X/lgrZsIaMctoZhEpYsV60=;
	b=Fp7FzVvXaxt9QLaGy9cLB2+2mDfkMzRE7DsbjnDUKjI2JmDaxnYj/PxQNkzCmsN18wEI
	 6E1GYDIgGUMWfvoJpYGxblBLFVXDKgxzeC7GnoFFPDpCbCFaf35B5eSU4unWpP73ugAcc
	 BoqmTr8gU5I/jFJ+JRkoGU8YH9z8yz1GE2ApCiUdaPUaedKY13SgGaZJqJsN74mq1e28X
	 aafR7ZdbCPpqSKob4dh6y26X4/r+SAH7+u5PrYyne5fXvN1IqjOYFsX7XbgiMekkUBCGU
	 s/uVAtYJnBH/9jpS1Tt/gPs/6q2vgMfGJfaDowImAArLQiWurVyjCDoXS5GveA7NL+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233DE606A322
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 16:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A831F000C4;
	Tue, 20 Oct 2026 16:32:18 +0000 (UTC)
Message-ID: <sashiko-outbox-179354@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 12/12] [do not merge] selftests/bpf: Cover
 the low-32 link for narrowing stack spills
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineet Gupta" <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261020161907.2115379-13-vineet.gupta@linux.dev>
References: <20261020161907.2115379-1-vineet.gupta@linux.dev>
 <20261020161907.2115379-13-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 16:32:07 +0000
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
- [Medium] selftests/bpf: fill before narrow in zext_narrowing_spill_byte_n=
o_link()
- [Medium] selftests/bpf: tautological test in sext_fill_of_narrowing_spill=
_drops_zext()
- [Low] selftests/bpf: stale inline comment in zext_narrowing_spill_drops_l=
ink()
--

commit a341902044eb0b749136bbae6f269759e4c0ffcd
Author: Vineet Gupta <vineet.gupta@linux.dev>

selftests/bpf: Cover the low-32 link for narrowing stack spills

This patch adds six verifier selftests to verifier_linked_scalars.c to test
low-32 register linking behavior across narrowing stack spills and subseque=
nt
fills.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c =
b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> index ab78285153fb1..8ade4836e1b2f 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> @@ -1217,6 +1217,128 @@ __naked void zext_fill_byte_forms_no_link(void)
>  	: __clobber_all);
>  }
> =20

[ ... ]

> +/*
> + * A narrowing spill stores only the source's low 32 bits, so the slot i=
s their
> + * zero-extension. Filling it back is a mov, though, and that drops the =
link
> + * for the same reason zext_chain_drops_link does, so a later narrowing =
of the
> + * source does not reach the filled register.
> + */
> +SEC("socket")
> +__failure
> +__msg("div by zero")
> +__naked void zext_narrowing_spill_drops_link(void)
> +{
> +	asm volatile ("						\
> +	call %[bpf_get_prandom_u32];				\
> +	r6 =3D r0;						\
> +	call %[bpf_get_prandom_u32];				\
> +	r0 <<=3D 32;						\
> +	r6 |=3D r0;		/* r6 =3D full 64-bit unknown */	\
> +	*(u32 *)(r10 - 8) =3D r6;	/* narrowing spill, forms the link */ \
> +	r2 =3D *(u32 *)(r10 - 8);	/* fill it back */		\
> +	if w6 !=3D 0 goto 1f;	/* narrows r6, propagates to r2 */ \

[Severity: Low]
This isn't a bug, but is this inline comment in
zext_narrowing_spill_drops_link() left over from the earlier version of the
test? Since the preceding fill into r2 drops BPF_REG_LINK_ZEXT, narrowing w6
here does not propagate to r2.

> +	if r2 =3D=3D 0 goto 1f;					\
> +	r0 /=3D 0;						\
> +1:								\
> +	r0 =3D 0;							\
> +	exit;							\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +

[ ... ]

> +/*
> + * A sub-word spill is below the low-32 model, so no link is formed ther=
e.
> + * The fill is a byte load too, so this pins the spill-side and fill-side
> + * size gates together rather than either on its own.
> + */
> +SEC("socket")
> +__failure __msg("div by zero")
> +__naked void zext_narrowing_spill_byte_no_link(void)
> +{
> +	asm volatile ("						\
> +	call %[bpf_get_prandom_u32];				\
> +	r6 =3D r0;						\
> +	call %[bpf_get_prandom_u32];				\
> +	r0 <<=3D 32;						\
> +	r6 |=3D r0;						\
> +	*(u8 *)(r10 - 8) =3D r6;	/* 1-byte spill: no link */	\
> +	r2 =3D *(u8 *)(r10 - 8);					\
> +	if w6 !=3D 0 goto 1f;					\
> +	if r2 =3D=3D 0 goto 1f;	/* not deduced */		\

[Severity: Medium]
Does zext_narrowing_spill_byte_no_link() actually test the size gate in
check_stack_write_fixed_off()?

Here, r2 is filled from fp-8 before w6 is narrowed:

	*(u8 *)(r10 - 8) =3D r6;	/* 1-byte spill: no link */
	r2 =3D *(u8 *)(r10 - 8);
	if w6 !=3D 0 goto 1f;

As demonstrated by zext_narrowing_spill_drops_link() above, filling a
BPF_REG_LINK_ZEXT slot into r2 before narrowing w6 drops the zero-extending
link on the fill, so narrowing w6 afterwards would not propagate to r2 even=
 if
the 1-byte spill had formed a link.

Should the narrowing branch "if w6 !=3D 0 goto 1f" happen while the value is
still on the stack before filling r2, matching the instruction order in
zext_narrowing_spill_reaches_fill()?

> +	r0 /=3D 0;						\
> +1:								\
> +	r0 =3D 0;							\
> +	exit;							\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
>  #ifdef CAN_USE_MOVSX

[ ... ]

> @@ -1800,6 +1952,35 @@ __naked void sext_byte_fill_drops_sext_link(void)
>  }
>  #endif /* CAN_USE_MOVSX */
> =20
> +/*
> + * The same, with the zero-extending link coming from a narrowing spill =
rather
> + * than a mov. The spill truncated the slot to 32 bits, so the fill is n=
ot
> + * narrowing and assigns no link kind of its own; the slot's zero-extend=
ing
> + * one must not survive the sign-extending load.
> + */
> +SEC("socket")
> +__failure __msg("div by zero")
> +__naked void sext_fill_of_narrowing_spill_drops_zext(void)
> +{
> +	asm volatile ("						\
> +	call %[bpf_get_prandom_u32];				\
> +	r6 =3D r0;						\
> +	call %[bpf_get_prandom_u32];				\
> +	r0 <<=3D 32;						\
> +	r6 |=3D r0;		/* r6 =3D full 64-bit unknown */	\
> +	*(u32 *)(r10 - 8) =3D r6;	/* narrowing spill: slot is ZEXT */ \
> +	r2 =3D *(s32 *)(r10 - 8);	/* sign-extending, not narrowing */ \
> +	if w6 !=3D -1 goto 1f;	/* slot low 32 bits are all ones */ \
> +	if r2 s>=3D 0 goto 1f;	/* taken only if r2 was rebuilt zext */ \
> +	r0 /=3D 0;						\

[Severity: Medium]
Can sext_fill_of_narrowing_spill_drops_zext() ever reach the is_ldsx link
clearing in check_mem_access() with BPF_REG_LINK_ZEXT still intact?

In check_stack_write_fixed_off(), the 4-byte narrowing spill
"*(u32 *)(r10 - 8) =3D r6" truncates fp-8 to 32 bits via
zext_32_to_64(&ss->spilled_ptr) and sets BPF_REG_LINK_ZEXT.

When "r2 =3D *(s32 *)(r10 - 8)" then runs in check_stack_read_fixed_off(),
get_reg_width(reg) is at most 32, so narrowing is false. Because size =3D=
=3D 4,
spill_size =3D=3D 4, and !narrowing all hold, check_stack_read_fixed_off() =
calls
assign_scalar_id_before_mov(env, reg) before copying *reg to
state->regs[dst_regno]:

kernel/bpf/verifier.c:check_stack_read_fixed_off() {
    ...
	if (env->bpf_capable && size =3D=3D 4 &&
	    (subreg_link || (spill_size =3D=3D 4 && !narrowing)))
		assign_scalar_id_before_mov(env, reg);
	state->regs[dst_regno] =3D *reg;
    ...
}

And assign_scalar_id_before_mov() immediately clears BPF_REG_LINK_ZEXT and
assigns a fresh scalar ID unlinked from r6:

kernel/bpf/verifier.c:assign_scalar_id_before_mov() {
	if (src_reg->link_kind && src_reg->link_kind !=3D BPF_REG_LINK_SEXT)
		bpf_clear_scalar_id(src_reg);
	if (!src_reg->id && !tnum_is_const(src_reg->var_off))
		src_reg->id =3D ++env->id_gen;
}

So BPF_REG_LINK_ZEXT is already cleared by the normal 4-byte fill path (the
same path tested by zext_narrowing_spill_drops_link()) before the is_ldsx
handling in check_mem_access() runs.

Additionally, even if r2 kept r6's ID and BPF_REG_LINK_ZEXT past
check_mem_access(), coerce_reg_to_size_sx() restricts r2's 64-bit bounds to
[S32_MIN, S32_MAX]. When "if w6 !=3D -1 goto 1f" calls sync_linked_regs(),
rebuilding r2 with zext_32_to_64() yields 0xffffffff, which is disjoint from
[S32_MIN, S32_MAX], causing range_bounds_violation() to revert r2 to its pr=
ior
bounds and still hit "r0 /=3D 0".

> +1:								\
> +	r0 =3D 0;							\
> +	exit;							\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
>  #endif /* CAN_USE_LDSX */
> =20
>  char _license[] SEC("license") =3D "GPL";

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020161907.2115=
379-1-vineet.gupta@linux.dev?part=3D12
