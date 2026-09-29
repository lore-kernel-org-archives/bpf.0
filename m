Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF4C218592
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 00:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641013; cv=none; b=A+zMS3AlGv430RVkk99sEXaW2ZuCQh75bEeuUVpWl6hhB/FNVHdcT90F7rBiZru31ls+eNOhjNqZTh0QAzM4Yf22ZS24O/EsQLGXrfiCyoWX2ksLPbNrGuna0D09p/4HOMnxeSvBFMBTiOwUeTC3TiSKtyiZFofxOAOdl4qlDkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641013; c=relaxed/simple;
	bh=6mL8gGFxVCHw35nIrE/Wk33LQC/Ke9UbnJ9XDJZL0VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FR2gnoZ6stcgdClulYIwKkxv72GYafsthCHpoAiBDzqLQE+96Ch7qeAJ3B6aXQfcuRR+OANV62phQ0e7WnLD5aWwANk6H1RHUK34Z5GUOnTyn8IMU+4mSZrggRyW8oFb6fswKaRTbAC1rRG3kcJhN7eyRpbnOJjpMzyIT9M/mQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 69E412DE06BE74; Mon, 28 Sep 2026 17:16:38 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v7 07/22] bpf: Resume a covered call at its landing pad
Date: Mon, 28 Sep 2026 17:16:38 -0700
Message-ID: <20260929001638.3248952-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929001601.3242665-1-yonghong.song@linux.dev>
References: <20260929001601.3242665-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A landing pad runs in the frame that owns it, entered by an ordinary
return: bpf_unwind() rewrites the frame's saved return address, so the ca=
ll
the frame is suspended at comes back at the pad rather than at the next
instruction. That makes the pad a second successor of a covered call, in
the same frame, whose entry state is knowable without verifying the calle=
e
-- the state at the call with the caller-saved registers gone, since the
callee's epilogue puts r6-r9 and the stack back on its way out.
push_cleanup_pad_branch() pushes exactly that. The call to bpf_unwind()
itself never comes back to the instruction after it: it resumes at this
frame's pad where a record covers the call, and otherwise the frame
returns at once. Where that frame is the main program's, returning at onc=
e
is the program returning, so it leaves through process_bpf_exit_full() an=
d
the zero it returns is held to the program type.

Precision backtracking has to tell those two edges apart, and subseq_idx =
is
what it has to do it with. Coming back to a covered call from its own pad
stays in this frame, the callee never having been entered on that path.
Coming back to a resume is the opposite -- a resume leaves its frame the
way an exit does -- so the walk enters the callee there, and r6-r9 and th=
e
stack stay marked in this frame's masks until it comes back out. Miss tha=
t
and the callee is walked against the caller's masks.

Answering the two here skips check_kfunc_call(), so the filter it applies
first -- whether this program may call this kfunc at all -- is split out =
as
check_kfunc_allowed() and applied here too. Until the patch that register=
s
them, that filter is what refuses them.

The CFG walk starts summarising it too: a subprogram calling bpf_unwind()
is marked might_unwind, and merge_callee_effects() carries that up to its
callers. Nothing reads it yet; later patches do.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |   1 +
 kernel/bpf/backtrack.c       |  42 ++++++++++++++
 kernel/bpf/cfg.c             |  11 ++++
 kernel/bpf/verifier.c        | 108 ++++++++++++++++++++++++++++++++---
 4 files changed, 154 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 6d78c20e6507..0143688896b0 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -836,6 +836,7 @@ struct bpf_subprog_info {
 	s16 fastcall_stack_off;
 	bool has_tail_call: 1;
 	bool might_throw: 1;
+	bool might_unwind: 1;
 	bool tail_call_reachable: 1;
 	bool has_ld_abs: 1;
 	bool is_cb: 1;
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 0e38b9575328..90f30e152cbe 100644
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
@@ -434,6 +435,24 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
 					return -EFAULT;
 			}
=20
+			if (bpf_exc_pad_of_call(env, idx) =3D=3D subseq_idx) {
+				/*
+				 * We came from this call's landing pad, which
+				 * runs in the caller's frame: on that path the
+				 * callee's frame was never entered, so there is
+				 * no frame to leave. The call clobbered r0-r5;
+				 * r6-r9 and the stack are the caller's own and
+				 * keep going back from here.
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
@@ -523,6 +542,24 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
 			if (bt_subprog_exit(bt))
 				return -EFAULT;
 			return 0;
+		} else if (bpf_is_unwind_resume_kfunc(insn)) {
+			/*
+			 * A resume leaves its frame the way an exit does, so
+			 * the walk is crossing from the caller into the callee
+			 * here and has a frame to enter. The zero the resume
+			 * returns is its own: nothing further back defines r0,
+			 * and r1-r5 the call clobbered.
+			 */
+			bt_clear_reg(bt, BPF_REG_0);
+			bt_clear_reg(bt, BPF_REG_2);
+			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
+				verifier_bug(env, "backtracking resume unexpected regs %x",
+					     bt_reg_mask(bt));
+				return -EFAULT;
+			}
+			if (bt_subprog_enter(bt))
+				return -EFAULT;
+			return 0;
 		} else if (opcode =3D=3D BPF_CALL) {
 			/* kfunc with imm=3D=3D0 is invalid and fixup_kfunc_call will
 			 * catch this error later. Make backtracking conservative
@@ -956,6 +993,11 @@ int bpf_mark_chain_precision(struct bpf_verifier_env=
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
index 2eb07397e874..82b5abcc736b 100644
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
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fc3df452de2e..ee074d4a936b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14725,6 +14725,32 @@ static int check_special_kfunc(struct bpf_verifi=
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
+/* noinline saves the caller a 200-byte struct bpf_call_arg_meta on its =
frame. */
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
@@ -14746,14 +14772,7 @@ static int check_kfunc_call(struct bpf_verifier_=
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
@@ -19167,6 +19186,57 @@ enum {
 	INSN_IDX_UPDATED =3D 2,
 };
=20
+static int push_cleanup_pad_branch(struct bpf_verifier_env *env, int ins=
n_idx)
+{
+	struct bpf_verifier_state *branch;
+	struct bpf_func_state *frame;
+	int pad =3D bpf_exc_pad_of_call(env, insn_idx);
+
+	if (pad < 0)
+		return 0;
+	branch =3D push_stack(env, pad, insn_idx, false);
+	if (IS_ERR(branch))
+		return PTR_ERR(branch);
+	frame =3D branch->frame[branch->curframe];
+	/*
+	 * The state at that call with the caller-saved registers gone: the
+	 * callee's epilogue put r6-r9 and the stack back on the way out.
+	 */
+	clear_caller_saved_regs(env, frame->regs);
+	mark_reg_unknown(env, frame->regs, BPF_REG_0);
+	return 0;
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
+		err =3D check_resource_leak(env, false, !env->cur_state->curframe,
+					  "an unwind with no landing pad");
+		if (err)
+			return err;
+		if (env->cur_state->curframe)
+			return PROCESS_BPF_EXIT;
+		/*
+		 * The main program's frame returns at once, which is the
+		 * program returning. Mark r0 the zero the fixups leave after
+		 * the call, and leave through the exit, which is what holds
+		 * that zero to the program type.
+		 */
+		mark_reg_unknown(env, cur_regs(env), BPF_REG_0);
+		mark_reg_known_zero(env, cur_regs(env), BPF_REG_0);
+		return process_bpf_exit_full(env, do_print_state, false);
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
@@ -19421,7 +19491,29 @@ static int do_check_insn(struct bpf_verifier_env=
 *env, bool *do_print_state)
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
+				 * Mark r0 a known zero -- unknown first, as
+				 * the known-zero helper keeps the type it
+				 * finds, which here is NOT_INIT. The fixups
+				 * lower this to 'r0 =3D 0; exit', so the frame
+				 * returns a real zero.
+				 */
+				mark_reg_unknown(env, cur_regs(env), BPF_REG_0);
+				mark_reg_known_zero(env, cur_regs(env), BPF_REG_0);
+				return process_bpf_exit_full(env, do_print_state, false);
+			}
 			mark_reg_scratched(env, BPF_REG_0);
+			/* An unwind out of this call resumes at the pad. */
+			err =3D push_cleanup_pad_branch(env, env->insn_idx);
+			if (err)
+				return err;
 			if (bpf_in_stack_arg_cnt(&env->subprog_info[cur_func(env)->subprogno]=
))
 				cur_func(env)->no_stack_arg_load =3D true;
 			if (bpf_is_callx(insn))
--=20
2.53.0-Meta

