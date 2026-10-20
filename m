Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514585;
	b=x2pB6rEbezYBSibIz894wH/HSpHu/rTOf6Q8gty3Ab9KSYaDz5jbDcQux3K9s8JBBSzO
	 4kaH6TbwNP8GnoD5mDoIu7NkIaW+2ks9IsD+10ktJIv2Jbiz/2rTfDJ0Io0bf/DMu90uM
	 rM6xKPny2iztLE5z+dmUL4RTU0IV588pO+Hn7OVWwPKhDZfkROcpj5TxgTc08g133j41E
	 CSInIl/5+cZN1nXMWaenJa6yMqufzf/PaIbvI2CFBG04aGKmCy1BjlRl2YemDr6pIAPwU
	 Nwfbi2wldP0MG7wnkBrWxVtJDUdvIrJ3vAoImqy6y1hG2u+fUhG8SaxMCzRtZ5KRs3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514585;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/owV5taIEGMcTkaOevOiapZDdTSVeRPFnQQ681SbOVs=;
	b=sQybChFIsfv+MVJu/EbyZQTDzSq3FPvP9QZWhIgSQ+mSMGwJFeC66Gwup4zhyG0saisi
	 vO0Pz72yce0t3J5CeY/qmgz0bKCmoAusDHazAXqR+jVULZQNoxq+r7YBOqPUi2ztVQ83f
	 H8jpzBq0viiGCeOuLg/W79EX4J2YJWqN6Gg2yczctSfV4vfFwF0W0s+/npcAAK4CHMCdE
	 IwhB+Ny1LXxujcnMSdlhY+NMfGQqR1SoVCnjOlqKCXAs5vOUOwRdCwtJJFMERgm3jYPcw
	 ui2UpZGN03gC4n9SvYy60sDasRAiC8ANTv7TyTVO96L62fHvBoE83sHilD5peuX6F2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38021606A335
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 16:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFA41F000CA;
	Tue, 20 Oct 2026 16:43:04 +0000 (UTC)
Message-ID: <sashiko-outbox-179371@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 11/12] [do not merge] bpf: Track low-32
 scalar equality across narrowing stack spills
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineet Gupta" <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261020161907.2115379-12-vineet.gupta@linux.dev>
References: <20261020161907.2115379-1-vineet.gupta@linux.dev>
 <20261020161907.2115379-12-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 16:42:34 +0000
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
- [Medium] bpf: zext_32_to_64() on 4-byte spill loses signed bounds on ldsx=
 fill
--

commit b63f0039bbb8ede3ae56c9d69df1283e246bde61
Author: Vineet Gupta <vineet.gupta@linux.dev>

bpf: Track low-32 scalar equality across narrowing stack spills

This patch tracks low-32 scalar equality across 4-byte narrowing stack
spills by assigning a scalar ID, truncating the spilled slot with
zext_32_to_64(), and setting link_kind to BPF_REG_LINK_ZEXT.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 083b5bd70d3fa..de2a5c048a29a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -3927,15 +3928,46 @@ static int check_stack_write_fixed_off(struct bpf=
_verifier_env *env,
>  	mark_stack_slot_scratched(env, spi);
>  	if (reg && !(off % BPF_REG_SIZE) && reg->type =3D=3D SCALAR_VALUE && en=
v->bpf_capable) {
>  		bool reg_value_fits;
> +		bool subreg_link;
> =20
>  		reg_value_fits =3D get_reg_width(reg) <=3D BITS_PER_BYTE * size;
> +		/*
> +		 * A narrowing spill stores the low 32 bits of the source, so
> +		 * the slot is their zero-extension: record a low-32 link
> +		 * rather than dropping the relation, as a 32-bit mov does.
> +		 * A store never sign-extends, so there is only one link kind here.
> +		 */
> +		subreg_link =3D !reg_value_fits && size =3D=3D 4;
> +
>  		/* Make sure that reg had an ID to build a relation on spill. */
> -		if (reg_value_fits)
> +		if (reg_value_fits || subreg_link)
>  			assign_scalar_id_before_mov(env, reg);
>  		save_register_state(env, state, spi, reg, size);
> -		/* Break the relation on a narrowing spill. */
> -		if (!reg_value_fits)
> -			bpf_clear_scalar_id(&ss->spilled_ptr);
> +		if (!reg_value_fits) {
> +			if (subreg_link && reg->id) {
> +				/*
> +				 * save_register_state() copies the source
> +				 * whole, but the store only wrote its low 32
> +				 * bits, so truncate to those before recording
> +				 * the kind: a slot asserting BPF_REG_LINK_ZEXT
> +				 * over the source's wider bounds is a register
> +				 * state that contradicts itself.
> +				 *
> +				 * Keep the source's delta, though: the slot
> +				 * holds (u32)(base + delta), so resetting it to
> +				 * 0 would record a relation off by that delta.
> +				 */
> +				zext_32_to_64(&ss->spilled_ptr);
> +				ss->spilled_ptr.link_kind =3D BPF_REG_LINK_ZEXT;

[Severity: Medium]
Does calling zext_32_to_64() on ss->spilled_ptr cause a precision
regression when the 4-byte slot is subsequently filled by a sign-extending
load (ldsx)?

When spilling a scalar register whose signed range straddles zero (for
example [-10, 10], where reg_umax(reg) is U64_MAX and get_reg_width(reg)
is 64) with a 4-byte store (*(u32 *)(r10 - 8) =3D rX), subreg_link is true
and zext_32_to_64(&ss->spilled_ptr) is called:

static void zext_32_to_64(struct bpf_reg_state *reg)
{
	reg_step_check_unsigned(reg, 32);
	reg->var_off =3D tnum_subreg(reg->var_off);
	reg_set_urange64(reg, reg_u32_min(reg), reg_u32_max(reg));
}

Because r32 =3D [-10, 10] straddles zero in unsigned 32-bit arithmetic
(u32_min =3D 0, u32_max =3D 0xffffffff), zext_32_to_64() overwrites
ss->spilled_ptr.r64 with [0, 0xffffffff] while leaving [-10, 10] only in
r32.

If the slot is then reloaded with a sign-extending load (*(s32 *)(r10 - 8),
*(s16 *)(r10 - 8), or *(s8 *)(r10 - 8)), check_stack_read_fixed_off()
copies ss->spilled_ptr to the destination register and check_mem_access()
calls coerce_reg_to_size_sx():

static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
{
	...
	/* If every value fits the signed N-bit range sign extension is a noop. */
	if (reg_smin(reg) >=3D -limit && reg_smax(reg) < limit)
		return;

Because coerce_reg_to_size_sx() inspects reg_smin(reg) and reg_smax(reg)
from r64 rather than r32, smax is 0xffffffff (>=3D limit), so the early
return no longer triggers and coerce_reg_to_size_sx() falls through to
set_sext64_default_val(), resetting both r64 and r32 to [S32_MIN, S32_MAX]
(or the full S16/S8 range).

> +			} else {
> +				/*
> +				 * Nothing to relate: either the source has no
> +				 * id to share, or the store is narrower than
> +				 * the 32 bits a link can describe.
> +				 */
> +				bpf_clear_scalar_id(&ss->spilled_ptr);
> +			}
> +		}
>  	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
>  		   env->bpf_capable) {
>  		struct bpf_reg_state *tmp_reg =3D &env->fake_reg[0];
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020161907.2115=
379-1-vineet.gupta@linux.dev?part=3D11
