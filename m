Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB468390601
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 19:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789242777; cv=none; b=rWTmmNiLWYC5gPKFE81GFGr1rgAgkJNG9h64MLGvGWV6OYZITbtv9duqFyOgBVQQF6n3emdvIC7ZyMJTg8OVzKO846rvXw0NtId/nDRUoRZ9cz8sQa3xXHtm/81GSk5dOY445xUBcFzfi3q8CcX0I4WHEnfd6Joj0WBOhaE+8tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789242777; c=relaxed/simple;
	bh=Tw7fN4lKjvLcQldif9vw5AneyI8GV7j9Ahi62+62Gpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPoSiGKdn4OMBfkayO6wlJPZ81QVb4thvmm0R7+uzVjwNJHC3gH7t4nT04DyI8Q75ozFlpP1q1HGrj4b18QXkDakum5tYbbD9T6CHw28v7XMhBZ5hKmcyKu3Kwv7l0Y+iQL1VyEQWjpA7zrNYL8+p6CZsey6T4mpMs5Vl3qPnTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 6DC342A58A0D7E; Sat, 12 Sep 2026 12:52:42 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 09/15] bpf: Prepare kfunc arguments for the JIT from an ABI description
Date: Sat, 12 Sep 2026 12:52:42 -0700
Message-ID: <20260912195242.989416-1-yonghong.song@linux.dev>
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

The previous patch refuses a kfunc argument of more than one eightbyte.
This patch allows up to 16 byte kfunc arguments.

But different architectures have different ways to map the BPF calling
convention (no gap, no backfill) to the native one. Rather than have each
arch open-code where it wants an argument, describe the convention with a
register count and four booleans, and let each arch set what applies to
it:

  struct bpf_jit_arg_abi {
        u8   nr_arg_regs;
        bool even_reg_align;
        bool even_stack_align;
        bool split_at_boundary;
        bool backfill_after_stack;
  };

The four booleans are meant to cover x86-64, arm64, RISC-V LP64 and
PowerPC64 ELFv2, although only x86-64 and arm64 fill the struct in here.
bpf_jit_place_args() and bpf_jit_plan_arg_moves() use that description to
work out where each argument belongs and which slots the JIT then has to
move, to be used in the JIT later on.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h          | 15 ++++++
 include/linux/bpf_verifier.h |  1 +
 include/linux/filter.h       | 32 ++++++++++++
 kernel/bpf/btf.c             |  3 ++
 kernel/bpf/core.c            | 94 ++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 99 +++++++++++++++++++++++++++++++-----
 6 files changed, 231 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d0066d744ceb..2a5fa346aada 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -993,6 +993,13 @@ static_assert(__BPF_RET_TYPE_MAX <=3D BPF_BASE_TYPE_=
LIMIT);
  */
 #define MAX_BPF_FUNC_REG_ARGS 5
=20
+/* A by-value argument takes two eightbytes at most, so the maximum numb=
er of
+ * argument slots of any function is 2 * MAX_BPF_FUNC_ARGS. A local arra=
y may
+ * need that size for processing, although eventually the maximum slots =
will
+ * be capped at MAX_BPF_FUNC_ARGS.
+ */
+#define MAX_BPF_FUNC_ARG_SLOTS (2 * MAX_BPF_FUNC_ARGS)
+
 /* eBPF function prototype used by verifier to allow BPF_CALLs from eBPF=
 programs
  * to in-kernel helper functions and for adjusting imm32 field in BPF_CA=
LL
  * instructions after verifying
@@ -1210,6 +1217,9 @@ struct bpf_prog_offload {
 	u32			jited_len;
 };
=20
+/* The argument is aligned to 16 bytes. */
+#define BTF_FMODEL_ALIGN16_ARG		BIT(0)
+
 /* The argument is signed. */
 #define BTF_FMODEL_SIGNED_ARG		BIT(1)
=20
@@ -1227,6 +1237,11 @@ struct btf_func_model {
 	u8 arg_flags[MAX_BPF_FUNC_ARGS];
 };
=20
+static inline u32 btf_func_model_arg_slots(const struct btf_func_model *=
m, u32 arg)
+{
+	return (m->arg_size[arg] + sizeof(u64) - 1) / sizeof(u64);
+}
+
 /* Restore arguments before returning from trampoline to let original fu=
nction
  * continue executing. This flag is used for fentry progs when there are=
 no
  * fexit progs.
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1b836c6d570f..cf85141ea167 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1512,6 +1512,7 @@ enum btf_member_kind {
=20
 bool btf_struct_is_composed_of(struct bpf_verifier_env *env, const struc=
t btf *btf,
 			       const struct btf_type *t, u32 member_kinds);
+u32 btf_func_arg_align(const struct btf *btf, const struct btf_type *t);
=20
 int bpf_find_subprog(struct bpf_verifier_env *env, int off);
 bool bpf_is_throw_kfunc(struct bpf_insn *insn);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 00ad8b63aa47..b17222db2efc 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1248,6 +1248,38 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, =
bool in_arena);
 bool bpf_jit_supports_private_stack(void);
 bool bpf_jit_supports_timed_may_goto(void);
 bool bpf_jit_supports_fsession(void);
+
+struct bpf_jit_arg_abi {
+	/* Argument registers of the kernel convention. */
+	u8 nr_arg_regs;
+	/* Round the register number up to an even one for 16-byte alignment. *=
/
+	bool even_reg_align;
+	/* Round the stack slot up to an even one for 16-byte alignment. */
+	bool even_stack_align;
+	/* An argument may straddle the last register and the stack. */
+	bool split_at_boundary;
+	/* A later argument may reuse a register a stack-passed one skipped. */
+	bool backfill_after_stack;
+};
+
+const struct bpf_jit_arg_abi *bpf_jit_arg_abi(void);
+u32 bpf_jit_place_args(const struct bpf_jit_arg_abi *abi,
+		       const struct btf_func_model *fm, u8 *pos_of_slot);
+
+/* The JIT's scratch register, in place of an argument slot. */
+#define BPF_JIT_ARG_TMP		0xff
+
+/* Every argument slot moves at most once, and the scratch goes out and =
back. */
+#define BPF_JIT_MAX_ARG_MOVES	(MAX_BPF_FUNC_ARG_SLOTS + 2)
+
+struct bpf_jit_arg_move {
+	u8 dst;
+	u8 src;
+};
+
+u32 bpf_jit_plan_arg_moves(const struct bpf_jit_arg_abi *abi,
+			   const struct btf_func_model *fm,
+			   struct bpf_jit_arg_move *moves);
 u64 bpf_arch_uaddress_limit(void);
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp=
, u64 bp), void *cookie);
 u64 arch_bpf_timed_may_goto(void);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9f8a4e4aac3b..7daf4c286c9b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7579,6 +7579,9 @@ static u8 __get_arg_fmodel_flags(const struct btf *=
btf,
 {
 	u8 flags =3D __get_type_fmodel_flags(t);
=20
+	if (btf_func_arg_align(btf, t) > sizeof(u64))
+		flags |=3D BTF_FMODEL_ALIGN16_ARG;
+
 	if (btf_param_match_suffix(btf, arg, "__arena__nullable"))
 		flags |=3D BTF_FMODEL_ARENA_ARG | BTF_FMODEL_NULLABLE_ARG;
 	else if (btf_param_match_suffix(btf, arg, "__arena"))
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index c673b02d55a6..4e208cc94752 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3287,6 +3287,100 @@ bool __weak bpf_jit_supports_kfunc_ret_reg_pair(v=
oid)
 	return false;
 }
=20
+/*
+ * How this arch places a by-value kfunc argument, or NULL for one that =
has
+ * not opted in and so only takes an argument of a single eightbyte, whi=
ch
+ * every convention places in slot order.
+ */
+const struct bpf_jit_arg_abi * __weak bpf_jit_arg_abi(void)
+{
+	return NULL;
+}
+
+u32 bpf_jit_place_args(const struct bpf_jit_arg_abi *abi,
+		       const struct btf_func_model *fm, u8 *pos_of_slot)
+{
+	u32 i, k, nslots, slot =3D 0, nregs_used =3D 0, stack_off =3D 0;
+	bool on_stack =3D false;
+
+	for (i =3D 0; i < fm->nr_args; i++) {
+		bool align16 =3D fm->arg_flags[i] & BTF_FMODEL_ALIGN16_ARG;
+		u32 pos;
+
+		nslots =3D btf_func_model_arg_slots(fm, i);
+
+		if (align16 && abi->even_reg_align)
+			nregs_used =3D round_up(nregs_used, 2);
+
+		if (!on_stack && nregs_used + nslots <=3D abi->nr_arg_regs) {
+			/* wholly in registers */
+			pos =3D nregs_used;
+			nregs_used +=3D nslots;
+		} else if (!on_stack && abi->split_at_boundary) {
+			/* the last registers hold what fits, the stack the rest */
+			pos =3D nregs_used;
+			stack_off =3D (nregs_used + nslots - abi->nr_arg_regs) * BPF_REG_SIZE=
;
+			nregs_used =3D abi->nr_arg_regs;
+			on_stack =3D true;
+		} else {
+			/* wholly on the stack */
+			if (align16 && abi->even_stack_align)
+				stack_off =3D round_up(stack_off, 2 * BPF_REG_SIZE);
+			pos =3D abi->nr_arg_regs + stack_off / BPF_REG_SIZE;
+			stack_off +=3D nslots * BPF_REG_SIZE;
+			if (!abi->backfill_after_stack)
+				on_stack =3D true;
+		}
+
+		for (k =3D 0; k < nslots; k++)
+			pos_of_slot[slot + k] =3D pos + k;
+		slot +=3D nslots;
+	}
+
+	return slot;
+}
+
+u32 bpf_jit_plan_arg_moves(const struct bpf_jit_arg_abi *abi,
+			   const struct btf_func_model *fm,
+			   struct bpf_jit_arg_move *moves)
+{
+	u8 pos_of_slot[MAX_BPF_FUNC_ARG_SLOTS];
+	u32 nslots, n =3D 0, s, back;
+
+	nslots =3D bpf_jit_place_args(abi, fm, pos_of_slot);
+	back =3D nslots;
+
+	/*
+	 * An argument is two eightbytes at most, so it frees one register at
+	 * most and only one argument ever moves down. Its destination is
+	 * still in use, so carry it in the scratch. Only a lower slot can
+	 * take the one it leaves, so the walk reaches it first.
+	 */
+	for (s =3D nslots; s > 0; s--) {
+		u8 slot =3D s - 1, pos =3D pos_of_slot[slot];
+
+		if (pos =3D=3D slot)
+			continue;
+
+		if (pos < slot) {
+			moves[n].dst =3D BPF_JIT_ARG_TMP;
+			back =3D slot;
+		} else {
+			moves[n].dst =3D pos;
+		}
+		moves[n].src =3D slot;
+		n++;
+	}
+
+	if (back < nslots) {
+		moves[n].dst =3D pos_of_slot[back];
+		moves[n].src =3D BPF_JIT_ARG_TMP;
+		n++;
+	}
+
+	return n;
+}
+
 bool __weak bpf_jit_supports_stack_args(void)
 {
 	return false;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c33f1e1d1a1c..6c6b8d8520cd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2844,7 +2844,7 @@ static int fetch_kfunc_meta(struct bpf_verifier_env=
 *env,
 }
=20
 static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_=
call_arg_meta *meta,
-			       struct bpf_func_proto *proto);
+			       const struct btf_func_model *fm, struct bpf_func_proto *proto)=
;
=20
 int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 of=
fset)
 {
@@ -2961,7 +2961,7 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env=
, u32 func_id, u16 offset)
 	desc =3D &tab->descs[tab->nr_descs];
 	memset(desc, 0, sizeof(*desc));
=20
-	err =3D gen_kfunc_arg_proto(env, &meta, &desc->proto);
+	err =3D gen_kfunc_arg_proto(env, &meta, &func_model, &desc->proto);
 	if (err)
 		return err;
=20
@@ -12729,6 +12729,58 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_call_a=
rg_meta *meta)
 	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_xdp_pull_data]);
 }
=20
+static u32 kfunc_abi_slots(const struct btf_func_model *fm)
+{
+	const struct bpf_jit_arg_abi *abi =3D bpf_jit_arg_abi();
+	u8 pos_of_slot[MAX_BPF_FUNC_ARG_SLOTS];
+	u32 i, nslots, slots =3D 0;
+
+	for (i =3D 0; i < fm->nr_args; i++)
+		slots +=3D btf_func_model_arg_slots(fm, i);
+
+	if (!abi)
+		return slots;
+
+	nslots =3D bpf_jit_place_args(abi, fm, pos_of_slot);
+	for (i =3D 0; i < nslots; i++)
+		if (pos_of_slot[i] + 1 > slots)
+			slots =3D pos_of_slot[i] + 1;
+
+	return slots;
+}
+
+static u32 __btf_func_arg_align(const struct btf *btf, const struct btf_=
type *t, int rec)
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
+		align =3D __btf_func_arg_align(btf, mt, rec + 1);
+		if (!align)
+			return 0;
+		if (align > BPF_REG_SIZE)
+			return 2 * BPF_REG_SIZE;
+	}
+	return BPF_REG_SIZE;
+}
+
+u32 btf_func_arg_align(const struct btf *btf, const struct btf_type *t)
+{
+	return __btf_func_arg_align(btf, t, 0);
+}
+
 static int
 get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_met=
a *meta,
 		   const struct btf_param *args, int arg, int nargs, u32 slot,
@@ -12942,9 +12994,12 @@ get_kfunc_arg_type(struct bpf_verifier_env *env,=
 struct bpf_call_arg_meta *meta,
 }
=20
 static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_=
call_arg_meta *meta,
-			       struct bpf_func_proto *proto)
+			       const struct btf_func_model *fm, struct bpf_func_proto *proto)
 {
+	const struct bpf_jit_arg_abi *abi;
+	const struct btf *btf =3D meta->btf;
 	const struct btf_param *args;
+	const struct btf_type *t;
 	u32 i, nargs, slots_used;
 	int arg_type;
=20
@@ -12957,17 +13012,35 @@ static int gen_kfunc_arg_proto(struct bpf_verif=
ier_env *env, struct bpf_call_arg
 	}
=20
 	for (i =3D 0, slots_used =3D 0; i < nargs; i++) {
-		const struct btf_type *t;
-		u32 nslots;
+		u32 nslots =3D btf_func_model_arg_slots(fm, i);
=20
-		t =3D btf_type_skip_modifiers(meta->btf, args[i].type, NULL);
-		nslots =3D kfunc_arg_slots(t);
-		/*
-		 * The calling conventions the JIT has to reconcile do not
-		 * agree on where an argument of more than one eightbyte goes,
-		 * so refuse one until the JIT can say where this arch puts it.
-		 */
 		if (nslots > 1) {
+			t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
+			if (!btf_func_arg_align(btf, t)) {
+				verbose(env,
+					"Function %s arg#%d type %s nests structs more than "
+					"%d levels deep\n",
+					meta->func_name, i, btf_type_str(t),
+					BTF_MEMBER_MAX_DEPTH);
+				return -EINVAL;
+			}
+		}
+		slots_used +=3D nslots;
+	}
+
+	if (slots_used > MAX_BPF_FUNC_ARGS) {
+		verbose(env, "Function %s needs %d > %d argument slots\n", meta->func_=
name,
+			slots_used, MAX_BPF_FUNC_ARGS);
+		return -EINVAL;
+	}
+
+	abi =3D bpf_jit_arg_abi();
+
+	for (i =3D 0, slots_used =3D 0; i < nargs; i++) {
+		u32 nslots =3D btf_func_model_arg_slots(fm, i);
+
+		if (!abi && nslots > 1) {
+			t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
 			verbose(env,
 				"Function %s arg#%d type %s cannot be passed at "
 				"argument slot %d on this architecture\n",
@@ -14405,7 +14478,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 	if (bpf_is_kfunc_pkt_changing(&meta))
 		clear_all_pkt_pointers(env);
=20
-	proto_slots =3D kfunc_proto_slots(desc_btf, meta.func_proto);
+	proto_slots =3D kfunc_abi_slots(&desc->func_model);
 	if (proto_slots > MAX_BPF_FUNC_REG_ARGS) {
 		struct bpf_func_state *caller =3D cur_func(env);
 		struct bpf_subprog_info *caller_info =3D &env->subprog_info[caller->su=
bprogno];
--=20
2.53.0-Meta

