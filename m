Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3466F3AA1A8
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778711832; cv=none; b=OxvIqc1votI6qaQVCRBEdiToSWPCeyvMVVVlwtBUnOUkr//hc5qRcl1+zt5/Yt/M/c/e3eM6WWxzx04Ce299/aIO+hb7tRTtKBThk5fVbGMxzoZjkc5u7yaYdRd+5ozrTVKN2ZPEheq6hLl5Eb5xeCW3UkwCehpwehhz0UwVkc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778711832; c=relaxed/simple;
	bh=Qdw+aQ9C7sAbQha8AWOMR/jMj3AT4oS6z8/Z4PChFkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U4tJXNa6QTlSo8OuaMWmWOZUwmQqQc+NmA09OI44pa1wyLTEfaivswSQEigs/89qjAL5rcLzjKRXeuy713PlwgT3ODm+JND480Ks//HKXTLmixDIjp748Cqy5DzqASeb8oI+tTOeiLRmdgiq0azxCTtF5wTuIFV90Dez+SaMaNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmMTAMZo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmMTAMZo"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso83455735e9.1
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778711828; x=1779316628; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSiskZvvVrWIhpK4aEbHiRBKRyn1PMYZyFOc9vwUxHQ=;
        b=dmMTAMZoZJO8pS/nYpquh64ago3P0lR7TNmDyBBnwN5Z5JVdI736Vjb+RnMGcPs8CT
         5CgJRiHuZMRLKnoa5Io+/1WUc2nD/C71DRNV2c+liZS0TygENjIKtHs5QkL1/nFoDcs4
         4Xk3qXCVAe/Ck1ifReo1fWBUeO+RlXDbGgFr/qKpYqZ36Vauc4ao2BhliJJkvme2HQgq
         P6RziIUgdBmQRh0QxSHOBNeIutMCgZpXsjpSeam6E8RdxJ+ac26KuGhR7UCMFj2o6SfR
         Vklc9G2+oZD9EWyUqe3pLVKO/zq/2j8A3c1Nc9i+50ZohXjdmk1h+i3xTcN47nOwAXII
         6DUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778711828; x=1779316628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TSiskZvvVrWIhpK4aEbHiRBKRyn1PMYZyFOc9vwUxHQ=;
        b=YZV1y2Un6850eTYtjDV/Th5WeR3+NfscGtwivu7xM0OKbEryQyLb/UswBCpZcKUSue
         m3J0heLGmE4ASBntkoaSe9hC0HFxLdMlSWybjcx2MtkNGX/N6Zu84CBOsWmI59c/9wLz
         jmqI4iacM1V+f/GAyi6iZyqyrG8uZnh4PVJb9WpUHmDmZsftGWFBEc+yd4acET8j53s7
         hXaSxvm27jHfl1W2Rzv8HGbCe3sUS5CQfmSLNbFk+5IPNZIcqWWTO+bOTCDCadbjK9D7
         jiSBeNO2kneUBHP0gZtM+Fqt2ulVuAHODOnnerss9dbbaNDl2cLnaTCx9kWKvUHcc2/Y
         JcKw==
X-Gm-Message-State: AOJu0YzQ/Wf9dSpcxBeLxwOgNBETZMOcLWgLzQ9kAweMe5yVYYSALngN
	14uubPRu/X4uCOwQyXh9L6thpyGheeXcjWexGzwb1xROLz9DNJ6UXeUK
X-Gm-Gg: Acq92OHVebqOSosKgqYn241h2M0PrVLOVnfs+rhh4L2kqFQHUcXtyZnP6Sbd4lSNHpZ
	p944DRr9e9s/AgSrnkzifJznxxEjvulEsChDnutd2CrB2HIdFzucqFfskOmWXH1W11n7iKCqvg1
	eL71XlCpE614MJswhU/Z9L6JovK3pDsRJSt/Zujh3lOuNE7I40vIHX7unE3pWXd5/BhsrkWKNAI
	lBcEW/5AqUax65VgYVlLvF9uLmSX3FWZzOMbcU/0OhjMUwXph+wfbxX9N79scsXLimA4N38lLE+
	ydTGQpv+1IXLn/V3cubDNloHHv92AeFEvK8ZKRDUotFZPVFqdu4mGVSZ+jmjzgV8ypdUzHjHMO4
	QPKSQBqm/thV82zMlAOTSpvjvos/wpVGqkU2rlwANE+JueG643/1GF6G8HroF1x4uN5qE1qsPxs
	Rv0QXQ4sfpELUZ
X-Received: by 2002:a05:600c:8105:b0:48f:d5e8:758c with SMTP id 5b1f17b1804b1-48fd5e875e7mr28581705e9.16.1778711828109;
        Wed, 13 May 2026 15:37:08 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fdb26a7aasm5304875e9.3.2026.05.13.15.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 15:37:07 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 13 May 2026 15:36:08 -0700
Subject: [PATCH bpf-next v4 05/11] bpf: Allow special fields in resizable
 hashtab
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-rhash-v4-5-dd3d541ccb0b@meta.com>
References: <20260513-rhash-v4-0-dd3d541ccb0b@meta.com>
In-Reply-To: <20260513-rhash-v4-0-dd3d541ccb0b@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778711817; l=8618;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=Tx+3vJSLVTVEdQYl2x45HEUmOHSzfFZVLQ1TmR5k4rw=;
 b=Qsgg1HYFrtpQZ8gm792XfZCq0pG5e89RVqGujjF1EzYilnA+MTaVOdnnkVQsDUBwAaVJl1TZZ
 5UPtozrfY0eBGSFLFSlmiPdjdT1TosXd1UQm9SpIk1KM2OXQwRbutcx
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
 kernel/bpf/hashtab.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++-----
 kernel/bpf/syscall.c |   2 +
 2 files changed, 98 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 61eb88cb9229..9cc41850dc79 100644
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
@@ -2952,6 +2975,13 @@ static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *el
 		copy_map_value_locked(map, old_val, value, false);
 	else
 		copy_map_value(map, old_val, value);
+
+	/*
+	 * copy_map_value() skips special-field offsets, so old timers/
+	 * kptrs/etc. still sit in the slot. Cancel them after the copy
+	 * to match arraymap's update semantics.
+	 */
+	rhtab_check_and_free_fields(rhtab, elem);
 	return 0;
 }
 
@@ -2974,6 +3004,14 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
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
@@ -2984,6 +3022,7 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
 
 	memcpy(elem->data, key, map->key_size);
 	copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
+	check_and_init_map_value(map, rhtab_elem_value(elem, map->key_size));
 
 	/* Prevent deadlock for NMI programs attempting to take bucket lock */
 	bpf_disable_instrumentation();
@@ -3016,8 +3055,54 @@ static int rhtab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
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
@@ -3381,6 +3466,7 @@ const struct bpf_map_ops rhtab_map_ops = {
 	.map_free = rhtab_map_free,
 	.map_get_next_key = rhtab_map_get_next_key,
 	.map_release_uref = rhtab_map_free_internal_structs,
+	.map_check_btf = rhtab_map_check_btf,
 	.map_lookup_elem = rhtab_map_lookup_elem,
 	.map_lookup_and_delete_elem = rhtab_map_lookup_and_delete_elem,
 	.map_update_elem = rhtab_map_update_elem,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 597e92f0dafc..814ed22522ce 100644
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

