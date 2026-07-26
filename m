Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F731302146
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 01:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785029475; cv=none; b=PiyTKFJAyj7CmkdD6PnzKZ24RtTleYsWyHIF9NXyhbEmWNFyjhMkfsSyi2d9w18H0JCn06mjVM7dppUTA/iT49yQh70fyfgQPoQYAjvVD/15FMXE97OfLZnBmh19auWx5MQzOeru/imrkIWtjw7mynCCcquaw6jX5zARyKUE0ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785029475; c=relaxed/simple;
	bh=lDDj938vjODLg8NlRS3Lzjknn+FfTuav6uZDkZrYVuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqdpQLHqvh8n6llebi67pv6xMphkh6tWndUOIACzpCssfaMQLio5clI2/noMEDEyYdgnuOfTWS2a3n5hKQbDwFa/4501992KL03OZTUoRx0I3vjmm3Xx6vuXHlGGPJSIIcFtyYuDfC2htF/d1hv82USKZz0wD079ScvW8qrg1ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMmlHlQW; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMmlHlQW"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47528970fbdso646317f8f.1
        for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 18:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785029472; x=1785634272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jbqOP3+QFpsnQXK31UnGLry20dmETJAoWcqdS/af96Q=;
        b=GMmlHlQWY+1fkD63tVjhY61mLYquouuxG24uJ7sop+bPtHUjrk1QCtADK4W4/nf8Hm
         29mA5M5fuUtS9ra1+sfpljQPRf6F2nCj7KRZaXT7Nf8n7AYMsPazH/7XIydtJK8aqe7x
         IVFMDNbHDbIJwKldyh872V38z7CISx1RAvfAh6CUiWvt6yemSRZxZ5pWW35GLRKf21OV
         5VyY7baE8a2AEu9nfe8rzuRVv6P6W++2ZGto2iYPYgnLPMRJM/8r7VJDlTF2MkZspOXz
         8JNlJoebspkY2GD6TEoKhzhA3MheGPqS6slh23mMZRwK/vFs724KvTKUfuL2qgvucexg
         L3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785029472; x=1785634272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jbqOP3+QFpsnQXK31UnGLry20dmETJAoWcqdS/af96Q=;
        b=L3j7Uu4A4l/hr8aCHNv4zWEGmX0V2mY12gqOfmuTXHYgF+NcBAdprn90EsaqzKSipu
         elnzwYETP/PW0k4un0AbXs79EjEewBczQl9nDzkRBgjNgzCmQvZirY2s2FZ9tJqW995+
         Rp5EuqT+5WI2XiXn3gAuLMNV1kXAJbxiaeAJZzVhIt3TyAWZioL9IIIg8OFdKWpwv8ac
         vl++zpDVFNF6nr+XJCHLgghsc+LOu9mEF8ch/fATwdspio4QRiMOpsqFyZclNg9f1HfY
         F21Pa7WJvNHaXrAy4mtpr2Gdd5r1eAOWfIjeZV7SP+ypjr+jRK0JiQVYXFn+kZEYg1tv
         bN0A==
X-Gm-Message-State: AOJu0YzrMF/VMEdonYmiFigxp0AuCYD3XSiBri8VYKv/I47KVVzeYNwS
	aLqskbbrA8lMox48zJPWxXO1xmU4+UhMhwniyrOoU3wCe7Ts82788WWT6tvFNSKN
X-Gm-Gg: AR+sD10owqe3ebPBMeUrBmJd18fxUHq6cNYvNpBf7JH4YQbnZcpY4szgcFb9YLDc7O2
	fdB/X/ySp1N+Jlyig86Cag7W86DFZPEyjUU4S5erHlURUJiYWV9ByMYPTqbGa3u/Wby8sdOEfyf
	GjWz4nyG4KfpVbY7dOdqAeW2DriFbljY1hxJD765MY6vpD1IXxycpxGRDYHORlpVu1Pqznw1vW8
	/W16nbWpOR8Dw6L+XjS8DMTynB/CrSRyUZT8nWsC6x76NhjjAZTP9ij4KxELTeW2lXJUxebDdAg
	TqygcEmN8x9jqdIaU0G0L7Rmf9wH6SwczpsOEbECxVmRHBcqqJMkUUoeydA3SY9xD5SRi96IzLZ
	0dvIx2d+9mjo5932zsLrdKNM+HO1hagGuLu9gWNY+bTVMQQNfqU91wKt3ATs3U5Ge9WUoSAQtHI
	GDVc895KYhxCU3ZfbKSpfTLfTsFuWHOFrWU4aG4a+qAIMmwuhlk4OdqC8TYBnp3NiE4OF6IG8MZ
	Hxgd4xhsihIqwTOTMBkbbeUEG6R3VYoM8qI14X0GBXb
X-Received: by 2002:a05:6000:2287:b0:47f:81c4:36a5 with SMTP id ffacd0b85a97d-47f9fc92cfdmr4390680f8f.15.1785029472322;
        Sat, 25 Jul 2026 18:31:12 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6dc25sm35867630f8f.33.2026.07.25.18.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 18:31:11 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 6/9] selftests/bpf: Add JIT-sequence tests for __arena kfunc arguments
Date: Sun, 26 Jul 2026 03:30:59 +0200
Message-ID: <20260726013105.3689867-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726013105.3689867-1-memxor@gmail.com>
References: <20260726013105.3689867-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4268; i=memxor@gmail.com; h=from:subject; bh=gIYlPDPUmdEfLvCWjLxkqMK7+A62h8qvyD078jaiMmQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISs12apTT0JvTcPBppmSegI+vpvLxZYrP5zYt69T/cVxk TvTCws6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJGqZQz/nXnmsPTqiSbduH5c 2uGUl4FHIeuXY/mL5wVdkN777+ir+wx/pbPra7RCTi0x3pmirviKlct61ee15eoS6nVHj5i6v/J iAQA=
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

