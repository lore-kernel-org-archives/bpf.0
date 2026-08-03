Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ACB489898
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 12:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761486; cv=none; b=WUunRgRXw0BfLRyjo5yvsR9hMa1Cin0VuZBUj+QtTJx04xcaqnfbig8wUllJGHFCHZDoZ1ga9eD/1X0Gy1vOxB0FItjqOegnpnvGq2EalcxZoDOG6dGfcjJdlfPbN6Um4APUmj3CHw8OEblDkwcNOzXauhil79cLYvVuvMsiZX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761486; c=relaxed/simple;
	bh=lDDj938vjODLg8NlRS3Lzjknn+FfTuav6uZDkZrYVuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAsLrlYlOE7PVRicWBvcJItV/V4VQgoi1iOdGw89LfINaDNcBCmUXTlpiEyskplQsXKpKp+e2r7TF1RCX8QkqIeqfZQ69YMx+rhXiunikWCYu31h3EEfqKXsp7lLFfLUOR2S5jj06uuUKSgOH5w0ySB3Dh7Vc+hPoaubAZj+wvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azTR9B7C; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azTR9B7C"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-470713a9053so968827f8f.0
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 05:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785761483; x=1786366283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jbqOP3+QFpsnQXK31UnGLry20dmETJAoWcqdS/af96Q=;
        b=azTR9B7C+Riqh4uW/y0PmmbtuVACF17gH/5P/+ebWX68U7+lZ23ZE1NvCzg2Kl+sOR
         Hf6gw9M9BaS3Vns9HsLW8es6uQk57h9BqMdjOimGmWDw3CgNx/6Dcz37cEcjlMCEL79f
         LGWwSVckmCA/osBP2nGR26isPT5LMySseP4bdNr1BmNdwcZhdiMb/4W443+7qmvjS/Wz
         SOpLHeRQKe/7yRLkGZaifOyBH4Taqs0dGG94SVrUYeF7eGWOupxrgGM6CGvMjLT6a9yG
         KA4Dh9ri4Wn8oGdSu8kImAMNCgX2xkbWEOacRkxQz5gqG9w1s0dcbdy9vowUkh0S497V
         pXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785761483; x=1786366283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jbqOP3+QFpsnQXK31UnGLry20dmETJAoWcqdS/af96Q=;
        b=iYidQDwCZaw1x99jNbW4gpacC46+Rjk/9RJgzC+cS/NwkbkTjWCqhPW5h+gqRoiFWu
         omzA7c11+icM2fAQQaL8hXy8ZqW++jaVsZ3RZd9hM1Q+2Sih8hY5Ki9nDIvf1JdPAuUo
         VXwuQ3sNl1ZRbM7eDZCInXjgoSBacGHFO8RamYfXZYjrPboHi5vkxqPyVfPl1yARBojy
         PmvYzq1rmZvnCZiMti/BsC7RDwCL6C6FWlOH83tCBbwKPsIAOeunrOCVYC7hKC6tfe3i
         M6bj5cfp9Sd/NvvxsOAQdU4hBFf5fkuHqtqGUVO7Cv5nuD4Kzu/iguLWjxNTmz6d//u+
         U39Q==
X-Gm-Message-State: AOJu0Yw5kUdW3VPSTa0JtSiSy3TUXyG3PRDGJfIsw2SJFRsB1OHobr6v
	1pZhMzHs9xC0+8/mDbKhagufCkQISGNexqpG3NKH5DXUNsCSSp4tThwP7rrgX7n/
X-Gm-Gg: AR+sD13pxTbYPNtmK8d/abNmRTv8rI+HId10q2Ftm7PSaIFYr+JUr6LwFDlNKLYv7T3
	VMgMeOLwFje4X88F3jGmuvsOeSiNDWxuPo9VSyXsHz5dTsnX6h70mz0ZsWKFajuMBut5Y0bCkQc
	GJJOYzIQxcmR88MYUqIEDv/hvsnLsyVvNL18PL+4OmfzMZGYQyCVnt9jTWtGWEdxRlkynGdJVh9
	ViEEiY6zKdSoild82g8dj9TOFKzQSbZQcI+XVhl2HqLjl0CXHoW7dkarrqzzunRsobCUkXDaACH
	LImF3i5MGVAevmhn3cRU6omfuQEQFSrvtwbDo4v7IlK1k4CTFFRUsUEVyAw1YGc6PrfmyFWw65b
	bP1GANcDOjkkOD1iHvhcPFMfngH8kzNxH1AfXXA0Hw9SIoZeTgvlECz6bdoZDEssPOMv3oae/al
	HsutWHzwb8QGJOLTpUOoi3l1gUjOoR7vyfzJkpWnCBkdkTINBrLywxI/ThFCJubfTU457DqZnOJ
	MJZ3nJxnhqXERfpkGdtYftYl/wVWwGC9g0h8xTXXzI1agnGLu1mEPz6Yu7nrmSjdrHrkNmQJVwS
	G9h7uSioDxHioODola3B5bQQdZk=
X-Received: by 2002:a05:6000:178d:b0:47f:86af:8fdd with SMTP id ffacd0b85a97d-47fd72c74bbmr25129423f8f.3.1785761483437;
        Mon, 03 Aug 2026 05:51:23 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd42d91bfsm34680735f8f.15.2026.08.03.05.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 05:51:22 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 6/9] selftests/bpf: Add JIT-sequence tests for __arena kfunc arguments
Date: Mon,  3 Aug 2026 14:51:07 +0200
Message-ID: <20260803125115.2264733-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803125115.2264733-1-memxor@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4268; i=memxor@gmail.com; h=from:subject; bh=gIYlPDPUmdEfLvCWjLxkqMK7+A62h8qvyD078jaiMmQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIaugb3OnnoTemoaDTTMl9QR8fDeXiy1Xfjixb1+n+ovjI nemFxZ0lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCJa1xgZzsycLfg7bu4UpRde d872PlxYs42juavu4CyGl/sVJrCGKjD8r/1mfjF9ftSVPTk2uXU/Dmqn5m2ueh1fPu/TjQxL33O p7AA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

Pin the exact rebase sequences the JITs emit for __arena and
__arena_nullable kfunc arguments with __jited assertions on x86-64: the
unconditional truncate-and-add, the nullable test-and-skip variant, and
all five argument registers in one call, which also covers the
REX-prefixed encoding of r8 on x86. The capture kfuncs take the argument
without dereferencing, so only the emitted code is under test.  The
tests skip without LLVM disassembler support.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/arena_kfunc_jit.c          | 13 +++
 .../selftests/bpf/progs/arena_kfunc_jit.c     | 96 +++++++++++++++++++
 2 files changed, 109 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_kfunc_jit.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_kfunc_jit.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_kfunc_jit.c b/tools/testing/selftests/bpf/prog_tests/arena_kfunc_jit.c
new file mode 100644
index 000000000000..2359cde24c45
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_kfunc_jit.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include "arena_kfunc_jit.skel.h"
+
+/*
+ * Runs with full capabilities: resolving module kfunc ksyms requires
+ * CAP_SYS_ADMIN, which rules out the capability-restricted runner.
+ */
+void test_arena_kfunc_jit(void)
+{
+	RUN_TESTS(arena_kfunc_jit);
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c b/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
new file mode 100644
index 000000000000..84747611725f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+/*
+ * Verify the JIT-emitted rebase sequences for __arena and __arena_nullable
+ * kfunc arguments. The capture kfuncs take the argument without
+ * dereferencing it, so these tests pin only the emitted code.
+ */
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+#include <bpf_arena_common.h>
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1);
+} arena SEC(".maps");
+
+/* volatile to force the scalar reloads below */
+volatile u64 stash;
+
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+
+SEC("syscall")
+__arch_x86_64
+__jited("...")
+__jited("	movl	%edi, %edi")
+__jited("	addq	%r12, %rdi")
+__jited("...")
+__jited("	callq	{{.*}}")
+__success
+int arena_arg_jit_rebase(void *ctx)
+{
+	stash = (u64)bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	bpf_kfunc_arena_cap_test((u64 *)stash);
+	return 0;
+}
+
+SEC("syscall")
+__arch_x86_64
+__jited("...")
+__jited("	movl	%edi, %edi")
+__jited("	testl	%edi, %edi")
+__jited("	je	{{.*}}")
+__jited("	addq	%r12, %rdi")
+__success
+int arena_arg_jit_nullable(void *ctx)
+{
+	stash = (u64)bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	bpf_kfunc_arena_cap_nullable_test((u64 *)stash);
+	return 0;
+}
+
+SEC("syscall")
+__arch_x86_64
+__jited("...")
+__jited("	movl	%edi, %edi")
+__jited("	addq	%r12, %rdi")
+__jited("	movl	%esi, %esi")
+__jited("	addq	%r12, %rsi")
+__jited("	movl	%edx, %edx")
+__jited("	addq	%r12, %rdx")
+__jited("	movl	%ecx, %ecx")
+__jited("	addq	%r12, %rcx")
+__jited("	movl	%r8d, %r8d")
+__jited("	testl	%r8d, %r8d")
+__jited("	je	{{.*}}")
+__jited("	addq	%r12, %r8")
+__success
+int arena_arg_jit_args5(void *ctx)
+{
+	u64 __arena *val;
+
+	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!val)
+		return 1;
+
+	val[0] = 1;
+	val[1] = 2;
+	val[2] = 4;
+	val[3] = 8;
+	val[4] = 16;
+
+	bpf_kfunc_arena_args5_test((u64 *)&val[0], (u64 *)&val[1],
+				   (u64 *)&val[2], (u64 *)&val[3],
+				   (u64 *)&val[4]);
+	return 0;
+}
+
+#endif /* __BPF_FEATURE_ADDR_SPACE_CAST */
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0

