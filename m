Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E833F3290
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 06:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577637; cv=none; b=eKEffaWEfxb/jDjPaqdjgfypVfAExC1E+oDuUgM9VdY2fE2/CMpOeNE3mPLsKN3YZ9bf4duidiPMB9WS6ajqU4Wh9+DJJQuJWus3xr/NOIo6KN6nqpmjoQ9R8IZuUOj6wWQCPBlJazNqT2PUtVXnpgTeR631vV8rfV+3RA0ulBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577637; c=relaxed/simple;
	bh=N7Fs28JmrYnT1t3Ic7KH0KbPUvczoz4S3Bb+7itZJpE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gbS1qul0eABAE1KOw0WfIryNjGNlXTciBB9YC1E5XAwGgrNE7mfZ+tibb2Kw2/UA+in3l2vt8s/XN676mAcJygvHkR3UCLMh5OWvtR3DhiQriPJPWWpBbhQkA1l40jmV1WFMuZ3qVKgBmCfKmGsSBZU0BLdJUKlcw73ycbjZRgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iKuSiVD6; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iKuSiVD6"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d94f086fedso26195335ad.1
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 23:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790577635; x=1791182435; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xff7d79sjKaP1X7AjVAm0xyzzdzeGT0zb9KnG4y/6SM=;
        b=iKuSiVD6zkupMiyiLQTt6/zvMcaEDsZbnWIZQvgtjajfy39IaD7L2YtkPTQDWSFrJh
         wnAzKKxqLVzZEQjQ3/KK84rpO4IiDuflnXhfkwr2/tRDiqGujilfLmsOu5tdY2/j5Yt7
         xIo0RBL7tfz5F25iOVmnnDPDb/xeqlMDFALmE1I6R9BfjcZ8U4iGw9lihUuij5R92Qib
         vI/6nOPG6Z9JAkwAdmkIjW6jw8dQXUB1I09/AJfkEKMrWdolcGfZI6+4lvkJ0EN+e3hT
         bde/XsD+SdKkHtQiOXQoac3HIZ6iaZHZy4C0DdXv9RBd/+vK0BiEzZHnRKf7y8jpuInN
         zcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790577635; x=1791182435;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xff7d79sjKaP1X7AjVAm0xyzzdzeGT0zb9KnG4y/6SM=;
        b=AVOrlD4fDTCgx8sgjj6srP5GtF2Ra99YcmfS8+yC+qx8OSdaG4JacV3KqWKvS/zeYf
         Tax0v6XYIgW+VVHvxuR3YiTS20EhSHRmf1PveTSJxWIS41J6PXF+/lcEC0dHx/aSiVqt
         GWOnkn9yobo/Z3sP+/NpW41+Q9pl8Na8gTrVOKKHLGkut8oRqw3lMlQ7pb3Odfv9HR9S
         GKPwqfRGCXOVCk6VQFQ89JZnUUzFPOWv1XlwpNg+Ki3P/wvdvKSMjMAqLWs6QJcwiCyQ
         5XF9nIeeh73zqoJE4b6/51MtOaNqS/4j9OjaRu4MK8OMPGwct8rcxTJlgdxcJA+h3W47
         ZO8w==
X-Gm-Message-State: AFq9FYIMso681F9FqLeR7q8g+fvBQYmolpRFY164Hqrj7Wp2kRsWEO9L
	aMM5Ez97/y7utnso9eR/1NBTEWu4RPPTdoCJ9OBBJqvnu6+CJRco6gX9go6diJvX17F6nYU/Io1
	fdtn5SVecK6QzV//csg==
X-Received: from pldu14.prod.google.com ([2002:a17:903:108e:b0:2df:a429:6698])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3804:b0:2dd:c100:424a with SMTP id d9443c01a7336-2df7e247c77mr96776115ad.46.1790577634470;
 Sun, 27 Sep 2026 23:40:34 -0700 (PDT)
Date: Sun, 27 Sep 2026 23:40:18 -0700
In-Reply-To: <20260928064021.1433277-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928064021.1433277-1-tjmercier@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928064021.1433277-2-tjmercier@google.com>
Subject: [PATCH bpf-next v6 1/2] bpf: htab: Split htab_elem_lru and
 htab_elem_pcpu off of htab_elem
From: "T.J. Mercier" <tjmercier@google.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com
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

Place lru_node and ptr_to_pptr before struct htab_elem in
htab_elem_lru and htab_elem_pcpu respectively, and track the offset of
htab_elem from the start of the element allocation in htab->elem_offset.
This keeps key and value at constant compile-time offsets from struct
htab_elem across all hash map types, avoiding dynamic key offset
calculations on lookups.

Use sizeof(struct htab_elem_lru) for the element size rollover check in
htab_map_alloc_check() since it is now the largest element variant.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 kernel/bpf/hashtab.c                          | 152 ++++++++++++------
 .../selftests/bpf/progs/map_ptr_kern.c        |   2 +-
 2 files changed, 103 insertions(+), 51 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 6f331c80130d..847a53e6407a 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -102,6 +102,7 @@ struct bpf_htab {
 	bool use_percpu_counter;
 	u32 n_buckets;	/* number of hash buckets */
 	u32 elem_size;	/* size of each element in bytes */
+	u32 elem_offset;/* offset of htab_elem in bytes */
 	u32 hashrnd;
 };
 
@@ -117,15 +118,25 @@ struct htab_elem {
 			};
 		};
 	};
-	union {
-		/* pointer to per-cpu pointer */
-		void *ptr_to_pptr;
-		struct bpf_lru_node lru_node;
-	};
-	u32 hash;
+	u32 hash __aligned(8);
 	char key[] __aligned(8);
 };
 
+struct htab_elem_lru {
+	struct bpf_lru_node lru_node;
+	struct htab_elem elem;
+};
+
+/*
+ * Only for non-preallocated PCPU maps. Preallocated PCPU maps don't need
+ * ptr_to_pptr, and use htab_elem.
+ */
+struct htab_elem_pcpu {
+	/* pointer to per-cpu pointer */
+	void *ptr_to_pptr;
+	struct htab_elem elem;
+};
+
 struct htab_btf_record {
 	struct btf_record *record;
 	u32 key_size;
@@ -183,6 +194,21 @@ static inline bool is_fd_htab(const struct bpf_htab *htab)
 	return htab->map.map_type == BPF_MAP_TYPE_HASH_OF_MAPS;
 }
 
+static void *htab_elem_container(const struct bpf_htab *htab, struct htab_elem *l)
+{
+	return (void *)l - htab->elem_offset;
+}
+
+static void *htab_elem_get_ptr_to_pptr(struct htab_elem *l)
+{
+	return container_of(l, struct htab_elem_pcpu, elem)->ptr_to_pptr;
+}
+
+static void htab_elem_set_ptr_to_pptr(struct htab_elem *l, void *ptr)
+{
+	container_of(l, struct htab_elem_pcpu, elem)->ptr_to_pptr = ptr;
+}
+
 static inline void *htab_elem_value(struct htab_elem *l, u32 key_size)
 {
 	return l->key + round_up(key_size, 8);
@@ -206,7 +232,7 @@ static void *fd_htab_map_get_ptr(const struct bpf_map *map, struct htab_elem *l)
 
 static struct htab_elem *get_htab_elem(struct bpf_htab *htab, int i)
 {
-	return (struct htab_elem *) (htab->elems + i * (u64)htab->elem_size);
+	return htab->elems + i * (u64)htab->elem_size + htab->elem_offset;
 }
 
 /* Both percpu and fd htab support in-place update, so no need for
@@ -300,16 +326,16 @@ static void htab_free_elems(struct bpf_htab *htab)
  * bucket_lock followed by lru_lock is not allowed. In such cases,
  * bucket_lock needs to be released first before acquiring lru_lock.
  */
-static struct htab_elem *prealloc_lru_pop(struct bpf_htab *htab, void *key,
-					  u32 hash)
+static struct htab_elem_lru *prealloc_lru_pop(struct bpf_htab *htab, void *key,
+					      u32 hash)
 {
 	struct bpf_lru_node *node = bpf_lru_pop_free(&htab->lru, hash);
-	struct htab_elem *l;
+	struct htab_elem_lru *l;
 
 	if (node) {
 		bpf_map_inc_elem_count(&htab->map);
-		l = container_of(node, struct htab_elem, lru_node);
-		memcpy(l->key, key, htab->map.key_size);
+		l = container_of(node, struct htab_elem_lru, lru_node);
+		memcpy(l->elem.key, key, htab->map.key_size);
 		return l;
 	}
 
@@ -349,8 +375,8 @@ static int prealloc_init(struct bpf_htab *htab)
 	if (htab_is_lru(htab))
 		err = bpf_lru_init(&htab->lru,
 				   htab->map.map_flags & BPF_F_NO_COMMON_LRU,
-				   offsetof(struct htab_elem, hash) -
-				   offsetof(struct htab_elem, lru_node),
+				   offsetof(struct htab_elem_lru, elem.hash) -
+				   offsetof(struct htab_elem_lru, lru_node),
 				   htab_lru_map_delete_node,
 				   htab);
 	else
@@ -361,11 +387,12 @@ static int prealloc_init(struct bpf_htab *htab)
 
 	if (htab_is_lru(htab))
 		bpf_lru_populate(&htab->lru, htab->elems,
-				 offsetof(struct htab_elem, lru_node),
+				 offsetof(struct htab_elem_lru, lru_node),
 				 htab->elem_size, num_entries);
 	else
 		pcpu_freelist_populate(&htab->freelist,
-				       htab->elems + offsetof(struct htab_elem, fnode),
+				       htab->elems + htab->elem_offset +
+				       offsetof(struct htab_elem, fnode),
 				       htab->elem_size, num_entries);
 
 	return 0;
@@ -453,7 +480,7 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 		return -EINVAL;
 
 	if ((u64)attr->key_size + attr->value_size >= KMALLOC_MAX_SIZE -
-	   sizeof(struct htab_elem))
+	   sizeof(struct htab_elem_lru))
 		/* if key_size + value_size is bigger, the user space won't be
 		 * able to access the elements via bpf syscall. This check
 		 * also makes sure that the elem_size doesn't overflow and it's
@@ -586,7 +613,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 
 	htab->n_buckets = roundup_pow_of_two(htab->map.max_entries);
 
-	htab->elem_size = sizeof(struct htab_elem) +
+	if (htab_is_lru(htab))
+		htab->elem_offset = offsetof(struct htab_elem_lru, elem);
+	else if (percpu && !prealloc)
+		htab->elem_offset = offsetof(struct htab_elem_pcpu, elem);
+
+	htab->elem_size = htab->elem_offset +
+			  sizeof(struct htab_elem) +
 			  round_up(htab->map.key_size, 8);
 	if (percpu)
 		htab->elem_size += sizeof(void *);
@@ -797,8 +830,12 @@ static __always_inline void *__htab_lru_map_lookup_elem(struct bpf_map *map,
 	struct htab_elem *l = __htab_map_lookup_elem(map, key);
 
 	if (l) {
-		if (mark)
-			bpf_lru_node_set_ref(&l->lru_node);
+		if (mark) {
+			struct htab_elem_lru *l_lru =
+				container_of(l, struct htab_elem_lru, elem);
+
+			bpf_lru_node_set_ref(&l_lru->lru_node);
+		}
 		return htab_elem_value(l, map->key_size);
 	}
 
@@ -821,19 +858,17 @@ static int htab_lru_map_gen_lookup(struct bpf_map *map,
 	struct bpf_insn *insn = insn_buf;
 	const int ret = BPF_REG_0;
 	const int ref_reg = BPF_REG_1;
+	const s16 ref_off = (int)offsetof(struct htab_elem_lru, lru_node) +
+			    (int)offsetof(struct bpf_lru_node, ref) -
+			    (int)offsetof(struct htab_elem_lru, elem);
 
 	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
 		     (void *(*)(struct bpf_map *map, void *key))NULL));
 	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
 	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 4);
-	*insn++ = BPF_LDX_MEM(BPF_B, ref_reg, ret,
-			      offsetof(struct htab_elem, lru_node) +
-			      offsetof(struct bpf_lru_node, ref));
+	*insn++ = BPF_LDX_MEM(BPF_B, ref_reg, ret, ref_off);
 	*insn++ = BPF_JMP_IMM(BPF_JNE, ref_reg, 0, 1);
-	*insn++ = BPF_ST_MEM(BPF_B, ret,
-			     offsetof(struct htab_elem, lru_node) +
-			     offsetof(struct bpf_lru_node, ref),
-			     1);
+	*insn++ = BPF_ST_MEM(BPF_B, ret, ref_off, 1);
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
 				offsetof(struct htab_elem, key) +
 				round_up(map->key_size, 8));
@@ -865,15 +900,16 @@ static void check_and_cancel_fields(struct bpf_htab *htab,
 static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 {
 	struct bpf_htab *htab = arg;
-	struct htab_elem *l = NULL, *tgt_l;
+	struct htab_elem_lru *tgt_l;
+	struct htab_elem *l = NULL;
 	struct hlist_nulls_head *head;
 	struct hlist_nulls_node *n;
 	unsigned long flags;
 	struct bucket *b;
 	int ret;
 
-	tgt_l = container_of(node, struct htab_elem, lru_node);
-	b = __select_bucket(htab, tgt_l->hash);
+	tgt_l = container_of(node, struct htab_elem_lru, lru_node);
+	b = __select_bucket(htab, tgt_l->elem.hash);
 	head = &b->head;
 
 	ret = htab_lock_bucket(b, &flags);
@@ -881,7 +917,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 		return false;
 
 	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
-		if (l == tgt_l) {
+		if (l == &tgt_l->elem) {
 			hlist_nulls_del_rcu(&l->hash_node);
 			bpf_map_dec_elem_count(&htab->map);
 			break;
@@ -889,9 +925,9 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 
 	htab_unlock_bucket(b, flags);
 
-	if (l == tgt_l)
+	if (l == &tgt_l->elem)
 		check_and_cancel_fields(htab, l);
-	return l == tgt_l;
+	return l == &tgt_l->elem;
 }
 
 /* Called from syscall */
@@ -958,8 +994,8 @@ static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
 	check_and_cancel_fields(htab, l);
 
 	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
-		bpf_mem_cache_free(&htab->pcpu_ma, l->ptr_to_pptr);
-	bpf_mem_cache_free(&htab->ma, l);
+		bpf_mem_cache_free(&htab->pcpu_ma, htab_elem_get_ptr_to_pptr(l));
+	bpf_mem_cache_free(&htab->ma, htab_elem_container(htab, l));
 }
 
 static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
@@ -1104,6 +1140,8 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			bpf_map_inc_elem_count(&htab->map);
 		}
 	} else {
+		void *container;
+
 		if (is_map_full(htab))
 			if (!old_elem)
 				/* when map is full and update() is replacing
@@ -1113,11 +1151,12 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 				 */
 				return ERR_PTR(-E2BIG);
 		inc_elem_count(htab);
-		l_new = bpf_mem_cache_alloc(&htab->ma);
-		if (!l_new) {
+		container = bpf_mem_cache_alloc(&htab->ma);
+		if (!container) {
 			l_new = ERR_PTR(-ENOMEM);
 			goto dec_count;
 		}
+		l_new = container + htab->elem_offset;
 	}
 
 	memcpy(l_new->key, key, key_size);
@@ -1129,11 +1168,11 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			void *ptr = bpf_mem_cache_alloc(&htab->pcpu_ma);
 
 			if (!ptr) {
-				bpf_mem_cache_free(&htab->ma, l_new);
+				bpf_mem_cache_free(&htab->ma, htab_elem_container(htab, l_new));
 				l_new = ERR_PTR(-ENOMEM);
 				goto dec_count;
 			}
-			l_new->ptr_to_pptr = ptr;
+			htab_elem_set_ptr_to_pptr(l_new, ptr);
 			pptr = *(void __percpu **)ptr;
 		}
 
@@ -1276,16 +1315,19 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 
 static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
 {
+	struct htab_elem_lru *l = container_of(elem, struct htab_elem_lru, elem);
+
 	check_and_cancel_fields(htab, elem);
 	bpf_map_dec_elem_count(&htab->map);
-	bpf_lru_push_free(&htab->lru, &elem->lru_node);
+	bpf_lru_push_free(&htab->lru, &l->lru_node);
 }
 
 static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value,
 				     u64 map_flags)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
-	struct htab_elem *l_new, *l_old = NULL;
+	struct htab_elem *l_old = NULL;
+	struct htab_elem_lru *l_new;
 	struct hlist_nulls_head *head;
 	unsigned long flags;
 	struct bucket *b;
@@ -1313,7 +1355,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	l_new = prealloc_lru_pop(htab, key, hash);
 	if (!l_new)
 		return -ENOMEM;
-	copy_map_value(&htab->map, htab_elem_value(l_new, map->key_size), value);
+	copy_map_value(&htab->map, htab_elem_value(&l_new->elem, map->key_size), value);
 
 	ret = htab_lock_bucket(b, &flags);
 	if (ret)
@@ -1328,7 +1370,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	/* add new element to the head of the list, so that
 	 * concurrent search will find it before old elem
 	 */
-	hlist_nulls_add_head_rcu(&l_new->hash_node, head);
+	hlist_nulls_add_head_rcu(&l_new->elem.hash_node, head);
 	if (l_old) {
 		bpf_lru_node_set_ref(&l_new->lru_node);
 		hlist_nulls_del_rcu(&l_old->hash_node);
@@ -1340,7 +1382,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 
 err_lock_bucket:
 	if (ret)
-		htab_lru_push_free(htab, l_new);
+		htab_lru_push_free(htab, &l_new->elem);
 	else if (l_old)
 		htab_lru_push_free(htab, l_old);
 
@@ -1424,7 +1466,8 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 					      bool onallcpus)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
-	struct htab_elem *l_new = NULL, *l_old;
+	struct htab_elem_lru *l_new = NULL;
+	struct htab_elem *l_old;
 	struct hlist_nulls_head *head;
 	unsigned long flags;
 	struct bucket *b;
@@ -1466,15 +1509,18 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 		goto err;
 
 	if (l_old) {
-		bpf_lru_node_set_ref(&l_old->lru_node);
+		struct htab_elem_lru *l_old_lru =
+			container_of(l_old, struct htab_elem_lru, elem);
+
+		bpf_lru_node_set_ref(&l_old_lru->lru_node);
 
 		/* per-cpu hash map can update value in-place */
 		pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
 				value, onallcpus, map_flags);
 	} else {
-		pcpu_init_value(htab, htab_elem_get_ptr(l_new, key_size),
+		pcpu_init_value(htab, htab_elem_get_ptr(&l_new->elem, key_size),
 				value, onallcpus, map_flags);
-		hlist_nulls_add_head_rcu(&l_new->hash_node, head);
+		hlist_nulls_add_head_rcu(&l_new->elem.hash_node, head);
 		l_new = NULL;
 	}
 	ret = 0;
@@ -2453,7 +2499,10 @@ static void *htab_lru_percpu_map_lookup_elem(struct bpf_map *map, void *key)
 	struct htab_elem *l = __htab_map_lookup_elem(map, key);
 
 	if (l) {
-		bpf_lru_node_set_ref(&l->lru_node);
+		struct htab_elem_lru *l_lru =
+			container_of(l, struct htab_elem_lru, elem);
+
+		bpf_lru_node_set_ref(&l_lru->lru_node);
 		return this_cpu_ptr(htab_elem_get_ptr(l, map->key_size));
 	}
 
@@ -2469,7 +2518,10 @@ static void *htab_lru_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *k
 
 	l = __htab_map_lookup_elem(map, key);
 	if (l) {
-		bpf_lru_node_set_ref(&l->lru_node);
+		struct htab_elem_lru *l_lru =
+			container_of(l, struct htab_elem_lru, elem);
+
+		bpf_lru_node_set_ref(&l_lru->lru_node);
 		return per_cpu_ptr(htab_elem_get_ptr(l, map->key_size), cpu);
 	}
 
diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
index 373c8d17ea55..f71be4fc8dd7 100644
--- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
+++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
@@ -114,7 +114,7 @@ static inline int check_hash(void)
 	VERIFY(check_default_noinline(&hash->map, map));
 
 	VERIFY(hash->n_buckets == MAX_ENTRIES);
-	VERIFY(hash->elem_size == 64);
+	VERIFY(hash->elem_size == 40);
 
 	VERIFY(hash->count.counter == 0);
 	VERIFY(bpf_map_sum_elem_count(map) == 0);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

