Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617EF3CAE84;
	Fri,  3 Jul 2026 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079483; cv=none; b=kFjcyF6KhNZ34je1Suxpr6XaDY4QMtpKtn8EO1TbGS7Kz/kKRqApz//3NQlZozLCMJcEwt24xVJkO68JsJnN86L9tGxg1BM95LsTC92665y/19d/ilv/TFSPemmMdTjipaDJV4CTA0KDPZS5eljFqiEXCRwNZOmWHw9nRO/i9zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079483; c=relaxed/simple;
	bh=+zTM8mh035Hoog3VAAWBa8I4HI6gVKu4c23FjpySSvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDBKHIoB9IGqvKwfVMUxuEZnhol5RoNnxk0Om+CdIrNmXbt03DoPH4HMzu70HwPzVIzGr0DRJwe6mdRw4mDvnc/S0xZgukdWk/rfNbbjbs9gziow62Fa14gGDn6sWviuge1he+QitPDRNQUESPxPbZ9zGGL6L1Y8zX8MqpxAE+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0nZO3c5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0nZO3c5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4EA1F00A3D;
	Fri,  3 Jul 2026 11:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783079482;
	bh=Tr0MA1Ufb13rBonx+3sQlWzZanNCBrEWCbq0YZCoglc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J0nZO3c5lBZzMyOtMkfkPkctAxiO7ZB3Woz+CAPGkT9gfwsE+KCJwIFF7IlNN4fYR
	 2nF4KgvLo+CzeoREoFGd3SxpofzwyvQMZl6wqAbLTIuIJyHlno5qk+vekYUp7K4FoK
	 sUveCOqpLWCe+Y3EDkcA415tQeYoUdAdaaSrKk94fz9+ITolgD8t9TKsqfD0ofKFLW
	 j8vqWtxCueVYncVD7wvMMuRu0GG7L6cUSi40bweirDFN4qOEVXAUuTlpCHI8Kr0kUs
	 mXRFMKoJNieT4O8hyGdb/yUiFmPEuCeu+balTXiUnxW0/sOh1f5Ow7hFGlruy1Nr1W
	 GAMhh7zQL8MXw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv6 10/13] selftests/bpf: Change uprobe/usdt trigger bench code to use nop10
Date: Fri,  3 Jul 2026 13:49:14 +0200
Message-ID: <20260703114917.238144-11-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703114917.238144-1-jolsa@kernel.org>
References: <20260703114917.238144-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changing uprobe/usdt trigger bench code to use nop10 instead
of nop5. Also changing run_bench_uprobes.sh to use nop10 triggers.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/bench.c           | 20 +++++------
 .../selftests/bpf/benchs/bench_trigger.c      | 36 +++++++++----------
 .../selftests/bpf/benchs/run_bench_uprobes.sh |  2 +-
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 3d9d2cd7764b..c4a3a6b3eb83 100644
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
@@ -622,12 +622,12 @@ static const struct bench *benchs[] = {
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
2.54.0

