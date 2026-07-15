Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555E931E84E
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 22:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784152863; cv=none; b=ULOYmgyfuLnkAXSU7YwUqTovxL1h2sO9hFLHApn7M6nsBsQcUP/m9UrbtBzrHzilJZY3LyxYxCOASaAPSe0OP7Aant+GQUmDOksXKD7yFAin6Qtl6pHP/XDcs9nkAIMKb5gFT9uA+44Twb6R5DDJ2BHBjov6sAlGSSpkBoc8UHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784152863; c=relaxed/simple;
	bh=lDDj938vjODLg8NlRS3Lzjknn+FfTuav6uZDkZrYVuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTvYOEP7f2cI98Rd8YIFKMr7T8biwxp43iRnwQ8ARVMuuigbEvywBzElwS/Jb2rATyAAm+fuydkLcbzTZTu0K6D8OGoctej6ZfUz0uVAcEEMnw0026t98FOxoAPLIQ1dsZtpT3AoAllZP+AIOY8wrtj1sGqU0+Zl3MZ9zwT15Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s747JCyS; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s747JCyS"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-46e747fbf36so2848979f8f.0
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 15:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784152860; x=1784757660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jbqOP3+QFpsnQXK31UnGLry20dmETJAoWcqdS/af96Q=;
        b=s747JCySFz+1ZguV8Snz5nQj3aEUHilhnvyx54DhpkhXpaNT2yaX18AqgBT5z7yTC2
         Ri7GtbLqPax8K+Tsjm76C/7tn37eCyKk116j7quES8bc2hOXTpUSg19bGazjRiE1Yzvx
         KIt65kOCVTPG2FXxvSJNr5drQfB3683zXp/g/+JFBv7vwZL/PlSwde36V+lt8gIZ9Onl
         RYG2Wp7+jgpcen64L2eeWyTFJ8Fot3Rg6XJMVqfra9X/2Ce1t/zL4NJnkJUiWGx0k+ZU
         i1UUVIuZcfjm6Dw91UvEmihoJHQyHNb/N/OFBmVqkzYZ8pqI9amwFAsaHQ4kve2yWtOb
         ++Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784152860; x=1784757660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jbqOP3+QFpsnQXK31UnGLry20dmETJAoWcqdS/af96Q=;
        b=A+8CabgthJKsVnbheP9/uRfpanuuwx0FG+pt9bN1FykG3zWdCm+0ApRBqzUhO7I6Zn
         HAk80f6VVqfW+Uqen5agkD2ZXB5H4Y9iAlfbIQX84JqzkSX456Iw/6NkBih9Xmo5ZjlH
         44EzR7BZMHGiZXnsmfEs8hLwqFywkHyvjwnm33c6RnL60OiKBkAy27UiDkySJFAWIp8m
         ZX4MyncrPM0HBoA1fcC9aRK9QwrLTYEyEh1xp9901qFIASMENQg5oc2QMz8HURhgT4nW
         haZJvKKUZ7bRkxnDvlpQNKMHX6MQevHWieSnjeVbp3EQm3ojCENlWZRGrpNKXXWBZUhn
         CLvA==
X-Gm-Message-State: AOJu0Yy+dCR8+I7Xuqexiu9cUIqZM6Qe59uq8MeqVarDzLw4K6RoFlJ6
	OzAJhrEQCQEIaXbXr/Sh9weow+es+IVhVw7KgOtLIREZSmQY790zFqv9RGjo6i88
X-Gm-Gg: AfdE7clpaI/HFiHJu4oEUL5PHV0FFwS6dMg5QYbuwXYO+ZfajX9XUXu02v8TgwYZs3n
	is/Tyfg4KIn2EMM6/I4iUT5aXWxCwnUUu/tAlAlkWetyWa0oRQQEMcGavQWKaAMqeTOHhOnG/jR
	7JPeKNkuvpslJFtyotEaG0O/ggGMikjRD08l5In5tdh5w55ORZ8ZlBOB7efdr3VRteRygNAxmlq
	TdLzB5g45dOsL0ViXgDhgraPPN/W6r4jettFwSoqZM0U/l21FFAOohJ1ufa5n2rJ2UErAiwJ62d
	cJJOM0ZcrMqO5XBqR8vctmk/N6yCIBSZZ63KH4kqXxUYWSwHf1Oxm2+IFelHzwOSEEY7ovb3giF
	ntgSGkfMazQkMTEu08aId/rg0zne+kAJQrNANFJ3506w4LRrESgg6T7P7LjdS/inETXbBNK0qSO
	S3VMzWZ19VmO6r+EZv/GzJ6J3h+nOPN6jDUu2dEOxiIg34p7zPWt7SZh2Y5cOKmKwYdYOkA/KfA
	rcrss9KsfVOOoH+Mn3zYXPGK2rW91YQsxRM618DHoIYtzDjrV84REo=
X-Received: by 2002:a5d:5f48:0:b0:475:69ce:ac4a with SMTP id ffacd0b85a97d-47f4fd11344mr5103142f8f.33.1784152860207;
        Wed, 15 Jul 2026 15:01:00 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464b7f84sm18572880f8f.27.2026.07.15.15.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:00:59 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 6/9] selftests/bpf: Add JIT-sequence tests for __arena kfunc arguments
Date: Thu, 16 Jul 2026 00:00:46 +0200
Message-ID: <20260715220052.1590783-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715220052.1590783-1-memxor@gmail.com>
References: <20260715220052.1590783-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4268; i=memxor@gmail.com; h=from:subject; bh=gIYlPDPUmdEfLvCWjLxkqMK7+A62h8qvyD078jaiMmQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuC6U6nnoTemoaDTTMl9QR8fDeXiy1Xfjixb1+n+ovjI nemFxZ0lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCK6lxj+8Lic5Ix9d3vFrxmC G7ZOkd9We8lqzmfdR3m/M14bqYRExDD809MPMblYHvpgX6bG1gfHHjY4rFHTebbi6BeLVIbyGUx F3AA=
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

