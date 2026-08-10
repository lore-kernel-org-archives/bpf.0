Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB80A1531E8
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 05:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786341443; cv=none; b=YXrn5nEeLyn7mFNzi+XStnfi1LNjmeSxXb7uvJfe/0qgoKkmP2j61sz7gOWV+vNA2vW8tKbPI0RTPriQphY5K9uECca2UGfa442dC1T0q9v1RwGxoHwF0EsYsBRLPafkG+cJvqL5FTc4G8OkafSqyrBSADbOXuFil+Oa+IOTiQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786341443; c=relaxed/simple;
	bh=3wUaB3JiR3qrpw5LTw7FSBZil2mVvSd6Qevim/4qnHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iMgeV/HCd/UOE2GTIccGKJh7yS/ZHIGa5+722ISX5ukJZGZkntQOxWCHZevIdOp8+YUN0J7hvRlvgdOqgSSWxjl8akubdymlD2sVpjs4he0/rkNEqPSXTwpy1bSrrVgxniWcDJ3RdnFIlWb7g1wTwTY0WE9ZV/g/aac5r1IJcCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rm0tcQlP; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rm0tcQlP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786341428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ixRqwXrtRHyUXwEUPsPqV5qxylr+gSSEc5xTEuu2frQ=;
	b=Rm0tcQlPNAVZTS7sYepp2J7zWYis4pwqKcDrSVrk1hJxqT7O5fF9H9UKWzCrGt2hZ5kNog
	D6FWDulVlPyR4OVpwiYzsDhf530qiQ7bUzGQWdpDL6Ta76TZoXeiwl6TIzadscNMQm6jfg
	iJWMbRKH63lDXhSN5c1/4ReXvBBd0hA=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	shuah@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	chenguang.zhao@liux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH bpf-next] selftests/bpf: Add kptr-xchg benchmark
Date: Mon, 10 Aug 2026 13:57:09 +0800
Message-Id: <20260810055709.729203-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

Add a microbenchmark that repeatedly calls bpf_kptr_xchg() from an
fentry program. Architectures that advertise bpf_jit_supports_ptr_xchg()
inline the helper to BPF_XCHG; others keep the helper call. This bench
makes it easy to compare the two paths under the same workload.

Usage:
  sudo ./bench -d 30 -w 5 -p 1 kptr-xchg --nr_loops 256

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
Example results on LoongArch64 (helper vs inlined):

1. kptr xchg is helper:
	./bench -d 30 -w 5 -p 1 kptr-xchg --nr_loops 256
	Summary: throughput   68.612 ± 0.249 M ops/s ( 68.612M ops/prod), latency   14.575 ns/op

kptr xchg is inlined:
	./bench -d 30 -w 5 -p 1 kptr-xchg --nr_loops 256
	Summary: throughput   82.983 ± 0.268 M ops/s ( 82.983M ops/prod), latency   12.051 ns/op

This allows comparing the throughput difference.

2. To check whether bpf_kptr_xchg() was inlined:

bpftool prog show | grep -A4 -B1 'name benchmark'
       xlated 64B  jited 196B  memlock 16384B
   46: tracing  name benchmark  tag a9c8498a6197e8db  gpl
       loaded_at 2026-05-29T16:29:47+0800  uid 0
       xlated 232B  jited 380B  memlock 16384B  map_ids 8,10,9

bpftool prog dump xlated id 46 | grep -A6 -B6 -E 'xchg|atomic|call'

helper:
 ; __sync_add_and_fetch(&hits, i);
   13: (18) r2 = map[id:10][0]+0
   15: (db) lock *(u64 *)(r2 +0) += r1
 ; return 0;
   16: (b4) w0 = 0
   17: (95) exit
 ; old = bpf_kptr_xchg(&ptr, NULL);
   18: (18) r1 = map[id:9][0]+0
   20: (b7) r2 = 0
   21: (85) call bpf_kptr_xchg#244684 ------ there call helper function
 ; if (old)
   22: (15) if r0 == 0x0 goto pc-16
 ; bpf_obj_drop(old);
   23: (bf) r1 = r0
   24: (18) r2 = 0x0
   26: (85) call 0x900000000046760c#92204
   27: (05) goto pc-21

inlined:
 ; __sync_add_and_fetch(&hits, i);
  13: (18) r2 = map[id:10][0]+0
  15: (db) lock *(u64 *)(r2 +0) += r1
; return 0;
  16: (b4) w0 = 0
  17: (95) exit
; old = bpf_kptr_xchg(&ptr, NULL);
  18: (18) r1 = map[id:9][0]+0
  20: (b7) r2 = 0
  21: (bf) r0 = r2
  22: (db) r0 = atomic64_xchg((u64 *)(r1 +0), r0) ---- there inlining 'kptr xchg'
; if (old)
  23: (15) if r0 == 0x0 goto pc-17
; bpf_obj_drop(old);
  24: (bf) r1 = r0
  25: (18) r2 = 0x0
  27: (85) call 0x900000000046760e#92206
  28: (05) goto pc-22

 tools/testing/selftests/bpf/Makefile          |  2 +
 tools/testing/selftests/bpf/bench.c           |  2 +
 .../selftests/bpf/benchs/bench_kptr_xchg.c    | 96 +++++++++++++++++++
 .../selftests/bpf/progs/kptr_xchg_bench.c     | 49 ++++++++++
 4 files changed, 149 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_kptr_xchg.c
 create mode 100644 tools/testing/selftests/bpf/progs/kptr_xchg_bench.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index d3655a706482..76782b442aa9 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -988,6 +988,7 @@ $(OUTPUT)/bench_lpm_trie_map.o: $(OUTPUT)/lpm_trie_bench.skel.h $(OUTPUT)/lpm_tr
 $(OUTPUT)/bench_bpf_nop.o: $(OUTPUT)/bpf_nop_bench.skel.h bench_bpf_timing.h
 $(OUTPUT)/bench_xdp_lb.o: $(OUTPUT)/xdp_lb_bench.skel.h bench_bpf_timing.h
 $(OUTPUT)/bench_bpf_timing.o: bench_bpf_timing.h
+$(OUTPUT)/bench_kptr_xchg.o: $(OUTPUT)/kptr_xchg_bench.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS += -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o \
@@ -1014,6 +1015,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_bpf_timing.o \
 		 $(OUTPUT)/bench_bpf_nop.o \
 		 $(OUTPUT)/bench_xdp_lb.o \
+		 $(OUTPUT)/bench_kptr_xchg.o \
 		 $(OUTPUT)/usdt_1.o \
 		 $(OUTPUT)/usdt_2.o \
 		 #
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index b86b73456d3c..96cbd31088b8 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -585,6 +585,7 @@ extern const struct bench bench_lpm_trie_delete;
 extern const struct bench bench_lpm_trie_free;
 extern const struct bench bench_bpf_nop;
 extern const struct bench bench_xdp_lb;
+extern const struct bench bench_kptr_xchg;
 
 static const struct bench *benchs[] = {
 	&bench_count_global,
@@ -669,6 +670,7 @@ static const struct bench *benchs[] = {
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

