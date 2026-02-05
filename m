Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7E032BF4C
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 20:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770323230; cv=none; b=XE9AoBxc6+G4Lg6xghVRKpaqP+A4CQeCwR351FeqHk7tJZE5G5DesKwa1XWgemxCSoobbk91TVunlQeGnidh2swIiTuzoytCrVCkQTmxI8KPgPuvU9WC75hi4IU4P+DZgMiT4j03GK6ILhs0MPqtt2UvHokYA9lZoS/Q0Lt6dUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770323230; c=relaxed/simple;
	bh=mPyUKtFIsr4LNzyTg53gr7hVe1t3HutnmB7SAAA4OIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UQFVFfQtCJOLnIxTB4FTWOD+sdI1vwCbD05sEcHszsZm1dgkXw1s8ybihAubBdBlUzxoTcniLB4MecLLcnOCRgV4Lf4b/XXOSvQbtFQ5KZPjwJL51DsMxkM1U0Q2GJl0PuTPdjE6Pi4LmSwsNffIIRVgE1rDdbtqizSC1BfSuAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqYVsWVO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqYVsWVO"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so11708285e9.3
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 12:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770323228; x=1770928028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+/Hz+J7YC2WhKz66wE0esu+1f/+MLI5dv3o0LI06e4=;
        b=fqYVsWVOur/qM9l7RL173u6G8l2CXaQeZObmB/Crrp7futGJrIOtFzy5AxWqoqEOcn
         OWNCxFrn2PTHbKDfPri2RnC2fVT1d45M1oCOvKgz0j8PH0DA1A2r+o6vfiFQ6S8N3I3s
         hwLKZexio08aVppG8AEN8aWf9IgGrX7uFZqpvLmU3sDMzeQjqKxUi9cn0JyhI8EGtroR
         7ciY9DtzsczEnZdN+U4byCTF0wjnmk890Oygvog/o8twcNzyHEobqZRo1oR4EJgltTTI
         r32ipnzwr3jEIEIvKaaigCCdxp9VC15NQPbf+0uFZz37IzZYG20kK0vf+tSxzD3KeX3t
         rgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770323228; x=1770928028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f+/Hz+J7YC2WhKz66wE0esu+1f/+MLI5dv3o0LI06e4=;
        b=dCjKikdIzzJQjwL0gYstP4isN/l3yY9ZKd8EPxSxn/K87ytJKxOg+gKdSJx1AzSnjW
         bFnQndBpnlj0oFfJWQyJVWJggwvbc2/nK5Uw2O82a3mj2hb3Ox1tTijDaZp6Gk58lJy9
         wcK9DmaGylOQAYKHhKkkqQWxSOKq8PyFUQaT0r3evfFhhtlJhGAdn0fK2tVCNWaZ62YY
         Su48gF4F6p9dLvKLlsH4P1+EhE0Brn6Cfng//mdvKD6PUkTUXpxqqDYg0861kamr0fDl
         ZwEafAU1/cp+u07eL2DHE5VPRdrMjOSUJtX26rfQyBrKZ+8Ags+Aux1PXZaN2jJW2NFO
         IdNg==
X-Gm-Message-State: AOJu0YxdtRyYVxxDG839mLhnQeeBjCkFEjNQQ5u2OGG33J8sRl4wRdiB
	3mgGPHvzHrz9UWJv0QxeiPyFnMMEmbzCzkK9d1YcDlQlUdDjfnujksDk+LdFZg==
X-Gm-Gg: AZuq6aL7WcOOr0VqN61qHAk270ayD82Oq8X2QlEApjS/cVDI5YOWfZLu5CzKwkvSDyc
	H5I6j5FNtBOYYXdww46mRdir9GHWHLlwtlFRkKlp9BuPrs+YC/mWVwbtDrX+1d6GtWQzCkN/ZpH
	FknNzsvY2evKayysjcuKRdH2rRNfcFoK2ZBBtLBko3qMIUE84N0skEJPluPIoyt2wtiao9vL0MP
	khBxMe83wZfAxvEYLLSKvbP/opWrawIbaaKe4S94Gs62J8zxwFWm2b1Mw1r6CwUlW4I7JVEGKUm
	JDRE5qb0NbaG3iE8bYzcnwCRr2Sna+X9kG+E3DAKso56YJolvSOGf0q38xr5EgJYqNRNK8K18Sv
	VkcBPHlG0ZDUNI1SPwiYsewR/5KEDgfS4ZEWA34emEDMcZ7JhlvZuKodC4J9TbRVWP53LNr4=
X-Received: by 2002:a05:600c:4e8c:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-48320212d56mr10240115e9.24.1770323228414;
        Thu, 05 Feb 2026 12:27:08 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::6:1325])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629756b0dsm565246f8f.40.2026.02.05.12.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 12:27:08 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 05 Feb 2026 20:24:32 +0000
Subject: [PATCH RFC bpf-next 02/12] bpf: Implement basic functions for
 resizable hashtab
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-rhash-v1-2-30dd6d63c462@meta.com>
References: <20260205-rhash-v1-0-30dd6d63c462@meta.com>
In-Reply-To: <20260205-rhash-v1-0-30dd6d63c462@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com, memxor@gmail.com, 
 puranjay@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770323224; l=15777;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=E5Snlz9e+Z5GbbyiUs/+E09Y9GXMSDW011pNQ+bGmvI=;
 b=EZuDq56OcSg2zp4jfjLvvdqWfE3qmqtbZC5FIHB2bPVqWq5LYV12FUv2OCmRuKpNDvs//5sOp
 MwNcPAbLr5eC/CQ+A7kqTC00aq8Id+wiiXLYU6qL/WWc0C4VL9CObyA
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Introduce basic operations for BPF_MAP_TYPE_RHASH, a new hash map type
built on top of the kernel's rhashtable.

Key implementation details:
- Uses rhashtable for automatic resizing with RCU-safe operations
- Elements allocated via bpf_mem_alloc for lock-free allocation
- Supports BPF_F_LOCK for spin_lock protected values
- Requires BPF_F_NO_PREALLOC

Implemented map operations:
 * map_alloc/map_free: Initialize and destroy the rhashtable
 * map_lookup_elem: RCU-protected lookup via rhashtable_lookup
 * map_update_elem: Insert or update with BPF_NOEXIST/EXIST/ANY
 * map_delete_elem: Remove element with RCU-deferred freeing
 * map_get_next_key: Returns the next key in the table
 * map_release_uref: Free internal structs (timers, workqueues)

Other operations (batch, seq file) are implemented in the next patch

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/hashtab.c | 502 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 502 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 3b9d297a53bee5b3d1c6001ed12b55b4b1a6b6d1..917f8f7d70c9ce265c13751e17e3b0bb4b598c45 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -9,6 +9,7 @@
 #include <linux/rculist_nulls.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/random.h>
+#include <linux/rhashtable.h>
 #include <uapi/linux/btf.h>
 #include <linux/rcupdate_trace.h>
 #include <linux/btf_ids.h>
@@ -413,6 +414,7 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 	bool percpu_lru = (attr->map_flags & BPF_F_NO_COMMON_LRU);
 	bool prealloc = !(attr->map_flags & BPF_F_NO_PREALLOC);
 	bool zero_seed = (attr->map_flags & BPF_F_ZERO_SEED);
+	bool resizable = attr->map_type == BPF_MAP_TYPE_RHASH;
 	int numa_node = bpf_map_attr_numa_node(attr);
 
 	BUILD_BUG_ON(offsetof(struct htab_elem, fnode.next) !=
@@ -454,6 +456,9 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 	if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
 		return -E2BIG;
 
+	if (resizable && percpu_lru)
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -2649,3 +2654,500 @@ const struct bpf_map_ops htab_of_maps_map_ops = {
 	BATCH_OPS(htab),
 	.map_btf_id = &htab_map_btf_ids[0],
 };
+
+struct rhtab_elem {
+	struct rhash_head node;
+	u32 key_len;
+	/* key bytes, then value bytes follow */
+	u8 data[] __aligned(8);
+};
+
+struct bpf_rhtab {
+	struct bpf_map map;
+	struct rhashtable ht;
+	struct rhashtable_params params;
+	struct bpf_mem_alloc ma;
+	u32 elem_size;
+};
+
+static inline void *rhtab_elem_value(struct rhtab_elem *l)
+{
+	return l->data + round_up(l->key_len, 8);
+}
+
+static void rhtab_read_elem_value(struct bpf_map *map, void *dst, struct rhtab_elem *elem,
+				  u64 flags)
+{
+	void *src = rhtab_elem_value(elem);
+
+	if (flags & BPF_F_LOCK)
+		copy_map_value_locked(map, dst, src, true);
+	else
+		copy_map_value(map, dst, src);
+}
+
+static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem)
+{
+	int err;
+
+	err = rhashtable_remove_fast(&rhtab->ht, &elem->node, rhtab->params);
+	if (err)
+		return err;
+
+	bpf_map_free_internal_structs(&rhtab->map, rhtab_elem_value(elem));
+	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
+	return 0;
+}
+
+static u32 bpf_rhtab_hash_obj(const void *obj, u32 len, u32 seed)
+{
+	const struct rhtab_elem *e = obj;
+
+	return jhash(e->data, e->key_len, seed);
+}
+
+static u32 bpf_rhtab_hash_key(const void *obj, u32 len, u32 seed)
+{
+	return jhash(obj, len, seed);
+}
+
+static int bpf_rhtab_cmp(struct rhashtable_compare_arg *arg, const void *obj)
+{
+	const struct rhtab_elem *e = obj;
+
+	return memcmp(e->data, arg->key, e->key_len);
+}
+
+/* Helper to get next element, handling -EAGAIN during resize */
+static struct rhtab_elem *rhtab_iter_next(struct rhashtable_iter *iter)
+{
+	struct rhtab_elem *elem;
+
+	while ((elem = rhashtable_walk_next(iter))) {
+		if (IS_ERR(elem)) {
+			if (PTR_ERR(elem) == -EAGAIN)
+				continue;
+			return NULL;
+		}
+		return elem;
+	}
+
+	return NULL;
+}
+
+static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
+{
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	struct rhash_head *he;
+	unsigned int slot;
+	struct rhtab_elem *elem;
+	bool found = false;
+	struct bucket_table *tbl;
+
+	guard(rcu)();
+
+	tbl = rht_dereference_rcu(rhtab->ht.tbl, &rhtab->ht);
+restart:
+	if (!tbl)
+		return -ENOENT;
+
+	slot = (key && !found) ? rht_key_hashfn(&rhtab->ht, tbl, key, rhtab->params) : 0;
+	for (; slot < tbl->size; ++slot) {
+		rht_for_each_rcu(he, tbl, slot) {
+			elem = container_of(he, struct rhtab_elem, node);
+			if (found || !key) {
+				memcpy(next_key, elem->data, map->key_size);
+				return 0;
+			} else if (memcmp(elem->data, key, map->key_size) == 0) {
+				found = true;
+			}
+		}
+		/* if key is not found in this table, search future_tbl */
+		if (key && !found)
+			break;
+	}
+	tbl = rht_dereference_rcu(tbl->future_tbl, &rhtab->ht);
+	if (tbl)
+		goto restart;
+
+	/* Key not found, wrap to first element */
+	if (key && !found) {
+		tbl = rht_dereference_rcu(rhtab->ht.tbl, &rhtab->ht);
+		key = NULL;
+		goto restart;
+	}
+
+	return -ENOENT;
+}
+
+static struct bpf_map *rhtab_map_alloc(union bpf_attr *attr)
+{
+	struct bpf_rhtab *rhtab;
+	int err = 0;
+
+	rhtab = bpf_map_area_alloc(sizeof(*rhtab), NUMA_NO_NODE);
+	if (!rhtab)
+		return ERR_PTR(-ENOMEM);
+
+	bpf_map_init_from_attr(&rhtab->map, attr);
+
+	if (rhtab->map.max_entries > 1UL << 31) {
+		err = -E2BIG;
+		goto free_rhtab;
+	}
+
+	rhtab->elem_size = sizeof(struct rhtab_elem) + round_up(rhtab->map.key_size, 8) +
+			   round_up(rhtab->map.value_size, 8);
+
+	rhtab->params.head_offset = offsetof(struct rhtab_elem, node);
+	rhtab->params.hashfn = bpf_rhtab_hash_key;
+	rhtab->params.obj_hashfn = bpf_rhtab_hash_obj;
+	rhtab->params.obj_cmpfn = bpf_rhtab_cmp;
+	rhtab->params.key_len = rhtab->map.key_size;
+
+	err = rhashtable_init(&rhtab->ht, &rhtab->params);
+	if (err)
+		goto free_rhtab;
+
+	/* Set max_elems after rhashtable_init() since init zeroes the struct */
+	rhtab->ht.max_elems = rhtab->map.max_entries;
+
+	err = bpf_mem_alloc_init(&rhtab->ma, rhtab->elem_size, false);
+	if (err)
+		goto destroy_rhtab;
+
+	return &rhtab->map;
+
+destroy_rhtab:
+	rhashtable_destroy(&rhtab->ht);
+free_rhtab:
+	bpf_map_area_free(rhtab);
+	return ERR_PTR(err);
+}
+
+static void rhtab_free_elem(void *ptr, void *arg)
+{
+	struct bpf_rhtab *rhtab = arg;
+	struct rhtab_elem *elem = ptr;
+
+	bpf_map_free_internal_structs(&rhtab->map, rhtab_elem_value(elem));
+	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
+}
+
+static void rhtab_map_free(struct bpf_map *map)
+{
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+
+	rhashtable_free_and_destroy(&rhtab->ht, rhtab_free_elem, rhtab);
+	bpf_mem_alloc_destroy(&rhtab->ma);
+	bpf_map_area_free(rhtab);
+}
+
+static void *__rhtab_map_lookup_elem(struct bpf_map *map, void *key)
+{
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+
+	return rhashtable_lookup_fast(&rhtab->ht, key, rhtab->params);
+}
+
+static void *rhtab_map_lookup_elem(struct bpf_map *map, void *key) __must_hold(RCU)
+{
+	struct rhtab_elem *l;
+
+	l = __rhtab_map_lookup_elem(map, key);
+	return l ? rhtab_elem_value(l) : NULL;
+}
+
+static int rhtab_map_alloc_check(union bpf_attr *attr)
+{
+	if (!(attr->map_flags & BPF_F_NO_PREALLOC))
+		return -EINVAL;
+
+	return htab_map_alloc_check(attr);
+}
+
+static void rhtab_map_free_internal_structs(struct bpf_map *map)
+{
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	struct rhtab_elem *elem;
+	struct bucket_table *tbl;
+	struct rhash_head *he;
+	unsigned int slot;
+
+	if (!bpf_map_has_internal_structs(map))
+		return;
+
+	guard(rcu)();
+
+	/*
+	 * An element can be processed twice if rhashtable resized concurrently
+	 * Special structs freeing handles duplicate cancel_and_free.
+	 */
+
+	tbl = rht_dereference_rcu(rhtab->ht.tbl, &rhtab->ht);
+restart:
+	for (slot = 0; slot < tbl->size; ++slot) {
+		rht_for_each_rcu(he, tbl, slot) {
+			elem = container_of(he, struct rhtab_elem, node);
+			bpf_map_free_internal_structs(map, rhtab_elem_value(elem));
+		}
+	}
+	tbl = rht_dereference_rcu(tbl->future_tbl, &rhtab->ht);
+	if (tbl)
+		goto restart;
+}
+
+static int rhtab_map_lookup_and_delete_elem(struct bpf_map *map, void *key, void *value, u64 flags)
+{
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	struct rhtab_elem *l;
+
+	if ((flags & ~BPF_F_LOCK) ||
+	    ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK)))
+		return -EINVAL;
+
+	/* Make sure element is not deleted between lookup and copy */
+	guard(rcu)();
+
+	l = __rhtab_map_lookup_elem(map, key);
+	if (!l)
+		return -ENOENT;
+
+	rhtab_read_elem_value(map, value, l, flags);
+	check_and_init_map_value(map, value);
+
+	return rhtab_delete_elem(rhtab, l);
+}
+
+static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *elem, void *value,
+				      u64 map_flags)
+{
+	if (map_flags & BPF_NOEXIST)
+		return -EEXIST;
+
+	if (map_flags & BPF_F_LOCK)
+		copy_map_value_locked(map, rhtab_elem_value(elem), value, false);
+	else
+		copy_map_value(map, rhtab_elem_value(elem), value);
+	return 0;
+}
+
+static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u64 map_flags)
+{
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	struct rhtab_elem *elem, *tmp;
+
+	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST))
+		return -EINVAL;
+
+	if ((map_flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK))
+		return -EINVAL;
+
+	guard(rcu)();
+	elem = __rhtab_map_lookup_elem(map, key);
+	if (elem)
+		return rhtab_map_update_existing(map, elem, value, map_flags);
+
+	if (map_flags & BPF_EXIST)
+		return -ENOENT;
+
+	/* Check max_entries limit before inserting new element */
+	if (atomic_read(&rhtab->ht.nelems) >= map->max_entries)
+		return -E2BIG;
+
+	elem = bpf_mem_cache_alloc(&rhtab->ma);
+	if (!elem)
+		return -ENOMEM;
+
+	elem->key_len = map->key_size;
+	memcpy(elem->data, key, map->key_size);
+	copy_map_value(map, rhtab_elem_value(elem), value);
+
+	tmp = rhashtable_lookup_get_insert_key(&rhtab->ht, key, &elem->node, rhtab->params);
+	if (tmp) {
+		bpf_mem_cache_free(&rhtab->ma, elem);
+		if (IS_ERR(tmp))
+			return PTR_ERR(tmp);
+
+		return rhtab_map_update_existing(map, tmp, value, map_flags);
+	}
+
+	return 0;
+}
+
+static long rhtab_map_delete_elem(struct bpf_map *map, void *key)
+{
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	struct rhtab_elem *l;
+
+	guard(rcu)();
+	l = __rhtab_map_lookup_elem(map, key);
+	return l ? rhtab_delete_elem(rhtab, l) : -ENOENT;
+}
+
+static int rhtab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
+{
+	struct bpf_insn *insn = insn_buf;
+	const int ret = BPF_REG_0;
+
+	BUILD_BUG_ON(!__same_type(&__rhtab_map_lookup_elem,
+				  (void *(*)(struct bpf_map *map, void *key)) NULL));
+	*insn++ = BPF_EMIT_CALL(__rhtab_map_lookup_elem);
+	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 1);
+	*insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
+				offsetof(struct rhtab_elem, data) + round_up(map->key_size, 8));
+
+	return insn - insn_buf;
+}
+
+static void rhtab_map_seq_show_elem(struct bpf_map *map, void *key, struct seq_file *m)
+{
+	void *value;
+
+	/* Guarantee that hashtab value is not freed */
+	guard(rcu)();
+
+	value = rhtab_map_lookup_elem(map, key);
+	if (!value)
+		return;
+
+	btf_type_seq_show(map->btf, map->btf_key_type_id, key, m);
+	seq_puts(m, ": ");
+	btf_type_seq_show(map->btf, map->btf_value_type_id, value, m);
+	seq_putc(m, '\n');
+}
+
+static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn, void *callback_ctx,
+				u64 flags)
+{
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	struct bucket_table *tbl;
+	struct rhtab_elem *elem;
+	struct rhash_head *he;
+	int num_elems = 0;
+	unsigned int slot;
+	void *key, *val;
+	u64 ret = 0;
+
+	cant_migrate();
+
+	if (flags)
+		return -EINVAL;
+
+	guard(rcu)();
+
+	/*
+	 * An element can be processed twice or skipped,
+	 * if hash map is being resized concurrently
+	 */
+
+	tbl = rht_dereference_rcu(rhtab->ht.tbl, &rhtab->ht);
+retry:
+	for (slot = 0; slot < tbl->size; slot++) {
+		rht_for_each_rcu(he, tbl, slot) {
+			elem = container_of(he, struct rhtab_elem, node);
+			key = elem->data;
+			val = rhtab_elem_value(elem);
+			num_elems++;
+			ret = callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)val,
+					  (u64)(long)callback_ctx, 0);
+			/* return value: 0 - continue, 1 - stop and return */
+			if (ret)
+				return num_elems;
+		}
+	}
+	tbl = rht_dereference_rcu(tbl->future_tbl, &rhtab->ht);
+	if (tbl)
+		goto retry;
+
+	return num_elems;
+}
+
+static u64 rhtab_map_mem_usage(const struct bpf_map *map)
+{
+	return 0;
+}
+
+static int rhtab_map_lookup_batch(struct bpf_map *map, const union bpf_attr *attr,
+				  union bpf_attr __user *uattr)
+{
+	return 0;
+}
+
+static int rhtab_map_lookup_and_delete_batch(struct bpf_map *map, const union bpf_attr *attr,
+					     union bpf_attr __user *uattr)
+{
+	return 0;
+}
+
+struct bpf_iter_seq_rhash_map_info {
+	struct bpf_map *map;
+	struct bpf_rhtab *rhtab;
+	struct rhashtable_iter iter;
+	u32 skip_elems;
+	bool iter_active;
+};
+
+static void *bpf_rhash_map_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	return NULL;
+}
+
+static void *bpf_rhash_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	return NULL;
+}
+
+static int bpf_rhash_map_seq_show(struct seq_file *seq, void *v)
+{
+	return 0;
+}
+
+static void bpf_rhash_map_seq_stop(struct seq_file *seq, void *v)
+{
+}
+
+static int bpf_iter_init_rhash_map(void *priv_data, struct bpf_iter_aux_info *aux)
+{
+	return 0;
+}
+
+static void bpf_iter_fini_rhash_map(void *priv_data)
+{
+}
+
+static const struct seq_operations bpf_rhash_map_seq_ops = {
+	.start = bpf_rhash_map_seq_start,
+	.next = bpf_rhash_map_seq_next,
+	.stop = bpf_rhash_map_seq_stop,
+	.show = bpf_rhash_map_seq_show,
+};
+
+static const struct bpf_iter_seq_info rhash_iter_seq_info = {
+	.seq_ops = &bpf_rhash_map_seq_ops,
+	.init_seq_private = bpf_iter_init_rhash_map,
+	.fini_seq_private = bpf_iter_fini_rhash_map,
+	.seq_priv_size = sizeof(struct bpf_iter_seq_rhash_map_info),
+};
+
+BTF_ID_LIST_SINGLE(rhtab_map_btf_ids, struct, bpf_rhtab)
+const struct bpf_map_ops rhtab_map_ops = {
+	.map_meta_equal = bpf_map_meta_equal,
+	.map_alloc_check = rhtab_map_alloc_check,
+	.map_alloc = rhtab_map_alloc,
+	.map_free = rhtab_map_free,
+	.map_get_next_key = rhtab_map_get_next_key,
+	.map_release_uref = rhtab_map_free_internal_structs,
+	.map_lookup_elem = rhtab_map_lookup_elem,
+	.map_lookup_and_delete_elem = rhtab_map_lookup_and_delete_elem,
+	.map_update_elem = rhtab_map_update_elem,
+	.map_delete_elem = rhtab_map_delete_elem,
+	.map_gen_lookup = rhtab_map_gen_lookup,
+	.map_seq_show_elem = rhtab_map_seq_show_elem,
+	.map_set_for_each_callback_args = map_set_for_each_callback_args,
+	.map_for_each_callback = bpf_each_rhash_elem,
+	.map_mem_usage = rhtab_map_mem_usage,
+	BATCH_OPS(rhtab),
+	.map_btf_id = &rhtab_map_btf_ids[0],
+	.iter_seq_info = &rhash_iter_seq_info,
+};

-- 
2.53.0

