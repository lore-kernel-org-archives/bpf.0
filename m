Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3D9477994
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564974; cv=none; b=YJ+I4Y6XFt5jwnUREBjupSKrSfRvn/lg7TqrpVQPejJKah6YOFnZ/1D/ayXkWI/xE5cuc7FgmTAhC1TI+PjkdXDMm22Hy9wkiXr8Cb6LR4CSIRfm2OHtOH15PWlr0n87tkAPSSz8CxV2v18SXgemYKLh3BSiOEfO+7L781/s+Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564974; c=relaxed/simple;
	bh=PEQ/hH8f9EfEO3m9jfnl1sYEE2Fvx6y97vzN398bHFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C8/5XkHk+MRQ2W4X0SOiN+DpA+Ha1urGJlUIi5Zo0h/RMlHkiiJdbAwI52pd92rt80efCEvuH3JTll9md2hwFt2m4DEc9/tslKxAmQkIl/9Q6g/lxt41ljahywJfPYfNaCX0gBrW/28POdCVHVfVz6ssjDZsgdqvg+CqKD9468w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IezJ7y7a; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IezJ7y7a"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a74ac8b40aso1285894e87.1
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 09:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777564970; x=1778169770; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=da/3P3gWrWPT2pVZ+wpt21mcmTeD9JLfhBM9QpqBcIo=;
        b=IezJ7y7aAcmU4GvKYjH0s2QiYI7+lHCXLu7T+7Z39CvCQkLXXLirbi7rN/U/tbEbjm
         SjKabVuCoGnUIGPTUnBi9aH6B2rrTNRqApEHWGqrNBKNN71eAxmZ350cV+ffA9k/IOKG
         lepP36+9jEJ5Hc0DrFjbJd+JVoc2hJwwfO4z/Jx5icG1O6mpRqw/9VaVbBvphbDOM+00
         PljDW7uLZqI++qfuzIBDbn/Ivu65bujs2axhy96PH839QdH2SO64VBGtvgM/z4Eo/S3l
         Llo79v/aGTK1jYxxOdpYFhwpKwLW+WC0Q7LHv+pt60CG0uakK+w4yMiS3WwjhCww0lvV
         qk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777564970; x=1778169770;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=da/3P3gWrWPT2pVZ+wpt21mcmTeD9JLfhBM9QpqBcIo=;
        b=OGPgAEo6dMPkzZqZsuNHWYA0ndoBBpZ17WnzLPtqvOAic7o0P4RGe/vq6XKGCTPXWg
         195sbW07dhRAgUTgLZLEi4bifPNla4csWkw3wVTFY+1t9IbLxOfrwmylrQZaGQHnrzrx
         ge1C4s6qCBvOAEr51AlIpRtMADKf1lSd8OBY9u+LiHGPCSe2tE0Z/AAK8CGI1VfjuaXO
         P27ZJ8Hcirl3i4B4XwySdpIdeGWl4+pQuKO50LgsMjv8t7znXBjqwOtWdzI82AP6l7IQ
         B1OZ8nlW/UtTxjETo8CTAaaoB2wq20Fnvzw6KvGK04YhxwcfE0TBdcmL2665ujo6lpY0
         sHeA==
X-Gm-Message-State: AOJu0YzhaIdF/dg1WJhLkJT3Uvr3LpN5s+UxlPsctqk8OfVYWJJpng58
	vrriBzfbgXwL6MvM9N4MNSDyqxZoeBMGIXpfLKU5GGz1ok3prCD+YiRId0B3WArF9io=
X-Gm-Gg: AeBDiesJ+Zlm8qbVU5gkmilFTUE+JKAMOPeZn0YIi/kheWEcKGuTogGSOjJA+K0lCR0
	M7n6NyT4iHBjzS7COglM5LgJSj6I+AUYKmvE/38lRYoc+gnc4yXoQ3GZt3AY11JFGI0s+mX5PoK
	sdLWJkc0Tpxh0DZzp5K0ttNstbyrPs7MFgJI9OH6F7QbdVzmMpC9f4Vre8D52eD06jUFfjEcJfb
	/jSrd/nakWma/xJcCKCpaowlNavWXlqWFXqlwEWk8QAX8zxe0lTQqC2Jt9SxLmo0nNRlUUthSpR
	jUVW4GL8oOc+ZL4+jY6Mt7549MmyBDfR/UXdcvzJQFRxlDzca4F67X6kvLO0arESPHR8LW+qgSB
	QD4G8gu+zLaBoMrh1JStGyyAh3vs+B2kxcUuHdYZhCqA9mhlD3l8XOT7NgEVTc8ghJIoZNAg0rQ
	QiK2mFZavlPZMQi8pcCdRgS3Ei
X-Received: by 2002:a05:6512:3c85:b0:5a4:a85:ba43 with SMTP id 2adb3069b0e04-5a8522d80ccmr1131964e87.33.1777564969409;
        Thu, 30 Apr 2026 09:02:49 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b783a95sm351904eec.22.2026.04.30.09.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 09:02:48 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 30 Apr 2026 13:02:11 -0300
Subject: [PATCH bpf-next v11 10/11] selftests/bpf: Provide weak definitions
 for cross-test functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-selftests-bpf_misconfig-v11-10-e11f7a8c4fdc@suse.com>
References: <20260430-selftests-bpf_misconfig-v11-0-e11f7a8c4fdc@suse.com>
In-Reply-To: <20260430-selftests-bpf_misconfig-v11-0-e11f7a8c4fdc@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1777564926; l=5710;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=PEQ/hH8f9EfEO3m9jfnl1sYEE2Fvx6y97vzN398bHFI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QARd9MqO5u0wPoP+w/Wba+9N2KtAGMi1fCK+PM8eJuubbNpb8RtUIs+C+HRfnluzsj3dbuwbtnY
 D0RxNqGIy2AU=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Some test files reference functions defined in other translation units that
may not be compiled when skeletons are missing. Replace forward
declarations of uprobe_multi_func_{1,2,3}() with weak no-op stubs so the
linker resolves them regardless of which objects are present.

The stub bodies are `asm volatile ("")` rather than empty, matching the
shape of the strong definitions in prog_tests/uprobe_multi_test.c. This
keeps the weak and strong sides on the same footing for the optimiser
(noinline + asm-barrier), which is the form upstream already relies on
for these functions.

Move stack_mprotect() from test_lsm.c into testing_helpers.c so it is
always available. The previous weak-stub approach returned 0, which would
cause callers expecting -1/EPERM to fail their assertions
deterministically. Having the real implementation in a shared utility
avoids this problem entirely.

Include <alloca.h> for alloca() so the build does not rely on glibc's
implicit declaration via <stdlib.h>.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 .../testing/selftests/bpf/prog_tests/bpf_cookie.c  | 17 +++++++++++------
 tools/testing/selftests/bpf/prog_tests/iters.c     |  2 --
 tools/testing/selftests/bpf/prog_tests/test_lsm.c  | 22 ----------------------
 tools/testing/selftests/bpf/testing_helpers.c      | 18 ++++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h      |  1 +
 5 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 35adc3f6d443..fa484d00a7a5 100644
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
+noinline __weak void uprobe_multi_func_1(void) { asm volatile (""); }
+noinline __weak void uprobe_multi_func_2(void) { asm volatile (""); }
+noinline __weak void uprobe_multi_func_3(void) { asm volatile (""); }
 
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
index 6fbe1e995660..c970e7793dfc 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -5,6 +5,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
+#include <sys/mman.h>
+#include <alloca.h>
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
 #include "disasm.h"
@@ -516,3 +518,19 @@ bool is_jit_enabled(void)
 
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

