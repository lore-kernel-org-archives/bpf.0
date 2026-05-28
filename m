Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEAD352034
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992143; cv=none; b=c9DKgDw3ivetm3Js9Q9N2PmtXnHoPT4CSYUSIrS7d8k+Zz1BKZEYudJDhaRgDuJSYgy9w9dH25zsWYSvMae/7M6CH3EWNfX8ZTNe2smyFObBdRSxwZ/DIDX0+ry8ymrPY54+fX510vy5mFYpV7BS8eLJ+hBDidMQNX4NY5jdKms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992143; c=relaxed/simple;
	bh=z8waAE5cLwUxa1HskSU7fGjw252VjjsztDeu4PMSO0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tZKZsuMxjbtLHKyhD+NnK4N4yFQltobzaPJ94M5FghLHPIFud4x5oQCTFReM+M//82SsBe6YNhmfjr4/Md+iBlgJKGre/Hr4gUmRhHLs2VtuDVB8SY3+X+WvuPtIczATbBhoSIg9EjLHBklL9StYAoXfTk/eXxOaznqQNc0lh+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vr8A79uO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vr8A79uO"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4906238c62eso45080985e9.3
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 11:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779992140; x=1780596940; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v6WX/l4rRIslSFGl6aZZzR1KT6qWEqaCiV0iMCUXENw=;
        b=Vr8A79uOwdzPb3hC5IUBD2fHpSkxsGmV90vWElqLBXJbJmffmWndP83wxueyARp+RA
         IJi5+f5QghXzeRk11ewMQPuMGXLp48m/oj9Jhj39A5tQAlfwtMnVF+Vs6ycDDuH2j6Tt
         UozrQ9TNtJ5o+qzojbUfrlNtXdteZ4yjbPvwP7YRQz9xNy3XwDO3J4+q457Fc9f5oZ5m
         OQKj/kHaGP2Uty53zxReBni6NEY6QXXD1HEZQ+YIE52/oQGNBEvVzHxAiWaj7ek6L6A1
         1io0SROxdfR7GFmq8Yxfvw1ojTBQQTBiwm1jQXs7DHBVGeIdseRrj8+BxLTSXEJLqcsC
         DwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779992140; x=1780596940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v6WX/l4rRIslSFGl6aZZzR1KT6qWEqaCiV0iMCUXENw=;
        b=D/RC5156QtDBbnL86JcpccuUp7eDYj8yVEX/IDaauqeQ1rygpMgfQrSNXpKPlJyZuh
         Heig0AO0GfYb9t8geClhWwJyHhu48WWnCZ+3OcDw0Fv385Z0e/9q59etbe1vfyq2qiq9
         UiptwIxiRO4zixqxo/Gn4kQISCXgTZW6P4SUUwCfEsxkFBPhaPtoMpotzd59iIT7Kdk5
         g0H0+ssIOazWDdixMxvJumDJ52XOo2PXvu6FVjeKarhSiW9aMUtpegd3CUbIE76KAoOh
         R+AxARUJx/kjpdPM8wBDTP2OxEt/euKejyPhNWzhxMBtYP3QdcQBHiLxgoFmhyCuuHvX
         C5dQ==
X-Gm-Message-State: AOJu0Yw95VA8WoZm/hTfbm4//vJ6s7MvZu38D/UDEy9S2HFL2HapljXM
	55/DViKNLQ7V6rHHfCmXWOwEtw9Wv0vIYzfsbDCtLlGOn/R+WcozP9svU8P75a5A
X-Gm-Gg: Acq92OGYTvIHNBUK36+Eslsd+Y1iN37KUfEs4BR/TzltiloqfUVcvZTTs4l00w2yo5X
	RlA+68EtnpyLTFhCS5FaXaoi8NBTjLPSA4x4a9VFBY2A67huNdEMMGEGn1Jy6bagz+GXitiNEr7
	14Txluj2IDLeorPMzG2/tw3q1Bf+1dsTlUUHH29JYUDHBQAjWZjV9yPVrZY826RTef9HX9WWkQ9
	zLzljzTSF3+Nz6qF0a8t3i/O/LnKXcaKdKQhq+bKT74bOx+byDLEXFt4QqAmlwASm1yWzF9hKUW
	TugIv9ivUlQVuUuoR8rzhRe/JLwcJrO7M0x0fGw/hcMqH4Tz/OhrBaKqyHotAxgM0PiTrbMPEzx
	uojlZcsxwDg/ZNHXlyCB3UK7gLb7nSOV87Iet9VI9D2Uo9F8r8rPB8RUAeVLZbgJ2ckJGDdEk5c
	wsQqAqBhpVhe7Ha6FCMcUKwFD/
X-Received: by 2002:a05:600c:35cf:b0:48a:5c23:cab with SMTP id 5b1f17b1804b1-490426bc737mr519298745e9.19.1779992139606;
        Thu, 28 May 2026 11:15:39 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:41::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909298d41bsm54165145e9.11.2026.05.28.11.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 11:15:39 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 28 May 2026 11:13:24 -0700
Subject: [PATCH RFC bpf-next 1/3] bpf: Fix NMI/tracepoint re-entry deadlock
 on lru locks
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-lru_map_spin-v1-1-4f52223170cf@meta.com>
References: <20260528-lru_map_spin-v1-0-4f52223170cf@meta.com>
In-Reply-To: <20260528-lru_map_spin-v1-0-4f52223170cf@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 syzbot+c69a0a2c816716f1e0d5@syzkaller.appspotmail.com, 
 syzbot+18b26edb69b2e19f3b33@syzkaller.appspotmail.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779992135; l=17011;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=sEpJhnrAhbGYGvMMjNLIhpF5q2AbaLxIt0FGDoOBZoM=;
 b=q9Afc+DU8rAHECeK4vPhFQjMuJPMfB3caRvdITJTJovDjMQP/y4hQixR5WSJvKxa618TGi3hk
 P2ojLYqeXBDBsq8JD/OA3fexV8TSre9IfAUMkgGXfIsHHRedBBEFfIl
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

NMI and tracepoint BPF programs can re-enter the per-CPU or global
LRU lock that bpf_lru_pop_free()/push_free() already hold on the
same CPU, AA-deadlocking. Lockdep reports "inconsistent
{INITIAL USE} -> {IN-NMI}" on &l->lock (syzbot c69a0a2c816716f1e0d5)
and "possible recursive locking detected" on &loc_l->lock (syzbot
18b26edb69b2e19f3b33).

Prior trylock-based fixes were nacked because trylock fails on any
contention, returning -ENOMEM even when no deadlock exists - that
sacrifices LRU map reliability under normal load. rqspinlock is
different: it blocks like raw_spin_lock for benign contention and
only fails on AA self-deadlock (the bug being fixed) or contention
timeout (an actual cycle). The normal blocking-acquire path is
preserved, so steady-state contention does not produce spurious
-ENOMEM.

This patch converts every LRU lock site to rqspinlock_t and adds a
recovery path for each failure window so no node leaks.

Failure recovery:

 - *_pop_free top-level: return NULL; prealloc_lru_pop() already
   treats that as no-free-element (-ENOMEM).

 - Cross-CPU steal: skip the victim's locked loc_l, try next CPU.

 - Post-steal local lock fail: publish stolen node to lockless
   per-CPU free_llist; next pop on this CPU picks it up.

 - push_free fail: mark node pending_free=1. __local_list_flush(),
   __bpf_lru_list_shrink_inactive() and the steal path
   (__local_list_pop_pending) all honor the flag and reclaim
   regardless of del_from_htab(). For lru->percpu maps the strand
   is reclaimed on the owning CPU's subsequent pop_free calls (up
   to nr_scans=4 marked nodes per call); cross-CPU recovery is not
   available because per-CPU LRU lists are owned by their CPU.

Fixes: 3a08c2fd7634 ("bpf: LRU List")
Reported-by: syzbot+c69a0a2c816716f1e0d5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c69a0a2c816716f1e0d5
Reported-by: syzbot+18b26edb69b2e19f3b33@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=18b26edb69b2e19f3b33
Link: https://lore.kernel.org/bpf/CAPPBnEYO4R+m+SpVc2gNj_x31R6fo1uJvj2bK2YS1P09GWT6kQ@mail.gmail.com/
Link: https://lore.kernel.org/bpf/CAPPBnEZmFA3ab8Uc=PEm0bdojZy=7T_F5_+eyZSHyZR3MBG4Vw@mail.gmail.com/
Link: https://lore.kernel.org/bpf/20251030030010.95352-1-dongml2@chinatelecom.cn/
Link: https://lore.kernel.org/bpf/20260119142120.28170-1-leon.hwang@linux.dev/
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/bpf_lru_list.c | 163 ++++++++++++++++++++++++++++------------------
 kernel/bpf/bpf_lru_list.h |  25 +++++--
 2 files changed, 117 insertions(+), 71 deletions(-)

diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index e7a2fc60523f..a5faf4464d88 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -13,23 +13,8 @@
 #define PERCPU_FREE_TARGET		(4)
 #define PERCPU_NR_SCANS			PERCPU_FREE_TARGET
 
-/* Helpers to get the local list index */
-#define LOCAL_LIST_IDX(t)	((t) - BPF_LOCAL_LIST_T_OFFSET)
-#define LOCAL_FREE_LIST_IDX	LOCAL_LIST_IDX(BPF_LRU_LOCAL_LIST_T_FREE)
-#define LOCAL_PENDING_LIST_IDX	LOCAL_LIST_IDX(BPF_LRU_LOCAL_LIST_T_PENDING)
 #define IS_LOCAL_LIST_TYPE(t)	((t) >= BPF_LOCAL_LIST_T_OFFSET)
 
-/* Local list helpers */
-static struct list_head *local_free_list(struct bpf_lru_locallist *loc_l)
-{
-	return &loc_l->lists[LOCAL_FREE_LIST_IDX];
-}
-
-static struct list_head *local_pending_list(struct bpf_lru_locallist *loc_l)
-{
-	return &loc_l->lists[LOCAL_PENDING_LIST_IDX];
-}
-
 /* bpf_lru_node helpers */
 static bool bpf_lru_node_is_ref(const struct bpf_lru_node *node)
 {
@@ -72,6 +57,7 @@ static void __bpf_lru_node_move_to_free(struct bpf_lru_list *l,
 	bpf_lru_list_count_dec(l, node->type);
 
 	node->type = tgt_free_type;
+	WRITE_ONCE(node->pending_free, 0);
 	list_move(&node->list, free_list);
 }
 
@@ -87,6 +73,7 @@ static void __bpf_lru_node_move_in(struct bpf_lru_list *l,
 	bpf_lru_list_count_inc(l, tgt_type);
 	node->type = tgt_type;
 	bpf_lru_node_clear_ref(node);
+	WRITE_ONCE(node->pending_free, 0);
 	list_move(&node->list, &l->lists[tgt_type]);
 }
 
@@ -212,9 +199,11 @@ __bpf_lru_list_shrink_inactive(struct bpf_lru *lru,
 	unsigned int i = 0;
 
 	list_for_each_entry_safe_reverse(node, tmp_node, inactive, list) {
-		if (bpf_lru_node_is_ref(node)) {
+		if (bpf_lru_node_is_ref(node) &&
+		    !READ_ONCE(node->pending_free)) {
 			__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_ACTIVE);
-		} else if (lru->del_from_htab(lru->del_arg, node)) {
+		} else if (READ_ONCE(node->pending_free) ||
+			   lru->del_from_htab(lru->del_arg, node)) {
 			__bpf_lru_node_move_to_free(l, node, free_list,
 						    tgt_free_type);
 			if (++nshrinked == tgt_nshrink)
@@ -273,7 +262,8 @@ static unsigned int __bpf_lru_list_shrink(struct bpf_lru *lru,
 
 	list_for_each_entry_safe_reverse(node, tmp_node, force_shrink_list,
 					 list) {
-		if (lru->del_from_htab(lru->del_arg, node)) {
+		if (READ_ONCE(node->pending_free) ||
+		    lru->del_from_htab(lru->del_arg, node)) {
 			__bpf_lru_node_move_to_free(l, node, free_list,
 						    tgt_free_type);
 			return 1;
@@ -290,8 +280,10 @@ static void __local_list_flush(struct bpf_lru_list *l,
 	struct bpf_lru_node *node, *tmp_node;
 
 	list_for_each_entry_safe_reverse(node, tmp_node,
-					 local_pending_list(loc_l), list) {
-		if (bpf_lru_node_is_ref(node))
+					 &loc_l->pending_list, list) {
+		if (READ_ONCE(node->pending_free))
+			__bpf_lru_node_move_in(l, node, BPF_LRU_LIST_T_FREE);
+		else if (bpf_lru_node_is_ref(node))
 			__bpf_lru_node_move_in(l, node, BPF_LRU_LIST_T_ACTIVE);
 		else
 			__bpf_lru_node_move_in(l, node,
@@ -307,9 +299,12 @@ static void bpf_lru_list_push_free(struct bpf_lru_list *l,
 	if (WARN_ON_ONCE(IS_LOCAL_LIST_TYPE(node->type)))
 		return;
 
-	raw_spin_lock_irqsave(&l->lock, flags);
+	if (raw_res_spin_lock_irqsave(&l->lock, flags)) {
+		WRITE_ONCE(node->pending_free, 1);
+		return;
+	}
 	__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_FREE);
-	raw_spin_unlock_irqrestore(&l->lock, flags);
+	raw_res_spin_unlock_irqrestore(&l->lock, flags);
 }
 
 static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
@@ -318,8 +313,10 @@ static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
 	struct bpf_lru_list *l = &lru->common_lru.lru_list;
 	struct bpf_lru_node *node, *tmp_node;
 	unsigned int nfree = 0;
+	LIST_HEAD(tmp_free);
 
-	raw_spin_lock(&l->lock);
+	if (raw_res_spin_lock(&l->lock))
+		return;
 
 	__local_list_flush(l, loc_l);
 
@@ -327,7 +324,7 @@ static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
 
 	list_for_each_entry_safe(node, tmp_node, &l->lists[BPF_LRU_LIST_T_FREE],
 				 list) {
-		__bpf_lru_node_move_to_free(l, node, local_free_list(loc_l),
+		__bpf_lru_node_move_to_free(l, node, &tmp_free,
 					    BPF_LRU_LOCAL_LIST_T_FREE);
 		if (++nfree == lru->target_free)
 			break;
@@ -335,10 +332,19 @@ static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
 
 	if (nfree < lru->target_free)
 		__bpf_lru_list_shrink(lru, l, lru->target_free - nfree,
-				      local_free_list(loc_l),
+				      &tmp_free,
 				      BPF_LRU_LOCAL_LIST_T_FREE);
 
-	raw_spin_unlock(&l->lock);
+	raw_res_spin_unlock(&l->lock);
+
+	/*
+	 * Transfer the harvested nodes from the temporary list_head into
+	 * the lockless per-CPU free llist.
+	 */
+	list_for_each_entry_safe(node, tmp_node, &tmp_free, list) {
+		list_del(&node->list);
+		llist_add(&node->llist, &loc_l->free_llist);
+	}
 }
 
 static void __local_list_add_pending(struct bpf_lru *lru,
@@ -350,22 +356,21 @@ static void __local_list_add_pending(struct bpf_lru *lru,
 	*(u32 *)((void *)node + lru->hash_offset) = hash;
 	node->cpu = cpu;
 	node->type = BPF_LRU_LOCAL_LIST_T_PENDING;
+	WRITE_ONCE(node->pending_free, 0);
 	bpf_lru_node_clear_ref(node);
-	list_add(&node->list, local_pending_list(loc_l));
+	list_add(&node->list, &loc_l->pending_list);
 }
 
 static struct bpf_lru_node *
 __local_list_pop_free(struct bpf_lru_locallist *loc_l)
 {
-	struct bpf_lru_node *node;
+	struct llist_node *llnode;
 
-	node = list_first_entry_or_null(local_free_list(loc_l),
-					struct bpf_lru_node,
-					list);
-	if (node)
-		list_del(&node->list);
+	llnode = llist_del_first(&loc_l->free_llist);
+	if (!llnode)
+		return NULL;
 
-	return node;
+	return container_of(llnode, struct bpf_lru_node, llist);
 }
 
 static struct bpf_lru_node *
@@ -376,10 +381,10 @@ __local_list_pop_pending(struct bpf_lru *lru, struct bpf_lru_locallist *loc_l)
 
 ignore_ref:
 	/* Get from the tail (i.e. older element) of the pending list. */
-	list_for_each_entry_reverse(node, local_pending_list(loc_l),
-				    list) {
+	list_for_each_entry_reverse(node, &loc_l->pending_list, list) {
 		if ((!bpf_lru_node_is_ref(node) || force) &&
-		    lru->del_from_htab(lru->del_arg, node)) {
+		    (READ_ONCE(node->pending_free) ||
+		     lru->del_from_htab(lru->del_arg, node))) {
 			list_del(&node->list);
 			return node;
 		}
@@ -404,7 +409,8 @@ static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru *lru,
 
 	l = per_cpu_ptr(lru->percpu_lru, cpu);
 
-	raw_spin_lock_irqsave(&l->lock, flags);
+	if (raw_res_spin_lock_irqsave(&l->lock, flags))
+		return NULL;
 
 	__bpf_lru_list_rotate(lru, l);
 
@@ -420,7 +426,7 @@ static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru *lru,
 		__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_INACTIVE);
 	}
 
-	raw_spin_unlock_irqrestore(&l->lock, flags);
+	raw_res_spin_unlock_irqrestore(&l->lock, flags);
 
 	return node;
 }
@@ -437,7 +443,8 @@ static struct bpf_lru_node *bpf_common_lru_pop_free(struct bpf_lru *lru,
 
 	loc_l = per_cpu_ptr(clru->local_list, cpu);
 
-	raw_spin_lock_irqsave(&loc_l->lock, flags);
+	if (raw_res_spin_lock_irqsave(&loc_l->lock, flags))
+		return NULL;
 
 	node = __local_list_pop_free(loc_l);
 	if (!node) {
@@ -448,17 +455,22 @@ static struct bpf_lru_node *bpf_common_lru_pop_free(struct bpf_lru *lru,
 	if (node)
 		__local_list_add_pending(lru, loc_l, cpu, node, hash);
 
-	raw_spin_unlock_irqrestore(&loc_l->lock, flags);
+	raw_res_spin_unlock_irqrestore(&loc_l->lock, flags);
 
 	if (node)
 		return node;
 
-	/* No free nodes found from the local free list and
+	/*
+	 * No free nodes found from the local free list and
 	 * the global LRU list.
 	 *
 	 * Steal from the local free/pending list of the
 	 * current CPU and remote CPU in RR.  It starts
 	 * with the loc_l->next_steal CPU.
+	 *
+	 * Acquire the victim's lock before touching either list. On
+	 * acquisition failure (rqspinlock AA or timeout) skip the victim
+	 * and try the next CPU.
 	 */
 
 	first_steal = loc_l->next_steal;
@@ -466,24 +478,36 @@ static struct bpf_lru_node *bpf_common_lru_pop_free(struct bpf_lru *lru,
 	do {
 		steal_loc_l = per_cpu_ptr(clru->local_list, steal);
 
-		raw_spin_lock_irqsave(&steal_loc_l->lock, flags);
-
-		node = __local_list_pop_free(steal_loc_l);
-		if (!node)
-			node = __local_list_pop_pending(lru, steal_loc_l);
-
-		raw_spin_unlock_irqrestore(&steal_loc_l->lock, flags);
+		if (!raw_res_spin_lock_irqsave(&steal_loc_l->lock, flags)) {
+			node = __local_list_pop_free(steal_loc_l);
+			if (!node)
+				node = __local_list_pop_pending(lru, steal_loc_l);
+			raw_res_spin_unlock_irqrestore(&steal_loc_l->lock, flags);
+		}
 
 		steal = cpumask_next_wrap(steal, cpu_possible_mask);
 	} while (!node && steal != first_steal);
 
 	loc_l->next_steal = steal;
 
-	if (node) {
-		raw_spin_lock_irqsave(&loc_l->lock, flags);
-		__local_list_add_pending(lru, loc_l, cpu, node, hash);
-		raw_spin_unlock_irqrestore(&loc_l->lock, flags);
+	if (!node)
+		return NULL;
+
+	if (raw_res_spin_lock_irqsave(&loc_l->lock, flags)) {
+		/*
+		 * The local pending lock can't be acquired (rqspinlock AA
+		 * or timeout). Return the stolen node to the per-CPU
+		 * free_llist instead of orphaning it; the next pop_free on
+		 * this CPU will pick it up.
+		 */
+		node->type = BPF_LRU_LOCAL_LIST_T_FREE;
+		bpf_lru_node_clear_ref(node);
+		WRITE_ONCE(node->pending_free, 0);
+		llist_add(&node->llist, &loc_l->free_llist);
+		return NULL;
 	}
+	__local_list_add_pending(lru, loc_l, cpu, node, hash);
+	raw_res_spin_unlock_irqrestore(&loc_l->lock, flags);
 
 	return node;
 }
@@ -511,18 +535,24 @@ static void bpf_common_lru_push_free(struct bpf_lru *lru,
 
 		loc_l = per_cpu_ptr(lru->common_lru.local_list, node->cpu);
 
-		raw_spin_lock_irqsave(&loc_l->lock, flags);
+		if (raw_res_spin_lock_irqsave(&loc_l->lock, flags)) {
+			WRITE_ONCE(node->pending_free, 1);
+			return;
+		}
 
 		if (unlikely(node->type != BPF_LRU_LOCAL_LIST_T_PENDING)) {
-			raw_spin_unlock_irqrestore(&loc_l->lock, flags);
+			raw_res_spin_unlock_irqrestore(&loc_l->lock,
+						       flags);
 			goto check_lru_list;
 		}
 
 		node->type = BPF_LRU_LOCAL_LIST_T_FREE;
 		bpf_lru_node_clear_ref(node);
-		list_move(&node->list, local_free_list(loc_l));
+		list_del(&node->list);
+
+		raw_res_spin_unlock_irqrestore(&loc_l->lock, flags);
 
-		raw_spin_unlock_irqrestore(&loc_l->lock, flags);
+		llist_add(&node->llist, &loc_l->free_llist);
 		return;
 	}
 
@@ -538,11 +568,14 @@ static void bpf_percpu_lru_push_free(struct bpf_lru *lru,
 
 	l = per_cpu_ptr(lru->percpu_lru, node->cpu);
 
-	raw_spin_lock_irqsave(&l->lock, flags);
+	if (raw_res_spin_lock_irqsave(&l->lock, flags)) {
+		WRITE_ONCE(node->pending_free, 1);
+		return;
+	}
 
 	__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_FREE);
 
-	raw_spin_unlock_irqrestore(&l->lock, flags);
+	raw_res_spin_unlock_irqrestore(&l->lock, flags);
 }
 
 void bpf_lru_push_free(struct bpf_lru *lru, struct bpf_lru_node *node)
@@ -565,6 +598,7 @@ static void bpf_common_lru_populate(struct bpf_lru *lru, void *buf,
 
 		node = (struct bpf_lru_node *)(buf + node_offset);
 		node->type = BPF_LRU_LIST_T_FREE;
+		node->pending_free = 0;
 		bpf_lru_node_clear_ref(node);
 		list_add(&node->list, &l->lists[BPF_LRU_LIST_T_FREE]);
 		buf += elem_size;
@@ -594,6 +628,7 @@ static void bpf_percpu_lru_populate(struct bpf_lru *lru, void *buf,
 		node = (struct bpf_lru_node *)(buf + node_offset);
 		node->cpu = cpu;
 		node->type = BPF_LRU_LIST_T_FREE;
+		node->pending_free = 0;
 		bpf_lru_node_clear_ref(node);
 		list_add(&node->list, &l->lists[BPF_LRU_LIST_T_FREE]);
 		i++;
@@ -618,14 +653,12 @@ void bpf_lru_populate(struct bpf_lru *lru, void *buf, u32 node_offset,
 
 static void bpf_lru_locallist_init(struct bpf_lru_locallist *loc_l, int cpu)
 {
-	int i;
-
-	for (i = 0; i < NR_BPF_LRU_LOCAL_LIST_T; i++)
-		INIT_LIST_HEAD(&loc_l->lists[i]);
+	INIT_LIST_HEAD(&loc_l->pending_list);
+	init_llist_head(&loc_l->free_llist);
 
 	loc_l->next_steal = cpu;
 
-	raw_spin_lock_init(&loc_l->lock);
+	raw_res_spin_lock_init(&loc_l->lock);
 }
 
 static void bpf_lru_list_init(struct bpf_lru_list *l)
@@ -640,7 +673,7 @@ static void bpf_lru_list_init(struct bpf_lru_list *l)
 
 	l->next_inactive_rotation = &l->lists[BPF_LRU_LIST_T_INACTIVE];
 
-	raw_spin_lock_init(&l->lock);
+	raw_res_spin_lock_init(&l->lock);
 }
 
 int bpf_lru_init(struct bpf_lru *lru, bool percpu, u32 hash_offset,
diff --git a/kernel/bpf/bpf_lru_list.h b/kernel/bpf/bpf_lru_list.h
index fe2661a58ea9..8d0ee61622af 100644
--- a/kernel/bpf/bpf_lru_list.h
+++ b/kernel/bpf/bpf_lru_list.h
@@ -6,11 +6,11 @@
 
 #include <linux/cache.h>
 #include <linux/list.h>
-#include <linux/spinlock_types.h>
+#include <linux/llist.h>
+#include <asm/rqspinlock.h>
 
 #define NR_BPF_LRU_LIST_T	(3)
 #define NR_BPF_LRU_LIST_COUNT	(2)
-#define NR_BPF_LRU_LOCAL_LIST_T (2)
 #define BPF_LOCAL_LIST_T_OFFSET NR_BPF_LRU_LIST_T
 
 enum bpf_lru_list_type {
@@ -22,10 +22,22 @@ enum bpf_lru_list_type {
 };
 
 struct bpf_lru_node {
-	struct list_head list;
+	/*
+	 * A node is in at most one list at a time. The free path on the
+	 * per-CPU locallist uses an llist, so share storage via a union.
+	 */
+	union {
+		struct list_head list;
+		struct llist_node llist;
+	};
 	u16 cpu;
 	u8 type;
 	u8 ref;
+	/*
+	 * Marks nodes whose *_push_free() lock acquire failed; reclaimed
+	 * by flush/shrink which honor the flag instead of del_from_htab().
+	 */
+	u8 pending_free;
 };
 
 struct bpf_lru_list {
@@ -34,13 +46,14 @@ struct bpf_lru_list {
 	/* The next inactive list rotation starts from here */
 	struct list_head *next_inactive_rotation;
 
-	raw_spinlock_t lock ____cacheline_aligned_in_smp;
+	rqspinlock_t lock ____cacheline_aligned_in_smp;
 };
 
 struct bpf_lru_locallist {
-	struct list_head lists[NR_BPF_LRU_LOCAL_LIST_T];
+	struct list_head pending_list;
+	struct llist_head free_llist;
 	u16 next_steal;
-	raw_spinlock_t lock;
+	rqspinlock_t lock;
 };
 
 struct bpf_common_lru {

-- 
2.53.0-Meta

