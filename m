Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30315136358
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 04:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647850; cv=none; b=W4qTuVD+8UEexFG4dOfAQVVSKIdqVCvcdMH3TDYe5qPejdHj3qliEG6aq8fEiRwGkLlyPd1h3F0c6itCyIj/rAvjFssBWPebCa6Ub2/G8XpMFoi2RBHx6EQ5IVxJgKpVDFRov4Md6CN8sqtK5GJS8Fgr2ML6MtVN4HB5MYrNm68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647850; c=relaxed/simple;
	bh=ylQ5Wzp4puKaYBrH8xBXxJgMMmg9H8wHZ0ykRS9vTpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gs2OFyS5Rf3+wX51Qa3Ts/f8oGTxMQg7d3vELgk6BPr/dHbTCWciqRty5dQJ/7VVR4JzKg/rI72ASDxDHczx8XmP+OuURaAYyIuz60NN0XWREblx2wxn9YknG7+0cKKnLqtTEVzGl8CwFdWi7vROZ9aeSVMTxo9bA9KtNwKm+Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E656DB194C168; Tue, 12 May 2026 21:50:43 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 10/25] bpf: Extend liveness analysis to track stack argument slots
Date: Tue, 12 May 2026 21:50:40 -0700
Message-ID: <20260513045043.2389049-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513044949.2382019-1-yonghong.song@linux.dev>
References: <20260513044949.2382019-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

BPF_REG_PARAMS (R11) is at index MAX_BPF_REG, which is beyond the
register tracking arrays in const_fold.c and liveness.c. Handle it
explicitly to avoid out-of-bounds accesses.

Extend the arg tracking dataflow to cover stack arg slots. Otherwise,
pointers passed through stack args are invisible to liveness, causing
the pointed-to stack slots to be incorrectly poisoned.

Extend the at_out tracking array to MAX_AT_TRACK_REGS (registers
plus stack arg slots) so that outgoing stack arg stores are tracked
alongside registers. Add a separate at_stack_arg_entry array in
compute_subprog_args(), passed to arg_track_xfer(), to restore
FP-derived values on incoming stack arg reads.

Extend record_call_access() to check stack arg slots for FP-derived
pointers at kfunc call sites, reusing the record_arg_access() helper
extracted in the previous patch. Pass stack arg state from caller to
callee in analyze_subprog() so that callees can track pointers received
through stack args, hence avoid poisoning.

Skip stack arg instructions in record_load_store_access(). Stack arg
STX uses dst_reg=3DBPF_REG_PARAMS (index 11), but at[11] is repurposed
to track the value stored in stack arg slot 0. Without the skip, if a
prior stack arg STX stored an FP-derived pointer (e.g., fp-64) into
slot 0, a subsequent stack arg STX would read that FP-derived value as
the base pointer and spuriously mark a regular stack slot (e.g., fp-72
from -64 + -8) as accessed in the liveness bitmap.

Extend arg_track_log() to log state transitions for outgoing stack arg
slots at indices MAX_BPF_REG through MAX_AT_TRACK_REGS-1. Without this,
changes to at_out[11..17] caused by stack arg store instructions are
silently omitted from BPF_LOG_LEVEL2 output. For example, when a
caller passes fp-64 through a stack argument:

  subprog#0:
   10: (bf) r6 =3D r10
   11: (07) r6 +=3D -64
   12: (7b) *(u64 *)(r11 -8) =3D r6
	sa0: none -> fp0-64
   13: (85) call pc+5

Without the fix, the "sa0: none -> fp0-64" transition at insn 12
would not appear.

Extend print_subprog_arg_access() to include stack arg slots in the
per-instruction FP-derived state dump. For example:

  subprog#0:
   12: (7b) *(u64 *)(r11 - 8) =3D r6  // r6=3Dfp0-64
   13: (85) call pc+5              // r6=3Dfp0-64 sa0=3Dfp0-64

Without the fix, the "sa0=3Dfp0-64" annotation at insn 13 would not
appear, making it harder to debug liveness analysis for programs
that pass FP-derived pointers through stack arguments.

Extend has_fp_args() to also check stack arg slots for FP-derived
pointers, so that callees receiving pointers only through stack args
are still recursively analyzed.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/const_fold.c |   8 +++
 kernel/bpf/liveness.c   | 114 ++++++++++++++++++++++++++++++++++------
 2 files changed, 106 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
index db73c4740b1e..b2a19acadb91 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -58,6 +58,14 @@ static void const_reg_xfer(struct bpf_verifier_env *en=
v, struct const_arg_info *
 	u8 opcode =3D BPF_OP(insn->code) | BPF_SRC(insn->code);
 	int r;
=20
+	/* Stack arg stores (r11-based) are outside the tracked register set. *=
/
+	if (is_stack_arg_st(insn) || is_stack_arg_stx(insn))
+		return;
+	if (is_stack_arg_ldx(insn)) {
+		ci_out[insn->dst_reg] =3D unknown;
+		return;
+	}
+
 	switch (class) {
 	case BPF_ALU:
 	case BPF_ALU64:
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 13dc5ae44d2b..7f4a0e4c2c49 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -610,6 +610,21 @@ enum arg_track_state {
 /* Track callee stack slots fp-8 through fp-512 (64 slots of 8 bytes eac=
h) */
 #define MAX_ARG_SPILL_SLOTS 64
=20
+/*
+ * Combined register + stack arg tracking: R0-R10 at indices 0-10,
+ * outgoing stack arg slots at indices MAX_BPF_REG..MAX_BPF_REG+6.
+ */
+#define MAX_AT_TRACK_REGS (MAX_BPF_REG + MAX_STACK_ARG_SLOTS)
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
@@ -1032,6 +1047,21 @@ static void arg_track_log(struct bpf_verifier_env =
*env, struct bpf_insn *insn, i
 		verbose(env, "\tr%d: ", i); verbose_arg_track(env, &at_in[i]);
 		verbose(env, " -> "); verbose_arg_track(env, &at_out[i]);
 	}
+	/* Log outgoing stack arg slot transitions at indices MAX_BPF_REG..MAX_=
AT_TRACK_REGS-1 */
+	for (i =3D 0; i < MAX_STACK_ARG_SLOTS; i++) {
+		int ai =3D MAX_BPF_REG + i;
+
+		if (arg_track_eq(&at_out[ai], &at_in[ai]))
+			continue;
+		if (!printed) {
+			verbose(env, "%3d: ", idx);
+			bpf_verbose_insn(env, insn);
+			bpf_vlog_reset(&env->log, env->log.end_pos - 1);
+			printed =3D true;
+		}
+		verbose(env, "\tsa%d: ", i); verbose_arg_track(env, &at_in[ai]);
+		verbose(env, " -> "); verbose_arg_track(env, &at_out[ai]);
+	}
 	for (i =3D 0; i < MAX_ARG_SPILL_SLOTS; i++) {
 		if (arg_track_eq(&at_stack_out[i], &at_stack_in[i]))
 			continue;
@@ -1062,6 +1092,7 @@ static bool can_be_local_fp(int depth, int regno, s=
truct arg_track *at)
 static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn=
 *insn,
 			   int insn_idx,
 			   struct arg_track *at_out, struct arg_track *at_stack_out,
+			   const struct arg_track *at_stack_arg_entry,
 			   struct func_instance *instance,
 			   u32 *callsites)
 {
@@ -1071,9 +1102,21 @@ static void arg_track_xfer(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
 	struct arg_track *dst =3D &at_out[insn->dst_reg];
 	struct arg_track *src =3D &at_out[insn->src_reg];
 	struct arg_track none =3D { .frame =3D ARG_NONE };
-	int r;
-
-	if (class =3D=3D BPF_ALU64 && BPF_SRC(insn->code) =3D=3D BPF_K) {
+	int r, slot;
+
+	/* Handle stack arg stores and loads. */
+	if (is_stack_arg_st(insn) || is_stack_arg_stx(insn)) {
+		slot =3D stack_arg_off_to_slot(insn->off);
+		if (slot >=3D 0) {
+			if (is_stack_arg_stx(insn))
+				at_out[MAX_BPF_REG + slot] =3D at_out[insn->src_reg];
+			else
+				at_out[MAX_BPF_REG + slot] =3D none;
+		}
+	} else if (is_stack_arg_ldx(insn)) {
+		slot =3D stack_arg_off_to_slot(insn->off);
+		at_out[insn->dst_reg] =3D (slot >=3D 0) ? at_stack_arg_entry[slot] : n=
one;
+	} else if (class =3D=3D BPF_ALU64 && BPF_SRC(insn->code) =3D=3D BPF_K) =
{
 		if (code =3D=3D BPF_MOV) {
 			*dst =3D none;
 		} else if (dst->frame >=3D 0) {
@@ -1297,6 +1340,16 @@ static int record_load_store_access(struct bpf_ver=
ifier_env *env,
 	struct arg_track resolved, *ptr;
 	int oi;
=20
+	/*
+	 * Stack arg insns use dst_reg/src_reg=3DBPF_REG_PARAMS(11). Since at[]
+	 * is extended to MAX_AT_TRACK_REGS, at[11] holds the arg_track for
+	 * outgoing stack arg slot 0 =E2=80=94 not the pointer used for the mem=
ory
+	 * access. Skip so the slot's tracked value isn't confused with the
+	 * base register that record_stack_access() expects.
+	 */
+	if (is_stack_arg_stx(insn) || is_stack_arg_st(insn) || is_stack_arg_ldx=
(insn))
+		return 0;
+
 	switch (class) {
 	case BPF_LDX:
 		ptr =3D &at[insn->src_reg];
@@ -1395,11 +1448,18 @@ static int record_call_access(struct bpf_verifier=
_env *env,
 	if (bpf_get_call_summary(env, insn, &cs))
 		num_params =3D cs.num_params;
=20
-	for (r =3D BPF_REG_1; r < BPF_REG_1 + num_params; r++) {
+	for (r =3D BPF_REG_1; r < BPF_REG_1 + min(num_params, MAX_BPF_FUNC_REG_=
ARGS); r++) {
 		err =3D record_arg_access(env, instance, insn, &at[r], r - 1, insn_idx=
);
 		if (err)
 			return err;
 	}
+
+	for (r =3D 0; r < MAX_STACK_ARG_SLOTS && r < num_params - MAX_BPF_FUNC_=
REG_ARGS; r++) {
+		err =3D record_arg_access(env, instance, insn, &at[MAX_BPF_REG + r],
+					r + MAX_BPF_FUNC_REG_ARGS, insn_idx);
+		if (err)
+			return err;
+	}
 	return 0;
 }
=20
@@ -1456,7 +1516,7 @@ static int find_callback_subprog(struct bpf_verifie=
r_env *env,
=20
 /* Per-subprog intermediate state kept alive across analysis phases */
 struct subprog_at_info {
-	struct arg_track (*at_in)[MAX_BPF_REG];
+	struct arg_track (*at_in)[MAX_AT_TRACK_REGS];
 	int len;
 };
=20
@@ -1490,6 +1550,9 @@ static void print_subprog_arg_access(struct bpf_ver=
ifier_env *env,
 			for (r =3D 0; r < MAX_BPF_REG - 1; r++)
 				if (arg_is_fp(&info->at_in[i][r]))
 					has_extra =3D true;
+			for (r =3D 0; r < MAX_STACK_ARG_SLOTS; r++)
+				if (arg_is_fp(&info->at_in[i][MAX_BPF_REG + r]))
+					has_extra =3D true;
 		}
 		if (is_ldx_stx_call) {
 			for (r =3D 0; r < MAX_ARG_SPILL_SLOTS; r++)
@@ -1514,6 +1577,12 @@ static void print_subprog_arg_access(struct bpf_ve=
rifier_env *env,
 				verbose(env, " r%d=3D", r);
 				verbose_arg_track(env, &info->at_in[i][r]);
 			}
+			for (r =3D 0; r < MAX_STACK_ARG_SLOTS; r++) {
+				if (!arg_is_fp(&info->at_in[i][MAX_BPF_REG + r]))
+					continue;
+				verbose(env, " sa%d=3D", r);
+				verbose_arg_track(env, &info->at_in[i][MAX_BPF_REG + r]);
+			}
 		}
=20
 		if (is_ldx_stx_call) {
@@ -1536,7 +1605,7 @@ static void print_subprog_arg_access(struct bpf_ver=
ifier_env *env,
  * Runs forward fixed-point with arg_track_xfer(), then records
  * memory accesses in a single linear pass over converged state.
  *
- * @callee_entry: pre-populated entry state for R1-R5
+ * @callee_entry: pre-populated entry state for R1-R5 and stack args
  *                NULL for main (subprog 0).
  * @info:         stores at_in, len for debug printing.
  */
@@ -1554,10 +1623,11 @@ static int compute_subprog_args(struct bpf_verifi=
er_env *env,
 	int end =3D env->subprog_info[subprog + 1].start;
 	int po_end =3D env->subprog_info[subprog + 1].postorder_start;
 	int len =3D end - start;
-	struct arg_track (*at_in)[MAX_BPF_REG] =3D NULL;
-	struct arg_track at_out[MAX_BPF_REG];
+	struct arg_track (*at_in)[MAX_AT_TRACK_REGS] =3D NULL;
+	struct arg_track at_out[MAX_AT_TRACK_REGS];
 	struct arg_track (*at_stack_in)[MAX_ARG_SPILL_SLOTS] =3D NULL;
 	struct arg_track *at_stack_out =3D NULL;
+	struct arg_track at_stack_arg_entry[MAX_STACK_ARG_SLOTS];
 	struct arg_track unvisited =3D { .frame =3D ARG_UNVISITED };
 	struct arg_track none =3D { .frame =3D ARG_NONE };
 	bool changed;
@@ -1576,13 +1646,13 @@ static int compute_subprog_args(struct bpf_verifi=
er_env *env,
 		goto err_free;
=20
 	for (i =3D 0; i < len; i++) {
-		for (r =3D 0; r < MAX_BPF_REG; r++)
+		for (r =3D 0; r < MAX_AT_TRACK_REGS; r++)
 			at_in[i][r] =3D unvisited;
 		for (r =3D 0; r < MAX_ARG_SPILL_SLOTS; r++)
 			at_stack_in[i][r] =3D unvisited;
 	}
=20
-	for (r =3D 0; r < MAX_BPF_REG; r++)
+	for (r =3D 0; r < MAX_AT_TRACK_REGS; r++)
 		at_in[0][r] =3D none;
=20
 	/* Entry: R10 is always precisely the current frame's FP */
@@ -1598,6 +1668,10 @@ static int compute_subprog_args(struct bpf_verifie=
r_env *env,
 	for (r =3D 0; r < MAX_ARG_SPILL_SLOTS; r++)
 		at_stack_in[0][r] =3D none;
=20
+	/* Entry: incoming stack args from caller, or ARG_NONE for main */
+	for (r =3D 0; r < MAX_STACK_ARG_SLOTS; r++)
+		at_stack_arg_entry[r] =3D callee_entry ? callee_entry[MAX_BPF_REG + r]=
 : none;
+
 	if (env->log.level & BPF_LOG_LEVEL2)
 		verbose(env, "subprog#%d: analyzing (depth %d)...\n", subprog, depth);
=20
@@ -1616,7 +1690,8 @@ static int compute_subprog_args(struct bpf_verifier=
_env *env,
 		memcpy(at_out, at_in[i], sizeof(at_out));
 		memcpy(at_stack_out, at_stack_in[i], MAX_ARG_SPILL_SLOTS * sizeof(*at_=
stack_out));
=20
-		arg_track_xfer(env, insn, idx, at_out, at_stack_out, instance, callsit=
es);
+		arg_track_xfer(env, insn, idx, at_out, at_stack_out,
+			       at_stack_arg_entry, instance, callsites);
 		arg_track_log(env, insn, idx, at_in[i], at_stack_in[i], at_out, at_sta=
ck_out);
=20
 		/* Propagate to successors within this subprogram */
@@ -1630,7 +1705,7 @@ static int compute_subprog_args(struct bpf_verifier=
_env *env,
 				continue;
 			ti =3D target - start;
=20
-			for (r =3D 0; r < MAX_BPF_REG; r++)
+			for (r =3D 0; r < MAX_AT_TRACK_REGS; r++)
 				changed |=3D arg_track_join(env, idx, target, r,
 							  &at_in[ti][r], at_out[r]);
=20
@@ -1685,12 +1760,15 @@ static int compute_subprog_args(struct bpf_verifi=
er_env *env,
 	return err;
 }
=20
-/* Return true if any of R1-R5 is derived from a frame pointer. */
+/* Return true if any of R1-R5 or stack args is derived from a frame poi=
nter. */
 static bool has_fp_args(struct arg_track *args)
 {
 	for (int r =3D BPF_REG_1; r <=3D BPF_REG_5; r++)
 		if (arg_is_fp(&args[r]))
 			return true;
+	for (int r =3D 0; r < MAX_STACK_ARG_SLOTS; r++)
+		if (arg_is_fp(&args[MAX_BPF_REG + r]))
+			return true;
 	return false;
 }
=20
@@ -1814,7 +1892,7 @@ static int analyze_subprog(struct bpf_verifier_env =
*env,
 	/* For each reachable call site in the subprog, recurse into callees */
 	for (int p =3D po_start; p < po_end; p++) {
 		int idx =3D env->cfg.insn_postorder[p];
-		struct arg_track callee_args[BPF_REG_5 + 1];
+		struct arg_track callee_args[MAX_AT_TRACK_REGS] =3D {};
 		struct arg_track none =3D { .frame =3D ARG_NONE };
 		struct bpf_insn *insn =3D &insns[idx];
 		struct func_instance *callee_instance;
@@ -1829,9 +1907,11 @@ static int analyze_subprog(struct bpf_verifier_env=
 *env,
 			if (callee < 0)
 				continue;
=20
-			/* Build entry args: R1-R5 from at_in at call site */
+			/* Build entry args: R1-R5 and stack args from at_in at call site */
 			for (int r =3D BPF_REG_1; r <=3D BPF_REG_5; r++)
 				callee_args[r] =3D info[subprog].at_in[j][r];
+			for (int r =3D 0; r < MAX_STACK_ARG_SLOTS; r++)
+				callee_args[MAX_BPF_REG + r] =3D info[subprog].at_in[j][MAX_BPF_REG =
+ r];
 		} else if (bpf_calls_callback(env, idx)) {
 			callee =3D find_callback_subprog(env, insn, idx, &caller_reg, &cb_cal=
lee_reg);
 			if (callee =3D=3D -2) {
@@ -1853,6 +1933,8 @@ static int analyze_subprog(struct bpf_verifier_env =
*env,
=20
 			for (int r =3D BPF_REG_1; r <=3D BPF_REG_5; r++)
 				callee_args[r] =3D none;
+			for (int r =3D 0; r < MAX_STACK_ARG_SLOTS; r++)
+				callee_args[MAX_BPF_REG + r] =3D none;
 			callee_args[cb_callee_reg] =3D info[subprog].at_in[j][caller_reg];
 		} else {
 			continue;
@@ -2096,7 +2178,7 @@ static void compute_insn_live_regs(struct bpf_verif=
ier_env *env,
 			def =3D ALL_CALLER_SAVED_REGS;
 			use =3D def & ~BIT(BPF_REG_0);
 			if (bpf_get_call_summary(env, insn, &cs))
-				use =3D GENMASK(cs.num_params, 1);
+				use =3D GENMASK(min_t(u8, cs.num_params, MAX_BPF_FUNC_REG_ARGS), 1);
 			break;
 		default:
 			def =3D 0;
--=20
2.53.0-Meta

