Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757731F4C8E
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 00:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777335501; cv=none; b=ZXNw5lWHhIcMd4HPwjZ1c0Gt10GFFWEWajw6n8DtMbsZpbfeGvGj7sVmedQpfJk9GqbOBBgvaPsRqGtobEI0HMN20hku4kMnWiypps4ATCd9p8up+MtnoC3+TCBkuIxx6Ngo801fJ4Z0apD7fcIot/xJpBscJHoJdzyjPiobSYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777335501; c=relaxed/simple;
	bh=y9B/EoWrBxVr76bInglsqFDPTUbGOGxFHJ1XeISC+Ng=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bv1t9JT/EYhXmmtsIcwhgOf6leI2sTXQPF0pVXsREnjS5421rA2gjAYpUNo7QZGt/FLx2dz0OJuwe2m/gIirZ0IEreboA32/2jiya8p3nxvlXffkzljjZzc4mUAvlPPDs+gMsXzu1j/Bfk6n6EH4LnIRd4GujXgWwyXcHMQ6bVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoJvtNZf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoJvtNZf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B03C2BCB4;
	Tue, 28 Apr 2026 00:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777335501;
	bh=y9B/EoWrBxVr76bInglsqFDPTUbGOGxFHJ1XeISC+Ng=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=FoJvtNZfe0ERzGunpjx+fyxCECtCY286Sona0Lv8sTDoQLamajO21BQHEgo7qaJ5m
	 ZI7juvL80PjUBxTbX12UZSXhwtxoVNK3I2Ad7bFlsZSU/JtCja4cks+Na127N44NUh
	 PueHt6ewPhxJVajdZNgySNQpviF5bieDwWkfCGkBmgF2YmQNjDtrpf1QLwbCzbDdvI
	 /ymyByTynY/KHkppVBMvLV6OWZI7Qm0O9xbYMr6e0+CUr6noinMxyOEuLP1qvGLGiR
	 GOJAMzHGgKE1M4+PcKSIX4YyHiQywl54+4IB+9LKVWN69Dc1OrYb3oD8jj5ZEvTPxz
	 WcbY76/cBlNNg==
Content-Type: multipart/mixed; boundary="===============2091440985953466340=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <825349ab37b5f386b036f5c59476cd61c173f6fcd7632542c57fac1f1facdb9c@mail.kernel.org>
In-Reply-To: <20260427232313.1582588-3-puranjay@kernel.org>
References: <20260427232313.1582588-3-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next 2/7] selftests/bpf: Add BPF batch-timing library
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,mykyta.yatsenko5@gmail.com,feichen@meta.com,taragrawal@meta.com,ndixit@meta.com,tehnerd@tehnerd.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 28 Apr 2026 00:18:20 +0000 (UTC)

--===============2091440985953466340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_timing.c b/tools/testing/selftests/bpf/benchs/bench_bpf_timing.c
> new file mode 100644
> index 000000000000..75a39da69655
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/bench_bpf_timing.c

[ ... ]

> +static __u32 compute_batch_iters(__u64 per_op_ns)
> +{
> +	__u64 target_ns = (__u64)CALIBRATE_TARGET_MS * 1000000ULL;
> +	__u32 iters;
> +
> +	if (per_op_ns == 0)
> +		return CALIBRATE_MIN_BATCH;
> +
> +	iters = target_ns / per_op_ns;
> +
> +	if (iters < CALIBRATE_MIN_BATCH)
> +		iters = CALIBRATE_MIN_BATCH;
> +	if (iters > CALIBRATE_MAX_BATCH)
> +		iters = CALIBRATE_MAX_BATCH;
> +
> +	return iters;
> +}
> +
> +void bpf_bench_calibrate(struct bpf_bench_timing *t, bpf_bench_run_fn run_fn, void *run_ctx)
> +{
> +	__u64 elapsed, per_op_ns;
> +	__u64 time_n, time_2n;
> +	double ratio;
> +
> +	elapsed = measure_elapsed(t, run_fn, run_ctx, CALIBRATE_SEED_BATCH, CALIBRATE_RUNS);
> +	if (elapsed == 0) {
> +		fprintf(stderr, "calibration: no timing samples, using default\n");
> +		t->batch_iters = 10000;
> +		*t->batch_iters_bss = t->batch_iters;
> +		reset_timing(t);
> +		return;
> +	}
> +
> +	per_op_ns = elapsed / CALIBRATE_SEED_BATCH;
> +	t->batch_iters = compute_batch_iters(per_op_ns);

Will this integer division truncation break calibration for operations
taking less than 1 ns? If the total elapsed time for 100 iterations is under
100 ns, per_op_ns evaluates to 0, forcing compute_batch_iters() to return
CALIBRATE_MIN_BATCH (100) instead of scaling up to reach the 10 ms target.

> +
> +	time_n = measure_elapsed(t, run_fn, run_ctx, t->batch_iters, CALIBRATE_RUNS);
> +	time_2n = measure_elapsed(t, run_fn, run_ctx, t->batch_iters * 2, CALIBRATE_RUNS);

[ ... ]

> +static void reset_timing(struct bpf_bench_timing *t)
> +{
> +	*t->timing_enabled = 0;
> +	memset(t->samples, 0, sizeof(__u64) * BENCH_NR_CPUS * BENCH_NR_SAMPLES);
> +	memset(t->idx, 0, sizeof(__u32) * BENCH_NR_CPUS);
> +}

Does this need CPU memory barriers to prevent hardware reordering?
While timing_enabled is volatile, weakly-ordered architectures like arm64 might
reorder the memory stores across the flag toggle. This could allow background
BPF executions to write samples while the arrays are being zeroed.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/bench_bpf_timing.bpf.h b/tools/testing/selftests/bpf/progs/bench_bpf_timing.bpf.h
> new file mode 100644
> index 000000000000..6a1ad75f1fd7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bench_bpf_timing.bpf.h

[ ... ]

> +static __always_inline void bench_record_sample(__u64 elapsed_ns)
> +{
> +	__u32 cpu, idx;
> +
> +	if (!timing_enabled)
> +		return;
> +
> +	cpu = bpf_get_smp_processor_id() & BENCH_CPU_MASK;
> +	idx = timing_idx[cpu];
> +
> +	if (idx >= BENCH_NR_SAMPLES)
> +		return;
> +
> +	timing_samples[cpu][idx] = elapsed_ns;
> +	timing_idx[cpu] = idx + 1;
> +}

Can this read-modify-write pattern cause lost samples or out-of-bounds
writes? If machines have more than 256 logical CPUs, BENCH_CPU_MASK will alias
multiple CPUs to the same index. Concurrent thread executions could race and
overwrite the index, potentially corrupting the timing statistics.

> +
> +/*
> + * @body:  expression to time; return value (int) stored in __bench_result.
> + * @reset: undo body's side-effects so each iteration starts identically.
> + *         May reference __bench_result.  Use ({}) for empty reset.
> + *
> + * Runs batch_iters timed iterations, then one untimed iteration whose
> + * return value the macro evaluates to (for validation).
> + */
> +#define BENCH_BPF_LOOP(body, reset) ({					\
> +	__u64 __bench_start = bpf_ktime_get_ns();			\
> +	__u32 __bench_i;						\
> +	int __bench_result;						\
> +									\
> +	for (__bench_i = 0;						\
> +	     __bench_i < batch_iters && can_loop;			\
> +	     __bench_i++) {						\
> +		__bench_result = (body);				\
> +		reset;							\
> +	}								\
> +									\
> +	bench_record_sample(bpf_ktime_get_ns() - __bench_start);	\
> +									\
> +	__bench_result = (body);					\
> +	__bench_result;							\
> +})

Should the final untimed iteration also evaluate the reset expression?
Without calling reset here, any side effects from the last body execution (like
memory allocations or map modifications) will leak into the next program
invocation and could violate benchmark isolation.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25025533577
--===============2091440985953466340==--
