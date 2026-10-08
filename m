Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B48493D34
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791456081; cv=none; b=YEHA/g6nHhmoJCjoDmFrgpuKj1cpAAn/g5xKsBs8kdlxEt5Jun3UstghyAIzG7cY66asmf8d/YnrubVbMHBxu0+mbqINv3Bztbqukjh0HKPLXqe2Qds80tsYO6w3spNFtS9YXGg+RP/OVU3L26Bv8dVv9a+8BHpGPgKwpj12sUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791456081; c=relaxed/simple;
	bh=PfbgJJFtOI5HF8afd32gZy4ofQa0YS9BA0tQbe164ZI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lOip+5C1HE6zKQF03eMsWn28XyYldTvnaUtrIwVrdDBFLQRlfTrvUI3Z4UE+36nKKXFKk12lva3PXQ4iEhWTNqcGTPQ7NnLgucgU1oZX6M9XNcR9gp99QFp/o7sfHiD6WxayER9c3e04CtdUrLYqNcv3dJeWe/dc+I91cudF4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aduXm3Nj; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aduXm3Nj"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc795ad1f5aso3652714a12.2
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 03:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791456078; x=1792060878; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FohbjXXFFQ4KAg2ut2Fhzi5cxxNTBGYp+EAjhPyOA/o=;
        b=aduXm3NjVxFLC8j8gseQsUoIohfgsHK2rjI3fFNvbU6A7l0V5hOQ53it6GV91PVkLG
         MmbakXFd5ifm3EophBELHuyF6oZnZON1Y+QvhvOJE1tsOTNXHdBY013ib7wjJUIqeDfF
         /eCoLV7UBSgEkKx9Vc0VBz8lTChfq6Cn0u7LxiTOc1D0POT1bDvTXOZmlOD0cHP01/46
         quN3jf4xWUYkZyxyfaKHof0dW7ijk8fMrInUFn9ERpGCDPyW3GUl4/FRCVP9jri4GVrB
         VjtAygbc5J+rqfNuBjt081JxAUYuDZ8WVfz/CjJsrnXqrW6RUqERgGYCck/L8CVUufZv
         zguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456078; x=1792060878;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FohbjXXFFQ4KAg2ut2Fhzi5cxxNTBGYp+EAjhPyOA/o=;
        b=QSivFCTYqbbhIAYMiAITyBIGXOTqXKHG0W138zEkiiRTuSDJPB9DM0pcCZBNvWBppx
         sGRTa6AQHfBoQhyNlRjfahwFC7koh9GdiFwx83rqav1HVOpop4jptzNeLLL2w3jMwH7c
         /2QLbwK1FiJcPmSc9kjzrnGMgRZlSxQRcTEUpZHbQTp2A/vbwuscWr8E42pUA/ZQ5M9M
         JjO5n+o/0+xIL2qqtYfLoyD+PknS1kyTB0T1kJJy0WA3nyT/X+aVs65smcy9CiUs6Nmp
         R3IJo55EFjuhw/rFG+3muNY0afoKtLL/7bvTgwo3z1PG++xrt85puyp8b7myDLIH6lib
         qu9w==
X-Gm-Message-State: AFuF++lGsc6KtqunzBShpXG7P2AFCIqRZJ1DUj9zOGC4VMlrMlOuMH+4
	P4sxDnPgdfYfBTjiEw4qriaqHX2m3zqAy6E9jbVyqnILCDnrBvMwYn5dMG0+H0UtIoB+q28O8vZ
	AODFuqbdZcZl19WMWrQ==
X-Received: from pglr13.prod.google.com ([2002:a63:514d:0:b0:cc7:d4dc:2cd])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:14d:b0:3de:48ca:c578 with SMTP id adf61e73a8af0-3e134066a2emr4374409637.33.1791456078160;
 Thu, 08 Oct 2026 03:41:18 -0700 (PDT)
Date: Thu,  8 Oct 2026 03:41:06 -0700
In-Reply-To: <20261008104108.993791-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261008104108.993791-1-tjmercier@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261008104108.993791-3-tjmercier@google.com>
Subject: [PATCH bpf-next v9 2/2] bpf: htab: Reduce elem_size by 8 bytes for
 small key sizes
From: "T.J. Mercier" <tjmercier@google.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"

For standard and PCPU (non-LRU) hash maps with small key sizes (less
than or equal to the word size), comparing keys requires only a single
instruction. Storing a cached 32-bit hash value to shortcut full key
comparisons provides no performance advantage for small keys, and
consumes memory for every element.

This memory can be saved by removing hash from struct htab_elem and
placing it directly before struct htab_elem only for the new
htab_elem_hashed type which is used only when keys are larger than the
word size or for LRU maps. This reduces elem_size by 8 bytes for small
keys while keeping key and hash at constant compile-time offsets from
struct htab_elem across all map types and key sizes.

All element variants requiring hashes get an anonymous
htab_elem_hashed embedding, ensuring that the -8 byte hash offset is
guaranteed for all element types by composition.

Elements can be recycled without a RCU grace period. Before this commit,
alloc_htab_elem() overwrote the key before initializing the value/pptr
and wrote the hash last, so during value assignment on a recycled
element, the new key was paired with the old hash preventing lockless
readers from matching either the old key or the new key except when
there was also a hash collision.

When hashes are omitted for small keys, only the key field guards
lookups. Writing the new key before value/pptr initialization would
allow a concurrent lookup of the new key to match an uninitialized value
or dereference a stale or freed pptr. So move the new key assignment to
the end of alloc_htab_elem() where the hash assignment was done. Like
the hash assignment it replaces, it does not enforce value store
ordering before key stores on weakly ordered architectures for lockless
readers that were already traversing l_new via a stale pointer before
hlist_nulls_add_head_rcu().

Before this commit htab_mem_dtor() was invoked with the start of the
allocation, which is no longer always the address of struct htab_elem
now that elem_offset can be nonzero for non-preallocated, non-per-CPU
maps. So the key_size field of struct htab_btf_record has been replaced
with a value_offset computed at map creation and passed through
bpf_ma_set_dtor(). That reduces the destructor to a call to
bpf_obj_free_fields() at a fixed offset, which is exactly what
rhtab_mem_dtor() did, so rhtab_mem_dtor() has been removed and replaced
with the new implementation of htab_mem_dtor() for BPF_MAP_TYPE_RHASH.

Together with the previous patch, this reduces the minimum standard and
preallocated hash map element size from 64 bytes down to 32 bytes, and
non-preallocated per-CPU element size from 64 bytes down to 40 bytes.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 kernel/bpf/hashtab.c                          | 229 +++++++++++++-----
 .../selftests/bpf/progs/map_ptr_kern.c        |   2 +-
 2 files changed, 166 insertions(+), 65 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 810db9c43653..9d4791ee1741 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -100,6 +100,7 @@ struct bpf_htab {
 	struct percpu_counter pcount;
 	atomic_t count;
 	bool use_percpu_counter;
+	bool has_hash;
 	u32 n_buckets;	/* number of hash buckets */
 	u32 elem_size;	/* size of each element in bytes */
 	u32 elem_offset;/* offset of htab_elem in bytes */
@@ -118,18 +119,22 @@ struct htab_elem {
 			};
 		};
 	};
-	u32 hash __aligned(8);
 	char key[] __aligned(8);
 };
 
+struct htab_elem_hashed {
+	u32 hash __aligned(8);
+	struct htab_elem elem;
+};
+
 struct htab_elem_lru {
 	struct bpf_lru_node lru_node;
-	struct htab_elem elem;
+	struct htab_elem_hashed;
 };
 
 /*
- * Only for non-preallocated PCPU maps. Preallocated PCPU maps don't need
- * ptr_to_pptr, and use htab_elem.
+ * Only for non-preallocated PCPU maps with small keys. Preallocated PCPU maps
+ * don't need ptr_to_pptr, and use htab_elem.
  */
 struct htab_elem_pcpu {
 	/* pointer to per-cpu pointer */
@@ -137,10 +142,23 @@ struct htab_elem_pcpu {
 	struct htab_elem elem;
 };
 
+/*
+ * Only for non-preallocated PCPU maps with large keys. Preallocated PCPU maps
+ * don't need ptr_to_pptr, and use htab_elem_hashed.
+ */
+struct htab_elem_pcpu_hashed {
+	/* pointer to per-cpu pointer */
+	void *ptr_to_pptr;
+	struct htab_elem_hashed;
+};
+
+static_assert(offsetof(struct htab_elem_pcpu_hashed, ptr_to_pptr) ==
+	      offsetof(struct htab_elem_pcpu, ptr_to_pptr));
+
 struct htab_btf_record {
 	struct btf_record *record;
 	struct btf *btf;
-	u32 key_size;
+	u32 value_offset;
 };
 
 static inline bool htab_is_prealloc(const struct bpf_htab *htab)
@@ -195,19 +213,64 @@ static inline bool is_fd_htab(const struct bpf_htab *htab)
 	return htab->map.map_type == BPF_MAP_TYPE_HASH_OF_MAPS;
 }
 
+/*
+ * u32 hash reads are always atomic. If the hash is elided, key comparisons
+ * must also be atomic to avoid false positive matches from torn key
+ * reads/writes on recycled elements. That is only possible when the
+ * key fits within a word.
+ */
+static __always_inline bool htab_key_size_needs_hash(u32 key_size)
+{
+	return key_size > sizeof(unsigned long);
+}
+
+/*
+ * When hash is omitted, key reads and writes must be atomic to support lockless
+ * RCU readers. Zero-extend keys to the word size to support all sub-word key
+ * sizes, regardless of the size of the caller's key allocation.
+ */
+static __always_inline unsigned long htab_zero_extend_key(const void *key,
+							  u32 key_size)
+{
+	unsigned long k = 0;
+
+	memcpy(&k, key, min_t(u32, key_size, sizeof(k)));
+	return k;
+}
+
+static bool htab_has_hash(const struct bpf_htab *htab)
+{
+	return htab->has_hash;
+}
+
+static u32 htab_elem_hash(struct htab_elem *l)
+{
+	return container_of(l, struct htab_elem_hashed, elem)->hash;
+}
+
+static void htab_elem_set_hash(struct htab_elem *l, u32 hash)
+{
+	container_of(l, struct htab_elem_hashed, elem)->hash = hash;
+}
+
 static void *htab_elem_container(const struct bpf_htab *htab, struct htab_elem *l)
 {
 	return (void *)l - htab->elem_offset;
 }
 
-static void *htab_elem_get_ptr_to_pptr(struct htab_elem *l)
+static void *htab_elem_get_ptr_to_pptr(const struct bpf_htab *htab, struct htab_elem *l)
 {
-	return container_of(l, struct htab_elem_pcpu, elem)->ptr_to_pptr;
+	struct htab_elem_pcpu *pcpu_elem = htab_elem_container(htab, l);
+
+	return pcpu_elem->ptr_to_pptr;
 }
 
-static void htab_elem_set_ptr_to_pptr(struct htab_elem *l, void *ptr)
+static void htab_elem_set_ptr_to_pptr(const struct bpf_htab *htab, struct htab_elem *l,
+				      void *ptr)
 {
-	container_of(l, struct htab_elem_pcpu, elem)->ptr_to_pptr = ptr;
+	struct htab_elem_pcpu *pcpu_elem = htab_elem_container(htab, l);
+
+	pcpu_elem->ptr_to_pptr = ptr;
 }
 
 static struct bpf_lru_node *htab_elem_lru_node(struct htab_elem *l)
@@ -381,7 +444,7 @@ static int prealloc_init(struct bpf_htab *htab)
 	if (htab_is_lru(htab))
 		err = bpf_lru_init(&htab->lru,
 				   htab->map.map_flags & BPF_F_NO_COMMON_LRU,
-				   offsetof(struct htab_elem_lru, elem.hash) -
+				   offsetof(struct htab_elem_lru, hash) -
 				   offsetof(struct htab_elem_lru, lru_node),
 				   htab_lru_map_delete_node,
 				   htab);
@@ -503,14 +566,11 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 static void htab_mem_dtor(void *obj, void *ctx)
 {
 	struct htab_btf_record *hrec = ctx;
-	struct htab_elem *elem = obj;
-	void *map_value;
 
 	if (IS_ERR_OR_NULL(hrec->record))
 		return;
 
-	map_value = htab_elem_value(elem, hrec->key_size);
-	bpf_obj_free_fields(hrec->record, map_value);
+	bpf_obj_free_fields(hrec->record, obj + hrec->value_offset);
 }
 
 static void htab_pcpu_mem_dtor(void *obj, void *ctx)
@@ -540,7 +600,7 @@ static void htab_dtor_ctx_free(void *ctx)
 }
 
 static int bpf_ma_set_dtor(struct bpf_map *map, struct bpf_mem_alloc *ma,
-			   void (*dtor)(void *, void *))
+			   void (*dtor)(void *, void *), u32 value_offset)
 {
 	struct htab_btf_record *hrec;
 	int err;
@@ -552,7 +612,7 @@ static int bpf_ma_set_dtor(struct bpf_map *map, struct bpf_mem_alloc *ma,
 	hrec = kzalloc_obj(*hrec);
 	if (!hrec)
 		return -ENOMEM;
-	hrec->key_size = map->key_size;
+	hrec->value_offset = value_offset;
 	hrec->record = btf_record_dup(map->record);
 	if (IS_ERR(hrec->record)) {
 		err = PTR_ERR(hrec->record);
@@ -587,9 +647,12 @@ static int htab_map_check_btf(struct bpf_map *map, const struct btf *btf,
 	 * populated in htab_map_alloc(), so it will always appear as NULL.
 	 */
 	if (htab_is_percpu(htab))
-		return bpf_ma_set_dtor(map, &htab->pcpu_ma, htab_pcpu_mem_dtor);
+		return bpf_ma_set_dtor(map, &htab->pcpu_ma, htab_pcpu_mem_dtor, 0);
 	else
-		return bpf_ma_set_dtor(map, &htab->ma, htab_mem_dtor);
+		return bpf_ma_set_dtor(map, &htab->ma, htab_mem_dtor,
+				       htab->elem_offset +
+				       offsetof(struct htab_elem, key) +
+				       round_up(map->key_size, 8));
 }
 
 static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
@@ -612,6 +675,10 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 
 	bpf_map_init_from_attr(&htab->map, attr);
 
+	/* Avoid hash memory use and comparisons where unnecessary. */
+	htab->has_hash = htab_is_lru(htab) ||
+			 htab_key_size_needs_hash(htab->map.key_size);
+
 	if (percpu_lru) {
 		/* ensure each CPU's lru list has >=1 elements.
 		 * since we are at it, make each lru list has the same
@@ -636,7 +703,11 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	if (htab_is_lru(htab))
 		htab->elem_offset = offsetof(struct htab_elem_lru, elem);
 	else if (percpu && !prealloc)
-		htab->elem_offset = offsetof(struct htab_elem_pcpu, elem);
+		htab->elem_offset = htab_has_hash(htab) ?
+				    offsetof(struct htab_elem_pcpu_hashed, elem) :
+				    offsetof(struct htab_elem_pcpu, elem);
+	else if (htab_has_hash(htab))
+		htab->elem_offset = offsetof(struct htab_elem_hashed, elem);
 
 	htab->elem_size = htab->elem_offset +
 			  sizeof(struct htab_elem) +
@@ -754,35 +825,57 @@ static inline struct hlist_nulls_head *select_bucket(struct bpf_htab *htab, u32
 	return &__select_bucket(htab, hash)->head;
 }
 
-/* this lookup function can only be called with bucket lock taken */
-static struct htab_elem *lookup_elem_raw(struct hlist_nulls_head *head, u32 hash,
-					 void *key, u32 key_size)
+static __always_inline struct hlist_nulls_node *
+__lookup_elem_raw(struct hlist_nulls_head *head, u32 hash, void *key,
+		  u32 key_size, bool elem_has_hash)
 {
 	struct hlist_nulls_node *n;
 	struct htab_elem *l;
 
-	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
-		if (l->hash == hash && !memcmp(&l->key, key, key_size))
-			return l;
+	if (elem_has_hash) {
+		hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
+			if (htab_elem_hash(l) == hash &&
+			    !memcmp(&l->key, key, key_size))
+				break;
+	} else {
+		unsigned long k = htab_zero_extend_key(key, key_size);
 
-	return NULL;
+		hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
+			if (READ_ONCE(*(unsigned long *)l->key) == k)
+				break;
+	}
+
+	return n;
+}
+
+/* this lookup function can only be called with bucket lock taken */
+static __always_inline struct htab_elem *
+lookup_elem_raw(struct hlist_nulls_head *head, u32 hash, void *key,
+		u32 key_size, bool elem_has_hash)
+{
+	struct hlist_nulls_node *n;
+
+	n = __lookup_elem_raw(head, hash, key, key_size, elem_has_hash);
+	if (is_a_nulls(n))
+		return NULL;
+
+	return hlist_nulls_entry(n, struct htab_elem, hash_node);
 }
 
 /* can be called without bucket lock. it will repeat the loop in
  * the unlikely event when elements moved from one bucket into another
  * while link list is being walked
  */
-static __always_inline struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head *head,
-							       u32 hash, void *key,
-							       u32 key_size, u32 n_buckets)
+static __always_inline struct htab_elem *
+lookup_nulls_elem_raw(struct hlist_nulls_head *head, u32 hash, void *key,
+		      u32 key_size, bool elem_has_hash, u32 n_buckets)
 {
 	struct hlist_nulls_node *n;
-	struct htab_elem *l;
 
 again:
-	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
-		if (l->hash == hash && !memcmp(&l->key, key, key_size))
-			return l;
+	n = __lookup_elem_raw(head, hash, key, key_size, elem_has_hash);
+	if (!is_a_nulls(n))
+		return hlist_nulls_entry(n, struct htab_elem, hash_node);
 
 	if (unlikely(get_nulls_value(n) != (hash & (n_buckets - 1))))
 		goto again;
@@ -790,7 +883,8 @@ static __always_inline struct htab_elem *lookup_nulls_elem_raw(struct hlist_null
 	return NULL;
 }
 
-static __always_inline void *__htab_lookup(struct bpf_map *map, void *key, u32 key_size)
+static __always_inline void *__htab_lookup(struct bpf_map *map, void *key,
+					   u32 key_size, bool elem_has_hash)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct hlist_nulls_head *head;
@@ -803,7 +897,8 @@ static __always_inline void *__htab_lookup(struct bpf_map *map, void *key, u32 k
 
 	head = select_bucket(htab, hash);
 
-	l = lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_buckets);
+	l = lookup_nulls_elem_raw(head, hash, key, key_size, elem_has_hash,
+				  htab->n_buckets);
 
 	return l;
 }
@@ -817,17 +912,25 @@ static __always_inline void *__htab_lookup(struct bpf_map *map, void *key, u32 k
  */
 static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
 {
-	return __htab_lookup(map, key, map->key_size);
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
+
+	return __htab_lookup(map, key, map->key_size, htab_has_hash(htab));
 }
 
+/*
+ * Specialized lookups for htab_map_gen_lookup(). These are only used for
+ * BPF_MAP_TYPE_HASH (never LRU), so elem_has_hash depends only on key size.
+ */
 static void *__htab_map_lookup_elem_u32(struct bpf_map *map, void *key)
 {
-	return __htab_lookup(map, key, sizeof(u32));
+	return __htab_lookup(map, key, sizeof(u32),
+			     htab_key_size_needs_hash(sizeof(u32)));
 }
 
 static void *__htab_map_lookup_elem_u64(struct bpf_map *map, void *key)
 {
-	return __htab_lookup(map, key, sizeof(u64));
+	return __htab_lookup(map, key, sizeof(u64),
+			     htab_key_size_needs_hash(sizeof(u64)));
 }
 
 static void *htab_map_lookup_elem(struct bpf_map *map, void *key)
@@ -956,7 +1059,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 	int ret;
 
 	tgt_l = container_of(node, struct htab_elem_lru, lru_node);
-	b = __select_bucket(htab, tgt_l->elem.hash);
+	b = __select_bucket(htab, tgt_l->hash);
 	head = &b->head;
 
 	ret = htab_lock_bucket(b, &flags);
@@ -998,7 +1101,8 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 	head = select_bucket(htab, hash);
 
 	/* lookup the key */
-	l = lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_buckets);
+	l = lookup_nulls_elem_raw(head, hash, key, key_size,
+				  htab_has_hash(htab), htab->n_buckets);
 
 	if (!l)
 		goto find_first_elem;
@@ -1041,7 +1145,7 @@ static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
 	check_and_cancel_fields(htab, l);
 
 	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
-		bpf_mem_cache_free(&htab->pcpu_ma, htab_elem_get_ptr_to_pptr(l));
+		bpf_mem_cache_free(&htab->pcpu_ma, htab_elem_get_ptr_to_pptr(htab, l));
 	bpf_mem_cache_free(&htab->ma, htab_elem_container(htab, l));
 }
 
@@ -1209,7 +1313,9 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 		l_new = container + htab->elem_offset;
 	}
 
-	memcpy(l_new->key, key, key_size);
+	if (htab_has_hash(htab))
+		memcpy(l_new->key, key, key_size);
+
 	if (percpu) {
 		if (prealloc) {
 			pptr = htab_elem_get_ptr(l_new, key_size);
@@ -1222,7 +1328,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 				l_new = ERR_PTR(-ENOMEM);
 				goto dec_count;
 			}
-			htab_elem_set_ptr_to_pptr(l_new, ptr);
+			htab_elem_set_ptr_to_pptr(htab, l_new, ptr);
 			pptr = *(void __percpu **)ptr;
 		}
 
@@ -1241,7 +1347,11 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 		copy_map_value(&htab->map, htab_elem_value(l_new, key_size), value);
 	}
 
-	l_new->hash = hash;
+	if (htab_has_hash(htab))
+		htab_elem_set_hash(l_new, hash);
+	else
+		WRITE_ONCE(*(unsigned long *)l_new->key,
+			   htab_zero_extend_key(key, key_size));
 	return l_new;
 dec_count:
 	dec_elem_count(htab);
@@ -1292,6 +1402,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 			return -EINVAL;
 		/* find an element without taking the bucket lock */
 		l_old = lookup_nulls_elem_raw(head, hash, key, key_size,
+					      htab_has_hash(htab),
 					      htab->n_buckets);
 		ret = check_flags(htab, l_old, map_flags);
 		if (ret)
@@ -1313,7 +1424,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	if (ret)
 		return ret;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(head, hash, key, key_size, htab_has_hash(htab));
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1409,7 +1520,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	if (ret)
 		goto err_lock_bucket;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(head, hash, key, key_size, true);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1476,7 +1587,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 	if (ret)
 		return ret;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(head, hash, key, key_size, htab_has_hash(htab));
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1550,7 +1661,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	if (ret)
 		goto err_lock_bucket;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(head, hash, key, key_size, true);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1615,7 +1726,7 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
 	if (ret)
 		return ret;
 
-	l = lookup_elem_raw(head, hash, key, key_size);
+	l = lookup_elem_raw(head, hash, key, key_size, htab_has_hash(htab));
 	if (l)
 		hlist_nulls_del_rcu(&l->hash_node);
 	else
@@ -1650,7 +1761,7 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 	if (ret)
 		return ret;
 
-	l = lookup_elem_raw(head, hash, key, key_size);
+	l = lookup_elem_raw(head, hash, key, key_size, true);
 
 	if (l)
 		hlist_nulls_del_rcu(&l->hash_node);
@@ -1791,7 +1902,7 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 	if (ret)
 		return ret;
 
-	l = lookup_elem_raw(head, hash, key, key_size);
+	l = lookup_elem_raw(head, hash, key, key_size, htab_has_hash(htab));
 	if (!l) {
 		ret = -ENOENT;
 		goto out_unlock;
@@ -2977,18 +3088,6 @@ static int rhtab_map_alloc_check(union bpf_attr *attr)
 	return htab_map_alloc_check(attr);
 }
 
-static void rhtab_mem_dtor(void *obj, void *ctx)
-{
-	struct htab_btf_record *hrec = ctx;
-	struct rhtab_elem *elem = obj;
-
-	if (IS_ERR_OR_NULL(hrec->record))
-		return;
-
-	bpf_obj_free_fields(hrec->record,
-			    rhtab_elem_value(elem, hrec->key_size));
-}
-
 static void rhtab_free_elem(void *ptr, void *arg)
 {
 	struct bpf_rhtab *rhtab = arg;
@@ -3214,7 +3313,9 @@ static int rhtab_map_check_btf(struct bpf_map *map, const struct btf *btf,
 	if (btf_type_is_void(key_type))
 		return -EINVAL;
 
-	return bpf_ma_set_dtor(map, &rhtab->ma, rhtab_mem_dtor);
+	return bpf_ma_set_dtor(map, &rhtab->ma, htab_mem_dtor,
+			       offsetof(struct rhtab_elem, data) +
+			       round_up(map->key_size, 8));
 }
 
 static void rhtab_map_free_internal_structs(struct bpf_map *map)
diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
index f71be4fc8dd7..6bd4cb68c20c 100644
--- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
+++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
@@ -114,7 +114,7 @@ static inline int check_hash(void)
 	VERIFY(check_default_noinline(&hash->map, map));
 
 	VERIFY(hash->n_buckets == MAX_ENTRIES);
-	VERIFY(hash->elem_size == 40);
+	VERIFY(hash->elem_size == 32);
 
 	VERIFY(hash->count.counter == 0);
 	VERIFY(bpf_map_sum_elem_count(map) == 0);
-- 
2.56.0.385.gd3acb90ef8-goog

