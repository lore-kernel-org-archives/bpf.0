Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602C5332906
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 18:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776277793; cv=none; b=aa0eoErnkb1mBgNiZA1BRvy2JbMCf9ZCEn8TLMWKkGpb3S1KLvbw5UkXmx8yzdDw0JUiB2GgnrMDO1V3m6EM+hPTlrrCcQMwJT/BWpEcKcr+VS7tiOlNAbomdkV8Nu/4nK0iCgyfWVG5qNKxQ55AkpwXxFmtFwhQAbRCKWj4Zmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776277793; c=relaxed/simple;
	bh=UHfU1DHsJ9zsqjJyIa1gTPCYp/zxgM41AOkv2Z163ac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SDhx5MAyT2ytoot6NvcPhxYy+LdeY2YbcaVWRz5uYdRpW9Tsicm2iNBGTjNcsOPyn+E4YrXaL2xDIeekyJjdJPzo24MA/7nB8OjHNnGgcWcGjV0kMWGkK60fcHiHurroPNdf/g4vLnhXX24erI7v+bmW9LzKeBkLwRXisdjOUMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrXWyFHn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrXWyFHn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B77C19424;
	Wed, 15 Apr 2026 18:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776277792;
	bh=UHfU1DHsJ9zsqjJyIa1gTPCYp/zxgM41AOkv2Z163ac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=MrXWyFHnzLPfWIDfq0WfyxVTqzqZWfBdwn9rVIc7DmiZr6tmDv7+RIxEZ6mrS/uJD
	 k2IOvGv3Kr9glGuxAlup2b3A4epOA8srQBgpwYB9c0v/XrAcWQ3xZl6tDSZcpwUwFr
	 QTAWJnIuBkEY7l8BrBr0r6jXsnZavKdaMtoO1fiS/ZPFrl0TI/yhwRuR79PAvmH7NX
	 3O0NijUV1I29bhwa1ye19ryxNjhEF2Tog+rH3ZLMo6YpzbKExOYa6K6+PcDklwPnQ1
	 pWGX0gT77VlGvBUT2xxtOBjkBgFwdKNERwp8z5r6aPnXDE2UZSnGqhF/d1Fjrm+WqH
	 eNmTRttq2lc7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test for empty intersection
 of tnum and u64
Reply-To: sashiko@lists.linux.dev
To: "Harishankar Vishwanathan" <harishankar.vishwanathan@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260415160728.657270-3-harishankar.vishwanathan@gmail.com>
References: <20260415160728.657270-3-harishankar.vishwanathan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 18:29:52 +0000
Message-Id: <20260415182952.C7B77C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] The test relies on the verifier treating the return value of `bp=
f_get_prandom_u32()` as a completely unbounded 64-bit scalar. If the verifi=
er is improved to track its true 32-bit bounds, the test will silently stop=
 testing the intended logic.
- [Medium] The inline comments in `empty_tnum_u64_intersection` incorrectly=
 describe the verifier state at the wrong instruction boundaries and use in=
correct terminology.
--

commit f07d8c6131ab63ef38acb708d393fc328146ef7c
Author: Paul Chaignon <paul.chaignon@gmail.com>

selftests/bpf: Test for empty intersection of tnum and u64

This commit adds a verifier selftest for a scenario where the tnum and u64
values don't intersect on a branch. It uses bpf_get_prandom_u32() and
conditional jumps to test if the verifier correctly deduces that the branch
is dead code.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/=
testing/selftests/bpf/progs/verifier_bounds.c
> index c1ae013dee29c..151c7a479a6b8 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c

[ ... ]

> @@ -2184,4 +2184,29 @@ __naked void tnums_equal_impossible_constant(void =
*ctx)
>  	: __clobber_all);
>  }
> =20
> +SEC("socket")
> +__description("dead branch: tnum and u64 don't intersect on true branch")
> +__success
> +__naked void empty_tnum_u64_intersection(void *ctx)
> +{
> +	asm volatile("									\
> +	call %[bpf_get_prandom_u32];							\
> +	r6 =3D r0;									\

Since bpf_get_prandom_u32() returns a u32, its runtime value is strictly
within [0, 0xffffffff]. If a future verifier update bounds prandom_u32() to
this range, the verifier will accurately determine that the jump
(r6 s< 0xe00000002) is always taken and prune the fallthrough path as dead
code.

Would this cause the test to silently pass while no longer providing any te=
st
coverage for the tnum intersection logic? Could a truly unknown 64-bit value
be constructed instead to prevent this test fragility?

> +	r1 =3D 0xe00000002 ll;								\
> +	r2 =3D 0xf00000000 ll;								\
> +	if r6 s< r1 goto +2;								\
> +	/* On fallthrough, r6's u64=3D[0xe00000002;0xf00000000] */			\

Are these inline comments describing the verifier state accurately? The upp=
er
bound of 0xf00000000 does not seem to be established until the fallthrough =
of
the next instruction (if r6 s> r2 goto +1).

> +	/*                      tnum=3D(0xe00000000; 0x1ffffffff) */			\
> +	if r6 s> r2 goto +1;								\
> +	/* On fallthrough, r6's tnum=3D(0xe00000001; 0x100000000) */			\

Does this tnum state actually describe the fallthrough path? It appears to
describe the mathematically deduced state on the jump target (true branch) =
of
the w6 =3D=3D 1 check, making the term "fallthrough" incorrect here.

> +	/* It doesn't intersect with the u64 so the condition is always false *=
/	\
> +	if w6 =3D=3D 1 goto +1;								\

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415160728.6572=
70-1-harishankar.vishwanathan@gmail.com?part=3D2
