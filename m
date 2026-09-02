Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A558134CFDA
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 07:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332567; cv=none; b=M+4K0JDYFtgr75agq7jaIn6+AXTyMGRyF7S4W9ILNqe1BMu+IHZbM3g7frLXzvg/hGf5wIK7zm00fhQTD6P9/XUzSGeUVhMQsKRC0Rlas5qibgQdD+SXjEXrAbVr1PP36r81yPVNwPOQAEqUWBHt6WDjNTmtXWP59I2fZ2TYhYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332567; c=relaxed/simple;
	bh=FWJ4stsZXpkOzRK7ILGndAu5EzuM8oJTV7zUW64BchY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQLr3mWjNYtxzFgDlndNG2B3fRX6X6PeCOrUY4FkOE+jCXMzVMtUfwj+Mha0lqCgZkNYpmSvO61/qtlSH2iB6d1KBhBIOQCBVXCsufLK/NMQ+X+UyYOAf7tV/jqMJY6mDG57O5Y0HNoUWL/5ntFO420o8IXeSUFDXNXg1KV8nJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=RMEH9vel; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="RMEH9vel"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cf452def93so18314815ad.1
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 00:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788332565; x=1788937365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PLcDh0imiRrm2ADyuL3rFRZXq6A61sItu0uQrYiDnQE=;
        b=RMEH9velr1PaKld566qBpbZU+NuMPHQ+/sn9Yxz75g+mMKg+NUVcNKEsI2lFJ/FA3U
         2iw+wgP399c9vY4PAvn0qKawhI2rVJ/3Fpkw1Hs+mXGVzR6dvTu8dzachGCul4cxEEw6
         RafcLv/tpSKye575c5qK5OiL16pj9nROpy3dm73iFgRguZ6Mucej3h9vHgfG003aYZp4
         TfzqcDRrbi8VOP9eLpnlSk+IexmabSMO0np8+AP9dpZMkPriPtPGoWkptr9GUrDlUUQG
         EVzZlQgmufAwJICT8v0aMJI2wE1nTuNTfX/lGkRaeJLL3qQ75mKjV/ynaD+qHe4vllZD
         QGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788332565; x=1788937365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PLcDh0imiRrm2ADyuL3rFRZXq6A61sItu0uQrYiDnQE=;
        b=WGi652UT+3BxmhpF7szeF+c5hrPi4Jm70+5+6j5Iq++ttVe1HM/Q14PskhXNESxnhr
         L+o/ndJ/H2IfVlqS/VqmiEZhrmJEMqMeyzCDdL37wpzdD0IH62PkNMx5wYz8+zOfO3cX
         WQAB3+L2J9Z70ZNFP3Xwy1ZMCoJ3s5yJJWRmjxX2tLKLU6KWXTi+ukwuV2tUO0DbyvJ1
         pE0xyVoB6SlM2ECWVCRXbLi2bKHe+5cqlFHyKzKazCOHJmxTZZndGSBk0yrCjGPN3yl6
         Hkeqto4LjemNDDyvGFPs3vZQ5IeSErm2BJEzQefMjSWQdxp5Sz1FXOr++PirrWiUeVP5
         zg1A==
X-Gm-Message-State: AFuF++lwC8TyZhE/AhRo4A41TT4JDNzwPgO7r7gotrasTKLe3wgEyqd2
	9ehMBKL+YxPt6/h0Ozf4x21uz7xCaC7b7/2nGLoXKSYQZ2IRT6XfA+jopVR6OCCPD8wUcNpHHV5
	rwSSe3ao=
X-Gm-Gg: AYBFou3mSGIM9t5wjmJ75gP6fO9PBWJ1ons3ngaOeIJsNGAKLsjkxke3RLo1m16wTBS
	8qkqFX3f5Dk7n08Hp6edoWNxCrmOw+j9fcW7seZ/lz+MdmOAEpjNqPuaPNjyVo1WiV/EpGLbmCr
	R7unOMtShJXnezlxkcFqR48PV4Mqe+kKRy2oJv8CeXeUiB6QI8vK+LShYf6bzpzStZtcyqUtLwr
	TwtfIv6utCbr2xeeiLGk6NZuFF0FvP3kkUIpbdCYOshMl82sL/0K805pdZmfr9PDXbxtxe87UlL
	M0I/cj/qKfecRk0R08ZMIbDVJEyXU2QHh4HYw73ehROIL0eHL85TLL46sDSAqR/XklTQbtOknSR
	FAjJA0f7Ok7bayCht1Ve03kgvIq2p36sAUma8AYI+cG4u+QW1LCrlbdDD/Nwd7FNI/JjZk5naAK
	4VpeN9cxOkAgKZYxdZZyiEKdROnh8WeSojgMj2f62BOPRFDgfn3kiSfTOhB0026oeXPKCrt/xEo
	88SGXj29kJ7kIGb3bX/NUY=
X-Received: by 2002:a17:90b:1d4d:b0:398:9bd3:d6d4 with SMTP id 98e67ed59e1d1-39af6570371mr828833a91.14.1788332564925;
        Wed, 02 Sep 2026 00:02:44 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae05e21bcsm3793352a91.0.2026.09.02.00.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:02:44 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	nickolay.lysenko@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 3/5] bpf: Fix arena race between page free and alloc leading to incoherency
Date: Wed,  2 Sep 2026 03:02:37 -0400
Message-ID: <20260902070239.16968-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902070239.16968-1-emil@etsalapatis.com>
References: <20260902070239.16968-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Existing arena kfunc code has an underlying race condition
that can lead to writes being lost from the BPF program's
point of view:

a) A memory range gets gets freed by operation (1), and its
range is added back to the arena range tree.

b) A concurrent allocation (2) reallocates the range, and does
writes to it. Writes from that CPU may follow the stale TLB
entries into the pages that are about to be freed.

c) (1) invalidates the TLB. The old pages, and any writes done
to them, are now inaccessible. zap_pages() simlarly removes the
mappings for userspace threads.

This can be triggered by particularly demanding BPF arena data
structures that constantly allocate and deallocate memory, like
hash table allocations.

Solve this ABA problem by preventing range reallocation until
TLB invalidation/unmapping is complete. First, mark the range
freed but unavailable. Afterwards, drop the spinlock lock and
flush the kernel TLB and zap user page tables. Then pick up
the lock again and mark the ranges as available once again,
completing the free operation.

Reported-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c | 94 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 85 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index f49b52fa8586..d22b71a791db 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -76,6 +76,7 @@ struct arena_free_span {
 	struct llist_node node;
 	unsigned long uaddr;
 	u32 page_cnt;
+	bool release_only;
 };
 
 u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
@@ -855,6 +856,7 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	struct arena_free_span *s;
 	struct clear_range_data cdata;
 	unsigned long flags;
+	bool release_only = false;
 	int ret = 0;
 
 	/* only aligned lower 32-bit are relevant */
@@ -881,7 +883,15 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	if (ret)
 		goto defer;
 
-	range_tree_set_avail(&arena->rt, pgoff, page_cnt);
+	ret = range_tree_set_unavail(&arena->rt, pgoff, page_cnt);
+	if (ret) {
+		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+		if (ret == -ENOMEM)
+			goto defer;
+		WARN_ON_ONCE(ret);
+		bpf_map_memcg_exit(old_memcg, new_memcg);
+		return;
+	}
 
 	init_llist_head(&free_pages);
 	cdata.arena = arena;
@@ -911,6 +921,16 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 			zap_pages(arena, full_uaddr, 1);
 		__free_page(page);
 	}
+
+	ret = raw_res_spin_lock_irqsave(&arena->spinlock, flags);
+	if (ret) {
+		release_only = true;
+		goto defer;
+	}
+
+	ret = range_tree_make_avail(&arena->rt, pgoff, page_cnt);
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+	WARN_ON_ONCE(ret);
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 
 	return;
@@ -928,6 +948,7 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 
 	s->page_cnt = page_cnt;
 	s->uaddr = uaddr;
+	s->release_only = release_only;
 	llist_add(&s->node, &arena->free_spans);
 	irq_work_queue(&arena->free_irq);
 }
@@ -977,12 +998,13 @@ static void arena_free_worker(struct work_struct *work)
 	struct llist_node *list, *pos, *t;
 	struct arena_free_span *s;
 	u64 arena_vm_start, user_vm_start;
-	struct llist_head free_pages;
+	struct llist_head free_pages, teardown_spans, release_spans;
 	struct clear_range_data cdata;
 	struct page *page;
 	unsigned long full_uaddr;
 	long kaddr, page_cnt, pgoff;
 	unsigned long flags;
+	int ret;
 
 	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
 		schedule_work(work);
@@ -992,28 +1014,51 @@ static void arena_free_worker(struct work_struct *work)
 	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
 
 	init_llist_head(&free_pages);
+	init_llist_head(&teardown_spans);
+	init_llist_head(&release_spans);
 	cdata.arena = arena;
 	cdata.free_pages = &free_pages;
 	arena_vm_start = bpf_arena_get_kern_vm_start(arena);
 	user_vm_start = bpf_arena_get_user_vm_start(arena);
 
 	list = llist_del_all(&arena->free_spans);
-	llist_for_each(pos, list) {
+	llist_for_each_safe(pos, t, list) {
 		s = llist_entry(pos, struct arena_free_span, node);
 		page_cnt = s->page_cnt;
-		kaddr = arena_vm_start + s->uaddr;
 		pgoff = compute_pgoff(arena, s->uaddr);
 
+		if (s->release_only) {
+			ret = range_tree_make_avail(&arena->rt, pgoff, page_cnt);
+			WARN_ON_ONCE(ret);
+			kfree_nolock(s);
+			continue;
+		}
+
+		kaddr = arena_vm_start + s->uaddr;
+
+		ret = range_tree_set_unavail(&arena->rt, pgoff, page_cnt);
+		if (ret) {
+			/*
+			 * An -ENOMEM failure is the same failure mode as in
+			 * the defer: path of arena_free_pages(). Do not treat
+			 * the leak as a bug.
+			 */
+			if (ret != -ENOMEM)
+				WARN_ON_ONCE(ret);
+
+			kfree_nolock(s);
+			continue;
+		}
+
 		/* clear ptes and collect pages in free_pages llist */
 		apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
 					     apply_range_clear_cb, &cdata);
-
-		range_tree_set_avail(&arena->rt, pgoff, page_cnt);
+		__llist_add(pos, &teardown_spans);
 	}
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 
-	/* Iterate the list again without holding spinlock to do the tlb flush and zap_pages */
-	llist_for_each_safe(pos, t, list) {
+	/* Keep ranges unavailable until their stale translations are gone. */
+	llist_for_each_safe(pos, t, __llist_del_all(&teardown_spans)) {
 		s = llist_entry(pos, struct arena_free_span, node);
 		page_cnt = s->page_cnt;
 		full_uaddr = clear_lo32(user_vm_start) + s->uaddr;
@@ -1025,7 +1070,7 @@ static void arena_free_worker(struct work_struct *work)
 		/* remove pages from user vmas */
 		zap_pages(arena, full_uaddr, page_cnt);
 
-		kfree_nolock(s);
+		__llist_add(pos, &release_spans);
 	}
 
 	/* free all pages collected by apply_to_existing_page_range() in the first loop */
@@ -1034,6 +1079,37 @@ static void arena_free_worker(struct work_struct *work)
 		__free_page(page);
 	}
 
+	if (!llist_empty(&release_spans)) {
+		if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
+			llist_for_each_safe(pos, t, __llist_del_all(&release_spans)) {
+				s = llist_entry(pos, struct arena_free_span, node);
+				s->release_only = true;
+				llist_add(pos, &arena->free_spans);
+			}
+
+			schedule_work(work);
+			bpf_map_memcg_exit(old_memcg, new_memcg);
+			return;
+		}
+
+		llist_for_each_safe(pos, t, __llist_del_all(&release_spans)) {
+			s = llist_entry(pos, struct arena_free_span, node);
+			page_cnt = s->page_cnt;
+			pgoff = compute_pgoff(arena, s->uaddr);
+			/*
+			 * This range tree operation does not allocate memory,
+			 * and so should never fail regardless of contention
+			 * or memory pressure. This is in contrast to regular
+			 * inserts that _can_ fail under memory pressure and
+			 * force us to defer the free.
+			 */
+			ret = range_tree_make_avail(&arena->rt, pgoff, page_cnt);
+			WARN_ON_ONCE(ret);
+			kfree_nolock(s);
+		}
+		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+	}
+
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 }
 
-- 
2.55.0

