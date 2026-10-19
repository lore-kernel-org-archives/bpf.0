Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15E54D4874
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416596; cv=none; b=Blq9UoPT6/gH/QNMDBcEqdI3p3gQxr+40vrm0IbGCnp8l3y1+ujpDJjmKnKDxxzGfISY3A7x4rknTwKWzfN6oCHap8O9dEjOO+/x1ktHyD+mizaWo9dMlaxr4h5iqP+Kx5q6+5ZZzOZSUR/9EsK5A00+ZbMvSjhf032b+fTNPr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416596; c=relaxed/simple;
	bh=FmrOEGaHZrtXlOqS/Fq+aAw+64LBXN7UXdXhLiR8lx4=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=BdYeYqyP8MpYKfFEE8lMTqbW4gk/XUbIKJHBHFS7Z/iRI3xkmxWg75iTROsG9hjzm4d0xlkQMXoGxHZZDz4iAgnFasPcIeoAggIkFASPkiFJifXm88AGyy/VFPDjC/sg4ctw8Yn6M27RXP1VLHNnsb5j9oBcdtEAI45cRknQsrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XE4QMPC3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XE4QMPC3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BB01F000C4;
	Mon, 19 Oct 2026 13:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792416594;
	bh=OFriuVIGYxLnuLFhjj4Rsg+SiL9qzqaATxgIDLwmags=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XE4QMPC3O358mqCpOERTA7ZidNxcOtF08Do2lmszfSahFy6VTThCG+4+nZJXDpWkB
	 0OAwE/fuwvEzOTzr7aEQaDJFxYarkfkarhJTXv139s2EVaYtl1Ngm14kbEtJ3+FcqS
	 oI7QzN7Wl+Bx/hGG0pPGv8foEKG11VwtmxysMKEBvC/XmK+RecHac+DwSnAuMzpj8M
	 KkUQ4T2mNrNQwTrMbtJ7PclQovhE7nNbadm7gJ365ICQTBP3Y02MfmiRJcc/1F3zAE
	 hAgiyZ6QQn4gUI0BlanvCwPxk/dsersa49iGaE1VqgaA+XO0VFG1dxN5G+nBKDVRQG
	 +6wbaf3EabxLg==
Message-ID: <sashiko-outbox-177154@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 04/16] selftests/bpf: Clone a program that
 calls a module kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261019132203.3034698-5-memxor@gmail.com>
References: <20261019132203.3034698-1-memxor@gmail.com>
 <20261019132203.3034698-5-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 13:29:53 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests/bpf: standalone test file added for narrow kfunc clone ca=
se
--

commit 19b505b6bd62b4d72675abd0ca5df741fd9d15b1
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

selftests/bpf: Clone a program that calls a module kfunc

This commit adds a selftest that opens kfunc_call_test, prepares the BPF
object, and clones kfunc_call_test1 via bpf_program__clone() to verify modu=
le
BTF fd handling in fd_array.

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
This isn't a bug, but tools/testing/selftests/bpf/prog_tests/kfunc_call.c in
the same directory already includes kfunc_call_test.skel.h and exercises
loading kfunc_call_test1 across multiple loader paths in verify_success() a=
nd
subtests in test_kfunc_call():

tools/testing/selftests/bpf/prog_tests/kfunc_call.c:test_kfunc_call() {
	test_main();

	if (test__start_subtest("subprog"))
		test_subprog();

	if (test__start_subtest("subprog_lskel"))
		test_subprog_lskel();

	if (test__start_subtest("destructive"))
		test_destructive();
}

Rather than adding a new standalone file for this narrow bpf_program__clone=
()
variant on kfunc_call_test1, should this be added as a subtest in
test_kfunc_call() (or an additional check in verify_success()) in
tools/testing/selftests/bpf/prog_tests/kfunc_call.c?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019132203.3034=
698-1-memxor@gmail.com?part=3D4
