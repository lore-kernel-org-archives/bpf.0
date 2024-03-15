Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C80ED52F
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 05:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710479901; cv=none; b=dg/imOE5jJySmHogeHcGLOgaBCHNHx3JGHQ49e6TAcQ6TTgi9ciXn2OJawnHKAN+3t+Ja3iPNtIHtCtjHkGG9eIxXvzOvzQvGsThRfGz2Z4LGIxN1tsH6QQX4UXxCTh7kY85pMPEdIeAXmdLoOTFvtVHx6q/qyA7hW1Qv7J7cSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710479901; c=relaxed/simple;
	bh=WExK6KSsc/h4m+YXOL8wSayBVk93uU64floAX6+l6MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D75C0GW0AczRiC6kGIDfLTiaKsjxDyZOGCtVyKI3KaXjzGp/rbOEuZQtDStivk0xYCBRt3T745N+BzEH0BY4Rifwj7ChR9DC+Iqi833ljWCmce8Y+LFEK/QH0L3l2nsYjX94SQwwFAmf1Y6GDWJNp6fo/bvngAzDeY62TQSxK3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a05LnLR6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a05LnLR6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2608C433F1;
	Fri, 15 Mar 2024 05:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710479901;
	bh=WExK6KSsc/h4m+YXOL8wSayBVk93uU64floAX6+l6MA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a05LnLR6ZD8mg2ujHxLdzoJNWwn60L6L51ov1uFxeKoxuUYsK0LqmyX4z5JP/bAy1
	 fhACywZyoHRzWdOPvkrpW1Hiq0sNK5uKQIR3f9ozqlb134fcLWaqfD0myO946581FM
	 P3rIyAnCBovHilb6X3dKJGx5oBEjGcNJdbDZeYRqLvnsxPvCmzz7D742L1FEeaOvnu
	 4CB4bbpq/iGlZgLV/f6uRlgMdUil3BeEjRouexa87j/xlnUJTAeywANzcs+VbqgWbr
	 esmIc0ygqfybgx+EssL81Q+iNNDtBQ9Sd6EXMfvY9XJNM+uB3UnM7kxyuGjItRub0e
	 Wv9zNmL8C47vQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: add fast mostly in-kernel BPF triggering benchmarks
Date: Thu, 14 Mar 2024 22:18:13 -0700
Message-ID: <20240315051813.1320559-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315051813.1320559-1-andrii@kernel.org>
References: <20240315051813.1320559-1-andrii@kernel.org>
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
(bpf_get_smp_processor_id()), to which kprobe/fentry programs are
attached for benchmarking.

This way 1 bpf() syscall causes N executions of BPF program being
benchmarked. N defaults to 100, but can be adjusted with
--trig-batch-iters CLI argument.

Results speak for themselves:

$ ./run_bench_trigger.sh
uprobe-base         :  138.054 ± 0.556M/s
base                :   16.650 ± 0.123M/s
tp                  :   11.068 ± 0.100M/s
rawtp               :   14.087 ± 0.511M/s
kprobe              :    9.641 ± 0.027M/s
kprobe-multi        :   10.263 ± 0.061M/s
kretprobe           :    5.475 ± 0.028M/s
kretprobe-multi     :    5.703 ± 0.036M/s
fentry              :   14.544 ± 0.112M/s
fexit               :   10.637 ± 0.073M/s
fmodret             :   11.357 ± 0.061M/s
kprobe-fast         :   14.286 ± 0.377M/s
kprobe-multi-fast   :   14.999 ± 0.204M/s
kretprobe-fast      :    7.646 ± 0.084M/s
kretprobe-multi-fast:    4.354 ± 0.066M/s
fentry-fast         :   31.475 ± 0.254M/s
fexit-fast          :   17.379 ± 0.195M/s

Note how xxx-fast variants are measured with significantly higher
throughput, even though it's exactly the same in-kernel overhead:

fentry              :   14.544 ± 0.112M/s
fentry-fast         :   31.475 ± 0.254M/s

kprobe-multi        :   10.263 ± 0.061M/s
kprobe-multi-fast   :   14.999 ± 0.204M/s

One huge and not yet explained deviation is a slowdown of
kretprobe-multi, we should look into that separately.

kretprobe           :    5.475 ± 0.028M/s
kretprobe-multi     :    5.703 ± 0.036M/s
kretprobe-fast      :    7.646 ± 0.084M/s
kretprobe-multi-fast:    4.354 ± 0.066M/s

Kprobe cases don't seem to have this illogical slowdown:

kprobe              :    9.641 ± 0.027M/s
kprobe-multi        :   10.263 ± 0.061M/s
kprobe-fast         :   14.286 ± 0.377M/s
kprobe-multi-fast   :   14.999 ± 0.204M/s

Cc: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/bench.c           |  18 +++
 .../selftests/bpf/benchs/bench_trigger.c      | 123 +++++++++++++++++-
 .../selftests/bpf/benchs/run_bench_trigger.sh |   8 +-
 .../selftests/bpf/progs/trigger_bench.c       |  56 +++++++-
 4 files changed, 201 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index b2b4c391eb0a..67212b89f876 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -280,6 +280,7 @@ extern struct argp bench_strncmp_argp;
 extern struct argp bench_hashmap_lookup_argp;
 extern struct argp bench_local_storage_create_argp;
 extern struct argp bench_htab_mem_argp;
+extern struct argp bench_trigger_fast_argp;
 
 static const struct argp_child bench_parsers[] = {
 	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
@@ -292,6 +293,7 @@ static const struct argp_child bench_parsers[] = {
 	{ &bench_hashmap_lookup_argp, 0, "Hashmap lookup benchmark", 0 },
 	{ &bench_local_storage_create_argp, 0, "local-storage-create benchmark", 0 },
 	{ &bench_htab_mem_argp, 0, "hash map memory benchmark", 0 },
+	{ &bench_trigger_fast_argp, 0, "BPF triggering benchmark", 0 },
 	{},
 };
 
@@ -502,6 +504,12 @@ extern const struct bench bench_trig_fentry;
 extern const struct bench bench_trig_fexit;
 extern const struct bench bench_trig_fentry_sleep;
 extern const struct bench bench_trig_fmodret;
+extern const struct bench bench_trig_kprobe_fast;
+extern const struct bench bench_trig_kretprobe_fast;
+extern const struct bench bench_trig_kprobe_multi_fast;
+extern const struct bench bench_trig_kretprobe_multi_fast;
+extern const struct bench bench_trig_fentry_fast;
+extern const struct bench bench_trig_fexit_fast;
 extern const struct bench bench_trig_uprobe_base;
 extern const struct bench bench_trig_uprobe_nop;
 extern const struct bench bench_trig_uretprobe_nop;
@@ -539,6 +547,7 @@ static const struct bench *benchs[] = {
 	&bench_rename_rawtp,
 	&bench_rename_fentry,
 	&bench_rename_fexit,
+	/* syscall-driven triggering benchmarks */
 	&bench_trig_base,
 	&bench_trig_tp,
 	&bench_trig_rawtp,
@@ -550,6 +559,14 @@ static const struct bench *benchs[] = {
 	&bench_trig_fexit,
 	&bench_trig_fentry_sleep,
 	&bench_trig_fmodret,
+	/* fast, mostly in-kernel triggers */
+	&bench_trig_kprobe_fast,
+	&bench_trig_kretprobe_fast,
+	&bench_trig_kprobe_multi_fast,
+	&bench_trig_kretprobe_multi_fast,
+	&bench_trig_fentry_fast,
+	&bench_trig_fexit_fast,
+	/* uprobes */
 	&bench_trig_uprobe_base,
 	&bench_trig_uprobe_nop,
 	&bench_trig_uretprobe_nop,
@@ -557,6 +574,7 @@ static const struct bench *benchs[] = {
 	&bench_trig_uretprobe_push,
 	&bench_trig_uprobe_ret,
 	&bench_trig_uretprobe_ret,
+	/* ringbuf/perfbuf benchmarks */
 	&bench_rb_libbpf,
 	&bench_rb_custom,
 	&bench_pb_libbpf,
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 8fbc78d5f8a4..d6c87180c887 100644
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
+const struct argp bench_trigger_fast_argp = {
+	.options = opts,
+	.parser = parse_arg,
+};
+
 /* adjust slot shift in inc_hits() if changing */
 #define MAX_BUCKETS 256
 
@@ -70,6 +113,16 @@ static void *trigger_producer(void *input)
 	return NULL;
 }
 
+static void *trigger_producer_fast(void *input)
+{
+	int fd = bpf_program__fd(ctx.skel->progs.trigger_driver);
+
+	while (true)
+		bpf_prog_test_run_opts(fd, NULL);
+
+	return NULL;
+}
+
 static void trigger_measure(struct bench_res *res)
 {
 	res->hits = sum_and_reset_counters(ctx.skel->bss->hits);
@@ -77,13 +130,23 @@ static void trigger_measure(struct bench_res *res)
 
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
@@ -157,6 +220,44 @@ static void trigger_fmodret_setup(void)
 	attach_bpf(ctx.skel->progs.bench_trigger_fmodret);
 }
 
+/* Fast, mostly in-kernel triggering setups */
+
+static void trigger_kprobe_fast_setup(void)
+{
+	setup_ctx();
+	attach_bpf(ctx.skel->progs.bench_trigger_kprobe_fast);
+}
+
+static void trigger_kretprobe_fast_setup(void)
+{
+	setup_ctx();
+	attach_bpf(ctx.skel->progs.bench_trigger_kretprobe_fast);
+}
+
+static void trigger_kprobe_multi_fast_setup(void)
+{
+	setup_ctx();
+	attach_bpf(ctx.skel->progs.bench_trigger_kprobe_multi_fast);
+}
+
+static void trigger_kretprobe_multi_fast_setup(void)
+{
+	setup_ctx();
+	attach_bpf(ctx.skel->progs.bench_trigger_kretprobe_multi_fast);
+}
+
+static void trigger_fentry_fast_setup(void)
+{
+	setup_ctx();
+	attach_bpf(ctx.skel->progs.bench_trigger_fentry_fast);
+}
+
+static void trigger_fexit_fast_setup(void)
+{
+	setup_ctx();
+	attach_bpf(ctx.skel->progs.bench_trigger_fexit_fast);
+}
+
 /* make sure call is not inlined and not avoided by compiler, so __weak and
  * inline asm volatile in the body of the function
  *
@@ -385,6 +486,26 @@ const struct bench bench_trig_fmodret = {
 	.report_final = hits_drops_report_final,
 };
 
+/* fast (staying mostly in kernel) kprobe/fentry benchmarks */
+#define BENCH_TRIG_FAST(KIND, NAME)					\
+const struct bench bench_trig_##KIND = {				\
+	.name = "trig-" NAME,						\
+	.setup = trigger_##KIND##_setup,				\
+	.producer_thread = trigger_producer_fast,			\
+	.measure = trigger_measure,					\
+	.report_progress = hits_drops_report_progress,			\
+	.report_final = hits_drops_report_final,			\
+	.argp = &bench_trigger_fast_argp,				\
+}
+
+BENCH_TRIG_FAST(kprobe_fast, "kprobe-fast");
+BENCH_TRIG_FAST(kretprobe_fast, "kretprobe-fast");
+BENCH_TRIG_FAST(kprobe_multi_fast, "kprobe-multi-fast");
+BENCH_TRIG_FAST(kretprobe_multi_fast, "kretprobe-multi-fast");
+BENCH_TRIG_FAST(fentry_fast, "fentry-fast");
+BENCH_TRIG_FAST(fexit_fast, "fexit-fast");
+
+/* uprobe benchmarks */
 const struct bench bench_trig_uprobe_base = {
 	.name = "trig-uprobe-base",
 	.setup = NULL, /* no uprobe/uretprobe is attached */
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh b/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
index 78e83f243294..fee069ac930b 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
@@ -2,8 +2,12 @@
 
 set -eufo pipefail
 
-for i in base tp rawtp kprobe fentry fmodret
+for i in uprobe-base base tp rawtp \
+	 kprobe kprobe-multi kretprobe kretprobe-multi \
+	 fentry fexit fmodret \
+	 kprobe-fast kprobe-multi-fast kretprobe-fast kretprobe-multi-fast \
+	 fentry-fast fexit-fast
 do
 	summary=$(sudo ./bench -w2 -d5 -a trig-$i | tail -n1 | cut -d'(' -f1 | cut -d' ' -f3-)
-	printf "%-10s: %s\n" $i "$summary"
+	printf "%-20s: %s\n" $i "$summary"
 done
diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
index 42ec202015ed..2886c2cb3570 100644
--- a/tools/testing/selftests/bpf/progs/trigger_bench.c
+++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2020 Facebook
-
 #include <linux/bpf.h>
 #include <asm/unistd.h>
 #include <bpf/bpf_helpers.h>
@@ -103,3 +102,58 @@ int bench_trigger_uprobe(void *ctx)
 	inc_counter();
 	return 0;
 }
+
+const volatile int batch_iters = 0;
+
+SEC("raw_tp")
+int trigger_driver(void *ctx)
+{
+	int i;
+
+	for (i = 0; i < batch_iters; i++)
+		(void)bpf_get_smp_processor_id(); /* attach here to benchmark */
+
+	return 0;
+}
+
+SEC("kprobe/bpf_get_smp_processor_id")
+int bench_trigger_kprobe_fast(void *ctx)
+{
+	inc_counter();
+	return 0;
+}
+
+SEC("kretprobe/bpf_get_smp_processor_id")
+int bench_trigger_kretprobe_fast(void *ctx)
+{
+	inc_counter();
+	return 0;
+}
+
+SEC("kprobe.multi/bpf_get_smp_processor_id")
+int bench_trigger_kprobe_multi_fast(void *ctx)
+{
+	inc_counter();
+	return 0;
+}
+
+SEC("kretprobe.multi/bpf_get_smp_processor_id")
+int bench_trigger_kretprobe_multi_fast(void *ctx)
+{
+	inc_counter();
+	return 0;
+}
+
+SEC("fentry/bpf_get_smp_processor_id")
+int bench_trigger_fentry_fast(void *ctx)
+{
+	inc_counter();
+	return 0;
+}
+
+SEC("fexit/bpf_get_smp_processor_id")
+int bench_trigger_fexit_fast(void *ctx)
+{
+	inc_counter();
+	return 0;
+}
-- 
2.43.0

