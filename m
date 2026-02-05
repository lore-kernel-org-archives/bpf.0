Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D85354AF1
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 07:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274936; cv=none; b=n+6AEqhLuXR7HKl2ImO8bFxOo0iwKZKK6Dd22LJmV+CGL3jpXqMQRRyqYsjrBc+kuCZHXZW14SUSJhPdHMa8PPGB/O0NAcOrswX6N9dqS7bnNE9CpogR2/8fRB4/ETTWqCo7dslkt8kPDI//OU8kFHAor5Yh2ZYPvhAEwonP5F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274936; c=relaxed/simple;
	bh=YceoYaE7tZMhfDDH3ryuxeFypnUAlt+0vjgfaQp1kU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzI4B1QRNIKgcaWprP1ZwpD8TZmZR/uisk84IngOF9h+iqUKcE9q34UgmjMvURmpkW2/YlQDkqFyZQc7zhYzc/PRlE+22GsEhnm6ucscCzVvRnmbMGYC7pfxehKueZiJEWRH8tRSouXZA8AsIcM2J2kYv8hum6rJjgw5fs26T/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8GxORC1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8GxORC1"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-81f4dfa82edso366440b3a.0
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 23:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274936; x=1770879736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUTlkhP8irrGiE52R63A1ym6p47CQ9zFdFjmUGE1hxM=;
        b=J8GxORC1rD8rZOf8uZlabro7goGMpPtB0tpDjV8BQVMHOUJVC6gnPRpQBH80FMjPJ/
         8kWI+qpGn29yrp/HrCQ3Pf+WZF7k96/II5iNnifu3l9GO0GaDZrmNSx9Q3tLgNtq+ybP
         82ai5IFUjM7RkgqS9vB6ZhkYf2AegH1vv3r6aaWI2C3BXLH0a6B5WE80TsKVeYgAAhyJ
         IqdS7Bjs1KlgMrUYKZBOvhyVz5PH+fZgkBjk4yKn94Zg0YHTkUv0aTKKDHpWAm4uuZHL
         EF5FW9/D76OwdD5nX94LhdNOgL6P5DKaKwFy8QlbaSQ8oEmho42aHyu0fsidury/kCBW
         0RYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274936; x=1770879736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JUTlkhP8irrGiE52R63A1ym6p47CQ9zFdFjmUGE1hxM=;
        b=OB0WkY4Kk5iR8xoRQf/su3HD4aEAhYEpUK9H0MJku5C+jZrsSy1qrbYW1Hq4BxmxWv
         fg5VlgPGrUmwXXwyC+T/RsGhpWLNG/Rfg4iMOPMi/U7oGnC72Gptb2qQWz2CtPsxNGEr
         nU7J04AbD6gXHRUPLxsHsa1nWkMcFYZsUqBqcHGTfEcDi/2qUU7X/jNfrO9SEc6om6a6
         vNGyL8453+45BfGpzeiAh5OWZHaNhXKAHKUJXmLYEeS5n1Rd9RelgPV7yVyBahe/W/lf
         nNnEJ9rTDTdz6z4/gwQay1IiH4WJxcZuzy1sCfgRIslz6yDhDZJ7IUKXWbxVBX+grTn8
         rJSw==
X-Gm-Message-State: AOJu0Yxo3b4nOX/+NAKZakePSmQKG8Lxq1//vh2cnBgE7gMkwXGeu8KI
	T2j0VZVbX2AGS1WUuw/q3vHCjKTDcyyegzZ5qXV9bLa9NWwGsPcWxw/K6x42KQ==
X-Gm-Gg: AZuq6aLsJVDBRwIdm9TJsmOVsk8BR67WcZc8e49h3IcZO08ZOnP3Y4S8r4gB9kP4VnO
	CZohhESdYi00mgPwcGQCSZ+I6ZA5A/C+GFCt17wSCxLkKDR8cQj/aF4PaSBuPi37QGSqeJVfdPs
	Pg6ZauYpIrhCvG8lTqtkHZ7nO7bg6/+OQYI8oGjI12mZUGhK0new8Q6SbdYN9XPhLhMeS2UPlN5
	0kE7FdjIM/bdSg8mCHMPukZZrEVNFB6alQ5qLYfTlZ2v1P0EVIVnLYOIQ0gb8dAtiCSAOjSIE7O
	0cmCJVPn2nBWGDV0WIVsZPiHI8a0cPyEwmt1n8vq1K/w05AWzgO+gvrRqTKktNLvoijO2Sc/LJq
	Ex6cDbmBogODxVhqy9Jq7hjlRmEeqC5UPinVQpoFH5svpSGcrnWuJm4mQrLbVkY+47ZXjPJT4Wl
	MpXA==
X-Received: by 2002:a05:6a00:4fd1:b0:81c:c98c:aeb7 with SMTP id d2e1a72fcca58-8241c1972d5mr5503733b3a.7.1770274935756;
        Wed, 04 Feb 2026 23:02:15 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d16401esm4774025b3a.4.2026.02.04.23.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:15 -0800 (PST)
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
Subject: [PATCH bpf-next v6 05/17] bpf: Change local_storage->lock and b->lock to rqspinlock
Date: Wed,  4 Feb 2026 23:01:54 -0800
Message-ID: <20260205070208.186382-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205070208.186382-1-ameryhung@gmail.com>
References: <20260205070208.186382-1-ameryhung@gmail.com>
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
raw_res_spin_lock_irqsave() for now. A later patch will allow
bpf_local_storage_destroy() to unlink selems even when failing to
acquire locks.

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
index 5dcdf8e523b4..b33ef5fb5b49 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -322,14 +322,18 @@ static int bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
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
@@ -345,11 +349,16 @@ int bpf_selem_link_map(struct bpf_local_storage_map *smap,
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
@@ -366,7 +375,7 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 	bool free_local_storage = false;
 	HLIST_HEAD(selem_free_list);
 	unsigned long flags;
-	int err = 0;
+	int err;
 
 	if (unlikely(!selem_linked_to_storage_lockless(selem)))
 		/* selem has already been unlinked from sk */
@@ -375,7 +384,10 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
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
@@ -389,7 +401,7 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 			local_storage, selem, &selem_free_list);
 	}
 out:
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 
 	bpf_selem_free_list(&selem_free_list, reuse_now);
 
@@ -404,16 +416,20 @@ void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
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
@@ -458,14 +474,17 @@ int bpf_local_storage_alloc(void *owner,
 
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
@@ -483,11 +502,11 @@ int bpf_local_storage_alloc(void *owner,
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
 
@@ -570,7 +589,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	if (!alloc_selem)
 		return ERR_PTR(-ENOMEM);
 
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
+	if (err)
+		goto free_selem;
 
 	/* Recheck local_storage->list under local_storage->lock */
 	if (unlikely(hlist_empty(&local_storage->list))) {
@@ -597,7 +618,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 
 	b = select_bucket(smap, local_storage);
 
-	raw_spin_lock_irqsave(&b->lock, b_flags);
+	err = raw_res_spin_lock_irqsave(&b->lock, b_flags);
+	if (err)
+		goto unlock;
 
 	alloc_selem = NULL;
 	/* First, link the new selem to the map */
@@ -613,9 +636,10 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
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
@@ -700,7 +724,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 	 * when unlinking elem from the local_storage->list and
 	 * the map's bucket->list.
 	 */
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	raw_res_spin_lock_irqsave(&local_storage->lock, flags);
 	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
 		/* Always unlink from map before unlinking from
 		 * local_storage.
@@ -715,7 +739,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 		free_storage = bpf_selem_unlink_storage_nolock(
 			local_storage, selem, &free_selem_list);
 	}
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 
 	bpf_selem_free_list(&free_selem_list, true);
 
@@ -762,7 +786,7 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 
 	for (i = 0; i < nbuckets; i++) {
 		INIT_HLIST_HEAD(&smap->buckets[i].list);
-		raw_spin_lock_init(&smap->buckets[i].lock);
+		raw_res_spin_lock_init(&smap->buckets[i].lock);
 	}
 
 	smap->elem_size = offsetof(struct bpf_local_storage_elem,
-- 
2.47.3

