Received: from mta0.migadu.com (out-63.mta0.migadu.com [91.218.175.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC11E353A91
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787343225; cv=none; b=Xj7TI8Z0MtUMBZnfpTqn1MTU4He/gHn5Ig5I1kentkrejxdYHPFn4VsGt8E0QxP3Wddcv7NrJ3v26AhP0MuCoKpj2JjiCN5Lari5cat2Ty8llsBdkML326Lde/LO8v0MtCJoPphVmJCHdAie9zGY+WPL1jHVrci7d+ha3AM36co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787343225; c=relaxed/simple;
	bh=iKijKYnLssRaQ2gxPKvqQxkfcSpityh01f3HQTzeyWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElTi9Du/CLZL//OCdLup+btYpoAge657oB2Z34m7hHuNj29C5tjBcsZEn5eUCRpjZtEa3tpLLudaeBvD6OT6bECvNYxe5a45zdm/R6xpVE+HqTOMVPrYXgGOr9qyB4bOBn4D/P91Y0iBvbEf5sOr43L0swwd0bHuv02DABQyZpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qW5Og/Dm; arc=none smtp.client-ip=91.218.175.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qW5Og/Dm"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=iKijKYnLssRaQ2gxPKvqQxkfcSpityh01f3HQTzeyWs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787343221; v=1; x=1787948021;
 b=qW5Og/DmGMk5YlInFt0+Vps2YCZWYOOWt/GHUit8uKVyfrTrUyJ1N4oYQwpkXxqVgtF/XDKR
 UpRcZ3dia5EMGkxOr7cRDi+IBhmg5TiU1CAJ5CFqDACx8H0ymkbNxeK4p0O/SeYKwDzuAdp0WPJ
 e1ctqbq9izKkdSQTepWTXNOg=
X-Envelope-To: bpf@vger.kernel.org
Received: from gvineet-fedora-PF5JGVFY (67.169.75.212)
	by smtp.migadu.com with ESMTPS id b507d4dc9a988011;
	Fri, 21 Aug 2026 20:13:40 +0000
X-Mizu-Trace-ID: b507d4dc9a988011
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Enable some of the blocked cpuv4 instruction tests for bpf-gcc
Date: Fri, 21 Aug 2026 13:13:16 -0700
Message-ID: <20260821201316.1059129-4-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821201316.1059129-1-vineet.gupta@linux.dev>
References: <20260821201316.1059129-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A bunch of tests are gated behind clang only __clang_major__ and thus
fail to build under BPF_GCC. What's worse is, before the prev patch they
were also declared as passing/OK.

This need not be because (a) bpf-gcc does support the feature in codegen
and (b) also advertises correctly with feature support preprocessor macros:

  __BPF_FEATURE_BSWAP, __BPF_FEATURE_GOTOL, __BPF_FEATURE_LDSX,
  __BPF_FEATURE_MOVSX, __BPF_FEATURE_SDIV_SMOD, __BPF_FEATURE_ST

So loosen up the gates to also add specific feature check.
clang >=18 has to stay, despite it being true for so long: clang only
defines __BPF_FEATURE_MOVSX and friends at -mcpu=v4, but assembles the
inline asm at -mcpu=v3 too, and dropping it would remove these tests from
the default test_progs flavour where they run today.

Since bpf-gcc doesn't support addr_space_cast, wrap the corresponding
tests under __BPF_FEATURE_ADDR_SPACE_CAST to skip under it.
And also move the map under that guard so that a bpf-gcc object does not
declare an arena map that no program in it references.

Recovered under BPF_GCC (programs per object, was 1 dummy each):

  verifier_sdiv    80
  verifier_movsx   17
  verifier_ldsx    14   (20 under clang; 5 arena tests,
                       kfunc_root and the arena map stay clang-only)
  verifier_bswap   13

CAN_USE_GOTOL and CAN_USE_BPF_ST only gate parts of a file, so those were
not dummies to begin with:

  compute_live_registers        17 -> 19  (21 under clang)
  verifier_gotol                 1 -> 2
  verifier_iterating_callbacks  34 -> 35

The clang builds are unchanged: verifier_ldsx still emits 20 programs under
the cpuv4 flavour.

One thing left alone: verifier_load_acquire.c and verifier_store_release.c
stay clang-only, and their gates are correct as gas doesn't implement
those (experimental -mxbpf not implemented at all). FWIW LLVM groups
those under -mcpu=v4 and defines __BPF_FEATURE_LOAD_ACQ_STORE_REL there.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h   |  4 ++--
 .../bpf/progs/compute_live_registers.c         |  7 +++++++
 .../selftests/bpf/progs/verifier_bswap.c       |  2 +-
 .../selftests/bpf/progs/verifier_ldsx.c        | 18 +++++++++++-------
 .../selftests/bpf/progs/verifier_movsx.c       |  2 +-
 .../selftests/bpf/progs/verifier_sdiv.c        |  2 +-
 6 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 88b0bfba83bb..eb88d9ce6c34 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -261,11 +261,11 @@
      (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) ||		\
      defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) ||	\
      defined(__TARGET_ARCH_loongarch)) &&				\
-	__clang_major__ >= 18
+	(__clang_major__ >= 18 || defined(__BPF_FEATURE_GOTOL))
 #define CAN_USE_GOTOL
 #endif
 
-#if __clang_major__ >= 18
+#if __clang_major__ >= 18 || defined(__BPF_FEATURE_ST)
 #define CAN_USE_BPF_ST
 #endif
 
diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
index 338e67cd8856..c7d5a0abff2c 100644
--- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
+++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
@@ -299,7 +299,14 @@ __naked void gotol(void)
 		"r3 = 24;"
 		"if r1 > 0x7 goto +2;"
 		"r0 = r2;"
+#ifdef __clang__
 		"gotol +1;"
+#else
+		/* gas mis-parses 'gotol +1' as 'goto l+1', same encoding
+		 * without the sign (binutils PR gas/34558).
+		 */
+		"gotol 1;"
+#endif
 		"r0 = r3;"
 		"exit;"
 		:
diff --git a/tools/testing/selftests/bpf/progs/verifier_bswap.c b/tools/testing/selftests/bpf/progs/verifier_bswap.c
index 074faef5480e..48ffb5b242d2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bswap.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bswap.c
@@ -8,7 +8,7 @@
 	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || \
 	defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
 	defined(__TARGET_ARCH_loongarch)) && \
-	__clang_major__ >= 18
+	(__clang_major__ >= 18 || defined(__BPF_FEATURE_BSWAP))
 
 SEC("socket")
 __description("BSWAP, 16")
diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
index e58ea69e3854..75762e11b443 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -9,13 +9,7 @@
 	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || \
 	defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
 	defined(__TARGET_ARCH_loongarch)) && \
-	__clang_major__ >= 18
-
-struct {
-	__uint(type, BPF_MAP_TYPE_ARENA);
-	__uint(map_flags, BPF_F_MMAPABLE);
-	__uint(max_entries, 1);
-} arena SEC(".maps");
+	(__clang_major__ >= 18 || defined(__BPF_FEATURE_LDSX))
 
 SEC("socket")
 __description("LDSX, S8")
@@ -263,6 +257,14 @@ __naked void ldsx_ctx_8(void)
 	: __clobber_all);
 }
 
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1);
+} arena SEC(".maps");
+
 SEC("syscall")
 __description("Arena LDSX Disasm")
 __success
@@ -432,6 +434,8 @@ void kfunc_root(void)
 	bpf_arena_alloc_pages(0, 0, 0, 0, 0);
 }
 
+#endif /* __BPF_FEATURE_ADDR_SPACE_CAST */
+
 #else
 
 SEC("socket")
diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/testing/selftests/bpf/progs/verifier_movsx.c
index 5559c0583dd1..195b27a51224 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -8,7 +8,7 @@
 	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || \
 	defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
 	defined(__TARGET_ARCH_loongarch)) && \
-	__clang_major__ >= 18
+	(__clang_major__ >= 18 || defined(__BPF_FEATURE_MOVSX))
 
 SEC("socket")
 __description("MOV32SX, S8")
diff --git a/tools/testing/selftests/bpf/progs/verifier_sdiv.c b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
index 515644ace516..d6cbe1e27fd6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sdiv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
@@ -9,7 +9,7 @@
 	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || \
 	defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
 	defined(__TARGET_ARCH_loongarch)) && \
-	__clang_major__ >= 18
+	(__clang_major__ >= 18 || defined(__BPF_FEATURE_SDIV_SMOD))
 
 SEC("socket")
 __description("SDIV32, non-zero imm divisor, check 1")
-- 
2.53.0-Meta

