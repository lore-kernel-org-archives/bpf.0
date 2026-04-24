Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F803DA7EB
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050892; cv=none; b=kDv9/+nDsJ84O+sncWXIrfxRdjkkY9RogUAhYXq4+Krv25CRyDBK1m3iBdjikeOJRy1Kgd61cnHfagclrp70lG1WdeMk2WnU2kMhlSZiOHzTv5APshTIKAOyRzzqesAxoHQtoCxoyUGrHlFK34dIXVfBw0jfzXYXu/C6H1RpluM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050892; c=relaxed/simple;
	bh=cthFBPaf9BastBBcONKK4hsHfyKmK80O0Dk9FPKaxuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QwfkIzaalgwEa1taAHv2DmyMYRvyBzRBw14YN/kktgbXbZ1zR1MAAvwP9oNsrX03XeyW1d9FprsDKhtHUE7HUV1yT2ueBTqLfTR0wye3rz46sI1s2FyGZdtQEsTLHMt8hUK3ee/L6xbSLaMT4CNOKqwSXwyIM1shx/1vnxNthRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id D11FB474A641C; Fri, 24 Apr 2026 10:14:38 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 01/18] bpf: Support stack arguments for bpf functions
Date: Fri, 24 Apr 2026 10:14:38 -0700
Message-ID: <20260424171438.2034741-1-yonghong.song@linux.dev>
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

Currently BPF functions (subprogs) are limited to 5 register arguments.
With [1], the compiler can emit code that passes additional arguments
via a dedicated stack area through bpf register BPF_REG_PARAMS (r11),
introduced in an earlier patch ([2]).

The compiler uses positive r11 offsets for incoming (callee-side) args
and negative r11 offsets for outgoing (caller-side) args, following the
x86_64/arm64 calling convention direction. There is an 8-byte gap at
offset 0 separating two regions:
  Incoming (callee reads):   r11+8 (arg6), r11+16 (arg7), ...
  Outgoing (caller writes):  r11-8 (arg6), r11-16 (arg7), ...

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

  r11+8:  [incoming arg 6]               r11+8:  [incoming arg 6] <-+
  r11+16: [incoming arg 7]               r11+16: [incoming arg 7] <-|+
                                         r11+24: [incoming arg 8] <-||+
  Outgoing (negative offsets):                                      |||
  r11-8:  [outgoing arg 6 to bar] -------->-------------------------+||
  r11-16: [outgoing arg 7 to bar] -------->--------------------------+|
  r11-24: [outgoing arg 8 to bar] -------->---------------------------+

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

  r11+8:  [incoming arg 6]                 r11+8:  [incoming arg 6] <+
  r11+16: [incoming arg 7]                 r11+16: [incoming arg 7] <|+
                                           r11+24: [incoming arg 8] <||+
  Outgoing for bar2 (negative offsets):    r11+32: [incoming arg 9] <|||+
  r11-8:  [outgoing arg 6] ---->----------->-------------------------+|||
  r11-16: [outgoing arg 7] ---->----------->--------------------------+||
  r11-24: [outgoing arg 8] ---->----------->---------------------------+|
  r11-32: [outgoing arg 9] ---->----------->----------------------------+

The verifier tracks outgoing stack arguments in stack_arg_regs[] and
out_stack_arg_depth in bpf_func_state, separately from the regular
r10 stack. The callee does not copy incoming args =E2=80=94 it reads them
directly from the caller's outgoing slots at positive r11 offsets.
Similar to stacksafe(), introduce stack_arg_safe() to do pruning
check.

Outgoing stack arg slots are invalidated when the callee returns
(in prepare_func_exit), not at call time. This allows the callee to
read incoming args from the caller's outgoing slots during
verification. The following are a few examples.

Example 1:
  *(u64 *)(r11 - 8) =3D r6;
  *(u64 *)(r11 - 16) =3D r7;
  call bar1;                // arg6 =3D r6, arg7 =3D r7
  call bar2;                // expected with 2 stack arguments, failed

Example 2:
To fix the Example 1:
  *(u64 *)(r11 - 8) =3D r6;
  *(u64 *)(r11 - 16) =3D r7;
  call bar1;                // arg6 =3D r6, arg7 =3D r7
  *(u64 *)(r11 - 8) =3D r8;
  *(u64 *)(r11 - 16) =3D r9;
  call bar2;                // arg6 =3D r8, arg7 =3D r9

Example 3:
The compiler can hoist the shared stack arg stores above the branch:
  *(u64 *)(r11 - 16) =3D r7;
  if cond goto else;
    *(u64 *)(r11 - 8) =3D r8;
    call bar1;               // arg6 =3D r8, arg7 =3D r7
    goto end;
  else:
    *(u64 *)(r11 - 8) =3D r9;
    call bar2;               // arg6 =3D r9, arg7 =3D r7
  end:

Example 4:
Within a loop:
  loop:
    *(u64 *)(r11 - 8) =3D r6;  // arg6, before loop
    call bar;                // reuses arg6 each iteration
    if ... goto loop;

A separate max_out_stack_arg_depth field in bpf_subprog_info tracks
the deepest outgoing offset actually written. This intends to
reject programs that write to offsets beyond what any callee expects.

Similar to typical compiler generated code, enforce the following
orderings:
  - all stack arg reads must be ahead of any stack arg write
  - all stack arg reads must be before any bpf func, kfunc and helpers
This is needed as jit may emit 'mov' insns for read/write with
the same register.

Callback functions with stack arguments need kernel setup parameter
types (including stack parameters) properly and then callback function
can retrieve such information for verification purpose.

Global subprogs and freplace with >5 args are not yet supported.

  [1] https://github.com/llvm/llvm-project/pull/189060
  [2] https://lore.kernel.org/bpf/20260423033506.2542005-1-yonghong.song@=
linux.dev/

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h          |   2 +
 include/linux/bpf_verifier.h |  27 ++++-
 kernel/bpf/btf.c             |  14 ++-
 kernel/bpf/fixups.c          |  22 +++-
 kernel/bpf/states.c          |  31 ++++++
 kernel/bpf/verifier.c        | 198 ++++++++++++++++++++++++++++++++++-
 6 files changed, 282 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 715b6df9c403..831b28a22f4f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1669,6 +1669,8 @@ struct bpf_prog_aux {
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
index d5b4303315dd..2cc349d7fc17 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -358,6 +358,7 @@ struct bpf_func_state {
 	 *                           | number of simulations is tracked in fram=
e N
 	 */
 	u32 callback_depth;
+	bool no_stack_arg_load;
=20
 	/* The following fields should be last. See copy_func_state() */
 	/* The state of the stack. Each element of the array describes BPF_REG_=
SIZE
@@ -372,6 +373,9 @@ struct bpf_func_state {
 	 * `stack`. allocated_stack is always a multiple of BPF_REG_SIZE.
 	 */
 	int allocated_stack;
+
+	u16 out_stack_arg_depth; /* Size of max outgoing stack args in bytes. *=
/
+	struct bpf_reg_state *stack_arg_regs; /* Outgoing on-stack arguments */
 };
=20
 #define MAX_CALL_FRAMES 8
@@ -508,6 +512,17 @@ struct bpf_verifier_state {
 	     iter < frame->allocated_stack / BPF_REG_SIZE;		\
 	     iter++, reg =3D bpf_get_spilled_reg(iter, frame, mask))
=20
+#define bpf_get_spilled_stack_arg(slot, frame, mask)                   \
+	((((slot) < frame->out_stack_arg_depth / BPF_REG_SIZE) &&           \
+	  (frame->stack_arg_regs[slot].type !=3D NOT_INIT))               \
+	 ? &frame->stack_arg_regs[slot] : NULL)
+
+/* Iterate over 'frame', setting 'reg' to either NULL or a spilled stack=
 arg. */
+#define bpf_for_each_spilled_stack_arg(iter, frame, reg, mask)         \
+	for (iter =3D 0, reg =3D bpf_get_spilled_stack_arg(iter, frame, mask); =
\
+	     iter < frame->out_stack_arg_depth / BPF_REG_SIZE;              \
+	     iter++, reg =3D bpf_get_spilled_stack_arg(iter, frame, mask))
+
 #define bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, __mask, _=
_expr)   \
 	({                                                               \
 		struct bpf_verifier_state *___vstate =3D __vst;            \
@@ -525,6 +540,11 @@ struct bpf_verifier_state {
 					continue;                        \
 				(void)(__expr);                          \
 			}                                                \
+			bpf_for_each_spilled_stack_arg(___j, __state, __reg, __mask) { \
+				if (!__reg)                              \
+					continue;                        \
+				(void)(__expr);                          \
+			}						 \
 		}                                                        \
 	})
=20
@@ -739,10 +759,13 @@ struct bpf_subprog_info {
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
+	u16 stack_arg_depth; /* incoming + max outgoing */
+	u16 max_out_stack_arg_depth;
 };
=20
 struct bpf_verifier_env;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 77af44d8a3ad..cfb35a2decf6 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7880,13 +7880,19 @@ int btf_prepare_func_args(struct bpf_verifier_env=
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
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index fba9e8c00878..7d276208f3cc 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1123,6 +1123,8 @@ static int jit_subprogs(struct bpf_verifier_env *en=
v)
=20
 		func[i]->aux->name[0] =3D 'F';
 		func[i]->aux->stack_depth =3D env->subprog_info[i].stack_depth;
+		func[i]->aux->incoming_stack_arg_depth =3D env->subprog_info[i].incomi=
ng_stack_arg_depth;
+		func[i]->aux->stack_arg_depth =3D env->subprog_info[i].stack_arg_depth=
;
 		if (env->subprog_info[i].priv_stack_mode =3D=3D PRIV_STACK_ADAPTIVE)
 			func[i]->aux->jits_use_priv_stack =3D true;
=20
@@ -1301,8 +1303,10 @@ int bpf_jit_subprogs(struct bpf_verifier_env *env)
 	struct bpf_insn_aux_data *orig_insn_aux;
 	u32 *orig_subprog_starts;
=20
-	if (env->subprog_cnt <=3D 1)
+	if (env->subprog_cnt <=3D 1) {
+		env->prog->aux->stack_arg_depth =3D env->subprog_info[0].stack_arg_dep=
th;
 		return 0;
+	}
=20
 	prog =3D orig_prog =3D env->prog;
 	if (bpf_prog_need_blind(prog)) {
@@ -1378,9 +1382,21 @@ int bpf_fixup_call_args(struct bpf_verifier_env *e=
nv)
 	struct bpf_prog *prog =3D env->prog;
 	struct bpf_insn *insn =3D prog->insnsi;
 	bool has_kfunc_call =3D bpf_prog_has_kfunc_call(prog);
-	int i, depth;
+	int depth;
 #endif
-	int err =3D 0;
+	int i, err =3D 0;
+
+	for (i =3D 0; i < env->subprog_cnt; i++) {
+		struct bpf_subprog_info *subprog =3D &env->subprog_info[i];
+		u16 outgoing =3D subprog->stack_arg_depth - subprog->incoming_stack_ar=
g_depth;
+
+		if (subprog->max_out_stack_arg_depth > outgoing) {
+			verbose(env,
+				"func#%d writes stack arg slot at depth %u, but calls only require %=
u bytes\n",
+				i, subprog->max_out_stack_arg_depth, outgoing);
+			return -EINVAL;
+		}
+	}
=20
 	if (env->prog->jit_requested &&
 	    !bpf_prog_is_offloaded(env->prog->aux)) {
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 8478d2c6ed5b..3e59d1c3a726 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -838,6 +838,34 @@ static bool stacksafe(struct bpf_verifier_env *env, =
struct bpf_func_state *old,
 	return true;
 }
=20
+/*
+ * Compare stack arg slots between old and current states.
+ * Outgoing stack args are path-local state and must agree for pruning.
+ */
+static bool stack_arg_safe(struct bpf_verifier_env *env, struct bpf_func=
_state *old,
+			   struct bpf_func_state *cur, struct bpf_idmap *idmap,
+			   enum exact_level exact)
+{
+	int i, nslots;
+
+	nslots =3D min(old->out_stack_arg_depth, cur->out_stack_arg_depth) / BP=
F_REG_SIZE;
+	for (i =3D 0; i < nslots; i++) {
+		struct bpf_reg_state *old_arg =3D &old->stack_arg_regs[i];
+		struct bpf_reg_state *cur_arg =3D &cur->stack_arg_regs[i];
+
+		if (old_arg->type =3D=3D NOT_INIT && cur_arg->type =3D=3D NOT_INIT)
+			continue;
+
+		if (exact =3D=3D EXACT && old_arg->type !=3D cur_arg->type)
+			return false;
+
+		if (!regsafe(env, old_arg, cur_arg, idmap, exact))
+			return false;
+	}
+
+	return true;
+}
+
 static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_=
state *cur,
 		    struct bpf_idmap *idmap)
 {
@@ -929,6 +957,9 @@ static bool func_states_equal(struct bpf_verifier_env=
 *env, struct bpf_func_stat
 	if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
 		return false;
=20
+	if (!stack_arg_safe(env, old, cur, &env->idmap_scratch, exact))
+		return false;
+
 	return true;
 }
=20
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ff6ff1c27517..bcf81692a22b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1361,6 +1361,18 @@ static int copy_stack_state(struct bpf_func_state =
*dst, const struct bpf_func_st
 		return -ENOMEM;
=20
 	dst->allocated_stack =3D src->allocated_stack;
+
+	/* copy stack args state */
+	n =3D src->out_stack_arg_depth / BPF_REG_SIZE;
+	if (n) {
+		dst->stack_arg_regs =3D copy_array(dst->stack_arg_regs, src->stack_arg=
_regs, n,
+						 sizeof(struct bpf_reg_state),
+						 GFP_KERNEL_ACCOUNT);
+		if (!dst->stack_arg_regs)
+			return -ENOMEM;
+	}
+
+	dst->out_stack_arg_depth =3D src->out_stack_arg_depth;
 	return 0;
 }
=20
@@ -1402,6 +1414,22 @@ static int grow_stack_state(struct bpf_verifier_en=
v *env, struct bpf_func_state
 	return 0;
 }
=20
+static int grow_stack_arg_slots(struct bpf_verifier_env *env,
+				struct bpf_func_state *state, int size)
+{
+	size_t old_n =3D state->out_stack_arg_depth / BPF_REG_SIZE, n =3D size =
/ BPF_REG_SIZE;
+	if (old_n >=3D n)
+		return 0;
+
+	state->stack_arg_regs =3D realloc_array(state->stack_arg_regs, old_n, n=
,
+					  sizeof(struct bpf_reg_state));
+	if (!state->stack_arg_regs)
+		return -ENOMEM;
+
+	state->out_stack_arg_depth =3D size;
+	return 0;
+}
+
 /* Acquire a pointer id from the env and update the state->refs to inclu=
de
  * this new pointer reference.
  * On success, returns a valid pointer id to associate with the register
@@ -1564,6 +1592,7 @@ static void free_func_state(struct bpf_func_state *=
state)
 {
 	if (!state)
 		return;
+	kfree(state->stack_arg_regs);
 	kfree(state->stack);
 	kfree(state);
 }
@@ -4417,6 +4446,109 @@ static int check_stack_write(struct bpf_verifier_=
env *env,
 	return err;
 }
=20
+/*
+ * Write a value to the outgoing stack arg area.
+ * off is a negative offset from r11 (e.g. -8 for arg6, -16 for arg7).
+ */
+static int check_stack_arg_write(struct bpf_verifier_env *env, struct bp=
f_func_state *state,
+				 int off, int value_regno)
+{
+	int max_stack_arg_regs =3D MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS;
+	struct bpf_subprog_info *subprog =3D &env->subprog_info[state->subprogn=
o];
+	int spi =3D -off / BPF_REG_SIZE - 1;
+	struct bpf_func_state *cur;
+	struct bpf_reg_state *arg;
+	int err;
+
+	if (spi >=3D max_stack_arg_regs) {
+		verbose(env, "stack arg write offset %d exceeds max %d stack args\n",
+			off, max_stack_arg_regs);
+		return -EINVAL;
+	}
+
+	err =3D grow_stack_arg_slots(env, state, -off);
+	if (err)
+		return err;
+
+	/* Track the max outgoing stack arg access depth. */
+	if (-off > subprog->max_out_stack_arg_depth)
+		subprog->max_out_stack_arg_depth =3D -off;
+
+	cur =3D env->cur_state->frame[env->cur_state->curframe];
+	if (value_regno >=3D 0) {
+		state->stack_arg_regs[spi] =3D cur->regs[value_regno];
+	} else {
+		/* BPF_ST: store immediate, treat as scalar */
+		arg =3D &state->stack_arg_regs[spi];
+		arg->type =3D SCALAR_VALUE;
+		__mark_reg_known(arg, env->prog->insnsi[env->insn_idx].imm);
+	}
+	state->no_stack_arg_load =3D true;
+	return 0;
+}
+
+/*
+ * Read a value from the incoming stack arg area.
+ * off is a positive offset from r11 (e.g. +8 for arg6, +16 for arg7).
+ */
+static int check_stack_arg_read(struct bpf_verifier_env *env, struct bpf=
_func_state *state,
+				int off, int dst_regno)
+{
+	struct bpf_subprog_info *subprog =3D &env->subprog_info[state->subprogn=
o];
+	struct bpf_verifier_state *vstate =3D env->cur_state;
+	int spi =3D off / BPF_REG_SIZE - 1;
+	struct bpf_func_state *caller, *cur;
+	struct bpf_reg_state *arg;
+
+	if (state->no_stack_arg_load) {
+		verbose(env, "r11 load must be before any r11 store or call insn\n");
+		return -EINVAL;
+	}
+
+	if (off > subprog->incoming_stack_arg_depth) {
+		verbose(env, "invalid read from stack arg off %d depth %d\n",
+			off, subprog->incoming_stack_arg_depth);
+		return -EACCES;
+	}
+
+	caller =3D vstate->frame[vstate->curframe - 1];
+	arg =3D &caller->stack_arg_regs[spi];
+	cur =3D vstate->frame[vstate->curframe];
+
+	if (is_spillable_regtype(arg->type))
+		copy_register_state(&cur->regs[dst_regno], arg);
+	else
+		mark_reg_unknown(env, cur->regs, dst_regno);
+	return 0;
+}
+
+static int check_outgoing_stack_args(struct bpf_verifier_env *env, struc=
t bpf_func_state *caller,
+				     int nargs)
+{
+	int i, spi;
+
+	for (i =3D MAX_BPF_FUNC_REG_ARGS; i < nargs; i++) {
+		spi =3D i - MAX_BPF_FUNC_REG_ARGS;
+		if (spi >=3D (caller->out_stack_arg_depth / BPF_REG_SIZE) ||
+		    caller->stack_arg_regs[spi].type =3D=3D NOT_INIT) {
+			verbose(env, "stack %s not properly initialized\n",
+				reg_arg_name(env, argno_from_arg(i + 1)));
+			return -EFAULT;
+		}
+	}
+
+	return 0;
+}
+
+static struct bpf_reg_state *get_func_arg_reg(struct bpf_func_state *cal=
ler,
+					      struct bpf_reg_state *regs, int arg)
+{
+	if (arg < MAX_BPF_FUNC_REG_ARGS)
+		return &regs[arg + 1];
+
+	return &caller->stack_arg_regs[arg - MAX_BPF_FUNC_REG_ARGS];
+}
+
 static int check_map_access_type(struct bpf_verifier_env *env, struct bp=
f_reg_state *reg,
 				 int off, int size, enum bpf_access_type type)
 {
@@ -6605,10 +6737,20 @@ static int check_load_mem(struct bpf_verifier_env=
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
+	/* Handle stack arg read */
+	if (insn->src_reg =3D=3D BPF_REG_PARAMS) {
+		err =3D check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
+		if (err)
+			return err;
+		return check_stack_arg_read(env, state, insn->off, insn->dst_reg);
+	}
+
 	/* check src operand */
 	err =3D check_reg_arg(env, insn->src_reg, SRC_OP);
 	if (err)
@@ -6637,10 +6779,20 @@ static int check_load_mem(struct bpf_verifier_env=
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
+	if (insn->dst_reg =3D=3D BPF_REG_PARAMS) {
+		err =3D check_reg_arg(env, insn->src_reg, SRC_OP);
+		if (err)
+			return err;
+		return check_stack_arg_write(env, state, insn->off, insn->src_reg);
+	}
+
 	/* check src1 operand */
 	err =3D check_reg_arg(env, insn->src_reg, SRC_OP);
 	if (err)
@@ -9248,6 +9400,14 @@ static void clear_caller_saved_regs(struct bpf_ver=
ifier_env *env,
 	}
 }
=20
+static void invalidate_outgoing_stack_args(struct bpf_func_state *state)
+{
+	int i, nslots =3D state->out_stack_arg_depth / BPF_REG_SIZE;
+
+	for (i =3D 0; i < nslots; i++)
+		state->stack_arg_regs[i].type =3D NOT_INIT;
+}
+
 typedef int (*set_callee_state_fn)(struct bpf_verifier_env *env,
 				   struct bpf_func_state *caller,
 				   struct bpf_func_state *callee,
@@ -9310,6 +9470,7 @@ static int btf_check_func_arg_match(struct bpf_veri=
fier_env *env, int subprog,
 				    struct bpf_reg_state *regs)
 {
 	struct bpf_subprog_info *sub =3D subprog_info(env, subprog);
+	struct bpf_func_state *caller =3D cur_func(env);
 	struct bpf_verifier_log *log =3D &env->log;
 	u32 i;
 	int ret;
@@ -9318,13 +9479,16 @@ static int btf_check_func_arg_match(struct bpf_ve=
rifier_env *env, int subprog,
 	if (ret)
 		return ret;
=20
+	ret =3D check_outgoing_stack_args(env, caller, sub->arg_cnt);
+	if (ret)
+		return ret;
+
 	/* check that BTF function arguments match actual types that the
 	 * verifier sees.
 	 */
 	for (i =3D 0; i < sub->arg_cnt; i++) {
 		argno_t argno =3D argno_from_arg(i + 1);
-		u32 regno =3D i + 1;
-		struct bpf_reg_state *reg =3D &regs[regno];
+		struct bpf_reg_state *reg =3D get_func_arg_reg(caller, regs, i);
 		struct bpf_subprog_arg_info *arg =3D &sub->args[i];
=20
 		if (arg->arg_type =3D=3D ARG_ANYTHING) {
@@ -9512,6 +9676,8 @@ static int check_func_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
 			   int *insn_idx)
 {
 	struct bpf_verifier_state *state =3D env->cur_state;
+	struct bpf_subprog_info *caller_info;
+	u16 callee_incoming, stack_arg_depth;
 	struct bpf_func_state *caller;
 	int err, subprog, target_insn;
=20
@@ -9565,6 +9731,16 @@ static int check_func_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
 		return 0;
 	}
=20
+	/*
+	 * Track caller's total stack arg depth (incoming + max outgoing).
+	 * This is needed so the JIT knows how much stack arg space to allocate=
.
+	 */
+	caller_info =3D &env->subprog_info[caller->subprogno];
+	callee_incoming =3D env->subprog_info[subprog].incoming_stack_arg_depth=
;
+	stack_arg_depth =3D caller_info->incoming_stack_arg_depth + callee_inco=
ming;
+	if (stack_arg_depth > caller_info->stack_arg_depth)
+		caller_info->stack_arg_depth =3D stack_arg_depth;
+
 	/* for regular function entry setup new frame and continue
 	 * from that frame.
 	 */
@@ -9922,6 +10098,7 @@ static int prepare_func_exit(struct bpf_verifier_e=
nv *env, int *insn_idx)
 	 * bpf_throw, this will be done by copy_verifier_state for extra frames=
. */
 	free_func_state(callee);
 	state->frame[state->curframe--] =3D NULL;
+	invalidate_outgoing_stack_args(caller);
=20
 	/* for callbacks widen imprecise scalars to make programs like below ve=
rify:
 	 *
@@ -17627,6 +17804,14 @@ static int do_check_insn(struct bpf_verifier_env=
 *env, bool *do_print_state)
 		return check_store_reg(env, insn, false);
=20
 	case BPF_ST: {
+		/* Handle stack arg write (store immediate) */
+		if (insn->dst_reg =3D=3D BPF_REG_PARAMS) {
+			struct bpf_verifier_state *vstate =3D env->cur_state;
+			struct bpf_func_state *state =3D vstate->frame[vstate->curframe];
+
+			return check_stack_arg_write(env, state, insn->off, -1);
+		}
+
 		enum bpf_reg_type dst_reg_type;
=20
 		err =3D check_reg_arg(env, insn->dst_reg, SRC_OP);
@@ -17661,6 +17846,7 @@ static int do_check_insn(struct bpf_verifier_env =
*env, bool *do_print_state)
 				}
 			}
 			mark_reg_scratched(env, BPF_REG_0);
+			cur_func(env)->no_stack_arg_load =3D true;
 			if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
 				return check_func_call(env, insn, &env->insn_idx);
 			if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL)
@@ -18776,7 +18962,7 @@ static int do_check_common(struct bpf_verifier_en=
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
@@ -18819,6 +19005,12 @@ static int do_check_common(struct bpf_verifier_e=
nv *env, int subprog)
 				goto out;
 			}
 		}
+		if (env->prog->type =3D=3D BPF_PROG_TYPE_EXT && sub->arg_cnt > MAX_BPF=
_FUNC_REG_ARGS) {
+			verbose(env, "freplace programs with >%d args not supported yet\n",
+				MAX_BPF_FUNC_REG_ARGS);
+			ret =3D -EINVAL;
+			goto out;
+		}
 	} else {
 		/* if main BPF program has associated BTF info, validate that
 		 * it's matching expected signature, and otherwise mark BTF
--=20
2.52.0

