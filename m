Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA58BE65
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 00:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065656; cv=none; b=gsgS/iBdCzdZM5jnkuVovQbIL2wMvO3S3zZf/BFVH06OzVNhE2C4XCTLeVFY1EpvF2E2ThV1VTxzyB88d1LKVTDSXGe1KF6at0xANKywLKD6Ji02k9c2eefGXlLCh23HDi1wcbNlTPJzgH9CWMmYfMm5Bp46iZGAHXmorYyk4x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065656; c=relaxed/simple;
	bh=QBix4nOMRi0CG6TSGD0Dr9v+cIJ8puRms/VCh13VqjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j1ElRdhluGL0mqpPP6GTYFfuAPNZlltTLy20/k2DJxxynSvdg8wsheD2J0cWW18jHu4gdUUT6JVePoo0BV7QlRGuQipIFBU3T1ELoe5GTz9YrV0d0NazFZ7tR5KCLP4Z05YHGoLb8kC9uXF2YAoAbWQYQRv2eT9Riuhml+VFZQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBP6ixB1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBP6ixB1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F30C433C7;
	Fri, 22 Mar 2024 00:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711065656;
	bh=QBix4nOMRi0CG6TSGD0Dr9v+cIJ8puRms/VCh13VqjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MBP6ixB1/qzUYS7LIym1s3N2nnAqLJqSWqnp6ppCYyNoVp1F3THKttGbhhQeCISUs
	 TjhjgTh0y7+pbXsNoEfGYPoKXseK86/a/mBHhoUpK5EMCEqJl3DAbcNMtYV0hTxNDG
	 Nzq5q52qpEU7ycHa51pspLnqaRcMtXkygtGvY2dAzpcnoQfWi0I00I1n2UZUMF/08s
	 b9XnGhxW3pjEoSlTrqjb8ZaALqcm3+SHMvoumq1INSl5rPoggvvrd3KUUtEVXqxbRs
	 XP6OqotHDPuSjlvC803N0IhDs8vlWn2Eck/DZWJ9F3Bwf9YWstk5kfHTO+EXmplpOs
	 YqwrTQ78RXXCQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf-next 2/6] selftests/bpf: add batched, mostly in-kernel BPF triggering benchmarks
Date: Thu, 21 Mar 2024 17:00:37 -0700
Message-ID: <20240322000041.2919948-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322000041.2919948-1-andrii@kernel.org>
References: <20240322000041.2919948-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Existing kprobe/fentry triggering benchmarks have 1-to-1 mapping between
one syscall execution and BPF program run. While we use a fast
get_pgid() syscall, syscall overhead can still be non-trivial.

This patch adds kprobe/fentry set of benchmarks significantly amortizing
the cost of syscall vs actual BPF triggering overhead. We do this by
employing BPF_PROG_TEST_RUN command to trigger "driver" raw_tp program
which does a tight parameterized loop calling cheap BPF helper
(bpf_get_numa_node_id()), to which kprobe/fentry programs are
attached for benchmarking.

This way 1 bpf() syscall causes N executions of BPF program being
benchmarked. N defaults to 100, but can be adjusted with
--trig-batch-iters CLI argument.

For comparison we also implement a new baseline program that instead of
triggering another BPF program just does N atomic per-CPU counter
increments, establishing the limit for all other types of program within
this batched benchmarking setup.

Taking the final set of benchmarks added in this patch set (including
tp/raw_tp/fmodret, added in later patch), and keeping for now "legacy"
syscall-driven benchmarks, we can capture all triggering benchmarks in
one place for comparison, before we remove the legacy ones (and rename
xxx-batched into just xxx).

$ benchs/run_bench_trigger.sh
usermode-count       :   79.500 ± 0.024M/s
kernel-count         :   49.949 ± 0.081M/s
syscall-count        :    9.009 ± 0.007M/s

fentry-batch         :   31.002 ± 0.015M/s
fexit-batch          :   20.372 ± 0.028M/s
fmodret-batch        :   21.651 ± 0.659M/s
rawtp-batch          :   36.775 ± 0.264M/s
tp-batch             :   19.411 ± 0.248M/s
kprobe-batch         :   12.949 ± 0.220M/s
kprobe-multi-batch   :   15.400 ± 0.007M/s
kretprobe-batch      :    5.559 ± 0.011M/s
kretprobe-multi-batch:    5.861 ± 0.003M/s

fentry-legacy        :    8.329 ± 0.004M/s
fexit-legacy         :    6.239 ± 0.003M/s
fmodret-legacy       :    6.595 ± 0.001M/s
rawtp-legacy         :    8.305 ± 0.004M/s
tp-legacy            :    6.382 ± 0.001M/s
kprobe-legacy        :    5.528 ± 0.003M/s
kprobe-multi-legacy  :    5.864 ± 0.022M/s
kretprobe-legacy     :    3.081 ± 0.001M/s
kretprobe-multi-legacy:   3.193 ± 0.001M/s

Note how xxx-batch variants are measured with significantly higher
throughput, even though it's exactly the same in-kernel overhead. As
such, results can be compared only between benchmarks of the same kind
(syscall vs batched):

fentry-legacy        :    8.329 ± 0.004M/s
fentry-batch         :   31.002 ± 0.015M/s

kprobe-multi-legacy  :    5.864 ± 0.022M/s
kprobe-multi-batch   :   15.400 ± 0.007M/s

Note also that syscall-count is setting a theoretical limit for
syscall-triggered benchmarks, while kernel-count is setting similar
limits for batch variants. usermode-count is a happy and unachievable
case of user space counting without doing any syscalls, and is mostly
the measure of CPU speed for such a trivial benchmark.

As was mentioned, tp/raw_tp/fmodret require kernel-side kfunc to produce
similar benchmark, which we address in a separate patch.

Note that run_bench_trigger.sh allows to override a list of benchmarks
to run, which is very useful for performance work.

Cc: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/bench.c           |  21 ++-
 .../selftests/bpf/benchs/bench_trigger.c      | 130 +++++++++++++++++-
 .../selftests/bpf/benchs/run_bench_trigger.sh |  24 +++-
 .../selftests/bpf/progs/trigger_bench.c       |  67 ++++++++-
 4 files changed, 235 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 7ca1e1eb5c30..484bcbeaa819 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -280,6 +280,7 @@ extern struct argp bench_strncmp_argp;
 extern struct argp bench_hashmap_lookup_argp;
 extern struct argp bench_local_storage_create_argp;
 extern struct argp bench_htab_mem_argp;
+extern struct argp bench_trigger_batch_argp;
 
 static const struct argp_child bench_parsers[] = {
 	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
@@ -292,6 +293,7 @@ static const struct argp_child bench_parsers[] = {
 	{ &bench_hashmap_lookup_argp, 0, "Hashmap lookup benchmark", 0 },
 	{ &bench_local_storage_create_argp, 0, "local-storage-create benchmark", 0 },
 	{ &bench_htab_mem_argp, 0, "hash map memory benchmark", 0 },
+	{ &bench_trigger_batch_argp, 0, "BPF triggering benchmark", 0 },
 	{},
 };
 
@@ -508,6 +510,15 @@ extern const struct bench bench_trig_fexit;
 extern const struct bench bench_trig_fentry_sleep;
 extern const struct bench bench_trig_fmodret;
 
+/* batched, staying mostly in-kernel benchmarks */
+extern const struct bench bench_trig_kernel_count;
+extern const struct bench bench_trig_kprobe_batch;
+extern const struct bench bench_trig_kretprobe_batch;
+extern const struct bench bench_trig_kprobe_multi_batch;
+extern const struct bench bench_trig_kretprobe_multi_batch;
+extern const struct bench bench_trig_fentry_batch;
+extern const struct bench bench_trig_fexit_batch;
+
 /* uprobe/uretprobe benchmarks */
 extern const struct bench bench_trig_uprobe_nop;
 extern const struct bench bench_trig_uretprobe_nop;
@@ -548,7 +559,7 @@ static const struct bench *benchs[] = {
 	&bench_rename_fexit,
 	/* pure counting benchmarks for establishing theoretical limits */
 	&bench_trig_usermode_count,
-	&bench_trig_base,
+	&bench_trig_kernel_count,
 	/* syscall-driven triggering benchmarks */
 	&bench_trig_tp,
 	&bench_trig_rawtp,
@@ -560,6 +571,13 @@ static const struct bench *benchs[] = {
 	&bench_trig_fexit,
 	&bench_trig_fentry_sleep,
 	&bench_trig_fmodret,
+	/* batched, staying mostly in-kernel triggers */
+	&bench_trig_kprobe_batch,
+	&bench_trig_kretprobe_batch,
+	&bench_trig_kprobe_multi_batch,
+	&bench_trig_kretprobe_multi_batch,
+	&bench_trig_fentry_batch,
+	&bench_trig_fexit_batch,
 	/* uprobes */
 	&bench_trig_uprobe_nop,
 	&bench_trig_uretprobe_nop,
@@ -567,6 +585,7 @@ static const struct bench *benchs[] = {
 	&bench_trig_uretprobe_push,
 	&bench_trig_uprobe_ret,
 	&bench_trig_uretprobe_ret,
+	/* ringbuf/perfbuf benchmarks */
 	&bench_rb_libbpf,
 	&bench_rb_custom,
 	&bench_pb_libbpf,
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 68e703b46d9b..21fa1a84ecd2 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -1,11 +1,54 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
 #define _GNU_SOURCE
+#include <argp.h>
 #include <unistd.h>
+#include <stdint.h>
 #include "bench.h"
 #include "trigger_bench.skel.h"
 #include "trace_helpers.h"
 
+static struct {
+	__u32 batch_iters;
+} args = {
+	.batch_iters = 100,
+};
+
+enum {
+	ARG_TRIG_BATCH_ITERS = 7000,
+};
+
+static const struct argp_option opts[] = {
+	{ "trig-batch-iters", ARG_TRIG_BATCH_ITERS, "BATCH_ITER_CNT", 0,
+		"Number of in-kernel iterations per one driver test run"},
+	{},
+};
+
+static error_t parse_arg(int key, char *arg, struct argp_state *state)
+{
+	long ret;
+
+	switch (key) {
+	case ARG_TRIG_BATCH_ITERS:
+		ret = strtol(arg, NULL, 10);
+		if (ret < 1 || ret > UINT_MAX) {
+			fprintf(stderr, "invalid --trig-batch-iters value");
+			argp_usage(state);
+		}
+		args.batch_iters = ret;
+		break;
+	default:
+		return ARGP_ERR_UNKNOWN;
+	}
+
+	return 0;
+}
+
+const struct argp bench_trigger_batch_argp = {
+	.options = opts,
+	.parser = parse_arg,
+};
+
 /* adjust slot shift in inc_hits() if changing */
 #define MAX_BUCKETS 256
 
@@ -13,6 +56,7 @@
 static struct trigger_ctx {
 	struct trigger_bench *skel;
 	bool usermode_counters;
+	int driver_prog_fd;
 } ctx;
 
 static struct counter base_hits[MAX_BUCKETS];
@@ -71,6 +115,16 @@ static void *trigger_producer(void *input)
 	return NULL;
 }
 
+static void *trigger_producer_batch(void *input)
+{
+	int fd = ctx.driver_prog_fd ?: bpf_program__fd(ctx.skel->progs.trigger_driver);
+
+	while (true)
+		bpf_prog_test_run_opts(fd, NULL);
+
+	return NULL;
+}
+
 static void trigger_measure(struct bench_res *res)
 {
 	if (ctx.usermode_counters)
@@ -81,13 +135,23 @@ static void trigger_measure(struct bench_res *res)
 
 static void setup_ctx(void)
 {
+	int err;
+
 	setup_libbpf();
 
-	ctx.skel = trigger_bench__open_and_load();
+	ctx.skel = trigger_bench__open();
 	if (!ctx.skel) {
 		fprintf(stderr, "failed to open skeleton\n");
 		exit(1);
 	}
+
+	ctx.skel->rodata->batch_iters = args.batch_iters;
+
+	err = trigger_bench__load(ctx.skel);
+	if (err) {
+		fprintf(stderr, "failed to open skeleton\n");
+		exit(1);
+	}
 }
 
 static void attach_bpf(struct bpf_program *prog)
@@ -161,6 +225,50 @@ static void trigger_fmodret_setup(void)
 	attach_bpf(ctx.skel->progs.bench_trigger_fmodret);
 }
 
+/* Batched, staying mostly in-kernel triggering setups */
+static void trigger_kernel_count_setup(void)
+{
+	setup_ctx();
+	/* override driver program */
+	ctx.driver_prog_fd = bpf_program__fd(ctx.skel->progs.trigger_count);
+}
+
+static void trigger_kprobe_batch_setup(void)
+{
+	setup_ctx();
+	attach_bpf(ctx.skel->progs.bench_trigger_kprobe_batch);
+}
+
+static void trigger_kretprobe_batch_setup(void)
+{
+	setup_ctx();
+	attach_bpf(ctx.skel->progs.bench_trigger_kretprobe_batch);
+}
+
+static void trigger_kprobe_multi_batch_setup(void)
+{
+	setup_ctx();
+	attach_bpf(ctx.skel->progs.bench_trigger_kprobe_multi_batch);
+}
+
+static void trigger_kretprobe_multi_batch_setup(void)
+{
+	setup_ctx();
+	attach_bpf(ctx.skel->progs.bench_trigger_kretprobe_multi_batch);
+}
+
+static void trigger_fentry_batch_setup(void)
+{
+	setup_ctx();
+	attach_bpf(ctx.skel->progs.bench_trigger_fentry_batch);
+}
+
+static void trigger_fexit_batch_setup(void)
+{
+	setup_ctx();
+	attach_bpf(ctx.skel->progs.bench_trigger_fexit_batch);
+}
+
 /* make sure call is not inlined and not avoided by compiler, so __weak and
  * inline asm volatile in the body of the function
  *
@@ -394,6 +502,26 @@ const struct bench bench_trig_fmodret = {
 	.report_final = hits_drops_report_final,
 };
 
+/* batched (staying mostly in kernel) kprobe/fentry benchmarks */
+#define BENCH_TRIG_BATCH(KIND, NAME)					\
+const struct bench bench_trig_##KIND = {				\
+	.name = "trig-" NAME,						\
+	.setup = trigger_##KIND##_setup,				\
+	.producer_thread = trigger_producer_batch,			\
+	.measure = trigger_measure,					\
+	.report_progress = hits_drops_report_progress,			\
+	.report_final = hits_drops_report_final,			\
+	.argp = &bench_trigger_batch_argp,				\
+}
+
+BENCH_TRIG_BATCH(kernel_count, "kernel-count");
+BENCH_TRIG_BATCH(kprobe_batch, "kprobe-batch");
+BENCH_TRIG_BATCH(kretprobe_batch, "kretprobe-batch");
+BENCH_TRIG_BATCH(kprobe_multi_batch, "kprobe-multi-batch");
+BENCH_TRIG_BATCH(kretprobe_multi_batch, "kretprobe-multi-batch");
+BENCH_TRIG_BATCH(fentry_batch, "fentry-batch");
+BENCH_TRIG_BATCH(fexit_batch, "fexit-batch");
+
 /* uprobe benchmarks */
 #define BENCH_TRIG_USERMODE(KIND, PRODUCER, NAME)			\
 const struct bench bench_trig_##KIND = {				\
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh b/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
index 78e83f243294..b58ec33ea18c 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
@@ -2,8 +2,24 @@
 
 set -eufo pipefail
 
-for i in base tp rawtp kprobe fentry fmodret
-do
-	summary=$(sudo ./bench -w2 -d5 -a trig-$i | tail -n1 | cut -d'(' -f1 | cut -d' ' -f3-)
-	printf "%-10s: %s\n" $i "$summary"
+def_tests=( \
+	usermode-count kernel-count syscall-count \
+	fentry-batch fexit-batch \
+	kprobe-batch kprobe-multi-batch \
+	kretprobe-batch kretprobe-multi-batch \
+	fentry fexit fmodret \
+	rawtp tp \
+	kprobe kprobe-multi kretprobe kretprobe-multi \
+)
+
+tests=("$@")
+if [ ${#tests[@]} -eq 0 ]; then
+	tests=("${def_tests[@]}")
+fi
+
+p=${PROD_CNT:-1}
+
+for t in "${tests[@]}"; do
+	summary=$(sudo ./bench -w2 -d5 -a -p$p trig-$t | tail -n1 | cut -d'(' -f1 | cut -d' ' -f3-)
+	printf "%-21s: %s\n" $t "$summary"
 done
diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
index 42ec202015ed..f0b76afa5017 100644
--- a/tools/testing/selftests/bpf/progs/trigger_bench.c
+++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2020 Facebook
-
 #include <linux/bpf.h>
 #include <asm/unistd.h>
 #include <bpf/bpf_helpers.h>
@@ -103,3 +102,69 @@ int bench_trigger_uprobe(void *ctx)
 	inc_counter();
 	return 0;
 }
+
+const volatile int batch_iters = 0;
+
+SEC("raw_tp")
+int trigger_count(void *ctx)
+{
+	int i;
+
+	for (i = 0; i < batch_iters; i++)
+		inc_counter();
+
+	return 0;
+}
+
+SEC("raw_tp")
+int trigger_driver(void *ctx)
+{
+	int i;
+
+	for (i = 0; i < batch_iters; i++)
+		(void)bpf_get_numa_node_id(); /* attach point for benchmarking */
+
+	return 0;
+}
+
+SEC("kprobe/bpf_get_numa_node_id")
+int bench_trigger_kprobe_batch(void *ctx)
+{
+	inc_counter();
+	return 0;
+}
+
+SEC("kretprobe/bpf_get_numa_node_id")
+int bench_trigger_kretprobe_batch(void *ctx)
+{
+	inc_counter();
+	return 0;
+}
+
+SEC("kprobe.multi/bpf_get_numa_node_id")
+int bench_trigger_kprobe_multi_batch(void *ctx)
+{
+	inc_counter();
+	return 0;
+}
+
+SEC("kretprobe.multi/bpf_get_numa_node_id")
+int bench_trigger_kretprobe_multi_batch(void *ctx)
+{
+	inc_counter();
+	return 0;
+}
+
+SEC("fentry/bpf_get_numa_node_id")
+int bench_trigger_fentry_batch(void *ctx)
+{
+	inc_counter();
+	return 0;
+}
+
+SEC("fexit/bpf_get_numa_node_id")
+int bench_trigger_fexit_batch(void *ctx)
+{
+	inc_counter();
+	return 0;
+}
-- 
2.43.0

