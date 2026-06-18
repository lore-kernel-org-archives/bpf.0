Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A112EA151
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 03:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781753948; cv=none; b=O/n3IVhkoojaaAinFea/FmP8fF+2dV++AOSXmKXUd6Cuk9lRfXqJ9rdeII1pwRaYbv6OBvYfqslSa6y+SQXT2F4JkKxiYvO5MiOJNWD6g7UUp49gkg2PKfw/4U36Z9ssE5jAijF/GRSzfHIdFz7oPCPHs2w0qnfpM3rCjrq8gr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781753948; c=relaxed/simple;
	bh=hWwc9vCTbHwqbLb49C2jRYtUYTkKqOWcronIJUVTuQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I199hjay4e6/ME/eTGmll5FQyRntHE06jvggHSQQTexKv+eIEqYxpfeB8GL+6kI5v0qxFCA4Lca8K8g2QDEAaMK1iCPzM9EnKDrs170uAiSp8y1xndPdVyQTbch6iIOAW5W4ISiI1Jr6eOLA77JEA0pKGI0Vb0C+nTeeS8OIS2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EGVVuuZP; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EGVVuuZP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781753944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=scwsAaM724Yb99IZI+Tb13RGCWqEK8zZgDZxNWb4PXc=;
	b=EGVVuuZPNirTC7+NdEqnHCCKfdH5cS22n/kB0rStNaQYrOHcW0XzmiEmYav28kVB/RE648
	qVVjweYtUwyusfzhAPdXp3p7cDZvryJ1WbThD17vi0Uo3R50AUmxYa6QjFfmY+kYIohqYY
	Be3nkKnfKEGbVqByiNImp6EyiBWmu1M=
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
Subject: [PATCH 3/5] LoongArch: BPF: Add exceptions (bpf_throw) support
Date: Thu, 18 Jun 2026 11:38:07 +0800
Message-Id: <20260618033809.98253-4-dongtai.guo@linux.dev>
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

Implement BPF exception support, advertised via
bpf_jit_supports_exceptions(). bpf_throw() unwinds the stack to find the
exception boundary program's frame and then invokes its exception
callback with that frame's stack and frame pointers.

Finding the boundary frame needs arch_bpf_stack_walk(), which reports
each frame's (ip, sp, fp). This is implemented on top of the ORC
unwinder: ORC updates the frame pointer per frame and walks JITed BPF
code via its generated-code frame-pointer fallback, which expects the
frame record at fp-8 ($ra) and fp-16 (previous fp) -- exactly what the
LoongArch BPF prologue already lays down. The capability is therefore
gated on CONFIG_UNWINDER_ORC; with other unwinders it returns false.

The walk is seeded with the live frame pointer ($r22). The kernel is
built with -fomit-frame-pointer, so $fp is an ordinary callee-saved
register preserved across the call from the JITed program into
bpf_throw() down to arch_bpf_stack_walk(), where it still points at the
innermost BPF frame for the ORC fallback to start from. It is captured
in a thin wrapper with no large stack locals, because the worker that
runs the unwind uses $r22 to address its own (pt_regs + unwind_state)
frame and would otherwise clobber the live $fp before it could be read.

On the JIT side, the exception callback does not build a normal frame:
it receives the boundary program's frame pointer as its third argument
(a2), sets FP to it and SP to FP - stack_size, and reuses the boundary's
frame. Because the callee-saved register saves are anchored at the top
of the frame (FP), the existing FP-relative epilogue restores the
boundary's registers and returns to the boundary's caller regardless of
the two programs' individual frame sizes. To keep the boundary and the
callback agreeing on the layout, the s6 slot is always reserved for
exception programs, mirroring the arena case.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/kernel/stacktrace.c | 52 ++++++++++++++++++++++++++++++
 arch/loongarch/net/bpf_jit.c       | 41 +++++++++++++++++++++--
 2 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/kernel/stacktrace.c b/arch/loongarch/kernel/stacktrace.c
index 387dc4d3c486..718c98b3f1fc 100644
--- a/arch/loongarch/kernel/stacktrace.c
+++ b/arch/loongarch/kernel/stacktrace.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2022 Loongson Technology Corporation Limited
  */
+#include <linux/filter.h>
 #include <linux/sched.h>
 #include <linux/stacktrace.h>
 #include <linux/uaccess.h>
@@ -40,6 +41,57 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 	}
 }
 
+#ifdef CONFIG_UNWINDER_ORC
+/*
+ * Used by BPF exception support (bpf_throw) to find the exception boundary
+ * frame. The ORC unwinder reports the stack and frame pointer of each frame
+ * and, via its generated-code fallback, can walk JITed BPF frames, which set
+ * up the expected frame record ($ra at fp-8, previous fp at fp-16).
+ */
+static noinline void walk_stackframe_bpf(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp),
+					 void *cookie, unsigned long fp)
+{
+	unsigned long addr;
+	struct pt_regs dummyregs;
+	struct pt_regs *regs = &dummyregs;
+	struct unwind_state state;
+
+	regs->regs[3] = (unsigned long)__builtin_frame_address(0);
+	regs->csr_era = (unsigned long)__builtin_return_address(0);
+	regs->regs[1] = 0;
+	regs->regs[22] = fp;
+
+	for (unwind_start(&state, current, regs);
+	     !unwind_done(&state); unwind_next_frame(&state)) {
+		addr = unwind_get_return_address(&state);
+		if (!addr || !consume_fn(cookie, (u64)addr, (u64)state.sp, (u64)state.fp))
+			break;
+	}
+}
+
+void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp),
+			 void *cookie)
+{
+	unsigned long fp;
+
+	/*
+	 * Capture the live frame pointer ($r22/$fp) here, before handing off to
+	 * the worker. The kernel is built with -fomit-frame-pointer, so $fp is
+	 * an ordinary callee-saved register that is preserved across the call
+	 * from the JITed BPF program into bpf_throw() down to here, and thus
+	 * still points at the innermost BPF frame. The ORC frame-pointer
+	 * fallback walks the BPF frames up to the exception boundary from it.
+	 *
+	 * This must be a thin wrapper with no large stack locals: the worker
+	 * uses $r22 to address its frame, which would clobber the live $fp
+	 * before it could be read. __builtin_frame_address() cannot be used
+	 * either, as it is $sp-derived and would yield a kernel-stack frame.
+	 */
+	asm volatile("move %0, $r22" : "=r"(fp));
+	walk_stackframe_bpf(consume_fn, cookie, fp);
+}
+#endif /* CONFIG_UNWINDER_ORC */
+
 int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry,
 			     void *cookie, struct task_struct *task)
 {
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index c410b02e64be..22527428f0b3 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -142,6 +142,13 @@ static void build_prologue(struct jit_ctx *ctx)
 	int i, stack_adjust = 0, store_offset, bpf_stack_adjust;
 	const struct bpf_prog *prog = ctx->prog;
 	const bool is_main_prog = !bpf_is_subprog(prog);
+	/*
+	 * Exception boundary and callback programs must agree on the frame
+	 * layout: the callback reuses the boundary's frame to restore its
+	 * callee-saved registers, so the s6 slot is always reserved for them.
+	 */
+	const bool is_exception_prog = prog->aux->exception_boundary ||
+				       prog->aux->exception_cb;
 
 	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
 
@@ -151,7 +158,7 @@ static void build_prologue(struct jit_ctx *ctx)
 	/* To store tcc and tcc_ptr */
 	stack_adjust += sizeof(long) * 2;
 
-	if (ctx->arena_vm_start)
+	if (ctx->arena_vm_start || is_exception_prog)
 		stack_adjust += 8;
 
 	stack_adjust = round_up(stack_adjust, 16);
@@ -177,6 +184,19 @@ static void build_prologue(struct jit_ctx *ctx)
 	if (is_main_prog)
 		emit_insn(ctx, addid, REG_TCC, LOONGARCH_GPR_ZERO, 0);
 
+	if (prog->aux->exception_cb) {
+		/*
+		 * The exception callback receives the boundary program's frame
+		 * pointer as its third argument (a2). Reuse that frame so the
+		 * (FP-anchored) epilogue restores the boundary's callee-saved
+		 * registers and returns to the boundary's caller. The boundary
+		 * already saved them, so nothing is pushed here.
+		 */
+		move_reg(ctx, LOONGARCH_GPR_FP, LOONGARCH_GPR_A2);
+		emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_FP, -stack_adjust);
+		goto setup_bpf_fp;
+	}
+
 	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -stack_adjust);
 
 	store_offset = stack_adjust - sizeof(long);
@@ -203,7 +223,7 @@ static void build_prologue(struct jit_ctx *ctx)
 	store_offset -= sizeof(long);
 	emit_insn(ctx, std, LOONGARCH_GPR_S5, LOONGARCH_GPR_SP, store_offset);
 
-	if (ctx->arena_vm_start) {
+	if (ctx->arena_vm_start || is_exception_prog) {
 		store_offset -= sizeof(long);
 		emit_insn(ctx, std, REG_ARENA, LOONGARCH_GPR_SP, store_offset);
 	}
@@ -212,6 +232,7 @@ static void build_prologue(struct jit_ctx *ctx)
 
 	emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_adjust);
 
+setup_bpf_fp:
 	if (ctx->priv_sp_used) {
 		/* Set up the private stack pointer and the BPF frame pointer */
 		void __percpu *priv_stack_ptr;
@@ -233,6 +254,9 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
 {
 	int stack_adjust = ctx->stack_size;
 	int load_offset;
+	const struct bpf_prog *prog = ctx->prog;
+	const bool is_exception_prog = prog->aux->exception_boundary ||
+				       prog->aux->exception_cb;
 
 	load_offset = stack_adjust - sizeof(long);
 	emit_insn(ctx, ldd, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, load_offset);
@@ -258,7 +282,7 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
 	load_offset -= sizeof(long);
 	emit_insn(ctx, ldd, LOONGARCH_GPR_S5, LOONGARCH_GPR_SP, load_offset);
 
-	if (ctx->arena_vm_start) {
+	if (ctx->arena_vm_start || is_exception_prog) {
 		load_offset -= sizeof(long);
 		emit_insn(ctx, ldd, REG_ARENA, LOONGARCH_GPR_SP, load_offset);
 	}
@@ -2487,6 +2511,17 @@ bool bpf_jit_supports_private_stack(void)
 	return true;
 }
 
+bool bpf_jit_supports_exceptions(void)
+{
+	/*
+	 * Walking kernel and BPF frames from within bpf_throw() relies on
+	 * arch_bpf_stack_walk(), which is only implemented for the ORC
+	 * unwinder. ORC reports each frame's stack and frame pointer and
+	 * walks JITed BPF frames via its frame-pointer fallback.
+	 */
+	return IS_ENABLED(CONFIG_UNWINDER_ORC);
+}
+
 /* Indicate the JIT backend supports mixing bpf2bpf and tailcalls. */
 bool bpf_jit_supports_subprog_tailcalls(void)
 {
-- 
2.25.1

