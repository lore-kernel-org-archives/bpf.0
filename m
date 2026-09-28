Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4DB3B71A1
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 06:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577641; cv=none; b=qWoQE3ytDfPJtZ65NQJ14peS0MSdeALxSbT7bfDTCJWu/wQQsDiwN3ySX+gEalZnevY71ioef42b+ozae9kqYKGfLNOS1yxyhfALSbc3yf1bq6/Tr+rIYBQ6sUVAUz4ILgq9I2u5rOlq3likxr/xLBtrX1HKeKxUj5ikV0cpGe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577641; c=relaxed/simple;
	bh=ojDJAY3bcG/X3nf8u0o/nKHnGf9i94fk4eK+96fGlXw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gTbiyely4VfCgRd+yuboklW0qmnkZQKd5tkTqQeQW+MbNXfRbwcV0eKV/Mfca2XFj6NWsSG2WpKJq44YFScWd0RIDD087unXtNdDxUicfQqViaWXkf/ewn5I4FVwSAlu/3WdKcCO8BwN/TutdVhDHX2sBGZFiUDSBdz6eSuTaGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XE7au7kD; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XE7au7kD"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a470ead068so381882a91.3
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 23:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790577639; x=1791182439; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LnGHEFfRdf6hbyzCjyKE2Z66OV3nekss4U33/7J/Xz8=;
        b=XE7au7kDPpvmbeCSKV3CIs6sP+BFkW1mrflb6g3zCFu1Wh/E35W3QYtNUWaZj3Ly3g
         DRUVsnNszmLciGtfcDeo09ac1NPjhoD895HJa0a28cNOeNrJE8KseARyWquIvTk4Lck/
         O6kZ6rVnsueaGKGOrc79oh2rtVdzlrgIaUc8+Mc7uxQXO0vILA68XnBCFgjTl7pqtHuG
         e+kDzib6ivQTYSvEvhgupgLqUa1j34EdyybFPOc5t1U983+jpf91ws/kv/pJtwRsjoun
         ZBW+xNgLdij3tE02t6rZRKh4tczSGF/Jn7QIW5Mda7AlNh+EBd3z071nJ5KjNMq0HFO2
         jfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790577639; x=1791182439;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LnGHEFfRdf6hbyzCjyKE2Z66OV3nekss4U33/7J/Xz8=;
        b=OiASsifXffTs0ckyX7q3+v+5O7v+uMWcdeNksEqoVT2I5PnH5CzvQMvFBe7RbQnKSF
         abllh5excwcNjpsHOOEmglmHd9KUPY1m65ixG29DQb2i82M2yCPB47VsE1ChTaCjBca7
         KM+WqtvhUBQagZGXBwERKYHlygvNcVnFFXJTEG7b9CAkuDDGPaGg/m6jZ9MVxc3bN01E
         Ap8tyk+9GDpnFwuYvx/24obaYcfZroOSuX91doFjZKofy0iF0LRqz6Xe0AY2cPNwe5mc
         Rm9qhEwbCQp0GddsrCfCToo4wQLh5b71uVnlSERdjqQzSKxGoIcQOl8eVf+A+tMOR95x
         SmQg==
X-Gm-Message-State: AFq9FYJ2BeHs4Uaj6F6t+yXZLUoOK5Xifp37Gy/uEDMTT2mkJX/vJkNB
	S/iYlf/6sqqQ7GHpYOIF+2UqFAAFhaSY4htnRY9oDExGuWxdD/TPCckEn7Q+J6AQ4sO3DuohJAy
	kKx7WBc2huJiNUi3H0w==
X-Received: from plcx17.prod.google.com ([2002:a17:903:d1:b0:2df:5c69:498c])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:fdad:b0:2dd:c100:7cb7 with SMTP id d9443c01a7336-2df7dc560camr105129235ad.51.1790577638529;
 Sun, 27 Sep 2026 23:40:38 -0700 (PDT)
Date: Sun, 27 Sep 2026 23:40:19 -0700
In-Reply-To: <20260928064021.1433277-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928064021.1433277-1-tjmercier@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928064021.1433277-3-tjmercier@google.com>
Subject: [PATCH bpf-next v6 2/2] bpf: htab: Reduce elem_size by 8 bytes for
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
index 847a53e6407a..0b298fd026be 100644
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
 
 static inline void *htab_elem_value(struct htab_elem *l, u32 key_size)
@@ -375,7 +413,7 @@ static int prealloc_init(struct bpf_htab *htab)
 	if (htab_is_lru(htab))
 		err = bpf_lru_init(&htab->lru,
 				   htab->map.map_flags & BPF_F_NO_COMMON_LRU,
-				   offsetof(struct htab_elem_lru, elem.hash) -
+				   offsetof(struct htab_elem_lru, hash) -
 				   offsetof(struct htab_elem_lru, lru_node),
 				   htab_lru_map_delete_node,
 				   htab);
@@ -497,14 +535,11 @@ static int htab_map_alloc_check(union bpf_attr *attr)
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
@@ -529,7 +564,7 @@ static void htab_dtor_ctx_free(void *ctx)
 }
 
 static int bpf_ma_set_dtor(struct bpf_map *map, struct bpf_mem_alloc *ma,
-			   void (*dtor)(void *, void *))
+			   void (*dtor)(void *, void *), u32 value_offset)
 {
 	struct htab_btf_record *hrec;
 	int err;
@@ -541,7 +576,7 @@ static int bpf_ma_set_dtor(struct bpf_map *map, struct bpf_mem_alloc *ma,
 	hrec = kzalloc_obj(*hrec);
 	if (!hrec)
 		return -ENOMEM;
-	hrec->key_size = map->key_size;
+	hrec->value_offset = value_offset;
 	hrec->record = btf_record_dup(map->record);
 	if (IS_ERR(hrec->record)) {
 		err = PTR_ERR(hrec->record);
@@ -567,9 +602,12 @@ static int htab_map_check_btf(struct bpf_map *map, const struct btf *btf,
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
@@ -592,6 +630,14 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 
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
@@ -616,7 +662,11 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
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
@@ -727,35 +777,60 @@ static inline struct hlist_nulls_head *select_bucket(struct bpf_htab *htab, u32
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
-static struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head *head,
-					       u32 hash, void *key,
-					       u32 key_size, u32 n_buckets)
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
@@ -783,7 +858,7 @@ static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
 
 	head = select_bucket(htab, hash);
 
-	l = lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_buckets);
+	l = lookup_nulls_elem_raw(htab, head, hash, key, key_size, htab->n_buckets);
 
 	return l;
 }
@@ -909,7 +984,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 	int ret;
 
 	tgt_l = container_of(node, struct htab_elem_lru, lru_node);
-	b = __select_bucket(htab, tgt_l->elem.hash);
+	b = __select_bucket(htab, tgt_l->hash);
 	head = &b->head;
 
 	ret = htab_lock_bucket(b, &flags);
@@ -951,7 +1026,7 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 	head = select_bucket(htab, hash);
 
 	/* lookup the key */
-	l = lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_buckets);
+	l = lookup_nulls_elem_raw(htab, head, hash, key, key_size, htab->n_buckets);
 
 	if (!l)
 		goto find_first_elem;
@@ -994,7 +1069,7 @@ static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
 	check_and_cancel_fields(htab, l);
 
 	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
-		bpf_mem_cache_free(&htab->pcpu_ma, htab_elem_get_ptr_to_pptr(l));
+		bpf_mem_cache_free(&htab->pcpu_ma, htab_elem_get_ptr_to_pptr(htab, l));
 	bpf_mem_cache_free(&htab->ma, htab_elem_container(htab, l));
 }
 
@@ -1159,7 +1234,9 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 		l_new = container + htab->elem_offset;
 	}
 
-	memcpy(l_new->key, key, key_size);
+	if (htab_has_hash(htab))
+		memcpy(l_new->key, key, key_size);
+
 	if (percpu) {
 		if (prealloc) {
 			pptr = htab_elem_get_ptr(l_new, key_size);
@@ -1172,7 +1249,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 				l_new = ERR_PTR(-ENOMEM);
 				goto dec_count;
 			}
-			htab_elem_set_ptr_to_pptr(l_new, ptr);
+			htab_elem_set_ptr_to_pptr(htab, l_new, ptr);
 			pptr = *(void __percpu **)ptr;
 		}
 
@@ -1191,7 +1268,18 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
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
@@ -1241,7 +1329,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		if (unlikely(!btf_record_has_field(map->record, BPF_SPIN_LOCK)))
 			return -EINVAL;
 		/* find an element without taking the bucket lock */
-		l_old = lookup_nulls_elem_raw(head, hash, key, key_size,
+		l_old = lookup_nulls_elem_raw(htab, head, hash, key, key_size,
 					      htab->n_buckets);
 		ret = check_flags(htab, l_old, map_flags);
 		if (ret)
@@ -1263,7 +1351,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	if (ret)
 		return ret;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(htab, head, hash, key, key_size);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1361,7 +1449,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	if (ret)
 		goto err_lock_bucket;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(htab, head, hash, key, key_size);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1428,7 +1516,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 	if (ret)
 		return ret;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(htab, head, hash, key, key_size);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1502,7 +1590,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	if (ret)
 		goto err_lock_bucket;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(htab, head, hash, key, key_size);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1570,7 +1658,7 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
 	if (ret)
 		return ret;
 
-	l = lookup_elem_raw(head, hash, key, key_size);
+	l = lookup_elem_raw(htab, head, hash, key, key_size);
 	if (l)
 		hlist_nulls_del_rcu(&l->hash_node);
 	else
@@ -1605,7 +1693,7 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 	if (ret)
 		return ret;
 
-	l = lookup_elem_raw(head, hash, key, key_size);
+	l = lookup_elem_raw(htab, head, hash, key, key_size);
 
 	if (l)
 		hlist_nulls_del_rcu(&l->hash_node);
@@ -1746,7 +1834,7 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 	if (ret)
 		return ret;
 
-	l = lookup_elem_raw(head, hash, key, key_size);
+	l = lookup_elem_raw(htab, head, hash, key, key_size);
 	if (!l) {
 		ret = -ENOENT;
 		goto out_unlock;
@@ -2920,18 +3008,6 @@ static int rhtab_map_alloc_check(union bpf_attr *attr)
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
@@ -3157,7 +3233,9 @@ static int rhtab_map_check_btf(struct bpf_map *map, const struct btf *btf,
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

