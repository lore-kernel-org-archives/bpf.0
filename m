Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B4313C815
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 16:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470120; cv=none; b=mc2wVJH8JMWEgyMpjVonh+Tc9to0KoLHRrL/gLfnybQigs5a7e1XaG9oTzuqYWG4IQpQy8RMrXNRcIYOAj0djPhPsVd4YFfbRAIn2kQeLeRqseo8og58SWvzqt7td+mqsCY+kxUT/XVLHE0COopjhV65t95FEr5cG9snGugcJYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470120; c=relaxed/simple;
	bh=fz2HM3jgKdapOsuKW+zV1fBiaMIhAstvWJQ+a73OHso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jb5H6lo8wTzRtXqjUi57IDyGrOTm8oR2zYhP9RamY9eq9q5SpyyrR7Y3jNKIo0c8DkZ4aaAbaTKeCIeQhz8/20MWTj0hPbQz82TBulmkdl/7lWlr4F1aKIrMbMPGgr1HwBtjbFkZ33q/+F3P/vLopKnP+OeUTSAze7gnmyHFDaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHdjfcxD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHdjfcxD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA7CC43394;
	Tue, 26 Mar 2024 16:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711470119;
	bh=fz2HM3jgKdapOsuKW+zV1fBiaMIhAstvWJQ+a73OHso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IHdjfcxDz7BTesmqL9COmS9sGfi5Ku55dqES5sAiBqJ2YN1RS+zKJb0X8uNSdFUBj
	 xZJm5XxgNS9FfL/EoPF5WEJxj6qua4F0RZ2qAyCgzA/EI6WQs3tBtUQ4qdRgOguQEP
	 kqs7GDMzIkdWm3mr3PSrsfwVOwyJiCBpYb1zsM4eux9f6dxzLV8qpU2kEp9m46eFNT
	 ctglbRISr9CwdNmbyZ9olpcz7h5wtCi3NQcDn5N/Olp5lGRgxOguM/aBBFE7eZRTga
	 P9SYi5XoQpJgB0yyNjqYY1yMhHE/B/gCcS5vG/QA+tDYMofi+il3XMeTrWFDdWCkYn
	 Pleg3OgJOkTtA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 1/6] selftests/bpf: rename and clean up userspace-triggered benchmarks
Date: Tue, 26 Mar 2024 09:21:46 -0700
Message-ID: <20240326162151.3981687-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326162151.3981687-1-andrii@kernel.org>
References: <20240326162151.3981687-1-andrii@kernel.org>
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
index d66eddacd642..97aba7e6458d 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -14,6 +14,7 @@
 /* BPF triggering benchmarks */
 static struct trigger_ctx {
 	struct trigger_bench *skel;
+	bool usermode_counters;
 } ctx;
 
 static struct counter base_hits[MAX_BUCKETS];
@@ -74,7 +75,10 @@ static void *trigger_producer(void *input)
 
 static void trigger_measure(struct bench_res *res)
 {
-	res->hits = sum_and_reset_counters(ctx.skel->bss->hits);
+	if (ctx.usermode_counters)
+		res->hits = sum_and_reset_counters(base_hits);
+	else
+		res->hits = sum_and_reset_counters(ctx.skel->bss->hits);
 }
 
 static void setup_ctx(void)
@@ -192,7 +196,7 @@ __nocf_check __weak void uprobe_target_ret(void)
 	asm volatile ("");
 }
 
-static void *uprobe_base_producer(void *input)
+static void *uprobe_producer_count(void *input)
 {
 	while (true) {
 		uprobe_target_nop();
@@ -248,32 +252,37 @@ static void usetup(bool use_retprobe, void *target_addr)
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
@@ -387,65 +396,22 @@ const struct bench bench_trig_fmodret = {
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

