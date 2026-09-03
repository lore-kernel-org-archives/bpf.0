Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6119A3F0A92
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427936; cv=none; b=C0rH6Y/gRNUG3TZrX34rMJEEay0aEbge6NNHmlTdLo+S4zEyyZ8w9hwlJlOIuHy2DHfzSBF7wFFaB/4+mY7e89hazHM7xEwcnKwVnVNYDiJqukNMV8hvPncLFKP584V5R/PX9zAoDMJj+o8JchY27tK8CtPSkzrXCVWpVzVI1dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427936; c=relaxed/simple;
	bh=aoP7EQd5QUe4M49NjN7aKnLIjsSGkln+5WxgK9cAsmk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FmcnSE5W91YZ7rbUAn9PTCZLPAp+AzmmfRA7C0Hmadcq7+uFnMcZYeWTMjOmg5SAJ8muQhRgQjG4vTtwp5E86YPNwOAf3CBVJNW8asAQ1JTWM8GBSmGNHRFNGkxlts3TLSE02XAT5dB5U1tx/XjqRKzhBsmqsVqxvoJud30zUq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbTdwKtQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbTdwKtQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B54D1F000E9;
	Thu,  3 Sep 2026 09:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788427934;
	bh=1UtFAUFo8+KiwrhWvyGpRAcVYhKjzwKXuwPIjKwYvfs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HbTdwKtQQXwGBvfMTz3CvtO70iwm3wOjgSEXqdzjrEO8cir2noyHffF3uHsnsxA2J
	 P9TcKAEXt49wi7g7OBN1UEXxLVI/JHmydyKHIyXmewlNwAyAcQ3xEjKwqBxuqUUDPz
	 jjU+zNJ6lo64y7e/l8CT1Sko7RCmvDSbe+MNhHNutRO0Le23oHWTdug9XULLQMUrkt
	 BLD4Kuz3H8iqS+lt3hgGXdOVWoFTUJAOEkMPuaFMrdX5jYCo9W1W7ogzQZeNR07N/8
	 MAINDQMhllQexT3jXMrWqzmZ72kpKbszIuFY1BBq24n9ehEeIfGxwqwzpWGRGxZKed
	 cgwzjki27sWGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: Add assertions for
 bpf_program__{add,clear}_flags()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260903092416.223294-2-toke@redhat.com>
References: <20260903092416.223294-1-toke@redhat.com>
 <20260903092416.223294-2-toke@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 09:32:14 +0000
Message-Id: <20260903093214.9B54D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing early exit on failure to load BPF skeleton or modify fla=
gs, causing the test to continue execution on error.
--

commit bedacf91bd94531ce369ba064e4bc6158bdcecdb
Author: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

selftests/bpf: Add assertions for bpf_program__{add,clear}_flags()

This commit adds tests to ensure that bpf_program__add_flags() and
bpf_program__clear_flags() correctly modify and restore program flags.
It inserts these checks into the existing kernel_flag test program.

> diff --git a/tools/testing/selftests/bpf/prog_tests/kernel_flag.c b/tools=
/testing/selftests/bpf/prog_tests/kernel_flag.c
> index 25eb59f460abe..72c0ef8da409e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
[ ... ]
> @@ -10,15 +10,31 @@ void test_kernel_flag(void)
>  	struct test_kernel_flag *lsm_skel;
>  	struct kfunc_call_test *skel =3D NULL;
>  	struct kfunc_call_test_lskel *lskel =3D NULL;
> +	struct bpf_program *prog;
> +	__u32 flags;
>  	int ret;
> =20
> -	lsm_skel =3D test_kernel_flag__open_and_load();
> +	lsm_skel =3D test_kernel_flag__open();
>  	if (!ASSERT_OK_PTR(lsm_skel, "lsm_skel"))
>  		return;
> =20
> -	ASSERT_EQ(bpf_program__flags(lsm_skel->progs.bpf) & BPF_F_SLEEPABLE,
> +	prog =3D lsm_skel->progs.bpf;
> +	flags =3D bpf_program__flags(prog);
> +	ASSERT_EQ(flags & BPF_F_SLEEPABLE,
>  		  BPF_F_SLEEPABLE, "sleepable in program flags");
> =20
> +	ret =3D bpf_program__add_flags(prog, BPF_F_ANY_ALIGNMENT);
> +	ASSERT_OK(ret, "bpf_program__add_flags ret");

[Severity: Medium]
Should this assertion be wrapped in an if (!...) condition to short-circuit
execution on failure?

If bpf_program__add_flags() fails, the test will log the error but continue
executing with an invalid state. A clean abort here could prevent cascading
failures in the test output.

> +	ASSERT_EQ(bpf_program__flags(prog), flags | BPF_F_ANY_ALIGNMENT,
> +		  "bpf_program__add_flags value");
> +
> +	ret =3D bpf_program__clear_flags(prog, BPF_F_ANY_ALIGNMENT);
> +	ASSERT_OK(ret, "bpf_program__clear_flags ret");

[Severity: Medium]
Similarly, does this need an early exit if clearing flags fails?

> +	ASSERT_EQ(bpf_program__flags(prog), flags, "bpf_program__clear_flags va=
lue");
> +
> +	ret =3D test_kernel_flag__load(lsm_skel);
> +	ASSERT_OK(ret, "test_kernel_flag__load");

[Severity: Medium]
If the skeleton fails to load, this standalone ASSERT_OK() allows the test =
to
continue execution to lsm_skel->bss->monitored_tid =3D sys_gettid() and
test_kernel_flag__attach().=20

Could this cause the test to crash or produce noisy cascading failures?
Wrapping this in if (!ASSERT_OK(...)) goto close_prog; would ensure we exit
cleanly if the load fails, similar to how the attach step is handled later =
in
the function.

> =20
>  	lsm_skel->bss->monitored_tid =3D sys_gettid();
> =20
>  	ret =3D test_kernel_flag__attach(lsm_skel);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903092416.2232=
94-1-toke@redhat.com?part=3D2
