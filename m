Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDFB3932F9
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764127; cv=none; b=cFoFmshSEFX85439ZfZKn+n5ebnFNrs/jckdqYkJR54ENtaeR00kkJG7BOh7AVoy2B3/AOwOS2dQ2I9Zu4kBCIX2wtwgTlWvmeJd/NXU15FZ6uKWkfF7U0DG4pxaqw2BCMHGqlC7Rd40B6dvNI8LQkGfvsi/z6v7gN269xzQ0QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764127; c=relaxed/simple;
	bh=mgG96IOvQZnP0EzDecDuod8BOXPJ1D1TzOcFs+3aQlg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HoZrUCiZkZLtT5jKawfsNM9eoqIKwxGoVkZc9F7oXjy4L3+WRFh0LQZo4hhaBqXqtDM4gC1rVgAUpJrkc2drHLAAcL9/m2yhjUl9lu/BLhG2j6KixrITG+UgOayq6aIIbd4wmb/q3Sk9J+ZPtB0RDwznFP3tPj+tlzc2gzCNzk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5WXD1PC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5WXD1PC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0553E1F000E9;
	Mon,  3 Aug 2026 13:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785764126;
	bh=p0OutvycjuXEMHRWN2/lueaaBvAiX6OFBR7vl544fgw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f5WXD1PC7WYR29mqpMo19Di+dXE2+sah49OylGSzFFqcHbR+ZiWzrlagWDOIoMslI
	 ogzLni0BLKeHp6DRt0hf2z9VqhNdA/8xrP8Sv9Gozuph6XzCArweZvRAh8/1ADAc30
	 B+iRgg8j9PUnznE9D8hRM2cFEBz/20fyd7WtbbDchPm1jWqcPcucHlRxT/WdkZCmVW
	 QY2Fe1I5ZkG4pg47QNz7REjFy00G2XnSIncibDuM5x7/3ijVqw8hTgizOeCbZ6/xlS
	 icYGSCT1PaKfWtxywuBzhH0dUuL9VfB3bv/XC6w4HHAuydfMNeJwuz2RSTj6ZrHJQ0
	 Z7C+teGRB/MNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 6/9] selftests/bpf: Add JIT-sequence tests
 for __arena kfunc arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803125115.2264733-7-memxor@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
 <20260803125115.2264733-7-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 13:35:21 +0000
Message-Id: <20260803133526.0553E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing `env.has_testmod` check can cause test failures when `bp=
f_testmod.ko` is not loaded.
--

--- Patch [6]: [PATCH bpf-next v3 6/9] selftests/bpf: Add JIT-sequence test=
s for __arena kfunc arguments ---
commit 9c67c6873243ff0c5bbb155714a37d780a229111
Author: Tejun Heo <tj@kernel.org>

selftests/bpf: Add JIT-sequence tests for __arena kfunc arguments

This commit pins the exact rebase sequences the JITs emit for __arena and
__arena_nullable kfunc arguments with __jited assertions on x86-64.

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_kfunc_jit.c b/t=
ools/testing/selftests/bpf/prog_tests/arena_kfunc_jit.c
> new file mode 100644
> index 0000000000000..2359cde24c45d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_kfunc_jit.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +#include "arena_kfunc_jit.skel.h"
> +
> +/*
> + * Runs with full capabilities: resolving module kfunc ksyms requires
> + * CAP_SYS_ADMIN, which rules out the capability-restricted runner.
> + */
> +void test_arena_kfunc_jit(void)
> +{
> +	RUN_TESTS(arena_kfunc_jit);

[Severity: Medium]
Will this cause test failures in environments where bpf_testmod.ko is not
loaded?

Since the loaded BPF programs depend on kfuncs (e.g.,
bpf_kfunc_arena_cap_test) from bpf_testmod.ko, if the module is absent, kfu=
nc
resolution fails and causes program load failures. Because the programs are
annotated with __success, test_loader will record these as test failures
instead of skipping them.

Should there be an env.has_testmod check before calling RUN_TESTS() to skip
the test cleanly?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803125115.2264=
733-1-memxor@gmail.com?part=3D6
