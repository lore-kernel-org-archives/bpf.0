Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9475B3F210A
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 07:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015724; cv=none; b=BW6GK3nG5gvVVmq+/JpztskBk+XpfJeLLGFcL2zXtRA9QoTzDdnGhsn3cBxSe4aKdOm6niI+dt3TJJvVpYnGWnxMt7OsOCUS8yfK7ge2tgX3J3/ckhqEnlNWkOJuVuJw0JwEUcbqYsHhEaNaLv9UYRx87HGsKdBMXTNgzTSwOKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015724; c=relaxed/simple;
	bh=nsFBhsJ93BHzXkLZh7+ztjuii9Ry9VOIb29u2Z0nCGA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dAGqbOxOGqvId2YSddCk1MADcx+klAvmmQ9274JIp6ot14RX3TjtaJLznSFFn6/YkxOb/sPq2PzuCGknXrtjcIALDMODkHJVDEGX2ls6DZXZxDeh9si8JNXUD46oIo8e4KHYotkAgrY4NRIbCsyCmQHY1Bk/WhV7YLh/UDc74/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmKPjZRW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmKPjZRW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A8D1F000E9;
	Tue, 14 Jul 2026 07:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784015722;
	bh=joi3YMgRUE0is5r7Nj83IZxS7xyEo2NB1Nc7RT8wUyA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lmKPjZRWfkc3WsXyXmeUBViprtsRu+ITXSqWpIOGwJbJ6JTXooW3QVd2zEr5pZNdj
	 M2lEAviV9dVewMqhtN7+WZBHo3tnpyAI/qZXxWNFBGLG46iWw2yc9CXpg1tVSyKL5Y
	 39gsy1T8udItZpudliY4EcIYtzh7tm1WoyP7Y5btpw9t3gTjkEtb1hkwDQTs1RFHgm
	 XabLjFRUc4UxziRRoNFGxKIbU09i7+oPFrs9hAOB/9KzkzRLNorLUoJ+s5MiKGfP1R
	 jY2XqyjE8fYGumvPXKOHnI955ehRa+74MfoavN4QVAIW7GkyrHtWiqd3hvol3/7FeT
	 itWgU80lDNm+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 14/15] barrier: add tests for
 smp_cond_load_*_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260714073041.40250-15-ankur.a.arora@oracle.com>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
 <20260714073041.40250-15-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 07:55:22 +0000
Message-Id: <20260714075522.79A8D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The string pointers `clk` and `update` in `param_to_desc()` may be =
left uninitialized.
- [Low] Typo in Kconfig help text for `BARRIER_TIMEOUT_KUNIT_TEST`: 'unusur=
e' instead of 'unsure'.
--

--- Patch [14]: [PATCH v14 14/15] barrier: add tests for smp_cond_load_*_ti=
meout() ---
commit a30c2efa70f8be2b1654f46db86c3a29fe02abf2
Author: Ankur Arora <ankur.a.arora@oracle.com>

barrier: add tests for smp_cond_load_*_timeout()

Add success and failure case tests for smp_cond_load_*_timeout().
Success or failure cases depend on the expected bit being set (or not).
Additionally in failure cases smp_cond_load_*_timeout() cannot return
before timeout.

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 8ff5adcfe1e0a..ce75655863f49 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
[ ... ]
> @@ -2551,6 +2551,16 @@ config FFS_KUNIT_TEST
>  	  For more information on KUnit and unit tests in general,
>  	  please refer to Documentation/dev-tools/kunit/.
> =20
> +config BARRIER_TIMEOUT_KUNIT_TEST
> +	tristate "KUnit tests for smp_cond_load_relaxed_timeout()" if !KUNIT_AL=
L_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Builds KUnit tests that validate wake-up and timeout handling paths
> +	  in smp_cond_load_relaxed_timeout().
> +
> +	  If unusure, say N.

[Severity: Low]
This isn't a bug, but there's a typo (unusure instead of unsure) in the help
text.

> diff --git a/lib/tests/barrier-timeout-test.c b/lib/tests/barrier-timeout=
-test.c
> new file mode 100644
> index 0000000000000..4226fb6456b35
> --- /dev/null
> +++ b/lib/tests/barrier-timeout-test.c
[ ... ]
> +static void param_to_desc(const struct smp_cond_update_params *p, char *=
desc)
> +{
> +	char *clk, *update;
> +
> +	if (p->clock =3D=3D &mocked_clock) {
> +		clk =3D "mocked";
> +		update =3D "inline";
> +	} else if (p->clock =3D=3D &basic_clock) {
> +		clk =3D "basic";
> +		update =3D "none";
> +	}
> +
> +
> +	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "smp_cond_%s_timeout: clock-%s, u=
pdate=3D%s",
> +		p->acquire ? "acquire" : "relaxed", clk, update);

[Severity: Low]
Could the string pointers clk and update be left uninitialized here?

If a different clock function is ever added and passed into param_to_desc,
the conditional chain will fall through without assigning these pointers.
This would result in passing uninitialized variables to snprintf, and might
also trigger -Wmaybe-uninitialized compiler warnings.

Would it be safer to add a default else branch or initialize these variables
to a fallback string like "unknown"?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714073041.4025=
0-1-ankur.a.arora@oracle.com?part=3D14
