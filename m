Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551D23A381A
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 23:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777419963; cv=none; b=fV0Mv/fs8yDrEQzA9FM9Q6Nx+ss4qpksq8JO9rWjvAfrbVtXDfyRuDlLNv+bdSYlWHRe1y2mUIgckmEqUqabGfSykVFLGRyCGDCTb4sR7JHaNlyj4d9vYqpG0Fd6MW5oFU5iOisORNt+1IE+cuMq/P5e3IeJEoFTbUCg143nWko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777419963; c=relaxed/simple;
	bh=P1kmeBBxz6oLlrcr3TGMtgJ39fvP2CkFwTpn0Vo40DI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M5dMzcMkFB8Yv+lYYUo8UaV/4t5DTCugbp9p836tKsg1S+/3Vszo3ICwbg0vCsyb2MXZ4zBR0qviPEYYcmZGiEf290BgtfMu3srq6ZpDFhswv1NJCDpyhoHaH6tuJdIIA8glL3AonCTgG/F81BubU9Zk8k7ZnMS/OqkAhpxsqoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XQ23Q8KS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XQ23Q8KS"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso99201165e9.3
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 16:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777419960; x=1778024760; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzn0A233UxptBOFA9FIvgdlvl14jtwnlOOk9eQvvLMU=;
        b=XQ23Q8KSFoJQ+1bA3eBe4+bJiW5hmuSdTa0O2tlKlGT6HkVu/TYCfoTC0vhahGAntj
         9v/+JWP05sJlxETIKvzMi6iLpv4aQszGRfYoroZrQMAyDbqkofwRE6tEF/++alDtDbg0
         b51IkGzhsyUn9pCez3Cr6+kfxgTRE0Uyj4UkEqX8CIZD80skwt6fjGKeFCWXLarA80hC
         sWTAAmCyfDJ72ACZeAxIEW8Obf6LYsIAheBBFczUTV4LLqD/xXdiBolRAGRXN/4gzSJF
         pwgQIx6iDgaD1g4AgLuDUG5KKCmVvyCSUMg9xtUc2sf4gJaPhbx8jirAWnRaZjZMLlHf
         vSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777419960; x=1778024760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gzn0A233UxptBOFA9FIvgdlvl14jtwnlOOk9eQvvLMU=;
        b=OKuCRWEigz/bmCEu1GYW7yAnZPwqdzBR7HxE8fh7C7lLlwp9ZMm9OJsvRUM11vCaf7
         gK6+aQiwwprjR8k1dniT657hD8WtS/tBeJM3H9IO3kz1AVMEqJS+bJ8iP4v7f9xZ58O1
         6BLfmGIGDZ5TsBTpFvHnPO65o53B53073uszLKNii3zRzWCfDLWlcQOMz7FDrdkARzFY
         1KMgs5FiwD6Ek1iK9siU31BREz0lu2u5OofPGLmYW3h8HYfxXqvizvx0ULNpYlICqW21
         S8rYp6UGIwnb3Q+Rqy9Vr4O3Rp8RMvKNRXl2dvI0WV/D3yofpnovwWZ+4xc7a3grvsh7
         e63A==
X-Gm-Message-State: AOJu0YwppBdC9WPLuC+3jim7dK6OsarvnSYd2oElRi5KMq+gSSDE9ayq
	RN1qqIbFTkzDuQYdu7N+pFl9FEa7CmF7BDBwFgMO5n6NnBW+CVC/+SttCYsz+YEu0kI=
X-Gm-Gg: AeBDietOSnlC1IZF/3BHEyI1/R4reYeltq8LFLkbOtEYtiPvpiyIBo3pmPim/4JvLhT
	0xyxhZsl1wFfFQsAN19JbQILQWEqEJycxBF1fF4PMkzI79MTDEiVfPGVPrUFJPL4tv/O/cWqREv
	NumYdyMM3jzwahoTpStRNaeQ1OQILTO8rNIya5KMwWJzfn/nzNq+QhYtEOaNd6hgCxYx9dyGM1Z
	y2XFXs8xD58JM3gd2orCgVIq75B5FXEf2yh3ic/TM476DhbFgj1y6RfYWiynvqgDfb061JJRLsP
	2fbhikFYexLfcEJPbSuvqzMDxEUmN2MV0DMLyyWYQhxNNO9uGrrObjhrFz1KldqtP7/EeEDVHXS
	00kgvThYlgNuooyc5lO8IvxE1YlgmErLhpgpiHB9wGnLQHIJgMnyklQBXEqNkofVnZfjpq2W5+1
	we6nHk6rLI+9L1NvO+fV2bY7B5d4H6u1MmWvA=
X-Received: by 2002:a05:600c:8283:b0:489:1f08:91b with SMTP id 5b1f17b1804b1-48a77b1da8emr81247695e9.16.1777419959818;
        Tue, 28 Apr 2026 16:45:59 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-573b6d8b84bsm201147e0c.10.2026.04.28.16.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 16:45:58 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Tue, 28 Apr 2026 20:45:11 -0300
Subject: [PATCH bpf-next v8 10/11] selftests/bpf: Provide weak definitions
 for cross-test functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260428-selftests-bpf_misconfig-v8-10-bf02cf97dbcb@suse.com>
References: <20260428-selftests-bpf_misconfig-v8-0-bf02cf97dbcb@suse.com>
In-Reply-To: <20260428-selftests-bpf_misconfig-v8-0-bf02cf97dbcb@suse.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1777419912; l=5203;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=P1kmeBBxz6oLlrcr3TGMtgJ39fvP2CkFwTpn0Vo40DI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPnDxtNvxjb2j89XeyFx0apJDJ7Fuz13GuAXwoOT6AnvK4+56rJtqmtm1L2f201q7hVCtYFCdaD
 TiwQBjxdleAE=
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
 tools/testing/selftests/bpf/prog_tests/iters.c     |  2 --
 tools/testing/selftests/bpf/prog_tests/test_lsm.c  | 22 ----------------------
 tools/testing/selftests/bpf/testing_helpers.c      | 17 +++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h      |  1 +
 5 files changed, 29 insertions(+), 30 deletions(-)

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
index a539980a2fbe..c0b6082f345a 100644
--- a/tools/testing/selftests/bpf/prog_tests/iters.c
+++ b/tools/testing/selftests/bpf/prog_tests/iters.c
@@ -202,8 +202,6 @@ static void subtest_task_iters(void)
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
2.54.0

