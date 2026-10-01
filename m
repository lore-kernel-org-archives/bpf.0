Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3603655E7
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861470; cv=none; b=BhpAEnpucvGVzFKHaUfl4OM5uFEDCU2jNjSXYT26pgaKbPUrBJZB9oubuxmtotcVfC74KzcBkU+V0/nfFPlrdm8+w8VyuzFI8cVtKnyd6wNWX45213GGJGA9GVGVNKTg0hyFnu+hD/nw0JvyGXByh4D5FGQcPg6OkhyqP/2Jghw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861470; c=relaxed/simple;
	bh=PD8gC816Cdflb240bSfVpnzfXxHJ+7TjTP8nIWawhmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSfsZnbvH//MeF2tdeRm0jHM8CjOwRHqu1zig0r9oHy+NZC5bMNxGA0DO8yJjY4iqpjXkh44PnoQze0OHQBSgTT7CHqITFe649VcmSeyfwUk0lJESKV/WVGYI46VbD1RlZVwDiXXefd8DFubo04g7MnHqv7gSYHVdcosnTBDsYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id A850E2E6E0BC28; Thu,  1 Oct 2026 06:30:47 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v8 08/22] bpf: Require an unwind to leave a frame holding what it entered with
Date: Thu,  1 Oct 2026 06:30:47 -0700
Message-ID: <20261001133047.1339752-1-yonghong.song@linux.dev>
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

A landing pad is compiler output for one frame: it drops what that frame
holds and resumes. Nothing in it knows about its caller's locks and
references, or its callees'. Hold every frame an unwind leaves to that:
record what the program holds when a frame is entered, and require an
unwind leaving the frame to have put it back.

This is not what keeps a pad sound. An unwind is followed into the
caller's pad from the state the callee left, so a pad is verified against
what really holds at that point, and whatever an abandoned frame keeps
still reaches the resource checks at the program's exit. What the rule
changes is where a program gets refused, and so what the message points
at. Say foo() takes an RCU read lock and calls bar(), which unwinds:

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

Without the rule, the unwind reaches foo's pad without the lock, and that
pad's unlock is refused. The refusal is right, but it blames foo; the
mistake is in bar. With the rule, bar's resume is refused for not leaving
the RCU state as it found it. A frame that takes a lock or a reference an=
d
leaves through an unwind is worse: without the rule it is refused only at
the program's exit, as a leak or a held lock, with nothing pointing at th=
e
frame that dropped it. The rule does refuse a program that could be prove=
d
safe, a callee releasing its caller's reference and a caller's pad that
relies on that, but compiled code does not do that. A pad only knows abou=
t
its own frame.

Counts are enough for the locks. An unwind is a kfunc call, and those are
refused under a spin lock, so no unwind happens with one held and a
swapped spin lock is never seen. The RCU and preemption counts are nestin=
g
depths, and the IRQ state is compared by id. References go by id, since
ids only go up and bpf_reference_state does not say which frame acquired
one.

The frames in between need the same of them, and have nothing to run: whe=
re
no record covers the call a frame is suspended at, the unwind sends it to
its epilogue, so what it acquired since it was entered is dropped on the
floor and no path of its own arrives to say so. Ask it at the call instea=
d,
which is where it is abandoned -- check_unwind_through_call(). Per frame
rather than of the whole stack at the unwind, since a frame that does car=
ry
a record may hold what its pad will release. A callx counts as any
subprogram that might unwind, its target not being known there.

So every frame an unwind leaves is asked, one way of asking per way out:

  - "a resume": a frame with a pad runs it and ends at bpf_unwind_resume(=
).
    The frame that raised the unwind leaves this way where a record cover=
s
    its bpf_unwind(), and so does every caller whose call is covered.
  - "an unwind with no landing pad": the frame that raised it with no
    record over its bpf_unwind(), returning through the exit patched in
    after it.
  - "an unwind through this call": every caller whose call no record
    covers, asked at the call since nothing of it runs again.

Nothing else is left to ask: a frame other than the one that raised the
unwind is suspended at a call, and the call either carries a record or do=
es
not. The unwind reaches no further than the program it was raised in:
unwind_frames() stops at the main program's frame.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h | 11 ++++++
 kernel/bpf/exception.c       | 76 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/exception.h       |  6 +++
 kernel/bpf/verifier.c        | 37 ++++++++++++++++++
 4 files changed, 130 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c90fa3f5e787..a625d96a5b80 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -339,6 +339,17 @@ struct bpf_func_state {
 	bool in_async_callback_fn;
 	bool in_exception_callback_fn;
 	bool no_stack_arg_load;
+	/*
+	 * What the program held when this frame was entered. A frame an unwind
+	 * leaves has to have put these back: a diagnostic, which refuses the
+	 * frame at fault rather than a later pad or the program's exit.
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
index e12cdb12cde3..8d48cf69bef0 100644
--- a/kernel/bpf/exception.c
+++ b/kernel/bpf/exception.c
@@ -141,6 +141,72 @@ int bpf_exc_check_info(struct bpf_verifier_env *env,=
 const union bpf_attr *attr,
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
@@ -174,6 +240,16 @@ static void mark_call_sites(struct bpf_verifier_env =
*env)
 	}
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
 	int err;
diff --git a/kernel/bpf/exception.h b/kernel/bpf/exception.h
index 96dac3037d75..615df30fdfdb 100644
--- a/kernel/bpf/exception.h
+++ b/kernel/bpf/exception.h
@@ -8,12 +8,18 @@
=20
 union bpf_attr;
 struct bpf_verifier_env;
+struct bpf_verifier_state;
+struct bpf_func_state;
 struct bpf_insn;
=20
 int bpf_exc_check_info(struct bpf_verifier_env *env, const union bpf_att=
r *attr,
 		       bpfptr_t uattr);
 int bpf_exc_prepare(struct bpf_verifier_env *env);
 int bpf_exc_check_prog(struct bpf_verifier_env *env);
+bool bpf_prog_may_unwind(const struct bpf_verifier_env *env);
+void bpf_exc_record_frame_entry(const struct bpf_verifier_state *state,
+				struct bpf_func_state *frame, u32 id_gen);
+int bpf_exc_check_frame_balance(struct bpf_verifier_env *env, const char=
 *prefix);
 int bpf_exc_pad_of_call(struct bpf_verifier_env *env, u32 idx);
 bool bpf_is_unwind_kfunc(const struct bpf_insn *insn);
 bool bpf_is_unwind_resume_kfunc(const struct bpf_insn *insn);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c7a350be538e..a7b25ab04051 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10807,6 +10807,7 @@ static int setup_func_entry(struct bpf_verifier_e=
nv *env, int subprog, int calls
 			callsite,
 			state->curframe + 1 /* frameno within this callchain */,
 			subprog /* subprog number within this prog */);
+	bpf_exc_record_frame_entry(state, callee, env->id_gen);
 	err =3D set_callee_state_cb(env, caller, callee, callsite);
 	if (err)
 		goto err_out;
@@ -19244,6 +19245,32 @@ static int unwind_out_of_global_call(struct bpf_=
verifier_env *env, int call_idx,
 	return INSN_IDX_UPDATED;
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
@@ -19258,6 +19285,9 @@ static int process_bpf_unwind(struct bpf_verifier=
_env *env, int *insn_idx,
 			if (err)
 				return err;
 		}
+		err =3D bpf_exc_check_frame_balance(env, "an unwind with no landing pa=
d");
+		if (err)
+			return err;
 		return unwind_frames(env, do_print_state);
 	}
 	clear_caller_saved_regs(env, frame->regs);
@@ -19527,6 +19557,9 @@ static int do_check_insn(struct bpf_verifier_env =
*env, bool *do_print_state)
 				if (bpf_is_unwind_kfunc(insn))
 					return process_bpf_unwind(env, &env->insn_idx,
 								  do_print_state);
+				err =3D bpf_exc_check_frame_balance(env, "a resume");
+				if (err)
+					return err;
 				/*
 				 * The fixups lower this to 'r0 =3D 0; exit', and
 				 * the unwind goes on below this frame.
@@ -19534,6 +19567,10 @@ static int do_check_insn(struct bpf_verifier_env=
 *env, bool *do_print_state)
 				return unwind_frames(env, do_print_state);
 			}
 			mark_reg_scratched(env, BPF_REG_0);
+			/* An unwind with no pad leaves the frame for good. */
+			err =3D check_unwind_through_call(env, env->insn_idx);
+			if (err)
+				return err;
 			if (bpf_in_stack_arg_cnt(&env->subprog_info[cur_func(env)->subprogno]=
))
 				cur_func(env)->no_stack_arg_load =3D true;
 			if (bpf_is_callx(insn))
--=20
2.53.0-Meta

