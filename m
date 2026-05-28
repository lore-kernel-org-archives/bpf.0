Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC8C1891A9
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 22:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780006819; cv=none; b=H/mo1ok2LeT3eRVHefdnwB6/vUAACIMNm5FOIZv1tfz3+DbbexqZIQoRD9mbxqdb8MQqgC5QbTkk7dmkj0H9rJ/LLvFzagx2o5WInnOQezAah/HCidA9G9GD6kRGceFuF3bu38pT0BFjEfSGevmw4jQOOZfTa5ZKuhS7HVuAt7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780006819; c=relaxed/simple;
	bh=E1xgUHxsoibtP9dmPmVVrWJfnFOxLK2gfRFkOZNxH9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jytSh8k+d+96isya1m1IlorrN58AMOVxAGBB9S9UQasdWvc/rElJnwi0BSmHh304OYrKdYntrbT7/F0cGIPYrRbaO5mjchNpX7dYpT3InnrdVlTMe38+KgkuHuVeN9t0C8gLbDDdvAJUFeyd8oD//rDFz0dDHVCBIZb2MUvouR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9tw/Lmg; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9tw/Lmg"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2baca4df358so84986535ad.2
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 15:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780006817; x=1780611617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lzY/wX1m+wTmdwzLRFfROd6PO1yLrCOxW0YfULxOR4E=;
        b=N9tw/Lmg5FGBxVXIiYfTpUfquJK/FTYecpZg94gkQUOnWM3/95eBV1ETXKhLZAakyZ
         sqYkGNX/27BhwQ+Wu/svItT4rFTnEIdcKfM/48hB5FHLCZFmuQqLv2o1RzPGftLySTzR
         iAN8lev0ln97ljGNn6QOEAjkdTTjyUETYvAxwEuVfdY3etpodB1FK2VoloBLCj3Rh5z1
         lggMgOduF2hGhF9U6SDmLUdXxwWKaU7t0f63plG2AmOd6YvuLOhIsSp/zPUgZzv+FecR
         DjouAEsOa8L9UVj1uu+dXSByNSyQPdFXmULYar9chQwZUnrluuictZ+E7BZA1nj5fKtU
         tqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780006817; x=1780611617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzY/wX1m+wTmdwzLRFfROd6PO1yLrCOxW0YfULxOR4E=;
        b=M0TDf1i0xwh20Om6W0ntnbnO3B3Z6W914DyNoZf/qESyOL+o6RA+Y0fckpnE4TZFvC
         3BbF32Ypbdd48+E05O3TAf6F2eNYu3ZgLLEJAj4k+STtzEnTIx0eN67+5ildJ1Aq4KsA
         YEQHJ79QVh4+1pJessyv6k8pnzxacHue7aHveZ+mF+Z72vw8e/dQm1LxllCrgtdT7BUK
         L9a5bX//wkkXBrz0cy6OR0A5CBxSdFrk761zwcZQxS0eaPh45mRsfXFzRtVkvcDnoSzl
         jgk8Rnrc6TNwVHOqjit1o7eE9KkAT1tiwIWTB5/kvQViX0F+P310ERCn7sFTMZ8+2L+3
         A7nw==
X-Gm-Message-State: AOJu0Yxt0/TQrqDABYIyOkJTZHDw7biduYRCBFEV34jNgPTlsjMIbctd
	c8gaGtTelC28ai9oiK0XbASeiNNP04Sms2Xb84TYz5CQ0VL+ZCwCVv9vfHnsjA==
X-Gm-Gg: Acq92OG/hhCaGbEmvc2oNfNq+OlhReXCVCU7WEvsNqPKWYAAXKWQnbl7RSStk9cSIIM
	zXIjSH2YKCUujhgKIESedqchPVm7WOsERt+Fymlv92dEWDha2dwgkaKmXo8u5bPOYw8X9VaYYl3
	JO/x9DMvd0aaBqfTXASVa2kNj7brsFlUvgAZSAzJVF70mfHyHR+v8H/kDSmkweNbMfXQpz4eibX
	Jg6uoeyEFepXSxPeYLq5hLMXWir6npVK3hQjS/f56E034C9XcvsDNnZ+IOim+VYxl5ldz9Q/Sp4
	vFCOQbCAEI46lY+pzxqJoXsUlv1heBFUHScWL1vZzA35WzU8d4JSkv4tpQMEXpfzjeVzEhhD7rc
	yhuPsKFW+hQy/ek1YWH94+fJ4pnb3y6SLyCrGSDSZat/p6W6/v1R5inejmaF/98z/tq01tML754
	pdUef/aZd9BEoz6D/Nbr/RyVRT23KqB/P0Cn0ulh/L1a5+G9l49W83dZq71jHXP4GDeyoLVWHwr
	gLnR0pyA/JJRjB7M+lFM9oLCH0V+4OzN4RE50uhQm4dvYgRvJmLAkrLMs1L6wm7hmsl5HbO
X-Received: by 2002:a17:903:196b:b0:2b0:5ae9:ee4 with SMTP id d9443c01a7336-2bf204d9ea5mr3890855ad.5.1780006817097;
        Thu, 28 May 2026 15:20:17 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf21d297fcsm359455ad.62.2026.05.28.15.20.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 May 2026 15:20:16 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	david@kernel.org,
	tj@kernel.org,
	linux-mm@kvack.org
Subject: [PATCH bpf-next] bpf: Take mmap_lock in zap_pages()
Date: Thu, 28 May 2026 15:20:14 -0700
Message-ID: <20260528222014.38980-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

zap_vma_range() requires the owning mm's mmap_lock to be held.

Taking mmap_read_lock under arena->lock would AB-BA against
arena_vm_close() and arena_map_mmap(), both of which run with
mmap_write_lock held and then acquire arena->lock. Instead drop
arena->lock, mmget_not_zero() the vma's mm, take mmap_read_lock, and
re-resolve the vma via find_vma() since it may have been unmapped or
replaced while waiting.

Track processed vmls with a per-call generation in vml->zap_gen and
serialize zap_pages() callers with a new arena->zap_mutex so
concurrent callers on different uaddr ranges do not mark each other's
vmls processed before the zap is done.

Reported-by: David Hildenbrand <david@kernel.org>
Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/arena.c | 61 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 1727503b25d8..9b2dea229b38 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -60,6 +60,8 @@ struct bpf_arena {
 	struct list_head vma_list;
 	/* protects vma_list */
 	struct mutex lock;
+	u64 zap_gen;
+	struct mutex zap_mutex;
 	struct irq_work     free_irq;
 	struct work_struct  free_work;
 	struct llist_head   free_spans;
@@ -289,6 +291,7 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 	if (err)
 		goto err_free_scratch;
 	mutex_init(&arena->lock);
+	mutex_init(&arena->zap_mutex);
 	raw_res_spin_lock_init(&arena->spinlock);
 	err = populate_pgtable_except_pte(arena);
 	if (err)
@@ -391,6 +394,7 @@ struct vma_list {
 	struct vm_area_struct *vma;
 	struct list_head head;
 	refcount_t mmap_count;
+	u64 zap_gen;
 };
 
 static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
@@ -403,6 +407,7 @@ static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
 	refcount_set(&vml->mmap_count, 1);
 	vma->vm_private_data = vml;
 	vml->vma = vma;
+	vml->zap_gen = 0;
 	list_add(&vml->head, &arena->vma_list);
 	return 0;
 }
@@ -746,12 +751,60 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
  */
 static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 {
+	unsigned long size = (unsigned long)page_cnt << PAGE_SHIFT;
+	struct vm_area_struct *vma;
+	struct mm_struct *mm;
 	struct vma_list *vml;
+	unsigned long vm_start;
+	u64 my_gen;
 
-	guard(mutex)(&arena->lock);
-	/* iterate link list under lock */
-	list_for_each_entry(vml, &arena->vma_list, head)
-		zap_vma_range(vml->vma, uaddr, PAGE_SIZE * page_cnt);
+	/*
+	 * Taking mmap_read_lock() under arena->lock would deadlock against
+	 * arena_vm_close(), which runs with mmap_write_lock held and then
+	 * acquires arena->lock. Drop arena->lock for mmap_read_lock().
+	 *
+	 * Use per-call my_gen, recorded in vml->zap_gen, to remember which
+	 * vmls this invocation has already processed across the lock drop.
+	 * Hold zap_mutex around the whole walk so concurrent zap_pages()
+	 * callers cannot overwrite each other's marks on shared vmls --
+	 * otherwise call B's mark would make call A skip a vml that A has
+	 * not yet zapped for A's uaddr range.
+	 */
+	mutex_lock(&arena->zap_mutex);
+	mutex_lock(&arena->lock);
+	my_gen = ++arena->zap_gen;
+	for (;;) {
+		mm = NULL;
+		list_for_each_entry(vml, &arena->vma_list, head) {
+			if (vml->zap_gen >= my_gen)
+				continue;
+			vml->zap_gen = my_gen;
+			if (!mmget_not_zero(vml->vma->vm_mm))
+				continue;
+			mm = vml->vma->vm_mm;
+			vm_start = vml->vma->vm_start;
+			break;
+		}
+		if (!mm)
+			break;
+		mutex_unlock(&arena->lock);
+
+		mmap_read_lock(mm);
+		/*
+		 * Re-resolve: while we waited the VMA could have been unmapped
+		 * and a different mapping installed at the same address.
+		 */
+		vma = find_vma(mm, vm_start);
+		if (vma && vma->vm_start == vm_start &&
+		    vma->vm_file && vma->vm_file->private_data == &arena->map)
+			zap_vma_range(vma, uaddr, size);
+		mmap_read_unlock(mm);
+		mmput(mm);
+
+		mutex_lock(&arena->lock);
+	}
+	mutex_unlock(&arena->lock);
+	mutex_unlock(&arena->zap_mutex);
 }
 
 static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt, bool sleepable)
-- 
2.53.0-Meta

