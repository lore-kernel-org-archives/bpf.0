Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842799;
	b=o8VMwBGArnofwgzePhC63ysI3+JZv9vxvBF7nb6zTNjYQui0FRHkkAv1vETCTwb1ZWd6
	 3uyfxfTeFYECN4nnMkbAKKWqimzyq9NYeb2FdRoMcW8FQ55T8zWVQGPqFINDvp0LvMtpc
	 nxDrCo3ss2H7SCFe5bwiPsSiaQ5qUalf0gUOrMkeKouyl/j+WgWrRpFnyJ4itvB45+K7S
	 UbamuVsldY9LBFbFdqBmty4PqhBWp4Qnod0WNhYwPCWu0EcFpF8340Ax4c+dE0xPYTLei
	 4MJ1+l2iI47evO2weitxccagMNJRMIi7A4KYPcd3ASra/Nl5mgasDMv/en3KtJ8qhjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0MfzQ9uaLQOtbpZjsjqQcTgVeJwR89bCBP2I/pDH/pk=;
	b=V9axnsZPSdQ0eabTPU4l5P6KUvB0yptI4/9e4D1k6SVVunp/ihIMLynx4e6GWkDiVgrd
	 vFiU8tHTaqbyDWj5bGU/tZS811BQVAj6tXWFX4bJHQG429D15GXMm2G7Jp26afFopzzL6
	 DfxYIZsP7mOTSHQXXLLsOgK7uymDH5WiSeZcRdikH3rEM57oFrosVOkjqQSDbvS1SQ4Gm
	 BIj+2Z26O+K/M6WH9mULcSktl1UHirJZRcAeqiEItZzKUwqCWPDY4283D3HWWwOtR69ix
	 OTCa/mBSe2b+aWvfj6Jvfvt/fRy8d1wtGirN5M/aqVwyheXgVKueGkWk7QER8V+/WfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bnnDt6Gd;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A89F606A333
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 15:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A89F606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bnnDt6Gd
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso2796128a91.0
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 07:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794842797; x=1795447597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0MfzQ9uaLQOtbpZjsjqQcTgVeJwR89bCBP2I/pDH/pk=;
        b=bnnDt6GdXg+CkwT6bElidAKM2740W9qipj6ZMTn728TmSUd0p6ha+bNanOL8eC5cIQ
         ffH6lja65xzhSK9tlCpysMjeCNMkableo3FGsCmTRijcAzNJOFbMV5NAejs4/BPHdKSO
         +OE13H5ZDRu8bXGAzlNa8E/kHUA1HASVKj2mlrkysA+Upo1wvnfOVbp79FPbhL+V9itM
         zwXe03akvx4tcR89IgpK8NzE3MP9wdHooaOWVqVe1CmTJaJaVfK2w/wJp+eSBT+98F5W
         BLRwpRyQRQVreMFUt9Rwh47rMVjYeYLXtKnZ6WPxBoFTeierjNEwyp36IMsrb5RwpwhI
         ep9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794842797; x=1795447597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0MfzQ9uaLQOtbpZjsjqQcTgVeJwR89bCBP2I/pDH/pk=;
        b=xbEJbhQvdCmpdlT8uH+8eaY9Zqx08TAVYHFult/VBeT9w09WypKl9ZmXU46jEg8AtB
         2XZGIoMzcIMdtdubefi+8KC3TMk2glVKKz6Wo2E3SyBcv77J/68/XmGFslepyFuhxfSs
         yMMwsb5FANPLvFkBl8kUo7q4yT4sYtxtUtYhuEAcmE2W1sIXrMbqoI3UImmysXUuOZj8
         msmyVM2q+Bb3FPHvcaLe9fxaMU7v1hWUcaenOJOarTGjzjl7ThBPiG+bp41kngQsHHkL
         mxHs88w2+pKtH3HA4REytwmqGEEfe1clsibdk9wbgLmqf9iHOFZWszXNsu7CRMwjXZ4o
         6hUg==
X-Gm-Message-State: APuU4Z+O6tA4q4rl2tSBpHKwqWAl0SmY2ZSKyDaSFTofzI15frK4sN04
	AcL1ca5ekYZOQsY5fY44M+XHAfb/4Rzh4gRd6dw25NTwxXIOtnxLzUiOvLhpjQ==
X-Gm-Gg: AZFdTZean0ARj5kcAWdWJHHNQI/pYrmF1IFP23rZDhH92F9wWZB+CYfqHyKFEWQJb6y
	RV4mmVMVeWjF6cHB4NyANopZq+G70civikKoplAa++qeWXRb8D6uA7DrgrIKnHN9x/Cnvpohk+5
	/0TOKSMMau2T4obaL7JmLGsaXHQBw5O9U97cGEgD96IDnWKBZAPJaGx4az+RL6MWXcHQtg/TCOF
	w2ZGfUYhWxN5eCT63xwhJuVO0YRFSU8kd8uSqXb2HzIlW0g+1ovnyXNkKdk0L5fhl+LortSK7IW
	Csl4xkz8b2cT3H1Sd+v/Q6G7+qOLCiWTi1tlZv+8TyuBxjtbGDOYbK6H62rfy6y0GhSZ1vqTCk/
	aCN3I0ScaQxNVE9ZtY/QzThTVP0Mj8izRcKgpMJxW2+gwq2TJmXaixep/nUVck8oLu6BsoiT5Zt
	Dnghu3jjdxRvMvo3hnKOpoCVy0oyAAdhA6edTMiiXT3kY7zgTjdoMazwLxE2+nwBt6tzO/8BZ9V
	eGXRE1p3mmrlcZZyTitnFTobKU2Xook9ZVPo+qeG/apgjy6lJAc3bgPVaKW0DKOdPKsRgyiZUId
	F1lX3UW1eGs9IUnVxPkVPTIrTVBT0wVY96a2q97j9xpIqpPvD22+eJIKb9GK1dG8h0wogZA52ih
	oHiiI2N3Mqg/XzkbUfPzVkwvYKnYmD3Cx8PQeA6gmsy0hFmcg20UBWJ3cQfAj6/DuqWwq1u6NiQ
	==
X-Received: by 2002:a17:90b:5687:b0:3a8:337d:228a with SMTP id 98e67ed59e1d1-3b1b087c04bmr6877418a91.6.1794842797171;
        Mon, 16 Nov 2026 07:26:37 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec66f4csm17698564a91.14.2026.11.16.07.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:26:36 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 01/21] bpf: Stop a load only when the loader is killed or has to freeze
Date: Mon, 16 Nov 2026 15:26:06 +0000
Message-ID: <20261116152626.4032587-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
References: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Any pending signal stops the verifier with -EAGAIN. A loader with a
profiling timer never loads a program that takes longer than one period:

  timer:  |--10ms--|--10ms--|--10ms--|
  load:   |--------X EAGAIN
                   |--------X EAGAIN   ... libbpf gives up after 5 tries

Use one helper for all long loops. Add it to the loops that had no
check: cfg, const_fold, stack liveness and CO-RE relocations.

  event                     load
  fatal signal              stops
  system or cgroup freezer  stops, the task freezes, bpf() starts again
  other signals             goes on

The restart is not visible in user space. A loader program gets -EINTR
from bpf_sys_bpf(), it got -EAGAIN. Unprivileged loaders wait for one
lock: test the same condition when they get it, so the queue drains.

SIGSTOP, ptrace and signals with a handler wait for the end of the load.
A tool that stops and continues a task all the time is one more timer.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 16 ++++++++++++++++
 kernel/bpf/cfg.c             |  2 +-
 kernel/bpf/check_btf.c       |  4 ++--
 kernel/bpf/const_fold.c      |  4 ++++
 kernel/bpf/fixups.c          | 20 +++-----------------
 kernel/bpf/flow.c            | 29 +++++++++++------------------
 kernel/bpf/liveness.c        | 20 ++++++++++++--------
 kernel/bpf/loops.c           | 22 ++++------------------
 kernel/bpf/scev.c            | 10 ++++------
 kernel/bpf/syscall.c         |  9 ++++++++-
 kernel/bpf/verifier.c        | 14 +++++++-------
 11 files changed, 72 insertions(+), 78 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1afee19fcd25..ecb988ab6349 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -10,6 +10,22 @@
 #include <linux/tnum.h>
 #include <linux/cnum.h>
 #include <linux/math64.h> /* for div_s64_rem() */
+#include <linux/freezer.h>
+#include <linux/sched/signal.h>
+
+/*
+ * For each loop that can run long. The caller returns -EINTR.
+ *   killed          the task dies
+ *   freezer waits   the task freezes, then bpf() starts again
+ *   other signals   wait for the end of the load
+ */
+static inline bool bpf_must_abort(void)
+{
+	cond_resched();
+	return task_sigpending(current) &&
+	       (__fatal_signal_pending(current) || freezing(current) ||
+		(READ_ONCE(current->jobctl) & JOBCTL_TRAP_FREEZE));
+}
 
 /*
  * Mathematical modulo, the residue of 'v' modulo 'step', normalized to [0, step).
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index bbcf42eae9d9..163fdb21828f 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -686,7 +686,7 @@ int bpf_check_cfg(struct bpf_verifier_env *env)
 	while (env->cfg.cur_stack > 0) {
 		int t = insn_stack[env->cfg.cur_stack - 1];
 
-		ret = visit_insn(t, env);
+		ret = bpf_must_abort() ? -EINTR : visit_insn(t, env);
 		switch (ret) {
 		case DONE_EXPLORING:
 			insn_state[t] = EXPLORED;
diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
index 8a3f2421331e..d6b930377d75 100644
--- a/kernel/bpf/check_btf.c
+++ b/kernel/bpf/check_btf.c
@@ -402,8 +402,8 @@ int bpf_check_core_relo(struct bpf_verifier_env *env,
 			break;
 		}
 
-		err = bpf_core_apply(&ctx, &core_relo, i,
-				     &prog->insnsi[core_relo.insn_off / 8]);
+		err = bpf_must_abort() ? -EINTR :
+		      bpf_core_apply(&ctx, &core_relo, i, &prog->insnsi[core_relo.insn_off / 8]);
 		if (err)
 			break;
 		bpfptr_add(&u_core_relo, rec_size);
diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
index 3c8c1b64088b..5869730547ae 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -278,6 +278,10 @@ int bpf_compute_const_regs(struct bpf_verifier_env *env)
 	}
 
 redo:
+	if (bpf_must_abort()) {
+		kvfree(ci_in);
+		return -EINTR;
+	}
 	changed = false;
 	for (i = env->cfg.cur_postorder - 1; i >= 0; i--) {
 		int idx = env->cfg.insn_postorder[i];
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 1d33a78d9373..735932392a87 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -6,7 +6,6 @@
 #include <linux/filter.h>
 #include <linux/vmalloc.h>
 #include <linux/perf_event.h>
-#include <linux/sched/signal.h>
 #include <net/xdp.h>
 #include "disasm.h"
 
@@ -165,19 +164,6 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
 }
 #endif
 
-/*
- * A post-verification rewriting pass can queue a patch for each instruction
- * of a large program. Keep the primitives that queue them killable and
- * preemptible.
- */
-static bool bpf_rewrite_must_abort(void)
-{
-	if (fatal_signal_pending(current))
-		return true;
-	cond_resched();
-	return false;
-}
-
 /*
  * Queue the replacement of insn 'off' by 'patch[0..len)' until
  * bpf_patch_list_commit(), see __bpf_patch_list_add(). Replacing one insn by
@@ -190,7 +176,7 @@ struct bpf_insn *bpf_patch_list_add(struct bpf_verifier_env *env, u32 off,
 	struct bpf_patch_list *pl = &env->patch_list;
 	struct bpf_insn_patch *p = pl->cnt ? &pl->patches[pl->cnt - 1] : NULL;
 
-	if (bpf_rewrite_must_abort())
+	if (bpf_must_abort())
 		return ERR_PTR(-EINTR);
 
 	if (verifier_bug_if(!len || off >= env->prog->len ||
@@ -221,7 +207,7 @@ int bpf_patch_list_del(struct bpf_verifier_env *env, u32 off)
 {
 	struct bpf_patch_list *pl = &env->patch_list;
 
-	if (bpf_rewrite_must_abort())
+	if (bpf_must_abort())
 		return -EINTR;
 
 	if (verifier_bug_if(off >= env->prog->len ||
@@ -240,7 +226,7 @@ int bpf_patch_list_insert(struct bpf_verifier_env *env, u32 off,
 	struct bpf_insn_patch *p = pl->cnt ? &pl->patches[pl->cnt - 1] : NULL;
 	int err;
 
-	if (bpf_rewrite_must_abort())
+	if (bpf_must_abort())
 		return -EINTR;
 
 	if (verifier_bug_if(!cnt || off >= env->prog->len ||
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index 5341f95c5072..fbd1178eb9f5 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -504,11 +504,10 @@ int bpf_flow_place_guards(struct bpf_verifier_env *env)
 		if (!loop)
 			continue;
 		/* a deep nest of loops takes long */
-		if (signal_pending(current)) {
-			ret = -EAGAIN;
+		if (bpf_must_abort()) {
+			ret = -EINTR;
 			break;
 		}
-		cond_resched();
 		loop->rt_bounded = flow_loop_is_bounded(env, h);
 		/* also when it's bounded: the main pass may find that it's not */
 		flow_place_guards(env, h, seen);
@@ -884,11 +883,10 @@ int bpf_flow_compute_kinds(struct bpf_verifier_env *env)
 	for (n = 0; lost; n++) {
 		lost = false;
 		/* a chain of calls takes a round for each link */
-		if (signal_pending(current)) {
-			err = -EAGAIN;
+		if (bpf_must_abort()) {
+			err = -EINTR;
 			break;
 		}
-		cond_resched();
 		for (j = 0; j < cnt; j++) {
 			/* it has callees first */
 			s = env->subprog_topo_order[n & 1 ? j : cnt - 1 - j];
@@ -1068,11 +1066,10 @@ static int flow_compute_need_const(struct bpf_verifier_env *env, struct flow_nee
 again:
 	while (any && changed) {
 		changed = false;
-		if (signal_pending(current)) {
-			err = -EAGAIN;
+		if (bpf_must_abort()) {
+			err = -EINTR;
 			break;
 		}
-		cond_resched();
 		for (s = 0; callx && s < env->subprog_cnt; s++)
 			if (env->subprog_info[s].addr_taken)
 				callx_regs |= need[env->subprog_info[s].start].regs;
@@ -1619,11 +1616,10 @@ static int flow_compute_rungs(struct bpf_verifier_env *env)
 			depth++;
 		if (depth >= LOOP_STACK_SIZE)
 			continue;
-		if (signal_pending(current)) {
-			err = -EAGAIN;
+		if (bpf_must_abort()) {
+			err = -EINTR;
 			break;
 		}
-		cond_resched();
 		err = flow_compute_loop_rungs(env, at, total, h);
 	}
 	kvfree(at);
@@ -2737,12 +2733,10 @@ static int flow_merge(struct bpf_verifier_env *env, struct flow_set *set,
 	int prev = s->prev_insn_idx;
 
 again:
-	if (signal_pending(current)) {
-		err = -EAGAIN;
+	if (bpf_must_abort()) {
+		err = -EINTR;
 		goto err_free;
 	}
-	if (need_resched())
-		cond_resched();
 
 	/* again after a join: an offset may not be a constant any more, a pointer may be gone */
 	flow_shape_ctx(&s->st, &s->shape);
@@ -3397,7 +3391,7 @@ void bpf_flow_print_way(struct bpf_verifier_env *env, u64 log_pos, int head, int
 	if (!cnt || bpf_vlog_stash(&env->log, log_pos, &stash))
 		goto out;
 	env->prev_linfo = NULL;
-	while (cnt-- && !signal_pending(current)) {
+	while (cnt-- && !bpf_must_abort()) {
 		w = &way[cnt];
 		if (w->s) {
 			verbose(env, "from %d to %d:", w->s->prev_insn_idx, w->head);
@@ -3409,7 +3403,6 @@ void bpf_flow_print_way(struct bpf_verifier_env *env, u64 log_pos, int head, int
 			bpf_verbose_insn(env, &insns[i]);
 			verbose(env, "\n");
 		}
-		cond_resched();
 	}
 	bpf_vlog_unstash(&env->log, &stash);
 out:
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 06f739610c73..2c771b936d65 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -456,7 +456,7 @@ static inline bool update_insn(struct bpf_verifier_env *env, struct func_instanc
 }
 
 /* Fixed-point computation of @live_before marks */
-static void update_instance(struct bpf_verifier_env *env, struct func_instance *instance)
+static int update_instance(struct bpf_verifier_env *env, struct func_instance *instance)
 {
 	u32 i, frame, po_start, po_end;
 	int *insn_postorder = env->cfg.insn_postorder;
@@ -469,6 +469,8 @@ static void update_instance(struct bpf_verifier_env *env, struct func_instance *
 	po_end = (subprog + 1)->postorder_start;
 	/* repeat until fixed point is reached */
 	do {
+		if (bpf_must_abort())
+			return -EINTR;
 		changed = false;
 		for (frame = 0; frame <= instance->depth; frame++) {
 			if (!instance->frames[frame])
@@ -482,6 +484,7 @@ static void update_instance(struct bpf_verifier_env *env, struct func_instance *
 			}
 		}
 	} while (changed);
+	return 0;
 }
 
 static bool is_live_before(struct func_instance *instance, u32 insn_idx, u32 frameno, u32 half_spi,
@@ -2130,6 +2133,9 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 		struct bpf_iarray *succ;
 		int ti;
 
+		err = -EINTR;
+		if (bpf_must_abort())
+			goto err_free;
 		if (!arg_is_visited(&at_in[i][0]) && !arg_is_visited(&at_in[i][1]))
 			continue;
 
@@ -2365,8 +2371,8 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 		return -E2BIG;
 	}
 
-	if (need_resched())
-		cond_resched();
+	if (bpf_must_abort())
+		return -EINTR;
 
 	/*
 	 * When an instance is reused (must_write_initialized == true),
@@ -2524,8 +2530,7 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 		if (err)
 			return err;
 	}
-	update_instance(env, instance);
-	return 0;
+	return update_instance(env, instance);
 
 out_free:
 	if (prev_instance)
@@ -2872,11 +2877,10 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 
 		changed = false;
 		/* a cycle of calls takes a round for each link */
-		if (signal_pending(current)) {
-			err = -EAGAIN;
+		if (bpf_must_abort()) {
+			err = -EINTR;
 			goto out;
 		}
-		cond_resched();
 		for (i = 0; i < env->cfg.cur_postorder; ++i) {
 			int insn_idx = env->cfg.insn_postorder[i];
 			struct insn_live_regs *live = &state[insn_idx];
diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
index 7de1574af386..9946146847d7 100644
--- a/kernel/bpf/loops.c
+++ b/kernel/bpf/loops.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
 
 #include <linux/slab.h>
-#include <linux/sched/signal.h>
 #include <linux/bpf_verifier.h>
 
 static bool is_cfg_jump(struct bpf_insn *insn)
@@ -107,7 +106,6 @@ static int compute_subprog_idoms(struct bpf_verifier_env *env, struct bpf_iarray
 	int po_last = (subprog + 1)->postorder_start - 1;
 	int *idoms = env->idoms;
 	int po_num, pred;
-	u32 work = 0;
 	bool changed;
 
 	idoms[start] = start;
@@ -123,11 +121,8 @@ static int compute_subprog_idoms(struct bpf_verifier_env *env, struct bpf_iarray
 			int new_idom = -1;
 
 			iarray_for_each(pred, preds[idx]) {
-				if (++work % 1024 == 0) {
-					if (signal_pending(current))
-						return -EAGAIN;
-					cond_resched();
-				}
+				if (bpf_must_abort())
+					return -EINTR;
 
 				if (idoms[pred] == -1)
 					continue;
@@ -416,24 +411,15 @@ static int compute_loops_in_subprog(struct bpf_verifier_env *env, struct loops_d
 	int *stack = dfs->stack;
 	int s, h, err, cur, stack_sz;
 	struct bpf_iarray *succ;
-	u32 i;
 
 	stack[0] = start;
 	state[start].traversed = true;
 	state[start].next_succ = 0;
 	dfs_pos[start] = 1;
 	stack_sz = 1;
-	i = 0;
 	do {
-		/*
-		 * The algorithm should be very fast in practice,
-		 * guard against pathological inputs, just in case.
-		 */
-		if ((++i % 1024) == 0) {
-			if (signal_pending(current))
-				return -EAGAIN;
-			cond_resched();
-		}
+		if (bpf_must_abort())
+			return -EINTR;
 
 		cur = stack[stack_sz - 1];
 		succ = bpf_insn_successors(env, cur);
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 5648beca3931..616e22c038ed 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2664,11 +2664,10 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header, i
 		idx = *min_heap_peek_inline(worklist);
 		min_heap_pop_inline(worklist, &worklist_cb, env->cfg.postorder_nums);
 		start = idx;
-		if (signal_pending(current)) {
-			err = -EAGAIN;
+		if (bpf_must_abort()) {
+			err = -EINTR;
 			goto out;
 		}
-		cond_resched();
 
 		/* join_successor() maps nested-loop entries to their representative header. */
 		nested_loop = idx != cur_header ? aux[idx].loop : NULL;
@@ -3265,9 +3264,8 @@ int bpf_compute_scev(struct bpf_verifier_env *env)
 		idx = postorder[i];
 		if (!aux[idx].need_scev)
 			continue;
-		if (signal_pending(current))
-			return -EAGAIN;
-		cond_resched();
+		if (bpf_must_abort())
+			return -EINTR;
 		header = bpf_loop_at_index(env, idx);
 		err = aux[idx].loop
 		      ? compute_header_scevs(env, header)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 04a3b3c80c74..70caab9648d6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6604,7 +6604,14 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 SYSCALL_DEFINE5(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, size,
 		struct bpf_common_attr __user *, uattr_common, unsigned int, size_common)
 {
-	return __sys_bpf(cmd, USER_BPFPTR(uattr), size, USER_BPFPTR(uattr_common), size_common);
+	int err = __sys_bpf(cmd, USER_BPFPTR(uattr), size, USER_BPFPTR(uattr_common), size_common);
+
+	cmd &= ~BPF_COMMON_ATTRS;
+	/* bpf_must_abort() ended the command, nothing of it is left */
+	if (err == -EINTR && task_sigpending(current) &&
+	    (cmd == BPF_PROG_LOAD || cmd == BPF_BTF_LOAD || cmd == BPF_MAP_CREATE))
+		return -ERESTARTNOINTR;
+	return err;
 }
 
 static bool syscall_prog_is_valid_access(int off, int size,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e4fcd1c9242d..03f8b2f33596 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21790,11 +21790,8 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 		struct bpf_insn_aux_data *insn_aux;
 		int err;
 
-		if (signal_pending(current))
-			return -EAGAIN;
-
-		if (need_resched())
-			cond_resched();
+		if (bpf_must_abort())
+			return -EINTR;
 
 		/* no insn makes as many ids as there are from here to BPF_INHERITED_ID */
 		if (env->id_gen >= BPF_MAX_ID) {
@@ -22988,8 +22985,8 @@ static int resolve_func_ptrs(struct bpf_verifier_env *env)
 			continue;
 
 		for (off = 0; off + sizeof(u64) <= map->value_size; off += sizeof(u64)) {
-			if (!(off % SZ_64K))
-				cond_resched();
+			if (bpf_must_abort())
+				return -EINTR;
 			val = *(u64 *)(unsigned long)(addr + off);
 			if (!val || val % sizeof(struct bpf_insn) ||
 			    val / sizeof(struct bpf_insn) >= insn_cnt)
@@ -25306,6 +25303,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	/* Serialize verification of unprivileged programs. */
 	if (!is_priv)
 		mutex_lock(&bpf_verifier_lock);
+	ret = -EINTR;
+	if (bpf_must_abort())
+		goto skip_full_check;
 
 	len = env->insn_aux_data_len = env->prog->len;
 	env->insn_aux_data =
-- 
2.55.0

