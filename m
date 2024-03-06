Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7658605B3
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721958; cv=none; b=NPErN81H9vLKNUp+cJqnaFli0t/ZaOg94LLN6hHONEL/2zOf4Sc5wWthEf1TTzmto7gNcr05khzflYpBMMir8fmc3E+7l9/2uFAOQyQryOuf3lqDFR0OKLGq+O79yAoZFxCFDB+O9T+NC1vpxEnp11m8ZYaGZ6rTRq5lrm5D55I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721958; c=relaxed/simple;
	bh=rqgFbIeNuDVsN10Y3Wc/XO8EnZl5RUPoZprVYF/DQc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARv8iwEBDEX+qeDGMMITq9SqL1r+cH240Dbn8C7NKYT0x2BuX07y3spw1n9J4CzVU/3vmqTVv76w2m3tYpV0XjqIDvS4q5PehrVz/ie7jXxk2Djc3z9q9NMqCW3z9MQk+YjK1R6otuOEmdFZWGo7h29mWb2Raq6kvH8GWl6Swn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ix2Xd/SZ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ix2Xd/SZ"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so127266966b.0
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 02:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709721955; x=1710326755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sT8tEW8RnySdDbuoriCWllNRutWRJvAqN1r7dcUmjdE=;
        b=ix2Xd/SZfnh9bO+Xwx8RcfbdLRtTqlb4ZVVyxTIp4OZqfXMUd5Zqe7WdQkwE0JsSQy
         /H+MK4Z4yAwSq3bGZha7bl2ADTexsp6OPZmFN6+x/zObq2RgTnE2TGr6G7TSTuxV5YKN
         +Gbl8/rANEoFiWzOhC2SdSaKAuRd3BWKpnahsEN2xcv0c8cvNqZSvq95YV3al78++BKP
         KKtfFT7nu/ymOcd8arbHrQSJ1bOzWqCahw1RcUjLTy/dng5GPv6UJ66EHisYh0E/7FvV
         z6umUYJSFMUgIzt5W0JJ5XjsOvopEner+r/Ob1ite2xgarN8Njdt7gNGyKyLh/r1J+DS
         n3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709721955; x=1710326755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sT8tEW8RnySdDbuoriCWllNRutWRJvAqN1r7dcUmjdE=;
        b=eMw7NINH3IhhnZoBH2dOKeMXfnPM7zvn7c1Qh+zlh07McNdOHidG+IfA1qrsT+TiAw
         zYxaRNJn32vWRA7VPVCVuSfABgBQHewXabyj1UYT+1FeS03RYcyzAcVJP8QaC+LD0db4
         Wro7dVw9TO0n0eU7cbSxqpoC8aT6MURI6npYx8A7Guxe5H1MPLMjuSpa7KXBlQvUa+Oa
         i/u3ycxa5URyTFYI8nLvhMNKYWa4s77C7OO22KgKmGXzPILucfveFYbIBlNpXnrRBSNY
         ZtFhcbDCI5+c4T7HC6NYh+0oUz8eMjjqN57COwK7Lp38+a+W7U6k8TF+gvPnw+jJWnn0
         BsIg==
X-Gm-Message-State: AOJu0YxSf+gNCqczv4nRMlS3mafdQFKShWY7cBXjS0IH1n7NDFdTpkd3
	yqXmLgwfxK0SogNi5ny3Uk/nQMGpwEPrLNKcNn2UKLdnLrR/gkOYdZcafMM4
X-Google-Smtp-Source: AGHT+IFInlQzz0qIUa2Ds5TTKIIkya00rik6bD0nLjKdoDxfJHA9R4Y93T2P2TYQ1mW7nbpxNX6Erg==
X-Received: by 2002:a17:906:ca5b:b0:a45:163a:c08e with SMTP id jx27-20020a170906ca5b00b00a45163ac08emr5775241ejb.0.1709721954899;
        Wed, 06 Mar 2024 02:45:54 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906591400b00a3d5efc65e0sm7002450ejq.91.2024.03.06.02.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:45:54 -0800 (PST)
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
Subject: [PATCH bpf-next v4 13/15] selftests/bpf: test case for SEC("?.struct_ops")
Date: Wed,  6 Mar 2024 12:45:27 +0200
Message-ID: <20240306104529.6453-14-eddyz87@gmail.com>
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

Check that "?.struct_ops" and "?.struct_ops.link" section names define
struct_ops maps with autocreate == false after open.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/prog_tests/struct_ops_autocreate.c    | 52 ++++++++++++++++---
 .../bpf/progs/struct_ops_autocreate.c         | 10 ++++
 2 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
index 78948dc6445c..a5cc593c1e1d 100644
--- a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
+++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
@@ -34,10 +34,24 @@ static void cant_load_full_object(void)
 	struct_ops_autocreate__destroy(skel);
 }
 
+static int check_test_1_link(struct struct_ops_autocreate *skel, struct bpf_map *map)
+{
+	struct bpf_link *link;
+	int err;
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops"))
+		return -1;
+
+	/* test_1() would be called from bpf_dummy_reg2() in bpf_testmod.c */
+	err = ASSERT_EQ(skel->bss->test_1_result, 42, "test_1_result");
+	bpf_link__destroy(link);
+	return err;
+}
+
 static void can_load_partial_object(void)
 {
 	struct struct_ops_autocreate *skel;
-	struct bpf_link *link = NULL;
 	int err;
 
 	skel = struct_ops_autocreate__open();
@@ -58,15 +72,39 @@ static void can_load_partial_object(void)
 	ASSERT_TRUE(bpf_program__autoload(skel->progs.test_1), "test_1 actual autoload");
 	ASSERT_FALSE(bpf_program__autoload(skel->progs.test_2), "test_2 actual autoload");
 
-	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
-	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops"))
+	check_test_1_link(skel, skel->maps.testmod_1);
+
+cleanup:
+	struct_ops_autocreate__destroy(skel);
+}
+
+static void optional_maps(void)
+{
+	struct struct_ops_autocreate *skel;
+	int err;
+
+	skel = struct_ops_autocreate__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_autocreate__open"))
+		return;
+
+	ASSERT_TRUE(bpf_map__autocreate(skel->maps.testmod_1), "testmod_1 autocreate");
+	ASSERT_TRUE(bpf_map__autocreate(skel->maps.testmod_2), "testmod_2 autocreate");
+	ASSERT_FALSE(bpf_map__autocreate(skel->maps.optional_map), "optional_map autocreate");
+	ASSERT_FALSE(bpf_map__autocreate(skel->maps.optional_map2), "optional_map2 autocreate");
+
+	err  = bpf_map__set_autocreate(skel->maps.testmod_1, false);
+	err |= bpf_map__set_autocreate(skel->maps.testmod_2, false);
+	err |= bpf_map__set_autocreate(skel->maps.optional_map2, true);
+	if (!ASSERT_OK(err, "bpf_map__set_autocreate"))
 		goto cleanup;
 
-	/* test_1() would be called from bpf_dummy_reg2() in bpf_testmod.c */
-	ASSERT_EQ(skel->bss->test_1_result, 42, "test_1_result");
+	err = struct_ops_autocreate__load(skel);
+	if (ASSERT_OK(err, "struct_ops_autocreate__load"))
+		goto cleanup;
+
+	check_test_1_link(skel, skel->maps.optional_map2);
 
 cleanup:
-	bpf_link__destroy(link);
 	struct_ops_autocreate__destroy(skel);
 }
 
@@ -116,4 +154,6 @@ void test_struct_ops_autocreate(void)
 		can_load_partial_object();
 	if (test__start_subtest("autoload_and_shadow_vars"))
 		autoload_and_shadow_vars();
+	if (test__start_subtest("optional_maps"))
+		optional_maps();
 }
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_autocreate.c b/tools/testing/selftests/bpf/progs/struct_ops_autocreate.c
index 9a951ee6f55c..ba10c3896213 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_autocreate.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_autocreate.c
@@ -40,3 +40,13 @@ struct bpf_testmod_ops___v2 testmod_2 = {
 	.test_1 = (void *)test_1,
 	.does_not_exist = (void *)test_2
 };
+
+SEC("?.struct_ops")
+struct bpf_testmod_ops___v1 optional_map = {
+	.test_1 = (void *)test_1,
+};
+
+SEC("?.struct_ops.link")
+struct bpf_testmod_ops___v1 optional_map2 = {
+	.test_1 = (void *)test_1,
+};
-- 
2.43.0

