Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808609;
	b=QAmHTjS0+DMvh3td7DEhkXQ9WvlStN8oFufudR15RX5RaVyaooqJqPssO8Qew9Y3DKGm
	 Ybb3P7ROk/MNQgfp2x5C6s7XXyLVZLpf/6HGbQlClrfPv5djhFUpKrb+9Q9Bcg9W6jyBM
	 OPNT6D/JPd3ru9+JMyIXRkZzlYMwnocTNvKtpmCe1eYhxtzk45oIkEOouRygT4653ckd6
	 3JGVVbLw9eX84JDrG5tKhXCyi7Y6txatDC5Al8xWWCr0UmchN1Boh/hzT4ig33LEY8oY9
	 NPk+VvicqdA7xN7h1UqLNU6AbJuwnEqu5aFlcTXEG1uyjFjuhNihASPNiH+/qXH79wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=p7L7brxqBIWWEEVKCkfQ9JfxfHM6CBrm6om14Ku7yRE=;
	b=nMDaEMXB4M8LfZRyPkZ0aH66zAtLCcUDEC+pQeCAhd7jBCXRliJlXwo3aCEk2XqhmNZ9
	 XdUKZaWyWoQBowOB+q/bcohNu6fSK1r33XRpLBBz//nJukDgepTG0yGKfgN1mMlk4nOch
	 1BOxfwjBpeu7pUDP+CX0t6yuZkuVe/899FdcnQRBkuHrgXevh64ExznVhLQ6NPblAOtDU
	 4BGOh00yd5U5wLD0snGH3/rAGt4coOCNMDVY7aIlKzCHgrAHomNaMpgKqo5iIXK6EvKMm
	 FvDWdTSS9KtaVxYB4CLnNLeodpwAwVpuXj4X2j+chuUZRAI972X7kfTWTQyhsOUf47A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QRzBv9wW;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA7A606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 05:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFA7A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QRzBv9wW
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso1472368a91.0
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 21:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794808608; x=1795413408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p7L7brxqBIWWEEVKCkfQ9JfxfHM6CBrm6om14Ku7yRE=;
        b=QRzBv9wWYxmgv5EHe5e2zig0KaMz93uDnaLd6AhQpg/4lr2jWajudfX/MKs3+G8gR/
         SHqGLn3lRwqMDTj8DxLDYdHf8eeQt3eEvlHjU21srkVzS4gvkuRhWALla/B0iacgDaOo
         cNK7amfIJuWTngsOMrM0MJF8ATNMZT9tks2El5PnMvfwv51cuXmm2RaEW2wRVOkL0itF
         0OesCo2H5RyIePzTFM04OhGv82MD+dvkrNx5RBA+wNXQhBJzqVX6c0mLfzZThI7N5q+u
         e4oueSVoBJFHVm55AaBZR8AQY8hsY4Oe4i1LMOD9Cp/Vwvq13U0pdjz+s9LJkjcMYTVs
         IMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794808608; x=1795413408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p7L7brxqBIWWEEVKCkfQ9JfxfHM6CBrm6om14Ku7yRE=;
        b=QaQ3ubS5Dwpq0s/XLFnKstSA/HYV38lNlafeygW2k9UK0Zn85fQxFzBMUu0tdnmZgt
         X9m8sXbEa5r/QoSrQMveJGlAYHAVL9rrHXnafugbbN1qRSYM3bPCTmUmvYPViZjl427W
         g2kI9ayF2XFUoMZ5Trovmpvm4t2dNWjPFU+7soLt8adb7zB0DaiP/qRtJChYM6e44m2w
         uJO+NjTcW1+Xz0+L1HSl2OPE1vO2F2MRb2nTW7/ohA9dCan8ZTEsnk/4MVGSKv4Y4V51
         H7xVioW+6VzeX0Bv5FngyTnMT5RyQ5dQ6tDBWFW6VqDVCixAUPy7GF2Ph9iHXmc0etCX
         pxlg==
X-Gm-Message-State: APuU4Z+albAJYPwE3Hyj8FjVFHXnpCvn2mpCsxr/+rgcZiYxoA6rsuc9
	3vyNJkIOt0ENdcmeBjONThm+f/ZaVXpFlfXpMZe+tHIM+CwG7tZyjdj0sP2lfg==
X-Gm-Gg: AYBFou1fP4Wgs1taQqrqjzH2Cd6Squymvj/V7PE3gm8NF1W6G2zzrhI2LiZ3jIxj8+r
	Sn0jMPIHK8dQXC3pIK60xfXtb3EpG2lQ8OJCF93Ug+Zlqsr4MjEm/DHL+dva5oCJK2nAx8q/ScP
	aotZpuRR1rFkBdBrf6vzv5B9BxUk6d+IYSSSe7uFFKQguK9aIIBjXZ3GzQ5IbqqYzKf4v8wKl7P
	nu13cuEhHM4SafFNmd/YM3i9f1UjxOKvAU0hDkJBbHZv//UKYTgp7VlN8kv0ohIwvg+WwfKjwhK
	ONQhQ4ne2YyUhJ5MVNMpqwz58lxH/AoMyUXrCaOy9K99Ey/DZVAubqrlggkQ5VNlw2ApjHFhxBr
	N7PSUo0qtvE+vYXrQy4wi/WS5OLDjOTXuv1O+hlTJCx9nneQTSZLIaCj8fCgNz+B1Z8oahpWK29
	gBNm0lBKRvF6+pB0PeFwnxxqXM1XUqwvSCcgtQ8YpI5UgGReY13cv5b8G12UiA08pkNh3K66iJO
	nkyxv4Fj63SJiMUXUJ/YxJA7vVO9pc5qhxxghZkB/9TorOWnFM/amYQv/J7FhOebnRgByPBx6Bp
	zIpP7GhpQJL2ba06C54r3GY8UBy0YY6znJoBsdXZiPrjVZq+cABqnXYONZfNsDAYXcA2hekClK1
	yWqflbV7S1JCyagTpxiACcuC4LiFZatYtNBQLEcHvQgP/ZDmGIWrOG8r9n83vsgZjKnb0ic7VTH
	G86kMNBzD+T/jBMAigczU=
X-Received: by 2002:a17:90b:2d44:b0:3ab:330d:6e47 with SMTP id 98e67ed59e1d1-3b1b0b5c014mr6632572a91.10.1794808607687;
        Sun, 15 Nov 2026 21:56:47 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aeb18b73sm14779879a91.3.2026.11.15.21.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 21:56:47 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 01/21] bpf: Stop a load only when the loader is killed or has to freeze
Date: Mon, 16 Nov 2026 05:56:18 +0000
Message-ID: <20261116055638.4171529-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
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
 kernel/bpf/syscall.c         |  8 +++++++-
 kernel/bpf/verifier.c        | 14 +++++++-------
 11 files changed, 71 insertions(+), 78 deletions(-)

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
index 04a3b3c80c74..9c55f5ed8ced 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6604,7 +6604,13 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 SYSCALL_DEFINE5(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, size,
 		struct bpf_common_attr __user *, uattr_common, unsigned int, size_common)
 {
-	return __sys_bpf(cmd, USER_BPFPTR(uattr), size, USER_BPFPTR(uattr_common), size_common);
+	int err = __sys_bpf(cmd, USER_BPFPTR(uattr), size, USER_BPFPTR(uattr_common), size_common);
+
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

