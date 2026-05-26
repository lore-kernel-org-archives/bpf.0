Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28281309EEC;
	Tue, 26 May 2026 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779779003; cv=none; b=meS6Tam9EOal+gS5pbcCq8zBm2wwPWEiWNjE7j0V2Vvw2vFYFPvUR6pnytQYUdZFQ89LADmML/ETTS0WEwtc2X/SxIHfMMohiSCrd1C17ZgMpI7RpVnz306DxiiTfIrC0V4QYrCPT0BNP5aRmabxjXc3guJVsNT1iYL8irvfTZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779779003; c=relaxed/simple;
	bh=9w7CqJNsJcbGDXBvJNHlxDXz5Eplih9gYNRu1iRGRL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQbESQF8J5e+lL5pLG5u3oJIjSUvYV54a/KiB+wm26oF2pDxgv2nvQ4dDda02qZVIz+No3+cTwNuRkspI3hQ9GekfkI6Va/RO3djt01Qx8YONCcGmQtD2Hh6ihlZMmsPIcbiVXSa1ANHbI2VFV5ywRkUKfpSYn5v0qIgtbbBtp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx3em3RRVqdE0NAA--.37795S3;
	Tue, 26 May 2026 15:03:19 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxysG0RRVqq1+RAA--.11006S3;
	Tue, 26 May 2026 15:03:18 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] LoongArch: BPF: Fix outdated tail call comments
Date: Tue, 26 May 2026 15:03:15 +0800
Message-ID: <20260526070316.28228-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260526070316.28228-1-yangtiezhu@loongson.cn>
References: <20260526070316.28228-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxysG0RRVqq1+RAA--.11006S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWFy7uF15Cw1DCw4xXry8CrX_yoW5Ar4rpr
	4qk3WrGrWvgw42kF1kJw409r1agFs3GrW7ur4UAw4Fywn8Z34fK3ZFyr13CF98J3W8Gry8
	urnYywsI9F1kAwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j1LvtUUUUU=

The current LoongArch BPF JIT implementation hardcodes the number of
prologue instructions skipped during a tail call as a magic number '7'
in the jirl instruction. However, the accompanying comment explaining
this offset is completely outdated. It inaccurately states that only
a single TCC initialization instruction is bypassed, but in reality,
multiple setup slots are skipped, so fix these outdated comments in
__build_epilogue().

While at it, refine the comments in build_prologue() to describe the
skipped setup slots (RA saving, fentry nops, and the TCC register slot)
using proper dynamic tracing context. Also, remove the magic number '7'
by introducing descriptive macros to formally define the prologue layout
and make the tail call jump offset self-documenting.

Fixes: 61319d15a560 ("LoongArch: BPF: Adjust the jump offset of tail calls")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 24913dc7f4e8..77261fc7867a 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -9,7 +9,14 @@
 
 #define LOONGARCH_MAX_REG_ARGS 8
 
+#define LOONGARCH_SAVE_RA_NINSNS   1
 #define LOONGARCH_LONG_JUMP_NINSNS 5
+#define LOONGARCH_TCC_SLOT_NINSNS  1
+
+#define LOONGARCH_PROLOGUE_SKIP_INSNS (LOONGARCH_SAVE_RA_NINSNS + \
+				       LOONGARCH_LONG_JUMP_NINSNS + \
+				       LOONGARCH_TCC_SLOT_NINSNS)
+
 #define LOONGARCH_LONG_JUMP_NBYTES (LOONGARCH_LONG_JUMP_NINSNS * 4)
 
 #define LOONGARCH_FENTRY_NINSNS 2
@@ -143,8 +150,13 @@ static void build_prologue(struct jit_ctx *ctx)
 	stack_adjust = round_up(stack_adjust, 16);
 	stack_adjust += bpf_stack_adjust;
 
+	/*
+	 * Save the original return address to a temporary register to prevent
+	 * it from being overwritten, then reserve space for the long jump and
+	 * fentry trampoline slot for dynamically patching by ftrace at runtime.
+	 * These instructions are bypassed during a tail call invocation.
+	 */
 	move_reg(ctx, LOONGARCH_GPR_T0, LOONGARCH_GPR_RA);
-	/* Reserve space for the move_imm + jirl instruction */
 	for (i = 0; i < LOONGARCH_LONG_JUMP_NINSNS; i++)
 		emit_insn(ctx, nop);
 
@@ -253,10 +265,11 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
 		emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_RA, 0);
 	} else {
 		/*
-		 * Call the next bpf prog and skip the first instruction
-		 * of TCC initialization.
+		 * Tail call to the next BPF program, passing offset in number
+		 * of instructions to jirl to bypass the initial setup slots.
 		 */
-		emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T3, 7);
+		emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T3,
+			  LOONGARCH_PROLOGUE_SKIP_INSNS);
 	}
 }
 
-- 
2.42.0

