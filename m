Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793145877;
	b=moZjv+mMW2/KMroPYUCxpcRXzxeiGys3w2tCJds/xzn5fMZQcdOaJZDu8dRH5w5mgQ8m
	 Kl4MH/sY1hyVvaxMZGuX8kzMFer0XqoS9hb4iVqfuRuvw7bDXmZalA6JDiq6tBXN5kDgM
	 bUE/+qmjF3/Mw6njRj106NmGaqPyJ8vKOOgBK0sL6mgAoNxFaotYCc0suw+LU+02DRLs4
	 8RTROllPUAuzbUP+F/67fNhvqBmezmt6WtT6YLSUZbvAOohBGjustmH4Rx2R19iYZBMyA
	 FRUhvVRMY+277vGLYeSkANglGtUS4dNuuye4Ue3mV3R+6oAk8bRpo2fsQ1naxJp7D3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793145877;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=hL7+ZwtKr2IcHVKvmMWg/XEq/ceZwQuT1G7zrIVUNRg=;
	b=MYB4yrSfCoDOx8SeMq7isB8XeEvqHwEh8cxpLmsZASo1VR6Hj9v9ifxi7XHWwOQJXcu0
	 qvPfbQNOYKHg3XbMO6boI0GtcNSolg3V4zM1T0B4fscbJVooMo5jJ1v2K6kpXgmtVmYn+
	 FPN4OCpvjvfUt3a/WqmD8eV/fJVfvRbd9Ng1TCEzx6klWAiljPwG4obSCilbrjAF72dP8
	 vyfnl//wJDKdEr82PmjFojz4EOjvgQY5adwMdeVLZvOgYcciUhy7WQ23nR/IYO1FdmkH4
	 hH/5SZFkr7GW1Y6KaZdQSNfHi2NP3Jf+OPYjjpebbm9zi6x4q9l9mk3+BsPgtIKmRVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lo0uH7Po;
	arc=none smtp.remote-ip=91.218.175.229
Received: from mta0.migadu.com (out-229.mta0.migadu.com [91.218.175.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD3606A31E
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 00:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EBD3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lo0uH7Po
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3scEEBr+wkqFk/2UiQK9j8vjUCwxDCaoPzf1mtkcNLg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793145874; v=1; x=1793750674;
 b=lo0uH7PodoF2qcKdW5A68YJoOVXiTzPJuCe+x3fvLOhlI9HSikegD8EquYpZLn7WmV+xruER
 R5PNcK3JZQQoEj/3X6TR9NSk2eNe/6hlUFbkw1j+BJ9gkmBcJ9b/AyvA2EcvP26TQYiRnOHSNYl
 ENUCLW7I6o7JOvz6BgwmuVHQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2f01dc5dbfce6ce0;
	Wed, 28 Oct 2026 00:04:34 +0000
X-Mizu-Trace-ID: 2f01dc5dbfce6ce0
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jose.marchesi@oracle.com,
	david.faust@oss.qualcomm.com,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next v1 1/7] selftests/bpf: Build callx tests with GCC that defines __BPF_FEATURE_CALLX
Date: Tue, 27 Oct 2026 17:04:05 -0700
Message-ID: <20261028000411.4010967-2-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7cd1f73b37ea ("selftests/bpf: Fix build of callx tests with GCC")
gated the callx progs on __clang__. GCC had indirect call support which was
recently refurbished along with a __BPF_FEATURE_CALLX macro [1], so gate
on that as well so once this GCC is released, the tests start passing.

Put the arch and compiler conditions in a CAN_USE_CALLX macro in
bpf_misc.h, and use it all the test programs.

While at it, mark the placeholder programs left for unsupported
toolchains and arches with __skip(), so they report SKIP rather than OK.

[1] https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=ffe3ead4a8ad704b557b0cfa4f823df647c65a0d

Measured on bpf-next with a stock bpf-gcc that defines
__BPF_FEATURE_CALLX, test_progs before and after: 76 subtests run that
previously did not exist in the report, 75 OK and one @unpriv SKIP,
with no failures.  The two dummy placeholders retire and
callx_rodata_lskel goes SKIP -> OK.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 .../testing/selftests/bpf/prog_tests/callx_rodata_lskel.c  | 2 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h               | 7 +++++++
 tools/testing/selftests/bpf/progs/callx_rodata.c           | 4 ++--
 tools/testing/selftests/bpf/progs/verifier_callx.c         | 5 ++---
 tools/testing/selftests/bpf/progs/verifier_callx_rodata.c  | 5 ++---
 5 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c b/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
index f6ef67c3141e..acd821fb568f 100644
--- a/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
+++ b/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
@@ -36,7 +36,7 @@ static void __test_callx_rodata_lskel(void)
 	if (!ASSERT_OK_PTR(skel, "open"))
 		return;
 
-	/* gcc doesn't support indirect calls */
+	/* toolchain or JIT can't do callx */
 	if (skel->rodata->skip) {
 		test__skip();
 		goto out;
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index d7f706c3bc4a..1b264480e128 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -295,6 +295,13 @@
 #define CAN_USE_LOAD_ACQ_STORE_REL
 #endif
 
+/* clang always emits callx, gcc only when it defines __BPF_FEATURE_CALLX */
+#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||	\
+     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) &&		\
+	(defined(__clang__) || defined(__BPF_FEATURE_CALLX))
+#define CAN_USE_CALLX
+#endif
+
 #if defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86)
 #define SPEC_V1
 #endif
diff --git a/tools/testing/selftests/bpf/progs/callx_rodata.c b/tools/testing/selftests/bpf/progs/callx_rodata.c
index e3f8335f80f8..8c28f01b7113 100644
--- a/tools/testing/selftests/bpf/progs/callx_rodata.c
+++ b/tools/testing/selftests/bpf/progs/callx_rodata.c
@@ -4,13 +4,14 @@
 #include <stdbool.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 /* set by user space before the programs are loaded, it's in .rodata too */
 const volatile int bias = 1;
 
 int op_idx;
 
-#ifdef __clang__
+#ifdef CAN_USE_CALLX
 
 const volatile bool skip = false;
 
@@ -48,7 +49,6 @@ int both_ops(void *ctx)
 
 #else
 
-/* gcc doesn't support indirect calls */
 const volatile bool skip = true;
 
 SEC("socket")
diff --git a/tools/testing/selftests/bpf/progs/verifier_callx.c b/tools/testing/selftests/bpf/progs/verifier_callx.c
index 7e59188d9fca..a87e2a85f43d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_callx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_callx.c
@@ -6,9 +6,7 @@
 #include "bpf_misc.h"
 #include "../../../include/linux/filter.h"
 
-/* gcc doesn't support indirect calls */
-#if defined(__clang__) && (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
-    (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64))
+#ifdef CAN_USE_CALLX
 
 #define CALLX_INSN(DST, SRC, OFF, IMM) \
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL | BPF_X, DST, SRC, OFF, IMM)
@@ -1075,6 +1073,7 @@ int callx_c_ops_on_stack(void *ctx)
 #else
 
 SEC("socket")
+__skip("callx needs x86/arm64 JIT and compiler support")
 __success
 int dummy(void *ctx)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
index 6cf58ca9ac5b..29bc2f78315d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
+++ b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
@@ -6,9 +6,7 @@
 #include "bpf_misc.h"
 #include "../../../include/linux/filter.h"
 
-/* gcc doesn't support indirect calls */
-#if defined(__clang__) && (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
-    (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64))
+#ifdef CAN_USE_CALLX
 
 /*
  * Read-only data with pointers to functions, where the compiler puts tables
@@ -892,6 +890,7 @@ int callx_c_packed_struct(void *ctx)
 #else
 
 SEC("socket")
+__skip("callx needs x86/arm64 JIT and compiler support")
 __success
 int dummy(void *ctx)
 {
-- 
2.53.0-Meta

