Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983962;
	b=APLmgZoEaLC/4dmHldb/vmCxKXUgsLvjZfQP8PFnwTDDdg3EiW7ZtdNF2nxt/gvBHciE
	 SKdCW4JSMWp0gXjzjGHXniHXKaUzHY79tobhmcOEZ1YkurYoLWMC1OHtre3MaxJkPVfEB
	 Oj4QlaccObbPy6i5c6+nUemyeTXgH3bBas2gQOCLGYlUk0ila2ODeK0LubRKeWiEWmbLK
	 af8SDSFOAC0NfmXa0x+m+92N5p+7zJtMArz+PXUVFTrgSP3osmVuUi2ir5PM0NjRV7EOE
	 ZQJiBfrnHFRXFSZUrdvG4BmgDNePysRE7KBXGMqiAWzVImie4xyjh6FZI9BGaYAo0qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983962;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UiMLyocnAOdUbCbj0WdqDY557Lucv/NoBZW6bZwyCw8=;
	b=M/UU3eqy2TNotBsqIoFECed/P5bjdiwhLkPFQTbYHV/ixnPrKiJ8HFMRF9Zi1yD2y6uy
	 93xsrk/grUBADKJCOixgchBxQLuoAs2B7BhrqPSbKK01njLJaHOaBF5F2nHG3CNn898e8
	 gWrHMiEiUM0O5aiKWW6QLkgmq3Y5DINbZ2uv9Sn4hHPa8QSK4w+cR5Lay04jkIgyK04wp
	 sFzVAZ30q06LAGfm2d/EFXqSdX287fL3eF3ybxrKWzfQgxs0lRu2FoDj4Al9ZeVLnd67d
	 54Jf21/x271T10vFP4hraEae4gRDnGIgYx6u0SHo97l6PCzZdhpxc/TQKELUX4LlqEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G6HHhAUs;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3939606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3939606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G6HHhAUs
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e7e742a2c7so16039285ad.0
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983961; x=1793588761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UiMLyocnAOdUbCbj0WdqDY557Lucv/NoBZW6bZwyCw8=;
        b=G6HHhAUsZeJ6vrgxezse13w7FvCsWXYLfYQOdlJ9+/7u4LNE8H5vEOaADfe8ElWP44
         1LX2lygXpje/oP6L5bZ4c4quxw4ASXHGE7K/e+/XB2mpT4Xwzsws6IiuivVzogPi3TYD
         P9Qx3a7ttE+wMpvNoL2cH0xURJ+peL0E76r22suH5WserWLgtSHZRLvvy0QnYqg5duYv
         TohJHnmA31OT8VcUvHaZJTvBYt+7lyC+6HJEW+izfi0VbaxE0fGwFYL2lRSkWWuDVcbJ
         ECjyJ9c8JOZUwGzjD1jXp0fU4GiEG02Ei0vgsWtLBUSVwlakvanQK9OCMQy2/99VvgLt
         q6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983961; x=1793588761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UiMLyocnAOdUbCbj0WdqDY557Lucv/NoBZW6bZwyCw8=;
        b=IYTo5uI6hAf4IeOXMKOAr0vz8iXOb2I6s4KSaET37duFq7LkHsJDdaVrata0tjlHBT
         fK54YMcTTbkEvv2Vj/7HZe3f2mnrxOqCawZwwQL3EQI/5SoEgLqmiU4RzY9MJIWctzdF
         vID2Bvgg3P3Vx2Mh2iI4OeJR5efRRWLREpTBNCoh29gisi+UqcPIQhCytUa1OU3lZNwL
         rdNFyeOeUp9RC3ZotkvZsd2QSuXeoYjOrk1NsI/AgGJGtt+woU2KTDWPYsDVkTAnFPif
         PUsgqke4GS6nqgKctcFQZ9Wvca6cZE7YkK24QHr3aCcmEcuo23S3/jBCyzCj10GiayHG
         eClQ==
X-Gm-Message-State: AFq9FYLqWWhuOMNqNuU9FLrtz4lusVT1LVa6PLvMgRrVp+BMYnHwGdxb
	ZnpJkwRMc3gkKflugr4qsod77sc/FLsFl5p1eNY6JUwjm1dqb5KO35UnVnhJhg==
X-Gm-Gg: AYBFou3DWhRa9SN33CGw9M7WEGvcZsiEq3IivkdM8d9w1BLjf8kC5B+U835ong0VzD6
	6ujr3K8dDlJWwKLA7PPqJtGLAJaBpun/xCeq/usfCRJgXc/NttDq0kx5uz96VfItXXfB39kZ6yV
	ggUVYHexrsS9g4FhiJyzsbR87AjoPHWQU+cXus4r1luxC6kX3Rj3yUuo36i0PIWwltJHTjAKqNJ
	mKxeVxiHWB2KfSZqTmccXlpgMm+RLIdZV7x9SwSVrJWxnjhx8CefMX7uQzPr0kXsMzX/AzvAiZY
	nhmhKklAK2ksYmwWFenoAnJ4iK5RXNru05JAOjCvYRd/o4QoKlYXUBHV7cYfIF78YwKiNOn1M0V
	UYMSFg7VyT2m1ZsnoaTjVJgVns64gfrXBvrNCZ8dSkw3LYcRzAnAlgVBgPfY83ie3pKIXXskGRy
	y203AmZTAxVwzUlD50Aj8YY2OmjqZWz/J5l6FUDNqyD/2bIR/1pmWB5TNGZs7V4tELOM8qQdX2J
	Cq/NJ/5I2F1Z0am1B6QSBlPCpwKSm/O7OxIN257haF5gEbHnceptGM9uOwF4OEPCCg66cpkUsla
	Yp1vRzZPzXXhS7hPA35F3551lIyVopuobw4MKdHYiVIAvUyNjlhg/5F4I2Fw+YffQ6qEPD4HHWy
	fX7tuuRnRhtLV9T1YdiEK3VWm
X-Received: by 2002:a17:903:f16:b0:2e9:6468:1ffc with SMTP id d9443c01a7336-2ea9c87534fmr17452745ad.20.1792983961268;
        Sun, 25 Oct 2026 20:06:01 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1982d2sm11173945ad.41.2026.10.25.20.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:06:00 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 64/81] bpf: Remove bpf_compute_scc()
Date: Mon, 26 Oct 2026 02:59:25 +0000
Message-ID: <20261026025943.404450-65-alexei.starovoitov@gmail.com>
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

bpf_compute_scc() finds the strongly connected components (SCC) of the
control flow graph and gives each insn the number of its SCC. An SCC is an
outermost loop together with the loops in it. When the verifier followed
each path of a prog, is_state_visited() used the numbers to find the moment
when all paths through a loop were explored. Then it propagated precision
marks over the back edges of the loop.

"bpf: Remove is_state_visited()" removed the user of the numbers, and
"bpf: Remove precision tracking" removed the marks. The main pass finds
loops through loop_header in bpf_insn_aux_data.

Remove the calculation. The "Program dump" of log level 2 loses the scc
column.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   6 --
 kernel/bpf/cfg.c             | 190 -----------------------------------
 kernel/bpf/verifier.c        |  10 +-
 3 files changed, 1 insertion(+), 205 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9b107553461e..edac38665f54 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -759,11 +759,6 @@ struct bpf_insn_aux_data {
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
@@ -1632,7 +1627,6 @@ int bpf_prune_dead_branches(struct bpf_verifier_env *env);
 int bpf_check_cfg(struct bpf_verifier_env *env);
 void bpf_free_subprog_jts(struct bpf_verifier_env *env);
 int bpf_compute_postorder(struct bpf_verifier_env *env);
-int bpf_compute_scc(struct bpf_verifier_env *env);
 
 struct bpf_map_desc {
 	struct bpf_map *ptr;
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 64eccc28703a..8973ec413b8c 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -784,193 +784,3 @@ int bpf_compute_postorder(struct bpf_verifier_env *env)
 	return 0;
 }
 
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
-exit:
-	kvfree(stack);
-	kvfree(pre);
-	kvfree(low);
-	kvfree(dfs);
-	kvfree(dfs_pos);
-	return err;
-}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3bc0dcbeaa60..51106df0e76e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24525,13 +24525,9 @@ static void log_program(struct bpf_verifier_env *env)
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
@@ -24742,10 +24738,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
-	ret = bpf_compute_scc(env);
-	if (ret < 0)
-		goto skip_full_check;
-
 	/* must precede the first bpf_ret_reg_pair() user below */
 	ret = bpf_compute_subprog_ret_regs(env);
 	if (ret < 0)
-- 
2.55.0

