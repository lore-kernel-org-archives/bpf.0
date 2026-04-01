Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB3547D956
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060778; cv=none; b=khwvp6TTAG8RPYsBXTUyY8FWHcoEEC0lVGaroSdXA4QQdL/tnrQdQTpp5pktl8C/f0UDJU5YMIzLsOMrKxAwjG6cjcZiolSsOvsN8v6abq4NG2i2eaF6GpCemZR88/sgcJfctfZCS7SGlDVoWxkTutnQF6hyj1a3PdUhmU2IELQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060778; c=relaxed/simple;
	bh=nu4MbcaGC1ScZASfjnysGtYFM0vwpEgtgUxJgHFyeFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGl3CrK8PL7IE9Jb0yjxRHmvuyr5vPbGHkIvDV9VA3moFknXy+o6/1DdZBUSCVkFT+hmq0UD+wd8IwAeOffwQzPKPp4IqDg/MP7r1GSvkVycQ2fggc27lOvCSHdLVX7fUh0kYU69ZI2HPh/cMSfc1f6+yPzPgWPabcSsIrc56T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJE5q6gT; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJE5q6gT"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so2238720a91.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 09:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775060771; x=1775665571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htPARiivWMAf+Z1l6rsulvqtlMFd2ueWojQoT0sqF7s=;
        b=SJE5q6gT9V8ia6m917MSHVo/XACG1RTe9ZQl8wRrDjwpyNlC0l41ns3lYxhQF32q1e
         1/5v4tMS4CZGtWNlLoEuX+vo0IFFR7RF2n3YIFJpMlArLz5Ayfgy0c263A3F1D5lzz41
         QDVKHncwpxqBx61Gz3LJPYfP6E4DbgYeoRdy25187AKKftVvS4S8AX6e8mh0OqBKKZFG
         NNOum24xZ8XKo5usax00nmJ1rAI3r0zDOSkFHNg6o6tP3T2x2APHUMKjlBqru7sONN+9
         pGcVJWFgFCNoHKQdWzz2Eqoz6zq1JB6fq/tD0IFN6sBm6Gbag4wZ22Sw1MdcFg5dYtCJ
         cMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060771; x=1775665571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=htPARiivWMAf+Z1l6rsulvqtlMFd2ueWojQoT0sqF7s=;
        b=JAariI7Hx+/k5iaeu80BsCvFT71CNiMWrySIlR2YdR3P3CNBJ978r13XWHpbCfOddc
         pNUje9+ppdqU8F1UbDPwyutM0ZQ6JH3alJcLgwd/v5TGucNDQbvtDDZHqwnRmRQjlIdX
         x6Yv06SkNw5glgCiOEEDfZV0IPYzyZ/hqGxv2vs6t9sXCAiEaxv19G8enCtCt+iuOjUB
         C4zHMLSgdjF2BJ7EAqjvFRX/gbN/K7sq6LuxElnebG/y83RNisSAkmAyQ6VuWK8LsxY7
         CoD8Wst6wITAiXM3MNivP028AXDGxEOzliNWt2GbDNCHaGfrAD3we0GVl5eIVj15RzhK
         FzWA==
X-Forwarded-Encrypted: i=1; AJvYcCXtf2H5CdGBcgGZ7m7XgloWJUrNqFcd+E9JDEAysRofnECKcG9P+xbXKbbLwr6hdihCsTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl5HBVBMOPbldEtFO70p3iMUOgZd3R2hbaCTpfvNpvXJLAhWSq
	9Iejup5Q77YtVBK46XsJbuziaFaqgO1nnsejF0kbs7N/2Rjk4fRRbqiF
X-Gm-Gg: ATEYQzwUO8Y0rYLUkL3Ab0B9CkD/0z0KQ852CddSJY9HIjPK7VGOieAxoc9kzJ8qMyQ
	1Rxf01R4Els+ew8cUiElh3Lzc2q57VCrBzEbvV4ZtM5IoKIwjyAM3NvnYQK6+hv+dnydtgZBwdk
	Q9SROumcAbeExYIhwRvEjnTmY+g5fr57uPaDKTrVfaaddi8I7QlIPaxHqc3r6XrKCzouq2UJLsn
	dPiCSXY+rpAFGXEuNIywQtQtEO7TytD1m0T3GG7VinwcNTltxT4D0SdyIJgG4IHHvdR9KvV6ow9
	xh9hZrl19cXQ1EYnleSRmLt6Xe87wxqT1nIZycK4ORudiTcTw8rKiIx6+0EgFgIBgs3sUJj0L+z
	lurDDBaye8vTccvj+lJ22PfqQzrZoI4nz6Uq0inuNQOau0H+RL32VM4Amh6jHagJ2ieNMiPnz01
	vRDLGjpsEebCJhmcgwKdm0MZOId+jaeWm5ErukoBdbXOdtS/QvhnKWhjBoAlg6FbYqRSI=
X-Received: by 2002:a17:90b:1350:b0:35c:b02:b5c1 with SMTP id 98e67ed59e1d1-35dc6e2d00dmr3948220a91.2.1775060770387;
        Wed, 01 Apr 2026 09:26:10 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:a82::10c:22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dba546cccsm2338711a91.1.2026.04.01.09.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:26:09 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: varunrmallya@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	mattbobrowski@google.com,
	memxor@gmail.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH bpf v2] bpf: Reject sleepable kprobe_multi programs at attach time
Date: Wed,  1 Apr 2026 21:55:55 +0530
Message-ID: <20260401162555.426867-1-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ac0hLyMuPHiZfnVc@computer>
References: <ac0hLyMuPHiZfnVc@computer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kprobe.multi programs run in atomic/RCU context and cannot sleep.
However, bpf_kprobe_multi_link_attach() did not validate whether the
program being attached had the sleepable flag set, allowing sleepable
helpers such as bpf_copy_from_user() to be invoked from a non-sleepable
context.

This causes a "sleeping function called from invalid context" splat:

  BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:169
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1787, name: sudo
  preempt_count: 1, expected: 0
  RCU nest depth: 2, expected: 0

Fix this by rejecting sleepable programs early in
bpf_kprobe_multi_link_attach(), before any further processing.

Also add a selftest that tries to load a sleepable kprobe_multi program
and it needs to be rejected for the test to pass.

Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
---
 kernel/trace/bpf_trace.c                      |  4 ++
 .../bpf/prog_tests/kprobe_multi_test.c        | 41 +++++++++++++++++++
 .../bpf/progs/kprobe_multi_sleepable.c        | 13 ++++++
 3 files changed, 58 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0b040a417442..af7079aa0f36 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2752,6 +2752,10 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (!is_kprobe_multi(prog))
 		return -EINVAL;
 
+	/* kprobe_multi is not allowed to be sleepable. */
+	if (prog->sleepable)
+		return -EINVAL;
+
 	/* Writing to context is not allowed for kprobes. */
 	if (prog->aux->kprobe_write_ctx)
 		return -EINVAL;
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 78c974d4ea33..f02fec2b6fda 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -10,6 +10,7 @@
 #include "kprobe_multi_session_cookie.skel.h"
 #include "kprobe_multi_verifier.skel.h"
 #include "kprobe_write_ctx.skel.h"
+#include "kprobe_multi_sleepable.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "bpf/hashmap.h"
 
@@ -633,6 +634,44 @@ static void test_attach_write_ctx(void)
 }
 #endif
 
+static void test_attach_multi_sleepable(void)
+{
+	struct kprobe_multi_sleepable *skel;
+	int err;
+
+	skel = kprobe_multi_sleepable__open();
+	if (!ASSERT_OK_PTR(skel, "kprobe_multi_sleepable__open"))
+		return;
+
+	err = bpf_program__set_flags(skel->progs.handle_kprobe_multi_sleepable,
+				     BPF_F_SLEEPABLE);
+	if (!ASSERT_OK(err, "bpf_program__set_flags"))
+		goto cleanup;
+
+	/* Load should succeed even with BPF_F_SLEEPABLE for KPROBE types */
+	err = kprobe_multi_sleepable__load(skel);
+	if (!ASSERT_OK(err, "kprobe_multi_sleepable__load"))
+		goto cleanup;
+
+	/* Attachment must fail for kprobe.multi + BPF_F_SLEEPABLE.
+	 * Also chosen a stable symbol to send into opts
+	 */
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	const char *sym = "vfs_read";
+
+	opts.syms = &sym;
+	opts.cnt = 1;
+
+	skel->links.handle_kprobe_multi_sleepable =
+		bpf_program__attach_kprobe_multi_opts(skel->progs.handle_kprobe_multi_sleepable,
+						      NULL, &opts);
+	ASSERT_ERR_PTR(skel->links.handle_kprobe_multi_sleepable,
+		       "bpf_program__attach_kprobe_multi_opts");
+
+cleanup:
+	kprobe_multi_sleepable__destroy(skel);
+}
+
 void serial_test_kprobe_multi_bench_attach(void)
 {
 	if (test__start_subtest("kernel"))
@@ -676,5 +715,7 @@ void test_kprobe_multi_test(void)
 		test_unique_match();
 	if (test__start_subtest("attach_write_ctx"))
 		test_attach_write_ctx();
+	if (test__start_subtest("attach_multi_sleepable"))
+		test_attach_multi_sleepable();
 	RUN_TESTS(kprobe_multi_verifier);
 }
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c b/tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
new file mode 100644
index 000000000000..56973ad8779d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+SEC("kprobe.multi")
+int handle_kprobe_multi_sleepable(struct pt_regs *ctx)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0

