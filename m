Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100BB386562;
	Wed, 23 Sep 2026 08:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153949; cv=none; b=YQRwydPAq0CsgE/I5f8qbvanCCA8WxQwEBAzL7Ls+9Fi4fMxl/KM25hc8k/KaEMyyuVk8PzOkJZWWs8/BXZyM5Yqo4Z42BX5sByt8FWDfpk0b05NvLhQXw1V2n57jkzt+sDwTNNkPrghM3LQ6lw4lKrBSIrGjrrwZuB0MjDiUAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153949; c=relaxed/simple;
	bh=w8wkT5fXa23pw/3oHwR9ps67/78Q3/9hTI6jklhid1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpcyJazUSMLph+V75n1IH6p6ZIOpAy2TWBhjWvpzMTEk6BbVxb9sfvOkPEo+G17y8KxZZtKki+8eTZuZHV9LyccEfLBosAUbKG0Fcv0m0qIQUEv9cu/myIFxtqZYnnribTdjMldF8oCBjxEs7fJQv/NffN+buYO9elwgQgWOsn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Th5VcLw+; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Th5VcLw+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=OM
	eo3JmIOAHUDm9tz0WFATfA43d2b8nFcgMSqu4KQ4I=; b=Th5VcLw+ERb7poHl59
	PogjTh7q89JKsRK3p4slqpX+QZ5eWPiGPJaPyqNDdbgRJHYMcANE6MwZdLVWFwT1
	4qlyFQZduIj+D8vdsNbQlObcH01sfQyAfBUfBxRlMEGDzRpVOGYsdCH+Msl0hjI/
	thvlI2dUtuzzSuN2iOvUtjpqA=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3H8OylLNqSEwzAQ--.5285S4;
	Wed, 23 Sep 2026 16:58:30 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v7 2/2] bpf, arena: fix range_tree_set inconsistency on kmalloc_nolock failure
Date: Wed, 23 Sep 2026 16:58:17 +0800
Message-ID: <20260923085817.365930-3-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260923085817.365930-1-chenyuan_fl@163.com>
References: <DLMBR82RJV2B.3401V0ZRMT392@gmail.com>
 <20260923085817.365930-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H8OylLNqSEwzAQ--.5285S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw13CrWfXFW5Jw1xZw1rXrb_yoW5AF4Upw
	45KrWrJrsxJ3y7WwnYvr48CryrCw1fXw48tr9xGw4kAFnxCrn7Ar1YkF4jkF98AFy8ur15
	tF4jva1xKa1UuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jj9a9UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAhbZl2qzlLYVWwAA3v

From: Yuan Chen <chenyuan@kylinos.cn>

range_tree_set() pre-allocates the node needed for a brand-new range
before calling range_tree_clear(), so an allocation failure returns
-ENOMEM without having modified the tree (previously the overlapping
nodes were already removed by range_tree_clear() before the allocation
was attempted, permanently losing the cleared sub-ranges).

The adjacency lookups done before the clear already return the nodes
that the merge below needs: range_tree_clear() frees only the nodes
that lie entirely inside [start, last], trims the overlapping ones in
place, and the split case cannot happen because of the 'already set'
check above. Do the lookup once and drop the unreachable -EFAULT
checks.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/range_tree.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
index 15b588377a76..2460e78d6a55 100644
--- a/kernel/bpf/range_tree.c
+++ b/kernel/bpf/range_tree.c
@@ -199,6 +199,7 @@ int is_range_tree_set(struct range_tree *rt, u32 start, u32 len)
 int range_tree_set(struct range_tree *rt, u32 start, u32 len)
 {
 	u32 last = start + len - 1;
+	struct range_node *new_rn = NULL;
 	struct range_node *right;
 	struct range_node *left;
 	int err;
@@ -208,20 +209,19 @@ int range_tree_set(struct range_tree *rt, u32 start, u32 len)
 	if (left && left->rn_start <= start && left->rn_last >= last)
 		return 0;
 
+	left = range_it_iter_first(rt, start - 1, start - 1);
+	right = range_it_iter_first(rt, last + 1, last + 1);
+	if (!left && !right) {
+		new_rn = kmalloc_nolock(sizeof(struct range_node),
+					__GFP_ACCOUNT, NUMA_NO_NODE);
+		if (!new_rn)
+			return -ENOMEM;
+	}
+
 	/* Clear out everything in the range we want to set. */
 	err = range_tree_clear(rt, start, len);
 	if (err)
-		return err;
-
-	/* Do we have a left-adjacent range ? */
-	left = range_it_iter_first(rt, start - 1, start - 1);
-	if (left && left->rn_last + 1 != start)
-		return -EFAULT;
-
-	/* Do we have a right-adjacent range ? */
-	right = range_it_iter_first(rt, last + 1, last + 1);
-	if (right && right->rn_start != last + 1)
-		return -EFAULT;
+		goto out_free_new;
 
 	if (left && right) {
 		/* Combine left and right adjacent ranges */
@@ -241,14 +241,16 @@ int range_tree_set(struct range_tree *rt, u32 start, u32 len)
 		right->rn_start = start;
 		range_it_insert(right, rt);
 	} else {
-		left = kmalloc_nolock(sizeof(struct range_node), __GFP_ACCOUNT, NUMA_NO_NODE);
-		if (!left)
-			return -ENOMEM;
-		left->rn_start = start;
-		left->rn_last = last;
-		range_it_insert(left, rt);
+		/* No adjacent ranges; use the pre-allocated node */
+		new_rn->rn_start = start;
+		new_rn->rn_last = last;
+		range_it_insert(new_rn, rt);
 	}
 	return 0;
+
+out_free_new:
+	kfree_nolock(new_rn);
+	return err;
 }
 
 void range_tree_destroy(struct range_tree *rt)
-- 
2.54.0

