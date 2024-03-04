Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C6E10A1A
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 22:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592735; cv=none; b=kzpSTGhNSoUF1waJWnDJy00cppyjr5PxTM7K75HylFYKLPUl/Y7BACSjrKiC/NmtSoV+qYShA84jHHBN0j+jvCU4EdZ1/wU5jVvC8FukgN1y7ANGKWFP/W9C/62l9ufFdiwV0dhyVXV3ed/1FLZ2HQITmRZUXJWC5go6TdPy69E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592735; c=relaxed/simple;
	bh=cEPnyfFWBE9D0OLMyGcbpMzkO4Je1leH8rHBZdxQL3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoPqhZ1pNC+T4MmBY0D8P5eSXqNpwR08dUd5XWtalMKlhaZQp6nYC/PTGOtCV0/jSZJ3tu1jqnyR9beA8F+LLS9HdAVfSVe5W911PYs6J9g8wuMB3lU8NX8KoiI3JA1IQMQvAVlyg2UdCBBS7F4A3qqhvFRUQsWQKWtdgjJSjTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFgeVij/; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFgeVij/"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a446b5a08f0so658431166b.1
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 14:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709592732; x=1710197532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uC9tgxkqjgWUVRZpjwzr6XxoNQs3LWLYSDd6/trJreM=;
        b=dFgeVij/XwpPT5+brPH1oKmNn9m+SK0xEO/ZGnfzCUzEpE+a017f+4ASk726qWiPuP
         cF0z91z2PKz6BKJ6fhfp5f2wj+8v85hT12LkYh6MIHAS3PN0M05WvumaO0nAKXoGUiLI
         EA3pQjQ8DsTh7PdW2H2WxBvdTAuy6n8Nq6COcoMPhHsvErsF0ZZrGBCDk2ei+IdKo3Ep
         2vtO2G7XNq/2ptr4FATV/Nm1eXmqMJCmMVbPjVpl4rxnul1c+hKRNlDXKZ3bp9nJ/6iB
         rDvoneGQFYf96ZUoeZCQBTrivjAFBy0pBW6yp6uDyKqvuzojZ4ES6fNmTsXgBCs0w+MX
         HXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709592732; x=1710197532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uC9tgxkqjgWUVRZpjwzr6XxoNQs3LWLYSDd6/trJreM=;
        b=Q3IrQuCuaX2XvsEsS3gXGBM4h/ZKMk9vM6xP1/n8EvOR9L2EdUPgEeNmhme5wXpA3+
         fhuVa7af84K2wLLTCnn7ate+i9C9Rbnvp17mOTpOKRk69Qa8/oa+af6KmfoYAk0lp3ka
         T7NMrObw64x07kXjhRmDB32lLLQMQSBj40Lw8tuuEyozBPhaQTq9K0ejmFmCYhjtti1F
         5lTiMB6yYTFe9fjxHYHuZB6GYx5jO8W9/KfHFBZtTezno66Nri57s/Yrx06ZasBFwOQ6
         lqgKI63Vz9Gua8EjCAZkhheovqU5HqJewp3pJKhvMSctjMdWh/LhPC9+WrXphxYxwoEK
         zAog==
X-Gm-Message-State: AOJu0YwnpVaKe2c5rTO2EdWoTFolk3YAEfJDpgJ8EWFgqIMvICu/6HjK
	UvDoyM/g7jBGI/bcPfe853XW10/XBpR8fqUKgTQ8yHHwQiMfKNWTTaRIKxdj
X-Google-Smtp-Source: AGHT+IH8i3yK8jyuprSr0IIRE6NfxyJGX6G2sxLA/kULkzoodRbr7kpB5qHW9XygrUr3udDpFoW0zg==
X-Received: by 2002:a17:906:b85a:b0:a43:fd2c:663b with SMTP id ga26-20020a170906b85a00b00a43fd2c663bmr946939ejb.33.1709592731909;
        Mon, 04 Mar 2024 14:52:11 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id qx22-20020a170906fcd600b00a4302eb448dsm5315499ejb.134.2024.03.04.14.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 14:52:11 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	sinquersw@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 04/15] selftests/bpf: test struct_ops map definition with type suffix
Date: Tue,  5 Mar 2024 00:51:45 +0200
Message-ID: <20240304225156.24765-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304225156.24765-1-eddyz87@gmail.com>
References: <20240304225156.24765-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend struct_ops_module test case to check if it is possible to use
'___' suffixes for struct_ops type specification.

Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  1 +
 .../bpf/prog_tests/test_struct_ops_module.c   | 33 ++++++++++++++-----
 .../selftests/bpf/progs/struct_ops_module.c   | 21 +++++++++++-
 3 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 098ddd067224..b9ff88e3d463 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -564,6 +564,7 @@ static int bpf_dummy_reg(void *kdata)
 {
 	struct bpf_testmod_ops *ops = kdata;
 
+	ops->test_1();
 	/* Some test cases (ex. struct_ops_maybe_null) may not have test_2
 	 * initialized, so we need to check for NULL.
 	 */
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index 7d6facf46ebb..ee5372c7f2c7 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -30,11 +30,29 @@ static void check_map_info(struct bpf_map_info *info)
 	close(fd);
 }
 
+static int attach_ops_and_check(struct struct_ops_module *skel,
+				struct bpf_map *map,
+				int expected_test_2_result)
+{
+	struct bpf_link *link;
+
+	link = bpf_map__attach_struct_ops(map);
+	ASSERT_OK_PTR(link, "attach_test_mod_1");
+	if (!link)
+		return -1;
+
+	/* test_{1,2}() would be called from bpf_dummy_reg() in bpf_testmod.c */
+	ASSERT_EQ(skel->bss->test_1_result, 0xdeadbeef, "test_1_result");
+	ASSERT_EQ(skel->bss->test_2_result, expected_test_2_result, "test_2_result");
+
+	bpf_link__destroy(link);
+	return 0;
+}
+
 static void test_struct_ops_load(void)
 {
 	struct struct_ops_module *skel;
 	struct bpf_map_info info = {};
-	struct bpf_link *link;
 	int err;
 	u32 len;
 
@@ -59,20 +77,17 @@ static void test_struct_ops_load(void)
 	if (!ASSERT_OK(err, "bpf_map_get_info_by_fd"))
 		goto cleanup;
 
-	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
-	ASSERT_OK_PTR(link, "attach_test_mod_1");
-
+	check_map_info(&info);
 	/* test_3() will be called from bpf_dummy_reg() in bpf_testmod.c
 	 *
 	 * In bpf_testmod.c it will pass 4 and 13 (the value of data) to
 	 * .test_2.  So, the value of test_2_result should be 20 (4 + 13 +
 	 * 3).
 	 */
-	ASSERT_EQ(skel->bss->test_2_result, 20, "check_shadow_variables");
-
-	bpf_link__destroy(link);
-
-	check_map_info(&info);
+	if (!attach_ops_and_check(skel, skel->maps.testmod_1, 20))
+		goto cleanup;
+	if (!attach_ops_and_check(skel, skel->maps.testmod_2, 12))
+		goto cleanup;
 
 cleanup:
 	struct_ops_module__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
index 25952fa09348..026cabfa7f1f 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
@@ -7,12 +7,14 @@
 
 char _license[] SEC("license") = "GPL";
 
+int test_1_result = 0;
 int test_2_result = 0;
 
 SEC("struct_ops/test_1")
 int BPF_PROG(test_1)
 {
-	return 0xdeadbeef;
+	test_1_result = 0xdeadbeef;
+	return 0;
 }
 
 SEC("struct_ops/test_2")
@@ -35,3 +37,20 @@ struct bpf_testmod_ops testmod_1 = {
 	.data = 0x1,
 };
 
+SEC("struct_ops/test_2")
+void BPF_PROG(test_2_v2, int a, int b)
+{
+	test_2_result = a * b;
+}
+
+struct bpf_testmod_ops___v2 {
+	int (*test_1)(void);
+	void (*test_2)(int a, int b);
+	int (*test_maybe_null)(int dummy, struct task_struct *task);
+};
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops___v2 testmod_2 = {
+	.test_1 = (void *)test_1,
+	.test_2 = (void *)test_2_v2,
+};
-- 
2.43.0

