Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF2130BB94
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 05:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776836554; cv=none; b=JrBPiYIZDoddbcxkJjegf/5FZrrahjrqvSLxE0sqX9+tPaEvrRflsxWjHLhcBxwRuk+lZ2PCMojgI7f9hdnylOar2L3QhbkeT4RmuDRptqdoRR611YHvx0FA8hHxyNHKPALdMU879FFkDpzBLfT/da85PzSVal052t5RzaIrBC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776836554; c=relaxed/simple;
	bh=Bu5ylxyZLFf9jFgeuElx3RSsl1/8R0hURufP4x+zliQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTIpvL/+W2b26b+/cfvtICnqasEnQr1UN2nZmSHlo53hDuMwIIZgDhZEqEt5ZDaik444PqX5R85R97PIWQN0fVSGPj3m8Q9S7DvtVJ+78z0cD8+qaVAaB0ifL1pggX61oUSFa10Inbfs2W44jyBrsm4Ar7+PyJr12BN6Pi5ISK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id BF32244D0843C; Tue, 21 Apr 2026 22:42:19 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v2 6/9] bpf: Rename existing argno to arg
Date: Tue, 21 Apr 2026 22:42:19 -0700
Message-ID: <20260422054219.3127560-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260422054149.3124342-1-yonghong.song@linux.dev>
References: <20260422054149.3124342-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To support stack arguments, in later patches, argno will represent
both registers and stack arguments. To avoid confusion, rename
existing argno to arg.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 54 +++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a7ef3c770c24..c777a294302a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11301,9 +11301,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *e=
nv,
 		       struct bpf_kfunc_call_arg_meta *meta,
 		       const struct btf_type *t, const struct btf_type *ref_t,
 		       const char *ref_tname, const struct btf_param *args,
-		       int argno, int nargs, struct bpf_reg_state *reg)
+		       int arg, int nargs, struct bpf_reg_state *reg)
 {
-	u32 regno =3D argno + 1;
+	u32 regno =3D arg + 1;
 	struct bpf_reg_state *regs =3D cur_regs(env);
 	bool arg_mem_size =3D false;
=20
@@ -11312,9 +11312,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *e=
nv,
 	    meta->func_id =3D=3D special_kfunc_list[KF_bpf_session_cookie])
 		return KF_ARG_PTR_TO_CTX;
=20
-	if (argno + 1 < nargs &&
-	    (is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1=
]) ||
-	     is_kfunc_arg_const_mem_size(meta->btf, &args[argno + 1], &regs[reg=
no + 1])))
+	if (arg + 1 < nargs &&
+	    (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1], &regs[regno + 1])=
 ||
+	     is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1], &regs[regno=
 + 1])))
 		arg_mem_size =3D true;
=20
 	/* In this function, we verify the kfunc's BTF as per the argument type=
,
@@ -11322,68 +11322,68 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env =
*env,
 	 * type to our caller. When a set of conditions hold in the BTF type of
 	 * arguments, we resolve it to a known kfunc_ptr_arg_type.
 	 */
-	if (btf_is_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env=
->prog), argno))
+	if (btf_is_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env=
->prog), arg))
 		return KF_ARG_PTR_TO_CTX;
=20
-	if (is_kfunc_arg_nullable(meta->btf, &args[argno]) && bpf_register_is_n=
ull(reg) &&
+	if (is_kfunc_arg_nullable(meta->btf, &args[arg]) && bpf_register_is_nul=
l(reg) &&
 	    !arg_mem_size)
 		return KF_ARG_PTR_TO_NULL;
=20
-	if (is_kfunc_arg_alloc_obj(meta->btf, &args[argno]))
+	if (is_kfunc_arg_alloc_obj(meta->btf, &args[arg]))
 		return KF_ARG_PTR_TO_ALLOC_BTF_ID;
=20
-	if (is_kfunc_arg_refcounted_kptr(meta->btf, &args[argno]))
+	if (is_kfunc_arg_refcounted_kptr(meta->btf, &args[arg]))
 		return KF_ARG_PTR_TO_REFCOUNTED_KPTR;
=20
-	if (is_kfunc_arg_dynptr(meta->btf, &args[argno]))
+	if (is_kfunc_arg_dynptr(meta->btf, &args[arg]))
 		return KF_ARG_PTR_TO_DYNPTR;
=20
-	if (is_kfunc_arg_iter(meta, argno, &args[argno]))
+	if (is_kfunc_arg_iter(meta, arg, &args[arg]))
 		return KF_ARG_PTR_TO_ITER;
=20
-	if (is_kfunc_arg_list_head(meta->btf, &args[argno]))
+	if (is_kfunc_arg_list_head(meta->btf, &args[arg]))
 		return KF_ARG_PTR_TO_LIST_HEAD;
=20
-	if (is_kfunc_arg_list_node(meta->btf, &args[argno]))
+	if (is_kfunc_arg_list_node(meta->btf, &args[arg]))
 		return KF_ARG_PTR_TO_LIST_NODE;
=20
-	if (is_kfunc_arg_rbtree_root(meta->btf, &args[argno]))
+	if (is_kfunc_arg_rbtree_root(meta->btf, &args[arg]))
 		return KF_ARG_PTR_TO_RB_ROOT;
=20
-	if (is_kfunc_arg_rbtree_node(meta->btf, &args[argno]))
+	if (is_kfunc_arg_rbtree_node(meta->btf, &args[arg]))
 		return KF_ARG_PTR_TO_RB_NODE;
=20
-	if (is_kfunc_arg_const_str(meta->btf, &args[argno]))
+	if (is_kfunc_arg_const_str(meta->btf, &args[arg]))
 		return KF_ARG_PTR_TO_CONST_STR;
=20
-	if (is_kfunc_arg_map(meta->btf, &args[argno]))
+	if (is_kfunc_arg_map(meta->btf, &args[arg]))
 		return KF_ARG_PTR_TO_MAP;
=20
-	if (is_kfunc_arg_wq(meta->btf, &args[argno]))
+	if (is_kfunc_arg_wq(meta->btf, &args[arg]))
 		return KF_ARG_PTR_TO_WORKQUEUE;
=20
-	if (is_kfunc_arg_timer(meta->btf, &args[argno]))
+	if (is_kfunc_arg_timer(meta->btf, &args[arg]))
 		return KF_ARG_PTR_TO_TIMER;
=20
-	if (is_kfunc_arg_task_work(meta->btf, &args[argno]))
+	if (is_kfunc_arg_task_work(meta->btf, &args[arg]))
 		return KF_ARG_PTR_TO_TASK_WORK;
=20
-	if (is_kfunc_arg_irq_flag(meta->btf, &args[argno]))
+	if (is_kfunc_arg_irq_flag(meta->btf, &args[arg]))
 		return KF_ARG_PTR_TO_IRQ_FLAG;
=20
-	if (is_kfunc_arg_res_spin_lock(meta->btf, &args[argno]))
+	if (is_kfunc_arg_res_spin_lock(meta->btf, &args[arg]))
 		return KF_ARG_PTR_TO_RES_SPIN_LOCK;
=20
 	if ((base_type(reg->type) =3D=3D PTR_TO_BTF_ID || reg2btf_ids[base_type=
(reg->type)])) {
 		if (!btf_type_is_struct(ref_t)) {
 			verbose(env, "kernel function %s args#%d pointer type %s %s is not su=
pported\n",
-				meta->func_name, argno, btf_type_str(ref_t), ref_tname);
+				meta->func_name, arg, btf_type_str(ref_t), ref_tname);
 			return -EINVAL;
 		}
 		return KF_ARG_PTR_TO_BTF_ID;
 	}
=20
-	if (is_kfunc_arg_callback(env, meta->btf, &args[argno]))
+	if (is_kfunc_arg_callback(env, meta->btf, &args[arg]))
 		return KF_ARG_PTR_TO_CALLBACK;
=20
 	/* This is the catch all argument type of register types supported by
@@ -11394,7 +11394,7 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *e=
nv,
 	if (!btf_type_is_scalar(ref_t) && !__btf_type_is_scalar_struct(env, met=
a->btf, ref_t, 0) &&
 	    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
 		verbose(env, "arg#%d pointer type %s %s must point to %sscalar, or str=
uct with scalar\n",
-			argno, btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
+			arg, btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
 		return -EINVAL;
 	}
 	return arg_mem_size ? KF_ARG_PTR_TO_MEM_SIZE : KF_ARG_PTR_TO_MEM;
@@ -11405,7 +11405,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bp=
f_verifier_env *env,
 					const struct btf_type *ref_t,
 					const char *ref_tname, u32 ref_id,
 					struct bpf_kfunc_call_arg_meta *meta,
-					int argno)
+					int arg)
 {
 	const struct btf_type *reg_ref_t;
 	bool strict_type_match =3D false;
@@ -11464,7 +11464,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bp=
f_verifier_env *env,
 	taking_projection =3D btf_is_projection_of(ref_tname, reg_ref_tname);
 	if (!taking_projection && !struct_same) {
 		verbose(env, "kernel function %s args#%d expected pointer to %s %s but=
 R%d has a pointer to %s %s\n",
-			meta->func_name, argno, btf_type_str(ref_t), ref_tname, argno + 1,
+			meta->func_name, arg, btf_type_str(ref_t), ref_tname, arg + 1,
 			btf_type_str(reg_ref_t), reg_ref_tname);
 		return -EINVAL;
 	}
--=20
2.52.0

