Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D812429CE7;
	Mon, 24 Aug 2026 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579016; cv=none; b=I0ESkW6yt5w3+ym4AU950SytzRNMEyxPlhUp0XojXnb2HdJJ3xIEwb7GTppUYsMF8iRw835WjJC4354NXbzwW4i2LrS+rSbuKBiBQVWtje9oVv9rugzfRiNWm5zmSTcBdlag/JfOH5zIBQPwSDq9EK0bHN8bciOVQtVpEEyInbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579016; c=relaxed/simple;
	bh=34U9Hlzt8usGoop5DP8cQaWQgf4BxMng4CmGve075xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CA8EAq+52i82JGmd73UsJvZF16bKhM6S1xMzHgFPiTZelb1UvFESDdKWtWPFIOQDlJhVA5QV/sAD+DL56exzUkGfc71zWlqUQuDCC8G642DDF3rwGcuJfEbqg9TUrx78zut7ORijkmeeRWxUIVwvKI1NlRxSFSZbMkVlJ1EuLf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fzHNpn72; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fzHNpn72"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=sj
	lyGP7SmyNlVt9ERhiLH2GbPXg5tcviTAl4Ckd83TI=; b=fzHNpn72FUmA1zDmxe
	CfSTOGf4lrTSmDi+xuuYqsLQi0Wo5PykKBm67Cd823pIXE47XHvfVbZKgzaxq+/k
	6ZbXr3hPOWImKiIKDrLOEYw6BHRjNlDv1rsozZzsJOMFDXzGm2EK5JW5pCuEyLVl
	+cByCr5txy569Ur2tcNu221sU=
Received: from nec8-i7 (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCHGCDISYxqeuS4Nw--.46468S5;
	Mon, 24 Aug 2026 21:40:27 +0800 (CST)
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
Subject: [PATCH bpf-next v4 3/3] bpf, arena: check range_tree_set return in arena_free_pages and arena_free_worker
Date: Mon, 24 Aug 2026 21:40:16 +0800
Message-ID: <20260824134016.2006188-4-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824134016.2006188-1-chenyuan_fl@163.com>
References: <20260824134016.2006188-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCHGCDISYxqeuS4Nw--.46468S5
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jw43ZF1UXrWkWr15AFW7XFb_yoW7Cry8pF
	43GFn8trs5Jw4Svr43ur4v9r13KwsYqw48GFWjka4rZry5Z3sxtF4xCF1Uua4UCrWkXw12
	gF4jq345Kr4qqFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j9AwxUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAgtCAGqMScv5GwAA3N

From: Yuan Chen <chenyuan@kylinos.cn>

arena_free_pages() and arena_free_worker() now handle range_tree_set()
errors. arena_free_pages() aborts the free on error, and
arena_free_worker() moves range_tree_set() before PTE clearing so that a
failed tree update leaves the PTEs intact instead of freeing pages that
the arena free tree does not track.

Also check the range_tree_set() return value in arena_alloc_pages()'s
error path, which restores the unpopulated tail of a partially allocated
range; log a warning instead of silently leaking the virtual range when
the tree update fails.

range_tree_set() is failure-atomic (it pre-allocates the node before
touching the tree), so on -ENOMEM the range stays tracked as allocated
and the pages remain mapped and accessible. A failed free is therefore
retryable, and arena_map_free() reclaims any retained pages at map
destruction; aborting the free avoids clearing PTEs for pages the arena
free tree does not track.

In arena_free_worker() a failed tree update used to leave the span in
the drained list, where the second loop would still flush TLB entries,
zap user VMAs, and free the span itself: the free request was dropped,
user mappings were destroyed for a free that never happened, and the
pages stayed mapped until map destruction. Keep failed spans on
arena->free_spans instead and retry them on a later worker run; only
spans whose PTE clearing actually ran are flushed, zapped, and released.

Suggested-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/arena.c | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 555ee2531ef9..1315872941e1 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -766,7 +766,9 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 	return clear_lo32(arena->user_vm_start) + uaddr32;
 out:
-	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
+	if (range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped))
+		pr_warn_ratelimited("bpf_arena: failed to restore free range %ld+%ld after partial alloc\n",
+				    pgoff + mapped, page_cnt - mapped);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 	if (mapped) {
 		flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
@@ -881,7 +883,18 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	if (ret)
 		goto defer;
 
-	range_tree_set(&arena->rt, pgoff, page_cnt);
+	ret = range_tree_set(&arena->rt, pgoff, page_cnt);
+	if (ret) {
+		/*
+		 * range_tree_set() is failure-atomic, so -ENOMEM leaves the
+		 * range allocated and the pages mapped. Abort the free rather
+		 * than returning pages the free tree does not track; a later
+		 * free of the same range can succeed.
+		 */
+		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+		bpf_map_memcg_exit(old_memcg, new_memcg);
+		return;
+	}
 
 	init_llist_head(&free_pages);
 	cdata.arena = arena;
@@ -977,12 +990,13 @@ static void arena_free_worker(struct work_struct *work)
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
@@ -992,28 +1006,43 @@ static void arena_free_worker(struct work_struct *work)
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

