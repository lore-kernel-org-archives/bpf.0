Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E5F421227
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 21:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963881; cv=none; b=E9iGYGfqO8gS9LBH/o27+rd/tftzoiLFtooAW6lG9sqZZ2iPzPaxyCM6YOBvz+lyM88WsgRJwXSBitF4/T+lJvi+A1i7//GZ6pG3Fg34No0YSPFtqyJTNyOVq+aoXQjWxAatR5F4gUhxdnBvgqYt7hQTEiHk8h8T++KCTx2mGVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963881; c=relaxed/simple;
	bh=i2litrY7ra4zEtXVjLRCb6RP0Ju0UaMa49IdjtLxLhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coebIiY3ihrBxmZa4iIfnPEWMdw7dw+Bkb6zn0Qjx0emFm3+1PjuaCS+Du/0CARJwL6sCBGOVd3eu0azogRANQLhV0hPw/moh6BhvXTprzrNlJCC7i8b3C4qmY5Ezdlsght1oX6cdH1xusqpIPxaiaVROVVnu3P9EDJxOJynvtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmdFMfGQ; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmdFMfGQ"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-498079e98beso3537725e9.1
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 14:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785963878; x=1786568678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UgtYfcx//JAQqAksGOSMy6JHQM7MmcmVxBSiIICuPIg=;
        b=ZmdFMfGQxABnteAgbBFHWvi3rBbAZPiA5kKyKKpWkpE7tM31IVT+xgJ45wPpyOtENT
         4aBokV5t+QPWxaiffCUK/xqyH5pbfwkYGeHHQeD5u8xGLuPOH/dnw7eHKNNvAo3nwU7E
         n6e3vhPmCK5Ybumf2MutIUT655ofRNBP4qNH79OHY7uHGdKkVXf5abSnvIwLZMf6kx3w
         X1hpgeuk7Tuv8Ckg7E55VbdkSRg5Y0X2uf6fIkoo7GoqwSMbbdF4bM8GJuc45JwMQA4E
         lmRoAqjjdg5CHQGwg7tQFLqm2gmhudX4m/4rgUDKtiiHA3sYezaxHusdhxclxXRXUXVH
         kRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785963878; x=1786568678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UgtYfcx//JAQqAksGOSMy6JHQM7MmcmVxBSiIICuPIg=;
        b=FltE2guyZfDIraarpxbZWRvDXYZ86j0638WjXXRZgFIPCJLYolGmBgSTblpHWzmHL2
         qqh/swNAcDiajZnjuPEQIPP9qxeXqnGGYLAgYx5Q+9l7mWi8HNbO3R7fQvMNpDoMYA2u
         11ajSFQ5mMFNMH1BKnIMl3QTkRGAvZvg+CYSxgi6B/ASH4q/4NTeuu4P6Svumt6YGMhg
         pEFjJ5owZKNKQl03n9pQuPn7pOXmfP4bytrXRuyAJQi9DiZjyMyuMcE/R5BTKKKNQP8a
         oh/3N+973Ev6WYP1sGQ2qycj4oU2wC2jxS1Bcp2Q/Z3/ijjMZcouRvbUypTNM79Hp8iy
         VLDg==
X-Gm-Message-State: AOJu0YxmQSKDy9Xc1tkXF38WfO1LiNQuuFdPF//R9X/XdRSfM1FoO13X
	ABTZXAiHeLYAsuK2xan4tV6+GV5ejcxbSkQXtwn5wfeH3d4KQ5tiyGnjn+mVhOQM
X-Gm-Gg: AR+sD13QoyDqz8JtqAE9xUYHSbJRqPgrXJ+oVAT2WZ4/H+SeXKXZ9mrtslZ5utRscua
	eaING4v+qw+ej/dOehO4DE6ViTo72+Xh4dmSM5qXiXrCj5yDIieqQh466+as7c+9IpCG1b1Amth
	v6bs4OCwjXCRbmPWKWN8xU+S9bmO84b1NhwWBt7cSsWsr9XbcOw2odvZiSZwrdKwV5VA5qoXEZ6
	XxLur4Dx8bAqy9M/qi/pNMqbJvXgzr+OzjeA2NKWXiRpNgw9p+Sv8pWPgp+WSqZBS4ai2lGgCxh
	28Q0YMIjzaj5CfJT5AZq3evBt1mGqHEq0YgVO+s5KIEQ5X7z2F0HukKv/A6HdZGOB/jUu506J4Y
	Z/gxsM38+uDZhRt40CcruowUTjJZy6WppGotBk9oa8SCgkYW3VH+IX3HKiwQ0JSUuXJ2bc666jU
	MO517jjSBu5VPYnrfee1k5BVkkr43sM1kJUkGy9zGlVbeAEBDLYXJLaarb9TSudxTH/N0n2NM/3
	t94CXd7FeFKOs7QHjK+LuCdNVJcurNfmpexfMS+MhBUWLBrAtzUJuHe6UssybbrkvVjJdkqhM8k
	+5OFooNYH83ZGUYga1eIhVdG8T801qbZup84Ig==
X-Received: by 2002:a05:600c:8b17:b0:498:14d3:562f with SMTP id 5b1f17b1804b1-4994e7cb3efmr112112875e9.15.1785963878296;
        Wed, 05 Aug 2026 14:04:38 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499542183b2sm8366645e9.4.2026.08.05.14.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:04:37 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 09/13] selftests/bpf: Add JIT-sequence tests for __arena kfunc arguments
Date: Wed,  5 Aug 2026 23:04:20 +0200
Message-ID: <20260805210427.3218326-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805210427.3218326-1-memxor@gmail.com>
References: <20260805210427.3218326-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4500; i=memxor@gmail.com; h=from:subject; bh=IzA2+9ggnCbPPOYtbikfOdLlIY6D0BlLh2tOFJ16KCI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIat40dSHD8RkPMzdY/4se+2yqzDvzJ7SXwlCHCz3fi/c2 ugiIVvQUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIks2cbwz3CdUHz65g3rv06e uf6vh8MmT54/Se3cLKxPg/MXG22wbWf4H9uwfI+Fv0HY0tNzcndOX99TLG6g0fZmycam4xXN0vM duQE=
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
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  3 +
 .../selftests/bpf/progs/arena_kfunc_jit.c     | 98 +++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/arena_kfunc_jit.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 7eaee71783b6..110a33b6e1c2 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -3,6 +3,7 @@
 #include <test_progs.h>
 
 #include "arena_kfunc.skel.h"
+#include "arena_kfunc_jit.skel.h"
 #include "cap_helpers.h"
 #include "verifier_align.skel.h"
 #include "verifier_and.skel.h"
@@ -169,6 +170,8 @@ static void run_tests_aux(const char *skel_name,
  */
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
2.53.0

