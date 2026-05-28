Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FBA400DE4
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779990467; cv=none; b=cZQXpDDy10VkShnopOF6+tahvO/M8KYpmIQ+2yUP4MbNGPw465uprDFZlr7d5pM3QJ+opqUkE4XA2QU60dFxsCe8DnpKH7USJjb1dQDjDK+HGRoyHT8V1r6Vy70EFXnTkGT1ZQIW2ntOB2xKZZbyDL5jFfmrry8SX7avPeFWLyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779990467; c=relaxed/simple;
	bh=yZX1dfFYMhNOjLc/bOphK6zRysK3TxajTZjPEj9rwOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GVhrfONxztKcH/jDZF4jWywRJhfQZWJd8YOUv03fbsgUYtFbmuSk1kiPyiaG77VhAeeJJ1R24gDhtiWls3yv5ql1y8fIdoeT5Af9F3Lun18/aZ5sREqwtfdvl67DgjuQE02FBM9iaTLXKK5tyNpv5hrAv8cxd5kUpdJRxOSEfog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qFXC5G1K; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFXC5G1K"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49048e043e5so53691645e9.1
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779990460; x=1780595260; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRWs1prX9RiHYnMNiUZkk31qK/f108iI1MG4B76UHiE=;
        b=qFXC5G1KxqWqH5NkVJ/3erDasMxymwF3PYKizBbBnmsuLiMQoY5pSE+3moT8MBmrJf
         gd4OuzQSJMaRNBCEuSdqaaGr6uGi0nO3ifUOClnfM2WXKQfbyagDzfdhgeF90wW5z37P
         cNyWYfct3hlpH59bjFFJc3pdyq33WFwhH0e/bZbC99E7U6m1PqkfUy8ezr2xbFgJCzNl
         3oqHJF/HvsY8W0umzDJpr2FHRmdrM+2U7LU/6mHmfGsUG5AwtbDDqSteCMLtvd9QR67b
         hH5pu9XrG1N76+3LszVZ1TYy001Q/pW52vhqiOIYKLxU/9+sT832LrCSgTnSMwNlkiHI
         6Q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779990460; x=1780595260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FRWs1prX9RiHYnMNiUZkk31qK/f108iI1MG4B76UHiE=;
        b=gFTUvx82NNuaREfeqUWYnFelrOvF8cug/iGGwMBIG81LTSlU7lYkBipVXf3nW+awAG
         MgMdaXKMjpXXtn9OYOHcc/6oP3IrsIalP+GCmon5VUZ4w64G9Wu7wmQZe6KHUCWGRhKp
         dNr45j7CohlX83tsMs+/J/UwGzD1a5CQbSnsyFPjtG1lR/IlgKH2AiB344bojO7GrOn4
         vNOO6r09KacItcNqxJF6L7LtcP3n2USnED+ycmjTWJg+4pLtzHRS+ZfHX79PhdHlG+lW
         gN+Tw26ZURqa9YUHoaB6MXB81jgF1yUBufSy9zTrfHMn6j4OPu6mio2+8mMOLvebxBxq
         yNAA==
X-Gm-Message-State: AOJu0Yym7JtgaYm3EKLIka5PZivLHD7o/3o+Sw2Y0AgsZYbudvtkKeHL
	rREamJOP9LvxVjHtxOrUEwziiVhQ2mwqPrhnZhT/1oETHX2QcI6hjA9W
X-Gm-Gg: Acq92OHfuIABNQQeyJHgfPSbCuCdM2nDVkNM0fw++TbtoUNRBUaL9gxSRxjBnHgjpPb
	ziL4A/kF+AIuBrYtiavqDdldEEW7kVBbQT4FuENmkwiavD+juuj1rSJiw6r0V2QgF+Kexzzp6uF
	vw/N6hgxkikKJeFLhsopH/Tqec2JujypnBPF++REQGMMMg4y+VG7SoqV4BJQ4kLLnra1Sfyo4fD
	WwuPWiUEDmk3fI4lxY5DFYyklPWslaRtw9bTz+Yi3fF4lmdlkD4si3zTpwGOd0DVmmkXOLsR6+c
	dr0xbk8IvbPatNAPAy7QmysMJIIqdYe8zvqTSZj9uPrmK8MeT6RbJGRl9+FrRKP4+E8rueWDeDn
	Wlp9X0JTuQBO69z0Yne7FLyvwNcGcNsMVgItR9M78kWZi48p7IB5rH5naOySp2YWFpqF6+nrd7B
	KepPx/kMbZ7xlEY0/uWrXMCbNQ
X-Received: by 2002:a05:600c:3b02:b0:48a:581c:ead with SMTP id 5b1f17b1804b1-490425ac8a1mr473920265e9.10.1779990459476;
        Thu, 28 May 2026 10:47:39 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909235d43esm87615435e9.1.2026.05.28.10.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 10:47:39 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 28 May 2026 10:47:14 -0700
Subject: [PATCH bpf-next v5 03/11] bpf: Implement resizable hashmap basic
 functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-rhash-v5-3-7205191b6c57@meta.com>
References: <20260528-rhash-v5-0-7205191b6c57@meta.com>
In-Reply-To: <20260528-rhash-v5-0-7205191b6c57@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779990451; l=13689;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=qHheIwQuYSx9IAJaHsliXPdHqWIOhk2bueWTg4rCkGw=;
 b=6MWsHbH7eLf3QPaNOK7dSy0vfgAYb5JGebNesziaZ+/35RNxGkE6PkqbeIUeaG2VRYjInU2ls
 W/ORpdlGiJ5Aq1Q0tbROlzogQ8+yNXy3VoWuI56Tbhwb2ZTQpTvXZpk
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Use rhashtable_lookup_likely() for lookups, rhashtable_remove_fast()
for deletes, and rhashtable_lookup_get_insert_fast() for inserts.

Updates modify values in place under RCU rather than allocating a
new element and swapping the pointer (as regular htab does). This
trades read consistency for performance: concurrent readers may
see partial updates. Users requiring consistent reads should use
BPF_F_LOCK.

Initialize rhashtable with bpf_mem_alloc element cache. Require
BPF_F_NO_PREALLOC. Limit max_entries to 2^31. Free elements via
rhashtable_free_and_destroy() callback to handle internal structs.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf_types.h      |   1 +
 include/uapi/linux/bpf.h       |   6 +
 kernel/bpf/hashtab.c           | 301 +++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           |   3 +
 kernel/bpf/verifier.c          |   1 +
 tools/include/uapi/linux/bpf.h |   6 +
 6 files changed, 318 insertions(+)

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index b13de31e163f..56e4c3f983d3 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -134,6 +134,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_USER_RINGBUF, user_ringbuf_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_ARENA, arena_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_INSN_ARRAY, insn_array_map_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_RHASH, rhtab_map_ops)
 
 BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
 BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index aec171ccb6ef..bed9b1b4d5ef 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1047,6 +1047,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_CGRP_STORAGE,
 	BPF_MAP_TYPE_ARENA,
 	BPF_MAP_TYPE_INSN_ARRAY,
+	BPF_MAP_TYPE_RHASH,
 	__MAX_BPF_MAP_TYPE
 };
 
@@ -1545,6 +1546,11 @@ union bpf_attr {
 		 *
 		 * BPF_MAP_TYPE_ARENA - contains the address where user space
 		 * is going to mmap() the arena. It has to be page aligned.
+		 *
+		 * BPF_MAP_TYPE_RHASH - initial table size hint
+		 * (nelem_hint). 0 = use rhashtable default. Must be
+		 * <= min(max_entries, U16_MAX). Upper 32 bits reserved,
+		 * must be zero.
 		 */
 		__u64	map_extra;
 
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 3dd9b4924ae4..8944c9f070ca 100644
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
@@ -2739,3 +2740,303 @@ const struct bpf_map_ops htab_of_maps_map_ops = {
 	BATCH_OPS(htab),
 	.map_btf_id = &htab_map_btf_ids[0],
 };
+
+struct rhtab_elem {
+	struct rhash_head node;
+	/* key bytes, then value bytes follow */
+	u8 data[] __aligned(8);
+};
+
+struct bpf_rhtab {
+	struct bpf_map map;
+	struct rhashtable ht;
+	struct bpf_mem_alloc ma;
+	u32 elem_size;
+};
+
+static const struct rhashtable_params rhtab_params = {
+	.head_offset = offsetof(struct rhtab_elem, node),
+	.key_offset  = offsetof(struct rhtab_elem, data),
+};
+
+static inline void *rhtab_elem_value(struct rhtab_elem *l, u32 key_size)
+{
+	return l->data + round_up(key_size, 8);
+}
+
+static struct bpf_map *rhtab_map_alloc(union bpf_attr *attr)
+{
+	struct rhashtable_params params;
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
+	params = rhtab_params;
+	params.key_len = rhtab->map.key_size;
+	params.nelem_hint = (u32)attr->map_extra;
+	params.automatic_shrinking = true;
+
+	err = rhashtable_init(&rhtab->ht, &params);
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
+static int rhtab_map_alloc_check(union bpf_attr *attr)
+{
+	if (!(attr->map_flags & BPF_F_NO_PREALLOC))
+		return -EINVAL;
+
+	if (attr->map_flags & BPF_F_ZERO_SEED)
+		return -EINVAL;
+
+	if (attr->key_size > U16_MAX)
+		return -E2BIG;
+
+	if (attr->map_extra >> 32)
+		return -EINVAL;
+
+	if ((u32)attr->map_extra > U16_MAX)
+		return -E2BIG;
+
+	if ((u32)attr->map_extra > attr->max_entries)
+		return -EINVAL;
+
+	return htab_map_alloc_check(attr);
+}
+
+static void rhtab_free_elem(void *ptr, void *arg)
+{
+	struct bpf_rhtab *rhtab = arg;
+	struct rhtab_elem *elem = ptr;
+
+	bpf_map_free_internal_structs(&rhtab->map, rhtab_elem_value(elem, rhtab->map.key_size));
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
+static void *rhtab_lookup_elem(struct bpf_map *map, void *key)
+{
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+
+	/* Hold RCU lock in case sleepable program calls via gen_lookup */
+	guard(rcu)();
+
+	return rhashtable_lookup_likely(&rhtab->ht, key, rhtab_params);
+}
+
+static void *rhtab_map_lookup_elem(struct bpf_map *map, void *key) __must_hold(RCU)
+{
+	struct rhtab_elem *l;
+
+	l = rhtab_lookup_elem(map, key);
+	return l ? rhtab_elem_value(l, map->key_size) : NULL;
+}
+
+static void rhtab_read_elem_value(struct bpf_map *map, void *dst, struct rhtab_elem *elem,
+				  u64 flags)
+{
+	void *src = rhtab_elem_value(elem, map->key_size);
+
+	if (flags & BPF_F_LOCK)
+		copy_map_value_locked(map, dst, src, true);
+	else
+		copy_map_value(map, dst, src);
+}
+
+static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, void *copy,
+			     u64 flags)
+{
+	int err;
+
+	/*
+	 * disable_instrumentation() mitigates the deadlock for programs running in NMI context.
+	 * rhashtable locks bucket with local_irq_save(). Only NMI programs may reenter
+	 * rhashtable code, bpf_disable_instrumentation() disables programs running in NMI, except
+	 * raw tracepoints, which we don't have in rhashtable.
+	 */
+	bpf_disable_instrumentation();
+	err = rhashtable_remove_fast(&rhtab->ht, &elem->node, rhtab_params);
+	bpf_enable_instrumentation();
+
+	if (err)
+		return err;
+
+	if (copy) {
+		rhtab_read_elem_value(&rhtab->map, copy, elem, flags);
+		check_and_init_map_value(&rhtab->map, copy);
+	}
+
+	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
+	return 0;
+}
+
+
+static long rhtab_map_delete_elem(struct bpf_map *map, void *key)
+{
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	struct rhtab_elem *elem;
+
+	guard(rcu)();
+
+	elem = rhtab_lookup_elem(map, key);
+	if (!elem)
+		return -ENOENT;
+
+	return rhtab_delete_elem(rhtab, elem, NULL, 0);
+}
+
+static int rhtab_map_lookup_and_delete_elem(struct bpf_map *map, void *key, void *value, u64 flags)
+{
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	struct rhtab_elem *elem;
+	int err;
+
+	err = bpf_map_check_op_flags(map, flags, BPF_F_LOCK);
+	if (err)
+		return err;
+
+	guard(rcu)();
+
+	elem = rhtab_lookup_elem(map, key);
+	if (!elem)
+		return -ENOENT;
+
+	return rhtab_delete_elem(rhtab, elem, value, flags);
+}
+
+static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *elem, void *value,
+				      u64 map_flags)
+{
+	void *old_val = rhtab_elem_value(elem, map->key_size);
+
+	if (map_flags & BPF_NOEXIST)
+		return -EEXIST;
+
+	if (map_flags & BPF_F_LOCK)
+		copy_map_value_locked(map, old_val, value, false);
+	else
+		copy_map_value(map, old_val, value);
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
+	elem = rhtab_lookup_elem(map, key);
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
+	memcpy(elem->data, key, map->key_size);
+	copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
+
+	/* Prevent deadlock for NMI programs attempting to take bucket lock */
+	bpf_disable_instrumentation();
+	tmp = rhashtable_lookup_get_insert_fast(&rhtab->ht, &elem->node, rhtab_params);
+	bpf_enable_instrumentation();
+
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
+static int rhtab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
+{
+	struct bpf_insn *insn = insn_buf;
+	const int ret = BPF_REG_0;
+
+	BUILD_BUG_ON(!__same_type(&rhtab_lookup_elem,
+				  (void *(*)(struct bpf_map *map, void *key)) NULL));
+	*insn++ = BPF_EMIT_CALL(rhtab_lookup_elem);
+	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 1);
+	*insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
+				offsetof(struct rhtab_elem, data) + round_up(map->key_size, 8));
+
+	return insn - insn_buf;
+}
+
+static void rhtab_map_free_internal_structs(struct bpf_map *map)
+{
+}
+
+static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
+{
+	return -EOPNOTSUPP;
+}
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
+	.map_btf_id = &rhtab_map_btf_ids[0],
+};
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8d4ea700aac6..12c07310016a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1398,6 +1398,7 @@ static int __map_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_verifie
 
 	if (attr->map_type != BPF_MAP_TYPE_BLOOM_FILTER &&
 	    attr->map_type != BPF_MAP_TYPE_ARENA &&
+	    attr->map_type != BPF_MAP_TYPE_RHASH &&
 	    attr->map_extra != 0) {
 		bpf_log(log, "Invalid map_extra.\n");
 		return -EINVAL;
@@ -1473,6 +1474,7 @@ static int __map_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_verifie
 	case BPF_MAP_TYPE_CGROUP_ARRAY:
 	case BPF_MAP_TYPE_ARRAY_OF_MAPS:
 	case BPF_MAP_TYPE_HASH:
+	case BPF_MAP_TYPE_RHASH:
 	case BPF_MAP_TYPE_PERCPU_HASH:
 	case BPF_MAP_TYPE_HASH_OF_MAPS:
 	case BPF_MAP_TYPE_RINGBUF:
@@ -2238,6 +2240,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 		   map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 		   map->map_type == BPF_MAP_TYPE_LRU_HASH ||
 		   map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+		   map->map_type == BPF_MAP_TYPE_RHASH ||
 		   map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
 		if (!bpf_map_is_offloaded(map)) {
 			bpf_disable_instrumentation();
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c8d980fdd709..41388926b4f7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17795,6 +17795,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 	if (prog->sleepable)
 		switch (map->map_type) {
 		case BPF_MAP_TYPE_HASH:
+		case BPF_MAP_TYPE_RHASH:
 		case BPF_MAP_TYPE_LRU_HASH:
 		case BPF_MAP_TYPE_ARRAY:
 		case BPF_MAP_TYPE_PERCPU_HASH:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 37142e6d911a..7d0b282ba674 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1047,6 +1047,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_CGRP_STORAGE,
 	BPF_MAP_TYPE_ARENA,
 	BPF_MAP_TYPE_INSN_ARRAY,
+	BPF_MAP_TYPE_RHASH,
 	__MAX_BPF_MAP_TYPE
 };
 
@@ -1545,6 +1546,11 @@ union bpf_attr {
 		 *
 		 * BPF_MAP_TYPE_ARENA - contains the address where user space
 		 * is going to mmap() the arena. It has to be page aligned.
+		 *
+		 * BPF_MAP_TYPE_RHASH - initial table size hint
+		 * (nelem_hint). 0 = use rhashtable default. Must be
+		 * <= min(max_entries, U16_MAX). Upper 32 bits reserved,
+		 * must be zero.
 		 */
 		__u64	map_extra;
 

-- 
2.53.0-Meta

