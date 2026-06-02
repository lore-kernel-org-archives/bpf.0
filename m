Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1128C388890
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 20:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433176; cv=none; b=TeVNHxmirQzYXFh0RMQkQYkU8B3oPjinTN9fPTudKWNdPIGXKwiuNHw/5cJ8+buqbwTqxU/GVBQnp+pwGURen+iFHs4ySjI9kWxUqhfLYYiQVemJInSGY6DBeGFFLm59ZFKeHHFlprxZIQvvx7TtP9aukczQ8OefhPz7BVE1fdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433176; c=relaxed/simple;
	bh=zbhl9s4jp3HYmlAYXne48c7zs87ub0DAfRy/5Xr1+9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UV/0HjwvoYpGT/NqgyG6qLEAVc3QScZVSHBn/ykdplNjXZe9ixvmqwkQ3d94j0PaIcBZk2VVPro1AkNBtI9NPgAU4SYY5rCW/0CS/Hl2QnlWEhh9XFVa/fCht6OAAsLFEu4f/kAo8lnjEdNRheN39ZkSi8s/NI6HujkNJ12uCIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/SdwO6r; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/SdwO6r"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef29c5561so2674762f8f.0
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 13:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780433173; x=1781037973; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSpuE4gC/MNsYyOVna1gmWO3lchitbIbr3ERPpUGDf8=;
        b=h/SdwO6roQHI7Ag9Gs18hWAUbl7LYaUKoH2PL4YdMCr1rwhlnmLyJTa0mqzY+eANtt
         s52NT+NJqoxx0KLbG+WxQShgYgszHX9M4J93aBqlDP3C4VxVf+ZNCqWT4OLxo6UYj68b
         766gw9aqLsyOHER75ff7yaHYjD9DfH1RduD5hGUBpuRPbgC4o7SYtBH75JS0vcyEPqu5
         vHOqgTqpqRUu0gavvirrknUW0cqlv0bpJrIDt6qvwhczF0LHzXPm2ZYI0xLJfjyosUBo
         0hFLWCwupHLmHrX4xHxyEUnppkiRPCOrsXkiFzcpV1GaSU8BuCRcfzFHNYmfvQHHcmHb
         s4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780433173; x=1781037973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cSpuE4gC/MNsYyOVna1gmWO3lchitbIbr3ERPpUGDf8=;
        b=Txqw9gfgSy6TnVWIKn+BS3yDRsPCgj6jrqmdNO0M6ym71MP1uMOIkJB0EyjxZtP4nX
         U3vEreATg0wF1+TSRlmZANGFoAvFN6nAOefc8FAtx1gHS5rNMeNmqT8jH+8bW52ib3JM
         kIiaeSlAjYiv/9pqFc8lA7ZmOv31hSuFMHotC1yCL1jS65Fhh4vaVG47V0hMbCeWS/fw
         1yL5gx1I1AbA16I76czaEhvBheDAz78dZsIMmQK549NCaoSdxYFwVSroG9zDM6579COE
         hebam7/mjAr35Yo7fnUtUvzhyEjbehw4U22sfVtriDYEDdLZqjuqvT4mWgb6fdpJ9vi9
         jZvg==
X-Gm-Message-State: AOJu0YywXTzV07NoTqLadVNMnCdAB9K8sNtG7j07nzLupTmsnEGmJf+2
	WYGBnaKGbKmpQc8K2I6pLUKndNyexD0WiFbJw8MHN4+vE9TJ5Sl9ekb5
X-Gm-Gg: Acq92OH1qlL0EBXU9s9xcTLXhT/SS6E/Z9woxS48snhXON8RMavUkq4ghR4oqk0XZHZ
	rJSLLeSZ+wgKi0+0acITlWvMUSZ1qM1oxNcPw5g0VSVfRjo+ydNtW51niE9DNavt44lvL4IXdBG
	E7b2LpktrXjj6tFAhd/sYRcCpULMnsNFSgPvxmCT6+dA5rjuXmcYCPKmD9PDOQBFtqVQcWabw4Y
	HWFVZdLN2hXLGMBucweIt1+dyfS51N/XstCB+aUqtqzpSqfpZLAc6Sw4CHXGkgBynywH0uIB6qG
	hOp1hm1vLDj3Bt4Az79qamWulneKA+6LMrdYWO52z8caqfIF80EczL6ocYrGnUOzVT/w+0I/7lN
	GP3Hmqx7uXHWXQhF9KomLk8jqFXdw+/pwQ0PxPN3iJe9oj5fH3bISNg2TonkUmWUi9Fts88LgAu
	HSDfxTRBKYF/HKXlFzvwThMXGM
X-Received: by 2002:a05:6000:2704:b0:45f:1bd:a053 with SMTP id ffacd0b85a97d-46021783cf7mr118460f8f.1.1780433173422;
        Tue, 02 Jun 2026 13:46:13 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344558sm1919695f8f.18.2026.06.02.13.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:46:13 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 02 Jun 2026 13:45:34 -0700
Subject: [PATCH bpf-next v6 05/11] bpf: Allow special fields in resizable
 hashtab
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-rhash-v6-5-1bfd35a4184f@meta.com>
References: <20260602-rhash-v6-0-1bfd35a4184f@meta.com>
In-Reply-To: <20260602-rhash-v6-0-1bfd35a4184f@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780433165; l=8993;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=cxSr3hH9fSsqerYWkKXoWtpBBKO8qMFFiQGhc+hAgkM=;
 b=rRiJdvDyGUFMONHQeFXQJCbVaswaqAPbTFWaDBRV+NwF+6a17FfF038s8Xnj+pRaIuZnylBEQ
 7w6F4MHmzGYBt7JjtbmloHeMP6m4/MEIdERJtydvuOJWLWwEjFn5pUx
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
 kernel/bpf/hashtab.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++-----
 kernel/bpf/syscall.c |   2 +
 2 files changed, 103 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 997f420d67e3..8686918dbc3e 100644
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
@@ -2832,11 +2831,34 @@ static int rhtab_map_alloc_check(union bpf_attr *attr)
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
 	struct rhtab_elem *elem = ptr;
 
+	bpf_map_free_internal_structs(&rhtab->map, rhtab_elem_value(elem, rhtab->map.key_size));
 	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
 }
 
@@ -2900,7 +2922,8 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, v
 		rhtab_read_elem_value(&rhtab->map, copy, elem, flags);
 		check_and_init_map_value(&rhtab->map, copy);
 	}
-
+	/* Release internal structs: kptr, bpf_timer, task_work, wq */
+	rhtab_check_and_free_fields(rhtab, elem);
 	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
 	return 0;
 }
@@ -2942,6 +2965,7 @@ static int rhtab_map_lookup_and_delete_elem(struct bpf_map *map, void *key, void
 static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *elem, void *value,
 				      u64 map_flags)
 {
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
 	void *old_val = rhtab_elem_value(elem, map->key_size);
 
 	if (map_flags & BPF_NOEXIST)
@@ -2951,6 +2975,17 @@ static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *el
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
 
@@ -2973,6 +3008,14 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
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
@@ -2983,6 +3026,7 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
 
 	memcpy(elem->data, key, map->key_size);
 	copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
+	check_and_init_map_value(map, rhtab_elem_value(elem, map->key_size));
 
 	/* Prevent deadlock for NMI programs attempting to take bucket lock */
 	bpf_disable_instrumentation();
@@ -3015,8 +3059,54 @@ static int rhtab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
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
@@ -3382,6 +3472,7 @@ const struct bpf_map_ops rhtab_map_ops = {
 	.map_free = rhtab_map_free,
 	.map_get_next_key = rhtab_map_get_next_key,
 	.map_release_uref = rhtab_map_free_internal_structs,
+	.map_check_btf = rhtab_map_check_btf,
 	.map_lookup_elem = rhtab_map_lookup_elem,
 	.map_lookup_and_delete_elem = rhtab_map_lookup_and_delete_elem,
 	.map_update_elem = rhtab_map_update_elem,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 1faae184de48..73d427e32577 100644
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

