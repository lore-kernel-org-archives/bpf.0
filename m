Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BAC34D4DF
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836060; cv=none; b=CmgUwKivfwU/nu4xo5FCsSUQZGgAtfw5ClK7ohhu5jvp4W9F4qRJqGGbg2u2Uf23pggtuJqVryVlxQhi2MzO6ElX5MN1+vUGNKgOPBXaPsMfUzy2ailpvb/W2tIBjD9gjF3qRrQv4yssu64jcl24zFM+FlED5034RiD5cCjRD98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836060; c=relaxed/simple;
	bh=szp2iGNF4Kv6bLZiyYuIUdsXdQpB2wVIlacXByNuPIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exINOONRHxPWDJ25Z//jc/Bp3PQOqfbVaKVEq9SalFm85iinzAUj41xE+fn/As8PaPk+sJvq+r+IVVglkJ+QrFaAujbBTaGytiEcky/rTdPW7Pnf3G+09a/YPe5fF1TY40XoASdG/kKXw3iBBixM4VwpIW19yZNU9L91KwT1IvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3WQoh/l; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3WQoh/l"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a962230847so40490805ad.3
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 00:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771836059; x=1772440859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmlGR9kLwjUsf9wLTH82AWyfcud9qPjjE5O/Ouurqko=;
        b=f3WQoh/li10ZBhMiKHTblgR84G3LSO4geEcfysg7VpqYoaRwGON4Wpij6UMAD07Zh+
         bMmATpBgjKNJgTxXg1bba1xNt9AX+6OwtFy7ESBiHJ9tUeBsZ8CCa7bk6miJqRlsZwSI
         bqM2FrKsd9pBLyjUAkigzXA59IZTZJryMB+k2dkmXappTm+Vgo79/JwCDnJQ5CxohfaZ
         zRmF2QtfDOPlBcJ5uIfxK8/AMDRj4gOp2B7MtYVOtvChAEazpuep5I7qlapoAUWvkk68
         ayxHyzCu4vBMCEyd3shXQLVYfaSIKLcSVcEM3g4y+mvX5ppV/HWmrg3FwpJK7ESl2H67
         75VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771836059; x=1772440859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jmlGR9kLwjUsf9wLTH82AWyfcud9qPjjE5O/Ouurqko=;
        b=FDGj9igfItCGvsO4jRrIDLTj38f7nhmAlLdJumfn73MUNpBvS42vakq/Fq/jgJUDko
         Tc93xcfJve3+G/3/qOm3F0rp4JgfMmQjudq4/hLhwAx3VPVVLiTCO+/HMQ5Upmvg/TIs
         z0l1njiLKeorDtlpHKP5WLmErT8Rcxu4hfPoy2pJWYfSH1cddDmkD/V0BMN3zAwEacUu
         JaxfOPEHcZgHfJkJwjOW4VnEaNfcr8P8DpKrILvYCdPYlzgOfmQPI+N8uMwbM+AhYTiJ
         f4SGj3PJ7t7ymzo5cti+A7yyW2NpbIO/AIJKgx3Y5bb6fhncsqWeys+K1aLGsX+Cstox
         MPtA==
X-Forwarded-Encrypted: i=1; AJvYcCWUkeNiITcd1Bsu1LYCsQxasCzvawg2FwCHL+eAoHh0QH9zlxFb5CM3jzNKobhuDoiYDTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ZaKG6EsU9ztg382nQRVsgdocJfPzJsxwA14olzZuePxTQe4B
	tI/4VuHWNKQJh8KXkF4VV+6KDkTTcIddb0Kn0xZ3+1yAXT2xc3p1eFLN
X-Gm-Gg: ATEYQzycho9uGQ+c2LudDrw4CVvnGbq+IlcC11MV/Hm+O8Yl3x6y09tVSdyS2bsT1lK
	WUWGqbzxpmvvykCYPiaTHPJZ04BOpR3iAf0MXSxvW4Ro3RUwX2NCeK0swFsmoCZpOYA7/7UbPFM
	oZDwkjMixRJQwMjOaU6Vsnv7LRzTfmaSopIwbos9TNlew898tZSr8dCjkWAvhOXC1XBSGNO6MHK
	Ql/ZA6R7znV+l2GKDMYjlcXMh/nfvBn2/lvqgdNR7JDDQ3OmO8dwS+j4wrCGcSU8+xWXhGGoK01
	sz8mh5+W/nDpWYIfLHNu6xWnG4u9apDWO5fMprWzNLadgx24OBAX1Yex2UApNnwljFLIMS8zgxV
	08x3livE2xLcwoBwiEBPBhZxFFjoYE3rvOCnwIzoPH3AABHMwCoMwFR/64j09xjl+n+rWIxSyYs
	Thsbk4EuFX5z4yqwPKzKmA
X-Received: by 2002:a17:903:18d:b0:2a1:3cd9:a737 with SMTP id d9443c01a7336-2ad744eca61mr84182535ad.36.1771836058656;
        Mon, 23 Feb 2026 00:40:58 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad750591e2sm65725405ad.91.2026.02.23.00.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 00:40:58 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	iii@linux.ibm.com
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	bpf@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 3/3] selftests/bpf: factor out get_func_* tests for fsession
Date: Mon, 23 Feb 2026 16:40:22 +0800
Message-ID: <20260223084022.653186-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223084022.653186-1-dongml2@chinatelecom.cn>
References: <20260223084022.653186-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fsession is already supported by x86_64, arm64, riscv and s390, so we
don't need to disable it in the compile time according to the
architecture. Factor out the testings for it. Therefore, the testing can
be disabled for the architecture that doesn't support it manually.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../bpf/prog_tests/get_func_args_test.c       | 25 +++++++++++-
 .../bpf/prog_tests/get_func_ip_test.c         | 28 +++++++++++++-
 .../bpf/progs/get_func_args_fsession_test.c   | 37 ++++++++++++++++++
 .../selftests/bpf/progs/get_func_args_test.c  | 38 -------------------
 .../bpf/progs/get_func_ip_fsession_test.c     | 21 ++++++++++
 .../selftests/bpf/progs/get_func_ip_test.c    | 23 -----------
 6 files changed, 108 insertions(+), 64 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/get_func_args_fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_func_ip_fsession_test.c

diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
index 96b27de05524..7bf8adc41e99 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include "get_func_args_test.skel.h"
+#include "get_func_args_fsession_test.skel.h"
 
 void test_get_func_args_test(void)
 {
@@ -41,8 +42,30 @@ void test_get_func_args_test(void)
 	ASSERT_EQ(skel->bss->test4_result, 1, "test4_result");
 	ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
 	ASSERT_EQ(skel->bss->test6_result, 1, "test6_result");
-	ASSERT_EQ(skel->bss->test7_result, 1, "test7_result");
 
 cleanup:
 	get_func_args_test__destroy(skel);
 }
+
+void test_get_func_args_fsession_test(void)
+{
+	struct get_func_args_fsession_test *skel = NULL;
+	int err;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = get_func_args_fsession_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "get_func_args_fsession_test__open_and_load"))
+		return;
+
+	err = get_func_args_fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "get_func_args_fsession_test__attach"))
+		goto cleanup;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test1), &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	ASSERT_EQ(skel->bss->test1_result, 1, "test1_result");
+cleanup:
+	get_func_args_fsession_test__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
index 7772a0f288d3..357fdedfea93 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
@@ -2,6 +2,7 @@
 #include <test_progs.h>
 #include "get_func_ip_test.skel.h"
 #include "get_func_ip_uprobe_test.skel.h"
+#include "get_func_ip_fsession_test.skel.h"
 
 static noinline void uprobe_trigger(void)
 {
@@ -46,8 +47,6 @@ static void test_function_entry(void)
 	ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
 	ASSERT_EQ(skel->bss->test7_result, 1, "test7_result");
 	ASSERT_EQ(skel->bss->test8_result, 1, "test8_result");
-	ASSERT_EQ(skel->bss->test9_entry_result, 1, "test9_entry_result");
-	ASSERT_EQ(skel->bss->test9_exit_result, 1, "test9_exit_result");
 
 cleanup:
 	get_func_ip_test__destroy(skel);
@@ -139,3 +138,28 @@ void test_get_func_ip_test(void)
 	test_function_entry();
 	test_function_body();
 }
+
+void test_get_func_ip_fsession_test(void)
+{
+	struct get_func_ip_fsession_test *skel = NULL;
+	int err;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = get_func_ip_fsession_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "get_func_ip_fsession_test__open_and_load"))
+		return;
+
+	err = get_func_ip_fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "get_func_ip_fsession_test__attach"))
+		goto cleanup;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test1), &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	ASSERT_EQ(skel->bss->test1_entry_result, 1, "test1_entry_result");
+	ASSERT_EQ(skel->bss->test1_exit_result, 1, "test1_exit_result");
+
+cleanup:
+	get_func_ip_fsession_test__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/get_func_args_fsession_test.c b/tools/testing/selftests/bpf/progs/get_func_args_fsession_test.c
new file mode 100644
index 000000000000..bb597f24b659
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/get_func_args_fsession_test.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <errno.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 test1_result = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test1)
+{
+	__u64 cnt = bpf_get_func_arg_cnt(ctx);
+	__u64 a = 0, z = 0, ret = 0;
+	__s64 err;
+
+	test1_result = cnt == 1;
+
+	/* valid arguments */
+	err = bpf_get_func_arg(ctx, 0, &a);
+	test1_result &= err == 0 && ((int) a == 1);
+
+	/* not valid argument */
+	err = bpf_get_func_arg(ctx, 1, &z);
+	test1_result &= err == -EINVAL;
+
+	if (bpf_session_is_return(ctx)) {
+		err = bpf_get_func_ret(ctx, &ret);
+		test1_result &= err == 0 && ret == 2;
+	} else {
+		err = bpf_get_func_ret(ctx, &ret);
+		test1_result &= err == 0 && ret == 0;
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/get_func_args_test.c b/tools/testing/selftests/bpf/progs/get_func_args_test.c
index 075a1180ec26..1bf47f64d096 100644
--- a/tools/testing/selftests/bpf/progs/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_args_test.c
@@ -165,41 +165,3 @@ int BPF_PROG(tp_test2)
 
 	return 0;
 }
-
-__u64 test7_result = 0;
-#if defined(bpf_target_x86) || defined(bpf_target_arm64) || defined(bpf_target_riscv)
-SEC("fsession/bpf_fentry_test1")
-int BPF_PROG(test7)
-{
-	__u64 cnt = bpf_get_func_arg_cnt(ctx);
-	__u64 a = 0, z = 0, ret = 0;
-	__s64 err;
-
-	test7_result = cnt == 1;
-
-	/* valid arguments */
-	err = bpf_get_func_arg(ctx, 0, &a);
-	test7_result &= err == 0 && ((int) a == 1);
-
-	/* not valid argument */
-	err = bpf_get_func_arg(ctx, 1, &z);
-	test7_result &= err == -EINVAL;
-
-	if (bpf_session_is_return(ctx)) {
-		err = bpf_get_func_ret(ctx, &ret);
-		test7_result &= err == 0 && ret == 2;
-	} else {
-		err = bpf_get_func_ret(ctx, &ret);
-		test7_result &= err == 0 && ret == 0;
-	}
-
-	return 0;
-}
-#else
-SEC("fentry/bpf_fentry_test1")
-int BPF_PROG(test7)
-{
-	test7_result = 1;
-	return 0;
-}
-#endif
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_fsession_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_fsession_test.c
new file mode 100644
index 000000000000..bbeea0d512e3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_fsession_test.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 test1_entry_result = 0;
+__u64 test1_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test1, int a)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	if (bpf_session_is_return(ctx))
+		test1_exit_result = (const void *) addr == &bpf_fentry_test1;
+	else
+		test1_entry_result = (const void *) addr == &bpf_fentry_test1;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index 45eaa54d1ac7..2011cacdeb18 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -103,26 +103,3 @@ int BPF_URETPROBE(test8, int ret)
 	test8_result = (const void *) addr == (const void *) uprobe_trigger;
 	return 0;
 }
-
-__u64 test9_entry_result = 0;
-__u64 test9_exit_result = 0;
-#if defined(bpf_target_x86) || defined(bpf_target_arm64) || defined(bpf_target_riscv)
-SEC("fsession/bpf_fentry_test1")
-int BPF_PROG(test9, int a)
-{
-	__u64 addr = bpf_get_func_ip(ctx);
-
-	if (bpf_session_is_return(ctx))
-		test9_exit_result = (const void *) addr == &bpf_fentry_test1;
-	else
-		test9_entry_result = (const void *) addr == &bpf_fentry_test1;
-	return 0;
-}
-#else
-SEC("fentry/bpf_fentry_test1")
-int BPF_PROG(test9, int a)
-{
-	test9_entry_result = test9_exit_result = 1;
-	return 0;
-}
-#endif
-- 
2.53.0

