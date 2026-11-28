Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795873178;
	b=qw7K0HTogHwqIqdE7WfGWuGcdL7LfdmyYLozgTqmYSI5UBSRRu8ltjxwz/GkXBxMSDVA
	 Nz7nvPTndy37uIgKdqauGnk8WNvS/8HIe+uC0PRkfsFMZxGOdZPR3Y2safv2UdCXvfrmr
	 tRSIbx4i3AALTDYptoQHjU8QJz3kjLCONrxStCoZfkJas2mzZvetsdNIi9Yg3wI3nrJ9F
	 sM4EqIz6er/iccub5fzSIu64EAXDqAwVDiYCaEi6ACen8kLDjCbNxAFovk9AKU3ToBZzB
	 E2fFtsypoxqkNH3rj1uJkhUuHhm7J+/vxp8DCR6rdHrNJems8Dn8Vr4Oq80+29gEA9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795873178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:To:Cc:Message-ID;
	bh=Awy0tRu3t0kyoLdxhJm5Hbi5mwa0nPUbVP2OZ/Txoes=;
	b=f407sCcHCaKT948LhetbmHqcj2V+yLXLiFjNMC4bLfCxZgOvrP5DXvCrV33yjbZVFHFV
	 B7Bz7+CvRyk7C/ita0p31A/l0SK2EcTCuGqATemgBnJjv1U9Oz7XjHbfE8WvwmL2nGpMj
	 vrYDLYzf2qmTweDtfFkHUrCZ72fbrvv11hFJlK6IPom3MIEjwFOa2iQX2n36GOY8ZYBUv
	 PPGefdxDGp5sdxXG5xGtoidWPHiIjldMX2D8zOOYj8mK9DskUEciVqCyAL+qPUndfsHTh
	 cfi3rVb+Z1T0OCD+HR7Jfc1GQmYQDVAGpLaZFx7k0kizSzaPfTKvLVLSyWeEvTixsFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aFT4mr1w;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4D9606A31C
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 13:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B4D9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aFT4mr1w
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2f066274caeso42964975ad.2
        for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 05:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795873177; x=1796477977; darn=vger.kernel.org;
        h=message-id:cc:to:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Awy0tRu3t0kyoLdxhJm5Hbi5mwa0nPUbVP2OZ/Txoes=;
        b=aFT4mr1wEg7thFRwI3Kvj/FHlOSuZ1e4mKoeS3EGiHxU9uYsqy2JvclzTPOkb3+mMM
         FuryOeNiTZsL7bisJCqJ01HTBi40XO1ttZnzQ7GkeMfyUvEXV2ItjVrHruLUJxaj7k6m
         fuRSxuBpZuzGQDLvZwxT/RS3qdXWGljjCsTh3w9PdoQaTEUcjNL4/Wz8GtQUKqTr8V4X
         spBWC6hT1czlt2xay3AkvjOUgv/3dxNFXWM7O3K6ldyATtOYd/jaoqk4dEFXSF6TT5BS
         xo63lNukVXZzeeQSb3xXMC4Z2+v4zHSoJzNIvWBxdBy0stIRh6jKpjqYdrRhCPygbakH
         pf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795873177; x=1796477977;
        h=message-id:cc:to:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Awy0tRu3t0kyoLdxhJm5Hbi5mwa0nPUbVP2OZ/Txoes=;
        b=yYh/o2yHeNCJr3lV5xbs2YsMgYT0pflLh3iY485E9X+4t72jzFBeo/uzw+U3U+3s0B
         WxrJ4sPpP21TllNRS7VV/iCZ8Z8fqUUWgBFtF+0un9Y5GEyUCZdJBTaptHUJr+kYIAHS
         UBTAbHk1xBKfOhJi8bRW8cHqdO+FCbLKatRU9KKYdskwrVskkTSrFynE0dMYFfF5EJbA
         K21Oik6vOuKswPleEVJAsobmJ/JSJIDfGjZ+HNv117v1GbLpTUFnrYp5Re2ZwAyz4BG6
         +U9xdhh6rUDG/gHJc9v790NpvkbMoTqpDRPSZQVboqon6Gn53vsAJrprfQRiVADxzayg
         MMIA==
X-Gm-Message-State: APuU4Z+RmbdGnuSpUEjeWAhDfqExIjYvBdiqGZ5Hyk4ZTqWxhCYu/jbN
	HsTQfk1Rc5XE0ZqBVZ+X1upv4BEY2QluZqycEp8YNeUBXhjcP7PUUO9BxuX4EA1a
X-Gm-Gg: AZFdTZcMi1UD2K4NJnuyH8RRvOXoZZjxPRF0Fy+JAnthEtz+OLdAeHD39DmBm+DbXON
	P5zF9FXY4No0FqQOSGmmeQGPXzFjfTjnRdJS+eCKfNeyxKrLDTc2jCXbOW/EpX0SjDcijgdTUEF
	d8TuC/HTCs57E2XbXyOQcr8I/zCnAGoloQXO/M2o9VUkx3T6FGpYQvxdnga+Fg54LvH7/rZbGfx
	2I3IH3DwlH4+6ujnphuW8qtewUASUQ8tehylo39o5YmmJpmejkknEEiCeE5XZkHmG1l1FHWLjrZ
	aXRpT3pxj6GCN4s3WlrK7DYxENa+bRrhh3w4vlsc762Vns8uvtOTyBXq6g0kOSFO3XwegWTBrIG
	ZC0bBN8D4M21pINBH0VdLfjOwxYFdy9XHw4uVbhdchawqVYH/qGyCx0FPBk46KwtwIcIJctRxie
	10NpjyjE3gPdVd9QPYuVKZ4ZdYVVpM8EiuFchi02Rg/sLjje6Gbv5I6IRbU9+bgM3F58zKUvMT7
	y0zKSlF3huUUUzcutRjoOUSc+NJVmUSBzjt6uVu7sPvmLpB59ASauulndylKs4KhV/I16QNnn9r
	wqnQP3J6RgeAt4+U0H0lDaRFX9ZFnsSGqSgZoVrzn1Oq+Okn
X-Received: by 2002:a17:90b:1a90:b0:3b0:9941:8d42 with SMTP id 98e67ed59e1d1-3b41c92a1c0mr26039197a91.33.1795873176574;
        Sat, 28 Nov 2026 05:39:36 -0800 (PST)
Received: from [169.254.42.106] ([113.200.174.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b217a5bsm20688694a91.0.2026.11.28.05.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 05:39:36 -0800 (PST)
From: Zheng Shuhao <viennaoffh@gmail.com>
Date: Sat, 28 Nov 2026 21:39:24 +0800
Subject:
 [PATCH] bpf: defer reuse of LRU hash elements until after an RCU grace period
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, john.fastabend@gmail.com,
 syzbot+542d2bc50fc9545a27d6@syzkaller.appspotmail.com
Message-ID: <179587316462.32208.2314387285324230199@gmail.com>

syzbot reported a KCSAN data race between bcmp() in
htab_lru_map_update_elem() and a concurrent LRU hash update:

The lookup path compares an element's key while holding an RCU read-side
critical section. After hlist_nulls_del_rcu() removes an old element, an
RCU reader may still hold a pointer to it. The LRU path can return that
element to the free pool immediately, allowing prealloc_lru_pop() to
overwrite its key while the reader is still comparing it. The report
records a 280-byte key write racing with an 8-byte read in bcmp().

The report does not include a syz or C reproducer. My local C stress
reproducer is not identical: it issues repeated BPF_MAP_UPDATE_ELEM calls
from a writer thread, while the writer in the syzbot report goes through
generic_map_update_batch() (BPF_MAP_UPDATE_BATCH). Both exercise concurrent
LRU hash updates and lookups, but through different update paths. I can
provide my local reproducer if it would be useful.

This patch defers returning a removed element to the LRU free pool until
after an RCU grace period. It queues pending elements on the LRU, marks
them reclaimable from the RCU callback, and lets the shrink path reuse
only elements whose grace period has completed. The syscall map-update
path waits and retries if it gets -ENOMEM while deferred elements are
pending. BPF program helper updates do not use that syscall retry path
and may still see a transient -ENOMEM.

Testing:
- CONFIG_KCSAN=y, x86_64 QEMU with 2 vCPUs:
  tools/testing/selftests/bpf/test_lru_map passed with exit status 0.
- A 30-second local stress run with max_entries=32 and a 64-key
  working set completed 15,343,746 lookups and 5,351 updates, with no
  mismatches, update errors, or -ENOMEM returns. This checked regression
  behavior but did not reproduce the exact syzbot report.
- In the same synthetic workload, two baseline runs completed 19,819
  and 20,092 updates in 30 seconds. The patched run completed 5,351,
  about 73% fewer than the baseline average. This is one patched run,
  not a production benchmark, but it indicates a substantial
  performance cost.

I do not think this is a good final approach: it adds per-LRU RCU
queues and callback machinery, and syscall updates can block and retry
while BPF helper updates may still fail temporarily. Is there a simpler
or more appropriate way to keep an LRU element's key stable until
existing RCU readers have finished? I would appreciate suggestions on
how to improve this patch.

Reported-by: syzbot+542d2bc50fc9545a27d6@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=542d2bc50fc9545a27d6
Signed-off-by: Zheng Shuhao <viennaoffh@gmail.com>

---
 include/linux/bpf.h       |   1 +
 kernel/bpf/bpf_lru_list.c | 245 ++++++++++++++++++++++++++++++++++++++--------
 kernel/bpf/bpf_lru_list.h |  23 +++-
 kernel/bpf/hashtab.c      |  47 ++++++---
 kernel/bpf/syscall.c      |  10 +-
 5 files changed, 264 insertions(+), 62 deletions(-)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4e9a4d15a..c68aed7e1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -779,6 +779,7 @@ static inline void *bpf_arena_alloc_pages_sleepable(void *p__map, void *addr__ig
 #endif
 
 extern const struct bpf_map_ops bpf_map_offload_ops;
+bool bpf_lru_hash_wait_for_rcu(struct bpf_map *map);
 
 /* bpf_type_flag contains a set of flags that are applicable to the values of
  * arg_type, ret_type and reg_type. For example, a pointer value may be null,
diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index 3858886b0..b8a9a39f4 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2016 Facebook
  */
 #include <linux/cpumask.h>
+#include <linux/rcupdate.h>
 #include <linux/spinlock.h>
 #include <linux/percpu.h>
 
@@ -26,6 +27,77 @@ static void bpf_lru_node_clear_ref(struct bpf_lru_node *node)
 	WRITE_ONCE(node->ref, 0);
 }
 
+static u8 bpf_lru_node_pending_free(const struct bpf_lru_node *node)
+{
+	/* Pair with the release store after the RCU grace period. */
+	return smp_load_acquire(&node->pending_free);
+}
+
+static void bpf_lru_node_set_free_ready(struct bpf_lru_node *node)
+{
+	/* Publish readiness only after the RCU grace period has elapsed. */
+	smp_store_release(&node->pending_free, BPF_LRU_FREE_READY);
+}
+
+static void bpf_lru_rcu_done(struct rcu_head *rcu)
+{
+	struct bpf_lru *lru = container_of(rcu, struct bpf_lru, rcu);
+	struct llist_node *node, *next;
+
+	node = llist_del_all(&lru->rcu_waiting);
+	while (node) {
+		struct bpf_lru_node *lru_node;
+
+		next = node->next;
+		lru_node = container_of(node, struct bpf_lru_node, rcu_node);
+		bpf_lru_node_set_free_ready(lru_node);
+		node = next;
+	}
+
+	atomic_set(&lru->rcu_in_progress, 0);
+	wake_up_all(&lru->rcu_wait);
+	if (!llist_empty(&lru->rcu_pending))
+		irq_work_queue(&lru->rcu_work);
+}
+
+static void bpf_lru_rcu_work(struct irq_work *work)
+{
+	struct bpf_lru *lru = container_of(work, struct bpf_lru, rcu_work);
+	struct llist_node *node, *next;
+
+	if (atomic_xchg(&lru->rcu_in_progress, 1))
+		return;
+
+	node = llist_del_all(&lru->rcu_pending);
+	if (!node) {
+		atomic_set(&lru->rcu_in_progress, 0);
+		wake_up_all(&lru->rcu_wait);
+		return;
+	}
+
+	next = node->next;
+	while (node) {
+		struct llist_node *current_node = node;
+
+		node = next;
+		next = node ? node->next : NULL;
+		llist_add(current_node, &lru->rcu_waiting);
+	}
+
+	call_rcu_hurry(&lru->rcu, bpf_lru_rcu_done);
+}
+
+static void bpf_lru_node_defer_free(struct bpf_lru *lru,
+				    struct bpf_lru_node *node)
+{
+	if (cmpxchg(&node->pending_free, BPF_LRU_FREE_NONE,
+		    BPF_LRU_FREE_PENDING) != BPF_LRU_FREE_NONE)
+		return;
+
+	llist_add(&node->rcu_node, &lru->rcu_pending);
+	irq_work_queue(&lru->rcu_work);
+}
+
 static void bpf_lru_list_count_inc(struct bpf_lru_list *l,
 				   enum bpf_lru_list_type type)
 {
@@ -57,7 +129,7 @@ static void __bpf_lru_node_move_to_free(struct bpf_lru_list *l,
 	bpf_lru_list_count_dec(l, node->type);
 
 	node->type = tgt_free_type;
-	WRITE_ONCE(node->pending_free, 0);
+	WRITE_ONCE(node->pending_free, BPF_LRU_FREE_NONE);
 	list_move(&node->list, free_list);
 }
 
@@ -75,7 +147,7 @@ static void __bpf_lru_node_move_in(struct bpf_lru_list *l,
 	bpf_lru_node_clear_ref(node);
 	/* Reset pending_free only when moving to the free list */
 	if (tgt_type == BPF_LRU_LIST_T_FREE)
-		WRITE_ONCE(node->pending_free, 0);
+		WRITE_ONCE(node->pending_free, BPF_LRU_FREE_NONE);
 	list_move(&node->list, &l->lists[tgt_type]);
 }
 
@@ -107,6 +179,50 @@ static void __bpf_lru_node_move(struct bpf_lru_list *l,
 	list_move(&node->list, &l->lists[tgt_type]);
 }
 
+static unsigned int
+__bpf_lru_list_reclaim_ready(struct bpf_lru_list *l,
+			     unsigned int tgt_nshrink,
+			     struct list_head *free_list,
+			     enum bpf_lru_list_type tgt_free_type,
+			     bool *has_pending)
+{
+	struct bpf_lru_node *node, *tmp_node;
+	unsigned int nshrinked = 0;
+	int type;
+
+	*has_pending = false;
+	for (type = BPF_LRU_LIST_T_ACTIVE; type <= BPF_LRU_LIST_T_INACTIVE;
+	     type++) {
+		list_for_each_entry_safe_reverse(node, tmp_node,
+						 &l->lists[type], list) {
+			u8 pending_free = bpf_lru_node_pending_free(node);
+
+			if (pending_free != BPF_LRU_FREE_READY)
+				continue;
+
+			__bpf_lru_node_move_to_free(l, node, free_list,
+						    tgt_free_type);
+			if (++nshrinked == tgt_nshrink)
+				return nshrinked;
+		}
+	}
+
+	if (!nshrinked) {
+		for (type = BPF_LRU_LIST_T_ACTIVE;
+		     type <= BPF_LRU_LIST_T_INACTIVE; type++) {
+			list_for_each_entry(node, &l->lists[type], list) {
+				if (bpf_lru_node_pending_free(node) ==
+				    BPF_LRU_FREE_PENDING) {
+					*has_pending = true;
+					return 0;
+				}
+			}
+		}
+	}
+
+	return nshrinked;
+}
+
 static bool bpf_lru_list_inactive_low(const struct bpf_lru_list *l)
 {
 	return l->counts[BPF_LRU_LIST_T_INACTIVE] <
@@ -201,15 +317,21 @@ __bpf_lru_list_shrink_inactive(struct bpf_lru *lru,
 	unsigned int i = 0;
 
 	list_for_each_entry_safe_reverse(node, tmp_node, inactive, list) {
-		if (bpf_lru_node_is_ref(node) &&
-		    !READ_ONCE(node->pending_free)) {
-			__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_ACTIVE);
-		} else if (READ_ONCE(node->pending_free) ||
-			   lru->del_from_htab(lru->del_arg, node)) {
+		u8 pending_free = bpf_lru_node_pending_free(node);
+
+		if (pending_free == BPF_LRU_FREE_PENDING) {
+			return nshrinked + 1;
+		} else if (pending_free == BPF_LRU_FREE_READY) {
 			__bpf_lru_node_move_to_free(l, node, free_list,
 						    tgt_free_type);
 			if (++nshrinked == tgt_nshrink)
 				break;
+		} else if (bpf_lru_node_is_ref(node)) {
+			__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_ACTIVE);
+		} else if (lru->del_from_htab(lru->del_arg, node)) {
+			bpf_lru_node_defer_free(lru, node);
+			if (++nshrinked == tgt_nshrink)
+				break;
 		}
 
 		if (++i == lru->nr_scans)
@@ -250,6 +372,12 @@ static unsigned int __bpf_lru_list_shrink(struct bpf_lru *lru,
 	struct bpf_lru_node *node, *tmp_node;
 	struct list_head *force_shrink_list;
 	unsigned int nshrinked;
+	bool has_pending;
+
+	nshrinked = __bpf_lru_list_reclaim_ready(l, tgt_nshrink, free_list,
+						 tgt_free_type, &has_pending);
+	if (nshrinked || has_pending)
+		return nshrinked ? nshrinked : 1;
 
 	nshrinked = __bpf_lru_list_shrink_inactive(lru, l, tgt_nshrink,
 						   free_list, tgt_free_type);
@@ -264,11 +392,17 @@ static unsigned int __bpf_lru_list_shrink(struct bpf_lru *lru,
 
 	list_for_each_entry_safe_reverse(node, tmp_node, force_shrink_list,
 					 list) {
-		if (READ_ONCE(node->pending_free) ||
-		    lru->del_from_htab(lru->del_arg, node)) {
+		u8 pending_free = bpf_lru_node_pending_free(node);
+
+		if (pending_free == BPF_LRU_FREE_PENDING) {
+			return 1;
+		} else if (pending_free == BPF_LRU_FREE_READY) {
 			__bpf_lru_node_move_to_free(l, node, free_list,
 						    tgt_free_type);
 			return 1;
+		} else if (lru->del_from_htab(lru->del_arg, node)) {
+			bpf_lru_node_defer_free(lru, node);
+			return 1;
 		}
 	}
 
@@ -283,7 +417,9 @@ static void __local_list_flush(struct bpf_lru_list *l,
 
 	list_for_each_entry_safe_reverse(node, tmp_node,
 					 &loc_l->pending_list, list) {
-		if (READ_ONCE(node->pending_free))
+		if (bpf_lru_node_pending_free(node) == BPF_LRU_FREE_PENDING)
+			continue;
+		else if (bpf_lru_node_pending_free(node) == BPF_LRU_FREE_READY)
 			__bpf_lru_node_move_in(l, node, BPF_LRU_LIST_T_FREE);
 		else if (bpf_lru_node_is_ref(node))
 			__bpf_lru_node_move_in(l, node, BPF_LRU_LIST_T_ACTIVE);
@@ -293,19 +429,6 @@ static void __local_list_flush(struct bpf_lru_list *l,
 	}
 }
 
-static void bpf_lru_list_push_free(struct bpf_lru_list *l,
-				   struct bpf_lru_node *node)
-{
-	unsigned long flags;
-
-	if (raw_res_spin_lock_irqsave(&l->lock, flags)) {
-		WRITE_ONCE(node->pending_free, 1);
-		return;
-	}
-	__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_FREE);
-	raw_res_spin_unlock_irqrestore(&l->lock, flags);
-}
-
 static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
 					   struct bpf_lru_locallist *loc_l)
 {
@@ -355,7 +478,7 @@ static void __local_list_add_pending(struct bpf_lru *lru,
 	*(u32 *)((void *)node + lru->hash_offset) = hash;
 	node->cpu = cpu;
 	node->type = BPF_LRU_LOCAL_LIST_T_PENDING;
-	WRITE_ONCE(node->pending_free, 0);
+	WRITE_ONCE(node->pending_free, BPF_LRU_FREE_NONE);
 	bpf_lru_node_clear_ref(node);
 	list_add(&node->list, &loc_l->pending_list);
 }
@@ -381,12 +504,20 @@ __local_list_pop_pending(struct bpf_lru *lru, struct bpf_lru_locallist *loc_l)
 ignore_ref:
 	/* Get from the tail (i.e. older element) of the pending list. */
 	list_for_each_entry_reverse(node, &loc_l->pending_list, list) {
+		if (bpf_lru_node_pending_free(node) == BPF_LRU_FREE_PENDING)
+			continue;
+
 		if ((!bpf_lru_node_is_ref(node) || force) &&
-		    (READ_ONCE(node->pending_free) ||
-		     lru->del_from_htab(lru->del_arg, node))) {
+		    bpf_lru_node_pending_free(node) == BPF_LRU_FREE_READY) {
 			list_del(&node->list);
 			return node;
 		}
+
+		if ((!bpf_lru_node_is_ref(node) || force) &&
+		    lru->del_from_htab(lru->del_arg, node)) {
+			bpf_lru_node_defer_free(lru, node);
+			return NULL;
+		}
 	}
 
 	if (!force) {
@@ -501,7 +632,7 @@ static struct bpf_lru_node *bpf_common_lru_pop_free(struct bpf_lru *lru,
 		 */
 		node->type = BPF_LRU_LOCAL_LIST_T_FREE;
 		bpf_lru_node_clear_ref(node);
-		WRITE_ONCE(node->pending_free, 0);
+		WRITE_ONCE(node->pending_free, BPF_LRU_FREE_NONE);
 		llist_add(&node->llist, &loc_l->free_llist);
 		return NULL;
 	}
@@ -533,30 +664,30 @@ static void bpf_common_lru_push_free(struct bpf_lru *lru,
 		struct bpf_lru_locallist *loc_l;
 
 		loc_l = per_cpu_ptr(lru->common_lru.local_list, node->cpu);
-
 		if (raw_res_spin_lock_irqsave(&loc_l->lock, flags)) {
-			WRITE_ONCE(node->pending_free, 1);
+			WRITE_ONCE(node->pending_free, BPF_LRU_FREE_READY);
 			return;
 		}
-
 		if (unlikely(READ_ONCE(node->type) != BPF_LRU_LOCAL_LIST_T_PENDING)) {
-			raw_res_spin_unlock_irqrestore(&loc_l->lock,
-						       flags);
+			raw_res_spin_unlock_irqrestore(&loc_l->lock, flags);
 			goto check_lru_list;
 		}
-
 		node->type = BPF_LRU_LOCAL_LIST_T_FREE;
 		bpf_lru_node_clear_ref(node);
 		list_del(&node->list);
-
 		raw_res_spin_unlock_irqrestore(&loc_l->lock, flags);
-
 		llist_add(&node->llist, &loc_l->free_llist);
 		return;
 	}
 
 check_lru_list:
-	bpf_lru_list_push_free(&lru->common_lru.lru_list, node);
+	if (raw_res_spin_lock_irqsave(&lru->common_lru.lru_list.lock, flags)) {
+		WRITE_ONCE(node->pending_free, BPF_LRU_FREE_READY);
+		return;
+	}
+	__bpf_lru_node_move(&lru->common_lru.lru_list, node,
+			    BPF_LRU_LIST_T_FREE);
+	raw_res_spin_unlock_irqrestore(&lru->common_lru.lru_list.lock, flags);
 }
 
 static void bpf_percpu_lru_push_free(struct bpf_lru *lru,
@@ -566,14 +697,11 @@ static void bpf_percpu_lru_push_free(struct bpf_lru *lru,
 	unsigned long flags;
 
 	l = per_cpu_ptr(lru->percpu_lru, node->cpu);
-
 	if (raw_res_spin_lock_irqsave(&l->lock, flags)) {
-		WRITE_ONCE(node->pending_free, 1);
+		WRITE_ONCE(node->pending_free, BPF_LRU_FREE_READY);
 		return;
 	}
-
 	__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_FREE);
-
 	raw_res_spin_unlock_irqrestore(&l->lock, flags);
 }
 
@@ -585,6 +713,25 @@ void bpf_lru_push_free(struct bpf_lru *lru, struct bpf_lru_node *node)
 		bpf_common_lru_push_free(lru, node);
 }
 
+void bpf_lru_defer_free(struct bpf_lru *lru, struct bpf_lru_node *node)
+{
+	bpf_lru_node_defer_free(lru, node);
+}
+
+bool bpf_lru_wait_for_rcu(struct bpf_lru *lru)
+{
+	if (!atomic_read(&lru->rcu_in_progress) &&
+	    llist_empty(&lru->rcu_pending) &&
+	    llist_empty(&lru->rcu_waiting))
+		return false;
+
+	wait_event(lru->rcu_wait,
+		   !atomic_read(&lru->rcu_in_progress) &&
+		   llist_empty(&lru->rcu_pending) &&
+		   llist_empty(&lru->rcu_waiting));
+	return true;
+}
+
 static void bpf_common_lru_populate(struct bpf_lru *lru, void *buf,
 				    u32 node_offset, u32 elem_size,
 				    u32 nr_elems)
@@ -597,7 +744,7 @@ static void bpf_common_lru_populate(struct bpf_lru *lru, void *buf,
 
 		node = (struct bpf_lru_node *)(buf + node_offset);
 		node->type = BPF_LRU_LIST_T_FREE;
-		node->pending_free = 0;
+		node->pending_free = BPF_LRU_FREE_NONE;
 		bpf_lru_node_clear_ref(node);
 		list_add(&node->list, &l->lists[BPF_LRU_LIST_T_FREE]);
 		buf += elem_size;
@@ -627,7 +774,7 @@ static void bpf_percpu_lru_populate(struct bpf_lru *lru, void *buf,
 		node = (struct bpf_lru_node *)(buf + node_offset);
 		node->cpu = cpu;
 		node->type = BPF_LRU_LIST_T_FREE;
-		node->pending_free = 0;
+		node->pending_free = BPF_LRU_FREE_NONE;
 		bpf_lru_node_clear_ref(node);
 		list_add(&node->list, &l->lists[BPF_LRU_LIST_T_FREE]);
 		i++;
@@ -680,6 +827,12 @@ int bpf_lru_init(struct bpf_lru *lru, bool percpu, u32 hash_offset,
 {
 	int cpu;
 
+	init_llist_head(&lru->rcu_pending);
+	init_llist_head(&lru->rcu_waiting);
+	init_irq_work(&lru->rcu_work, bpf_lru_rcu_work);
+	atomic_set(&lru->rcu_in_progress, 0);
+	init_waitqueue_head(&lru->rcu_wait);
+
 	if (percpu) {
 		lru->percpu_lru = alloc_percpu(struct bpf_lru_list);
 		if (!lru->percpu_lru)
@@ -720,6 +873,14 @@ int bpf_lru_init(struct bpf_lru *lru, bool percpu, u32 hash_offset,
 
 void bpf_lru_destroy(struct bpf_lru *lru)
 {
+	do {
+		irq_work_sync(&lru->rcu_work);
+		rcu_barrier();
+		irq_work_sync(&lru->rcu_work);
+	} while (atomic_read(&lru->rcu_in_progress) ||
+		 !llist_empty(&lru->rcu_pending) ||
+		 !llist_empty(&lru->rcu_waiting));
+
 	if (lru->percpu)
 		free_percpu(lru->percpu_lru);
 	else
diff --git a/kernel/bpf/bpf_lru_list.h b/kernel/bpf/bpf_lru_list.h
index 8d0ee6162..a0f36a8c5 100644
--- a/kernel/bpf/bpf_lru_list.h
+++ b/kernel/bpf/bpf_lru_list.h
@@ -5,8 +5,11 @@
 #define __BPF_LRU_LIST_H_
 
 #include <linux/cache.h>
+#include <linux/irq_work.h>
 #include <linux/list.h>
 #include <linux/llist.h>
+#include <linux/rcupdate.h>
+#include <linux/wait.h>
 #include <asm/rqspinlock.h>
 
 #define NR_BPF_LRU_LIST_T	(3)
@@ -33,11 +36,15 @@ struct bpf_lru_node {
 	u16 cpu;
 	u8 type;
 	u8 ref;
-	/*
-	 * Marks nodes whose *_push_free() lock acquire failed; reclaimed
-	 * by flush/shrink which honor the flag instead of del_from_htab().
-	 */
+	/* Tracks whether this node is waiting for, or ready after, an RCU grace period. */
 	u8 pending_free;
+	struct llist_node rcu_node;
+};
+
+enum bpf_lru_free_state {
+	BPF_LRU_FREE_NONE,
+	BPF_LRU_FREE_PENDING,
+	BPF_LRU_FREE_READY,
 };
 
 struct bpf_lru_list {
@@ -74,6 +81,12 @@ struct bpf_lru {
 	unsigned int target_free;
 	unsigned int nr_scans;
 	bool percpu;
+	struct llist_head rcu_pending;
+	struct llist_head rcu_waiting;
+	struct irq_work rcu_work;
+	struct rcu_head rcu;
+	atomic_t rcu_in_progress;
+	wait_queue_head_t rcu_wait;
 };
 
 static inline void bpf_lru_node_set_ref(struct bpf_lru_node *node)
@@ -87,7 +100,9 @@ int bpf_lru_init(struct bpf_lru *lru, bool percpu, u32 hash_offset,
 void bpf_lru_populate(struct bpf_lru *lru, void *buf, u32 node_offset,
 		      u32 elem_size, u32 nr_elems);
 void bpf_lru_destroy(struct bpf_lru *lru);
+bool bpf_lru_wait_for_rcu(struct bpf_lru *lru);
 struct bpf_lru_node *bpf_lru_pop_free(struct bpf_lru *lru, u32 hash);
 void bpf_lru_push_free(struct bpf_lru *lru, struct bpf_lru_node *node);
+void bpf_lru_defer_free(struct bpf_lru *lru, struct bpf_lru_node *node);
 
 #endif
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index a2d0bfd4c..d46f962d9 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -207,6 +207,18 @@ static bool htab_is_lru(const struct bpf_htab *htab)
 	return htab_map_is_lru(&htab->map);
 }
 
+bool bpf_lru_hash_wait_for_rcu(struct bpf_map *map)
+{
+	struct bpf_htab *htab;
+
+	if (map->map_type != BPF_MAP_TYPE_LRU_HASH &&
+	    map->map_type != BPF_MAP_TYPE_LRU_PERCPU_HASH)
+		return false;
+
+	htab = container_of(map, struct bpf_htab, map);
+	return bpf_lru_wait_for_rcu(&htab->lru);
+}
+
 static bool htab_is_percpu(const struct bpf_htab *htab)
 {
 	return htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH ||
@@ -484,12 +496,13 @@ static int prealloc_init(struct bpf_htab *htab)
 
 static void prealloc_destroy(struct bpf_htab *htab)
 {
-	htab_free_elems(htab);
-
-	if (htab_is_lru(htab))
+	if (htab_is_lru(htab)) {
 		bpf_lru_destroy(&htab->lru);
-	else
+		htab_free_elems(htab);
+	} else {
+		htab_free_elems(htab);
 		pcpu_freelist_destroy(&htab->freelist);
+	}
 }
 
 static int alloc_extra_elems(struct bpf_htab *htab)
@@ -1505,11 +1518,15 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	return ret;
 }
 
-static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
+static void htab_lru_free_elem(struct bpf_htab *htab, struct htab_elem *elem,
+			       bool defer)
 {
 	check_and_cancel_fields(htab, elem);
 	bpf_map_dec_elem_count(&htab->map);
-	bpf_lru_push_free(&htab->lru, htab_elem_lru_node(elem));
+	if (defer)
+		bpf_lru_defer_free(&htab->lru, htab_elem_lru_node(elem));
+	else
+		bpf_lru_push_free(&htab->lru, htab_elem_lru_node(elem));
 }
 
 static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value,
@@ -1572,9 +1589,9 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 
 err_lock_bucket:
 	if (ret)
-		htab_lru_push_free(htab, &l_new->elem);
+		htab_lru_free_elem(htab, &l_new->elem, false);
 	else if (l_old)
-		htab_lru_push_free(htab, l_old);
+		htab_lru_free_elem(htab, l_old, true);
 
 	return ret;
 }
@@ -1803,7 +1820,7 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 
 	htab_unlock_bucket(b, flags);
 	if (l)
-		htab_lru_push_free(htab, l);
+		htab_lru_free_elem(htab, l, true);
 	return ret;
 }
 
@@ -1967,7 +1984,7 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 
 	if (l) {
 		if (is_lru_map)
-			htab_lru_push_free(htab, l);
+			htab_lru_free_elem(htab, l, true);
 		else
 			free_htab_elem(htab, l);
 	}
@@ -2181,10 +2198,10 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 		if (do_delete) {
 			hlist_nulls_del_rcu(&l->hash_node);
 
-			/* bpf_lru_push_free() will acquire lru_lock, which
-			 * may cause deadlock. See comments in function
-			 * prealloc_lru_pop(). Let us do bpf_lru_push_free()
-			 * after releasing the bucket lock.
+			/* Keep LRU element cleanup outside the bucket lock.
+			 * The immediate-free path takes lru_lock, and special-field
+			 * cleanup may synchronize with other contexts. See the lock
+			 * ordering documented above prealloc_lru_pop().
 			 *
 			 * For htab of maps, htab_put_fd_value() in
 			 * free_htab_elem() may acquire a spinlock with bucket
@@ -2205,7 +2222,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 		l = node_to_free;
 		node_to_free = node_to_free->batch_flink;
 		if (is_lru_map)
-			htab_lru_push_free(htab, l);
+			htab_lru_free_elem(htab, l, true);
 		else
 			free_htab_elem(htab, l);
 	}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ec8e78792..4ef40b333 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -267,7 +267,7 @@ static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
 		return bpf_fd_array_map_update_elem(map, map_file, key, value,
 						    flags);
 	}
-
+retry_update:
 	bpf_disable_instrumentation();
 	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
@@ -303,6 +303,14 @@ static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
 	}
 	bpf_enable_instrumentation();
 
+	if (err == -ENOMEM &&
+	    (map->map_type == BPF_MAP_TYPE_LRU_HASH ||
+	     map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) &&
+	    bpf_lru_hash_wait_for_rcu(map)) {
+		cond_resched();
+		goto retry_update;
+	}
+
 	return err;
 }
 
