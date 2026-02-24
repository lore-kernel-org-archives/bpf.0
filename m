Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2DF3644BE;
	Tue, 24 Feb 2026 07:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771918599; cv=none; b=KHjfTaI6g+uhsedmo6aDFaqRzKTYer7+KKa5zfbGM4mI0pC50awXqa9PCPOUIqoM1EIv7LGOzZki5G9Im+e++xfPXoNbJMeXQIav31GP1lq1RVyvQJ/4iejjjlLOdWnyITbLXfz+xKoZi3gJmxEPXFL33SZQtamkfEyWil8fE5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771918599; c=relaxed/simple;
	bh=iaacxNVDtXkpCqOoUsyH77L0rhFw34H652SiOL1g9FA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrWAJqDFr2Q74Ltu/mEN/1WDtNwPvdvad8MboWRbsLcRqioxjBaMxMdslb+lAH/YRPFaWr7xYHgvdjrhy0HLy5dbFlapGdc+Pb4CHJWAFMDdjZFzlwRcPQAcgqaANqIz1B6Q/K4PaEh2zTb9PTVOyS6+0YastVz5NFjHKNbUzwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxAfG3VJ1p2acUAA--.63601S3;
	Tue, 24 Feb 2026 15:35:19 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxD8O0VJ1p9kxKAA--.9173S4;
	Tue, 24 Feb 2026 15:35:18 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] LoongArch: BPF: Support small struct arguments for trampoline
Date: Tue, 24 Feb 2026 15:35:14 +0800
Message-ID: <20260224073515.1273-3-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJDxD8O0VJ1p9kxKAA--.9173S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3WF45Xr4UCr15CFy7trykXrc_yoW7ZFyrpF
	1qkwsxCF48JFW7WaykXr4UWFyYkFs3A3y3urWUG39aya15Xry5JF4rKFn0yFy5GrykAF1f
	ursYvryqkF1xJwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8CztUUUUU=

In the current BPF code, the struct argument size is at most 16 bytes,
enforced by the verifier. According to the Procedure Call Standard for
LoongArch [1], the struct argument size below 16 bytes are provided as
part of the 8 argument registers, that is to say, the struct argument
may be passed in a pair of registers if its size is more than 8 bytes
and no more than 16 bytes.

Extend the BPF trampoline JIT to support attachment to functions that
take small structures (up to 16 bytes) as argument, save and restore
a number of "argument registers" rather than a number of arguments.

With this patch, the following related testcases passed:

  sudo ./test_progs -a tracing_struct/struct_args
  sudo ./test_progs -a tracing_struct/union_args

Link: https://github.com/loongson/la-abi-specs/blob/release/lapcs.adoc#structures [1]
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 55 ++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 98c04d6056f4..fef002bd3ffb 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1460,21 +1460,21 @@ int bpf_arch_text_invalidate(void *dst, size_t len)
 	return ret;
 }
 
-static void store_args(struct jit_ctx *ctx, int nargs, int args_off)
+static void store_args(struct jit_ctx *ctx, int nregs, int args_off)
 {
 	int i;
 
-	for (i = 0; i < nargs; i++) {
+	for (i = 0; i < nregs; i++) {
 		emit_insn(ctx, std, LOONGARCH_GPR_A0 + i, LOONGARCH_GPR_FP, -args_off);
 		args_off -= 8;
 	}
 }
 
-static void restore_args(struct jit_ctx *ctx, int nargs, int args_off)
+static void restore_args(struct jit_ctx *ctx, int nregs, int args_off)
 {
 	int i;
 
-	for (i = 0; i < nargs; i++) {
+	for (i = 0; i < nregs; i++) {
 		emit_insn(ctx, ldd, LOONGARCH_GPR_A0 + i, LOONGARCH_GPR_FP, -args_off);
 		args_off -= 8;
 	}
@@ -1590,8 +1590,8 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 					 void *func_addr, u32 flags)
 {
 	int i, ret, save_ret;
-	int stack_size, nargs;
-	int retval_off, args_off, nargs_off, ip_off, run_ctx_off, sreg_off, tcc_ptr_off;
+	int stack_size, nregs = m->nr_args;
+	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off, tcc_ptr_off;
 	bool is_struct_ops = flags & BPF_TRAMP_F_INDIRECT;
 	void *orig_call = func_addr;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
@@ -1611,11 +1611,11 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	 *
 	 * FP - retval_off  [ return value      ] BPF_TRAMP_F_CALL_ORIG or
 	 *                    BPF_TRAMP_F_RET_FENTRY_RET
-	 *                  [ argN              ]
+	 *                  [ arg regN          ]
 	 *                  [ ...               ]
-	 * FP - args_off    [ arg1              ]
+	 * FP - args_off    [ arg reg1          ]
 	 *
-	 * FP - nargs_off   [ regs count        ]
+	 * FP - nregs_off   [ arg regs count    ]
 	 *
 	 * FP - ip_off      [ traced func   ] BPF_TRAMP_F_IP_ARG
 	 *
@@ -1626,15 +1626,23 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	 * FP - tcc_ptr_off [ tail_call_cnt_ptr ]
 	 */
 
-	if (m->nr_args > LOONGARCH_MAX_REG_ARGS)
-		return -ENOTSUPP;
-
-	/* FIXME: No support of struct argument */
+	/* Extra registers for struct arguments */
 	for (i = 0; i < m->nr_args; i++) {
-		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
-			return -ENOTSUPP;
+		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG) {
+			/*
+			 * The struct argument size is at most 16 bytes,
+			 * enforced by the verifier. The struct argument
+			 * may be passed in a pair of registers if its
+			 * size is more than 8 bytes and no more than 16
+			 * bytes.
+			 */
+			nregs += round_up(m->arg_size[i], 8) / 8 - 1;
+		}
 	}
 
+	if (nregs > LOONGARCH_MAX_REG_ARGS)
+		return -ENOTSUPP;
+
 	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
 		return -ENOTSUPP;
 
@@ -1648,13 +1656,12 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	retval_off = stack_size;
 
 	/* Room of trampoline frame to store args */
-	nargs = m->nr_args;
-	stack_size += nargs * 8;
+	stack_size += nregs * 8;
 	args_off = stack_size;
 
 	/* Room of trampoline frame to store args number */
 	stack_size += 8;
-	nargs_off = stack_size;
+	nregs_off = stack_size;
 
 	/* Room of trampoline frame to store ip address */
 	if (flags & BPF_TRAMP_F_IP_ARG) {
@@ -1717,11 +1724,11 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 		emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -ip_off);
 	}
 
-	/* store nargs number */
-	move_imm(ctx, LOONGARCH_GPR_T1, nargs, false);
-	emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -nargs_off);
+	/* store arg regs count */
+	move_imm(ctx, LOONGARCH_GPR_T1, nregs, false);
+	emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -nregs_off);
 
-	store_args(ctx, nargs, args_off);
+	store_args(ctx, nregs, args_off);
 
 	/* To traced function */
 	/* Ftrace jump skips 2 NOP instructions */
@@ -1763,7 +1770,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		restore_args(ctx, m->nr_args, args_off);
+		restore_args(ctx, nregs, args_off);
 
 		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
 			emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_FP, -tcc_ptr_off);
@@ -1799,7 +1806,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	}
 
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
-		restore_args(ctx, m->nr_args, args_off);
+		restore_args(ctx, nregs, args_off);
 
 	if (save_ret) {
 		emit_insn(ctx, ldd, regmap[BPF_REG_0], LOONGARCH_GPR_FP, -(retval_off - 8));
-- 
2.42.0

