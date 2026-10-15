Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7543E9584
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 04:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792036981; cv=none; b=TFIAPZTCAYe5WGfoIrLUZ7+rMPQ8UJteHpEv8xHHAxZWYBdK5w8YmtnvBEUzMQVOQbu4H2o98y9n4+nOedisDIHPZyrK/kCWoBYthi8UU4HFnlVbh++GHDiwISOI6HFBt67KVYEUL33G74avICSU3g8BhfjBWRgrBNcQA2x8uz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792036981; c=relaxed/simple;
	bh=yS1gBqUIM0sWVKtyGP5nc8A6fnvdeq0wWr2eAh84C7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrBa+o7ZSeJyBUjNPR3kc2/GVBoAmVVTIsFCpFZgl9M7fJY/iNS9FbaGdj09ylPrCiAjF0SUIgJuNM9twcJIz/cH15IJVMXSvHfAL+QoQKKVGnMSTWpPxlBbafZG98vj62Rf2VzM+23FaeJw0nP3XSCmYimufeKyrxkOA39Le5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 486CF31498F268; Wed, 14 Oct 2026 21:02:50 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v11 13/26] bpf: Allow a subprog to end with a call that does not return
Date: Wed, 14 Oct 2026 21:02:50 -0700
Message-ID: <20261015040250.860960-1-yonghong.song@linux.dev>
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

A compiler emits nothing after a call it knows does not return: a cleanup
pad's call to _Unwind_Resume, which libbpf resolves to bpf_unwind_resume(=
),
or a call to a Rust function that returns `!` because it unwinds. Built
with panic=3Dunwind, rustc gives for example

        fail:
                call bpf_unwind
        L0:     goto L0
        check:
                if w1 > 0x7 goto L0
                w0 =3D w1
                exit
        L0:     call fail
        prog:
                ...
                r1 =3D r6
                call _Unwind_Resume

and check_subprogs() refuses prog() and check(): "last insn is not an exi=
t
or jmp".

Let a call to a subprog or to a kfunc be the last insn of a subprog, and
give it no fall-through edge in the CFG walk or in bpf_insn_successors().
Whether a call to a subprog really never returns is up to do_check(),
which rejects a path on which it does, with the message check_subprogs()
gives: where a static subprog returns to it in prepare_func_exit(), which
also covers the hidden exits of a tail call and of a BPF_LD_[ABS|IND],
and at any call to a global subprog, which is taken to return even if it
can only throw. A static subprog that only ends in bpf_unwind(),
bpf_unwind_resume() or bpf_throw() never gets there, so a call to one may
now end a subprog in any program, as may a call to one of those kfuncs.

A compiler ends a subprog with a call to a subprog only if the callee has
no exit, and with a call to a kfunc only if the kfunc never returns, so
check_subprogs() refuses a final call to a callee with an exit, or to any
other kfunc, before do_check() can fail on something else first. For a
kfunc, do_check() would also be too late on a speculative path: it
recovers from the refusal there, while a branch the kfunc pushed after th=
e
call, as bpf_res_spin_lock() and an iterator's next do, would go on into
the next subprog. A helper always returns, so a helper call there is
refused too, as is a poisoned CO-RE insn. bpf_unwind_resume() is lowered
to 'r0 =3D 0; exit' as before.

The insns after such a call belong to the next subprog, so no fastcall
spill/fill pattern is looked for around it.

Backtracking tells an exit from a subprog from an exit from a callback by
whether the insn before the one it returns to is a call: a subprog return=
s
right after its call, a callback to the insn that called it. A subprog ma=
y
now start right after a call that ends the previous one, and start with a
call to bpf_loop() on the arguments its caller set up. The exit of the
callback then looked like a subprog's, and since bpf_loop() marks its
arguments precise, backtracking hit "backtracking exit unexpected regs". =
A
call that ends its subprog is never returned to, so it does not count.

Stack liveness has to handle such a call as well. update_insn() computes
an insn's live_before as (live_after & ~must_write) | may_read, where
live_after is the union of its successors' live_before, and a callee's
reads of its caller's stack are part of may_read of the call insn. The
function returned early for an insn with no successors, which used to be
only an exit, whose may_read is empty, so nothing was lost. A call that
ends a subprog has no successors either. Take

        frame:
                r1 =3D 1
                *(u64 *)(r10 - 8) =3D r1
                r1 =3D r10
                r1 +=3D -8
                call fail
        fail:
                r2 =3D *(u64 *)(r1 + 0)
                r1 =3D result ll
                *(u64 *)(r1 + 0) =3D r2
                call bpf_unwind

'call fail' has no successors: it is frame()'s last insn, so it has no
fall-through, and no record covers it, so it has no landing pad either.
The load in fail() puts fp-8 in may_read of 'call fail'. With the early
return, live_before of 'call fail' stays empty, so fp-8 is dead there and
at every insn before it. 'call fail' is a prune point, where the verifier
cleans the state and poisons fp-8, and the load in fail() is then refused=
:
"slot poisoned by dead code elimination". Without the early return,
live_before of 'call fail' is its may_read, fp-8, which goes back up to
the store, and the load is accepted. An exit still gets an empty
live_before.

bpf_stack_slot_alive() asks, for each caller's frame, whether a slot is
live at the insn after the frame's call. frame() has no insn after
'call fail', and the lookup would read past the end of frame()'s masks,
so it is skipped for a call that ends its subprog.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h | 10 +++++
 kernel/bpf/backtrack.c       |  6 ++-
 kernel/bpf/cfg.c             |  5 +++
 kernel/bpf/liveness.c        |  9 ++---
 kernel/bpf/verifier.c        | 74 ++++++++++++++++++++++++++++++------
 5 files changed, 85 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1c33b2cf29cf..cc7528f7d11d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1730,6 +1730,16 @@ bool btf_struct_is_composed_of(struct bpf_verifier=
_env *env, const struct btf *b
 u32 btf_func_arg_align(const struct btf *btf, const struct btf_type *t);
=20
 int bpf_find_subprog(struct bpf_verifier_env *env, int off);
+
+static inline bool bpf_call_ends_subprog(struct bpf_verifier_env *env, i=
nt idx)
+{
+	struct bpf_insn *insn =3D &env->prog->insnsi[idx];
+
+	if (!bpf_pseudo_call(insn) && !bpf_pseudo_kfunc_call(insn))
+		return false;
+	return idx + 1 =3D=3D env->prog->len || bpf_find_subprog(env, idx + 1) =
>=3D 0;
+}
+
 bool bpf_is_throw_kfunc(struct bpf_insn *insn);
 int bpf_compute_const_regs(struct bpf_verifier_env *env);
 int bpf_prune_dead_branches(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 16f6ef59ddf7..1c69fe1e8e3f 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -589,11 +589,13 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx, int subseq_idx,
 			 * *subprog* from exit from *callback*. In the former
 			 * case, we need to propagate the precision of the
 			 * return registers, if necessary. In the latter we
-			 * never do that.
+			 * never do that. A call that ends its subprog is never
+			 * returned to, so it does not count.
 			 */
 			from_subprog_call =3D subseq_idx - 1 >=3D 0 &&
 					    (bpf_pseudo_call(&env->prog->insnsi[subseq_idx - 1]) ||
-					     bpf_is_callx(&env->prog->insnsi[subseq_idx - 1]));
+					     bpf_is_callx(&env->prog->insnsi[subseq_idx - 1])) &&
+					    !bpf_call_ends_subprog(env, subseq_idx - 1);
=20
 			r0_precise =3D from_subprog_call && bt_is_reg_set(bt, BPF_REG_0);
 			r2_precise =3D from_subprog_call && bt_is_reg_set(bt, BPF_REG_2);
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 9608293bdc06..852102a1fb43 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -215,6 +215,10 @@ static int visit_func_call_insn(int t, struct bpf_in=
sn *insns,
 		return ret;
=20
 	insn_sz =3D bpf_is_ldimm64(&insns[t]) ? 2 : 1;
+	if (bpf_call_ends_subprog(env, t)) {
+		ret =3D DONE_EXPLORING;
+		goto callee;
+	}
 	ret =3D push_insn(t, t + insn_sz, FALLTHROUGH, env);
 	if (ret)
 		return ret;
@@ -223,6 +227,7 @@ static int visit_func_call_insn(int t, struct bpf_ins=
n *insns,
 	/* when we exit from subprog, we need to record non-linear history */
 	mark_jmp_point(env, t + insn_sz);
=20
+callee:
 	if (visit_callee) {
 		w =3D t + insns[t].imm + 1;
 		mark_prune_point(env, t);
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 8b7ee551ff6f..e53ef302e69c 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -386,7 +386,7 @@ bpf_insn_successors(struct bpf_verifier_env *env, u32=
 idx)
=20
 	opcode_info =3D &opcode_info_tbl[BPF_CLASS(insn->code) | BPF_OP(insn->c=
ode)];
 	insn_sz =3D bpf_is_ldimm64(insn) ? 2 : 1;
-	if (opcode_info->can_fallthrough)
+	if (opcode_info->can_fallthrough && !bpf_call_ends_subprog(env, idx))
 		succ->items[succ->cnt++] =3D idx + insn_sz;
=20
 	if (opcode_info->can_jump)
@@ -435,8 +435,6 @@ static inline bool update_insn(struct bpf_verifier_en=
v *env,
 	u32 s, w;
=20
 	succ =3D bpf_insn_successors(env, insn_idx);
-	if (succ->cnt =3D=3D 0)
-		return false;
=20
 	/* All instructions of one frame array share the same mask width */
 	for (s =3D 0; s < succ->cnt; ++s) {
@@ -544,7 +542,7 @@ bool bpf_stack_slot_alive(struct bpf_verifier_env *en=
v, u32 frameno, u32 half_sp
 	 * Slot is alive if it is read before q->insn_idx in current func insta=
nce,
 	 * or if for some outer func instance:
 	 * - alive before callsite if callsite calls callback or is callx, othe=
rwise
-	 * - alive after callsite,
+	 * - alive after callsite, unless the call ends its subprog,
 	 * - or alive at the landing pad a cleanup record gives the callsite
 	 */
 	struct live_stack_query *q =3D &env->liveness->live_stack_query;
@@ -579,7 +577,8 @@ bool bpf_stack_slot_alive(struct bpf_verifier_env *en=
v, u32 frameno, u32 half_sp
=20
 		alive =3D callee_stack_access_at_callsite(env, callsite)
 			? is_live_before(instance, callsite, rel, half_spi)
-			: is_live_before(instance, callsite + 1, rel, half_spi);
+			: !bpf_call_ends_subprog(env, callsite) &&
+			  is_live_before(instance, callsite + 1, rel, half_spi);
=20
 		if (!alive && unlikely(env->cleanup_info_cnt)) {
 			int pad =3D bpf_exc_pad_of_call(env, callsite);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index da20f4ca073d..63f0fec6ddb8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3317,6 +3317,17 @@ static void find_subprog_properties(struct bpf_ver=
ifier_env *env)
 	}
 }
=20
+static int subprog_falls_through(struct bpf_verifier_env *env, int subpr=
og, int idx)
+{
+	verbose(env, "last insn is not an exit or jmp\n");
+	bpf_diag_program_structure(
+		env, idx, "subprogram can fall through",
+		"End each subprogram with an exit or an explicit jump that keeps contr=
ol flow inside the subprogram.",
+		"Subprogram %d reaches its last instruction %d without an exit or jump=
, so control could continue into the next subprogram.",
+		subprog, idx);
+	return -EINVAL;
+}
+
 static int check_subprogs(struct bpf_verifier_env *env)
 {
 	int i, subprog_start, subprog_end, off, cur_subprog =3D 0;
@@ -3356,26 +3367,45 @@ static int check_subprogs(struct bpf_verifier_env=
 *env)
 			/*
 			 * To avoid fall-through from one subprog into another,
 			 * the last insn of the subprog should be either exit
-			 * or unconditional jump back or bpf_throw call.
+			 * or unconditional jump back or a call that never
+			 * returns: to a kfunc checked below, or to a subprog
+			 * that do_check() finds never returns.
 			 */
 			if (code !=3D (BPF_JMP | BPF_EXIT) &&
 			    code !=3D (BPF_JMP32 | BPF_JA) &&
 			    code !=3D (BPF_JMP | BPF_JA) &&
-			    !insn_is_gotox(&insn[i])) {
-				verbose(env, "last insn is not an exit or jmp\n");
-				bpf_diag_program_structure(
-					env, i, "subprogram can fall through",
-					"End each subprogram with an exit or an explicit jump that keeps co=
ntrol flow inside the subprogram.",
-					"Subprogram %d reaches its last instruction %d without an exit or j=
ump, so control could continue into the next subprogram.",
-					cur_subprog, i);
-				return -EINVAL;
-			}
+			    !insn_is_gotox(&insn[i]) &&
+			    !bpf_call_ends_subprog(env, i))
+				return subprog_falls_through(env, cur_subprog, i);
 			subprog_start =3D subprog_end;
 			cur_subprog++;
 			if (cur_subprog < env->subprog_cnt)
 				subprog_end =3D subprog[cur_subprog + 1].start;
 		}
 	}
+
+	/*
+	 * A compiler ends a subprog with a call to a subprog only if the calle=
e
+	 * has no exit, and with a call to a kfunc only if the kfunc never
+	 * returns. Refuse any other final call here, before do_check() can fai=
l
+	 * on something else first, or follow a branch a kfunc pushed after it.
+	 */
+	for (i =3D 0; i < env->subprog_cnt; i++) {
+		int last =3D subprog[i + 1].start - 1, callee;
+
+		if (bpf_pseudo_kfunc_call(&insn[last])) {
+			if (!bpf_is_unwind_kfunc(&insn[last]) &&
+			    !bpf_is_unwind_resume_kfunc(&insn[last]) &&
+			    !bpf_is_throw_kfunc(&insn[last]))
+				return subprog_falls_through(env, i, last);
+			continue;
+		}
+		if (!bpf_pseudo_call(&insn[last]))
+			continue;
+		callee =3D bpf_find_subprog(env, last + insn[last].imm + 1);
+		if (callee >=3D 0 && subprog[callee].exit_idx !=3D U32_MAX)
+			return subprog_falls_through(env, i, last);
+	}
 	return 0;
 }
=20
@@ -11836,6 +11866,14 @@ static bool retval_range_within(struct bpf_retva=
l_range range, const struct bpf_
 		return range.minval <=3D reg_smin(reg) && reg_smax(reg) <=3D range.max=
val;
 }
=20
+static int check_return_to_call(struct bpf_verifier_env *env, int call_i=
dx)
+{
+	if (!bpf_call_ends_subprog(env, call_idx))
+		return 0;
+	return subprog_falls_through(env, bpf_find_containing_subprog(env, call=
_idx) -
+					  env->subprog_info, call_idx);
+}
+
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx=
)
 {
 	struct bpf_verifier_state *state =3D env->cur_state, *prev_st;
@@ -11910,10 +11948,14 @@ static int prepare_func_exit(struct bpf_verifie=
r_env *env, int *insn_idx)
 	 * converges is_state_visited() would prune that visit eventually.
 	 */
 	in_callback_fn =3D callee->in_callback_fn;
-	if (in_callback_fn)
+	if (in_callback_fn) {
 		*insn_idx =3D callee->callsite;
-	else
+	} else {
+		err =3D check_return_to_call(env, callee->callsite);
+		if (err)
+			return err;
 		*insn_idx =3D callee->callsite + 1;
+	}
=20
 	if (env->log.level & BPF_LOG_LEVEL) {
 		verbose(env, "returning from callee:\n");
@@ -19419,6 +19461,8 @@ static void mark_fastcall_pattern_for_call(struct=
 bpf_verifier_env *env,
 	s16 off;
 	int i;
=20
+	if (bpf_call_ends_subprog(env, insn_idx))
+		return;
 	if (!bpf_get_call_summary(env, call, &cs))
 		return;
=20
@@ -20101,7 +20145,13 @@ static int do_check_insn(struct bpf_verifier_env=
 *env, bool *do_print_state)
 				return check_func_callx(env, insn, &env->insn_idx);
 			if (insn->src_reg =3D=3D BPF_PSEUDO_CALL) {
 				int call_idx =3D env->insn_idx;
+				int callee =3D bpf_find_subprog(env, call_idx + insn->imm + 1);
=20
+				if (callee >=3D 0 && bpf_subprog_is_global(env, callee)) {
+					err =3D check_return_to_call(env, call_idx);
+					if (err)
+						return err;
+				}
 				err =3D check_func_call(env, insn, &env->insn_idx);
 				if (err)
 					return err;
--=20
2.53.0-Meta

