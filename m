Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C957C9475
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 05:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775970030; cv=none; b=LDzY3fILx1bitjjbP0mRyl+WaGtBNOyEXueEqRIUbbwJVtN6dohYKUreg5gaj06fYwjQJoTMcgxQ70PoPbvjBSgTVm+gFEAQg2RckQflqdPyrzVvHp/h3BVBTDbWoGiIwTBfcmbRUIIMGMC2gvXQl5rRc3fc7ubpvSFRGlfc42w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775970030; c=relaxed/simple;
	bh=sg5FTnjNe5uEJ7qMxSDMA8P8tYqbFDr2UwdZ20s7mOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1lDvbH+7z7a7wzAnnIk9VPkYoN2Ms2UO172gal+GkVxOtsv1YSpX6/7u7uoZrKVGkt+eNoK6l8MFOlNDSmhC6iV8O2Lp95TMjMr8TZrrbYR3hWs+L9ZrgNQFNDT3aN9/R5BZ8zOClIBz7kQS6H4Cus27OrDpupGvzMNkFjm0Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id D424E3B021C25; Sat, 11 Apr 2026 22:00:15 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 13/18] bpf: Support stack arguments for kfunc calls
Date: Sat, 11 Apr 2026 22:00:15 -0700
Message-ID: <20260412050015.267072-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260412045826.254200-1-yonghong.song@linux.dev>
References: <20260412045826.254200-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Extend the stack argument mechanism to kfunc calls, allowing kfuncs
with more than 5 parameters to receive additional arguments via the
r12-based stack arg area.

For kfuncs, the caller is a BPF program and the callee is a kernel
function. The BPF program writes outgoing args at negative r12
offsets, following the same convention as BPF-to-BPF calls:

  Outgoing: r12 - N*8 (arg6), ..., r12 - 8 (last arg)

The following is an example:

  int foo(int a1, int a2, int a3, int a4, int a5, int a6, int a7) {
    ...
    kfunc1(a1, a2, a3, a4, a5, a6, a7, a8);
    ...
    kfunc2(a1, a2, a3, a4, a5, a6, a7, a8, a9);
    ...
  }

   Caller (foo)
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   Incoming (positive offsets):
     r12+8:  [incoming arg 6]
     r12+16: [incoming arg 7]

   Outgoing for kfunc1 (negative offsets):
     r12-24: [outgoing arg 6]
     r12-16: [outgoing arg 7]
     r12-8:  [outgoing arg 8]

   Outgoing for kfunc2 (negative offsets):
     r12-32: [outgoing arg 6]
     r12-24: [outgoing arg 7]
     r12-16: [outgoing arg 8]
     r12-8:  [outgoing arg 9]

Later JIT will marshal outgoing arguments to the native calling
convention for kfunc1() and kfunc2().

There are two places where meta->release_regno needs to keep
regno for later releasing the reference. Also, 'cur_aux(env)->arg_prog =3D=
 regno'
is also keeping regno for later fixup. Since regno is greater than 5,
such three cases are rejected for now if they are in stack arguments.
If possible, new kfuncs could keep them in first 5 registers so
there are no issues at all.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 104 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 85 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 45987041bb2a..206ffbd9596d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8885,8 +8885,6 @@ static int check_kfunc_mem_size_reg(struct bpf_veri=
fier_env *env, struct bpf_reg
 	struct bpf_call_arg_meta meta;
 	int err;
=20
-	WARN_ON_ONCE(mem_argno > BPF_REG_3);
-
 	memset(&meta, 0, sizeof(meta));
=20
 	if (may_be_null) {
@@ -13163,6 +13161,20 @@ static bool is_kfunc_pkt_changing(struct bpf_kfu=
nc_call_arg_meta *meta)
 	return meta->func_id =3D=3D special_kfunc_list[KF_bpf_xdp_pull_data];
 }
=20
+static struct bpf_reg_state *get_kfunc_arg_reg(struct bpf_verifier_env *=
env,
+					       int argno, int nargs)
+{
+	struct bpf_func_state *caller;
+	int spi;
+
+	if (argno < MAX_BPF_FUNC_REG_ARGS)
+		return &cur_regs(env)[argno + 1];
+
+	caller =3D cur_func(env);
+	spi =3D caller->incoming_stack_arg_depth / BPF_REG_SIZE + (nargs - 1 - =
argno);
+	return &caller->stack_arg_slots[spi].spilled_ptr;
+}
+
 static enum kfunc_ptr_arg_type
 get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 		       struct bpf_kfunc_call_arg_meta *meta,
@@ -13170,8 +13182,6 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *e=
nv,
 		       const char *ref_tname, const struct btf_param *args,
 		       int argno, int nargs, struct bpf_reg_state *reg)
 {
-	u32 regno =3D argno + 1;
-	struct bpf_reg_state *regs =3D cur_regs(env);
 	bool arg_mem_size =3D false;
=20
 	if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
@@ -13180,8 +13190,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *e=
nv,
 		return KF_ARG_PTR_TO_CTX;
=20
 	if (argno + 1 < nargs &&
-	    (is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1=
]) ||
-	     is_kfunc_arg_const_mem_size(meta->btf, &args[argno + 1], &regs[reg=
no + 1])))
+	    (is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], get_kfunc_arg_r=
eg(env, argno + 1, nargs)) ||
+	     is_kfunc_arg_const_mem_size(meta->btf, &args[argno + 1], get_kfunc=
_arg_reg(env, argno + 1, nargs))))
 		arg_mem_size =3D true;
=20
 	/* In this function, we verify the kfunc's BTF as per the argument type=
,
@@ -13848,9 +13858,9 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
=20
 	args =3D (const struct btf_param *)(meta->func_proto + 1);
 	nargs =3D btf_type_vlen(meta->func_proto);
-	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
+	if (nargs > MAX_BPF_FUNC_ARGS) {
 		verbose(env, "Function %s has %d > %d args\n", func_name, nargs,
-			MAX_BPF_FUNC_REG_ARGS);
+			MAX_BPF_FUNC_ARGS);
 		return -EINVAL;
 	}
=20
@@ -13858,19 +13868,42 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
 	 * verifier sees.
 	 */
 	for (i =3D 0; i < nargs; i++) {
-		struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &regs[i + 1];
+		struct bpf_reg_state *regs =3D cur_regs(env), *reg;
 		const struct btf_type *t, *ref_t, *resolve_ret;
 		enum bpf_arg_type arg_type =3D ARG_DONTCARE;
-		u32 regno =3D i + 1, ref_id, type_size;
+		struct bpf_reg_state tmp_reg;
+		int regno =3D i + 1;
+		u32 ref_id, type_size;
 		bool is_ret_buf_sz =3D false;
 		int kf_arg_type;
=20
+		if (i < MAX_BPF_FUNC_REG_ARGS) {
+			reg =3D &regs[i + 1];
+		} else {
+			/* Retrieve the spilled reg state from the stack arg slot. */
+			struct bpf_func_state *caller =3D cur_func(env);
+			int spi =3D caller->incoming_stack_arg_depth / BPF_REG_SIZE + (nargs =
- 1 - i);
+
+			if (!is_stack_arg_slot_initialized(caller, spi)) {
+				verbose(env, "stack arg#%d not properly initialized\n", i);
+				return -EINVAL;
+			}
+
+			tmp_reg =3D caller->stack_arg_slots[spi].spilled_ptr;
+			reg =3D &tmp_reg;
+			regno =3D -1;
+		}
+
 		if (is_kfunc_arg_prog_aux(btf, &args[i])) {
 			/* Reject repeated use bpf_prog_aux */
 			if (meta->arg_prog) {
 				verifier_bug(env, "Only 1 prog->aux argument supported per-kfunc");
 				return -EFAULT;
 			}
+			if (regno < 0) {
+				verbose(env, "arg#%d prog->aux cannot be a stack argument\n", i);
+				return -EINVAL;
+			}
 			meta->arg_prog =3D true;
 			cur_aux(env)->arg_prog =3D regno;
 			continue;
@@ -13896,9 +13929,11 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
 					verbose(env, "arg#%d must be a known constant\n", i);
 					return -EINVAL;
 				}
-				ret =3D mark_chain_precision(env, regno);
-				if (ret < 0)
-					return ret;
+				if (regno > 0) {
+					ret =3D mark_chain_precision(env, regno);
+					if (ret < 0)
+						return ret;
+				}
 				meta->arg_constant.found =3D true;
 				meta->arg_constant.value =3D reg->var_off.value;
 			} else if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdonly_buf_s=
ize")) {
@@ -13920,9 +13955,11 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
 				}
=20
 				meta->r0_size =3D reg->var_off.value;
-				ret =3D mark_chain_precision(env, regno);
-				if (ret)
-					return ret;
+				if (regno > 0) {
+					ret =3D mark_chain_precision(env, regno);
+					if (ret)
+						return ret;
+				}
 			}
 			continue;
 		}
@@ -13946,8 +13983,13 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
 				return -EFAULT;
 			}
 			meta->ref_obj_id =3D reg->ref_obj_id;
-			if (is_kfunc_release(meta))
+			if (is_kfunc_release(meta)) {
+				if (regno < 0) {
+					verbose(env, "arg#%d release arg cannot be a stack argument\n", i);
+					return -EINVAL;
+				}
 				meta->release_regno =3D regno;
+			}
 		}
=20
 		ref_t =3D btf_type_skip_modifiers(btf, t->type, &ref_id);
@@ -14100,6 +14142,10 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
 				dynptr_arg_type |=3D DYNPTR_TYPE_FILE;
 			} else if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_dynptr_file=
_discard]) {
 				dynptr_arg_type |=3D DYNPTR_TYPE_FILE;
+				if (regno < 0) {
+					verbose(env, "arg#%d release arg cannot be a stack argument\n", i);
+					return -EINVAL;
+				}
 				meta->release_regno =3D regno;
 			} else if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_dynptr_clon=
e] &&
 				   (dynptr_arg_type & MEM_UNINIT)) {
@@ -14247,9 +14293,9 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 			break;
 		case KF_ARG_PTR_TO_MEM_SIZE:
 		{
-			struct bpf_reg_state *buff_reg =3D &regs[regno];
+			struct bpf_reg_state *buff_reg =3D reg;
 			const struct btf_param *buff_arg =3D &args[i];
-			struct bpf_reg_state *size_reg =3D &regs[regno + 1];
+			struct bpf_reg_state *size_reg =3D get_kfunc_arg_reg(env, i + 1, narg=
s);
 			const struct btf_param *size_arg =3D &args[i + 1];
=20
 			if (!register_is_null(buff_reg) || !is_kfunc_arg_nullable(meta->btf, =
buff_arg)) {
@@ -15152,6 +15198,16 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
 			mark_btf_func_reg_size(env, regno, t->size);
 	}
=20
+	/* Track outgoing stack arg depth for kfuncs with >5 args */
+	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
+		struct bpf_func_state *caller =3D cur_func(env);
+		struct bpf_subprog_info *caller_info =3D &env->subprog_info[caller->su=
bprogno];
+		u16 kfunc_stack_arg_depth =3D (nargs - MAX_BPF_FUNC_REG_ARGS) * BPF_RE=
G_SIZE;
+
+		if (kfunc_stack_arg_depth > caller_info->outgoing_stack_arg_depth)
+			caller_info->outgoing_stack_arg_depth =3D kfunc_stack_arg_depth;
+	}
+
 	if (is_iter_next_kfunc(&meta)) {
 		err =3D process_iter_next_call(env, insn_idx, &meta);
 		if (err)
@@ -24167,6 +24223,16 @@ static int fixup_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
 	if (!bpf_jit_supports_far_kfunc_call())
 		insn->imm =3D BPF_CALL_IMM(desc->addr);
=20
+	/*
+	 * After resolving the kfunc address, insn->off is no longer needed
+	 * for BTF fd index. Repurpose it to store the number of stack args
+	 * so the JIT can marshal them.
+	 */
+	if (desc->func_model.nr_args > MAX_BPF_FUNC_REG_ARGS)
+		insn->off =3D desc->func_model.nr_args - MAX_BPF_FUNC_REG_ARGS;
+	else
+		insn->off =3D 0;
+
 	if (is_bpf_obj_new_kfunc(desc->func_id) || is_bpf_percpu_obj_new_kfunc(=
desc->func_id)) {
 		struct btf_struct_meta *kptr_struct_meta =3D env->insn_aux_data[insn_i=
dx].kptr_struct_meta;
 		struct bpf_insn addr[2] =3D { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struc=
t_meta) };
--=20
2.52.0

