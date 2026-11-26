Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795664460;
	b=dLYwrbBn4ZUQEjKbApahnfXONLRnwB8U3tTR2cAYVPB4xVO4mmyUmA2GP/h4UJu50Ht5
	 ak81SGGNBh42Il2UqKx06+JaBVL3f6Z9ExNfA5SOnisgNbIxTLkYgKBTfQpiE3/hKUAbn
	 XJl4WJ0/K7o2LJN3JAUogPGGXZoB2eYS30WDMQ1t0ePMaRxb9NjQNmjTbgIBbT9kLTf/M
	 TUyj7REgD2EWPmYiS6EIu+uWgxauU5iJGFSL7snx55NhXFMpRzO+QmVYVmoOn6ETH0eq0
	 Ta2NtgyxENBSevt7e/eE9a79KVlIp1S8BCtybTdXcmEoH0uyP4nOBDVVoNjfRm7+Pnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795664460;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2iOrCUIj378mJyxyHnqkmZI6s41NJbMX2yVLmntQcE4=;
	b=G3lAD7c23qCZdKJglwwjVeoSo9TczMJHFSIvB0dATVmye1D5CbHqh5+82/5QX4xyYPpc
	 bgIOTd37wjE4hTGgHHDTpEiBQxsjmdNtSIJmyvTCAlizXUCw9bGIczxYaMzTnHgj3Ld5X
	 9OAi37ncA8OSQpRmtvy2Ym3pzg8hVGb/oAYVLwE/tTsbAjWt/qK8tnEFQvfUz6q0QlYmg
	 aD2hkTyxWq9U26H9uSPcrAJD5jJeKMRJUEA8Pf1ToQT0koacrfw3O1zxjdod6oSS+Dmzm
	 /uqMBRfWDHT5GTndpFKscXCCEiOIyg2BTaVyhTavk4tw0I6XIQx/YwFErmjy6YEkJxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fbhxRlMD;
	arc=none smtp.remote-ip=95.215.58.219
Received: from mta1.migadu.com (out-219.mta1.migadu.com [95.215.58.219])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C954606A336
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 03:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C954606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fbhxRlMD
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uUmdahuLxDNRbhHZJ2aVyJ/ZZn+3XnApmgUizSYaQtw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795664457; v=1; x=1796269257;
 b=fbhxRlMDmhFx6oNo7b/Eg2HlLlIeUsghTqy31bVyqoLIJcIB745PIdlC8kR5gMTrWlYZ6ZMV
 EKYySql2eaR3pfTtc9WrZ/MrBp9wV4LXXnjuBUHrlT8gZQWYretMWsDYxjs55BXYUKmeRulGgKH
 yPoX+U04WEN4YqTTaCQNazdo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 42b23a4beb871a18;
	Thu, 26 Nov 2026 03:40:57 +0000
X-Mizu-Trace-ID: 42b23a4beb871a18
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn
Cc: hengqi.chen@gmail.com,
	guodongtai@kylinos.cn,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] LoongArch: BPF: Add support for private stack
Date: Thu, 26 Nov 2026 12:40:43 +0900
Message-ID: <20261126034048.7370-2-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126034048.7370-1-dongtai.guo@linux.dev>
References: <20261126034048.7370-1-dongtai.guo@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: George Guo <guodongtai@kylinos.cn>

Currently, the BPF stack of a program always lives on the kernel stack.
If the JIT supports private stack, the verifier marks a deep tracing or
struct_ops program with jits_use_priv_stack, so that its BPF stack can
be moved into a per-CPU allocation to reduce the kernel stack pressure.

Allocate a per-CPU private stack with guard regions to detect overflow
and underflow, and check the guards in bpf_jit_free(). In the prologue,
use $r21 to locate the current CPU's private stack and set the BPF frame
pointer, instead of allocating the BPF stack on the kernel stack.

This is similar to commit 6c17a882d380 ("bpf, arm64: JIT support for
private stack").

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 111 ++++++++++++++++++++++++++++++++++-
 arch/loongarch/net/bpf_jit.h |   1 +
 2 files changed, 109 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 567729921d6d..3ff15b64925f 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -30,6 +30,10 @@
 #define REG_ARENA	LOONGARCH_GPR_S6 /* For storing arena_vm_start */
 #define BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack) (round_up(stack, 16) - 80)
 
+/* Memory size/value to protect private stack overflow/underflow */
+#define PRIV_STACK_GUARD_SZ	16
+#define PRIV_STACK_GUARD_VAL	0xEB9F12345678eb9fULL
+
 static const int regmap[] = {
 	/* return value from in-kernel function, and exit value for eBPF program */
 	[BPF_REG_0] = LOONGARCH_GPR_A5,
@@ -50,6 +54,15 @@ static const int regmap[] = {
 	[BPF_REG_AX] = LOONGARCH_GPR_T0,
 };
 
+static void emit_percpu_ptr(struct jit_ctx *ctx, u8 dst, void __percpu *ptr)
+{
+	move_imm(ctx, dst, (__force long)ptr);
+#ifdef CONFIG_SMP
+	/* dst += __my_cpu_offset, held in $r21 */
+	emit_insn(ctx, addd, dst, dst, LOONGARCH_GPR_U0);
+#endif
+}
+
 static void prepare_bpf_tail_call_cnt(struct jit_ctx *ctx, int *store_offset)
 {
 	const struct bpf_prog *prog = ctx->prog;
@@ -133,7 +146,14 @@ static void build_prologue(struct jit_ctx *ctx)
 		stack_adjust += sizeof(long);
 
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
@@ -188,8 +208,16 @@ static void build_prologue(struct jit_ctx *ctx)
 
 	emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_adjust);
 
-	if (bpf_stack_adjust)
+	if (ctx->priv_sp_used) {
+		/* Point the BPF frame pointer at the top of this CPU's private stack */
+		void __percpu *priv_stack_ptr;
+
+		priv_stack_ptr = prog->aux->priv_stack_ptr + PRIV_STACK_GUARD_SZ;
+		emit_percpu_ptr(ctx, regmap[BPF_REG_FP], priv_stack_ptr);
+		emit_insn(ctx, addid, regmap[BPF_REG_FP], regmap[BPF_REG_FP], bpf_stack_adjust);
+	} else if (bpf_stack_adjust) {
 		emit_insn(ctx, addid, regmap[BPF_REG_FP], LOONGARCH_GPR_SP, bpf_stack_adjust);
+	}
 
 	ctx->stack_size = stack_adjust;
 
@@ -2280,6 +2308,39 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
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
@@ -2288,7 +2349,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	struct jit_ctx ctx;
 	struct jit_data *jit_data;
 	struct bpf_binary_header *header;
-	struct bpf_binary_header *ro_header;
+	struct bpf_binary_header *ro_header = NULL;
+	void __percpu *priv_stack_ptr = NULL;
+	int priv_stack_alloc_sz;
 
 	/*
 	 * If BPF JIT was not enabled then we must fall back to
@@ -2304,6 +2367,22 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
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
@@ -2321,6 +2400,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		ctx.arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
 		ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
 	}
+	ctx.priv_sp_used = priv_stack_ptr ? true : false;
 
 	ctx.offset = kvzalloc_objs(u32, prog->len + 1);
 	if (ctx.offset == NULL)
@@ -2422,7 +2502,17 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		bpf_prog_update_insn_ptrs(prog, ctx.offset, ctx.ro_image);
 
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
@@ -2439,6 +2529,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	if (header) {
 		bpf_arch_text_copy(&ro_header->size, &header->size, sizeof(header->size));
 		bpf_jit_binary_pack_free(ro_header, header);
+		ro_header = NULL;
 	}
 	goto out_offset;
 }
@@ -2448,6 +2539,8 @@ void bpf_jit_free(struct bpf_prog *prog)
 	if (prog->jited) {
 		struct jit_data *jit_data = prog->aux->jit_data;
 		struct bpf_binary_header *hdr;
+		void __percpu *priv_stack_ptr;
+		int priv_stack_alloc_sz;
 
 		/*
 		 * If we fail the final pass of JIT (from jit_subprogs), the
@@ -2461,6 +2554,13 @@ void bpf_jit_free(struct bpf_prog *prog)
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
 
@@ -2544,6 +2644,11 @@ bool bpf_jit_supports_ptr_xchg(void)
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
index 777c76112d95..bd11ca8fec53 100644
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
2.53.0

