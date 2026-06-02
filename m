Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3743845A7
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 20:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433174; cv=none; b=uarKwmVsJo3dPeYg53Qiyb7ByaAMGTumdC2KJMlhX1OhhlvB8mWm9nJtWVifF8EE6KYJSp8vR5ykqLQw9vGAZVxUX8TzSv/80ZKjpllsiF8QwJbKQLf70PzymZyUGGa7IBIXJJp5n0xAw34ODtC33efTBJTFTRJtCphGGtc6xSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433174; c=relaxed/simple;
	bh=TZ41CpU6um9Rs4RvdC1b9ixGngsL1TnFLdggHFO3L74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nCaG1X+xkVTZ22jFH8JF3UnucEdaduMn+93ju9vysTn2YbBZKcAhCUBasA9R58pZNOm8DQf8jhidVpJrPFpXFS6foxeRiRiDOhYgmQy2nJ5hxniDEz1fv8mzxImczE8mpQONUqL1eQ2OK8ZNrFeNg6pZLnB7h26U6eTZnUN3kAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjtZSnNw; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjtZSnNw"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ef56d9b67so3512561f8f.2
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 13:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780433171; x=1781037971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVsirGflFwPVnTPXUEn0XsBTrp/7FWvbMyywrJjq/+w=;
        b=hjtZSnNw35ZY9vPXRqYiHKqXDeeO8l/k8KmN8dYeCfFyJsJL35cc512kWZ4uWMd5l7
         AHrWAVauMuw6GKbh9CwlePbgHGTHFn4qlZkTtMe8xtnwSxllWKfnlm9YRnMH+MZsg42a
         1XTQshgXIolTG+FbqjOYjXBuyyFGP582W4DJqqpVBrOC9TVBFyo8jdpQmIO7kUgFU8WQ
         KiUndYFh6qd3H9HbRsODS1xhkrdX/WnIDLn8OSEKgmvMap8hbWvpGXwyzPSdjWM5lCQS
         scHhb5wtBr/zENh4CMCEI/DbdZpipMc52nQFa9d/t0SS0IkVJEVRwNYonlPeyEWoywlX
         kJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780433171; x=1781037971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IVsirGflFwPVnTPXUEn0XsBTrp/7FWvbMyywrJjq/+w=;
        b=XeKmHfiSH0yybwfgYtgsesjHk+hECPO7bmHx6mDg5xUzsnxGdcPcYZHeBKc4zIyRUm
         zOxjVnjtyTx4vLFtbWWmH563NiL5YIFuaficHpGl6Rf/plooOQ3MPNRTZDBQgq2xmMD2
         ELOa0F6SNF5X+K5Xen5IfW1Qdd3HvaH9QgnHQzS99NsDjD7QwdaPBUqAI6z2tj8Gz5Yw
         9X/0vAzC5QmZH13tcRdvv4QWszfwzuZLLzDVyz6256z0V+MKShNmrTTlwephekyeuu6U
         WFhdMd9N4/vYB8B4PZWifzjytZfsXjlME5vTaGMEFVid5V+LpsDGL8fOqQrbupQkVA0/
         F6XA==
X-Gm-Message-State: AOJu0YxFzbSYtE2gU4kL0dJIASHz6P1vYXrdQAzs5SpzQf5fx+oWPn6x
	YKWVf086VX5OCnWnpTVMZ6y623/eK2ff3Ofo7ssBGUnGEE9Uh/ktOnKI
X-Gm-Gg: Acq92OGXZL8oLJ/jLqrziqqngN8XzWG++W6t+1Ly9pWw860Zg5JF7YbFrAg3QqB8ZJF
	s21XRqTzWUyWOmUoc94XzS90+iO54ID8vuOnUiUcj9bAwurPd8bNGPl22+mDnYWNBha0TyCiGxb
	z9YsGXwJt9168ACihqTX48DOkx22wRjp7foqkzw5jUl+l+XUHxGCjsKI+8pGLX3tWGb7AFd3jBY
	yOxmD1yYttcZMifrE459PCzYLHN102mivdI8bWOVtBBkzCSGAQinhnzBcOk1KZs+cwEDGmxeyMg
	LWx7e2PL5YZUvcfWSCoHMOrdPNkWpagb/febwCcPJRG1tnuzUvwBJuq5mz0kpK7DifnxrDYbJA2
	Z2fhp+KsDpWvRf3zfrMTHO4pJSgXhGOldqaIJ0lCBNvYcUhPLuVMcbpxPBPtp2nf0/bNop2rAmX
	enq35h5GHNrZ7AudOMu9t8FCS0
X-Received: by 2002:adf:e014:0:20b0:452:11f9:bc40 with SMTP id ffacd0b85a97d-460218abd41mr63085f8f.2.1780433170765;
        Tue, 02 Jun 2026 13:46:10 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:45::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f67c6sm1872145f8f.16.2026.06.02.13.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:46:10 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 02 Jun 2026 13:45:32 -0700
Subject: [PATCH bpf-next v6 03/11] bpf: Implement resizable hashmap basic
 functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-rhash-v6-3-1bfd35a4184f@meta.com>
References: <20260602-rhash-v6-0-1bfd35a4184f@meta.com>
In-Reply-To: <20260602-rhash-v6-0-1bfd35a4184f@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780433165; l=14009;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=EZJEPUJev07Z+9odnhBIPRdOnadUikyaemOhkX9JXiw=;
 b=rzRo70F/nbTFVvsR6tC3tagECHA5Si5G56XCXdSuE3EWxN5YMCp/5O88LpjrqW7K0ASgChkn4
 whClP1A7BwICFmWmzd+bsd05mZ5cGddZiuFEasrFgxgZ8DKz8gi0qSu
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Use rhashtable_lookup_likely() for lookups, rhashtable_remove_fast()
for deletes, and rhashtable_lookup_get_insert_fast() for inserts.

Updates modify values in place under RCU rather than allocating a
new element and swapping the pointer (as regular htab does). This
trades read consistency for performance: concurrent readers may
see partial updates. BPF_F_LOCK support and special-field
handling (timers, kptrs, etc.) follow in a later commit.

Initialize rhashtable with bpf_mem_alloc element cache. Require
BPF_F_NO_PREALLOC. Limit max_entries to 2^31. Free elements via
rhashtable_free_and_destroy().

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf_types.h      |   1 +
 include/uapi/linux/bpf.h       |   6 +
 kernel/bpf/hashtab.c           | 311 +++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           |   3 +
 kernel/bpf/verifier.c          |   1 +
 tools/include/uapi/linux/bpf.h |   6 +
 6 files changed, 328 insertions(+)

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
index 3dd9b4924ae4..10f3a058747b 100644
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
@@ -2739,3 +2740,313 @@ const struct bpf_map_ops htab_of_maps_map_ops = {
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
+static u64 rhtab_map_mem_usage(const struct bpf_map *map)
+{
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	u64 num_entries;
+
+	/* Excludes rhashtable bucket overhead (~ nelems * sizeof(void *) at 75% load). */
+	num_entries = atomic_read(&rhtab->ht.nelems);
+	return sizeof(struct bpf_rhtab) + rhtab->elem_size * num_entries;
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
+	.map_mem_usage = rhtab_map_mem_usage,
+	.map_btf_id = &rhtab_map_btf_ids[0],
+};
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 625a4366fe6d..1faae184de48 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1398,6 +1398,7 @@ static int map_create_alloc(union bpf_attr *attr, bpfptr_t uattr, struct bpf_ver
 
 	if (attr->map_type != BPF_MAP_TYPE_BLOOM_FILTER &&
 	    attr->map_type != BPF_MAP_TYPE_ARENA &&
+	    attr->map_type != BPF_MAP_TYPE_RHASH &&
 	    attr->map_extra != 0) {
 		bpf_log(log, "Invalid map_extra.\n");
 		return -EINVAL;
@@ -1469,6 +1470,7 @@ static int map_create_alloc(union bpf_attr *attr, bpfptr_t uattr, struct bpf_ver
 	case BPF_MAP_TYPE_CGROUP_ARRAY:
 	case BPF_MAP_TYPE_ARRAY_OF_MAPS:
 	case BPF_MAP_TYPE_HASH:
+	case BPF_MAP_TYPE_RHASH:
 	case BPF_MAP_TYPE_PERCPU_HASH:
 	case BPF_MAP_TYPE_HASH_OF_MAPS:
 	case BPF_MAP_TYPE_RINGBUF:
@@ -2259,6 +2261,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 		   map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 		   map->map_type == BPF_MAP_TYPE_LRU_HASH ||
 		   map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+		   map->map_type == BPF_MAP_TYPE_RHASH ||
 		   map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
 		if (!bpf_map_is_offloaded(map)) {
 			bpf_disable_instrumentation();
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8ed484cb1a8a..7d27ba396d32 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17657,6 +17657,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
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

