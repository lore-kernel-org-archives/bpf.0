Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6381A2D780E
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051022; cv=none; b=OfLzxrM8FRua7ic942pNFNG86pk7/YAQrbQtm554NpJMIC5NSFCrG0uaYy22wi+nfNLoTz7QTaO4D8BoOMjGKZLRm/rS/jPDocNglSnvvwTiYEl4ukCxUq6YU1beFk0/RqSMlFfJx+us7wR3sFSO7pBmHN3GjXZPD4Xg9fDH/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051022; c=relaxed/simple;
	bh=qi0hKP8jFECYnAeeKddXbyLFCB8wez5BNQOzbTlRcCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=htTcTleJs5FoaY+v8mSt81vAExYKwQtvsjPCsaMWr/rdqbTth8M/lPn84Gig8dkMq0ndx6+Wv7vu76eJLNzW9bE1+woQNj/RzFDui09l0TA7UdZol7zFkYnGJNyIsFSSSaA0LuEV/pQrVrTcP0JZd5BhuJIyYD8/1lgMMKyK7Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 426E6474A6717; Fri, 24 Apr 2026 10:16:48 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf-next 10/18] bpf,x86: Implement JIT support for stack arguments
Date: Fri, 24 Apr 2026 10:15:24 -0700
Message-ID: <20260424171648.2043493-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260424171433.2034470-1-yonghong.song@linux.dev>
References: <20260424171433.2034470-1-yonghong.song@linux.dev>
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
addressed by register r11 (BPF_REG_PARAMS) in BPF bytecode,
which the JIT translates to native code.

The JIT follows the x86-64 calling convention for both BPF-to-BPF
and kfunc calls:
  - Arg 6 is passed in the R9 register
  - Args 7+ are passed on the stack

Incoming arg 6 (BPF r11+8) is translated to a MOV from R9 rather
than a memory load. Incoming args 7+ (BPF r11+16, r11+24, ...) map
directly to [rbp + 16], [rbp + 24], ..., matching the x86-64 stack
layout after CALL + PUSH RBP, so no offset adjustment is needed.

The verifier guarantees that neither tail_call_reachable nor
priv_stack is set when stack args exist, so R9 is always
available. When BPF bytecode writes to the arg-6 stack slot
(offset -8), the JIT emits a MOV into R9 instead of a memory store.
Outgoing args 7+ are placed at [rsp] in a pre-allocated area below
callee-saved registers, using:
  native_off =3D outgoing_arg_base - outgoing_rsp - bpf_off - 16

The native x86_64 stack layout with stack arguments:

  high address
  +-------------------------+
  | incoming stack arg N    |  [rbp + 16 + (N-7)*8]  (from caller)
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

Acked-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 154 ++++++++++++++++++++++++++++++++++--
 1 file changed, 148 insertions(+), 6 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index ea9e707e8abf..06f33fef1e8e 100644
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
@@ -1664,16 +1692,45 @@ static int do_jit(struct bpf_verifier_env *env, s=
truct bpf_prog *bpf_prog, int *
 	int i, excnt =3D 0;
 	int ilen, proglen =3D 0;
 	u8 *ip, *prog =3D temp;
+	u16 stack_arg_depth, incoming_stack_arg_depth, outgoing_stack_arg_depth=
;
+	u16 outgoing_rsp;
 	u32 stack_depth;
+	int callee_saved_size;
+	s32 outgoing_arg_base;
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
+	 * Incoming arg 6 is read from R9 (BPF r11+8 =E2=86=92 MOV from R9).
+	 * Incoming args 7+ are read from [rbp + 16], [rbp + 24], ...
+	 * (BPF r11+16, r11+24, ... map directly with no offset change).
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
 	arena_vm_start =3D bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
 	user_vm_start =3D bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
=20
@@ -1700,6 +1757,42 @@ static int do_jit(struct bpf_verifier_env *env, st=
ruct bpf_prog *bpf_prog, int *
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
+	 * to native offsets. BPF uses negative offsets from r11
+	 * (r11-8 for arg6, r11-16 for arg7, ...) while x86 uses
+	 * positive offsets from rsp ([rsp+0] for arg7, [rsp+8] for
+	 * arg8, ...). Arg 6 goes to R9 directly.
+	 *
+	 * The translation reverses direction:
+	 *   native_off =3D outgoing_arg_base - outgoing_rsp - bpf_off - 16
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
@@ -1721,7 +1814,7 @@ static int do_jit(struct bpf_verifier_env *env, str=
uct bpf_prog *bpf_prog, int *
 		u8 b2 =3D 0, b3 =3D 0;
 		u8 *start_of_ldx;
 		s64 jmp_offset;
-		s16 insn_off;
+		s32 insn_off;
 		u8 jmp_cond;
 		u8 *func;
 		int nops;
@@ -2134,12 +2227,26 @@ static int do_jit(struct bpf_verifier_env *env, s=
truct bpf_prog *bpf_prog, int *
 				EMIT1(0xC7);
 			goto st;
 		case BPF_ST | BPF_MEM | BPF_DW:
+			if (dst_reg =3D=3D BPF_REG_PARAMS && insn->off =3D=3D -8) {
+				/* Arg 6: store immediate in r9 register */
+				emit_mov_imm64(&prog, X86_REG_R9, imm32 >> 31, (u32)imm32);
+				break;
+			}
 			EMIT2(add_1mod(0x48, dst_reg), 0xC7);
=20
-st:			if (is_imm8(insn->off))
-				EMIT2(add_1reg(0x40, dst_reg), insn->off);
+st:			insn_off =3D insn->off;
+			if (dst_reg =3D=3D BPF_REG_PARAMS) {
+				/* Args 7+: reverse BPF negative offsets to
+				 * x86 positive rsp offsets.
+				 * BPF off=3D-16 =E2=86=92 [rsp+0], off=3D-24 =E2=86=92 [rsp+8], ...
+				 */
+				insn_off =3D outgoing_arg_base - outgoing_rsp - insn_off - 16;
+				dst_reg =3D BPF_REG_FP;
+			}
+			if (is_imm8(insn_off))
+				EMIT2(add_1reg(0x40, dst_reg), insn_off);
 			else
-				EMIT1_off32(add_1reg(0x80, dst_reg), insn->off);
+				EMIT1_off32(add_1reg(0x80, dst_reg), insn_off);
=20
 			EMIT(imm32, bpf_size_to_x86_bytes(BPF_SIZE(insn->code)));
 			break;
@@ -2149,7 +2256,17 @@ st:			if (is_imm8(insn->off))
 		case BPF_STX | BPF_MEM | BPF_H:
 		case BPF_STX | BPF_MEM | BPF_W:
 		case BPF_STX | BPF_MEM | BPF_DW:
-			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
+			if (dst_reg =3D=3D BPF_REG_PARAMS && insn->off =3D=3D -8) {
+				/* Arg 6: store register value in r9 */
+				EMIT_mov(X86_REG_R9, src_reg);
+				break;
+			}
+			insn_off =3D insn->off;
+			if (dst_reg =3D=3D BPF_REG_PARAMS) {
+				insn_off =3D outgoing_arg_base - outgoing_rsp - insn_off - 16;
+				dst_reg =3D BPF_REG_FP;
+			}
+			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
 			break;
=20
 		case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
@@ -2248,6 +2365,19 @@ st:			if (is_imm8(insn->off))
 		case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
 		case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
 			insn_off =3D insn->off;
+			if (src_reg =3D=3D BPF_REG_PARAMS) {
+				if (insn_off =3D=3D 8) {
+					/* Incoming arg 6: read from r9 */
+					EMIT_mov(dst_reg, X86_REG_R9);
+					break;
+				}
+				src_reg =3D BPF_REG_FP;
+				/*
+				 * Incoming args 7+: native_off =3D=3D bpf_off
+				 * (r11+16 =E2=86=92 [rbp+16], r11+24 =E2=86=92 [rbp+24], ...)
+				 * No offset adjustment needed.
+				 */
+			}
=20
 			if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM ||
 			    BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEMSX) {
@@ -2736,6 +2866,8 @@ st:			if (is_imm8(insn->off))
 				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
 					return -EINVAL;
 			}
+			/* Deallocate outgoing args 7+ area. */
+			emit_add_rsp(&prog, outgoing_rsp);
 			if (bpf_prog->aux->exception_boundary) {
 				pop_callee_regs(&prog, all_callee_regs_used);
 				pop_r12(&prog);
@@ -3743,7 +3875,12 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ve=
rifier_env *env, struct bpf_pr
 		prog->aux->jit_data =3D jit_data;
 	}
 	priv_stack_ptr =3D prog->aux->priv_stack_ptr;
-	if (!priv_stack_ptr && prog->aux->jits_use_priv_stack) {
+	/*
+	 * x86-64 uses R9 for both private stack frame pointer and arg 6,
+	 * so disable private stack when stack args are present.
+	 */
+	if (!priv_stack_ptr && prog->aux->jits_use_priv_stack &&
+	    prog->aux->stack_arg_depth =3D=3D 0) {
 		/* Allocate actual private stack size with verifier-calculated
 		 * stack size plus two memory guards to protect overflow and
 		 * underflow.
@@ -3910,6 +4047,11 @@ bool bpf_jit_supports_kfunc_call(void)
 	return true;
 }
=20
+bool bpf_jit_supports_stack_args(void)
+{
+	return true;
+}
+
 void *bpf_arch_text_copy(void *dst, void *src, size_t len)
 {
 	if (text_poke_copy(dst, src, len) =3D=3D NULL)
--=20
2.52.0

