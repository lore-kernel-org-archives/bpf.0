Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE6A389110
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776106985; cv=none; b=aGfeqDFi41T/rY/gDzE8dZIhJHbvveYvlOF6ECp2MsOXi52EAFl04yJXhG1oXIMALtyoiYFEhoT6xPPH8jq4UmSZjPSRXWHyniqC0vRw9DJdV8r7UOfvXFmXPuv6KHMSmyCRMtA+1Y5OFjW+hFJeQRwKAO9VRnmRDhKoZIEmK7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776106985; c=relaxed/simple;
	bh=pMpwvXE7yOaZrVTGmBsC5B/Lv9HpgVAuB4OWHRd1f38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djc779tCkavhZQb/U3q0q1Xqa7DxqtFk7p4AwEUFqQfCztJNSuPHyWPiDygKPulhR/3klubJZhfu5rrWIIo3i+79bD7Qlwl3VwIOsdLxrdC390FH/JUiLraqDGi8bY7lFqg5jDIn5Yagu6XFflMXW9fKjLK/JVB/wr05FouzyJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+o53yZM; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+o53yZM"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c76b0cda2aeso1966756a12.2
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 12:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776106984; x=1776711784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UZ7jkkKZAtYbyD2FZ41mfTnzdOMPoraKwEtxgxHrUE=;
        b=a+o53yZMY+3kBl2Tjf47rOnTC+s0qsBFKswHbUQYUDoHdohUz0BTHeu/Enmz+w3/Rg
         fZoIHSQarw8knQ26AxMWXoDuRWA+2Cu7DmODfz9SsTjyIVyiuGQJ5Vv9F2yaKyXptiQD
         puISDhGDpkH8O5yPROtCG43pLEDDOxaFS57YpplR/EXLTwv+XCO85oz07vjCv/XYGCPI
         6++ciEybRafbfJKPRyh87CxLGCzVVFYnPKa/LNtDlQZwbWag8FmAXQp/5bFkiQvBENsO
         U9ts8xzaFH4n5MOfV0FbfaeNJflGmmcn1V3ZbGqTAS8guhpXXBqE+q2eRnC/2Pohb0bO
         BRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776106984; x=1776711784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8UZ7jkkKZAtYbyD2FZ41mfTnzdOMPoraKwEtxgxHrUE=;
        b=NqyQWqe/JSZ531cJi5/Z5VYvG7DWnoC/2HGhDUVUlBKDpdApAJcPylxtiBErUgGwkf
         G5W6sONo+kpkvZM8J8O6VpjnH/Ld/rRDMZQUR7sDW39vU8agKhsx1XwHT4F5mdu0hS79
         T/vPTYO5XKc/PMQp54XRIa65Y9cP0TjoCivZGpQKpsT5D2y94tk3Hhr0GEppJnPlxxAi
         5XFlOHmKF4f2zeWlfjS5QEgH+NARzbAFqpCxhD9jAD4+jwck+iWJQvaBp+QoobLOiVNb
         6SUPBxJx7gWLkKqJYxY42aCi6zQZMdxByCqD0M7e+Z7HJCjf5CgXFeEcSTGkV7MuVCMJ
         9MBw==
X-Gm-Message-State: AOJu0YwrWp/MU4XmLHiSNBV/DD55OHWLaNWg5mM6LHzZFKnt1I6qLmcA
	AjxnglBBpRV9yaHIEMVReLZGKyzc7bM/QaacbeI85wya+Pr6qURd2kccy4BpSw==
X-Gm-Gg: AeBDieusKOlsTXlrsEkSi0QXMlHxrB+Tah67/mBxOsslaHjrkYcjCncV3mqPpxFvfpP
	Y55gT5mnPktl/IAYnuK3vfxLQTl01g95I3KdMxa6DPPoqEFJn5OBI0f6CkWdveliJTPpD2N+SOE
	5vwAMKTm2YXTmHVh8L9wrJ/whkHfVO3hMqNqTpeKc560IG0S9XxM7+GQb/zUXkvunMOVi6npCrW
	Nl14DAXQPTUNjcrFAmgn0jkt6vsBW5Gd1n/wgjVHLRxNLvIteHw52qHjTL9p//zbnWTbtACihcK
	mQUxD3Mqy00ESMmfPu63CAfpZtolMapiG4f1U49+SZ5zBSIneTbiN5MpTiaAOGIyz7zA3jAWvif
	oBYTS42bZhsGq4pQyfIRY9HR6I9uZtRnMQsIeTCyHKQ0pmzbH+ReHzRgIuquqI8BYIL6BGvhneX
	ZKGJ2E5sE5jSqczw==
X-Received: by 2002:a17:902:ebd0:b0:2b0:60b2:4f8 with SMTP id d9443c01a7336-2b2d59c812bmr102768895ad.15.1776106983554;
        Mon, 13 Apr 2026 12:03:03 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4ddcda9sm126867825ad.28.2026.04.13.12.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 12:03:03 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yatsenko@meta.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 3/3] selftests/bpf: Test small task local data allocation
Date: Mon, 13 Apr 2026 12:02:59 -0700
Message-ID: <20260413190259.358442-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413190259.358442-1-ameryhung@gmail.com>
References: <20260413190259.358442-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure task local data is working correctly for different allocation
sizes. Existing task local data selftests allocate the maximum amount of
data possible but miss the garbage data issue when only small amount of
data is allocated. Therefore, test small data allocations as well.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/test_task_local_data.c     | 78 ++++++++++++++++++-
 1 file changed, 74 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
index 8b99b4880d24..6a5806b36113 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
@@ -30,12 +30,12 @@ TLD_DEFINE_KEY(value0_key, "value0", sizeof(int));
  * sequentially. Users of task local data library should not touch
  * library internal.
  */
-static void reset_tld(void)
+static void reset_tld(__u16 dyn_data_size)
 {
 	if (tld_meta_p) {
 		/* Remove TLDs created by tld_create_key() */
 		tld_meta_p->cnt = 1;
-		tld_meta_p->size = TLD_DYN_DATA_SIZE;
+		tld_meta_p->size = dyn_data_size + 8;
 		memset(&tld_meta_p->metadata[1], 0,
 		       (TLD_MAX_DATA_CNT - 1) * sizeof(struct tld_metadata));
 	}
@@ -133,7 +133,7 @@ static void test_task_local_data_basic(void)
 	tld_key_t key;
 	int i, err;
 
-	reset_tld();
+	reset_tld(TLD_DYN_DATA_SIZE_MAX);
 
 	ASSERT_OK(pthread_mutex_init(&global_mutex, NULL), "pthread_mutex_init");
 
@@ -247,7 +247,7 @@ static void test_task_local_data_race(void)
 	tld_keys[0] = value0_key;
 
 	for (j = 0; j < 100; j++) {
-		reset_tld();
+		reset_tld(TLD_DYN_DATA_SIZE_MAX);
 
 		for (i = 0; i < TEST_RACE_THREAD_NUM; i++) {
 			/*
@@ -296,10 +296,80 @@ static void test_task_local_data_race(void)
 	test_task_local_data__destroy(skel);
 }
 
+static void test_task_local_data_dyn_size(__u16 dyn_data_size)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct test_task_local_data *skel;
+	int max_keys, i, err, fd, *data;
+	char name[TLD_NAME_LEN];
+	tld_key_t key;
+
+	reset_tld(dyn_data_size);
+
+	skel = test_task_local_data__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	tld_keys = calloc(TLD_MAX_DATA_CNT, sizeof(tld_key_t));
+	if (!ASSERT_OK_PTR(tld_keys, "calloc tld_keys"))
+		goto out;
+
+	fd = bpf_map__fd(skel->maps.tld_data_map);
+
+	/* Create as many int-sized TLDs as the dynamic data size allows */
+	max_keys = dyn_data_size / TLD_ROUND_UP(sizeof(int), 8);
+	for (i = 0; i < max_keys; i++) {
+		snprintf(name, TLD_NAME_LEN, "value_%d", i);
+		tld_keys[i] = tld_create_key(name, sizeof(int));
+		if (!ASSERT_FALSE(tld_key_is_err(tld_keys[i]), "tld_create_key"))
+			goto out;
+
+		data = tld_get_data(fd, tld_keys[i]);
+		if (!ASSERT_OK_PTR(data, "tld_get_data"))
+			goto out;
+		*data = i;
+	}
+
+	/* The next key should fail with E2BIG */
+	key = tld_create_key("overflow", sizeof(int));
+	ASSERT_EQ(tld_key_err_or_zero(key), -E2BIG, "tld_create_key overflow");
+
+	/* Verify data for value_i do not overlap */
+	for (i = 0; i < max_keys; i++) {
+		data = tld_get_data(fd, tld_keys[i]);
+		if (!ASSERT_OK_PTR(data, "tld_get_data"))
+			goto out;
+
+		ASSERT_EQ(*data, i, "tld_get_data value_i");
+	}
+
+	/* Verify BPF side can still read the static key */
+	data = tld_get_data(fd, value0_key);
+	if (!ASSERT_OK_PTR(data, "tld_get_data value0"))
+		goto out;
+	*data = 0xdeadbeef;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.task_main), &opts);
+	ASSERT_OK(err, "run task_main");
+	ASSERT_EQ(skel->bss->test_value0, 0xdeadbeef, "tld_get_data value0");
+
+out:
+	if (tld_keys) {
+		free(tld_keys);
+		tld_keys = NULL;
+	}
+	tld_free();
+	test_task_local_data__destroy(skel);
+}
+
 void test_task_local_data(void)
 {
 	if (test__start_subtest("task_local_data_basic"))
 		test_task_local_data_basic();
 	if (test__start_subtest("task_local_data_race"))
 		test_task_local_data_race();
+	if (test__start_subtest("task_local_data_dyn_size_small"))
+		test_task_local_data_dyn_size(64);
+	if (test__start_subtest("task_local_data_dyn_size_zero"))
+		test_task_local_data_dyn_size(0);
 }
-- 
2.52.0

