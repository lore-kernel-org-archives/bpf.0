Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0AB34028D
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 03:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776397674; cv=none; b=j0vR/p3wXpaLSEqpSpo+lX76DlU1QB8aH/84cQb3YteNiLAYhYBcrlzV1ShbBmgJhn6CO9wlqIsVoVw5MWnOy9IEZZzBgvMFRgZ94BurYG73+gKH2YyOs01h0NwaPYX5W8tRL/0O4yC8luz+0Use2erPkPXvVzIGEVvPIlkSch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776397674; c=relaxed/simple;
	bh=Pc9HgRTQkZpISwz7NLKlV9i7wnUHztPcCSrsmJlxHu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIrqA1GF5ksrSdBdCCRQVztgcAs1UTeIZDcckOv1KUX0ux1Q0onwOp1Eh+F8X++F4pCjTd/aveZrDzF/AzivSOLZJ37RjZKqlqbeQgu79xYd8j20tH2tF2HWARa9ASkg6HKd+LIK39mwdRQNMFaegP/yyZe9F6wPPBPQ3K2kI1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 8ED24403C240A; Thu, 16 Apr 2026 20:47:39 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 08/16] bpf: Support stack arguments for bpf functions
Date: Thu, 16 Apr 2026 20:47:39 -0700
Message-ID: <20260417034739.2629927-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260417034658.2625353-1-yonghong.song@linux.dev>
References: <20260417034658.2625353-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently BPF functions (subprogs) are limited to 5 register arguments.
With [1], the compiler can emit code that passes additional arguments
via a dedicated stack area through bpf register BPF_REG_PARAMS (r11),
introduced in the previous patch.

The compiler uses positive r11 offsets for incoming (callee-side) args
and negative r11 offsets for outgoing (caller-side) args, following the
x86_64/arm64 calling convention direction. There is an 8-byte gap at
offset 0 separating the two regions:
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

The verifier tracks stack arguments separately from the regular r10
stack. The stack_arg_regs are stored in bpf_func_state. This separation
keeps the stack arg area from interfering with the normal stack and
frame pointer (r10) bookkeeping. Similar to stacksafe(), introduce
stack_arg_safe() to do pruning check.

A per-state bitmask out_stack_arg_mask tracks which outgoing stack arg
slots have been written on the current path. Each bit corresponds to
an outgoing slot index (bit 0 =3D r11-8 =3D arg6, bit 1 =3D r11-16 =3D ar=
g7,
etc.). At a call site, the verifier checks that all slots required by
the callee have their corresponding mask bits set. This enables
precise per-path tracking: if one branch of a conditional writes arg6
but another does not, the mask correctly reflects the difference and
the verifier rejects the uninitialized path. The mask is included in
stack_arg_safe() so that states with different sets of initialized
slots are not incorrectly pruned together.

Outgoing stack arg slots are not invalidated after a call. This allows
the compiler to hoist shared stores above a call and reuse them for
subsequent calls. The following are a few examples.

Example 1:
  *(u64 *)(r11 - 8) =3D r6;
  *(u64 *)(r11 - 16) =3D r7;
  call bar1;                // arg6 =3D r6, arg7 =3D r7
  call bar2;                // reuses same arg6, arg7 without re-storing

Example 2:
If the caller wants different values for a later call, it simply
overwrites the slot before that call:
  *(u64 *)(r11 - 8) =3D r6;
  call bar1;                // arg6 =3D r6
  *(u64 *)(r11 - 8) =3D r8;   // overwrite arg6
  call bar2;                // arg6 =3D r8

Example 3:
The compiler can hoist the shared stack arg stores above the branch:
  *(u64 *)(r11 - 16) =3D r7;
  ...
  if cond goto else;
    *(u64 *)(r11 - 8) =3D r8;
    call bar1;               // arg6 =3D r8, arg7 =3D r7
    goto end;
  else:
    *(u64 *)(r11 - 8) =3D r9;
    call bar2;               // arg6 =3D r9, arg7 =3D r7
  end:

Example 4:
The compiler hoists the store above the loop:
  *(u64 *)(r11 - 8) =3D r6;    // arg6, before loop
  loop:
    call bar;                // reuses arg6 each iteration
    if ... goto loop;

A separate max_out_stack_arg_depth field in bpf_subprog_info tracks
the deepest outgoing offset actually written. This intends to
reject programs that write to offsets beyond what any callee expects.

Callback functions with stack arguments need kernel setup parameter
types (including stack parameters) properly and then callback function
can retrieve such information for verification purpose.

Global subprogs with >5 args are not yet supported.

  [1] https://github.com/llvm/llvm-project/pull/189060

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h          |   2 +
 include/linux/bpf_verifier.h |  28 +++-
 kernel/bpf/btf.c             |  14 +-
 kernel/bpf/fixups.c          |  26 +++-
 kernel/bpf/states.c          |  41 +++++
 kernel/bpf/verifier.c        | 284 ++++++++++++++++++++++++++++++++++-
 6 files changed, 383 insertions(+), 12 deletions(-)

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
index 29a8a2605a12..6223c055b028 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -372,6 +372,11 @@ struct bpf_func_state {
 	 * `stack`. allocated_stack is always a multiple of BPF_REG_SIZE.
 	 */
 	int allocated_stack;
+
+	u16 stack_arg_depth; /* Size of incoming + max outgoing stack args in b=
ytes. */
+	u16 incoming_stack_arg_depth; /* Size of incoming stack args in bytes. =
*/
+	u16 out_stack_arg_mask; /* Bitmask of outgoing stack arg slots that hav=
e been written. */
+	struct bpf_reg_state *stack_arg_regs; /* On-stack arguments */
 };
=20
 #define MAX_CALL_FRAMES 8
@@ -508,6 +513,17 @@ struct bpf_verifier_state {
 	     iter < frame->allocated_stack / BPF_REG_SIZE;		\
 	     iter++, reg =3D bpf_get_spilled_reg(iter, frame, mask))
=20
+#define bpf_get_spilled_stack_arg(slot, frame, mask)                   \
+	(((slot < frame->stack_arg_depth / BPF_REG_SIZE) &&             \
+	  ((1 << frame->stack_arg_regs[slot].type) & (mask))) \
+	 ? &frame->stack_arg_regs[slot] : NULL)
+
+/* Iterate over 'frame', setting 'reg' to either NULL or a spilled stack=
 arg. */
+#define bpf_for_each_spilled_stack_arg(iter, frame, reg, mask)         \
+	for (iter =3D 0, reg =3D bpf_get_spilled_stack_arg(iter, frame, mask); =
\
+	     iter < frame->stack_arg_depth / BPF_REG_SIZE;              \
+	     iter++, reg =3D bpf_get_spilled_stack_arg(iter, frame, mask))
+
 #define bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, __mask, _=
_expr)   \
 	({                                                               \
 		struct bpf_verifier_state *___vstate =3D __vst;            \
@@ -525,6 +541,11 @@ struct bpf_verifier_state {
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
@@ -738,10 +759,13 @@ struct bpf_subprog_info {
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
+	u16 max_out_stack_arg_depth;
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
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 67c9b28767e1..f9233945b0f2 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -983,8 +983,14 @@ int bpf_jit_subprogs(struct bpf_verifier_env *env)
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
@@ -1074,6 +1080,9 @@ int bpf_jit_subprogs(struct bpf_verifier_env *env)
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
@@ -1265,9 +1274,20 @@ int bpf_fixup_call_args(struct bpf_verifier_env *e=
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
+
+		if (subprog->max_out_stack_arg_depth > subprog->outgoing_stack_arg_dep=
th) {
+			verbose(env,
+				"func#%d writes stack arg slot at depth %u, but calls only require %=
u bytes\n",
+				i, subprog->max_out_stack_arg_depth, subprog->outgoing_stack_arg_dep=
th);
+			return -EINVAL;
+		}
+	}
=20
 	if (env->prog->jit_requested &&
 	    !bpf_prog_is_offloaded(env->prog->aux)) {
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 8478d2c6ed5b..235841d23fe3 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -838,6 +838,44 @@ static bool stacksafe(struct bpf_verifier_env *env, =
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
+	if (old->incoming_stack_arg_depth !=3D cur->incoming_stack_arg_depth)
+		return false;
+
+	/* Compare both incoming and outgoing stack arg slots. */
+	if (old->stack_arg_depth !=3D cur->stack_arg_depth)
+		return false;
+
+	if (old->out_stack_arg_mask !=3D cur->out_stack_arg_mask)
+		return false;
+
+	nslots =3D old->stack_arg_depth / BPF_REG_SIZE;
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
@@ -929,6 +967,9 @@ static bool func_states_equal(struct bpf_verifier_env=
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
index f25a56cfabac..7a65b532e84a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1340,6 +1340,20 @@ static int copy_stack_state(struct bpf_func_state =
*dst, const struct bpf_func_st
 		return -ENOMEM;
=20
 	dst->allocated_stack =3D src->allocated_stack;
+
+	/* copy stack args state */
+	n =3D src->stack_arg_depth / BPF_REG_SIZE;
+	if (n) {
+		dst->stack_arg_regs =3D copy_array(dst->stack_arg_regs, src->stack_arg=
_regs, n,
+					     sizeof(struct bpf_reg_state),
+					     GFP_KERNEL_ACCOUNT);
+		if (!dst->stack_arg_regs)
+			return -ENOMEM;
+
+		dst->stack_arg_depth =3D src->stack_arg_depth;
+		dst->incoming_stack_arg_depth =3D src->incoming_stack_arg_depth;
+		dst->out_stack_arg_mask =3D src->out_stack_arg_mask;
+	}
 	return 0;
 }
=20
@@ -1381,6 +1395,25 @@ static int grow_stack_state(struct bpf_verifier_en=
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
+	state->stack_arg_regs =3D realloc_array(state->stack_arg_regs, old_n, n=
,
+					  sizeof(struct bpf_reg_state));
+	if (!state->stack_arg_regs)
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
@@ -1543,6 +1576,7 @@ static void free_func_state(struct bpf_func_state *=
state)
 {
 	if (!state)
 		return;
+	kfree(state->stack_arg_regs);
 	kfree(state->stack);
 	kfree(state);
 }
@@ -4215,6 +4249,13 @@ static int check_stack_read_fixed_off(struct bpf_v=
erifier_env *env,
 					}
 					if (type =3D=3D STACK_INVALID && env->allow_uninit_stack)
 						continue;
+					/*
+					 * Cross-frame reads may hit slots poisoned by dead code eliminatio=
n.
+					 * Static liveness can't track indirect references through pointers=
,
+					 * so allow the read conservatively.
+					 */
+					if (type =3D=3D STACK_POISON && reg_state !=3D state)
+						continue;
 					if (type =3D=3D STACK_POISON) {
 						verbose(env, "reading from stack off %d+%d size %d, slot poisoned =
by dead code elimination\n",
 							off, i, size);
@@ -4270,6 +4311,8 @@ static int check_stack_read_fixed_off(struct bpf_ve=
rifier_env *env,
 				continue;
 			if (type =3D=3D STACK_INVALID && env->allow_uninit_stack)
 				continue;
+			if (type =3D=3D STACK_POISON && reg_state !=3D state)
+				continue;
 			if (type =3D=3D STACK_POISON) {
 				verbose(env, "reading from stack off %d+%d size %d, slot poisoned by=
 dead code elimination\n",
 					off, i, size);
@@ -4424,6 +4467,123 @@ static int check_stack_write(struct bpf_verifier_=
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
+static int out_arg_idx_from_off(int off)
+{
+	return -off / BPF_REG_SIZE - 1;
+}
+
+static int out_arg_spi(const struct bpf_func_state *state, int idx)
+{
+	return state->incoming_stack_arg_depth / BPF_REG_SIZE + idx;
+}
+
+static u16 out_arg_req_mask(int nr_stack_arg_regs)
+{
+	return nr_stack_arg_regs ? (1U << nr_stack_arg_regs) - 1 : 0;
+}
+
+/*
+ * Write a value to the outgoing stack arg area.
+ * off is a negative offset from r11 (e.g. -8 for arg6, -16 for arg7).
+ * Callers ensure off < 0, 8-byte aligned, and size is BPF_REG_SIZE.
+ */
+static int check_stack_arg_write(struct bpf_verifier_env *env, struct bp=
f_func_state *state,
+				 int off, int value_regno)
+{
+	int max_stack_arg_regs =3D MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS;
+	int idx =3D out_arg_idx_from_off(off);
+	int spi =3D out_arg_spi(state, idx);
+	struct bpf_subprog_info *subprog;
+	struct bpf_func_state *cur;
+	int err;
+
+	if (idx >=3D max_stack_arg_regs) {
+		verbose(env, "stack arg write offset %d exceeds max %d stack args\n",
+			off, max_stack_arg_regs);
+		return -EINVAL;
+	}
+
+	err =3D grow_stack_arg_slots(env, state, state->incoming_stack_arg_dept=
h + (-off));
+	if (err)
+		return err;
+
+	/* Track the max outgoing stack arg access depth. */
+	subprog =3D &env->subprog_info[state->subprogno];
+	if (-off > subprog->max_out_stack_arg_depth)
+		subprog->max_out_stack_arg_depth =3D -off;
+
+	cur =3D env->cur_state->frame[env->cur_state->curframe];
+	if (value_regno >=3D 0) {
+		state->stack_arg_regs[spi] =3D cur->regs[value_regno];
+	} else {
+		/* BPF_ST: store immediate, treat as scalar */
+		struct bpf_reg_state *arg =3D &state->stack_arg_regs[spi];
+
+		arg->type =3D SCALAR_VALUE;
+		__mark_reg_known(arg, env->prog->insnsi[env->insn_idx].imm);
+	}
+	state->out_stack_arg_mask |=3D BIT(idx);
+	return 0;
+}
+
+/*
+ * Read a value from the incoming stack arg area.
+ * off is a positive offset from r11 (e.g. +8 for arg6, +16 for arg7).
+ * Callers ensure off > 0, 8-byte aligned, and size is BPF_REG_SIZE.
+ */
+static int check_stack_arg_read(struct bpf_verifier_env *env, struct bpf=
_func_state *state,
+				int off, int dst_regno)
+{
+	int spi =3D off / BPF_REG_SIZE - 1;
+	struct bpf_func_state *cur;
+	struct bpf_reg_state *arg;
+
+	if (off > state->incoming_stack_arg_depth) {
+		verbose(env, "invalid read from stack arg off %d depth %d\n",
+			off, state->incoming_stack_arg_depth);
+		return -EACCES;
+	}
+
+	arg =3D &state->stack_arg_regs[spi];
+	cur =3D env->cur_state->frame[env->cur_state->curframe];
+
+	if (is_spillable_regtype(arg->type))
+		copy_register_state(&cur->regs[dst_regno], arg);
+	else
+		mark_reg_unknown(env, cur->regs, dst_regno);
+	return 0;
+}
+
 static int check_map_access_type(struct bpf_verifier_env *env, struct bp=
f_reg_state *reg, u32 argno,
 				 int off, int size, enum bpf_access_type type)
 {
@@ -6606,10 +6766,23 @@ static int check_load_mem(struct bpf_verifier_env=
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
+	if (insn->src_reg =3D=3D BPF_REG_PARAMS) {
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
@@ -6638,10 +6811,23 @@ static int check_load_mem(struct bpf_verifier_env=
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
+		err =3D check_stack_arg_access(env, insn, "write");
+		if (err)
+			return err;
+		return check_stack_arg_write(env, state, insn->off, insn->src_reg);
+	}
+
 	/* check src1 operand */
 	err =3D check_reg_arg(env, insn->src_reg, SRC_OP);
 	if (err)
@@ -9327,6 +9513,20 @@ static int setup_func_entry(struct bpf_verifier_en=
v *env, int subprog, int calls
 	return err;
 }
=20
+static struct bpf_reg_state *get_func_arg_reg(struct bpf_verifier_env *e=
nv,
+					      struct bpf_reg_state *regs, int argno)
+{
+	struct bpf_func_state *caller;
+	int spi;
+
+	if (argno < MAX_BPF_FUNC_REG_ARGS)
+		return &regs[argno + 1];
+
+	caller =3D cur_func(env);
+	spi =3D out_arg_spi(caller, argno - MAX_BPF_FUNC_REG_ARGS);
+	return &caller->stack_arg_regs[spi];
+}
+
 static int btf_check_func_arg_match(struct bpf_verifier_env *env, int su=
bprog,
 				    const struct btf *btf,
 				    struct bpf_reg_state *regs)
@@ -9345,8 +9545,24 @@ static int btf_check_func_arg_match(struct bpf_ver=
ifier_env *env, int subprog,
 	 */
 	for (i =3D 0; i < sub->arg_cnt; i++) {
 		u32 argno =3D make_argno(i);
-		u32 regno =3D i + 1;
-		struct bpf_reg_state *reg =3D &regs[regno];
+		struct bpf_reg_state *reg;
+
+		if (i >=3D MAX_BPF_FUNC_REG_ARGS) {
+			struct bpf_func_state *caller =3D cur_func(env);
+			int spi =3D out_arg_spi(caller, i - MAX_BPF_FUNC_REG_ARGS);
+
+			/*
+			 * The compiler may constant-fold stack arg values into the
+			 * callee, eliminating the r11 stores. The BTF still declares
+			 * these parameters, but no outgoing stack slots exist.
+			 */
+			if (spi >=3D (caller->stack_arg_depth / BPF_REG_SIZE)) {
+				verbose(env, "stack %s not found in caller state\n",
+					reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+		}
+		reg =3D get_func_arg_reg(env, regs, i);
 		struct bpf_subprog_arg_info *arg =3D &sub->args[i];
=20
 		if (arg->arg_type =3D=3D ARG_ANYTHING) {
@@ -9534,8 +9750,10 @@ static int check_func_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
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
@@ -9587,6 +9805,15 @@ static int check_func_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
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
@@ -9640,6 +9867,7 @@ static int set_callee_state(struct bpf_verifier_env=
 *env,
 			    struct bpf_func_state *caller,
 			    struct bpf_func_state *callee, int insn_idx)
 {
+	struct bpf_subprog_info *callee_info;
 	int i;
=20
 	/* copy r1 - r5 args that callee can access.  The copy includes parent
@@ -9647,6 +9875,45 @@ static int set_callee_state(struct bpf_verifier_en=
v *env,
 	 */
 	for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++)
 		callee->regs[i] =3D caller->regs[i];
+
+	/*
+	 * Transfer stack args from caller's outgoing area to callee's incoming
+	 * area.
+	 *
+	 * Caller stores outgoing args at negative r11 offsets: -8 (arg6),
+	 * -16 (arg7), -24 (arg8), ...  In the caller's slot array, outgoing
+	 * spi 0 is arg6, spi 1 is arg7, and so on.
+	 *
+	 * Callee reads incoming args at positive r11 offsets: +8 (arg6),
+	 * +16 (arg7), ...  Incoming spi 0 is arg6.
+	 */
+	callee_info =3D &env->subprog_info[callee->subprogno];
+	if (callee_info->incoming_stack_arg_depth) {
+		int callee_incoming_slots =3D callee_info->incoming_stack_arg_depth / =
BPF_REG_SIZE;
+		u16 req_mask =3D out_arg_req_mask(callee_incoming_slots);
+		int err, caller_spi;
+
+		callee->incoming_stack_arg_depth =3D callee_info->incoming_stack_arg_d=
epth;
+		err =3D grow_stack_arg_slots(env, callee, callee_info->incoming_stack_=
arg_depth);
+		if (err)
+			return err;
+
+		if ((caller->out_stack_arg_mask & req_mask) !=3D req_mask) {
+			for (i =3D 0; i < callee_incoming_slots; i++) {
+				if (caller->out_stack_arg_mask & BIT(i))
+					continue;
+				verbose(env, "stack arg#%d not properly initialized\n",
+					i + MAX_BPF_FUNC_REG_ARGS + 1);
+				return -EINVAL;
+			}
+		}
+
+		for (i =3D 0; i < callee_incoming_slots; i++) {
+			caller_spi =3D out_arg_spi(caller, i);
+			callee->stack_arg_regs[i] =3D caller->stack_arg_regs[caller_spi];
+		}
+	}
+
 	return 0;
 }
=20
@@ -17649,6 +17916,17 @@ static int do_check_insn(struct bpf_verifier_env=
 *env, bool *do_print_state)
 		return check_store_reg(env, insn, false);
=20
 	case BPF_ST: {
+		/* Handle stack arg write (store immediate) */
+		if (insn->dst_reg =3D=3D BPF_REG_PARAMS) {
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
@@ -18807,7 +19085,7 @@ static int do_check_common(struct bpf_verifier_en=
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

