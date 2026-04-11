Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF64F2848BA
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 00:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775866638; cv=none; b=MRH2lveEiI9/BHw0CsJhHoYUjP6k91IkD8wv1zFlRsoiSjY6ME/JPc4Fhs/hyu6bED+7mm0xybdQBhcom2YndfI/KI/eqRen1jgaC2NsTjBoqMQnMnyXNSG96nvaP8X2LkdWszpPAVS3mOwe9l3B9gC4BIDNCoR4AzFSsJihy9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775866638; c=relaxed/simple;
	bh=kmh51PpoQfrIwTDg2WJgoCaVQdyEm0VR8qCRgYzU7i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dT3z5QJNEsshDVUxGN9XwibOSbg9WXn+XJTqZb6f4B6xcZjFNB9EZIpEdNX4DrPmIblLK5Ceer+hZ0Yhd0aRVeJqmc3VZh/i64P0g+c2SWInJZahkI+2740Ba22igAQCXrbSMh6+BUiFh4qooUGnR0asu7P1YzTMP9MvYGCsOp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g//5Mnyj; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g//5Mnyj"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82cebbdbdccso1341670b3a.1
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 17:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775866636; x=1776471436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3BgZN/1cII+QDpGmOCJfNJmY6Ff066wEIidnw16qy0=;
        b=g//5MnyjmR0HzU+smJjEQmwMbXujeYF24AH9DPqcEqOHrE9ftb0C8i8nlYTdjFST0K
         2QlxNDg1gRNVS+WvrMVff4guP37pPOhqGPrwLwoYc6eSgNil3QrRUeGEBCAmghx+N1QR
         LDx4nKx7JF70EMKgQcXvppeszl0lrFslvD/ZF1W/UGtbcWrU6I/rMwDyQVDCjSG6g3r5
         K4ENKTN6D6OY/y9dKq1hVGO92Ic5P53KxO8xcSQgqeWtBPjBz5xRLPzgn7KeWsNoYEKW
         WWFuc6loFbfDK9hLEDo31JpeUp8g75hGVllwnlgnZnwJeBjjJCxcS8KnLbhbpgeooEK9
         k0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775866636; x=1776471436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X3BgZN/1cII+QDpGmOCJfNJmY6Ff066wEIidnw16qy0=;
        b=irfDA08yaxY0rFK2J4sDrpd2QNIReMrkwH/YcrtuJVO4ZtukzW4zh/9Dq+XKE6Jhxd
         1RcOOAYhwxysWUswb3OVyvDpNXvt/TLI8Mw1AXO0cSRpBpZC/gV1/FZe25EClFrHBQ3t
         UdGMhUl15TrddSjSE0MiY465SGE8gPPF+qFL01sbVD3wZVOAd6hhjbWQ5nFyqoqsDvKb
         YxwznqstSFNpGcr70cTLTydyH6VEIEg2YE6mTI62HjGyxbs1Vqb7JMDFZ+dURj8811k6
         JohnZ2rBA4Q75IL+OOVPEtnC7IVyK1lwH9E7f0ESMYxqufw62y/pN9tEHzCSB1TGYfSW
         xdyw==
X-Gm-Message-State: AOJu0YxdPxar5uvIW4thMmejLsb3r+XeveDMLiW2HCoGbOlW2jgbmen+
	3WU5hY+OHdNra1Mgbb3IA0aC32D8HdRgkdFdJc1u+tvICWHIKAhAqFvw75QIPg==
X-Gm-Gg: AeBDiesZ+7hZEdpZgLk8WS2XmppxO66SPaAOv7QcMwWZF7uLsVAJ6k6W1Xa/v24f56g
	dqbwI54zyVg6BA6IUV3cJNP4eKpCLdx4n1w2NB8lNviL8osgtNTkBJOUsrM/Tt47toVSyVS8a4B
	8ak34nVzD+ZR1QwkDu9xT/Iqdw/zcTyr9zvGmLhgqHL/TIjh40ISuGS6cD26xzThFG55hrUAaNn
	rcyAyISIR+aeKtHzp4bd1NHrId63aYymHUvGw7gfP2sLso5EYwH4RyjeRDkYzNl8uVW2siO+6OH
	klxr3xsz2em6cLUPr65XYqlFPgHo8pI9AruIl9Nb/RD1vV8zaCV2BLWPDULsJvXXciQvexMa7jn
	pZpmqU75HUat6GwGu+qL7KIDcRPD84Sr8CCyDuHseJJgECuJoG7S4+S6ZkYoPjZwsqoo9uEMbzX
	eT9bpaycPqw2Lx7kY/m2fJjlV5
X-Received: by 2002:aa7:9dc2:0:b0:82f:dd8:2a52 with SMTP id d2e1a72fcca58-82f0dd8381emr2905870b3a.33.1775866635938;
        Fri, 10 Apr 2026 17:17:15 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4b5a79sm4353836b3a.30.2026.04.10.17.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 17:17:15 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/3] bpf: Use kmalloc_nolock() universally in local storage
Date: Fri, 10 Apr 2026 17:17:10 -0700
Message-ID: <20260411001711.3418264-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260411001711.3418264-1-ameryhung@gmail.com>
References: <20260411001711.3418264-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Switch to kmalloc_nolock() universally in local storage. Socket local
storage didn't move to kmalloc_nolock() when BPF memory allocator was
replaced by it for performance reasons. Now that kfree_rcu() supports
freeing memory allocated by kmalloc_nolock(), we can move the remaining
local storages to use kmalloc_nolock() and cleanup the cluttered free
paths.

Use kfree() instead of kfree_nolock() in bpf_selem_free_trace_rcu() and
bpf_local_storage_free_trace_rcu(). Both callbacks run in process context
where spinning is allowed, so kfree_nolock() is unnecessary.

Benchmark:

./bench -p 1 local-storage-create --storage-type socket \
  --batch-size {16,32,64}

The benchmark is a microbenchmark stress-testing how fast local storage
can be created. There is no measurable throughput change for socket local
storage after switching from kzalloc() to kmalloc_nolock().

Socket local storage

                 batch  creation speed              diff
---------------  ----   ------------------          ----
Baseline          16    433.9 ± 0.6 k/s
                  32    434.3 ± 1.4 k/s
                  64    434.2 ± 0.7 k/s

After             16    439.0 ± 1.9 k/s             +1.2%
                  32    437.3 ± 2.0 k/s             +0.7%
                  64    435.8 ± 2.5k/s              +0.4%

Also worth noting that the baseline got a 5% throughput boost when sheaf
replaces percpu partial slab recently [0].

[0] https://lore.kernel.org/bpf/20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz/

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |   8 +-
 kernel/bpf/bpf_cgrp_storage.c     |   2 +-
 kernel/bpf/bpf_inode_storage.c    |   2 +-
 kernel/bpf/bpf_local_storage.c    | 130 ++++--------------------------
 kernel/bpf/bpf_task_storage.c     |   2 +-
 net/core/bpf_sk_storage.c         |   2 +-
 6 files changed, 21 insertions(+), 125 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 8157e8da61d4..dced54e9265f 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -54,7 +54,6 @@ struct bpf_local_storage_map {
 	u32 bucket_log;
 	u16 elem_size;
 	u16 cache_idx;
-	bool use_kmalloc_nolock;
 };
 
 struct bpf_local_storage_data {
@@ -86,8 +85,7 @@ struct bpf_local_storage_elem {
 						 */
 	};
 	atomic_t state;
-	bool use_kmalloc_nolock;
-	/* 3 bytes hole */
+	/* 4 bytes hole */
 	/* The data is stored in another cacheline to minimize
 	 * the number of cachelines access during a cache hit.
 	 */
@@ -104,7 +102,6 @@ struct bpf_local_storage {
 	rqspinlock_t lock;	/* Protect adding/removing from the "list" */
 	u64 mem_charge;		/* Copy of mem charged to owner. Protected by "lock" */
 	refcount_t owner_refcnt;/* Used to pin owner when map_free is uncharging */
-	bool use_kmalloc_nolock;
 };
 
 /* U16_MAX is much more than enough for sk local storage
@@ -137,8 +134,7 @@ int bpf_local_storage_map_alloc_check(union bpf_attr *attr);
 
 struct bpf_map *
 bpf_local_storage_map_alloc(union bpf_attr *attr,
-			    struct bpf_local_storage_cache *cache,
-			    bool use_kmalloc_nolock);
+			    struct bpf_local_storage_cache *cache);
 
 void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
 				      struct bpf_local_storage_map *smap,
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index c2a2ead1f466..d93ac2866748 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -114,7 +114,7 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 {
-	return bpf_local_storage_map_alloc(attr, &cgroup_cache, true);
+	return bpf_local_storage_map_alloc(attr, &cgroup_cache);
 }
 
 static void cgroup_storage_map_free(struct bpf_map *map)
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index e86734609f3d..efc8996a4c0a 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -179,7 +179,7 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key,
 
 static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
 {
-	return bpf_local_storage_map_alloc(attr, &inode_cache, false);
+	return bpf_local_storage_map_alloc(attr, &inode_cache);
 }
 
 static void inode_storage_map_free(struct bpf_map *map)
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 9c96a4477f81..d0e6070fa68c 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -75,18 +75,12 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 	if (mem_charge(smap, owner, smap->elem_size))
 		return NULL;
 
-	if (smap->use_kmalloc_nolock) {
-		selem = bpf_map_kmalloc_nolock(&smap->map, smap->elem_size,
-					       __GFP_ZERO, NUMA_NO_NODE);
-	} else {
-		selem = bpf_map_kzalloc(&smap->map, smap->elem_size,
-					gfp_flags | __GFP_NOWARN);
-	}
+	selem = bpf_map_kmalloc_nolock(&smap->map, smap->elem_size,
+				       __GFP_ZERO, NUMA_NO_NODE);
 
 	if (selem) {
 		RCU_INIT_POINTER(SDATA(selem)->smap, smap);
 		atomic_set(&selem->state, 0);
-		selem->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 
 		if (value) {
 			/* No need to call check_and_init_map_value as memory is zero init */
@@ -102,8 +96,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 	return NULL;
 }
 
-/* rcu tasks trace callback for use_kmalloc_nolock == false */
-static void __bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
+static void bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage *local_storage;
 
@@ -115,47 +108,14 @@ static void __bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
 	kfree(local_storage);
 }
 
-/* Handle use_kmalloc_nolock == false */
-static void __bpf_local_storage_free(struct bpf_local_storage *local_storage,
-				     bool vanilla_rcu)
-{
-	if (vanilla_rcu)
-		kfree_rcu(local_storage, rcu);
-	else
-		call_rcu_tasks_trace(&local_storage->rcu,
-				     __bpf_local_storage_free_trace_rcu);
-}
-
-static void bpf_local_storage_free_rcu(struct rcu_head *rcu)
-{
-	struct bpf_local_storage *local_storage;
-
-	local_storage = container_of(rcu, struct bpf_local_storage, rcu);
-	kfree_nolock(local_storage);
-}
-
-static void bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
-{
-	/*
-	 * RCU Tasks Trace grace period implies RCU grace period, do
-	 * kfree() directly.
-	 */
-	bpf_local_storage_free_rcu(rcu);
-}
-
 static void bpf_local_storage_free(struct bpf_local_storage *local_storage,
 				   bool reuse_now)
 {
 	if (!local_storage)
 		return;
 
-	if (!local_storage->use_kmalloc_nolock) {
-		__bpf_local_storage_free(local_storage, reuse_now);
-		return;
-	}
-
 	if (reuse_now) {
-		call_rcu(&local_storage->rcu, bpf_local_storage_free_rcu);
+		kfree_rcu(local_storage, rcu);
 		return;
 	}
 
@@ -163,42 +123,7 @@ static void bpf_local_storage_free(struct bpf_local_storage *local_storage,
 			     bpf_local_storage_free_trace_rcu);
 }
 
-/* rcu callback for use_kmalloc_nolock == false */
-static void __bpf_selem_free_rcu(struct rcu_head *rcu)
-{
-	struct bpf_local_storage_elem *selem;
-	struct bpf_local_storage_map *smap;
-
-	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
-	/* bpf_selem_unlink_nofail may have already cleared smap and freed fields. */
-	smap = rcu_dereference_check(SDATA(selem)->smap, 1);
-
-	if (smap)
-		bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
-	kfree(selem);
-}
-
-/* rcu tasks trace callback for use_kmalloc_nolock == false */
-static void __bpf_selem_free_trace_rcu(struct rcu_head *rcu)
-{
-	/*
-	 * RCU Tasks Trace grace period implies RCU grace period, do
-	 * kfree() directly.
-	 */
-	__bpf_selem_free_rcu(rcu);
-}
-
-/* Handle use_kmalloc_nolock == false */
-static void __bpf_selem_free(struct bpf_local_storage_elem *selem,
-			     bool vanilla_rcu)
-{
-	if (vanilla_rcu)
-		call_rcu(&selem->rcu, __bpf_selem_free_rcu);
-	else
-		call_rcu_tasks_trace(&selem->rcu, __bpf_selem_free_trace_rcu);
-}
-
-static void bpf_selem_free_rcu(struct rcu_head *rcu)
+static void bpf_selem_free_trace_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage_elem *selem;
 	struct bpf_local_storage_map *smap;
@@ -209,37 +134,24 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
 
 	if (smap)
 		bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
-	kfree_nolock(selem);
-}
-
-static void bpf_selem_free_trace_rcu(struct rcu_head *rcu)
-{
 	/*
 	 * RCU Tasks Trace grace period implies RCU grace period, do
 	 * kfree() directly.
 	 */
-	bpf_selem_free_rcu(rcu);
+	kfree(selem);
 }
 
 void bpf_selem_free(struct bpf_local_storage_elem *selem,
 		    bool reuse_now)
 {
-	if (!selem->use_kmalloc_nolock) {
-		/*
-		 * No uptr will be unpin even when reuse_now == false since uptr
-		 * is only supported in task local storage, where
-		 * smap->use_kmalloc_nolock == true.
-		 */
-		__bpf_selem_free(selem, reuse_now);
-		return;
-	}
+	struct bpf_local_storage_map *smap;
+
+	smap = rcu_dereference_check(SDATA(selem)->smap, 1);
 
 	if (reuse_now) {
-		/*
-		 * While it is okay to call bpf_obj_free_fields() that unpins uptr when
-		 * reuse_now == true, keep it in bpf_selem_free_rcu() for simplicity.
-		 */
-		call_rcu(&selem->rcu, bpf_selem_free_rcu);
+		if (smap)
+			bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
+		kfree_rcu(selem, rcu);
 		return;
 	}
 
@@ -565,12 +477,8 @@ int bpf_local_storage_alloc(void *owner,
 	if (err)
 		return err;
 
-	if (smap->use_kmalloc_nolock)
-		storage = bpf_map_kmalloc_nolock(&smap->map, sizeof(*storage),
-						 __GFP_ZERO, NUMA_NO_NODE);
-	else
-		storage = bpf_map_kzalloc(&smap->map, sizeof(*storage),
-					  gfp_flags | __GFP_NOWARN);
+	storage = bpf_map_kmalloc_nolock(&smap->map, sizeof(*storage),
+					 __GFP_ZERO, NUMA_NO_NODE);
 	if (!storage) {
 		err = -ENOMEM;
 		goto uncharge;
@@ -580,7 +488,6 @@ int bpf_local_storage_alloc(void *owner,
 	raw_res_spin_lock_init(&storage->lock);
 	storage->owner = owner;
 	storage->mem_charge = sizeof(*storage);
-	storage->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 	refcount_set(&storage->owner_refcnt, 1);
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
@@ -857,8 +764,7 @@ u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map)
 
 struct bpf_map *
 bpf_local_storage_map_alloc(union bpf_attr *attr,
-			    struct bpf_local_storage_cache *cache,
-			    bool use_kmalloc_nolock)
+			    struct bpf_local_storage_cache *cache)
 {
 	struct bpf_local_storage_map *smap;
 	unsigned int i;
@@ -890,12 +796,6 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 	smap->elem_size = offsetof(struct bpf_local_storage_elem,
 				   sdata.data[attr->value_size]);
 
-	/* In PREEMPT_RT, kmalloc(GFP_ATOMIC) is still not safe in non
-	 * preemptible context. Thus, enforce all storages to use
-	 * kmalloc_nolock() when CONFIG_PREEMPT_RT is enabled.
-	 */
-	smap->use_kmalloc_nolock = IS_ENABLED(CONFIG_PREEMPT_RT) ? true : use_kmalloc_nolock;
-
 	smap->cache_idx = bpf_local_storage_cache_idx_get(cache);
 	return &smap->map;
 
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 605506792b5b..55f4f22bb212 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -212,7 +212,7 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
 {
-	return bpf_local_storage_map_alloc(attr, &task_cache, true);
+	return bpf_local_storage_map_alloc(attr, &task_cache);
 }
 
 static void task_storage_map_free(struct bpf_map *map)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index f8338acebf07..9fb22e352beb 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -68,7 +68,7 @@ static void bpf_sk_storage_map_free(struct bpf_map *map)
 
 static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
 {
-	return bpf_local_storage_map_alloc(attr, &sk_cache, false);
+	return bpf_local_storage_map_alloc(attr, &sk_cache);
 }
 
 static int notsupp_get_next_key(struct bpf_map *map, void *key,
-- 
2.52.0

