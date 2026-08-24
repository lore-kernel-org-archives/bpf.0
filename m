Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614933A4F32
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 08:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787559937; cv=none; b=VB4EPyzAkL4ECCCSjThF7HeiWsywfF5RVDfplDcyNfxKFzFR8txfCSW7J7DEnbdhQIm5TDhOfQw6Vha2R7rBUlKTScjZ4PPNZCFnVAdgqJXWr8nf1A1UYnGWSicjufAuTf0F6xdUWaLwj24H4yQVKgJfjtRVwdYdMZ8IbQ1Soq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787559937; c=relaxed/simple;
	bh=pXGnjXjhk8pUnqZNBTVYbtydnDv8EwkV61+KlN/tlJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUFRBlyi5cm9ccP7SeKeJBcfx+O1CZqpzeOR20OM534eh4S3+d3tdto/MvkG7LkjDHydN36RY2MsuduA4A/XmKrwNq/34vNhVUxQwVbah9eEAaps8XNrLhno87AixQ8ad7mGN2A1cSTUdVjOjLkVapN6+TKpBnh0hGsbbWPbbSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=KD5AFGG/; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="KD5AFGG/"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so2462468a91.0
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 01:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1787559936; x=1788164736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fwbT5KoN/V9fvTm+wwRylT//chfk91dlGlfRRMLJsX0=;
        b=KD5AFGG/aTOgKMZGiTfHUrGGEjBSLZ1PRTzAsxjKdZn0jJHnUlhgqcvLIp3cIqskSn
         w5oCJ6K6J4lQfuuMQbrChCGNp7aaPGbMTa2N4/0jFwfytuG7dFKhEnYar/DUYGuZCYfG
         GkQ1a5vRrIYUxnqZHik4CoTCQuWq/uo29xP6KRJP1BJxOC7WnOo82W5L/sdNe3xVrsDf
         PJZr4GgCmDyrMcO/XYs8nEcdnPC8KzOuj++fZ1qYnF0t67KrBRREvo+7HmBoLiUmj1Lx
         eHYOnxiXBUEVCHS9UByprNlpC71UG5hS4qfRIawRC+4ahHMc3h+yr8MAGP6ECViewjY2
         mJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787559936; x=1788164736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fwbT5KoN/V9fvTm+wwRylT//chfk91dlGlfRRMLJsX0=;
        b=oJ9ClxlIXniHO045z1+d7SGURHCejLQX6hNMJGs5B5yIsYpIxMKgHNJJWogh2dzS6x
         +wBfS9wsALiRPZ3ZdVEM0WWeX8DCcFExRwdGaZfeKplSCaAp7ApvivwJZi2F0D/XY246
         uEWCn/qAONskDrvoPztzDf8sDLruUuneMXXh/AjytUmkIODxRUL2KDjQpa7OKxp5bTrp
         OwMWJF0ppaWGWjb0D2uNwXhdOcIgzMgYTaBu3CYgtp45OxutW1bs4HnL9VFfcOwB/HkS
         LJFL4CQGVd0KHRJHLs7+tcn3bR7y11sdSVK93FsoRIJsDdUykqMzH3FwVF0ikNUP5sfA
         +ZjQ==
X-Gm-Message-State: AFuF++nFsanjwYjgR0Qzq7VLkbus3RjTmQUN5sPLLm7AYPZa+O+Q1CeU
	ncdxepbhbmDOZBI30SNOF8WBHjfgX5CENMV4pbdAC43Cqy8WeYm+b2RM86+musVrN7ZWUyar3dx
	JhCz/
X-Gm-Gg: AR+sD13eD2/gCyhKEGnhowZDD+9jXd/lmdDFUwhhOWSD28bTqs6/cGuIvgUP3M9xXQs
	yikbSwFAupOOikoNcG0vDlMwE7/UmX7BD+c7HZipsnwHIEz6tZjetOPuGCdJhAb0YsaXRO4Vd7s
	i03L7rLOeRL32SrGLRguDuD7wJqrUrSXsrL82bvgCcPpjPVEfzDszYHvLEskB0x/Dea8UVU+Ndx
	rtPZ8n3LdNnAO41n6z1uJilyeeULSboMo6aWuplJ5FF2LJ62wuWmfPsSbtFnNb2z1eFd9k8u8qb
	ZVPkPsicKPO+fr953Nv9nuNtpElE2p2R8AtDp5PpDD6LVYWth9DdEKkWge8SptJ173rp9SQi0YQ
	j8XRujramLzxJGCP1BPzXk4KKtCX+CS3ydJckDbztFFO1cYvFNL+ACOtZ6p3CpgwFsbtunXNTbW
	V65SE2/KRWjIlAe8b0hH+tyCK8t3yewBu/P9ogMd7Tqj//xBSyeoY1ypG5Fk96cNhiIdv8ga8Oj
	RstGqMVRsnZi/1ZcGjXf3c=
X-Received: by 2002:a17:90a:e7c3:b0:38f:efed:5448 with SMTP id 98e67ed59e1d1-395c371d53amr41522920a91.8.1787559935564;
        Mon, 24 Aug 2026 01:25:35 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b46518sm9518512a91.17.2026.08.24.01.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 01:25:34 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 2/3] bpf: Add sleepable arena page allocation path
Date: Mon, 24 Aug 2026 04:25:29 -0400
Message-ID: <20260824082530.47553-3-emil@etsalapatis.com>
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
 include/linux/bpf.h  |  6 ++++
 kernel/bpf/arena.c   | 76 +++++++++++++++++++++++++++++++++++++++++---
 kernel/bpf/syscall.c |  8 +----
 3 files changed, 79 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ffa5626411ac..d15ed7a3879b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -710,6 +710,12 @@ void bpf_map_free_internal_structs(struct bpf_map *map, void *obj);
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
index da356989786a..126ddae763f9 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -683,8 +683,73 @@ static int arena_adjust_tree(struct bpf_arena *arena, long uaddr, long page_cnt,
 	return range_tree_clear(&arena->rt, *pgoff, page_cnt);
 }
 
-static long arena_alloc_pages_internal(struct bpf_arena *arena, long page_cnt,
-		long uaddr, long pgoff, int node_id, bool sleepable)
+static long arena_alloc_pages_sleepable(struct bpf_arena *arena, long page_cnt,
+		long uaddr, long pgoff, int node_id)
+{
+	u64 kern_vm_start = bpf_arena_get_kern_vm_start(arena);
+	struct apply_range_data data;
+	struct page **pages = NULL;
+	unsigned long flags;
+	u32 uaddr32;
+	int ret, i;
+
+	pages = kvcalloc(page_cnt, sizeof(struct page *), GFP_KERNEL_ACCOUNT);
+	if (!pages)
+		return 0;
+
+	ret = bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages);
+	if (ret) {
+		kvfree(pages);
+		return 0;
+	}
+
+	data.i = 0;
+	data.pages = pages;
+	data.arena = arena;
+
+	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
+		goto out_free_pages;
+
+	ret = arena_adjust_tree(arena, uaddr, page_cnt, &pgoff);
+	if (ret) {
+		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+		goto out_free_pages;
+	}
+
+	uaddr32 = (u32)(arena->user_vm_start + pgoff * PAGE_SIZE);
+
+	ret = apply_to_page_range(&init_mm, kern_vm_start + uaddr32,
+			page_cnt << PAGE_SHIFT, apply_range_set_cb, &data);
+
+	if (ret)
+		goto out_unmap;
+
+	flush_vmap_cache(kern_vm_start + uaddr32, page_cnt << PAGE_SHIFT);
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+
+	kvfree(pages);
+
+	return clear_lo32(arena->user_vm_start) + uaddr32;
+
+out_unmap:
+	/* data.i pages were mapped, undo only those who failed to map */
+	flush_vmap_cache(kern_vm_start + uaddr32, data.i << PAGE_SHIFT);
+	range_tree_set(&arena->rt, pgoff + data.i, page_cnt - data.i);
+
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+
+	arena_free_pages(arena, uaddr32, data.i, true);
+
+out_free_pages:
+	for (i = data.i; i < page_cnt; i++)
+		__free_page(pages[i]);
+
+	kvfree(pages);
+	return 0;
+}
+
+static long arena_alloc_pages_non_sleepable(struct bpf_arena *arena, long page_cnt,
+		long uaddr, long pgoff, int node_id)
 {
 	u64 kern_vm_start = bpf_arena_get_kern_vm_start(arena);
 	struct apply_range_data data;
@@ -762,7 +827,7 @@ static long arena_alloc_pages_internal(struct bpf_arena *arena, long page_cnt,
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 	if (mapped) {
 		flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
-		arena_free_pages(arena, uaddr32, mapped, sleepable);
+		arena_free_pages(arena, uaddr32, mapped, false);
 	}
 
 out_free_pages:
@@ -802,7 +867,10 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 
 	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
 
-	addr = arena_alloc_pages_internal(arena, page_cnt, uaddr, pgoff, node_id, sleepable);
+	if (sleepable && !is_bpf_alloc_nonsleepable())
+		addr = arena_alloc_pages_sleepable(arena, page_cnt, uaddr, pgoff, node_id);
+	else
+		addr = arena_alloc_pages_non_sleepable(arena, page_cnt, uaddr, pgoff, node_id);
 
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6874ba1424af..700ed7a99579 100644
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
2.54.0

