Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B07274B59
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 02:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769914458; cv=none; b=nhysv48m+qAePAaPKw8fOAKHbwF6Rd+LlQEVZIQAo/bxVWp+cRP1vFbqUpSplkiwJIUxkaHWZFv8fEI08gdyfBUc43tq1+Ca8LoC6wuc1amX0vJZvTEJs/yuPqtV4a3pg563pbkl/5wy4y0rYmi9d8f62176m6UbJCBvlzSjPJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769914458; c=relaxed/simple;
	bh=RdF2G2dzRkWr0V8TjZdp1zVUlL3rHWOlbit2LbRBdc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9VayVALohSpAnwIXx2G7Q+w6FsHt45kavQ0lf/VjqbcfuwLqJU+/ihXrjNgH/ObBnoZhwq3didycl2LNKhVWv89IC4+B9G5xt6/tw0qohJt9OM7/tiCxn+udwCFYIZAcqaSAmKaM6HUDve+b7Ut44oGWe6xkaZoJmptoizKKgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxHu+ATt; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxHu+ATt"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bd1ce1b35e7so2037776a12.0
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 18:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769914457; x=1770519257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APHkQLrkChI82VTQd/Qgj0NDqY47f9PUl8bOkrGs7BA=;
        b=jxHu+ATttYkGbTER3xLrKJ8eN790bvxJuuPkRndk/zycpQtel2WLNoStGAYFWO8cpx
         5yokcvzXdvlsFbv0X6pzglGgMO85AtFPrQvrIdj479kZJGzUt0vEY+LjEsIPzoed7Ooz
         nv/H0iHFqEqbUY0CxDXs0zw1l+UBqEpgVyyIR0s8QkV6ofLlq3fa2GG3zOVk3qWOlpke
         zE+qsa/XXuqXqaZxrRaJ1pGj8/gAxice8ji18niJWAAy4niQo4Lmr00Z0zMsZyi6gjrq
         EmrN35m2yBa4tTAd0mEvO5Pk+UPfSA6djq1Vn4uidqMmrHNqWieopMt3hJw2y46OryKS
         UmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769914457; x=1770519257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=APHkQLrkChI82VTQd/Qgj0NDqY47f9PUl8bOkrGs7BA=;
        b=r7UiqQ93Llmps00A9rdWue8pEBrrYPOA0AHYM/h8Yk1vSu7o8HJ8U3ZK0EZydfNXYV
         jdokIBNDfymO+8c3MSRQtY6peZMpiT/VvK6hfuSHeKcBkus8SnWGbiMuKuBd/hNvpNHB
         fs7ixwoejXY4ZcLtpiprzDVu5141a4yKbg//g1P+d07Ve1GOM2ty5FonLDBfRaY5d9hc
         6Lymkna/mliEokoiltYsvy8wu9QOxG+ZVkCO3oLmP1V6wsmgXdr0ZEG2YTGBbToDrLQU
         UwsPCZZylPhbcdIphNudbfXPled8HsV7TuaQoULEWgRBFm7t/gFIAn9ION2grA/WV9aY
         OxVQ==
X-Gm-Message-State: AOJu0Yzf+7NmpC28SvjHoGtmnatO2ZZRQsmLjnlgL+WfmYXBUpJYzMh9
	QGWa291riT0myWTR1Xq+I31b3d6WkbmxcyFrmxNysc7bw/oXn6xiv6VCIGpVEQ==
X-Gm-Gg: AZuq6aK+RBvLbSm2eZ9ot3S04peGDsIEjTN+QDEVlzS6YV9K502jJR/f0zzK+sQt3Xq
	oT2MibZ6xn1nU7Io4ZxzwQlC9DXUeQm4k8utanngBpmR2JLN19gna71VXRdbg6MMzT4wKGTojPK
	eAsa+K4hlyotLg8dvATU5OKSaYw8bBBpmtukhQbpK76BelFmVs1M3OjJnkwq83XIqgoOpJ+xhFd
	/SreNNCrYmzyTOHOLh2pxbbGbLzGPFyRh3oR2K7Ov2euM0wsG18mc9qbJno/KULOxuU9DfyyTv9
	0DkodJkwEQKA3zgOG0pjcTkClV0oUsioDx86Sr5GYkhs3XVKisYNbyjGWxunLcSBF0doLDLGC22
	K9CF8s/YyAemLVDk+NZPyN2lqwt5CLF+EIY62XJsVlgN67YjFqyJbNg3eKbspkts3GJ2TQxgUrM
	VbnqMChf1TzyMiY89hTvZ8k0BZr4U0FiLVo0YeOvSxI9K739BLwi0xFc6gqVNov5pQ3AsV2bV/i
	dmiV0VWSynw8KK86RIqbflj9Pr0/CinCJv7Ajw0WRb3BdFsOw==
X-Received: by 2002:a17:902:ea96:b0:2a3:bf9d:9399 with SMTP id d9443c01a7336-2a8d99194a9mr55539745ad.35.1769914456637;
        Sat, 31 Jan 2026 18:54:16 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b7f9a42sm114069805ad.99.2026.01.31.18.54.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Jan 2026 18:54:16 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	mykyta.yatsenko5@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v9 bpf-next 4/9] selftests/bpf: Refactor timer selftests
Date: Sat, 31 Jan 2026 18:53:58 -0800
Message-ID: <20260201025403.66625-5-alexei.starovoitov@gmail.com>
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

Refactor timer selftests, extracting stress test into a separate test.
This makes it easier to debug test failures and allows to extend.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/timer.c  | 55 ++++++++++++-------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
index 34f9ccce2602..4d853d1bd2a7 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -22,13 +22,35 @@ static void *spin_lock_thread(void *arg)
 	pthread_exit(arg);
 }
 
-static int timer(struct timer *timer_skel)
+
+static int timer_stress(struct timer *timer_skel)
 {
-	int i, err, prog_fd;
+	int i, err = 1, prog_fd;
 	LIBBPF_OPTS(bpf_test_run_opts, topts);
 	pthread_t thread_id[NUM_THR];
 	void *ret;
 
+	prog_fd = bpf_program__fd(timer_skel->progs.race);
+	for (i = 0; i < NUM_THR; i++) {
+		err = pthread_create(&thread_id[i], NULL,
+				     &spin_lock_thread, &prog_fd);
+		if (!ASSERT_OK(err, "pthread_create"))
+			break;
+	}
+
+	while (i) {
+		err = pthread_join(thread_id[--i], &ret);
+		if (ASSERT_OK(err, "pthread_join"))
+			ASSERT_EQ(ret, (void *)&prog_fd, "pthread_join");
+	}
+	return err;
+}
+
+static int timer(struct timer *timer_skel)
+{
+	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
 	err = timer__attach(timer_skel);
 	if (!ASSERT_OK(err, "timer_attach"))
 		return err;
@@ -63,25 +85,10 @@ static int timer(struct timer *timer_skel)
 	/* check that code paths completed */
 	ASSERT_EQ(timer_skel->bss->ok, 1 | 2 | 4, "ok");
 
-	prog_fd = bpf_program__fd(timer_skel->progs.race);
-	for (i = 0; i < NUM_THR; i++) {
-		err = pthread_create(&thread_id[i], NULL,
-				     &spin_lock_thread, &prog_fd);
-		if (!ASSERT_OK(err, "pthread_create"))
-			break;
-	}
-
-	while (i) {
-		err = pthread_join(thread_id[--i], &ret);
-		if (ASSERT_OK(err, "pthread_join"))
-			ASSERT_EQ(ret, (void *)&prog_fd, "pthread_join");
-	}
-
 	return 0;
 }
 
-/* TODO: use pid filtering */
-void serial_test_timer(void)
+static void test_timer(int (*timer_test_fn)(struct timer *timer_skel))
 {
 	struct timer *timer_skel = NULL;
 	int err;
@@ -94,13 +101,23 @@ void serial_test_timer(void)
 	if (!ASSERT_OK_PTR(timer_skel, "timer_skel_load"))
 		return;
 
-	err = timer(timer_skel);
+	err = timer_test_fn(timer_skel);
 	ASSERT_OK(err, "timer");
 	timer__destroy(timer_skel);
+}
+
+void serial_test_timer(void)
+{
+	test_timer(timer);
 
 	RUN_TESTS(timer_failure);
 }
 
+void serial_test_timer_stress(void)
+{
+	test_timer(timer_stress);
+}
+
 void test_timer_interrupt(void)
 {
 	struct timer_interrupt *skel = NULL;
-- 
2.47.3

