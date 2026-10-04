Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C0843744F
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121134; cv=none; b=tMGUfXkdq4XJ/UByOGs79CX7VmSRqiKiFTpOv//abB0Y2KOc2mzIqJQSFcevuyLfXRKMBMJsjJQ+OCEmS7hkTTqAt2VA1FHGi/cQHBLzKRRVoRVHw9HSAH8X1kBDLfb+8/qajqbGuVRg0mIX9uMmRjggqlpWZ8UyE7Now7IfEgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121134; c=relaxed/simple;
	bh=0sT1L8LFQ8E8+ROxLJuBVd5sZeonGOV9+Yru1tNG7JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qkyzGzYYAo8M4WkjCsHBKQXkkkJGM+E1+nh7FdbKlpWadX9acEpNMbwrWBeELPNZRIRtxGH8Fl71ZVvS9LmP114XDX5ivb7LB9wlGQHHmTeXLnAkiwWkV3WA0BHxsMBMIVudmgOFHQ4BBBdPvSNwkH7pmXwJBg/InxlV2GGp/z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dY/2EexY; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dY/2EexY"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c08393b0so268182a12.0
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121132; x=1791725932; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w4DrO50/ThGCLoGm884qltDZzuBqP4qG8CjdezLWVoE=;
        b=dY/2EexYNIBYCnXTkhk5xCjJa08bfq5OHA8Feer9YN3pWpSO8nLV9HJ/NKZYP/2U8L
         uR2erH3BYXBRNiHEUs+IGDBXGNhLT5qjZqKZThy77orbDV0tpb/+4FFuDxpjThvpHm2Y
         EDX1xIS1wXQE/MrD6vkji58qnQNdOxFqpvIlrnEfbBe3kudQF6yc/BwYHjWajc4hGLsD
         Gr1xMEKhwsHhWjpPqb8oHJ+A9tr6blg1NWeURJnOlh9eUoOn9NozGpxfTzsLxDrSkA8G
         pYVEYNzw6pdoNZY7a4JgFN6FIX4ifn1FWPfcfdge1THW+FIpTI292erJkqQr8cgYixs1
         AStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121132; x=1791725932;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w4DrO50/ThGCLoGm884qltDZzuBqP4qG8CjdezLWVoE=;
        b=PHGkKVjhPgob/JenuV3JD896Q0chltEHZqydQhkpSIo2YOEI8jYweHIJCfthiHRRI6
         YwReD57s3yK2n6M8zLHGXaz4tLyM6sZuM2Ys7BzfoVLQHsDRXnXFSlRQJybWdszog9nW
         6JwvgQQqPmx3hiefqgsbhfowEB4MWXmTodhlsCQe8FfCFodvGIteVqNOOucFlh4TisXF
         aN2kUUovbViFltkdqaW3muHxD56E4MWZZZBpJC9Q/6p//1TWR+PeQ6RcvpH/2u5eGilt
         YzdburKybHyru9VNhL8aOQqkgJtpgywfepwSc4YJ7GiKnKenMF+UvZK5ja+HX/7JrQK3
         Jo1g==
X-Gm-Message-State: AFuF++mjJhwADZVs3HFWraK+ZILyqIBgmciyomNJtTdC9sspKLzEXODD
	G96fdfTSxJoi8ZrNfETzv9jsR+SuXc/xDAo+zt+YO8Ob1+yTm8XA8xEEdzv/dA==
X-Gm-Gg: AYBFou1/gDNw+EZcIBdg1WEngOymEKowJJVzjeEyQFlJ7kT27HAr9ajEz+ETIEYu90Z
	8rj0ySEjJBef2WQuiUBAQeLs3OWI5WZSzaNVI8VKso/Fo1X9HZq1nNowYpS9gOmgvI9a/ZjvrxY
	hL1OmUnlz44th0vhfrShwxRsF7SRxtAKX4xg0lJL30CxCC8qvXIl0YhOG8cLHwR/28vzR/gqNYy
	wLGeFDziDrWJxApy7ls8tFJ73lQYfbNx9LimYCfQkt5VjKdqIB+l1tybYZJpYUVm193rDeAm4RW
	Oh8yNpO4VFrZQrFUHhW/XZ7UDk9icGsXyvsjks2zYUGAN1/qL2sCSxxMjis5dqySmaSp8VfrSpC
	Bi1xconEkCGoaYFQ9gpzVohfCQlyCEmlP3oAoUGQXIxajb8g3Fdo9CPzDkBjTfl7jZ5roD1tZFt
	t6opxs1qgmNhmLldspjwPGBkc8eID0dzPotXT8JTZtjHwkXKyNPCXU8PEAOSupo4ehk/SxgdpLd
	YsdaxsTfRjvhQU=
X-Received: by 2002:a05:6a21:6185:b0:3dd:ff93:a87 with SMTP id adf61e73a8af0-3e0bd18f29amr7059214637.50.1791121132058;
        Sun, 04 Oct 2026 06:38:52 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:38:51 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 16/43] bpf: save DFS postorder numbers for program instructions
Date: Sun,  4 Oct 2026 06:37:58 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-16-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Dominator intersections and SCEV worklist scheduling need to compare
instructions by their DFS postorder rank. Save per-instruction
postorder numbers alongside the existing postorder sequence.

This commit modifies bpf_compute_postorder() to actually do the DFS
traversal, instead of scheduling traversal of all siblings at once.

Consider a graph:

  A -> B
  A -> C
  C -> B

Old result: C, B, A
DFS result: B, C, A

Fixes: efcda22aa541 ("bpf: compute instructions postorder per subprogram")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/cfg.c             | 56 +++++++++++++++++++++++++++-----------------
 kernel/bpf/const_fold.c      |  2 ++
 kernel/bpf/verifier.c        |  1 +
 4 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 05914fcbe77c..14813040df84 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1036,6 +1036,7 @@ struct bpf_verifier_env {
 		 * see bpf_subprog_info->postorder_start.
 		 */
 		int *insn_postorder;
+		int *postorder_nums;
 		int cur_stack;
 		/* current position in the insn_postorder vector */
 		int cur_postorder;
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index d8a579680e5b..bce7b5abcfda 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -767,6 +767,11 @@ int bpf_check_cfg(struct bpf_verifier_env *env)
 	return ret;
 }
 
+struct dfs_state {
+	u32 traversed:1;
+	u32 next_succ:31;
+};
+
 /*
  * For each subprogram 'i' fill array env->cfg.insn_subprogram sub-range
  * [env->subprog_info[i].postorder_start, env->subprog_info[i+1].postorder_start)
@@ -774,43 +779,52 @@ int bpf_check_cfg(struct bpf_verifier_env *env)
  */
 int bpf_compute_postorder(struct bpf_verifier_env *env)
 {
-	u32 cur_postorder, i, top, stack_sz, s;
-	int *stack = NULL, *postorder = NULL, *state = NULL;
-	struct bpf_iarray *succ;
+	int *stack = NULL, *postorder = NULL, *postorder_nums = NULL;
+	int subprog_idx, stack_sz, cur, s, cur_postorder, start;
+	struct dfs_state *state = NULL;
+	struct bpf_iarray *succ = NULL;
 
+	postorder_nums = kvzalloc_objs(int, env->prog->len, GFP_KERNEL_ACCOUNT);
 	postorder = kvzalloc_objs(int, env->prog->len, GFP_KERNEL_ACCOUNT);
-	state = kvzalloc_objs(int, env->prog->len, GFP_KERNEL_ACCOUNT);
 	stack = kvzalloc_objs(int, env->prog->len, GFP_KERNEL_ACCOUNT);
-	if (!postorder || !state || !stack) {
+	state = kvzalloc_objs(struct dfs_state, env->prog->len, GFP_KERNEL_ACCOUNT);
+	if (!postorder_nums || !postorder || !stack || !state) {
+		kvfree(postorder_nums);
 		kvfree(postorder);
-		kvfree(state);
 		kvfree(stack);
+		kvfree(state);
 		return -ENOMEM;
 	}
 	cur_postorder = 0;
-	for (i = 0; i < env->subprog_cnt; i++) {
-		env->subprog_info[i].postorder_start = cur_postorder;
-		stack[0] = env->subprog_info[i].start;
+	for (subprog_idx = 0; subprog_idx < env->subprog_cnt; subprog_idx++) {
+		start = env->subprog_info[subprog_idx].start;
+		env->subprog_info[subprog_idx].postorder_start = cur_postorder;
+		stack[0] = start;
 		stack_sz = 1;
+		state[start].traversed = true;
 		do {
-			top = stack[stack_sz - 1];
-			state[top] |= DISCOVERED;
-			if (state[top] & EXPLORED) {
-				postorder[cur_postorder++] = top;
+			cur = stack[stack_sz - 1];
+			succ = bpf_insn_successors(env, cur);
+			if (state[cur].next_succ == succ->cnt) {
+				postorder_nums[cur] = cur_postorder;
+				postorder[cur_postorder] = cur;
+				cur_postorder++;
 				stack_sz--;
 				continue;
 			}
-			succ = bpf_insn_successors(env, top);
-			for (s = 0; s < succ->cnt; ++s) {
-				if (!state[succ->items[s]]) {
-					stack[stack_sz++] = succ->items[s];
-					state[succ->items[s]] |= DISCOVERED;
-				}
+			s = succ->items[state[cur].next_succ];
+			if (!state[s].traversed) {
+				state[s].traversed = true;
+				state[s].next_succ = 0;
+				stack[stack_sz] = s;
+				stack_sz++;
+				continue;
 			}
-			state[top] |= EXPLORED;
+			state[cur].next_succ++;
 		} while (stack_sz);
 	}
-	env->subprog_info[i].postorder_start = cur_postorder;
+	env->subprog_info[subprog_idx].postorder_start = cur_postorder;
+	env->cfg.postorder_nums = postorder_nums;
 	env->cfg.insn_postorder = postorder;
 	env->cfg.cur_postorder = cur_postorder;
 	kvfree(stack);
diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
index b1528adbeb79..8dd8c5958eb8 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -398,5 +398,7 @@ int bpf_prune_dead_branches(struct bpf_verifier_env *env)
 	/* recompute postorder, since CFG has changed */
 	kvfree(env->cfg.insn_postorder);
 	env->cfg.insn_postorder = NULL;
+	kvfree(env->cfg.postorder_nums);
+	env->cfg.postorder_nums = NULL;
 	return bpf_compute_postorder(env);
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 27a53204696f..3298e2192239 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23092,6 +23092,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	vfree(env->insn_aux_data);
 	kvfree(env->fd_array);
 	bpf_stack_liveness_free(env);
+	kvfree(env->cfg.postorder_nums);
 	kvfree(env->cfg.insn_postorder);
 	kvfree(env->scc_info);
 	kvfree(env->succ);

-- 
2.53.0
