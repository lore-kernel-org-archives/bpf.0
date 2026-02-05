Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4124835A923
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274933; cv=none; b=MJkDUFmyp2ZZj1IT9/MDs+iSEfRv+ytWJVMYYQ6EdvzmYAYLN85jgNZAh2XNy1FKMyjVbpQ8sf1CXr4XiQUlrOK/GJqwkTGp27JrA9XOlPsR/BjtLUZJhnbhK1JKIHzuxa2BWJ+87WEKbFrk7OshrvUtZX6Ha1RzC0IWgWVrTQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274933; c=relaxed/simple;
	bh=+qPw4038eS2y9kHNs6zcJcVnfSIT1Z4cjnQ1bz/GUeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmiiUMEU3qEF+9BjmkPOoPPbn4R4z8QnOjzIeMcIvTj9Gx4+wbAQHxHEVisJ6wm2rjqzKNIwRgLdIQihbtXYE9bVUZRHEzX/RQSW9cFWDHsvcpAgDQcWWqDqCrt2aXzQhEX7sdq6DcR7TaH6Zuj2jXEFpUoTBPwEhGOKkVMw5ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpsY8LVS; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpsY8LVS"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-81f47610542so473816b3a.0
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 23:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274932; x=1770879732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUj0HFkDrL7UYCdDezay2A0SQorq6cGviwCSfX9SRxA=;
        b=DpsY8LVSgMirlbas/p0fA94uXy2wiugsVCJ2ZEPBmetD7JRABN9aiEidiBu7uDi8mA
         Fy09lo/1mrG3XYT2gHN9IQtkt0MGY/B6VNH9f/ZkQFAD2atHW90m/nuA8GxF0LIskX5Q
         ByxeDJW1+cz0v35HGx6yCnDVNodM9j4lo0W2vvxBaWfN3k1qsWfsYYKMcZPlSS6YVN2V
         ZfgrZXHzOcd3iQ/zY8FdDK9JjAyD0dlliIrVClddvakCVw0MzQaN7q1pVK19ZDN3hi7f
         mKnQZYZ3TM2GN60f8tERQ/j2sceWSOEd3EmOEMaQktooq6ZWjKaf5BsTlHw0eDf5kfST
         0gTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274932; x=1770879732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cUj0HFkDrL7UYCdDezay2A0SQorq6cGviwCSfX9SRxA=;
        b=JO3N6/LB2o2pmHdjn78aoGLDMwHSa1OATjmgbyv3XvCSkb5PaffejtscpNZlsJzg8d
         hU2EcqTiHmVQJuzyqvZCyvtT1iK5MvOi4cMA6CuW7jadYyBTb42cjrz5VcZARozqc+5F
         3ITGK8J/7SfFhTy7orXSOMuG2Yd+FdrGQyeWYKbfZ8f/kKw7ITJeiFsqwzjv9ogULJgi
         kd7KklO4BjYZKbWHlg3UX2zU5l9vh09d9tt3oucgC7F+0Zj013kccxrKqFtLNQ0os80k
         8rP89RMa3WqpkIrf2QxgIFOUM9Dx2H7k8KfWZ9Ea1MaX9B1RugmFmLzkcDx1UyR+1ARu
         n1mA==
X-Gm-Message-State: AOJu0YwJvXwVV6oD7IRvyV0CWZjTJ2X0zRV1gfXbakx4LRhXBF34FQ2Z
	kIQ2ZAMpZk/cn4NRC+F8qp283VYYY0SMoY4WIRCLB5k49cDbduocYGzf+tGVCQ==
X-Gm-Gg: AZuq6aKTZSh01KnicbIXtd+MPrsVEEXA9aKFonRodLc6aApECr3dSvoydZtazI6Q5Wd
	vtYFEHd1R8poIRzRe5EgaI67KZ1uc/oJEfrD5Eux3N3kSRt/EpWz5T+pdnC4XbksB0kXkWh+H9G
	yfl2YPrgLVVaJdzjtmw9KNmVCvtqHGsXc5h9Y7ohFUa3vWhsb5j9XXdYKlf3Cg5f6rbu0s9hFEK
	Gr7XXdh7XgArCwIlKDw7WZebuFi5CxY/9RIPcrugw8Pen6ScmUPgmUC4UlgzTlOOFzoiYfVGRIA
	yOcIh6j2XcDiQwCkfob7QgPj3tym3sM93vGEAFBisZ8byvCTYbnRjA0nNIPLuKTTd40B7Um+lfa
	ejfiHKbdTYoqX8fU8yPIRh2xG9cZV6jUQ8QfLosuRNI6pgPRs4X6BfnC/lreusbgYR7gw7snByU
	UiDQ==
X-Received: by 2002:a05:6a00:12c9:b0:81f:3c5b:f437 with SMTP id d2e1a72fcca58-8241c2c42c1mr5211180b3a.35.1770274932357;
        Wed, 04 Feb 2026 23:02:12 -0800 (PST)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d45b996sm4360533b3a.45.2026.02.04.23.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:11 -0800 (PST)
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
Subject: [PATCH bpf-next v6 02/17] bpf: Convert bpf_selem_unlink_map to failable
Date: Wed,  4 Feb 2026 23:01:51 -0800
Message-ID: <20260205070208.186382-3-ameryhung@gmail.com>
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

To prepare for changing bpf_local_storage_map_bucket::lock to rqspinlock,
convert bpf_selem_unlink_map() to failable. It still always succeeds and
returns 0 for now.

Since some operations updating local storage cannot fail in the middle,
open-code bpf_selem_unlink_map() to take the b->lock before the
operation. There are two such locations:

- bpf_local_storage_alloc()

  The first selem will be unlinked from smap if cmpxchg owner_storage_ptr
  fails, which should not fail. Therefore, hold b->lock when linking
  until allocation complete. Helpers that assume b->lock is held by
  callers are introduced: bpf_selem_link_map_nolock() and
  bpf_selem_unlink_map_nolock().

- bpf_local_storage_update()

  The three step update process: link_map(new_selem),
  link_storage(new_selem), and unlink_map(old_selem) should not fail in
  the middle.

In bpf_selem_unlink(), bpf_selem_unlink_map() and
bpf_selem_unlink_storage() should either all succeed or fail as a whole
instead of failing in the middle. So, return if unlink_map() failed.
Remove the selem_linked_to_map_lockless() check as an selem in the
common paths (not bpf_local_storage_map_free() or
bpf_local_storage_destroy()), will be unlinked under b->lock and
local_storage->lock and therefore no other threads can unlink the selem
from map at the same time.

In bpf_local_storage_destroy(), ignore the return of
bpf_selem_unlink_map() for now. A later patch will allow
bpf_local_storage_destroy() to unlink selems even when failing to
acquire locks.

Note that while this patch removes all callers of selem_linked_to_map(),
a later patch that introduces bpf_selem_unlink_nofail() will use it
again.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 58 +++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 91b28f4e3130..5f7869078c4f 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -61,11 +61,6 @@ static bool selem_linked_to_storage(const struct bpf_local_storage_elem *selem)
 	return !hlist_unhashed(&selem->snode);
 }
 
-static bool selem_linked_to_map_lockless(const struct bpf_local_storage_elem *selem)
-{
-	return !hlist_unhashed_lockless(&selem->map_node);
-}
-
 static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
 {
 	return !hlist_unhashed(&selem->map_node);
@@ -347,25 +342,28 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 	hlist_add_head_rcu(&selem->snode, &local_storage->list);
 }
 
-static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
+/* Only called in common paths */
+static int bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 {
 	struct bpf_local_storage *local_storage;
 	struct bpf_local_storage_map *smap;
 	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
 
-	if (unlikely(!selem_linked_to_map_lockless(selem)))
-		/* selem has already be unlinked from smap */
-		return;
-
 	local_storage = rcu_dereference_check(selem->local_storage,
 					      bpf_rcu_lock_held());
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 	b = select_bucket(smap, local_storage);
 	raw_spin_lock_irqsave(&b->lock, flags);
-	if (likely(selem_linked_to_map(selem)))
-		hlist_del_init_rcu(&selem->map_node);
+	hlist_del_init_rcu(&selem->map_node);
 	raw_spin_unlock_irqrestore(&b->lock, flags);
+
+	return 0;
+}
+
+static void bpf_selem_unlink_map_nolock(struct bpf_local_storage_elem *selem)
+{
+	hlist_del_init_rcu(&selem->map_node);
 }
 
 void bpf_selem_link_map(struct bpf_local_storage_map *smap,
@@ -381,13 +379,24 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 	raw_spin_unlock_irqrestore(&b->lock, flags);
 }
 
+static void bpf_selem_link_map_nolock(struct bpf_local_storage_map_bucket *b,
+				      struct bpf_local_storage_elem *selem)
+{
+	hlist_add_head_rcu(&selem->map_node, &b->list);
+}
+
 void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 {
+	int err;
+
 	/* Always unlink from map before unlinking from local_storage
 	 * because selem will be freed after successfully unlinked from
 	 * the local_storage.
 	 */
-	bpf_selem_unlink_map(selem);
+	err = bpf_selem_unlink_map(selem);
+	if (err)
+		return;
+
 	bpf_selem_unlink_storage(selem, reuse_now);
 }
 
@@ -429,6 +438,8 @@ int bpf_local_storage_alloc(void *owner,
 {
 	struct bpf_local_storage *prev_storage, *storage;
 	struct bpf_local_storage **owner_storage_ptr;
+	struct bpf_local_storage_map_bucket *b;
+	unsigned long flags;
 	int err;
 
 	err = mem_charge(smap, owner, sizeof(*storage));
@@ -453,7 +464,10 @@ int bpf_local_storage_alloc(void *owner,
 	storage->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
-	bpf_selem_link_map(smap, storage, first_selem);
+
+	b = select_bucket(smap, storage);
+	raw_spin_lock_irqsave(&b->lock, flags);
+	bpf_selem_link_map_nolock(b, first_selem);
 
 	owner_storage_ptr =
 		(struct bpf_local_storage **)owner_storage(smap, owner);
@@ -469,10 +483,12 @@ int bpf_local_storage_alloc(void *owner,
 	 */
 	prev_storage = cmpxchg(owner_storage_ptr, NULL, storage);
 	if (unlikely(prev_storage)) {
-		bpf_selem_unlink_map(first_selem);
+		bpf_selem_unlink_map_nolock(first_selem);
+		raw_spin_unlock_irqrestore(&b->lock, flags);
 		err = -EAGAIN;
 		goto uncharge;
 	}
+	raw_spin_unlock_irqrestore(&b->lock, flags);
 
 	return 0;
 
@@ -494,8 +510,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	struct bpf_local_storage_data *old_sdata = NULL;
 	struct bpf_local_storage_elem *alloc_selem, *selem = NULL;
 	struct bpf_local_storage *local_storage;
+	struct bpf_local_storage_map_bucket *b;
 	HLIST_HEAD(old_selem_free_list);
-	unsigned long flags;
+	unsigned long flags, b_flags;
 	int err;
 
 	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
@@ -579,20 +596,25 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		goto unlock;
 	}
 
+	b = select_bucket(smap, local_storage);
+
+	raw_spin_lock_irqsave(&b->lock, b_flags);
+
 	alloc_selem = NULL;
 	/* First, link the new selem to the map */
-	bpf_selem_link_map(smap, local_storage, selem);
+	bpf_selem_link_map_nolock(b, selem);
 
 	/* Second, link (and publish) the new selem to local_storage */
 	bpf_selem_link_storage_nolock(local_storage, selem);
 
 	/* Third, remove old selem, SELEM(old_sdata) */
 	if (old_sdata) {
-		bpf_selem_unlink_map(SELEM(old_sdata));
+		bpf_selem_unlink_map_nolock(SELEM(old_sdata));
 		bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_sdata),
 						&old_selem_free_list);
 	}
 
+	raw_spin_unlock_irqrestore(&b->lock, b_flags);
 unlock:
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 	bpf_selem_free_list(&old_selem_free_list, false);
-- 
2.47.3

