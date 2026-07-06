Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DAF3AA9D1;
	Mon,  6 Jul 2026 03:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783309156; cv=none; b=DgNyQYRzdVKBR2gJZFs27F6FRw08XInDidc44+cNoj8m1vBTIsCaLEoKha7ZOg3tUNYqZAFNvJYOfRK2OXaKnHc0S9Gqg7tVuNqP8tfw4ZJgcrRAE4eZvWR9+KvtYpzyiBoIxiZahUv9J9unoFrzQ1jaQio15AKZJe8ZX7JFrC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783309156; c=relaxed/simple;
	bh=AhaCFGX0hQS6nC3CCuqHUR/+lLn98dO3+TCepviaxHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rI6d+xYroR0QHcGpnZy7bLxR/fqejORrtU7BTOEg1RvX21J/rpYRjRUJ9pvBY4Hzu7crS1JeBL3tTuSyu+PlVUFDqTRtUg3m63jhLZL0KhmkPq9/s0n1eIFtb5ojYTUQ5TSouz6XksjO+sUnWBSumAQQ1iBAyKyM3oJB97W8jkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxmutgI0tqYkQAAA--.1259S3;
	Mon, 06 Jul 2026 11:39:12 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAx3cZbI0tq3LoBAA--.10774S6;
	Mon, 06 Jul 2026 11:39:12 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] LoongArch: BPF: Implement branchless conditional move for TCC
Date: Mon,  6 Jul 2026 11:39:06 +0800
Message-ID: <20260706033906.1988-5-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260706033906.1988-1-yangtiezhu@loongson.cn>
References: <20260706033906.1988-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx3cZbI0tq3LoBAA--.10774S6
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3GFW8KFykur1kJrWDJF4DJrc_yoW3Kw1fpa
	sFkrsYgr4kXF13tFnrAa18urZ8Aws5CrW3WF1DJrWvy3sxury5W3WUKr1agFW5Crn5Xr10
	qr1Yvw42va1DJ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5l1kUUUUU=

The current implementation handles combined bpf2bpf and tail calls by
checking at runtime whether REG_TCC holds a count or an address via a
conditional jump (BPF_JGT against 33). This adds non-negligible branch
prediction overhead in the hot path of tail call execution.

To eliminate this runtime conditional branch in prologue, refactor the
logic of prepare_bpf_tail_call_cnt() with a branchless conditional move
mechanism using unsigned comparison and mask instructions.

When the program is a main program (is_main_prog), the branchless logic
classifies and blends the incoming REG_TCC based on its physical content
according to three possible entrance statuses:

1) Initial Entry (Scalar): Enter via a standard event, where REG_TCC is
   initialized to a pure scalar 0.
2) Inherited Entry (Scalar): Enter via a flat main-to-main tail call,
   where REG_TCC carries an accumulated scalar count (1 to 33) reloaded
   from the prior stack frame.
3) Inherited Entry (Pointer): Enter via a tail call from a subprogram,
   where REG_TCC inherits and carries a massive kernel pointer address
   reloaded from the prior stack frame.

To handle these cases seamlessly without branching:
- sltui identifies the type of REG_TCC. For cases 1 and 2 (scalar count),
  it sets the temporary register T8 to 1. For case 3 (kernel pointer), it
  sets T8 to 0.
- maskeqz handles the local stack pointer (T7). If T8 == 1, it keeps T7
  intact. If T8 == 0, it clears T7 to 0.
- masknez handles the incoming REG_TCC to prevent register pollution.
  If T8 == 1, it clears REG_TCC to 0 (erasing 1~33 scalars). If T8 == 0,
  it keeps the massive kernel pointer intact.
- or combines the results. The scalar cases yield a clean local stack
  pointer by evaluating REG_TCC (0) | T7, while the pointer case leaves
  the inherited global pointer intact by evaluating REG_TCC | T7 (0).

For subprograms, the logic directly backs up the verified TCC pointer
inherited via REG_TCC into its own local "tcc" slot, ensuring the global
counter reference remains safely propagated across function frames.

Finally, the finalized REG_TCC pointer is unconditionally backed up into
the adjacent "tcc_ptr" slot, completing the expected dual-slot stack
layout identically across all entry paths.

This optimization refactors the inner logic of the helper function,
unifies the offset decrement at the function entry, and uses safe
internal temporary registers (T7 and T8) to prevent any JIT register
conflicts, completely removing all runtime branching from the prologue
hot path.

When exposed to complex bpf2bpf + tailcall interleaved control flows,
where inputs shuffle dynamically between a scalar count (0 to 33) and
a massive kernel pointer address, clear improvements are demonstrated.
Furthermore, the optimization significantly eliminated uncertainty in
the execution path, making the performance more stable and predictable.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/inst.h |  6 +++
 arch/loongarch/net/bpf_jit.c      | 74 +++++++++++++++++--------------
 2 files changed, 46 insertions(+), 34 deletions(-)

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
index 45364a15ae5e..b56ae7ed3e06 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -52,50 +52,56 @@ static void prepare_bpf_tail_call_cnt(struct jit_ctx *ctx, int *store_offset)
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
+		 *
+		 * In combined bpf2bpf and tailcall scenarios, REG_TCC can carry
+		 * either a scalar count (0 to 33) or an inherited kernel pointer address.
+		 *
+		 * Entrance status for a main program based on REG_TCC physical content:
+		 * 1) Initial Entry (Scalar): Enter via a standard event, where REG_TCC
+		 *    is initialized to a pure scalar 0.
+		 * 2) Inherited Entry (Scalar): Enter via a flat main-to-main tail call,
+		 *    where REG_TCC carries an accumulated scalar count (1 to 33) reloaded
+		 *    from the prior stack frame.
+		 * 3) Inherited Entry (Pointer): Enter via a tail call from a subprogram,
+		 *    where REG_TCC inherits and carries a massive kernel pointer address
+		 *    reloaded from the prior stack frame.
+		 *
+		 * sltui:   Identify the type of REG_TCC.
+		 *          If REG_TCC < MAX_TAIL_CALL_CNT + 1 (scalar 0~33), sets T8 = 1.
+		 *          If REG_TCC >= MAX_TAIL_CALL_CNT + 1 (kernel pointer), sets T8 = 0.
+		 *
+		 * maskeqz: Handle the local stack pointer (T7).
+		 *          If T8 == 1, keeps T7 intact.
+		 *          If T8 == 0, clears T7 to 0.
+		 *
+		 * masknez: Handle the incoming REG_TCC to prevent register pollution.
+		 *          If T8 == 1, clears REG_TCC to 0 (erasing 1~33 scalars).
+		 *          If T8 == 0, keeps the massive kernel pointer intact.
+		 *
+		 * or:      Combine the results.
+		 *          Scalar Case:  REG_TCC = 0 | T7       -> Clean local stack pointer.
+		 *          Pointer Case: REG_TCC = REG_TCC | 0  -> Clean inherited global pointer.
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

