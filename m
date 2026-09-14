Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5232368D78
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405412; cv=none; b=HDIoZnnIF4ZTvvAitBQHASm0mcY80Qu8p82+F8sCZ47glYj1keayy2vIjsFDma59ItGKHbSClVVihMDSOZoaRgNoC4/uxtfh0r6Omw8M4MBKW86zpJrFdF+5nBLJ/UWpK+2yHAsV6thNmc1NbRocK0HcLmZXfdtMaIHlRlgSzOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405412; c=relaxed/simple;
	bh=nLVEguBzjV99L9p1/pnXLYYu9C1NgyjfdowfjEbTizo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mf8vyGVeIDNbJ+/ONLVWva7TFyBktNR9PzHbv4cLyrq/p8Qy3NlyQ4gA6R49Q0kTEbpcwkSAJVDHu3oiIKWiecPo/iPtBZnm0/mOY35aNHqrw1u836WXA619YbUxVz999sDnrFt7K1MF4WEYwS/N+gP7vEx5Dw5gYS9EuudQEtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=NtVI4HFY; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="NtVI4HFY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ULpFruM/DrxKGQFgBTE60ZzSa5Qz/VeYY0up0TQo3Qs=; b=NtVI4HFYLKpcn+bIdpN1YSiKVn
	uJ8AwXBPOxiDSNSxvg8rz5Mc8PwQBvGz/b6yE8eWrLsTJBahIfo4cU/cwDXiwCS+8aG0XchflIRZS
	SjrC6ABBsCK/SE2nT/3KcA+llzcdAkk6uYy/Htg997gc6xwulMBX1eYuFPsBzb71hLed8b1kmjYhy
	t2qN76Qh5A0YcKXjZ+G0RV3ja9sQfKi0wOhWvebOMGH3M1B0E6pz+hWPAWZGUaD6WZuwF4PX1QG2E
	0pjArj19TqqHg5zCcYW82TkW9/omAVRBg1ygOXn1Netiz5CqbjomsEkQ6xlWyZ9AboGjUBxpJcIBm
	YIJdQKDw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x6A5X-000C8I-36;
	Mon, 14 Sep 2026 19:03:28 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: memxor@gmail.com,
	eddyz87@gmail.com,
	a.s.protopopov@gmail.com,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf v2 01/11] bpf: Avoid quadratic successor rescan in bpf_compute_scc
Date: Mon, 14 Sep 2026 19:03:16 +0200
Message-ID: <20260914170326.249953-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914170326.249953-1-daniel@iogearbox.net>
References: <20260914170326.249953-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28123/Mon Sep 14 08:24:19 2026)

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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/cfg.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 842c7d1eabcc..5cfd02c42afd 100644
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
@@ -860,13 +864,22 @@ int bpf_compute_scc(struct bpf_verifier_env *env)
 				next_preorder_num++;
 				stack[stack_sz++] = w;
 			}
-			/* Visit 'w' successors */
+			/* Visit remaining 'w' successors */
 			succ = bpf_insn_successors(env, w);
-			for (j = 0; j < succ->cnt; ++j) {
+			for (j = dfs_pos[dfs_sz - 1]; j < succ->cnt; ++j) {
 				if (pre[succ->items[j]]) {
 					low[w] = min(low[w], low[succ->items[j]]);
 				} else {
-					dfs[dfs_sz++] = succ->items[j];
+					/*
+					 * Once DFS for succ->items[j] is complete,
+					 * pre[succ->items[j]] is non-zero, hence
+					 * resuming at 'j' allows to follow the
+					 * low[w] = min(...) update branch above.
+					 */
+					dfs_pos[dfs_sz - 1] = j;
+					dfs_pos[dfs_sz] = 0;
+					dfs[dfs_sz] = succ->items[j];
+					dfs_sz++;
 					goto dfs_continue;
 				}
 			}
@@ -916,5 +929,6 @@ int bpf_compute_scc(struct bpf_verifier_env *env)
 	kvfree(pre);
 	kvfree(low);
 	kvfree(dfs);
+	kvfree(dfs_pos);
 	return err;
 }
-- 
2.43.0

