Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8083B14C1
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 08:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907697; cv=none; b=pBJK4xckcOjRWtseejvWpCpL6JsVgPOqsOPTst0FxD9ZFDhLUD0XVer15LwwSbwGOFCViR/YGcOmqkPN/vNCfV8uMNSsQ4cSNVd8VStfS+J37Xq2wTevNvOmg99zn9mCcsku0sB+bOz/C9ddaGbDf6zqDcas9Qk/hHGMv0OuV4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907697; c=relaxed/simple;
	bh=VWetMO+0fv5tzjpBTkFbhh5f6lgzMu1L7zBoim1WSjo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=geq+/02RGxPKqyilCwuvRoXalcgoZ8YofW1G1t+tSwTwY1CeELy3I9bu7nnL4EVtFnmEeNaE8ysjt333YtG5v+SEhjcUxviClsKkazRKL1FMjbG5W4HGp5CAyyrKr2HZCXLzZWaX5f5gjrzaogNrJMKST7XEw6h0m3bwMjUE640=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eukl1shf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eukl1shf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171881F00898;
	Mon,  8 Jun 2026 08:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780907689;
	bh=aRAZVNbymhvQRHfLEsUIY/dSvDMYT5mCFjDgTttIb4Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Eukl1shf32Apkut093Im/Wp78RZeIK7LL53bN0MGWhOu34J315QUmYY6YJ3YraBkf
	 STmRFuSsBBadFu/mkWlaZ7G/9SU21VxuHcJcDdXxeR7upJATRyc2VUiq5mGWQ92Iei
	 LXA5f68q/TqYN9XcQp6InDVNkcC0gKkgvX58fFpL+7eZCNuLEn+fkkxsaOTIjXSjl6
	 MoL6qARhBZyw4nfbAZjdrS7vCnZt4c2fpEnvrnb+IdrU+hTaKlq2MpQAIA6SsR4V2b
	 eSBQOSH83A7zCJq8+uQrkc+tJek3/OrnIEsCtElaqIV5sN3nTReAf18HkPBWvLJe+E
	 eTGu0/SKWlsVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 15/15] barrier: add clock tests for
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608080440.127491-16-ankur.a.arora@oracle.com>
References: <20260608080440.127491-16-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 08:34:48 +0000
Message-Id: <20260608083449.171881F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] smp_cond_load_relaxed_timeout() passes an unvalidated, potentially=
 negative timeout to cpu_poll_relax() before checking for expiration, causi=
ng unintended excessive sleeps on architectures like arm64.
--

commit 188f153f9d611077a8cfb23fad92d4d764992236
Author: Ankur Arora <ankur.a.arora@oracle.com>

barrier: add clock tests for smp_cond_load_relaxed_timeout()

Add a few clock tests for smp_cond_load_relaxed_timeout(). These
ensure that the implementation doesn't do anything funny stuff with the
clock (like multiple accesses per iteration.)

Also ensure that we handle edge cases sanely. Note that two edge cases
fail: S64_MAX and U64_MAX. However, both of those are quite far out
and if needed, can be addressed in the implementation of the interface.

Also, this tests only smp_cond_load_relaxed_timeout(). The acquire
variant uses an identical clock path and testing wouldn't add anything.

> diff --git a/lib/tests/barrier-timeout-test.c b/lib/tests/barrier-timeout=
-test.c
> index 4226fb6456b35..8fb896b6bdce6 100644
> --- a/lib/tests/barrier-timeout-test.c
> +++ b/lib/tests/barrier-timeout-test.c

[ ... ]

> @@ -112,8 +114,63 @@ static void test_smp_cond_timeout(struct kunit *test)

[ ... ]

> +static const struct smp_cond_expiry_params expiry_params_list[] =3D {
> +	{ .clk_inc =3D (0x1ULL << 28), .timeout =3D -1LL,		.niters =3D 1,			.de=
sc =3D "-1LL",    },

[Severity: High]
This is a pre-existing issue, but does adding this test for a -1LL timeout
expose an unintended massive sleep on architectures like arm64?

Looking at include/asm-generic/barrier.h, smp_cond_load_relaxed_timeout()=20
passes the unvalidated timeout to cpu_poll_relax() on the first iteration=20
before evaluating expiration:

#define smp_cond_load_relaxed_timeout(ptr, cond_expr, \
                                      time_expr_ns, timeout_ns) \
({ \
	...
	s64 __timeout =3D (s64)timeout_ns; \
	...
	for (;;) { \
		VAL =3D READ_ONCE(*__PTR); \
		if (cond_expr) \
			break; \
		cpu_poll_relax(__PTR, VAL, (u64)__timeout); \
		...

Since the -1LL timeout is cast to u64, it becomes U64_MAX. On architectures
like arm64, cpu_poll_relax() maps to __cmpwait_relaxed_timeout() where
this huge value is converted into cycles for a WFET instruction.

Could this stall the core completely until the next asynchronous event wakes
it up, breaking lockless wait latency guarantees?

The KUnit test appears to pass silently here because it uses synthetic_cloc=
k()
which measures iterations rather than actual wall-clock time, ignoring
the hardware stalling effect.

> +	{ .clk_inc =3D (0x1ULL << 28), .timeout =3D (0x1ULL << 30), .niters =3D=
 1 + (1 << (30-28)),	.desc =3D "1<<30",   },
> +	{ .clk_inc =3D (0x1ULL << 28), .timeout =3D S32_MAX,	.niters =3D 1 + (1=
 << (31-28)),	.desc =3D "S32_MAX", },
> +	{ .clk_inc =3D (0x1ULL << 28), .timeout =3D U32_MAX,	.niters =3D 1 + (1=
 << (32-28)),	.desc =3D "U32_MAX", },
> +	{ .clk_inc =3D (0x1ULL << 28), .timeout =3D (0x1ULL << 33), .niters =3D=
 1 + (1 << (33-28)),	.desc =3D "1<<33",   },
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608080440.1274=
91-1-ankur.a.arora@oracle.com?part=3D15
