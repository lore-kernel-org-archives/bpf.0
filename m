Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2311311C32;
	Sat,  5 Sep 2026 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788598436; cv=none; b=ArvnYqPHzhx2nmCTQrXWkQdLm4LtM2hAvnraX+IU92mTQOMsWwOA3uKU0601xusdpYYNHzQbrpZtXvSRzuEcOzqG4xuxysLsuaasTBjxSnE5GaS5+Ulvsaw26xoTc/6MYH8GJW/43j6rFi83/BlmzNgN4nglgiDNparkHIiccKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788598436; c=relaxed/simple;
	bh=X5puYXhBV5Q/+iT7DxMv9s/n72YYx/2s6Mx0VWlMF9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AE5ouT63F/XAvhIDPn36WYum12h66Yq341xtSMrV7eRbZghfa1C2XCGMHqxew0bFnLGCP+yX57IQE2lrNS3ZGkr01fiFa2n/wUQUFDZrf+9MGUXvQhxWhAY9BePHnwTvCor/l2nlIt2nikpK43XA+cFvKwsTsrxmPsvYIqT0Ks8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hcRtm0G4GzYQv1J;
	Sat,  5 Sep 2026 16:53:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 150E340577;
	Sat,  5 Sep 2026 16:53:50 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgBnTwqc2JtqP8lOAw--.13006S4;
	Sat, 05 Sep 2026 16:53:49 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Feng Jiang <jiangfeng@kylinos.cn>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next v5 2/3] riscv, bpf: Add BPF stack arguments support for RV64 JIT
Date: Sat,  5 Sep 2026 08:58:56 +0000
Message-Id: <20260905085857.14143-3-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905085857.14143-1-pulehui@huaweicloud.com>
References: <20260905085857.14143-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnTwqc2JtqP8lOAw--.13006S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtw18KF13Xw4xtFy7JF4Dtwb_yoW3XFW8p3
	WDGr1SkrWvqw40qFyDtFnrXr13CrsYv3W7KrZ7GayrJa12qrWkG3WYka1ayFy5CryrWw1x
	AFWq9rW3C395t37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jI
	sjbUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Feng Jiang <jiangfeng@kylinos.cn>

Implement bpf_jit_supports_stack_args() on RV64 JIT to allow bpf
subprogs and kfuncs to pass and receive more than 5 arguments.

In the riscv abi, the first 8 arguments are passed in registers a0 to
a7, and arguments 9+ reside on the stack. To align bpf stack arguments
with this calling convention and unify bpf2bpf calls with kfuncs, map
the first 3 bpf stack arguments (6th to 8th) directly to a5 to a7, and
store or load the remaining arguments (9th+) at SP or FP. Reserve
outgoing stack space in the prologue accordingly when stack_arg_cnt
exceeds 3.

In addition, update kfunc argument sign extension to handle all 8
register arguments as well as any arguments passed on the stack.

Co-developed-by: Pu Lehui <pulehui@huawei.com>
Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit.h        |  4 ++
 arch/riscv/net/bpf_jit_comp64.c | 80 ++++++++++++++++++++++++++++-----
 arch/riscv/net/bpf_jit_core.c   |  7 +++
 3 files changed, 81 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 419b9d795f2a..5c4f53060c91 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -12,6 +12,9 @@
 #include <linux/bpf.h>
 #include <linux/filter.h>
 
+#define RV_MAX_REG_ARGS		8
+#define RV_EXTRA_STK_ARGS	(RV_MAX_REG_ARGS - MAX_BPF_FUNC_REG_ARGS)
+
 /* verify runtime detection extension status */
 #define rv_ext_enabled(ext) \
 	(IS_ENABLED(CONFIG_RISCV_ISA_##ext) && riscv_has_extension_likely(RISCV_ISA_EXT_##ext))
@@ -82,6 +85,7 @@ struct rv_jit_context {
 	unsigned long flags;
 	int stack_size;
 	int tcc_offset;
+	int stack_arg_sz;
 	u64 arena_vm_start;
 	u64 user_vm_start;
 };
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index fc1c8c5480b6..7f84447a31ff 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -15,7 +15,6 @@
 #include <asm/percpu.h>
 #include "bpf_jit.h"
 
-#define RV_MAX_REG_ARGS 8
 #define RV_FENTRY_NINSNS 2
 #define RV_FENTRY_NBYTES (RV_FENTRY_NINSNS * 4)
 /* imm that allows emit_imm to emit max count insns */
@@ -498,6 +497,18 @@ static void emit_ldx(u8 rd, s16 off, u8 rs, u8 size, bool sign_ext,
 	ctx->ex_jmp_off = ctx->ninsns;
 }
 
+static void emit_stack_arg_ldx(u8 rd, s16 off, struct rv_jit_context *ctx)
+{
+	int idx = off / 8 - 1;
+
+	if (idx < RV_EXTRA_STK_ARGS) {
+		emit_mv(rd, RV_REG_A5 + idx, ctx);
+		return;
+	}
+
+	emit_ldx_insn(rd, (idx - RV_EXTRA_STK_ARGS) * 8, RV_REG_FP, BPF_DW, false, ctx);
+}
+
 static void emit_st(u8 rd, s16 off, s32 imm, u8 size, struct rv_jit_context *ctx)
 {
 	emit_imm(RV_REG_T1, imm, ctx);
@@ -515,6 +526,19 @@ static void emit_st(u8 rd, s16 off, s32 imm, u8 size, struct rv_jit_context *ctx
 	ctx->ex_jmp_off = ctx->ninsns;
 }
 
+static void emit_stack_arg_st(s16 off, s32 imm, struct rv_jit_context *ctx)
+{
+	int idx = -off / 8 - 1;
+
+	if (idx < RV_EXTRA_STK_ARGS) {
+		emit_imm(RV_REG_A5 + idx, imm, ctx);
+		return;
+	}
+
+	emit_imm(RV_REG_T1, imm, ctx);
+	emit_stx_insn(RV_REG_SP, (idx - RV_EXTRA_STK_ARGS) * 8, RV_REG_T1, BPF_DW, ctx);
+}
+
 static void emit_stx(u8 rd, s16 off, u8 rs, u8 size, struct rv_jit_context *ctx)
 {
 	if (is_12b_int(off)) {
@@ -531,6 +555,18 @@ static void emit_stx(u8 rd, s16 off, u8 rs, u8 size, struct rv_jit_context *ctx)
 	ctx->ex_jmp_off = ctx->ninsns;
 }
 
+static void emit_stack_arg_stx(s16 off, u8 rs, struct rv_jit_context *ctx)
+{
+	int idx = -off / 8 - 1;
+
+	if (idx < RV_EXTRA_STK_ARGS) {
+		emit_mv(RV_REG_A5 + idx, rs, ctx);
+		return;
+	}
+
+	emit_stx_insn(RV_REG_SP, (idx - RV_EXTRA_STK_ARGS) * 8, rs, BPF_DW, ctx);
+}
+
 static int emit_atomic_ld_st(u8 rd, u8 rs, const struct bpf_insn *insn,
 			     struct rv_jit_context *ctx)
 {
@@ -1824,11 +1860,21 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 				return -EINVAL;
 
 			for (idx = 0; idx < fm->nr_args; idx++) {
-				u8 reg = bpf_to_rv_reg(BPF_REG_1 + idx, ctx);
 				bool sign = fm->arg_flags[idx] & BTF_FMODEL_SIGNED_ARG;
-
-				if (sign_extend(reg, reg, fm->arg_size[idx], sign, ctx))
-					return -EINVAL;
+				u8 arg_sz = fm->arg_size[idx];
+
+				if (arg_sz == 8 || (arg_sz != 4 && !sign))
+					continue;
+
+				if (idx < RV_MAX_REG_ARGS) {
+					if (sign_extend(RV_REG_A0 + idx, RV_REG_A0 + idx, arg_sz, sign, ctx))
+						return -EINVAL;
+				} else {
+					emit_ld(RV_REG_T1, (idx - RV_MAX_REG_ARGS) * 8, RV_REG_SP, ctx);
+					if (sign_extend(RV_REG_T1, RV_REG_T1, arg_sz, sign, ctx))
+						return -EINVAL;
+					emit_sd(RV_REG_SP, (idx - RV_MAX_REG_ARGS) * 8, RV_REG_T1, ctx);
+				}
 			}
 		}
 
@@ -1927,7 +1973,10 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			rs = RV_REG_T2;
 		}
 
-		emit_ldx(rd, off, rs, BPF_SIZE(code), sign_ext, ctx);
+		if (is_stack_arg_ldx(insn))
+			emit_stack_arg_ldx(rd, off, ctx);
+		else
+			emit_ldx(rd, off, rs, BPF_SIZE(code), sign_ext, ctx);
 
 		ret = add_exception_handler(insn, rd, ctx);
 		if (ret)
@@ -1957,7 +2006,10 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			rd = RV_REG_T3;
 		}
 
-		emit_st(rd, off, imm, BPF_SIZE(code), ctx);
+		if (is_stack_arg_st(insn))
+			emit_stack_arg_st(off, imm, ctx);
+		else
+			emit_st(rd, off, imm, BPF_SIZE(code), ctx);
 
 		ret = add_exception_handler(insn, REG_DONT_CLEAR_MARKER, ctx);
 		if (ret)
@@ -1979,7 +2031,10 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			rd = RV_REG_T2;
 		}
 
-		emit_stx(rd, off, rs, BPF_SIZE(code), ctx);
+		if (is_stack_arg_stx(insn))
+			emit_stack_arg_stx(off, rs, ctx);
+		else
+			emit_stx(rd, off, rs, BPF_SIZE(code), ctx);
 
 		ret = add_exception_handler(insn, REG_DONT_CLEAR_MARKER, ctx);
 		if (ret)
@@ -2029,9 +2084,9 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 
 void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
 {
-	int i, stack_adjust = 0, store_offset, bpf_stack_adjust;
+	int i, stack_adjust = 0, store_offset, bpf_stack_adjust = ctx->stack_arg_sz;
 
-	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, STACK_ALIGN);
+	bpf_stack_adjust += round_up(ctx->prog->aux->stack_depth, STACK_ALIGN);
 	if (bpf_stack_adjust)
 		mark_fp(ctx);
 
@@ -2190,3 +2245,8 @@ bool bpf_jit_supports_timed_may_goto(void)
 {
 	return true;
 }
+
+bool bpf_jit_supports_stack_args(void)
+{
+	return true;
+}
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index cbfcd287ea16..2fb0b4e198b9 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -48,6 +48,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	int pass = 0, prev_ninsns = 0, i;
 	struct rv_jit_data *jit_data;
 	struct rv_jit_context *ctx;
+	u16 stack_arg_cnt;
 
 	if (!prog->jit_requested)
 		return prog;
@@ -71,6 +72,12 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 
 	ctx->arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
 	ctx->user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
+
+	stack_arg_cnt = bpf_out_stack_arg_cnt(env, prog);
+	/* First 3 stack args in regs, rest on stack */
+	ctx->stack_arg_sz = stack_arg_cnt > RV_EXTRA_STK_ARGS ?
+			    round_up((stack_arg_cnt - RV_EXTRA_STK_ARGS) * 8, STACK_ALIGN) : 0;
+
 	ctx->prog = prog;
 	ctx->offset = kvzalloc_objs(int, prog->len);
 	if (!ctx->offset)
-- 
2.34.1

