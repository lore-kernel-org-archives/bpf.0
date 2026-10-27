Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793135076;
	b=wvnO2taQHI8F8XDQ/JM6RUWnY0KBxGTntuxbJexVW9ltWjbfJYxnEiDWSQlSv8dVkJPS
	 gySjP+pLNZrmKRJBxRD46PZu1/uHk2ftt/1l/Ot3JI4/crFe7rpGQgVD5yfcEx5UGzEeq
	 e4K32isxsvLqvd3e+zfe4pHygrmWypz11ziiKVSaph8CO/7ZjYZQkE+sZjUsyxHM5wzIX
	 KTijC/2tjcJjxW9o5t26jQBEqebvfy1pdz709yU4AeyCnxNP7Dn9z1PKuezhqoKbzSE0v
	 mWGylzmJr+DLLxWT1QvLegZrd34fmqkpGX2uRc9xAwqQ0vLgabmJyK9rm8AqD3rl8HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135076;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lPHvtGDdzblXviQeF4RcbSLV7O99Re+MGi5iKsQP6HQ=;
	b=IIO1uEuvInJyKOPVjW1mQ+YQqg2v6+5KHY6hjdfXQYPjswOy1BZGN940sLvmBSKz7/UY
	 bGILhzFGADG4divB2R896MSUE1AfuSuEgsltOzgX0pO3j4yBV6PdGy5iYXxksu3Nj+sAQ
	 08cuoBnOOCN9ufHdM/SwcpyUxmOoFqncZZfZqQg2jQmW26zAYv6YwzTXPtmVJQtSU384s
	 B92k7jnpZ8HpFEJ15axDakU57MEV7TNhnaJ37k04KwZQv99zlMTH79YX8N4oUs4jMBKBd
	 HndFRZ1m2bgFQ8xY5GuCOQL1wH8HSltNhBLWIVxmZrsBXQOu0iWbZGGaoioQOIczbPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c8gTKsSp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42811606A31D
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 21:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c8gTKsSp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D2E1F01825;
	Tue, 27 Oct 2026 21:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793135075;
	bh=lPHvtGDdzblXviQeF4RcbSLV7O99Re+MGi5iKsQP6HQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=c8gTKsSppONrK4hZf2RAH4rUCfWqMAVlpgilDrmo03BkhUxaGKjt5xDijJ8DBs55r
	 YG9Rr4X5wAUT23rYMjsbJLLts0bc2NFZBIdfa1zfxnTxor6eKxr1fHK7q1Q58eR3cp
	 Mt2a6kejgkxukRDrFmyD19371b+qafCgPVolAw2NVPL9rrhFT9bzZZodiFZksCm8F/
	 uGzyQqV/eMKqxoq9iapGSUFgqdIf0ruCo0xu4cEKQNfzoM2KJNlALpH6rYMD9oMmxe
	 a+B65jQzY3m4DhTRBYz5oeWnIyNTpHZ8s4lvom62ICypxMVpR7JocroLJRDxsX3F5J
	 M+dcJUiRmisvA==
Message-ID: <sashiko-outbox-187109@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: Keep the valid bytes of a packet pointer
 in scalar evolution
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261027201436.3192716-2-alexei.starovoitov@gmail.com>
References: <20261027201436.3192716-1-alexei.starovoitov@gmail.com>
 <20261027201436.3192716-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 21:04:35 +0000
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
- [Critical] bpf: out-of-bounds packet range in sync_widened_reg() when r64=
 crosses zero
- [Critical] bpf: missing range reset in bpf_clamp_scev_regs() corrupts pac=
ket range
- [High] bpf: verifier_bug() in bpf_reg_union() when sync_widened_reg() mut=
ates range
--

commit f227a7637607cf60f782fa9321486ac435f7a53c
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Keep the valid bytes of a packet pointer in scalar evolution

This patch updates sync_widened_reg() in bpf_set_reg_range() and
bpf_reg_union() to reduce reg->range when reg_bounds_sync() lowers umax on a
widened packet pointer, and clears negative pkt_end marks in
bpf_widen_scev_regs().

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index 04d4962448e27..f28eddd17d78f 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c
> @@ -2838,6 +2838,9 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *en=
v, struct bpf_verifier_state
>  				bpf_log(log, "\n");
>  			}
>  			scratch_widened_reg_id(env, reg);
> +			/* "at pkt_end" and "beyond pkt_end" are not valid in all iterations =
*/
> +			if (type_is_pkt_pointer(reg->type))
> +				reg->range =3D max(reg->range, 0);
>  			err =3D bpf_set_reg_range(env, reg, bounds.r64, bounds.r32,
>  						bounds.base, bounds.step);

[Severity: Critical]
Should bpf_clamp_scev_regs() also reset reg->range from entry_reg (i.e.
max(entry_reg->range, 0)) before calling bpf_set_reg_range()?

On every loop backedge, do_check() -> handle_loop_entry_exit() ->
maybe_clamp_scev_regs() -> bpf_clamp_scev_regs() recomputes bounds from the
pre-widen loop-entry register entry_reg and calls bpf_set_reg_range() ->
sync_widened_reg(reg) on the current state's reg without resetting
reg->range:

kernel/bpf/scev.c:bpf_clamp_scev_regs() {
    ...
		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
		...
		scratch_widened_reg_id(env, reg);
		err =3D bpf_set_reg_range(env, reg, bounds.r64, bounds.r32,
					bounds.base, bounds.step);
    ...
}

This appears to cause two regressions on loop backedges:

1. Stale loop-body range leading to out-of-bounds packet access:
Suppose before a 2-iteration loop r6 =3D pkt has r64 =3D [0, 0] and range =
=3D 0
(widened at the header to r64 =3D [0, 8], range =3D 0), and inside the loop=
 body
r6 +=3D 8 advances r6 to r64 =3D [8, 16] followed by if r6 > pkt_end goto e=
xit.
find_good_pkt_pointers() sets r6->range =3D reg_umax(r6) =3D 16 (representi=
ng 0
valid bytes past r6, since iteration 0 only proved pkt + 8 <=3D pkt_end).

When the backedge returns to the loop header, bpf_clamp_scev_regs() resets
r6->r64 back to [0, 8] (umax =3D 8) while leaving r6->range =3D 16 from the=
 loop
body. If the backedge state is not pruned at the header (for example, when
another register or stack slot changes), iteration 1 executes at the header
with r6 having umax =3D 8 and range =3D 16 (8 valid bytes), allowing
*(u64 *)(r6 + 0) to read 8 bytes past pkt_end when r6 =3D=3D pkt + 8 =3D=3D=
 pkt_end.
Similarly, negative AT_PKT_END or BEYOND_PKT_END marks set inside the loop
body are not cleared by bpf_clamp_scev_regs().

2. Repeated range subtraction preventing loop convergence:
When entry_reg has range =3D R > 0 before the loop and sync_widened_reg()
lowers umax by d =3D 2 (for instance, 58 -> 56), bpf_widen_scev_regs() at l=
oop
entry sets the header checkpoint state's rold->range =3D R - 2. When the
backedge reaches the loop header, the current state's reg enters
bpf_clamp_scev_regs() with reg->range already equal to R - 2.

Because bpf_clamp_scev_regs() recomputes bounds.r64 =3D [0, 58] from entry_=
reg
and calls bpf_set_reg_range() -> sync_widened_reg(reg), umax drops from 58
to 56 a second time and sync_widened_reg() subtracts 2 again, setting
rcur->range =3D R - 4. In kernel/bpf/states.c:regsafe(), rold->range >
rcur->range returns false, preventing state pruning at the loop header and
shrinking reg->range on each pass.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a0a5f075d2018..66d008166f169 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17768,6 +17768,20 @@ bool bpf_same_memory_origin(const struct bpf_reg=
_state *reg_a,
>  	}
>  }
> =20
> +/*
> + * 'range - umax' bytes from a packet pointer are in the packet. reg_bou=
nds_sync() can make umax
> + * smaller: with a step of 8, or with 3 zero bits in var_off, 58 becomes=
 56. Make the range
> + * smaller by the same number, so that the number of bytes does not grow.
> + */
> +static void sync_widened_reg(struct bpf_reg_state *reg)
> +{
> +	u64 umax =3D reg_umax(reg);
> +
> +	reg_bounds_sync(reg);
> +	if (type_is_pkt_pointer(reg->type) && reg->range > 0)
> +		reg->range =3D max_t(s64, reg->range - (s64)(umax - reg_umax(reg)), 0);
> +}

[Severity: Critical]
Can sync_widened_reg() corrupt reg->range when reg->r64 spans negative and
non-negative offsets (smin < 0 && smax >=3D 0)?

In kernel/bpf/scev.c:linear_bounds(), when a packet pointer is decremented =
in
a loop (slope < 0) or starts at a negative offset before the loop,
bounds.r64 =3D cnum64_from_srange(min_val, max_val) can have min_val < 0 and
max_val >=3D 0.

In kernel/bpf/cnum_defs.h:cnum64_umax():

ut FN(umax)(struct cnum_t cnum)
{
	return FN(urange_overflow)(cnum) ? UT_MAX : cnum.base + cnum.size;
}

any cnum64 that crosses the U64_MAX/0 boundary returns U64_MAX from
reg_umax(reg). Using reg_umax(reg) in sync_widened_reg() leads to two cases
where check_packet_access() can allow out-of-bounds packet reads or writes
past pkt_end:

1. Range inflation when reg_bounds_sync() rounds smin up to >=3D 0:
Suppose before a 2-iteration loop:

    r4 &=3D 0x38
    if r4 < 2 goto exit
    if r4 > 50 goto exit
    r6 =3D pkt
    r6 +=3D r4
    r5 =3D r6
    r5 +=3D 8
    if r5 > pkt_end goto exit

so r6 has r64 =3D [2, 50], var_off =3D (0; 0x38), range =3D 58. If the loop=
 body
decrements r6 by 8 (r6 +=3D -8), linear_bounds() produces r64 =3D [-6, 50],
base =3D 0, step =3D 8.

In sync_widened_reg(), umax before reg_bounds_sync(reg) is U64_MAX because
[-6, 50] crosses zero. Then reg_bounds_sync(reg) intersects r64 with step =
=3D 8
via __update_bounds_from_step(), narrowing r6->r64 to [0, 48] with
reg_umax(r6) =3D 48. As a result, (s64)(umax - reg_umax(reg)) evaluates to
(s64)(U64_MAX - 48) =3D -49, and reg->range - (s64)(umax - reg_umax(reg))
increases r6->range from 58 to 107 instead of reducing it to 56.

2. Failure to shrink range when smin remains < 0:
If the if r4 < 2 goto exit check is omitted above, linear_bounds() produces
r64 =3D [-8, 50], step =3D 8, and reg_bounds_sync(reg) tightens r6->r64 to
[-8, 48]. Because smin is still negative, reg_umax(reg) is U64_MAX both
before and after reg_bounds_sync(reg), so umax - reg_umax(reg) is 0 and
r6->range remains 58 instead of shrinking to 56. Inside the loop body,
r5 =3D r6; r5 +=3D 8 yields r5->r64 =3D [0, 56] with r5->range =3D 58, allo=
wing a
2-byte read at r5 + 0 past pkt_end when r4 =3D 48 and pkt_end =3D pkt + 56.

> =20
>  int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state=
 *reg,
>  		      struct cnum64 r64, struct cnum32 r32, u16 base, u16 step)
> @@ -17776,7 +17790,7 @@ int bpf_set_reg_range(struct bpf_verifier_env *en=
v, struct bpf_reg_state *reg,
>  	reg->step =3D step;
>  	reg->base =3D base;
>  	reg->var_off =3D tnum_unknown;
> -	reg_bounds_sync(reg); /* this should infer the tnum alignment */
> +	sync_widened_reg(reg); /* this should infer the tnum alignment */
>  	return reg_bounds_sanity_check(env, reg, "bpf_set_reg_range");
>  }
> =20
> @@ -17821,7 +17835,7 @@ int bpf_reg_union(struct bpf_verifier_env *env, s=
truct bpf_reg_state *acc,
>  		acc->base =3D base;
>  		acc->step =3D step;
>  	}
> -	reg_bounds_sync(acc);
> +	sync_widened_reg(acc);
>  	return reg_bounds_sanity_check(env, acc, "bpf_reg_union");
>  }

[Severity: High]
Does calling sync_widened_reg(acc) inside bpf_reg_union() trigger
verifier_bug(env, "union of incompatible registers") when union_any_reg()
iterates over multiple leaves?

In kernel/bpf/scev.c:union_any_reg(), bpf_reg_union(env, acc, leaf_reg) is
called in a loop for each leaf of an ANY expression. On each call,
bpf_reg_union() checks bpf_reg_union_compatible(acc, src):

kernel/bpf/verifier.c:bpf_reg_union_compatible() {
	if (a->type !=3D b->type)
		return false;
	if (a->type =3D=3D SCALAR_VALUE)
		return true;
	return !memcmp(a, b, offsetof(struct bpf_reg_state, var_off)) &&
	       a->id =3D=3D b->id && a->parent_id =3D=3D b->parent_id && a->map_ui=
d =3D=3D b->map_uid;
}

which compares a->range and b->range via memcmp().

For example, if at loop entry r6 has id =3D 1, r64 =3D [0, 50],
var_off =3D (0; 0x38), range =3D 58 and r5 =3D r6 + 8 has id =3D 1, r64 =3D=
 [8, 58],
var_off =3D (0; 0x78), range =3D 58, and the loop body sets r5 =3D r6 so r5=
 has
SCEV (any r5 r6):

1. is_widenable_any() succeeds because both leaves have id =3D 1 and
   range =3D 58.
2. In union_any_reg(), the first leaf (entry_r5) is unioned into acc.
   sync_widened_reg(acc) lowers umax from 58 to 56 via var_off and changes
   acc->range from 58 to 56.
3. On the second leaf (entry_r6, which still has range =3D 58),
   bpf_reg_union_compatible(acc, entry_r6) sees acc->range (56) !=3D
   entry_r6->range (58), triggering verifier_bug(env, "union of incompatible
   registers") and returning -EFAULT.

In addition, calling sync_widened_reg(acc) on each leaf in union_any_reg()
can subtract umax reductions multiple times across intermediate leaves, and
the is_any() branch in bpf_widen_scev_regs() does not clear negative
pkt_end marks on reg->range before unioning.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027201436.3192=
716-1-alexei.starovoitov@gmail.com?part=3D1
