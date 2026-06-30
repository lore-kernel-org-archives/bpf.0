Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE4C33FE05;
	Tue, 30 Jun 2026 02:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782786208; cv=none; b=UOfii5IcK6m3F3NUh/i8o3KJP/eOWe3IpGzoh+++AvSIuQYwVEBq9cyxpS4HVDxgnVFzPclr/9FfaTyiaSuYHQ0MK4J2HEKzm4miplp8yvZfcqD4wFsrFGHRriM3q34mSPQV4t79UmdqTTh4c9WsnNXEv2NX96E0RWg2iD6vztU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782786208; c=relaxed/simple;
	bh=tILK3UZ5xjayGmPu6PGgRCBolLMcHF//tJUxYt9WR4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W/9RsjRoL+mXfiAVPLUgSm+nTRnGPklAf3KZ6hhoRLAUSUBKsY9r3MbKq5mRalL/9Jpo4EkAbBNthEYlqPx/0wNY/dzIQDFB6OHbXU+tjWNMGJXryhGOLS/OPWMUCNO7SXXZODHi4BqW9P9VBn9a7YXgP8sseZdfmVlktW74GKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxlniWKENqfHcZAA--.40525S3;
	Tue, 30 Jun 2026 10:23:18 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxbcKLKENqIHy4AA--.20751S2;
	Tue, 30 Jun 2026 10:23:08 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1] selftests/bpf: Add benchmark for tail call performance
Date: Tue, 30 Jun 2026 10:23:06 +0800
Message-ID: <20260630022306.10017-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxbcKLKENqIHy4AA--.20751S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3tr17KryfWryDuF17Cw45Arc_yoWDZF4Dpa
	yxG3s0krWrXF17Ca17Ww48JrW3Cr1kZry5Gw1FkryYvrsxJr92gF1IyFW8GF9xCrWrtry3
	ur92vF1Uua1rJ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXUUUUU=

Add a dedicated benchmark to measure the runtime performance and overhead
of tail calls. This helps developers detect performance regressions across
different kernel versions and optimization phases.

The benchmark sets up a standard tracepoint to intercept syscalls triggered
by a dedicated producer thread running a dead loop. The execution path is
strictly bounded by the tail call depth limit, safely preventing any core
lockup or infinite recursion risks.

To eliminate cacheline bouncing and global locking variance, Per-CPU array
maps are utilized to track execution hits across multiple cores.

To evaluate the JIT compiler architecture under complex control flows, it
interleaves direct tail calls with bpf2bpf tail calls.

This forces the tracking context at the target program's entry prologue to
toggle dynamically between a scalar count (0 to 33) and a massive kernel
pointer address, providing a robust micro-architectural stress test which
consists of:

1. tailcall_bench_main: The entry program filtering processes by PID, and
   introducing a high-frequency alternating execution path via the syscall
   arguments to switch between a direct tail call and a bpf2bpf tail call.
2. tailcall_bench_target: The final target destination hop which safely
   terminates the mixed execution flow and increments the step counter.

All functions utilize explicit "struct tracepoint_raw_syscalls_sys_enter"
context types to ensure strict type alignment and clear pointer provenance
for the BPF verifier.

Additionally, provide a test script run_bench_tailcall.sh to automate the
execution under strict core affinity and isolation for reliable profiling,
formatting the captured metrics directly into the performance report.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/Makefile          |  2 +
 tools/testing/selftests/bpf/bench.c           |  2 +
 .../selftests/bpf/benchs/bench_tailcall.c     | 90 +++++++++++++++++++
 .../bpf/benchs/run_bench_tailcall.sh          | 18 ++++
 .../selftests/bpf/progs/tailcall_bench.c      | 89 ++++++++++++++++++
 5 files changed, 201 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_tailcall.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_tailcall.sh
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bench.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b642ee489ea6..584504bc87a6 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -980,6 +980,7 @@ $(OUTPUT)/bench_lpm_trie_map.o: $(OUTPUT)/lpm_trie_bench.skel.h $(OUTPUT)/lpm_tr
 $(OUTPUT)/bench_bpf_nop.o: $(OUTPUT)/bpf_nop_bench.skel.h bench_bpf_timing.h
 $(OUTPUT)/bench_xdp_lb.o: $(OUTPUT)/xdp_lb_bench.skel.h bench_bpf_timing.h
 $(OUTPUT)/bench_bpf_timing.o: bench_bpf_timing.h
+$(OUTPUT)/bench_tailcall.o: $(OUTPUT)/tailcall_bench.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS += -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o \
@@ -1005,6 +1006,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_bpf_timing.o \
 		 $(OUTPUT)/bench_bpf_nop.o \
 		 $(OUTPUT)/bench_xdp_lb.o \
+		 $(OUTPUT)/bench_tailcall.o \
 		 $(OUTPUT)/usdt_1.o \
 		 $(OUTPUT)/usdt_2.o \
 		 #
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 3d9d2cd7764b..a79b86316d28 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -582,6 +582,7 @@ extern const struct bench bench_lpm_trie_delete;
 extern const struct bench bench_lpm_trie_free;
 extern const struct bench bench_bpf_nop;
 extern const struct bench bench_xdp_lb;
+extern const struct bench bench_tailcall;
 
 static const struct bench *benchs[] = {
 	&bench_count_global,
@@ -665,6 +666,7 @@ static const struct bench *benchs[] = {
 	&bench_lpm_trie_free,
 	&bench_bpf_nop,
 	&bench_xdp_lb,
+	&bench_tailcall,
 };
 
 static void find_benchmark(void)
diff --git a/tools/testing/selftests/bpf/benchs/bench_tailcall.c b/tools/testing/selftests/bpf/benchs/bench_tailcall.c
new file mode 100644
index 000000000000..a203017f5e28
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_tailcall.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/types.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <bpf/bpf.h>
+#include "bench.h"
+#include "tailcall_bench.skel.h"
+
+static struct ctx {
+	struct tailcall_bench *skel;
+	struct bpf_link *link;
+	int map_fd;
+	int ncpus;
+	unsigned int percpu_size;
+} ctx;
+
+static void tailcall_measure(struct bench_res *res)
+{
+	__u32 key = 0;
+	__u8 *values;
+	__u64 total_hits = 0;
+
+	values = calloc(ctx.ncpus, ctx.percpu_size);
+	if (!values)
+		return;
+
+	if (bpf_map_lookup_elem(ctx.map_fd, &key, values) != 0)
+		return;
+
+	for (int i = 0; i < ctx.ncpus; i++)
+		total_hits += *(__u64 *)(values + i * ctx.percpu_size);
+
+	res->hits = total_hits;
+	free(values);
+}
+
+static void *tailcall_producer(void *input)
+{
+	unsigned long arg = 0;
+
+	while (true) {
+		/* Toggle the argument between 0 and 1 on every iteration */
+		syscall(__NR_getpgid, arg & 1);
+		arg++;
+	}
+
+	return NULL;
+}
+
+static void tailcall_setup(void)
+{
+	int main_fd, target_fd, jmp_map_fd;
+	__u32 key1 = 1;
+
+	ctx.skel = tailcall_bench__open();
+	if (!ctx.skel)
+		exit(1);
+
+	ctx.skel->data->my_pid = getpid();
+	ctx.ncpus = libbpf_num_possible_cpus();
+
+	if (tailcall_bench__load(ctx.skel))
+		exit(1);
+
+	jmp_map_fd = bpf_map__fd(ctx.skel->maps.jmp_table);
+	ctx.map_fd = bpf_map__fd(ctx.skel->maps.pcpu_hits_map);
+	ctx.percpu_size = bpf_map__value_size(ctx.skel->maps.pcpu_hits_map);
+
+	if (ctx.map_fd < 0 || jmp_map_fd < 0)
+		exit(1);
+
+	main_fd = bpf_program__fd(ctx.skel->progs.tailcall_bench_main);
+	target_fd = bpf_program__fd(ctx.skel->progs.tailcall_bench_target);
+
+	/* Map key 1 directly to the final target program */
+	bpf_map_update_elem(jmp_map_fd, &key1, &target_fd, BPF_ANY);
+
+	ctx.link = bpf_program__attach(ctx.skel->progs.tailcall_bench_main);
+	if (!ctx.link)
+		exit(1);
+}
+
+const struct bench bench_tailcall = {
+	.name = "tailcall",
+	.setup = tailcall_setup,
+	.producer_thread = tailcall_producer,
+	.measure = tailcall_measure,
+	.report_progress = ops_report_progress,
+	.report_final = ops_report_final,
+};
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_tailcall.sh b/tools/testing/selftests/bpf/benchs/run_bench_tailcall.sh
new file mode 100755
index 000000000000..c687f34455e8
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/run_bench_tailcall.sh
@@ -0,0 +1,18 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# 1. Load the official common benchmark utilities
+source ./benchs/run_common.sh
+
+# 2. Strict error handling configurations
+set -eufo pipefail
+
+# 3. Use default bench binary path if not exported by the framework
+BENCH_BIN=${BENCH:-./bench}
+
+# 4. Run with strict core affinity and isolation for reliable profiling
+RUN_BENCH="numactl --physcpubind=0,2 --membind=0 nice -n -20 $BENCH_BIN -w5 -d20 -a"
+
+# 5. Capture the output string and pass it straight into summarize_ops
+# This satisfies the framework's internal parameter bounds without triggering set -u.
+summarize_ops "tailcall" "$($RUN_BENCH tailcall)"
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bench.c b/tools/testing/selftests/bpf/progs/tailcall_bench.c
new file mode 100644
index 000000000000..68a50c7b1d06
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_bench.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+/*
+ * Define the standard kernel tracepoint context structure explicitly
+ * to provide the Clang compiler with exact memory offsets.
+ */
+struct tracepoint_raw_syscalls_sys_enter {
+	unsigned long long unused;
+	long id;
+	unsigned long args[6];
+};
+
+__u32 my_pid SEC(".data") = 0;
+
+/* High-performance Per-CPU Array Map to eliminate global lock variance */
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} pcpu_hits_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 2);
+	__type(key, __u32);
+	__type(value, __u32);
+} jmp_table SEC(".maps");
+
+static __always_inline void increment_pcpu_counter(void)
+{
+	__u32 key = 0;
+	__u64 *val;
+
+	val = bpf_map_lookup_elem(&pcpu_hits_map, &key);
+	if (val) {
+		/* Lockless and stable per-CPU increment without cacheline bounce */
+		(*val)++;
+	}
+}
+
+/* Target Program: The final destination of the tail call */
+SEC("tracepoint/raw_syscalls/sys_enter")
+int tailcall_bench_target(struct tracepoint_raw_syscalls_sys_enter *ctx)
+{
+	increment_pcpu_counter();
+	return 0;
+}
+
+/* bpf2bpf Sub-function driving a tail call to pointerize the counter */
+static __noinline int bpf2bpf_tailcall(struct tracepoint_raw_syscalls_sys_enter *ctx)
+{
+	bpf_tail_call(ctx, &jmp_table, 1);
+	return 0;
+}
+
+/* Main program: Entry point for filtered syscall tracepoints */
+SEC("tracepoint/raw_syscalls/sys_enter")
+int tailcall_bench_main(struct tracepoint_raw_syscalls_sys_enter *ctx)
+{
+	__u32 current_pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (current_pid != my_pid)
+		return 0;
+
+	increment_pcpu_counter();
+
+	/*
+	 * Branch based on the syscall's first argument from user space.
+	 * Alternating between a direct tail call and a bpf2bpf tail call
+	 * forces the tail call counter at the target program's prologue to
+	 * swing dynamically between a pure scalar value and an inherited
+	 * kernel pointer.
+	 */
+	if (ctx->args[0] & 1) {
+		/* Path A: Direct tail call -> pure scalar value */
+		bpf_tail_call(ctx, &jmp_table, 1);
+	} else {
+		/* Path B: bpf2bpf tail call -> inherited kernel pointer */
+		bpf2bpf_tailcall(ctx);
+	}
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.42.0

