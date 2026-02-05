Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E58359701
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 07:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274940; cv=none; b=lZfs9tZKC6LVqisJLDgA0sHe+5kvrcm0xoVUR8wHhNa3KkFxl0F2COXaQkeyMd6r29x5g0f1dEJhk5ZoGEsBobihFlZJ9KwRp1k3UeoG5z6hAIoyxpaY5eWxkTb+UtyYJOeP2e6qlzIcrIbIpGAyGxKPlYJBiKuyn1pqAKrKVkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274940; c=relaxed/simple;
	bh=8up+wZy9RrzSdoWwRf0FZK/yhU97o7sUFXZ6sCudOPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pauf/ashLYcxUH/Ww2850onKTqtFTmtqqZ1Z4f5/W1LXdJRYSFPCryrn8VEQCDBZ5CpKfo87Gth8WcFp5Chwge+6odWkAniDW2SlWu8DGra6uCq2R7K2X2w+De4tbn39fG78XbK3kHNeS5Fy8NbjuhKisujdWJ5ZXsMtI3LeJGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLbUY+IE; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLbUY+IE"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso1101841a91.1
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 23:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274940; x=1770879740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvzLeA7TbKOCQYjLRl0umDrTwnucL4WTJeEfH0WWcV4=;
        b=TLbUY+IE71VTAaUEIsccsXGwPJBuXc9fFSrgOCEyScqIioBOUXIgpZtVuwZ5lvsLs9
         IlwY0RWJ8H8odot9tCi4gUcBG3mks85PmoexBwh/Xn5mCyHDONUOqYg1vl3PEPGVH3lC
         aLjKYzaWBwakdjwDGMfBcC0maf4ogHiCCmGNjjpWBfvBz5bJV9nrs0cOqHeSw4RdpWof
         VjPi1WC5Uqt0gM/CR8bBoh9evMrr7TgT9GQJhYnVGRhhXjSAboDPyXVP1+9HYwt1fj4r
         REmPkKWnYft3D1K69diOsleFV3ffsP7PyKqGKELVX+omSdu0/cZm/e1Y2DZ+Jx1WkMAr
         nlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274940; x=1770879740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mvzLeA7TbKOCQYjLRl0umDrTwnucL4WTJeEfH0WWcV4=;
        b=jllvT+WUApQdM8eHikaYKTMZcEXtYPraZIwsdR+tXdV2w9eKpyO/Hln67zg1CYLeMw
         2VLyl5sD0Aa8JqAYa3i4yHg0OwAtLqVbDr6Dick8BeiA2IwoupoOPon41hyQUEZ8Z82E
         Ap79cNoHayOxAPTa1A6ibIU4774qthyy2ZuMNB7wTxfRRZamxJ5In3OINLCLVaIXH/nq
         Mg0PTR2gPBTvCl4ibLi0a6pomw7wj8sym8iR1TrTA3JbHHD+wZMK9gV/eQUOX4gxg5Wp
         ssk8AUrji38HicvxOerYrmtuI1wUj2/WGwEiFZJALguFnlN70QTfE7mQL3/fg27DBjq6
         whEw==
X-Gm-Message-State: AOJu0YyT5vVfnC4AEVpDnaohbR0dimqk19+9SUymhJhn0hj3rdV4L1Qz
	7f9e0PfXcO9qpxq2J6NhYhjjWhV07RaUhTUHn8F7aTsBtHh4zuzxppxk9EL1Bw==
X-Gm-Gg: AZuq6aL2T4xtOABFS2Viu7F36JxypwjMkYxkmBmZr2jwXfcycorSeBm7mDWhPHDn63C
	+qlRtgs5/CfyVCR6GiAz2qNHE9XREHegzvLg9GNBOClMb+8uhv50JAnTsZnoTRqX8JjCfN6j24J
	knfzbFRLpqAw7EVpy6ws31npTra56kagFIdI4McZXdzyZpOE7Dp6pxfzj6qP998Bxa/BnjOdPmU
	H5eAHo7Ji3YNtbo+lKZMD2fDwLQEQ6WntRYZrc2Ptyi4SEeBAkgQnVS4/txBVK4X8AghjzRzVwB
	3De00YlIpSYr1SBMOoj9ntK0SMuCt7EL6yMW5F5qcm7ZmFDPUnNJAhcGt22qCFDAzCPrndekn0C
	PgLTzud2PCoiB1m8OLy7KnxIi0B2ymX2u60GKuq1fbf9y5JGcHIFQkAF73VvYTHPXTS1DS1o5EI
	Ft
X-Received: by 2002:a17:903:1a4e:b0:2a7:5e7a:5e80 with SMTP id d9443c01a7336-2a9411e087bmr18719715ad.26.1770274939853;
        Wed, 04 Feb 2026 23:02:19 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933851050sm43564815ad.5.2026.02.04.23.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:19 -0800 (PST)
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
Subject: [PATCH bpf-next v6 09/17] bpf: Prepare for bpf_selem_unlink_nofail()
Date: Wed,  4 Feb 2026 23:01:58 -0800
Message-ID: <20260205070208.186382-10-ameryhung@gmail.com>
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

The next patch will introduce bpf_selem_unlink_nofail() to handle
rqspinlock errors. bpf_selem_unlink_nofail() will allow an selem to be
partially unlinked from map or local storage. Save memory allocation
method in selem so that later an selem can be correctly freed even when
SDATA(selem)->smap is init to NULL.

In addition, keep track of memory charge to the owner in local storage
so that later bpf_selem_unlink_nofail() can return the correct memory
charge to the owner. Updating local_storage->mem_charge is protected by
local_storage->lock.

Finally, extract miscellaneous tasks performed when unlinking an selem
from local_storage into bpf_selem_unlink_storage_nolock_misc(). It will
be reused by bpf_selem_unlink_nofail().

This patch also takes the chance to remove local_storage->smap, which
is no longer used since commit f484f4a3e058 ("bpf: Replace bpf memory
allocator with kmalloc_nolock() in local storage").

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  5 ++-
 kernel/bpf/bpf_local_storage.c    | 67 ++++++++++++++++---------------
 2 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index fba3354988d3..a34ed7fa81d8 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -80,7 +80,8 @@ struct bpf_local_storage_elem {
 						 * after raw_spin_unlock
 						 */
 	};
-	/* 8 bytes hole */
+	bool use_kmalloc_nolock;
+	/* 7 bytes hole */
 	/* The data is stored in another cacheline to minimize
 	 * the number of cachelines access during a cache hit.
 	 */
@@ -89,13 +90,13 @@ struct bpf_local_storage_elem {
 
 struct bpf_local_storage {
 	struct bpf_local_storage_data __rcu *cache[BPF_LOCAL_STORAGE_CACHE_SIZE];
-	struct bpf_local_storage_map __rcu *smap;
 	struct hlist_head list; /* List of bpf_local_storage_elem */
 	void *owner;		/* The object that owns the above "list" of
 				 * bpf_local_storage_elem.
 				 */
 	struct rcu_head rcu;
 	rqspinlock_t lock;	/* Protect adding/removing from the "list" */
+	u64 mem_charge;		/* Copy of mem charged to owner. Protected by "lock" */
 	bool use_kmalloc_nolock;
 };
 
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 3735f79a7b55..f8cfef31e3b8 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -85,6 +85,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 
 	if (selem) {
 		RCU_INIT_POINTER(SDATA(selem)->smap, smap);
+		selem->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 
 		if (value) {
 			/* No need to call check_and_init_map_value as memory is zero init */
@@ -214,7 +215,7 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 
-	if (!smap->use_kmalloc_nolock) {
+	if (!selem->use_kmalloc_nolock) {
 		/*
 		 * No uptr will be unpin even when reuse_now == false since uptr
 		 * is only supported in task local storage, where
@@ -251,6 +252,30 @@ static void bpf_selem_free_list(struct hlist_head *list, bool reuse_now)
 		bpf_selem_free(selem, reuse_now);
 }
 
+static void bpf_selem_unlink_storage_nolock_misc(struct bpf_local_storage_elem *selem,
+						 struct bpf_local_storage_map *smap,
+						 struct bpf_local_storage *local_storage,
+						 bool free_local_storage)
+{
+	void *owner = local_storage->owner;
+	u32 uncharge = smap->elem_size;
+
+	if (rcu_access_pointer(local_storage->cache[smap->cache_idx]) ==
+	    SDATA(selem))
+		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
+
+	uncharge += free_local_storage ? sizeof(*local_storage) : 0;
+	mem_uncharge(smap, local_storage->owner, uncharge);
+	local_storage->mem_charge -= uncharge;
+
+	if (free_local_storage) {
+		local_storage->owner = NULL;
+
+		/* After this RCU_INIT, owner may be freed and cannot be used */
+		RCU_INIT_POINTER(*owner_storage(smap, owner), NULL);
+	}
+}
+
 /* local_storage->lock must be held and selem->local_storage == local_storage.
  * The caller must ensure selem->smap is still valid to be
  * dereferenced for its smap->elem_size and smap->cache_idx.
@@ -266,51 +291,27 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 	owner = local_storage->owner;
 
-	/* All uncharging on the owner must be done first.
-	 * The owner may be freed once the last selem is unlinked
-	 * from local_storage.
-	 */
-	mem_uncharge(smap, owner, smap->elem_size);
-
 	free_local_storage = hlist_is_singular_node(&selem->snode,
 						    &local_storage->list);
-	if (free_local_storage) {
-		mem_uncharge(smap, owner, sizeof(struct bpf_local_storage));
-		local_storage->owner = NULL;
 
-		/* After this RCU_INIT, owner may be freed and cannot be used */
-		RCU_INIT_POINTER(*owner_storage(smap, owner), NULL);
+	bpf_selem_unlink_storage_nolock_misc(selem, smap, local_storage,
+					     free_local_storage);
 
-		/* local_storage is not freed now.  local_storage->lock is
-		 * still held and raw_spin_unlock_bh(&local_storage->lock)
-		 * will be done by the caller.
-		 *
-		 * Although the unlock will be done under
-		 * rcu_read_lock(),  it is more intuitive to
-		 * read if the freeing of the storage is done
-		 * after the raw_spin_unlock_bh(&local_storage->lock).
-		 *
-		 * Hence, a "bool free_local_storage" is returned
-		 * to the caller which then calls then frees the storage after
-		 * all the RCU grace periods have expired.
-		 */
-	}
 	hlist_del_init_rcu(&selem->snode);
-	if (rcu_access_pointer(local_storage->cache[smap->cache_idx]) ==
-	    SDATA(selem))
-		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
 
 	hlist_add_head(&selem->free_node, free_selem_list);
 
-	if (rcu_access_pointer(local_storage->smap) == smap)
-		RCU_INIT_POINTER(local_storage->smap, NULL);
-
 	return free_local_storage;
 }
 
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 				   struct bpf_local_storage_elem *selem)
 {
+	struct bpf_local_storage_map *smap;
+
+	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
+	local_storage->mem_charge += smap->elem_size;
+
 	RCU_INIT_POINTER(selem->local_storage, local_storage);
 	hlist_add_head_rcu(&selem->snode, &local_storage->list);
 }
@@ -472,10 +473,10 @@ int bpf_local_storage_alloc(void *owner,
 		goto uncharge;
 	}
 
-	RCU_INIT_POINTER(storage->smap, smap);
 	INIT_HLIST_HEAD(&storage->list);
 	raw_res_spin_lock_init(&storage->lock);
 	storage->owner = owner;
+	storage->mem_charge = sizeof(*storage);
 	storage->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
-- 
2.47.3

