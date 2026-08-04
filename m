Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D24047DF97
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 20:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785875764; cv=none; b=r0oqs2k5zzzLIrKLaQ1ZSo45QV8x2LWv4Ct/W9oMrZFLPcdbb/Z76cp8OkRYTJoEh9Jv+nomAB5nU9QWO35JU+N8TEXUhv+e3528hBx7vIPdRfue9HoO22o3NhQcAFi40/6BPUyqZxFkhYEalB3DxxbAX95PIDFIz2dMleB8hFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785875764; c=relaxed/simple;
	bh=dMUOgZRUFgcqKjBb68075nDR8H++aPdz9WcLjwagWW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZzo9Ror6UWQ2fMJhFxgHUSPlCUuznYLZGDrjUB4Ngv+yfCEkX+8bqTYEWegr1GpTlU/ZkDZ0OTBNkQxMgohmAEKqoSZyRq2SVy2Z73/SRLRaX6L6fdRb6V0Sc5RrAO0nlPpYqA5P0PEoyG4KpsLszjkC2XjHVBWwELYkDvPKWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 7D98021FBFEF0C; Tue,  4 Aug 2026 13:35:58 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 07/13] bpf: Add verifier support for 16-byte returns in R0:R2
Date: Tue,  4 Aug 2026 13:35:58 -0700
Message-ID: <20260804203558.1873903-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804203522.1869244-1-yonghong.song@linux.dev>
References: <20260804203522.1869244-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

LLVM 23 added support for returning a value in two registers for an
__int128, or a struct/union whose size is greater than 8 but not more tha=
n
16 bytes. See LLVM patches [1] and [2].

Before LLVM 23 the BPF backend could not return these values at all. A
by-value struct or union return (of any size) was rejected at compile tim=
e
with:

  error: aggregate returns are not supported

and an __int128 return failed later in the backend with:

  fatal error: error in backend: unable to allocate function return #1

Both are resolved in LLVM 23, which lowers such returns into the R0:R2
register pair.

This patch adds handling for returns greater than 8 bytes in several
places: BPF subprogram returns (the main program, and both global and
static subprograms) and kfunc returns.

The R0:R2 convention is only implemented in the JIT. The BPF interpreter
has no notion of a second return register: a BPF-to-BPF call goes through
JMP_CALL_ARGS and a BPF_EXIT hands back BPF_R0 alone, so a caller reading
R2 would see a stale value. Force the JIT wherever a caller can observe t=
he
pair, that is at the call to a global subprogram in check_func_call() and
at the return from a static subprogram in prepare_func_exit(). Kfunc call=
s
need no separate handling since bpf_add_kfunc_call() already sets
jit_required for every kfunc call.

A by-value struct or union returned by a kfunc must be composed only of
scalars, since the verifier models the returned register bits as an unkno=
wn
scalar and a pointer field would otherwise be laundered into one, escapin=
g
provenance and reference tracking.

A global subprogram must return a scalar in every return register. The
existing exemption for arena pointers now applies only when the return
value fits in R0 alone: both halves of a register pair carry a piece of a
>8 byte scalar, so an arena pointer in either of them is a leak rather th=
an
a legitimate return value. A subprogram whose whole return value is an
arena pointer is unaffected.

A static subprogram is handled differently. The verifier walks into its
frame, so prepare_func_exit() propagates the return register(s) to the
caller. R0 holding a stack pointer has long been rejected outright there,
but R2 is deliberately not treated the same way. LLVM owns both sides of =
a
static call and is not bound by the ABI, so even with a 9..16 byte declar=
ed
return type it may leave R2 untouched when the caller only consumes the l=
ow
half; R2 can then hold an incidental stack pointer that is not a return
value at all, and rejecting the program would be a false positive.
Propagating the register as is would be worse: the callee frame is freed
immediately afterwards, leaving the caller with a PTR_TO_STACK that refer=
s
to a frame which no longer exists. So the caller's R2 is marked
uninitialized instead, and only a caller that actually reads the returned
upper half fails. As with R0, a pointer into the caller's own frame is
scrubbed too, which is conservative but keeps the two registers consisten=
t.

Once callers read R0:R2, an extension program can no longer replace a
function with a >8 byte return value: an extension's own return is
capped at 8 bytes by the program-exit check above, so it would leave R2
stale for the target's callers. btf_check_type_match() cannot catch
this, as it compares return types by btf_type->info only and an int
carries no vlen, so a 16-byte __int128 and an 8-byte long compare equal.
Reject such an attach in bpf_check_attach_target() instead.

  [1] https://github.com/llvm/llvm-project/pull/190894
  [2] https://github.com/llvm/llvm-project/pull/206876

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 138 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 124 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5584178a0e1c..60b9e587e094 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -418,6 +418,9 @@ static u32 ret_regs_cnt(u32 size)
 	return size > 8 && size <=3D 16 ? 2 : 1;
 }
=20
+/* Registers holding a function return value, in order. See ret_regs_cnt=
(). */
+static const int ret_regs[] =3D { BPF_REG_0, BPF_REG_2 };
+
 /*
  * Resolve the return convention of every subprogram once, so that
  * bpf_ret_reg_pair() is a plain flag test on the hot paths that use it.
@@ -9528,6 +9531,7 @@ static int check_func_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
 	u16 callee_incoming, stack_arg_cnt;
 	struct bpf_func_state *caller;
 	int err, subprog, target_insn;
+	u32 i, nregs;
=20
 	target_insn =3D *insn_idx + insn->imm + 1;
 	subprog =3D bpf_find_subprog(env, target_insn);
@@ -9570,10 +9574,24 @@ static int check_func_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn,
 		clear_caller_saved_regs(env, caller->regs);
 		invalidate_outgoing_stack_args(env, cur_func(env));
=20
-		/* All non-void global functions return a 64-bit SCALAR_VALUE. */
+		/*
+		 * A non-void global function returns a 64-bit SCALAR_VALUE in
+		 * R0, or a >8 byte SCALAR_VALUE in the R0:R2 register pair.
+		 */
 		if (!subprog_returns_void(env, subprog)) {
-			mark_reg_unknown(env, caller->regs, BPF_REG_0);
-			caller->regs[BPF_REG_0].subreg_def =3D DEF_NOT_SUBREG;
+			nregs =3D bpf_ret_reg_pair(env, subprog) ? 2 : 1;
+			/*
+			 * The R0:R2 return convention is only implemented in the
+			 * JIT: the interpreter propagates BPF_R0 alone out of a
+			 * subprogram, so a caller reading R2 would see a stale
+			 * value. Force the JIT once a caller can observe the pair.
+			 */
+			if (nregs > 1)
+				env->prog->jit_required =3D 1;
+			for (i =3D 0; i < nregs; i++) {
+				mark_reg_unknown(env, caller->regs, ret_regs[i]);
+				caller->regs[ret_regs[i]].subreg_def =3D DEF_NOT_SUBREG;
+			}
 		}
=20
 		if (env->subprog_info[subprog].might_throw) {
@@ -9895,10 +9913,14 @@ static int prepare_func_exit(struct bpf_verifier_=
env *env, int *insn_idx)
 	struct bpf_func_state *caller, *callee;
 	struct bpf_reg_state *r0;
 	bool in_callback_fn;
+	u32 i, nregs;
 	int err;
=20
 	callee =3D state->frame[state->curframe];
 	r0 =3D &callee->regs[BPF_REG_0];
+	nregs =3D bpf_ret_reg_pair(env, callee->subprogno) ? 2 : 1;
+	if (nregs > 1)
+		env->prog->jit_required =3D 1;
 	if (r0->type =3D=3D PTR_TO_STACK) {
 		/* technically it's ok to return caller's stack pointer
 		 * (or caller's caller's pointer) back to the caller,
@@ -9934,8 +9956,21 @@ static int prepare_func_exit(struct bpf_verifier_e=
nv *env, int *insn_idx)
 			return -EFAULT;
 		}
 	} else {
-		/* return to the caller whatever r0 had in the callee */
-		caller->regs[BPF_REG_0] =3D *r0;
+		/* return to the caller whatever the callee had in the
+		 * return register(s)
+		 */
+		for (i =3D 0; i < nregs; i++)
+			caller->regs[ret_regs[i]] =3D callee->regs[ret_regs[i]];
+
+		/* R2 carries only the upper half of a register pair return
+		 * value. A stack pointer must not escape the callee (see the
+		 * R0 case above), but there is no need to reject the whole
+		 * program for it: hand the caller an uninitialized R2 instead,
+		 * so that only a caller actually using the returned pointer
+		 * fails.
+		 */
+		if (nregs > 1 && caller->regs[BPF_REG_2].type =3D=3D PTR_TO_STACK)
+			bpf_mark_reg_not_init(env, &caller->regs[BPF_REG_2]);
 	}
=20
 	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to call=
site,
@@ -10835,6 +10870,14 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
 	return 0;
 }
=20
+/* Mark a register holding a @reg_size byte part of a function return va=
lue */
+static void mark_ret_reg_size(struct bpf_verifier_env *env, struct bpf_r=
eg_state *regs,
+			      u32 regno, size_t reg_size)
+{
+	regs[regno].subreg_def =3D reg_size =3D=3D sizeof(u64) ?
+		DEF_NOT_SUBREG : env->insn_idx + 1;
+}
+
 /* mark_btf_func_reg_size() is used when the reg size is determined by
  * the BTF func_proto's return value size and argument.
  */
@@ -10845,8 +10888,7 @@ static void __mark_btf_func_reg_size(struct bpf_v=
erifier_env *env, struct bpf_re
=20
 	if (regno =3D=3D BPF_REG_0) {
 		/* Function return value */
-		reg->subreg_def =3D reg_size =3D=3D sizeof(u64) ?
-			DEF_NOT_SUBREG : env->insn_idx + 1;
+		mark_ret_reg_size(env, regs, regno, reg_size);
 	} else if (reg_size =3D=3D sizeof(u64)) {
 		/* Function argument */
 		mark_insn_zext(env, reg);
@@ -10859,6 +10901,22 @@ static void mark_btf_func_reg_size(struct bpf_ve=
rifier_env *env, u32 regno,
 	return __mark_btf_func_reg_size(env, cur_regs(env), regno, reg_size);
 }
=20
+/* Mark the register(s) holding a @size byte kfunc return value as unkno=
wn
+ * scalars. All of them are processed the same way, only the size differ=
s:
+ * a single register may hold a sub-register sized value, while both hal=
ves
+ * of a register pair are treated as 64-bit wide.
+ */
+static void mark_kfunc_ret_regs(struct bpf_verifier_env *env,
+				struct bpf_reg_state *regs, u32 size)
+{
+	u32 i, nregs =3D ret_regs_cnt(size);
+
+	for (i =3D 0; i < nregs; i++) {
+		mark_reg_unknown(env, regs, ret_regs[i]);
+		mark_ret_reg_size(env, regs, ret_regs[i], nregs =3D=3D 1 ? size : size=
of(u64));
+	}
+}
+
 static bool is_kfunc_acquire(struct bpf_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_ACQUIRE;
@@ -13316,11 +13374,25 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
 	}
=20
 	if (btf_type_is_scalar(t)) {
-		mark_reg_unknown(env, regs, BPF_REG_0);
+		mark_kfunc_ret_regs(env, regs, t->size);
 		if (meta.btf =3D=3D btf_vmlinux && (meta.func_id =3D=3D special_kfunc_=
list[KF_bpf_res_spin_lock] ||
 		    meta.func_id =3D=3D special_kfunc_list[KF_bpf_res_spin_lock_irqsav=
e]))
 			__mark_reg_const_zero(env, &regs[BPF_REG_0]);
-		mark_btf_func_reg_size(env, BPF_REG_0, t->size);
+	} else if (btf_type_is_struct(t)) {
+		/*
+		 * The returned struct comes back as raw register bits modeled
+		 * as an unknown scalar, so it must contain only scalars:
+		 * otherwise a pointer field would be laundered into a scalar
+		 * and escape provenance and reference tracking.
+		 */
+		if (!__btf_type_is_scalar_struct(env, desc_btf, t, 0)) {
+			verbose(env,
+				"kernel function %s returns %s %s that is not composed of scalars\n"=
,
+				func_name, btf_type_str(t),
+				btf_name_by_offset(desc_btf, t->name_off));
+			return -EINVAL;
+		}
+		mark_kfunc_ret_regs(env, regs, t->size);
 	} else if (btf_type_is_ptr(t)) {
 		ptr_type =3D btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
 		err =3D check_special_kfunc(env, &meta, regs, insn_aux, ptr_type, desc=
_btf);
@@ -16800,7 +16872,8 @@ static int check_return_code(struct bpf_verifier_=
env *env, int regno, const char
 	return 0;
 }
=20
-static int check_global_ret_scalar_reg(struct bpf_verifier_env *env, u32=
 regno)
+static int check_global_ret_scalar_reg(struct bpf_verifier_env *env, u32=
 regno,
+				       bool allow_arena_ptr_return)
 {
 	struct bpf_reg_state *reg;
 	int err;
@@ -16810,7 +16883,7 @@ static int check_global_ret_scalar_reg(struct bpf=
_verifier_env *env, u32 regno)
 		return err;
=20
 	/* Pointers to arena are safe to pass between subprograms. */
-	if (is_arena_reg(env, regno))
+	if (allow_arena_ptr_return && is_arena_reg(env, regno))
 		return 0;
=20
 	if (is_pointer_value(env, regno)) {
@@ -16832,11 +16905,26 @@ static int check_global_subprog_return_code(str=
uct bpf_verifier_env *env)
 {
 	struct bpf_func_state *cur_frame =3D cur_func(env);
 	u32 subprog =3D cur_frame->subprogno;
+	u32 i, nregs;
+	int err;
=20
 	if (subprog_returns_void(env, subprog))
 		return 0;
=20
-	return check_global_ret_scalar_reg(env, BPF_REG_0);
+	/*
+	 * An arena pointer is only a legitimate return value when it is the
+	 * whole of it, that is when it is returned in R0 alone. Both halves of
+	 * a register pair carry a piece of a >8 byte scalar, so an arena
+	 * pointer in either of them is a leak.
+	 */
+	nregs =3D bpf_ret_reg_pair(env, subprog) ? 2 : 1;
+	for (i =3D 0; i < nregs; i++) {
+		err =3D check_global_ret_scalar_reg(env, ret_regs[i], nregs =3D=3D 1);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
=20
 /* Bitmask with 1s for all caller saved registers */
@@ -17326,10 +17414,16 @@ static int process_bpf_exit_full(struct bpf_ver=
ifier_env *env,
 	 */
 	if (cur_frame->subprogno &&
 	    !cur_frame->in_async_callback_fn &&
-	    !cur_frame->in_exception_callback_fn)
+	    !cur_frame->in_exception_callback_fn) {
 		err =3D check_global_subprog_return_code(env);
-	else
+	} else {
+		if (!cur_frame->subprogno && bpf_ret_reg_pair(env, 0)) {
+			verbose(env,
+				"return value larger than 8 bytes is not supported at program exit\n=
");
+			return -EINVAL;
+		}
 		err =3D check_return_code(env, BPF_REG_0, "R0");
+	}
 	if (err)
 		return err;
 	return PROCESS_BPF_EXIT;
@@ -19462,6 +19556,22 @@ int bpf_check_attach_target(struct bpf_verifier_=
log *log,
 			return -EOPNOTSUPP;
 		}
=20
+		/*
+		 * An extension replaces the target outright, so it has to match
+		 * the target's return convention. Its own return value is capped
+		 * at 8 bytes (a >8 byte program return is rejected at BPF_EXIT),
+		 * so it can never fill the R0:R2 pair the target's callers read.
+		 * This cannot be left to btf_check_type_match() above, which
+		 * compares return types by btf_type->info only: an int carries no
+		 * vlen, so a 16-byte __int128 and an 8-byte long compare equal.
+		 */
+		if (prog_extension && tgt_info->fmodel.ret_size > 8) {
+			bpf_log(log,
+				"Cannot replace function %s with a >8 byte return value\n",
+				tname);
+			return -EOPNOTSUPP;
+		}
+
 		/*
 		 * *.multi programs don't need an address during program
 		 * verification, we just take the module ref if needed.
--=20
2.53.0-Meta

