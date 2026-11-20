Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207996;
	b=ZiuiEdMR7oR0ROkh3fh2HA77pJJ/qAUT2QatwL70CWJPjCQ0TzMhqYA5IfDHzEUK/K8a
	 t0v1RxdSho5WINdKQxzWyGUrK19Q31NKVJw0OJB+oR+EsIuShPbLgg7MPHsHLNS5Iwfap
	 4mrqKsyoLwfdjiLc8HF1p017y3Q15ktPRbQl3vq909vG6EP7eZ4+tlXLCwaDUGI+8yvTQ
	 Gj4OsnPAuZIhzySMf3XMNbfLAPytD5NqVHFYDtVkSfPzrSgripsxCuRBvWxu/27ypalxN
	 fPuMhszwiJst8hJGoI4+43buWsp3LR+iBxEIIr1c4JJo5tHP45eY5h99INitcx2ZKAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Q4laom9/uVnhNK5mbr6nURYednMaQ7pwCNC4grBo75o=;
	b=4xgxtO58yVN91c7rRsgzZ3iCHzabtEYzBpcfIDOCuHIr8SCtHqF8VMm/nIxzEheqtJuX
	 X4Jti6W4gXAI9V2YbQv8HVD2UwkJmCNFwtPtVG8lQfLjyMGmqs1erHOf++Xb9AXZcRBmD
	 7wo5pUpUeaGKmhAbAxzKPwRecNuDLNP0UGkdwhnGulmvZwycp0zKtjp9PXMlPeK1CetQf
	 gn/F0WYPuqVJgv997R5oubEYMb7fCGEDyqxGcmSZIc4ttFol6MHD0GZKnS7DefuFcLs6a
	 RLl2fvwF2ZuTL07moGo9/0WY8r7ZNTtgCP3zu44NWxMuhVHLUjVKtiLv0xq/IIvq0kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ehtvYUp1;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9B8606A6B7
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E9B8606A6B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ehtvYUp1
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8c70c2ab5a2so645531b3a.3
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207987; x=1795812787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q4laom9/uVnhNK5mbr6nURYednMaQ7pwCNC4grBo75o=;
        b=ehtvYUp1kZv5dnRA/U/PIb/LOY6HT0JC4ZiDWUNN32vO6oQlx93RKtyI/gTccKa0JH
         nRICwYwfpJZYvfcw9YfnuDf55/9YB1fyZEN+GwVVXgkTfWN9tnB6h3nonLL5PTLOkARb
         TOtU8bQ8NdFlOdliAjzAbdoiRTBnDo7QOuGUVSbpr/ujAzx0uezzBIj+oTQ1UfR0YXub
         hHHMX/wvjPB1dGbzWGBenN4IhYZdWOEtMPUWNDjt2pj5XLCfPpmX0VHSO68PeyOvzv2M
         WgQxwPThg2et2v30e6AJ0XLGedcBiFNoO/bFSS4K388xysjUiIyUrSb3BMmHGMWUvYEp
         4M4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207987; x=1795812787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q4laom9/uVnhNK5mbr6nURYednMaQ7pwCNC4grBo75o=;
        b=p8aHQxl4FigMFJMVNZH7inT+FuWH+CREmj1rE80mdX3uZ0KfUtP3yBWR+W5nz9CsJ9
         YYGZDPSBg6XnE/PkJ/xWKggd8W5BMDUstrl+NcrfluIYh5WctGmT6ElsCjiNw/kSlQnp
         57spAbfeCqFp+g2YH3fEsZGNxBKnn123DehCSCwyKSVLWhkxUTfMyDgwyg/PIi7/c4Lw
         Q//Eou4MXK+OzfTwCEg3NPm6NABNEvozWKmsgYn8d855q+AdUqkCV0ptcS+0JWoaoFlY
         Zk63o6E+PAOUGsYVhq1S6mnSC4t8ve4f4ginrqjVVFyGzQ/jBT7rZs9BXQG74Bn+OTEg
         kTxA==
X-Gm-Message-State: APuU4Z9zObjvPwpVwSAWPS/nuppqsQ2QppDTiX6Rjx1tkbKTwKgMzIBG
	Q9Ck8ryQeQVOQmgmlulHIWMMWy4i4LqxU61enQn8vTZujRBHKDxerxLrzRxrrw==
X-Gm-Gg: AZFdTZcUU8cIsEMF1FgPSq1PXeFuqFs+klKj41wMn52yy5YeKgKkzjhPgve/xsiVn/v
	w/PDnrCLb71PF7acmAKpy3g9YR8sAqC/ewHdxYwOOT7nBuHc3Du7/r0qisw9Llgep1vQLP3aSzt
	hPU95y1pm6kQ6KZQAQYpq+56WnJXPkdKv5XuM2bcUQ+ZAcHxZ2N86BGR+hubBKRQe0ahHCTq52E
	qUQ6tVK5vCDMN4do+ZhE3wNxgFy71cqmIiBZyNyMzM0zdFy7RndsihVvpsNEO1rcdBuzabvf2yh
	ELFSOzKfCB1oWxF0xSj94HAdMNFe/OYawROjdenE9At/96npprpY4FtRnG8L9fedBhJ2IXYDzzZ
	8B6ELIbSPsAZrWV/73r8E/w2OQ0aWtMpuhbicEdLMm0rqN8cQoIZAFUqDoyv8in1lQzBUF3kjD8
	Uu7iujM1xRv4WmiEAKdIHQ2Qu8mu0tuXmjqLJucKKcB4Tvnv4aVsLCCKqfPRvZkO0fuRN1zAuU1
	rbsWGgJ41L05wt6aeGOIOEmYhCb+MeNzII4KQ1XRVu9W+x2yuUgLhHsYFj4oEEPqp7giYZrAC52
	ckW6MyjMv61QnB8n14mI0ZSg4cK5d6fr9v4sSgtG4BkXO3GerTDzzad00XoBIDM7/eSFOY9qgo7
	kKAp51zlLeeKmdRdmk3kZ5alx478XMB5i/YxVrXMpRwpzp7NOddsnOxijzaqWalRzhrJFU7q8tA
	==
X-Received: by 2002:a05:6a00:2d0b:b0:89f:63f9:b6c4 with SMTP id d2e1a72fcca58-8c87c6728demr3881228b3a.32.1795207986278;
        Fri, 20 Nov 2026 12:53:06 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c219sm2027768b3a.18.2026.11.20.12.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:53:05 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 31/49] bpf: Give a loop a checked trip count or may_goto
Date: Fri, 20 Nov 2026 20:49:39 +0000
Message-ID: <20261120204959.614908-32-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
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

A fixpoint proves that each insn is safe. It does not prove that a loop
ends. A state that is pruned by its own ancestor closes a cycle:

  t --> ... --> header --> ... --> s
  ^                                |
  `----------- subsumes -----------'

All pruned states go through flow_check_trip_counts(). If s made more
trips than t, look at the trip index k of s:

  if k <= BPF_MAX_TRIPS (2^32)   the loop has a trip count, no may_goto
  else                           the loop gets may_goto

A loop that has may_goto or an iterator needs nothing. There is no trip
count without CAP_PERFMON, as before.

may_goto is there for all states at run time. If a state went through
the loop without its edges, the pass starts again.
bpf_flow_drop_guards() removes may_goto that no state needed.

A peeled trip that an earlier trip subsumes is pruned for the price of
may_goto, see flow_prune_peeled(). bpf_flow_trip_is_new() tells if one
more peeled trip can help. bpf_guard_edge and the old members of
loop_stack_entry go away.

may_goto at a header skips the body. So a slot that is live at its
target is live at the header.

bpf_loop_spine_end() finds the insns that dominate all back edges. It
replaces the counters in flow_place_guards().

If both edges of a jump are dead, no run gets to the jump. It becomes
'goto -1'.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  56 +++------
 kernel/bpf/fixups.c          |   3 +
 kernel/bpf/flow.c            | 233 +++++++++++++++++++++++++++++++----
 kernel/bpf/liveness.c        |   3 +
 kernel/bpf/loops.c           |  10 ++
 kernel/bpf/verifier.c        |  84 ++++++-------
 6 files changed, 282 insertions(+), 107 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1ae2f57311c..4ed4efcd45f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -435,13 +435,6 @@ static inline u64 bpf_xreg(u32 frameno, u32 xregno)
 	return (u64)frameno << 32 | xregno;
 }
 
-/* Where may_goto that the verifier adds goes, see check_loop_guard() */
-enum bpf_guard_edge {
-	BPF_NO_GUARD_EDGE,
-	BPF_GUARD_LEAVES_SUBPROG,
-	BPF_GUARD_LEAVES_LOOP,
-};
-
 /*
  * A state in a loop, see bpf_flow_loop_enter()
  *
@@ -452,22 +445,6 @@ enum bpf_guard_edge {
  */
 struct loop_stack_entry {
 	struct bpf_loop *loop;
-	u32 loop_id:23;
-	u32 terminates:1;
-	/* the loop had may_goto when the state entered it, see check_loop_guard() */
-	u32 guarded:1;
-	/*
-	 * The iterations are kept apart: states with different @trip are not
-	 * joined for as long as they are in the loop.
-	 */
-	u32 apart:1;
-	/* max_header_count follows from the state at the entry, not from patience */
-	u32 counted:1;
-	/*
-	 * The first iteration of a counted loop is kept apart. The state that comes back
-	 * to the head is made to stand for the rest.
-	 */
-	u32 first:1;
 	/* How many times the state came back to the header. A join has the larger number. */
 	u32 trip;
 	/* The state that entered the loop. What comes back to the header is for that state. */
@@ -480,12 +457,6 @@ struct loop_stack_entry {
 	u64 exit_threshold;	/* by the jumps that the state passed and that leave the loop */
 };
 
-/* The state is in a walk on patience, which may not get to the end of the loop */
-static inline bool bpf_loop_walk_may_give_up(const struct loop_stack_entry *entry)
-{
-	return entry->apart && entry->terminates && !entry->counted && !entry->first;
-}
-
 /* The states of trip 0, 1, 2, 4, 8, ... are saved. A compare with them finds any period. */
 static inline bool bpf_trip_is_saved(const struct loop_stack_entry *entry)
 {
@@ -868,7 +839,9 @@ enum bpf_loop_kind {
 /* What a pass finds about a loop */
 struct bpf_loop_per_pass {
 	bool needs_guard;	/* see bpf_flow_needs_guard() */
+	bool no_guard_edges;	/* a state did not take the edges of may_goto */
 	bool has_leftover;	/* the peeled trips were not enough */
+	bool peel_pruned;	/* see flow_prune_peeled() */
 	/* a check failed in a state that the loop kept apart, with no other suspect */
 	bool has_unproven;
 	u32 last_peeled_trip;	/* see flow_keep_peeled() */
@@ -901,11 +874,14 @@ struct bpf_loop {
 	u32 max_peel_cnt;	/* peel up to this trip */
 	bool peeled_apart;	/* the join rule holds for states that start a peeled trip */
 	bool disjoint_apart;	/* disjoint values in data_deps stay apart, also in the leftover */
+	bool no_peel_prune;	/* a larger earlier trip does not prune, see flow_prune_peeled() */
 	);
 	struct bpf_loop_per_pass last_pass;	/* the last pass whose partition was kept */
 	bool partitioned;	/* the last partition was for this loop */
 	bool peeled_joined;	/* at the start of a peeled trip, against the join rule */
+	bool changed;		/* see flow_forget_loop() */
 	bool guarded;		/* states take the edges of may_goto */
+	bool infinite;		/* see failing_path_trip() */
 	struct bpf_iv_threshold *iv_thresholds;	/* where an iv can stop, see equation_join.c */
 	u32 iv_threshold_cnt, iv_threshold_cap;
 	u32 leftover_epoch;	/* how many leftovers started */
@@ -984,7 +960,6 @@ struct bpf_insn_aux_data {
 	u64 speculative_first:1; /* a speculative state came to it first */
 	u64 call_recorded:1; /* see record_call_fixup() */
 	u64 pessimized:1; /* see bpf_partition_for_pessimized() */
-	u64 guard_edge_dropped:1; /* an edge of may_goto from here was dropped */
 	u64 alu_state:5; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
 	 * pattern for a bpf_fastcall call.
@@ -1398,7 +1373,7 @@ struct bpf_verifier_env {
 	bool imprecise;			/* a state before the first error is imprecise */
 	bool over_limit;		/* see bpf_check_limits() */
 	bool restart;			/* see bpf_flow_next_is_no_bound() */
-	bool guards_late;		/* see bpf_flow_loop_gets_guards() */
+	bool guards_late;		/* see bpf_flow_needs_guard() */
 	bool extra_values;		/* a state can have constants that no run has */
 	bool new_linear_xreg;		/* see bpf_same_insns_unproven() */
 	bool seen_direct_write;
@@ -1767,15 +1742,19 @@ static inline int bpf_add_cost_and_check(struct bpf_verifier_env *env, u64 cnt,
 int bpf_flow_prepare(struct bpf_verifier_env *env);
 void bpf_flow_reset(struct bpf_verifier_env *env);
 void bpf_flow_free(struct bpf_verifier_env *env);
+bool bpf_flow_trip_is_new(struct bpf_verifier_env *env, struct loop_stack_entry *entry);
 bool bpf_flow_is_bb_start(struct bpf_verifier_env *env, int insn_idx);
 int bpf_flow_deliver(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 		     int insn_idx, int prev_insn_idx, bool again);
 int bpf_flow_next(struct bpf_verifier_env *env, int *prev_insn_idx, u64 *log_pos, u64 *diag_pos);
+int bpf_flow_needs_guard(struct bpf_verifier_env *env, struct bpf_loop *loop);
 int bpf_flow_call(struct bpf_verifier_env *env, struct bpf_verifier_state *caller,
 		  struct bpf_verifier_state *entry, int subprog, int call_idx);
 int bpf_flow_exit(struct bpf_verifier_env *env, struct bpf_verifier_state *st, int exit_idx);
 void bpf_flow_next_is_no_bound(struct bpf_verifier_env *env, int insn_idx, int h);
 bool bpf_flow_loops_lost_bound(struct bpf_verifier_env *env);
+void bpf_flow_new_pass(struct bpf_verifier_env *env);
+void bpf_flow_drop_guards(struct bpf_verifier_env *env);
 void bpf_flow_new_round(struct bpf_verifier_env *env);
 int bpf_flow_place_guards(struct bpf_verifier_env *env);
 /* verifier.c, for flow.c */
@@ -2099,18 +2078,16 @@ struct bpf_iarray *bpf_insn_successors(struct bpf_verifier_env *env, u32 idx);
 
 /*
  * Where the program goes from may_goto and from the checks that the verifier adds:
- * - May_goto in front of a jump goes where the jump goes, with the registers and the stack
- *   as they are in front of the jump. bpf_insn_successors() has that edge.
+ * - May_goto before a jump goes where the jump goes, with the registers and the stack
+ *   as they are before the jump. bpf_insn_successors() has that edge.
  * - A subprog that is out of budget goes to bail_insn, an exit. No such edge.
- * - May_goto in front of the head of a loop goes to where the loops around it are left: from
+ * - May_goto before the header of a loop goes to where the loops around it are left: from
  *   @idx to what is returned here, -1 if there is none. No such edge either. The registers
- *   and the stack are what they are in front of @idx.
+ *   and the stack are what they are before @idx.
  *
  * The main pass looks at the states that go there. What is computed from the graph before
- * the main pass has to take these edges into account where the main pass believes it:
- * - Against the direction of the edges, liveness: a register that is live at the target is
- *   live at @idx. Stack that is dead at @idx stays dead: a read of it at the target is
- *   rejected.
+ * the main pass has to take these edges into account where the main pass relies on it:
+ * - Against the direction of the edges, liveness: what is live at the target is live at @idx.
  * - In the direction of the edges, bpf_compute_const_regs() and compute_subprog_args(): what
  *   holds on all edges of the graph to the target doesn't hold on this one.
  */
@@ -2459,6 +2436,7 @@ u8 bpf_rev_opcode(u8 opcode);
 int bpf_compute_idoms(struct bpf_verifier_env *env);
 int bpf_compute_loops(struct bpf_verifier_env *env);
 int bpf_loop_at_index(struct bpf_verifier_env *env, u32 idx);
+int bpf_loop_spine_end(struct bpf_verifier_env *env, const struct bpf_loop *loop);
 int bpf_flow_insn_after(struct bpf_verifier_env *env, int idx);
 bool bpf_is_nested_loop(struct bpf_verifier_env *env, int inner_header, int outer_header);
 u32 bpf_loop_thresholds_below(const struct bpf_loop *loop, s64 k);
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 9f816e2818d..4c9f63e096d 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -826,6 +826,9 @@ void bpf_opt_hard_wire_dead_code_branches(struct bpf_verifier_env *env)
 		if (bpf_prog_is_offloaded(env->prog->aux))
 			bpf_prog_offload_replace_insn(env, i, &ja);
 
+		/* If both edges are dead, no run gets here. The driver keeps the old target. */
+		if (!aux_data[i + 1 + ja.off].seen)
+			ja.off = -1;
 		memcpy(insn, &ja, sizeof(ja));
 	}
 }
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index 856d38cc973..c10fa54cdf9 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -262,11 +262,11 @@ static void flow_set_guard(struct bpf_verifier_env *env, int h, int n)
 	aux[h].loop->has_guards = true;
 }
 
-static void flow_place_guards(struct bpf_verifier_env *env, int h, u32 *seen)
+static void flow_place_guards(struct bpf_verifier_env *env, int h)
 {
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
 	struct bpf_loop *loop = aux[h].loop;
-	int i, n, o, t, found = -1;
+	int i, n, o, t;
 
 	if (loop->backedges_overflow)
 		goto header;
@@ -286,20 +286,9 @@ static void flow_place_guards(struct bpf_verifier_env *env, int h, u32 *seen)
 		return;
 	}
 
-	/* seen[n]: the number of back edges that n dominates */
-	for (i = 0; i < loop->backedges_cnt; i++)
-		for (n = loop->backedges[i].from; n >= 0; n = n == h ? -1 : env->idoms[n])
-			seen[n]++;
-	for (n = loop->backedges[0].from; n >= 0 && found < 0; n = n == h ? -1 : env->idoms[n])
-		if (seen[n] == loop->backedges_cnt && bpf_insn_leaves_loop(env, h, n))
-			found = n;
-	for (i = 0; i < loop->backedges_cnt; i++)
-		for (n = loop->backedges[i].from; n >= 0; n = n == h ? -1 : env->idoms[n])
-			seen[n] = 0;
-	if (found >= 0) {
-		flow_set_guard(env, h, found);
-		return;
-	}
+	for (n = bpf_loop_spine_end(env, loop); n >= 0; n = n == h ? -1 : env->idoms[n])
+		if (bpf_insn_leaves_loop(env, h, n))
+			return flow_set_guard(env, h, n);
 
 	for (i = 0; i < loop->backedges_cnt; i++)
 		if (loop->backedges[i].latch < 0)
@@ -385,6 +374,85 @@ bool bpf_flow_loops_lost_bound(struct bpf_verifier_env *env)
 	return false;
 }
 
+/*
+ * A state goes around @loop without a trip count, so the loop gets may_goto. At run time
+ * may_goto is there for all states. This includes states with a trip count, and states that
+ * got to the end of the loop in a peeled trip. A loop before this one can use up the budget
+ * of may_goto. So if a state did not take the edges of may_goto, the pass restarts.
+ */
+int bpf_flow_needs_guard(struct bpf_verifier_env *env, struct bpf_loop *loop)
+{
+	if (loop->rt_bounded)
+		return 0;
+	if (!loop->has_guards) {
+		verbose(env, "loop at insn %d never exits\n", loop->header);
+		return -EINVAL;
+	}
+	if (!loop->this_pass.needs_guard && (env->log.level & BPF_LOG_LEVEL2))
+		verbose(env, "loop at %d has no trip count\n", loop->header);
+	loop->this_pass.needs_guard = loop->guarded = true;
+	env->guards_late |= loop->this_pass.no_guard_edges;
+	return 0;
+}
+
+/* This pass peels more trips. What the last pass found about @loop can be wrong. */
+static void flow_forget_loop(struct bpf_verifier_env *env, struct bpf_loop *loop)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	int i, n = loop->nr_insns;
+
+	loop->changed = loop->guarded = false;
+	bpf_add_cost(env, n, BPF_COST_SCAN);
+	for (i = loop->header; n--; i = bpf_flow_insn_after(env, i)) {
+		if (bpf_loop_at_index(env, i) != loop->header)
+			continue;
+		aux[i].guard_no_unwind = aux[i].guard_unset_reg = false;
+		aux[i].not_stopped = -1;
+	}
+	loop->rt_bounded = flow_loop_is_bounded(env, loop->header);
+}
+
+/* A pass starts. It verifies the main prog and the global functions. */
+void bpf_flow_new_pass(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_flow *flow = env->flow;
+	int i;
+
+	memset(flow->cost, 0, env->subprog_cnt * sizeof(*flow->cost));
+	flow->budget_func_cnt = 0;
+	flow->start_cnt++;
+	for (i = 0; i < env->prog->len; i++, aux++) {
+		if (aux->callback_loop)
+			aux->callback_loop->this_pass = (struct bpf_loop_per_pass){};
+		if (aux->recursion_loop)
+			aux->recursion_loop->this_pass = (struct bpf_loop_per_pass){};
+		if (!aux->loop)
+			continue;
+		/* pass 0 is over */
+		if (flow->start_cnt == 2)
+			aux->loop->guarded = aux->loop->this_pass.needs_guard;
+		aux->loop->this_pass = (struct bpf_loop_per_pass){};
+		if (aux->loop->changed && !env->path_sensitive)
+			flow_forget_loop(env, aux->loop);
+		if (aux->loop->rt_bounded)
+			aux->loop->rt_bounded = flow_loop_is_bounded(env, i);
+	}
+}
+
+/* The pass has no error. A loop needs may_goto only if a state had no trip count. */
+void bpf_flow_drop_guards(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	int i, h;
+
+	for (i = 0; i < env->prog->len; i++) {
+		h = bpf_loop_at_index(env, i);
+		if (h >= 0)
+			aux[i].loop_guard &= aux[h].loop->this_pass.needs_guard;
+	}
+}
+
 /*
  * Which loops have something that stops them at run time, and where may_goto goes in the others.
  * Returns 1 if a place is at the head of a loop.
@@ -394,11 +462,6 @@ int bpf_flow_place_guards(struct bpf_verifier_env *env)
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
 	int len = env->prog->len, h, i, ret = 0, err = 0;
 	struct bpf_loop *loop;
-	u32 *seen;
-
-	seen = kvcalloc(len, sizeof(*seen), BPF_VERIFIER_GFP);
-	if (!seen)
-		return -ENOMEM;
 
 	for (i = 0; i < len; i++) {
 		aux[i].not_stopped = -1;
@@ -416,13 +479,12 @@ int bpf_flow_place_guards(struct bpf_verifier_env *env)
 			break;
 		loop->rt_bounded = flow_loop_is_bounded(env, h);
 		/* also when it's bounded: the main pass may find that it's not */
-		flow_place_guards(env, h, seen);
+		flow_place_guards(env, h);
 		/* pass 0 does not know the trip count before it ends */
 		loop->guarded = loop->has_guards && !bpf_prog_is_offloaded(env->prog->aux);
 		if (aux[h].guard_at_header)
 			ret = 1;
 	}
-	kvfree(seen);
 	return err ?: ret;
 }
 
@@ -976,6 +1038,56 @@ static bool flow_same_entry(struct bpf_loop *loop, const struct flow_state *t,
 	       flow_loop_entry(&t->st, loop)->entry_id == flow_loop_entry(&s->st, loop)->entry_id;
 }
 
+/*
+ * @t subsumes @s. The caller prunes @s, @t continues for it. If @s made more trips it can
+ * come from @t:
+ *
+ *	t --> ... --> header --> ... --> s
+ *	^                                |
+ *	`----------- subsumes -----------'
+ *
+ * A back edge adds a trip and a join has the larger number. So each cycle of states has such
+ * an edge for the outermost loop that it goes around. All pruned states come here.
+ * Speculation ends by itself.
+ *
+ * The loop ends if the trip index k of @s is small each time. That is the trip count:
+ *
+ *  trip count:  guess -> state holds k -> jumps refine k -> k is small ?
+ *                                                           yes: no guard   no: add may_goto
+ *
+ * A loop that can run longer than that gets may_goto.
+ * There is no trip count without CAP_PERFMON (allow_uninit_stack).
+ */
+static int flow_check_trip_counts(struct bpf_verifier_env *env, const struct flow_state *t,
+				  const struct flow_state *s)
+{
+	const struct loop_stack_entry *e;
+	u32 fr, i;
+	u64 max_trip;
+	int err;
+
+	for (fr = 0; fr <= s->st.curframe && !s->st.speculative; fr++) {
+		e = s->st.frame[fr]->loop_stack;
+		for (i = 0; i < s->st.frame[fr]->loop_stack_cnt; i++, e++) {
+			if (e->loop->rt_bounded || e->trip <= t->st.frame[fr]->loop_stack[i].trip)
+				continue;
+			max_trip = cnum64_umax(e->trip_index.r64);
+			if (!e->peeled && max_trip <= BPF_MAX_TRIPS && env->allow_uninit_stack) {
+				/* with may_goto k can start again, see trip_index_safe() */
+				if ((env->log.level & BPF_LOG_LEVEL2) &&
+				    !e->loop->this_pass.needs_guard)
+					verbose(env, "loop at %d has trip count %llu\n",
+						e->loop->header, max_trip + 1);
+				continue;
+			}
+			err = bpf_flow_needs_guard(env, e->loop);
+			if (err)
+				return err;
+		}
+	}
+	return 0;
+}
+
 /* @t is from an earlier walk over a leftover. The header state of @s subsumes that of @t. */
 static bool flow_is_stale(const struct flow_state *t, const struct flow_state *s)
 {
@@ -1036,10 +1148,14 @@ static int flow_prune_or_join(struct bpf_verifier_env *env, struct flow_state *s
 		if (subsumed) {
 			if (env->log.level & BPF_LOG_LEVEL2)
 				verbose(env, "from %d to %d: pruned\n", prev, insn_idx);
+			err = flow_check_trip_counts(env, t, s);
 			goto free;
 		}
 		/* what grows in a loop is widened, it is not replaced */
 		if (!leftover_loop && bpf_state_subsumes(env, &s->st, &t->st)) {
+			err = flow_check_trip_counts(env, s, t);
+			if (err)
+				goto free;
 			/* it goes on with the leftover that @t started */
 			if (s->kind == FLOW_LEFTOVER)
 				bpf_top_loop(s->st.frame[s->st.curframe])->entry_id =
@@ -1082,6 +1198,73 @@ static int flow_prune_or_join(struct bpf_verifier_env *env, struct flow_state *s
 	return err;
 }
 
+/*
+ * @s starts a peeled trip of @loop. Does it repeat the state of an earlier trip? It is compared
+ * with trip 0, 1, 2, 4, 8, ... That finds any period. If @s comes from that state, the verifier
+ * sees no end of the loop. So the loop needs may_goto.
+ * A state that has less than the earlier one can be on its way to the end of the loop:
+ *	for (i = 7; i >= 0; i--) { if (i >= n) continue; ... }
+ * It is pruned for the price of may_goto. So is a state of another entry. If that causes
+ * an error, the next pass sets no_peel_prune.
+ */
+static int flow_prune_peeled(struct bpf_verifier_env *env, struct flow_state *s,
+			     struct bpf_loop *loop)
+{
+	struct loop_stack_entry *entry = flow_loop_entry(&s->st, loop);
+	struct flow_state *t, *tn;
+	u32 trip = entry->trip;
+	int ret = 0;
+
+	entry->trip = 0;
+	s->kind = FLOW_PEELED;
+	flow_for_each_near(env, s, t, tn) {
+		if (!flow_same_join_key(env, t, s) || !bpf_state_subsumes(env, &t->st, &s->st))
+			continue;
+		if (!loop->rt_bounded && !loop->this_pass.needs_guard && !s->st.speculative &&
+		    (!flow_same_entry(loop, t, s) || !bpf_state_subsumes(env, &s->st, &t->st))) {
+			if (loop->no_peel_prune)
+				continue;
+			loop->this_pass.peel_pruned = true;
+		}
+		if (env->log.level & BPF_LOG_LEVEL2)
+			verbose(env, "from %d to %d: pruned\n", s->prev_insn_idx, s->st.insn_idx);
+		entry->trip = trip;
+		ret = flow_check_trip_counts(env, t, s) ?: 1;
+		break;
+	}
+	s->kind = FLOW_AT;
+	entry->trip = trip;
+	return ret;
+}
+
+/*
+ * The current state starts a peeled trip. An earlier trip can have all that it has in the
+ * deps. Then more peeled trips cannot help, and the leftover starts. If the earlier trip
+ * subsumes the full state, the trip counts as new: flow_prune_peeled() prunes it.
+ */
+bool bpf_flow_trip_is_new(struct bpf_verifier_env *env, struct loop_stack_entry *entry)
+{
+	struct flow_state *s = container_of(env->cur_state, struct flow_state, st), *t, *tn;
+	u32 trip = entry->trip;
+	bool is_new = true;
+
+	if (entry->loop->kind == BPF_LOOP_RECURSION || entry->loop->no_peel_prune)
+		return true;
+	entry->trip = 0;
+	s->kind = FLOW_PEELED;
+	flow_for_each_near(env, s, t, tn) {
+		if (!flow_same_join_key(env, t, s) || bpf_values_grew_in_deps(env, &t->st, &s->st))
+			continue;
+		is_new = bpf_state_subsumes(env, &t->st, &s->st);
+		if (is_new)
+			break;
+	}
+	s->kind = FLOW_AT;
+	entry->trip = trip;
+	entry->loop->this_pass.peel_pruned |= !is_new;
+	return is_new;
+}
+
 /* @s is taken. @starts_leftover: the states of FLOW_LEFTOVER are joined, start the leftover */
 static int flow_add(struct bpf_verifier_env *env, struct flow_state *s, bool starts_leftover)
 {
@@ -1103,6 +1286,10 @@ static int flow_add(struct bpf_verifier_env *env, struct flow_state *s, bool sta
 	/* a pointer to the packet that moves in the loop got an id */
 	if (!err && env->id_gen != id_gen)
 		err = bpf_renumber_ids(env, &s->st);
+	if (!err && env->path_sensitive) {
+	} else if (!err && loop && flow_loop_entry(&s->st, loop)->peeled) {
+		err = flow_prune_peeled(env, s, loop);
+	}
 	if (err) {
 		flow_free_state(env, s);
 		return min(err, 0);
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 7b00e17cab2..23a66b22393 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -418,6 +418,7 @@ static inline bool update_insn(struct bpf_verifier_env *env, struct func_instanc
 	unsigned long *may_read, *must_write, *live_before;
 	struct frame_masks *fm = instance->frames[frame];
 	u32 rel = relative_idx(instance, insn_idx);
+	int t = bpf_head_guard_target(env, insn_idx);
 	struct bpf_iarray *succ;
 	bool changed = false;
 	u32 s, w;
@@ -445,6 +446,8 @@ static inline bool update_insn(struct bpf_verifier_env *env, struct func_instanc
 	for (w = 0; w < fm->words; w++) {
 		unsigned long new_before = (new_after[w] & ~must_write[w]) | may_read[w];
 
+		if (t >= 0)
+			new_before |= rel_mask(fm, relative_idx(instance, t), before)[w];
 		if (new_before != live_before[w]) {
 			live_before[w] = new_before;
 			changed = true;
diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
index bb8cb4fedc5..fafef3dec49 100644
--- a/kernel/bpf/loops.c
+++ b/kernel/bpf/loops.c
@@ -310,6 +310,16 @@ static int check_loop_depth(struct bpf_verifier_env *env, int idx)
 	return 0;
 }
 
+/* The last insn that dominates all back edges of @loop */
+int bpf_loop_spine_end(struct bpf_verifier_env *env, const struct bpf_loop *loop)
+{
+	int i, n = loop->backedges[0].from;
+
+	for (i = 1; i < loop->backedges_cnt; i++)
+		n = idoms_intersect(env, n, loop->backedges[i].from);
+	return n;
+}
+
 /*
  * The backedge->from and its latch can reside in an inner loop of @h, e.g.:
  *
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b6de3447b08..fac44fceccf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -196,7 +196,6 @@ struct bpf_verifier_stack_elem {
 	struct bpf_verifier_state st;
 	int insn_idx;
 	int prev_insn_idx;
-	enum bpf_guard_edge guard_edge;
 	bool again;	/* see bpf_flow_deliver() */
 	struct bpf_verifier_stack_elem *next;
 };
@@ -20959,6 +20958,9 @@ static int next_trip(struct bpf_verifier_env *env, struct loop_stack_entry *entr
 	}
 	if (!entry->peeled)
 		return check_held_in_leftover(env, entry);
+	*starts_leftover = !bpf_flow_trip_is_new(env, entry) || !try_peel_trip(entry);
+	if (*starts_leftover)
+		entry->entry_id = ++env->loop_entry_cnt;
 	return 0;
 }
 
@@ -21155,87 +21157,79 @@ static int push_unwind_exit(struct bpf_verifier_env *env)
 }
 
 /*
- * The loop that is not counted and has nothing that stops it at run time gets
- * may_goto in front of this insn. When it is out of budget the program goes
- * where may_goto goes with the registers and the stack as they are here.
- * Every state that goes through the loop does, see bpf_flow_loop_gets_guards().
+ * A loop has no trip count, and nothing stops it at run time. It gets may_goto
+ * before this insn. When may_goto is out of budget, the program goes to its
+ * target with the registers and the stack that it has here.
+ * Every state that goes through the loop does that, see bpf_flow_needs_guard().
  */
 static int check_loop_guard(struct bpf_verifier_env *env)
 {
 	struct bpf_insn_aux_data *aux = &env->insn_aux_data[env->insn_idx];
-	struct bpf_verifier_state *branch;
-	struct bpf_func_state *frame = cur_func(env);
-	struct loop_stack_entry *entry;
 	struct bpf_loop *loop;
-	int h, err;
+	int err;
 
-	h = bpf_loop_at_index(env, env->insn_idx);
 	/* The callback came back to the helper that calls it: the program is not in front of it. */
-	if (h < 0 || !frame->loop_stack_cnt || frame->callback_depth)
+	if (!aux->guard_place || cur_func(env)->callback_depth)
 		return 0;
-	loop = env->insn_aux_data[h].loop;
-	entry = &frame->loop_stack[frame->loop_stack_cnt - 1];
-	if (loop->rt_bounded || !env->insn_aux_data[env->insn_idx].guard_place ||
-	    entry->loop_id != h)
+	loop = env->insn_aux_data[bpf_loop_at_index(env, env->insn_idx)].loop;
+	if (loop->rt_bounded)
 		return 0;
-	if (verifier_bug_if(!entry->terminates && !entry->guarded, env,
-			    "nothing stops the loop at %d", h))
-		return -EFAULT;
-	if (!entry->guarded && !bpf_loop_walk_may_give_up(entry))
+	if (!(env->path_sensitive ? loop->infinite : loop->guarded)) {
+		loop->this_pass.no_guard_edges = true;
 		return 0;
+	}
 
+	env->imprecise |= !env->err;
 	/* the device runs the insns that the driver was given, without may_goto */
 	if (bpf_prog_is_offloaded(env->prog->aux)) {
-		verbose(env, "loop at insn %d has no known bound in an offloaded program\n", h);
+		verbose(env, "loop at insn %d has no known bound in an offloaded program\n",
+			loop->header);
+		env->cur_state->suspect_loops |= loop->suspect_bit;
 		return -EINVAL;
 	}
 
 	/*
-	 * A guard has one way out, and only that one is looked at.
+	 * A guard has one way out, and only that one is verified.
 	 *
 	 * Leave the subprog, if that is possible every time the program gets here:
 	 *	do { p = lookup(); } while (!p); *p
-	 * The code that follows the loop counts on what the jump that leaves it has found out.
+	 * The code after the loop relies on the result of the jump that leaves it.
 	 *
 	 * Otherwise leave the loop:
 	 *	lock(); do { ... } while (...); unlock();
-	 * The code that follows the loop releases what is held.
+	 * The code after the loop releases what is held.
 	 *
-	 * From the head of a loop to where the loop is left is not an edge of the program:
+	 * The program has no edge from the header of a loop to the exit of the loop:
 	 *	for (;;) { c = *s++; if (!c) return 0; if (c == '*') return 1; }
-	 * The loop is left to 'exit', and only its body sets r0. Leave the subprog then, with
+	 * The loop is left to 'exit', and only its body sets r0. Then leave the subprog. Use
 	 * a plain exit if it cannot unwind, like check_recursion_guard().
 	 *
-	 * It's the same way for all states that get here. As long as they leave the subprog
-	 * what would leave the loop is dropped. Both are dropped as long as the loop has
-	 * no may_goto: the state is in a walk that may get to the end of the loop.
+	 * All states that get here take the same way, or the pass starts again.
+	 * A speculative state does not select the way.
 	 */
+	if (env->cur_state->speculative)
+		goto out;
 	if (aux->guard_at_header && !aux->guard_unset_reg && guard_reads_unset_reg(env, aux)) {
 		aux->guard_unset_reg = true;
-		/* The states that were here left the loop. All again. */
-		if (aux->guard_no_unwind)
-			env->guards_late = true;
+		env->guards_late |= aux->guard_no_unwind && aux->loop_guard;
 		aux->guard_no_unwind = false;
 	}
 	if (!aux->guard_no_unwind &&
 	    !state_can_unwind(env, env->cur_state, aux->guard_unset_reg)) {
+		env->guards_late |= aux->loop_guard;
 		aux->guard_no_unwind = true;
-		/* What would leave the loop from the states that were here is gone. All again. */
-		if (aux->guard_edge_dropped && loop->guarded)
-			env->guards_late = true;
 	}
-	if (!aux->guard_no_unwind) {
+out:
+	aux->loop_guard = true;
+	aux->guard_unwinds = !aux->guard_no_unwind;
+	if (aux->guard_no_unwind)
+		err = PTR_ERR_OR_ZERO(push_stack(env, aux->guard_to, env->insn_idx, false));
+	else
 		err = push_unwind_exit(env);
-		if (err)
-			return err;
-		env->head->guard_edge = BPF_GUARD_LEAVES_SUBPROG;
-	}
-
-	branch = push_stack(env, env->insn_aux_data[env->insn_idx].guard_to, env->insn_idx, false);
-	if (IS_ERR(branch))
-		return PTR_ERR(branch);
-	env->head->guard_edge = BPF_GUARD_LEAVES_LOOP;
-	return 0;
+	/* more peeled trips can show that the edge is dead */
+	if (!err && env->head)
+		env->head->st.suspect_loops |= loop->suspect_bit;
+	return err;
 }
 
 /* The states that the insn pushed go where they were pushed to. */
-- 
2.55.0

