Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A5433471A;
	Tue,  9 Sep 2025 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421602; cv=none; b=pqRXcUoeyuvN0K5UcIZ4rUrj37phBx1Hnw4R57wKsqml4yrJy6rXC7yXWQOkbc2Jif/aB3dCij1hrzQQVYBHDpDniPTymUwRI0NMVgpBXbfwuBvlv+AKdPMDxr3ZDAvj1VYOQZGgW/oiKniOsURu+TLhQOghvwGaRBy3vjcKhw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421602; c=relaxed/simple;
	bh=DcRm/QuIJ29/54z6kYgqyNeqOZ05ZpUkyeEHfEwnpc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlN0EfMnox2w0nXm9Mz590iHtcIoqNYQmpJg0MiE5RJhicudmmZCG9+dh5o3Mi92pwXWglVDmFtY251LTrJ5Tnfd5o9jKRpeSm8gFmyIrHBVSRhi7PLfuE3SpdVm6tyjSE8oRD+L6FKk+gHzxcQ46t5qcdDZrGMzxcFMUhW27aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVmlTsvs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVmlTsvs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17217C4CEF4;
	Tue,  9 Sep 2025 12:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757421602;
	bh=DcRm/QuIJ29/54z6kYgqyNeqOZ05ZpUkyeEHfEwnpc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hVmlTsvssKVPqgCV3pY2c2IMxY6p7Bk65CBfDMopoTpW5bm04o8SYkJ6Uc1SGwFn6
	 O0BLqJhoSsvr06GLmNuslZhLE1+phByuLLBqDe8/BbU+r26grCc/XNtjkV/0sVIgc+
	 oVOryjY7aHSXGjTaM/Vh/D9fayIsRRjXbKbquqfaI9HhTIXoa4yMXorIUHwUY3txS+
	 E4mnP3yQ2f+X0hRdzboi67sRMcGnxKyS5f0N5exbYU5Rw1xbw/WdgzOJr+G1uu3I76
	 dkUaxsYo2CtQw0QU4CUnInvxd/39jWXuvr+f0PeOLKB9LsWmbM8Qqc0VV0fQ87wXKq
	 CnMEepYqbHS9g==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCHv3 perf/core 5/6] selftests/bpf: Add kprobe write ctx attach test
Date: Tue,  9 Sep 2025 14:38:56 +0200
Message-ID: <20250909123857.315599-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909123857.315599-1-jolsa@kernel.org>
References: <20250909123857.315599-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test to check we can't attach standard kprobe program that
writes to the context.

It's x86_64 specific test.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 28 +++++++++++++++++++
 .../selftests/bpf/progs/kprobe_write_ctx.c    | 15 ++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_write_ctx.c

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index cabc51c2ca6b..9e77e5da7097 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -3,6 +3,7 @@
 #include "test_attach_kprobe_sleepable.skel.h"
 #include "test_attach_probe_manual.skel.h"
 #include "test_attach_probe.skel.h"
+#include "kprobe_write_ctx.skel.h"
 
 /* this is how USDT semaphore is actually defined, except volatile modifier */
 volatile unsigned short uprobe_ref_ctr __attribute__((unused)) __attribute((section(".probes")));
@@ -201,6 +202,31 @@ static void test_attach_kprobe_long_event_name(void)
 	test_attach_probe_manual__destroy(skel);
 }
 
+#ifdef __x86_64__
+/* attach kprobe/kretprobe long event name testings */
+static void test_attach_kprobe_write_ctx(void)
+{
+	struct kprobe_write_ctx *skel = NULL;
+	struct bpf_link *link = NULL;
+
+	skel = kprobe_write_ctx__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "kprobe_write_ctx__open_and_load"))
+		return;
+
+	link = bpf_program__attach_kprobe_opts(skel->progs.kprobe_write_ctx,
+					     "bpf_fentry_test1", NULL);
+	if (!ASSERT_ERR_PTR(link, "bpf_program__attach_kprobe_opts"))
+		bpf_link__destroy(link);
+
+	kprobe_write_ctx__destroy(skel);
+}
+#else
+static void test_attach_kprobe_write_ctx(void)
+{
+	test__skip();
+}
+#endif
+
 static void test_attach_probe_auto(struct test_attach_probe *skel)
 {
 	struct bpf_link *uprobe_err_link;
@@ -406,6 +432,8 @@ void test_attach_probe(void)
 		test_attach_uprobe_long_event_name();
 	if (test__start_subtest("kprobe-long_name"))
 		test_attach_kprobe_long_event_name();
+	if (test__start_subtest("kprobe-write-ctx"))
+		test_attach_kprobe_write_ctx();
 
 cleanup:
 	test_attach_probe__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c b/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c
new file mode 100644
index 000000000000..4621a5bef4e2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+#if defined(__TARGET_ARCH_x86)
+SEC("kprobe")
+int kprobe_write_ctx(struct pt_regs *ctx)
+{
+	ctx->ax = 0;
+	return 0;
+}
+#endif
-- 
2.51.0

