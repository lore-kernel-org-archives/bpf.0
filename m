Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2042E3B27F9
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 05:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139612; cv=none; b=ByXjQRfuaN5dmupvbaruDFP6ox81Z/nZQJn3kUpooAZ7PZntaCLr+4EDm1WbJl4vuxuCXQaWdJzewOcqX0B6iNMe4qNmHQLWeTNyPrEfGtF7o+xT5saDHfd5hx7S9IboqB+aK3Ver1cnw4B42tm8E8BVy6X0j4O3DmquWdkZHSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139612; c=relaxed/simple;
	bh=6GIDvsgrFeOpo2koBqWFA0JZ+vz4MXSa/lj3TuAuNis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMr9i6dLUuLv98HqTuORTZBrUR/iMe7BgIxX7d78LwHt9kta4Xaa5lrqT2+oLkTrqoUkmPN+HGsSXplvmwdy0isFTPYGdJM1yyO3HUGy3gbWRbgr3G0YDG4u0l3/B/jfPo4kLpRasb5CWAk5WI1pko+WmKNbB9lqNDbn6xghjco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 45B162C8DA7F11; Tue, 22 Sep 2026 21:59:53 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 13/21] bpf, arm64: Dispatch exception cleanup pads at run time
Date: Tue, 22 Sep 2026 21:59:53 -0700
Message-ID: <20260923045953.2420644-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923045846.2414643-1-yonghong.song@linux.dev>
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The same arch half for arm64: force the full callee-saved spill, record
where it starts, build the native table from the JIT's byte offsets, and
hand control to a pad from arch_bpf_run_cleanup_pad().

Unlike x86-64 a pad cannot simply return: every call it makes clobbers x3=
0,
so no return address survives to its resume. x23 carries it instead.
bpf2a64[] maps nothing to x23 or x24 -- they are pushed only to keep the
frame shape the exception callback expects -- so nothing else in generate=
d
code touches them, and being callee-saved they survive every kfunc the pa=
d
calls. The JIT emits "br x23" for a pad's bpf_unwind_resume().

x24 is the other one, and it is what makes a pad able to touch its own
frame at all. Generated code addresses the BPF frame through the stack
pointer -- the frame sits directly on top of it, which turns every offset
positive and each access into one instruction -- and in a pad the stack
pointer is the walker's. So the JIT has a pad recompute the equivalent of
its frame's stack pointer from BPF r10 on entry, into x24, and addresses
the frame off x24 for every instruction the previous patches marked as
running only while unwinding. One instruction per pad, and the accesses
keep the shape and the immediate range they have everywhere else.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/arm64/net/Makefile          |  2 +-
 arch/arm64/net/bpf_cleanup_pad.S | 94 ++++++++++++++++++++++++++++++++
 arch/arm64/net/bpf_jit_comp.c    | 92 +++++++++++++++++++++++++++++--
 3 files changed, 181 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/net/bpf_cleanup_pad.S

diff --git a/arch/arm64/net/Makefile b/arch/arm64/net/Makefile
index 3ae382bfca87..ebec2a44a52b 100644
--- a/arch/arm64/net/Makefile
+++ b/arch/arm64/net/Makefile
@@ -2,4 +2,4 @@
 #
 # ARM64 networking code
 #
-obj-$(CONFIG_BPF_JIT) +=3D bpf_jit_comp.o bpf_timed_may_goto.o
+obj-$(CONFIG_BPF_JIT) +=3D bpf_jit_comp.o bpf_timed_may_goto.o bpf_clean=
up_pad.o
diff --git a/arch/arm64/net/bpf_cleanup_pad.S b/arch/arm64/net/bpf_cleanu=
p_pad.S
new file mode 100644
index 000000000000..729b1ef3e585
--- /dev/null
+++ b/arch/arm64/net/bpf_cleanup_pad.S
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/linkage.h>
+
+/*
+ * A frame's prologue pushes the tail call counter pair, and then -- onc=
e
+ * bpf_exc_force_spill() says so -- x19/x20, x21/x22, x23/x24, x25/x26 a=
nd
+ * x27/x28. Each A64_PUSH pre-decrements, so the lowest address of the s=
pill
+ * area holds x27 and the highest x20:
+ *
+ *	spill_base + 0		x27 (private stack pointer)
+ *	spill_base + 8		x28 (arena base)
+ *	spill_base + 16		x25 (BPF r10, the frame pointer)
+ *	spill_base + 24		x26 (tail call counter pointer)
+ *	spill_base + 32		x23  -- the pad's own, see below
+ *	spill_base + 40		x24  -- likewise
+ *	spill_base + 48		x21 (BPF r8)
+ *	spill_base + 56		x22 (BPF r9)
+ *	spill_base + 64		x19 (BPF r6)
+ *	spill_base + 72		x20 (BPF r7)
+ *
+ * Neither x23 nor x24 is restored from that spill: the pad has its own =
use for
+ * both. bpf2a64[] maps nothing to either -- they are pushed only to kee=
p the
+ * frame shape the exception callback expects -- so nothing else in gene=
rated
+ * code touches them, and being callee-saved they survive every call the=
 pad
+ * makes.
+ *
+ * x23 is the pad's return address. Unlike x86-64 a pad cannot simply re=
turn:
+ * every call it makes clobbers x30, so nothing is left to return throug=
h by
+ * the time it reaches its resume. The JIT emits "br x23" for the pad's
+ * bpf_unwind_resume() and this routine puts .Lcleanup_pad_done there.
+ *
+ * x24 is where the pad's frame is anchored. Generated code addresses th=
e BPF
+ * frame through the stack pointer, which here is this routine's rather =
than
+ * the unwinding frame's, so the JIT has the pad recompute the equivalen=
t from
+ * BPF r10 on entry and address its frame off x24 for as long as it runs=
.
+ *
+ * Both of those branches are indirect, so both targets carry a BTI land=
ing
+ * marker: the JIT emits one at each pad, and .Lcleanup_pad_done below h=
as one
+ * of its own.
+ */
+
+	.text
+
+/*
+ * void arch_bpf_run_cleanup_pad(u64 pad, u64 frame_fp, u64 spill_base)
+ *
+ * x0 =3D native address of the landing pad
+ * x1 =3D frame pointer of the frame the pad belongs to (unused here: BP=
F r10 is
+ *      x25, which the spill area already holds)
+ * x2 =3D spill area holding that frame's BPF callee-saved registers
+ *
+ * Give the pad the register state of its own frame and call it. It runs=
 on
+ * this stack, far below the frame it is cleaning up after, so nothing i=
t
+ * calls can reach into that frame.
+ */
+SYM_FUNC_START(arch_bpf_run_cleanup_pad)
+	/* Save the kernel's callee-saved registers; the pad owns them next. */
+	stp	x29, x30, [sp, #-96]!
+	mov	x29, sp
+	stp	x19, x20, [sp, #16]
+	stp	x21, x22, [sp, #32]
+	stp	x23, x24, [sp, #48]
+	stp	x25, x26, [sp, #64]
+	stp	x27, x28, [sp, #80]
+
+	/* x9 is BPF_REG_AX, so the pad's address does not stay in BPF r1. */
+	mov	x9, x0
+
+	ldp	x27, x28, [x2, #0]
+	ldp	x25, x26, [x2, #16]
+	ldp	x21, x22, [x2, #48]
+	ldp	x19, x20, [x2, #64]
+
+	/* BPF r0 (x8) on the way into a pad, not whatever the kernel left. */
+	mov	x8, #1
+
+	/* Where the pad's resume branches back to. */
+	adr	x23, .Lcleanup_pad_done
+
+	br	x9
+
+.Lcleanup_pad_done:
+	/* Reached by the pad's "br x23", so it is an indirect branch target. *=
/
+	bti	j
+	ldp	x19, x20, [sp, #16]
+	ldp	x21, x22, [sp, #32]
+	ldp	x23, x24, [sp, #48]
+	ldp	x25, x26, [sp, #64]
+	ldp	x27, x28, [sp, #80]
+	ldp	x29, x30, [sp], #96
+	ret
+SYM_FUNC_END(arch_bpf_run_cleanup_pad)
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
index 6c04fee46876..c7209c26b235 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -10,6 +10,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/bitfield.h>
 #include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
 #include <linux/cfi.h>
 #include <linux/filter.h>
 #include <linux/memory.h>
@@ -75,6 +76,19 @@ static const int bpf2a64[] =3D {
 	[ARENA_VM_START] =3D A64_R(28),
 };
=20
+/*
+ * Throw-site spill: the five pairs push_callee_regs() forces on, same s=
ize and
+ * slot order, so arch_bpf_run_cleanup_pad() reads both alike.
+ */
+#define A64_CLEANUP_SPILL_SZ	(5 * 16)
+
+/*
+ * Where a landing pad's frame is anchored, since the stack pointer gene=
rated
+ * code normally addresses it through is the walker's inside a pad. bpf2=
a64[]
+ * maps nothing to x24, so nothing else in generated code touches it.
+ */
+#define A64_CLEANUP_FP		A64_R(24)
+
 struct jit_ctx {
 	const struct bpf_prog *prog;
 	int idx;
@@ -87,6 +101,8 @@ struct jit_ctx {
 	__le32 *ro_image;
 	u32 stack_size;
 	u16 stack_arg_size;
+	/* Bytes reserved for the throw-site spill; 0 unless this frame throws.=
 */
+	u32 throw_spill;
 	u64 user_vm_start;
 	u64 arena_vm_start;
 	bool fp_used;
@@ -432,7 +448,7 @@ static void push_callee_regs(struct jit_ctx *ctx)
 	 * Callee-saved registers as the exception callback needs to recover
 	 * all ARM64 Callee-saved registers in its epilogue.
 	 */
-	if (ctx->prog->aux->exception_boundary) {
+	if (ctx->prog->aux->exception_boundary || bpf_exc_force_spill(ctx->prog=
)) {
 		emit(A64_PUSH(A64_R(19), A64_R(20), A64_SP), ctx);
 		emit(A64_PUSH(A64_R(21), A64_R(22), A64_SP), ctx);
 		emit(A64_PUSH(A64_R(23), A64_R(24), A64_SP), ctx);
@@ -466,7 +482,8 @@ static void pop_callee_regs(struct jit_ctx *ctx)
 	 * program's stack frame, so recover these extra registers in the above
 	 * two cases.
 	 */
-	if (aux->exception_boundary || aux->exception_cb) {
+	if (aux->exception_boundary || aux->exception_cb ||
+	    bpf_exc_force_spill(ctx->prog)) {
 		emit(A64_POP(A64_R(27), A64_R(28), A64_SP), ctx);
 		emit(A64_POP(A64_R(25), A64_R(26), A64_SP), ctx);
 		emit(A64_POP(A64_R(23), A64_R(24), A64_SP), ctx);
@@ -602,6 +619,22 @@ static int build_prologue(struct jit_ctx *ctx, bool =
ebpf_from_cbpf)
 		emit(A64_SUB_I(1, A64_SP, A64_FP, 96), ctx);
 	}
=20
+	/*
+	 * Lowest address of each spill area, as an offset from A64_FP; see
+	 * bpf_cleanup_pad.S for the layout. The 16 is the tail call counter
+	 * pair pushed just below the frame record, and the throw-site area,
+	 * which only a frame that throws has, sits below the callee-saved one
+	 * rather than in the program stack.
+	 */
+	if (bpf_exc_force_spill(prog))
+		prog->aux->exc->spill_off =3D -(16 + A64_CLEANUP_SPILL_SZ);
+	if (bpf_exc_needs_throw_spill(prog)) {
+		ctx->throw_spill =3D A64_CLEANUP_SPILL_SZ;
+		emit(A64_SUB_I(1, A64_SP, A64_SP, ctx->throw_spill), ctx);
+		prog->aux->exc->throw_spill_off =3D
+			-(16 + A64_CLEANUP_SPILL_SZ) - ctx->throw_spill;
+	}
+
 	/* Stack must be multiples of 16B */
 	ctx->stack_size =3D round_up(prog->aux->stack_depth, 16);
=20
@@ -691,6 +724,9 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	if (ctx->stack_size && !ctx->priv_sp_used)
 		emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
=20
+	if (ctx->throw_spill)
+		emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->throw_spill), ctx);
+
 	pop_callee_regs(ctx);
=20
 	/* goto *(prog->bpf_func + prologue_offset); */
@@ -1055,6 +1091,9 @@ static void build_epilogue(struct jit_ctx *ctx, boo=
l was_classic)
 	if (ctx->stack_size && !ctx->priv_sp_used)
 		emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
=20
+	if (ctx->throw_spill)
+		emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->throw_spill), ctx);
+
 	pop_callee_regs(ctx);
=20
 	emit(A64_POP(A64_ZR, ptr, A64_SP), ctx);
@@ -1367,6 +1406,8 @@ static int build_insn(const struct bpf_verifier_env=
 *env, const struct bpf_insn
 	const s16 off =3D insn->off;
 	const s32 imm =3D insn->imm;
 	const int i =3D insn - ctx->prog->insnsi;
+	const bool in_pad =3D bpf_exc_insn_in_pad(env, ctx->prog, i);
+	const bool pad_head =3D bpf_exc_insn_is_pad(env, ctx->prog, i);
 	const bool is64 =3D BPF_CLASS(code) =3D=3D BPF_ALU64 ||
 			  BPF_CLASS(code) =3D=3D BPF_JMP;
 	u8 jmp_cond;
@@ -1378,9 +1419,13 @@ static int build_insn(const struct bpf_verifier_en=
v *env, const struct bpf_insn
 	int ret;
 	bool sign_extend;
=20
-	if (bpf_insn_is_indirect_target(env, ctx->prog, i))
+	if (bpf_insn_is_indirect_target(env, ctx->prog, i) || pad_head)
 		emit_bti(A64_BTI_J, ctx);
=20
+	if (pad_head)
+		emit(A64_SUB_I(1, A64_CLEANUP_FP, fp,
+			       ctx->stack_size + ctx->stack_arg_size), ctx);
+
 	switch (code) {
 	/* dst =3D src */
 	case BPF_ALU | BPF_MOV | BPF_X:
@@ -1743,6 +1788,26 @@ static int build_insn(const struct bpf_verifier_en=
v *env, const struct bpf_insn
 		u64 func_addr;
 		u32 cpu_offset;
=20
+		if (bpf_exc_insn_is_throw(env, ctx->prog, i)) {
+			/* Spill where the bpf_throw() walker looks. */
+			const s32 off =3D ctx->prog->aux->exc->throw_spill_off;
+
+			emit(A64_SUB_I(1, tmp, A64_FP, -off), ctx);
+			emit(A64_STR64I(bpf2a64[PRIVATE_SP], tmp, 0), ctx);
+			emit(A64_STR64I(bpf2a64[ARENA_VM_START], tmp, 8), ctx);
+			emit(A64_STR64I(bpf2a64[BPF_REG_FP], tmp, 16), ctx);
+			emit(A64_STR64I(bpf2a64[TCCNT_PTR], tmp, 24), ctx);
+			emit(A64_STR64I(bpf2a64[BPF_REG_8], tmp, 48), ctx);
+			emit(A64_STR64I(bpf2a64[BPF_REG_9], tmp, 56), ctx);
+			emit(A64_STR64I(bpf2a64[BPF_REG_6], tmp, 64), ctx);
+			emit(A64_STR64I(bpf2a64[BPF_REG_7], tmp, 72), ctx);
+		}
+
+		if (bpf_exc_insn_is_resume(env, ctx->prog, i)) {
+			emit(A64_BR(A64_R(23)), ctx);
+			break;
+		}
+
 		/* Implement helper call to bpf_get_smp_processor_id() inline */
 		if (insn->src_reg =3D=3D 0 && insn->imm =3D=3D BPF_FUNC_get_smp_proces=
sor_id) {
 			cpu_offset =3D offsetof(struct thread_info, cpu);
@@ -1854,7 +1919,8 @@ static int build_insn(const struct bpf_verifier_env=
 *env, const struct bpf_insn
 			src =3D tmp2;
 		}
 		if (src =3D=3D fp) {
-			src_adj =3D ctx->priv_sp_used ? priv_sp : A64_SP;
+			src_adj =3D ctx->priv_sp_used ? priv_sp :
+				  in_pad ? A64_CLEANUP_FP : A64_SP;
 			off_adj =3D off + ctx->stack_size;
 			if (!ctx->priv_sp_used)
 				off_adj +=3D ctx->stack_arg_size;
@@ -1952,7 +2018,8 @@ static int build_insn(const struct bpf_verifier_env=
 *env, const struct bpf_insn
 			dst =3D tmp3;
 		}
 		if (dst =3D=3D fp) {
-			dst_adj =3D ctx->priv_sp_used ? priv_sp : A64_SP;
+			dst_adj =3D ctx->priv_sp_used ? priv_sp :
+				  in_pad ? A64_CLEANUP_FP : A64_SP;
 			off_adj =3D off + ctx->stack_size;
 			if (!ctx->priv_sp_used)
 				off_adj +=3D ctx->stack_arg_size;
@@ -2021,7 +2088,8 @@ static int build_insn(const struct bpf_verifier_env=
 *env, const struct bpf_insn
 			dst =3D tmp2;
 		}
 		if (dst =3D=3D fp) {
-			dst_adj =3D ctx->priv_sp_used ? priv_sp : A64_SP;
+			dst_adj =3D ctx->priv_sp_used ? priv_sp :
+				  in_pad ? A64_CLEANUP_FP : A64_SP;
 			off_adj =3D off + ctx->stack_size;
 			if (!ctx->priv_sp_used)
 				off_adj +=3D ctx->stack_arg_size;
@@ -2410,6 +2478,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ve=
rifier_env *env, struct bpf_pr
 		 * reasons, expects to point to the next instruction)
 		 */
 		bpf_prog_update_insn_ptrs(prog, ctx.offset, ctx.ro_image);
+
+		/*
+		 * Same byte offsets, consumed by the bpf_throw() frame walker:
+		 * turn the cleanup records into native address ranges now that
+		 * the image is final.
+		 */
+		bpf_exc_fill_native_ranges(prog, ctx.offset, ctx.ro_image);
 out_off:
 		if (!ro_header && priv_stack_ptr) {
 			free_percpu(priv_stack_ptr);
@@ -3385,6 +3460,11 @@ bool bpf_jit_supports_exceptions(void)
 	return true;
 }
=20
+bool bpf_jit_supports_cleanup_pads(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_arena(void)
 {
 	return true;
--=20
2.53.0-Meta

