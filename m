Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8857F3783C0
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777230233; cv=none; b=XNvQIbToR568Ty5VCuSw/d2pRXc9+9kN9GFf+7Xj8NEhKZkcqFDTpFukEqTbaY1fpKlzOkv93Ua+l8/rS/NzJYIJ7DVgqoocu+zj+OvuJkt/zBKefP3eACwioe1Ak2S1SgUDNZfZDJDQHKoElWHs4FGRvc1KsckfW9q929jsnLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777230233; c=relaxed/simple;
	bh=FJuL0NQkXpYBXCfG6T9GBrfcSSbSG3AOa7vUTsNnBNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqapd2WFxFkhiXSj5mrbLQel7NN8n5aZ/p31A1Mz/TFJQLJGMjdxEZqoi6uYaEQAgSmca3CwLKlwJPdLFqQnuvJvxP4D+EAvHQ2sUjzYKhBxOAuhQESmpSz8QHZssy7wSWJzJgdLYCGrDxlNOeaD6XM9+Br3xjXT11LyYdKo/AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=dD2PrJ0a; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="dD2PrJ0a"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35fc0d7c310so6116801a91.1
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 12:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1777230229; x=1777835029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTbiquxLoW0qbAbsBWXnBqZupGUFJaw3xlHxqa54jVQ=;
        b=dD2PrJ0adXDwECFnTg+xlvoSU3fdcIJi2pue8WtMhvlYRaQvizxUBFMPl8XrtMdXro
         2Wskcue1d4JQ4kKsCw34mBm9ceekSzQM/OS6/8n02KyOjfndQrqTvauSZ+pZ+mySLKqz
         tdzyUzDRa+b4S00jXPIeZie/lLtRbUdq2KZO1EwA58JfHHN9f8SREeK3VkB/PRA1zXB4
         Zc/kWllLysmBC4Uqsu9gq/imYdcKTrMTUir86ujN62TxZyTwPBwdaMhjFpt+N97WgJYf
         yUYWnQh5evsJx2hJMNq/K9dwHAGjkKiLWltcp+VlmnrDFUgBteiDD4KRPXtcz0i2xH5b
         wj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777230229; x=1777835029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sTbiquxLoW0qbAbsBWXnBqZupGUFJaw3xlHxqa54jVQ=;
        b=lHSfP9XlsPHFdKm78P0iojBBISqAoFEgTJvnTX6MEEdqV234EqijlCRlCUCPRu18GS
         /Tdd2/n7BSbsGuaPyoC2zRl3utnGEEapnF4Pp4ELdKJKx7g1z7xG5SNXm8aS6xSP52sF
         x3qusdUAuEYKwwiYOGccFlNl240UPiCC6mqug/WJXoCG//9EaZz7x8I3ooJ1thbdsrZz
         azJnHFDqhiyzkx4uHM8HwpbANboe1LnYW1gHst1PAlgRvcyprM6hBN0x0AFKjOOpYWpm
         TqbGySsjSqxgM7JVvA67DxfhBWMjLSe3N7dxbgx9pKCSS1h6FnPDwfi19HNTqlPXty4c
         7e1Q==
X-Gm-Message-State: AOJu0YyP1SaPEs3ERXTLAtBeELsxRMym0QFM8wMXQIT6mnvuHXmfDOcO
	Glygfl3CuFRMnp6JVFMLJJjf/AtF8DDiy/Ky7/oob2JRRY2t5cTfI+3+hY6rQsMGdCaQ0kCSso1
	263hOU4Q=
X-Gm-Gg: AeBDievxkNWkqjdjMZjWz/jfCQSemB+ECwQK9z5PEfmNercADWcrd8m01jmv0EXw3vq
	P7uPfEpd/0a7EyiB7AbaA21cTnbFr9xZZx1BYNAzpU7oKS6B2re2ZyRmBuwO3FTXPhNe0zlSP+W
	Xb7sn4k3AwiukJEYZMHoVQzshPxVhQs5QcGfkNeq9bVP7qBVSt6uoCTad/RQri1V1EcjbopTrfZ
	UcUtaRq9cq1iJWjynRobpPxJ0YJnRFNitCoHxC4LzNk7VO0OlLZn+NueDAoyl2AXNsnZ0ZX5d7+
	7HhQtBwBDow16QIS5i5PD4rdo/YqlBdU+fVqVGrqfh7rsKhzXMNCv+pORuHyjyrxSb8iu7VJEMy
	b1FD7XuFsjidJfYm32YBumCROMyxZG1zc9GaLxp3vvmA/zTjPy2mgxxIm/M0uYJLd7zANAQ0ELE
	Qr5JTye20x2OHQptkgZF0nR2s=
X-Received: by 2002:a17:90b:1804:b0:359:83d3:27d3 with SMTP id 98e67ed59e1d1-361403c326fmr43068492a91.2.1777230228898;
        Sun, 26 Apr 2026 12:03:48 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::2af6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b7a9efd0f2sm107449965ad.31.2026.04.26.12.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 12:03:48 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	mattbobrowski@google.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v9 8/8] selftests/bpf: Reuse stderr parsing for libarena ASAN tests
Date: Sun, 26 Apr 2026 15:03:38 -0400
Message-ID: <20260426190338.4615-9-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260426190338.4615-1-emil@etsalapatis.com>
References: <20260426190338.4615-1-emil@etsalapatis.com>
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
 .../libarena/selftests/st_asan_buddy.bpf.c    | 18 +++++++
 .../libarena/selftests/test_progs_compat.h    | 15 ++++++
 .../selftests/bpf/prog_tests/libarena_asan.c  |  2 +
 tools/testing/selftests/bpf/test_loader.c     | 51 ++++++++++++++-----
 tools/testing/selftests/bpf/test_progs.h      |  2 +
 5 files changed, 76 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_progs_compat.h

diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
index 9dd2980b5d6c..97acd50ffa5c 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
@@ -5,6 +5,9 @@
 #include <libarena/asan.h>
 #include <libarena/buddy.h>
 
+/* Required for parsing the ASAN call stacks. */
+#include "test_progs_compat.h"
+
 extern buddy_t buddy;
 
 #ifdef BPF_ARENA_ASAN
@@ -141,6 +144,11 @@ static __always_inline int asan_test_buddy_blob_single(void)
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
@@ -174,6 +182,11 @@ __weak int asan_test_buddy_oob(void)
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
@@ -205,6 +218,11 @@ __weak int asan_test_buddy_uaf(void)
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
diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_progs_compat.h b/tools/testing/selftests/bpf/libarena/selftests/test_progs_compat.h
new file mode 100644
index 000000000000..9d431376c42f
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_progs_compat.h
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
diff --git a/tools/testing/selftests/bpf/prog_tests/libarena_asan.c b/tools/testing/selftests/bpf/prog_tests/libarena_asan.c
index b4fba10cdfbf..d59d9dd12ef2 100644
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

