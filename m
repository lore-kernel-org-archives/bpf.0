Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204F827602C
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 02:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769914464; cv=none; b=BeVWSBbm6bFskM05G6kujfrFSJ+8WqjnPv6jDsUKNyeni0QcaE6IJ5gvDCNJbAhifv2pUR0B89plgmEwWnUhGs6PXy7GaGNHIdTg9vMSSjl5MqskNcv7XiLc0ADyJUiLjm0qYmS+KvaZ4V/biQQsfBlP/KD7D+zlmIg3CnA7VCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769914464; c=relaxed/simple;
	bh=irYoqezMG3nHHZhqm8E35ZWgl3DD427/GSypk6aPt8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFXhfzBoqqZuBjIA+8TzyTTVePNUz7flsipG95xrphn+AOvWN0V64RF+KYrEEK2GXXxkawiMUtLM1/qZIGu3E17fKjQ24Nwh3ELocD0NG6Vr4mQfcmxeZ3SBH+iFCG4hLJQIIHzTdCRNfnBiB++l+63cAS4Ul58JycwA254nhE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfqAPt73; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfqAPt73"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a7bced39cfso34634555ad.1
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 18:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769914462; x=1770519262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0Pz5GqwDXqmOHCGS8xfkATZgJRf8Ib+p3Hxfq8PNTg=;
        b=DfqAPt73EUfPLKXC1msaVE//6UtpIgn7K7mEqMvaOewzBA/HW4ZceSKeAeYlA1sCr+
         OOeYUAW0tFOoZCQT2jpcBU2dt1xz6Yu482rIVcRMxutGylOkT+/40lGCzQX9gSZcc8yZ
         NILhlN45OShK2IQCwV0F9QZFEOEvXsKs/e7Q2EiuQgtYUScifEBUKWiSy1chsO0eMZjz
         WL4H+eRnxMDBKZ8S0aPkZ6XZWG7lBpm4IS55pHX7ORfs+ls0h6frvc1uQKN5eMiCJx0E
         hwdGAQfSFpy91tq0ffU0Ovycwb4p5rCUgCieniqtCWAVHu24m1IpMDx+WAIjjsCItccr
         KeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769914462; x=1770519262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q0Pz5GqwDXqmOHCGS8xfkATZgJRf8Ib+p3Hxfq8PNTg=;
        b=Dp2uj+eLiHth1PIlr6TFERki+df9aSCA46PV6qQpxoe3bq+2Tqor8TojPv+RNf0nlI
         uN+OygEp9CIcLA7t/NsugAXvKgGxd7oFKA5kMOM4qZh8Oanwsmn1VEaCWAbIIiRAzI4g
         oYw74AMPJnUMoHfIXt/m3QIhsEIdcB83LEag+TGUkcdSGXTcKRiN+N2/4WZm93zHdN+u
         lFmRdtDUDt38MOVeGKJKTJUCoPA+1icaTlOhCR7UapSzQh/dENbgqTf4CHw5vVtQ45iX
         ZGm7Ah21D2twc2X+DX6xSPUQSyWH/TUNd+opk58oBOFadcSU071VldGQKdK8KuEVbsuZ
         uKAA==
X-Gm-Message-State: AOJu0YyMKOQpUkxRayTwod9/P2U4g3Ua5KFXDTjKJibhpshgxYwr51sw
	h/wpEibOEGqsC2clBQyR5N7ngSqfxkODtOEkwxvA/81FaNrYnVnuXB5lU7qYww==
X-Gm-Gg: AZuq6aKpgKf1k9g9otV2CfvNqqj2RLVAG/KSYXtFRLxj1KcKcJDbpG+2PyqrPpRVxS8
	uqEqvjG/TXQRjjxXeNbPo9uZ2oatkQmTC7G2wOcdgEsAeQO8ApgrrSWaWEl71eoY4XbkvvOzwgx
	hywNB3NBOlp8qe8Z1zVOKMiVWFL8a7PD1Nmc557CgJr5p31nMcaaVAmlM0IMOYxlXCcw3wJzAWd
	iD8eQwMxrwwVauxMvNJV2KH9UmEYLR3WYBM0T1GS1wxlHSrws/aCepGENfyAG+KYj1m9w+r/gYv
	XcCkmzb+UkebQ7l7vCchoqALjCLZhKKTVBQbx323/NXx/0ixcoAiqSWLqARDuvJ8eqPIvpIMlMu
	9qeiVBDfCUpCmEOBC9iePT4iZ6efO38zISLHvWemvDVBtRVg0Ak+lQdQtrZJR1stiK/uurAjuYX
	G/kI6lZDSHan66D6R4gUtitCVhbZUNC5sQkH4lT8XXzQwb7rTjtREi7BOX0h0mcIqyK5oR4wQSr
	tTMEMu++LQWlhG1GsqWnPSjX51KOdbD9/Eizowdnud+km6XWxEyS7D0HRZJ
X-Received: by 2002:a17:903:244f:b0:2a5:8c95:d823 with SMTP id d9443c01a7336-2a8d96a6a6bmr84399325ad.10.1769914462044;
        Sat, 31 Jan 2026 18:54:22 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eef44sm113963045ad.11.2026.01.31.18.54.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Jan 2026 18:54:21 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	mykyta.yatsenko5@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v9 bpf-next 6/9] selftests/bpf: Verify bpf_timer_cancel_async works
Date: Sat, 31 Jan 2026 18:54:00 -0800
Message-ID: <20260201025403.66625-7-alexei.starovoitov@gmail.com>
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

Add test that verifies that bpf_timer_cancel_async works: can cancel
callback successfully.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/timer.c  | 25 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/timer.c     | 23 +++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
index a157a2a699e6..2b932d4dfd43 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -99,6 +99,26 @@ static int timer(struct timer *timer_skel)
 	return 0;
 }
 
+static int timer_cancel_async(struct timer *timer_skel)
+{
+	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	prog_fd = bpf_program__fd(timer_skel->progs.test_async_cancel_succeed);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	usleep(500);
+	/* check that there were no errors in timer execution */
+	ASSERT_EQ(timer_skel->bss->err, 0, "err");
+
+	/* check that code paths completed */
+	ASSERT_EQ(timer_skel->bss->ok, 1 | 2 | 4, "ok");
+
+	return 0;
+}
+
 static void test_timer(int (*timer_test_fn)(struct timer *timer_skel))
 {
 	struct timer *timer_skel = NULL;
@@ -134,6 +154,11 @@ void serial_test_timer_stress_async_cancel(void)
 	test_timer(timer_stress_async_cancel);
 }
 
+void serial_test_timer_async_cancel(void)
+{
+	test_timer(timer_cancel_async);
+}
+
 void test_timer_interrupt(void)
 {
 	struct timer_interrupt *skel = NULL;
diff --git a/tools/testing/selftests/bpf/progs/timer.c b/tools/testing/selftests/bpf/progs/timer.c
index a81413514e4b..4b4ca781e7cd 100644
--- a/tools/testing/selftests/bpf/progs/timer.c
+++ b/tools/testing/selftests/bpf/progs/timer.c
@@ -169,6 +169,29 @@ int BPF_PROG2(test1, int, a)
 	return 0;
 }
 
+static int timer_error(void *map, int *key, struct bpf_timer *timer)
+{
+	err = 42;
+	return 0;
+}
+
+SEC("syscall")
+int test_async_cancel_succeed(void *ctx)
+{
+	struct bpf_timer *arr_timer;
+	int array_key = ARRAY;
+
+	arr_timer = bpf_map_lookup_elem(&array, &array_key);
+	if (!arr_timer)
+		return 0;
+	bpf_timer_init(arr_timer, &array, CLOCK_MONOTONIC);
+	bpf_timer_set_callback(arr_timer, timer_error);
+	bpf_timer_start(arr_timer, 100000 /* 100us */, 0);
+	bpf_timer_cancel_async(arr_timer);
+	ok = 7;
+	return 0;
+}
+
 /* callback for prealloc and non-prealloca hashtab timers */
 static int timer_cb2(void *map, int *key, struct hmap_elem *val)
 {
-- 
2.47.3

