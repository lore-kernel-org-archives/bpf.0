Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D983F36F436
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 18:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105035; cv=none; b=hSiQceB9edPZRnR0h537M9vOa5CrGotP+Drs4Ary+W0PKK9mPOWA/BRXJ46i2nYVx85+qiNE3o1qOzxEP3XE/SIv5P3hHsOKeswS/eSxx4in6awVOzeMnK+aW/+pdQsitH/GT7yGVRGaPD+ThmuWPryaLC5065V6ory+qZDNWZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105035; c=relaxed/simple;
	bh=GhLUF0L0IpH45tda1zr/y9KpIGofV4tcu+8hyTPCFfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J8Fgrn1Z/k/Mf4ITHdYjihwApTJr3JgQs87GXNMWgJCIumpQAKNsRJn8am1kN0R4Ro46alTfqnqCBiL20+MAGS3T7pZlT7/67AmR+gyMvPHVd6I3qKdmsm45iV+JBRcYvlPJkO2YqO2rRjwBD/QMmh2XNYhoMz+5vru5CXguigY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VD3udAAs; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VD3udAAs"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4359a316d89so1012401f8f.0
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 10:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769105025; x=1769709825; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xLMYYolyJjqq6i9TpWAlkvvOL0WcqfDjXNv5Xko3nI=;
        b=VD3udAAsfRZUJpTBGAJs2EOub97w2LArWrviySdxSnx4V+Yx+VEGVY7OdGj1QNmmGe
         6rUuLdi7Y9oi7jPsME8y4RQ80LiLZLvCIWf9aF/Iw0J7lHvy37sNTx3yXlYHAKp3jQ1/
         6g7hB8+hpvLCc5TlmodIlSPDLOZZGAEar8AIIvs5aCOecgIw7ZQZTBE3/GMrYto2N7+r
         /MsEztP/kibCylz6juNSQ7kjscR/qfH2UIGPcYW+EAWOwc230yYOb+uADd3JwWjTROLI
         sA2JN07FQe3to10Puh0RYuFaUwvNGvmv78ibQL8U0yEa7f9iNwHKdBk32fQBvJSjp+ak
         Zqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769105025; x=1769709825;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0xLMYYolyJjqq6i9TpWAlkvvOL0WcqfDjXNv5Xko3nI=;
        b=XHns8+oMEZKYAXivcJ2x8zJekC41DZTvi5KSvUoax+1G6ZXRnoUloxNxDKIv9StCEy
         FpDQPAlYtGUpF2yso44IK/klAT0ThcboU18d5XHs49oLhzjyyclSNlQ5TPouNVGeqhQj
         VUVRQxwdvT9GZoV+Q3XQS9s6cNZarGrI/Yx/c4cnTEmH3dCFtxMHStZWSKgCF47GYhDA
         vVJ02V/mUeTXg8yjrwAMpfcmXvo6Hmq1H3JOPULdo9xCseGBvJCvxtRDBSt0fn6A5pPH
         yyal0ymkjmu6ib4ivlAl5As8xQuuWsDDBdTbCT27CQaojMpGMfciRd09rAY2MHA6q3kH
         Z8tQ==
X-Gm-Message-State: AOJu0Yy7pPHdAnPFf3q4aBdDfE0mJ/GJ46SgclOz7falRvsmelqWJk4a
	RhIpTd1gmCKG64HOUdx2ZbU6+pzNi2RfC6hTTU52mFs4kxnPNx0an4mN
X-Gm-Gg: AZuq6aL7/lHX1OVQ42SGzVhK5zhDjwbMdFFQUH+NHhMPJWQn2WkzipXvy+U/Cy7D9yx
	EJytmW4arjMLEjt4Rzu5/nxI6GEzmgmsqYxnSSJC5rfaBDmR6fhHXLwyD5n0/nnh7eh0Qi3Avm5
	OGRvBuQFpriSL9B9BK7FWLffXQVCQMrCFpBy+km3rLvMMG3lDX7cMmIHvKJS7l9jvVafSJEV6c+
	hA0vNO0QHuTYfCfEh8lN8O3ftu6Gw++jtsNp8TqBDm9aSnWidNQShrJsMH9OaV1L7RqpU9X9YCF
	hn1fEg+YL7otWkreFemHpeYyMc1h5bXqZ9bgdYKpoB9WXQsVa0mqw69Uq9KmFdIf8Yx9ybmJaFP
	PDAFmXr3Bt4IMF7tECWzonOUjba1TfK4Hkk9DQNXPuMHoCHbNT/XSMKUql9gV6yNpYoGPSwVVQX
	b65QFbQ4tZfd/L
X-Received: by 2002:a05:6000:40dd:b0:435:8f1b:bb28 with SMTP id ffacd0b85a97d-435b130e05amr737579f8f.0.1769105024538;
        Thu, 22 Jan 2026 10:03:44 -0800 (PST)
Received: from localhost ([2a02:8109:a307:d900:df8b:2445:a6ca:bb5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e716b6sm344208f8f.27.2026.01.22.10.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 10:03:43 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 22 Jan 2026 18:03:18 +0000
Subject: [PATCH bpf-next v7 5/8] selftests/bpf: Add stress test for timer
 async cancel
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-timer_nolock-v7-5-04a45c55c2e2@meta.com>
References: <20260122-timer_nolock-v7-0-04a45c55c2e2@meta.com>
In-Reply-To: <20260122-timer_nolock-v7-0-04a45c55c2e2@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769105012; l=3034;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=8om38gAdspUYGhhX2UZoUsJGe+8wJ7bi5do3dC7FV58=;
 b=WUrX6xbRscNaIMQrVP58Ak9KRQKC5Ia2qKwWW808kPTxWBHqilEYP2ZC8wYKRaBNkh3bLDc8m
 up9I6YoaTvKDMsQLGjiinIrKUH5V6NktNHIGyU6aQuTOkwbdtrHQ0nN
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

