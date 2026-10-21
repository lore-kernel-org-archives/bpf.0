Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.32.2.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571100;
	b=e9epInSBc3wXVoIvIJ/C31BdjZ+W+jFpqP/FfVjJBIIRczJQlON8TbVwowJFlbqR2v1p
	 VYRwuPoE3x+yev2q32f4f/5js0FFHdIv4jWhouzn++eVi+2haCP3h8hG9fHRBxL3xK9cK
	 OLcIhdmsYgc2seUBmAomUuUTwyblM7yCkKhgWRlRD1DXV4ngEkxiRfw9Z3SfB8LTN/Ur0
	 kTALatY8YIsMX6wzALHFWnvYgJWI34NkZgqxeHf7WiuP9oLyCfn1DFJrPcsL8NtBo1xMm
	 SkPyAo4c7wwZp2dfCwq4KLG8Rjx+OFUEOqvapBIcIdeekdPX+bEyk00VIMlS9o7YeDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571100;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-CM-DELIVERINFO:X-Coremail-Antispam;
	bh=nLvx1FjKuvWgFgec40Cb4qh0IcvpzIEXyEqhpZDf7RE=;
	b=lTXHZ41GHJAh1WN9dVI5kfR4bSYdKQqLLNecgyKwv3e6iJ32sVddzTUDCvAsbvdlaB2z
	 DhgP3hd0YeOabNL5wLb90wOY/GU/guGmVWHK/yfjalmt1UHJFob2+x40cOArFHGpwn8Qj
	 iBk+cLLoA2CEHZwSIVhe41Aoe9NStPHgmRi7z4FttlkVLSSl4lMDjLpwpMBkc8lI5HBe1
	 /zjEpo7XTOpYtezd85YfX+WzM6T4uerPgcCmPPkEV6X/VGSnKrhZAPKAqwWTW8mQYk3Ug
	 DKZRpgDSuMODdXsCfxTbjicr/adqiQLoirW9afkj1QQGU1lx1Mi5EkZu6bMi+sds+zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=zju.edu.cn;
	spf=pass smtp.mailfrom=zju.edu.cn;
	arc=none smtp.remote-ip=210.32.2.4
Received: from zju.edu.cn (gw.zju.edu.cn [210.32.2.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE228606A31A;
	Wed, 21 Oct 2026 08:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE228606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wD3sj3BdthqyVCtAQ--.82S3;
	Wed, 21 Oct 2026 16:24:33 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.163.215])
	by mail-app3 (Coremail) with UTF8SMTPA id zS_KCgD3l6K7dthqfF21AA--.41149S2;
	Wed, 21 Oct 2026 16:24:28 +0800 (CST)
From: tangyazhou@zju.edu.cn
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	David Vernet <void@manifault.com>,
	bpf@ietf.org
Cc: John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	=?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Shahab Vahedi <list+bpf@vahedi.org>,
	Russell King <linux@armlinux.org.uk>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>,
	Paul Burton <paulburton@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>,
	Xi Wang <xi.wang@gmail.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Wang YanQing <udknight@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Yazhou Tang <tangyazhou518@outlook.com>,
	Tianci Cao <ziye@zju.edu.cn>,
	Shenghao Yuan <shenghaoyuan0928@163.com>
Subject: [PATCH bpf-next v2 8/8] selftests/bpf: Add bytecode tests for UHMUL and SHMUL
Date: Wed, 21 Oct 2026 16:24:25 +0800
Message-ID: <20261021-bpf-hmul-v2-8-88e260099f7d@outlook.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021-bpf-hmul-v2-0-88e260099f7d@outlook.com>
References: <20261021-bpf-hmul-v2-0-88e260099f7d@outlook.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgD3l6K7dthqfF21AA--.41149S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBhILCmrXxB0qLQAAs2
X-CM-DELIVERINFO: =?B?8oMkfQXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9EVVP6kLhQ0h/Ob14g/5HMk/nLh2vxT8H3RwpnaL88vMle9LcpBe2xLm1l7FYGybVlWg
	6mzcp2KQy1GcuN/vxzjiUz/HswzHBImQc+TfAusI35kw7NXfKhcELEUR/qsuQg==
X-Coremail-Antispam: 1Uk129KBj9fXoW3tr1DJr45ur17AF1fZF1fuFX_yoW8GFW7Wo
	Z2ka1ayr4fKFn09FWSkF1SyFW7ur4Ikay8JrWkG3WUWF97Ar1Yy348Cw4xtr4q9r1q9a4k
	Xa47Za4Yva15GFykl-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYR7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26F4UJVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAF
	wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7M4kE6xkIj40Ew7xC0wCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48J
	MIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr
	1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvE
	x4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUcj2MUUUUU

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

2. Add arena pointer rejection tests in verifier_hmul_arena.c. Use an
   arena pointer as the destination of UHMUL and as the source of SHMUL,
   and verify that the verifier rejects both programs.

   Keep these cases in a separate BPF object with a dedicated userspace
   runner. Probe BPF_MAP_TYPE_ARENA support before loading the object,
   and skip this suite when arena maps are unavailable, while keeping
   the arithmetic tests in verifier_hmul.c runnable. Retain
   __BPF_FEATURE_ADDR_SPACE_CAST gating and a dummy skip program for
   toolchains without addr_space_cast support.

3. Extend the illegal instruction encoding tests in verifier_value_illegal_alu.c.
   Check reserved MUL offsets and UHMUL and SHMUL encodings in the BPF_ALU
   class, reusing the existing DEFINE_BAD_OFFSET_TEST() macro.

Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
---
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/prog_tests/verifier_hmul_arena.c |  19 ++
 tools/testing/selftests/bpf/progs/verifier_hmul.c  | 235 +++++++++++++++++++++
 .../selftests/bpf/progs/verifier_hmul_arena.c      |  70 ++++++
 .../bpf/progs/verifier_value_illegal_alu.c         |   7 +-
 5 files changed, 332 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 04740ba37e91..795c3e56c23e 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -59,6 +59,7 @@
 #include "verifier_helper_packet_access.skel.h"
 #include "verifier_helper_restricted.skel.h"
 #include "verifier_helper_value_access.skel.h"
+#include "verifier_hmul.skel.h"
 #include "verifier_idoms.skel.h"
 #include "verifier_int_ptr.skel.h"
 #include "verifier_iterating_callbacks.skel.h"
@@ -251,6 +252,7 @@ void test_verifier_helper_access_var_len(void) { RUN(verifier_helper_access_var_
 void test_verifier_helper_packet_access(void) { RUN(verifier_helper_packet_access); }
 void test_verifier_helper_restricted(void)    { RUN(verifier_helper_restricted); }
 void test_verifier_helper_value_access(void)  { RUN(verifier_helper_value_access); }
+void test_verifier_hmul(void)                 { RUN(verifier_hmul); }
 void test_verifier_idoms(void)                { RUN(verifier_idoms); }
 void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
 void test_verifier_iterating_callbacks(void)  { RUN(verifier_iterating_callbacks); }
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier_hmul_arena.c b/tools/testing/selftests/bpf/prog_tests/verifier_hmul_arena.c
new file mode 100644
index 000000000000..f9cd7b7b9781
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/verifier_hmul_arena.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "verifier_hmul_arena.skel.h"
+
+void test_verifier_hmul_arena(void)
+{
+	int ret;
+
+	/* Arena support can depend on CPU features, such as Zacas on RV64. */
+	ret = libbpf_probe_bpf_map_type(BPF_MAP_TYPE_ARENA, NULL);
+	if (!ASSERT_GE(ret, 0, "probe_arena"))
+		return;
+	if (!ret) {
+		test__skip();
+		return;
+	}
+	RUN_TESTS(verifier_hmul_arena);
+}
diff --git a/tools/testing/selftests/bpf/progs/verifier_hmul.c b/tools/testing/selftests/bpf/progs/verifier_hmul.c
new file mode 100644
index 000000000000..acd92355c636
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_hmul.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <limits.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../../../include/linux/filter.h"
+
+#define BPF_UHMUL64_REG(DST, SRC) \
+	BPF_RAW_INSN(BPF_ALU64 | BPF_MUL | BPF_X, DST, SRC, BPF_UHMUL, 0)
+
+#define BPF_UHMUL64_IMM(DST, IMM) \
+	BPF_RAW_INSN(BPF_ALU64 | BPF_MUL | BPF_K, DST, 0, BPF_UHMUL, IMM)
+
+#define BPF_SHMUL64_REG(DST, SRC) \
+	BPF_RAW_INSN(BPF_ALU64 | BPF_MUL | BPF_X, DST, SRC, BPF_SHMUL, 0)
+
+#define BPF_SHMUL64_IMM(DST, IMM) \
+	BPF_RAW_INSN(BPF_ALU64 | BPF_MUL | BPF_K, DST, 0, BPF_SHMUL, IMM)
+
+/*
+ * Inject UHMUL/SHMUL as raw instructions so these tests do not require
+ * assembler support for the new mnemonics. All surrounding instructions use
+ * existing BPF assembly syntax supported by the baseline selftests toolchain.
+ */
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
diff --git a/tools/testing/selftests/bpf/progs/verifier_hmul_arena.c b/tools/testing/selftests/bpf/progs/verifier_hmul_arena.c
new file mode 100644
index 000000000000..fc0ca88114d0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_hmul_arena.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../../../include/linux/filter.h"
+
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+
+#define BPF_UHMUL64_IMM(DST, IMM) \
+	BPF_RAW_INSN(BPF_ALU64 | BPF_MUL | BPF_K, DST, 0, BPF_UHMUL, IMM)
+
+#define BPF_SHMUL64_REG(DST, SRC) \
+	BPF_RAW_INSN(BPF_ALU64 | BPF_MUL | BPF_X, DST, SRC, BPF_SHMUL, 0)
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
+#else
+
+SEC("socket")
+__description("HMUL arena tests require compiler support for addr_space_cast")
+__skip("compiler doesn't support addr_space_cast")
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
index 31663338866d..209d5be55155 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
@@ -367,7 +367,8 @@ __naked void flow_keys_illegal_variable_offset_alu(void)
 
 /*
  * Offset fields of 0 and 1 are legal for BPF_{DIV,MOD} instructions.
- * Offset fields of 0 are legal for the rest of ALU instructions.
+ * Offset fields of 0, 1 and 2 are legal for BPF_ALU64 | BPF_MUL.
+ * Only offset 0 is legal for BPF_ALU | BPF_MUL.
  * Test that error is reported for illegal offsets, assuming that tests
  * for legal offsets exist.
  */
@@ -377,5 +378,9 @@ DEFINE_BAD_OFFSET_TEST(bad_offset_addx, BPF_ALU64 | BPF_ADD | BPF_X, -1, 0)
 DEFINE_BAD_OFFSET_TEST(bad_offset_divx2, BPF_ALU64 | BPF_DIV | BPF_X, 2, 0)
 DEFINE_BAD_OFFSET_TEST(bad_offset_modk2, BPF_ALU64 | BPF_MOD | BPF_K, 2, 1)
 DEFINE_BAD_OFFSET_TEST(bad_offset_addx2, BPF_ALU64 | BPF_ADD | BPF_X, 1, 0)
+DEFINE_BAD_OFFSET_TEST(bad_offset_mulx, BPF_ALU64 | BPF_MUL | BPF_X, -1, 0)
+DEFINE_BAD_OFFSET_TEST(bad_offset_mulk, BPF_ALU64 | BPF_MUL | BPF_K, 3, 0)
+DEFINE_BAD_OFFSET_TEST(bad_uhmul32_x, BPF_ALU | BPF_MUL | BPF_X, BPF_UHMUL, 0)
+DEFINE_BAD_OFFSET_TEST(bad_shmul32_k, BPF_ALU | BPF_MUL | BPF_K, BPF_SHMUL, 0)
 
 char _license[] SEC("license") = "GPL";

-- 
2.56.0

