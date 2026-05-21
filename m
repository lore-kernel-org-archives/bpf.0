Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0086537CD35
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357371; cv=none; b=pUhz2kOY/TUao5sb9JufwoS51hdaeDOoGLz/uFQtLb4Hh1dLMfv1+41VuUWPbhyW8AtAbjQ1tyB4RI5WxS07j3GLJI6ogydHp1T613Fj8UncEbaFAXfKLwPoRcCbdTo1YDgP72nhgEx/VpK8c5Xu4xWzpyDRGqyf3ZeTwNqbLXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357371; c=relaxed/simple;
	bh=kbVueLwdS6FCSHLaai+FgwoTwF0y1M51qZTlJCAovz8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oONzf2TJ99IVzj4lOc+SMCsTv4OdSQg8vPLjl/7qHgvg1Dg3oPO3TflxV/a+Aj2EGlN2JI8hln6/pnLZS8LGh9ZJXbirko2RobX7TFF3S+pz8komt2jQRbz7tyiCV2N4XCbEbSADNa2putMXe1tq5AofLalN3m3eVAp2QU8nqgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQn0J2Kg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQn0J2Kg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4D51F00A3F;
	Thu, 21 May 2026 09:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779357369;
	bh=qESjHINfOXXAwSHMsVTmBlHJ3voEobLzaWHNcLCjLX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kQn0J2Kg0xr4Oo4pTEbkNj+nYJ5882f4lKubJpwQ0sdcNqPipjfLA+uoFMZWJ+7JH
	 NInJsbgICGho6492f/ZdirRZRT+2Z0hiTmB4reAJ2THx8gaiF7T+Aqjpdktf+A8Pvf
	 diywyVwKwcpMzMxtFHMoAqMMnMt8cH7LmWIyBH3zzSczkIGz6oplUTijy0MUmluYO5
	 yihppxQjCRNGpuaGlKEnqItZw+IhJuQ7C0tJGpavV9iSeKHvLJIILPeCBud7dRJG1h
	 ak+wEN6Tk0SYRGCTDirL2xNwKI+mhZc81lwRGnB2E3aLdmHFC4MBRxLeB4+dl8XC59
	 w4fAkIcadKilw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/2] kunit: add clock tests for
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521083038.134260-2-ankur.a.arora@oracle.com>
References: <20260521083038.134260-2-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 09:56:09 +0000
Message-Id: <20260521095609.7E4D51F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] The variable `result` in `test_smp_cond_expiry()` is assigned but n=
ever used.
- [Low] The opening brace of the function `synthetic_clock()` is placed on =
the same line as the function definition.

Pre-existing issues:
- [High] The `smp_cond_load_relaxed_timeout()` implementation suffers from =
an unhandled integer overflow when evaluating extremely large timeouts like=
 `S64_MAX` or `U64_MAX`.
--

commit 7f53d0ddbab5d1cd94d6d7bf4f26665e2d25582d
Author: Ankur Arora <ankur.a.arora@oracle.com>

kunit: add clock tests for smp_cond_load_relaxed_timeout()

This commit adds clock tests for smp_cond_load_relaxed_timeout() to ensure
the implementation handles clock accesses and edge cases correctly. The tes=
ts
check if the timeout expires properly and whether the clock is accessed
appropriately per iteration. The acquire variant is skipped since it uses an
identical clock path.

> Also ensure that edge cases are handled sanely. Note that two edge
> cases fail: S64_MAX and U64_MAX. However, both of those are quite
> far out and if needed, can be addressed in the implementation of
> the interface.

[Severity: High]
This is a pre-existing issue, but the commit message acknowledges that the
underlying implementation fails for S64_MAX and U64_MAX. Passing a maximum
value to request an infinite wait is a standard kernel paradigm.

Does the internal calculation overflow and wrap around, causing the timeout
check to immediately succeed? If so, this transforms an intended infinite
wait into an immediate exit, silently breaking synchronization logic.

Should the macro implementation be fixed rather than simply avoiding the
failing edge cases in the test suite?

> diff --git a/lib/tests/barrier-timeout-test.c b/lib/tests/barrier-timeout=
-test.c
> index 2160844b27b85..6ce6c7b0fc445 100644
> --- a/lib/tests/barrier-timeout-test.c
> +++ b/lib/tests/barrier-timeout-test.c

[ ... ]

> @@ -112,8 +114,63 @@ static void test_smp_cond_timeout(struct kunit *test)
>  		KUNIT_EXPECT_GE(test, runtime, timeout_ns);
>  }
> =20
> +static s64 synthetic_clock(struct clock_state *clk) {

[Severity: Low]
According to the Linux kernel coding style guidelines, the opening brace of
a function definition must be placed on a new line. Should this be moved to
the next line to avoid checkpatch warnings?

> +	clk->end_time +=3D clk->extra;
> +	clk->niters++;
> +
> +	return clk->end_time;
> +}

[ ... ]

> +static void test_smp_cond_expiry(struct kunit *test)
> +{
> +	const struct smp_cond_expiry_params *p =3D test->param_value;
> +	struct clock_state clk =3D {
> +		.start_time =3D 0,
> +		.end_time =3D 0,
> +		.extra =3D p->clk_inc,
> +		.niters =3D 0,
> +	};
> +	unsigned int result;
> +	s64 runtime;
> +
> +	flag =3D 0;
> +	result =3D smp_cond_load_relaxed_timeout(&flag,
> +					       0,
> +					       synthetic_clock(&clk),
> +					       p->timeout);
> +
> +	runtime =3D (u64)clk.end_time - (u64)clk.start_time;

[Severity: Low]
The variable result is assigned the return value of
smp_cond_load_relaxed_timeout(), but it is never read or asserted afterward.
Could this trigger an unused-but-set-variable compiler warning and break
builds with -Werror enabled?

> +	KUNIT_EXPECT_EQ(test, clk.niters, p->niters);
> +	KUNIT_EXPECT_GE(test, runtime, p->timeout);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521083038.1342=
60-1-ankur.a.arora@oracle.com?part=3D2
