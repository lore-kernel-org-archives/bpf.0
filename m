Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0218935D5E8
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 07:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274943; cv=none; b=DkarTuY6wxMFXRrjPieXH4OSITjP2j8OG94oBM9JJhKVqjdKIy4W+mEFddr17U5BTvnvnpUqO2O8EUlUyKfkwYTxRd9rPOQ/9LPFR+F4WsEkp+hbR3D4MG5noohwbicZL0XtXL/lbsf3CwYE+oAMwC4Mx+JZ2TdfPWsIFO1cinI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274943; c=relaxed/simple;
	bh=4yZRyFVuJG0BwoZpNz8+AAzv0IV/FMzsjX/D+OyZmAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEAB8G3yw44zHg5p/QcmyeLbtinaFQO3GKHTSkv28VpS+igGxQAnH3adkmR02i4KPsJ9Y5HsOGcFMTYkv+rbFUA/KEsC6tIbS5LXtOE1JTZ4Et/CIzO1WAu4yo3jaIZoeT7bKnw009QNmopDgzBrTb02Yqx3zNjxc4W5Nrnpl/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFFbKmgT; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFFbKmgT"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c227206e6dcso346514a12.2
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 23:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274942; x=1770879742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgT4J4/PbVALNFDOICgtccVAy98DXPpqaI+XGoMOIE0=;
        b=nFFbKmgTLYfQv8ffrKnirF1RvtkVivViXBdv2tzyRojN74BjXd2LmIq1YMEOJwx5Gy
         Au+h2fXoPIQVh6QmUWlllZEAAY1Vzf7LM7U+J/Ssk927vSUc4BEYTs5UQdIRo/lI9ff8
         kJoWgplEjt1/k3RioT0k/6NXIIeRV8ESMo6avDw6dTe47IIiOAqMMhZz5rH6yiV66ThM
         yPSAY68RFryDF23+5M+ZB1/iJ1hstV7owiSh1d32wBTSp2ojXDEoSV33iqQY27BPI/0u
         YCgrf3t9cye77Jkyn3hZN4LWRfmSW+5ITF5Q6MfNhi3Z5GuPadPE2+MHZ8hZ4N2XG0GH
         mW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274942; x=1770879742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RgT4J4/PbVALNFDOICgtccVAy98DXPpqaI+XGoMOIE0=;
        b=YPdCpiiXFQ35dAErZeSk5ELsQ3I3kuCcNMKJNb/2fTSL7NAUMsSAzcbvqHdZMgOAe5
         77uclXnjEh1BdQ5Dsx1UC/isoUQzeshKQTVKgavwH8ELy0Iqe2qIK07nktINPsGsJ+yv
         LnZHlSOjaaL+c2Xm5IHoIx9rbgxcMFW3rVr1lEA7nJyruhJfjO3rr0VuSTnP12EFMCCI
         QH8tnZk6XCGp0MHE3v18HvNPWQsUcz/X7pIOHx8LrXXqmz9BvKS3K7cO+umN6VWvuj3U
         epzbSAgEC8zKnzpzt0mocaEYphwuM6/Cks3pUDHncBGGS756wk++JAPYuTk26k9rdMgN
         rWUA==
X-Gm-Message-State: AOJu0YxUsC3ay9JwYhvhLLAdBrk/kfm/NyLNmJwDRKRoC/hPIFdDJhX/
	b0F7YqLG/b4F4n93sP06rucAKYh/tzv63OJkh96b2TUv2C2bpFnFWbkkFUfL5w==
X-Gm-Gg: AZuq6aL7654zs0knnzsyiYkFS84PHfb4M3VHBsZIeXXhhZ/tPFupRkytvbuDODB7fUY
	EdJ/QxMi/CDFncpJuPmowZPfqSNC8AStuP3fQlF5/VlOBVJhptfKjAkG/YZ/Fqpi6DckkOhlL6d
	8FDJ9P1t7jF0QgF3lspdv/zXUlQOZ+2+M0P88pBUB7kEwp97WFc+yksKiKtZWITwJtU42tbS2qX
	5u+5xapi2kDIE9KbROtvNZskq3m7y/TCrO+rjkAkWwRaVpW2kkRd75/jC56OMLLZ5NV3VknNNhk
	N6cAdw13UvNbmi2CgnYxzo1YUbt8YxAKLwjDxBCAV3NF32rdXJPM7frcw50AypUDy+smDAuLZVL
	F19aPidn0sSX5vn9xUm4Z66pqxL0ci9UT9lW30w1slqwOv69FpOhPwaCTpzHlGerZf4WquNRxt7
	W2zw==
X-Received: by 2002:a17:903:11d0:b0:298:2afa:796d with SMTP id d9443c01a7336-2a9341122a1mr58678775ad.61.1770274942057;
        Wed, 04 Feb 2026 23:02:22 -0800 (PST)
Received: from localhost ([2a03:2880:ff:20::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933a252f6sm37438725ad.75.2026.02.04.23.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:21 -0800 (PST)
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
Subject: [PATCH bpf-next v6 11/17] bpf: Switch to bpf_selem_unlink_nofail in bpf_local_storage_{map_free, destroy}
Date: Wed,  4 Feb 2026 23:02:00 -0800
Message-ID: <20260205070208.186382-12-ameryhung@gmail.com>
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

Take care of rqspinlock error in bpf_local_storage_{map_free, destroy}()
properly by switching to bpf_selem_unlink_nofail().

Both functions iterate their own RCU-protected list of selems and call
bpf_selem_unlink_nofail(). In map_free(), to prevent infinite loop when
both map_free() and destroy() fail to remove a selem from b->list
(extremely unlikely), switch to hlist_for_each_entry_rcu(). In destroy(),
also switch to hlist_for_each_entry_rcu() since we no longer iterate
local_storage->list under local_storage->lock.

bpf_selem_unlink() now becomes dedicated to helpers and syscalls paths
so reuse_now should always be false. Remove it from the argument and
hardcode it.

Co-developed-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  4 +-
 kernel/bpf/bpf_cgrp_storage.c     |  2 +-
 kernel/bpf/bpf_inode_storage.c    |  2 +-
 kernel/bpf/bpf_local_storage.c    | 63 ++++++++++++++-----------------
 kernel/bpf/bpf_task_storage.c     |  2 +-
 net/core/bpf_sk_storage.c         |  7 +++-
 6 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 69a5d8aa765d..85efa9772530 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -171,7 +171,7 @@ bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
 	return SDATA(selem);
 }
 
-void bpf_local_storage_destroy(struct bpf_local_storage *local_storage);
+u32 bpf_local_storage_destroy(struct bpf_local_storage *local_storage);
 
 void bpf_local_storage_map_free(struct bpf_map *map,
 				struct bpf_local_storage_cache *cache);
@@ -184,7 +184,7 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 				   struct bpf_local_storage_elem *selem);
 
-int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
+int bpf_selem_unlink(struct bpf_local_storage_elem *selem);
 
 int bpf_selem_link_map(struct bpf_local_storage_map *smap,
 		       struct bpf_local_storage *local_storage,
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 853183eead2c..c2a2ead1f466 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -89,7 +89,7 @@ static int cgroup_storage_delete(struct cgroup *cgroup, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	return bpf_selem_unlink(SELEM(sdata), false);
+	return bpf_selem_unlink(SELEM(sdata));
 }
 
 static long bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 470f4b02c79e..e86734609f3d 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -110,7 +110,7 @@ static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	return bpf_selem_unlink(SELEM(sdata), false);
+	return bpf_selem_unlink(SELEM(sdata));
 }
 
 static long bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 4bd0b5552c33..899641fcc562 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -380,7 +380,11 @@ static void bpf_selem_link_map_nolock(struct bpf_local_storage_map_bucket *b,
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
@@ -414,10 +418,10 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 out:
 	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 
-	bpf_selem_free_list(&selem_free_list, reuse_now);
+	bpf_selem_free_list(&selem_free_list, false);
 
 	if (free_local_storage)
-		bpf_local_storage_free(local_storage, reuse_now);
+		bpf_local_storage_free(local_storage, false);
 
 	return err;
 }
@@ -807,13 +811,13 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 	return 0;
 }
 
-void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
+/*
+ * Destroy local storage when the owner is going away. Caller must uncharge memory
+ * if memory charging is used.
+ */
+u32 bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 {
 	struct bpf_local_storage_elem *selem;
-	bool free_storage = false;
-	HLIST_HEAD(free_selem_list);
-	struct hlist_node *n;
-	unsigned long flags;
 
 	/* Neither the bpf_prog nor the bpf_map's syscall
 	 * could be modifying the local_storage->list now.
@@ -824,32 +828,20 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
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
-	}
-	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
-
-	bpf_selem_free_list(&free_selem_list, true);
-
-	if (free_storage)
-		bpf_local_storage_free(local_storage, true);
+	hlist_for_each_entry_rcu(selem, &local_storage->list, snode)
+		bpf_selem_unlink_nofail(selem, NULL);
 
 	if (!refcount_dec_and_test(&local_storage->owner_refcnt)) {
 		while (refcount_read(&local_storage->owner_refcnt))
 			cpu_relax();
+		/*
+		 * Paired with refcount_dec() in bpf_selem_unlink_nofail()
+		 * to make sure destroy() sees the correct local_storage->mem_charge.
+		 */
+		smp_mb();
 	}
+
+	return local_storage->mem_charge;
 }
 
 u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map)
@@ -943,11 +935,14 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 
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
index 4d53aebe6784..605506792b5b 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -134,7 +134,7 @@ static int task_storage_delete(struct task_struct *task, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	return bpf_selem_unlink(SELEM(sdata), false);
+	return bpf_selem_unlink(SELEM(sdata));
 }
 
 static long bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index d2164165a994..1eb3e060994e 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -40,20 +40,23 @@ static int bpf_sk_storage_del(struct sock *sk, struct bpf_map *map)
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
+	uncharge = bpf_local_storage_destroy(sk_storage);
+	if (uncharge)
+		atomic_sub(uncharge, &sk->sk_omem_alloc);
 out:
 	rcu_read_unlock_migrate();
 }
-- 
2.47.3

