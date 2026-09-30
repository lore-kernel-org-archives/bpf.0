Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59754E77F3
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799736; cv=none; b=W56oEWynpOM65mfXmcJURh+8Cq+KtIeebfHpqG8tRPKoJMQUzpc8BI3PbGVN7p2UFcnEtBD60WjzTbD3i7wStPEObMbrtoXV4fl0GPmMX9Li8SfdV2E0e3YEgd+hw9C6Szt5xlDqzMwK9LhuPRG6D7TUoBxHm+Of5TvQnLIrr7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799736; c=relaxed/simple;
	bh=SZsJ55ewHuSYYdoAMtIPxKv/oom2tvo/sQSmOMEO9Zw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NqSF5rVErYGg3cR1tW9ZjwnxWRiunwnjLPIlOgJDXARiISgATmGnUoZ+nSFjq1fZDCiAiklZSkTs5pfzc+nJ5TQVWI2dETTcF7C4K3I2r2Y+s+BrTnUifP5XV8Sk97BMVokdhtL6YdOWa16Ppts9wC7fB8tA7z0cPVUBZwUFTNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtWHn7eg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtWHn7eg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAE01F00898;
	Wed, 30 Sep 2026 20:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790799734;
	bh=lPFJ9zW9p/iW2fDA9ZsbehGiUs1wfahczd8obEvE/08=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HtWHn7egUO1MO4zZmox6YHc1P99nghbKkISPoMsYaz9sbL5Y2YulUBTz7QWh/wrq1
	 h6h/QTVBZROKD63IvMyROwSCP8tFREX42BpPMQnTY8bBPM9lOHTgLWG0GhRTJId2vy
	 dKssplBoay2YwvL3sZh2M+6V7H2VboNeg5D8QqeIOAm8JhUq9ARPunrD33NH1Nb5TR
	 +VKrA5cJ/G+7wBW4DFCxHWoLzazMOyd0KrE5sA85joL/YNc/BV5Jl9GD3kfmreW1n3
	 txAcKXgsADfu34lmAEMmbBgTGgvKnxyk+nCCsb3zTqH1sjFQ83ZjgxkGDa/9rpEBoC
	 F9DBqX3umMvKg==
Content-Type: multipart/mixed; boundary="===============5057781823704840857=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c5206372156f9be0095069fd1d36419148006ee6a92b5e72068dd73f01a715aa@mail.kernel.org>
In-Reply-To: <20260930193127.2181684-5-alexei.starovoitov@gmail.com>
References: <20260930193127.2181684-5-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 04/14] selftests/bpf: Add tests for arena access through numbers
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 30 Sep 2026 20:22:13 +0000 (UTC)

--===============5057781823704840857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add tests for arena access through numbers

TL;DR: Test-only nits in the new blinded arena test: it could live in
verifier.c next to the existing suite (separate file also seems fine), and the
JIT-disabled skip lacks a reason message.

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_scalar_blinded.c b/tools/testing/selftests/bpf/prog_tests/arena_scalar_blinded.c
> new file mode 100644
> index 000000000000..2ac2e9a652fe
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_scalar_blinded.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include "sysctl_helpers.h"
> +#include "verifier_arena_scalar.skel.h"
> +
> +/* The same tests with constants of the programs blinded */
> +void serial_test_arena_scalar_blinded(void)
> +{

A subsystem guideline flags this as potentially concerning: a new, narrow
test file for a variant of something an existing test in the same directory
already covers.

prog_tests/verifier.c already includes verifier_arena_scalar.skel.h and runs
the same programs through test_verifier_arena_scalar().  Could this be a
serial_test_verifier_arena_scalar_blinded() placed next to it in verifier.c,
so the two variants of the same suite sit together?  test_progs finds
serial_test_ functions in any prog_tests/*.c file, so verifier.c would work.

Keeping it separate also looks reasonable.  The test has to be serial
because it changes a global sysctl, and verifier.c has no serial_test_
functions today.  One difference is that RUN() in verifier.c drops
CAP_SYS_ADMIN while RUN_TESTS() here keeps it, but no expectation in
verifier_arena_scalar.c appears to depend on that.

> +	const char *harden = "/proc/sys/net/core/bpf_jit_harden";
> +	char old[16] = {};
> +
> +	if (!is_jit_enabled()) {
> +		test__skip();

A subsystem guideline also flags a skip that has no reason string as
potentially concerning.

When the JIT is disabled, test__skip() is called with no message, so the
log does not say that the prerequisite was bpf_jit_enable.  test_loader
prints a reason for its own skips, for example in run_subtest():

    printf("%s:SKIP: %s\n", __func__, spec->skip_reason);

Would a one-line printf() before test__skip() help, for example:

    printf("%s:SKIP: blinding needs the JIT\n", __func__);

Skipping instead of failing looks right here, since constant blinding only
happens when the JIT runs, and a bare test__skip() is also used in
prog_tests/callx_func_ptr_map.c, prog_tests/callx_rodata_lskel.c and the
RUN_JITED() macro in prog_tests/verifier.c.  The only gap is the missing
reason string.

> +		return;
> +	}
> +	if (sysctl_set_or_fail(harden, old, "2"))
> +		return;
> +	RUN_TESTS(verifier_arena_scalar);
> +	sysctl_set_or_fail(harden, NULL, old);
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36768148430
--===============5057781823704840857==--
