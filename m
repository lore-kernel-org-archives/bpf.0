Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703D54A207C;
	Fri, 25 Sep 2026 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344125; cv=none; b=oZv7H8r7NL7VW+HkwkULRvmCMZnJB7fNwS6J8OmDy/EroRVGzEuTIrRsLL9TnC03Skw/pHBxAvRr5eceLCwuf7SgL3IYVuv5kaI0SaL1kEXiR9brm7Z3EmqdLlmI+X8k+okSppImuXDMIsUU5oAQAwlY4tB2VuSHKFcVmfuKzts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344125; c=relaxed/simple;
	bh=y1kSx02FzRV1dlkVA5BKEP2PjebJvN7okGKv+MvenRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXFa7grHQi1DCtwQ214aX8OWaon7zjfmuim+wUmGhgeEHvMb3P0kI8jROpbSRi3GXj70N2aPfCFvvuT9sk6Caxefql1EsNPzxmehE60BWsgoBrbZ8WOS12E519BGdeGPwT5105+v08DpfZJLGCPe0fFx4VxMy91SUlfiX9hYQDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4ea965u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4ea965u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14451F000FF;
	Fri, 25 Sep 2026 13:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790344123;
	bh=2RTk6nLr1hSiarJMt13YTdSTD2/g9k9IDKVVtgXP3vU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D4ea965ulyrEWC8tIFlLeCpIhbFzBeXuuhC2gz0qTdhWHG7PzZMpsvADh7ZpIGVhP
	 +5f1TAyWzoin82u+YRRysS1JfkGBR1POSF60Bdkk9DoUxMdXtZCIXpito2OfQZ0yGM
	 c76C7rLIISlO0UCmzjSYdjhbKMxsC7C1cAcV9PrCNhvNY0JeEhcAGfyrQDQ+glwylh
	 C088lzxVNepsa8XjCJVh0EpFru/zsTfpMqks9C3RSruXiC/Rl/FxIkP3s2BkSHYxZG
	 LwIXRv6xymVXkq1hcreK6KyGV2Q6VFIhrA+zs1o90kaB+1Hj1dknyBjlrbrJO6MUXt
	 iKxMZNfRlZWiQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	"Tejun Heo" <tj@kernel.org>,
	"David Vernet" <void@manifault.com>,
	"Andrea Righi" <arighi@nvidia.com>,
	"Changwoo Min" <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: Test fetching AND/OR/XOR atomics in arena
Date: Fri, 25 Sep 2026 06:48:21 -0700
Message-ID: <20260925134828.2012199-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925134828.2012199-1-puranjay@kernel.org>
References: <20260925134828.2012199-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arena and/or/xor tests never exercised the fetching form of the
instruction. Commit 2897b1e2a2f4 ("selftests/bpf: Fix arena_atomics
failure due to llvm change") deliberately switched them to
__c11_atomic_fetch_*() with memory_order_relaxed, which clang lowers to a
non-fetching locked instruction when the result is unused, because
x86-64 could not JIT the fetching one against an arena.

It can now, so check the returned old value with __sync_fetch_and_*().
Keep a __c11_atomic_fetch_*() of each width per operation with the result
discarded: that spelling is what selects the non-fetching insn, which
would otherwise lose its only coverage, on every architecture rather than
just x86. Compiling the prog before and after confirms the split: 6 non-
fetching and no fetching arena and/or/xor before, 6 and 22 after.

Add a fetch_r0 test for the two register assignments the x86 JIT has to
special-case, where the operand and where the arena pointer is R0 and
BPF_REG_AX is substituted for it. Clang picks its own registers and will
not reliably produce either, so spell the instructions out. Add both
forms to the uaf test as well, since the substitution only reaches the
exception table when such an access faults.

Both spell addr_space_cast textually, which needs LLVM 19, so uaf gains
the __BPF_FEATURE_ADDR_SPACE_CAST guard that every other textual use in
the file already has. It was plain C before and built on older clang.

Finally drop x86 from the exclusion list of the uaf test, which is what
covers the fault path through the new exception table entry.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/prog_tests/arena_atomics.c  |  41 +++++
 .../selftests/bpf/progs/arena_atomics.c       | 167 ++++++++++++++----
 2 files changed, 169 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
index 1ad5d03d07adb..2a535815bf1dc 100644
--- a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
+++ b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
@@ -68,6 +68,12 @@ static void test_and(struct arena_atomics *skel)
 
 	ASSERT_EQ(skel->arena->and64_value, 0x010ull << 32, "and64_value");
 	ASSERT_EQ(skel->arena->and32_value, 0x010, "and32_value");
+
+	ASSERT_EQ(skel->arena->and64_result, 0x110ull << 32, "and64_result");
+	ASSERT_EQ(skel->arena->and32_result, 0x110, "and32_result");
+
+	ASSERT_EQ(skel->arena->and64_noreturn_value, 0x010ull << 32, "and64_noreturn_value");
+	ASSERT_EQ(skel->arena->and32_noreturn_value, 0x010, "and32_noreturn_value");
 }
 
 static void test_or(struct arena_atomics *skel)
@@ -85,6 +91,12 @@ static void test_or(struct arena_atomics *skel)
 
 	ASSERT_EQ(skel->arena->or64_value, 0x111ull << 32, "or64_value");
 	ASSERT_EQ(skel->arena->or32_value, 0x111, "or32_value");
+
+	ASSERT_EQ(skel->arena->or64_result, 0x110ull << 32, "or64_result");
+	ASSERT_EQ(skel->arena->or32_result, 0x110, "or32_result");
+
+	ASSERT_EQ(skel->arena->or64_noreturn_value, 0x111ull << 32, "or64_noreturn_value");
+	ASSERT_EQ(skel->arena->or32_noreturn_value, 0x111, "or32_noreturn_value");
 }
 
 static void test_xor(struct arena_atomics *skel)
@@ -102,6 +114,12 @@ static void test_xor(struct arena_atomics *skel)
 
 	ASSERT_EQ(skel->arena->xor64_value, 0x101ull << 32, "xor64_value");
 	ASSERT_EQ(skel->arena->xor32_value, 0x101, "xor32_value");
+
+	ASSERT_EQ(skel->arena->xor64_result, 0x110ull << 32, "xor64_result");
+	ASSERT_EQ(skel->arena->xor32_result, 0x110, "xor32_result");
+
+	ASSERT_EQ(skel->arena->xor64_noreturn_value, 0x101ull << 32, "xor64_noreturn_value");
+	ASSERT_EQ(skel->arena->xor32_noreturn_value, 0x101, "xor32_noreturn_value");
 }
 
 static void test_cmpxchg(struct arena_atomics *skel)
@@ -146,6 +164,27 @@ static void test_xchg(struct arena_atomics *skel)
 	ASSERT_EQ(skel->arena->xchg32_result, 1, "xchg32_result");
 }
 
+static void test_fetch_r0(struct arena_atomics *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd;
+
+	/* No need to attach it, just run it directly */
+	prog_fd = bpf_program__fd(skel->progs.fetch_r0);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return;
+
+	ASSERT_EQ(skel->arena->fetch_src_r0_value, 0x111, "fetch_src_r0_value");
+	ASSERT_EQ(skel->arena->fetch_src_r0_result, 0x110, "fetch_src_r0_result");
+
+	ASSERT_EQ(skel->arena->fetch_dst_r0_value, 0x111, "fetch_dst_r0_value");
+	ASSERT_EQ(skel->arena->fetch_dst_r0_result, 0x110, "fetch_dst_r0_result");
+	ASSERT_EQ(skel->arena->fetch_dst_r0_readback, 0x111, "fetch_dst_r0_readback");
+}
+
 static void test_uaf(struct arena_atomics *skel)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, topts);
@@ -256,6 +295,8 @@ void serial_test_arena_atomics(void)
 		test_cmpxchg(skel);
 	if (test__start_subtest("xchg"))
 		test_xchg(skel);
+	if (test__start_subtest("fetch_r0"))
+		test_fetch_r0(skel);
 	if (test__start_subtest("uaf"))
 		test_uaf(skel);
 	if (test__start_subtest("load_acquire"))
diff --git a/tools/testing/selftests/bpf/progs/arena_atomics.c b/tools/testing/selftests/bpf/progs/arena_atomics.c
index 73bc2b835f3fe..3beca5eab3873 100644
--- a/tools/testing/selftests/bpf/progs/arena_atomics.c
+++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
@@ -91,13 +91,22 @@ int sub(const void *ctx)
 	return 0;
 }
 
-#ifdef __BPF_FEATURE_ATOMIC_MEM_ORDERING
-_Atomic __u64 __arena_global and64_value = (0x110ull << 32);
-_Atomic __u32 __arena_global and32_value = 0x110;
-#else
+/*
+ * Discarding the result of an atomic RMW is what selects the non-fetching
+ * insn, so keep one of each width per operation to cover that lowering too.
+ * Declared together rather than per operation to keep them in one place.
+ */
+_Atomic __u64 __arena_global and64_noreturn_value = (0x110ull << 32);
+_Atomic __u64 __arena_global or64_noreturn_value = (0x110ull << 32);
+_Atomic __u64 __arena_global xor64_noreturn_value = (0x110ull << 32);
+_Atomic __u32 __arena_global and32_noreturn_value = 0x110;
+_Atomic __u32 __arena_global or32_noreturn_value = 0x110;
+_Atomic __u32 __arena_global xor32_noreturn_value = 0x110;
+
 __u64 __arena_global and64_value = (0x110ull << 32);
+__u64 __arena_global and64_result = 0;
 __u32 __arena_global and32_value = 0x110;
-#endif
+__u32 __arena_global and32_result = 0;
 
 SEC("raw_tp/sys_enter")
 int and(const void *ctx)
@@ -105,25 +114,19 @@ int and(const void *ctx)
 	if (pid != (bpf_get_current_pid_tgid() >> 32))
 		return 0;
 #ifdef ENABLE_ATOMICS_TESTS
-#ifdef __BPF_FEATURE_ATOMIC_MEM_ORDERING
-	__c11_atomic_fetch_and(&and64_value, 0x011ull << 32, memory_order_relaxed);
-	__c11_atomic_fetch_and(&and32_value, 0x011, memory_order_relaxed);
-#else
-	__sync_fetch_and_and(&and64_value, 0x011ull << 32);
-	__sync_fetch_and_and(&and32_value, 0x011);
-#endif
+	and64_result = __sync_fetch_and_and(&and64_value, 0x011ull << 32);
+	and32_result = __sync_fetch_and_and(&and32_value, 0x011);
+	__c11_atomic_fetch_and(&and64_noreturn_value, 0x011ull << 32, memory_order_relaxed);
+	__c11_atomic_fetch_and(&and32_noreturn_value, 0x011, memory_order_relaxed);
 #endif
 
 	return 0;
 }
 
-#ifdef __BPF_FEATURE_ATOMIC_MEM_ORDERING
-_Atomic __u32 __arena_global or32_value = 0x110;
-_Atomic __u64 __arena_global or64_value = (0x110ull << 32);
-#else
-__u32 __arena_global or32_value = 0x110;
 __u64 __arena_global or64_value = (0x110ull << 32);
-#endif
+__u64 __arena_global or64_result = 0;
+__u32 __arena_global or32_value = 0x110;
+__u32 __arena_global or32_result = 0;
 
 SEC("raw_tp/sys_enter")
 int or(const void *ctx)
@@ -131,25 +134,19 @@ int or(const void *ctx)
 	if (pid != (bpf_get_current_pid_tgid() >> 32))
 		return 0;
 #ifdef ENABLE_ATOMICS_TESTS
-#ifdef __BPF_FEATURE_ATOMIC_MEM_ORDERING
-	__c11_atomic_fetch_or(&or64_value, 0x011ull << 32, memory_order_relaxed);
-	__c11_atomic_fetch_or(&or32_value, 0x011, memory_order_relaxed);
-#else
-	__sync_fetch_and_or(&or64_value, 0x011ull << 32);
-	__sync_fetch_and_or(&or32_value, 0x011);
-#endif
+	or64_result = __sync_fetch_and_or(&or64_value, 0x011ull << 32);
+	or32_result = __sync_fetch_and_or(&or32_value, 0x011);
+	__c11_atomic_fetch_or(&or64_noreturn_value, 0x011ull << 32, memory_order_relaxed);
+	__c11_atomic_fetch_or(&or32_noreturn_value, 0x011, memory_order_relaxed);
 #endif
 
 	return 0;
 }
 
-#ifdef __BPF_FEATURE_ATOMIC_MEM_ORDERING
-_Atomic __u64 __arena_global xor64_value = (0x110ull << 32);
-_Atomic __u32 __arena_global xor32_value = 0x110;
-#else
 __u64 __arena_global xor64_value = (0x110ull << 32);
+__u64 __arena_global xor64_result = 0;
 __u32 __arena_global xor32_value = 0x110;
-#endif
+__u32 __arena_global xor32_result = 0;
 
 SEC("raw_tp/sys_enter")
 int xor(const void *ctx)
@@ -157,13 +154,10 @@ int xor(const void *ctx)
 	if (pid != (bpf_get_current_pid_tgid() >> 32))
 		return 0;
 #ifdef ENABLE_ATOMICS_TESTS
-#ifdef __BPF_FEATURE_ATOMIC_MEM_ORDERING
-	__c11_atomic_fetch_xor(&xor64_value, 0x011ull << 32, memory_order_relaxed);
-	__c11_atomic_fetch_xor(&xor32_value, 0x011, memory_order_relaxed);
-#else
-	__sync_fetch_and_xor(&xor64_value, 0x011ull << 32);
-	__sync_fetch_and_xor(&xor32_value, 0x011);
-#endif
+	xor64_result = __sync_fetch_and_xor(&xor64_value, 0x011ull << 32);
+	xor32_result = __sync_fetch_and_xor(&xor32_value, 0x011);
+	__c11_atomic_fetch_xor(&xor64_noreturn_value, 0x011ull << 32, memory_order_relaxed);
+	__c11_atomic_fetch_xor(&xor32_noreturn_value, 0x011, memory_order_relaxed);
 #endif
 
 	return 0;
@@ -213,6 +207,64 @@ int xchg(const void *ctx)
 	return 0;
 }
 
+__u64 __arena_global fetch_src_r0_value = 0x110;
+__u64 __arena_global fetch_src_r0_result = 0;
+__u64 __arena_global fetch_dst_r0_value = 0x110;
+__u64 __arena_global fetch_dst_r0_result = 0;
+__u64 __arena_global fetch_dst_r0_readback = 0;
+
+/*
+ * A fetching OR with the operand in r0, and one with the arena pointer in r0.
+ * The x86 JIT needs RAX for its CMPXCHG loop and substitutes BPF_REG_AX for
+ * whichever of the two is r0, so both have to keep working. Hand-written
+ * because clang picks its own registers and will not reliably emit either.
+ */
+SEC("raw_tp/sys_enter")
+int fetch_r0(const void *ctx)
+{
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+#if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	asm volatile (
+	"r1 = %[fetch_src_r0_value] ll;"
+	"r1 = addr_space_cast(r1, 0x0, 0x1);"
+	"r0 = 0x011;"
+	".8byte %[fetch_src_r0_insn];"
+	"r2 = %[fetch_src_r0_result] ll;"
+	"r2 = addr_space_cast(r2, 0x0, 0x1);"
+	"*(u64 *)(r2 + 0) = r0;"
+	:
+	: __imm_addr(fetch_src_r0_value),
+	  __imm_insn(fetch_src_r0_insn,
+		     BPF_ATOMIC_OP(BPF_DW, BPF_OR | BPF_FETCH, BPF_REG_1, BPF_REG_0, 0)),
+	  __imm_addr(fetch_src_r0_result)
+	: __clobber_all);
+
+	asm volatile (
+	"r0 = %[fetch_dst_r0_value] ll;"
+	"r0 = addr_space_cast(r0, 0x0, 0x1);"
+	"r1 = 0x011;"
+	".8byte %[fetch_dst_r0_insn];"
+	"r2 = %[fetch_dst_r0_result] ll;"
+	"r2 = addr_space_cast(r2, 0x0, 0x1);"
+	"*(u64 *)(r2 + 0) = r1;"
+	/* r0 is only read by the atomic, so it must still be the pointer. */
+	"r3 = *(u64 *)(r0 + 0);"
+	"r2 = %[fetch_dst_r0_readback] ll;"
+	"r2 = addr_space_cast(r2, 0x0, 0x1);"
+	"*(u64 *)(r2 + 0) = r3;"
+	:
+	: __imm_addr(fetch_dst_r0_value),
+	  __imm_insn(fetch_dst_r0_insn,
+		     BPF_ATOMIC_OP(BPF_DW, BPF_OR | BPF_FETCH, BPF_REG_0, BPF_REG_1, 0)),
+	  __imm_addr(fetch_dst_r0_result),
+	  __imm_addr(fetch_dst_r0_readback)
+	: __clobber_all);
+#endif
+
+	return 0;
+}
+
 __u64 __arena_global uaf_sink;
 volatile __u64 __arena_global uaf_recovery_fails;
 
@@ -221,15 +273,24 @@ int uaf(const void *ctx)
 {
 	if (pid != (bpf_get_current_pid_tgid() >> 32))
 		return 0;
+/*
+ * arm64 stays excluded as it has been since this test was added: its JIT only
+ * accepts arena RMW atomics when LSE is present, which is a run-time property.
+ * The rest of the file shares that dependency without a guard, so on a non-LSE
+ * arm64 the whole skeleton already fails to load.
+ *
+ * __BPF_FEATURE_ADDR_SPACE_CAST is required by the asm below, which spells
+ * addr_space_cast textually. That and the mnemonic both arrived in LLVM 19.
+ */
 #if defined(ENABLE_ATOMICS_TESTS) && !defined(__TARGET_ARCH_arm64) && \
-    !defined(__TARGET_ARCH_x86)
+	defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	__u32 __arena *page32;
 	__u64 __arena *page64;
 	void __arena *page;
 
 	page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
 	bpf_arena_free_pages(&arena, page, 1);
-	uaf_recovery_fails = 24;
+	uaf_recovery_fails = 26;
 
 	page32 = (__u32 __arena *)page;
 	uaf_sink += __sync_fetch_and_add(page32, 1);
@@ -282,6 +343,34 @@ int uaf(const void *ctx)
 	uaf_recovery_fails -= 1;
 	uaf_sink += __sync_lock_test_and_set(page64, 1);
 	uaf_recovery_fails -= 1;
+
+	/*
+	 * The x86 JIT needs RAX for the CMPXCHG loop it lowers a fetching
+	 * AND/OR/XOR into, and substitutes BPF_REG_AX for r0 when r0 is either
+	 * operand. Only then does the fault fixup have to name that register,
+	 * so spell both forms out: clang picks its own and never produces them.
+	 */
+	asm volatile (
+	"r0 = %[page];"
+	"r0 = addr_space_cast(r0, 0x0, 0x1);"
+	"r1 = 1;"
+	".8byte %[fetch_dst_r0];"
+	: : [page]"r"(page64),
+	    __imm_insn(fetch_dst_r0,
+		       BPF_ATOMIC_OP(BPF_DW, BPF_OR | BPF_FETCH, BPF_REG_0, BPF_REG_1, 0))
+	: "r0", "r1", "memory");
+	uaf_recovery_fails -= 1;
+
+	asm volatile (
+	"r1 = %[page];"
+	"r1 = addr_space_cast(r1, 0x0, 0x1);"
+	"r0 = 1;"
+	".8byte %[fetch_src_r0];"
+	: : [page]"r"(page64),
+	    __imm_insn(fetch_src_r0,
+		       BPF_ATOMIC_OP(BPF_DW, BPF_OR | BPF_FETCH, BPF_REG_1, BPF_REG_0, 0))
+	: "r0", "r1", "memory");
+	uaf_recovery_fails -= 1;
 #endif
 
 	return 0;
-- 
2.53.0-Meta

