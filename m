Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572203A75A7
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691094; cv=none; b=dlUAt5DDUomgxoXkoN6jYfffV9qugxrVpfuwUMJXNVm1yfmJSCHkNtuvU/T07wn+g8RIXKH346OH3F0PNaZcfYAGkVR8MBhT8FGPfpqPJD4P7tQNd5NLT/wQv3D1ZPy0ZKkcVGKetjNGkMudwJMkiQsmBqr0zeM+xDpwADnd/i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691094; c=relaxed/simple;
	bh=md4FjVSLV+aJ6Y1MmYtZs3XlkoHVCPdmFdBNzbOU0Ts=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iNCFYiNAbO4lYdaz6VFXcYF/2rgEZRM/BuPE7Uocy3JNlpmRxef0RqOHexFO/+bFLii1Q5IcjTbl9KK+PbwDrkdeIchNIOBnykKZye4N9LDNv08WwKQZsM1dYIgcAXctEA13+lXJcj7omXat8qWsFjMfRwWW1ReHe5Nrp5fH1nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FW15U+mN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FW15U+mN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2E1C2BCB4;
	Mon, 20 Apr 2026 13:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691094;
	bh=md4FjVSLV+aJ6Y1MmYtZs3XlkoHVCPdmFdBNzbOU0Ts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=FW15U+mNgOopZb2po5ySDZuEH1cONOL4Z59D8DgMDpIpQpmrIYyifzVIcrvIF3BR5
	 4TDB2HhLnOMtURmXEe9YwhTHZEOy0bBbZPxT8SjXCUk9UXrQ8c8byeeyEJbmKKfi2J
	 icQsSvfjWyhSdz0TouT1LEB6yuNDSWzZXAsLvjUj0hsnIZft9a7yQx9Z7xfarKXe+U
	 CZX2AUJGs0y/TOT6hrSYUBYUZxZUUd+JgUdHr9KQRET+wa7iitLZwe1yZCWMz55dzJ
	 uXzOiXSlUOeodPYrKH7Ev5cUQj4bxAY9mNdOZahDM93NZRX0sDpjS5n6t+oLMlBKJ8
	 sFOJk+xvrQLNg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 2/6] selftests/bpf: Add BPF batch-timing
 library
Reply-To: sashiko@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420111726.2118636-3-puranjay@kernel.org>
References: <20260420111726.2118636-3-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 13:18:13 +0000
Message-Id: <20260420131814.1E2E1C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 6 potential issue(s):
- [Medium] The BPF timing macros rely on undeclared kfuncs `bpf_get_cpu_tim=
e_counter()` and `bpf_cpu_time_counter_to_ns()` which do not exist in the k=
ernel.
- [Medium] Integer division truncation in `compute_batch_iters` completely =
breaks calibration for fast operations (< 1 ns/op).
- [Medium] The `BENCH_BPF_LOOP` macro leaks state across BPF program execut=
ions by omitting the `reset` step on the final untimed iteration.
- [Medium] The `machine_readable` field in `struct bpf_bench_timing` is lef=
t uninitialized by the `BENCH_TIMING_INIT` macro.
- [Medium] The BPF program updates the per-CPU `timing_idx` array using a n=
on-atomic read-modify-write pattern, causing TOCTOU races.
- [Medium] Userspace lacks memory barriers when toggling `timing_enabled` a=
nd clearing the BSS arrays, allowing store reordering on weakly-ordered arc=
hitectures.
--

commit 09663b9e30e128fd77353ff1616f5777a20d0dbc
Author: Puranjay Mohan <puranjay@kernel.org>

selftests/bpf: Add BPF batch-timing library

This commit adds a reusable timing library for BPF benchmarks to allow prec=
ise
per-operation measurements inside BPF programs.

> diff --git a/tools/testing/selftests/bpf/bench_bpf_timing.h b/tools/testi=
ng/selftests/bpf/bench_bpf_timing.h
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bench_bpf_timing.h

[ ... ]

> +#define BENCH_TIMING_INIT(t, skel, iters) do {				\
> +	(t)->samples =3D (skel)->bss->timing_samples;			\
> +	(t)->idx =3D (skel)->bss->timing_idx;				\
> +	(t)->timing_enabled =3D &(skel)->bss->timing_enabled;		\
> +	(t)->batch_iters_bss =3D &(skel)->bss->batch_iters;		\
> +	(t)->batch_iters =3D (iters);					\
> +	(t)->target_samples =3D 200;					\
> +	(t)->nr_cpus =3D env.nr_cpus;					\
> +	(t)->warmup_ticks =3D 0;						\
> +	(t)->done =3D false;						\
> +} while (0)

Is there a reason machine_readable is omitted from this initialization? If
the struct is allocated on the stack by a benchmark driver, could this resu=
lt
in unpredictable output formatting due to reading uninitialized memory?

> diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_timing.c b/tool=
s/testing/selftests/bpf/benchs/bench_bpf_timing.c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/bench_bpf_timing.c

[ ... ]

> +static void reset_timing(struct bpf_bench_timing *t)
> +{
> +	*t->timing_enabled =3D 0;
> +	memset(t->samples, 0,
> +	       sizeof(__u64) * BENCH_NR_CPUS * BENCH_NR_SAMPLES);
> +	memset(t->idx, 0, sizeof(__u32) * BENCH_NR_CPUS);
> +}

Does this need CPU memory barriers to prevent hardware reordering? While
timing_enabled is volatile, weakly-ordered architectures like arm64 might
reorder the memory stores across the flag toggle. This could allow backgrou=
nd
BPF executions to write samples while the arrays are being zeroed.

[ ... ]

> +void bpf_bench_calibrate(struct bpf_bench_timing *t,
> +			 bpf_bench_run_fn run_fn, void *run_ctx)
> +{
> +	__u64 elapsed, per_op_ns;
> +	__u64 time_n, time_2n;
> +	double ratio;
> +
> +	elapsed =3D measure_elapsed(t, run_fn, run_ctx, CALIBRATE_SEED_BATCH, C=
ALIBRATE_RUNS);

[ ... ]

> +	per_op_ns =3D elapsed / CALIBRATE_SEED_BATCH;
> +	t->batch_iters =3D compute_batch_iters(per_op_ns);

Will this truncation break calibration for operations taking less than 1 ns?
If the total elapsed time for 100 iterations is under 100 ns, per_op_ns
evaluates to 0.

This would force compute_batch_iters() to return CALIBRATE_MIN_BATCH (100)
instead of scaling up to reach the 10 ms target.

> diff --git a/tools/testing/selftests/bpf/progs/bench_bpf_timing.bpf.h b/t=
ools/testing/selftests/bpf/progs/bench_bpf_timing.bpf.h
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bench_bpf_timing.bpf.h

[ ... ]

> +extern __u64 bpf_get_cpu_time_counter(void) __weak __ksym;
> +extern __u64 bpf_cpu_time_counter_to_ns(__u64 counter) __weak __ksym;

Do these kfuncs exist in the kernel source? It does not appear they are
introduced in this patch series.

If they are missing, won't libbpf resolve them to 0, causing the verifier to
reject the program or causing executions to record 0 elapsed time?

[ ... ]

> +static __always_inline void bench_record_sample(__u64 elapsed_ns)
> +{
> +	__u32 cpu, idx;
> +
> +	if (!timing_enabled)
> +		return;
> +
> +	cpu =3D bpf_get_smp_processor_id() & BENCH_CPU_MASK;
> +	idx =3D timing_idx[cpu];
> +
> +	if (idx >=3D BENCH_NR_SAMPLES)
> +		return;
> +
> +	timing_samples[cpu][idx] =3D elapsed_ns;
> +	timing_idx[cpu] =3D idx + 1;
> +}

Can this read-modify-write pattern cause lost samples or out-of-bounds writ=
es?
If machines have more than 256 logical CPUs, BENCH_CPU_MASK will alias
multiple CPUs to the same index.

Concurrent thread executions could race and overwrite the index, potentially
corrupting the timing statistics.

[ ... ]

> +/*
> + * @body:  expression to time; return value (int) stored in __bench_resu=
lt.
> + * @reset: undo body's side-effects so each iteration starts identically.
> + *         May reference __bench_result.  Use ({}) for empty reset.
> + *
> + * Runs batch_iters timed iterations, then one untimed iteration whose
> + * return value the macro evaluates to (for validation).
> + */
> +#define BENCH_BPF_LOOP(body, reset) ({					\
> +	__u64 __bench_start =3D bpf_get_cpu_time_counter();		\
> +	int __bench_result;						\
> +									\
> +	bpf_repeat(batch_iters) {					\
> +		__bench_result =3D (body);				\
> +		reset;							\
> +	}								\
> +									\
> +	bench_record_sample(bpf_cpu_time_counter_to_ns(			\
> +		bpf_get_cpu_time_counter() - __bench_start));		\
> +									\
> +	__bench_result =3D (body);					\
> +	__bench_result;							\
> +})

Should the final untimed iteration also evaluate the reset expression?

Without calling reset here, any side effects from the last body execution
(like memory allocations or map modifications) will leak into the next
program invocation and could violate benchmark isolation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420111726.2118=
636-1-puranjay@kernel.org?part=3D2
