Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7B538DC65
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 04:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791519350; cv=none; b=Fx2SBt39BqW8nbv95irF/gKK5TzBx33bjLabC9FVRcivT4n20oyhnIa2a9RhNTNNNMd/7OVDgc6/lpAZsx/Jyv6/jgzDHw6bI19tN/iOyy5CegY8JcjzhH6scnWKKGBMLYFXZbvl31tlo6BxANrc6AokHB1s1Xa3VoGpOCKphfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791519350; c=relaxed/simple;
	bh=h3vmVjvf8k/fha4itihgB6xYFK0vCJedDcuulzvweGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzckMHHtYl7+rt2X3vrI/MOeUz8nA7fQb37Zfu+qYQCSV+pIsw3ZsMAyJdA3LkU4N7eGqOvrxSkDEMIRGSU8widSa7G0/E0i13AuYqoVpghvJbyCHVYcksr8jp5cMoISzV/7moyX8jRQ2GW6OJbcyjqh6xW6zcBe3br4+Qx0iBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 47AF23008C5216; Thu,  8 Oct 2026 21:15:34 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v10 09/24] bpf: Refuse a landing pad that does not resume
Date: Thu,  8 Oct 2026 21:15:34 -0700
Message-ID: <20261009041534.27944-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009041447.17092-1-yonghong.song@linux.dev>
References: <20261009041447.17092-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A cleanup pad runs drop glue and calls bpf_unwind_resume(), so its frame
returns and the unwind goes on. A catch pad carries on in its frame
instead. Only the first is supported: bpf_unwind() rewrites every frame's
return address in one pass, so a catch pad's caller would still resume
at a pad.

Nothing in the record says which kind a pad is, but the code does: a
cleanup pad reaches _Unwind_Resume, a catch pad a return. So the unwind
marks the frame whose pad it enters, and refuses in the marked code:

  refused                                  where
  ---------------------------------------  ----------------------------
  an exit: how a catch pad ends            the pad's own frame
  a tail call, a BPF_LD_[ABS|IND]: it      the pad's own frame
    leaves through an exit on a failed
    load
  an indirect jump: nothing a compiler     the pad's own frame
    frontend emits in a pad needs one
  a bpf_unwind(), a call to a global       the pad and its callees
    subprog that might_unwind
  a bpf_unwind_resume() outside a pad      any program

The first three are refused only in the pad's own frame: a subprog the
pad calls may do them and still come back.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/exception.c       | 59 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/exception.h       |  1 +
 kernel/bpf/states.c          |  3 ++
 kernel/bpf/verifier.c        | 20 +++++++++++-
 5 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d3740ad20235..6449e4babc60 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -339,6 +339,7 @@ struct bpf_func_state {
 	bool in_async_callback_fn;
 	bool in_exception_callback_fn;
 	bool no_stack_arg_load;
+	bool in_pad;
 	/* For callback calling functions that limit number of possible
 	 * callback executions (e.g. bpf_loop) keeps track of current
 	 * simulated iteration number.
diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
index a0f088e225ac..2b9640099269 100644
--- a/kernel/bpf/exception.c
+++ b/kernel/bpf/exception.c
@@ -232,6 +232,65 @@ bool bpf_is_unwind_resume_kfunc(const struct bpf_ins=
n *insn)
 	       insn->imm =3D=3D bpf_unwind_resume_id[0];
 }
=20
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
+	if (!in_pad)
+		return 0;
+
+	if (insn->code =3D=3D (BPF_JMP | BPF_EXIT)) {
+		verbose(env,
+			"exit at insn %u ends a landing pad: a catch pad is not supported yet=
, only cleanup pads that resume\n",
+			i);
+		return -EINVAL;
+	}
+	if (bpf_helper_call(insn) && insn->imm =3D=3D BPF_FUNC_tail_call)
+		why =3D "is a tail call, which replaces the frame";
+	else if (BPF_CLASS(insn->code) =3D=3D BPF_LD &&
+		 (BPF_MODE(insn->code) =3D=3D BPF_ABS || BPF_MODE(insn->code) =3D=3D B=
PF_IND))
+		why =3D "is a BPF_LD_[ABS|IND], which can leave through the epilogue";
+	else if (insn->code =3D=3D (BPF_JMP | BPF_JA | BPF_X) ||
+		 insn->code =3D=3D (BPF_JMP32 | BPF_JA | BPF_X))
+		why =3D "is an indirect jump, which nothing a compiler frontend emits =
in a pad needs";
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
index 983b9af16a19..1d7fc795619f 100644
--- a/kernel/bpf/exception.h
+++ b/kernel/bpf/exception.h
@@ -18,5 +18,6 @@ int bpf_exc_pad_of_call(struct bpf_verifier_env *env, u=
32 idx);
 bool bpf_is_unwind_kfunc(const struct bpf_insn *insn);
 bool bpf_is_unwind_resume_kfunc(const struct bpf_insn *insn);
 int bpf_exc_check_callback(struct bpf_verifier_env *env, int subprog);
+int bpf_exc_check_insn(struct bpf_verifier_env *env, struct bpf_insn *in=
sn);
=20
 #endif /* __BPF_EXCEPTION_H */
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 4ffa5b7ebf0f..eaf95d6e81bc 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -956,6 +956,9 @@ static bool func_states_equal(struct bpf_verifier_env=
 *env, struct bpf_func_stat
 	if (!old->no_stack_arg_load && cur->no_stack_arg_load)
 		return false;
=20
+	if (old->in_pad !=3D cur->in_pad)
+		return false;
+
 	for (i =3D 0; i < MAX_BPF_REG; i++)
 		if (((1 << i) & live_regs) &&
 		    !regsafe(env, &old->regs[i], &cur->regs[i],
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4ab838ba21eb..59b275bfc949 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15243,8 +15243,13 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
=20
 	if (bpf_is_unwind_kfunc(insn))
 		return process_bpf_unwind(env, insn_idx_p, NULL);
-	if (bpf_is_unwind_resume_kfunc(insn))
+	if (bpf_is_unwind_resume_kfunc(insn)) {
+		if (!cur_func(env)->in_pad) {
+			verbose(env, "resume at insn %d is not in a landing pad\n", insn_idx)=
;
+			return -EINVAL;
+		}
 		return unwind_frames(env, NULL);
+	}
=20
 	return 0;
 }
@@ -19251,6 +19256,7 @@ static int unwind_frames(struct bpf_verifier_env =
*env, bool *do_print_state)
 			return err;
 		clear_caller_saved_regs(env, caller->regs);
 		mark_reg_unknown(env, caller->regs, BPF_REG_0);
+		caller->in_pad =3D true;
 		env->insn_idx =3D pad;
 		if (do_print_state)
 			*do_print_state =3D true;
@@ -19326,6 +19332,7 @@ static int process_global_call_unwind(struct bpf_=
verifier_env *env,
 	frame =3D cur_func(env);
 	clear_caller_saved_regs(env, frame->regs);
 	mark_reg_unknown(env, frame->regs, BPF_REG_0);
+	frame->in_pad =3D true;
 	env->insn_idx =3D pad;
 	*do_print_state =3D true;
 	return INSN_IDX_UPDATED;
@@ -19341,6 +19348,7 @@ static int process_bpf_unwind(struct bpf_verifier=
_env *env, int *insn_idx,
 		return unwind_frames(env, do_print_state);
 	clear_caller_saved_regs(env, frame->regs);
 	mark_reg_unknown(env, frame->regs, BPF_REG_0);
+	frame->in_pad =3D true;
 	*insn_idx =3D pad;
 	return INSN_IDX_UPDATED;
 }
@@ -19712,6 +19720,16 @@ static int do_check(struct bpf_verifier_env *env=
)
 			}
 		}
=20
+		if (unlikely(env->cleanup_info_cnt)) {
+			err =3D bpf_exc_check_insn(env, insn);
+			if (error_recoverable_with_nospec(err) && state->speculative) {
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

