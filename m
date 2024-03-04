Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31A37C088
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 22:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592748; cv=none; b=rMRqyD8j9BDiop8RJjKIMjAt5Ux3F8JlBAIyDeiDgfseDIDGiIqEwIy/jM3HxKnE7UM0GehuE0c7cFQODi7qAJ6t3eTpSUhCC+VXVX6lBLLsVuu+uIBw+8n7SfOljJQt3JYye70WcaYEZ/3TrFHIXKlKLtgIJkDqizYj82h7ozI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592748; c=relaxed/simple;
	bh=3ucbTocqqvyELdO97R7ddrmWT7k2ekLNsTzOQggLbK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lss1XUnLpzV+PT8cyWSgwY9jBC2dtjhh09cTRWN+BOxvKYurPZVmgsIjbXdsHMr66b4lhTjwnhTZ50HAWT4HRjP9zrIlIuTneH75bqDWoVbsVhtIwmRjrCCiA6sbavf88DhlfaKbtDP8rlNVEHV8HjnW1b40jbenjqLKZ6vZtkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuMyu28x; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuMyu28x"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-512bde3d197so4974540e87.0
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 14:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709592745; x=1710197545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kW5p4yXSsN4YghlPBvvq93ye5IVZXwFo8TqXZjsdlc0=;
        b=GuMyu28xxsRts/ThRoKn4VNYn5uB5n94HiAUvpFyexQG8g3uaVwR1G79Oy+v6ahK9T
         axMIvGQX8KSLUuJ0sljN+Ahu+sH1HW+LuSuUMlseTBW1vFCUm920Uf2Tj8/2KbbP1yYm
         NU7o5HFxDh5mWgwqO6fH6oBBIMjW3YGPTxldZzTvOorh0xhKuSWvW4wWndioy5sz4PYw
         t1Hg+s2QCDekwK79i/UWK0xMmILeU4YlUuj5cLAzeekf7xu58bPsVoFpBfYY15XrlZq5
         qJPpb7F1jbgM6XMrc6X59mwIVMCC7JbZhurP94jFkpwBZXpM2Ixae/ZR5GX8ABqrtvT7
         3aVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709592745; x=1710197545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kW5p4yXSsN4YghlPBvvq93ye5IVZXwFo8TqXZjsdlc0=;
        b=qmln1GXiKVlFjDBXx8HhDoI/Wq/KinoQahAXIwIws54SAB6HEZ8gYvp2oS6dQkGXJK
         71Xkj4DdJSLX+Bj9eHntXxgzgWfyqpqbLURLVAzchMxVDrfGZFuecWV4eocXpTADHpYQ
         GnNJRjM7XculfQfnQTmm71T1sGBBpiV/k3iX29h/R8iiL5DHGoOMt+D86oBcXY90YZG3
         t90Ls/neIiFL3sfQEOkapgAdv7HRadRpjFdsJ+VEYKE6rTOuu9hVmN/DdEsuJKKczahN
         sWhxCyO4W3jzapKBGHorQ96hx/7oIpJb6KlRwYvBMokhnpNDgwL18JgLiNvo5jlkzdec
         Cdqw==
X-Gm-Message-State: AOJu0YzsyLMv5cUOTFvSBRuQWnV/DYNPtZnQpc/BotRMrXf4fu9owWuL
	7ECFeZ4zl81sx923EEFx/fPcfvsNWfeleA7kYNz4KMQHu9zupTleYrjMccxS
X-Google-Smtp-Source: AGHT+IGj9QCGPeTHAPONF0pgEY66EVZK/ahZUU3Jf7oPjr7Je6OdBDZaU6PW0icMdQgQlsyu2PLitw==
X-Received: by 2002:ac2:54a8:0:b0:513:3dcf:35ca with SMTP id w8-20020ac254a8000000b005133dcf35camr100423lfk.38.1709592744509;
        Mon, 04 Mar 2024 14:52:24 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id qx22-20020a170906fcd600b00a4302eb448dsm5315499ejb.134.2024.03.04.14.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 14:52:24 -0800 (PST)
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
Subject: [PATCH bpf-next v3 13/15] selftests/bpf: test case for SEC("?.struct_ops")
Date: Tue,  5 Mar 2024 00:51:54 +0200
Message-ID: <20240304225156.24765-14-eddyz87@gmail.com>
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

Check that "?.struct_ops" and "?.struct_ops.link" section names define
struct_ops maps with autocreate == false after open.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/prog_tests/struct_ops_autocreate.c    | 58 +++++++++++++++++--
 .../bpf/progs/struct_ops_autocreate.c         | 10 ++++
 2 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
index 35910cbb9ca4..a89ba036e2e2 100644
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
@@ -52,15 +66,45 @@ static void can_load_partial_object(void)
 	if (ASSERT_OK(err, "struct_ops_autocreate__load"))
 		goto cleanup;
 
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
+	err  = !ASSERT_TRUE(bpf_map__autocreate(skel->maps.testmod_1),
+			    "default autocreate for testmod_1");
+	err |= !ASSERT_TRUE(bpf_map__autocreate(skel->maps.testmod_2),
+			    "default autocreate for testmod_2");
+	err |= !ASSERT_FALSE(bpf_map__autocreate(skel->maps.optional_map),
+			     "default autocreate for optional_map");
+	err |= !ASSERT_FALSE(bpf_map__autocreate(skel->maps.optional_map2),
+			    "default autocreate for optional_map2");
+	if (err)
 		goto cleanup;
 
-	/* test_1() would be called from bpf_dummy_reg2() in bpf_testmod.c */
-	ASSERT_EQ(skel->bss->test_1_result, 42, "test_1_result");
+	err  = bpf_map__set_autocreate(skel->maps.testmod_1, false);
+	err |= bpf_map__set_autocreate(skel->maps.testmod_2, false);
+	err |= bpf_map__set_autocreate(skel->maps.optional_map2, true);
+	if (!ASSERT_OK(err, "bpf_map__set_autocreate"))
+		goto cleanup;
+
+	err = struct_ops_autocreate__load(skel);
+	if (ASSERT_OK(err, "struct_ops_autocreate__load"))
+		goto cleanup;
+
+	check_test_1_link(skel, skel->maps.optional_map2);
 
 cleanup:
-	bpf_link__destroy(link);
 	struct_ops_autocreate__destroy(skel);
 }
 
@@ -108,4 +152,6 @@ void test_struct_ops_autocreate(void)
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

