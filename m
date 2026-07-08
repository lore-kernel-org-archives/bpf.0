Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7883E5A08
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 20:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541407; cv=none; b=pI3XHZVfU8/GCDIrP372sBFev0+dn+Rz1N4rLxvfGzHlUEPEDOetmpuKmDWOeFNEkPAUh+ZKvSg/Gv4YUdN/PpePo04QFnULZ1GgGioQWpvux8C+s2+HeKDXemcS8ATrtfwG7gGmrEgCqi3IZHmH/IwXz4ZCmJmKXv4b8O029xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541407; c=relaxed/simple;
	bh=TUHpXKR5lE7TIBrUTA2Ijan4nP3XjGYe7ThgS9GSsnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LX3ijuuelRlN6M9BjhG3aGhfTM2jArFtdiAgyX3Zws0Wlg28GfkJGZ4IlRM1/9zbFbtNi1BaoaJ98H2A9PI214/j4Dv920/YQPoqCFAucE4O9hEuqEz+/wc3Rj9pdTsRTVznnbNDTLUkZ8dptGgolC0WkJbRYNsc5ptd1gqUczY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E06B51D0B6F78D; Wed,  8 Jul 2026 13:09:49 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 02/12] bpf: Add verifier support for 16-byte returns in R0:R2
Date: Wed,  8 Jul 2026 13:09:49 -0700
Message-ID: <20260708200949.2156169-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708200939.2153664-1-yonghong.song@linux.dev>
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

LLVM 23 added support for returning a value in two registers for an
__int128, or a struct/union whose size is greater than 8 but not more
than 16 bytes. See LLVM patches [1] and [2].

Before LLVM 23 the BPF backend could not return these values at all. A
by-value struct or union return (of any size) was rejected at compile
time with:

  error: aggregate returns are not supported

and an __int128 return failed later in the backend with:

  fatal error: error in backend: unable to allocate function return #1

Both are resolved in LLVM 23, which lowers such returns into the R0:R2
register pair.

This patch is one of several preparation patches that build up
<=3D16 byte return support incrementally:
  - the verifier R0:R2 modelling in this patch,
  - the x86 JIT move and JIT-capability gate,
  - precision-backtracking and live-register tracking of R2,
  - forcing the JIT for such programs, and
  - guarding the trampoline paths.
Finally, the patch "bpf: Enable 16-byte aggregate return types" enables
support for 16-byte returns.

This patch adds handling for '>8' byte returns in several places: BPF
subprogram returns (the main program, and both global and static
subprograms) and kfunc returns.

  [1] https://github.com/llvm/llvm-project/pull/190894
  [2] https://github.com/llvm/llvm-project/pull/206876

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 93 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 88 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3f34ce1a3107..03ffb5f839fa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -424,6 +424,35 @@ static bool subprog_returns_void(struct bpf_verifier=
_env *env, int subprog)
 	return btf_type_is_void(type);
 }
=20
+static bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int subprog)
+{
+	const struct btf_type *type, *func, *func_proto;
+	const struct btf *btf =3D env->prog->aux->btf;
+	u32 btf_id;
+
+	if (!btf || !env->prog->aux->func_info)
+		return false;
+
+	btf_id =3D env->prog->aux->func_info[subprog].type_id;
+
+	func =3D btf_type_by_id(btf, btf_id);
+	if (!func)
+		return false;
+
+	func_proto =3D btf_type_by_id(btf, func->type);
+	if (!func_proto)
+		return false;
+
+	type =3D btf_type_skip_modifiers(btf, func_proto->type, NULL);
+	if (!type)
+		return false;
+
+	if (btf_type_is_struct(type) || btf_type_is_scalar(type))
+		return type->size > 8 && type->size <=3D 16;
+
+	return false;
+}
+
 static const char *subprog_name(const struct bpf_verifier_env *env, int =
subprog)
 {
 	struct bpf_func_info *info;
@@ -9459,10 +9488,17 @@ static int check_func_call(struct bpf_verifier_en=
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
 			mark_reg_unknown(env, caller->regs, BPF_REG_0);
 			caller->regs[BPF_REG_0].subreg_def =3D DEF_NOT_SUBREG;
+			if (bpf_ret_reg_pair(env, subprog)) {
+				mark_reg_unknown(env, caller->regs, BPF_REG_2);
+				caller->regs[BPF_REG_2].subreg_def =3D DEF_NOT_SUBREG;
+			}
 		}
=20
 		if (env->subprog_info[subprog].might_throw) {
@@ -9825,6 +9861,13 @@ static int prepare_func_exit(struct bpf_verifier_e=
nv *env, int *insn_idx)
 	} else {
 		/* return to the caller whatever r0 had in the callee */
 		caller->regs[BPF_REG_0] =3D *r0;
+		if (bpf_ret_reg_pair(env, callee->subprogno)) {
+			if (callee->regs[BPF_REG_2].type =3D=3D PTR_TO_STACK) {
+				verbose(env, "cannot return stack pointer to the caller\n");
+				return -EINVAL;
+			}
+			caller->regs[BPF_REG_2] =3D callee->regs[BPF_REG_2];
+		}
 	}
=20
 	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to call=
site,
@@ -10745,6 +10788,18 @@ static void mark_btf_func_reg_size(struct bpf_ve=
rifier_env *env, u32 regno,
 	return __mark_btf_func_reg_size(env, cur_regs(env), regno, reg_size);
 }
=20
+static void mark_kfunc_ret_reg_size(struct bpf_verifier_env *env,
+				    struct bpf_reg_state *regs, u32 size)
+{
+	if (size > 8) {
+		mark_btf_func_reg_size(env, BPF_REG_0, 8);
+		mark_reg_unknown(env, regs, BPF_REG_2);
+		regs[BPF_REG_2].subreg_def =3D DEF_NOT_SUBREG;
+	} else {
+		mark_btf_func_reg_size(env, BPF_REG_0, size);
+	}
+}
+
 static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_ACQUIRE;
@@ -13208,7 +13263,22 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
 		if (meta.btf =3D=3D btf_vmlinux && (meta.func_id =3D=3D special_kfunc_=
list[KF_bpf_res_spin_lock] ||
 		    meta.func_id =3D=3D special_kfunc_list[KF_bpf_res_spin_lock_irqsav=
e]))
 			__mark_reg_const_zero(env, &regs[BPF_REG_0]);
-		mark_btf_func_reg_size(env, BPF_REG_0, t->size);
+		mark_kfunc_ret_reg_size(env, regs, t->size);
+	} else if (btf_type_is_struct(t)) {
+		/*
+		 * The returned struct comes back as raw register bits modeled
+		 * as an unknown scalar, so it must contain only scalars:
+		 * otherwise a pointer field would be laundered into a scalar
+		 * and escape provenance and reference tracking.
+		 */
+		if (!__btf_type_is_scalar_struct(env, desc_btf, t, 0)) {
+			verbose(env, "kernel function %s returns %s %s that is not composed o=
f scalars\n",
+				func_name, btf_type_str(t),
+				btf_name_by_offset(desc_btf, t->name_off));
+			return -EINVAL;
+		}
+		mark_reg_unknown(env, regs, BPF_REG_0);
+		mark_kfunc_ret_reg_size(env, regs, t->size);
 	} else if (btf_type_is_ptr(t)) {
 		ptr_type =3D btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
 		err =3D check_special_kfunc(env, &meta, regs, insn_aux, ptr_type, desc=
_btf);
@@ -16711,11 +16781,19 @@ static int check_global_subprog_return_code(str=
uct bpf_verifier_env *env)
 {
 	struct bpf_func_state *cur_frame =3D cur_func(env);
 	u32 subprog =3D cur_frame->subprogno;
+	int err;
=20
 	if (subprog_returns_void(env, subprog))
 		return 0;
=20
-	return check_global_ret_scalar_reg(env, BPF_REG_0);
+	err =3D check_global_ret_scalar_reg(env, BPF_REG_0);
+	if (err)
+		return err;
+
+	if (!bpf_ret_reg_pair(env, subprog))
+		return 0;
+
+	return check_global_ret_scalar_reg(env, BPF_REG_2);
 }
=20
 /* Bitmask with 1s for all caller saved registers */
@@ -17205,10 +17283,15 @@ static int process_bpf_exit_full(struct bpf_ver=
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
+			verbose(env, "return value larger than 8 bytes is not supported at pr=
ogram exit\n");
+			return -EINVAL;
+		}
 		err =3D check_return_code(env, BPF_REG_0, "R0");
+	}
 	if (err)
 		return err;
 	return PROCESS_BPF_EXIT;
--=20
2.53.0-Meta

