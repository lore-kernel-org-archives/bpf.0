Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC0F346E59
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 06:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784703205; cv=none; b=VNIpRzEQX1uYweQgfwjZsA0lgbawjrzSM7fe/gC9D3s6NluAlC1piXHbEnBV2/ONBr59Ut9p8gYrsu/NZ0fb9OX5OlBjYrrTsXS2GJ2yPSYxlMALy3l5oJOycWLdGdB5i/SbuePmh+yxy8gadBh9SdkzZiko/RwFatVe3hdV6ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784703205; c=relaxed/simple;
	bh=EjgwsKetTIuGMZSADTnPR1fOehx7aMW6C1gB08KEoqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=It2r4ZGBFdhpULFn1wBDT2H7BRcvnzhJCPkxVJIZt0UWAl7ubOZWHyhfD7fiInD8Vho4Brwr4rQ88dqrDrdBWdC2SwxwdXdd0+zfLf50Ig27MjOsbxKJktvhEGcgffLj4bEsVP2anfCHwGKcdGsfGQpiw+kV0oO8zI3Hmdqra8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYkY2jTP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYkY2jTP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C6B1F000E9;
	Wed, 22 Jul 2026 06:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784703203;
	bh=CNgM21zkT13LhBwG5+nILIk3R+wA7gePyg7WfF68o2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DYkY2jTPyeE90jrQ6nL5t96fxyZlPcZyI+YQ9zzDSpg5jSSkWVlZzsJmC1XgdkS7K
	 qux08TSYl6SJ2BpHL8vs3Frxw9Y+DTrow/76zshwLOEw3+3utS9rKxdrEcQ4VZRc7Y
	 dTaHfd0sa4mH94RXmH7osUam8EWjrmqEc6KPgsTNWAdRb4iBPG9kD6DAsrN8hO+VZO
	 8y7GofdHiVZPoFvaAOca+Tk7bPPqw2ZNfHGJ6PCS2kK0Pr5/D/D+nRfiabFJVb0kRM
	 dZ004+Lg3sPN2vFktih6lEve0pYQE1XQpkT+ouWLVXXPv+sTU+02TL7Swfw8NILmEa
	 nXcE3GYS79snw==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add mmap/munmap benchmark for array maps
Date: Tue, 21 Jul 2026 23:53:08 -0700
Message-ID: <20260722065308.4116186-3-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722065308.4116186-1-song@kernel.org>
References: <20260722065308.4116186-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a benchmark that repeatedly mmap()s and munmap()s an mmap-able BPF
array map (BPF_F_MMAPABLE) from a configurable number of threads. Both
the number of worker threads and the size of the map are tunable via
--nr-threads and --map-size, defaulting to 16 threads and 8MiB.

The benchmark is useful to observe how the cost of mmap()/munmap()
scales with the mapping size, e.g. eager vs lazy page-table population.

Signed-off-by: Song Liu <song@kernel.org>
Assisted-by: Claude:claude-opus-4-8
---
 tools/testing/selftests/bpf/Makefile          |   1 +
 tools/testing/selftests/bpf/bench.c           |   4 +
 .../bpf/benchs/bench_arraymap_mmap.c          | 146 ++++++++++++++++++
 .../bpf/benchs/run_bench_arraymap_mmap.sh     |  15 ++
 4 files changed, 166 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_arraymap_mmap.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_arraymap_mmap.sh

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 55d394438705..b6593fb1135b 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -1003,6 +1003,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_bpf_timing.o \
 		 $(OUTPUT)/bench_bpf_nop.o \
 		 $(OUTPUT)/bench_xdp_lb.o \
+		 $(OUTPUT)/bench_arraymap_mmap.o \
 		 $(OUTPUT)/usdt_1.o \
 		 $(OUTPUT)/usdt_2.o \
 		 #
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 3d9d2cd7764b..192d5fcb7a74 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -287,6 +287,7 @@ extern struct argp bench_crypto_argp;
 extern struct argp bench_sockmap_argp;
 extern struct argp bench_lpm_trie_map_argp;
 extern struct argp bench_xdp_lb_argp;
+extern struct argp bench_arraymap_mmap_argp;
 
 static const struct argp_child bench_parsers[] = {
 	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
@@ -304,6 +305,7 @@ static const struct argp_child bench_parsers[] = {
 	{ &bench_sockmap_argp, 0, "bpf sockmap benchmark", 0 },
 	{ &bench_lpm_trie_map_argp, 0, "LPM trie map benchmark", 0 },
 	{ &bench_xdp_lb_argp, 0, "XDP load-balancer benchmark", 0 },
+	{ &bench_arraymap_mmap_argp, 0, "arraymap-mmap benchmark", 0 },
 	{},
 };
 
@@ -582,6 +584,7 @@ extern const struct bench bench_lpm_trie_delete;
 extern const struct bench bench_lpm_trie_free;
 extern const struct bench bench_bpf_nop;
 extern const struct bench bench_xdp_lb;
+extern const struct bench bench_arraymap_mmap;
 
 static const struct bench *benchs[] = {
 	&bench_count_global,
@@ -665,6 +668,7 @@ static const struct bench *benchs[] = {
 	&bench_lpm_trie_free,
 	&bench_bpf_nop,
 	&bench_xdp_lb,
+	&bench_arraymap_mmap,
 };
 
 static void find_benchmark(void)
diff --git a/tools/testing/selftests/bpf/benchs/bench_arraymap_mmap.c b/tools/testing/selftests/bpf/benchs/bench_arraymap_mmap.c
new file mode 100644
index 000000000000..356d80a85cf0
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_arraymap_mmap.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. */
+#include <argp.h>
+#include <sys/mman.h>
+#include "bench.h"
+
+/* Benchmark mmap()/munmap() of an mmap-able BPF array map from N threads. */
+
+static struct ctx {
+	int map_fd;
+	size_t mmap_sz;
+} ctx;
+
+static struct {
+	__u32 nr_threads;
+	__u64 map_size;
+} args = {
+	.nr_threads = 16,
+	.map_size = 8 * 1024 * 1024, /* 8 MiB */
+};
+
+enum {
+	ARG_NR_THREADS = 5000,
+	ARG_MAP_SIZE = 5001,
+};
+
+static const struct argp_option opts[] = {
+	{ "nr-threads", ARG_NR_THREADS, "NR_THREADS", 0,
+		"Number of threads that mmap/munmap the map (default 16)" },
+	{ "map-size", ARG_MAP_SIZE, "BYTES", 0,
+		"Size of the BPF array map in bytes (default 8388608)" },
+	{},
+};
+
+static error_t parse_arg(int key, char *arg, struct argp_state *state)
+{
+	switch (key) {
+	case ARG_NR_THREADS:
+		args.nr_threads = strtoul(arg, NULL, 0);
+		if (args.nr_threads == 0) {
+			fprintf(stderr, "Invalid nr-threads: %s\n", arg);
+			argp_usage(state);
+		}
+		break;
+	case ARG_MAP_SIZE:
+		args.map_size = strtoull(arg, NULL, 0);
+		if (args.map_size == 0) {
+			fprintf(stderr, "Invalid map-size: %s\n", arg);
+			argp_usage(state);
+		}
+		break;
+	default:
+		return ARGP_ERR_UNKNOWN;
+	}
+
+	return 0;
+}
+
+/* exported into benchmark runner */
+const struct argp bench_arraymap_mmap_argp = {
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
+
+	/*
+	 * The number of worker threads is controlled by --nr-threads and
+	 * drives the framework's producer machinery, so per-producer stats
+	 * are reported correctly.
+	 */
+	env.producer_cnt = args.nr_threads;
+}
+
+static long hits;
+
+static void *producer(void *input)
+{
+	while (true) {
+		void *addr;
+
+		addr = mmap(NULL, ctx.mmap_sz, PROT_READ | PROT_WRITE,
+			    MAP_SHARED, ctx.map_fd, 0);
+		if (addr == MAP_FAILED) {
+			fprintf(stderr, "mmap failed: %d\n", -errno);
+			exit(1);
+		}
+		if (munmap(addr, ctx.mmap_sz)) {
+			fprintf(stderr, "munmap failed: %d\n", -errno);
+			exit(1);
+		}
+		atomic_inc(&hits);
+	}
+
+	return NULL;
+}
+
+static void measure(struct bench_res *res)
+{
+	res->hits = atomic_swap(&hits, 0);
+}
+
+static void setup(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_MMAPABLE);
+	long page_sz = sysconf(_SC_PAGESIZE);
+	__u32 value_size = sizeof(__u64);
+	__u32 max_entries;
+
+	setup_libbpf();
+
+	/*
+	 * mmap-able array maps round the value size up to 8 bytes and expose
+	 * PAGE_ALIGN(max_entries * elem_size) bytes to user space.
+	 */
+	max_entries = (args.map_size + value_size - 1) / value_size;
+	ctx.mmap_sz = ((__u64)max_entries * value_size + page_sz - 1) &
+		      ~(page_sz - 1);
+
+	ctx.map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "mmap_array",
+				    sizeof(__u32), value_size, max_entries,
+				    &opts);
+	if (ctx.map_fd < 0) {
+		fprintf(stderr, "failed to create map: %d\n", -errno);
+		exit(1);
+	}
+
+	printf("array map: %u entries, mmap size %zu bytes, %u threads\n",
+	       max_entries, ctx.mmap_sz, args.nr_threads);
+}
+
+const struct bench bench_arraymap_mmap = {
+	.name = "arraymap-mmap",
+	.argp = &bench_arraymap_mmap_argp,
+	.validate = validate,
+	.setup = setup,
+	.producer_thread = producer,
+	.measure = measure,
+	.report_progress = ops_report_progress,
+	.report_final = ops_report_final,
+};
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_arraymap_mmap.sh b/tools/testing/selftests/bpf/benchs/run_bench_arraymap_mmap.sh
new file mode 100755
index 000000000000..3efd441cd653
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/run_bench_arraymap_mmap.sh
@@ -0,0 +1,15 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ./benchs/run_common.sh
+
+set -eufo pipefail
+
+for t in 1 4 8 16; do
+for s in 1048576 8388608 67108864; do
+subtitle "nr_threads: $t, map_size: $s"
+	summarize_ops "arraymap-mmap: " \
+	    "$($RUN_BENCH --nr-threads $t --map-size $s arraymap-mmap)"
+	printf "\n"
+done
+done
-- 
2.53.0-Meta

