Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B1840B102
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 05:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789624651; cv=none; b=TEAVazG0H59UvMV74cNgbbIB0ULeTqaeEFCHre9bIgqqmdWeKtscMbtsaRraLJKXYfEFptN+5HnGZ/o3cMtp7xDXz3Mlf+ZCMQ/jn9/zwE3eUM6m42bF9VPc8kYglRrUu02kUc/qHoCLvM5dvEAKB0MRZcESmapCo5bqA6pG1HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789624651; c=relaxed/simple;
	bh=UahBVSFAodyaPVw0DoBpnxfmYy24nNo4RAgw1PH8VW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETzUBQzdVq9fZ5WoiGn7jAbBafcjR9vU2YLwHRpp2g5TZepZIOG9TmNx6UYE5M4NBlVjWHab3L3SYU4RUH1ENhX9tB+Gm6d+njj3Gsg8Lmd1kZYJYWFRtHBq9dsgVTWJcJw2+AKtsn4PynQxUv4Ekdv4HYPQWl8ShC+Vgr5aFQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id D3DCB2B487D43B; Wed, 16 Sep 2026 22:57:26 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 08/20] bpf: Walk the exception unwind in the verifier
Date: Wed, 16 Sep 2026 22:57:26 -0700
Message-ID: <20260917055726.3930930-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917055645.3926444-1-yonghong.song@linux.dev>
References: <20260917055645.3926444-1-yonghong.song@linux.dev>
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

	at a throw, with the frame chain in env->cur_state->frame[]
	  if a record covers the call control is at
	      run that record's landing pad in this frame
	      on reaching its resume, pop the frame and carry on
	  else
	      pop the frame and carry on
	at the boundary, deliver

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

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_cleanup_abi.h |  16 +++++
 include/linux/bpf_verifier.h    |   1 +
 kernel/bpf/states.c             |   3 +
 kernel/bpf/verifier.c           | 102 +++++++++++++++++++++++++-------
 4 files changed, 99 insertions(+), 23 deletions(-)
 create mode 100644 include/linux/bpf_cleanup_abi.h

diff --git a/include/linux/bpf_cleanup_abi.h b/include/linux/bpf_cleanup_=
abi.h
new file mode 100644
index 000000000000..b6c1d589abda
--- /dev/null
+++ b/include/linux/bpf_cleanup_abi.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#ifndef _LINUX_BPF_CLEANUP_ABI_H
+#define _LINUX_BPF_CLEANUP_ABI_H
+
+/*
+ * Value arch_bpf_run_cleanup_pad() leaves in r0 on the way into a landi=
ng pad.
+ * It has to be a constant the verifier knows: LLVM names r0 as both the
+ * exception pointer and the exception selector register, so every pad r=
eads it
+ * before anything else and is free to store what it read. Kept on its o=
wn
+ * because the verifier and the arch dispatchers, which are assembly, ha=
ve to
+ * agree on it.
+ */
+#define BPF_PAD_ENTRY_R0	1
+
+#endif /* _LINUX_BPF_CLEANUP_ABI_H */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index fe8b26351a15..09fb89fda40a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -509,6 +509,7 @@ struct bpf_verifier_state {
=20
 	bool speculative;
 	bool in_sleepable;
+	bool unwinding;
=20
 	/* first and last insn idx of this verifier state */
 	u32 first_insn_idx;
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 66fb11b6c6a7..be0f529f7ecc 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -996,6 +996,9 @@ static bool states_equal(struct bpf_verifier_env *env=
,
 	if (old->in_sleepable !=3D cur->in_sleepable)
 		return false;
=20
+	if (old->unwinding !=3D cur->unwinding)
+		return false;
+
 	if (!refsafe(old, cur, &env->idmap_scratch))
 		return false;
=20
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9cbdb8339701..a3b34ded1392 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
+#include <linux/bpf_cleanup_abi.h>
 #include <linux/bpf_verifier.h>
 #include <linux/filter.h>
 #include <net/netlink.h>
@@ -1715,6 +1716,7 @@ int bpf_copy_verifier_state(struct bpf_verifier_sta=
te *dst_state,
 		return err;
 	dst_state->speculative =3D src->speculative;
 	dst_state->in_sleepable =3D src->in_sleepable;
+	dst_state->unwinding =3D src->unwinding;
 	dst_state->curframe =3D src->curframe;
 	dst_state->branches =3D src->branches;
 	dst_state->parent =3D src->parent;
@@ -10540,8 +10542,8 @@ static int push_callback_call(struct bpf_verifier=
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
@@ -10631,7 +10633,7 @@ static int check_func_call(struct bpf_verifier_en=
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
@@ -14511,7 +14513,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 		env->prog->call_session_cookie =3D true;
=20
 	if (bpf_is_throw_kfunc(insn))
-		return process_bpf_exit_full(env, NULL, true);
+		return unwind_step(env, insn_idx, &env->insn_idx);
=20
 	return 0;
 }
@@ -18436,9 +18438,75 @@ enum {
 	INSN_IDX_UPDATED =3D 2,
 };
=20
-static int process_bpf_exit_full(struct bpf_verifier_env *env,
-				 bool *do_print_state,
-				 bool exception_exit)
+static u32 unwind_pop_frame(struct bpf_verifier_env *env)
+{
+	struct bpf_verifier_state *state =3D env->cur_state;
+	struct bpf_func_state *callee =3D state->frame[state->curframe];
+	u32 callsite =3D callee->callsite;
+	struct bpf_func_state *caller;
+
+	caller =3D state->frame[state->curframe - 1];
+	account_processed_insns(env, callee, caller);
+	free_func_state(callee);
+	state->frame[state->curframe--] =3D NULL;
+	invalidate_outgoing_stack_args(env, caller);
+	return callsite;
+}
+
+static void unwind_enter_pad(struct bpf_verifier_env *env)
+{
+	struct bpf_func_state *frame =3D cur_func(env);
+
+	clear_caller_saved_regs(env, frame->regs);
+	mark_reg_unknown(env, frame->regs, BPF_REG_0);
+	__mark_reg_known(&frame->regs[BPF_REG_0], BPF_PAD_ENTRY_R0);
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
+
+	state->unwinding =3D true;
+	for (;;) {
+		int pad =3D bpf_cleanup_pad_of_call(env, callsite);
+
+		if (pad >=3D 0) {
+			unwind_enter_pad(env);
+			*insn_idx =3D pad;
+			return INSN_IDX_UPDATED;
+		}
+		if (!state->curframe)
+			return unwind_finish(env);
+		callsite =3D unwind_pop_frame(env);
+	}
+}
+
+static int process_cleanup_resume(struct bpf_verifier_env *env, int *ins=
n_idx)
+{
+	struct bpf_verifier_state *state =3D env->cur_state;
+
+	/* A pad entered by ordinary control flow. */
+	if (!state->unwinding) {
+		verbose(env,
+			"bpf_unwind_resume() at insn %d reached without an exception in fligh=
t\n",
+			*insn_idx);
+		return -EINVAL;
+	}
+	if (!state->curframe)
+		return unwind_finish(env);
+	return unwind_step(env, unwind_pop_frame(env), insn_idx);
+}
+
+static int process_bpf_exit_full(struct bpf_verifier_env *env, bool *do_=
print_state)
 {
 	struct bpf_func_state *cur_frame =3D cur_func(env);
=20
@@ -18448,25 +18516,11 @@ static int process_bpf_exit_full(struct bpf_ver=
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
@@ -18640,6 +18694,8 @@ static int do_check_insn(struct bpf_verifier_env =
*env, bool *do_print_state)
=20
 		env->jmps_processed++;
 		if (opcode =3D=3D BPF_CALL) {
+			if (bpf_is_unwind_resume_kfunc(insn))
+				return process_cleanup_resume(env, &env->insn_idx);
 			if (env->cur_state->active_locks) {
 				if ((insn->src_reg =3D=3D BPF_REG_0 &&
 				     insn->imm !=3D BPF_FUNC_spin_unlock &&
@@ -18673,7 +18729,7 @@ static int do_check_insn(struct bpf_verifier_env =
*env, bool *do_print_state)
 				env->insn_idx +=3D insn->imm + 1;
 			return INSN_IDX_UPDATED;
 		} else if (opcode =3D=3D BPF_EXIT) {
-			return process_bpf_exit_full(env, do_print_state, false);
+			return process_bpf_exit_full(env, do_print_state);
 		}
 		return check_cond_jmp_op(env, insn, &env->insn_idx);
 	}
--=20
2.53.0-Meta

