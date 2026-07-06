Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11D03AE6F7;
	Mon,  6 Jul 2026 03:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783309166; cv=none; b=Vz5jkG4sSIwf2B9Y0E2kyEvGyeGGOQMhTcwmV0b95gDQjc6+MOhP6OMii4Jj2Qorr3XVR60haleIoTmVVOzxSYOdEwDMs1w55Wy41oNKxtlf167XoadDMuYKuGgnCe+OrYwM8oPLk47q7P4KbTccVot3zlpvCxgoKq3tAX3d7Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783309166; c=relaxed/simple;
	bh=sK7OWxjHSEVseZ/UmyKv4Kiu1kp61naUowa+BqgN+AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nH+rBwdF7Ick8qM0ZjwkGQR5HS1tay0awa9Q8NmhZJfFvxS4gxNLyt99YOjVdGNCHwx5BN3kHS3T1ekI+054LhnyBE0Dex7cOAuwzvGRGcTCjrIwDCsQCmieG54/Fdc07JgOJ/4WEz1En4xBejpfYDSTjVCd48qRFV+wBPBv3Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxOOtgI0tqXkQAAA--.1369S3;
	Mon, 06 Jul 2026 11:39:12 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAx3cZbI0tq3LoBAA--.10774S5;
	Mon, 06 Jul 2026 11:39:10 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] LoongArch: BPF: Refactor jump offset calculation in tail call
Date: Mon,  6 Jul 2026 11:39:05 +0800
Message-ID: <20260706033906.1988-4-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJAx3cZbI0tq3LoBAA--.10774S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWF1fXw4DAw4rGF1fKF1rAFc_yoWrKr13pr
	Z0gr4kt3yrXr1UGF4DJas7Z3WfKan5Cr47GF1DG39Yy34avrn2gFyYk3W5uay5C3y8Zryx
	Xrs0yry5Za1UAwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07josjUUUUUU=

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

However, during the initial size-estimation pass, the target address
"ctx->offset[insn + 1]" is not yet populated and will evaluate to 0,
resulting in "jmp_offset = -ctx->idx". For large eBPF programs, this
inflated negative offset would overflow the 16-bit signed immediate
limit of LoongArch conditional branch instructions, causing the range
validation inside emit_tailcall_jmp() to abort the JIT compilation
prematurely.

To bypass this initialization bottleneck cleanly without changing any
function signatures, leverage the "ctx->image" pointer to safely detect
the initial pass. Since conditional branch instructions on LoongArch
maintain a fixed 4-byte width regardless of the target displacement,
injecting a safe dummy offset (0) when "ctx->image == NULL" preserves
accurate size estimation while preventing 16-bit range check failures.

Within this new deterministic arithmetic model:
1) "ctx->offset[insn + 1]" maps directly to the absolute instruction
   index of the immediate next eBPF business instruction, serving as
   a rock-solid target label.
2) "ctx->idx" tracks the real-time instruction index of the conditional
   branch currently being emitted.

This guarantees the generated immediate offsets always land precisely
on the next instruction boundary under all multi-pass compilation paths
and all code size dimensions.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 95e3b372a44f..45364a15ae5e 100644
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
+	jmp_offset = ctx->image ? (ctx->offset[insn + 1] - ctx->idx) : 0;
 	if (emit_tailcall_jmp(ctx, BPF_JGE, a2, t1, jmp_offset) < 0)
 		goto toofar;
 
@@ -326,6 +322,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 	emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tcc_ptr_off);
 	emit_insn(ctx, ldd, t3, REG_TCC, 0);
 	emit_insn(ctx, addid, t2, LOONGARCH_GPR_ZERO, MAX_TAIL_CALL_CNT);
+	jmp_offset = ctx->image ? (ctx->offset[insn + 1] - ctx->idx) : 0;
 	if (emit_tailcall_jmp(ctx, BPF_JSGE, t3, t2, jmp_offset) < 0)
 		goto toofar;
 
@@ -340,6 +337,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 	off = offsetof(struct bpf_array, ptrs);
 	emit_insn(ctx, ldd, t2, t2, off);
 	/* beq $t2, $zero, jmp_offset */
+	jmp_offset = ctx->image ? (ctx->offset[insn + 1] - ctx->idx) : 0;
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

