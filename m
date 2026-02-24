Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF3129AB05;
	Tue, 24 Feb 2026 07:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771918599; cv=none; b=LlRWFxYR72pipvLY+jl3da83p3aaINBAWsdkKDG+h3O1cBAbWow7wtwgfmaxt0mxkgirAQa5zhrcBDWej5s+13bBohCPt9HKCJ1rctWcjjuSVTOHIF6Zq+t0TftcRhvzVvBu+HeasilhnShyo9+f+j5rZ0mKBJ3lHJfBrMcCiKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771918599; c=relaxed/simple;
	bh=ZHWDl5P27da+k2g3nl1uHj5zw4TRH3V2IEk/qlaxiOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkuS7TOGkp7Ki41UxYvXzo8DZoPjvyQ/P9pbH6u6bYCxc9eb+Yub24AqxxgY9B9RbcPShDdAMerHOehcGfdMILsxxl/i5zdBBdTebNYzAMEl47gtl5FLghYJXte9HXCKlBPy+E4DEctameNwtSDxWc4jTlJgG5bKbn2zGHkwc8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxScK4VJ1p3acUAA--.63785S3;
	Tue, 24 Feb 2026 15:35:20 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxD8O0VJ1p9kxKAA--.9173S5;
	Tue, 24 Feb 2026 15:35:19 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] LoongArch: BPF: support 12 function arguments for trampoline
Date: Tue, 24 Feb 2026 15:35:15 +0800
Message-ID: <20260224073515.1273-4-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260224073515.1273-1-yangtiezhu@loongson.cn>
References: <20260224073515.1273-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxD8O0VJ1p9kxKAA--.9173S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtr4UKFy7Zr1DGr4rZF45XFc_yoWxXr47pF
	1qkan5uF18tFW7Wa97XF4UuF1YkFs3A3yY9rW7Aa92vw45ur98GayrKFnIkFy5Gr1kAr1x
	Cws0vrWYyF1xJ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
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

Currently, LoongArch bpf trampoline supports up to 8 function arguments.
According to the statistics from commit 473e3150e30a ("bpf, x86: allow
function arguments up to 12 for TRACING"), there are over 200 functions
accept 9 to 12 arguments, so add 12 arguments support for trampoline.

With this patch, the following related testcases passed:

  sudo ./test_progs -a tracing_struct/struct_many_args
  sudo ./test_progs -a fentry_test/fentry_many_args
  sudo ./test_progs -a fexit_test/fexit_many_args

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 79 +++++++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 24 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index fef002bd3ffb..6037f2495cf6 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1460,26 +1460,48 @@ int bpf_arch_text_invalidate(void *dst, size_t len)
 	return ret;
 }
 
-static void store_args(struct jit_ctx *ctx, int nregs, int args_off)
+static void store_args(struct jit_ctx *ctx, int nr_arg_slots, int args_off)
 {
 	int i;
 
-	for (i = 0; i < nregs; i++) {
-		emit_insn(ctx, std, LOONGARCH_GPR_A0 + i, LOONGARCH_GPR_FP, -args_off);
+	for (i = 0; i < nr_arg_slots; i++) {
+		if (i < LOONGARCH_MAX_REG_ARGS) {
+			emit_insn(ctx, std, LOONGARCH_GPR_A0 + i, LOONGARCH_GPR_FP, -args_off);
+		} else {
+			/* skip slots for T0 and FP of traced function */
+			emit_insn(ctx, ldd, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP,
+				  16 + (i - LOONGARCH_MAX_REG_ARGS) * 8);
+			emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -args_off);
+		}
 		args_off -= 8;
 	}
 }
 
-static void restore_args(struct jit_ctx *ctx, int nregs, int args_off)
+static void restore_args(struct jit_ctx *ctx, int nr_reg_args, int args_off)
 {
 	int i;
 
-	for (i = 0; i < nregs; i++) {
+	for (i = 0; i < nr_reg_args; i++) {
 		emit_insn(ctx, ldd, LOONGARCH_GPR_A0 + i, LOONGARCH_GPR_FP, -args_off);
 		args_off -= 8;
 	}
 }
 
+static void restore_stk_args(struct jit_ctx *ctx, int nr_stk_args,
+			     int args_off, int stk_arg_off)
+{
+	int i;
+
+	for (i = 0; i < nr_stk_args; i++) {
+		emit_insn(ctx, ldd, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP,
+			  -(args_off - LOONGARCH_MAX_REG_ARGS * 8));
+		emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP,
+			  -stk_arg_off);
+		args_off -= 8;
+		stk_arg_off -= 8;
+	}
+}
+
 static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
 			   int args_off, int retval_off, int run_ctx_off, bool save_ret)
 {
@@ -1590,7 +1612,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 					 void *func_addr, u32 flags)
 {
 	int i, ret, save_ret;
-	int stack_size, nregs = m->nr_args;
+	int stack_size, nr_arg_slots = 0, stk_arg_off;
 	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off, tcc_ptr_off;
 	bool is_struct_ops = flags & BPF_TRAMP_F_INDIRECT;
 	void *orig_call = func_addr;
@@ -1624,25 +1646,27 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	 * FP - sreg_off    [ callee saved reg  ]
 	 *
 	 * FP - tcc_ptr_off [ tail_call_cnt_ptr ]
+	 *
+	 *                  [ stack_argN        ]
+	 *                  [ ...               ]
+	 * FP - stk_arg_off [ stack_arg1        ] BPF_TRAMP_F_CALL_ORIG
 	 */
 
+	if (m->nr_args > MAX_BPF_FUNC_ARGS)
+		return -ENOTSUPP;
+
 	/* Extra registers for struct arguments */
 	for (i = 0; i < m->nr_args; i++) {
-		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG) {
-			/*
-			 * The struct argument size is at most 16 bytes,
-			 * enforced by the verifier. The struct argument
-			 * may be passed in a pair of registers if its
-			 * size is more than 8 bytes and no more than 16
-			 * bytes.
-			 */
-			nregs += round_up(m->arg_size[i], 8) / 8 - 1;
-		}
+		/*
+		 * The struct argument size is at most 16 bytes,
+		 * enforced by the verifier. The struct argument
+		 * may be passed in a pair of registers if its
+		 * size is more than 8 bytes and no more than 16
+		 * bytes.
+		 */
+		nr_arg_slots += round_up(m->arg_size[i], 8) / 8;
 	}
 
-	if (nregs > LOONGARCH_MAX_REG_ARGS)
-		return -ENOTSUPP;
-
 	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
 		return -ENOTSUPP;
 
@@ -1656,7 +1680,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	retval_off = stack_size;
 
 	/* Room of trampoline frame to store args */
-	stack_size += nregs * 8;
+	stack_size += nr_arg_slots * 8;
 	args_off = stack_size;
 
 	/* Room of trampoline frame to store args number */
@@ -1682,8 +1706,14 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 		tcc_ptr_off = stack_size;
 	}
 
+	if ((flags & BPF_TRAMP_F_CALL_ORIG) && (nr_arg_slots - LOONGARCH_MAX_REG_ARGS > 0))
+		stack_size += (nr_arg_slots - LOONGARCH_MAX_REG_ARGS) * 8;
+
 	stack_size = round_up(stack_size, 16);
 
+	/* Room for args on stack must be at the top of stack */
+	stk_arg_off = stack_size;
+
 	if (is_struct_ops) {
 		/*
 		 * For the trampoline called directly, just handle
@@ -1725,10 +1755,10 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	}
 
 	/* store arg regs count */
-	move_imm(ctx, LOONGARCH_GPR_T1, nregs, false);
+	move_imm(ctx, LOONGARCH_GPR_T1, nr_arg_slots, false);
 	emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -nregs_off);
 
-	store_args(ctx, nregs, args_off);
+	store_args(ctx, nr_arg_slots, args_off);
 
 	/* To traced function */
 	/* Ftrace jump skips 2 NOP instructions */
@@ -1770,7 +1800,8 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		restore_args(ctx, nregs, args_off);
+		restore_args(ctx, min_t(int, nr_arg_slots, LOONGARCH_MAX_REG_ARGS), args_off);
+		restore_stk_args(ctx, nr_arg_slots - LOONGARCH_MAX_REG_ARGS, args_off, stk_arg_off);
 
 		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
 			emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_FP, -tcc_ptr_off);
@@ -1806,7 +1837,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	}
 
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
-		restore_args(ctx, nregs, args_off);
+		restore_args(ctx, min_t(int, nr_arg_slots, LOONGARCH_MAX_REG_ARGS), args_off);
 
 	if (save_ret) {
 		emit_insn(ctx, ldd, regmap[BPF_REG_0], LOONGARCH_GPR_FP, -(retval_off - 8));
-- 
2.42.0

