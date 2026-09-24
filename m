Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FB038DC51
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 05:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228189; cv=none; b=JkbR+W7ofByp9QapJPfQZ0kaO+HGVgpgGy6H1BaYrpnFiOze3KzJUo/XxBfhSvHnXR0Yy/UUTYprzDff6ZKn/YCssNzqnvQd28IpyCKW01ysFCKQTGCaMOstB+AqGV1BjQqXxloWBbqJeyRGlZ8DZITM/pQKb/Kkfi74U6NDlhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228189; c=relaxed/simple;
	bh=ukmsY3kh/Lzd3vqtrCVe514MahDODKIG2Z2YOUqZKo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKXoB0KsDKaYigexZ79U9U/S3dE0w21/BYGv4GAy1t8yy2mC5QuZvTUpTFy/6jM6uYOZoKZEdfPEE2TUyi9mn5pDYkiQbNz0vG2kachY8B6UGMDLcX9Ug/z0u9ckVs5COE/T0W5rSvpbFjeDgQUmBZ1CKk62cS22H2HYz7oouxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=EUpQH2Qz; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="EUpQH2Qz"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eb79f6so7860725ad.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790228187; x=1790832987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mmKEWWEJRT65N0DuUUiRcjmQ/CtGr96DRqf7Ay26UhA=;
        b=EUpQH2Qz5u1VUv9lT7snEkjDzMxu9ggGeDYuM5LCM/1Wzv7zmiQToDOXcFRjfGlFZS
         La4I803tAD7j9QmIXdF0uoXOxWaiM231VWb/E/1LJZycnEpqTlSpDpNMurVKgRkYBOLv
         0SykEIEdbyr66sx1M+ZHehOdXXLUco4YrFKNOXOIXW02jCHaAefoRJeEKiRQsZ2aTukI
         gsSkZkuzJ3i8gC5tfxut04WrP/bb4x67LsgetTXptG6Z6sv0e8GTlvG/qRaLjGlVoh6N
         b0zBZ5TzFkjRmR36v36YMxVjREf/ECYmDb9Kfnzd5p9Q4Zcg8Yim7eT2xNVqwAUNKN+e
         F2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790228187; x=1790832987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mmKEWWEJRT65N0DuUUiRcjmQ/CtGr96DRqf7Ay26UhA=;
        b=ZnuMYUVXJOz6LaI/moodVuYfflTEIz/RtsFXKVdgyZB3MUufyldxJioyfcHVg6lHGp
         5gF1AgDpFB+xoFVvzUZ7uMEhdjKkJgE0mxb+1eLfSxfdarjRX2tTX/3j8h8pMvlMoLeb
         Y2iGVX26wdAsaZ8NahQQNOmhdEeqr7pgXEcwrDQdCzf5vGgzEzMpNgXP9bbhvMJVytcc
         iEN5hE+tibk3sQfhDxI/2ynpt4GbwLX943lc5Mak+A5ShnRrljuayWC8F8BAnrNjviCq
         E9pwdoBsWa74qpycSYzXKLx87Mr1IB7s4uF6tS7sPEh9B8G/H4gjv251aMhpPTtJ5RSB
         dnyA==
X-Gm-Message-State: AFuF++mJcHYUZxhCLR3q/ywZrvBykLmSNX7vsD2+ZF3UrLRpY+Jo58dw
	wCdO9PI3sPjXD1HowF2u/feC/2yePEfTf68eavSIbptyidi1cjRMUWV2pcCSyhSlzLBth9PR5ae
	DL7lNSPGl5w==
X-Gm-Gg: AYBFou2rD9nMp6wNc3UPj08bgZn6ksE8iELWuKsigHJwiZuvanxCP0qawufWwaTEYNI
	P3VoIrfYjcSlXxhzuhyJ4XObmmLBmc7i8o/NqPPwk+ne2xx70qtwigmqFwstslqhIVL+KV5HSe3
	0uWUyMR2pKV7wbZsruGGDb/3KhH1j7T8B2ukThXkD/ZLJHBp/7iCsR8NyAZA52c2DjnShJJfJ3L
	YDHnCaEnDxjZi5MchvLIVmkcJNEDmRRPpxFLQCDr3lL6niS7FjwEBdf62h6gK51lw3m3S1Zdoao
	UCDPYayCEe0zrJ19VnRmc1HHaEEknlVaXYb67bLPpSq4rZMLRngLq9OF7T4zwzHdp9ZwRH9gji6
	5MIJmfFa1s8GL4zrV40unO7k4E061yluD7Qd4TKAPyVPbLbp8xpnUH6i/7aQaThKY4an6L4l370
	f8ry618Z6JfCkcw9AjZDjnvrNzGzotXMx59ZwM4M+mmmWxEBnCiyjcLpWTileu39lpY8Pgr71e4
	DHF67slSQeJHJlRleQNtYrwEKiRvyG8ma92+ezenA==
X-Received: by 2002:a17:903:1aed:b0:2dd:ad73:c98b with SMTP id d9443c01a7336-2df7deb7ca8mr11335635ad.35.1790228187165;
        Wed, 23 Sep 2026 22:36:27 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5a4997sm20511265ad.27.2026.09.23.22.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 22:36:26 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v2 1/2] bpf: Add sleepable arena page allocation path
Date: Thu, 24 Sep 2026 05:36:20 +0000
Message-ID: <20260924053621.7076-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260924053621.7076-1-emil@etsalapatis.com>
References: <20260924053621.7076-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_arena_alloc_pages() function currently only allocates pages
inside a spinlock critical section with IRQs off. This forces the use
of alloc_pages_nolock() in the BPF allocator, even when the caller is
a sleepable BPF function. This in turn causes allocation failures even
in cases where falling into the allocator slow path and possibly
sleeping would eventually succeed. This can be triggered consistently
by heavy BPF arena users like scx.

Add a separate arena page allocation path just for sleepable callers.
The path preallocates the arena memory to be added to the tree before
taking the critical section.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf.h  |   6 +++
 kernel/bpf/arena.c   | 123 ++++++++++++++++++++++++++++++-------------
 kernel/bpf/syscall.c |   8 +--
 3 files changed, 92 insertions(+), 45 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e7c5e203eddd..b37e34cf1086 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -720,6 +720,12 @@ void bpf_map_free_internal_structs(struct bpf_map *map, void *obj);
 int bpf_dynptr_from_file_sleepable(struct file *file, u32 flags,
 				   struct bpf_dynptr *ptr__uninit);
 
+static inline bool is_bpf_alloc_nonsleepable(void)
+{
+	return preempt_count() > 0 || irqs_disabled() ||
+		IS_ENABLED(CONFIG_PREEMPT_RT);
+}
+
 #if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
 void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ign, u32 page_cnt, int node_id,
 					  u64 flags);
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index c6369ea5e208..eaeae16bbe7a 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -704,6 +704,27 @@ static u64 clear_lo32(u64 val)
 	return val & ~(u64)~0U;
 }
 
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
 /*
  * Allocate pages and vmap them into kernel vmalloc area.
  * Later the pages will be mmaped into user space vma.
@@ -721,7 +742,9 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	long alloc_pages;
 	unsigned long flags;
 	long pgoff = 0;
+	bool can_sleep;
 	u32 uaddr32;
+	long addr = 0;
 	int ret, i;
 
 	if (node_id != NUMA_NO_NODE &&
@@ -741,31 +764,38 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	}
 
 	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
-	/* Cap allocation size to KMALLOC_MAX_CACHE_SIZE so kmalloc_nolock() can succeed. */
-	alloc_pages = min(page_cnt, KMALLOC_MAX_CACHE_SIZE / sizeof(struct page *));
-	pages = kmalloc_nolock(alloc_pages * sizeof(struct page *), __GFP_ACCOUNT, NUMA_NO_NODE);
-	if (!pages) {
-		bpf_map_memcg_exit(old_memcg, new_memcg);
-		return 0;
+
+	can_sleep = sleepable && !is_bpf_alloc_nonsleepable();
+	if (can_sleep) {
+		alloc_pages = page_cnt;
+		pages = kvcalloc(page_cnt, sizeof(struct page *), GFP_KERNEL_ACCOUNT);
+		if (!pages)
+			goto out_memcg;
+
+		ret = bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages);
+		if (ret)
+			goto out_free_array;
+		data.i = 0;
+	} else {
+		/* Cap allocation size so kmalloc_nolock() can succeed. */
+		alloc_pages = min(page_cnt, KMALLOC_MAX_CACHE_SIZE / sizeof(struct page *));
+		pages = kmalloc_nolock(alloc_pages * sizeof(struct page *), __GFP_ACCOUNT,
+				       NUMA_NO_NODE);
+		if (!pages)
+			goto out_memcg;
 	}
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
@@ -773,12 +803,14 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	while (remaining) {
 		long this_batch = min(remaining, alloc_pages);
 
-		/* zeroing is needed, since alloc_pages_bulk() only fills in non-zero entries */
-		memset(pages, 0, this_batch * sizeof(struct page *));
+		if (!can_sleep) {
+			/* alloc_pages_bulk() only fills in non-zero entries. */
+			memset(pages, 0, this_batch * sizeof(struct page *));
 
-		ret = bpf_map_alloc_pages(&arena->map, node_id, this_batch, pages);
-		if (ret)
-			goto out;
+			ret = bpf_map_alloc_pages(&arena->map, node_id, this_batch, pages);
+			if (ret)
+				goto out_unmap;
+		}
 
 		/*
 		 * Earlier checks made sure that uaddr32 + page_cnt * PAGE_SIZE - 1
@@ -793,35 +825,50 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 					  kern_vm_start + uaddr32 + (mapped << PAGE_SHIFT),
 					  this_batch << PAGE_SHIFT, apply_range_set_cb, &data);
 		if (ret) {
-			/* data.i pages were mapped, account them and free the remaining */
+			/* data.i pages were mapped, account them and free the remaining. */
 			mapped += data.i;
-			for (i = data.i; i < this_batch; i++)
-				free_pages_nolock(pages[i], 0);
-			goto out;
+			if (!can_sleep)
+				for (i = data.i; i < this_batch; i++)
+					free_pages_nolock(pages[i], 0);
+			goto out_unmap;
 		}
 
 		mapped += this_batch;
 		remaining -= this_batch;
 	}
+
 	flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
-	kfree_nolock(pages);
-	bpf_map_memcg_exit(old_memcg, new_memcg);
-	return clear_lo32(arena->user_vm_start) + uaddr32;
-out:
+
+	addr = clear_lo32(arena->user_vm_start) + uaddr32;
+	goto out_free_array;
+
+out_unmap:
+	if (can_sleep)
+		flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
 	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
-	if (mapped) {
-		flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
-		arena_free_pages(arena, uaddr32, mapped, sleepable);
+	if (mapped || can_sleep) {
+		if (!can_sleep)
+			flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
+		arena_free_pages(arena, uaddr32, mapped, can_sleep);
 	}
-	goto out_free_pages;
-out_unlock_free_pages:
-	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+
 out_free_pages:
-	kfree_nolock(pages);
+	if (can_sleep)
+		for (i = data.i; i < page_cnt; i++)
+			__free_page(pages[i]);
+
+out_free_array:
+	if (can_sleep)
+		kvfree(pages);
+	else
+		kfree_nolock(pages);
+
+out_memcg:
 	bpf_map_memcg_exit(old_memcg, new_memcg);
-	return 0;
+
+	return addr;
 }
 
 /*
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 74496fd716d3..d193d84cc33e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -596,15 +596,9 @@ static void bpf_map_release_memcg(struct bpf_map *map)
 }
 #endif
 
-static bool can_alloc_pages(void)
-{
-	return preempt_count() == 0 && !irqs_disabled() &&
-		!IS_ENABLED(CONFIG_PREEMPT_RT);
-}
-
 static struct page *__bpf_alloc_page(int nid)
 {
-	if (!can_alloc_pages())
+	if (is_bpf_alloc_nonsleepable())
 		return alloc_pages_nolock(__GFP_ACCOUNT, nid, 0);
 
 	return alloc_pages_node(nid,
-- 
2.52.0

