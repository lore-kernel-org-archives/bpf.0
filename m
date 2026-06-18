Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E797E35836A
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 03:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781753942; cv=none; b=cmcVXoDDEUkMNskH6WGqRVxh6T2Qz1YRRI0JXhKQXkjYF5TWkVwS2DpmgQY4SrzA+y46toYrEZcuBgB64ZstsF0voQ+Ssfc1wqRgJBFYLyr30S8v2Zhf0zs/f5HqlmAMq61QkGfI6Q2wLPMG+esw+4Sj9t3u+g0LrMSUOqROndM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781753942; c=relaxed/simple;
	bh=qkVySCjELWa77xsnAhRxul5IV1m4ywp3M4MXb4eARrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cgHduQY0be2CRkO4buyD8dx18AF6hcaBCeY1fyxYuUpIA8JbQPaKeAScorasY1pT4R945dNFRb+PjHgk7kR8SJJaNP/J9MSIvidErmgzfo56oL1XQmVPrEQFAZL1Pk7q22/hZIlCzTichxrpnzOZ0v44GGD7kLf2I/3NEAsJehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vVWFhcPc; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vVWFhcPc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781753939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ljz5L5/fb2UuDq3qcgP3FoZaiRo87+uGExdQujT+41M=;
	b=vVWFhcPcsI7VLQk7CN4JpSTCjkNAJq5/hxi9JVHFCsy/KGsYlVmcTZzsCuLp9fpgz8L8kh
	WOs9fUP/4H4LsHmKy1C2V7aFSDOHgCwDYWZAZ+ASazqGeqRGFHqFp0zxEgQ1wloJqydEFp
	F0GKyvI4B9c7hX/PPIr/mQZIr/3gb0s=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	hengqi.chen@gmail.com
Cc: kernel@xen0n.name,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 2/5] LoongArch: BPF: Add private stack support
Date: Thu, 18 Jun 2026 11:38:06 +0800
Message-Id: <20260618033809.98253-3-dongtai.guo@linux.dev>
In-Reply-To: <20260618033809.98253-1-dongtai.guo@linux.dev>
References: <20260618033809.98253-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

Support per-program private stacks, advertised via
bpf_jit_supports_private_stack(). When the verifier marks a program with
jits_use_priv_stack (e.g. a sufficiently deep, potentially recursive
tracing program), its BPF stack is moved off the kernel stack into a
per-CPU allocation, reducing kernel stack pressure.

The private stack is allocated in bpf_int_jit_compile() as the
verifier-computed stack depth plus two 16-byte guard regions used to
detect overflow and underflow; the guards are initialised at allocation
time and validated in bpf_jit_free(). S5 (otherwise saved/restored but
unused by the JIT) is reused to hold the private stack pointer, loaded
in the prologue with the current CPU's per-CPU offset ($r21). When a
private stack is in use the BPF frame pointer points into this per-CPU
region and the BPF stack is no longer reserved on the kernel stack.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 111 ++++++++++++++++++++++++++++++++++-
 arch/loongarch/net/bpf_jit.h |   1 +
 2 files changed, 109 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 3f9ffdde2491..c410b02e64be 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -18,8 +18,13 @@
 
 #define REG_TCC		LOONGARCH_GPR_A6
 #define REG_ARENA	LOONGARCH_GPR_S6 /* For storing arena_vm_start */
+#define REG_PRIV_SP	LOONGARCH_GPR_S5 /* For storing the private stack pointer */
 #define BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack) (round_up(stack, 16) - 80)
 
+/* Memory size/value to protect private stack overflow/underflow */
+#define PRIV_STACK_GUARD_SZ	16
+#define PRIV_STACK_GUARD_VAL	0xEB9F12345678eb9fULL
+
 static const int regmap[] = {
 	/* return value from in-kernel function, and exit value for eBPF program */
 	[BPF_REG_0] = LOONGARCH_GPR_A5,
@@ -40,6 +45,15 @@ static const int regmap[] = {
 	[BPF_REG_AX] = LOONGARCH_GPR_T0,
 };
 
+static void emit_percpu_ptr(struct jit_ctx *ctx, u8 dst, void __percpu *ptr)
+{
+	move_imm(ctx, dst, (__force long)ptr, false);
+#ifdef CONFIG_SMP
+	/* dst += __my_cpu_offset, held in $r21 */
+	emit_insn(ctx, addd, dst, dst, LOONGARCH_GPR_U0);
+#endif
+}
+
 static void prepare_bpf_tail_call_cnt(struct jit_ctx *ctx, int *store_offset)
 {
 	const struct bpf_prog *prog = ctx->prog;
@@ -141,7 +155,14 @@ static void build_prologue(struct jit_ctx *ctx)
 		stack_adjust += 8;
 
 	stack_adjust = round_up(stack_adjust, 16);
-	stack_adjust += bpf_stack_adjust;
+
+	/*
+	 * When a private stack is used the BPF stack lives in a per-CPU
+	 * allocation rather than on the kernel stack, so only the non-BPF
+	 * part is reserved here.
+	 */
+	if (!ctx->priv_sp_used)
+		stack_adjust += bpf_stack_adjust;
 
 	move_reg(ctx, LOONGARCH_GPR_T0, LOONGARCH_GPR_RA);
 	/* Reserve space for the move_imm + jirl instruction */
@@ -191,8 +212,16 @@ static void build_prologue(struct jit_ctx *ctx)
 
 	emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_adjust);
 
-	if (bpf_stack_adjust)
+	if (ctx->priv_sp_used) {
+		/* Set up the private stack pointer and the BPF frame pointer */
+		void __percpu *priv_stack_ptr;
+
+		priv_stack_ptr = prog->aux->priv_stack_ptr + PRIV_STACK_GUARD_SZ;
+		emit_percpu_ptr(ctx, REG_PRIV_SP, priv_stack_ptr);
+		emit_insn(ctx, addid, regmap[BPF_REG_FP], REG_PRIV_SP, bpf_stack_adjust);
+	} else if (bpf_stack_adjust) {
 		emit_insn(ctx, addid, regmap[BPF_REG_FP], LOONGARCH_GPR_SP, bpf_stack_adjust);
+	}
 
 	ctx->stack_size = stack_adjust;
 
@@ -2166,6 +2195,39 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 	return ret < 0 ? ret : ret * LOONGARCH_INSN_SIZE;
 }
 
+static void priv_stack_init_guard(void __percpu *priv_stack_ptr, int alloc_size)
+{
+	int cpu, underflow_idx = (alloc_size - PRIV_STACK_GUARD_SZ) >> 3;
+	u64 *stack_ptr;
+
+	for_each_possible_cpu(cpu) {
+		stack_ptr = per_cpu_ptr(priv_stack_ptr, cpu);
+		stack_ptr[0] = PRIV_STACK_GUARD_VAL;
+		stack_ptr[1] = PRIV_STACK_GUARD_VAL;
+		stack_ptr[underflow_idx] = PRIV_STACK_GUARD_VAL;
+		stack_ptr[underflow_idx + 1] = PRIV_STACK_GUARD_VAL;
+	}
+}
+
+static void priv_stack_check_guard(void __percpu *priv_stack_ptr, int alloc_size,
+				   struct bpf_prog *prog)
+{
+	int cpu, underflow_idx = (alloc_size - PRIV_STACK_GUARD_SZ) >> 3;
+	u64 *stack_ptr;
+
+	for_each_possible_cpu(cpu) {
+		stack_ptr = per_cpu_ptr(priv_stack_ptr, cpu);
+		if (stack_ptr[0] != PRIV_STACK_GUARD_VAL ||
+		    stack_ptr[1] != PRIV_STACK_GUARD_VAL ||
+		    stack_ptr[underflow_idx] != PRIV_STACK_GUARD_VAL ||
+		    stack_ptr[underflow_idx + 1] != PRIV_STACK_GUARD_VAL) {
+			pr_err("BPF private stack overflow/underflow detected for prog %sx\n",
+			       bpf_jit_get_prog_name(prog));
+			break;
+		}
+	}
+}
+
 struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	bool extra_pass = false;
@@ -2174,7 +2236,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	struct jit_ctx ctx;
 	struct jit_data *jit_data;
 	struct bpf_binary_header *header;
-	struct bpf_binary_header *ro_header;
+	struct bpf_binary_header *ro_header = NULL;
+	void __percpu *priv_stack_ptr = NULL;
+	int priv_stack_alloc_sz;
 
 	/*
 	 * If BPF JIT was not enabled then we must fall back to
@@ -2190,6 +2254,22 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			return prog;
 		prog->aux->jit_data = jit_data;
 	}
+	priv_stack_ptr = prog->aux->priv_stack_ptr;
+	if (!priv_stack_ptr && prog->aux->jits_use_priv_stack) {
+		/*
+		 * Allocate the actual private stack: the verifier-calculated
+		 * stack size plus two guard regions to detect overflow and
+		 * underflow.
+		 */
+		priv_stack_alloc_sz = round_up(prog->aux->stack_depth, 16) +
+				      2 * PRIV_STACK_GUARD_SZ;
+		priv_stack_ptr = __alloc_percpu_gfp(priv_stack_alloc_sz, 16, GFP_KERNEL);
+		if (!priv_stack_ptr)
+			goto out_priv_stack;
+
+		priv_stack_init_guard(priv_stack_ptr, priv_stack_alloc_sz);
+		prog->aux->priv_stack_ptr = priv_stack_ptr;
+	}
 	if (jit_data->ctx.offset) {
 		ctx = jit_data->ctx;
 		ro_header = jit_data->ro_header;
@@ -2205,6 +2285,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	ctx.prog = prog;
 	ctx.arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
 	ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
+	ctx.priv_sp_used = priv_stack_ptr ? true : false;
 
 	ctx.offset = kvcalloc(prog->len + 1, sizeof(u32), GFP_KERNEL);
 	if (ctx.offset == NULL)
@@ -2298,7 +2379,17 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		bpf_prog_fill_jited_linfo(prog, ctx.offset + 1);
 
 out_offset:
+		/*
+		 * A NULL ro_header here means the JIT failed, so release the
+		 * private stack that was allocated above; on success the
+		 * program keeps it until bpf_jit_free().
+		 */
+		if (!ro_header && priv_stack_ptr) {
+			free_percpu(priv_stack_ptr);
+			prog->aux->priv_stack_ptr = NULL;
+		}
 		kvfree(ctx.offset);
+out_priv_stack:
 		kfree(jit_data);
 		prog->aux->jit_data = NULL;
 	}
@@ -2324,6 +2415,8 @@ void bpf_jit_free(struct bpf_prog *prog)
 	if (prog->jited) {
 		struct jit_data *jit_data = prog->aux->jit_data;
 		struct bpf_binary_header *hdr;
+		void __percpu *priv_stack_ptr;
+		int priv_stack_alloc_sz;
 
 		/*
 		 * If we fail the final pass of JIT (from jit_subprogs), the
@@ -2336,6 +2429,13 @@ void bpf_jit_free(struct bpf_prog *prog)
 		}
 		hdr = bpf_jit_binary_pack_hdr(prog);
 		bpf_jit_binary_pack_free(hdr, NULL);
+		priv_stack_ptr = prog->aux->priv_stack_ptr;
+		if (priv_stack_ptr) {
+			priv_stack_alloc_sz = round_up(prog->aux->stack_depth, 16) +
+					      2 * PRIV_STACK_GUARD_SZ;
+			priv_stack_check_guard(priv_stack_ptr, priv_stack_alloc_sz, prog);
+			free_percpu(prog->aux->priv_stack_ptr);
+		}
 		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
 	}
 
@@ -2382,6 +2482,11 @@ bool bpf_jit_supports_fsession(void)
 	return true;
 }
 
+bool bpf_jit_supports_private_stack(void)
+{
+	return true;
+}
+
 /* Indicate the JIT backend supports mixing bpf2bpf and tailcalls. */
 bool bpf_jit_supports_subprog_tailcalls(void)
 {
diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
index a8e29be35fa8..01a7ea47e79b 100644
--- a/arch/loongarch/net/bpf_jit.h
+++ b/arch/loongarch/net/bpf_jit.h
@@ -22,6 +22,7 @@ struct jit_ctx {
 	u32 stack_size;
 	u64 arena_vm_start;
 	u64 user_vm_start;
+	bool priv_sp_used;
 };
 
 struct jit_data {
-- 
2.25.1

