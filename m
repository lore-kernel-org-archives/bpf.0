Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6267135A933
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786750076; cv=none; b=B9eqrcA4E8//KWX7VUYZQkQee9ZYnPXkoYbD2p3oFXtQuhyCJ3bMw3knnuBGnJjPmldr2j526P++Ip0oK0Dy9oGQkbjWONNBvkM799Z4L2tHwl5nhmjyqzu1i5oW56HlZ61M2D60Fx2crUuU+NCcVdZ9FqVY868z3TDMfGTOvyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786750076; c=relaxed/simple;
	bh=oMMpDu8i8xr7e64RWTVFqcKUjWrjGhghkfIQHU/RdVc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q3oFpCBiNNtJbR5gPe35NT/mBXEJ9eH2vbvrzUk4s7rtGiP1MwLuqVMO9jsFCJ1X/klYxlXtlxPihJHJuIZsyHAMpPm0PWL8vcjwZVdOXy7WObORGSFDDH68FXkNZ6l38ES0MdxZkZUxokvpgwCqrHivZhuuZb+h9npNrOwRDZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3G3O01S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3G3O01S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF49D1F000E9;
	Fri, 14 Aug 2026 23:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786750075;
	bh=+Ki58PJh6Y3ixv3fpACCVLzUC52SSwbJFyawJgJwIo0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H3G3O01SU+IGGMkv8s0HPP/7tJ3J+D/amneYTpQiNpOSxFGDw3W6aSLjFq7X+fJeE
	 ryEmAYeEQziGHupSNp5a7EXuJYlS/IObuU0BlR/fg3DhLOR9sCqyIuzKdk3mWOTAq6
	 QYzJd3OZf33WmdiNOyZHjTbxpc4qu3ss1kzZSjiZy/M1v66UsDxyRvQ3ZnkDpoqpXw
	 RoRU7jOqymDEUXDscnyQl8iALc6pfcWiPvG74NsR1r19ieP/pSgHBbbGrIJ+q4DAtW
	 Y2KyM2Xgh/cz35Mva3n+6sUZxu2GZp+o4evjzva90vANUAkh2lT0qenOy3D1qQXizS
	 m+uGH5y4mIIWg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC bpf-next 4/6] selftests/bpf: cover low-32 subreg-equal
 link for zero-extending movs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineet Gupta" <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814231945.3884596-5-vineet.gupta@linux.dev>
References: <20260814231945.3884596-1-vineet.gupta@linux.dev>
 <20260814231945.3884596-5-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 23:27:54 +0000
Message-Id: <20260814232754.CF49D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Logic error in regression test rendering it ineffective
- [Low] Multi-line comment style violation in BPF subsystem
--

--- Patch [4]: [RFC bpf-next 4/6] selftests/bpf: cover low-32 subreg-equal =
link for zero-extending movs ---
commit c52a4172a626e9c98f4a644af71ceb18fe331f7d
Author: Vineet Gupta <vineet.gupta@linux.dev>

selftests/bpf: cover low-32 subreg-equal link for zero-extending movs

This commit adds a new test subreg_eq_zext_mov_narrow and updates existing
tests to verify the verifier's low-32 BPF_FLAG_SUBREG_ZEXT link behavior
for zero-extending moves. It also introduces tests to cover the destination
driven direction and the preservation of wide ADD_CONST sources.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c =
b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> index c80747c16bcf7..2cc6f9e45aff3 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c

[ ... ]

> @@ -711,4 +711,119 @@ l_exit_%=3D:							\
>  	: __clobber_all);
>  }

[ ... ]

> +/*
> + * Dest-driven direction, zero-extend flavour: narrowing the LINKED regi=
ster
> + * must not narrow the wide base.
> + *
> + * w7 =3D w6 shares only r6's low 32 bits; r7's high half is zero, r6's =
is
> + * unknown. Learning r7 =3D=3D 0 therefore says nothing about r6, and
> + * sync_linked_regs() must not copy r7's state onto it. Rejected iff the=
 base
> + * is left alone.
> + *
> + * This is the shape that catches a lost BPF_FLAG_SUBREG_ZEXT: if the fl=
ag is
> + * dropped while the shared ->id survives, the pair looks like a full 64=
-bit
> + * equality, the dest-driven guard is bypassed and r6 wrongly becomes 0.
> + */
> +SEC("socket")
> +__failure __msg("div by zero")
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__naked void zext_dest_driven_does_not_narrow_base(void)
> +{
> +	asm volatile ("						\
> +	call %[bpf_get_prandom_u32];				\
> +	r6 =3D r0;		/* r6 low =3D unknown u32 */	\
> +	call %[bpf_get_prandom_u32];				\
> +	r0 <<=3D 32;						\
> +	r6 |=3D r0;		/* r6 =3D full 64-bit unknown (base) */ \
> +	w7 =3D w6;		/* low-32 ZEXT link */		\
> +	if r7 !=3D 0 goto l_out_%=3D;/* r7 =3D=3D 0: low 32 bits are 0 */ \
> +	if r6 !=3D 0 goto l_out_%=3D;/* r6 may still have high bits set */ \

[Severity: Medium]
Does this logic correctly catch a regression when a buggy verifier is teste=
d?

If a buggy verifier incorrectly narrows r6 to exactly 0, wouldn't it evalua=
te
"r6 !=3D 0" as statically false, and then fall through to the division by z=
ero,
just like a correct verifier that sees r6 with unknown high bits?

Since both correct and buggy verifiers evaluate both branches and fall thro=
ugh
to the division, wouldn't this test always pass?

Would changing the branch to "if r6 =3D=3D 0 goto l_out_%=3D;" correctly al=
low a
buggy verifier to skip the division and incorrectly accept the program,
failing the test?

> +	r0 /=3D 0;		/* must stay reachable */	\
> +l_out_%=3D:							\
> +	r0 =3D 0;							\
> +	exit;							\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/verifier_reg_equal.c b/too=
ls/testing/selftests/bpf/progs/verifier_reg_equal.c
> index dc1d8c30fb0ee..e6fbbfaeedcb7 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
> @@ -31,23 +31,25 @@ l1_%=3D:	exit;						\
>  }
> =20
>  SEC("socket")
> -__description("check w reg not equal if r reg upper32 bits not 0")
> -__failure __msg("R1 !read_ok")
> +__description("w reg shares r reg low32 via subreg link even if upper32 =
not 0")
> +__success
>  __naked void subreg_equality_2(void)
>  {
>  	asm volatile ("					\
>  	call %[bpf_ktime_get_ns];			\
>  	r2 =3D r0;					\
> -	/* Upper 4-bytes of r2 may not be 0, thus insn	\
> -	 * w3 =3D w2 should not propagate reg id,	and	\
> -	 * w2 < 9 comparison should not propagate	\
> -	 * the range for r3 either.			\
> +	/* Upper 4-bytes of r2 may not be 0. w3 =3D w2 is a 32-bit	\

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the BPF subsystem
style guide?

The modern kernel multi-line comment style used in the BPF subsystem requir=
es
the opening "/*" to be on its own line.

> +	 * zero-extending mov, so w3 shares only r2 low 32 bits	\
> +	 * (a BPF_FLAG_SUBREG_ZEXT link) and its high bits are zero. The	\
> +	 * w2 < 9 comparison then narrows r3 to [0, 8] via the link,	\
> +	 * so if r3 < 9 is always taken and the illegal r1 read below	\
> +	 * is unreachable.				\
>  	 */						\
>  	w3 =3D w2;					\
>  	if w2 < 9 goto l0_%=3D;				\
>  	exit;						\

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814231945.3884=
596-1-vineet.gupta@linux.dev?part=3D4
