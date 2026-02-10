Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C471DC198;
	Tue, 10 Feb 2026 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770730665; cv=none; b=n304bdumv9RS9+n89jSMrxce0hj8imLh9iDTt373GwyB+1Q8xmuwAYq5orMjst1ekVVgh3BflVFizoSEon36rrWLQYK219Yw7sIIRyBOaAc1f6h3mVUQOq+0U3qCqHIUmfngz80GmQ/EZfuNuPAsLgiOiFu3PZjWrFkWxhNmOfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770730665; c=relaxed/simple;
	bh=j/ImcZTftZ2nzFNq2YJAfz4LlmzAH/8itUNdqym9u14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RrNiUIq18bgF33Wvz6IPR0NFId4vzXCD3+SN16/7tcVLzyObLC1AL1y4whrlr5VYexWXMA4ic2r3/v3DGkVPDpA9tJ8crVzlugHyMH6aLrNkp/lAy/W+wbc6ICh/A8jPcmczCFpLTJEDOckD+lLWuQMkVaiUi79Qq5FuW0zyGdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWZrq5L/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWZrq5L/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37691C16AAE;
	Tue, 10 Feb 2026 13:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770730665;
	bh=j/ImcZTftZ2nzFNq2YJAfz4LlmzAH/8itUNdqym9u14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nWZrq5L/Yr1+dHrIBUnQ+7+cNDq26K+9cxBp000JitT2QD9Xi0SwkHg4Q35eVgXxH
	 wg6DrmZwrtGcR4vli3lKZr/U/CCTSLt7P76terJjY8QpJROYLSm2w7VIHZFLfvFA9J
	 +cXgrwMqFwnfwycCTYQ9lDMl1j/fodFZAmEFbRhz4Xj2pJTUU0deoE9WvHa087AZyK
	 V49hXYRe/VO8nq1JgvghZyasvHKGNzKqJKzMLpRzqa9zrru/OHqZAxJvJZtIiInZeO
	 hHiSVbOOyN3cqSh9nAOIbYdIgIjjn9UXxdH8mqMTEDsbpJeEfBCGMgar18xp0arprh
	 XPbO5EkuVTowQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCHv2 bpf-next 5/5] selftests/bpf: Add usdt trigger bench
Date: Tue, 10 Feb 2026 14:36:49 +0100
Message-ID: <20260210133649.524292-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260210133649.524292-1-jolsa@kernel.org>
References: <20260210133649.524292-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adding usdt trigger bench for usdt:
 trig-usdt_nop - usdt on top of nop1 instruction
 trig-usdt_nop_combo - usdt on top of nop1/nop5 combo

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
  usdt_nop       :    3.235 ± 0.008M/s   <-- added
  usdt_nop_combo :    7.511 ± 0.045M/s   <-- added

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |  2 +
 tools/testing/selftests/bpf/bench.c           |  4 ++
 .../selftests/bpf/benchs/bench_trigger.c      | 60 +++++++++++++++++++
 .../selftests/bpf/benchs/run_bench_uprobes.sh |  2 +-
 .../selftests/bpf/progs/trigger_bench.c       | 10 +++-
 5 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 306949162a5b..9b2ca0028322 100644
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
index 8368bd3a0665..4dacb87e464e 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -541,6 +541,8 @@ extern const struct bench bench_trig_uprobe_nop5;
 extern const struct bench bench_trig_uretprobe_nop5;
 extern const struct bench bench_trig_uprobe_multi_nop5;
 extern const struct bench bench_trig_uretprobe_multi_nop5;
+extern const struct bench bench_trig_usdt_nop;
+extern const struct bench bench_trig_usdt_nop_combo;
 #endif
 
 extern const struct bench bench_rb_libbpf;
@@ -617,6 +619,8 @@ static const struct bench *benchs[] = {
 	&bench_trig_uretprobe_nop5,
 	&bench_trig_uprobe_multi_nop5,
 	&bench_trig_uretprobe_multi_nop5,
+	&bench_trig_usdt_nop,
+	&bench_trig_usdt_nop_combo,
 #endif
 	/* ringbuf/perfbuf benchmarks */
 	&bench_rb_libbpf,
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index aeec9edd3851..b4b03fe1f61d 100644
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
+static void *uprobe_producer_usdt_nop_combo(void *input)
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
+static void usdt_nop_combo_setup(void)
+{
+	usdt_setup("usdt_2");
+}
 #endif
 
 const struct bench bench_trig_syscall_count = {
@@ -609,4 +667,6 @@ BENCH_TRIG_USERMODE(uprobe_nop5, nop5, "uprobe-nop5");
 BENCH_TRIG_USERMODE(uretprobe_nop5, nop5, "uretprobe-nop5");
 BENCH_TRIG_USERMODE(uprobe_multi_nop5, nop5, "uprobe-multi-nop5");
 BENCH_TRIG_USERMODE(uretprobe_multi_nop5, nop5, "uretprobe-multi-nop5");
+BENCH_TRIG_USERMODE(usdt_nop, usdt_nop, "usdt_nop");
+BENCH_TRIG_USERMODE(usdt_nop_combo, usdt_nop_combo, "usdt_nop_combo");
 #endif
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh b/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
index 03f55405484b..3656676d99d2 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
@@ -2,7 +2,7 @@
 
 set -eufo pipefail
 
-for i in usermode-count syscall-count {uprobe,uretprobe}-{nop,push,ret,nop5}
+for i in usermode-count syscall-count {uprobe,uretprobe}-{nop,push,ret,nop5} usdt_nop usdt_nop_combo
 do
 	summary=$(sudo ./bench -w2 -d5 -a trig-$i | tail -n1 | cut -d'(' -f1 | cut -d' ' -f3-)
 	printf "%-15s: %s\n" $i "$summary"
diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
index 4ea0422d1042..f631706bbdc9 100644
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
+SEC("usdt")
+int bench_trigger_usdt(void *ctx)
+{
+	inc_counter();
+	return 0;
+}
-- 
2.53.0

