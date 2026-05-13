Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D184D16A956
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 00:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778632438; cv=none; b=DSImP4L2Rk15848nltKGI9GwZHWckEyDPvot5z5AqC9N4WqpyFrciiy6iTtP1Ye9aYV3DF2+RqyqW0YMEVAc/JLV2Ns1g4kTZ1QCRzPayj9GdcFMAjQeiHpSLB8G9cPYvVJno2NTf80ghFu07ovThjLwddPwgGYyYIqMO08Iqyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778632438; c=relaxed/simple;
	bh=X2owT7XR/q2FQTW2hK92OCtgaw11j/o0PY+T3pHIllk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OaDZ7dNwZc4x1+kSFuECdmgcAC2oz0414XxE4sT2fQ0fbfwTnVPeuUJts8Q3URGWJfoJk5UoTViXn+X8X3L27A2LpIbh7y7sM2sZWSkjb4kz1Xj54Mu3oSJWMXJ7hCQx1CudhDei13Y2O5ts3jPet9AVq6zD0ST1XWJXGuWz/IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dh+Hlyad; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dh+Hlyad"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55836C2BCB0;
	Wed, 13 May 2026 00:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778632438;
	bh=X2owT7XR/q2FQTW2hK92OCtgaw11j/o0PY+T3pHIllk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dh+Hlyad2rG/z9IdFurVB82x3d3HLSkq27g4Q0s3bRo3KjTusNckuMNRqr4bUccxn
	 pAd8WY+eO03bvTOxjXmABzczDwWj928BgjlalzF0Ekio5Fa2HJCXgqqf6a3W2SlOiP
	 RH8vsE3GPV7cTn7IvQRIs4MP4wG6faC1CJH2ZmP600j2hYJxOmnK/QcRrGrQvKqcu4
	 hRmibf1+GaMGoI/YoFKJm81Pk4Y+BKLN/5bT/1X6ETlIHXV2Q1V0t6rW1hpO55cKbZ
	 WUEnDavrFFaiA4J5SngE0ZqNZOkG80LINKB8wgW+xDkmqMpH4kM7rh072HtMC/lsri
	 zuSRqGJXnGPEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v13 8/8] selftests/bpf: Add tests to verify map
 create failure log
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260511152817.89191-9-leon.hwang@linux.dev>
References: <20260511152817.89191-9-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 00:33:57 +0000
Message-Id: <20260513003358.55836C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The tests `test_invalid_numa_node` and `test_invalid_token_fd` u=
se the hardcoded value `0xFF` (255) to trigger validation failures, which c=
an cause spurious test failures on certain systems.
--

commit 31093136dd05cf604e6a2e0d0a470807567ed4a7
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Add tests to verify map create failure log

This commit adds tests to verify that the kernel reports the expected error
messages and correct log_true_size when map creation fails.

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

Is it possible for this test to fail spuriously on large systems? If the
test runs on a machine with 256 or more NUMA nodes where node 255 is
online, the kernel validation will pass.=20

The map creation might then fail for another reason, skipping the expected
log message and causing the test to fail.

Would a value like 0xFFFFFFFE (avoiding NUMA_NO_NODE) be more reliable to
ensure it exceeds nr_node_ids?

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

Could this also cause an unexpected test failure if file descriptor 255
happens to be an open BPF token in the test runner?=20

It looks like test_invalid_btf_fd uses -1 to guarantee an invalid file
descriptor. Does it make sense to use -1 here as well?

> +	);
> +
> +	test_map_create_array(&opts, msg);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511152817.8919=
1-1-leon.hwang@linux.dev?part=3D8
