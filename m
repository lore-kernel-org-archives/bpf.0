Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4A43859DC;
	Mon,  6 Jul 2026 03:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783309155; cv=none; b=fxnYFmKeWzcaZ71DGggea98PWnGUfin9WptO0zukrUPEAEc1Ai9wMkBGkKoEDt7MR4FqlUmr4lMjGQV5mwCFN9fYx14hZmrBSeE4iuCSX5/qJzYlRjGi9IolNuSiki7M1TGLR0x/Y/r9BfgOfazW4hJU23YWbrQKbjhPi2YcS8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783309155; c=relaxed/simple;
	bh=Ckpt2CSHHwb25p1UyDUjpzzd3BdYbGxFuoocY1xFysw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrwHG9e2uKu0O/s6yL46aDhyqi/7SL4oPBNRJ9DbhliVoOSuyFpybhOYSfMKVMtAxLzhMF9sT2n5IfojB9qZZX8imhZotaZHiqPa1pXXpAmqBlwbDRWoJFWMMtEribTABSXMhW7yR9sZrMj97WgBevrNa+GepHGBfxMhuB9z2As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxGOteI0tqWUQAAA--.1338S3;
	Mon, 06 Jul 2026 11:39:10 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAx3cZbI0tq3LoBAA--.10774S4;
	Mon, 06 Jul 2026 11:39:10 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] LoongArch: BPF: Move arena register slot below TCC context
Date: Mon,  6 Jul 2026 11:39:04 +0800
Message-ID: <20260706033906.1988-3-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJAx3cZbI0tq3LoBAA--.10774S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAFy3JF1DZry3Cw47XF4rtFc_yoW5ury7pr
	nxJF4fGF40q3W7tFs7WrWq9ryrGan5WF13GryDGrZ5JryqvFyfGayUK3WSva4kZr95Zr1x
	ur90yw129F1DJwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jea0PUUUUU=

Currently, the stack layout places the optional arena register slot above
the tail call counter context. When arena_vm_start is dynamically enabled,
it shifts the relative offset of the tcc_ptr slot within the stack frame,
causing hardcoded tracking macros to mismatch and potentially leading to
memory misalignment or corruption.

To fix this, move the arena register save and restore sequences below the
tail call counter context slots in both build_prologue() and epilogue. It
needs to update __build_epilogue() to insert a proper offset decrement to
safely skip the unneeded tcc_ptr reading block while accurately aligning
with the relocated arena slot at the very bottom.

With this patch, the tcc_ptr slot is always positioned at a fixed distance
directly underneath the base callee-saved registers that is independent of
whether the arena features are on.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 719dc4ab7a98..95e3b372a44f 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -124,6 +124,9 @@ static void prepare_bpf_tail_call_cnt(struct jit_ctx *ctx, int *store_offset)
  *                            |           tcc           |
  *                            +-------------------------+
  *                            |           tcc_ptr       |
+ *                            +-------------------------+
+ *                            |           arena         |
+ *                            |         (optional)      |
  *                            +-------------------------+ <--BPF_REG_FP
  *                            |  prog->aux->stack_depth |
  *                            |        (optional)       |
@@ -145,7 +148,7 @@ static void build_prologue(struct jit_ctx *ctx)
 	stack_adjust += sizeof(long) * 2;
 
 	if (ctx->arena_vm_start)
-		stack_adjust += 8;
+		stack_adjust += sizeof(long);
 
 	stack_adjust = round_up(stack_adjust, 16);
 	stack_adjust += bpf_stack_adjust;
@@ -194,13 +197,13 @@ static void build_prologue(struct jit_ctx *ctx)
 	store_offset -= sizeof(long);
 	emit_insn(ctx, std, LOONGARCH_GPR_S5, LOONGARCH_GPR_SP, store_offset);
 
+	prepare_bpf_tail_call_cnt(ctx, &store_offset);
+
 	if (ctx->arena_vm_start) {
 		store_offset -= sizeof(long);
 		emit_insn(ctx, std, REG_ARENA, LOONGARCH_GPR_SP, store_offset);
 	}
 
-	prepare_bpf_tail_call_cnt(ctx, &store_offset);
-
 	emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_adjust);
 
 	if (bpf_stack_adjust)
@@ -241,15 +244,18 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
 	load_offset -= sizeof(long);
 	emit_insn(ctx, ldd, LOONGARCH_GPR_S5, LOONGARCH_GPR_SP, load_offset);
 
+	/* Only restore the TCC state into REG_TCC from the higher slot */
+	load_offset -= sizeof(long);
+	emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, load_offset);
+
+	/* Skip the unused local 'tcc_ptr' slot to align with arena */
+	load_offset -= sizeof(long);
+
 	if (ctx->arena_vm_start) {
 		load_offset -= sizeof(long);
 		emit_insn(ctx, ldd, REG_ARENA, LOONGARCH_GPR_SP, load_offset);
 	}
 
-	/* Only restore the TCC state into REG_TCC from the higher slot */
-	load_offset -= sizeof(long);
-	emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, load_offset);
-
 	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_adjust);
 
 	if (!is_tail_call) {
-- 
2.42.0

