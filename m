Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160856;
	b=lQY+ioRzQL9a9CctX1t8SW/h2lSl3qjqP7H5O+MeCeqsA6UqYkYv9bXA9O9qQ3u0LMAB
	 epwNiEKhfw6GNARRNqjGUHmlQIHUmWqS7yBD1qGSSv0ySOCOv80PKphJFLczVCQriDboS
	 liMz7fAYZEry50/DcB7Qr+t/LAf6qo1UcYM9N6zpmVzWnXt1V/DV0vM6GLW1yb0Pyp00s
	 mz/OjXLdmKrIJmUA1KJAL2yljwcivGHAtydpCNSeyHGZL3kx6aIHr6ZXYRSg4vHukrxx8
	 6gx4Fu+xdLMeE5FkQrCMb+cfR6HXF2XY03USaSeILuPlTSbLgBC/kv0vDJWOscl26Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=udtnG4pHTFvkZzEgmpz05P7hm2p8nLYsqDRZ8VVupAo=;
	b=0zY20/jrU33TeuovF7fdtGgKL7+ubYL4rVNuscfAP1rowxUH04t6mQp1aV9WteGLsqF5
	 nnbr/OnZRO+VWt02sSmHAaB3pQJa7uQCTdj8qkA1uOq0gchJtgqVjd6ogKXnL388FWhqx
	 KFwhAn+rVYFKhe7muZhBuK7pocfoDnzofYKqknoen2W06aOYQxuO+5s4YrGkwoirT5IyN
	 Mbsh9mQ03qtwQtpIvo1v+Ir91sZBz6KHRJ6jjGH6N7Zv2Q3QpIE+4whrLgI4BmNZJ2IRD
	 axeCtDvu8gtqjXUxWqKU4+z/zabFT4JjVnYOIelVk2Hk1VOeMudjJhdMDBWxb62G/Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N4nZFaC5;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F92606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6F92606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N4nZFaC5
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f037bc348dso5197505ad.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160855; x=1795765655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=udtnG4pHTFvkZzEgmpz05P7hm2p8nLYsqDRZ8VVupAo=;
        b=N4nZFaC5Hoew1MuktuVDRRE+RI+1QOQLZMRnu8Fm2SS3qzX/GkGwCPc9iAP10cQQlf
         Ob+RRGhN6br1EeJHte8R9w6HisG6Z2xOu6YDxdPur3tYWFIhv3eWCydZix9UYMxIc7kd
         b+CTP+E46ZcH/z79eY154JTP1ppm+Tffr0ozQMCjNsfk7XIpgVk85ouORVxxgY23O564
         r09jWvamvUjTYoURgKPke7AXEmmXw7RmcRhwVGp0WUMCMA9gSOqS7uINouT6OMxfLTrI
         islfm7MvDG0rp7AXK8NMytZt5HmnumWjGFYIGGfkUO1vVJGGtaMbL822GCJk4Bt9qfEv
         9mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160855; x=1795765655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=udtnG4pHTFvkZzEgmpz05P7hm2p8nLYsqDRZ8VVupAo=;
        b=vDOUuK7P0IyowjkO+HyT2omX7lpBZ/X6wYc+vLK7+DmqkEqzG8J7GwUZjHa2zjYmDq
         Yz5ttRRq3PDLP25cdPuN1HdCrpbSA2z6SaRySyPz4+CrnzrbOwpAg/PfrWG3K7B0iFWt
         0fn+iAIJxOYl2AC6JhvqpvbwChh68oT23n1L10DClYT8aQtT/0ABldQaKJfTnKypLi/J
         YXW1vInaj6ZUqheA+etRwZ2xZllYE+Gc/ZtoZQ7RHSDSPLBywz4YVvH+FrCVo6o6zBkf
         R1lo1ZR9/NOuozI7qMGtnPm1vWrPQgk5gfQpvuBiRnqO/aX5n21zijmwly3ZAoB7m6Af
         wXXw==
X-Gm-Message-State: APuU4Z9IDSdybx7MAz12gRzjv7JOwF8TDENDmDDaSJBnydbgFCesWzFL
	iXgA7LMO1UIjs6HruSzfIE46LRCIzjsipcV4uINz1UXCcIR7AzH4xOh6wsUKDQ==
X-Gm-Gg: AZFdTZcXE8t2jDDoZ+DAf+C2z2drQB/H/52BQJLE0reyx/JqnHP+unfLOWCckNso+lH
	LASMKtA5VP/JLEvfGoCbGJzkIqZiN1JvJH8/MqlMbDg05uql8KTZGOqB/eSG4qEnYBc5U/LWWKy
	AbbCirMyBfHs6JAlFyJW0dBKpwt1JvPmF6FxhugMbo7D3t8RFqR5zUhaS+OJNODQxe7Cweivsvf
	rmk0wbu1y3pXXtkr2zqhp+u3tGC7+BYbOmf7LbTl3kNJN79ekPVHpXlyeK6NimfcQRAmsNGHpQU
	3ZEmfZ0QAI4u7mEcB/gwPfXzOrQUCrpieS7Era3GxNoZNcaRCCGw6Wdzd/K1gSVWB1YYFPHPQp/
	mO17ucKqaK0Ps2pR1z6mX1ScozqXm5otYbKw6fyPxHUm7XKNUmNYdU/xoFVmQP04incn1t8vAqo
	ubNBH8aVCIX8c2A/l06iVYNpOt/4k38LsuG5ys0AtPRvljJElMcChlrXlbd94Mv/o04ezs0apxF
	4AiINfgGnHtkzxdEgX3j7dbQmvlX0cuz6FWH/ebiNFI6uoIF668lfK6fBJt5PqoFYbVW/1slk5/
	OpFVcYpLL1DlZIjFvfYYAqfZ0vMi1XGC7RAQjvfhGjbp8aj6hOi00bC62m8hwC2KRQHrL0qA8+S
	SikZ4EFGhB+BBPb8s5bgGAl4+yNQXNyU8VfVn92pY+noX6hrMg8KEIQgf3Leyzv+IVI1jtupWeL
	4B3tFzEqxuCCWbQY8i+TQ=
X-Received: by 2002:a17:902:e803:b0:2ef:effd:4606 with SMTP id d9443c01a7336-2f03efb019emr26098435ad.2.1795160854920;
        Thu, 19 Nov 2026 23:47:34 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0dcbe3sm10574375ad.28.2026.11.19.23.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:47:34 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 31/49] bpf: Give a loop a checked trip count or may_goto
Date: Fri, 20 Nov 2026 07:42:03 +0000
Message-ID: <20261120074430.2704488-32-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
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
may_goto, see flow_prune_peeled().

may_goto at a header skips the body. So a slot that is live at its
target is live at the header.

bpf_loop_spine_end() finds the insns that dominate all back edges. It
replaces the counters in flow_place_guards().

If both edges of a jump are dead, no run gets to the jump. It becomes
'goto -1'.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  27 +++--
 kernel/bpf/fixups.c          |  24 ++--
 kernel/bpf/flow.c            | 225 +++++++++++++++++++++++++++++++----
 kernel/bpf/liveness.c        |   3 +
 kernel/bpf/loops.c           |  13 ++
 kernel/bpf/verifier.c        |  85 ++++++-------
 6 files changed, 285 insertions(+), 92 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index be499471e12..2d4d8531ced 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -839,7 +839,9 @@ enum bpf_loop_kind {
 /* What a pass finds about a loop */
 struct bpf_loop_per_pass {
 	bool needs_guard;	/* see bpf_flow_needs_guard() */
+	bool no_guard_edges;	/* a state did not take the edges of may_goto */
 	bool has_leftover;	/* the peeled trips were not enough */
+	bool peel_pruned;	/* see flow_prune_peeled() */
 	/* a check failed in a state that the loop kept apart, with no other suspect */
 	bool has_unproven;
 	u32 last_peeled_trip;	/* see flow_keep_peeled() */
@@ -872,11 +874,14 @@ struct bpf_loop {
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
@@ -951,6 +956,7 @@ struct bpf_insn_aux_data {
 	u64 cast_arena:1; /* addr_space_cast of an address in arena */
 	u64 cast_mov:1; /* addr_space_cast of a pointer that is not in arena, it's a move */
 	u64 loop_guard:1; /* may_goto is added in front of this instruction */
+	u64 guard_unwinds:1; /* it leaves the subprog */
 	u64 speculative_first:1; /* a speculative state came to it first */
 	u64 call_recorded:1; /* see record_call_fixup() */
 	u64 pessimized:1; /* see bpf_partition_for_pessimized() */
@@ -1366,7 +1372,7 @@ struct bpf_verifier_env {
 	bool imprecise;			/* a state before the first error is imprecise */
 	bool over_limit;		/* see bpf_check_limits() */
 	bool restart;			/* see bpf_flow_next_is_no_bound() */
-	bool guards_late;		/* see bpf_flow_loop_gets_guards() */
+	bool guards_late;		/* see bpf_flow_needs_guard() */
 	bool extra_values;		/* a state can have constants that no run has */
 	bool seen_direct_write;
 	/* a register may point to the stack and is not PTR_TO_STACK, see bpf_reg_state::buf */
@@ -1734,15 +1740,19 @@ static inline int bpf_add_cost_and_check(struct bpf_verifier_env *env, u64 cnt,
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
 int bpf_flow_place_guards(struct bpf_verifier_env *env);
 /* verifier.c, for flow.c */
 int bpf_flow_loop_enter(struct bpf_verifier_env *env, struct bpf_loop **backedge_loop,
@@ -2065,18 +2075,16 @@ struct bpf_iarray *bpf_insn_successors(struct bpf_verifier_env *env, u32 idx);
 
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
@@ -2425,6 +2433,7 @@ u8 bpf_rev_opcode(u8 opcode);
 int bpf_compute_idoms(struct bpf_verifier_env *env);
 int bpf_compute_loops(struct bpf_verifier_env *env);
 int bpf_loop_at_index(struct bpf_verifier_env *env, u32 idx);
+int bpf_loop_spine_end(struct bpf_verifier_env *env, const struct bpf_loop *loop);
 bool bpf_is_nested_loop(struct bpf_verifier_env *env, int inner_header, int outer_header);
 u32 bpf_loop_thresholds_below(const struct bpf_loop *loop, s64 k);
 int bpf_loop_collect_thresholds(struct bpf_verifier_env *env, struct bpf_loop *loop);
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index ccde914c57a..4c9f63e096d 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -608,18 +608,14 @@ static int emit_unwind_exit(struct bpf_verifier_env *env, int s, struct bpf_insn
 int bpf_insert_loop_guards(struct bpf_verifier_env *env)
 {
 	struct bpf_insn patch[2] = { BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 0, 0) };
-	struct bpf_insn leave[3] = { BPF_MOV64_IMM(BPF_REG_0, 0) };
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_insn leave[4], *insn;
 	struct bpf_subprog_info *sub;
-	struct bpf_insn *insn;
 	int i, s, n, err;
-	bool leaves;
 
 	for (s = 0; s < env->subprog_cnt; s++) {
 		sub = &env->subprog_info[s];
-		n = bpf_ret_reg_pair(env, s) ? 3 : 2;
-		leaves = false;
-		for (i = sub->start; i < sub[1].start; i++) {
+		for (i = sub->start, n = 0; i < sub[1].start; i++) {
 			if (!aux[i].loop_guard)
 				continue;
 			/* A jump to itself is a back edge. It goes through may_goto too. */
@@ -627,16 +623,15 @@ int bpf_insert_loop_guards(struct bpf_verifier_env *env)
 			insn = bpf_patch_list_add(env, i, patch, 2);
 			if (IS_ERR(insn))
 				return PTR_ERR(insn);
-			if (aux[i].guard_no_unwind)
+			if (!aux[i].guard_unwinds) {
 				bpf_patch_list_jump(&env->patch_list, insn - 1, aux[i].guard_to, 0);
-			else
-				bpf_patch_list_jump(&env->patch_list, insn - 1, sub[1].start, n);
-			leaves |= !aux[i].guard_no_unwind;
+				continue;
+			}
+			n = emit_unwind_exit(env, s, leave);
+			bpf_patch_list_jump(&env->patch_list, insn - 1, sub[1].start, n);
 		}
-		if (!leaves)
+		if (!n)
 			continue;
-		leave[1] = BPF_MOV64_IMM(BPF_REG_2, 0);
-		leave[n - 1] = budget_exit_insn(env, sub);
 		err = bpf_patch_list_append(env, i - 1, leave, n);
 		if (err)
 			return err;
@@ -831,6 +826,9 @@ void bpf_opt_hard_wire_dead_code_branches(struct bpf_verifier_env *env)
 		if (bpf_prog_is_offloaded(env->prog->aux))
 			bpf_prog_offload_replace_insn(env, i, &ja);
 
+		/* If both edges are dead, no run gets here. The driver keeps the old target. */
+		if (!aux_data[i + 1 + ja.off].seen)
+			ja.off = -1;
 		memcpy(insn, &ja, sizeof(ja));
 	}
 }
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index d31a689471e..2acf85a10d4 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -244,11 +244,11 @@ static void flow_set_guard(struct bpf_verifier_env *env, int h, int n)
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
@@ -268,20 +268,9 @@ static void flow_place_guards(struct bpf_verifier_env *env, int h, u32 *seen)
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
@@ -367,6 +356,86 @@ bool bpf_flow_loops_lost_bound(struct bpf_verifier_env *env)
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
+	flow->budget = bpf_precision_budget(env);
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
@@ -376,11 +445,6 @@ int bpf_flow_place_guards(struct bpf_verifier_env *env)
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
@@ -398,13 +462,12 @@ int bpf_flow_place_guards(struct bpf_verifier_env *env)
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
 
@@ -963,6 +1026,55 @@ static bool flow_same_entry(struct bpf_loop *loop, const struct flow_state *t,
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
+			if (e->loop->kind != BPF_LOOP_JUMPS ||
+			    e->trip <= t->st.frame[fr]->loop_stack[i].trip)
+				continue;
+			max_trip = cnum64_umax(e->trip_index.r64);
+			if (!e->peeled && max_trip <= BPF_MAX_TRIPS && env->allow_uninit_stack) {
+				if (env->log.level & BPF_LOG_LEVEL2)
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
@@ -1068,6 +1180,73 @@ static int flow_prune_or_join(struct bpf_verifier_env *env, struct flow_state *s
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
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index c9fea08eada..59976ae6999 100644
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
index 23c443ab3a2..deda85d0953 100644
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
@@ -627,6 +637,9 @@ int bpf_loop_collect_thresholds(struct bpf_verifier_env *env, struct bpf_loop *l
 	if (!todo)
 		return -ENOMEM;
 	done = todo + words;
+	/* the insns of a loop follow its header, see flow_compute_order() */
+	i = loop->header;
+	n = loop->kind == BPF_LOOP_CALLBACK ? 1 : loop->nr_insns;
 	for (;;) {
 		err = err ?: bpf_add_cost_and_check(env, n, BPF_COST_XREG);
 		for (; n-- && i >= 0 && i < sub[1].start && !err; i = bpf_flow_insn_after(env, i)) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bf26a6dc87d..6373505c672 100644
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
@@ -21155,87 +21154,79 @@ static int push_unwind_exit(struct bpf_verifier_env *env)
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
@@ -21602,8 +21593,8 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 	}
 }
 
-/* All is done again, whatever came out, see do_check_all() */
-static bool round_is_dropped(struct bpf_verifier_env *env)
+/* What the pass assumed about loops does not hold, see do_check_all() */
+static bool pass_needs_restart(struct bpf_verifier_env *env)
 {
 	return (env->restart && bpf_flow_loops_lost_bound(env)) || env->guards_late;
 }
-- 
2.55.0

