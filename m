Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D3B488764
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 23:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792020889; cv=none; b=UIYliGQrZXZglWhYhXiyPFUxrsFtcXkczPf1nxAFIM/PIXze20EuUsDhKGukL/INd+j5BCU4EMBQNE6nD9G7xNf04h8Ahe56AjUFVklNDx72Rix4EGr+z4+8kulkbZQdiqitzvcc9RNCzKl7aP0wZAijkn/6L3kBVtso57zmfgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792020889; c=relaxed/simple;
	bh=a1jh47ZriPUcBLhIMh/upM5u1nC12FS13lvnGs01a9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PoFgD6vONSVqkF92FPNed3ihC6prLjgatdZtWYH+er//5OtzqqNZfKK4jW0hMY27HPo1iXgu7G2CWV6IN9URvE6CkC1EAWqodD5ZeQZ9EMCqY2ozda8UiVRpL6CMsu+PxnSHVCZ8ct5wI5AzIxliHkdWuonpYfJnm0sOQin6QHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=uMf/yX8m; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="uMf/yX8m"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so1938775a12.3
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 16:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792020887; x=1792625687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gy3vTCdtWnUu43UA30q35Zdj15Yl3ETEAgbPrkJJUrM=;
        b=uMf/yX8mEoIcaBhhc5uIyshMtHDJaMeRoU5U8vBbqXAci2lUeEuAi9crZaLzRJq3H3
         es+cZNvdaE7h6ARfcT7S0vzvG5PX9YXgHbPTCybbQGIlX3Tog1TrdskqxPjeRtw28euZ
         znL7IYegGWige5y1z/J9KGQSUBFPsOBi6YaRygERF/qLmzflZeiiF7u0O+Usjq+3Nh/G
         ngtN92/KK65t+MYHJWuPeczyRf3p2p6v2LN21r+kONNQwuClVEXVIQnaC8DwuE32iZqn
         Dm51AkdtrTEgbe8LdLK5yFthk249F3tZJwX7Rh4U8sbaN5foDu4h1SpJbCJ0i/8T4Mre
         NzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792020887; x=1792625687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gy3vTCdtWnUu43UA30q35Zdj15Yl3ETEAgbPrkJJUrM=;
        b=FDQoVc/VZZNDOal11lNk4qTgNGG0gbikHMKlX5uLAYlbC2vwaXdIvmylTOuqHy2zlA
         HQ6BzLi0c3UaHq4I9J/Mi3UHJU71GoYTlKoeX2WFRPFbZzAgoO9KboI5C2nUcGCrJxVu
         1XcsXZ71C81rhO48pfBrG3/HIVin7J+cBbGUazEUIvuwBlZJZ8MUtRdWFyo/P5jbbFv7
         +z3pjQgMbJ91UFSS/M3zqOSmm6Lz660T9/x4wiAZtC3o4Gx5/CqtaQ5lFvtG0qRcQcjw
         JLPO7oAtYPzXZue1gK190Xu46hmHkix7s/O5gaDKwymn/PSLTC+weZjB6YlDocXqdTW1
         iApQ==
X-Gm-Message-State: AFq9FYJ5rdBquaqJcFgZxftVCRD76aNC5bVOsI8NfaGal6X4TkpPzVlK
	aJfQmH7m/XnE98x3+W/MOa/07LXhvLmork1nFLQ7q8O8OhL3Ju2W2GLTXNFgtVAEbym+Vccf74T
	Mak7O97M=
X-Gm-Gg: AYBFou16rrV3NqWlQNuIvKZBLMPvXOCPHHtrjCR1umH3roaDulTBo1v1ibGGAEHKZgi
	HCVt0RWS+TOG3lVS99OZg9azhQsJy1+1FbVyC3px04K9kLjqXB40OjesWGxVe9YEkdmItU8zWH0
	zdrnY1mDBkYQowVTvTVLWxRxdtGIHZa0uV3kXAxNsAUvm+vOFMdBXpEaK7IKcOJNkBFI4zAvHX4
	ywb9HWXJATp8nNvG4+WCaQ9nBwvcUVFMNpmdRo9biTTBXQAzrESTlao4gjqZxbwpwUHuBu/o2lM
	BjW+DOf/02aIeP6BuwxH33QsdPbX1kF8KI8XJV/2g5jsG0Vfeao5wq7WKfvR6kS9IdXxUb/67H3
	mB2BvMxbsr/vZUQ//dQsYXFrMCOSCi2KEe1HWWj3Yq3xsFxkSvjGU8Vb8eWVxvA34TJl2WuT03f
	KG6WX4u7weDZWEtAgDEIYmbNL4ZAGAcmjYw5YqOLmqN9flCaGIIFmPaGJlhkmT5fKBj0dmObUC7
	uB0qqN4YHUcegE0a+h01rWpcWTkM0+projb
X-Received: by 2002:a17:90b:1d03:b0:39e:345b:3322 with SMTP id 98e67ed59e1d1-3ab3a60f97emr13515294a91.23.1792020886628;
        Wed, 14 Oct 2026 16:34:46 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac943e7a98sm1385177a91.6.2026.10.14.16.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 16:34:46 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 1/8] bpf: Use mapping tree to zap arena VMAs
Date: Wed, 14 Oct 2026 23:34:35 +0000
Message-ID: <20261014233442.8392-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261014233442.8392-1-emil@etsalapatis.com>
References: <20261014233442.8392-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Walk the arena's mapping tree under i_mmap_lock_read() instead of dropping
arena->lock and acquiring mmap_lock for each VMA. Remove the need for MM
pins, address revalidation, visitation generations and zap seialization
Give each arena a private anonymous inode through an arena-owned backing
file.

This refactoring is necessary to avoid deadlocks between arena_vm_fault
and page zapping in subsequent patches.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf.h  |  1 +
 kernel/bpf/arena.c   | 97 ++++++++++++++++++--------------------------
 kernel/bpf/syscall.c |  2 +
 3 files changed, 43 insertions(+), 57 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 54144372281c..fd2986686d62 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -89,6 +89,7 @@ struct bpf_map_ops {
 	/* funcs callable from userspace (via syscall) */
 	int (*map_alloc_check)(union bpf_attr *attr);
 	struct bpf_map *(*map_alloc)(union bpf_attr *attr);
+	struct file *(*map_get_file)(struct bpf_map *map, int flags);
 	void (*map_release)(struct bpf_map *map, struct file *map_file);
 	void (*map_free)(struct bpf_map *map);
 	void (*map_free_pre_rcu)(struct bpf_map *map);
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 0ff707707da0..b95ffdb14417 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <linux/anon_inodes.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/cacheflush.h>
 #include <linux/err.h>
+#include <linux/fs.h>
 #include <linux/irq_work.h>
 #include "linux/filter.h"
 #include <linux/llist.h>
@@ -53,6 +55,7 @@ struct bpf_arena {
 	u64 user_vm_start;
 	u64 user_vm_end;
 	struct vm_struct *kern_vm;
+	struct file *file;
 	struct page *scratch_page;
 	struct range_tree rt;
 	/* protects rt and nr_pages */
@@ -62,8 +65,6 @@ struct bpf_arena {
 	struct list_head vma_list;
 	/* protects vma_list */
 	struct mutex lock;
-	u64 zap_gen;
-	struct mutex zap_mutex;
 	struct irq_work     free_irq;
 	struct work_struct  free_work;
 	struct llist_head   free_spans;
@@ -268,6 +269,9 @@ static int populate_pgtable_except_pte(struct bpf_arena *arena)
 				   SZ_4G + GUARD_SZ / 2, apply_range_set_cb, NULL);
 }
 
+/* The backing file must not hold a map reference. */
+static const struct file_operations arena_backing_fops = {};
+
 static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 {
 	struct vm_struct *kern_vm;
@@ -326,12 +330,18 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 	if (err)
 		goto err_free_scratch;
 	mutex_init(&arena->lock);
-	mutex_init(&arena->zap_mutex);
 	raw_res_spin_lock_init(&arena->spinlock);
 	err = populate_pgtable_except_pte(arena);
 	if (err)
 		goto err_destroy_rt;
 
+	arena->file = anon_inode_create_getfile("bpf-map", &arena_backing_fops,
+						NULL, O_RDWR, NULL);
+	if (IS_ERR(arena->file)) {
+		err = PTR_ERR(arena->file);
+		goto err_destroy_rt;
+	}
+
 	return &arena->map;
 
 err_destroy_rt:
@@ -400,6 +410,7 @@ static void arena_map_free(struct bpf_map *map)
 	free_vm_area(arena->kern_vm);
 	range_tree_destroy(&arena->rt);
 	__free_page(arena->scratch_page);
+	fput(arena->file);
 	bpf_map_area_free(arena);
 }
 
@@ -428,10 +439,8 @@ static u64 arena_map_mem_usage(const struct bpf_map *map)
 }
 
 struct vma_list {
-	struct vm_area_struct *vma;
 	struct list_head head;
 	refcount_t mmap_count;
-	u64 zap_gen;
 };
 
 static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
@@ -443,8 +452,6 @@ static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
 		return -ENOMEM;
 	refcount_set(&vml->mmap_count, 1);
 	vma->vm_private_data = vml;
-	vml->vma = vma;
-	vml->zap_gen = 0;
 	list_add(&vml->head, &arena->vma_list);
 	return 0;
 }
@@ -638,6 +645,20 @@ static unsigned long arena_get_unmapped_area(struct file *filp, unsigned long ad
 	return round_up(ret, SZ_4G);
 }
 
+static struct file *arena_map_get_file(struct bpf_map *map, int flags)
+{
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+	struct file *file;
+
+	file = alloc_file_clone(arena->file, flags & (O_ACCMODE | O_NONBLOCK),
+				&bpf_map_fops);
+	if (!IS_ERR(file)) {
+		file->private_data = map;
+		file_set_fsnotify_mode(file, FMODE_NONOTIFY);
+	}
+	return file;
+}
+
 static int arena_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
 {
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
@@ -692,6 +713,7 @@ BTF_ID_LIST_SINGLE(bpf_arena_map_btf_ids, struct, bpf_arena)
 const struct bpf_map_ops arena_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
 	.map_alloc = arena_map_alloc,
+	.map_get_file = arena_map_get_file,
 	.map_free = arena_map_free,
 	.map_direct_value_addr = arena_map_direct_value_addr,
 	.map_mmap = arena_map_mmap,
@@ -835,60 +857,21 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
  */
 static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 {
+	struct address_space *mapping = arena->file->f_mapping;
 	unsigned long size = (unsigned long)page_cnt << PAGE_SHIFT;
+	pgoff_t first = compute_pgoff(arena, uaddr);
+	pgoff_t last = first + page_cnt - 1;
 	struct vm_area_struct *vma;
-	struct mm_struct *mm;
-	struct vma_list *vml;
-	unsigned long vm_start;
-	u64 my_gen;
-
-	/*
-	 * Taking mmap_read_lock() under arena->lock would deadlock against
-	 * arena_vm_close(), which runs with mmap_write_lock held and then
-	 * acquires arena->lock. Drop arena->lock for mmap_read_lock().
-	 *
-	 * Use per-call my_gen, recorded in vml->zap_gen, to remember which
-	 * vmls this invocation has already processed across the lock drop.
-	 * Hold zap_mutex around the whole walk so concurrent zap_pages()
-	 * callers cannot overwrite each other's marks on shared vmls --
-	 * otherwise call B's mark would make call A skip a vml that A has
-	 * not yet zapped for A's uaddr range.
-	 */
-	mutex_lock(&arena->zap_mutex);
-	mutex_lock(&arena->lock);
-	my_gen = ++arena->zap_gen;
-	for (;;) {
-		mm = NULL;
-		list_for_each_entry(vml, &arena->vma_list, head) {
-			if (vml->zap_gen >= my_gen)
-				continue;
-			vml->zap_gen = my_gen;
-			if (!mmget_not_zero(vml->vma->vm_mm))
-				continue;
-			mm = vml->vma->vm_mm;
-			vm_start = vml->vma->vm_start;
-			break;
-		}
-		if (!mm)
-			break;
-		mutex_unlock(&arena->lock);
 
-		mmap_read_lock(mm);
-		/*
-		 * Re-resolve: while we waited the VMA could have been unmapped
-		 * and a different mapping installed at the same address.
-		 */
-		vma = find_vma(mm, vm_start);
-		if (vma && vma->vm_start == vm_start &&
-		    vma->vm_file && vma->vm_file->private_data == &arena->map)
-			zap_vma_range(vma, uaddr, size);
-		mmap_read_unlock(mm);
-		mmput(mm);
-
-		mutex_lock(&arena->lock);
+	/* The mapping lock keeps VMAs stable without taking mmap_lock. */
+	i_mmap_lock_read(mapping);
+	mapping_rmap_tree_foreach(vma, mapping, first, last) {
+		if (vma->vm_ops != &arena_vm_ops ||
+		    vma->vm_file->private_data != &arena->map)
+			continue;
+		zap_vma_range(vma, uaddr, size);
 	}
-	mutex_unlock(&arena->lock);
-	mutex_unlock(&arena->zap_mutex);
+	i_mmap_unlock_read(mapping);
 }
 
 static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt, bool sleepable)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 654f896af265..1a1cc305dabb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1209,6 +1209,8 @@ int bpf_map_new_fd(struct bpf_map *map, int flags)
 	if (ret < 0)
 		return ret;
 
+	if (map->ops->map_get_file)
+		return FD_ADD(flags | O_CLOEXEC, map->ops->map_get_file(map, flags));
 	return anon_inode_getfd("bpf-map", &bpf_map_fops, map,
 				flags | O_CLOEXEC);
 }
-- 
2.52.0

