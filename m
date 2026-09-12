Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3AB38F95B
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 19:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789242784; cv=none; b=u9uR9XphzULqITMTyFcR79QOXEUPMLvFgrZWCmr7uI2SG9LEDDi6HvlqiMaFOEbVjjPVMNnkRrH9fl40HhFm79ALSLXxmdSB4xhmw9zOeCwzMEcVJZ7+76BNZ5Y4YcvQw6OVOKISJfJi2JkT6PvOln7izH5/16N5JLWtR2aN9DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789242784; c=relaxed/simple;
	bh=JtGE/lc9iEJMxKdz46h3GgmEPGkvUmxiTgX1dM2TVzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RR3zTMlJzL+Ezw18hxOUU5qCXpxkQy8AkeqIsj7xdSX//P/jNeIAIoSedUc5hgzWL6+/TSWpyoTxkq2Nlcno4leI7Gws9Sbm6tKiLqQ2+iXIUeNULiZRwRqhfMQflnt7PbkGCEkcf2IqwuDfx3hPZGDWwwJnIj9pdUoRd9fnsmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id A55FC2A58A0DBB; Sat, 12 Sep 2026 12:52:52 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 11/15] bpf, arm64: Place trampoline arguments by the arm64 calling convention
Date: Sat, 12 Sep 2026 12:52:52 -0700
Message-ID: <20260912195252.990578-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912195156.980886-1-yonghong.song@linux.dev>
References: <20260912195156.980886-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

calc_arg_aux(), save_args() and restore_args() number argument registers
and stack slots consecutively, while AAPCS64 rounds both up to an even
one for an argument aligned to 16 bytes: an __int128, or an aggregate
holding one. The argument that takes the hole, and every argument after
it, is saved from and restored to the wrong place, so a bpf program
attached to such a function reads a neighbouring eightbyte, and the
arguments handed on to the original function are shifted.

Take the position of each argument slot from bpf_jit_place_args() and
keep it in struct arg_aux. save_args() then reads a slot from the
register, or the incoming stack slot, and restore_args() puts it back
there; the outgoing area built for the original function mirrors the
incoming one, hole and all.

A bpf program still cannot read an __int128 argument itself: it is an
integer wider than eight bytes, which btf_ctx_access() refuses, so the
program is rejected whatever the trampoline does with the argument. What
a program can read, and what the placement puts right, is an aggregate
holding an __int128, allowed as a struct, and any argument that follows
a 16-byte aligned one. Both were taken from the wrong place before.

Bound the argument slots rather than the arguments while here.
btf_distill_func_proto() only limits the count although a by-value
argument may take two slots, so, similar to x86-64, support up to
MAX_BPF_FUNC_ARGS argument slots and refuse a function with more.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/arm64/net/bpf_jit_comp.c | 78 ++++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
index 3aa3ea0bc30b..25a7657a6710 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1220,6 +1220,12 @@ static int add_exception_handler(const struct bpf_=
insn *insn,
 	return 0;
 }
=20
+static const struct bpf_jit_arg_abi arm64_arg_abi =3D {
+	.nr_arg_regs		=3D 8,
+	.even_reg_align		=3D true,
+	.even_stack_align	=3D true,
+};
+
 static const u8 stack_arg_reg[] =3D { A64_R(5), A64_R(6), A64_R(7) };
=20
 #define NR_STACK_ARG_REGS	ARRAY_SIZE(stack_arg_reg)
@@ -1293,6 +1299,16 @@ static int emit_kfunc_arena_args(struct jit_ctx *c=
tx, const struct bpf_insn *ins
 	return 0;
 }
=20
+static bool a64_arg_on_stack(u8 slot)
+{
+	return slot >=3D arm64_arg_abi.nr_arg_regs;
+}
+
+static s32 a64_arg_stack_off(u8 slot)
+{
+	return (slot - arm64_arg_abi.nr_arg_regs) * sizeof(u64);
+}
+
 /* JITs an eBPF instruction.
  * Returns:
  * 0  - successfully JITed an 8-byte eBPF instruction.
@@ -2529,33 +2545,41 @@ struct arg_aux {
 	 * arguments to be properly aligned)
 	 */
 	int ostack_for_args;
+	/* where AAPCS64 puts each argument slot: an argument register below
+	 * the eighth, an on-stack argument slot from it up
+	 */
+	u8 pos_of_slot[MAX_BPF_FUNC_ARG_SLOTS];
 };
=20
 static int calc_arg_aux(const struct btf_func_model *m,
 			 struct arg_aux *a)
 {
-	int stack_slots, nregs, slots, i;
+	int slots, i, slot, total;
+
+	total =3D bpf_jit_place_args(&arm64_arg_abi, m, a->pos_of_slot);
+	if (total > MAX_BPF_FUNC_ARGS)
+		return -ENOTSUPP;
=20
 	/* verifier ensures m->nr_args <=3D MAX_BPF_FUNC_ARGS */
-	for (i =3D 0, nregs =3D 0; i < m->nr_args; i++) {
+	for (i =3D 0, slot =3D 0; i < m->nr_args; i++) {
 		slots =3D (m->arg_size[i] + 7) / 8;
-		if (nregs + slots <=3D 8) /* passed through register ? */
-			nregs +=3D slots;
-		else
+		if (a64_arg_on_stack(a->pos_of_slot[slot])) /* passed through register=
 ? */
 			break;
+		slot +=3D slots;
 	}
=20
 	a->args_in_regs =3D i;
-	a->regs_for_args =3D nregs;
+	a->regs_for_args =3D slot;
 	a->ostack_for_args =3D 0;
 	a->bstack_for_args =3D 0;
=20
 	/* the rest arguments are passed through stack */
-	for (; i < m->nr_args; i++) {
-		stack_slots =3D (m->arg_size[i] + 7) / 8;
-		a->bstack_for_args +=3D stack_slots * 8;
-		a->ostack_for_args =3D a->ostack_for_args + stack_slots * 8;
-	}
+	for (; i < m->nr_args; i++)
+		a->bstack_for_args +=3D ((m->arg_size[i] + 7) / 8) * 8;
+
+	/* the outgoing area reaches the last slot, over any alignment hole */
+	if (a->bstack_for_args)
+		a->ostack_for_args =3D a64_arg_stack_off(a->pos_of_slot[total - 1]) + =
8;
=20
 	return 0;
 }
@@ -2602,7 +2626,7 @@ static void save_args(struct jit_ctx *ctx, int barg=
s_off, int oargs_off,
 {
 	u8 tmp =3D bpf2a64[TMP_REG_1];
 	u8 base_lo =3D bpf2a64[TMP_REG_2];
-	int i, reg, doff, soff, slots;
+	int i, reg, slot, soff, slots;
=20
 	/* only the low 32 bits of the base take part in the subtraction */
 	if (arena_base)
@@ -2611,12 +2635,13 @@ static void save_args(struct jit_ctx *ctx, int ba=
rgs_off, int oargs_off,
 	/* store arguments to the stack for the bpf program, or restore
 	 * arguments from stack for the original function
 	 */
-	for (i =3D 0, reg =3D 0; i < a->args_in_regs; i++) {
+	for (i =3D 0, slot =3D 0; i < a->args_in_regs; i++) {
 		bool arena_arg =3D arena_base && (m->arg_flags[i] & BTF_FMODEL_ARENA_A=
RG);
 		bool nullable =3D m->arg_flags[i] & BTF_FMODEL_NULLABLE_ARG;
=20
 		slots =3D (m->arg_size[i] + 7) / 8;
 		while (slots-- > 0) {
+			reg =3D a->pos_of_slot[slot++];
 			if (for_call_origin) {
 				emit(A64_LDR64I(reg, A64_SP, bargs_off), ctx);
 			} else if (arena_arg) {
@@ -2625,7 +2650,6 @@ static void save_args(struct jit_ctx *ctx, int barg=
s_off, int oargs_off,
 			} else {
 				emit(A64_STR64I(reg, A64_SP, bargs_off), ctx);
 			}
-			reg++;
 			bargs_off +=3D 8;
 		}
 	}
@@ -2637,9 +2661,11 @@ static void save_args(struct jit_ctx *ctx, int bar=
gs_off, int oargs_off,
 	 * (FP/LR) frames, so the arguments start at FP + 32. A struct_ops
 	 * callback is called indirectly and only the FP/LR frame is saved, so
 	 * they start at FP + 16.
+	 *
+	 * The outgoing area mirrors the incoming one, hole and all; only the
+	 * bpf program takes the arguments packed.
 	 */
 	soff =3D is_struct_ops ? 16 : 32;
-	doff =3D (for_call_origin ? oargs_off : bargs_off);
=20
 	/* save on stack arguments */
 	for (i =3D a->args_in_regs; i < m->nr_args; i++) {
@@ -2649,7 +2675,9 @@ static void save_args(struct jit_ctx *ctx, int barg=
s_off, int oargs_off,
 		slots =3D (m->arg_size[i] + 7) / 8;
 		/* verifier ensures arg_size <=3D 16, so slots equals 1 or 2 */
 		while (slots-- > 0) {
-			emit(A64_LDR64I(tmp, A64_FP, soff), ctx);
+			int off =3D a64_arg_stack_off(a->pos_of_slot[slot++]);
+
+			emit(A64_LDR64I(tmp, A64_FP, soff + off), ctx);
 			/* if there is unused space in the last slot, clear
 			 * the garbage contained in the space.
 			 */
@@ -2664,19 +2692,21 @@ static void save_args(struct jit_ctx *ctx, int ba=
rgs_off, int oargs_off,
 			 */
 			if (arena_arg)
 				emit_arena_arg_conv(ctx, tmp, tmp, nullable, base_lo);
-			emit(A64_STR64I(tmp, A64_SP, doff), ctx);
-			soff +=3D 8;
-			doff +=3D 8;
+			if (for_call_origin)
+				emit(A64_STR64I(tmp, A64_SP, oargs_off + off), ctx);
+			else
+				emit(A64_STR64I(tmp, A64_SP, bargs_off), ctx);
+			bargs_off +=3D 8;
 		}
 	}
 }
=20
-static void restore_args(struct jit_ctx *ctx, int bargs_off, int nregs)
+static void restore_args(struct jit_ctx *ctx, int bargs_off, const struc=
t arg_aux *a)
 {
-	int reg;
+	int slot;
=20
-	for (reg =3D 0; reg < nregs; reg++) {
-		emit(A64_LDR64I(reg, A64_SP, bargs_off), ctx);
+	for (slot =3D 0; slot < a->regs_for_args; slot++) {
+		emit(A64_LDR64I(a->pos_of_slot[slot], A64_SP, bargs_off), ctx);
 		bargs_off +=3D 8;
 	}
 }
@@ -2948,7 +2978,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, =
struct bpf_tramp_image *im,
 	}
=20
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
-		restore_args(ctx, bargs_off, a->regs_for_args);
+		restore_args(ctx, bargs_off, a);
=20
 	/* restore callee saved register x19 and x20 */
 	emit(A64_LDR64I(A64_R(19), A64_SP, regs_off), ctx);
--=20
2.53.0-Meta

