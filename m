Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B76646AED7
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815956; cv=none; b=ubUTCPopl+oGQPZ74bHrfn/2Ldx1JqW9rLOlf3fA0g0q1ngtOaxe4VhG2rCqUlMV/jyFhEkt2uKCuShk4N5vuaco3zCq1rRKyWnr6PopaqSGNKw1L2faNuineIj8DIZNcEXVvAblBFdKYapjLrKT6ZfF3AoJDnXReckCaMZF/pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815956; c=relaxed/simple;
	bh=UuvAtim8IgbUjy17i/E2FQmmxRQAcmmPhcnhM0WW02Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s+eLt+QnMhH0SGWgZZBJITg1XI6PeRBuDBneUkmqfW9czc7gCvEP5Sv9NLseBXhVPFxTF7E0ly7S0jj0U9++GYwr4+3lfycVhuD7HhOh7v14DcVICO7NNS9f7ed+IVPJY64UP1X79gwboD3sW4OEvGSX2gqM6SYKCgj13MDaSEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Crn7FJOz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Crn7FJOz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB081F000E9;
	Thu, 23 Jul 2026 14:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784815946;
	bh=39i8AWSNGH1K+svrKKjlTIPgF3U5hPbSqo9/5J1THqI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Crn7FJOzMVXfaor8HpYGKr42X2FzxHRPYGrQcNTzbbFnRdy2LDbDd5rI271zKF1xp
	 dzUWBeRhrDPPrNtkcL0rGJihMmUUzXa9bQuzYbl30vofQJXrd7FuxREfHLjz2SX1DS
	 DpZYi1TGP9p9KoOZFFKHz9/vdrVWv1duCiF/FYDbXF6xxCx7xEfXwOmzyeE/CHaqYd
	 Ynm650o5bVwyJ4RJS9f4+SaHz6xHXfk0k5ChQTifYdVEJg1666sjpsrROP9HGqaVRe
	 1W1cfqNH2KnSWTFR4KusKbLV5+OdlNkKARmQ6pUObzRs4RFF8Ixrk2UrYNPZ9z8kpw
	 g+smIyqQg6Plg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/3] s390/bpf: Enable atomics tests for s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxim Khmelevskii" <max@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260723140648.583055-8-max@linux.ibm.com>
References: <20260723140648.583055-5-max@linux.ibm.com>
 <20260723140648.583055-8-max@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 14:12:25 +0000
Message-Id: <20260723141226.4CB081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Meaningful code and commit message mismatch: failure to reuse CA=
N_USE_LOAD_ACQ_STORE_REL in arena_atomics.c.
--

--- Patch [3]: [PATCH bpf-next 3/3] s390/bpf: Enable atomics tests for s390=
 ---
commit c1e0ed2dde3c2d83049962c67b540464ea7a24d3
Author: Maxim Khmelevskii <max@linux.ibm.com>

s390/bpf: Enable atomics tests for s390

This commit adds s390 to the list of supported architectures for atomics
tests and updates CAN_USE_LOAD_ACQ_STORE_REL in bpf_misc.h.

> Reuse CAN_USE_LOAD_ACQ_STORE_REL in arena_atomics selftest,
> to remove code duplication.

[Severity: Medium]
Is this description accurate for the changes actually made in arena_atomics=
.c?

> diff --git a/tools/testing/selftests/bpf/progs/arena_atomics.c b/tools/te=
sting/selftests/bpf/progs/arena_atomics.c
> index 2e7751a853999..73bc2b835f3fe 100644
> --- a/tools/testing/selftests/bpf/progs/arena_atomics.c
> +++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
> @@ -28,8 +28,10 @@ bool skip_all_tests =3D true;
> =20
>  #if defined(ENABLE_ATOMICS_TESTS) &&		  \
>  	defined(__BPF_FEATURE_ADDR_SPACE_CAST) && \
> -	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
> -	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64))
> +	(defined(__TARGET_ARCH_arm64) || \
> +	 defined(__TARGET_ARCH_x86) || \
> +	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) || \
> +	 defined(__TARGET_ARCH_s390))

[Severity: Medium]
Could this #if block use CAN_USE_LOAD_ACQ_STORE_REL as mentioned in the
commit message, instead of manually expanding the architecture list?

By not using the macro, it appears that powerpc and loongarch support
defined in bpf_misc.h are omitted in these checks. This manual expansion
also seems to be duplicated in load_acquire() and store_release() later
in the patch.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723140648.5830=
55-5-max@linux.ibm.com?part=3D3
