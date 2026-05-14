Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468E62DECCB
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 01:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778721933; cv=none; b=ZcRi0KJh+onSljHLkzG31NjBJ/5Z4IHq6Sz7SCG95WmxURDPkE6zlSLJ6kxhdZqOt66mUxphGF/ekXBDOOGAH3PJDEzliFeDlSYCFUlpFdtnHVck1ZRQkl/d9mbmz4CSKPU65nZ+b/idKHGxrVIxbd8E28VhoiOxGaTENup30Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778721933; c=relaxed/simple;
	bh=+C/SSB1Oj64lEIOJDgD33GIZHoPGciYS3obdHKg1Jeg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eiLZktNj4rPJZFdembGzFobzi7+2quRSzoPYDzLU4rG7+veFObOb6Xozr8HDN4YJjH6mOWLn4oTLmKnPXfUfn3NouRZMmRYraSdExY/XSJON3XqYrJQe+iz3GTm8NBNMN3QIFZsxLYx9mcmgbxa1J2bT2aTbuUbvpymwS2gRgk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnTdvlfq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnTdvlfq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0375C2BCB3;
	Thu, 14 May 2026 01:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778721933;
	bh=+C/SSB1Oj64lEIOJDgD33GIZHoPGciYS3obdHKg1Jeg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JnTdvlfqE6FeCny87/tPdR2FveYTk0vTifxcwYzUdvPKLVEY0eSjS2K/9vF+KFtFg
	 dGYM4iv6nOw73en8/8ZYoVauSJn/a2tIUE4zz0d5jx7aZz4zN+nrWFiOiRq5X/Koe2
	 sm1gY/j57fPu3PsZq1wKOIhj/EOj37N5Pk0QD1vvfBsElPl758XKzmZJ3SWA7sOMaD
	 7Lbcq+RhMleA+ZISoOJRyTo+dt9CmVu+DnDiYO8SYUZSP6G2B23hFPJNHmd1284H9W
	 45BvpP2eTvPLnnvU6Dwt4sWS/aPXYBd8AptmVIwXC0zVlsnAR8S9n2j1Iz8POw2pgq
	 DjwGnGMY83A8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v14 8/8] selftests/bpf: Add tests to verify map
 create failure log
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260512153157.28382-9-leon.hwang@linux.dev>
References: <20260512153157.28382-9-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 01:25:32 +0000
Message-Id: <20260514012532.E0375C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Hardcoded value of 0xFF (255) for invalid NUMA node and invalid =
token FD may cause spurious test failures on certain systems.
--

commit b99a7cb4d2c7cfcc2878066c51d6ca1706eaa83a
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Add tests to verify map create failure log

Add tests to verify that the kernel reports the expected error messages
and correct log_true_size when map creation fails.

> diff --git a/tools/testing/selftests/bpf/prog_tests/map_init.c b/tools/te=
sting/selftests/bpf/prog_tests/map_init.c
> index 14a31109dd0e0..5c61c8e373065 100644
> --- a/tools/testing/selftests/bpf/prog_tests/map_init.c
> +++ b/tools/testing/selftests/bpf/prog_tests/map_init.c
[ ... ]
> +static void test_invalid_numa_node(void)
> +{
> +	const char *msg =3D "Invalid numa_node.\n";
> +	LIBBPF_OPTS(bpf_map_create_opts, opts,
> +		    .map_flags =3D BPF_F_NUMA_NODE,
> +		    .numa_node =3D 0xFF,

Would this test be flaky on a massive system? Using 0xFF (255) for the
NUMA node could accidentally match an online node on systems with large NUMA
topologies (e.g., up to 1024 nodes).

Would it be safer to use ~0U or -1 to represent a guaranteed invalid node?

> +	);
> +
> +	test_map_create_array(&opts, msg);
> +}
[ ... ]
> +static void test_invalid_token_fd(void)
> +{
> +	const char *msg =3D "Invalid map_token_fd.\n";
> +	LIBBPF_OPTS(bpf_map_create_opts, opts,
> +		    .map_flags =3D BPF_F_TOKEN_FD,
> +		    .token_fd =3D 0xFF,

Could the use of 0xFF (255) as a file descriptor lead to spurious test fail=
ures?

While an open FD 255 is unlikely to be a BPF token, using -1 or ~0U is the
standard way to provide an invalid FD, which completely eliminates the risk=
 of
accidentally hitting an open file descriptor.

> +	);
> +
> +	test_map_create_array(&opts, msg);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512153157.2838=
2-1-leon.hwang@linux.dev?part=3D8
