Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E4E364053
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 04:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775970001; cv=none; b=uMSBOkoPsobvTy1ctpaJqF3BV4/6rUg8nONINgVDJz75hmdpy9almOqMj8GT4tgEKbWeZLCVwRCVAVKSHLqkGJ3ZksPaLwaw2HANxMvlRUL3RIjro19fQNOcnTQFFW97scYrqV0m3wW2cSHlCPEXV4AO+Xp+hcIBGQv/5jQ7h80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775970001; c=relaxed/simple;
	bh=Oxh3vmvKzdze4v/T7teOtLjKpZGVAr2PPxzoHHOw+Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJS4G66XOx5Dx7zbVsTf3m+CQSU1UFWt4B9/n22cq5c6EdUvh3oLaGZWiO3zG1yQg+Mtll1ioIw/3+oHFAd8gh9fTIqUl9Apz3C7aL5H2BiF8BU2epMfxuzEgT6zOJa5XKc4phgJk/KT5PdQFGQfolfonIawg37HaPEaEoD4MW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 6B5493B021B80; Sat, 11 Apr 2026 21:59:55 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 09/18] bpf: Support stack arguments for bpf functions
Date: Sat, 11 Apr 2026 21:59:12 -0700
Message-ID: <20260412045955.257613-1-yonghong.song@linux.dev>
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

Currently BPF functions (subprogs) are limited to 5 register arguments.
With [1], the compiler can emit code that passes additional arguments
via a dedicated stack area through bpf register
BPF_REG_STACK_ARG_BASE (r12), introduced in the previous patch.

The compiler uses positive r12 offsets for incoming (callee-side) args
and negative r12 offsets for outgoing (caller-side) args, following the
x86_64/arm64 calling convention direction. There is an 8-byte gap at
offset 0 separating the two regions:

  Incoming (callee reads):   r12+8 (arg6), r12+16 (arg7), ...
  Outgoing (caller writes):  r12-N*8 (arg6), ..., r12-8 (last arg)

The following is an example to show how stack arguments are saved
and transferred between caller and callee:

  int foo(int a1, int a2, int a3, int a4, int a5, int a6, int a7) {
    ...
    bar(a1, a2, a3, a4, a5, a6, a7, a8);
    ...
  }

   Caller (foo)                           Callee (bar)
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                           =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
   Incoming (positive offsets):           Incoming (positive offsets):

   r12+8:  [incoming arg 6]               r12+8:  [incoming arg 6] <-+
   r12+16: [incoming arg 7]               r12+16: [incoming arg 7] <-|+
                                          r12+24: [incoming arg 8] <-||+
   Outgoing (negative offsets):                                      |||
   r12-24: [outgoing arg 6 to bar] -------->-------------------------+||
   r12-16: [outgoing arg 7 to bar] -------->--------------------------+|
   r12-8:  [outgoing arg 8 to bar] -------->---------------------------+

Note the reversed order: the caller's most negative outgoing offset
(arg6) maps to the callee's first positive incoming offset (arg6).
The caller stores arg6 at r12-24 (=3D -3*8 for 3 stack args), and
the callee reads it at r12+8.

If the bpf function has more than one call:

  int foo(int a1, int a2, int a3, int a4, int a5, int a6, int a7) {
    ...
    bar1(a1, a2, a3, a4, a5, a6, a7, a8);
    ...
    bar2(a1, a2, a3, a4, a5, a6, a7, a8, a9);
    ...
  }

   Caller (foo)                             Callee (bar2)
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                             =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   Incoming (positive offsets):             Incoming (positive offsets):

   r12+8:  [incoming arg 6]                 r12+8:  [incoming arg 6] <+
   r12+16: [incoming arg 7]                 r12+16: [incoming arg 7] <|+
                                            r12+24: [incoming arg 8] <||+
   Outgoing for bar2 (negative offsets):    r12+32: [incoming arg 9] <|||=
+
   r12-32: [outgoing arg 6] ---->----------->-------------------------+||=
|
   r12-24: [outgoing arg 7] ---->----------->--------------------------+|=
|
   r12-16: [outgoing arg 8] ---->----------->---------------------------+=
|
   r12-8:  [outgoing arg 9] ---->----------->----------------------------=
+

The verifier tracks stack arg slots separately from the regular r10
stack. A new 'bpf_stack_arg_state' structure mirrors the existing stack
slot tracking (spilled_ptr + slot_type[]) but lives in a dedicated
'stack_arg_slots' array in bpf_func_state. This separation keeps the
stack arg area from interfering with the normal stack and frame pointer
(r10) bookkeeping. Similar to stacksafe(), introduce stack_arg_safe()
to do pruning check.

Callback functions with stack arguments need kernel setup parameter
types (including stack parameters) properly and then callback function
can retrieve such information for verification purpose.

Global subprogs with >5 args are not yet supported.

  [1] https://github.com/llvm/llvm-project/pull/189060

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h          |   2 +
 include/linux/bpf_verifier.h |  31 +++-
 kernel/bpf/btf.c             |  14 +-
 kernel/bpf/verifier.c        | 320 ++++++++++++++++++++++++++++++++++-
 4 files changed, 355 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b0f956be73d2..5e061ec42940 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1666,6 +1666,8 @@ struct bpf_prog_aux {
 	u32 max_pkt_offset;
 	u32 max_tp_access;
 	u32 stack_depth;
+	u16 incoming_stack_arg_depth;
+	u16 stack_arg_depth; /* both incoming and max outgoing of stack argumen=
ts */
 	u32 id;
 	u32 func_cnt; /* used by non-func prog as the number of func progs */
 	u32 real_func_cnt; /* includes hidden progs, only used for JIT and free=
ing progs */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 291f11ddd176..645a4546a57f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -319,6 +319,11 @@ struct bpf_retval_range {
 	bool return_32bit;
 };
=20
+struct bpf_stack_arg_state {
+	struct bpf_reg_state spilled_ptr; /* for spilled scalar/pointer semanti=
cs */
+	u8 slot_type[BPF_REG_SIZE];
+};
+
 /* state of the program:
  * type of all registers and stack info
  */
@@ -370,6 +375,10 @@ struct bpf_func_state {
 	 * `stack`. allocated_stack is always a multiple of BPF_REG_SIZE.
 	 */
 	int allocated_stack;
+
+	u16 stack_arg_depth; /* Size of incoming + max outgoing stack args in b=
ytes. */
+	u16 incoming_stack_arg_depth; /* Size of incoming stack args in bytes. =
*/
+	struct bpf_stack_arg_state *stack_arg_slots;
 };
=20
 #define MAX_CALL_FRAMES 8
@@ -506,6 +515,17 @@ struct bpf_verifier_state {
 	     iter < frame->allocated_stack / BPF_REG_SIZE;		\
 	     iter++, reg =3D bpf_get_spilled_reg(iter, frame, mask))
=20
+#define bpf_get_spilled_stack_arg(slot, frame, mask)			\
+	(((slot < frame->stack_arg_depth / BPF_REG_SIZE) &&		\
+	  ((1 << frame->stack_arg_slots[slot].slot_type[BPF_REG_SIZE - 1]) & (m=
ask))) \
+	 ? &frame->stack_arg_slots[slot].spilled_ptr : NULL)
+
+/* Iterate over 'frame', setting 'reg' to either NULL or a spilled stack=
 arg. */
+#define bpf_for_each_spilled_stack_arg(iter, frame, reg, mask)		\
+	for (iter =3D 0, reg =3D bpf_get_spilled_stack_arg(iter, frame, mask); =
\
+	     iter < frame->stack_arg_depth / BPF_REG_SIZE;		\
+	     iter++, reg =3D bpf_get_spilled_stack_arg(iter, frame, mask))
+
 #define bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, __mask, _=
_expr)   \
 	({                                                               \
 		struct bpf_verifier_state *___vstate =3D __vst;            \
@@ -523,6 +543,11 @@ struct bpf_verifier_state {
 					continue;                        \
 				(void)(__expr);                          \
 			}                                                \
+			bpf_for_each_spilled_stack_arg(___j, __state, __reg, __mask) { \
+				if (!__reg)                              \
+					continue;                        \
+				(void)(__expr);                          \
+			}                                                \
 		}                                                        \
 	})
=20
@@ -736,10 +761,12 @@ struct bpf_subprog_info {
 	bool keep_fastcall_stack: 1;
 	bool changes_pkt_data: 1;
 	bool might_sleep: 1;
-	u8 arg_cnt:3;
+	u8 arg_cnt:4;
=20
 	enum priv_stack_mode priv_stack_mode;
-	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
+	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_ARGS];
+	u16 incoming_stack_arg_depth;
+	u16 outgoing_stack_arg_depth;
 };
=20
 struct bpf_verifier_env;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a62d78581207..c5f3aa05d5a3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7887,13 +7887,19 @@ int btf_prepare_func_args(struct bpf_verifier_env=
 *env, int subprog)
 	}
 	args =3D (const struct btf_param *)(t + 1);
 	nargs =3D btf_type_vlen(t);
-	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
-		if (!is_global)
-			return -EINVAL;
-		bpf_log(log, "Global function %s() with %d > %d args. Buggy compiler.\=
n",
+	if (nargs > MAX_BPF_FUNC_ARGS) {
+		bpf_log(log, "Function %s() with %d > %d args not supported.\n",
+			tname, nargs, MAX_BPF_FUNC_ARGS);
+		return -EINVAL;
+	}
+	if (is_global && nargs > MAX_BPF_FUNC_REG_ARGS) {
+		bpf_log(log, "Global function %s() with %d > %d args not supported.\n"=
,
 			tname, nargs, MAX_BPF_FUNC_REG_ARGS);
 		return -EINVAL;
 	}
+	if (nargs > MAX_BPF_FUNC_REG_ARGS)
+		sub->incoming_stack_arg_depth =3D (nargs - MAX_BPF_FUNC_REG_ARGS) * BP=
F_REG_SIZE;
+
 	/* check that function is void or returns int, exception cb also requir=
es this */
 	t =3D btf_type_by_id(btf, t->type);
 	while (btf_type_is_modifier(t))
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 01df990f841a..e664d924e8d4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1482,6 +1482,19 @@ static int copy_stack_state(struct bpf_func_state =
*dst, const struct bpf_func_st
 		return -ENOMEM;
=20
 	dst->allocated_stack =3D src->allocated_stack;
+
+	/* copy stack_arg_slots state */
+	n =3D src->stack_arg_depth / BPF_REG_SIZE;
+	if (n) {
+		dst->stack_arg_slots =3D copy_array(dst->stack_arg_slots, src->stack_a=
rg_slots, n,
+						  sizeof(struct bpf_stack_arg_state),
+						  GFP_KERNEL_ACCOUNT);
+		if (!dst->stack_arg_slots)
+			return -ENOMEM;
+
+		dst->stack_arg_depth =3D src->stack_arg_depth;
+		dst->incoming_stack_arg_depth =3D src->incoming_stack_arg_depth;
+	}
 	return 0;
 }
=20
@@ -1523,6 +1536,25 @@ static int grow_stack_state(struct bpf_verifier_en=
v *env, struct bpf_func_state
 	return 0;
 }
=20
+static int grow_stack_arg_slots(struct bpf_verifier_env *env,
+				struct bpf_func_state *state, int size)
+{
+	size_t old_n =3D state->stack_arg_depth / BPF_REG_SIZE, n;
+
+	size =3D round_up(size, BPF_REG_SIZE);
+	n =3D size / BPF_REG_SIZE;
+	if (old_n >=3D n)
+		return 0;
+
+	state->stack_arg_slots =3D realloc_array(state->stack_arg_slots, old_n,=
 n,
+					       sizeof(struct bpf_stack_arg_state));
+	if (!state->stack_arg_slots)
+		return -ENOMEM;
+
+	state->stack_arg_depth =3D size;
+	return 0;
+}
+
 /* Acquire a pointer id from the env and update the state->refs to inclu=
de
  * this new pointer reference.
  * On success, returns a valid pointer id to associate with the register
@@ -1693,6 +1725,7 @@ static void free_func_state(struct bpf_func_state *=
state)
 {
 	if (!state)
 		return;
+	kfree(state->stack_arg_slots);
 	kfree(state->stack);
 	kfree(state);
 }
@@ -5940,6 +5973,119 @@ static int check_stack_write(struct bpf_verifier_=
env *env,
 	return err;
 }
=20
+/* Validate that a stack arg access is 8-byte sized and aligned. */
+static int check_stack_arg_access(struct bpf_verifier_env *env,
+				  struct bpf_insn *insn, const char *op)
+{
+	int size =3D bpf_size_to_bytes(BPF_SIZE(insn->code));
+
+	if (size !=3D BPF_REG_SIZE) {
+		verbose(env, "stack arg %s must be %d bytes, got %d\n",
+			op, BPF_REG_SIZE, size);
+		return -EINVAL;
+	}
+	if (insn->off =3D=3D 0 || insn->off % BPF_REG_SIZE) {
+		verbose(env, "stack arg %s offset %d not aligned to %d\n",
+			op, insn->off, BPF_REG_SIZE);
+		return -EINVAL;
+	}
+	/* Reads use positive offsets (incoming), writes use negative (outgoing=
) */
+	if (op[0] =3D=3D 'r' && insn->off < 0) {
+		verbose(env, "stack arg read must use positive offset, got %d\n",
+			insn->off);
+		return -EINVAL;
+	}
+	if (op[0] =3D=3D 'w' && insn->off > 0) {
+		verbose(env, "stack arg write must use negative offset, got %d\n",
+			insn->off);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/* Check that a stack arg slot has been properly initialized. */
+static bool is_stack_arg_slot_initialized(struct bpf_func_state *state, =
int spi)
+{
+	u8 type;
+
+	if (spi >=3D (int)(state->stack_arg_depth / BPF_REG_SIZE))
+		return false;
+	type =3D state->stack_arg_slots[spi].slot_type[BPF_REG_SIZE - 1];
+	return type =3D=3D STACK_SPILL || type =3D=3D STACK_MISC;
+}
+
+/*
+ * Write a value to the outgoing stack arg area.
+ * off is a negative offset from r12 (e.g. -8 for the last outgoing arg)=
.
+ * Callers ensure off < 0, 8-byte aligned, and size is BPF_REG_SIZE.
+ */
+static int check_stack_arg_write(struct bpf_verifier_env *env, struct bp=
f_func_state *state,
+				 int off, int value_regno)
+{
+	int incoming_slots =3D state->incoming_stack_arg_depth / BPF_REG_SIZE;
+	int spi =3D incoming_slots + (-off / BPF_REG_SIZE - 1);
+	struct bpf_subprog_info *subprog;
+	struct bpf_func_state *cur;
+	struct bpf_reg_state *reg;
+	int i, err;
+	u8 type;
+
+	err =3D grow_stack_arg_slots(env, state, state->incoming_stack_arg_dept=
h + (-off));
+	if (err)
+		return err;
+
+	/* Ensure the JIT allocates space for the outgoing stack arg area. */
+	subprog =3D &env->subprog_info[state->subprogno];
+	if (-off > subprog->outgoing_stack_arg_depth)
+		subprog->outgoing_stack_arg_depth =3D -off;
+
+	cur =3D env->cur_state->frame[env->cur_state->curframe];
+	if (value_regno >=3D 0) {
+		reg =3D &cur->regs[value_regno];
+		state->stack_arg_slots[spi].spilled_ptr =3D *reg;
+		type =3D is_spillable_regtype(reg->type) ? STACK_SPILL : STACK_MISC;
+		for (i =3D 0; i < BPF_REG_SIZE; i++)
+			state->stack_arg_slots[spi].slot_type[i] =3D type;
+	} else {
+		/* BPF_ST: store immediate, treat as scalar */
+		reg =3D &state->stack_arg_slots[spi].spilled_ptr;
+		reg->type =3D SCALAR_VALUE;
+		__mark_reg_known(reg, env->prog->insnsi[env->insn_idx].imm);
+		for (i =3D 0; i < BPF_REG_SIZE; i++)
+			state->stack_arg_slots[spi].slot_type[i] =3D STACK_MISC;
+	}
+	return 0;
+}
+
+/*
+ * Read a value from the incoming stack arg area.
+ * off is a positive offset from r12 (e.g. +8 for arg6, +16 for arg7).
+ * Callers ensure off > 0, 8-byte aligned, and size is BPF_REG_SIZE.
+ */
+static int check_stack_arg_read(struct bpf_verifier_env *env, struct bpf=
_func_state *state,
+				int off, int dst_regno)
+{
+	int spi =3D off / BPF_REG_SIZE - 1;
+	struct bpf_func_state *cur;
+	u8 *stype;
+
+	if (off > state->incoming_stack_arg_depth) {
+		verbose(env, "invalid read from stack arg off %d depth %d\n",
+			off, state->incoming_stack_arg_depth);
+		return -EACCES;
+	}
+
+	stype =3D state->stack_arg_slots[spi].slot_type;
+	cur =3D env->cur_state->frame[env->cur_state->curframe];
+
+	if (stype[BPF_REG_SIZE - 1] =3D=3D STACK_SPILL)
+		copy_register_state(&cur->regs[dst_regno],
+				    &state->stack_arg_slots[spi].spilled_ptr);
+	else
+		mark_reg_unknown(env, cur->regs, dst_regno);
+	return 0;
+}
+
 static int check_map_access_type(struct bpf_verifier_env *env, struct bp=
f_reg_state *reg,
 				 int off, int size, enum bpf_access_type type)
 {
@@ -8136,10 +8282,23 @@ static int check_load_mem(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
 			  bool strict_alignment_once, bool is_ldsx,
 			  bool allow_trust_mismatch, const char *ctx)
 {
+	struct bpf_verifier_state *vstate =3D env->cur_state;
+	struct bpf_func_state *state =3D vstate->frame[vstate->curframe];
 	struct bpf_reg_state *regs =3D cur_regs(env);
 	enum bpf_reg_type src_reg_type;
 	int err;
=20
+	/* Handle stack arg access */
+	if (insn->src_reg =3D=3D BPF_REG_STACK_ARG_BASE) {
+		err =3D check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
+		if (err)
+			return err;
+		err =3D check_stack_arg_access(env, insn, "read");
+		if (err)
+			return err;
+		return check_stack_arg_read(env, state, insn->off, insn->dst_reg);
+	}
+
 	/* check src operand */
 	err =3D check_reg_arg(env, insn->src_reg, SRC_OP);
 	if (err)
@@ -8168,10 +8327,23 @@ static int check_load_mem(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
 static int check_store_reg(struct bpf_verifier_env *env, struct bpf_insn=
 *insn,
 			   bool strict_alignment_once)
 {
+	struct bpf_verifier_state *vstate =3D env->cur_state;
+	struct bpf_func_state *state =3D vstate->frame[vstate->curframe];
 	struct bpf_reg_state *regs =3D cur_regs(env);
 	enum bpf_reg_type dst_reg_type;
 	int err;
=20
+	/* Handle stack arg write */
+	if (insn->dst_reg =3D=3D BPF_REG_STACK_ARG_BASE) {
+		err =3D check_reg_arg(env, insn->src_reg, SRC_OP);
+		if (err)
+			return err;
+		err =3D check_stack_arg_access(env, insn, "write");
+		if (err)
+			return err;
+		return check_stack_arg_write(env, state, insn->off, insn->src_reg);
+	}
+
 	/* check src1 operand */
 	err =3D check_reg_arg(env, insn->src_reg, SRC_OP);
 	if (err)
@@ -10881,7 +11053,7 @@ static int btf_check_func_arg_match(struct bpf_ve=
rifier_env *env, int subprog,
 	/* check that BTF function arguments match actual types that the
 	 * verifier sees.
 	 */
-	for (i =3D 0; i < sub->arg_cnt; i++) {
+	for (i =3D 0; i < min_t(u32, sub->arg_cnt, MAX_BPF_FUNC_REG_ARGS); i++)=
 {
 		u32 regno =3D i + 1;
 		struct bpf_reg_state *reg =3D &regs[regno];
 		struct bpf_subprog_arg_info *arg =3D &sub->args[i];
@@ -11067,8 +11239,10 @@ static int check_func_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 			   int *insn_idx)
 {
 	struct bpf_verifier_state *state =3D env->cur_state;
+	struct bpf_subprog_info *caller_info;
 	struct bpf_func_state *caller;
 	int err, subprog, target_insn;
+	u16 callee_incoming;
=20
 	target_insn =3D *insn_idx + insn->imm + 1;
 	subprog =3D bpf_find_subprog(env, target_insn);
@@ -11120,6 +11294,15 @@ static int check_func_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 		return 0;
 	}
=20
+	/*
+	 * Track caller's outgoing stack arg depth (max across all callees).
+	 * This is needed so the JIT knows how much stack arg space to allocate=
.
+	 */
+	caller_info =3D &env->subprog_info[caller->subprogno];
+	callee_incoming =3D env->subprog_info[subprog].incoming_stack_arg_depth=
;
+	if (callee_incoming > caller_info->outgoing_stack_arg_depth)
+		caller_info->outgoing_stack_arg_depth =3D callee_incoming;
+
 	/* for regular function entry setup new frame and continue
 	 * from that frame.
 	 */
@@ -11173,13 +11356,61 @@ static int set_callee_state(struct bpf_verifier=
_env *env,
 			    struct bpf_func_state *caller,
 			    struct bpf_func_state *callee, int insn_idx)
 {
-	int i;
+	struct bpf_subprog_info *callee_info;
+	int i, err;
=20
 	/* copy r1 - r5 args that callee can access.  The copy includes parent
 	 * pointers, which connects us up to the liveness chain
 	 */
 	for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++)
 		callee->regs[i] =3D caller->regs[i];
+
+	/*
+	 * Transfer stack args from caller's outgoing area to callee's incoming=
 area.
+	 *
+	 * Caller stores outgoing args at negative r12 offsets: -K*8 (arg6),
+	 * -(K-1)*8 (arg7), ..., -8 (last arg).  In the caller's slot array,
+	 * outgoing spi 0 (off=3D-8) is the *last* arg and spi K-1 (off=3D-K*8)
+	 * is arg6.
+	 *
+	 * Callee reads incoming args at positive r12 offsets: +8 (arg6),
+	 * +16 (arg7), ...  Incoming spi 0 is arg6.
+	 *
+	 * So the transfer reverses: callee spi i =3D caller outgoing spi (K-1-=
i).
+	 */
+	callee_info =3D &env->subprog_info[callee->subprogno];
+	if (callee_info->incoming_stack_arg_depth) {
+		int caller_incoming_slots =3D caller->incoming_stack_arg_depth / BPF_R=
EG_SIZE;
+		int callee_incoming_slots =3D callee_info->incoming_stack_arg_depth / =
BPF_REG_SIZE;
+
+		callee->incoming_stack_arg_depth =3D callee_info->incoming_stack_arg_d=
epth;
+		err =3D grow_stack_arg_slots(env, callee, callee_info->incoming_stack_=
arg_depth);
+		if (err)
+			return err;
+
+		for (i =3D 0; i < callee_incoming_slots; i++) {
+			int caller_spi =3D caller_incoming_slots +
+					 (callee_incoming_slots - 1 - i);
+
+			if (!is_stack_arg_slot_initialized(caller, caller_spi)) {
+				verbose(env, "stack arg#%d not properly initialized\n",
+					i + MAX_BPF_FUNC_REG_ARGS);
+				return -EINVAL;
+			}
+			callee->stack_arg_slots[i] =3D caller->stack_arg_slots[caller_spi];
+		}
+
+		/* Invalidate caller's outgoing slots -- they have been consumed
+		 * by the callee. This ensures the verifier requires fresh
+		 * initialization before each subsequent call.
+		 */
+		for (i =3D 0; i < callee_incoming_slots; i++) {
+			int caller_spi =3D i + caller_incoming_slots;
+
+			memset(&caller->stack_arg_slots[caller_spi], 0,
+			       sizeof(caller->stack_arg_slots[caller_spi]));
+		}
+	}
 	return 0;
 }
=20
@@ -20565,6 +20796,60 @@ static bool stacksafe(struct bpf_verifier_env *e=
nv, struct bpf_func_state *old,
 	return true;
 }
=20
+/*
+ * Compare stack arg slots between old and current states.
+ * Only incoming stack args need comparison -=E2=80=94 outgoing slots ar=
e transient
+ * (written before each call, consumed at the call site) so they don't c=
arry
+ * meaningful state across pruning points.
+ */
+static bool stack_arg_safe(struct bpf_verifier_env *env, struct bpf_func=
_state *old,
+			   struct bpf_func_state *cur, struct bpf_idmap *idmap,
+			   enum exact_level exact)
+{
+	int i, spi;
+
+	if (old->incoming_stack_arg_depth !=3D cur->incoming_stack_arg_depth)
+		return false;
+
+	/* Compare both incoming and outgoing stack arg slots. */
+	if (old->stack_arg_depth !=3D cur->stack_arg_depth)
+		return false;
+
+	for (i =3D 0; i < old->stack_arg_depth; i++) {
+		spi =3D i / BPF_REG_SIZE;
+
+		if (exact =3D=3D EXACT &&
+		    old->stack_arg_slots[spi].slot_type[i % BPF_REG_SIZE] !=3D
+		    cur->stack_arg_slots[spi].slot_type[i % BPF_REG_SIZE])
+			return false;
+
+		if (old->stack_arg_slots[spi].slot_type[i % BPF_REG_SIZE] =3D=3D STACK=
_INVALID)
+			continue;
+
+		if (old->stack_arg_slots[spi].slot_type[i % BPF_REG_SIZE] !=3D
+		    cur->stack_arg_slots[spi].slot_type[i % BPF_REG_SIZE])
+			return false;
+
+		if (i % BPF_REG_SIZE !=3D BPF_REG_SIZE - 1)
+			continue;
+
+		switch (old->stack_arg_slots[spi].slot_type[BPF_REG_SIZE - 1]) {
+		case STACK_SPILL:
+			if (!regsafe(env, &old->stack_arg_slots[spi].spilled_ptr,
+				     &cur->stack_arg_slots[spi].spilled_ptr, idmap, exact))
+				return false;
+			break;
+		case STACK_MISC:
+		case STACK_ZERO:
+		case STACK_INVALID:
+			continue;
+		default:
+			return false;
+		}
+	}
+	return true;
+}
+
 static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_=
state *cur,
 		    struct bpf_idmap *idmap)
 {
@@ -20656,6 +20941,9 @@ static bool func_states_equal(struct bpf_verifier=
_env *env, struct bpf_func_stat
 	if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
 		return false;
=20
+	if (!stack_arg_safe(env, old, cur, &env->idmap_scratch, exact))
+		return false;
+
 	return true;
 }
=20
@@ -21545,6 +21833,17 @@ static int do_check_insn(struct bpf_verifier_env=
 *env, bool *do_print_state)
 		return check_store_reg(env, insn, false);
=20
 	case BPF_ST: {
+		/* Handle stack arg write (store immediate) */
+		if (insn->dst_reg =3D=3D BPF_REG_STACK_ARG_BASE) {
+			struct bpf_verifier_state *vstate =3D env->cur_state;
+			struct bpf_func_state *state =3D vstate->frame[vstate->curframe];
+
+			err =3D check_stack_arg_access(env, insn, "write");
+			if (err)
+				return err;
+			return check_stack_arg_write(env, state, insn->off, -1);
+		}
+
 		enum bpf_reg_type dst_reg_type;
=20
 		err =3D check_reg_arg(env, insn->dst_reg, SRC_OP);
@@ -22383,11 +22682,11 @@ static int check_and_resolve_insns(struct bpf_v=
erifier_env *env)
 		return err;
=20
 	for (i =3D 0; i < insn_cnt; i++, insn++) {
-		if (insn->dst_reg >=3D MAX_BPF_REG) {
+		if (insn->dst_reg >=3D MAX_BPF_REG && insn->dst_reg !=3D BPF_REG_STACK=
_ARG_BASE) {
 			verbose(env, "R%d is invalid\n", insn->dst_reg);
 			return -EINVAL;
 		}
-		if (insn->src_reg >=3D MAX_BPF_REG) {
+		if (insn->src_reg >=3D MAX_BPF_REG && insn->src_reg !=3D BPF_REG_STACK=
_ARG_BASE) {
 			verbose(env, "R%d is invalid\n", insn->src_reg);
 			return -EINVAL;
 		}
@@ -23414,8 +23713,14 @@ static int jit_subprogs(struct bpf_verifier_env =
*env)
 	int err, num_exentries;
 	int old_len, subprog_start_adjustment =3D 0;
=20
-	if (env->subprog_cnt <=3D 1)
+	if (env->subprog_cnt <=3D 1) {
+		/*
+		 * Even without subprogs, kfunc calls with >5 args need stack arg spac=
e
+		 * allocated by the root program.
+		 */
+		prog->aux->stack_arg_depth =3D env->subprog_info[0].outgoing_stack_arg=
_depth;
 		return 0;
+	}
=20
 	for (i =3D 0, insn =3D prog->insnsi; i < prog->len; i++, insn++) {
 		if (!bpf_pseudo_func(insn) && !bpf_pseudo_call(insn))
@@ -23505,6 +23810,9 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
=20
 		func[i]->aux->name[0] =3D 'F';
 		func[i]->aux->stack_depth =3D env->subprog_info[i].stack_depth;
+		func[i]->aux->incoming_stack_arg_depth =3D env->subprog_info[i].incomi=
ng_stack_arg_depth;
+		func[i]->aux->stack_arg_depth =3D env->subprog_info[i].incoming_stack_=
arg_depth +
+						env->subprog_info[i].outgoing_stack_arg_depth;
 		if (env->subprog_info[i].priv_stack_mode =3D=3D PRIV_STACK_ADAPTIVE)
 			func[i]->aux->jits_use_priv_stack =3D true;
=20
@@ -25197,7 +25505,7 @@ static int do_check_common(struct bpf_verifier_en=
v *env, int subprog)
 				goto out;
 			}
 		}
-		for (i =3D BPF_REG_1; i <=3D sub->arg_cnt; i++) {
+		for (i =3D BPF_REG_1; i <=3D min_t(u32, sub->arg_cnt, MAX_BPF_FUNC_REG=
_ARGS); i++) {
 			arg =3D &sub->args[i - BPF_REG_1];
 			reg =3D &regs[i];
=20
--=20
2.52.0

