Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA423DB658;
	Tue,  7 Jul 2026 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419315; cv=none; b=c7PpoRcw+fwNt51x+Ik/ACF59eiMtIaatApXw0/Zuupmwwp6afTHH9U0LZhyUMBtqupD8z00HXD9YNMiNO0UKpzJgwqSlgwPN0LunsqlPNOn/pZ/UlTDNxSknWdFYn5sG833v+e3gpLrqR+AZ509qlO0KmP2LSGeG6Pu9nEKgr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419315; c=relaxed/simple;
	bh=Sak2B1hAJInU+/LyF+YLVbjkhcxdou6Sd9+k/lB2iuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmtx9EealZrk5y0KmrhNOuzxL2lhSERu/fqb91+19vx+wP84T7hbTSb7GLnVaCrk21wNVDrx7soHIr88nb8FQg9QloDjHzaR+9MBw9X7JmFLNRobuOKuMve6dK9cRgZ3TzakMQR/nOoqI6zGMnHCIdLxMp2UVqwu+qk/pryUK2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxGfCu0Uxq4uAAAA--.3794S3;
	Tue, 07 Jul 2026 18:15:10 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxIuSs0UxqL8kDAA--.22379S4;
	Tue, 07 Jul 2026 18:15:09 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] LoongArch: BPF: Move arena register slot below TCC context
Date: Tue,  7 Jul 2026 18:15:06 +0800
Message-ID: <20260707101508.32283-3-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJCxIuSs0UxqL8kDAA--.22379S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAFyxAw4DtFWUZr45Cw4rZwc_yoW5tr47pr
	nxGF1fCF40q3WxtFs7WrWv9ryrGan5WFW3GryUG393JryqvF1fGayUK3WS9a4kZr95Zr1x
	ur90yr129a4qywbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2F4iUUUUU

Currently, the stack layout places the optional arena register slot above
the tail call counter context. When arena_vm_start is dynamically enabled,
it shifts the relative offset of the tcc_ptr slot within the stack frame,
causing hardcoded tracking macros to mismatch and potentially leading to
memory misalignment or corruption.

To fix this, move the arena register save and restore sequences below the
tail call counter context slots in both build_prologue() and epilogue.

Update __build_epilogue() to insert a proper offset decrement to safely
skip the unneeded tcc_ptr reading block while accurately aligning with the
relocated arena slot at the very bottom.

With this patch, the tcc_ptr slot is always positioned at a fixed distance
directly underneath the base callee-saved registers that is independent of
whether the arena features are on.

Fixes: ef54c517a937 ("LoongArch: BPF: Implement PROBE_MEM32 pseudo instructions")
Cc: stable@vger.kernel.org
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 93a181312256..a12b8278d5d4 100644
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

