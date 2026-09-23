Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581993FB7E0
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 04:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139596; cv=none; b=fSmbjyprTDwEQKZmXVZuHEc+QCgAXsd/YzzOBxAWPenb/N4vJsVyfRWS99Kwwez76A3HxUv0tjDCxXmYGEJ0Tg1390R7Ej9Ne3qHV0L3UbNQKmITdi/+3/2xu1yxAKoAJMl5wuPToNvalx7orf0F+uElq6+3XTrGdcTUojo4vks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139596; c=relaxed/simple;
	bh=VBZ5EXEcFdqKT3Ib9yMXDq9srmvAORTa1qi3hgLl6J4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgE4mCOLqjVSafRpCABS3TBvYeLR1D6BL5BYh5tas9XPYM2lN/e5ujM4q5vFSz7rpV6+jRBtlMtpaN/5jS8UfhDTR7XNYCAs5qAPBNTuaz3mgiGsWRl9xA6p0QSZsU0Kt+uE6H/jARbEqiM5eu4vo7DilYuXOSlLZNCoME5cW5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 2924D2C8DA7EEB; Tue, 22 Sep 2026 21:59:48 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 12/21] bpf, x86: Dispatch exception cleanup pads at run time
Date: Tue, 22 Sep 2026 21:59:48 -0700
Message-ID: <20260923045948.2420512-1-yonghong.song@linux.dev>
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

Provide the arch half for x86-64: force the full callee-saved spill for a
program carrying a cleanup table so the walker can find a frame's r6-r9 i=
n
its callee's prologue, record where that spill area starts, build the
native cleanup table from the JIT's addrs[], emit a bare return for a pad=
's
bpf_unwind_resume(), and hand control to a pad from
arch_bpf_run_cleanup_pad().

Support is gated on CONFIG_UNWINDER_ORC, the same requirement
arch_bpf_stack_walk() and therefore bpf_throw() already have here, and
bpf_cleanup_pad.o is built only there. Nothing else can call it, and a
frame-pointer build would have objtool validate a routine that has to car=
ry
BPF r10 in rbp rather than a frame pointer ("call without frame pointer
save/setup", an error under CONFIG_OBJTOOL_WERROR).

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/Makefile          |  3 ++
 arch/x86/net/bpf_cleanup_pad.S | 79 +++++++++++++++++++++++++++++++++
 arch/x86/net/bpf_jit_comp.c    | 81 +++++++++++++++++++++++++++++-----
 3 files changed, 151 insertions(+), 12 deletions(-)
 create mode 100644 arch/x86/net/bpf_cleanup_pad.S

diff --git a/arch/x86/net/Makefile b/arch/x86/net/Makefile
index dddbefc0f439..8bb22644ba10 100644
--- a/arch/x86/net/Makefile
+++ b/arch/x86/net/Makefile
@@ -7,4 +7,7 @@ ifeq ($(CONFIG_X86_32),y)
         obj-$(CONFIG_BPF_JIT) +=3D bpf_jit_comp32.o
 else
         obj-$(CONFIG_BPF_JIT) +=3D bpf_jit_comp.o bpf_timed_may_goto.o
+        ifdef CONFIG_UNWINDER_ORC
+                obj-$(CONFIG_BPF_JIT) +=3D bpf_cleanup_pad.o
+        endif
 endif
diff --git a/arch/x86/net/bpf_cleanup_pad.S b/arch/x86/net/bpf_cleanup_pa=
d.S
new file mode 100644
index 000000000000..10d612b11f36
--- /dev/null
+++ b/arch/x86/net/bpf_cleanup_pad.S
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/linkage.h>
+#include <asm/nospec-branch.h>
+
+/*
+ * The x86-64 BPF JIT prologue spills, once bpf_exc_force_spill() makes =
it
+ * unconditional, r12, rbx, r13, r14 and r15 in that order -- so within =
the
+ * spill area the lowest address holds r15 and the highest r12. The thro=
w-site
+ * spill the JIT emits uses the same layout, so the routine below reads =
both
+ * the same way:
+ *
+ *	spill_base + 0		BPF r9  (r15)
+ *	spill_base + 8		BPF r8  (r14)
+ *	spill_base + 16		BPF r7  (r13)
+ *	spill_base + 24		BPF r6  (rbx)
+ *	spill_base + 32		r12 (arena base, not a BPF register)
+ */
+
+	.code64
+	.section .text, "ax"
+
+/*
+ * void arch_bpf_run_cleanup_pad(u64 pad, u64 frame_fp, u64 spill_base)
+ *
+ * rdi =3D native address of the landing pad
+ * rsi =3D frame pointer of the frame the pad belongs to
+ * rdx =3D spill area holding that frame's BPF callee-saved registers
+ *
+ * Give the pad the register state of its own frame and call it. The pad=
 ends
+ * in the bare return the JIT emits for its bpf_unwind_resume(), so it c=
omes
+ * back here rather than returning to its frame's caller. It runs on thi=
s
+ * stack, far below the frame it is cleaning up after, so nothing it cal=
ls can
+ * reach into that frame.
+ *
+ * rbp addresses the pad's frame and rsp this one, so the two are not th=
e
+ * neighbours a JITed frame expects them to be. That is why
+ * cleanup_check_pad_insn() refuses a call in a pad that passes an argum=
ent on
+ * the stack: the JIT stages those relative to rbp, and the callee reads=
 them
+ * relative to rsp.
+ */
+SYM_FUNC_START(arch_bpf_run_cleanup_pad)
+	ANNOTATE_NOENDBR
+
+	pushq %rbp
+	pushq %rbx
+	pushq %r12
+	pushq %r13
+	pushq %r14
+	pushq %r15
+	/* Keep the pad's entry rsp congruent to a normal call's. */
+	subq $8, %rsp
+
+	movq 0(%rdx), %r15
+	movq 8(%rdx), %r14
+	movq 16(%rdx), %r13
+	movq 24(%rdx), %rbx
+	movq 32(%rdx), %r12
+	/* rbp is BPF r10, so this is the whole of the pad's frame setup. */
+	movq %rsi, %rbp
+
+	/* CALL_NOSPEC needs the target in a register; rcx is BPF r4, dead. */
+	movq %rdi, %rcx
+
+	/* BPF r0 on the way into a pad, not whatever the kernel left in rax. *=
/
+	movl $1, %eax
+
+	CALL_NOSPEC rcx
+
+	addq $8, %rsp
+	popq %r15
+	popq %r14
+	popq %r13
+	popq %r12
+	popq %rbx
+	popq %rbp
+	RET
+SYM_FUNC_END(arch_bpf_run_cleanup_pad)
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d4a980140b48..26df52050cd7 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -357,6 +357,12 @@ struct jit_context {
 /* Number of bytes that will be skipped on tailcall */
 #define X86_TAIL_CALL_OFFSET	(12 + ENDBR_INSN_SIZE)
=20
+/*
+ * Throw-site spill: r15, r14, r13, rbx, r12 low to high, the layout the
+ * prologue's pushes leave, so arch_bpf_run_cleanup_pad() reads both ali=
ke.
+ */
+#define X86_CLEANUP_SPILL_SZ	(5 * 8)
+
 static void push_r9(u8 **pprog)
 {
 	u8 *prog =3D *pprog;
@@ -832,7 +838,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_pr=
og *bpf_prog,
 	/* Inc tail_call_cnt if the slot is populated. */
 	EMIT4(0x48, 0x83, 0x00, 0x01);            /* add qword ptr [rax], 1 */
=20
-	if (bpf_prog->aux->exception_boundary) {
+	if (bpf_prog->aux->exception_boundary || bpf_exc_force_spill(bpf_prog))=
 {
 		pop_callee_regs(&prog, all_callee_regs_used);
 		pop_r12(&prog);
 	} else {
@@ -899,7 +905,7 @@ static void emit_bpf_tail_call_direct(struct bpf_prog=
 *bpf_prog,
 	/* Inc tail_call_cnt if the slot is populated. */
 	EMIT4(0x48, 0x83, 0x00, 0x01);                /* add qword ptr [rax], 1=
 */
=20
-	if (bpf_prog->aux->exception_boundary) {
+	if (bpf_prog->aux->exception_boundary || bpf_exc_force_spill(bpf_prog))=
 {
 		pop_callee_regs(&prog, all_callee_regs_used);
 		pop_r12(&prog);
 	} else {
@@ -1977,6 +1983,7 @@ static int do_jit(struct bpf_verifier_env *env, str=
uct bpf_prog *bpf_prog, int *
 	u8 *ip, *prog =3D temp;
 	u32 stack_depth;
 	int callee_saved_size;
+	u32 throw_spill, prologue_depth;
 	s32 outgoing_arg_base;
 	int err;
=20
@@ -2015,7 +2022,10 @@ static int do_jit(struct bpf_verifier_env *env, st=
ruct bpf_prog *bpf_prog, int *
=20
 	detect_reg_usage(insn, insn_cnt, callee_regs_used);
=20
-	emit_prologue(&prog, image, stack_depth,
+	throw_spill =3D bpf_exc_needs_throw_spill(bpf_prog) ? X86_CLEANUP_SPILL=
_SZ : 0;
+	prologue_depth =3D stack_depth + throw_spill;
+
+	emit_prologue(&prog, image, prologue_depth,
 		      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
 		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
=20
@@ -2024,7 +2034,7 @@ static int do_jit(struct bpf_verifier_env *env, str=
uct bpf_prog *bpf_prog, int *
 	/* Exception callback will clobber callee regs for its own use, and
 	 * restore the original callee regs from main prog's stack frame.
 	 */
-	if (bpf_prog->aux->exception_boundary) {
+	if (bpf_prog->aux->exception_boundary || bpf_exc_force_spill(bpf_prog))=
 {
 		/* We also need to save r12, which is not mapped to any BPF
 		 * register, as we throw after entry into the kernel, which may
 		 * overwrite r12.
@@ -2039,9 +2049,10 @@ static int do_jit(struct bpf_verifier_env *env, st=
ruct bpf_prog *bpf_prog, int *
=20
 	/* Compute callee-saved register area size. */
 	callee_saved_size =3D 0;
-	if (bpf_prog->aux->exception_boundary || arena_vm_start)
+	if (bpf_prog->aux->exception_boundary || bpf_exc_force_spill(bpf_prog) =
||
+	    arena_vm_start)
 		callee_saved_size +=3D 8; /* r12 */
-	if (bpf_prog->aux->exception_boundary) {
+	if (bpf_prog->aux->exception_boundary || bpf_exc_force_spill(bpf_prog))=
 {
 		callee_saved_size +=3D 4 * 8; /* rbx, r13, r14, r15 */
 	} else {
 		int j;
@@ -2063,7 +2074,21 @@ static int do_jit(struct bpf_verifier_env *env, st=
ruct bpf_prog *bpf_prog, int *
 	 * Note that tail_call_reachable is guaranteed to be false when
 	 * stack args exist, so tcc pushes need not be accounted for.
 	 */
-	outgoing_arg_base =3D -(round_up(stack_depth, 8) + callee_saved_size);
+	outgoing_arg_base =3D -(round_up(stack_depth, 8) + throw_spill + callee=
_saved_size);
+
+	/*
+	 * Lowest address of each spill area, as an offset from rbp; see
+	 * bpf_cleanup_pad.S for the layout. The 16 is the tail call counter
+	 * pair emit_prologue_tail_call() pushes above the callee-saved one.
+	 * Only a frame that throws has a throw-site area.
+	 */
+	if (bpf_exc_force_spill(bpf_prog))
+		bpf_prog->aux->exc->spill_off =3D -(round_up(stack_depth, 8) + throw_s=
pill +
+						  (tail_call_reachable ? 16 : 0) +
+						  callee_saved_size);
+	if (bpf_exc_needs_throw_spill(bpf_prog))
+		bpf_prog->aux->exc->throw_spill_off =3D
+			-(round_up(stack_depth, 8) + throw_spill);
=20
 	/*
 	 * Allocate outgoing stack arg area for args 7+ only.
@@ -2110,7 +2135,8 @@ static int do_jit(struct bpf_verifier_env *env, str=
uct bpf_prog *bpf_prog, int *
 				dst_reg =3D X86_REG_R9;
 		}
=20
-		if (bpf_insn_is_indirect_target(env, bpf_prog, i - 1))
+		if (bpf_insn_is_indirect_target(env, bpf_prog, i - 1) ||
+		    bpf_exc_insn_is_pad(env, bpf_prog, i - 1))
 			EMIT_ENDBR();
=20
 		ip =3D image + addrs[i - 1] + (prog - temp);
@@ -2903,9 +2929,27 @@ static int do_jit(struct bpf_verifier_env *env, st=
ruct bpf_prog *bpf_prog, int *
 		case BPF_JMP | BPF_CALL: {
 			const struct btf_func_model *fm =3D NULL;
=20
+			if (bpf_exc_insn_is_throw(env, bpf_prog, i - 1)) {
+				/* Spill r6-r9 and r12 where the bpf_throw() walker looks. */
+				s32 off =3D bpf_prog->aux->exc->throw_spill_off;
+				u8 *spill =3D prog;
+
+				emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_9, off + 0);
+				emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_8, off + 8);
+				emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_7, off + 16);
+				emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, off + 24);
+				emit_stx(&prog, BPF_DW, BPF_REG_FP, X86_REG_R12, off + 32);
+				ip +=3D prog - spill;
+			}
+
+			if (bpf_exc_insn_is_resume(env, bpf_prog, i - 1)) {
+				emit_return(&prog, image + addrs[i - 1] + (prog - temp));
+				break;
+			}
+
 			func =3D (u8 *) __bpf_call_base + imm32;
 			if (src_reg =3D=3D BPF_PSEUDO_CALL && tail_call_reachable) {
-				LOAD_TAIL_CALL_CNT_PTR(stack_depth);
+				LOAD_TAIL_CALL_CNT_PTR(prologue_depth);
 				ip +=3D 7;
 			}
 			if (!imm32)
@@ -2948,13 +2992,13 @@ static int do_jit(struct bpf_verifier_env *env, s=
truct bpf_prog *bpf_prog, int *
 							  &prog,
 							  ip,
 							  callee_regs_used,
-							  stack_depth,
+							  prologue_depth,
 							  ctx);
 			else
 				emit_bpf_tail_call_indirect(bpf_prog,
 							    &prog,
 							    callee_regs_used,
-							    stack_depth,
+							    prologue_depth,
 							    ip,
 							    ctx);
 			break;
@@ -3215,7 +3259,8 @@ static int do_jit(struct bpf_verifier_env *env, str=
uct bpf_prog *bpf_prog, int *
 			}
 			/* Deallocate outgoing args 7+ area. */
 			emit_add_rsp(&prog, outgoing_rsp);
-			if (bpf_prog->aux->exception_boundary) {
+			if (bpf_prog->aux->exception_boundary ||
+			    bpf_exc_force_spill(bpf_prog)) {
 				pop_callee_regs(&prog, all_callee_regs_used);
 				pop_r12(&prog);
 			} else {
@@ -4385,6 +4430,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ve=
rifier_env *env, struct bpf_pr
 		 */
 		bpf_prog_update_insn_ptrs(prog, addrs, image);
=20
+		/*
+		 * Same mapping, consumed by the bpf_throw() frame walker:
+		 * turn the cleanup records into native address ranges now
+		 * that the image is final.
+		 */
+		bpf_exc_fill_native_ranges(prog, addrs, image);
+
 		/*
 		 * ctx.prog_offset is used when CFI preambles put code *before*
 		 * the function. See emit_cfi(). For FineIBT specifically this code
@@ -4501,6 +4553,11 @@ bool bpf_jit_supports_exceptions(void)
 	return IS_ENABLED(CONFIG_UNWINDER_ORC);
 }
=20
+bool bpf_jit_supports_cleanup_pads(void)
+{
+	return IS_ENABLED(CONFIG_UNWINDER_ORC);
+}
+
 bool bpf_jit_supports_private_stack(void)
 {
 	return true;
--=20
2.53.0-Meta

