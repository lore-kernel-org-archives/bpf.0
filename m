Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E401C372ECB
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 05:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778477614; cv=none; b=dO2ksf51z1D42JtqQzr06FPcwTdkiDnQuZNsY57LMLIFAoWHZTZVwlzcLTFPpsKSu7hrGFRfOz4cYVoNHqWpLpB2T7enN/VP+DUiNUOmOaKy6hG/APSDpmElYVpmaCGkuI+k+INX/cbOK2cHAQF19kSmYMCfTq4B84IBcHSM4XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778477614; c=relaxed/simple;
	bh=KZ5t13oe6QmihBOlREae4E/ln9y/HTvFCxWS5EPq6VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rG3/Eg+yJI39aycm92weVA20trmS4+WkW9D1NExQJ7V8yJvC9uHUaSaKS1ZhYFRsyreS7b6Qqvsg2o5BSUImGkAhkG4M5NGRpgH9s8dPm7cj+kiv193Kju7cTxPZ6QGG4u62uPFd3l+W56H32rp2JFBpVOBy1UEgyoL4f0eqeMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 9C153A59DB7D1; Sun, 10 May 2026 22:33:27 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 05/24] bpf: Support stack arguments for bpf functions
Date: Sun, 10 May 2026 22:33:27 -0700
Message-ID: <20260511053327.1883871-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260511053301.1878610-1-yonghong.song@linux.dev>
References: <20260511053301.1878610-1-yonghong.song@linux.dev>
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
out_stack_arg_cnt in bpf_func_state, separately from the regular
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

A separate max_out_stack_arg_cnt field in bpf_subprog_info tracks
the deepest outgoing slot actually written. This intends to
reject programs that write to slots beyond what any callee expects.
It is necessary for JIT.

Similar to typical compiler generated code, enforce the following
orderings:
  - all stack arg reads must be ahead of any stack arg write
  - all stack arg reads must be before any bpf func, kfunc and helpers
This is needed as JIT may emit 'mov' insns for read/write with
the same register and bpf function, kfunc and helper will invalidate
all arguments immediately after the call.

Callback functions with stack arguments need kernel setup parameter
types (including stack parameters) properly and then callback function
can retrieve such information for verification purpose.

Global subprogs and freplace with >5 args are not yet supported.

  [1] https://github.com/llvm/llvm-project/pull/189060
  [2] https://lore.kernel.org/bpf/20260423033506.2542005-1-yonghong.song@=
linux.dev/

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |  37 ++++++-
 kernel/bpf/btf.c             |  14 ++-
 kernel/bpf/fixups.c          |  16 ++-
 kernel/bpf/states.c          |  29 +++++
 kernel/bpf/verifier.c        | 198 ++++++++++++++++++++++++++++++++++-
 5 files changed, 282 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 321b9d69cf9c..f9020a4ea005 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -402,6 +402,7 @@ struct bpf_func_state {
 	bool in_callback_fn;
 	bool in_async_callback_fn;
 	bool in_exception_callback_fn;
+	bool no_stack_arg_load;
 	/* For callback calling functions that limit number of possible
 	 * callback executions (e.g. bpf_loop) keeps track of current
 	 * simulated iteration number.
@@ -427,6 +428,9 @@ struct bpf_func_state {
 	 * `stack`. allocated_stack is always a multiple of BPF_REG_SIZE.
 	 */
 	int allocated_stack;
+
+	u16 out_stack_arg_cnt; /* Number of outgoing on-stack argument slots */
+	struct bpf_reg_state *stack_arg_regs; /* Outgoing on-stack arguments */
 };
=20
 #define MAX_CALL_FRAMES 8
@@ -561,12 +565,27 @@ bpf_get_spilled_reg(int slot, struct bpf_func_state=
 *frame, u32 mask)
 	return NULL;
 }
=20
+static inline struct bpf_reg_state *
+bpf_get_spilled_stack_arg(int slot, struct bpf_func_state *frame, u32 ma=
sk)
+{
+	if (slot < frame->out_stack_arg_cnt &&
+	    frame->stack_arg_regs[slot].type !=3D NOT_INIT)
+		return &frame->stack_arg_regs[slot];
+	return NULL;
+}
+
 /* Iterate over 'frame', setting 'reg' to either NULL or a spilled regis=
ter. */
 #define bpf_for_each_spilled_reg(iter, frame, reg, mask)			\
 	for (iter =3D 0, reg =3D bpf_get_spilled_reg(iter, frame, mask);		\
 	     iter < frame->allocated_stack / BPF_REG_SIZE;		\
 	     iter++, reg =3D bpf_get_spilled_reg(iter, frame, mask))
=20
+/* Iterate over 'frame', setting 'reg' to either NULL or a spilled stack=
 arg. */
+#define bpf_for_each_spilled_stack_arg(iter, frame, reg, mask)         \
+	for (iter =3D 0, reg =3D bpf_get_spilled_stack_arg(iter, frame, mask); =
\
+	     iter < frame->out_stack_arg_cnt;              \
+	     iter++, reg =3D bpf_get_spilled_stack_arg(iter, frame, mask))
+
 #define bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, __mask, _=
_expr)   \
 	({                                                               \
 		struct bpf_verifier_state *___vstate =3D __vst;            \
@@ -584,6 +603,11 @@ bpf_get_spilled_reg(int slot, struct bpf_func_state =
*frame, u32 mask)
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
@@ -799,12 +823,21 @@ struct bpf_subprog_info {
 	bool keep_fastcall_stack: 1;
 	bool changes_pkt_data: 1;
 	bool might_sleep: 1;
-	u8 arg_cnt:3;
+	u8 arg_cnt:4;
=20
 	enum priv_stack_mode priv_stack_mode;
-	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
+	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_ARGS];
+	u16 stack_arg_cnt; /* incoming + max outgoing */
+	u16 max_out_stack_arg_cnt;
 };
=20
+static inline u16 bpf_in_stack_arg_cnt(struct bpf_subprog_info *sub)
+{
+	if (sub->arg_cnt > MAX_BPF_FUNC_REG_ARGS)
+		return sub->arg_cnt - MAX_BPF_FUNC_REG_ARGS;
+	return 0;
+}
+
 struct bpf_verifier_env;
=20
 struct backtrack_state {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a33a5b4122f8..ec3fb8c8f4ee 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7881,10 +7881,16 @@ int btf_prepare_func_args(struct bpf_verifier_env=
 *env, int subprog)
 	args =3D (const struct btf_param *)(t + 1);
 	nargs =3D btf_type_vlen(t);
 	sub->arg_cnt =3D nargs;
-	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
-		if (!is_global)
-			return -EINVAL;
-		bpf_log(log, "Global function %s() with %d > %d args. Buggy compiler.\=
n",
+	if (nargs > MAX_BPF_FUNC_ARGS) {
+		bpf_log(log, "kernel supports at most %d parameters, function %s has %=
d\n",
+			MAX_BPF_FUNC_ARGS, tname, nargs);
+		return -EFAULT;
+	}
+	if (nargs > MAX_BPF_FUNC_REG_ARGS)
+		sub->stack_arg_cnt =3D nargs - MAX_BPF_FUNC_REG_ARGS;
+
+	if (is_global && nargs > MAX_BPF_FUNC_REG_ARGS) {
+		bpf_log(log, "global function %s has %d > %d args, stack args not supp=
orted\n",
 			tname, nargs, MAX_BPF_FUNC_REG_ARGS);
 		return -EINVAL;
 	}
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index fba9e8c00878..ba86039789fd 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1378,9 +1378,21 @@ int bpf_fixup_call_args(struct bpf_verifier_env *e=
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
+		u16 outgoing =3D subprog->stack_arg_cnt - bpf_in_stack_arg_cnt(subprog=
);
+
+		if (subprog->max_out_stack_arg_cnt > outgoing) {
+			verbose(env,
+				"func#%d writes %u stack arg slots, but calls only require %u\n",
+				i, subprog->max_out_stack_arg_cnt, outgoing);
+			return -EINVAL;
+		}
+	}
=20
 	if (env->prog->jit_requested &&
 	    !bpf_prog_is_offloaded(env->prog->aux)) {
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index bd9c22945050..c249eb40c6d6 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -833,6 +833,32 @@ static bool stacksafe(struct bpf_verifier_env *env, =
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
+	nslots =3D max(old->out_stack_arg_cnt, cur->out_stack_arg_cnt);
+	for (i =3D 0; i < nslots; i++) {
+		struct bpf_reg_state *old_arg, *cur_arg;
+		struct bpf_reg_state not_init =3D { .type =3D NOT_INIT };
+
+		old_arg =3D i < old->out_stack_arg_cnt ?
+			  &old->stack_arg_regs[i] : &not_init;
+		cur_arg =3D i < cur->out_stack_arg_cnt ?
+			  &cur->stack_arg_regs[i] : &not_init;
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
@@ -924,6 +950,9 @@ static bool func_states_equal(struct bpf_verifier_env=
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
index 3bafb7ad2ba7..4ba7510bc87c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1362,6 +1362,18 @@ static int copy_stack_state(struct bpf_func_state =
*dst, const struct bpf_func_st
 		return -ENOMEM;
=20
 	dst->allocated_stack =3D src->allocated_stack;
+
+	/* copy stack args state */
+	n =3D src->out_stack_arg_cnt;
+	if (n) {
+		dst->stack_arg_regs =3D copy_array(dst->stack_arg_regs, src->stack_arg=
_regs, n,
+						 sizeof(struct bpf_reg_state),
+						 GFP_KERNEL_ACCOUNT);
+		if (!dst->stack_arg_regs)
+			return -ENOMEM;
+	}
+
+	dst->out_stack_arg_cnt =3D src->out_stack_arg_cnt;
 	return 0;
 }
=20
@@ -1403,6 +1415,23 @@ static int grow_stack_state(struct bpf_verifier_en=
v *env, struct bpf_func_state
 	return 0;
 }
=20
+static int grow_stack_arg_slots(struct bpf_verifier_env *env,
+				struct bpf_func_state *state, int cnt)
+{
+	size_t old_n =3D state->out_stack_arg_cnt;
+
+	if (old_n >=3D cnt)
+		return 0;
+
+	state->stack_arg_regs =3D realloc_array(state->stack_arg_regs, old_n, c=
nt,
+					      sizeof(struct bpf_reg_state));
+	if (!state->stack_arg_regs)
+		return -ENOMEM;
+
+	state->out_stack_arg_cnt =3D cnt;
+	return 0;
+}
+
 /* Acquire a pointer id from the env and update the state->refs to inclu=
de
  * this new pointer reference.
  * On success, returns a valid pointer id to associate with the register
@@ -1565,6 +1594,7 @@ static void free_func_state(struct bpf_func_state *=
state)
 {
 	if (!state)
 		return;
+	kfree(state->stack_arg_regs);
 	kfree(state->stack);
 	kfree(state);
 }
@@ -4050,6 +4080,103 @@ static int check_stack_write(struct bpf_verifier_=
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
+				 int off, struct bpf_reg_state *value_reg)
+{
+	int max_stack_arg_regs =3D MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS;
+	struct bpf_subprog_info *subprog =3D &env->subprog_info[state->subprogn=
o];
+	int spi =3D -off / BPF_REG_SIZE - 1;
+	struct bpf_reg_state *arg;
+	int err;
+
+	if (spi >=3D max_stack_arg_regs) {
+		verbose(env, "stack arg write offset %d exceeds max %d stack args\n",
+			off, max_stack_arg_regs);
+		return -EINVAL;
+	}
+
+	err =3D grow_stack_arg_slots(env, state, spi + 1);
+	if (err)
+		return err;
+
+	/* Track the max outgoing stack arg slot count. */
+	if (spi + 1 > subprog->max_out_stack_arg_cnt)
+		subprog->max_out_stack_arg_cnt =3D spi + 1;
+
+	if (value_reg) {
+		state->stack_arg_regs[spi] =3D *value_reg;
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
+	if (spi + 1 > bpf_in_stack_arg_cnt(subprog)) {
+		verbose(env, "invalid read from stack arg off %d depth %d\n",
+			off, bpf_in_stack_arg_cnt(subprog) * BPF_REG_SIZE);
+		return -EACCES;
+	}
+
+	caller =3D vstate->frame[vstate->curframe - 1];
+	arg =3D &caller->stack_arg_regs[spi];
+	cur =3D vstate->frame[vstate->curframe];
+	cur->regs[dst_regno] =3D *arg;
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
+		if (spi >=3D caller->out_stack_arg_cnt ||
+		    caller->stack_arg_regs[spi].type =3D=3D NOT_INIT) {
+			verbose(env, "caller expects %d args, stack arg%d is not initialized\=
n",
+				nargs, spi + 1);
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
@@ -6217,10 +6344,20 @@ static int check_load_mem(struct bpf_verifier_env=
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
+	if (is_stack_arg_ldx(insn)) {
+		err =3D check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
+		if (err)
+			return err;
+		return check_stack_arg_read(env, state, insn->off, insn->dst_reg);
+	}
+
 	/* check src operand */
 	err =3D check_reg_arg(env, insn->src_reg, SRC_OP);
 	if (err)
@@ -6249,10 +6386,20 @@ static int check_load_mem(struct bpf_verifier_env=
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
+	if (is_stack_arg_stx(insn)) {
+		err =3D check_reg_arg(env, insn->src_reg, SRC_OP);
+		if (err)
+			return err;
+		return check_stack_arg_write(env, state, insn->off, regs + insn->src_r=
eg);
+	}
+
 	/* check src1 operand */
 	err =3D check_reg_arg(env, insn->src_reg, SRC_OP);
 	if (err)
@@ -8860,6 +9007,14 @@ static void clear_caller_saved_regs(struct bpf_ver=
ifier_env *env,
 	}
 }
=20
+static void invalidate_outgoing_stack_args(struct bpf_func_state *state)
+{
+	int i, nslots =3D state->out_stack_arg_cnt;
+
+	for (i =3D 0; i < nslots; i++)
+		state->stack_arg_regs[i].type =3D NOT_INIT;
+}
+
 typedef int (*set_callee_state_fn)(struct bpf_verifier_env *env,
 				   struct bpf_func_state *caller,
 				   struct bpf_func_state *callee,
@@ -8922,6 +9077,7 @@ static int btf_check_func_arg_match(struct bpf_veri=
fier_env *env, int subprog,
 				    struct bpf_reg_state *regs)
 {
 	struct bpf_subprog_info *sub =3D subprog_info(env, subprog);
+	struct bpf_func_state *caller =3D cur_func(env);
 	struct bpf_verifier_log *log =3D &env->log;
 	u32 i;
 	int ret;
@@ -8930,13 +9086,16 @@ static int btf_check_func_arg_match(struct bpf_ve=
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
@@ -9124,6 +9283,8 @@ static int check_func_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
 			   int *insn_idx)
 {
 	struct bpf_verifier_state *state =3D env->cur_state;
+	struct bpf_subprog_info *caller_info;
+	u16 callee_incoming, stack_arg_cnt;
 	struct bpf_func_state *caller;
 	int err, subprog, target_insn;
=20
@@ -9177,6 +9338,16 @@ static int check_func_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
 		return 0;
 	}
=20
+	/*
+	 * Track caller's total stack arg count (incoming + max outgoing).
+	 * This is needed so the JIT knows how much stack arg space to allocate=
.
+	 */
+	caller_info =3D &env->subprog_info[caller->subprogno];
+	callee_incoming =3D bpf_in_stack_arg_cnt(&env->subprog_info[subprog]);
+	stack_arg_cnt =3D bpf_in_stack_arg_cnt(caller_info) + callee_incoming;
+	if (stack_arg_cnt > caller_info->stack_arg_cnt)
+		caller_info->stack_arg_cnt =3D stack_arg_cnt;
+
 	/* for regular function entry setup new frame and continue
 	 * from that frame.
 	 */
@@ -9534,6 +9705,7 @@ static int prepare_func_exit(struct bpf_verifier_en=
v *env, int *insn_idx)
 	 * bpf_throw, this will be done by copy_verifier_state for extra frames=
. */
 	free_func_state(callee);
 	state->frame[state->curframe--] =3D NULL;
+	invalidate_outgoing_stack_args(caller);
=20
 	/* for callbacks widen imprecise scalars to make programs like below ve=
rify:
 	 *
@@ -16961,6 +17133,14 @@ static int do_check_insn(struct bpf_verifier_env=
 *env, bool *do_print_state)
 		return check_store_reg(env, insn, false);
=20
 	case BPF_ST: {
+		/* Handle stack arg write (store immediate) */
+		if (is_stack_arg_st(insn)) {
+			struct bpf_verifier_state *vstate =3D env->cur_state;
+			struct bpf_func_state *state =3D vstate->frame[vstate->curframe];
+
+			return check_stack_arg_write(env, state, insn->off, NULL);
+		}
+
 		enum bpf_reg_type dst_reg_type;
=20
 		err =3D check_reg_arg(env, insn->dst_reg, SRC_OP);
@@ -16995,6 +17175,7 @@ static int do_check_insn(struct bpf_verifier_env =
*env, bool *do_print_state)
 				}
 			}
 			mark_reg_scratched(env, BPF_REG_0);
+			cur_func(env)->no_stack_arg_load =3D true;
 			if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
 				return check_func_call(env, insn, &env->insn_idx);
 			if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL)
@@ -18110,7 +18291,7 @@ static int do_check_common(struct bpf_verifier_en=
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
@@ -18153,6 +18334,12 @@ static int do_check_common(struct bpf_verifier_e=
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
@@ -18160,8 +18347,11 @@ static int do_check_common(struct bpf_verifier_e=
nv *env, int subprog)
 		 */
 		if (env->prog->aux->func_info_aux) {
 			ret =3D btf_prepare_func_args(env, 0);
-			if (ret || sub->arg_cnt !=3D 1 || sub->args[0].arg_type !=3D ARG_PTR_=
TO_CTX)
+			if (ret || sub->arg_cnt !=3D 1 || sub->args[0].arg_type !=3D ARG_PTR_=
TO_CTX) {
 				env->prog->aux->func_info_aux[0].unreliable =3D true;
+				sub->arg_cnt =3D 1;
+				sub->stack_arg_cnt =3D 0;
+			}
 		}
=20
 		/* 1st arg to a function */
--=20
2.53.0-Meta

