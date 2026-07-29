Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB6D37EFFB
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 02:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785292212; cv=none; b=oUmooCQt220QsEgsCpPQBmAUA+dXoMQQ8Cmd6ozGp/dFOSqBm6ndJAmF81wAmXS8E7nq69Ga6aUjk1HhfGQdz6o5H3FeGzxnRmfjUdbATyjXv0AciLpI5V3aMlvnuELXt1w+gwZLoSNXq4rHHP+L/3+FtKPZFNXtXeKSMf2/R60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785292212; c=relaxed/simple;
	bh=Dp5GppK4ZvVX+9JPvJB+9cuubEsYP4GcZG5AFv0g7BM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q2/ax1aCkCeCPNC3ANLXktYlJr4b8sHkYCO82ba0Xsg1yLGb1AoWAGfhoMkaTjKtVJfH4/hOpP9O0e8mm7/lIlZlAuCJbnxP6NtQ01oCnrxYINJC28ZdkJEWHUCPYQTdQaMrafS59ULra7AbbSUugjC/tYvGt9ib/oC7zv+taNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W+bBnAr5; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W+bBnAr5"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785292209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=53rSFkRK1meF5ukodk7lUVFAh+3imCSI4cF438grTO8=;
	b=W+bBnAr5on7CqNhsijDkum2f14Xg+CG76EhQKbEegjroovmn8LyHQC6ek+V/5uMXBFNVJk
	/4DcllPcQFz9ofTfoZmQmUsMWzDCHT7wgX1k9V4C6IYPva/oZVTfxClMzUVAmDb7075xxk
	1NO4/ZpjYcfBumSHu/Scr2tr8jC7iOk=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yangtiezhu@loongson.cn
Cc: hengqi.chen@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH v4 4/4] selftests/bpf: Add kptr-xchg benchmark
Date: Wed, 29 Jul 2026 10:28:37 +0800
Message-Id: <20260729022837.355549-5-chenguang.zhao@linux.dev>
In-Reply-To: <20260729022837.355549-1-chenguang.zhao@linux.dev>
References: <20260729022837.355549-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

Add a bpf selftest benchmark that exercises bpf_kptr_xchg() in a tight loop
so helper vs inlined JIT paths can be compared on supported architectures.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 tools/testing/selftests/bpf/Makefile          |  2 +
 tools/testing/selftests/bpf/bench.c           |  2 +
 .../selftests/bpf/benchs/bench_kptr_xchg.c    | 96 +++++++++++++++++++
 .../selftests/bpf/progs/kptr_xchg_bench.c     | 49 ++++++++++
 4 files changed, 149 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_kptr_xchg.c
 create mode 100644 tools/testing/selftests/bpf/progs/kptr_xchg_bench.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b642ee489ea6..6dfc81748584 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -980,6 +980,7 @@ $(OUTPUT)/bench_lpm_trie_map.o: $(OUTPUT)/lpm_trie_bench.skel.h $(OUTPUT)/lpm_tr
 $(OUTPUT)/bench_bpf_nop.o: $(OUTPUT)/bpf_nop_bench.skel.h bench_bpf_timing.h
 $(OUTPUT)/bench_xdp_lb.o: $(OUTPUT)/xdp_lb_bench.skel.h bench_bpf_timing.h
 $(OUTPUT)/bench_bpf_timing.o: bench_bpf_timing.h
+$(OUTPUT)/bench_kptr_xchg.o: $(OUTPUT)/kptr_xchg_bench.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS += -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o \
@@ -1005,6 +1006,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_bpf_timing.o \
 		 $(OUTPUT)/bench_bpf_nop.o \
 		 $(OUTPUT)/bench_xdp_lb.o \
+		 $(OUTPUT)/bench_kptr_xchg.o \
 		 $(OUTPUT)/usdt_1.o \
 		 $(OUTPUT)/usdt_2.o \
 		 #
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 3d9d2cd7764b..550290d6701a 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -582,6 +582,7 @@ extern const struct bench bench_lpm_trie_delete;
 extern const struct bench bench_lpm_trie_free;
 extern const struct bench bench_bpf_nop;
 extern const struct bench bench_xdp_lb;
+extern const struct bench bench_kptr_xchg;
 
 static const struct bench *benchs[] = {
 	&bench_count_global,
@@ -665,6 +666,7 @@ static const struct bench *benchs[] = {
 	&bench_lpm_trie_free,
 	&bench_bpf_nop,
 	&bench_xdp_lb,
+	&bench_kptr_xchg,
 };
 
 static void find_benchmark(void)
diff --git a/tools/testing/selftests/bpf/benchs/bench_kptr_xchg.c b/tools/testing/selftests/bpf/benchs/bench_kptr_xchg.c
new file mode 100644
index 000000000000..b8a0d346fda6
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_kptr_xchg.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026. Loongson Technology Corporation Limited */
+#include <argp.h>
+#include "bench.h"
+#include "kptr_xchg_bench.skel.h"
+
+static struct ctx {
+	struct kptr_xchg_bench *skel;
+} ctx;
+
+static struct {
+	__u32 nr_loops;
+} args = {
+	.nr_loops = 256,
+};
+
+enum {
+	ARG_NR_LOOPS = 7000,
+};
+
+static const struct argp_option opts[] = {
+	{ "nr_loops", ARG_NR_LOOPS, "nr_loops", 0,
+	  "Set number of bpf_kptr_xchg() calls per trigger"},
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
+static const struct argp bench_kptr_xchg_argp = {
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
+	ctx.skel = kptr_xchg_bench__open_and_load();
+	if (!ctx.skel) {
+		fprintf(stderr, "failed to open skeleton\n");
+		exit(1);
+	}
+
+	ctx.skel->data->nr_loops = args.nr_loops;
+
+	link = bpf_program__attach(ctx.skel->progs.benchmark);
+	if (!link) {
+		fprintf(stderr, "failed to attach program!\n");
+		exit(1);
+	}
+}
+
+const struct bench bench_kptr_xchg = {
+	.name = "kptr-xchg",
+	.argp = &bench_kptr_xchg_argp,
+	.validate = validate,
+	.setup = setup,
+	.producer_thread = producer,
+	.measure = measure,
+	.report_progress = ops_report_progress,
+	.report_final = ops_report_final,
+};
diff --git a/tools/testing/selftests/bpf/progs/kptr_xchg_bench.c b/tools/testing/selftests/bpf/progs/kptr_xchg_bench.c
new file mode 100644
index 000000000000..363883073e2c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kptr_xchg_bench.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026. Loongson Technology Corporation Limited */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define MAX_XCHG_LOOPS 4096
+
+struct bin_data {
+	char blob[32];
+};
+
+#define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
+
+private(kptr) struct bin_data __kptr *ptr;
+u32 nr_loops = 256;
+long hits;
+
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int benchmark(void *ctx)
+{
+	struct bin_data *old;
+	u32 i;
+
+	for (i = 0; i < MAX_XCHG_LOOPS; i++) {
+		if (i >= nr_loops)
+			break;
+
+		old = bpf_kptr_xchg(&ptr, NULL);
+		if (old)
+			bpf_obj_drop(old);
+	}
+
+	__sync_add_and_fetch(&hits, i);
+	return 0;
+}
+
+/*
+ * BTF FUNC records are not generated for kfuncs referenced only through
+ * optimized paths. Keep bpf_obj_drop() visible to libbpf's kfunc linker.
+ */
+void __btf_root(void)
+{
+	bpf_obj_drop(NULL);
+}
-- 
2.25.1

