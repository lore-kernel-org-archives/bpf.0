Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E356F3E1CE2
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050897; cv=none; b=YPK0WcpNOw6Kb4j31C6zAt+o7lOZE2uP85zzA2mtsrgFlnlrnWf2HnWhRn9g+YE7r0rJ5Mwl5yBdq4av2C0BXCbR1mCzrMQmwHLZtsIPUD9PKOGvBLsxBvFITzPDeffRbQhoIkzYeaySluoBJ2Rhopf3U/Wuc231lY5JE1KXcBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050897; c=relaxed/simple;
	bh=7t23y806Qkepvvz0AVVv5lV8K/Wzb1K6O4bjHQgDMu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Es3XduP4mS+AumxPHtlvTu5Lj5aEXq4vX+0ZLAKZ7M3mGu2IzqT00SX0ZSGMLM3fXC9y8ESRD8kqp0l4NxgkwrZjB3EwB/mOMdicUzA5eJcgFGpfP6wwTUlnS7uktibrm6lodlzgOEGrXjfrc57CoXmW1d/t+A79cTGzDKaGxQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 2DC48474A646C; Fri, 24 Apr 2026 10:14:54 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 04/18] bpf: Extend liveness analysis to track stack argument slots
Date: Fri, 24 Apr 2026 10:14:54 -0700
Message-ID: <20260424171454.2035580-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260424171433.2034470-1-yonghong.song@linux.dev>
References: <20260424171433.2034470-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

BPF_REG_PARAMS (R11) is at index MAX_BPF_REG, which is beyond the
register tracking arrays in const_fold.c and liveness.c. Handle it
explicitly to avoid out-of-bounds accesses.

In liveness.c, extend the arg tracking dataflow to cover stack arg
slots. Otherwise, pointers passed through stack args are invisible
to liveness, causing the pointed-to stack slots to be incorrectly
poisoned.

Add a parallel tracking array (at_stack_arg_out/at_stack_arg_entry)
in arg_track_xfer() to record FP-derived values stored to outgoing
stack arg slots and to restore them on incoming reads. Extend
record_call_access() to check stack arg slots for FP-derived
pointers at kfunc call sites, reusing the record_arg_access() helper
extracted in the previous patch. Pass stack arg state from caller to
callee in analyze_subprog() so that callees can track pointers
received through stack args.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |   2 +
 kernel/bpf/const_fold.c      |  13 +++-
 kernel/bpf/liveness.c        | 133 ++++++++++++++++++++++++++++++++---
 3 files changed, 135 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 735f33ad3db7..de723d27da94 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -905,6 +905,8 @@ struct bpf_verifier_env {
 	struct bpf_jmp_history_entry *cur_hist_ent;
 	/* Per-callsite copy of parent's converged at_stack_in for cross-frame =
fills. */
 	struct arg_track **callsite_at_stack;
+	/* Per-callsite stack arg state for cross-frame stack arg tracking. */
+	struct arg_track **callsite_at_stack_arg;
 	u32 pass_cnt; /* number of times do_check() was called */
 	u32 subprog_cnt;
 	/* number of instructions analyzed by the verifier */
diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
index db73c4740b1e..b65285d61efe 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -51,13 +51,22 @@ static void const_reg_xfer(struct bpf_verifier_env *e=
nv, struct const_arg_info *
 			   struct bpf_insn *insn, struct bpf_insn *insns, int idx)
 {
 	struct const_arg_info unknown =3D { .state =3D CONST_ARG_UNKNOWN, .val =
=3D 0 };
-	struct const_arg_info *dst =3D &ci_out[insn->dst_reg];
-	struct const_arg_info *src =3D &ci_out[insn->src_reg];
+	struct const_arg_info *dst, *src;
 	u8 class =3D BPF_CLASS(insn->code);
 	u8 mode =3D BPF_MODE(insn->code);
 	u8 opcode =3D BPF_OP(insn->code) | BPF_SRC(insn->code);
 	int r;
=20
+	/* Stack arguments use BPF_REG_PARAMS which is outside the tracked regi=
ster set. */
+	if (insn->dst_reg =3D=3D BPF_REG_PARAMS)
+		return;
+	if (insn->src_reg =3D=3D BPF_REG_PARAMS) {
+		ci_out[insn->dst_reg] =3D unknown;
+		return;
+	}
+
+	dst =3D &ci_out[insn->dst_reg];
+	src =3D &ci_out[insn->src_reg];
 	switch (class) {
 	case BPF_ALU:
 	case BPF_ALU64:
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 1b45621d652c..b60b5fdae9b9 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -610,6 +610,18 @@ enum arg_track_state {
 /* Track callee stack slots fp-8 through fp-512 (64 slots of 8 bytes eac=
h) */
 #define MAX_ARG_SPILL_SLOTS 64
=20
+/* Stack arg slots: outgoing at -(i+1)*8, incoming at +(i+1)*8 */
+#define MAX_STACK_ARG_SLOTS (MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS)
+
+static int stack_arg_off_to_slot(s16 off)
+{
+	int aoff =3D off < 0 ? -off : off;
+
+	if (aoff / 8 > MAX_STACK_ARG_SLOTS)
+		return -1;
+	return aoff / 8 - 1;
+}
+
 static bool arg_is_visited(const struct arg_track *at)
 {
 	return at->frame !=3D ARG_UNVISITED;
@@ -1062,17 +1074,37 @@ static bool can_be_local_fp(int depth, int regno,=
 struct arg_track *at)
 static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn=
 *insn,
 			   int insn_idx,
 			   struct arg_track *at_out, struct arg_track *at_stack_out,
+			   struct arg_track *at_stack_arg_out,
+			   const struct arg_track *at_stack_arg_entry,
 			   struct func_instance *instance,
 			   u32 *callsites)
 {
 	int depth =3D instance->depth;
 	u8 class =3D BPF_CLASS(insn->code);
 	u8 code =3D BPF_OP(insn->code);
-	struct arg_track *dst =3D &at_out[insn->dst_reg];
-	struct arg_track *src =3D &at_out[insn->src_reg];
+	struct arg_track *dst, *src;
 	struct arg_track none =3D { .frame =3D ARG_NONE };
-	int r;
+	int r, slot;
+
+	/* Handle stack arg stores and loads. */
+	if (insn->dst_reg =3D=3D BPF_REG_PARAMS) {
+		slot =3D stack_arg_off_to_slot(insn->off);
+		if (slot >=3D 0) {
+			if (class =3D=3D BPF_STX)
+				at_stack_arg_out[slot] =3D at_out[insn->src_reg];
+			else
+				at_stack_arg_out[slot] =3D none;
+		}
+		return;
+	}
+	if (insn->src_reg =3D=3D BPF_REG_PARAMS) {
+		slot =3D stack_arg_off_to_slot(insn->off);
+		at_out[insn->dst_reg] =3D (slot >=3D 0) ? at_stack_arg_entry[slot] : n=
one;
+		return;
+	}
=20
+	dst =3D &at_out[insn->dst_reg];
+	src =3D &at_out[insn->src_reg];
 	if (class =3D=3D BPF_ALU64 && BPF_SRC(insn->code) =3D=3D BPF_K) {
 		if (code =3D=3D BPF_MOV) {
 			*dst =3D none;
@@ -1385,6 +1417,7 @@ static int record_arg_access(struct bpf_verifier_en=
v *env,
 static int record_call_access(struct bpf_verifier_env *env,
 			      struct func_instance *instance,
 			      struct arg_track *at,
+			      struct arg_track *at_stack_arg,
 			      int insn_idx)
 {
 	struct bpf_insn *insn =3D &env->prog->insnsi[insn_idx];
@@ -1402,6 +1435,15 @@ static int record_call_access(struct bpf_verifier_=
env *env,
 		if (err)
 			return err > 0 ? 0 : err;
 	}
+
+	if (num_params <=3D MAX_BPF_FUNC_REG_ARGS)
+		return 0;
+	for (r =3D 0; r < MAX_STACK_ARG_SLOTS && r < num_params - MAX_BPF_FUNC_=
REG_ARGS; r++) {
+		err =3D record_arg_access(env, instance, insn, &at_stack_arg[r],
+					r + MAX_BPF_FUNC_REG_ARGS, insn_idx);
+		if (err)
+			return err > 0 ? 0 : err;
+	}
 	return 0;
 }
=20
@@ -1545,6 +1587,7 @@ static void print_subprog_arg_access(struct bpf_ver=
ifier_env *env,
 static int compute_subprog_args(struct bpf_verifier_env *env,
 				struct subprog_at_info *info,
 				struct arg_track *callee_entry,
+				struct arg_track *callee_stack_arg_entry,
 				struct func_instance *instance,
 				u32 *callsites)
 {
@@ -1560,6 +1603,9 @@ static int compute_subprog_args(struct bpf_verifier=
_env *env,
 	struct arg_track at_out[MAX_BPF_REG];
 	struct arg_track (*at_stack_in)[MAX_ARG_SPILL_SLOTS] =3D NULL;
 	struct arg_track *at_stack_out =3D NULL;
+	struct arg_track (*at_stack_arg_in)[MAX_STACK_ARG_SLOTS] =3D NULL;
+	struct arg_track at_stack_arg_out[MAX_STACK_ARG_SLOTS];
+	struct arg_track at_stack_arg_entry[MAX_STACK_ARG_SLOTS];
 	struct arg_track unvisited =3D { .frame =3D ARG_UNVISITED };
 	struct arg_track none =3D { .frame =3D ARG_NONE };
 	bool changed;
@@ -1569,6 +1615,10 @@ static int compute_subprog_args(struct bpf_verifie=
r_env *env,
 	if (!at_in)
 		goto err_free;
=20
+	at_stack_arg_in =3D kvmalloc_objs(*at_stack_arg_in, len, GFP_KERNEL_ACC=
OUNT);
+	if (!at_stack_arg_in)
+		goto err_free;
+
 	at_stack_in =3D kvmalloc_objs(*at_stack_in, len, GFP_KERNEL_ACCOUNT);
 	if (!at_stack_in)
 		goto err_free;
@@ -1582,6 +1632,8 @@ static int compute_subprog_args(struct bpf_verifier=
_env *env,
 			at_in[i][r] =3D unvisited;
 		for (r =3D 0; r < MAX_ARG_SPILL_SLOTS; r++)
 			at_stack_in[i][r] =3D unvisited;
+		for (r =3D 0; r < MAX_STACK_ARG_SLOTS; r++)
+			at_stack_arg_in[i][r] =3D unvisited;
 	}
=20
 	for (r =3D 0; r < MAX_BPF_REG; r++)
@@ -1600,6 +1652,12 @@ static int compute_subprog_args(struct bpf_verifie=
r_env *env,
 	for (r =3D 0; r < MAX_ARG_SPILL_SLOTS; r++)
 		at_stack_in[0][r] =3D none;
=20
+	/* Entry: incoming stack args from caller, or ARG_NONE for main */
+	for (r =3D 0; r < MAX_STACK_ARG_SLOTS; r++) {
+		at_stack_arg_entry[r] =3D callee_stack_arg_entry ? callee_stack_arg_en=
try[r] : none;
+		at_stack_arg_in[0][r] =3D none;
+	}
+
 	if (env->log.level & BPF_LOG_LEVEL2)
 		verbose(env, "subprog#%d: analyzing (depth %d)...\n", subprog, depth);
=20
@@ -1617,8 +1675,10 @@ static int compute_subprog_args(struct bpf_verifie=
r_env *env,
=20
 		memcpy(at_out, at_in[i], sizeof(at_out));
 		memcpy(at_stack_out, at_stack_in[i], MAX_ARG_SPILL_SLOTS * sizeof(*at_=
stack_out));
+		memcpy(at_stack_arg_out, at_stack_arg_in[i], sizeof(at_stack_arg_out))=
;
=20
-		arg_track_xfer(env, insn, idx, at_out, at_stack_out, instance, callsit=
es);
+		arg_track_xfer(env, insn, idx, at_out, at_stack_out,
+			       at_stack_arg_out, at_stack_arg_entry, instance, callsites);
 		arg_track_log(env, insn, idx, at_in[i], at_stack_in[i], at_out, at_sta=
ck_out);
=20
 		/* Propagate to successors within this subprogram */
@@ -1639,6 +1699,18 @@ static int compute_subprog_args(struct bpf_verifie=
r_env *env,
 			for (r =3D 0; r < MAX_ARG_SPILL_SLOTS; r++)
 				changed |=3D arg_track_join(env, idx, target, -r - 1,
 							  &at_stack_in[ti][r], at_stack_out[r]);
+
+			/*
+			 * Stack arg slots use indices after spill slots:
+			 * -(r + MAX_ARG_SPILL_SLOTS + 1) so that index * 8 in verbose loggin=
g
+			 * yields unique FP-relative offsets that don't * collide with spill =
slot
+			 * offsets -8..-512.
+			 */
+			for (r =3D 0; r < MAX_STACK_ARG_SLOTS; r++)
+				changed |=3D arg_track_join(env, idx, target,
+							  -(r + MAX_ARG_SPILL_SLOTS + 1),
+							  &at_stack_arg_in[ti][r],
+							  at_stack_arg_out[r]);
 		}
 	}
 	if (changed)
@@ -1655,7 +1727,7 @@ static int compute_subprog_args(struct bpf_verifier=
_env *env,
 			goto err_free;
=20
 		if (insn->code =3D=3D (BPF_JMP | BPF_CALL)) {
-			err =3D record_call_access(env, instance, at_in[i], idx);
+			err =3D record_call_access(env, instance, at_in[i], at_stack_arg_in[i=
], idx);
 			if (err)
 				goto err_free;
 		}
@@ -1671,6 +1743,17 @@ static int compute_subprog_args(struct bpf_verifie=
r_env *env,
 			}
 			memcpy(env->callsite_at_stack[idx],
 			       at_stack_in[i], sizeof(struct arg_track) * MAX_ARG_SPILL_SLOTS=
);
+
+			kvfree(env->callsite_at_stack_arg[idx]);
+			env->callsite_at_stack_arg[idx] =3D
+				kvmalloc_objs(*env->callsite_at_stack_arg[idx],
+					      MAX_STACK_ARG_SLOTS, GFP_KERNEL_ACCOUNT);
+			if (!env->callsite_at_stack_arg[idx]) {
+				err =3D -ENOMEM;
+				goto err_free;
+			}
+			memcpy(env->callsite_at_stack_arg[idx],
+			       at_stack_arg_in[i], sizeof(struct arg_track) * MAX_STACK_ARG_S=
LOTS);
 		}
 	}
=20
@@ -1683,6 +1766,7 @@ static int compute_subprog_args(struct bpf_verifier=
_env *env,
 err_free:
 	kvfree(at_stack_out);
 	kvfree(at_stack_in);
+	kvfree(at_stack_arg_in);
 	kvfree(at_in);
 	return err;
 }
@@ -1696,6 +1780,16 @@ static bool has_fp_args(struct arg_track *args)
 	return false;
 }
=20
+static bool has_fp_stack_args(struct arg_track *stack_args)
+{
+	if (!stack_args)
+		return false;
+	for (int r =3D 0; r < MAX_STACK_ARG_SLOTS; r++)
+		if (arg_is_fp(&stack_args[r]))
+			return true;
+	return false;
+}
+
 /*
  * Merge a freshly analyzed instance into the original.
  * may_read: union (any pass might read the slot).
@@ -1768,6 +1862,7 @@ static void free_instance(struct func_instance *ins=
tance)
  */
 static int analyze_subprog(struct bpf_verifier_env *env,
 			   struct arg_track *entry_args,
+			   struct arg_track *entry_stack_args,
 			   struct subprog_at_info *info,
 			   struct func_instance *instance,
 			   u32 *callsites)
@@ -1809,7 +1904,8 @@ static int analyze_subprog(struct bpf_verifier_env =
*env,
 	kvfree(info[subprog].at_in);
 	info[subprog].at_in =3D NULL;
=20
-	err =3D compute_subprog_args(env, &info[subprog], entry_args, instance,=
 callsites);
+	err =3D compute_subprog_args(env, &info[subprog], entry_args, entry_sta=
ck_args, instance,
+				   callsites);
 	if (err)
 		goto out_free;
=20
@@ -1817,6 +1913,7 @@ static int analyze_subprog(struct bpf_verifier_env =
*env,
 	for (int p =3D po_start; p < po_end; p++) {
 		int idx =3D env->cfg.insn_postorder[p];
 		struct arg_track callee_args[BPF_REG_5 + 1];
+		struct arg_track *callee_stack_args =3D NULL;
 		struct arg_track none =3D { .frame =3D ARG_NONE };
 		struct bpf_insn *insn =3D &insns[idx];
 		struct func_instance *callee_instance;
@@ -1834,6 +1931,7 @@ static int analyze_subprog(struct bpf_verifier_env =
*env,
 			/* Build entry args: R1-R5 from at_in at call site */
 			for (int r =3D BPF_REG_1; r <=3D BPF_REG_5; r++)
 				callee_args[r] =3D info[subprog].at_in[j][r];
+			callee_stack_args =3D env->callsite_at_stack_arg[idx];
 		} else if (bpf_calls_callback(env, idx)) {
 			callee =3D find_callback_subprog(env, insn, idx, &caller_reg, &cb_cal=
lee_reg);
 			if (callee =3D=3D -2) {
@@ -1860,7 +1958,7 @@ static int analyze_subprog(struct bpf_verifier_env =
*env,
 			continue;
 		}
=20
-		if (!has_fp_args(callee_args))
+		if (!has_fp_args(callee_args) && !has_fp_stack_args(callee_stack_args)=
)
 			continue;
=20
 		if (depth =3D=3D MAX_CALL_FRAMES - 1) {
@@ -1874,7 +1972,8 @@ static int analyze_subprog(struct bpf_verifier_env =
*env,
 			goto out_free;
 		}
 		callsites[depth] =3D idx;
-		err =3D analyze_subprog(env, callee_args, info, callee_instance, calls=
ites);
+		err =3D analyze_subprog(env, callee_args, callee_stack_args, info, cal=
lee_instance,
+				      callsites);
 		if (err)
 			goto out_free;
=20
@@ -1926,13 +2025,21 @@ int bpf_compute_subprog_arg_access(struct bpf_ver=
ifier_env *env)
 		kvfree(info);
 		return -ENOMEM;
 	}
+	env->callsite_at_stack_arg =3D kvzalloc_objs(*env->callsite_at_stack_ar=
g, insn_cnt,
+					      GFP_KERNEL_ACCOUNT);
+	if (!env->callsite_at_stack_arg) {
+		kvfree(env->callsite_at_stack);
+		env->callsite_at_stack =3D NULL;
+		kvfree(info);
+		return -ENOMEM;
+	}
=20
 	instance =3D call_instance(env, NULL, 0, 0);
 	if (IS_ERR(instance)) {
 		err =3D PTR_ERR(instance);
 		goto out;
 	}
-	err =3D analyze_subprog(env, NULL, info, instance, callsites);
+	err =3D analyze_subprog(env, NULL, NULL, info, instance, callsites);
 	if (err)
 		goto out;
=20
@@ -1958,7 +2065,7 @@ int bpf_compute_subprog_arg_access(struct bpf_verif=
ier_env *env)
 			err =3D PTR_ERR(instance);
 			goto out;
 		}
-		err =3D analyze_subprog(env, NULL, info, instance, callsites);
+		err =3D analyze_subprog(env, NULL, NULL, info, instance, callsites);
 		if (err)
 			goto out;
 	}
@@ -1967,10 +2074,14 @@ int bpf_compute_subprog_arg_access(struct bpf_ver=
ifier_env *env)
 		err =3D print_instances(env);
=20
 out:
-	for (k =3D 0; k < insn_cnt; k++)
+	for (k =3D 0; k < insn_cnt; k++) {
 		kvfree(env->callsite_at_stack[k]);
+		kvfree(env->callsite_at_stack_arg[k]);
+	}
 	kvfree(env->callsite_at_stack);
 	env->callsite_at_stack =3D NULL;
+	kvfree(env->callsite_at_stack_arg);
+	env->callsite_at_stack_arg =3D NULL;
 	for (k =3D 0; k < env->subprog_cnt; k++)
 		kvfree(info[k].at_in);
 	kvfree(info);
--=20
2.52.0

