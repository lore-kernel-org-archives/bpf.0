Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E7132E728;
	Thu,  6 Aug 2026 03:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785985508; cv=none; b=esPhnYhbwPD+jEmLcq5j/1q1WXmqcg2mJyZ3AmtS8zZcUeJHXrdU3gfkJEh2jgR8SyDQiMOtlQy6SgfsVqk9OxTszSapiRGCNIMK828P7fACl/0OOyme7g6t41mFp5Foe//1UWOc6/O8luw1BMfFYYyAirfu85yPPDdbDAjRRYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785985508; c=relaxed/simple;
	bh=lFyzvFLBFlFCN7WrNUZoqnrlPNPVQpdB1y4PGbHJ6Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrfRpVapbaSZ/vaNf83C7Tk4J1t8Nn02sZkmeUzUsSVXceeqrgOhiRJPB3Vq6TPBDLXrdZHNOsDdjQF8CNd2YaNtphrP3Q+4ZV2t4qFrZEPVjnoh5RWW69axFZgOO0alXkcqamtlX17SqL05uAFt6QcsUiwTtBVZ35ALH6XPYXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RoPwbWG9; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RoPwbWG9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=64
	vxsg4gBmXayFP7He2QEIPaG2DHX5YeIZkXH+D34FE=; b=RoPwbWG90v6vv/ObVv
	uss5xRb9dk9zUbqTCpygGUvqxWm6lfMMQDhRtmJde1WOVPYFESs3GzB9om/KSjwa
	vhEAQ4JT/jcDOZHgVKRzALVlRPv6/0iXVZWUE/2HdFugjCiydgKZoMn3KPRZWvhS
	rUWO4ajz9+ckEI2e8eLXZJdjY=
Received: from nec8-i7 (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3Xy2m+XNqWvt+Kw--.33251S4;
	Thu, 06 Aug 2026 11:04:14 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v1 2/3] bpf, arena: fix range_tree_set inconsistency on kmalloc_nolock failure
Date: Thu,  6 Aug 2026 11:03:58 +0800
Message-ID: <20260806030359.299480-3-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806030359.299480-1-chenyuan_fl@163.com>
References: <20260806030359.299480-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgD3Xy2m+XNqWvt+Kw--.33251S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr17ZFy3Wry8Wr13GFWDCFg_yoW5uF1Upw
	15KrWrJrsxt3yxWrySvr48CryFkw1fXws5trZrGw4kAFn8ArZ7AFn0kF4jkFWDAFykur15
	tF1jva1UGr4UuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbnYwUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5Q4h3mpz+a5JNQAA3m

From: Yuan Chen <chenyuan@kylinos.cn>

range_tree_set() clears overlapping ranges before allocating the node
for the new range.  If the allocation fails, the function returns
-ENOMEM with the cleared range already removed from the tree, leaving
those arena slots permanently unavailable.

Allocate only when the range has no adjacent free range on either side;
this is known before the clear, since any range covering start - 1 or
last + 1 survives it as an adjacent piece.  A failure therefore still
leaves the tree unmodified.

Fixes: b795379757eb ("bpf: Introduce range_tree data structure and use it in bpf arena")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/range_tree.c | 45 +++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
index 24fa32d4356b..45560e9f0d07 100644
--- a/kernel/bpf/range_tree.c
+++ b/kernel/bpf/range_tree.c
@@ -198,6 +198,7 @@ int is_range_tree_set(struct range_tree *rt, u32 start, u32 len)
 int range_tree_set(struct range_tree *rt, u32 start, u32 len)
 {
 	u32 last = start + len - 1;
+	struct range_node *new_rn = NULL;
 	struct range_node *right;
 	struct range_node *left;
 	int err;
@@ -207,20 +208,40 @@ int range_tree_set(struct range_tree *rt, u32 start, u32 len)
 	if (left && left->rn_start <= start && left->rn_last >= last)
 		return 0;
 
+	/*
+	 * A new node is needed only when the range has no adjacent free
+	 * range on either side.  This is known before clearing: any range
+	 * covering start - 1 or last + 1 survives the clear as an adjacent
+	 * piece.  Allocate only in that case, before modifying the tree, so
+	 * a failure leaves the range tree unmodified
+	 */
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
+		goto out_free_new;
 
 	/* Do we have a left-adjacent range ? */
 	left = range_it_iter_first(rt, start - 1, start - 1);
-	if (left && left->rn_last + 1 != start)
-		return -EFAULT;
+	if (left && left->rn_last + 1 != start) {
+		err = -EFAULT;
+		goto out_free_new;
+	}
 
 	/* Do we have a right-adjacent range ? */
 	right = range_it_iter_first(rt, last + 1, last + 1);
-	if (right && right->rn_start != last + 1)
-		return -EFAULT;
+	if (right && right->rn_start != last + 1) {
+		err = -EFAULT;
+		goto out_free_new;
+	}
 
 	if (left && right) {
 		/* Combine left and right adjacent ranges */
@@ -240,14 +261,16 @@ int range_tree_set(struct range_tree *rt, u32 start, u32 len)
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

