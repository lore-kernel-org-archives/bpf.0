Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EDE426434;
	Tue,  7 Jul 2026 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433891; cv=none; b=LV2I5tDWoaJ5DliGo0Q9VX8l381z8aA8D3P9Y9DWKvckTdMzfEGuYvBVMOphJl5YMpyueZHd+INpcJJByB1315ok24U1wNqbeM9HSqW1OLfFs+Dmfo9vA4aWhDCWmZh1lmSpanTPfWuC01N6db5rWkbVOUVuf6WQxekn76i+5Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433891; c=relaxed/simple;
	bh=2KldgqvE24bMlyBfkgUcLb0OunmjGjstx0DjZWA5kjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NkXxkb3mtjRMr9s5Sov/KJKrqLP9qZM2Zu7DEpUiHfXVQj1A97cuIHDn3fZIRj3908yXJaSluuuN0isrLcpegntpEWJwUwfaIoaqvu3F2xpNmHvDgXcCE9+JFkfV3Aq1RUBA9Brt4FsTedgqTVeAUvtdZIgfZvsrjr9EedpDvJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gvjx20H65zKHMND;
	Tue,  7 Jul 2026 22:17:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 79E274093A;
	Tue,  7 Jul 2026 22:18:01 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgBnd3OXCk1qwUWNAQ--.43005S7;
	Tue, 07 Jul 2026 22:18:01 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next v5 5/6] riscv, bpf: Mixing bpf2bpf and tailcalls
Date: Tue,  7 Jul 2026 14:22:18 +0000
Message-Id: <20260707142219.2871758-6-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707142219.2871758-1-pulehui@huaweicloud.com>
References: <20260707142219.2871758-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnd3OXCk1qwUWNAQ--.43005S7
X-Coremail-Antispam: 1UD129KBjvJXoW3KF48XF4xAr17JryDur4DJwb_yoWkXr4kp3
	4kKw4SkFW0qa15AFZrGF1DXw1akw4vvFnIkryfK393Ca1qq34kG3WxKF4YvFy5C34rZw1x
	Xrs0yw1aga17JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
	WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU0sqXPUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

In the current RV64 JIT, if we just don't initialize the TCC in subprog,
the TCC can be propagated from the parent process to the subprocess, but
the updated TCC of the parent process cannot be restored when the
subprocess exits. Since the RV64 TCC is initialized before saving the
callee saved registers into the stack, we cannot use the callee saved
register to pass the TCC, otherwise the original value of the callee
saved register will be destroyed. So we implemented mixing bpf2bpf and
tailcalls similar to x86_64, i.e. using a non-callee saved register to
transfer the TCC between functions, and saving that register to the
stack to protect the TCC value. As for the tailcall hierarchy issue,
inspired by the s390's low-overhead approach, we store TCC from
RV_REG_TCC back to stack after calling bpf2bpf call or calling orig bpf
func in bpf trampoline.

Tests test_bpf.ko and test_verifier have passed, as well as the relative
testcases of test_progs*.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit.h        |   1 +
 arch/riscv/net/bpf_jit_comp64.c | 108 ++++++++++++++++----------------
 2 files changed, 54 insertions(+), 55 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index da0271790244..419b9d795f2a 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -81,6 +81,7 @@ struct rv_jit_context {
 	int ex_jmp_off;
 	unsigned long flags;
 	int stack_size;
+	int tcc_offset;
 	u64 arena_vm_start;
 	u64 user_vm_start;
 };
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 7c6304e0b846..823262ca47eb 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -24,7 +24,6 @@
 #define RV_TAILCALL_OFFSET ((RV_FENTRY_NINSNS + 1) * 4)
 
 #define RV_REG_TCC RV_REG_A6
-#define RV_REG_TCC_SAVED RV_REG_S6 /* Store A6 in S6 if program do calls */
 #define RV_REG_ARENA RV_REG_S7 /* For storing arena_vm_start */
 
 static const int regmap[] = {
@@ -58,14 +57,12 @@ static const int pt_regmap[] = {
 };
 
 enum {
-	RV_CTX_F_SEEN_TAIL_CALL =	0,
 	RV_CTX_F_SEEN_CALL =		RV_REG_RA,
 	RV_CTX_F_SEEN_S1 =		RV_REG_S1,
 	RV_CTX_F_SEEN_S2 =		RV_REG_S2,
 	RV_CTX_F_SEEN_S3 =		RV_REG_S3,
 	RV_CTX_F_SEEN_S4 =		RV_REG_S4,
 	RV_CTX_F_SEEN_S5 =		RV_REG_S5,
-	RV_CTX_F_SEEN_S6 =		RV_REG_S6,
 };
 
 static u8 bpf_to_rv_reg(int bpf_reg, struct rv_jit_context *ctx)
@@ -78,7 +75,6 @@ static u8 bpf_to_rv_reg(int bpf_reg, struct rv_jit_context *ctx)
 	case RV_CTX_F_SEEN_S3:
 	case RV_CTX_F_SEEN_S4:
 	case RV_CTX_F_SEEN_S5:
-	case RV_CTX_F_SEEN_S6:
 		__set_bit(reg, &ctx->flags);
 	}
 	return reg;
@@ -93,7 +89,6 @@ static bool seen_reg(int reg, struct rv_jit_context *ctx)
 	case RV_CTX_F_SEEN_S3:
 	case RV_CTX_F_SEEN_S4:
 	case RV_CTX_F_SEEN_S5:
-	case RV_CTX_F_SEEN_S6:
 		return test_bit(reg, &ctx->flags);
 	}
 	return false;
@@ -109,32 +104,6 @@ static void mark_call(struct rv_jit_context *ctx)
 	__set_bit(RV_CTX_F_SEEN_CALL, &ctx->flags);
 }
 
-static bool seen_call(struct rv_jit_context *ctx)
-{
-	return test_bit(RV_CTX_F_SEEN_CALL, &ctx->flags);
-}
-
-static void mark_tail_call(struct rv_jit_context *ctx)
-{
-	__set_bit(RV_CTX_F_SEEN_TAIL_CALL, &ctx->flags);
-}
-
-static bool seen_tail_call(struct rv_jit_context *ctx)
-{
-	return test_bit(RV_CTX_F_SEEN_TAIL_CALL, &ctx->flags);
-}
-
-static u8 rv_tail_call_reg(struct rv_jit_context *ctx)
-{
-	mark_tail_call(ctx);
-
-	if (seen_call(ctx)) {
-		__set_bit(RV_CTX_F_SEEN_S6, &ctx->flags);
-		return RV_REG_S6;
-	}
-	return RV_REG_A6;
-}
-
 static bool is_32b_int(s64 val)
 {
 	return -(1L << 31) <= val && val < (1L << 31);
@@ -259,15 +228,14 @@ static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
 		emit_ld(RV_REG_S5, store_offset, RV_REG_SP, ctx);
 		store_offset -= 8;
 	}
-	if (seen_reg(RV_REG_S6, ctx)) {
-		emit_ld(RV_REG_S6, store_offset, RV_REG_SP, ctx);
-		store_offset -= 8;
-	}
 	if (ctx->arena_vm_start) {
 		emit_ld(RV_REG_ARENA, store_offset, RV_REG_SP, ctx);
 		store_offset -= 8;
 	}
 
+	/* restore TCC from stack to RV_REG_TCC */
+	emit_ld(RV_REG_TCC, ctx->tcc_offset, RV_REG_SP, ctx);
+
 	emit_addi(RV_REG_SP, RV_REG_SP, stack_adjust, ctx);
 	/* Set return value. */
 	if (!is_tail_call)
@@ -354,7 +322,6 @@ static void emit_branch(u8 cond, u8 rd, u8 rs, int rvoff,
 static int emit_bpf_tail_call(int insn, struct rv_jit_context *ctx)
 {
 	int tc_ninsn, off, start_insn = ctx->ninsns;
-	u8 tcc = rv_tail_call_reg(ctx);
 
 	/* a0: &ctx
 	 * a1: &array
@@ -377,7 +344,8 @@ static int emit_bpf_tail_call(int insn, struct rv_jit_context *ctx)
 	/* if (--TCC < 0)
 	 *     goto out;
 	 */
-	emit_addi(RV_REG_TCC, tcc, -1, ctx);
+	emit_ld(RV_REG_TCC, ctx->tcc_offset, RV_REG_SP, ctx);
+	emit_addi(RV_REG_TCC, RV_REG_TCC, -1, ctx);
 	off = ninsns_rvoff(tc_ninsn - (ctx->ninsns - start_insn));
 	emit_branch(BPF_JSLT, RV_REG_TCC, RV_REG_ZERO, off, ctx);
 
@@ -393,6 +361,9 @@ static int emit_bpf_tail_call(int insn, struct rv_jit_context *ctx)
 	off = ninsns_rvoff(tc_ninsn - (ctx->ninsns - start_insn));
 	emit_branch(BPF_JEQ, RV_REG_T2, RV_REG_ZERO, off, ctx);
 
+	/* store updated TCC back to stack */
+	emit_sd(RV_REG_SP, ctx->tcc_offset, RV_REG_TCC, ctx);
+
 	/* goto *(prog->bpf_func + RV_TAILCALL_OFFSET); */
 	off = offsetof(struct bpf_prog, bpf_func);
 	if (is_12b_check(off, insn))
@@ -1027,7 +998,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	int i, ret, offset;
 	int *branches_off = NULL;
 	int stack_size = 0, nr_arg_slots = 0;
-	int retval_off, args_off, func_meta_off, ip_off, run_ctx_off, sreg_off, stk_arg_off;
+	int retval_off, args_off, func_meta_off, ip_off;
+	int run_ctx_off, sreg_off, stk_arg_off, tcc_off;
 	int cookie_off, cookie_cnt;
 	struct bpf_tramp_nodes *fentry = &tnodes[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_nodes *fexit = &tnodes[BPF_TRAMP_FEXIT];
@@ -1078,6 +1050,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	 *
 	 * FP - sreg_off    [ callee saved reg	]
 	 *
+	 * FP - tcc_off     [ tail call count	] BPF_TRAMP_F_TAIL_CALL_CTX
+	 *
 	 *		    [ pads              ] pads for 16 bytes alignment
 	 *
 	 *		    [ stack_argN        ]
@@ -1125,6 +1099,11 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	stack_size += 8;
 	sreg_off = stack_size;
 
+	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
+		stack_size += 8;
+		tcc_off = stack_size;
+	}
+
 	if ((flags & BPF_TRAMP_F_CALL_ORIG) && (nr_arg_slots - RV_MAX_REG_ARGS > 0))
 		stack_size += (nr_arg_slots - RV_MAX_REG_ARGS) * 8;
 
@@ -1159,6 +1138,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		emit_addi(RV_REG_FP, RV_REG_SP, stack_size, ctx);
 	}
 
+	/* store tail call count */
+	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
+		emit_sd(RV_REG_FP, -tcc_off, RV_REG_TCC, ctx);
+
 	/* callee saved register S1 to pass start time */
 	emit_sd(RV_REG_FP, -sreg_off, RV_REG_S1, ctx);
 
@@ -1217,9 +1200,15 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		orig_call += RV_FENTRY_NINSNS * 4;
 		restore_args(min_t(int, nr_arg_slots, RV_MAX_REG_ARGS), args_off, ctx);
 		restore_stack_args(nr_arg_slots - RV_MAX_REG_ARGS, args_off, stk_arg_off, ctx);
+		/* restore TCC to RV_REG_TCC before calling the orig bpf func */
+		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
+			emit_ld(RV_REG_TCC, -tcc_off, RV_REG_FP, ctx);
 		ret = emit_call((const u64)orig_call, true, ctx);
 		if (ret)
 			goto out;
+		/* store updated TCC back to stack after calling the orig bpf func */
+		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
+			emit_sd(RV_REG_FP, -tcc_off, RV_REG_TCC, ctx);
 		emit_sd(RV_REG_FP, -retval_off, RV_REG_A0, ctx);
 		emit_sd(RV_REG_FP, -(retval_off - 8), regmap[BPF_REG_0], ctx);
 		im->ip_after_call = ctx->ro_insns + ctx->ninsns;
@@ -1272,6 +1261,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 
 	emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);
 
+	/* restore TCC from stack to RV_REG_TCC */
+	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
+		emit_ld(RV_REG_TCC, -tcc_off, RV_REG_FP, ctx);
+
 	if (!is_struct_ops) {
 		/* trampoline called from function entry */
 		emit_ld(RV_REG_T0, stack_size - 8, RV_REG_SP, ctx);
@@ -1836,10 +1829,18 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			}
 		}
 
+		/* restore TCC to RV_REG_TCC before bpf2bpf call */
+		if (aux->tail_call_reachable && insn->src_reg == BPF_PSEUDO_CALL)
+			emit_ld(RV_REG_TCC, ctx->tcc_offset, RV_REG_SP, ctx);
+
 		ret = emit_call(addr, fixed_addr, ctx);
 		if (ret)
 			return ret;
 
+		/* store updated TCC back to stack after bpf2bpf call */
+		if (aux->tail_call_reachable && insn->src_reg == BPF_PSEUDO_CALL)
+			emit_sd(RV_REG_SP, ctx->tcc_offset, RV_REG_TCC, ctx);
+
 		if (insn->src_reg != BPF_PSEUDO_CALL)
 			emit_mv(bpf_to_rv_reg(BPF_REG_0, ctx), RV_REG_A0, ctx);
 		break;
@@ -2019,10 +2020,9 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
 		stack_adjust += 8;
 	if (seen_reg(RV_REG_S5, ctx))
 		stack_adjust += 8;
-	if (seen_reg(RV_REG_S6, ctx))
-		stack_adjust += 8;
 	if (ctx->arena_vm_start)
 		stack_adjust += 8;
+	stack_adjust += 8; /* RV_REG_TCC */
 
 	stack_adjust = round_up(stack_adjust, STACK_ALIGN);
 	stack_adjust += bpf_stack_adjust;
@@ -2038,11 +2038,10 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
 	for (i = 0; i < RV_FENTRY_NINSNS; i++)
 		emit(rv_nop(), ctx);
 
-	/* First instruction is always setting the tail-call-counter
-	 * (TCC) register. This instruction is skipped for tail calls.
-	 * Force using a 4-byte (non-compressed) instruction.
-	 */
-	emit(rv_addi(RV_REG_TCC, RV_REG_ZERO, MAX_TAIL_CALL_CNT), ctx);
+	if (!is_subprog)
+		emit(rv_addi(RV_REG_TCC, RV_REG_ZERO, MAX_TAIL_CALL_CNT), ctx);
+
+	/* tailcall starts here, emit insn before it must be fixed */
 
 	emit_addi(RV_REG_SP, RV_REG_SP, -stack_adjust, ctx);
 
@@ -2072,26 +2071,20 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
 		emit_sd(RV_REG_SP, store_offset, RV_REG_S5, ctx);
 		store_offset -= 8;
 	}
-	if (seen_reg(RV_REG_S6, ctx)) {
-		emit_sd(RV_REG_SP, store_offset, RV_REG_S6, ctx);
-		store_offset -= 8;
-	}
 	if (ctx->arena_vm_start) {
 		emit_sd(RV_REG_SP, store_offset, RV_REG_ARENA, ctx);
 		store_offset -= 8;
 	}
 
+	/* store TCC from RV_REG_TCC to stack */
+	emit_sd(RV_REG_SP, store_offset, RV_REG_TCC, ctx);
+	ctx->tcc_offset = store_offset;
+
 	emit_addi(RV_REG_FP, RV_REG_SP, stack_adjust, ctx);
 
 	if (bpf_stack_adjust)
 		emit_addi(RV_REG_S5, RV_REG_SP, bpf_stack_adjust, ctx);
 
-	/* Program contains calls and tail calls, so RV_REG_TCC need
-	 * to be saved across calls.
-	 */
-	if (seen_tail_call(ctx) && seen_call(ctx))
-		emit_mv(RV_REG_TCC_SAVED, RV_REG_TCC, ctx);
-
 	ctx->stack_size = stack_adjust;
 
 	if (ctx->arena_vm_start)
@@ -2158,3 +2151,8 @@ bool bpf_jit_supports_fsession(void)
 {
 	return true;
 }
+
+bool bpf_jit_supports_subprog_tailcalls(void)
+{
+	return true;
+}
-- 
2.34.1

