Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35D135966
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 03:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380680; cv=none; b=EsCJYReCzcM1owqsYWJaUKSs/TmyTa0ktM1aivyMprmv21kcoVV6dqhOpYHP7xi4fEGRO8MSCMbpLnV1ECJQdRoXuq2d8iR7BiS8X0+2H1usjO6DRemcDMpH3RzF8R/7WIdTO6sStNcZ5FiZJxa0cQHnHvfTwE5KErpIIBHK/TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380680; c=relaxed/simple;
	bh=W7QWTdMt/sq+VR4J+JSEfGBLgp7z0mtPMSjKcV/mfr4=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=l10gKS7G3kZQl0EjIei6RfIGI8WWd+Pii48LVcUDBY69hijyKbnYljJXiC6ATuZo8yh2+Pwv6ehIYVwgiztH/kqUBw8P9TNbBbSIviB27FecEohRZH1y9+pWkkd10KG3sCyZYDUL8bB5svR0QKsPnon2ywVpHV5AZBgZFM4yD3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpBKIBVp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpBKIBVp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E031F000C4;
	Mon, 19 Oct 2026 03:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792380678;
	bh=JAJ/qzmWMngPY+a7DE1GBIHYpP+bqjPTj2om3pToQdQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=kpBKIBVp/AH5KUW9elLFav2V6tS40WafV/si3X/+z03STa0IOYzf3aq1HKxjux8fW
	 Rq/tJJhB7APphAxQMQ3/41/8Dr2rHlm8muBylLUbC4/SMPXOMtkwdKBFYDQv4GnsED
	 jQJt9yxGwDhv/vpxiBKejaKyaxa80+MXDw8alTqq9eK2IJm5vTQ83uHjt+OQM4ebo2
	 65USrsTp6DGMoPD/T7D0maEQfVWj4GSkMIPvFF3FyNb91Pftc6E8BvBrqco5E1o3gx
	 bkwtqFhnaC7RU8YIE96x6UMDNKuxSMV9IlAOnc7OGehqEXy9pMXP3x4T8fYu4S9Cy8
	 tlCGD0Hqs6OFg==
Message-ID: <sashiko-outbox-176573@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 04/16] selftests/bpf: Clone a program that
 calls a module kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261019032401.2302823-5-memxor@gmail.com>
References: <20261019032401.2302823-1-memxor@gmail.com>
 <20261019032401.2302823-5-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 03:31:18 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests/bpf: new standalone file for narrow bpf_program__clone() =
variant
--

commit 037d01e59174031ad79e435ca7e39a5bb4ce575d
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

selftests/bpf: Clone a program that calls a module kfunc

This commit adds a selftest that opens kfunc_call_test, prepares the object
via bpf_object__prepare(), and loads kfunc_call_test1 using
bpf_program__clone() to verify module BTF fd handling in the object's
fd_array.

> diff --git a/tools/testing/selftests/bpf/prog_tests/clone_module_kfunc.c =
b/tools/testing/selftests/bpf/prog_tests/clone_module_kfunc.c
> new file mode 100644
> index 0000000000000..fa6ccbaa7fd98
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/clone_module_kfunc.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +#include "kfunc_call_test.skel.h"
> +
> +/*
> + * bpf_program__clone() loads a program from a prepared object with the
> + * fd_array of the object, where module BTF fds start at slot 1 and slot=
 0 is
> + * empty. It used to pass the fill index of that array as fd_array_cnt, =
which
> + * made the kernel resolve slot 0 and fail the load.
> + */
> +void test_clone_module_kfunc(void)
> +{
> +	struct kfunc_call_test *skel;
> +	int err, fd;
> +
> +	skel =3D kfunc_call_test__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	err =3D bpf_object__prepare(skel->obj);
> +	if (!ASSERT_OK(err, "prepare"))
> +		goto out;
> +
> +	fd =3D bpf_program__clone(skel->progs.kfunc_call_test1, NULL);
> +	if (ASSERT_GE(fd, 0, "clone"))
> +		close(fd);
> +out:
> +	kfunc_call_test__destroy(skel);
> +}

[Severity: Low]
This isn't a bug, but test_clone_module_kfunc() in
tools/testing/selftests/bpf/prog_tests/clone_module_kfunc.c adds a new
standalone test file for a single bpf_object__prepare() and
bpf_program__clone() check on kfunc_call_test.skel.h.

In the same directory, tools/testing/selftests/bpf/prog_tests/kfunc_call.c
already includes kfunc_call_test.skel.h, exercises kfunc_call_test1 across
loader variants, and groups subtests under test_kfunc_call():

tools/testing/selftests/bpf/prog_tests/kfunc_call.c:test_kfunc_call() {
	test_main();

	if (test__start_subtest("subprog"))
		test_subprog();

	if (test__start_subtest("subprog_lskel"))
		test_subprog_lskel();

	if (test__start_subtest("destructive"))
		test_destructive();
}

Similarly, tools/testing/selftests/bpf/prog_tests/prepare.c and
tools/testing/selftests/bpf/prog_tests/clone_attach_btf_id.c already test
bpf_object__prepare() and bpf_program__clone().

Could this check be added as a subtest or case in an existing test file such
as kfunc_call.c, prepare.c, or clone_attach_btf_id.c (similar to how the
preceding patch in the series extended prog_tests/map_excl.c) instead of
adding a new standalone file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019032401.2302=
823-1-memxor@gmail.com?part=3D4
