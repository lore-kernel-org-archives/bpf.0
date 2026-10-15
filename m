Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF343B8921;
	Thu, 15 Oct 2026 02:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792030401; cv=none; b=GC+764moTTWjShGuLM5tcbmIj1Y43iHb8z5qlcRjv2+6J75g/V3D7sIJ02RNMQC9+VfcBhJW8ypD6V1LUmsmc7gsekoppKoG6xEI4xUi6aNL6jcWTsi0OPAYmA3n4pTAjTg6KLWWBDdcRORzgP1o2eOPpNorwOq10KmT1fd+lUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792030401; c=relaxed/simple;
	bh=3NfrV1dTdOChrKOILxj8xxkkULtt0LTy9uqU4OOysgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=geV5Iij1bG5I7uHnjpKAoezG/jsMqEzpogUbz/i+7E7371XLurgR8aXZf+hQOCCnkQriS7I8QXsusY+BWzFQU8Qb94vYCKFzdSEY0SlIzlCAXiCnLCiVisACvpl0K9YYDXlHInnvbGgeqyT7cTndivf6m2me2g+1Hemx5Rg5lwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ydiAgMzg; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ydiAgMzg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792030386; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=AP8mOT2Tvjd0ULmisNLPOzWyXU+zviS2NkU89PTeN3c=;
	b=ydiAgMzguzG35xnEiPb2dSDk6pHIMhcP23ITERen3Tu0pd3iuYtpBx+8nmMw+K3Qfb3A9bweFPsCrHykV/0fB4VilSl/bfC8srs01LgHJHwTgWmaglQ/eMNJncQhG5C1hTny7ML7cOcFoKo8OpZhJvVEzHXYN4LTB0yiTQ0CrTU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0XCqJ07Y_1792030383;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XCqJ07Y_1792030383 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 15 Oct 2026 10:13:04 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	bjorn@kernel.org,
	puranjay@kernel.org
Cc: eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	pulehui@huawei.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	luke.r.nels@gmail.com,
	xi.wang@gmail.com,
	shuah@kernel.org,
	rgbi3307@gmail.com,
	guoren@kernel.org,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/3] riscv: bpf: Add BPF private stack support
Date: Thu, 15 Oct 2026 10:12:36 +0800
Message-ID: <20261015021238.5657-2-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015021238.5657-1-cp0613@linux.alibaba.com>
References: <20261015021238.5657-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A program on a private stack keeps its BPF frames in a per-CPU area of
its own rather than on the kernel stack of whichever context entered it.
bpf_enable_priv_stack() grants that mode only once the JIT reports
bpf_jit_supports_private_stack(), which riscv64 did not: programs there
always ran on the kernel stack, and a struct_ops program that requires
one was rejected with -EACCES.

Allocate a per-CPU area of the verifier calculated depth plus a 16 byte
guard region at each end, and point BPF_REG_FP (S5) at the top of it
while leaving SP on the kernel stack. Every BPF stack access already
goes through S5, and S5 is callee-saved with each subprog deriving its
own, so nothing else in the JIT has to know about the private stack.

The outgoing stack argument area stays in the kernel frame: callers
write it relative to SP, callees relative to RV_REG_FP, which the
prologue sets to the caller's SP.

The per-CPU lookup is emitted after the tail call entry point: a program
using a private stack can still be entered as a tail call target, and
RV_TAILCALL_OFFSET is a constant added to the target's bpf_func, so what
is in front of it must be the same size in every program.

The base is materialized with absolute moves, as on arm64, x86-64 and
powerpc64: the dynamic per-CPU area is vmalloc'd, beyond a PC-relative
auipc pair from the JIT region, and riscv64 has no segment or register
holding the per-CPU offset, so __per_cpu_offset needs materializing the
same way. Both constants are fixed before the offset convergence loop,
so the prologue length is stable across passes.

The guard layout and value follow arm64, x86-64 and powerpc64: a 16
byte region at each end holding two copies of the pattern. A jited
program has them checked when it is freed, reporting the first
corrupted CPU only; failure paths release the area unchecked since the
image never ran, which also clears priv_stack_ptr for the later
bpf_jit_free().

RV32 does not declare support and keeps the existing kernel stack
behaviour.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 arch/riscv/net/bpf_jit.h        |  1 +
 arch/riscv/net/bpf_jit_comp64.c | 42 +++++++++++++++--
 arch/riscv/net/bpf_jit_core.c   | 84 +++++++++++++++++++++++++++++----
 3 files changed, 115 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 5c4f53060c91..6d42083829f7 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -14,6 +14,7 @@
 
 #define RV_MAX_REG_ARGS		8
 #define RV_EXTRA_STK_ARGS	(RV_MAX_REG_ARGS - MAX_BPF_FUNC_REG_ARGS)
+#define PRIV_STACK_GUARD_SZ	16
 
 /* verify runtime detection extension status */
 #define rv_ext_enabled(ext) \
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 788fcc21fd5b..9a83770f0460 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -2122,12 +2122,34 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	return 0;
 }
 
+static void emit_priv_stack_frame(struct rv_jit_context *ctx)
+{
+	u64 fp = (__force u64)ctx->prog->aux->priv_stack_ptr + PRIV_STACK_GUARD_SZ;
+
+	fp += round_up(ctx->prog->aux->stack_depth, STACK_ALIGN);
+	emit_imm(RV_REG_S5, fp, ctx);
+#ifdef CONFIG_SMP
+	emit_lw(RV_REG_T1, offsetof(struct thread_info, cpu), RV_REG_TP, ctx);
+	emit_imm(RV_REG_T2, (u64)__per_cpu_offset, ctx);
+	emit_sh3add(RV_REG_T1, RV_REG_T1, RV_REG_T2, ctx);
+	emit_ld(RV_REG_T1, 0, RV_REG_T1, ctx);
+	emit_add(RV_REG_S5, RV_REG_S5, RV_REG_T1, ctx);
+#endif
+}
+
 void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
 {
+	bool priv_stack = ctx->prog->aux->priv_stack_ptr;
 	int i, stack_adjust = 0, store_offset, bpf_stack_adjust = ctx->stack_arg_sz;
 
-	bpf_stack_adjust += round_up(ctx->prog->aux->stack_depth, STACK_ALIGN);
-	if (bpf_stack_adjust)
+	/*
+	 * With a private stack only the outgoing stack argument area is left in
+	 * this frame. It has to stay: the caller writes it relative to SP while
+	 * the callee reads it relative to RV_REG_FP, the caller's SP set below.
+	 */
+	if (!priv_stack)
+		bpf_stack_adjust += round_up(ctx->prog->aux->stack_depth, STACK_ALIGN);
+	if (bpf_stack_adjust || priv_stack)
 		mark_fp(ctx);
 
 	if (seen_reg(RV_REG_RA, ctx))
@@ -2205,7 +2227,16 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
 
 	emit_addi(RV_REG_FP, RV_REG_SP, stack_adjust, ctx);
 
-	if (bpf_stack_adjust)
+	/*
+	 * Point BPF_REG_FP at the top of this CPU's private stack. A program
+	 * with one can still be entered as a tail call target, at
+	 * RV_TAILCALL_OFFSET, so this has to come after that entry point; the
+	 * offset is a constant added to the target's bpf_func, so everything in
+	 * front of it must also be the same size in every program.
+	 */
+	if (priv_stack)
+		emit_priv_stack_frame(ctx);
+	else if (bpf_stack_adjust)
 		emit_addi(RV_REG_S5, RV_REG_SP, bpf_stack_adjust, ctx);
 
 	ctx->stack_size = stack_adjust;
@@ -2303,3 +2334,8 @@ bool bpf_jit_supports_callx(void)
 {
 	return true;
 }
+
+bool bpf_jit_supports_private_stack(void)
+{
+	return true;
+}
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 5265dd5bd39e..06f74d6943a9 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -9,6 +9,7 @@
 #include <linux/bpf.h>
 #include <linux/filter.h>
 #include <linux/memory.h>
+#include <linux/percpu.h>
 #include <asm/text-patching.h>
 #include <asm/cfi.h>
 #include "bpf_jit.h"
@@ -44,6 +45,62 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
 
+#define PRIV_STACK_GUARD_VAL	0xEB9F12345678eb9fULL
+
+static u32 priv_stack_size(struct bpf_prog *prog)
+{
+	return round_up(prog->aux->stack_depth, STACK_ALIGN) +
+	       2 * PRIV_STACK_GUARD_SZ;
+}
+
+static int alloc_priv_stack(struct bpf_prog *prog)
+{
+	u32 size = priv_stack_size(prog);
+	u32 end = (size - PRIV_STACK_GUARD_SZ) / sizeof(u64);
+	void __percpu *ptr;
+	int cpu, i;
+
+	ptr = __alloc_percpu_gfp(size, STACK_ALIGN, GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		u64 *stack = per_cpu_ptr(ptr, cpu);
+
+		for (i = 0; i < PRIV_STACK_GUARD_SZ / sizeof(u64); i++) {
+			stack[i] = PRIV_STACK_GUARD_VAL;
+			stack[end + i] = PRIV_STACK_GUARD_VAL;
+		}
+	}
+	prog->aux->priv_stack_ptr = ptr;
+	return 0;
+}
+
+static void priv_stack_check_guard(struct bpf_prog *prog)
+{
+	u32 end = (priv_stack_size(prog) - PRIV_STACK_GUARD_SZ) / sizeof(u64);
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		u64 *stack = per_cpu_ptr(prog->aux->priv_stack_ptr, cpu);
+
+		if (stack[0] != PRIV_STACK_GUARD_VAL ||
+		    stack[1] != PRIV_STACK_GUARD_VAL ||
+		    stack[end] != PRIV_STACK_GUARD_VAL ||
+		    stack[end + 1] != PRIV_STACK_GUARD_VAL) {
+			pr_err("bpf-jit: private stack overflow/underflow guard of prog %s corrupted on CPU %d\n",
+			       bpf_jit_get_prog_name(prog), cpu);
+			return;
+		}
+	}
+}
+
+static void free_priv_stack(struct bpf_prog *prog)
+{
+	free_percpu(prog->aux->priv_stack_ptr);
+	prog->aux->priv_stack_ptr = NULL;
+}
+
 struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	unsigned int prog_size = 0, extable_size = 0;
@@ -82,12 +139,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			    round_up((stack_arg_cnt - RV_EXTRA_STK_ARGS) * 8, STACK_ALIGN) : 0;
 
 	ctx->prog = prog;
+	if (prog->aux->jits_use_priv_stack && alloc_priv_stack(prog))
+		goto out_free_hdr;
+
 	ctx->offset = kvzalloc_objs(int, prog->len);
 	if (!ctx->offset)
-		goto out_offset;
+		goto out_free_hdr;
 
 	if (build_body(ctx, extra_pass, NULL))
-		goto out_offset;
+		goto out_free_hdr;
 
 	for (i = 0; i < prog->len; i++) {
 		prev_ninsns += 32;
@@ -102,7 +162,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		ctx->prologue_len = ctx->ninsns;
 
 		if (build_body(ctx, extra_pass, ctx->offset))
-			goto out_offset;
+			goto out_free_hdr;
 
 		ctx->epilogue_offset = ctx->ninsns;
 		bpf_jit_build_epilogue(ctx);
@@ -122,7 +182,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 							  bpf_fill_ill_insns,
 							  bpf_prog_was_classic(prog));
 			if (!jit_data->ro_header)
-				goto out_offset;
+				goto out_free_hdr;
 
 			/*
 			 * Use the image(RW) for writing the JITed instructions. But also save
@@ -188,10 +248,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			ctx->offset[i] = ctx->offset[i - 1];
 		ctx->offset[0] = ninsns_rvoff(ctx->prologue_len);
 		bpf_prog_update_insn_ptrs(prog, ctx->offset, jit_data->ro_image);
-out_offset:
-		kvfree(ctx->offset);
-		kfree(jit_data);
-		prog->aux->jit_data = NULL;
+		goto out_free_ctx;
 	}
 
 	return prog;
@@ -207,7 +264,12 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 				   sizeof(jit_data->header->size));
 		bpf_jit_binary_pack_free(jit_data->ro_header, jit_data->header);
 	}
-	goto out_offset;
+	free_priv_stack(prog);
+out_free_ctx:
+	kvfree(ctx->offset);
+	kfree(jit_data);
+	prog->aux->jit_data = NULL;
+	return prog;
 }
 
 u64 bpf_jit_alloc_exec_limit(void)
@@ -259,6 +321,10 @@ void bpf_jit_free(struct bpf_prog *prog)
 		prog->bpf_func = (void *)prog->bpf_func - cfi_get_offset();
 		hdr = bpf_jit_binary_pack_hdr(prog);
 		bpf_jit_binary_pack_free(hdr, NULL);
+		if (prog->aux->priv_stack_ptr) {
+			priv_stack_check_guard(prog);
+			free_priv_stack(prog);
+		}
 		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
 	}
 
-- 
2.50.1

