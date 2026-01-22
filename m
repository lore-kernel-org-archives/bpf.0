Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FE736F42A
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105039; cv=none; b=ow/OVQ9r0Fc+XXjmMkFWfAain7IGmkoZPCxp2oGQQ4UhSgOG4o6xDzkEzc5KPKrxz8SScNjuKjIwde9LO54rwQuk8vMiSlq4fTfLmZWCJZFuxMgs6zD9jXcBtvfHozraYHg8aUO/EIaWck2NEC6Q9f51CZvLABNpIXVBCHTnbq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105039; c=relaxed/simple;
	bh=SWyMRCjSOVCSx3FWxZDLXZnAjKeKkFv9M7p4lS61Opo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EVrVWU90aIZO7xEN3yG2cj9/rsF03LcLznHPHyuxNTfu3WDlLzHegD523kF5Fr2M08GsNSZt2E+XIdi655hdaow5p7ktSQUru/esTRsQ4vxfrZ5aKTYu4Mt6Kt3b3famXmegxm/wTuXZXhJ+a7/cFAr/BiBLWpMcuot8f7mHJfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYuH8rdr; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYuH8rdr"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa9so854204f8f.1
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 10:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769105023; x=1769709823; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z90nFROdPtst2IKVs/+csEyxpI1YETMH4mOHgmwYj7o=;
        b=JYuH8rdrM5sGniHdnA77X/NsAcbjLwtUDKKHLyGSukvJFAZ8dg33RhnjlSlLb858QT
         oAPrkk1kE6inrQn/1E7AFPYzrREwgTB/LwMHymupW2QTzLYCESOA8l+nGwgF6mJryalB
         hJ8wC6FAJCvZHNRU1XY3s7T7TgkiXyDuQCU0dk879hMlkYRV/9C/OzZIjSbGFjFr48oF
         kTPNk92MgUlI/UtyO1c2U0qcko/7WuZLuGDX/qUnRct5lfV8aZi9ctVJDN6Tg5eRm4Ub
         fDQ/4MsZJMA499UBz0kwW6DiDsX5+ZnS4f4YJjeiiivPDBL+cWY3yOC/AipbfcA1+tXx
         6waA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769105023; x=1769709823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z90nFROdPtst2IKVs/+csEyxpI1YETMH4mOHgmwYj7o=;
        b=faNCx3CO6a4UC6vB8hL5vRoXLHtArXX9nzpcwt/tiq2FkWbbns67zvbkKaGxt3gpXa
         D5Zxx7yazOK+6eypRFyshnV2sa//hwkZBob1O/Ng0wy/4C0+zU7FmdPaXM8CGCSE4WA0
         98ei1fXHXNenl45ZuW5cgGeK9VccFX56+/2nejT+zPsJmd5T2zfDeA05Ko5m72TkU924
         TTmqthatAlPumzjIOrrVG0mG6Yq21Iel4IHsRdhm8k7sFEMNCu5s76uBttdjzJj+rEj9
         XvKGd+JXPPDV+AxDiBt2iD3p5AmpfZY7ir3fvhxAgMOeM2oB1rx/hUuDHEPDgu9FLPst
         ZaeA==
X-Gm-Message-State: AOJu0YyxHz0VRJ7uSaetRelgqDjEDhB5HQIgUFYaLwqIJbyzxeQAZxZc
	31IsB6I2QoTzwZiLFj4DFJk0rVs6+4Piue/PKz1hBBWqsFMS/eP3m8Ziy3iGng==
X-Gm-Gg: AZuq6aJK7gP9lJ47YrrXq8ywU30psRRU5lURjRgFsNWCQuMsWU8xqiZzDNfHAtMvfgJ
	Zgd0XzbvmaR4wrwpDNoILfZZV2i5jK2sYkfWMEJmCAc9vPt8/ASVyevh8QI5LvkfwnlUCnPMjU8
	ubuRlkPX4kL791ElokzEAFNa2pffUq+12H9Vz4gjUGkCSRE8jo44JXH1hiXHoURd8gUvTkNKBYQ
	mAz9ApKKtUtOWYJhE6OQsgley7nLxuHV3e6zDwApDwH9iMrKyXCwY3gGCOl6RiGxD1aoP8sfl2a
	CNYB/oGIJjs07v5fwDAKtL8iOhg64R/JgRiiyxinJnffipnqERLBR+d5388RNpjNvc+um5+g5Um
	GEBqH1W/+cu67gr+OoHsK63uIqi82guoxq3MqwHqtS00DI6y0hl0HLafntj++DXkOyINp5p+IZQ
	IaHAjBJQPZpJfrhQAymdTFxZA=
X-Received: by 2002:a05:6000:420b:b0:430:8583:d189 with SMTP id ffacd0b85a97d-435b1604cebmr645601f8f.39.1769105022845;
        Thu, 22 Jan 2026 10:03:42 -0800 (PST)
Received: from localhost ([2a02:8109:a307:d900:df8b:2445:a6ca:bb5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c01783sm397495f8f.3.2026.01.22.10.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 10:03:42 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 22 Jan 2026 18:03:17 +0000
Subject: [PATCH bpf-next v7 4/8] selftests/bpf: Refactor timer selftests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-timer_nolock-v7-4-04a45c55c2e2@meta.com>
References: <20260122-timer_nolock-v7-0-04a45c55c2e2@meta.com>
In-Reply-To: <20260122-timer_nolock-v7-0-04a45c55c2e2@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769105012; l=2904;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=I12f8/2m85P/qMhnRxqBUg240K5nCwpW7fUenuGUBFo=;
 b=XcXTOiT3LyP96jW34uAnBy7kv3Skr09lwTB7jErVW6JTUixQUEepCu+3GEUmiw66wEb8Xagaz
 4aCIailjHnZA8MlXb1OKkrj4wyKEhluZ8LH50yNId/wNd8B/IUO2w54
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

