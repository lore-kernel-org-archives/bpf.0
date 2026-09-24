Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20924AAC5F
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790274069; cv=none; b=gYoLTkd6RrVHu4VfBr6sHlAPWLXGOHP73LVli3ymwbEhD90/mgp8hauqy/JIgLVXgBcRZb2yTvPw6RV/iY7GWEZO+fGYV4arzGRei4cWVPNsaN4NCFVCBn97huvyeVeY17MbwpDQAwiOUSL1WAHeFH00zEkOQ4pgBTxwH2wPrxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790274069; c=relaxed/simple;
	bh=JnfT7VS81piH6sp71u+n8Tk+bZUWlQM5+MR54GoQGYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N8Te9d51Gt3pg9aWI7RQTjAZqmJJrDCEQDr6Gg6ElSWMTPjEbkzRYSSVOiztcPSg0+ITY7TYnoFnWVjBDUUNrl2BEk39q8M8Xsk4vVFJhvoNmlBjtdEJxi5LQ6q+q6Bd/lMtv8DtwSWdD0Bqu/B0vR2bUH8bc/A+S3JgliN5Lp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ss4zQU+D; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ss4zQU+D"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so121722a91.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790274067; x=1790878867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pu+cf2HW60Bu22Jh2AbwJqeaS4sqcr7R3fh3cTR6Qkk=;
        b=Ss4zQU+DbmFF/wCoGs0IHr580auFZ1/msN98ZHoV/OMTPY2waI2nt3u/hPztHA9bWI
         4Hhg2V3ehyUle2aRiyZk19AAHcOg3S3wkMEinMywx32xi5jg0Utj28GeUAgTZmwtIOjC
         fwWvxfLMMWXk01H3ySd/jMvM8GZU5h4pqlWaMpKCkhI4ehVbO6e/MT0zHH9KBAcR6Opm
         If9HaUmDgaBLqJehyqY9s8ChrrU07wEfgOI/K1X5X6eESJfaH+qrGofzhkN14bzKsilx
         o1Ky+AR2QZVZQrE+vY0LMOHJ6plnHe89UiNZlxHFY2JkFKuqxteOCCNAM0YWENvXI53J
         z4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790274067; x=1790878867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pu+cf2HW60Bu22Jh2AbwJqeaS4sqcr7R3fh3cTR6Qkk=;
        b=nPUNrO8QfgBWqRnlr6B0rcVzApTjD0LCgQuq72pxutff724q2lOR+OTJe8AllNsU5W
         fCD6g6kSyhET/OIix/Ide/gfUgUQqS1uKBioZ2OObyE2NuqdtpNRbBEbCbxMjqyvzc/w
         waw8dWXUCLDcvqfv9iY1C4eHvU0wpSomekofC/2MrfhcPcvOf7o4+lgjxBq0GgCUkqlp
         KqrA1J4oTGKfNJu3s92vquvVFASy/sU1Tb05d3ifkW1VD3WnrpbTQ6Lx7G5Vh5MqT8Zt
         jXIjb5xm1IfT1miKbyl5bdyCzAEKsLTeBIFtAKEeynw9vVbLqENp1WT5atqgZY/lA2Q4
         aBGg==
X-Gm-Message-State: AFuF++nCjZqJ360wNJseHrt9eRULIfcFuPt4h1jRUxgHTgdKCu7OyQ1p
	L+kzFbMIHZzGQuSdDASE/5ucS3LC825rSlS5d5HGhR0hgdDzhhq5a+P9L87u3A==
X-Gm-Gg: AYBFou1pgcAZP+qeK4oCoayu2vzjzDRfwb4FzYEllty6TsjpdbevM2Qg0p8WzuBULm/
	fpOS0BLBoCC9Cm2OLuI/3L35Rayl07wTqnSxnQGes8cl6/A0DT3Xc6GyCdxFKi54XMAQ/d+t7J+
	5qyakm2grLT9IJAmrWEUwj2xfPY1SR9L5D3NiZGy2i/Y5Px8dp4Lo2E7hQbZTzwWogw8dw+yqds
	HlrjmHVfiSBr4KypHmd6a9rPqGzIBj68jKIob2sZvN0We+yIQzjdVaDdH7l1fzjxP/2jbnzEXSR
	z5+jB0qDXQu4GfuhBFGu+XcP/MyGR4uMRiQB6M0JtuV34npx6NFgOJWf1+v+BqgeOqigmBqdEED
	bKisx+5XLzWwmJ629jk0fAApHyy0l9QE1JAhaFNm6mR+wgsHmQ2gTQPyuSf2m5YLLdJzxENq3No
	6xl+rxJW0HVS7JytksHAyDt3NrFo3oZvPTieB2PLL8wCwkYt7fFhyjHPZhPqf3rWvxYU2Tuy4D5
	X65yG8QB09mi9divVubFQIrU9BwlrVipDdkhPhil5+s3j3IXKJxHymZak9zdg1UsWG1SAS7+5M4
	ru7USdwvLyfiEF8ki2MF+UfY6sCXkGRurLjEhk4N6C5s
X-Received: by 2002:a17:90b:2649:b0:3a0:b223:683e with SMTP id 98e67ed59e1d1-3a0b2236bfbmr564658a91.48.1790274067055;
        Thu, 24 Sep 2026 11:21:07 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09773d402sm6468056a91.16.2026.09.24.11.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 11:21:06 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next] selftests/bpf: Fix build of callx tests with GCC
Date: Thu, 24 Sep 2026 18:21:04 +0000
Message-ID: <20260924182104.261823-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

GCC doesn't support indirect calls in BPF:

  progs/verifier_callx.c: In function 'apply_op':
  progs/verifier_callx.c:977:1: error: indirect call in function, which are not supported by eBPF
  progs/verifier_callx_rodata.c: In function 'use_shape':
  progs/verifier_callx_rodata.c:746:1: error: indirect call in function, which are not supported by eBPF

Build verifier_callx, verifier_callx_rodata and callx_rodata progs
with clang only. Skip callx_rodata_lskel test when progs are built
with GCC.

Fixes: e9b22d50796d ("selftests/bpf: Add tests for callx")
Fixes: b018e998e645 ("selftests/bpf: Add tests for callx through pointers in read-only data")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/prog_tests/callx_rodata_lskel.c       |  6 ++++
 .../selftests/bpf/progs/callx_rodata.c        | 28 +++++++++++++++++--
 .../selftests/bpf/progs/verifier_callx.c      |  3 +-
 .../bpf/progs/verifier_callx_rodata.c         |  3 +-
 4 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c b/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
index 96f6179f0492..6a43b880d730 100644
--- a/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
+++ b/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
@@ -35,6 +35,12 @@ void test_callx_rodata_lskel(void)
 	if (!ASSERT_OK_PTR(skel, "open"))
 		return;
 
+	/* gcc doesn't support indirect calls */
+	if (skel->rodata->skip) {
+		test__skip();
+		goto out;
+	}
+
 	skel->rodata->bias = 7;
 
 	if (!ASSERT_OK(callx_rodata_lskel__load(skel), "load"))
diff --git a/tools/testing/selftests/bpf/progs/callx_rodata.c b/tools/testing/selftests/bpf/progs/callx_rodata.c
index 07ae2d1b6b8e..e3f8335f80f8 100644
--- a/tools/testing/selftests/bpf/progs/callx_rodata.c
+++ b/tools/testing/selftests/bpf/progs/callx_rodata.c
@@ -1,16 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0
 /* callx through pointers to functions in .rodata, loaded by light skeleton */
 
+#include <stdbool.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
-typedef int (*op_fn)(int);
-
 /* set by user space before the programs are loaded, it's in .rodata too */
 const volatile int bias = 1;
 
 int op_idx;
 
+#ifdef __clang__
+
+const volatile bool skip = false;
+
+typedef int (*op_fn)(int);
+
 static __noinline int add_bias(int x)
 {
 	return x + bias;
@@ -41,6 +46,25 @@ int both_ops(void *ctx)
 	return ops[1](ops[0](4));
 }
 
+#else
+
+/* gcc doesn't support indirect calls */
+const volatile bool skip = true;
+
+SEC("socket")
+int select_op(void *ctx)
+{
+	return 0;
+}
+
+SEC("socket")
+int both_ops(void *ctx)
+{
+	return 0;
+}
+
+#endif
+
 /* no callx here */
 SEC("socket")
 int read_bias(void *ctx)
diff --git a/tools/testing/selftests/bpf/progs/verifier_callx.c b/tools/testing/selftests/bpf/progs/verifier_callx.c
index ea3d3f97da31..bc31d0221f6a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_callx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_callx.c
@@ -6,7 +6,8 @@
 #include "bpf_misc.h"
 #include "../../../include/linux/filter.h"
 
-#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
+/* gcc doesn't support indirect calls */
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && defined(__clang__)
 
 #define CALLX_INSN(DST, SRC, OFF, IMM) \
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL | BPF_X, DST, SRC, OFF, IMM)
diff --git a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
index 65d34769c8bf..db3169a1ddf6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
+++ b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
@@ -6,7 +6,8 @@
 #include "bpf_misc.h"
 #include "../../../include/linux/filter.h"
 
-#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
+/* gcc doesn't support indirect calls */
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && defined(__clang__)
 
 /*
  * Read-only data with pointers to functions, where the compiler puts tables
-- 
2.55.0

