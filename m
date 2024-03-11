Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4243CF6A
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710191429; cv=none; b=gbuO8kM+UYRhfDl6JDxnuhDnowYSFvfAEc+50yPxvnC01+2Ei2T46ZuHr/MTK5Z4fG3NBhl4VMLiM7xrDPKcxFn321sBg7rDCSj/DgCPv4umtzTPYyHnGWmbO4TSc9Tx9Cw6PoZAz9cMMtvEGriX7hUXhlYtDnsaRCHLWsdMRss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710191429; c=relaxed/simple;
	bh=tXdXGegJUj2reKoxdV6Go21eCT8WV624YS2KR8dAzgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A6eYhYHkxzQKtbV5w9vK1KG/jQjA3cOhRmm/sNmQrFhSYZXPlJrEsbG4DxMoCiHCB6f1YSus6p/krYgsfkPThi943SX4Pz4sLYIkcCKcz4wEJDvTfvip9morElU7VfhDgvFC8so4BxBFRBizSzx5k4ybOGW+9/bI5kACOx4CTEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOwA3Qr1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOwA3Qr1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E56C433C7;
	Mon, 11 Mar 2024 21:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710191429;
	bh=tXdXGegJUj2reKoxdV6Go21eCT8WV624YS2KR8dAzgo=;
	h=From:To:Cc:Subject:Date:From;
	b=IOwA3Qr1yxXCt4yW+R4/fR85Tpq1ZhlUWC+WnTYIPZmJMkyv784LQjHgsHM/ok3kF
	 l1efZqUxQg1X59mz49b4cCBWBgx1dsA7h45XO0hHUqlxiWuSMWTnEniGCUnJFIKLJz
	 0nJ5EbEvZfJT66t+8MG0jh5SW3/SFns1e3KkXqcMitoHWwrMhIvG80JBY9/M5H2w+D
	 0SVC1wDLyiIR0HJCEdNIxANeWVuOWNGcZMDh9TbGwhz6dZgePVteLugsc6kccTdsqx
	 MwHEoKFj5sCVKBnfiZ+Qq9RFFsO4ebEc0sT9RwwAxwzwqLkc1dpo+uYAg4U2EeC0bN
	 +pp34952jwj6A==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Add kprobe multi triggering benchmarks
Date: Mon, 11 Mar 2024 22:10:23 +0100
Message-ID: <20240311211023.590321-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding kprobe multi triggering benchmarks. It's useful now to bench
new fprobe implementation and might be useful later as well.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/bench.c           |  4 +++
 .../selftests/bpf/benchs/bench_trigger.c      | 32 +++++++++++++++++++
 .../selftests/bpf/progs/trigger_bench.c       | 14 ++++++++
 3 files changed, 50 insertions(+)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 8e02645afe31..b2b4c391eb0a 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -496,6 +496,8 @@ extern const struct bench bench_trig_tp;
 extern const struct bench bench_trig_rawtp;
 extern const struct bench bench_trig_kprobe;
 extern const struct bench bench_trig_kretprobe;
+extern const struct bench bench_trig_kprobe_multi;
+extern const struct bench bench_trig_kretprobe_multi;
 extern const struct bench bench_trig_fentry;
 extern const struct bench bench_trig_fexit;
 extern const struct bench bench_trig_fentry_sleep;
@@ -542,6 +544,8 @@ static const struct bench *benchs[] = {
 	&bench_trig_rawtp,
 	&bench_trig_kprobe,
 	&bench_trig_kretprobe,
+	&bench_trig_kprobe_multi,
+	&bench_trig_kretprobe_multi,
 	&bench_trig_fentry,
 	&bench_trig_fexit,
 	&bench_trig_fentry_sleep,
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 3f24be9cfcb9..ace0d1011a8e 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -91,6 +91,18 @@ static void trigger_kretprobe_setup(void)
 	attach_bpf(ctx.skel->progs.bench_trigger_kretprobe);
 }
 
+static void trigger_kprobe_multi_setup(void)
+{
+	setup_ctx();
+	attach_bpf(ctx.skel->progs.bench_trigger_kprobe_multi);
+}
+
+static void trigger_kretprobe_multi_setup(void)
+{
+	setup_ctx();
+	attach_bpf(ctx.skel->progs.bench_trigger_kretprobe_multi);
+}
+
 static void trigger_fentry_setup(void)
 {
 	setup_ctx();
@@ -283,6 +295,26 @@ const struct bench bench_trig_kretprobe = {
 	.report_final = hits_drops_report_final,
 };
 
+const struct bench bench_trig_kprobe_multi = {
+	.name = "trig-kprobe-multi",
+	.validate = trigger_validate,
+	.setup = trigger_kprobe_multi_setup,
+	.producer_thread = trigger_producer,
+	.measure = trigger_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
+
+const struct bench bench_trig_kretprobe_multi = {
+	.name = "trig-kretprobe-multi",
+	.validate = trigger_validate,
+	.setup = trigger_kretprobe_multi_setup,
+	.producer_thread = trigger_producer,
+	.measure = trigger_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
+
 const struct bench bench_trig_fentry = {
 	.name = "trig-fentry",
 	.validate = trigger_validate,
diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
index eb94f9c0186f..5fda43901033 100644
--- a/tools/testing/selftests/bpf/progs/trigger_bench.c
+++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
@@ -40,6 +40,20 @@ int bench_trigger_kretprobe(void *ctx)
 	return 0;
 }
 
+SEC("kprobe.multi/" SYS_PREFIX "sys_getpgid")
+int bench_trigger_kprobe_multi(void *ctx)
+{
+	__sync_add_and_fetch(&hits, 1);
+	return 0;
+}
+
+SEC("kretprobe.multi/" SYS_PREFIX "sys_getpgid")
+int bench_trigger_kretprobe_multi(void *ctx)
+{
+	__sync_add_and_fetch(&hits, 1);
+	return 0;
+}
+
 SEC("fentry/" SYS_PREFIX "sys_getpgid")
 int bench_trigger_fentry(void *ctx)
 {
-- 
2.44.0

