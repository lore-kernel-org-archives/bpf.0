Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DE32F6920;
	Mon, 13 Jul 2026 03:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783912620; cv=none; b=M/IeCUIS9PnKi8kHHXhZ1aB/0y0YgqwmAtEAwWuwp0AB86yr0Ezef67kHRCdGM8LQ2YruwR7d5OkwZ9MCppULsI/a4C69hRrGHO5y7re6KYbTX7bL8AzkmcmsOJYfuROWLZQGTqPpe+DTDChUw4IwYQ2zIuBMygysijOJNYVwAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783912620; c=relaxed/simple;
	bh=gJK4QYqv36E8TpV4oORblKmL1Yj8fycFolCJAs6RgS4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OUYVJP9iuZq68dDyAWymwgkbImjlkS9i2XHSuLHV2zqxzF4ThdV+BfC9AodpzVlhKHDH38GqMp5TYwQIFTmoz8HIT9RagI3XUnRyeejmNHPtpuoFb1uF4miw8nqJg8iTaOW8pTZhNOnT9Qs6wi7OmavJdWgniYEHfizEhgNsV/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISsRT1PY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISsRT1PY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECAB1F000E9;
	Mon, 13 Jul 2026 03:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783912617;
	bh=RnzRd8bWzBrUasip93YHhwfqq0EFdeXaJynfim2Jlw0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ISsRT1PYIlihAGwQHjCqgryWHsvEMlu5mQRlQwkRL1516u7jwpQCF+j5nCRhaJmx/
	 shJJijRGgSuSnx+NwQlcfKISrCvJVikTT6/ID0BVCPr2BCgDDd3f/sfG+9xjEfEsR9
	 bnrtSyfYrcleNiHhpWWoxOpvxpMJv30JTJj112Q5MPsfrX513kxGKd8I8OYq5/LPCx
	 AdR9eSHxxoHXbFhe92JfJ7oWz2fwc9ZKHHi74pDu3mn94jnZ+EvXSoT/0DZHVxTEeZ
	 LxmCLzHauUkw5jgFbkeV6CK7mVHE1YPjbmHRFWxVaiFf/3QZEr4/yNwC4IDgEdJhIJ
	 96aA33spm8Elw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHSET SLOP RFC 2/6] selftests/bpf: Add kfunc __arena
 argument tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260713024414.3759854-3-tj@kernel.org>
References: <20260713024414.3759854-1-tj@kernel.org>
 <20260713024414.3759854-3-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 03:16:57 +0000
Message-Id: <20260713031657.7ECAB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The kfunc arena argument fixup logic incorrectly translates a vali=
d pointer to the first page of a 4GB-aligned arena as NULL, causing kfuncs =
to receive a NULL pointer instead of a valid kernel address.
- [Low] Multi-line comment does not follow the mandated BPF subsystem style.
--

--- Patch [2]: [PATCHSET SLOP RFC 2/6] selftests/bpf: Add kfunc __arena arg=
ument tests ---
commit c3a66495e39c4d671a1065fb44bc6cef2f26d120
Author: Tejun Heo <tj@kernel.org>

selftests/bpf: Add kfunc __arena argument tests

Add arena-argument kfuncs to bpf_testmod, which also exercises the
argument rebasing on module kfuncs, and tests covering the accepted
argument forms (arena pointer, low 32 bits as a scalar, full user address
as a scalar, NULL), five arena arguments in one call with NULLs mixed in,
a kernel-side dereference of an unpopulated page recovering through the
scratch page, and the rejections (no arena in the program, incompatible
register type).

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_kfunc.c b/tools=
/testing/selftests/bpf/prog_tests/arena_kfunc.c
> new file mode 100644
> index 0000000000000..8946184553ea8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_kfunc.c
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Tejun Heo <tj@kernel.org> */
> +#include <test_progs.h>
> +
> +#include "arena_kfunc.skel.h"
> +
> +/* The test kfuncs live in bpf_testmod. Resolving kfuncs against module
> + * BTFs needs CAP_SYS_ADMIN, so run with full capabilities instead of
> + * through the verifier tests' capability-restricted runner.
> + */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the BPF
subsystem style?

The opening /* should be on its own line:

/*
 * The test kfuncs live in bpf_testmod...
 */

> +void test_arena_kfunc(void)
> +{
> +	RUN_TESTS(arena_kfunc);
> +}

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/test=
ing/selftests/bpf/progs/arena_kfunc.c
> new file mode 100644
> index 0000000000000..b5996944ed73b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c

[ ... ]

> +	/* NULL is preserved */
> +	ret =3D bpf_kfunc_arena_arg_test(NULL);
> +	if (ret !=3D 0xdeadbeef)
> +		return 5;

[Severity: High]
Does the kfunc arena argument fixup logic tested here incorrectly translate
a valid pointer to the first page of a 4GB-aligned arena as NULL?

In kernel/bpf/verifier.c:bpf_fixup_kfunc_call(), if an arena is created with
a 4GB-aligned user_vm_start, and a BPF program passes a pointer to offset 0
within this arena to a kfunc, the fixup logic uses BPF_ZEXT_REG(regno) to
clear the upper 32 bits, making the register exactly 0.

This is then explicitly checked by BPF_JMP_IMM(BPF_JEQ, regno, 0, 1), which
skips the kern_vm_start base addition.

Would this cause kfuncs to receive a NULL pointer instead of a valid kernel
address when passed a pointer to offset 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713024414.3759=
854-1-tj@kernel.org?part=3D2
