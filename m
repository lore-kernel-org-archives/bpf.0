Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44ED33970F
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330568; cv=none; b=NMrCW29J1EgKojcrEPHdRLcy9uoNBfiujQLJN39/dQ5Z+xqm7FlQ8fTiRl3jQRVxbw4y9PjGPZK9OdSF4fgzUXWiQkuURhrZuzsVAmPS2CDNCiHfkxdSX2LhNebBIJVRIw6UmrScTxgC/xUmjXD7royK3nJFasSE0m1yEMGZqA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330568; c=relaxed/simple;
	bh=7yR9+YHp1RkNT1a7BlXW5HCa9dPz59Ra9Z4hFpWq00E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5bXlB5+J7VHMaub2LTuqSIg1AS/qncdM2YwwRSVPIYtS7TcE6hZ3fmzWg1YxvoGyNtbqpVfZJpIdy/59wmJG9HDN4Q6nzJbDyeMUd4VdtRa1pLpIsdUI0QK7LXsrYHY8Dw0COaQ2Id1PfTrOKw2qhzzdUJwqhzphiAMoT0qp/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFvjQoxu; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFvjQoxu"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82318702afbso98188b3a.1
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 14:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330568; x=1770935368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTz6jdn9HQWwkM1E/PJ2ctwZr1RsErnR1/qAIfEoEwg=;
        b=KFvjQoxuHRo7Y0vV240Y3/QHHJ72M7g9eHfzQ+l2SOs7SSiOySVGcHJ8zDwQQvmyFY
         c3NTbmFTk81ntj0u5VIEziNdHP40heT7N7eXLEl//vm0BRFH9tZ/MMBng2nuQoE/41/F
         Yn/Rr6i9Lg9BJ/UBslAZbK+j4Zcoq3NTUI7gimqJ4DuB066c00WXAy9BFUd5WcLPS1Hh
         TJRMI8K6JiIhRw/n6ppSOOhwKrwnmoSI9dO1SZu+p0WO03gj8mv6t8902jL+MYJfMPoe
         o8Ex9KgZRF58g6PWZsvOAn4zIsno/hEGT6ioc2+Q7O+GWsJhHxx1gb3Jzs4LV1r/EaYh
         uBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330568; x=1770935368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JTz6jdn9HQWwkM1E/PJ2ctwZr1RsErnR1/qAIfEoEwg=;
        b=TKM8NqzXPKxrqaDDNFmBRKb7FYBMRZxKEL7WwRmAukSZM7Idi0tPX+c3I8g3AL4qhq
         tgCiIbkC9Wz+hOpOHuC31Y+uMMSN82HlF7/Kck0OTcX6Nemfa7K/9TRjoF/sbaBOp6DS
         bbBeAzrMRHdoZJRGYKDSI/ReWfg7ZUT5djG/VjmHFhkAUSBxS4iImikBToVg5FEEg3Uy
         KfmEiRGCpWHC47TRwyqeBuGJ2NfpduslFTthnb/5D7pz4OL8p8Go2IWgft3idMQt3wts
         zhouVwKXiS8AD2O+iDZhFWb7LFVhqLNIlUWqWWfQdZhOTiVDHeqZLHGip6142/0F4VOn
         iGkA==
X-Gm-Message-State: AOJu0Yx9Vo3fqistyW1ECsWWhWafsPm35Y1lV/cEgA+2Nn8O2dLukChE
	BYpYEUFAOprcgdov6oDQEYEysgdezkOiSYquQxQbk5RRtZ6CrBfRVGdrJdKSSQ==
X-Gm-Gg: AZuq6aJ2TKjebux2Memld4Lw5YfnQjKRow8Btmrc6Vz57vrogS1sFAhiR32KnbKuDPy
	AjM4KRyItp1LrOFYrGRirQvIstxjOux8Q4XeG1x62glyp7I/xT/xnltfP2bpYra99UR60NLOugX
	IGrkXkMbeHHEIhJF3L0uEtL/Nj+ff4HNBjjFIaL8dUokKhyZE8/NOoBlLJR7rHZPtCzl5meLMY4
	omhqXT/JqfwYrXZLtgev+0afL30HYJRYX0Fh4SDwNrfxyGPtkyr6wJGKNGSokyRqEH0eyEhlyRx
	p3PJVeSa9f7nSfmvUkftaIw0vkN7g5GsEqPVGybHbuHb4zG4Yq3IM/MqB1y/KmZsHo7XMrNkg/H
	SlpR8F0sIguDV98K+6AfAcqvFJpryO3+FLAP7IbNfNU6mye4dFnlsd8GMJsTZTsRPAXHTXXh5LM
	Sj9Q==
X-Received: by 2002:a05:6a00:a22a:b0:81f:b3d1:2d17 with SMTP id d2e1a72fcca58-824416f79d4mr495219b3a.35.1770330567959;
        Thu, 05 Feb 2026 14:29:27 -0800 (PST)
Received: from localhost ([2a03:2880:ff:50::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418812d2sm314869b3a.43.2026.02.05.14.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:29:27 -0800 (PST)
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
Subject: [PATCH bpf-next v7 09/17] bpf: Prepare for bpf_selem_unlink_nofail()
Date: Thu,  5 Feb 2026 14:29:07 -0800
Message-ID: <20260205222916.1788211-10-ameryhung@gmail.com>
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
 kernel/bpf/bpf_local_storage.c    | 69 +++++++++++++++----------------
 2 files changed, 37 insertions(+), 37 deletions(-)

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
index 76e812a40380..0e9ae41a9759 100644
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
@@ -261,56 +286,30 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 {
 	struct bpf_local_storage_map *smap;
 	bool free_local_storage;
-	void *owner;
 
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
-	owner = local_storage->owner;
-
-	/* All uncharging on the owner must be done first.
-	 * The owner may be freed once the last selem is unlinked
-	 * from local_storage.
-	 */
-	mem_uncharge(smap, owner, smap->elem_size);
 
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
@@ -471,10 +470,10 @@ int bpf_local_storage_alloc(void *owner,
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

