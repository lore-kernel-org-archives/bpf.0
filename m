Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124B53BADB8
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776342134; cv=none; b=dBVO5KuGbOzYkX1iEpJggeKxvUGdJrfwcK6c4CC2SBPg3iCPqx75IE2ha7o3VEwzIC16OJqYjeBoX4ddkc8btebp+gJ21NfVxNalnk/Y9ZrEqNWLdkxPNH5TSyptv6JF3DcE+0j8EeUvxJngtPPDxIhRDxFbZoUXMeHs6g1VEbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776342134; c=relaxed/simple;
	bh=ku5U3Ka0ndjPXP92siQHnGkpd1bCq2hgtWQ4GejuUdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RFSf+/GK9gFBR6DHpI25CqOMXMgM2Co5UJAJUV/1TeuildlazuhNJBK5gATHtjCtkeUy9pFLNhzYJhuBLFIIvhpeACo4+JdEF0DQZHxXnhvFsnFcfO9gMQIRNsVYsAFqwY7oQofiWWyUg2XBXIDiXj5XfZXyzGouHEYr9TiDwIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JcAWIne0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JcAWIne0"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488afb0427eso93582375e9.1
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 05:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776342131; x=1776946931; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oynt2x6SXKNaRU8MrrgQe7iSYgm0Zd6fxbgaEr/IL1k=;
        b=JcAWIne0kU6feEsIZ0b7rhmXVoHGtaxG6QuZyqp3RxBVBhcqz18S2ZbJpT6j++nhBO
         aQq7xEG/kGAS5MIeqRzF9e7gb71bUaWTYAscF8WhwDpNCJ4NQRQjXb8jgfcPzHW0jbJz
         8vDS41qQO5gMiBdISccatwIwF550rx1zPSvgmFNZyl92HRKhH0UjAn/ndZ2pumIHNrBc
         4+VKJcUlqmb1XLLAzCsYb+RdgXik/vptTL3uWvL0RxU6w7NCI90qFn8O0ESc+Eq5TEhg
         1hoKv1OmuRogEjXg5rwYABTVL7PatCqN3oZDYCvbPRqI+kieuLP+4cD3UqaoZAOcPmpn
         z0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776342131; x=1776946931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Oynt2x6SXKNaRU8MrrgQe7iSYgm0Zd6fxbgaEr/IL1k=;
        b=XVIY0lDwkO8AQqKquorj3VOIN7cJFlVykaXBqGoLDShRQstpn9lXu95e6Q1ta4tVuo
         vQBZy3Yvz1y3H9qT7k89ixCYAb3p3vCgQ8lYqZm6MoLATxT8jI8xfrzhs9ClputZY5yg
         nZ+9EuipyclrhtRnCUl53JT+loYHMAwAwJ26NSL4nTpW+1CyVv2WJh644+H7OkjhJXBN
         wVH0K5BV41XGKGctduCLCybopXfv4BtgmrFntkQnoO8LtqgV45Gb/yAao27X1VCSgI9r
         L9cCbDjt0lLkTlYsvBCJshkFcTXThtejwj7RWS5+yJLJneI0hpLjyCRZvXexLFvSmvlb
         6JLw==
X-Gm-Message-State: AOJu0YwWcuA8xzG/LVsTA/OXPg6AYCbSRAoJZBpdyb7l4bt+kFbPxmgo
	/MjSMSKOFZvf+LHcJVA8bN25FV1Cg7Uin0DUz/ti6IueByZ7mIetUCchr6MhkZ0VLiw=
X-Gm-Gg: AeBDietslubxA9LVLMvca6h26xhSQWpswq36pBHkP8Nyh+Oza2bhtT85S2pY89Q/ZHM
	xNUiTtZz4gxMumd28I9oMJDzb0xbgA4fCwVPdQ23U946lgOSglAbDFHryAGEy8dMqU+YWUHYp1+
	D3nQ+WmEstcHq7GYa2kE1STEdNRdJGoqxK9MFJJseOkZ5O6oodVuLk/fCGhwo1TTYiNXYBQlk0U
	JDVepTzn1/w5c/YYSqWAXBVG12gF7yq+DZUxUh8uI5KoYxkanI8PtFfSWedlC2CQFxsfGKYFnNF
	+h93tKXt6C5cJqsMGGXW2hbysLat7PSu8LosWnZ6qiLdhByesxBM9Tn6PeinMPEBFTImWFc23PG
	gxXk8CGIBvo/b9cnI8sqHUtVf3PtpaPQKOtpOkUQIAMIRsWEp8P2mAE8wE2+shJe6m3IIpYT/bk
	RU8Y+BN37JAjY=
X-Received: by 2002:a05:600d:1:b0:488:a2ac:a334 with SMTP id 5b1f17b1804b1-488d67c720emr320597815e9.3.1776342131415;
        Thu, 16 Apr 2026 05:22:11 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:e41:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c606db2sm6897614eec.11.2026.04.16.05.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 05:22:10 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 16 Apr 2026 09:21:27 -0300
Subject: [PATCH bpf-next v6 10/11] selftests/bpf: Provide weak definitions
 for cross-test functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260416-selftests-bpf_misconfig-v6-10-7efeab504af1@suse.com>
References: <20260416-selftests-bpf_misconfig-v6-0-7efeab504af1@suse.com>
In-Reply-To: <20260416-selftests-bpf_misconfig-v6-0-7efeab504af1@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1776342088; l=5376;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=ku5U3Ka0ndjPXP92siQHnGkpd1bCq2hgtWQ4GejuUdw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QADQi3LbxVO70sLafTtzZ1OnYs3sI4Q1YFUFVnjYDmm2m3UqMyE9AKo9DgDBEEFgFn2aMcsIuHC
 qKzGtpkOGWAc=
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

