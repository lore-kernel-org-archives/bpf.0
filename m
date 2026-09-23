Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7D5414439
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 06:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790144080; cv=none; b=iGH4favFLbrnaJu3UFxu5xh0kHu5awiExOb+sIwmadebfmXaTJqC9ToHqoKflCEglcSMwdKrsNQeFy4uobfoKCqUqd9djubmKJYBxFh0M/0+UqgUoQNOWQHZER76qILVcri5yBIfqz1l/XuoCEH+nO1tCx6/S6kS1IPNBxSePAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790144080; c=relaxed/simple;
	bh=A0oiKNXnd1jis6KnMpaAmsYAjnASO3XJLKNKR42SdJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkFnNCx7/8zh35VKZ/rU9uJgG/m4SJEAdtQky80xvon4xavao9RGbfMgx97InROtcTkD8Ry6fgox+G3AQ2w7L6+hNbeVeFrREkDqtfCNpzPyQnpdHQ6YVGFzSkzCBFH7/rE9k+kY1H/zDXdtKg201J7CwIZbnFUXweyG4bFonzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=NxaH+sNW; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="NxaH+sNW"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so266042a91.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 23:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790144072; x=1790748872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FlRyAfnfehHhXhoeFcCmS5o/S0vGa8i66z1gg3O4bds=;
        b=NxaH+sNW1x6uJ9gOlD/nfxhxteoC4vQR28Ml3JDUY8qIQB22RtAQaFcZSFfjUdC+4k
         Oocf4p+yRSTr77H2pK1Ei66NlCw0A9UuDpir8299WNBeKH2w1PFK32+UT+OslDkBgx2S
         njHZCiRwKilplH9BhCXwVWfKCujTJX8Bxmb0nHfHaZcGyYxTqE1337MGs+gIGNLdxlSD
         o4Y28zOCF4+0SKGMwKyZbNvvWj2eY0XpJaGpmifhFSJ0SmWi3wjG6dlp8qBqIGAR9CTM
         5NFQxsEjqzjMuGrUmzyrNE8EtMwEcZ1438hyal1d4tmiOOyCHNstmPRAScsEurWjTdHy
         dDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790144072; x=1790748872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FlRyAfnfehHhXhoeFcCmS5o/S0vGa8i66z1gg3O4bds=;
        b=disncLDfv4jtm3gJpwX0t9DCDp7BdRxc3Ln9eUUsx3QIQgJtQNnaQ0u8EizGxoHEPe
         deUxuNpQAkh2/sxZkc7tkK/LTjdrZ/bGgzojzDCSUcH7A0nqlnkgLCxkXh4m55O5iSWF
         eOlb9Jq7DArVaHSRw5yMMILRlQeeCDQq41fUg4Rovspa8B3/mgIdNkIpGPG2cJrsO3BU
         deTiXbZxs3xOIMlAeh7g1OxCQ4eysYy0gXUjKS5OMMGMpXA9HsTOIhtFsQTfjaXZRM2A
         KrEQi9IgWs5g2CbZW6MYsy+4/XTqbJSY+KkqOFDCLjO8lzNfLfWBBHSufcDYiKqQMwO6
         yOIQ==
X-Gm-Message-State: AFuF++ky1yxjZSKsVL5WEWvokcLMcA1bcVa3qNkuFr7LRdr0+p3V8KVD
	0+F6dMggkPYvgMJ2GosqyknOFjcW6MsD4+BDl6yOZpfKkk90TQwcF6O3XlfA4HWWHeALXZclv6z
	9kDHl
X-Gm-Gg: AYBFou0WCmOmUtBLZPff3/Y5YH3IeqBsL6mCQNc19bEowzYFyRlYoCSv+D2kHdrOpsA
	VQFvLS+PWf7iZlAYem+wx797uNOr+vOz/C0qsv9vSwxid560n/Zt4/XjRb9hZocVqU7IXXT5cUt
	9Y2zXoenq4JoCwya0NBqGzNDhaVpSIKBhkCMv2xkqXh+oXnBYTkWdZWj/aARP1VnhUBh82X76EI
	m8/Ft4fWLZ5jnPEFhtGsWfHNUCWS7CcEF3+/EfUzynJ6Ya5aUVkjprC2PJUKXxFnV8zangswMu5
	yS5I4unqDuGog3ZcykisNs0Yj7qrPCHSrxWk6zKHSw9LS1In0u6fQVBUg8w7dSvpwnQBUI03boe
	rZi/l/+RSngnzl9CM0r4ixu4zeVXnIUzvpf6kXNvknCQb7vFE8OBB0qBB5H0gdeBB1FREQ9/uE4
	JbE+9+3bWaM/hyzquHzEr9/81zOqo0PuqWOqWxsR7F9yCpxnxsVWDPdyr6cV9cXogZIDi8MeW9b
	ql+WPxEtRtdSqFg5MzLXret7eJq4q5iWhpzxah60w==
X-Received: by 2002:a17:90b:3fc6:b0:39d:e1da:81e5 with SMTP id 98e67ed59e1d1-3a07e492ba1mr1061418a91.11.1790144071493;
        Tue, 22 Sep 2026 23:14:31 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07de57682sm3562652a91.16.2026.09.22.23.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:14:31 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf-next v2 4/7] bpf: Add explicit state machine for arena free spans
Date: Wed, 23 Sep 2026 06:14:22 +0000
Message-ID: <20260923061425.7045-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260923061425.7045-1-emil@etsalapatis.com>
References: <20260923061425.7045-1-emil@etsalapatis.com>
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
index 8bb011aae604..ad58aeaa0c87 100644
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
@@ -971,7 +978,7 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 
 	s->page_cnt = page_cnt;
 	s->uaddr = uaddr;
-	s->release_only = release_only;
+	s->state = release_only ? ARENA_FREE_SPAN_ZAPPED : ARENA_FREE_SPAN_NOT_STARTED;
 	llist_add(&s->node, &arena->free_spans);
 	irq_work_queue(&arena->free_irq);
 }
@@ -1021,7 +1028,7 @@ static void arena_free_worker(struct work_struct *work)
 	struct llist_node *list, *pos, *t;
 	struct arena_free_span *s;
 	u64 arena_vm_start, user_vm_start;
-	struct llist_head free_pages, teardown_spans;
+	struct llist_head free_pages;
 	struct clear_range_data cdata;
 	struct page *page;
 	unsigned long full_uaddr;
@@ -1038,7 +1045,6 @@ static void arena_free_worker(struct work_struct *work)
 	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
 
 	init_llist_head(&free_pages);
-	init_llist_head(&teardown_spans);
 	cdata.arena = arena;
 	cdata.free_pages = &free_pages;
 	arena_vm_start = bpf_arena_get_kern_vm_start(arena);
@@ -1047,26 +1053,18 @@ static void arena_free_worker(struct work_struct *work)
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
 
 		ret = range_tree_set_unavail(&arena->rt, pgoff, page_cnt);
 		if (ret) {
 			/* Kick off another attempt at the end of this call. */
-			if (ret == -EAGAIN) {
-				llist_add(pos, &arena->free_spans);
-				retry = true;
+			if (ret == -EAGAIN)
 				continue;
-			}
 
 			/*
 			 * An -ENOMEM failure is the same failure mode as in
@@ -1076,20 +1074,24 @@ static void arena_free_worker(struct work_struct *work)
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
@@ -1099,6 +1101,12 @@ static void arena_free_worker(struct work_struct *work)
 
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
@@ -1107,40 +1115,54 @@ static void arena_free_worker(struct work_struct *work)
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
2.54.0

