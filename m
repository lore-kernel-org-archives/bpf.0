Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162B2C10F14
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 14:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E410520854
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 14:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732754AbfDJOan (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:30:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60011 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbfDJOan (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 10:30:43 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hEEFL-0002Y9-Sr; Wed, 10 Apr 2019 16:30:40 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/3] bpf: Use spinlock_t in hashtab
Date:   Wed, 10 Apr 2019 16:30:24 +0200
Message-Id: <20190410143025.11997-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410143025.11997-1-bigeasy@linutronix.de>
References: <20190410143025.11997-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There is no difference between spinlock_t and raw_spinlock_t for !RT
kernels. htab_map_update_elem() may allocate memory while it is holding
the ->lock which is not possible on RT kernels.

Make the ->lock a spinlock_t.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/bpf/hashtab.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index f9274114c88d3..b4f903a5ef36e 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -27,7 +27,7 @@
 
 struct bucket {
 	struct hlist_nulls_head head;
-	raw_spinlock_t lock;
+	spinlock_t lock;
 };
 
 struct bpf_htab {
@@ -385,7 +385,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 
 	for (i = 0; i < htab->n_buckets; i++) {
 		INIT_HLIST_NULLS_HEAD(&htab->buckets[i].head, i);
-		raw_spin_lock_init(&htab->buckets[i].lock);
+		spin_lock_init(&htab->buckets[i].lock);
 	}
 
 	if (prealloc) {
@@ -580,7 +580,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 	b = __select_bucket(htab, tgt_l->hash);
 	head = &b->head;
 
-	raw_spin_lock_irqsave(&b->lock, flags);
+	spin_lock_irqsave(&b->lock, flags);
 
 	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
 		if (l == tgt_l) {
@@ -588,7 +588,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 			break;
 		}
 
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	spin_unlock_irqrestore(&b->lock, flags);
 
 	return l == tgt_l;
 }
@@ -842,7 +842,7 @@ static int htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	head = &b->head;
 
 	/* bpf_map_update_elem() can be called in_irq() */
-	raw_spin_lock_irqsave(&b->lock, flags);
+	spin_lock_irqsave(&b->lock, flags);
 
 	l_old = lookup_elem_raw(head, hash, key, key_size);
 
@@ -869,7 +869,7 @@ static int htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	}
 	ret = 0;
 err:
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	spin_unlock_irqrestore(&b->lock, flags);
 	return ret;
 }
 
@@ -908,7 +908,7 @@ static int htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value,
 	memcpy(l_new->key + round_up(map->key_size, 8), value, map->value_size);
 
 	/* bpf_map_update_elem() can be called in_irq() */
-	raw_spin_lock_irqsave(&b->lock, flags);
+	spin_lock_irqsave(&b->lock, flags);
 
 	l_old = lookup_elem_raw(head, hash, key, key_size);
 
@@ -927,7 +927,7 @@ static int htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value,
 	ret = 0;
 
 err:
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	spin_unlock_irqrestore(&b->lock, flags);
 
 	if (ret)
 		bpf_lru_push_free(&htab->lru, &l_new->lru_node);
@@ -963,7 +963,7 @@ static int __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
 	head = &b->head;
 
 	/* bpf_map_update_elem() can be called in_irq() */
-	raw_spin_lock_irqsave(&b->lock, flags);
+	spin_lock_irqsave(&b->lock, flags);
 
 	l_old = lookup_elem_raw(head, hash, key, key_size);
 
@@ -986,7 +986,7 @@ static int __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
 	}
 	ret = 0;
 err:
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	spin_unlock_irqrestore(&b->lock, flags);
 	return ret;
 }
 
@@ -1027,7 +1027,7 @@ static int __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	}
 
 	/* bpf_map_update_elem() can be called in_irq() */
-	raw_spin_lock_irqsave(&b->lock, flags);
+	spin_lock_irqsave(&b->lock, flags);
 
 	l_old = lookup_elem_raw(head, hash, key, key_size);
 
@@ -1049,7 +1049,7 @@ static int __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	}
 	ret = 0;
 err:
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	spin_unlock_irqrestore(&b->lock, flags);
 	if (l_new)
 		bpf_lru_push_free(&htab->lru, &l_new->lru_node);
 	return ret;
@@ -1087,7 +1087,7 @@ static int htab_map_delete_elem(struct bpf_map *map, void *key)
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
-	raw_spin_lock_irqsave(&b->lock, flags);
+	spin_lock_irqsave(&b->lock, flags);
 
 	l = lookup_elem_raw(head, hash, key, key_size);
 
@@ -1097,7 +1097,7 @@ static int htab_map_delete_elem(struct bpf_map *map, void *key)
 		ret = 0;
 	}
 
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	spin_unlock_irqrestore(&b->lock, flags);
 	return ret;
 }
 
@@ -1119,7 +1119,7 @@ static int htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
-	raw_spin_lock_irqsave(&b->lock, flags);
+	spin_lock_irqsave(&b->lock, flags);
 
 	l = lookup_elem_raw(head, hash, key, key_size);
 
@@ -1128,7 +1128,7 @@ static int htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 		ret = 0;
 	}
 
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	spin_unlock_irqrestore(&b->lock, flags);
 	if (l)
 		bpf_lru_push_free(&htab->lru, &l->lru_node);
 	return ret;
-- 
2.20.1

