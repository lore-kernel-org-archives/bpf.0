Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937180;
	b=AgMzEklG2YpG0FJaMavvfPQxJ+Yo1g7rvXwXW5W0yr88ztb0dsdHPvhlXv52wwI3EJc+
	 YUhnbVWNRMZurAbCBiRi4ms1DqUsR3QocwHQ0hsFNrkuX0VnBG9LhNFw0+JGz4CzBCFNJ
	 HhLCueaJEfmkXlmv7VwQbHc87/GvkMTEyLZuUIEjYNp2eXds0OQ+MMTgVAbQVkXNzjsZt
	 ubLiTIh5N/1AmpdObHZ2gElesMw2FdNutwUvtebHz2XCEViH1Q10/Malb2BbVHzRur8QO
	 UrAy98gfZo5t75UNe/ZrAxkof2U2uzbt+auALRyYlITEVG4xa/UwxiuguvevMfBCiAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937180;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QR8c1/3dg9ETaJzsukfFpsh2/TyD+Opcv23kWvWjZTs=;
	b=5qWFoNEbQnlB7vl7n8RNeKRNtCMet1pKVoFauZ0r8pkscE8wctEarACrguRvcwHYfcQ6
	 1+8ECSjyUo6pLpa7yiZJR2tWZIyU+VdH2xVEBvQz2lNSmL2xRgDP7Ts5zBlGuMYZbakdm
	 vI8daa1roiPipdNFs12JduVxi3YTUW/iqBcIheREWHIej8eVC2QmFUAnutlHA7NlBnJ33
	 WEUBvi+mXZbOhJh0hhFczlf+V57rbgA2CDznhCizyAZz9bS9K8UgPpImCvSH2OLVD8wm1
	 9xlRLDBgMWWa5DsqwR1EloNJSBjbwnMaJAD6VnvgVjlkGFDgFbNLzn8VN9nfQWpHLJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qXlpmWap;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4B2606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D4B2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qXlpmWap
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2eb0f1b592bso609345ad.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937179; x=1794541979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QR8c1/3dg9ETaJzsukfFpsh2/TyD+Opcv23kWvWjZTs=;
        b=qXlpmWapw/Q6VHZJgC0pdphWna95RentU2NwQFQRePuXGSkFGMqhR5N0EYtO7Q2C/U
         PFN5kFUmxVrWwXWb6ZetmJw8ajctSP9+IQeSnvfePjMAQs/AN3JSNnt+LzN2fpdo+WD8
         MUAnmcKXzSuWHq/UNx5BrQAcfAUxXK/8EYllU0LFMLrd+Q4zc9YDg5iBJPY6ofdk/mLI
         RLWQVuFVR9wibK+Dg7gr5e1dyHL8Do2NUkXwKDZD/9WQKCpDXIYg+29RHRogFILao3Ld
         oOf/rnGvQLnYfS/a7Xbh7Wz45dYBaBq52Iyf+M5SkXT6wZZzRwIdIU0tA6PNve7S67FE
         1xQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937179; x=1794541979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QR8c1/3dg9ETaJzsukfFpsh2/TyD+Opcv23kWvWjZTs=;
        b=JsLxLXAb8Of5t1FW70Z95GnmSNliVlLS9IVj6jf7PuwjeEeb3C10v/cR5IrF8G16QX
         TtGipp5Y5i6FNrbETS0ZtZLuoB5J44V5c7lcsvyzuM//6NFGjOIIvLPR0Nc5WUApCTux
         RYCC1waKtTageO2qSaQ3kGhWgyDo+VpGmmq09P4ufLjjpCcRvyFBd35x5vR5BXr8BuZP
         0kgU+CGF/yXkaivyP1i7SYXcTq9EvU/mYmJovTJEauNFLBVET3riT/aeonOkAuNhUaa+
         2gkM+hW0fE3t0fckjdFW1uI5gPB9kTicAKqGAg5/wD/vK7IDY07Xb98qMH9/TZKs9VjM
         C02w==
X-Gm-Message-State: APuU4Z/bIeVL3htCA79kzY9zlAURQpUCqPyO0NhqRVDoI04jg8JrrriU
	jtF703BbJs/zjEpLNBvwb0BYb6SGrm5707XooFCt33LLwTs81pw0gpVRDE2P+A==
X-Gm-Gg: AYBFou0/sL7Kk7BMfHCRHnKKnbsEcKmzwbZdv/FFv8Us5SjYxsNzDtPz0bHkDKzCc7X
	Hv+iH8XOPDWSmyL7jeujvGRwq6rc9Ld5ms8qLEYI4AYmTT00BiMOc6NFFxmMVR7hoVPdY7g5tdf
	TBFb4dIBDNVd0UmYoI24kCp/XfD/0yHvSSPaYUjPZsV81S9xyVNfOLj3peiz6wuz57t93nPvWiC
	8Y+ozpOOrk8/7M3iPjGNJOZjJu2qyDGDk+zmIbl8ZytM521b1Vl8/U7kIZqUPv/Vp9dW9B5elxT
	CSSS5sLG6Axg4S2Z0PgJmR8lHkC7WyC57B1Iau5BrkIJkXfSbljGLWVb5lWoNklHVKzvha3Eowj
	DTmTBriO6PeaMr1ow0aDY6r3MvHTYWTDn10BGGO0zS6ZELphxWAegTxZk12WngPRAONqudX4hrq
	xZh8B9ZZHgrUCUMvRhRPi2ziDvA4KXCtKePopy9EzZDru5Oz0b62AME8il8OKT54vyhcqqgWiCd
	Oa7i4Gwsroo+VVQiysYvNJSS7kPVKBqFIkfAlizAiYDhJgoqVBV+eqx0pHT+dzF4V0uUDzKZa+U
	TbGaJa7BDfsId3c//TWEguTcenhkQVlVi7/Xo+XdBGObjJ291p+BVJiTGEe3zmEy+fDTWbOllri
	6/1mxVtDHNJjLy0kgnznLhihK+0hOIFCwiiuYaOAnrE6Ti5bBjugaEdcCgsNk9OwNWjsxfoRVZA
	==
X-Received: by 2002:a17:903:2b0b:b0:2e2:e3aa:7a35 with SMTP id d9443c01a7336-2ed40c96724mr21010505ad.36.1793937178563;
        Thu, 05 Nov 2026 19:52:58 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d5f226sm1157605ad.44.2026.11.05.19.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:52:58 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 18/45] bpf: Tell the passes over the graph where an added may_goto goes
Date: Fri,  6 Nov 2026 03:50:42 +0000
Message-ID: <20261106035111.3315285-19-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
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

A spin lock in Rust, test atomic_spin_lock of rust-bpf:

  for _ in 0..n {
      while lock.compare_exchange_weak(...).is_err() {
          core::hint::spin_loop();
      }
      data += 1;
      lock.store(false, Release);
  }

The compiler makes one loop with two back edges. The spin does not pass the
test of the counter: no jump that leaves the loop is in each iteration.
Today: "infinite loop detected at insn 41". The only place for may_goto
that each iteration passes is the head. Its target is an exit of all loops
around it. Without that place: "loop at insn 41 never exits". 142 of the
225 progs of the schedulers of rust-bpf have such a loop.

The prog has no edge from the head to the exit. The main pass verifies the
state that goes there. But four passes before it see only the control flow
graph, and the main pass and scalar evolution rely on their results:

  pass                      if it does not know the edge
  ------------------------  -----------------------------------------------
  bpf_compute_const_regs()  r7 == &ro on all edges to the exit, r7 == &rw
                            at the head. 'for (i = 0; i < *r7; i++)' after
                            the exit gets its count from ro. The count is
                            wrong for the state that comes from the head.
  compute_subprog_args()    The same with fp-8 and fp-16: a store through
                            r7 changes a slot that the pass does not know.
  live registers            A register that the loop sets on each path to
                            the exit is dead at the head. The state at the
                            head drops it. A read after the exit is
                            rejected.
  bpf_edge_leaves_loop()    'if i > 255' sets a flag, the way from there
                            out of the loop leads through a jump of a
                            nested loop. may_goto in front of that jump
                            takes its other edge: the count is wrong.

The place and the target depend only on the loops. Thus call
bpf_flow_place_guards() directly after the loops are known. If a loop has
this place bpf_check() calculates the constants again, with nothing known
at the target. compute_subprog_args() joins what it knows at the head into
the target. A register that is live at the target is live at the head.

  do { ..; more = ++i < 256 && v->in[i & 63]; 10 insns; } while (more);
clang keeps the flag: 'if w6 > 255' sets it and stays in the loop. The old
bpf_edge_leaves_loop() lost it at 'w1 &= 1': no count, 15611 insns, and "R7
unbounded memory access" with one state for all iterations. Now it
propagates constants from the edge with the functions of const_fold.c: 112
insns. It has to know the added edges too. It runs after the constants are
calculated again. It does not enter a nested loop: may_goto there goes
where a jump of that loop goes, whatever the constants say.

The edge is there for each loop that can get a may_goto at its head, if it
gets one or not. Thus the passes can know less than before. The loop of
compute_live_registers/may_goto is such a loop: r1 is live at its head.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h                  |   7 +-
 kernel/bpf/const_fold.c                       | 128 +++++++++++++-
 kernel/bpf/liveness.c                         |  41 +++--
 kernel/bpf/loops.c                            | 167 ++++++++----------
 kernel/bpf/scev.c                             |  12 +-
 kernel/bpf/verifier.c                         |  15 ++
 .../bpf/progs/compute_live_registers.c        |   8 +-
 .../selftests/bpf/progs/verifier_loop_latch.c |   6 +-
 8 files changed, 264 insertions(+), 120 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 243715bad1e8..e5bee65807fa 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -810,6 +810,8 @@ struct bpf_backedge {
 	 */
 	int latches[MAX_LATCHES];
 	u8 latches_cnt;
+	/* bit k: the loop is left on the edge of latches[k] that is taken, not on the other one */
+	u8 taken_leaves;
 };
 
 struct bpf_loop_exit {
@@ -976,6 +978,8 @@ struct bpf_insn_aux_data {
 	u16 const_reg_map_mask;
 	u16 const_reg_subprog_mask;
 	u32 const_reg_vals[10];
+	/* bpf_edge_leaves_loop() + 1 for the edge that is not taken and for the one that is */
+	u8 edge_leaves[2];
 	/*
 	 * Header index of the innermost loop containing this instruction, -1 if none.
 	 * For a loop header, identifies the parent loop instead.
@@ -1700,7 +1704,8 @@ u16 bpf_call_const_arg_regs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 u16 bpf_call_checked_arg_regs(struct bpf_verifier_env *env, struct bpf_insn *insn);
 bool bpf_insn_is_iter_next(struct bpf_verifier_env *env, struct bpf_insn *insn);
 bool bpf_insn_leaves_loop(struct bpf_verifier_env *env, int h, int n);
-bool bpf_edge_leaves_loop(struct bpf_verifier_env *env, int h, int n, int t);
+int bpf_edge_leaves_loop(struct bpf_verifier_env *env, int h, int n, int t, int *budget);
+int bpf_find_latches(struct bpf_verifier_env *env, bool flags);
 bool bpf_jump_leaves_loop(struct bpf_verifier_env *env, int h, int n);
 int bpf_insert_recursion_checks(struct bpf_verifier_env *env);
 int bpf_split_cur_state(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
index eac2bf80274c..bcaec1488fc9 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -250,7 +250,7 @@ int bpf_compute_const_regs(struct bpf_verifier_env *env)
 	struct const_arg_info ci_out[MAX_BPF_REG];
 	struct bpf_iarray *succ;
 	bool changed;
-	int i, r;
+	int i, r, t;
 
 	/* kvzalloc zeroes memory, so all entries start as CONST_ARG_UNVISITED (0) */
 	ci_in = kvzalloc_objs(*ci_in, insn_cnt, GFP_KERNEL_ACCOUNT);
@@ -264,6 +264,12 @@ int bpf_compute_const_regs(struct bpf_verifier_env *env)
 		for (r = 0; r < MAX_BPF_REG; r++)
 			ci_in[start][r] = unknown;
 	}
+	/* The same from the head of a loop to where the loop is left, once the loops are known. */
+	for (i = 0; i < insn_cnt; i++) {
+		t = bpf_head_guard_target(env, i);
+		for (r = 0; r < MAX_BPF_REG && t >= 0; r++)
+			ci_in[t][r] = unknown;
+	}
 
 redo:
 	changed = false;
@@ -344,6 +350,126 @@ static int eval_const_branch(u8 opcode, u64 dst_val, u64 src_val)
 	}
 }
 
+/* 1: the registers @ci take the conditional jump @insn, 0: they don't, -1: not known */
+static int const_branch_taken(const struct bpf_insn *insn, const struct const_arg_info *ci)
+{
+	u64 dst = ci[insn->dst_reg].val, src = insn->imm;
+
+	if (!ci_is_const(&ci[insn->dst_reg]))
+		return -1;
+	if (BPF_SRC(insn->code) == BPF_X) {
+		if (!ci_is_const(&ci[insn->src_reg]))
+			return -1;
+		src = ci[insn->src_reg].val;
+	}
+	/* see bpf_prune_dead_branches() */
+	if (BPF_CLASS(insn->code) == BPF_JMP32) {
+		dst = (s32)dst;
+		src = (s32)src;
+	}
+	return eval_const_branch(insn->code, dst, src);
+}
+
+/* The registers in front of the insn @idx on the paths that got there so far */
+struct edge_state {
+	int idx;
+	struct const_arg_info ci[MAX_BPF_REG];
+};
+
+#define EDGE_OPEN	8	/* insns that wait for their turn */
+
+/*
+ * Does the program leave the loop at @h when the conditional jump at @n goes on at @t?
+ * It does when @t is not in the loop. A compiler also makes
+ *	w1 = 0; if w7 > 255 goto l; ...; w1 = 1; l: ...; w1 &= 1; if w1 != 0 goto head;
+ * of 'do { ...; more = ++i < 256 && ...; ...; } while (more);'. The jump that leaves the loop
+ * looks at 1 or 0. The jump that counts stays in the loop on both edges.
+ *
+ * So propagate constants once more, over what can be reached from this edge only. Start with
+ * the constants at @n. A jump that the constants decide has one successor. Two paths that
+ * meet are joined: both started at the edge. If nothing leads to @h the edge leaves the loop.
+ *
+ * The insn that is first in reverse post order goes first. A cycle without @h is a nested
+ * loop, so all that leads to the insn was looked at and every insn has one turn.
+ *
+ * Every edge that the program has at run time must be followed, the edges of may_goto that the
+ * verifier adds too. May_goto of @h and of the loops around it leaves @h. A nested loop can get
+ * one in front of a jump that the constants decide the other way. So don't go into a nested loop.
+ *
+ * @budget: the insns to look at. 0: look at @t only. An edge is followed once: a jump can
+ * dominate more than one back edge. Returns 1, 0, or an error.
+ */
+int bpf_edge_leaves_loop(struct bpf_verifier_env *env, int h, int n, int t, int *budget)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[n];
+	struct bpf_insn *insns = env->prog->insnsi, *insn;
+	int *nums = env->cfg.postorder_nums;
+	int i, l, s, first, taken, cnt = 1;
+	u8 *seen = &aux->edge_leaves[t != n + 1];
+	struct edge_state *open, *cur;
+	struct bpf_iarray *succ;
+	int ret = 0;
+
+	l = bpf_loop_at_index(env, t);
+	if (l != h)
+		return !bpf_is_nested_loop(env, l, h);
+	if (*seen)
+		return *seen - 1;
+	if (t == h || !*budget)
+		return 0;
+
+	open = kcalloc(EDGE_OPEN + 1, sizeof(*open), GFP_KERNEL_ACCOUNT);
+	if (!open)
+		return -ENOMEM;
+	cur = &open[EDGE_OPEN];
+	open[0].idx = t;
+	for (i = 0; i < MAX_BPF_REG; i++) {
+		open[0].ci[i].state = CONST_ARG_UNKNOWN;
+		if (i < ARRAY_SIZE(aux->const_reg_vals) && (aux->const_reg_mask & BIT(i))) {
+			open[0].ci[i].state = CONST_ARG_CONST;
+			open[0].ci[i].val = aux->const_reg_vals[i];
+		}
+	}
+	while (cnt) {
+		for (i = 1, first = 0; i < cnt; i++)
+			if (nums[open[i].idx] > nums[open[first].idx])
+				first = i;
+		*cur = open[first];
+		open[first] = open[--cnt];
+		if (!*budget)
+			goto out;
+		--*budget;
+		insn = &insns[cur->idx];
+		const_reg_xfer(env, cur->ci, insn, insns, cur->idx);
+		taken = bpf_insn_is_cond_jump(insn->code) ? const_branch_taken(insn, cur->ci) : -1;
+		succ = bpf_insn_successors(env, cur->idx);
+		iarray_for_each(s, succ) {
+			if (taken >= 0 && s != cur->idx + 1 + (taken ? insn->off : 0))
+				continue;
+			l = bpf_loop_at_index(env, s);
+			if (s == h || bpf_is_nested_loop(env, l, h))
+				goto out;
+			if (l != h)
+				continue;
+			for (i = 0; i < cnt && open[i].idx != s; i++)
+				;
+			if (i == EDGE_OPEN)
+				goto out;
+			if (i < cnt) {
+				const_reg_join(open[i].ci, cur->ci);
+				continue;
+			}
+			open[cnt] = *cur;
+			open[cnt++].idx = s;
+		}
+	}
+	ret = 1;
+out:
+	*seen = ret + 1;
+	kfree(open);
+	return ret;
+}
+
 /*
  * Rewrite conditional branches with constant outcomes into unconditional
  * jumps using register values resolved by bpf_compute_const_regs() pass.
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 525c0faff1a6..6a2ee407412b 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1054,6 +1054,22 @@ static bool arg_track_join(struct bpf_verifier_env *env, int idx, int target, in
 	return true;
 }
 
+/* What leaves @idx gets to @target */
+static bool arg_track_join_all(struct bpf_verifier_env *env, int idx, int target,
+			       struct arg_track *in, struct arg_track *stack_in,
+			       const struct arg_track *out, const struct arg_track *stack_out,
+			       u32 nslots)
+{
+	bool changed = false;
+	int r;
+
+	for (r = 0; r < MAX_AT_TRACK_REGS; r++)
+		changed |= arg_track_join(env, idx, target, r, &in[r], out[r]);
+	for (r = 0; r < nslots; r++)
+		changed |= arg_track_join(env, idx, target, -r - 1, &stack_in[r], stack_out[r]);
+	return changed;
+}
+
 /*
  * Compute the result when an ALU op destroys offset precision.
  * If a single arg is identifiable, preserve it with OFF_IMPRECISE.
@@ -2069,6 +2085,7 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 		int i = idx - start;
 		struct bpf_insn *insn = &insns[idx];
 		struct bpf_iarray *succ;
+		int ti;
 
 		if (!arg_is_visited(&at_in[i][0]) && !arg_is_visited(&at_in[i][1]))
 			continue;
@@ -2076,6 +2093,12 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 		memcpy(at_out, at_in[i], sizeof(at_out));
 		memcpy(at_stack_out, &at_stack_in[(size_t)i * nslots], nslots * sizeof(*at_stack_out));
 
+		ti = bpf_head_guard_target(env, idx) - start;
+		if (ti >= 0)
+			changed |= arg_track_join_all(env, idx, start + ti, at_in[ti],
+						      &at_stack_in[(size_t)ti * nslots],
+						      at_out, at_stack_out, nslots);
+
 		arg_track_xfer(env, insn, idx, at_out, at_stack_out, nslots,
 			       at_stack_arg_entry, instance, callsites);
 		arg_track_log(env, insn, idx, at_in[i], &at_stack_in[(size_t)i * nslots], at_out,
@@ -2085,21 +2108,14 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 		succ = bpf_insn_successors(env, idx);
 		for (int s = 0; s < succ->cnt; s++) {
 			int target = succ->items[s];
-			int ti;
 
 			/* Filter: stay within the subprogram's range */
 			if (target < start || target >= end)
 				continue;
 			ti = target - start;
-
-			for (r = 0; r < MAX_AT_TRACK_REGS; r++)
-				changed |= arg_track_join(env, idx, target, r,
-							  &at_in[ti][r], at_out[r]);
-
-			for (r = 0; r < nslots; r++)
-				changed |= arg_track_join(env, idx, target, -r - 1,
-							  &at_stack_in[(size_t)ti * nslots + r],
-							  at_stack_out[r]);
+			changed |= arg_track_join_all(env, idx, target, at_in[ti],
+						      &at_stack_in[(size_t)ti * nslots],
+						      at_out, at_stack_out, nslots);
 		}
 	}
 	if (changed)
@@ -2780,6 +2796,7 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 			u32 new_out = 0;
 			u32 new_in = 0;
 			u32 use;
+			int t;
 
 			succ = bpf_insn_successors(env, insn_idx);
 			for (int s = 0; s < succ->cnt; ++s)
@@ -2794,6 +2811,10 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 				use |= state[insn_idx + insns[insn_idx].imm + 1].in &
 				       mask_widen(GENMASK(BPF_REG_5, BPF_REG_1));
 			new_in = (new_out & ~live->def) | use;
+			/* may_goto that is added at the head of a loop goes there */
+			t = bpf_head_guard_target(env, insn_idx);
+			if (t >= 0)
+				new_in |= state[t].in;
 			if (new_out != live->out || new_in != live->in) {
 				live->in = new_in;
 				live->out = new_out;
diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
index 729e0055f86f..c77378b3fbde 100644
--- a/kernel/bpf/loops.c
+++ b/kernel/bpf/loops.c
@@ -304,97 +304,35 @@ int bpf_loop_at_index(struct bpf_verifier_env *env, u32 idx)
 	return aux[idx].loop ? idx : aux[idx].loop_header;
 }
 
-/* @known: the registers that hold the constant @val behind @insn. False: a jump or the like. */
-static bool track_consts(const struct bpf_insn *insn, u16 *known, s32 *val)
-{
-	u8 class = BPF_CLASS(insn->code);
-
-	if (class == BPF_ST || (class == BPF_STX && BPF_MODE(insn->code) == BPF_MEM))
-		return true;
-	/* r6 - r9 are what they were when the call returns */
-	if (insn->code == (BPF_JMP | BPF_CALL)) {
-		*known &= ~GENMASK(BPF_REG_5, BPF_REG_0);
-		return true;
-	}
-	if (class != BPF_ALU && class != BPF_ALU64 && class != BPF_LDX)
-		return false;
-	*known &= ~BIT(insn->dst_reg);
-	if (class != BPF_LDX && BPF_OP(insn->code) == BPF_MOV && BPF_SRC(insn->code) == BPF_K) {
-		*known |= BIT(insn->dst_reg);
-		val[insn->dst_reg] = insn->imm;
-	}
-	return true;
-}
-
-/*
- * Does the program leave the loop at @h when the conditional jump at @n goes on at @t?
- * It does when @t is not in the loop. A compiler also makes
- *	w2 = 1; if w1 == 0 goto l; w2 = 0; l: ...; if w2 != 1 goto head;
- * of 'while (n--)'. So follow the constants that are set next to the jump for as long as there
- * is one way to go.
- */
-bool bpf_edge_leaves_loop(struct bpf_verifier_env *env, int h, int n, int t)
-{
-	struct bpf_insn *insns = env->prog->insnsi, *insn;
-	s32 val[MAX_BPF_REG];
-	u16 known = 0;
-	int i, l;
-	u8 op;
-
-	/* the insns in front of the jump, for as long as nothing else leads to the next one */
-	for (i = n; i && i > n - 4 && !env->insn_aux_data[i].loop && env->idoms[i] == i - 1; i--)
-		;
-	for (; i < n; i++)
-		if (!track_consts(&insns[i], &known, val))
-			known = 0;
-	for (i = 0; i < 16; i++, t++) {
-		l = bpf_loop_at_index(env, t);
-		if (l != h && !bpf_is_nested_loop(env, l, h))
-			return true;
-		insn = &insns[t];
-		op = BPF_OP(insn->code);
-		if (t == h) {
-			return false;
-		} else if (insn->code == (BPF_JMP | BPF_JA)) {
-			t += insn->off;
-		} else if (is_cond_jmp_insn(insn)) {
-			/* a 32-bit and a 64-bit jump agree on a number that is not negative */
-			if (!(known & BIT(insn->dst_reg)) || val[insn->dst_reg] < 0 ||
-			    BPF_SRC(insn->code) != BPF_K || (op != BPF_JEQ && op != BPF_JNE))
-				return false;
-			if ((val[insn->dst_reg] == insn->imm) == (op == BPF_JEQ))
-				t += insn->off;
-		} else if (!track_consts(insn, &known, val)) {
-			return false;
-		}
-	}
-	return false;
-}
-
 /*
  * Collect conditional jumps within n's loop that dominate 'n' and leave
  * the loop on one edge, see bpf_edge_leaves_loop(), nearest first.
  */
-static void find_dominating_conditions(struct bpf_verifier_env *env, int n,
-				       struct bpf_backedge *backedge)
+static int find_dominating_conditions(struct bpf_verifier_env *env, int n,
+				      struct bpf_backedge *backedge, int budget)
 {
 	struct bpf_insn *insns = env->prog->insnsi;
-	bool t_exits_loop, f_exits_loop;
+	int t_exits_loop, f_exits_loop;
 	int *idoms = env->idoms;
 	int n_loop;
 
 	n_loop = bpf_loop_at_index(env, n);
 	if (idoms_intersect(env, n, n_loop) != n_loop)
-		return;
+		return 0;
 	while (n >= 0) {
 		if (is_cond_jmp_insn(&insns[n]) && bpf_loop_at_index(env, n) == n_loop) {
-			t_exits_loop = bpf_edge_leaves_loop(env, n_loop, n, n + insns[n].off + 1);
-			f_exits_loop = bpf_edge_leaves_loop(env, n_loop, n, n + 1);
+			t_exits_loop = bpf_edge_leaves_loop(env, n_loop, n, n + insns[n].off + 1,
+							    &budget);
+			f_exits_loop = bpf_edge_leaves_loop(env, n_loop, n, n + 1, &budget);
+			if (t_exits_loop < 0 || f_exits_loop < 0)
+				return -ENOMEM;
 			/* latches[0] is the latch: it has to leave the loop itself */
 			if ((t_exits_loop || f_exits_loop) &&
 			    (backedge->latches_cnt || bpf_jump_leaves_loop(env, n_loop, n))) {
 				if (backedge->latches_cnt == MAX_LATCHES)
-					return;
+					return 0;
+				if (t_exits_loop)
+					backedge->taken_leaves |= BIT(backedge->latches_cnt);
 				backedge->latches[backedge->latches_cnt++] = n;
 			}
 		}
@@ -402,6 +340,60 @@ static void find_dominating_conditions(struct bpf_verifier_env *env, int n,
 			break;
 		n = idoms[n];
 	}
+	return 0;
+}
+
+/* The insns to look at, per back edge, to find the jumps that leave a loop by way of a flag */
+#define FLAG_BUDGET	4096
+
+/*
+ * Without @flags: the jumps that leave a loop themselves. That tells where the verifier may add
+ * may_goto. It takes the constants that hold with these edges to follow a flag.
+ */
+int bpf_find_latches(struct bpf_verifier_env *env, bool flags)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_backedge *backedge;
+	struct bpf_loop *loop;
+	int i, j, k, err;
+
+	for (i = 0; i < env->prog->len; i++) {
+		loop = aux[i].loop;
+		if (!loop)
+			continue;
+		if (signal_pending(current))
+			return -EAGAIN;
+		cond_resched();
+		for (j = 0; j < loop->backedges_cnt; j++) {
+			backedge = &loop->backedges[j];
+			backedge->latches_cnt = 0;
+			backedge->taken_leaves = 0;
+			/*
+			 * In theory, the backedge->from and it's latch can reside in
+			 * an inner loop of `i`, e.g.:
+			 *
+			 *  1:  r7 += 1;
+			 *  2:  r6 += 1;
+			 *      if r7 == 2 goto 1b;
+			 *      if r6 < 2 goto 2b;
+			 *
+			 * For now, let's assume that latches are unknown for such cases.
+			 * (GCC/LLVM handle this by inserting artificial cfg nodes).
+			 */
+			if (bpf_loop_at_index(env, backedge->from) != i)
+				continue;
+			err = find_dominating_conditions(env, backedge->from, backedge,
+							 flags ? FLAG_BUDGET : 0);
+			if (err)
+				return err;
+			for (k = 1; k < backedge->latches_cnt; k++)
+				if ((env->log.level & BPF_LOG_LEVEL2) &&
+				    !bpf_jump_leaves_loop(env, i, backedge->latches[k]))
+					bpf_log(&env->log, "loop at %d, exit by way of a flag at %d\n",
+						i, backedge->latches[k]);
+		}
+	}
+	return 0;
 }
 
 /*
@@ -572,30 +564,9 @@ int bpf_compute_loops(struct bpf_verifier_env *env)
 		if (err)
 			goto out;
 	}
-	/* find latches */
-	for (i = 0; i < len; i++) {
-		loop = aux[i].loop;
-		if (!loop)
-			continue;
-		for (j = 0; j < loop->backedges_cnt; j++) {
-			backedge = &loop->backedges[j];
-			/*
-			 * In theory, the backedge->from and it's latch can reside in
-			 * an inner loop of `i`, e.g.:
-			 *
-			 *  1:  r7 += 1;
-			 *  2:  r6 += 1;
-			 *      if r7 == 2 goto 1b;
-			 *      if r6 < 2 goto 2b;
-			 *
-			 * For now, let's assume that latches are unknown for such cases.
-			 * (GCC/LLVM handle this by inserting artificial cfg nodes).
-			 */
-			if (bpf_loop_at_index(env, backedge->from) != i)
-				continue;
-			find_dominating_conditions(env, backedge->from, backedge);
-		}
-	}
+	err = bpf_find_latches(env, false);
+	if (err)
+		goto out;
 	/* find exits */
 	for (i = 0; i < len; i++) {
 		iloop = aux[i].loop ? i : aux[i].loop_header;
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 819b563a5b54..8ce188a715e8 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2043,13 +2043,12 @@ static bool loop_invariant(struct scev *scev, u32 id)
 
 static int match_linear_latch(struct bpf_verifier_env *env,
 			      u32 header,
-			      u32 latch_idx,
+			      u32 latch_idx, bool taken_leaves,
 			      struct linear_latch *latch)
 {
 	struct bpf_insn *insn = &env->prog->insnsi[latch_idx];
 	struct scev *scev = env->scev;
 	struct env *latch_env;
-	u32 true_branch_tgt;
 	u32 src_reg_scev;
 	u32 dst_reg_scev;
 	u32 t, l, r, op;
@@ -2058,8 +2057,7 @@ static int match_linear_latch(struct bpf_verifier_env *env,
 	op = BPF_OP(insn->code);
 	latch->jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
 	/* Flip the condition if true branch jumps out of the loop. */
-	true_branch_tgt = latch_idx + bpf_jmp_offset(insn) + 1;
-	if (bpf_edge_leaves_loop(env, header, latch_idx, true_branch_tgt))
+	if (taken_leaves)
 		op = bpf_rev_opcode(op);
 	switch (op) {
 	case BPF_JSLT:
@@ -3289,7 +3287,8 @@ static int count_backedge(struct bpf_verifier_env *env, struct bpf_func_state *s
 
 	for (j = 0; j < backedge->latches_cnt; j++) {
 		latch_idx = backedge->latches[j];
-		linear_latch = match_linear_latch(env, insn_idx, latch_idx, &latch);
+		linear_latch = match_linear_latch(env, insn_idx, latch_idx,
+						  backedge->taken_leaves & BIT(j), &latch);
 		if (linear_latch < 0)
 			return linear_latch;
 		if (!linear_latch) {
@@ -3305,6 +3304,9 @@ static int count_backedge(struct bpf_verifier_env *env, struct bpf_func_state *s
 					insn_idx, latch_idx);
 			continue;
 		}
+		/* a flag can have other reasons to end the loop */
+		if (!bpf_jump_leaves_loop(env, insn_idx, latch_idx))
+			tmp.min_header_count = 0;
 		if (!found || tmp.max_header_count < iters->max_header_count) {
 			iters->max_header_count = tmp.max_header_count;
 			iters->iv_reg = tmp.iv_reg;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8c89bf67a842..5af42d2dcab9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -25219,6 +25219,21 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	/*
+	 * It took the constants to remove dead branches and find the loops. Now it's known
+	 * which edges the verifier may add, see bpf_head_guard_target(). What follows
+	 * believes the constants.
+	 */
+	ret = bpf_flow_place_guards(env);
+	if (ret > 0)
+		ret = bpf_compute_const_regs(env);
+	if (ret < 0)
+		goto skip_full_check;
+
+	ret = bpf_find_latches(env, true);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = bpf_compute_live_registers(env);
 	if (ret < 0)
 		goto skip_full_check;
diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
index ba43304836ca..f5c505dfd464 100644
--- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
+++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
@@ -316,11 +316,15 @@ __naked void gotol(void)
 }
 #endif
 
+/*
+ * If the verifier had to add may_goto to this loop it would be at the head, insn 0, and go to
+ * insn 3. What is live at 3 is live at 0.
+ */
 SEC("socket")
 __log_level(2)
-__msg("0: .......... (b7) r1 = 1")
+__msg("0: .1........ (b7) r1 = 1")
 __msg("1: .1........ (e5) may_goto pc+1")
-__msg("2: .......... (05) goto pc-3")
+__msg("2: .1........ (05) goto pc-3")
 __msg("3: .1........ (bf) r0 = r1")
 __msg("4: 0......... (95) exit")
 __naked void may_goto(void)
diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_latch.c b/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
index 1fcefce9ab01..6dd46edd8ed0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
@@ -130,17 +130,17 @@ LOOP(down_two_tests, "w8 = 4; r6 += 2043;",
 /* 'while (n--)': the jump that counts sets a flag, the jump that leaves the loop tests it */
 #define FLAG(mid)	"w8 += 1; w2 = 1; if w8 == 0 goto 2f; w2 = 0; 2: " mid " if w2 != 1 goto 1b;"
 
-OK("a flag", "2048")
+OK("a flag", "[0..2048]")
 LOOP(flag, "w8 = -2048;", FLAG("r3 = r6;"))
 
 BAD("a flag, one too many")
 LOOP(flag_bad, "w8 = -2049;", FLAG("r3 = r6;"))
 
-OK("a flag, a store behind it", "2048")
+OK("a flag, a store behind it", "[0..2048]")
 LOOP(flag_store, "w8 = -2048;",
      "w8 += 1; w2 = 1; *(u32 *)(r10 - 4) = r8; if w8 == 0 goto 2f; w2 = 0; 2: if w2 != 1 goto 1b;")
 
-OK("a flag, a call behind it", "2048")
+OK("a flag, a call behind it", "[0..2048]")
 LOOP(flag_call, "w8 = -2048;",
      "w8 += 1; w9 = 1; if w8 == 0 goto 2f; w9 = 0; 2: call %[bpf_get_prandom_u32]; if w9 != 1 goto 1b;")
 
-- 
2.55.0

