Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1086913FEE
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 06:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777098104; cv=none; b=WJ0ipT+srNO3oQHGzVVP53mX7n9JPS9Hk8uOvDk5NUefzIMaHzrJ8Pa6WAGESGIFAr8bBaceHGo8wrZ4kdyObuoAD6LPLsxiq/LyWA/ZeKsTN578lpIQ6bjj15pqNvpjvv0v1uJBXw8FjuVuu6q3G97j+caoCE5LSohuZI9NiTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777098104; c=relaxed/simple;
	bh=mT3Zo9nx3IRvfi6wtUI8OyMiq/e+PhQKQk5hZA9uZVQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZNXytxMN2CIRPzy9tqNv5PgC115qw9zcmQ8oOyIgzEZWkVx5b1WCdEZKMyAR8JYU8az+qtfPGdq6F9k4UJ3cbDW3IV9g6aOOj0zwoWZI5imTc1jIx0f+lMZqjPtzoO8z1fA1wtJ2eZPreOa5JgAAvy9okqzhogYy31BFxSXQa9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgNx+WX6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgNx+WX6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A9EC2BCB0;
	Sat, 25 Apr 2026 06:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777098103;
	bh=mT3Zo9nx3IRvfi6wtUI8OyMiq/e+PhQKQk5hZA9uZVQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=KgNx+WX6LMettESqnxkDEKRrUInXPw/tI1TDHCFaelZ0KHUk4Acv1rqmo0EQu2G6g
	 0eisLhmZWehanzrktOG+ug51Eo2d5ufCCXo7IzkqE2kJl1aNi+DYVUW8cpOHEzyMku
	 wDLdoxBDJtd6n05ryWh5p6t0jBq8xwN1nGlIiI8gi69b7Ictxlk7pzRBViEzIp3+gD
	 g6b2jY3xRbiZcivgLiPl/JzZaN183Z2gAOYlxl6xPsbq0gVj8/jt6SFxa7Ahh9WiUS
	 CLcft7rdVVYk8pmoc3hgXZrMQn+Hie3oJv7GW6WLpRqfNek34IWIB0VFE7gb9ZOWdC
	 FKbJ0cS3YbIOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 6/8] selftests/bpf: do not run verifier JIT
 tests when BPF_JIT_KASAN is enabled
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260413-kasan-v1-6-1a5831230821@bootlin.com>
References: <20260413-kasan-v1-6-1a5831230821@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 06:21:42 +0000
Message-Id: <20260425062143.81A9EC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] get_kasan_jit_enabled() unconditionally returns true, incorrectly =
skipping JIT verifier tests on all kernels.
- [Medium] Repeated, uncached parsing of the compressed kernel config file =
for every JIT test drastically degrades test execution performance.
- [Medium] Aborting the entire subtest when KASAN JIT is enabled unnecessar=
ily drops unrelated test coverage.
--

commit a6c1eb256b8f5c1306ecd153f22c3c278b50ae23
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

selftests/bpf: do not run verifier JIT tests when BPF_JIT_KASAN is enabled

This commit aims to skip BPF verifier tests that check exact JIT instructio=
ns
when the kernel is built with KASAN and JIT enabled, since the inserted KAS=
AN
instrumentation breaks exact instruction matching.

> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/se=
lftests/bpf/test_loader.c
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
[ ... ]
> @@ -1175,6 +1175,11 @@ void run_subtest(struct test_loader *tester,
>  		return;
>  	}
> =20
> +	if (is_jit_enabled() && subspec->jited.cnt && get_kasan_jit_enabled()) {
> +		test__skip();
> +		return;
> +	}
> +

By returning early here, does this code unnecessarily skip other valuable
validations? While KASAN breaks the exact JIT instruction check, skipping
the entire subtest drops coverage for program loading, verifier log checks,
and translated instruction validations. Could the skip logic bypass only the
later JIT verification block instead of aborting the whole subtest?

Also, does this repeated execution degrade test suite performance?
get_kasan_jit_enabled() is called here for every subtest with JIT assertion=
s,
which will repeatedly open, decompress, and parse the kernel config file.
Could the config check result be cached in a static variable instead?

> diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing=
/selftests/bpf/unpriv_helpers.c
> --- a/tools/testing/selftests/bpf/unpriv_helpers.c
> +++ b/tools/testing/selftests/bpf/unpriv_helpers.c
[ ... ]
> @@ -142,3 +142,8 @@ bool get_unpriv_disabled(void)
>  	}
>  	return mitigations_off;
>  }
> +
> +bool get_kasan_jit_enabled(void)
> +{
> +	return config_contains("CONFIG_BPF_JIT_KASAN=3Dy");
> +}

Does this code unconditionally evaluate to true on all kernels?

The config_contains() function returns 1 if the target string is found, and
-1 if the end of the file is reached without finding it. Since both non-zero
integer values evaluate to true when cast to bool, it appears this will
cause the framework to skip the tests even when KASAN is disabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413-kasan-v1-0=
-1a5831230821@bootlin.com?part=3D6
