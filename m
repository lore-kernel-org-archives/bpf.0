Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DFD592200
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202973; cv=none; b=dIO2RNwXr8sQjaNfMu5gSAFXkuuW0UfVt4Mw4dyzdy8D7KLMc+ApMVyCl2h0GvXvJvQSpKa1/DOlJ8wzNRevgw2s87W4NIwCD3tTQkhhkQSeWRL1nmTEOqUjJjLqRGnpAajiJREaGgC1M6wzfCb/ooTt7sYrbV55V+096lqlUok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202973; c=relaxed/simple;
	bh=aPUOf7T53Y0F8qc4bRzabQvHWbPFyZlvSLABU0wEoTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZS70Vd6Ih/icB0uNKncB+XcwIugGfcngAIpTyk/Q+vBsZ03wFqJesi4cJUfUdsSmxq1HvdMuVufvRLmx4jrZR49PNw6NWXxg/YDAHmXb5Czb8wiImIU39km9q/KqlytaFaesVEDTf648r8agIHmxDKxPtMEfyS2hMjQGJhwbcv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMHDhLw3; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMHDhLw3"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd4f99cso1173509a91.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 15:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202967; x=1790807767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZDhw08NpXM8aY2CMicwa+mE8h9yiUUYUtRoZHq0c2eM=;
        b=eMHDhLw3NT/VbMubTCVRKjDONzWo8OZ3YJgaLgXxbMBWA6TxtOuXpKbqTxXCrRJkmv
         r3Tbb+vehEC2WFEOA+NLItzv21NKijkSQrJR1yAKp7V1lFHnR6EInJK5XKbk+A61x+zB
         uS0aLT6cJMCIojHrMU5sjGpy4HkmMOU4TMcXrUOgltGU3jjAh+hla3k3satkSFd+6uk6
         g7OGwOpurzfpEEkTkOdNHD1Ov9RcPvavc0p1QkzkW/UgttQ2mAcynYUHxWtA44+M9YE9
         K7Ku5WLnMhmYSST7seEe+ZrUp8TQQCfv32Odgr6xvxKWk4JCgoyi8QB5dTUXkCb6nw9t
         D8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202967; x=1790807767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZDhw08NpXM8aY2CMicwa+mE8h9yiUUYUtRoZHq0c2eM=;
        b=jL9Fv1mUkLGXyy/fu++3AZdQULVZznPr9XcNrV+IYe8ZyiEz5Ijg7Kt7wdWxdC3Lbc
         RKL+iaj4qu/CvWFNqRjyvh4unGwj4Qi9IqJbJ1Qth608Kilr8C5rVf0ApHWTJDB0GXgy
         DZ+MuXjn5wMLO7PNcW4hOTB92onrVTgqzOlJFhaBguq0A9HdXoK5ESh/fNHQ+xOh4Fme
         JarZ5SQpYosV9d/cFYmfyyCF1d3x1K2TSZdL6Oe/ty8gBOKU1ppRt5YYVMSh83AwwJaf
         DCuyR4yMYXcN7cbstRLMrRRhVG7mjUZfD1LrLhK9vUt8+uno91+N/0UZxcmvjnFei9ee
         9KeA==
X-Gm-Message-State: AFuF++lKxNuLVnia9ul4q5kYuidg+mQccgOLKOfCmtsjq5kD2LqyrsXJ
	wwQnZpFZa3IpFKTrAdqNaycScXEkzrnheJcGYXy+uFT6eYosvzYmqhzYX+pTPg==
X-Gm-Gg: AYBFou2kEL0a5rl6Z4seHXdWjTFUvTORiAfxFoAMUtlftzwrcK7XWmH35i2zVf5fRN+
	FHNGkpl0tcn2pbjSIe2WOWIGKNBPkwcfLdbLPuJJXiTB4npML2jJrR+42dh7yBMqhRIPPJY5J18
	YGux44soZh7f//tn6R2jcvKzUvksjJoZJmlq1jSb0F51jDvRTXlKYrroL8nfPjA+Jq7ACOh3gdE
	io7K8UAMZOoT1g7SmvEmAJywmJb/X16x0O4CxVJlSAAe8tgvK+ozUbxXVrvkKOH2LNwPiz4OPkj
	FhNe1vCzo9PIi0FhaZLYadZUT6UVUkPWMdM2K2ssJpiOuW16EbGSFIo1805V8TFoAo1ryjOMrJb
	YbnXuqt3eG4JM20jrNIppriiiHBtdkWdrpGlaJXowcQix53qz1ebbmFQpdfsRmBcw6XvqMBzKOg
	axa54XY6hHhyISq9C90Bgp9bJ2YIyRghO01VCDFGdslXE7VXQIhcdzZnjjn7DPcHiW1mz4v6whw
	JbLnntfQO8YwQP933NpUNTG68xK408Zz1CAN/jxjGi3ThaYHXE63/CAoArfaSjV6pm4j9HFMqQy
	Hab3okXgycyYLKHANYznARjzYlYNrj/NlEacinMj6cE=
X-Received: by 2002:a17:90b:3c0e:b0:39e:4c81:6c95 with SMTP id 98e67ed59e1d1-3a098dbb040mr462076a91.27.1790202966701;
        Wed, 23 Sep 2026 15:36:06 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972f2cddsm1138024a91.1.2026.09.23.15.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:36:06 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 3/8] bpf: Widen scalars at loop heads
Date: Wed, 23 Sep 2026 22:35:49 +0000
Message-ID: <20260923223554.562379-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923223554.562379-1-alexei.starovoitov@gmail.com>
References: <20260923223554.562379-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The verifier walks a bounded loop one iteration at a time. The work is
proportional to the number of iterations and the loop with 250k of them
is rejected with "BPF program is too large".

Let the state that comes back to the loop head stand for all iterations
the way it is done for open coded iterators. In is_state_visited():
 - if the state is within the state that went around the loop nothing
   new can happen on the next trip. Record SCC backedge and stop.
 - otherwise widen scalars in registers and spilled registers and go
   around the loop again.

widen_reg() takes the range that covers both states. The end that moved
is moved further to the nearest constant (imm - 1, imm, imm + 1) the
register is compared with inside the loop. Low bits of var_off that
are the same in both states are kept. In the loop:

   9: (b7) r6 = 0
  10: (bf) r1 = r7
  11: (0f) r1 += r6
  12: (61) r0 = *(u32 *)(r1 +0)
  13: (07) r6 += 4
  14: (55) if r6 != 0xf4240 goto pc-5

the second trip starts with
  R6=scalar(smin=0,smax=umax=0xf423c,var_off=(0x0; 0xffffc))
and the state that comes back is within it.

The first 4 trips use constants of the loop, the next 2 use S32_MIN, 0,
S32_MAX, U32_MAX, then the bound is dropped. Pointers and stack slots
other than spilled scalars are not widened. If that is what differs
the walk is given up after 10 trips.

The state that repeats exactly is treated as converged too instead of
"infinite loop detected". The loop that is not walked to the end is not
known to terminate. The next patches reject such loop when nothing
leaves it and add may_goto to it otherwise.

Nothing sets env->widen_loops yet.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  11 ++
 kernel/bpf/states.c          |  75 ++++++++-
 kernel/bpf/verifier.c        | 291 ++++++++++++++++++++++++++++++++++-
 3 files changed, 374 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5a08f079a489..981902cd5b71 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -527,6 +527,8 @@ struct bpf_verifier_state {
 	u32 dfs_depth;
 	u32 callback_unroll_depth;
 	u32 may_goto_depth;
+	/* number of times the loop head this state is a checkpoint of was widened */
+	u32 loop_passes;
 };
 
 static inline struct bpf_reg_state *
@@ -1049,6 +1051,12 @@ struct bpf_verifier_env {
 	/* array of pointers to bpf_scc_info indexed by SCC id */
 	struct bpf_scc_info **scc_info;
 	u32 scc_cnt;
+	/* per SCC constants that loop counters are compared with, see bpf_widen_loop_head() */
+	struct bpf_widen_thrs **scc_thrs;
+	/* states that come back to a loop head are widened instead of walking every iteration */
+	bool widen_loops;
+	/* the walk did or tried that, so a failure can be due to the lost precision */
+	bool widen_used;
 	struct bpf_iarray *succ;
 	struct bpf_iarray *gotox_tmp_buf;
 };
@@ -1221,6 +1229,9 @@ void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
 int mark_chain_precision(struct bpf_verifier_env *env, int regno);
 
 int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx);
+bool bpf_same_loop(struct bpf_verifier_state *old, struct bpf_verifier_state *cur);
+int bpf_widen_loop_head(struct bpf_verifier_env *env, int insn_idx, bool backedge,
+			struct bpf_verifier_state *old, struct bpf_verifier_state *cur);
 int bpf_update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 
 void bpf_clear_jmp_history(struct bpf_verifier_state *state);
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 66fb11b6c6a7..22987ce070e7 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -1108,6 +1108,41 @@ static int propagate_backedges(struct bpf_verifier_env *env, struct bpf_scc_visi
 	return 0;
 }
 
+/* Did the walk get to @insn_idx over a back-edge? */
+static bool is_backedge(struct bpf_verifier_env *env, int insn_idx)
+{
+	int prev = env->prev_insn_idx;
+	struct bpf_insn_aux_data *aux;
+	struct bpf_insn *insn;
+
+	if (prev < 0 || prev >= env->prog->len)
+		return false;
+	aux = &env->insn_aux_data[prev];
+	insn = &env->prog->insnsi[prev];
+	/* check_cfg() does not record the edge of an unconditional jump as a jump */
+	if ((BPF_CLASS(insn->code) == BPF_JMP || BPF_CLASS(insn->code) == BPF_JMP32) &&
+	    BPF_OP(insn->code) == BPF_JA)
+		return aux->backedge_ft || aux->backedge_br;
+	return insn_idx == prev + 1 ? aux->backedge_ft : aux->backedge_br;
+}
+
+/* The state of this walk that was the last to get to loop head @insn_idx. */
+static struct bpf_verifier_state *loop_head_state(struct bpf_verifier_env *env, int insn_idx)
+{
+	struct bpf_verifier_state *cur = env->cur_state;
+	struct bpf_verifier_state_list *sl;
+	struct list_head *pos;
+
+	/* states are most recent first */
+	list_for_each(pos, bpf_explored_state(env, insn_idx)) {
+		sl = container_of(pos, struct bpf_verifier_state_list, node);
+		if (sl->state.insn_idx == insn_idx && sl->state.branches &&
+		    bpf_same_loop(&sl->state, cur))
+			return &sl->state;
+	}
+	return NULL;
+}
+
 static bool states_maybe_looping(struct bpf_verifier_state *old,
 				 struct bpf_verifier_state *cur)
 {
@@ -1237,12 +1272,17 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 {
 	struct bpf_verifier_state_list *new_sl;
 	struct bpf_verifier_state_list *sl;
-	struct bpf_verifier_state *cur = env->cur_state, *new;
+	struct bpf_verifier_state *cur = env->cur_state, *new, *widen_from = NULL;
+	bool loop_head = env->widen_loops && env->insn_aux_data[insn_idx].loop_head;
 	bool force_new_state, add_new_state, loop;
 	int n, err, states_cnt = 0;
 	struct list_head *pos, *tmp, *head;
 
+	if (loop_head)
+		widen_from = loop_head_state(env, insn_idx);
+
 	force_new_state = env->test_state_freq || bpf_is_force_checkpoint(env, insn_idx) ||
+			  loop_head ||
 			  /* Avoid accumulating infinitely long jmp history */
 			  cur->jmp_history_cnt > 40;
 
@@ -1364,12 +1404,32 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 				}
 				goto skip_inf_loop_check;
 			}
+			/*
+			 * The state came back to the loop head. If it is within
+			 * the state that went around the loop nothing new can
+			 * happen on the next trip. Otherwise it is widened below
+			 * and goes around instead of all the iterations it stands for.
+			 */
+			if (loop_head && bpf_same_loop(&sl->state, cur)) {
+				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
+					env->widen_used = true;
+					loop = true;
+					goto hit;
+				}
+				goto skip_inf_loop_check;
+			}
 			/* attempt to detect infinite loop to avoid unnecessary doomed work */
 			if (states_maybe_looping(&sl->state, cur) &&
 			    states_equal(env, &sl->state, cur, EXACT) &&
 			    !iter_active_depths_differ(&sl->state, cur) &&
 			    sl->state.may_goto_depth == cur->may_goto_depth &&
 			    sl->state.callback_unroll_depth == cur->callback_unroll_depth) {
+				/* the state repeats, nothing new on the next trip */
+				if (env->widen_loops) {
+					env->widen_used = true;
+					loop = true;
+					goto hit;
+				}
 				verbose_linfo(env, insn_idx, "; ");
 				verbose(env, "infinite loop detected at insn %d\n", insn_idx);
 				verbose(env, "cur state:");
@@ -1522,7 +1582,8 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 		 * Use bigger 'n' for checkpoints because evicting checkpoint states
 		 * too early would hinder iterator convergence.
 		 */
-		n = bpf_is_force_checkpoint(env, insn_idx) && sl->state.branches > 0 ? 64 : 3;
+		n = (bpf_is_force_checkpoint(env, insn_idx) || loop_head) &&
+		    sl->state.branches > 0 ? 64 : 3;
 		if (sl->miss_cnt > sl->hit_cnt * n + n) {
 			/* the state is unlikely to be useful. Remove it to
 			 * speed up verification
@@ -1539,6 +1600,16 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	if (env->max_states_per_insn < states_cnt)
 		env->max_states_per_insn = states_cnt;
 
+	if (loop_head) {
+		cur->loop_passes = 0;
+		if (widen_from) {
+			err = bpf_widen_loop_head(env, insn_idx, is_backedge(env, insn_idx),
+						  widen_from, cur);
+			if (err)
+				return err;
+		}
+	}
+
 	if (!env->bpf_capable && states_cnt > BPF_COMPLEXITY_LIMIT_STATES)
 		return 0;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cb5d498ada69..85b2691f81b1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1733,6 +1733,7 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
 	dst_state->dfs_depth = src->dfs_depth;
 	dst_state->callback_unroll_depth = src->callback_unroll_depth;
 	dst_state->may_goto_depth = src->may_goto_depth;
+	dst_state->loop_passes = src->loop_passes;
 	dst_state->equal_state = src->equal_state;
 	for (i = 0; i <= src->curframe; i++) {
 		dst = dst_state->frame[i];
@@ -8040,6 +8041,287 @@ static struct bpf_verifier_state *find_prev_entry(struct bpf_verifier_env *env,
 	return NULL;
 }
 
+/* A constant that register @regno is compared with, -1 if any register. */
+struct widen_thr {
+	s64 val;
+	int regno;
+};
+
+struct bpf_widen_thrs {
+	u32 cnt;
+	struct widen_thr thr[];
+};
+
+/* passes around a loop that widen to constants the loop compares with */
+#define WIDEN_THR_PASSES	4
+/* passes that widen to S32_MAX and the like, later ones drop the bound */
+#define WIDEN_GEN_PASSES	6
+/* states at the loop head differ in something that can't be widened */
+#define WIDEN_MAX_PASSES	10
+
+static const struct widen_thr widen_generic[] = {
+	{ S32_MIN, -1 }, { 0, -1 }, { S32_MAX, -1 }, { U32_MAX, -1 },
+};
+
+static int cmp_widen_thr(const void *a, const void *b)
+{
+	s64 x = ((const struct widen_thr *)a)->val;
+	s64 y = ((const struct widen_thr *)b)->val;
+
+	return x < y ? -1 : x > y;
+}
+
+static bool is_cmp_imm(const struct bpf_insn *insn)
+{
+	u8 class = BPF_CLASS(insn->code);
+	u8 op = BPF_OP(insn->code);
+
+	if (class != BPF_JMP && class != BPF_JMP32)
+		return false;
+	if (BPF_SRC(insn->code) != BPF_K)
+		return false;
+	return op != BPF_JA && op != BPF_CALL && op != BPF_EXIT && op != BPF_JCOND;
+}
+
+/*
+ * Sorted constants that registers are compared with in the SCC of @insn_idx.
+ * A range that ends at one of them can be cut back by the exit test of
+ * the loop, so that the state at the loop head stops growing.
+ */
+static const struct bpf_widen_thrs *scc_thresholds(struct bpf_verifier_env *env, int insn_idx)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_insn *insns = env->prog->insnsi;
+	u32 scc = aux[insn_idx].scc;
+	struct bpf_widen_thrs *thrs;
+	int i, d, n = 0;
+
+	if (!scc)
+		return NULL;
+	if (!env->scc_thrs) {
+		env->scc_thrs = kvzalloc_objs(*env->scc_thrs, env->scc_cnt, GFP_KERNEL_ACCOUNT);
+		if (!env->scc_thrs)
+			return NULL;
+	}
+	if (env->scc_thrs[scc])
+		return env->scc_thrs[scc];
+
+	for (i = 0; i < env->prog->len; i++)
+		if (aux[i].scc == scc && is_cmp_imm(&insns[i]))
+			n++;
+	thrs = kvzalloc(struct_size(thrs, thr, 3 * n), GFP_KERNEL_ACCOUNT);
+	if (!thrs)
+		return NULL;
+	for (i = 0; i < env->prog->len; i++) {
+		if (aux[i].scc != scc || !is_cmp_imm(&insns[i]))
+			continue;
+		for (d = -1; d <= 1; d++) {
+			thrs->thr[thrs->cnt].val = (s64)insns[i].imm + d;
+			thrs->thr[thrs->cnt++].regno = insns[i].dst_reg;
+		}
+	}
+	sort(thrs->thr, thrs->cnt, sizeof(thrs->thr[0]), cmp_widen_thr, NULL);
+	env->scc_thrs[scc] = thrs;
+	return thrs;
+}
+
+/*
+ * Nearest constant in sorted @thr that is >= @x if @up, <= @x otherwise.
+ * Constants that another register is compared with are skipped.
+ */
+static bool thr_nearest(const struct widen_thr *thr, u32 cnt, int regno, s64 x, bool up,
+			s64 *res)
+{
+	bool found = false;
+	u32 i;
+
+	for (i = 0; i < cnt; i++) {
+		if (regno >= 0 && thr[i].regno >= 0 && thr[i].regno != regno)
+			continue;
+		if (up && thr[i].val >= x) {
+			*res = thr[i].val;
+			return true;
+		}
+		if (!up && thr[i].val <= x) {
+			*res = thr[i].val;
+			found = true;
+		}
+	}
+	return found;
+}
+
+struct widen_ctx {
+	const struct bpf_widen_thrs *thrs;
+	u32 passes;
+	int regno;
+};
+
+/* Where to move the end @x of a range that keeps moving up or down. */
+static bool widen_pick(const struct widen_ctx *w, s64 x, bool up, s64 *res)
+{
+	bool found = false;
+	s64 t;
+
+	if (w->passes <= WIDEN_THR_PASSES && w->thrs &&
+	    thr_nearest(w->thrs->thr, w->thrs->cnt, w->regno, x, up, &t)) {
+		*res = t;
+		found = true;
+	}
+	if (w->passes <= WIDEN_GEN_PASSES &&
+	    thr_nearest(widen_generic, ARRAY_SIZE(widen_generic), -1, x, up, &t)) {
+		*res = !found ? t : up ? min(*res, t) : max(*res, t);
+		found = true;
+	}
+	return found;
+}
+
+static s64 widen_smax(const struct widen_ctx *w, s64 x, s64 lim)
+{
+	s64 t;
+
+	return widen_pick(w, x, true, &t) && t <= lim ? t : lim;
+}
+
+static s64 widen_smin(const struct widen_ctx *w, s64 x, s64 lim)
+{
+	s64 t;
+
+	return widen_pick(w, x, false, &t) && t >= lim ? t : lim;
+}
+
+static u64 widen_umax(const struct widen_ctx *w, u64 x, u64 lim)
+{
+	s64 t;
+
+	if (x > S64_MAX || !widen_pick(w, x, true, &t) || (u64)t > lim)
+		return lim;
+	return t;
+}
+
+static u64 widen_umin(const struct widen_ctx *w, u64 x)
+{
+	s64 t;
+
+	if (!widen_pick(w, min_t(u64, x, S64_MAX), false, &t) || t < 0)
+		return 0;
+	return t;
+}
+
+/*
+ * @old is the state of a register at the loop head, @cur is its state after
+ * a trip around the loop. If @cur has values that @old doesn't have make @cur
+ * a guess of all the values the register can have at the loop head: both
+ * @old and @cur, and where an end of the range moved it is moved further,
+ * to the nearest constant the loop compares the register with.
+ * Whether the guess is good is seen on the next trip: the state that comes
+ * back has to be within it.
+ */
+static void widen_reg(const struct widen_ctx *w, const struct bpf_reg_state *old,
+		      struct bpf_reg_state *cur)
+{
+	u64 umin, umax, low;
+	u32 u32_min, u32_max;
+	s32 s32_min, s32_max;
+	s64 smin, smax;
+	struct tnum t;
+
+	if (old->type != SCALAR_VALUE || cur->type != SCALAR_VALUE)
+		return;
+	if (cnum64_is_subset(old->r64, cur->r64) && cnum32_is_subset(old->r32, cur->r32) &&
+	    tnum_in(old->var_off, cur->var_off))
+		return;
+
+	umin = min(reg_umin(old), reg_umin(cur));
+	umax = max(reg_umax(old), reg_umax(cur));
+	smin = min(reg_smin(old), reg_smin(cur));
+	smax = max(reg_smax(old), reg_smax(cur));
+	u32_min = min(reg_u32_min(old), reg_u32_min(cur));
+	u32_max = max(reg_u32_max(old), reg_u32_max(cur));
+	s32_min = min(reg_s32_min(old), reg_s32_min(cur));
+	s32_max = max(reg_s32_max(old), reg_s32_max(cur));
+
+	if (reg_umin(cur) < reg_umin(old))
+		umin = widen_umin(w, umin);
+	if (reg_umax(cur) > reg_umax(old))
+		umax = widen_umax(w, umax, U64_MAX);
+	if (reg_smin(cur) < reg_smin(old))
+		smin = widen_smin(w, smin, S64_MIN);
+	if (reg_smax(cur) > reg_smax(old))
+		smax = widen_smax(w, smax, S64_MAX);
+	if (reg_u32_min(cur) < reg_u32_min(old))
+		u32_min = widen_umin(w, u32_min);
+	if (reg_u32_max(cur) > reg_u32_max(old))
+		u32_max = widen_umax(w, u32_max, U32_MAX);
+	if (reg_s32_min(cur) < reg_s32_min(old))
+		s32_min = widen_smin(w, s32_min, S32_MIN);
+	if (reg_s32_max(cur) > reg_s32_max(old))
+		s32_max = widen_smax(w, s32_max, S32_MAX);
+
+	/* low bits that are the same in all values seen so far are kept, e.g. alignment */
+	t = tnum_union(old->var_off, cur->var_off);
+	low = t.mask ? BIT_ULL(__ffs64(t.mask)) - 1 : 0;
+	cur->var_off = (struct tnum){ .value = t.value & low, .mask = ~low };
+	cur->r64 = cnum64_intersect(cnum64_from_urange(umin, umax),
+				    cnum64_from_srange(smin, smax));
+	cur->r32 = cnum32_intersect(cnum32_from_urange(u32_min, u32_max),
+				    cnum32_from_srange(s32_min, s32_max));
+	cur->id = 0;
+	cur->delta = 0;
+	reg_bounds_sync(cur);
+}
+
+bool bpf_same_loop(struct bpf_verifier_state *old, struct bpf_verifier_state *cur)
+{
+	return old->speculative == cur->speculative && same_callsites(old, cur);
+}
+
+/*
+ * @cur came to loop head @insn_idx and is not within @old, the state that
+ * went around the loop. Widen scalars of @cur, so that the walk goes around
+ * the loop with a state that stands for many iterations, see widen_reg().
+ * Everything else is left as is. If that is what differs the states never
+ * converge and the walk is given up after a few trips.
+ */
+int bpf_widen_loop_head(struct bpf_verifier_env *env, int insn_idx, bool backedge,
+			struct bpf_verifier_state *old, struct bpf_verifier_state *cur)
+{
+	/* @old is of an earlier run of the loop if @cur just entered it */
+	u32 passes = backedge ? old->loop_passes + 1 : 1;
+	struct widen_ctx w = { scc_thresholds(env, insn_idx), passes };
+	struct bpf_func_state *fold, *fcur;
+	int i, fr, num_slots;
+
+	env->widen_used = true;
+	if (passes > WIDEN_MAX_PASSES) {
+		verbose(env, "states at loop head %d don't converge\n", insn_idx);
+		return -E2BIG;
+	}
+
+	for (fr = 0; fr <= cur->curframe; fr++) {
+		fold = old->frame[fr];
+		fcur = cur->frame[fr];
+
+		for (i = 0; i < BPF_REG_FP; i++) {
+			/* registers of callers are not the ones the loop compares */
+			w.regno = fr == cur->curframe ? i : -1;
+			widen_reg(&w, &fold->regs[i], &fcur->regs[i]);
+		}
+
+		w.regno = -1;
+		num_slots = min(fold->allocated_stack, fcur->allocated_stack) / BPF_REG_SIZE;
+		for (i = 0; i < num_slots; i++) {
+			if (!bpf_is_spilled_reg(&fold->stack[i]) ||
+			    !bpf_is_spilled_reg(&fcur->stack[i]))
+				continue;
+			widen_reg(&w, &fold->stack[i].spilled_ptr, &fcur->stack[i].spilled_ptr);
+		}
+	}
+	cur->loop_passes = passes;
+	if (env->log.level & BPF_LOG_LEVEL2)
+		verbose(env, "loop head %d widened, pass %u\n", insn_idx, passes);
+	return 0;
+}
+
 /*
  * Check if scalar registers are exact for the purpose of not widening.
  * More lenient than regs_exact()
@@ -18970,7 +19252,9 @@ static int do_check(struct bpf_verifier_env *env)
 			}
 		}
 
-		if (bpf_is_prune_point(env, env->insn_idx)) {
+		/* loop heads are where states are widened, all of them have to be looked at */
+		if (bpf_is_prune_point(env, env->insn_idx) ||
+		    (env->widen_loops && insn_aux->loop_head)) {
 			err = bpf_is_state_visited(env, env->insn_idx);
 			if (err < 0)
 				return err;
@@ -22059,6 +22343,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	bpf_stack_liveness_free(env);
 	kvfree(env->cfg.insn_postorder);
 	kvfree(env->scc_info);
+	if (env->scc_thrs) {
+		for (i = 0; i < env->scc_cnt; i++)
+			kvfree(env->scc_thrs[i]);
+		kvfree(env->scc_thrs);
+	}
 	kvfree(env->succ);
 	kvfree(env->gotox_tmp_buf);
 	bpf_diag_free(env);
-- 
2.55.0

