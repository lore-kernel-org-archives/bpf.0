Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0CE3A63EB
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 22:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809814; cv=none; b=q4Aarn5Th/XyDF1YHCI+otdLu7am+JD6tcd+scKk6rtGRBk3GJkisrIJms1W6O3QKcSxRKLN2dLNDDw8UiaBRXcOfobDeReAHjP0KaPGu9qCjNKJVzi2VaPJ+pr1UfgEA8nhg9vbCWJMxXbMF47tVyfu/QgYrIMfNvP1ocCt5vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809814; c=relaxed/simple;
	bh=euBu2N68Y6Y91IeVX4SmCqIP0+NVF/RllhtH6xqhv4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RoKLI3LPrHA0Fb4vmORE1aOmd5OP26oPCX9MsdOvUIEI6R1wrUZitgRps1DoCjMWEyfsfSAVp+NFiV10yIaZKj331XlQNR14JaN0wuosNi5Q0T341oyKxL54v1DMSKjYAGc+V4xuZPWzvLmMGKzwgm6Mx7QVKI9GmV2vOhzMBBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGFo5VWy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGFo5VWy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75221C2BCB0;
	Tue, 21 Apr 2026 22:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776809813;
	bh=euBu2N68Y6Y91IeVX4SmCqIP0+NVF/RllhtH6xqhv4c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JGFo5VWyKDNSabLeds8EXpMIfpAKEbI2BwGP/KR701gRd4fbjVEDuQTSE7QCO4fuO
	 xhgCbeU6Q4mk8BDW4qBSHMnBWVe2cTOTajeXbAVD7LRIn6q+GuTGp9nLLPow5xTGLN
	 dEuQVVuoYrFsvp59Ketr+rwPOZlwLRdOOui6naBNhFwaOU3sEttVgc8sTopaZdIW4Y
	 4mqS2wQqKoEk5gup46sH3nkxjnFmKF36aIwyD7Qu3YQe42qGzHtT/9U+b0Rhc/GcJA
	 D0gYECEh4YJxyKokreFvosvG0v4zBug9JV/4OJryrW8QofP84jFASTavNrSUH4/Qsr
	 bznq7lz0/LZCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 8/8] selftests/bpf: Reuse stderr parsing for
 libarena ASAN tests
Reply-To: sashiko@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260421165037.4736-9-emil@etsalapatis.com>
References: <20260421165037.4736-9-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 22:16:51 +0000
Message-Id: <20260421221653.75221C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The `verify_test_stderr()` function ignores unprivileged stderr =
test tags (`__stderr_unpriv`), silently skipping their verification.
--

commit a614a51f0e77c17b24ea2c75a95abb7cf65988a1
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: Reuse stderr parsing for libarena ASAN tests

This commit adds code to directly test the output of libarena ASAN tests by
reusing testing infrastructure from BPF streams. It introduces a new
verify_test_stderr() helper and test tags to validate stderr output against
expected messages.

> diff --git a/tools/testing/selftests/bpf/libarena/include/test_progs_comp=
at.h b/tools/testing/selftests/bpf/libarena/include/test_progs_compat.h
> new file mode 100644
> index 0000000000000..9d431376c42f2
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/include/test_progs_compat.h
[ ... ]
> +#define __stderr(msg)		__test_tag("test_expect_stderr=3D" msg)
> +#define __stderr_unpriv(msg)	__test_tag("test_expect_stderr_unpriv=3D" m=
sg)

[ ... ]

> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/se=
lftests/bpf/test_loader.c
> index c4c34cae61027..ee637809a1d4e 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
[ ... ]
> +void verify_test_stderr(struct bpf_object *obj, struct bpf_program *prog)
> +{
> +	struct test_spec spec =3D {};
> +
> +	if (parse_test_spec(NULL, obj, prog, &spec))
> +		return;
> +
> +	verify_stderr(bpf_program__fd(prog), &spec.priv.stderr);

Does this code ignore unprivileged stderr test tags?

It appears that verify_test_stderr() hardcodes the use of &spec.priv.stderr.
Since it lacks an unprivileged parameter to select the unprivileged spec,
any expected messages specified via __stderr_unpriv() might be silently
ignored.

> +	free_test_spec(&spec);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260421165037.4736=
-1-emil@etsalapatis.com?part=3D8
