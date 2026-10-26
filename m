Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983899;
	b=Dno4uLiGrR8I+GlRcpZV9J9BKeTZJQX6m+MwR6iBiVlTSbfNzoQSpeAUzycX766Q2ApI
	 Zl5rVqcMlnDmA18VeP2bqq5e5xxDPdscLqq+8en4cdSOBpPpMto7asb9MjHtXUovWbZWl
	 x5tGkvOB9Z+dsRxPc7735IUONUqnT1wr+VBiUcy1NgTN9yapEEmywjnzrYfAaRbJFVpUY
	 bNXK8q3yAd7GsCz0CjEb4CEi06rJcq9+9nUk+36GXHquGqBCQ25RC88N84iS+J5Z/W7YZ
	 0qBRp6MSwAZVZqk7lxzxpVgp9UPKnTjFYKViIRC4UAyHPlgPi/OjC+6wTXzFS8IAhuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=a+7Ij/c4b92CKAylTQFuisE/wyTJ0CnjYZPPGUXmprc=;
	b=zj6a6Nddcp9Hfji8yW+d0GaKTYyQuU+YVp2YIuXydCnR2ZZNkRYJxi3nhDAeQDRjVer/
	 2cTt1LSe8D7w+eSLtv5CcDqxzymRH5T7Svu6v5ivaTfkrcogJi+ZSvHZrEXBGMrKbFo7x
	 a0sG09ngMNT61TfLkz3TxR5e3lgVvduudto+qA4zTpirX4+ELDhf41ASW7pYxPF/+aC+n
	 WyFT/yWTQnvAdnl8VLpLShk/fIGjgBX3oRJ62oVuQ2R9c5cU+q2fQslOS9tMAEnmHh3/2
	 ifPD233j0mUsq3JWlgN/OwVzDCnRFFHdczoYAxmnKD2HO16GmSWbazwMi+NKhrjWiZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mf584nBn;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B781606A31B
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B781606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mf584nBn
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso1357443a12.0
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983898; x=1793588698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a+7Ij/c4b92CKAylTQFuisE/wyTJ0CnjYZPPGUXmprc=;
        b=mf584nBnfmqVoYRtdVimv/DE93rQxQbbjbmyQbAEvP9q4BLzcR5IVaKuPV6axvjcAS
         anwMosjkyXQWeL1tSRTUiepXo+EE9xmHhNVrtahF6GDBhj5GnPWkiTG9ToZK+oEM+vUM
         X4h1ciiGTJ/aU/g9Ir5q9dTCYei99geEdL8Dl1CnHKNFiNT82E/4d+r1BQZQ8oQxoR+Y
         pCT+FggR204PhUWxQco8DTcBVW0iIFSR6shP3RfItLzs/si2LK83V9dRmthDK8YrHnR1
         Ih0NiyY9/4PrfQQizR7jnaGrygBo4ykW4fMJNY4VnjEprtoKaYejtqZAwkOtx3f3NYlW
         6e/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983898; x=1793588698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a+7Ij/c4b92CKAylTQFuisE/wyTJ0CnjYZPPGUXmprc=;
        b=sutSedXRxVmXdOorSTjXumudLRoVA8c7sWM3+Rt6WFPZpCoVn1mo23l5lME4vkfBbS
         gdgX96KuZPXxvIL02zz+gQVPtDcr7hMv3BzMLNR6KSwHL5AT4tAEO+sfiWx+Dbq2OsAY
         BIX9Kmmsdzt46zFORkmpbl1oVUr37mS0BorLZWRedmo7H7/nuJgULxP0YaoTQw0GXT57
         1u+xF0QrBRQZbkdoedvynCmwYK4n+rjfXz4wgd06XkDrsJZq1up2lTwN5jaOPRGGXtwM
         bLKBRwbIphFaIZMolRoLY3Qpa2brP8Kz0N2NnaMd8OUjv5++5WmjW9UYLor7KCdpqmcY
         g/zA==
X-Gm-Message-State: AFq9FYJq62L35SrMQ6OQTWcUwBXXO/xH5M6bAt+8jjJBaPKxROVA0OTO
	0Q9B4UY+NuYo8nAZBvO3Fa48TijK0m5ZJjbu/udKpPow/2swyowzCDFMrOWTxg==
X-Gm-Gg: AYBFou3S9Nz0rjl89b8E9VZLJ2Xg8XMohOtRZGHXstq/HKJ2L0xbKpXNY+RxqP/otuT
	roxnZv9lQPlCsIBofP/VNoBRVe39Xef8cv4gepit1IjHfwsj6bDhTU2D20D1NC21Tb+3fPsFYbO
	20gB0VmGFTl1N4w0RX8QkCQ+CG7SPFIl+s2Did4yLvJiNtMzD8vCDM8R03HifRzoVulT8FEfJyM
	q3jPwyudhSNluUk+e10EaG4GxM3FiO1sojyQvP9U9MYK7YOuOic1sWwbzH1yS6OYQt3/fvwBKB7
	9eg57EKneBVa4/B7L011L5sxUoczEHy5DKdOAYbHJmxWJMqMykuc29oJUkifZOkIV6dvvLefCLr
	+A3NU46NB4lFJd+wE+6fz8La3Y/9GCfg0S2aVHx5nMWzGQR/jL52qbLVHmLbSssHg98ppJxz/en
	JEUzGt/oASaAs1fJhusEzUoAMbbu1C6DSQvO+bT/sZnLtaOyWoP5srDW1XYMmB6gqyMJP3YOlzV
	SK9tfbguGgPAiRpO0DOFVCFaQ1W314jIMekFb8PIoJoA/A1di4vhb8IWGiofIp9AsFVxaz5GyXQ
	iNxSLgW7B3UGQoA9vKNW5fnsDItdWl1yCWcFVustfU/VwXb7aHrO9t9dFg/Qu8YwN6MALjaMjmq
	5gJBEYGLnMN7db2HBzxfAC39klxbqDw2f0aBZiHhZD3BUUL0=
X-Received: by 2002:a17:90b:53cf:b0:3a4:b418:94cf with SMTP id 98e67ed59e1d1-3adead57bedmr4726714a91.14.1792983896712;
        Sun, 25 Oct 2026 20:04:56 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeb83b35esm4232710a91.0.2026.10.25.20.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:04:56 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 53/81] bpf: Verify programs as a fixpoint over the control flow graph
Date: Mon, 26 Oct 2026 02:59:14 +0000
Message-ID: <20261026025943.404450-54-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

The verifier follows each path of a prog from the first insn to exit. It
stops a path when a state that it saw before at the same insn covers the
current state. Each branch can double the number of paths. Thus the
verifier has limits of 1M insns and 8K jumps, and large progs hit them.

Do not follow paths. Where two paths meet, make one state that covers the
two states. This operation is a join. What is safe for the join is safe for
each of the two states.

     follow each path                       join

          [if]                              [if]
         /    \                            /    \
      r1=1    r1=5                      r1=1    r1=5
         \    /                            \    /
         [next]                            [next]
    verified 2 times:                 verified 1 time:
    r1=1, then r1=5                   r1=[1,5]

The work depends on the size of the prog, not on the number of paths.
Remove the two limits. flow.c limits the number of states, in proportion to
the size of the prog.

Some states have no join, for example a pointer and a scalar in the same
register. flow.c also refuses a join that loses a fact that progs depend
on. Thus each basic block has a set of states, not one state.

  a state arrives at a basic block        the verifier
  --------------------------------------  ---------------------------------
  a state of the set covers it            drops it
  it has a join with a state of the set   replaces that state with the join
  all other cases                         adds it to the set

The verifier verifies a block with each new state of its set. It stops when
no set has a new state. This is the fixpoint.

flow.c and join.c contain the algorithm. Build them and call them from
do_check(). The check of one insn does not change.

bpf_flow_loop_enter() makes the state that enters a loop cover all
iterations. Then one pass through the body is usually sufficient. If a
state comes back to the loop head and is not covered, the verifier joins
the two states and removes the bound that grows. Thus the pass ends.

Such a state shows that each iteration is safe, but not that the loop ends.
Thus the verifier adds may_goto to a loop that it cannot bound. may_goto
exits a loop when a run of the prog takes too long.

  loop                            state at the loop head         added
  ------------------------------  -----------------------------  --------
  scalar evolution counts the     each induction variable has    nothing
  iterations                      its range over all iterations
  the verifier can unroll it      one state for each iteration   nothing
  to its end
  each iteration has may_goto     the scalars that the loop      nothing
  or bpf_iter_*_next()            changes are unknown
  all other loops                 the same                       may_goto
  no exit                         rejected: loop at insn N never exits

Recursion has the same problem. A subprog on a cycle of the call graph gets
a check at its entry. The check limits the stack and the number of calls in
a run. A callback that passes its own address to a helper is on a cycle
too. mark_recursive_subprogs() has the cases that stay rejected, for
example recursion of the main prog.

Before this patch the verifier rejected recursion, and loops that it could
neither count nor follow to the end. They load now.

The jump of an added check is a new edge of the prog. The verifier verifies
it like each other edge. It selects the target at load time:

  the frame holds only the references and locks that it held at its entry
    main prog, async callback                        r0 = 0; exit
    subprog, unwind_goto follows each call of it     r0 = 0; unwind_exit
  all other cases
    loop                                             exit from the loop
    recursive subprog                                r0 = 0; exit

unwind_exit continues in the cleanup code of the callers.

The verifier verifies a static subprog for each state at its entry, not for
each chain of calls. The state of the caller waits for the exit states.
This is correct only if the subprog cannot access the frames of its
callers. func_is_on_its_own() has the exceptions, for example a pointer to
the stack. Then the frames of the callers stay in the state, as before.

Most progs that loaded before get the same code. The usual causes of
different code are added may_goto, added recursion checks, and a jump that
a join leaves open. Each path decides such a jump, the joined state does
not, and dead code stays in the prog.

The cost of added may_goto on x86-64 (Zen 5) with hot caches, in nsec:

  each iteration, the body only counts            0.29 -> 0.45
  each iteration, the body does a hash lookup     +0.15 (+6%)
  each run of the prog                            +0.43
  each call of a subprog that has may_goto        +0.28 .. +0.34

A join loses the relation between scalars. The verifier now rejects this
prog:

  if (c) { i = 3; n = 4; } else { i = 7; n = 8; }
  arr[n - i]

      { i=3 n=4 }      { i=7 n=8 }        n - i is 1 in each state
                \      /
          { i=[3,7] n=[4,8] }             n - i is [-3, 5]

Other changes:
 - may_goto at a loop head skips the body. The code after the loop can read
   registers and stack slots that only the body sets. The verifier sets
   them to 0 on this edge.
 - Such a register can be a pointer to arena. Thus, in a prog that has an
   arena, a load or a store through the scalar 0 is an access to arena.
   This is safe, because an access to arena cannot leave the arena.
 - If the pass finds that an iterator does not stop its loop, the pass
   starts again, and the loop gets may_goto.
 - Pruning, jmp_history and precision marks have no function now. This
   patch only disables them. "bpf: Remove is_state_visited()" and
   subsequent patches remove the code.
 - The verifier log shows the states of basic blocks, not paths.

A: the previous patch. B: this patch. Progs load in the two runs. Insns is
the number of insns that the verifier processes.

Corpus             Progs  Insns (A)  Insns (B)        Insns (DIFF)
-----------------  -----  ---------  ---------  ------------------
selftests           3714    6843490    2676019  -4167471 (-60.90%)
cilium               144    1151493     282948   -868545 (-75.43%)
scx, as in BPF CI    394    1296250     253946  -1042304 (-80.41%)
scx, master          468    3415944     475390  -2940554 (-86.08%)
tools/sched_ext      240     118790      37454    -81336 (-68.47%)

No prog of Cilium or sched-ext/scx changes its verdict.

One prog with 5,000 insns or more regresses. mlfq_dispatch of scx_mlfq has
nested loops that are not counted: 12902 -> 15673 (+21.48%).

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   71 +-
 kernel/bpf/Makefile          |    2 +-
 kernel/bpf/backtrack.c       |    7 +
 kernel/bpf/const_fold.c      |    6 +
 kernel/bpf/log.c             |    5 +
 kernel/bpf/states.c          |   19 +-
 kernel/bpf/verifier.c        | 1400 +++++++++++++++++++++++++++++-----
 7 files changed, 1308 insertions(+), 202 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 16987fa282b3..41ffe9b694a6 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -353,8 +353,26 @@ struct loop_stack_entry {
 	struct bpf_verifier_state *entry_state;
 	u32 min_header_count;
 	u32 max_header_count;
-	u32 loop_id:31;
+	u32 loop_id:27;
 	u32 terminates:1;
+	/*
+	 * The iterations are kept apart: states with different @trip are not
+	 * compared and not joined for as long as they are in the loop.
+	 */
+	u32 apart:1;
+	/* max_header_count follows from the state at the entry, not from patience */
+	u32 counted:1;
+	/* the walk goes on for as long as the jumps that leave the loop are decided */
+	u32 probe:1;
+	/* one of them went both ways */
+	u32 undecided:1;
+	u32 trip;
+	/*
+	 * A walk on patience: env->insn_processed at its start and how much it may grow.
+	 * The size of the loop says nothing about the functions that it calls.
+	 */
+	u32 walk_start;
+	u32 walk_patience;
 	int iv_reg;
 	struct cnum64 iv_range;
 };
@@ -416,6 +434,10 @@ struct bpf_func_state {
 	 * subprogram (loops never cross subprogram boundaries).
 	 */
 	u32 loop_stack_cnt;
+	/* What was held when the frame was entered. More than that is for this frame to release. */
+	u32 entry_refs;
+	u32 entry_rcu_locks;
+	u32 entry_preempt_locks;
 
 	/* The following fields should be last. See copy_func_state() */
 	/* The state of the stack. Each element of the array describes BPF_REG_SIZE
@@ -546,8 +568,17 @@ struct bpf_verifier_state {
 
 	bool speculative;
 	bool in_sleepable;
+	/* a function that is verified on its own and is called from a callback */
+	bool in_callback;
+	/* a global function or an extension, and what it calls: exit of frame 0 is not the end */
+	bool callers_unknown;
 	/* The callee left with unwind_exit. Next insn is unwind_goto. */
 	bool unwound;
+	/*
+	 * Not zero in a function that is verified on its own: the call that the
+	 * state at its entry came from, see bpf_flow_call().
+	 */
+	u32 flow_entry;
 
 	/*
 	 * First and last insn idx of this verifier state.
@@ -1022,14 +1053,21 @@ struct bpf_subprog_info {
 	 * a hidden pointer to the result, a pair in two registers, no dead arguments.
 	 */
 	bool stack_args_from_code: 1;
+	/* it releases what its caller holds, so it's verified in the context of such caller */
+	bool releases_inherited: 1;
+	/* a call of it was verified on its own: its insns are not in insns_total of the caller */
+	bool on_its_own: 1;
 	/* it can leave with unwind_exit: it has one, or unwind_goto follows every call of it */
 	bool bail_unwinds: 1;
+	/* some call of it is not followed by unwind_goto */
+	bool plain_call: 1;
 	u8 code_stack_args:4;
 	u8 arg_slot_cnt:4;
 
 	enum priv_stack_mode priv_stack_mode;
 	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_ARGS];
 	u32 recursion_weight; /* see bpf_insert_recursion_checks() */
+	int bail_insn; /* an exit of it, for the main pass. -1 if there is none */
 	u16 stack_arg_cnt; /* incoming + max outgoing */
 	u16 max_out_stack_arg_cnt;
 };
@@ -1131,6 +1169,7 @@ struct bpf_verifier_env {
 	bool test_state_freq;		/* test verifier with different pruning frequency */
 	bool test_reg_invariants;	/* fail verification on register invariants violations */
 	bool uses_arena_sp;		/* the program has insns with BPF_REG_ARENA_SP */
+	bool restart;			/* do the main pass again with what was found out */
 	u32 max_arena_stack_depth;	/* of all call chains */
 	struct bpf_verifier_state *cur_state; /* current verifier state */
 	/* Search pruning optimization, array of list_heads for
@@ -1275,6 +1314,7 @@ struct bpf_verifier_env {
 	struct bpf_iarray *gotox_tmp_buf;
 	int *idoms;
 	struct scev *scev;
+	struct bpf_flow *flow;
 	struct bpf_join_state *join;
 };
 
@@ -1459,15 +1499,44 @@ void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
 int mark_chain_precision(struct bpf_verifier_env *env, int regno);
 
 int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx);
+int bpf_clean_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
+bool bpf_state_subsumes(struct bpf_verifier_env *env, struct bpf_verifier_state *old,
+			struct bpf_verifier_state *cur);
+
 /* join.c */
 int bpf_states_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst,
 		    const struct bpf_verifier_state *a, const struct bpf_verifier_state *b,
 		    bool widen);
 void bpf_join_free(struct bpf_verifier_env *env);
 
+/* flow.c */
+int bpf_flow_prepare(struct bpf_verifier_env *env);
+void bpf_flow_reset(struct bpf_verifier_env *env);
+void bpf_flow_free(struct bpf_verifier_env *env);
+bool bpf_flow_is_point(struct bpf_verifier_env *env, int insn_idx);
+struct bpf_verifier_state *bpf_flow_keep_state(struct bpf_verifier_env *env,
+					       const struct bpf_verifier_state *st);
+int bpf_flow_deliver(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+		     int insn_idx, int prev_insn_idx);
+int bpf_flow_park(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+		  int insn_idx, int prev_insn_idx);
+void bpf_flow_unpark(struct bpf_verifier_env *env, int prev_insn_idx);
+int bpf_flow_deliver_unparked(struct bpf_verifier_env *env);
+int bpf_flow_next(struct bpf_verifier_env *env, int *prev_insn_idx);
+int bpf_flow_call(struct bpf_verifier_env *env, struct bpf_verifier_state *caller,
+		  struct bpf_verifier_state *entry, int subprog, int call_idx);
+int bpf_flow_exit(struct bpf_verifier_env *env, struct bpf_verifier_state *st, int exit_idx);
+/* verifier.c, for flow.c */
+int bpf_flow_loop_leave(struct bpf_verifier_env *env, bool *enters);
+int bpf_flow_loop_enter(struct bpf_verifier_env *env, bool *backedge, bool *drop);
+int bpf_flow_return(struct bpf_verifier_env *env, struct bpf_verifier_state *caller,
+		    const struct bpf_verifier_state *exit, int call_idx);
 int bpf_insert_loop_guards(struct bpf_verifier_env *env);
 int bpf_insert_recursion_reports(struct bpf_verifier_env *env);
 int bpf_insert_unwound_reports(struct bpf_verifier_env *env);
+u16 bpf_kfunc_const_arg_regs(struct bpf_verifier_env *env, struct bpf_insn *insn);
+u16 bpf_helper_const_arg_regs(struct bpf_verifier_env *env, struct bpf_insn *insn);
+bool bpf_insn_is_iter_next(struct bpf_verifier_env *env, struct bpf_insn *insn);
 bool bpf_insn_leaves_loop(struct bpf_verifier_env *env, int h, int n);
 bool bpf_jump_leaves_loop(struct bpf_verifier_env *env, int h, int n);
 int bpf_insert_recursion_checks(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 269810b128c4..d5a79e1ea933 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
-obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o backtrack.o check_btf.o
+obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o backtrack.o check_btf.o flow.o join.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 47452ac7277a..98539c7e42c5 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -16,6 +16,9 @@ int bpf_push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state
 	struct bpf_jmp_history_entry *p;
 	size_t alloc_size;
 
+	/* FLOW: nothing looks at the history */
+	return 0;
+
 	/* combine instruction flags if we already recorded this instruction */
 	if (env->cur_hist_ent) {
 		/* atomic instructions push insn_flags twice, for READ and
@@ -850,6 +853,10 @@ int bpf_mark_chain_precision(struct bpf_verifier_env *env,
 	struct bpf_func_state *func;
 	bool tmp, skip_first = true;
 	struct bpf_stack_state *ss;
+
+	/* FLOW: there are no precision marks */
+	bt_reset(bt);
+	return 0;
 	struct bpf_reg_state *reg;
 	int i, fr, err;
 
diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
index bd251c8e82ee..a2dbf03601ae 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -263,6 +263,12 @@ int bpf_compute_const_regs(struct bpf_verifier_env *env)
 
 		for (r = 0; r < MAX_BPF_REG; r++)
 			ci_in[start][r] = unknown;
+		/*
+		 * The subprog gets there from where it is out of budget too, see
+		 * push_budget_exit(). That is not an edge of the graph.
+		 */
+		for (r = 0; r < MAX_BPF_REG && env->subprog_info[i].bail_insn >= 0; r++)
+			ci_in[env->subprog_info[i].bail_insn][r] = unknown;
 	}
 
 redo:
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 5432c0fc442b..82edff722dea 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -792,6 +792,11 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 		verbose(env, " cb");
 	if (state->in_async_callback_fn)
 		verbose(env, " async_cb");
+	/* the iterations of the loops in which they are kept apart */
+	for (i = 0; i < state->loop_stack_cnt; i++)
+		if (state->loop_stack[i].apart)
+			verbose(env, " iter(%d)=%u", state->loop_stack[i].loop_id,
+				state->loop_stack[i].trip);
 	if (state->loop_stack_cnt) {
 		verbose(env, " loop_stack=");
 		for (i = 0; i < state->loop_stack_cnt; i++)
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index d7df6632a5c4..d55adade5b1c 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -949,7 +949,9 @@ static bool loop_stack_safe(struct bpf_verifier_env *env, struct bpf_func_state
 	for (i = 0; i < old->loop_stack_cnt; i++) {
 		if (old_stack[i].loop_id == cur_stack[i].loop_id &&
 		    old_stack[i].max_header_count == cur_stack[i].max_header_count &&
-		    old_stack[i].terminates == cur_stack[i].terminates)
+		    old_stack[i].terminates == cur_stack[i].terminates &&
+		    old_stack[i].apart == cur_stack[i].apart &&
+		    old_stack[i].trip == cur_stack[i].trip)
 			continue;
 		return false;
 	}
@@ -1043,6 +1045,9 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->speculative && !cur->speculative)
 		return false;
 
+	if (old->in_callback != cur->in_callback || old->callers_unknown != cur->callers_unknown)
+		return false;
+
 	if (old->in_sleepable != cur->in_sleepable)
 		return false;
 
@@ -1731,3 +1736,15 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	 */
 	return bpf_split_cur_state(env);
 }
+
+int bpf_clean_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	return clean_verifier_state(env, st);
+}
+
+/* Everything that @cur describes is described by @old. */
+bool bpf_state_subsumes(struct bpf_verifier_env *env, struct bpf_verifier_state *old,
+			struct bpf_verifier_state *cur)
+{
+	return states_equal(env, old, cur, RANGE_WITHIN);
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a9628f5045fe..0c1de0f24b85 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -194,13 +194,14 @@ struct bpf_verifier_stack_elem {
 	struct bpf_verifier_state st;
 	int insn_idx;
 	int prev_insn_idx;
+	/* it goes there only if the guard at prev_insn_idx has to, see check_loop_guard() */
+	bool parked;
 	struct bpf_verifier_stack_elem *next;
 	/* length of verifier log at the time this state was pushed on stack */
 	u32 log_pos;
 	u64 diag_log_pos;
 };
 
-#define BPF_COMPLEXITY_LIMIT_JMP_SEQ	8192
 #define BPF_COMPLEXITY_LIMIT_STATES	64
 
 #define BPF_GLOBAL_PERCPU_MA_MAX_SIZE  512
@@ -1781,7 +1782,11 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
 		return err;
 	dst_state->speculative = src->speculative;
 	dst_state->in_sleepable = src->in_sleepable;
+	dst_state->in_callback = src->in_callback;
+	dst_state->callers_unknown = src->callers_unknown;
 	dst_state->unwound = src->unwound;
+	dst_state->flow_entry = src->flow_entry;
+	dst_state->insn_idx = src->insn_idx;
 	dst_state->curframe = src->curframe;
 	dst_state->branches = src->branches;
 	dst_state->parent = src->parent;
@@ -1910,11 +1915,6 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	if (err)
 		return ERR_PTR(-ENOMEM);
 	elem->st.speculative |= speculative;
-	if (env->stack_size > BPF_COMPLEXITY_LIMIT_JMP_SEQ) {
-		verbose(env, "The sequence of %d jumps is too complex.\n",
-			env->stack_size);
-		return ERR_PTR(-E2BIG);
-	}
 	if (elem->st.parent) {
 		++elem->st.parent->branches;
 		/* WARN_ON(branches > 2) technically makes sense here,
@@ -2593,12 +2593,6 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	elem->diag_log_pos = bpf_diag_event_log_save(env);
 	env->head = elem;
 	env->stack_size++;
-	if (env->stack_size > BPF_COMPLEXITY_LIMIT_JMP_SEQ) {
-		verbose(env,
-			"The sequence of %d jumps is too complex for async cb.\n",
-			env->stack_size);
-		return ERR_PTR(-E2BIG);
-	}
 	/* Unlike push_stack() do not bpf_copy_verifier_state().
 	 * The caller state doesn't matter.
 	 * This is async callback. It starts in a fresh stack.
@@ -3454,7 +3448,17 @@ static int check_unwind_insns(struct bpf_verifier_env *env)
 	bool seen = false;
 	int i;
 
+	for (i = 0; i < env->subprog_cnt; i++)
+		env->subprog_info[i].bail_insn = -1;
+
 	for (i = 0; i < env->prog->len; i++, insn++) {
+		if (bpf_is_ldimm64(insn)) {
+			i++;
+			insn++;
+			continue;
+		}
+		if (insn->code == (BPF_JMP | BPF_EXIT))
+			bpf_find_containing_subprog(env, i)->bail_insn = i;
 		if (bpf_is_unwind_exit(insn)) {
 			bpf_find_containing_subprog(env, i)->can_unwind = true;
 			seen = true;
@@ -3552,20 +3556,19 @@ static int sort_subprogs_topo(struct bpf_verifier_env *env)
 				}
 				if (color[callee] == 2)
 					continue;
-				if (color[callee] == 1) {
-					if (bpf_pseudo_func(&insn[idx]))
-						continue;
-					verbose(env, "recursive call from %s() to %s()\n",
-						bpf_subprog_name(env, cur),
-						bpf_subprog_name(env, callee));
-					bpf_diag_program_structure(
-						env, idx, "recursive subprogram call",
-						"Rewrite the recursion as an explicit bounded loop, or split the logic so subprogram calls do not form a cycle.",
-						"This bpf2bpf call would make the subprogram call graph recursive. "
-						"The verifier requires a finite, acyclic call graph so it can bound stack depth and analysis.");
+				/*
+				 * The call that is its own target never returns. It is
+				 * also what libbpf leaves in place of a call that it
+				 * could not resolve.
+				 */
+				if (bpf_pseudo_call(&insn[idx]) && insn[idx].imm == -1) {
+					verbose(env, "call at insn %d calls itself\n", idx);
 					ret = -EINVAL;
 					goto out;
 				}
+				/* recursion: the order within the cycle is arbitrary */
+				if (color[callee] == 1)
+					continue;
 				color[callee] = 1;
 				dfs_stack[top++] = callee;
 				pushed = true;
@@ -4598,6 +4601,23 @@ static int check_stack_write(struct bpf_verifier_env *env,
 	return err;
 }
 
+/*
+ * The function that is verified on its own has no caller to look at. Its incoming
+ * arguments are in its stack_arg_regs until it is done with loading them.
+ */
+static void end_stack_arg_loads(struct bpf_verifier_env *env, struct bpf_func_state *state)
+{
+	int i;
+
+	if (state->no_stack_arg_load)
+		return;
+	state->no_stack_arg_load = true;
+	if (state->frameno)
+		return;
+	for (i = 0; i < state->out_stack_arg_cnt; i++)
+		bpf_mark_reg_not_init(env, &state->stack_arg_regs[i]);
+}
+
 /*
  * Write a value to the outgoing stack arg area.
  * off is a negative offset from r11 (e.g. -8 for arg6, -16 for arg7).
@@ -4617,6 +4637,7 @@ static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_s
 		return -EINVAL;
 	}
 
+	end_stack_arg_loads(env, state);
 	err = grow_stack_arg_slots(env, state, spi + 1);
 	if (err)
 		return err;
@@ -4636,7 +4657,6 @@ static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_s
 		__mark_reg_known(arg, env->prog->insnsi[env->insn_idx].imm);
 	}
 	bpf_diag_mod_end(env);
-	state->no_stack_arg_load = true;
 	return bpf_push_jmp_history(env, env->cur_state,
 				    INSN_F_STACK_ARG_ACCESS, spi, 0, NULL, 0);
 }
@@ -4665,7 +4685,9 @@ static int check_stack_arg_read(struct bpf_verifier_env *env, struct bpf_func_st
 		return -EACCES;
 	}
 
-	caller = vstate->frame[vstate->curframe - 1];
+	caller = vstate->frame[vstate->curframe ? vstate->curframe - 1 : 0];
+	if (verifier_bug_if(spi >= caller->out_stack_arg_cnt, env, "no stack arg%d", spi + 1))
+		return -EFAULT;
 	arg = &caller->stack_arg_regs[spi];
 	cur = vstate->frame[vstate->curframe];
 	bpf_diag_mod_begin(env, &cur->regs[dst_regno], arg, BPF_DIAG_MOD_WRITE);
@@ -5746,6 +5768,9 @@ struct bpf_subprog_call_depth_info {
 	int callx_insn; /* callx instruction whose callees are being walked */
 	int callx_next; /* next callee of callx_insn to walk */
 	bool via_callx; /* the subprogram is entered via callx */
+	/* recursive subprog: the deepest it was entered, out of a callback and in one, plus 1 */
+	int seen_depth[2];
+	int seen_arena_depth[2];
 };
 
 /* starting from main bpf function walk all instructions of the function
@@ -5810,7 +5835,9 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 			break;
 		}
 	}
-	arena_depth += subprog[idx].arena_stack_depth;
+	/* frames of recursive subprogs are counted at run time */
+	if (!subprog[idx].recursive)
+		arena_depth += subprog[idx].arena_stack_depth;
 	if (arena_depth > env->max_arena_stack_depth)
 		env->max_arena_stack_depth = arena_depth;
 	if (arena_depth > BPF_ARENA_STACK_MAX) {
@@ -5849,7 +5876,8 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 			return -EACCES;
 		}
 	} else {
-		depth += subprog_depth;
+		if (!subprog[idx].recursive)
+			depth += subprog_depth;
 		if (depth > env->max_stack_depth)
 			env->max_stack_depth = depth;
 		if (depth > env->stack_limit) {
@@ -5930,17 +5958,37 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		 * The main verification pass limits the depth of the recursion,
 		 * but it doesn't follow calls of global functions.
 		 */
-		for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller) {
-			if (tmp != sidx)
+		for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller)
+			if (tmp == sidx)
+				break;
+		/*
+		 * Recursion. How deep it goes is not known here. It's counted
+		 * at run time.
+		 */
+		if (tmp >= 0) {
+			if (bpf_is_callx(insn + i) || bpf_calls_callback(env, i))
+				i--;
+			continue;
+		}
+		/*
+		 * Any recursive subprog may follow any other when they call each other
+		 * through pointers. Don't walk all such chains: what is called from
+		 * here was looked at with at least as much on the stack.
+		 */
+		if (subprog[sidx].recursive) {
+			bool cb = subprog[sidx].is_cb;
+
+			for (tmp = idx; tmp >= 0 && !cb; tmp = dinfo[tmp].caller)
+				cb = subprog[tmp].is_cb;
+			if (depth < dinfo[sidx].seen_depth[cb] &&
+			    arena_depth < dinfo[sidx].seen_arena_depth[cb]) {
+				if (bpf_is_callx(insn + i) || bpf_calls_callback(env, i))
+					i--;
 				continue;
-			verbose(env, "recursive call from %s() to %s()\n",
-				bpf_subprog_name(env, idx), bpf_subprog_name(env, sidx));
-			bpf_diag_program_structure(
-				env, i, "recursive subprogram call",
-				"Rewrite the recursion as an explicit bounded loop, or split the logic so subprogram calls do not form a cycle.",
-				"This call or callback would make the subprogram call graph recursive. "
-				"The verifier requires a finite, acyclic call graph so it can bound stack depth and analysis.");
-			return -EINVAL;
+			}
+			dinfo[sidx].seen_depth[cb] = max(dinfo[sidx].seen_depth[cb], depth + 1);
+			dinfo[sidx].seen_arena_depth[cb] = max(dinfo[sidx].seen_arena_depth[cb],
+							       arena_depth + 1);
 		}
 
 		/* store caller info for after we return from callee */
@@ -5959,7 +6007,10 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		/* sync tail_call_reachable with callee state on entry */
 		tail_call_reachable = subprog[idx].has_tail_call;
 
-		frame = bpf_subprog_is_global(env, idx) ? 0 : frame + 1;
+		if (bpf_subprog_is_global(env, idx))
+			frame = 0;
+		else if (!subprog[idx].recursive)
+			frame++;
 		if (frame >= MAX_CALL_FRAMES) {
 			verbose(env, "the call stack of %d frames is too deep !\n",
 				frame);
@@ -6003,11 +6054,12 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	/* end of for() loop means the last insn of the 'subprog'
 	 * was reached. Doesn't matter whether it was JA or EXIT
 	 */
-	if (frame == 0 && dinfo[idx].caller < 0)
+	if (dinfo[idx].caller < 0)
 		return 0;
-	if (subprog[idx].priv_stack_mode != PRIV_STACK_ADAPTIVE)
+	if (subprog[idx].priv_stack_mode != PRIV_STACK_ADAPTIVE && !subprog[idx].recursive)
 		depth -= round_up_stack_depth(env, subprog[idx].stack_depth);
-	arena_depth -= subprog[idx].arena_stack_depth;
+	if (!subprog[idx].recursive)
+		arena_depth -= subprog[idx].arena_stack_depth;
 
 	/* pop caller idx from callee */
 	idx = dinfo[idx].caller;
@@ -6022,6 +6074,111 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	goto continue_func;
 }
 
+/*
+ * Find the subprogs on cycles of the call graph. It is not known yet what callx
+ * calls: it may be any subprog whose address is taken. A subprog that is
+ * marked for no reason counts its frames for no reason, that is all.
+ */
+static int mark_recursive_subprogs(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *si = env->subprog_info;
+	struct bpf_insn *insn = env->prog->insnsi;
+	int cnt = env->subprog_cnt, words = BITS_TO_LONGS(cnt);
+	unsigned long *calls, *taken, *callx;
+	bool plain_callx = false;
+	int i, j, s, err = 0;
+
+	/* calls + s * words: the subprogs that s calls */
+	calls = kvcalloc((cnt + 2) * words, sizeof(long), GFP_KERNEL_ACCOUNT);
+	if (!calls)
+		return -ENOMEM;
+	taken = calls + cnt * words;
+	callx = taken + words;
+
+	for (s = 0; s < cnt; s++) {
+		for (i = si[s].start; i < si[s + 1].start; i++) {
+			if (bpf_is_callx(&insn[i])) {
+				__set_bit(s, callx);
+				if (!bpf_is_unwind_goto(&insn[i + 1]))
+					plain_callx = true;
+			}
+			if (bpf_pseudo_call(&insn[i]) || bpf_pseudo_func(&insn[i])) {
+				j = bpf_find_subprog(env, i + insn[i].imm + 1);
+				if (j < 0)
+					continue;
+				/* the helper that calls a callback doesn't expect it to unwind */
+				if (bpf_pseudo_func(&insn[i]) || !bpf_is_unwind_goto(&insn[i + 1]))
+					si[j].plain_call = true;
+				/* the helper that takes a callback calls it */
+				__set_bit(j, calls + s * words);
+				if (bpf_pseudo_func(&insn[i]))
+					__set_bit(j, taken);
+			}
+			if (bpf_is_ldimm64(&insn[i]))
+				i++;
+		}
+	}
+	for (i = 0; i < env->func_ptr_cnt; i++) {
+		j = bpf_find_subprog(env, env->func_ptrs[i].xlated_off);
+		if (j >= 0)
+			__set_bit(j, taken);
+	}
+	for_each_set_bit(s, callx, cnt)
+		bitmap_or(calls + s * words, calls + s * words, taken, cnt);
+
+	/*
+	 * Callers of a global subprog look at can_unwind before the subprog is verified.
+	 * The main prog returns to the kernel.
+	 */
+	for (s = 0; s < cnt; s++) {
+		if (plain_callx && test_bit(s, taken))
+			si[s].plain_call = true;
+		si[s].bail_unwinds = si[s].can_unwind ||
+				     (s && !si[s].plain_call && !bpf_subprog_is_global(env, s) &&
+				      bpf_jit_supports_unwind() &&
+				      !bpf_prog_is_offloaded(env->prog->aux));
+	}
+
+	for (j = 0; j < cnt; j++)
+		for (s = 0; s < cnt; s++)
+			if (test_bit(j, calls + s * words))
+				bitmap_or(calls + s * words, calls + s * words,
+					  calls + j * words, cnt);
+
+	for (s = 0; s < cnt; s++) {
+		if (!test_bit(s, calls + s * words))
+			continue;
+		err = -EINVAL;
+		if (!s) {
+			verbose(env, "recursive call of the main program\n");
+			break;
+		}
+		/* it has no way to tell one run from another, see bpf_prog_begin_run() */
+		if (env->prog->type == BPF_PROG_TYPE_EXT) {
+			verbose(env, "recursive %s() in an extension\n", bpf_subprog_name(env, s));
+			break;
+		}
+		if (si[s].has_tail_call || si[s].has_ld_abs) {
+			verbose(env, "recursive %s() cannot have %s\n", bpf_subprog_name(env, s),
+				si[s].has_tail_call ? "tail calls" : "LD_ABS");
+			break;
+		}
+		if (!bpf_jit_supports_percpu_insn()) {
+			verbose(env, "JIT does not support recursive calls\n");
+			err = -EOPNOTSUPP;
+			break;
+		}
+		if (si[s].bail_insn < 0) {
+			verbose(env, "recursive %s() has no exit\n", bpf_subprog_name(env, s));
+			break;
+		}
+		si[s].recursive = true;
+		err = 0;
+	}
+	kvfree(calls);
+	return err;
+}
+
 static int check_max_stack_depth(struct bpf_verifier_env *env)
 {
 	enum priv_stack_mode priv_stack_mode = PRIV_STACK_UNKNOWN;
@@ -6035,14 +6192,15 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 		return -ENOMEM;
 
 	for (int i = 0; i < env->subprog_cnt; i++) {
-		if (si[i].has_tail_call) {
-			/* the stack in arena wouldn't be returned */
-			if (env->uses_arena_sp) {
-				verbose(env, "tail_calls are not allowed in programs that use R%d\n",
-					BPF_REG_ARENA_SP);
-				kvfree(dinfo);
-				return -EINVAL;
-			}
+		/* the stack in arena wouldn't be returned */
+		if (si[i].has_tail_call && env->uses_arena_sp) {
+			verbose(env, "tail_calls are not allowed in programs that use R%d\n",
+				BPF_REG_ARENA_SP);
+			kvfree(dinfo);
+			return -EINVAL;
+		}
+		/* the private stack has room for one frame of a subprog */
+		if (si[i].has_tail_call || si[i].recursive) {
 			priv_stack_mode = NO_PRIV_STACK;
 			break;
 		}
@@ -8962,12 +9120,33 @@ static struct bpf_reg_state *get_iter_from_state(struct bpf_verifier_state *cur_
  *     }
  *     bpf_iter_num_destroy(&it);
  */
+/*
+ * The program asks for the next element after it was told that there is none. So it didn't
+ * leave the loops around the call, and the iterator is not what stops them.
+ */
+static int iter_is_drained(struct bpf_verifier_env *env, int insn_idx)
+{
+	struct bpf_loop *loop;
+	int h;
+
+	for (h = bpf_loop_at_index(env, insn_idx); h >= 0; h = env->insn_aux_data[h].loop_header) {
+		loop = env->insn_aux_data[h].loop;
+		if (!loop->rt_bounded)
+			continue;
+		loop->rt_bounded = false;
+		env->restart = true;
+	}
+	return env->restart ? -EINVAL : 0;
+}
+
 static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 				  struct bpf_call_arg_meta *meta)
 {
-	struct bpf_verifier_state *cur_st = env->cur_state, *queued_st, *prev_st;
+	struct bpf_verifier_state *cur_st = env->cur_state, *queued_st;
+	struct bpf_func_state *fr;
 	struct bpf_func_state *cur_fr = cur_st->frame[cur_st->curframe], *queued_fr;
 	struct bpf_reg_state *cur_iter, *queued_iter;
+	int err;
 
 	BTF_TYPE_EMIT(struct bpf_iter);
 
@@ -8980,21 +9159,18 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 		return -EFAULT;
 	}
 
+	if (cur_iter->iter.state == BPF_ITER_STATE_DRAINED) {
+		err = iter_is_drained(env, insn_idx);
+		if (err)
+			return err;
+	}
+
 	if (cur_iter->iter.state == BPF_ITER_STATE_ACTIVE) {
-		/* Because iter_next() call is a checkpoint is_state_visitied()
-		 * should guarantee parent state with same call sites and insn_idx.
-		 */
-		if (!cur_st->parent || cur_st->parent->insn_idx != insn_idx ||
-		    !same_callsites(cur_st->parent, cur_st)) {
-			verifier_bug(env, "bad parent state for iter next call");
-			return -EFAULT;
-		}
-		/* Note cur_st->parent in the call below, it is necessary to skip
-		 * checkpoint created for cur_st by is_state_visited()
-		 * right at this instruction.
-		 */
-		prev_st = find_prev_entry(env, cur_st->parent, insn_idx);
 		/* branch out active iter state */
+		/* there is an element or there is none: a jump out of the loop, both ways */
+		fr = cur_st->frame[cur_st->curframe];
+		if (fr->loop_stack_cnt && fr->loop_stack[fr->loop_stack_cnt - 1].probe)
+			fr->loop_stack[fr->loop_stack_cnt - 1].undecided = true;
 		queued_st = push_stack(env, insn_idx + 1, insn_idx, false);
 		if (IS_ERR(queued_st))
 			return PTR_ERR(queued_st);
@@ -9002,8 +9178,6 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 		queued_iter = get_iter_from_state(queued_st, meta);
 		queued_iter->iter.state = BPF_ITER_STATE_ACTIVE;
 		queued_iter->iter.depth++;
-		if (prev_st)
-			widen_imprecise_scalars(env, prev_st, queued_st);
 
 		queued_fr = queued_st->frame[queued_st->curframe];
 		mark_ptr_not_null_reg(&queued_fr->regs[BPF_REG_0]);
@@ -11311,6 +11485,9 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 			callsite,
 			state->curframe + 1 /* frameno within this callchain */,
 			subprog /* subprog number within this prog */);
+	callee->entry_refs = state->acquired_refs;
+	callee->entry_rcu_locks = state->active_rcu_locks;
+	callee->entry_preempt_locks = state->active_preempt_locks;
 	err = set_callee_state_cb(env, caller, callee, callsite);
 	if (err)
 		goto err_out;
@@ -11365,7 +11542,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog, s
 	const struct btf_type *func, *func_proto;
 	struct bpf_call_arg_meta meta;
 	struct bpf_func_proto *fn;
-	int ret;
+	int ret, err;
 	u32 i;
 
 	memset(&meta, 0, sizeof(meta));
@@ -11374,13 +11551,22 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog, s
 	meta.func_name = bpf_subprog_name(env, subprog);
 
 	ret = btf_prepare_func_args(env, subprog);
-	if (ret)
-		return ret;
-	/* BTF doesn't describe what the code does */
-	if (sub->stack_args_from_code &&
-	    max_t(int, sub->arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS) !=
-	    MAX_BPF_FUNC_REG_ARGS + bpf_in_stack_arg_cnt(sub))
-		return -EINVAL;
+	if (ret || sub->stack_args_from_code) {
+		if (bpf_in_stack_arg_cnt(sub) > 0) {
+			err = check_outgoing_stack_args(env, caller, MAX_BPF_FUNC_REG_ARGS +
+							bpf_in_stack_arg_cnt(sub),
+							bpf_subprog_name(env, subprog),
+							NULL, NULL);
+			if (err)
+				return err;
+		}
+		if (ret)
+			return ret;
+		/* BTF doesn't describe what the code does */
+		if (max_t(int, sub->arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS) !=
+		    MAX_BPF_FUNC_REG_ARGS + bpf_in_stack_arg_cnt(sub))
+			return -EINVAL;
+	}
 
 	func = btf_type_by_id(btf, env->prog->aux->func_info[subprog].type_id);
 	func_proto = btf_type_by_id(btf, func->type);
@@ -11523,13 +11709,362 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	return 0;
 }
 
+enum {
+	PROCESS_BPF_EXIT = 1,
+	INSN_IDX_UPDATED = 2,
+};
+
 static int process_bpf_exit_full(struct bpf_verifier_env *env,
 				 bool *do_print_state, bool exception_exit);
+static void account_current_path(struct bpf_verifier_env *env);
+
+/*
+ * The function can be verified on its own, for the state at its entry, when
+ * what it does depends on its arguments only and it cannot get to what its
+ * callers have: nothing points to their stack.
+ *
+ * What the callers hold, references, locks and so on, is a part of that state:
+ * it matters for what the function may do. Calls that differ in ids only
+ * have to get to the same state, so the ids of what is held are replaced with
+ * BPF_INHERITED_ID + the position for the function, and put back at the return.
+ * The same for other ids that the arguments have: BPF_INHERITED_ARG_ID + the position.
+ */
+#define BPF_INHERITED_ID	0x20000000
+#define BPF_INHERITED_ARG_ID	(BPF_INHERITED_ID + 0x10000)
+#define BPF_MAX_ARG_IDS		32
+
+static u32 inherited_id(const struct bpf_verifier_state *state, u32 id)
+{
+	int i;
+
+	/* the first one: the same lock can't be taken twice, the rest have ids of their own */
+	for (i = 0; id && i < state->acquired_refs; i++)
+		if (state->refs[i].id == id)
+			return BPF_INHERITED_ID + i;
+	return id;
+}
+
+static bool state_in_callback(const struct bpf_verifier_state *st)
+{
+	u32 fr;
+
+	if (st->in_callback)
+		return true;
+	for (fr = 0; fr <= st->curframe; fr++)
+		if (st->frame[fr]->in_callback_fn || st->frame[fr]->in_async_callback_fn ||
+		    st->frame[fr]->in_exception_callback_fn || st->frame[fr]->in_rcu_callback_fn)
+			return true;
+	return false;
+}
+
+static u32 add_arg_id(const struct bpf_verifier_state *state, u32 *ids, u32 n, u32 id)
+{
+	u32 i;
+
+	if (!id || n == BPF_MAX_ARG_IDS || inherited_id(state, id) != id)
+		return n;
+	for (i = 0; i < n; i++)
+		if (ids[i] == id)
+			return n;
+	ids[n] = id;
+	return n + 1;
+}
+
+/* The ids that the arguments of the call of @subprog in @state have, in the order of arguments */
+static u32 collect_arg_ids(struct bpf_verifier_env *env, const struct bpf_verifier_state *state,
+			   int subprog, u32 *ids)
+{
+	struct bpf_subprog_info *sub = &env->subprog_info[subprog];
+	u16 live = env->insn_aux_data[sub->start].live_regs_before;
+	const struct bpf_func_state *caller = state->frame[state->curframe];
+	const struct bpf_reg_state *reg;
+	u32 i, n = 0;
+
+	for (i = BPF_REG_1; i <= BPF_REG_5; i++) {
+		if (!(live & BIT(i)))
+			continue;
+		reg = &caller->regs[i];
+		n = add_arg_id(state, ids, n, reg->id & ~BPF_ADD_CONST);
+		n = add_arg_id(state, ids, n, reg->parent_id);
+	}
+	for (i = 0; i < bpf_in_stack_arg_cnt(sub) && i < caller->out_stack_arg_cnt; i++) {
+		reg = &caller->stack_arg_regs[i];
+		n = add_arg_id(state, ids, n, reg->id & ~BPF_ADD_CONST);
+		n = add_arg_id(state, ids, n, reg->parent_id);
+	}
+	return n;
+}
+
+static u32 callee_id(const struct bpf_verifier_state *state, const u32 *ids, u32 n, u32 id)
+{
+	u32 flags = id & BPF_ADD_CONST, i;
+
+	id &= ~BPF_ADD_CONST;
+	if (inherited_id(state, id) != id)
+		return inherited_id(state, id) | flags;
+	for (i = 0; i < n; i++)
+		if (ids[i] == id)
+			return (BPF_INHERITED_ARG_ID + i) | flags;
+	return id | flags;
+}
+
+static bool func_is_on_its_own(struct bpf_verifier_env *env, struct bpf_verifier_state *state,
+			       int subprog)
+{
+	struct bpf_func_state *caller = state->frame[state->curframe];
+	struct bpf_subprog_info *sub = &env->subprog_info[subprog];
+	u16 live = env->insn_aux_data[sub->start].live_regs_before;
+	u32 fr, i;
+
+	/*
+	 * Iterations that are kept apart would meet in the function.
+	 * There is no other way for a recursive one.
+	 */
+	for (fr = 0; fr <= state->curframe && !sub->recursive; fr++)
+		for (i = 0; i < state->frame[fr]->loop_stack_cnt; i++)
+			if (state->frame[fr]->loop_stack[i].apart)
+				return false;
+
+	if (sub->changes_pkt_data || sub->has_tail_call || sub->has_ld_abs ||
+	    sub->is_cb || sub->is_async_cb || sub->is_exception_cb)
+		return false;
+	if (state->speculative)
+		return false;
+	if (sub->releases_inherited &&
+	    (state->acquired_refs || state->active_rcu_locks || state->active_preempt_locks))
+		return false;
+	/* there is no other way for a recursive function */
+	if (state_in_callback(state) && !sub->recursive)
+		return false;
+	for (i = BPF_REG_1; i <= BPF_REG_5; i++) {
+		if (!(live & BIT(i)))
+			continue;
+		if (caller->regs[i].type == PTR_TO_STACK ||
+		    base_type(caller->regs[i].type) == CONST_PTR_TO_DYNPTR)
+			return false;
+		/* it checks how much of the packet is there, for the caller */
+		if (caller->regs[i].type == PTR_TO_PACKET_END && !sub->recursive)
+			return false;
+		/* or whether there is something to point to */
+		if (type_may_be_null(caller->regs[i].type) && !sub->recursive)
+			return false;
+	}
+	for (i = 0; i < bpf_in_stack_arg_cnt(sub); i++) {
+		if (caller->stack_arg_regs[i].type == PTR_TO_STACK ||
+		    base_type(caller->stack_arg_regs[i].type) == CONST_PTR_TO_DYNPTR)
+			return false;
+	}
+	return true;
+}
+
+static int call_func_on_its_own(struct bpf_verifier_env *env, int subprog, int insn_idx)
+{
+	u16 live = env->insn_aux_data[env->subprog_info[subprog].start].live_regs_before;
+	struct bpf_verifier_state *state = env->cur_state;
+	struct bpf_func_state *caller = state->frame[state->curframe], *callee;
+	struct bpf_verifier_state entry = {};
+	u32 ids[BPF_MAX_ARG_IDS], nids;
+	int i, err;
+
+	callee = kzalloc_obj(*callee, GFP_KERNEL_ACCOUNT);
+	if (!callee)
+		return -ENOMEM;
+	entry.frame[0] = callee;
+	entry.in_sleepable = state->in_sleepable;
+	entry.in_callback = state_in_callback(state);
+	entry.callers_unknown = state->callers_unknown;
+	init_func_state(env, callee, BPF_MAIN_FUNC, 0, subprog);
+	for (i = BPF_REG_1; i <= BPF_REG_5; i++)
+		if (live & BIT(i))
+			callee->regs[i] = caller->regs[i];
+	err = grow_stack_arg_slots(env, callee, bpf_in_stack_arg_cnt(&env->subprog_info[subprog]));
+	if (err) {
+		bpf_free_verifier_state(&entry, false);
+		return err;
+	}
+	for (i = 0; i < callee->out_stack_arg_cnt; i++)
+		callee->stack_arg_regs[i] = caller->stack_arg_regs[i];
+
+	err = copy_reference_state(&entry, state);
+	if (err) {
+		bpf_free_verifier_state(&entry, false);
+		return err;
+	}
+	for (i = 0; i < entry.acquired_refs; i++) {
+		/* the id of a lock is the id of the pointer to it, which may have none */
+		entry.refs[i].id = inherited_id(state, entry.refs[i].id);
+		if (entry.refs[i].type == REF_TYPE_PTR)
+			entry.refs[i].parent_id = inherited_id(state, entry.refs[i].parent_id);
+	}
+	entry.active_irq_id = inherited_id(state, entry.active_irq_id);
+	entry.active_lock_id = inherited_id(state, entry.active_lock_id);
+	callee->entry_refs = entry.acquired_refs;
+	callee->entry_rcu_locks = entry.active_rcu_locks;
+	callee->entry_preempt_locks = entry.active_preempt_locks;
+	nids = collect_arg_ids(env, state, subprog, ids);
+	for (i = BPF_REG_1; i <= BPF_REG_5; i++) {
+		callee->regs[i].id = callee_id(state, ids, nids, callee->regs[i].id);
+		callee->regs[i].parent_id = callee_id(state, ids, nids, callee->regs[i].parent_id);
+	}
+	for (i = 0; i < callee->out_stack_arg_cnt; i++) {
+		callee->stack_arg_regs[i].id =
+			callee_id(state, ids, nids, callee->stack_arg_regs[i].id);
+		callee->stack_arg_regs[i].parent_id =
+			callee_id(state, ids, nids, callee->stack_arg_regs[i].parent_id);
+	}
+
+	account_current_path(env);
+	env->subprog_info[subprog].on_its_own = true;
+	err = bpf_flow_call(env, state, &entry, subprog, insn_idx);
+	bpf_free_verifier_state(&entry, false);
+	/* the call waits, there is nothing to go on with */
+	return err ?: PROCESS_BPF_EXIT;
+}
+
+/* The current state is at exit of a function that is verified on its own. */
+static int exit_func_on_its_own(struct bpf_verifier_env *env)
+{
+	struct bpf_verifier_state *state = env->cur_state;
+	struct bpf_func_state *callee = state->frame[0];
+	u32 i, nregs;
+	int err;
+
+	nregs = bpf_ret_reg_pair(env, callee->subprogno) ? 2 : 1;
+	for (i = 0; i < nregs; i++) {
+		if (callee->regs[ret_regs[i]].type != PTR_TO_STACK)
+			continue;
+		verbose(env, "cannot return stack pointer to the caller\n");
+		return -EINVAL;
+	}
+	state->unwound |= bpf_is_unwind_exit(&env->prog->insnsi[env->insn_idx]);
+
+	/* Invalidate callee-local dynptrs and their slices before the frame goes away. */
+	err = destroy_dynptrs_in_stack_slots(env, callee, 0,
+					     callee->allocated_stack / BPF_REG_SIZE - 1);
+	if (err)
+		return err;
+
+	account_current_path(env);
+	err = bpf_flow_exit(env, state, env->insn_idx);
+	return err ?: PROCESS_BPF_EXIT;
+}
+
+static u32 fresh_id(struct bpf_verifier_env *env, struct bpf_idmap *idmap, u32 id)
+{
+	u32 flags = id & BPF_ADD_CONST, i;
+
+	id &= ~BPF_ADD_CONST;
+	if (!id)
+		return 0;
+	for (i = 0; i < idmap->cnt; i++)
+		if (idmap->map[i].old == id)
+			return idmap->map[i].cur | flags;
+	if (idmap->cnt == BPF_ID_MAP_SIZE)
+		return 0;
+	idmap->map[idmap->cnt].old = id;
+	idmap->map[idmap->cnt].cur = ++env->id_gen;
+	return idmap->map[idmap->cnt++].cur | flags;
+}
+
+/*
+ * @caller waits at the call at @call_idx and @exit is what came out of the
+ * function. Make @caller what it is after the call.
+ * Returns 1 if the call has to be verified in the context of the caller.
+ */
+int bpf_flow_return(struct bpf_verifier_env *env, struct bpf_verifier_state *caller,
+		    const struct bpf_verifier_state *exit, int call_idx)
+{
+	struct bpf_func_state *frame = caller->frame[caller->curframe];
+	const struct bpf_func_state *callee = exit->frame[0];
+	struct bpf_idmap *idmap = &env->idmap_scratch;
+	u32 caller_rcu = caller->active_rcu_locks, caller_preempt = caller->active_preempt_locks;
+	u32 ids[BPF_MAX_ARG_IDS], nids;
+	struct bpf_reference_state *held;
+	struct bpf_reg_state *reg;
+	u32 i, nregs, nheld, kept = 0, id;
+	int err;
+
+	if (exit->unwound && !bpf_is_unwind_goto(&env->prog->insnsi[call_idx + 1])) {
+		verbose(env, "unwind_exit, but no unwind_goto after the call at insn %d\n",
+			call_idx);
+		return -EINVAL;
+	}
+	caller->unwound = exit->unwound;
+
+	nids = collect_arg_ids(env, caller, callee->subprogno, ids);
+	for (i = 0; i < CALLER_SAVED_REGS; i++)
+		bpf_mark_reg_not_init(env, &frame->regs[caller_saved[i]]);
+	for (i = 0; i < frame->out_stack_arg_cnt; i++)
+		bpf_mark_reg_not_init(env, &frame->stack_arg_regs[i]);
+
+	/* what is held now is what was held at the call and what the function took */
+	held = caller->refs;
+	nheld = caller->acquired_refs;
+	caller->refs = NULL;
+	caller->acquired_refs = 0;
+	err = copy_reference_state(caller, exit);
+	if (err) {
+		kfree(held);
+		return err;
+	}
+	if (nheld > BPF_ID_MAP_SIZE / 2) {
+		kfree(held);
+		return -E2BIG;
+	}
+
+	/*
+	 * The same state comes out for every call. Ids in it have to be new
+	 * every time, or two calls in a row return the same object.
+	 */
+	idmap->cnt = 0;
+	for (i = 0; i < nheld; i++) {
+		idmap->map[idmap->cnt].old = BPF_INHERITED_ID + i;
+		idmap->map[idmap->cnt++].cur = held[i].id;
+	}
+	for (i = 0; i < nids; i++) {
+		idmap->map[idmap->cnt].old = BPF_INHERITED_ARG_ID + i;
+		idmap->map[idmap->cnt++].cur = ids[i];
+	}
+	/* What is taken is added at the end. What is released leaves no hole. */
+	for (i = 0; i < nheld && i < caller->acquired_refs; i++) {
+		id = held[i].id ? BPF_INHERITED_ID + i : 0;
+		if (caller->refs[i].id != id || caller->refs[i].type != held[i].type)
+			break;
+		caller->refs[i] = held[i];
+		kept++;
+	}
+	kfree(held);
+	/* What it means for the caller is found out in the context of the caller. */
+	if (kept != nheld || exit->active_rcu_locks < caller_rcu ||
+	    exit->active_preempt_locks < caller_preempt) {
+		if (env->log.level & BPF_LOG_LEVEL2)
+			verbose(env, "func#%d releases what its caller holds at insn %d\n",
+				callee->subprogno, call_idx);
+		env->subprog_info[callee->subprogno].releases_inherited = true;
+		return 1;
+	}
+	nregs = bpf_ret_reg_pair(env, callee->subprogno) ? 2 : 1;
+	for (i = 0; i < nregs; i++) {
+		reg = &frame->regs[ret_regs[i]];
+		*reg = callee->regs[ret_regs[i]];
+		reg->id = fresh_id(env, idmap, reg->id);
+		reg->parent_id = fresh_id(env, idmap, reg->parent_id);
+	}
+	/* those that were held are the first */
+	for (i = nheld; i < caller->acquired_refs; i++) {
+		caller->refs[i].id = fresh_id(env, idmap, caller->refs[i].id);
+		if (caller->refs[i].type == REF_TYPE_PTR)
+			caller->refs[i].parent_id = fresh_id(env, idmap, caller->refs[i].parent_id);
+	}
+	caller->active_irq_id = fresh_id(env, idmap, caller->active_irq_id);
+	caller->active_lock_id = fresh_id(env, idmap, caller->active_lock_id);
+	return 0;
+}
 
 /*
- * Call of a static subprog. The callee is verified in the context of
- * the caller, hence set up a new frame and continue from the first
- * instruction of the callee.
+ * Call of a static subprog. Unless the callee is verified on its own it is
+ * verified in the context of the caller, hence set up a new frame and
+ * continue from the first instruction of the callee.
  */
 static int check_static_func_call(struct bpf_verifier_env *env, int subprog,
 				  int *insn_idx)
@@ -11551,12 +12086,15 @@ static int check_static_func_call(struct bpf_verifier_env *env, int subprog,
 	stack_arg_cnt = bpf_in_stack_arg_cnt(caller_info) + callee_incoming;
 	if (stack_arg_cnt > caller_info->stack_arg_cnt)
 		caller_info->stack_arg_cnt = stack_arg_cnt;
-
+	/* btf_check_subprog_call() doesn't get to it when BTF is not reliable */
 	err = check_outgoing_stack_args(env, caller, MAX_BPF_FUNC_REG_ARGS + callee_incoming,
 					bpf_subprog_name(env, subprog), NULL, NULL);
 	if (err)
 		return err;
 
+	if (func_is_on_its_own(env, state, subprog))
+		return call_func_on_its_own(env, subprog, *insn_idx);
+
 	/*
 	 * For regular function entry setup new frame and continue
 	 * from that frame.
@@ -12162,7 +12700,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	}
 
 	caller = state->frame[state->curframe - 1];
-	if (bpf_is_unwind_exit(&env->prog->insnsi[*insn_idx])) {
+	if (bpf_is_unwind_exit(&env->prog->insnsi[*insn_idx]) || state->unwound) {
 		/* the helper or the kfunc that called it doesn't expect that */
 		if (callee->in_callback_fn) {
 			verbose(env, "callback cannot unwind\n");
@@ -12181,6 +12719,16 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 			return -EACCES;
 		}
 
+		/* It's called any number of times. Nobody can release what it leaves behind. */
+		for (i = callee->entry_refs; i < state->acquired_refs; i++) {
+			if (state->refs[i].type != REF_TYPE_PTR)
+				continue;
+			verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
+				state->refs[i].id, state->refs[i].insn_idx);
+			bpf_diag_leak(env, state->refs[i].id, state->refs[i].insn_idx, *insn_idx);
+			return -EINVAL;
+		}
+
 		/* we are going to rely on register's precise value */
 		err = mark_chain_precision(env, BPF_REG_0);
 		if (err)
@@ -15115,14 +15663,59 @@ bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *ins
 	return info;
 }
 
-/*
- * Describe a kfunc's stack access through argument slot @arg (0-based).
- * As for helpers, must_write describes destruction of prior verifier state,
- * rather than a guarantee that the callee writes every byte at runtime.
- */
-struct arg_access_info
-bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *insn,
-			     int arg, int insn_idx)
+/* insn_aux_data->is_iter_next is not there before the main pass */
+bool bpf_insn_is_iter_next(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	struct bpf_call_arg_meta meta;
+
+	return bpf_pseudo_kfunc_call(insn) &&
+	       !bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta) &&
+	       bpf_is_iter_next_kfunc(&meta);
+}
+
+/* The registers in which the kfunc takes nothing but a known constant ("__k") */
+u16 bpf_kfunc_const_arg_regs(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	struct bpf_call_arg_meta meta;
+	const struct btf_param *args;
+	u32 i, slot, nargs;
+	u16 mask = 0;
+
+	if (bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta) < 0)
+		return 0;
+	args = btf_params(meta.func_proto);
+	nargs = btf_type_vlen(meta.func_proto);
+	for (i = 0, slot = 0; i < nargs && slot < MAX_BPF_FUNC_REG_ARGS; i++) {
+		if (is_kfunc_arg_constant(meta.btf, &args[i]))
+			mask |= BIT(BPF_REG_1 + slot);
+		slot += btf_arg_slots(btf_type_skip_modifiers(meta.btf, args[i].type, NULL));
+	}
+	return mask;
+}
+
+/* The same for a helper */
+u16 bpf_helper_const_arg_regs(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	const struct bpf_func_proto *fn;
+	u16 mask = 0;
+	u32 i;
+
+	if (bpf_get_helper_proto(env, insn->imm, &fn) < 0)
+		return 0;
+	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++)
+		if (fn->arg_type[i] == ARG_CONST_ALLOC_SIZE_OR_ZERO)
+			mask |= BIT(BPF_REG_1 + i);
+	return mask;
+}
+
+/*
+ * Describe a kfunc's stack access through argument slot @arg (0-based).
+ * As for helpers, must_write describes destruction of prior verifier state,
+ * rather than a guarantee that the callee writes every byte at runtime.
+ */
+struct arg_access_info
+bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			     int arg, int insn_idx)
 {
 	struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
 	struct arg_access_info info = {
@@ -19043,6 +19636,21 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 	}
 }
 
+/* The jump at env->insn_idx goes both ways */
+static void mark_loop_exit_undecided(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	struct bpf_func_state *frame = st->frame[st->curframe];
+	struct loop_stack_entry *entry;
+	u32 i;
+
+	for (i = 0; i < frame->loop_stack_cnt; i++) {
+		entry = &frame->loop_stack[i];
+		if (entry->apart && entry->probe &&
+		    bpf_jump_leaves_loop(env, entry->loop_id, env->insn_idx))
+			entry->undecided = true;
+	}
+}
+
 static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			     struct bpf_insn *insn, int *insn_idx)
 {
@@ -19212,6 +19820,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			return err;
 	}
 
+	mark_loop_exit_undecided(env, this_branch);
 	other_branch = push_stack(env, *insn_idx + insn->off + 1, *insn_idx, false);
 	if (IS_ERR(other_branch))
 		return PTR_ERR(other_branch);
@@ -20263,10 +20872,6 @@ static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type typ
 	return 0;
 }
 
-enum {
-	PROCESS_BPF_EXIT = 1,
-	INSN_IDX_UPDATED = 2,
-};
 
 static int process_bpf_exit_full(struct bpf_verifier_env *env,
 				 bool *do_print_state,
@@ -20274,6 +20879,9 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
 {
 	struct bpf_func_state *cur_frame = cur_func(env);
 
+	if (!exception_exit && !env->cur_state->curframe && env->cur_state->flow_entry)
+		return exit_func_on_its_own(env);
+
 	/* We must do check_reference_leak here before
 	 * prepare_func_exit to handle the case when
 	 * state->curframe > 0, it may be a callback function,
@@ -20490,6 +21098,24 @@ static int check_arena_sp_insn(struct bpf_verifier_env *env, struct bpf_insn *in
 	return err ?: save_aux_ptr_type(env, PTR_TO_ARENA, false);
 }
 
+/*
+ * NULL is dereferenced. In a program that has arena take it for a pointer to arena:
+ * the compiler may have moved the cast to where the number was not known to be 0 yet,
+ * and what check_loop_guard() sets to 0 may be a pointer that was cast in the loop.
+ */
+static void null_to_arena(struct bpf_verifier_env *env, int regno)
+{
+	struct bpf_reg_state *reg;
+
+	if (!env->prog->aux->arena || regno >= BPF_REG_FP)
+		return;
+	reg = &cur_regs(env)[regno];
+	if (reg->type != SCALAR_VALUE || !tnum_equals_const(reg->var_off, 0))
+		return;
+	__mark_reg_const_zero(env, reg);
+	reg->type = PTR_TO_ARENA;
+}
+
 static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 {
 	int err;
@@ -20499,6 +21125,11 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 	if (is_arena_sp_insn(insn))
 		return check_arena_sp_insn(env, insn);
 
+	if (class == BPF_LDX)
+		null_to_arena(env, insn->src_reg);
+	else if (class == BPF_STX || class == BPF_ST)
+		null_to_arena(env, insn->dst_reg);
+
 	switch (class) {
 	case BPF_ALU:
 	case BPF_ALU64:
@@ -20565,7 +21196,7 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 			}
 			mark_reg_scratched(env, BPF_REG_0);
 			if (bpf_in_stack_arg_cnt(&env->subprog_info[cur_func(env)->subprogno]))
-				cur_func(env)->no_stack_arg_load = true;
+				end_stack_arg_loads(env, cur_func(env));
 			if (bpf_is_callx(insn))
 				return check_func_callx(env, insn, &env->insn_idx);
 			if (insn->src_reg == BPF_PSEUDO_CALL)
@@ -20659,6 +21290,11 @@ static int loop_stack_push(struct bpf_verifier_env *env, bool *pushed)
 
 	for (; num_missing; num_missing--, cnt++) {
 		h = missing_headers[num_missing - 1];
+		/* wherever it is entered: a loop can have more than one entry */
+		if (!aux[h].loop->exits_cnt) {
+			verbose(env, "loop at insn %d never exits\n", h);
+			return -EINVAL;
+		}
 		loop_stack[cnt] = (struct loop_stack_entry){ .loop_id = h };
 		if (env->log.level & BPF_LOG_LEVEL2)
 			verbose(env, "entering loop %d\n", h);
@@ -20728,18 +21364,66 @@ static int maybe_clamp_scev_regs(struct bpf_verifier_env *env)
 	return bpf_clamp_scev_regs(env, frame, env->insn_idx, entry);
 }
 
-static int handle_loop_entry_exit(struct bpf_verifier_env *env)
+/* How many insns it may take to go through the iterations of a loop one by one. */
+#define BPF_FLOW_MAX_WALK	100000
+/* The same when it is not known that the walk gets to the end of the loop. */
+#define BPF_FLOW_MAX_TRY	4096
+
+/* How many times the current insn is looked at because of the loops around it that are walked. */
+static u64 flow_walk_factor(const struct bpf_verifier_state *st)
+{
+	const struct loop_stack_entry *e;
+	u64 factor = 1;
+	u32 fr, i;
+
+	for (fr = 0; fr <= st->curframe; fr++) {
+		for (i = 0; i < st->frame[fr]->loop_stack_cnt; i++) {
+			e = &st->frame[fr]->loop_stack[i];
+			if (e->apart)
+				factor = min_t(u64, factor * max(e->max_header_count, 1U), U32_MAX);
+		}
+	}
+	return factor;
+}
+
+/*
+ * The current state gets to env->insn_idx. Leave the loops that the insn is not in.
+ * @enters: the insn is the head of a loop that the state is not in yet.
+ */
+int bpf_flow_loop_leave(struct bpf_verifier_env *env, bool *enters)
 {
-	struct bpf_verifier_state *cur = env->cur_state;
 	struct bpf_func_state *frame = cur_func(env);
-	struct loop_stack_entry *entry;
-	struct bpf_loop_iters iters;
-	bool pushed, terminates;
 	int err;
 
 	err = loop_stack_pop(env);
 	if (err)
 		return err;
+	*enters = env->insn_aux_data[env->insn_idx].loop &&
+		  (!frame->loop_stack_cnt ||
+		   frame->loop_stack[frame->loop_stack_cnt - 1].loop_id != env->insn_idx);
+	return 0;
+}
+
+/*
+ * Enter the loops that env->insn_idx is in.
+ *
+ * The state that enters a loop at its head is made to stand for all iterations:
+ * - When the number of iterations follows from the state, with the ranges that
+ *   induction variables have in that many iterations.
+ * - Otherwise the numbers that the loop changes are forgotten.
+ * The state that comes back to the head is then expected to be within it.
+ */
+int bpf_flow_loop_enter(struct bpf_verifier_env *env, bool *backedge, bool *drop)
+{
+	struct bpf_verifier_state *cur = env->cur_state, *entry_state;
+	const struct bpf_insn *insn = &env->prog->insnsi[env->insn_idx];
+	struct bpf_func_state *frame = cur_func(env);
+	struct loop_stack_entry *entry;
+	struct bpf_loop_iters iters;
+	struct bpf_loop *loop;
+	bool pushed;
+	u32 patience;
+	int err;
 
 	err = loop_stack_push(env, &pushed);
 	if (err)
@@ -20752,43 +21436,336 @@ static int handle_loop_entry_exit(struct bpf_verifier_env *env)
 	if (env->insn_idx != entry->loop_id)
 		return 0;
 
+	/*
+	 * No edge goes from a call to itself: the call goes on with one function of a set, see
+	 * split_func_set(), in the same iteration.
+	 */
+	if (!pushed && cur->last_insn_idx == env->insn_idx &&
+	    BPF_CLASS(insn->code) == BPF_JMP && BPF_OP(insn->code) == BPF_CALL)
+		return 0;
+
+	/* The callback came back to the helper that calls it, in the same iteration. */
+	if (frame->callback_depth)
+		return 0;
+
 	/* If nothing was pushed and env->insn_idx is a loop header, we've taken a backedge. */
-	if (!pushed)
-		return maybe_clamp_scev_regs(env);
+	if (!pushed) {
+		if (!entry->apart) {
+			*backedge = true;
+			return maybe_clamp_scev_regs(env);
+		}
+		/* the next iteration is another kind of state, there is no cycle */
+		if (!entry->undecided && ++entry->trip < entry->max_header_count &&
+		    (entry->counted ||
+		     env->insn_processed - entry->walk_start <= entry->walk_patience))
+			return 0;
+		/* there is no such iteration at run time */
+		if (entry->counted) {
+			*drop = true;
+			return 0;
+		}
+		/*
+		 * The walk doesn't get to the end of the loop. Make this state stand for
+		 * all iterations. It stands for those that were looked at as well.
+		 */
+		loop = env->insn_aux_data[env->insn_idx].loop;
+		if (!loop->rt_bounded && !loop->has_guards) {
+			verbose(env, "loop at insn %d never exits\n", env->insn_idx);
+			return -EINVAL;
+		}
+		entry->apart = false;
+		entry->probe = false;
+		entry->undecided = false;
+		entry->terminates = false;
+		entry->trip = 0;
+		entry->max_header_count = 0;
+		return bpf_scev_forget_regs(env, cur);
+	}
 
-	err = bpf_compute_loop_iters(env, env->cur_state, &iters);
+	loop = env->insn_aux_data[env->insn_idx].loop;
+	err = bpf_compute_loop_iters(env, cur, &iters);
 	if (err < 0)
 		return err;
 
-	terminates = err == 1;
-	if (!terminates)
+	/*
+	 * There is no summary of what the loop does to something that is live.
+	 * Go through the iterations one by one if that is not too long.
+	 */
+	if (err == 2 && flow_walk_factor(cur) * iters.max_header_count * loop->nr_insns <=
+			BPF_FLOW_MAX_WALK) {
+		entry->max_header_count = iters.max_header_count;
+		entry->terminates = true;
+		entry->counted = true;
+		entry->apart = true;
+		return 0;
+	}
+	if (err == 2 && iters.spill_base)
+		err = 0;
+	/* The walk has to get to the end of the loop, so it is known to have one. */
+	/*
+	 * Or it's found out on the way: the walk goes on for as long as the jumps that
+	 * leave the loop are decided.
+	 */
+	patience = bpf_scev_latch_decided(env, cur) ? BPF_FLOW_MAX_TRY :
+		   env->allow_uninit_stack && !loop->rt_bounded && !loop->irreducible &&
+		   !loop->has_calls ? BPF_FLOW_MAX_TRY : 0;
+	/* Two trips for a loop of any length. Many a loop is left in the second one. */
+	if (patience && flow_walk_factor(cur) == 1)
+		patience = max_t(u64, patience, 2ULL * loop->nr_insns);
+	if (!err && flow_walk_factor(cur) * loop->nr_insns <= patience) {
+		entry->max_header_count = max_t(u32, patience /
+						(flow_walk_factor(cur) * loop->nr_insns), 1U);
+		entry->terminates = true;
+		entry->probe = !bpf_scev_latch_decided(env, cur);
+		entry->walk_start = env->insn_processed;
+		entry->walk_patience = patience;
+		entry->apart = true;
 		return 0;
+	}
 
-	/* Create a loop_entry checkpoint before widening */
-	err = bpf_split_cur_state(env);
-	if (err)
-		return err;
+	if (!err) {
+		if (!loop->rt_bounded && !loop->has_guards) {
+			verbose(env, "loop at insn %d never exits\n", env->insn_idx);
+			return -EINVAL;
+		}
+		return bpf_scev_forget_regs(env, cur);
+	}
+
+	/* What the ranges are derived from for as long as the loop is looked at. */
+	entry_state = bpf_flow_keep_state(env, cur);
+	if (!entry_state)
+		return -ENOMEM;
 
 	entry->min_header_count = iters.min_header_count;
 	entry->max_header_count = iters.max_header_count;
 	entry->iv_reg = iters.iv_reg;
 	entry->iv_range = iters.iv_range;
-	entry->entry_state = cur->parent;
+	entry->entry_state = entry_state;
 	entry->terminates = true;
-	err = bpf_widen_scev_regs(env, cur, cur->parent, &iters);
-	if (err < 0)
+	err = bpf_widen_scev_regs(env, cur, entry_state, &iters);
+	return err < 0 ? err : 0;
+}
+
+/* Can the main program return 0? */
+static bool zero_is_valid_retval(struct bpf_verifier_env *env)
+{
+	struct bpf_retval_range range;
+
+	if (program_returns_void(env) || !return_retval_range(env, &range))
+		return true;
+	return range.minval <= 0 && range.maxval >= 0;
+}
+
+/*
+ * A loop or a recursion is out of budget in the current frame of @st. What the
+ * program computed so far is not what it was meant to compute, so it's better
+ * not to go on. The way to stop is to unwind: 'r0 = 0; unwind_exit'. The landing
+ * pads of the callers are code like any other. They release what the callers
+ * hold, or the program is rejected.
+ *
+ * False when it cannot:
+ * - There is no landing pad for what this frame took itself.
+ * - There is a call of the subprog that unwind_goto doesn't follow. That is every
+ *   program that is compiled without unwinding.
+ * - A helper that calls a callback doesn't expect it to unwind.
+ * Then the program goes on along a path that it has, like after may_goto of
+ * its own. It releases what it holds there.
+ */
+static bool budget_can_unwind(struct bpf_verifier_env *env, const struct bpf_verifier_state *st)
+{
+	const struct bpf_func_state *frame = st->frame[st->curframe];
+	const struct bpf_subprog_info *sub = &env->subprog_info[frame->subprogno];
+	bool top;
+
+	if (sub->bail_insn < 0)
+		return false;
+	if (st->acquired_refs != frame->entry_refs ||
+	    st->active_rcu_locks != frame->entry_rcu_locks ||
+	    st->active_preempt_locks != frame->entry_preempt_locks)
+		return false;
+	if (frame->in_callback_fn || frame->in_exception_callback_fn)
+		return false;
+	/* the kernel called it: either exit ends it */
+	top = !st->curframe && !st->callers_unknown &&
+	      (!frame->subprogno || frame->in_async_callback_fn);
+	if (top && !frame->subprogno && !zero_is_valid_retval(env))
+		return false;
+	return top || sub->bail_unwinds;
+}
+
+/*
+ * The current frame leaves with 0 in place of the result: with unwind_exit if the subprog
+ * can do that, with exit otherwise. The insns are added when the main pass is over. Until
+ * then an exit that the subprog has stands for them.
+ */
+static int push_budget_exit(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *sub = &env->subprog_info[cur_func(env)->subprogno];
+	struct bpf_verifier_state *branch;
+	struct bpf_reg_state *regs;
+
+	branch = push_stack(env, sub->bail_insn, env->insn_idx, false);
+	if (IS_ERR(branch))
+		return PTR_ERR(branch);
+	branch->unwound = sub->bail_unwinds;
+	regs = branch->frame[branch->curframe]->regs;
+	__mark_reg_const_zero(env, &regs[BPF_REG_0]);
+	if (bpf_ret_reg_pair(env, cur_func(env)->subprogno))
+		__mark_reg_const_zero(env, &regs[BPF_REG_2]);
+	return 0;
+}
+
+/*
+ * The loop that is not counted and has nothing that stops it at run time gets
+ * may_goto in front of this insn. When it is out of budget the program goes
+ * where may_goto goes with the registers and the stack as they are here.
+ */
+static int check_loop_guard(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[env->insn_idx];
+	struct bpf_func_state *frame = cur_func(env);
+	struct bpf_verifier_state *branch;
+	struct loop_stack_entry *entry;
+	struct bpf_func_state *func;
+	struct bpf_stack_state *slot;
+	struct bpf_reg_state *regs;
+	struct bpf_loop *loop;
+	int h, i, j, err;
+
+	h = bpf_loop_at_index(env, env->insn_idx);
+	if (h < 0 || !frame->loop_stack_cnt)
+		return 0;
+	loop = env->insn_aux_data[h].loop;
+	entry = &frame->loop_stack[frame->loop_stack_cnt - 1];
+	if (loop->rt_bounded || !env->insn_aux_data[env->insn_idx].guard_place ||
+	    entry->loop_id != h || entry->terminates)
+		return 0;
+
+	/*
+	 * A guard has one way out, and only that one is looked at.
+	 *
+	 * Leave the subprog, if that is possible every time the program gets here:
+	 *	do { p = lookup(); } while (!p); *p
+	 * The code that follows the loop counts on what the jump that leaves it has found out.
+	 *
+	 * Otherwise leave the loop:
+	 *	lock(); do { ... } while (...); unlock();
+	 * The code that follows the loop releases what is held.
+	 *
+	 * It's the same way for all states that get here. As long as they leave the subprog
+	 * what would leave the loop is put aside.
+	 */
+	if (!budget_can_unwind(env, env->cur_state))
+		aux->guard_no_unwind = true;
+	if (!aux->loop_guard && !aux->guard_no_unwind) {
+		aux->loop_guard = true;
+		aux->guard_unwind = true;
+	}
+	if (aux->guard_unwind && aux->guard_no_unwind) {
+		aux->guard_unwind = false;
+		bpf_flow_unpark(env, env->insn_idx);
+	}
+	if (!aux->guard_no_unwind) {
+		err = push_budget_exit(env);
+		if (err)
+			return err;
+	}
+	if (aux->guard_to < 0) {
+		if (aux->guard_unwind)
+			return 0;
+		verbose(env, "loop at insn %d never exits\n", h);
+		return -EINVAL;
+	}
+
+	branch = push_stack(env, env->insn_aux_data[env->insn_idx].guard_to, env->insn_idx, false);
+	if (IS_ERR(branch))
+		return PTR_ERR(branch);
+	env->head->parked = aux->guard_unwind;
+	aux->loop_guard = true;
+	if (!aux->guard_at_header)
+		return 0;
+	/*
+	 * The program doesn't leave the loop from here. What it computes in the loop
+	 * for the code that follows is not there. Nothing good comes out of a loop
+	 * that is cut short anyway. Let it be 0.
+	 */
+	regs = branch->frame[branch->curframe]->regs;
+	for (i = BPF_REG_0; i < BPF_REG_FP; i++)
+		if (regs[i].type == NOT_INIT &&
+		    (env->insn_aux_data[aux->guard_to].live_regs_before & BIT(i)))
+			aux->guard_zero |= BIT(i);
+	for (i = BPF_REG_0; i < BPF_REG_FP; i++)
+		if (aux->guard_zero & BIT(i))
+			__mark_reg_const_zero(env, &regs[i]);
+
+	func = branch->frame[branch->curframe];
+	branch->insn_idx = aux->guard_to;
+	err = bpf_live_stack_query_init(env, branch);
+	if (err)
 		return err;
+	for (i = 0; i < min_t(int, bpf_stack_nr_slots(func), 64); i++) {
+		if (!bpf_stack_slot_alive(env, branch->curframe, i * 2) &&
+		    !bpf_stack_slot_alive(env, branch->curframe, i * 2 + 1))
+			continue;
+		slot = bpf_stack_slot(func, i);
+		for (j = 0; j < BPF_REG_SIZE; j++)
+			if (slot->slot_type[j] == STACK_INVALID ||
+			    slot->slot_type[j] == STACK_POISON)
+				aux->guard_zero_slots |= BIT_ULL(i);
+	}
+	for (i = 0; i < min_t(int, bpf_stack_nr_slots(func), 64); i++) {
+		if (!(aux->guard_zero_slots & BIT_ULL(i)))
+			continue;
+		slot = bpf_stack_slot(func, i);
+		bpf_mark_reg_not_init(env, &slot->spilled_ptr);
+		for (j = 0; j < BPF_REG_SIZE; j++)
+			slot->slot_type[j] = STACK_ZERO;
+	}
 	return 0;
 }
 
-static int do_check(struct bpf_verifier_env *env)
+/* The states that the insn pushed go where they were pushed to. */
+static int flow_drain(struct bpf_verifier_env *env)
+{
+	struct bpf_verifier_stack_elem *elem;
+	int err = 0;
+
+	while ((elem = env->head)) {
+		env->head = elem->next;
+		env->stack_size--;
+		if (!err && elem->parked)
+			err = bpf_flow_park(env, &elem->st, elem->insn_idx, elem->prev_insn_idx);
+		else if (!err)
+			err = bpf_flow_deliver(env, &elem->st, elem->insn_idx,
+					       elem->prev_insn_idx);
+		bpf_free_verifier_state(&elem->st, false);
+		kfree(elem);
+	}
+	return err ?: bpf_flow_deliver_unparked(env);
+}
+
+/*
+ * A subprog on a cycle of the call graph counts its frames at run time, see
+ * bpf_insert_recursion_checks(). When there are too many it leaves at once
+ * with 0 in place of the result: it unwinds if it has unwind_exit, otherwise it
+ * returns and callers have to be fine with that.
+ */
+static int check_recursion_guard(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *sub = &env->subprog_info[cur_func(env)->subprogno];
+
+	if (!sub->recursive || env->insn_idx != sub->start)
+		return 0;
+	return push_budget_exit(env);
+}
+
+/* Process the current state until it gets to the start of a basic block. */
+static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 {
-	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
 	struct bpf_verifier_state *state = env->cur_state;
 	struct bpf_insn *insns = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
-	bool do_print_state = false;
-	int prev_insn_idx = -1;
+	bool do_print_state = true;
 
 	for (;;) {
 		struct bpf_insn *insn;
@@ -20801,9 +21778,6 @@ static int do_check(struct bpf_verifier_env *env)
 		if (need_resched())
 			cond_resched();
 
-		/* reset current history entry on each new instruction */
-		env->cur_hist_ent = NULL;
-
 		env->prev_insn_idx = prev_insn_idx;
 		if (env->insn_idx >= insn_cnt) {
 			verbose(env, "invalid insn idx %d insn_cnt %d\n",
@@ -20816,18 +21790,10 @@ static int do_check(struct bpf_verifier_env *env)
 
 		account_processed_insn(env);
 
-		if (env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
-			verbose(env,
-				"BPF program is too large. Processed %d insn\n",
-				env->insn_processed);
-			return -E2BIG;
-		}
-
 		state->last_insn_idx = env->prev_insn_idx;
 		state->insn_idx = env->insn_idx;
 		/*
-		 * Record the incoming edge so active and queued paths use the same
-		 * branch-recording path. A zero-offset conditional has identical
+		 * Record the incoming edge. A zero-offset conditional has identical
 		 * successors, so its outcome cannot be reconstructed from the edge.
 		 */
 		if (!state->speculative && prev_insn_idx >= 0 && prev_insn_idx < insn_cnt) {
@@ -20847,40 +21813,6 @@ static int do_check(struct bpf_verifier_env *env)
 			}
 		}
 
-		/*
-		 * Possibly widen the registers before creating a checkpoint
-		 * in bpf_is_state_visited(). The next loop iteration will
-		 * have a chance to hit this checkpoint and converge.
-		 */
-		err = handle_loop_entry_exit(env);
-		if (err)
-			return err;
-
-		if (bpf_is_prune_point(env, env->insn_idx)) {
-			err = bpf_is_state_visited(env, env->insn_idx);
-			if (err < 0)
-				return err;
-			if (err == 1) {
-				/* found equivalent state, can prune the search */
-				if (env->log.level & BPF_LOG_LEVEL) {
-					if (do_print_state)
-						verbose(env, "\nfrom %d to %d%s: safe\n",
-							env->prev_insn_idx, env->insn_idx,
-							env->cur_state->speculative ?
-							" (speculative execution)" : "");
-					else
-						verbose(env, "%d: safe\n", env->insn_idx);
-				}
-				goto process_bpf_exit;
-			}
-		}
-
-		if (bpf_is_jmp_point(env, env->insn_idx)) {
-			err = bpf_push_jmp_history(env, state, 0, 0, 0, NULL, 0);
-			if (err)
-				return err;
-		}
-
 		if (env->log.level & BPF_LOG_LEVEL2 && do_print_state) {
 			verbose(env, "\nfrom %d to %d%s:",
 				env->prev_insn_idx, env->insn_idx,
@@ -20890,13 +21822,6 @@ static int do_check(struct bpf_verifier_env *env)
 			do_print_state = false;
 		}
 
-		if (bpf_loop_at_index(env, env->insn_idx) >= 0 &&
-		    cur_func(env)->loop_stack_cnt == 0) {
-			verifier_bug(env, "loop stack empty at %d, while inside the loop %d\n",
-				     env->insn_idx, bpf_loop_at_index(env, env->insn_idx));
-			return -EFAULT;
-		}
-
 		if (env->log.level & BPF_LOG_LEVEL) {
 			if (verifier_state_scratched(env))
 				print_insn_state(env, state, state->curframe);
@@ -20947,6 +21872,14 @@ static int do_check(struct bpf_verifier_env *env)
 		if (state->speculative && insn_aux->nospec)
 			goto process_bpf_exit;
 
+		err = check_loop_guard(env);
+		if (err)
+			return err;
+
+		err = check_recursion_guard(env);
+		if (err)
+			return err;
+
 		err = do_check_insn(env, &do_print_state);
 		if (error_recoverable_with_nospec(err) && state->speculative) {
 			/* Prevent this speculative path from ever reaching the
@@ -20968,19 +21901,8 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 
 		if (state->speculative && insn_aux->nospec_result) {
-			/* If we are on a path that performed a jump-op, this
-			 * may skip a nospec patched-in after the jump. This can
-			 * currently never happen because nospec_result is only
-			 * used for the write-ops
-			 * `*(size*)(dst_reg+off)=src_reg|imm32` and helper
-			 * calls. These must never skip the following insn
-			 * (i.e., bpf_insn_successors()'s opcode_info.can_jump
-			 * is false). Still, add a warning to document this in
-			 * case nospec_result is used elsewhere in the future.
-			 *
-			 * All non-branch instructions have a single
-			 * fall-through edge. For these, nospec_result should
-			 * already work.
+			/* All non-branch instructions have a single fall-through
+			 * edge. For these, nospec_result should already work.
 			 */
 			if (verifier_bug_if((BPF_CLASS(insn->code) == BPF_JMP ||
 					     BPF_CLASS(insn->code) == BPF_JMP32) &&
@@ -20990,23 +21912,40 @@ static int do_check(struct bpf_verifier_env *env)
 process_bpf_exit:
 			account_current_path(env);
 			mark_verifier_state_scratched(env);
-			err = bpf_update_branch_counts(env, env->cur_state);
-			if (err)
-				return err;
-			err = pop_stack(env, &prev_insn_idx, &env->insn_idx,
-					pop_log);
-			if (err < 0) {
-				if (err != -ENOENT)
-					return err;
-				break;
-			} else {
-				do_print_state = true;
-				continue;
-			}
+			bpf_free_verifier_state(state, false);
+			memset(state, 0, sizeof(*state));
+			return flow_drain(env);
+		}
+
+		err = flow_drain(env);
+		if (err)
+			return err;
+
+		if (env->insn_idx < insn_cnt && bpf_flow_is_point(env, env->insn_idx)) {
+			account_current_path(env);
+			mark_verifier_state_scratched(env);
+			return bpf_flow_deliver(env, state, env->insn_idx, prev_insn_idx);
 		}
 	}
+}
 
-	return 0;
+static int do_check(struct bpf_verifier_env *env)
+{
+	int prev_insn_idx = -1;
+	int err;
+
+	err = bpf_flow_deliver(env, env->cur_state, env->insn_idx, -1);
+	while (!err) {
+		err = bpf_flow_next(env, &prev_insn_idx);
+		if (err == -ENOENT)
+			return 0;
+		if (err)
+			break;
+		/* What is known about how the state came to be is not kept with it. */
+		bpf_diag_event_log_restore(env, 0);
+		err = do_check_block(env, prev_insn_idx);
+	}
+	return err;
 }
 
 static int find_btf_percpu_datasec(struct btf *btf)
@@ -22069,6 +23008,7 @@ static void free_states(struct bpf_verifier_env *env)
 	bpf_free_verifier_state(env->cur_state, true);
 	env->cur_state = NULL;
 	while (!pop_stack(env, NULL, NULL, false));
+	bpf_flow_reset(env);
 
 	list_for_each_safe(pos, tmp, &env->free_list) {
 		sl = container_of(pos, struct bpf_verifier_state_list, node);
@@ -22102,8 +23042,8 @@ static void free_states(struct bpf_verifier_env *env)
 	}
 }
 
-static int do_check_common(struct bpf_verifier_env *env, int subprog,
-			   enum bpf_func_context context)
+static int __do_check_common(struct bpf_verifier_env *env, int subprog,
+			     enum bpf_func_context context)
 {
 	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
 	struct bpf_subprog_info *sub = subprog_info(env, subprog);
@@ -22124,6 +23064,8 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog,
 	state->speculative = false;
 	state->branches = 1;
 	state->in_sleepable = context == BPF_FUNC_CTX_SLEEPABLE;
+	/* nobody knows what the callers of a global function or of an extension hold */
+	state->callers_unknown = subprog || env->prog->type == BPF_PROG_TYPE_EXT;
 	env->no_rcu_read_lock = context == BPF_FUNC_CTX_NO_RCU_LOCK;
 	state->frame[0] = kzalloc_obj(struct bpf_func_state, GFP_KERNEL_ACCOUNT);
 	if (!state->frame[0]) {
@@ -22230,7 +23172,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog,
 		 * it's matching expected signature, and otherwise mark BTF
 		 * info for main program as unreliable
 		 */
-		if (env->prog->aux->func_info_aux) {
+		if (env->prog->aux->func_info_aux && !env->prog->aux->func_info_aux[0].unreliable) {
 			ret = btf_prepare_func_args(env, 0);
 			if (ret || sub->arg_slot_cnt != 1 ||
 			    sub->args[0].arg_type != ARG_PTR_TO_CTX) {
@@ -22279,6 +23221,26 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog,
 	return ret;
 }
 
+static int do_check_common(struct bpf_verifier_env *env, int subprog,
+			   enum bpf_func_context context)
+{
+	int insn_idx = env->insn_idx, tries = 0, ret;
+	u64 log_pos = env->log.end_pos;
+
+	for (;;) {
+		env->restart = false;
+		ret = __do_check_common(env, subprog, context);
+		if (!ret || !env->restart)
+			return ret;
+		if (++tries == 8) {
+			verbose(env, "verification was started again too many times\n");
+			return ret;
+		}
+		bpf_vlog_reset(&env->log, log_pos);
+		env->insn_idx = insn_idx;
+	}
+}
+
 /* Lazily verify all global functions based on their BTF, if they are called
  * from main BPF program or any of subprograms transitively.
  * BPF global subprogs called from dead code are not validated.
@@ -22364,6 +23326,37 @@ static int do_check_main(struct bpf_verifier_env *env)
 	return ret;
 }
 
+/*
+ * What it took to verify a static subprog on its own is not in insns_total of its callers.
+ * Add it, once per caller. The main prog and global subprogs have all of it already.
+ */
+static void add_insns_of_callees(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *si = env->subprog_info;
+	struct bpf_insn *insn = env->prog->insnsi;
+	int *added, i, j, s, c;
+
+	added = kvcalloc(env->subprog_cnt, sizeof(*added), GFP_KERNEL_ACCOUNT);
+	if (!added)
+		return;
+	/* callees first */
+	for (i = 0; i < env->subprog_cnt; i++) {
+		s = env->subprog_topo_order[i];
+		if (!s || bpf_subprog_is_global(env, s))
+			continue;
+		for (j = si[s].start; j < si[s + 1].start; j++) {
+			if (!bpf_pseudo_call(&insn[j]))
+				continue;
+			c = bpf_find_subprog(env, j + insn[j].imm + 1);
+			if (c <= 0 || c == s || !si[c].on_its_own || added[c] == s)
+				continue;
+			added[c] = s;
+			si[s].insns_total += si[c].insns_total;
+		}
+	}
+	kvfree(added);
+}
+
 static void print_verification_stats(struct bpf_verifier_env *env)
 {
 	/* Skip over hidden subprogs which are not verified. */
@@ -24351,6 +25344,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	ret = mark_recursive_subprogs(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = sort_subprogs_topo(env);
 	if (ret < 0)
 		goto skip_full_check;
@@ -24389,6 +25386,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	ret = bpf_flow_prepare(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	bpf_free_subprog_jts(env);
 
 	ret = mark_fastcall_patterns(env);
@@ -24397,10 +25398,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 
 	ret = do_check_main(env);
 	ret = ret ?: do_check_subprogs(env);
-
-	/* reject recursion through the callx edges found by the main pass */
-	if (ret == 0 && env->callx_edges)
-		ret = sort_subprogs_topo(env);
+	/* while the calls are what they are in the program */
+	if (env->log.level & BPF_LOG_STATS)
+		add_insns_of_callees(env);
 
 	if (ret == 0)
 		ret = bpf_insert_loop_guards(env);
@@ -24560,6 +25560,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	vfree(env->insn_aux_data);
 	kvfree(env->fd_array);
 	bpf_free_scev(env);
+	bpf_flow_free(env);
+	bpf_join_free(env);
 	bpf_stack_liveness_free(env);
 	kvfree(env->cfg.postorder_nums);
 	kvfree(env->cfg.insn_postorder);
-- 
2.55.0

