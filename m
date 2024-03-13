Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C4553E3D
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 21:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366108; cv=none; b=Wt4YHHRHXAw52QRIOmNojfHyy0kTgToMEqMxvaJGVZs/24lozgI5xS4CdRICp9i2TcZKYkSdUn5p/itNMcbzAK7gsTu3CB2K1e1ntB72i9/z1Mp14DIe14p7/zxdJs+GtiMpKConTpcFGzC8Hr/LaKTt1fttYjFSHmcwwCKoQaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366108; c=relaxed/simple;
	bh=dtLdzQuBbY4kfQP4lL4sE6OJP2osySf8drptIZwprWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l61CcU0r8Ybvk7n3OHW9t5wDRWGSYi1rGQKP4OC4BzVMPAbNyonefKhYvtUJswOXasuFpqkyBcoLaUXJaKBIq6/uOU59hXEW86VIjcCujL4TULz44xq3MrMLGFVIA0iAY2KuVjJGALJ8SIV80Hlm5DhUNDar2rTbgcNeTMhjAsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0N9oy5d; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0N9oy5d"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60a5a11b59dso4035527b3.0
        for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710366106; x=1710970906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q273taNMFteBw9+l51Eedoh4iH5uR4q8TiM120xEQ+4=;
        b=D0N9oy5dctsGnfjLzqmw/gAwbxUKPE3WGEqKclIvRb8G5zhHEn78mH7zqTWRdThdc1
         rtAGeVWJ+TUSNLdfEU0yCjmic6jQpu0PQmQMJNhCxRqNMc5z1JroKdF5prkeRPrYQb8O
         HUViWR4xoXOOqSl0gjMie1rjZWDy1s5XmBo1PROf4+E8h2zM7/+pg+bfPdk3okM4E9rk
         deyKNL3R1RYwUepJNVWnY4j+HAhHEF8HA7L9ifeFNeCTg2BBp841tlhbB8xvu4Lnj9fl
         NclgJDMEdexBC0BRIobiLD50h0JUuILPmbXGzTm3yTQbzA7PXb2dwaBj7oZUb51FT9pE
         5EGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366106; x=1710970906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q273taNMFteBw9+l51Eedoh4iH5uR4q8TiM120xEQ+4=;
        b=ahBT57C4N9HR4MFV0ftAtPhUCihK76aV4dew5erkjkyn/cjCrjn9TrfucnPTsTrdYn
         kRgPpepreqbNf1sxcmouE8+swws85kon/XbZdmCuGJ1D8xFQkhifpJwnMoK6Rb8eCwWE
         m26wXNOepYWNz8YMLwDuDFiOTWZ/Yl7+DQyMCH9KIAfmGzSSvR9VVcdXyfCocZYX1QaS
         35l9cRvggB4jcKO5PssCXgNhOIGI+z1ROime2kdksJ+p1urd8bhrfcIXgpRpjNlR6W3Q
         VPC1GmoIBmWyjQNGYJQ+RNwxeC0JNpN8lCRJrdN8aEwmWY3UngVyVwgKz/HemDmZ1UXo
         MytA==
X-Gm-Message-State: AOJu0YzFVzSjUIx3ZkKFfJ4knO22NEnMFR/d0BiMT6xqp63WjL1FSCro
	wUDdsqaVS4xTrMaYIxUlX87UyyWpLcQ644G9GdgUgtR95nRvnSI1oFLk8pvz
X-Google-Smtp-Source: AGHT+IEhKYe1pmBuqIMQUmB4vD+SEDeH4iHd3C1WcIaKoFCV1tdRquA7pKszlU/uLV3wVip5JKZEiw==
X-Received: by 2002:a81:89c1:0:b0:609:fff3:bad0 with SMTP id z184-20020a8189c1000000b00609fff3bad0mr4651002ywf.7.1710366105726;
        Wed, 13 Mar 2024 14:41:45 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:30fd:440:22c1:8047])
        by smtp.gmail.com with ESMTPSA id y74-20020a0dd64d000000b00607b3038a7dsm2678950ywd.9.2024.03.13.14.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:41:45 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: Ensure libbpf skip all-zeros fields of struct_ops maps.
Date: Wed, 13 Mar 2024 14:41:38 -0700
Message-Id: <20240313214139.685112-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313214139.685112-1-thinker.li@gmail.com>
References: <20240313214139.685112-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new version of a type may have additional fields that do not exist in
older versions. Previously, libbpf would reject struct_ops maps with a new
version containing extra fields when running on a machine with an old
kernel. However, we have updated libbpf to ignore these fields if their
values are all zeros or null in order to provide backward compatibility.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_module.c   | 47 +++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_module.c   | 16 ++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index ee5372c7f2c7..098776d00ab4 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -93,9 +93,56 @@ static void test_struct_ops_load(void)
 	struct_ops_module__destroy(skel);
 }
 
+static void test_struct_ops_not_zeroed(void)
+{
+	struct struct_ops_module *skel;
+	int err;
+
+	/* zeroed is 0, and zeroed_op is null */
+	skel = struct_ops_module__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
+		return;
+
+	err = struct_ops_module__load(skel);
+	ASSERT_OK(err, "struct_ops_module_load");
+
+	struct_ops_module__destroy(skel);
+
+	/* zeroed is not 0 */
+	skel = struct_ops_module__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open_not_zeroed"))
+		return;
+
+	/* libbpf should reject the testmod_zeroed since struct
+	 * bpf_testmod_ops in the kernel has no "zeroed" field and the
+	 * value of "zeroed" is non-zero.
+	 */
+	skel->struct_ops.testmod_zeroed->zeroed = 0xdeadbeef;
+	err = struct_ops_module__load(skel);
+	ASSERT_ERR(err, "struct_ops_module_load_not_zeroed");
+
+	struct_ops_module__destroy(skel);
+
+	/* zeroed_op is not null */
+	skel = struct_ops_module__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open_not_zeroed_op"))
+		return;
+
+	/* libbpf should reject the testmod_zeroed since the value of its
+	 * "zeroed_op" is not null.
+	 */
+	skel->struct_ops.testmod_zeroed->zeroed_op = skel->progs.test_3;
+	err = struct_ops_module__load(skel);
+	ASSERT_ERR(err, "struct_ops_module_load_not_zeroed_op");
+
+	struct_ops_module__destroy(skel);
+}
+
 void serial_test_struct_ops_module(void)
 {
 	if (test__start_subtest("test_struct_ops_load"))
 		test_struct_ops_load();
+	if (test__start_subtest("test_struct_ops_not_zeroed"))
+		test_struct_ops_not_zeroed();
 }
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
index 026cabfa7f1f..86e1e50c5531 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
@@ -23,7 +23,7 @@ void BPF_PROG(test_2, int a, int b)
 	test_2_result = a + b;
 }
 
-SEC("struct_ops/test_3")
+SEC("?struct_ops/test_3")
 int BPF_PROG(test_3, int a, int b)
 {
 	test_2_result = a + b + 3;
@@ -54,3 +54,17 @@ struct bpf_testmod_ops___v2 testmod_2 = {
 	.test_1 = (void *)test_1,
 	.test_2 = (void *)test_2_v2,
 };
+
+struct bpf_testmod_ops___zeroed {
+	int (*test_1)(void);
+	void (*test_2)(int a, int b);
+	int (*test_maybe_null)(int dummy, struct task_struct *task);
+	void (*zeroed_op)(int a, int b);
+	int zeroed;
+};
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops___zeroed testmod_zeroed = {
+	.test_1 = (void *)test_1,
+	.test_2 = (void *)test_2_v2,
+};
-- 
2.34.1

