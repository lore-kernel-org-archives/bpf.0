Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A305452A8
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059872; cv=none; b=NitXElm/Y//O/sp8nod9YlkBjNESN9u2JlMMpwsza3Z0CWR4FH4yz8TLaX4uWtzzmSYSswGDaS4BAFY+3ydyc3orr9zPS0heQyISg4LOei4LQAg4WIjFST1MDayCUb83irK4VRlgf8/HZumqwzTshaYwEaOuUhQFKB9FOBDWipk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059872; c=relaxed/simple;
	bh=szn5QYSl+xXgoArirrjpmFyUZShewLDV/3Z9tI3H8rI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lx00o8fwNi53m8+piEIC8SiyG9nqT1084zOx2OyMj/Rv0D9O6rcEhejEKIHLJh6Bat4WEcF1h0x1XhYeBH8I7xAH/ED6dh/U4X6JgLhqREwOJcxe/hDXTjypTMoRzOeIVchTHJxuPQ99o6cGZodrjEJwoPGshb8zalCgB8tOcuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpuxTSr0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpuxTSr0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8601F000FF;
	Thu, 10 Sep 2026 17:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789059859;
	bh=4kO0OfP5RR9ktVRc/Y6XvM/wclz/gH5BFvNR5hjz6m0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RpuxTSr0byLf/sg6IkqvVC8g7qMvSNzGQYThy76IIZ+OYByoDYnXda2GSgm6JTJMN
	 tKDyl5Em6lCvUqDsvU1gKokDkb4M4g4zPosZvXu8l45Yx21LfhGVl2qMhayLqXtqXk
	 hUekiWFKQ+85ON9/1hmPqvelKmGM1boGGR6CMqP4NbX/DsdHodvbesry6mSD4a3LIa
	 CYzooWU/u4YeVGdSf0kd8ivE85nwOZ0uE8ItxjhogSZzpLSH7jyEho6NAt+RYxa/Zg
	 3UqAQH7MHFBwEioMdMqsYH+aL+UyhOaf7lRq0d/o2sGIBPdy1PXyw5ediO59uxTRfd
	 TFMYScjabGWCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 09/13] bpf: track low-32 scalar equality
 across narrowing stack fills
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineet Gupta" <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260910164635.459558-10-vineet.gupta@linux.dev>
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
 <20260910164635.459558-10-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 17:04:18 +0000
Message-Id: <20260910170419.4C8601F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Sign-extending loads incorrectly preserve conflicting SUBREG_Z=
EXT metadata.
--

commit f939550a777ae3d2a7392dec744bffdc9fabcdda
Author: Vineet Gupta <vineet.gupta@linux.dev>

bpf: track low-32 scalar equality across narrowing stack fills

This commit records a low-32 link for stack fills narrower than the wider
source, allowing the verifier to deduce relations between 32-bit narrows
and their wider origins. It also adjusts check_mem_access() to not clear
the id of a ->subreg register on a sign-extending load.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 308ff53232f06..89be1240c99ae 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -3968,18 +3969,34 @@ static int check_stack_read_fixed_off(struct bpf_=
verifier_env *env,
> =20
>  			if (size <=3D spill_size &&
>  			    bpf_stack_narrow_access_ok(off, size, spill_size)) {
> -				if (env->bpf_capable && size =3D=3D 4 && spill_size =3D=3D 4 &&
> -				    get_reg_width(reg) <=3D 32)
> +				bool narrowing =3D get_reg_width(reg) > size * BITS_PER_BYTE;
> +				/*
> +				 * A narrowing fill keeps only the slot's low 32 bits,
> +				 * so record a low-32 link rather than dropping the
> +				 * relation, as a 32-bit mov from a wide source does.
> +				 * Which kind depends on how the load fills the high
> +				 * half, hence is_ldsx.
> +				 */
> +				bool subreg_link =3D narrowing && size =3D=3D 4;
> +
> +				if (env->bpf_capable && size =3D=3D 4 &&
> +				    (subreg_link || (spill_size =3D=3D 4 && !narrowing)))
>  					/* Ensure stack slot has an ID to build a relation
>  					 * with the destination register on fill.
>  					 */
>  					assign_scalar_id_before_mov(env, reg);
>  				state->regs[dst_regno] =3D *reg;
> =20
> -				/* Break the relation on a narrowing fill.
> -				 * coerce_reg_to_size will adjust the boundaries.
> -				 */
> -				if (get_reg_width(reg) > size * BITS_PER_BYTE)
> +				if (subreg_link && reg->id)
> +					state->regs[dst_regno].subreg =3D
> +						is_ldsx ? SUBREG_SEXT : SUBREG_ZEXT;
> +				else if (narrowing)
> +					/*
> +					 * Nothing to relate: either the slot has
> +					 * no id to share, or the fill is narrower
> +					 * than the 32 bits a link can describe.
> +					 * coerce_reg_to_size adjusts the bounds.
> +					 */
>  					clear_scalar_id(&state->regs[dst_regno]);

[Severity: Critical]
When narrowing is false, does this preserve a stale SUBREG_ZEXT property for
a sign-extending load?

If a register with SUBREG_ZEXT is spilled to the stack and then read back
via a 4-byte sign-extending load, narrowing evaluates to false. This allows
the destination register to inherit the SUBREG_ZEXT property directly from
the stack slot, even though it is being sign-extended.

[ ... ]

> @@ -6736,13 +6753,15 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, struct b
>  			 * Sign-extension can change the register value relative
>  			 * to a scalar it is linked with by id (e.g. a zero-
>  			 * extending fill of the same spilled stack slot), thus
> -			 * drop the shared id in that case.
> +			 * drop the shared id in that case. A ->subreg link is
> +			 * the exception: it already records that only the low
> +			 * 32 bits are shared, and how the high half follows.
>  			 */
>  			bool no_sext =3D reg_umax(&regs[value_regno]) <
>  					(1ULL << (size * BITS_PER_BYTE - 1));
> =20
>  			coerce_reg_to_size_sx(&regs[value_regno], size);
> -			if (!no_sext)
> +			if (!no_sext && !regs[value_regno].subreg)
>  				clear_scalar_id(&regs[value_regno]);

[Severity: Critical]
Does this check wrongly preserve the ID for SUBREG_ZEXT registers that
have just been sign-extended?

Because SUBREG_ZEXT is non-zero, !regs[value_regno].subreg evaluates to
false, skipping the clear_scalar_id() call for a register that might hold
a sign-extended negative value.

Later, if a conditional branch triggers sync_linked_regs(), it will see
SUBREG_ZEXT and invoke reconstruct_zext32(). This would forcefully set the
bounds to a zero-extended positive value.=20

At runtime, the discrepancy between the verifier's zero-extended positive
bounds and the actual sign-extended negative value could bypass bounds chec=
ks,
potentially leading to out-of-bounds memory reads or writes.

Should this explicitly check for SUBREG_SEXT rather than just allowing any
non-zero ->subreg value?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910164635.4595=
58-1-vineet.gupta@linux.dev?part=3D9
