Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA0A25771
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 00:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641021; cv=none; b=Kb+QBJVA49B3LclpvC6GS2PpxAhhOCB2uTbx8OOdyjUgWrr4Fk27jZcctCdXizEkpy/MXd9eLIRliW3/tVJZUzMER3YUWxoq3IuvtPeBqytC+Bm+QD2aVzy+nZEl0LPyEI8KifG/5QuFSqTPIKAKfsQyhy6t62XSWNo4Zn2PHd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641021; c=relaxed/simple;
	bh=1Gl96q4NnzO2RavAOfMCLjky5TJhxzOLaHfSG5kU5Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+7PLcwkWmFWc1sbr/x1VCGZgGNR5p2Or4bSn7Q1ODBeiQlV5NcHDuf8b3A/Az1nJYhO+NoveQ/fXWosgoY0H1w0Of5frt/gcrP05yE2VFpRirRB43aM0D+qPSs/0NXtP2pdUEpHb8cZu5WDZoQrNkGSaYHVS1haAcSYD8cBwns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 88C912DE06BEA9; Mon, 28 Sep 2026 17:16:43 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v7 08/22] bpf: Require an unwind to leave a frame holding what it entered with
Date: Mon, 28 Sep 2026 17:16:43 -0700
Message-ID: <20260929001643.3249386-1-yonghong.song@linux.dev>
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

A landing pad's entry state is the state at the call it belongs to, taken
before the callee ran -- push_cleanup_pad_branch() snapshots it there. Th=
at
is right for the frame's own registers and stack, which the callee's
epilogue puts back, and wrong for what the program shares: nothing restor=
es
the locks in bpf_verifier_state. So a callee that drops a lock its caller
took and then resumes leaves the caller's pad verified against a state th=
at
still holds it. Say foo() takes an RCU read lock and calls bar(), which
unwinds:

  foo:
      call bpf_rcu_read_lock
  1:  call bar                  /* covered, pad at 3 */
  2:  r0 =3D 0; exit
  3:  call bpf_rcu_read_unlock  /* pad: drops the lock foo() took */
      call bpf_unwind_resume

  bar:
  1:  call bpf_unwind           /* covered, pad at 3 */
  2:  r0 =3D 0; exit
  3:  call bpf_rcu_read_unlock  /* pad: drops it a second time */
      call bpf_unwind_resume

At run time both pads run and the one lock is released twice, and no sing=
le
state shows it: bar's path ends at its resume, and foo's pad is verified
from the snapshot at its call to bar. A frame that acquires a lock and
leaves through an unwind hides the same way. Fix both by making the
snapshot true -- record what the program holds when a frame is entered an=
d
require an unwind leaving it to have put that back, at the resume and at =
a
bpf_unwind() no record covers. References go by id, since ids only go up
and bpf_reference_state does not say which frame acquired one.

The frames in between need the same of them, and have nothing to run: whe=
re
no record covers the call a frame is suspended at, the JIT sends it to it=
s
epilogue, so what it acquired since it was entered is dropped on the floo=
r
and no path of its own arrives to say so. Ask it at the call instead, whi=
ch
is where it is abandoned -- check_unwind_through_call(). Per frame rather
than of the whole stack at the unwind, since a frame that does carry a
record may hold what its pad will release. A callx counts as any subprogr=
am
that might unwind, its target not being known there.

So every frame an unwind leaves is asked, one way of asking per way out:

  - "a resume": a frame with a pad runs it and ends at bpf_unwind_resume(=
).
    The frame that raised the unwind leaves this way where a record cover=
s
    its bpf_unwind(), and so does every frame above it whose call is
    covered.
  - "an unwind with no landing pad": the frame that raised it with no
    record over its bpf_unwind(), returning through the exit patched in
    after it.
  - "an unwind through this call": every frame above it whose call no
    record covers, asked at the call since nothing of it runs again.

Nothing else is left to ask: a frame other than the one that raised the
unwind is suspended at a call, and the call either carries a record or do=
es
not. The unwind reaches no further than the program it was raised in, the
walk stopping at the first frame that is not a subprogram.

One walk is then left that cannot happen. A resume ends its frame the way
an exit does, so the verifier continued the caller at the instruction
after its call -- the one place a resume does not return to, since
bpf_unwind() rewrote that address before any pad ran. Where it does retur=
n
is walked already: the caller's pad is the branch pushed at the call, and
with no pad nothing of the caller runs. Walking on anyway keeps code the
JIT never reaches out of the dead code sweep, and arrives holding what
only the pad releases, which refuses a correct program. End the path ther=
e
instead, as an unwind with no landing pad already does. The main program'=
s
frame keeps the old way out: no caller to leave to, and the exit is what
holds its zero to the program type.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h | 12 ++++++
 kernel/bpf/exception.c       | 76 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/exception.h       |  6 +++
 kernel/bpf/verifier.c        | 50 +++++++++++++++++++++++-
 4 files changed, 142 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 0143688896b0..75e572a8a1ba 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -339,6 +339,18 @@ struct bpf_func_state {
 	bool in_async_callback_fn;
 	bool in_exception_callback_fn;
 	bool no_stack_arg_load;
+	/*
+	 * What the program held when this frame was entered. An unwind leaves
+	 * the frame without running anything below it, so the frame has to put
+	 * these back to what it found before it goes -- otherwise a caller's
+	 * landing pad, whose state was taken at the call, is wrong about them.
+	 */
+	u32 entry_active_locks;
+	u32 entry_preempt_locks;
+	u32 entry_rcu_locks;
+	u32 entry_irq_id;
+	u32 entry_id_gen;
+	u32 entry_acquired_refs;
 	/* For callback calling functions that limit number of possible
 	 * callback executions (e.g. bpf_loop) keeps track of current
 	 * simulated iteration number.
diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
index c1779d2d02f0..c0b0b8478af5 100644
--- a/kernel/bpf/exception.c
+++ b/kernel/bpf/exception.c
@@ -12,6 +12,72 @@
 BTF_ID_LIST_SINGLE(bpf_unwind_id, func, bpf_unwind)
 BTF_ID_LIST_SINGLE(bpf_unwind_resume_id, func, bpf_unwind_resume)
=20
+void bpf_exc_record_frame_entry(const struct bpf_verifier_state *state,
+				struct bpf_func_state *frame, u32 id_gen)
+{
+	u32 i;
+
+	frame->entry_active_locks =3D state->active_locks;
+	frame->entry_preempt_locks =3D state->active_preempt_locks;
+	frame->entry_rcu_locks =3D state->active_rcu_locks;
+	frame->entry_irq_id =3D state->active_irq_id;
+
+	/* Ids only ever go up, so this one tells the frame's own apart. */
+	frame->entry_id_gen =3D id_gen;
+	frame->entry_acquired_refs =3D 0;
+	for (i =3D 0; i < state->acquired_refs; i++)
+		if (state->refs[i].type =3D=3D REF_TYPE_PTR)
+			frame->entry_acquired_refs++;
+}
+
+int bpf_exc_check_frame_balance(struct bpf_verifier_env *env, const char=
 *prefix)
+{
+	const struct bpf_verifier_state *state =3D env->cur_state;
+	const struct bpf_func_state *frame =3D cur_func(env);
+	u32 i, held;
+	const char *what;
+
+	if (state->active_rcu_locks !=3D frame->entry_rcu_locks)
+		what =3D "bpf_rcu_read_lock";
+	else if (state->active_preempt_locks !=3D frame->entry_preempt_locks)
+		what =3D "bpf_preempt_disable";
+	else if (state->active_irq_id !=3D frame->entry_irq_id)
+		what =3D "bpf_local_irq_save";
+	else if (state->active_locks !=3D frame->entry_active_locks)
+		what =3D "bpf_spin_lock";
+	else
+		what =3D NULL;
+
+	if (what) {
+		verbose(env, "%s does not leave the frame's %s state as it found it\n"=
,
+			prefix, what);
+		return -EINVAL;
+	}
+
+	/*
+	 * References the same way. ids only go up, so entry_id_gen splits
+	 * refs[] in two at frame entry: nothing above that line may still be
+	 * held, and the count below it has to be what it was.
+	 */
+	for (i =3D 0, held =3D 0; i < state->acquired_refs; i++) {
+		if (state->refs[i].type !=3D REF_TYPE_PTR)
+			continue;
+		if (state->refs[i].id > frame->entry_id_gen) {
+			verbose(env, "%s keeps the reference id=3D%d the frame acquired\n",
+				prefix, state->refs[i].id);
+			return -EINVAL;
+		}
+		held++;
+	}
+	if (held !=3D frame->entry_acquired_refs) {
+		verbose(env, "%s does not leave the frame's references as it found it\=
n",
+			prefix);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int reject_throw(struct bpf_verifier_env *env)
 {
 	u32 i;
@@ -46,6 +112,16 @@ static int mark_call_sites(struct bpf_verifier_env *e=
nv)
 	return 0;
 }
=20
+bool bpf_prog_may_unwind(const struct bpf_verifier_env *env)
+{
+	u32 i;
+
+	for (i =3D 0; i < env->subprog_cnt; i++)
+		if (env->subprog_info[i].might_unwind)
+			return true;
+	return false;
+}
+
 int bpf_exc_check_prog(struct bpf_verifier_env *env)
 {
 	if (bpf_prog_is_offloaded(env->prog->aux)) {
diff --git a/kernel/bpf/exception.h b/kernel/bpf/exception.h
index 1552438083d8..e93da039b5bd 100644
--- a/kernel/bpf/exception.h
+++ b/kernel/bpf/exception.h
@@ -6,9 +6,15 @@
 #include <linux/types.h>
=20
 struct bpf_verifier_env;
+struct bpf_verifier_state;
+struct bpf_func_state;
=20
 int bpf_prepare_cleanup_exceptions(struct bpf_verifier_env *env);
 int bpf_exc_check_prog(struct bpf_verifier_env *env);
+bool bpf_prog_may_unwind(const struct bpf_verifier_env *env);
+void bpf_exc_record_frame_entry(const struct bpf_verifier_state *state,
+				struct bpf_func_state *frame, u32 id_gen);
+int bpf_exc_check_frame_balance(struct bpf_verifier_env *env, const char=
 *prefix);
 int bpf_exc_pad_of_call(struct bpf_verifier_env *env, u32 idx);
=20
 #endif /* _LINUX_BPF_EXCEPTION_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ee074d4a936b..4bdee3f02fe9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10774,6 +10774,7 @@ static int setup_func_entry(struct bpf_verifier_e=
nv *env, int subprog, int calls
 			callsite,
 			state->curframe + 1 /* frameno within this callchain */,
 			subprog /* subprog number within this prog */);
+	bpf_exc_record_frame_entry(state, callee, env->id_gen);
 	err =3D set_callee_state_cb(env, caller, callee, callsite);
 	if (err)
 		goto err_out;
@@ -19207,6 +19208,32 @@ static int push_cleanup_pad_branch(struct bpf_ve=
rifier_env *env, int insn_idx)
 	return 0;
 }
=20
+/* Can an unwind come back out of this call? */
+static bool call_may_unwind(struct bpf_verifier_env *env, const struct b=
pf_insn *insn,
+			    int insn_idx)
+{
+	int subprog;
+
+	/* Which subprog a callx lands in is not known here, so any may be it. =
*/
+	if (bpf_is_callx(insn))
+		return bpf_prog_may_unwind(env);
+	if (insn->src_reg !=3D BPF_PSEUDO_CALL)
+		return false;
+	subprog =3D bpf_find_subprog(env, insn_idx + insn->imm + 1);
+	return subprog >=3D 0 && env->subprog_info[subprog].might_unwind;
+}
+
+static int check_unwind_through_call(struct bpf_verifier_env *env, int i=
nsn_idx)
+{
+	const struct bpf_insn *insn =3D &env->prog->insnsi[insn_idx];
+
+	if (bpf_exc_pad_of_call(env, insn_idx) >=3D 0)
+		return 0;
+	if (!call_may_unwind(env, insn, insn_idx))
+		return 0;
+	return bpf_exc_check_frame_balance(env, "an unwind through this call");
+}
+
 static int process_bpf_unwind(struct bpf_verifier_env *env, int *insn_id=
x,
 			      bool *do_print_state)
 {
@@ -19215,8 +19242,13 @@ static int process_bpf_unwind(struct bpf_verifie=
r_env *env, int *insn_idx,
 	int err;
=20
 	if (pad < 0) {
-		err =3D check_resource_leak(env, false, !env->cur_state->curframe,
-					  "an unwind with no landing pad");
+		if (!env->cur_state->curframe) {
+			err =3D check_resource_leak(env, false, true,
+						  "an unwind with no landing pad");
+			if (err)
+				return err;
+		}
+		err =3D bpf_exc_check_frame_balance(env, "an unwind with no landing pa=
d");
 		if (err)
 			return err;
 		if (env->cur_state->curframe)
@@ -19498,6 +19530,16 @@ static int do_check_insn(struct bpf_verifier_env=
 *env, bool *do_print_state)
 				if (bpf_is_unwind_kfunc(insn))
 					return process_bpf_unwind(env, &env->insn_idx,
 								  do_print_state);
+				err =3D bpf_exc_check_frame_balance(env, "a resume");
+				if (err)
+					return err;
+				/*
+				 * No need to walk into the caller: its pad was
+				 * pushed as a branch at its call, and with no
+				 * pad nothing of it runs.
+				 */
+				if (env->cur_state->curframe)
+					return PROCESS_BPF_EXIT;
 				/*
 				 * Mark r0 a known zero -- unknown first, as
 				 * the known-zero helper keeps the type it
@@ -19512,6 +19554,10 @@ static int do_check_insn(struct bpf_verifier_env=
 *env, bool *do_print_state)
 			mark_reg_scratched(env, BPF_REG_0);
 			/* An unwind out of this call resumes at the pad. */
 			err =3D push_cleanup_pad_branch(env, env->insn_idx);
+			if (err)
+				return err;
+			/* Or, with no pad, leaves the frame for good. */
+			err =3D check_unwind_through_call(env, env->insn_idx);
 			if (err)
 				return err;
 			if (bpf_in_stack_arg_cnt(&env->subprog_info[cur_func(env)->subprogno]=
))
--=20
2.53.0-Meta

