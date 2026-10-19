Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440674;
	b=PtepMWPKqWXwKQLE2sePyGOK9OvSYLG9fBYdZXmYYcPqNIY/H0lIezoid7OUrTv8xBw6
	 xBh410oxmFD6cC4HkLFF2q+n1uEs9nXUK+7q63R2zVyuEoXxSiWXrLiCVrv+KQw0QAWju
	 yHrkAntA0shRuuVF9Ff8HgNwNLt5TRGqRtX2GKHxofiRoXyD56DkWjstlTP1VzxW2GAkd
	 uGZrC4Qp2CUl3RziCIbqSb0SR4WgPR455regnnCSeaV3kz5DCRcFSTD2TIq1ngt8lH8Xt
	 YAXgP/W/JcFNgKr3gcW/0F6QK0W990iaFtU10eTaKGBw6v7o9OHrTSbMCqk6xtRCwVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zR0bKNmFrarT5kXjoovQc4qe3MXIt/ne5IeCkGI3Grs=;
	b=z7PU4RJsi76RJi6e91l7aF0PkTlylipcoqZ86xDUZpvOK/F8Zj5geQmmFSzkEUjrxk1S
	 Yu5aYKhLzYJ+w+H28/t/XWDAJ2ca+1OOk2nWcpK74cyJi8P9uGUO6CEF5u8pA3xejkvM6
	 9fkItqM3zNOfhP2BR7g/S1fti/MUJ2CnknPgA26Q+qOQS+KJTByQi12CYAVfnl1ODiZSr
	 SY/KmUv+L1NThcJwik27GZQrUeWSRbPmlyQr63dNFzT6uh7kBam/Vz8BMg9LvuZd1wned
	 Pocldrauo8sbghY497DNGgm5ydDoBf9Brh5d2lcMLgwWWunXioL7zmECW7jdATkVi8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=BeP8A741;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AF4606A335
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 20:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32AF4606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=BeP8A741
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ea1e7fad99so265945ad.1
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792440673; x=1793045473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zR0bKNmFrarT5kXjoovQc4qe3MXIt/ne5IeCkGI3Grs=;
        b=BeP8A741Ujriy0SeR40HzW4Y4wN/QMkcHZGzoHGGH4F2LNJu2Djd6iRTOgbDYfCBhM
         6x47/XSHiyr6JeQeCZQpJTesjftZmXfafmrDyfp3CNk6BYNGKj9RWTOjbP3mGrQiTQm7
         wvh7OAbDoWWgcmfMGpLr/v8iddBySFaOPAvKUyrpyr0mSIkEQLbnE9PLEkvRjeTP3u9r
         Lf/2SqqW0Hrr7TzPupP47HXXzJFheJz9ROS4z+NoEIcj1QWMCC7C0EC6/HwhvWa2+4e2
         3bgaeuEQEqHemJHKnJ6KI39KUL9bd8sd1fCIYspuJau2WeEJyBUAi7Hok5v5dGAVgUcD
         Pf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792440673; x=1793045473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zR0bKNmFrarT5kXjoovQc4qe3MXIt/ne5IeCkGI3Grs=;
        b=gAJuFVwc7I6nm8B0qDgqBORkKoFU+SQ7LEuK17TBJOdhEZTNkrIg5v1E8hGweT44OL
         tfDsSWYNuKCCtiZbBalVAuGHvrqpwuDAI0gBXYmz0grtS56maiRUV+SLzaDP771T2rs+
         M2YDOZNZGCvwad5Rnr+VGYW3He9ud5bXN8HafyqfigKX/kZFD1H8NH65wd+h7tE93wq5
         kaq9GjPBneFLPtUThPi0DxrbxDEIK/Hlb0SjRnzxnoQv6LGY1/YpJcKVQ+crVBlVrTVD
         GJCEAD6ms84o98Zg8swyRnc0ItkZdqNfbYYAiPz1ReRWDxe6pCzY5YCk8jC1XLuMm+sM
         5hDw==
X-Gm-Message-State: AFq9FYJpUjIZQfkMU2SNLONUBCZRaTmV62sCcTEqElyyDWDbrDJV6NVg
	O4JvQBGb/jobg/n8i0yPESr3A7MzZltSJ2gC9wPjL82rc31yBGAU8wiXhrBCBI+AgxVfg4RuDBK
	xOIp2hzw=
X-Gm-Gg: AYBFou2Nz/2yY3Z8Ks5hAOKPtuBxzAe0zeNDnPkNmASvsVPBbM+PSz0zMQFC8GjxPKJ
	k05v8JJXzPIfV5fJRaaATL0xygG0FVoUk59NEDHB0ZTJZje29vEch/iVA3agT/zLtT+2G2iIQmb
	6aeQcU8hH6vqO29WXWprqy0VaNAU9oEMp1aJuIQGQxDeazkRj424nExiCv02AIVkvmB4uWhM7Gf
	micyQ0oFfB56APaFkOxDz9AG4jYW4q+Qkn83WWsEVrkr7n3vvBJ+91cA4P/r6OrdOZt5PT+OzZw
	3raDYNkuSUttWP7ys5X639nAgJeecJVmeFoZYDjeEX5ahojPBpMsfYC5eSpg2vSmAjRTzCLQqJR
	BWcjBYKK8FGNFi13JOrM98ex46kIeKvFK+OPna/TmTYYZsv71Ak1CUcwAyP4iiX7ZQLbg4sbi5k
	wlFroAp/o3FujEjr8iExWf7vfZC4iOrWlFlAiOKAqyCubqeyMx0MaFMz0/sRt8uIJZvil9QTFTI
	SkCK22pOlPXwWTlAZcWhNH0Q24Bv6I+A7ul
X-Received: by 2002:a17:903:950:b0:2dd:ad73:5b68 with SMTP id d9443c01a7336-2e9a6c1b978mr69983815ad.24.1792440673227;
        Mon, 19 Oct 2026 13:11:13 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea151818f0sm5102585ad.65.2026.10.19.13.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:11:12 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Mykola Lysenko <nickolay.lysenko@gmail.com>
Subject: [PATCH bpf-next v6 2/3] bpf: Fix arena race between page free and alloc leading to incoherency
Date: Mon, 19 Oct 2026 20:11:07 +0000
Message-ID: <20261019201108.4552-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261019201108.4552-1-emil@etsalapatis.com>
References: <20261019201108.4552-1-emil@etsalapatis.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Existing arena kfunc code has an underlying race condition
that can lead to writes being lost from the BPF program's
point of view:

a) A memory range gets freed by operation (1), and its range
is added back to the arena range tree.

b) A concurrent allocation (2) reallocates the range, and does
writes to it. Writes from that CPU may follow the stale TLB
entries into the pages that are about to be freed.

c) (1) invalidates the TLB. The old pages, and any writes done
to them, are now inaccessible. zap_pages() similarly removes the
mappings for userspace threads.

This can be triggered by particularly demanding BPF arena data
structures that constantly allocate and deallocate memory, like
hash table allocations.

Solve this ABA problem by keeping the range allocated until TLB
invalidation and unmapping are complete. Under the arena spinlock,
claim any free pages in the range and clear its kernel PTEs. Then drop
the spinlock, lock and unlock each cleared page to wait for faults that
are still installing a user PTE, flush the kernel TLB and zap the user
page tables. Finally, retake the spinlock to release the range. Frees
serialize on zap_mutex, so an overlapping free cannot release the range
early. Claiming the range only allocates a range tree node when the
whole range is free, and then there is nothing to free.

User faults on a range that is allocated without a page now raise
SIGBUS instead of populating it. That covers a range reserved with
bpf_arena_reserve_pages() and a range whose kernel PTEs a free has
already cleared. Touching a page while a BPF program frees it is a user
space bug, and in a BPF_F_SEGV_ON_FAULT arena it already raises SIGSEGV.

Sleepable frees run synchronously and are deferred only when the arena
spinlock cannot be taken. The deferred free worker retries such a free
in place instead of requeueing itself, so the flush_work() in
arena_map_free() waits for all of its work.

Reported-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Fixes: b8467290edab ("bpf: arena: make arena kfuncs any context safe")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c | 159 +++++++++++++++++++++------------------------
 1 file changed, 73 insertions(+), 86 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 5e0e0837980b..868589f07330 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -543,6 +543,12 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		goto out_err_locked;
 	}
 
+	if (is_range_tree_set(&arena->rt, vmf->pgoff, 1)) {
+		/* Allocated without a page: reserved or being freed */
+		fault_ret = VM_FAULT_SIGBUS;
+		goto out_err_locked;
+	}
+
 	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
 
 	if (!new_page) {
@@ -868,7 +874,7 @@ static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 	 * otherwise call B's mark would make call A skip a vml that A has
 	 * not yet zapped for A's uaddr range.
 	 */
-	mutex_lock(&arena->zap_mutex);
+	lockdep_assert_held(&arena->zap_mutex);
 	mutex_lock(&arena->lock);
 	my_gen = ++arena->zap_gen;
 	for (;;) {
@@ -902,49 +908,41 @@ static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 		mutex_lock(&arena->lock);
 	}
 	mutex_unlock(&arena->lock);
-	mutex_unlock(&arena->zap_mutex);
 }
 
-static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt, bool sleepable)
+/*
+ * The range stays allocated in the range tree until the pages are unmapped
+ * from vmalloc area and from all user space vma-s, so that nobody can
+ * populate it while stale TLB entries or user ptes are still around.
+ */
+static int arena_free_range(struct bpf_arena *arena, long uaddr, long page_cnt)
 {
-	struct mem_cgroup *new_memcg, *old_memcg;
-	u64 full_uaddr, uaddr_end;
-	long kaddr, pgoff;
-	struct page *page;
-	struct llist_head free_pages;
-	struct llist_node *pos, *t;
-	struct arena_free_span *s;
+	u64 full_uaddr = clear_lo32(arena->user_vm_start) + uaddr;
+	long kaddr = bpf_arena_get_kern_vm_start(arena) + uaddr;
+	long pgoff = compute_pgoff(arena, uaddr);
 	struct clear_range_data cdata;
+	struct llist_node *pos, *t;
+	LLIST_HEAD(free_pages);
 	unsigned long flags;
-	int ret = 0;
-
-	/* only aligned lower 32-bit are relevant */
-	uaddr = (u32)uaddr;
-	uaddr &= PAGE_MASK;
-	kaddr = bpf_arena_get_kern_vm_start(arena) + uaddr;
-	full_uaddr = clear_lo32(arena->user_vm_start) + uaddr;
-	if (full_uaddr < arena->user_vm_start)
-		return;
-	uaddr_end = min(arena->user_vm_end, full_uaddr + (page_cnt << PAGE_SHIFT));
-	if (full_uaddr >= uaddr_end)
-		return;
-
-	page_cnt = (uaddr_end - full_uaddr) >> PAGE_SHIFT;
-	pgoff = compute_pgoff(arena, uaddr);
-	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
+	struct page *page;
+	int ret;
 
-	if (!sleepable)
-		goto defer;
+	/* An overlapping free must not release the range before this one is done */
+	guard(mutex)(&arena->zap_mutex);
 
 	ret = raw_res_spin_lock_irqsave(&arena->spinlock, flags);
-
-	/* Can't proceed without holding the spinlock so defer the free */
 	if (ret)
-		goto defer;
+		return ret;
 
-	range_tree_set(&arena->rt, pgoff, page_cnt);
+	/*
+	 * Take the free pages of the range too. It allocates, and can fail,
+	 * only when the whole range is free. Then there is nothing to do.
+	 */
+	if (range_tree_clear(&arena->rt, pgoff, page_cnt)) {
+		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+		return 0;
+	}
 
-	init_llist_head(&free_pages);
 	cdata.arena = arena;
 	cdata.free_pages = &free_pages;
 	/* clear ptes and collect struct pages */
@@ -954,6 +952,12 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	/* drop the lock to do the tlb flush and zap pages */
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 
+	/* wait for arena_vm_fault() that found the page before its pte was cleared */
+	llist_for_each_entry(page, free_pages.first, pcp_llist) {
+		lock_page(page);
+		unlock_page(page);
+	}
+
 	/* ensure no stale TLB entries */
 	flush_tlb_kernel_range(kaddr, kaddr + (page_cnt * PAGE_SIZE));
 
@@ -972,8 +976,39 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 			zap_pages(arena, full_uaddr, 1);
 		__free_page(page);
 	}
-	bpf_map_memcg_exit(old_memcg, new_memcg);
 
+	/* The callers hold no other rqspinlock, so this one can only time out */
+	while (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
+		cond_resched();
+	range_tree_set(&arena->rt, pgoff, page_cnt);
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+	return 0;
+}
+
+static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt, bool sleepable)
+{
+	struct mem_cgroup *new_memcg, *old_memcg;
+	u64 full_uaddr, uaddr_end;
+	struct arena_free_span *s;
+
+	/* only aligned lower 32-bit are relevant */
+	uaddr = (u32)uaddr;
+	uaddr &= PAGE_MASK;
+	full_uaddr = clear_lo32(arena->user_vm_start) + uaddr;
+	if (full_uaddr < arena->user_vm_start)
+		return;
+	uaddr_end = min(arena->user_vm_end, full_uaddr + (page_cnt << PAGE_SHIFT));
+	if (full_uaddr >= uaddr_end)
+		return;
+
+	page_cnt = (uaddr_end - full_uaddr) >> PAGE_SHIFT;
+	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
+
+	/* Can't proceed without holding the spinlock so defer the free */
+	if (!sleepable || arena_free_range(arena, uaddr, page_cnt))
+		goto defer;
+
+	bpf_map_memcg_exit(old_memcg, new_memcg);
 	return;
 
 defer:
@@ -1035,66 +1070,18 @@ static void arena_free_worker(struct work_struct *work)
 {
 	struct bpf_arena *arena = container_of(work, struct bpf_arena, free_work);
 	struct mem_cgroup *new_memcg, *old_memcg;
-	struct llist_node *list, *pos, *t;
+	struct llist_node *pos, *t;
 	struct arena_free_span *s;
-	u64 arena_vm_start, user_vm_start;
-	struct llist_head free_pages;
-	struct clear_range_data cdata;
-	struct page *page;
-	unsigned long full_uaddr;
-	long kaddr, page_cnt, pgoff;
-	unsigned long flags;
-
-	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
-		schedule_work(work);
-		return;
-	}
 
 	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
 
-	init_llist_head(&free_pages);
-	cdata.arena = arena;
-	cdata.free_pages = &free_pages;
-	arena_vm_start = bpf_arena_get_kern_vm_start(arena);
-	user_vm_start = bpf_arena_get_user_vm_start(arena);
-
-	list = llist_del_all(&arena->free_spans);
-	llist_for_each(pos, list) {
-		s = llist_entry(pos, struct arena_free_span, node);
-		page_cnt = s->page_cnt;
-		kaddr = arena_vm_start + s->uaddr;
-		pgoff = compute_pgoff(arena, s->uaddr);
-
-		/* clear ptes and collect pages in free_pages llist */
-		apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
-					     apply_range_clear_cb, &cdata);
-
-		range_tree_set(&arena->rt, pgoff, page_cnt);
-	}
-	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
-
-	/* Iterate the list again without holding spinlock to do the tlb flush and zap_pages */
-	llist_for_each_safe(pos, t, list) {
+	llist_for_each_safe(pos, t, llist_del_all(&arena->free_spans)) {
 		s = llist_entry(pos, struct arena_free_span, node);
-		page_cnt = s->page_cnt;
-		full_uaddr = clear_lo32(user_vm_start) + s->uaddr;
-		kaddr = arena_vm_start + s->uaddr;
-
-		/* ensure no stale TLB entries */
-		flush_tlb_kernel_range(kaddr, kaddr + (page_cnt * PAGE_SIZE));
-
-		/* remove pages from user vmas */
-		zap_pages(arena, full_uaddr, page_cnt);
-
+		while (arena_free_range(arena, s->uaddr, s->page_cnt))
+			cond_resched();
 		kfree_nolock(s);
 	}
 
-	/* free all pages collected by apply_to_existing_page_range() in the first loop */
-	llist_for_each_safe(pos, t, __llist_del_all(&free_pages)) {
-		page = llist_entry(pos, struct page, pcp_llist);
-		__free_page(page);
-	}
-
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 }
 
-- 
2.52.0

