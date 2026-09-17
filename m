Received: from zju.edu.cn (gw.zju.edu.cn [210.32.2.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875C13BED23
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 04:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.32.2.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618781; cv=none; b=eX2iwITn8sISAS9lPMVPqBu9aTwLGDuNZ48NFMBHy/gUqaKQFG5PxfES717DmRJmKhMYxsPwH1ZDVRc29KdT6ofu42S2Xg4/JrCkjQ96SqTJMWxGOhueYzMTlMLivAa87jiZOytGGTXtU9XXrNv2I5z0bMO0xb3cHbc7M2IkF6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618781; c=relaxed/simple;
	bh=dFDdPU9IBPl0P3saPerTLdSXEBGOBR7Uyh5jhRXS6/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gELFBbJLYysV29TgCoZTTfrv1t47+e/0iDcE3MROcjpVlHi9bdWyoGVBPQWsi9EC155au2Qc1WVKlshfTR8PvskZYqYlvJLtJvSFPYLyBj3kB57plEU7nOKmd3XHflNVHb5vTPKeI4GjSfD/MiMOxA94e//oLdXD1Rw1VDwbZd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=210.32.2.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wCnr3_baatqqBMdAQ--.3639S3;
	Thu, 17 Sep 2026 12:17:31 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.163.215])
	by mail-app1 (Coremail) with SMTP id yy_KCgDnNZ7aaatqMOuJBA--.2471S2;
	Thu, 17 Sep 2026 12:17:30 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com,
	ziye@zju.edu.cn
Subject: [PATCH bpf-next 8/8] selftests/bpf: Add bytecode tests for UHMUL and SHMUL
Date: Thu, 17 Sep 2026 12:17:12 +0800
Message-ID: <20260917041712.1860722-9-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917041712.1860722-1-tangyazhou@zju.edu.cn>
References: <20260917041712.1860722-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgDnNZ7aaatqMOuJBA--.2471S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAhARCmqq8RoVYwAAsU
X-CM-DELIVERINFO: =?B?LwXM6AXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9IM9FLVg81ZTWd+DT36CLxXi/ioJprkDrAwKUew90oS5BeFAAQQB6aPIDRulkMa2wCoF
	tLTWbgyQtKrfKrYlnCY3NCygyy0DcDqL8oFc71ucgwcI61zhOrzFs5A0wFcIJQ==
X-Coremail-Antispam: 1Uk129KBj9fXoW3tr1DJr45ur17AryrGw18tFc_yoW8Jr15Xo
	W7ua17tr45KF1Y9aySkFsayFW7ur4IkayrJrWkG3WUXF97Ar1Yy340kw4xtr4q9r1q9as5
	Xa47Z3Wava15JF1kl-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYX7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjcxG0xvY0x
	0EwIxGrVCF72vEw4AK0wACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jjpBfUUUUU=

From: Yazhou Tang <tangyazhou518@outlook.com>

Add test_progs coverage for UHMUL and SHMUL with the following changes:

1. Add arithmetic execution tests in verifier_hmul.c and register the new
   test suite with the verifier test runner:
   - Gate the execution cases on x86, arm64, and RV64, matching the JIT support
     added in this series, and provide a dummy program for other targets.
   - Inject only UHMUL and SHMUL as raw .8byte values built with
     BPF_RAW_INSN(), while keeping the surrounding instructions in the
     existing assembly syntax. This avoids requiring assembler support
     for the new mnemonics.
   - Exercise register and immediate sources, signed and unsigned boundary
     values, negative immediate sign extension, and R0, R1, and R3
     destinations. The R3 case covers the x86 JIT path where BPF R3 aliases
     the implicit RDX result register. Run these cases in both privileged
     and unprivileged modes.
   - BPF_PROG_TEST_RUN exposes only the low 32 bits of R0 as its return
     value, so a direct __retval() check cannot validate the upper 32 bits.
     Build a 64-bit mismatch mask as actual ^ expected, then fold it to
     32 bits as (u32)mismatch | (u32)(mismatch >> 32) and return the folded
     value through R0. The return value is zero if and only if the complete
     64-bit result matches the expected value.

2. Add arena pointer rejection tests in verifier_hmul.c. Use an arena
   pointer as the destination of UHMUL and as the source of SHMUL, and
   verify that the verifier rejects both programs.

3. Extend the illegal instruction encoding tests in verifier_value_illegal_alu.c.
   Check reserved MUL offsets and UHMUL and SHMUL encodings in the BPF_ALU
   class, reusing the existing DEFINE_BAD_OFFSET_TEST() macro.

Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_hmul.c       | 284 ++++++++++++++++++
 .../bpf/progs/verifier_value_illegal_alu.c    |   9 +-
 3 files changed, 294 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_hmul.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 7732df9bc870..bf5d9b140c45 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -51,6 +51,7 @@
 #include "verifier_helper_packet_access.skel.h"
 #include "verifier_helper_restricted.skel.h"
 #include "verifier_helper_value_access.skel.h"
+#include "verifier_hmul.skel.h"
 #include "verifier_int_ptr.skel.h"
 #include "verifier_iterating_callbacks.skel.h"
 #include "verifier_jeq_infer_not_null.skel.h"
@@ -217,6 +218,7 @@ void test_verifier_helper_access_var_len(void) { RUN(verifier_helper_access_var_
 void test_verifier_helper_packet_access(void) { RUN(verifier_helper_packet_access); }
 void test_verifier_helper_restricted(void)    { RUN(verifier_helper_restricted); }
 void test_verifier_helper_value_access(void)  { RUN(verifier_helper_value_access); }
+void test_verifier_hmul(void)                 { RUN(verifier_hmul); }
 void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
 void test_verifier_iterating_callbacks(void)  { RUN(verifier_iterating_callbacks); }
 void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_hmul.c b/tools/testing/selftests/bpf/progs/verifier_hmul.c
new file mode 100644
index 000000000000..197ceac3b798
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_hmul.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <limits.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../../../include/linux/filter.h"
+
+#define BPF_UHMUL64_REG(DST, SRC) \
+	BPF_RAW_INSN(BPF_ALU64 | BPF_MUL | BPF_X, DST, SRC, \
+		     BPF_MUL_VARIANT_UHMUL, 0)
+
+#define BPF_UHMUL64_IMM(DST, IMM) \
+	BPF_RAW_INSN(BPF_ALU64 | BPF_MUL | BPF_K, DST, 0, \
+		     BPF_MUL_VARIANT_UHMUL, IMM)
+
+#define BPF_SHMUL64_REG(DST, SRC) \
+	BPF_RAW_INSN(BPF_ALU64 | BPF_MUL | BPF_X, DST, SRC, \
+		     BPF_MUL_VARIANT_SHMUL, 0)
+
+#define BPF_SHMUL64_IMM(DST, IMM) \
+	BPF_RAW_INSN(BPF_ALU64 | BPF_MUL | BPF_K, DST, 0, \
+		     BPF_MUL_VARIANT_SHMUL, IMM)
+
+/*
+ * Inject UHMUL/SHMUL as raw instructions so these tests do not require
+ * assembler support for the new mnemonics. All surrounding instructions use
+ * existing BPF assembly syntax supported by the baseline selftests toolchain.
+ */
+
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1);
+} arena SEC(".maps");
+
+SEC("syscall")
+__description("UHMUL64 with arena pointer dst")
+__failure __msg("UHMUL/SHMUL with arena pointers are not supported")
+__naked void uhmul64_arena_ptr(void)
+{
+	asm volatile (
+	"r1 = %[arena] ll;"
+	"r0 = 1;"
+	"r0 = addr_space_cast(r0, 0x0, 0x1);"
+	".8byte %[hmul];"
+	"exit;"
+	:
+	: __imm_addr(arena),
+	  __imm_insn(hmul, BPF_UHMUL64_IMM(BPF_REG_0, 2))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("SHMUL64 with arena pointer src")
+__failure __msg("UHMUL/SHMUL with arena pointers are not supported")
+__naked void shmul64_arena_ptr(void)
+{
+	asm volatile (
+	"r1 = %[arena] ll;"
+	"r1 = 1;"
+	"r1 = addr_space_cast(r1, 0x0, 0x1);"
+	"r0 = 2;"
+	".8byte %[hmul];"
+	"exit;"
+	:
+	: __imm_addr(arena),
+	  __imm_insn(hmul, BPF_SHMUL64_REG(BPF_REG_0, BPF_REG_1))
+	: __clobber_all);
+}
+
+#endif
+
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
+	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)
+
+/*
+ * BPF_PROG_TEST_RUN reports a 32-bit retval. Fold both halves of
+ * (actual ^ expected) into w0 so retval == 0 checks the full 64-bit result.
+ */
+
+SEC("socket")
+__description("UHMUL64, U64_MAX * U64_MAX, register source")
+__success __success_unpriv __retval(0)
+__naked void uhmul64_max_reg(void)
+{
+	asm volatile (
+	"r0 = -1;"
+	"r1 = -1;"
+	".8byte %[hmul];"
+	"r2 = -2;"
+	"r0 ^= r2;"
+	"r2 = r0;"
+	"r2 >>= 32;"
+	"w0 |= w2;"
+	"exit;"
+	:
+	: __imm_insn(hmul, BPF_UHMUL64_REG(BPF_REG_0, BPF_REG_1))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("UHMUL64, (1ULL << 63) * 2, register source")
+__success __success_unpriv __retval(0)
+__naked void uhmul64_pow2_reg(void)
+{
+	asm volatile (
+	"r0 = 2;"
+	"r1 = %[llong_min] ll;"
+	".8byte %[hmul];"
+	"r0 = r1;"
+	"r2 = 1;"
+	"r0 ^= r2;"
+	"r2 = r0;"
+	"r2 >>= 32;"
+	"w0 |= w2;"
+	"exit;"
+	:
+	: __imm_const(llong_min, LLONG_MIN),
+	  __imm_insn(hmul, BPF_UHMUL64_REG(BPF_REG_1, BPF_REG_0))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("UHMUL64, (1ULL << 63) * 2, R3 destination")
+__success __success_unpriv __retval(0)
+__naked void uhmul64_r3_dst(void)
+{
+	asm volatile (
+	"r3 = %[llong_min] ll;"
+	"r0 = 2;"
+	".8byte %[hmul];"
+	"r2 = 1;"
+	"r3 ^= r2;"
+	"r2 = r3;"
+	"r2 >>= 32;"
+	"w3 |= w2;"
+	"r0 = r3;"
+	"exit;"
+	:
+	: __imm_const(llong_min, LLONG_MIN),
+	  __imm_insn(hmul, BPF_UHMUL64_REG(BPF_REG_3, BPF_REG_0))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("UHMUL64, (1ULL << 63) * 2, immediate source")
+__success __success_unpriv __retval(0)
+__naked void uhmul64_pow2_imm(void)
+{
+	asm volatile (
+	"r0 = %[llong_min] ll;"
+	".8byte %[hmul];"
+	"r2 = 1;"
+	"r0 ^= r2;"
+	"r2 = r0;"
+	"r2 >>= 32;"
+	"w0 |= w2;"
+	"exit;"
+	:
+	: __imm_const(llong_min, LLONG_MIN),
+	  __imm_insn(hmul, BPF_UHMUL64_IMM(BPF_REG_0, 2))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("UHMUL64, (1ULL << 63) * -2, immediate source")
+__success __success_unpriv __retval(0)
+__naked void uhmul64_neg_imm(void)
+{
+	asm volatile (
+	"r0 = %[llong_min] ll;"
+	".8byte %[hmul];"
+	"r2 = %[llong_max] ll;"
+	"r0 ^= r2;"
+	"r2 = r0;"
+	"r2 >>= 32;"
+	"w0 |= w2;"
+	"exit;"
+	:
+	: __imm_const(llong_min, LLONG_MIN),
+	  __imm_const(llong_max, LLONG_MAX),
+	  __imm_insn(hmul, BPF_UHMUL64_IMM(BPF_REG_0, -2))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SHMUL64, INT64_MAX * INT64_MAX, register source")
+__success __success_unpriv __retval(0)
+__naked void shmul64_max_reg(void)
+{
+	asm volatile (
+	"r0 = %[llong_max] ll;"
+	"r1 = %[llong_max] ll;"
+	".8byte %[hmul];"
+	"r2 = %[expected] ll;"
+	"r0 ^= r2;"
+	"r2 = r0;"
+	"r2 >>= 32;"
+	"w0 |= w2;"
+	"exit;"
+	:
+	: __imm_const(expected, 0x3fffffffffffffffULL),
+	  __imm_const(llong_max, LLONG_MAX),
+	  __imm_insn(hmul, BPF_SHMUL64_REG(BPF_REG_0, BPF_REG_1))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SHMUL64, INT64_MIN * -2, register source")
+__success __success_unpriv __retval(0)
+__naked void shmul64_min_neg2_reg(void)
+{
+	asm volatile (
+	"r0 = %[llong_min] ll;"
+	"r1 = -2;"
+	".8byte %[hmul];"
+	"r2 = 1;"
+	"r0 ^= r2;"
+	"r2 = r0;"
+	"r2 >>= 32;"
+	"w0 |= w2;"
+	"exit;"
+	:
+	: __imm_const(llong_min, LLONG_MIN),
+	  __imm_insn(hmul, BPF_SHMUL64_REG(BPF_REG_0, BPF_REG_1))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SHMUL64, 1 * -2, immediate source")
+__success __success_unpriv __retval(0)
+__naked void shmul64_neg_imm(void)
+{
+	asm volatile (
+	"r0 = 1;"
+	".8byte %[hmul];"
+	"r2 = -1;"
+	"r0 ^= r2;"
+	"r2 = r0;"
+	"r2 >>= 32;"
+	"w0 |= w2;"
+	"exit;"
+	:
+	: __imm_insn(hmul, BPF_SHMUL64_IMM(BPF_REG_0, -2))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SHMUL64, INT64_MIN * 2, immediate source")
+__success __success_unpriv __retval(0)
+__naked void shmul64_min_imm(void)
+{
+	asm volatile (
+	"r0 = %[llong_min] ll;"
+	".8byte %[hmul];"
+	"r2 = -1;"
+	"r0 ^= r2;"
+	"r2 = r0;"
+	"r2 >>= 32;"
+	"w0 |= w2;"
+	"exit;"
+	:
+	: __imm_const(llong_min, LLONG_MIN),
+	  __imm_insn(hmul, BPF_SHMUL64_IMM(BPF_REG_0, 2))
+	: __clobber_all);
+}
+
+#else
+
+SEC("socket")
+__description("UHMUL/SHMUL are not supported by this JIT, use a dummy test")
+__skip("UHMUL/SHMUL are not supported by this jit")
+__success
+int dummy_test(void)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
index 4d8273c258d5..d7fb6b71b206 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
@@ -202,7 +202,8 @@ __naked void flow_keys_illegal_variable_offset_alu(void)
 
 /*
  * Offset fields of 0 and 1 are legal for BPF_{DIV,MOD} instructions.
- * Offset fields of 0 are legal for the rest of ALU instructions.
+ * Offset fields of 0, 1 and 2 are legal for BPF_ALU64 | BPF_MUL.
+ * Only offset 0 is legal for BPF_ALU | BPF_MUL.
  * Test that error is reported for illegal offsets, assuming that tests
  * for legal offsets exist.
  */
@@ -212,5 +213,11 @@ DEFINE_BAD_OFFSET_TEST(bad_offset_addx, BPF_ALU64 | BPF_ADD | BPF_X, -1, 0)
 DEFINE_BAD_OFFSET_TEST(bad_offset_divx2, BPF_ALU64 | BPF_DIV | BPF_X, 2, 0)
 DEFINE_BAD_OFFSET_TEST(bad_offset_modk2, BPF_ALU64 | BPF_MOD | BPF_K, 2, 1)
 DEFINE_BAD_OFFSET_TEST(bad_offset_addx2, BPF_ALU64 | BPF_ADD | BPF_X, 1, 0)
+DEFINE_BAD_OFFSET_TEST(bad_offset_mulx, BPF_ALU64 | BPF_MUL | BPF_X, -1, 0)
+DEFINE_BAD_OFFSET_TEST(bad_offset_mulk, BPF_ALU64 | BPF_MUL | BPF_K, 3, 0)
+DEFINE_BAD_OFFSET_TEST(bad_uhmul32_x, BPF_ALU | BPF_MUL | BPF_X,
+		       BPF_MUL_VARIANT_UHMUL, 0)
+DEFINE_BAD_OFFSET_TEST(bad_shmul32_k, BPF_ALU | BPF_MUL | BPF_K,
+		       BPF_MUL_VARIANT_SHMUL, 0)
 
 char _license[] SEC("license") = "GPL";
-- 
2.55.0

