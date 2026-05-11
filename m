Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56B836607F
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 05:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778477641; cv=none; b=gzZcl99ov52xIDxye8UaVDFMmw53CdTO4dGOFWGG79hMpNrz0ZLnK4SdYjLzVTwjRyLQofXaFvqubUq82TYCXxf63lmnJloGPYZ1DXblE7qVHyWolIbY0M3W9QxiV8f7SgMOljQTxQUkEWfDhcoJUs6A4ySEd4+WmxI0Z+26fpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778477641; c=relaxed/simple;
	bh=47TesZ7Ee+Hk6106ky8iC9nYZy/g0umWiGjC2dNMHzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TA4baE+Ekw2waipgSkewef0ntoTKXufDrCA4w04ZZZVgT/KQ5cZvQVCRyovlmSqf0MEd5oEnJ0e6PGO5lFd9i5ZPoZdQNTiRzgE06XtL+/vDwbi6FV4jkvEEQ/xseMeTL+ylyvmss5gBm5q213mgpNEstxcwDoqsLx9tv1fXzdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 1CC46A59DBEDD; Sun, 10 May 2026 22:33:48 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 09/24] bpf: Extend liveness analysis to track stack argument slots
Date: Sun, 10 May 2026 22:33:48 -0700
Message-ID: <20260511053348.1885300-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260511053301.1878610-1-yonghong.song@linux.dev>
References: <20260511053301.1878610-1-yonghong.song@linux.dev>
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

Extend the arg tracking dataflow to cover stack arg slots. Otherwise,
pointers passed through stack args are invisible to liveness, causing
the pointed-to stack slots to be incorrectly poisoned.

Extend the at_out tracking array to MAX_AT_TRACK_REGS (registers
plus stack arg slots) so that outgoing stack arg stores are tracked
alongside registers. Add a separate at_stack_arg_entry array in
arg_track_xfer() to restore FP-derived values on incoming stack arg
reads.

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

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/const_fold.c |   8 +++
 kernel/bpf/liveness.c   | 115 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 109 insertions(+), 14 deletions(-)

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
index c81337dfbfc7..6527631de758 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -610,6 +610,24 @@ enum arg_track_state {
 /* Track callee stack slots fp-8 through fp-512 (64 slots of 8 bytes eac=
h) */
 #define MAX_ARG_SPILL_SLOTS 64
=20
+/* Track stack arg slots: outgoing starts at -(i+1)*8, incoming at +(i+1=
)*8 */
+#define MAX_STACK_ARG_SLOTS (MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS)
+
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
@@ -1032,6 +1050,21 @@ static void arg_track_log(struct bpf_verifier_env =
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
@@ -1062,6 +1095,7 @@ static bool can_be_local_fp(int depth, int regno, s=
truct arg_track *at)
 static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn=
 *insn,
 			   int insn_idx,
 			   struct arg_track *at_out, struct arg_track *at_stack_out,
+			   const struct arg_track *at_stack_arg_entry,
 			   struct func_instance *instance,
 			   u32 *callsites)
 {
@@ -1071,8 +1105,24 @@ static void arg_track_xfer(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
 	struct arg_track *dst =3D &at_out[insn->dst_reg];
 	struct arg_track *src =3D &at_out[insn->src_reg];
 	struct arg_track none =3D { .frame =3D ARG_NONE };
-	int r;
-
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
+		return;
+	}
+	if (is_stack_arg_ldx(insn)) {
+		slot =3D stack_arg_off_to_slot(insn->off);
+		at_out[insn->dst_reg] =3D (slot >=3D 0) ? at_stack_arg_entry[slot] : n=
one;
+		return;
+	}
 	if (class =3D=3D BPF_ALU64 && BPF_SRC(insn->code) =3D=3D BPF_K) {
 		if (code =3D=3D BPF_MOV) {
 			*dst =3D none;
@@ -1297,6 +1347,14 @@ static int record_load_store_access(struct bpf_ver=
ifier_env *env,
 	struct arg_track resolved, *ptr;
 	int oi;
=20
+	/*
+	 * Stack arg insns use dst_reg=3DBPF_REG_PARAMS(11), but at[11] tracks
+	 * the value stored in stack arg slot 0, not a memory base pointer.
+	 * Skip to avoid misinterpreting that value as an FP-derived pointer.
+	 */
+	if (is_stack_arg_stx(insn) || is_stack_arg_st(insn) || is_stack_arg_ldx=
(insn))
+		return 0;
+
 	switch (class) {
 	case BPF_LDX:
 		ptr =3D &at[insn->src_reg];
@@ -1395,11 +1453,18 @@ static int record_call_access(struct bpf_verifier=
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
@@ -1456,7 +1521,7 @@ static int find_callback_subprog(struct bpf_verifie=
r_env *env,
=20
 /* Per-subprog intermediate state kept alive across analysis phases */
 struct subprog_at_info {
-	struct arg_track (*at_in)[MAX_BPF_REG];
+	struct arg_track (*at_in)[MAX_AT_TRACK_REGS];
 	int len;
 };
=20
@@ -1490,6 +1555,9 @@ static void print_subprog_arg_access(struct bpf_ver=
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
@@ -1514,6 +1582,12 @@ static void print_subprog_arg_access(struct bpf_ve=
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
@@ -1554,10 +1628,11 @@ static int compute_subprog_args(struct bpf_verifi=
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
@@ -1576,19 +1651,19 @@ static int compute_subprog_args(struct bpf_verifi=
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
 	at_in[0][BPF_REG_FP] =3D arg_single(depth, 0);
=20
-	/* R1-R5: from caller or ARG_NONE for main */
+	/* R1-R5 and outgoing stack args: from caller or ARG_NONE for main */
 	if (callee_entry) {
 		for (r =3D BPF_REG_1; r <=3D BPF_REG_5; r++)
 			at_in[0][r] =3D callee_entry[r];
@@ -1598,6 +1673,10 @@ static int compute_subprog_args(struct bpf_verifie=
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
@@ -1616,7 +1695,8 @@ static int compute_subprog_args(struct bpf_verifier=
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
@@ -1630,7 +1710,7 @@ static int compute_subprog_args(struct bpf_verifier=
_env *env,
 				continue;
 			ti =3D target - start;
=20
-			for (r =3D 0; r < MAX_BPF_REG; r++)
+			for (r =3D 0; r < MAX_AT_TRACK_REGS; r++)
 				changed |=3D arg_track_join(env, idx, target, r,
 							  &at_in[ti][r], at_out[r]);
=20
@@ -1685,12 +1765,15 @@ static int compute_subprog_args(struct bpf_verifi=
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
 		if (args[r].frame !=3D ARG_NONE)
 			return true;
+	for (int r =3D 0; r < MAX_STACK_ARG_SLOTS; r++)
+		if (arg_is_fp(&args[MAX_BPF_REG + r]))
+			return true;
 	return false;
 }
=20
@@ -1814,7 +1897,7 @@ static int analyze_subprog(struct bpf_verifier_env =
*env,
 	/* For each reachable call site in the subprog, recurse into callees */
 	for (int p =3D po_start; p < po_end; p++) {
 		int idx =3D env->cfg.insn_postorder[p];
-		struct arg_track callee_args[BPF_REG_5 + 1];
+		struct arg_track callee_args[MAX_AT_TRACK_REGS] =3D {};
 		struct arg_track none =3D { .frame =3D ARG_NONE };
 		struct bpf_insn *insn =3D &insns[idx];
 		struct func_instance *callee_instance;
@@ -1829,9 +1912,11 @@ static int analyze_subprog(struct bpf_verifier_env=
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
@@ -1853,6 +1938,8 @@ static int analyze_subprog(struct bpf_verifier_env =
*env,
=20
 			for (int r =3D BPF_REG_1; r <=3D BPF_REG_5; r++)
 				callee_args[r] =3D none;
+			for (int r =3D 0; r < MAX_STACK_ARG_SLOTS; r++)
+				callee_args[MAX_BPF_REG + r] =3D none;
 			callee_args[cb_callee_reg] =3D info[subprog].at_in[j][caller_reg];
 		} else {
 			continue;
--=20
2.53.0-Meta

