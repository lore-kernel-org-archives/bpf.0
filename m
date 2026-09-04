Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9516F358378
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 06:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502184; cv=none; b=PMz06PZu/PYPRJ4yAFkin4MhoAUcUsTKEqNaMdHRNgz/IFryI+yN4cW9Gfue05XBlqsE4jp6iCnG6tqFWNvxG5AuIO1UajybtJSztUp8Sn2ZnrxW1CT07y4ZKQTnDQLy/YxsBztnQ7Qys3Iw5e0Yc4dfu0KJ1egn4FvOEiRnrvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502184; c=relaxed/simple;
	bh=zyXffOIxDrOjcI1yYYbTmCGMEqoRNLulyQKuSSaYBeQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=My2yB0sZ86UgWIl4OJyE3AOEEgZJQn+25RjT0KL6ZJRbhxRYOaeEggDS6/PUTzAhRSExe8gSb95JaiTJ23LpMGfb/xAhSxoVL9uKRNtzewG9xzJB1KLNEzJGW9SYjqrAjFoW75GfIkq1qOC2ThyHHYTCnRhPQ7cKmKq9CULbT4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmoBPx1h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmoBPx1h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98651F00A3F;
	Fri,  4 Sep 2026 06:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788502183;
	bh=eNKaWKv89DfELipwaDha/wU41O+euN4ntHHIhAK5jUM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DmoBPx1h5JZoWrkQh1Ndv2CfFYqNWq6LUz4TjbsRbtMzvdbFmTeg0Pepa7UsSiPC2
	 +PkuO0lvBnOfPezwd+1i+RfM/+rYXq9buGEViJVZ0LV4kkr+eBlyOlZQj9bftW1DRA
	 8VCcp+MtSFJrvdOI9BBvQmq1miE/6JhBEQk4MULZAzJDC7rk7Z2PBx2Nx0uMQxx50U
	 Z2rlDhCHomMMo8gFwJtRohLaU1gYsZRAlDeIqMdJry3BKyl3Tc5oFTpVhmY6UqLOmj
	 nXiz1bt7CvMkb1N5BLf7Psxle51Y5HVXc9Avl7mPzNUg3IYOa0Xu47XUJ2mAz8VueN
	 v5h5OcIeTIFTg==
Content-Type: multipart/mixed; boundary="===============2923292248830055560=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f3466f8c3246d1abb06f2651a539c2697670246105f2b4664cba6455fe9199c0@mail.kernel.org>
In-Reply-To: <20260904051054.3983495-1-yonghong.song@linux.dev>
References: <20260904051054.3983495-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 11/12] selftests/bpf: Add inline-asm tests for by-value arguments
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  4 Sep 2026 06:09:42 +0000 (UTC)

--===============2923292248830055560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_arg.c b/tools/testing/selftests/bpf/prog_tests/aggregate_arg.c
> new file mode 100644
> index 000000000000..b230f3bd3b2a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/aggregate_arg.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +#include "aggregate_arg_func.skel.h"
> +
> +void test_aggregate_arg(void)
> +{
> +	RUN_TESTS(aggregate_arg_func);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/aggregate_arg_func.c b/tools/testing/selftests/bpf/progs/aggregate_arg_func.c
> new file mode 100644
> index 000000000000..61dd5f86c3a4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/aggregate_arg_func.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +typedef unsigned __int128 u128;
> +
> +struct pair {
> +	__u64 lo;
> +	__u64 hi;
> +};

[ ... ]

> +#if defined(__BPF_FEATURE_STACK_ARGUMENT)
> +
> +__noinline __u64 global_arg_split(int a, int b, int c, int d, struct pair p)
> +{
> +	return (__u64)a + b + c + d + p.lo + p.hi;
> +}
> +
> +SEC("tc")
> +__failure __msg("global function global_arg_split() needs 6 > 5 argument slots")
> +__naked int aggregate_arg_split_fail(void)

[ ... ]

> +SEC("tc")
> +__failure __msg("global function global_arg_past_regs() needs 7 > 5 argument slots")
> +__naked int aggregate_arg_past_regs_fail(void)

[ ... ]

> +SEC("tc")
> +__failure __msg("global function global_arg_i128_slots() needs 6 > 5 argument slots")
> +__naked int aggregate_arg_i128_slots_fail(void)

[ ... ]

A subsystem pattern flags this as potentially concerning: this commit
creates a new BPF prog file (progs/aggregate_arg_func.c) plus a new
test_progs entry point (prog_tests/aggregate_arg.c) for by-value
argument tests, while the immediately preceding commit in the same series
(7bdde6e0b83d) added by-value aggregate argument tests to the existing
progs/verifier_int128_arg.c, which is already run by
prog_tests/verifier.c.

This means coverage for one feature is now split across two test runners
in the same directory, and struct pair is defined twice
(progs/verifier_int128_arg.c and progs/aggregate_arg_func.c).

Three of the six new subtests (aggregate_arg_split_fail,
aggregate_arg_past_regs_fail, aggregate_arg_i128_slots_fail) are pure
__failure/__msg verifier tests that need no hand-written register layout,
so they could fit as cases in the existing file. The same is true of
aggregate_arg_pair_ptr_fail.

Is there a reason to create a separate test file rather than adding these
tests to the existing progs/verifier_int128_arg.c, which already covers
by-value aggregate arguments and would consolidate the feature's tests in
one place?

(For context: the pattern is motivated by the fact that aggregate_arg_pair_asm
and aggregate_arg_pair_ptr_fail need hand-written register placement that
C cannot express, and this layout mirrors the existing aggregate_ret
structure with prog_tests/aggregate_ret.c + progs/aggregate_ret_func.c.
A following commit extends the test with kfunc cases, so the new entry
point is reused rather than single-purpose. The question is whether the
C tests in verifier_int128_arg.c should move here too, so the feature's
tests live in one place and struct pair is defined once.)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33840714551
--===============2923292248830055560==--
