Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E853B38A2
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 19:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994187; cv=none; b=cZeQfxoUW/AZIDHZoKBMSVAiX9YutDmvT5HyBFYRyrG/Ae/CJcVnuTRHql7Crtxh9QQhf4iszYcqqb9GZp3VkkjaKWGrO+NBawfaljMI0pwsf2aJA2Ovie7Y4DghGUUvruh++lXlO7IXwvrheKunv0EIvK2l19rxnkO+E67ptHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994187; c=relaxed/simple;
	bh=qyrdRKAoLjIxPFwr29h/G9Or5cf9OC3Y8eBY/dYpu1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=su10MURyMI/42LbXOaH8FqASmv6zqDhofeQ1MtCI8zHUKoNjoxsn3KZwglpyqPTNmNmwLraBLQQ5s02Ajc222pRpvbM2RBOrpDKD4hLkYvmWhXTjDBXZxG+NLarNepE++8HiMFR38JEw0oNBFP//Ke1FFYmJjDCLmxzEE9d10Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=tM6GK+up; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="tM6GK+up"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso4923283a91.2
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 12:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1786994185; x=1787598985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Dzor70WJDnSOmcqm4vIeMtkrjxyDmjMc8CBaD/oZ5M=;
        b=tM6GK+up/94oFWzXlDn9zGlzbCS3YDLt1GywtIKrj7FpamsqT/LBZBqnjV6q04bRdW
         M/Plx29mH7jn5KTJcHhq9AcBrf+Juz19DrZmJKZ3zhuY+2awQtkWm+y85PMkd7HCtecV
         zRK6+ISyqFbnylhZBWeSB2YLl9nOwQWJrRZTF2IVIPt9gEifkA6CTJIxYoZyvBvYxZwS
         j6//GrveuW5KoDLxtIpXqQ8lG4JgbY/dV470HCuoy/AB/XTsjI4YQ3UurtDlgd79ks5G
         hZpGZscLEooxr1qVQABBWJC6qCGSSQ3e5OGhAIJvhka8/+iYTQfTlmJ0dnwqZnJbeUYh
         W5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994185; x=1787598985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Dzor70WJDnSOmcqm4vIeMtkrjxyDmjMc8CBaD/oZ5M=;
        b=ZY8D3znFGFCYZHAozag0njrtuA8Kdcn3EhWctvc3dt7fVnzj4h8eUPcc4eH7rHEZWt
         l3tr9V11znDsTaJNb0g+/dLyYE225gVHuepFb3M9Dx3liQ3Z5O+s3ibTjVSGbHOiKTIu
         i5XqgQ9VXJjxvtb/EpYkfXB1DWQn9w/5gwB83KgETxtfnXQe/OVxNBkCHAT8sTUGPR9K
         zQuhAyToQDUTE4UV/8MHtMiQABOw4ZBN8oUJWRi3+UD925VD8qqIw+6yrtm968FEAhpj
         +/d8n9AueghTf9tnjltq6ddR7zNC0oFdLBaEQ8Xcb5ec6s97KIGTr84aFFwIwpEhr/Ep
         76fw==
X-Gm-Message-State: AOJu0YwjduX4a5MC9MBQ4AX2w8nGJAjo9w2eyPDvZnwyEmv0QrU1LjIZ
	pcpOijWd3tpa5GSzaY/66zXAXNxgXvHtOzEi9SDHxhFg1NCpPS4jD9JZe/AjIRHXQZ/gv928BDK
	JJDk+K8E=
X-Gm-Gg: AR+sD11d7PRd5QkBIr2K29bmtjs7WuhdfncqbXWfPP+uX4eleZIUjMnizXoPy4Uq1AW
	3J5GgiUL2Giy/ku35Wyb0yi3lbAtlWqoF0rkIkZUnkwgRMHJq6K15En5FbS9W4U6EfGFF+YOqG4
	W5zLVkZ2eentzdWYX0SaQdKMa4QEtyLB0oWu3O0soL4FSG381klnpXFXBBHMT2g2lF46ISVmbYu
	ZwwKnvYzUs8R9JhcSIisK65WdNBfdjUo1V5zzv4stbgRPQiN9uVk1hSGQ7bGhwtii3/TiyFky1Q
	pfN9AAIwzV9cd6L+knu2EhV5wOByoj6cdDo1GXC5qio/heXz4g5tq09BdSUz9uiw+zjpp2dteBW
	mbmdX8DwiTvP2S9I9riU8660PsKiGIHdKHYbilCbVryYLD/G24A6+679xZ1VJ6BvAOmh4xoxQD8
	k9ppgd4SqfPksNHZSI7r269AnZfjv9TvcamEookIFl70rd0mLRCX81fDC2aIGRp/73MrHUxhEdl
	7n8zlAH7NJNxyGElchE1fc=
X-Received: by 2002:a17:90b:4cc4:b0:38e:101f:c867 with SMTP id 98e67ed59e1d1-3933b927a55mr29179740a91.18.1786994185075;
        Mon, 17 Aug 2026 12:16:25 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3933b62696bsm5485597a91.2.2026.08.17.12.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:16:24 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 5/6] selftests/bpf: libarena: Add a benchmark for malloc()/calloc()
Date: Mon, 17 Aug 2026 15:16:15 -0400
Message-ID: <20260817191616.11071-6-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817191616.11071-1-emil@etsalapatis.com>
References: <20260817191616.11071-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a benchmark for measuring the performance of the malloc()/calloc()
arena allocator calls. This is useful as a basic allocator performance
check that we can easily expand later. As with the regular arena
allocator, focus on sub-page allocations that cannot be satisfied
efficiently with the BPF arena page allocation code.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/Makefile          |  18 +-
 tools/testing/selftests/bpf/bench.c           |   6 +
 .../selftests/bpf/benchs/bench_libarena.c     | 210 ++++++++++++++++++
 .../bpf/benchs/run_bench_libarena.sh          |  31 +++
 tools/testing/selftests/bpf/libarena/Makefile |  30 ++-
 .../bpf/libarena/benchs/bench_malloc.bpf.c    |  51 +++++
 6 files changed, 334 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_libarena.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_libarena.sh
 create mode 100644 tools/testing/selftests/bpf/libarena/benchs/bench_malloc.bpf.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index d3655a706482..22e9eb16c151 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -826,18 +826,22 @@ LIBARENA_MAKE_ARGS = \
 		BPF_TARGET_ENDIAN="$(BPF_TARGET_ENDIAN)" \
 		Q="$(Q)"
 
-LIBARENA_BPF_DEPS := $(wildcard libarena/Makefile		\
-				 libarena/include/*		\
-				 libarena/include/libarena/*	\
-				 libarena/src/*			\
-				 libarena/selftests/*		\
-				 libarena/*.bpf.o)
+LIBARENA_COMMON_DEPS := $(wildcard libarena/Makefile		\
+				    libarena/include/*		\
+				    libarena/include/libarena/*	\
+				    libarena/src/*)
+LIBARENA_BPF_DEPS := $(LIBARENA_COMMON_DEPS) $(wildcard libarena/selftests/*)
+LIBARENA_BENCH_BPF_DEPS := $(LIBARENA_COMMON_DEPS) $(wildcard libarena/benchs/*)
 
 LIBARENA_SKEL := libarena/libarena.skel.h
+LIBARENA_BENCH_SKEL := libarena/libarena_bench.skel.h
 
 $(LIBARENA_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
 	+$(MAKE) -C libarena libarena.skel.h $(LIBARENA_MAKE_ARGS)
 
+$(LIBARENA_BENCH_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BENCH_BPF_DEPS) | $(LIBARENA_SKEL)
+	+$(MAKE) -C libarena benchmarks $(LIBARENA_MAKE_ARGS)
+
 ifneq ($(CLANG_HAS_ARENA_ASAN),)
 LIBARENA_ASAN_SKEL := libarena/libarena_asan.skel.h
 CFLAGS += -DHAS_BPF_ARENA_ASAN
@@ -987,6 +991,7 @@ $(OUTPUT)/bench_sockmap.o: $(OUTPUT)/bench_sockmap_prog.skel.h
 $(OUTPUT)/bench_lpm_trie_map.o: $(OUTPUT)/lpm_trie_bench.skel.h $(OUTPUT)/lpm_trie_map.skel.h
 $(OUTPUT)/bench_bpf_nop.o: $(OUTPUT)/bpf_nop_bench.skel.h bench_bpf_timing.h
 $(OUTPUT)/bench_xdp_lb.o: $(OUTPUT)/xdp_lb_bench.skel.h bench_bpf_timing.h
+$(OUTPUT)/bench_libarena.o: $(LIBARENA_BENCH_SKEL)
 $(OUTPUT)/bench_bpf_timing.o: bench_bpf_timing.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS += -lm
@@ -1014,6 +1019,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_bpf_timing.o \
 		 $(OUTPUT)/bench_bpf_nop.o \
 		 $(OUTPUT)/bench_xdp_lb.o \
+		 $(OUTPUT)/bench_libarena.o \
 		 $(OUTPUT)/usdt_1.o \
 		 $(OUTPUT)/usdt_2.o \
 		 #
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index b86b73456d3c..de672f61d4ab 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -288,6 +288,7 @@ extern struct argp bench_crypto_argp;
 extern struct argp bench_sockmap_argp;
 extern struct argp bench_lpm_trie_map_argp;
 extern struct argp bench_xdp_lb_argp;
+extern struct argp bench_libarena_argp;
 
 static const struct argp_child bench_parsers[] = {
 	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
@@ -306,6 +307,7 @@ static const struct argp_child bench_parsers[] = {
 	{ &bench_sockmap_argp, 0, "bpf sockmap benchmark", 0 },
 	{ &bench_lpm_trie_map_argp, 0, "LPM trie map benchmark", 0 },
 	{ &bench_xdp_lb_argp, 0, "XDP load-balancer benchmark", 0 },
+	{ &bench_libarena_argp, 0, "libarena allocator benchmark", 0 },
 	{},
 };
 
@@ -585,6 +587,8 @@ extern const struct bench bench_lpm_trie_delete;
 extern const struct bench bench_lpm_trie_free;
 extern const struct bench bench_bpf_nop;
 extern const struct bench bench_xdp_lb;
+extern const struct bench bench_libarena_malloc;
+extern const struct bench bench_libarena_calloc;
 
 static const struct bench *benchs[] = {
 	&bench_count_global,
@@ -669,6 +673,8 @@ static const struct bench *benchs[] = {
 	&bench_lpm_trie_free,
 	&bench_bpf_nop,
 	&bench_xdp_lb,
+	&bench_libarena_malloc,
+	&bench_libarena_calloc,
 };
 
 static void find_benchmark(void)
diff --git a/tools/testing/selftests/bpf/benchs/bench_libarena.c b/tools/testing/selftests/bpf/benchs/bench_libarena.c
new file mode 100644
index 000000000000..24e432244bf5
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_libarena.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <argp.h>
+#include <limits.h>
+#include <string.h>
+
+#include "bench.h"
+
+#include <libarena/common.h>
+#include <libarena/asan.h>
+#include <libarena/buddy.h>
+#include <libarena/userspace.h>
+
+#include "libarena/libarena_bench.skel.h"
+
+static struct {
+	__u64 alloc_size;
+	__u64 nallocs;
+} args = {
+	.alloc_size = 64,
+	.nallocs = 10000,
+};
+
+static struct {
+	struct libarena_bench *skel;
+	int bench_fd;
+	int reset_fd;
+} ctx;
+
+enum {
+	ARG_LIBARENA_ALLOC_SIZE = 12000,
+	ARG_LIBARENA_NALLOCS,
+};
+
+static const struct argp_option opts[] = {
+	{ "alloc_size", ARG_LIBARENA_ALLOC_SIZE, "BYTES", 0,
+	  "Size of each arena allocation" },
+	{ "nallocs", ARG_LIBARENA_NALLOCS, "ITERS", 0,
+	  "Number of allocation per measurement" },
+	{},
+};
+
+static error_t parse_arg(int key, char *arg, struct argp_state *state)
+{
+	unsigned long value;
+
+	switch (key) {
+	case ARG_LIBARENA_ALLOC_SIZE:
+		value = strtoull(arg, NULL, 10);
+		if (!value || value >= UINT_MAX) {
+			fprintf(stderr, "invalid alloc_size: %ld", value);
+			argp_usage(state);
+		}
+		args.alloc_size = value;
+		break;
+	case ARG_LIBARENA_NALLOCS:
+		args.nallocs = strtoull(arg, NULL, 10);
+		break;
+	default:
+		return ARGP_ERR_UNKNOWN;
+	}
+
+	return 0;
+}
+
+const struct argp bench_libarena_argp = {
+	.options = opts,
+	.parser = parse_arg,
+};
+
+static void validate(void)
+{
+	if (env.consumer_cnt != 0) {
+		fprintf(stderr, "benchmark doesn't support consumers\n");
+		exit(1);
+	}
+
+	if (env.producer_cnt != 1) {
+		fprintf(stderr, "benchmark supports exactly one producer\n");
+		exit(1);
+	}
+}
+
+static void setup_common(void)
+{
+	struct arena_alloc_reserve_args reserve_args = {
+		.nr_pages = ARENA_RESERVE_PAGES_DFL,
+	};
+	int err;
+
+	setup_libbpf();
+
+	ctx.skel = libarena_bench__open_and_load();
+	if (!ctx.skel) {
+		fprintf(stderr, "failed to open and load skeleton\n");
+		exit(1);
+	}
+
+	err = libarena_run_prog_args(
+		bpf_program__fd(ctx.skel->progs.arena_alloc_reserve),
+		&reserve_args, sizeof(reserve_args));
+	if (err) {
+		fprintf(stderr, "failed to reserve arena pages: %d\n", err);
+		exit(1);
+	}
+
+	err = libarena_run_prog(
+		bpf_program__fd(ctx.skel->progs.arena_buddy_reset));
+	if (err) {
+		fprintf(stderr, "failed to initialize arena allocator: %d\n", err);
+		exit(1);
+	}
+
+	ctx.skel->bss->bench_alloc_size = args.alloc_size;
+	ctx.skel->bss->bench_nallocs = args.nallocs;
+	ctx.reset_fd = bpf_program__fd(ctx.skel->progs.arena_buddy_reset);
+}
+
+static void malloc_setup(void)
+{
+	setup_common();
+	ctx.bench_fd = bpf_program__fd(ctx.skel->progs.bench_malloc);
+}
+
+static void calloc_setup(void)
+{
+	setup_common();
+	ctx.bench_fd = bpf_program__fd(ctx.skel->progs.bench_calloc);
+}
+
+static void *producer(void *input)
+{
+	int err;
+
+	while (true) {
+		err = libarena_run_prog(ctx.bench_fd);
+		if (err) {
+			fprintf(stderr, "libarena benchmark failed: %d\n", err);
+			exit(1);
+		}
+
+		err = libarena_run_prog(ctx.reset_fd);
+		if (err) {
+			fprintf(stderr, "libarena alloc reset failed: %d\n", err);
+			exit(1);
+		}
+	}
+
+	return NULL;
+}
+
+static void measure(struct bench_res *res)
+{
+	res->duration_ns = atomic_swap(&ctx.skel->bss->bench_duration_ns, 0);
+	res->hits = atomic_swap(&ctx.skel->bss->bench_hits, 0);
+}
+
+static void report_progress(int iter, struct bench_res *res, long delta_ns)
+{
+	double latency_ns = 0.0;
+
+	if (res->hits)
+		latency_ns = res->duration_ns / (double)res->hits;
+
+	printf("Iter %3d (%7.3lfus): latency %8.3lf ns/op (%ld allocations)\n",
+	       iter, (delta_ns - 1000000000) / 1000.0, latency_ns, res->hits);
+}
+
+static void report_final(struct bench_res res[], int res_cnt)
+{
+	unsigned long duration_ns = 0;
+	long hits = 0;
+	int i;
+
+	for (i = 0; i < res_cnt; i++) {
+		duration_ns += res[i].duration_ns;
+		hits += res[i].hits;
+	}
+
+	if (!hits || !res_cnt) {
+		printf("Summary: no runs measured\n");
+		return;
+	}
+
+	printf("Summary: %.3lf ns/op, %.0lf invocations for %u allocations/invocation)\n",
+	       duration_ns / (double)hits, hits / (double)res_cnt,
+	       ctx.skel->bss->bench_nallocs);
+}
+
+const struct bench bench_libarena_malloc = {
+	.name = "libarena-malloc",
+	.argp = &bench_libarena_argp,
+	.validate = validate,
+	.setup = malloc_setup,
+	.producer_thread = producer,
+	.measure = measure,
+	.report_progress = report_progress,
+	.report_final = report_final,
+};
+
+const struct bench bench_libarena_calloc = {
+	.name = "libarena-calloc",
+	.argp = &bench_libarena_argp,
+	.validate = validate,
+	.setup = calloc_setup,
+	.producer_thread = producer,
+	.measure = measure,
+	.report_progress = report_progress,
+	.report_final = report_final,
+};
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_libarena.sh b/tools/testing/selftests/bpf/benchs/run_bench_libarena.sh
new file mode 100755
index 000000000000..10afe4d52ebf
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/run_bench_libarena.sh
@@ -0,0 +1,31 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ./benchs/run_common.sh
+
+set -eufo pipefail
+
+RUN_BENCH="./bench -d3 -q"
+
+summarize_libarena()
+{
+	local bench="$1"
+	local summary
+
+	summary=$(printf '%s\n' "$2" | tail -n1)
+	summary=${summary#Summary: }
+	printf "%-20s %s\n" "$bench" "$summary"
+}
+
+header "libarena sequential malloc\n"
+
+for size in 16 64 256 1024 4096; do
+subtitle "allocation size: $size"
+printf "\t-------------------\n"
+	for nallocs in 10 50 100 500 1000 5000 10000; do
+		summarize_libarena "malloc:" \
+			"$($RUN_BENCH --alloc_size "$size" --nallocs "$nallocs" libarena-malloc)"
+		summarize_libarena "calloc:" \
+			"$($RUN_BENCH --alloc_size "$size" --nallocs "$nallocs" libarena-calloc)"
+	done
+done
diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testing/selftests/bpf/libarena/Makefile
index 5e2ab514805e..6d62eda34920 100644
--- a/tools/testing/selftests/bpf/libarena/Makefile
+++ b/tools/testing/selftests/bpf/libarena/Makefile
@@ -27,10 +27,17 @@ BPFDIR=$(abspath $(LIBARENA)/..)
 INCLUDE_DIR ?= $(BPFDIR)/tools/include
 LIBBPF_INCLUDE ?= $(INCLUDE_DIR)
 
-# Scan src/ and selftests/ to generate the final binaries
-LIBARENA_SOURCES = $(wildcard $(LIBARENA)/src/*.bpf.c) $(wildcard $(LIBARENA)/selftests/*.bpf.c)
-LIBARENA_OBJECTS = $(notdir $(LIBARENA_SOURCES:.bpf.c=.bpf.o))
-LIBARENA_OBJECTS_ASAN = $(notdir $(LIBARENA_SOURCES:.bpf.c=_asan.bpf.o))
+# Build selftests and benchmarks into separate BPF objects and skeletons.
+LIBARENA_CORE_SOURCES = $(wildcard $(LIBARENA)/src/*.bpf.c)
+LIBARENA_TEST_SOURCES = $(wildcard $(LIBARENA)/selftests/*.bpf.c)
+LIBARENA_BENCH_SOURCES = $(wildcard $(LIBARENA)/benchs/*.bpf.c)
+
+LIBARENA_OBJECTS = $(notdir $(LIBARENA_CORE_SOURCES:.bpf.c=.bpf.o) \
+			       $(LIBARENA_TEST_SOURCES:.bpf.c=.bpf.o))
+LIBARENA_OBJECTS_ASAN = $(notdir $(LIBARENA_CORE_SOURCES:.bpf.c=_asan.bpf.o) \
+				    $(LIBARENA_TEST_SOURCES:.bpf.c=_asan.bpf.o))
+LIBARENA_BENCH_OBJECTS = $(notdir $(LIBARENA_CORE_SOURCES:.bpf.c=.bpf.o) \
+				     $(LIBARENA_BENCH_SOURCES:.bpf.c=.bpf.o))
 
 INCLUDES = -I$(LIBARENA)/include -I$(BPFDIR)
 ifneq ($(INCLUDE_DIR),)
@@ -58,12 +65,19 @@ override BPF_CFLAGS += $(INCLUDES)
 CFLAGS = -O2 -no-pie
 CFLAGS += $(INCLUDES)
 
-vpath %.bpf.c $(LIBARENA)/src $(LIBARENA)/selftests
-vpath %.c $(LIBARENA)/src $(LIBARENA)/selftests
+vpath %.bpf.c $(LIBARENA)/src $(LIBARENA)/selftests $(LIBARENA)/benchs
+vpath %.c $(LIBARENA)/src $(LIBARENA)/selftests $(LIBARENA)/benchs
 
 skeletons: libarena.skel.h libarena_asan.skel.h
 .PHONY: skeletons
 
+benchmarks: libarena_bench.skel.h
+.PHONY: benchmarks
+
+libarena_bench.skel.h: libarena_bench.bpf.o
+	$(call msg,GEN-SKEL,libarena,$@)
+	$(Q)$(BPFTOOL) gen skeleton $< name "libarena_bench" > $@
+
 libarena_asan.skel.h: libarena_asan.bpf.o
 	$(call msg,GEN-SKEL,libarena,$@)
 	$(Q)$(BPFTOOL) gen skeleton $< name "libarena_asan" > $@
@@ -80,6 +94,10 @@ libarena.bpf.o: $(LIBARENA_OBJECTS)
 	$(call msg,GEN-OBJ,libarena,$@)
 	$(Q)$(BPFTOOL) gen object $@ $^
 
+libarena_bench.bpf.o: $(LIBARENA_BENCH_OBJECTS)
+	$(call msg,GEN-OBJ,libarena,$@)
+	$(Q)$(BPFTOOL) gen object $@ $^
+
 %_asan.bpf.o: %.bpf.c
 	$(call msg,CLNG-BPF,libarena,$@)
 	$(Q)$(CLANG) $(BPF_CFLAGS) $(ASAN_FLAGS) -DBPF_ARENA_ASAN $(BPF_TARGET_ENDIAN) -c $< -o $@
diff --git a/tools/testing/selftests/bpf/libarena/benchs/bench_malloc.bpf.c b/tools/testing/selftests/bpf/libarena/benchs/bench_malloc.bpf.c
new file mode 100644
index 000000000000..e06397dc9a40
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/benchs/bench_malloc.bpf.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <libarena/common.h>
+
+#include <libarena/asan.h>
+#include <libarena/buddy.h>
+
+u32 bench_alloc_size;
+u32 bench_nallocs;
+long bench_hits;
+long bench_duration_ns;
+
+SEC("syscall")
+int bench_malloc(void)
+{
+	void __arena *mem;
+	u64 start_ns;
+	u32 i;
+
+	start_ns = bpf_ktime_get_ns();
+	for (i = zero; i < bench_nallocs && can_loop; i++) {
+		mem = arena_malloc(bench_alloc_size);
+		if (!mem)
+			return -ENOMEM;
+	}
+
+	__sync_add_and_fetch(&bench_duration_ns,
+			     bpf_ktime_get_ns() - start_ns);
+	__sync_add_and_fetch(&bench_hits, i);
+	return 0;
+}
+
+SEC("syscall")
+int bench_calloc(void)
+{
+	void __arena *mem;
+	u64 start_ns;
+	u32 i;
+
+	start_ns = bpf_ktime_get_ns();
+	for (i = zero; i < bench_nallocs && can_loop; i++) {
+		mem = arena_calloc(1, bench_alloc_size);
+		if (!mem)
+			return -ENOMEM;
+	}
+
+	__sync_add_and_fetch(&bench_duration_ns,
+			     bpf_ktime_get_ns() - start_ns);
+	__sync_add_and_fetch(&bench_hits, i);
+	return 0;
+}
-- 
2.54.0

