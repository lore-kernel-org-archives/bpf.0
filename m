Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A696337101
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 22:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330564; cv=none; b=bpcrghCJmCHDJkfaZoJ32jiTD+0rUrcLORtPRPzU5pnPztq/gOEEfjjvU7qJ0lKz0PQantLkonKtK5Y1FyjCP0WkzS9bchY6gzXOt10VhCRxgR2ZI3KM0P1XHFK8ecIPCXqjhpmpFVzlcFDfnVTvtJ6E5RJzw8OE1FFCQIt2s34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330564; c=relaxed/simple;
	bh=PDpGuKQk+dS0Ymu8CcklXQ/y3S2SNn96mVNrtKZFeFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVJ3TgJDttjcQDMrdQeEtLUfEn5A0cjRdtr3WQJfJOX0K8OmN45xvsp5f2yobkK8JIVz4awolV5zYPpPiSV2hevqyw6UWLW5NUhAChApqJsGZ9yAh8Kz/f4Z0N4Nsoc/MVDS24SQqvEK58uwgNtsYQwktbdLRFKa2cvzc6ePVfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCdJrDNH; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCdJrDNH"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3545cf80e1dso26418a91.2
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 14:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330563; x=1770935363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYfRc9/ioTu8QRod3CwWOvpaMtaLBbP+5+GXA7G++Nw=;
        b=QCdJrDNHj3ZpPKnkHiAEThFjMXcWu009jxseJHDa9sWfRTicx2WWrSZTieZy/5Esjn
         EyfnqcB4S3HtOtvWMZmExC3RV1RagsQs8/81+OW+2wSPPiT7JTRyDPjIjNrC14gzVZuW
         aFnJ0ozeUWkp86SSqf96QUU9JbhkRcU1aqUwAk8bbuTFI8co29gO2Mg9bc5AbO1kD4am
         /yuQENJXq0ABMT3H2NWyFyaUEjc3WoR/yyOdvdEOup0AXvnWn50AITNlpltNzHnD5vcX
         lqd+qHztVdNvIVOPKJ/PB7t/QTwXRqT+o8WLA/Iv9TdyOicPZrG7DzpdmEjbpeQKyzIR
         tnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330563; x=1770935363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KYfRc9/ioTu8QRod3CwWOvpaMtaLBbP+5+GXA7G++Nw=;
        b=T9dOASAunpXU7aFfibDxpebktsjGocFVUyXx2z2m1PvUXbmKHa14ic9TJNq7rO+9/G
         yZ/kmwYPGwsDXa8vohiXrclgf2nv5OQ3+512m69z0TeMfAa7j/eLbMPX+e3xusqtPF7O
         9b6/EiY68nilXjOxv7L2orFhjDHDSBUCdM1HIjQmPugxY9y0fJuSlmA7lq5rVrXBNNrP
         VCOrflAyT0+PWr6WBvOsfF2J7P0aeoK/Wu4ogPVFCv6iucIF4dTdCWjYddCUsVmZm8Ft
         TVY5luOEdP309+1Vx8cOZM1hkgjp1KiVU1jX1+/JAxgLaAm+HVaqAnmjRsKkz4gcmEwW
         aT6g==
X-Gm-Message-State: AOJu0Yzm2Vti9j19q0UyJz8S47eVpLBfI4tqGeod1PAvzL/wqUvWH1ED
	2b7IUe37GUHMbiejtM71YiqtNvSWcvhibcv/7o4UWJma6jVUAOxfzheSV5BhIQ==
X-Gm-Gg: AZuq6aIJoO5Iljd7ccoxeucP+l7s7F1v2rBWKLZlUBpXmbDxIcH6POWF6DmzERDCVfc
	W7k5XpBmAmafD7bAvCl/RASB38RBFRd6UmtmGJ1StPN/1b7NF2nyReSwAR4j9DhojvOfDu7hFzl
	KWfFqGHi32OiQZNeVha+ljKJn2qt0ntjHDIzrBLGGWy2B/3C7+l4Tg4AoMdFCtgh6lfUZW2Gx+O
	GBXMok8xKZwFWFL1yIVZEx+kMYicH7T4MmUE5OeYy4Ce5VQdkuVRCvkHt6asdqBr0qvfpSivChA
	AnYnyOJnj795d2pqc3sb3Tf0iZgkkNWEwp1h5GgRzGuhFySziuZjqqjtfWR7U06+vkWGtsQ3ZNK
	9W6h7zUskxeymHsFxnRlpRI3KOlCQ4p4IzlWSmvOc0ErNhZVxGkByuXtEpLtxkh/++tgQX0SfDP
	bHOvaWXgEZsaYn
X-Received: by 2002:a17:90b:268a:b0:353:2e1:95f2 with SMTP id 98e67ed59e1d1-354b3c2ec5fmr437910a91.8.1770330563404;
        Thu, 05 Feb 2026 14:29:23 -0800 (PST)
Received: from localhost ([2a03:2880:ff:48::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3549c0bf37fsm3411716a91.8.2026.02.05.14.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:29:23 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 05/17] bpf: Change local_storage->lock and b->lock to rqspinlock
Date: Thu,  5 Feb 2026 14:29:03 -0800
Message-ID: <20260205222916.1788211-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205222916.1788211-1-ameryhung@gmail.com>
References: <20260205222916.1788211-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change bpf_local_storage::lock and bpf_local_storage_map_bucket::lock
from raw_spin_lock to rqspinlock.

Finally, propagate errors from raw_res_spin_lock_irqsave() to syscall
return or BPF helper return.

In bpf_local_storage_destroy(), ignore return from
raw_res_spin_lock_irqsave() for now. A later patch will correctly
handle errors correctly in bpf_local_storage_destroy() so that it can
unlink selems even when failing to acquire locks.

For __bpf_local_storage_map_cache(), instead of handling the error,
skip updating the cache.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  5 ++-
 kernel/bpf/bpf_local_storage.c    | 64 +++++++++++++++++++++----------
 2 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index f74e0f7656a1..fa50b7afee18 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -15,12 +15,13 @@
 #include <linux/types.h>
 #include <linux/bpf_mem_alloc.h>
 #include <uapi/linux/btf.h>
+#include <asm/rqspinlock.h>
 
 #define BPF_LOCAL_STORAGE_CACHE_SIZE	16
 
 struct bpf_local_storage_map_bucket {
 	struct hlist_head list;
-	raw_spinlock_t lock;
+	rqspinlock_t lock;
 };
 
 /* Thp map is not the primary owner of a bpf_local_storage_elem.
@@ -94,7 +95,7 @@ struct bpf_local_storage {
 				 * bpf_local_storage_elem.
 				 */
 	struct rcu_head rcu;
-	raw_spinlock_t lock;	/* Protect adding/removing from the "list" */
+	rqspinlock_t lock;	/* Protect adding/removing from the "list" */
 	bool use_kmalloc_nolock;
 };
 
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 38f5c3db2957..1138e2293b50 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -321,14 +321,18 @@ static int bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 	struct bpf_local_storage_map *smap;
 	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
+	int err;
 
 	local_storage = rcu_dereference_check(selem->local_storage,
 					      bpf_rcu_lock_held());
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 	b = select_bucket(smap, local_storage);
-	raw_spin_lock_irqsave(&b->lock, flags);
+	err = raw_res_spin_lock_irqsave(&b->lock, flags);
+	if (err)
+		return err;
+
 	hlist_del_init_rcu(&selem->map_node);
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	raw_res_spin_unlock_irqrestore(&b->lock, flags);
 
 	return 0;
 }
@@ -344,11 +348,16 @@ int bpf_selem_link_map(struct bpf_local_storage_map *smap,
 {
 	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
+	int err;
 
 	b = select_bucket(smap, local_storage);
-	raw_spin_lock_irqsave(&b->lock, flags);
+
+	err = raw_res_spin_lock_irqsave(&b->lock, flags);
+	if (err)
+		return err;
+
 	hlist_add_head_rcu(&selem->map_node, &b->list);
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	raw_res_spin_unlock_irqrestore(&b->lock, flags);
 
 	return 0;
 }
@@ -365,7 +374,7 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 	bool free_local_storage = false;
 	HLIST_HEAD(selem_free_list);
 	unsigned long flags;
-	int err = 0;
+	int err;
 
 	if (unlikely(!selem_linked_to_storage_lockless(selem)))
 		/* selem has already been unlinked from sk */
@@ -374,7 +383,10 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 	local_storage = rcu_dereference_check(selem->local_storage,
 					      bpf_rcu_lock_held());
 
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
+	if (err)
+		return err;
+
 	if (likely(selem_linked_to_storage(selem))) {
 		/* Always unlink from map before unlinking from local_storage
 		 * because selem will be freed after successfully unlinked from
@@ -388,7 +400,7 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 			local_storage, selem, &selem_free_list);
 	}
 out:
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 
 	bpf_selem_free_list(&selem_free_list, reuse_now);
 
@@ -403,16 +415,20 @@ void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
 				      struct bpf_local_storage_elem *selem)
 {
 	unsigned long flags;
+	int err;
 
 	/* spinlock is needed to avoid racing with the
 	 * parallel delete.  Otherwise, publishing an already
 	 * deleted sdata to the cache will become a use-after-free
 	 * problem in the next bpf_local_storage_lookup().
 	 */
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
+	if (err)
+		return;
+
 	if (selem_linked_to_storage(selem))
 		rcu_assign_pointer(local_storage->cache[smap->cache_idx], SDATA(selem));
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 }
 
 static int check_flags(const struct bpf_local_storage_data *old_sdata,
@@ -457,14 +473,17 @@ int bpf_local_storage_alloc(void *owner,
 
 	RCU_INIT_POINTER(storage->smap, smap);
 	INIT_HLIST_HEAD(&storage->list);
-	raw_spin_lock_init(&storage->lock);
+	raw_res_spin_lock_init(&storage->lock);
 	storage->owner = owner;
 	storage->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
 
 	b = select_bucket(smap, storage);
-	raw_spin_lock_irqsave(&b->lock, flags);
+	err = raw_res_spin_lock_irqsave(&b->lock, flags);
+	if (err)
+		goto uncharge;
+
 	bpf_selem_link_map_nolock(b, first_selem);
 
 	owner_storage_ptr =
@@ -482,11 +501,11 @@ int bpf_local_storage_alloc(void *owner,
 	prev_storage = cmpxchg(owner_storage_ptr, NULL, storage);
 	if (unlikely(prev_storage)) {
 		bpf_selem_unlink_map_nolock(first_selem);
-		raw_spin_unlock_irqrestore(&b->lock, flags);
+		raw_res_spin_unlock_irqrestore(&b->lock, flags);
 		err = -EAGAIN;
 		goto uncharge;
 	}
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	raw_res_spin_unlock_irqrestore(&b->lock, flags);
 
 	return 0;
 
@@ -569,7 +588,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	if (!alloc_selem)
 		return ERR_PTR(-ENOMEM);
 
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
+	if (err)
+		goto free_selem;
 
 	/* Recheck local_storage->list under local_storage->lock */
 	if (unlikely(hlist_empty(&local_storage->list))) {
@@ -596,7 +617,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 
 	b = select_bucket(smap, local_storage);
 
-	raw_spin_lock_irqsave(&b->lock, b_flags);
+	err = raw_res_spin_lock_irqsave(&b->lock, b_flags);
+	if (err)
+		goto unlock;
 
 	alloc_selem = NULL;
 	/* First, link the new selem to the map */
@@ -612,9 +635,10 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 						&old_selem_free_list);
 	}
 
-	raw_spin_unlock_irqrestore(&b->lock, b_flags);
+	raw_res_spin_unlock_irqrestore(&b->lock, b_flags);
 unlock:
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
+free_selem:
 	bpf_selem_free_list(&old_selem_free_list, false);
 	if (alloc_selem) {
 		mem_uncharge(smap, owner, smap->elem_size);
@@ -699,7 +723,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 	 * when unlinking elem from the local_storage->list and
 	 * the map's bucket->list.
 	 */
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	raw_res_spin_lock_irqsave(&local_storage->lock, flags);
 	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
 		/* Always unlink from map before unlinking from
 		 * local_storage.
@@ -714,7 +738,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 		free_storage = bpf_selem_unlink_storage_nolock(
 			local_storage, selem, &free_selem_list);
 	}
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 
 	bpf_selem_free_list(&free_selem_list, true);
 
@@ -761,7 +785,7 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 
 	for (i = 0; i < nbuckets; i++) {
 		INIT_HLIST_HEAD(&smap->buckets[i].list);
-		raw_spin_lock_init(&smap->buckets[i].lock);
+		raw_res_spin_lock_init(&smap->buckets[i].lock);
 	}
 
 	smap->elem_size = offsetof(struct bpf_local_storage_elem,
-- 
2.47.3

