Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794818716;
	b=02XaCa4tRew8OEW/da6Zcg9jBlWQc40Bi4XJTc2PF5N+d9Nk2MyLJYafObKp0OkZjL5l
	 CsQefzkWsy5qgFdZP5K/3d4axGvtNfVwfuI3o5z5I2C3bf64yRv6c5GFku5Co8XnFUf71
	 a55K4kFxjCWchQEHI1KaWilEF9B5lGl5IW4mGjWy8FAaGSs9Q2l7xbSJBBpzhdu+FhaJU
	 DLPiYFdVDwP8NJmXtDQYFppi1cxTeip1RoiL5AxUOcnHDpRMOSE7l5+qiZXWw9asGNpuz
	 1uohas2N+nrAbuNeR2SskHyf7l5eB1YxMCmb2t5Ppz3WmUkAAVxpOSmp1jhV+bJa4jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794818716;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8x/H8txNrrB8gQsyO1GCUKCpaWopus1RADYwJiXRCcY=;
	b=xpsK1Qc6vQ/URuaZuIM1scyMyeOGyzSxYYaLCh29kb/6w1BJR9dllBBcGoQrdywyQAdD
	 6lzXo9LGHSfw05CFDLn7wSdTVKQYKxIb8wQjtAMAoMupBwxBLy4F7bK/Gmi2WQvaEclbm
	 8izDT8Fp/gpkn7Vq506mPk6o858FaW/YbXT7lXTi1TKiYDVFWjqELf59eXy/lJaBmNu17
	 YNf0JTOa7bk7a8HE2WRGOYImW03oXVhpetVzzR2PUap5kDNLVoH0TXfRXvUWXWuWEAtOt
	 H+YqA+9e3Wzb860ljuNzaK9kp57MqQ2ITpyqv0w8rkb3f8653Q9cgRCF6cILq8rMQVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJ84BRT2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41F4606A323
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 08:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJ84BRT2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8381F000C4;
	Mon, 16 Nov 2026 08:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794818716;
	bh=8x/H8txNrrB8gQsyO1GCUKCpaWopus1RADYwJiXRCcY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=jJ84BRT2C0IJmJXS6zfK7XP3iYkjk3wm+ThQa4f8y6xpa7zOx7w10MozlFApK2mSD
	 HC1o9hkASlI1W36jczGpF0JlXMpeu6bYwpIg8WprN//4DtMq/IWw6BElZKK8W5LXY/
	 pgnS6wZ64wKsKzCLa8IP1wjJXusFTkTlAIcdPtqbjDhDGkhEN3goxzZV7GGnPkH1Mn
	 nxRaBgUEM5aMIi6wqq2Gi4HUCNoBZFfefF8bx26k/n8U7IjPo4QGa5U/rOfXyMCf7Q
	 YKIXpPusoN0ACw52J+M6FDEnBSIY+y8ouB45ZN2rjiqHLn6QMbYUXFDFC72ahahXzm
	 NZK3gbgk+ymJQ==
Message-ID: <sashiko-outbox-216561@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 15/16] barrier: timeout validity checks for
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>, bpf@vger.kernel.org
In-Reply-To: <20261116082437.66739-16-ankur.a.arora@oracle.com>
References: <20261116082437.66739-1-ankur.a.arora@oracle.com>
 <20261116082437.66739-16-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 08:45:15 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] kunit: barrier: expiry_skip_test() skips invalid timeouts on
  arm64 WFXT
--

commit b346a6c0c892c3f1d3df9f9238d93e9e4a6dba04
Author: Ankur Arora <ankur.a.arora@oracle.com>

barrier: timeout validity checks for smp_cond_load_relaxed_timeout()

This commit adds KUnit parameterized tests to verify how
smp_cond_load_relaxed_timeout() handles invalid, out-of-range, and edge-case
timeout values using a synthetic clock.

> diff --git a/lib/tests/barrier_timeout_kunit.c b/lib/tests/barrier_timeou=
t_kunit.c
> index 63d82f05ca596..b6cdecf295747 100644
> --- a/lib/tests/barrier_timeout_kunit.c
> +++ b/lib/tests/barrier_timeout_kunit.c

[ ... ]

> @@ -113,8 +115,118 @@ static void test_smp_cond_timeout(struct kunit *tes=
t)
>  		KUNIT_EXPECT_GE(test, runtime, timeout_ns);
>  }
> =20
> +static s64 synthetic_clock(struct clock_state *clk)
> +{
> +	clk->end_time +=3D clk->extra;
> +	clk->niters++;
> +
> +	return clk->end_time;
> +}
> +
> +struct smp_cond_expiry_params {
> +	char	*desc;
> +	u64	timeout_ns;
> +	s64	clk_unit;
> +	s64	miniters;
> +	s64	maxiters;
> +};
> +
> +static const struct smp_cond_expiry_params expiry_params_list[] =3D {
> +	/* timeout_ns is invalid/out-of-range */
> +	{ .clk_unit =3D 0, .timeout_ns =3D -1LL,	.miniters =3D -1, .maxiters =
=3D 0, .desc =3D "invalid (-1LL)", },
> +	{ .clk_unit =3D 0, .timeout_ns =3D ~0ULL,	.miniters =3D -1, .maxiters =
=3D 0, .desc =3D "invalid (~0ULL)", },
> +	{ .clk_unit =3D 0, .timeout_ns =3D S64_MAX+1ULL, .miniters =3D -1, .max=
iters =3D 0, .desc =3D "out-of-range (S64_MAX+1)", },
> +	{ .clk_unit =3D 0, .timeout_ns =3D U64_MAX,	.miniters =3D -1, .maxiters=
 =3D 0, .desc =3D "out-of-range (U64_MAX)", },
> +	{ .clk_unit =3D 0, .timeout_ns =3D 0,	.miniters =3D -1, .maxiters =3D 1=
, .desc =3D "degenerate (0)",    },
> +
> +	/* timeout_ns is valid */
> +	{ .clk_unit =3D (0x1ULL << 28), .timeout_ns =3D 1,		    .miniters =3D 1=
,	      .maxiters =3D -1, .desc =3D "1",    },
> +	{ .clk_unit =3D (0x1ULL << 28), .timeout_ns =3D (0x1ULL << 30), .minite=
rs =3D 1 << (30-28), .maxiters =3D -1, .desc =3D "1<<30",   },
> +	{ .clk_unit =3D (0x1ULL << 28), .timeout_ns =3D S32_MAX,	    .miniters =
=3D 1 << (31-28), .maxiters =3D -1, .desc =3D "S32_MAX", },
> +	{ .clk_unit =3D (0x1ULL << 28), .timeout_ns =3D U32_MAX,	    .miniters =
=3D 1 << (32-28), .maxiters =3D -1, .desc =3D "U32_MAX", },
> +	{ .clk_unit =3D (0x1ULL << 28), .timeout_ns =3D (0x1ULL << 33), .minite=
rs =3D 1 << (33-28), .maxiters =3D -1, .desc =3D "1<<33",   },
> +};

[ ... ]

> +static char *expiry_skip_test(const struct smp_cond_expiry_params *p)
> +{
> +#ifdef CONFIG_ARM64
> +
> +	/*
> +	 * WFXT waits for the full p->timeout_ns so limit it to a reasonable
> +	 * duration.
> +	 */
> +	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT) &&
> +	    p->timeout_ns >=3D NSEC_PER_SEC) {
> +
> +		return "runtime duration too long";
> +	}
> +#endif
> +	return NULL;
> +}

[Severity: Low]
Does expiry_skip_test() skip the invalid and out-of-range test cases on
arm64 systems with ARM64_HAS_WFXT?

Because p->timeout_ns is a u64, values such as -1LL, ~0ULL, S64_MAX+1ULL,
and U64_MAX all compare >=3D NSEC_PER_SEC in an unsigned comparison, even
though smp_cond_load_relaxed_timeout() casts timeout_ns to s64 and returns
immediately without entering the WFXT wait loop.  Casting p->timeout_ns to
s64 here (or checking p->maxiters !=3D 0) would keep coverage for those test
cases on WFXT-capable hardware.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116082437.6673=
9-1-ankur.a.arora@oracle.com?part=3D15
