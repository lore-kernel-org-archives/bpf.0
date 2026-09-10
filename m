Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7983B0AEA
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059630; cv=none; b=o8itdfrAbHtXOVnPhzr5m+vkbW6s8i/D+vhG4DxbTnSvrFcCMbQ/WavGhvXAEk7f5QqsFg9zUD/b9BJlwyRmsQBSsuPC0K809nQxPi8A9OCThNgqmeFSy6cBpDgXVc5EFK28IWS8pzLMu1QlGY000fQisFBzMkZp7THVwXLWObI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059630; c=relaxed/simple;
	bh=IFz0gVlUaQfReX3mzNLHFXbdVRZnqOXVp/ms0k4PuFs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qSFAzW/SnebYhY91Gg7QiCLjlRSTO2xXs4jKhvhNIBEr4PGdhX5NSxbhv+eYKTpoH/WTTbsTWhDHLkA/8us5/opLcIEt2s7ZyOlBBOAEv1Qzr9fDgGIn7hu5cbVzqXtYX3zoVc5uWBD0GyIr3d2Zc21Fj4Br1EHe/FZW8Wa4DF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ba1Uwtze; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ba1Uwtze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A4E1F000FF;
	Thu, 10 Sep 2026 17:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789059620;
	bh=oui7bGJIFg4wz2m2B+DzPH3RZZe1hdEC0i7ig70oXdM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ba1Uwtze9ACHqoOBxURR7u1Eu9xdU57YhS/PAF8ryj/BlDtOOaD4eSM9hFDQ87/2Y
	 1MMOqhJFth4O/HpZHJofFrAsnKDqoQ5ufztFzUevNd8bUgxKziMJIIeQdydAULk6kB
	 RI47+uWCqabQlrkeUZvot8b0qBh7kZjHl03veXYB9eU8rTBjYpx5CTf8TZghDbQrvr
	 iUeTMBkAk9rT8ZL/cXCy22eJJAki/9sHsVEZXjcaqa86SoLMvw1JCS8b8fTUw8qgsC
	 PKyzwZyoUeS/nahHNwJsq54elk3OecnBHS4dq8v7Nw6UHijdJDYydrtpAJdiPN3E4P
	 eAgX2DvhGl9Mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 10/13] selftests/bpf: cover the low-32 link
 for narrowing stack fills
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineet Gupta" <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260910164635.459558-11-vineet.gupta@linux.dev>
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
 <20260910164635.459558-11-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 17:00:19 +0000
Message-Id: <20260910170020.04A4E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added tests for narrow stack fills hardcode memory off=
sets (e.g., `(r10 - 8)`) which are only correct on little-endian architectu=
res. On big-endian architectures like s390x, these offsets do not point to =
the lower bits, causing the BPF verifier to reject the programs and resulti=
ng in test failures.
--

commit a42f9a6d4d49f17385f014eede55d6e82094a838
Author: Vineet Gupta <vineet.gupta@linux.dev>

selftests/bpf: cover the low-32 link for narrowing stack fills

This commit adds five new BPF programs to test the verifier's handling of
narrowing stack fills, specifically targeting low-32 links and sign-extensi=
on
behavior.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c =
b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> --- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c

[ ... ]

> +SEC("socket")
> +__success
> +__naked void zext_fill_narrow_from_wide_spill(void)
> +{
> +	asm volatile ("						\
> +	call %[bpf_get_prandom_u32];				\
> +	r6 =3D r0;						\
> +	call %[bpf_get_prandom_u32];				\
> +	r0 <<=3D 32;						\
> +	r6 |=3D r0;		/* r6 =3D full 64-bit unknown */	\
> +	*(u64 *)(r10 - 8) =3D r6;	/* slot linked to r6 */		\
> +	r2 =3D *(u32 *)(r10 - 8);	/* narrowing fill, forms the link */ \

[Severity: Medium]
On big-endian architectures like s390x, won't reading 32 bits from offset -8
target the upper 32 bits instead of the lower 32 bits?

The bpf_stack_narrow_access_ok() check in the verifier expects to read the
least significant bytes of the spill slot, which on big-endian are located
at offset -4 for a 32-bit read. Could this hardcoded offset cause the verif=
ier
to reject the program and break the test on big-endian systems?

> +	if w6 !=3D 0 goto 1f;	/* narrows r6, propagates to r2 */ \
> +	if r2 =3D=3D 0 goto 1f;					\
> +	r0 /=3D 0;						\
> +1:								\
> +	r0 =3D 0;							\
> +	exit;							\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}

[ ... ]

> +SEC("socket")
> +__failure __msg("div by zero")
> +__naked void zext_fill_byte_forms_no_link(void)
> +{
> +	asm volatile ("						\
> +	call %[bpf_get_prandom_u32];				\
> +	r6 =3D r0;						\
> +	call %[bpf_get_prandom_u32];				\
> +	r0 <<=3D 32;						\
> +	r6 |=3D r0;						\
> +	*(u64 *)(r10 - 8) =3D r6;					\
> +	r2 =3D *(u8 *)(r10 - 8);	/* 1-byte fill: no link */	\

[Severity: Medium]
Does this hardcoded 8-bit read from offset -8 target the most significant b=
yte
rather than the least significant byte on big-endian architectures?

> +	if w6 !=3D 0 goto 1f;					\
> +	if r2 =3D=3D 0 goto 1f;	/* not deduced */		\
> +	r0 /=3D 0;						\
> +1:								\
> +	r0 =3D 0;							\
> +	exit;							\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}

[ ... ]

> +SEC("socket")
> +__success
> +__naked void sext_fill_narrow_from_wide_spill(void)
> +{
> +	asm volatile ("						\
> +	call %[bpf_get_prandom_u32];				\
> +	r6 =3D r0;						\
> +	call %[bpf_get_prandom_u32];				\
> +	r0 <<=3D 32;						\
> +	r6 |=3D r0;		/* r6 =3D full 64-bit unknown */	\
> +	*(u64 *)(r10 - 8) =3D r6;	/* slot linked to r6 */		\
> +	r2 =3D *(s32 *)(r10 - 8);	/* narrowing sx fill */		\

[Severity: Medium]
Similar to the previous cases, will this 32-bit read from offset -8 read the
upper 32 bits on big-endian systems and cause verifier bounds tracking to f=
ail?

> +	if w6 !=3D -1 goto 1f;	/* narrows r6, propagates to r2 */ \
> +	if r2 =3D=3D -1 goto 1f;	/* sign-extended, not 0xffffffff */ \
> +	r0 /=3D 0;						\
> +1:								\
> +	r0 =3D 0;							\
> +	exit;							\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}

[ ... ]

> +SEC("socket")
> +__failure __msg("div by zero")
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__naked void fill_kinds_reach_different_values(void)
> +{
> +	asm volatile ("						\
> +	call %[bpf_get_prandom_u32];				\
> +	r6 =3D r0;						\
> +	r6 &=3D 1;						\
> +	call %[bpf_get_prandom_u32];				\
> +	r8 =3D r0;						\
> +	call %[bpf_get_prandom_u32];				\
> +	r0 <<=3D 32;						\
> +	r8 |=3D r0;						\
> +	*(u64 *)(r10 - 8) =3D r8;					\
> +	if r6 >=3D 1 goto 2f;					\
> +	r2 =3D *(s32 *)(r10 - 8);	/* sign-extending fill */	\

[Severity: Medium]
Will these narrow fills also fail verifier checks on big-endian machines due
to the fixed -8 offset pointing to the wrong 32-bit half?

> +	goto 1f;						\
> +2:								\
> +	r2 =3D *(u32 *)(r10 - 8);	/* zero-extending fill */	\
> +1:								\
> +	if w8 !=3D -1 goto 3f;					\
> +	if r2 =3D=3D -1 goto 3f;	/* only the sign-extending path */ \

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910164635.4595=
58-1-vineet.gupta@linux.dev?part=3D10
