Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C8435B640
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 07:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274935; cv=none; b=g6BqBKqfWG42ZDooDhLujbJSMZGDMTVJ1z5ng8LAkLZCtx/Ni1ZfIvyG2NXQG4udl507HQxq/Z7RUai+Ag4FJuGDxE9x+Le/7MedX4EPZya1wyIFC6+5qwe+ULX83TxvI7ymIVm1NVO3V9RjEeViB1rBQp6d0VZXfmKxP5Of6hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274935; c=relaxed/simple;
	bh=GrLV5gijxoE7NSW6SK7VgXZ5qFlInWugStQsPetpfKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qyq0klTlVsAqu/LMSh+R6qClmjoE1b/0yrWG74alifKTqI50Rf+BlrK4IOmbaQEP2jbO6phVpT6Omc7Ay0OR1xtWeIEDAGpBsIFgx8kjHt9pD+s+5oHifLKjA44Ma+aUfHvPE9JsEBRjYVXyLf+0ZfoTYHTsZjswKeWKsetI9jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIhkbrL3; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIhkbrL3"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-823081bb15fso371343b3a.3
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 23:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274935; x=1770879735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wyGHQfdqlOcSTajpA9fKceqwUXV3jdUWCFJw8oPo2A=;
        b=fIhkbrL3Jlrzkzo24mcwFs1OgalwdX6mVngUK3u70E8kRBSKu2UOZd55VRx5sxKQiC
         aF+sC62ltb1Vx8yV1BamkZbl/wS/GM3xC+YlnDkhs4mFEdcZ5sHG0DlhStsIfOEojANp
         fjiuGNddLY4TTJEpncbJh4TQJk+4/c68IKbdcaIOjWAJa0dXyVvWigkOCC6kTDZpT4rn
         AnMf19hynijYsqCIdFfeMw6Uch7DGzLsGJilTaNzwbr1ttOA4c6MOiph121pvXjv2evw
         gHDm5MiHaQVWIgooJVuLkWRyfGEu5GN5BXTRCiEXSbpO0/DJHd6VenFvYrK9Xv8c56uQ
         N9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274935; x=1770879735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+wyGHQfdqlOcSTajpA9fKceqwUXV3jdUWCFJw8oPo2A=;
        b=E+2dqZdORrJIBKkpRhdDn6MXyc8/nmLnJ3rtQ6YcFIp7slloJUnCCEo7fSE9ioAeLV
         PQzFeP3HK/0n7jvak2XNKRmVwUU+WsAc42wYjmMdeP/OxzipwwG6Bv34YgjG7IzJIJkx
         G1W823mAypnFEgQPDjWlI8lLDxVeWmtJFDA81XlKxfKnSj3C7+uiGztvCPFbbGOcO77Z
         Zd+J0HizYWMYAgncoJj2H1/ojIeke6GjL5pzVh3ngWYqon42+yT9nT6uPdKmED4b8DuG
         Y8lybMxtR/S5GmOHLNNFykl195FZsnxAybvHd7M2yjUKTeu+Z0yr+I8V1sb2Fu8tptK9
         Of6A==
X-Gm-Message-State: AOJu0Yz6ijX9KKIWfCG6rr7GDf6BFR4bBFlHBgPNOVbPmGI2v2K7LNWT
	hHYPQhgfPFaGK6ama/Ey2WkH4gmqMOZ5+fTICl/aof4l/zt4KAYY8UsORCWdqA==
X-Gm-Gg: AZuq6aJBb0rwun5p0OlB7srscVfEysX8WA/zbgL+y8G+Q7ksTfAd6EuqGqp9Lr8MQ4C
	dbtTFfmg7lWi+efo1hZ7b4qJj9mkkwmxHe7iu5BNgsEhOnMw6m369BcoHvoMKY4CZx7vR8K1iI2
	TmQuX5/Sb3tcDVp1ezg1pwsfL3gugVwDskqVUaPddm1ymFFYH8KWaCBsTNo05hPIb3FmuskFCu6
	YA7ar51g/P6RoPLODlU92z++py0RnF9mIPS0av5E404NhpYeKFqvhHzJmw9Q3pNzU1+r2h55KWh
	xpqo+Ir3vLrFdXgFuo09yWPwSROdxd3yAqfyoRvVZ7VCN0Mqr0R5U9CozG5df0gpO7Qi143ocfy
	dS9e4yIRa0mKnueBL1cWWnJDr7iUPRJEMUYmr+z36EfwK8S8plnDedap+NM+4MitFLrew+x68Sg
	URtQ==
X-Received: by 2002:a05:6a00:1a8f:b0:81f:b97:14a with SMTP id d2e1a72fcca58-8241c695d07mr5381155b3a.61.1770274934666;
        Wed, 04 Feb 2026 23:02:14 -0800 (PST)
Received: from localhost ([2a03:2880:ff:57::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d4af6e4sm4669777b3a.66.2026.02.04.23.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:14 -0800 (PST)
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
Subject: [PATCH bpf-next v6 04/17] bpf: Convert bpf_selem_unlink to failable
Date: Wed,  4 Feb 2026 23:01:53 -0800
Message-ID: <20260205070208.186382-5-ameryhung@gmail.com>
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

To prepare changing both bpf_local_storage_map_bucket::lock and
bpf_local_storage::lock to rqspinlock, convert bpf_selem_unlink() to
failable. It still always succeeds and returns 0 until the change
happens. No functional change.

Open code bpf_selem_unlink_storage() in the only caller,
bpf_selem_unlink(), since unlink_map and unlink_storage must be done
together after all the necessary locks are acquired.

For bpf_local_storage_map_free(), ignore the return from
bpf_selem_unlink() for now. A later patch will allow it to unlink selems
even when failing to acquire locks.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  2 +-
 kernel/bpf/bpf_cgrp_storage.c     |  3 +-
 kernel/bpf/bpf_inode_storage.c    |  4 +-
 kernel/bpf/bpf_local_storage.c    | 71 +++++++++++++++----------------
 kernel/bpf/bpf_task_storage.c     |  4 +-
 net/core/bpf_sk_storage.c         |  4 +-
 6 files changed, 39 insertions(+), 49 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 709506e982a6..f74e0f7656a1 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -176,7 +176,7 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 				   struct bpf_local_storage_elem *selem);
 
-void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
+int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
 
 int bpf_selem_link_map(struct bpf_local_storage_map *smap,
 		       struct bpf_local_storage *local_storage,
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 0687a760974a..8fef24fcac68 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -118,8 +118,7 @@ static int cgroup_storage_delete(struct cgroup *cgroup, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	bpf_selem_unlink(SELEM(sdata), false);
-	return 0;
+	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
 static long bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index e54cce2b9175..cedc99184dad 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -110,9 +110,7 @@ static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	bpf_selem_unlink(SELEM(sdata), false);
-
-	return 0;
+	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
 static long bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index bcf7e7f42d18..5dcdf8e523b4 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -308,33 +308,6 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 	return free_local_storage;
 }
 
-static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
-				     bool reuse_now)
-{
-	struct bpf_local_storage *local_storage;
-	bool free_local_storage = false;
-	HLIST_HEAD(selem_free_list);
-	unsigned long flags;
-
-	if (unlikely(!selem_linked_to_storage_lockless(selem)))
-		/* selem has already been unlinked from sk */
-		return;
-
-	local_storage = rcu_dereference_check(selem->local_storage,
-					      bpf_rcu_lock_held());
-
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
-	if (likely(selem_linked_to_storage(selem)))
-		free_local_storage = bpf_selem_unlink_storage_nolock(
-			local_storage, selem, &selem_free_list);
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
-
-	bpf_selem_free_list(&selem_free_list, reuse_now);
-
-	if (free_local_storage)
-		bpf_local_storage_free(local_storage, reuse_now);
-}
-
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 				   struct bpf_local_storage_elem *selem)
 {
@@ -387,19 +360,43 @@ static void bpf_selem_link_map_nolock(struct bpf_local_storage_map_bucket *b,
 	hlist_add_head_rcu(&selem->map_node, &b->list);
 }
 
-void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
+int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 {
-	int err;
+	struct bpf_local_storage *local_storage;
+	bool free_local_storage = false;
+	HLIST_HEAD(selem_free_list);
+	unsigned long flags;
+	int err = 0;
 
-	/* Always unlink from map before unlinking from local_storage
-	 * because selem will be freed after successfully unlinked from
-	 * the local_storage.
-	 */
-	err = bpf_selem_unlink_map(selem);
-	if (err)
-		return;
+	if (unlikely(!selem_linked_to_storage_lockless(selem)))
+		/* selem has already been unlinked from sk */
+		return 0;
+
+	local_storage = rcu_dereference_check(selem->local_storage,
+					      bpf_rcu_lock_held());
+
+	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	if (likely(selem_linked_to_storage(selem))) {
+		/* Always unlink from map before unlinking from local_storage
+		 * because selem will be freed after successfully unlinked from
+		 * the local_storage.
+		 */
+		err = bpf_selem_unlink_map(selem);
+		if (err)
+			goto out;
+
+		free_local_storage = bpf_selem_unlink_storage_nolock(
+			local_storage, selem, &selem_free_list);
+	}
+out:
+	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 
-	bpf_selem_unlink_storage(selem, reuse_now);
+	bpf_selem_free_list(&selem_free_list, reuse_now);
+
+	if (free_local_storage)
+		bpf_local_storage_free(local_storage, reuse_now);
+
+	return err;
 }
 
 void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index a1dc1bf0848a..ab902364ac23 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -167,9 +167,7 @@ static int task_storage_delete(struct task_struct *task, struct bpf_map *map,
 	if (!nobusy)
 		return -EBUSY;
 
-	bpf_selem_unlink(SELEM(sdata), false);
-
-	return 0;
+	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
 static long bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 0b85d8f2c17e..d7b5c4551997 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -40,9 +40,7 @@ static int bpf_sk_storage_del(struct sock *sk, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	bpf_selem_unlink(SELEM(sdata), false);
-
-	return 0;
+	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
 /* Called by __sk_destruct() & bpf_sk_storage_clone() */
-- 
2.47.3

