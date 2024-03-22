Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECCD5CB8
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 00:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065660; cv=none; b=eRgM2ujOBLZd1ODgEYP1DfjFtXlrFrmSe5h3mHfyhvRDHVyU3mbUzT7/2KJP0dfDI0JCzLFinXfT8eZ/oMnvGcPJu+L6GTxZBxRjQ9VWDZreM3o3QQ/9OiNuOzriI/SWJuZpxooU8F/OXVjmlDbY9k6FCShQXA8M0uEKUt3tXKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065660; c=relaxed/simple;
	bh=jn7vAcmlMFhaNxKL1nG0LFqBI0+15mT10O5VSx+AQuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBX2sVw9n/SCpG2th0biZ1Ac/lFAxAIrKKocoQH+XFYgFUXDUYyNaEXtcRMKgnboMIo0h/wVvPnTSossutTxabRrLVzkznM/ij8hSOfZVQYe6AbuS/Fg/+YnzcpeLi/jPx8LAM1I7TZ+AuFUxER8V8lwOHq04lZ3/s2ldyGRWpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mB+/H5Ra; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mB+/H5Ra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26C5C433F1;
	Fri, 22 Mar 2024 00:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711065659;
	bh=jn7vAcmlMFhaNxKL1nG0LFqBI0+15mT10O5VSx+AQuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mB+/H5RacoNpiwfOm1ultTQQiXkVN4iUyxBuYs373X1OnxjYtbCSGaRZEoz/06UtZ
	 Rl8LaadIBsV8GXdA/YGoOx16UWHG09IvImOIuRsZJglH1wu0Gc6Zcac0yqXHHtRMwy
	 ipkBEBie72lxepmDPLHf83Apou0tLQGge4zaUcMQ7cREGWT2KSPJQRBGCJCOLcgcEF
	 KP774v9Z4SMgwxgmQRU9abEQNbO6sZlS8g+YeAngT8tJGJhvrtYeHbTIigzBs+wCle
	 hTMBIW/HQ8EGELRwDZ+ynhFiESPNaYLaaXl6N8Rp49qrrzdVX5LoRuWaI0WcY8QTGp
	 x9esiMcYKoVmw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 3/6] selftests/bpf: remove syscall-driven benchs, keep syscall-count only
Date: Thu, 21 Mar 2024 17:00:38 -0700
Message-ID: <20240322000041.2919948-4-andrii@kernel.org>
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

Remove "legacy" benchmarks triggered by syscalls in favor of newly added
in-kernel/batched benchmarks. Drop -batched suffix now as well.
Next patch will restore "feature parity" by adding back
tp/raw_tp/fmodret benchmarks based on in-kernel kfunc approach.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/bench.c           |  32 +--
 .../selftests/bpf/benchs/bench_trigger.c      | 213 +++---------------
 .../selftests/bpf/benchs/run_bench_trigger.sh |  11 +-
 .../selftests/bpf/benchs/run_bench_uprobes.sh |   2 +-
 .../selftests/bpf/progs/trigger_bench.c       |  83 +------
 5 files changed, 42 insertions(+), 299 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 484bcbeaa819..8b16841a3dec 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -496,28 +496,16 @@ extern const struct bench bench_rename_fexit;
 
 /* pure counting benchmarks to establish theoretical lmits */
 extern const struct bench bench_trig_usermode_count;
-extern const struct bench bench_trig_base;
+extern const struct bench bench_trig_syscall_count;
+extern const struct bench bench_trig_kernel_count;
 
-/* kernel-side syscall-triggered benchmarks */
-extern const struct bench bench_trig_tp;
-extern const struct bench bench_trig_rawtp;
+/* batched, staying mostly in-kernel benchmarks */
 extern const struct bench bench_trig_kprobe;
 extern const struct bench bench_trig_kretprobe;
 extern const struct bench bench_trig_kprobe_multi;
 extern const struct bench bench_trig_kretprobe_multi;
 extern const struct bench bench_trig_fentry;
 extern const struct bench bench_trig_fexit;
-extern const struct bench bench_trig_fentry_sleep;
-extern const struct bench bench_trig_fmodret;
-
-/* batched, staying mostly in-kernel benchmarks */
-extern const struct bench bench_trig_kernel_count;
-extern const struct bench bench_trig_kprobe_batch;
-extern const struct bench bench_trig_kretprobe_batch;
-extern const struct bench bench_trig_kprobe_multi_batch;
-extern const struct bench bench_trig_kretprobe_multi_batch;
-extern const struct bench bench_trig_fentry_batch;
-extern const struct bench bench_trig_fexit_batch;
 
 /* uprobe/uretprobe benchmarks */
 extern const struct bench bench_trig_uprobe_nop;
@@ -560,24 +548,14 @@ static const struct bench *benchs[] = {
 	/* pure counting benchmarks for establishing theoretical limits */
 	&bench_trig_usermode_count,
 	&bench_trig_kernel_count,
-	/* syscall-driven triggering benchmarks */
-	&bench_trig_tp,
-	&bench_trig_rawtp,
+	&bench_trig_syscall_count,
+	/* batched, staying mostly in-kernel triggers */
 	&bench_trig_kprobe,
 	&bench_trig_kretprobe,
 	&bench_trig_kprobe_multi,
 	&bench_trig_kretprobe_multi,
 	&bench_trig_fentry,
 	&bench_trig_fexit,
-	&bench_trig_fentry_sleep,
-	&bench_trig_fmodret,
-	/* batched, staying mostly in-kernel triggers */
-	&bench_trig_kprobe_batch,
-	&bench_trig_kretprobe_batch,
-	&bench_trig_kprobe_multi_batch,
-	&bench_trig_kretprobe_multi_batch,
-	&bench_trig_fentry_batch,
-	&bench_trig_fexit_batch,
 	/* uprobes */
 	&bench_trig_uprobe_nop,
 	&bench_trig_uretprobe_nop,
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 21fa1a84ecd2..567aad2d6f09 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -94,24 +94,17 @@ static void trigger_validate(void)
 	}
 }
 
-static void *trigger_base_producer(void *input)
-{
-	while (true) {
-		(void)syscall(__NR_getpgid);
-		inc_counter(base_hits);
-	}
-	return NULL;
-}
-
-static void trigger_base_measure(struct bench_res *res)
-{
-	res->hits = sum_and_reset_counters(base_hits);
-}
-
 static void *trigger_producer(void *input)
 {
-	while (true)
-		(void)syscall(__NR_getpgid);
+	if (ctx.usermode_counters) {
+		while (true) {
+			(void)syscall(__NR_getpgid);
+			inc_counter(base_hits);
+		}
+	} else {
+		while (true)
+			(void)syscall(__NR_getpgid);
+	}
 	return NULL;
 }
 
@@ -165,16 +158,17 @@ static void attach_bpf(struct bpf_program *prog)
 	}
 }
 
-static void trigger_tp_setup(void)
+static void trigger_syscall_count_setup(void)
 {
-	setup_ctx();
-	attach_bpf(ctx.skel->progs.bench_trigger_tp);
+	ctx.usermode_counters = true;
 }
 
-static void trigger_rawtp_setup(void)
+/* Batched, staying mostly in-kernel triggering setups */
+static void trigger_kernel_count_setup(void)
 {
 	setup_ctx();
-	attach_bpf(ctx.skel->progs.bench_trigger_raw_tp);
+	/* override driver program */
+	ctx.driver_prog_fd = bpf_program__fd(ctx.skel->progs.trigger_count);
 }
 
 static void trigger_kprobe_setup(void)
@@ -213,62 +207,6 @@ static void trigger_fexit_setup(void)
 	attach_bpf(ctx.skel->progs.bench_trigger_fexit);
 }
 
-static void trigger_fentry_sleep_setup(void)
-{
-	setup_ctx();
-	attach_bpf(ctx.skel->progs.bench_trigger_fentry_sleep);
-}
-
-static void trigger_fmodret_setup(void)
-{
-	setup_ctx();
-	attach_bpf(ctx.skel->progs.bench_trigger_fmodret);
-}
-
-/* Batched, staying mostly in-kernel triggering setups */
-static void trigger_kernel_count_setup(void)
-{
-	setup_ctx();
-	/* override driver program */
-	ctx.driver_prog_fd = bpf_program__fd(ctx.skel->progs.trigger_count);
-}
-
-static void trigger_kprobe_batch_setup(void)
-{
-	setup_ctx();
-	attach_bpf(ctx.skel->progs.bench_trigger_kprobe_batch);
-}
-
-static void trigger_kretprobe_batch_setup(void)
-{
-	setup_ctx();
-	attach_bpf(ctx.skel->progs.bench_trigger_kretprobe_batch);
-}
-
-static void trigger_kprobe_multi_batch_setup(void)
-{
-	setup_ctx();
-	attach_bpf(ctx.skel->progs.bench_trigger_kprobe_multi_batch);
-}
-
-static void trigger_kretprobe_multi_batch_setup(void)
-{
-	setup_ctx();
-	attach_bpf(ctx.skel->progs.bench_trigger_kretprobe_multi_batch);
-}
-
-static void trigger_fentry_batch_setup(void)
-{
-	setup_ctx();
-	attach_bpf(ctx.skel->progs.bench_trigger_fentry_batch);
-}
-
-static void trigger_fexit_batch_setup(void)
-{
-	setup_ctx();
-	attach_bpf(ctx.skel->progs.bench_trigger_fexit_batch);
-}
-
 /* make sure call is not inlined and not avoided by compiler, so __weak and
  * inline asm volatile in the body of the function
  *
@@ -393,109 +331,10 @@ static void uretprobe_ret_setup(void)
 	usetup(true, &uprobe_target_ret);
 }
 
-const struct bench bench_trig_base = {
-	.name = "trig-base",
-	.validate = trigger_validate,
-	.producer_thread = trigger_base_producer,
-	.measure = trigger_base_measure,
-	.report_progress = hits_drops_report_progress,
-	.report_final = hits_drops_report_final,
-};
-
-const struct bench bench_trig_tp = {
-	.name = "trig-tp",
-	.validate = trigger_validate,
-	.setup = trigger_tp_setup,
-	.producer_thread = trigger_producer,
-	.measure = trigger_measure,
-	.report_progress = hits_drops_report_progress,
-	.report_final = hits_drops_report_final,
-};
-
-const struct bench bench_trig_rawtp = {
-	.name = "trig-rawtp",
-	.validate = trigger_validate,
-	.setup = trigger_rawtp_setup,
-	.producer_thread = trigger_producer,
-	.measure = trigger_measure,
-	.report_progress = hits_drops_report_progress,
-	.report_final = hits_drops_report_final,
-};
-
-const struct bench bench_trig_kprobe = {
-	.name = "trig-kprobe",
-	.validate = trigger_validate,
-	.setup = trigger_kprobe_setup,
-	.producer_thread = trigger_producer,
-	.measure = trigger_measure,
-	.report_progress = hits_drops_report_progress,
-	.report_final = hits_drops_report_final,
-};
-
-const struct bench bench_trig_kretprobe = {
-	.name = "trig-kretprobe",
-	.validate = trigger_validate,
-	.setup = trigger_kretprobe_setup,
-	.producer_thread = trigger_producer,
-	.measure = trigger_measure,
-	.report_progress = hits_drops_report_progress,
-	.report_final = hits_drops_report_final,
-};
-
-const struct bench bench_trig_kprobe_multi = {
-	.name = "trig-kprobe-multi",
-	.validate = trigger_validate,
-	.setup = trigger_kprobe_multi_setup,
-	.producer_thread = trigger_producer,
-	.measure = trigger_measure,
-	.report_progress = hits_drops_report_progress,
-	.report_final = hits_drops_report_final,
-};
-
-const struct bench bench_trig_kretprobe_multi = {
-	.name = "trig-kretprobe-multi",
-	.validate = trigger_validate,
-	.setup = trigger_kretprobe_multi_setup,
-	.producer_thread = trigger_producer,
-	.measure = trigger_measure,
-	.report_progress = hits_drops_report_progress,
-	.report_final = hits_drops_report_final,
-};
-
-const struct bench bench_trig_fentry = {
-	.name = "trig-fentry",
-	.validate = trigger_validate,
-	.setup = trigger_fentry_setup,
-	.producer_thread = trigger_producer,
-	.measure = trigger_measure,
-	.report_progress = hits_drops_report_progress,
-	.report_final = hits_drops_report_final,
-};
-
-const struct bench bench_trig_fexit = {
-	.name = "trig-fexit",
-	.validate = trigger_validate,
-	.setup = trigger_fexit_setup,
-	.producer_thread = trigger_producer,
-	.measure = trigger_measure,
-	.report_progress = hits_drops_report_progress,
-	.report_final = hits_drops_report_final,
-};
-
-const struct bench bench_trig_fentry_sleep = {
-	.name = "trig-fentry-sleep",
-	.validate = trigger_validate,
-	.setup = trigger_fentry_sleep_setup,
-	.producer_thread = trigger_producer,
-	.measure = trigger_measure,
-	.report_progress = hits_drops_report_progress,
-	.report_final = hits_drops_report_final,
-};
-
-const struct bench bench_trig_fmodret = {
-	.name = "trig-fmodret",
+const struct bench bench_trig_syscall_count = {
+	.name = "trig-syscall-count",
 	.validate = trigger_validate,
-	.setup = trigger_fmodret_setup,
+	.setup = trigger_syscall_count_setup,
 	.producer_thread = trigger_producer,
 	.measure = trigger_measure,
 	.report_progress = hits_drops_report_progress,
@@ -503,7 +342,7 @@ const struct bench bench_trig_fmodret = {
 };
 
 /* batched (staying mostly in kernel) kprobe/fentry benchmarks */
-#define BENCH_TRIG_BATCH(KIND, NAME)					\
+#define BENCH_TRIG_KERNEL(KIND, NAME)					\
 const struct bench bench_trig_##KIND = {				\
 	.name = "trig-" NAME,						\
 	.setup = trigger_##KIND##_setup,				\
@@ -514,13 +353,13 @@ const struct bench bench_trig_##KIND = {				\
 	.argp = &bench_trigger_batch_argp,				\
 }
 
-BENCH_TRIG_BATCH(kernel_count, "kernel-count");
-BENCH_TRIG_BATCH(kprobe_batch, "kprobe-batch");
-BENCH_TRIG_BATCH(kretprobe_batch, "kretprobe-batch");
-BENCH_TRIG_BATCH(kprobe_multi_batch, "kprobe-multi-batch");
-BENCH_TRIG_BATCH(kretprobe_multi_batch, "kretprobe-multi-batch");
-BENCH_TRIG_BATCH(fentry_batch, "fentry-batch");
-BENCH_TRIG_BATCH(fexit_batch, "fexit-batch");
+BENCH_TRIG_KERNEL(kernel_count, "kernel-count");
+BENCH_TRIG_KERNEL(kprobe, "kprobe");
+BENCH_TRIG_KERNEL(kretprobe, "kretprobe");
+BENCH_TRIG_KERNEL(kprobe_multi, "kprobe-multi");
+BENCH_TRIG_KERNEL(kretprobe_multi, "kretprobe-multi");
+BENCH_TRIG_KERNEL(fentry, "fentry");
+BENCH_TRIG_KERNEL(fexit, "fexit");
 
 /* uprobe benchmarks */
 #define BENCH_TRIG_USERMODE(KIND, PRODUCER, NAME)			\
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh b/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
index b58ec33ea18c..6e790e294260 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
@@ -4,12 +4,9 @@ set -eufo pipefail
 
 def_tests=( \
 	usermode-count kernel-count syscall-count \
-	fentry-batch fexit-batch \
-	kprobe-batch kprobe-multi-batch \
-	kretprobe-batch kretprobe-multi-batch \
-	fentry fexit fmodret \
-	rawtp tp \
-	kprobe kprobe-multi kretprobe kretprobe-multi \
+	fentry fexit \
+	kprobe kprobe-multi \
+	kretprobe kretprobe-multi \
 )
 
 tests=("$@")
@@ -21,5 +18,5 @@ p=${PROD_CNT:-1}
 
 for t in "${tests[@]}"; do
 	summary=$(sudo ./bench -w2 -d5 -a -p$p trig-$t | tail -n1 | cut -d'(' -f1 | cut -d' ' -f3-)
-	printf "%-21s: %s\n" $t "$summary"
+	printf "%-15s: %s\n" $t "$summary"
 done
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh b/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
index 36021d243397..af169f831f2f 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
@@ -2,7 +2,7 @@
 
 set -eufo pipefail
 
-for i in usermode-count base {uprobe,uretprobe}-{nop,push,ret}
+for i in usermode-count syscall-count {uprobe,uretprobe}-{nop,push,ret}
 do
 	summary=$(sudo ./bench -w2 -d5 -a trig-$i | tail -n1 | cut -d'(' -f1 | cut -d' ' -f3-)
 	printf "%-15s: %s\n" $i "$summary"
diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
index f0b76afa5017..81990e45b547 100644
--- a/tools/testing/selftests/bpf/progs/trigger_bench.c
+++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
@@ -25,77 +25,6 @@ static __always_inline void inc_counter(void)
 	__sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
 }
 
-SEC("tp/syscalls/sys_enter_getpgid")
-int bench_trigger_tp(void *ctx)
-{
-	inc_counter();
-	return 0;
-}
-
-SEC("raw_tp/sys_enter")
-int BPF_PROG(bench_trigger_raw_tp, struct pt_regs *regs, long id)
-{
-	if (id == __NR_getpgid)
-		inc_counter();
-	return 0;
-}
-
-SEC("kprobe/" SYS_PREFIX "sys_getpgid")
-int bench_trigger_kprobe(void *ctx)
-{
-	inc_counter();
-	return 0;
-}
-
-SEC("kretprobe/" SYS_PREFIX "sys_getpgid")
-int bench_trigger_kretprobe(void *ctx)
-{
-	inc_counter();
-	return 0;
-}
-
-SEC("kprobe.multi/" SYS_PREFIX "sys_getpgid")
-int bench_trigger_kprobe_multi(void *ctx)
-{
-	inc_counter();
-	return 0;
-}
-
-SEC("kretprobe.multi/" SYS_PREFIX "sys_getpgid")
-int bench_trigger_kretprobe_multi(void *ctx)
-{
-	inc_counter();
-	return 0;
-}
-
-SEC("fentry/" SYS_PREFIX "sys_getpgid")
-int bench_trigger_fentry(void *ctx)
-{
-	inc_counter();
-	return 0;
-}
-
-SEC("fexit/" SYS_PREFIX "sys_getpgid")
-int bench_trigger_fexit(void *ctx)
-{
-	inc_counter();
-	return 0;
-}
-
-SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
-int bench_trigger_fentry_sleep(void *ctx)
-{
-	inc_counter();
-	return 0;
-}
-
-SEC("fmod_ret/" SYS_PREFIX "sys_getpgid")
-int bench_trigger_fmodret(void *ctx)
-{
-	inc_counter();
-	return -22;
-}
-
 SEC("uprobe")
 int bench_trigger_uprobe(void *ctx)
 {
@@ -128,42 +57,42 @@ int trigger_driver(void *ctx)
 }
 
 SEC("kprobe/bpf_get_numa_node_id")
-int bench_trigger_kprobe_batch(void *ctx)
+int bench_trigger_kprobe(void *ctx)
 {
 	inc_counter();
 	return 0;
 }
 
 SEC("kretprobe/bpf_get_numa_node_id")
-int bench_trigger_kretprobe_batch(void *ctx)
+int bench_trigger_kretprobe(void *ctx)
 {
 	inc_counter();
 	return 0;
 }
 
 SEC("kprobe.multi/bpf_get_numa_node_id")
-int bench_trigger_kprobe_multi_batch(void *ctx)
+int bench_trigger_kprobe_multi(void *ctx)
 {
 	inc_counter();
 	return 0;
 }
 
 SEC("kretprobe.multi/bpf_get_numa_node_id")
-int bench_trigger_kretprobe_multi_batch(void *ctx)
+int bench_trigger_kretprobe_multi(void *ctx)
 {
 	inc_counter();
 	return 0;
 }
 
 SEC("fentry/bpf_get_numa_node_id")
-int bench_trigger_fentry_batch(void *ctx)
+int bench_trigger_fentry(void *ctx)
 {
 	inc_counter();
 	return 0;
 }
 
 SEC("fexit/bpf_get_numa_node_id")
-int bench_trigger_fexit_batch(void *ctx)
+int bench_trigger_fexit(void *ctx)
 {
 	inc_counter();
 	return 0;
-- 
2.43.0

