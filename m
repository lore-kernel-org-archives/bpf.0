Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516839;
	b=SJZgWlWQ/BK4DZFc3f5AXIGbd7Y9MmoIyehh7PJuhcIpHCrnSMvn/Q7rPB8MF3bETVWi
	 DSHwcEQ8GRIfarh9G3N4t3t3r3FmBEDgV6oHYWAiuBRDJv2NUCencPcJAgxkHfl/lr1AK
	 ihFpbbwr0Kuv0is07zaFrt84OKqy8RDJZng69+hEJCl7lYU7CoLP29NFHjQBa/RzwpE/w
	 hmgx0fx0yJbfqBuQd8GByV2t3a5Cz0uRpCdRV0Xwk9XqGVJXpR21PgG0BEjVcpFvYnApj
	 Kyo4TI0YVfXhHQzHA6oZSWKwNpx9B/gRh1oa8CwC4Xjm9cxLMOeJtLqPRqkERRXttcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516839;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rW+dNTDwU9IAPS+U46iKSDXcgWC2yUlq58WkqgQKgBc=;
	b=zSuRq9LPA7NoqI37OSLOrJZW5x/8UwmGQJfh5NzOSlWtvSjrVEFmdev6hEp+aRwxzuZK
	 9LweUN2NFC72fQS2LrltU0HuF+ldK9Vohp2vOZ+2fX3c9zCeR2O47hrztCQ2SZL7gv4M4
	 KPXWBMoG2qX1FEKh+iUFwY6dzoa/ja8tGl2FX9dNmlLG9C/27G2/b7IwgVCE3rIrDCqSQ
	 TG7Uy2mwMXkmMxc3g6LQl9AIM0dhTrgAFeculTa9pAT/shW1BBEAdP2M3Vto5ITUbjAA2
	 JqXh+3R7DE7iuUqKJpMRhMtbpLRnSLXu7/60ysNykslFdpVPeif+25ML3/1+FiEtgOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FR05pxn2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F5C606A330
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FR05pxn2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D92F1F000C9;
	Tue, 20 Oct 2026 17:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792516838;
	bh=rW+dNTDwU9IAPS+U46iKSDXcgWC2yUlq58WkqgQKgBc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FR05pxn2BhItvOV1SIcm1kcJinwrGq1yPwZHpTBetmLYfkpZk9l2YRvS6HTDqCxua
	 g+vnZ/5XVqb5k0S3rAC94yOSpYDdeZMBF1ynUVGosY7avN9EuiruKULqYNwOc+QJR6
	 bFXSGK9y2P/LCSoN7O9QCRkxR7FFG83T1DshcbHpvqn67hmkp8K7LvWEDrHEhtwyTl
	 JNkc9V1fBbiBSTZ/7c96nv/QHAtCh1JANUVPSbAv8M+rmrXgScYJRq2feAFIMrtdFw
	 8MiBU+wapH7FNbRCD8hP/WOSoT7IGJWgPjnCf/xYKHFVoYSBOGRP2LkKnte4xQLD1H
	 KUrk2s8mnomFQ==
Message-ID: <sashiko-outbox-179412@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 08/12] bpf: Recover the low 32 bits on the
 reverse link direction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineet Gupta" <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261020161907.2115379-9-vineet.gupta@linux.dev>
References: <20261020161907.2115379-1-vineet.gupta@linux.dev>
 <20261020161907.2115379-9-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 17:20:28 +0000
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
- [Medium] bpf: missing contradiction check in sync_linked_regs() reverse-d=
irection arm
--

commit 651910c4895680e635057947cc88b56f4edbf401
Author: Vineet Gupta <vineet.gupta@linux.dev>

bpf: Recover the low 32 bits on the reverse link direction

This commit updates sync_linked_regs() in the BPF verifier to recover the l=
ow
32-bit bounds and subreg tnum when propagating from a narrow linked register
(BPF_REG_LINK_ZEXT or BPF_REG_LINK_SEXT) back to a linked register wider th=
an
32 bits.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4621b476b206e..ac50252cec1f7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18785,29 +18785,54 @@ static void sync_linked_regs(struct bpf_verifie=
r_env *env, struct bpf_verifier_s
>  		if (reg->id !=3D known_reg->id)
>  			continue;
>  		/*
> -		 * The reverse direction does not work for a narrow known_reg:
> -		 * it knows only its low 32 bits, which say nothing about a
> -		 * wider reg's high half. Neither (u32)(base + delta) nor
> -		 * (s32)(base + delta) inverts once the base is wider than 32
> -		 * bits.
> +		 * The reverse direction, from a narrow known_reg to a wider
> +		 * reg, does not invert: neither (u32)(base + delta) nor
> +		 * (s32)(base + delta) says anything about the base's high
> +		 * half. It does still pin the low half, though -- both sides
> +		 * are (base + delta) mod 2^32, differing only by their deltas
> +		 * -- so recover that much and leave the high half alone.
>  		 */
>  		if ((known_reg->link_kind =3D=3D BPF_REG_LINK_ZEXT ||
>  		     known_reg->link_kind =3D=3D BPF_REG_LINK_SEXT) &&
>  		    reg->link_kind !=3D BPF_REG_LINK_ZEXT &&
>  		    reg->link_kind !=3D BPF_REG_LINK_SEXT &&
> -		    get_reg_width(reg) > 32)
> -			continue;
> +		    get_reg_width(reg) > 32) {
> +			/*
> +			 * Only @low's 32-bit half is meaningful: its var_off
> +			 * is advanced over all 64 bits while r64 and the
> +			 * base/step line are not, and nothing below reads
> +			 * either. It is a scratch value, not a register state.
> +			 */
> +			struct bpf_reg_state low =3D *known_reg;
> +			struct tnum low32;
> +
> +			fake_reg.type =3D SCALAR_VALUE;
> +			__mark_reg_known(&fake_reg,
> +					 (s64)reg->delta - (s64)known_reg->delta);
> +			scalar32_min_max_add(&low, &fake_reg);
> +			low.var_off =3D tnum_add(low.var_off, fake_reg.var_off);
> +
> +			cnum32_intersect_with(&reg->r32, low.r32);
> +			low32 =3D tnum_intersect(tnum_subreg(reg->var_off),
> +					       tnum_subreg(low.var_off));
> +			reg->var_off =3D tnum_with_subreg(reg->var_off, low32);
> +			reg_bounds_sync(reg);
> +			goto scratched;
> +		}

[Severity: Medium]
Can this reverse-direction arm leave reg with an empty range (CNUM32_EMPTY =
or
CNUM64_EMPTY) or conflicting constant subreg bits when the low-32 bounds,
var_off, or step progression of reg and known_reg contradict on an
unreachable path?

In the sibling differencing arm further down in sync_linked_regs(), the code
saves prev =3D *reg before intersecting and restores *reg =3D prev if
range_bounds_violation(reg) holds:

kernel/bpf/verifier.c:sync_linked_regs() {
	...
	cnum64_intersect_with(&reg->r64, prev.r64);
	cnum32_intersect_with(&reg->r32, prev.r32);
	reg->var_off =3D tnum_intersect(reg->var_off, prev.var_off);
	if (range_bounds_violation(reg))
		*reg =3D prev;
	reg_bounds_sync(reg);
}

In the new arm above, cnum32_intersect_with(&reg->r32, low.r32) and
tnum_intersect() are applied directly without saving prev or checking for
contradictions. If reg->r32 becomes CNUM32_EMPTY, reg_bounds_sync() exits
early on range_bounds_violation(reg), and even when cnum32_intersect_with()
is non-empty, reg_bounds_sync() can still empty reg->r32 or reg->r64 via
__update_reg_bounds(), __reg_deduce_bounds(), or __update_bounds_from_step()
when the narrowed low 32 bits contradict reg's 64-bit bounds, subreg tnum, =
or
base/step progression. Similarly, if tnum_subreg(reg->var_off) and
tnum_subreg(low.var_off) do not overlap (!tnum_overlap()), tnum_intersect()
ORs conflicting constant bits together.

Contradictions can reach this arm in several ways during check_cond_jmp_op()
-> sync_linked_regs():

1. Mixed link kinds: if r6 is a wide unknown scalar (BPF_REG_LINK_NONE),
   w7 =3D w6 (BPF_REG_LINK_ZEXT), and r8 =3D r6; r8 +=3D 2 (BPF_REG_LINK_FU=
LL),
   narrowing r8 with if w8 !=3D 7 goto out syncs r6->r32 to [5, 5] while
   skipping r7 because r7->link_kind !=3D r8->link_kind. A subsequent
   if w7 !=3D 9 goto out then enters the new arm for r6 and r8, intersecting
   [5, 5] with [9, 9] and [7, 7] with [11, 11] to leave r6->r32 and r8->r32
   as CNUM32_EMPTY.

2. Sign-extending mov (BPF_REG_LINK_SEXT): if a wide r6 has its low 32 bits
   pinned by if w6 !=3D 5 goto out (so r6->r32 is [5, 5]), r7 =3D (s32)r6 l=
inks
   r7 with BPF_REG_LINK_SEXT while coerce_reg_to_size_sx() resets r7->r32 to
   [S32_MIN, S32_MAX]. A following if w7 !=3D 8 goto out enters the new arm
   and intersects r6->r32 ([5, 5]) with [8, 8].

3. BPF_JSET fallthrough: in regs_refine_cond_op(), the BPF_JSET | BPF_X
   fallthrough path calls __mark_reg_unbounded() before masking var_off.
   After w7 =3D w6; if w6 =3D=3D 0 goto out; (where r6->r32 is [1, U32_MAX]=
),
   if w7 & -1 goto out refines r7 to 0 on fallthrough and syncs back to r6,
   intersecting [1, U32_MAX] with [0, 0].

4. Step or tnum conflict inside reg_bounds_sync(): if a wide r6 has step > 1
   (for example step =3D=3D 3) and w7 =3D w6 resets r7->step to 1 via
   zext_32_to_64(), narrowing w7 to a value in r6->r32 that is not a
   multiple of 3 passes cnum32_intersect_with() and then becomes empty in
   __update_bounds_from_step(r6) at the end of reg_bounds_sync().

When reg is left in this state, any subsequent instruction that checks it v=
ia
reg_bounds_sanity_check() triggers verifier_bug() ("range bounds violation"=
),
emitting a BPF_WARN_ONCE() and returning -EFAULT when
BPF_F_TEST_REG_INVARIANTS is enabled.

Should this arm save struct bpf_reg_state prev =3D *reg and restore *reg =
=3D prev
if !tnum_overlap(tnum_subreg(reg->var_off), tnum_subreg(low.var_off)) or if
range_bounds_violation(reg) is true after reg_bounds_sync(reg)?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020161907.2115=
379-1-vineet.gupta@linux.dev?part=3D8
