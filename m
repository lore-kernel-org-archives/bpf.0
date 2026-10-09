Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E8A4C9DF3
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542931; cv=none; b=qP3PIWCn9Wa3pTSQcqSwne6Hug7tiEMcYLiw7KDVgeEnliQ3S8cHZ3R/PzXzSolKgtZym+/Mf2nNQtPsOshzv7wWSHaIAQqY1YqjJ6im0/ie1dmgIpoY7uyP3vTVfa+vgw2bk6z60Q72z7GkrBrmReGB1uv3tCn89UiAlG7cdYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542931; c=relaxed/simple;
	bh=VjNyqDgq9Kp41BJ9+IHr96Y2vpAwOWPIJsFb1Jj/PzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ut+fA36ZdcUGVscOw7MShVw9exZgHU/K42HARSW5zF+RLsech2gff8+yH7DsHovQ+gVHnMgThJVmi9yLHdfS5c9/ModDcK0HnPMvcuT4NADYH7oxCTG1hEsRNcCLCmhqUZDA3zoAOzXJtIWE/EuNbcyDxzNCqnViRaMlllrM63Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ov7ArJGX; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ov7ArJGX"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ccc6b11a19aso2222714a12.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542917; x=1792147717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=INxCcEvN+dvvZW88nxQzZ+/CKLMbZaFnNe4SzBZ7yPY=;
        b=Ov7ArJGXgdf9vfILwfBTkB+6ZSyKtBALVaxm1gQHdhpDTc7SNxLtKAAOuUR94u424t
         chinYCtr5WZ77wiT8BhTpXZlM3ei06hBWip/i/canx1ZGdG55Ds4A1xMY46EW2wagvpf
         eGxWZTKnwTcuPB7xYuGz/rwTdt0fyXa849JYP+qNvwFx63ZnpYSl3166/+tbkRI46iVr
         fz5e1GpsCzmRDv3OupCa1j99PkTo8Q63ImfQq0eCZYzzTC0kNjnGZyxM8mRgvyUWNAum
         xe2AKjShvdqn0NoMRb1IqbPJVctFa7Nc1xe9o73zdDlU14ZUYNcXjdXkUFx7NA2xmOks
         ckMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542917; x=1792147717;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=INxCcEvN+dvvZW88nxQzZ+/CKLMbZaFnNe4SzBZ7yPY=;
        b=o/7WDbfgnrDbPam3/zd+sVTkLuAJIQLCYXaD3U791FMlQZt9L6hlBB0ydjbo0YYXoq
         jl0oQMou21Gpl7aSiEOaSqXgw7oJp+g5rTXMgvqyAkVZMn1hFPA8eBiJRUv6P4UM9+5o
         BL4S9SZHOgEbiYbCK8bwkN6uQAm58zv23gbiI2FkfG4z1UI0REQgLoY1q0g3daaQQars
         bKrkMS1JkaL9EbRQ7+XINowaerhmsphopjy6Aqtf6Nxm/ebzsZnrEpyUYIiWS4/AMjNj
         kNQx2QicSu3DbuIu/wI3rYgAbj8Z052yNN0RAxRukCdWfoEGwtb01QLvonNbTRXMz7rG
         idtw==
X-Gm-Message-State: AFq9FYKUcemGGkyM9ukdhL4QMOj/DE31Nf5MNJY36Du4XtLtz+SL72sN
	OtkVtIJAdgBgYeiR48b1KQLijhm6u/2YS3oZmcoIgxntq5sz/Rf02mE/xTa2IQ==
X-Gm-Gg: AYBFou1kg+x2AG24Noh9DhqsiwZJf+XJ/v1hZ+1sI4/y7Lk5zbSJ6VE/axxQA8LYRQ/
	ghGRZvC9f94up0BjtMd1MRz/74tYBBIiiQZNMjduaynCxBJIJykFrSZt7FB2x2e7qrg2sVh9Pm9
	W14VRZSSNbcCAEAIAaO8ed4NU9YPCe+oRP6YqhlhqgwQcnOn37npRRB9eau+SX4moE/1utpoDyT
	fOdO6bhvXtMkX3sOdPej5SutCcqfLCPUCLlCERQDLezZ9pzSyjjIiqQSAcwriQBFgh7DGjbz+r4
	isj54bNMW5njRSkqYpMxZ7zMy7iaAYrUYOoY90Tr1n+YwspbhKmexuE+Fjce7DsPMqc/3xc9jRS
	cZ5uuna0jjh1l9Jd+a3OpVEVRTt7o2qfu5dCRQhKhiYvWorhNUwZW3hgsmD/v2Vyo3m93tqk2ub
	GoGtGEiBpoJeRSky58uPOeu2Y+mfyidird2aR2gvgtFs0+zVFgGLxunkGOFWOxxltANNy/1ycDs
	V1WisGGA60WHJg=
X-Received: by 2002:a17:90b:384b:b0:3a4:ca46:840f with SMTP id 98e67ed59e1d1-3ab3a94ff18mr1400989a91.8.1791542916999;
        Fri, 09 Oct 2026 03:48:36 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:36 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 24/51] bpf: compute loop hierarchy
Date: Fri,  9 Oct 2026 03:47:42 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-24-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
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
 include/linux/bpf_verifier.h |  46 +++++
 kernel/bpf/fixups.c          |  18 ++
 kernel/bpf/loops.c           | 439 +++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |  12 +-
 4 files changed, 514 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 59c0670af0e9..d1ebbfef5455 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -655,6 +655,41 @@ struct bpf_iarray {
 	     ___idx < (arr)->cnt && ({ item = (arr)->items[___idx]; 1; });	\
 	     ___idx++)
 
+#define MAX_BACKEDGES 16
+#define MAX_LOOP_EXITS 256
+
+/* Number of exit conditions dominating a backedge. */
+#define MAX_LATCHES 4
+
+struct bpf_backedge {
+	int from;
+	/*
+	 * Conditional jumps within the loop that dominate 'from' and have
+	 * a successor outside the loop, nearest first. latches[0] is the
+	 * latch; the remaining entries are additional exit conditions.
+	 * Each usable condition gives an upper bound on the iteration count,
+	 * so keeping only a subset is sound.
+	 */
+	int latches[MAX_LATCHES];
+	u8 latches_cnt;
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
@@ -752,6 +787,13 @@ struct bpf_insn_aux_data {
 	u16 const_reg_map_mask;
 	u16 const_reg_subprog_mask;
 	u32 const_reg_vals[10];
+	/*
+	 * Header index of the innermost loop containing this instruction, -1 if none.
+	 * For a loop header, identifies the parent loop instead.
+	 */
+	s32 loop_header;
+	/* additional information about the loop if this instruction is a loop header */
+	struct bpf_loop *loop;
 };
 
 #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
@@ -1879,6 +1921,7 @@ int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 bt
 				  struct bpf_attach_target_info *tgt_info);
 
 /* Functions in fixups.c, called from bpf_check() */
+void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len);
 int bpf_remove_fastcall_spills_fills(struct bpf_verifier_env *env);
 int bpf_optimize_bpf_loop(struct bpf_verifier_env *env);
 void bpf_opt_hard_wire_dead_code_branches(struct bpf_verifier_env *env);
@@ -1895,5 +1938,8 @@ int bpf_flip_opcode(u32 opcode);
 u8 bpf_rev_opcode(u8 opcode);
 
 int bpf_compute_idoms(struct bpf_verifier_env *env);
+int bpf_compute_loops(struct bpf_verifier_env *env);
+int bpf_loop_at_index(struct bpf_verifier_env *env, u32 idx);
+bool bpf_is_nested_loop(struct bpf_verifier_env *env, int inner_header, int outer_header);
 
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 206cc9a614a9..b2fa7e8bedf3 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -590,6 +590,22 @@ static int bpf_adj_linfo_after_remove(struct bpf_verifier_env *env, u32 off,
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
@@ -602,6 +618,8 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 	if (bpf_prog_is_offloaded(env->prog->aux))
 		bpf_prog_offload_remove_insns(env, off, cnt);
 
+	bpf_clear_insn_aux_data(env, off, cnt);
+
 	err = bpf_remove_insns(env->prog, off, cnt);
 	if (err)
 		return err;
diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
index 0db823ee42f7..8a6dc805e559 100644
--- a/kernel/bpf/loops.c
+++ b/kernel/bpf/loops.c
@@ -156,3 +156,442 @@ int bpf_compute_idoms(struct bpf_verifier_env *env)
 	kvfree(preds);
 	return err;
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
+	loop->backedges[cnt].latches_cnt = 0;
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
+/*
+ * Collect conditional jumps within n's loop that dominate 'n' and have
+ * a successor outside the loop, nearest first.
+ */
+static void find_dominating_conditions(struct bpf_verifier_env *env, int n,
+				       struct bpf_backedge *backedge)
+{
+	struct bpf_insn *insns = env->prog->insnsi;
+	bool t_exits_loop, f_exits_loop;
+	int n_loop, t_loop, f_loop;
+	int *idoms = env->idoms;
+
+	n_loop = bpf_loop_at_index(env, n);
+	if (idoms_intersect(env, n, n_loop) != n_loop)
+		return;
+	while (n >= 0) {
+		if (is_cond_jmp_insn(&insns[n]) && bpf_loop_at_index(env, n) == n_loop) {
+			t_loop = bpf_loop_at_index(env, n + insns[n].off + 1);
+			f_loop = bpf_loop_at_index(env, n + 1);
+			t_exits_loop = t_loop != n_loop && !bpf_is_nested_loop(env, t_loop, n_loop);
+			f_exits_loop = f_loop != n_loop && !bpf_is_nested_loop(env, f_loop, n_loop);
+			if (t_exits_loop || f_exits_loop) {
+				if (backedge->latches_cnt == MAX_LATCHES)
+					return;
+				backedge->latches[backedge->latches_cnt++] = n;
+			}
+		}
+		if (n == n_loop)
+			break;
+		n = idoms[n];
+	}
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
+	int i, j, k, s, t, iloop, sloop, err = 0, len = env->prog->len;
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
+			find_dominating_conditions(env, backedge->from, backedge);
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
+			for (j = 0; j < loop->backedges_cnt; j++) {
+				backedge = &loop->backedges[j];
+				bpf_log(log, "  backedge from %d", backedge->from);
+				for (k = 0; k < backedge->latches_cnt; k++) {
+					if (k == 0)
+						bpf_log(log, ", latch at ");
+					if (k == 1)
+						bpf_log(log, ", dominating exits at ");
+					if (k > 1)
+						bpf_log(log, ", ");
+					bpf_log(log, "%d", backedge->latches[k]);
+				}
+				bpf_log(log, "\n");
+			}
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
index 5a29d05c523c..16b7758221b0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22872,13 +22872,17 @@ static void log_program(struct bpf_verifier_env *env)
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
@@ -23108,6 +23112,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	ret = bpf_compute_loops(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = bpf_compute_live_registers(env);
 	if (ret < 0)
 		goto skip_full_check;
@@ -23260,6 +23268,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	release_btfs(env);
 err_free_env:
 	bpf_free_subprog_jts(env);
+	if (env->insn_aux_data)
+		bpf_clear_insn_aux_data(env, 0, env->insn_aux_data_len);
 	vfree(env->insn_aux_data);
 	kvfree(env->fd_array);
 	bpf_stack_liveness_free(env);

-- 
2.53.0
