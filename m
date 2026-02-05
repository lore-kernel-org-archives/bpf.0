Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AAE3376A9
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 22:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330571; cv=none; b=JmRKR2FcHvJixt+mjnYIEDcS1RcjZYjpCUheUhcUmoA47LD+fAmRw9xuJThx2vY0SRtdPXDPpaQ6GkuNS1/b1BwZ4YgmMbOw0GY0PSR1O6BAVdv/UqqQoZKVHQKNF31DdmATP5m6tJGi3mmuRzv6D27DyxqI7KOBNyJ2y3nZhAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330571; c=relaxed/simple;
	bh=QWbfXmr6Jl6GvHE0PDI7xF+SucHg8msYWO9Bdo+OzIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBaZRgi5waSWplIRQC8tj2EBrtLPAn1uP5GSeqBZ/sDrzUACUVoYFvDUPzKaxPAlxnyW775Wy3cBDmJ4OUD25xV+VwMW4hlQcWB1nhZY2QrkjoG7fZs8JGqcpWaCAUjRxX47AD0l/e9wTP6aSmC344LDbWrUykrsW4BiYfgGP5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8ahzySF; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8ahzySF"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81e8b1bdf0cso1201407b3a.3
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 14:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330570; x=1770935370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4LZ/nNnOFdE3LMXnnhVYkfbVdRAisVzrr0tkBS6uJk=;
        b=C8ahzySF+dVzdUBUttSReUADWLmbxBj0IqF2BqTqv0YtVLm2KmU/2J1RN4bQNHsgX+
         Hg1wXtTGhjT9f2vl6y33TJ1CrKPCWnSbBnbNH7LfTKa8gE+bUAQX5g0MkYbiGDRmL0qR
         GZnEJK0d0MlCG1rp2dgqFdL/jRuv77Kz8NHz+JUpGyU4JUKJKyRidlmA4aB3rVheYqv8
         oGMfB12jkZ/tIE+0WfpnnMa2vspY5Skq4NIO5DBDuxwQudWP7ZLRK3Xo8WWwbQyV9KGh
         RxTsaXpD9w1LrXO2DEkqG3gwIDq+1IOxgNCAQE6/qz3qA32755DL/vWIl4Dyue6gazQH
         CbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330570; x=1770935370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+4LZ/nNnOFdE3LMXnnhVYkfbVdRAisVzrr0tkBS6uJk=;
        b=tNJAWFLM54PIORko3VEERAFZulBx1fV5/aaOb6VeOLV7MBcuRMgx+ATejkvkMRlh9b
         NUz6uJgntNHGI2AiVivXmke4NYZK7rBt//24qY6ua8C3eG6j1V3JvrAKjxqsZmxERwGQ
         v2g3SD17lS8VjwVpoRCP1q+rufa4n4XHTFBH7jsM/Ac0xULogePT7lZYkCqrJT/0XX4N
         mtCRxJCY40O9cJMSjev/AiO1PAGahAnLKbZHD59Du2HrmIQI3/HvsMLHxhnAZ7KsIxHW
         nFbaAxhw2QEA7WLv4Qvpvv2ejM8geXipwHLWJQTE7RISs6qJAJibhrpblvNnohljiiaU
         gAog==
X-Gm-Message-State: AOJu0Yyj9ND1xLZ4V6j1fAv0stKkOY5zt2jO9YyHrMG8nQpH1ib0ObxK
	yin+8ChDJOJqEhFdnXCgA4G9ayw79E5+NJ3EYNtU4neIJV7wc5EWbJHAscBH0A==
X-Gm-Gg: AZuq6aJOjrGXgTr8nbWk3sgEf+XUmxjcq5iEJsLP9zRdqDhn66ogt5HIJXCtEGwPY/k
	Q4nOJ+MbYLHgZ0rETiDToNqTZNZ9C48Xh9T/1wsZ86bHCnWPsiY5UXFiAwcdP5wFArkwrH37Woz
	PTe/O699Nx1o7QMOlrT2Y88xJlfprOL16+TlXSPIKmTKT+I22IEWUM3dp/wUWyCFvvP8Sc8FgIJ
	M23kpu+svcT4RtQAaiHbN/Oe6X0xrTUZ7JhkFaosubxrLsuomxc1N+sDurntNWsN86annmYLcCk
	I4nNfAZtnzeiXrqcQlt2CacWy094F7JoxaJzYZsy7TlleSP05rAUIsjFzuFW/vhObo0olVXEEMT
	FUeAIJE/7+YbsyOsj98L77pyhrLHoZUkru74gboUkX4JTuc0GeMjYygGAIiK8oUebVhp6yDzDGM
	TKDkOMlor+SYN2
X-Received: by 2002:a05:6a20:d52e:b0:38e:9d3b:470c with SMTP id adf61e73a8af0-393ad33a9e5mr742941637.42.1770330570118;
        Thu, 05 Feb 2026 14:29:30 -0800 (PST)
Received: from localhost ([2a03:2880:ff:23::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb627a23sm410159a12.29.2026.02.05.14.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:29:29 -0800 (PST)
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
Subject: [PATCH bpf-next v7 11/17] bpf: Switch to bpf_selem_unlink_nofail in bpf_local_storage_{map_free, destroy}
Date: Thu,  5 Feb 2026 14:29:09 -0800
Message-ID: <20260205222916.1788211-12-ameryhung@gmail.com>
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
index 294605c78271..b28f07d3a0db 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -377,7 +377,11 @@ static void bpf_selem_link_map_nolock(struct bpf_local_storage_map_bucket *b,
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
@@ -411,10 +415,10 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 out:
 	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 
-	bpf_selem_free_list(&selem_free_list, reuse_now);
+	bpf_selem_free_list(&selem_free_list, false);
 
 	if (free_local_storage)
-		bpf_local_storage_free(local_storage, reuse_now);
+		bpf_local_storage_free(local_storage, false);
 
 	return err;
 }
@@ -804,13 +808,13 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
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
@@ -821,32 +825,20 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
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
@@ -940,11 +932,14 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 
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

