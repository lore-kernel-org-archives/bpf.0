Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D5E37E31F
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778226730; cv=none; b=Z03GYprX2McoD2A8OZF7gFIxulUoIN5647Ag5mUjcUYEScD6l67XajETJwzltFfNJlXPe3rPWy3q29ymmS+NK6QsQFcYWrtULwSFFTs0MO83x63AwwrHTGMzs1wICFXFApnYzpBST/Z6DrnL+rtUXwrzfdy95t2nihP/jVltfqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778226730; c=relaxed/simple;
	bh=QbNWoa1qIsCZ6h37ALp5edJjeNQqRpD+pRIJqIDDPLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DcvTMG5K6RmYyzaaUzRcafYAnN9yN0G3nKP2KYQWWt9kAS892SBFcnD9g88uYzESsGqdVbbrCHDLI00nAJNmVcj7KFRxjMd7Yn2HtM/vPFmkc5VoxNYbotFE3VAQy0bft7bGw2jWeWqHV+dKAy3RE+1YAHgBrklpVfmqfj2v2V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIRMgHlP; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIRMgHlP"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b4520f6b32so3239741eec.0
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 00:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778226725; x=1778831525; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lVc9Il3YRzVNGidLNxWPc9mcguOR/ueoaeWWxhFeju8=;
        b=AIRMgHlPTnu6EvQ8g/kuoLmj65gEBxusEuQ3fltLm1q7zWqCTyC0FjTgMWOprOgKzZ
         N29BVhvm9g956HAuoMD774h61bsa+pKcbM73tVsLeT3aV0aXao327+lZ5cyzpAEKkoRi
         pPaBj8Pmj0f+AM6ycVudL8v3BXQr6O97aDWByNGXkkfHSImjKdUFbsVh0L5kxjTTldYI
         YkQInvB06DJ2SzJ7xiNdCget80zY9pLhwGYrRlXDsWQgoYo5JJXOeUmvcdWsyxkAq7p0
         gcWFhPXgJJaaf26pgUEBLAbL3g8pYSwQ+3TdriFG74buvCQTu3lDCiaiiZ4gJGBvu/a0
         bgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778226725; x=1778831525;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVc9Il3YRzVNGidLNxWPc9mcguOR/ueoaeWWxhFeju8=;
        b=B8gQzNiovEyBnOgsvUL3+hho9PzVUId9+ZDJCX/tCibqGjGLXn2rWCLEv5JR/Pa0Om
         YrP1XWicqUPQB/HlsZXWxegqxFwRr0/Aboz/qpTPB1UmH0pdCxOdoGgf6hPR1ZJV0Z7V
         duZZjtNSNVnsdozOBmkJr9uPuuaCJ9JQku0erkz42Eypgp43Axv1dP/3Ifph3I17z3qJ
         qQLViIBz0epHDvTEBrI0A6YJgJbnsK3Suof9IdyJT7sYl7dp6U0tt4oQFTpFh+IjUYLk
         VZ9U7GSs0vhc65EyrSMP1mUoJzD6xXqbCbUL1zeJr7TVlJzQQcLONeeOSFDh3lGzBr+V
         96cQ==
X-Forwarded-Encrypted: i=1; AFNElJ8tR+me6XWaR60fH6E5dMezE/vvQK0q20w6GomLuxYB/hmLaCPcYiWLrqY+VF+LihCubrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq6uOzgWV47ZNqxfo7Hl9fTbyS4aQ0/ltmIlR+eTkQ1zJA74/p
	gk/12scbv4fTDEhAEXTaL0Nk5Yf8CY6BC13+A2obxxJ11BWlq5JbIfa6
X-Gm-Gg: AeBDievSSNLWqSY1p+uOIeH0dgUv5eidXUOEpFYPZX6/DbQsbcc/EIs1J6EZStkeECR
	8y+lRqs52zdcV0ItLllqYCNXgf2IV3LCl5qYWy4LjoWmUryel4QpGeTQdrtPuNyDxOqqsNH5azY
	YG0KDC4bFl4OE0wIeArZerrJ7VD7Lv4TVqY52y5NpK7EcHU+VY59hhwPUeyrNz7AQRjOiPVT5P/
	9jEetmjDTEOolsYQq1SXgyoUZhB228JkGPq/zV+AiJDFyxRo4rbZWKDn1nN4ifx63pMsi6HUZ4a
	TCPHySF4LwJ7kWl6qXvlkdWnMIbc/D+Fu1iEWbvYTrYZR+ibJbMnjQXFukZRI2P5IYegVSj4vRr
	VsiYBBfEVU5nDwD3WVMWuz4I5lBeSOhfmq2HhMEynsh/8kssYvjebcwcsui10sCYLXTUvmbtrC7
	FR70JJp7IKuWbkYUfrXQR1DFyTZyDfbY4=
X-Received: by 2002:a05:7022:ea23:b0:12b:ec15:69d2 with SMTP id a92af1059eb24-1319d14dcbfmr5342798c88.33.1778226725038;
        Fri, 08 May 2026 00:52:05 -0700 (PDT)
Received: from wujing.localdomain ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132781103e7sm1650917c88.1.2026.05.08.00.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 00:52:04 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Fri, 08 May 2026 15:51:35 +0800
Subject: [PATCH] sched_ext: Add scx_ai_numa scheduler example for AI
 workloads
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260508-feat-scx_ai_example-v1-1-2b498af3514d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqAIBRG4a3EHSeYmVhbiQipv7rQC40Qor0nD
 b/BOQ8FeEagJnvI4+bAx55Q5BkNi9tnCB6TSUllZCWtmOAuEYbYO+4R3XauEBZFaXWtldGGUnl
 6TBz/a9u97wfu/7W5ZQAAAA==
X-Change-ID: 20260508-feat-scx_ai_example-8e1384942646
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
 bpf@vger.kernel.org, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.14.3

Implement an AI-focused NUMA-aware scheduler that optimizes task dispatch for
GPU-accelerated AI training. The scheduler maintains per-NUMA-node dispatch
queues to preserve L3 cache warmth and minimize remote DRAM accesses that
would stall GPU kernel launches waiting on CPU preprocessing.

Key features:
- Per-NUMA-node DSQs (dispatch queues) to maintain cache locality
- Idle fast path that bypasses DSQ for minimum latency
- Per-task NUMA affinity tracking to remember task placement
- Work stealing across nodes to prevent starvation during load imbalance

The BPF component (scx_ai_numa.bpf.c) implements the core scheduler
callbacks, while the userspace loader (scx_ai_numa.c) detects NUMA
topology, installs the BPF program, and reports per-node dispatch
statistics every second.

This scheduler is suitable for AI training workloads where GPU command
launches depend on rapid CPU preprocessing with minimal scheduling latency.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 tools/sched_ext/Makefile          |   2 +-
 tools/sched_ext/scx_ai_numa.bpf.c | 200 ++++++++++++++++++++++++++++++++++++++
 tools/sched_ext/scx_ai_numa.c     | 126 ++++++++++++++++++++++++
 3 files changed, 327 insertions(+), 1 deletion(-)

diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
index 21554f0896923..a639b5bf4f542 100644
--- a/tools/sched_ext/Makefile
+++ b/tools/sched_ext/Makefile
@@ -191,7 +191,7 @@ $(INCLUDE_DIR)/%.bpf.skel.h: $(SCXOBJ_DIR)/%.bpf.o $(INCLUDE_DIR)/vmlinux.h $(BP
 
 SCX_COMMON_DEPS := include/scx/common.h include/scx/user_exit_info.h | $(BINDIR)
 
-c-sched-targets = scx_simple scx_cpu0 scx_qmap scx_central scx_flatcg scx_userland scx_pair scx_sdt
+c-sched-targets = scx_simple scx_cpu0 scx_qmap scx_central scx_flatcg scx_userland scx_pair scx_sdt scx_ai_numa
 
 $(addprefix $(BINDIR)/,$(c-sched-targets)): \
 	$(BINDIR)/%: \
diff --git a/tools/sched_ext/scx_ai_numa.bpf.c b/tools/sched_ext/scx_ai_numa.bpf.c
new file mode 100644
index 0000000000000..89d3b7dd3d474
--- /dev/null
+++ b/tools/sched_ext/scx_ai_numa.bpf.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * scx_ai_numa - AI NUMA-aware scheduler (BPF side)
+ *
+ * Scheduling policy optimized for AI training workloads:
+ *
+ * 1. Per-NUMA-node DSQs: each NUMA node owns a dedicated dispatch queue.
+ *    Tasks are steered to the DSQ of the NUMA node they last ran on,
+ *    preserving L3 cache warmth and reducing remote DRAM accesses that
+ *    stall GPU kernel launches waiting on CPU preprocessing.
+ *
+ * 2. Idle fast path: when an idle CPU is found, bypass the per-node DSQ
+ *    and insert directly into SCX_DSQ_LOCAL for minimum latency.
+ *
+ * 3. Task NUMA affinity: per-task storage tracks the preferred NUMA node
+ *    (updated every time select_cpu() sees the task's prev_cpu).
+ *
+ * 4. Work stealing: if a node's DSQ is empty, try remote nodes in order
+ *    to prevent CPU starvation during load imbalance (e.g., bursty GPU
+ *    command submissions landing on a single NUMA node).
+ */
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+#define MAX_NUMA_NODES 16
+
+/* One DSQ per NUMA node, IDs 0 .. MAX_NUMA_NODES-1 */
+#define NUMA_DSQ(node) ((u64)(node))
+
+/* Per-task context: remember which NUMA node this task prefers */
+struct task_ctx {
+	u32 preferred_node;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct task_ctx);
+} task_ctx_stor SEC(".maps");
+
+/* Per-node counters (per-CPU to avoid false sharing) */
+struct node_stat {
+	__u64 local_dsq;	/* fast-path: direct SCX_DSQ_LOCAL insert */
+	__u64 numa_dsq;		/* enqueued to per-node DSQ */
+	__u64 steal;		/* dispatched from a remote node's DSQ */
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(u32));
+	__uint(value_size, sizeof(struct node_stat));
+	__uint(max_entries, MAX_NUMA_NODES);
+} node_stats SEC(".maps");
+
+/* Set by userspace after detecting the number of NUMA nodes */
+const volatile u32 nr_nodes = 1;
+
+static __always_inline u32 cpu_to_node(s32 cpu)
+{
+	return __COMPAT_scx_bpf_cpu_node(cpu);
+}
+
+static __always_inline void stat_inc_local(u32 node)
+{
+	struct node_stat *s = bpf_map_lookup_elem(&node_stats, &node);
+
+	if (s)
+		s->local_dsq++;
+}
+
+static __always_inline void stat_inc_numa(u32 node)
+{
+	struct node_stat *s = bpf_map_lookup_elem(&node_stats, &node);
+
+	if (s)
+		s->numa_dsq++;
+}
+
+static __always_inline void stat_inc_steal(u32 node)
+{
+	struct node_stat *s = bpf_map_lookup_elem(&node_stats, &node);
+
+	if (s)
+		s->steal++;
+}
+
+s32 BPF_STRUCT_OPS(ai_numa_select_cpu, struct task_struct *p, s32 prev_cpu, u64 wake_flags)
+{
+	struct task_ctx *tctx;
+	bool is_idle = false;
+	u32 node;
+	s32 cpu;
+
+	/* Update task's preferred NUMA node from prev_cpu */
+	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0,
+				     BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (tctx) {
+		node = cpu_to_node(prev_cpu);
+		tctx->preferred_node = node < nr_nodes ? node : 0;
+	}
+
+	/*
+	 * Default selection tries prev_cpu first (same LLC), which preserves
+	 * L1/L2/L3 cache across AI loop iterations without extra policy code.
+	 */
+	cpu = scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags, &is_idle);
+	if (is_idle) {
+		/* Idle CPU found: bypass DSQ for minimum latency */
+		node = cpu_to_node(cpu);
+		stat_inc_local(node);
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+	}
+
+	return cpu;
+}
+
+void BPF_STRUCT_OPS(ai_numa_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	struct task_ctx *tctx;
+	u32 node = 0;
+
+	/*
+	 * Route to the task's preferred NUMA node DSQ.
+	 * Keeping AI tasks on the same NUMA node as their GPU's host memory
+	 * reduces cross-node DRAM traffic and PCIe DMA stalls.
+	 */
+	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+	if (tctx) {
+		node = tctx->preferred_node;
+		if (node >= nr_nodes)
+			node = 0;
+	}
+
+	stat_inc_numa(node);
+	scx_bpf_dsq_insert(p, NUMA_DSQ(node), SCX_SLICE_DFL, enq_flags);
+}
+
+void BPF_STRUCT_OPS(ai_numa_dispatch, s32 cpu, struct task_struct *prev)
+{
+	u32 my_node = cpu_to_node(cpu);
+	u32 i;
+
+	/* First: consume from our own NUMA node — zero cross-node traffic */
+	if (scx_bpf_dsq_move_to_local(NUMA_DSQ(my_node), 0))
+		return;
+
+	/*
+	 * Work steal from other nodes in order.
+	 * Prevents CPU starvation when one GPU's launch bursts all tasks
+	 * onto a single NUMA node while other nodes sit idle.
+	 */
+	for (i = 0; i < MAX_NUMA_NODES; i++) {
+		u32 node = i;
+
+		if (node >= nr_nodes)
+			break;
+		if (node == my_node)
+			continue;
+		if (scx_bpf_dsq_move_to_local(NUMA_DSQ(node), 0)) {
+			stat_inc_steal(my_node);
+			return;
+		}
+	}
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(ai_numa_init)
+{
+	u32 i;
+	int ret;
+
+	for (i = 0; i < MAX_NUMA_NODES; i++) {
+		if (i >= nr_nodes)
+			break;
+		ret = scx_bpf_create_dsq(NUMA_DSQ(i), -1);
+		if (ret) {
+			scx_bpf_error("failed to create DSQ for node %u: %d",
+				      i, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(ai_numa_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SCX_OPS_DEFINE(ai_numa_ops,
+	       .select_cpu	= (void *)ai_numa_select_cpu,
+	       .enqueue		= (void *)ai_numa_enqueue,
+	       .dispatch	= (void *)ai_numa_dispatch,
+	       .init		= (void *)ai_numa_init,
+	       .exit		= (void *)ai_numa_exit,
+	       .name		= "ai_numa");
diff --git a/tools/sched_ext/scx_ai_numa.c b/tools/sched_ext/scx_ai_numa.c
new file mode 100644
index 0000000000000..58c7bb1bd6bb6
--- /dev/null
+++ b/tools/sched_ext/scx_ai_numa.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * scx_ai_numa - AI NUMA-aware scheduler (userspace loader)
+ *
+ * Detects NUMA topology, configures the BPF scheduler, and prints
+ * per-node dispatch statistics every second.
+ */
+#include <stdio.h>
+#include <unistd.h>
+#include <signal.h>
+#include <assert.h>
+#include <libgen.h>
+#include <sys/stat.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include "scx_ai_numa.bpf.skel.h"
+
+/* Must match BPF side */
+struct node_stat {
+	__u64 local_dsq;
+	__u64 numa_dsq;
+	__u64 steal;
+};
+
+#define MAX_NUMA_NODES 16
+
+static volatile int exit_req;
+
+static void sigint_handler(int sig)
+{
+	exit_req = 1;
+}
+
+/* Detect NUMA node count by scanning sysfs */
+static __u32 detect_nr_nodes(void)
+{
+	struct stat st;
+	char path[64];
+	__u32 i, count = 0;
+
+	for (i = 0; i < MAX_NUMA_NODES; i++) {
+		snprintf(path, sizeof(path),
+			 "/sys/devices/system/node/node%u", i);
+		if (stat(path, &st) == 0 && S_ISDIR(st.st_mode))
+			count = i + 1;
+		else
+			break;
+	}
+	return count ? count : 1;
+}
+
+static void print_stats(struct scx_ai_numa *skel, __u32 nr_nodes)
+{
+	int nr_cpus = libbpf_num_possible_cpus();
+	int map_fd  = bpf_map__fd(skel->maps.node_stats);
+
+	printf("\n%-6s %14s %14s %14s\n",
+	       "Node", "Local-DSQ", "NUMA-DSQ", "Steals");
+	printf("------+--------------+--------------+--------------\n");
+
+	for (__u32 node = 0; node < nr_nodes; node++) {
+		struct node_stat per_cpu[nr_cpus];
+		struct node_stat total = {};
+		__u32 key = node;
+		int i;
+
+		if (bpf_map_lookup_elem(map_fd, &key, per_cpu) < 0)
+			continue;
+
+		for (i = 0; i < nr_cpus; i++) {
+			total.local_dsq += per_cpu[i].local_dsq;
+			total.numa_dsq  += per_cpu[i].numa_dsq;
+			total.steal     += per_cpu[i].steal;
+		}
+
+		printf("%-6u %14llu %14llu %14llu\n", node,
+		       total.local_dsq, total.numa_dsq, total.steal);
+	}
+}
+
+int main(int argc, char **argv)
+{
+	struct scx_ai_numa *skel;
+	struct bpf_link *link;
+	__u64 ecode;
+	__u32 nr_nodes;
+
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
+
+	nr_nodes = detect_nr_nodes();
+	printf("scx_ai_numa: detected %u NUMA node(s)\n", nr_nodes);
+
+restart:
+	/*
+	 * Avoid SCX_OPS_OPEN() which accesses sub_attach/sub_detach/
+	 * sub_cgroup_id at compile time. These fields may not be available
+	 * in all supported kernel versions.
+	 */
+	skel = scx_ai_numa__open();
+	SCX_BUG_ON(!skel, "Could not open scx_ai_numa");
+	skel->struct_ops.ai_numa_ops->hotplug_seq = scx_hotplug_seq();
+	SCX_ENUM_INIT(skel);
+
+	/* Pass NUMA topology to the BPF program via rodata */
+	skel->rodata->nr_nodes = nr_nodes;
+
+	SCX_OPS_LOAD(skel, ai_numa_ops, scx_ai_numa, uei);
+	link = SCX_OPS_ATTACH(skel, ai_numa_ops, scx_ai_numa);
+
+	printf("scx_ai_numa: running (Ctrl-C to stop)\n");
+
+	while (!exit_req && !UEI_EXITED(skel, uei)) {
+		print_stats(skel, nr_nodes);
+		fflush(stdout);
+		sleep(1);
+	}
+
+	bpf_link__destroy(link);
+	ecode = UEI_REPORT(skel, uei);
+	scx_ai_numa__destroy(skel);
+
+	if (UEI_ECODE_RESTART(ecode))
+		goto restart;
+	return 0;
+}

---
base-commit: 8ab992f815d6736b5c7a6f5fd7bfe7bc106bb3dc
change-id: 20260508-feat-scx_ai_example-8e1384942646

Best regards,
-- 
Qiliang Yuan <realwujing@gmail.com>

