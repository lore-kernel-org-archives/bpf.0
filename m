Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C5F313E34
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 01:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775093281; cv=none; b=LRtqojWNJYluir0qM8JtvrJwG6/XVjAhgECDwFkOOSVL8EVs9XBn4aQfSyYyPqQhP4lwhnFXEfn1Pwv/JZ14CWJjJkczaefHs7RRRW4Y0/55/hRP2CMsOG25XmJIloQHc9PIUD2nKpeiI02EDRUxLkakP1Ko3jWXb8HMoulTjCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775093281; c=relaxed/simple;
	bh=oiJWFhE0fX34tbrmUmPdZEToNiXbab3KqbCO7QJgvDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHnF6u5zB+0dcvHhsA5neFf18p3WgAnM8Kwy64RV9yMSAo/T1MiwxPLZESZuRpPVwdXEtX59C1AbexfMfGqOtSo3ULJvLQgJq+pHI9wfOTChs6nLNV/AuhqrNd2k454GS4iFRTZNV1P+ZFf0BUdGWDjrRbnEQdiPdvmJdpbvczY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id CC95E332804CD; Wed,  1 Apr 2026 18:27:47 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 04/10] bpf: Support stack arguments for kfunc calls
Date: Wed,  1 Apr 2026 18:27:47 -0700
Message-ID: <20260402012747.3918081-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402012727.3916819-1-yonghong.song@linux.dev>
References: <20260402012727.3916819-1-yonghong.song@linux.dev>
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
function. The BPF program writes outgoing args at r12-relative offsets
past its own incoming area.

The following is an example to show how stack arguments are saved:

   int foo(int a1, int a2, int a3, int a4, int a5, int a6, int a7) {
     ...
     kfunc1(a1, a2, a3, a4, a5, a6, a7, a8);
     ...
     kfunc2(a1, a2, a3, a4, a5, a6, a7, a8, a9);
     ...
   }

The following is an illustration:

   Caller (foo)
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
       r12-relative stack arg area:

       r12-8:  [incoming arg 6]
       r12-16: [incoming arg 7]

       ---- incoming/outgoing boundary (kfunc1)
       r12-24: [outgoing arg 6 to callee]
       r12-32: [outgoing arg 7 to callee]
       r12-40: [outgoing arg 8 to callee]
       ...
       Back from kfunc1
       ...

       ---- incoming/outgoing boundary
       r12-24: [outgoing arg 6 to callee]
       r12-32: [outgoing arg 7 to callee]
       r12-40: [outgoing arg 8 to callee]
       r12-48: [outgoing arg 9 to callee]

Later JIT will marshal outgoing arguments to the native calling conventio=
n
for kfunc1() and kfunc2().

In check_kfunc_args(), for args beyond the 5th, retrieve the spilled
register state from the caller's stack arg slots. Temporarily copy
it into regs[BPF_REG_1] to reuse the existing type checking
infrastructure, then restore after checking. Also in fixup_kfunc_call(),
repurpose insn->off (no longer needed after kfunc address resolution)
to store the number of stack args, so the JIT knows how many args to mars=
hal.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 97 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 80 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d424fe611ef8..6579156486b8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3502,7 +3502,7 @@ static int add_kfunc_call(struct bpf_verifier_env *=
env, u32 func_id, s16 offset)
 	struct bpf_kfunc_meta kfunc;
 	struct bpf_kfunc_desc *desc;
 	unsigned long addr;
-	int err;
+	int i, err;
=20
 	prog_aux =3D env->prog->aux;
 	tab =3D prog_aux->kfunc_tab;
@@ -3578,6 +3578,14 @@ static int add_kfunc_call(struct bpf_verifier_env =
*env, u32 func_id, s16 offset)
 	if (err)
 		return err;
=20
+	for (i =3D MAX_BPF_FUNC_REG_ARGS; i < func_model.nr_args; i++) {
+		if (func_model.arg_size[i] > sizeof(u64)) {
+			verbose(env, "kfunc %s arg#%d size %d > %zu not supported for stack a=
rgs\n",
+				kfunc.name, i, func_model.arg_size[i], sizeof(u64));
+			return -EINVAL;
+		}
+	}
+
 	desc =3D &tab->descs[tab->nr_descs++];
 	desc->func_id =3D func_id;
 	desc->offset =3D offset;
@@ -12995,9 +13003,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *e=
nv,
 		       struct bpf_kfunc_call_arg_meta *meta,
 		       const struct btf_type *t, const struct btf_type *ref_t,
 		       const char *ref_tname, const struct btf_param *args,
-		       int argno, int nargs)
+		       int argno, int nargs, u32 regno)
 {
-	u32 regno =3D argno + 1;
 	struct bpf_reg_state *regs =3D cur_regs(env);
 	struct bpf_reg_state *reg =3D &regs[regno];
 	bool arg_mem_size =3D false;
@@ -13677,9 +13684,9 @@ static int check_kfunc_args(struct bpf_verifier_e=
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
@@ -13687,13 +13694,41 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
 	 * verifier sees.
 	 */
 	for (i =3D 0; i < nargs; i++) {
-		struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &regs[i + 1];
+		struct bpf_reg_state *regs =3D cur_regs(env), *reg;
+		struct bpf_reg_state saved_reg;
 		const struct btf_type *t, *ref_t, *resolve_ret;
 		enum bpf_arg_type arg_type =3D ARG_DONTCARE;
 		u32 regno =3D i + 1, ref_id, type_size;
 		bool is_ret_buf_sz =3D false;
+		bool is_stack_arg =3D false;
 		int kf_arg_type;
=20
+		if (i < MAX_BPF_FUNC_REG_ARGS) {
+			reg =3D &regs[i + 1];
+		} else {
+			/*
+			 * Retrieve the spilled reg state from the stack arg slot.
+			 * Reuse the existing type checking infrastructure which
+			 * reads from cur_regs(env)[regno], temporarily copy the
+			 * stack arg reg state into regs[BPF_REG_1] and restore
+			 * it after checking.
+			 */
+			struct bpf_func_state *caller =3D cur_func(env);
+			int spi =3D caller->incoming_stack_arg_depth / BPF_REG_SIZE +
+				  (i - MAX_BPF_FUNC_REG_ARGS);
+
+			if (!is_stack_arg_slot_initialized(caller, spi)) {
+				verbose(env, "stack arg#%d not properly initialized\n", i);
+				return -EINVAL;
+			}
+
+			is_stack_arg =3D true;
+			regno =3D BPF_REG_1;
+			saved_reg =3D regs[BPF_REG_1];
+			regs[BPF_REG_1] =3D caller->stack_arg_slots[spi].spilled_ptr;
+			reg =3D &regs[BPF_REG_1];
+		}
+
 		if (is_kfunc_arg_prog_aux(btf, &args[i])) {
 			/* Reject repeated use bpf_prog_aux */
 			if (meta->arg_prog) {
@@ -13702,7 +13737,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 			}
 			meta->arg_prog =3D true;
 			cur_aux(env)->arg_prog =3D regno;
-			continue;
+			goto next_arg;
 		}
=20
 		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, =
i))
@@ -13725,9 +13760,11 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
 					verbose(env, "R%d must be a known constant\n", regno);
 					return -EINVAL;
 				}
-				ret =3D mark_chain_precision(env, regno);
-				if (ret < 0)
-					return ret;
+				if (i < MAX_BPF_FUNC_REG_ARGS) {
+					ret =3D mark_chain_precision(env, regno);
+					if (ret < 0)
+						return ret;
+				}
 				meta->arg_constant.found =3D true;
 				meta->arg_constant.value =3D reg->var_off.value;
 			} else if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdonly_buf_s=
ize")) {
@@ -13749,11 +13786,13 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
 				}
=20
 				meta->r0_size =3D reg->var_off.value;
-				ret =3D mark_chain_precision(env, regno);
-				if (ret)
-					return ret;
+				if (i < MAX_BPF_FUNC_REG_ARGS) {
+					ret =3D mark_chain_precision(env, regno);
+					if (ret)
+						return ret;
+				}
 			}
-			continue;
+			goto next_arg;
 		}
=20
 		if (!btf_type_is_ptr(t)) {
@@ -13782,13 +13821,14 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
 		ref_t =3D btf_type_skip_modifiers(btf, t->type, &ref_id);
 		ref_tname =3D btf_name_by_offset(btf, ref_t->name_off);
=20
-		kf_arg_type =3D get_kfunc_ptr_arg_type(env, meta, t, ref_t, ref_tname,=
 args, i, nargs);
+		kf_arg_type =3D get_kfunc_ptr_arg_type(env, meta, t, ref_t, ref_tname,=
 args, i, nargs,
+						     regno);
 		if (kf_arg_type < 0)
 			return kf_arg_type;
=20
 		switch (kf_arg_type) {
 		case KF_ARG_PTR_TO_NULL:
-			continue;
+			goto next_arg;
 		case KF_ARG_PTR_TO_MAP:
 			if (!reg->map_ptr) {
 				verbose(env, "pointer in R%d isn't map pointer\n", regno);
@@ -14201,6 +14241,9 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 			break;
 		}
 		}
+next_arg:
+		if (is_stack_arg)
+			regs[BPF_REG_1] =3D saved_reg;
 	}
=20
 	if (is_kfunc_release(meta) && !meta->release_regno) {
@@ -14778,7 +14821,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
=20
 	nargs =3D btf_type_vlen(meta.func_proto);
 	args =3D (const struct btf_param *)(meta.func_proto + 1);
-	for (i =3D 0; i < nargs; i++) {
+	for (i =3D 0; i < nargs && i < MAX_BPF_FUNC_REG_ARGS; i++) {
 		u32 regno =3D i + 1;
=20
 		t =3D btf_type_skip_modifiers(desc_btf, args[i].type, NULL);
@@ -14789,6 +14832,16 @@ static int check_kfunc_call(struct bpf_verifier_=
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
@@ -23615,6 +23668,16 @@ static int fixup_kfunc_call(struct bpf_verifier_=
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

