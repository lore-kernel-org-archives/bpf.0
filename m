Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C1A51AEF7;
	Tue, 22 Sep 2026 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061730; cv=none; b=JGdcjWc18QOP5o7+EFnrPwjJAyLvgeKs1h21PPwo0Kpf+JNSfSagU+6rcfrgYzFQeRdkdzRVLwt2srpUpKRTgoHTEEPJXX3+v4tdVwuQEXeW3eEOc75BQBdAtypWagTCo6WE7WP30FLBuBeRdhj7FRkMCLd0Yq4C6CiJJaVhwnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061730; c=relaxed/simple;
	bh=93smRfkrSCdfqub5zCaYTBTRqN+iLihNrS9/AE67eeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQDQbzKD8MXD+gULQntnFmCEEYj/1RQ84X0atWbc0NBf/wxYoOe3ZddUjbGYjAzSWxSatMycBYg5VxnXqWNOgtvXG8YqmvJUvHGtQJLMc71sPFTEtZXqhggxpOhKNVXFlJLoPcJ0fbY0UXYxuM6EOtiDtp5hblenycgTy1/qx54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ht2xVYLT; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ht2xVYLT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=xP
	FUatCRmLe4VIi1rrI4JzaFWrbFatDgTEx+a1Vrgr0=; b=Ht2xVYLTvyL6nmdFky
	IlSHN6At4RgXuVoPunwyTCMUh6frJIiAjRfQbxlnwsq08bk7svt8G1IuGIv5ZT7H
	Sy7rLaIKfFvQvs9scaDWLoYHEu3eicMBT6puLnMjlVvNh1zrWkYjwNr/jaDqzGv9
	0/p7LToqMVGoSn1G2eLdRvgG8=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3X6F1LLJqk95GAA--.20838S2;
	Tue, 22 Sep 2026 15:21:26 +0800 (CST)
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
Subject: [PATCH bpf-next v6 3/3] bpf, arena: check range_tree_set return in arena_free_pages and arena_free_worker
Date: Tue, 22 Sep 2026 15:21:16 +0800
Message-ID: <20260922072116.3570973-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CABFh=a6QOjBv1c7B0fw0AEqaBXiQJRh=8on5DUfqPC7hYuGBxg@mail.gmail.com>
References: <CABFh=a6QOjBv1c7B0fw0AEqaBXiQJRh=8on5DUfqPC7hYuGBxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X6F1LLJqk95GAA--.20838S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrW7uF13CrWkAF1rXw18Krg_yoWrCry7pF
	43GFn0yr4rJw4Svr43Wr4v9rnxKwsYqw48GFWYka4rZ345Z342yF4xAF1Uury5CrW8Xr47
	Gr4jq345Kw4jqFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j01v3UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5RZvLWqyLHaVXQAA37

From: Yuan Chen <chenyuan@kylinos.cn>

range_tree_set() can fail with -ENOMEM, but the arena callers ignored its
return value. In arena_free_worker() it ran after PTE clearing, so a
failed update left the range marked allocated while its pages were
already unmapped and freed.

Check the return value at all three call sites: arena_alloc_pages() warns
if restoring the unpopulated tail of a partial allocation fails,
arena_free_pages() aborts the free, and arena_free_worker() moves
range_tree_set() before PTE clearing and, on failure, drops the span and
leaks the range, reclaimed later by arena_map_free().

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/arena.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 7b6847200b43..c9f81d08582b 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -766,7 +766,9 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
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
@@ -881,7 +883,18 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	if (ret)
 		goto defer;
 
-	range_tree_set(&arena->rt, pgoff, page_cnt);
+	ret = range_tree_set(&arena->rt, pgoff, page_cnt);
+	if (ret) {
+		/*
+		 * range_tree_set() is failure-atomic: on -ENOMEM the range
+		 * stays allocated and its pages mapped. Abort the free
+		 * instead of unmapping pages the tree does not track; the
+		 * program can free the range again later.
+		 */
+		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+		bpf_map_memcg_exit(old_memcg, new_memcg);
+		return;
+	}
 
 	init_llist_head(&free_pages);
 	cdata.arena = arena;
@@ -977,7 +990,7 @@ static void arena_free_worker(struct work_struct *work)
 	struct llist_node *list, *pos, *t;
 	struct arena_free_span *s;
 	u64 arena_vm_start, user_vm_start;
-	struct llist_head free_pages;
+	struct llist_head free_pages, cleared;
 	struct clear_range_data cdata;
 	struct page *page;
 	unsigned long full_uaddr;
@@ -992,28 +1005,39 @@ static void arena_free_worker(struct work_struct *work)
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
+		 * Mark the range free before clearing PTEs so a failed
+		 * update keeps the tree and the PTEs consistent. On failure
+		 * leak the range, reclaimed later by arena_map_free(); only
+		 * spans on @cleared reach the flush/zap/release loop below.
+		 */
+		if (range_tree_set(&arena->rt, pgoff, page_cnt)) {
+			kfree_nolock(s);
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
 
 	/* Iterate the list again without holding spinlock to do the tlb flush and zap_pages */
-	llist_for_each_safe(pos, t, list) {
+	llist_for_each_safe(pos, t, cleared.first) {
 		s = llist_entry(pos, struct arena_free_span, node);
 		page_cnt = s->page_cnt;
 		full_uaddr = clear_lo32(user_vm_start) + s->uaddr;
-- 
2.54.0

