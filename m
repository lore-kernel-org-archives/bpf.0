Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D114EFFB5
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790957877; cv=none; b=kcwI9QHry0iUfXUZccipqTEvTD7ISAaMe6CmutQbcDw3R6srd2vx55lJIdrgBeWTfrq0GhSbx2F3JEuql1i4tydlNSjoWVyqX9vrKe65U0ZvAYUNGHLrU0Vbj2hc9awEINP+QFe6FoR8bRKkOLT2H2kCtDEebNKtpqyNCbxcveE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790957877; c=relaxed/simple;
	bh=VBb0ic1cEFkdiEcneOGtRFRp7PzlMpYqDWMPVLl9FP4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WdMVu7eS8FNMi6W+7ZSELa1RmDoYPM9pdBNHOBBbqNI5LYmuJsX6Sq9KcWe+V3ItcZnwQfAYrOz3cqtd4P4Eubhh4kZ8e+PoXKeKbiMW9pt1c1fJQnwtZCAntLlkTXE9LVKHNuYJc6c4ofFKN5wnLBY4hIhAmI1Ze/6sc64ZPbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZLNWBsf9; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZLNWBsf9"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4922b7c31so5642257a12.1
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 09:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790957875; x=1791562675; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mKdyAhStUnZqG82QI1+oAIRO2IYijKHVYgl7jUcGp0Q=;
        b=ZLNWBsf93XsgTiuX4FUHUpKGLJdPoqfr9MNs9NBva773Tbstv6TQUYlPuN10OH6q0Z
         /ij54ZNsegBTI4piyR8/crmFl3W102EKXyHcmjwhgQDvdxXcErQgBZ1DF7kHyDrkqTmR
         hsOa21QH3TxmEb5TzZNSMCUHr/ojrzCnbQiWYUtTCujeHDzG5u8kBUv7igDckpq+APAa
         4THo0Zw6bBDJKN2AgpZ0oggqaYyfGQewkIQLFxopThbkHS9HsDxNOMGQaSwRbtEDGoqJ
         NSs+onGX+dwrmpcGV6cv7v6dt4gpjYxtd8b7mXSrNN8848vUs6B592W6uX571NtQwvHT
         kARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790957875; x=1791562675;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mKdyAhStUnZqG82QI1+oAIRO2IYijKHVYgl7jUcGp0Q=;
        b=ZYEm2/NwduuKOO6w0Vz1rbqvY3l9RXPfIQk4/IndPTKjKc7cep2YsrmsA6mQf5pJCy
         l25d5TISozcgHAcqE4FnVwjXr/z9TJ7ermbFPwBYIYbbTFgyzG3qMLd3enppH0G4cHyP
         zz4y4xJ1iwzlWux2tws4yMGNIKD4AieMgUCTVEEUxYskv5VRnsrSkMnHl/c7pVWfG+q4
         bWHnlqBKFz4NXhlO6FdQ65qHVlozjtRoIUdcylRzgDYKFV+vgVNL+NRgEdRBtPbNo6Vg
         O8fatD1EMlGG9CrWlP19sCNgVE7xf6AMvodFuUR3yb5V7MGenUwdYd6AIcL4D8dOBDGZ
         9Kog==
X-Gm-Message-State: AFuF++leyqUJYhCySrrI17RXSmGlgcqjVRivork5ee6jzaHFvx5PcoAn
	+YuSUTGR+mrNndMw+wyUhVO8v0yijKENjlrFVZZGXigC1VV48rpJrLkgqJFlmZ1bt2Sl5Wbgmsr
	U4wvUNzmprK/FOB403g==
X-Received: from pgac17.prod.google.com ([2002:a05:6a02:2951:b0:cc7:d4dc:2cd])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:6bc6:20b0:3e0:cd4c:fa68 with SMTP id adf61e73a8af0-3e0cd4d054bmr762718637.41.1790957875127;
 Fri, 02 Oct 2026 09:17:55 -0700 (PDT)
Date: Fri,  2 Oct 2026 09:17:34 -0700
In-Reply-To: <20261002161738.621133-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261002161738.621133-1-tjmercier@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002161738.621133-2-tjmercier@google.com>
Subject: [PATCH bpf-next v8 1/2] bpf: htab: Split htab_elem_lru and
 htab_elem_pcpu off of htab_elem
From: "T.J. Mercier" <tjmercier@google.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"T.J. Mercier" <tjmercier@google.com>, Mykyta Yatsenko <yatsenko@meta.com>
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
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/hashtab.c                          | 140 ++++++++++++------
 .../selftests/bpf/progs/map_ptr_kern.c        |   2 +-
 2 files changed, 92 insertions(+), 50 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 53c99fe4f176..4df6ae1fa722 100644
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
@@ -183,6 +194,26 @@ static inline bool is_fd_htab(const struct bpf_htab *htab)
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
+static struct bpf_lru_node *htab_elem_lru_node(struct htab_elem *l)
+{
+	return &container_of(l, struct htab_elem_lru, elem)->lru_node;
+}
+
 static inline void *htab_elem_value(struct htab_elem *l, u32 key_size)
 {
 	return l->key + round_up(key_size, 8);
@@ -206,7 +237,7 @@ static void *fd_htab_map_get_ptr(const struct bpf_map *map, struct htab_elem *l)
 
 static struct htab_elem *get_htab_elem(struct bpf_htab *htab, int i)
 {
-	return (struct htab_elem *) (htab->elems + i * (u64)htab->elem_size);
+	return htab->elems + i * (u64)htab->elem_size + htab->elem_offset;
 }
 
 /* Both percpu and fd htab support in-place update, so no need for
@@ -300,16 +331,16 @@ static void htab_free_elems(struct bpf_htab *htab)
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
 
@@ -349,8 +380,8 @@ static int prealloc_init(struct bpf_htab *htab)
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
@@ -361,11 +392,12 @@ static int prealloc_init(struct bpf_htab *htab)
 
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
@@ -453,7 +485,7 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 		return -EINVAL;
 
 	if ((u64)attr->key_size + attr->value_size >= KMALLOC_MAX_SIZE -
-	   sizeof(struct htab_elem))
+	   sizeof(struct htab_elem_lru))
 		/* if key_size + value_size is bigger, the user space won't be
 		 * able to access the elements via bpf syscall. This check
 		 * also makes sure that the elem_size doesn't overflow and it's
@@ -586,7 +618,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 
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
@@ -829,7 +867,7 @@ static __always_inline void *__htab_lru_map_lookup_elem(struct bpf_map *map,
 
 	if (l) {
 		if (mark)
-			bpf_lru_node_set_ref(&l->lru_node);
+			bpf_lru_node_set_ref(htab_elem_lru_node(l));
 		return htab_elem_value(l, map->key_size);
 	}
 
@@ -852,19 +890,17 @@ static int htab_lru_map_gen_lookup(struct bpf_map *map,
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
@@ -896,15 +932,16 @@ static void check_and_cancel_fields(struct bpf_htab *htab,
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
@@ -912,7 +949,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 		return false;
 
 	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
-		if (l == tgt_l) {
+		if (l == &tgt_l->elem) {
 			hlist_nulls_del_rcu(&l->hash_node);
 			bpf_map_dec_elem_count(&htab->map);
 			break;
@@ -920,9 +957,9 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 
 	htab_unlock_bucket(b, flags);
 
-	if (l == tgt_l)
+	if (l == &tgt_l->elem)
 		check_and_cancel_fields(htab, l);
-	return l == tgt_l;
+	return l == &tgt_l->elem;
 }
 
 /* Called from syscall */
@@ -989,8 +1026,8 @@ static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
 	check_and_cancel_fields(htab, l);
 
 	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
-		bpf_mem_cache_free(&htab->pcpu_ma, l->ptr_to_pptr);
-	bpf_mem_cache_free(&htab->ma, l);
+		bpf_mem_cache_free(&htab->pcpu_ma, htab_elem_get_ptr_to_pptr(l));
+	bpf_mem_cache_free(&htab->ma, htab_elem_container(htab, l));
 }
 
 static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
@@ -1138,6 +1175,8 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			bpf_map_inc_elem_count(&htab->map);
 		}
 	} else {
+		void *container;
+
 		if (is_map_full(htab))
 			if (!old_elem)
 				/* when map is full and update() is replacing
@@ -1147,11 +1186,12 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
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
@@ -1163,11 +1203,11 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
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
 
@@ -1312,14 +1352,15 @@ static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
 {
 	check_and_cancel_fields(htab, elem);
 	bpf_map_dec_elem_count(&htab->map);
-	bpf_lru_push_free(&htab->lru, &elem->lru_node);
+	bpf_lru_push_free(&htab->lru, htab_elem_lru_node(elem));
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
@@ -1347,7 +1388,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	l_new = prealloc_lru_pop(htab, key, hash);
 	if (!l_new)
 		return -ENOMEM;
-	copy_map_value(&htab->map, htab_elem_value(l_new, map->key_size), value);
+	copy_map_value(&htab->map, htab_elem_value(&l_new->elem, map->key_size), value);
 
 	ret = htab_lock_bucket(b, &flags);
 	if (ret)
@@ -1362,7 +1403,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	/* add new element to the head of the list, so that
 	 * concurrent search will find it before old elem
 	 */
-	hlist_nulls_add_head_rcu(&l_new->hash_node, head);
+	hlist_nulls_add_head_rcu(&l_new->elem.hash_node, head);
 	if (l_old) {
 		bpf_lru_node_set_ref(&l_new->lru_node);
 		hlist_nulls_del_rcu(&l_old->hash_node);
@@ -1374,7 +1415,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 
 err_lock_bucket:
 	if (ret)
-		htab_lru_push_free(htab, l_new);
+		htab_lru_push_free(htab, &l_new->elem);
 	else if (l_old)
 		htab_lru_push_free(htab, l_old);
 
@@ -1458,7 +1499,8 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 					      bool onallcpus)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
-	struct htab_elem *l_new = NULL, *l_old;
+	struct htab_elem_lru *l_new = NULL;
+	struct htab_elem *l_old;
 	struct hlist_nulls_head *head;
 	unsigned long flags;
 	struct bucket *b;
@@ -1500,15 +1542,15 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 		goto err;
 
 	if (l_old) {
-		bpf_lru_node_set_ref(&l_old->lru_node);
+		bpf_lru_node_set_ref(htab_elem_lru_node(l_old));
 
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
@@ -2505,7 +2547,7 @@ static void *htab_lru_percpu_map_lookup_elem(struct bpf_map *map, void *key)
 	struct htab_elem *l = __htab_map_lookup_elem(map, key);
 
 	if (l) {
-		bpf_lru_node_set_ref(&l->lru_node);
+		bpf_lru_node_set_ref(htab_elem_lru_node(l));
 		return this_cpu_ptr(htab_elem_get_ptr(l, map->key_size));
 	}
 
@@ -2521,7 +2563,7 @@ static void *htab_lru_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *k
 
 	l = __htab_map_lookup_elem(map, key);
 	if (l) {
-		bpf_lru_node_set_ref(&l->lru_node);
+		bpf_lru_node_set_ref(htab_elem_lru_node(l));
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

