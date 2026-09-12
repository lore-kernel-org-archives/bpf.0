Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF15038E8CB
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789242772; cv=none; b=TiQjIYoUzTC2j24AnH1yj/AZ68p4bEFKTrNp5HiznwTofelORD2nEiSV6eUuP+20I/QF7PLYy3llTBI0nmaLWT+8QVpHJS6dDHOYWH6LYS3YgDqPV6lIQ9xlyerg9AisZ2sfnC3ZLsdcZkcj9z60BS9JvLdQAl+IekBKg9az56U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789242772; c=relaxed/simple;
	bh=W/HtRuHzHIdl7YXuSHy0E3yEpNnJ2SoCZJfVIHo75/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/ChPzCq7tzJ4pFZmElv7JmfZq2kI3DrgOm3aZ8gsYvjyjkoSGU5whijB/LizgFtKv4EKGj91bIkWo9CnYkOLndamOr7D7v5t2LMW8m4okIeEnfcXbh+2ZxLFx+iFrGI5dItj30qkCBAlK9MRyML4o2oXH/ere1Jy6jdTWyGCEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 50D602A58A0D5F; Sat, 12 Sep 2026 12:52:37 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 08/15] bpf: Recognize by-value struct and __int128 kfunc arguments
Date: Sat, 12 Sep 2026 12:52:37 -0700
Message-ID: <20260912195237.988712-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912195156.980886-1-yonghong.song@linux.dev>
References: <20260912195156.980886-1-yonghong.song@linux.dev>
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
 kernel/bpf/verifier.c | 189 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 153 insertions(+), 36 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8c784e9fd8b7..c33f1e1d1a1c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8238,7 +8238,7 @@ static int resolve_map_arg_type(struct bpf_verifier=
_env *env,
 }
=20
 static int resolve_func_arg_type(struct bpf_verifier_env *env,
-				 struct bpf_reg_state *reg, u32 arg,
+				 struct bpf_reg_state *reg, u32 arg, argno_t argno,
 				 struct bpf_call_arg_meta *meta,
 				 enum bpf_arg_type *arg_type, u32 *arg_size);
 static int process_arg_ptr_to_btf_id(struct bpf_verifier_env *env, struc=
t bpf_reg_state *reg,
@@ -8885,7 +8885,7 @@ static int process_map_ptr_arg(struct bpf_verifier_=
env *env, struct bpf_reg_stat
 	return 0;
 }
=20
-static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
+static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slo=
t, u32 prev_slot,
 			  struct bpf_call_arg_meta *meta,
 			  int insn_idx)
 {
@@ -8893,8 +8893,8 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
 	const struct bpf_func_proto *fn =3D meta->fn;
 	struct bpf_func_state *caller =3D cur_func(env);
 	struct bpf_reg_state *regs =3D cur_regs(env);
-	argno_t argno =3D argno_from_arg(arg + 1);
-	struct bpf_reg_state *reg =3D get_func_arg_reg(caller, regs, arg);
+	argno_t argno =3D argno_from_arg(slot + 1);
+	struct bpf_reg_state *reg =3D get_func_arg_reg(caller, regs, slot);
 	enum bpf_arg_type arg_type =3D fn->arg_type[arg];
 	int regno =3D reg_from_argno(argno);
 	u32 arg_size =3D arg_type & MEM_FIXED_SIZE ? fn->arg_size[arg] : 0;
@@ -8925,7 +8925,7 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
 		return 0;
 	}
=20
-	err =3D resolve_func_arg_type(env, reg, arg, meta, &arg_type, &arg_size=
);
+	err =3D resolve_func_arg_type(env, reg, arg, argno, meta, &arg_type, &a=
rg_size);
 	if (err)
 		return err;
=20
@@ -9220,8 +9220,8 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
 	case ARG_MEM_SIZE:
 	case ARG_MEM_SIZE_OR_ZERO:
 	{
-		struct bpf_reg_state *buff_reg =3D get_func_arg_reg(caller, regs, arg =
- 1);
-		argno_t buff_argno =3D argno_from_arg(arg);
+		struct bpf_reg_state *buff_reg =3D get_func_arg_reg(caller, regs, prev=
_slot);
+		argno_t buff_argno =3D argno_from_arg(prev_slot + 1);
 		enum bpf_mem_size_failure failure;
 		const char *buff_arg, *size_arg;
 		bool zero_size_allowed;
@@ -9448,9 +9448,52 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg,
 	return err;
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
+/* The argument slot @slot holds an eightbyte of a by-value argument. */
+static int check_arg_extra_slot(struct bpf_verifier_env *env, struct bpf=
_func_state *caller,
+				u32 slot, struct bpf_call_arg_meta *meta)
+{
+	struct bpf_reg_state *reg =3D get_func_arg_reg(caller, cur_regs(env), s=
lot);
+	argno_t argno =3D argno_from_arg(slot + 1);
+	int regno =3D reg_from_argno(argno);
+	int err;
+
+	if (regno >=3D 0) {
+		err =3D check_reg_arg(env, regno, SRC_OP);
+		if (err)
+			return err;
+	}
+
+	return check_reg_type(env, reg, argno, ARG_SCALAR, meta);
+}
+
 static int check_func_args(struct bpf_verifier_env *env, struct bpf_call=
_arg_meta *meta,
 			   int insn_idx)
 {
+	u32 slot =3D 0, prev_slot =3D 0, proto_slots, nslots;
 	struct bpf_func_state *caller =3D cur_func(env);
 	const struct btf_param *args =3D NULL;
 	u32 arg, nargs =3D MAX_BPF_FUNC_REG_ARGS;
@@ -9461,19 +9504,47 @@ static int check_func_args(struct bpf_verifier_en=
v *env, struct bpf_call_arg_met
 		nargs =3D btf_type_vlen(meta->func_proto);
 	}
=20
-	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
-		err =3D check_outgoing_stack_args(env, caller, nargs, meta->func_name,
-						meta->btf, args);
+	/*
+	 * A by-value argument of more than one eightbyte takes a slot per
+	 * eightbyte, so the slots a call occupies are no longer its parameter
+	 * count. Only a proto whose parameters take a slot each can name the
+	 * argument a stack slot belongs to.
+	 */
+	proto_slots =3D meta->btf ? kfunc_proto_slots(meta->btf, meta->func_pro=
to) : nargs;
+
+	if (proto_slots > MAX_BPF_FUNC_REG_ARGS) {
+		err =3D check_outgoing_stack_args(env, caller, proto_slots, meta->func=
_name,
+						meta->btf, proto_slots =3D=3D nargs ? args : NULL);
 		if (err)
 			return err;
 	}
=20
-	for (arg =3D 0; arg < nargs; arg++) {
+	for (arg =3D 0; arg < nargs; arg++, prev_slot =3D slot, slot +=3D nslot=
s) {
+		const struct btf_type *t;
+		u32 k;
+
+		nslots =3D 1;
+		if (args) {
+			t =3D btf_type_skip_modifiers(meta->btf, args[arg].type, NULL);
+			nslots =3D kfunc_arg_slots(t);
+		}
+
 		if (meta->fn->arg_type[arg] =3D=3D ARG_UNUSED)
 			break;
-		err =3D check_func_arg(env, arg, meta, insn_idx);
+		err =3D check_func_arg(env, arg, slot, prev_slot, meta, insn_idx);
 		if (err)
 			return err;
+
+		/*
+		 * check_func_arg() took the first slot. A parameter of more
+		 * than one eightbyte is always a scalar, so every slot it
+		 * takes beyond the first holds one too.
+		 */
+		for (k =3D 1; k < nslots; k++) {
+			err =3D check_arg_extra_slot(env, caller, slot + k, meta);
+			if (err)
+				return err;
+		}
 	}
=20
 	return 0;
@@ -12329,11 +12400,10 @@ static bool btf_type_is_scalar_struct(struct bp=
f_verifier_env *env,
 }
=20
 static int resolve_func_arg_type(struct bpf_verifier_env *env,
-				 struct bpf_reg_state *reg, u32 arg,
+				 struct bpf_reg_state *reg, u32 arg, argno_t argno,
 				 struct bpf_call_arg_meta *meta,
 				 enum bpf_arg_type *arg_type, u32 *arg_size)
 {
-	argno_t argno =3D argno_from_arg(arg + 1);
 	const struct btf_param *args;
 	const struct btf_type *ref_t, *resolve_ret;
 	const struct btf *btf;
@@ -12661,12 +12731,12 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_call_=
arg_meta *meta)
=20
 static int
 get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_met=
a *meta,
-		   const struct btf_param *args, int arg, int nargs,
+		   const struct btf_param *args, int arg, int nargs, u32 slot,
 		   struct bpf_func_proto *proto)
 {
 	const struct btf_type *t, *ref_t =3D NULL, *resolve_ret;
 	const u32 *ref_id_ptr =3D NULL;
-	argno_t argno =3D argno_from_arg(arg + 1);
+	argno_t argno =3D argno_from_arg(slot + 1);
 	const char *ref_tname =3D NULL;
 	u32 ref_id, type_size;
 	int arg_type;
@@ -12695,6 +12765,23 @@ get_kfunc_arg_type(struct bpf_verifier_env *env,=
 struct bpf_call_arg_meta *meta,
 		return ARG_SCALAR;
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
+		return ARG_SCALAR;
+	}
+
 	if (!btf_type_is_ptr(t)) {
 		verbose(env, "Unrecognized %s type %s\n",
 			reg_arg_name(env, argno), btf_type_str(t));
@@ -12858,7 +12945,7 @@ static int gen_kfunc_arg_proto(struct bpf_verifie=
r_env *env, struct bpf_call_arg
 			       struct bpf_func_proto *proto)
 {
 	const struct btf_param *args;
-	u32 i, nargs;
+	u32 i, nargs, slots_used;
 	int arg_type;
=20
 	args =3D (const struct btf_param *)(meta->func_proto + 1);
@@ -12868,20 +12955,41 @@ static int gen_kfunc_arg_proto(struct bpf_verif=
ier_env *env, struct bpf_call_arg
 			nargs, MAX_BPF_FUNC_ARGS);
 		return -EINVAL;
 	}
-	if (nargs > MAX_BPF_FUNC_REG_ARGS && !bpf_jit_supports_stack_args()) {
-		verbose(env, "JIT does not support kfunc %s() with %d args\n",
-			meta->func_name, nargs);
-		return -ENOTSUPP;
-	}
=20
-	for (i =3D 0; i < nargs; i++) {
-		arg_type =3D get_kfunc_arg_type(env, meta, args, i, nargs, proto);
+	for (i =3D 0, slots_used =3D 0; i < nargs; i++) {
+		const struct btf_type *t;
+		u32 nslots;
+
+		t =3D btf_type_skip_modifiers(meta->btf, args[i].type, NULL);
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
+		arg_type =3D get_kfunc_arg_type(env, meta, args, i, nargs,
+					      slots_used - nslots, proto);
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
 	return check_arg_prog_aux(env, proto) ? 0 : -EINVAL;
 }
=20
@@ -13621,7 +13729,7 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verif=
ier_env *env, struct bpf_insn *
 	const struct btf_param *args;
 	const struct btf_type *t, *ref_t;
 	const struct btf *btf;
-	u32 nargs, type_size;
+	u32 i, slot, nargs, type_size;
 	s64 size;
=20
 	if (bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta) < 0)
@@ -13630,23 +13738,32 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_ver=
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
@@ -13862,7 +13979,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 	struct bpf_insn_aux_data *insn_aux;
 	const char *operation;
 	int err, insn_idx =3D *insn_idx_p;
-	u32 i, nargs, ptr_type_id, ret_nregs =3D 1;
+	u32 i, proto_slots, ptr_type_id, ret_nregs =3D 1;
 	struct bpf_kfunc_desc *desc;
 	struct btf *desc_btf;
 	int id;
@@ -14288,11 +14405,11 @@ static int check_kfunc_call(struct bpf_verifier=
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
@@ -17859,7 +17976,7 @@ bool bpf_get_call_summary(struct bpf_verifier_env=
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

