Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73E213D53C
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986451; cv=none; b=NGIFIQlfEmef4vsUHsYoubXJpfnrGKXET+sADPUq+CUjhfc8s9G7RugUKLyLJ0t+XupMxfXVbPg0y5VLTeds1YQp8LZgw+/n4pdHdUp4Y1NzsFhk02/+vCKxcuYRM400g5Gps5YkRPxF8/0uhHfNf+lUQMMXSfuyKEH2BBMeR6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986451; c=relaxed/simple;
	bh=U47b6icRp3uEKw0CFFKVbH6/FjIkSDTb2jQavAmS42U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LnXwO2ZKrKZ3Hs6oJSmD/1AJeSa4cq17bSsRcBpwMSUPC4rOrDmZMu9l8R3/p8MyCG3vvuLms1fVof2E/Gjff1F1QG6djNCJ0F3lAX4rJ/EI0sJ39O3rGsWFZNJuXdmQpfNKc1ZrV5pimCtl5qZvWeXGqjJN3oMxeEGxsY0VIW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ie2x5m6x; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ie2x5m6x"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=jWePLrEincUP9gVfLYbal5E/icf90cbD2UhZIs4mwmk=; b=ie2x5m6x9ZI4WlUatQEyNhQW2S
	ZsGzC/bpWeO1ZbKXIcbl8ao6VMB6I3fNzuAdwEzGZGIaBSXOrGKh1Er9/W18TK72vKN2yZaPFOQRj
	kb8KR2idMBtumpx/pgQntHE+BbkeR1D/6lCGl1aRvMCqu4q1Msw704UPXW3Cd+v0+zXkygcf0EGp4
	4xQW3mYD52KcX8AgIYqXqEBLYQatuu71SALa0I8DAp30VHtuaIat2BikClxQCMDrwxpHzMH1VPJeA
	GOzkGHbvnKUivD6TkmW2lv8Y3r4MsYy8qvWeLBHVvH7dsAp/6vXkqe2Chi/f7dasmltbsFHu1ab7j
	AwoGy8iw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x4P5w-000F6n-2t;
	Wed, 09 Sep 2026 22:40:37 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: memxor@gmail.com,
	eddyz87@gmail.com,
	a.s.protopopov@gmail.com,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf 1/6] bpf: Avoid quadratic successor rescan in bpf_compute_scc
Date: Wed,  9 Sep 2026 22:40:30 +0200
Message-ID: <20260909204035.24289-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28118/Wed Sep  9 08:24:03 2026)

The iterative Tarjan DFS in bpf_compute_scc() emulates recursion with an
explicit 'dfs' stack: when a successor has not been visited yet, the
successor is pushed and the walk restarts at the top of the loop. On the
way back to a vertex the successor scan starts over at index zero, so a
vertex with k successors rescans up to k successors on each of its up to k
descents, i.e. O(k^2) work.

For ordinary instructions k <= 2 and this is irrelevant. For a gotox the
successors are the jump table of the containing subprogram, whose size is
bounded only by the max_entries of the insn_array map, so k can reach the
1M instruction complexity limit. Loading such a program keeps a CPU busy
in the loop for a very long time before verification even begins.

Record in 'dfs_pos' the successor index each frame stopped at and resume
the scan there. Each edge is therefore examined a bounded number of times
and the walk becomes linear in the number of edges.

Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Reported-by: STAR Labs SG <info@starlabs.sg>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/cfg.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 842c7d1eabcc..081f7003eae6 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -749,7 +749,7 @@ int bpf_compute_scc(struct bpf_verifier_env *env)
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
 	const u32 insn_cnt = env->prog->len;
 	int stack_sz, dfs_sz, err = 0;
-	u32 *stack, *pre, *low, *dfs;
+	u32 *stack, *pre, *low, *dfs, *dfs_pos;
 	u32 i, j, t, w;
 	u32 next_preorder_num;
 	u32 next_scc_id;
@@ -762,13 +762,16 @@ int bpf_compute_scc(struct bpf_verifier_env *env)
 	 * - 'stack' accumulates vertices in DFS order, see invariant comment below;
 	 * - 'pre[t] == p' => preorder number of vertex 't' is 'p';
 	 * - 'low[t] == n' => smallest preorder number of the vertex reachable from 't' is 'n';
-	 * - 'dfs' DFS traversal stack, used to emulate explicit recursion.
+	 * - 'dfs' DFS traversal stack, used to emulate explicit recursion;
+	 * - 'dfs_pos[k] == j' => the frame 'dfs[k]' resumes visiting its
+	 *   successors at index 'j'.
 	 */
 	stack = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
 	pre = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
 	low = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
 	dfs = kvcalloc(insn_cnt, sizeof(*dfs), GFP_KERNEL_ACCOUNT);
-	if (!stack || !pre || !low || !dfs) {
+	dfs_pos = kvcalloc(insn_cnt, sizeof(*dfs_pos), GFP_KERNEL_ACCOUNT);
+	if (!stack || !pre || !low || !dfs || !dfs_pos) {
 		err = -ENOMEM;
 		goto exit;
 	}
@@ -851,6 +854,7 @@ int bpf_compute_scc(struct bpf_verifier_env *env)
 		stack_sz = 0;
 		dfs_sz = 1;
 		dfs[0] = i;
+		dfs_pos[0] = 0;
 dfs_continue:
 		while (dfs_sz) {
 			w = dfs[dfs_sz - 1];
@@ -860,13 +864,37 @@ int bpf_compute_scc(struct bpf_verifier_env *env)
 				next_preorder_num++;
 				stack[stack_sz++] = w;
 			}
-			/* Visit 'w' successors */
+			/*
+			 * Visit 'w' successors, resuming at the successor this
+			 * frame last descended into. Restarting the scan at zero
+			 * on every return to 'w' would examine each successor
+			 * once per descent, i.e. quadratic in the number of
+			 * successors, which for a gotox is the size of the jump
+			 * table.
+			 *
+			 * Re-folding the successors before that index would be a
+			 * no-op. Such a successor 's' has 'pre[s] != 0' by then,
+			 * so it is never pushed onto 'dfs' again, and low[s] can
+			 * only decrease while 's' is the top of 'dfs'. If 's' is
+			 * still on 'dfs' it sits below 'w' and cannot become the
+			 * top before 'w' is popped; otherwise the only remaining
+			 * write to low[s] is the pop of its SCC, setting it to
+			 * NOT_ON_STACK, for which the min below is a no-op.
+			 */
 			succ = bpf_insn_successors(env, w);
-			for (j = 0; j < succ->cnt; ++j) {
+			for (j = dfs_pos[dfs_sz - 1]; j < succ->cnt; ++j) {
 				if (pre[succ->items[j]]) {
 					low[w] = min(low[w], low[succ->items[j]]);
 				} else {
-					dfs[dfs_sz++] = succ->items[j];
+					/*
+					 * Resume at 'j', not 'j + 1': the successor
+					 * is revisited once its DFS completes, to
+					 * fold its low[] into low[w].
+					 */
+					dfs_pos[dfs_sz - 1] = j;
+					dfs_pos[dfs_sz] = 0;
+					dfs[dfs_sz] = succ->items[j];
+					dfs_sz++;
 					goto dfs_continue;
 				}
 			}
@@ -916,5 +944,6 @@ int bpf_compute_scc(struct bpf_verifier_env *env)
 	kvfree(pre);
 	kvfree(low);
 	kvfree(dfs);
+	kvfree(dfs_pos);
 	return err;
 }
-- 
2.43.0

