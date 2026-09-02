Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721FB4218B6;
	Wed,  2 Sep 2026 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341919; cv=none; b=ryoh1ti1hSekrAL0RzdfhDWbXpkSL5IkuhJACyh8vKFNF8w5bC0c7LRNSKnwinbVAaQBus8auN/u6Fx9psaiJk8ntQImup6/h6t+F/SAX9MbYmrupgsbp1nbKyny6MXRTNtqPo+bBCsDwL1JCWEbXoG+xE5iEH379BPy/dB60pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341919; c=relaxed/simple;
	bh=8NRZLSZC/WH0iPpJIOU+E5GNNTl2iXvwpUd2oPyB8RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2oejMp3Flx9PBbuakOwPIXxL8Y7mrZtAH9gl2u9e0q1fsppRUQlToRt81Lh4tZU0L8QZ/VUR98H6r9vWAhBbv2MuqqLXT5tERHJ+R5/6MdZrhTMVpVg2W48j/IdNavJ4ZJQNGHWLXPrWVQ8y2cXeOn5M0kFK2ZDq4zs6M09B5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=infkKRYu; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="infkKRYu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=2q
	9utxZ+9B0IUlUY+Tcgn2k/NPUl5FtceBfR+r6rKN8=; b=infkKRYuj0shgaFgMW
	I7sh7iw22hQIqi+YiNOMcecMOS0IbZZXa8SIy0xDTDFKCWohMsU9Uvcn+A73mUif
	6b2qk/Y5KG8hmugVSfTDTp1GqR0XGEK6MLcU6B4YXvQJS6dCRbt8BNB+Z+LaPVdz
	9oH6YHGPzRfTtPCQIPo9mFvh8=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3F7Vu7pdqogtpAA--.21222S5;
	Wed, 02 Sep 2026 17:37:55 +0800 (CST)
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
Subject: [PATCH bpf-next v5 3/3] bpf, arena: handle range_tree_set failures in alloc/free paths
Date: Wed,  2 Sep 2026 17:37:40 +0800
Message-ID: <20260902093740.2338724-4-chenyuan_fl@163.com>
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
X-CM-TRANSID:_____wD3F7Vu7pdqogtpAA--.21222S5
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jw43ZF1UXrWkWr15AFW7XFb_yoWfWw4fpF
	s8G3s8trs5J3yI9r43Zr1v9r13KwsYqw4UGFWIka4rAry5Zr9IyFWxCF1UuFy5CrWkXr12
	kr4jq34rKrWUZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j9ku7UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDARRZF2qX7nQNAwAA3y

From: Yuan Chen <chenyuan@kylinos.cn>

arena_alloc_pages(), arena_free_pages() and arena_free_worker() now
handle range_tree_set() errors. arena_free_pages() aborts the free on
error, and arena_free_worker() moves range_tree_set() before PTE
clearing so that a failed tree update leaves the PTEs intact instead of
freeing pages that the arena free tree does not track.

Also check the range_tree_set() return value in arena_alloc_pages()'s
error path, which restores the unpopulated tail of a partially
allocated range; log a warning instead of silently leaking the virtual
range when the tree update fails.

range_tree_set() is failure-atomic (it pre-allocates the node before
touching the tree), so on -ENOMEM the range stays tracked as allocated
and the pages remain mapped and accessible. A failed free is therefore
retryable, and arena_map_free() reclaims any retained pages at map
destruction; aborting the free avoids clearing PTEs for pages the
arena free tree does not track.

In arena_free_worker() a failed tree update used to leave the span in
the drained list, where the second loop would still flush TLB entries,
zap user VMAs, and free the span itself: the free request was dropped,
user mappings were destroyed for a free that never happened, and the
pages stayed mapped until map destruction. Keep failed spans on
arena->free_spans instead and retry them on a later worker run; only
spans whose PTE clearing actually ran are flushed, zapped, and
released.

The retry queues arena->free_irq while the map can concurrently be
freed. arena_map_free() relied on irq_work_sync() + flush_work(),
which miss an irq_work queued by the running worker between the two
calls: the irq_work can fire after the arena is freed and its callback
schedules free_work on freed memory. Set arena->dying under the arena
spinlock before draining, so the worker stops requeueing, steal the
orphaned spans (their pages are reclaimed by existing_page_cb()), and
drain with flush_work() + irq_work_sync() + flush_work().

Setting @dying requires the arena spinlock. raw_res_spin_lock_irqsave()
can fail (-EDEADLK on a proven deadlock cycle, -ETIMEDOUT after a long
hold), and proceeding without the lock would race the worker. Retry a
bounded number of times for a long but finite hold and do not retry
-EDEADLK; on exhaustion leak the arena with a WARN carrying the error
code rather than hang map free.

Suggested-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/arena.c | 95 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 87 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 7b6847200b43..b0d1f0facfb2 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -5,6 +5,7 @@
 #include <linux/cacheflush.h>
 #include <linux/err.h>
 #include <linux/irq_work.h>
+#include <linux/delay.h>
 #include "linux/filter.h"
 #include <linux/llist.h>
 #include <linux/btf_ids.h>
@@ -67,6 +68,8 @@ struct bpf_arena {
 	struct irq_work     free_irq;
 	struct work_struct  free_work;
 	struct llist_head   free_spans;
+	/* set under spinlock during map free; stops the worker retry loop */
+	bool dying;
 };
 
 static void arena_free_worker(struct work_struct *work);
@@ -370,6 +373,9 @@ static int existing_page_cb(pte_t *ptep, unsigned long addr, void *data)
 static void arena_map_free(struct bpf_map *map)
 {
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+	struct llist_node *list, *pos, *t;
+	unsigned long flags;
+	int ret, i;
 
 	/*
 	 * Check that user vma-s are not around when bpf map is freed.
@@ -380,7 +386,40 @@ static void arena_map_free(struct bpf_map *map)
 	if (WARN_ON_ONCE(!list_empty(&arena->vma_list)))
 		return;
 
-	/* Ensure no pending deferred frees */
+	/*
+	 * No fallback if this fails, so retry a few times for a long but
+	 * finite hold; -EDEADLK can't be waited out. Cap the retries:
+	 * leaking the arena is better than hanging map free.
+	 */
+	for (i = 0; i < 10; i++) {
+		ret = raw_res_spin_lock_irqsave(&arena->spinlock, flags);
+		if (!ret || ret == -EDEADLK)
+			break;
+		msleep(1);
+	}
+	if (ret) {
+		WARN_ONCE(1, "bpf_arena: spinlock acquire failed %d\n", ret);
+		return;
+	}
+	/*
+	 * Set @dying before draining: the worker checks it under this
+	 * spinlock before requeueing, so a failed span is either stolen
+	 * here or dropped by the worker.
+	 */
+	arena->dying = true;
+	list = llist_del_all(&arena->free_spans);
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+
+	llist_for_each_safe(pos, t, list)
+		kfree_nolock(llist_entry(pos, struct arena_free_span, node));
+
+	/*
+	 * flush_work() lets the running worker observe @dying so it stops
+	 * requeueing; irq_work_sync() retires anything queued before that;
+	 * the final flush_work() runs the instance which the retired
+	 * irq_work's callback may have scheduled.
+	 */
+	flush_work(&arena->free_work);
 	irq_work_sync(&arena->free_irq);
 	flush_work(&arena->free_work);
 
@@ -766,7 +805,9 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 	return clear_lo32(arena->user_vm_start) + uaddr32;
 out:
-	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
+	if (range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped))
+		pr_warn_ratelimited("bpf_arena: leak range %ld+%ld on failed alloc\n",
+				    pgoff + mapped, page_cnt - mapped);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 	if (mapped) {
 		flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
@@ -881,7 +922,20 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	if (ret)
 		goto defer;
 
-	range_tree_set(&arena->rt, pgoff, page_cnt);
+	ret = range_tree_set(&arena->rt, pgoff, page_cnt);
+	if (ret) {
+		/*
+		 * range_tree_set() is failure-atomic, so -ENOMEM leaves the
+		 * range allocated and the pages mapped; abort the free rather
+		 * than release pages the tree does not track. Nothing retries
+		 * the free; the program can free the range again.
+		 */
+		pr_warn_ratelimited("bpf_arena: free of %lx+%ld failed\n",
+				    uaddr, page_cnt);
+		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+		bpf_map_memcg_exit(old_memcg, new_memcg);
+		return;
+	}
 
 	init_llist_head(&free_pages);
 	cdata.arena = arena;
@@ -977,12 +1031,13 @@ static void arena_free_worker(struct work_struct *work)
 	struct llist_node *list, *pos, *t;
 	struct arena_free_span *s;
 	u64 arena_vm_start, user_vm_start;
-	struct llist_head free_pages;
+	struct llist_head free_pages, cleared;
 	struct clear_range_data cdata;
 	struct page *page;
 	unsigned long full_uaddr;
 	long kaddr, page_cnt, pgoff;
 	unsigned long flags;
+	bool retry = false;
 
 	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
 		schedule_work(work);
@@ -992,28 +1047,52 @@ static void arena_free_worker(struct work_struct *work)
 	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
 
 	init_llist_head(&free_pages);
+	init_llist_head(&cleared);
 	cdata.arena = arena;
 	cdata.free_pages = &free_pages;
 	arena_vm_start = bpf_arena_get_kern_vm_start(arena);
 	user_vm_start = bpf_arena_get_user_vm_start(arena);
 
 	list = llist_del_all(&arena->free_spans);
-	llist_for_each(pos, list) {
+	llist_for_each_safe(pos, t, list) {
 		s = llist_entry(pos, struct arena_free_span, node);
 		page_cnt = s->page_cnt;
 		kaddr = arena_vm_start + s->uaddr;
 		pgoff = compute_pgoff(arena, s->uaddr);
 
+		/*
+		 * Set the range free before clearing PTEs, and requeue the
+		 * span on failure: the PTEs stay intact and the free is
+		 * retried later. Only spans moved to @cleared (PTE clearing
+		 * actually ran) reach the flush/zap/release loop below.
+		 */
+		if (range_tree_set(&arena->rt, pgoff, page_cnt)) {
+			if (arena->dying) {
+				/*
+				 * The map is being freed. PTEs stay intact
+				 * and the pages are reclaimed by
+				 * arena_map_free() via existing_page_cb().
+				 */
+				kfree_nolock(s);
+				continue;
+			}
+			llist_add(&s->node, &arena->free_spans);
+			retry = true;
+			continue;
+		}
+
 		/* clear ptes and collect pages in free_pages llist */
 		apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
 					     apply_range_clear_cb, &cdata);
-
-		range_tree_set(&arena->rt, pgoff, page_cnt);
+		llist_add(&s->node, &cleared);
 	}
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 
+	if (retry)
+		irq_work_queue(&arena->free_irq);
+
 	/* Iterate the list again without holding spinlock to do the tlb flush and zap_pages */
-	llist_for_each_safe(pos, t, list) {
+	llist_for_each_safe(pos, t, cleared.first) {
 		s = llist_entry(pos, struct arena_free_span, node);
 		page_cnt = s->page_cnt;
 		full_uaddr = clear_lo32(user_vm_start) + s->uaddr;
-- 
2.54.0

