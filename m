Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F45281503
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776683884; cv=none; b=utjAj5pvVE10tojh8l+jmR5O0kqYw1POOde8l1EKTEbnaHwX+xe/Hv9oAVQq6by2vaNtAF2QGvlG1TUOohEPtwxe1UF8Iku4FwgmPaAnO2HnvS2MMCor4cfMvHUeE8UwrZ8VcNsrYY6H+E8Nd57ud9JejRsosEdeXtNqEgTKxUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776683884; c=relaxed/simple;
	bh=gC+dzM+TtiqDiJW8pA3mDdSF5c3Qb9PyQtWY+2qXQJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPyuI6LJM/3Ad3eNDW8V3VXIBn4LZ+Q5QC0O/Rh845zXJjGoZW+Vlgx+LgwEF4e+98rBmhyA+lwrRaDX2bcxByjUnnH2KIRRg04kn963djQqoZAD0nIsSKJ23+1clFf4HneE8MHtlZd6VscMCE2cEEBQVDwGrUgO4IoF2Cs0ntE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUL9MAMH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUL9MAMH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0E6C19425;
	Mon, 20 Apr 2026 11:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776683883;
	bh=gC+dzM+TtiqDiJW8pA3mDdSF5c3Qb9PyQtWY+2qXQJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RUL9MAMHCR+/uqlqVglVxytxL3wpg2rFTI8qk0oXxAwCQwTGQqgnv83aOZ69+9PFK
	 tqeP9PFxCZhG5Nsz9xWKwjNkRyRdHHl/XAn27TUMgGS0KWaDbF+rwpmLZB7Bcu9wvE
	 h3jL9Jlp1l6fMZqBPOOeHNWvVCghrtU8zwxkuzcwFabuE9BQCy2/nuzxbCzENAKktU
	 Y2v2hChd+xl69EH2yDs+8+f8oCd9aPuxZjVq5uttxHOuJjCKuRN1UVJZ/YZ5y7IyLJ
	 qA1WT5YCB04+Yy03L108d9hGEoGwWYTE0uXK/g75dp0wktKu5wDayu5BUHMVbgS98j
	 4poXK/yjqdaYA==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Fei Chen <feichen@meta.com>,
	Taruna Agrawal <taragrawal@meta.com>,
	Nikhil Dixit Limaye <ndixit@meta.com>,
	"Nikita V. Shirokov" <tehnerd@tehnerd.com>,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next 2/6] selftests/bpf: Add BPF batch-timing library
Date: Mon, 20 Apr 2026 04:17:02 -0700
Message-ID: <20260420111726.2118636-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260420111726.2118636-1-puranjay@kernel.org>
References: <20260420111726.2118636-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a reusable timing library for BPF benchmarks that need precise
per-operation measurements inside the BPF program.

The BPF side (progs/bench_bpf_timing.bpf.h) provides per-CPU sample
arrays and BENCH_BPF_LOOP(), a macro that brackets batch_iters
iterations with bpf_get_cpu_time_counter() reads and records the
elapsed time.  One extra untimed iteration runs afterward for output
validation.

The userspace side (benchs/bench_bpf_timing.c) collects samples from
the skeleton BSS, computes percentile statistics with a histogram,
and flags right-skewed distributions.  bpf_bench_calibrate() picks a
batch_iters value targeting ~10 ms per batch and sanity-checks it with
a proportionality test (2N iters should take ~2x as long as N).

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |   2 +
 .../testing/selftests/bpf/bench_bpf_timing.h  |  49 +++
 .../selftests/bpf/benchs/bench_bpf_timing.c   | 415 ++++++++++++++++++
 .../bpf/progs/bench_bpf_timing.bpf.h          |  68 +++
 4 files changed, 534 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/bench_bpf_timing.h
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_timing.c
 create mode 100644 tools/testing/selftests/bpf/progs/bench_bpf_timing.bpf.h

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 6ef6872adbc3..20244b78677f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -866,6 +866,7 @@ $(OUTPUT)/bench_htab_mem.o: $(OUTPUT)/htab_mem_bench.skel.h
 $(OUTPUT)/bench_bpf_crypto.o: $(OUTPUT)/crypto_bench.skel.h
 $(OUTPUT)/bench_sockmap.o: $(OUTPUT)/bench_sockmap_prog.skel.h
 $(OUTPUT)/bench_lpm_trie_map.o: $(OUTPUT)/lpm_trie_bench.skel.h $(OUTPUT)/lpm_trie_map.skel.h
+$(OUTPUT)/bench_bpf_timing.o: bench_bpf_timing.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS += -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o \
@@ -888,6 +889,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_bpf_crypto.o \
 		 $(OUTPUT)/bench_sockmap.o \
 		 $(OUTPUT)/bench_lpm_trie_map.o \
+		 $(OUTPUT)/bench_bpf_timing.o \
 		 $(OUTPUT)/usdt_1.o \
 		 $(OUTPUT)/usdt_2.o \
 		 #
diff --git a/tools/testing/selftests/bpf/bench_bpf_timing.h b/tools/testing/selftests/bpf/bench_bpf_timing.h
new file mode 100644
index 000000000000..9accfd6841a7
--- /dev/null
+++ b/tools/testing/selftests/bpf/bench_bpf_timing.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#ifndef __BENCH_BPF_TIMING_H__
+#define __BENCH_BPF_TIMING_H__
+
+#include <stdbool.h>
+#include <linux/types.h>
+#include "bench.h"
+
+#ifndef BENCH_NR_SAMPLES
+#define BENCH_NR_SAMPLES	4096
+#endif
+#ifndef BENCH_NR_CPUS
+#define BENCH_NR_CPUS		256
+#endif
+
+typedef void (*bpf_bench_run_fn)(void *ctx);
+
+struct bpf_bench_timing {
+	__u64 (*samples)[BENCH_NR_SAMPLES];	/* skel->bss->timing_samples */
+	__u32 *idx;				/* skel->bss->timing_idx */
+	volatile __u32 *timing_enabled;		/* &skel->bss->timing_enabled */
+	volatile __u32 *batch_iters_bss;	/* &skel->bss->batch_iters */
+	__u32 batch_iters;
+	__u32 target_samples;
+	__u32 nr_cpus;
+	int warmup_ticks;
+	bool done;
+	bool machine_readable;
+};
+
+#define BENCH_TIMING_INIT(t, skel, iters) do {				\
+	(t)->samples = (skel)->bss->timing_samples;			\
+	(t)->idx = (skel)->bss->timing_idx;				\
+	(t)->timing_enabled = &(skel)->bss->timing_enabled;		\
+	(t)->batch_iters_bss = &(skel)->bss->batch_iters;		\
+	(t)->batch_iters = (iters);					\
+	(t)->target_samples = 200;					\
+	(t)->nr_cpus = env.nr_cpus;					\
+	(t)->warmup_ticks = 0;						\
+	(t)->done = false;						\
+} while (0)
+
+void bpf_bench_timing_measure(struct bpf_bench_timing *t, struct bench_res *res);
+void bpf_bench_timing_report(struct bpf_bench_timing *t, const char *name, const char *desc);
+void bpf_bench_calibrate(struct bpf_bench_timing *t, bpf_bench_run_fn run_fn, void *ctx);
+
+#endif /* __BENCH_BPF_TIMING_H__ */
diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_timing.c b/tools/testing/selftests/bpf/benchs/bench_bpf_timing.c
new file mode 100644
index 000000000000..13440b4c30a6
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_bpf_timing.c
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <math.h>
+#include "bench_bpf_timing.h"
+#include "bpf_util.h"
+
+#define HIST_BAR_WIDTH	40
+
+struct timing_stats {
+	double min, max;
+	double p1, p5, p25, median, p75, p90, p95, p99;
+	double mean, stddev;
+	int count;
+};
+
+static int cmp_double(const void *a, const void *b)
+{
+	double da = *(const double *)a;
+	double db = *(const double *)b;
+
+	if (da < db)
+		return -1;
+	if (da > db)
+		return 1;
+	return 0;
+}
+
+static double percentile(const double *sorted, int n, double pct)
+{
+	int idx = (int)(n * pct / 100.0);
+
+	if (idx >= n)
+		idx = n - 1;
+	return sorted[idx];
+}
+
+static int collect_samples(struct bpf_bench_timing *t,
+			   double *out, int max_out)
+{
+	unsigned int nr_cpus = bpf_num_possible_cpus();
+	__u32 timed_iters = t->batch_iters;
+	int total = 0;
+
+	if (nr_cpus > BENCH_NR_CPUS)
+		nr_cpus = BENCH_NR_CPUS;
+
+	for (unsigned int cpu = 0; cpu < nr_cpus; cpu++) {
+		__u32 count = t->idx[cpu];
+
+		if (count > BENCH_NR_SAMPLES)
+			count = BENCH_NR_SAMPLES;
+
+		for (__u32 i = 0; i < count && total < max_out; i++) {
+			__u64 sample = t->samples[cpu][i];
+
+			if (sample == 0)
+				continue;
+			out[total++] = (double)sample / timed_iters;
+		}
+	}
+
+	qsort(out, total, sizeof(double), cmp_double);
+	return total;
+}
+
+static void compute_stats(const double *sorted, int n,
+			  struct timing_stats *s)
+{
+	double sum = 0, var_sum = 0;
+
+	memset(s, 0, sizeof(*s));
+	s->count = n;
+
+	if (n == 0)
+		return;
+
+	s->min    = sorted[0];
+	s->max    = sorted[n - 1];
+	s->p1     = percentile(sorted, n, 1);
+	s->p5     = percentile(sorted, n, 5);
+	s->p25    = percentile(sorted, n, 25);
+	s->median = sorted[n / 2];
+	s->p75    = percentile(sorted, n, 75);
+	s->p90    = percentile(sorted, n, 90);
+	s->p95    = percentile(sorted, n, 95);
+	s->p99    = percentile(sorted, n, 99);
+
+	for (int i = 0; i < n; i++)
+		sum += sorted[i];
+	s->mean = sum / n;
+
+	for (int i = 0; i < n; i++) {
+		double d = sorted[i] - s->mean;
+
+		var_sum += d * d;
+	}
+	s->stddev = n > 1 ? sqrt(var_sum / (n - 1)) : 0;
+}
+
+/* Fixed bin width avoids sub-ns bins that make tight distributions look spread. */
+static double select_bin_width(double range)
+{
+	if (range < 20)
+		return 1;
+	if (range < 100)
+		return 5;
+	if (range < 500)
+		return 10;
+	if (range < 2000)
+		return 50;
+	return 100;
+}
+
+static void print_histogram(const double *sorted, int n,
+			    const struct timing_stats *s)
+{
+	double range = s->p99 - s->p1;
+	double bin_w = select_bin_width(range);
+	double lo = floor(s->p1 / bin_w) * bin_w;
+	double hi = ceil(s->p99 / bin_w) * bin_w;
+	int nr_bins, prec;
+	__u64 below = 0, above = 0, max_bin = 0;
+	__u64 *bins;
+	int i, j, bar;
+
+	if (hi <= lo)
+		hi = lo + bin_w;
+
+	nr_bins = (int)((hi - lo) / bin_w);
+	if (nr_bins < 1)
+		nr_bins = 1;
+	if (nr_bins > 100)
+		nr_bins = 100;
+
+	bins = calloc(nr_bins, sizeof(*bins));
+	if (!bins)
+		return;
+
+	for (i = 0; i < n; i++) {
+		if (sorted[i] < lo) {
+			below++;
+		} else if (sorted[i] >= hi) {
+			above++;
+		} else {
+			int b = (int)((sorted[i] - lo) / bin_w);
+
+			if (b >= nr_bins)
+				b = nr_bins - 1;
+			bins[b]++;
+			if (bins[b] > max_bin)
+				max_bin = bins[b];
+		}
+	}
+
+	prec = bin_w >= 1.0 ? 0 : (bin_w >= 0.1 ? 1 : 2);
+
+	printf("\n  Distribution (ns/op):\n");
+
+	if (below > 0)
+		printf("  %8s : %-8llu  (below range)\n", "<p1",
+		       (unsigned long long)below);
+
+	for (i = 0; i < nr_bins; i++) {
+		double edge = lo + i * bin_w;
+
+		bar = max_bin > 0
+			? (int)(bins[i] * HIST_BAR_WIDTH / max_bin)
+			: 0;
+
+		printf("  %8.*f : %-8llu  |", prec, edge,
+		       (unsigned long long)bins[i]);
+		for (j = 0; j < HIST_BAR_WIDTH; j++)
+			putchar(j < bar ? '*' : ' ');
+		printf("|\n");
+	}
+
+	if (above > 0)
+		printf("  %8s : %-8llu  (above range)\n", ">p99",
+		       (unsigned long long)above);
+
+	free(bins);
+}
+
+void bpf_bench_timing_measure(struct bpf_bench_timing *t,
+			      struct bench_res *res)
+{
+	unsigned int nr_cpus;
+	__u32 total_samples;
+	int i;
+
+	t->warmup_ticks++;
+
+	if (t->warmup_ticks < env.warmup_sec)
+		return;
+
+	if (t->warmup_ticks == env.warmup_sec) {
+		*t->timing_enabled = 1;
+		return;
+	}
+
+	nr_cpus = bpf_num_possible_cpus();
+	if (nr_cpus > BENCH_NR_CPUS)
+		nr_cpus = BENCH_NR_CPUS;
+
+	total_samples = 0;
+	for (i = 0; i < (int)nr_cpus; i++) {
+		__u32 cnt = t->idx[i];
+
+		if (cnt > BENCH_NR_SAMPLES)
+			cnt = BENCH_NR_SAMPLES;
+		total_samples += cnt;
+	}
+
+	if (total_samples >= (__u32)env.producer_cnt * t->target_samples &&
+	    !t->done) {
+		t->done = true;
+		*t->timing_enabled = 0;
+		bench_force_done();
+	}
+}
+
+void bpf_bench_timing_report(struct bpf_bench_timing *t,
+			     const char *name, const char *description)
+{
+	__u32 timed_iters = t->batch_iters;
+	int max_out = BENCH_NR_CPUS * BENCH_NR_SAMPLES;
+	struct timing_stats s;
+	double *all;
+	int total, prec;
+
+	all = calloc(max_out, sizeof(*all));
+	if (!all) {
+		fprintf(stderr, "failed to allocate timing buffer\n");
+		return;
+	}
+
+	total = collect_samples(t, all, max_out);
+
+	if (total == 0) {
+		printf("\nNo in-BPF timing samples collected.\n");
+		free(all);
+		return;
+	}
+
+	compute_stats(all, total, &s);
+
+	if (t->machine_readable) {
+		printf("RESULT scenario=%s samples=%d median=%.2f stddev=%.2f"
+		       " cv=%.2f min=%.2f p90=%.2f p95=%.2f p99=%.2f max=%.2f\n",
+		       name, total, s.median, s.stddev,
+		       s.mean > 0 ? s.stddev / s.mean * 100.0 : 0.0,
+		       s.min, s.p90, s.p95, s.p99, s.max);
+		free(all);
+		return;
+	}
+
+	if (s.p99 - s.p1 >= 10.0)
+		prec = 1;
+	else if (s.p99 - s.p1 >= 1.0)
+		prec = 2;
+	else
+		prec = 3;
+
+	printf("\nScenario: %s", name);
+	if (description)
+		printf(" - %s", description);
+	printf("\n");
+	printf("Batch size: %u iterations/invocation (+1 for validation)\n",
+	       t->batch_iters);
+	printf("\nIn-BPF timing: %d samples, %u ops/batch\n",
+	       total, timed_iters);
+	printf("  median %.*f ns/op, stddev %.*f, CV %.2f%% [min %.*f, max %.*f]\n",
+	       prec, s.median, prec, s.stddev,
+	       s.mean > 0 ? s.stddev / s.mean * 100.0 : 0.0,
+	       prec, s.min, prec, s.max);
+	printf("  p50 %.*f, p75 %.*f, p90 %.*f, p95 %.*f, p99 %.*f\n",
+	       prec, s.median, prec, s.p75, prec, s.p90, prec, s.p95,
+	       prec, s.p99);
+
+	if (total < 200)
+		printf("  WARNING: only %d samples - tail percentiles may be unreliable\n",
+		       total);
+
+	if (s.median > s.p1 &&
+	    (s.p99 - s.p1) > 2.0 &&
+	    (s.p99 - s.median) > 3.0 * (s.median - s.p1))
+		printf("  NOTE: right-skewed distribution (tail %.1fx the body)\n",
+		       (s.p99 - s.median) / (s.median - s.p1));
+
+	print_histogram(all, total, &s);
+
+	free(all);
+}
+
+#define CALIBRATE_SEED_BATCH	100
+#define CALIBRATE_MIN_BATCH	100
+#define CALIBRATE_MAX_BATCH	10000000
+#define CALIBRATE_TARGET_MS	10
+#define CALIBRATE_RUNS		5
+#define PROPORTIONALITY_TOL	0.05	/* 5% */
+
+static void reset_timing(struct bpf_bench_timing *t)
+{
+	*t->timing_enabled = 0;
+	memset(t->samples, 0,
+	       sizeof(__u64) * BENCH_NR_CPUS * BENCH_NR_SAMPLES);
+	memset(t->idx, 0, sizeof(__u32) * BENCH_NR_CPUS);
+}
+
+static __u64 measure_elapsed(struct bpf_bench_timing *t,
+			     bpf_bench_run_fn run_fn, void *run_ctx,
+			     __u32 iters, int runs)
+{
+	__u64 buf[CALIBRATE_RUNS];
+	int n = 0, i, j;
+
+	reset_timing(t);
+	*t->batch_iters_bss = iters;
+	*t->timing_enabled = 1;
+
+	for (i = 0; i < runs; i++)
+		run_fn(run_ctx);
+
+	*t->timing_enabled = 0;
+
+	for (i = 0; i < BENCH_NR_CPUS && n < runs; i++) {
+		__u32 cnt = t->idx[i];
+
+		for (j = 0; j < (int)cnt && n < runs; j++)
+			buf[n++] = t->samples[i][j];
+	}
+
+	if (n == 0)
+		return 0;
+
+	for (i = 1; i < n; i++) {
+		__u64 key = buf[i];
+
+		j = i - 1;
+		while (j >= 0 && buf[j] > key) {
+			buf[j + 1] = buf[j];
+			j--;
+		}
+		buf[j + 1] = key;
+	}
+
+	return buf[n / 2];
+}
+
+static __u32 compute_batch_iters(__u64 per_op_ns)
+{
+	__u64 target_ns = (__u64)CALIBRATE_TARGET_MS * 1000000ULL;
+	__u32 iters;
+
+	if (per_op_ns == 0)
+		return CALIBRATE_MIN_BATCH;
+
+	iters = target_ns / per_op_ns;
+
+	if (iters < CALIBRATE_MIN_BATCH)
+		iters = CALIBRATE_MIN_BATCH;
+	if (iters > CALIBRATE_MAX_BATCH)
+		iters = CALIBRATE_MAX_BATCH;
+
+	return iters;
+}
+
+void bpf_bench_calibrate(struct bpf_bench_timing *t,
+			 bpf_bench_run_fn run_fn, void *run_ctx)
+{
+	__u64 elapsed, per_op_ns;
+	__u64 time_n, time_2n;
+	double ratio;
+
+	elapsed = measure_elapsed(t, run_fn, run_ctx, CALIBRATE_SEED_BATCH, CALIBRATE_RUNS);
+	if (elapsed == 0) {
+		fprintf(stderr, "calibration: no timing samples, using default\n");
+		t->batch_iters = 10000;
+		*t->batch_iters_bss = t->batch_iters;
+		reset_timing(t);
+		return;
+	}
+
+	per_op_ns = elapsed / CALIBRATE_SEED_BATCH;
+	t->batch_iters = compute_batch_iters(per_op_ns);
+
+	if (!t->machine_readable)
+		printf("Calibration: %llu ns/op, batch_iters=%u (~%ums/batch)\n",
+		       (unsigned long long)per_op_ns, t->batch_iters,
+		       (unsigned int)(per_op_ns * t->batch_iters / 1000000));
+
+	time_n = measure_elapsed(t, run_fn, run_ctx, t->batch_iters, CALIBRATE_RUNS);
+	time_2n = measure_elapsed(t, run_fn, run_ctx, t->batch_iters * 2, CALIBRATE_RUNS);
+
+	if (time_n > 0 && time_2n > 0) {
+		ratio = (double)time_2n / (double)time_n;
+
+		if (fabs(ratio - 2.0) / 2.0 > PROPORTIONALITY_TOL)
+			fprintf(stderr,
+				"WARNING: proportionality check failed "
+				"(2N/N ratio=%.3f, expected=2.000, error=%.1f%%)\n"
+				"  System noise may be affecting results.\n",
+				ratio, fabs(ratio - 2.0) / 2.0 * 100.0);
+		else if (!t->machine_readable)
+			printf("Proportionality check: 2N/N ratio=%.4f (ok)\n",
+			       ratio);
+	}
+
+	*t->batch_iters_bss = t->batch_iters;
+	reset_timing(t);
+}
diff --git a/tools/testing/selftests/bpf/progs/bench_bpf_timing.bpf.h b/tools/testing/selftests/bpf/progs/bench_bpf_timing.bpf.h
new file mode 100644
index 000000000000..9a924f378a11
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bench_bpf_timing.bpf.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#ifndef __BENCH_BPF_TIMING_BPF_H__
+#define __BENCH_BPF_TIMING_BPF_H__
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+extern __u64 bpf_get_cpu_time_counter(void) __weak __ksym;
+extern __u64 bpf_cpu_time_counter_to_ns(__u64 counter) __weak __ksym;
+
+#ifndef BENCH_NR_SAMPLES
+#define BENCH_NR_SAMPLES	4096
+#endif
+#ifndef BENCH_NR_CPUS
+#define BENCH_NR_CPUS		256
+#endif
+#define BENCH_CPU_MASK		(BENCH_NR_CPUS - 1)
+
+__u64 timing_samples[BENCH_NR_CPUS][BENCH_NR_SAMPLES];
+__u32 timing_idx[BENCH_NR_CPUS];
+
+volatile __u32 batch_iters;
+volatile __u32 timing_enabled;
+
+static __always_inline void bench_record_sample(__u64 elapsed_ns)
+{
+	__u32 cpu, idx;
+
+	if (!timing_enabled)
+		return;
+
+	cpu = bpf_get_smp_processor_id() & BENCH_CPU_MASK;
+	idx = timing_idx[cpu];
+
+	if (idx >= BENCH_NR_SAMPLES)
+		return;
+
+	timing_samples[cpu][idx] = elapsed_ns;
+	timing_idx[cpu] = idx + 1;
+}
+
+/*
+ * @body:  expression to time; return value (int) stored in __bench_result.
+ * @reset: undo body's side-effects so each iteration starts identically.
+ *         May reference __bench_result.  Use ({}) for empty reset.
+ *
+ * Runs batch_iters timed iterations, then one untimed iteration whose
+ * return value the macro evaluates to (for validation).
+ */
+#define BENCH_BPF_LOOP(body, reset) ({					\
+	__u64 __bench_start = bpf_get_cpu_time_counter();		\
+	int __bench_result;						\
+									\
+	bpf_repeat(batch_iters) {					\
+		__bench_result = (body);				\
+		reset;							\
+	}								\
+									\
+	bench_record_sample(bpf_cpu_time_counter_to_ns(			\
+		bpf_get_cpu_time_counter() - __bench_start));		\
+									\
+	__bench_result = (body);					\
+	__bench_result;							\
+})
+
+#endif /* __BENCH_BPF_TIMING_BPF_H__ */
-- 
2.52.0

