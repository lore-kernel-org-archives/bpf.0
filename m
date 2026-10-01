Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADB730C160
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861471; cv=none; b=DNIzro2YhyHVvhf35MNOWMGHaunz4L2cDprUdY3gC9ESaoWbjtm1BnnTD3aFn/hrsuUqLtR7VTN0CPqxP9SLUTqE0ho03fP7hkcP4IssH5aTQ9mDrCrQAYmyzqs3t69Qj/mUpTDyZbqhZ1OhY9O83X20L5Mid5zsdyCT2lQQL/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861471; c=relaxed/simple;
	bh=zMdiIh9FYXTOPdp+Brt2qBER0ETtzkCjUTO9WuNLmmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5PMsP/JS6NdK2bM4rrewjrahNGChm1dLayxZ46sU3fDydcE2IS9IJkPF/BgAOqwjFSUMuaPFw7/TmJlv1RXcRPtSzAXnKK2KGAVhfrKV0F67I4id0PrEIJEbLK2a7ZIfMEH13/YNB4b9UBStjJPIHVRfbudehxyq8G5r0ONkss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id DD8112E6E0BC62; Thu,  1 Oct 2026 06:30:52 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v8 09/22] bpf: Refuse a landing pad that does not resume
Date: Thu,  1 Oct 2026 06:30:52 -0700
Message-ID: <20261001133052.1339921-1-yonghong.song@linux.dev>
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

A cleanup pad runs drop glue and calls bpf_unwind_resume(), so the frame
returns and the unwind goes on. A catch pad runs the same drops and then
carries on in its frame, stopping the unwind. Only the first is supported=
:
bpf_unwind() rewrites every frame's return address in one pass, so a
caller of a catch pad's frame would resume at a pad for an unwind already
caught.

Nothing in the record says which kind a pad is, but the code does, as LLV=
M
emits it: a cleanup pad reaches _Unwind_Resume, a catch pad reaches a
return. An unwind arriving at a pad, in the frame that raised it, in a
caller, or out of a call to a global subprog, is the only way in, and it
marks the frame it enters. bpf_exc_check_insn() asks that mark about ever=
y
instruction of a program carrying a table, and refuses:

 - an exit, which is how a catch pad ends
 - a tail call, and a BPF_LD_[ABS|IND], which leaves through an exit on a
   failed load
 - an indirect jump
 - a bpf_unwind(), and a call to a global subprogram that might_unwind
 - an instruction reached both inside and outside a pad

do_check_insn() refuses the other half of it, a bpf_unwind_resume() the
mark does not find in a pad. That one is asked of every program rather
than only those carrying a table, since a program with no table has no pa=
d
to be in.

The first three concern the pad's own frame, since a subprogram it calls
may do any of them and still come back; an unwind is refused in a pad's
callees too, since it never does. do_check() asks before pruning, so the
mark stays out of states_equal().

A speculative walk can reach a pad too; that is answered as do_check()
answers anything it cannot allow speculatively, by marking the instructio=
n
for a barrier and stopping rather than refusing the program. Such a visit
leaves no in-pad or outside-pad mark for a real path to be refused over,
and an exit it finds in a pad gets the barrier too. A callback that can
unwind is refused as well, its helper frame being C with no pad.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |  4 ++
 kernel/bpf/exception.c       | 88 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/exception.h       |  2 +
 kernel/bpf/verifier.c        | 28 ++++++++++++
 4 files changed, 122 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a625d96a5b80..ccac422737fb 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -339,6 +339,8 @@ struct bpf_func_state {
 	bool in_async_callback_fn;
 	bool in_exception_callback_fn;
 	bool no_stack_arg_load;
+	/* an unwind reached this frame and its landing pad is running */
+	bool in_pad;
 	/*
 	 * What the program held when this frame was entered. A frame an unwind
 	 * leaves has to have put these back: a diagnostic, which refuses the
@@ -716,6 +718,8 @@ struct bpf_insn_aux_data {
 	u64 non_stack_access:1; /* instruction can access non-stack memory */
 	/* true if some jump or call instruction targets this instruction */
 	u64 jump_target:1;
+	u64 in_cleanup_pad:1; /* reached with a landing pad running */
+	u64 outside_cleanup_pad:1; /* reached the other way */
=20
 	unsigned int orig_idx; /* original instruction index, initialized once =
*/
 	/*
diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
index 8d48cf69bef0..e824883d3981 100644
--- a/kernel/bpf/exception.c
+++ b/kernel/bpf/exception.c
@@ -141,6 +141,15 @@ int bpf_exc_check_info(struct bpf_verifier_env *env,=
 const union bpf_attr *attr,
 BTF_ID_LIST_SINGLE(bpf_unwind_id, func, bpf_unwind)
 BTF_ID_LIST_SINGLE(bpf_unwind_resume_id, func, bpf_unwind_resume)
=20
+int bpf_exc_check_callback(struct bpf_verifier_env *env, int subprog)
+{
+	if (!env->subprog_info[subprog].might_unwind)
+		return 0;
+
+	verbose(env, "subprog %d may unwind and is used as a callback\n", subpr=
og);
+	return -EINVAL;
+}
+
 void bpf_exc_record_frame_entry(const struct bpf_verifier_state *state,
 				struct bpf_func_state *frame, u32 id_gen)
 {
@@ -308,6 +317,85 @@ bool bpf_is_unwind_resume_kfunc(const struct bpf_ins=
n *insn)
 	       insn->imm =3D=3D bpf_unwind_resume_id[0];
 }
=20
+/* Is an unwind in flight: is this frame running a pad, or called from o=
ne? */
+static bool unwinding(const struct bpf_verifier_state *state)
+{
+	u32 i;
+
+	for (i =3D 0; i <=3D state->curframe; i++)
+		if (state->frame[i]->in_pad)
+			return true;
+	return false;
+}
+
+int bpf_exc_check_insn(struct bpf_verifier_env *env, struct bpf_insn *in=
sn)
+{
+	bool in_pad =3D cur_func(env)->in_pad;
+	struct bpf_insn_aux_data *aux;
+	u32 i =3D env->insn_idx;
+	const char *why =3D NULL;
+
+	if (unwinding(env->cur_state)) {
+		if (bpf_is_unwind_kfunc(insn)) {
+			verbose(env, "insn %u starts a second unwind while one is in flight\n=
", i);
+			return -EINVAL;
+		}
+		if (bpf_pseudo_call(insn)) {
+			int subprog =3D bpf_find_subprog(env, i + insn->imm + 1);
+
+			if (subprog >=3D 0 && bpf_subprog_is_global(env, subprog) &&
+			    env->subprog_info[subprog].might_unwind) {
+				verbose(env,
+					"insn %u calls global subprog %d, which can unwind while an unwind =
is in flight\n",
+					i, subprog);
+				return -EINVAL;
+			}
+		}
+	}
+
+	aux =3D &env->insn_aux_data[i];
+
+	if (in_pad ? aux->outside_cleanup_pad : aux->in_cleanup_pad) {
+		verbose(env, "insn %u runs both inside and outside a landing pad\n", i=
);
+		return -EINVAL;
+	}
+	/*
+	 * Only a real path marks the insn: a speculative one that finds the
+	 * other mark gets a barrier, so it must not leave one for a real path
+	 * to be refused over.
+	 */
+	if (!env->cur_state->speculative) {
+		if (in_pad)
+			aux->in_cleanup_pad =3D true;
+		else
+			aux->outside_cleanup_pad =3D true;
+	}
+
+	if (!in_pad)
+		return 0;
+
+	if (insn->code =3D=3D (BPF_JMP | BPF_EXIT)) {
+		verbose(env,
+			"exit at insn %u ends a landing pad: a catch pad is not supported yet=
, only cleanup pads that resume\n",
+			i);
+		return -EOPNOTSUPP;
+	}
+	if (bpf_helper_call(insn) && insn->imm =3D=3D BPF_FUNC_tail_call)
+		why =3D "is a tail call, which replaces the frame";
+	else if (BPF_CLASS(insn->code) =3D=3D BPF_LD &&
+		 (BPF_MODE(insn->code) =3D=3D BPF_ABS || BPF_MODE(insn->code) =3D=3D B=
PF_IND))
+		why =3D "is a BPF_LD_[ABS|IND], which can leave through the epilogue";
+	else if (insn->code =3D=3D (BPF_JMP | BPF_JA | BPF_X) ||
+		 insn->code =3D=3D (BPF_JMP32 | BPF_JA | BPF_X))
+		why =3D "is an indirect jump";
+
+	if (!why)
+		return 0;
+
+	verbose(env, "insn %u %s, and is in a landing pad\n", i, why);
+	return -EINVAL;
+}
+
 int bpf_exc_pad_of_call(struct bpf_verifier_env *env, u32 idx)
 {
 	u32 pad =3D env->insn_aux_data[idx].cleanup_pad;
diff --git a/kernel/bpf/exception.h b/kernel/bpf/exception.h
index 615df30fdfdb..e72e68ebfe85 100644
--- a/kernel/bpf/exception.h
+++ b/kernel/bpf/exception.h
@@ -23,5 +23,7 @@ int bpf_exc_check_frame_balance(struct bpf_verifier_env=
 *env, const char *prefix
 int bpf_exc_pad_of_call(struct bpf_verifier_env *env, u32 idx);
 bool bpf_is_unwind_kfunc(const struct bpf_insn *insn);
 bool bpf_is_unwind_resume_kfunc(const struct bpf_insn *insn);
+int bpf_exc_check_callback(struct bpf_verifier_env *env, int subprog);
+int bpf_exc_check_insn(struct bpf_verifier_env *env, struct bpf_insn *in=
sn);
=20
 #endif /* __BPF_EXCEPTION_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a7b25ab04051..f3ed68960d70 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10945,6 +10945,10 @@ static int push_callback_call(struct bpf_verifie=
r_env *env, struct bpf_insn *ins
 	 * callbacks
 	 */
 	env->subprog_info[subprog].is_cb =3D true;
+	err =3D bpf_exc_check_callback(env, subprog);
+	if (err)
+		return err;
+
 	if (bpf_pseudo_kfunc_call(insn) &&
 	    !is_callback_calling_kfunc(insn->imm)) {
 		verifier_bug(env, "kfunc %s#%d not marked as callback-calling",
@@ -19163,6 +19167,10 @@ static int unwind_frames(struct bpf_verifier_env=
 *env, bool *do_print_state)
 	while (state->curframe) {
 		callee =3D cur_func(env);
 		caller =3D state->frame[state->curframe - 1];
+		/* A subprog that can unwind is refused as a callback. */
+		if (verifier_bug_if(callee->in_callback_fn, env,
+				    "unwind out of callback frame %d", state->curframe))
+			return -EFAULT;
 		pad =3D bpf_exc_pad_of_call(env, callee->callsite);
 		/* The caller is at its call now, not at this frame's insn. */
 		state->insn_idx =3D callee->callsite;
@@ -19182,6 +19190,7 @@ static int unwind_frames(struct bpf_verifier_env =
*env, bool *do_print_state)
 			return err;
 		clear_caller_saved_regs(env, caller->regs);
 		mark_reg_unknown(env, caller->regs, BPF_REG_0);
+		caller->in_pad =3D true;
 		env->insn_idx =3D pad;
 		*do_print_state =3D true;
 		return INSN_IDX_UPDATED;
@@ -19240,6 +19249,7 @@ static int unwind_out_of_global_call(struct bpf_v=
erifier_env *env, int call_idx,
 	frame =3D cur_func(env);
 	clear_caller_saved_regs(env, frame->regs);
 	mark_reg_unknown(env, frame->regs, BPF_REG_0);
+	frame->in_pad =3D true;
 	env->insn_idx =3D pad;
 	*do_print_state =3D true;
 	return INSN_IDX_UPDATED;
@@ -19292,6 +19302,7 @@ static int process_bpf_unwind(struct bpf_verifier=
_env *env, int *insn_idx,
 	}
 	clear_caller_saved_regs(env, frame->regs);
 	mark_reg_unknown(env, frame->regs, BPF_REG_0);
+	frame->in_pad =3D true;
 	*insn_idx =3D pad;
 	return INSN_IDX_UPDATED;
 }
@@ -19557,6 +19568,11 @@ static int do_check_insn(struct bpf_verifier_env=
 *env, bool *do_print_state)
 				if (bpf_is_unwind_kfunc(insn))
 					return process_bpf_unwind(env, &env->insn_idx,
 								  do_print_state);
+				if (!cur_func(env)->in_pad) {
+					verbose(env, "resume at insn %d is not in a landing pad\n",
+						env->insn_idx);
+					return -EINVAL;
+				}
 				err =3D bpf_exc_check_frame_balance(env, "a resume");
 				if (err)
 					return err;
@@ -19681,6 +19697,18 @@ static int do_check(struct bpf_verifier_env *env=
)
 			}
 		}
=20
+		if (unlikely(env->cleanup_info_cnt)) {
+			err =3D bpf_exc_check_insn(env, insn);
+			/* An exit in a pad is refused as unsupported, not invalid. */
+			if ((error_recoverable_with_nospec(err) || err =3D=3D -EOPNOTSUPP) &&
+			    state->speculative) {
+				insn_aux->nospec =3D true;
+				goto process_bpf_exit;
+			}
+			if (err)
+				return err;
+		}
+
 		if (bpf_is_prune_point(env, env->insn_idx)) {
 			err =3D bpf_is_state_visited(env, env->insn_idx);
 			if (err < 0)
--=20
2.53.0-Meta

