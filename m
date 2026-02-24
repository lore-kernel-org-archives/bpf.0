Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28066366DCF
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924979; cv=none; b=r4IcAcZrJ3gOS+C2SDmbh4H+BCFLTFlLjbboW9mr2LXZqRMZpVQwfeIiAj18mZJlxHbuXRaBeJQJw8pa59F63Jv0WDwabEFFab7vhNTn57ixKiENfdOz3patHXugOtQPQRY9JVusYUzazWzJI4AxjNhmluHWxoo24eEjG4hmyzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924979; c=relaxed/simple;
	bh=iA1WwvmzDS5SoQjU9t8h48yCceGfEAvtxk1RGs93S9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gamy+Ho4jOtirWr/nwGK2YyFLrKIjjxzscJ9zyH04bMcpPA6JQ1hYuycaN1Wpu5UMC+1B7ejfOQIqEigzM5NzJR3BoI/nu7yKk7bi+H0LdR166020jIa/Qg0exCzKqqufFQ7pWCC6Yfmnzkv9eY+uUbSacZhfXdJibsAVk0kMWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3Q+bRJe; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3Q+bRJe"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a91215c158so35061735ad.0
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 01:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771924977; x=1772529777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFREYxUIZ0cRYQkkmQ4UIO9hPNsMXbWBqRtIGvrYot8=;
        b=M3Q+bRJeWaj0x3+ELxz0mmwsIgrZSIyKDp3CPZQkS6PKcbBoP4u7diwN484pTO9SuS
         TrcXwuBHo/YGE2mk4OQrTRqLnS+WZcZLhGjN5D9+U2Ouoa5TUHaG6cBROiXSiw6FVC7m
         30PiTLVv2U4Rom+9AU0T/R1q9QwLCfBi1c7WSzUUMtApDFscRoXjoztuZY0hQ6eZBnIb
         op4m7i0t8O5RiJi3vHJinhgvGUGiN8ZYQXTYcMYcoU7++ARvxr4hTM1Je8HJzPHOkED2
         0Klcr75LCGdFpmA4jZfmNWcVMFD3noji7LRiIizXCDzp+ang6hdly66ipTcdLPSakO7p
         QOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771924977; x=1772529777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dFREYxUIZ0cRYQkkmQ4UIO9hPNsMXbWBqRtIGvrYot8=;
        b=k0hRIM1saHSno4YjQ4cGFqgbnymaoV+gS+seiFLjlFfcMjqeETinqA7WI/L2v7tyRh
         rVSpNXsYj7fXhG9x5bH3NhQ0Cz7yUurYwo+iG3eTXEdTRJN+hr/gK0VgptOdvCK24nwK
         7MOIFN13Q2Kc4p5RNkFAwA/bjn7PPk5JkA14xVDOAcexT8E16O8itiGfnf7JNUbUOwK2
         l7R/K9NULZhnuWjI8jzSIb+zTuQtVv+lJD4w5vi2L/zrAKwtrK7lgm4deTuhs9+iRmnX
         W2tQJqQfIPJNxZK92bCrhNtLPNPNsu3C/DOr7WhquWC7HYbu+5ZO/ZEcULChPuurHIII
         nHSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeUMNiJkXggDpwK8B5ziHuABIwUW4xgMg3AdZH86H1rauUBfoa4gDYNbcoQfd6CQFrQ+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG40GM1eb5oqrsSTrCNX45dlz1Ga0E4FGGKXnjfLHKm1iaIfPx
	6ZER7yp+SXywOHpFBTj0Dm1ptMCUaMG8ObfDC/y4UTas/0qlaG1i6LTW
X-Gm-Gg: ATEYQzxOu7rf/RmZ0GdAFGdAsVkBhikxe85Sg+FvSXJaqh5BCEcVk4mOzmpZWFa1LJA
	jfnjozb00EB+Sntdr8GIcheu0HYWztEhgrI3lEIhSIwkS9OlSHZzbQeFtLXNj4fW93qB3+AcX3I
	mqAsQfCPhPWwvAkyCOj9n6NbyVqasSE+WFe3qaacoOWzWEadtfWcqZPlT2f3kYPpc+iZTW7Abpu
	pGc0Sp+EDoC12PgUEt78PB+YdFdILumm9hw2YtQX227eeOz0mOyrTZzeduI7Ni+NaPbaIxubtQ4
	12PS9374YWEamYBbW02+S4Yrel+a2kq9nSvxz8UtLx/b/w0eWlBfSd/MZh6v3U1ChTZEbxrVt5h
	4UwBD3lNGTws2VCIW5AUIWKSHIVBbfXJnqWF5yNvuTSFXqyVjTBQduzIXtFDjTilPu09/lYYXoC
	NTZyRFKlbYMk2tzuZoqo0t
X-Received: by 2002:a17:902:ce81:b0:2aa:d287:6943 with SMTP id d9443c01a7336-2ad744353e0mr95407575ad.16.1771924977473;
        Tue, 24 Feb 2026 01:22:57 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7500e2b2sm97181695ad.52.2026.02.24.01.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 01:22:56 -0800 (PST)
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
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: factor out get_func_* tests for fsession
Date: Tue, 24 Feb 2026 17:22:08 +0800
Message-ID: <20260224092208.1395085-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224092208.1395085-1-dongml2@chinatelecom.cn>
References: <20260224092208.1395085-1-dongml2@chinatelecom.cn>
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
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
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

