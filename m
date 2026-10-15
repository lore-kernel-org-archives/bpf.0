Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93673B6356
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 04:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792036947; cv=none; b=gHfGThcadonW5Up3ycQxogV/0E58zkHXuwPk7XwUaRwwtFF8f9pwHWCfHkZziK9TuBIHxP91j7UoS5WvHouewJFEA5REKrXGUN+g8etlDRv7JHUj7l4G12E764ofjiq9myHQnKATc/4LtnjUhlBsalcBiAhiFkbeajQsAIAJB8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792036947; c=relaxed/simple;
	bh=5AG8hC7if8BG51qSybhZawHQdjjyJPOlDBQw9CRjfoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPEYGduJ2dMZXqB5bJUnk4L/ICr14HZ06fjX9uzOOfA+515BjyAu3oBQwOLZyvniobfPyy8y0sMlmYLhVCTOj+875kSkq8LXAf1U0UpM4wgsNfmyLTlzsdht/NBokMmqaBirksscegHswBM+jqAof4Q4PL0d2ENRY1AQcnOor8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 9695931498E353; Wed, 14 Oct 2026 21:02:19 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v11 07/26] bpf: Verify an unwind through landing pads and epilogues
Date: Wed, 14 Oct 2026 21:02:19 -0700
Message-ID: <20261015040219.858407-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015040143.854070-1-yonghong.song@linux.dev>
References: <20261015040143.854070-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Once a later patch makes bpf_unwind() dispatch pads, an unwind rewrites
the return address of every frame it passes: to the pad where a record
covers the frame's call, else to the frame's epilogue. Each frame then
returns normally, a pad through its resume, which is lowered to
'r0 =3D 0; exit'. The verifier follows the unwind the same way: into the
pad of each frame that has one, out of each frame that does not, and out
of main as a program exit.

  instruction                          goes on at
  -----------------------------------  ---------------------------------
  bpf_unwind(), record over it         its own frame's pad
  bpf_unwind(), no record over it      unwind_frames()
  bpf_unwind_resume()                  unwind_frames()
  call to a global subprog that can    next insn, and the unwind from the
  unwind                               returned state: to the call's pad,
                                       or on through unwind_frames()

Whether a subprog can unwind is worked out on the CFG, as might_throw
is: a call to bpf_unwind() marks its subprog might_unwind, and
merge_callee_effects() carries the mark to its callers. A callx goes
around merge_callee_effects(), so if any subprog whose address is taken
can unwind, mark_callx_might_unwind() marks every subprog holding a
callx, and its callers. That is conservative, as only the main walk
knows which subprog a callx calls.

unwind_frames(), for main -> A -> B -> C where only A's call is covered:

  program                              run time: bpf_unwind() in C
  -----------------------------------  ---------------------------------
  main:     call A                     main returns via its epilogue
  A:     1: call B     [1, 2) -> P     A resumes at P
         2: ...
         P: <drop A's resources>
            call bpf_unwind_resume
  B:        call C     no record       B returns via its epilogue
  C:        call bpf_unwind            C returns via 'r0 =3D 0; exit'

  frame   at C's bpf_unwind()   unwind_frames()     at P's resume
  -----   -------------------   -----------------   -----------------
    3     C  <- curframe        popped
    2     B                     popped
    1     A                     A  <- curframe, P   popped
    0     main                  main                exit with r0 =3D 0

P gets A's frame as B and C left it, with r0 unknown and r1-r5 cleared.
With no pad left, the program ends through process_bpf_exit_full(). Only
then are the unwind's resources checked, and a leak is reported against
bpf_unwind at the insn that unwound: a frame it pops may leave something
for a caller's pad to drop.

The pad's state comes from the unwind, not from a snapshot at the call:
before unwinding, the callee may have written the caller's stack through
a pointer, overwritten a spilled pointer, reinitialised a dynptr or an
iterator, or changed packet data, none of which its epilogue restores. A
global subprog is verified on its own, so the unwind out of a call to one
starts from the state the call returns in, after check_func_call().

Precision backtracking gets three new edges:

  edge                     frame
  -----------------------  ---------------------------------------------
  global call <- its pad   stays in the caller (subseq_idx is the pad)
  unwind <- pad            moves to the frame the unwind left, recorded
                           in its history entry under INSN_F_UNWIND
  unwind <- main's exit    the same, after a jump from the unwinding insn
                           to where the path ends

Where no frame has a pad, the path ends at E, the insn it exits from in
place of a BPF_EXIT: main's call into the popped frames, else the
unwinding insn U itself. Backtracking for the return check starts at E
without processing it, while r0 is set at U, Q being U's predecessor:

    frames popped                     none popped

    main:  E: call A                  main:      Q: r6 =3D 0
    A:        call B                         E =3D U: call bpf_unwind
    B:     Q: r6 =3D 0
           U: call bpf_unwind

    walk:  E -> U -> Q -> ...         walk:  E -> U -> Q -> ...
           ^ skipped                         ^ skipped

The jump from U to E takes the walk to U rather than to the insn before
E; where E is U, it is what gets U processed at all. U's INSN_F_UNWIND
mark matters there only for an unwinding global call, which backtracking
would otherwise take for one that returned.

Unlike a BPF_EXIT in main, the end of such a path can be inside a loop,
where maybe_exit_scc() finds no visit info for it. The new unwind_exit
in the state tells it that the path ended there.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |  11 ++-
 kernel/bpf/backtrack.c       |  40 +++++++++-
 kernel/bpf/cfg.c             |  88 +++++++++++++++++++++
 kernel/bpf/states.c          |   8 +-
 kernel/bpf/verifier.c        | 145 ++++++++++++++++++++++++++++++++++-
 5 files changed, 281 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 89a714057820..cc95d2ad015c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -429,6 +429,8 @@ enum {
 	INSN_F_SRC_REG_STACK =3D BIT(2), /* src_reg is PTR_TO_STACK */
=20
 	INSN_F_STACK_ARG_ACCESS =3D BIT(3),
+
+	INSN_F_UNWIND =3D BIT(4),
 };
=20
 /* Registers linked to one jump condition that a history entry can recor=
d */
@@ -437,10 +439,10 @@ enum {
 struct bpf_jmp_history_entry {
 	/* insn idx can't be bigger than 1 million */
 	u32 idx : 20;
-	u32 frame : 4;	/* stack access frame number */
+	u32 frame : 4;	/* stack access frame number, or the frame an unwind ran=
 in */
 	/* special INSN_F_xxx flags */
-	u32 flags : 4;
-	u32 : 4;
+	u32 flags : 5;
+	u32 : 3;
 	u32 prev_idx : 20;
 	u32 spi : 12;	/* stack slot index */
 	/*
@@ -527,6 +529,8 @@ struct bpf_verifier_state {
=20
 	bool speculative;
 	bool in_sleepable;
+	/* the path ends with an unwind returning from frame 0 */
+	bool unwind_exit;
=20
 	/*
 	 * First and last insn idx of this verifier state.
@@ -949,6 +953,7 @@ struct bpf_subprog_info {
 	s16 fastcall_stack_off;
 	bool has_tail_call: 1;
 	bool might_throw: 1;
+	bool might_unwind: 1;
 	bool tail_call_reachable: 1;
 	bool has_ld_abs: 1;
 	bool is_cb: 1;
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 43d5740034c0..16f6ef59ddf7 100644
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
@@ -424,7 +425,31 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
 		if (class =3D=3D BPF_STX)
 			bt_set_reg(bt, sreg);
 	} else if (class =3D=3D BPF_JMP || class =3D=3D BPF_JMP32) {
-		if (bpf_pseudo_call(insn) || bpf_is_callx(insn)) {
+		if (hist && (hist->flags & INSN_F_UNWIND)) {
+			/*
+			 * A bpf_unwind(), a resume or an unwinding global call
+			 * left frame hist->frame here, for a landing pad in
+			 * this one, or for the main frame's exit, which is
+			 * this frame itself when it is the main one. The walk
+			 * crosses back into that frame, past any frames
+			 * between, which were entered and never returned
+			 * from. The pad found r0 unknown and r1-r5 clobbered;
+			 * r6-r9 and the stack are this frame's own and stay
+			 * marked in its masks until the walk comes back out.
+			 */
+			bt_clear_reg(bt, BPF_REG_0);
+			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
+				verifier_bug(env, "backtracking unwind unexpected regs %x",
+					     bt_reg_mask(bt));
+				return -EFAULT;
+			}
+			if (verifier_bug_if(hist->frame < bt->frame, env,
+					    "unwind from frame %d to frame %d",
+					    hist->frame, bt->frame))
+				return -EFAULT;
+			bt->frame =3D hist->frame;
+			return 0;
+		} else if (bpf_pseudo_call(insn) || bpf_is_callx(insn)) {
 			int subprog_insn_idx, subprog =3D -1;
=20
 			if (bpf_pseudo_call(insn)) {
@@ -440,10 +465,17 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx, int subseq_idx,
 				 * extra instructions from subprog; the next
 				 * instruction after call to global subprog
 				 * should be literally next instruction in
-				 * caller program
+				 * caller program, or the call's landing pad,
+				 * branched to from the state the call returns
+				 * in when the callee can unwind. A pad may be
+				 * the next instruction too, so the two edges
+				 * cannot be told apart, and need not be: the
+				 * pad finds r0 unknown and r1-r5 cleared, so
+				 * both clear the same registers below.
 				 */
-				verifier_bug_if(idx + 1 !=3D subseq_idx, env,
-						"extra insn from subprog");
+				verifier_bug_if(idx + 1 !=3D subseq_idx &&
+						bpf_exc_pad_of_call(env, idx) !=3D subseq_idx,
+						env, "extra insn from subprog");
 				/* global subprog always sets R0 */
 				bt_clear_reg(bt, BPF_REG_0);
 				/* and if it does not set R2, main pass would catch it */
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index ad7ea08f3b15..9608293bdc06 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -76,6 +76,14 @@ static void mark_subprog_might_throw(struct bpf_verifi=
er_env *env, int off)
 	subprog->might_throw =3D true;
 }
=20
+static void mark_subprog_might_unwind(struct bpf_verifier_env *env, int =
off)
+{
+	struct bpf_subprog_info *subprog;
+
+	subprog =3D bpf_find_containing_subprog(env, off);
+	subprog->might_unwind =3D true;
+}
+
 /* 't' is an index of a call-site.
  * 'w' is a callee entry point.
  * Eventually this function would be called when env->cfg.insn_state[w] =
=3D=3D EXPLORED.
@@ -91,6 +99,7 @@ static void merge_callee_effects(struct bpf_verifier_en=
v *env, int t, int w)
 	caller->changes_pkt_data |=3D callee->changes_pkt_data;
 	caller->might_sleep |=3D callee->might_sleep;
 	caller->might_throw |=3D callee->might_throw;
+	caller->might_unwind |=3D callee->might_unwind;
 }
=20
 enum {
@@ -668,6 +677,8 @@ static int visit_insn(int t, struct bpf_verifier_env =
*env)
 				mark_subprog_changes_pkt_data(env, t);
 			if (ret =3D=3D 0 && bpf_is_throw_kfunc(insn))
 				mark_subprog_might_throw(env, t);
+			if (ret =3D=3D 0 && bpf_is_unwind_kfunc(insn))
+				mark_subprog_might_unwind(env, t);
 		}
 		return visit_func_call_insn(t, insns, env, insn->src_reg =3D=3D BPF_PS=
EUDO_CALL);
=20
@@ -705,6 +716,82 @@ static int visit_insn(int t, struct bpf_verifier_env=
 *env)
 	}
 }
=20
+static bool addr_taken_subprog_might_unwind(struct bpf_verifier_env *env=
)
+{
+	struct bpf_insn *insns =3D env->prog->insnsi;
+	struct bpf_subprog_info *callee;
+	struct bpf_func_ptr *ptrs;
+	u32 cnt, j;
+	int i;
+
+	for (i =3D 0; i < env->prog->len; i++) {
+		if (bpf_pseudo_func(&insns[i])) {
+			callee =3D bpf_find_containing_subprog(env, i + insns[i].imm + 1);
+			if (callee->might_unwind)
+				return true;
+			continue;
+		}
+		ptrs =3D insn_func_ptrs(env, i, &cnt);
+		for (j =3D 0; j < cnt; j++) {
+			callee =3D bpf_find_containing_subprog(env, ptrs[j].xlated_off);
+			if (callee->might_unwind)
+				return true;
+		}
+	}
+	return false;
+}
+
+/*
+ * merge_callee_effects() does not carry might_unwind to a subprog that =
calls
+ * through a pointer it was handed. So if any subprog a callx can reach =
may
+ * unwind, mark every subprog with a callx, and its callers.
+ *
+ * This is conservative: a subprog with a callx is marked even when noth=
ing it
+ * calls unwinds. The main walk knows each callx's target and could tell=
 those
+ * apart.
+ */
+static void mark_callx_might_unwind(struct bpf_verifier_env *env)
+{
+	struct bpf_insn *insns =3D env->prog->insnsi;
+	struct bpf_subprog_info *caller, *callee;
+	int i, j, len =3D env->prog->len;
+	struct bpf_func_ptr *ptrs;
+	bool changed;
+	u32 cnt;
+
+	if (!addr_taken_subprog_might_unwind(env))
+		return;
+
+	for (i =3D 0; i < len; i++)
+		if (bpf_is_callx(&insns[i]))
+			bpf_find_containing_subprog(env, i)->might_unwind =3D true;
+
+	do {
+		changed =3D false;
+		for (i =3D 0; i < len; i++) {
+			caller =3D bpf_find_containing_subprog(env, i);
+			if (caller->might_unwind)
+				continue;
+			if (bpf_pseudo_call(&insns[i]) || bpf_pseudo_func(&insns[i])) {
+				callee =3D bpf_find_containing_subprog(env, i + insns[i].imm + 1);
+				if (!callee->might_unwind)
+					continue;
+				caller->might_unwind =3D true;
+				changed =3D true;
+				continue;
+			}
+			ptrs =3D insn_func_ptrs(env, i, &cnt);
+			for (j =3D 0; j < cnt; j++) {
+				callee =3D bpf_find_containing_subprog(env, ptrs[j].xlated_off);
+				if (!callee->might_unwind)
+					continue;
+				caller->might_unwind =3D true;
+				changed =3D true;
+			}
+		}
+	} while (changed);
+}
+
 /* non-recursive depth-first-search to detect loops in BPF program
  * loop =3D=3D back-edge in directed graph
  */
@@ -795,6 +882,7 @@ int bpf_check_cfg(struct bpf_verifier_env *env)
 		}
 	}
 	ret =3D 0; /* cfg looks good */
+	mark_callx_might_unwind(env);
 	env->prog->aux->changes_pkt_data =3D env->subprog_info[0].changes_pkt_d=
ata;
 	env->prog->aux->might_sleep =3D env->subprog_info[0].might_sleep;
=20
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 953700822fa7..a3dd2f5712e7 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -201,9 +201,13 @@ static int maybe_exit_scc(struct bpf_verifier_env *e=
nv, struct bpf_verifier_stat
 		 * c. A checkpoint is reached and matched. Checkpoints are created by
 		 *    is_state_visited(), which calls maybe_enter_scc(), which allocat=
es
 		 *    bpf_scc_visit instances for checkpoints within SCCs.
-		 * (c) is the only case that can reach this point.
+		 * d. An unwind returns from frame 0, ending the path at a call or at
+		 *    the unwinding insn, which may be in an SCC as a top-level
+		 *    BPF_EXIT is not. Like (b), it leaves nothing to exit.
+		 * (c) and (d), and a speculative path, are the only ways to reach
+		 * this point.
 		 */
-		if (!st->speculative) {
+		if (!st->speculative && !st->unwind_exit) {
 			verifier_bug(env, "scc exit: no visit info for call chain %s",
 				     format_callchain(env, callchain));
 			return -EFAULT;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 96f5ea8ea8bf..fe24291260a0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1751,6 +1751,7 @@ int bpf_copy_verifier_state(struct bpf_verifier_sta=
te *dst_state,
 		return err;
 	dst_state->speculative =3D src->speculative;
 	dst_state->in_sleepable =3D src->in_sleepable;
+	dst_state->unwind_exit =3D src->unwind_exit;
 	dst_state->curframe =3D src->curframe;
 	dst_state->branches =3D src->branches;
 	dst_state->parent =3D src->parent;
@@ -11252,6 +11253,8 @@ static int push_callback_call(struct bpf_verifier=
_env *env, struct bpf_insn *ins
=20
 static int process_bpf_exit_full(struct bpf_verifier_env *env,
 				 bool *do_print_state, bool exception_exit);
+static int process_bpf_unwind(struct bpf_verifier_env *env, int *insn_id=
x);
+static int unwind_frames(struct bpf_verifier_env *env, bool *do_print_st=
ate);
=20
 /*
  * Call of a static subprog. The callee is verified in the context of
@@ -15564,6 +15567,11 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
 	if (bpf_is_throw_kfunc(insn))
 		return process_bpf_exit_full(env, NULL, true);
=20
+	if (bpf_is_unwind_kfunc(insn))
+		return process_bpf_unwind(env, insn_idx_p);
+	if (bpf_is_unwind_resume_kfunc(insn))
+		return unwind_frames(env, NULL);
+
 	return 0;
 }
=20
@@ -19674,6 +19682,133 @@ enum {
 	INSN_IDX_UPDATED =3D 2,
 };
=20
+static int unwind_frames(struct bpf_verifier_env *env, bool *do_print_st=
ate)
+{
+	struct bpf_verifier_state *state =3D env->cur_state;
+	u32 frameno =3D state->curframe;
+	struct bpf_func_state *callee, *caller;
+	int err, pad;
+
+	while (state->curframe) {
+		callee =3D cur_func(env);
+		caller =3D state->frame[state->curframe - 1];
+		pad =3D bpf_exc_pad_of_call(env, callee->callsite);
+		/* The caller is at its call now, not at this frame's insn. */
+		state->insn_idx =3D callee->callsite;
+		/* As on a return: the frame's dynptrs, and their slices, go with it. =
*/
+		err =3D destroy_dynptrs_in_stack_slots(env, callee, 0,
+						     callee->allocated_stack / BPF_REG_SIZE - 1);
+		if (err)
+			return err;
+
+		account_processed_insns(env, callee, caller);
+		free_func_state(callee);
+		state->frame[state->curframe--] =3D NULL;
+		invalidate_outgoing_stack_args(env, caller);
+		if (pad < 0)
+			continue;
+
+		/*
+		 * Mark the unwinding insn with the frame it ran in: backtracking
+		 * from the pad comes back to that insn and goes on in that frame.
+		 */
+		err =3D bpf_push_jmp_history(env, state, INSN_F_UNWIND, 0, frameno, NU=
LL, 0);
+		if (err)
+			return err;
+		clear_caller_saved_regs(env, caller->regs);
+		mark_reg_unknown(env, caller->regs, BPF_REG_0);
+		env->insn_idx =3D pad;
+		if (do_print_state)
+			*do_print_state =3D true;
+		return INSN_IDX_UPDATED;
+	}
+
+	/* A resource still held leaks; report it at the unwinding insn. */
+	err =3D check_resource_leak(env, false, true, "bpf_unwind");
+	if (err)
+		return err;
+	/*
+	 * No pad: the program ends at frame 0's call into the popped frames, o=
r
+	 * at the unwinding insn itself if none was popped. Mark the unwinding
+	 * insn as above; an unwinding global call needs that when backtracking
+	 * from the end reaches it.
+	 */
+	err =3D bpf_push_jmp_history(env, state, INSN_F_UNWIND, 0, frameno, NUL=
L, 0);
+	if (err)
+		return err;
+	/*
+	 * Then, in an entry of its own, a jump from the unwinding insn to the
+	 * end, so backtracking from the end goes back to the unwinding insn.
+	 */
+	env->cur_hist_ent =3D NULL;
+	env->prev_insn_idx =3D env->insn_idx;
+	env->insn_idx =3D state->insn_idx;
+	err =3D bpf_push_jmp_history(env, state, 0, 0, 0, NULL, 0);
+	if (err)
+		return err;
+	/*
+	 * The end may be in a loop: unlike a plain exit, the path can stop
+	 * inside an SCC with no checkpoint there.
+	 */
+	state->unwind_exit =3D true;
+
+	/* The call clobbered r1-r5, and r0 holds the zero the fixups put there=
. */
+	clear_caller_saved_regs(env, cur_regs(env));
+	__mark_reg_const_zero(env, &cur_regs(env)[BPF_REG_0]);
+	/*
+	 * A global subprog verified on its own returns here too. One that
+	 * returns in R0:R2 has R2 checked as well, though its caller never
+	 * reads either: it resumes at a pad or an epilogue.
+	 */
+	if (cur_func(env)->subprogno &&
+	    bpf_ret_reg_pair(env, cur_func(env)->subprogno))
+		mark_reg_unknown(env, cur_regs(env), BPF_REG_2);
+
+	return process_bpf_exit_full(env, do_print_state, false);
+}
+
+static int process_global_call_unwind(struct bpf_verifier_env *env,
+				      int call_idx, bool *do_print_state)
+{
+	const struct bpf_insn *insn =3D &env->prog->insnsi[call_idx];
+	int subprog =3D bpf_find_subprog(env, call_idx + insn->imm + 1);
+	struct bpf_verifier_state *branch;
+	struct bpf_func_state *frame;
+	int pad;
+
+	if (!bpf_subprog_is_global(env, subprog) ||
+	    !env->subprog_info[subprog].might_unwind)
+		return 0;
+
+	/* The call returning normally is walked later. */
+	branch =3D push_stack(env, call_idx + 1, call_idx, false);
+	if (IS_ERR(branch))
+		return PTR_ERR(branch);
+
+	pad =3D bpf_exc_pad_of_call(env, call_idx);
+	if (pad < 0)
+		return unwind_frames(env, do_print_state);
+	frame =3D cur_func(env);
+	clear_caller_saved_regs(env, frame->regs);
+	mark_reg_unknown(env, frame->regs, BPF_REG_0);
+	env->insn_idx =3D pad;
+	*do_print_state =3D true;
+	return INSN_IDX_UPDATED;
+}
+
+static int process_bpf_unwind(struct bpf_verifier_env *env, int *insn_id=
x)
+{
+	struct bpf_func_state *frame =3D cur_func(env);
+	int pad =3D bpf_exc_pad_of_call(env, *insn_idx);
+
+	if (pad < 0)
+		return unwind_frames(env, NULL);
+	clear_caller_saved_regs(env, frame->regs);
+	mark_reg_unknown(env, frame->regs, BPF_REG_0);
+	*insn_idx =3D pad;
+	return INSN_IDX_UPDATED;
+}
+
 static int process_bpf_exit_full(struct bpf_verifier_env *env,
 				 bool *do_print_state,
 				 bool exception_exit)
@@ -19935,8 +20070,14 @@ static int do_check_insn(struct bpf_verifier_env=
 *env, bool *do_print_state)
 				cur_func(env)->no_stack_arg_load =3D true;
 			if (bpf_is_callx(insn))
 				return check_func_callx(env, insn, &env->insn_idx);
-			if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
-				return check_func_call(env, insn, &env->insn_idx);
+			if (insn->src_reg =3D=3D BPF_PSEUDO_CALL) {
+				int call_idx =3D env->insn_idx;
+
+				err =3D check_func_call(env, insn, &env->insn_idx);
+				if (err)
+					return err;
+				return process_global_call_unwind(env, call_idx, do_print_state);
+			}
 			if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL)
 				return check_kfunc_call(env, insn, &env->insn_idx);
 			return check_helper_call(env, insn, &env->insn_idx);
--=20
2.53.0-Meta

