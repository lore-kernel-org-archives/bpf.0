Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF90F3B14B4;
	Mon, 10 Aug 2026 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786355254; cv=none; b=oet52YUjKFTCA/yKRtN0tnNWYlhdqglS+/ErnJH6PJn40lBz519CPIUo+z434nV/SaQSMzotjsJMNUt27JbaNLI7no4RtmY8CMVvK1GgZQ8A0t9Xw368VJUBckTtnchyupXOIZq5LxJGWi3YC5cVm1j5oUjtf4B8gHofwehxjic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786355254; c=relaxed/simple;
	bh=s0eDlEyhWhKwZINONwJAuf9I/2mSlEEBqqnzWw018TU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1fgJ7FXUH/w1Uh1KnKzaaLV4kHCndflrA3zuFPgab5fwyOd1FfpKsNy2P2sVwzG5rs5db7heeYNlzyvCxtop322sHYz/Mf8ePDsVWwmSuZGkqxHpfimhocDvS44yI86u/WpisxId5/HB2goQxGirYKqlWpJYatrTK6QT3ypxBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aSethP9p; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aSethP9p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=tL
	TL2ZpglUla0GwJf+IdatjY2pI7kZBakztj9ClJ+Y0=; b=aSethP9pAMthcxjiwK
	gWaugtb5JVX2gdbbaq5CshpTKvuVHuPSTv6V9/oZ3+ZjVoivoW1XKeU+FpjDzLxf
	xaWBHv8v6fSaOVCUTQhnWeGV4LRuRYS1fpajInyxr6b5GjOlWjA0IBiwaklxCxA4
	gujzxPGWCvnxOLeczx2zoQKNk=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wB3EocEnnlqAlAcOg--.9113S4;
	Mon, 10 Aug 2026 17:46:49 +0800 (CST)
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
Subject: [PATCH bpf-next v2 2/3] bpf, arena: fix range_tree_set inconsistency on kmalloc_nolock failure
Date: Mon, 10 Aug 2026 17:46:33 +0800
Message-ID: <20260810094634.2723213-3-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810094634.2723213-1-chenyuan_fl@163.com>
References: <20260810094634.2723213-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3EocEnnlqAlAcOg--.9113S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw13AF1kWr48GF4xAFy8Grg_yoW5CF4Upw
	45KrWrJrsxJ3yxWr1Svr4ruryrCw1fXws5trZrGw4kA3ZxAr97Arn0kF4jkFWDAFykCr15
	tF1jva1UKF4UuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbIDcUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAQmiYGp5ngmVIAAA37

From: Yuan Chen <chenyuan@kylinos.cn>

range_tree_set() pre-allocates the node needed for a brand-new range
before calling range_tree_clear(), so an allocation failure returns
-ENOMEM without having modified the tree (previously the overlapping
nodes were already removed by range_tree_clear() before the allocation
was attempted, permanently losing the cleared sub-ranges).

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/range_tree.c | 45 +++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
index 15b588377a76..54055b1fe541 100644
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
@@ -208,20 +209,40 @@ int range_tree_set(struct range_tree *rt, u32 start, u32 len)
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
@@ -241,14 +262,16 @@ int range_tree_set(struct range_tree *rt, u32 start, u32 len)
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

