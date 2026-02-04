Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644731632E7
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 03:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770174574; cv=none; b=N0uKKEDTX8u/tlN862IaJwV/atZb2tjvrKBf19aCu2Kf21gLBDFb8hFqld5Riu1YECjZ0ucwr2hevtKj4fZkfCxl9aMkwYagjdL4tErqiI1HcxdSMtLLX51SsH19aoxTuKYzPxMNiFo1mvb8B86ODcvFxfaI7umpCG+llcTejzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770174574; c=relaxed/simple;
	bh=nPjYYnHQxObuB0Ahuo6+NDJE4IlnvfXBohhhY94UzTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9Jk9orMCftWST6v8SUBPr1IsPouN03AIeYIAVKTHhLi0jQX2tgSjbATXc+PfCZW+8siG8NSLIR2CpyfmHudoarMU0osYm6AsV7thZ9exTGSX+M5uB6dGwTmBtNeQcjgbJcLzjP7YhHTFwyr0bwbAo/OfoJlRzf0dtKx2TsINSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWesp2o2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWesp2o2"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a7bceb6cd0so43921835ad.1
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 19:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770174572; x=1770779372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w//PdEvEK79u4CG5EQr9wEDM4RdGRC8XJ2Jm/hb6SdA=;
        b=dWesp2o2ioWs/5SkpwpO3/2PNmmV7v8X9Vq1X9qKUgTNtqg3RLApaxnGHR+8CErnPQ
         Z04Ela6yvZAkoUspy+cRU4bLUoJt9m+WmYY2UQw7bVV71g7wLswnfKSoQ7qrwaoBu+BZ
         dFzvxB7lp/S+4eW8QQBgCUcAm0/xRRjjb1JwKWpcyOxwxFpR9jW7lgY/vd729zQQj+Md
         TgvNyWsdsoe2L4Ubv6br9lpbfs/BLz5wnZh5jfo+TY3w+6Xo3z6TtXIWG4IHVtLgsznK
         4rEwhJb1r9lUFeR1Rk/lEZBxkc+PDq6cf5f2TDqxAZj8Nn6VercG0v4RlBPHNoqIRY+o
         NGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770174572; x=1770779372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w//PdEvEK79u4CG5EQr9wEDM4RdGRC8XJ2Jm/hb6SdA=;
        b=iRBCs4485GWz5tdLK0yC6m+11i77StVdKJJ1Y8PYoZgOeNq6R/5fR1A/3dfGvXwprx
         TZvetFCV7T4QJbcz2FwStjD/LlEaU2I5oG2Id8Bm7W1DOD3ZYFGT7t+lIMFc1plIkNpS
         JZQEGxTK6WXmxU8exCEc/+tBvAWlCbyjfP9548eQ5TCjFoFMzfcaKcPvp37ME5Di9w7F
         OrOF7ELPNSXQJrYOzsdoeIZYL65anD1b5iIGVtEKZSXQtg8vZZ7zy88EzL9MJpkCt5cf
         cd9hpM0IV0QdfhS9z3dOSIh/ELxtk3FcKN0rArHG+3vnd/J6om7k7pNmxOmzRGUUGSXP
         USNQ==
X-Gm-Message-State: AOJu0YwSQ6RDPDxfGSeVsO7wkhEN+6IgZEnaygINIZfHNORoObrsKzJy
	90S+patPzS3W1tbyWvCstHx6z9JkfXqZ8z/yoJUNYOyH5+0sGUiJMan30KsLlw==
X-Gm-Gg: AZuq6aIH3dsmMfv4dh+7j9m+lSiyGVumo9ToT7MihONdowjeW3CMzAPWbmN5kHlAT3W
	r7+yBmNLGUEt+j7dxFEfIxzrMP75syrEqAjH7+ReO9wzPErF6cdyySga1Zw4PLL+Ki2MBdKLdrs
	VMMkDqHejJ5AD0P8aE25toupolkUsZOz75hRbTdV+g9sg55sovBg3/hNoMYIrDs0CADjnmd6XEj
	Wo4Qqg0XlkWmLOyhtb+SiaZoJ2rkbZtxSt2FrQnqaYhZaKu1F8MA6EKgBB3QPg3sR1o2PCxOTvx
	ajk+Ke6VhgGsdj3S+HFhdBTp/ICy2wxizeF3wPArxHMyP6mozlAQqIVXbOYMymdovCM8JsuY7tA
	2JqvqCN6aPdJH/h5Ep4d6Mh29buHNLhzfphTP8pNbkGzKQQ9Nf9tMO7F5a8bbVfpuBSgRdFf1oV
	kTzTU+N1+5AQ+l2inmTCLFRHm5TgIeU2/Y6JHQWWxtrB2ip/d31vZ5LjyNkAikXXOj0uTee3eGB
	bEg1vWc/KXdheVW64UOT+u9u8vpCZzq4q/ksdDYIJ18JbTzWw==
X-Received: by 2002:a17:903:fa7:b0:2a3:e76d:e8e with SMTP id d9443c01a7336-2a933fcc930mr16278255ad.45.1770174572481;
        Tue, 03 Feb 2026 19:09:32 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9338b71b7sm7410965ad.44.2026.02.03.19.09.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Feb 2026 19:09:32 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	mykyta.yatsenko5@gmail.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add a testcase for deadlock avoidance
Date: Tue,  3 Feb 2026 19:09:27 -0800
Message-ID: <20260204030927.171-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260204030927.171-1-alexei.starovoitov@gmail.com>
References: <20260204030927.171-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add a testcase that checks that deadlock avoidance is working
as expected.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/prog_tests/timer_start_deadlock.c     | 33 ++++++++
 .../bpf/progs/timer_start_deadlock.c          | 75 +++++++++++++++++++
 2 files changed, 108 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_start_deadlock.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_start_deadlock.c

diff --git a/tools/testing/selftests/bpf/prog_tests/timer_start_deadlock.c b/tools/testing/selftests/bpf/prog_tests/timer_start_deadlock.c
new file mode 100644
index 000000000000..9f1f9aec8888
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/timer_start_deadlock.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include "timer_start_deadlock.skel.h"
+
+void test_timer_start_deadlock(void)
+{
+	struct timer_start_deadlock *skel;
+	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+
+	skel = timer_start_deadlock__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	err = timer_start_deadlock__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.start_timer);
+
+	/*
+	 * Run the syscall program that attempts to deadlock.
+	 * If the kernel deadlocks, this call will never return.
+	 */
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+	ASSERT_OK(err, "prog_test_run");
+	ASSERT_EQ(opts.retval, 0, "prog_retval");
+
+	ASSERT_EQ(skel->bss->tp_called, 1, "tp_called");
+cleanup:
+	timer_start_deadlock__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/timer_start_deadlock.c b/tools/testing/selftests/bpf/progs/timer_start_deadlock.c
new file mode 100644
index 000000000000..368563747a46
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/timer_start_deadlock.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define CLOCK_MONOTONIC 1
+
+char _license[] SEC("license") = "GPL";
+
+struct elem {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} timer_map SEC(".maps");
+
+volatile int in_timer_start;
+volatile int tp_called;
+
+static int timer_cb(void *map, int *key, struct elem *value)
+{
+	return 0;
+}
+
+SEC("tp_btf/hrtimer_cancel")
+int BPF_PROG(tp_hrtimer_cancel, struct hrtimer *hrtimer)
+{
+	struct bpf_timer *timer;
+	static bool called = false;
+	int key = 0;
+
+	if (!in_timer_start)
+		return 0;
+
+	tp_called = 1;
+	timer = bpf_map_lookup_elem(&timer_map, &key);
+
+	/*
+	 * Call bpf_timer_start() from the tracepoint within hrtimer logic
+	 * on the same timer to make sure it doesn't deadlock,
+	 * and do it once.
+	 */
+	if (!called) {
+		called = true;
+		bpf_timer_start(timer, 1000000000, 0);
+	}
+	return 0;
+}
+
+SEC("syscall")
+int start_timer(void *ctx)
+{
+	struct bpf_timer *timer;
+	int key = 0;
+
+	timer = bpf_map_lookup_elem(&timer_map, &key);
+	/* claude may complain here that there is no NULL check. Ignoring it. */
+	bpf_timer_init(timer, &timer_map, CLOCK_MONOTONIC);
+	bpf_timer_set_callback(timer, timer_cb);
+
+	/*
+	 * call hrtimer_start() twice, so that 2nd call does
+	 * remove_hrtimer() and trace_hrtimer_cancel() tracepoint.
+	 */
+	in_timer_start = 1;
+	bpf_timer_start(timer, 1000000000, 0);
+	bpf_timer_start(timer, 1000000000, 0);
+	in_timer_start = 0;
+	return 0;
+}
-- 
2.47.3

