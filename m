Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5D93B2FC8
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 23:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777332224; cv=none; b=o4Xs2HPGpgiWeTMMGxJtSizHPjOGM9SJGIIVg/wVwu16KPxAr0GKFYAuVIlThm6ZLOluB8ymdQes+x+W2ePjvUG5TFIyDu1AFyvo2ztyuRk9kkIimzFfeV0ZbUYBkIt6QWv3Jd+YmwqgoQPeK8J0DGqezhg41eCtNpRo7WXPpf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777332224; c=relaxed/simple;
	bh=0bbeEOXW0GRgSLYb1vWoEmVCrDjKNmvtmKnd6YkNf8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfTLwttTxVoke/6pnTTZWOMqh3hbP+I5nOcksss//u+JS9kdRArhzdQW6v0zPwHVjqrYfTggBkrfJy6vBPa2gKcpE7paxgTj95aLPTMjS76mnm+f6UZZ7bBEXYOZ58oXLqv1LZrhL/VmPAshkwhUWmNcZmtPDyJbePUdxunkdYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpJm8m5B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpJm8m5B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584ECC19425;
	Mon, 27 Apr 2026 23:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777332224;
	bh=0bbeEOXW0GRgSLYb1vWoEmVCrDjKNmvtmKnd6YkNf8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MpJm8m5B/R6qfrcek5TDyPHfGpNr28g0hmMpz76n1j+KqqWxPYvC8dtd6h9y0wNE2
	 VM3/1D+K0QduOev2kxNY+Q3Wg004CAOEXjv0CcgAC/qgrmnq4fHj5NfTztb+/sYQoR
	 /yv/05D/nwT32BBZc5U/Chf8gddUj+zTl1gfW9rpBzlqBRdd8zMC3CeWpQ/pAuZPwF
	 KEHwrp00iIU1Qn8LOUvQHbxVu9w1g8pgew0PLsqXIZmwCyZr6EB04TOjBjYRSI1kQt
	 Il9vF8LdPDrfPSUmYykDi9BdLdhwkhYL9Tt293PHHokY0ljpQ6PKyg7L6ojH1B50Ug
	 A8dxi3cfiJagQ==
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
Subject: [PATCH bpf-next 3/7] selftests/bpf: Add bpf-nop benchmark for timing overhead baseline
Date: Mon, 27 Apr 2026 16:23:00 -0700
Message-ID: <20260427232313.1582588-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260427232313.1582588-1-puranjay@kernel.org>
References: <20260427232313.1582588-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a minimal benchmark that measures the overhead of the batch-timing
infrastructure itself. The BPF program runs an empty BENCH_BPF_LOOP body
(~1.5-2 ns/op), establishing the floor cost that all timing-library
benchmarks include.

[root@virtme-ng tools/testing/selftests/bpf]# sudo ./bench -a -p8 bpf-nop
Setting up benchmark 'bpf-nop'...
Benchmark 'bpf-nop' started.
bpf-nop: median 1.82 ns/op, stddev 0.01, p99 1.86 (1754 samples)

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |  2 +
 tools/testing/selftests/bpf/bench.c           |  2 +
 .../selftests/bpf/benchs/bench_bpf_nop.c      | 84 +++++++++++++++++++
 .../selftests/bpf/progs/bpf_nop_bench.c       | 14 ++++
 4 files changed, 102 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_nop.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_nop_bench.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 3d516f10f29e..97f9fbd41244 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -906,6 +906,7 @@ $(OUTPUT)/bench_htab_mem.o: $(OUTPUT)/htab_mem_bench.skel.h
 $(OUTPUT)/bench_bpf_crypto.o: $(OUTPUT)/crypto_bench.skel.h
 $(OUTPUT)/bench_sockmap.o: $(OUTPUT)/bench_sockmap_prog.skel.h
 $(OUTPUT)/bench_lpm_trie_map.o: $(OUTPUT)/lpm_trie_bench.skel.h $(OUTPUT)/lpm_trie_map.skel.h
+$(OUTPUT)/bench_bpf_nop.o: $(OUTPUT)/bpf_nop_bench.skel.h bench_bpf_timing.h
 $(OUTPUT)/bench_bpf_timing.o: bench_bpf_timing.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS += -lm
@@ -930,6 +931,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_sockmap.o \
 		 $(OUTPUT)/bench_lpm_trie_map.o \
 		 $(OUTPUT)/bench_bpf_timing.o \
+		 $(OUTPUT)/bench_bpf_nop.o \
 		 $(OUTPUT)/usdt_1.o \
 		 $(OUTPUT)/usdt_2.o \
 		 #
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 47a4e72208d6..1696de5d6780 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -575,6 +575,7 @@ extern const struct bench bench_lpm_trie_insert;
 extern const struct bench bench_lpm_trie_update;
 extern const struct bench bench_lpm_trie_delete;
 extern const struct bench bench_lpm_trie_free;
+extern const struct bench bench_bpf_nop;
 
 static const struct bench *benchs[] = {
 	&bench_count_global,
@@ -653,6 +654,7 @@ static const struct bench *benchs[] = {
 	&bench_lpm_trie_update,
 	&bench_lpm_trie_delete,
 	&bench_lpm_trie_free,
+	&bench_bpf_nop,
 };
 
 static void find_benchmark(void)
diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_nop.c b/tools/testing/selftests/bpf/benchs/bench_bpf_nop.c
new file mode 100644
index 000000000000..e2d8c2ccf384
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_bpf_nop.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include "bench.h"
+#include "bench_bpf_timing.h"
+#include "bpf_nop_bench.skel.h"
+#include "bpf_util.h"
+
+static struct ctx {
+	struct bpf_nop_bench *skel;
+	struct bpf_bench_timing timing;
+	int prog_fd;
+} ctx;
+
+static void nop_validate(void)
+{
+	if (env.consumer_cnt != 0) {
+		fprintf(stderr, "benchmark doesn't support consumers\n");
+		exit(1);
+	}
+}
+
+static void nop_run_once(void *unused __always_unused)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	bpf_prog_test_run_opts(ctx.prog_fd, &topts);
+}
+
+static void nop_setup(void)
+{
+	struct bpf_nop_bench *skel;
+	int err;
+
+	setup_libbpf();
+
+	skel = bpf_nop_bench__open();
+	if (!skel) {
+		fprintf(stderr, "failed to open skeleton\n");
+		exit(1);
+	}
+
+	err = bpf_nop_bench__load(skel);
+	if (err) {
+		fprintf(stderr, "failed to load skeleton: %s\n", strerror(-err));
+		bpf_nop_bench__destroy(skel);
+		exit(1);
+	}
+
+	ctx.skel = skel;
+	ctx.prog_fd = bpf_program__fd(skel->progs.bench_nop);
+
+	BENCH_TIMING_INIT(&ctx.timing, skel, 0);
+	bpf_bench_calibrate(&ctx.timing, nop_run_once, NULL);
+
+	env.duration_sec = 600;
+}
+
+static void *nop_producer(void *input)
+{
+	while (true)
+		nop_run_once(NULL);
+
+	return NULL;
+}
+
+static void nop_measure(struct bench_res *res)
+{
+	bpf_bench_timing_measure(&ctx.timing, res);
+}
+
+static void nop_report_final(struct bench_res res[], int res_cnt)
+{
+	bpf_bench_timing_report(&ctx.timing, "bpf-nop", NULL);
+}
+
+const struct bench bench_bpf_nop = {
+	.name		= "bpf-nop",
+	.validate	= nop_validate,
+	.setup		= nop_setup,
+	.producer_thread = nop_producer,
+	.measure	= nop_measure,
+	.report_final	= nop_report_final,
+};
diff --git a/tools/testing/selftests/bpf/progs/bpf_nop_bench.c b/tools/testing/selftests/bpf/progs/bpf_nop_bench.c
new file mode 100644
index 000000000000..01ed284c1bb3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_nop_bench.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bench_bpf_timing.bpf.h"
+
+SEC("syscall")
+int bench_nop(void *ctx)
+{
+	return BENCH_BPF_LOOP(0, ({}));
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.52.0

