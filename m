Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A48F9F8
	for <bpf@vger.kernel.org>; Sat,  9 Mar 2024 00:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709945486; cv=none; b=pPQQTffX1E7B4JbZxZdBgudCVXZd1cRdJf+pO+ydIq1MkwVhmAHC78mGR0V4GMvspxQ7KrR3x6lNgdaeowWVv7OUpKQZrxHPhykso6IG9ddEIDsIbuAfkswIkIc/f5il8/CZGcO96GzrcKf5MJZXNZhFcef1CrW/GbAqkJfXAbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709945486; c=relaxed/simple;
	bh=WB2XXF6DF4QNTlz/uhYPYRQYkfEybOkNy/jHBqbALWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IVk/wJEzI5G++V3AbJLDLJep2Y4B34xEIpDiKFMivTYKa3N05UYX+fz0a70OAHYTd46LB729XbPohn2PXiyWaLXu5qfva8wKT/TjYu9rzZCEDZV8hNevJTi7SUpCYniUh9bhIDbqiSaq3RWhuo7KMQzwoYE7YbaVpye5n9TIKns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVTFzE19; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVTFzE19"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F61EC433C7;
	Sat,  9 Mar 2024 00:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709945486;
	bh=WB2XXF6DF4QNTlz/uhYPYRQYkfEybOkNy/jHBqbALWE=;
	h=From:To:Cc:Subject:Date:From;
	b=oVTFzE19T8iRmwSWJ3+33v+/BWxyEFGrm0ScIyUtW+bQt+3A7TNaTxH1BIqcLgNGG
	 DGqOLdVxYeGK1fABpbg3Ni2+Q8A7TU2DnXPaGAWJUiwEOeGv0R8lznJ0n6IvGiqLd9
	 IFJrcNM0i2zO2XBW8yJC9vTs4cQKLjVYNMN5j9Y+C8DLlPjOM1EP3o33qr1Ru3+Pgh
	 muUHBp3fQ/IElS37sgsqGglTQioQv10d7Q2tyV2zgENMIA7SUQj/5ngC9/yQiKKY6C
	 oorVn1PpvmkX7mSCmZTCdT7NrfFog1kgrsm/ZSmt1+n/4WvDF8IS2IGzvWraZ9QEa8
	 kbq4kUEfdPUGA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] selftests/bpf: add fexit and kretprobe triggering benchmarks
Date: Fri,  8 Mar 2024 16:51:24 -0800
Message-ID: <20240309005124.3004446-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We already have kprobe and fentry benchmarks. Let's add kretprobe and
fexit ones for completeness.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/bench.c           |  4 +++
 .../selftests/bpf/benchs/bench_trigger.c      | 32 +++++++++++++++++++
 .../selftests/bpf/progs/trigger_bench.c       | 14 ++++++++
 3 files changed, 50 insertions(+)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 60df99b6ac72..8e02645afe31 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -495,7 +495,9 @@ extern const struct bench bench_trig_base;
 extern const struct bench bench_trig_tp;
 extern const struct bench bench_trig_rawtp;
 extern const struct bench bench_trig_kprobe;
+extern const struct bench bench_trig_kretprobe;
 extern const struct bench bench_trig_fentry;
+extern const struct bench bench_trig_fexit;
 extern const struct bench bench_trig_fentry_sleep;
 extern const struct bench bench_trig_fmodret;
 extern const struct bench bench_trig_uprobe_base;
@@ -539,7 +541,9 @@ static const struct bench *benchs[] = {
 	&bench_trig_tp,
 	&bench_trig_rawtp,
 	&bench_trig_kprobe,
+	&bench_trig_kretprobe,
 	&bench_trig_fentry,
+	&bench_trig_fexit,
 	&bench_trig_fentry_sleep,
 	&bench_trig_fmodret,
 	&bench_trig_uprobe_base,
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 064a1ef7a6fb..3f24be9cfcb9 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -85,12 +85,24 @@ static void trigger_kprobe_setup(void)
 	attach_bpf(ctx.skel->progs.bench_trigger_kprobe);
 }
 
+static void trigger_kretprobe_setup(void)
+{
+	setup_ctx();
+	attach_bpf(ctx.skel->progs.bench_trigger_kretprobe);
+}
+
 static void trigger_fentry_setup(void)
 {
 	setup_ctx();
 	attach_bpf(ctx.skel->progs.bench_trigger_fentry);
 }
 
+static void trigger_fexit_setup(void)
+{
+	setup_ctx();
+	attach_bpf(ctx.skel->progs.bench_trigger_fexit);
+}
+
 static void trigger_fentry_sleep_setup(void)
 {
 	setup_ctx();
@@ -261,6 +273,16 @@ const struct bench bench_trig_kprobe = {
 	.report_final = hits_drops_report_final,
 };
 
+const struct bench bench_trig_kretprobe = {
+	.name = "trig-kretprobe",
+	.validate = trigger_validate,
+	.setup = trigger_kretprobe_setup,
+	.producer_thread = trigger_producer,
+	.measure = trigger_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
+
 const struct bench bench_trig_fentry = {
 	.name = "trig-fentry",
 	.validate = trigger_validate,
@@ -271,6 +293,16 @@ const struct bench bench_trig_fentry = {
 	.report_final = hits_drops_report_final,
 };
 
+const struct bench bench_trig_fexit = {
+	.name = "trig-fexit",
+	.validate = trigger_validate,
+	.setup = trigger_fexit_setup,
+	.producer_thread = trigger_producer,
+	.measure = trigger_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
+
 const struct bench bench_trig_fentry_sleep = {
 	.name = "trig-fentry-sleep",
 	.validate = trigger_validate,
diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
index 694e7cec1823..eb94f9c0186f 100644
--- a/tools/testing/selftests/bpf/progs/trigger_bench.c
+++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
@@ -33,6 +33,13 @@ int bench_trigger_kprobe(void *ctx)
 	return 0;
 }
 
+SEC("kretprobe/" SYS_PREFIX "sys_getpgid")
+int bench_trigger_kretprobe(void *ctx)
+{
+	__sync_add_and_fetch(&hits, 1);
+	return 0;
+}
+
 SEC("fentry/" SYS_PREFIX "sys_getpgid")
 int bench_trigger_fentry(void *ctx)
 {
@@ -40,6 +47,13 @@ int bench_trigger_fentry(void *ctx)
 	return 0;
 }
 
+SEC("fexit/" SYS_PREFIX "sys_getpgid")
+int bench_trigger_fexit(void *ctx)
+{
+	__sync_add_and_fetch(&hits, 1);
+	return 0;
+}
+
 SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
 int bench_trigger_fentry_sleep(void *ctx)
 {
-- 
2.43.0

