Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F70282F2A
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 00:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789950144; cv=none; b=QA72XwwOQbkWhP7tyubQWCa+9URw9vLW7xHs0S/6bQxIT83j/WmxdGRhHvcQrqeCBRNg1iy8phTvJHu6bo3xmh65V3KY2vxndNui3SYDZ+KoyNmsCG776+ndzyPAO0LGKa/erkg61PO9tIB6Ud5/D13LuA5Nw2Cfo5qzLhaMBCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789950144; c=relaxed/simple;
	bh=0U9q105QAinJ0FgOptzqZa4yP4E6e0fs6WD6rmMea5M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=odmZz7AOxjPyXXMwAY9mv41ck6B/XHXGdRzAlM6djXVMwRdu2KZZAwpRpRG9Psj62trC+E4+9tjxaqOtWLp9+Y/qMTmmtDDktCl/+MTlFiUHnIeOIzMTsmWfB1DrwPE+xZJPwEbMwbWLEw0ctoSMrrHzkDN4VCTh9FBK5JPUOhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pYm2U821; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pYm2U821"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2dd753a52bbso47126535ad.0
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 17:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789950142; x=1790554942; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=agijlrmp35jubqCojdz0yntMhx9bktHHpfPZPPCv7PU=;
        b=pYm2U821UYxeyYig8vZX3VqG5eLp/fvZbQrf5nCGRLXtvN1/irVfbJG0uKCA6TwvK1
         Ov5BktKkkJ6jfNYWjGsD/GBrljTpOewj39dEOAIi/8wxZLF8g4icGVvQ2TILgo49bSmB
         N/NEcy390F9mrahD051fo8WhuwW+OoHDndXiX/rsNrOJMXTcTNUqqJ5NUpvIa2BHW1nS
         UaMcNscWO7UmtmZu6tOn3UKNXznnsF3r3XNbRlDws0Irjc1KOuVTVgWMW4KaIr977+vt
         EcrkYFzCYl44fR/Kgy1mAnCDKloYDOE8zYoG/Sf2G6w/oqtOtewrlL7BRjy1PtD25+Wf
         LNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789950142; x=1790554942;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=agijlrmp35jubqCojdz0yntMhx9bktHHpfPZPPCv7PU=;
        b=KXSpr/qzjZaxIRYAHkLO4HnE2oY3yMDv1bQCcaRGxRXbFLJlg9VIL6oBPQyGOViLtc
         rNPes6Nu2hoIbQa7gQEmHivwzbXlPzCbDVhjujorzneBSNS61KociXY0OX885AwSxp+P
         l/NCqvAcyTvL8IQwa8Ro1Cw/qQ7R+VG284AixJOMERkATHoQY1BZm7fWJ+woc4z5lgos
         cE0bXQy8fOEpomW0qqa9tG10IyEfpirCxtyoh+i4gXLsr2T6cSJw2BW1TOJkiKllW+b9
         j0m//mUrmocRkq+Jx5MuV5Ly1MC2qsKilKqGrtcCHeQ8S/TIheslyr1rc7syu7kGfrCJ
         r18A==
X-Gm-Message-State: AFuF++klBg0Qm4+o4q1yFwGFXvz55rrxRB+iBPPAwVAne8R7dUHutL8j
	G/7e8h3wwmmllABuMVicIMtWPUz8kIDJYzrpMJs0hbq2mJzSmBZUYrwbW9xGjFK3t+f4GI6CcO2
	cMcogHJaUMGnZXp0zJA==
X-Received: from ploc3.prod.google.com ([2002:a17:902:8483:b0:2dd:fc2:99fe])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:8496:b0:2dd:c053:a6f6 with SMTP id d9443c01a7336-2ddc053a766mr54092725ad.40.1789950141702;
 Sun, 20 Sep 2026 17:22:21 -0700 (PDT)
Date: Sun, 20 Sep 2026 17:22:04 -0700
In-Reply-To: <20260921002206.184660-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921002206.184660-1-tjmercier@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921002206.184660-3-tjmercier@google.com>
Subject: [PATCH bpf-next v5 2/2] bpf: htab: Reduce elem_size by 8 bytes for
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
the end of alloc_htab_elem() (where the hash assignment was done) behind
a write memory barrier.

For recycled elements, keeping the old key until the new value is
written slightly widens the existing window where a lockless lookup
racing with a deletion of the old key can observe the recycled element's
new value.

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
 kernel/bpf/hashtab.c                          | 209 +++++++++++++-----
 .../selftests/bpf/progs/map_ptr_kern.c        |   2 +-
 2 files changed, 153 insertions(+), 58 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 905bddadf37f..5e916ccb53e0 100644
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
@@ -136,15 +141,29 @@ struct htab_elem_pcpu {
 	struct htab_elem elem;
 };
 
+/*
+ * Only for non-preallocated PCPU maps. Preallocated PCPU maps don't need
+ * ptr_to_pptr, and use htab_elem_hashed.
+ */
+struct htab_elem_pcpu_hashed {
+	void *ptr_to_pptr;
+	struct htab_elem_hashed;
+};
+
+static_assert(offsetof(struct htab_elem_pcpu_hashed, ptr_to_pptr) ==
+	      offsetof(struct htab_elem_pcpu, ptr_to_pptr));
+
 union htab_elem_all {
 	struct htab_elem elem;
+	struct htab_elem_hashed hashed;
 	struct htab_elem_lru lru;
 	struct htab_elem_pcpu pcpu;
+	struct htab_elem_pcpu_hashed pcpu_hashed;
 };
 
 struct htab_btf_record {
 	struct btf_record *record;
-	u32 key_size;
+	u32 value_offset;
 };
 
 static inline bool htab_is_prealloc(const struct bpf_htab *htab)
@@ -199,19 +218,40 @@ static inline bool is_fd_htab(const struct bpf_htab *htab)
 	return htab->map.map_type == BPF_MAP_TYPE_HASH_OF_MAPS;
 }
 
+static bool htab_has_hash(const struct bpf_htab *htab)
+{
+	return htab->has_hash;
+}
+
+static u32 htab_elem_hash(struct htab_elem *l)
+{
+	return READ_ONCE(container_of(l, struct htab_elem_hashed, elem)->hash);
+}
+
+static void htab_elem_set_hash(struct bpf_htab *htab, struct htab_elem *l, u32 hash)
+{
+	if (htab_has_hash(htab))
+		WRITE_ONCE(container_of(l, struct htab_elem_hashed, elem)->hash, hash);
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
@@ -380,7 +420,7 @@ static int prealloc_init(struct bpf_htab *htab)
 	if (htab_is_lru(htab))
 		err = bpf_lru_init(&htab->lru,
 				   htab->map.map_flags & BPF_F_NO_COMMON_LRU,
-				   offsetof(struct htab_elem_lru, elem.hash) -
+				   offsetof(struct htab_elem_lru, hash) -
 				   offsetof(struct htab_elem_lru, lru_node),
 				   htab_lru_map_delete_node,
 				   htab);
@@ -502,14 +542,11 @@ static int htab_map_alloc_check(union bpf_attr *attr)
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
@@ -534,7 +571,7 @@ static void htab_dtor_ctx_free(void *ctx)
 }
 
 static int bpf_ma_set_dtor(struct bpf_map *map, struct bpf_mem_alloc *ma,
-			   void (*dtor)(void *, void *))
+			   void (*dtor)(void *, void *), u32 value_offset)
 {
 	struct htab_btf_record *hrec;
 	int err;
@@ -546,7 +583,7 @@ static int bpf_ma_set_dtor(struct bpf_map *map, struct bpf_mem_alloc *ma,
 	hrec = kzalloc_obj(*hrec);
 	if (!hrec)
 		return -ENOMEM;
-	hrec->key_size = map->key_size;
+	hrec->value_offset = value_offset;
 	hrec->record = btf_record_dup(map->record);
 	if (IS_ERR(hrec->record)) {
 		err = PTR_ERR(hrec->record);
@@ -572,9 +609,12 @@ static int htab_map_check_btf(struct bpf_map *map, const struct btf *btf,
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
@@ -598,6 +638,14 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 
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
@@ -622,7 +670,11 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	if (htab_is_lru(htab))
 		elem_offset = offsetof(struct htab_elem_lru, elem);
 	else if (percpu && !prealloc)
-		elem_offset = offsetof(struct htab_elem_pcpu, elem);
+		elem_offset = htab_has_hash(htab) ?
+			      offsetof(struct htab_elem_pcpu_hashed, elem) :
+			      offsetof(struct htab_elem_pcpu, elem);
+	else if (htab_has_hash(htab))
+		elem_offset = offsetof(struct htab_elem_hashed, elem);
 
 	BUILD_BUG_ON(elem_offset + sizeof(struct htab_elem) >
 		     sizeof(union htab_elem_all));
@@ -737,35 +789,67 @@ static inline struct hlist_nulls_head *select_bucket(struct bpf_htab *htab, u32
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
+	if (l) {
+		/*
+		 * Pairs with smp_wmb() in alloc_htab_elem() to ensure
+		 * value/pptr reads happen after key/hash match on
+		 * recycled elements.
+		 */
+		smp_rmb();
+		return l;
+	}
 
 	if (unlikely(get_nulls_value(n) != (hash & (n_buckets - 1))))
 		goto again;
@@ -793,7 +877,7 @@ static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
 
 	head = select_bucket(htab, hash);
 
-	l = lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_buckets);
+	l = lookup_nulls_elem_raw(htab, head, hash, key, key_size, htab->n_buckets);
 
 	return l;
 }
@@ -919,7 +1003,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 	int ret;
 
 	tgt_l = container_of(node, struct htab_elem_lru, lru_node);
-	b = __select_bucket(htab, tgt_l->elem.hash);
+	b = __select_bucket(htab, READ_ONCE(tgt_l->hash));
 	head = &b->head;
 
 	ret = htab_lock_bucket(b, &flags);
@@ -961,7 +1045,7 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 	head = select_bucket(htab, hash);
 
 	/* lookup the key */
-	l = lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_buckets);
+	l = lookup_nulls_elem_raw(htab, head, hash, key, key_size, htab->n_buckets);
 
 	if (!l)
 		goto find_first_elem;
@@ -1004,7 +1088,7 @@ static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
 	check_and_cancel_fields(htab, l);
 
 	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
-		bpf_mem_cache_free(&htab->pcpu_ma, htab_elem_get_ptr_to_pptr(l));
+		bpf_mem_cache_free(&htab->pcpu_ma, htab_elem_get_ptr_to_pptr(htab, l));
 	bpf_mem_cache_free(&htab->ma, htab_elem_container(htab, l));
 }
 
@@ -1169,7 +1253,9 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 		l_new = container + htab->elem_offset;
 	}
 
-	memcpy(l_new->key, key, key_size);
+	if (htab_has_hash(htab))
+		memcpy(l_new->key, key, key_size);
+
 	if (percpu) {
 		if (prealloc) {
 			pptr = htab_elem_get_ptr(l_new, key_size);
@@ -1182,7 +1268,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 				l_new = ERR_PTR(-ENOMEM);
 				goto dec_count;
 			}
-			htab_elem_set_ptr_to_pptr(l_new, ptr);
+			htab_elem_set_ptr_to_pptr(htab, l_new, ptr);
 			pptr = *(void __percpu **)ptr;
 		}
 
@@ -1201,7 +1287,26 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 		copy_map_value(&htab->map, htab_elem_value(l_new, key_size), value);
 	}
 
-	l_new->hash = hash;
+	/*
+	 * Order value/pptr initialization before publishing the new hash
+	 * (or the new key when hash is omitted) so lockless RCU readers
+	 * matching the new element never observe uninitialized data or
+	 * a stale pptr.
+	 * Pairs with smp_rmb() in lookup_nulls_elem_raw().
+	 */
+	smp_wmb();
+	if (htab_has_hash(htab)) {
+		htab_elem_set_hash(htab, l_new, hash);
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
@@ -1251,7 +1356,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		if (unlikely(!btf_record_has_field(map->record, BPF_SPIN_LOCK)))
 			return -EINVAL;
 		/* find an element without taking the bucket lock */
-		l_old = lookup_nulls_elem_raw(head, hash, key, key_size,
+		l_old = lookup_nulls_elem_raw(htab, head, hash, key, key_size,
 					      htab->n_buckets);
 		ret = check_flags(htab, l_old, map_flags);
 		if (ret)
@@ -1273,7 +1378,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	if (ret)
 		return ret;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(htab, head, hash, key, key_size);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1371,7 +1476,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	if (ret)
 		goto err_lock_bucket;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(htab, head, hash, key, key_size);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1438,7 +1543,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 	if (ret)
 		return ret;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(htab, head, hash, key, key_size);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1512,7 +1617,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	if (ret)
 		goto err_lock_bucket;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(htab, head, hash, key, key_size);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1580,7 +1685,7 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
 	if (ret)
 		return ret;
 
-	l = lookup_elem_raw(head, hash, key, key_size);
+	l = lookup_elem_raw(htab, head, hash, key, key_size);
 	if (l)
 		hlist_nulls_del_rcu(&l->hash_node);
 	else
@@ -1615,7 +1720,7 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 	if (ret)
 		return ret;
 
-	l = lookup_elem_raw(head, hash, key, key_size);
+	l = lookup_elem_raw(htab, head, hash, key, key_size);
 
 	if (l)
 		hlist_nulls_del_rcu(&l->hash_node);
@@ -1756,7 +1861,7 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 	if (ret)
 		return ret;
 
-	l = lookup_elem_raw(head, hash, key, key_size);
+	l = lookup_elem_raw(htab, head, hash, key, key_size);
 	if (!l) {
 		ret = -ENOENT;
 		goto out_unlock;
@@ -2930,18 +3035,6 @@ static int rhtab_map_alloc_check(union bpf_attr *attr)
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
@@ -3167,7 +3260,9 @@ static int rhtab_map_check_btf(struct bpf_map *map, const struct btf *btf,
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
2.55.0.1082.g2b9226bbc0-goog

