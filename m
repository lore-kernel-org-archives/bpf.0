Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711004A5C42
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145249; cv=none; b=I0xyR1WM1F5632umkkXBtPynDfZJijDwk83AH1I0gV1dCkxMOao5TwnyE2tuk6Wpr1PGDeK3pm3OyNgKrOjfgDaOD9IL9TPP7GUsgboUYyxqlS2kQYn91kiKH3kV+tZb7/aNL052yrJ1s9ntVHC6fnyzqJjwJzJHTZwQe3wKvw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145249; c=relaxed/simple;
	bh=qSQLrZGvrhZdE6dAx4lS8GNnaTknKy3r2POxWrQTZuk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ErPMFDjTLsjSbzAbze7MUhd9nfHk35g/BsnXa3y62PtzfnO8oz3HQbU7olRfIXGRGtQMuOsN6OMgCmvaGi1nslsCFckBIUljgRq7jt0QOemsKVH+kYzpRILq+SpADqSmDh5W4+NpaTNkMotfCxl0S95NbthIw2SE0CYnpkv+U6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuD9Dbet; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuD9Dbet"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EF41F0089D;
	Fri, 11 Sep 2026 16:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789145246;
	bh=nUGvbfGTcBOLj75AsfRrMgBvuBDfpdx1/FkcHhdNvOI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TuD9DbetX1he/S1qPS9bkEfJ3sVfAGBXq9fGuJ41DRVKX6riAccSkjd4FGEp2V05G
	 47v/oHDKeh5xKw+yeAHiog2lIltBodNQ9vAji6XyeBCC8nDM7KOLQYRQoUJEIgbcot
	 hhRvb5ZSBQ1EWuIcigZJCXxu0FrR/nkoln4GlNNH1ETNnKYKBQ/FAGyl9vznaOV9VP
	 4IOzyAPU1mIeYc355shrvbcN/BikpAnCTTmJG2QTJYA9jn0A/9cUeKXFwzZmHp4lrd
	 +XyD+6wcjdQ0yuKyfKJGIbZkW6+mLS8rrFmd5C0idcSnuNIZCtCKNr2la64LbapFJA
	 9gp+wD1wN0yOQ==
Content-Type: multipart/mixed; boundary="===============5634430915835740592=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <034515b18553e09288479d75768b362839532503a5ca15889c035acdcdf41b06@mail.kernel.org>
In-Reply-To: <20260911154924.2005771-1-yonghong.song@linux.dev>
References: <20260911154924.2005771-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 02/15] selftests/bpf: Add a test for an __int128 by-value argument
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 11 Sep 2026 16:47:26 +0000 (UTC)

--===============5634430915835740592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> index f7f94ccebce2..3c7ded537314 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -5,6 +5,7 @@
>  #include "arena_kfunc.skel.h"
>  #include "arena_kfunc_jit.skel.h"
>  #include "cap_helpers.h"
> +#include "verifier_aggregate_arg.skel.h"
>  #include "verifier_aggregate_ret.skel.h"
>  #include "verifier_align.skel.h"
>  #include "verifier_and.skel.h"
> @@ -171,6 +172,7 @@ void test_arena_kfunc(void)                   { RUN_TESTS(arena_kfunc); }
>
>  void test_arena_kfunc_jit(void)               { RUN_TESTS(arena_kfunc_jit); }
>
> +void test_verifier_aggregate_arg(void)        { RUN_TESTS(verifier_aggregate_arg); }
>  void test_verifier_aggregate_ret(void)        { RUN_TESTS(verifier_aggregate_ret); }
>  void test_verifier_align(void)                { RUN(verifier_align); }
>  void test_verifier_and(void)                  { RUN(verifier_and); }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_aggregate_arg.c b/tools/testing/selftests/bpf/progs/verifier_aggregate_arg.c
> new file mode 100644
> index 000000000000..d90f754396d0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_aggregate_arg.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +#define MIX_A	0xdeadbeefcafef00dULL
> +#define MIX_B	0x0123456789abcdefULL
> +
> +#ifdef __SIZEOF_INT128__
> +
> +typedef unsigned __int128 u128;
> +
> +__noinline __u64 take_i128_global(int a, u128 v, int c)
> +{
> +	return (__u64)a + (__u64)(v >> 64) + (__u64)v + c;
> +}
> +
> +SEC("tc")
> +/*
> + * The verifier counts one argument register for the __int128 and marks only
> + * R1 through R3 at the entry of take_i128_global(), while the compiler passed
> + * a in R1, v in R2:R3 and c in R4.
> + */
> +__failure __msg("R4 !read_ok")
> +int aggregate_arg_int128_c_test(struct __sk_buff *skb)
> +{
> +	__u64 a = skb->len ^ MIX_A;
> +	__u64 b = skb->len ^ MIX_B;
> +	u128 v = ((u128)a << 64) | b;
> +
> +	if (take_i128_global(1, v, 2) != a + b + 3)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +#endif /* __SIZEOF_INT128__ */
> +
> +char _license[] SEC("license") = "GPL";

A subsystem pattern flags this as potentially concerning: every program
in the new file is wrapped in '#ifdef __SIZEOF_INT128__' with no '#else'
branch.

When a BPF compiler does not define __SIZEOF_INT128__ (for example, when
building with bpf-gcc via BPF_GCC=1), the generated verifier_aggregate_arg.bpf.o
contains no programs at all. The skeleton still compiles because bpftool
guards maps/progs/links members on their counts, but test_loader__run_subtests()
then iterates zero programs and test_progs.c reports the test as passing with
no indication that the __int128 coverage was compiled out.

Every sibling prog file in progs/ that wraps all of its tests in a feature
#ifdef adds an '#else' dummy carrying __description()/__skip() so the result
is a visible SKIP instead. For instance, verifier_aggregate_ret.c (from the
same series) includes such a dummy at lines 167-175 with the message "needs
LLVM 23, dummy test". The same pattern appears in verifier_gotol.c,
verifier_bswap.c, verifier_ldsx.c, verifier_movsx.c, verifier_sdiv.c,
verifier_private_stack.c, verifier_stack_arg_order.c, verifier_load_acquire.c,
verifier_store_release.c, arena_kfunc.c, stack_arg_precision.c, and
stack_arg_fail.c.

Should this file include an '#else' dummy with __skip() to match the
pattern used by its sibling tests, so that builds without __SIZEOF_INT128__
report SKIP rather than silently passing?

Note: __SIZEOF_INT128__ is defined by every clang for the bpf target, so
the normal CI matrix (clang test_progs, no_alu32, cpuv4) does compile and
run the test. Only the optional bpf-gcc flavor would be affected.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34620351527
--===============5634430915835740592==--
