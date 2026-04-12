Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3631284B2F
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 04:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775966409; cv=none; b=tJ9HjseD+XTLqO4uFoKWvszMDlHfVelIc3Wao9DQ9tvqKYMn3j2y4+jf2jHPtI9ISU3qwxEYA2v4j+vQL0Ubexjae0/IPIoYMt8BRWv6GvUGUxOsU422ppIO+n5T73cQ6p4CixZDhGrdIvZqARzW+O8x2VRa3kOZWbKfAKxHrac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775966409; c=relaxed/simple;
	bh=lKglUOakP2BsGyEErbNF7WVEj6uXniAI6g4i4RaV9Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MhPEaqHBF0idYgSy7Xdj2OW79r3wqAPoFlSXn9sTVXC+Lfz5injYLnZtTeQ9iVs12SZ0yufxZtZq1Fzfv93KNoBt4XGoKDv6PVI7S8tvjsXNbhVxGt9oyGDDASw3aJmg+SkETxN1nW6sLhPXAbcvDAlDw0W2PYchMUzoLWoLMaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIQB5T4V; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIQB5T4V"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c742d4df00cso1208987a12.1
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 21:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775966402; x=1776571202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5vggwWVE55ab053CthrbvoKjIU91URyJhA7ysIin0E=;
        b=nIQB5T4VEh9vc7tl6RXUWUCLY7CcN6/el8eRvyy0VW6GfL87QFj6elAEASSkqra4Io
         t5ECjKdDHq7hC23KRlEqcVdn/BmFan7yO/A2D3B5LyPiUDhyQ5ehDIqJPrrbyU5t95Uh
         hADCaVoko1FiNJ23B5M0GnAE8OF/lh0hHVmiIR+TkTJ/inpDs6jKdVKmJ5LHdKyNIdgP
         qxdYAwoeq8GsLNACwrdBMN431RFIjuGdJK6rhjEmk602LZh1haK5mdhPV5VoElXrq1uA
         fmY89ZqYAPIsWYr1YPFpzBCmBCam0f6+sKRNotDFG5ZT3J7+Uvg4QbLX3T8yTSPhqWQ8
         c9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775966402; x=1776571202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j5vggwWVE55ab053CthrbvoKjIU91URyJhA7ysIin0E=;
        b=JEXv/h2T3V9UzrZuwsjWxH+teURFUZ69dWEqxFTfDCim9h9akEJU3adQ+2M0R7KANR
         zzf+6r/r9fldM3fxL/RebnrUfvCKhP3t4ylCMtUs/HtRtN5wx9DPWizyVKbqXTLqIkIa
         uhr6fqr7NS7y5RBBx+ooKeOnPMB74sTk2ABfvBQncusRmHtxztFpuNcNSTlIrbcyBbY9
         c4vI87qyC8hpUoCwFKuOS9HBOCqr07gsn/IP3QCtxmyofss7Of9so28BEdH8C4BXeVkU
         PJFKN2KNc3lJFV8NJxf8v5ZXeraveqQVVypsJ3b2lk3eBvffD67/0Mmp2XDjalOzFvlG
         eipw==
X-Gm-Message-State: AOJu0YzBM+OaF6ed+vlon/8DymIAYd80aRT1W2JIhXXI2bJ2Lroi7LX3
	ZYFr31fpb7g7mBXKJtgcV1oEqjgXDt/SGUCp/IgduAzfE/bGEnnAxvw4M2DRqg==
X-Gm-Gg: AeBDieuXQ7pynoY9u0FH3WPUkGGmFOJQLRCqdhSDh/P6ULWYeW2nso3rEzmGWQ9eazq
	/GlxnVzL2megFi/MCBcICNMZsRyh8iZL4JbdnxCjYDsJjD9qAXIdJvuNumpdeay6efhLlyNklcZ
	knrSqKWTbglx1CiBzYxxpkPktny8SwUifKMQT/COLyDVXene9rjAAk9CoZzumqHWF+BX8fvZLm4
	NyNP/0TbYfB6gURj0UEdZJOh2VAYb7B0e4nLWQwgVB9HKgFIsb+8OKuQwUXlQCWpPWOBdvB5ubB
	ZOFGjQEu2AMbZPMSaeNyjVn4IJCSFId+YMD4QVnWPjhQ+vxuDMsBkTAO1Z9O2sfkgofLZsYjjQf
	5Fb2a+L511NiNPq0QQJuV7wo23Enqy0ahFPLoDfBj1rAQystqhHGSyx9KlSrOScGbNv4rtUbc2e
	LHb0kgMUgACfIOvhwCLqffp06eib9Xsee4HSb1Ai1sUgsS2jBzOOB8NUCKXUCzA5tvd65NCLQ/T
	nbDEkNv/sxn1+gAxgLXAGybpNssMvq67xYzDFIRx8A=
X-Received: by 2002:a17:903:1ae6:b0:2b2:54db:3e93 with SMTP id d9443c01a7336-2b2c736f057mr111631385ad.23.1775966400384;
        Sat, 11 Apr 2026 21:00:00 -0700 (PDT)
Received: from ast-mac ([2603:3023:126:8500:1c82:6ab4:808c:1834])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f26a97sm94983465ad.61.2026.04.11.20.59.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Apr 2026 20:59:59 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf-next 4/6] bpf: Move state equivalence logic to states.c
Date: Sat, 11 Apr 2026 20:59:42 -0700
Message-ID: <20260412035945.46916-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260412035945.46916-1-alexei.starovoitov@gmail.com>
References: <20260412035945.46916-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

verifier.c is huge. Move is_state_visited() to states.c,
so that all state equivalence logic is in one file.

Mechanical move. No functional changes.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   66 ++
 kernel/bpf/Makefile          |    2 +-
 kernel/bpf/cfg.c             |   95 +-
 kernel/bpf/states.c          | 1552 ++++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 2001 ++++------------------------------
 5 files changed, 1905 insertions(+), 1811 deletions(-)
 create mode 100644 kernel/bpf/states.c

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index aa92a597bc5c..d602e05a826e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1068,6 +1068,72 @@ void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
 
 int mark_chain_precision(struct bpf_verifier_env *env, int regno);
 
+int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx);
+int bpf_update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
+
+void bpf_clear_jmp_history(struct bpf_verifier_state *state);
+int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
+			    const struct bpf_verifier_state *src);
+struct list_head *bpf_explored_state(struct bpf_verifier_env *env, int idx);
+void bpf_free_verifier_state(struct bpf_verifier_state *state, bool free_self);
+void bpf_free_backedges(struct bpf_scc_visit *visit);
+int bpf_push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
+			 int insn_flags, u64 linked_regs);
+void bpf_mark_reg_not_init(const struct bpf_verifier_env *env,
+			   struct bpf_reg_state *reg);
+void bpf_mark_reg_unknown_imprecise(struct bpf_reg_state *reg);
+void bpf_mark_all_scalars_precise(struct bpf_verifier_env *env,
+				  struct bpf_verifier_state *st);
+void bpf_clear_singular_ids(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
+int bpf_mark_chain_precision(struct bpf_verifier_env *env,
+			     struct bpf_verifier_state *starting_state,
+			     int regno, bool *changed);
+
+static inline int bpf_get_spi(s32 off)
+{
+	return (-off - 1) / BPF_REG_SIZE;
+}
+
+static inline struct bpf_func_state *bpf_func(struct bpf_verifier_env *env,
+					      const struct bpf_reg_state *reg)
+{
+	struct bpf_verifier_state *cur = env->cur_state;
+
+	return cur->frame[reg->frameno];
+}
+
+static inline u32 bpf_frame_insn_idx(struct bpf_verifier_state *st, u32 frame)
+{
+	return frame == st->curframe
+	       ? st->insn_idx
+	       : st->frame[frame + 1]->callsite;
+}
+
+static inline bool bpf_is_jmp_point(struct bpf_verifier_env *env, int insn_idx)
+{
+	return env->insn_aux_data[insn_idx].jmp_point;
+}
+
+static inline bool bpf_is_spilled_reg(const struct bpf_stack_state *stack)
+{
+	return stack->slot_type[BPF_REG_SIZE - 1] == STACK_SPILL;
+}
+
+static inline bool bpf_register_is_null(struct bpf_reg_state *reg)
+{
+	return reg->type == SCALAR_VALUE && tnum_equals_const(reg->var_off, 0);
+}
+
+static inline void bpf_bt_set_frame_reg(struct backtrack_state *bt, u32 frame, u32 reg)
+{
+	bt->reg_masks[frame] |= 1 << reg;
+}
+
+static inline void bpf_bt_set_frame_slot(struct backtrack_state *bt, u32 frame, u32 slot)
+{
+	bt->stack_masks[frame] |= 1ull << slot;
+}
+
 bool bpf_map_is_rdonly(const struct bpf_map *map);
 int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
 			bool is_ldsx);
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 8649ee9651a9..3da5dae33827 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
-obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o
+obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 365dcbb848af..998f42a8189a 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -710,6 +710,12 @@ int bpf_compute_scc(struct bpf_verifier_env *env)
 
 	next_preorder_num = 1;
 	next_scc_id = 1;
+	/*
+	 * - 'stack' accumulates vertices in DFS order, see invariant comment below;
+	 * - 'pre[t] == p' => preorder number of vertex 't' is 'p';
+	 * - 'low[t] == n' => smallest preorder number of the vertex reachable from 't' is 'n';
+	 * - 'dfs' DFS traversal stack, used to emulate explicit recursion.
+	 */
 	stack = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
 	pre = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
 	low = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
@@ -718,6 +724,79 @@ int bpf_compute_scc(struct bpf_verifier_env *env)
 		err = -ENOMEM;
 		goto exit;
 	}
+	/*
+	 * References:
+	 * [1] R. Tarjan "Depth-First Search and Linear Graph Algorithms"
+	 * [2] D. J. Pearce "A Space-Efficient Algorithm for Finding Strongly Connected Components"
+	 *
+	 * The algorithm maintains the following invariant:
+	 * - suppose there is a path 'u' ~> 'v', such that 'pre[v] < pre[u]';
+	 * - then, vertex 'u' remains on stack while vertex 'v' is on stack.
+	 *
+	 * Consequently:
+	 * - If 'low[v] < pre[v]', there is a path from 'v' to some vertex 'u',
+	 *   such that 'pre[u] == low[v]'; vertex 'u' is currently on the stack,
+	 *   and thus there is an SCC (loop) containing both 'u' and 'v'.
+	 * - If 'low[v] == pre[v]', loops containing 'v' have been explored,
+	 *   and 'v' can be considered the root of some SCC.
+	 *
+	 * Here is a pseudo-code for an explicitly recursive version of the algorithm:
+	 *
+	 *    NOT_ON_STACK = insn_cnt + 1
+	 *    pre = [0] * insn_cnt
+	 *    low = [0] * insn_cnt
+	 *    scc = [0] * insn_cnt
+	 *    stack = []
+	 *
+	 *    next_preorder_num = 1
+	 *    next_scc_id = 1
+	 *
+	 *    def recur(w):
+	 *        nonlocal next_preorder_num
+	 *        nonlocal next_scc_id
+	 *
+	 *        pre[w] = next_preorder_num
+	 *        low[w] = next_preorder_num
+	 *        next_preorder_num += 1
+	 *        stack.append(w)
+	 *        for s in successors(w):
+	 *            # Note: for classic algorithm the block below should look as:
+	 *            #
+	 *            # if pre[s] == 0:
+	 *            #     recur(s)
+	 *            #     low[w] = min(low[w], low[s])
+	 *            # elif low[s] != NOT_ON_STACK:
+	 *            #     low[w] = min(low[w], pre[s])
+	 *            #
+	 *            # But replacing both 'min' instructions with 'low[w] = min(low[w], low[s])'
+	 *            # does not break the invariant and makes iterative version of the algorithm
+	 *            # simpler. See 'Algorithm #3' from [2].
+	 *
+	 *            # 's' not yet visited
+	 *            if pre[s] == 0:
+	 *                recur(s)
+	 *            # if 's' is on stack, pick lowest reachable preorder number from it;
+	 *            # if 's' is not on stack 'low[s] == NOT_ON_STACK > low[w]',
+	 *            # so 'min' would be a noop.
+	 *            low[w] = min(low[w], low[s])
+	 *
+	 *        if low[w] == pre[w]:
+	 *            # 'w' is the root of an SCC, pop all vertices
+	 *            # below 'w' on stack and assign same SCC to them.
+	 *            while True:
+	 *                t = stack.pop()
+	 *                low[t] = NOT_ON_STACK
+	 *                scc[t] = next_scc_id
+	 *                if t == w:
+	 *                    break
+	 *            next_scc_id += 1
+	 *
+	 *    for i in range(0, insn_cnt):
+	 *        if pre[i] == 0:
+	 *            recur(i)
+	 *
+	 * Below implementation replaces explicit recursion with array 'dfs'.
+	 */
 	for (i = 0; i < insn_cnt; i++) {
 		if (pre[i])
 			continue;
@@ -743,19 +822,29 @@ int bpf_compute_scc(struct bpf_verifier_env *env)
 					goto dfs_continue;
 				}
 			}
+			/*
+			 * Preserve the invariant: if some vertex above in the stack
+			 * is reachable from 'w', keep 'w' on the stack.
+			 */
 			if (low[w] < pre[w]) {
 				dfs_sz--;
 				goto dfs_continue;
 			}
-			assign_scc = stack[stack_sz - 1] != w;
-			for (j = 0; j < succ->cnt; ++j) {
+			/*
+			 * Assign SCC number only if component has two or more elements,
+			 * or if component has a self reference, or if instruction is a
+			 * callback calling function (implicit loop).
+			 */
+			assign_scc = stack[stack_sz - 1] != w;	/* two or more elements? */
+			for (j = 0; j < succ->cnt; ++j) {	/* self reference? */
 				if (succ->items[j] == w) {
 					assign_scc = true;
 					break;
 				}
 			}
-			if (bpf_calls_callback(env, w))
+			if (bpf_calls_callback(env, w)) /* implicit loop? */
 				assign_scc = true;
+			/* Pop component elements from stack */
 			do {
 				t = stack[--stack_sz];
 				low[t] = NOT_ON_STACK;
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
new file mode 100644
index 000000000000..3a4a7f6d861e
--- /dev/null
+++ b/kernel/bpf/states.c
@@ -0,0 +1,1552 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
+#include <linux/filter.h>
+
+#define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
+
+#define BPF_COMPLEXITY_LIMIT_STATES	64
+
+static bool is_may_goto_insn_at(struct bpf_verifier_env *env, int insn_idx)
+{
+	return bpf_is_may_goto_insn(&env->prog->insnsi[insn_idx]);
+}
+
+static bool is_iter_next_insn(struct bpf_verifier_env *env, int insn_idx)
+{
+	return env->insn_aux_data[insn_idx].is_iter_next;
+}
+
+static void update_peak_states(struct bpf_verifier_env *env)
+{
+	u32 cur_states;
+
+	cur_states = env->explored_states_size + env->free_list_size + env->num_backedges;
+	env->peak_states = max(env->peak_states, cur_states);
+}
+
+/* struct bpf_verifier_state->parent refers to states
+ * that are in either of env->{expored_states,free_list}.
+ * In both cases the state is contained in struct bpf_verifier_state_list.
+ */
+static struct bpf_verifier_state_list *state_parent_as_list(struct bpf_verifier_state *st)
+{
+	if (st->parent)
+		return container_of(st->parent, struct bpf_verifier_state_list, state);
+	return NULL;
+}
+
+static bool incomplete_read_marks(struct bpf_verifier_env *env,
+				  struct bpf_verifier_state *st);
+
+/* A state can be freed if it is no longer referenced:
+ * - is in the env->free_list;
+ * - has no children states;
+ */
+static void maybe_free_verifier_state(struct bpf_verifier_env *env,
+				      struct bpf_verifier_state_list *sl)
+{
+	if (!sl->in_free_list
+	    || sl->state.branches != 0
+	    || incomplete_read_marks(env, &sl->state))
+		return;
+	list_del(&sl->node);
+	bpf_free_verifier_state(&sl->state, false);
+	kfree(sl);
+	env->free_list_size--;
+}
+
+/* Return IP for a given frame in a call stack */
+static bool compute_scc_callchain(struct bpf_verifier_env *env,
+				  struct bpf_verifier_state *st,
+				  struct bpf_scc_callchain *callchain)
+{
+	u32 i, scc, insn_idx;
+
+	memset(callchain, 0, sizeof(*callchain));
+	for (i = 0; i <= st->curframe; i++) {
+		insn_idx = bpf_frame_insn_idx(st, i);
+		scc = env->insn_aux_data[insn_idx].scc;
+		if (scc) {
+			callchain->scc = scc;
+			break;
+		} else if (i < st->curframe) {
+			callchain->callsites[i] = insn_idx;
+		} else {
+			return false;
+		}
+	}
+	return true;
+}
+
+/* Check if bpf_scc_visit instance for @callchain exists. */
+static struct bpf_scc_visit *scc_visit_lookup(struct bpf_verifier_env *env,
+					      struct bpf_scc_callchain *callchain)
+{
+	struct bpf_scc_info *info = env->scc_info[callchain->scc];
+	struct bpf_scc_visit *visits = info->visits;
+	u32 i;
+
+	if (!info)
+		return NULL;
+	for (i = 0; i < info->num_visits; i++)
+		if (memcmp(callchain, &visits[i].callchain, sizeof(*callchain)) == 0)
+			return &visits[i];
+	return NULL;
+}
+
+/* Allocate a new bpf_scc_visit instance corresponding to @callchain.
+ * Allocated instances are alive for a duration of the do_check_common()
+ * call and are freed by free_states().
+ */
+static struct bpf_scc_visit *scc_visit_alloc(struct bpf_verifier_env *env,
+					     struct bpf_scc_callchain *callchain)
+{
+	struct bpf_scc_visit *visit;
+	struct bpf_scc_info *info;
+	u32 scc, num_visits;
+	u64 new_sz;
+
+	scc = callchain->scc;
+	info = env->scc_info[scc];
+	num_visits = info ? info->num_visits : 0;
+	new_sz = sizeof(*info) + sizeof(struct bpf_scc_visit) * (num_visits + 1);
+	info = kvrealloc(env->scc_info[scc], new_sz, GFP_KERNEL_ACCOUNT);
+	if (!info)
+		return NULL;
+	env->scc_info[scc] = info;
+	info->num_visits = num_visits + 1;
+	visit = &info->visits[num_visits];
+	memset(visit, 0, sizeof(*visit));
+	memcpy(&visit->callchain, callchain, sizeof(*callchain));
+	return visit;
+}
+
+/* Form a string '(callsite#1,callsite#2,...,scc)' in env->tmp_str_buf */
+static char *format_callchain(struct bpf_verifier_env *env, struct bpf_scc_callchain *callchain)
+{
+	char *buf = env->tmp_str_buf;
+	int i, delta = 0;
+
+	delta += snprintf(buf + delta, TMP_STR_BUF_LEN - delta, "(");
+	for (i = 0; i < ARRAY_SIZE(callchain->callsites); i++) {
+		if (!callchain->callsites[i])
+			break;
+		delta += snprintf(buf + delta, TMP_STR_BUF_LEN - delta, "%u,",
+				  callchain->callsites[i]);
+	}
+	delta += snprintf(buf + delta, TMP_STR_BUF_LEN - delta, "%u)", callchain->scc);
+	return env->tmp_str_buf;
+}
+
+/* If callchain for @st exists (@st is in some SCC), ensure that
+ * bpf_scc_visit instance for this callchain exists.
+ * If instance does not exist or is empty, assign visit->entry_state to @st.
+ */
+static int maybe_enter_scc(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	struct bpf_scc_callchain *callchain = &env->callchain_buf;
+	struct bpf_scc_visit *visit;
+
+	if (!compute_scc_callchain(env, st, callchain))
+		return 0;
+	visit = scc_visit_lookup(env, callchain);
+	visit = visit ?: scc_visit_alloc(env, callchain);
+	if (!visit)
+		return -ENOMEM;
+	if (!visit->entry_state) {
+		visit->entry_state = st;
+		if (env->log.level & BPF_LOG_LEVEL2)
+			verbose(env, "SCC enter %s\n", format_callchain(env, callchain));
+	}
+	return 0;
+}
+
+static int propagate_backedges(struct bpf_verifier_env *env, struct bpf_scc_visit *visit);
+
+/* If callchain for @st exists (@st is in some SCC), make it empty:
+ * - set visit->entry_state to NULL;
+ * - flush accumulated backedges.
+ */
+static int maybe_exit_scc(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	struct bpf_scc_callchain *callchain = &env->callchain_buf;
+	struct bpf_scc_visit *visit;
+
+	if (!compute_scc_callchain(env, st, callchain))
+		return 0;
+	visit = scc_visit_lookup(env, callchain);
+	if (!visit) {
+		/*
+		 * If path traversal stops inside an SCC, corresponding bpf_scc_visit
+		 * must exist for non-speculative paths. For non-speculative paths
+		 * traversal stops when:
+		 * a. Verification error is found, maybe_exit_scc() is not called.
+		 * b. Top level BPF_EXIT is reached. Top level BPF_EXIT is not a member
+		 *    of any SCC.
+		 * c. A checkpoint is reached and matched. Checkpoints are created by
+		 *    is_state_visited(), which calls maybe_enter_scc(), which allocates
+		 *    bpf_scc_visit instances for checkpoints within SCCs.
+		 * (c) is the only case that can reach this point.
+		 */
+		if (!st->speculative) {
+			verifier_bug(env, "scc exit: no visit info for call chain %s",
+				     format_callchain(env, callchain));
+			return -EFAULT;
+		}
+		return 0;
+	}
+	if (visit->entry_state != st)
+		return 0;
+	if (env->log.level & BPF_LOG_LEVEL2)
+		verbose(env, "SCC exit %s\n", format_callchain(env, callchain));
+	visit->entry_state = NULL;
+	env->num_backedges -= visit->num_backedges;
+	visit->num_backedges = 0;
+	update_peak_states(env);
+	return propagate_backedges(env, visit);
+}
+
+/* Lookup an bpf_scc_visit instance corresponding to @st callchain
+ * and add @backedge to visit->backedges. @st callchain must exist.
+ */
+static int add_scc_backedge(struct bpf_verifier_env *env,
+			    struct bpf_verifier_state *st,
+			    struct bpf_scc_backedge *backedge)
+{
+	struct bpf_scc_callchain *callchain = &env->callchain_buf;
+	struct bpf_scc_visit *visit;
+
+	if (!compute_scc_callchain(env, st, callchain)) {
+		verifier_bug(env, "add backedge: no SCC in verification path, insn_idx %d",
+			     st->insn_idx);
+		return -EFAULT;
+	}
+	visit = scc_visit_lookup(env, callchain);
+	if (!visit) {
+		verifier_bug(env, "add backedge: no visit info for call chain %s",
+			     format_callchain(env, callchain));
+		return -EFAULT;
+	}
+	if (env->log.level & BPF_LOG_LEVEL2)
+		verbose(env, "SCC backedge %s\n", format_callchain(env, callchain));
+	backedge->next = visit->backedges;
+	visit->backedges = backedge;
+	visit->num_backedges++;
+	env->num_backedges++;
+	update_peak_states(env);
+	return 0;
+}
+
+/* bpf_reg_state->live marks for registers in a state @st are incomplete,
+ * if state @st is in some SCC and not all execution paths starting at this
+ * SCC are fully explored.
+ */
+static bool incomplete_read_marks(struct bpf_verifier_env *env,
+				  struct bpf_verifier_state *st)
+{
+	struct bpf_scc_callchain *callchain = &env->callchain_buf;
+	struct bpf_scc_visit *visit;
+
+	if (!compute_scc_callchain(env, st, callchain))
+		return false;
+	visit = scc_visit_lookup(env, callchain);
+	if (!visit)
+		return false;
+	return !!visit->backedges;
+}
+
+int bpf_update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	struct bpf_verifier_state_list *sl = NULL, *parent_sl;
+	struct bpf_verifier_state *parent;
+	int err;
+
+	while (st) {
+		u32 br = --st->branches;
+
+		/* verifier_bug_if(br > 1, ...) technically makes sense here,
+		 * but see comment in push_stack(), hence:
+		 */
+		verifier_bug_if((int)br < 0, env, "%s:branches_to_explore=%d", __func__, br);
+		if (br)
+			break;
+		err = maybe_exit_scc(env, st);
+		if (err)
+			return err;
+		parent = st->parent;
+		parent_sl = state_parent_as_list(st);
+		if (sl)
+			maybe_free_verifier_state(env, sl);
+		st = parent;
+		sl = parent_sl;
+	}
+	return 0;
+}
+
+static bool range_within(const struct bpf_reg_state *old,
+			 const struct bpf_reg_state *cur)
+{
+	return old->umin_value <= cur->umin_value &&
+	       old->umax_value >= cur->umax_value &&
+	       old->smin_value <= cur->smin_value &&
+	       old->smax_value >= cur->smax_value &&
+	       old->u32_min_value <= cur->u32_min_value &&
+	       old->u32_max_value >= cur->u32_max_value &&
+	       old->s32_min_value <= cur->s32_min_value &&
+	       old->s32_max_value >= cur->s32_max_value;
+}
+
+/* If in the old state two registers had the same id, then they need to have
+ * the same id in the new state as well.  But that id could be different from
+ * the old state, so we need to track the mapping from old to new ids.
+ * Once we have seen that, say, a reg with old id 5 had new id 9, any subsequent
+ * regs with old id 5 must also have new id 9 for the new state to be safe.  But
+ * regs with a different old id could still have new id 9, we don't care about
+ * that.
+ * So we look through our idmap to see if this old id has been seen before.  If
+ * so, we require the new id to match; otherwise, we add the id pair to the map.
+ */
+static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
+{
+	struct bpf_id_pair *map = idmap->map;
+	unsigned int i;
+
+	/* either both IDs should be set or both should be zero */
+	if (!!old_id != !!cur_id)
+		return false;
+
+	if (old_id == 0) /* cur_id == 0 as well */
+		return true;
+
+	for (i = 0; i < idmap->cnt; i++) {
+		if (map[i].old == old_id)
+			return map[i].cur == cur_id;
+		if (map[i].cur == cur_id)
+			return false;
+	}
+
+	/* Reached the end of known mappings; haven't seen this id before */
+	if (idmap->cnt < BPF_ID_MAP_SIZE) {
+		map[idmap->cnt].old = old_id;
+		map[idmap->cnt].cur = cur_id;
+		idmap->cnt++;
+		return true;
+	}
+
+	/* We ran out of idmap slots, which should be impossible */
+	WARN_ON_ONCE(1);
+	return false;
+}
+
+/*
+ * Compare scalar register IDs for state equivalence.
+ *
+ * When old_id == 0, the old register is independent - not linked to any
+ * other register. Any linking in the current state only adds constraints,
+ * making it more restrictive. Since the old state didn't rely on any ID
+ * relationships for this register, it's always safe to accept cur regardless
+ * of its ID. Hence, return true immediately.
+ *
+ * When old_id != 0 but cur_id == 0, we need to ensure that different
+ * independent registers in cur don't incorrectly satisfy the ID matching
+ * requirements of linked registers in old.
+ *
+ * Example: if old has r6.id=X and r7.id=X (linked), but cur has r6.id=0
+ * and r7.id=0 (both independent), without temp IDs both would map old_id=X
+ * to cur_id=0 and pass. With temp IDs: r6 maps X->temp1, r7 tries to map
+ * X->temp2, but X is already mapped to temp1, so the check fails correctly.
+ *
+ * When old_id has BPF_ADD_CONST set, the compound id (base | flag) and the
+ * base id (flag stripped) must both map consistently. Example: old has
+ * r2.id=A, r3.id=A|flag (r3 = r2 + delta), cur has r2.id=B, r3.id=C|flag
+ * (r3 derived from unrelated r4). Without the base check, idmap gets two
+ * independent entries A->B and A|flag->C|flag, missing that A->C conflicts
+ * with A->B. The base ID cross-check catches this.
+ */
+static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
+{
+	if (!old_id)
+		return true;
+
+	cur_id = cur_id ? cur_id : ++idmap->tmp_id_gen;
+
+	if (!check_ids(old_id, cur_id, idmap))
+		return false;
+	if (old_id & BPF_ADD_CONST) {
+		old_id &= ~BPF_ADD_CONST;
+		cur_id &= ~BPF_ADD_CONST;
+		if (!check_ids(old_id, cur_id, idmap))
+			return false;
+	}
+	return true;
+}
+
+static void __clean_func_state(struct bpf_verifier_env *env,
+			       struct bpf_func_state *st,
+			       u16 live_regs, int frame)
+{
+	int i, j;
+
+	for (i = 0; i < BPF_REG_FP; i++) {
+		/* liveness must not touch this register anymore */
+		if (!(live_regs & BIT(i)))
+			/* since the register is unused, clear its state
+			 * to make further comparison simpler
+			 */
+			bpf_mark_reg_not_init(env, &st->regs[i]);
+	}
+
+	/*
+	 * Clean dead 4-byte halves within each SPI independently.
+	 * half_spi 2*i   → lower half: slot_type[0..3] (closer to FP)
+	 * half_spi 2*i+1 → upper half: slot_type[4..7] (farther from FP)
+	 */
+	for (i = 0; i < st->allocated_stack / BPF_REG_SIZE; i++) {
+		bool lo_live = bpf_stack_slot_alive(env, frame, i * 2);
+		bool hi_live = bpf_stack_slot_alive(env, frame, i * 2 + 1);
+
+		if (!hi_live || !lo_live) {
+			int start = !lo_live ? 0 : BPF_REG_SIZE / 2;
+			int end = !hi_live ? BPF_REG_SIZE : BPF_REG_SIZE / 2;
+			u8 stype = st->stack[i].slot_type[7];
+
+			/*
+			 * Don't clear special slots.
+			 * destroy_if_dynptr_stack_slot() needs STACK_DYNPTR to
+			 * detect overwrites and invalidate associated data slices.
+			 * is_iter_reg_valid_uninit() and is_irq_flag_reg_valid_uninit()
+			 * check for their respective slot types to detect double-create.
+			 */
+			if (stype == STACK_DYNPTR || stype == STACK_ITER ||
+			    stype == STACK_IRQ_FLAG)
+				continue;
+
+			/*
+			 * Only destroy spilled_ptr when hi half is dead.
+			 * If hi half is still live with STACK_SPILL, the
+			 * spilled_ptr metadata is needed for correct state
+			 * comparison in stacksafe().
+			 * is_spilled_reg() is using slot_type[7], but
+			 * is_spilled_scalar_after() check either slot_type[0] or [4]
+			 */
+			if (!hi_live) {
+				struct bpf_reg_state *spill = &st->stack[i].spilled_ptr;
+
+				if (lo_live && stype == STACK_SPILL) {
+					u8 val = STACK_MISC;
+
+					/*
+					 * 8 byte spill of scalar 0 where half slot is dead
+					 * should become STACK_ZERO in lo 4 bytes.
+					 */
+					if (bpf_register_is_null(spill))
+						val = STACK_ZERO;
+					for (j = 0; j < 4; j++) {
+						u8 *t = &st->stack[i].slot_type[j];
+
+						if (*t == STACK_SPILL)
+							*t = val;
+					}
+				}
+				bpf_mark_reg_not_init(env, spill);
+			}
+			for (j = start; j < end; j++)
+				st->stack[i].slot_type[j] = STACK_POISON;
+		}
+	}
+}
+
+static int clean_verifier_state(struct bpf_verifier_env *env,
+				 struct bpf_verifier_state *st)
+{
+	int i, err;
+
+	err = bpf_live_stack_query_init(env, st);
+	if (err)
+		return err;
+	for (i = 0; i <= st->curframe; i++) {
+		u32 ip = bpf_frame_insn_idx(st, i);
+		u16 live_regs = env->insn_aux_data[ip].live_regs_before;
+
+		__clean_func_state(env, st->frame[i], live_regs, i);
+	}
+	return 0;
+}
+
+/* Find id in idset and increment its count, or add new entry */
+
+static bool regs_exact(const struct bpf_reg_state *rold,
+		       const struct bpf_reg_state *rcur,
+		       struct bpf_idmap *idmap)
+{
+	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
+	       check_ids(rold->id, rcur->id, idmap) &&
+	       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
+}
+
+enum exact_level {
+	NOT_EXACT,
+	EXACT,
+	RANGE_WITHIN
+};
+
+/* Returns true if (rold safe implies rcur safe) */
+static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
+		    struct bpf_reg_state *rcur, struct bpf_idmap *idmap,
+		    enum exact_level exact)
+{
+	if (exact == EXACT)
+		return regs_exact(rold, rcur, idmap);
+
+	if (rold->type == NOT_INIT)
+		/* explored state can't have used this */
+		return true;
+
+	/* Enforce that register types have to match exactly, including their
+	 * modifiers (like PTR_MAYBE_NULL, MEM_RDONLY, etc), as a general
+	 * rule.
+	 *
+	 * One can make a point that using a pointer register as unbounded
+	 * SCALAR would be technically acceptable, but this could lead to
+	 * pointer leaks because scalars are allowed to leak while pointers
+	 * are not. We could make this safe in special cases if root is
+	 * calling us, but it's probably not worth the hassle.
+	 *
+	 * Also, register types that are *not* MAYBE_NULL could technically be
+	 * safe to use as their MAYBE_NULL variants (e.g., PTR_TO_MAP_VALUE
+	 * is safe to be used as PTR_TO_MAP_VALUE_OR_NULL, provided both point
+	 * to the same map).
+	 * However, if the old MAYBE_NULL register then got NULL checked,
+	 * doing so could have affected others with the same id, and we can't
+	 * check for that because we lost the id when we converted to
+	 * a non-MAYBE_NULL variant.
+	 * So, as a general rule we don't allow mixing MAYBE_NULL and
+	 * non-MAYBE_NULL registers as well.
+	 */
+	if (rold->type != rcur->type)
+		return false;
+
+	switch (base_type(rold->type)) {
+	case SCALAR_VALUE:
+		if (env->explore_alu_limits) {
+			/* explore_alu_limits disables tnum_in() and range_within()
+			 * logic and requires everything to be strict
+			 */
+			return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
+			       check_scalar_ids(rold->id, rcur->id, idmap);
+		}
+		if (!rold->precise && exact == NOT_EXACT)
+			return true;
+		/*
+		 * Linked register tracking uses rold->id to detect relationships.
+		 * When rold->id == 0, the register is independent and any linking
+		 * in rcur only adds constraints. When rold->id != 0, we must verify
+		 * id mapping and (for BPF_ADD_CONST) offset consistency.
+		 *
+		 * +------------------+-----------+------------------+---------------+
+		 * |                  | rold->id  | rold + ADD_CONST | rold->id == 0 |
+		 * |------------------+-----------+------------------+---------------|
+		 * | rcur->id         | range,ids | false            | range         |
+		 * | rcur + ADD_CONST | false     | range,ids,off    | range         |
+		 * | rcur->id == 0    | range,ids | false            | range         |
+		 * +------------------+-----------+------------------+---------------+
+		 *
+		 * Why check_ids() for scalar registers?
+		 *
+		 * Consider the following BPF code:
+		 *   1: r6 = ... unbound scalar, ID=a ...
+		 *   2: r7 = ... unbound scalar, ID=b ...
+		 *   3: if (r6 > r7) goto +1
+		 *   4: r6 = r7
+		 *   5: if (r6 > X) goto ...
+		 *   6: ... memory operation using r7 ...
+		 *
+		 * First verification path is [1-6]:
+		 * - at (4) same bpf_reg_state::id (b) would be assigned to r6 and r7;
+		 * - at (5) r6 would be marked <= X, sync_linked_regs() would also mark
+		 *   r7 <= X, because r6 and r7 share same id.
+		 * Next verification path is [1-4, 6].
+		 *
+		 * Instruction (6) would be reached in two states:
+		 *   I.  r6{.id=b}, r7{.id=b} via path 1-6;
+		 *   II. r6{.id=a}, r7{.id=b} via path 1-4, 6.
+		 *
+		 * Use check_ids() to distinguish these states.
+		 * ---
+		 * Also verify that new value satisfies old value range knowledge.
+		 */
+
+		/*
+		 * ADD_CONST flags must match exactly: BPF_ADD_CONST32 and
+		 * BPF_ADD_CONST64 have different linking semantics in
+		 * sync_linked_regs() (alu32 zero-extends, alu64 does not),
+		 * so pruning across different flag types is unsafe.
+		 */
+		if (rold->id &&
+		    (rold->id & BPF_ADD_CONST) != (rcur->id & BPF_ADD_CONST))
+			return false;
+
+		/* Both have offset linkage: offsets must match */
+		if ((rold->id & BPF_ADD_CONST) && rold->delta != rcur->delta)
+			return false;
+
+		if (!check_scalar_ids(rold->id, rcur->id, idmap))
+			return false;
+
+		return range_within(rold, rcur) && tnum_in(rold->var_off, rcur->var_off);
+	case PTR_TO_MAP_KEY:
+	case PTR_TO_MAP_VALUE:
+	case PTR_TO_MEM:
+	case PTR_TO_BUF:
+	case PTR_TO_TP_BUFFER:
+		/* If the new min/max/var_off satisfy the old ones and
+		 * everything else matches, we are OK.
+		 */
+		return memcmp(rold, rcur, offsetof(struct bpf_reg_state, var_off)) == 0 &&
+		       range_within(rold, rcur) &&
+		       tnum_in(rold->var_off, rcur->var_off) &&
+		       check_ids(rold->id, rcur->id, idmap) &&
+		       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
+	case PTR_TO_PACKET_META:
+	case PTR_TO_PACKET:
+		/* We must have at least as much range as the old ptr
+		 * did, so that any accesses which were safe before are
+		 * still safe.  This is true even if old range < old off,
+		 * since someone could have accessed through (ptr - k), or
+		 * even done ptr -= k in a register, to get a safe access.
+		 */
+		if (rold->range < 0 || rcur->range < 0) {
+			/* special case for [BEYOND|AT]_PKT_END */
+			if (rold->range != rcur->range)
+				return false;
+		} else if (rold->range > rcur->range) {
+			return false;
+		}
+		/* id relations must be preserved */
+		if (!check_ids(rold->id, rcur->id, idmap))
+			return false;
+		/* new val must satisfy old val knowledge */
+		return range_within(rold, rcur) &&
+		       tnum_in(rold->var_off, rcur->var_off);
+	case PTR_TO_STACK:
+		/* two stack pointers are equal only if they're pointing to
+		 * the same stack frame, since fp-8 in foo != fp-8 in bar
+		 */
+		return regs_exact(rold, rcur, idmap) && rold->frameno == rcur->frameno;
+	case PTR_TO_ARENA:
+		return true;
+	case PTR_TO_INSN:
+		return memcmp(rold, rcur, offsetof(struct bpf_reg_state, var_off)) == 0 &&
+		       range_within(rold, rcur) && tnum_in(rold->var_off, rcur->var_off);
+	default:
+		return regs_exact(rold, rcur, idmap);
+	}
+}
+
+static struct bpf_reg_state unbound_reg;
+
+static __init int unbound_reg_init(void)
+{
+	bpf_mark_reg_unknown_imprecise(&unbound_reg);
+	return 0;
+}
+late_initcall(unbound_reg_init);
+
+static bool is_spilled_scalar_after(const struct bpf_stack_state *stack, int im)
+{
+	return stack->slot_type[im] == STACK_SPILL &&
+	       stack->spilled_ptr.type == SCALAR_VALUE;
+}
+
+static bool is_stack_misc_after(struct bpf_verifier_env *env,
+				struct bpf_stack_state *stack, int im)
+{
+	u32 i;
+
+	for (i = im; i < ARRAY_SIZE(stack->slot_type); ++i) {
+		if ((stack->slot_type[i] == STACK_MISC) ||
+		    ((stack->slot_type[i] == STACK_INVALID || stack->slot_type[i] == STACK_POISON) &&
+		     env->allow_uninit_stack))
+			continue;
+		return false;
+	}
+
+	return true;
+}
+
+static struct bpf_reg_state *scalar_reg_for_stack(struct bpf_verifier_env *env,
+						  struct bpf_stack_state *stack, int im)
+{
+	if (is_spilled_scalar_after(stack, im))
+		return &stack->spilled_ptr;
+
+	if (is_stack_misc_after(env, stack, im))
+		return &unbound_reg;
+
+	return NULL;
+}
+
+static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
+		      struct bpf_func_state *cur, struct bpf_idmap *idmap,
+		      enum exact_level exact)
+{
+	int i, spi;
+
+	/* walk slots of the explored stack and ignore any additional
+	 * slots in the current stack, since explored(safe) state
+	 * didn't use them
+	 */
+	for (i = 0; i < old->allocated_stack; i++) {
+		struct bpf_reg_state *old_reg, *cur_reg;
+		int im = i % BPF_REG_SIZE;
+
+		spi = i / BPF_REG_SIZE;
+
+		if (exact == EXACT) {
+			u8 old_type = old->stack[spi].slot_type[i % BPF_REG_SIZE];
+			u8 cur_type = i < cur->allocated_stack ?
+				      cur->stack[spi].slot_type[i % BPF_REG_SIZE] : STACK_INVALID;
+
+			/* STACK_INVALID and STACK_POISON are equivalent for pruning */
+			if (old_type == STACK_POISON)
+				old_type = STACK_INVALID;
+			if (cur_type == STACK_POISON)
+				cur_type = STACK_INVALID;
+			if (i >= cur->allocated_stack || old_type != cur_type)
+				return false;
+		}
+
+		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_INVALID ||
+		    old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_POISON)
+			continue;
+
+		if (env->allow_uninit_stack &&
+		    old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_MISC)
+			continue;
+
+		/* explored stack has more populated slots than current stack
+		 * and these slots were used
+		 */
+		if (i >= cur->allocated_stack)
+			return false;
+
+		/*
+		 * 64 and 32-bit scalar spills vs MISC/INVALID slots and vice versa.
+		 * Load from MISC/INVALID slots produces unbound scalar.
+		 * Construct a fake register for such stack and call
+		 * regsafe() to ensure scalar ids are compared.
+		 */
+		if (im == 0 || im == 4) {
+			old_reg = scalar_reg_for_stack(env, &old->stack[spi], im);
+			cur_reg = scalar_reg_for_stack(env, &cur->stack[spi], im);
+			if (old_reg && cur_reg) {
+				if (!regsafe(env, old_reg, cur_reg, idmap, exact))
+					return false;
+				i += (im == 0 ? BPF_REG_SIZE - 1 : 3);
+				continue;
+			}
+		}
+
+		/* if old state was safe with misc data in the stack
+		 * it will be safe with zero-initialized stack.
+		 * The opposite is not true
+		 */
+		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_MISC &&
+		    cur->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_ZERO)
+			continue;
+		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] !=
+		    cur->stack[spi].slot_type[i % BPF_REG_SIZE])
+			/* Ex: old explored (safe) state has STACK_SPILL in
+			 * this stack slot, but current has STACK_MISC ->
+			 * this verifier states are not equivalent,
+			 * return false to continue verification of this path
+			 */
+			return false;
+		if (i % BPF_REG_SIZE != BPF_REG_SIZE - 1)
+			continue;
+		/* Both old and cur are having same slot_type */
+		switch (old->stack[spi].slot_type[BPF_REG_SIZE - 1]) {
+		case STACK_SPILL:
+			/* when explored and current stack slot are both storing
+			 * spilled registers, check that stored pointers types
+			 * are the same as well.
+			 * Ex: explored safe path could have stored
+			 * (bpf_reg_state) {.type = PTR_TO_STACK, .off = -8}
+			 * but current path has stored:
+			 * (bpf_reg_state) {.type = PTR_TO_STACK, .off = -16}
+			 * such verifier states are not equivalent.
+			 * return false to continue verification of this path
+			 */
+			if (!regsafe(env, &old->stack[spi].spilled_ptr,
+				     &cur->stack[spi].spilled_ptr, idmap, exact))
+				return false;
+			break;
+		case STACK_DYNPTR:
+			old_reg = &old->stack[spi].spilled_ptr;
+			cur_reg = &cur->stack[spi].spilled_ptr;
+			if (old_reg->dynptr.type != cur_reg->dynptr.type ||
+			    old_reg->dynptr.first_slot != cur_reg->dynptr.first_slot ||
+			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
+				return false;
+			break;
+		case STACK_ITER:
+			old_reg = &old->stack[spi].spilled_ptr;
+			cur_reg = &cur->stack[spi].spilled_ptr;
+			/* iter.depth is not compared between states as it
+			 * doesn't matter for correctness and would otherwise
+			 * prevent convergence; we maintain it only to prevent
+			 * infinite loop check triggering, see
+			 * iter_active_depths_differ()
+			 */
+			if (old_reg->iter.btf != cur_reg->iter.btf ||
+			    old_reg->iter.btf_id != cur_reg->iter.btf_id ||
+			    old_reg->iter.state != cur_reg->iter.state ||
+			    /* ignore {old_reg,cur_reg}->iter.depth, see above */
+			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
+				return false;
+			break;
+		case STACK_IRQ_FLAG:
+			old_reg = &old->stack[spi].spilled_ptr;
+			cur_reg = &cur->stack[spi].spilled_ptr;
+			if (!check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap) ||
+			    old_reg->irq.kfunc_class != cur_reg->irq.kfunc_class)
+				return false;
+			break;
+		case STACK_MISC:
+		case STACK_ZERO:
+		case STACK_INVALID:
+		case STACK_POISON:
+			continue;
+		/* Ensure that new unhandled slot types return false by default */
+		default:
+			return false;
+		}
+	}
+	return true;
+}
+
+static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *cur,
+		    struct bpf_idmap *idmap)
+{
+	int i;
+
+	if (old->acquired_refs != cur->acquired_refs)
+		return false;
+
+	if (old->active_locks != cur->active_locks)
+		return false;
+
+	if (old->active_preempt_locks != cur->active_preempt_locks)
+		return false;
+
+	if (old->active_rcu_locks != cur->active_rcu_locks)
+		return false;
+
+	if (!check_ids(old->active_irq_id, cur->active_irq_id, idmap))
+		return false;
+
+	if (!check_ids(old->active_lock_id, cur->active_lock_id, idmap) ||
+	    old->active_lock_ptr != cur->active_lock_ptr)
+		return false;
+
+	for (i = 0; i < old->acquired_refs; i++) {
+		if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap) ||
+		    old->refs[i].type != cur->refs[i].type)
+			return false;
+		switch (old->refs[i].type) {
+		case REF_TYPE_PTR:
+		case REF_TYPE_IRQ:
+			break;
+		case REF_TYPE_LOCK:
+		case REF_TYPE_RES_LOCK:
+		case REF_TYPE_RES_LOCK_IRQ:
+			if (old->refs[i].ptr != cur->refs[i].ptr)
+				return false;
+			break;
+		default:
+			WARN_ONCE(1, "Unhandled enum type for reference state: %d\n", old->refs[i].type);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+/* compare two verifier states
+ *
+ * all states stored in state_list are known to be valid, since
+ * verifier reached 'bpf_exit' instruction through them
+ *
+ * this function is called when verifier exploring different branches of
+ * execution popped from the state stack. If it sees an old state that has
+ * more strict register state and more strict stack state then this execution
+ * branch doesn't need to be explored further, since verifier already
+ * concluded that more strict state leads to valid finish.
+ *
+ * Therefore two states are equivalent if register state is more conservative
+ * and explored stack state is more conservative than the current one.
+ * Example:
+ *       explored                   current
+ * (slot1=INV slot2=MISC) == (slot1=MISC slot2=MISC)
+ * (slot1=MISC slot2=MISC) != (slot1=INV slot2=MISC)
+ *
+ * In other words if current stack state (one being explored) has more
+ * valid slots than old one that already passed validation, it means
+ * the verifier can stop exploring and conclude that current state is valid too
+ *
+ * Similarly with registers. If explored state has register type as invalid
+ * whereas register type in current state is meaningful, it means that
+ * the current state will reach 'bpf_exit' instruction safely
+ */
+static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_state *old,
+			      struct bpf_func_state *cur, u32 insn_idx, enum exact_level exact)
+{
+	u16 live_regs = env->insn_aux_data[insn_idx].live_regs_before;
+	u16 i;
+
+	if (old->callback_depth > cur->callback_depth)
+		return false;
+
+	for (i = 0; i < MAX_BPF_REG; i++)
+		if (((1 << i) & live_regs) &&
+		    !regsafe(env, &old->regs[i], &cur->regs[i],
+			     &env->idmap_scratch, exact))
+			return false;
+
+	if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
+		return false;
+
+	return true;
+}
+
+static void reset_idmap_scratch(struct bpf_verifier_env *env)
+{
+	struct bpf_idmap *idmap = &env->idmap_scratch;
+
+	idmap->tmp_id_gen = env->id_gen;
+	idmap->cnt = 0;
+}
+
+static bool states_equal(struct bpf_verifier_env *env,
+			 struct bpf_verifier_state *old,
+			 struct bpf_verifier_state *cur,
+			 enum exact_level exact)
+{
+	u32 insn_idx;
+	int i;
+
+	if (old->curframe != cur->curframe)
+		return false;
+
+	reset_idmap_scratch(env);
+
+	/* Verification state from speculative execution simulation
+	 * must never prune a non-speculative execution one.
+	 */
+	if (old->speculative && !cur->speculative)
+		return false;
+
+	if (old->in_sleepable != cur->in_sleepable)
+		return false;
+
+	if (!refsafe(old, cur, &env->idmap_scratch))
+		return false;
+
+	/* for states to be equal callsites have to be the same
+	 * and all frame states need to be equivalent
+	 */
+	for (i = 0; i <= old->curframe; i++) {
+		insn_idx = bpf_frame_insn_idx(old, i);
+		if (old->frame[i]->callsite != cur->frame[i]->callsite)
+			return false;
+		if (!func_states_equal(env, old->frame[i], cur->frame[i], insn_idx, exact))
+			return false;
+	}
+	return true;
+}
+
+/* find precise scalars in the previous equivalent state and
+ * propagate them into the current state
+ */
+static int propagate_precision(struct bpf_verifier_env *env,
+			       const struct bpf_verifier_state *old,
+			       struct bpf_verifier_state *cur,
+			       bool *changed)
+{
+	struct bpf_reg_state *state_reg;
+	struct bpf_func_state *state;
+	int i, err = 0, fr;
+	bool first;
+
+	for (fr = old->curframe; fr >= 0; fr--) {
+		state = old->frame[fr];
+		state_reg = state->regs;
+		first = true;
+		for (i = 0; i < BPF_REG_FP; i++, state_reg++) {
+			if (state_reg->type != SCALAR_VALUE ||
+			    !state_reg->precise)
+				continue;
+			if (env->log.level & BPF_LOG_LEVEL2) {
+				if (first)
+					verbose(env, "frame %d: propagating r%d", fr, i);
+				else
+					verbose(env, ",r%d", i);
+			}
+			bpf_bt_set_frame_reg(&env->bt, fr, i);
+			first = false;
+		}
+
+		for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
+			if (!bpf_is_spilled_reg(&state->stack[i]))
+				continue;
+			state_reg = &state->stack[i].spilled_ptr;
+			if (state_reg->type != SCALAR_VALUE ||
+			    !state_reg->precise)
+				continue;
+			if (env->log.level & BPF_LOG_LEVEL2) {
+				if (first)
+					verbose(env, "frame %d: propagating fp%d",
+						fr, (-i - 1) * BPF_REG_SIZE);
+				else
+					verbose(env, ",fp%d", (-i - 1) * BPF_REG_SIZE);
+			}
+			bpf_bt_set_frame_slot(&env->bt, fr, i);
+			first = false;
+		}
+		if (!first && (env->log.level & BPF_LOG_LEVEL2))
+			verbose(env, "\n");
+	}
+
+	err = bpf_mark_chain_precision(env, cur, -1, changed);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+#define MAX_BACKEDGE_ITERS 64
+
+/* Propagate read and precision marks from visit->backedges[*].state->equal_state
+ * to corresponding parent states of visit->backedges[*].state until fixed point is reached,
+ * then free visit->backedges.
+ * After execution of this function incomplete_read_marks() will return false
+ * for all states corresponding to @visit->callchain.
+ */
+static int propagate_backedges(struct bpf_verifier_env *env, struct bpf_scc_visit *visit)
+{
+	struct bpf_scc_backedge *backedge;
+	struct bpf_verifier_state *st;
+	bool changed;
+	int i, err;
+
+	i = 0;
+	do {
+		if (i++ > MAX_BACKEDGE_ITERS) {
+			if (env->log.level & BPF_LOG_LEVEL2)
+				verbose(env, "%s: too many iterations\n", __func__);
+			for (backedge = visit->backedges; backedge; backedge = backedge->next)
+				bpf_mark_all_scalars_precise(env, &backedge->state);
+			break;
+		}
+		changed = false;
+		for (backedge = visit->backedges; backedge; backedge = backedge->next) {
+			st = &backedge->state;
+			err = propagate_precision(env, st->equal_state, st, &changed);
+			if (err)
+				return err;
+		}
+	} while (changed);
+
+	bpf_free_backedges(visit);
+	return 0;
+}
+
+static bool states_maybe_looping(struct bpf_verifier_state *old,
+				 struct bpf_verifier_state *cur)
+{
+	struct bpf_func_state *fold, *fcur;
+	int i, fr = cur->curframe;
+
+	if (old->curframe != fr)
+		return false;
+
+	fold = old->frame[fr];
+	fcur = cur->frame[fr];
+	for (i = 0; i < MAX_BPF_REG; i++)
+		if (memcmp(&fold->regs[i], &fcur->regs[i],
+			   offsetof(struct bpf_reg_state, frameno)))
+			return false;
+	return true;
+}
+
+/* is_state_visited() handles iter_next() (see process_iter_next_call() for
+ * terminology) calls specially: as opposed to bounded BPF loops, it *expects*
+ * states to match, which otherwise would look like an infinite loop. So while
+ * iter_next() calls are taken care of, we still need to be careful and
+ * prevent erroneous and too eager declaration of "infinite loop", when
+ * iterators are involved.
+ *
+ * Here's a situation in pseudo-BPF assembly form:
+ *
+ *   0: again:                          ; set up iter_next() call args
+ *   1:   r1 = &it                      ; <CHECKPOINT HERE>
+ *   2:   call bpf_iter_num_next        ; this is iter_next() call
+ *   3:   if r0 == 0 goto done
+ *   4:   ... something useful here ...
+ *   5:   goto again                    ; another iteration
+ *   6: done:
+ *   7:   r1 = &it
+ *   8:   call bpf_iter_num_destroy     ; clean up iter state
+ *   9:   exit
+ *
+ * This is a typical loop. Let's assume that we have a prune point at 1:,
+ * before we get to `call bpf_iter_num_next` (e.g., because of that `goto
+ * again`, assuming other heuristics don't get in a way).
+ *
+ * When we first time come to 1:, let's say we have some state X. We proceed
+ * to 2:, fork states, enqueue ACTIVE, validate NULL case successfully, exit.
+ * Now we come back to validate that forked ACTIVE state. We proceed through
+ * 3-5, come to goto, jump to 1:. Let's assume our state didn't change, so we
+ * are converging. But the problem is that we don't know that yet, as this
+ * convergence has to happen at iter_next() call site only. So if nothing is
+ * done, at 1: verifier will use bounded loop logic and declare infinite
+ * looping (and would be *technically* correct, if not for iterator's
+ * "eventual sticky NULL" contract, see process_iter_next_call()). But we
+ * don't want that. So what we do in process_iter_next_call() when we go on
+ * another ACTIVE iteration, we bump slot->iter.depth, to mark that it's
+ * a different iteration. So when we suspect an infinite loop, we additionally
+ * check if any of the *ACTIVE* iterator states depths differ. If yes, we
+ * pretend we are not looping and wait for next iter_next() call.
+ *
+ * This only applies to ACTIVE state. In DRAINED state we don't expect to
+ * loop, because that would actually mean infinite loop, as DRAINED state is
+ * "sticky", and so we'll keep returning into the same instruction with the
+ * same state (at least in one of possible code paths).
+ *
+ * This approach allows to keep infinite loop heuristic even in the face of
+ * active iterator. E.g., C snippet below is and will be detected as
+ * infinitely looping:
+ *
+ *   struct bpf_iter_num it;
+ *   int *p, x;
+ *
+ *   bpf_iter_num_new(&it, 0, 10);
+ *   while ((p = bpf_iter_num_next(&t))) {
+ *       x = p;
+ *       while (x--) {} // <<-- infinite loop here
+ *   }
+ *
+ */
+static bool iter_active_depths_differ(struct bpf_verifier_state *old, struct bpf_verifier_state *cur)
+{
+	struct bpf_reg_state *slot, *cur_slot;
+	struct bpf_func_state *state;
+	int i, fr;
+
+	for (fr = old->curframe; fr >= 0; fr--) {
+		state = old->frame[fr];
+		for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
+			if (state->stack[i].slot_type[0] != STACK_ITER)
+				continue;
+
+			slot = &state->stack[i].spilled_ptr;
+			if (slot->iter.state != BPF_ITER_STATE_ACTIVE)
+				continue;
+
+			cur_slot = &cur->frame[fr]->stack[i].spilled_ptr;
+			if (cur_slot->iter.depth != slot->iter.depth)
+				return true;
+		}
+	}
+	return false;
+}
+
+static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	struct bpf_func_state *func;
+	struct bpf_reg_state *reg;
+	int i, j;
+
+	for (i = 0; i <= st->curframe; i++) {
+		func = st->frame[i];
+		for (j = 0; j < BPF_REG_FP; j++) {
+			reg = &func->regs[j];
+			if (reg->type != SCALAR_VALUE)
+				continue;
+			reg->precise = false;
+		}
+		for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
+			if (!bpf_is_spilled_reg(&func->stack[j]))
+				continue;
+			reg = &func->stack[j].spilled_ptr;
+			if (reg->type != SCALAR_VALUE)
+				continue;
+			reg->precise = false;
+		}
+	}
+}
+
+int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
+{
+	struct bpf_verifier_state_list *new_sl;
+	struct bpf_verifier_state_list *sl;
+	struct bpf_verifier_state *cur = env->cur_state, *new;
+	bool force_new_state, add_new_state, loop;
+	int n, err, states_cnt = 0;
+	struct list_head *pos, *tmp, *head;
+
+	force_new_state = env->test_state_freq || bpf_is_force_checkpoint(env, insn_idx) ||
+			  /* Avoid accumulating infinitely long jmp history */
+			  cur->jmp_history_cnt > 40;
+
+	/* bpf progs typically have pruning point every 4 instructions
+	 * http://vger.kernel.org/bpfconf2019.html#session-1
+	 * Do not add new state for future pruning if the verifier hasn't seen
+	 * at least 2 jumps and at least 8 instructions.
+	 * This heuristics helps decrease 'total_states' and 'peak_states' metric.
+	 * In tests that amounts to up to 50% reduction into total verifier
+	 * memory consumption and 20% verifier time speedup.
+	 */
+	add_new_state = force_new_state;
+	if (env->jmps_processed - env->prev_jmps_processed >= 2 &&
+	    env->insn_processed - env->prev_insn_processed >= 8)
+		add_new_state = true;
+
+	/* keep cleaning the current state as registers/stack become dead */
+	err = clean_verifier_state(env, cur);
+	if (err)
+		return err;
+
+	loop = false;
+	head = bpf_explored_state(env, insn_idx);
+	list_for_each_safe(pos, tmp, head) {
+		sl = container_of(pos, struct bpf_verifier_state_list, node);
+		states_cnt++;
+		if (sl->state.insn_idx != insn_idx)
+			continue;
+
+		if (sl->state.branches) {
+			struct bpf_func_state *frame = sl->state.frame[sl->state.curframe];
+
+			if (frame->in_async_callback_fn &&
+			    frame->async_entry_cnt != cur->frame[cur->curframe]->async_entry_cnt) {
+				/* Different async_entry_cnt means that the verifier is
+				 * processing another entry into async callback.
+				 * Seeing the same state is not an indication of infinite
+				 * loop or infinite recursion.
+				 * But finding the same state doesn't mean that it's safe
+				 * to stop processing the current state. The previous state
+				 * hasn't yet reached bpf_exit, since state.branches > 0.
+				 * Checking in_async_callback_fn alone is not enough either.
+				 * Since the verifier still needs to catch infinite loops
+				 * inside async callbacks.
+				 */
+				goto skip_inf_loop_check;
+			}
+			/* BPF open-coded iterators loop detection is special.
+			 * states_maybe_looping() logic is too simplistic in detecting
+			 * states that *might* be equivalent, because it doesn't know
+			 * about ID remapping, so don't even perform it.
+			 * See process_iter_next_call() and iter_active_depths_differ()
+			 * for overview of the logic. When current and one of parent
+			 * states are detected as equivalent, it's a good thing: we prove
+			 * convergence and can stop simulating further iterations.
+			 * It's safe to assume that iterator loop will finish, taking into
+			 * account iter_next() contract of eventually returning
+			 * sticky NULL result.
+			 *
+			 * Note, that states have to be compared exactly in this case because
+			 * read and precision marks might not be finalized inside the loop.
+			 * E.g. as in the program below:
+			 *
+			 *     1. r7 = -16
+			 *     2. r6 = bpf_get_prandom_u32()
+			 *     3. while (bpf_iter_num_next(&fp[-8])) {
+			 *     4.   if (r6 != 42) {
+			 *     5.     r7 = -32
+			 *     6.     r6 = bpf_get_prandom_u32()
+			 *     7.     continue
+			 *     8.   }
+			 *     9.   r0 = r10
+			 *    10.   r0 += r7
+			 *    11.   r8 = *(u64 *)(r0 + 0)
+			 *    12.   r6 = bpf_get_prandom_u32()
+			 *    13. }
+			 *
+			 * Here verifier would first visit path 1-3, create a checkpoint at 3
+			 * with r7=-16, continue to 4-7,3. Existing checkpoint at 3 does
+			 * not have read or precision mark for r7 yet, thus inexact states
+			 * comparison would discard current state with r7=-32
+			 * => unsafe memory access at 11 would not be caught.
+			 */
+			if (is_iter_next_insn(env, insn_idx)) {
+				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
+					struct bpf_func_state *cur_frame;
+					struct bpf_reg_state *iter_state, *iter_reg;
+					int spi;
+
+					cur_frame = cur->frame[cur->curframe];
+					/* btf_check_iter_kfuncs() enforces that
+					 * iter state pointer is always the first arg
+					 */
+					iter_reg = &cur_frame->regs[BPF_REG_1];
+					/* current state is valid due to states_equal(),
+					 * so we can assume valid iter and reg state,
+					 * no need for extra (re-)validations
+					 */
+					spi = bpf_get_spi(iter_reg->var_off.value);
+					iter_state = &bpf_func(env, iter_reg)->stack[spi].spilled_ptr;
+					if (iter_state->iter.state == BPF_ITER_STATE_ACTIVE) {
+						loop = true;
+						goto hit;
+					}
+				}
+				goto skip_inf_loop_check;
+			}
+			if (is_may_goto_insn_at(env, insn_idx)) {
+				if (sl->state.may_goto_depth != cur->may_goto_depth &&
+				    states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
+					loop = true;
+					goto hit;
+				}
+			}
+			if (bpf_calls_callback(env, insn_idx)) {
+				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
+					loop = true;
+					goto hit;
+				}
+				goto skip_inf_loop_check;
+			}
+			/* attempt to detect infinite loop to avoid unnecessary doomed work */
+			if (states_maybe_looping(&sl->state, cur) &&
+			    states_equal(env, &sl->state, cur, EXACT) &&
+			    !iter_active_depths_differ(&sl->state, cur) &&
+			    sl->state.may_goto_depth == cur->may_goto_depth &&
+			    sl->state.callback_unroll_depth == cur->callback_unroll_depth) {
+				verbose_linfo(env, insn_idx, "; ");
+				verbose(env, "infinite loop detected at insn %d\n", insn_idx);
+				verbose(env, "cur state:");
+				print_verifier_state(env, cur, cur->curframe, true);
+				verbose(env, "old state:");
+				print_verifier_state(env, &sl->state, cur->curframe, true);
+				return -EINVAL;
+			}
+			/* if the verifier is processing a loop, avoid adding new state
+			 * too often, since different loop iterations have distinct
+			 * states and may not help future pruning.
+			 * This threshold shouldn't be too low to make sure that
+			 * a loop with large bound will be rejected quickly.
+			 * The most abusive loop will be:
+			 * r1 += 1
+			 * if r1 < 1000000 goto pc-2
+			 * 1M insn_procssed limit / 100 == 10k peak states.
+			 * This threshold shouldn't be too high either, since states
+			 * at the end of the loop are likely to be useful in pruning.
+			 */
+skip_inf_loop_check:
+			if (!force_new_state &&
+			    env->jmps_processed - env->prev_jmps_processed < 20 &&
+			    env->insn_processed - env->prev_insn_processed < 100)
+				add_new_state = false;
+			goto miss;
+		}
+		/* See comments for mark_all_regs_read_and_precise() */
+		loop = incomplete_read_marks(env, &sl->state);
+		if (states_equal(env, &sl->state, cur, loop ? RANGE_WITHIN : NOT_EXACT)) {
+hit:
+			sl->hit_cnt++;
+
+			/* if previous state reached the exit with precision and
+			 * current state is equivalent to it (except precision marks)
+			 * the precision needs to be propagated back in
+			 * the current state.
+			 */
+			err = 0;
+			if (bpf_is_jmp_point(env, env->insn_idx))
+				err = bpf_push_jmp_history(env, cur, 0, 0);
+			err = err ? : propagate_precision(env, &sl->state, cur, NULL);
+			if (err)
+				return err;
+			/* When processing iterator based loops above propagate_liveness and
+			 * propagate_precision calls are not sufficient to transfer all relevant
+			 * read and precision marks. E.g. consider the following case:
+			 *
+			 *  .-> A --.  Assume the states are visited in the order A, B, C.
+			 *  |   |   |  Assume that state B reaches a state equivalent to state A.
+			 *  |   v   v  At this point, state C is not processed yet, so state A
+			 *  '-- B   C  has not received any read or precision marks from C.
+			 *             Thus, marks propagated from A to B are incomplete.
+			 *
+			 * The verifier mitigates this by performing the following steps:
+			 *
+			 * - Prior to the main verification pass, strongly connected components
+			 *   (SCCs) are computed over the program's control flow graph,
+			 *   intraprocedurally.
+			 *
+			 * - During the main verification pass, `maybe_enter_scc()` checks
+			 *   whether the current verifier state is entering an SCC. If so, an
+			 *   instance of a `bpf_scc_visit` object is created, and the state
+			 *   entering the SCC is recorded as the entry state.
+			 *
+			 * - This instance is associated not with the SCC itself, but with a
+			 *   `bpf_scc_callchain`: a tuple consisting of the call sites leading to
+			 *   the SCC and the SCC id. See `compute_scc_callchain()`.
+			 *
+			 * - When a verification path encounters a `states_equal(...,
+			 *   RANGE_WITHIN)` condition, there exists a call chain describing the
+			 *   current state and a corresponding `bpf_scc_visit` instance. A copy
+			 *   of the current state is created and added to
+			 *   `bpf_scc_visit->backedges`.
+			 *
+			 * - When a verification path terminates, `maybe_exit_scc()` is called
+			 *   from `bpf_update_branch_counts()`. For states with `branches == 0`, it
+			 *   checks whether the state is the entry state of any `bpf_scc_visit`
+			 *   instance. If it is, this indicates that all paths originating from
+			 *   this SCC visit have been explored. `propagate_backedges()` is then
+			 *   called, which propagates read and precision marks through the
+			 *   backedges until a fixed point is reached.
+			 *   (In the earlier example, this would propagate marks from A to B,
+			 *    from C to A, and then again from A to B.)
+			 *
+			 * A note on callchains
+			 * --------------------
+			 *
+			 * Consider the following example:
+			 *
+			 *     void foo() { loop { ... SCC#1 ... } }
+			 *     void main() {
+			 *       A: foo();
+			 *       B: ...
+			 *       C: foo();
+			 *     }
+			 *
+			 * Here, there are two distinct callchains leading to SCC#1:
+			 * - (A, SCC#1)
+			 * - (C, SCC#1)
+			 *
+			 * Each callchain identifies a separate `bpf_scc_visit` instance that
+			 * accumulates backedge states. The `propagate_{liveness,precision}()`
+			 * functions traverse the parent state of each backedge state, which
+			 * means these parent states must remain valid (i.e., not freed) while
+			 * the corresponding `bpf_scc_visit` instance exists.
+			 *
+			 * Associating `bpf_scc_visit` instances directly with SCCs instead of
+			 * callchains would break this invariant:
+			 * - States explored during `C: foo()` would contribute backedges to
+			 *   SCC#1, but SCC#1 would only be exited once the exploration of
+			 *   `A: foo()` completes.
+			 * - By that time, the states explored between `A: foo()` and `C: foo()`
+			 *   (i.e., `B: ...`) may have already been freed, causing the parent
+			 *   links for states from `C: foo()` to become invalid.
+			 */
+			if (loop) {
+				struct bpf_scc_backedge *backedge;
+
+				backedge = kzalloc_obj(*backedge,
+						       GFP_KERNEL_ACCOUNT);
+				if (!backedge)
+					return -ENOMEM;
+				err = bpf_copy_verifier_state(&backedge->state, cur);
+				backedge->state.equal_state = &sl->state;
+				backedge->state.insn_idx = insn_idx;
+				err = err ?: add_scc_backedge(env, &sl->state, backedge);
+				if (err) {
+					bpf_free_verifier_state(&backedge->state, false);
+					kfree(backedge);
+					return err;
+				}
+			}
+			return 1;
+		}
+miss:
+		/* when new state is not going to be added do not increase miss count.
+		 * Otherwise several loop iterations will remove the state
+		 * recorded earlier. The goal of these heuristics is to have
+		 * states from some iterations of the loop (some in the beginning
+		 * and some at the end) to help pruning.
+		 */
+		if (add_new_state)
+			sl->miss_cnt++;
+		/* heuristic to determine whether this state is beneficial
+		 * to keep checking from state equivalence point of view.
+		 * Higher numbers increase max_states_per_insn and verification time,
+		 * but do not meaningfully decrease insn_processed.
+		 * 'n' controls how many times state could miss before eviction.
+		 * Use bigger 'n' for checkpoints because evicting checkpoint states
+		 * too early would hinder iterator convergence.
+		 */
+		n = bpf_is_force_checkpoint(env, insn_idx) && sl->state.branches > 0 ? 64 : 3;
+		if (sl->miss_cnt > sl->hit_cnt * n + n) {
+			/* the state is unlikely to be useful. Remove it to
+			 * speed up verification
+			 */
+			sl->in_free_list = true;
+			list_del(&sl->node);
+			list_add(&sl->node, &env->free_list);
+			env->free_list_size++;
+			env->explored_states_size--;
+			maybe_free_verifier_state(env, sl);
+		}
+	}
+
+	if (env->max_states_per_insn < states_cnt)
+		env->max_states_per_insn = states_cnt;
+
+	if (!env->bpf_capable && states_cnt > BPF_COMPLEXITY_LIMIT_STATES)
+		return 0;
+
+	if (!add_new_state)
+		return 0;
+
+	/* There were no equivalent states, remember the current one.
+	 * Technically the current state is not proven to be safe yet,
+	 * but it will either reach outer most bpf_exit (which means it's safe)
+	 * or it will be rejected. When there are no loops the verifier won't be
+	 * seeing this tuple (frame[0].callsite, frame[1].callsite, .. insn_idx)
+	 * again on the way to bpf_exit.
+	 * When looping the sl->state.branches will be > 0 and this state
+	 * will not be considered for equivalence until branches == 0.
+	 */
+	new_sl = kzalloc_obj(struct bpf_verifier_state_list, GFP_KERNEL_ACCOUNT);
+	if (!new_sl)
+		return -ENOMEM;
+	env->total_states++;
+	env->explored_states_size++;
+	update_peak_states(env);
+	env->prev_jmps_processed = env->jmps_processed;
+	env->prev_insn_processed = env->insn_processed;
+
+	/* forget precise markings we inherited, see __mark_chain_precision */
+	if (env->bpf_capable)
+		mark_all_scalars_imprecise(env, cur);
+
+	bpf_clear_singular_ids(env, cur);
+
+	/* add new state to the head of linked list */
+	new = &new_sl->state;
+	err = bpf_copy_verifier_state(new, cur);
+	if (err) {
+		bpf_free_verifier_state(new, false);
+		kfree(new_sl);
+		return err;
+	}
+	new->insn_idx = insn_idx;
+	verifier_bug_if(new->branches != 1, env,
+			"%s:branches_to_explore=%d insn %d",
+			__func__, new->branches, insn_idx);
+	err = maybe_enter_scc(env, new);
+	if (err) {
+		bpf_free_verifier_state(new, false);
+		kfree(new_sl);
+		return err;
+	}
+
+	cur->parent = new;
+	cur->first_insn_idx = insn_idx;
+	cur->dfs_depth = new->dfs_depth + 1;
+	bpf_clear_jmp_history(cur);
+	list_add(&new_sl->node, head);
+	return 0;
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 00fcd7f9c06b..d812448f2b24 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -498,11 +498,6 @@ bool bpf_is_may_goto_insn(struct bpf_insn *insn)
 	return insn->code == (BPF_JMP | BPF_JCOND) && insn->src_reg == BPF_MAY_GOTO;
 }
 
-static bool is_may_goto_insn_at(struct bpf_verifier_env *env, int insn_idx)
-{
-	return bpf_is_may_goto_insn(&env->prog->insnsi[insn_idx]);
-}
-
 static bool helper_multiple_ref_obj_use(enum bpf_func_id func_id,
 					const struct bpf_map *map)
 {
@@ -532,18 +527,6 @@ static bool is_atomic_fetch_insn(const struct bpf_insn *insn)
 	       (insn->imm & BPF_FETCH);
 }
 
-static int __get_spi(s32 off)
-{
-	return (-off - 1) / BPF_REG_SIZE;
-}
-
-static struct bpf_func_state *func(struct bpf_verifier_env *env,
-				   const struct bpf_reg_state *reg)
-{
-	struct bpf_verifier_state *cur = env->cur_state;
-
-	return cur->frame[reg->frameno];
-}
 
 static bool is_spi_bounds_valid(struct bpf_func_state *state, int spi, int nr_slots)
 {
@@ -575,13 +558,13 @@ static int stack_slot_obj_get_spi(struct bpf_verifier_env *env, struct bpf_reg_s
 		return -EINVAL;
 	}
 
-	spi = __get_spi(off);
+	spi = bpf_get_spi(off);
 	if (spi + 1 < nr_slots) {
 		verbose(env, "cannot pass in %s at an offset=%d\n", obj_kind, off);
 		return -EINVAL;
 	}
 
-	if (!is_spi_bounds_valid(func(env, reg), spi, nr_slots))
+	if (!is_spi_bounds_valid(bpf_func(env, reg), spi, nr_slots))
 		return -ERANGE;
 	return spi;
 }
@@ -650,8 +633,6 @@ static void __mark_dynptr_reg(struct bpf_reg_state *reg,
 			      enum bpf_dynptr_type type,
 			      bool first_slot, int dynptr_id);
 
-static void __mark_reg_not_init(const struct bpf_verifier_env *env,
-				struct bpf_reg_state *reg);
 
 static void mark_dynptr_stack_regs(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *sreg1,
@@ -677,7 +658,7 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 				   enum bpf_arg_type arg_type, int insn_idx, int clone_ref_obj_id)
 {
-	struct bpf_func_state *state = func(env, reg);
+	struct bpf_func_state *state = bpf_func(env, reg);
 	enum bpf_dynptr_type type;
 	int spi, i, err;
 
@@ -741,13 +722,13 @@ static void invalidate_dynptr(struct bpf_verifier_env *env, struct bpf_func_stat
 		state->stack[spi - 1].slot_type[i] = STACK_INVALID;
 	}
 
-	__mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
-	__mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
+	bpf_mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
+	bpf_mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
 }
 
 static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
-	struct bpf_func_state *state = func(env, reg);
+	struct bpf_func_state *state = bpf_func(env, reg);
 	int spi, ref_obj_id, i;
 
 	/*
@@ -806,7 +787,7 @@ static void __mark_reg_unknown(const struct bpf_verifier_env *env,
 static void mark_reg_invalid(const struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	if (!env->allow_ptr_leaks)
-		__mark_reg_not_init(env, reg);
+		bpf_mark_reg_not_init(env, reg);
 	else
 		__mark_reg_unknown(env, reg);
 }
@@ -876,8 +857,8 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 	/* Do not release reference state, we are destroying dynptr on stack,
 	 * not using some helper to release it. Just reset register.
 	 */
-	__mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
-	__mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
+	bpf_mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
+	bpf_mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
 
 	return 0;
 }
@@ -912,7 +893,7 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
 
 static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
-	struct bpf_func_state *state = func(env, reg);
+	struct bpf_func_state *state = bpf_func(env, reg);
 	int i, spi;
 
 	/* This already represents first slot of initialized bpf_dynptr.
@@ -942,7 +923,7 @@ static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_re
 static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 				    enum bpf_arg_type arg_type)
 {
-	struct bpf_func_state *state = func(env, reg);
+	struct bpf_func_state *state = bpf_func(env, reg);
 	enum bpf_dynptr_type dynptr_type;
 	int spi;
 
@@ -972,7 +953,7 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
 				 struct bpf_reg_state *reg, int insn_idx,
 				 struct btf *btf, u32 btf_id, int nr_slots)
 {
-	struct bpf_func_state *state = func(env, reg);
+	struct bpf_func_state *state = bpf_func(env, reg);
 	int spi, i, j, id;
 
 	spi = iter_get_spi(env, reg, nr_slots);
@@ -1013,7 +994,7 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
 static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg, int nr_slots)
 {
-	struct bpf_func_state *state = func(env, reg);
+	struct bpf_func_state *state = bpf_func(env, reg);
 	int spi, i, j;
 
 	spi = iter_get_spi(env, reg, nr_slots);
@@ -1027,7 +1008,7 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 		if (i == 0)
 			WARN_ON_ONCE(release_reference(env, st->ref_obj_id));
 
-		__mark_reg_not_init(env, st);
+		bpf_mark_reg_not_init(env, st);
 
 		for (j = 0; j < BPF_REG_SIZE; j++)
 			slot->slot_type[j] = STACK_INVALID;
@@ -1041,7 +1022,7 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 static bool is_iter_reg_valid_uninit(struct bpf_verifier_env *env,
 				     struct bpf_reg_state *reg, int nr_slots)
 {
-	struct bpf_func_state *state = func(env, reg);
+	struct bpf_func_state *state = bpf_func(env, reg);
 	int spi, i, j;
 
 	/* For -ERANGE (i.e. spi not falling into allocated stack slots), we
@@ -1068,7 +1049,7 @@ static bool is_iter_reg_valid_uninit(struct bpf_verifier_env *env,
 static int is_iter_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 				   struct btf *btf, u32 btf_id, int nr_slots)
 {
-	struct bpf_func_state *state = func(env, reg);
+	struct bpf_func_state *state = bpf_func(env, reg);
 	int spi, i, j;
 
 	spi = iter_get_spi(env, reg, nr_slots);
@@ -1105,7 +1086,7 @@ static int mark_stack_slot_irq_flag(struct bpf_verifier_env *env,
 				     struct bpf_reg_state *reg, int insn_idx,
 				     int kfunc_class)
 {
-	struct bpf_func_state *state = func(env, reg);
+	struct bpf_func_state *state = bpf_func(env, reg);
 	struct bpf_stack_state *slot;
 	struct bpf_reg_state *st;
 	int spi, i, id;
@@ -1136,7 +1117,7 @@ static int mark_stack_slot_irq_flag(struct bpf_verifier_env *env,
 static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 				      int kfunc_class)
 {
-	struct bpf_func_state *state = func(env, reg);
+	struct bpf_func_state *state = bpf_func(env, reg);
 	struct bpf_stack_state *slot;
 	struct bpf_reg_state *st;
 	int spi, i, err;
@@ -1174,7 +1155,7 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 		return err;
 	}
 
-	__mark_reg_not_init(env, st);
+	bpf_mark_reg_not_init(env, st);
 
 	for (i = 0; i < BPF_REG_SIZE; i++)
 		slot->slot_type[i] = STACK_INVALID;
@@ -1185,7 +1166,7 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 
 static bool is_irq_flag_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
-	struct bpf_func_state *state = func(env, reg);
+	struct bpf_func_state *state = bpf_func(env, reg);
 	struct bpf_stack_state *slot;
 	int spi, i;
 
@@ -1209,7 +1190,7 @@ static bool is_irq_flag_reg_valid_uninit(struct bpf_verifier_env *env, struct bp
 
 static int is_irq_flag_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
-	struct bpf_func_state *state = func(env, reg);
+	struct bpf_func_state *state = bpf_func(env, reg);
 	struct bpf_stack_state *slot;
 	struct bpf_reg_state *st;
 	int spi, i;
@@ -1260,23 +1241,12 @@ static bool is_stack_slot_special(const struct bpf_stack_state *stack)
 /* The reg state of a pointer or a bounded scalar was saved when
  * it was spilled to the stack.
  */
-static bool is_spilled_reg(const struct bpf_stack_state *stack)
-{
-	return stack->slot_type[BPF_REG_SIZE - 1] == STACK_SPILL;
-}
-
 static bool is_spilled_scalar_reg(const struct bpf_stack_state *stack)
 {
 	return stack->slot_type[BPF_REG_SIZE - 1] == STACK_SPILL &&
 	       stack->spilled_ptr.type == SCALAR_VALUE;
 }
 
-static bool is_spilled_scalar_after(const struct bpf_stack_state *stack, int im)
-{
-	return stack->slot_type[im] == STACK_SPILL &&
-	       stack->spilled_ptr.type == SCALAR_VALUE;
-}
-
 /*
  * Mark stack slot as STACK_MISC, unless it is already:
  * - STACK_INVALID, in which case they are equivalent.
@@ -1588,14 +1558,6 @@ static struct bpf_reference_state *find_lock_state(struct bpf_verifier_state *st
 	return NULL;
 }
 
-static void update_peak_states(struct bpf_verifier_env *env)
-{
-	u32 cur_states;
-
-	cur_states = env->explored_states_size + env->free_list_size + env->num_backedges;
-	env->peak_states = max(env->peak_states, cur_states);
-}
-
 static void free_func_state(struct bpf_func_state *state)
 {
 	if (!state)
@@ -1604,15 +1566,15 @@ static void free_func_state(struct bpf_func_state *state)
 	kfree(state);
 }
 
-static void clear_jmp_history(struct bpf_verifier_state *state)
+void bpf_clear_jmp_history(struct bpf_verifier_state *state)
 {
 	kfree(state->jmp_history);
 	state->jmp_history = NULL;
 	state->jmp_history_cnt = 0;
 }
 
-static void free_verifier_state(struct bpf_verifier_state *state,
-				bool free_self)
+void bpf_free_verifier_state(struct bpf_verifier_state *state,
+			    bool free_self)
 {
 	int i;
 
@@ -1621,42 +1583,11 @@ static void free_verifier_state(struct bpf_verifier_state *state,
 		state->frame[i] = NULL;
 	}
 	kfree(state->refs);
-	clear_jmp_history(state);
+	bpf_clear_jmp_history(state);
 	if (free_self)
 		kfree(state);
 }
 
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
-	free_verifier_state(&sl->state, false);
-	kfree(sl);
-	env->free_list_size--;
-}
-
 /* copy verifier state from src to dst growing dst stack space
  * when necessary to accommodate larger src stack
  */
@@ -1667,8 +1598,8 @@ static int copy_func_state(struct bpf_func_state *dst,
 	return copy_stack_state(dst, src);
 }
 
-static int copy_verifier_state(struct bpf_verifier_state *dst_state,
-			       const struct bpf_verifier_state *src)
+int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
+			   const struct bpf_verifier_state *src)
 {
 	struct bpf_func_state *dst;
 	int i, err;
@@ -1721,7 +1652,7 @@ static u32 state_htab_size(struct bpf_verifier_env *env)
 	return env->prog->len;
 }
 
-static struct list_head *explored_state(struct bpf_verifier_env *env, int idx)
+struct list_head *bpf_explored_state(struct bpf_verifier_env *env, int idx)
 {
 	struct bpf_verifier_state *cur = env->cur_state;
 	struct bpf_func_state *state = cur->frame[cur->curframe];
@@ -1743,266 +1674,19 @@ static bool same_callsites(struct bpf_verifier_state *a, struct bpf_verifier_sta
 	return true;
 }
 
-/* Return IP for a given frame in a call stack */
-static u32 frame_insn_idx(struct bpf_verifier_state *st, u32 frame)
-{
-	return frame == st->curframe
-	       ? st->insn_idx
-	       : st->frame[frame + 1]->callsite;
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
-		insn_idx = frame_insn_idx(st, i);
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
 
-static void free_backedges(struct bpf_scc_visit *visit)
+void bpf_free_backedges(struct bpf_scc_visit *visit)
 {
 	struct bpf_scc_backedge *backedge, *next;
 
 	for (backedge = visit->backedges; backedge; backedge = next) {
-		free_verifier_state(&backedge->state, false);
+		bpf_free_verifier_state(&backedge->state, false);
 		next = backedge->next;
 		kfree(backedge);
 	}
 	visit->backedges = NULL;
 }
 
-static int update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
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
 static int pop_stack(struct bpf_verifier_env *env, int *prev_insn_idx,
 		     int *insn_idx, bool pop_log)
 {
@@ -2014,7 +1698,7 @@ static int pop_stack(struct bpf_verifier_env *env, int *prev_insn_idx,
 		return -ENOENT;
 
 	if (cur) {
-		err = copy_verifier_state(cur, &head->st);
+		err = bpf_copy_verifier_state(cur, &head->st);
 		if (err)
 			return err;
 	}
@@ -2025,7 +1709,7 @@ static int pop_stack(struct bpf_verifier_env *env, int *prev_insn_idx,
 	if (prev_insn_idx)
 		*prev_insn_idx = head->prev_insn_idx;
 	elem = head->next;
-	free_verifier_state(&head->st, false);
+	bpf_free_verifier_state(&head->st, false);
 	kfree(head);
 	env->head = elem;
 	env->stack_size--;
@@ -2062,7 +1746,7 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	elem->log_pos = env->log.end_pos;
 	env->head = elem;
 	env->stack_size++;
-	err = copy_verifier_state(&elem->st, cur);
+	err = bpf_copy_verifier_state(&elem->st, cur);
 	if (err)
 		return ERR_PTR(-ENOMEM);
 	elem->st.speculative |= speculative;
@@ -2792,7 +2476,7 @@ static void __reg_assign_32_into_64(struct bpf_reg_state *reg)
 }
 
 /* Mark a register as having a completely unknown (scalar) value. */
-static void __mark_reg_unknown_imprecise(struct bpf_reg_state *reg)
+void bpf_mark_reg_unknown_imprecise(struct bpf_reg_state *reg)
 {
 	/*
 	 * Clear type, off, and union(map_ptr, range) and
@@ -2814,7 +2498,7 @@ static void __mark_reg_unknown_imprecise(struct bpf_reg_state *reg)
 static void __mark_reg_unknown(const struct bpf_verifier_env *env,
 			       struct bpf_reg_state *reg)
 {
-	__mark_reg_unknown_imprecise(reg);
+	bpf_mark_reg_unknown_imprecise(reg);
 	reg->precise = !env->bpf_capable;
 }
 
@@ -2843,19 +2527,13 @@ static int __mark_reg_s32_range(struct bpf_verifier_env *env,
 	return reg_bounds_sanity_check(env, reg, "s32_range");
 }
 
-static void __mark_reg_not_init(const struct bpf_verifier_env *env,
-				struct bpf_reg_state *reg)
+void bpf_mark_reg_not_init(const struct bpf_verifier_env *env,
+			   struct bpf_reg_state *reg)
 {
 	__mark_reg_unknown(env, reg);
 	reg->type = NOT_INIT;
 }
 
-static void mark_reg_not_init(struct bpf_verifier_env *env,
-			      struct bpf_reg_state *regs, u32 regno)
-{
-	__mark_reg_not_init(env, regs + regno);
-}
-
 static int mark_btf_ld_reg(struct bpf_verifier_env *env,
 			   struct bpf_reg_state *regs, u32 regno,
 			   enum bpf_reg_type reg_type,
@@ -2893,7 +2571,7 @@ static void init_reg_state(struct bpf_verifier_env *env,
 	int i;
 
 	for (i = 0; i < MAX_BPF_REG; i++) {
-		mark_reg_not_init(env, regs, i);
+		bpf_mark_reg_not_init(env, &regs[i]);
 		regs[i].subreg_def = DEF_NOT_SUBREG;
 	}
 
@@ -2949,7 +2627,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 			env->stack_size);
 		return ERR_PTR(-E2BIG);
 	}
-	/* Unlike push_stack() do not copy_verifier_state().
+	/* Unlike push_stack() do not bpf_copy_verifier_state().
 	 * The caller state doesn't matter.
 	 * This is async callback. It starts in a fresh stack.
 	 * Initialize it similar to do_check_common().
@@ -3849,11 +3527,6 @@ static int insn_stack_access_frameno(int insn_flags)
 	return insn_flags & INSN_F_FRAMENO_MASK;
 }
 
-static bool is_jmp_point(struct bpf_verifier_env *env, int insn_idx)
-{
-	return env->insn_aux_data[insn_idx].jmp_point;
-}
-
 #define LR_FRAMENO_BITS	3
 #define LR_SPI_BITS	6
 #define LR_ENTRY_BITS	(LR_SPI_BITS + LR_FRAMENO_BITS + 1)
@@ -3933,8 +3606,8 @@ static void linked_regs_unpack(u64 val, struct linked_regs *s)
 }
 
 /* for any branch, call, exit record the history of jmps in the given state */
-static int push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
-			    int insn_flags, u64 linked_regs)
+int bpf_push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
+			int insn_flags, u64 linked_regs)
 {
 	u32 cnt = cur->jmp_history_cnt;
 	struct bpf_jmp_history_entry *p;
@@ -4088,11 +3761,6 @@ static inline int bt_subprog_exit(struct backtrack_state *bt)
 	return 0;
 }
 
-static inline void bt_set_frame_reg(struct backtrack_state *bt, u32 frame, u32 reg)
-{
-	bt->reg_masks[frame] |= 1 << reg;
-}
-
 static inline void bt_clear_frame_reg(struct backtrack_state *bt, u32 frame, u32 reg)
 {
 	bt->reg_masks[frame] &= ~(1 << reg);
@@ -4100,7 +3768,7 @@ static inline void bt_clear_frame_reg(struct backtrack_state *bt, u32 frame, u32
 
 static inline void bt_set_reg(struct backtrack_state *bt, u32 reg)
 {
-	bt_set_frame_reg(bt, bt->frame, reg);
+	bpf_bt_set_frame_reg(bt, bt->frame, reg);
 }
 
 static inline void bt_clear_reg(struct backtrack_state *bt, u32 reg)
@@ -4108,11 +3776,6 @@ static inline void bt_clear_reg(struct backtrack_state *bt, u32 reg)
 	bt_clear_frame_reg(bt, bt->frame, reg);
 }
 
-static inline void bt_set_frame_slot(struct backtrack_state *bt, u32 frame, u32 slot)
-{
-	bt->stack_masks[frame] |= 1ull << slot;
-}
-
 static inline void bt_clear_frame_slot(struct backtrack_state *bt, u32 frame, u32 slot)
 {
 	bt->stack_masks[frame] &= ~(1ull << slot);
@@ -4222,9 +3885,9 @@ static void bt_sync_linked_regs(struct backtrack_state *bt, struct bpf_jmp_histo
 		struct linked_reg *e = &linked_regs.entries[i];
 
 		if (e->is_reg)
-			bt_set_frame_reg(bt, e->frameno, e->regno);
+			bpf_bt_set_frame_reg(bt, e->frameno, e->regno);
 		else
-			bt_set_frame_slot(bt, e->frameno, e->spi);
+			bpf_bt_set_frame_slot(bt, e->frameno, e->spi);
 	}
 }
 
@@ -4337,7 +4000,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 		 */
 		spi = insn_stack_access_spi(hist->flags);
 		fr = insn_stack_access_frameno(hist->flags);
-		bt_set_frame_slot(bt, fr, spi);
+		bpf_bt_set_frame_slot(bt, fr, spi);
 	} else if (class == BPF_STX || class == BPF_ST) {
 		if (bt_is_reg_set(bt, dreg))
 			/* stx & st shouldn't be using _scalar_ dst_reg
@@ -4410,7 +4073,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				for (i = BPF_REG_1; i <= BPF_REG_5; i++) {
 					if (bt_is_reg_set(bt, i)) {
 						bt_clear_reg(bt, i);
-						bt_set_frame_reg(bt, bt->frame - 1, i);
+						bpf_bt_set_frame_reg(bt, bt->frame - 1, i);
 					}
 				}
 				if (bt_subprog_exit(bt))
@@ -4596,8 +4259,8 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
  *
  * For now backtracking falls back into conservative marking.
  */
-static void mark_all_scalars_precise(struct bpf_verifier_env *env,
-				     struct bpf_verifier_state *st)
+void bpf_mark_all_scalars_precise(struct bpf_verifier_env *env,
+				 struct bpf_verifier_state *st)
 {
 	struct bpf_func_state *func;
 	struct bpf_reg_state *reg;
@@ -4628,7 +4291,7 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
 				}
 			}
 			for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
-				if (!is_spilled_reg(&func->stack[j]))
+				if (!bpf_is_spilled_reg(&func->stack[j]))
 					continue;
 				reg = &func->stack[j].spilled_ptr;
 				if (reg->type != SCALAR_VALUE || reg->precise)
@@ -4643,33 +4306,8 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
 	}
 }
 
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
-		for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
-			if (!is_spilled_reg(&func->stack[j]))
-				continue;
-			reg = &func->stack[j].spilled_ptr;
-			if (reg->type != SCALAR_VALUE)
-				continue;
-			reg->precise = false;
-		}
-	}
-}
-
 /*
- * __mark_chain_precision() backtracks BPF program instruction sequence and
+ * bpf_mark_chain_precision() backtracks BPF program instruction sequence and
  * chain of verifier states making sure that register *regno* (if regno >= 0)
  * and/or stack slot *spi* (if spi >= 0) are marked as precisely tracked
  * SCALARS, as well as any other registers and slots that contribute to
@@ -4755,10 +4393,10 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
  * mark_all_scalars_imprecise() to hopefully get more permissive and generic
  * finalized states which help in short circuiting more future states.
  */
-static int __mark_chain_precision(struct bpf_verifier_env *env,
-				  struct bpf_verifier_state *starting_state,
-				  int regno,
-				  bool *changed)
+int bpf_mark_chain_precision(struct bpf_verifier_env *env,
+			    struct bpf_verifier_state *starting_state,
+			    int regno,
+			    bool *changed)
 {
 	struct bpf_verifier_state *st = starting_state;
 	struct backtrack_state *bt = &env->bt;
@@ -4841,7 +4479,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
 				err = backtrack_insn(env, i, subseq_idx, hist, bt);
 			}
 			if (err == -ENOTSUPP) {
-				mark_all_scalars_precise(env, starting_state);
+				bpf_mark_all_scalars_precise(env, starting_state);
 				bt_reset(bt);
 				return 0;
 			} else if (err) {
@@ -4933,7 +4571,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
 	 * fallback to marking all precise
 	 */
 	if (!bt_empty(bt)) {
-		mark_all_scalars_precise(env, starting_state);
+		bpf_mark_all_scalars_precise(env, starting_state);
 		bt_reset(bt);
 	}
 
@@ -4942,7 +4580,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
 
 int mark_chain_precision(struct bpf_verifier_env *env, int regno)
 {
-	return __mark_chain_precision(env, env->cur_state, regno, NULL);
+	return bpf_mark_chain_precision(env, env->cur_state, regno, NULL);
 }
 
 /* mark_chain_precision_batch() assumes that env->bt is set in the caller to
@@ -4951,7 +4589,7 @@ int mark_chain_precision(struct bpf_verifier_env *env, int regno)
 static int mark_chain_precision_batch(struct bpf_verifier_env *env,
 				      struct bpf_verifier_state *starting_state)
 {
-	return __mark_chain_precision(env, starting_state, -1, NULL);
+	return bpf_mark_chain_precision(env, starting_state, -1, NULL);
 }
 
 static bool is_spillable_regtype(enum bpf_reg_type type)
@@ -4981,11 +4619,6 @@ static bool is_spillable_regtype(enum bpf_reg_type type)
 	}
 }
 
-/* Does this register contain a constant zero? */
-static bool register_is_null(struct bpf_reg_state *reg)
-{
-	return reg->type == SCALAR_VALUE && tnum_equals_const(reg->var_off, 0);
-}
 
 /* check if register is a constant scalar value */
 static bool is_reg_const(struct bpf_reg_state *reg, bool subreg32)
@@ -5015,6 +4648,68 @@ static void clear_scalar_id(struct bpf_reg_state *reg)
 	reg->delta = 0;
 }
 
+static void idset_cnt_inc(struct bpf_idset *idset, u32 id)
+{
+	u32 i;
+
+	for (i = 0; i < idset->num_ids; i++) {
+		if (idset->entries[i].id == id) {
+			idset->entries[i].cnt++;
+			return;
+		}
+	}
+	/* New id */
+	if (idset->num_ids < BPF_ID_MAP_SIZE) {
+		idset->entries[idset->num_ids].id = id;
+		idset->entries[idset->num_ids].cnt = 1;
+		idset->num_ids++;
+	}
+}
+
+/* Find id in idset and return its count, or 0 if not found */
+static u32 idset_cnt_get(struct bpf_idset *idset, u32 id)
+{
+	u32 i;
+
+	for (i = 0; i < idset->num_ids; i++) {
+		if (idset->entries[i].id == id)
+			return idset->entries[i].cnt;
+	}
+	return 0;
+}
+
+/*
+ * Clear singular scalar ids in a state.
+ * A register with a non-zero id is called singular if no other register shares
+ * the same base id. Such registers can be treated as independent (id=0).
+ */
+void bpf_clear_singular_ids(struct bpf_verifier_env *env,
+			    struct bpf_verifier_state *st)
+{
+	struct bpf_idset *idset = &env->idset_scratch;
+	struct bpf_func_state *func;
+	struct bpf_reg_state *reg;
+
+	idset->num_ids = 0;
+
+	bpf_for_each_reg_in_vstate(st, func, reg, ({
+		if (reg->type != SCALAR_VALUE)
+			continue;
+		if (!reg->id)
+			continue;
+		idset_cnt_inc(idset, reg->id & ~BPF_ADD_CONST);
+	}));
+
+	bpf_for_each_reg_in_vstate(st, func, reg, ({
+		if (reg->type != SCALAR_VALUE)
+			continue;
+		if (!reg->id)
+			continue;
+		if (idset_cnt_get(idset, reg->id & ~BPF_ADD_CONST) == 1)
+			clear_scalar_id(reg);
+	}));
+}
+
 static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
 					struct bpf_reg_state *src_reg)
 {
@@ -5125,7 +4820,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	 * so it's aligned access and [off, off + size) are within stack limits
 	 */
 	if (!env->allow_ptr_leaks &&
-	    is_spilled_reg(&state->stack[spi]) &&
+	    bpf_is_spilled_reg(&state->stack[spi]) &&
 	    !is_spilled_scalar_reg(&state->stack[spi]) &&
 	    size != BPF_REG_SIZE) {
 		verbose(env, "attempt to corrupt spilled pointer on stack\n");
@@ -5194,7 +4889,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		scrub_special_slot(state, spi);
 
 		/* when we zero initialize stack slots mark them as such */
-		if ((reg && register_is_null(reg)) ||
+		if ((reg && bpf_register_is_null(reg)) ||
 		    (!reg && is_bpf_st_mem(insn) && insn->imm == 0)) {
 			/* STACK_ZERO case happened because register spill
 			 * wasn't properly aligned at the stack slot boundary,
@@ -5215,7 +4910,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	}
 
 	if (insn_flags)
-		return push_jmp_history(env, env->cur_state, insn_flags, 0);
+		return bpf_push_jmp_history(env, env->cur_state, insn_flags, 0);
 	return 0;
 }
 
@@ -5260,14 +4955,14 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 	max_off = ptr_reg->smax_value + off + size;
 	if (value_regno >= 0)
 		value_reg = &cur->regs[value_regno];
-	if ((value_reg && register_is_null(value_reg)) ||
+	if ((value_reg && bpf_register_is_null(value_reg)) ||
 	    (!value_reg && is_bpf_st_mem(insn) && insn->imm == 0))
 		writing_zero = true;
 
 	for (i = min_off; i < max_off; i++) {
 		int spi;
 
-		spi = __get_spi(i);
+		spi = bpf_get_spi(i);
 		err = destroy_if_dynptr_stack_slot(env, state, spi);
 		if (err)
 			return err;
@@ -5316,7 +5011,7 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 
 		/*
 		 * Scrub slots if variable-offset stack write goes over spilled pointers.
-		 * Otherwise is_spilled_reg() may == true && spilled_ptr.type == NOT_INIT
+		 * Otherwise bpf_is_spilled_reg() may == true && spilled_ptr.type == NOT_INIT
 		 * and valid program is rejected by check_stack_read_fixed_off()
 		 * with obscure "invalid size of register fill" message.
 		 */
@@ -5420,7 +5115,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 	mark_stack_slot_scratched(env, spi);
 	check_fastcall_stack_contract(env, state, env->insn_idx, off);
 
-	if (is_spilled_reg(&reg_state->stack[spi])) {
+	if (bpf_is_spilled_reg(&reg_state->stack[spi])) {
 		u8 spill_size = 1;
 
 		for (i = BPF_REG_SIZE - 1; i > 0 && stype[i - 1] == STACK_SPILL; i--)
@@ -5543,7 +5238,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 		insn_flags = 0; /* we are not restoring spilled register */
 	}
 	if (insn_flags)
-		return push_jmp_history(env, env->cur_state, insn_flags, 0);
+		return bpf_push_jmp_history(env, env->cur_state, insn_flags, 0);
 	return 0;
 }
 
@@ -5581,7 +5276,7 @@ static int check_stack_read_var_off(struct bpf_verifier_env *env,
 {
 	/* The state of the source register. */
 	struct bpf_reg_state *reg = reg_state(env, ptr_regno);
-	struct bpf_func_state *ptr_state = func(env, reg);
+	struct bpf_func_state *ptr_state = bpf_func(env, reg);
 	int err;
 	int min_off, max_off;
 
@@ -5613,7 +5308,7 @@ static int check_stack_read(struct bpf_verifier_env *env,
 			    int dst_regno)
 {
 	struct bpf_reg_state *reg = reg_state(env, ptr_regno);
-	struct bpf_func_state *state = func(env, reg);
+	struct bpf_func_state *state = bpf_func(env, reg);
 	int err;
 	/* Some accesses are only permitted with a static offset. */
 	bool var_off = !tnum_is_const(reg->var_off);
@@ -5669,7 +5364,7 @@ static int check_stack_write(struct bpf_verifier_env *env,
 			     int value_regno, int insn_idx)
 {
 	struct bpf_reg_state *reg = reg_state(env, ptr_regno);
-	struct bpf_func_state *state = func(env, reg);
+	struct bpf_func_state *state = bpf_func(env, reg);
 	int err;
 
 	if (tnum_is_const(reg->var_off)) {
@@ -6066,7 +5761,7 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 			return ret;
 	} else if (class == BPF_STX) {
 		val_reg = reg_state(env, value_regno);
-		if (!register_is_null(val_reg) &&
+		if (!bpf_register_is_null(val_reg) &&
 		    map_kptr_match_type(env, kptr_field, val_reg, value_regno))
 			return -EACCES;
 	} else if (class == BPF_ST) {
@@ -7532,7 +7227,7 @@ static int check_stack_access_within_bounds(
 		enum bpf_access_type type)
 {
 	struct bpf_reg_state *reg = reg_state(env, regno);
-	struct bpf_func_state *state = func(env, reg);
+	struct bpf_func_state *state = bpf_func(env, reg);
 	s64 min_off, max_off;
 	int err;
 	char *err_extra;
@@ -8118,7 +7813,7 @@ static int check_stack_range_initialized(
 		enum bpf_access_type type, struct bpf_call_arg_meta *meta)
 {
 	struct bpf_reg_state *reg = reg_state(env, regno);
-	struct bpf_func_state *state = func(env, reg);
+	struct bpf_func_state *state = bpf_func(env, reg);
 	int err, min_off, max_off, i, j, slot, spi;
 	/* Some accesses can write anything into the stack, others are
 	 * read-only.
@@ -8190,7 +7885,7 @@ static int check_stack_range_initialized(
 		for (i = min_off; i < max_off + access_size; i++) {
 			int stack_off = -i - 1;
 
-			spi = __get_spi(i);
+			spi = bpf_get_spi(i);
 			/* raw_mode may write past allocated_stack */
 			if (state->allocated_stack <= stack_off)
 				continue;
@@ -8226,7 +7921,7 @@ static int check_stack_range_initialized(
 			goto mark;
 		}
 
-		if (is_spilled_reg(&state->stack[spi]) &&
+		if (bpf_is_spilled_reg(&state->stack[spi]) &&
 		    (state->stack[spi].spilled_ptr.type == SCALAR_VALUE ||
 		     env->allow_ptr_leaks)) {
 			if (clobber) {
@@ -8334,7 +8029,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 	default: /* scalar_value or invalid ptr */
 		/* Allow zero-byte read from NULL, regardless of pointer type */
 		if (zero_size_allowed && access_size == 0 &&
-		    register_is_null(reg))
+		    bpf_register_is_null(reg))
 			return 0;
 
 		verbose(env, "R%d type=%s ", regno,
@@ -8407,7 +8102,7 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 	struct bpf_reg_state saved_reg;
 	int err;
 
-	if (register_is_null(reg))
+	if (bpf_register_is_null(reg))
 		return 0;
 
 	/* Assuming that the register contains a value check if the memory
@@ -8833,7 +8528,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn
 
 static u32 iter_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg, int spi)
 {
-	struct bpf_func_state *state = func(env, reg);
+	struct bpf_func_state *state = bpf_func(env, reg);
 
 	return state->stack[spi].spilled_ptr.ref_obj_id;
 }
@@ -8965,7 +8660,7 @@ static struct bpf_verifier_state *find_prev_entry(struct bpf_verifier_env *env,
 	struct list_head *pos, *head;
 
 	/* Explored states are pushed in stack order, most recent states come first */
-	head = explored_state(env, insn_idx);
+	head = bpf_explored_state(env, insn_idx);
 	list_for_each(pos, head) {
 		sl = container_of(pos, struct bpf_verifier_state_list, node);
 		/* If st->branches != 0 state is a part of current DFS verification path,
@@ -8980,14 +8675,8 @@ static struct bpf_verifier_state *find_prev_entry(struct bpf_verifier_env *env,
 	return NULL;
 }
 
-static void reset_idmap_scratch(struct bpf_verifier_env *env);
-static bool regs_exact(const struct bpf_reg_state *rold,
-		       const struct bpf_reg_state *rcur,
-		       struct bpf_idmap *idmap);
-
 /*
  * Check if scalar registers are exact for the purpose of not widening.
- * More lenient than regs_exact()
  */
 static bool scalars_exact_for_widen(const struct bpf_reg_state *rold,
 				    const struct bpf_reg_state *rcur)
@@ -9026,8 +8715,8 @@ static int widen_imprecise_scalars(struct bpf_verifier_env *env,
 		num_slots = min(fold->allocated_stack / BPF_REG_SIZE,
 				fcur->allocated_stack / BPF_REG_SIZE);
 		for (i = 0; i < num_slots; i++) {
-			if (!is_spilled_reg(&fold->stack[i]) ||
-			    !is_spilled_reg(&fcur->stack[i]))
+			if (!bpf_is_spilled_reg(&fold->stack[i]) ||
+			    !bpf_is_spilled_reg(&fcur->stack[i]))
 				continue;
 
 			maybe_widen_reg(env,
@@ -9620,7 +9309,7 @@ static struct bpf_reg_state *get_dynptr_arg_reg(struct bpf_verifier_env *env,
 
 static int dynptr_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
-	struct bpf_func_state *state = func(env, reg);
+	struct bpf_func_state *state = bpf_func(env, reg);
 	int spi;
 
 	if (reg->type == CONST_PTR_TO_DYNPTR)
@@ -9633,7 +9322,7 @@ static int dynptr_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 
 static int dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
-	struct bpf_func_state *state = func(env, reg);
+	struct bpf_func_state *state = bpf_func(env, reg);
 	int spi;
 
 	if (reg->type == CONST_PTR_TO_DYNPTR)
@@ -9647,13 +9336,13 @@ static int dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state
 static enum bpf_dynptr_type dynptr_get_type(struct bpf_verifier_env *env,
 					    struct bpf_reg_state *reg)
 {
-	struct bpf_func_state *state = func(env, reg);
+	struct bpf_func_state *state = bpf_func(env, reg);
 	int spi;
 
 	if (reg->type == CONST_PTR_TO_DYNPTR)
 		return reg->dynptr.type;
 
-	spi = __get_spi(reg->var_off.value);
+	spi = bpf_get_spi(reg->var_off.value);
 	if (spi < 0) {
 		verbose(env, "verifier internal error: invalid spi when querying dynptr type\n");
 		return BPF_DYNPTR_TYPE_INVALID;
@@ -9721,7 +9410,7 @@ static int get_constant_map_key(struct bpf_verifier_env *env,
 				u32 key_size,
 				s64 *value)
 {
-	struct bpf_func_state *state = func(env, key);
+	struct bpf_func_state *state = bpf_func(env, key);
 	struct bpf_reg_state *reg;
 	int slot, spi, off;
 	int spill_size = 0;
@@ -9767,7 +9456,7 @@ static int get_constant_map_key(struct bpf_verifier_env *env,
 	/* We are relying on a constant value. So mark as precise
 	 * to prevent pruning on it.
 	 */
-	bt_set_frame_slot(&env->bt, key->frameno, spi);
+	bpf_bt_set_frame_slot(&env->bt, key->frameno, spi);
 	err = mark_chain_precision_batch(env, env->cur_state);
 	if (err < 0)
 		return err;
@@ -9819,7 +9508,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return err;
 	}
 
-	if (register_is_null(reg) && type_may_be_null(arg_type))
+	if (bpf_register_is_null(reg) && type_may_be_null(arg_type))
 		/* A NULL register has a SCALAR_VALUE type, so skip
 		 * type checking.
 		 */
@@ -9841,7 +9530,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 skip_type_check:
 	if (arg_type_is_release(arg_type)) {
 		if (arg_type_is_dynptr(arg_type)) {
-			struct bpf_func_state *state = func(env, reg);
+			struct bpf_func_state *state = bpf_func(env, reg);
 			int spi;
 
 			/* Only dynptr created on stack can be released, thus
@@ -9859,7 +9548,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 				verbose(env, "cannot release unowned const bpf_dynptr\n");
 				return -EINVAL;
 			}
-		} else if (!reg->ref_obj_id && !register_is_null(reg)) {
+		} else if (!reg->ref_obj_id && !bpf_register_is_null(reg)) {
 			verbose(env, "R%d must be referenced when passed to release function\n",
 				regno);
 			return -EINVAL;
@@ -9938,7 +9627,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		}
 		break;
 	case ARG_PTR_TO_MAP_VALUE:
-		if (type_may_be_null(arg_type) && register_is_null(reg))
+		if (type_may_be_null(arg_type) && bpf_register_is_null(reg))
 			return 0;
 
 		/* bpf_map_xxx(..., map_ptr, ..., value) call:
@@ -10543,7 +10232,7 @@ static void clear_caller_saved_regs(struct bpf_verifier_env *env,
 
 	/* after the call registers r0 - r5 were scratched */
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
-		mark_reg_not_init(env, regs, caller_saved[i]);
+		bpf_mark_reg_not_init(env, &regs[caller_saved[i]]);
 		__check_reg_arg(env, regs, caller_saved[i], DST_OP_NO_MARK);
 	}
 }
@@ -10682,7 +10371,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			struct bpf_call_arg_meta meta;
 			int err;
 
-			if (register_is_null(reg) && type_may_be_null(arg->arg_type))
+			if (bpf_register_is_null(reg) && type_may_be_null(arg->arg_type))
 				continue;
 
 			memset(&meta, 0, sizeof(meta)); /* leave func_id as zero */
@@ -10905,7 +10594,7 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 	callee->regs[BPF_REG_4] = caller->regs[BPF_REG_3];
 
 	/* unused */
-	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
+	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	return 0;
 }
 
@@ -10962,9 +10651,9 @@ static int set_loop_callback_state(struct bpf_verifier_env *env,
 	callee->regs[BPF_REG_2] = caller->regs[BPF_REG_3];
 
 	/* unused */
-	__mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
-	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
-	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
+	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
+	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
+	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 
 	callee->in_callback_fn = true;
 	callee->callback_ret_range = retval_range(0, 1);
@@ -10994,8 +10683,8 @@ static int set_timer_callback_state(struct bpf_verifier_env *env,
 	callee->regs[BPF_REG_3].map_ptr = map_ptr;
 
 	/* unused */
-	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
-	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
+	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
+	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_async_callback_fn = true;
 	callee->callback_ret_range = retval_range(0, 0);
 	return 0;
@@ -11022,8 +10711,8 @@ static int set_find_vma_callback_state(struct bpf_verifier_env *env,
 	callee->regs[BPF_REG_3] = caller->regs[BPF_REG_4];
 
 	/* unused */
-	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
-	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
+	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
+	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_callback_fn = true;
 	callee->callback_ret_range = retval_range(0, 1);
 	return 0;
@@ -11038,14 +10727,14 @@ static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
 	 *			  callback_ctx, u64 flags);
 	 * callback_fn(const struct bpf_dynptr_t* dynptr, void *callback_ctx);
 	 */
-	__mark_reg_not_init(env, &callee->regs[BPF_REG_0]);
+	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_0]);
 	mark_dynptr_cb_reg(env, &callee->regs[BPF_REG_1], BPF_DYNPTR_TYPE_LOCAL);
 	callee->regs[BPF_REG_2] = caller->regs[BPF_REG_3];
 
 	/* unused */
-	__mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
-	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
-	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
+	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
+	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
+	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 
 	callee->in_callback_fn = true;
 	callee->callback_ret_range = retval_range(0, 1);
@@ -11077,9 +10766,9 @@ static int set_rbtree_add_callback_state(struct bpf_verifier_env *env,
 	mark_reg_graph_node(callee->regs, BPF_REG_2, &field->graph_root);
 	ref_set_non_owning(env, &callee->regs[BPF_REG_2]);
 
-	__mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
-	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
-	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
+	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
+	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
+	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_callback_fn = true;
 	callee->callback_ret_range = retval_range(0, 1);
 	return 0;
@@ -11108,8 +10797,8 @@ static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
 	callee->regs[BPF_REG_3].map_ptr = map_ptr;
 
 	/* unused */
-	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
-	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
+	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
+	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_async_callback_fn = true;
 	callee->callback_ret_range = retval_range(S32_MIN, S32_MAX);
 	return 0;
@@ -11486,7 +11175,7 @@ static struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *env)
 static bool loop_flag_is_zero(struct bpf_verifier_env *env)
 {
 	struct bpf_reg_state *reg = reg_state(env, BPF_REG_4);
-	bool reg_is_null = register_is_null(reg);
+	bool reg_is_null = bpf_register_is_null(reg);
 
 	if (reg_is_null)
 		mark_chain_precision(env, BPF_REG_4);
@@ -11682,7 +11371,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			}
 		} else if (meta.ref_obj_id) {
 			err = release_reference(env, meta.ref_obj_id);
-		} else if (register_is_null(&regs[meta.release_regno])) {
+		} else if (bpf_register_is_null(&regs[meta.release_regno])) {
 			/* meta.ref_obj_id can only be 0 if register that is meant to be
 			 * released is NULL, which must be > R0.
 			 */
@@ -11705,7 +11394,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		/* check that flags argument in get_local_storage(map, flags) is 0,
 		 * this is required because get_local_storage() can't return an error.
 		 */
-		if (!register_is_null(&regs[BPF_REG_2])) {
+		if (!bpf_register_is_null(&regs[BPF_REG_2])) {
 			verbose(env, "get_local_storage() doesn't support non-zero flags\n");
 			return -EINVAL;
 		}
@@ -11848,7 +11537,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	/* reset caller saved regs */
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
-		mark_reg_not_init(env, regs, caller_saved[i]);
+		bpf_mark_reg_not_init(env, &regs[caller_saved[i]]);
 		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
 	}
 
@@ -12684,7 +12373,7 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (btf_is_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), argno))
 		return KF_ARG_PTR_TO_CTX;
 
-	if (is_kfunc_arg_nullable(meta->btf, &args[argno]) && register_is_null(reg) &&
+	if (is_kfunc_arg_nullable(meta->btf, &args[argno]) && bpf_register_is_null(reg) &&
 	    !arg_mem_size)
 		return KF_ARG_PTR_TO_NULL;
 
@@ -13425,7 +13114,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return -EINVAL;
 		}
 
-		if ((register_is_null(reg) || type_may_be_null(reg->type)) &&
+		if ((bpf_register_is_null(reg) || type_may_be_null(reg->type)) &&
 		    !is_kfunc_arg_nullable(meta->btf, &args[i])) {
 			verbose(env, "Possibly NULL pointer passed to trusted arg%d\n", i);
 			return -EACCES;
@@ -13745,7 +13434,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			struct bpf_reg_state *size_reg = &regs[regno + 1];
 			const struct btf_param *size_arg = &args[i + 1];
 
-			if (!register_is_null(buff_reg) || !is_kfunc_arg_nullable(meta->btf, buff_arg)) {
+			if (!bpf_register_is_null(buff_reg) || !is_kfunc_arg_nullable(meta->btf, buff_arg)) {
 				ret = check_kfunc_mem_size_reg(env, size_reg, regno + 1);
 				if (ret < 0) {
 					verbose(env, "arg#%d arg#%d memory, len pair leads to invalid memory access\n", i, i + 1);
@@ -14320,7 +14009,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 		/* Clear r0-r5 registers in forked state */
 		for (i = 0; i < CALLER_SAVED_REGS; i++)
-			mark_reg_not_init(env, regs, caller_saved[i]);
+			bpf_mark_reg_not_init(env, &regs[caller_saved[i]]);
 
 		mark_reg_unknown(env, regs, BPF_REG_0);
 		err = __mark_reg_s32_range(env, regs, BPF_REG_0, -MAX_ERRNO, -1);
@@ -14498,7 +14187,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		u32 regno = caller_saved[i];
 
-		mark_reg_not_init(env, regs, regno);
+		bpf_mark_reg_not_init(env, &regs[regno]);
 		regs[regno].subreg_def = DEF_NOT_SUBREG;
 	}
 
@@ -17498,7 +17187,7 @@ static void collect_linked_regs(struct bpf_verifier_env *env,
 
 	id = id & ~BPF_ADD_CONST;
 	for (i = vstate->curframe; i >= 0; i--) {
-		live_regs = aux[frame_insn_idx(vstate, i)].live_regs_before;
+		live_regs = aux[bpf_frame_insn_idx(vstate, i)].live_regs_before;
 		func = vstate->frame[i];
 		for (j = 0; j < BPF_REG_FP; j++) {
 			if (!(live_regs & BIT(j)))
@@ -17507,7 +17196,7 @@ static void collect_linked_regs(struct bpf_verifier_env *env,
 			__collect_linked_regs(linked_regs, reg, id, i, j, true);
 		}
 		for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
-			if (!is_spilled_reg(&func->stack[j]))
+			if (!bpf_is_spilled_reg(&func->stack[j]))
 				continue;
 			reg = &func->stack[j].spilled_ptr;
 			__collect_linked_regs(linked_regs, reg, id, i, j, false);
@@ -17652,7 +17341,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	}
 
 	if (insn_flags) {
-		err = push_jmp_history(env, this_branch, insn_flags, 0);
+		err = bpf_push_jmp_history(env, this_branch, insn_flags, 0);
 		if (err)
 			return err;
 	}
@@ -17716,7 +17405,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	if (dst_reg->type == SCALAR_VALUE && dst_reg->id)
 		collect_linked_regs(env, this_branch, dst_reg->id, &linked_regs);
 	if (linked_regs.cnt > 1) {
-		err = push_jmp_history(env, this_branch, 0, linked_regs_pack(&linked_regs));
+		err = bpf_push_jmp_history(env, this_branch, 0, linked_regs_pack(&linked_regs));
 		if (err)
 			return err;
 	}
@@ -17796,7 +17485,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	if (!is_jmp32 && (opcode == BPF_JEQ || opcode == BPF_JNE) &&
 	    type_may_be_null(dst_reg->type) &&
 	    ((BPF_SRC(insn->code) == BPF_K && insn->imm == 0) ||
-	     (BPF_SRC(insn->code) == BPF_X && register_is_null(src_reg)))) {
+	     (BPF_SRC(insn->code) == BPF_X && bpf_register_is_null(src_reg)))) {
 		/* Mark all identical registers in each branch as either
 		 * safe or unknown depending R == 0 or R != 0 conditional.
 		 */
@@ -17988,7 +17677,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 
 	/* reset caller saved regs to unreadable */
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
-		mark_reg_not_init(env, regs, caller_saved[i]);
+		bpf_mark_reg_not_init(env, &regs[caller_saved[i]]);
 		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
 	}
 
@@ -18996,1309 +18685,7 @@ static int check_btf_info(struct bpf_verifier_env *env,
 	return 0;
 }
 
-/* check %cur's range satisfies %old's */
-static bool range_within(const struct bpf_reg_state *old,
-			 const struct bpf_reg_state *cur)
-{
-	return old->umin_value <= cur->umin_value &&
-	       old->umax_value >= cur->umax_value &&
-	       old->smin_value <= cur->smin_value &&
-	       old->smax_value >= cur->smax_value &&
-	       old->u32_min_value <= cur->u32_min_value &&
-	       old->u32_max_value >= cur->u32_max_value &&
-	       old->s32_min_value <= cur->s32_min_value &&
-	       old->s32_max_value >= cur->s32_max_value;
-}
-
-/* If in the old state two registers had the same id, then they need to have
- * the same id in the new state as well.  But that id could be different from
- * the old state, so we need to track the mapping from old to new ids.
- * Once we have seen that, say, a reg with old id 5 had new id 9, any subsequent
- * regs with old id 5 must also have new id 9 for the new state to be safe.  But
- * regs with a different old id could still have new id 9, we don't care about
- * that.
- * So we look through our idmap to see if this old id has been seen before.  If
- * so, we require the new id to match; otherwise, we add the id pair to the map.
- */
-static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
-{
-	struct bpf_id_pair *map = idmap->map;
-	unsigned int i;
-
-	/* either both IDs should be set or both should be zero */
-	if (!!old_id != !!cur_id)
-		return false;
-
-	if (old_id == 0) /* cur_id == 0 as well */
-		return true;
-
-	for (i = 0; i < idmap->cnt; i++) {
-		if (map[i].old == old_id)
-			return map[i].cur == cur_id;
-		if (map[i].cur == cur_id)
-			return false;
-	}
-
-	/* Reached the end of known mappings; haven't seen this id before */
-	if (idmap->cnt < BPF_ID_MAP_SIZE) {
-		map[idmap->cnt].old = old_id;
-		map[idmap->cnt].cur = cur_id;
-		idmap->cnt++;
-		return true;
-	}
-
-	/* We ran out of idmap slots, which should be impossible */
-	WARN_ON_ONCE(1);
-	return false;
-}
-
-/*
- * Compare scalar register IDs for state equivalence.
- *
- * When old_id == 0, the old register is independent - not linked to any
- * other register. Any linking in the current state only adds constraints,
- * making it more restrictive. Since the old state didn't rely on any ID
- * relationships for this register, it's always safe to accept cur regardless
- * of its ID. Hence, return true immediately.
- *
- * When old_id != 0 but cur_id == 0, we need to ensure that different
- * independent registers in cur don't incorrectly satisfy the ID matching
- * requirements of linked registers in old.
- *
- * Example: if old has r6.id=X and r7.id=X (linked), but cur has r6.id=0
- * and r7.id=0 (both independent), without temp IDs both would map old_id=X
- * to cur_id=0 and pass. With temp IDs: r6 maps X->temp1, r7 tries to map
- * X->temp2, but X is already mapped to temp1, so the check fails correctly.
- *
- * When old_id has BPF_ADD_CONST set, the compound id (base | flag) and the
- * base id (flag stripped) must both map consistently. Example: old has
- * r2.id=A, r3.id=A|flag (r3 = r2 + delta), cur has r2.id=B, r3.id=C|flag
- * (r3 derived from unrelated r4). Without the base check, idmap gets two
- * independent entries A->B and A|flag->C|flag, missing that A->C conflicts
- * with A->B. The base ID cross-check catches this.
- */
-static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
-{
-	if (!old_id)
-		return true;
-
-	cur_id = cur_id ? cur_id : ++idmap->tmp_id_gen;
-
-	if (!check_ids(old_id, cur_id, idmap))
-		return false;
-	if (old_id & BPF_ADD_CONST) {
-		old_id &= ~BPF_ADD_CONST;
-		cur_id &= ~BPF_ADD_CONST;
-		if (!check_ids(old_id, cur_id, idmap))
-			return false;
-	}
-	return true;
-}
-
-static void __clean_func_state(struct bpf_verifier_env *env,
-			       struct bpf_func_state *st,
-			       u16 live_regs, int frame)
-{
-	int i, j;
-
-	for (i = 0; i < BPF_REG_FP; i++) {
-		/* liveness must not touch this register anymore */
-		if (!(live_regs & BIT(i)))
-			/* since the register is unused, clear its state
-			 * to make further comparison simpler
-			 */
-			__mark_reg_not_init(env, &st->regs[i]);
-	}
-
-	/*
-	 * Clean dead 4-byte halves within each SPI independently.
-	 * half_spi 2*i   → lower half: slot_type[0..3] (closer to FP)
-	 * half_spi 2*i+1 → upper half: slot_type[4..7] (farther from FP)
-	 */
-	for (i = 0; i < st->allocated_stack / BPF_REG_SIZE; i++) {
-		bool lo_live = bpf_stack_slot_alive(env, frame, i * 2);
-		bool hi_live = bpf_stack_slot_alive(env, frame, i * 2 + 1);
-
-		if (!hi_live || !lo_live) {
-			int start = !lo_live ? 0 : BPF_REG_SIZE / 2;
-			int end = !hi_live ? BPF_REG_SIZE : BPF_REG_SIZE / 2;
-			u8 stype = st->stack[i].slot_type[7];
-
-			/*
-			 * Don't clear special slots.
-			 * destroy_if_dynptr_stack_slot() needs STACK_DYNPTR to
-			 * detect overwrites and invalidate associated data slices.
-			 * is_iter_reg_valid_uninit() and is_irq_flag_reg_valid_uninit()
-			 * check for their respective slot types to detect double-create.
-			 */
-			if (stype == STACK_DYNPTR || stype == STACK_ITER ||
-			    stype == STACK_IRQ_FLAG)
-				continue;
-
-			/*
-			 * Only destroy spilled_ptr when hi half is dead.
-			 * If hi half is still live with STACK_SPILL, the
-			 * spilled_ptr metadata is needed for correct state
-			 * comparison in stacksafe().
-			 * is_spilled_reg() is using slot_type[7], but
-			 * is_spilled_scalar_after() check either slot_type[0] or [4]
-			 */
-			if (!hi_live) {
-				struct bpf_reg_state *spill = &st->stack[i].spilled_ptr;
-
-				if (lo_live && stype == STACK_SPILL) {
-					u8 val = STACK_MISC;
-
-					/*
-					 * 8 byte spill of scalar 0 where half slot is dead
-					 * should become STACK_ZERO in lo 4 bytes.
-					 */
-					if (register_is_null(spill))
-						val = STACK_ZERO;
-					for (j = 0; j < 4; j++) {
-						u8 *t = &st->stack[i].slot_type[j];
-
-						if (*t == STACK_SPILL)
-							*t = val;
-					}
-				}
-				__mark_reg_not_init(env, spill);
-			}
-			for (j = start; j < end; j++)
-				st->stack[i].slot_type[j] = STACK_POISON;
-		}
-	}
-}
-
-static int clean_verifier_state(struct bpf_verifier_env *env,
-				 struct bpf_verifier_state *st)
-{
-	int i, err;
-
-	err = bpf_live_stack_query_init(env, st);
-	if (err)
-		return err;
-	for (i = 0; i <= st->curframe; i++) {
-		u32 ip = frame_insn_idx(st, i);
-		u16 live_regs = env->insn_aux_data[ip].live_regs_before;
-
-		__clean_func_state(env, st->frame[i], live_regs, i);
-	}
-	return 0;
-}
-
-/* Find id in idset and increment its count, or add new entry */
-static void idset_cnt_inc(struct bpf_idset *idset, u32 id)
-{
-	u32 i;
-
-	for (i = 0; i < idset->num_ids; i++) {
-		if (idset->entries[i].id == id) {
-			idset->entries[i].cnt++;
-			return;
-		}
-	}
-	/* New id */
-	if (idset->num_ids < BPF_ID_MAP_SIZE) {
-		idset->entries[idset->num_ids].id = id;
-		idset->entries[idset->num_ids].cnt = 1;
-		idset->num_ids++;
-	}
-}
-
-/* Find id in idset and return its count, or 0 if not found */
-static u32 idset_cnt_get(struct bpf_idset *idset, u32 id)
-{
-	u32 i;
-
-	for (i = 0; i < idset->num_ids; i++) {
-		if (idset->entries[i].id == id)
-			return idset->entries[i].cnt;
-	}
-	return 0;
-}
-
-/*
- * Clear singular scalar ids in a state.
- * A register with a non-zero id is called singular if no other register shares
- * the same base id. Such registers can be treated as independent (id=0).
- */
-static void clear_singular_ids(struct bpf_verifier_env *env,
-			       struct bpf_verifier_state *st)
-{
-	struct bpf_idset *idset = &env->idset_scratch;
-	struct bpf_func_state *func;
-	struct bpf_reg_state *reg;
-
-	idset->num_ids = 0;
-
-	bpf_for_each_reg_in_vstate(st, func, reg, ({
-		if (reg->type != SCALAR_VALUE)
-			continue;
-		if (!reg->id)
-			continue;
-		idset_cnt_inc(idset, reg->id & ~BPF_ADD_CONST);
-	}));
-
-	bpf_for_each_reg_in_vstate(st, func, reg, ({
-		if (reg->type != SCALAR_VALUE)
-			continue;
-		if (!reg->id)
-			continue;
-		if (idset_cnt_get(idset, reg->id & ~BPF_ADD_CONST) == 1)
-			clear_scalar_id(reg);
-	}));
-}
-
-static bool regs_exact(const struct bpf_reg_state *rold,
-		       const struct bpf_reg_state *rcur,
-		       struct bpf_idmap *idmap)
-{
-	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
-	       check_ids(rold->id, rcur->id, idmap) &&
-	       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
-}
-
-enum exact_level {
-	NOT_EXACT,
-	EXACT,
-	RANGE_WITHIN
-};
-
-/* Returns true if (rold safe implies rcur safe) */
-static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
-		    struct bpf_reg_state *rcur, struct bpf_idmap *idmap,
-		    enum exact_level exact)
-{
-	if (exact == EXACT)
-		return regs_exact(rold, rcur, idmap);
-
-	if (rold->type == NOT_INIT)
-		/* explored state can't have used this */
-		return true;
-
-	/* Enforce that register types have to match exactly, including their
-	 * modifiers (like PTR_MAYBE_NULL, MEM_RDONLY, etc), as a general
-	 * rule.
-	 *
-	 * One can make a point that using a pointer register as unbounded
-	 * SCALAR would be technically acceptable, but this could lead to
-	 * pointer leaks because scalars are allowed to leak while pointers
-	 * are not. We could make this safe in special cases if root is
-	 * calling us, but it's probably not worth the hassle.
-	 *
-	 * Also, register types that are *not* MAYBE_NULL could technically be
-	 * safe to use as their MAYBE_NULL variants (e.g., PTR_TO_MAP_VALUE
-	 * is safe to be used as PTR_TO_MAP_VALUE_OR_NULL, provided both point
-	 * to the same map).
-	 * However, if the old MAYBE_NULL register then got NULL checked,
-	 * doing so could have affected others with the same id, and we can't
-	 * check for that because we lost the id when we converted to
-	 * a non-MAYBE_NULL variant.
-	 * So, as a general rule we don't allow mixing MAYBE_NULL and
-	 * non-MAYBE_NULL registers as well.
-	 */
-	if (rold->type != rcur->type)
-		return false;
-
-	switch (base_type(rold->type)) {
-	case SCALAR_VALUE:
-		if (env->explore_alu_limits) {
-			/* explore_alu_limits disables tnum_in() and range_within()
-			 * logic and requires everything to be strict
-			 */
-			return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
-			       check_scalar_ids(rold->id, rcur->id, idmap);
-		}
-		if (!rold->precise && exact == NOT_EXACT)
-			return true;
-		/*
-		 * Linked register tracking uses rold->id to detect relationships.
-		 * When rold->id == 0, the register is independent and any linking
-		 * in rcur only adds constraints. When rold->id != 0, we must verify
-		 * id mapping and (for BPF_ADD_CONST) offset consistency.
-		 *
-		 * +------------------+-----------+------------------+---------------+
-		 * |                  | rold->id  | rold + ADD_CONST | rold->id == 0 |
-		 * |------------------+-----------+------------------+---------------|
-		 * | rcur->id         | range,ids | false            | range         |
-		 * | rcur + ADD_CONST | false     | range,ids,off    | range         |
-		 * | rcur->id == 0    | range,ids | false            | range         |
-		 * +------------------+-----------+------------------+---------------+
-		 *
-		 * Why check_ids() for scalar registers?
-		 *
-		 * Consider the following BPF code:
-		 *   1: r6 = ... unbound scalar, ID=a ...
-		 *   2: r7 = ... unbound scalar, ID=b ...
-		 *   3: if (r6 > r7) goto +1
-		 *   4: r6 = r7
-		 *   5: if (r6 > X) goto ...
-		 *   6: ... memory operation using r7 ...
-		 *
-		 * First verification path is [1-6]:
-		 * - at (4) same bpf_reg_state::id (b) would be assigned to r6 and r7;
-		 * - at (5) r6 would be marked <= X, sync_linked_regs() would also mark
-		 *   r7 <= X, because r6 and r7 share same id.
-		 * Next verification path is [1-4, 6].
-		 *
-		 * Instruction (6) would be reached in two states:
-		 *   I.  r6{.id=b}, r7{.id=b} via path 1-6;
-		 *   II. r6{.id=a}, r7{.id=b} via path 1-4, 6.
-		 *
-		 * Use check_ids() to distinguish these states.
-		 * ---
-		 * Also verify that new value satisfies old value range knowledge.
-		 */
-
-		/*
-		 * ADD_CONST flags must match exactly: BPF_ADD_CONST32 and
-		 * BPF_ADD_CONST64 have different linking semantics in
-		 * sync_linked_regs() (alu32 zero-extends, alu64 does not),
-		 * so pruning across different flag types is unsafe.
-		 */
-		if (rold->id &&
-		    (rold->id & BPF_ADD_CONST) != (rcur->id & BPF_ADD_CONST))
-			return false;
-
-		/* Both have offset linkage: offsets must match */
-		if ((rold->id & BPF_ADD_CONST) && rold->delta != rcur->delta)
-			return false;
-
-		if (!check_scalar_ids(rold->id, rcur->id, idmap))
-			return false;
-
-		return range_within(rold, rcur) && tnum_in(rold->var_off, rcur->var_off);
-	case PTR_TO_MAP_KEY:
-	case PTR_TO_MAP_VALUE:
-	case PTR_TO_MEM:
-	case PTR_TO_BUF:
-	case PTR_TO_TP_BUFFER:
-		/* If the new min/max/var_off satisfy the old ones and
-		 * everything else matches, we are OK.
-		 */
-		return memcmp(rold, rcur, offsetof(struct bpf_reg_state, var_off)) == 0 &&
-		       range_within(rold, rcur) &&
-		       tnum_in(rold->var_off, rcur->var_off) &&
-		       check_ids(rold->id, rcur->id, idmap) &&
-		       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
-	case PTR_TO_PACKET_META:
-	case PTR_TO_PACKET:
-		/* We must have at least as much range as the old ptr
-		 * did, so that any accesses which were safe before are
-		 * still safe.  This is true even if old range < old off,
-		 * since someone could have accessed through (ptr - k), or
-		 * even done ptr -= k in a register, to get a safe access.
-		 */
-		if (rold->range < 0 || rcur->range < 0) {
-			/* special case for [BEYOND|AT]_PKT_END */
-			if (rold->range != rcur->range)
-				return false;
-		} else if (rold->range > rcur->range) {
-			return false;
-		}
-		/* id relations must be preserved */
-		if (!check_ids(rold->id, rcur->id, idmap))
-			return false;
-		/* new val must satisfy old val knowledge */
-		return range_within(rold, rcur) &&
-		       tnum_in(rold->var_off, rcur->var_off);
-	case PTR_TO_STACK:
-		/* two stack pointers are equal only if they're pointing to
-		 * the same stack frame, since fp-8 in foo != fp-8 in bar
-		 */
-		return regs_exact(rold, rcur, idmap) && rold->frameno == rcur->frameno;
-	case PTR_TO_ARENA:
-		return true;
-	case PTR_TO_INSN:
-		return memcmp(rold, rcur, offsetof(struct bpf_reg_state, var_off)) == 0 &&
-		       range_within(rold, rcur) && tnum_in(rold->var_off, rcur->var_off);
-	default:
-		return regs_exact(rold, rcur, idmap);
-	}
-}
-
-static struct bpf_reg_state unbound_reg;
-
-static __init int unbound_reg_init(void)
-{
-	__mark_reg_unknown_imprecise(&unbound_reg);
-	return 0;
-}
-late_initcall(unbound_reg_init);
-
-static bool is_stack_misc_after(struct bpf_verifier_env *env,
-				struct bpf_stack_state *stack, int im)
-{
-	u32 i;
-
-	for (i = im; i < ARRAY_SIZE(stack->slot_type); ++i) {
-		if ((stack->slot_type[i] == STACK_MISC) ||
-		    ((stack->slot_type[i] == STACK_INVALID || stack->slot_type[i] == STACK_POISON) &&
-		     env->allow_uninit_stack))
-			continue;
-		return false;
-	}
-
-	return true;
-}
-
-static struct bpf_reg_state *scalar_reg_for_stack(struct bpf_verifier_env *env,
-						  struct bpf_stack_state *stack, int im)
-{
-	if (is_spilled_scalar_after(stack, im))
-		return &stack->spilled_ptr;
-
-	if (is_stack_misc_after(env, stack, im))
-		return &unbound_reg;
-
-	return NULL;
-}
-
-static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
-		      struct bpf_func_state *cur, struct bpf_idmap *idmap,
-		      enum exact_level exact)
-{
-	int i, spi;
-
-	/* walk slots of the explored stack and ignore any additional
-	 * slots in the current stack, since explored(safe) state
-	 * didn't use them
-	 */
-	for (i = 0; i < old->allocated_stack; i++) {
-		struct bpf_reg_state *old_reg, *cur_reg;
-		int im = i % BPF_REG_SIZE;
-
-		spi = i / BPF_REG_SIZE;
-
-		if (exact == EXACT) {
-			u8 old_type = old->stack[spi].slot_type[i % BPF_REG_SIZE];
-			u8 cur_type = i < cur->allocated_stack ?
-				      cur->stack[spi].slot_type[i % BPF_REG_SIZE] : STACK_INVALID;
-
-			/* STACK_INVALID and STACK_POISON are equivalent for pruning */
-			if (old_type == STACK_POISON)
-				old_type = STACK_INVALID;
-			if (cur_type == STACK_POISON)
-				cur_type = STACK_INVALID;
-			if (i >= cur->allocated_stack || old_type != cur_type)
-				return false;
-		}
-
-		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_INVALID ||
-		    old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_POISON)
-			continue;
-
-		if (env->allow_uninit_stack &&
-		    old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_MISC)
-			continue;
-
-		/* explored stack has more populated slots than current stack
-		 * and these slots were used
-		 */
-		if (i >= cur->allocated_stack)
-			return false;
-
-		/*
-		 * 64 and 32-bit scalar spills vs MISC/INVALID slots and vice versa.
-		 * Load from MISC/INVALID slots produces unbound scalar.
-		 * Construct a fake register for such stack and call
-		 * regsafe() to ensure scalar ids are compared.
-		 */
-		if (im == 0 || im == 4) {
-			old_reg = scalar_reg_for_stack(env, &old->stack[spi], im);
-			cur_reg = scalar_reg_for_stack(env, &cur->stack[spi], im);
-			if (old_reg && cur_reg) {
-				if (!regsafe(env, old_reg, cur_reg, idmap, exact))
-					return false;
-				i += (im == 0 ? BPF_REG_SIZE - 1 : 3);
-				continue;
-			}
-		}
-
-		/* if old state was safe with misc data in the stack
-		 * it will be safe with zero-initialized stack.
-		 * The opposite is not true
-		 */
-		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_MISC &&
-		    cur->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_ZERO)
-			continue;
-		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] !=
-		    cur->stack[spi].slot_type[i % BPF_REG_SIZE])
-			/* Ex: old explored (safe) state has STACK_SPILL in
-			 * this stack slot, but current has STACK_MISC ->
-			 * this verifier states are not equivalent,
-			 * return false to continue verification of this path
-			 */
-			return false;
-		if (i % BPF_REG_SIZE != BPF_REG_SIZE - 1)
-			continue;
-		/* Both old and cur are having same slot_type */
-		switch (old->stack[spi].slot_type[BPF_REG_SIZE - 1]) {
-		case STACK_SPILL:
-			/* when explored and current stack slot are both storing
-			 * spilled registers, check that stored pointers types
-			 * are the same as well.
-			 * Ex: explored safe path could have stored
-			 * (bpf_reg_state) {.type = PTR_TO_STACK, .off = -8}
-			 * but current path has stored:
-			 * (bpf_reg_state) {.type = PTR_TO_STACK, .off = -16}
-			 * such verifier states are not equivalent.
-			 * return false to continue verification of this path
-			 */
-			if (!regsafe(env, &old->stack[spi].spilled_ptr,
-				     &cur->stack[spi].spilled_ptr, idmap, exact))
-				return false;
-			break;
-		case STACK_DYNPTR:
-			old_reg = &old->stack[spi].spilled_ptr;
-			cur_reg = &cur->stack[spi].spilled_ptr;
-			if (old_reg->dynptr.type != cur_reg->dynptr.type ||
-			    old_reg->dynptr.first_slot != cur_reg->dynptr.first_slot ||
-			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
-				return false;
-			break;
-		case STACK_ITER:
-			old_reg = &old->stack[spi].spilled_ptr;
-			cur_reg = &cur->stack[spi].spilled_ptr;
-			/* iter.depth is not compared between states as it
-			 * doesn't matter for correctness and would otherwise
-			 * prevent convergence; we maintain it only to prevent
-			 * infinite loop check triggering, see
-			 * iter_active_depths_differ()
-			 */
-			if (old_reg->iter.btf != cur_reg->iter.btf ||
-			    old_reg->iter.btf_id != cur_reg->iter.btf_id ||
-			    old_reg->iter.state != cur_reg->iter.state ||
-			    /* ignore {old_reg,cur_reg}->iter.depth, see above */
-			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
-				return false;
-			break;
-		case STACK_IRQ_FLAG:
-			old_reg = &old->stack[spi].spilled_ptr;
-			cur_reg = &cur->stack[spi].spilled_ptr;
-			if (!check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap) ||
-			    old_reg->irq.kfunc_class != cur_reg->irq.kfunc_class)
-				return false;
-			break;
-		case STACK_MISC:
-		case STACK_ZERO:
-		case STACK_INVALID:
-		case STACK_POISON:
-			continue;
-		/* Ensure that new unhandled slot types return false by default */
-		default:
-			return false;
-		}
-	}
-	return true;
-}
-
-static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *cur,
-		    struct bpf_idmap *idmap)
-{
-	int i;
-
-	if (old->acquired_refs != cur->acquired_refs)
-		return false;
-
-	if (old->active_locks != cur->active_locks)
-		return false;
-
-	if (old->active_preempt_locks != cur->active_preempt_locks)
-		return false;
-
-	if (old->active_rcu_locks != cur->active_rcu_locks)
-		return false;
-
-	if (!check_ids(old->active_irq_id, cur->active_irq_id, idmap))
-		return false;
-
-	if (!check_ids(old->active_lock_id, cur->active_lock_id, idmap) ||
-	    old->active_lock_ptr != cur->active_lock_ptr)
-		return false;
-
-	for (i = 0; i < old->acquired_refs; i++) {
-		if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap) ||
-		    old->refs[i].type != cur->refs[i].type)
-			return false;
-		switch (old->refs[i].type) {
-		case REF_TYPE_PTR:
-		case REF_TYPE_IRQ:
-			break;
-		case REF_TYPE_LOCK:
-		case REF_TYPE_RES_LOCK:
-		case REF_TYPE_RES_LOCK_IRQ:
-			if (old->refs[i].ptr != cur->refs[i].ptr)
-				return false;
-			break;
-		default:
-			WARN_ONCE(1, "Unhandled enum type for reference state: %d\n", old->refs[i].type);
-			return false;
-		}
-	}
-
-	return true;
-}
-
-/* compare two verifier states
- *
- * all states stored in state_list are known to be valid, since
- * verifier reached 'bpf_exit' instruction through them
- *
- * this function is called when verifier exploring different branches of
- * execution popped from the state stack. If it sees an old state that has
- * more strict register state and more strict stack state then this execution
- * branch doesn't need to be explored further, since verifier already
- * concluded that more strict state leads to valid finish.
- *
- * Therefore two states are equivalent if register state is more conservative
- * and explored stack state is more conservative than the current one.
- * Example:
- *       explored                   current
- * (slot1=INV slot2=MISC) == (slot1=MISC slot2=MISC)
- * (slot1=MISC slot2=MISC) != (slot1=INV slot2=MISC)
- *
- * In other words if current stack state (one being explored) has more
- * valid slots than old one that already passed validation, it means
- * the verifier can stop exploring and conclude that current state is valid too
- *
- * Similarly with registers. If explored state has register type as invalid
- * whereas register type in current state is meaningful, it means that
- * the current state will reach 'bpf_exit' instruction safely
- */
-static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_state *old,
-			      struct bpf_func_state *cur, u32 insn_idx, enum exact_level exact)
-{
-	u16 live_regs = env->insn_aux_data[insn_idx].live_regs_before;
-	u16 i;
-
-	if (old->callback_depth > cur->callback_depth)
-		return false;
-
-	for (i = 0; i < MAX_BPF_REG; i++)
-		if (((1 << i) & live_regs) &&
-		    !regsafe(env, &old->regs[i], &cur->regs[i],
-			     &env->idmap_scratch, exact))
-			return false;
-
-	if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
-		return false;
-
-	return true;
-}
-
-static void reset_idmap_scratch(struct bpf_verifier_env *env)
-{
-	struct bpf_idmap *idmap = &env->idmap_scratch;
-
-	idmap->tmp_id_gen = env->id_gen;
-	idmap->cnt = 0;
-}
-
-static bool states_equal(struct bpf_verifier_env *env,
-			 struct bpf_verifier_state *old,
-			 struct bpf_verifier_state *cur,
-			 enum exact_level exact)
-{
-	u32 insn_idx;
-	int i;
-
-	if (old->curframe != cur->curframe)
-		return false;
-
-	reset_idmap_scratch(env);
-
-	/* Verification state from speculative execution simulation
-	 * must never prune a non-speculative execution one.
-	 */
-	if (old->speculative && !cur->speculative)
-		return false;
-
-	if (old->in_sleepable != cur->in_sleepable)
-		return false;
-
-	if (!refsafe(old, cur, &env->idmap_scratch))
-		return false;
-
-	/* for states to be equal callsites have to be the same
-	 * and all frame states need to be equivalent
-	 */
-	for (i = 0; i <= old->curframe; i++) {
-		insn_idx = frame_insn_idx(old, i);
-		if (old->frame[i]->callsite != cur->frame[i]->callsite)
-			return false;
-		if (!func_states_equal(env, old->frame[i], cur->frame[i], insn_idx, exact))
-			return false;
-	}
-	return true;
-}
-
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
-			bt_set_frame_reg(&env->bt, fr, i);
-			first = false;
-		}
-
-		for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
-			if (!is_spilled_reg(&state->stack[i]))
-				continue;
-			state_reg = &state->stack[i].spilled_ptr;
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
-			bt_set_frame_slot(&env->bt, fr, i);
-			first = false;
-		}
-		if (!first && (env->log.level & BPF_LOG_LEVEL2))
-			verbose(env, "\n");
-	}
-
-	err = __mark_chain_precision(env, cur, -1, changed);
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
-				mark_all_scalars_precise(env, &backedge->state);
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
-	free_backedges(visit);
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
-			   offsetof(struct bpf_reg_state, frameno)))
-			return false;
-	return true;
-}
-
-static bool is_iter_next_insn(struct bpf_verifier_env *env, int insn_idx)
-{
-	return env->insn_aux_data[insn_idx].is_iter_next;
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
-		for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
-			if (state->stack[i].slot_type[0] != STACK_ITER)
-				continue;
-
-			slot = &state->stack[i].spilled_ptr;
-			if (slot->iter.state != BPF_ITER_STATE_ACTIVE)
-				continue;
-
-			cur_slot = &cur->frame[fr]->stack[i].spilled_ptr;
-			if (cur_slot->iter.depth != slot->iter.depth)
-				return true;
-		}
-	}
-	return false;
-}
-
-static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
-{
-	struct bpf_verifier_state_list *new_sl;
-	struct bpf_verifier_state_list *sl;
-	struct bpf_verifier_state *cur = env->cur_state, *new;
-	bool force_new_state, add_new_state, loop;
-	int n, err, states_cnt = 0;
-	struct list_head *pos, *tmp, *head;
-
-	force_new_state = env->test_state_freq || bpf_is_force_checkpoint(env, insn_idx) ||
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
-	head = explored_state(env, insn_idx);
-	list_for_each_safe(pos, tmp, head) {
-		sl = container_of(pos, struct bpf_verifier_state_list, node);
-		states_cnt++;
-		if (sl->state.insn_idx != insn_idx)
-			continue;
-
-		if (sl->state.branches) {
-			struct bpf_func_state *frame = sl->state.frame[sl->state.curframe];
-
-			if (frame->in_async_callback_fn &&
-			    frame->async_entry_cnt != cur->frame[cur->curframe]->async_entry_cnt) {
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
-					struct bpf_func_state *cur_frame;
-					struct bpf_reg_state *iter_state, *iter_reg;
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
-					spi = __get_spi(iter_reg->var_off.value);
-					iter_state = &func(env, iter_reg)->stack[spi].spilled_ptr;
-					if (iter_state->iter.state == BPF_ITER_STATE_ACTIVE) {
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
-			if (is_jmp_point(env, env->insn_idx))
-				err = push_jmp_history(env, cur, 0, 0);
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
-			 *   from `update_branch_counts()`. For states with `branches == 0`, it
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
-				err = copy_verifier_state(&backedge->state, cur);
-				backedge->state.equal_state = &sl->state;
-				backedge->state.insn_idx = insn_idx;
-				err = err ?: add_scc_backedge(env, &sl->state, backedge);
-				if (err) {
-					free_verifier_state(&backedge->state, false);
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
-		n = bpf_is_force_checkpoint(env, insn_idx) && sl->state.branches > 0 ? 64 : 3;
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
-	clear_singular_ids(env, cur);
-
-	/* add new state to the head of linked list */
-	new = &new_sl->state;
-	err = copy_verifier_state(new, cur);
-	if (err) {
-		free_verifier_state(new, false);
-		kfree(new_sl);
-		return err;
-	}
-	new->insn_idx = insn_idx;
-	verifier_bug_if(new->branches != 1, env,
-			"%s:branches_to_explore=%d insn %d",
-			__func__, new->branches, insn_idx);
-	err = maybe_enter_scc(env, new);
-	if (err) {
-		free_verifier_state(new, false);
-		kfree(new_sl);
-		return err;
-	}
-
-	cur->parent = new;
-	cur->first_insn_idx = insn_idx;
-	cur->dfs_depth = new->dfs_depth + 1;
-	clear_jmp_history(cur);
-	list_add(&new_sl->node, head);
-	return 0;
-}
 
-/* Return true if it's OK to have the same insn return a different type. */
 static bool reg_type_mismatch_ok(enum bpf_reg_type type)
 {
 	switch (base_type(type)) {
@@ -20686,7 +19073,7 @@ static int do_check(struct bpf_verifier_env *env)
 		state->insn_idx = env->insn_idx;
 
 		if (bpf_is_prune_point(env, env->insn_idx)) {
-			err = is_state_visited(env, env->insn_idx);
+			err = bpf_is_state_visited(env, env->insn_idx);
 			if (err < 0)
 				return err;
 			if (err == 1) {
@@ -20704,8 +19091,8 @@ static int do_check(struct bpf_verifier_env *env)
 			}
 		}
 
-		if (is_jmp_point(env, env->insn_idx)) {
-			err = push_jmp_history(env, state, 0, 0);
+		if (bpf_is_jmp_point(env, env->insn_idx)) {
+			err = bpf_push_jmp_history(env, state, 0, 0);
 			if (err)
 				return err;
 		}
@@ -20816,7 +19203,7 @@ static int do_check(struct bpf_verifier_env *env)
 				return -EFAULT;
 process_bpf_exit:
 			mark_verifier_state_scratched(env);
-			err = update_branch_counts(env, env->cur_state);
+			err = bpf_update_branch_counts(env, env->cur_state);
 			if (err)
 				return err;
 			err = pop_stack(env, &prev_insn_idx, &env->insn_idx,
@@ -21623,13 +20010,13 @@ static void free_states(struct bpf_verifier_env *env)
 	struct bpf_scc_info *info;
 	int i, j;
 
-	free_verifier_state(env->cur_state, true);
+	bpf_free_verifier_state(env->cur_state, true);
 	env->cur_state = NULL;
 	while (!pop_stack(env, NULL, NULL, false));
 
 	list_for_each_safe(pos, tmp, &env->free_list) {
 		sl = container_of(pos, struct bpf_verifier_state_list, node);
-		free_verifier_state(&sl->state, false);
+		bpf_free_verifier_state(&sl->state, false);
 		kfree(sl);
 	}
 	INIT_LIST_HEAD(&env->free_list);
@@ -21639,7 +20026,7 @@ static void free_states(struct bpf_verifier_env *env)
 		if (!info)
 			continue;
 		for (j = 0; j < info->num_visits; j++)
-			free_backedges(&info->visits[j]);
+			bpf_free_backedges(&info->visits[j]);
 		kvfree(info);
 		env->scc_info[i] = NULL;
 	}
@@ -21652,7 +20039,7 @@ static void free_states(struct bpf_verifier_env *env)
 
 		list_for_each_safe(pos, tmp, head) {
 			sl = container_of(pos, struct bpf_verifier_state_list, node);
-			free_verifier_state(&sl->state, false);
+			bpf_free_verifier_state(&sl->state, false);
 			kfree(sl);
 		}
 		INIT_LIST_HEAD(&env->explored_states[i]);
-- 
2.52.0

