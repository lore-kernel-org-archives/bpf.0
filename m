Received: from zju.edu.cn (gw.zju.edu.cn [210.32.2.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDD83C8C77
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 07:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.32.2.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332874; cv=none; b=rZaBOEmnYDCwh9FhyafR1Xaj0hrTDLuCsn7N0oeC5vimsnzEey14zEVh854BSpnb4HomJ03Wnph/84p1srXaAGxxv6V/6maeAF+zet3Z12E3GcLDSu8SLSlinuRwv9e0c7/YtCf//O3D+Zw/iqUeE9woLB9xlikIbfDX42NNDGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332874; c=relaxed/simple;
	bh=BpjZLgdje1lIlynoQ3OEJ5NPt+3vYUjhbus+TgG29I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eyakf6PdZTbgyaj7oUFFHn3XGW9v50AX4DlkNUXRamH0Bn97ye+lCiUXO58ZrkiY4b4Jibbc0l3f5qnj7sgJJWn1j2LMa6ZlSo53rng0D/5gLEuTak2IACI4tDiHwMtnLf5aKfTZ3ATkuQ+/19TKkLRnLMZb8+wA0e4aNfRtWIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=210.32.2.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.14.28.207])
	by mtasvr (Coremail) with SMTP id _____wA34zzjypdqLBXjAA--.41756S3;
	Wed, 02 Sep 2026 15:06:11 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.14.28.207])
	by mail-app2 (Coremail) with SMTP id zC_KCgAXhsviypdqFR5IBA--.23240S2;
	Wed, 02 Sep 2026 15:06:10 +0800 (CST)
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
Subject: [RFC PATCH bpf-next 6/6] selftests/bpf: Add bytecode tests for UHMUL and SHMUL
Date: Wed,  2 Sep 2026 15:05:34 +0800
Message-ID: <20260902070534.2141812-7-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902070534.2141812-1-tangyazhou@zju.edu.cn>
References: <20260902070534.2141812-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgAXhsviypdqFR5IBA--.23240S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgECCmqXKpkZyQAAsR
X-CM-DELIVERINFO: =?B?3/QofAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9BW57ZX8IOr2HTuB9W6G9jVbIg+xbyL2p2+KSRPhHtnMFcIBXVRlejBYUmiWKaRlTr7z
	TIg02/gdK1ghhjxzLG2tf8YiNBcyXK05HZknIdPWl94wCn8ytgagN39KMPRE+g==
X-Coremail-Antispam: 1Uk129KBj93XoW3tr1DJr45ur17AryrGw18tFc_yoWkKFyUpF
	1IkF1DGrykCr9a9FZ7Ca9ruF1fGFs29rWUWw40yr15Za17Jr9Fqr4xKF4DGwn3Jwnav3yY
	vF1ayF9IkryUAwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU2pnQUUUUU

From: Yazhou Tang <tangyazhou518@outlook.com>

Add test_progs coverage for UHMUL and SHMUL with the following changes:

1. Add arithmetic execution tests in verifier_hmul.c and register the new
   test suite with the verifier test runner:
   - Gate the execution cases on __TARGET_ARCH_x86, matching the initial
     JIT support, and provide a dummy program for other targets.
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
index f7f94ccebce2..bb352ad0d36f 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -50,6 +50,7 @@
 #include "verifier_helper_packet_access.skel.h"
 #include "verifier_helper_restricted.skel.h"
 #include "verifier_helper_value_access.skel.h"
+#include "verifier_hmul.skel.h"
 #include "verifier_int_ptr.skel.h"
 #include "verifier_iterating_callbacks.skel.h"
 #include "verifier_jeq_infer_not_null.skel.h"
@@ -214,6 +215,7 @@ void test_verifier_helper_access_var_len(void) { RUN(verifier_helper_access_var_
 void test_verifier_helper_packet_access(void) { RUN(verifier_helper_packet_access); }
 void test_verifier_helper_restricted(void)    { RUN(verifier_helper_restricted); }
 void test_verifier_helper_value_access(void)  { RUN(verifier_helper_value_access); }
+void test_verifier_hmul(void)                 { RUN(verifier_hmul); }
 void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
 void test_verifier_iterating_callbacks(void)  { RUN(verifier_iterating_callbacks); }
 void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_hmul.c b/tools/testing/selftests/bpf/progs/verifier_hmul.c
new file mode 100644
index 000000000000..b29565b30913
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_hmul.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Tianci Cao */
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
+#if defined(__TARGET_ARCH_x86)
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
2.43.0

