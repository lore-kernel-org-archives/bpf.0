Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4483002CF
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 02:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782959088; cv=none; b=DXpYSvFP6p6HEi2jSa6IhMPdjMgMN+92efYKj4PV7KWRjwpuaV4OAV3QvE2CgkDuYbkG7zmsrDh6pb2yVanLFZ52O0ZluHQoIPG7oe24JD7lX2hoyghbcpptxZKyL89lHemTKI6T036Gl66G9R6OCXHo3Aau8XfROMg2xFMf+ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782959088; c=relaxed/simple;
	bh=sjVmMbOVY1gDfWO9UZomy7o+bqlzFnGqx0crFmusGjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sHbSgr2JXkbnBtpQmMc+QyeoAyieuXvBsckbav8lW0K9HpvmWqWSZbPDeoJlRfHUoueQSpAfSPyQ1sIFUTm4K1tjdUytjsbub8S0EltYBDUzel+z50qhqGhn1fdqRFeuRHbwHDeCt/8/rPCmV1lh589mKhJWUKOrppxC2Q89OxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B1QwPYUd; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B1QwPYUd"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782959085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oRfY36aXVerkshXysqx45Mhcj0glrMVJ9gPGXyeVg6g=;
	b=B1QwPYUdTL3q9TCWXyDRRtv/rCZEBqpqgCQDma5AA0xUu85Cr6KBSNbd9mR73PKwSuyfZf
	jgqzVbqNlPN2e382ZxMKz9VmmA2p4EyvsMVAjs8k1DlLiDTBxcNh/dp6hflWphRWnDjFTW
	+2dsejvJ+ldjOBUTYNmAKLEVWAWNeZQ=
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
Subject: [PATCH bpf-next v2 05/11] LoongArch: BPF: Add exceptions (bpf_throw) support
Date: Thu,  2 Jul 2026 10:23:16 +0800
Message-Id: <20260702022322.51033-6-dongtai.guo@linux.dev>
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
 arch/loongarch/kernel/stacktrace.c | 52 ++++++++++++++++++++++++++++
 arch/loongarch/net/bpf_jit.c       | 54 ++++++++++++++++++++++++++----
 2 files changed, 100 insertions(+), 6 deletions(-)

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
index 3822e05a0779..f172ffc2c011 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -29,16 +29,20 @@
 
 static int tail_call_cnt_ptr_stack_off(struct jit_ctx *ctx)
 {
+	const struct bpf_prog *prog = ctx->prog;
+	const bool is_exception_prog = prog->aux->exception_boundary ||
+				       prog->aux->exception_cb;
 	/* Ten words are pushed below the BPF stack: ra, fp, s0-s5, and the
 	 * tail call count plus its pointer, which occupy the two deepest
 	 * slots of the callee-saved area.
 	 */
 	int offset = sizeof(long) * 10;
 
-	/* An arena program reserves one extra word above them (REG_ARENA),
-	 * which pushes the tail call count pointer down by one slot.
+	/* An arena or exception program reserves one extra word above them
+	 * ($s6, see build_prologue()), which pushes the tail call count
+	 * pointer down by one slot.
 	 */
-	if (ctx->arena_vm_start)
+	if (ctx->arena_vm_start || is_exception_prog)
 		offset += sizeof(long);
 
 	return round_up(ctx->stack_size, 16) - offset;
@@ -151,6 +155,9 @@ static void prepare_bpf_tail_call_cnt(struct jit_ctx *ctx, int *store_offset)
  *                            +-------------------------+
  *                            |           $s5           |
  *                            +-------------------------+
+ *                            |   $s6 (arena/exception) |
+ *                            |        (optional)       |
+ *                            +-------------------------+
  *                            |           tcc           |
  *                            +-------------------------+
  *                            |           tcc_ptr       |
@@ -165,6 +172,13 @@ static void build_prologue(struct jit_ctx *ctx)
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
 
@@ -174,7 +188,7 @@ static void build_prologue(struct jit_ctx *ctx)
 	/* To store tcc and tcc_ptr */
 	stack_adjust += sizeof(long) * 2;
 
-	if (ctx->arena_vm_start)
+	if (ctx->arena_vm_start || is_exception_prog)
 		stack_adjust += 8;
 
 	stack_adjust = round_up(stack_adjust, 16);
@@ -205,6 +219,19 @@ static void build_prologue(struct jit_ctx *ctx)
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
@@ -231,7 +258,7 @@ static void build_prologue(struct jit_ctx *ctx)
 	store_offset -= sizeof(long);
 	emit_insn(ctx, std, LOONGARCH_GPR_S5, LOONGARCH_GPR_SP, store_offset);
 
-	if (ctx->arena_vm_start) {
+	if (ctx->arena_vm_start || is_exception_prog) {
 		store_offset -= sizeof(long);
 		emit_insn(ctx, std, REG_ARENA, LOONGARCH_GPR_SP, store_offset);
 	}
@@ -240,6 +267,7 @@ static void build_prologue(struct jit_ctx *ctx)
 
 	emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_adjust);
 
+setup_bpf_fp:
 	if (ctx->priv_sp_used) {
 		/* Set up the private stack pointer and the BPF frame pointer */
 		void __percpu *priv_stack_ptr;
@@ -261,6 +289,9 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
 {
 	int stack_adjust = ctx->stack_size;
 	int load_offset;
+	const struct bpf_prog *prog = ctx->prog;
+	const bool is_exception_prog = prog->aux->exception_boundary ||
+				       prog->aux->exception_cb;
 
 	load_offset = stack_adjust - sizeof(long);
 	emit_insn(ctx, ldd, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, load_offset);
@@ -286,7 +317,7 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
 	load_offset -= sizeof(long);
 	emit_insn(ctx, ldd, LOONGARCH_GPR_S5, LOONGARCH_GPR_SP, load_offset);
 
-	if (ctx->arena_vm_start) {
+	if (ctx->arena_vm_start || is_exception_prog) {
 		load_offset -= sizeof(long);
 		emit_insn(ctx, ldd, REG_ARENA, LOONGARCH_GPR_SP, load_offset);
 	}
@@ -2537,6 +2568,17 @@ bool bpf_jit_supports_private_stack(void)
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

