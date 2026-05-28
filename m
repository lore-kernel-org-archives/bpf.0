Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1CA3FFAC5
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779990470; cv=none; b=P3Ml1/K6DDLXBpOcKvMHExUfU2sfaxX9gUtiq+YOufa4u+ar+fRoHAn7fubzRUtYsSaHkSwh+SJtbHGzGX9Ta3xnUf2OHvSZV/koCjBTfrf6+NVRZaQcc0SRDy+K2DQH5iK15v98pxn8+TPRQcL7LuwUsJhbYonr0nTdzxf0muw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779990470; c=relaxed/simple;
	bh=0qykcCutH7y1VcpS51pXACoYu9zVrUoDm9VxXJHUfBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TZcE6/AlVfGKFwBuEO6AMMo+fMlxJ7jPA4+3j1e90MK4WPe8zU1cLaBckWfqtOSsK0pzrNYepYdp7A6G8MVs6/vMn/GTkXCpZsWZcGUP7lMgZDhbcvHQiNKPlAOnlal2ejs1j39YQK4QGuSbhJeVG6oBBA6XiW2LyiegMjOU51I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjhDCw2t; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjhDCw2t"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49041e84237so56346365e9.1
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 10:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779990462; x=1780595262; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/emJhtAx72+Y+gbAyp5G0VSR8o3AEV1NMRC4F4bSR+0=;
        b=HjhDCw2tRSl/IHr89/kbJv/b+MNYzwusgsyzjN2Y2zGZUjgB7Rs6hlzz5aCJf6rirq
         vqt9ppHoWrLIpUSiyHHdQtOtMoc32V1Eqwc/S3km/sfTg4AusQkRf72a6SYnw2BfIn9p
         f49/+mrNAfbB1Vf42Z2EVQVCYOleAf1iOEJ5+isueqhMAJUZ7KWnghtPMB0jCi48VaIs
         NdPo2q2uwvViP0saanv/uMNE+dpSjtUOpz6eH3YRpoCKvH26VWAL8xuF9XXcaZRqb8d7
         AkLbAJZoj15bua4ryyb1Ytz826jD2RaZuulAohQioPF2TJjYF96/JEH20q21T5dSK+DI
         W1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779990462; x=1780595262;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/emJhtAx72+Y+gbAyp5G0VSR8o3AEV1NMRC4F4bSR+0=;
        b=sTROk+9Ggpci7/HJtd2Lz9YRG154CTi/cAy3TCzB/W8fxv1zXA34KjVFju0QbX6/YU
         8IUVLkorTxJ+b0WVKuL079NDLW/IOjFgSyKMuKOMTL+tkmLcxwUQ563hMCD2RZqlhMUL
         ckDF+WNVFRmO7VbbrF/TrQVjYvHxL8IIwDhjn6SMNWYH1nDS+wREfpvqRH9G9O42wYTN
         8GU5rdcUAsYzVjoue5sqd8Cyoof4xAPib6C6sfWIa6vRn5jN5aLi3atKHfLdEIrYNVP2
         6XqlDDZE3E+uCVxGQta2FFE1JKLlKBS4pMztDuK0aBuHLcgBfAL6yx01bG2tg20rWpKk
         exxA==
X-Gm-Message-State: AOJu0YwHuUYym3lcb8nkrmLWf0ooxTWLSMiGMWGW4TjTUR0hvvWprAWI
	q/Fa31/Ke4kmWVdm/j8eDb68lWJ5IeaFyACfkKc+pN56qr8aSPbCBHbr
X-Gm-Gg: Acq92OHTj1GaYuSTNMM7gsLQIQ8YEpmLudqWrYyMlWCjdoo0/gfVVUPDsyE1TTG1LWm
	jHbYEvdXr1XhgiVDf/RxMTp/iH3aIDjScYyyhY0By+YBcpIQrzqLAfBXcgB7nnjL00LCK60a4Yx
	u/IUPNbDmXYi8hetOoh1e241honxos/UtxxFK5mKzKfHOZp7j26KqvkftONBuxEkljsnBQImPEZ
	M2TvKNUrDQH1JGBcILbWEX0cvBQknrh8QFFKesdxQ5kZXI1BzsY0MbVde774jpLrKRUQcu3IAgY
	TxEBuEfJJSM6+XRQxhhDzZoCVtb3ElIgEE0SN0jcgGGVF2OBFbo+Ga2P+yBKmZJhaPr0+CTwdW9
	BVb/oEe2230jFpSlEDy8FTpiiL1GZ9pX3ZyvveVb1awMkWsVz6NerFEtew+MTSbmH8I6jLsgWCa
	qz4HqssL3up56aOnMaNUKjDjEj9Yigj2qwy60=
X-Received: by 2002:a05:600c:a40f:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-490947bff9dmr25200945e9.16.1779990462240;
        Thu, 28 May 2026 10:47:42 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49092a925acsm95070875e9.14.2026.05.28.10.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 10:47:41 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 28 May 2026 10:47:16 -0700
Subject: [PATCH bpf-next v5 05/11] bpf: Allow special fields in resizable
 hashtab
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-rhash-v5-5-7205191b6c57@meta.com>
References: <20260528-rhash-v5-0-7205191b6c57@meta.com>
In-Reply-To: <20260528-rhash-v5-0-7205191b6c57@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779990451; l=8811;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=c130TOhI6VwPYbXUUf7dob0V7QOS7AYGZiglvVlkk2M=;
 b=VNEA5y9HcxgnV4EYCj8UaUWGEPEM7/8pXOK3h/OsNQtoe3cN4+kdN0TQwPsYfpr7jxkME7kUR
 MJ3l8L7XNcDA9YMsKmeyvXFHZkTAoB/TR029cKduooE+a3p69A76rV0
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add support for timers, workqueues, task work and spin locks.
Without this, users needing deferred callbacks or BPF_F_LOCK in a
dynamically-sized map have no option - fixed-size htab is the only
map supporting these field types. Resizable hashtab should offer the
same capability.

Properly clean up BTF record fields on element delete and map
teardown by wiring up bpf_obj_free_fields through a memory allocator
destructor, matching the pattern used by htab for non-prealloc maps.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/hashtab.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++-----
 kernel/bpf/syscall.c |   2 +
 2 files changed, 102 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index a03fa5fa6545..50e9d57b2790 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -497,28 +497,26 @@ static void htab_dtor_ctx_free(void *ctx)
 	kfree(ctx);
 }
 
-static int htab_set_dtor(struct bpf_htab *htab, void (*dtor)(void *, void *))
+static int bpf_ma_set_dtor(struct bpf_map *map, struct bpf_mem_alloc *ma,
+			   void (*dtor)(void *, void *))
 {
-	u32 key_size = htab->map.key_size;
-	struct bpf_mem_alloc *ma;
 	struct htab_btf_record *hrec;
 	int err;
 
 	/* No need for dtors. */
-	if (IS_ERR_OR_NULL(htab->map.record))
+	if (IS_ERR_OR_NULL(map->record))
 		return 0;
 
 	hrec = kzalloc(sizeof(*hrec), GFP_KERNEL);
 	if (!hrec)
 		return -ENOMEM;
-	hrec->key_size = key_size;
-	hrec->record = btf_record_dup(htab->map.record);
+	hrec->key_size = map->key_size;
+	hrec->record = btf_record_dup(map->record);
 	if (IS_ERR(hrec->record)) {
 		err = PTR_ERR(hrec->record);
 		kfree(hrec);
 		return err;
 	}
-	ma = htab_is_percpu(htab) ? &htab->pcpu_ma : &htab->ma;
 	bpf_mem_alloc_set_dtor(ma, dtor, htab_dtor_ctx_free, hrec);
 	return 0;
 }
@@ -535,9 +533,9 @@ static int htab_map_check_btf(struct bpf_map *map, const struct btf *btf,
 	 * populated in htab_map_alloc(), so it will always appear as NULL.
 	 */
 	if (htab_is_percpu(htab))
-		return htab_set_dtor(htab, htab_pcpu_mem_dtor);
+		return bpf_ma_set_dtor(map, &htab->pcpu_ma, htab_pcpu_mem_dtor);
 	else
-		return htab_set_dtor(htab, htab_mem_dtor);
+		return bpf_ma_set_dtor(map, &htab->ma, htab_mem_dtor);
 }
 
 static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
@@ -2752,6 +2750,7 @@ struct bpf_rhtab {
 	struct rhashtable ht;
 	struct bpf_mem_alloc ma;
 	u32 elem_size;
+	bool freeing_internal;
 };
 
 static const struct rhashtable_params rhtab_params = {
@@ -2832,6 +2831,28 @@ static int rhtab_map_alloc_check(union bpf_attr *attr)
 	return htab_map_alloc_check(attr);
 }
 
+static void rhtab_check_and_free_fields(struct bpf_rhtab *rhtab,
+					struct rhtab_elem *elem)
+{
+	if (IS_ERR_OR_NULL(rhtab->map.record))
+		return;
+
+	bpf_obj_free_fields(rhtab->map.record,
+			    rhtab_elem_value(elem, rhtab->map.key_size));
+}
+
+static void rhtab_mem_dtor(void *obj, void *ctx)
+{
+	struct htab_btf_record *hrec = ctx;
+	struct rhtab_elem *elem = obj;
+
+	if (IS_ERR_OR_NULL(hrec->record))
+		return;
+
+	bpf_obj_free_fields(hrec->record,
+			    rhtab_elem_value(elem, hrec->key_size));
+}
+
 static void rhtab_free_elem(void *ptr, void *arg)
 {
 	struct bpf_rhtab *rhtab = arg;
@@ -2901,7 +2922,8 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, v
 		rhtab_read_elem_value(&rhtab->map, copy, elem, flags);
 		check_and_init_map_value(&rhtab->map, copy);
 	}
-
+	/* Release internal structs: kptr, bpf_timer, task_work, wq */
+	rhtab_check_and_free_fields(rhtab, elem);
 	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
 	return 0;
 }
@@ -2943,6 +2965,7 @@ static int rhtab_map_lookup_and_delete_elem(struct bpf_map *map, void *key, void
 static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *elem, void *value,
 				      u64 map_flags)
 {
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
 	void *old_val = rhtab_elem_value(elem, map->key_size);
 
 	if (map_flags & BPF_NOEXIST)
@@ -2952,6 +2975,17 @@ static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *el
 		copy_map_value_locked(map, old_val, value, false);
 	else
 		copy_map_value(map, old_val, value);
+
+	/*
+	 * Torn reads: a concurrent reader without BPF_F_LOCK may observe
+	 * the value mid-copy. Callers requiring consistent reads must use
+	 * BPF_F_LOCK, matching arraymap semantics.
+	 *
+	 * copy_map_value() skips special-field offsets, so old timers/
+	 * kptrs/etc. still sit in the slot. Cancel them after the copy
+	 * to match arraymap's update semantics.
+	 */
+	rhtab_check_and_free_fields(rhtab, elem);
 	return 0;
 }
 
@@ -2974,6 +3008,14 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
 	if (map_flags & BPF_EXIST)
 		return -ENOENT;
 
+	/*
+	 * Reject new insertions while map_release_uref cleanup walks the
+	 * table. Without this, new elements could keep triggering rehash
+	 * and prevent the walk from terminating.
+	 */
+	if (READ_ONCE(rhtab->freeing_internal))
+		return -EBUSY;
+
 	/* Check max_entries limit before inserting new element */
 	if (atomic_read(&rhtab->ht.nelems) >= map->max_entries)
 		return -E2BIG;
@@ -2984,6 +3026,7 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
 
 	memcpy(elem->data, key, map->key_size);
 	copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
+	check_and_init_map_value(map, rhtab_elem_value(elem, map->key_size));
 
 	/* Prevent deadlock for NMI programs attempting to take bucket lock */
 	bpf_disable_instrumentation();
@@ -3016,8 +3059,54 @@ static int rhtab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 	return insn - insn_buf;
 }
 
+static int rhtab_map_check_btf(struct bpf_map *map, const struct btf *btf,
+			       const struct btf_type *key_type,
+			       const struct btf_type *value_type)
+{
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+
+	return bpf_ma_set_dtor(map, &rhtab->ma, rhtab_mem_dtor);
+}
+
 static void rhtab_map_free_internal_structs(struct bpf_map *map)
 {
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	struct rhashtable_iter iter;
+	struct rhtab_elem *elem;
+
+	if (!bpf_map_has_internal_structs(map))
+		return;
+
+	/*
+	 * Block new insertions. Once observed, no new growth is triggered,
+	 * so any in-flight rehash will drain and the walker is guaranteed
+	 * to stop returning -EAGAIN. Treat -EAGAIN as "rehash in progress,
+	 * retry"; do not wait for the worker.
+	 */
+	WRITE_ONCE(rhtab->freeing_internal, true);
+
+	rhashtable_walk_enter(&rhtab->ht, &iter);
+	rhashtable_walk_start(&iter);
+
+	while ((elem = rhashtable_walk_next(&iter))) {
+		if (IS_ERR(elem)) {
+			if (PTR_ERR(elem) == -EAGAIN)
+				continue;
+			break;
+		}
+
+		bpf_map_free_internal_structs(map, rhtab_elem_value(elem, map->key_size));
+
+		if (need_resched()) { /* Avoid stalls on large maps */
+			rhashtable_walk_stop(&iter);
+			cond_resched();
+			rhashtable_walk_start(&iter);
+		}
+	}
+
+	rhashtable_walk_stop(&iter);
+	rhashtable_walk_exit(&iter);
+	WRITE_ONCE(rhtab->freeing_internal, false);
 }
 
 static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
@@ -3386,6 +3475,7 @@ const struct bpf_map_ops rhtab_map_ops = {
 	.map_free = rhtab_map_free,
 	.map_get_next_key = rhtab_map_get_next_key,
 	.map_release_uref = rhtab_map_free_internal_structs,
+	.map_check_btf = rhtab_map_check_btf,
 	.map_lookup_elem = rhtab_map_lookup_elem,
 	.map_lookup_and_delete_elem = rhtab_map_lookup_and_delete_elem,
 	.map_update_elem = rhtab_map_update_elem,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 12c07310016a..4d97bbce3578 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1280,6 +1280,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 			case BPF_SPIN_LOCK:
 			case BPF_RES_SPIN_LOCK:
 				if (map->map_type != BPF_MAP_TYPE_HASH &&
+				    map->map_type != BPF_MAP_TYPE_RHASH &&
 				    map->map_type != BPF_MAP_TYPE_ARRAY &&
 				    map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE &&
 				    map->map_type != BPF_MAP_TYPE_SK_STORAGE &&
@@ -1294,6 +1295,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 			case BPF_WORKQUEUE:
 			case BPF_TASK_WORK:
 				if (map->map_type != BPF_MAP_TYPE_HASH &&
+				    map->map_type != BPF_MAP_TYPE_RHASH &&
 				    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
 				    map->map_type != BPF_MAP_TYPE_ARRAY) {
 					ret = -EOPNOTSUPP;

-- 
2.53.0-Meta

