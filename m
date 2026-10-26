Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983940;
	b=IRA9qxibpNDdcn1E6jRpErjThLV/aj0OOccUTeJYL6G5Ihacu/SjRsNPugbDQjoPUggN
	 gL2kb2MNEEYmp5/8iXjLeZQy5zFXJ/nXOlb7/VY3c/Sz2O303nwzDnW4hbEkwM7Q53+RW
	 tBOvEFwmnZxTfzLhi7u7rRIwY3HQphXA/x0VlxUyMdnLc9GOeL9VO0cv46TotYK3xaahE
	 M5QEV1B04tg4Y6+UqjGfYle5bTVDFZH6nMt25NizAV4hNjRff1JRK4aH3iQNGw7aschce
	 1you4m4fG7u9zSjej2KflAyjRyOgMvtbYq241ErL8h9QNAuv3pUpVLvG39PZY5uKpfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SGvi7pG3Gu1YcQagJF4TFRFCVxQLO+onzHyI1PEdLfw=;
	b=0C5hTADK/Svbjj+DZiTpcxbP+O37OrZFPHpmw2DFG3TvD1X0uFrJvdLXtGjSnz7QGzOU
	 DNHXzjZDWbFDIzrCeTNNiBqc2/ZiXWkESNrU8HkZ7QiAhir8SHFQW1NhxHM3eE9A+NpYV
	 JyW6nN4dytzGIQkP+n148fdtrZCcfBJVqH7Y8yH9WdIDl7BSPQqprcVbQuVB6/9bIDFh9
	 cjyrwjav26IYqQ9S3ulMdIruNPT9oiFtHA+qsGNtWX2iim7SeZeERSyFm5v3Q3P9NUs/z
	 8F6chMPzpP2PCql0Nxv0Njr6W0pTCOdMiKHj5We+4HIgMT45dserZzBbaZKi0Ominhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fJlmIhjj;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E40606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27E40606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fJlmIhjj
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a05e3f0d23so919451b3a.0
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983938; x=1793588738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SGvi7pG3Gu1YcQagJF4TFRFCVxQLO+onzHyI1PEdLfw=;
        b=fJlmIhjjjEkOvZfqmgy4i4pK4+dpRNLKrNKhGm69YovEaosmQ3vuBp/UZQ3nlbMkfn
         QDX3Rz6L8MRJd1AJnjP2omhqXhDsucnQllJyRi/IOCmGIs/wCnLRW5S/KuIZ76LFsR5p
         a223LLRN/zg+d/m1kp8Cw2KoEKGRmmMiAuO32ncDzKrAq1tB4zicpbfS2ts9Ec3l/h+j
         aoYiGvKNdswz/7/2EBRsg3hYMhmPMDp1w65phZQslQdSQZLll2WKS5Gl3AukfdVl+Oe4
         CWFVPh1Q/PRRqF2RkjPmlzrZFMBeyXgqkKeu23d5nOaWalG40PL+D53O7cpLeIbB+54K
         pSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983938; x=1793588738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SGvi7pG3Gu1YcQagJF4TFRFCVxQLO+onzHyI1PEdLfw=;
        b=tVgRz6QcA0Yu7vHPbYoBWTSx30cmiONEvt0REloVJvcBpwIaFrcyIorU/9mH/32vL4
         td+jxFZTDn+IM2oZfTi+NwhOJzJOeax+Y+oMma7TbkQnScmcLtV5AQ0qdUjPnN3dtlZ+
         z2hwAL3v7oavG0qb0uZ0pp2218KSdez3A1m2xy3G6iM8YybC1+t0ws4aQdAwiFj8JIVQ
         J7t61Qvvf3vNXn5d/jhTRVBR10K+xldHQx6/wz2CF3nd5PCRRY/C+niiqgUAzBEcp49Y
         8aFp9Q7GTgegxDefxJchViCzy9GZS1iRlAXElHGdwyiEdnANU9xmSViEDBIE3/umCqJa
         +DDw==
X-Gm-Message-State: AFq9FYKpV0PvwOKPeP416PCuhef+BSpY4NHrlh+NpYppha3z1nldOv7o
	Z50q4wsHcsbOjKcnXbM/3jP8Pj89LuYOoQcYvq5vgDEpJiYaTl56I7tfo3IKmg==
X-Gm-Gg: AYBFou2O222YhcuLMA1ZNakgrLyxdYAkGcTEvObKUeaE0ua0FzbDpzHj/7QVhKwWa+a
	FsRmu7gWh4G3yg/XBGYLE0vMKcSDpPqUSCUDOuJFlkIAG8s9NKJAOWhWOpth9oD9bdGNLTmv9rN
	vAazN/S3Jc/eTnbWJo68A619IPAfDEO/OdgCQqdND3iEZl+F4fuMNrqP4iUez7keg7oKnH/0xJK
	Vuf2k7bGf9Neqk0s5Urd0evPgP8j3u59k7KCelMfmwMRoTUM7ehM7Ba4suj192vn00Deu3kn1EG
	Nl/CaGY9Vnf4g+Dl3N+psB+aY7tVEc7DD5aOJ/jRqDGVYmNiVMsaKXJrNMVglEdmkGimQnlbVte
	N6oko3a/uuGPZORkW/djByKFy9MB6/VipAexT53RQew71tm5eXBs98QV90FgqYlXTTjXMP0q2H5
	H184aXx5iPZo+55DfcqGkivBVsC2bpTO1Yk3fuo4UoLszCmhHAucrLOpBF5Td6JkfuanPpO9o/9
	PpkCUENf+N0HLbhiMMnSQu5z2UK+nsApMXC3nftasS1TMgAK79f3kc1xqN+QZqE5FHuAiQuraVF
	nsM7HbyzoTRjseEZ4xB+T8SV5bqh2bPMHvqrESIswAGOu/ZuZ5ZdVMsdAd06uazsgt25hDVsfWU
	yIT1tyVIZ3iNuws9tuJHVFEo7
X-Received: by 2002:aa7:8895:0:b0:886:458a:42e9 with SMTP id d2e1a72fcca58-8a367a1b6b1mr4332918b3a.49.1792983937814;
        Sun, 25 Oct 2026 20:05:37 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36c100027sm759963b3a.48.2026.10.25.20.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:05:37 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 60/81] bpf: Remove is_state_visited()
Date: Mon, 26 Oct 2026 02:59:21 +0000
Message-ID: <20261026025943.404450-61-alexei.starovoitov@gmail.com>
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

is_state_visited() did the pruning when the verifier followed each path of
a prog. It saved states at selected insns. It stopped a path when a saved
state at the same insn covered the current state.

Since "bpf: Verify programs as a fixpoint over the control flow graph"
flow.c keeps a set of states for each basic block. Nothing calls
is_state_visited(). Remove it, together with the code and the fields that
only it uses.

  removed                       task in the old pass
  ----------------------------  -------------------------------------------
  explored_states, free_list    Hold the saved states.
  'branches' in a state         Count the paths from the state that are
                                not explored.
  SCC visits, backedges         Propagate precision marks over the back
                                edges of a loop.
  states_maybe_looping()        Find an infinite loop.
  widen_imprecise_scalars()     Make the states of a loop with an iterator,
                                a callback or may_goto converge.

BPF_F_TEST_STATE_FREQ told is_state_visited() to save a state each time.
The flag is UAPI, and selftests set it. The kernel continues to accept the
flag, and the flag has no effect.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 116 +----
 kernel/bpf/cfg.c             |   7 -
 kernel/bpf/states.c          | 957 -----------------------------------
 kernel/bpf/verifier.c        | 227 +--------
 4 files changed, 5 insertions(+), 1302 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 51abcaead6b9..d704b3776b68 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -509,52 +509,6 @@ struct bpf_verifier_state {
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
 
@@ -586,10 +540,6 @@ struct bpf_verifier_state {
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
@@ -597,9 +547,6 @@ struct bpf_verifier_state {
 	 */
 	struct bpf_jmp_history_entry *jmp_history;
 	u32 jmp_history_cnt;
-	u32 dfs_depth;
-	u32 callback_unroll_depth;
-	u32 may_goto_depth;
 };
 
 /* Number of BPF_REG_SIZE stack slots tracked for the frame so far. */
@@ -689,15 +636,6 @@ bpf_get_spilled_stack_arg(int slot, struct bpf_func_state *frame)
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
@@ -1111,38 +1049,6 @@ struct bpf_idset {
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
 
@@ -1166,17 +1072,11 @@ struct bpf_verifier_env {
 	struct bpf_verifier_stack_elem *head; /* stack of verifier states to be processed */
 	int stack_size;			/* number of states to be processed */
 	bool strict_alignment;		/* perform strict pointer alignment checks */
-	bool test_state_freq;		/* test verifier with different pruning frequency */
 	bool test_reg_invariants;	/* fail verification on register invariants violations */
 	bool uses_arena_sp;		/* the program has insns with BPF_REG_ARENA_SP */
 	bool restart;			/* do the main pass again with what was found out */
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
@@ -1250,9 +1150,7 @@ struct bpf_verifier_env {
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
@@ -1270,9 +1168,6 @@ struct bpf_verifier_env {
 	u32 peak_states;
 	/* longest register parentage chain walked for liveness marking */
 	u32 longest_mark_read_walk;
-	u32 free_list_size;
-	u32 explored_states_size;
-	u32 num_backedges;
 	/*
 	 * The program's fd_array comes in two shapes, told apart by whether
 	 * the caller passed fd_array_cnt. They are mutually exclusive:
@@ -1305,11 +1200,7 @@ struct bpf_verifier_env {
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
@@ -1498,7 +1389,6 @@ void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
 
 int mark_chain_precision(struct bpf_verifier_env *env, int regno);
 
-int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx);
 int bpf_clean_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 bool bpf_state_subsumes(struct bpf_verifier_env *env, struct bpf_verifier_state *old,
 			struct bpf_verifier_state *cur);
@@ -1540,15 +1430,11 @@ bool bpf_insn_is_iter_next(struct bpf_verifier_env *env, struct bpf_insn *insn);
 bool bpf_insn_leaves_loop(struct bpf_verifier_env *env, int h, int n);
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
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 2ee950e9ac82..f5705ea0bcb9 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -1016,13 +1016,6 @@ int bpf_compute_scc(struct bpf_verifier_env *env)
 			dfs_sz--;
 		}
 	}
-	env->scc_info = kvzalloc_objs(*env->scc_info, next_scc_id,
-				      GFP_KERNEL_ACCOUNT);
-	if (!env->scc_info) {
-		err = -ENOMEM;
-		goto exit;
-	}
-	env->scc_cnt = next_scc_id;
 exit:
 	kvfree(stack);
 	kvfree(pre);
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index d55adade5b1c..7cf81ba411eb 100644
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
@@ -1071,672 +780,6 @@ static bool states_equal(struct bpf_verifier_env *env,
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
-static struct loop_stack_entry *current_loop(struct bpf_verifier_state *st)
-{
-	struct bpf_func_state *frame = st->frame[st->curframe];
-
-	if (frame->loop_stack_cnt == 0)
-		return NULL;
-	return &frame->loop_stack[frame->loop_stack_cnt - 1];
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
-			if (old_loop && cur_loop &&
-			    old_loop->terminates && cur_loop->terminates &&
-			    old_loop->entry_state == cur_loop->entry_state) {
-				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
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
index e55ba1db2e1f..2c385a7d459c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -202,8 +202,6 @@ struct bpf_verifier_stack_elem {
 	u64 diag_log_pos;
 };
 
-#define BPF_COMPLEXITY_LIMIT_STATES	64
-
 #define BPF_GLOBAL_PERCPU_MA_MAX_SIZE  512
 
 #define BPF_PRIV_STACK_MIN_SIZE		64
@@ -1788,14 +1786,9 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
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
@@ -1811,45 +1804,6 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
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
@@ -1915,18 +1869,6 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
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
 
@@ -2598,7 +2540,6 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	 * This is async callback. It starts in a fresh stack.
 	 * Initialize it similar to do_check_common().
 	 */
-	elem->st.branches = 1;
 	elem->st.in_sleepable = is_sleepable;
 	frame = kzalloc_obj(*frame, GFP_KERNEL_ACCOUNT);
 	if (!frame)
@@ -8954,85 +8895,6 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
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
@@ -11703,7 +11565,6 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	if (err)
 		return err;
 
-	callback_state->callback_unroll_depth++;
 	callback_state->frame[callback_state->curframe - 1]->callback_depth++;
 	caller->callback_depth = 0;
 	return 0;
@@ -12676,10 +12537,9 @@ static bool retval_range_within(struct bpf_retval_range range, const struct bpf_
 
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 {
-	struct bpf_verifier_state *state = env->cur_state, *prev_st;
+	struct bpf_verifier_state *state = env->cur_state;
 	struct bpf_func_state *caller, *callee;
 	struct bpf_reg_state *r0;
-	bool in_callback_fn;
 	u32 i, nregs;
 	int err;
 
@@ -12767,11 +12627,9 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 		return err;
 
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
@@ -12788,24 +12646,6 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
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
 
@@ -19690,19 +19530,14 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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
@@ -21175,7 +21010,6 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 	case BPF_JMP32: {
 		u8 opcode = BPF_OP(insn->code);
 
-		env->jmps_processed++;
 		if (opcode == BPF_CALL) {
 			if (env->cur_state->active_locks) {
 				/* similar to static subprog calls callx is allowed under a lock */
@@ -23000,46 +22834,10 @@ static void sanitize_dead_code(struct bpf_verifier_env *env)
 
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
 
 static int __do_check_common(struct bpf_verifier_env *env, int subprog,
@@ -23062,7 +22860,6 @@ static int __do_check_common(struct bpf_verifier_env *env, int subprog,
 		return -ENOMEM;
 	state->curframe = 0;
 	state->speculative = false;
-	state->branches = 1;
 	state->in_sleepable = context == BPF_FUNC_CTX_SLEEPABLE;
 	/* nobody knows what the callers of a global function or of an extension hold */
 	state->callers_unknown = subprog || env->prog->type == BPF_PROG_TYPE_EXT;
@@ -25250,21 +25047,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
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
@@ -25409,8 +25193,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 		ret = bpf_prog_offload_finalize(env);
 
 skip_full_check:
-	kvfree(env->explored_states);
-
 	/* might decrease stack depth, keep it before passes that
 	 * allocate additional slots.
 	 */
@@ -25565,7 +25347,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	bpf_stack_liveness_free(env);
 	kvfree(env->cfg.postorder_nums);
 	kvfree(env->cfg.insn_postorder);
-	kvfree(env->scc_info);
 	kvfree(env->succ);
 	kvfree(env->gotox_tmp_buf);
 	kvfree(env->callx_edges);
-- 
2.55.0

