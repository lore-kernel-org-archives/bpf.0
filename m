Received: from mail-oi2-f2.google.com (mail-oi2-f2.google.com [74.125.231.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76214223DE7
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 00:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149606; cv=none; b=t1kl8eNVwjgVE0Y4ulHuTBZeVbnb09xXBgBHrRbGv50sfEk14Nl9m0pjgKN3p1fEcfcA+0Blajmp8zNpTjY43MVl3beYgBhhOuSMGFhQfhbP5SKuLyIH7EfisvKuE+w57I4p/liGywxhMnpq1rNgylzeoUzkFRAZkfTcl6X1rr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149606; c=relaxed/simple;
	bh=1z7bjFaLLlOOhgNyaUREATOg5q3vPC2W0vsoOaneZ40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBz41ZU65mSURckqD5WPjzXIOA4UqiAsjtRXqQ56mYBb4UvnLyLOK5Xc1ij/7CA1hV0nsZl8ruDWcZEEFF0kOcEQp/XC4AVM2AoaGeOAUealc41zvL/p2uDjCRmpWhys1dj4OdgzgO5ytDTfrUGqf6RuzIUuS0tcNIlTpSLTFgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWFaogxH; arc=none smtp.client-ip=74.125.231.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWFaogxH"
Received: by mail-oi2-f2.google.com with SMTP id 5614622812f47-495e058ca73so33493b6e.0
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 17:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786149604; x=1786754404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2XfZAZZKxcTD1OMmu03DuK+nvG9BPrjo2whhfLKO/sU=;
        b=HWFaogxHOmLrP3ctfZJpEjycHh9DiIgYuVBr3fDVDepLVFuC6FohM5cQBycDVp1jEc
         H2h+7ulEQP9kHkZrBFvxwP6GdGKTwJAiClgoS/43AGauCUG6pDe3QszFjTYKtR6XxILR
         TQN7ECe25GBc6EgwZrzACCikxDOI/r49JFsDl7Dtld/uHO15+3jD/dgp9Sa2TunTv/9/
         13lQH2OpP9HV3WzaF+7CtvLVjCzXa+/ub8ErP2Nn1l3UKVuHzq2jijKiPidnp0edA0eP
         m27s6pJYdz+FdR1SC9XsR5IyARxnCiLezCYcUmfhFhmZWGia1rhRbNcSWCQVz/mSN91N
         FSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786149604; x=1786754404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2XfZAZZKxcTD1OMmu03DuK+nvG9BPrjo2whhfLKO/sU=;
        b=MI4oZusgzI9y6nCDgTaIMye6sUrxADU5msncmEFYpioZ5/lpHh3+QslySGQGcDB+YL
         WSjMTGkWO25PxkTIf2vigDh/sLbABRcAVpQXsRYW6CNlsWQ5f6w+ulHBccudIxEGizBR
         8QlN2KjObXsiA7d7Ff7LTeD5ERXXKSyaxJL+qDAW3wx7lwJpftbMyab9aHXOGf0QgE+K
         eL46dB8FmMuz9Zej7aYmEi91OLIqW/RSVKaBPV5WgBn/iFOgqbBzP6GsxvvsznGasegg
         nYV7MTwS8TXpoq9YJRLLZ8+vD0f9nUBL4aO0srEP8aIuOBCP18SvigF2wFJrw/v5K+Bm
         QJnA==
X-Gm-Message-State: AOJu0YytiC4ThTU4ZIH8utjQQRktQFYH9GDkcBcNRnACZloTjA0M9Fsv
	m1c4jkubLoxJuB00GinrRglGORNp/BoU3jZ4JljA840dyFL20le5Svxkv8qLm+3qAXY=
X-Gm-Gg: AR+sD11OPkbDl+igQg0WS3GNjq+MJ+hXnJL091CQQUlDL/lXZP3e0mOsxAjbyb2Ah5w
	kLzSvXRCWoWRGYwTgQQZ6+M0EybV54rhAoABtqzQhnubas7d0KBDcZ4jVbudUSO2sWVEyNMke01
	ZvWU1iTFp4ThcuZ6SBy6Xf+h1O23+mxZ1XAeCxj30Y4RX8oSFC9gAPE05FhhU9z2HjiNaMhOGsZ
	rOredMw/V0NajPyYn37ktCuhefsXrD8rDm1j4V68iF4ZKncMIg6yYfCqjGLfJMeOm3acbtbdFZ3
	PIhzLIRdWnw9bv/4hHvu7i0k7xiuU+UVcDqIKNlusnQMEYw1tW6aOlbY91hvI3j4S2I+PfsRL7d
	ko7eQY+2dFQlsDq8bn8gnLoHO9eRB5YXs422CQzsT/YuySxXr6o8yUoRFrCpTCx7vNJ+zKZQkg/
	1e/mAC42KXQZQWXSXI7PuW0lRn8b+P8DbGVmvMvzEVLfbmSsr6d+cc2Kt3zlK1aZMsgHeCYZAmj
	OrIaPcqnlAAJwOhgrf2x1pKfvuwo/D4dB+0GUq0gdHyy/QhTLXWZtJOQ3tAI9u54GkV86I=
X-Received: by 2002:a05:6808:c3f3:b0:4a4:c12:46f6 with SMTP id 5614622812f47-4b1ab72c821mr2397411b6e.2.1786149604194;
        Fri, 07 Aug 2026 17:40:04 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:49::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b1af6856f9sm835336b6e.18.2026.08.07.17.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:40:03 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 09/14] selftests/bpf: Add JIT-sequence tests for __arena kfunc arguments
Date: Sat,  8 Aug 2026 02:39:29 +0200
Message-ID: <20260808003938.3486067-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808003938.3486067-1-memxor@gmail.com>
References: <20260808003938.3486067-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4550; i=memxor@gmail.com; h=from:subject; bh=Yumye9NUGzkl499FUAHqzIrvv3HcesA/fdF71KxGiEg=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIausqrKsfkZ6Vs4OFqVTbPXXz6xiKWfsTT2jIMPvcbbrlO5F b+6OUhYGMS4GWTFFlpL/+5iMT1T+DrRdxg0zh5UJZAgDF6cATMR+IiPDUXP3vvbI89ESHC8W/5nJoL bh3u+u1BtujU2lf3Lbg2d9ZGT4IxTCVMrXznnt+BazHUn+R15l3bEUeshYfrv2S9rticd4AQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

Pin the exact rebase sequences the JITs emit for __arena and
__arena__nullable kfunc arguments with __jited assertions on x86-64: the
unconditional truncate-and-add, the nullable test-and-skip variant, and
all five argument registers in one call, which also covers the
REX-prefixed encoding of r8 on x86. The capture kfuncs take the argument
without dereferencing, so only the emitted code is under test. The
tests skip without LLVM disassembler support.

Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  3 +
 .../selftests/bpf/progs/arena_kfunc_jit.c     | 98 +++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/arena_kfunc_jit.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 380a624dd63f..e7fb3eec7801 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -3,6 +3,7 @@
 #include <test_progs.h>
 
 #include "arena_kfunc.skel.h"
+#include "arena_kfunc_jit.skel.h"
 #include "cap_helpers.h"
 #include "verifier_align.skel.h"
 #include "verifier_and.skel.h"
@@ -164,6 +165,8 @@ static void run_tests_aux(const char *skel_name,
 
 void test_arena_kfunc(void)                   { RUN_TESTS(arena_kfunc); }
 
+void test_arena_kfunc_jit(void)               { RUN_TESTS(arena_kfunc_jit); }
+
 void test_verifier_align(void)                { RUN(verifier_align); }
 void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_arena(void)                { RUN(verifier_arena); }
diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c b/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
new file mode 100644
index 000000000000..c9b918662616
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+/*
+ * Verify the JIT-emitted rebase sequences for __arena and __arena__nullable
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
+__jited("	je	L0")
+__jited("	addq	%r12, %rdi")
+__jited("L0:	callq	{{.*}}")
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
+__jited("	je	L0")
+__jited("	addq	%r12, %r8")
+__jited("L0:	callq	{{.*}}")
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
2.53.0-Meta

