Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA90338C2A7
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778711828; cv=none; b=T5TOgqdArilmXNZo6DqUvfjvlD44OKYZuJOhnKh095Lmn39/jE+5Eepke+rlQOWy69HkZoUFlSjJUj39Tzw+/q58EAAT9g7n2dVO/8eHWw0GBoEUAKVGaAMcXZo3ghlVwcNOTEj4t04Az8b/1MBbqmmdXqGdytQ+Me32W1+vetA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778711828; c=relaxed/simple;
	bh=L3MClWlyzqLHcJpi16OtsP+Si0/6Fa+3zTqrhhustKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xbwol5ND6E/93en6CU9RAA4t2pXZx0g83vcfEMPPYpS23WVDvHUO1wftQqvGlUXJJuzh0SRDOa4d5mnF4/OshqlbzcqrUa/NAH+KO4RPZtnYMFRrkd+zYUJjDRJCFWmCYixkr2ycw4itSyNuI5sLm+UUqMOsrI499mfNi9DHfEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSARFHCg; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSARFHCg"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43fe62837baso3855186f8f.3
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778711825; x=1779316625; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/QnKlAaFGZGvDaYHoQWUmaWzh1aoito5IhFxzuPkCA4=;
        b=DSARFHCg25zxjdEqwNKoIFCYzVxmMNbBN8A5VoqYGwVUE9sKGpFOEXUntf623i0/zl
         dsXgMhIp9+Wd0JpZB6k+qCdAe+Qe6W685RBPvGWfTvPHffNsjRur0VucL+BNj6eapgqq
         sneI/OXJoay56kVn/5OWzytBs4quD+uxPNsvaPnBFvp+n2cGj3hBrYZWueQkXFaNpxfL
         X9sBvaxLwVUdZYUI087kPCIqLlae1w5AOsWxpmqEGwlp3kgt0p9mfMV4IOJzZpO5kRAW
         MgjqrwtYKV2adnTbandUay6V96pPTJHhJ2C4U4yXKtGMy/0rWxqHiH962BA1rpOvvfjE
         2ujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778711825; x=1779316625;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/QnKlAaFGZGvDaYHoQWUmaWzh1aoito5IhFxzuPkCA4=;
        b=eTLcZhcGp6CPVhytFH8gppPDVBdLAwvkZvrog47z9QaBijPoV71KXXr3rsF3w18ERF
         jGzKFWd1eC+0Z79pD/ZibRwyzFDQbSgI9LGp/5jWBmOc2McE58ceg5MZaH8BJgBrZNID
         dY0D4EPQZ1YxX6DClZbUnixOhJNAd+LSRSHkIx6n9KVvo7Uo7RDYFoMyKcodgHxNGdbG
         RTB2LrgutC6nIIxQnU2LniCowiltkVNiNgMJQdzshWTIxWqES17UHzg1eKN5JM0+Xa0u
         s5EXWjWftyMFq9MVvaFFZ4WhtJ5E/i/sGWnGrFIyswpWcJRBmTFg9fAnTBSQLN/CJIND
         6iiw==
X-Gm-Message-State: AOJu0Yxkz14rFA+P6QWi+wblNXDtjK7drp4HyJKIycl9vfKBrrn0MEbz
	X+EwNC6wB4PpsXj4+jSzMd0zC+Hnp4m6DYk+Xko4BafiVhFZa5ZAG0In
X-Gm-Gg: Acq92OE5Vog+7Pn6NeWr4Euw83LPc7BgShqfZyDkYdiLb97bA3altVYFfnNI7t4CWfl
	+z13fL3yM2vRTws3pq5GELa1LCkIhfhgXmtwE1Z8xRbTrD5u3D5ycoJc+FA1APvig0MAQC+E308
	iKVC82uOPbX8Cm8GvpN54Yrsk2aJuVmhIV+t+zKGdl4iCA9C/CxjL2v1QuITxtOdXIMRr68O5Pt
	Fz8rNrZ1mmZdg7kQf8e3jDUqjifqnU9e8DGZQVksKnheNBCySzVjBtqoLWgnko1xUr0TNHudQUx
	csr7Raot/Q7OSXyPmSWvw+AwbT+f90mqJ2MiJ5TVyeJDMq7S4dTdmvQTiutpN44v7Pps+6yp+8y
	pjQTGDWmjDlCr/vtroY8z7LTXTKLHimp6RtNRHboTK6Q7Krh69JYDXbNV22RFFPk+ss5rXJ5lcS
	u26n6LY60h8b5QIQ==
X-Received: by 2002:a5d:5f84:0:b0:43e:b0f8:66f1 with SMTP id ffacd0b85a97d-45c5b31272bmr8173813f8f.43.1778711824674;
        Wed, 13 May 2026 15:37:04 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3ac86sm1907264f8f.14.2026.05.13.15.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 15:37:04 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 13 May 2026 15:36:06 -0700
Subject: [PATCH bpf-next v4 03/11] bpf: Implement resizable hashmap basic
 functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-rhash-v4-3-dd3d541ccb0b@meta.com>
References: <20260513-rhash-v4-0-dd3d541ccb0b@meta.com>
In-Reply-To: <20260513-rhash-v4-0-dd3d541ccb0b@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778711817; l=15765;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=nDk/Ia62XYU6WjoT+KkQYVVvg2waQEfUnxhKlW4/oFw=;
 b=B85b2j6UdV4n+P1EciYtNiBoGJA+iOtSgn6xD5xmh5kQ/iuCKZ/jGogbD+py7VcRD8kJ66jLM
 XKoSKZOpXAqCWKjM6wwEbbB4BM1pDlzupMKeSs4Sg6SXmcaFlUkWdTN
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
 kernel/bpf/hashtab.c           | 381 +++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           |   3 +
 kernel/bpf/verifier.c          |   1 +
 tools/include/uapi/linux/bpf.h |   6 +
 6 files changed, 398 insertions(+)

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
index 3dd9b4924ae4..da1754e1a525 100644
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
@@ -2739,3 +2740,383 @@ const struct bpf_map_ops htab_of_maps_map_ops = {
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
+static void rhtab_map_seq_show_elem(struct bpf_map *map, void *key, struct seq_file *m)
+{
+}
+
+static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
+				void *callback_ctx, u64 flags)
+{
+	return -EOPNOTSUPP;
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
+	return -EOPNOTSUPP;
+}
+
+static int rhtab_map_lookup_and_delete_batch(struct bpf_map *map, const union bpf_attr *attr,
+					     union bpf_attr __user *uattr)
+{
+	return -EOPNOTSUPP;
+}
+
+struct bpf_iter_seq_rhash_map_info {
+	struct bpf_map *map;
+	struct bpf_rhtab *rhtab;
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
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6600e126fbfb..597e92f0dafc 100644
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
index 82b9531f87f6..e07ab9117e41 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17739,6 +17739,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
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

