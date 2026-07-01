Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239F21C3BF7;
	Wed,  1 Jul 2026 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913537; cv=none; b=m9sjObg8h33PeM5KWbs5f0dKBV5emBp56W8Oa+P3kpgjwyGEoJTrNXb0Zn2ZcyV/xzKzstXfDD2ZRl/ygsjSAwdu9DuPbdPp7cPJmE7fL/BPpxDFNbZ1/qWBXoFoLxd2Oi5wn97hWSPRArOCaspWYJSddlOxjzsi54PK8M4NANo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913537; c=relaxed/simple;
	bh=Tnz66dvzdp75I9XjRKodS3T5EMpKXqWFJ5JH0SdZ/+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LYAArFjlA5EUaejR7Z51eeU7U/BA4vjulQbVJxtVLnRgOsEPpLYRnL78co/DqQO6uvDu4XDw/VjPIe5zWR4AWQ6UiKMou7Pw6EGJfbfuhrX1EFxdUWvOitfHqPLU7F8MLH2S/5AHztXflstXyDwg4XO5I/v8keOlRuWtZn39uwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOuAqmjI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOuAqmjI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479B51F000E9;
	Wed,  1 Jul 2026 13:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782913536;
	bh=mMPCOqNasq7RsP665EcudwSEfAFtZ4jKlvU4b01oet0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TOuAqmjI1MKQC/y035vDMb0DAK8nsvHad+c7goBre6nK+XtLpfQ6F0CGzuFTF2lfp
	 x6atW8f8BNQNThjJ1hp/i7aCN5TIIpqa4RZ/bDTlA8h4rgpZecC/XdY3P/QKxebK8X
	 E3Ka5XoA2LIUbNHC3bI0cE0na2VH0GLrxMappzR3XexAhz3G64XFJJg8s/8jAxYjGx
	 VJm/yk40jurIkIsxfJ/qUpk46IixYuqM7V/+3DzAgxZOsX4HeB2/Bo4yqRO60iETfQ
	 5KFsV1ZzNujJWWjwbK+xujEhBIYDUTUht55DnBySwM4u5Ys+rUWKIKY3t3qB1ywJkc
	 SWYr7HY8EFn/Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RFC PATCH 1/4] tools/tracing: Add fetcharg performance micro-benchmark
Date: Wed,  1 Jul 2026 22:45:32 +0900
Message-ID: <178291353202.1566898.1316084678106262789.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178291352217.1566898.14481561093843379745.stgit@devnote2>
References: <178291352217.1566898.14481561093843379745.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add a benchmark test module (fetcharg_bench) and bench_fetcharg.sh script
to measure the execution overhead of fetchargs across kprobe, fprobe,
and eprobe configurations.

The benchmark runs for a baseline (no probe events), 0-arguments,
1-argument, 2-arguments, and 3-arguments configurations, calculating
the estimated overhead in nanoseconds. It also supports a --debug option
to dump registered dynamic events.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/tracing/benchmark/Kbuild                 |    3 
 tools/tracing/benchmark/Makefile               |   12 +
 tools/tracing/benchmark/bench_fetcharg.sh      |  195 ++++++++++++++++++++++++
 tools/tracing/benchmark/fetcharg_bench.c       |   98 ++++++++++++
 tools/tracing/benchmark/fetcharg_bench_trace.h |   37 +++++
 5 files changed, 345 insertions(+)
 create mode 100644 tools/tracing/benchmark/Kbuild
 create mode 100644 tools/tracing/benchmark/Makefile
 create mode 100755 tools/tracing/benchmark/bench_fetcharg.sh
 create mode 100644 tools/tracing/benchmark/fetcharg_bench.c
 create mode 100644 tools/tracing/benchmark/fetcharg_bench_trace.h

diff --git a/tools/tracing/benchmark/Kbuild b/tools/tracing/benchmark/Kbuild
new file mode 100644
index 000000000000..4c31b26ca51c
--- /dev/null
+++ b/tools/tracing/benchmark/Kbuild
@@ -0,0 +1,3 @@
+obj-m += fetcharg_bench.o
+
+ccflags-y += -I$(src)
diff --git a/tools/tracing/benchmark/Makefile b/tools/tracing/benchmark/Makefile
new file mode 100644
index 000000000000..bf5b3cbaff03
--- /dev/null
+++ b/tools/tracing/benchmark/Makefile
@@ -0,0 +1,12 @@
+ifeq ($(O),)
+KDIR ?= /lib/modules/$(shell uname -r)/build
+else
+KDIR := $(O)
+endif
+MDIR := $(CURDIR)
+
+all:
+	$(MAKE) -C $(KDIR) M=$(MDIR) modules
+
+clean:
+	$(MAKE) -C $(KDIR) M=$(MDIR) clean
diff --git a/tools/tracing/benchmark/bench_fetcharg.sh b/tools/tracing/benchmark/bench_fetcharg.sh
new file mode 100755
index 000000000000..0b2a2b8a896e
--- /dev/null
+++ b/tools/tracing/benchmark/bench_fetcharg.sh
@@ -0,0 +1,195 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# description: Benchmark fetcharg performance (baseline vs kprobe vs fprobe vs eprobe)
+
+DEBUG=0
+while [[ $# -gt 0 ]]; do
+    case "$1" in
+        --debug|-d)
+            DEBUG=1
+            shift
+            ;;
+        *)
+            echo "Unknown option: $1"
+            echo "Usage: $0 [--debug|-d]"
+            exit 1
+            ;;
+    esac
+done
+
+DEBUGFS_MOUNT=$(grep ^debugfs /proc/mounts | awk '{print $2}')
+if [ -z "$DEBUGFS_MOUNT" ]; then
+    mount -t debugfs nodev /sys/kernel/debug
+    DEBUGFS_MOUNT="/sys/kernel/debug"
+fi
+
+TRACEFS_MOUNT=$(grep ^tracefs /proc/mounts | awk '{print $2}')
+if [ -z "$TRACEFS_MOUNT" ]; then
+    mount -t tracefs nodev /sys/kernel/tracing
+    TRACEFS_MOUNT="/sys/kernel/tracing"
+fi
+
+MOD_NAME="fetcharg_bench"
+MOD_FILE="./${MOD_NAME}.ko"
+
+if [ ! -f "$MOD_FILE" ]; then
+    echo "Module $MOD_FILE not found. Please run 'make' first."
+    exit 1
+fi
+
+rmmod $MOD_NAME 2>/dev/null
+insmod $MOD_FILE || { echo "Failed to load $MOD_FILE"; exit 1; }
+
+TRIGGER_FILE="${DEBUGFS_MOUNT}/fetcharg_benchmark/trigger"
+
+if [ ! -f "$TRIGGER_FILE" ]; then
+    echo "Trigger file $TRIGGER_FILE not found."
+    rmmod $MOD_NAME
+    exit 1
+fi
+
+DYN_EVENTS="${TRACEFS_MOUNT}/dynamic_events"
+
+# Helper to clear events
+clear_events() {
+    echo 0 > "${TRACEFS_MOUNT}/events/enable"
+    echo > "$DYN_EVENTS"
+}
+
+run_bench() {
+    if [ "$DEBUG" = "1" ]; then
+        echo "=== [DEBUG] dynamic_events ===" >&2
+        cat "$DYN_EVENTS" >&2
+        echo "==============================" >&2
+    fi
+    cat "$TRIGGER_FILE"
+}
+
+calc_overhead() {
+    local lps=$1
+    local base_lps=$2
+    if [ -z "$lps" ] || [ -z "$base_lps" ] || [ "$lps" = "-" ] || [ "$base_lps" = "-" ]; then
+        echo "-"
+        return
+    fi
+    awk -v lps="$lps" -v base_lps="$base_lps" 'BEGIN {
+        if (lps == 0 || base_lps == 0) {
+            print "-"
+            exit
+        }
+        t = 1000000000.0 / lps
+        t_base = 1000000000.0 / base_lps
+        diff = t - t_base
+        printf "%.2f ns", diff
+    }'
+}
+
+echo "Running Fetcharg Micro Benchmark..."
+echo "Please wait, this may take a few seconds..."
+
+# Baseline
+clear_events
+baseline=$(run_bench)
+
+# Kprobe
+clear_events
+echo "p:bench_kprobe fetcharg_bench_target" >> "$DYN_EVENTS"
+echo 1 > "${TRACEFS_MOUNT}/events/kprobes/bench_kprobe/enable"
+kprobe_0=$(run_bench)
+
+clear_events
+echo "p:bench_kprobe fetcharg_bench_target a=\$arg1" >> "$DYN_EVENTS"
+echo 1 > "${TRACEFS_MOUNT}/events/kprobes/bench_kprobe/enable"
+kprobe_1=$(run_bench)
+
+clear_events
+echo "p:bench_kprobe fetcharg_bench_target a=\$arg1 b=+0(+0(\$arg2)):u32" >> "$DYN_EVENTS"
+echo 1 > "${TRACEFS_MOUNT}/events/kprobes/bench_kprobe/enable"
+kprobe_2=$(run_bench)
+
+clear_events
+echo "p:bench_kprobe fetcharg_bench_target a=\$arg1 b=+0(+0(\$arg2)):u32 c=+0(\$arg3):u32" \
+    >> "$DYN_EVENTS"
+echo 1 > "${TRACEFS_MOUNT}/events/kprobes/bench_kprobe/enable"
+kprobe_3=$(run_bench)
+
+# Fprobe
+clear_events
+echo "f:bench_fprobe fetcharg_bench_target" >> "$DYN_EVENTS"
+echo 1 > "${TRACEFS_MOUNT}/events/fprobes/bench_fprobe/enable"
+fprobe_0=$(run_bench)
+
+clear_events
+echo "f:bench_fprobe fetcharg_bench_target a=\$arg1" >> "$DYN_EVENTS"
+echo 1 > "${TRACEFS_MOUNT}/events/fprobes/bench_fprobe/enable"
+fprobe_1=$(run_bench)
+
+clear_events
+echo "f:bench_fprobe fetcharg_bench_target a=\$arg1 b=+0(+0(\$arg2)):u32" >> "$DYN_EVENTS"
+echo 1 > "${TRACEFS_MOUNT}/events/fprobes/bench_fprobe/enable"
+fprobe_2=$(run_bench)
+
+clear_events
+echo "f:bench_fprobe fetcharg_bench_target a=\$arg1 b=+0(+0(\$arg2)):u32 c=+0(\$arg3):u32" \
+    >> "$DYN_EVENTS"
+echo 1 > "${TRACEFS_MOUNT}/events/fprobes/bench_fprobe/enable"
+fprobe_3=$(run_bench)
+
+# Eprobe
+clear_events
+echo "e:bench_eprobe fetcharg_bench/fetcharg_bench_event" >> "$DYN_EVENTS"
+echo 1 > "${TRACEFS_MOUNT}/events/eprobes/bench_eprobe/enable"
+echo 1 > "${TRACEFS_MOUNT}/events/fetcharg_bench/fetcharg_bench_event/enable"
+eprobe_0=$(run_bench)
+
+clear_events
+echo "e:bench_eprobe fetcharg_bench/fetcharg_bench_event a=\$a" >> "$DYN_EVENTS"
+echo 1 > "${TRACEFS_MOUNT}/events/eprobes/bench_eprobe/enable"
+echo 1 > "${TRACEFS_MOUNT}/events/fetcharg_bench/fetcharg_bench_event/enable"
+eprobe_1=$(run_bench)
+
+clear_events
+echo "e:bench_eprobe fetcharg_bench/fetcharg_bench_event a=\$a b=+0(+0(\$b_ptr)):u32" \
+    >> "$DYN_EVENTS"
+echo 1 > "${TRACEFS_MOUNT}/events/eprobes/bench_eprobe/enable"
+echo 1 > "${TRACEFS_MOUNT}/events/fetcharg_bench/fetcharg_bench_event/enable"
+eprobe_2=$(run_bench)
+
+clear_events
+echo "e:bench_eprobe fetcharg_bench/fetcharg_bench_event a=\$a b=+0(+0(\$b_ptr)):u32 c=+0(\$c_ptr):u32" \
+    >> "$DYN_EVENTS"
+echo 1 > "${TRACEFS_MOUNT}/events/eprobes/bench_eprobe/enable"
+echo 1 > "${TRACEFS_MOUNT}/events/fetcharg_bench/fetcharg_bench_event/enable"
+eprobe_3=$(run_bench)
+
+echo "--------------------------------------------------------------------------------"
+echo "Configuration      0 Fetchargs       1 Fetcharg        2 Fetchargs        3 Fetchargs"
+echo "--------------------------------------------------------------------------------"
+printf "%-18s %15s %15s %18s %18s loops/sec\n" "Baseline" "$baseline" "-" "-" "-"
+printf "%-18s %15s %15s %18s %18s overhead\n"  " "        "-" "-" "-" "-"
+printf "%-18s %15s %15s %18s %18s loops/sec\n" \
+    "Kprobe" "$kprobe_0" "$kprobe_1" "$kprobe_2" "$kprobe_3"
+printf "%-18s %15s %15s %18s %18s overhead\n" " " \
+    "$(calc_overhead $kprobe_0 $baseline)" \
+    "$(calc_overhead $kprobe_1 $kprobe_0)" \
+    "$(calc_overhead $kprobe_2 $kprobe_0)" \
+    "$(calc_overhead $kprobe_3 $kprobe_0)"
+printf "%-18s %15s %15s %18s %18s loops/sec\n" \
+    "Fprobe" "$fprobe_0" "$fprobe_1" "$fprobe_2" "$fprobe_3"
+printf "%-18s %15s %15s %18s %18s overhead\n" " " \
+    "$(calc_overhead $fprobe_0 $baseline)" \
+    "$(calc_overhead $fprobe_1 $fprobe_0)" \
+    "$(calc_overhead $fprobe_2 $fprobe_0)" \
+    "$(calc_overhead $fprobe_3 $fprobe_0)"
+printf "%-18s %15s %15s %18s %18s loops/sec\n" \
+    "Eprobe" "$eprobe_0" "$eprobe_1" "$eprobe_2" "$eprobe_3"
+printf "%-18s %15s %15s %18s %18s overhead\n" " " \
+    "$(calc_overhead $eprobe_0 $baseline)" \
+    "$(calc_overhead $eprobe_1 $eprobe_0)" \
+    "$(calc_overhead $eprobe_2 $eprobe_0)" \
+    "$(calc_overhead $eprobe_3 $eprobe_0)"
+echo "--------------------------------------------------------------------------------"
+
+clear_events
+rmmod $MOD_NAME
+exit 0
diff --git a/tools/tracing/benchmark/fetcharg_bench.c b/tools/tracing/benchmark/fetcharg_bench.c
new file mode 100644
index 000000000000..af18183c1f5d
--- /dev/null
+++ b/tools/tracing/benchmark/fetcharg_bench.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/module.h>
+#include <linux/ktime.h>
+#include <linux/debugfs.h>
+#include <linux/uaccess.h>
+
+#define CREATE_TRACE_POINTS
+#include "fetcharg_bench_trace.h"
+
+static noinline int fetcharg_bench_target(int a, int **b, char *c)
+{
+	/* Prevent compiler from optimizing the loop out entirely */
+	asm volatile ("" : : "r"(a), "r"(b), "r"(c) : "memory");
+	trace_fetcharg_bench_event(a, b, c);
+	return a + **b;
+}
+
+/* Indirect pointer to prevent inlining */
+static int (*bench_func_ptr)(int, int **, char *) = fetcharg_bench_target;
+
+#define BENCH_ITERATIONS 1000000
+
+static ssize_t fetcharg_bench_read(struct file *file, char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
+	char buf[64];
+	int len;
+	u64 start, current_time;
+	u64 elapsed;
+	u64 loops_per_sec;
+	int dummy = 0;
+	int a = 1;
+	int b_val = 2;
+	int *b_ptr = &b_val;
+	int **b = &b_ptr;
+	char c[] = "benchmark";
+	int i;
+
+	if (*ppos > 0)
+		return 0; /* EOF */
+
+	start = ktime_get_ns();
+	for (i = 0; i < BENCH_ITERATIONS; i++)
+		dummy += bench_func_ptr(a, b, c);
+	current_time = ktime_get_ns();
+
+	elapsed = current_time - start;
+	loops_per_sec = ((u64)BENCH_ITERATIONS * NSEC_PER_SEC) / elapsed;
+
+	len = snprintf(buf, sizeof(buf), "%llu\n", loops_per_sec);
+	if (len < 0)
+		return len;
+
+	if (copy_to_user(user_buf, buf, len))
+		return -EFAULT;
+
+	*ppos += len;
+
+	/*
+	 * Use 'dummy' to ensure the compiler doesn't optimize out
+	 * the call completely, though the asm volatile helps too.
+	 */
+	if (dummy == 0xdeadbeef)
+		pr_info("dummy=%d\n", dummy);
+
+	return len;
+}
+
+static const struct file_operations fetcharg_bench_fops = {
+	.read		= fetcharg_bench_read,
+	.open		= simple_open,
+	.llseek		= default_llseek,
+};
+
+static struct dentry *bench_dir;
+
+static int __init fetcharg_bench_init(void)
+{
+	bench_dir = debugfs_create_dir("fetcharg_benchmark", NULL);
+	if (!bench_dir)
+		return -ENOMEM;
+
+	debugfs_create_file("trigger", 0444, bench_dir, NULL, &fetcharg_bench_fops);
+
+	return 0;
+}
+
+static void __exit fetcharg_bench_exit(void)
+{
+	debugfs_remove_recursive(bench_dir);
+}
+
+module_init(fetcharg_bench_init);
+module_exit(fetcharg_bench_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Antigravity");
+MODULE_DESCRIPTION("Fetcharg performance benchmark test module");
diff --git a/tools/tracing/benchmark/fetcharg_bench_trace.h b/tools/tracing/benchmark/fetcharg_bench_trace.h
new file mode 100644
index 000000000000..6560f62337e3
--- /dev/null
+++ b/tools/tracing/benchmark/fetcharg_bench_trace.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM fetcharg_bench
+
+#if !defined(_FETCHARG_BENCH_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _FETCHARG_BENCH_TRACE_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(fetcharg_bench_event,
+
+	TP_PROTO(int a, int **b, char *c),
+
+	TP_ARGS(a, b, c),
+
+	TP_STRUCT__entry(
+		__field(int, a)
+		__field(int **, b_ptr)
+		__field(char *, c_ptr)
+	),
+
+	TP_fast_assign(
+		__entry->a = a;
+		__entry->b_ptr = b;
+		__entry->c_ptr = c;
+	),
+
+	TP_printk("a=%d b=%p c=%p", __entry->a, __entry->b_ptr, __entry->c_ptr)
+);
+
+#endif /* _FETCHARG_BENCH_TRACE_H */
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE fetcharg_bench_trace
+#include <trace/define_trace.h>

