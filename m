Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D673F9F2A
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777060275; cv=none; b=rYM0KcgSkf3BECGD2biMusMPQNP0A917/E4UgaVtySvF1ji2snnCuhAiEIQ50f5QrLVmhXRp130KcvCfY1YmxqaiYtculOZ6bwTTfoCnNCoNbtuApE51GDOycHNDOOCrNQ2Pe7mYXp6wH0fxQGFRGEU0pSV+xuWFXj+y8PwTwAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777060275; c=relaxed/simple;
	bh=sP1J2kkAobA1o7F+/wylH+SKXf2Gj3kNC3DTm+Dzc44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dBS+dCz+t1Gj1uBd/0wKyzYaAcO1vItkUNkHCq16kauNCsa1uv4s8mt2gLdfaQFeZU6kqQdrvrBRjvRO/Wm6RxwR9x4237FrWWa1dzntE/eNnuxFxKEobTrp6BUyTH6sQ1FTHqIC789q/3uLo4+g9SRlLL1sfwyoUGtvDJLcFNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZptyWQw; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZptyWQw"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a3d42263e4so8114272e87.2
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 12:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777060262; x=1777665062; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8tUcUQGf7D1VoVWHjIX/4xYF5G1yz16H0We96GM5bXo=;
        b=NZptyWQwquJfBsvYjD4GZ8jIQSc35/6RfSdKGXLGUmLQPasWEuZo374M+IzIcwlhKU
         tyP7neA+tHBEmaGGLDYtAByAfshUYTUmsYFrmamEy5O8jyClihelf2vBzQgJSXdSn7Ra
         g/lMtPDX4grVlE7JgrcVN0kurEmwcTJUw/Rva6FkZFEaoe5vMa4gPu42lE5ts7Q4tABS
         x1gxWOepmfSGNMM9jQ0/AnHjxK3yc1d3TgQ9U/W9Wlj2cedcc0gjsVzDNGXJSnDyI7nO
         oS+U+GFLmO82fpY87H8H9vlYXl/Y7e9Gkzw4CRrLN8Sq60cXyvdp/bPtRlVEOT4sOHMy
         dbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777060262; x=1777665062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8tUcUQGf7D1VoVWHjIX/4xYF5G1yz16H0We96GM5bXo=;
        b=kAdc1BgJwJuAL9ZxFVtmzUaAE/92WKuQpSa1ACiyc7JvNIB82WF9CyKlAza9dN2xiK
         jGOYlX3Xpfd+9Blk1P7xE9H48+or64WUX8XUgIyG4gw82uCJjaEgMmu0II3sZAJZ6KRy
         Ytc1nkY8mLSzubUstmfXMim3w4/QtcgJOBel3ot5VpmBx9k8QMv91sM37B88pTdQXOSv
         bVuX3MzhWZn5VOcrR4vFM7JZbbw8Y3hzNODlYPiScIjEMfV+pbUyz2qDeS7vlW9qJuEs
         sqC8hzclLVi0E+K3sCuDVkWL217IO8eUbC7aGJE92vVMXdw5FU4aoQxZOwSHn8kTu+Xz
         9EnA==
X-Gm-Message-State: AOJu0YzdRU9H2UxGE75mW2uAaOgOy2ywwBj6NKsZaM8GWwLXaxgdrBAi
	+50wI1euAElDGCyJwYr6B2rkkZtVt1VPf3c8KhOETrr3J31XC8O2t3QZ
X-Gm-Gg: AeBDiesngOOtcktT0vqv7e9doRDhIree+MUOQ8BFFMttUvy5Rrq1YIDb9cSzxFbJXPJ
	EA4R9bsTw0JBs4kzo7I/G4QANlnbf7ez4SC/ztlJc8qiZ56WL0q5eRTONWuRsFJ09250jqJTA6b
	u0JjS7uhEfqxnXAF3DyrppnJssnY7S5royxgD9GkgpoNO3Ylnbd/8+kGum8FH9H1a1KYKuIH7rm
	bfDtaTLbgzQc0SfbLzf/98wo0raryqNJuW1sV4I6z5KbQTkf1MSk2krHXC5a6xHPKwWdrNJSdIq
	KmBBYL+FmdP4c4+KXeR0UpXq9tIG4H0aE85XaCgLE3m1lkVpWkJG9RchomsLszJXODEU+TUtGyF
	GZo6OQuZzqrmwei/8D/dJiNi3W7q+9y54Gx8nNMbKW9LvFMeOYLe92SveGcASMrH/+h2ElZVnLW
	2cgw30fYD1rAZYh5JUGimlvVBBlszLNgMdMw==
X-Received: by 2002:a05:6512:6c7:b0:5a2:c766:13bb with SMTP id 2adb3069b0e04-5a4172cc01dmr11471005e87.18.1777060261273;
        Fri, 24 Apr 2026 12:51:01 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187ebfd6sm6136142e87.78.2026.04.24.12.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 12:50:59 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 24 Apr 2026 12:50:43 -0700
Subject: [PATCH bpf-next v3 01/10] bpf: Implement resizable hashmap basic
 functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-rhash-v3-1-d0fa0ce4379b@meta.com>
References: <20260424-rhash-v3-0-d0fa0ce4379b@meta.com>
In-Reply-To: <20260424-rhash-v3-0-d0fa0ce4379b@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777060253; l=15712;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=+LHEjn7SSVtaT+3e/xfn9OtC1BVrd8phOUmaE2I19kE=;
 b=PO9DiQ3BbiLbd90SiPW4WNpE2jZ8h1msOzW8eBXD9TfIDbLPxIYYUQIi8Y0u5lJS9VQg7G+6G
 wjSSkXHAks1AJUF4uDH8U5961QDGF2dhs9/olNBC3Sl99tVr93yFga1
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
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf_types.h      |   1 +
 include/uapi/linux/bpf.h       |   1 +
 kernel/bpf/hashtab.c           | 381 +++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/map_iter.c          |   3 +-
 kernel/bpf/syscall.c           |   3 +
 kernel/bpf/verifier.c          |   1 +
 tools/include/uapi/linux/bpf.h |   1 +
 7 files changed, 390 insertions(+), 1 deletion(-)

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
index 552bc5d9afbd..822582c04f22 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1046,6 +1046,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_CGRP_STORAGE,
 	BPF_MAP_TYPE_ARENA,
 	BPF_MAP_TYPE_INSN_ARRAY,
+	BPF_MAP_TYPE_RHASH,
 	__MAX_BPF_MAP_TYPE
 };
 
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 3dd9b4924ae4..a37bd2a7b30f 100644
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
+	struct rhashtable_params params;
+	struct bpf_mem_alloc ma;
+	u32 elem_size;
+};
+
+static inline void *rhtab_elem_value(struct rhtab_elem *l, u32 key_size)
+{
+	return l->data + round_up(key_size, 8);
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
+	rhtab->params.key_offset = offsetof(struct rhtab_elem, data);
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
+static int rhtab_map_alloc_check(union bpf_attr *attr)
+{
+	if (!(attr->map_flags & BPF_F_NO_PREALLOC))
+		return -EINVAL;
+
+	if (attr->map_flags & BPF_F_ZERO_SEED)
+		return -EINVAL;
+
+	return htab_map_alloc_check(attr);
+}
+
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
+static int rhtab_map_check_btf(struct bpf_map *map, const struct btf *btf,
+			       const struct btf_type *key_type,
+			       const struct btf_type *value_type)
+{
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+
+	return bpf_ma_set_dtor(map, &rhtab->ma, rhtab_mem_dtor);
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
+	/* Using constant zeroed params to force rhashtable use inlined hashfunc */
+	static const struct rhashtable_params params = { 0 };
+
+	/* Hold RCU lock in case sleepable program calls via gen_lookup */
+	guard(rcu)();
+
+	return rhashtable_lookup_likely(&rhtab->ht, key, params);
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
+static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem)
+{
+	int err;
+
+	err = rhashtable_remove_fast(&rhtab->ht, &elem->node, rhtab->params);
+	if (err)
+		return err;
+
+	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
+	return 0;
+}
+
+static long rhtab_map_delete_elem(struct bpf_map *map, void *key)
+{
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	struct rhtab_elem *l;
+
+	guard(rcu)();
+	l = rhtab_lookup_elem(map, key);
+	return l ? rhtab_delete_elem(rhtab, l) : -ENOENT;
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
+static int rhtab_map_lookup_and_delete_elem(struct bpf_map *map, void *key, void *value, u64 flags)
+{
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	struct rhtab_elem *l;
+	int err;
+
+	err = bpf_map_check_op_flags(map, flags, BPF_F_LOCK);
+	if (err)
+		return err;
+
+	/* Make sure element is not deleted between lookup and copy */
+	guard(rcu)();
+
+	l = rhtab_lookup_elem(map, key);
+	if (!l)
+		return -ENOENT;
+
+	rhtab_read_elem_value(map, value, l, flags);
+	err = rhtab_delete_elem(rhtab, l);
+	if (err)
+		return err;
+
+	check_and_init_map_value(map, value);
+	return 0;
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
+	tmp = rhashtable_lookup_get_insert_fast(&rhtab->ht, &elem->node, rhtab->params);
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
+	struct rhashtable_iter iter;
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
diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index 261a03ea73d3..4a2aafbe28b4 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -119,7 +119,8 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
 		is_percpu = true;
 	else if (map->map_type != BPF_MAP_TYPE_HASH &&
 		 map->map_type != BPF_MAP_TYPE_LRU_HASH &&
-		 map->map_type != BPF_MAP_TYPE_ARRAY)
+		 map->map_type != BPF_MAP_TYPE_ARRAY &&
+		 map->map_type != BPF_MAP_TYPE_RHASH)
 		goto put_map;
 
 	key_acc_size = prog->aux->max_rdonly_access;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a3c0214ca934..6c4369691d87 100644
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
@@ -1457,6 +1458,7 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 	case BPF_MAP_TYPE_CGROUP_ARRAY:
 	case BPF_MAP_TYPE_ARRAY_OF_MAPS:
 	case BPF_MAP_TYPE_HASH:
+	case BPF_MAP_TYPE_RHASH:
 	case BPF_MAP_TYPE_PERCPU_HASH:
 	case BPF_MAP_TYPE_HASH_OF_MAPS:
 	case BPF_MAP_TYPE_RINGBUF:
@@ -2192,6 +2194,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 		   map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 		   map->map_type == BPF_MAP_TYPE_LRU_HASH ||
 		   map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+		   map->map_type == BPF_MAP_TYPE_RHASH ||
 		   map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
 		if (!bpf_map_is_offloaded(map)) {
 			bpf_disable_instrumentation();
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 185210b73385..633d29fe79b6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18070,6 +18070,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 	if (prog->sleepable)
 		switch (map->map_type) {
 		case BPF_MAP_TYPE_HASH:
+		case BPF_MAP_TYPE_RHASH:
 		case BPF_MAP_TYPE_LRU_HASH:
 		case BPF_MAP_TYPE_ARRAY:
 		case BPF_MAP_TYPE_PERCPU_HASH:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 677be9a47347..9d7df174770a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1046,6 +1046,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_CGRP_STORAGE,
 	BPF_MAP_TYPE_ARENA,
 	BPF_MAP_TYPE_INSN_ARRAY,
+	BPF_MAP_TYPE_RHASH,
 	__MAX_BPF_MAP_TYPE
 };
 

-- 
2.52.0

