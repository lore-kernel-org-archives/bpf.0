Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887B1469859
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785858594; cv=none; b=tuOldG4nUybvkikZmKDVPI/9UrSHNnUbZDe0hfQdpPr3hRbDfh+2sZIEgH/T6aF446+l/49qxKe0uL4BgPPVo+v0wB2v0GsmPSvHVvadOECixD47Pz7XPhq6jzcULlYKEYDs9uD4Otw3mfUXMHzMNoyvQGlNVufwmRBONa4OIzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785858594; c=relaxed/simple;
	bh=1rqwiJ0BDwyHQ77LBVjsvMO5NNoLMzt5CUl7Oj/cxQQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eUFJGvNpDAC6WVH+W2x5dtHgkKueyVJ19/FhVceGAwkcUkq1D2aWUPCP2bSUaksS8kcSFZqa9Uu1IggvYOCumuguRQdKMVynJF6pVcCvOvpKQOqE3Lj2PRJiR2jWCBUePlsHpzRoWpyU3tmDczr2KollAzehmbpklsQuOfwZlOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDL7n1LX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDL7n1LX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394411F000E9;
	Tue,  4 Aug 2026 15:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785858593;
	bh=kIoZ7hElEuFFjGezlSAWEJzMY6B2QwZEYygbGwdMJT4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HDL7n1LXGXLz4Knz666qzg1pVbRiOeZbzBiTVjaq52uV8+6pZSMP6EGm5xHQKqx9O
	 nF2vyG2WeV+hKM+TspuQURgCWzuJckg1RmNd2yhMbLsSzhECnxMnpLGoSv1ol8OFA3
	 3ogrm8NVu/IXbVbX3YyUIUvIaTi/gCQ0ePt+57rYBGOgHmK67xIPkBFduZafHsfAn4
	 LUCFlVaHfuSOUoLsS+ZPxSyGVp+tD18qF5kKmh+CzVzSkWtXosRa+Y7TyeP7Swu4NI
	 J7tNLdxES+lgRTpLgPaYZL67mWcRBeP4cqpgbstu7hSmgwxQa1Rbdj74K48JH2Wfkg
	 BqmShS/hUk8Fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Verify rejection of
 sleepable tracing prog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260804145710.43062-3-leon.hwang@linux.dev>
References: <20260804145710.43062-1-leon.hwang@linux.dev>
 <20260804145710.43062-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 15:49:52 +0000
Message-Id: <20260804154953.394411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test contains dead reproducer code that intentionally crashe=
s the kernel on test failure instead of failing gracefully.
--

--- Patch [2]: [PATCH bpf-next v3 2/2] selftests/bpf: Verify rejection of s=
leepable tracing prog ---
commit 22c464db2aa39d78b7ca52b202c4a7828b6fddc2
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Verify rejection of sleepable tracing prog

This commit adds a test to verify that a sleepable tracing program cannot
attach to a '__x64_sys' prefixed program target.

> diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/too=
ls/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> index 4a87d7163c8c7..2523c07a16c65 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
[ ... ]
> @@ -576,6 +577,60 @@ static void test_func_replace_progmap(void)
>  	freplace_progmap__destroy(skel);
>  }
> =20
> +static void test_sleepable_fentry_to_xdp(void)
> +{
[ ... ]
> +	err =3D fentry_sleepable__load(skel);
> +	ASSERT_ERR(err, "fentry_sleepable__load");
> +	if (err)
> +		goto out;
> +
> +	skel->links.fentry_xdp =3D bpf_program__attach_trace(skel->progs.fentry=
_xdp);
> +	if (!ASSERT_OK_PTR(skel->links.fentry_xdp, "bpf_program__attach_trace"))
> +		goto out;
> +
> +	skel_xdp->links.__x64_sys_nop =3D bpf_program__attach_xdp(skel_xdp->pro=
gs.__x64_sys_nop,
> +								ifindex);
> +	if (!ASSERT_OK_PTR(skel_xdp->links.__x64_sys_nop, "bpf_program__attach_=
xdp"))
> +		goto out;
> +
> +	err =3D system("ping -q -c 1 -W 1 127.0.0.1 > /dev/null");
> +	ASSERT_OK(err, "ping");
> +	ASSERT_ERR(skel->bss->retval, "retval");

[Severity: Medium]
Will this sequence crash the kernel if the test fails?

If the kernel lacks the fix, fentry_sleepable__load() will return 0.
ASSERT_ERR() will correctly log a test failure, but since err =3D=3D 0, the
if (err) goto out; check will be bypassed.

The test will then proceed to attach the sleepable program and trigger it
with ping, intentionally causing the kernel panic described in the commit
message.

Additionally, when the kernel is fixed and the test passes, this entire blo=
ck
is dead code because fentry_sleepable__load() returns < 0 and the test exits
early via goto out.

Could this test fail gracefully without crashing the system during automated
bisections?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804145710.4306=
2-1-leon.hwang@linux.dev?part=3D2
