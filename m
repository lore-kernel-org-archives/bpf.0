Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9500D36EA85
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 19:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542320; cv=none; b=SkAj5n7FiFQJe+BbSvBkTTJ7Npw33WAFubKwkLhbQBHUUxYTYfLv9SXQNSq9KqvsgRR1Pn4edANEzOfapyW1+i4nyviFMlcD801vIAwIegx+rnboB47LESZeovyE2RGRpOKeRVUTkgdWvBwWCRJGawSiFP81Omqw2wKDcR93O4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542320; c=relaxed/simple;
	bh=SWyMRCjSOVCSx3FWxZDLXZnAjKeKkFv9M7p4lS61Opo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OOQx39WA6FJV1xRdWjtpxPE4zh4q4oK/TArOglG+888RRLziumdwt5Am0FmIPGU0P/2SN5XPS2c0lMjVinuQ4SZawZTQ1Oe6nGMLLFcrc7UgtWkVVcxTnUhEB2xOMimFIDS2yQt8+Yg0nDUad3Q6/RrZljwLRtuMucZA1IcxJok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mm745zRA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mm745zRA"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ee0291921so52235615e9.3
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 11:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769542317; x=1770147117; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z90nFROdPtst2IKVs/+csEyxpI1YETMH4mOHgmwYj7o=;
        b=Mm745zRAX+rpBzt3JyMcaI87eWX7Z8Tg5ADPcUnstILYCVLG09jVGwE9Dm1IFaHsKK
         +nZj7GGx1eSdztoXf8HhlLAs9fxiBj6BMgGTs+1IyQbfcwS3rrlxAktyO7OdysafSdhM
         0yE+VxkIyOuEe2qSt/5WsdJ5zIoK1T7WdfUpse94KyueRyo1yHjA15RPJd5A7WY0LMV1
         jdlyd7mmLacfWELwVzUcmKoRoKIihQmwYE0Jj12cOw0XW8we7JwuObxcFhh0P+L/B/Pm
         fKPc7WRgrpChWnuQO30LWhB8CQ63GzztGstyb94xBX3ktIYRJMotp8yDJXS6M/BKfIJb
         JQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769542317; x=1770147117;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z90nFROdPtst2IKVs/+csEyxpI1YETMH4mOHgmwYj7o=;
        b=NWGoLAFy9zZX3Q/xUyPbE5I2j01zzNFyXP9wwnS80thRLkKCkFrfaGIGYoDWkZALqk
         fMXacPsIvl4hpvAybwHXZy8Ig6Mj/X/ReSWfIYY3+3pY5OBmeskMT3ev+dZ6HEh9gldO
         VBgddqKLF6M43fkwCxAF3W25kRYbaXkc2NI2deb49BvltM7vODOOQtqtfjP1u/Wfcf7x
         MnJNbEo6xghnr07XbrjorpFCDFX7PUANuPhs+0cALon+sPpsqqQgFWzgj8Fd2/+HOuaO
         bPusPXhb4AqFaRgaPkIG4wPtg5RjDlYf76Mp8VJHj3Ue2mTPfzFizMWMAyQ8RBpjoWlX
         2rzw==
X-Gm-Message-State: AOJu0YxU5bfNwJwps2F5u4N4bTRDrge2TCw4zsBnkD4ZerZ/Rwg1SsAk
	QLkz94igkL7KjtkLSpk3We66ARsBTR295Qt0XB4pHKVz1id3rBrxnbqMG2ruLKDu
X-Gm-Gg: AZuq6aK44VIf6gPcXusrxh5n2hGGb00brq058n02srYKhtkugg8y0XWYdMjh6X902Af
	D/BzFRkI3zMijA8ecPUyisSZdpfxZQzFW/b2tcuetZ5uqCzYVgf1GEJXLUwKC0UvIP/CdrwMNCe
	swEhTAePJmaOcDcxHCLKTi5ZmApXSnGIdgPfvaq5T6fh2u2Gor4TXCWo2tgbdYwZXosFb6ueIC6
	wPvZQr4IeVXX/3ygtdQ8dGUmqaOJ3xCY205aASL/3MFFFl2j3wwgvmd3vUHRu4WvUcqwBb26UPC
	v7IwBO/SzN7g29PR7xQEG/LKDw17YmUj/P2QC0M2CfPYRdgxr+AcLcYze3C3OclxnbgQODXy6Fi
	qJ8T6H5MAW3XZDGw2INcUh3bGdCqE3JS3zMazWzHrsDs2FdezKvymJyNICDaN0a9/Fz+cBP5cDO
	bJUhjt58nEVSfRgkah3OGDPkrZmHzYTg==
X-Received: by 2002:a05:600c:1e0d:b0:471:1765:839c with SMTP id 5b1f17b1804b1-48069c8bd00mr35016405e9.20.1769542316994;
        Tue, 27 Jan 2026 11:31:56 -0800 (PST)
Received: from localhost (i68975BB5.versanet.de. [104.151.91.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c42895sm82993715e9.14.2026.01.27.11.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 11:31:56 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 27 Jan 2026 19:31:21 +0000
Subject: [PATCH bpf-next v8 4/8] selftests/bpf: Refactor timer selftests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-timer_nolock-v8-4-5a29a9571059@meta.com>
References: <20260127-timer_nolock-v8-0-5a29a9571059@meta.com>
In-Reply-To: <20260127-timer_nolock-v8-0-5a29a9571059@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769542292; l=2904;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=I12f8/2m85P/qMhnRxqBUg240K5nCwpW7fUenuGUBFo=;
 b=GowSr/XDGZX4PZNwtAN7mkGEw7tn6vSosyRxxV1kjiEId6zy92wiGa9xW3wxt+hP6yCAPW+e+
 j7OvJvH+DNVDXGj3X+QdLUjep6jrwa2fUwNM/0UqGYXZ3sgo++4nZsD
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Refactor timer selftests, extracting stress test into a separate test.
This makes it easier to debug test failures and allows to extend.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/timer.c | 55 +++++++++++++++++---------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
index 34f9ccce260293755980bcd6fcece491964f7929..4d853d1bd2a71b3d0f1ba0daa7a699945b4457fe 100644
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
2.52.0

