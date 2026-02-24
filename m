Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8D8377551;
	Tue, 24 Feb 2026 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929615; cv=none; b=pUTcEetij8EF//w5p7BH9Df1ARto8Cnjso4lfFioGzXdp9DP2ok+6Ut9qQ1O5NAo3+rh9b38p8MW6YsZjfYzLXw2t8ziy2ELpaVoHtljKAkh4QpUw5tVaD/47m4TcMZn5lOmjyI9DPKSsfuiGisJbnq1etM0R6z0vTthtDECBy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929615; c=relaxed/simple;
	bh=F+27PLKRsMR9oBOYaHEH2ngLd8FV0hMP80Zyg/41MHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PP7//xYjWEVED4EFBhdaCObK44C/rXiK1nVmIVZyn4luLUYsEMsrwAbj3ZDeVNiPHhom5Prd8iy4oBSUhkvea88vHSqPM1CVBBrno0NJn4o8qTJxk7l9TuFxxz9XuHNqBWSxDNGqr7/yRCXMd+cevYG0WdDaQPZ6ow0LcdbI+mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOCwEqF5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOCwEqF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6322AC116D0;
	Tue, 24 Feb 2026 10:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771929615;
	bh=F+27PLKRsMR9oBOYaHEH2ngLd8FV0hMP80Zyg/41MHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bOCwEqF51QTlIU+XhLgvUTQTmM594NK59hVXtqWieqVnu5HEmQpfQLiqFFoxHFied
	 24ITGEN3iQ/pHZeByxS3Y9TZhNwcOmo860OwcEik/IoS5px/jXFacviWxhBJNc6vn1
	 uslR9V7FLNAdUPOo2g8g/s8HsEcBRvgUHrBUvxK1Rzs0xHP2svYTb3Ct8CX/RVk6/v
	 zw2Nx4PkWQiGB03Bt/+G57ywGzHKUdpj2zOpxFbV+Ix8BiRYCMlw6KHRIT0Jj43nAI
	 E7MZl0Z0zcrjRI8xsCzqarUnf86yft3GI6czeBf8jnog8Mg6qdUzBeIrINb4XNotlb
	 7Y0f1aLR2v+9g==
From: Jiri Olsa <jolsa@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCHv5 bpf-next 5/5] selftests/bpf: Add usdt trigger bench
Date: Tue, 24 Feb 2026 11:39:15 +0100
Message-ID: <20260224103915.1369690-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224103915.1369690-1-jolsa@kernel.org>
References: <20260224103915.1369690-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adding usdt trigger bench for usdt:
 trig-usdt-nop  - usdt on top of nop1 instruction
 trig-usdt-nop5 - usdt on top of nop1/nop5 combo

Adding it to benchs/run_bench_uprobes.sh script.

Example run on x86_64 kernel with uprobe syscall:

  # ./benchs/run_bench_uprobes.sh
  usermode-count :  152.507 ± 0.098M/s
  syscall-count  :   14.309 ± 0.093M/s
  uprobe-nop     :    3.190 ± 0.012M/s
  uprobe-push    :    3.057 ± 0.004M/s
  uprobe-ret     :    1.095 ± 0.009M/s
  uprobe-nop5    :    7.305 ± 0.034M/s
  uretprobe-nop  :    2.175 ± 0.005M/s
  uretprobe-push :    2.109 ± 0.003M/s
  uretprobe-ret  :    0.945 ± 0.002M/s
  uretprobe-nop5 :    3.530 ± 0.006M/s
  usdt-nop       :    3.235 ± 0.008M/s   <-- added
  usdt-nop5      :    7.511 ± 0.045M/s   <-- added

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |  2 +
 tools/testing/selftests/bpf/bench.c           |  4 ++
 .../selftests/bpf/benchs/bench_trigger.c      | 60 +++++++++++++++++++
 .../selftests/bpf/benchs/run_bench_uprobes.sh |  2 +-
 .../selftests/bpf/progs/trigger_bench.c       | 10 +++-
 5 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 23857d17fc5b..8196128251d5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -874,6 +874,8 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_bpf_crypto.o \
 		 $(OUTPUT)/bench_sockmap.o \
 		 $(OUTPUT)/bench_lpm_trie_map.o \
+		 $(OUTPUT)/usdt_1.o \
+		 $(OUTPUT)/usdt_2.o \
 		 #
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 8368bd3a0665..029b3e21f438 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -541,6 +541,8 @@ extern const struct bench bench_trig_uprobe_nop5;
 extern const struct bench bench_trig_uretprobe_nop5;
 extern const struct bench bench_trig_uprobe_multi_nop5;
 extern const struct bench bench_trig_uretprobe_multi_nop5;
+extern const struct bench bench_trig_usdt_nop;
+extern const struct bench bench_trig_usdt_nop5;
 #endif
 
 extern const struct bench bench_rb_libbpf;
@@ -617,6 +619,8 @@ static const struct bench *benchs[] = {
 	&bench_trig_uretprobe_nop5,
 	&bench_trig_uprobe_multi_nop5,
 	&bench_trig_uretprobe_multi_nop5,
+	&bench_trig_usdt_nop,
+	&bench_trig_usdt_nop5,
 #endif
 	/* ringbuf/perfbuf benchmarks */
 	&bench_rb_libbpf,
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index aeec9edd3851..2ee6a2df2c26 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -405,6 +405,23 @@ static void *uprobe_producer_nop5(void *input)
 		uprobe_target_nop5();
 	return NULL;
 }
+
+void usdt_1(void);
+void usdt_2(void);
+
+static void *uprobe_producer_usdt_nop(void *input)
+{
+	while (true)
+		usdt_1();
+	return NULL;
+}
+
+static void *uprobe_producer_usdt_nop5(void *input)
+{
+	while (true)
+		usdt_2();
+	return NULL;
+}
 #endif
 
 static void usetup(bool use_retprobe, bool use_multi, void *target_addr)
@@ -542,6 +559,47 @@ static void uretprobe_multi_nop5_setup(void)
 {
 	usetup(true, true /* use_multi */, &uprobe_target_nop5);
 }
+
+static void usdt_setup(const char *name)
+{
+	struct bpf_link *link;
+	int err;
+
+	setup_libbpf();
+
+	ctx.skel = trigger_bench__open();
+	if (!ctx.skel) {
+		fprintf(stderr, "failed to open skeleton\n");
+		exit(1);
+	}
+
+	bpf_program__set_autoload(ctx.skel->progs.bench_trigger_usdt, true);
+
+	err = trigger_bench__load(ctx.skel);
+	if (err) {
+		fprintf(stderr, "failed to load skeleton\n");
+		exit(1);
+	}
+
+	link = bpf_program__attach_usdt(ctx.skel->progs.bench_trigger_usdt,
+					0 /*self*/, "/proc/self/exe",
+					"optimized_attach", name, NULL);
+	if (libbpf_get_error(link)) {
+		fprintf(stderr, "failed to attach optimized_attach:%s usdt probe\n", name);
+		exit(1);
+	}
+	ctx.skel->links.bench_trigger_usdt = link;
+}
+
+static void usdt_nop_setup(void)
+{
+	usdt_setup("usdt_1");
+}
+
+static void usdt_nop5_setup(void)
+{
+	usdt_setup("usdt_2");
+}
 #endif
 
 const struct bench bench_trig_syscall_count = {
@@ -609,4 +667,6 @@ BENCH_TRIG_USERMODE(uprobe_nop5, nop5, "uprobe-nop5");
 BENCH_TRIG_USERMODE(uretprobe_nop5, nop5, "uretprobe-nop5");
 BENCH_TRIG_USERMODE(uprobe_multi_nop5, nop5, "uprobe-multi-nop5");
 BENCH_TRIG_USERMODE(uretprobe_multi_nop5, nop5, "uretprobe-multi-nop5");
+BENCH_TRIG_USERMODE(usdt_nop, usdt_nop, "usdt-nop");
+BENCH_TRIG_USERMODE(usdt_nop5, usdt_nop5, "usdt-nop5");
 #endif
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh b/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
index 03f55405484b..9ec59423b949 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
@@ -2,7 +2,7 @@
 
 set -eufo pipefail
 
-for i in usermode-count syscall-count {uprobe,uretprobe}-{nop,push,ret,nop5}
+for i in usermode-count syscall-count {uprobe,uretprobe}-{nop,push,ret,nop5} usdt-nop usdt-nop5
 do
 	summary=$(sudo ./bench -w2 -d5 -a trig-$i | tail -n1 | cut -d'(' -f1 | cut -d' ' -f3-)
 	printf "%-15s: %s\n" $i "$summary"
diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
index 4ea0422d1042..3225b4aee8ff 100644
--- a/tools/testing/selftests/bpf/progs/trigger_bench.c
+++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2020 Facebook
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <asm/unistd.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
+#include "bpf/usdt.bpf.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -180,3 +181,10 @@ int bench_trigger_rawtp(void *ctx)
 	handle(ctx);
 	return 0;
 }
+
+SEC("?usdt")
+int bench_trigger_usdt(void *ctx)
+{
+	inc_counter();
+	return 0;
+}
-- 
2.53.0

