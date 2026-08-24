Received: from mta1.migadu.com (out-128.mta1.migadu.com [95.215.58.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0523E34D4CE
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 21:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787605329; cv=none; b=WnbDp3wTwV0ATWsqI72i1TYJiKoM2bObRfwcB/565YUc1KO4LrLBCQQEwawSlXN0Tv0kvlSD6aI+7Qisf67IySB07BZFQJVSEQ5rjD+MeauZ9XwYb+2EMmwPC7gb808HgVUn/he94M9AQeSti+YIqbavy8A06UhBg6Mbe38uI10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787605329; c=relaxed/simple;
	bh=HvRwy++BN6qNxPpdtGXIxKsMcYXxCSTwGQlQR4/g+2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKeGNshu8sdYn4Zyfc9UW57r5+1wOBYchjkbUEBLUQPXqGxmc45Bj9COZn9CzxDQoJdWfjaV1mkeUwGwbxbe3aAGkF0FMcqAgO3X9W+TplH1GuyscO+7c50lEMOe/fAtapeZ1cYy/tg3ro/Jl4zkhIe8UlsHBIpEyp49Ix1fZwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XZcXwy7D; arc=none smtp.client-ip=95.215.58.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XZcXwy7D"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HvRwy++BN6qNxPpdtGXIxKsMcYXxCSTwGQlQR4/g+2Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787605324; v=1; x=1788210124;
 b=XZcXwy7DW4INIlCikZL7DsHpCAWrJ3SOV7/Zaf0cVVq8a2lz4zxIALBCiFzQTXdq/w7L7tRn
 T6GsMH67Tk4NUh/4WQOa5GS/2qOXFbqa5lKOcw+EBDePQT92dinJ9ECZ19Z3Q5LeBhkrbJjjeEn
 ySRG7DbzKST8+Z9jMaDHRyaw=
X-Envelope-To: bpf@vger.kernel.org
Received: from gvineet-fedora-PF5JGVFY.thefacebook.com (2620:10d:c090:500::4:2c42)
	by smtp.migadu.com with ESMTPS id 1c2d6e0722264665;
	Mon, 24 Aug 2026 21:02:04 +0000
X-Mizu-Trace-ID: 1c2d6e0722264665
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: Vineet Gupta <vineet.gupta@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: report placeholder tests as SKIP, not OK
Date: Mon, 24 Aug 2026 14:01:41 -0700
Message-ID: <20260824210142.3933580-3-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824210142.3933580-1-vineet.gupta@linux.dev>
References: <20260824210142.3933580-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several verifier test files wrap their contents in a feature gate and provide
a one-line placeholder program in the #else arm, so the file still yields
something when the toolchain or JIT cannot support the tested instructions.

However the placeholder is annotated __success, so it reports as a pass,
whereas this is really a SKIP.

|  #318/1   verifier_ldsx/cpuv4 is not supported by compiler or jit, ...:OK
|  #318     verifier_ldsx:OK

This causes skipped coverage to be overlooked: see the next patch where
BPF_GCC builds miss a whole bunch of test due to clang only gate.

Add a __skip("reason") annotation for a compile-time gate, and use it for the
placeholders.

After this change, above tests reported as

|  #318/1   verifier_ldsx/cpuv4 is not supported by compiler or jit, ...:SKIP
|  #318     verifier_ldsx:SKIP

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/arena_kfunc.c          | 1 +
 tools/testing/selftests/bpf/progs/bpf_misc.h             | 6 ++++++
 tools/testing/selftests/bpf/progs/stack_arg_fail.c       | 1 +
 tools/testing/selftests/bpf/progs/stack_arg_precision.c  | 1 +
 .../testing/selftests/bpf/progs/verifier_aggregate_ret.c | 1 +
 tools/testing/selftests/bpf/progs/verifier_bswap.c       | 1 +
 tools/testing/selftests/bpf/progs/verifier_gotol.c       | 1 +
 tools/testing/selftests/bpf/progs/verifier_ldsx.c        | 1 +
 .../testing/selftests/bpf/progs/verifier_load_acquire.c  | 1 +
 tools/testing/selftests/bpf/progs/verifier_movsx.c       | 1 +
 tools/testing/selftests/bpf/progs/verifier_percpu_addr.c | 1 +
 .../testing/selftests/bpf/progs/verifier_private_stack.c | 1 +
 tools/testing/selftests/bpf/progs/verifier_sdiv.c        | 1 +
 tools/testing/selftests/bpf/progs/verifier_stack_arg.c   | 1 +
 .../selftests/bpf/progs/verifier_stack_arg_order.c       | 1 +
 .../testing/selftests/bpf/progs/verifier_store_release.c | 1 +
 tools/testing/selftests/bpf/test_loader.c                | 9 +++++++++
 17 files changed, 30 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/testing/selftests/bpf/progs/arena_kfunc.c
index 47bed5c4c488..50609f3b0564 100644
--- a/tools/testing/selftests/bpf/progs/arena_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c
@@ -233,6 +233,7 @@ SEC("syscall")
 __arch_x86_64
 __arch_arm64
 __description("arena_arg_stack: not supported, dummy test")
+__skip("arena_arg_stack: not supported")
 __success
 int dummy_test(void *ctx)
 {
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 5eacf1b43252..88b0bfba83bb 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -106,6 +106,11 @@
  * __description     Text to be used for display and as an additional filter
  *                   alias, while the original program name stays matchable.
  *
+ * __skip            Report the test as SKIP with the given reason instead of
+ *                   running it. For placeholder programs that stand in for a
+ *                   feature the toolchain or JIT cannot provide, so a run does
+ *                   not report OK for coverage it never executed.
+ *
  * __log_level       Log level to use for the program, numeric value expected.
  *
  * __flag            Adds one flag use for the program, the following values are valid:
@@ -139,6 +144,7 @@
 #define __failure		__test_tag("test_expect_failure")
 #define __success		__test_tag("test_expect_success")
 #define __description(desc)	__test_tag("test_description=" desc)
+#define __skip(reason)		__test_tag("test_skip=" reason)
 #define __msg_unpriv(msg)	__test_tag("test_expect_msg_unpriv=" msg)
 #define __not_msg_unpriv(msg)	__test_tag("test_expect_not_msg_unpriv=" msg)
 #define __xlated_unpriv(msg)	__test_tag("test_expect_xlated_unpriv=" msg)
diff --git a/tools/testing/selftests/bpf/progs/stack_arg_fail.c b/tools/testing/selftests/bpf/progs/stack_arg_fail.c
index 6f6f59306d0e..eed97d582515 100644
--- a/tools/testing/selftests/bpf/progs/stack_arg_fail.c
+++ b/tools/testing/selftests/bpf/progs/stack_arg_fail.c
@@ -103,6 +103,7 @@ __naked void r11_store_zero_off(void)
 
 SEC("tc")
 __description("stack_arg_fail: not supported, dummy test")
+__skip("stack_arg_fail: not supported")
 __success
 int dummy_test(struct __sk_buff *skb)
 {
diff --git a/tools/testing/selftests/bpf/progs/stack_arg_precision.c b/tools/testing/selftests/bpf/progs/stack_arg_precision.c
index bee2eeec021d..ce0301a41fa9 100644
--- a/tools/testing/selftests/bpf/progs/stack_arg_precision.c
+++ b/tools/testing/selftests/bpf/progs/stack_arg_precision.c
@@ -124,6 +124,7 @@ __naked void stack_arg_precision_bpf2bpf(void)
 
 SEC("socket")
 __description("stack_arg_precision: not supported, dummy test")
+__skip("stack_arg_precision: not supported")
 __success
 int dummy_test(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_aggregate_ret.c b/tools/testing/selftests/bpf/progs/verifier_aggregate_ret.c
index 7851bade2b40..f5c1166027a1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_aggregate_ret.c
+++ b/tools/testing/selftests/bpf/progs/verifier_aggregate_ret.c
@@ -167,6 +167,7 @@ int aggregate_ret_kfunc_struct_c_test(struct __sk_buff *skb)
 
 SEC("socket")
 __description("verifier_aggregate_ret: needs LLVM 23, dummy test")
+__skip("needs LLVM 23")
 __success
 int dummy_test(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_bswap.c b/tools/testing/selftests/bpf/progs/verifier_bswap.c
index cffaf36192bc..074faef5480e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bswap.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bswap.c
@@ -117,6 +117,7 @@ l0_%=:							\
 
 SEC("socket")
 __description("cpuv4 is not supported by compiler or jit, use a dummy test")
+__skip("cpuv4 is not supported by compiler or jit")
 __success
 int dummy_test(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_gotol.c b/tools/testing/selftests/bpf/progs/verifier_gotol.c
index d5d8f24df394..c0fd30a3a4c1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotol.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotol.c
@@ -52,6 +52,7 @@ __naked void gotol_large_imm(void)
 
 SEC("socket")
 __description("cpuv4 is not supported by compiler or jit, use a dummy test")
+__skip("cpuv4 is not supported by compiler or jit")
 __success
 int dummy_test(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
index 41340877dc9d..e58ea69e3854 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -436,6 +436,7 @@ void kfunc_root(void)
 
 SEC("socket")
 __description("cpuv4 is not supported by compiler or jit, use a dummy test")
+__skip("cpuv4 is not supported by compiler or jit")
 __success
 int dummy_test(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_load_acquire.c b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
index d17026d7480d..bcc34e798c63 100644
--- a/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
+++ b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
@@ -267,6 +267,7 @@ __naked void load_acquire_with_invalid_reg(void)
 
 SEC("socket")
 __description("Clang version < 18, ENABLE_ATOMICS_TESTS not defined, and/or JIT doesn't support load-acquire, use a dummy test")
+__skip("Clang version < 18, ENABLE_ATOMICS_TESTS not defined, and/or JIT doesn't support load-acquire")
 __success
 int dummy_test(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/testing/selftests/bpf/progs/verifier_movsx.c
index a4d8814eb5ed..5559c0583dd1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -343,6 +343,7 @@ label_%=: 	                                        \
 
 SEC("socket")
 __description("cpuv4 is not supported by compiler or jit, use a dummy test")
+__skip("cpuv4 is not supported by compiler or jit")
 __success
 int dummy_test(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c b/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c
index 967f4e6e3a49..fd418f27996f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c
@@ -61,6 +61,7 @@ __naked void percpu_addr(void)
 
 SEC("raw_tp")
 __description("percpu addr dummy")
+__skip("percpu addr tests need x86")
 __success
 int dummy_test(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index ea0a7e73331d..3d9994a52464 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -377,6 +377,7 @@ int private_stack_max_depth(void)
 
 SEC("kprobe")
 __description("private stack is not supported, use a dummy test")
+__skip("private stack is not supported")
 __success
 int dummy_test(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_sdiv.c b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
index 95f3239ce228..515644ace516 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sdiv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
@@ -1271,6 +1271,7 @@ __naked void smod32_int_min_mod_neg2_imm(void)
 
 SEC("socket")
 __description("cpuv4 is not supported by compiler or jit, use a dummy test")
+__skip("cpuv4 is not supported by compiler or jit")
 __success
 int dummy_test(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
index 7e0ce5db28a0..51d22faf4559 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -436,6 +436,7 @@ __naked void stack_arg_sequential_calls(void)
 
 SEC("socket")
 __description("stack_arg is not supported by compiler or jit, use a dummy test")
+__skip("stack_arg is not supported by compiler or jit")
 __success
 int dummy_test(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
index c9fe4857da3f..8e4325273b3d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
@@ -174,6 +174,7 @@ __naked void stack_arg_read_without_write_2(void)
 
 SEC("socket")
 __description("stack_arg order is not supported by compiler or jit, use a dummy test")
+__skip("stack_arg order is not supported by compiler or jit")
 __success
 int dummy_test(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_store_release.c b/tools/testing/selftests/bpf/progs/verifier_store_release.c
index 72f1eb006074..0abbee5ce109 100644
--- a/tools/testing/selftests/bpf/progs/verifier_store_release.c
+++ b/tools/testing/selftests/bpf/progs/verifier_store_release.c
@@ -290,6 +290,7 @@ __naked void store_release_with_invalid_reg(void)
 
 SEC("socket")
 __description("Clang version < 18, ENABLE_ATOMICS_TESTS not defined, and/or JIT doesn't support store-release, use a dummy test")
+__skip("Clang version < 18, ENABLE_ATOMICS_TESTS not defined, and/or JIT doesn't support store-release")
 __success
 int dummy_test(void)
 {
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 07807757b518..794a7dfb0579 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -70,6 +70,7 @@ struct test_spec {
 	int arch_mask;
 	int load_mask;
 	int linear_sz;
+	const char *skip_reason;
 	bool auxiliary;
 	bool valid;
 };
@@ -456,6 +457,8 @@ static int parse_test_spec(struct test_loader *tester,
 			continue;
 		if ((val = str_has_pfx(s, "test_description="))) {
 			description = val;
+		} else if ((val = str_has_pfx(s, "test_skip="))) {
+			spec->skip_reason = val;
 		} else if (strcmp(s, "test_expect_failure") == 0) {
 			spec->priv.expect_failure = true;
 			spec->mode_mask |= PRIV;
@@ -1327,6 +1330,12 @@ void run_subtest(struct test_loader *tester,
 	if (!test__start_subtest_with_desc(subspec->name, subspec->description))
 		return;
 
+	if (spec->skip_reason) {
+		printf("%s:SKIP: %s\n", __func__, spec->skip_reason);
+		test__skip();
+		return;
+	}
+
 	if ((get_current_arch() & spec->arch_mask) == 0) {
 		test__skip();
 		return;
-- 
2.53.0-Meta

