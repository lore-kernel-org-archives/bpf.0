Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2480E438026
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432463; cv=none; b=WZYlEEdD3W+ag+l6HcRbJR3t9FqdZSPkjcTnHEvkXs+EnYYqHZriAeH+TO0LqMSNPCNxBRLTf6BfEvI/2GSfsG1F+5jGSBo8VDHKHOBNrMj9Rx4l+T3DQ7CcbTHtmuvDoZsdL7shImnUQC6szDHM+NQAeG4n18nAxrdt5oTAEzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432463; c=relaxed/simple;
	bh=q9IKaQorxR4deVpof6DuGWi+PXDCV57Algi2kRtgOzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VIOw9j54yix4RUyoxEFwDPtDholcICduGjFiWbs6Xn5ICgOEVpDRf0D5uEC20Yg3/yliMihs5vMydmzOkfvBNLwbZdNC9fht7DC7w/7u4A2qd8TdqWAijfQDCSrXWrptuBGzkj0xD0Fg4fLttfx6J9YiJYOTlhYI6Ch0+AIUE3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ofHny9JH; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ofHny9JH"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccafb752so928086a91.0
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432461; x=1791037261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wwHDmNWVfS9J2AgQDafCWkNfsbGINyqdVwxRzttZ/dw=;
        b=ofHny9JHOaQiMuyx5479Z+AwwGB2CdI7xhQFJPdh9D8HircOqu7rfVHLubmCKqBEpd
         M3hYRxSw+dZJDl98z2U+h0vqJwLKsqzzJjTC5K6IwMMk8hOYQ1u/j+wwo3DjsaNMBGWm
         Kb5T+zQPz5eblsn1n8PQrU3hkCm7Jb8qUgX2BeqOsjn/SYogzkieZxMn3Xbdis0VWvQc
         hnTRpXxvYRR5rDW92P9ZFV1a4yEr1krrgXriMgeNd7OZoeEYquWHwhxRf4ycCSOyNPzd
         qeYNVubyfQZ5BcpXuhX+oQbqHOgYibdscBdbH1cFboP3EYl8DglIkEJipC8lKEZd1U+Y
         /nSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432461; x=1791037261;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wwHDmNWVfS9J2AgQDafCWkNfsbGINyqdVwxRzttZ/dw=;
        b=cdrIUUo3Srh3vha5ywYHwwNkPoMu7uxkUdiLZp/dAE3eRRNjiWjFQzZNnh/xn2I/oI
         /FNihFwIKk/OI+tMiy65N5UEs/qHwXCUPPZ9yAkpdeMu8zq8MPmhP5MJ4WfaLMgygDpI
         wP+zzlLRWKW34bfZqtYJ8czDFYNMP2fgr7zR/26v7XV4TatC1YTCbgME1gcwvi7neJqd
         I84AQX6nR10Ko8n4hMj8cw0oGeY2BxXVaHE/1XRNg+D4Wsn569/WmhdNZOGP0t7+NKoJ
         AJdSR7qV1bAUO/hRyguytkmotcVTinOZsp8qh3zMWEceC6xwM7g9ON9B2wvrwdpv7Gyy
         qpsA==
X-Gm-Message-State: AFq9FYJK1L2BUfl/+TPD2xyhtVcTyRsdYNI3nS6kff6GOCWBK3gnIXZw
	+1RMOQ98GvcLQ/RcJI689Fjc7CcTdTsjA2/rxWS4+a526nhMvh9nI3BXGdErxLp47gM=
X-Gm-Gg: AYBFou2QSbAhu2buTlKUWvYX0alCv3vM/0rnxAjrvc6071NNc79RZJwocK2gtpqULQs
	GW4AVYwN2S9qKpevwIiapQqbUmsko9mFwKjgUI/E5qjWmF0Qy96rtyZn0lAHNHERZcDF7YugaDs
	Oeb9k4w8J2JXFjOHVJe8WCbYSQYSw87qrq+CTAsudfzOyYqSQwZyyYoyXDBNv1NvTEZmlRa6UCw
	WEFt4k/EVZUbyrYUWKb8D6g5S8NhrVJjUlyk1Cy7Paj6rPWg1RsXhxpTGA6aZ1BP+dGnFZllMhQ
	q/PVLqg1ojwwcnC49syiGgL0MHE8Qh+4hbYvlAqFnz6Uxsh8q89lVh125hKpjBsnqsJSnB1w5a+
	5pWDU41iHYNN2kFhKhq+WnE4XhRqN0SaTULGJXPVDu4v3CM56Fy2+VXp3fUDL1SqsADP8kW8Gqv
	Z4nxTK/kcmi5RGJaBReHb+DcWcM6OVr68+X4JXw3EW5x/RHEHSguQ1AVN7rtq6KucO0Wiqox05d
	3hXRc9uzCM9vRCTvzm21WqlSzQOXxzns7/YMbBtwTk=
X-Received: by 2002:a17:90b:5847:b0:3a0:b40d:827 with SMTP id 98e67ed59e1d1-3a0b40d1ebamr4909665a91.0.1790432461356;
        Sat, 26 Sep 2026 07:21:01 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:21:01 -0700 (PDT)
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
Subject: [PATCH bpf-next 16/36] bpf: save DFS postorder numbers for program instructions
Date: Sat, 26 Sep 2026 07:20:14 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-16-c8e5ab5ba79f@gmail.com>
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
 kernel/bpf/verifier.c        |  1 +
 3 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3787de11f689..6a8157e607ee 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1033,6 +1033,7 @@ struct bpf_verifier_env {
 		 * see bpf_subprog_info->postorder_start.
 		 */
 		int *insn_postorder;
+		int *postorder_nums;
 		int cur_stack;
 		/* current position in the insn_postorder vector */
 		int cur_postorder;
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index b0bd9ba951df..bd771efec66a 100644
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
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a78a9924a610..40ed20693936 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22933,6 +22933,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	vfree(env->insn_aux_data);
 	kvfree(env->fd_array);
 	bpf_stack_liveness_free(env);
+	kvfree(env->cfg.postorder_nums);
 	kvfree(env->cfg.insn_postorder);
 	kvfree(env->scc_info);
 	kvfree(env->succ);

-- 
2.55.0
