Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1104228314E
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769968269; cv=none; b=oys9VkoYpBg5xArg52+4vWPSwGgfc0iL0WPwjTwBYzGi7RH7CRBrGp2/qKgm7yC20YiOY3fiBrL5AEK4OIhLbJ6rOo9bNQl0Sr+zQca5oD7GRg9C7lCODS45EVFg4PYsbbgG49i5Ucu3raWVy/50AUJkfhf21kdWzrBM1nfK79k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769968269; c=relaxed/simple;
	bh=j9okROgC3d3IWDzv7hV5iNjpBOxFqifQ//DYr9QTOPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0Oofhhh5qOALwo3z7EMMHnhsmVJd/7e88HbwqPOyuLV8juVH7W7GJovL7L6Fb6GhkJbp+p+jt6FWV9T1Cciv494obORPqeNgtCfJeFC8QKHL3Wv9z7bQnSKr6ZvR6EM3L93Aq227VF/cFjeTKELZ5k8HQ1RfwabI8usSxPvXO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JluWyEN1; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JluWyEN1"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c47ee987401so1585602a12.1
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 09:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769968265; x=1770573065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xm7oC+xgIKCvXxrSGiuTDF0Hzayvzv2tP2HFWM+MKaM=;
        b=JluWyEN1OEoU5vHI2PEFxuTHIAdJr0gwK0Whuc+aBMiu8KW01mQXIi+4BvpiZx06SS
         +jgfRFMvaPmh0mB9mMaMZK17DPAfEgXbKz66q0a7Aq6g89oK0Dq2ueP58WkCvwwQkmOP
         LiL+kwGKXWgU2Jc0B8zX+DeiwAeDNVRTHBPVY8toMbHmnPcA1J9UllhgjFXi/jUOc+/m
         +3LIGnXOrnSTOAi42la9P70G/0K885Z1uptBV91dxiczAFuvoA2qxJaGUHvv7+Og+uTv
         LPHandBqu0boMgcL7wOWH0T/JM/PIyA5ruT3iIwhmKuZpVVaatPdjNiTg/lAcqIW5h8F
         q9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769968265; x=1770573065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xm7oC+xgIKCvXxrSGiuTDF0Hzayvzv2tP2HFWM+MKaM=;
        b=bIYeCarRE3bThrytU4IDMECuEHazxqIaVD4QObAAwtf0xSvF/HDAZ1reujJD1iYr+U
         nV4GKR1Z4FyHGI5JpZmyQEPgTDxFO85pBCPyGsniu0Dq0PP6rzzgTW6cOqE046KvWaUy
         ogLu+neerI39LAokTJPZwNY7iS9KuNtCdZ/HFa/fjmvQ4fZKdpzyJAfnIeEHiaD7tA9m
         /ejoa4R4zrcJ905Z08taktByW3SFnKJ14ogE1koe8sBODVQH2Y+3VKu45AL7LWV69hzZ
         BvND8lq7d/NYVVIh4QUa8CceodheWlk5d7c60mN3P8gAQaMjCh1Sh5cgReNnDk07CuZX
         GxAA==
X-Gm-Message-State: AOJu0YxjtWzIOEqUM02VvJ9qwL2XFvz0AUWCP2K1vZMWNVgxybdHCbJ1
	jHvO7UQmobw8qNIvj4hz9nxg3aVZRmeVkwc7hFz7eaUx+is442CpUCVcPOK8FQ==
X-Gm-Gg: AZuq6aKbIZ95PyennCyiXuuFwuWybnd0l9WsnWBRn9ebmiaBxbM2q6skBN7uLVJ37/A
	sQA+7yyFrSWdnAfrDeZNjcvqQoVT8gpl/4kFt2gJ2Gjtkp5qeb1cRXVOF7abS62PHcDKPUqu5Yt
	8B5Ctz/es6TNGzZv9lH5q1w/hXhubueZue8NICSVDTyBDPSh/Nc9Cc7yLvmTPeHtrykrvlrJj5e
	oACEI4LP4NgPlTnbeV3qgn+sZ2Db/UyIrmNoMgLCxgZz8rtqDey/9XkMet8jEzexnv9wEPR/IGD
	ycO/U/sySnNRDAmB0dYhlPf+Qckyk8yPIh9t+71QwV2KlNuu6pq2ngB7ZR2gAgxdmxVLPfyt6fI
	5MD4XeZsgSnyFe/EgWfNcVD8CAMoMpzaePvqNWMJv53wYJa4KqOdiCWPffBAgYmjIVny5O/iTs3
	y3ww==
X-Received: by 2002:a05:6a21:e92:b0:351:cf08:93de with SMTP id adf61e73a8af0-392cc6fa8e3mr11302255637.26.1769968265000;
        Sun, 01 Feb 2026 09:51:05 -0800 (PST)
Received: from localhost ([2a03:2880:ff:47::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a42b3fcsm12739227a12.20.2026.02.01.09.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 09:51:04 -0800 (PST)
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
Subject: [PATCH bpf-next v5 11/16] bpf: Switch to bpf_selem_unlink_nofail in bpf_local_storage_{map_free, destroy}
Date: Sun,  1 Feb 2026 09:50:44 -0800
Message-ID: <20260201175050.468601-12-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260201175050.468601-1-ameryhung@gmail.com>
References: <20260201175050.468601-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Take care of rqspinlock error in bpf_local_storage_{map_free, destroy}()
properly by switching to bpf_selem_unlink_nofail().

Both functions iterate their own RCU-protected list of selems and call
bpf_selem_unlink_nofail(). In map_free(), to prevent infinite loop when
both map_free() and destroy() fail to remove a selem from b->list
(extremely unlikely), switch to hlist_for_each_entry_rcu(). In destroy(),
also switch to hlist_for_each_entry_rcu() since we no longer iterate
local_storage->list under local_storage->lock. In addition, defer it to
workqueue as sleep may not always be possible in destroy().

Since selem, SDATA(selem)->smap and selem->local_storage may be seen by
map_free() and destroy() at the same time, protect them with RCU. This
means passing reuse_now == false to bpf_selem_free() and
bpf_local_storage_free(). The local storage map is already protected as
bpf_local_storage_map_free() waits for an RCU grace period after
iterating b->list and before freeing itself.

bpf_selem_unlink() now becomes dedicated to helpers and syscalls paths
so reuse_now should always be false. Remove it from the argument and
hardcode it.

Co-developed-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  5 +-
 kernel/bpf/bpf_cgrp_storage.c     |  3 +-
 kernel/bpf/bpf_inode_storage.c    |  3 +-
 kernel/bpf/bpf_local_storage.c    | 96 +++++++++++++++++--------------
 kernel/bpf/bpf_task_storage.c     |  3 +-
 net/core/bpf_sk_storage.c         |  9 ++-
 6 files changed, 69 insertions(+), 50 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index cfa301ccc700..0d04f6babb2e 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -101,6 +101,7 @@ struct bpf_local_storage {
 	rqspinlock_t lock;	/* Protect adding/removing from the "list" */
 	u64 selems_size;	/* Total selem size. Protected by "lock" */
 	refcount_t owner_refcnt;
+	struct work_struct work;
 	bool use_kmalloc_nolock;
 };
 
@@ -168,7 +169,7 @@ bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
 	return SDATA(selem);
 }
 
-void bpf_local_storage_destroy(struct bpf_local_storage *local_storage);
+u32 bpf_local_storage_destroy(struct bpf_local_storage *local_storage);
 
 void bpf_local_storage_map_free(struct bpf_map *map,
 				struct bpf_local_storage_cache *cache);
@@ -181,7 +182,7 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 				   struct bpf_local_storage_elem *selem);
 
-int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
+int bpf_selem_unlink(struct bpf_local_storage_elem *selem);
 
 int bpf_selem_link_map(struct bpf_local_storage_map *smap,
 		       struct bpf_local_storage *local_storage,
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 853183eead2c..0bc3ab19c7b4 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -27,6 +27,7 @@ void bpf_cgrp_storage_free(struct cgroup *cgroup)
 	if (!local_storage)
 		goto out;
 
+	RCU_INIT_POINTER(cgroup->bpf_cgrp_storage, NULL);
 	bpf_local_storage_destroy(local_storage);
 out:
 	rcu_read_unlock();
@@ -89,7 +90,7 @@ static int cgroup_storage_delete(struct cgroup *cgroup, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	return bpf_selem_unlink(SELEM(sdata), false);
+	return bpf_selem_unlink(SELEM(sdata));
 }
 
 static long bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 470f4b02c79e..eb607156ba35 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -68,6 +68,7 @@ void bpf_inode_storage_free(struct inode *inode)
 	if (!local_storage)
 		goto out;
 
+	RCU_INIT_POINTER(bsb->storage, NULL);
 	bpf_local_storage_destroy(local_storage);
 out:
 	rcu_read_unlock_migrate();
@@ -110,7 +111,7 @@ static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	return bpf_selem_unlink(SELEM(sdata), false);
+	return bpf_selem_unlink(SELEM(sdata));
 }
 
 static long bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 1846067e6e7e..d02ad9052bd6 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -381,7 +381,11 @@ static void bpf_selem_link_map_nolock(struct bpf_local_storage_map_bucket *b,
 	hlist_add_head_rcu(&selem->map_node, &b->list);
 }
 
-int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
+/*
+ * Unlink an selem from map and local storage with lock held.
+ * This is the common path used by local storages to delete an selem.
+ */
+int bpf_selem_unlink(struct bpf_local_storage_elem *selem)
 {
 	struct bpf_local_storage *local_storage;
 	bool free_local_storage = false;
@@ -415,10 +419,10 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 out:
 	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 
-	bpf_selem_free_list(&selem_free_list, reuse_now);
+	bpf_selem_free_list(&selem_free_list, false);
 
 	if (free_local_storage)
-		bpf_local_storage_free(local_storage, reuse_now);
+		bpf_local_storage_free(local_storage, false);
 
 	return err;
 }
@@ -648,7 +652,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 
 	local_storage = rcu_dereference_check(*owner_storage(smap, owner),
 					      bpf_rcu_lock_held());
-	if (!local_storage || hlist_empty(&local_storage->list)) {
+	if (!local_storage) {
 		/* Very first elem for the owner */
 		err = check_flags(NULL, map_flags);
 		if (err)
@@ -696,17 +700,6 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	if (err)
 		goto free_selem;
 
-	/* Recheck local_storage->list under local_storage->lock */
-	if (unlikely(hlist_empty(&local_storage->list))) {
-		/* A parallel del is happening and local_storage is going
-		 * away.  It has just been checked before, so very
-		 * unlikely.  Return instead of retry to keep things
-		 * simple.
-		 */
-		err = -EAGAIN;
-		goto unlock;
-	}
-
 	old_sdata = bpf_local_storage_lookup(local_storage, smap, false);
 	err = check_flags(old_sdata, map_flags);
 	if (err)
@@ -810,13 +803,16 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 	return 0;
 }
 
-void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
+/*
+ * Deferred looping local_storage->list to workqueue since sleeping may not be
+ * allowed in bpf_local_storage_destroy()
+ */
+static void bpf_local_storage_free_deferred(struct work_struct *work)
 {
+	struct bpf_local_storage *local_storage;
 	struct bpf_local_storage_elem *selem;
-	bool free_storage = false;
-	HLIST_HEAD(free_selem_list);
-	struct hlist_node *n;
-	unsigned long flags;
+
+	local_storage = container_of(work, struct bpf_local_storage, work);
 
 	/* Neither the bpf_prog nor the bpf_map's syscall
 	 * could be modifying the local_storage->list now.
@@ -827,33 +823,44 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 	 * when unlinking elem from the local_storage->list and
 	 * the map's bucket->list.
 	 */
-	raw_res_spin_lock_irqsave(&local_storage->lock, flags);
-	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
-		/* Always unlink from map before unlinking from
-		 * local_storage.
-		 */
-		bpf_selem_unlink_map(selem);
-		/* If local_storage list has only one element, the
-		 * bpf_selem_unlink_storage_nolock() will return true.
-		 * Otherwise, it will return false. The current loop iteration
-		 * intends to remove all local storage. So the last iteration
-		 * of the loop will set the free_cgroup_storage to true.
-		 */
-		free_storage = bpf_selem_unlink_storage_nolock(
-			local_storage, selem, &free_selem_list);
+	rcu_read_lock();
+restart:
+	hlist_for_each_entry_rcu(selem, &local_storage->list, snode) {
+		bpf_selem_unlink_nofail(selem, NULL);
+
+		if (need_resched()) {
+			cond_resched_rcu();
+			goto restart;
+		}
 	}
-	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
+	rcu_read_unlock();
 
-	bpf_selem_free_list(&free_selem_list, true);
+	bpf_local_storage_free(local_storage, false);
+}
+
+/*
+ * Destroy local storage when the owner is going away. Caller must clear owner->storage
+ * and uncharge memory if memory charging is used.
+ *
+ * Since smaps associated with selems may already be gone, mem_uncharge() or
+ * owner_storage() cannot be called in this function. Let the owner (i.e., the caller)
+ * do it instead.
+ */
+u32 bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
+{
+	INIT_WORK(&local_storage->work, bpf_local_storage_free_deferred);
 
-	if (free_storage)
-		bpf_local_storage_free(local_storage, true);
+	queue_work(system_dfl_wq, &local_storage->work);
 
 	if (!refcount_dec_and_test(&local_storage->owner_refcnt)) {
 		while (refcount_read(&local_storage->owner_refcnt))
 			cpu_relax();
 		smp_mb();  /* pair with refcount_dec in bpf_selem_unlink_nofail */
 	}
+
+	local_storage->owner = NULL;
+
+	return sizeof(*local_storage) + local_storage->selems_size;
 }
 
 u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map)
@@ -947,11 +954,14 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 
 		rcu_read_lock();
 		/* No one is adding to b->list now */
-		while ((selem = hlist_entry_safe(
-				rcu_dereference_raw(hlist_first_rcu(&b->list)),
-				struct bpf_local_storage_elem, map_node))) {
-			bpf_selem_unlink(selem, true);
-			cond_resched_rcu();
+restart:
+		hlist_for_each_entry_rcu(selem, &b->list, map_node) {
+			bpf_selem_unlink_nofail(selem, b);
+
+			if (need_resched()) {
+				cond_resched_rcu();
+				goto restart;
+			}
 		}
 		rcu_read_unlock();
 	}
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 4d53aebe6784..ea7ea80d85e7 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -53,6 +53,7 @@ void bpf_task_storage_free(struct task_struct *task)
 	if (!local_storage)
 		goto out;
 
+	RCU_INIT_POINTER(task->bpf_storage, NULL);
 	bpf_local_storage_destroy(local_storage);
 out:
 	rcu_read_unlock();
@@ -134,7 +135,7 @@ static int task_storage_delete(struct task_struct *task, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	return bpf_selem_unlink(SELEM(sdata), false);
+	return bpf_selem_unlink(SELEM(sdata));
 }
 
 static long bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index d2164165a994..a8d277f9604f 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -40,20 +40,25 @@ static int bpf_sk_storage_del(struct sock *sk, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	return bpf_selem_unlink(SELEM(sdata), false);
+	return bpf_selem_unlink(SELEM(sdata));
 }
 
 /* Called by __sk_destruct() & bpf_sk_storage_clone() */
 void bpf_sk_storage_free(struct sock *sk)
 {
 	struct bpf_local_storage *sk_storage;
+	u32 uncharge;
 
 	rcu_read_lock_dont_migrate();
 	sk_storage = rcu_dereference(sk->sk_bpf_storage);
 	if (!sk_storage)
 		goto out;
 
-	bpf_local_storage_destroy(sk_storage);
+	RCU_INIT_POINTER(sk->sk_bpf_storage, NULL);
+
+	uncharge = bpf_local_storage_destroy(sk_storage);
+	if (uncharge)
+		atomic_sub(uncharge, &sk->sk_omem_alloc);
 out:
 	rcu_read_unlock_migrate();
 }
-- 
2.47.3

