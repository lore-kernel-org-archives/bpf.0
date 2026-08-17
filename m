Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2881330216D
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 04:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786940538; cv=none; b=SdBY1GMsQmfh/fwCa5zdd7/RtB4Ej49ZkBt+iyPJYYeXf8kLNWRvQCVTzMe6EpoKHtrYSCs46INvvnIgMLYqsCDaeh7dRrZuuzz7oPAtvpcJr4yexxMERaAWMBd+fdFKjhRTuXkLrG1MxV2Ta1+Zwl25pVYPL6xFGgmGRoQJTBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786940538; c=relaxed/simple;
	bh=0kg8uuq4pf4lvdApeUbY3/99iD5nKrcZlAWIIShKkjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tf2cu90MajHvtd1p04eMs8AAqK27GJLIPu2f44tqpwypZXYgkp09phToCvBWcaKOOq4Hj0AeMPLfJC/aPu+N7ld+By4Hz5CwN4VhC875xIwcEwjILu9nLV5if2FRije3kW1uBeNd+eHq/8L9zoxd4Ulrw1CpDxK/xi+kuBA3Vqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 44E2D24982E84C; Sun, 16 Aug 2026 21:22:12 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 06/10] bpf: Add verifier support for 16-byte returns in R0:R2
Date: Sun, 16 Aug 2026 21:22:12 -0700
Message-ID: <20260817042212.2291498-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817042141.2286086-1-yonghong.song@linux.dev>
References: <20260817042141.2286086-1-yonghong.song@linux.dev>
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

Model that pair at calls to global and static BPF subprograms and at kfun=
c
calls: R2 is marked alongside R0 at the call, propagated out of a callee
at its exit, and held to the same scalar-only and no-stack-pointer rules
that already apply to R0. A struct returned by a kfunc must be composed o=
f
scalars, since its bytes reach the program as raw register contents and a
pointer field would otherwise be laundered into a scalar.

An extension program is the one caller of the convention that cannot take
part in it: only R0 is checked at its exit, since that is the program exi=
t
code, so it has no way to hand back an upper half. Replacing a function
whose return value is larger than 8 bytes is therefore rejected in
btf_check_func_type_match(). That function compares btf_type->info, which
carries no size for an int, so an 8 byte long and a 16 byte __int128
compared equal; sizes up to 8 bytes stay interchangeable, as they always
have been, so this only rejects what the R0:R2 convention newly makes
incompatible.

  [1] https://github.com/llvm/llvm-project/pull/190894
  [2] https://github.com/llvm/llvm-project/pull/206876

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/btf.c      |  6 ++++
 kernel/bpf/verifier.c | 68 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 67 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5b9d767895c9..2ae7cb9b30f2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7684,6 +7684,12 @@ static int btf_check_func_type_match(struct bpf_ve=
rifier_log *log,
 			btf_type_str(t2), fn2);
 		return -EINVAL;
 	}
+	if (btf_type_has_size(t1) && (t1->size > 8 || t2->size > 8)) {
+		bpf_log(log,
+			"Return type of %s() has size %u while %s() has size %u, and a size a=
bove 8 bytes cannot be replaced\n",
+			fn1, t1->size, fn2, t2->size);
+		return -EINVAL;
+	}
=20
 	for (i =3D 0; i < nargs1; i++) {
 		t1 =3D btf_type_skip_modifiers(btf1, args1[i].type, NULL);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 54aca6c30506..e371b7e27ec9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -415,6 +415,9 @@ static u32 ret_regs_cnt(u32 size)
 	return size > 8 && size <=3D 16 ? 2 : 1;
 }
=20
+/* Registers holding a function return value, in order. See ret_regs_cnt=
(). */
+static const int ret_regs[] =3D { BPF_REG_0, BPF_REG_2 };
+
 static int bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
 {
 	const struct btf *btf =3D env->prog->aux->btf;
@@ -9910,6 +9913,7 @@ static int check_func_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
 	u16 callee_incoming, stack_arg_cnt;
 	struct bpf_func_state *caller;
 	int err, subprog, target_insn;
+	u32 i, nregs;
=20
 	target_insn =3D *insn_idx + insn->imm + 1;
 	subprog =3D bpf_find_subprog(env, target_insn);
@@ -9965,9 +9969,14 @@ static int check_func_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
 		clear_caller_saved_regs(env, caller->regs);
 		invalidate_outgoing_stack_args(env, cur_func(env));
=20
-		/* All non-void global functions return a 64-bit SCALAR_VALUE. */
+		/*
+		 * A non-void global function returns a 64-bit SCALAR_VALUE in
+		 * R0, or a >8 byte SCALAR_VALUE in the R0:R2 register pair.
+		 */
 		if (!returns_void) {
-			mark_reg_unknown(env, caller->regs, BPF_REG_0);
+			nregs =3D bpf_ret_reg_pair(env, subprog) ? 2 : 1;
+			for (i =3D 0; i < nregs; i++)
+				mark_reg_unknown(env, caller->regs, ret_regs[i]);
 			bpf_diag_mod_end(env);
 		}
=20
@@ -10327,11 +10336,15 @@ static int prepare_func_exit(struct bpf_verifie=
r_env *env, int *insn_idx)
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
@@ -10366,9 +10379,13 @@ static int prepare_func_exit(struct bpf_verifier=
_env *env, int *insn_idx)
 			return -EFAULT;
 		}
 	} else {
-		/* return to the caller whatever r0 had in the callee */
+		/*
+		 * return to the caller whatever the callee had in the
+		 * return register(s)
+		 */
 		bpf_diag_mod_begin(env, &caller->regs[BPF_REG_0], r0, BPF_DIAG_MOD_WRI=
TE);
-		caller->regs[BPF_REG_0] =3D *r0;
+		for (i =3D 0; i < nregs; i++)
+			caller->regs[ret_regs[i]] =3D callee->regs[ret_regs[i]];
 		bpf_diag_mod_end(env);
 	}
=20
@@ -11303,6 +11320,19 @@ static int check_helper_call(struct bpf_verifier=
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
@@ -13967,10 +13997,25 @@ static int check_kfunc_call(struct bpf_verifier=
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
@@ -17538,11 +17583,20 @@ static int check_global_subprog_return_code(str=
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
--=20
2.53.0-Meta

