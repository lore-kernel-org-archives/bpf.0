Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653585328AD
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190712; cv=none; b=koyZvmnE9xfJhikUUOIcfBtyFysV4vZ5dFLTQW86IokTQ7CXwSyULJYtU5RE4vUNWJ1HlKxpQr8Zt395GgOFnYEYIF3FCLeGnOZpNZ2aHJL9zkhEm31zBnL+dVd5H3022y59e/k7pY5fLD89jAaI9LzJiy+URPn/33NOaCraMbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190712; c=relaxed/simple;
	bh=kr+12xj5IlgY5hVWQlR4ClbUlgb+j4p/AlAnyGAh/kE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vy5lnUJ0PT6o7JoibNyzBlMccYoA99QDVc+EbUmPnDUSFSabXKH9lmROrT7unBNV+E+pdH/Y0Y+VklwKql6SCD5WQkEDsUZAN2Al74uS3+My+AdLgQQg13nOzWZ/jnFpICo/2Vd20ZGgUeKzDOwJhnBrZ9rquZJjjdR7BVx3vyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=XSatlPFM; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="XSatlPFM"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48442ea8f59so86368f8f.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790190708; x=1790795508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FvQbVwcAdrLYUhYJmYRDZ2DqtnmZ5+Dv6z1gLdDfYAs=;
        b=XSatlPFM1uUVfgvHbEKDm7ZAxIKvJcF9DWRoPSvVOa1jxLg2txtbFnoo6c8ubVig/h
         NeieryEQXVuNv5+Ej/GeovHtS6HeEM0A6kVzb6UFS7CAdFL1UnxI3dfqN5QcqiaaK6IH
         tp+ngxmAHtc3v1mNcrooHkZVOeFnSP337miOeA/9wyV7G7Y+qhCCh52OGRdMYInROd+q
         6IWHj6VLjvI49MNz2YGCR3fQbBcl+KKDob3iQlOmCGXJFpOqVas7SrD2Kigh6MDguHWy
         0NYJ/bpAcEkG8dcLk4/uuyzgyJSOhyuHmW68bBCH+lhCjezh1JPrqkbuoCV2dk8lYyZq
         PX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190708; x=1790795508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FvQbVwcAdrLYUhYJmYRDZ2DqtnmZ5+Dv6z1gLdDfYAs=;
        b=qrOyDucRLUxyCKGWO5WQHRQ0bzqdh1cv/3dUlbnveQy9vh5nYXdKGPRzrI56/F+JhT
         PHBku5yoZTr89Q508o594YUOzvjq2PYg9Tidm8rHUFgh+36rxGaPJkfVtffF2chMZwd8
         OH4iJuE2kesqadrkheAXCEtWiw5RzgBOkPVRf0zdrRZkNno47Msda39yS7lOCT2eUdQ2
         +xMOXe+ml98+BknKAxXtKgyM5Jk+ETyC4wjHo1hb2E3QwHo0Z8P2uB+aAaHsGgZS4tbp
         IJqnHgAFWIv74Y+g/73gyifXGyyVWcfpt5RrdCS9VntZHYWJGervbjOcGNtjEyI4JktQ
         ZesA==
X-Gm-Message-State: AFuF++maSwnfZjdw0VRU6gcWWDu4PX+BVg1tPDTs26BMBThaF7McmsCh
	xIj34e7Xy+5yAhfMKgB4o+41kKPK2j7f7xW4cPh0EpvzDvv3lzaWJKsjwE8wVauWY2Pp3cBnMyZ
	cUsGrYigiHA==
X-Gm-Gg: AYBFou1gbZmIuciKKE0NegSdePxYl5LjQ0lj4V2BqsqVQ5KtfMtZ1P/bREre58S+6vk
	8u81pBSscrscOScruJFln5By4VLq7PG0Tw8shWBUGuiOim+gWULA2+2xw8aJ48hk6r2k7MCStGl
	29lYe7DzrqXRBozQpEHDjurHSvhbKY78pyAMNYXuHO8k1FTtBNoDta+aAuaikNQp2KrFoTfR5U1
	WhRQpkcCKN9i6Wz79N68K3YWwtPdnlsI9oQB5gReyPJpP0A+7/JFBH1hjF1+vhNfZEx8JbMYo9/
	IhmSrCj7PUDz+f7+lGbtIy8vnWCwi/1+ZYHxPqbHkERMnZ2d4CghzNz7Z6uo/9mixt6Yny3tqCR
	vN6s+IBFFl4sdZ+Ok4yw7jGsLdpzognUjqV+7NkpmpopOS7LOhqQJYvGm48ct8u10KXLMYOUPYA
	hDSWz6aAXjI7ER5M4G6tf72gQQnZpx1Ptx2XI6bCrHxBcFrJHlvmzFE/WiA3Y=
X-Received: by 2002:a05:6000:4712:b0:487:955:e6c3 with SMTP id ffacd0b85a97d-48871338f42mr265370f8f.0.1790190708447;
        Wed, 23 Sep 2026 12:11:48 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c090:600::1:2f89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886877a2a5sm9473563f8f.26.2026.09.23.12.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:11:47 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf-next v3 4/6] bpf: Add explicit state machine for arena free spans
Date: Wed, 23 Sep 2026 19:11:23 +0000
Message-ID: <20260923191125.5311-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260923191125.5311-1-emil@etsalapatis.com>
References: <20260923191125.5311-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arena_free_worker() call currently tracks the status
of each arena_free_span by placing it into a separate
list. This requires multiple list manipulation calls
during the freeing operation, complicating the code for
no reason.

Add an explicit state machine for span state. This
avoids encoding the states within temporary list membership,
and also allows for safely reschedulign freeing work for each
span separately.

Suggested-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c | 108 +++++++++++++++++++++++++++------------------
 1 file changed, 65 insertions(+), 43 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 9df4c74ff171..69c8924f4c30 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -72,11 +72,18 @@ struct bpf_arena {
 static void arena_free_worker(struct work_struct *work);
 static void arena_free_irq(struct irq_work *iw);
 
+enum arena_free_span_state {
+	ARENA_FREE_SPAN_NOT_STARTED,	/* Freeing not started */
+	ARENA_FREE_SPAN_UNAVAIL,	/* Region cleared & unavailable */
+	ARENA_FREE_SPAN_ZAPPED,		/* Region zapped and cleared */
+	ARENA_FREE_SPAN_FAILED,		/* Freeing operation cannot continue */
+};
+
 struct arena_free_span {
 	struct llist_node node;
 	unsigned long uaddr;
 	u32 page_cnt;
-	bool release_only;
+	enum arena_free_span_state state;
 };
 
 u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
@@ -1030,7 +1037,7 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 
 	s->page_cnt = page_cnt;
 	s->uaddr = uaddr;
-	s->release_only = release_only;
+	s->state = release_only ? ARENA_FREE_SPAN_ZAPPED : ARENA_FREE_SPAN_NOT_STARTED;
 	llist_add(&s->node, &arena->free_spans);
 	irq_work_queue(&arena->free_irq);
 }
@@ -1081,7 +1088,7 @@ static void arena_free_worker(struct work_struct *work)
 	struct arena_free_span *s;
 	struct range_node *unavail_node;
 	u64 arena_vm_start, user_vm_start;
-	struct llist_head free_pages, teardown_spans;
+	struct llist_head free_pages;
 	struct clear_range_data cdata;
 	struct page *page;
 	unsigned long full_uaddr;
@@ -1098,7 +1105,6 @@ static void arena_free_worker(struct work_struct *work)
 	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
 
 	init_llist_head(&free_pages);
-	init_llist_head(&teardown_spans);
 	cdata.arena = arena;
 	cdata.free_pages = &free_pages;
 	arena_vm_start = bpf_arena_get_kern_vm_start(arena);
@@ -1107,27 +1113,19 @@ static void arena_free_worker(struct work_struct *work)
 	list = llist_del_all(&arena->free_spans);
 	llist_for_each_safe(pos, t, list) {
 		s = llist_entry(pos, struct arena_free_span, node);
-		page_cnt = s->page_cnt;
-		pgoff = compute_pgoff(arena, s->uaddr);
-
-		if (s->release_only) {
-			ret = range_tree_make_avail(&arena->rt, pgoff, page_cnt);
-			WARN_ON_ONCE(ret);
-			kfree_nolock(s);
+		if (s->state != ARENA_FREE_SPAN_NOT_STARTED)
 			continue;
-		}
 
+		page_cnt = s->page_cnt;
+		pgoff = compute_pgoff(arena, s->uaddr);
 		kaddr = arena_vm_start + s->uaddr;
 
 		unavail_node = range_tree_set_unavail(&arena->rt, pgoff, page_cnt);
 		if (IS_ERR(unavail_node)) {
 			ret = PTR_ERR(unavail_node);
 			/* Kick off another attempt at the end of this call. */
-			if (ret == -EAGAIN) {
-				llist_add(pos, &arena->free_spans);
-				retry = true;
+			if (ret == -EAGAIN)
 				continue;
-			}
 
 			/*
 			 * An -ENOMEM failure is the same failure mode as in
@@ -1137,20 +1135,24 @@ static void arena_free_worker(struct work_struct *work)
 			if (ret != -ENOMEM)
 				WARN_ON_ONCE(ret);
 
-			kfree_nolock(s);
+			s->state = ARENA_FREE_SPAN_FAILED;
 			continue;
 		}
 
+		s->state = ARENA_FREE_SPAN_UNAVAIL;
+
 		/* clear ptes and collect pages in free_pages llist */
 		apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
 					     apply_range_clear_cb, &cdata);
-		__llist_add(pos, &teardown_spans);
 	}
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 
 	/* Keep ranges unavailable until their stale translations are gone. */
-	llist_for_each_safe(pos, t, READ_ONCE(teardown_spans.first)) {
+	llist_for_each_safe(pos, t, list) {
 		s = llist_entry(pos, struct arena_free_span, node);
+		if (s->state != ARENA_FREE_SPAN_UNAVAIL)
+			continue;
+
 		page_cnt = s->page_cnt;
 		full_uaddr = clear_lo32(user_vm_start) + s->uaddr;
 		kaddr = arena_vm_start + s->uaddr;
@@ -1160,6 +1162,12 @@ static void arena_free_worker(struct work_struct *work)
 
 		/* remove pages from user vmas */
 		zap_pages(arena, full_uaddr, page_cnt);
+
+		/*
+		 * Used to avoid zapping twice if we fail the lock acquisition
+		 * below and rerun the span through this function.
+		 */
+		s->state = ARENA_FREE_SPAN_ZAPPED;
 	}
 
 	/* free all pages collected by apply_to_existing_page_range() in the first loop */
@@ -1168,40 +1176,54 @@ static void arena_free_worker(struct work_struct *work)
 		__free_page(page);
 	}
 
-	if (!llist_empty(&teardown_spans)) {
-		if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
-			llist_for_each_safe(pos, t, __llist_del_all(&teardown_spans)) {
-				s = llist_entry(pos, struct arena_free_span, node);
-				s->release_only = true;
-				llist_add(pos, &arena->free_spans);
+	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
+		llist_for_each_safe(pos, t, list) {
+			s = llist_entry(pos, struct arena_free_span, node);
+
+			if (s->state == ARENA_FREE_SPAN_FAILED) {
+				kfree_nolock(s);
+				continue;
 			}
 
-			schedule_work(work);
-			bpf_map_memcg_exit(old_memcg, new_memcg);
-			return;
+			llist_add(pos, &arena->free_spans);
+			retry = true;
 		}
+		goto done;
+	}
 
-		llist_for_each_safe(pos, t, __llist_del_all(&teardown_spans)) {
-			s = llist_entry(pos, struct arena_free_span, node);
-			page_cnt = s->page_cnt;
-			pgoff = compute_pgoff(arena, s->uaddr);
-			/*
-			 * This range tree operation does not allocate memory,
-			 * and so should never fail regardless of contention
-			 * or memory pressure. This is in contrast to regular
-			 * inserts that _can_ fail under memory pressure and
-			 * force us to defer the free.
-			 */
-			ret = range_tree_make_avail(&arena->rt, pgoff, page_cnt);
-			WARN_ON_ONCE(ret);
+	llist_for_each_safe(pos, t, list) {
+		s = llist_entry(pos, struct arena_free_span, node);
+
+		/* Remove the spans of failed allocations. */
+		if (s->state == ARENA_FREE_SPAN_FAILED) {
 			kfree_nolock(s);
+			continue;
 		}
-		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+
+		if (s->state == ARENA_FREE_SPAN_NOT_STARTED) {
+			llist_add(pos, &arena->free_spans);
+			retry = true;
+			continue;
+		}
+
+		page_cnt = s->page_cnt;
+		pgoff = compute_pgoff(arena, s->uaddr);
+		/*
+		 * This range tree operation does not allocate memory,
+		 * and so should never fail regardless of contention
+		 * or memory pressure. This is in contrast to regular
+		 * inserts that _can_ fail under memory pressure and
+		 * force us to defer the free.
+		 */
+		ret = range_tree_make_avail(&arena->rt, pgoff, page_cnt);
+		WARN_ON_ONCE(ret);
+		kfree_nolock(s);
 	}
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 
+done:
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 
-	/* Retry if any region was unavailable for free. */
 	if (retry)
 		schedule_work(work);
 }
-- 
2.52.0

