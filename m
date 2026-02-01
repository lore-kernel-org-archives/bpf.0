Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C62274B59
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 02:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769914473; cv=none; b=bhg2BJx79jVPtinn9Q5M+XWRssyItsOAkrC1Pfdo3LZYpwDJSugxndpAIAM9iqSwIfqY3bNgo0ZdIw43O6cgdMMjFMFbSEC/lPxJwUSodY4c3uAk5b4afL1taWXwxhi4Eu4I4NW0GvD45SKxcS6s2bRZHO53fC1Ie+rKF6UItps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769914473; c=relaxed/simple;
	bh=hqP87BM4TQ+4JRpxXcJhJTb0cTRdSUZCWELpTMmqCc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fy4nbac9g80TtEZ+89kN93c7utpkz3Jm2W3Ny18rAO40APW34AcyxbJr1XNbzCpoCyonV34raXA+wHXkht7Ne3/YypWDXxi3rOHamlivj3/5v1H+M32yPhXiPnlGQKMC2le8osXv1t568WrHIK7o+ifpQAkcv0vcAr8E9C1unPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTRvDQ9U; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTRvDQ9U"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81dbc0a99d2so1685403b3a.1
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 18:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769914471; x=1770519271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fNAeNgQ7oAuods89/m4QOrNTlB0/6EWs+zd/V64WWw=;
        b=FTRvDQ9UIRxAg8dRP2KHB4gy6IlS7FBQJybfv0uC+GZ0nK7SUd+JuopWMCAtpIOiGB
         fL9YIhlRusHjiduHnt+rzw+CIb0j0vIDiYl55pUCwdSsLRwBi6bCaYe4OHgyS/HmTTDr
         pOO0mc7aEJnxho4JxNHycZmVmlmRbqGvZmC9WmNqzfe4k0LUuiSTp+RqPniggBJjzsVu
         0/N6NVfcRoqJhms5EhmN5fdD4RBjBZ3dzgo4mA75TJVrPDMvZrzHzZ/05HCsvJzodwpX
         uIKhFhfTHs3OEOh+NsHffaxSo6nLy3f/z7WUPJ5at+fFAcU2W4Zb5/vBlWn75ZfqE0G9
         PChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769914471; x=1770519271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+fNAeNgQ7oAuods89/m4QOrNTlB0/6EWs+zd/V64WWw=;
        b=cZvlMuvGbPFxWs86QbmzTcVCj3WpXtvdtb2HsPLOArzpUV5BbjzPFEvfKsK8Eo1kBE
         3H2CJoTopY93IlfivQqgsLelrxDlt+fLpSZMEbSayZATuTulmkfnuWJy1viZrlfZjxTs
         zKE7947Qt9OHzeukc0w27e8CqgYyHo6ahowD8T4FfrYqQX1kFi8glc9QcecQACekIb7I
         ca8xtiV1L0ONSxvkQGOuZrBbCeyXkjgEGiXbUD1FvsC7V+TPAwxaX/+jbmUufzvGuDHQ
         g1ViWWomwMbtbu6yuZSMj1FXeG0VAWn0b6TkmGQxalMItcTtjYzgkwKmkjp8THyiURIZ
         f4aw==
X-Gm-Message-State: AOJu0YygKTLNTS6F8BjHpJa0RFwIpoOrm4V5fnIlIR2Svump+HvofMv+
	l+AUHPgCjVXqzHAcXf2hZArCLOEl5ZEkaAZvuGwnBtiNoiiqr/Y0LOQOk+j+dg==
X-Gm-Gg: AZuq6aIT6IZo25i+DKgz0T1ZGVB/jM8lOghFDNTA/InKc3uQ4I/Un518v/4oTbCd5rh
	LXzK7cSfwdvcVqPL7/1Js2B0OGhgDrvsclpU8snhtX2gWWI1z7DfFT8wAAoEDBMoWRNadfyH5y1
	iFx/9LCLp143lS6AQqHUQQ2eOrtkfpCs5rElo9Nw4VjaTcuAuauvLZvyWXa+OSgcsynGlvZqttf
	oGbne4zrK2pC3vGjHfv1uVhD+k/OvfO0y9HcuKrONdQmsJUddyODJ2X+HM5xnTRUM2tjG/NGzzF
	tLH8//eNALoUi2l40GZOTrIWYBS8AkvrELk8FB+sJKcjHkgvUPtLzTcu8xOyHpICqHM8Cv51Zes
	3P2fb6N6/spA3Q7DkylzmrJE/XZZlS5t+1zTk7cmbrqJ5gLR2FvrmX0NZjZtUnYHXOK9qSUkbK+
	mu3dh4hPu0/Ue4kVUA4rNOr9YPmGEf6OA+E1JRbNBqBcy27eoZxuRrYcFpAUODZjSIjQG91yOnI
	VlWT52+S4kmwEvu+X6kkynLhtliP2MhUk3yDIqONvSre9UWrg==
X-Received: by 2002:a05:6a00:9153:b0:822:f928:fd97 with SMTP id d2e1a72fcca58-823ab67143amr6585265b3a.22.1769914471437;
        Sat, 31 Jan 2026 18:54:31 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b4e7b7sm11824042b3a.21.2026.01.31.18.54.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Jan 2026 18:54:31 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	mykyta.yatsenko5@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v9 bpf-next 9/9] selftests/bpf: Add a test to stress bpf_timer_start and map_delete race
Date: Sat, 31 Jan 2026 18:54:03 -0800
Message-ID: <20260201025403.66625-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260201025403.66625-1-alexei.starovoitov@gmail.com>
References: <20260201025403.66625-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add a test to stress bpf_timer_start and map_delete race

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/prog_tests/timer_start_delete_race.c  | 137 ++++++++++++++++++
 .../bpf/progs/timer_start_delete_race.c       |  66 +++++++++
 2 files changed, 203 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_start_delete_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_start_delete_race.c

diff --git a/tools/testing/selftests/bpf/prog_tests/timer_start_delete_race.c b/tools/testing/selftests/bpf/prog_tests/timer_start_delete_race.c
new file mode 100644
index 000000000000..29a46e96f660
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/timer_start_delete_race.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#define _GNU_SOURCE
+#include <sched.h>
+#include <pthread.h>
+#include <test_progs.h>
+#include "timer_start_delete_race.skel.h"
+
+/*
+ * Test for race between bpf_timer_start() and map element deletion.
+ *
+ * The race scenario:
+ * - CPU 1: bpf_timer_start() proceeds to bpf_async_process() and is about
+ *          to call hrtimer_start() but hasn't yet
+ * - CPU 2: map_delete_elem() calls __bpf_async_cancel_and_free(), since
+ *          timer is not scheduled yet hrtimer_try_to_cancel() is a nop,
+ *          then calls bpf_async_refcount_put() dropping refcnt to zero
+ *          and scheduling call_rcu_tasks_trace()
+ * - CPU 1: continues and calls hrtimer_start()
+ * - After RCU tasks trace grace period: memory is freed
+ * - Timer callback fires on freed memory: UAF!
+ *
+ * This test stresses this race by having two threads:
+ * - Thread 1: repeatedly starts timers
+ * - Thread 2: repeatedly deletes map elements
+ *
+ * KASAN should detect use-after-free.
+ */
+
+#define ITERATIONS 1000
+
+struct ctx {
+	struct timer_start_delete_race *skel;
+	volatile bool start;
+	volatile bool stop;
+	int errors;
+};
+
+static void *start_timer_thread(void *arg)
+{
+	struct ctx *ctx = arg;
+	cpu_set_t cpuset;
+	int fd, i;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(0, &cpuset);
+	pthread_setaffinity_np(pthread_self(), sizeof(cpuset), &cpuset);
+
+	while (!ctx->start && !ctx->stop)
+		usleep(1);
+	if (ctx->stop)
+		return NULL;
+
+	fd = bpf_program__fd(ctx->skel->progs.start_timer);
+
+	for (i = 0; i < ITERATIONS && !ctx->stop; i++) {
+		LIBBPF_OPTS(bpf_test_run_opts, opts);
+		int err;
+
+		err = bpf_prog_test_run_opts(fd, &opts);
+		if (err || opts.retval) {
+			ctx->errors++;
+			break;
+		}
+	}
+
+	return NULL;
+}
+
+static void *delete_elem_thread(void *arg)
+{
+	struct ctx *ctx = arg;
+	cpu_set_t cpuset;
+	int fd, i;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(1, &cpuset);
+	pthread_setaffinity_np(pthread_self(), sizeof(cpuset), &cpuset);
+
+	while (!ctx->start && !ctx->stop)
+		usleep(1);
+	if (ctx->stop)
+		return NULL;
+
+	fd = bpf_program__fd(ctx->skel->progs.delete_elem);
+
+	for (i = 0; i < ITERATIONS && !ctx->stop; i++) {
+		LIBBPF_OPTS(bpf_test_run_opts, opts);
+		int err;
+
+		err = bpf_prog_test_run_opts(fd, &opts);
+		if (err || opts.retval) {
+			ctx->errors++;
+			break;
+		}
+	}
+
+	return NULL;
+}
+
+void test_timer_start_delete_race(void)
+{
+	struct timer_start_delete_race *skel;
+	pthread_t threads[2];
+	struct ctx ctx = {};
+	int err;
+
+	skel = timer_start_delete_race__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	ctx.skel = skel;
+
+	err = pthread_create(&threads[0], NULL, start_timer_thread, &ctx);
+	if (!ASSERT_OK(err, "create start_timer_thread")) {
+		ctx.stop = true;
+		goto cleanup;
+	}
+
+	err = pthread_create(&threads[1], NULL, delete_elem_thread, &ctx);
+	if (!ASSERT_OK(err, "create delete_elem_thread")) {
+		ctx.stop = true;
+		pthread_join(threads[0], NULL);
+		goto cleanup;
+	}
+
+	ctx.start = true;
+
+	pthread_join(threads[0], NULL);
+	pthread_join(threads[1], NULL);
+
+	ASSERT_EQ(ctx.errors, 0, "thread_errors");
+
+	/* Either KASAN will catch UAF or kernel will crash or nothing happens */
+cleanup:
+	timer_start_delete_race__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/timer_start_delete_race.c b/tools/testing/selftests/bpf/progs/timer_start_delete_race.c
new file mode 100644
index 000000000000..2ff6357f33f9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/timer_start_delete_race.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <linux/bpf.h>
+#include <time.h>
+#include <bpf/bpf_helpers.h>
+
+#define ITER_CNT 2000
+
+struct map_value {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+} timer_map SEC(".maps");
+
+long cb_cnt;
+
+/*
+ * Timer callback that accesses the map value.
+ * If the race bug exists and this runs on freed memory,
+ * KASAN should detect it.
+ */
+static int timer_cb(void *map, int *key, struct map_value *value)
+{
+	__sync_fetch_and_add(&cb_cnt, 1);
+	return 0;
+}
+
+SEC("syscall")
+int start_timer(void *ctx)
+{
+	struct map_value *value;
+	int i;
+
+	for (i = 0; i < ITER_CNT; i++) {
+		int key = 0;
+
+		value = bpf_map_lookup_elem(&timer_map, &key);
+		/* hey claude, no if (!value) here. The verifier got smarter */
+
+		bpf_timer_init(&value->timer, &timer_map, CLOCK_MONOTONIC);
+		bpf_timer_set_callback(&value->timer, timer_cb);
+		bpf_timer_start(&value->timer, 100000000, 0);
+	}
+	return 0;
+}
+
+SEC("syscall")
+int delete_elem(void *ctx)
+{
+	int i;
+
+	for (i = 0; i < ITER_CNT; i++) {
+		int key = 0;
+
+		bpf_map_delete_elem(&timer_map, &key);
+	}
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.3

