Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E12E26980F
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 03:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769225600; cv=none; b=udOqk2Z7XVzRklEunBV66uo/y+VKPRYkiXCi0F1eoB6v2YeyQi9HXg+jnB9mMsbOLT2WKRWu1aycswvbYW6R9FpU7ua5ZRcOw28kS/FRx+Ndpl9FXrfoOH3sogbJbtIjkXNbfBaKc95PmI7sx3tQGyySJZeD2fOy5l9Hc8iO3mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769225600; c=relaxed/simple;
	bh=MY0TzEwIF2cncGc4J2MGjes5OtwOQCXp+QMlMZ001rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvCyR+tNsVBEjrMJmYt5MKnkNZDTZGmR5fj175Z55qpMjiNsetGnMEeMtO0oEiTbMFfllknnQZXLrHaGTKSjEAAHkd3bXH9fSlkBCk761/yGEFDJSqPVbz0DZ0zl77HImH53HMrDDaJs2y+kYXOrnp+sqoCx1KH7VNzB83CU/Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2Ktq0i2; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2Ktq0i2"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a7a23f5915so17898045ad.2
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 19:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769225598; x=1769830398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePFOCu4by0RV/ygPSJGiVD2r6LAEFSKblHnuNBvqT3M=;
        b=T2Ktq0i2acqqKiOMV8Kuo2CUC3O7L5j6ASCRSCDI+RxNv7a+BxckrcDGtH69cnUHi/
         2P8/kCWurwddyGxqpSW9FBXIGfc4e5Kpd9S6K7Rk6mOZSbsgAtioDDbirhMqvmc5Ws3D
         D3AMZ+z58quWI9Jvqtv5HDgoiiYJWkh5kfIVsgcB3O05GTRwjOG5+qrf7jr2+l/4lUEn
         SS/adGdDzZdYWCsZY01OsVSq2VL1Sy9LUD1DAsand1iuOG1pgGKL8XP69iQqjJuMcO7R
         9YJjBRM3R2l5YE8iHu0GV/0zryinbitQMEyl+ojJTPscoUFjErLDffW8r1PUQM8w0N/N
         GjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769225598; x=1769830398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ePFOCu4by0RV/ygPSJGiVD2r6LAEFSKblHnuNBvqT3M=;
        b=tmF06PXzHa/s1ziPheX/YCLwIZCzPHSEDVePMpO9y92D+OCfizV9uClAerCUyBOQaH
         vwE7OkAar8tGczq4r1nsqftAzT0LvSjCA9QcXa0U4q2FKLjZGmQtAusK8xG4myH4Y1En
         zcbECZXS6A5CMYOYFiVYPX4g7D8EOvECoiinFUASVUN49lFHif9K7OvJG4sIZsoqheSx
         DfbITIvM2OSs2nmJEEGFXWnCIKsODBK9orreAQsCEwPev17RI6jOedb+wAekyKnXSBlL
         voNeMjkAWCgbCtPXMedTCJu9tWnI+Ii1Tt3QbMYqO/90rN9zG3ZIEcupfrTmBUH6Qzoq
         b/kA==
X-Forwarded-Encrypted: i=1; AJvYcCVeA3IOwLWP32AoNFg3VaVJB5ckxb45I63b/cY6rf6dPP06BQvaDemWmAf7y3H4vQPPnwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGDLoBDcsbojJPLlLwE19Np0Xkhgijdkg0NSXhN7RhJ5US2qRk
	SyUdpsoKQ19oKuOZ6LT65pNo5SfTmJm3Rgnzt5LL7FpaAskB7CTO8pN0
X-Gm-Gg: AZuq6aKveGoqi4hdJBwu7v71DVmfM2nm5dT9E8L8C97CaXIDXCfLq9TdDk2o6cCqFJR
	tvfQJzVscWkqta+nfJ8sf8SMQLcJzbk0fDSeXANtYd9eD/QInLmWxkpjBm1915I/8fDu/GJGHJM
	eA5wndiCbymN8kgmjZg5imVyoOtl87Gd3MjO9++GPzE3Y453xhZSmRA0THfcMlRmZuHauOjAP8P
	spHZbPke4k6RTrivQEUgeHPHEfrE5X2BiiZf2JS91dGIX9TbrBQ09ORjQ4oS+pgCSDeZaOxCk1z
	sytmkQRZgVUxaKYo0lh59LxQX3NV4FEGiBZl2RXNCn0Mn0bgD7LmAN/blQGhC+KF1F3jYDZnT8K
	gX9bG3BZl7fv65QQWjfgEjANi0gNIUjCFhfq5mCcgvKoQcn978kpgJaVjH5NmkQ14Gr7A6Q/jhX
	DjHvGxeAau
X-Received: by 2002:a17:902:db0b:b0:295:20b8:e104 with SMTP id d9443c01a7336-2a80ec7fa5amr32307055ad.58.1769225598537;
        Fri, 23 Jan 2026 19:33:18 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcddb0sm32539805ad.38.2026.01.23.19.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 19:33:18 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v12 12/13] selftests/bpf: add testcases for fsession cookie
Date: Sat, 24 Jan 2026 11:31:18 +0800
Message-ID: <20260124033119.28682-13-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124033119.28682-1-dongml2@chinatelecom.cn>
References: <20260124033119.28682-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test session cookie for fsession. Multiple fsession BPF progs is attached
to bpf_fentry_test1() and session cookie is read and write in the
testcase.

bpf_get_func_ip() will influence the layout of the session cookies, so we
test the cookie in two case: with and without bpf_get_func_ip().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v12:
- add the case to test session cookie without bpf_get_func_ip()

v11:
- add "volatile" to the variable "cookie"

v3:
- restructure the testcase by combine the testcases for session cookie and
  get_func_ip into one patch
---
 .../selftests/bpf/prog_tests/fsession_test.c  | 34 ++++++++++
 .../selftests/bpf/progs/fsession_test.c       | 66 +++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/fsession_test.c b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
index 75bb42942b67..0c4b428e1cee 100644
--- a/tools/testing/selftests/bpf/prog_tests/fsession_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
@@ -77,6 +77,38 @@ static void test_fsession_reattach(void)
 	fsession_test__destroy(skel);
 }
 
+static void test_fsession_cookie(void)
+{
+	struct fsession_test *skel = NULL;
+	int err;
+
+	skel = fsession_test__open();
+	if (!ASSERT_OK_PTR(skel, "fsession_test__open"))
+		goto cleanup;
+
+	/*
+	 * The test_fsession_basic() will test the session cookie with
+	 * bpf_get_func_ip() case, so we need only check
+	 * the cookie without bpf_get_func_ip() case here
+	 */
+	bpf_program__set_autoload(skel->progs.test6, false);
+
+	err = fsession_test__load(skel);
+	if (!ASSERT_OK(err, "fsession_test__load"))
+		goto cleanup;
+
+	err = fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "fsession_attach"))
+		goto cleanup;
+
+	skel->bss->test6_entry_result = 1;
+	skel->bss->test6_exit_result = 1;
+
+	check_result(skel);
+cleanup:
+	fsession_test__destroy(skel);
+}
+
 void test_fsession_test(void)
 {
 #if !defined(__x86_64__)
@@ -87,4 +119,6 @@ void test_fsession_test(void)
 		test_fsession_basic();
 	if (test__start_subtest("fsession_reattach"))
 		test_fsession_reattach();
+	if (test__start_subtest("fsession_cookie"))
+		test_fsession_cookie();
 }
diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index 0e1b66b2dddc..211332bdcccb 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -95,3 +95,69 @@ int BPF_PROG(test5, struct bpf_fentry_test_t *arg, int ret)
 	return 0;
 }
 
+__u64 test6_entry_result = 0;
+__u64 test6_exit_result = 0;
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test6, int a)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	if (bpf_session_is_return(ctx))
+		test6_exit_result = (const void *) addr == &bpf_fentry_test1;
+	else
+		test6_entry_result = (const void *) addr == &bpf_fentry_test1;
+	return 0;
+}
+
+__u64 test7_entry_ok = 0;
+__u64 test7_exit_ok = 0;
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test7, int a)
+{
+	volatile __u64 *cookie = bpf_session_cookie(ctx);
+
+	if (!bpf_session_is_return(ctx)) {
+		*cookie = 0xAAAABBBBCCCCDDDDull;
+		test7_entry_ok = *cookie == 0xAAAABBBBCCCCDDDDull;
+		return 0;
+	}
+
+	test7_exit_ok = *cookie == 0xAAAABBBBCCCCDDDDull;
+	return 0;
+}
+
+__u64 test8_entry_ok = 0;
+__u64 test8_exit_ok = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test8, int a)
+{
+	volatile __u64 *cookie = bpf_session_cookie(ctx);
+
+	if (!bpf_session_is_return(ctx)) {
+		*cookie = 0x1111222233334444ull;
+		test8_entry_ok = *cookie == 0x1111222233334444ull;
+		return 0;
+	}
+
+	test8_exit_ok = *cookie == 0x1111222233334444ull;
+	return 0;
+}
+
+__u64 test9_entry_result = 0;
+__u64 test9_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test9, int a, int ret)
+{
+	__u64 *cookie = bpf_session_cookie(ctx);
+
+	if (!bpf_session_is_return(ctx)) {
+		test9_entry_result = a == 1 && ret == 0;
+		*cookie = 0x123456ULL;
+		return 0;
+	}
+
+	test9_exit_result = a == 1 && ret == 2 && *cookie == 0x123456ULL;
+	return 0;
+}
-- 
2.52.0

