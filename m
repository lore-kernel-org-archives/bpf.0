Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F14B36EA8F
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 19:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542327; cv=none; b=VAhhYYAua6ZNsYo6+70b6Wj8fELHLbQEvBixIWtoHHaF4LBZbskjKyScVmGycy6tyH/VJl9sj/kVh0721cHIoxg8nT3SHr6YxOX38tjrPr61khe4lCoLPqWBfPukZTd3cMdDXxGdZYsCF3an6gSZCR/ztPwWvw8//d5/EsU0sBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542327; c=relaxed/simple;
	bh=GhLUF0L0IpH45tda1zr/y9KpIGofV4tcu+8hyTPCFfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CcaLA9NK3TK3SPXY4+Ble4ECahKN1N+AWC6NmPtQM+bNZ5eGXC97qaIX9cTnxnf5gdHCPRm5yajBnqa3jtrhh1B1GG9ql6gmNj/C328BMJzVyLdpVOkgl+aTjqXfNPq+l6904H8rfR2dr9lMWqS41rpWbhXzbv9P5KPKybXSSeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjY151yZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjY151yZ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47eddddcdcfso35852195e9.1
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 11:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769542324; x=1770147124; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xLMYYolyJjqq6i9TpWAlkvvOL0WcqfDjXNv5Xko3nI=;
        b=XjY151yZ2TjirzQZUSf/dydhH1/b0VorGVNqOneFHX/c6TsElKGgoqaRV6mcVSygAs
         OTpWRj+/VjihBaUC+i+mgQOqmL7AD7a5TcLCNNuZJDxT6fNIjqd8LV6vkERcz/Q66/6u
         sS0giVrsz7u+6L++PNuQr5MwIfg13HCnX1cpBv1qSZVR+mcOi8I5+ZT14Bn30Yixl+zS
         U8mGqwIYn5I83yG52y4jIj9RlqWGNK/sGQuT7ue2GzswE0fXCo8KAAw+pRhcOCRUpfhi
         3759yZEDt18Xdc7m5UGSap1gO6ctBMyXjDr2hOngZ//5Otn2p1XB5KnFm+zIIN3EbhMt
         y4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769542324; x=1770147124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0xLMYYolyJjqq6i9TpWAlkvvOL0WcqfDjXNv5Xko3nI=;
        b=sHPabEvtqYBjc5IcwGyqgWH901PCp0VMUN+2TpYQa98Eaef0s6DsLI5Fw249Tw/knF
         9TyekJWBuxy7WD66H2dSTXtIJhSUMLAfTSygIe8P1CvuMaLn/vIKCHkkYc5wTbBSLAIr
         1Y/FlwlM4ZlQnI+2NkNcNEFr+4P/CPhlrcl0TvTrYMzkqK26XCJZu/voMrXpj8kriXe7
         mGIRmvLbsAKp0Nb6ik7FWTh9OdqImITrHHoyBOAc27eFK/j7Jkq1y8UxJG4b97NdSpwF
         dybc9tOOAamOywDiBBzyt07z/ydXrc51x01QpO1AmkrBhVfFsSbr04uYBDQqAfdbOYaH
         uLoQ==
X-Gm-Message-State: AOJu0Yy1rHBPgEjhcH6w8w+Uj311gHmz0o7rrkS7RySUMJ1NXBfm9Qqu
	za/i7/knMtqU8mB4zMs22UAS1WjZTMefBj/PwbdZzCQiapgu5iT2pN0oZiaMkBMZ
X-Gm-Gg: AZuq6aIHQt24SgxQqbhXnfFe9WbyMSEdlkW8x4SDmQVV1TP8DKX/U+pkG5+W4K0xdAi
	K7BAhtESH620kgVZsVKt9nbF9THmdPwHoVUoLql0KOTIXnsZBDhg+osqLzfK3/VBgb6ZhadnWnx
	SMyLhVFHZy1WWHNC9xFzmJrsZsbQyAMNnkxpzmHVlnv0qU9k0nPNZbtdetJ0YtwF3T/anBxy/yc
	7XrhtKNJ6EDSeNjo/Y6RWPkfUf2pZ5mGr8ZdlHqwJPHk0IJP9b9WG41qInJgJyv364tMIf2EQTY
	rYNXpzujSiL9qLow+VxRe251XuLLp8mR5Up43c4MW2Yc9qINUeBFWBZS+SxROm3znaQOU6lg8TG
	HwWdl9+ceKATkvmBO4aaSSvsJ9aZeAZOS/vFoWnZC2TnRUb0HyF8mQwGlwpajlD+ny/m9yQ9vbD
	oFQIgp6FDbwnWednrW5vF5pZdkI9bMoQ==
X-Received: by 2002:a05:600c:4e94:b0:477:639d:bca2 with SMTP id 5b1f17b1804b1-48069c0e146mr37872315e9.4.1769542323491;
        Tue, 27 Jan 2026 11:32:03 -0800 (PST)
Received: from localhost (i68975BB5.versanet.de. [104.151.91.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c42895sm83000485e9.14.2026.01.27.11.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 11:32:03 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 27 Jan 2026 19:31:22 +0000
Subject: [PATCH bpf-next v8 5/8] selftests/bpf: Add stress test for timer
 async cancel
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-timer_nolock-v8-5-5a29a9571059@meta.com>
References: <20260127-timer_nolock-v8-0-5a29a9571059@meta.com>
In-Reply-To: <20260127-timer_nolock-v8-0-5a29a9571059@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769542292; l=3034;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=8om38gAdspUYGhhX2UZoUsJGe+8wJ7bi5do3dC7FV58=;
 b=0ccXKsv7ErhAAqImhY3zor3STxO8Rgb4H3JR+r8k03MNXJaWrjsNwr+fmzoiIgBM1Vg2t+T7Q
 06b1tGWW7QODbYH1ef/PoeZ3W2KurOl3LvxuPh3tLKo7SY36yl4Tu7x
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Extend BPF timer selftest to run stress test for async cancel.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/timer.c | 18 +++++++++++++++++-
 tools/testing/selftests/bpf/progs/timer.c      | 14 +++++++++++---
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
index 4d853d1bd2a71b3d0f1ba0daa7a699945b4457fe..a157a2a699e638c9f21712b1e7194fc4b6382e71 100644
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
index 4c677c001258a4c05cd570ec52363d49d8eea169..a81413514e4b07ef745f27eade71454234e731e8 100644
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
2.52.0

