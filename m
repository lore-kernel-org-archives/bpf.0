Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7672F325495
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775409980; cv=none; b=jNdC/1UNE1xgUxcIPZ22bG3+lMV4WhofBd5kSUQ35RmJJbxjCN9CZymTKUCr//miqTb0runErjLSBEVXCSsFVR145ds2AUgNuqEsFcHoqO8IiOvr2y8d9jJI1vdnrr2swY7MvSHmUFc7HQEAmPDpqmnL6cwM+RcEV0/HP41zaZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775409980; c=relaxed/simple;
	bh=N6JByPQnmS8jgiocXj7brgsxJAfRxC9MMmkYljtnQ1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Thn+UPelZNtgmtYsXdJhZkWVDyHRBABITT/Yx2BPTuTKCr0fFJI37E0x0CrrXrbcAeLNubM8J9Lhh7YTVsXxuHcIQgusSr9DdjnuI6oBqP/R0vP1UFR9q/cqcnxqaVai7paAxDMMwQDYS/0tB1+f2/TbUSjT5UEfEYShRUJknzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 6A231361E5E2C; Sun,  5 Apr 2026 10:26:11 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 05/11] bpf: Support stack arguments for kfunc calls
Date: Sun,  5 Apr 2026 10:26:11 -0700
Message-ID: <20260405172611.1336162-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260405172505.1329392-1-yonghong.song@linux.dev>
References: <20260405172505.1329392-1-yonghong.song@linux.dev>
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
infrastructure, then restore after checking. The following is one
of examples based on a later selftest:

  13: (85) call bpf_kfunc_call_stack_arg_mem#152105
  Use reg 1 for stack arg#5
  Use reg 2 to represent mem_size
  mark_precise: frame0: last_idx 13 first_idx 0 subseq_idx -1
  mark_precise: frame0: regs=3Dr2 stack=3D before 12: (b7) r5 =3D 5
  mark_precise: frame0: regs=3Dr2 stack=3D before 11: (b7) r4 =3D 4
  mark_precise: frame0: regs=3Dr2 stack=3D before 10: (b7) r3 =3D 3
  mark_precise: frame0: regs=3Dr2 stack=3D before 9: (b7) r2 =3D 2
  mark_precise: frame0: last_idx 13 first_idx 0 subseq_idx -1
  mark_precise: frame0: regs=3Dr2 stack=3D before 12: (b7) r5 =3D 5
  mark_precise: frame0: regs=3Dr2 stack=3D before 11: (b7) r4 =3D 4
  mark_precise: frame0: regs=3Dr2 stack=3D before 10: (b7) r3 =3D 3
  mark_precise: frame0: regs=3Dr2 stack=3D before 9: (b7) r2 =3D 2
  End of using reg 1 for stack arg#6
  14: R0=3Dscalar()
  14: (95) exit

The above example is for KF_ARG_PTR_TO_MEM_SIZE case.
Registers 1 and 2 are used as an temporary register for argument
checking. The verifier log will identify when the temporary register
is used and when the temporary register is not used any more.

There are two places where meta->release_regno needs to keep
regno for later releasing the reference. Also, 'cur_aux(env)->arg_prog =3D=
 regno'
is also keep regno for later fixup. Since regno is a faked one
such three cases are rejected for now if they are in stack arguments.
If possible, new kfuncs could keep them in first 5 registers so
there are no issues at all.

If faked register approach is not favored, the following is an
alternative approach with the following data structure:

   struct reg_or_arg_t {
     struct bpf_reg_state *state;
     union {
       int regno;
       int argno;
     };
     bool is_reg; /* distinguish between reg and arg */
   };

Such a struct can replace existing regno/argno/reg_state parameters
to make it easy to distinguish reg vs. arg.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 143 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 124 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 183a4108fd4d..dba889cece1c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3491,7 +3491,7 @@ static int add_kfunc_call(struct bpf_verifier_env *=
env, u32 func_id, s16 offset)
 	struct bpf_kfunc_meta kfunc;
 	struct bpf_kfunc_desc *desc;
 	unsigned long addr;
-	int err;
+	int i, err;
=20
 	prog_aux =3D env->prog->aux;
 	tab =3D prog_aux->kfunc_tab;
@@ -3567,6 +3567,14 @@ static int add_kfunc_call(struct bpf_verifier_env =
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
@@ -13083,6 +13091,19 @@ static bool is_kfunc_pkt_changing(struct bpf_kfu=
nc_call_arg_meta *meta)
 	return meta->func_id =3D=3D special_kfunc_list[KF_bpf_xdp_pull_data];
 }
=20
+static struct bpf_reg_state *get_kfunc_arg_reg(struct bpf_verifier_env *=
env, int argno)
+{
+	struct bpf_func_state *caller;
+	int spi;
+
+	if (argno < MAX_BPF_FUNC_REG_ARGS)
+		return &cur_regs(env)[argno + 1];
+
+	caller =3D cur_func(env);
+	spi =3D caller->incoming_stack_arg_depth / BPF_REG_SIZE + (argno - MAX_=
BPF_FUNC_REG_ARGS);
+	return &caller->stack_arg_slots[spi].spilled_ptr;
+}
+
 static enum kfunc_ptr_arg_type
 get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 		       struct bpf_kfunc_call_arg_meta *meta,
@@ -13101,8 +13122,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *e=
nv,
 		return KF_ARG_PTR_TO_CTX;
=20
 	if (argno + 1 < nargs &&
-	    (is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1=
]) ||
-	     is_kfunc_arg_const_mem_size(meta->btf, &args[argno + 1], &regs[reg=
no + 1])))
+	    (is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], get_kfunc_arg_r=
eg(env, argno + 1)) ||
+	     is_kfunc_arg_const_mem_size(meta->btf, &args[argno + 1], get_kfunc=
_arg_reg(env, argno + 1))))
 		arg_mem_size =3D true;
=20
 	/* In this function, we verify the kfunc's BTF as per the argument type=
,
@@ -13770,9 +13791,9 @@ static int check_kfunc_args(struct bpf_verifier_e=
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
@@ -13780,26 +13801,59 @@ static int check_kfunc_args(struct bpf_verifier=
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
+			verbose(env, "Use reg %d for stack arg#%d\n", regno, i);
+		}
+
 		if (is_kfunc_arg_prog_aux(btf, &args[i])) {
 			/* Reject repeated use bpf_prog_aux */
 			if (meta->arg_prog) {
 				verifier_bug(env, "Only 1 prog->aux argument supported per-kfunc");
 				return -EFAULT;
 			}
+			if (is_stack_arg) {
+				verbose(env, "arg#%d prog->aux cannot be a stack argument\n", i);
+				return -EINVAL;
+			}
 			meta->arg_prog =3D true;
 			cur_aux(env)->arg_prog =3D regno;
-			continue;
+			goto next_arg;
 		}
=20
 		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, =
i))
-			continue;
+			goto next_arg;
=20
 		t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
=20
@@ -13818,9 +13872,11 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
 					verbose(env, "R%d must be a known constant\n", regno);
 					return -EINVAL;
 				}
-				ret =3D mark_chain_precision(env, regno);
-				if (ret < 0)
-					return ret;
+				if (!is_stack_arg) {
+					ret =3D mark_chain_precision(env, regno);
+					if (ret < 0)
+						return ret;
+				}
 				meta->arg_constant.found =3D true;
 				meta->arg_constant.value =3D reg->var_off.value;
 			} else if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdonly_buf_s=
ize")) {
@@ -13842,11 +13898,13 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
 				}
=20
 				meta->r0_size =3D reg->var_off.value;
-				ret =3D mark_chain_precision(env, regno);
-				if (ret)
-					return ret;
+				if (!is_stack_arg) {
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
@@ -13868,8 +13926,13 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
 				return -EFAULT;
 			}
 			meta->ref_obj_id =3D reg->ref_obj_id;
-			if (is_kfunc_release(meta))
+			if (is_kfunc_release(meta)) {
+				if (is_stack_arg) {
+					verbose(env, "arg#%d release arg cannot be a stack argument\n", i);
+					return -EINVAL;
+				}
 				meta->release_regno =3D regno;
+			}
 		}
=20
 		ref_t =3D btf_type_skip_modifiers(btf, t->type, &ref_id);
@@ -13881,7 +13944,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
=20
 		switch (kf_arg_type) {
 		case KF_ARG_PTR_TO_NULL:
-			continue;
+			goto next_arg;
 		case KF_ARG_PTR_TO_MAP:
 			if (!reg->map_ptr) {
 				verbose(env, "pointer in R%d isn't map pointer\n", regno);
@@ -14020,6 +14083,10 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
 				dynptr_arg_type |=3D DYNPTR_TYPE_FILE;
 			} else if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_dynptr_file=
_discard]) {
 				dynptr_arg_type |=3D DYNPTR_TYPE_FILE;
+				if (is_stack_arg) {
+					verbose(env, "arg#%d release arg cannot be a stack argument\n", i);
+					return -EINVAL;
+				}
 				meta->release_regno =3D regno;
 			} else if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_dynptr_clon=
e] &&
 				   (dynptr_arg_type & MEM_UNINIT)) {
@@ -14169,8 +14236,18 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
 		{
 			struct bpf_reg_state *buff_reg =3D &regs[regno];
 			const struct btf_param *buff_arg =3D &args[i];
-			struct bpf_reg_state *size_reg =3D &regs[regno + 1];
+			struct bpf_reg_state *size_reg;
 			const struct btf_param *size_arg =3D &args[i + 1];
+			struct bpf_reg_state saved_size_reg =3D {};
+			bool size_is_stack_arg =3D false;
+
+			if (i >=3D MAX_BPF_FUNC_REG_ARGS) {
+				size_is_stack_arg =3D true;
+				saved_size_reg =3D regs[regno + 1];
+				regs[regno + 1] =3D *get_kfunc_arg_reg(env, i + 1);
+				verbose(env, "Use reg %d to represent mem_size\n", regno + 1);
+			}
+			size_reg =3D &regs[regno + 1];
=20
 			if (!register_is_null(buff_reg) || !is_kfunc_arg_nullable(meta->btf, =
buff_arg)) {
 				ret =3D check_kfunc_mem_size_reg(env, size_reg, regno + 1);
@@ -14193,6 +14270,9 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 				meta->arg_constant.value =3D size_reg->var_off.value;
 			}
=20
+			if (size_is_stack_arg)
+				regs[regno + 1] =3D saved_size_reg;
+
 			/* Skip next '__sz' or '__szk' argument */
 			i++;
 			break;
@@ -14294,6 +14374,11 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
 			break;
 		}
 		}
+next_arg:
+		if (is_stack_arg) {
+			regs[regno] =3D saved_reg;
+			verbose(env, "End of using reg %d for stack arg#%d\n", regno, i);
+		}
 	}
=20
 	if (is_kfunc_release(meta) && !meta->release_regno) {
@@ -15059,7 +15144,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
=20
 	nargs =3D btf_type_vlen(meta.func_proto);
 	args =3D (const struct btf_param *)(meta.func_proto + 1);
-	for (i =3D 0; i < nargs; i++) {
+	for (i =3D 0; i < nargs && i < MAX_BPF_FUNC_REG_ARGS; i++) {
 		u32 regno =3D i + 1;
=20
 		t =3D btf_type_skip_modifiers(desc_btf, args[i].type, NULL);
@@ -15070,6 +15155,16 @@ static int check_kfunc_call(struct bpf_verifier_=
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
@@ -23975,6 +24070,16 @@ static int fixup_kfunc_call(struct bpf_verifier_=
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

