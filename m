Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41B53FE367
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 04:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139587; cv=none; b=Yssg6pJA80BqXSsDf+19fFlwnLuxNgJt2CcMY8tZUFq8F8LENNJneOJk0/69P8hBLLYkxk/o1fRhikM2BLilj9dhWJ3iPxSyGLifp9lTig6VQZ94NXklEfUz7zeHAyIA5TWOgN4nvB1098Z9CUH7sIMn7uh1+CDstyeEGgJZRgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139587; c=relaxed/simple;
	bh=TIhe8l+mjdRBKziVtLL0SjfRf6QvCuHQAXeOTadcmp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k93rkCZDtqlyFW40tx28UQ+xtiVVV95jJJta8P/kWG5wiaSJHKfC1gjZYwzTcWqWU3Yv4CB4nmntiN2YGICTqYLnosZfQQf72bvX+rEUf60NcyEWtsDcpOtIGN7jc31LD8aXFTX74AospFX67UjDCSeSLCJwEimWH03OBQ9pmHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id AED122C8DA7E65; Tue, 22 Sep 2026 21:59:27 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 08/21] bpf: Walk the exception unwind in the verifier
Date: Tue, 22 Sep 2026 21:59:27 -0700
Message-ID: <20260923045927.2418543-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923045846.2414643-1-yonghong.song@linux.dev>
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
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

	at a throw, with the frame chain in env->cur_state->frame[]:
	  1. does a record cover the call site control is at?
	  2. yes: run that record's landing pad in this frame, and on
	     reaching its resume, pop the frame and go back to 1
	  3. no: pop the frame and go back to 1
	  4. frame 0 asks with nothing left to pop: deliver

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

A pad starts in the state the walker hands it: its own frame's stack and
callee-saved registers, which the walker puts back, and nothing in the
caller-saved ones. r0 is an unknown scalar: LLVM names it as both the
exception pointer and the exception selector register, so a pad reads it
before anything else, and the dispatchers leave a defined value there
rather than whatever the kernel had.

Two things about that walk have to be said out loud, because the
instruction stream does not say them.

A resume belongs to the frame whose landing pad the walker called:

  - a JIT lowers it as the way back out of a pad -- a bare return on
    x86-64, a branch to the saved address on arm64 -- so it reaches the
    walker only from there
  - an exception in flight does not say which frame that is: a pad may ca=
ll
    a subprogram whose own pad reaches a resume by ordinary control flow
  - so the state records the frame the unwind entered a pad in,
    states_equal() keeps two such states apart, a resume in any other fra=
me
    is refused, and bpf_insn_successors() reports none for it

The edge from a throw to a pad crosses frames with no instruction in
between, and mark_chain_precision() walks that history backwards:

  - left alone it stays in the pad's frame while reading the callee's
    instructions: a request for the pad frame's r6 is cleared by the
    callee's own write to r6, or reaches a call still set and trips "stat=
ic
    subprog unexpected regs"
  - so the history entry for a pad records how many frames the unwind
    popped, and the backtrack enters that many, the way it enters one for
    BPF_EXIT
  - the pad's r0 is whatever the walker left rather than anything an
    instruction wrote, so a request for it ends at the edge
  - a throwing global subprogram gets no frame of its own, so its excepti=
on
    arrives at the pad rather than the insn after the call, which
    backtrack_insn() has to allow for

This is also where bpf_unwind_resume() becomes callable: the kfunc is
registered here, beside the rule that refuses it outside a pad. Earlier,
nothing refused the call and a JIT rewrites a resume only in a pad, so a
program could reach the kernel body -- a WARN_ONCE whose only job is to s=
ay
it should never have been reached.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |   8 ++-
 kernel/bpf/backtrack.c       |  41 +++++++++--
 kernel/bpf/exception.c       |   1 +
 kernel/bpf/helpers.c         |   1 +
 kernel/bpf/liveness.c        |   3 +
 kernel/bpf/states.c          |   6 ++
 kernel/bpf/verifier.c        | 133 +++++++++++++++++++++++++++--------
 7 files changed, 158 insertions(+), 35 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e12ec91b8150..3146f707e030 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -429,7 +429,8 @@ struct bpf_jmp_history_entry {
 	u32 prev_idx : 20;
 	/* special INSN_F_xxx flags */
 	u32 flags : 4;
-	u32 : 8;
+	u32 unwind_frames : 4;	/* frames popped to reach this landing pad */
+	u32 : 4;
 	/*
 	 * additional registers that need precision tracking when this
 	 * jump is backtracked, vector of five 11-bit records
@@ -510,6 +511,9 @@ struct bpf_verifier_state {
 	bool speculative;
 	bool in_sleepable;
=20
+	bool unwinding; /* an exception is in flight */
+	u8 unwind_frameno; /* the frame whose landing pad is running */
+
 	/* first and last insn idx of this verifier state */
 	u32 first_insn_idx;
 	u32 last_insn_idx;
@@ -991,6 +995,8 @@ struct bpf_verifier_env {
 	} cfg;
 	struct backtrack_state bt;
 	struct bpf_jmp_history_entry *cur_hist_ent;
+	u8 cur_unwind_frames; /* frames popped to reach this insn, if a pad */
+	u8 unwind_frames; /* frames popped, staged for the next insn */
 	/* Per-callsite copy of parent's converged at_stack_in for cross-frame =
fills. */
 	struct arg_track **callsite_at_stack;
 	u32 pass_cnt; /* number of times do_check() was called */
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 507a366dffa4..88da73345f01 100644
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
+	p->unwind_frames =3D env->cur_unwind_frames;
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
+						bpf_exc_pad_of_call(env, idx) !=3D subseq_idx,
+						env, "extra insn from subprog");
 				/* global subprog always sets R0 */
 				bt_clear_reg(bt, BPF_REG_0);
 				/* and if it does not set R2, main pass would catch it */
@@ -823,6 +827,7 @@ int bpf_mark_chain_precision(struct bpf_verifier_env =
*env,
 	struct bpf_func_state *func;
 	bool tmp, skip_first =3D true;
 	struct bpf_reg_state *reg;
+	u32 pending_unwind =3D 0;
 	int i, fr, err;
=20
 	if (!env->bpf_capable)
@@ -888,11 +893,19 @@ int bpf_mark_chain_precision(struct bpf_verifier_en=
v *env,
 		}
=20
 		for (i =3D last_idx;;) {
+			hist =3D get_jmp_hist_entry(st, history, i);
+			/*
+			 * The insn about to be read sits on the far side of an
+			 * unwind edge, so enter the frames that edge crossed
+			 * before reading it.
+			 */
+			for (; pending_unwind; pending_unwind--)
+				if (bt_subprog_enter(bt))
+					return -EFAULT;
 			if (skip_first) {
 				err =3D 0;
 				skip_first =3D false;
 			} else {
-				hist =3D get_jmp_hist_entry(st, history, i);
 				err =3D backtrack_insn(env, i, subseq_idx, hist, bt);
 			}
 			if (err =3D=3D -ENOTSUPP) {
@@ -909,6 +922,21 @@ int bpf_mark_chain_precision(struct bpf_verifier_env=
 *env,
 				 */
 				return 0;
 			subseq_idx =3D i;
+			if (hist && hist->unwind_frames) {
+				/*
+				 * This insn is a landing pad the unwind reached
+				 * from a throw or a resume with
+				 * hist->unwind_frames frames deeper. The walker
+				 * writes r0 on the way in, so no insn defines
+				 * it: left set, the request reaches the call
+				 * that created this frame, where only r1-r5 may
+				 * still be.
+				 */
+				bt_clear_reg(bt, BPF_REG_0);
+				if (bt_empty(bt))
+					return 0;
+				pending_unwind =3D hist->unwind_frames;
+			}
 			i =3D get_prev_insn_idx(st, i, &history);
 			if (i =3D=3D -ENOENT)
 				break;
@@ -927,6 +955,11 @@ int bpf_mark_chain_precision(struct bpf_verifier_env=
 *env,
 		if (!st)
 			break;
=20
+		if (verifier_bug_if(bt->frame > st->curframe, env,
+				    "backtrack frame %d, state curframe %d",
+				    bt->frame, st->curframe))
+			return -EFAULT;
+
 		for (fr =3D bt->frame; fr >=3D 0; fr--) {
 			func =3D st->frame[fr];
 			bitmap_from_u64(mask, bt_frame_reg_mask(bt, fr));
diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
index 244ea1b5417c..3270e7ae2e7c 100644
--- a/kernel/bpf/exception.c
+++ b/kernel/bpf/exception.c
@@ -5,6 +5,7 @@
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
 #include <linux/filter.h>
+#include <linux/slab.h>
 #include "exception.h"
=20
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##ar=
gs)
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 249418e60ee4..5eadab4dfa3f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -5094,6 +5094,7 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE=
 | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_from_vpid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
+BTF_ID_FLAGS(func, bpf_unwind_resume)
 #ifdef CONFIG_BPF_EVENTS
 BTF_ID_FLAGS(func, bpf_send_signal_task)
 #endif
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 9d44a7dafe5f..00ac8917a716 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -258,6 +258,9 @@ bpf_insn_successors(struct bpf_verifier_env *env, u32=
 idx)
 	succ =3D env->succ;
 	succ->cnt =3D 0;
=20
+	if (unlikely(bpf_is_unwind_resume_kfunc(insn)))
+		return succ;
+
 	opcode_info =3D &opcode_info_tbl[BPF_CLASS(insn->code) | BPF_OP(insn->c=
ode)];
 	insn_sz =3D bpf_is_ldimm64(insn) ? 2 : 1;
 	if (opcode_info->can_fallthrough)
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
index 8163c75ec3fa..53edce3d64ea 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1726,6 +1726,8 @@ int bpf_copy_verifier_state(struct bpf_verifier_sta=
te *dst_state,
 		return err;
 	dst_state->speculative =3D src->speculative;
 	dst_state->in_sleepable =3D src->in_sleepable;
+	dst_state->unwinding =3D src->unwinding;
+	dst_state->unwind_frameno =3D src->unwind_frameno;
 	dst_state->curframe =3D src->curframe;
 	dst_state->branches =3D src->branches;
 	dst_state->parent =3D src->parent;
@@ -10598,8 +10600,8 @@ static int push_callback_call(struct bpf_verifier=
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
@@ -10689,7 +10691,7 @@ static int check_func_call(struct bpf_verifier_en=
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
@@ -11078,6 +11080,20 @@ static bool retval_range_within(struct bpf_retva=
l_range range, const struct bpf_
 		return range.minval <=3D reg_smin(reg) && reg_smax(reg) <=3D range.max=
val;
 }
=20
+static u32 pop_frame(struct bpf_verifier_env *env)
+{
+	struct bpf_verifier_state *state =3D env->cur_state;
+	struct bpf_func_state *callee =3D state->frame[state->curframe];
+	struct bpf_func_state *caller =3D state->frame[state->curframe - 1];
+	u32 callsite =3D callee->callsite;
+
+	account_processed_insns(env, callee, caller);
+	free_func_state(callee);
+	state->frame[state->curframe--] =3D NULL;
+	invalidate_outgoing_stack_args(env, caller);
+	return callsite;
+}
+
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx=
)
 {
 	struct bpf_verifier_state *state =3D env->cur_state, *prev_st;
@@ -11157,12 +11173,7 @@ static int prepare_func_exit(struct bpf_verifier=
_env *env, int *insn_idx)
 		verbose(env, "to caller at %d:\n", *insn_idx);
 		print_verifier_state(env, state, caller->frameno, true);
 	}
-	account_processed_insns(env, callee, caller);
-	/* clear everything in the callee. In case of exceptional exits using
-	 * bpf_throw, this will be done by copy_verifier_state for extra frames=
. */
-	free_func_state(callee);
-	state->frame[state->curframe--] =3D NULL;
-	invalidate_outgoing_stack_args(env, caller);
+	pop_frame(env);
=20
 	/* for callbacks widen imprecise scalars to make programs like below ve=
rify:
 	 *
@@ -14661,7 +14672,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 		env->prog->call_session_cookie =3D true;
=20
 	if (bpf_is_throw_kfunc(insn))
-		return process_bpf_exit_full(env, NULL, true);
+		return unwind_step(env, insn_idx, &env->insn_idx);
=20
 	return 0;
 }
@@ -18586,9 +18597,80 @@ enum {
 	INSN_IDX_UPDATED =3D 2,
 };
=20
-static int process_bpf_exit_full(struct bpf_verifier_env *env,
-				 bool *do_print_state,
-				 bool exception_exit)
+static void unwind_enter_pad(struct bpf_verifier_env *env)
+{
+	struct bpf_verifier_state *state =3D env->cur_state;
+	struct bpf_func_state *frame =3D cur_func(env);
+
+	state->unwind_frameno =3D state->curframe;
+	clear_caller_saved_regs(env, frame->regs);
+	mark_reg_unknown(env, frame->regs, BPF_REG_0);
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
+		int pad =3D bpf_exc_pad_of_call(env, callsite);
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
+		callsite =3D pop_frame(env);
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
+	if (!state->unwinding) {
+		verbose(env,
+			"bpf_unwind_resume() at insn %u reached without an exception in fligh=
t\n",
+			(u32)*insn_idx);
+		return -EINVAL;
+	}
+	if (state->curframe !=3D state->unwind_frameno) {
+		verbose(env,
+			"bpf_unwind_resume() at insn %u is in frame %u, not frame %u whose la=
nding pad the exception entered\n",
+			(u32)*insn_idx, state->curframe, state->unwind_frameno);
+		return -EINVAL;
+	}
+	if (!state->curframe)
+		return unwind_finish(env);
+	err =3D unwind_step(env, pop_frame(env), insn_idx);
+	/* unwind_step() counted the frames it popped, not the one popped here.=
 */
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
@@ -18598,25 +18680,11 @@ static int process_bpf_exit_full(struct bpf_ver=
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
@@ -18790,6 +18858,8 @@ static int do_check_insn(struct bpf_verifier_env =
*env, bool *do_print_state)
=20
 		env->jmps_processed++;
 		if (opcode =3D=3D BPF_CALL) {
+			if (bpf_is_unwind_resume_kfunc(insn))
+				return process_cleanup_resume(env, &env->insn_idx);
 			if (env->cur_state->active_locks) {
 				if ((insn->src_reg =3D=3D BPF_REG_0 &&
 				     insn->imm !=3D BPF_FUNC_spin_unlock &&
@@ -18823,7 +18893,7 @@ static int do_check_insn(struct bpf_verifier_env =
*env, bool *do_print_state)
 				env->insn_idx +=3D insn->imm + 1;
 			return INSN_IDX_UPDATED;
 		} else if (opcode =3D=3D BPF_EXIT) {
-			return process_bpf_exit_full(env, do_print_state, false);
+			return process_bpf_exit_full(env, do_print_state);
 		}
 		return check_cond_jmp_op(env, insn, &env->insn_idx);
 	}
@@ -18864,6 +18934,9 @@ static int do_check(struct bpf_verifier_env *env)
=20
 		/* reset current history entry on each new instruction */
 		env->cur_hist_ent =3D NULL;
+		/* frames the unwind popped to reach this insn, if it is a pad */
+		env->cur_unwind_frames =3D env->unwind_frames;
+		env->unwind_frames =3D 0;
=20
 		env->prev_insn_idx =3D prev_insn_idx;
 		if (env->insn_idx >=3D insn_cnt) {
@@ -18927,7 +19000,7 @@ static int do_check(struct bpf_verifier_env *env)
 			}
 		}
=20
-		if (bpf_is_jmp_point(env, env->insn_idx)) {
+		if (bpf_is_jmp_point(env, env->insn_idx) || env->cur_unwind_frames) {
 			err =3D bpf_push_jmp_history(env, state, 0, 0, 0, 0);
 			if (err)
 				return err;
--=20
2.53.0-Meta

