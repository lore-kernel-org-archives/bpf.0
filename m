Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11D7339875
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330569; cv=none; b=lN55QOP/XG/qxE24yps1fbPk3ZcOOR9HsdR0pTMbpF9nDwMVI7Hg8v9yySF3KNSnWzP+V+jdWH5nsfyKux7NsJNWtVbSUy+l/gs7KstK4RjzBuxtCqCtmIvbH/MsSYRGptrwCWaL30YcolqvusSI9w5fRYVNcZoJ0bzSvgLVl4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330569; c=relaxed/simple;
	bh=VnozYrLGaSmHn47JWZHYKC8m8kRx77A8yvcPMxveW7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3QKe+fKHLO9xWz2hSrb/LJdC066vy/4wAb3j7NOXoGvdlCc/lhZNxc2UhYdoD1O3bwOlkqA1jM6t6r4c7EzPtPLvUgpSJ6tDvNMRQcK5cjzbTXN2gV324OiEcqrSmqQJ3SX/8zcvL9WSdn5h+MsKTtYBA7r8MFpGtLKHGmR87Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huWsolxb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huWsolxb"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a871daa98fso359805ad.1
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 14:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330569; x=1770935369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIhJtZRCLk7YdjNlG+1nU9SqVwd00JGho6ErExhHcww=;
        b=huWsolxbbTouNxxyCyfHU04QkX/gs+2pxtotwi998YX0krQxE/XDDe7lMbqhPy0QgL
         7U6VwkPbskx4NQVXwrlKltDQMM6TI3adqQ04GooajPSB8WGdVYwKha2oxXLq5gwsJBft
         SZ86Cx0wIxE14O1rqzjDZgEeDLTlpAPfpLwtmU1E14BDCa4h6d6e+3clSVjSa7Qbo+4G
         8jYxpOgSfJGbFTTZGaU7W21C4P93aXrw06sbxZznAbbKknhR40mfHiHESMhiyscqjq1C
         oX+TQDKNvxvAJWPA3uYC+RLOjgRF+qYkug11RfHeJ6OMJXMS/uNJsF4FzV8ZkKWF9sCg
         12yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330569; x=1770935369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AIhJtZRCLk7YdjNlG+1nU9SqVwd00JGho6ErExhHcww=;
        b=R85HYESniTIvnFhqX47T+mg8hcJ+/lqaAsdyG9ly6pxeM6YnJ4GDC5ricF/3k0YcRs
         8cnC11fVI2HAjWuNOb7MKb5I6N52jfx52mhG9qlDPwuBgIx7rYj+DbEdl7mpd1E8E9WV
         vFAu+YKUe5/LrGvImXAgE0voTahShYect4npR6Wbge4rRxmz1qYbR6ZKdw6hLl5TbOZ4
         rq+o3k1a9zvIMF/YyJcA5omTA+cbPsZ6I8/HrvaLtnvneOKM7IUVrt87Jm5kXu6UXSJN
         xMSCiIist88tg3mtByBSPU+UC8LXJuT+Y+rI1Pp0FREs0ej+ZS/DarRoRL95KdZxJUCk
         gtIQ==
X-Gm-Message-State: AOJu0YyVoHnKc8l8WVenVeQC+p3Gdi2244JSRi5M/vJJgU3Y6z/Mp4Qf
	KZJiQ0yKqqvXfy+nC+qRLLnxEsUfPLStcRqQgEssXkP6lvykS0m2bGeaQ258Aw==
X-Gm-Gg: AZuq6aJGsJa1Ju9x4LCOWF+ccYPMGMhGwamfvIWLgdQIypA6RCmV2fTUK322woqJNiu
	XnJtWuxq544rLrsM9mJOx5OvXaActBUEbvlG6Z33hfga00hQ4RF6Yn0DuBO2UICw3e37LJUaGm2
	wrRjTDQIPM55WpuwOruzeCbkbA3LlhN2Zc3tv9LW385fMiowmeiaDh1cT6xpKmvymEtAMzHmaEf
	jW8BKLiute6BYQhZG4paqcexUQNlVs2dkyu8a78wIsgXTfYu+mqe6rRgSKJh1zowLt1GdtYYIhQ
	TwnYSBDusjhKgV1AQkV1ok1a0r+LFunf4dnW8PT6LYXGP3sV4kvTxWEVJBYWRqvLAmrWx3WK1rI
	vgsn5aO6l6U7bpu763rjvkjFD9gzLiMSgOgvCT8MwRgQ83C6P8EYwp3sFRo9/lAuOn7/DQGyLDq
	QekA==
X-Received: by 2002:a17:902:ea06:b0:2a9:4cab:f4f5 with SMTP id d9443c01a7336-2a95192a995mr7212065ad.38.1770330569042;
        Thu, 05 Feb 2026 14:29:29 -0800 (PST)
Received: from localhost ([2a03:2880:ff:59::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951a638e3sm4051005ad.1.2026.02.05.14.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:29:28 -0800 (PST)
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
Subject: [PATCH bpf-next v7 10/17] bpf: Support lockless unlink when freeing map or local storage
Date: Thu,  5 Feb 2026 14:29:08 -0800
Message-ID: <20260205222916.1788211-11-ameryhung@gmail.com>
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

Introduce bpf_selem_unlink_nofail() to properly handle errors returned
from rqspinlock in bpf_local_storage_map_free() and
bpf_local_storage_destroy() where the operation must succeeds.

The idea of bpf_selem_unlink_nofail() is to allow an selem to be
partially linked and use atomic operation on a bit field, selem->state,
to determine when and who can free the selem if any unlink under lock
fails. An selem initially is fully linked to a map and a local storage.
Under normal circumstances, bpf_selem_unlink_nofail() will be able to
grab locks and unlink a selem from map and local storage in sequeunce,
just like bpf_selem_unlink(), and then free it after an RCU grace period.
However, if any of the lock attempts fails, it will only clear
SDATA(selem)->smap or selem->local_storage depending on the caller and
set SELEM_MAP_UNLINKED or SELEM_STORAGE_UNLINKED according to the
caller. Then, after both map_free() and destroy() see the selem and the
state becomes SELEM_UNLINKED, one of two racing caller can succeed in
cmpxchg the state from SELEM_UNLINKED to SELEM_TOFREE, ensuring no
double free or memory leak.

To make sure bpf_obj_free_fields() is done only once and when map is
still present, it is called when unlinking an selem from b->list under
b->lock.

To make sure uncharging memory is done only when the owner is still
present in map_free(), block destroy() from returning until there is no
pending map_free().

Since smap may not be valid in destroy(), bpf_selem_unlink_nofail()
skips bpf_selem_unlink_storage_nolock_misc() when called from destroy().
This is okay as bpf_local_storage_destroy() will return the remaining
amount of memory charge tracked by mem_charge to the owner to uncharge.
It is also safe to skip clearing local_storage->owner and owner_storage
as the owner is being freed and no users or bpf programs should be able
to reference the owner and using local_storage.

Finally, access of selem, SDATA(selem)->smap and selem->local_storage
are racy. Callers will protect these fields with RCU.

Co-developed-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |   9 ++-
 kernel/bpf/bpf_local_storage.c    | 116 ++++++++++++++++++++++++++++--
 2 files changed, 118 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index a34ed7fa81d8..69a5d8aa765d 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -68,6 +68,11 @@ struct bpf_local_storage_data {
 	u8 data[] __aligned(8);
 };
 
+#define SELEM_MAP_UNLINKED	(1 << 0)
+#define SELEM_STORAGE_UNLINKED	(1 << 1)
+#define SELEM_UNLINKED		(SELEM_MAP_UNLINKED | SELEM_STORAGE_UNLINKED)
+#define SELEM_TOFREE		(1 << 2)
+
 /* Linked to bpf_local_storage and bpf_local_storage_map */
 struct bpf_local_storage_elem {
 	struct hlist_node map_node;	/* Linked to bpf_local_storage_map */
@@ -80,8 +85,9 @@ struct bpf_local_storage_elem {
 						 * after raw_spin_unlock
 						 */
 	};
+	atomic_t state;
 	bool use_kmalloc_nolock;
-	/* 7 bytes hole */
+	/* 3 bytes hole */
 	/* The data is stored in another cacheline to minimize
 	 * the number of cachelines access during a cache hit.
 	 */
@@ -97,6 +103,7 @@ struct bpf_local_storage {
 	struct rcu_head rcu;
 	rqspinlock_t lock;	/* Protect adding/removing from the "list" */
 	u64 mem_charge;		/* Copy of mem charged to owner. Protected by "lock" */
+	refcount_t owner_refcnt;/* Used to pin owner when map_free is uncharging */
 	bool use_kmalloc_nolock;
 };
 
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 0e9ae41a9759..294605c78271 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -85,6 +85,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 
 	if (selem) {
 		RCU_INIT_POINTER(SDATA(selem)->smap, smap);
+		atomic_set(&selem->state, 0);
 		selem->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 
 		if (value) {
@@ -194,9 +195,11 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
 	/* The bpf_local_storage_map_free will wait for rcu_barrier */
 	smap = rcu_dereference_check(SDATA(selem)->smap, 1);
 
-	migrate_disable();
-	bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
-	migrate_enable();
+	if (smap) {
+		migrate_disable();
+		bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
+		migrate_enable();
+	}
 	kfree_nolock(selem);
 }
 
@@ -221,7 +224,8 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 		 * is only supported in task local storage, where
 		 * smap->use_kmalloc_nolock == true.
 		 */
-		bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
+		if (smap)
+			bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
 		__bpf_selem_free(selem, reuse_now);
 		return;
 	}
@@ -255,7 +259,7 @@ static void bpf_selem_free_list(struct hlist_head *list, bool reuse_now)
 static void bpf_selem_unlink_storage_nolock_misc(struct bpf_local_storage_elem *selem,
 						 struct bpf_local_storage_map *smap,
 						 struct bpf_local_storage *local_storage,
-						 bool free_local_storage)
+						 bool free_local_storage, bool pin_owner)
 {
 	void *owner = local_storage->owner;
 	u32 uncharge = smap->elem_size;
@@ -264,6 +268,9 @@ static void bpf_selem_unlink_storage_nolock_misc(struct bpf_local_storage_elem *
 	    SDATA(selem))
 		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
 
+	if (pin_owner && !refcount_inc_not_zero(&local_storage->owner_refcnt))
+		return;
+
 	uncharge += free_local_storage ? sizeof(*local_storage) : 0;
 	mem_uncharge(smap, local_storage->owner, uncharge);
 	local_storage->mem_charge -= uncharge;
@@ -274,6 +281,9 @@ static void bpf_selem_unlink_storage_nolock_misc(struct bpf_local_storage_elem *
 		/* After this RCU_INIT, owner may be freed and cannot be used */
 		RCU_INIT_POINTER(*owner_storage(smap, owner), NULL);
 	}
+
+	if (pin_owner)
+		refcount_dec(&local_storage->owner_refcnt);
 }
 
 /* local_storage->lock must be held and selem->local_storage == local_storage.
@@ -293,7 +303,7 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 						    &local_storage->list);
 
 	bpf_selem_unlink_storage_nolock_misc(selem, smap, local_storage,
-					     free_local_storage);
+					     free_local_storage, false);
 
 	hlist_del_init_rcu(&selem->snode);
 
@@ -409,6 +419,94 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 	return err;
 }
 
+/*
+ * Unlink an selem from map and local storage with lockless fallback if callers
+ * are racing or rqspinlock returns error. It should only be called by
+ * bpf_local_storage_destroy() or bpf_local_storage_map_free().
+ */
+static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *selem,
+				    struct bpf_local_storage_map_bucket *b)
+{
+	bool in_map_free = !!b, free_storage = false;
+	struct bpf_local_storage *local_storage;
+	struct bpf_local_storage_map *smap;
+	unsigned long flags;
+	int err, unlink = 0;
+
+	local_storage = rcu_dereference_check(selem->local_storage, bpf_rcu_lock_held());
+	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
+
+	if (smap) {
+		b = b ? : select_bucket(smap, local_storage);
+		err = raw_res_spin_lock_irqsave(&b->lock, flags);
+		if (!err) {
+			/*
+			 * Call bpf_obj_free_fields() under b->lock to make sure it is done
+			 * exactly once for an selem. Safe to free special fields immediately
+			 * as no BPF program should be referencing the selem.
+			 */
+			if (likely(selem_linked_to_map(selem))) {
+				hlist_del_init_rcu(&selem->map_node);
+				bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
+				unlink++;
+			}
+			raw_res_spin_unlock_irqrestore(&b->lock, flags);
+		}
+		/*
+		 * Highly unlikely scenario: resource leak
+		 *
+		 * When map_free(selem1), destroy(selem1) and destroy(selem2) are racing
+		 * and both selem belong to the same bucket, if destroy(selem2) acquired
+		 * b->lock and block for too long, neither map_free(selem1) and
+		 * destroy(selem1) will be able to free the special field associated
+		 * with selem1 as raw_res_spin_lock_irqsave() returns -ETIMEDOUT.
+		 */
+		WARN_ON_ONCE(err && in_map_free);
+		if (!err || in_map_free)
+			RCU_INIT_POINTER(SDATA(selem)->smap, NULL);
+	}
+
+	if (local_storage) {
+		err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
+		if (!err) {
+			if (likely(selem_linked_to_storage(selem))) {
+				free_storage = hlist_is_singular_node(&selem->snode,
+								      &local_storage->list);
+				 /*
+				  * Okay to skip clearing owner_storage and storage->owner in
+				  * destroy() since the owner is going away. No user or bpf
+				  * programs should be able to reference it.
+				  */
+				if (smap && in_map_free)
+					bpf_selem_unlink_storage_nolock_misc(
+						selem, smap, local_storage,
+						free_storage, true);
+				hlist_del_init_rcu(&selem->snode);
+				unlink++;
+			}
+			raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
+		}
+		if (!err || !in_map_free)
+			RCU_INIT_POINTER(selem->local_storage, NULL);
+	}
+
+	if (unlink != 2)
+		atomic_or(in_map_free ? SELEM_MAP_UNLINKED : SELEM_STORAGE_UNLINKED, &selem->state);
+
+	/*
+	 * Normally, an selem can be unlinked under local_storage->lock and b->lock, and
+	 * then freed after an RCU grace period. However, if destroy() and map_free() are
+	 * racing or rqspinlock returns errors in unlikely situations (unlink != 2), free
+	 * the selem only after both map_free() and destroy() see the selem.
+	 */
+	if (unlink == 2 ||
+	    atomic_cmpxchg(&selem->state, SELEM_UNLINKED, SELEM_TOFREE) == SELEM_UNLINKED)
+		bpf_selem_free(selem, true);
+
+	if (free_storage)
+		bpf_local_storage_free(local_storage, true);
+}
+
 void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
 				      struct bpf_local_storage_map *smap,
 				      struct bpf_local_storage_elem *selem)
@@ -475,6 +573,7 @@ int bpf_local_storage_alloc(void *owner,
 	storage->owner = owner;
 	storage->mem_charge = sizeof(*storage);
 	storage->use_kmalloc_nolock = smap->use_kmalloc_nolock;
+	refcount_set(&storage->owner_refcnt, 1);
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
 
@@ -743,6 +842,11 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 
 	if (free_storage)
 		bpf_local_storage_free(local_storage, true);
+
+	if (!refcount_dec_and_test(&local_storage->owner_refcnt)) {
+		while (refcount_read(&local_storage->owner_refcnt))
+			cpu_relax();
+	}
 }
 
 u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map)
-- 
2.47.3

