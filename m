Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FAB48094A
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512957; cv=none; b=cpgG2kPQN3zSzjtKfGR96K84p7c/QnYXzycuMbc182oT2wTwzMbocmDlyfJLsGnDJmEW4WZbLRPSRFo0tzdJ286dtLRqL13vuNqN1qrkE55GAlO8XLKQVN6ZjNlQ/TnCcn0LZi9glE0d4Wec4ra4N+KfWf2Xrw/7689t02dFQ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512957; c=relaxed/simple;
	bh=qEUwdRnrh2iHrC+3gGV+GfExguEYI+IFNGGWADtxCjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V6Tb4/2oNJL+L6cgIMbIXai345DKsIZB03FAuQ0nMNaJUoOq9Dlcm2ObmmwH4WDdQ5if77opqXpFQHJ6YDdsK/GontJtuS0ne/nY3pXrn5jc5Z8VgmYue1i9IeTZ1EBxJSOOWFhojLufdBSzJRF0b4/YZUfy6dBkXibcoeo8Kos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpHiZ7a4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpHiZ7a4"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ebafde87cso8950192f8f.3
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 11:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780512954; x=1781117754; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDJSpK9RG8EJMs2aTnQcnM07mJKiTjC+of6bayuDtp0=;
        b=fpHiZ7a4FFUUtGjVzmkeJDQV0hk0w8S3Ot8ak9WSdiBcapSx/9o13e8PyIs6f5bkqA
         lw0yEFrfAWk/P/Y/jhsGgHcgzz1Q0jtdBG6+dgm4U9zGtFUYm9jvjAOOalLWPZaa87GK
         TOvuD4xgJ4hgJh7RzueoVVM82nj3LTOjLoC6DDPUuJLhwBsaYM3fbn8uWRhfeKdGxSuo
         FNURgWoERXVrXbnB40cEN0Bs2069lWfrVBHxnecs2aUWTPuQVBaWdTcchVTpAOjbWZ8p
         DiJ/FQ9sBtNyBioTAPKfsMSle5dFJ4IOqsoow/1u2dEhZgdhZ3IMoTQGP/qT1+kReZpQ
         6C/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780512954; x=1781117754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UDJSpK9RG8EJMs2aTnQcnM07mJKiTjC+of6bayuDtp0=;
        b=mHivKhql6hSWrEPk58WCZzATKfIhUJ7Sw4HWmnu1mPDXHbX7xt5HqmkyvDyydRu7jl
         5LeE8XpIlMJ8lpz8hFyrPIDzLS+icmHxVhoIB0U6beFUkcE1O89bL6jj58SU6PPYSUrV
         CvOZ2sTrrGxCDqoAq8ccnukXwy6xr1B5uGSkZcncOOwOzB8VqIw7NnqKsdgyzMAT/xF7
         NUcJhA4QheDNj7u6toBUBYb33syjgNqKhXkrCEyc+j2Mu9OX+Fa/e1P3jjUkMKr9JzSh
         DwOxlT5IDFEc8u932euZxG99jHR1cFaJjo0SFR0LShd/5jgS1h7s3o8buKnJtfWfbeIH
         PBlw==
X-Gm-Message-State: AOJu0Yzr1sFKO3yNqCITeiCYdHJO3lPL5nVsRYgQFWgGb6k6dsY73zaO
	IGbSOa24g9YOmIol9/y91QjU2IJPD/LrbShJ8gDHsN96prCVpGgptFNf
X-Gm-Gg: Acq92OEctUH6Pzf0yO1vTXQJKaxeI8k4Sq8pKenXo9jjiwA0Xetey1P3FhmSBx3Ib2d
	OY9uyuiXYImzsU9t/pbSN08V/AbqmSFAEu91aDLjQHR/8+Jseek5e6+KEZzgtMB5OEcbM2lwVPg
	DzOsbTCyHTITe18f/G2nfVORYAD3uuUehktu2ROnd6Fuyfo7IbJSlQOVJoxkKRW9Q8kC142tEqT
	eaXG8dooGMyidahk/7h0Fb3VHxGUqDPmf32p8EDf3sjvBVrDtCeWVt/nhy8dNtYAW0AHxWwIN/7
	2XW+hNv0X8SjHqFUYjeJtt3nE9D6mG/HU74AHJoWxEhgGN/eAIG1fvO4/P2DPzChEhoBLdgt7Jz
	bmdR2qQArEcV2cuMwDXN0i1GxXrfS8QgNRINN9DJLU6ZwaWrLFdBuvu0eE+n1rUZ62ruvrJvqpR
	eq7mOQr16YC5ruUYtUToBg+Dw=
X-Received: by 2002:adf:fd48:0:b0:45f:f142:d55f with SMTP id ffacd0b85a97d-460216db965mr5975157f8f.15.1780512954059;
        Wed, 03 Jun 2026 11:55:54 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm10334761f8f.5.2026.06.03.11.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:55:53 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 03 Jun 2026 11:55:25 -0700
Subject: [PATCH RFC bpf-next v2 1/3] bpf: Fix NMI/tracepoint re-entry
 deadlock on lru locks
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-lru_map_spin-v2-1-7060cfb6cdac@meta.com>
References: <20260603-lru_map_spin-v2-0-7060cfb6cdac@meta.com>
In-Reply-To: <20260603-lru_map_spin-v2-0-7060cfb6cdac@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 syzbot+c69a0a2c816716f1e0d5@syzkaller.appspotmail.com, 
 syzbot+18b26edb69b2e19f3b33@syzkaller.appspotmail.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780512951; l=16645;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=jZjlAlcdzsh64S3IaGflnFZPFXEmRMI9Um1TqZoq6kE=;
 b=wQ5duKh+8xKSvGo9L5lR5x0h0G1iA+87qYaMz70Idgsix0uX0goMaHK+mD3BHB66IVNr9UYye
 MzMEb8Sl7KuA3waErElo02brBnFHzsnbT99faMYHpVmwsoQXeL3YQSb
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

NMI and tracepoint BPF programs can re-enter the per-CPU or global
LRU lock that bpf_lru_pop_free()/push_free() already hold on the
same CPU, AA-deadlocking. Lockdep reports "inconsistent
{INITIAL USE} -> {IN-NMI}" on &l->lock (syzbot c69a0a2c816716f1e0d5)
and "possible recursive locking detected" on &loc_l->lock (syzbot
18b26edb69b2e19f3b33).

Prior trylock and rqspinlock based fixes (see links) were nacked
because compromised on reliability.

This patch converts every LRU lock site to rqspinlock_t and adds a
recovery path for some failure windows to avoid node leaks.

Failure recovery:

 - *_pop_free top-level: return NULL; prealloc_lru_pop() already
   treats that as no-free-element (-ENOMEM).

 - Cross-CPU steal: skip the victim's locked loc_l, try next CPU.

 - Post-steal local lock fail: publish stolen node to lockless
   per-CPU free_llist; next pop on this CPU picks it up.

 - push_free fail: mark node pending_free=1. __local_list_flush(),
   __local_list_pop_pending() reclaim the node from pending_list.
   __bpf_lru_list_shrink_inactive() reclaims the node from inactive
   list. Nodes from active list are reclaimed by __bpf_lru_list_shrink()
   or after __bpf_lru_list_rotate_active() demotes it to the inactive.

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
 kernel/bpf/bpf_lru_list.c | 165 ++++++++++++++++++++++++++++------------------
 kernel/bpf/bpf_lru_list.h |  25 +++++--
 2 files changed, 119 insertions(+), 71 deletions(-)

diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index e7a2fc60523f..5ed7cb4b98c0 100644
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
 
@@ -87,6 +73,9 @@ static void __bpf_lru_node_move_in(struct bpf_lru_list *l,
 	bpf_lru_list_count_inc(l, tgt_type);
 	node->type = tgt_type;
 	bpf_lru_node_clear_ref(node);
+	/* Reset pending_free only when moving to the free list */
+	if (tgt_type == BPF_LRU_LIST_T_FREE)
+		WRITE_ONCE(node->pending_free, 0);
 	list_move(&node->list, &l->lists[tgt_type]);
 }
 
@@ -212,9 +201,11 @@ __bpf_lru_list_shrink_inactive(struct bpf_lru *lru,
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
@@ -273,7 +264,8 @@ static unsigned int __bpf_lru_list_shrink(struct bpf_lru *lru,
 
 	list_for_each_entry_safe_reverse(node, tmp_node, force_shrink_list,
 					 list) {
-		if (lru->del_from_htab(lru->del_arg, node)) {
+		if (READ_ONCE(node->pending_free) ||
+		    lru->del_from_htab(lru->del_arg, node)) {
 			__bpf_lru_node_move_to_free(l, node, free_list,
 						    tgt_free_type);
 			return 1;
@@ -290,8 +282,10 @@ static void __local_list_flush(struct bpf_lru_list *l,
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
@@ -307,9 +301,12 @@ static void bpf_lru_list_push_free(struct bpf_lru_list *l,
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
@@ -318,8 +315,10 @@ static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
 	struct bpf_lru_list *l = &lru->common_lru.lru_list;
 	struct bpf_lru_node *node, *tmp_node;
 	unsigned int nfree = 0;
+	LIST_HEAD(tmp_free);
 
-	raw_spin_lock(&l->lock);
+	if (raw_res_spin_lock(&l->lock))
+		return;
 
 	__local_list_flush(l, loc_l);
 
@@ -327,7 +326,7 @@ static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
 
 	list_for_each_entry_safe(node, tmp_node, &l->lists[BPF_LRU_LIST_T_FREE],
 				 list) {
-		__bpf_lru_node_move_to_free(l, node, local_free_list(loc_l),
+		__bpf_lru_node_move_to_free(l, node, &tmp_free,
 					    BPF_LRU_LOCAL_LIST_T_FREE);
 		if (++nfree == lru->target_free)
 			break;
@@ -335,10 +334,19 @@ static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
 
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
@@ -350,22 +358,21 @@ static void __local_list_add_pending(struct bpf_lru *lru,
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
@@ -376,10 +383,10 @@ __local_list_pop_pending(struct bpf_lru *lru, struct bpf_lru_locallist *loc_l)
 
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
@@ -404,7 +411,8 @@ static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru *lru,
 
 	l = per_cpu_ptr(lru->percpu_lru, cpu);
 
-	raw_spin_lock_irqsave(&l->lock, flags);
+	if (raw_res_spin_lock_irqsave(&l->lock, flags))
+		return NULL;
 
 	__bpf_lru_list_rotate(lru, l);
 
@@ -420,7 +428,7 @@ static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru *lru,
 		__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_INACTIVE);
 	}
 
-	raw_spin_unlock_irqrestore(&l->lock, flags);
+	raw_res_spin_unlock_irqrestore(&l->lock, flags);
 
 	return node;
 }
@@ -437,7 +445,8 @@ static struct bpf_lru_node *bpf_common_lru_pop_free(struct bpf_lru *lru,
 
 	loc_l = per_cpu_ptr(clru->local_list, cpu);
 
-	raw_spin_lock_irqsave(&loc_l->lock, flags);
+	if (raw_res_spin_lock_irqsave(&loc_l->lock, flags))
+		return NULL;
 
 	node = __local_list_pop_free(loc_l);
 	if (!node) {
@@ -448,17 +457,22 @@ static struct bpf_lru_node *bpf_common_lru_pop_free(struct bpf_lru *lru,
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
@@ -466,24 +480,36 @@ static struct bpf_lru_node *bpf_common_lru_pop_free(struct bpf_lru *lru,
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
@@ -511,18 +537,24 @@ static void bpf_common_lru_push_free(struct bpf_lru *lru,
 
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
 
@@ -538,11 +570,14 @@ static void bpf_percpu_lru_push_free(struct bpf_lru *lru,
 
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
@@ -565,6 +600,7 @@ static void bpf_common_lru_populate(struct bpf_lru *lru, void *buf,
 
 		node = (struct bpf_lru_node *)(buf + node_offset);
 		node->type = BPF_LRU_LIST_T_FREE;
+		node->pending_free = 0;
 		bpf_lru_node_clear_ref(node);
 		list_add(&node->list, &l->lists[BPF_LRU_LIST_T_FREE]);
 		buf += elem_size;
@@ -594,6 +630,7 @@ static void bpf_percpu_lru_populate(struct bpf_lru *lru, void *buf,
 		node = (struct bpf_lru_node *)(buf + node_offset);
 		node->cpu = cpu;
 		node->type = BPF_LRU_LIST_T_FREE;
+		node->pending_free = 0;
 		bpf_lru_node_clear_ref(node);
 		list_add(&node->list, &l->lists[BPF_LRU_LIST_T_FREE]);
 		i++;
@@ -618,14 +655,12 @@ void bpf_lru_populate(struct bpf_lru *lru, void *buf, u32 node_offset,
 
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
@@ -640,7 +675,7 @@ static void bpf_lru_list_init(struct bpf_lru_list *l)
 
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

