Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6A93A6F1D
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 19:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776367903; cv=none; b=M9pIOvRG6LIHTm5IR6OluJShGeQP4v0fFfT92ImVxyhj6YmjZdFAa5/AFAQsxeXKYczcTvklXOww6SLgxis4dhZkyDZlkWfGr+A/TmSBlJ+ZclmJgALJSyEul65gdaBNBjaElu5QUjw9y6a/2NESRK7Yffc0fBG2bgM2zVJt7Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776367903; c=relaxed/simple;
	bh=ku5U3Ka0ndjPXP92siQHnGkpd1bCq2hgtWQ4GejuUdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fv0ANKpSoDgCjhAd3UCOSc2AS5ZZ88ZsZRP7Yvf7WTqg3tsEih9aM8qfX18CeMFY2dmDk4LFr5T3ZIcDyfJLrhWHWyTL9bgrIUHFFJeKGPEKwWJG2Zj5i4EolrVSM56KRZy16a2FV+xZQ+y6uoipkLL34OSaFOceuVh8Cme+yYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZFvUmzRE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZFvUmzRE"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a4bc360bso46923095e9.0
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 12:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776367897; x=1776972697; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oynt2x6SXKNaRU8MrrgQe7iSYgm0Zd6fxbgaEr/IL1k=;
        b=ZFvUmzREKj3T1DA+CIZqL2jiH5cDObOCYjoB0ipJTYGz3ajfGm7r/TPITUvx1/oTye
         saW2j6tVOoVBbyk0iS1aHYCTahG8EtfHC4YZRHZodRfVVgN0aNNuefy2JFQ/DSdbDgjq
         6yjQRauRBIhP+9SNilHAs4wJrF9wMeqlqj/K3sl8YyAN+spCf0f/UfWuyaejes+XnRIw
         OvUccqyiiSrW2db4jIObzd9MzSPGHN6UtXJRdKvoFFX9sgUT9Pl+xaiaNpx1uJEwXChG
         TeoAEf9GVTWhK9luGzmPMYD6MOBfyOJlX7fAEEmEoNqxfL7Akj706cj9bigpo7MemAeG
         RF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776367897; x=1776972697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Oynt2x6SXKNaRU8MrrgQe7iSYgm0Zd6fxbgaEr/IL1k=;
        b=cR5bb4PXutYakO6JPJNwbamUZEU6/BlbAJLCQH63oPpqrhp13KbFLj50LO63MkhVzQ
         /X0RkQ4p28OPj8ifEWAgIvtAQJpZhWAhBkTT5NjHQL/Vlkyg34s3dejBfAXkioUdP/I1
         abCMARlECmr62Osp3IWNRAwCjxBRXbMGGT6jtnOGJmDeLDCFmsU9Nit3JHrYsAy8cRF6
         jSsRI8F19d83OcnkA929Q8Hlh4HxDXZUlOJD8/6Onn3Ekk9a5y/kcptlps2SNsLYj+mq
         jj1yjVxjCRgvolpnSBLPLH0WY4kdHn9n8rwwPg2vEoV4o+eH9trmhB38W6x26dGE/Ca0
         Zm2A==
X-Gm-Message-State: AOJu0Yzc/jhXLMFWa5aTgs6cM1H7gcUdneshRs9gDRb6A0wQS0Vi4pUU
	Ku5LqDpdOmUbtQMFABhoF8oELZnlNSDjdXHPLmWQKv7dBFfv524seWs4OhZ0+XvIWB8=
X-Gm-Gg: AeBDieupZNtskxDy/N1l0U4am/S98zJftuQySPvrvhn1Egdy1ZKz8bO5YHBWRsYI6lI
	u19tM8n8Fnhoa1fRACY9QhToe/ydInPcEGP3pkuTKcHDXU9ZiCOzy20ZhOaVmC0yVQ8dPn52qDQ
	+LBvefAllBp1XUQayKwiUziq8E93jDkYPyiXXGGm6f5H3B3NTqgBu//EQTyoBvDwA0FDrymuC31
	T4FHY6wX3AcK+LBsnPT5Kqz6h8IAkcAppKloP3+QrSnQQa1mFRH25PzUIqODQcvuJzpxA+uH6+N
	STr40Aghe8GoCDaGPcYIDYx5nspzwHnYLEKPN7Nzr+SnJIzrnbI0AZ8JELBWhwrdfNYvhw/4SB2
	O7Uwv5QkHs4KfjWz07JscznO64n25+PCSccImiVJjQZoaLwHmI1AA/YCnHQolWQd8LwxW5Qxg70
	dFj5gqL8w5xI2nHWkQFIXmEUg=
X-Received: by 2002:a05:600c:3154:b0:480:4a8f:2d5c with SMTP id 5b1f17b1804b1-488fb2af6e7mr2318855e9.29.1776367896617;
        Thu, 16 Apr 2026 12:31:36 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:dc8:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c5e6b5627sm6987349c88.13.2026.04.16.12.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 12:31:35 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 16 Apr 2026 16:30:59 -0300
Subject: [PATCH bpf-next v7 10/11] selftests/bpf: Provide weak definitions
 for cross-test functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260416-selftests-bpf_misconfig-v7-10-a078e18012e4@suse.com>
References: <20260416-selftests-bpf_misconfig-v7-0-a078e18012e4@suse.com>
In-Reply-To: <20260416-selftests-bpf_misconfig-v7-0-a078e18012e4@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Alan Maguire <alan.maguire@oracle.com>, 
 "Ricardo B. Marliere" <rbm@suse.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1776367852; l=5376;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=ku5U3Ka0ndjPXP92siQHnGkpd1bCq2hgtWQ4GejuUdw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAkDjl45d5sRPklc34PmgKC8ECMgmGvgnKN9F7L3tHXdaC5iKfmi09X8sHsAiSLv+gJwpnkZNcm
 KACycMQPNjg0=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Some test files reference functions defined in other translation units that
may not be compiled when skeletons are missing. Replace forward
declarations of uprobe_multi_func_{1,2,3}() with weak no-op stubs so the
linker resolves them regardless of which objects are present.

Move stack_mprotect() from test_lsm.c into testing_helpers.c so it is
always available. The previous weak-stub approach returned 0, which would
cause callers expecting -1/EPERM to fail their assertions
deterministically. Having the real implementation in a shared utility
avoids this problem entirely.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 .../testing/selftests/bpf/prog_tests/bpf_cookie.c  | 17 +++++++++++------
 tools/testing/selftests/bpf/prog_tests/iters.c     |  3 +--
 tools/testing/selftests/bpf/prog_tests/test_lsm.c  | 22 ----------------------
 tools/testing/selftests/bpf/testing_helpers.c      | 17 +++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h      |  1 +
 5 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 35adc3f6d443..5a864cd8ad1b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -252,10 +252,17 @@ static void kprobe_multi_attach_api_subtest(void)
 	kprobe_multi__destroy(skel);
 }
 
-/* defined in prog_tests/uprobe_multi_test.c */
-void uprobe_multi_func_1(void);
-void uprobe_multi_func_2(void);
-void uprobe_multi_func_3(void);
+/*
+ * Weak uprobe target stubs. noinline is required because
+ * uprobe_multi_test_run() takes their addresses to configure the BPF
+ * program's attachment points; an inlined function has no stable
+ * address in the binary to probe. The strong definitions in
+ * uprobe_multi_test.c take precedence when that translation unit is
+ * linked.
+ */
+noinline __weak void uprobe_multi_func_1(void) {}
+noinline __weak void uprobe_multi_func_2(void) {}
+noinline __weak void uprobe_multi_func_3(void) {}
 
 static void uprobe_multi_test_run(struct uprobe_multi *skel)
 {
@@ -574,8 +581,6 @@ static void tracing_subtest(struct test_bpf_cookie *skel)
 		close(fmod_ret_fd);
 }
 
-int stack_mprotect(void);
-
 static void lsm_subtest(struct test_bpf_cookie *skel)
 {
 	__u64 cookie;
diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testing/selftests/bpf/prog_tests/iters.c
index a539980a2fbe..7c0b59fdf498 100644
--- a/tools/testing/selftests/bpf/prog_tests/iters.c
+++ b/tools/testing/selftests/bpf/prog_tests/iters.c
@@ -7,6 +7,7 @@
 #include <unistd.h>
 #include <malloc.h>
 #include <stdlib.h>
+#include <linux/compiler.h>
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 
@@ -202,8 +203,6 @@ static void subtest_task_iters(void)
 	iters_task__destroy(skel);
 }
 
-extern int stack_mprotect(void);
-
 static void subtest_css_task_iters(void)
 {
 	struct iters_css_task *skel = NULL;
diff --git a/tools/testing/selftests/bpf/prog_tests/test_lsm.c b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
index bdc4fc06bc5a..d7495efd4a56 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_lsm.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
@@ -5,36 +5,14 @@
  */
 
 #include <test_progs.h>
-#include <sys/mman.h>
 #include <sys/wait.h>
 #include <unistd.h>
-#include <malloc.h>
-#include <stdlib.h>
 
 #include "lsm.skel.h"
 #include "lsm_tailcall.skel.h"
 
 char *CMD_ARGS[] = {"true", NULL};
 
-#define GET_PAGE_ADDR(ADDR, PAGE_SIZE)					\
-	(char *)(((unsigned long) (ADDR + PAGE_SIZE)) & ~(PAGE_SIZE-1))
-
-int stack_mprotect(void)
-{
-	void *buf;
-	long sz;
-	int ret;
-
-	sz = sysconf(_SC_PAGESIZE);
-	if (sz < 0)
-		return sz;
-
-	buf = alloca(sz * 3);
-	ret = mprotect(GET_PAGE_ADDR(buf, sz), sz,
-		       PROT_READ | PROT_WRITE | PROT_EXEC);
-	return ret;
-}
-
 int exec_cmd(int *monitored_pid)
 {
 	int child_pid, child_status;
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 6fbe1e995660..3f7ae76c209b 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -5,6 +5,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
+#include <sys/mman.h>
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
 #include "disasm.h"
@@ -516,3 +517,19 @@ bool is_jit_enabled(void)
 
 	return enabled;
 }
+
+int stack_mprotect(void)
+{
+	void *buf;
+	long sz;
+	int ret;
+
+	sz = sysconf(_SC_PAGESIZE);
+	if (sz < 0)
+		return sz;
+
+	buf = alloca(sz * 3);
+	ret = mprotect((void *)(((unsigned long)(buf + sz)) & ~(sz - 1)), sz,
+		       PROT_READ | PROT_WRITE | PROT_EXEC);
+	return ret;
+}
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index 2ca2356a0b58..2edc6fb7fc52 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -59,5 +59,6 @@ struct bpf_insn;
 int get_xlated_program(int fd_prog, struct bpf_insn **buf, __u32 *cnt);
 int testing_prog_flags(void);
 bool is_jit_enabled(void);
+int stack_mprotect(void);
 
 #endif /* __TESTING_HELPERS_H */

-- 
2.53.0

