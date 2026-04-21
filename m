Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA9D533D6
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776790257; cv=none; b=gtFQ1xf77PvcLw2/MGTTb018Ke4HRFpKRlnIUeAtbKXOs55jPrqIx+R92kH41TQJ6baMkhmD3uCWUCsHcvlvqKLQTE7ep6VLGPjCjuYK6b8STX50NM7tDFcfhDdqXHg3EWjXPQyks40kvIsnAmljHtnAurp/XcGksBMcq7ITVZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776790257; c=relaxed/simple;
	bh=wBVzE0YiFRzFmGcdNGeG08pvE5VCoG+FG6OR/Y5ZECk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alEqho98FHqWOURGtUE/qYggPuBCgOXQuLOd7giMErW+0VxH8meVHJkblruBP9NLjohQXcMwY7SNyPzH6b3Y4R0W4X6kvcS2/hknHEvpqRFISPaGoJfqO6wvbd2ltBtzMwMAwFyL2EYVx/E8ufzckg1x2r6t24LtvEJ3Pl9g+Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=i28cX+yp; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="i28cX+yp"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c8f9846c8so3164635c88.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 09:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776790253; x=1777395053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKRj+yWil7siAgVLYl1cN496dUY16Ak7ydfQm7oVR34=;
        b=i28cX+ypAbV+kFNIpmfYDwXzNpzbt/ogiz4HCVJYugaFX4Sl1TLKREIA1WYxhy+Co0
         n+GFDV51XbwaTiXNM3E97r8HaAa12z0KIw8c/6fgtCr390hjYj4hojjl4oJQcpR8Q26+
         eXZWUTfUszkcgv1nQUXYV9k/C4ZURYYj0EBdwFlSq74UTfM3jBeMMHa2ZPgjY/P8OrRt
         SafBAFQtb2kFQYo6wsaQbnTaHw49QINFvXMjWvwzzRylnB2Xc38Xoq1Y/CNgti8wok4I
         yiPoqbFaaipxlZpJL/NY+obSF9/fyZiUTBs5eXGFpJ3Xfe2EWEaZ9OZQzqmzMpj8tAW5
         0hEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776790253; x=1777395053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WKRj+yWil7siAgVLYl1cN496dUY16Ak7ydfQm7oVR34=;
        b=jWL6XU83qjjzEoSbOYpT7YWOydKNSrZ3wCLFM3NYuRsHRCV2tHYWk9h0MNNRAJZLm5
         VDalaaG85tpN76mfoskEyF4apZ0+/+8/i8Ng3cDnF0OyQfHdw/VcPEIqXQe4PZh7vj52
         qty+XYwxCGEeszDbX0amQSI4p2Ilc7flCtAT0U59TZSth0J/xSCtfesZf7PJWRqbEQWi
         pg3e3Ws05aZN7Xzzdqk7Nr+fjwhg21sSE1l2uk5WyEa0JVtPWNXCmjZ02vtQLvpdxby2
         Ekt1rgzDrbwQCoGqptfDI5YCugrpc9kXoPx2Rie/LpIwqmem2uPjylVJKs4XEr79HVQb
         8Zmw==
X-Gm-Message-State: AOJu0YzRsRb4BFaloXyXJ7PX7elkWOaN/bwR/k9oIoTxzSFUPFGnNSUE
	45BW13CUitPwI0/bdQuDgZPg0IfviiRMqy9vopC+te4U1hEaPOIvdi5qcNMhHifYPx1z4/Meb/h
	v+4/ZRh3bbD5m
X-Gm-Gg: AeBDievPWG+EOOL1v3qec/dLBaTAd6TIzRPMEBI6u2P0sZMB1uLDxX9/4jbRNrKavtF
	lt/AJYYhlEPwdEPX3SER8fVOn17e9seTrlj0vm8xeX6Mpkgu/BIiW/wGQl4zHXdBN1tV6VN65Wq
	r4DhNwUPR7D8qjeaRLpg4QrzVroBgSMhnYTQlB0RXK/dhsnB1/gWZXJPh/p7KrhOdFovDJiFbuC
	i2rTc+ZtYPFRIO93Ttp8YIQ+8aorcte/z0rh9ZsCLUi4FyEdfXnciHn+n5ttpBCa3dMg2JZosEQ
	+BH4+HTOfs7hEkFPYJ4M7Zi7+xb6XkoTOIVf0qICmZAFDH3jAooRPJrB8nM9/71lXAFEzHmfkCa
	CgcQDdNpDvBOwe92FCxa3R6CY46O3BmtoafCf23SqjpEZXNSXJc64RL19TaGfNbknI1W81OSMmJ
	VQbeq+3fgyyN66bh91pFMzZW7sWJKbCg==
X-Received: by 2002:a05:7300:fb94:b0:2c5:220c:5670 with SMTP id 5a478bee46e88-2e4646ccd74mr9249012eec.2.1776790252866;
        Tue, 21 Apr 2026 09:50:52 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::8110])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a8018sm24514993eec.8.2026.04.21.09.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 09:50:52 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v8 8/8] selftests/bpf: Reuse stderr parsing for libarena ASAN tests
Date: Tue, 21 Apr 2026 12:50:37 -0400
Message-ID: <20260421165037.4736-9-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421165037.4736-1-emil@etsalapatis.com>
References: <20260421165037.4736-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add code to directly test the output of libarena ASAN tests.
The code reuses testing infrastructure originally for BPF streams
to verify that ASAN emits call stacks when the selftests trigger
a memory error.

Since stderr() testing uses logic from test_progs, it is only
available on the test_progs-based selftest runner. The standalone
runner still uses internal ASAN state to verify access errors are
triaged as expected.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/test_progs_compat.h  | 15 ++++++
 .../libarena/selftests/st_asan_buddy.bpf.c    | 18 +++++++
 .../selftests/bpf/prog_tests/libarena_asan.c  |  2 +
 tools/testing/selftests/bpf/test_loader.c     | 51 ++++++++++++++-----
 tools/testing/selftests/bpf/test_progs.h      |  2 +
 5 files changed, 76 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/test_progs_compat.h

diff --git a/tools/testing/selftests/bpf/libarena/include/test_progs_compat.h b/tools/testing/selftests/bpf/libarena/include/test_progs_compat.h
new file mode 100644
index 000000000000..9d431376c42f
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/test_progs_compat.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#pragma once
+
+#ifdef __BPF__
+
+/* Selftests use these tags for compatibility with test_progs. */
+#define __test_tag(tag)		__attribute__((btf_decl_tag("comment:" XSTR(__COUNTER__) ":" tag)))
+#define __stderr(msg)		__test_tag("test_expect_stderr=" msg)
+#define __stderr_unpriv(msg)	__test_tag("test_expect_stderr_unpriv=" msg)
+
+#define XSTR(s) STR(s)
+#define STR(s) #s
+
+#endif
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
index 4b995cce2730..4c1eef263e88 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
@@ -6,6 +6,9 @@
 #include <asan.h>
 #include <buddy.h>
 
+/* Required for parsing the ASAN call stacks. */
+#include <test_progs_compat.h>
+
 extern buddy_t buddy;
 
 #ifdef BPF_ARENA_ASAN
@@ -142,6 +145,11 @@ static __always_inline int asan_test_buddy_blob_single(void)
 }
 
 SEC("syscall")
+__stderr("Memory violation for address {{.*}} for write of size 1")
+__stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
+__stderr("Call trace:\n"
+"{{([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
+"|[ \t]+[^\n]+\n)*}}")
 __weak int asan_test_buddy_oob(void)
 {
 	size_t sizes[] = {
@@ -175,6 +183,11 @@ __weak int asan_test_buddy_oob(void)
 }
 
 SEC("syscall")
+__stderr("Memory violation for address {{.*}} for write of size 1")
+__stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
+__stderr("Call trace:\n"
+"{{([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
+"|[ \t]+[^\n]+\n)*}}")
 __weak int asan_test_buddy_uaf(void)
 {
 	size_t sizes[] = { 16, 32, 64, 128, 256, 512, 1024, 16384 };
@@ -206,6 +219,11 @@ __weak int asan_test_buddy_uaf(void)
 }
 
 SEC("syscall")
+__stderr("Memory violation for address {{.*}} for write of size 1")
+__stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
+__stderr("Call trace:\n"
+"{{([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
+"|[ \t]+[^\n]+\n)*}}")
 __weak int asan_test_buddy_blob(void)
 {
 	const int iters = 10;
diff --git a/tools/testing/selftests/bpf/prog_tests/libarena_asan.c b/tools/testing/selftests/bpf/prog_tests/libarena_asan.c
index 4e54949b1e3a..46e73cf77540 100644
--- a/tools/testing/selftests/bpf/prog_tests/libarena_asan.c
+++ b/tools/testing/selftests/bpf/prog_tests/libarena_asan.c
@@ -25,6 +25,8 @@ static void run_libarena_asan_test(struct libarena_asan *skel,
 
 	ret = libarena_run_prog(bpf_program__fd(prog));
 	ASSERT_OK(ret, name);
+
+	verify_test_stderr(skel->obj, prog);
 }
 
 static void run_test(void)
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index c4c34cae6102..ee637809a1d4 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -93,7 +93,7 @@ void test_loader_fini(struct test_loader *tester)
 	free(tester->log_buf);
 }
 
-static void free_msgs(struct expected_msgs *msgs)
+void free_msgs(struct expected_msgs *msgs)
 {
 	int i;
 
@@ -789,6 +789,43 @@ static void emit_stderr(const char *stderr, bool force)
 	fprintf(stdout, "STDERR:\n=============\n%s=============\n", stderr);
 }
 
+static void verify_stderr(int prog_fd, struct expected_msgs *msgs)
+{
+	LIBBPF_OPTS(bpf_prog_stream_read_opts, ropts);
+	char *buf;
+	int ret;
+
+	if (!msgs->cnt)
+		return;
+
+	buf = malloc(TEST_LOADER_LOG_BUF_SZ);
+	if (!ASSERT_OK_PTR(buf, "malloc"))
+		return;
+
+	ret = bpf_prog_stream_read(prog_fd, 2, buf, TEST_LOADER_LOG_BUF_SZ - 1,
+				    &ropts);
+	if (ret > 0) {
+		buf[ret] = '\0';
+		emit_stderr(buf, false);
+		validate_msgs(buf, msgs, emit_stderr);
+	} else {
+		ASSERT_GT(ret, 0, "stderr stream read");
+	}
+
+	free(buf);
+}
+
+void verify_test_stderr(struct bpf_object *obj, struct bpf_program *prog)
+{
+	struct test_spec spec = {};
+
+	if (parse_test_spec(NULL, obj, prog, &spec))
+		return;
+
+	verify_stderr(bpf_program__fd(prog), &spec.priv.stderr);
+	free_test_spec(&spec);
+}
+
 static void emit_stdout(const char *bpf_stdout, bool force)
 {
 	if (!force && env.verbosity == VERBOSE_NONE)
@@ -1314,17 +1351,7 @@ void run_subtest(struct test_loader *tester,
 			goto tobj_cleanup;
 		}
 
-		if (subspec->stderr.cnt) {
-			err = get_stream(2, bpf_program__fd(tprog),
-					 tester->log_buf, tester->log_buf_sz);
-			if (err <= 0) {
-				PRINT_FAIL("Unexpected retval from get_stream(): %d, errno = %d\n",
-					   err, errno);
-				goto tobj_cleanup;
-			}
-			emit_stderr(tester->log_buf, false /*force*/);
-			validate_msgs(tester->log_buf, &subspec->stderr, emit_stderr);
-		}
+		verify_stderr(bpf_program__fd(tprog), &subspec->stderr);
 
 		if (subspec->stdout.cnt) {
 			err = get_stream(1, bpf_program__fd(tprog),
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 1a44467f4310..37955a8ad385 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -563,5 +563,7 @@ struct expected_msgs {
 
 void validate_msgs(const char *log_buf, struct expected_msgs *msgs,
 		   void (*emit_fn)(const char *buf, bool force));
+void free_msgs(struct expected_msgs *msgs);
+void verify_test_stderr(struct bpf_object *obj, struct bpf_program *prog);
 
 #endif /* __TEST_PROGS_H */
-- 
2.53.0

