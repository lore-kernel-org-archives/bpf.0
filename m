Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3951DDA24
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 01:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775093294; cv=none; b=r7+jBFSgS6Uh+dI/l1KTnoi14N0wgznQEodg2zEcbxKO8+WvxFBzrxh/DiokszrRe6YxPWXGLkJVVc+ZG+sTjiKF+QYCqOTRCIBYjGftc90twwDzdrxcAQbG8VsbtZSZLtoCh8pztINccR76DKW64wJoyaPWBKXDJAkFu+vC4p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775093294; c=relaxed/simple;
	bh=CubN+baczASZaD7FLx7QLPSuu7W1qQ/6pTIj4cBkvN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qWLhspOew8Eb/fu6usAISqISvhX1dvooP2iD8w1rovtXa3Q8X65L6vjMO2y3rqyv8VKTl+ZK2pTd87arEazzzd+9GN4cyE8wXUjD+AEDn3C7nQYOczv6stHNSaGOc59NEM4Ji4FWP8XbXU6MsdltaJuJpXWYZVV0hi6LGTVbWvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 5CA263328051F; Wed,  1 Apr 2026 18:28:03 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 07/10] bpf,x86: Implement JIT support for stack arguments
Date: Wed,  1 Apr 2026 18:28:03 -0700
Message-ID: <20260402012803.3920450-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402012727.3916819-1-yonghong.song@linux.dev>
References: <20260402012727.3916819-1-yonghong.song@linux.dev>
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

There are two possible approaches to allocate the stack arg area:

  Option 1: Allocate a single combined region (incoming + max_outgoing)
    below the program stack in the function prologue. All r12-relative
    accesses become [rbp - prog_stack_depth - offset] where the 'offset'
    is the offset value in (incoming + max_outgoing) region. This is
    simple because the area is always at a fixed offset from RBP.
    The tradeoff is slightly higher stack usage when multiple callees
    have different stack arg counts =E2=80=94 the area is sized to the ma=
ximum.

  Option 2: Allocate each outgoing area individually at the call
    site, sized exactly to the callee's needs. This minimizes
    stack usage but significantly complicates the JIT: each call
    site must dynamically adjust RSP, and addresses of stack args
    would shift depending on context, making the offset
    calculations harder.

This patch uses Option 1 for simplicity.

The native x86_64 stack layout for a function with incoming and
outgoing stack args:

  high address
  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=90
  =E2=94=82 incoming stack arg N    =E2=94=82  [rbp + 16 + (N - 1) * 8]  =
(pushed by caller)
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
  =E2=94=82 callee-saved regs       =E2=94=82
  =E2=94=82 BPF program stack       =E2=94=82  (stack_depth bytes)
  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=A4
  =E2=94=82 incoming stack arg 1    =E2=94=82  [rbp - prog_stack_depth - =
8]
  =E2=94=82 ...   (copied from      =E2=94=82   (copied in prologue)
  =E2=94=82        caller's push)   =E2=94=82
  =E2=94=82 incoming stack arg N    =E2=94=82  [rbp - prog_stack_depth - =
N * 8]
  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=A4
  =E2=94=82 outgoing stack arg 1    =E2=94=82  (written via r12-relative =
STX/ST,
  =E2=94=82 ...                     =E2=94=82   JIT translates to RBP-rel=
ative)
  =E2=94=82 outgoing stack arg M    =E2=94=82
  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=98
    ...                        Other stack usage
  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=90
  =E2=94=82 incoming stack arg M    =E2=94=82 (copy from outgoing stack a=
rg to
  =E2=94=82 ...                     =E2=94=82  incoming stack arg)
  =E2=94=82 incoming stack arg 1    =E2=94=82
  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=A4
  =E2=94=82 return address          =E2=94=82
  =E2=94=82 saved rbp               =E2=94=82
  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=A4
  =E2=94=82 ...                     =E2=94=82
  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=98
  low address

In prologue, the caller's incoming stack arguments are copied to callee's
incoming stack arguments, which will be fetched by later load insns.
The outgoing stack arguments are written by JIT RBP-relative STX or ST.

For each bpf-to-bpf call, push outgoing stack args onto the native
stack before CALL, pop them after return. So the same 'outgoing stack arg=
'
area is used by all bpf-to-bpf functions.

For kfunc calls, push stack args (arg 7+) onto the native stack
and load arg 6 into R9 per the x86_64 calling convention,
then clean up RSP after return.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 145 ++++++++++++++++++++++++++++++++++--
 1 file changed, 138 insertions(+), 7 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 32864dbc2c4e..807493f109e5 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -367,6 +367,27 @@ static void push_callee_regs(u8 **pprog, bool *calle=
e_regs_used)
 	*pprog =3D prog;
 }
=20
+static int push_stack_args(u8 **pprog, s32 base_off, int from, int to)
+{
+	u8 *prog =3D *pprog;
+	int j, off, cnt =3D 0;
+
+	for (j =3D from; j >=3D to; j--) {
+		off =3D base_off - j * 8;
+
+		/* push qword [rbp + off] */
+		if (is_imm8(off)) {
+			EMIT3(0xFF, 0x75, off);
+			cnt +=3D 3;
+		} else {
+			EMIT2_off32(0xFF, 0xB5, off);
+			cnt +=3D 6;
+		}
+	}
+	*pprog =3D prog;
+	return cnt;
+}
+
 static void pop_r12(u8 **pprog)
 {
 	u8 *prog =3D *pprog;
@@ -1664,19 +1685,35 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
 	int i, excnt =3D 0;
 	int ilen, proglen =3D 0;
 	u8 *prog =3D temp;
-	u32 stack_depth;
+	u16 stack_arg_depth, incoming_stack_arg_depth;
+	u32 prog_stack_depth, stack_depth;
+	bool has_stack_args;
 	int err;
=20
 	stack_depth =3D bpf_prog->aux->stack_depth;
+	stack_arg_depth =3D bpf_prog->aux->stack_arg_depth;
+	incoming_stack_arg_depth =3D bpf_prog->aux->incoming_stack_arg_depth;
 	priv_stack_ptr =3D bpf_prog->aux->priv_stack_ptr;
 	if (priv_stack_ptr) {
 		priv_frame_ptr =3D priv_stack_ptr + PRIV_STACK_GUARD_SZ + round_up(sta=
ck_depth, 8);
 		stack_depth =3D 0;
 	}
=20
+	/*
+	 * Save program stack depth before adding stack arg space.
+	 * Each function allocates its own stack arg space
+	 * (incoming + outgoing) below its BPF stack.
+	 * Stack args are accessed via RBP-based addressing.
+	 */
+	prog_stack_depth =3D round_up(stack_depth, 8);
+	if (stack_arg_depth)
+		stack_depth +=3D stack_arg_depth;
+	has_stack_args =3D stack_arg_depth > 0;
+
 	arena_vm_start =3D bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
 	user_vm_start =3D bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
=20
+
 	detect_reg_usage(insn, insn_cnt, callee_regs_used);
=20
 	emit_prologue(&prog, image, stack_depth,
@@ -1704,6 +1741,38 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
 		emit_mov_imm64(&prog, X86_REG_R12,
 			       arena_vm_start >> 32, (u32) arena_vm_start);
=20
+	if (incoming_stack_arg_depth && bpf_is_subprog(bpf_prog)) {
+		int n =3D incoming_stack_arg_depth / 8;
+
+		/*
+		 * Caller pushed stack args before CALL, so after prologue
+		 * (CALL saves ret addr, then PUSH saves old RBP) they sit
+		 * above RBP:
+		 *
+		 *   [rbp + 16 + (n - 1) * 8]  stack_arg n
+		 *   ...
+		 *   [rbp + 24]                stack_arg 2
+		 *   [rbp + 16]                stack_arg 1
+		 *   [rbp +  8]                return address
+		 *   [rbp +  0]                saved rbp
+		 *
+		 * Copy each into callee's own region below the program stack:
+		 *   [rbp - prog_stack_depth - i * 8]
+		 */
+		for (i =3D 0; i < n; i++) {
+			s32 src =3D 16 + i * 8;
+			s32 dst =3D -prog_stack_depth - (i + 1) * 8;
+
+			/* mov rax, [rbp + src] */
+			EMIT4(0x48, 0x8B, 0x45, src);
+			/* mov [rbp + dst], rax */
+			if (is_imm8(dst))
+				EMIT4(0x48, 0x89, 0x45, dst);
+			else
+				EMIT3_off32(0x48, 0x89, 0x85, dst);
+		}
+	}
+
 	if (priv_frame_ptr)
 		emit_priv_frame_ptr(&prog, priv_frame_ptr);
=20
@@ -1715,13 +1784,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
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
@@ -1734,6 +1804,21 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
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
@@ -2131,10 +2216,16 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
 		case BPF_ST | BPF_MEM | BPF_DW:
 			EMIT2(add_1mod(0x48, dst_reg), 0xC7);
=20
-st:			if (is_imm8(insn->off))
-				EMIT2(add_1reg(0x40, dst_reg), insn->off);
+st:		{
+			int off =3D insn->off;
+
+			if (adjust_stack_arg_off)
+				off -=3D prog_stack_depth;
+			if (is_imm8(off))
+				EMIT2(add_1reg(0x40, dst_reg), off);
 			else
-				EMIT1_off32(add_1reg(0x80, dst_reg), insn->off);
+				EMIT1_off32(add_1reg(0x80, dst_reg), off);
+		}
=20
 			EMIT(imm32, bpf_size_to_x86_bytes(BPF_SIZE(insn->code)));
 			break;
@@ -2143,9 +2234,14 @@ st:			if (is_imm8(insn->off))
 		case BPF_STX | BPF_MEM | BPF_B:
 		case BPF_STX | BPF_MEM | BPF_H:
 		case BPF_STX | BPF_MEM | BPF_W:
-		case BPF_STX | BPF_MEM | BPF_DW:
-			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
+		case BPF_STX | BPF_MEM | BPF_DW: {
+			int off =3D insn->off;
+
+			if (adjust_stack_arg_off)
+				off -=3D prog_stack_depth;
+			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, off);
 			break;
+		}
=20
 		case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
 		case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
@@ -2243,6 +2339,8 @@ st:			if (is_imm8(insn->off))
 		case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
 		case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
 			insn_off =3D insn->off;
+			if (adjust_stack_arg_off)
+				insn_off -=3D prog_stack_depth;
=20
 			if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM ||
 			    BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEMSX) {
@@ -2440,6 +2538,8 @@ st:			if (is_imm8(insn->off))
=20
 			/* call */
 		case BPF_JMP | BPF_CALL: {
+			int off, base_off, n_stack_args, kfunc_stack_args =3D 0, stack_args =3D=
 0;
+			u16 outgoing_stack_args =3D stack_arg_depth - incoming_stack_arg_dept=
h;
 			u8 *ip =3D image + addrs[i - 1];
=20
 			func =3D (u8 *) __bpf_call_base + imm32;
@@ -2449,6 +2549,29 @@ st:			if (is_imm8(insn->off))
 			}
 			if (!imm32)
 				return -EINVAL;
+
+			if (src_reg =3D=3D BPF_PSEUDO_CALL && outgoing_stack_args > 0) {
+				n_stack_args =3D outgoing_stack_args / 8;
+				base_off =3D -(prog_stack_depth + incoming_stack_arg_depth);
+				ip +=3D push_stack_args(&prog, base_off, n_stack_args, 1);
+			}
+
+			if (src_reg !=3D BPF_PSEUDO_CALL && insn->off > 0) {
+				kfunc_stack_args =3D insn->off;
+				stack_args =3D kfunc_stack_args > 1 ? kfunc_stack_args - 1 : 0;
+				base_off =3D -(prog_stack_depth + incoming_stack_arg_depth);
+				ip +=3D push_stack_args(&prog, base_off, kfunc_stack_args, 2);
+
+				/* mov r9, [rbp + base_off - 8] */
+				off =3D base_off - 8;
+				if (is_imm8(off)) {
+					EMIT4(0x4C, 0x8B, 0x4D, off);
+					ip +=3D 4;
+				} else {
+					EMIT3_off32(0x4C, 0x8B, 0x8D, off);
+					ip +=3D 7;
+				}
+			}
 			if (priv_frame_ptr) {
 				push_r9(&prog);
 				ip +=3D 2;
@@ -2458,6 +2581,14 @@ st:			if (is_imm8(insn->off))
 				return -EINVAL;
 			if (priv_frame_ptr)
 				pop_r9(&prog);
+			if (stack_args > 0) {
+				/* add rsp, stack_args * 8 */
+				EMIT4(0x48, 0x83, 0xC4, stack_args * 8);
+			}
+			if (src_reg =3D=3D BPF_PSEUDO_CALL && outgoing_stack_args > 0) {
+				/* add rsp, outgoing_stack_args */
+				EMIT4(0x48, 0x83, 0xC4, outgoing_stack_args);
+			}
 			break;
 		}
=20
--=20
2.52.0

