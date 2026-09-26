Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9A738F926
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 05:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790398855; cv=none; b=prl8sTerLDXMqtayXsRBe1ZA3tpON4fj9xcrZh5YekG5tYHvaSbkHjswjFl5Rc7zzvguF6F/eNo2QljTGBAivWKQzYg+esg5UqxQ/NzRFjlWhvpyl5G9WyBsvwNRHSzRrdSk/i9GEMmdrbOTxSyQB4LvL6k/6rmUADWaacvThf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790398855; c=relaxed/simple;
	bh=vFcgi+wUxzpAHaXlj8Ag4pXhv9FWYMBqgfSmdUjTP6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBsRcQrSFDTJEf7fspvRi+Hg4fsX8oxVikJG5IE2iwJxBtsBgIuG8U/YU/khevFVgFcdMSOWXU8dPWT7wdVsYb+D8iJKaxQU2XOT/f8vBylD1Zyb5LaczAUHGL+Kgs3eN+V0P7Gimx5e4viVShqpyclFWRQAmXZacN2QsZfOQbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 3E22C2D4590184; Fri, 25 Sep 2026 22:00:42 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 07/21] bpf: Resume a covered call at its landing pad
Date: Fri, 25 Sep 2026 22:00:42 -0700
Message-ID: <20260926050042.2216692-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926050006.2213110-1-yonghong.song@linux.dev>
References: <20260926050006.2213110-1-yonghong.song@linux.dev>
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
the frame is suspended at comes back at the pad instead of at the next
instruction. Nothing crosses a frame boundary that the instruction stream
does not already describe.

That makes the pad an ordinary second successor of a covered call, in the
same frame, and its entry state knowable without verifying the callee at
all: it is the state at the call with the caller-saved registers gone,
since the callee's epilogue puts r6-r9 and the stack back on its way out.
push_cleanup_pad_branch() pushes exactly that.

The call to bpf_unwind() itself never returns to the instruction after it=
,
having rewritten its own return address along with the rest. Control
resumes at this frame's pad when a record covers the call, and otherwise
the frame returns at once -- which its caller already explores as the oth=
er
side of its own covered call.

Resource accounting needs nothing new. Whatever the callee held it releas=
ed
in its own pads before this frame's runs, so both sides of the call leave
the caller holding what it held itself, and the ordinary checks at each
exit cover the pad like any other path.

This is also where both kfuncs become callable: they are registered here,
beside the rules that say where each is allowed.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/backtrack.c       | 24 ++++++++++++++++-
 kernel/bpf/cfg.c             | 11 ++++++++
 kernel/bpf/helpers.c         |  2 ++
 kernel/bpf/liveness.c        |  3 +++
 kernel/bpf/verifier.c        | 52 ++++++++++++++++++++++++++++++++++++
 6 files changed, 92 insertions(+), 1 deletion(-)

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
index 0e38b9575328..57665c67e66b 100644
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
@@ -434,8 +435,24 @@ static int backtrack_insn(struct bpf_verifier_env *e=
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
 			/* callx calls static subprogs only */
-			if (subprog >=3D 0 && bpf_subprog_is_global(env, subprog)) {
+			} else if (subprog >=3D 0 && bpf_subprog_is_global(env, subprog)) {
 				/* check that jump history doesn't have any
 				 * extra instructions from subprog; the next
 				 * instruction after call to global subprog
@@ -956,6 +973,11 @@ int bpf_mark_chain_precision(struct bpf_verifier_env=
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
index 4e2b6985bc96..cfd4fe4049ca 100644
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
@@ -678,6 +687,8 @@ static int visit_insn(int t, struct bpf_verifier_env =
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
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 08aee86a155c..f291611fe578 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -5095,6 +5095,8 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE=
 | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_from_vpid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
+BTF_ID_FLAGS(func, bpf_unwind)
+BTF_ID_FLAGS(func, bpf_unwind_resume)
 #ifdef CONFIG_BPF_EVENTS
 BTF_ID_FLAGS(func, bpf_send_signal_task)
 #endif
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 4e0273a8ceee..c9ee4f10f725 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -364,6 +364,9 @@ bpf_insn_successors(struct bpf_verifier_env *env, u32=
 idx)
 		return jt;
 	}
=20
+	if (unlikely(bpf_is_unwind_resume_kfunc(insn)))
+		return succ;
+
 	opcode_info =3D &opcode_info_tbl[BPF_CLASS(insn->code) | BPF_OP(insn->c=
ode)];
 	insn_sz =3D bpf_is_ldimm64(insn) ? 2 : 1;
 	if (opcode_info->can_fallthrough)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fc3df452de2e..77176250f866 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19167,6 +19167,40 @@ enum {
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
x)
+{
+	struct bpf_func_state *frame =3D cur_func(env);
+	int pad =3D bpf_exc_pad_of_call(env, *insn_idx);
+
+	if (pad < 0)
+		return PROCESS_BPF_EXIT;
+	clear_caller_saved_regs(env, frame->regs);
+	mark_reg_unknown(env, frame->regs, BPF_REG_0);
+	*insn_idx =3D pad;
+	return INSN_IDX_UPDATED;
+}
+
 static int process_bpf_exit_full(struct bpf_verifier_env *env,
 				 bool *do_print_state,
 				 bool exception_exit)
@@ -19404,6 +19438,20 @@ static int do_check_insn(struct bpf_verifier_env=
 *env, bool *do_print_state)
=20
 		env->jmps_processed++;
 		if (opcode =3D=3D BPF_CALL) {
+			if (bpf_is_unwind_kfunc(insn))
+				return process_bpf_unwind(env, &env->insn_idx);
+			if (bpf_is_unwind_resume_kfunc(insn)) {
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
 			if (env->cur_state->active_locks) {
 				/* similar to static subprog calls callx is allowed under a lock */
 				if (!bpf_is_callx(insn) &&
@@ -19422,6 +19470,10 @@ static int do_check_insn(struct bpf_verifier_env=
 *env, bool *do_print_state)
 				}
 			}
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

