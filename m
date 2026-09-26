Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9A347AF57
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432466; cv=none; b=Yr6dJPRQHEDBm7v8k9ezYSyY1uWXEIkpV9etWZsxw0VCqKfuwIMyuIRiwu1K8i9A0xsQ1NjzKW7uDwtuM5O8lfrs/Dt4s/U48tdPxv2b9QuD1chYftJAWJYRKV7vMY6A8NC2oGXHDC5LwS/9e4BClP0LCF5sx88XrCwHmNQBE2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432466; c=relaxed/simple;
	bh=iVqBRu83NacnzgFnXrgRdPeHcvdhH7iha6JknDxF29Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxbfR3JDpZzQaBQhXHCjoHXhtASbtJ2Owml98qLPHfMzBjBs+I3xQMwmgqCAYUaKo+mSyJBrX1CBYe9BJ5ABc7ZYJ/ZakL6/q2Hrllujwbh7uVnzXEnfXZ8qJzN+usJs2Cpn47SSibzGx3PABs0eb8KrNjq66PhFc2j24FZGCqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/MbGTqs; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/MbGTqs"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fbef5018so11884995ad.0
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432464; x=1791037264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MkjDo6o7rFYlgEedVhRyUuauh4ZC1R4yIpg6+ChLbLE=;
        b=h/MbGTqs6C4buwfs3M+CrVj5ch+oy/lfOrVo5HSbKJlLriXIYjJ7N8d7wUfLkKOzJ/
         75nUkKTlpzSFvEe2DEZGqj3tAQe1en6+fqSy2RENbhu/Vl2kZUGY/eVuq4lriRuS70pE
         dJQGW5saxMMgKKlQlgh9In/1Vsv6VfeTiq85FqncOvselKv2oMdHDeyuVru7+QD/vVQi
         P5K8nTj+UQfENnuFOdoR4Qx0YfrvNSlK4vUCQtjHJycw/SpZK8xKhYGXo8klPt2YT6L0
         N1BH/i2M+Sn8SxTD3ol0fVit1btgT7eQVlbjvqVsf65/mUkUfzQ6bQqjinQvyL+Pyuwe
         3SoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432464; x=1791037264;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MkjDo6o7rFYlgEedVhRyUuauh4ZC1R4yIpg6+ChLbLE=;
        b=hNJK6TenE4zK1jnJKk1CK6FFTsnlYhxxfx4751IXxKI8t6zZr0ejN+kFLKt3zSOuUb
         EoksIzogtXiOc6Au/pyXsdzTEoyNQU9B4ACDbhfJL8pucutDWyQrNDPQw/AtvnU11Pfu
         ZECEWlV87/2uZxeBSsy/wvRCNJuQgwJ9hUDqeuafhgNiwWJr/hL1kJYS7/7BuCLOvbW3
         HP13OODk2JqDCgDPw94WXfivVahUsRU6V8ynnzfb8LqbFczxsAXxXOYVLLGtZKZTlYuE
         frq8//bh+Efn7hPhJwRNpVf9iJgYCGFW9SKFDeEvLc4NuY4wCrrVp9VdGKrnDmmuKYGV
         O74g==
X-Gm-Message-State: AFq9FYKjSAQ1KnJqRqo9BMjKXlzcjHZ1vg9Dr6lc1PXeq2dHazz4Yi4i
	5JYOdvG7SbPE9my5juwrzTcvzTFZDN9EW9bsxIGE9w+kqjxVnuqqGBQAUHAvolS0+1I=
X-Gm-Gg: AYBFou3mik1S9OUFZSnNC6jZRSRMjjSnfzcugT37ZMLq4blg3F8IjOaRHrVhPBctXag
	fl0jawaF7/LBTD18hsA+jFMuv7t0rcqSCEmmHSaJeVYe6nY5SbufkZtFyp1SJwbFrC6pO6AdNkv
	2MtU8Sg58ieLkhA9qfSOjQpWNysA5Dz+y7oM0n7Z2YIZmihh76Qq0u9I16y+rjy/WlzV5apKLTb
	ZQ1EA88MpTKc9NGnsZFGXVV3yzFRwLbGkYGvPkcvqfeIkoeGKeblJmS47hECQikw+RbtwjtaUOo
	PvLi4hmy0+fO8b3Fwm3EWXeSs6+QAQnGzxwnls1EeKZSP3PXkIVw4VEs2ODRzx++KLw1vYzZb89
	tSYKLMB7HQZVt0TMlCoAGF7xgBAAPcvWvluAsQq38Ap4g9W9LGtvFM9vcqrLNLOvvztD1aqwk+n
	zXYOqdEXLrC+4eKEjr9zHux5NWCb6doV71C0k2egIZ4XfcNAJhHxOmRLcKyPM5wn1Y3j9SOUsM4
	B9+6e+mNVbI7486Bn13cRkficm/xYCtBJ0OE7+aow==
X-Received: by 2002:a17:90b:4c03:b0:39e:6a82:afd6 with SMTP id 98e67ed59e1d1-3a098feb5abmr7279514a91.40.1790432464025;
        Sat, 26 Sep 2026 07:21:04 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:21:03 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 19/36] bpf: compute loop hierarchy
Date: Sat, 26 Sep 2026 07:20:17 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-19-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

SCEV needs to process loops from innermost to outermost, summarizing
results for nested loops. Add a pass to compute the loop structure.

Use a non-recursive adaptation of the algorithm from:
"A New Algorithm for Identifying Loops in Decompilation" by Wei et al.

Record the loop hierarchy per instruction:
- The field insn_aux_data->loop_header records the innermost loop
  header containing it.
- The field insn_aux_data->loop records additional information about
  the loop if this instruction is a loop header (exits, backedges,
  irreducibility).

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  39 ++++
 kernel/bpf/fixups.c          |  18 ++
 kernel/bpf/loops.c           | 414 +++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |  12 +-
 4 files changed, 482 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5e6fa41a1353..d8142f1b2347 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -655,6 +655,30 @@ struct bpf_iarray {
 	     ___idx < (arr)->cnt && ({ item = (arr)->items[___idx]; 1; });	\
 	     ___idx++)
 
+#define MAX_BACKEDGES 16
+#define MAX_LOOP_EXITS 256
+
+struct bpf_backedge {
+	int from;
+	int latch; /* -1 if no latch can be found */
+};
+
+struct bpf_loop_exit {
+	int from; /* instruction inside the loop */
+	int to; /* instruction outside the loop */
+};
+
+struct bpf_loop {
+	struct bpf_backedge backedges[MAX_BACKEDGES];
+	/* edges exiting from this loop, includes edges from nested loops */
+	struct bpf_loop_exit *exits;
+	int backedges_cnt;
+	int exits_cnt;
+	bool irreducible;
+	bool backedges_overflow;
+	bool exits_overflow;
+};
+
 struct bpf_insn_aux_data {
 	union {
 		enum bpf_reg_type ptr_type;	/* pointer type for load/store insns */
@@ -732,6 +756,13 @@ struct bpf_insn_aux_data {
 	u32 non_stack_access:1; /* instruction can access non-stack memory */
 	/* true if some jump or call instruction targets this instruction */
 	u32 jump_target:1;
+	/*
+	 * True if this instruction is a loop entry. For loops with a single entry
+	 * this bit will coincide with 'loop' pointer being non-NULL.
+	 * Irreducible loops have multiple entries, all of them will be marked as 'loop_entry',
+	 * but only the one at 'loop_header' will have a non-NULL 'loop' pointer.
+	 */
+	u32 loop_entry:1;
 	/*
 	 * CFG strongly connected component this instruction belongs to,
 	 * zero if it is a singleton SCC.
@@ -751,6 +782,10 @@ struct bpf_insn_aux_data {
 	u16 const_reg_map_mask;
 	u16 const_reg_subprog_mask;
 	u32 const_reg_vals[10];
+	/* index of a loop header of the innermost loop containing this instruction, -1 if none */
+	s32 loop_header;
+	/* additional information about the loop if this instruction is a loop header */
+	struct bpf_loop *loop;
 };
 
 #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
@@ -1860,6 +1895,7 @@ int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 bt
 				  struct bpf_attach_target_info *tgt_info);
 
 /* Functions in fixups.c, called from bpf_check() */
+void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len);
 int bpf_remove_fastcall_spills_fills(struct bpf_verifier_env *env);
 int bpf_optimize_bpf_loop(struct bpf_verifier_env *env);
 void bpf_opt_hard_wire_dead_code_branches(struct bpf_verifier_env *env);
@@ -1876,5 +1912,8 @@ int bpf_flip_opcode(u32 opcode);
 u8 bpf_rev_opcode(u8 opcode);
 
 int bpf_compute_idoms(struct bpf_verifier_env *env);
+int bpf_compute_loops(struct bpf_verifier_env *env);
+int bpf_loop_at_index(struct bpf_verifier_env *env, u32 idx);
+bool bpf_is_nested_loop(struct bpf_verifier_env *env, int inner_header, int outer_header);
 
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 37cf130ebb57..ecea117f2848 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -614,6 +614,22 @@ static int bpf_adj_linfo_after_remove(struct bpf_verifier_env *env, u32 off,
 	return 0;
 }
 
+/* Clean up dynamically allocated fields of aux data for instructions [start, ...] */
+void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len)
+{
+	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
+	int end = start + len;
+	int i;
+
+	for (i = start; i < end; i++) {
+		if (aux_data[i].loop) {
+			kvfree(aux_data[i].loop->exits);
+			kvfree(aux_data[i].loop);
+			aux_data[i].loop = NULL;
+		}
+	}
+}
+
 static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 {
 	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
@@ -626,6 +642,8 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 	if (bpf_prog_is_offloaded(env->prog->aux))
 		bpf_prog_offload_remove_insns(env, off, cnt);
 
+	bpf_clear_insn_aux_data(env, off, cnt);
+
 	err = bpf_remove_insns(env->prog, off, cnt);
 	if (err)
 		return err;
diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
index e7ff02e9ab3a..e269870f6a6e 100644
--- a/kernel/bpf/loops.c
+++ b/kernel/bpf/loops.c
@@ -141,3 +141,417 @@ int bpf_compute_idoms(struct bpf_verifier_env *env)
 	kvfree(preds);
 	return 0;
 }
+
+struct dfs_state {
+	u32 traversed:1;
+	u32 next_succ:31;
+};
+
+struct loops_dfs {
+	struct dfs_state *state;
+	int *dfs_pos;
+	int *stack;
+};
+
+static void mark_irreducible(struct bpf_verifier_env *env, int h)
+{
+	env->insn_aux_data[h].loop->irreducible = true;
+}
+
+static void mark_entry(struct bpf_verifier_env *env, int s)
+{
+	env->insn_aux_data[s].loop_entry = true;
+}
+
+static void add_backedge(struct bpf_verifier_env *env, int from, int h)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_loop *loop = aux[h].loop;
+	int cnt = loop->backedges_cnt;
+
+	if (cnt == MAX_BACKEDGES) {
+		loop->backedges_overflow = true;
+		return;
+	}
+	loop->backedges[cnt].from = from;
+	loop->backedges[cnt].latch = -1;
+	loop->backedges_cnt++;
+}
+
+static int add_exit(struct bpf_loop *loop, int from, int to)
+{
+	if (loop->exits_overflow)
+		return 0;
+	if (loop->exits_cnt == MAX_LOOP_EXITS) {
+		loop->exits_overflow = true;
+		return 0;
+	}
+	if (!loop->exits) {
+		loop->exits = kvcalloc(MAX_LOOP_EXITS, sizeof(*loop->exits), GFP_KERNEL_ACCOUNT);
+		if (!loop->exits)
+			return -ENOMEM;
+	}
+	loop->exits[loop->exits_cnt] = (struct bpf_loop_exit) {
+		.from = from,
+		.to = to,
+	};
+	loop->exits_cnt++;
+	return 0;
+}
+
+static int mark_as_header(struct bpf_verifier_env *env, int h)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+
+	if (!aux[h].loop) {
+		mark_entry(env, h);
+		aux[h].loop = kvzalloc_obj(struct bpf_loop, GFP_KERNEL_ACCOUNT);
+		if (!aux[h].loop)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
+static int assign_header(struct bpf_verifier_env *env, struct loops_dfs *dfs, int n, int h)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	int *dfs_pos = dfs->dfs_pos;
+	int err, nh;
+
+	err = mark_as_header(env, h);
+	if (err)
+		return err;
+
+	/* Don't encode self-loops, otherwise can't reflect loops nesting structure. */
+	if (n == h)
+		return 0;
+
+	/* Make sure that loop headers up the chain are sorted by dfs_pos. */
+	while (aux[n].loop_header != -1) {
+		nh = aux[n].loop_header;
+		if (nh == h)
+			return 0;
+		if (dfs_pos[nh] < dfs_pos[h]) {
+			aux[n].loop_header = h;
+			n = h;
+			h = nh;
+		} else {
+			n = nh;
+		}
+	}
+	aux[n].loop_header = h;
+	return 0;
+}
+
+static bool is_cond_jmp_insn(struct bpf_insn *insn)
+{
+	u8 class = BPF_CLASS(insn->code);
+	u8 opcode = BPF_OP(insn->code);
+
+	if (class != BPF_JMP && class != BPF_JMP32)
+		return false;
+
+	switch (opcode) {
+	case BPF_JEQ:
+	case BPF_JGE:
+	case BPF_JGT:
+	case BPF_JLE:
+	case BPF_JLT:
+	case BPF_JNE:
+	case BPF_JSET:
+	case BPF_JSGE:
+	case BPF_JSGT:
+	case BPF_JSLE:
+	case BPF_JSLT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+int bpf_loop_at_index(struct bpf_verifier_env *env, u32 idx)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+
+	return aux[idx].loop ? idx : aux[idx].loop_header;
+}
+
+static int find_dominating_condition(struct bpf_verifier_env *env, int n, int top)
+{
+	struct bpf_insn *insns = env->prog->insnsi;
+	int common_dom, n_loop, t_loop, f_loop;
+	int *idoms = env->idoms;
+
+	n_loop = bpf_loop_at_index(env, n);
+	common_dom = idoms_intersect(env, n, top);
+	if (common_dom != top)
+		return -1;
+	while (n >= 0) {
+		if (is_cond_jmp_insn(&insns[n]) && bpf_loop_at_index(env, n) == n_loop) {
+			t_loop = bpf_loop_at_index(env, n + insns[n].off + 1);
+			f_loop = bpf_loop_at_index(env, n + 1);
+			if (f_loop != n_loop && !bpf_is_nested_loop(env, f_loop, n_loop))
+				return n;
+			if (t_loop != n_loop && !bpf_is_nested_loop(env, t_loop, n_loop))
+				return n;
+		}
+		if (n == top)
+			break;
+		n = idoms[n];
+	}
+	return -1;
+}
+
+/*
+ * As described in "A New Algorithm for Identifying Loops in Decompilation" by Wei et al,
+ * adapted to be non-recursive.
+ */
+static int compute_loops_in_subprog(struct bpf_verifier_env *env, struct loops_dfs *dfs,
+				    int subprog_idx)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct dfs_state *state = dfs->state;
+	int start = env->subprog_info[subprog_idx].start;
+	int *dfs_pos = dfs->dfs_pos;
+	int *stack = dfs->stack;
+	int s, h, err, cur, stack_sz;
+	struct bpf_iarray *succ;
+	u32 i;
+
+	stack[0] = start;
+	state[start].traversed = true;
+	state[start].next_succ = 0;
+	dfs_pos[start] = 1;
+	stack_sz = 1;
+	i = 0;
+	do {
+		/*
+		 * The algorithm should be very fast in practice,
+		 * guard against pathological inputs, just in case.
+		 */
+		if ((++i % 1024) == 0) {
+			if (signal_pending(current))
+				return -EAGAIN;
+			cond_resched();
+		}
+
+		cur = stack[stack_sz - 1];
+		succ = bpf_insn_successors(env, cur);
+		if (state[cur].next_succ == succ->cnt) {
+			dfs_pos[cur] = 0;
+			stack_sz--;
+			continue;
+		}
+		s = succ->items[state[cur].next_succ];
+		if (!state[s].traversed) {
+			/* Case A:  start -> ... -> cur -> s [unexplored] */
+			state[s].traversed = true;
+			state[s].next_succ = 0;
+			stack[stack_sz] = s;
+			dfs_pos[s] = stack_sz + 1;
+			stack_sz++;
+			continue;
+		}
+		/* 's' is fully explored at this point */
+		if (dfs_pos[s]) {
+			/*
+			 * start -> ... -> s -> cur --.
+			 *                 ^          |
+			 *                 '----------'
+			 * Case B: 's' is in the current DFS path.
+			 */
+			err = assign_header(env, dfs, cur, s);
+			if (err)
+				return err;
+			add_backedge(env, cur, s);
+		} else if (aux[s].loop_header == -1) {
+			/*
+			 * start -> ... -> ... -> s -> ... -> end
+			 *           |            ^
+			 *           '---> cur ---'
+			 * Case C: 's' is explored, not in the current DFS path,
+			 * and not a part of any loop.
+			 */
+		} else if (dfs_pos[aux[s].loop_header]) {
+			/*
+			 *                 .----------------------.
+			 *                 v                      |
+			 * start -> ... -> h -> ... -> ... -> s --'
+			 *                       |            ^
+			 *	                 '---> cur ---'
+			 * Case D: 's' is explored, not in current DFS path,
+			 * but its innermost loop header is.
+			 */
+			err = assign_header(env, dfs, cur, aux[s].loop_header);
+			if (err)
+				return err;
+		} else {
+			/*
+			 * case E: 's' is explored, not in current DFS path,
+			 * its innermost loop header is not in current DFS path,
+			 * hence 's' is another entry into the same loop.
+			 */
+			h = aux[s].loop_header;
+			mark_irreducible(env, h);
+			mark_entry(env, s);
+			while (aux[h].loop_header != -1) {
+				h = aux[h].loop_header;
+				if (dfs_pos[h]) {
+					err = assign_header(env, dfs, cur, h);
+					if (err)
+						return err;
+					break;
+				}
+				mark_irreducible(env, h);
+			}
+		}
+		state[cur].next_succ++;
+	} while (stack_sz);
+
+	return 0;
+}
+
+bool bpf_is_nested_loop(struct bpf_verifier_env *env, int inner_header, int outer_header)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	int idx;
+
+	for (idx = inner_header; idx >= 0; idx = aux[idx].loop_header)
+		if (aux[idx].loop_header == outer_header)
+			return true;
+
+	return false;
+}
+
+int bpf_compute_loops(struct bpf_verifier_env *env)
+{
+	int i, j, s, t, iloop, sloop, err = 0, len = env->prog->len;
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_verifier_log *log = &env->log;
+	struct bpf_backedge *backedge;
+	struct loops_dfs dfs = {};
+	struct bpf_iarray *succ;
+	struct bpf_loop *loop;
+
+	dfs.dfs_pos = kvcalloc(len, sizeof(int), GFP_KERNEL_ACCOUNT);
+	dfs.state = kvcalloc(len, sizeof(struct dfs_state), GFP_KERNEL_ACCOUNT);
+	dfs.stack = kvcalloc(len, sizeof(int), GFP_KERNEL_ACCOUNT);
+	if (!dfs.dfs_pos || !dfs.state || !dfs.stack) {
+		err = -ENOMEM;
+		goto out;
+	}
+	for (i = 0; i < len; i++)
+		aux[i].loop_header = -1;
+	for (i = 0; i < env->subprog_cnt; i++) {
+		err = compute_loops_in_subprog(env, &dfs, i);
+		if (err)
+			goto out;
+	}
+	/* find latches */
+	for (i = 0; i < len; i++) {
+		loop = aux[i].loop;
+		if (!loop)
+			continue;
+		for (j = 0; j < loop->backedges_cnt; j++) {
+			backedge = &loop->backedges[j];
+			backedge->latch = find_dominating_condition(env, backedge->from, i);
+		}
+	}
+	/* find exits */
+	for (i = 0; i < len; i++) {
+		iloop = aux[i].loop ? i : aux[i].loop_header;
+		if (iloop < 0)
+			continue;
+		succ = bpf_insn_successors(env, i);
+		iarray_for_each(s, succ) {
+			/*
+			 * Nothing left to record once the innermost loop of 'i'
+			 * overflowed: the walk below would stop at it right away.
+			 */
+			if (aux[iloop].loop->exits_overflow)
+				break;
+			sloop = aux[s].loop ? s : aux[s].loop_header;
+			if (iloop == sloop)
+				continue;
+			if (bpf_is_nested_loop(env, sloop, iloop))
+				continue;
+			/*
+			 * At this point 'sloop' is either -1, an outer loop,
+			 * or a loop in another branch of the loop hierarchy.
+			 */
+			for (t = iloop; t >= 0 && t != sloop; t = aux[t].loop_header) {
+				/*
+				 * Account for the following configuration:
+				 *
+				 *   tloop {
+				 *     iloop {
+				 *       ... i: goto s;
+				 *     }
+				 *     sloop {
+				 *   s:
+				 *       ...
+				 *     }
+				 *   }
+				 */
+				if (bpf_is_nested_loop(env, sloop, t))
+					break;
+				/*
+				 * Record edges i -> s as exits from tloop when:
+				 *
+				 *   sloop {
+				 *     tloop {
+				 *       iloop {
+				 *         ... i: goto s;
+				 *       }
+				 *     }
+				 *  s: ...
+				 *   }
+				 */
+				/* Enclosing loops inherit the overflow, see below */
+				if (aux[t].loop->exits_overflow)
+					break;
+				err = add_exit(aux[t].loop, i, s);
+				if (err)
+					goto out;
+			}
+		}
+		if (bpf_is_ldimm64(env->prog->insnsi + i))
+			i++;
+	}
+	/* A nested loop with a truncated exit list can't be abstracted by SCEV */
+	for (i = 0; i < len; i++) {
+		loop = aux[i].loop;
+		if (!loop || !loop->exits_overflow)
+			continue;
+		for (t = aux[i].loop_header; t >= 0; t = aux[t].loop_header)
+			aux[t].loop->exits_overflow = true;
+	}
+
+	if (env->log.level & BPF_LOG_LEVEL2) {
+		for (i = 0; i < len; i++) {
+			loop = aux[i].loop;
+			if (!loop)
+				continue;
+			bpf_log(log, "loop at %d", i);
+			if (aux[i].loop_header >= 0)
+				bpf_log(log, ", nested in %d", aux[i].loop_header);
+			if (loop->irreducible)
+				bpf_log(log, ", irreducible");
+			if (loop->exits_overflow)
+				bpf_log(log, ", too many exits");
+			bpf_log(log, "\n");
+			for (j = 0; j < loop->backedges_cnt; j++)
+				bpf_log(log, "  backedge from %d, latch at %d\n",
+					loop->backedges[j].from, loop->backedges[j].latch);
+			for (j = 0; j < loop->exits_cnt; j++)
+				bpf_log(log, "  exit from %d to %d\n",
+					loop->exits[j].from, loop->exits[j].to);
+		}
+	}
+
+out:
+	kvfree(dfs.dfs_pos);
+	kvfree(dfs.stack);
+	kvfree(dfs.state);
+	return err;
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 93100541475a..0d18b3bb0865 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22589,13 +22589,17 @@ static void log_program(struct bpf_verifier_env *env)
 	u64 pos, insn_pos;
 	u32 i, j;
 
-	verbose(env, "Program dump (scc? idom insn#: live_regs_before):\n");
+	verbose(env, "Program dump (scc? loop_header? idom insn#: live_regs_before):\n");
 	for (i = 0; i < insn_cnt; ++i) {
 		verbose_linfo(env, i, "    ; ");
 		if (env->insn_aux_data[i].scc)
 			verbose(env, "%3d ", env->insn_aux_data[i].scc);
 		else
 			verbose(env, "    ");
+		if (env->insn_aux_data[i].loop_header >= 0)
+			verbose(env, "%3d ", env->insn_aux_data[i].loop_header);
+		else
+			verbose(env, "    ");
 		verbose(env, "%3d ", env->idoms[i]);
 		verbose(env, "%3d: ", i);
 		for (j = BPF_REG_0; j < BPF_REG_10; ++j)
@@ -22820,6 +22824,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	ret = bpf_compute_loops(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = bpf_compute_live_registers(env);
 	if (ret < 0)
 		goto skip_full_check;
@@ -22972,6 +22980,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	release_btfs(env);
 err_free_env:
 	bpf_free_subprog_jts(env);
+	if (env->insn_aux_data)
+		bpf_clear_insn_aux_data(env, 0, env->insn_aux_data_len);
 	vfree(env->insn_aux_data);
 	kvfree(env->fd_array);
 	bpf_stack_liveness_free(env);

-- 
2.55.0
