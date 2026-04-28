Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211D940DFC2
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 00:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777335174; cv=none; b=RYB1c+nWPANdblABqTi7UrIK4fdFGRVDTMQM/2Hpm7M1+3jFaT16Zt2SpwidjyjZ5MVJMf2/G9xnHWzriM0UqjtD0kJNvF/n5uwZpKWvXxHdgZIlE0ALSDYUuohPL7llidZLxqShs484+up90LpLCWVNA/+d5aK4KaKpnwVsI8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777335174; c=relaxed/simple;
	bh=ZTzqeKSs7yt4mjadCpjAaZLuI1Edgw3v4wVrEULsUrI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dj2Ze8hOi7gL+biDNwgqArt1Lxif7D+uX+BrA4qzVHYmb+0dIqwrqvK7mJGul/nqQm1JWIqP886zR/s2bASoqO45JTTkapK1s+vcPaOfnkqzby7VRIjswGv7I+XyEVkrMhuOr0vJ9SOJJFy0otBsGCjuQf6Bou/qDx2u49bfvgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrpD0jIo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrpD0jIo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EDCC19425;
	Tue, 28 Apr 2026 00:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777335174;
	bh=ZTzqeKSs7yt4mjadCpjAaZLuI1Edgw3v4wVrEULsUrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=GrpD0jIodn9ViCazT6t02Oyh7WaDhsQc/G4JjgzoDbJhYEbcd/mAyLOWBN0q+YuLt
	 nNoMCPmsCYthbIUDeEq5w6n7Y4k5iUajqDoDWS1tc/BVLDFRH4eWAPs6mX+Zzosq7r
	 jSn4cEWksE91tW6H7C/Zoxx2finp+y3OB2kCE8paBW+f79y2XUq2djtwiOsTsa4c3Q
	 1mE6asVFHTqMJuvwtfoBUm5xNWozoBg4rOLkYNtgpuHMdr4MxhwkEzBehvQauXb7D9
	 MKDqlvF15CS98xjQfcT2uKs/SDbLGF9VaA2TwQGYwEyZUVu67vT5CcghpcjPb0t1/1
	 mUx0w4IBA6H6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/7] selftests/bpf: Add BPF batch-timing
 library
Reply-To: sashiko@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260427232313.1582588-3-puranjay@kernel.org>
References: <20260427232313.1582588-3-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 00:12:53 +0000
Message-Id: <20260428001253.E5EDCC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Medium] Integer division truncation in `bpf_bench_calibrate()` breaks au=
to-calibration for very fast BPF programs.
- [Medium] Zero warmup time (`-w 0`) causes the benchmark to silently colle=
ct no samples.
- [Medium] BPF `can_loop` (`bpf_may_goto`) can prematurely terminate the ti=
med loop, silently invalidating the userspace `ns/op` calculation.
- [Low] The BPF header includes a non-existent file `<bpf_may_goto.h>`.
--

commit ecbc1ddd2ab895fa706970f55f150bb87ba2790e
Author: Puranjay Mohan <puranjay@kernel.org>

selftests/bpf: Add BPF batch-timing library
   =20
This commit adds a reusable timing library for BPF benchmarks that need to
measure BPF program execution time. It provides a BPF macro to record elaps=
ed
time and a userspace library to auto-calibrate batch iterations and compute
statistics.

> diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_timing.c b/tool=
s/testing/selftests/bpf/benchs/bench_bpf_timing.c
> new file mode 100644
> index 000000000000..75a39da69655
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/bench_bpf_timing.c
[ ... ]
> +static int collect_samples(struct bpf_bench_timing *t,
> +			   double *out, int max_out)
> +{
> +	unsigned int nr_cpus =3D bpf_num_possible_cpus();
> +	__u32 timed_iters =3D t->batch_iters;
> +	int total =3D 0;
[ ... ]
> +		for (__u32 i =3D 0; i < count && total < max_out; i++) {
> +			__u64 sample =3D t->samples[cpu][i];
> +
> +			if (sample =3D=3D 0)
> +				continue;
> +			out[total++] =3D (double)sample / timed_iters;

If the loop in BENCH_BPF_LOOP is terminated early by the can_loop condition
(e.g., due to instruction limits or yielding), the actual number of complet=
ed
iterations will be less than timed_iters.

Since the BPF program only records the elapsed time, will dividing by
timed_iters produce artificially low ns/op calculations?

Should the BPF program explicitly record and export the actual number of
completed iterations for this calculation?

> +		}
> +	}
> +
> +	qsort(out, total, sizeof(double), cmp_double);
> +	return total;
> +}
[ ... ]
> +void bpf_bench_timing_measure(struct bpf_bench_timing *t, struct bench_r=
es *res)
> +{
> +	unsigned int nr_cpus;
> +	__u32 total_samples;
> +	int i;
> +
> +	t->warmup_ticks++;
> +
> +	if (t->warmup_ticks < env.warmup_sec)
> +		return;
> +
> +	if (t->warmup_ticks =3D=3D env.warmup_sec) {
> +		*t->timing_enabled =3D 1;
> +		return;
> +	}

If the benchmark is run with zero warmup (env.warmup_sec =3D=3D 0),
t->warmup_ticks becomes 1 on the first tick.

Does this mean t->warmup_ticks =3D=3D env.warmup_sec will never be true, by=
passing
the assignment and preventing timing_enabled from ever being set to 1?

[ ... ]
> +void bpf_bench_calibrate(struct bpf_bench_timing *t, bpf_bench_run_fn ru=
n_fn, void *run_ctx)
> +{
> +	__u64 elapsed, per_op_ns;
> +	__u64 time_n, time_2n;
> +	double ratio;
> +
> +	elapsed =3D measure_elapsed(t, run_fn, run_ctx, CALIBRATE_SEED_BATCH, C=
ALIBRATE_RUNS);
> +	if (elapsed =3D=3D 0) {
> +		fprintf(stderr, "calibration: no timing samples, using default\n");
> +		t->batch_iters =3D 10000;
> +		*t->batch_iters_bss =3D t->batch_iters;
> +		reset_timing(t);
> +		return;
> +	}
> +
> +	per_op_ns =3D elapsed / CALIBRATE_SEED_BATCH;

If the BPF operation executes in less than 1 ns (e.g., an empty loop or
bpf-nop), elapsed could be less than 100 since CALIBRATE_SEED_BATCH is 100.

Will the integer division truncate per_op_ns to 0 here, causing
compute_batch_iters() to incorrectly fall back to CALIBRATE_MIN_BATCH inste=
ad
of scaling up the iterations?

> +	t->batch_iters =3D compute_batch_iters(per_op_ns);
[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/bench_bpf_timing.bpf.h b/t=
ools/testing/selftests/bpf/progs/bench_bpf_timing.bpf.h
> new file mode 100644
> index 000000000000..6a1ad75f1fd7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bench_bpf_timing.bpf.h
> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#ifndef __BENCH_BPF_TIMING_BPF_H__
> +#define __BENCH_BPF_TIMING_BPF_H__
> +
> +#include <stdbool.h>
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf_may_goto.h>

Does bpf_may_goto.h exist in the kernel source tree?

I noticed that can_loop is typically defined in bpf_experimental.h. Will
including this cause a No such file or directory build error?

> +
> +#ifndef BENCH_NR_SAMPLES

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260427232313.1582=
588-1-puranjay@kernel.org?part=3D2
