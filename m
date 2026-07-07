Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039603DC861;
	Tue,  7 Jul 2026 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419316; cv=none; b=Mh6YP7MEfbOpI8dDe/MsfAX5tyk+8HmGinZvOVsMayCRoQ2MCNLjhcp5r8gQ/ae7wjJaIBmUy7Fp75/VnEBoMvbnp7dRtrgpNQyuD2t8EBFAwgY9//1TEPk1wvnJoNURjZkyLQruy43hFLKTqfIiBbkTuvcTy8+nSV5I1OPlLdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419316; c=relaxed/simple;
	bh=QosjHO6u4TWIJoAHNBF2xhKzClo4gTzM7v+TW+uJj1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnkcSrF8VK1DNSkaD0vVJ1D4oIHuNJtqT2YDNSpePQTcWPQwFkTE78F9y55YHvuVV9+9bV37AUFmHCPd24Iyqha71KNZ9zVSQerkM7+lgSnKIh46ZFvDiqfmw9jkWSY96tWncqwU9uE6nxoKFqT/I0ufZTOzOyazoJzrMnvCKS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Axiuuw0Uxq6uAAAA--.3921S3;
	Tue, 07 Jul 2026 18:15:12 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxIuSs0UxqL8kDAA--.22379S6;
	Tue, 07 Jul 2026 18:15:11 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] LoongArch: BPF: Implement branchless conditional move for TCC
Date: Tue,  7 Jul 2026 18:15:08 +0800
Message-ID: <20260707101508.32283-5-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260707101508.32283-1-yangtiezhu@loongson.cn>
References: <20260707101508.32283-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxIuSs0UxqL8kDAA--.22379S6
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3WFy5Xr1rKw1kCF17AF1kJFc_yoW7GF4kpa
	sFyrs5Wr4kWr13tF97ZF4Uurs5Jan5CFyagFn8JFZ2yr9xZa48G3WUKw1S9Fy5JFn8Zr1I
	vrn0vr12v3WDJrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcCD7UUUUU

The current implementation handles combined bpf2bpf and tail calls by
checking at runtime whether REG_TCC holds a scalar count or a pointer
address via a conditional jump. This adds branch prediction overhead
in the hot path of tail call execution.

To implement branchless conditional move, use an unsigned comparison
(sltui) combined with mask instructions (maskeqz/masknez) to achieve
branchless classification and blending of incoming scalar counts and
kernel pointers in REG_TCC.

This optimization refactors the inner logic of the helper function,
unifies the offset decrement at the function entry, and completely
removes all runtime branching from the prologue hot path.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/inst.h |  6 ++++
 arch/loongarch/net/bpf_jit.c      | 47 +++++++++----------------------
 2 files changed, 19 insertions(+), 34 deletions(-)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 76b723590023..19feae166e1c 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -97,6 +97,7 @@ enum reg2i6_op {
 };
 
 enum reg2i12_op {
+	sltui_op	= 0x09,
 	addiw_op	= 0x0a,
 	addid_op	= 0x0b,
 	lu52id_op	= 0x0c,
@@ -153,6 +154,8 @@ enum reg3_op {
 	addd_op		= 0x21,
 	subw_op		= 0x22,
 	subd_op		= 0x23,
+	maskeqz_op	= 0x26,
+	masknez_op	= 0x27,
 	nor_op		= 0x28,
 	and_op		= 0x29,
 	or_op		= 0x2a,
@@ -644,6 +647,7 @@ static inline void emit_##NAME(union loongarch_instruction *insn,	\
 	insn->reg2i12_format.rj = rj;					\
 }
 
+DEF_EMIT_REG2I12_FORMAT(sltui, sltui_op)
 DEF_EMIT_REG2I12_FORMAT(addiw, addiw_op)
 DEF_EMIT_REG2I12_FORMAT(addid, addid_op)
 DEF_EMIT_REG2I12_FORMAT(lu52id, lu52id_op)
@@ -749,6 +753,8 @@ DEF_EMIT_REG3_FORMAT(divd, divd_op)
 DEF_EMIT_REG3_FORMAT(modd, modd_op)
 DEF_EMIT_REG3_FORMAT(divdu, divdu_op)
 DEF_EMIT_REG3_FORMAT(moddu, moddu_op)
+DEF_EMIT_REG3_FORMAT(maskeqz, maskeqz_op)
+DEF_EMIT_REG3_FORMAT(masknez, masknez_op)
 DEF_EMIT_REG3_FORMAT(and, and_op)
 DEF_EMIT_REG3_FORMAT(or, or_op)
 DEF_EMIT_REG3_FORMAT(xor, xor_op)
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 8d6738103f59..9e9d98b21812 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -52,50 +52,29 @@ static void prepare_bpf_tail_call_cnt(struct jit_ctx *ctx, int *store_offset)
 	const struct bpf_prog *prog = ctx->prog;
 	const bool is_main_prog = !bpf_is_subprog(prog);
 
+	*store_offset -= sizeof(long);
 	if (is_main_prog) {
-		/*
-		 * LOONGARCH_GPR_T3 = MAX_TAIL_CALL_CNT
-		 * if (REG_TCC > T3 )
-		 *	std REG_TCC -> LOONGARCH_GPR_SP + store_offset
-		 * else
-		 *	std REG_TCC -> LOONGARCH_GPR_SP + store_offset
-		 *	REG_TCC = LOONGARCH_GPR_SP + store_offset
-		 *
-		 * std REG_TCC -> LOONGARCH_GPR_SP + store_offset
-		 *
-		 * The purpose of this code is to first push the TCC into stack,
-		 * and then push the address of TCC into stack.
-		 * In cases where bpf2bpf and tailcall are used in combination,
-		 * the value in REG_TCC may be a count or an address,
-		 * these two cases need to be judged and handled separately.
-		 */
-		emit_insn(ctx, addid, LOONGARCH_GPR_T3, LOONGARCH_GPR_ZERO, MAX_TAIL_CALL_CNT);
-		*store_offset -= sizeof(long);
-
-		emit_cond_jmp(ctx, BPF_JGT, REG_TCC, LOONGARCH_GPR_T3, 4);
-
-		/*
-		 * If REG_TCC < MAX_TAIL_CALL_CNT, the value in REG_TCC is a count,
-		 * push tcc into stack
-		 */
+		/* Save entrance TCC state (scalar count or kernel pointer) to local 'tcc' slot */
 		emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP, *store_offset);
 
-		/* Push the address of TCC into the REG_TCC */
-		emit_insn(ctx, addid, REG_TCC, LOONGARCH_GPR_SP, *store_offset);
-
-		emit_uncond_jmp(ctx, 2);
+		/* Compute the absolute pointer to the local 'tcc' slot */
+		emit_insn(ctx, addid, LOONGARCH_GPR_T7, LOONGARCH_GPR_SP, *store_offset);
 
 		/*
-		 * If REG_TCC > MAX_TAIL_CALL_CNT, the value in REG_TCC is an address,
-		 * push tcc_ptr into stack
+		 * Branchless classification and blending:
+		 * Combine interleaved inputs between a scalar count (0 to 33)
+		 * and a kernel pointer address without runtime branching.
 		 */
-		emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP, *store_offset);
+		emit_insn(ctx, sltui, LOONGARCH_GPR_T8, REG_TCC, MAX_TAIL_CALL_CNT + 1);
+		emit_insn(ctx, maskeqz, LOONGARCH_GPR_T7, LOONGARCH_GPR_T7, LOONGARCH_GPR_T8);
+		emit_insn(ctx, masknez, REG_TCC, REG_TCC, LOONGARCH_GPR_T8);
+		emit_insn(ctx, or, REG_TCC, REG_TCC, LOONGARCH_GPR_T7);
 	} else {
-		*store_offset -= sizeof(long);
+		/* Subprograms: backup the verified TCC pointer inherited via REG_TCC */
 		emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP, *store_offset);
 	}
 
-	/* Push tcc_ptr into stack */
+	/* Store the finalized TCC pointer value securely into the local 'tcc_ptr' slot */
 	*store_offset -= sizeof(long);
 	emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP, *store_offset);
 }
-- 
2.42.0

