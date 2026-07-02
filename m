Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174532FBE1F
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 02:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782959077; cv=none; b=qp91AEs61sO9w/PpnBm9pN+BH0Qol604V9dHHjxGl7dKqQSbP4Iay+FcO6CgnWoE+ZZ5dgRG2mQkdcmWtAPngrU/oWHp8FP5vMj+Bgv0BL9PgTNng1vvSsva8hB3WHceOAi7PgJ6CL7IrMi06I//GAO4A+9aQm7WsmnNbpwGEng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782959077; c=relaxed/simple;
	bh=IAavs7RkcmXKAqRDVH/t5K5YlK0x7gZX1f0vw3qjtJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EuXIVQtPVzqpwAm1oje+eFz3JJnHnkgymgG6yzeOsEU8NfCEtUXnyhvwKuzWuegdf3wQb/a/3hkrOzXu/CILC/pYYixNo6ZE0MqgkwETxzWG91FH8tMD5CpBR0rS2TdLWT1ChfsyTcjjEr7OddBD/gHM3sxEiAvbKmETKNltvHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MPO6I5TQ; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MPO6I5TQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782959074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYY32EJF9UaglyRy6bei55DLa431KkwFtj+gO/A77sc=;
	b=MPO6I5TQ9xjbFwSa829oHeEf4k+nMWtzGvgtXviV6+wDbos8+eFCpAYbPriwTR7j9i++IM
	trUZmwFgF4tbX2TX5fufIEFC/wsyZ9IkGN7oeHtjwBNSUlA5ggpIdd0K/RHfb/8A83vT+d
	bggAQt+B9iYB8AkjWEhwg2Cg3jyKpT4=
From: George Guo <dongtai.guo@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	George Guo <guodongtai@kylinos.cn>,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 04/11] LoongArch: BPF: Add private stack support
Date: Thu,  2 Jul 2026 10:23:15 +0800
Message-Id: <20260702022322.51033-5-dongtai.guo@linux.dev>
In-Reply-To: <20260702022322.51033-1-dongtai.guo@linux.dev>
References: <20260702022322.51033-1-dongtai.guo@linux.dev>
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

The private stack is sized as the verifier-computed stack depth plus two
16-byte guard regions for overflow/underflow detection, initialised at
allocation time and validated in bpf_jit_free(). S5 (saved/restored but
otherwise unused by the JIT) holds the private stack pointer, computed in
the prologue from the current CPU's per-CPU offset ($r21).

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 112 ++++++++++++++++++++++++++++++++++-
 arch/loongarch/net/bpf_jit.h |   1 +
 2 files changed, 110 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index bb84b985cb45..3822e05a0779 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -25,6 +25,7 @@
 
 #define REG_TCC		LOONGARCH_GPR_A6
 #define REG_ARENA	LOONGARCH_GPR_S6 /* For storing arena_vm_start */
+#define REG_PRIV_SP	LOONGARCH_GPR_S5 /* For storing the private stack pointer */
 
 static int tail_call_cnt_ptr_stack_off(struct jit_ctx *ctx)
 {
@@ -43,6 +44,10 @@ static int tail_call_cnt_ptr_stack_off(struct jit_ctx *ctx)
 	return round_up(ctx->stack_size, 16) - offset;
 }
 
+/* Memory size/value to protect private stack overflow/underflow */
+#define PRIV_STACK_GUARD_SZ	16
+#define PRIV_STACK_GUARD_VAL	0xEB9F12345678eb9fULL
+
 static const int regmap[] = {
 	/* return value from in-kernel function, and exit value for eBPF program */
 	[BPF_REG_0] = LOONGARCH_GPR_A5,
@@ -63,6 +68,15 @@ static const int regmap[] = {
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
@@ -164,7 +178,14 @@ static void build_prologue(struct jit_ctx *ctx)
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
 
 	/*
 	 * Save the original return address to a temporary register to prevent
@@ -219,8 +240,16 @@ static void build_prologue(struct jit_ctx *ctx)
 
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
 
@@ -2225,6 +2254,39 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
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
+			pr_err("BPF private stack overflow/underflow detected for prog %s\n",
+			       bpf_jit_get_prog_name(prog));
+			break;
+		}
+	}
+}
+
 struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	bool extra_pass = false;
@@ -2233,7 +2295,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	struct jit_ctx ctx;
 	struct jit_data *jit_data;
 	struct bpf_binary_header *header;
-	struct bpf_binary_header *ro_header;
+	struct bpf_binary_header *ro_header = NULL;
+	void __percpu *priv_stack_ptr = NULL;
+	int priv_stack_alloc_sz;
 
 	/*
 	 * If BPF JIT was not enabled then we must fall back to
@@ -2249,6 +2313,22 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
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
@@ -2264,6 +2344,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	ctx.prog = prog;
 	ctx.arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
 	ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
+	ctx.priv_sp_used = priv_stack_ptr ? true : false;
 
 	ctx.offset = kvcalloc(prog->len + 1, sizeof(u32), GFP_KERNEL);
 	if (ctx.offset == NULL)
@@ -2357,7 +2438,17 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
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
@@ -2374,6 +2465,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	if (header) {
 		bpf_arch_text_copy(&ro_header->size, &header->size, sizeof(header->size));
 		bpf_jit_binary_pack_free(ro_header, header);
+		ro_header = NULL;
 	}
 	goto out_offset;
 }
@@ -2383,6 +2475,8 @@ void bpf_jit_free(struct bpf_prog *prog)
 	if (prog->jited) {
 		struct jit_data *jit_data = prog->aux->jit_data;
 		struct bpf_binary_header *hdr;
+		void __percpu *priv_stack_ptr;
+		int priv_stack_alloc_sz;
 
 		/*
 		 * If we fail the final pass of JIT (from jit_subprogs), the
@@ -2395,6 +2489,13 @@ void bpf_jit_free(struct bpf_prog *prog)
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
 
@@ -2431,6 +2532,11 @@ bool bpf_jit_supports_timed_may_goto(void)
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

