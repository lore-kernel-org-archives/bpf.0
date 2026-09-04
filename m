Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554EF405C3F
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 05:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788498635; cv=none; b=kkIawgvZjwZSeWR8zC2ngup5HkwBlmlYQ+3kNNlV6srfzidKMVT5553jJ/mDg00mksmMvPxIJhP2D0dz5Z+OPfnOpVwb/QJnUiLiiLBYYmwUyow7NzZExLPmDFGuoGf42FZCr0EHkiNVItqDV23WS3uUC0S6vCWjGip0qpOTC08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788498635; c=relaxed/simple;
	bh=lcIMQq6n4Cs1+IWeqXS6ngbMT1IBAQv4ytXbrf09+oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YukEiJV4ZL1+2Unevz1/SHhXngkW6Luv6rYi9f9ff5QxCs//YYDd/8gZcIhaGhqdblfdl7KnQEsViinbU8eAL5lu9leJ4W9mLyFCClSQ5aPQAnv2JZl3RXcPcpJgXR/m0Q7A76EClpqXXNuvqK28Rr4Uixa5vN+XhnDOTC57ljs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 47AB6288131731; Thu,  3 Sep 2026 22:10:23 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 05/12] bpf: Support by-value struct and __int128 kfunc arguments
Date: Thu,  3 Sep 2026 22:10:23 -0700
Message-ID: <20260904051023.3979415-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904050957.3976119-1-yonghong.song@linux.dev>
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
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

Give the kfunc argument walk the same slot count a BPF-to-BPF call now
uses: one argument register per eightbyte, so a 16-byte value takes two.
The outgoing stack argument count at the call site follows the slots for
the same reason. Similar to BPF-to-BPF aggregate handling, a kfunc
aggregate argument only supports tbe composed of scalars.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/filter.h |   1 +
 kernel/bpf/core.c      |  11 +++
 kernel/bpf/verifier.c  | 168 +++++++++++++++++++++++++++++++++++++----
 3 files changed, 164 insertions(+), 16 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 6e746b0a0930..e288df4124d3 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1238,6 +1238,7 @@ bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_kfunc_ret_reg_pair(void);
+bool bpf_jit_supports_kfunc_arg_slot(u32 slots_used, u32 nslots, u32 ali=
gn);
 bool bpf_jit_supports_stack_args(void);
 bool bpf_jit_supports_arena_args(void);
 bool bpf_jit_supports_far_kfunc_call(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 5db77d7915df..5a20d3e1ace9 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3292,6 +3292,17 @@ bool __weak bpf_jit_supports_kfunc_ret_reg_pair(vo=
id)
 	return false;
 }
=20
+/*
+ * Whether an argument of @nslots eightbytes and @align alignment, comin=
g after
+ * @slots_used slots, lands where the kernel calling convention expects =
it. The
+ * JIT maps slots to argument positions in order, registers first, so th=
e two
+ * agree unless the calling convention places the argument elsewhere.
+ */
+bool __weak bpf_jit_supports_kfunc_arg_slot(u32 slots_used, u32 nslots, =
u32 align)
+{
+	return false;
+}
+
 bool __weak bpf_jit_supports_stack_args(void)
 {
 	return false;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 17e576c7b757..030fb37c22ef 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12049,12 +12049,63 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_call_=
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
+/*
+ * The alignment the calling convention gives a kfunc parameter of type =
@t, or
+ * 0 for a type that nests deeper than the walk descends. Only a 128-bit
+ * integer, or an aggregate built around one, asks for more than a regis=
ter,
+ * and some conventions place such an argument differently.
+ */
+static u32 kfunc_arg_align(const struct btf *btf, const struct btf_type =
*t, int rec)
+{
+	const struct btf_member *member;
+	const struct btf_type *mt;
+	u32 align, i;
+
+	while (btf_type_is_array(t))
+		t =3D btf_type_skip_modifiers(btf, btf_array(t)->type, NULL);
+
+	if (btf_type_is_int(t))
+		return t->size > BPF_REG_SIZE ? t->size : BPF_REG_SIZE;
+	if (!btf_type_is_struct(t))
+		return BPF_REG_SIZE;
+	if (rec >=3D BTF_MEMBER_MAX_DEPTH)
+		return 0;
+
+	for_each_member(i, t, member) {
+		mt =3D btf_type_skip_modifiers(btf, member->type, NULL);
+		align =3D kfunc_arg_align(btf, mt, rec + 1);
+		if (!align)
+			return 0;
+		if (align > BPF_REG_SIZE)
+			return 2 * BPF_REG_SIZE;
+	}
+	return BPF_REG_SIZE;
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
@@ -12062,6 +12113,14 @@ get_kfunc_arg_type(struct bpf_verifier_env *env,=
 struct bpf_call_arg_meta *meta,
=20
 	/* Scalar arguments are classified from their BTF suffix/name alone. */
 	if (btf_type_is_scalar(t)) {
+		if (t->size > 2 * BPF_REG_SIZE) {
+			verbose(env,
+				"%s type %s has size %u, only 1 to %d bytes "
+				"can be passed by value\n",
+				reg_arg_name(env, argno), btf_type_str(t), t->size,
+				2 * BPF_REG_SIZE);
+			return -EINVAL;
+		}
 		if (is_kfunc_arg_constant(meta->btf, &args[arg]))
 			return KF_ARG_CONST;
 		if (is_kfunc_arg_const_mem_size(meta->btf, &args[arg]))
@@ -12074,6 +12133,23 @@ get_kfunc_arg_type(struct bpf_verifier_env *env,=
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
@@ -12189,7 +12265,7 @@ static int gen_kfunc_arg_proto(struct bpf_verifie=
r_env *env, struct bpf_call_arg
 {
 	const struct btf *btf =3D meta->btf;
 	const struct btf_param *args;
-	u32 i, nargs;
+	u32 i, nargs, slots_used;
 	int arg_type;
=20
 	args =3D (const struct btf_param *)(meta->func_proto + 1);
@@ -12205,19 +12281,55 @@ static int gen_kfunc_arg_proto(struct bpf_verif=
ier_env *env, struct bpf_call_arg
 		return -ENOTSUPP;
 	}
=20
-	for (i =3D 0; i < nargs; i++) {
+	for (i =3D 0, slots_used =3D 0; i < nargs; i++) {
+		const struct btf_type *t;
+		u32 align, nslots;
+
+		t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
+		nslots =3D kfunc_arg_slots(t);
+		if (nslots > 1) {
+			align =3D kfunc_arg_align(btf, t, 0);
+			if (!align) {
+				verbose(env,
+					"Function %s arg#%d type %s nests structs more than "
+					"%d levels deep\n",
+					meta->func_name, i, btf_type_str(t),
+					BTF_MEMBER_MAX_DEPTH);
+				return -EINVAL;
+			}
+			if (!bpf_jit_supports_kfunc_arg_slot(slots_used, nslots, align)) {
+				verbose(env,
+					"Function %s arg#%d type %s cannot be passed at "
+					"argument slot %d on this architecture\n",
+					meta->func_name, i, btf_type_str(t), slots_used);
+				return -EINVAL;
+			}
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
+	if (slots_used > MAX_BPF_FUNC_ARGS) {
+		verbose(env, "Function %s needs %d > %d argument slots\n", meta->func_=
name,
+			slots_used, MAX_BPF_FUNC_ARGS);
+		return -EINVAL;
+	}
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
@@ -12792,29 +12904,34 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_call_arg_me
 	const struct btf *btf =3D meta->btf;
 	const struct btf_param *args;
 	struct btf_record *rec;
-	u32 i, nargs;
+	u32 i, k, nargs, proto_slots, slots_used, nslots =3D 0;
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
+	for (i =3D 0, slots_used =3D 0; i < nargs; i++, slots_used +=3D nslots)=
 {
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
@@ -12834,8 +12951,6 @@ static int check_kfunc_args(struct bpf_verifier_e=
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
@@ -12882,6 +12997,27 @@ static int check_kfunc_args(struct bpf_verifier_=
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
@@ -13882,7 +14018,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 	struct bpf_insn_aux_data *insn_aux;
 	const char *operation;
 	int err, insn_idx =3D *insn_idx_p;
-	u32 i, nargs, ptr_type_id, ret_nregs =3D 1;
+	u32 i, proto_slots, ptr_type_id, ret_nregs =3D 1;
 	struct bpf_kfunc_desc *desc;
 	struct btf *desc_btf;
 	int id;
@@ -14308,11 +14444,11 @@ static int check_kfunc_call(struct bpf_verifier=
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
--=20
2.53.0-Meta

