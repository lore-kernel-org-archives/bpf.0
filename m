Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91605581F3
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170827; cv=none; b=Gy7pVqsWsSx5+cT3chVd8Q4fw5E6i2d5Z+/arYozMm99XcwSgRlmdjUBo+VzgWZWjNQJwZDUQEZkKLBmifZ8KflK/9h6KlLXUusi+kIlTEV5e04ukkJCOKbaiRtu8NN50uTOLC6ojM2YpIo3hVpc3H3KCf5CpuI52T/w0pTTL2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170827; c=relaxed/simple;
	bh=qLEtLV2gcZIJkWcgTQYm4zAlkFYhrwGaUPlXVcd6gDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWo80XvxYEOKqiNY1U7+EMUIh/8z4OnfPBMt8G6EtqL+j1PlSdfWqStgBrfDTB+Fr3f79dz8nARbMBYlrrbwi/J8DwjHeuBtsZUQ2mnKrF7JgcTSjRF3EOGivEAEl1tOR3UWAAJN/S6Sx6zavCIEe4mh4sX0hxk6iCBrdVTCPY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGQJVlke; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGQJVlke"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453261F000C4;
	Fri, 16 Oct 2026 17:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792170823;
	bh=LvlRZvi1D0HGQD/Ksi9xdJr/RyAiq3pxGxHCN3f4eRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JGQJVlkeze1LtUv4OONrWy6P71a2fqSijXkc/fveOeWLm1CtN9Yba6jChFaRTOLBl
	 B6D+ZgZBo8Rysxpch1SQjt8lpU1ad3WGdnfNS+I4vS/7545+lRIG1lpUWda2TzCP2C
	 +G4pyxo7aym+weTahJShERFuL2WjQxQ/NoWeQdsYA7y3reZ1Muu5SJ/zqe5sDyOHQJ
	 Y/aJwtj5axKDVKgtLWN7lHSxPc8LnpDfUXunpllCnmuEY73SSqKWdKLnnadmy9MmdN
	 eACoqyT4mqUqGFgIpNwI4/DaO64jbK6/Ns4Lq7bQJz0WEVXbOB1ANETJPol1tl295X
	 lpetHKusOrAJg==
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
	"Tejun Heo" <tj@kernel.org>
Subject: [PATCH bpf-next v5 2/3] selftests/bpf: Test fetching AND/OR/XOR atomics in arena
Date: Fri, 16 Oct 2026 10:13:13 -0700
Message-ID: <20261016171319.1623447-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016171319.1623447-1-puranjay@kernel.org>
References: <20261016171319.1623447-1-puranjay@kernel.org>
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
just x86. Compiling the prog with clang 22 before and after confirms the
split: 6 non-fetching and no fetching arena and/or/xor before, 6 and 22
after.

The new globals go in their operation's block, and the or block keeps its
u32s first, so .addr_space.1 stays free of the padding holes that clang
before 18 cannot fill when it is built without address space casts.

Add a fetch_r0 test for the two register assignments the x86 JIT has to
special-case, where the operand and where the arena pointer is R0 and
BPF_REG_AX is substituted for it. Clang picks its own registers and will
not reliably produce either, so spell the instructions out. The values
have bits set above 32 so that a truncating move on that path shows up.
Add both forms to the uaf test as well, since the substitution only
reaches the exception table when such an access faults, and check that
the fault cleared the fetched register and left the address alone. They
fault on the page after the freed one: the freed page is the first of the
arena, whose 32-bit address is 0, which would make the address check
empty. The address is read back afterwards, which gives 0 if the JIT's
exception table entry recovered the fault, but not if the arena had
mapped its zeroed scratch page and let the access succeed. The powerpc64
JIT does not clear the register of a faulting atomic yet, so those checks
are skipped there.

Both spell addr_space_cast textually, which needs LLVM 19, so uaf gains
the __BPF_FEATURE_ADDR_SPACE_CAST guard that every other textual use in
the file already has. It was plain C before and built on older clang.

Drop x86 from the exclusion list of the uaf test, which covers the fault
path. Its page is gone before the first access, so it faults on the load;
the CMPXCHG entry is only reached when the page goes away between the two
accesses, which a test cannot arrange.

Finally cover fetching AND/OR/XOR through a number in
verifier_arena_scalar, on x86-64 and arm64. Both widths are run with the
operand in a register and in R0, which is where the x86-64 JIT keeps the
operand on the stack because BPF_REG_AX holds the address. The 32-bit
operands have bits set above 32 so that a missing zero-extension shows.
The page is also freed first, after storing a nonzero value in it so that
an access which did not fault would show, and the test checks that the
fetched register comes back 0 and R0 is left alone, and that reading the
address back gives 0. R0 is compared with a value derived from the page
address: the verifier would decide a comparison with a constant at load
time and drop it.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/prog_tests/arena_atomics.c  |  53 ++++
 .../selftests/bpf/progs/arena_atomics.c       | 211 ++++++++++++---
 .../bpf/progs/verifier_arena_scalar.c         | 256 ++++++++++++++++++
 3 files changed, 482 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
index 1ad5d03d07adb..222c63b15de03 100644
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
+	ASSERT_EQ(skel->arena->fetch_src_r0_value, 0x11100000111ull, "fetch_src_r0_value");
+	ASSERT_EQ(skel->arena->fetch_src_r0_result, 0x11000000110ull, "fetch_src_r0_result");
+
+	ASSERT_EQ(skel->arena->fetch_dst_r0_value, 0x11100000111ull, "fetch_dst_r0_value");
+	ASSERT_EQ(skel->arena->fetch_dst_r0_result, 0x11000000110ull, "fetch_dst_r0_result");
+	ASSERT_EQ(skel->arena->fetch_dst_r0_readback, 0x11100000111ull, "fetch_dst_r0_readback");
+}
+
 static void test_uaf(struct arena_atomics *skel)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, topts);
@@ -160,6 +199,18 @@ static void test_uaf(struct arena_atomics *skel)
 		return;
 
 	ASSERT_EQ(skel->arena->uaf_recovery_fails, 0, "uaf_recovery_fails");
+
+#ifndef __powerpc64__
+	/*
+	 * A fault clears the fetched register and leaves the address alone. The
+	 * powerpc64 JIT does not clear the register of a faulting atomic yet.
+	 */
+	ASSERT_EQ(skel->arena->uaf_r1_after_dst_r0, 0, "uaf_r1_after_dst_r0");
+	ASSERT_EQ(skel->arena->uaf_r0_after_dst_r0, skel->arena->uaf_r0_before_dst_r0,
+		  "uaf_r0_after_dst_r0");
+	ASSERT_EQ(skel->arena->uaf_r0_after_src_r0, 0, "uaf_r0_after_src_r0");
+	ASSERT_EQ(skel->arena->uaf_reread, 0, "uaf_reread");
+#endif
 }
 
 static void test_load_acquire(struct arena_atomics *skel)
@@ -256,6 +307,8 @@ void serial_test_arena_atomics(void)
 		test_cmpxchg(skel);
 	if (test__start_subtest("xchg"))
 		test_xchg(skel);
+	if (test__start_subtest("fetch_r0"))
+		test_fetch_r0(skel);
 	if (test__start_subtest("uaf"))
 		test_uaf(skel);
 	if (test__start_subtest("load_acquire"))
diff --git a/tools/testing/selftests/bpf/progs/arena_atomics.c b/tools/testing/selftests/bpf/progs/arena_atomics.c
index 73bc2b835f3fe..ce76a73d197bb 100644
--- a/tools/testing/selftests/bpf/progs/arena_atomics.c
+++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
@@ -91,13 +91,17 @@ int sub(const void *ctx)
 	return 0;
 }
 
-#ifdef __BPF_FEATURE_ATOMIC_MEM_ORDERING
-_Atomic __u64 __arena_global and64_value = (0x110ull << 32);
-_Atomic __u32 __arena_global and32_value = 0x110;
-#else
+/*
+ * A relaxed __c11_atomic_fetch_*() whose result is discarded is what selects
+ * the non-fetching insn, so each operation keeps a *_noreturn_value of each
+ * width to cover that lowering as well.
+ */
 __u64 __arena_global and64_value = (0x110ull << 32);
+__u64 __arena_global and64_result = 0;
+_Atomic __u64 __arena_global and64_noreturn_value = (0x110ull << 32);
 __u32 __arena_global and32_value = 0x110;
-#endif
+__u32 __arena_global and32_result = 0;
+_Atomic __u32 __arena_global and32_noreturn_value = 0x110;
 
 SEC("raw_tp/sys_enter")
 int and(const void *ctx)
@@ -105,25 +109,22 @@ int and(const void *ctx)
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
+/* u32s first: .addr_space.1 must not have holes, see the clang-17 note below */
 __u32 __arena_global or32_value = 0x110;
+__u32 __arena_global or32_result = 0;
+_Atomic __u32 __arena_global or32_noreturn_value = 0x110;
 __u64 __arena_global or64_value = (0x110ull << 32);
-#endif
+__u64 __arena_global or64_result = 0;
+_Atomic __u64 __arena_global or64_noreturn_value = (0x110ull << 32);
 
 SEC("raw_tp/sys_enter")
 int or(const void *ctx)
@@ -131,25 +132,21 @@ int or(const void *ctx)
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
+_Atomic __u64 __arena_global xor64_noreturn_value = (0x110ull << 32);
 __u32 __arena_global xor32_value = 0x110;
-#endif
+__u32 __arena_global xor32_result = 0;
+_Atomic __u32 __arena_global xor32_noreturn_value = 0x110;
 
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
@@ -213,23 +207,96 @@ int xchg(const void *ctx)
 	return 0;
 }
 
+__u64 __arena_global fetch_src_r0_value = 0x11000000110ull;
+__u64 __arena_global fetch_src_r0_result = 0;
+__u64 __arena_global fetch_dst_r0_value = 0x11000000110ull;
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
+	"r0 = 0x1100000011 ll;"
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
+	"r1 = 0x1100000011 ll;"
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
+/* Register state after the r0 forms below fault, checked by the test */
+__u64 __arena_global uaf_r1_after_dst_r0;
+__u64 __arena_global uaf_r0_before_dst_r0;
+__u64 __arena_global uaf_r0_after_dst_r0;
+__u64 __arena_global uaf_r0_after_src_r0;
+/* What reading the faulted address again gives, see the end of uaf() */
+__u64 __arena_global uaf_reread;
 
 SEC("syscall")
 int uaf(const void *ctx)
 {
 	if (pid != (bpf_get_current_pid_tgid() >> 32))
 		return 0;
+/*
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
+	uaf_r1_after_dst_r0 = 1;
+	uaf_r0_after_dst_r0 = 1;
+	uaf_r0_after_src_r0 = 1;
+	uaf_reread = 1;
 
 	page32 = (__u32 __arena *)page;
 	uaf_sink += __sync_fetch_and_add(page32, 1);
@@ -282,6 +349,74 @@ int uaf(const void *ctx)
 	uaf_recovery_fails -= 1;
 	uaf_sink += __sync_lock_test_and_set(page64, 1);
 	uaf_recovery_fails -= 1;
+
+	/*
+	 * The x86 JIT needs RAX for the CMPXCHG loop it lowers a fetching
+	 * AND/OR/XOR into, and substitutes BPF_REG_AX for r0 when r0 is either
+	 * operand. Only then does the fault fixup have to name that register,
+	 * so spell both forms out: clang picks its own and never produces them.
+	 *
+	 * The freed page is the first of the arena, whose 32-bit address is 0,
+	 * which would make "the address register was left alone" an empty
+	 * check. Use the page after it, which is unmapped as well.
+	 */
+	asm volatile (
+	"r0 = %[page];"
+	"r0 += 4096;"
+	"r0 = addr_space_cast(r0, 0x0, 0x1);"
+	"r1 = 1;"
+	"r2 = %[uaf_r0_before_dst_r0] ll;"
+	"r2 = addr_space_cast(r2, 0x0, 0x1);"
+	"*(u64 *)(r2 + 0) = r0;"
+	".8byte %[fetch_dst_r0];"
+	"r2 = %[uaf_r0_after_dst_r0] ll;"
+	"r2 = addr_space_cast(r2, 0x0, 0x1);"
+	"*(u64 *)(r2 + 0) = r0;"
+	"r2 = %[uaf_r1_after_dst_r0] ll;"
+	"r2 = addr_space_cast(r2, 0x0, 0x1);"
+	"*(u64 *)(r2 + 0) = r1;"
+	: : [page]"r"(page64),
+	    __imm_insn(fetch_dst_r0,
+		       BPF_ATOMIC_OP(BPF_DW, BPF_OR | BPF_FETCH, BPF_REG_0, BPF_REG_1, 0)),
+	    __imm_addr(uaf_r0_before_dst_r0),
+	    __imm_addr(uaf_r0_after_dst_r0),
+	    __imm_addr(uaf_r1_after_dst_r0)
+	: "r0", "r1", "r2", "memory");
+	uaf_recovery_fails -= 1;
+
+	asm volatile (
+	"r1 = %[page];"
+	"r1 += 4096;"
+	"r1 = addr_space_cast(r1, 0x0, 0x1);"
+	"r0 = 1;"
+	".8byte %[fetch_src_r0];"
+	"r2 = %[uaf_r0_after_src_r0] ll;"
+	"r2 = addr_space_cast(r2, 0x0, 0x1);"
+	"*(u64 *)(r2 + 0) = r0;"
+	: : [page]"r"(page64),
+	    __imm_insn(fetch_src_r0,
+		       BPF_ATOMIC_OP(BPF_DW, BPF_OR | BPF_FETCH, BPF_REG_1, BPF_REG_0, 0)),
+	    __imm_addr(uaf_r0_after_src_r0)
+	: "r0", "r1", "r2", "memory");
+	uaf_recovery_fails -= 1;
+
+	/*
+	 * If a fault were recovered by the arena mapping its zeroed scratch
+	 * page rather than by the JIT's exception table entry, the access above
+	 * would have succeeded and written there. The page has to still be
+	 * unmapped, so that the read faults and gives 0.
+	 */
+	asm volatile (
+	"r1 = %[page];"
+	"r1 += 4096;"
+	"r1 = addr_space_cast(r1, 0x0, 0x1);"
+	"r3 = *(u64 *)(r1 + 0);"
+	"r2 = %[uaf_reread] ll;"
+	"r2 = addr_space_cast(r2, 0x0, 0x1);"
+	"*(u64 *)(r2 + 0) = r3;"
+	: : [page]"r"(page64),
+	    __imm_addr(uaf_reread)
+	: "r1", "r2", "r3", "memory");
 #endif
 
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_scalar.c b/tools/testing/selftests/bpf/progs/verifier_arena_scalar.c
index bebc37f501b7e..ecfc6873ffa95 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_scalar.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_scalar.c
@@ -7,6 +7,7 @@
 
 void *bpf_arena_alloc_pages(void *map, void *addr, __u32 page_cnt, int node_id,
 			    __u64 flags) __ksym;
+void bpf_arena_free_pages(void *map, void *ptr, __u32 page_cnt) __ksym;
 
 #ifdef __TARGET_ARCH_arm64
 #define ARENA_VM_START (1ull << 32)
@@ -35,6 +36,7 @@ struct {
 void __kfunc_btf_root(void)
 {
 	bpf_arena_alloc_pages(0, 0, 0, 0, 0);
+	bpf_arena_free_pages(0, 0, 0);
 }
 
 /* Tests start with r6 = address of a new page as the user space sees it, a number */
@@ -256,6 +258,260 @@ __naked void atomics(void)
 	: __clobber_all);
 }
 
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: fetching and/or/xor")
+__success __retval(0)
+__load_if_JITed()
+__naked void fetch_and_or_xor(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 1;						\
+	r4 = -1;					\
+	r5 = 0;						\
+	call %[bpf_arena_alloc_pages];			\
+	r6 = r0;					\
+	r0 = 100;					\
+	if r6 == 0 goto 9f;				\
+	r7 = 0x11000000110 ll;				\
+	*(u64 *)(r6 + 8) = r7;				\
+	r0 = r6;					\
+	r0 ^= 0x55;					\
+	r1 = 0x1100000011 ll;				\
+	.8byte %[fetch_or_dw]; /* r1 = atomic_fetch_or((u64 *)(r6 + 8), r1) */ \
+	r2 = r6;					\
+	r2 ^= 0x55;					\
+	if r0 == r2 goto 1f;				\
+	r0 = 99;					\
+	goto 9f;					\
+1:	r0 = 1;						\
+	if r1 != r7 goto 9f;				\
+	r7 = 0x11100000111 ll;				\
+	r1 = 0x11000000111 ll;				\
+	.8byte %[fetch_and_dw]; /* r1 = atomic_fetch_and((u64 *)(r6 + 8), r1) */ \
+	r0 = 2;						\
+	if r1 != r7 goto 9f;				\
+	r7 = 0x11000000111 ll;				\
+	r1 = 0x101 ll;					\
+	.8byte %[fetch_xor_dw]; /* r1 = atomic_fetch_xor((u64 *)(r6 + 8), r1) */ \
+	r0 = 3;						\
+	if r1 != r7 goto 9f;				\
+	r7 = 0x11000000010 ll;				\
+	r2 = *(u64 *)(r6 + 8);				\
+	r0 = 4;						\
+	if r2 != r7 goto 9f;				\
+	*(u32 *)(r6 + 16) = 0x110;			\
+	r1 = 0xdead000000000011 ll;			\
+	.8byte %[fetch_or_w]; /* r1 = atomic_fetch_or((u32 *)(r6 + 16), r1) */ \
+	r0 = 5;						\
+	if r1 != 0x110 goto 9f;				\
+	r1 = 0xdead000000000101 ll;			\
+	.8byte %[fetch_and_w]; /* r1 = atomic_fetch_and((u32 *)(r6 + 16), r1) */ \
+	r0 = 6;						\
+	if r1 != 0x111 goto 9f;				\
+	r1 = 0xdead000000000011 ll;			\
+	.8byte %[fetch_xor_w]; /* r1 = atomic_fetch_xor((u32 *)(r6 + 16), r1) */ \
+	r0 = 7;						\
+	if r1 != 0x101 goto 9f;				\
+	r2 = *(u32 *)(r6 + 16);				\
+	r0 = 8;						\
+	if r2 != 0x110 goto 9f;				\
+	r0 = 0;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm(bpf_arena_alloc_pages),
+	  __imm_insn(fetch_or_dw, BPF_ATOMIC_OP(BPF_DW, BPF_OR | BPF_FETCH,
+						BPF_REG_6, BPF_REG_1, 8)),
+	  __imm_insn(fetch_and_dw, BPF_ATOMIC_OP(BPF_DW, BPF_AND | BPF_FETCH,
+						 BPF_REG_6, BPF_REG_1, 8)),
+	  __imm_insn(fetch_xor_dw, BPF_ATOMIC_OP(BPF_DW, BPF_XOR | BPF_FETCH,
+						 BPF_REG_6, BPF_REG_1, 8)),
+	  __imm_insn(fetch_or_w, BPF_ATOMIC_OP(BPF_W, BPF_OR | BPF_FETCH,
+					       BPF_REG_6, BPF_REG_1, 16)),
+	  __imm_insn(fetch_and_w, BPF_ATOMIC_OP(BPF_W, BPF_AND | BPF_FETCH,
+						BPF_REG_6, BPF_REG_1, 16)),
+	  __imm_insn(fetch_xor_w, BPF_ATOMIC_OP(BPF_W, BPF_XOR | BPF_FETCH,
+						BPF_REG_6, BPF_REG_1, 16))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: fetching and/or/xor with the operand in r0")
+__success __retval(0)
+__load_if_JITed()
+__naked void fetch_and_or_xor_r0(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 1;						\
+	r4 = -1;					\
+	r5 = 0;						\
+	call %[bpf_arena_alloc_pages];			\
+	r6 = r0;					\
+	r0 = 100;					\
+	if r6 == 0 goto 9f;				\
+	r7 = 0x11000000110 ll;				\
+	*(u64 *)(r6 + 8) = r7;				\
+	r0 = 0x1100000011 ll;				\
+	.8byte %[fetch_or_dw]; /* r0 = atomic_fetch_or((u64 *)(r6 + 8), r0) */ \
+	r2 = r0;					\
+	r0 = 1;						\
+	if r2 != r7 goto 9f;				\
+	r7 = 0x11100000111 ll;				\
+	r0 = 0x11000000111 ll;				\
+	.8byte %[fetch_and_dw]; /* r0 = atomic_fetch_and((u64 *)(r6 + 8), r0) */ \
+	r2 = r0;					\
+	r0 = 2;						\
+	if r2 != r7 goto 9f;				\
+	r7 = 0x11000000111 ll;				\
+	r0 = 0x101 ll;					\
+	.8byte %[fetch_xor_dw]; /* r0 = atomic_fetch_xor((u64 *)(r6 + 8), r0) */ \
+	r2 = r0;					\
+	r0 = 3;						\
+	if r2 != r7 goto 9f;				\
+	r7 = 0x11000000010 ll;				\
+	r2 = *(u64 *)(r6 + 8);				\
+	r0 = 4;						\
+	if r2 != r7 goto 9f;				\
+	*(u32 *)(r6 + 16) = 0x110;			\
+	r0 = 0xdead000000000011 ll;			\
+	.8byte %[fetch_or_w]; /* r0 = atomic_fetch_or((u32 *)(r6 + 16), r0) */ \
+	r2 = r0;					\
+	r0 = 5;						\
+	if r2 != 0x110 goto 9f;				\
+	r0 = 0xdead000000000101 ll;			\
+	.8byte %[fetch_and_w]; /* r0 = atomic_fetch_and((u32 *)(r6 + 16), r0) */ \
+	r2 = r0;					\
+	r0 = 6;						\
+	if r2 != 0x111 goto 9f;				\
+	r0 = 0xdead000000000011 ll;			\
+	.8byte %[fetch_xor_w]; /* r0 = atomic_fetch_xor((u32 *)(r6 + 16), r0) */ \
+	r2 = r0;					\
+	r0 = 7;						\
+	if r2 != 0x101 goto 9f;				\
+	r2 = *(u32 *)(r6 + 16);				\
+	r0 = 8;						\
+	if r2 != 0x110 goto 9f;				\
+	r0 = 0;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm(bpf_arena_alloc_pages),
+	  __imm_insn(fetch_or_dw, BPF_ATOMIC_OP(BPF_DW, BPF_OR | BPF_FETCH,
+						BPF_REG_6, BPF_REG_0, 8)),
+	  __imm_insn(fetch_and_dw, BPF_ATOMIC_OP(BPF_DW, BPF_AND | BPF_FETCH,
+						 BPF_REG_6, BPF_REG_0, 8)),
+	  __imm_insn(fetch_xor_dw, BPF_ATOMIC_OP(BPF_DW, BPF_XOR | BPF_FETCH,
+						 BPF_REG_6, BPF_REG_0, 8)),
+	  __imm_insn(fetch_or_w, BPF_ATOMIC_OP(BPF_W, BPF_OR | BPF_FETCH,
+					       BPF_REG_6, BPF_REG_0, 16)),
+	  __imm_insn(fetch_and_w, BPF_ATOMIC_OP(BPF_W, BPF_AND | BPF_FETCH,
+						BPF_REG_6, BPF_REG_0, 16)),
+	  __imm_insn(fetch_xor_w, BPF_ATOMIC_OP(BPF_W, BPF_XOR | BPF_FETCH,
+						BPF_REG_6, BPF_REG_0, 16))
+	: __clobber_all);
+}
+
+/*
+ * The page is gone, so the access faults. The fetched register has to come back
+ * 0 and everything else has to be left alone, r0 included. Reading the address
+ * again has to give 0 as well: had the fault been recovered by the arena mapping
+ * its zeroed scratch page instead of by the JIT's exception table entry, the
+ * access would have succeeded and left a 1 there.
+ */
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: fetching or through a number to a freed page")
+__success __retval(0)
+__load_if_JITed()
+__naked void fetch_or_freed_page(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 1;						\
+	r4 = -1;					\
+	r5 = 0;						\
+	call %[bpf_arena_alloc_pages];			\
+	r6 = r0;					\
+	r0 = 100;					\
+	if r6 == 0 goto 9f;				\
+	*(u64 *)(r6 + 8) = 0x55;			\
+	r1 = %[arena] ll;				\
+	r2 = r6;					\
+	r3 = 1;						\
+	call %[bpf_arena_free_pages];			\
+	r0 = r6;					\
+	r0 ^= 0x55;					\
+	r1 = 1;						\
+	.8byte %[fetch_or_dw]; /* faults: r1 = atomic_fetch_or((u64 *)(r6 + 8), r1) */ \
+	r2 = r6;					\
+	r2 ^= 0x55;					\
+	if r0 == r2 goto 1f;				\
+	r0 = 1;						\
+	goto 9f;					\
+1:	r0 = 2;						\
+	if r1 != 0 goto 9f;				\
+	r3 = *(u64 *)(r6 + 8);				\
+	r0 = 3;						\
+	if r3 != 0 goto 9f;				\
+	r0 = 0;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm(bpf_arena_alloc_pages),
+	  __imm(bpf_arena_free_pages),
+	  __imm_insn(fetch_or_dw, BPF_ATOMIC_OP(BPF_DW, BPF_OR | BPF_FETCH,
+						BPF_REG_6, BPF_REG_1, 8))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: fetching or with the operand in r0 to a freed page")
+__success __retval(0)
+__load_if_JITed()
+__naked void fetch_or_r0_freed_page(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 1;						\
+	r4 = -1;					\
+	r5 = 0;						\
+	call %[bpf_arena_alloc_pages];			\
+	r6 = r0;					\
+	r0 = 100;					\
+	if r6 == 0 goto 9f;				\
+	*(u64 *)(r6 + 8) = 0x55;			\
+	r1 = %[arena] ll;				\
+	r2 = r6;					\
+	r3 = 1;						\
+	call %[bpf_arena_free_pages];			\
+	r0 = 1;						\
+	.8byte %[fetch_or_dw]; /* faults: r0 = atomic_fetch_or((u64 *)(r6 + 8), r0) */ \
+	r2 = r0;					\
+	r0 = 1;						\
+	if r2 != 0 goto 9f;				\
+	r3 = *(u64 *)(r6 + 8);				\
+	r0 = 2;						\
+	if r3 != 0 goto 9f;				\
+	r0 = 0;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm(bpf_arena_alloc_pages),
+	  __imm(bpf_arena_free_pages),
+	  __imm_insn(fetch_or_dw, BPF_ATOMIC_OP(BPF_DW, BPF_OR | BPF_FETCH,
+						BPF_REG_6, BPF_REG_0, 8))
+	: __clobber_all);
+}
+
 SEC("syscall")
 __arena_scalar
 __description("arena_scalar: cmpxchg through r0")
-- 
2.53.0-Meta

