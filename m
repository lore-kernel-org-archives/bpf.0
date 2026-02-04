Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1D63019A9
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 04:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770178128; cv=none; b=jDKUyiwcDS7TDK0KSQhVrAHDTf0qGYLFnhqGKTE0q5ivjQFn4CrQE4Rj1HX25s1TA+DO24BSqKlIh97KzIBqnedKYRBm3COpDahZfjwMuKCKOQl5sAfbLBRpo/EzqLaWKIeQLpTuuAM1RpTC8yfuayS7RKutacNTYBNz+0SkapM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770178128; c=relaxed/simple;
	bh=nPjYYnHQxObuB0Ahuo6+NDJE4IlnvfXBohhhY94UzTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6fn9yCRWEAX8Nid8g+rGIAOV99GhLSkEFEp9sovTLhYLuP4qgVzEXP1KeaikwfEM5c0Mn93bDeYpln20rgGl+1uWVxAPWP6ra6BZaQ+QEs6cLF5A2aEb25EUt1wPaLLjFUeT/9OmZQIpmnsKUkR6vYDFFcS/ilUcpz02Q6c5Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/K4SgqM; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/K4SgqM"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34f2a0c4574so6095235a91.1
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 20:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770178121; x=1770782921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w//PdEvEK79u4CG5EQr9wEDM4RdGRC8XJ2Jm/hb6SdA=;
        b=D/K4SgqMAS80lLMRxtdrcn0S11kqVU5XMcqxFTzqbvDE+BTF5tAxK6RIimPmWlJSXG
         +vLviknXQUhbsYAtPYBh3sZWKnMs3en/JPfoQB7JXEgYYKMgruFyIuPfDeEXmmic/0AX
         e0udIXTbnGcxiwKxV2goD8DYeMb8PYE1cnNvgC3dGT4MPSzWRJC4dxJ1CT8oNEwYeIE3
         qZpVtpFxZc7BN5CMcThDCZkLzrTfrLxpaCcMV6Vk3kukHSWLtSvXH5CwwQhulad+DEC+
         fUCcQLvn38X9lT2Ea0wRHQENNwVodngQ5XlTfldKRxtJbZH0wbIlbp2WBlZJDL2a3ex9
         JTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770178121; x=1770782921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w//PdEvEK79u4CG5EQr9wEDM4RdGRC8XJ2Jm/hb6SdA=;
        b=pAa6dZn+jgZBEi7bWr1IggxZsDq2QPEfiJEvQe3a//q9rVjZnxucQCWQhRFmaQ3Yyz
         id4f38eIlp8/HBXSDrgwJZAhRqEAM9YtBAgmC0OYGQKGqD+rxYSDU0j5w4GfvX/Yk166
         10Z0dDccZX3l2H3mJ1DsYdZNgAgmz3OEJljI3/yYMEzortmpnDrtYP09K8bLj7Xv4KYI
         hCef0vw5SebeUzCkUsfRFkASoL6c5tafwTgRles8bpOHzrWyXYkN6UkAluK/cIgXiPjk
         idEiQjrZDMC3Vav3361RyXJg96L495xa5ySl90xPpY/gSnjtKvRNFNiVYTPxTiOVe3IS
         QStw==
X-Gm-Message-State: AOJu0YwJg2FWRLsqFz7P4/iCt1YPnUGWeqdUFjDuxOXP6m5BA0rU4JhE
	qY8idtNUNMeMApzm6Kv5OEqBOphRY0ifLhVe6ITDt6jOpoh8GjOtvjfLBK9LOg==
X-Gm-Gg: AZuq6aIfx/hGxl2ulTvpZiNnMnY6HPvykXtoh/6QVLglKeE9T2nqE2h0AORqBNx6uxJ
	QcDue7eaaKkM/6m1v1CNj6slO7qLCydlGMI/B/KkXACNvYa8koRUf1ZOt451Tu05KML++uMfETY
	pFScKjid7H/HSSitZiB/77mD8R2OvzvwXzU8mFk+JzuQ3wKpBdkdVnxfbmXmnQcZ6bBFDGKqDTZ
	GZjemSCPSt2+bpwR8TuAi3sxdWmdPUCQ9QxFnhzXJczhfvSpvDqWXXn8u4YMk+07QVzfFJ6+7jr
	choNnDUOI7zEndqmGLJkZcVPHjOurFcokHkGIGnNJiLSdYXRC85ELbkq7rrAUDrluOiuiX6V21P
	tiMHgGyxNQlnlRJgXVOeM4W8U2cWYNOUIOqDaFa2kqY+mh+0UWZb+vwHb33RSaiX/U1UMYYgwp3
	u50ZC1fYo+jvMa1/19Chon1cz4MiGH7jWT/JVLpsCYLanyrZdWJoRTp+C15maZ5NzvYWLYeQ4OF
	9+BPxCQRDIlb3vyMuTq6TepK0gviCC2drB4zQL8NLuQkntAvQ==
X-Received: by 2002:a17:90b:4d86:b0:34c:f92a:ad05 with SMTP id 98e67ed59e1d1-354870da12fmr1443694a91.11.1770178121387;
        Tue, 03 Feb 2026 20:08:41 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354860bef61sm1047460a91.3.2026.02.03.20.08.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Feb 2026 20:08:41 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	mykyta.yatsenko5@gmail.com
Subject: [PATCH v2 bpf-next 2/4] selftests/bpf: Add a testcase for deadlock avoidance
Date: Tue,  3 Feb 2026 20:08:31 -0800
Message-ID: <20260204040834.22263-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260204040834.22263-1-alexei.starovoitov@gmail.com>
References: <20260204040834.22263-1-alexei.starovoitov@gmail.com>
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

