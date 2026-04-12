Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C43A364927
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 05:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775970036; cv=none; b=dVBJixBTBOhM7kuKs9nSPWa1/Qbo4xMwiTYJ33wsHS26N1NEVz0m1T4HMLUarOwRblSHOcwU3zBfvCnEreZ4oNj2oUztgnS86WhvIgo3bhaA3Gplb4eR+0rDTNA4cWoT0fiZ/pUs+0XIHAPKkawtV6VFTfC+HWVXPEaUraIn2nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775970036; c=relaxed/simple;
	bh=VIJ+9iyobLDhEzYqb0dqp/TgOFKkiZKbBe5F2Gul0F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOAjcSXbUKLm9QvWCj6o897ZgOatOYMxJf5aaFSZCfO8hwSO7LTS8DPSoFH5twFoWlOPRYB+NkC7IUNwUL2ir2LyDKZM+uZWFiAmMzasoc0IGQsweo8F/+zy+Jba5Up7jeOVIpxkqQBtQjflEz366Y2+ymJdC7KK9Whr7RzFjJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id A63083B021C95; Sat, 11 Apr 2026 22:00:33 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 15/18] bpf,x86: Implement JIT support for stack arguments
Date: Sat, 11 Apr 2026 22:00:26 -0700
Message-ID: <20260412050033.267815-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260412045826.254200-1-yonghong.song@linux.dev>
References: <20260412045826.254200-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Add x86_64 JIT support for BPF functions and kfuncs with more than
5 arguments. The extra arguments are passed through a stack area
addressed by register r12 (BPF_REG_STACK_ARG_BASE) in BPF bytecode,
which the JIT translates to native code.

The JIT follows the x86-64 calling convention for both BPF-to-BPF
and kfunc calls:
  - Arg 6 is passed in the R9 register
  - Args 7+ are passed on the stack

Incoming arg 6 (BPF r12+8) is translated to a MOV from R9 rather
than a memory load. Incoming args 7+ (BPF r12+16, r12+24, ...) map
directly to [rbp + 16], [rbp + 24], ..., matching the x86-64 stack
layout after CALL + PUSH RBP, so no offset adjustment is needed.

The verifier guarantees that neither tail_call_reachable nor
priv_stack is set when outgoing stack args exist, so R9 is always
available. When BPF bytecode writes to the arg-6 stack slot
(the most negative outgoing offset), the JIT emits a MOV into R9
instead of a memory store. Outgoing args 7+ are placed at [rsp]
in a pre-allocated area below callee-saved registers, using:
  native_off =3D outgoing_arg_base + bpf_off

The native x86_64 stack layout:

  high address
  +-------------------------+
  | incoming stack arg N    |  [rbp + 16 + (N-2)*8]  (from caller)
  | ...                     |
  | incoming stack arg 7    |  [rbp + 16]
  +-------------------------+
  | return address          |  [rbp + 8]
  | saved rbp               |  [rbp]
  +-------------------------+
  | BPF program stack       |  (round_up(stack_depth, 8) bytes)
  +-------------------------+
  | callee-saved regs       |  (r12, rbx, r13, r14, r15 as needed)
  +-------------------------+
  | outgoing arg M          |  [rsp + (M-7)*8]
  | ...                     |
  | outgoing arg 7          |  [rsp]
  +-------------------------+  rsp
  low address

  (Arg 6 is in R9, not on the stack)

  [1] https://github.com/llvm/llvm-project/pull/189060

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 172 ++++++++++++++++++++++++++++++++++--
 1 file changed, 164 insertions(+), 8 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 32864dbc2c4e..ec57b9a6b417 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -390,6 +390,34 @@ static void pop_callee_regs(u8 **pprog, bool *callee=
_regs_used)
 	*pprog =3D prog;
 }
=20
+/* add rsp, depth */
+static void emit_add_rsp(u8 **pprog, u16 depth)
+{
+	u8 *prog =3D *pprog;
+
+	if (!depth)
+		return;
+	if (is_imm8(depth))
+		EMIT4(0x48, 0x83, 0xC4, depth); /* add rsp, imm8 */
+	else
+		EMIT3_off32(0x48, 0x81, 0xC4, depth); /* add rsp, imm32 */
+	*pprog =3D prog;
+}
+
+/* sub rsp, depth */
+static void emit_sub_rsp(u8 **pprog, u16 depth)
+{
+	u8 *prog =3D *pprog;
+
+	if (!depth)
+		return;
+	if (is_imm8(depth))
+		EMIT4(0x48, 0x83, 0xEC, depth); /* sub rsp, imm8 */
+	else
+		EMIT3_off32(0x48, 0x81, 0xEC, depth); /* sub rsp, imm32 */
+	*pprog =3D prog;
+}
+
 static void emit_nops(u8 **pprog, int len)
 {
 	u8 *prog =3D *pprog;
@@ -725,8 +753,8 @@ static void emit_return(u8 **pprog, u8 *ip)
  */
 static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 					u8 **pprog, bool *callee_regs_used,
-					u32 stack_depth, u8 *ip,
-					struct jit_context *ctx)
+					u32 stack_depth, u16 outgoing_depth,
+					u8 *ip, struct jit_context *ctx)
 {
 	int tcc_ptr_off =3D BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack_depth);
 	u8 *prog =3D *pprog, *start =3D *pprog;
@@ -775,6 +803,9 @@ static void emit_bpf_tail_call_indirect(struct bpf_pr=
og *bpf_prog,
 	/* Inc tail_call_cnt if the slot is populated. */
 	EMIT4(0x48, 0x83, 0x00, 0x01);            /* add qword ptr [rax], 1 */
=20
+	/* Deallocate outgoing stack arg area. */
+	emit_add_rsp(&prog, outgoing_depth);
+
 	if (bpf_prog->aux->exception_boundary) {
 		pop_callee_regs(&prog, all_callee_regs_used);
 		pop_r12(&prog);
@@ -815,6 +846,7 @@ static void emit_bpf_tail_call_direct(struct bpf_prog=
 *bpf_prog,
 				      struct bpf_jit_poke_descriptor *poke,
 				      u8 **pprog, u8 *ip,
 				      bool *callee_regs_used, u32 stack_depth,
+				      u16 outgoing_depth,
 				      struct jit_context *ctx)
 {
 	int tcc_ptr_off =3D BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack_depth);
@@ -842,6 +874,9 @@ static void emit_bpf_tail_call_direct(struct bpf_prog=
 *bpf_prog,
 	/* Inc tail_call_cnt if the slot is populated. */
 	EMIT4(0x48, 0x83, 0x00, 0x01);                /* add qword ptr [rax], 1=
 */
=20
+	/* Deallocate outgoing stack arg area. */
+	emit_add_rsp(&prog, outgoing_depth);
+
 	if (bpf_prog->aux->exception_boundary) {
 		pop_callee_regs(&prog, all_callee_regs_used);
 		pop_r12(&prog);
@@ -1664,16 +1699,48 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
 	int i, excnt =3D 0;
 	int ilen, proglen =3D 0;
 	u8 *prog =3D temp;
+	u16 stack_arg_depth, incoming_stack_arg_depth, outgoing_stack_arg_depth=
;
+	u16 outgoing_rsp;
 	u32 stack_depth;
+	int callee_saved_size;
+	s32 outgoing_arg_base;
+	bool has_stack_args;
 	int err;
=20
 	stack_depth =3D bpf_prog->aux->stack_depth;
+	stack_arg_depth =3D bpf_prog->aux->stack_arg_depth;
+	incoming_stack_arg_depth =3D bpf_prog->aux->incoming_stack_arg_depth;
+	outgoing_stack_arg_depth =3D stack_arg_depth - incoming_stack_arg_depth=
;
 	priv_stack_ptr =3D bpf_prog->aux->priv_stack_ptr;
 	if (priv_stack_ptr) {
 		priv_frame_ptr =3D priv_stack_ptr + PRIV_STACK_GUARD_SZ + round_up(sta=
ck_depth, 8);
 		stack_depth =3D 0;
 	}
=20
+	/*
+	 * Follow x86-64 calling convention for both BPF-to-BPF and
+	 * kfunc calls:
+	 *   - Arg 6 is passed in R9 register
+	 *   - Args 7+ are passed on the stack at [rsp]
+	 *
+	 * Incoming arg 6 is read from R9 (BPF r12+8 =E2=86=92 MOV from R9).
+	 * Incoming args 7+ are read from [rbp + 16], [rbp + 24], ...
+	 * (BPF r12+16, r12+24, ... map directly with no offset change).
+	 *
+	 * The verifier guarantees that neither tail_call_reachable nor
+	 * priv_stack is set when outgoing stack args exist, so R9 is
+	 * always available.
+	 *
+	 * Stack layout (high to low):
+	 *   [rbp + 16 + ...]    incoming stack args 7+ (from caller)
+	 *   [rbp + 8]           return address
+	 *   [rbp]               saved rbp
+	 *   [rbp - prog_stack]  program stack
+	 *   [below]             callee-saved regs
+	 *   [below]             outgoing args 7+ (=3D rsp)
+	 */
+	has_stack_args =3D stack_arg_depth > 0;
+
 	arena_vm_start =3D bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
 	user_vm_start =3D bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
=20
@@ -1700,6 +1767,41 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
 			push_r12(&prog);
 		push_callee_regs(&prog, callee_regs_used);
 	}
+
+	/* Compute callee-saved register area size. */
+	callee_saved_size =3D 0;
+	if (bpf_prog->aux->exception_boundary || arena_vm_start)
+		callee_saved_size +=3D 8; /* r12 */
+	if (bpf_prog->aux->exception_boundary) {
+		callee_saved_size +=3D 4 * 8; /* rbx, r13, r14, r15 */
+	} else {
+		int j;
+
+		for (j =3D 0; j < 4; j++)
+			if (callee_regs_used[j])
+				callee_saved_size +=3D 8;
+	}
+	/*
+	 * Base offset from rbp for translating BPF outgoing args 7+
+	 * to native offsets:
+	 *   native_off =3D outgoing_arg_base + bpf_off
+	 *
+	 * BPF outgoing offsets are negative (r12 - N*8 for arg6,
+	 * ..., r12 - 8 for last arg). Arg 6 goes to R9 directly,
+	 * so only args 7+ occupy the outgoing stack area.
+	 *
+	 * Note that tail_call_reachable is guaranteed to be false when
+	 * stack args exist, so tcc pushes need not be accounted for.
+	 */
+	outgoing_arg_base =3D -(round_up(stack_depth, 8) + callee_saved_size);
+
+	/*
+	 * Allocate outgoing stack arg area for args 7+ only.
+	 * Arg 6 goes into r9 register, not on stack.
+	 */
+	outgoing_rsp =3D outgoing_stack_arg_depth > 8 ?  outgoing_stack_arg_dep=
th - 8 : 0;
+	emit_sub_rsp(&prog, outgoing_rsp);
+
 	if (arena_vm_start)
 		emit_mov_imm64(&prog, X86_REG_R12,
 			       arena_vm_start >> 32, (u32) arena_vm_start);
@@ -1715,13 +1817,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
 	prog =3D temp;
=20
 	for (i =3D 1; i <=3D insn_cnt; i++, insn++) {
+		bool adjust_stack_arg_off =3D false;
 		const s32 imm32 =3D insn->imm;
 		u32 dst_reg =3D insn->dst_reg;
 		u32 src_reg =3D insn->src_reg;
 		u8 b2 =3D 0, b3 =3D 0;
 		u8 *start_of_ldx;
 		s64 jmp_offset;
-		s16 insn_off;
+		s32 insn_off;
 		u8 jmp_cond;
 		u8 *func;
 		int nops;
@@ -1734,6 +1837,21 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
 				dst_reg =3D X86_REG_R9;
 		}
=20
+		if (has_stack_args) {
+			u8 class =3D BPF_CLASS(insn->code);
+
+			if (class =3D=3D BPF_LDX &&
+			    src_reg =3D=3D BPF_REG_STACK_ARG_BASE) {
+				src_reg =3D BPF_REG_FP;
+				adjust_stack_arg_off =3D true;
+			}
+			if ((class =3D=3D BPF_STX || class =3D=3D BPF_ST) &&
+			    dst_reg =3D=3D BPF_REG_STACK_ARG_BASE) {
+				dst_reg =3D BPF_REG_FP;
+				adjust_stack_arg_off =3D true;
+			}
+		}
+
 		switch (insn->code) {
 			/* ALU */
 		case BPF_ALU | BPF_ADD | BPF_X:
@@ -2129,12 +2247,20 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
 				EMIT1(0xC7);
 			goto st;
 		case BPF_ST | BPF_MEM | BPF_DW:
+			if (adjust_stack_arg_off && insn->off =3D=3D -outgoing_stack_arg_dept=
h) {
+				/* Arg 6: store immediate in r9 register */
+				emit_mov_imm64(&prog, X86_REG_R9, imm32 >> 31, (u32)imm32);
+				break;
+			}
 			EMIT2(add_1mod(0x48, dst_reg), 0xC7);
=20
-st:			if (is_imm8(insn->off))
-				EMIT2(add_1reg(0x40, dst_reg), insn->off);
+st:			insn_off =3D insn->off;
+			if (adjust_stack_arg_off)
+				insn_off =3D outgoing_arg_base + insn_off;
+			if (is_imm8(insn_off))
+				EMIT2(add_1reg(0x40, dst_reg), insn_off);
 			else
-				EMIT1_off32(add_1reg(0x80, dst_reg), insn->off);
+				EMIT1_off32(add_1reg(0x80, dst_reg), insn_off);
=20
 			EMIT(imm32, bpf_size_to_x86_bytes(BPF_SIZE(insn->code)));
 			break;
@@ -2144,7 +2270,15 @@ st:			if (is_imm8(insn->off))
 		case BPF_STX | BPF_MEM | BPF_H:
 		case BPF_STX | BPF_MEM | BPF_W:
 		case BPF_STX | BPF_MEM | BPF_DW:
-			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
+			if (adjust_stack_arg_off && insn->off =3D=3D -outgoing_stack_arg_dept=
h) {
+				/* Arg 6: store register value in r9 */
+				EMIT_mov(X86_REG_R9, src_reg);
+				break;
+			}
+			insn_off =3D insn->off;
+			if (adjust_stack_arg_off)
+				insn_off =3D outgoing_arg_base + insn_off;
+			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
 			break;
=20
 		case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
@@ -2243,6 +2377,18 @@ st:			if (is_imm8(insn->off))
 		case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
 		case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
 			insn_off =3D insn->off;
+			if (adjust_stack_arg_off) {
+				if (insn_off =3D=3D 8) {
+					/* Incoming arg 6: read from r9 */
+					EMIT_mov(dst_reg, X86_REG_R9);
+					break;
+				}
+				/*
+				 * Incoming args 7+: native_off =3D=3D bpf_off
+				 * (r12+16 =E2=86=92 [rbp+16], r12+24 =E2=86=92 [rbp+24], ...)
+				 * No offset adjustment needed.
+				 */
+			}
=20
 			if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM ||
 			    BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEMSX) {
@@ -2468,12 +2614,14 @@ st:			if (is_imm8(insn->off))
 							  &prog, image + addrs[i - 1],
 							  callee_regs_used,
 							  stack_depth,
+							  outgoing_rsp,
 							  ctx);
 			else
 				emit_bpf_tail_call_indirect(bpf_prog,
 							    &prog,
 							    callee_regs_used,
 							    stack_depth,
+							    outgoing_rsp,
 							    image + addrs[i - 1],
 							    ctx);
 			break;
@@ -2734,6 +2882,8 @@ st:			if (is_imm8(insn->off))
 				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
 					return -EINVAL;
 			}
+			/* Deallocate outgoing args 7+ area. */
+			emit_add_rsp(&prog, outgoing_rsp);
 			if (bpf_prog->aux->exception_boundary) {
 				pop_callee_regs(&prog, all_callee_regs_used);
 				pop_r12(&prog);
@@ -3757,7 +3907,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pr=
og *prog)
 		prog->aux->jit_data =3D jit_data;
 	}
 	priv_stack_ptr =3D prog->aux->priv_stack_ptr;
-	if (!priv_stack_ptr && prog->aux->jits_use_priv_stack) {
+	/*
+	 * x86-64 uses R9 for both private stack frame pointer and
+	 * outgoing arg 6, so disable private stack when outgoing
+	 * stack args are present.
+	 */
+	if (!priv_stack_ptr && prog->aux->jits_use_priv_stack &&
+	    prog->aux->stack_arg_depth =3D=3D prog->aux->incoming_stack_arg_dep=
th) {
 		/* Allocate actual private stack size with verifier-calculated
 		 * stack size plus two memory guards to protect overflow and
 		 * underflow.
--=20
2.52.0

