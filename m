Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CE840244C;
	Thu, 14 May 2026 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766876; cv=none; b=Cg+4Ahx6gCKEwvM3Htwv70CpUXTl6v4qpBpxK4ac92F4j27A7j0Fszwxz69AY/NjENbFIbbUaZceqR5jmU95TKIY0tHntZq9QApxEBTaGiP97zB2MTmE6ZrV0xoKXIf4hUOREaCt3zeKyOSsqsqZTzkJ6mfIRzZ++r1fzQhIOps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766876; c=relaxed/simple;
	bh=UK17G6dklZa5Hl2vTmmy0UsIxtqzWgwovhbJ3CVUhjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXUBM2V0i2mxfBSTKj+k4VsWhJyFXnx+2YThGKC4suFMVKsSf4ZEtkSxlnBdJWswRuCMw9kPJ25bWF6HRzkn7kWJagXmw0aAsY0Wosf1x7IifITahfkv3Tew/SCjt9DKjJdzw1AjsePu16CtQfBjnvu+/k+6+xwhrYFMdKxD7hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozW1R0BM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozW1R0BM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98A0C4AF1A;
	Thu, 14 May 2026 13:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778766875;
	bh=UK17G6dklZa5Hl2vTmmy0UsIxtqzWgwovhbJ3CVUhjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ozW1R0BMhOZqPvA43YSDVLmS9AZhSQKCgKPlTy+c6GFy2NtNHWILV7gBlRpc4xEoj
	 AwMJYuq0GBSx2wenjELMO2zBNlhAffRt1KAUCuBDaKVgTO3bqtwmNarOgFCmwGsD7T
	 aTgHsb3dO6lBoomQP2/EsdYAi8/NabNTxtlG5DIAL9pFO5MXwpKTlDoDxEgBSE+jnS
	 jFLqcde4e0yxDWDEKoijf/IdwXkmG4aZbNzPLD1u1oCJlkrWaLN/t4w9krkC1aExEh
	 EKcQKuHhj/qHz99+43NLkjhbqPIiCh1J0fJQW2m76wRqs0b4j+Xu2HOpI39mtdhwle
	 7Q5ke+smf6XgQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 5/7] selftests/bpf: Change uprobe/usdt trigger bench code to use nop10
Date: Thu, 14 May 2026 15:53:40 +0200
Message-ID: <20260514135342.22130-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514135342.22130-1-jolsa@kernel.org>
References: <20260514135342.22130-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changing uprobe/usdt trigger bench code to use nop10 instead
of nop5. Also changing un_bench_uprobes.sh to use nop10 triggers.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/bench.c           | 20 +++++------
 .../selftests/bpf/benchs/bench_trigger.c      | 36 +++++++++----------
 .../selftests/bpf/benchs/run_bench_uprobes.sh |  2 +-
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 6155ce455c27..1252a1af2e84 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -539,12 +539,12 @@ extern const struct bench bench_trig_uretprobe_multi_push;
 extern const struct bench bench_trig_uprobe_multi_ret;
 extern const struct bench bench_trig_uretprobe_multi_ret;
 #ifdef __x86_64__
-extern const struct bench bench_trig_uprobe_nop5;
-extern const struct bench bench_trig_uretprobe_nop5;
-extern const struct bench bench_trig_uprobe_multi_nop5;
-extern const struct bench bench_trig_uretprobe_multi_nop5;
+extern const struct bench bench_trig_uprobe_nop10;
+extern const struct bench bench_trig_uretprobe_nop10;
+extern const struct bench bench_trig_uprobe_multi_nop10;
+extern const struct bench bench_trig_uretprobe_multi_nop10;
 extern const struct bench bench_trig_usdt_nop;
-extern const struct bench bench_trig_usdt_nop5;
+extern const struct bench bench_trig_usdt_nop10;
 #endif
 
 extern const struct bench bench_rb_libbpf;
@@ -619,12 +619,12 @@ static const struct bench *benchs[] = {
 	&bench_trig_uprobe_multi_ret,
 	&bench_trig_uretprobe_multi_ret,
 #ifdef __x86_64__
-	&bench_trig_uprobe_nop5,
-	&bench_trig_uretprobe_nop5,
-	&bench_trig_uprobe_multi_nop5,
-	&bench_trig_uretprobe_multi_nop5,
+	&bench_trig_uprobe_nop10,
+	&bench_trig_uretprobe_nop10,
+	&bench_trig_uprobe_multi_nop10,
+	&bench_trig_uretprobe_multi_nop10,
 	&bench_trig_usdt_nop,
-	&bench_trig_usdt_nop5,
+	&bench_trig_usdt_nop10,
 #endif
 	/* ringbuf/perfbuf benchmarks */
 	&bench_rb_libbpf,
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index bcc4820c802e..3998ea8ff9aa 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -396,15 +396,15 @@ static void *uprobe_producer_ret(void *input)
 }
 
 #ifdef __x86_64__
-__nocf_check __weak void uprobe_target_nop5(void)
+__nocf_check __weak void uprobe_target_nop10(void)
 {
 	asm volatile (".byte 0x66, 0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00");
 }
 
-static void *uprobe_producer_nop5(void *input)
+static void *uprobe_producer_nop10(void *input)
 {
 	while (true)
-		uprobe_target_nop5();
+		uprobe_target_nop10();
 	return NULL;
 }
 
@@ -418,7 +418,7 @@ static void *uprobe_producer_usdt_nop(void *input)
 	return NULL;
 }
 
-static void *uprobe_producer_usdt_nop5(void *input)
+static void *uprobe_producer_usdt_nop10(void *input)
 {
 	while (true)
 		usdt_2();
@@ -542,24 +542,24 @@ static void uretprobe_multi_ret_setup(void)
 }
 
 #ifdef __x86_64__
-static void uprobe_nop5_setup(void)
+static void uprobe_nop10_setup(void)
 {
-	usetup(false, false /* !use_multi */, &uprobe_target_nop5);
+	usetup(false, false /* !use_multi */, &uprobe_target_nop10);
 }
 
-static void uretprobe_nop5_setup(void)
+static void uretprobe_nop10_setup(void)
 {
-	usetup(true, false /* !use_multi */, &uprobe_target_nop5);
+	usetup(true, false /* !use_multi */, &uprobe_target_nop10);
 }
 
-static void uprobe_multi_nop5_setup(void)
+static void uprobe_multi_nop10_setup(void)
 {
-	usetup(false, true /* use_multi */, &uprobe_target_nop5);
+	usetup(false, true /* use_multi */, &uprobe_target_nop10);
 }
 
-static void uretprobe_multi_nop5_setup(void)
+static void uretprobe_multi_nop10_setup(void)
 {
-	usetup(true, true /* use_multi */, &uprobe_target_nop5);
+	usetup(true, true /* use_multi */, &uprobe_target_nop10);
 }
 
 static void usdt_setup(const char *name)
@@ -598,7 +598,7 @@ static void usdt_nop_setup(void)
 	usdt_setup("usdt_1");
 }
 
-static void usdt_nop5_setup(void)
+static void usdt_nop10_setup(void)
 {
 	usdt_setup("usdt_2");
 }
@@ -665,10 +665,10 @@ BENCH_TRIG_USERMODE(uretprobe_multi_nop, nop, "uretprobe-multi-nop");
 BENCH_TRIG_USERMODE(uretprobe_multi_push, push, "uretprobe-multi-push");
 BENCH_TRIG_USERMODE(uretprobe_multi_ret, ret, "uretprobe-multi-ret");
 #ifdef __x86_64__
-BENCH_TRIG_USERMODE(uprobe_nop5, nop5, "uprobe-nop5");
-BENCH_TRIG_USERMODE(uretprobe_nop5, nop5, "uretprobe-nop5");
-BENCH_TRIG_USERMODE(uprobe_multi_nop5, nop5, "uprobe-multi-nop5");
-BENCH_TRIG_USERMODE(uretprobe_multi_nop5, nop5, "uretprobe-multi-nop5");
+BENCH_TRIG_USERMODE(uprobe_nop10, nop10, "uprobe-nop10");
+BENCH_TRIG_USERMODE(uretprobe_nop10, nop10, "uretprobe-nop10");
+BENCH_TRIG_USERMODE(uprobe_multi_nop10, nop10, "uprobe-multi-nop10");
+BENCH_TRIG_USERMODE(uretprobe_multi_nop10, nop10, "uretprobe-multi-nop10");
 BENCH_TRIG_USERMODE(usdt_nop, usdt_nop, "usdt-nop");
-BENCH_TRIG_USERMODE(usdt_nop5, usdt_nop5, "usdt-nop5");
+BENCH_TRIG_USERMODE(usdt_nop10, usdt_nop10, "usdt-nop10");
 #endif
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh b/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
index 9ec59423b949..e490b337e960 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
@@ -2,7 +2,7 @@
 
 set -eufo pipefail
 
-for i in usermode-count syscall-count {uprobe,uretprobe}-{nop,push,ret,nop5} usdt-nop usdt-nop5
+for i in usermode-count syscall-count {uprobe,uretprobe}-{nop,push,ret,nop10} usdt-nop usdt-nop10
 do
 	summary=$(sudo ./bench -w2 -d5 -a trig-$i | tail -n1 | cut -d'(' -f1 | cut -d' ' -f3-)
 	printf "%-15s: %s\n" $i "$summary"
-- 
2.53.0

