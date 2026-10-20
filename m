Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514429;
	b=vFN3DT9h5u21ePeYtuJk4AcgdKnW96sqH2RIi0hprfEYyEmCiGH1xMrFGFuLPmKjB5hi
	 03c/XZlUuOzuOtSuK30d9eU5hUZKSOXjcEJuGn8GOh/Y+PELk8Hgwss86oFKNmNR0BeKe
	 Qe7Q3fSNMRUntSj+qWhB3zW2L4rVKmBYQqP1SmRFJVDLYLtKBoiKGlAKH1LTxhl4iVPiN
	 mObr1UJsrGX5tpUTxlDTRN70BTkZCy2hcG8IPJrWxM5hGfWAMSNwDDh6hlbOi3387LVGA
	 XPgub0hcqKg7xS0ZnE/TsKA2cMS4z0qr0c4ZSoWmIdKNF02N4awJ68QzcY9lVM4Alsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514429;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WV5u3i930IYdub8VqB7hzebv3VGUvXoUzVDIBMdZvJI=;
	b=U8NzXPEiQ6hjYZgqOlmOjzRkMjrAPf9jcyrEOIsDUWhCIWptwZZOvDADYhY1ZkZvqiiR
	 4yaSuUIdoiYQUqOK5JDAVB+xIBId6xAYeo4E6vvYdTVlpmEGzQWvpC0qxY06KFfCRKt49
	 b5nhdCBQTpPSRjlcfVFRBn3S+aDhEQeSBPe1GqxeXckS9a8qeHkmxJwHtJ0QptqX9KBov
	 slZYh0GCXpTTZ7hfyRbqW943rdqndKciT3dUgH7GAN6YE3kuU+xctrKcFrOPzODRiP0kR
	 5Qcmr8Cwn0ZskwjXUl9kbsd9sIj2rr8MHNr37Pp1OwCgQUz2jOOsEZD7wqIhOGh2EpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18BF606A31B
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 16:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4606D1F00ADB;
	Tue, 20 Oct 2026 16:40:28 +0000 (UTC)
Message-ID: <sashiko-outbox-179367@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 04/12] bpf: Track low-32 scalar equality
 across zero-extending movs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineet Gupta" <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261020161907.2115379-5-vineet.gupta@linux.dev>
References: <20261020161907.2115379-1-vineet.gupta@linux.dev>
 <20261020161907.2115379-5-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 16:39:57 +0000
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
- [Medium] bpf: empty or corrupted range after intersection in sync_linked_=
regs()
--

commit 05d23d7192de1c6009703f8fbe1537ad78dda89e
Author: Vineet Gupta <vineet.gupta@linux.dev>

bpf: Track low-32 scalar equality across zero-extending movs

This commit extends linked-scalar tracking across zero-extending 32-bit mov=
es
from wide 64-bit source registers using BPF_REG_LINK_ZEXT. Because a wide b=
ase
cannot be inverted across all 64 bits, sync_linked_regs() propagates bounds
forward only and intersects the derived bounds with the destination registe=
r's
existing state.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b9c20a5cc6d6f..6afd718ede647 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -18749,6 +18798,27 @@ static void sync_linked_regs(struct bpf_verifier=
_env *env, struct bpf_verifier_s
>  			if (reg->link_kind =3D=3D BPF_REG_LINK_ZEXT ||
>  			    known_reg->link_kind =3D=3D BPF_REG_LINK_ZEXT)
>  				zext_32_to_64(reg);
> +			/*
> +			 * Intersect rather than overwrite. A BPF_REG_LINK_ZEXT
> +			 * link over a wide base does not propagate back, so the
> +			 * base can be wider than what @reg has already proved
> +			 * about itself; replacing it would lose that.
> +			 */
> +			cnum64_intersect_with(&reg->r64, prev.r64);
> +			cnum32_intersect_with(&reg->r32, prev.r32);
> +			reg->var_off =3D tnum_intersect(reg->var_off, prev.var_off);
> +			/*
> +			 * An empty intersection means the two sides contradict,
> +			 * so this path is unreachable. Say nothing rather than
> +			 * say it with an empty range: reg_bounds_sync() below
> +			 * refuses to touch one, and the first later
> +			 * reg_bounds_sanity_check() would report it as a
> +			 * verifier bug, which it is not. Keeping the wider
> +			 * pre-intersect state only costs precision on a path
> +			 * that cannot be taken.
> +			 */
> +			if (range_bounds_violation(reg))
> +				*reg =3D prev;
>  			reg_bounds_sync(reg);
>  		}
>  		if (e->is_reg)

[Severity: Medium]
Can a contradiction in var_off or linear step still leave an empty range on
reg, or corrupt reg into a bogus constant, after sync_linked_regs() finishe=
s?

First, tnum_intersect() in kernel/bpf/tnum.c assumes its arguments overlap:

/* Note that if a and b disagree - i.e. one has a 'known 1' where the other=
 has
 * a 'known 0' - this will return a 'known 1' for that bit.
 */
struct tnum tnum_intersect(struct tnum a, struct tnum b)
{
	u64 v, mu;

	v =3D a.value | b.value;
	mu =3D a.mask & b.mask;
	return TNUM(v & ~mu, mu);
}

When reg->var_off and prev.var_off disagree on a known bit without
tnum_overlap(reg->var_off, prev.var_off) being checked first, tnum_intersec=
t()
turns the conflicting bit into a known 1.

Second, range_bounds_violation(reg) only checks cnum32_is_empty(reg->r32) ||
cnum64_is_empty(reg->r64), and is only called before reg_bounds_sync(reg). =
Any
contradiction between the intersected r64/r32 ranges and var_off (via
__update_reg_bounds()) or base/step (via __update_bounds_from_step()) happe=
ns
inside reg_bounds_sync(reg), after the range_bounds_violation(reg) check has
already passed.

For example, in a socket filter:

  w7 =3D w6;                /* r6 is unknown 64-bit; r7 gets BPF_REG_LINK_Z=
EXT */
  if w7 < 4 goto out;
  if w7 > 5 goto out;
  if w7 & 2 goto out;     /* r7: r64=3D[4, 5], var_off=3D(0x4; 0x1) */
  if r6 & 2 goto l1;

At l1, r6 has var_off=3D(0x2; ~2ULL), so after zext_32_to_64(reg), reg has
r64=3D[2, U32_MAX] and var_off=3D(0x2; 0xfffffffd). Intersecting r64 and r3=
2 with
prev produces [4, 5], which is non-empty, so range_bounds_violation(reg) is
false. However, tnum_intersect() produces (0x6; 0x1) ([6, 7]), and
reg_bounds_sync(reg) then intersects [4, 5] with [6, 7], leaving reg->r64 a=
nd
reg->r32 empty and triggering a verifier warning on a subsequent r7 %=3D r9=
 (with
r9 =3D 0).

Worse, if w7 was narrowed to a single constant 4 (r64=3D[4, 4],
var_off=3D(0x4; 0x0)) before "if r6 & 2 goto l1", tnum_intersect() fabricat=
es
the constant var_off=3D(0x6; 0x0). Inside
reg_bounds_sync()->__update_reg_bounds()->__update_reg64_bounds():

	cnum64_intersect_with(&reg->r64, cnum64_from_tnum(reg->var_off));

	/* Check if u64 and tnum overlap in a single value */
	tnum_next =3D tnum_step(reg->var_off, reg_umin(reg));
	umin_in_tnum =3D (reg_umin(reg) & ~reg->var_off.mask) =3D=3D reg->var_off.=
value;
	tmax =3D reg->var_off.value | reg->var_off.mask;
	if (umin_in_tnum && tnum_next > reg_umax(reg)) {
		___mark_reg_known(reg, reg_umin(reg));
	} else if (!umin_in_tnum && tnum_next =3D=3D tmax) {
		___mark_reg_known(reg, tmax);
	}

cnum64_intersect_with() sets reg->r64 to CNUM64_EMPTY, where reg_umin(reg)
returns 0 and reg_umax(reg) returns U64_MAX. That satisfies !umin_in_tnum &&
tnum_next =3D=3D tmax (6 =3D=3D 6) and calls ___mark_reg_known(reg, 6), ove=
rwriting
r7 =3D=3D 4 with the contradicted constant r7 =3D=3D 6.

Even when tnum_overlap(reg->var_off, prev.var_off) holds, reg_bounds_sync(r=
eg)
can still empty r64/r32 if the intersected cnum range and intersected tnum =
(or
base/step in __update_bounds_from_step()) have no common points.

Should sync_linked_regs() verify tnum_overlap(reg->var_off, prev.var_off)
before calling tnum_intersect(), and also check range_bounds_violation(reg)
after reg_bounds_sync(reg) to restore *reg =3D prev?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020161907.2115=
379-1-vineet.gupta@linux.dev?part=3D4
