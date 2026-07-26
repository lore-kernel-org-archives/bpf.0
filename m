Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2E735E922
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 01:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785030243; cv=none; b=cNDFOUT1bdcFNWrwpjBmwFBudR8kgFwpnXm9U3VG7ndGPEF7s1VaS68opn4S8f5T1GFM8SFZkCrEfmfk4cFvAwvc7i1B1yQTqVPIxBz0hwGi8p/DdjOJfUPeAeCQM2Y0zUu1DHCy0J16gE/Tbol9qrlh7U/Yetq1W63JF6Qfoj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785030243; c=relaxed/simple;
	bh=38AnMBuCbw+55MDFLYyph/VcHYPX/W4afpM29oOY9iw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MRJcsAcNb1/qAviS/dDXR8OwkNhrd1tbnivue4p915d2Sg1wM0o9Cxag3clF3ZC+BCBoaI0Idp1yH6K0gtAvw0YCe72URFEpBnIunh0Dod7luOKzfqyWY1dUjKjHbdyOncF5OsE7RyyGiSOo0dtuYuTS16lS1kkSffehJtiBIcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXsAEw2S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXsAEw2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E3F1F000E9;
	Sun, 26 Jul 2026 01:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785030242;
	bh=QI/cMI01W9nCdH621ZKTZajwfuva14Eop7FIuHCKS9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CXsAEw2SYpG7tiHATZMBHoVNj8Tj4VgB4qaNhkXrfcMOJGsA/ggEFameqwgvsVj4O
	 l6OVluw2MeBjX/hkyYUQGUDpqMVxgiT93hrkbxlOAtYaSRy86jbVlt8ii18EQoX3Aw
	 oSWugxZ8NFnm4q9pQR+rdHvooViT1R/U5NXJPlzt1OUUjN7MOP0h0hTUUNEBUCrON3
	 mlyF/PO3yVtcO+nNpfMkV7ieF8hkveH4MjVodSdLNJ2emRGUyzhJYbSAmohrJGpDx8
	 syUZg6QLZSmviMfOppRAUsiqEIlejlFswAzoYR10+wK7EAy8PrImv3vohokR2NmbR1
	 IjkVYbRQ5GAcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 6/9] selftests/bpf: Add JIT-sequence tests
 for __arena kfunc arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260726013105.3689867-7-memxor@gmail.com>
References: <20260726013105.3689867-1-memxor@gmail.com>
 <20260726013105.3689867-7-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 01:44:01 +0000
Message-Id: <20260726014402.23E3F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing test dependency check for `bpf_testmod.ko` in `test_aren=
a_kfunc_jit()`.
--

--- Patch [6]: [PATCH bpf-next v2 6/9] selftests/bpf: Add JIT-sequence test=
s for __arena kfunc arguments ---
commit 127efe77c3180fef987aeb8dfccbc04666cf9935
Author: Tejun Heo <tj@kernel.org>

selftests/bpf: Add JIT-sequence tests for __arena kfunc arguments

This commit adds JIT-sequence tests for __arena and __arena_nullable
kfunc arguments on x86-64. It pins the exact rebase sequences the JITs
emit to verify correct code generation.

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
> +}

[Severity: Medium]
Since this test relies on kfuncs from bpf_testmod, should there be a check
for env.has_testmod before running the tests?

If the tests are run in an environment where bpf_testmod cannot be loaded,
this will fail with a verifier kfunc resolution error instead of skipping
gracefully.

For example, adding:

    if (!env.has_testmod) {
        test__skip();
        return;
    }

would allow the test runner to skip gracefully.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726013105.3689=
867-1-memxor@gmail.com?part=3D6
