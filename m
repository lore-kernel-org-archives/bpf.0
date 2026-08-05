Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BA33F327B
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785969353; cv=none; b=YZ3ybJhgkey9R1XVdS8gmqrmnjcxQ/Uy3hIroya49NNRhTPgl3VycTkMay0gDm7kOe7tE0LQcaPMMi+Y94/F5fU/jF1PbCkMiLBIOpm70dUs1iqIb2syvAFXcOQS3EilnDIxXduLAIx37ugvXedKVOfXBUZilBSBLwX+rxF+njo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785969353; c=relaxed/simple;
	bh=UysVq0pp7KKE7w+AkVLTb3mgrWyhY9YX+Q9aQExcGSQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tkNKxj0JMa6crozvYOej9qp4mPdrgtJBPH7+7xeXV0Lr3KUVDTgqL7w6HENlsWQRZgbvT1p8fBtdIGIWKZUpUfuJaR+/hg6Se8OF3NPY3G5eeGPAI0g7BpoXFEL04bDDQkxdJaj1H4KGJyZt09Mh6kohTDL8/npjElaR0K4+Rxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L9koGS7D; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L9koGS7D"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cee894b3d8so23626185ad.2
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 15:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785969345; x=1786574145; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YsN729/3NGBB9z+D9zsabMqZm2mSGZqcszcqfW15in0=;
        b=L9koGS7DEl7kVifiJfKvrw5hUqfa8Z5gg3gk31OeproEETMqr85fTmTtHiMVuaKgcA
         zlMsPBAw5+nnTTnz90kpW++mGQY2vf54BKBHrzKgmH+AXG9jCRnry1rGq89nOJG/9yZk
         XHJS9XWu1BJL4zbHfnYnxn14Xqipx8cVUehFJSCzHb3aCnMQQ2lJnhhd7MXsIi1qgRkN
         9JS2j9pZ5giEiokxPPcG/4IujNdOwLE8e2ll2ICXdGiLMHm4yQHE8y2a7Zp32sq5/TYz
         gTqTFpfJ6ysawuNSfvbYzdVrlzK+WzksyH7ktK3Nc+0ya4VXCWsaCXCp8NE58siELoj6
         LBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785969345; x=1786574145;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YsN729/3NGBB9z+D9zsabMqZm2mSGZqcszcqfW15in0=;
        b=aLk6M7yxxnFey6c4jLL6TBoasp13S5ZJH+2LrxvGifI1hsBAqv88iGnpWaazYemRvt
         V/Iv7ZIDPmm6HjkbGeP+RogMmH1PbGR+J/kQDOtQ/FKgcf8c9d+n0kPmgqawarV4wBoM
         gISi1X6ftDrFEYXHUfcnXuFtUsHNT3WRl/fLx7g5Z8xOc8nARPztVSa5Y1Iwf8LWE9IV
         UGpgiKJgp8wrzGrKsp4KhO2k9lnPUTgllTi7u3oNJ4qPcrb5OwKC1RIbD5nuoOOssuKd
         l+gCe+i0MpN2sbnw3a+tHba6RZMU1uy+vsLtiT3HWcYuTEcHCKq9n6Z62vkwqoZ4x6Bd
         KeRA==
X-Gm-Message-State: AOJu0YzJRo2Rfn2fc9IDUgwnsjmVWh85QH4bUghhlhIz4BWwHxuqomaG
	JMEPB130ouMjaj5AAOToB885BADAJTg/dQljKvp1Ru8XBbSZ5O5aecyL/qCUvSYMXsf0Lm35vGq
	YmWxdBPKOrcnU+nBvbw==
X-Received: from plhi14.prod.google.com ([2002:a17:903:2ece:b0:2cf:1f9d:da12])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1b70:b0:2d0:cc92:f7c2 with SMTP id d9443c01a7336-2d0cc930325mr124039155ad.1.1785969345097;
 Wed, 05 Aug 2026 15:35:45 -0700 (PDT)
Date: Wed,  5 Aug 2026 15:35:15 -0700
In-Reply-To: <20260805223516.1495988-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260805223516.1495988-1-tjmercier@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260805223516.1495988-2-tjmercier@google.com>
Subject: [PATCH bpf-next v3 1/2] bpf: htab: Split htab_elem_lru and
 htab_elem_pcpu off of htab_elem
From: "T.J. Mercier" <tjmercier@google.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	mykyta.yatsenko5@gmail.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"

The htab_elem struct is used as the per-element type for all BPF hash
map types and includes bpf_lru_node in a union with a ptr_to_pptr
pointer. For standard (non-LRU, non-PCPU) hash maps, the 24 byte union
allocated for every element is entirely unused. For non-preallocated
PCPU maps, ptr_to_pptr only requires 8 bytes, leaving 16 bytes of unused
overhead in the union. For preallocated PCPU maps ptr_to_pptr is unused
since elements are freed to the PCPU freelist.

Eliminate this per-element memory overhead by splitting htab_elem into
dedicated structures for each map type:
   - struct htab_elem: Minimal structure for standard hash maps and
     preallocated PCPU maps (saves 24 bytes per element).
   - struct htab_elem_pcpu: Structure for non-preallocated PCPU maps
     containing ptr_to_pptr (saves 16 bytes per element).
   - struct htab_elem_lru: Retains struct bpf_lru_node for LRU maps.

Because element sizes now vary by map type, add key_offset to struct
bpf_htab to track the dynamic key offset. Update helper accessors and
lookups to compute key and value offsets using htab->key_offset.

Pointers to struct htab_elem in the existing code (e.g. htab_elem_hash)
serve as generic base element pointers. This is possible because
htab_elem, htab_elem_pcpu, and htab_elem_lru share a common initial
sequence, making pointer casts safe.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 kernel/bpf/hashtab.c    | 362 +++++++++++++++++++++++++---------------
 kernel/bpf/map_in_map.c |  13 ++
 kernel/bpf/map_in_map.h |   2 +
 3 files changed, 242 insertions(+), 135 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 9f394e1aa2e8..f54366da459f 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -102,11 +102,13 @@ struct bpf_htab {
 	bool use_percpu_counter;
 	u32 n_buckets;	/* number of hash buckets */
 	u32 elem_size;	/* size of each element in bytes */
+	u32 key_offset;	/* offset of key in bytes */
 	u32 hashrnd;
 };
 
 /* each htab element is struct htab_elem + key + value */
-struct htab_elem {
+struct htab_elem;
+struct htab_node {
 	union {
 		struct hlist_nulls_node hash_node;
 		struct {
@@ -117,11 +119,27 @@ struct htab_elem {
 			};
 		};
 	};
-	union {
-		/* pointer to per-cpu pointer */
-		void *ptr_to_pptr;
-		struct bpf_lru_node lru_node;
-	};
+};
+
+struct htab_elem {
+	struct htab_node node;
+	u32 hash;
+	char key[] __aligned(8);
+};
+
+struct htab_elem_lru {
+	struct htab_node node;
+	struct bpf_lru_node lru_node;
+	u32 hash;
+	char key[] __aligned(8);
+};
+
+/* Only for non-preallocated PCPU maps. Preallocated PCPU maps don't need
+ * ptr_to_pptr, and use htab_elem.
+ */
+struct htab_elem_pcpu {
+	struct htab_node node;
+	void *ptr_to_pptr;
 	u32 hash;
 	char key[] __aligned(8);
 };
@@ -136,6 +154,21 @@ static inline bool htab_is_prealloc(const struct bpf_htab *htab)
 	return !(htab->map.map_flags & BPF_F_NO_PREALLOC);
 }
 
+static inline struct bpf_lru_node *htab_elem_lru_node(struct htab_elem *l)
+{
+	return &((struct htab_elem_lru *)l)->lru_node;
+}
+
+static inline void *htab_elem_get_ptr_to_pptr(struct htab_elem *l)
+{
+	return ((struct htab_elem_pcpu *)l)->ptr_to_pptr;
+}
+
+static inline void htab_elem_set_ptr_to_pptr(struct htab_elem *l, void *ptr)
+{
+	((struct htab_elem_pcpu *)l)->ptr_to_pptr = ptr;
+}
+
 static void htab_init_buckets(struct bpf_htab *htab)
 {
 	unsigned int i;
@@ -183,25 +216,30 @@ static inline bool is_fd_htab(const struct bpf_htab *htab)
 	return htab->map.map_type == BPF_MAP_TYPE_HASH_OF_MAPS;
 }
 
-static inline void *htab_elem_value(struct htab_elem *l, u32 key_size)
+static inline void *htab_elem_key(struct bpf_htab *htab, struct htab_elem *l)
+{
+	return (void *)l + htab->key_offset;
+}
+
+static inline void *htab_elem_value(struct bpf_htab *htab, struct htab_elem *l)
 {
-	return l->key + round_up(key_size, 8);
+	return htab_elem_key(htab, l) + round_up(htab->map.key_size, 8);
 }
 
-static inline void htab_elem_set_ptr(struct htab_elem *l, u32 key_size,
+static inline void htab_elem_set_ptr(struct bpf_htab *htab, struct htab_elem *l,
 				     void __percpu *pptr)
 {
-	*(void __percpu **)htab_elem_value(l, key_size) = pptr;
+	*(void __percpu **)htab_elem_value(htab, l) = pptr;
 }
 
-static inline void __percpu *htab_elem_get_ptr(struct htab_elem *l, u32 key_size)
+static inline void __percpu *htab_elem_get_ptr(struct bpf_htab *htab, struct htab_elem *l)
 {
-	return *(void __percpu **)htab_elem_value(l, key_size);
+	return *(void __percpu **)htab_elem_value(htab, l);
 }
 
-static void *fd_htab_map_get_ptr(const struct bpf_map *map, struct htab_elem *l)
+static void *fd_htab_map_get_ptr(struct bpf_htab *htab, struct htab_elem *l)
 {
-	return *(void **)htab_elem_value(l, map->key_size);
+	return *(void **)htab_elem_value(htab, l);
 }
 
 static struct htab_elem *get_htab_elem(struct bpf_htab *htab, int i)
@@ -209,6 +247,26 @@ static struct htab_elem *get_htab_elem(struct bpf_htab *htab, int i)
 	return (struct htab_elem *) (htab->elems + i * (u64)htab->elem_size);
 }
 
+static inline u32 htab_elem_hash(struct bpf_htab *htab, struct htab_elem *l)
+{
+	if (htab_is_lru(htab))
+		return ((struct htab_elem_lru *)l)->hash;
+	else if (htab_is_percpu(htab) && !htab_is_prealloc(htab))
+		return ((struct htab_elem_pcpu *)l)->hash;
+	else
+		return l->hash;
+}
+
+static inline void htab_elem_set_hash(struct bpf_htab *htab, struct htab_elem *l, u32 hash)
+{
+	if (htab_is_lru(htab))
+		((struct htab_elem_lru *)l)->hash = hash;
+	else if (htab_is_percpu(htab) && !htab_is_prealloc(htab))
+		((struct htab_elem_pcpu *)l)->hash = hash;
+	else
+		l->hash = hash;
+}
+
 /* Both percpu and fd htab support in-place update, so no need for
  * extra elem. LRU itself can remove the least used element, so
  * there is no need for an extra elem during map_update.
@@ -231,7 +289,7 @@ static void htab_free_prealloced_internal_structs(struct bpf_htab *htab)
 
 		elem = get_htab_elem(htab, i);
 		bpf_map_free_internal_structs(&htab->map,
-					      htab_elem_value(elem, htab->map.key_size));
+					      htab_elem_value(htab, elem));
 		cond_resched();
 	}
 }
@@ -254,7 +312,7 @@ static void htab_free_prealloced_fields(struct bpf_htab *htab)
 
 		elem = get_htab_elem(htab, i);
 		if (htab_is_percpu(htab)) {
-			void __percpu *pptr = htab_elem_get_ptr(elem, htab->map.key_size);
+			void __percpu *pptr = htab_elem_get_ptr(htab, elem);
 			int cpu;
 
 			for_each_possible_cpu(cpu) {
@@ -263,7 +321,7 @@ static void htab_free_prealloced_fields(struct bpf_htab *htab)
 			}
 		} else {
 			bpf_obj_free_fields(htab->map.record,
-					    htab_elem_value(elem, htab->map.key_size));
+					    htab_elem_value(htab, elem));
 			cond_resched();
 		}
 		cond_resched();
@@ -280,8 +338,7 @@ static void htab_free_elems(struct bpf_htab *htab)
 	for (i = 0; i < htab->map.max_entries; i++) {
 		void __percpu *pptr;
 
-		pptr = htab_elem_get_ptr(get_htab_elem(htab, i),
-					 htab->map.key_size);
+		pptr = htab_elem_get_ptr(htab, get_htab_elem(htab, i));
 		free_percpu(pptr);
 		cond_resched();
 	}
@@ -308,8 +365,8 @@ static struct htab_elem *prealloc_lru_pop(struct bpf_htab *htab, void *key,
 
 	if (node) {
 		bpf_map_inc_elem_count(&htab->map);
-		l = container_of(node, struct htab_elem, lru_node);
-		memcpy(l->key, key, htab->map.key_size);
+		l = (struct htab_elem *)container_of(node, struct htab_elem_lru, lru_node);
+		memcpy(htab_elem_key(htab, l), key, htab->map.key_size);
 		return l;
 	}
 
@@ -340,8 +397,7 @@ static int prealloc_init(struct bpf_htab *htab)
 					    GFP_USER | __GFP_NOWARN);
 		if (!pptr)
 			goto free_elems;
-		htab_elem_set_ptr(get_htab_elem(htab, i), htab->map.key_size,
-				  pptr);
+		htab_elem_set_ptr(htab, get_htab_elem(htab, i), pptr);
 		cond_resched();
 	}
 
@@ -349,8 +405,8 @@ static int prealloc_init(struct bpf_htab *htab)
 	if (htab_is_lru(htab))
 		err = bpf_lru_init(&htab->lru,
 				   htab->map.map_flags & BPF_F_NO_COMMON_LRU,
-				   offsetof(struct htab_elem, hash) -
-				   offsetof(struct htab_elem, lru_node),
+				   offsetof(struct htab_elem_lru, hash) -
+				   offsetof(struct htab_elem_lru, lru_node),
 				   htab_lru_map_delete_node,
 				   htab);
 	else
@@ -361,11 +417,11 @@ static int prealloc_init(struct bpf_htab *htab)
 
 	if (htab_is_lru(htab))
 		bpf_lru_populate(&htab->lru, htab->elems,
-				 offsetof(struct htab_elem, lru_node),
+				 offsetof(struct htab_elem_lru, lru_node),
 				 htab->elem_size, num_entries);
 	else
 		pcpu_freelist_populate(&htab->freelist,
-				       htab->elems + offsetof(struct htab_elem, fnode),
+				       htab->elems + offsetof(struct htab_elem, node.fnode),
 				       htab->elem_size, num_entries);
 
 	return 0;
@@ -401,7 +457,7 @@ static int alloc_extra_elems(struct bpf_htab *htab)
 		/* pop will succeed, since prealloc_init()
 		 * preallocated extra num_possible_cpus elements
 		 */
-		l_new = container_of(l, struct htab_elem, fnode);
+		l_new = container_of(l, struct htab_elem, node.fnode);
 		*per_cpu_ptr(pptr, cpu) = l_new;
 	}
 	htab->extra_elems = pptr;
@@ -425,8 +481,8 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 	bool zero_seed = (attr->map_flags & BPF_F_ZERO_SEED);
 	int numa_node = bpf_map_attr_numa_node(attr);
 
-	BUILD_BUG_ON(offsetof(struct htab_elem, fnode.next) !=
-		     offsetof(struct htab_elem, hash_node.pprev));
+	BUILD_BUG_ON(offsetof(struct htab_node, fnode.next) !=
+		     offsetof(struct htab_node, hash_node.pprev));
 
 	if (zero_seed && !capable(CAP_SYS_ADMIN))
 		/* Guard against local DoS, and discourage production use. */
@@ -476,7 +532,7 @@ static void htab_mem_dtor(void *obj, void *ctx)
 	if (IS_ERR_OR_NULL(hrec->record))
 		return;
 
-	map_value = htab_elem_value(elem, hrec->key_size);
+	map_value = (void *)elem + sizeof(struct htab_elem) + round_up(hrec->key_size, 8);
 	bpf_obj_free_fields(hrec->record, map_value);
 }
 
@@ -583,8 +639,14 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 
 	htab->n_buckets = roundup_pow_of_two(htab->map.max_entries);
 
-	htab->elem_size = sizeof(struct htab_elem) +
-			  round_up(htab->map.key_size, 8);
+	if (htab_is_lru(htab))
+		htab->key_offset = sizeof(struct htab_elem_lru);
+	else if (percpu && !prealloc)
+		htab->key_offset = sizeof(struct htab_elem_pcpu);
+	else
+		htab->key_offset = sizeof(struct htab_elem);
+
+	htab->elem_size = htab->key_offset + round_up(htab->map.key_size, 8);
 	if (percpu)
 		htab->elem_size += sizeof(void *);
 	else
@@ -692,14 +754,16 @@ static inline struct hlist_nulls_head *select_bucket(struct bpf_htab *htab, u32
 }
 
 /* this lookup function can only be called with bucket lock taken */
-static struct htab_elem *lookup_elem_raw(struct hlist_nulls_head *head, u32 hash,
+static struct htab_elem *lookup_elem_raw(struct bpf_htab *htab,
+					 struct hlist_nulls_head *head, u32 hash,
 					 void *key, u32 key_size)
 {
 	struct hlist_nulls_node *n;
 	struct htab_elem *l;
 
-	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
-		if (l->hash == hash && !memcmp(&l->key, key, key_size))
+	hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node)
+		if (htab_elem_hash(htab, l) == hash &&
+		    !memcmp(htab_elem_key(htab, l), key, key_size))
 			return l;
 
 	return NULL;
@@ -709,7 +773,8 @@ static struct htab_elem *lookup_elem_raw(struct hlist_nulls_head *head, u32 hash
  * the unlikely event when elements moved from one bucket into another
  * while link list is being walked
  */
-static struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head *head,
+static struct htab_elem *lookup_nulls_elem_raw(struct bpf_htab *htab,
+					       struct hlist_nulls_head *head,
 					       u32 hash, void *key,
 					       u32 key_size, u32 n_buckets)
 {
@@ -717,8 +782,9 @@ static struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head *head,
 	struct htab_elem *l;
 
 again:
-	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
-		if (l->hash == hash && !memcmp(&l->key, key, key_size))
+	hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node)
+		if (htab_elem_hash(htab, l) == hash &&
+		    !memcmp(htab_elem_key(htab, l), key, key_size))
 			return l;
 
 	if (unlikely(get_nulls_value(n) != (hash & (n_buckets - 1))))
@@ -747,17 +813,18 @@ static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
 
 	head = select_bucket(htab, hash);
 
-	l = lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_buckets);
+	l = lookup_nulls_elem_raw(htab, head, hash, key, key_size, htab->n_buckets);
 
 	return l;
 }
 
 static void *htab_map_lookup_elem(struct bpf_map *map, void *key)
 {
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct htab_elem *l = __htab_map_lookup_elem(map, key);
 
 	if (l)
-		return htab_elem_value(l, map->key_size);
+		return htab_elem_value(htab, l);
 
 	return NULL;
 }
@@ -775,6 +842,7 @@ static void *htab_map_lookup_elem(struct bpf_map *map, void *key)
  */
 static int htab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 {
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct bpf_insn *insn = insn_buf;
 	const int ret = BPF_REG_0;
 
@@ -783,7 +851,7 @@ static int htab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
 	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 1);
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
-				offsetof(struct htab_elem, key) +
+				htab->key_offset +
 				round_up(map->key_size, 8));
 	return insn - insn_buf;
 }
@@ -791,12 +859,13 @@ static int htab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 static __always_inline void *__htab_lru_map_lookup_elem(struct bpf_map *map,
 							void *key, const bool mark)
 {
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct htab_elem *l = __htab_map_lookup_elem(map, key);
 
 	if (l) {
 		if (mark)
-			bpf_lru_node_set_ref(&l->lru_node);
-		return htab_elem_value(l, map->key_size);
+			bpf_lru_node_set_ref(htab_elem_lru_node(l));
+		return htab_elem_value(htab, l);
 	}
 
 	return NULL;
@@ -815,6 +884,7 @@ static void *htab_lru_map_lookup_elem_sys(struct bpf_map *map, void *key)
 static int htab_lru_map_gen_lookup(struct bpf_map *map,
 				   struct bpf_insn *insn_buf)
 {
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct bpf_insn *insn = insn_buf;
 	const int ret = BPF_REG_0;
 	const int ref_reg = BPF_REG_1;
@@ -824,15 +894,15 @@ static int htab_lru_map_gen_lookup(struct bpf_map *map,
 	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
 	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 4);
 	*insn++ = BPF_LDX_MEM(BPF_B, ref_reg, ret,
-			      offsetof(struct htab_elem, lru_node) +
+			      offsetof(struct htab_elem_lru, lru_node) +
 			      offsetof(struct bpf_lru_node, ref));
 	*insn++ = BPF_JMP_IMM(BPF_JNE, ref_reg, 0, 1);
 	*insn++ = BPF_ST_MEM(BPF_B, ret,
-			     offsetof(struct htab_elem, lru_node) +
+			     offsetof(struct htab_elem_lru, lru_node) +
 			     offsetof(struct bpf_lru_node, ref),
 			     1);
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
-				offsetof(struct htab_elem, key) +
+				htab->key_offset +
 				round_up(map->key_size, 8));
 	return insn - insn_buf;
 }
@@ -844,13 +914,13 @@ static void check_and_cancel_fields(struct bpf_htab *htab,
 		return;
 
 	if (htab_is_percpu(htab)) {
-		void __percpu *pptr = htab_elem_get_ptr(elem, htab->map.key_size);
+		void __percpu *pptr = htab_elem_get_ptr(htab, elem);
 		int cpu;
 
 		for_each_possible_cpu(cpu)
 			bpf_obj_cancel_fields(&htab->map, per_cpu_ptr(pptr, cpu));
 	} else {
-		void *map_value = htab_elem_value(elem, htab->map.key_size);
+		void *map_value = htab_elem_value(htab, elem);
 
 		bpf_obj_cancel_fields(&htab->map, map_value);
 	}
@@ -869,17 +939,17 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 	struct bucket *b;
 	int ret;
 
-	tgt_l = container_of(node, struct htab_elem, lru_node);
-	b = __select_bucket(htab, tgt_l->hash);
+	tgt_l = (struct htab_elem *)container_of(node, struct htab_elem_lru, lru_node);
+	b = __select_bucket(htab, htab_elem_hash(htab, tgt_l));
 	head = &b->head;
 
 	ret = htab_lock_bucket(b, &flags);
 	if (ret)
 		return false;
 
-	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
+	hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node)
 		if (l == tgt_l) {
-			hlist_nulls_del_rcu(&l->hash_node);
+			hlist_nulls_del_rcu(&l->node.hash_node);
 			bpf_map_dec_elem_count(&htab->map);
 			break;
 		}
@@ -912,18 +982,19 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 	head = select_bucket(htab, hash);
 
 	/* lookup the key */
-	l = lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_buckets);
+	l = lookup_nulls_elem_raw(htab, head, hash, key, key_size, htab->n_buckets);
 
 	if (!l)
 		goto find_first_elem;
 
 	/* key was found, get next key in the same bucket */
-	next_l = hlist_nulls_entry_safe(rcu_dereference_raw(hlist_nulls_next_rcu(&l->hash_node)),
-				  struct htab_elem, hash_node);
+	next_l = hlist_nulls_entry_safe(
+			rcu_dereference_raw(hlist_nulls_next_rcu(&l->node.hash_node)),
+			struct htab_elem, node.hash_node);
 
 	if (next_l) {
 		/* if next elem in this hash list is non-zero, just return it */
-		memcpy(next_key, next_l->key, key_size);
+		memcpy(next_key, htab_elem_key(htab, next_l), key_size);
 		return 0;
 	}
 
@@ -938,10 +1009,10 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 		/* pick first element in the bucket */
 		next_l = hlist_nulls_entry_safe(rcu_dereference_raw(hlist_nulls_first_rcu(head)),
-					  struct htab_elem, hash_node);
+					  struct htab_elem, node.hash_node);
 		if (next_l) {
 			/* if it's not empty, just return it */
-			memcpy(next_key, next_l->key, key_size);
+			memcpy(next_key, htab_elem_key(htab, next_l), key_size);
 			return 0;
 		}
 	}
@@ -955,7 +1026,7 @@ static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
 	check_and_cancel_fields(htab, l);
 
 	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
-		bpf_mem_cache_free(&htab->pcpu_ma, l->ptr_to_pptr);
+		bpf_mem_cache_free(&htab->pcpu_ma, htab_elem_get_ptr_to_pptr(l));
 	bpf_mem_cache_free(&htab->ma, l);
 }
 
@@ -965,7 +1036,7 @@ static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
 	void *ptr;
 
 	if (map->ops->map_fd_put_ptr) {
-		ptr = fd_htab_map_get_ptr(map, l);
+		ptr = fd_htab_map_get_ptr(htab, l);
 		map->ops->map_fd_put_ptr(map, ptr, true);
 	}
 }
@@ -1006,7 +1077,7 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 	if (htab_is_prealloc(htab)) {
 		bpf_map_dec_elem_count(&htab->map);
 		check_and_cancel_fields(htab, l);
-		pcpu_freelist_push(&htab->freelist, &l->fnode);
+		pcpu_freelist_push(&htab->freelist, &l->node.fnode);
 	} else {
 		dec_elem_count(htab);
 		htab_elem_free(htab, l);
@@ -1097,7 +1168,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			l = __pcpu_freelist_pop(&htab->freelist);
 			if (!l)
 				return ERR_PTR(-E2BIG);
-			l_new = container_of(l, struct htab_elem, fnode);
+			l_new = container_of(l, struct htab_elem, node.fnode);
 			bpf_map_inc_elem_count(&htab->map);
 		}
 	} else {
@@ -1117,10 +1188,10 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 		}
 	}
 
-	memcpy(l_new->key, key, key_size);
+	memcpy(htab_elem_key(htab, l_new), key, key_size);
 	if (percpu) {
 		if (prealloc) {
-			pptr = htab_elem_get_ptr(l_new, key_size);
+			pptr = htab_elem_get_ptr(htab, l_new);
 		} else {
 			/* alloc_percpu zero-fills */
 			void *ptr = bpf_mem_cache_alloc(&htab->pcpu_ma);
@@ -1130,26 +1201,26 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 				l_new = ERR_PTR(-ENOMEM);
 				goto dec_count;
 			}
-			l_new->ptr_to_pptr = ptr;
+			htab_elem_set_ptr_to_pptr(l_new, ptr);
 			pptr = *(void __percpu **)ptr;
 		}
 
 		pcpu_init_value(htab, pptr, value, onallcpus, map_flags);
 
 		if (!prealloc)
-			htab_elem_set_ptr(l_new, key_size, pptr);
+			htab_elem_set_ptr(htab, l_new, pptr);
 	} else if (fd_htab_map_needs_adjust(htab)) {
 		size = round_up(size, 8);
-		memcpy(htab_elem_value(l_new, key_size), value, size);
+		memcpy(htab_elem_value(htab, l_new), value, size);
 	} else if (map_flags & BPF_F_LOCK) {
 		copy_map_value_locked(&htab->map,
-				      htab_elem_value(l_new, key_size),
+				      htab_elem_value(htab, l_new),
 				      value, false);
 	} else {
-		copy_map_value(&htab->map, htab_elem_value(l_new, key_size), value);
+		copy_map_value(&htab->map, htab_elem_value(htab, l_new), value);
 	}
 
-	l_new->hash = hash;
+	htab_elem_set_hash(htab, l_new, hash);
 	return l_new;
 dec_count:
 	dec_elem_count(htab);
@@ -1199,7 +1270,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		if (unlikely(!btf_record_has_field(map->record, BPF_SPIN_LOCK)))
 			return -EINVAL;
 		/* find an element without taking the bucket lock */
-		l_old = lookup_nulls_elem_raw(head, hash, key, key_size,
+		l_old = lookup_nulls_elem_raw(htab, head, hash, key, key_size,
 					      htab->n_buckets);
 		ret = check_flags(htab, l_old, map_flags);
 		if (ret)
@@ -1207,7 +1278,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		if (l_old) {
 			/* grab the element lock and update value in place */
 			copy_map_value_locked(map,
-					      htab_elem_value(l_old, key_size),
+					      htab_elem_value(htab, l_old),
 					      value, false);
 			return 0;
 		}
@@ -1221,7 +1292,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	if (ret)
 		return ret;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(htab, head, hash, key, key_size);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1235,7 +1306,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		 * and update element in place
 		 */
 		copy_map_value_locked(map,
-				      htab_elem_value(l_old, key_size),
+				      htab_elem_value(htab, l_old),
 				      value, false);
 		ret = 0;
 		goto err;
@@ -1252,9 +1323,9 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	/* add new element to the head of the list, so that
 	 * concurrent search will find it before old elem
 	 */
-	hlist_nulls_add_head_rcu(&l_new->hash_node, head);
+	hlist_nulls_add_head_rcu(&l_new->node.hash_node, head);
 	if (l_old) {
-		hlist_nulls_del_rcu(&l_old->hash_node);
+		hlist_nulls_del_rcu(&l_old->node.hash_node);
 
 		/* l_old has already been stashed in htab->extra_elems, cancel
 		 * its reusable special fields before it is available for reuse.
@@ -1275,7 +1346,7 @@ static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
 {
 	check_and_cancel_fields(htab, elem);
 	bpf_map_dec_elem_count(&htab->map);
-	bpf_lru_push_free(&htab->lru, &elem->lru_node);
+	bpf_lru_push_free(&htab->lru, htab_elem_lru_node(elem));
 }
 
 static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value,
@@ -1310,13 +1381,13 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	l_new = prealloc_lru_pop(htab, key, hash);
 	if (!l_new)
 		return -ENOMEM;
-	copy_map_value(&htab->map, htab_elem_value(l_new, map->key_size), value);
+	copy_map_value(&htab->map, htab_elem_value(htab, l_new), value);
 
 	ret = htab_lock_bucket(b, &flags);
 	if (ret)
 		goto err_lock_bucket;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(htab, head, hash, key, key_size);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1325,10 +1396,10 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	/* add new element to the head of the list, so that
 	 * concurrent search will find it before old elem
 	 */
-	hlist_nulls_add_head_rcu(&l_new->hash_node, head);
+	hlist_nulls_add_head_rcu(&l_new->node.hash_node, head);
 	if (l_old) {
-		bpf_lru_node_set_ref(&l_new->lru_node);
-		hlist_nulls_del_rcu(&l_old->hash_node);
+		bpf_lru_node_set_ref(htab_elem_lru_node(l_new));
+		hlist_nulls_del_rcu(&l_old->node.hash_node);
 	}
 	ret = 0;
 
@@ -1383,7 +1454,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 	if (ret)
 		return ret;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(htab, head, hash, key, key_size);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1392,10 +1463,10 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 	if (l_old) {
 		/* Update value in-place */
 		if (percpu) {
-			pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
+			pcpu_copy_value(htab, htab_elem_get_ptr(htab, l_old),
 					value, onallcpus, map_flags);
 		} else {
-			void **inner_map_pptr = htab_elem_value(l_old, key_size);
+			void **inner_map_pptr = htab_elem_value(htab, l_old);
 
 			old_map_ptr = *inner_map_pptr;
 			WRITE_ONCE(*inner_map_pptr, *(void **)value);
@@ -1407,7 +1478,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 			ret = PTR_ERR(l_new);
 			goto err;
 		}
-		hlist_nulls_add_head_rcu(&l_new->hash_node, head);
+		hlist_nulls_add_head_rcu(&l_new->node.hash_node, head);
 	}
 err:
 	htab_unlock_bucket(b, flags);
@@ -1456,22 +1527,22 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	if (ret)
 		goto err_lock_bucket;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(htab, head, hash, key, key_size);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
 		goto err;
 
 	if (l_old) {
-		bpf_lru_node_set_ref(&l_old->lru_node);
+		bpf_lru_node_set_ref(htab_elem_lru_node(l_old));
 
 		/* per-cpu hash map can update value in-place */
-		pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
+		pcpu_copy_value(htab, htab_elem_get_ptr(htab, l_old),
 				value, onallcpus, map_flags);
 	} else {
-		pcpu_init_value(htab, htab_elem_get_ptr(l_new, key_size),
+		pcpu_init_value(htab, htab_elem_get_ptr(htab, l_new),
 				value, onallcpus, map_flags);
-		hlist_nulls_add_head_rcu(&l_new->hash_node, head);
+		hlist_nulls_add_head_rcu(&l_new->node.hash_node, head);
 		l_new = NULL;
 	}
 	ret = 0;
@@ -1480,7 +1551,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 err_lock_bucket:
 	if (l_new) {
 		bpf_map_dec_elem_count(&htab->map);
-		bpf_lru_push_free(&htab->lru, &l_new->lru_node);
+		bpf_lru_push_free(&htab->lru, htab_elem_lru_node(l_new));
 	}
 	return ret;
 }
@@ -1521,9 +1592,9 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
 	if (ret)
 		return ret;
 
-	l = lookup_elem_raw(head, hash, key, key_size);
+	l = lookup_elem_raw(htab, head, hash, key, key_size);
 	if (l)
-		hlist_nulls_del_rcu(&l->hash_node);
+		hlist_nulls_del_rcu(&l->node.hash_node);
 	else
 		ret = -ENOENT;
 
@@ -1556,10 +1627,10 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 	if (ret)
 		return ret;
 
-	l = lookup_elem_raw(head, hash, key, key_size);
+	l = lookup_elem_raw(htab, head, hash, key, key_size);
 
 	if (l)
-		hlist_nulls_del_rcu(&l->hash_node);
+		hlist_nulls_del_rcu(&l->node.hash_node);
 	else
 		ret = -ENOENT;
 
@@ -1581,8 +1652,8 @@ static void delete_all_elements(struct bpf_htab *htab)
 		struct hlist_nulls_node *n;
 		struct htab_elem *l;
 
-		hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
-			hlist_nulls_del_rcu(&l->hash_node);
+		hlist_nulls_for_each_entry_safe(l, n, head, node.hash_node) {
+			hlist_nulls_del_rcu(&l->node.hash_node);
 			htab_elem_free(htab, l);
 		}
 		cond_resched();
@@ -1599,10 +1670,10 @@ static void htab_free_malloced_internal_structs(struct bpf_htab *htab)
 		struct hlist_nulls_node *n;
 		struct htab_elem *l;
 
-		hlist_nulls_for_each_entry(l, n, head, hash_node) {
+		hlist_nulls_for_each_entry(l, n, head, node.hash_node) {
 			/* We only free internal structs on uref dropping to zero */
 			bpf_map_free_internal_structs(&htab->map,
-						      htab_elem_value(l, htab->map.key_size));
+						      htab_elem_value(htab, l));
 		}
 		cond_resched_rcu();
 	}
@@ -1697,7 +1768,7 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 	if (ret)
 		return ret;
 
-	l = lookup_elem_raw(head, hash, key, key_size);
+	l = lookup_elem_raw(htab, head, hash, key, key_size);
 	if (!l) {
 		ret = -ENOENT;
 		goto out_unlock;
@@ -1708,14 +1779,14 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 		void __percpu *pptr;
 		int off = 0, cpu;
 
-		pptr = htab_elem_get_ptr(l, key_size);
+		pptr = htab_elem_get_ptr(htab, l);
 		for_each_possible_cpu(cpu) {
 			copy_map_value_long(&htab->map, value + off, per_cpu_ptr(pptr, cpu));
 			check_and_init_map_value(&htab->map, value + off);
 			off += roundup_value_size;
 		}
 	} else {
-		void *src = htab_elem_value(l, map->key_size);
+		void *src = htab_elem_value(htab, l);
 
 		if (flags & BPF_F_LOCK)
 			copy_map_value_locked(map, value, src, true);
@@ -1724,7 +1795,7 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 		/* Zeroing special fields in the temp buffer */
 		check_and_init_map_value(map, value);
 	}
-	hlist_nulls_del_rcu(&l->hash_node);
+	hlist_nulls_del_rcu(&l->node.hash_node);
 
 out_unlock:
 	htab_unlock_bucket(b, bflags);
@@ -1860,7 +1931,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	}
 
 	bucket_cnt = 0;
-	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
+	hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node)
 		bucket_cnt++;
 
 	if (bucket_cnt && !locked) {
@@ -1897,14 +1968,14 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	if (!locked)
 		goto next_batch;
 
-	hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
-		memcpy(dst_key, l->key, key_size);
+	hlist_nulls_for_each_entry_safe(l, n, head, node.hash_node) {
+		memcpy(dst_key, htab_elem_key(htab, l), key_size);
 
 		if (is_percpu) {
 			int off = 0, cpu;
 			void __percpu *pptr;
 
-			pptr = htab_elem_get_ptr(l, map->key_size);
+			pptr = htab_elem_get_ptr(htab, l);
 			if (elem_map_flags & BPF_F_CPU) {
 				cpu = elem_map_flags >> 32;
 				copy_map_value(&htab->map, dst_val, per_cpu_ptr(pptr, cpu));
@@ -1918,7 +1989,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 				}
 			}
 		} else {
-			value = htab_elem_value(l, key_size);
+			value = htab_elem_value(htab, l);
 			if (is_fd_htab(htab)) {
 				struct bpf_map **inner_map = value;
 
@@ -1936,7 +2007,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 			check_and_init_map_value(map, dst_val);
 		}
 		if (do_delete) {
-			hlist_nulls_del_rcu(&l->hash_node);
+			hlist_nulls_del_rcu(&l->node.hash_node);
 
 			/* bpf_lru_push_free() will acquire lru_lock, which
 			 * may cause deadlock. See comments in function
@@ -1948,7 +2019,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 			 * lock being held and it violates the lock rule, so
 			 * invoke free_htab_elem() after unlock as well.
 			 */
-			l->batch_flink = node_to_free;
+			l->node.batch_flink = node_to_free;
 			node_to_free = l;
 		}
 		dst_key += key_size;
@@ -1960,7 +2031,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 
 	while (node_to_free) {
 		l = node_to_free;
-		node_to_free = node_to_free->batch_flink;
+		node_to_free = node_to_free->node.batch_flink;
 		if (is_lru_map)
 			htab_lru_push_free(htab, l);
 		else
@@ -2108,8 +2179,8 @@ bpf_hash_map_seq_find_next(struct bpf_iter_seq_hash_map_info *info,
 		/* no update/deletion on this bucket, prev_elem should be still valid
 		 * and we won't skip elements.
 		 */
-		n = rcu_dereference_raw(hlist_nulls_next_rcu(&prev_elem->hash_node));
-		elem = hlist_nulls_entry_safe(n, struct htab_elem, hash_node);
+		n = rcu_dereference_raw(hlist_nulls_next_rcu(&prev_elem->node.hash_node));
+		elem = hlist_nulls_entry_safe(n, struct htab_elem, node.hash_node);
 		if (elem)
 			return elem;
 
@@ -2125,7 +2196,7 @@ bpf_hash_map_seq_find_next(struct bpf_iter_seq_hash_map_info *info,
 
 		count = 0;
 		head = &b->head;
-		hlist_nulls_for_each_entry_rcu(elem, n, head, hash_node) {
+		hlist_nulls_for_each_entry_rcu(elem, n, head, node.hash_node) {
 			if (count >= skip_elems) {
 				info->bucket_id = i;
 				info->skip_elems = count;
@@ -2183,12 +2254,12 @@ static int __bpf_hash_map_seq_show(struct seq_file *seq, struct htab_elem *elem)
 		ctx.meta = &meta;
 		ctx.map = info->map;
 		if (elem) {
-			ctx.key = elem->key;
+			ctx.key = htab_elem_key(info->htab, elem);
 			if (!info->percpu_value_buf) {
-				ctx.value = htab_elem_value(elem, map->key_size);
+				ctx.value = htab_elem_value(info->htab, elem);
 			} else {
 				roundup_value_size = round_up(map->value_size, 8);
-				pptr = htab_elem_get_ptr(elem, map->key_size);
+				pptr = htab_elem_get_ptr(info->htab, elem);
 				for_each_possible_cpu(cpu) {
 					copy_map_value_long(map, info->percpu_value_buf + off,
 							    per_cpu_ptr(pptr, cpu));
@@ -2292,14 +2363,14 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
 		b = &htab->buckets[i];
 		rcu_read_lock();
 		head = &b->head;
-		hlist_nulls_for_each_entry_safe(elem, n, head, hash_node) {
-			key = elem->key;
+		hlist_nulls_for_each_entry_safe(elem, n, head, node.hash_node) {
+			key = htab_elem_key(htab, elem);
 			if (is_percpu) {
 				/* current cpu value for percpu map */
-				pptr = htab_elem_get_ptr(elem, map->key_size);
+				pptr = htab_elem_get_ptr(htab, elem);
 				val = this_cpu_ptr(pptr);
 			} else {
-				val = htab_elem_value(elem, map->key_size);
+				val = htab_elem_value(htab, elem);
 			}
 			num_elems++;
 			ret = callback_fn((u64)(long)map, (u64)(long)key,
@@ -2403,10 +2474,11 @@ const struct bpf_map_ops htab_lru_map_ops = {
 /* Called from eBPF program */
 static void *htab_percpu_map_lookup_elem(struct bpf_map *map, void *key)
 {
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct htab_elem *l = __htab_map_lookup_elem(map, key);
 
 	if (l)
-		return this_cpu_ptr(htab_elem_get_ptr(l, map->key_size));
+		return this_cpu_ptr(htab_elem_get_ptr(htab, l));
 	else
 		return NULL;
 }
@@ -2414,6 +2486,7 @@ static void *htab_percpu_map_lookup_elem(struct bpf_map *map, void *key)
 /* inline bpf_map_lookup_elem() call for per-CPU hashmap */
 static int htab_percpu_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 {
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct bpf_insn *insn = insn_buf;
 
 	if (!bpf_jit_supports_percpu_insn())
@@ -2424,7 +2497,7 @@ static int htab_percpu_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn
 	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
 	*insn++ = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3);
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_0,
-				offsetof(struct htab_elem, key) + roundup(map->key_size, 8));
+				htab->key_offset + roundup(map->key_size, 8));
 	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
 	*insn++ = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
 
@@ -2433,6 +2506,7 @@ static int htab_percpu_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn
 
 static void *htab_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *key, u32 cpu)
 {
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct htab_elem *l;
 
 	if (cpu >= nr_cpu_ids)
@@ -2440,18 +2514,19 @@ static void *htab_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *key,
 
 	l = __htab_map_lookup_elem(map, key);
 	if (l)
-		return per_cpu_ptr(htab_elem_get_ptr(l, map->key_size), cpu);
+		return per_cpu_ptr(htab_elem_get_ptr(htab, l), cpu);
 	else
 		return NULL;
 }
 
 static void *htab_lru_percpu_map_lookup_elem(struct bpf_map *map, void *key)
 {
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct htab_elem *l = __htab_map_lookup_elem(map, key);
 
 	if (l) {
-		bpf_lru_node_set_ref(&l->lru_node);
-		return this_cpu_ptr(htab_elem_get_ptr(l, map->key_size));
+		bpf_lru_node_set_ref(htab_elem_lru_node(l));
+		return this_cpu_ptr(htab_elem_get_ptr(htab, l));
 	}
 
 	return NULL;
@@ -2459,6 +2534,7 @@ static void *htab_lru_percpu_map_lookup_elem(struct bpf_map *map, void *key)
 
 static void *htab_lru_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *key, u32 cpu)
 {
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct htab_elem *l;
 
 	if (cpu >= nr_cpu_ids)
@@ -2466,8 +2542,8 @@ static void *htab_lru_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *k
 
 	l = __htab_map_lookup_elem(map, key);
 	if (l) {
-		bpf_lru_node_set_ref(&l->lru_node);
-		return per_cpu_ptr(htab_elem_get_ptr(l, map->key_size), cpu);
+		bpf_lru_node_set_ref(htab_elem_lru_node(l));
+		return per_cpu_ptr(htab_elem_get_ptr(htab, l), cpu);
 	}
 
 	return NULL;
@@ -2475,6 +2551,7 @@ static void *htab_lru_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *k
 
 int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u64 map_flags)
 {
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct htab_elem *l;
 	void __percpu *pptr;
 	int ret = -ENOENT;
@@ -2494,7 +2571,7 @@ int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u64 map_fl
 	/* We do not mark LRU map element here in order to not mess up
 	 * eviction heuristics when user space does a map walk.
 	 */
-	pptr = htab_elem_get_ptr(l, map->key_size);
+	pptr = htab_elem_get_ptr(htab, l);
 	if (map_flags & BPF_F_CPU) {
 		cpu = map_flags >> 32;
 		copy_map_value(map, value, per_cpu_ptr(pptr, cpu));
@@ -2532,6 +2609,7 @@ int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
 static void htab_percpu_map_seq_show_elem(struct bpf_map *map, void *key,
 					  struct seq_file *m)
 {
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct htab_elem *l;
 	void __percpu *pptr;
 	int cpu;
@@ -2546,7 +2624,7 @@ static void htab_percpu_map_seq_show_elem(struct bpf_map *map, void *key,
 
 	btf_type_seq_show(map->btf, map->btf_key_type_id, key, m);
 	seq_puts(m, ": {\n");
-	pptr = htab_elem_get_ptr(l, map->key_size);
+	pptr = htab_elem_get_ptr(htab, l);
 	for_each_possible_cpu(cpu) {
 		seq_printf(m, "\tcpu%d: ", cpu);
 		btf_type_seq_show(map->btf, map->btf_value_type_id,
@@ -2619,8 +2697,8 @@ static void fd_htab_map_free(struct bpf_map *map)
 	for (i = 0; i < htab->n_buckets; i++) {
 		head = select_bucket(htab, i);
 
-		hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
-			void *ptr = fd_htab_map_get_ptr(map, l);
+		hlist_nulls_for_each_entry_safe(l, n, head, node.hash_node) {
+			void *ptr = fd_htab_map_get_ptr(htab, l);
 
 			map->ops->map_fd_put_ptr(map, ptr, false);
 		}
@@ -2705,6 +2783,7 @@ static void *htab_of_map_lookup_elem(struct bpf_map *map, void *key)
 static int htab_of_map_gen_lookup(struct bpf_map *map,
 				  struct bpf_insn *insn_buf)
 {
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct bpf_insn *insn = insn_buf;
 	const int ret = BPF_REG_0;
 
@@ -2713,7 +2792,7 @@ static int htab_of_map_gen_lookup(struct bpf_map *map,
 	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
 	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 2);
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
-				offsetof(struct htab_elem, key) +
+				htab->key_offset +
 				round_up(map->key_size, 8));
 	*insn++ = BPF_LDX_MEM(BPF_DW, ret, ret, 0);
 
@@ -3533,3 +3612,16 @@ const struct bpf_map_ops rhtab_map_ops = {
 	.map_btf_id = &rhtab_map_btf_ids[0],
 	.iter_seq_info = &rhash_iter_seq_info,
 };
+
+size_t bpf_htab_map_meta_size(void)
+{
+	return sizeof(struct bpf_htab);
+}
+
+void bpf_htab_map_meta_init(struct bpf_map *inner_map_meta, struct bpf_map *inner_map)
+{
+	struct bpf_htab *inner_htab_meta = container_of(inner_map_meta, struct bpf_htab, map);
+	struct bpf_htab *inner_htab = container_of(inner_map, struct bpf_htab, map);
+
+	inner_htab_meta->key_offset = inner_htab->key_offset;
+}
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index d2cbab4bdf64..b2db5d0c98be 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -7,6 +7,15 @@
 
 #include "map_in_map.h"
 
+static bool bpf_map_type_is_htab(enum bpf_map_type type)
+{
+	return type == BPF_MAP_TYPE_HASH ||
+	       type == BPF_MAP_TYPE_PERCPU_HASH ||
+	       type == BPF_MAP_TYPE_LRU_HASH ||
+	       type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+	       type == BPF_MAP_TYPE_HASH_OF_MAPS;
+}
+
 struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 {
 	struct bpf_map *inner_map, *inner_map_meta;
@@ -29,6 +38,8 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	/* In some cases verifier needs to access beyond just base map. */
 	if (inner_map->ops == &array_map_ops || inner_map->ops == &percpu_array_map_ops)
 		inner_map_meta_size = sizeof(struct bpf_array);
+	else if (bpf_map_type_is_htab(inner_map->map_type))
+		inner_map_meta_size = bpf_htab_map_meta_size();
 
 	inner_map_meta = kzalloc(inner_map_meta_size, GFP_USER);
 	if (!inner_map_meta)
@@ -70,6 +81,8 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 		inner_array_meta->index_mask = inner_array->index_mask;
 		inner_array_meta->elem_size = inner_array->elem_size;
 		inner_map_meta->bypass_spec_v1 = inner_map->bypass_spec_v1;
+	} else if (bpf_map_type_is_htab(inner_map->map_type)) {
+		bpf_htab_map_meta_init(inner_map_meta, inner_map);
 	}
 	return inner_map_meta;
 }
diff --git a/kernel/bpf/map_in_map.h b/kernel/bpf/map_in_map.h
index 7d61602354de..1edc205772d8 100644
--- a/kernel/bpf/map_in_map.h
+++ b/kernel/bpf/map_in_map.h
@@ -15,5 +15,7 @@ void *bpf_map_fd_get_ptr(struct bpf_map *map, struct file *map_file,
 			 int ufd);
 void bpf_map_fd_put_ptr(struct bpf_map *map, void *ptr, bool need_defer);
 u32 bpf_map_fd_sys_lookup_elem(void *ptr);
+size_t bpf_htab_map_meta_size(void);
+void bpf_htab_map_meta_init(struct bpf_map *inner_map_meta, struct bpf_map *inner_map);
 
 #endif
-- 
2.55.0.654.g21b8a5bc05-goog

