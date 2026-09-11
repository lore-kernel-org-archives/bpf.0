Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828A5493D54
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141803; cv=none; b=TSgfLv3lhnJ/ZGxYlZQSL0WKIDVeVsv3GMVyNOAkiRHzgYtXKQ97LI9cKb1BBv9aYiB287sbWwQDASlbJdTYgDvHkfsfabD7miqthdY1B6IYAk6jqVEi7x/Y0Cyk+PLEUMo/ZzegdESvXyf7ouSz5WbNRg3IkgLhvefsyxGxkNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141803; c=relaxed/simple;
	bh=flLDG5nJUhl26Ap8DcH3zGtzwIdey3uzewYFvFWV0VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6SPkYsThadzwRXBDsTvBCRVSpuyY4QvhRPuJ2oiZpC6A+ejYrLExVNygpn+v5YGQC9H2Pcl228z8EDQ0Y3ezDI/xDZm1/gmnABxtq0fHpwDDrS9307Tsxf+Ke4VIc9LFGs9eXezDJThUoDg8MJSs8XC0RHushtL5ZmlO4GGf64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id F2CD02A1843051; Fri, 11 Sep 2026 08:49:54 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 08/15] bpf: Recognize by-value struct and __int128 kfunc arguments
Date: Fri, 11 Sep 2026 08:49:54 -0700
Message-ID: <20260911154954.2008505-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260911154914.2004336-1-yonghong.song@linux.dev>
References: <20260911154914.2004336-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A kfunc taking a struct or union by value is rejected today, and one
taking an __int128 is accepted but mis-counted:

  Unrecognized R2 type STRUCT

The kfunc arguments walk the same slot as a BPF-to-BPF call:
one argument register per eightbyte, and a 16-byte value takes two.
The outgoing stack argument count at the call site follows the slots for
the same reason. Similar to BPF-to-BPF aggregate handling, a kfunc
aggregate argument is only supported when it is composed of scalars.
Everything that maps a kfunc argument to a register has to follow the
slots too.

An argument of a single eightbyte lands in the same place under every
calling convention, so those are taken. The conventions the JIT has to
reconcile do not agree on where a larger one goes, so refuse it for now
with

  Function f arg#1 type INT cannot be passed at argument slot 1 on this
  architecture

which the next patch turns into an answer from the JIT. The paths that
handle a two-slot argument are therefore unreachable until then.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 177 +++++++++++++++++++++++++++++++++---------
 1 file changed, 141 insertions(+), 36 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c520c37bb3c9..9e70995c763f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12149,12 +12149,36 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_call_=
arg_meta *meta)
 	return meta->func_id =3D=3D special_kfunc_list[KF_bpf_xdp_pull_data];
 }
=20
+/*
+ * The slots a parameter takes, from its BTF type. This has to agree wit=
h
+ * btf_func_model_arg_slots(), which answers the same from the size the
+ * func model recorded, or the verifier would check an argument at a slo=
t
+ * the JIT does not place it at.
+ */
+static u32 kfunc_arg_slots(const struct btf_type *t)
+{
+	if (btf_type_is_int(t) || btf_type_is_struct(t))
+		return (t->size + BPF_REG_SIZE - 1) / BPF_REG_SIZE;
+	return 1;
+}
+
+static u32 kfunc_proto_slots(const struct btf *btf, const struct btf_typ=
e *func_proto)
+{
+	const struct btf_param *args =3D btf_params(func_proto);
+	u32 i, nargs =3D btf_type_vlen(func_proto), slots_used =3D 0;
+
+	for (i =3D 0; i < nargs; i++)
+		slots_used +=3D kfunc_arg_slots(btf_type_skip_modifiers(btf, args[i].t=
ype, NULL));
+
+	return slots_used;
+}
+
 static int
 get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_met=
a *meta,
-		   const struct btf_param *args, int arg, int nargs)
+		   const struct btf_param *args, int arg, int nargs, u32 slot)
 {
 	const struct btf_type *t, *ref_t =3D NULL;
-	argno_t argno =3D argno_from_arg(arg + 1);
+	argno_t argno =3D argno_from_arg(slot + 1);
 	const char *ref_tname =3D NULL;
 	int arg_type;
=20
@@ -12174,6 +12198,23 @@ get_kfunc_arg_type(struct bpf_verifier_env *env,=
 struct bpf_call_arg_meta *meta,
 		return KF_ARG_ANYTHING;
 	}
=20
+	if (btf_type_is_struct(t)) {
+		if (!t->size || t->size > 2 * BPF_REG_SIZE) {
+			verbose(env,
+				"%s type %s has size %u, only 1 to %d bytes "
+				"can be passed by value\n",
+				reg_arg_name(env, argno), btf_type_str(t), t->size,
+				2 * BPF_REG_SIZE);
+			return -EINVAL;
+		}
+		if (!btf_type_is_scalar_struct(env, meta->btf, t)) {
+			verbose(env, "%s type %s is not composed of scalars\n",
+				reg_arg_name(env, argno), btf_type_str(t));
+			return -EINVAL;
+		}
+		return KF_ARG_ANYTHING;
+	}
+
 	if (!btf_type_is_ptr(t)) {
 		verbose(env, "Unrecognized %s type %s\n",
 			reg_arg_name(env, argno), btf_type_str(t));
@@ -12289,7 +12330,7 @@ static int gen_kfunc_arg_proto(struct bpf_verifie=
r_env *env, struct bpf_call_arg
 {
 	const struct btf *btf =3D meta->btf;
 	const struct btf_param *args;
-	u32 i, nargs;
+	u32 i, nargs, slots_used;
 	int arg_type;
=20
 	args =3D (const struct btf_param *)(meta->func_proto + 1);
@@ -12305,19 +12346,44 @@ static int gen_kfunc_arg_proto(struct bpf_verif=
ier_env *env, struct bpf_call_arg
 		return -ENOTSUPP;
 	}
=20
-	for (i =3D 0; i < nargs; i++) {
+	for (i =3D 0, slots_used =3D 0; i < nargs; i++) {
+		const struct btf_type *t;
+		u32 nslots;
+
+		t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
+		nslots =3D kfunc_arg_slots(t);
+		/*
+		 * The calling conventions the JIT has to reconcile do not
+		 * agree on where an argument of more than one eightbyte goes,
+		 * so refuse one until the JIT can say where this arch puts it.
+		 */
+		if (nslots > 1) {
+			verbose(env,
+				"Function %s arg#%d type %s cannot be passed at "
+				"argument slot %d on this architecture\n",
+				meta->func_name, i, btf_type_str(t), slots_used);
+			return -EINVAL;
+		}
+		slots_used +=3D nslots;
+
 		if (is_kfunc_arg_prog_aux(btf, &args[i]) ||
 		    is_kfunc_arg_ignore(btf, &args[i]) ||
 		    is_kfunc_arg_implicit(meta, i))
 			continue;
=20
-		arg_type =3D get_kfunc_arg_type(env, meta, args, i, nargs);
+		arg_type =3D get_kfunc_arg_type(env, meta, args, i, nargs, slots_used =
- nslots);
 		if (arg_type < 0)
 			return arg_type;
=20
 		proto->arg_type[i] =3D arg_type;
 	}
=20
+	if (slots_used > MAX_BPF_FUNC_REG_ARGS && !bpf_jit_supports_stack_args(=
)) {
+		verbose(env, "JIT does not support kfunc %s() with %d argument slots\n=
",
+			meta->func_name, slots_used);
+		return -ENOTSUPP;
+	}
+
 	return 0;
 }
=20
@@ -12883,6 +12949,26 @@ static bool check_css_task_iter_allowlist(struct=
 bpf_verifier_env *env)
 	}
 }
=20
+/* The argument slot @slot of the call has to hold a scalar. */
+static int check_kfunc_scalar_arg(struct bpf_verifier_env *env, struct b=
pf_func_state *caller,
+				  struct bpf_reg_state *regs, u32 slot, int insn_idx,
+				  const char *func_name)
+{
+	struct bpf_reg_state *reg =3D get_func_arg_reg(caller, regs, slot);
+	argno_t argno =3D argno_from_arg(slot + 1);
+
+	if (reg->type =3D=3D SCALAR_VALUE)
+		return 0;
+
+	verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
+	bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
+			      "Pass an integer scalar value for this argument, not a pointer =
or resource object.",
+			      "the kfunc expects an integer scalar, but %s is %s",
+			      reg_arg_name(env, argno),
+			      bpf_diag_reg_type_plain(env, reg->type));
+	return -EINVAL;
+}
+
 static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_cal=
l_arg_meta *meta,
 			    int insn_idx)
 {
@@ -12892,29 +12978,35 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_call_arg_me
 	const struct btf *btf =3D meta->btf;
 	const struct btf_param *args;
 	struct btf_record *rec;
-	u32 i, nargs;
+	u32 i, k, nargs, proto_slots, slots_used, prev_slot =3D 0, nslots =3D 0=
;
 	int ret;
=20
 	args =3D (const struct btf_param *)(meta->func_proto + 1);
 	nargs =3D btf_type_vlen(meta->func_proto);
+	proto_slots =3D kfunc_proto_slots(btf, meta->func_proto);
=20
-	ret =3D check_outgoing_stack_args(env, caller, nargs, func_name, btf, a=
rgs);
+	ret =3D check_outgoing_stack_args(env, caller, proto_slots, func_name, =
btf,
+					proto_slots =3D=3D nargs ? args : NULL);
 	if (ret)
 		return ret;
=20
 	/* Check that BTF function arguments match actual types that the
 	 * verifier sees.
 	 */
-	for (i =3D 0; i < nargs; i++) {
-		struct bpf_reg_state *reg =3D get_func_arg_reg(caller, regs, i);
+	for (i =3D 0, slots_used =3D 0; i < nargs;
+	     i++, prev_slot =3D slots_used, slots_used +=3D nslots) {
+		struct bpf_reg_state *reg =3D get_func_arg_reg(caller, regs, slots_use=
d);
 		const struct btf_type *t, *ref_t, *resolve_ret;
 		enum bpf_arg_type arg_type =3D ARG_DONTCARE;
-		argno_t argno =3D argno_from_arg(i + 1);
+		argno_t argno =3D argno_from_arg(slots_used + 1);
 		int regno =3D reg_from_argno(argno);
 		bool btf_id_fixed_off_ok =3D true;
 		u32 ref_id =3D args[i].type, type_size;
 		int kf_arg_type =3D meta->fn->arg_type[i];
=20
+		t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
+		nslots =3D kfunc_arg_slots(t);
+
 		if (is_kfunc_arg_prog_aux(btf, &args[i])) {
 			/* Reject repeated use bpf_prog_aux */
 			if (meta->arg_prog) {
@@ -12934,8 +13026,6 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_call_arg_me
 		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, =
i))
 			continue;
=20
-		t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
-
 		if (btf_type_is_ptr(t)) {
 			ref_t =3D btf_type_skip_modifiers(btf, t->type, &ref_id);
 			ref_tname =3D btf_name_by_offset(btf, ref_t->name_off);
@@ -12986,6 +13076,17 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_call_arg_me
 			ref_tname =3D btf_name_by_offset(btf, ref_t->name_off);
 		}
=20
+		/*
+		 * The first slot is checked in below KF_ARG_ANYTHING.
+		 * The rest of it has to be a scalar.
+		 */
+		for (k =3D 1; k < nslots; k++) {
+			ret =3D check_kfunc_scalar_arg(env, caller, regs, slots_used + k,
+						     insn_idx, func_name);
+			if (ret)
+				return ret;
+		}
+
 		switch (base_type(kf_arg_type)) {
 		case KF_ARG_CONST:
 		case KF_ARG_CONST_MEM_SIZE:
@@ -13055,15 +13156,10 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_call_arg_me
 			}
 			break;
 		case KF_ARG_ANYTHING:
-			if (reg->type !=3D SCALAR_VALUE) {
-				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
-				bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
-						      "Pass an integer scalar value for this argument, not a point=
er or resource object.",
-						      "the kfunc expects an integer scalar, but %s is %s",
-						      reg_arg_name(env, argno),
-						      bpf_diag_reg_type_plain(env, reg->type));
-				return -EINVAL;
-			}
+			ret =3D check_kfunc_scalar_arg(env, caller, regs, slots_used,
+						     insn_idx, func_name);
+			if (ret)
+				return ret;
 			break;
 		case KF_ARG_CONST_ALLOC_SIZE_OR_ZERO:
 			if (reg->type !=3D SCALAR_VALUE) {
@@ -13403,9 +13499,9 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_call_arg_me
 			fallthrough;
 		case KF_ARG_MEM_SIZE:
 		{
-			struct bpf_reg_state *buff_reg =3D get_func_arg_reg(caller, regs, i -=
 1);
+			struct bpf_reg_state *buff_reg =3D get_func_arg_reg(caller, regs, pre=
v_slot);
 			struct bpf_reg_state *size_reg =3D reg;
-			argno_t buff_argno =3D argno_from_arg(i);
+			argno_t buff_argno =3D argno_from_arg(prev_slot + 1);
 			enum bpf_mem_size_failure failure;
=20
 			if (reg->type !=3D SCALAR_VALUE) {
@@ -13751,7 +13847,7 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verif=
ier_env *env, struct bpf_insn *
 	const struct btf_param *args;
 	const struct btf_type *t, *ref_t;
 	const struct btf *btf;
-	u32 nargs, type_size;
+	u32 i, slot, nargs, type_size;
 	s64 size;
=20
 	if (bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta) < 0)
@@ -13760,23 +13856,32 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_ver=
ifier_env *env, struct bpf_insn *
 	btf =3D meta.btf;
 	args =3D btf_params(meta.func_proto);
 	nargs =3D btf_type_vlen(meta.func_proto);
-	if (arg >=3D nargs)
+
+	/*
+	 * @arg is an argument slot and a 16-byte parameter takes two of them,
+	 * so walk the parameters to find the one that starts at this slot. A
+	 * slot holding the upper eightbyte of such a parameter belongs to no
+	 * pointer, and neither does a slot past the last parameter.
+	 */
+	for (i =3D 0, slot =3D 0; i < nargs && slot < arg; i++)
+		slot +=3D kfunc_arg_slots(btf_type_skip_modifiers(btf, args[i].type, N=
ULL));
+	if (i >=3D nargs || slot !=3D arg)
 		return 0;
=20
-	t =3D btf_type_skip_modifiers(btf, args[arg].type, NULL);
+	t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
 	if (!btf_type_is_ptr(t))
 		return 0;
=20
 	/* dynptr: fixed 16-byte on-stack representation */
-	if (is_kfunc_arg_dynptr(btf, &args[arg])) {
+	if (is_kfunc_arg_dynptr(btf, &args[i])) {
 		size =3D BPF_DYNPTR_SIZE;
 		goto out;
 	}
=20
 	/* ptr + __sz/__szk pair: the size follows the pointer */
-	if (arg + 1 < nargs &&
-	    (btf_param_match_suffix(btf, &args[arg + 1], "__sz") ||
-	     btf_param_match_suffix(btf, &args[arg + 1], "__szk"))) {
+	if (i + 1 < nargs &&
+	    (btf_param_match_suffix(btf, &args[i + 1], "__sz") ||
+	     btf_param_match_suffix(btf, &args[i + 1], "__szk"))) {
 		int size_reg =3D BPF_REG_1 + arg + 1;
=20
 		if (size_reg <=3D MAX_BPF_FUNC_REG_ARGS &&
@@ -13799,7 +13904,7 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verif=
ier_env *env, struct bpf_insn *
 	/* KF_ITER_NEW kfuncs initialize the iterator state at arg 0 */
 	if (arg =3D=3D 0 && meta.kfunc_flags & KF_ITER_NEW)
 		return -size;
-	if (is_kfunc_arg_uninit(btf, &args[arg]))
+	if (is_kfunc_arg_uninit(btf, &args[i]))
 		return -size;
 	return size;
 }
@@ -13992,7 +14097,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 	struct bpf_insn_aux_data *insn_aux;
 	const char *operation;
 	int err, insn_idx =3D *insn_idx_p;
-	u32 i, nargs, ptr_type_id, ret_nregs =3D 1;
+	u32 i, proto_slots, ptr_type_id, ret_nregs =3D 1;
 	struct bpf_kfunc_desc *desc;
 	struct btf *desc_btf;
 	int id;
@@ -14418,11 +14523,11 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
 	if (bpf_is_kfunc_pkt_changing(&meta))
 		clear_all_pkt_pointers(env);
=20
-	nargs =3D btf_type_vlen(meta.func_proto);
-	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
+	proto_slots =3D kfunc_proto_slots(desc_btf, meta.func_proto);
+	if (proto_slots > MAX_BPF_FUNC_REG_ARGS) {
 		struct bpf_func_state *caller =3D cur_func(env);
 		struct bpf_subprog_info *caller_info =3D &env->subprog_info[caller->su=
bprogno];
-		u16 out_stack_arg_cnt =3D nargs - MAX_BPF_FUNC_REG_ARGS;
+		u16 out_stack_arg_cnt =3D proto_slots - MAX_BPF_FUNC_REG_ARGS;
 		u16 stack_arg_cnt =3D bpf_in_stack_arg_cnt(caller_info) + out_stack_ar=
g_cnt;
=20
 		if (stack_arg_cnt > caller_info->stack_arg_cnt)
@@ -17989,7 +18094,7 @@ bool bpf_get_call_summary(struct bpf_verifier_env=
 *env, struct bpf_insn *call,
 		if (err < 0)
 			/* error would be reported later */
 			return false;
-		cs->arg_slot_cnt =3D btf_type_vlen(meta.func_proto);
+		cs->arg_slot_cnt =3D kfunc_proto_slots(meta.btf, meta.func_proto);
 		cs->fastcall =3D meta.kfunc_flags & KF_FASTCALL;
 		cs->is_void =3D btf_type_is_void(btf_type_by_id(meta.btf, meta.func_pr=
oto->type));
 		return true;
--=20
2.52.0

