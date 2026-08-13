Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C613ED3CA
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651371; cv=none; b=rXMPyXBJeghd1tO8ctGLkAG7nFgcbDTk9tPNbRR4ZH5qLgNXrBXTIySNcVEHVwCSSYzE302V9Rlt9FtOUBLE1+2Aaj0AS35X/dEQCkC1dDSbjGWfjDYNvJGqm05/orzZX45WZXeE6Hmy/LfLy3h9bpZ3IL3g6JyEazpDkBUmwAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651371; c=relaxed/simple;
	bh=2Q+CEwAqurmbnF3Z/11uNswQakbYEDAb8+AtZdjfZH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkFEhOnWc9LvKzfAORONprPvIfWWoEEo1YUTO/QpPWlpTFpHM3sO1yz/J6j7mSWiJ8LP2AMarMg8/A+raAWKdSDfWgW7RnBt7LfcA6bqyN9qImNZ8r0KwQWReNoqS2qqQCVE6mvBxXuflx2oH6tb5R4nMjVkwW70zz9+IhbCTuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id BF89323E02F005; Thu, 13 Aug 2026 13:02:40 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 06/11] bpf: Add verifier support for 16-byte returns in R0:R2
Date: Thu, 13 Aug 2026 13:02:40 -0700
Message-ID: <20260813200240.1995795-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813200210.1991507-1-yonghong.song@linux.dev>
References: <20260813200210.1991507-1-yonghong.song@linux.dev>
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

This patch models that pair at calls to global and static BPF subprograms
and at kfunc calls: R2 is marked alongside R0 at the call, propagated out
of a callee at its exit, and held to the same scalar-only and no-stack-
pointer rules that R0 already is. A struct returned by a kfunc must be
composed of scalars, since its bytes reach the program as raw register
contents and a pointer field would otherwise be laundered into a scalar.

An extension program is the one caller of the convention that cannot take
part in it: its own return value is the program exit code, read out of R0
alone, so it has no way to hand back an upper half. Replacing a function
whose return value is larger than 8 bytes is therefore rejected with
-EOPNOTSUPP rather than supported.

  [1] https://github.com/llvm/llvm-project/pull/190894
  [2] https://github.com/llvm/llvm-project/pull/206876

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 75 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 161d77791bc6..0c68ab3bd6ce 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -412,6 +412,9 @@ static u32 ret_regs_cnt(u32 size)
 	return size > 8 && size <=3D 16 ? 2 : 1;
 }
=20
+/* Registers holding a function return value, in order. See ret_regs_cnt=
(). */
+static const int ret_regs[] =3D { BPF_REG_0, BPF_REG_2 };
+
 static void bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
 {
 	const struct btf *btf =3D env->prog->aux->btf;
@@ -9456,6 +9459,7 @@ static int check_func_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
 	u16 callee_incoming, stack_arg_cnt;
 	struct bpf_func_state *caller;
 	int err, subprog, target_insn;
+	u32 i, nregs;
=20
 	target_insn =3D *insn_idx + insn->imm + 1;
 	subprog =3D bpf_find_subprog(env, target_insn);
@@ -9498,9 +9502,14 @@ static int check_func_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
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
+			nregs =3D bpf_ret_reg_pair(env, subprog) ? 2 : 1;
+			for (i =3D 0; i < nregs; i++)
+				mark_reg_unknown(env, caller->regs, ret_regs[i]);
 		}
=20
 		if (env->subprog_info[subprog].might_throw) {
@@ -9858,11 +9867,15 @@ static int prepare_func_exit(struct bpf_verifier_=
env *env, int *insn_idx)
 	struct bpf_func_state *caller, *callee;
 	struct bpf_reg_state *r0;
 	bool in_callback_fn;
+	u32 i, nregs;
 	int err;
=20
 	callee =3D state->frame[state->curframe];
 	r0 =3D &callee->regs[BPF_REG_0];
-	if (r0->type =3D=3D PTR_TO_STACK) {
+	nregs =3D bpf_ret_reg_pair(env, callee->subprogno) ? 2 : 1;
+	for (i =3D 0; i < nregs; i++) {
+		if (callee->regs[ret_regs[i]].type !=3D PTR_TO_STACK)
+			continue;
 		/* technically it's ok to return caller's stack pointer
 		 * (or caller's caller's pointer) back to the caller,
 		 * since these pointers are valid. Only current stack
@@ -9897,8 +9910,12 @@ static int prepare_func_exit(struct bpf_verifier_e=
nv *env, int *insn_idx)
 			return -EFAULT;
 		}
 	} else {
-		/* return to the caller whatever r0 had in the callee */
-		caller->regs[BPF_REG_0] =3D *r0;
+		/*
+		 * return to the caller whatever the callee had in the
+		 * return register(s)
+		 */
+		for (i =3D 0; i < nregs; i++)
+			caller->regs[ret_regs[i]] =3D callee->regs[ret_regs[i]];
 	}
=20
 	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to call=
site,
@@ -10796,6 +10813,19 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
 	return 0;
 }
=20
+/*
+ * Mark the register(s) holding a @size byte kfunc return value as unkno=
wn
+ * scalars. Both halves of a register pair are treated the same way.
+ */
+static void mark_kfunc_ret_regs(struct bpf_verifier_env *env,
+				struct bpf_reg_state *regs, u32 size)
+{
+	u32 i, nregs =3D ret_regs_cnt(size);
+
+	for (i =3D 0; i < nregs; i++)
+		mark_reg_unknown(env, regs, ret_regs[i]);
+}
+
 static bool is_kfunc_acquire(struct bpf_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_ACQUIRE;
@@ -13265,10 +13295,25 @@ static int check_kfunc_call(struct bpf_verifier=
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
@@ -16746,11 +16791,20 @@ static int check_global_subprog_return_code(str=
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
+	nregs =3D bpf_ret_reg_pair(env, subprog) ? 2 : 1;
+	for (i =3D 0; i < nregs; i++) {
+		err =3D check_global_ret_scalar_reg(env, ret_regs[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
=20
 /* Bitmask with 1s for all caller saved registers */
@@ -19404,6 +19458,13 @@ int bpf_check_attach_target(struct bpf_verifier_=
log *log,
 			return -EOPNOTSUPP;
 		}
=20
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

