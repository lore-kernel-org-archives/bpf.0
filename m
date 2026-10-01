Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD5E3CF204
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861461; cv=none; b=pnprZQ358lBu4FtP4wDcxqqOrN9NUvWuI+Yp6SUPkI9lsD1r/1Ei84PYtiU+4BV/V1vR8m6nZ3UQNvESQsfQrsunknp+LbzyQuqNIzhgdLOK2UJVRJkHL4FwEskLnUqUrGbyr5GZCLBB3UGaK655IypDn/eI8iKTtfzEqFK4L/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861461; c=relaxed/simple;
	bh=Bc8WfN1FSbo9hQFIxFvySWIcKFUgtWJOlh2WYRYQcu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbg+XIN83HK1GiSdxpIVjqMkfSlw3YviCCnbBvO8C5vgNtE3a/AlgrGQAltGSRSBJgfywVQIGUfQ1jdCKRyRNwJbJNnP/69xftQ4/29ubbSPeSUEi+stdAT6UwxLO9pfTlIWaQjzGpQVNYjSOOASele8cTLxdgto9STHXSpmwE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 8AE102E6E0BA29; Thu,  1 Oct 2026 06:30:42 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v8 07/22] bpf: Follow an unwind to its landing pad in the verifier
Date: Thu,  1 Oct 2026 06:30:42 -0700
Message-ID: <20261001133042.1339539-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001133006.1335369-1-yonghong.song@linux.dev>
References: <20261001133006.1335369-1-yonghong.song@linux.dev>
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
returns normally. A pad ends in a resume (a later patch refuses one that
does not), lowered to 'r0 =3D 0; exit', so it returns too. The verifier n=
ow
follows that path.

Where the walk goes on:

  instruction                          goes on at
  -----------------------------------  ---------------------------------
  bpf_unwind(), record over it         its own frame's pad
  bpf_unwind(), no record over it      unwind_frames()
  bpf_unwind_resume()                  unwind_frames()
  call to a global subprog that can    next insn, and the unwind from the
  unwind                               returned state: to the call's pad,
                                       or on through unwind_frames()

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

  P gets A's frame as B and C left it, with r0 unknown and r1-r5
  cleared. Main returning goes through process_bpf_exit_full(): nothing
  may still be held, and r0 =3D 0 must suit the program type. r1-r5 are
  cleared there too, since the call main returns from clobbered them.

Why the pad's state is not taken at the call:

  the callee may, before unwinding     a snapshot at the call would trust
  -----------------------------------  ----------------------------------
  write the caller's stack via a ptr   the slot's old value
  overwrite a spilled pointer          a pointer that is now a scalar
  reinitialise a dynptr or iterator    the old dynptr or iterator
  change packet data                   stale packet pointers

  The callee's epilogue restores only r6-r9 and the frame pointer,
  none of the above. A covered call whose callee cannot unwind leaves
  its pad unreached.

  A global subprog is verified on its own, so the unwind out of it is
  taken from the state its call returns in, after check_func_call(),
  whose argument checks and packet invalidation already cover the list
  above; a dynptr passed to a global subprog is read-only to it.

Precision backtracking, three new edges:

  edge                     frame
  -----------------------  ---------------------------------------------
  global call <- its pad   stays in the caller (subseq_idx is the pad)
  unwind <- pad            moves to the frame the unwind left, recorded
                           in its history entry under INSN_F_UNWIND
  unwind <- main's exit    a history entry makes the unwinding insn,
                           which sets r0, the one before main's return

  In the example, backtracking from P:

    insn                bt->frame
    ------------------  ------------------------
    P                   1
    C: bpf_unwind()     3, from INSN_F_UNWIND
    C ... entry         2, at B's call to C
    B ... entry         1, at A's call to B
    A, before the call

Also:

 - check_kfunc_allowed() is split out of check_kfunc_call(), which the
   two kfuncs no longer reach. Until they are registered, it is what
   refuses them.
 - INSN_F_UNWIND takes a fifth flag bit from the history entry's padding.
 - The CFG walk marks a subprogram calling bpf_unwind() might_unwind,
   carried up by merge_callee_effects(). Where the program can unwind at
   all, a subprogram with a callx is marked too, since the pointer it
   calls through may have been handed to it rather than loaded there, and
   the mark is carried up to its callers again.
   unwind_out_of_global_call() reads it here, and later patches do too.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |  12 ++-
 kernel/bpf/backtrack.c       |  49 +++++++++-
 kernel/bpf/cfg.c             |  63 ++++++++++++
 kernel/bpf/verifier.c        | 179 +++++++++++++++++++++++++++++++++--
 4 files changed, 290 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a22ce69e9aff..c90fa3f5e787 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -383,6 +383,13 @@ enum {
 	INSN_F_SRC_REG_STACK =3D BIT(2), /* src_reg is PTR_TO_STACK */
=20
 	INSN_F_STACK_ARG_ACCESS =3D BIT(3),
+
+	/*
+	 * A bpf_unwind(), a resume or an unwinding global call that left frame
+	 * 'frame' for a landing pad in one of its callers; backtracking jumps
+	 * back into that frame here.
+	 */
+	INSN_F_UNWIND =3D BIT(4),
 };
=20
 /* Registers linked to one jump condition that a history entry can recor=
d */
@@ -393,8 +400,8 @@ struct bpf_jmp_history_entry {
 	u32 idx : 20;
 	u32 frame : 4;	/* stack access frame number */
 	/* special INSN_F_xxx flags */
-	u32 flags : 4;
-	u32 : 4;
+	u32 flags : 5;
+	u32 : 3;
 	u32 prev_idx : 20;
 	u32 spi : 12;	/* stack slot index */
 	/*
@@ -836,6 +843,7 @@ struct bpf_subprog_info {
 	s16 fastcall_stack_off;
 	bool has_tail_call: 1;
 	bool might_throw: 1;
+	bool might_unwind: 1;
 	bool tail_call_reachable: 1;
 	bool has_ld_abs: 1;
 	bool is_cb: 1;
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 0e38b9575328..f5504334df90 100644
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
@@ -424,7 +425,30 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
 		if (class =3D=3D BPF_STX)
 			bt_set_reg(bt, sreg);
 	} else if (class =3D=3D BPF_JMP || class =3D=3D BPF_JMP32) {
-		if (bpf_pseudo_call(insn) || bpf_is_callx(insn)) {
+		if (hist && (hist->flags & INSN_F_UNWIND)) {
+			/*
+			 * A bpf_unwind(), a resume or an unwinding global call
+			 * left frame hist->frame here, for a landing pad in
+			 * this one. The walk crosses back into that frame,
+			 * past any frames between, which were entered and
+			 * never returned from. The pad found r0 unknown and
+			 * r1-r5 clobbered; r6-r9 and the stack are this
+			 * frame's own and stay marked in its masks until the
+			 * walk comes back out.
+			 */
+			bt_clear_reg(bt, BPF_REG_0);
+			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
+				verifier_bug(env, "backtracking unwind unexpected regs %x",
+					     bt_reg_mask(bt));
+				return -EFAULT;
+			}
+			if (verifier_bug_if(hist->frame <=3D bt->frame, env,
+					    "unwind from frame %d to frame %d",
+					    hist->frame, bt->frame))
+				return -EFAULT;
+			bt->frame =3D hist->frame;
+			return 0;
+		} else if (bpf_pseudo_call(insn) || bpf_is_callx(insn)) {
 			int subprog_insn_idx, subprog =3D -1;
=20
 			if (bpf_pseudo_call(insn)) {
@@ -434,6 +458,24 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
 					return -EFAULT;
 			}
=20
+			if (bpf_exc_pad_of_call(env, idx) =3D=3D subseq_idx) {
+				/*
+				 * We came from the landing pad of a call to a
+				 * global subprog, branched to from the state
+				 * the call returns in: as on its return, no
+				 * frame was entered here. The call clobbered
+				 * r0-r5; r6-r9 and the stack are the caller's
+				 * own and keep going back from here.
+				 */
+				bt_clear_reg(bt, BPF_REG_0);
+				if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
+					verifier_bug(env, "landing pad unexpected regs %x",
+						     bt_reg_mask(bt));
+					return -EFAULT;
+				}
+				return 0;
+			}
+
 			/* callx calls static subprogs only */
 			if (subprog >=3D 0 && bpf_subprog_is_global(env, subprog)) {
 				/* check that jump history doesn't have any
@@ -956,6 +998,11 @@ int bpf_mark_chain_precision(struct bpf_verifier_env=
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
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 63afbc5fb296..81963b3bdd5a 100644
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
@@ -705,6 +716,57 @@ static int visit_insn(int t, struct bpf_verifier_env=
 *env)
 	}
 }
=20
+/*
+ * merge_callee_effects() carries might_unwind to where a subprog is cal=
led or
+ * has its address taken, but not to a subprog that calls it through a p=
ointer
+ * it was handed. So where the program can unwind at all, take every sub=
prog
+ * with a callx to be able to, and carry that up to its callers.
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
+	for (i =3D 0; i < env->subprog_cnt; i++)
+		if (env->subprog_info[i].might_unwind)
+			break;
+	if (i =3D=3D env->subprog_cnt)
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
@@ -795,6 +857,7 @@ int bpf_check_cfg(struct bpf_verifier_env *env)
 		}
 	}
 	ret =3D 0; /* cfg looks good */
+	mark_callx_might_unwind(env);
 	env->prog->aux->changes_pkt_data =3D env->subprog_info[0].changes_pkt_d=
ata;
 	env->prog->aux->might_sleep =3D env->subprog_info[0].might_sleep;
=20
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 80034429fdd0..c7a350be538e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14684,6 +14684,32 @@ static int check_special_kfunc(struct bpf_verifi=
er_env *env, struct bpf_call_arg
=20
 static int check_return_code(struct bpf_verifier_env *env, int regno, co=
nst char *reg_name);
=20
+static int check_kfunc_allowed(struct bpf_verifier_env *env, struct bpf_=
insn *insn,
+			       int insn_idx, struct bpf_call_arg_meta *meta)
+{
+	const char *operation;
+	int err;
+
+	err =3D bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, meta);
+	if (err =3D=3D -EACCES && meta->func_name) {
+		verbose(env, "calling kernel function %s is not allowed\n", meta->func=
_name);
+		operation =3D bpf_diag_fmt(env, "kfunc %s", meta->func_name);
+		bpf_diag_policy(
+			env, insn_idx, operation, "this program cannot call the kfunc",
+			"Use a kfunc allowed for this program type and attach point, or chang=
e the program context.");
+	}
+	return err;
+}
+
+/* noinline keeps a struct bpf_call_arg_meta off the caller's frame. */
+static noinline int check_kfunc_allowed_only(struct bpf_verifier_env *en=
v,
+					     struct bpf_insn *insn, int insn_idx)
+{
+	struct bpf_call_arg_meta meta;
+
+	return check_kfunc_allowed(env, insn, insn_idx, &meta);
+}
+
 static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_ins=
n *insn,
 			    int *insn_idx_p)
 {
@@ -14705,14 +14731,7 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
 	if (!insn->imm)
 		return 0;
=20
-	err =3D bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta);
-	if (err =3D=3D -EACCES && meta.func_name) {
-		verbose(env, "calling kernel function %s is not allowed\n", meta.func_=
name);
-		operation =3D bpf_diag_fmt(env, "kfunc %s", meta.func_name);
-		bpf_diag_policy(
-			env, insn_idx, operation, "this program cannot call the kfunc",
-			"Use a kfunc allowed for this program type and attach point, or chang=
e the program context.");
-	}
+	err =3D check_kfunc_allowed(env, insn, insn_idx, &meta);
 	if (err)
 		return err;
 	desc_btf =3D meta.btf;
@@ -19126,6 +19145,127 @@ enum {
 	INSN_IDX_UPDATED =3D 2,
 };
=20
+/*
+ * The current frame is leaving through an unwind. Its caller's saved re=
turn
+ * address now points at the pad covering the call, or, with none, at th=
e
+ * caller's epilogue, and so on down. Follow that from the state the fra=
me
+ * leaves in -- anything it wrote into its callers' stacks included -- t=
o the
+ * first pad, or to the main program's frame returning.
+ */
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
+		account_processed_insns(env, callee, caller);
+		free_func_state(callee);
+		state->frame[state->curframe--] =3D NULL;
+		invalidate_outgoing_stack_args(env, caller);
+		if (pad < 0)
+			continue;
+
+		/*
+		 * The frames between were entered and never returned from,
+		 * so tell precision backtracking which one this left.
+		 */
+		err =3D bpf_push_jmp_history(env, state, INSN_F_UNWIND, 0, frameno, NU=
LL, 0);
+		if (err)
+			return err;
+		clear_caller_saved_regs(env, caller->regs);
+		mark_reg_unknown(env, caller->regs, BPF_REG_0);
+		env->insn_idx =3D pad;
+		*do_print_state =3D true;
+		return INSN_IDX_UPDATED;
+	}
+
+	/*
+	 * The main frame returning ends the program, from its call if frames
+	 * were popped, else from the unwinding insn. Link that to the unwindin=
g
+	 * insn, so that backtracking from the exit starts where r0 is set and
+	 * not in code the unwind skipped.
+	 */
+	env->cur_hist_ent =3D NULL;
+	env->prev_insn_idx =3D env->insn_idx;
+	env->insn_idx =3D state->insn_idx;
+	err =3D bpf_push_jmp_history(env, state, 0, 0, 0, NULL, 0);
+	if (err)
+		return err;
+
+	/*
+	 * The call clobbered r1-r5, and r0 holds the zero the fixups put
+	 * there. Mark r0 unknown first: the known-zero helper keeps a NOT_INIT
+	 * type.
+	 */
+	clear_caller_saved_regs(env, cur_regs(env));
+	mark_reg_unknown(env, cur_regs(env), BPF_REG_0);
+	mark_reg_known_zero(env, cur_regs(env), BPF_REG_0);
+	return process_bpf_exit_full(env, do_print_state, false);
+}
+
+/*
+ * A global subprog is verified on its own, so an unwind out of one is n=
ot
+ * walked. Its call has a second successor instead: the unwind, taken fr=
om
+ * the state the call returns in, to this frame's pad or on out of it.
+ */
+static int unwind_out_of_global_call(struct bpf_verifier_env *env, int c=
all_idx,
+				     bool *do_print_state)
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
x,
+			      bool *do_print_state)
+{
+	struct bpf_func_state *frame =3D cur_func(env);
+	int pad =3D bpf_exc_pad_of_call(env, *insn_idx);
+	int err;
+
+	if (pad < 0) {
+		if (!env->cur_state->curframe) {
+			err =3D check_resource_leak(env, false, true,
+						  "an unwind with no landing pad");
+			if (err)
+				return err;
+		}
+		return unwind_frames(env, do_print_state);
+	}
+	clear_caller_saved_regs(env, frame->regs);
+	mark_reg_unknown(env, frame->regs, BPF_REG_0);
+	*insn_idx =3D pad;
+	return INSN_IDX_UPDATED;
+}
+
 static int process_bpf_exit_full(struct bpf_verifier_env *env,
 				 bool *do_print_state,
 				 bool exception_exit)
@@ -19380,13 +19520,32 @@ static int do_check_insn(struct bpf_verifier_en=
v *env, bool *do_print_state)
 					return -EINVAL;
 				}
 			}
+			if (bpf_is_unwind_kfunc(insn) || bpf_is_unwind_resume_kfunc(insn)) {
+				err =3D check_kfunc_allowed_only(env, insn, env->insn_idx);
+				if (err)
+					return err;
+				if (bpf_is_unwind_kfunc(insn))
+					return process_bpf_unwind(env, &env->insn_idx,
+								  do_print_state);
+				/*
+				 * The fixups lower this to 'r0 =3D 0; exit', and
+				 * the unwind goes on below this frame.
+				 */
+				return unwind_frames(env, do_print_state);
+			}
 			mark_reg_scratched(env, BPF_REG_0);
 			if (bpf_in_stack_arg_cnt(&env->subprog_info[cur_func(env)->subprogno]=
))
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
+				return unwind_out_of_global_call(env, call_idx, do_print_state);
+			}
 			if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL)
 				return check_kfunc_call(env, insn, &env->insn_idx);
 			return check_helper_call(env, insn, &env->insn_idx);
--=20
2.53.0-Meta

