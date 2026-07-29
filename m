Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0393F65EA
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357452; cv=none; b=Q0N5Ew5H+gQRQNhGAckS80jn0QJoUvTSj8xVjcbtxyXYgVrdbki8Jmfvpn5ItaANzN1+0RGCjevnN8I5WeRl7vUou1fxU9QROW61HPZ9BQeoPYbBv1qW6yhpCyyXnXFfwTcmHjeNW5sZmhBlnGDadgt38zPdp1pvu6ShdFu419U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357452; c=relaxed/simple;
	bh=YSlyE9huIGO9TCcl9YMQvBLeerVsSrtYsxVB6i73o4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toc7RII0+jZyOWXT8u5/2Cnv3V1GNfbwxuiVMxSnR6B0TlxuRaJ/skyXk+JgeO8mrl+JXCszYNfoZGSI4dJRHHI3DsnNILpdXTOMi2zkYY8Dw/aUj4dkvCVM4dRwK11rbaWW3HMtGMfLV4AyIZ4UgJgp0OETKvp4Ofc44bnzy8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpDVQ52l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpDVQ52l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035F81F00A3A;
	Wed, 29 Jul 2026 20:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785357430;
	bh=2zLZkD7V8q+NIi0RQc+Q68RjOVkSd+85kSmPx7CoPxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jpDVQ52lNVBjpf4XYzgm0F2HwufblITQyAwfBG4OR1fiyOXNVbqJ3IldtDwHO5sh3
	 siKID8+DoOQPinKTaFNBnm+mhFItkOxEvZRDBgadbU9R+41iCfxZjbzLi8llOofcjM
	 gPty2xppKSZnGB3rsagHf65eQltqE4ILyaNdgZ3h2jIfxaq1RUxPTGwbY2Q9KF3s28
	 nLnwOuLEBLoqSZQ0nSWPeWHnh6m13yWwFMUPs1AvWRBjuLXu2HI5EJgpyekpizq+xS
	 oKw5XooQ1yDL0NWxSFpZHQn9OZyNgo84G1THLQM0ypFOEFGJFTUBFtNGISO+AxySWm
	 n48qxL1mDPc1Q==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v4 6/6] selftests/bpf: Add bpf_for() benchmark
Date: Wed, 29 Jul 2026 13:36:26 -0700
Message-ID: <20260729203633.213973-7-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729203633.213973-1-puranjay@kernel.org>
References: <20260729203633.213973-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_for() macro builds on the numeric open-coded iterator kfuncs
bpf_iter_num_{new,next,destroy}(). Add a benchmark, modelled on the
existing bpf_loop benchmark, that repeatedly runs a bpf_for() loop so the
per-iteration cost of the iterator can be measured, e.g. to quantify the
effect of inlining the iterator kfuncs in the verifier.

The BPF program runs an inner bpf_for(i, 0, nr_loops) loop with an empty
body 1000 times per trigger and accounts nr_loops hits per outer
iteration, mirroring bench_bpf_loop so the two are directly comparable.

nr_loops defaults to 1000 so that the per-iteration bpf_iter_num_next()
cost, rather than the one-time bpf_iter_num_new()/destroy() setup and
teardown, dominates the reported numbers:

  $ ./bench -p 1 --nr_loops 1000 bpf-for

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |   4 +
 .../selftests/bpf/benchs/bench_bpf_for.c      | 104 ++++++++++++++++++
 .../selftests/bpf/benchs/run_bench_bpf_for.sh |  15 +++
 .../selftests/bpf/progs/bpf_for_bench.c       |  32 ++++++
 5 files changed, 157 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_for.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bpf_for.sh
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_for_bench.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 55d394438705a..3174c2f18e715 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -965,6 +965,7 @@ $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.skel.h \
 			    $(OUTPUT)/perfbuf_bench.skel.h
 $(OUTPUT)/bench_bloom_filter_map.o: $(OUTPUT)/bloom_filter_bench.skel.h
 $(OUTPUT)/bench_bpf_loop.o: $(OUTPUT)/bpf_loop_bench.skel.h
+$(OUTPUT)/bench_bpf_for.o: $(OUTPUT)/bpf_for_bench.skel.h
 $(OUTPUT)/bench_strncmp.o: $(OUTPUT)/strncmp_bench.skel.h
 $(OUTPUT)/bench_bpf_hashmap_full_update.o: $(OUTPUT)/bpf_hashmap_full_update_bench.skel.h
 $(OUTPUT)/bench_local_storage.o: $(OUTPUT)/local_storage_bench.skel.h
@@ -990,6 +991,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_ringbufs.o \
 		 $(OUTPUT)/bench_bloom_filter_map.o \
 		 $(OUTPUT)/bench_bpf_loop.o \
+		 $(OUTPUT)/bench_bpf_for.o \
 		 $(OUTPUT)/bench_strncmp.o \
 		 $(OUTPUT)/bench_bpf_hashmap_full_update.o \
 		 $(OUTPUT)/bench_local_storage.o \
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 3d9d2cd7764bd..b86b73456d3ca 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -276,6 +276,7 @@ static const struct argp_option opts[] = {
 extern struct argp bench_ringbufs_argp;
 extern struct argp bench_bloom_map_argp;
 extern struct argp bench_bpf_loop_argp;
+extern struct argp bench_bpf_for_argp;
 extern struct argp bench_local_storage_argp;
 extern struct argp bench_local_storage_rcu_tasks_trace_argp;
 extern struct argp bench_strncmp_argp;
@@ -292,6 +293,7 @@ static const struct argp_child bench_parsers[] = {
 	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
 	{ &bench_bloom_map_argp, 0, "Bloom filter map benchmark", 0 },
 	{ &bench_bpf_loop_argp, 0, "bpf_loop helper benchmark", 0 },
+	{ &bench_bpf_for_argp, 0, "bpf_for loop benchmark", 0 },
 	{ &bench_local_storage_argp, 0, "local_storage benchmark", 0 },
 	{ &bench_strncmp_argp, 0, "bpf_strncmp helper benchmark", 0 },
 	{ &bench_local_storage_rcu_tasks_trace_argp, 0,
@@ -557,6 +559,7 @@ extern const struct bench bench_bloom_false_positive;
 extern const struct bench bench_hashmap_without_bloom;
 extern const struct bench bench_hashmap_with_bloom;
 extern const struct bench bench_bpf_loop;
+extern const struct bench bench_bpf_for;
 extern const struct bench bench_strncmp_no_helper;
 extern const struct bench bench_strncmp_helper;
 extern const struct bench bench_bpf_hashmap_full_update;
@@ -640,6 +643,7 @@ static const struct bench *benchs[] = {
 	&bench_hashmap_without_bloom,
 	&bench_hashmap_with_bloom,
 	&bench_bpf_loop,
+	&bench_bpf_for,
 	&bench_strncmp_no_helper,
 	&bench_strncmp_helper,
 	&bench_bpf_hashmap_full_update,
diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_for.c b/tools/testing/selftests/bpf/benchs/bench_bpf_for.c
new file mode 100644
index 0000000000000..730c51ad2dec3
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_bpf_for.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <argp.h>
+#include "bench.h"
+#include "bpf_for_bench.skel.h"
+
+/* BPF triggering benchmarks */
+static struct ctx {
+	struct bpf_for_bench *skel;
+} ctx;
+
+static struct {
+	__u32 nr_loops;
+} args = {
+	/*
+	 * Default to a large loop count so the per-iteration bpf_iter_num_next() cost dominates
+	 * the one-time bpf_iter_num_new()/destroy() setup and teardown.
+	 */
+	.nr_loops = 1000,
+};
+
+enum {
+	ARG_NR_LOOPS = 4000,
+};
+
+static const struct argp_option opts[] = {
+	{ "nr_loops", ARG_NR_LOOPS, "nr_loops", 0,
+		"Set number of iterations for the bpf_for() loop"},
+	{},
+};
+
+static error_t parse_arg(int key, char *arg, struct argp_state *state)
+{
+	switch (key) {
+	case ARG_NR_LOOPS:
+		args.nr_loops = strtol(arg, NULL, 10);
+		break;
+	default:
+		return ARGP_ERR_UNKNOWN;
+	}
+
+	return 0;
+}
+
+/* exported into benchmark runner */
+const struct argp bench_bpf_for_argp = {
+	.options = opts,
+	.parser = parse_arg,
+};
+
+static void validate(void)
+{
+	if (env.consumer_cnt != 0) {
+		fprintf(stderr, "benchmark doesn't support consumer!\n");
+		exit(1);
+	}
+}
+
+static void *producer(void *input)
+{
+	while (true)
+		/* trigger the bpf program */
+		syscall(__NR_getpgid);
+
+	return NULL;
+}
+
+static void measure(struct bench_res *res)
+{
+	res->hits = atomic_swap(&ctx.skel->bss->hits, 0);
+}
+
+static void setup(void)
+{
+	struct bpf_link *link;
+
+	setup_libbpf();
+
+	ctx.skel = bpf_for_bench__open_and_load();
+	if (!ctx.skel) {
+		fprintf(stderr, "failed to open skeleton\n");
+		exit(1);
+	}
+
+	link = bpf_program__attach(ctx.skel->progs.benchmark);
+	if (!link) {
+		fprintf(stderr, "failed to attach program!\n");
+		exit(1);
+	}
+
+	ctx.skel->bss->nr_loops = args.nr_loops;
+}
+
+const struct bench bench_bpf_for = {
+	.name = "bpf-for",
+	.argp = &bench_bpf_for_argp,
+	.validate = validate,
+	.setup = setup,
+	.producer_thread = producer,
+	.measure = measure,
+	.report_progress = ops_report_progress,
+	.report_final = ops_report_final,
+};
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_bpf_for.sh b/tools/testing/selftests/bpf/benchs/run_bench_bpf_for.sh
new file mode 100755
index 0000000000000..7da6453920dab
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/run_bench_bpf_for.sh
@@ -0,0 +1,15 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ./benchs/run_common.sh
+
+set -eufo pipefail
+
+for t in 1 4 8 12 16; do
+for i in 10 100 500 1000 5000 10000 50000 100000 500000 1000000; do
+subtitle "nr_loops: $i, nr_threads: $t"
+	summarize_ops "bpf_for: " \
+	    "$($RUN_BENCH -p $t --nr_loops $i bpf-for)"
+	printf "\n"
+done
+done
diff --git a/tools/testing/selftests/bpf/progs/bpf_for_bench.c b/tools/testing/selftests/bpf/progs/bpf_for_bench.c
new file mode 100644
index 0000000000000..f9c723051fc74
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_for_bench.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+int nr_loops;
+long hits;
+
+static int outer_loop(__u32 index, void *data)
+{
+	int i;
+
+	/*
+	 * Empty body: the work being measured is the open-coded numeric iterator itself
+	 * (bpf_iter_num_new/next/destroy behind bpf_for()).
+	 */
+	bpf_for(i, 0, nr_loops)
+		;
+	__sync_add_and_fetch(&hits, nr_loops);
+	return 0;
+}
+
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int benchmark(void *ctx)
+{
+	bpf_loop(1000, outer_loop, NULL, 0);
+	return 0;
+}
-- 
2.53.0-Meta

