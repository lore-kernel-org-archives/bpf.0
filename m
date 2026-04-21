Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325B82AE78
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791912; cv=none; b=kTozE1guKj4Rui+Ket5ocD02R6PK/z7p9FGd5P4j0lTJ4YFTCCVKhielxmVYmvtilfz6Z7WWjwjz4RkXs0m6f+76tFPln+tKbd8+LxoAenxxxYehSzXHs18r8RSX8lXh90SFwqrIC84J+crn/BZiw9unYfhsiNMBSGJaXptISws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791912; c=relaxed/simple;
	bh=LA5Mymi5WlGDvCtb5Ih1LotxlsfbuMckFJ4yBe6jLUU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DISmKUUPVXHjJnUlG0GkDC8jdwniUdnqoeLVi3YSAEmw55fFfVcLKlM8RP01WQQkxmzbgIuKfxCqNMBq8Dhm7MSHdqmLWJyQYrVNxfeMpLe4wwMVwlWrTnspL26vt8ae+dG3/946/PXM43BtFkFGaczhwPYwU6wYW1RIyQnd5Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZT66ZGO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZT66ZGO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3881BC2BCB5;
	Tue, 21 Apr 2026 17:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776791910;
	bh=LA5Mymi5WlGDvCtb5Ih1LotxlsfbuMckFJ4yBe6jLUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eZT66ZGOSvMXzf9UcoWwWhWf2UjmxhjkF2zfby7pyHlFJGpIhwUIRRM6e9gnFO80L
	 EzsG0K2kQSqOS4jBg/egdnBjik5Ewgg1i+L8BxqagNQ2G5CzmL+BMum9xQE5CopVgF
	 YWLieGrThqOoZSLyIlKnaF4oUPDNlHoeZreyObqTtrzTpzNRyiedARiuOrvVd4iHD1
	 KjNwu5YGTE/a000VjJ8mDtK0zFnpqgtTz/lzCB+4yvsbLKYHsSzN/rVhD4T6DHFjPa
	 lUANf1vS5M451aSKWBQKrOTFvj0h9wz+pfWbHXY1rki/OeORXoSbLcSxZ8RYwcFdfQ
	 i5T2po5ECrNmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 1/4] bpf: representation and basic
 operations on circular numbers
Reply-To: sashiko@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260421-cnums-everywhere-rfc-v1-v1-1-8f8e98537f48@gmail.com>
References: <20260421-cnums-everywhere-rfc-v1-v1-1-8f8e98537f48@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 17:18:29 +0000
Message-Id: <20260421171830.3881BC2BCB5@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Critical] `FN(cut)` emits wrapped chunks causing `FN(mk_mul_u)` to compu=
te unsound narrow bounds.
- [Critical] `cnum32_from_cnum64()` can return a struct mathematically equi=
valent to the `CNUM32_EMPTY` sentinel.
- [High] Unconditional use of `__int128` breaks compilation on 32-bit archi=
tectures.
- [Medium] Missing emptiness checks in `cnum64_cnum32_intersect` and `cnum3=
2_from_cnum64` resurrect unreachable states.
--

commit 5ab536543671bb2cd6865196d88e96f87d1e7888
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: representation and basic operations on circular numbers

This commit introduces cnum32 and cnum64 representations for unified
signed and unsigned numeric ranges in the BPF verifier. It includes
functions for intersection, multiplication, and range conversion to
refine bounds deductions.

Link: https://lore.kernel.org/all/ZTZxoDJJbX9mrQ9w@u94a/
Link: https://jorgenavas.github.io/papers/ACM-TOPLAS-wrapped.pdf
Link: https://github.com/eddyz87/cnum-verif/tree/master

> diff --git a/kernel/bpf/cnum.c b/kernel/bpf/cnum.c
> new file mode 100644
> index 0000000000000..38a805a6fc2a9
> --- /dev/null
> +++ b/kernel/bpf/cnum.c
[ ... ]
> +struct cnum32 cnum32_from_cnum64(struct cnum64 cnum)
> +{

Are we missing a check for empty inputs here? If an empty 64-bit range is
passed, does this code convert it directly into an unbounded 32-bit range?

> +	if (cnum.size > U32_MAX)
> +		return (struct cnum32){ .base =3D 0, .size =3D U32_MAX };
> +	else
> +		return (struct cnum32){ .base =3D (u32)cnum.base, .size =3D cnum.size =
};
> +}

Could this else branch return a value mathematically identical to the
CNUM32_EMPTY sentinel?

If a valid 64-bit range has a size of U32_MAX and a base ending in
0xFFFFFFFF, this would return { .base =3D 0xFFFFFFFF, .size =3D 0xFFFFFFFF =
}.
Would the verifier then incorrectly assume this code path is dead and
prune it?

[ ... ]
> +struct cnum64 cnum64_cnum32_intersect(struct cnum64 a, struct cnum32 b)
> +{

Does this function need to verify if the input ranges are empty before
operating on them? If the variable a is empty, could the arithmetic below
return a non-empty, garbage range, effectively resurrecting dead code paths?

> +	/*
> +	 * To simplify reasoning, rotate the circles so that [virtual] a1 starts
> +	 * at u32 boundary, b1 represents b in this new frame of reference.
> +	 */
> +	struct cnum32 b1 =3D { b.base - (u32)a.base, b.size };
[ ... ]
> diff --git a/kernel/bpf/cnum_defs.h b/kernel/bpf/cnum_defs.h
> new file mode 100644
> index 0000000000000..28dcb79ba6950
> --- /dev/null
> +++ b/kernel/bpf/cnum_defs.h
[ ... ]
> +#if T =3D=3D 32
> +#define ut2 u64
> +#define st2 s64
> +#define utt u32
> +#define stt s32
> +#define EMPTY CNUM32_EMPTY
> +#elif T =3D=3D 64
> +#define ut2 unsigned __int128
> +#define st2 signed __int128

Will the unconditional use of unsigned __int128 and signed __int128 break
compilation on 32-bit architectures? Since the BPF subsystem and verifier
are built on 32-bit kernels when CONFIG_BPF_SYSCALL is enabled, this
might cause widespread build failures.

> +#define utt u64
> +#define stt s64
> +#define EMPTY CNUM64_EMPTY
> +#else
> +#error "Unsupported T value, cannot define ut2/st2"
> +#endif
[ ... ]
> +static int FN(cut)(struct cnum_t a, struct cnum_t chunks[3])
> +{
> +	int ncuts =3D 0;
> +
> +	if (FN(srange_overflow)(a)) {
> +		chunks[ncuts++] =3D FN(from_urange)(a.base, ST_MAX);
> +		a =3D FN(from_urange)(ST_MIN, a.base + a.size);
> +	}

Can this splitting logic emit wrapped chunks that cause bound deductions
to underflow?

When an arc crosses both boundaries, this splits it first at ST_MAX. The
resulting first chunk crosses the unsigned boundary 0.

When passed to FN(mul_chunk) with a multiplier, it falls into the fallback
branch utilizing FN(mk_mul_u):

static struct cnum_t FN(mk_mul_u)(utt a, utt b, utt c, utt d)
{
        ut2 size =3D (ut2)c * d - (ut2)a * b;

Because the chunk wraps, its unsigned start is mathematically greater than
its end. Does this cause the subtraction to severely underflow in unsigned
arithmetic, producing an artificially tight size that misses valid
runtime products?

> +	if (FN(urange_overflow)(a)) {
> +		chunks[ncuts++] =3D FN(from_urange)(a.base, UT_MAX);
> +		a =3D FN(from_urange)(0, a.base + a.size);
> +	}
> +	chunks[ncuts++] =3D a;
> +	return ncuts;
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260421-cnums-ever=
ywhere-rfc-v1-v1-0-8f8e98537f48@gmail.com?part=3D1
