Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1C644213A
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 06:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790144081; cv=none; b=LpxI72o+pGgrTw1bhsmzH1CiHefHxMF667e0OIauJGR0BNgGy3IFITgIxvHnxThsTQ6K/XChFY3jgf27UIVO74bqgWBwy5NKYuUPbMmxU75/SK5zLv2qmdLhgkMWzeIjKIe9oqGFW4hYtakE5VYF9GTswYs0bwfN8+kv4xqZbXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790144081; c=relaxed/simple;
	bh=LR+35UwwI99qPvfVKyCOlw5rmo7MW/U2VJik0XkCJf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpR/Oif8J7UQ1dkzVBhH/s7ny7IlUyh94+4v3WD9lNLdpf2FFW9geMO7Oqad1qFRPigOva/fdh9SaSpGWkfxG+KRMu3THPaS2n/3oTjVNWijDXGvclXdARLKVKQcyR9yuU+LiXuhiEqWGTOTzhXdorv+Ag+zWJCgBCA29oAMKr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=KXTHQeH9; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="KXTHQeH9"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so352029a91.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 23:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790144073; x=1790748873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=po0C5fenyTZin9gYAVmxN8hOMCqUdaZwvALXB+AcDh8=;
        b=KXTHQeH9lQfcOBvKombSeFKyEu9OcsvmnRKH39LbM+ZJ4WgFKFTxxnRbD4Xo7usBMH
         opMgf51QT72k3NYjxHuhi/GehfcXOXtWMJhfyBxFHpMlIup/k09k56MlrWVF6W09Uewa
         AXG0lYpFwWir7YcddCWLhV2opNAf6LAPGa2amqq1CYUGvJnG8b7jUcLbuJdX5Uc6JQdi
         +4CEnxf83dI0G2zpYoOLvkSvkfS8ekgO6uJ3k1V45MTiw3UkPTeNTgr0Q7E+SzBXWv3n
         mkXoslwVrgfMsFQ+zXZGxbU7/J3I40rCE/uxbEZ914xU5my0yj6ka83deHLjZc7obho8
         pj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790144073; x=1790748873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=po0C5fenyTZin9gYAVmxN8hOMCqUdaZwvALXB+AcDh8=;
        b=i4W9kMkkRxaEsyoVIJpFRmkU6IIlqaQ2JZQESob+YlIILIGlNGxzU/Z1JZ9Odvr4q9
         hfcxzHWoB2IfVe0mQTnbJXSxqcLSdOXpZgKrmvtuT8ApZHjPfDPXs5j/XN5CqIG3ZEOf
         XDQV/beUvqEdje88Ye/3wxa4vRS/+epXOxB34C/+OjyelbtrR3TEBDWJMUWPQ27OToI3
         LsWF+aLDlRsd1/mn1swcq1TUA3kJ3+cvGfYUHg6Fa9MntJPOm3LRZSkgbb/dbxN8vnGC
         YriKtiN54domkvXPcaHS+91/CGvjW2pMk+af8NDrRb0D4wrX+LM+4MuNH5lBoDQs+hZZ
         /F+g==
X-Gm-Message-State: AFuF++mNG4zVvKm/wCmZ2smlr5Ouk+SN1ibuxnFit7Fcj+hwh8QzdhH8
	cBb5gz67WZcgFZa06+iWp2XAKTg/DmY2FAH6EsIbYxSE9iPJMnSMcGVvFshZw78aiBSdX46gNrZ
	IKQtj
X-Gm-Gg: AYBFou3QxX9ZW262PZDIN7C+sNd0tYK91TNnGqHzmPvVHhlhwHH4fm+frGutk2L81YO
	fb2689eEa5a1D6y40tXD9ka9VCY+vqMOLUAkE5xFHSrRVWXDoSVxQwYHgqLMIK6MAFBJpqF6hgY
	AE8ixPmetshRczEpWGfjTRPDtK8DUUiGcLwNE+8j09kS7KUx2rjRanceGkKXKIhYn7oipQjAkIr
	n9/ZujdLQiR0b2z1ObAkkbEHzvsy6W3xd9ZT0n/QzEQfcyZaDwNu9bGL3ErYBcWvqVSjFHf6h9N
	7vNSVl/Vh5hgDgDVjp01dOYLsxyKOlh4vTc/TRNWr71yUdUHWfEBL8bB6ZV+xdTpcaodDXySW4d
	pEjCvZEwvHrMFRrLu0JktFeWSZ0QOjOJkQT4C/F8gzQ7jplW9PArGEuFXmKHcVxTAjqr3dEONdV
	8Cp5B2UOdNnERkSlYb/JvNyDxKWNAw8T5lh0JmdQ7NysxGke7ibqxBD683MM8nZ+XFlX8AuIIA9
	BeJiBNbHQ6lT8r8PkbIO3b0pU7d+A4XCUOKRlKdYA==
X-Received: by 2002:a17:90b:37c3:b0:39e:6c68:1550 with SMTP id 98e67ed59e1d1-3a07e67ce75mr1250927a91.24.1790144073425;
        Tue, 22 Sep 2026 23:14:33 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07de57682sm3562652a91.16.2026.09.22.23.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:14:33 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2 6/7] bpf: Avoid unavailable range leakage during arena_free_pages()
Date: Wed, 23 Sep 2026 06:14:24 +0000
Message-ID: <20260923061425.7045-7-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260923061425.7045-1-emil@etsalapatis.com>
References: <20260923061425.7045-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arena_free_pages() call is designed to leak the attempted
freed page when it is unable to either directly complete or
defer the operation. This is valid for ranges for which freeing
has not started. For those already marked as unavailable in the
range tree, leaving them permanently unavailable breaks the
assumption that unavailable ranges denote an operation currently
in progress.

Atomically turn the range available instead. The only point a
range can be leaked as unavailable is when failing to regrab the
arena spinlock after zapping the range. At that point, the only
operation left to complete the free is to mark the range available.
The spinlock is required to merge the range with adjacent free ones
to avoid range space fragmentation, but this is not necessary for
correctness or safety. Just flip the range node back to available
without the spinlock then.

This is safe because unavailable nodes are not affected by operations
done to the other nodes, and vice versa for changing the node's available
state. We can thus treat pointers to newly created unavailable nodes
as transient references we drop when we mark the node available.
We do not make the layout of the range_node part of the tree's public
API.

The new operation causes fragmentation in the range tree. This is
preferable to leaking the range, even setting aside the correctness
issue.

Fixes: 226d4d4d1272 ("bpf: Fix arena race between page free and alloc leading to incoherency")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c      | 42 +++++++++++++++++++++++++++++++----------
 kernel/bpf/range_tree.c | 36 ++++++++++++++++++++++++++++++-----
 kernel/bpf/range_tree.h |  5 ++++-
 3 files changed, 67 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 8594b76dae61..299525f93bbd 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -489,6 +489,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	struct bpf_map *map = vmf->vma->vm_file->private_data;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 	struct mem_cgroup *new_memcg, *old_memcg;
+	struct range_node *unavail_node;
 	struct page *page;
 	long kbase, kaddr;
 	unsigned long flags;
@@ -551,10 +552,11 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 out:
 	/* Reserve the page while installing its user PTE without the arena lock. */
 	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
-	ret = range_tree_set_unavail(&arena->rt, vmf->pgoff, 1);
+	unavail_node = range_tree_set_unavail(&arena->rt, vmf->pgoff, 1);
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
-	if (ret) {
+	if (IS_ERR(unavail_node)) {
+		ret = PTR_ERR(unavail_node);
 		if (ret == -EAGAIN)
 			goto retry;
 		return VM_FAULT_OOM;
@@ -895,6 +897,7 @@ static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt, bool sleepable)
 {
 	struct mem_cgroup *new_memcg, *old_memcg;
+	struct range_node *unavail_node = NULL;
 	u64 full_uaddr, uaddr_end;
 	long kaddr, pgoff;
 	struct page *page;
@@ -930,8 +933,9 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	if (ret)
 		goto defer;
 
-	ret = range_tree_set_unavail(&arena->rt, pgoff, page_cnt);
-	if (ret) {
+	unavail_node = range_tree_set_unavail(&arena->rt, pgoff, page_cnt);
+	if (IS_ERR(unavail_node)) {
+		ret = PTR_ERR(unavail_node);
 		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 		/*
 		 * For -EAGAIN: An overlapping fault reserves
@@ -989,13 +993,29 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 defer:
 	s = kmalloc_nolock(sizeof(struct arena_free_span), __GFP_ACCOUNT, -1);
 	bpf_map_memcg_exit(old_memcg, new_memcg);
-	if (!s)
+	if (!s) {
+		/*
+		 * Directly mark the region available. Unavailable regions must
+		 * always be transient, and a permanent one breaks the assumptions
+		 * made in the allocation/faulting code. The operation is safe because
+		 * unavailable nodes are not modified by the range tree code without a reference
+		 * to the node. The modification from unavailable to available also does
+		 * not require touching anything in the tree apart from the node itself,
+		 * so it can be done locklessly. The downside is fragmentation in the tree,
+		 * since we cannot merge with neighbors, but this is a) safe and b) better
+		 * than leaking the range.
+		 */
+		if (release_only)
+			range_node_mark_available(unavail_node);
+
 		/*
-		 * If allocation fails in non-sleepable context, pages are intentionally left
-		 * inaccessible (leaked) until the arena is destroyed. Cleanup or retries are not
-		 * possible here, so we intentionally omit them for safety.
+		 * If we haven't even zapped the pages, intentionally leave them
+		 * inaccessible (leaked) until the arena is destroyed. Cleanup or
+		 * retries are not possible here, so we intentionally omit them for safety.
 		 */
+
 		return;
+	}
 
 	s->page_cnt = page_cnt;
 	s->uaddr = uaddr;
@@ -1048,6 +1068,7 @@ static void arena_free_worker(struct work_struct *work)
 	struct mem_cgroup *new_memcg, *old_memcg;
 	struct llist_node *list, *pos, *t;
 	struct arena_free_span *s;
+	struct range_node *unavail_node;
 	u64 arena_vm_start, user_vm_start;
 	struct llist_head free_pages;
 	struct clear_range_data cdata;
@@ -1081,8 +1102,9 @@ static void arena_free_worker(struct work_struct *work)
 		pgoff = compute_pgoff(arena, s->uaddr);
 		kaddr = arena_vm_start + s->uaddr;
 
-		ret = range_tree_set_unavail(&arena->rt, pgoff, page_cnt);
-		if (ret) {
+		unavail_node = range_tree_set_unavail(&arena->rt, pgoff, page_cnt);
+		if (IS_ERR(unavail_node)) {
+			ret = PTR_ERR(unavail_node);
 			/* Kick off another attempt at the end of this call. */
 			if (ret == -EAGAIN)
 				continue;
diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
index 46a32623efb2..62ebf4df51cb 100644
--- a/kernel/bpf/range_tree.c
+++ b/kernel/bpf/range_tree.c
@@ -3,6 +3,7 @@
 #include <linux/interval_tree_generic.h>
 #include <linux/slab.h>
 #include <linux/bpf.h>
+#include <linux/err.h>
 #include "range_tree.h"
 
 /*
@@ -45,7 +46,21 @@ struct range_node {
 /* Is the range available for merging? */
 static inline bool range_available(struct range_node *rn)
 {
-	return rn && rn->available;
+	/* Pairs with smp_store_release() in range_node_mark_available(). */
+	return rn && smp_load_acquire(&rn->available);
+}
+
+/*
+ * Mark a node as available. Designed to be used locklessly
+ * as a last-ditch effort to avoid leaking unavailable range
+ * tree nodes when all attempts to directly or indirectly
+ * free an arena region has failed. See arena_free_pages()
+ * for more info.
+ */
+void range_node_mark_available(struct range_node *rn)
+{
+	/* Pairs with smp_load_acquire() in range_available(). */
+	smp_store_release(&rn->available, true);
 }
 
 static struct range_node *rb_to_range_node(struct rb_node *rb)
@@ -321,7 +336,8 @@ int range_tree_make_avail(struct range_tree *rt, u32 start, u32 len)
 }
 
 /* Set the range in this range tree */
-static int range_tree_set(struct range_tree *rt, u32 start, u32 len, bool available)
+static int range_tree_set(struct range_tree *rt, u32 start, u32 len, bool available,
+			  struct range_node **new_rn)
 {
 	u32 last = start + len - 1;
 	struct range_node *right;
@@ -364,18 +380,28 @@ static int range_tree_set(struct range_tree *rt, u32 start, u32 len, bool availa
 	left->rn_start = start;
 	left->rn_last = last;
 	range_it_insert(left, rt);
+	if (new_rn)
+		*new_rn = left;
 
 	return 0;
 }
 
 int range_tree_set_avail(struct range_tree *rt, u32 start, u32 len)
 {
-	return range_tree_set(rt, start, len, true);
+	return range_tree_set(rt, start, len, true, NULL);
 }
 
-int range_tree_set_unavail(struct range_tree *rt, u32 start, u32 len)
+struct range_node *range_tree_set_unavail(struct range_tree *rt, u32 start, u32 len)
 {
-	return range_tree_set(rt, start, len, false);
+	struct range_node *rn = NULL;
+	int err;
+
+	err = range_tree_set(rt, start, len, false, &rn);
+	if (err)
+		return ERR_PTR(err);
+	if (WARN_ON_ONCE(!rn))
+		return ERR_PTR(-EINVAL);
+	return rn;
 }
 
 int range_tree_remove_unavail(struct range_tree *rt, u32 start, u32 len)
diff --git a/kernel/bpf/range_tree.h b/kernel/bpf/range_tree.h
index 4b12ef51cc0b..79295abe3684 100644
--- a/kernel/bpf/range_tree.h
+++ b/kernel/bpf/range_tree.h
@@ -10,12 +10,15 @@ struct range_tree {
 	struct rb_root_cached range_size_root;
 };
 
+struct range_node;
+
 void range_tree_init(struct range_tree *rt);
 void range_tree_destroy(struct range_tree *rt);
 
 int range_tree_clear(struct range_tree *rt, u32 start, u32 len);
 int range_tree_set_avail(struct range_tree *rt, u32 start, u32 len);
-int range_tree_set_unavail(struct range_tree *rt, u32 start, u32 len);
+struct range_node *range_tree_set_unavail(struct range_tree *rt, u32 start, u32 len);
+void range_node_mark_available(struct range_node *rn);
 int range_tree_remove_unavail(struct range_tree *rt, u32 start, u32 len);
 int range_tree_make_avail(struct range_tree *rt, u32 start, u32 len);
 int is_range_tree_set(struct range_tree *rt, u32 start, u32 len);
-- 
2.54.0

