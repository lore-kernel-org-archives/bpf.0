Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF49151588F
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 08:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066769; cv=none; b=lNMl/ar7Ax+8Z0tsS5ff6Fpb+Y6b+AGRyqDdCXfAcdWslzbBNnzOFlNnQejFcrjAGHBMql9CrY4aDRdKINVcvNkXrn6i5OKmRUw8SJt127lop8X8qdASFUpLQAzASfSF4z3aFJEzuLPo8MOoRJxEhmQ5iDLBdEQjPY8cBYFgpr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066769; c=relaxed/simple;
	bh=o9zCc/zSe+xZ4w5cTAya59ZN6r+jRaV+ChNlwTPRXpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qjv1TNk6tcXXhypxqNAXsfKfEjFQaFaYc5lrpNdLqhCmNYsCu9NDX5cQzF116TWNY0qExg7ByHlQTjQ0LKlt0gDHqtkR7u/Lz3a2/e/5+7rKQIH6Ubjrs7rIyr1G8/mFGj0tdHzaGA5+hJEHeeenGVH1mFyRCuEQB4TSspLpgFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTZfS8Za; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTZfS8Za"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d93ff61046so38147735ad.3
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790066767; x=1790671567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7I6IZbNhwYoxdXyyuPQOHhYaN+sfM6reZoUvS2wh7bQ=;
        b=XTZfS8ZaoN1asGc5VGkibewEORA01LmZWEHalqo1gsq85kkhZms+YmOi6GyeoqBhZK
         1UdMGgONgqzizAxqAURetmQfb3L4guUHFieVQbnBQnCLT8UpSKHFyUXr+RW4Fa4CeS+j
         rWrBvjQ1nRm8OhM2eNdbKWlOeR3jnnxSFznu712mmcDSt1wO2yUO3FfvlA93xY53f2u/
         k2wqKtnB819gMJJcfjOb22tuHpwizOuN6kzu2uRVnmx4CfOYyL/zfu4sX2kP7eWQ+01f
         qmFRzAScVvB/d+p2noBW0Ry8cMCElHwuPdb4HNWlDQXGKy+7Vf9TYHJtRgG4n7/Q6+A2
         +zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790066767; x=1790671567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7I6IZbNhwYoxdXyyuPQOHhYaN+sfM6reZoUvS2wh7bQ=;
        b=PtXRwzIRIUxRC5bUkMvUEyqLLu51ijdiZLr3kXf7et912FjW1hPZFXhttSNX8AmZ6t
         YG/QAIvmewWixW5d75YMWRp20Mx6J0bIeVuCy5rvESGEm87rSIbcRHMhrV5GqZxX++ms
         EvTCkwfDrd7pPYw7mzl7PLkuKQGj4u06ua+/aCnuMaVFOKcWOKCW4SnLdoIVvOM7/Ve0
         eA5OjouryLGFIBhpMe/tYOoGg6Q2HXjGmH63zlpvaM7Eov1d5QlBcoNsZaw+Sog2icNj
         BD2w+rhhj5u07hPXyVYk3bmWnAkF7H1wI6o6xizKfCnsLF7OZKBLcnC+SNZkxxEPKcF+
         c5bA==
X-Gm-Message-State: AFuF++lSSzKEgT80lqW2rIutZyulKbR7J3/FNxJ8tTOz35bZo5iKk7fE
	io36ENN4lgA8Ys2ZIHWLkAsU7y92hs5RsJqlV61yozPtiHA5GtdCcEY0
X-Gm-Gg: AYBFou2xuZR5TWeoxfP77qmKiAUDaTPQehYf7vEbiOUwD566f7oYcjwRqhPCWF/CfZ+
	T2ooeWA/Akos7Yfa4pk1KrP2XVI6+qTYE1jOV049LzAsla36b5q2A8b5LRNIeZuoUJxA33vqEN3
	UntAoMng6jlnvQjf2r+oegzVNfQCSdzb9g9nE21iUZqgootXHPe0iooFBxkKqj9sBZ5NSkKUTA3
	UFWoWW5LoNmgc3kQwUqldaVOqj1LV5ZkVcp/PywKNJpzERj80rp4mHIXcatKNvYpSLhHTk6Ha/O
	m6PujgDN2PyZBG8ZZvsxrAjHCaUr5OxayKjSl3Z4RDYiDFdVii6u47hfqs+lHdSEpWTS3cNcxHl
	Xhe1WjeXKt2Yp95cg7KVArNTqFk1qMP4/nP0mWIjI/msDQNLgmVtnaiXJtfv227C2LN5WGCjU04
	ELkFWPzzR7wu+Rc24W2tSAXniCXtHPnyb1NbM3ju29+iZ1MjL+kXaIsmnVhMHSxbIUlfo+nZgRA
	TP/hMfHlOPd00MbDLnoRg==
X-Received: by 2002:a17:902:f60c:b0:2dd:ad74:ac21 with SMTP id d9443c01a7336-2df60b2d3d6mr6255355ad.28.1790066767075;
        Tue, 22 Sep 2026 01:46:07 -0700 (PDT)
Received: from DESKTOP-S9NKFCJ ([103.120.166.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5cf83512sm6117845ad.5.2026.09.22.01.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:46:06 -0700 (PDT)
From: rahadbhuiya <rahadbhuiya2021@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rahadbhuiya <rahadbhuiya2021@gmail.com>
Subject: [PATCH] tools/sched_ext: Add scx_priority dual-queue priority CPU scheduler
Date: Tue, 22 Sep 2026 14:45:57 +0600
Message-ID: <20260922084557.532-1-rahadbhuiya2021@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add scx_priority, a dual-queue priority CPU scheduler using sched_ext.
It differentiates between latency-sensitive/interactive tasks (nice < 0)
and normal/batch tasks, dispatching high-priority tasks with boosted
slices and draining the high-priority queue first upon core availability.

- Add scx_priority.bpf.c with two DSQs (high priority and normal).
- Add scx_priority.c userspace monitor tracking live throughput.
- Update Makefile and README.md.

Signed-off-by: rahadbhuiya <rahadbhuiya2021@gmail.com>
---
 tools/sched_ext/Makefile           |   2 +-
 tools/sched_ext/README.md          |   7 ++
 tools/sched_ext/scx_priority.bpf.c | 117 ++++++++++++++++++++++++++
 tools/sched_ext/scx_priority.c     | 128 +++++++++++++++++++++++++++++
 4 files changed, 253 insertions(+), 1 deletion(-)
 create mode 100644 tools/sched_ext/scx_priority.bpf.c
 create mode 100644 tools/sched_ext/scx_priority.c

diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
index 21554f089692..41b80e164cda 100644
--- a/tools/sched_ext/Makefile
+++ b/tools/sched_ext/Makefile
@@ -191,7 +191,7 @@ $(INCLUDE_DIR)/%.bpf.skel.h: $(SCXOBJ_DIR)/%.bpf.o $(INCLUDE_DIR)/vmlinux.h $(BP
 
 SCX_COMMON_DEPS := include/scx/common.h include/scx/user_exit_info.h | $(BINDIR)
 
-c-sched-targets = scx_simple scx_cpu0 scx_qmap scx_central scx_flatcg scx_userland scx_pair scx_sdt
+c-sched-targets = scx_simple scx_cpu0 scx_qmap scx_central scx_flatcg scx_userland scx_pair scx_sdt scx_priority
 
 $(addprefix $(BINDIR)/,$(c-sched-targets)): \
 	$(BINDIR)/%: \
diff --git a/tools/sched_ext/README.md b/tools/sched_ext/README.md
index 0ee5a3d997e5..18b80eacc28a 100644
--- a/tools/sched_ext/README.md
+++ b/tools/sched_ext/README.md
@@ -164,6 +164,13 @@ scx_simple can be run in either global weighted vtime mode, or FIFO mode.
 Though very simple, in limited scenarios, this scheduler can perform reasonably
 well on single-socket systems with a unified L3 cache.
 
+## scx_priority
+
+A dual-queue priority scheduler that separates latency-sensitive and interactive
+tasks from normal/batch tasks. Tasks with higher priority (nice < 0) are queued
+to a dedicated high-priority DSQ with boosted time slices and drained first upon
+dispatch.
+
 ## scx_qmap
 
 Another simple, yet slightly more complex scheduler that provides an example of
diff --git a/tools/sched_ext/scx_priority.bpf.c b/tools/sched_ext/scx_priority.bpf.c
new file mode 100644
index 000000000000..816b197c4019
--- /dev/null
+++ b/tools/sched_ext/scx_priority.bpf.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A dual-queue priority scheduler based on sched_ext.
+ *
+ * Dispatches latency-sensitive / interactive tasks (nice < 0) to a high-priority
+ * DSQ, and batch / normal tasks to a standard DSQ. When a CPU core becomes
+ * available, the high-priority queue is drained first before serving normal tasks.
+ *
+ * Copyright (c) 2026 Rahad Bhuiya <rahadbhuiya2021@gmail.com>
+ */
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define PRIO_DSQ_HIGH	0
+#define PRIO_DSQ_LOW	1
+
+/*
+ * Stats tracking:
+ * [0] - High priority / interactive tasks queued
+ * [1] - Standard / batch tasks queued
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(u32));
+	__uint(value_size, sizeof(u64));
+	__uint(max_entries, 2);
+} stats SEC(".maps");
+
+static void stat_inc(u32 idx)
+{
+	u64 *cnt_p = bpf_map_lookup_elem(&stats, &idx);
+
+	if (cnt_p)
+		(*cnt_p)++;
+}
+
+static bool is_high_prio(const struct task_struct *p)
+{
+	/*
+	 * In the Linux kernel, static_prio maps nice -20..19 to 100..139.
+	 * Default nice 0 corresponds to static_prio 120. Tasks with nice < 0
+	 * (static_prio < 120) or real-time policies are prioritized.
+	 */
+	return p->static_prio < 120;
+}
+
+s32 BPF_STRUCT_OPS(prio_select_cpu, struct task_struct *p, s32 prev_cpu, u64 wake_flags)
+{
+	bool is_idle = false;
+	s32 cpu;
+
+	cpu = scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags, &is_idle);
+	if (is_idle) {
+		u64 slice = is_high_prio(p) ? (2 * SCX_SLICE_DFL) : SCX_SLICE_DFL;
+
+		stat_inc(is_high_prio(p) ? 0 : 1);
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, slice, 0);
+	}
+
+	return cpu;
+}
+
+void BPF_STRUCT_OPS(prio_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	if (is_high_prio(p)) {
+		stat_inc(0);
+		scx_bpf_dsq_insert(p, PRIO_DSQ_HIGH, 2 * SCX_SLICE_DFL, enq_flags);
+	} else {
+		stat_inc(1);
+		scx_bpf_dsq_insert(p, PRIO_DSQ_LOW, SCX_SLICE_DFL, enq_flags);
+	}
+}
+
+void BPF_STRUCT_OPS(prio_dispatch, s32 cpu, struct task_struct *prev)
+{
+	/* First drain high-priority tasks if any are waiting */
+	if (scx_bpf_dsq_move_to_local(PRIO_DSQ_HIGH, 0))
+		return;
+
+	/* Otherwise drain standard priority tasks */
+	scx_bpf_dsq_move_to_local(PRIO_DSQ_LOW, 0);
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(prio_init)
+{
+	int ret;
+
+	ret = scx_bpf_create_dsq(PRIO_DSQ_HIGH, -1);
+	if (ret) {
+		scx_bpf_error("failed to create high priority DSQ (%d)", ret);
+		return ret;
+	}
+
+	ret = scx_bpf_create_dsq(PRIO_DSQ_LOW, -1);
+	if (ret) {
+		scx_bpf_error("failed to create low priority DSQ (%d)", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+UEI_DEFINE(uei);
+
+void BPF_STRUCT_OPS(prio_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SCX_OPS_DEFINE(priority_ops,
+	       .select_cpu	= (void *)prio_select_cpu,
+	       .enqueue		= (void *)prio_enqueue,
+	       .dispatch	= (void *)prio_dispatch,
+	       .init		= (void *)prio_init,
+	       .exit		= (void *)prio_exit,
+	       .name		= "priority");
diff --git a/tools/sched_ext/scx_priority.c b/tools/sched_ext/scx_priority.c
new file mode 100644
index 000000000000..3cf975be3a1e
--- /dev/null
+++ b/tools/sched_ext/scx_priority.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Userspace controller and monitor for scx_priority scheduler.
+ *
+ * Copyright (c) 2026 Rahad Bhuiya <rahadbhuiya2021@gmail.com>
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <signal.h>
+#include <assert.h>
+#include <libgen.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include "scx_priority.bpf.skel.h"
+
+const char help_fmt[] =
+"A dual-queue priority sched_ext scheduler.\n"
+"\n"
+"Usage: %s [-i INTERVAL] [-v] [-h]\n"
+"\n"
+"  -i INTERVAL   Stats monitoring interval in seconds (default: 1)\n"
+"  -v            Print libbpf debug messages\n"
+"  -h            Display this help and exit\n";
+
+static bool verbose;
+static sig_atomic_t exit_req;
+
+static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
+{
+	if (level == LIBBPF_DEBUG && !verbose)
+		return 0;
+	return vfprintf(stderr, format, args);
+}
+
+static void sigint_handler(int sig)
+{
+	exit_req = 1;
+}
+
+static void read_stats(struct scx_priority *skel, __u64 *stats)
+{
+	int nr_cpus = libbpf_num_possible_cpus();
+	__u64 *cnts[2];
+	__u32 idx;
+
+	assert(nr_cpus > 0);
+	cnts[0] = calloc(nr_cpus, sizeof(__u64));
+	cnts[1] = calloc(nr_cpus, sizeof(__u64));
+	if (!cnts[0] || !cnts[1]) {
+		free(cnts[0]);
+		free(cnts[1]);
+		return;
+	}
+
+	memset(stats, 0, sizeof(stats[0]) * 2);
+
+	for (idx = 0; idx < 2; idx++) {
+		int ret, cpu;
+
+		ret = bpf_map_lookup_elem(bpf_map__fd(skel->maps.stats),
+					  &idx, cnts[idx]);
+		if (ret < 0)
+			continue;
+		for (cpu = 0; cpu < nr_cpus; cpu++)
+			stats[idx] += cnts[idx][cpu];
+	}
+
+	free(cnts[0]);
+	free(cnts[1]);
+}
+
+int main(int argc, char **argv)
+{
+	struct scx_priority *skel;
+	struct bpf_link *link;
+	__s32 opt;
+	__u64 ecode;
+	int interval = 1;
+
+	libbpf_set_print(libbpf_print_fn);
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
+
+restart:
+	optind = 1;
+	skel = SCX_OPS_OPEN(priority_ops, scx_priority);
+
+	while ((opt = getopt(argc, argv, "i:vh")) != -1) {
+		switch (opt) {
+		case 'i':
+			interval = atoi(optarg);
+			if (interval <= 0)
+				interval = 1;
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			fprintf(stderr, help_fmt, basename(argv[0]));
+			return opt != 'h';
+		}
+	}
+
+	SCX_OPS_LOAD(skel, priority_ops, scx_priority, uei);
+	link = SCX_OPS_ATTACH(skel, priority_ops, scx_priority);
+
+	printf("scx_priority started (interval: %ds). Press Ctrl-C to stop.\n", interval);
+	printf("%-15s %-15s %-15s\n", "HIGH_PRIO(UI)", "LOW_PRIO(BATCH)", "TOTAL_DISPATCH");
+
+	while (!exit_req && !UEI_EXITED(skel, uei)) {
+		__u64 stats[2];
+
+		read_stats(skel, stats);
+		printf("%-15llu %-15llu %-15llu\n",
+		       stats[0], stats[1], stats[0] + stats[1]);
+		fflush(stdout);
+		sleep(interval);
+	}
+
+	bpf_link__destroy(link);
+	ecode = UEI_REPORT(skel, uei);
+	scx_priority__destroy(skel);
+
+	if (!exit_req && UEI_ECODE_RESTART(ecode))
+		goto restart;
+	return 0;
+}
-- 
2.54.0.windows.1

