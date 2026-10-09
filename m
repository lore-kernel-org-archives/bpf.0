Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B748F4BFE94
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542928; cv=none; b=RfV6jx1k8kKBu3sVZqqnh/MQzfYKD7FEyDHSebxx3uy3MTEZ8vKh5cGDRRbk/jNUEtDcdMsWl25E05IfaySUTpyRULNmPqfGTwuxIp11kjAyIZymE4b6TPHH4eRNBH5sT4gUERdUBXQCSJZTdLSrWhV761s9kVfTY/J7liWesCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542928; c=relaxed/simple;
	bh=bb2Mk1ARAKw7Fcx6HVfyYjcbBAnxUybfrR3AQUls5zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=leWdXs7LeWygFS/ZbISjkyGei2/79wkEWY6aWwd0NXnOFlMXiaPbsn09XcZr19NstwdwqG5R1KzrVzuEZ60prKCjFGCoM4DuwyS7FRJNczp9GzJ93gs5KW4zslGeW7/DGg8DFcwbkdwBTKTXSII1Lol9NhjBUKCX1zXU1ZrSAqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZZwWfpm; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZZwWfpm"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc147d86bebso1085555a12.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542915; x=1792147715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j3PwnHqMUdHhhE53YWt615kKerV1NFa0cz7MSSEVTKQ=;
        b=lZZwWfpmSw/V1D34OZzeqMNstcXvMrUZ/pQiZ7GtE5gapAKzA9/sZAOVZ7PpiM0P9Z
         kV10lwr7XT/2l80YiF5lIuPMOqamFnk5/T84WLHI97QACrNw/9KxCHxnyMWaVs34VfmV
         MwI+0Nz0h2VROVMRStZ0UVGC/QAc8jo2Rp24dryL20TvTNU59ddq/yM5QnmYgV1nzodC
         0KdhMJpmS3oQ8tNFwpciiY+WTpHL1DPaA9gH7JkUujUBa9ifGX1O+DvvMpCw0WG6PkrV
         TR07ku6RxRN2FvQO/4+M+BfFjlJPAr1SeF4sQwZ+RlIXtkk3uwGvHrqcNZbwi2SvKOqa
         LWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542915; x=1792147715;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j3PwnHqMUdHhhE53YWt615kKerV1NFa0cz7MSSEVTKQ=;
        b=r8K7pB86tOGrS09WVtJPsZsc6vSzZOMr2Sm9kRQU+f2rEPERmB5g5ZMlrNmfTOSprR
         OUPKpA0GDs7MV76KadK69066GIaO8TdjNTx5pVsZ9Yt5DlYX4SVznRxBmegAhMJmbSuA
         ti0paMH1nOX7EcTdXAtWLT5/lYS7j//lg7UEs7a/f0LPcRoXyE2y7QjNqDaPWFbGb+3X
         OmHi2aowZ/zz1fzZg4AuJFFhBjAQVqyiqiZ76QhTg1DfhWiQ9+4zrv3kBP+mz9NhJ19N
         o9toRJlFGl0dKVOhcXP8ZrPX3XPlR/LQL2cThMz+rR/xa8NTrK4UaI5qpUJN7b13qVss
         gUdw==
X-Gm-Message-State: AFq9FYLO7MZgMoeBU3xJTlQg64bdZDtcP4ihoqhS5JLY3ahHzk+hK3yp
	QmLUGnsic/ICukKXkgjMhIVfQkbRZe3+tIYKGzByzha8jnRZ+8rTOk5fGiDPwFGh
X-Gm-Gg: AYBFou2HItMiBC6UaZsIVbju1rrWDHJDJV/ax1VoMKZiRhpveWfv1p68GAAr7r/SB0z
	cadlBp2qxeHGqGhAkNq0ifiyb5epk2HvZY5zqzBLZFEzuE/r8Wh9JcxYArAkxwlNZiPhOM6uYwb
	G1w+271J1DkqxfQgX9IG/FBOfmOfb42bKoDHli7YLQVHBlfor4CZqS7DIviHBLASUUShmfDiIBG
	uJmdKm4YnamU31BFrlflGiG5D7pSbgUQCymf2VSf5Kkb11mfCHM2+PbOKin23m7L860dxOVhCzU
	xZNXw1xQZj23EL+Ud8A7rJOFEO2L1ZJurzNEBB9QENJjnVMSX8IkQxRcarMLcOUNw5RnA95zcHp
	jDLNRK1mDsio9kST6cB3Cw0hpK+1oayaNlyURvMOnwS7Kzm1LWyk3cI5dkqI79/ZFc8iH/qwItG
	xWjz4DkT+bhyR/ZTgXAUeJJMsXP3BC6bjRNFj3wBFY8RsnacZb4WHz+2Qv4BIrFL9V8VY9hoBKo
	EFdg8IcKveVu98=
X-Received: by 2002:a17:90b:3a48:b0:3a0:2900:f55e with SMTP id 98e67ed59e1d1-3ab3ac697f1mr898010a91.29.1791542914886;
        Fri, 09 Oct 2026 03:48:34 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:34 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 21/51] bpf: save DFS postorder numbers for program instructions
Date: Fri,  9 Oct 2026 03:47:39 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-21-bcba9bc53ac9@gmail.com>
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
index 2560754ed56c..bd7733fbe930 100644
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
index 192efb722997..91f114947b8b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23221,6 +23221,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	vfree(env->insn_aux_data);
 	kvfree(env->fd_array);
 	bpf_stack_liveness_free(env);
+	kvfree(env->cfg.postorder_nums);
 	kvfree(env->cfg.insn_postorder);
 	kvfree(env->scc_info);
 	kvfree(env->succ);

-- 
2.53.0
