Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC69274B59
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 02:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769914461; cv=none; b=iE+8UL88kjFCkMcshfJU9fnxrgPmAVvYfkP05XhBgTt8eHJkLfC9sUdkWI5NRPvct9iw3CdFrvhw5qrgv/IuMR6LcIwaLgXyjCfPc25QsQXUKVFXqVWx15D4z9EXcLKWSKfTl7+56IXcXFsA5i1lvcM0KwzjlKrdEX2kKDuykE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769914461; c=relaxed/simple;
	bh=iNel74PWpCo8B397mEsLXPk/ZtgWy27gVap4f1+L3mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QomhcX538vU8JFvsTLjPM72etn9Ztn4AUuPWAejEc5HN1N95sWtkp6h4FFvV38iVB+Rau1W/kHreve9/lL9z5nlQe3aqkpDCIXna33T6sQVB3V3fAW4aznKWF78AFxvP8k+bWrxsf+jGY0TAzxL5uGdDvUVLQjv1DFIn0mIu+/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0GeltI9; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0GeltI9"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35305538592so3009743a91.0
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 18:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769914459; x=1770519259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsBV5QhFjYgRpqFEYwGYD8++hkHhplRufqro04B7jxs=;
        b=G0GeltI9rKSGzs4AW2oOEWS75pdaKc1XaVipR+bOFnANQ0Qpa5F6qjyZlYhwbRZuLh
         c+vtVWMJiSesfYeL4gpc5borWT8i7lSQ7Vl6jgmeOSx/sTRzPpzp2rOrgr9aJgANxPcO
         N6PHEK4e74cythijshdfKGWeyB58tOoD6nrK32hrAkoXFngx51StyC6yc31DPHQNtW3p
         jicOejU1bq1iuy3Z5csLPjrgeQJDTHz+ahsX6fSEcJ3eOOBZG4Gge13T4mzQ93+2/y5B
         cakVzRtlayfxMYaqx10ZQhuEemQAgKwRfwegLkH5kDzaqBh8PDuVnX7BZY4GQ6pQQa76
         PxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769914459; x=1770519259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vsBV5QhFjYgRpqFEYwGYD8++hkHhplRufqro04B7jxs=;
        b=abtcjv9/0oMcqR1gJlj+xcd7SNdhlGHVLjZzTiSiIZo3DnQIYaJuwa+EK2sDfY+OTj
         1wCJJuQg2EkKDdBGnHOHIa5DfqbJoL4gm/xJqofq6vttyk7QNRL8NcHnNgCfC8rO4yPw
         ugBze9n6daXcW63/vQ5+4jvGb28GRgYHSK2u+C5H8AcaPEj9ZLIrcpP7Sfj/92ZJtqrj
         HLZR18XwqCH0YClF8CQcTz06v1/Hdp3rRsQrKcNQlpNl1JdlnXdoi1cthrJqr2wTKtRP
         MurXuSw15RlqW7XC9Iif+FlOmDY0/AiWQbaw9VP3vzUQp4cwdxUNXnaiTl8mgQXflgeF
         PITw==
X-Gm-Message-State: AOJu0YwLjCxbe6zJQC0mJJHnd10dC1p4YMCqh/lZfloydWqhD0uVB++m
	c0tx+V0MSxnSepvu4ZG2moabNmE5xWGmXEAgSEnDwiJ2l6JeMed1FjBl+bMN1g==
X-Gm-Gg: AZuq6aKW0u+tzzGqzTJhIR9sXDsXOhMdNHbBObWlLrd3BfXN1xeRpgFbhjMow+xp0i9
	vRC4tSoyREGlG5AzyFeAzfVQ3T9YxMGUDFpBOETdCuvJVocFdpkH/LDMmpFbl0PfVZLWWt3LQhP
	NobeUNJ8p4V4pU6f6FK/ODJtzw6ehIRimkF5ittm6mKG5pFztRHd2jOMRepGEhUqZ6B0flJ8F/H
	wOQsWyirsgKArrutJGE01sc9KyI48lXhwk8qsYwIhI6Zfzhkeiew/AjiOF1REkmHyz83gklDVDH
	LiMyJWOOXReUPB8Rb/069Dx7eWXAfTW26K1sMeFw2N71NK8XgN26nJ44oDjFniL4OnPZtMJceFK
	+e7uAOtlHv89T+LTlMLwkCakX3Ng4ZgEgh6zxnjHSXMHRrxE11KMIomueucX8Y18aC7WhJdd/rj
	BWFYgLX14U5Dtcujc/zEnz2jt0Y0GKanhirC55dHSWz/rjLrh7Bnah4mGVAeP61J6QbJfhg+ldl
	w9PIjgoFJjBghr6rg6zxYxpmL86unbZ6rl8QCbRluuwnTWluQ==
X-Received: by 2002:a17:90b:2b43:b0:340:ad5e:ca with SMTP id 98e67ed59e1d1-3543b30535fmr7680002a91.12.1769914459249;
        Sat, 31 Jan 2026 18:54:19 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f6230d5dsm15203994a91.17.2026.01.31.18.54.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Jan 2026 18:54:18 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	mykyta.yatsenko5@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v9 bpf-next 5/9] selftests/bpf: Add stress test for timer async cancel
Date: Sat, 31 Jan 2026 18:53:59 -0800
Message-ID: <20260201025403.66625-6-alexei.starovoitov@gmail.com>
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

From: Mykyta Yatsenko <yatsenko@meta.com>

Extend BPF timer selftest to run stress test for async cancel.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/timer.c | 18 +++++++++++++++++-
 tools/testing/selftests/bpf/progs/timer.c      | 14 +++++++++++---
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
index 4d853d1bd2a7..a157a2a699e6 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -23,13 +23,14 @@ static void *spin_lock_thread(void *arg)
 }
 
 
-static int timer_stress(struct timer *timer_skel)
+static int timer_stress_runner(struct timer *timer_skel, bool async_cancel)
 {
 	int i, err = 1, prog_fd;
 	LIBBPF_OPTS(bpf_test_run_opts, topts);
 	pthread_t thread_id[NUM_THR];
 	void *ret;
 
+	timer_skel->bss->async_cancel = async_cancel;
 	prog_fd = bpf_program__fd(timer_skel->progs.race);
 	for (i = 0; i < NUM_THR; i++) {
 		err = pthread_create(&thread_id[i], NULL,
@@ -46,6 +47,16 @@ static int timer_stress(struct timer *timer_skel)
 	return err;
 }
 
+static int timer_stress(struct timer *timer_skel)
+{
+	return timer_stress_runner(timer_skel, false);
+}
+
+static int timer_stress_async_cancel(struct timer *timer_skel)
+{
+	return timer_stress_runner(timer_skel, true);
+}
+
 static int timer(struct timer *timer_skel)
 {
 	int err, prog_fd;
@@ -118,6 +129,11 @@ void serial_test_timer_stress(void)
 	test_timer(timer_stress);
 }
 
+void serial_test_timer_stress_async_cancel(void)
+{
+	test_timer(timer_stress_async_cancel);
+}
+
 void test_timer_interrupt(void)
 {
 	struct timer_interrupt *skel = NULL;
diff --git a/tools/testing/selftests/bpf/progs/timer.c b/tools/testing/selftests/bpf/progs/timer.c
index 4c677c001258..a81413514e4b 100644
--- a/tools/testing/selftests/bpf/progs/timer.c
+++ b/tools/testing/selftests/bpf/progs/timer.c
@@ -1,13 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Facebook */
-#include <linux/bpf.h>
-#include <time.h>
+
+#include <vmlinux.h>
 #include <stdbool.h>
 #include <errno.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
+#define CLOCK_MONOTONIC 1
+#define CLOCK_BOOTTIME 7
+
 char _license[] SEC("license") = "GPL";
+
 struct hmap_elem {
 	int counter;
 	struct bpf_timer timer;
@@ -63,6 +67,7 @@ __u64 callback_check = 52;
 __u64 callback2_check = 52;
 __u64 pinned_callback_check;
 __s32 pinned_cpu;
+bool async_cancel = 0;
 
 #define ARRAY 1
 #define HTAB 2
@@ -419,7 +424,10 @@ int race(void *ctx)
 
 	bpf_timer_set_callback(timer, race_timer_callback);
 	bpf_timer_start(timer, 0, 0);
-	bpf_timer_cancel(timer);
+	if (async_cancel)
+		bpf_timer_cancel_async(timer);
+	else
+		bpf_timer_cancel(timer);
 
 	return 0;
 }
-- 
2.47.3

