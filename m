Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5CE605BC
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 10:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721948; cv=none; b=Fkm+jOGFOSRVxyVaQU2fIEtFgEVqknoBeq8ICuGTH/xw1M7aasbm8vdKac4xhAqlplWZ0ZvpemRr/lI+9Wp0Bnwku0gV+lty7DSxnzEykwOsWI/i2cp+jMlE8vV6+xelkGhpPNusneEm9BwU4gLHYtKE1aKkvfzgKEjtMbUF4z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721948; c=relaxed/simple;
	bh=PnHswEzkTKLyrkFqxRvFfq3V7JCNVSzhJrf8FimWERg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B37dQI22jfCUn0gt5waGSwysRGwdoWEKutyBLPzl9ujNqFPkjKC5F3uodxZdlRIP2JhZKqLZI2sOX/MBM3SS04koq5J4nTwoaqvlQRiEH4glwMCJa78PMWvgqnEiE38ndvz3amtLJMazMiRgS8DL025CH9K4w/lsiqTslEfdkjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiYPeswe; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiYPeswe"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so248283166b.0
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 02:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709721945; x=1710326745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WObSvZSCuqPl1NZLtLA+BpcdBmw/EUeTAbS78t3Bs6k=;
        b=eiYPeswe2KAKVeU2seZeb+j+myGsYpj9Dg9qO6qLNBDmZ467/jwzq3ZnR3t4mmjyQv
         EWJmuEd7AXxWakVHgXJcH1m8pxJDgfPoEUifC8Movuvp4Cl2zGtGzJwcbSua35QNCTEs
         aiq/h2bRju+CGJwkn+jWPVa9479vkk31P9BSPrN3lv5ceMoii/O23PNVURSs/34+MNrl
         y5znh5nIIQLmVqNIpHU0lw9EV8A0JG7CgNsonRIWTmxLZpivkt6BwDmVU8ZLaW8WY0C6
         yZACs2g5yGrB9YJEO3ahFy058/zjeIcB5ujbqthM1xuKtVMHB25YS+OSd6XVnkJCVA58
         hW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709721945; x=1710326745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WObSvZSCuqPl1NZLtLA+BpcdBmw/EUeTAbS78t3Bs6k=;
        b=B49uyd/xwTq6zyCXQVg9ttC2lotuacdxMFK8Kxt/fNBpR2zHF/agVnFgDxzvwFeq2z
         aL65JvqcJpYeNyuJ3TOBMLWjZIKsgQFX9DcHAibfosuvcZdKUath43+OcR6/uwzW84gG
         pfMdHTU/oAo78ZnHWVf7HOZ3IjwBPTRHx7vQQEc1xArvUNjsBBdfUUkiRZjzZGnNthDR
         7igy1/XtF2hn4UHoZ7ldWaVRB6eCqbm9EiVI35fG76Mx7FKcvYvkE6M+NJ18MTRwU6R2
         XE5iMpk25oWkl5qMOjN3C7bMvwHcVEqN/RM78MRYjAwyVeUDJr9CGTDbpqrRYK3AKcfs
         oXhg==
X-Gm-Message-State: AOJu0YykW4q0rTRJpMEwQCUEdi4aPUGQ9ERpNczfamahEAiroWplLFdl
	olMUt+Yw1HoiIJgGIaQBGHSBsv04wgofuDqstFVIhxUocuE+2Qux2w6iOh4J
X-Google-Smtp-Source: AGHT+IGghzYB1ZXvUpUzcyW5Wrz64RrccRETh+Xk5SDzihjkhiKWm9vvb9k5R0tsI1dZhL+x/smZ2Q==
X-Received: by 2002:a17:906:4c58:b0:a45:ad29:725c with SMTP id d24-20020a1709064c5800b00a45ad29725cmr2539759ejw.62.1709721944882;
        Wed, 06 Mar 2024 02:45:44 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906591400b00a3d5efc65e0sm7002450ejq.91.2024.03.06.02.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:45:44 -0800 (PST)
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
Subject: [PATCH bpf-next v4 04/15] selftests/bpf: test struct_ops map definition with type suffix
Date: Wed,  6 Mar 2024 12:45:18 +0200
Message-ID: <20240306104529.6453-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306104529.6453-1-eddyz87@gmail.com>
References: <20240306104529.6453-1-eddyz87@gmail.com>
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
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  2 ++
 .../bpf/prog_tests/test_struct_ops_module.c   | 33 ++++++++++++++-----
 .../selftests/bpf/progs/struct_ops_module.c   | 21 +++++++++++-
 3 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 098ddd067224..b9b488d6d53a 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -564,6 +564,8 @@ static int bpf_dummy_reg(void *kdata)
 {
 	struct bpf_testmod_ops *ops = kdata;
 
+	if (ops->test_1)
+		ops->test_1();
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

