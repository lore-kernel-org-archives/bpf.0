Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794196991;
	b=2enLzHhrn9YMH2qB1TlNx+W+eVaEbsAJu2SyYa4U+yQuiHZayMAuXX3cxQOL2fbv3rqq
	 CJnqE57XS/AwB24WL+97VEqXIWwl0LwwxcLntUnZt+Sp6dVsoLFxNE7Ai4fvB9goWQVTc
	 +bRs+SV+emO8PRvCM6+pzJwsJDM8FecdQZoszfdK4yITTX2gN+NtjraHl76djdeMRKqVf
	 1sKZo+aTX6oXaGymul2+ntwARlhxU6s6Fv75XUKg9lhOE0VIBSQcEpN6Adz4F4zegmOm3
	 z82iFCtl1YeErfSidDSDRsdlfNGNO+1K4eoKzjJI97nLBow+t8lA5EF81NA4nrPqBUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794196991;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=qkD8MjWseQOJfnadaF4/vhz7UYdj2TH3JKdu6mu1bQg=;
	b=x6k8hHOFEmhsIfbHvLFVmFAhByKYSwarELBUJzBXkrE6aPGmRw9z+oCt/2dO7fEz+H6t
	 h476tp963C4kpOtbQBzABYsuBDvxQm4jzIIrzYPTtQgICnpIAXE/fkkJjhd2efCzUrZj3
	 rCxxHnPm+we0F8XpblwwnV6USqcAUaQ4OC2KvDcEoXzLJRRjv5a9hNBVJLmPMtsguR9y1
	 QLuoYhzJzqxVuNAJi6aJ15WDA+hAX6x4cFA8RceUO9qjV+L1gTQLgsYEzP/zpLXSQ3DCg
	 EWwF4FuQ554U3LGh+/qD+7cye0r0UTaYAJlwqud/SB2HV72JdLzN83lKZuZIX3+gVpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEF4606A325;
	Mon,  9 Nov 2026 04:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DEF4606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxD9P9RfFqBbMdAA--.20307S3;
	Mon, 09 Nov 2026 12:03:09 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAxlMz7RfFq9hszAA--.11822S4;
	Mon, 09 Nov 2026 12:03:08 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] LoongArch: BPF: Make use of beqz and bnez for trampoline branches
Date: Mon,  9 Nov 2026 12:03:06 +0800
Message-ID: <20261109040306.11536-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20261109040306.11536-1-yangtiezhu@loongson.cn>
References: <20261109040306.11536-1-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJAxlMz7RfFq9hszAA--.11822S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3ArWDArWkCFWrXFyDXr4kKrX_yoW7GrWrpr
	yjvwn5JrW8GryfXr95J3yDZr15Jan7WrZFgFZIy392kw4UXFyrtFy8KrWDJFyjgw48uF4F
	qa13tw1I93W5J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jOdb8UUUUU=

Currently, the implementation for BPF trampoline branches does not match
the existing technical comments. The code uses larch_insn_gen_beq, where
the comment indicates beqz should be used.

While the BPF trampoline size is restricted within a single memory page
(at most 64KB on LoongArch) and cannot cross the original 16-bit branch
offset limit of the reg2i16 format, switching to the beqz instruction
(which belongs to the reg1i21 format) avoids explicitly specifying the
zero register during dynamic JIT encoding, resulting in cleaner assembly
generation.

While at it, also apply the same optimization to the bne instruction by
replacing it with bnez and adding a corresponding comment.

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
index b845083d1d74..d7ea515045ec 100644
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

