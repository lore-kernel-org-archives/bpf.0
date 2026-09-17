Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC7C3BFAE8
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 04:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.101.248.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618668; cv=none; b=OJ55hzv29Z/Zw2WBMGWfw6zEovSJMrrgCKyzqWIdJx662zyWaLnQ8JNU3NnGIEZFqBAStolQDHYN25mGPieYeV0U2lI4KJkNL7ry+trAjX4l4kEQhOEoVmlaNSOGpcQiuWHGJKmKqAQD0YMzUfI0k15CPR0HU4se0me6HfHs27Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618668; c=relaxed/simple;
	bh=sKQ4lYLaM+WArpN+AR0915ZkN8vB7GBQ2RejMuzOhCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6kvZoyt3c5UnqZOc/w6CXg05IwirP2tRvdJ49VOvJY82LurRLPUi2YjCXFi5wdVRGJELmEb+IbbPyJL2Q7vSac+OY6gnUTaPs7bNOMSfBmjSk+GTk9m9GEvrb52a1Mh69kPIT9vHAhwbzYjfbOo7ZZZfJpV1B3MFBWfqqV2ts0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=46.101.248.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wB3jnzUaatqkBMdAQ--.3604S3;
	Thu, 17 Sep 2026 12:17:24 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.163.215])
	by mail-app1 (Coremail) with SMTP id yy_KCgDnoZnUaatqFuuJBA--.2486S2;
	Thu, 17 Sep 2026 12:17:24 +0800 (CST)
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
	ziye@zju.edu.cn,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next 1/8] bpf: Add UHMUL and SHMUL instructions
Date: Thu, 17 Sep 2026 12:17:05 +0800
Message-ID: <20260917041712.1860722-2-tangyazhou@zju.edu.cn>
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
X-CM-TRANSID:yy_KCgDnoZnUaatqFuuJBA--.2486S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAgERCmqq8RoVXQABs6
X-CM-DELIVERINFO: =?B?JvuLEAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9BMXZiQifGBAu8ehqrOKaOqJhpj6DqDI0HqAXeHgbSERElsnvplEpUpqlcJ9Ddr3UUWe
	IHm4NJphLXJgD4RqNQdetmQKa+jk7JB8sxEsjPcDpHLt7QJFWqXpm1Iai9HS4w==
X-Coremail-Antispam: 1Uk129KBj93XoW3Zw4kZFW5tw17Cw18Zw13trc_yoWDCrW8pF
	4vyryrJFZ2grWkur97G397CF15Ga10gr4UGry7W3yUAFZrtasYqF40qr1SgFW3JrW8WayY
	qr9I9ry8u3yUZwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Hq2tUUUUU==

From: Tianci Cao <ziye@zju.edu.cn>

Define UHMUL and SHMUL as BPF_ALU64 BPF_MUL variants selected by insn->off.
UHMUL returns the high 64 bits of an unsigned 64-by-64-bit product, while
SHMUL returns the high 64 bits of a signed product. Keep off == 0 as the
existing low-half multiplication, and assign off == 1 and off == 2 to
UHMUL and SHMUL, respectively.

These operations are inspired by the UHMUL and SHMUL instructions introduced
as part of the PQR instruction class in sBPF sBPF (Solana's BPF variant)[1].

The encoding and immediate semantics differ from current sBPF.

1. sBPF assigns these operations dedicated opcodes in the BPF_PQR class,
   whereas this implementation selects them through the offset field of BPF_MUL.

2. sBPF initially sign-extended the immediate operand of UHMUL, but later
   changed unsigned PQR immediates, including UHMUL, to be zero-extended[2].
   This was an ISA design choice to treat immediates of explicitly unsigned
   operations as unsigned 32-bit values[3].

   Linux instead follows the existing BPF_ALU64 immediate convention.
   Both immediate forms first sign-extend the 32-bit immediate to 64 bits.
   UHMUL then interprets the resulting bit pattern as unsigned, while
   SHMUL interprets it as signed.

Add portable helpers for both operations, using mul_u64_u64_shr() and a
signed correction instead of relying on a compiler-provided 128-bit
integer type. Wire the variants into the interpreter and disassembler,
and document the encoding in the UAPI and BPF instruction set. Keep
BPF_ALU multiplication restricted to the existing low-half variant.

[1] https://github.com/solana-labs/rbpf/pull/498
[2] https://github.com/solana-labs/rbpf/pull/642
[3] https://lore.kernel.org/bpf/59e754a2-6158-485c-93b9-6f60d9f57528@zju.edu.cn/

Link: https://lore.kernel.org/bpf/CAADnVQ+2O2zgdy11+vxE6dOp+3Br4zZBysHF-Hne7cP+eeucnQ@mail.gmail.com/
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Yazhou Tang <tangyazhou518@outlook.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
---
 .../bpf/standardization/instruction-set.rst   | 26 ++++++++++-
 include/linux/filter.h                        | 39 ++++++++++++++++
 include/uapi/linux/bpf.h                      | 10 +++++
 kernel/bpf/core.c                             | 45 ++++++++++++++++++-
 kernel/bpf/disasm.c                           | 18 ++++++++
 tools/include/uapi/linux/bpf.h                | 10 +++++
 6 files changed, 145 insertions(+), 3 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 39c74611752b..3c2cde11fa23 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -330,6 +330,8 @@ register.
   ADD    0x0    0        dst += src
   SUB    0x1    0        dst -= src
   MUL    0x2    0        dst \*= src
+  UHMUL  0x2    1        unsigned high-half multiplication (``ALU64`` only)
+  SHMUL  0x2    2        signed high-half multiplication (``ALU64`` only)
   DIV    0x3    0        dst = (src != 0) ? (dst / src) : 0
   SDIV   0x3    1        dst = (src == 0) ? 0 : ((src == -1 && dst == LLONG_MIN) ? LLONG_MIN : (dst s/ src))
   OR     0x4    0        dst \|= src
@@ -379,13 +381,33 @@ where '(u32)' indicates that the upper 32 bits are zeroed.
 
   dst = dst ^ imm
 
-Note that most arithmetic instructions have 'offset' set to 0. Only three instructions
-(``SDIV``, ``SMOD``, ``MOVSX``) have a non-zero 'offset'.
+Note that most arithmetic instructions have 'offset' set to 0. The following
+instructions may have a non-zero 'offset':
+
+* ``SDIV`` and ``SMOD``: ``offset == 1`` selects the signed variant.
+* ``MOVSX``: ``offset`` selects the source operand width.
+* ``MUL``: ``offset`` selects the multiplication variant (see below).
 
 Division, multiplication, and modulo operations for ``ALU`` are part
 of the "divmul32" conformance group, and division, multiplication, and
 modulo operations for ``ALU64`` are part of the "divmul64" conformance
 group.
+
+For ``ALU64`` multiplication, ``offset == 1`` selects unsigned
+high-half multiplication (``UHMUL``), and ``offset == 2`` selects
+signed high-half multiplication (``SHMUL``).
+
+For ``X`` mode, ``src64`` is the 64-bit value in ``src_reg``. For
+``K`` mode, ``src64`` is ``imm`` sign-extended from 32 to 64 bits.
+The operations are::
+
+  UHMUL: dst = (u64)(((u128)dst * (u128)(u64)src64) >> 64)
+  SHMUL: dst = (u64)(((s128)(s64)dst * (s128)(s64)src64) >> 64)
+
+For ``ALU`` multiplication, only ``offset == 0`` is valid. For
+``ALU64`` multiplication, offset values other than 0, 1, and 2 are
+reserved.
+
 The division and modulo operations support both unsigned and signed flavors.
 
 For unsigned operations (``DIV`` and ``MOD``), for ``ALU``,
diff --git a/include/linux/filter.h b/include/linux/filter.h
index b17222db2efc..b6dc4b968a9c 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -23,6 +23,7 @@
 #include <linux/sockptr.h>
 #include <linux/static_call.h>
 #include <linux/u64_stats_sync.h>
+#include <linux/math64.h>
 
 #include <net/sch_generic.h>
 
@@ -147,6 +148,44 @@ struct ctl_table_header;
 #define BPF_ALU32_IMM(OP, DST, IMM)				\
 	BPF_ALU32_IMM_OFF(OP, DST, IMM, 0)
 
+static inline u64 bpf_uhmul64(u64 a, u64 b)
+{
+	return mul_u64_u64_shr(a, b, 64);
+}
+
+static inline u64 bpf_shmul64(s64 a, s64 b)
+{
+	u64 ua = a, ub = b;
+	u64 hi = bpf_uhmul64(ua, ub);
+
+	/*
+	 * Let M = 2^64, sa = (a < 0), and sb = (b < 0). Then:
+	 *
+	 * a * b = (ua - sa * M) * (ub - sb * M)
+	 *       = ua * ub - sa * M * ub - sb * M * ua + sa * sb * M^2
+	 *
+	 * Therefore, signed_hi = unsigned_hi - sa * ub - sb * ua (mod M).
+	 */
+	if (a < 0)
+		hi -= ub;
+	if (b < 0)
+		hi -= ua;
+	return hi;
+}
+
+static inline bool bpf_is_hmul_variant(s16 off)
+{
+	return off == BPF_MUL_VARIANT_UHMUL ||
+	       off == BPF_MUL_VARIANT_SHMUL;
+}
+
+static inline bool bpf_insn_is_hmul(const struct bpf_insn *insn)
+{
+	return BPF_CLASS(insn->code) == BPF_ALU64 &&
+	       BPF_OP(insn->code) == BPF_MUL &&
+	       bpf_is_hmul_variant(insn->off);
+}
+
 /* Endianess conversion, cpu_to_{l,b}e(), {l,b}e_to_cpu() */
 
 #define BPF_ENDIAN(TYPE, DST, LEN)				\
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 732b35cc08d1..845eee536198 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -34,6 +34,16 @@
 #define BPF_FROM_LE	BPF_TO_LE
 #define BPF_FROM_BE	BPF_TO_BE
 
+/*
+ * BPF_MUL variants selected by the off field.
+ * UHMUL and SHMUL are only valid for BPF_ALU64.
+ */
+enum bpf_mul_variant {
+	BPF_MUL_VARIANT_LO    = 0,
+	BPF_MUL_VARIANT_UHMUL = 1,
+	BPF_MUL_VARIANT_SHMUL = 2,
+};
+
 /* jmp encodings */
 #define BPF_JNE		0x50	/* jump != */
 #define BPF_JLT		0xa0	/* LT is unsigned, '<' */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 4e208cc94752..4f746973481b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1931,7 +1931,50 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 	ALU(AND,  &)
 	ALU(OR,   |)
 	ALU(XOR,  ^)
-	ALU(MUL,  *)
+	/*
+	 * MUL needs explicit handlers because ALU64 insn->off selects
+	 * low-half, unsigned high-half, or signed high-half multiplication.
+	 */
+	ALU64_MUL_X:
+		switch (OFF) {
+		case BPF_MUL_VARIANT_LO:
+			DST = DST * SRC;
+			break;
+		case BPF_MUL_VARIANT_UHMUL:
+			DST = bpf_uhmul64(DST, SRC);
+			break;
+		case BPF_MUL_VARIANT_SHMUL:
+			DST = bpf_shmul64((s64)DST, (s64)SRC);
+			break;
+		default:
+			goto default_label;
+		}
+		CONT;
+	ALU_MUL_X:
+		if (OFF != BPF_MUL_VARIANT_LO)
+			goto default_label;
+		DST = (u32) DST * (u32) SRC;
+		CONT;
+	ALU64_MUL_K:
+		switch (OFF) {
+		case BPF_MUL_VARIANT_LO:
+			DST = DST * IMM;
+			break;
+		case BPF_MUL_VARIANT_UHMUL:
+			DST = bpf_uhmul64(DST, (u64)IMM);
+			break;
+		case BPF_MUL_VARIANT_SHMUL:
+			DST = bpf_shmul64((s64)DST, (s32)IMM);
+			break;
+		default:
+			goto default_label;
+		}
+		CONT;
+	ALU_MUL_K:
+		if (OFF != BPF_MUL_VARIANT_LO)
+			goto default_label;
+		DST = (u32) DST * (u32) IMM;
+		CONT;
 	SHT(LSH, <<)
 	SHT(RSH, >>)
 #undef SHT
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 3ce8d74b0e40..03f22845e169 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -163,6 +163,22 @@ static bool is_sdiv_smod(const struct bpf_insn *insn)
 	       insn->off == 1;
 }
 
+/* Return the UHMUL or SHMUL operator string, or NULL for all other encodings. */
+static const char *hmul_op_string(const struct bpf_insn *insn)
+{
+	if (BPF_CLASS(insn->code) != BPF_ALU64 ||
+	    BPF_OP(insn->code) != BPF_MUL)
+		return NULL;
+	switch (insn->off) {
+	case BPF_MUL_VARIANT_UHMUL:
+		return "uh*=";
+	case BPF_MUL_VARIANT_SHMUL:
+		return "sh*=";
+	default:
+		return NULL;
+	}
+}
+
 static bool is_movsx(const struct bpf_insn *insn)
 {
 	return BPF_OP(insn->code) == BPF_MOV &&
@@ -215,6 +231,7 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			verbose(cbs->private_data, "(%02x) %c%d %s %s%c%d",
 				insn->code, class == BPF_ALU ? 'w' : 'r',
 				insn->dst_reg,
+				hmul_op_string(insn) ?:
 				is_sdiv_smod(insn) ? bpf_alu_sign_string[BPF_OP(insn->code) >> 4]
 						   : bpf_alu_string[BPF_OP(insn->code) >> 4],
 				is_movsx(insn) ? bpf_movsx_string[(insn->off >> 3) - 1] : "",
@@ -224,6 +241,7 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			verbose(cbs->private_data, "(%02x) %c%d %s %d",
 				insn->code, class == BPF_ALU ? 'w' : 'r',
 				insn->dst_reg,
+				hmul_op_string(insn) ?:
 				is_sdiv_smod(insn) ? bpf_alu_sign_string[BPF_OP(insn->code) >> 4]
 						   : bpf_alu_string[BPF_OP(insn->code) >> 4],
 				insn->imm);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 732b35cc08d1..845eee536198 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -34,6 +34,16 @@
 #define BPF_FROM_LE	BPF_TO_LE
 #define BPF_FROM_BE	BPF_TO_BE
 
+/*
+ * BPF_MUL variants selected by the off field.
+ * UHMUL and SHMUL are only valid for BPF_ALU64.
+ */
+enum bpf_mul_variant {
+	BPF_MUL_VARIANT_LO    = 0,
+	BPF_MUL_VARIANT_UHMUL = 1,
+	BPF_MUL_VARIANT_SHMUL = 2,
+};
+
 /* jmp encodings */
 #define BPF_JNE		0x50	/* jump != */
 #define BPF_JLT		0xa0	/* LT is unsigned, '<' */
-- 
2.55.0

