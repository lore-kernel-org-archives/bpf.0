Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7A7368D63;
	Tue, 30 Jun 2026 02:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782786445; cv=none; b=jvQUjZ+rM9P9L9OJmXqBY0aw+2I48084G5kh3xT7XHC/t8KHP0DFlNcPcInw1a3TxWCdiXnGXV4yraNCeZ7yJtqw0bSL2jE0Pj41D1mwzFBRUZ9ljOmjNcnFVXKer+hfJsTNq931+mMktU//73BgWCjRTDbNNVgYdLP8mRWzUhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782786445; c=relaxed/simple;
	bh=saA1Zntfpxnf9P2xnIIQYrA/79oabXZnCG5oNZoyIDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5AmSCQ7HRO3qe1xljvlwTg6hDmuSuZbQT5sW2a2Z7jj7xhcfWPvcJ0aQajnYDbPwMpCgso8bwIt5l5eAUBwSonnSkspfk0ZsX4766tMIwdzXhuYQ8g/1Ry5B6qnRu+jQdkJVmJX2Y+3GgUYEO1ojfaESBKm10ppvxyFY11uFpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxNeh+KUNq3HcZAA--.59159S3;
	Tue, 30 Jun 2026 10:27:10 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxbcJ6KUNqIH24AA--.20759S5;
	Tue, 30 Jun 2026 10:27:10 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] LoongArch: BPF: Refactor jump offset calculation in tail call
Date: Tue, 30 Jun 2026 10:27:04 +0800
Message-ID: <20260630022705.11536-4-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260630022705.11536-1-yangtiezhu@loongson.cn>
References: <20260630022705.11536-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxbcJ6KUNqIH24AA--.20759S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWF1fXw4DAw4rJw47Ww1DXFc_yoWrGr13pr
	Z09r4kKFWFqr1UGF4DJas7Zw1fKan5Gr17Kr1DG39ayasIvryfWa4Yk3W5ua45CrW8Zryx
	Zrs0yry5ua1UArbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAF
	wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8l38UUUUUU==

In emit_bpf_tail_call(), the macro-based jmp_offset calculation relies
on a fragile prediction equation: "tc_ninsn - (ctx->idx - idx0)". This
calculation model utilizes tc_ninsn from the previous pass to estimate
the remaining stride of the active tail call code block.

Given that the macro relies on stale layout data from a prior pass to
compute the active relative stride, the conditional branches end up
encoding wrong immediate offsets under extra JIT passes. Consequently,
the execution flow leaps into misaligned instruction boundaries,
triggering soft lockups or early loop collapse.

To fix this issue, drop the pass-dependent macro and the intermediate
variable entirely. Instead, explicitly calculate "jmp_offset" using an
absolute target reference anchor: "ctx->offset[insn + 1] - ctx->idx".

Within this new deterministic arithmetic model:
1) "ctx->offset[insn + 1]" maps directly to the absolute instruction
   index of the immediate next eBPF business instruction, serving as
   a rock-solid target label.
2) "ctx->idx" tracks the real-time instruction index of the conditional
   branch currently being emitted.

This guarantees the generated immediate offsets always land precisely
on the next instruction boundary under all multi-pass compilation paths.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 95e3b372a44f..b30132f44541 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -290,17 +290,13 @@ bool bpf_jit_supports_far_kfunc_call(void)
 
 static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 {
-	int off, tc_ninsn = 0;
+	int off, jmp_offset;
 	int tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
 	u8 a1 = LOONGARCH_GPR_A1;
 	u8 a2 = LOONGARCH_GPR_A2;
 	u8 t1 = LOONGARCH_GPR_T1;
 	u8 t2 = LOONGARCH_GPR_T2;
 	u8 t3 = LOONGARCH_GPR_T3;
-	const int idx0 = ctx->idx;
-
-#define cur_offset (ctx->idx - idx0)
-#define jmp_offset (tc_ninsn - (cur_offset))
 
 	/*
 	 * a0: &ctx
@@ -310,12 +306,12 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 	 * if (index >= array->map.max_entries)
 	 *	 goto out;
 	 */
-	tc_ninsn = insn ? ctx->offset[insn+1] - ctx->offset[insn] : ctx->offset[0];
 	emit_zext_32(ctx, a2, true);
 
 	off = offsetof(struct bpf_array, map.max_entries);
 	emit_insn(ctx, ldwu, t1, a1, off);
 	/* bgeu $a2, $t1, jmp_offset */
+	jmp_offset = ctx->offset[insn + 1] - ctx->idx;
 	if (emit_tailcall_jmp(ctx, BPF_JGE, a2, t1, jmp_offset) < 0)
 		goto toofar;
 
@@ -326,6 +322,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 	emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tcc_ptr_off);
 	emit_insn(ctx, ldd, t3, REG_TCC, 0);
 	emit_insn(ctx, addid, t2, LOONGARCH_GPR_ZERO, MAX_TAIL_CALL_CNT);
+	jmp_offset = ctx->offset[insn + 1] - ctx->idx;
 	if (emit_tailcall_jmp(ctx, BPF_JSGE, t3, t2, jmp_offset) < 0)
 		goto toofar;
 
@@ -340,6 +337,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 	off = offsetof(struct bpf_array, ptrs);
 	emit_insn(ctx, ldd, t2, t2, off);
 	/* beq $t2, $zero, jmp_offset */
+	jmp_offset = ctx->offset[insn + 1] - ctx->idx;
 	if (emit_tailcall_jmp(ctx, BPF_JEQ, t2, LOONGARCH_GPR_ZERO, jmp_offset) < 0)
 		goto toofar;
 
@@ -355,8 +353,6 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 toofar:
 	pr_info_once("tail_call: jump too far\n");
 	return -1;
-#undef cur_offset
-#undef jmp_offset
 }
 
 static void emit_store_stack_imm64(struct jit_ctx *ctx, int reg, int stack_off, u64 imm64)
-- 
2.42.0

