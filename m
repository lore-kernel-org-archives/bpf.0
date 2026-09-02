Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8634229A6;
	Wed,  2 Sep 2026 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341920; cv=none; b=bdjOZYqj8rBSUT7OHwzNh9E83GGN4h+pReZao7MVYSSK6kjX0Bbw4WmTdmAM7ZI38KmuIbiEgLkKp77WdkK1gf6yprkWUWIC+iXbQNM0w7+RX3lhPou+PbS5Wnr/6npwXYAdGp2VOqLb+3MTczG7A2tZzdCgdal+Nilp2OgVQMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341920; c=relaxed/simple;
	bh=IwROk44CZaQG+siuubT32QXiRJHbp5/a/TuPA93r2pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtaS34C2odJRT+5uZcU9hVRe9l+UZ9/tIICC0dtuPp8Y5wRXPy9ZnOb4eVjiwNVlAVpr/xVjyGlLLtllGlfnxLBfYChmJ8FNOep+Vf9BI1Evttp/M95oUtydRSSUfIg/x8AvtA8IiqzME7bbx95lIGX3vEfYC17eYAy+KA6e2Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PFufibr8; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PFufibr8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=zr
	VKOIfZyNfdBaup7kUIwUMlr9Bdz0dloClPNSFyXyY=; b=PFufibr8UkN7dLNEP4
	e3w84zL+/Fj0jHTso8J/7oZSBacGgvQ93plbH0KoHMsyEwuJrp/p7TlOnmdbhU0M
	qgeACe4oAcustGRdyRkVzkwY9zkVoGDHKHtkjpG0fvlRyf1A6jlCz7nsjZtTR5xB
	adOWQC51HXVoYshU7dMxl8Ijs=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3F7Vu7pdqogtpAA--.21222S4;
	Wed, 02 Sep 2026 17:37:54 +0800 (CST)
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
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v5 2/3] bpf, arena: fix range_tree_set inconsistency on kmalloc_nolock failure
Date: Wed,  2 Sep 2026 17:37:39 +0800
Message-ID: <20260902093740.2338724-3-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260902093740.2338724-1-chenyuan_fl@163.com>
References: <CAADnVQKPSWBzaEc7QBT39C_N_32Gu5_P5Cob9G0rxcDgiSQg6g@mail.gmail.com>
 <20260902093740.2338724-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3F7Vu7pdqogtpAA--.21222S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw13AF1kWr48GF4xAFy8Grg_yoW5CFWrpw
	15KrWrJrsxJ3y7Ww1Fvr48uFyrCw1fXw4ktrZxGw4kA3W5Ar97AFn0kF4jkFWDAFy8Cr15
	tF1jv3y7GF4UuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbo7NUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAhJYFmqX7nIOyAAA35

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
index 15b588377a76..0420ab715f20 100644
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
+	 * The pre-clear probe only decides whether a fresh node is needed;
+	 * adjacency on either side is invariant across the clear, so it can
+	 * run before the tree is modified and -ENOMEM leaves it untouched.
+	 * The merge below re-fetches its handles after the clear instead of
+	 * relying on the overlapping nodes being updated in place.
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

