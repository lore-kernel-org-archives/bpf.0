Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527754EFFB5
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790957882; cv=none; b=DE3UTtP3aw6u+cuUTsTku5mRyKeOEFq+fqLLN7q8FzGISibl4vIRIlQf8wfqwRAOYgusFUKhY4G2cZ9wJt6V77zckiMZSpJogvwpJvOQYndh6s576uJ1IZMrYR4YrMhEAlwlQoCQVtDWpN3yH+0ziNsTedjGovVSpC5Uw8VJfQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790957882; c=relaxed/simple;
	bh=tZIzMmShoqmFz0fnJEYNQDc6hq/NeyheH7i+AKKgxV4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lefJ19Ax8tyLPntp7j0n2SLZHDm6q9oQZ9RSMXjUc5zCwkjkdUgkhQi9H/fbBmDnAx3lV3WBIWQBJca4LxmoXHyY1dhU98S0Svilzp1XxyTOhFoDZBdQQU8476dfrvGx352GnpjRJwi01ipQtjWMZDk3c/2E3SNmwHnG93UEcf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IOb1Jm+y; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IOb1Jm+y"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2df375fb9b2so80735955ad.2
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 09:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790957880; x=1791562680; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8bnhNvlKHjFuGwUe30ZEzKwfq8NERsW7PIfkiupCRaY=;
        b=IOb1Jm+yTiBeJJRjRaMXFNSSOSKosPn9HDu3JND4xSqOtJYmYhEqCt6+MEf4SOoCmf
         qFZbt9cj4lpX8uZcji/6XyCb5X+HTinzK9Q6dtPXcKVRaZvef39Rsec3NNXAPkNaAw1e
         GNivs04rMCBoFr4mNGf+l6mmOnsoIXd8wUixtzz5uqFKRJ4fEzImj50cKPx2aaVuirNe
         QGGOetObc7wBaHT8bNL6POMnOAPu/shRBppStoSU4LZ7Ys8UmxkZbGRzTz3u63ddE+dj
         QSc3klJToJSk290jzWDuI3GhCxb/SxnUJVvkm2rbt45OS5kCHd4joqIp/GzIo0DfRK8O
         xknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790957880; x=1791562680;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8bnhNvlKHjFuGwUe30ZEzKwfq8NERsW7PIfkiupCRaY=;
        b=nWCtphMEN5eB7yEf187ow5RDU9f4xH/kJJWTp0VnKbHZMAhakJsZpItjp3uKbjfg2I
         oQkg7jbuNs3knv44xCWqmjPXYXFCWWaeWp0VUI+w3/ZmBOEwmBOTZ6kqOWTFul03JDym
         TH0/gkC/2SC0dzTSGR6N4MRex5L5v1Rf35VP03C/uhmECu64HKFF1hjSNT/qtyuab+5u
         x7d+hD8xniYuwnTIhjnwYvtWTMyfUajv8qnMgxpFwONgERTBLA1ggD/xbhVyQr6cfeVY
         AgTCV+AH4um1DHokiO03LPGm95OXW6TjW90ECqtN7BLv2Ao00d6yHdx+M5gMesThlGgn
         h8Dg==
X-Gm-Message-State: AFq9FYLF6edVxUUoSjoWIRClPwDeFdy2CzgpJ88nrLLf6fKTvOZbaord
	C/eCUf8Yj18p9v2uJmbnbACymuKeMdD3D5gffUgcOPTtaLscsaoImth7ybeUFJkAnhfJcaw1sHg
	kjjx7Ad+iLmI23bojfA==
X-Received: from pljg12.prod.google.com ([2002:a17:902:fe0c:b0:2df:3fbc:513a])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:da89:b0:2e1:530b:d890 with SMTP id d9443c01a7336-2e499f09e52mr33132055ad.5.1790957879396;
 Fri, 02 Oct 2026 09:17:59 -0700 (PDT)
Date: Fri,  2 Oct 2026 09:17:35 -0700
In-Reply-To: <20261002161738.621133-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261002161738.621133-1-tjmercier@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002161738.621133-3-tjmercier@google.com>
Subject: [PATCH bpf-next v8 2/2] bpf: htab: Reduce elem_size by 8 bytes for
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
the end of alloc_htab_elem() where the hash assignment was done.

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
 kernel/bpf/hashtab.c                          | 192 ++++++++++++------
 .../selftests/bpf/progs/map_ptr_kern.c        |   2 +-
 2 files changed, 136 insertions(+), 58 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 4df6ae1fa722..610e9051e373 100644
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
@@ -118,13 +119,17 @@ struct htab_elem {
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
@@ -137,9 +142,22 @@ struct htab_elem_pcpu {
 	struct htab_elem elem;
 };
 
+/*
+ * Only for non-preallocated PCPU maps. Preallocated PCPU maps don't need
+ * ptr_to_pptr, and use htab_elem_hashed.
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
-	u32 key_size;
+	u32 value_offset;
 };
 
 static inline bool htab_is_prealloc(const struct bpf_htab *htab)
@@ -194,19 +212,39 @@ static inline bool is_fd_htab(const struct bpf_htab *htab)
 	return htab->map.map_type == BPF_MAP_TYPE_HASH_OF_MAPS;
 }
 
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
+				       void *ptr)
 {
-	container_of(l, struct htab_elem_pcpu, elem)->ptr_to_pptr = ptr;
+	struct htab_elem_pcpu *pcpu_elem = htab_elem_container(htab, l);
+
+	pcpu_elem->ptr_to_pptr = ptr;
 }
 
 static struct bpf_lru_node *htab_elem_lru_node(struct htab_elem *l)
@@ -380,7 +418,7 @@ static int prealloc_init(struct bpf_htab *htab)
 	if (htab_is_lru(htab))
 		err = bpf_lru_init(&htab->lru,
 				   htab->map.map_flags & BPF_F_NO_COMMON_LRU,
-				   offsetof(struct htab_elem_lru, elem.hash) -
+				   offsetof(struct htab_elem_lru, hash) -
 				   offsetof(struct htab_elem_lru, lru_node),
 				   htab_lru_map_delete_node,
 				   htab);
@@ -502,14 +540,11 @@ static int htab_map_alloc_check(union bpf_attr *attr)
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
@@ -534,7 +569,7 @@ static void htab_dtor_ctx_free(void *ctx)
 }
 
 static int bpf_ma_set_dtor(struct bpf_map *map, struct bpf_mem_alloc *ma,
-			   void (*dtor)(void *, void *))
+			   void (*dtor)(void *, void *), u32 value_offset)
 {
 	struct htab_btf_record *hrec;
 	int err;
@@ -546,7 +581,7 @@ static int bpf_ma_set_dtor(struct bpf_map *map, struct bpf_mem_alloc *ma,
 	hrec = kzalloc_obj(*hrec);
 	if (!hrec)
 		return -ENOMEM;
-	hrec->key_size = map->key_size;
+	hrec->value_offset = value_offset;
 	hrec->record = btf_record_dup(map->record);
 	if (IS_ERR(hrec->record)) {
 		err = PTR_ERR(hrec->record);
@@ -572,9 +607,12 @@ static int htab_map_check_btf(struct bpf_map *map, const struct btf *btf,
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
@@ -597,6 +635,14 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 
 	bpf_map_init_from_attr(&htab->map, attr);
 
+	/*
+	 * Avoid hash memory use and comparisons where unnecessary.
+	 * u32 hash reads are always atomic. If we elide them, key comparisons must also be atomic
+	 * to avoid false positive key matches due to torn key reads / writes. This is only possible
+	 * when the key fits within a word, so check key_size.
+	 */
+	htab->has_hash = htab_is_lru(htab) || htab->map.key_size > sizeof(unsigned long);
+
 	if (percpu_lru) {
 		/* ensure each CPU's lru list has >=1 elements.
 		 * since we are at it, make each lru list has the same
@@ -621,7 +667,11 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
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
@@ -739,35 +789,60 @@ static inline struct hlist_nulls_head *select_bucket(struct bpf_htab *htab, u32
 	return &__select_bucket(htab, hash)->head;
 }
 
-/* this lookup function can only be called with bucket lock taken */
-static struct htab_elem *lookup_elem_raw(struct hlist_nulls_head *head, u32 hash,
-					 void *key, u32 key_size)
+static __always_inline struct htab_elem *
+__lookup_elem_raw(struct bpf_htab *htab, struct hlist_nulls_head *head,
+		  u32 hash, void *key, u32 key_size,
+		  struct hlist_nulls_node **out_n)
 {
 	struct hlist_nulls_node *n;
 	struct htab_elem *l;
 
-	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
-		if (l->hash == hash && !memcmp(&l->key, key, key_size))
-			return l;
+	if (htab_has_hash(htab)) {
+		hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
+			if (htab_elem_hash(l) == hash &&
+			    !memcmp(&l->key, key, key_size))
+				return l;
+	} else {
+		/*
+		 * When hash is omitted, key comparisons must be atomic. Zero extend
+		 * the caller's key to the word size to support an atomic compare.
+		 */
+		unsigned long k = 0;
+
+		memcpy(&k, key, key_size);
+		hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
+			if (READ_ONCE(*(unsigned long *)l->key) == k)
+				return l;
+	}
 
+	if (out_n)
+		*out_n = n;
 	return NULL;
 }
 
+/* this lookup function can only be called with bucket lock taken */
+static __always_inline struct htab_elem *
+lookup_elem_raw(struct bpf_htab *htab, struct hlist_nulls_head *head, u32 hash,
+		void *key, u32 key_size)
+{
+	return __lookup_elem_raw(htab, head, hash, key, key_size, NULL);
+}
+
 /* can be called without bucket lock. it will repeat the loop in
  * the unlikely event when elements moved from one bucket into another
  * while link list is being walked
  */
-static __always_inline struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head *head,
-							       u32 hash, void *key,
-							       u32 key_size, u32 n_buckets)
+static __always_inline struct htab_elem *
+lookup_nulls_elem_raw(struct bpf_htab *htab, struct hlist_nulls_head *head,
+		      u32 hash, void *key, u32 key_size, u32 n_buckets)
 {
 	struct hlist_nulls_node *n;
 	struct htab_elem *l;
 
 again:
-	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
-		if (l->hash == hash && !memcmp(&l->key, key, key_size))
-			return l;
+	l = __lookup_elem_raw(htab, head, hash, key, key_size, &n);
+	if (l)
+		return l;
 
 	if (unlikely(get_nulls_value(n) != (hash & (n_buckets - 1))))
 		goto again;
@@ -788,7 +863,7 @@ static __always_inline void *__htab_lookup(struct bpf_map *map, void *key, u32 k
 
 	head = select_bucket(htab, hash);
 
-	l = lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_buckets);
+	l = lookup_nulls_elem_raw(htab, head, hash, key, key_size, htab->n_buckets);
 
 	return l;
 }
@@ -941,7 +1016,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 	int ret;
 
 	tgt_l = container_of(node, struct htab_elem_lru, lru_node);
-	b = __select_bucket(htab, tgt_l->elem.hash);
+	b = __select_bucket(htab, tgt_l->hash);
 	head = &b->head;
 
 	ret = htab_lock_bucket(b, &flags);
@@ -983,7 +1058,7 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 	head = select_bucket(htab, hash);
 
 	/* lookup the key */
-	l = lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_buckets);
+	l = lookup_nulls_elem_raw(htab, head, hash, key, key_size, htab->n_buckets);
 
 	if (!l)
 		goto find_first_elem;
@@ -1026,7 +1101,7 @@ static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
 	check_and_cancel_fields(htab, l);
 
 	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
-		bpf_mem_cache_free(&htab->pcpu_ma, htab_elem_get_ptr_to_pptr(l));
+		bpf_mem_cache_free(&htab->pcpu_ma, htab_elem_get_ptr_to_pptr(htab, l));
 	bpf_mem_cache_free(&htab->ma, htab_elem_container(htab, l));
 }
 
@@ -1194,7 +1269,9 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 		l_new = container + htab->elem_offset;
 	}
 
-	memcpy(l_new->key, key, key_size);
+	if (htab_has_hash(htab))
+		memcpy(l_new->key, key, key_size);
+
 	if (percpu) {
 		if (prealloc) {
 			pptr = htab_elem_get_ptr(l_new, key_size);
@@ -1207,7 +1284,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 				l_new = ERR_PTR(-ENOMEM);
 				goto dec_count;
 			}
-			htab_elem_set_ptr_to_pptr(l_new, ptr);
+			htab_elem_set_ptr_to_pptr(htab, l_new, ptr);
 			pptr = *(void __percpu **)ptr;
 		}
 
@@ -1226,7 +1303,18 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 		copy_map_value(&htab->map, htab_elem_value(l_new, key_size), value);
 	}
 
-	l_new->hash = hash;
+	if (htab_has_hash(htab)) {
+		htab_elem_set_hash(l_new, hash);
+	} else {
+		/*
+		 * Zero-extend key into k for an atomic write to support
+		 * lockless RCU readers.
+		 */
+		unsigned long k = 0;
+
+		memcpy(&k, key, key_size);
+		WRITE_ONCE(*(unsigned long *)l_new->key, k);
+	}
 	return l_new;
 dec_count:
 	dec_elem_count(htab);
@@ -1276,7 +1364,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		if (unlikely(!btf_record_has_field(map->record, BPF_SPIN_LOCK)))
 			return -EINVAL;
 		/* find an element without taking the bucket lock */
-		l_old = lookup_nulls_elem_raw(head, hash, key, key_size,
+		l_old = lookup_nulls_elem_raw(htab, head, hash, key, key_size,
 					      htab->n_buckets);
 		ret = check_flags(htab, l_old, map_flags);
 		if (ret)
@@ -1298,7 +1386,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	if (ret)
 		return ret;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(htab, head, hash, key, key_size);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1394,7 +1482,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	if (ret)
 		goto err_lock_bucket;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(htab, head, hash, key, key_size);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1461,7 +1549,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 	if (ret)
 		return ret;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(htab, head, hash, key, key_size);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1535,7 +1623,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	if (ret)
 		goto err_lock_bucket;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(htab, head, hash, key, key_size);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1600,7 +1688,7 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
 	if (ret)
 		return ret;
 
-	l = lookup_elem_raw(head, hash, key, key_size);
+	l = lookup_elem_raw(htab, head, hash, key, key_size);
 	if (l)
 		hlist_nulls_del_rcu(&l->hash_node);
 	else
@@ -1635,7 +1723,7 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 	if (ret)
 		return ret;
 
-	l = lookup_elem_raw(head, hash, key, key_size);
+	l = lookup_elem_raw(htab, head, hash, key, key_size);
 
 	if (l)
 		hlist_nulls_del_rcu(&l->hash_node);
@@ -1776,7 +1864,7 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 	if (ret)
 		return ret;
 
-	l = lookup_elem_raw(head, hash, key, key_size);
+	l = lookup_elem_raw(htab, head, hash, key, key_size);
 	if (!l) {
 		ret = -ENOENT;
 		goto out_unlock;
@@ -2962,18 +3050,6 @@ static int rhtab_map_alloc_check(union bpf_attr *attr)
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
@@ -3199,7 +3275,9 @@ static int rhtab_map_check_btf(struct bpf_map *map, const struct btf *btf,
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
2.56.0.rc1.315.gc6ed9934b7-goog

