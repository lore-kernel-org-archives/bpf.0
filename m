Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022825;
	b=iHvMrzx7lrUNzjEp/BNnwUTFi63TfMp9bvFCn/l8nyfia0IGyttt/C5RDrozE9RVcf92
	 +CpkK7QKLVPfns37YPKhp+6dXae5IEXhCyDnOfYPqgknaxlxczokZG16HdzFa7fQiwjmB
	 7f2UTZwyNOY5Uvkypa/8wnlrvk0uhf3fJaZ1WHzpDBUp1Plf71ZlLQQxAFRUNYXFUEpg1
	 +HS5hLU+lHp6j1IdovINl2kjWpQWTkjPOXKoeOHqsfCGAyOw6Rztldufl6OKvsUwlukxy
	 e06WT3Y0T+iERKVzzsIW9bHlFYTiGda3jIU9GiYvWXSlZ4WgHR5N9Na+9TF7PXBkl7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=enT5W1+LJf56wVu/RRY/hq4eiPolUt/LgiE00mWcVgc=;
	b=TeHE7PHWA+VoL5W9b2eiFOgyDmfaFKgS6qUf98vLDeP+HHePEYmPkMZBmBwfQxQ5QyVo
	 PZTOpJOlWOk8bqctVvpIWLhF7NkwJdo6jJyK/2m2Tq9D7wceQJq/zcznHpJrY83p858GK
	 5JxG5JCckH8kEVUifiWdGiegbvUWt3KGmUZIPipowMidL5Mm9905EIq3TFVjNFQLJSJpm
	 ZfWcojItZQF9v1Z1fZOHxIKVr0MTRg8P3W4CLSK6xWaCL68lATCMTBZOASw/Vzk84VHNA
	 f2YZZuEfV4it1qNXfPBRaM6jAaPhbgglPD8ssy8VERxKzppWJeC/XuISR1gXhsMb82A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y6s2AKRT;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C51606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5C51606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y6s2AKRT
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e946155442so10314955ad.3
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022823; x=1794627623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=enT5W1+LJf56wVu/RRY/hq4eiPolUt/LgiE00mWcVgc=;
        b=Y6s2AKRT8gSo25z7T+bVA5UNYWAeRFHH9SFjsf5nnGab0XCp1Ob/ET9U79olTBNtCE
         6XJU7sHdul/4zrAPhKng5XF7+l8FNVXXrJA9bchBhJh0LN1ONk1an27alUXLqzXdOzxb
         iWvnNmkrd0DxSBR/AiBGoSz9TTGItYuhg37TOs4l/9ODnk/9NbQkVqPFNeVm9lioS0hf
         O0o2U3n52aWCF2RfKHtqj/LLPVxpnUzWdvin/XimbV3YNrInxdCtHs/EMA+lXwKkedsf
         3U8kHWLIqa8T92ykl32buFkrcuRQGdzeJT4WJM763ljPHQ3WEBVXjpOT1dAlZ/mU+jKz
         Zg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022823; x=1794627623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=enT5W1+LJf56wVu/RRY/hq4eiPolUt/LgiE00mWcVgc=;
        b=S+Y4K/ivexJpZPT6d8rpxgCHPF0KdrD44y5DK6k9fDJI7Z0Taa348mggZhos5t/HZg
         2fbpzOnvAouzp3i+5TKsSKJ7zXhYodhFUc1hHCRMeAxiLr3x5cnD2zsTI8HGI4HCP3xN
         Xdl0sluFF+aWF1BFPYdIOlGaQJvaqcDHP09Dm/OHwYRZh6LLQruD/OeMadbQbzoffxNb
         CiCP02C0BBu/+mAdAHs8lNhBvmeUj2u3JUq9HUGK7IuF+zx4ckyWz22X19N5wf+JKLQV
         SOBgQsOmUfS2iRSxhaimCgKIHoCh3WVmUmWC840H3SoELY1r1SLS3rmjHEkH8G1I5DfJ
         Okng==
X-Gm-Message-State: APuU4Z98QY+2lj5cGs8cPSY8/uhzZRKrgU2Y7OA+Fmgn8Rrt9pZxAYsK
	JSUVlA6lUpmah9iLC32msP9IPqncYE/TVFENNklnEVGaSkSYsbfg1NS/iBs4jg==
X-Gm-Gg: AYBFou0+Ir2fCMqgEhhN2JHq34C+C+ZDzb6TW7sgsIzZoz0j5/lBjwMNp/0oJoTR4mm
	ZCbDBVeC12EmA3SMme1pWdXO3Pxstc3prvlS0F4mGqFezQ6KZdOBXxZu+Lyng1K7B0o56XZJnB9
	fBhDgFmTBznSlHaljcWporDNqYe5vj1ViO42INoUJL6i2jcKuDhOmGKV6Z8HBpKZGo4PjVXJBwk
	IEbVwydbS2anHkZs+9OG+1xtEXQnmcRvPinT/0NmFecxmelnH1pyniR+EIVkWR8+RLiLNKBvGs+
	TYR7t76acwVH3IlcGxaOqSBvhYdanpjqTho9qSMaXbSa7MEw89IxXnF30hwjpxe3oTOYlP9eOqg
	87qD84xwdZW/xM/POgJITHRdw2qdJVWMCjH4a4YUwga2aFK1/hJg2+x48xNzYuJjVl4d5bceadt
	n6rWQcNuD36jTJm5DTU+zz6qFPzH598qNRHQOay2rVZxBH+NRiREOwn1AfXZkBuO/7VrafBW8KO
	n/cWzXbiOGd7uUp0tgOf+RGsYoLPd5tsPFkaBb5RJHz4mE60CYyElnJ/EOWO7QuIEkYINoMQqwg
	1nw1deQQefL1Zkmuh390zsGaaYbvmHcwUbST7wKAT55wFaqnV/1DX0Pq62IKBa4YXX08Yl7yAW5
	357kDXBh7mvgFiBTKghb+2zMwY+fP6nsg/tgsRaCS2BvSKqGKu0Z+Dm5PKWnLhHPtxA+AzRklib
	g=
X-Received: by 2002:a17:90b:314e:b0:3ac:da41:ef7e with SMTP id 98e67ed59e1d1-3b0db70531fmr4739869a91.52.1794022822009;
        Fri, 06 Nov 2026 19:40:22 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0fc487e05sm1220787a91.1.2026.11.06.19.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:40:21 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 23/46] bpf: Remove is_state_visited(), bpf_compute_scc() and iter.depth
Date: Sat,  7 Nov 2026 03:37:31 +0000
Message-ID: <20261107033758.1547725-24-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
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

is_state_visited() is the pruning of a verifier that follows each path of
a prog. It saves states at selected insns and stops a path when a saved
state covers the current state. The main pass is in flow.c now. Each insn
that starts a basic block has a set of states, and a state that arrives is
dropped, joined or added. Nothing calls is_state_visited().

Remove it, and all that exists only for it: 1550 lines.

  removed                     task in the old pass     what does it now
  --------------------------  -----------------------  --------------------
  explored_states, free_list  Hold the saved states.   The sets of states
                                                       in flow.c.
  branches, dfs_depth,        Tell when all paths      No paths. The pass
  equal_state                 from a state are         ends when no set has
                              explored.                a new state.
  bpf_compute_scc(), SCC      Bring precision marks    The marks are not
  visits, backedges           over the back edges of   used. loop_header
                              a loop.                  tells the loops.
  states_maybe_looping(),     Reject a path that       The verifier adds
  iter.depth                  comes back in the same   may_goto to a loop
                              state.                   that it cannot
                                                       bound.
  widen_imprecise_scalars(),  Make a loop with an      A loop that is not
  callback_unroll_depth,      iterator, a callback or  counted is walked,
  may_goto_depth              may_goto converge.       or widened at its
                                                       head.
  bpf_split_cur_state()       Save the state that      flow.c keeps the
                              enters a counted loop.   states that enter.

What user space sees:
 - BPF_F_TEST_STATE_FREQ told is_state_visited() to save a state each time.
   The flag is UAPI and selftests set it. The kernel accepts it as before,
   and it has no effect.
 - The "Program dump" of log level 2 has no scc column.
 - The log does not print "depth=" for an iterator.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 123 +----
 kernel/bpf/cfg.c             | 198 -------
 kernel/bpf/log.c             |   5 +-
 kernel/bpf/states.c          | 998 -----------------------------------
 kernel/bpf/verifier.c        | 240 +--------
 5 files changed, 8 insertions(+), 1556 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 993d8241f6f3..902a339b0caf 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -119,7 +119,6 @@ struct bpf_reg_state {
 			u32 btf_id;
 			/* packing following two fields to fit iter state into 16 bytes */
 			enum bpf_iter_state state:2;
-			int depth:30;
 			/*
 			 * The number of loops, in all frames, that the program was in
 			 * when it made the iterator, see iter_stops_loops().
@@ -568,52 +567,6 @@ struct bpf_verifier_state {
 	struct bpf_verifier_state *parent;
 	/* Acquired reference states */
 	struct bpf_reference_state *refs;
-	/*
-	 * 'branches' field is the number of branches left to explore:
-	 * 0 - all possible paths from this state reached bpf_exit or
-	 * were safely pruned
-	 * 1 - at least one path is being explored.
-	 * This state hasn't reached bpf_exit
-	 * 2 - at least two paths are being explored.
-	 * This state is an immediate parent of two children.
-	 * One is fallthrough branch with branches==1 and another
-	 * state is pushed into stack (to be explored later) also with
-	 * branches==1. The parent of this state has branches==1.
-	 * The verifier state tree connected via 'parent' pointer looks like:
-	 * 1
-	 * 1
-	 * 2 -> 1 (first 'if' pushed into stack)
-	 * 1
-	 * 2 -> 1 (second 'if' pushed into stack)
-	 * 1
-	 * 1
-	 * 1 bpf_exit.
-	 *
-	 * Once do_check() reaches bpf_exit, it calls update_branch_counts()
-	 * and the verifier state tree will look:
-	 * 1
-	 * 1
-	 * 2 -> 1 (first 'if' pushed into stack)
-	 * 1
-	 * 1 -> 1 (second 'if' pushed into stack)
-	 * 0
-	 * 0
-	 * 0 bpf_exit.
-	 * After pop_stack() the do_check() will resume at second 'if'.
-	 *
-	 * If is_state_visited() sees a state with branches > 0 it means
-	 * there is a loop. If such state is exactly equal to the current state
-	 * it's an infinite loop. Note states_equal() checks for states
-	 * equivalency, so two states being 'states_equal' does not mean
-	 * infinite loop. The exact comparison is provided by
-	 * states_maybe_looping() function. It's a stronger pre-check and
-	 * much faster than states_equal().
-	 *
-	 * This algorithm may not find all possible infinite loops or
-	 * loop iteration count may be too high.
-	 * In such cases BPF_COMPLEXITY_LIMIT_INSNS limit kicks in.
-	 */
-	u32 branches;
 	u32 insn_idx;
 	u32 curframe;
 
@@ -648,10 +601,6 @@ struct bpf_verifier_state {
 	 */
 	u32 first_insn_idx;
 	u32 last_insn_idx;
-	/* if this state is a backedge state then equal_state
-	 * records cached state to which this state is equal.
-	 */
-	struct bpf_verifier_state *equal_state;
 	/* jmp history recorded from first to last.
 	 * backtracking is using it to go from last to first.
 	 * For most states jmp_history_cnt is [0-3].
@@ -659,9 +608,6 @@ struct bpf_verifier_state {
 	 */
 	struct bpf_jmp_history_entry *jmp_history;
 	u32 jmp_history_cnt;
-	u32 dfs_depth;
-	u32 callback_unroll_depth;
-	u32 may_goto_depth;
 };
 
 /* Number of BPF_REG_SIZE stack slots tracked for the frame so far. */
@@ -761,15 +707,6 @@ static inline bool bpf_stack_args_are_incoming(const struct bpf_func_state *fram
 						1 << STACK_SPILL, __expr);	\
 	})
 
-/* linked list of verifier states used to prune search */
-struct bpf_verifier_state_list {
-	struct bpf_verifier_state state;
-	struct list_head node;
-	u32 miss_cnt;
-	u32 hit_cnt:31;
-	u32 in_free_list:1;
-};
-
 struct bpf_loop_inline_state {
 	unsigned int initialized:1; /* set to true upon first entry */
 	unsigned int fit_for_inline:1; /* true if callback function is the same
@@ -984,11 +921,6 @@ struct bpf_insn_aux_data {
 	u64 jump_target:1;
 
 	unsigned int orig_idx; /* original instruction index, initialized once */
-	/*
-	 * CFG strongly connected component this instruction belongs to,
-	 * zero if it is a singleton SCC.
-	 */
-	u32 scc;
 	/* registers alive before this instruction. */
 	u16 live_regs_before;
 	/*
@@ -1235,38 +1167,6 @@ struct bpf_idset {
 	} entries[BPF_ID_MAP_SIZE];
 };
 
-/* see verifier.c:compute_scc_callchain() */
-struct bpf_scc_callchain {
-	/* call sites from bpf_verifier_state->frame[*]->callsite leading to this SCC */
-	u32 callsites[MAX_CALL_FRAMES - 1];
-	/* last frame in a chain is identified by SCC id */
-	u32 scc;
-};
-
-/* verifier state waiting for propagate_backedges() */
-struct bpf_scc_backedge {
-	struct bpf_scc_backedge *next;
-	struct bpf_verifier_state state;
-};
-
-struct bpf_scc_visit {
-	struct bpf_scc_callchain callchain;
-	/* first state in current verification path that entered SCC
-	 * identified by the callchain
-	 */
-	struct bpf_verifier_state *entry_state;
-	struct bpf_scc_backedge *backedges; /* list of backedges */
-	u32 num_backedges;
-};
-
-/* An array of bpf_scc_visit structs sharing tht same bpf_scc_callchain->scc
- * but having different bpf_scc_callchain->callsites.
- */
-struct bpf_scc_info {
-	u32 num_visits;
-	struct bpf_scc_visit visits[];
-};
-
 struct bpf_liveness;
 struct scev;
 
@@ -1351,7 +1251,6 @@ struct bpf_verifier_env {
 	struct bpf_verifier_stack_elem *head; /* stack of verifier states to be processed */
 	int stack_size;			/* number of states to be processed */
 	bool strict_alignment;		/* perform strict pointer alignment checks */
-	bool test_state_freq;		/* test verifier with different pruning frequency */
 	bool test_reg_invariants;	/* fail verification on register invariants violations */
 	bool uses_arena_sp;		/* the program has insns with BPF_REG_ARENA_SP */
 	bool restart;			/* see bpf_flow_next_is_no_bound() */
@@ -1361,11 +1260,6 @@ struct bpf_verifier_env {
 	u32 *walk_insns;		/* the insns that were looked at in each of them */
 	u32 max_arena_stack_depth;	/* of all call chains */
 	struct bpf_verifier_state *cur_state; /* current verifier state */
-	/* Search pruning optimization, array of list_heads for
-	 * lists of struct bpf_verifier_state_list.
-	 */
-	struct list_head *explored_states;
-	struct list_head free_list;	/* list of struct bpf_verifier_state_list */
 	struct bpf_map *used_maps[MAX_USED_MAPS]; /* array of map's used by eBPF program */
 	struct btf_mod_pair used_btfs[MAX_USED_BTFS]; /* array of BTF's used by BPF program */
 	struct bpf_map *insn_array_maps[MAX_USED_MAPS]; /* array of INSN_ARRAY map's to be relocated */
@@ -1442,9 +1336,7 @@ struct bpf_verifier_env {
 	u32 pass_cnt; /* number of times do_check() was called */
 	u32 subprog_cnt;
 	/* number of instructions analyzed by the verifier */
-	u32 prev_insn_processed, insn_processed;
-	/* number of jmps, calls, exits analyzed so far */
-	u32 prev_jmps_processed, jmps_processed;
+	u32 insn_processed;
 	/* maximum combined stack depth */
 	u32 max_stack_depth;
 	/* stack budget of the program, see bpf_prog_stack_limit() */
@@ -1462,9 +1354,6 @@ struct bpf_verifier_env {
 	u32 peak_states;
 	/* longest register parentage chain walked for liveness marking */
 	u32 longest_mark_read_walk;
-	u32 free_list_size;
-	u32 explored_states_size;
-	u32 num_backedges;
 	/*
 	 * The program's fd_array comes in two shapes, told apart by whether
 	 * the caller passed fd_array_cnt. They are mutually exclusive:
@@ -1497,11 +1386,7 @@ struct bpf_verifier_env {
 	char tmp_arg_name[32];
 	struct bpf_insn insn_buf[INSN_BUF_SIZE];
 	struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
-	struct bpf_scc_callchain callchain_buf;
 	struct bpf_liveness *liveness;
-	/* array of pointers to bpf_scc_info indexed by SCC id */
-	struct bpf_scc_info **scc_info;
-	u32 scc_cnt;
 	struct bpf_iarray *succ;
 	struct bpf_iarray *gotox_tmp_buf;
 	int *idoms;
@@ -1699,7 +1584,6 @@ void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
 
 int mark_chain_precision(struct bpf_verifier_env *env, int regno);
 
-int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx);
 int bpf_clean_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 bool bpf_state_subsumes(struct bpf_verifier_env *env, struct bpf_verifier_state *old,
 			struct bpf_verifier_state *cur);
@@ -1748,15 +1632,11 @@ bool bpf_edge_leaves_loop(struct bpf_verifier_env *env, int h, int n, int t);
 int bpf_find_latches(struct bpf_verifier_env *env, bool flags);
 bool bpf_jump_leaves_loop(struct bpf_verifier_env *env, int h, int n);
 int bpf_insert_recursion_checks(struct bpf_verifier_env *env);
-int bpf_split_cur_state(struct bpf_verifier_env *env);
-int bpf_update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 
 void bpf_clear_jmp_history(struct bpf_verifier_state *state);
 int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
 			    const struct bpf_verifier_state *src);
-struct list_head *bpf_explored_state(struct bpf_verifier_env *env, int idx);
 void bpf_free_verifier_state(struct bpf_verifier_state *state, bool free_self);
-void bpf_free_backedges(struct bpf_scc_visit *visit);
 int bpf_push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
 			 int insn_flags, int spi, int frame, const u16 *linked_regs,
 			 u8 linked_regs_cnt);
@@ -2114,7 +1994,6 @@ int bpf_prune_dead_branches(struct bpf_verifier_env *env);
 int bpf_check_cfg(struct bpf_verifier_env *env);
 void bpf_free_subprog_jts(struct bpf_verifier_env *env);
 int bpf_compute_postorder(struct bpf_verifier_env *env);
-int bpf_compute_scc(struct bpf_verifier_env *env);
 
 struct bpf_map_desc {
 	struct bpf_map *ptr;
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 04c1c98ba248..94140d1fe1c3 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -868,201 +868,3 @@ int bpf_compute_postorder(struct bpf_verifier_env *env)
 	kvfree(state);
 	return 0;
 }
-
-/*
- * Compute strongly connected components (SCCs) on the CFG.
- * Assign an SCC number to each instruction, recorded in env->insn_aux[*].scc.
- * If instruction is a sole member of its SCC and there are no self edges,
- * assign it SCC number of zero.
- * Uses a non-recursive adaptation of Tarjan's algorithm for SCC computation.
- */
-int bpf_compute_scc(struct bpf_verifier_env *env)
-{
-	const u32 NOT_ON_STACK = U32_MAX;
-
-	struct bpf_insn_aux_data *aux = env->insn_aux_data;
-	const u32 insn_cnt = env->prog->len;
-	int stack_sz, dfs_sz, err = 0;
-	u32 *stack, *pre, *low, *dfs, *dfs_pos;
-	u32 i, j, t, w;
-	u32 next_preorder_num;
-	u32 next_scc_id;
-	bool assign_scc;
-	struct bpf_iarray *succ;
-
-	next_preorder_num = 1;
-	next_scc_id = 1;
-	/*
-	 * - 'stack' accumulates vertices in DFS order, see invariant comment below;
-	 * - 'pre[t] == p' => preorder number of vertex 't' is 'p';
-	 * - 'low[t] == n' => smallest preorder number of the vertex reachable from 't' is 'n';
-	 * - 'dfs' DFS traversal stack, used to emulate explicit recursion;
-	 * - 'dfs_pos[k] == j' => the frame 'dfs[k]' resumes visiting its
-	 *   successors at index 'j'.
-	 */
-	stack = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
-	pre = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
-	low = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
-	dfs = kvcalloc(insn_cnt, sizeof(*dfs), GFP_KERNEL_ACCOUNT);
-	dfs_pos = kvcalloc(insn_cnt, sizeof(*dfs_pos), GFP_KERNEL_ACCOUNT);
-	if (!stack || !pre || !low || !dfs || !dfs_pos) {
-		err = -ENOMEM;
-		goto exit;
-	}
-	/*
-	 * References:
-	 * [1] R. Tarjan "Depth-First Search and Linear Graph Algorithms"
-	 * [2] D. J. Pearce "A Space-Efficient Algorithm for Finding Strongly Connected Components"
-	 *
-	 * The algorithm maintains the following invariant:
-	 * - suppose there is a path 'u' ~> 'v', such that 'pre[v] < pre[u]';
-	 * - then, vertex 'u' remains on stack while vertex 'v' is on stack.
-	 *
-	 * Consequently:
-	 * - If 'low[v] < pre[v]', there is a path from 'v' to some vertex 'u',
-	 *   such that 'pre[u] == low[v]'; vertex 'u' is currently on the stack,
-	 *   and thus there is an SCC (loop) containing both 'u' and 'v'.
-	 * - If 'low[v] == pre[v]', loops containing 'v' have been explored,
-	 *   and 'v' can be considered the root of some SCC.
-	 *
-	 * Here is a pseudo-code for an explicitly recursive version of the algorithm:
-	 *
-	 *    NOT_ON_STACK = insn_cnt + 1
-	 *    pre = [0] * insn_cnt
-	 *    low = [0] * insn_cnt
-	 *    scc = [0] * insn_cnt
-	 *    stack = []
-	 *
-	 *    next_preorder_num = 1
-	 *    next_scc_id = 1
-	 *
-	 *    def recur(w):
-	 *        nonlocal next_preorder_num
-	 *        nonlocal next_scc_id
-	 *
-	 *        pre[w] = next_preorder_num
-	 *        low[w] = next_preorder_num
-	 *        next_preorder_num += 1
-	 *        stack.append(w)
-	 *        for s in successors(w):
-	 *            # Note: for classic algorithm the block below should look as:
-	 *            #
-	 *            # if pre[s] == 0:
-	 *            #     recur(s)
-	 *            #     low[w] = min(low[w], low[s])
-	 *            # elif low[s] != NOT_ON_STACK:
-	 *            #     low[w] = min(low[w], pre[s])
-	 *            #
-	 *            # But replacing both 'min' instructions with 'low[w] = min(low[w], low[s])'
-	 *            # does not break the invariant and makes iterative version of the algorithm
-	 *            # simpler. See 'Algorithm #3' from [2].
-	 *
-	 *            # 's' not yet visited
-	 *            if pre[s] == 0:
-	 *                recur(s)
-	 *            # if 's' is on stack, pick lowest reachable preorder number from it;
-	 *            # if 's' is not on stack 'low[s] == NOT_ON_STACK > low[w]',
-	 *            # so 'min' would be a noop.
-	 *            low[w] = min(low[w], low[s])
-	 *
-	 *        if low[w] == pre[w]:
-	 *            # 'w' is the root of an SCC, pop all vertices
-	 *            # below 'w' on stack and assign same SCC to them.
-	 *            while True:
-	 *                t = stack.pop()
-	 *                low[t] = NOT_ON_STACK
-	 *                scc[t] = next_scc_id
-	 *                if t == w:
-	 *                    break
-	 *            next_scc_id += 1
-	 *
-	 *    for i in range(0, insn_cnt):
-	 *        if pre[i] == 0:
-	 *            recur(i)
-	 *
-	 * Below implementation replaces explicit recursion with array 'dfs'.
-	 */
-	for (i = 0; i < insn_cnt; i++) {
-		if (pre[i])
-			continue;
-		stack_sz = 0;
-		dfs_sz = 1;
-		dfs[0] = i;
-		dfs_pos[0] = 0;
-dfs_continue:
-		while (dfs_sz) {
-			w = dfs[dfs_sz - 1];
-			if (pre[w] == 0) {
-				low[w] = next_preorder_num;
-				pre[w] = next_preorder_num;
-				next_preorder_num++;
-				stack[stack_sz++] = w;
-			}
-			/* Visit remaining 'w' successors */
-			succ = bpf_insn_successors(env, w);
-			for (j = dfs_pos[dfs_sz - 1]; j < succ->cnt; ++j) {
-				if (pre[succ->items[j]]) {
-					low[w] = min(low[w], low[succ->items[j]]);
-				} else {
-					/*
-					 * Once DFS for succ->items[j] is complete,
-					 * pre[succ->items[j]] is non-zero, hence
-					 * resuming at 'j' allows to follow the
-					 * low[w] = min(...) update branch above.
-					 */
-					dfs_pos[dfs_sz - 1] = j;
-					dfs_pos[dfs_sz] = 0;
-					dfs[dfs_sz] = succ->items[j];
-					dfs_sz++;
-					goto dfs_continue;
-				}
-			}
-			/*
-			 * Preserve the invariant: if some vertex above in the stack
-			 * is reachable from 'w', keep 'w' on the stack.
-			 */
-			if (low[w] < pre[w]) {
-				dfs_sz--;
-				goto dfs_continue;
-			}
-			/*
-			 * Assign SCC number only if component has two or more elements,
-			 * or if component has a self reference, or if instruction is a
-			 * callback calling function (implicit loop).
-			 */
-			assign_scc = stack[stack_sz - 1] != w;	/* two or more elements? */
-			for (j = 0; j < succ->cnt; ++j) {	/* self reference? */
-				if (succ->items[j] == w) {
-					assign_scc = true;
-					break;
-				}
-			}
-			if (bpf_calls_callback(env, w)) /* implicit loop? */
-				assign_scc = true;
-			/* Pop component elements from stack */
-			do {
-				t = stack[--stack_sz];
-				low[t] = NOT_ON_STACK;
-				if (assign_scc)
-					aux[t].scc = next_scc_id;
-			} while (t != w);
-			if (assign_scc)
-				next_scc_id++;
-			dfs_sz--;
-		}
-	}
-	env->scc_info = kvzalloc_objs(*env->scc_info, next_scc_id,
-				      GFP_KERNEL_ACCOUNT);
-	if (!env->scc_info) {
-		err = -ENOMEM;
-		goto exit;
-	}
-	env->scc_cnt = next_scc_id;
-exit:
-	kvfree(stack);
-	kvfree(pre);
-	kvfree(low);
-	kvfree(dfs);
-	kvfree(dfs_pos);
-	return err;
-}
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index e1c9b56cd13f..00cb219e24cd 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -779,11 +779,10 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 			if (!reg->id)
 				continue;
 
-			verbose(env, " fp%d=iter_%s(id=%d,state=%s,depth=%u)",
+			verbose(env, " fp%d=iter_%s(id=%d,state=%s)",
 				(-i - 1) * BPF_REG_SIZE,
 				iter_type_str(reg->iter.btf, reg->iter.btf_id),
-				reg->id, iter_state_str(reg->iter.state),
-				reg->iter.depth);
+				reg->id, iter_state_str(reg->iter.state));
 			break;
 		case STACK_MISC:
 		case STACK_ZERO:
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 4b2506f3e3e2..343f29b52d79 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -7,297 +7,6 @@
 
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
 
-#define BPF_COMPLEXITY_LIMIT_STATES	64
-
-static bool is_may_goto_insn_at(struct bpf_verifier_env *env, int insn_idx)
-{
-	return bpf_is_may_goto_insn(&env->prog->insnsi[insn_idx]);
-}
-
-static bool is_iter_next_insn(struct bpf_verifier_env *env, int insn_idx)
-{
-	return env->insn_aux_data[insn_idx].is_iter_next;
-}
-
-static void update_peak_states(struct bpf_verifier_env *env)
-{
-	u32 cur_states;
-
-	cur_states = env->explored_states_size + env->free_list_size + env->num_backedges;
-	env->peak_states = max(env->peak_states, cur_states);
-}
-
-/* struct bpf_verifier_state->parent refers to states
- * that are in either of env->{expored_states,free_list}.
- * In both cases the state is contained in struct bpf_verifier_state_list.
- */
-static struct bpf_verifier_state_list *state_parent_as_list(struct bpf_verifier_state *st)
-{
-	if (st->parent)
-		return container_of(st->parent, struct bpf_verifier_state_list, state);
-	return NULL;
-}
-
-static bool incomplete_read_marks(struct bpf_verifier_env *env,
-				  struct bpf_verifier_state *st);
-
-/* A state can be freed if it is no longer referenced:
- * - is in the env->free_list;
- * - has no children states;
- */
-static void maybe_free_verifier_state(struct bpf_verifier_env *env,
-				      struct bpf_verifier_state_list *sl)
-{
-	if (!sl->in_free_list
-	    || sl->state.branches != 0
-	    || incomplete_read_marks(env, &sl->state))
-		return;
-	list_del(&sl->node);
-	bpf_free_verifier_state(&sl->state, false);
-	kfree(sl);
-	env->free_list_size--;
-}
-
-/* For state @st look for a topmost frame with frame_insn_idx() in some SCC,
- * if such frame exists form a corresponding @callchain as an array of
- * call sites leading to this frame and SCC id.
- * E.g.:
- *
- *    void foo()  { A: loop {... SCC#1 ...}; }
- *    void bar()  { B: loop { C: foo(); ... SCC#2 ... }
- *                  D: loop { E: foo(); ... SCC#3 ... } }
- *    void main() { F: bar(); }
- *
- * @callchain at (A) would be either (F,SCC#2) or (F,SCC#3) depending
- * on @st frame call sites being (F,C,A) or (F,E,A).
- */
-static bool compute_scc_callchain(struct bpf_verifier_env *env,
-				  struct bpf_verifier_state *st,
-				  struct bpf_scc_callchain *callchain)
-{
-	u32 i, scc, insn_idx;
-
-	memset(callchain, 0, sizeof(*callchain));
-	for (i = 0; i <= st->curframe; i++) {
-		insn_idx = bpf_frame_insn_idx(st, i);
-		scc = env->insn_aux_data[insn_idx].scc;
-		if (scc) {
-			callchain->scc = scc;
-			break;
-		} else if (i < st->curframe) {
-			callchain->callsites[i] = insn_idx;
-		} else {
-			return false;
-		}
-	}
-	return true;
-}
-
-/* Check if bpf_scc_visit instance for @callchain exists. */
-static struct bpf_scc_visit *scc_visit_lookup(struct bpf_verifier_env *env,
-					      struct bpf_scc_callchain *callchain)
-{
-	struct bpf_scc_info *info = env->scc_info[callchain->scc];
-	struct bpf_scc_visit *visits = info->visits;
-	u32 i;
-
-	if (!info)
-		return NULL;
-	for (i = 0; i < info->num_visits; i++)
-		if (memcmp(callchain, &visits[i].callchain, sizeof(*callchain)) == 0)
-			return &visits[i];
-	return NULL;
-}
-
-/* Allocate a new bpf_scc_visit instance corresponding to @callchain.
- * Allocated instances are alive for a duration of the do_check_common()
- * call and are freed by free_states().
- */
-static struct bpf_scc_visit *scc_visit_alloc(struct bpf_verifier_env *env,
-					     struct bpf_scc_callchain *callchain)
-{
-	struct bpf_scc_visit *visit;
-	struct bpf_scc_info *info;
-	u32 scc, num_visits;
-	u64 new_sz;
-
-	scc = callchain->scc;
-	info = env->scc_info[scc];
-	num_visits = info ? info->num_visits : 0;
-	new_sz = sizeof(*info) + sizeof(struct bpf_scc_visit) * (num_visits + 1);
-	info = kvrealloc(env->scc_info[scc], new_sz, GFP_KERNEL_ACCOUNT);
-	if (!info)
-		return NULL;
-	env->scc_info[scc] = info;
-	info->num_visits = num_visits + 1;
-	visit = &info->visits[num_visits];
-	memset(visit, 0, sizeof(*visit));
-	memcpy(&visit->callchain, callchain, sizeof(*callchain));
-	return visit;
-}
-
-/* Form a string '(callsite#1,callsite#2,...,scc)' in env->tmp_str_buf */
-static char *format_callchain(struct bpf_verifier_env *env, struct bpf_scc_callchain *callchain)
-{
-	char *buf = env->tmp_str_buf;
-	int i, delta = 0;
-
-	delta += snprintf(buf + delta, TMP_STR_BUF_LEN - delta, "(");
-	for (i = 0; i < ARRAY_SIZE(callchain->callsites); i++) {
-		if (!callchain->callsites[i])
-			break;
-		delta += snprintf(buf + delta, TMP_STR_BUF_LEN - delta, "%u,",
-				  callchain->callsites[i]);
-	}
-	delta += snprintf(buf + delta, TMP_STR_BUF_LEN - delta, "%u)", callchain->scc);
-	return env->tmp_str_buf;
-}
-
-/* If callchain for @st exists (@st is in some SCC), ensure that
- * bpf_scc_visit instance for this callchain exists.
- * If instance does not exist or is empty, assign visit->entry_state to @st.
- */
-static int maybe_enter_scc(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
-{
-	struct bpf_scc_callchain *callchain = &env->callchain_buf;
-	struct bpf_scc_visit *visit;
-
-	if (!compute_scc_callchain(env, st, callchain))
-		return 0;
-	visit = scc_visit_lookup(env, callchain);
-	visit = visit ?: scc_visit_alloc(env, callchain);
-	if (!visit)
-		return -ENOMEM;
-	if (!visit->entry_state) {
-		visit->entry_state = st;
-		if (env->log.level & BPF_LOG_LEVEL2)
-			verbose(env, "SCC enter %s\n", format_callchain(env, callchain));
-	}
-	return 0;
-}
-
-static int propagate_backedges(struct bpf_verifier_env *env, struct bpf_scc_visit *visit);
-
-/* If callchain for @st exists (@st is in some SCC), make it empty:
- * - set visit->entry_state to NULL;
- * - flush accumulated backedges.
- */
-static int maybe_exit_scc(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
-{
-	struct bpf_scc_callchain *callchain = &env->callchain_buf;
-	struct bpf_scc_visit *visit;
-
-	if (!compute_scc_callchain(env, st, callchain))
-		return 0;
-	visit = scc_visit_lookup(env, callchain);
-	if (!visit) {
-		/*
-		 * If path traversal stops inside an SCC, corresponding bpf_scc_visit
-		 * must exist for non-speculative paths. For non-speculative paths
-		 * traversal stops when:
-		 * a. Verification error is found, maybe_exit_scc() is not called.
-		 * b. Top level BPF_EXIT is reached. Top level BPF_EXIT is not a member
-		 *    of any SCC.
-		 * c. A checkpoint is reached and matched. Checkpoints are created by
-		 *    is_state_visited(), which calls maybe_enter_scc(), which allocates
-		 *    bpf_scc_visit instances for checkpoints within SCCs.
-		 * (c) is the only case that can reach this point.
-		 */
-		if (!st->speculative) {
-			verifier_bug(env, "scc exit: no visit info for call chain %s",
-				     format_callchain(env, callchain));
-			return -EFAULT;
-		}
-		return 0;
-	}
-	if (visit->entry_state != st)
-		return 0;
-	if (env->log.level & BPF_LOG_LEVEL2)
-		verbose(env, "SCC exit %s\n", format_callchain(env, callchain));
-	visit->entry_state = NULL;
-	env->num_backedges -= visit->num_backedges;
-	visit->num_backedges = 0;
-	update_peak_states(env);
-	return propagate_backedges(env, visit);
-}
-
-/* Lookup an bpf_scc_visit instance corresponding to @st callchain
- * and add @backedge to visit->backedges. @st callchain must exist.
- */
-static int add_scc_backedge(struct bpf_verifier_env *env,
-			    struct bpf_verifier_state *st,
-			    struct bpf_scc_backedge *backedge)
-{
-	struct bpf_scc_callchain *callchain = &env->callchain_buf;
-	struct bpf_scc_visit *visit;
-
-	if (!compute_scc_callchain(env, st, callchain)) {
-		verifier_bug(env, "add backedge: no SCC in verification path, insn_idx %d",
-			     st->insn_idx);
-		return -EFAULT;
-	}
-	visit = scc_visit_lookup(env, callchain);
-	if (!visit) {
-		verifier_bug(env, "add backedge: no visit info for call chain %s",
-			     format_callchain(env, callchain));
-		return -EFAULT;
-	}
-	if (env->log.level & BPF_LOG_LEVEL2)
-		verbose(env, "SCC backedge %s\n", format_callchain(env, callchain));
-	backedge->next = visit->backedges;
-	visit->backedges = backedge;
-	visit->num_backedges++;
-	env->num_backedges++;
-	update_peak_states(env);
-	return 0;
-}
-
-/* bpf_reg_state->live marks for registers in a state @st are incomplete,
- * if state @st is in some SCC and not all execution paths starting at this
- * SCC are fully explored.
- */
-static bool incomplete_read_marks(struct bpf_verifier_env *env,
-				  struct bpf_verifier_state *st)
-{
-	struct bpf_scc_callchain *callchain = &env->callchain_buf;
-	struct bpf_scc_visit *visit;
-
-	if (!compute_scc_callchain(env, st, callchain))
-		return false;
-	visit = scc_visit_lookup(env, callchain);
-	if (!visit)
-		return false;
-	return !!visit->backedges;
-}
-
-int bpf_update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
-{
-	struct bpf_verifier_state_list *sl = NULL, *parent_sl;
-	struct bpf_verifier_state *parent;
-	int err;
-
-	while (st) {
-		u32 br = --st->branches;
-
-		/* verifier_bug_if(br > 1, ...) technically makes sense here,
-		 * but see comment in push_stack(), hence:
-		 */
-		verifier_bug_if((int)br < 0, env, "%s:branches_to_explore=%d", __func__, br);
-		if (br)
-			break;
-		err = maybe_exit_scc(env, st);
-		if (err)
-			return err;
-		parent = st->parent;
-		parent_sl = state_parent_as_list(st);
-		if (sl)
-			maybe_free_verifier_state(env, sl);
-		st = parent;
-		sl = parent_sl;
-	}
-	return 0;
-}
-
 /* check %cur's range satisfies %old's */
 static bool range_within(const struct bpf_reg_state *old,
 			 const struct bpf_reg_state *cur)
@@ -830,18 +539,11 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		case STACK_ITER:
 			old_reg = &old_slot->spilled_ptr;
 			cur_reg = &cur_slot->spilled_ptr;
-			/* iter.depth is not compared between states as it
-			 * doesn't matter for correctness and would otherwise
-			 * prevent convergence; we maintain it only to prevent
-			 * infinite loop check triggering, see
-			 * iter_active_depths_differ()
-			 */
 			if (old_reg->type != cur_reg->type ||
 			    old_reg->iter.btf != cur_reg->iter.btf ||
 			    old_reg->iter.btf_id != cur_reg->iter.btf_id ||
 			    old_reg->iter.state != cur_reg->iter.state ||
 			    old_reg->iter.loops != cur_reg->iter.loops ||
-			    /* ignore {old_reg,cur_reg}->iter.depth, see above */
 			    !check_ids(old_reg->id, cur_reg->id, idmap))
 				return false;
 			break;
@@ -1110,706 +812,6 @@ static bool states_equal(struct bpf_verifier_env *env,
 	return true;
 }
 
-/* find precise scalars in the previous equivalent state and
- * propagate them into the current state
- */
-static int propagate_precision(struct bpf_verifier_env *env,
-			       const struct bpf_verifier_state *old,
-			       struct bpf_verifier_state *cur,
-			       bool *changed)
-{
-	struct bpf_reg_state *state_reg;
-	struct bpf_func_state *state;
-	int i, err = 0, fr;
-	bool first;
-
-	for (fr = old->curframe; fr >= 0; fr--) {
-		state = old->frame[fr];
-		state_reg = state->regs;
-		first = true;
-		for (i = 0; i < BPF_REG_FP; i++, state_reg++) {
-			if (state_reg->type != SCALAR_VALUE ||
-			    !state_reg->precise)
-				continue;
-			if (env->log.level & BPF_LOG_LEVEL2) {
-				if (first)
-					verbose(env, "frame %d: propagating r%d", fr, i);
-				else
-					verbose(env, ",r%d", i);
-			}
-			bpf_bt_set_frame_reg(&env->bt, fr, i);
-			first = false;
-		}
-
-		for (i = 0; i < bpf_stack_nr_slots(state); i++) {
-			struct bpf_stack_state *ss = bpf_stack_slot(state, i);
-
-			if (!bpf_is_spilled_reg(ss))
-				continue;
-			state_reg = &ss->spilled_ptr;
-			if (state_reg->type != SCALAR_VALUE ||
-			    !state_reg->precise)
-				continue;
-			if (env->log.level & BPF_LOG_LEVEL2) {
-				if (first)
-					verbose(env, "frame %d: propagating fp%d",
-						fr, (-i - 1) * BPF_REG_SIZE);
-				else
-					verbose(env, ",fp%d", (-i - 1) * BPF_REG_SIZE);
-			}
-			bpf_bt_set_frame_slot(&env->bt, fr, i);
-			first = false;
-		}
-		for (i = 0; i < state->out_stack_arg_cnt; i++) {
-			state_reg = &state->stack_arg_regs[i];
-			if (state_reg->type != SCALAR_VALUE || !state_reg->precise)
-				continue;
-			if (env->log.level & BPF_LOG_LEVEL2) {
-				if (first)
-					verbose(env, "frame %d: propagating r11%d",
-						fr, -(i + 1) * BPF_REG_SIZE);
-				else
-					verbose(env, ",r11%d", -(i + 1) * BPF_REG_SIZE);
-			}
-			bt_set_frame_stack_arg_slot(&env->bt, fr, i);
-			first = false;
-		}
-		if (!first && (env->log.level & BPF_LOG_LEVEL2))
-			verbose(env, "\n");
-	}
-
-	err = bpf_mark_chain_precision(env, cur, -1, changed);
-	if (err < 0)
-		return err;
-
-	return 0;
-}
-
-#define MAX_BACKEDGE_ITERS 64
-
-/* Propagate read and precision marks from visit->backedges[*].state->equal_state
- * to corresponding parent states of visit->backedges[*].state until fixed point is reached,
- * then free visit->backedges.
- * After execution of this function incomplete_read_marks() will return false
- * for all states corresponding to @visit->callchain.
- */
-static int propagate_backedges(struct bpf_verifier_env *env, struct bpf_scc_visit *visit)
-{
-	struct bpf_scc_backedge *backedge;
-	struct bpf_verifier_state *st;
-	bool changed;
-	int i, err;
-
-	i = 0;
-	do {
-		if (i++ > MAX_BACKEDGE_ITERS) {
-			if (env->log.level & BPF_LOG_LEVEL2)
-				verbose(env, "%s: too many iterations\n", __func__);
-			for (backedge = visit->backedges; backedge; backedge = backedge->next)
-				bpf_mark_all_scalars_precise(env, &backedge->state);
-			break;
-		}
-		changed = false;
-		for (backedge = visit->backedges; backedge; backedge = backedge->next) {
-			st = &backedge->state;
-			err = propagate_precision(env, st->equal_state, st, &changed);
-			if (err)
-				return err;
-		}
-	} while (changed);
-
-	bpf_free_backedges(visit);
-	return 0;
-}
-
-static bool states_maybe_looping(struct bpf_verifier_state *old,
-				 struct bpf_verifier_state *cur)
-{
-	struct bpf_func_state *fold, *fcur;
-	int i, fr = cur->curframe;
-
-	if (old->curframe != fr)
-		return false;
-
-	fold = old->frame[fr];
-	fcur = cur->frame[fr];
-	for (i = 0; i < MAX_BPF_REG; i++)
-		if (memcmp(&fold->regs[i], &fcur->regs[i],
-			   offsetofend(struct bpf_reg_state, step)))
-			return false;
-	return true;
-}
-
-/* is_state_visited() handles iter_next() (see process_iter_next_call() for
- * terminology) calls specially: as opposed to bounded BPF loops, it *expects*
- * states to match, which otherwise would look like an infinite loop. So while
- * iter_next() calls are taken care of, we still need to be careful and
- * prevent erroneous and too eager declaration of "infinite loop", when
- * iterators are involved.
- *
- * Here's a situation in pseudo-BPF assembly form:
- *
- *   0: again:                          ; set up iter_next() call args
- *   1:   r1 = &it                      ; <CHECKPOINT HERE>
- *   2:   call bpf_iter_num_next        ; this is iter_next() call
- *   3:   if r0 == 0 goto done
- *   4:   ... something useful here ...
- *   5:   goto again                    ; another iteration
- *   6: done:
- *   7:   r1 = &it
- *   8:   call bpf_iter_num_destroy     ; clean up iter state
- *   9:   exit
- *
- * This is a typical loop. Let's assume that we have a prune point at 1:,
- * before we get to `call bpf_iter_num_next` (e.g., because of that `goto
- * again`, assuming other heuristics don't get in a way).
- *
- * When we first time come to 1:, let's say we have some state X. We proceed
- * to 2:, fork states, enqueue ACTIVE, validate NULL case successfully, exit.
- * Now we come back to validate that forked ACTIVE state. We proceed through
- * 3-5, come to goto, jump to 1:. Let's assume our state didn't change, so we
- * are converging. But the problem is that we don't know that yet, as this
- * convergence has to happen at iter_next() call site only. So if nothing is
- * done, at 1: verifier will use bounded loop logic and declare infinite
- * looping (and would be *technically* correct, if not for iterator's
- * "eventual sticky NULL" contract, see process_iter_next_call()). But we
- * don't want that. So what we do in process_iter_next_call() when we go on
- * another ACTIVE iteration, we bump slot->iter.depth, to mark that it's
- * a different iteration. So when we suspect an infinite loop, we additionally
- * check if any of the *ACTIVE* iterator states depths differ. If yes, we
- * pretend we are not looping and wait for next iter_next() call.
- *
- * This only applies to ACTIVE state. In DRAINED state we don't expect to
- * loop, because that would actually mean infinite loop, as DRAINED state is
- * "sticky", and so we'll keep returning into the same instruction with the
- * same state (at least in one of possible code paths).
- *
- * This approach allows to keep infinite loop heuristic even in the face of
- * active iterator. E.g., C snippet below is and will be detected as
- * infinitely looping:
- *
- *   struct bpf_iter_num it;
- *   int *p, x;
- *
- *   bpf_iter_num_new(&it, 0, 10);
- *   while ((p = bpf_iter_num_next(&t))) {
- *       x = p;
- *       while (x--) {} // <<-- infinite loop here
- *   }
- *
- */
-static bool iter_active_depths_differ(struct bpf_verifier_state *old, struct bpf_verifier_state *cur)
-{
-	struct bpf_reg_state *slot, *cur_slot;
-	struct bpf_func_state *state;
-	int i, fr;
-
-	for (fr = old->curframe; fr >= 0; fr--) {
-		state = old->frame[fr];
-		for (i = 0; i < bpf_stack_nr_slots(state); i++) {
-			struct bpf_stack_state *ss = bpf_stack_slot(state, i);
-
-			if (ss->slot_type[0] != STACK_ITER)
-				continue;
-
-			slot = &ss->spilled_ptr;
-			if (slot->iter.state != BPF_ITER_STATE_ACTIVE)
-				continue;
-
-			cur_slot = &bpf_stack_slot(cur->frame[fr], i)->spilled_ptr;
-			if (cur_slot->iter.depth != slot->iter.depth)
-				return true;
-		}
-	}
-	return false;
-}
-
-static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
-{
-	struct bpf_func_state *func;
-	struct bpf_reg_state *reg;
-	int i, j;
-
-	for (i = 0; i <= st->curframe; i++) {
-		func = st->frame[i];
-		for (j = 0; j < BPF_REG_FP; j++) {
-			reg = &func->regs[j];
-			if (reg->type != SCALAR_VALUE)
-				continue;
-			reg->precise = false;
-		}
-		for (j = 0; j < bpf_stack_nr_slots(func); j++) {
-			struct bpf_stack_state *ss = bpf_stack_slot(func, j);
-
-			if (!bpf_is_spilled_reg(ss))
-				continue;
-			reg = &ss->spilled_ptr;
-			if (reg->type != SCALAR_VALUE)
-				continue;
-			reg->precise = false;
-		}
-	}
-}
-
-int bpf_split_cur_state(struct bpf_verifier_env *env)
-{
-	struct bpf_verifier_state *cur = env->cur_state, *new;
-	struct bpf_verifier_state_list *new_sl;
-	struct list_head *head;
-	int insn_idx = cur->insn_idx;
-	int err;
-
-	head = bpf_explored_state(env, insn_idx);
-	new_sl = kzalloc_obj(struct bpf_verifier_state_list, GFP_KERNEL_ACCOUNT);
-	if (!new_sl)
-		return -ENOMEM;
-	env->total_states++;
-	env->explored_states_size++;
-	update_peak_states(env);
-	env->prev_jmps_processed = env->jmps_processed;
-	env->prev_insn_processed = env->insn_processed;
-
-	/* forget precise markings we inherited, see __mark_chain_precision */
-	if (env->bpf_capable)
-		mark_all_scalars_imprecise(env, cur);
-
-	bpf_clear_singular_ids(env, cur);
-
-	/* add new state to the head of linked list */
-	new = &new_sl->state;
-	err = bpf_copy_verifier_state(new, cur);
-	if (err) {
-		bpf_free_verifier_state(new, false);
-		kfree(new_sl);
-		return err;
-	}
-	new->insn_idx = insn_idx;
-	verifier_bug_if(new->branches != 1, env,
-			"%s:branches_to_explore=%d insn %d",
-			__func__, new->branches, insn_idx);
-	err = maybe_enter_scc(env, new);
-	if (err) {
-		bpf_free_verifier_state(new, false);
-		kfree(new_sl);
-		return err;
-	}
-
-	cur->parent = new;
-	cur->last_insn_idx = -1;
-	cur->first_insn_idx = insn_idx;
-	cur->dfs_depth = new->dfs_depth + 1;
-	bpf_clear_jmp_history(cur);
-	list_add(&new_sl->node, head);
-	return 0;
-}
-
-/* Force a checkpoint upon reaching a loop header for a terminating loop. */
-static bool need_loop_checkpoint(struct bpf_verifier_env *env, int insn_idx)
-{
-	struct bpf_verifier_state *cur = env->cur_state;
-	struct bpf_func_state *frame = cur->frame[cur->curframe];
-	struct loop_stack_entry *top;
-
-	if (bpf_loop_at_index(env, insn_idx) != insn_idx || !frame->loop_stack_cnt)
-		return false;
-	top = &frame->loop_stack[frame->loop_stack_cnt - 1];
-	return top->loop_id == insn_idx && top->terminates;
-}
-
-/* Searches for an innermost loop entry starting from an innermost frame. */
-static struct loop_stack_entry *current_loop(struct bpf_verifier_state *st)
-{
-	struct bpf_func_state *frame;
-	int fr;
-
-	for (fr = st->curframe; fr >= 0; fr--) {
-		frame = st->frame[fr];
-		if (frame->loop_stack_cnt)
-			return &frame->loop_stack[frame->loop_stack_cnt - 1];
-	}
-	return NULL;
-}
-
-/* True if any of the loops call chain is currently in terminates. */
-static bool in_a_terminating_loop(struct bpf_verifier_state *st)
-{
-	struct bpf_func_state *frame;
-	int l, fr;
-
-	for (fr = st->curframe; fr >= 0; fr--) {
-		frame = st->frame[fr];
-		for (l = frame->loop_stack_cnt - 1; l >= 0; l--)
-			if (frame->loop_stack[l].terminates)
-				return true;
-	}
-	return false;
-}
-
-int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
-{
-	struct loop_stack_entry *old_loop, *cur_loop;
-	struct bpf_verifier_state_list *sl;
-	struct bpf_verifier_state *cur = env->cur_state;
-	bool force_new_state, add_new_state, loop, loop_checkpoint;
-	int n, err, states_cnt = 0;
-	struct list_head *pos, *tmp, *head;
-
-	loop_checkpoint = need_loop_checkpoint(env, insn_idx);
-	force_new_state = env->test_state_freq || bpf_is_force_checkpoint(env, insn_idx) ||
-			  loop_checkpoint ||
-			  /* Avoid accumulating infinitely long jmp history */
-			  cur->jmp_history_cnt > 40;
-
-	/* bpf progs typically have pruning point every 4 instructions
-	 * http://vger.kernel.org/bpfconf2019.html#session-1
-	 * Do not add new state for future pruning if the verifier hasn't seen
-	 * at least 2 jumps and at least 8 instructions.
-	 * This heuristics helps decrease 'total_states' and 'peak_states' metric.
-	 * In tests that amounts to up to 50% reduction into total verifier
-	 * memory consumption and 20% verifier time speedup.
-	 */
-	add_new_state = force_new_state;
-	if (env->jmps_processed - env->prev_jmps_processed >= 2 &&
-	    env->insn_processed - env->prev_insn_processed >= 8)
-		add_new_state = true;
-
-	/* keep cleaning the current state as registers/stack become dead */
-	err = clean_verifier_state(env, cur);
-	if (err)
-		return err;
-
-	loop = false;
-	head = bpf_explored_state(env, insn_idx);
-	list_for_each_safe(pos, tmp, head) {
-		sl = container_of(pos, struct bpf_verifier_state_list, node);
-		states_cnt++;
-		if (sl->state.insn_idx != insn_idx)
-			continue;
-
-		if (sl->state.branches) {
-			struct bpf_func_state *old_top_frame = sl->state.frame[0];
-
-			if (old_top_frame->in_async_callback_fn &&
-			    old_top_frame->async_entry_cnt != cur->frame[0]->async_entry_cnt) {
-				/* Different async_entry_cnt means that the verifier is
-				 * processing another entry into async callback.
-				 * Seeing the same state is not an indication of infinite
-				 * loop or infinite recursion.
-				 * But finding the same state doesn't mean that it's safe
-				 * to stop processing the current state. The previous state
-				 * hasn't yet reached bpf_exit, since state.branches > 0.
-				 * Checking in_async_callback_fn alone is not enough either.
-				 * Since the verifier still needs to catch infinite loops
-				 * inside async callbacks.
-				 */
-				goto skip_inf_loop_check;
-			}
-			/* BPF open-coded iterators loop detection is special.
-			 * states_maybe_looping() logic is too simplistic in detecting
-			 * states that *might* be equivalent, because it doesn't know
-			 * about ID remapping, so don't even perform it.
-			 * See process_iter_next_call() and iter_active_depths_differ()
-			 * for overview of the logic. When current and one of parent
-			 * states are detected as equivalent, it's a good thing: we prove
-			 * convergence and can stop simulating further iterations.
-			 * It's safe to assume that iterator loop will finish, taking into
-			 * account iter_next() contract of eventually returning
-			 * sticky NULL result.
-			 *
-			 * Note, that states have to be compared exactly in this case because
-			 * read and precision marks might not be finalized inside the loop.
-			 * E.g. as in the program below:
-			 *
-			 *     1. r7 = -16
-			 *     2. r6 = bpf_get_prandom_u32()
-			 *     3. while (bpf_iter_num_next(&fp[-8])) {
-			 *     4.   if (r6 != 42) {
-			 *     5.     r7 = -32
-			 *     6.     r6 = bpf_get_prandom_u32()
-			 *     7.     continue
-			 *     8.   }
-			 *     9.   r0 = r10
-			 *    10.   r0 += r7
-			 *    11.   r8 = *(u64 *)(r0 + 0)
-			 *    12.   r6 = bpf_get_prandom_u32()
-			 *    13. }
-			 *
-			 * Here verifier would first visit path 1-3, create a checkpoint at 3
-			 * with r7=-16, continue to 4-7,3. Existing checkpoint at 3 does
-			 * not have read or precision mark for r7 yet, thus inexact states
-			 * comparison would discard current state with r7=-32
-			 * => unsafe memory access at 11 would not be caught.
-			 */
-			if (is_iter_next_insn(env, insn_idx)) {
-				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
-					struct bpf_func_state *cur_frame, *iter_frame, *old_frame;
-					struct bpf_reg_state *iter_state, *iter_reg;
-					struct bpf_reg_state *old_iter;
-					int spi;
-
-					cur_frame = cur->frame[cur->curframe];
-					/* btf_check_iter_kfuncs() enforces that
-					 * iter state pointer is always the first arg
-					 */
-					iter_reg = &cur_frame->regs[BPF_REG_1];
-					/* current state is valid due to states_equal(),
-					 * so we can assume valid iter and reg state,
-					 * no need for extra (re-)validations
-					 */
-					spi = bpf_get_spi(iter_reg->var_off.value);
-					iter_frame = bpf_func(env, iter_reg);
-					iter_state = &bpf_stack_slot(iter_frame, spi)->spilled_ptr;
-					old_frame = sl->state.frame[iter_reg->frameno];
-					old_iter = &bpf_stack_slot(old_frame, spi)->spilled_ptr;
-					/*
-					 * states_equal() matches ids through idmap.
-					 * The loop converged only if it's the same
-					 * iterator. The one that was destroyed and
-					 * created again starts from the beginning.
-					 */
-					if (iter_state->iter.state == BPF_ITER_STATE_ACTIVE &&
-					    iter_state->id == old_iter->id) {
-						loop = true;
-						goto hit;
-					}
-				}
-				goto skip_inf_loop_check;
-			}
-			if (is_may_goto_insn_at(env, insn_idx)) {
-				if (sl->state.may_goto_depth != cur->may_goto_depth &&
-				    states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
-					loop = true;
-					goto hit;
-				}
-			}
-			if (bpf_calls_callback(env, insn_idx)) {
-				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
-					loop = true;
-					goto hit;
-				}
-				goto skip_inf_loop_check;
-			}
-			/*
-			 * If old state belongs to a control flow loop that we know terminates,
-			 * it should be safe to prune current state. However, account for the
-			 * following situation:
-			 *
-			 *   for (;;) {
-			 *     for (i = 0; i < 10; i++)
-			 *       ...
-			 *   }
-			 *
-			 * Here a backedge to a non-terminating outer loop is dominated by an exit
-			 * from the inner loop. Pruning at a re-entry to the inner loop therefore
-			 * would hide the fact that outer loop is non-terminating.
-			 * Hence, only allow pruning states within the same entry state.
-			 */
-			old_loop = current_loop(&sl->state);
-			cur_loop = current_loop(cur);
-			if (old_loop && cur_loop && in_a_terminating_loop(cur)) {
-				if (old_loop->terminates && cur_loop->terminates &&
-				    old_loop->entry_state == cur_loop->entry_state &&
-				    states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
-					loop = true;
-					goto hit;
-				}
-				goto skip_inf_loop_check;
-			}
-
-			/* attempt to detect infinite loop to avoid unnecessary doomed work */
-			if (states_maybe_looping(&sl->state, cur) &&
-			    states_equal(env, &sl->state, cur, EXACT) &&
-			    !iter_active_depths_differ(&sl->state, cur) &&
-			    sl->state.may_goto_depth == cur->may_goto_depth &&
-			    sl->state.callback_unroll_depth == cur->callback_unroll_depth) {
-				verbose_linfo(env, insn_idx, "; ");
-				verbose(env, "infinite loop detected at insn %d\n", insn_idx);
-				verbose(env, "cur state:");
-				print_verifier_state(env, cur, cur->curframe, true);
-				verbose(env, "old state:");
-				print_verifier_state(env, &sl->state, cur->curframe, true);
-				return -EINVAL;
-			}
-			/* if the verifier is processing a loop, avoid adding new state
-			 * too often, since different loop iterations have distinct
-			 * states and may not help future pruning.
-			 * This threshold shouldn't be too low to make sure that
-			 * a loop with large bound will be rejected quickly.
-			 * The most abusive loop will be:
-			 * r1 += 1
-			 * if r1 < 1000000 goto pc-2
-			 * 1M insn_procssed limit / 100 == 10k peak states.
-			 * This threshold shouldn't be too high either, since states
-			 * at the end of the loop are likely to be useful in pruning.
-			 */
-skip_inf_loop_check:
-			if (!force_new_state &&
-			    env->jmps_processed - env->prev_jmps_processed < 20 &&
-			    env->insn_processed - env->prev_insn_processed < 100)
-				add_new_state = false;
-			goto miss;
-		}
-		/* See comments for mark_all_regs_read_and_precise() */
-		loop = incomplete_read_marks(env, &sl->state);
-		if (states_equal(env, &sl->state, cur, loop ? RANGE_WITHIN : NOT_EXACT)) {
-hit:
-			sl->hit_cnt++;
-
-			/* if previous state reached the exit with precision and
-			 * current state is equivalent to it (except precision marks)
-			 * the precision needs to be propagated back in
-			 * the current state.
-			 */
-			err = 0;
-			if (bpf_is_jmp_point(env, env->insn_idx))
-				err = bpf_push_jmp_history(env, cur, 0, 0, 0, NULL, 0);
-			err = err ? : propagate_precision(env, &sl->state, cur, NULL);
-			if (err)
-				return err;
-			/* When processing iterator based loops above propagate_liveness and
-			 * propagate_precision calls are not sufficient to transfer all relevant
-			 * read and precision marks. E.g. consider the following case:
-			 *
-			 *  .-> A --.  Assume the states are visited in the order A, B, C.
-			 *  |   |   |  Assume that state B reaches a state equivalent to state A.
-			 *  |   v   v  At this point, state C is not processed yet, so state A
-			 *  '-- B   C  has not received any read or precision marks from C.
-			 *             Thus, marks propagated from A to B are incomplete.
-			 *
-			 * The verifier mitigates this by performing the following steps:
-			 *
-			 * - Prior to the main verification pass, strongly connected components
-			 *   (SCCs) are computed over the program's control flow graph,
-			 *   intraprocedurally.
-			 *
-			 * - During the main verification pass, `maybe_enter_scc()` checks
-			 *   whether the current verifier state is entering an SCC. If so, an
-			 *   instance of a `bpf_scc_visit` object is created, and the state
-			 *   entering the SCC is recorded as the entry state.
-			 *
-			 * - This instance is associated not with the SCC itself, but with a
-			 *   `bpf_scc_callchain`: a tuple consisting of the call sites leading to
-			 *   the SCC and the SCC id. See `compute_scc_callchain()`.
-			 *
-			 * - When a verification path encounters a `states_equal(...,
-			 *   RANGE_WITHIN)` condition, there exists a call chain describing the
-			 *   current state and a corresponding `bpf_scc_visit` instance. A copy
-			 *   of the current state is created and added to
-			 *   `bpf_scc_visit->backedges`.
-			 *
-			 * - When a verification path terminates, `maybe_exit_scc()` is called
-			 *   from `bpf_update_branch_counts()`. For states with `branches == 0`, it
-			 *   checks whether the state is the entry state of any `bpf_scc_visit`
-			 *   instance. If it is, this indicates that all paths originating from
-			 *   this SCC visit have been explored. `propagate_backedges()` is then
-			 *   called, which propagates read and precision marks through the
-			 *   backedges until a fixed point is reached.
-			 *   (In the earlier example, this would propagate marks from A to B,
-			 *    from C to A, and then again from A to B.)
-			 *
-			 * A note on callchains
-			 * --------------------
-			 *
-			 * Consider the following example:
-			 *
-			 *     void foo() { loop { ... SCC#1 ... } }
-			 *     void main() {
-			 *       A: foo();
-			 *       B: ...
-			 *       C: foo();
-			 *     }
-			 *
-			 * Here, there are two distinct callchains leading to SCC#1:
-			 * - (A, SCC#1)
-			 * - (C, SCC#1)
-			 *
-			 * Each callchain identifies a separate `bpf_scc_visit` instance that
-			 * accumulates backedge states. The `propagate_{liveness,precision}()`
-			 * functions traverse the parent state of each backedge state, which
-			 * means these parent states must remain valid (i.e., not freed) while
-			 * the corresponding `bpf_scc_visit` instance exists.
-			 *
-			 * Associating `bpf_scc_visit` instances directly with SCCs instead of
-			 * callchains would break this invariant:
-			 * - States explored during `C: foo()` would contribute backedges to
-			 *   SCC#1, but SCC#1 would only be exited once the exploration of
-			 *   `A: foo()` completes.
-			 * - By that time, the states explored between `A: foo()` and `C: foo()`
-			 *   (i.e., `B: ...`) may have already been freed, causing the parent
-			 *   links for states from `C: foo()` to become invalid.
-			 */
-			if (loop) {
-				struct bpf_scc_backedge *backedge;
-
-				backedge = kzalloc_obj(*backedge,
-						       GFP_KERNEL_ACCOUNT);
-				if (!backedge)
-					return -ENOMEM;
-				err = bpf_copy_verifier_state(&backedge->state, cur);
-				backedge->state.equal_state = &sl->state;
-				backedge->state.insn_idx = insn_idx;
-				err = err ?: add_scc_backedge(env, &sl->state, backedge);
-				if (err) {
-					bpf_free_verifier_state(&backedge->state, false);
-					kfree(backedge);
-					return err;
-				}
-			}
-			return 1;
-		}
-miss:
-		/* when new state is not going to be added do not increase miss count.
-		 * Otherwise several loop iterations will remove the state
-		 * recorded earlier. The goal of these heuristics is to have
-		 * states from some iterations of the loop (some in the beginning
-		 * and some at the end) to help pruning.
-		 */
-		if (add_new_state)
-			sl->miss_cnt++;
-		/* heuristic to determine whether this state is beneficial
-		 * to keep checking from state equivalence point of view.
-		 * Higher numbers increase max_states_per_insn and verification time,
-		 * but do not meaningfully decrease insn_processed.
-		 * 'n' controls how many times state could miss before eviction.
-		 * Use bigger 'n' for checkpoints because evicting checkpoint states
-		 * too early would hinder iterator convergence.
-		 */
-		n = (bpf_is_force_checkpoint(env, insn_idx) || loop_checkpoint) &&
-		    sl->state.branches > 0 ? 64 : 3;
-		if (sl->miss_cnt > sl->hit_cnt * n + n) {
-			/* the state is unlikely to be useful. Remove it to
-			 * speed up verification
-			 */
-			sl->in_free_list = true;
-			list_del(&sl->node);
-			list_add(&sl->node, &env->free_list);
-			env->free_list_size++;
-			env->explored_states_size--;
-			maybe_free_verifier_state(env, sl);
-		}
-	}
-
-	if (env->max_states_per_insn < states_cnt)
-		env->max_states_per_insn = states_cnt;
-
-	if (!env->bpf_capable && states_cnt > BPF_COMPLEXITY_LIMIT_STATES)
-		return 0;
-
-	if (!add_new_state)
-		return 0;
-
-	/* There were no equivalent states, remember the current one.
-	 * Technically the current state is not proven to be safe yet,
-	 * but it will either reach outer most bpf_exit (which means it's safe)
-	 * or it will be rejected. When there are no loops the verifier won't be
-	 * seeing this tuple (frame[0].callsite, frame[1].callsite, .. insn_idx)
-	 * again on the way to bpf_exit.
-	 * When looping the sl->state.branches will be > 0 and this state
-	 * will not be considered for equivalence until branches == 0.
-	 */
-	return bpf_split_cur_state(env);
-}
-
 int bpf_clean_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
 {
 	return clean_verifier_state(env, st);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ef68796c04dd..616a69b4cfb5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -202,8 +202,6 @@ struct bpf_verifier_stack_elem {
 	u64 diag_log_pos;
 };
 
-#define BPF_COMPLEXITY_LIMIT_STATES	64
-
 #define BPF_GLOBAL_PERCPU_MA_MAX_SIZE  512
 
 #define BPF_PRIV_STACK_MIN_SIZE		64
@@ -1082,7 +1080,6 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
 		st->iter.btf_id = btf_id;
 		st->iter.state = BPF_ITER_STATE_ACTIVE;
 		st->iter.loops = nr_loops_below(env->cur_state, env->cur_state->curframe + 1);
-		st->iter.depth = 0;
 
 		for (j = 0; j < BPF_REG_SIZE; j++)
 			slot->slot_type[j] = STACK_ITER;
@@ -1826,14 +1823,9 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
 	dst_state->flow_entry = src->flow_entry;
 	dst_state->insn_idx = src->insn_idx;
 	dst_state->curframe = src->curframe;
-	dst_state->branches = src->branches;
 	dst_state->parent = src->parent;
 	dst_state->first_insn_idx = src->first_insn_idx;
 	dst_state->last_insn_idx = src->last_insn_idx;
-	dst_state->dfs_depth = src->dfs_depth;
-	dst_state->callback_unroll_depth = src->callback_unroll_depth;
-	dst_state->may_goto_depth = src->may_goto_depth;
-	dst_state->equal_state = src->equal_state;
 	for (i = 0; i <= src->curframe; i++) {
 		dst = dst_state->frame[i];
 		if (!dst) {
@@ -1849,45 +1841,6 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
 	return 0;
 }
 
-static u32 state_htab_size(struct bpf_verifier_env *env)
-{
-	return env->prog->len;
-}
-
-struct list_head *bpf_explored_state(struct bpf_verifier_env *env, int idx)
-{
-	struct bpf_verifier_state *cur = env->cur_state;
-	struct bpf_func_state *state = cur->frame[cur->curframe];
-
-	return &env->explored_states[(idx ^ state->callsite) % state_htab_size(env)];
-}
-
-static bool same_callsites(struct bpf_verifier_state *a, struct bpf_verifier_state *b)
-{
-	int fr;
-
-	if (a->curframe != b->curframe)
-		return false;
-
-	for (fr = a->curframe; fr >= 0; fr--)
-		if (a->frame[fr]->callsite != b->frame[fr]->callsite)
-			return false;
-
-	return true;
-}
-
-void bpf_free_backedges(struct bpf_scc_visit *visit)
-{
-	struct bpf_scc_backedge *backedge, *next;
-
-	for (backedge = visit->backedges; backedge; backedge = next) {
-		bpf_free_verifier_state(&backedge->state, false);
-		next = backedge->next;
-		kfree(backedge);
-	}
-	visit->backedges = NULL;
-}
-
 static int pop_stack(struct bpf_verifier_env *env, int *prev_insn_idx,
 		     int *insn_idx, bool pop_log)
 {
@@ -1953,18 +1906,6 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	if (err)
 		return ERR_PTR(-ENOMEM);
 	elem->st.speculative |= speculative;
-	if (elem->st.parent) {
-		++elem->st.parent->branches;
-		/* WARN_ON(branches > 2) technically makes sense here,
-		 * but
-		 * 1. speculative states will bump 'branches' for non-branch
-		 * instructions
-		 * 2. is_state_visited() heuristics may decide not to create
-		 * a new state for a sequence of branches and all such current
-		 * and cloned states will be pointing to a single parent state
-		 * which might have large 'branches' count.
-		 */
-	}
 	return &elem->st;
 }
 
@@ -2636,7 +2577,6 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	 * This is async callback. It starts in a fresh stack.
 	 * Initialize it similar to do_check_common().
 	 */
-	elem->st.branches = 1;
 	elem->st.in_sleepable = is_sleepable;
 	frame = kzalloc_obj(*frame, GFP_KERNEL_ACCOUNT);
 	if (!frame)
@@ -9228,85 +9168,6 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 	return 0;
 }
 
-/* Look for a previous loop entry at insn_idx: nearest parent state
- * stopped at insn_idx with callsites matching those in cur->frame.
- */
-static struct bpf_verifier_state *find_prev_entry(struct bpf_verifier_env *env,
-						  struct bpf_verifier_state *cur,
-						  int insn_idx)
-{
-	struct bpf_verifier_state_list *sl;
-	struct bpf_verifier_state *st;
-	struct list_head *pos, *head;
-
-	/* Explored states are pushed in stack order, most recent states come first */
-	head = bpf_explored_state(env, insn_idx);
-	list_for_each(pos, head) {
-		sl = container_of(pos, struct bpf_verifier_state_list, node);
-		/* If st->branches != 0 state is a part of current DFS verification path,
-		 * hence cur & st for a loop.
-		 */
-		st = &sl->state;
-		if (st->insn_idx == insn_idx && st->branches && same_callsites(st, cur) &&
-		    st->dfs_depth < cur->dfs_depth)
-			return st;
-	}
-
-	return NULL;
-}
-
-/*
- * Check if scalar registers are exact for the purpose of not widening.
- * More lenient than regs_exact()
- */
-static bool scalars_exact_for_widen(const struct bpf_reg_state *rold,
-				    const struct bpf_reg_state *rcur)
-{
-	return !memcmp(rold, rcur, offsetof(struct bpf_reg_state, id));
-}
-
-static void maybe_widen_reg(struct bpf_verifier_env *env,
-			    struct bpf_reg_state *rold, struct bpf_reg_state *rcur)
-{
-	if (rold->type != SCALAR_VALUE)
-		return;
-	if (rold->type != rcur->type)
-		return;
-	if (rold->precise || rcur->precise || scalars_exact_for_widen(rold, rcur))
-		return;
-	__mark_reg_unknown(env, rcur);
-}
-
-static int widen_imprecise_scalars(struct bpf_verifier_env *env,
-				   struct bpf_verifier_state *old,
-				   struct bpf_verifier_state *cur)
-{
-	struct bpf_func_state *fold, *fcur;
-	int i, fr, num_slots;
-
-	for (fr = old->curframe; fr >= 0; fr--) {
-		fold = old->frame[fr];
-		fcur = cur->frame[fr];
-
-		for (i = 0; i < MAX_BPF_REG; i++)
-			maybe_widen_reg(env,
-					&fold->regs[i],
-					&fcur->regs[i]);
-
-		num_slots = min(bpf_stack_nr_slots(fold), bpf_stack_nr_slots(fcur));
-		for (i = 0; i < num_slots; i++) {
-			struct bpf_stack_state *old_ss = bpf_stack_slot(fold, i);
-			struct bpf_stack_state *cur_ss = bpf_stack_slot(fcur, i);
-
-			if (!bpf_is_spilled_reg(old_ss) || !bpf_is_spilled_reg(cur_ss))
-				continue;
-
-			maybe_widen_reg(env, &old_ss->spilled_ptr, &cur_ss->spilled_ptr);
-		}
-	}
-	return 0;
-}
-
 static struct bpf_reg_state *get_iter_from_state(struct bpf_verifier_state *cur_st,
 						 struct bpf_call_arg_meta *meta)
 {
@@ -9454,13 +9315,11 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 
 		queued_iter = get_iter_from_state(queued_st, meta);
 		queued_iter->iter.state = BPF_ITER_STATE_ACTIVE;
-		queued_iter->iter.depth++;
 
 		queued_fr = queued_st->frame[queued_st->curframe];
 		mark_ptr_not_null_reg(&queued_fr->regs[BPF_REG_0]);
 	}
 
-	/* switch to DRAINED state, but keep the depth unchanged */
 	/* mark current iter state as drained and assume returned NULL */
 	cur_iter->iter.state = BPF_ITER_STATE_DRAINED;
 	__mark_reg_const_zero(env, &cur_fr->regs[BPF_REG_0]);
@@ -12014,7 +11873,6 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	if (err)
 		return err;
 
-	callback_state->callback_unroll_depth++;
 	callback_state->frame[callback_state->curframe - 1]->callback_depth++;
 	caller->callback_depth = 0;
 	return 0;
@@ -12975,10 +12833,9 @@ static bool retval_range_within(struct bpf_retval_range range, const struct bpf_
 
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 {
-	struct bpf_verifier_state *state = env->cur_state, *prev_st;
+	struct bpf_verifier_state *state = env->cur_state;
 	struct bpf_func_state *caller, *callee;
 	struct bpf_reg_state *r0;
-	bool in_callback_fn;
 	u32 i, nregs;
 	int err;
 
@@ -13067,11 +12924,9 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	invalidate_stack_slices(env, callee->frameno, INT_MIN, 0);
 
 	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to callsite,
-	 * there function call logic would reschedule callback visit. If iteration
-	 * converges is_state_visited() would prune that visit eventually.
+	 * there function call logic would reschedule callback visit.
 	 */
-	in_callback_fn = callee->in_callback_fn;
-	if (in_callback_fn)
+	if (callee->in_callback_fn)
 		*insn_idx = callee->callsite;
 	else
 		*insn_idx = callee->callsite + 1;
@@ -13088,24 +12943,6 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	free_func_state(callee);
 	state->frame[state->curframe--] = NULL;
 	invalidate_outgoing_stack_args(env, caller);
-
-	/* for callbacks widen imprecise scalars to make programs like below verify:
-	 *
-	 *   struct ctx { int i; }
-	 *   void cb(int idx, struct ctx *ctx) { ctx->i++; ... }
-	 *   ...
-	 *   struct ctx = { .i = 0; }
-	 *   bpf_loop(100, cb, &ctx, 0);
-	 *
-	 * This is similar to what is done in process_iter_next_call() for open
-	 * coded iterators.
-	 */
-	prev_st = in_callback_fn ? find_prev_entry(env, state, *insn_idx) : NULL;
-	if (prev_st) {
-		err = widen_imprecise_scalars(env, prev_st, state);
-		if (err)
-			return err;
-	}
 	return 0;
 }
 
@@ -20140,19 +19977,14 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	}
 
 	if (opcode == BPF_JCOND) {
-		struct bpf_verifier_state *cur_st = env->cur_state, *queued_st, *prev_st;
+		struct bpf_verifier_state *queued_st;
 		int idx = *insn_idx;
 
-		prev_st = find_prev_entry(env, cur_st->parent, idx);
-
 		/* branch out 'fallthrough' insn as a new state to explore */
 		queued_st = push_stack(env, idx + 1, idx, false);
 		if (IS_ERR(queued_st))
 			return PTR_ERR(queued_st);
 
-		queued_st->may_goto_depth++;
-		if (prev_st)
-			widen_imprecise_scalars(env, prev_st, queued_st);
 		*insn_idx += insn->off;
 		return 0;
 	}
@@ -21620,7 +21452,6 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 	case BPF_JMP32: {
 		u8 opcode = BPF_OP(insn->code);
 
-		env->jmps_processed++;
 		if (opcode == BPF_CALL) {
 			if (env->cur_state->active_locks) {
 				/* similar to static subprog calls callx is allowed under a lock */
@@ -23590,46 +23421,10 @@ static void sanitize_dead_code(struct bpf_verifier_env *env)
 
 static void free_states(struct bpf_verifier_env *env)
 {
-	struct bpf_verifier_state_list *sl;
-	struct list_head *head, *pos, *tmp;
-	struct bpf_scc_info *info;
-	int i, j;
-
 	bpf_free_verifier_state(env->cur_state, true);
 	env->cur_state = NULL;
 	while (!pop_stack(env, NULL, NULL, false));
 	bpf_flow_reset(env);
-
-	list_for_each_safe(pos, tmp, &env->free_list) {
-		sl = container_of(pos, struct bpf_verifier_state_list, node);
-		bpf_free_verifier_state(&sl->state, false);
-		kfree(sl);
-	}
-	INIT_LIST_HEAD(&env->free_list);
-
-	for (i = 0; i < env->scc_cnt; ++i) {
-		info = env->scc_info[i];
-		if (!info)
-			continue;
-		for (j = 0; j < info->num_visits; j++)
-			bpf_free_backedges(&info->visits[j]);
-		kvfree(info);
-		env->scc_info[i] = NULL;
-	}
-
-	if (!env->explored_states)
-		return;
-
-	for (i = 0; i < state_htab_size(env); i++) {
-		head = &env->explored_states[i];
-
-		list_for_each_safe(pos, tmp, head) {
-			sl = container_of(pos, struct bpf_verifier_state_list, node);
-			bpf_free_verifier_state(&sl->state, false);
-			kfree(sl);
-		}
-		INIT_LIST_HEAD(&env->explored_states[i]);
-	}
 }
 
 static int do_check_common(struct bpf_verifier_env *env, int subprog,
@@ -23652,7 +23447,6 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog,
 		return -ENOMEM;
 	state->curframe = 0;
 	state->speculative = false;
-	state->branches = 1;
 	state->in_sleepable = context == BPF_FUNC_CTX_SLEEPABLE;
 	/* nobody knows what the callers of a global function or of an extension hold */
 	state->callers_unknown = subprog || env->prog->type == BPF_PROG_TYPE_EXT;
@@ -25746,13 +25540,9 @@ static void log_program(struct bpf_verifier_env *env)
 	u64 pos, insn_pos;
 	u32 i, j;
 
-	verbose(env, "Program dump (scc? loop_header? idom insn#: live_regs_before):\n");
+	verbose(env, "Program dump (loop_header? idom insn#: live_regs_before):\n");
 	for (i = 0; i < insn_cnt; ++i) {
 		verbose_linfo(env, i, "    ; ");
-		if (env->insn_aux_data[i].scc)
-			verbose(env, "%3d ", env->insn_aux_data[i].scc);
-		else
-			verbose(env, "    ");
 		if (env->insn_aux_data[i].loop_header >= 0)
 			verbose(env, "%3d ", env->insn_aux_data[i].loop_header);
 		else
@@ -25875,21 +25665,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (attr->prog_flags & BPF_F_ANY_ALIGNMENT)
 		env->strict_alignment = false;
 
-	if (is_priv)
-		env->test_state_freq = attr->prog_flags & BPF_F_TEST_STATE_FREQ;
 	env->test_reg_invariants = attr->prog_flags & BPF_F_TEST_REG_INVARIANTS;
 
-	env->explored_states = kvzalloc_objs(struct list_head,
-					     state_htab_size(env),
-					     GFP_KERNEL_ACCOUNT);
-	ret = -ENOMEM;
-	if (!env->explored_states)
-		goto skip_full_check;
-
-	for (i = 0; i < state_htab_size(env); i++)
-		INIT_LIST_HEAD(&env->explored_states[i]);
-	INIT_LIST_HEAD(&env->free_list);
-
 	/* Prepare BTF and func_info needed to discover all subprograms. */
 	ret = bpf_prepare_btf_info(env, attr, uattr);
 	if (ret < 0)
@@ -25978,10 +25755,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
-	ret = bpf_compute_scc(env);
-	if (ret < 0)
-		goto skip_full_check;
-
 	/* must precede the first bpf_ret_reg_pair() user below */
 	ret = bpf_compute_subprog_ret_regs(env);
 	if (ret < 0)
@@ -26054,8 +25827,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 		ret = bpf_insert_loop_guards(env);
 
 skip_full_check:
-	kvfree(env->explored_states);
-
 	/* might decrease stack depth, keep it before passes that
 	 * allocate additional slots.
 	 */
@@ -26208,7 +25979,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	bpf_stack_liveness_free(env);
 	kvfree(env->cfg.postorder_nums);
 	kvfree(env->cfg.insn_postorder);
-	kvfree(env->scc_info);
 	kvfree(env->succ);
 	kvfree(env->gotox_tmp_buf);
 	kvfree(env->callx_edges);
-- 
2.55.0

