Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=206.189.79.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792561306;
	b=XBWfmqsPyTgQKOOS6fflCi4Ro/sf6G3ymu1lVlzkeP/2Vea2voBh7Jv74GUO+VM/tH1m
	 BPPHz4+8RUQp9XD0NYekO+wEQc3GriBHPzWlLQOx+OJFooYuX/u+LbEw7NrOvTQ5P3qiE
	 XBBsqez+dqxJa66T+EehQjO1iMFxJkB/sUNm3nwc8GB5WTfqHcV/rvzsmYpZ83rOpC2j3
	 9kjboYiWhkdXWAqij+UuFAD6IowrwbNbUbD2XiCw5wRYJb3hEnSxaKuTSP8yjvcZj052g
	 wl7Tbr+tbmdRlenHrErMiFFkGzebfVS9MSIC1BQs7+MucF7T00W3n9ZzrqLpNyKfZBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561306;
	h=DMARC-Filter:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-CM-TRANSID:X-CM-SenderInfo:
	 X-CM-DELIVERINFO:X-Coremail-Antispam;
	bh=sdVlJMsF65Nr3fdm/Caz1kaSyWTTPe/nREKl/GePA3k=;
	b=bVWAiRFKJIZMbGVePflymBMcXocDqeJftWx2VKHWyOmcYZtQDRvAvd9ImaVB6R4IjSp2
	 5cdAO7yPN7m7yTpN5TmiDLewko9ukB8uniKKuiQn+ykT0ku8u8FVuQnKRB5s95MAuIEim
	 a8Z7pENq4UGmDrgTIndUw0zVYjL7U5hwek9pevKht9Iin7ixDsnQo+1+FVmDVTjkfeJZr
	 sgKIKfNRD3D9xc8n1wRad6egzQDGluarWXn93mpdKo4xQH8fH0RGhaIw0Mg+6+MPQh8yF
	 mPqcWb4NJQ6ehwgPiI0iSkajostMZ6w6Er288KQ+Elj53qtTNbLIKVgxUSiRKwrpH7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=zju.edu.cn;
	spf=pass smtp.mailfrom=zju.edu.cn;
	arc=none smtp.remote-ip=206.189.79.184
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56229606A319;
	Wed, 21 Oct 2026 05:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56229606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wCncwhfUNhqA3msAQ--.12017S3;
	Wed, 21 Oct 2026 13:40:47 +0800 (CST)
Received: from lutetium.localdomain (unknown [10.162.163.215])
	by mail-app4 (Coremail) with UTF8SMTPA id zi_KCgBXJ5xeUNhqcCJmAA--.33421S3;
	Wed, 21 Oct 2026 13:40:46 +0800 (CST)
From: tangyazhou@zju.edu.cn
Date: Wed, 21 Oct 2026 13:40:35 +0800
Subject: [PATCH bpf-next v2 1/8] bpf: Add UHMUL and SHMUL instructions
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-bpf-hmul-v2-1-88e260099f7d@outlook.com>
References: <20261021-bpf-hmul-v2-0-88e260099f7d@outlook.com>
In-Reply-To: <20261021-bpf-hmul-v2-0-88e260099f7d@outlook.com>
To: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 David Vernet <void@manifault.com>, bpf@ietf.org
Cc: John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Quentin Monnet <qmo@kernel.org>, 
 Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Pu Lehui <pulehui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 Shahab Vahedi <list+bpf@vahedi.org>, Russell King <linux@armlinux.org.uk>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Hengqi Chen <hengqi.chen@gmail.com>, 
 Johan Almbladh <johan.almbladh@anyfinetworks.com>, 
 Paul Burton <paulburton@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Hari Bathini <hbathini@linux.ibm.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Naveen N Rao <naveen@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, 
 Xi Wang <xi.wang@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 "David S. Miller" <davem@davemloft.net>, Wang YanQing <udknight@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 linux-doc@vger.kernel.org, Tianci Cao <ziye@zju.edu.cn>, 
 Yazhou Tang <tangyazhou518@outlook.com>, 
 Shenghao Yuan <shenghaoyuan0928@163.com>, 
 Alexei Starovoitov <ast@kernel.org>
X-Mailer: b4 0.15.2
X-CM-TRANSID:zi_KCgBXJ5xeUNhqcCJmAA--.33421S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgALCmrXxB0b0QABso
X-CM-DELIVERINFO: =?B?DvblwAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9Nte+2zWzrdkvaZkVwVQI+FIRDKY/0eZO65g+lHlVXAEMxseE/p1uqb2G0oDaGRkKRvj
	en1rIj0bnrIH+DqfznhIXCWny1l/Jp05GaoLbDgTgOIH0duDS2HkSSDi5B6Ubw==
X-Coremail-Antispam: 1Uk129KBj93XoW3ZrWUZw43Zr48uF4UtFWfXrc_yoWkGw43pF
	4vy34rtFZ2qrW5u3s7J39FkF1rCa1rWr4UGry7W348AF9rtas5tF4vqr4YqF9xJrWkWayY
	qr9I9ryUu3yUZ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAF
	wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7M4kE6xkIj40Ew7xC0wCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48J
	MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_R67UUUUU==

From: Tianci Cao <ziye@zju.edu.cn>

Define UHMUL and SHMUL as BPF_ALU64 BPF_MUL variants selected by insn->off.
UHMUL returns the high 64 bits of an unsigned 64-by-64-bit product, while
SHMUL returns the high 64 bits of a signed product. Keep off == 0 as the
existing low-half multiplication, and assign off == 1 and off == 2 to
UHMUL and SHMUL, respectively.

These operations are inspired by the UHMUL and SHMUL instructions introduced
as part of the PQR instruction class in sBPF (Solana's BPF variant)[1].

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
integer type. Add interpreter support and disassemble UHMUL and SHMUL
as uh*= and sh*=, respectively. Keep BPF_ALU multiplication restricted
to the existing low-half variant.

Document the encoding and semantics in the BPF instruction set.
Introduce a new divmul64v2 conformance group that includes divmul64 plus
UHMUL and SHMUL. Keep divmul64 unchanged so existing implementations
remain conformant without supporting the new instructions.

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
 .../bpf/standardization/instruction-set.rst        | 37 +++++++++++++++----
 include/linux/filter.h                             | 38 ++++++++++++++++++++
 include/uapi/linux/bpf.h                           |  6 ++++
 kernel/bpf/core.c                                  | 41 +++++++++++++++++++++-
 kernel/bpf/disasm.c                                | 18 ++++++++++
 tools/include/uapi/linux/bpf.h                     |  6 ++++
 6 files changed, 138 insertions(+), 8 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 39c74611752b..6f3cb6bcaa1a 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -142,8 +142,9 @@ This document defines the following conformance groups:
 * atomic32: includes 32-bit atomic operation instructions (see `Atomic operations`_).
 * atomic64: includes atomic32, plus 64-bit atomic operation instructions.
 * divmul32: includes 32-bit division, multiplication, and modulo instructions.
-* divmul64: includes divmul32, plus 64-bit division, multiplication,
+* divmul64: includes divmul32, plus 64-bit division, low-half multiplication,
   and modulo instructions.
+* divmul64v2: includes divmul64, plus high-half multiplication instructions.
 * packet: deprecated packet access instructions.
 
 Instruction encoding
@@ -330,6 +331,8 @@ register.
   ADD    0x0    0        dst += src
   SUB    0x1    0        dst -= src
   MUL    0x2    0        dst \*= src
+  UHMUL  0x2    1        ``dst uh*= src`` (unsigned high half, ``ALU64`` only)
+  SHMUL  0x2    2        ``dst sh*= src`` (signed high half, ``ALU64`` only)
   DIV    0x3    0        dst = (src != 0) ? (dst / src) : 0
   SDIV   0x3    1        dst = (src == 0) ? 0 : ((src == -1 && dst == LLONG_MIN) ? LLONG_MIN : (dst s/ src))
   OR     0x4    0        dst \|= src
@@ -379,13 +382,33 @@ where '(u32)' indicates that the upper 32 bits are zeroed.
 
   dst = dst ^ imm
 
-Note that most arithmetic instructions have 'offset' set to 0. Only three instructions
-(``SDIV``, ``SMOD``, ``MOVSX``) have a non-zero 'offset'.
+Note that most arithmetic instructions have 'offset' set to 0. The following
+instructions may have a non-zero 'offset':
+
+* ``SDIV`` and ``SMOD``: ``offset == 1`` selects the signed variant.
+* ``MOVSX``: ``offset`` selects the source operand width.
+* ``MUL``: ``offset`` selects the multiplication variant (see below).
+
+Division, low-half multiplication (``MUL`` with ``offset == 0``), and
+modulo operations for ``ALU`` are part of the "divmul32" conformance
+group, and their ``ALU64`` variants are part of the "divmul64"
+conformance group.
+
+For ``ALU64`` multiplication, ``offset == 1`` selects unsigned
+high-half multiplication (``UHMUL``), and ``offset == 2`` selects
+signed high-half multiplication (``SHMUL``). Both instructions belong
+to the "divmul64v2" conformance group.
+
+For ``X`` mode, ``src64`` is the 64-bit value in ``src_reg``. For
+``K`` mode, ``src64`` is ``imm`` sign-extended from 32 to 64 bits.
+The operations are::
+
+  UHMUL: dst = (u64)(((u128)dst * (u128)(u64)src64) >> 64)
+  SHMUL: dst = (u64)(((s128)(s64)dst * (s128)(s64)src64) >> 64)
+
+For ``ALU`` multiplication, only ``offset == 0`` is valid. For ``ALU64``
+multiplication, offset values other than 0, 1, and 2 are reserved.
 
-Division, multiplication, and modulo operations for ``ALU`` are part
-of the "divmul32" conformance group, and division, multiplication, and
-modulo operations for ``ALU64`` are part of the "divmul64" conformance
-group.
 The division and modulo operations support both unsigned and signed flavors.
 
 For unsigned operations (``DIV`` and ``MOD``), for ``ALU``,
diff --git a/include/linux/filter.h b/include/linux/filter.h
index e0218e677a1d..fa8a1d18691d 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -23,6 +23,7 @@
 #include <linux/sockptr.h>
 #include <linux/static_call.h>
 #include <linux/u64_stats_sync.h>
+#include <linux/math64.h>
 
 #include <net/sch_generic.h>
 
@@ -152,6 +153,43 @@ struct ctl_table_header;
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
+	return off == BPF_UHMUL || off == BPF_SHMUL;
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
index f29b0aad440c..90c30e5d790b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -34,6 +34,12 @@
 #define BPF_FROM_LE	BPF_TO_LE
 #define BPF_FROM_BE	BPF_TO_BE
 
+/* BPF_MUL off values for high-half multiplication; BPF_ALU64 only. */
+enum bpf_mul_variant {
+	BPF_UHMUL = 1,
+	BPF_SHMUL = 2,
+};
+
 /* jmp encodings */
 #define BPF_JNE		0x50	/* jump != */
 #define BPF_JLT		0xa0	/* LT is unsigned, '<' */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3030beb531d9..f4f8cfa80033 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1943,7 +1943,46 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
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
+		case 0:
+			DST = DST * SRC;
+			break;
+		case BPF_UHMUL:
+			DST = bpf_uhmul64(DST, SRC);
+			break;
+		case BPF_SHMUL:
+			DST = bpf_shmul64((s64)DST, (s64)SRC);
+			break;
+		default:
+			goto default_label;
+		}
+		CONT;
+	ALU_MUL_X:
+		DST = (u32) DST * (u32) SRC;
+		CONT;
+	ALU64_MUL_K:
+		switch (OFF) {
+		case 0:
+			DST = DST * IMM;
+			break;
+		case BPF_UHMUL:
+			DST = bpf_uhmul64(DST, (u64)IMM);
+			break;
+		case BPF_SHMUL:
+			DST = bpf_shmul64((s64)DST, (s32)IMM);
+			break;
+		default:
+			goto default_label;
+		}
+		CONT;
+	ALU_MUL_K:
+		DST = (u32) DST * (u32) IMM;
+		CONT;
 	SHT(LSH, <<)
 	SHT(RSH, >>)
 #undef SHT
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 889fc074496f..0b1bbb27e9e4 100644
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
+	case BPF_UHMUL:
+		return "uh*=";
+	case BPF_SHMUL:
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
index f29b0aad440c..90c30e5d790b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -34,6 +34,12 @@
 #define BPF_FROM_LE	BPF_TO_LE
 #define BPF_FROM_BE	BPF_TO_BE
 
+/* BPF_MUL off values for high-half multiplication; BPF_ALU64 only. */
+enum bpf_mul_variant {
+	BPF_UHMUL = 1,
+	BPF_SHMUL = 2,
+};
+
 /* jmp encodings */
 #define BPF_JNE		0x50	/* jump != */
 #define BPF_JLT		0xa0	/* LT is unsigned, '<' */

-- 
2.56.0

