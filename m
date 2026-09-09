Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D7E33344A
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 06:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935158; cv=none; b=Bd+3pzo3RKqAKK/GQD7eLBsvPLphEHk9xcxs4deJ7c7CNGbgm5l9fr3OjmgNa01duVBrlrPgItkjDSjvTP0rvSDxu2H52j71f7Y7EzKjwjzVw79+glkmILmwxuRQUTJ4PKTxM2K4FAwPqWweM0xSaIN9Yz5+EhV1r7ZyuhlyLJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935158; c=relaxed/simple;
	bh=+Z89mGdmNwAjkCqM1BtazwMiU2TAley2u7qTB0zDQuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZnGEYQVI/6ImquOByo+ud9mQmtlye+sWji9J02q3fFFWj2+OwpvIhfuPn86wEA9pYbZyCqnE7eMhgySYKGen1AZ2TuW7gV3y93eVqq2Lcgsj8eF+9/4xHswHrygLidf9FYl7UEQaVAP0FgolAs1mGa0itoo+fbrMst+gTvkEIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 6539D299486F1D; Tue,  8 Sep 2026 23:25:54 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 06/12] bpf: Recognize by-value struct and __int128 kfunc arguments
Date: Tue,  8 Sep 2026 23:25:54 -0700
Message-ID: <20260909062554.4007131-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909062522.4001896-1-yonghong.song@linux.dev>
References: <20260909062522.4001896-1-yonghong.song@linux.dev>
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
 kernel/bpf/verifier.c | 148 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 121 insertions(+), 27 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cf526f28f3e5..94c359351bb6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12154,12 +12154,30 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_call_=
arg_meta *meta)
 	return meta->func_id =3D=3D special_kfunc_list[KF_bpf_xdp_pull_data];
 }
=20
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
@@ -12179,6 +12197,23 @@ get_kfunc_arg_type(struct bpf_verifier_env *env,=
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
@@ -12294,7 +12329,7 @@ static int gen_kfunc_arg_proto(struct bpf_verifie=
r_env *env, struct bpf_call_arg
 {
 	const struct btf *btf =3D meta->btf;
 	const struct btf_param *args;
-	u32 i, nargs;
+	u32 i, nargs, slots_used;
 	int arg_type;
=20
 	args =3D (const struct btf_param *)(meta->func_proto + 1);
@@ -12310,19 +12345,44 @@ static int gen_kfunc_arg_proto(struct bpf_verif=
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
@@ -12897,29 +12957,35 @@ static int check_kfunc_args(struct bpf_verifier=
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
@@ -12939,8 +13005,6 @@ static int check_kfunc_args(struct bpf_verifier_e=
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
@@ -12991,6 +13055,27 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_call_arg_me
 			ref_tname =3D btf_name_by_offset(btf, ref_t->name_off);
 		}
=20
+		/*
+		 * The first register is checked in below KF_ARG_ANYTHING.
+		 * The rest of it has to be a scalar.
+		 */
+		for (k =3D 1; k < nslots; k++) {
+			argno_t hi_argno =3D argno_from_arg(slots_used + k + 1);
+			struct bpf_reg_state *hi =3D get_func_arg_reg(caller, regs, slots_use=
d + k);
+
+			if (hi->type !=3D SCALAR_VALUE) {
+				verbose(env, "%s is not a scalar\n", reg_arg_name(env, hi_argno));
+				bpf_diag_call_arg_fmt(env, insn_idx, hi_argno, func_name,
+						      "Pass an integer scalar value for this "
+						      "argument, not a pointer or resource object.",
+						      "the kfunc expects an integer scalar, "
+						      "but %s is %s",
+						      reg_arg_name(env, hi_argno),
+						      bpf_diag_reg_type_plain(env, hi->type));
+				return -EINVAL;
+			}
+		}
+
 		switch (base_type(kf_arg_type)) {
 		case KF_ARG_CONST:
 		case KF_ARG_CONST_MEM_SIZE:
@@ -13408,9 +13493,9 @@ static int check_kfunc_args(struct bpf_verifier_e=
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
@@ -13756,7 +13841,7 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verif=
ier_env *env, struct bpf_insn *
 	const struct btf_param *args;
 	const struct btf_type *t, *ref_t;
 	const struct btf *btf;
-	u32 nargs, type_size;
+	u32 i, slot, nargs, type_size;
 	s64 size;
=20
 	if (bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta) < 0)
@@ -13765,23 +13850,32 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_ver=
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
 	/* ptr + __sz/__szk pair: size is in the next register */
-	if (arg + 1 < nargs &&
-	    (btf_param_match_suffix(btf, &args[arg + 1], "__sz") ||
-	     btf_param_match_suffix(btf, &args[arg + 1], "__szk"))) {
+	if (i + 1 < nargs &&
+	    (btf_param_match_suffix(btf, &args[i + 1], "__sz") ||
+	     btf_param_match_suffix(btf, &args[i + 1], "__szk"))) {
 		int size_reg =3D BPF_REG_1 + arg + 1;
=20
 		if (aux->const_reg_mask & BIT(size_reg)) {
@@ -13803,7 +13897,7 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verif=
ier_env *env, struct bpf_insn *
 	/* KF_ITER_NEW kfuncs initialize the iterator state at arg 0 */
 	if (arg =3D=3D 0 && meta.kfunc_flags & KF_ITER_NEW)
 		return -size;
-	if (is_kfunc_arg_uninit(btf, &args[arg]))
+	if (is_kfunc_arg_uninit(btf, &args[i]))
 		return -size;
 	return size;
 }
@@ -13996,7 +14090,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 	struct bpf_insn_aux_data *insn_aux;
 	const char *operation;
 	int err, insn_idx =3D *insn_idx_p;
-	u32 i, nargs, ptr_type_id, ret_nregs =3D 1;
+	u32 i, proto_slots, ptr_type_id, ret_nregs =3D 1;
 	struct bpf_kfunc_desc *desc;
 	struct btf *desc_btf;
 	int id;
@@ -14422,11 +14516,11 @@ static int check_kfunc_call(struct bpf_verifier=
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
@@ -17993,7 +18087,7 @@ bool bpf_get_call_summary(struct bpf_verifier_env=
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
2.53.0-Meta

