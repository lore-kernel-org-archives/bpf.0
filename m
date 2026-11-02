Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604504;
	b=B78jJ9De3Wi4nMQrh98mp/kP8DAmWGPZfM+8Znn04dnVFCBU1ChcQgkgSyqkcZWwieXR
	 SER47ZiU+jC+Dv8UFcGK114CkqBJojMi30pkpYWohnVAcmZwHFAIgyhLNMvTbh2wprIWL
	 yJIJQrVTcoppeImySEUswpef2em1ywmJQp4k9swP9Gq34imm9/FOSwPiijGiP3R0GUJJa
	 t80voZ+PmPd1KZa/l3D9RRv7ss5QckYrWNINhke0FPuNBIBWDOP1PFFbYw5gamRPNRnEI
	 yCavMbAaLtgCdtgBvndZQyLwjyU1Oqak3Z99s7jEk8UFdJj/MnGQmX77iqI2z1QvpfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604504;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=wyRusqBZzBrKbrpoLy/X6K+wh9AVozBslxwgCH9r4So=;
	b=bjH0Fn7Bc0YOOEw8nI4/q8K6NgmWxcwCZ9X/rn/YxRKuUrTNxh1L5p666wrS9cDM4JNF
	 Z656KHrRTXvMJx+1E1qe6DDMcDHYHzNCeC/Y5ldQVlR2K1MlE3Z5ITeaZYouVJu0kGDM0
	 jST5ijNsxj9fTYOqOMm7nd49F7e5x57IqO1DTa/b6tJ1m3FmublHqg9jV0kMYl50hxzlv
	 lQDZW1wBs8uBE1abTnh+fQqhRky6UXMpV/XcsXFC6fG7wdwLVAyC+VfoMXi2iPz1XCHwz
	 apShzyOCmWOfosSR4gwFDfKEv3598AZDf1fg2hoMLJnuO21/vKEx0IKKd5pVGW5WvAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F097606A32C;
	Mon,  2 Nov 2026 07:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F097606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxjdKNO+hqXHQbAA--.13605S3;
	Mon, 02 Nov 2026 15:28:13 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAx2c2KO+hqSsoxAA--.37951S4;
	Mon, 02 Nov 2026 15:28:13 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] LoongArch: BPF: Use beqz and bnez instructions for trampoline
Date: Mon,  2 Nov 2026 15:28:08 +0800
Message-ID: <20261102072808.23080-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20261102072808.23080-1-yangtiezhu@loongson.cn>
References: <20261102072808.23080-1-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJAx2c2KO+hqSsoxAA--.37951S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3ArWkKryrKw4kurWxJr45twc_yoW7GFW5pr
	Wjvwn5ArW8GryfXr95X3yDZr13Jan7WrZFgFZxt392kw4UXF90qFy8KryDtFyjgw48uF4F
	qa13tw17u3W5J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1a6r1DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IUb58n5UUUUU==

Currently, the implementation for BPF trampoline branches does not match
the existing technical comments. The code uses larch_insn_gen_beq, where
the comment indicates beqz should be used.

Moreover, the beq instruction belongs to the reg2i16 format which limits
the jump offset to 16 bits (+/-128KB). After using the beqz instruction
which belongs to the reg1i21 format, the jump range will be extended to
21 bits (+/-4MB). This mitigates potential branch overflow risks in the
complex BPF trampolines.

While at it, also apply the same optimization to the bne instruction by
replacing it with bnez and adding a corresponding comment.

Fixes: f9b6b41f0cf3 ("LoongArch: BPF: Add basic bpf trampoline support")
Cc: stable@vger.kernel.org
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/inst.h | 21 +++++++++++++++++++++
 arch/loongarch/kernel/inst.c      | 28 ++++++++++++++++++++++++++++
 arch/loongarch/net/bpf_jit.c      |  5 +++--
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index b55aae325300..e061f966f7d1 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -535,6 +535,8 @@ u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm);
 u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
 u32 larch_insn_gen_beq(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
 u32 larch_insn_gen_bne(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
+u32 larch_insn_gen_beqz(enum loongarch_gpr rj, int imm);
+u32 larch_insn_gen_bnez(enum loongarch_gpr rj, int imm);
 u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
 
 static inline bool signed_imm_check(long val, unsigned int bit)
@@ -592,6 +594,25 @@ DEF_EMIT_REG1I20_FORMAT(lu12iw, lu12iw_op)
 DEF_EMIT_REG1I20_FORMAT(lu32id, lu32id_op)
 DEF_EMIT_REG1I20_FORMAT(pcaddu18i, pcaddu18i_op)
 
+#define DEF_EMIT_REG1I21_FORMAT(NAME, OP)				\
+static inline void emit_##NAME(union loongarch_instruction *insn,	\
+			       enum loongarch_gpr rj, int offset)	\
+{									\
+	unsigned int immediate_l, immediate_h;				\
+									\
+	immediate_l = offset & 0xffff;					\
+	offset >>= 16;							\
+	immediate_h = offset & 0x1f;					\
+									\
+	insn->reg1i21_format.opcode = OP;				\
+	insn->reg1i21_format.immediate_l = immediate_l;			\
+	insn->reg1i21_format.rj = rj;					\
+	insn->reg1i21_format.immediate_h = immediate_h;			\
+}
+
+DEF_EMIT_REG1I21_FORMAT(beqz, beqz_op)
+DEF_EMIT_REG1I21_FORMAT(bnez, bnez_op)
+
 #define DEF_EMIT_REG2_FORMAT(NAME, OP)					\
 static inline void emit_##NAME(union loongarch_instruction *insn,	\
 			       enum loongarch_gpr rd,			\
diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index 0b9228b7c13a..0d5076cfd7d1 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -428,6 +428,34 @@ u32 larch_insn_gen_bne(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
 	return insn.word;
 }
 
+u32 larch_insn_gen_beqz(enum loongarch_gpr rj, int imm)
+{
+	union loongarch_instruction insn;
+
+	if ((imm & 3) || imm < -SZ_4M || imm >= SZ_4M) {
+		pr_warn("The generated beqz instruction is out of range.\n");
+		return INSN_BREAK;
+	}
+
+	emit_beqz(&insn, rj, imm >> 2);
+
+	return insn.word;
+}
+
+u32 larch_insn_gen_bnez(enum loongarch_gpr rj, int imm)
+{
+	union loongarch_instruction insn;
+
+	if ((imm & 3) || imm < -SZ_4M || imm >= SZ_4M) {
+		pr_warn("The generated bnez instruction is out of range.\n");
+		return INSN_BREAK;
+	}
+
+	emit_bnez(&insn, rj, imm >> 2);
+
+	return insn.word;
+}
+
 u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
 {
 	union loongarch_instruction insn;
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 01c12da168ee..8cc78efe722d 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1819,7 +1819,7 @@ static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	/* update branch with beqz */
 	if (ctx->image) {
 		int offset = (void *)(&ctx->image[ctx->idx]) - (void *)branch;
-		*branch = larch_insn_gen_beq(LOONGARCH_GPR_A0, LOONGARCH_GPR_ZERO, offset);
+		*branch = larch_insn_gen_beqz(LOONGARCH_GPR_A0, offset);
 	}
 
 	/* arg1: prog */
@@ -2132,9 +2132,10 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 		emit_insn(ctx, std, regmap[BPF_REG_0], LOONGARCH_GPR_FP, -(retval_off - 8));
 	}
 
+	/* update branches with bnez */
 	for (i = 0; ctx->image && i < fmod_ret->nr_nodes; i++) {
 		int offset = (void *)(&ctx->image[ctx->idx]) - (void *)branches[i];
-		*branches[i] = larch_insn_gen_bne(LOONGARCH_GPR_T1, LOONGARCH_GPR_ZERO, offset);
+		*branches[i] = larch_insn_gen_bnez(LOONGARCH_GPR_T1, offset);
 	}
 
 	/* Set "is_return" flag for fsession */
-- 
2.42.0

