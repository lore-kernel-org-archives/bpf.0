Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3285360887
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721953; cv=none; b=I3tu8mHWsx4AqrorAJro3w4yoTee3PJNYN2buesya2RnlMW0F2Irf7qFm2xT4+Q7U+WLq2AsoLIyTjvmuGmQfiuKkWEk50LktnxHkrj5ZbPPYIPhardngEzQRtGafO2bcFOcZDze6S3MmLTs2BcQfSLLUvlwQbmINMF7Rjb9lO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721953; c=relaxed/simple;
	bh=G4ecxg7LSoDP8MJVLH4UV2xdOkweAMnKQ77b3nVDSQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFTfmxj7WtGXBpvd418/hSRu+argCuNX5+NnDLLVV9v8cC+T5PvpfvgRbOGezLppkTkS42beaht4NQVnSGD9w/i9WnQJbhabM/buO/rRBCJavt2Xb9hwPa9heHZIAre3EE7ilF1cNGHfKKuc6qJWye+wqg5zg+ijnmYzy4imwS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjS8o/rL; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjS8o/rL"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so971477866b.2
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 02:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709721950; x=1710326750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7Tp1+0QPXm9bAZ+co/csJxjcRsh7mBUoZj4MMBt58o=;
        b=YjS8o/rLl1BdP1LoXpfh0MWYwLilYJtZPaBbPeCOwHfV2stVOennz/UE2uNj2E4meY
         nfFpbkomiaqx2yygQv1/B1Zf/jUD2IJ+b/C8u4KkzM+J+EaT2A7PX2Q3xksQQDyG5M5i
         5jPlqNeLN8InHNhOHQm6fqhMm9I62cPT2PgE9tLLi0JK5tYBEql8iNRbNzAbxCmSaqUs
         rJ1FgTjpHqE1yA4en79iHvJ7PH8njXeJsAdwnUC8nP1hhqJcnLQroqT7wjWGxSDHX/Yp
         9pDleh2+/ODkwj/X5nZgUI1dDEd2ddu++gr7vdFiiv/9d71Im1LhJilo3R+49L0cIAPZ
         +/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709721950; x=1710326750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7Tp1+0QPXm9bAZ+co/csJxjcRsh7mBUoZj4MMBt58o=;
        b=eDfcWmWimPEAcuMPQcFoZfDUfRlWSvFnnGZgahpTgxfS90kSrx8PKfQui33GaRkv46
         NUXF54rPDvtNMep2GArlxpUpAYU7xXxbB3RBjRDQ1j+M4FMCIj9DFHzP5xnev/GuuWqT
         C7D+K79rnnppRl5Fy6yaIstYbSRCubAkrvzHf3px0X6+4C9m8nPI9dc//LAfHDbd5EWi
         Ijje/ElCBuPHudSDynbQZHIXKtoNBm0tfFMfucI24dTzy6uBqzVLaZak7jv6UFSYy9Fq
         o38nO1LYj9D86x/Pv3m8P9csKDU+x6ZkGF48+/D4lR+wjm/NEttDx/SqKBTBo46ZhXNu
         z8CQ==
X-Gm-Message-State: AOJu0Yw2PnCv6DkkvjpOJkl/S989HFg1cqXoc6Ja+LWVqWlTfdvsc24l
	Q+PoGgzT4nrLLSCHL+3qZ9nv9Cx4BFmal712Cry9XxYrL81MwNq12t5RAei6
X-Google-Smtp-Source: AGHT+IEENWkkyQZSUlrGBITDlHZpJub1P5JJAfzyw/XOK2EYw1OZzJgCg9gQf8/RDxr3PBKcNHcV1Q==
X-Received: by 2002:a17:906:248b:b0:a45:ad00:eade with SMTP id e11-20020a170906248b00b00a45ad00eademr2711628ejb.57.1709721950389;
        Wed, 06 Mar 2024 02:45:50 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906591400b00a3d5efc65e0sm7002450ejq.91.2024.03.06.02.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:45:49 -0800 (PST)
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
Subject: [PATCH bpf-next v4 09/15] selftests/bpf: verify struct_ops autoload/autocreate sync
Date: Wed,  6 Mar 2024 12:45:23 +0200
Message-ID: <20240306104529.6453-10-eddyz87@gmail.com>
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

Check that autocreate flags of struct_ops map cause autoload of
struct_ops corresponding programs:
- when struct_ops program is referenced only from a map for which
  autocreate is set to false, that program should not be loaded;
- when struct_ops program with autoload == false is set to be used
  from a map with autocreate == true using shadow var,
  that program should be loaded;
- when struct_ops program is not referenced from any map object load
  should fail.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/bad_struct_ops.c | 32 ++++++++++++
 .../bpf/prog_tests/struct_ops_autocreate.c    | 51 +++++++++++++++++--
 .../selftests/bpf/progs/bad_struct_ops2.c     | 14 +++++
 .../bpf/progs/struct_ops_autocreate2.c        | 32 ++++++++++++
 4 files changed, 125 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bad_struct_ops2.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_autocreate2.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c b/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
index 9f5dbefa0dd9..6a707213e46b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
+++ b/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
@@ -2,6 +2,7 @@
 
 #include <test_progs.h>
 #include "bad_struct_ops.skel.h"
+#include "bad_struct_ops2.skel.h"
 
 static void invalid_prog_reuse(void)
 {
@@ -28,8 +29,39 @@ static void invalid_prog_reuse(void)
 	bad_struct_ops__destroy(skel);
 }
 
+static void unused_program(void)
+{
+	struct bad_struct_ops2 *skel;
+	char *log = NULL;
+	int err;
+
+	skel = bad_struct_ops2__open();
+	if (!ASSERT_OK_PTR(skel, "bad_struct_ops2__open"))
+		return;
+
+	/* struct_ops programs not referenced from any maps are open
+	 * with autoload set to true.
+	 */
+	ASSERT_TRUE(bpf_program__autoload(skel->progs.foo), "foo autoload == true");
+
+	if (start_libbpf_log_capture())
+		goto cleanup;
+
+	err = bad_struct_ops2__load(skel);
+	ASSERT_ERR(err, "bad_struct_ops2__load should fail");
+	log = stop_libbpf_log_capture();
+	ASSERT_HAS_SUBSTR(log, "prog 'foo': failed to load",
+			  "message about 'foo' failing to load");
+
+cleanup:
+	free(log);
+	bad_struct_ops2__destroy(skel);
+}
+
 void test_bad_struct_ops(void)
 {
 	if (test__start_subtest("invalid_prog_reuse"))
 		invalid_prog_reuse();
+	if (test__start_subtest("unused_program"))
+		unused_program();
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
index a5c8bb9fcb2c..78948dc6445c 100644
--- a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
+++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
@@ -2,6 +2,7 @@
 
 #include <test_progs.h>
 #include "struct_ops_autocreate.skel.h"
+#include "struct_ops_autocreate2.skel.h"
 
 static void cant_load_full_object(void)
 {
@@ -43,18 +44,20 @@ static void can_load_partial_object(void)
 	if (!ASSERT_OK_PTR(skel, "struct_ops_autocreate__open_opts"))
 		return;
 
-	err = bpf_program__set_autoload(skel->progs.test_2, false);
-	if (!ASSERT_OK(err, "bpf_program__set_autoload"))
-		goto cleanup;
-
 	err = bpf_map__set_autocreate(skel->maps.testmod_2, false);
 	if (!ASSERT_OK(err, "bpf_map__set_autocreate"))
 		goto cleanup;
 
+	ASSERT_TRUE(bpf_program__autoload(skel->progs.test_1), "test_1 default autoload");
+	ASSERT_TRUE(bpf_program__autoload(skel->progs.test_2), "test_2 default autoload");
+
 	err = struct_ops_autocreate__load(skel);
 	if (ASSERT_OK(err, "struct_ops_autocreate__load"))
 		goto cleanup;
 
+	ASSERT_TRUE(bpf_program__autoload(skel->progs.test_1), "test_1 actual autoload");
+	ASSERT_FALSE(bpf_program__autoload(skel->progs.test_2), "test_2 actual autoload");
+
 	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
 	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops"))
 		goto cleanup;
@@ -67,10 +70,50 @@ static void can_load_partial_object(void)
 	struct_ops_autocreate__destroy(skel);
 }
 
+/* Swap test_mod1->test_1 program from 'bar' to 'foo' using shadow vars.
+ * test_mod1 load should enable autoload for 'foo'.
+ */
+static void autoload_and_shadow_vars(void)
+{
+	struct struct_ops_autocreate2 *skel = NULL;
+	struct bpf_link *link = NULL;
+	int err;
+
+	skel = struct_ops_autocreate2__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_autocreate__open_opts"))
+		return;
+
+	ASSERT_FALSE(bpf_program__autoload(skel->progs.foo), "foo default autoload");
+	ASSERT_FALSE(bpf_program__autoload(skel->progs.bar), "bar default autoload");
+
+	/* loading map testmod_1 would switch foo's autoload to true */
+	skel->struct_ops.testmod_1->test_1 = skel->progs.foo;
+
+	err = struct_ops_autocreate2__load(skel);
+	if (ASSERT_OK(err, "struct_ops_autocreate__load"))
+		goto cleanup;
+
+	ASSERT_TRUE(bpf_program__autoload(skel->progs.foo), "foo actual autoload");
+	ASSERT_FALSE(bpf_program__autoload(skel->progs.bar), "bar actual autoload");
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops"))
+		goto cleanup;
+
+	/* test_1() would be called from bpf_dummy_reg2() in bpf_testmod.c */
+	err = ASSERT_EQ(skel->bss->test_1_result, 42, "test_1_result");
+
+cleanup:
+	bpf_link__destroy(link);
+	struct_ops_autocreate2__destroy(skel);
+}
+
 void test_struct_ops_autocreate(void)
 {
 	if (test__start_subtest("cant_load_full_object"))
 		cant_load_full_object();
 	if (test__start_subtest("can_load_partial_object"))
 		can_load_partial_object();
+	if (test__start_subtest("autoload_and_shadow_vars"))
+		autoload_and_shadow_vars();
 }
diff --git a/tools/testing/selftests/bpf/progs/bad_struct_ops2.c b/tools/testing/selftests/bpf/progs/bad_struct_ops2.c
new file mode 100644
index 000000000000..64a95f6be86d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bad_struct_ops2.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+/* This is an unused struct_ops program, it lacks corresponding
+ * struct_ops map, which provides attachment information.
+ * W/o additional configuration attempt to load such
+ * BPF object file would fail.
+ */
+SEC("struct_ops/foo")
+void foo(void) {}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_autocreate2.c b/tools/testing/selftests/bpf/progs/struct_ops_autocreate2.c
new file mode 100644
index 000000000000..6049d9c902d3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_autocreate2.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+int test_1_result = 0;
+
+SEC("?struct_ops/test_1")
+int BPF_PROG(foo)
+{
+	test_1_result = 42;
+	return 0;
+}
+
+SEC("?struct_ops/test_1")
+int BPF_PROG(bar)
+{
+	test_1_result = 24;
+	return 0;
+}
+
+struct bpf_testmod_ops {
+	int (*test_1)(void);
+};
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_1 = {
+	.test_1 = (void *)bar
+};
-- 
2.43.0

