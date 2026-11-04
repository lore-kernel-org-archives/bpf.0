Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793756418;
	b=gj1cA8Hq3QJjL2JNi5T2Zd+el0D9qhXbrf/rcvH3m3BUG1ly/dETG24UuVqfsK+20f21
	 omjdbfQ7zyfUNsVhdsL7QRwCOg1e5wF4t/UF2kJ77w+9p6sKs+R7X1hFynNFEIQoWVImx
	 NTxPYlV5K3o8l2E2/a3qfwVgWJBD+iszrOq80eBP6QhuEogbMT4yzH+Z1mGAOJj0Scnfi
	 4OcUbVZbrLNpUqIuAxHfzFrOz/ym7wne9ujNf+bpGLJYMl0tAkmA1aEHIc9Bph4xpLXDI
	 EX3p6MIl5aHXjapi7UkTERccNsAvPd3mtGEHtn9Qv7posp088EITI+nI4GeI92kTiDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793756418;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7j074EsLQ5+HiW+n0It9s1DVaK3CFOhFA1D/KWUhlAk=;
	b=Lq7GCtMU7ADHIRg+Et+UJ8tn6f9FjALicwkpqNY/QYqfAF+rEGOjSRhh4qhFqVts49n+
	 sooGQhir6GHf4l1/CHq+y2sLEEb3FJEPUVY0qhIEzT+fGUHy9ly8rxLrwSDnhJRd7WSkK
	 VuGM61XgjcEQkf9EE6181ulXUiGOo+FgoIaftoa42e+vuj3dwga56Sa1SymG3S8wL+UzO
	 VcvMcNq8TeFF1YMBELW65i1G2p0InbDkNrS35nue0TULq9WQoEc+Wh8DGJVjLUm8m8x8y
	 hd8qhYACoTA+SmFwbw6jv0KtSWT0YYLcPs4oG3EKUZRK1y5owcdBmAgjYZ++72HEnPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QUIBh+g0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FBE606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 01:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QUIBh+g0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A141F00A02;
	Wed,  4 Nov 2026 01:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793756418;
	bh=7j074EsLQ5+HiW+n0It9s1DVaK3CFOhFA1D/KWUhlAk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=QUIBh+g0QqneYydYm4FGR8iHV7Oi0SHeIaSB8qitROYzgqpfh/HZ7r6t/81TG822d
	 fAwsaxzRZ5gsYnVUKK3CRfBllnppGSqdEa0XVxYn8qV+0jcGJ+/4qGBFgG47/ZJjpX
	 wYIYRLcQfr7CAqtetd3maSBZndoujwe9GQ3Zal2W66X/1d64ZiztVzhGR5oCB0x7FT
	 gS8OI0KxJ1MLRGgggeZUx2eMefVw1wQJ9BFq35cc5iu2r+UWZjeVds4HarlC+Yzd7m
	 u1EmB1+gnfqrL8wQ0l+bRX2gFNcE0vN0TlnvKJ2gnSL7aWhecV9AtsARF51mwAjyLH
	 xSg0B4wYUf1lg==
Message-ID: <sashiko-outbox-196371@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 04/14] selftests/bpf: Test addr_space_cast
 of pointers that are not in arena
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261104012401.1354861-5-alexei.starovoitov@gmail.com>
References: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
 <20261104012401.1354861-5-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 01:40:17 +0000
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
- [Medium] selftests/bpf: wrong stack offset in r10_stored_to_arena()
--

commit 54fbcf6815ff6f19ca4963d449d29e574fbc1941
Author: Alexei Starovoitov <ast@kernel.org>

selftests/bpf: Test addr_space_cast of pointers that are not in arena

This commit adds BPF verifier selftests in verifier_arena_cast.c to test
addr_space_cast behavior on non-arena pointers, numbers, and stack slot
liveness tracking across casts.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_cast.c b/to=
ols/testing/selftests/bpf/progs/verifier_arena_cast.c
> new file mode 100644
> index 0000000000000..14a199318d0d5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena_cast.c
> @@ -0,0 +1,800 @@

[ ... ]

> +SEC("syscall")
> +__description("arena cast: r10 is stored to arena, a pointer to map valu=
e is in the stack")
> +__failure __msg("invalid access to map value, value_size=3D8 off=3D4096 =
size=3D1")
> +__naked void r10_stored_to_arena(void)
> +{
> +	asm volatile (
> +	"r1 =3D %[arena] ll;"
> +	UPDATE_AND_LOOKUP
> +	"if r0 =3D=3D 0 goto 2f;"
> +	"r9 =3D r0;"
> +	STALE_SPILL_R7(-8)
> +	".8byte %[cast_r7_r7];"
> +	"r1 =3D r9;"
> +	"r1 +=3D 8;"
> +	"*(u64 *)(r10 - 32) =3D r1;"
> +	/* to arena, not to fp-32 */
> +	"*(u64 *)(r7 + 0) =3D r10;"
> +	"r7 =3D *(u64 *)(r10 - 32);"

[Severity: Medium]
In r10_stored_to_arena() in
tools/testing/selftests/bpf/progs/verifier_arena_cast.c, should
STALE_SPILL_R7(-8) be STALE_SPILL_R7(-32) instead?

As written, STALE_SPILL_R7(-8) gives r7 a stale stack offset of fp-8 rather
than fp-32. When *(u64 *)(r7 + 0) =3D r10 executes, static stack analysis
tracks the store against slot fp-8 (which is immediately overwritten by
SPILL_FP24_TO_FP8) and never touches slot fp-32, so the test does not
exercise joining the map value pointer in fp-32 (ARG_NONE) with r10 (fp+0).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104012401.1354=
861-1-alexei.starovoitov@gmail.com?part=3D4
