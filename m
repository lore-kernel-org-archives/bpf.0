Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8663F313E3F
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775409997; cv=none; b=LMkDtKY/KCCnyq5kNWxzR7IFF2qWU82fRVyNCSZBRi9EJMWiJr+QgNDxTnkAWcuHmy/pL3Aw13I8BG56mhylKOXkJVZSvaLDv6T7+BxUEetdCRRaR4DUL7Qc6UDRSs3APqjyvwBCBOJ1uPdRC8haH+4D9dDKZvQ5/6RZZyuR80k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775409997; c=relaxed/simple;
	bh=86tBRR0jcpLrN3oCaRV5FSim1Y14OZ8Rqkqihr5WHpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6pz4nCVu+M4jBy30c61bnOiclabhD2snN9S5JMRqzAsMR6MXBTv/XIPsFjHeFomVN5YB2TLhrMW2RtUaEg6LzJ36iXNBlCoNQwUgPzVNWyYllofbw45UpwIt2g6gvUC5s/RMYoQkTiMiNW0hGSRfnsZeeSn9jrCK+ZuKLHVFzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id CDA42361E5E82; Sun,  5 Apr 2026 10:26:26 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 08/11] bpf,x86: Implement JIT support for stack arguments
Date: Sun,  5 Apr 2026 10:26:26 -0700
Message-ID: <20260405172626.1337674-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260405172505.1329392-1-yonghong.song@linux.dev>
References: <20260405172505.1329392-1-yonghong.song@linux.dev>
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
which the JIT translates to RBP-relative accesses in native code.

The JIT follows the native x86_64 calling convention for stack
argument placement. Incoming stack args from the caller sit above
the callee's frame pointer at [rbp + 16], [rbp + 24], etc., exactly
where x86_64 expects them after CALL + PUSH RBP. Only the outgoing
stack arg area is allocated below the program stack in the prologue.

The native x86_64 stack layout for a function with incoming and
outgoing stack args:

  high address
  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=90
  =E2=94=82 incoming stack arg N    =E2=94=82  [rbp + 16 + (N-1)*8]  (fro=
m caller)
  =E2=94=82 ...                     =E2=94=82
  =E2=94=82 incoming stack arg 1    =E2=94=82  [rbp + 16]
  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=A4
  =E2=94=82 return address          =E2=94=82  [rbp + 8]
  =E2=94=82 saved rbp               =E2=94=82  [rbp]
  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=A4
  =E2=94=82 BPF program stack       =E2=94=82  (stack_depth bytes)
  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=A4
  =E2=94=82 outgoing stack arg 1    =E2=94=82  [rbp - prog_stack_depth - =
outgoing_depth]
  =E2=94=82 ...                     =E2=94=82   (written via r12-relative=
 STX/ST)
  =E2=94=82 outgoing stack arg M    =E2=94=82  [rbp - prog_stack_depth - =
8]
  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=A4
  =E2=94=82 callee-saved regs ...   =E2=94=82  (pushed after sub rsp)
  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=98  rsp
  low address

BPF r12-relative offsets are translated to native RBP-relative
offsets with two formulas:
  - Incoming args (load: -off <=3D incoming_depth):
      native_off =3D 8 - bpf_off  =E2=86=92  [rbp + 16 + ...]
  - Outgoing args (store: -off > incoming_depth):
      native_off =3D -(bpf_prog_stack + stack_arg_depth + 8) - bpf_off

Since callee-saved registers are pushed below the outgoing area,
outgoing args are not at [rsp] at call time. Therefore, for both BPF-to-B=
PF
calls and kfunc calls, outgoing args are explicitly pushed from the
outgoing area onto the stack before CALL and rsp is restored after return=
.

For kfunc calls specifically, arg 6 is loaded into R9 and args 7+
are pushed onto the native stack, per the x86_64 calling convention.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 135 ++++++++++++++++++++++++++++++++++--
 1 file changed, 129 insertions(+), 6 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 32864dbc2c4e..206f342a0ca0 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -390,6 +390,28 @@ static void pop_callee_regs(u8 **pprog, bool *callee=
_regs_used)
 	*pprog =3D prog;
 }
=20
+/* Push stack args from [rbp + outgoing_base + (k - 1) * 8] in reverse o=
rder. */
+static int push_stack_args(u8 **pprog, s32 outgoing_base, int from, int =
to)
+{
+	u8 *prog =3D *pprog;
+	int k, bytes =3D 0;
+	s32 off;
+
+	for (k =3D from; k >=3D to; k--) {
+		off =3D outgoing_base + (k - 1) * 8;
+		/* push qword [rbp + off] */
+		if (is_imm8(off)) {
+			EMIT3(0xFF, 0x75, off);
+			bytes +=3D 3;
+		} else {
+			EMIT2_off32(0xFF, 0xB5, off);
+			bytes +=3D 6;
+		}
+	}
+	*pprog =3D prog;
+	return bytes;
+}
+
 static void emit_nops(u8 **pprog, int len)
 {
 	u8 *prog =3D *pprog;
@@ -1664,16 +1686,33 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
 	int i, excnt =3D 0;
 	int ilen, proglen =3D 0;
 	u8 *prog =3D temp;
-	u32 stack_depth;
+	u16 stack_arg_depth, incoming_stack_arg_depth, outgoing_stack_arg_depth=
;
+	u32 prog_stack_depth, stack_depth;
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
+	 * Save program stack depth before adding outgoing stack arg space.
+	 * Incoming stack args are read directly from [rbp + 16 + ...].
+	 * Only the outgoing stack arg area is allocated below the
+	 * program stack. Outgoing args written here become the callee's
+	 * incoming args.
+	 */
+	prog_stack_depth =3D round_up(stack_depth, 8);
+	if (outgoing_stack_arg_depth)
+		stack_depth +=3D outgoing_stack_arg_depth;
+	has_stack_args =3D stack_arg_depth > 0;
+
 	arena_vm_start =3D bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
 	user_vm_start =3D bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
=20
@@ -1715,13 +1754,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
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
@@ -1734,6 +1774,37 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
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
+		/*
+		 * Translate BPF r12-relative offset to native RBP-relative:
+		 *
+		 * Incoming args (load: offset >=3D -incoming_depth):
+		 *   BPF: r12 + bpf_off =3D r12 - k * 8 (k =3D 1,2,...) for incoming a=
rg k
+		 *   Native: [rbp + 8 + k * 8]
+		 *   Formula: native_off =3D 8 + k * 8 =3D 8 - bpf_off
+		 *
+		 * Outgoing args (store: offset < -incoming_depth):
+		 *   BPF: r12 + bpf_off =3D r12 - (incoming + k * 8) for outgoing arg =
k
+		 *   Native: [rbp - prog_stack_depth - outgoing + (k - 1) * 8]
+		 *   Formula: native_off =3D -(prog_stack_depth + outgoing) + (k - 1) =
* 8
+		 *          =3D -(prog_stack_depth + outgoing + incoming + 8) - bpf_of=
f
+		 *          =3D -(prog_stack_depth + stack_arg_depth + 8) - bpf_off
+		 */
+
 		switch (insn->code) {
 			/* ALU */
 		case BPF_ALU | BPF_ADD | BPF_X:
@@ -2131,10 +2202,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
 		case BPF_ST | BPF_MEM | BPF_DW:
 			EMIT2(add_1mod(0x48, dst_reg), 0xC7);
=20
-st:			if (is_imm8(insn->off))
-				EMIT2(add_1reg(0x40, dst_reg), insn->off);
+st:			insn_off =3D insn->off;
+			if (adjust_stack_arg_off)
+				insn_off =3D -(prog_stack_depth + stack_arg_depth + 8) - insn_off;
+			if (is_imm8(insn_off))
+				EMIT2(add_1reg(0x40, dst_reg), insn_off);
 			else
-				EMIT1_off32(add_1reg(0x80, dst_reg), insn->off);
+				EMIT1_off32(add_1reg(0x80, dst_reg), insn_off);
=20
 			EMIT(imm32, bpf_size_to_x86_bytes(BPF_SIZE(insn->code)));
 			break;
@@ -2144,7 +2218,10 @@ st:			if (is_imm8(insn->off))
 		case BPF_STX | BPF_MEM | BPF_H:
 		case BPF_STX | BPF_MEM | BPF_W:
 		case BPF_STX | BPF_MEM | BPF_DW:
-			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
+			insn_off =3D insn->off;
+			if (adjust_stack_arg_off)
+				insn_off =3D -(prog_stack_depth + stack_arg_depth + 8) - insn_off;
+			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
 			break;
=20
 		case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
@@ -2243,6 +2320,8 @@ st:			if (is_imm8(insn->off))
 		case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
 		case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
 			insn_off =3D insn->off;
+			if (adjust_stack_arg_off)
+				insn_off =3D 8 - insn_off;
=20
 			if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM ||
 			    BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEMSX) {
@@ -2441,6 +2520,7 @@ st:			if (is_imm8(insn->off))
 			/* call */
 		case BPF_JMP | BPF_CALL: {
 			u8 *ip =3D image + addrs[i - 1];
+			int stack_args =3D 0;
=20
 			func =3D (u8 *) __bpf_call_base + imm32;
 			if (src_reg =3D=3D BPF_PSEUDO_CALL && tail_call_reachable) {
@@ -2449,6 +2529,41 @@ st:			if (is_imm8(insn->off))
 			}
 			if (!imm32)
 				return -EINVAL;
+
+			if (src_reg =3D=3D BPF_PSEUDO_CALL && outgoing_stack_arg_depth > 0) {
+				/*
+				 * BPF-to-BPF calls: push outgoing stack args from
+				 * the outgoing area onto the stack before CALL.
+				 * The outgoing area is at [rbp - prog_stack - outgoing],
+				 * but rsp is below that due to callee-saved reg pushes,
+				 * so we must explicitly push args for the callee.
+				*/
+				s32 outgoing_base =3D -(prog_stack_depth + outgoing_stack_arg_depth)=
;
+				int n_args =3D outgoing_stack_arg_depth / 8;
+
+				ip +=3D push_stack_args(&prog, outgoing_base, n_args, 1);
+			}
+
+			if (src_reg !=3D BPF_PSEUDO_CALL && insn->off > 0) {
+				/* Kfunc calls: arg 6 =E2=86=92 R9, args 7+ =E2=86=92 push. */
+				s32 outgoing_base =3D -(prog_stack_depth + outgoing_stack_arg_depth)=
;
+				int kfunc_stack_args =3D insn->off;
+
+				stack_args =3D kfunc_stack_args > 1 ? kfunc_stack_args - 1 : 0;
+
+				/* Push args 7+ in reverse order */
+				if (stack_args > 0)
+					ip +=3D push_stack_args(&prog, outgoing_base, kfunc_stack_args, 2);
+
+				/* mov r9, [rbp + outgoing_base] (arg 6) */
+				if (is_imm8(outgoing_base)) {
+					EMIT4(0x4C, 0x8B, 0x4D, outgoing_base);
+					ip +=3D 4;
+				} else {
+					EMIT3_off32(0x4C, 0x8B, 0x8D, outgoing_base);
+					ip +=3D 7;
+				}
+			}
 			if (priv_frame_ptr) {
 				push_r9(&prog);
 				ip +=3D 2;
@@ -2458,6 +2573,14 @@ st:			if (is_imm8(insn->off))
 				return -EINVAL;
 			if (priv_frame_ptr)
 				pop_r9(&prog);
+			if (stack_args > 0) {
+				/* add rsp, stack_args * 8 */
+				EMIT4(0x48, 0x83, 0xC4, stack_args * 8);
+			}
+			if (src_reg =3D=3D BPF_PSEUDO_CALL && outgoing_stack_arg_depth > 0) {
+				/* add rsp, outgoing_stack_arg_depth */
+				EMIT4(0x48, 0x83, 0xC4, outgoing_stack_arg_depth);
+			}
 			break;
 		}
=20
--=20
2.52.0

