Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ACB42C4F0
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786576758; cv=none; b=st/45fG+edS7uaMi1ZMaZ5qeyXir0ds+4Zf/YcuFX81YrcTQ5k5E0Fj2LR+Sa4fJ/GzJh/jfFUF7xS+Ale5FWTJlgZHb12PPbg72pjakduCp/d7h3RPWCv5bDLX3zNRzzXSem72h5y2e6B/xbkP+naSyjQuueTRPC4iWHo3bNO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786576758; c=relaxed/simple;
	bh=DjY7J8c/6/IjNjdfWdKHbpiLn2QZM5cbxrpCjkPxUf0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QlqRX6ioN+A/S3N2YPk8V/IxhXzQ2lE/hm33vExAcFXpLVLIj4lVGDHhXcATYZmmpQsT8r9LgMYX3+f0Jmb5YHEIMYdfACfVO2AZ0g21CJRBcoywWmPmqPQWtJ2QO+fOt3POMdqcte52xY5reC7c1Z+64+xLwt4TTvNQyseXK4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HfAlhAQT; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HfAlhAQT"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbee57593baso819259a12.3
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786576755; x=1787181555; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=75rhLWRcSidlUgdQX62fzK5vbrG66n2hkP7GIeooNvs=;
        b=HfAlhAQTNjReVkhMI7qlSVnQkfk5bbKJbQrWepXb82JAQhjiPIeiF7tpcv8dt3TW5d
         srpqpCxRBjO4byc+6uNXukPW9xzbdJVl+FLqrvUnKXh8up2ylaSMwA55PWFxp4QpiphT
         o7g+qF2s4nOsMDF5/yqfnWYCJi3kBkVVsCm6cuMF+tynVA9RPhKs3yaU3+xQ9Yh4ZEpP
         1oxye9hYRjoBgMVwy+l1GdZezgtpTxAcnR2K9UR9/aumWLnoDYQYtV/rpOeCgr3wx25b
         C2dT/OGU6pkoUtM4XPo3Vb5MhdVAIg4ixNhHeIutLSjBuTQyABNenahPi4QfD1i/GXx2
         +hhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786576755; x=1787181555;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=75rhLWRcSidlUgdQX62fzK5vbrG66n2hkP7GIeooNvs=;
        b=hfUGGQ34DTuBqmE9v34miL8M0mo+eKYr7+J2g6sixw0fRNWKVYqlHFp/VCrI5a7e26
         J3RggdX79iZoJ+0YifhkAXvYeUaHWpCuXvaprBEGq5nOPrXcAUmzCrkXhS7eJMQNAIHL
         Jxr/MVcODdH9ARYr3OoZfRmEj1QTdhzrybDxUF1MH3cUxhIV8LrGeT8ZElCRPD1+SGNA
         WGnnkx+F5ducbzwyUtI1WDGc8R7chc7SlGQladdw5SI+bP3VUaE8e4XG2RqoFwuHkLHT
         avxk22X236EC1te3YaOpY4fUJxsr8ss9xbPD85gvn4xmjeWCW7b6qxg65zeUroima5oy
         DchQ==
X-Gm-Message-State: AOJu0YyyY9e5T75+c9xBKq735gNsP77xx6NR4UiNJCOGm9LmpVbEmWCU
	pR2MfESjfO2yQSzWyzROAW1OmFgC7QpN5eU0ELuQkesTdhoxcjPshWW3vm3TH9elFbrm+bmK1Gd
	K8259s8PRcA+3W0G6NA==
X-Received: from pjes1.prod.google.com ([2002:a17:90a:741:b0:38e:ba48:b0cc])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b92:b0:37f:e1b6:4c7d with SMTP id 98e67ed59e1d1-3931e079c22mr1555677a91.6.1786576754178;
 Wed, 12 Aug 2026 16:19:14 -0700 (PDT)
Date: Wed, 12 Aug 2026 16:19:04 -0700
In-Reply-To: <20260812231905.2956588-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812231905.2956588-1-tjmercier@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812231905.2956588-2-tjmercier@google.com>
Subject: [PATCH bpf-next v4 1/2] bpf: htab: Split htab_elem_lru and
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
 kernel/bpf/hashtab.c    | 354 +++++++++++++++++++++++++---------------
 kernel/bpf/map_in_map.c |  13 ++
 kernel/bpf/map_in_map.h |   2 +
 3 files changed, 233 insertions(+), 136 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 9f394e1aa2e8..fed4b1db8b78 100644
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
@@ -117,12 +119,28 @@ struct htab_elem {
 			};
 		};
 	};
-	union {
-		/* pointer to per-cpu pointer */
-		void *ptr_to_pptr;
-		struct bpf_lru_node lru_node;
-	};
-	u32 hash;
+};
+
+struct htab_elem {
+	struct htab_node node;
+	u32 hash __aligned(8);
+	char key[] __aligned(8);
+};
+
+struct htab_elem_lru {
+	struct htab_node node;
+	struct bpf_lru_node lru_node;
+	u32 hash __aligned(8);
+	char key[] __aligned(8);
+};
+
+/* Only for non-preallocated PCPU maps. Preallocated PCPU maps don't need
+ * ptr_to_pptr, and use htab_elem.
+ */
+struct htab_elem_pcpu {
+	struct htab_node node;
+	void *ptr_to_pptr;
+	u32 hash __aligned(8);
 	char key[] __aligned(8);
 };
 
@@ -136,6 +154,21 @@ static inline bool htab_is_prealloc(const struct bpf_htab *htab)
 	return !(htab->map.map_flags & BPF_F_NO_PREALLOC);
 }
 
+static struct bpf_lru_node *htab_elem_lru_node(struct htab_elem *l)
+{
+	return &((struct htab_elem_lru *)l)->lru_node;
+}
+
+static void *htab_elem_get_ptr_to_pptr(struct htab_elem *l)
+{
+	return ((struct htab_elem_pcpu *)l)->ptr_to_pptr;
+}
+
+static void htab_elem_set_ptr_to_pptr(struct htab_elem *l, void *ptr)
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
+static void *htab_elem_key(struct bpf_htab *htab, struct htab_elem *l)
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
@@ -209,6 +247,16 @@ static struct htab_elem *get_htab_elem(struct bpf_htab *htab, int i)
 	return (struct htab_elem *) (htab->elems + i * (u64)htab->elem_size);
 }
 
+static u32 htab_elem_hash(struct bpf_htab *htab, struct htab_elem *l)
+{
+	return *(u32 *)(htab_elem_key(htab, l) - 8);
+}
+
+static void htab_elem_set_hash(struct bpf_htab *htab, struct htab_elem *l, u32 hash)
+{
+	*(u32 *)(htab_elem_key(htab, l) - 8) = hash;
+}
+
 /* Both percpu and fd htab support in-place update, so no need for
  * extra elem. LRU itself can remove the least used element, so
  * there is no need for an extra elem during map_update.
@@ -231,7 +279,7 @@ static void htab_free_prealloced_internal_structs(struct bpf_htab *htab)
 
 		elem = get_htab_elem(htab, i);
 		bpf_map_free_internal_structs(&htab->map,
-					      htab_elem_value(elem, htab->map.key_size));
+					      htab_elem_value(htab, elem));
 		cond_resched();
 	}
 }
@@ -254,7 +302,7 @@ static void htab_free_prealloced_fields(struct bpf_htab *htab)
 
 		elem = get_htab_elem(htab, i);
 		if (htab_is_percpu(htab)) {
-			void __percpu *pptr = htab_elem_get_ptr(elem, htab->map.key_size);
+			void __percpu *pptr = htab_elem_get_ptr(htab, elem);
 			int cpu;
 
 			for_each_possible_cpu(cpu) {
@@ -263,7 +311,7 @@ static void htab_free_prealloced_fields(struct bpf_htab *htab)
 			}
 		} else {
 			bpf_obj_free_fields(htab->map.record,
-					    htab_elem_value(elem, htab->map.key_size));
+					    htab_elem_value(htab, elem));
 			cond_resched();
 		}
 		cond_resched();
@@ -280,8 +328,7 @@ static void htab_free_elems(struct bpf_htab *htab)
 	for (i = 0; i < htab->map.max_entries; i++) {
 		void __percpu *pptr;
 
-		pptr = htab_elem_get_ptr(get_htab_elem(htab, i),
-					 htab->map.key_size);
+		pptr = htab_elem_get_ptr(htab, get_htab_elem(htab, i));
 		free_percpu(pptr);
 		cond_resched();
 	}
@@ -308,8 +355,8 @@ static struct htab_elem *prealloc_lru_pop(struct bpf_htab *htab, void *key,
 
 	if (node) {
 		bpf_map_inc_elem_count(&htab->map);
-		l = container_of(node, struct htab_elem, lru_node);
-		memcpy(l->key, key, htab->map.key_size);
+		l = (struct htab_elem *)container_of(node, struct htab_elem_lru, lru_node);
+		memcpy(htab_elem_key(htab, l), key, htab->map.key_size);
 		return l;
 	}
 
@@ -340,8 +387,7 @@ static int prealloc_init(struct bpf_htab *htab)
 					    GFP_USER | __GFP_NOWARN);
 		if (!pptr)
 			goto free_elems;
-		htab_elem_set_ptr(get_htab_elem(htab, i), htab->map.key_size,
-				  pptr);
+		htab_elem_set_ptr(htab, get_htab_elem(htab, i), pptr);
 		cond_resched();
 	}
 
@@ -349,8 +395,8 @@ static int prealloc_init(struct bpf_htab *htab)
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
@@ -361,11 +407,11 @@ static int prealloc_init(struct bpf_htab *htab)
 
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
@@ -401,7 +447,7 @@ static int alloc_extra_elems(struct bpf_htab *htab)
 		/* pop will succeed, since prealloc_init()
 		 * preallocated extra num_possible_cpus elements
 		 */
-		l_new = container_of(l, struct htab_elem, fnode);
+		l_new = container_of(l, struct htab_elem, node.fnode);
 		*per_cpu_ptr(pptr, cpu) = l_new;
 	}
 	htab->extra_elems = pptr;
@@ -425,8 +471,8 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 	bool zero_seed = (attr->map_flags & BPF_F_ZERO_SEED);
 	int numa_node = bpf_map_attr_numa_node(attr);
 
-	BUILD_BUG_ON(offsetof(struct htab_elem, fnode.next) !=
-		     offsetof(struct htab_elem, hash_node.pprev));
+	BUILD_BUG_ON(offsetof(struct htab_node, fnode.next) !=
+		     offsetof(struct htab_node, hash_node.pprev));
 
 	if (zero_seed && !capable(CAP_SYS_ADMIN))
 		/* Guard against local DoS, and discourage production use. */
@@ -476,7 +522,7 @@ static void htab_mem_dtor(void *obj, void *ctx)
 	if (IS_ERR_OR_NULL(hrec->record))
 		return;
 
-	map_value = htab_elem_value(elem, hrec->key_size);
+	map_value = (void *)elem + sizeof(struct htab_elem) + round_up(hrec->key_size, 8);
 	bpf_obj_free_fields(hrec->record, map_value);
 }
 
@@ -583,8 +629,14 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 
 	htab->n_buckets = roundup_pow_of_two(htab->map.max_entries);
 
-	htab->elem_size = sizeof(struct htab_elem) +
-			  round_up(htab->map.key_size, 8);
+	if (htab_is_lru(htab))
+		htab->key_offset = offsetof(struct htab_elem_lru, key);
+	else if (percpu && !prealloc)
+		htab->key_offset = offsetof(struct htab_elem_pcpu, key);
+	else
+		htab->key_offset = offsetof(struct htab_elem, key);
+
+	htab->elem_size = htab->key_offset + round_up(htab->map.key_size, 8);
 	if (percpu)
 		htab->elem_size += sizeof(void *);
 	else
@@ -692,14 +744,16 @@ static inline struct hlist_nulls_head *select_bucket(struct bpf_htab *htab, u32
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
@@ -709,7 +763,8 @@ static struct htab_elem *lookup_elem_raw(struct hlist_nulls_head *head, u32 hash
  * the unlikely event when elements moved from one bucket into another
  * while link list is being walked
  */
-static struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head *head,
+static struct htab_elem *lookup_nulls_elem_raw(struct bpf_htab *htab,
+					       struct hlist_nulls_head *head,
 					       u32 hash, void *key,
 					       u32 key_size, u32 n_buckets)
 {
@@ -717,8 +772,9 @@ static struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head *head,
 	struct htab_elem *l;
 
 again:
-	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
-		if (l->hash == hash && !memcmp(&l->key, key, key_size))
+	hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node)
+		if (htab_elem_hash(htab, l) == hash &&
+		    !memcmp(htab_elem_key(htab, l), key, key_size))
 			return l;
 
 	if (unlikely(get_nulls_value(n) != (hash & (n_buckets - 1))))
@@ -747,17 +803,18 @@ static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
 
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
@@ -775,6 +832,7 @@ static void *htab_map_lookup_elem(struct bpf_map *map, void *key)
  */
 static int htab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 {
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct bpf_insn *insn = insn_buf;
 	const int ret = BPF_REG_0;
 
@@ -783,7 +841,7 @@ static int htab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
 	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 1);
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
-				offsetof(struct htab_elem, key) +
+				htab->key_offset +
 				round_up(map->key_size, 8));
 	return insn - insn_buf;
 }
@@ -791,12 +849,13 @@ static int htab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
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
@@ -815,6 +874,7 @@ static void *htab_lru_map_lookup_elem_sys(struct bpf_map *map, void *key)
 static int htab_lru_map_gen_lookup(struct bpf_map *map,
 				   struct bpf_insn *insn_buf)
 {
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct bpf_insn *insn = insn_buf;
 	const int ret = BPF_REG_0;
 	const int ref_reg = BPF_REG_1;
@@ -824,15 +884,15 @@ static int htab_lru_map_gen_lookup(struct bpf_map *map,
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
@@ -844,13 +904,13 @@ static void check_and_cancel_fields(struct bpf_htab *htab,
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
@@ -869,17 +929,17 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
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
@@ -912,18 +972,19 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
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
 
@@ -938,10 +999,10 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
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
@@ -955,7 +1016,7 @@ static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
 	check_and_cancel_fields(htab, l);
 
 	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
-		bpf_mem_cache_free(&htab->pcpu_ma, l->ptr_to_pptr);
+		bpf_mem_cache_free(&htab->pcpu_ma, htab_elem_get_ptr_to_pptr(l));
 	bpf_mem_cache_free(&htab->ma, l);
 }
 
@@ -965,7 +1026,7 @@ static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
 	void *ptr;
 
 	if (map->ops->map_fd_put_ptr) {
-		ptr = fd_htab_map_get_ptr(map, l);
+		ptr = fd_htab_map_get_ptr(htab, l);
 		map->ops->map_fd_put_ptr(map, ptr, true);
 	}
 }
@@ -1006,7 +1067,7 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 	if (htab_is_prealloc(htab)) {
 		bpf_map_dec_elem_count(&htab->map);
 		check_and_cancel_fields(htab, l);
-		pcpu_freelist_push(&htab->freelist, &l->fnode);
+		pcpu_freelist_push(&htab->freelist, &l->node.fnode);
 	} else {
 		dec_elem_count(htab);
 		htab_elem_free(htab, l);
@@ -1097,7 +1158,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			l = __pcpu_freelist_pop(&htab->freelist);
 			if (!l)
 				return ERR_PTR(-E2BIG);
-			l_new = container_of(l, struct htab_elem, fnode);
+			l_new = container_of(l, struct htab_elem, node.fnode);
 			bpf_map_inc_elem_count(&htab->map);
 		}
 	} else {
@@ -1117,10 +1178,10 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
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
@@ -1130,26 +1191,26 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
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
@@ -1199,7 +1260,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		if (unlikely(!btf_record_has_field(map->record, BPF_SPIN_LOCK)))
 			return -EINVAL;
 		/* find an element without taking the bucket lock */
-		l_old = lookup_nulls_elem_raw(head, hash, key, key_size,
+		l_old = lookup_nulls_elem_raw(htab, head, hash, key, key_size,
 					      htab->n_buckets);
 		ret = check_flags(htab, l_old, map_flags);
 		if (ret)
@@ -1207,7 +1268,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		if (l_old) {
 			/* grab the element lock and update value in place */
 			copy_map_value_locked(map,
-					      htab_elem_value(l_old, key_size),
+					      htab_elem_value(htab, l_old),
 					      value, false);
 			return 0;
 		}
@@ -1221,7 +1282,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	if (ret)
 		return ret;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(htab, head, hash, key, key_size);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1235,7 +1296,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		 * and update element in place
 		 */
 		copy_map_value_locked(map,
-				      htab_elem_value(l_old, key_size),
+				      htab_elem_value(htab, l_old),
 				      value, false);
 		ret = 0;
 		goto err;
@@ -1252,9 +1313,9 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
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
@@ -1275,7 +1336,7 @@ static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
 {
 	check_and_cancel_fields(htab, elem);
 	bpf_map_dec_elem_count(&htab->map);
-	bpf_lru_push_free(&htab->lru, &elem->lru_node);
+	bpf_lru_push_free(&htab->lru, htab_elem_lru_node(elem));
 }
 
 static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value,
@@ -1310,13 +1371,13 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
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
@@ -1325,10 +1386,10 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
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
 
@@ -1383,7 +1444,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 	if (ret)
 		return ret;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(htab, head, hash, key, key_size);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1392,10 +1453,10 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
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
@@ -1407,7 +1468,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 			ret = PTR_ERR(l_new);
 			goto err;
 		}
-		hlist_nulls_add_head_rcu(&l_new->hash_node, head);
+		hlist_nulls_add_head_rcu(&l_new->node.hash_node, head);
 	}
 err:
 	htab_unlock_bucket(b, flags);
@@ -1456,22 +1517,22 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
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
@@ -1480,7 +1541,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 err_lock_bucket:
 	if (l_new) {
 		bpf_map_dec_elem_count(&htab->map);
-		bpf_lru_push_free(&htab->lru, &l_new->lru_node);
+		bpf_lru_push_free(&htab->lru, htab_elem_lru_node(l_new));
 	}
 	return ret;
 }
@@ -1521,9 +1582,9 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
 	if (ret)
 		return ret;
 
-	l = lookup_elem_raw(head, hash, key, key_size);
+	l = lookup_elem_raw(htab, head, hash, key, key_size);
 	if (l)
-		hlist_nulls_del_rcu(&l->hash_node);
+		hlist_nulls_del_rcu(&l->node.hash_node);
 	else
 		ret = -ENOENT;
 
@@ -1556,10 +1617,10 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 	if (ret)
 		return ret;
 
-	l = lookup_elem_raw(head, hash, key, key_size);
+	l = lookup_elem_raw(htab, head, hash, key, key_size);
 
 	if (l)
-		hlist_nulls_del_rcu(&l->hash_node);
+		hlist_nulls_del_rcu(&l->node.hash_node);
 	else
 		ret = -ENOENT;
 
@@ -1581,8 +1642,8 @@ static void delete_all_elements(struct bpf_htab *htab)
 		struct hlist_nulls_node *n;
 		struct htab_elem *l;
 
-		hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
-			hlist_nulls_del_rcu(&l->hash_node);
+		hlist_nulls_for_each_entry_safe(l, n, head, node.hash_node) {
+			hlist_nulls_del_rcu(&l->node.hash_node);
 			htab_elem_free(htab, l);
 		}
 		cond_resched();
@@ -1599,10 +1660,10 @@ static void htab_free_malloced_internal_structs(struct bpf_htab *htab)
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
@@ -1697,7 +1758,7 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 	if (ret)
 		return ret;
 
-	l = lookup_elem_raw(head, hash, key, key_size);
+	l = lookup_elem_raw(htab, head, hash, key, key_size);
 	if (!l) {
 		ret = -ENOENT;
 		goto out_unlock;
@@ -1708,14 +1769,14 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
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
@@ -1724,7 +1785,7 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 		/* Zeroing special fields in the temp buffer */
 		check_and_init_map_value(map, value);
 	}
-	hlist_nulls_del_rcu(&l->hash_node);
+	hlist_nulls_del_rcu(&l->node.hash_node);
 
 out_unlock:
 	htab_unlock_bucket(b, bflags);
@@ -1860,7 +1921,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	}
 
 	bucket_cnt = 0;
-	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
+	hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node)
 		bucket_cnt++;
 
 	if (bucket_cnt && !locked) {
@@ -1897,14 +1958,14 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
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
@@ -1918,7 +1979,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 				}
 			}
 		} else {
-			value = htab_elem_value(l, key_size);
+			value = htab_elem_value(htab, l);
 			if (is_fd_htab(htab)) {
 				struct bpf_map **inner_map = value;
 
@@ -1936,7 +1997,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 			check_and_init_map_value(map, dst_val);
 		}
 		if (do_delete) {
-			hlist_nulls_del_rcu(&l->hash_node);
+			hlist_nulls_del_rcu(&l->node.hash_node);
 
 			/* bpf_lru_push_free() will acquire lru_lock, which
 			 * may cause deadlock. See comments in function
@@ -1948,7 +2009,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 			 * lock being held and it violates the lock rule, so
 			 * invoke free_htab_elem() after unlock as well.
 			 */
-			l->batch_flink = node_to_free;
+			l->node.batch_flink = node_to_free;
 			node_to_free = l;
 		}
 		dst_key += key_size;
@@ -1960,7 +2021,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 
 	while (node_to_free) {
 		l = node_to_free;
-		node_to_free = node_to_free->batch_flink;
+		node_to_free = node_to_free->node.batch_flink;
 		if (is_lru_map)
 			htab_lru_push_free(htab, l);
 		else
@@ -2108,8 +2169,8 @@ bpf_hash_map_seq_find_next(struct bpf_iter_seq_hash_map_info *info,
 		/* no update/deletion on this bucket, prev_elem should be still valid
 		 * and we won't skip elements.
 		 */
-		n = rcu_dereference_raw(hlist_nulls_next_rcu(&prev_elem->hash_node));
-		elem = hlist_nulls_entry_safe(n, struct htab_elem, hash_node);
+		n = rcu_dereference_raw(hlist_nulls_next_rcu(&prev_elem->node.hash_node));
+		elem = hlist_nulls_entry_safe(n, struct htab_elem, node.hash_node);
 		if (elem)
 			return elem;
 
@@ -2125,7 +2186,7 @@ bpf_hash_map_seq_find_next(struct bpf_iter_seq_hash_map_info *info,
 
 		count = 0;
 		head = &b->head;
-		hlist_nulls_for_each_entry_rcu(elem, n, head, hash_node) {
+		hlist_nulls_for_each_entry_rcu(elem, n, head, node.hash_node) {
 			if (count >= skip_elems) {
 				info->bucket_id = i;
 				info->skip_elems = count;
@@ -2183,12 +2244,12 @@ static int __bpf_hash_map_seq_show(struct seq_file *seq, struct htab_elem *elem)
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
@@ -2292,14 +2353,14 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
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
@@ -2403,10 +2464,11 @@ const struct bpf_map_ops htab_lru_map_ops = {
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
@@ -2414,6 +2476,7 @@ static void *htab_percpu_map_lookup_elem(struct bpf_map *map, void *key)
 /* inline bpf_map_lookup_elem() call for per-CPU hashmap */
 static int htab_percpu_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 {
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct bpf_insn *insn = insn_buf;
 
 	if (!bpf_jit_supports_percpu_insn())
@@ -2424,7 +2487,7 @@ static int htab_percpu_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn
 	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
 	*insn++ = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3);
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_0,
-				offsetof(struct htab_elem, key) + roundup(map->key_size, 8));
+				htab->key_offset + roundup(map->key_size, 8));
 	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
 	*insn++ = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
 
@@ -2433,6 +2496,7 @@ static int htab_percpu_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn
 
 static void *htab_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *key, u32 cpu)
 {
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct htab_elem *l;
 
 	if (cpu >= nr_cpu_ids)
@@ -2440,18 +2504,19 @@ static void *htab_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *key,
 
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
@@ -2459,6 +2524,7 @@ static void *htab_lru_percpu_map_lookup_elem(struct bpf_map *map, void *key)
 
 static void *htab_lru_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *key, u32 cpu)
 {
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct htab_elem *l;
 
 	if (cpu >= nr_cpu_ids)
@@ -2466,8 +2532,8 @@ static void *htab_lru_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *k
 
 	l = __htab_map_lookup_elem(map, key);
 	if (l) {
-		bpf_lru_node_set_ref(&l->lru_node);
-		return per_cpu_ptr(htab_elem_get_ptr(l, map->key_size), cpu);
+		bpf_lru_node_set_ref(htab_elem_lru_node(l));
+		return per_cpu_ptr(htab_elem_get_ptr(htab, l), cpu);
 	}
 
 	return NULL;
@@ -2475,6 +2541,7 @@ static void *htab_lru_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *k
 
 int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u64 map_flags)
 {
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct htab_elem *l;
 	void __percpu *pptr;
 	int ret = -ENOENT;
@@ -2494,7 +2561,7 @@ int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u64 map_fl
 	/* We do not mark LRU map element here in order to not mess up
 	 * eviction heuristics when user space does a map walk.
 	 */
-	pptr = htab_elem_get_ptr(l, map->key_size);
+	pptr = htab_elem_get_ptr(htab, l);
 	if (map_flags & BPF_F_CPU) {
 		cpu = map_flags >> 32;
 		copy_map_value(map, value, per_cpu_ptr(pptr, cpu));
@@ -2532,6 +2599,7 @@ int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
 static void htab_percpu_map_seq_show_elem(struct bpf_map *map, void *key,
 					  struct seq_file *m)
 {
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct htab_elem *l;
 	void __percpu *pptr;
 	int cpu;
@@ -2546,7 +2614,7 @@ static void htab_percpu_map_seq_show_elem(struct bpf_map *map, void *key,
 
 	btf_type_seq_show(map->btf, map->btf_key_type_id, key, m);
 	seq_puts(m, ": {\n");
-	pptr = htab_elem_get_ptr(l, map->key_size);
+	pptr = htab_elem_get_ptr(htab, l);
 	for_each_possible_cpu(cpu) {
 		seq_printf(m, "\tcpu%d: ", cpu);
 		btf_type_seq_show(map->btf, map->btf_value_type_id,
@@ -2619,8 +2687,8 @@ static void fd_htab_map_free(struct bpf_map *map)
 	for (i = 0; i < htab->n_buckets; i++) {
 		head = select_bucket(htab, i);
 
-		hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
-			void *ptr = fd_htab_map_get_ptr(map, l);
+		hlist_nulls_for_each_entry_safe(l, n, head, node.hash_node) {
+			void *ptr = fd_htab_map_get_ptr(htab, l);
 
 			map->ops->map_fd_put_ptr(map, ptr, false);
 		}
@@ -2705,6 +2773,7 @@ static void *htab_of_map_lookup_elem(struct bpf_map *map, void *key)
 static int htab_of_map_gen_lookup(struct bpf_map *map,
 				  struct bpf_insn *insn_buf)
 {
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct bpf_insn *insn = insn_buf;
 	const int ret = BPF_REG_0;
 
@@ -2713,7 +2782,7 @@ static int htab_of_map_gen_lookup(struct bpf_map *map,
 	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
 	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 2);
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
-				offsetof(struct htab_elem, key) +
+				htab->key_offset +
 				round_up(map->key_size, 8));
 	*insn++ = BPF_LDX_MEM(BPF_DW, ret, ret, 0);
 
@@ -3533,3 +3602,16 @@ const struct bpf_map_ops rhtab_map_ops = {
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
2.55.0.691.gc56d675ccc-goog

