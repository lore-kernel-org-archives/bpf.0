Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9A7498904
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182400; cv=none; b=EGBc13eGNnArbW75fL2N84VUWGnjfCTQYI/8cpDuLttHaqzNVAx8w5+Gk7M4PhP/sbIyFh+TXXN+e+QI/9bwy2reXVp3BLFakPf5jrMt9edO04pWm/4X+jLv2PH7fIdhoykXmrsK/gZ62W/wdzUjxA2euSalVT99v2k4lSRh8NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182400; c=relaxed/simple;
	bh=cINrVnrX5YJUqRSkMZ4dxtVoBTwBWaIGcPYZhXHkn5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCBNbT97flpj1wZb3GrVvyUx1Q6GusjlLjG+e8DMHlSeJH1IdBpqe2t/SmnToobqM3QD5e85iQ0T9LGK5I2C4M4fmQL+0TVmWqa3Sug/1M8Zt6Q14ljxbCxsU1js3Zd93Rcu82aq56nHrBw9pUn79SJ4SWAQKszQz55wmrzFPEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOqemeUV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOqemeUV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965BD1F000FF;
	Wed, 23 Sep 2026 16:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790182398;
	bh=IKR8rT0o5zV6E5/BLrYuyl/4pcrnWQdkJmDts4Iuxu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NOqemeUVr5W97A1mHf4nTtj2OovXPY5TWa7C0EwxObVd649aYOxiTzXsWC2eIoH0d
	 3VSxGqlFv2wXUpdgRTUS+wZAea9lDfOo+AdgDd72hN0rgNo/6g2oxKHOt1v9lVmyHj
	 7L2+APysYThyb9PnCnZ/Mu16Ra4qYEPZADuq+if0bh9qlXOkC2Ayw0anKzHwUukcRH
	 a/SKLTI/e9YPYrHLpfJTUeLAdpMGTHHkaRIDQtL1p0gBSyd4PizdOdLfmRal575+4M
	 G+whlNY+wR0ZgYy1hA92rkAHs8cSAjKcZOvMU686zGg37/hieQAMViwtSjMhr/lW0+
	 jQ3oFqyvIp3PQ==
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
	"Yonghong Song" <yonghong.song@linux.dev>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test fetching AND/OR/XOR atomics in arena
Date: Wed, 23 Sep 2026 09:53:00 -0700
Message-ID: <20260923165301.3463007-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923165301.3463007-1-puranjay@kernel.org>
References: <20260923165301.3463007-1-puranjay@kernel.org>
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

It can now, so go back to plain __sync_fetch_and_*() and check the
returned old value. Drop the _Atomic declarations and <stdatomic.h> along
with the workaround.

Add a fetch_r0 test for the two register assignments the x86 JIT has to
special-case, where the operand and where the arena pointer is R0 and
BPF_REG_AX is substituted for it. Clang picks its own registers and will
not reliably produce either, so spell the instructions out.

Finally drop x86 from the exclusion list of the uaf test, which is what
covers the fault path through both of the new exception table entries.
arm64 stays excluded: whether its JIT accepts arena RMW atomics depends
on LSE being present at run time, which is not a compile-time property.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/prog_tests/arena_atomics.c  |  32 +++++
 .../selftests/bpf/progs/arena_atomics.c       | 114 ++++++++++++------
 2 files changed, 107 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
index 1ad5d03d07adb..13c37b087d6e7 100644
--- a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
+++ b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
@@ -68,6 +68,9 @@ static void test_and(struct arena_atomics *skel)
 
 	ASSERT_EQ(skel->arena->and64_value, 0x010ull << 32, "and64_value");
 	ASSERT_EQ(skel->arena->and32_value, 0x010, "and32_value");
+
+	ASSERT_EQ(skel->arena->and64_result, 0x110ull << 32, "and64_result");
+	ASSERT_EQ(skel->arena->and32_result, 0x110, "and32_result");
 }
 
 static void test_or(struct arena_atomics *skel)
@@ -85,6 +88,9 @@ static void test_or(struct arena_atomics *skel)
 
 	ASSERT_EQ(skel->arena->or64_value, 0x111ull << 32, "or64_value");
 	ASSERT_EQ(skel->arena->or32_value, 0x111, "or32_value");
+
+	ASSERT_EQ(skel->arena->or64_result, 0x110ull << 32, "or64_result");
+	ASSERT_EQ(skel->arena->or32_result, 0x110, "or32_result");
 }
 
 static void test_xor(struct arena_atomics *skel)
@@ -102,6 +108,9 @@ static void test_xor(struct arena_atomics *skel)
 
 	ASSERT_EQ(skel->arena->xor64_value, 0x101ull << 32, "xor64_value");
 	ASSERT_EQ(skel->arena->xor32_value, 0x101, "xor32_value");
+
+	ASSERT_EQ(skel->arena->xor64_result, 0x110ull << 32, "xor64_result");
+	ASSERT_EQ(skel->arena->xor32_result, 0x110, "xor32_result");
 }
 
 static void test_cmpxchg(struct arena_atomics *skel)
@@ -146,6 +155,27 @@ static void test_xchg(struct arena_atomics *skel)
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
@@ -256,6 +286,8 @@ void serial_test_arena_atomics(void)
 		test_cmpxchg(skel);
 	if (test__start_subtest("xchg"))
 		test_xchg(skel);
+	if (test__start_subtest("fetch_r0"))
+		test_fetch_r0(skel);
 	if (test__start_subtest("uaf"))
 		test_uaf(skel);
 	if (test__start_subtest("load_acquire"))
diff --git a/tools/testing/selftests/bpf/progs/arena_atomics.c b/tools/testing/selftests/bpf/progs/arena_atomics.c
index 73bc2b835f3fe..697f2c14e84eb 100644
--- a/tools/testing/selftests/bpf/progs/arena_atomics.c
+++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
@@ -4,7 +4,6 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <stdbool.h>
-#include <stdatomic.h>
 #include <bpf_arena_common.h>
 #include "../../../include/linux/filter.h"
 #include "bpf_misc.h"
@@ -91,13 +90,10 @@ int sub(const void *ctx)
 	return 0;
 }
 
-#ifdef __BPF_FEATURE_ATOMIC_MEM_ORDERING
-_Atomic __u64 __arena_global and64_value = (0x110ull << 32);
-_Atomic __u32 __arena_global and32_value = 0x110;
-#else
 __u64 __arena_global and64_value = (0x110ull << 32);
 __u32 __arena_global and32_value = 0x110;
-#endif
+__u64 __arena_global and64_result = 0;
+__u32 __arena_global and32_result = 0;
 
 SEC("raw_tp/sys_enter")
 int and(const void *ctx)
@@ -105,25 +101,17 @@ int and(const void *ctx)
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
 #endif
 
 	return 0;
 }
 
-#ifdef __BPF_FEATURE_ATOMIC_MEM_ORDERING
-_Atomic __u32 __arena_global or32_value = 0x110;
-_Atomic __u64 __arena_global or64_value = (0x110ull << 32);
-#else
 __u32 __arena_global or32_value = 0x110;
 __u64 __arena_global or64_value = (0x110ull << 32);
-#endif
+__u64 __arena_global or64_result = 0;
+__u32 __arena_global or32_result = 0;
 
 SEC("raw_tp/sys_enter")
 int or(const void *ctx)
@@ -131,25 +119,17 @@ int or(const void *ctx)
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
 #endif
 
 	return 0;
 }
 
-#ifdef __BPF_FEATURE_ATOMIC_MEM_ORDERING
-_Atomic __u64 __arena_global xor64_value = (0x110ull << 32);
-_Atomic __u32 __arena_global xor32_value = 0x110;
-#else
 __u64 __arena_global xor64_value = (0x110ull << 32);
 __u32 __arena_global xor32_value = 0x110;
-#endif
+__u64 __arena_global xor64_result = 0;
+__u32 __arena_global xor32_result = 0;
 
 SEC("raw_tp/sys_enter")
 int xor(const void *ctx)
@@ -157,13 +137,8 @@ int xor(const void *ctx)
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
 #endif
 
 	return 0;
@@ -213,6 +188,64 @@ int xchg(const void *ctx)
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
 
@@ -221,8 +254,11 @@ int uaf(const void *ctx)
 {
 	if (pid != (bpf_get_current_pid_tgid() >> 32))
 		return 0;
-#if defined(ENABLE_ATOMICS_TESTS) && !defined(__TARGET_ARCH_arm64) && \
-    !defined(__TARGET_ARCH_x86)
+/*
+ * arm64 stays excluded: whether the JIT accepts arena RMW atomics depends on
+ * LSE being available at run time, which is not a compile-time property.
+ */
+#if defined(ENABLE_ATOMICS_TESTS) && !defined(__TARGET_ARCH_arm64)
 	__u32 __arena *page32;
 	__u64 __arena *page64;
 	void __arena *page;
-- 
2.53.0-Meta

