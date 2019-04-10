Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFFBC10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 14:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEF020850
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 14:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732639AbfDJOal (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:30:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60008 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbfDJOal (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 10:30:41 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hEEFI-0002Y9-Q0; Wed, 10 Apr 2019 16:30:36 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/3] bpf: Use spinlock_t in bpf_lru_list
Date:   Wed, 10 Apr 2019 16:30:23 +0200
Message-Id: <20190410143025.11997-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There is no difference between spinlock_t and raw_spinlock_t for !RT
kernels. It is possible that bpf_lru_list_pop_free_to_local() invokes
at least three list walks which look unbounded it probably makes sense
to use spinlock_t.

Make bpf_lru_list use a spinlock_t.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/bpf/bpf_lru_list.c | 38 +++++++++++++++++++-------------------
 kernel/bpf/bpf_lru_list.h |  4 ++--
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index e6ef4401a1380..40f47210c3817 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -313,9 +313,9 @@ static void bpf_lru_list_push_free(struct bpf_lru_list *l,
 	if (WARN_ON_ONCE(IS_LOCAL_LIST_TYPE(node->type)))
 		return;
 
-	raw_spin_lock_irqsave(&l->lock, flags);
+	spin_lock_irqsave(&l->lock, flags);
 	__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_FREE);
-	raw_spin_unlock_irqrestore(&l->lock, flags);
+	spin_unlock_irqrestore(&l->lock, flags);
 }
 
 static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
@@ -325,7 +325,7 @@ static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
 	struct bpf_lru_node *node, *tmp_node;
 	unsigned int nfree = 0;
 
-	raw_spin_lock(&l->lock);
+	spin_lock(&l->lock);
 
 	__local_list_flush(l, loc_l);
 
@@ -344,7 +344,7 @@ static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
 				      local_free_list(loc_l),
 				      BPF_LRU_LOCAL_LIST_T_FREE);
 
-	raw_spin_unlock(&l->lock);
+	spin_unlock(&l->lock);
 }
 
 static void __local_list_add_pending(struct bpf_lru *lru,
@@ -410,7 +410,7 @@ static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru *lru,
 
 	l = per_cpu_ptr(lru->percpu_lru, cpu);
 
-	raw_spin_lock_irqsave(&l->lock, flags);
+	spin_lock_irqsave(&l->lock, flags);
 
 	__bpf_lru_list_rotate(lru, l);
 
@@ -426,7 +426,7 @@ static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru *lru,
 		__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_INACTIVE);
 	}
 
-	raw_spin_unlock_irqrestore(&l->lock, flags);
+	spin_unlock_irqrestore(&l->lock, flags);
 
 	return node;
 }
@@ -443,7 +443,7 @@ static struct bpf_lru_node *bpf_common_lru_pop_free(struct bpf_lru *lru,
 
 	loc_l = per_cpu_ptr(clru->local_list, cpu);
 
-	raw_spin_lock_irqsave(&loc_l->lock, flags);
+	spin_lock_irqsave(&loc_l->lock, flags);
 
 	node = __local_list_pop_free(loc_l);
 	if (!node) {
@@ -454,7 +454,7 @@ static struct bpf_lru_node *bpf_common_lru_pop_free(struct bpf_lru *lru,
 	if (node)
 		__local_list_add_pending(lru, loc_l, cpu, node, hash);
 
-	raw_spin_unlock_irqrestore(&loc_l->lock, flags);
+	spin_unlock_irqrestore(&loc_l->lock, flags);
 
 	if (node)
 		return node;
@@ -472,13 +472,13 @@ static struct bpf_lru_node *bpf_common_lru_pop_free(struct bpf_lru *lru,
 	do {
 		steal_loc_l = per_cpu_ptr(clru->local_list, steal);
 
-		raw_spin_lock_irqsave(&steal_loc_l->lock, flags);
+		spin_lock_irqsave(&steal_loc_l->lock, flags);
 
 		node = __local_list_pop_free(steal_loc_l);
 		if (!node)
 			node = __local_list_pop_pending(lru, steal_loc_l);
 
-		raw_spin_unlock_irqrestore(&steal_loc_l->lock, flags);
+		spin_unlock_irqrestore(&steal_loc_l->lock, flags);
 
 		steal = get_next_cpu(steal);
 	} while (!node && steal != first_steal);
@@ -486,9 +486,9 @@ static struct bpf_lru_node *bpf_common_lru_pop_free(struct bpf_lru *lru,
 	loc_l->next_steal = steal;
 
 	if (node) {
-		raw_spin_lock_irqsave(&loc_l->lock, flags);
+		spin_lock_irqsave(&loc_l->lock, flags);
 		__local_list_add_pending(lru, loc_l, cpu, node, hash);
-		raw_spin_unlock_irqrestore(&loc_l->lock, flags);
+		spin_unlock_irqrestore(&loc_l->lock, flags);
 	}
 
 	return node;
@@ -516,10 +516,10 @@ static void bpf_common_lru_push_free(struct bpf_lru *lru,
 
 		loc_l = per_cpu_ptr(lru->common_lru.local_list, node->cpu);
 
-		raw_spin_lock_irqsave(&loc_l->lock, flags);
+		spin_lock_irqsave(&loc_l->lock, flags);
 
 		if (unlikely(node->type != BPF_LRU_LOCAL_LIST_T_PENDING)) {
-			raw_spin_unlock_irqrestore(&loc_l->lock, flags);
+			spin_unlock_irqrestore(&loc_l->lock, flags);
 			goto check_lru_list;
 		}
 
@@ -527,7 +527,7 @@ static void bpf_common_lru_push_free(struct bpf_lru *lru,
 		node->ref = 0;
 		list_move(&node->list, local_free_list(loc_l));
 
-		raw_spin_unlock_irqrestore(&loc_l->lock, flags);
+		spin_unlock_irqrestore(&loc_l->lock, flags);
 		return;
 	}
 
@@ -543,11 +543,11 @@ static void bpf_percpu_lru_push_free(struct bpf_lru *lru,
 
 	l = per_cpu_ptr(lru->percpu_lru, node->cpu);
 
-	raw_spin_lock_irqsave(&l->lock, flags);
+	spin_lock_irqsave(&l->lock, flags);
 
 	__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_FREE);
 
-	raw_spin_unlock_irqrestore(&l->lock, flags);
+	spin_unlock_irqrestore(&l->lock, flags);
 }
 
 void bpf_lru_push_free(struct bpf_lru *lru, struct bpf_lru_node *node)
@@ -627,7 +627,7 @@ static void bpf_lru_locallist_init(struct bpf_lru_locallist *loc_l, int cpu)
 
 	loc_l->next_steal = cpu;
 
-	raw_spin_lock_init(&loc_l->lock);
+	spin_lock_init(&loc_l->lock);
 }
 
 static void bpf_lru_list_init(struct bpf_lru_list *l)
@@ -642,7 +642,7 @@ static void bpf_lru_list_init(struct bpf_lru_list *l)
 
 	l->next_inactive_rotation = &l->lists[BPF_LRU_LIST_T_INACTIVE];
 
-	raw_spin_lock_init(&l->lock);
+	spin_lock_init(&l->lock);
 }
 
 int bpf_lru_init(struct bpf_lru *lru, bool percpu, u32 hash_offset,
diff --git a/kernel/bpf/bpf_lru_list.h b/kernel/bpf/bpf_lru_list.h
index 7d4f89b7cb841..4e1e4608f1bb0 100644
--- a/kernel/bpf/bpf_lru_list.h
+++ b/kernel/bpf/bpf_lru_list.h
@@ -36,13 +36,13 @@ struct bpf_lru_list {
 	/* The next inacitve list rotation starts from here */
 	struct list_head *next_inactive_rotation;
 
-	raw_spinlock_t lock ____cacheline_aligned_in_smp;
+	spinlock_t lock ____cacheline_aligned_in_smp;
 };
 
 struct bpf_lru_locallist {
 	struct list_head lists[NR_BPF_LRU_LOCAL_LIST_T];
 	u16 next_steal;
-	raw_spinlock_t lock;
+	spinlock_t lock;
 };
 
 struct bpf_common_lru {
-- 
2.20.1

