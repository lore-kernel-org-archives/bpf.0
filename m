Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFACC35A92F
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 07:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274947; cv=none; b=DrXiKGOIcDin2Sc3fkcAtJzeHc7oNAXJ9oesep8IteoZ9fg4/86SUdUQ1eZ4BqPAQAyV/SgtrFgeCFVpdb4Bqk4X0nyK4uI79jg3uy5csbEqgEGy4X0YyJbatOBkGl0Bj/R7mj8QyCck5kytY3EjgbLJlnxiENiGv8DwOJ6jw8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274947; c=relaxed/simple;
	bh=ccp3EztJlEJzQLmiEu1DIzpJsXT5LIfKYR2G67v0qAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBTjLtOMwH0IWEJ5KFrLAIZyl6MvANSPACi8Nv20Kfgjg824aR5V7xbkb+WnH1YpHPFoyS2GGGwAdDpU/4jc6jUdjGAboUua3OQv3SX3neKuNLTQ8M1hl3iyR+16U90SsHEOmIwHe2K1dSv2o7tygA+23E/KyVB+1UfQgbX21jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnXpJV8/; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnXpJV8/"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c47ee987401so311518a12.1
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 23:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274947; x=1770879747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dhstHRDqQgEPx9WkzXkwbtwT/zsNcRbIl8bglWWgQI=;
        b=WnXpJV8/caJc8pfCmOynKPnZcu1aAXMMqY6NpGHFsdLzENReub49epW7WrdlyyqIuM
         NjlCuEMEV54kzMHPGF2p/nDNFxrLZNy7ygZNzmNG/mpqdGSg9Z0Uy6vTSAeO9OMCe+vO
         /X1q8gUqAPxrb6I4qHH9I/fIJz1R0gOlEe9HMKlV8hZe+MY2xkL25FiF5xtVbj4p833y
         mwcK3+GHrYIgAfZFOOg6LzuRJhkYuKZ84aul4ktIWjN1JbiA8rRyOAkTl6IZxc3YoaO1
         XBd1pTbrCiKZfThFwIZoMPqeJah93vuic9QGCtiW2LQQr3/CIN1vRONdpVoGjP482mSl
         cuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274947; x=1770879747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6dhstHRDqQgEPx9WkzXkwbtwT/zsNcRbIl8bglWWgQI=;
        b=rsjLprXCQJiLkzoPFyRL6Oft0cBytY9jUWMBuOwFFhj7CiYXxjwizC85xEm5nQStz7
         Uq9/aPpoxT1/K1s0GB7D/XJRkTUv8H+5NBGKHEPY5INKCcCDWzh8/4LqjzcOKzKUfdNk
         ARK/5gT2fsXza85fXgS8eAAdyJ0X2XkA3Z4UbaWxG/cuCRwCXQy+Gp5saUu+wgyPJLQG
         Hi4JWgr7YZJ0IMVRARcFjDHcAh6uN6Gkb5P8DBp3PCiMnZtlVLOqqKp7n2cF+CRhnLCP
         Hy/J4lu9//PHhmdczxlsGiypOXgUPBOhr4/OSktpkR9oKtAS/6QDApMFIN/QRPxjEl0T
         YpLw==
X-Gm-Message-State: AOJu0YzIbAoQgz7WyZmghtehthDf6ElAStQNcu2uRszu8xpUOy3M8il5
	L7M8flqARS0AY7BInlBsML5/MtbZNKONdI3HwKLV6WyyDFNoOm/NjOkpNUucLA==
X-Gm-Gg: AZuq6aIX+NbmpgXF94YXaWy7JHvyRyq1Hvs+sgeaL7oZ1oFBy2LS+Bf0LQ7T6882hhU
	FlRuon+lo80oK4sjmGcpULL/mVEsb/jAOY85BcQUcdoz1kNPlK2iKKBXlyq2ocAm/dAs0dfiNr8
	zhmUxl0u9YWUkmSvOgCcB3LvatXnP8D/ZWAcatYmJ4Bvp0DSjk6xHhvojqt0aSOjR19KB9A3ANP
	FWJhWYVtjUix6eLX0qGk1lRv0qSOGl3NJwn+y5TUrIhKeAW4E9pcwVptWdJpENTGhIBuVqqWacQ
	LUpm96TPkkoKpVymdpvIkce2ezcFqSGSv9b7+0pDl5A3k/xiH2FsjFzjTu6ufPfJBRdt/MVUnM0
	zV63k++gBXU2aUudV1Hp5eavOLVeSluu1gzx7wYOt7qfgV9KUhuagebAc7JvmdebYTnu8Kptg66
	oKgQ==
X-Received: by 2002:a05:6a20:43ac:b0:35f:14ae:4a7a with SMTP id adf61e73a8af0-3938f98a77fmr1973210637.13.1770274946873;
        Wed, 04 Feb 2026 23:02:26 -0800 (PST)
Received: from localhost ([2a03:2880:ff:19::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6c8506377esm4175968a12.25.2026.02.04.23.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:26 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 15/17] selftests/bpf: Remove test_task_storage_map_stress_lookup
Date: Wed,  4 Feb 2026 23:02:04 -0800
Message-ID: <20260205070208.186382-16-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205070208.186382-1-ameryhung@gmail.com>
References: <20260205070208.186382-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a test in test_maps that checks if the updating of the percpu
counter in task local storage map is preemption safe as the percpu
counter is now removed.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/map_tests/task_storage_map.c          | 128 ------------------
 .../bpf/progs/read_bpf_task_storage_busy.c    |  38 ------
 2 files changed, 166 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/map_tests/task_storage_map.c
 delete mode 100644 tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c

diff --git a/tools/testing/selftests/bpf/map_tests/task_storage_map.c b/tools/testing/selftests/bpf/map_tests/task_storage_map.c
deleted file mode 100644
index a4121d2248ac..000000000000
--- a/tools/testing/selftests/bpf/map_tests/task_storage_map.c
+++ /dev/null
@@ -1,128 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2022. Huawei Technologies Co., Ltd */
-#define _GNU_SOURCE
-#include <sched.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <stdbool.h>
-#include <errno.h>
-#include <string.h>
-#include <pthread.h>
-
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-
-#include "bpf_util.h"
-#include "test_maps.h"
-#include "task_local_storage_helpers.h"
-#include "read_bpf_task_storage_busy.skel.h"
-
-struct lookup_ctx {
-	bool start;
-	bool stop;
-	int pid_fd;
-	int map_fd;
-	int loop;
-};
-
-static void *lookup_fn(void *arg)
-{
-	struct lookup_ctx *ctx = arg;
-	long value;
-	int i = 0;
-
-	while (!ctx->start)
-		usleep(1);
-
-	while (!ctx->stop && i++ < ctx->loop)
-		bpf_map_lookup_elem(ctx->map_fd, &ctx->pid_fd, &value);
-	return NULL;
-}
-
-static void abort_lookup(struct lookup_ctx *ctx, pthread_t *tids, unsigned int nr)
-{
-	unsigned int i;
-
-	ctx->stop = true;
-	ctx->start = true;
-	for (i = 0; i < nr; i++)
-		pthread_join(tids[i], NULL);
-}
-
-void test_task_storage_map_stress_lookup(void)
-{
-#define MAX_NR_THREAD 4096
-	unsigned int i, nr = 256, loop = 8192, cpu = 0;
-	struct read_bpf_task_storage_busy *skel;
-	pthread_t tids[MAX_NR_THREAD];
-	struct lookup_ctx ctx;
-	cpu_set_t old, new;
-	const char *cfg;
-	int err;
-
-	cfg = getenv("TASK_STORAGE_MAP_NR_THREAD");
-	if (cfg) {
-		nr = atoi(cfg);
-		if (nr > MAX_NR_THREAD)
-			nr = MAX_NR_THREAD;
-	}
-	cfg = getenv("TASK_STORAGE_MAP_NR_LOOP");
-	if (cfg)
-		loop = atoi(cfg);
-	cfg = getenv("TASK_STORAGE_MAP_PIN_CPU");
-	if (cfg)
-		cpu = atoi(cfg);
-
-	skel = read_bpf_task_storage_busy__open_and_load();
-	err = libbpf_get_error(skel);
-	CHECK(err, "open_and_load", "error %d\n", err);
-
-	/* Only for a fully preemptible kernel */
-	if (!skel->kconfig->CONFIG_PREEMPTION) {
-		printf("%s SKIP (no CONFIG_PREEMPTION)\n", __func__);
-		read_bpf_task_storage_busy__destroy(skel);
-		skips++;
-		return;
-	}
-
-	/* Save the old affinity setting */
-	sched_getaffinity(getpid(), sizeof(old), &old);
-
-	/* Pinned on a specific CPU */
-	CPU_ZERO(&new);
-	CPU_SET(cpu, &new);
-	sched_setaffinity(getpid(), sizeof(new), &new);
-
-	ctx.start = false;
-	ctx.stop = false;
-	ctx.pid_fd = sys_pidfd_open(getpid(), 0);
-	ctx.map_fd = bpf_map__fd(skel->maps.task);
-	ctx.loop = loop;
-	for (i = 0; i < nr; i++) {
-		err = pthread_create(&tids[i], NULL, lookup_fn, &ctx);
-		if (err) {
-			abort_lookup(&ctx, tids, i);
-			CHECK(err, "pthread_create", "error %d\n", err);
-			goto out;
-		}
-	}
-
-	ctx.start = true;
-	for (i = 0; i < nr; i++)
-		pthread_join(tids[i], NULL);
-
-	skel->bss->pid = getpid();
-	err = read_bpf_task_storage_busy__attach(skel);
-	CHECK(err, "attach", "error %d\n", err);
-
-	/* Trigger program */
-	sys_gettid();
-	skel->bss->pid = 0;
-
-	CHECK(skel->bss->busy != 0, "bad bpf_task_storage_busy", "got %d\n", skel->bss->busy);
-out:
-	read_bpf_task_storage_busy__destroy(skel);
-	/* Restore affinity setting */
-	sched_setaffinity(getpid(), sizeof(old), &old);
-	printf("%s:PASS\n", __func__);
-}
diff --git a/tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c b/tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c
deleted file mode 100644
index 69da05bb6c63..000000000000
--- a/tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c
+++ /dev/null
@@ -1,38 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2022. Huawei Technologies Co., Ltd */
-#include "vmlinux.h"
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-
-extern bool CONFIG_PREEMPTION __kconfig __weak;
-extern const int bpf_task_storage_busy __ksym;
-
-char _license[] SEC("license") = "GPL";
-
-int pid = 0;
-int busy = 0;
-
-struct {
-	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
-	__uint(map_flags, BPF_F_NO_PREALLOC);
-	__type(key, int);
-	__type(value, long);
-} task SEC(".maps");
-
-SEC("raw_tp/sys_enter")
-int BPF_PROG(read_bpf_task_storage_busy)
-{
-	int *value;
-
-	if (!CONFIG_PREEMPTION)
-		return 0;
-
-	if (bpf_get_current_pid_tgid() >> 32 != pid)
-		return 0;
-
-	value = bpf_this_cpu_ptr(&bpf_task_storage_busy);
-	if (value)
-		busy = *value;
-
-	return 0;
-}
-- 
2.47.3

