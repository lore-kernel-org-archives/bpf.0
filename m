Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E1033066E
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 05:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836168; cv=none; b=ZDeMdKASX+n64zGAcYh2b4oq0tdbrFq+B98Kmic+IxUXmwjbcZmFGAM4XDESbrzgGdb0OENXk9Xpqz6Eu4Trjt0kDHoUKd7Xj6Nl30Mv3Q9PG3HuDFRu72yDvppjWRITjjGDK91ZmU3p4eNntZzUN9PeY9S/LDPdi0U2ht3cbes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836168; c=relaxed/simple;
	bh=ZZ83GhZsOop6I5Cstj6vurMVVgLh1GU7oDlqaegHFp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaVSe+tcLFUT6HYXTHrVGxK7MYwgLIDY2nkhKdiJK26cS4LCbFX0VsaQtoTh+3vS9+DzdPHunXaQYF1ocryQVPMBJHaXHydW063ENSbrgA3veb6fbEmmxFXK7Aod6ovJlyechZdz7whwadL0vekEoQCBeKpBgMibLH9IAqekBIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcWtx09X; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcWtx09X"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0834769f0so18598685ad.2
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 21:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769836166; x=1770440966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFEgS9FcO38B+wcnpk2Av0d1YmvDJw80lbOmqJ4hYjA=;
        b=AcWtx09XY5g6CCHS9NFruDaWX6Va7BFy52dAISAH+o1fqLRffMqBnS86w42oGlRtRT
         SpT4u68hwqcISpObPX5aM/0b7m7KowkS9MhhKacIwygA6a+UBpJ74uFU3qmRgwWBsSCO
         xDrl4TbtSGlaIl31FSLPYRFQEkrfCs6lQjSxANRQ0vEkPA72o0cPtnQcWTqL96psi00/
         G/ZXTaO8FzsnWjjzyrRpckBJrNOtNaD9vIiETvbdgossmZom4u3a7ae6fu8AtaHBVel6
         6q4pruQNU6DzBb9uhQ/kKkXa+dEJHCaIirEBh3EzjJqnXszcLw4/naWrLlqjmPnZmOSx
         v3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769836166; x=1770440966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YFEgS9FcO38B+wcnpk2Av0d1YmvDJw80lbOmqJ4hYjA=;
        b=auCpyKwHhJA2Vlmkw2x4wV3LY+Q9qnp7kgtbisFAIW85GOfGefy7L7wJ1ndMR1Do5N
         XT9OcT/1n+uVU0QnIeyQPw53EhcFnyeMsx3XJC0cUzGq5sGrvgS2MDAfhx0P8cT/7Ubo
         KW9wBZpvc/WHvzTi4XDvB8EiJFak8p3G2JwzPE27TKR1FCV3qwT0sxzCDU6Dkq64f0RG
         18qfMYYm2wzDFltYs5H+ZEa1R3RIb9+AP3nqLdxhq2YDDs3/s8vgIqmH6sDp7Arljx+4
         BU5n0ue51nDQ7Z2d+pyOlOvjxQBpAqN8ODLx9NjsK9RzrUlIeNfgSPfd6rnb+Vtmbam9
         uT/Q==
X-Gm-Message-State: AOJu0Yw4c6dyUsPRLNaI6CDej748Le6F0CHl0iwEgMFf130ZVXNXqd+Y
	YYOgD/xccgsZPz8aAMkO9OAOLNictZTzXVAJdv6cCIPepGULV3SqH7yg/4BiQA==
X-Gm-Gg: AZuq6aLmWRI8glUBCm8AtZpWWkpfyNe3uxPr+7VocUv5gYnKf4R54+JBCR1UVcyHgOk
	PfOG/z3nDVzJAg/zrHLh3uYs2hnZ8oyW5+J7nAZQblU1gykQaUjwgx4rYRuxyl2YYy98Rzj5I6m
	5HODj/J0N1kVMatNDhXSPCqXWNeoQEcJVB/QTu7HYQsFwNAy1sTW+JjBx7L0RNGWIWZxoMXDJOh
	9VtXoeVYQcj3qY7Dh8VIxYwk+u46D6roDUSLWukVZABDTa1Hz0rhw+k6Uc4iwDWohXyq0if6Nhi
	q8JKIKOq2uvzOYSeKu/RLBG9UCK6Y+vwul4+hF6AQvrgs2rVupehYQkFTnaPthKjzM2GeldK596
	3D7Jp2y5uEtiTHyP1WezM+4X5s4dZi1piSZm6fkiGcYX0XO7ELlm7ML+o5ddqBWzZvzRRupPA8p
	BTLg==
X-Received: by 2002:a17:903:1211:b0:2a8:7814:47ce with SMTP id d9443c01a7336-2a8d96a7ffemr56151555ad.23.1769836166242;
        Fri, 30 Jan 2026 21:09:26 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4153e4sm92234715ad.39.2026.01.30.21.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 21:09:25 -0800 (PST)
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
Subject: [PATCH bpf-next v4 04/16] bpf: Convert bpf_selem_unlink to failable
Date: Fri, 30 Jan 2026 21:09:07 -0800
Message-ID: <20260131050920.2574084-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260131050920.2574084-1-ameryhung@gmail.com>
References: <20260131050920.2574084-1-ameryhung@gmail.com>
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
index 6cabf5154cf6..a94e12ddd83d 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -176,7 +176,7 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 				   struct bpf_local_storage_elem *selem);
 
-void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
+int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
 
 int bpf_selem_link_map(struct bpf_local_storage_map *smap,
 		       struct bpf_local_storage_elem *selem);
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
index 939102a5f4f7..824d053255cb 100644
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
@@ -389,19 +362,43 @@ static void bpf_selem_link_map_nolock(struct bpf_local_storage_map_bucket *b,
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
index 9da11a53109b..78e936288879 100644
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

