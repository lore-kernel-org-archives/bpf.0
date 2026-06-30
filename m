Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E131C23FC41
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 02:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782788318; cv=none; b=bCXBr+Ck1SU7pCbfFh6E/VVkPYidHPI0fsnG1v0aae7CNpAODB4DEM1YM0qyQ7sKHZYUPNU76RAB3qe4Zhz/fwg0umzm75qenHf51bW9FeE9jHmw01WymPv7NURp8nuwcfx4m0TOfiPwgdio0DCadd4Bw72HyWkqIpoKUxEMPq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782788318; c=relaxed/simple;
	bh=tPLinYbJb80Iz/qFBGacknXcBvQq+tUEq9miK6254Iw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sbcZ4h254cHCf3MZigfrKzkem6ZgY5Y9RQNLut2C52vukgD/cGX+rZqrTKDEuh2hptY4dbjn0acKI0cHvfMdbJM7bvebWuXKTM0qVk2g7S8Q6rkgrPbRfRWc4NvYd1xxFYuwx1pzeoyAt+6ktnHBjVnQUCIfcTyQ4Lr2k+g5bHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z9L8pjtG; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z9L8pjtG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782788304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OsYagQzu6qHNQWTSa0S7+sdlg1USYp8Up3WJKT3wYiY=;
	b=Z9L8pjtGtgPdqqpvLzsFUS0JgIr7gs5/l0Zlddd83H+CvT7uKHQtMwmYrlV6Tsh63ry97E
	OFOIsKp/Ozxz8x74bPxw1/pzsiywZpP2FFzGFO6/dgznVQAkNR69uhXfo7g/UuPUQr6Rno
	BZMfGaLbzGgqyjJGLP0GVUyFWT8fgCc=
From: George Guo <dongtai.guo@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	George Guo <guodongtai@kylinos.cn>,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] selftests/bpf: Skip libarena when the BPF backend lacks 32-bit arena cmpxchg
Date: Tue, 30 Jun 2026 10:58:09 +0800
Message-Id: <20260630025809.74043-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

The arena qspinlock pulled in by libarena (bpf_arena_spin_lock.h) performs
a 32-bit atomic compare-and-exchange on an arena (address space 1) pointer
via atomic_try_cmpxchg_acquire() on the 32-bit atomic_t lock word. Not
every LLVM BPF backend can select that operation; releases such as clang 19
abort instruction selection with:

  error: unsupported atomic operation, please use 64 bit version
  fatal error: error in backend: Cannot select: AtomicCmpSwap<(s32)> ...
  In function: arena_spin_lock_slowpath

Because libarena/libarena.skel.h is an unconditional dependency of
test_progs, this aborts the entire selftests/bpf build before test_progs is
ever linked, so none of the other tests can be built or run. This was
observed building selftests/bpf for LoongArch with clang 19, but it is a
property of the BPF backend, not of the host architecture.

Mirror the existing CLANG_HAS_ARENA_ASAN feature probe: detect whether the
backend can compile a 32-bit arena cmpxchg, and only build libarena when it
can. Define HAS_BPF_ARENA in that case and guard prog_tests/libarena.c
behind it - exactly the way prog_tests/libarena_asan.c is guarded behind
HAS_BPF_ARENA_ASAN - so the test still compiles and reports as skipped when
libarena is not built. When the operation is unsupported, libarena is
skipped and the rest of test_progs builds and links as before.

Fixes: d5327480a12a ("selftests/bpf: Add basic libarena scaffolding")
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 tools/testing/selftests/bpf/Makefile          | 14 ++++++++++++++
 .../selftests/bpf/prog_tests/libarena.c       | 19 ++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b642ee489ea6..0098d892cb39 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -91,6 +91,17 @@ CLANG_HAS_ARENA_ASAN := $(shell echo 'int x;' | \
 	-mllvm -asan-shadow-addr-space=1 \
 	-x c -c - -o /dev/null 2>/dev/null && echo 1)
 
+# The arena qspinlock used by libarena performs a 32-bit atomic cmpxchg on an
+# arena (address space 1) pointer. Not every LLVM BPF backend can select it;
+# older releases bail out with "unsupported atomic operation, please use 64 bit
+# version", which aborts the whole selftests build. Probe for the operation and
+# skip libarena (and its dependent tests) when the backend cannot handle it.
+CLANG_HAS_ARENA_CMPXCHG32 := $(shell printf '%s\n' \
+	'struct s { int counter; };' \
+	'int f(struct s __attribute__((address_space(1))) *l, int o, int n)' \
+	'{ return __sync_val_compare_and_swap(&l->counter, o, n); }' | \
+	$(CLANG) --target=bpf -O2 -x c -c - -o /dev/null 2>/dev/null && echo 1)
+
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_progs \
 	test_sockmap \
@@ -835,10 +846,13 @@ LIBARENA_BPF_DEPS := $(wildcard libarena/Makefile		\
 				 libarena/selftests/*		\
 				 libarena/*.bpf.o)
 
+ifneq ($(CLANG_HAS_ARENA_CMPXCHG32),)
 LIBARENA_SKEL := libarena/libarena.skel.h
+CFLAGS += -DHAS_BPF_ARENA
 
 $(LIBARENA_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
 	+$(MAKE) -C libarena libarena.skel.h $(LIBARENA_MAKE_ARGS)
+endif
 
 ifneq ($(CLANG_HAS_ARENA_ASAN),)
 LIBARENA_ASAN_SKEL := libarena/libarena_asan.skel.h
diff --git a/tools/testing/selftests/bpf/prog_tests/libarena.c b/tools/testing/selftests/bpf/prog_tests/libarena.c
index 61ea68dce410..a7ede72c7256 100644
--- a/tools/testing/selftests/bpf/prog_tests/libarena.c
+++ b/tools/testing/selftests/bpf/prog_tests/libarena.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
 /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
 #include <test_progs.h>
+
+#ifdef HAS_BPF_ARENA
 #include <unistd.h>
 
 #include <libarena/common.h>
@@ -198,7 +200,7 @@ static void run_libarena_parallel_test(struct libarena *skel, struct bpf_program
 	run_libarena_parallel_fini(skel, name, prefixlen);
 }
 
-void test_libarena(void)
+static void run_test(void)
 {
 	struct arena_alloc_reserve_args args;
 	struct libarena *skel;
@@ -251,3 +253,18 @@ void test_libarena(void)
 out:
 	libarena__destroy(skel);
 }
+
+#endif /* HAS_BPF_ARENA */
+
+/*
+ * Run the test only if the BPF backend can compile the arena programs
+ * libarena depends on (see CLANG_HAS_ARENA_CMPXCHG32 in the Makefile).
+ */
+void test_libarena(void)
+{
+#ifdef HAS_BPF_ARENA
+	run_test();
+#else
+	test__skip();
+#endif
+}
-- 
2.25.1

