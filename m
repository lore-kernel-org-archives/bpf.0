Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D821D3A5445
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787559936; cv=none; b=hBAsvCZgOff4LSestozznfdLIosSn9tmsZGv8OR6YuarAh1YsNynnU6vG9+3uDXRDZATMpDWT0uDidp6AjJ6u+JTLMsEsdMyDttB82QiyiW/DSiZJBZYWYKUH10YFwXZZaw2fAktjp6pF0O7UD8eFDuyzS6Nw7+V4ukjMRlkaTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787559936; c=relaxed/simple;
	bh=J+4G0G8PystxgAQ46m2zEB/QiHUSj1jydmGcK4vJPmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvUbNszLAynxToHVPrmyysNPgrdutgQIh8kfo2+XwgMVqSI2Zpm1xGVeZKO/PJkQw0noqGdXIeeipBROFN8qlFJcJeCqnvldzTtRzEHYkpYskIm2N8n5xYDPldsPAtGTsKDAxUXGiKnGcPTtIE7kHVm1Mwz73fPBSJms7LRpTGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=KEcNsuIx; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="KEcNsuIx"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-381b831d535so4539092a91.0
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 01:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1787559934; x=1788164734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KjNvRi0uk/gcMbZSSAyzuzHQxBV8olxaPEx9qmKXlFM=;
        b=KEcNsuIxeBAmkcVd9/feMgdjtRJ8cSkQ9/dbvrfW2K08Ixexjqpw+S9soEoMN0DUPw
         ZC5C5gjyhJk+vp0TeAvMJjnTG9UIBPYKiBu3lujAMVGdYT8AyMdxojbztmzNCuNbkBIC
         rV3gDJ5ttri5T2duQqKC8GKXb0rJStNdS3c5k6ivI+SsL35j2XG2jv/x4A6KFyuaxFKQ
         82T/Yrx09OM7fGN8qiq0Jrrz61rpMQyIKrxmoxKRC+EuDr6j8yHkYYHba5oZW4fzOKDh
         eIw1IkSOq8IV2ke3EX2LklhYF8WprFpoppaZMvCviExy1/UFB0e4XvsfwaEcCc0BtZxr
         ihAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787559934; x=1788164734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KjNvRi0uk/gcMbZSSAyzuzHQxBV8olxaPEx9qmKXlFM=;
        b=RarYOv9G9SqKd9XCn47BkGUqXTrCsF5iozLlvXwI95jt5l966bfBkeQjLXGKrUxctr
         +JfjdzEZ+X8+EUV3uaJBgvOQeEMtpG38F/lYSQQiZAD9q1vIsWs/J4xsvJcZbvEhHTd4
         uQjhLJ5On5BZ8tBOf9xdDRgtgewS5jgtj4tDS8vhk35rp3la+OUWHQoUw5ONX5Bjy6wf
         crxL/XfknvIjjB2/kdIBVWi0YSYd+g+NBgMb45VJuTO8mnbeZ17Pv5tHDTVWvpY0vQmH
         bptIQYPN/n8XgTlH7NbqRgkQHmVMc4ZPxDozFH56CuFvAodyS7OUvJBKXe1XUuDXBUs1
         M0PQ==
X-Gm-Message-State: AFuF++lnod9OdDDVZEuFaW0uIeiYRMETDRBKoDzMnie06jWs0naYkJJn
	v3UvDwERqmePiJpwbcPmFRrfW0eCuM5WJK7nQMJO19lMhxJtpbceHvbml/i0vOxjiC8NFXU8Gfm
	Ckp65
X-Gm-Gg: AR+sD10/j8wVuyRX8833/2oXnqYtdKEvcz1z1jx7bGq1ds7oPVaw/BjaF20zljeBx9z
	UMMkr+Upr5K/sKsodqqjxe0bVRptYXiFpv7GftqNyP1lUfp6qo/6Nti2y4wPefDpgYmsVlZCRbQ
	z7iO/36jLjPSetPf2necRJ9Z1zmqSI7ISrWMuhrVxrPjEHNvFCLEonK/hFERbGcrI6SbGFnqP7V
	kRj2sXthZrVtYGzFGT8YX04Nhxdgss64vDP3woYSY+ECXWl4V82+W+oLGILgm4xQ40khJWrKgJm
	ghGbxfhb6/HB1cjqQrEdQo2Am6wvuYrPEOrLFZdYy4B7P6cGgbF/G4irohgcy0xM9LcTtjn4d58
	ulUSrdTGigOXlIql3LmioR7o/lIGHUlpG9RZA6sve9XvPCl6BbxEn12t4h4gbLCRNcRqN5ZRarY
	pGBaSwC5nCAHVrc21nr9Yd6S9J6TODsGNDPWH47ft0H5pvPiwfGk3O74YX8N4TGyag0W5p8xuuE
	gVOwPjDO5OVucwRmLqTEfhpivdVgQwqwg==
X-Received: by 2002:a17:90b:3c84:b0:390:b41a:b92b with SMTP id 98e67ed59e1d1-395c3542369mr48620531a91.4.1787559933977;
        Mon, 24 Aug 2026 01:25:33 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b46518sm9518512a91.17.2026.08.24.01.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 01:25:33 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 1/3] bpf: Factor out nonsleepable arena allocation logic
Date: Mon, 24 Aug 2026 04:25:28 -0400
Message-ID: <20260824082530.47553-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824082530.47553-1-emil@etsalapatis.com>
References: <20260824082530.47553-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_arena_alloc_pages() is supposed to transparently choose whether
to use _nolock() allocation variants or not depending on the caller's
context. This is implemented internally by testing the context a
__bpf_alloc_page call is made in. However, the implementation of
bpf_arena_alloc_pages() forces the use of the _nolock() variants by
calling __bpf_alloc_page after disabling IRQs by taking a spinlock.
This in turn causes spurious allocation failures for some workloads
like scx schedulers due to ZONE_NORMAL falling below the minimum
watermark, even though the caller is sleepable could wait until
there is memory available.

To fix this we need to call __bpf_alloc_page outside of the spinlock
critical section when the allocation is called from a sleepable BPF
function. As a first step, refactor the existing logic to simplify
adding the path in the next commit.

No functional changes in this patch. The followup will add a proper
sleepable path.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c | 126 +++++++++++++++++++++++++++------------------
 1 file changed, 77 insertions(+), 49 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 7b6847200b43..da356989786a 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -661,68 +661,57 @@ static u64 clear_lo32(u64 val)
 	return val & ~(u64)~0U;
 }
 
-/*
- * Allocate pages and vmap them into kernel vmalloc area.
- * Later the pages will be mmaped into user space vma.
- */
-static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt, int node_id,
-			      bool sleepable)
+
+static int arena_adjust_tree(struct bpf_arena *arena, long uaddr, long page_cnt, long *pgoff)
+{
+	int ret;
+
+	/* Special case where user is requesting specific range. */
+	if (uaddr) {
+		ret = is_range_tree_set(&arena->rt, *pgoff, page_cnt);
+		if (ret)
+			return ret;
+		return range_tree_clear(&arena->rt, *pgoff, page_cnt);
+	}
+
+	ret = range_tree_find(&arena->rt, page_cnt);
+	if (ret < 0)
+		return ret;
+
+	*pgoff = ret;
+
+	return range_tree_clear(&arena->rt, *pgoff, page_cnt);
+}
+
+static long arena_alloc_pages_internal(struct bpf_arena *arena, long page_cnt,
+		long uaddr, long pgoff, int node_id, bool sleepable)
 {
-	/* user_vm_end/start are fixed before bpf prog runs */
-	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;
 	u64 kern_vm_start = bpf_arena_get_kern_vm_start(arena);
-	struct mem_cgroup *new_memcg, *old_memcg;
 	struct apply_range_data data;
 	struct page **pages = NULL;
 	long remaining, mapped = 0;
 	long alloc_pages;
 	unsigned long flags;
-	long pgoff = 0;
 	u32 uaddr32;
 	int ret, i;
 
-	if (node_id != NUMA_NO_NODE &&
-	    ((unsigned int)node_id >= nr_node_ids || !node_online(node_id)))
-		return 0;
-
-	if (page_cnt > page_cnt_max)
-		return 0;
-
-	if (uaddr) {
-		if (uaddr & ~PAGE_MASK)
-			return 0;
-		pgoff = compute_pgoff(arena, uaddr);
-		if (pgoff > page_cnt_max - page_cnt)
-			/* requested address will be outside of user VMA */
-			return 0;
-	}
-
-	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
 	/* Cap allocation size to KMALLOC_MAX_CACHE_SIZE so kmalloc_nolock() can succeed. */
 	alloc_pages = min(page_cnt, KMALLOC_MAX_CACHE_SIZE / sizeof(struct page *));
 	pages = kmalloc_nolock(alloc_pages * sizeof(struct page *), __GFP_ACCOUNT, NUMA_NO_NODE);
-	if (!pages) {
-		bpf_map_memcg_exit(old_memcg, new_memcg);
+	if (!pages)
 		return 0;
-	}
+
 	data.arena = arena;
 	data.pages = pages;
 
 	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
 		goto out_free_pages;
 
-	if (uaddr) {
-		ret = is_range_tree_set(&arena->rt, pgoff, page_cnt);
-		if (ret)
-			goto out_unlock_free_pages;
-		ret = range_tree_clear(&arena->rt, pgoff, page_cnt);
-	} else {
-		ret = pgoff = range_tree_find(&arena->rt, page_cnt);
-		if (pgoff >= 0)
-			ret = range_tree_clear(&arena->rt, pgoff, page_cnt);
+	ret = arena_adjust_tree(arena, uaddr, page_cnt, &pgoff);
+	if (ret) {
+		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+		goto out_free_pages;
 	}
-	if (ret)
-		goto out_unlock_free_pages;
 
 	remaining = page_cnt;
 	uaddr32 = (u32)(arena->user_vm_start + pgoff * PAGE_SIZE);
@@ -735,7 +724,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 
 		ret = bpf_map_alloc_pages(&arena->map, node_id, this_batch, pages);
 		if (ret)
-			goto out;
+			goto out_unmap;
 
 		/*
 		 * Earlier checks made sure that uaddr32 + page_cnt * PAGE_SIZE - 1
@@ -754,31 +743,70 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 			mapped += data.i;
 			for (i = data.i; i < this_batch; i++)
 				free_pages_nolock(pages[i], 0);
-			goto out;
+			goto out_unmap;
 		}
 
 		mapped += this_batch;
 		remaining -= this_batch;
 	}
+
 	flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+
 	kfree_nolock(pages);
-	bpf_map_memcg_exit(old_memcg, new_memcg);
+
 	return clear_lo32(arena->user_vm_start) + uaddr32;
-out:
+
+out_unmap:
 	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 	if (mapped) {
 		flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
 		arena_free_pages(arena, uaddr32, mapped, sleepable);
 	}
-	goto out_free_pages;
-out_unlock_free_pages:
-	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+
 out_free_pages:
 	kfree_nolock(pages);
-	bpf_map_memcg_exit(old_memcg, new_memcg);
 	return 0;
+
+}
+
+/*
+ * Allocate pages and vmap them into kernel vmalloc area.
+ * Later the pages will be mmaped into user space vma.
+ */
+static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt, int node_id,
+			      bool sleepable)
+{
+	/* user_vm_end/start are fixed before bpf prog runs */
+	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;
+	struct mem_cgroup *new_memcg, *old_memcg;
+	long addr;
+	long pgoff = 0;
+
+	if (node_id != NUMA_NO_NODE &&
+	    ((unsigned int)node_id >= nr_node_ids || !node_online(node_id)))
+		return 0;
+
+	if (page_cnt > page_cnt_max)
+		return 0;
+
+	if (uaddr) {
+		if (uaddr & ~PAGE_MASK)
+			return 0;
+		pgoff = compute_pgoff(arena, uaddr);
+		if (pgoff > page_cnt_max - page_cnt)
+			/* requested address will be outside of user VMA */
+			return 0;
+	}
+
+	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
+
+	addr = arena_alloc_pages_internal(arena, page_cnt, uaddr, pgoff, node_id, sleepable);
+
+	bpf_map_memcg_exit(old_memcg, new_memcg);
+
+	return addr;
 }
 
 /*
-- 
2.54.0

