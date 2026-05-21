Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C373C278B;
	Thu, 21 May 2026 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367544; cv=none; b=j6lkED6oJPzLANC0EN+y2kaBGNuwmJbuZX1MYJBbek8mMLoOea+1iaY4gatZF8NvfMUVYEpGVuddUmLns3pe5j1TrdKIXRiGsEUy+Xt2KhyDn6R5EXu1t0vsDac8e5Es0S5BGZl3SXkbo+OQTj6zlJO/YGU1bFnZXODE4S8ciyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367544; c=relaxed/simple;
	bh=in4vJN0viwJNZ3TU+TidIvIYG3dk5WVIfxr2SLtiEQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NeSelNL/H5cVk9v5v3MhyKFJD9JH43l7lMLpjBR7aOCRM3IoKNF8C/Y0V83cVigxCOUT8G/qkcaGpIbGRIYWySpWau/Pq1UwXM9ol3keK8J7FjavgJLZbZQCzMAkamIZC1z/p3tSpdbsBkp9ZHLAqWK3cPZXbP0wPnlc4FZo/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMpozWPB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMpozWPB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55501F000E9;
	Thu, 21 May 2026 12:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779367543;
	bh=dhP2OxECkNsTw6KVL9fxf9oMlKwCCLdb9cemYv/CWYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZMpozWPBqUtHWeJ1vPCswAr2ZLBnBGxBlfbLWd9yZiSkdSnXK6t3rBzwCD083zRvV
	 g6fBeefGaDmK3Pk9aDesyuEcId0h6pJeokNNenMw45xy5HuFqkbQEwh2EIrHFAOJiP
	 z1cDQjxLHDbSJjbw8Q5uKQgmSI31cCw/S3vR/2vGremvvY/Nct4MJXYhSoq+G9eGfU
	 NedkvQcBfEnMEVwUbKMfp3/bQJgfy1Cs1QNpafT8h9Tzq5CSHc2qzPUkQZRK8MTlIG
	 j6V569YOL0DtoyKWTooLWcqn1pQfyICHX1F1ZG3LHVcMS/anzOCMqWM+DB+BJn28UC
	 OPJmdj630ymXQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv3 09/12] selftests/bpf: Change uprobe/usdt trigger bench code to use nop10
Date: Thu, 21 May 2026 14:44:08 +0200
Message-ID: <20260521124411.31133-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521124411.31133-1-jolsa@kernel.org>
References: <20260521124411.31133-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changing uprobe/usdt trigger bench code to use nop10 instead
of nop5. Also changing run_bench_uprobes.sh to use nop10 triggers.

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
index a60b8173cdc4..61513efc167a 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -396,15 +396,15 @@ static void *uprobe_producer_ret(void *input)
 }
 
 #ifdef __x86_64__
-__nocf_check __weak void uprobe_target_nop5(void)
+__nocf_check __weak void uprobe_target_nop10(void)
 {
 	asm volatile (".byte 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00");
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

