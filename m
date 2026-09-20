Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2603D75CE
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 05:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882991; cv=none; b=jAX9K9+eh2731XleNkorc7Ajv9sb6CrG3f5bc70I5ZSQTyGmjmlvUX7zYxwxmP1Jeg5kfrBzxy0W5K3jzMZr1b2VDkDRKGaimTcdtuw93oDW1u4XJllfFQm+GLePl5+Hf/mxrzXY5AlGMyKbSJbvPeO9tJBYnQxgXpkeCZTlFP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882991; c=relaxed/simple;
	bh=NnboPvhi5QVWdYP//R3NnPivBxigcZH5Oi+w87RVbQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZPVlqN9HGivstFYEpIv/fd+izi+anTl4qQn4vlNTHWr0Eoz1B9KiiFlyehzN8jJobjCY+sfT0iBteq1lTuhFtj5eUFW9tV4Y+rt0U4VugWzMAo1MZOHSVyNDHgVJTCI+JV1nagyE+Ymhbwv8y/aS4dBlo5zSsfmZydZoS1N+wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 117E72BEBAB6D0; Sat, 19 Sep 2026 22:43:07 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 08/20] bpf: Walk the exception unwind in the verifier
Date: Sat, 19 Sep 2026 22:43:07 -0700
Message-ID: <20260920054307.868442-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920054225.864535-1-yonghong.song@linux.dev>
References: <20260920054225.864535-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

bpf_throw() is about to stop discarding the frames it unwinds and start
running their landing pads instead. Have the verifier walk the same thing=
,
step for step:

	at a throw, with the frame chain in env->cur_state->frame[]
	  if a record covers the call control is at
	      run that record's landing pad in this frame
	      on reaching its resume, pop the frame and carry on
	  else
	      pop the frame and carry on
	at the boundary, deliver

Doing it this way is what keeps the resource rules unchanged. Whatever a
pad releases is released in the verifier state too, so by the time the wa=
lk
reaches the boundary the state says exactly what the program will really
hold there -- and check_resource_leak(), which used to fire the moment a
throw was seen, simply moves to the end of the walk. A frame that no reco=
rd
covers contributes nothing, so anything it held is still held when the wa=
lk
ends, and that is what gets reported.

Two things about that walk have to be said out loud, because the
instruction stream does not say them.

A resume belongs to the frame whose landing pad the walker called. Each J=
IT
lowers bpf_unwind_resume() as the way back out of a pad -- a bare return =
on
x86-64, a branch to the saved address on arm64 -- and that reaches the
walker only from there. An exception being in flight is not enough to tel=
l:
a pad may call a subprogram that has a landing pad of its own and reaches
it by ordinary control flow, and the resume in it is in a pad body by eve=
ry
static measure. So the state records the frame the unwind entered a pad i=
n,
and a resume in any other frame is refused.

The edge from a throw to a pad crosses frames with no instruction in
between to account for them, and mark_chain_precision() walks that histor=
y
backwards. Left alone it stays in the pad's frame while it reads the
callee's instructions: a request for the pad frame's r6 is cleared by the
callee's own write to r6 -- so the caller's definition never becomes
precise -- or reaches the call instruction still set and trips "static
subprog unexpected regs". The history entry for a pad therefore records h=
ow
many frames the unwind popped, and the backtrack enters that many, the wa=
y
it enters one at a time for BPF_EXIT. A throwing global subprogram gets n=
o
frame of its own, and its exception arrives at the landing pad rather tha=
n
at the next instruction, which the global-call check has to allow for.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_cleanup_abi.h |  16 ++++
 include/linux/bpf_verifier.h    |   6 +-
 kernel/bpf/backtrack.c          |  21 ++++-
 kernel/bpf/states.c             |   6 ++
 kernel/bpf/verifier.c           | 143 ++++++++++++++++++++++++++------
 5 files changed, 163 insertions(+), 29 deletions(-)
 create mode 100644 include/linux/bpf_cleanup_abi.h

diff --git a/include/linux/bpf_cleanup_abi.h b/include/linux/bpf_cleanup_=
abi.h
new file mode 100644
index 000000000000..b6c1d589abda
--- /dev/null
+++ b/include/linux/bpf_cleanup_abi.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#ifndef _LINUX_BPF_CLEANUP_ABI_H
+#define _LINUX_BPF_CLEANUP_ABI_H
+
+/*
+ * Value arch_bpf_run_cleanup_pad() leaves in r0 on the way into a landi=
ng pad.
+ * It has to be a constant the verifier knows: LLVM names r0 as both the
+ * exception pointer and the exception selector register, so every pad r=
eads it
+ * before anything else and is free to store what it read. Kept on its o=
wn
+ * because the verifier and the arch dispatchers, which are assembly, ha=
ve to
+ * agree on it.
+ */
+#define BPF_PAD_ENTRY_R0	1
+
+#endif /* _LINUX_BPF_CLEANUP_ABI_H */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 382177b80745..0721461aaabb 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -429,7 +429,8 @@ struct bpf_jmp_history_entry {
 	u32 prev_idx : 20;
 	/* special INSN_F_xxx flags */
 	u32 flags : 4;
-	u32 : 8;
+	u32 unwind_frames : 4;	/* frames the unwind popped to get here */
+	u32 : 4;
 	/*
 	 * additional registers that need precision tracking when this
 	 * jump is backtracked, vector of five 11-bit records
@@ -509,6 +510,8 @@ struct bpf_verifier_state {
=20
 	bool speculative;
 	bool in_sleepable;
+	bool unwinding; /* an exception is in flight */
+	u8 unwind_frameno; /* the frame whose landing pad it entered */
=20
 	/* first and last insn idx of this verifier state */
 	u32 first_insn_idx;
@@ -991,6 +994,7 @@ struct bpf_verifier_env {
 	} cfg;
 	struct backtrack_state bt;
 	struct bpf_jmp_history_entry *cur_hist_ent;
+	u8 unwind_frames; /* scratch: pops for the insn about to be recorded */
 	/* Per-callsite copy of parent's converged at_stack_in for cross-frame =
fills. */
 	struct arg_track **callsite_at_stack;
 	u32 pass_cnt; /* number of times do_check() was called */
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 507a366dffa4..c19e4fe247ce 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -4,6 +4,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/filter.h>
 #include <linux/bitmap.h>
+#include "exception.h"
=20
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##ar=
gs)
=20
@@ -47,6 +48,7 @@ int bpf_push_jmp_history(struct bpf_verifier_env *env, =
struct bpf_verifier_state
 	p->flags =3D insn_flags;
 	p->spi =3D spi;
 	p->frame =3D frame;
+	p->unwind_frames =3D 0;
 	p->linked_regs =3D linked_regs;
 	cur->jmp_history_cnt =3D cnt;
 	env->cur_hist_ent =3D p;
@@ -419,10 +421,12 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx, int subseq_idx,
 				 * extra instructions from subprog; the next
 				 * instruction after call to global subprog
 				 * should be literally next instruction in
-				 * caller program
+				 * caller program -- or, if the callee threw,
+				 * the landing pad of this call site
 				 */
-				verifier_bug_if(idx + 1 !=3D subseq_idx, env,
-						"extra insn from subprog");
+				verifier_bug_if(idx + 1 !=3D subseq_idx &&
+						bpf_cleanup_pad_of_call(env, idx) !=3D subseq_idx,
+						env, "extra insn from subprog");
 				/* global subprog always sets R0 */
 				bt_clear_reg(bt, BPF_REG_0);
 				/* and if it does not set R2, main pass would catch it */
@@ -888,11 +892,11 @@ int bpf_mark_chain_precision(struct bpf_verifier_en=
v *env,
 		}
=20
 		for (i =3D last_idx;;) {
+			hist =3D get_jmp_hist_entry(st, history, i);
 			if (skip_first) {
 				err =3D 0;
 				skip_first =3D false;
 			} else {
-				hist =3D get_jmp_hist_entry(st, history, i);
 				err =3D backtrack_insn(env, i, subseq_idx, hist, bt);
 			}
 			if (err =3D=3D -ENOTSUPP) {
@@ -909,6 +913,15 @@ int bpf_mark_chain_precision(struct bpf_verifier_env=
 *env,
 				 */
 				return 0;
 			subseq_idx =3D i;
+			/* An exception unwind reached this insn, a landing
+			 * pad, from a throw or a resume that many frames
+			 * deeper. There is no insn in between to backtrack
+			 * over, so enter those frames here, the way BPF_EXIT
+			 * does one at a time.
+			 */
+			for (fr =3D 0; hist && fr < hist->unwind_frames; fr++)
+				if (bt_subprog_enter(bt))
+					return -EFAULT;
 			i =3D get_prev_insn_idx(st, i, &history);
 			if (i =3D=3D -ENOENT)
 				break;
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 66fb11b6c6a7..b101baa43171 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -996,6 +996,12 @@ static bool states_equal(struct bpf_verifier_env *en=
v,
 	if (old->in_sleepable !=3D cur->in_sleepable)
 		return false;
=20
+	if (old->unwinding !=3D cur->unwinding)
+		return false;
+
+	if (old->unwinding && old->unwind_frameno !=3D cur->unwind_frameno)
+		return false;
+
 	if (!refsafe(old, cur, &env->idmap_scratch))
 		return false;
=20
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 48fa94a582e7..6ca242d70a4c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
+#include <linux/bpf_cleanup_abi.h>
 #include <linux/bpf_verifier.h>
 #include <linux/filter.h>
 #include <net/netlink.h>
@@ -1715,6 +1716,8 @@ int bpf_copy_verifier_state(struct bpf_verifier_sta=
te *dst_state,
 		return err;
 	dst_state->speculative =3D src->speculative;
 	dst_state->in_sleepable =3D src->in_sleepable;
+	dst_state->unwinding =3D src->unwinding;
+	dst_state->unwind_frameno =3D src->unwind_frameno;
 	dst_state->curframe =3D src->curframe;
 	dst_state->branches =3D src->branches;
 	dst_state->parent =3D src->parent;
@@ -10558,8 +10561,8 @@ static int push_callback_call(struct bpf_verifier=
_env *env, struct bpf_insn *ins
 	return 0;
 }
=20
-static int process_bpf_exit_full(struct bpf_verifier_env *env,
-				 bool *do_print_state, bool exception_exit);
+static int process_bpf_exit_full(struct bpf_verifier_env *env, bool *do_=
print_state);
+static int unwind_step(struct bpf_verifier_env *env, u32 callsite, int *=
insn_idx);
=20
 static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn=
 *insn,
 			   int *insn_idx)
@@ -10649,7 +10652,7 @@ static int check_func_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn,
 				verbose(env, "failed to push state for global subprog exception path=
\n");
 				return PTR_ERR(branch);
 			}
-			return process_bpf_exit_full(env, NULL, true);
+			return unwind_step(env, *insn_idx, insn_idx);
 		}
=20
 		/* continue with next insn after call */
@@ -14550,7 +14553,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 		env->prog->call_session_cookie =3D true;
=20
 	if (bpf_is_throw_kfunc(insn))
-		return process_bpf_exit_full(env, NULL, true);
+		return unwind_step(env, insn_idx, &env->insn_idx);
=20
 	return 0;
 }
@@ -18475,9 +18478,103 @@ enum {
 	INSN_IDX_UPDATED =3D 2,
 };
=20
-static int process_bpf_exit_full(struct bpf_verifier_env *env,
-				 bool *do_print_state,
-				 bool exception_exit)
+static u32 unwind_pop_frame(struct bpf_verifier_env *env)
+{
+	struct bpf_verifier_state *state =3D env->cur_state;
+	struct bpf_func_state *callee =3D state->frame[state->curframe];
+	u32 callsite =3D callee->callsite;
+	struct bpf_func_state *caller;
+
+	caller =3D state->frame[state->curframe - 1];
+	account_processed_insns(env, callee, caller);
+	free_func_state(callee);
+	state->frame[state->curframe--] =3D NULL;
+	invalidate_outgoing_stack_args(env, caller);
+	return callsite;
+}
+
+static void unwind_enter_pad(struct bpf_verifier_env *env)
+{
+	struct bpf_verifier_state *state =3D env->cur_state;
+	struct bpf_func_state *frame =3D cur_func(env);
+
+	state->unwind_frameno =3D state->curframe;
+	clear_caller_saved_regs(env, frame->regs);
+	mark_reg_unknown(env, frame->regs, BPF_REG_0);
+	__mark_reg_known(&frame->regs[BPF_REG_0], BPF_PAD_ENTRY_R0);
+}
+
+static int unwind_finish(struct bpf_verifier_env *env)
+{
+	int err =3D check_resource_leak(env, true, true, "bpf_throw");
+
+	if (err)
+		return err;
+	return PROCESS_BPF_EXIT;
+}
+
+static int unwind_step(struct bpf_verifier_env *env, u32 callsite, int *=
insn_idx)
+{
+	struct bpf_verifier_state *state =3D env->cur_state;
+	u8 popped =3D 0;
+
+	state->unwinding =3D true;
+	for (;;) {
+		int pad =3D bpf_cleanup_pad_of_call(env, callsite);
+
+		if (pad >=3D 0) {
+			unwind_enter_pad(env);
+			/*
+			 * The edge from @callsite to the pad crosses @popped
+			 * frames, and nothing in the instruction stream says
+			 * so. Record it for mark_chain_precision(), which has
+			 * to walk back through the same frames.
+			 */
+			env->unwind_frames =3D popped;
+			*insn_idx =3D pad;
+			return INSN_IDX_UPDATED;
+		}
+		if (!state->curframe)
+			return unwind_finish(env);
+		callsite =3D unwind_pop_frame(env);
+		popped++;
+	}
+}
+
+static int process_cleanup_resume(struct bpf_verifier_env *env, int *ins=
n_idx)
+{
+	struct bpf_verifier_state *state =3D env->cur_state;
+	int err;
+
+	/* A pad entered by ordinary control flow. */
+	if (!state->unwinding) {
+		verbose(env,
+			"bpf_unwind_resume() at insn %d reached without an exception in fligh=
t\n",
+			*insn_idx);
+		return -EINVAL;
+	}
+	/*
+	 * A resume in a subprogram the pad called, which has a landing pad of
+	 * its own and reached it by ordinary control flow. A JIT lowers a
+	 * resume as the way back out of a pad, which reaches the walker only
+	 * from the frame whose pad it called.
+	 */
+	if (state->curframe !=3D state->unwind_frameno) {
+		verbose(env,
+			"bpf_unwind_resume() at insn %d is in frame %d, not frame %d whose la=
nding pad the exception entered\n",
+			*insn_idx, state->curframe, state->unwind_frameno);
+		return -EINVAL;
+	}
+	if (!state->curframe)
+		return unwind_finish(env);
+	err =3D unwind_step(env, unwind_pop_frame(env), insn_idx);
+	/* unwind_step() counted the frames it popped, not this one. */
+	if (err =3D=3D INSN_IDX_UPDATED)
+		env->unwind_frames++;
+	return err;
+}
+
+static int process_bpf_exit_full(struct bpf_verifier_env *env, bool *do_=
print_state)
 {
 	struct bpf_func_state *cur_frame =3D cur_func(env);
=20
@@ -18487,25 +18584,11 @@ static int process_bpf_exit_full(struct bpf_ver=
ifier_env *env,
 	 * for which reference_state must match caller reference
 	 * state when it exits.
 	 */
-	int err =3D check_resource_leak(env, exception_exit,
-				      exception_exit || !env->cur_state->curframe,
-				      exception_exit ? "bpf_throw" :
+	int err =3D check_resource_leak(env, false, !env->cur_state->curframe,
 				      "BPF_EXIT instruction in main prog");
 	if (err)
 		return err;
=20
-	/* The side effect of the prepare_func_exit which is
-	 * being skipped is that it frees bpf_func_state.
-	 * Typically, process_bpf_exit will only be hit with
-	 * outermost exit. copy_verifier_state in pop_stack will
-	 * handle freeing of any extra bpf_func_state left over
-	 * from not processing all nested function exits. We
-	 * also skip return code checks as they are not needed
-	 * for exceptional exits.
-	 */
-	if (exception_exit)
-		return PROCESS_BPF_EXIT;
-
 	if (env->cur_state->curframe) {
 		/* exit from nested function */
 		err =3D prepare_func_exit(env, &env->insn_idx);
@@ -18679,6 +18762,8 @@ static int do_check_insn(struct bpf_verifier_env =
*env, bool *do_print_state)
=20
 		env->jmps_processed++;
 		if (opcode =3D=3D BPF_CALL) {
+			if (bpf_is_unwind_resume_kfunc(insn))
+				return process_cleanup_resume(env, &env->insn_idx);
 			if (env->cur_state->active_locks) {
 				if ((insn->src_reg =3D=3D BPF_REG_0 &&
 				     insn->imm !=3D BPF_FUNC_spin_unlock &&
@@ -18712,7 +18797,7 @@ static int do_check_insn(struct bpf_verifier_env =
*env, bool *do_print_state)
 				env->insn_idx +=3D insn->imm + 1;
 			return INSN_IDX_UPDATED;
 		} else if (opcode =3D=3D BPF_EXIT) {
-			return process_bpf_exit_full(env, do_print_state, false);
+			return process_bpf_exit_full(env, do_print_state);
 		}
 		return check_cond_jmp_op(env, insn, &env->insn_idx);
 	}
@@ -18749,10 +18834,14 @@ static int do_check(struct bpf_verifier_env *en=
v)
 	for (;;) {
 		struct bpf_insn *insn;
 		struct bpf_insn_aux_data *insn_aux;
+		u8 unwind_frames;
 		int err;
=20
 		/* reset current history entry on each new instruction */
 		env->cur_hist_ent =3D NULL;
+		/* frames the unwind popped to reach this insn, if it is a pad */
+		unwind_frames =3D env->unwind_frames;
+		env->unwind_frames =3D 0;
=20
 		env->prev_insn_idx =3D prev_insn_idx;
 		if (env->insn_idx >=3D insn_cnt) {
@@ -18816,10 +18905,16 @@ static int do_check(struct bpf_verifier_env *en=
v)
 			}
 		}
=20
-		if (bpf_is_jmp_point(env, env->insn_idx)) {
+		/*
+		 * A landing pad is a jump point, but record the edge even if
+		 * that ever stops being true: it is the only place the frames
+		 * the unwind popped are written down.
+		 */
+		if (bpf_is_jmp_point(env, env->insn_idx) || unwind_frames) {
 			err =3D bpf_push_jmp_history(env, state, 0, 0, 0, 0);
 			if (err)
 				return err;
+			env->cur_hist_ent->unwind_frames =3D unwind_frames;
 		}
=20
 		if (signal_pending(current))
--=20
2.53.0-Meta

