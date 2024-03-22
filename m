Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABC25CB8
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 00:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065653; cv=none; b=OHu6qgT6tg00MmwxaOx5QkJZcuBVovnxzCzS4M5MudFt1VvSJbRkkxz6cNWuUL6FwjJ1hCOgwJkObMRtSzK45ihZ8ezrrGHlRqAW2ip9/EuZjqpor8HNikac1v3bNhQyo7cioam9uxfCYA68H8F8VY8vo/1yILI8sz9pWyww70g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065653; c=relaxed/simple;
	bh=3Ho0kc21D/CUkprAbOk1NKR5OimHhuqMiecj4/zbJQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUxTTip+wjy0iGZiZAubnCA+61PYwYJAWABfO+XodOz10if2UcQU0avkxwPE3Zccbjlvki6pGYRK6KMHfz46zHmIItNucOuN4g9v25HkCa6/dHQKoCKAti5wRWdXR9j1VMX4zaEWQULk0d+1niVyPQfmGKDwhFU/gk0BN7Mo8B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5U0R6V1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5U0R6V1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B7BC433F1;
	Fri, 22 Mar 2024 00:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711065653;
	bh=3Ho0kc21D/CUkprAbOk1NKR5OimHhuqMiecj4/zbJQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y5U0R6V1WYfD48S4ewSfgf7wp/0nl2s/6ochiUn1Ey1QdcFQy/FA7tkua3aiQJ8+z
	 oa08mhFFQS5hIYQuRmuVPCl4loL5Bd9CM1A4fTPUkSiljennZs4Ib6OAGM7W7HYHoU
	 xXiCL3fF3BzIpAcNm8Ks7RxTSFNSsmHIVOcziwle/ZbQegJo3NwkP51Mjfiey9ZYJw
	 M5VW5mQwJqTkbbYH+HsbHC0HFXoVDC6AF0p84uSSI3iQeJMm0j8rjHZ1L71SfKD1vY
	 hciRBpPI/RhsskSV8hVDxgraCE6sf0O4mtVm8gIvEHyhHk2lxFMda1rmFRAGDDqHD0
	 MGm974Tk5XXnA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/6] selftests/bpf: rename and clean up userspace-triggered benchmarks
Date: Thu, 21 Mar 2024 17:00:36 -0700
Message-ID: <20240322000041.2919948-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322000041.2919948-1-andrii@kernel.org>
References: <20240322000041.2919948-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename uprobe-base to more precise usermode-count (it will match other
baseline-like benchmarks, kernel-count and syscall-count). Also use
BENCH_TRIG_USERMODE() macro to define all usermode-based triggering
benchmarks, which include usermode-count and uprobe/uretprobe benchmarks.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/bench.c           |  14 ++-
 .../selftests/bpf/benchs/bench_trigger.c      | 106 ++++++------------
 .../selftests/bpf/benchs/run_bench_uprobes.sh |   2 +-
 3 files changed, 49 insertions(+), 73 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index b2b4c391eb0a..7ca1e1eb5c30 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -491,7 +491,12 @@ extern const struct bench bench_rename_kretprobe;
 extern const struct bench bench_rename_rawtp;
 extern const struct bench bench_rename_fentry;
 extern const struct bench bench_rename_fexit;
+
+/* pure counting benchmarks to establish theoretical lmits */
+extern const struct bench bench_trig_usermode_count;
 extern const struct bench bench_trig_base;
+
+/* kernel-side syscall-triggered benchmarks */
 extern const struct bench bench_trig_tp;
 extern const struct bench bench_trig_rawtp;
 extern const struct bench bench_trig_kprobe;
@@ -502,13 +507,15 @@ extern const struct bench bench_trig_fentry;
 extern const struct bench bench_trig_fexit;
 extern const struct bench bench_trig_fentry_sleep;
 extern const struct bench bench_trig_fmodret;
-extern const struct bench bench_trig_uprobe_base;
+
+/* uprobe/uretprobe benchmarks */
 extern const struct bench bench_trig_uprobe_nop;
 extern const struct bench bench_trig_uretprobe_nop;
 extern const struct bench bench_trig_uprobe_push;
 extern const struct bench bench_trig_uretprobe_push;
 extern const struct bench bench_trig_uprobe_ret;
 extern const struct bench bench_trig_uretprobe_ret;
+
 extern const struct bench bench_rb_libbpf;
 extern const struct bench bench_rb_custom;
 extern const struct bench bench_pb_libbpf;
@@ -539,7 +546,10 @@ static const struct bench *benchs[] = {
 	&bench_rename_rawtp,
 	&bench_rename_fentry,
 	&bench_rename_fexit,
+	/* pure counting benchmarks for establishing theoretical limits */
+	&bench_trig_usermode_count,
 	&bench_trig_base,
+	/* syscall-driven triggering benchmarks */
 	&bench_trig_tp,
 	&bench_trig_rawtp,
 	&bench_trig_kprobe,
@@ -550,7 +560,7 @@ static const struct bench *benchs[] = {
 	&bench_trig_fexit,
 	&bench_trig_fentry_sleep,
 	&bench_trig_fmodret,
-	&bench_trig_uprobe_base,
+	/* uprobes */
 	&bench_trig_uprobe_nop,
 	&bench_trig_uretprobe_nop,
 	&bench_trig_uprobe_push,
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index b7aea79495ba..68e703b46d9b 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -12,6 +12,7 @@
 /* BPF triggering benchmarks */
 static struct trigger_ctx {
 	struct trigger_bench *skel;
+	bool usermode_counters;
 } ctx;
 
 static struct counter base_hits[MAX_BUCKETS];
@@ -72,7 +73,10 @@ static void *trigger_producer(void *input)
 
 static void trigger_measure(struct bench_res *res)
 {
-	res->hits = sum_and_reset_counters(ctx.skel->bss->hits);
+	if (ctx.usermode_counters)
+		res->hits = sum_and_reset_counters(base_hits);
+	else
+		res->hits = sum_and_reset_counters(ctx.skel->bss->hits);
 }
 
 static void setup_ctx(void)
@@ -190,7 +194,7 @@ __weak void uprobe_target_ret(void)
 	asm volatile ("");
 }
 
-static void *uprobe_base_producer(void *input)
+static void *uprobe_producer_count(void *input)
 {
 	while (true) {
 		uprobe_target_nop();
@@ -246,32 +250,37 @@ static void usetup(bool use_retprobe, void *target_addr)
 	ctx.skel->links.bench_trigger_uprobe = link;
 }
 
-static void uprobe_setup_nop(void)
+static void usermode_count_setup(void)
+{
+	ctx.usermode_counters = true;
+}
+
+static void uprobe_nop_setup(void)
 {
 	usetup(false, &uprobe_target_nop);
 }
 
-static void uretprobe_setup_nop(void)
+static void uretprobe_nop_setup(void)
 {
 	usetup(true, &uprobe_target_nop);
 }
 
-static void uprobe_setup_push(void)
+static void uprobe_push_setup(void)
 {
 	usetup(false, &uprobe_target_push);
 }
 
-static void uretprobe_setup_push(void)
+static void uretprobe_push_setup(void)
 {
 	usetup(true, &uprobe_target_push);
 }
 
-static void uprobe_setup_ret(void)
+static void uprobe_ret_setup(void)
 {
 	usetup(false, &uprobe_target_ret);
 }
 
-static void uretprobe_setup_ret(void)
+static void uretprobe_ret_setup(void)
 {
 	usetup(true, &uprobe_target_ret);
 }
@@ -385,65 +394,22 @@ const struct bench bench_trig_fmodret = {
 	.report_final = hits_drops_report_final,
 };
 
-const struct bench bench_trig_uprobe_base = {
-	.name = "trig-uprobe-base",
-	.setup = NULL, /* no uprobe/uretprobe is attached */
-	.producer_thread = uprobe_base_producer,
-	.measure = trigger_base_measure,
-	.report_progress = hits_drops_report_progress,
-	.report_final = hits_drops_report_final,
-};
-
-const struct bench bench_trig_uprobe_nop = {
-	.name = "trig-uprobe-nop",
-	.setup = uprobe_setup_nop,
-	.producer_thread = uprobe_producer_nop,
-	.measure = trigger_measure,
-	.report_progress = hits_drops_report_progress,
-	.report_final = hits_drops_report_final,
-};
-
-const struct bench bench_trig_uretprobe_nop = {
-	.name = "trig-uretprobe-nop",
-	.setup = uretprobe_setup_nop,
-	.producer_thread = uprobe_producer_nop,
-	.measure = trigger_measure,
-	.report_progress = hits_drops_report_progress,
-	.report_final = hits_drops_report_final,
-};
-
-const struct bench bench_trig_uprobe_push = {
-	.name = "trig-uprobe-push",
-	.setup = uprobe_setup_push,
-	.producer_thread = uprobe_producer_push,
-	.measure = trigger_measure,
-	.report_progress = hits_drops_report_progress,
-	.report_final = hits_drops_report_final,
-};
-
-const struct bench bench_trig_uretprobe_push = {
-	.name = "trig-uretprobe-push",
-	.setup = uretprobe_setup_push,
-	.producer_thread = uprobe_producer_push,
-	.measure = trigger_measure,
-	.report_progress = hits_drops_report_progress,
-	.report_final = hits_drops_report_final,
-};
-
-const struct bench bench_trig_uprobe_ret = {
-	.name = "trig-uprobe-ret",
-	.setup = uprobe_setup_ret,
-	.producer_thread = uprobe_producer_ret,
-	.measure = trigger_measure,
-	.report_progress = hits_drops_report_progress,
-	.report_final = hits_drops_report_final,
-};
-
-const struct bench bench_trig_uretprobe_ret = {
-	.name = "trig-uretprobe-ret",
-	.setup = uretprobe_setup_ret,
-	.producer_thread = uprobe_producer_ret,
-	.measure = trigger_measure,
-	.report_progress = hits_drops_report_progress,
-	.report_final = hits_drops_report_final,
-};
+/* uprobe benchmarks */
+#define BENCH_TRIG_USERMODE(KIND, PRODUCER, NAME)			\
+const struct bench bench_trig_##KIND = {				\
+	.name = "trig-" NAME,						\
+	.validate = trigger_validate,					\
+	.setup = KIND##_setup,						\
+	.producer_thread = uprobe_producer_##PRODUCER,			\
+	.measure = trigger_measure,					\
+	.report_progress = hits_drops_report_progress,			\
+	.report_final = hits_drops_report_final,			\
+}
+
+BENCH_TRIG_USERMODE(usermode_count, count, "usermode-count");
+BENCH_TRIG_USERMODE(uprobe_nop, nop, "uprobe-nop");
+BENCH_TRIG_USERMODE(uprobe_push, push, "uprobe-push");
+BENCH_TRIG_USERMODE(uprobe_ret, ret, "uprobe-ret");
+BENCH_TRIG_USERMODE(uretprobe_nop, nop, "uretprobe-nop");
+BENCH_TRIG_USERMODE(uretprobe_push, push, "uretprobe-push");
+BENCH_TRIG_USERMODE(uretprobe_ret, ret, "uretprobe-ret");
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh b/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
index 9bdcc74e03a4..36021d243397 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
@@ -2,7 +2,7 @@
 
 set -eufo pipefail
 
-for i in base {uprobe,uretprobe}-{nop,push,ret}
+for i in usermode-count base {uprobe,uretprobe}-{nop,push,ret}
 do
 	summary=$(sudo ./bench -w2 -d5 -a trig-$i | tail -n1 | cut -d'(' -f1 | cut -d' ' -f3-)
 	printf "%-15s: %s\n" $i "$summary"
-- 
2.43.0

