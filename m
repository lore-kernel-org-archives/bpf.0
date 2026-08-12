Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C7C39E190
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786576759; cv=none; b=l37au43qdOxe0N9VBdCqI2j4He+QO9au7McLJqtSmWXh+UIgGxzmNT7A/Q91eNEELTBE+qWXNNAOQhx3RkvsSu0IOeHindR7X+L0WA632FvfbWuv1EJY+PhYfQrNHTzG5xCezWzFReEq7/iggwL//U+dovPbM4EyX7c6vm9FAvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786576759; c=relaxed/simple;
	bh=mVTz+gLZlC8oAO3HfC02JAP/xHhCOTZ+M3hJiiDmago=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tFk1GTorRyFOMtH6/+dsXOu9/L0Ko2LY75HDtfNHk9Vg4V5Wg+S6clSsg5uPEJ9bKRLORuuitjYmQykxtkKwpuRn9PafKyAke6GJTdNTySS9fsoPjV8nVatOreL1a9hs7ST2v524p1xrOYnqKw0H98e/2spDElEiIUKLLpkPi9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vj/YzMQ8; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vj/YzMQ8"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-848662cd2a1so1795715b3a.2
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786576757; x=1787181557; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OvDfjx6OQ5cKkEqIXyG7fMSI0eq9VGCdFM9eAmAkcCc=;
        b=Vj/YzMQ8PQuorif4+7rHGLdpTYYzBu6GsNixUaKsBl+QOfX/E2ydpcim5eEzb0jTLP
         rRyKAWpxkjaQ3wKdScOdGC3/8TPWbxYFcz+Rz2VUxkZwzJ55n5oBMe94MTkfnKgnoEGr
         Wsupm+K94+lwnLC68SXQth1pjC2JY83CD+lCGKrANtYjpgl6WUkfK6tX+TIUOdVVULOX
         hcE/YT3BTExTVjR2z4prC1d4CikocoKavf3oaAhuTu118nmpQmTTqtPJpdOsh1+nu9tH
         TIsSeJy8O8/xhowgPs4dWXFWd4gD60bZsh4jpyA5KLMbAkNjcvGLiCVlO3tSfafuUysC
         TWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786576757; x=1787181557;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OvDfjx6OQ5cKkEqIXyG7fMSI0eq9VGCdFM9eAmAkcCc=;
        b=GBuCZt7fjLowSSaW+mZijnyWoHhyT81IFE+hyFTPRC13Zvi5rqnBScBuRitcjy+Z6E
         9F9JQ44ZoP17dMlR1LNY0iPs7O8hb2Ew+2XB7c/5zNybR1aPJuIuDlp+TaYd2SKk8lce
         X7eI4mWPGxrVQGm/PR7X/tia8dz+5W/IkAKKRLoXpiv/FrvrWS5TtIdXw+eHXNcpC8Eo
         OXrpfy8b0tRQ6KjL39lEIZahwWMp/Igh26cDrC+hyMYC4pUYG3ThRHCAfKd+wmbeSjZg
         0GPwI51CvYsEovxIkXVHUG3JBV2mZsrDeidl2DSAIDcF+H8m6gv++TfQADlwM2flG9JX
         gFag==
X-Gm-Message-State: AOJu0YydFn/DKxeIM53tYsi0GmaKzocdaRUX7/ZRfujrXkWpKFjojT6x
	HHZ1Ixkr6oj90XO+l0TUaS/I8m5qprzbtAVVb6gUxPyvxk3OS5u9FgGudbLc5pV2A23nmGL0NTy
	RDkGlFOwu2czlK71fJg==
X-Received: from pfbhy7.prod.google.com ([2002:a05:6a00:6a07:b0:848:41c3:4371])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:9a9:b0:848:2e53:3f63 with SMTP id d2e1a72fcca58-84fc7514f14mr1307649b3a.21.1786576756803;
 Wed, 12 Aug 2026 16:19:16 -0700 (PDT)
Date: Wed, 12 Aug 2026 16:19:05 -0700
In-Reply-To: <20260812231905.2956588-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812231905.2956588-1-tjmercier@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812231905.2956588-3-tjmercier@google.com>
Subject: [PATCH bpf-next v4 2/2] bpf: htab: Reduce elem_size by 8 bytes for
 small key sizes
From: "T.J. Mercier" <tjmercier@google.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	mykyta.yatsenko5@gmail.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"

For standard and PCPU (non-LRU) hash maps with small key sizes (less
than or equal to the word size), comparing keys requires only a single
instruction. Storing a cached 32-bit hash value to shortcut full key
comparisons provides no performance advantage for small keys, and
consumes memory for every element.

This memory can be saved by eliminating hash along with its associated
4 byte padding before the key, reducing the elem_size (and key_offset)
by 8 bytes for standard and PCPU maps.

Introduce htab_has_hash() to check whether a map requires a cached hash
field. Update htab_elem_set_hash(), lookup_elem_raw(), and
lookup_nulls_elem_raw() to conditionally bypass hash checking and
storage when htab_has_hash() is false.

Together with the previous patch, this reduces the minimum standard and
preallocated hash map element size from 64 bytes down to 32 bytes, and
non-preallocated per-CPU element size from 64 bytes down to 40 bytes.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 kernel/bpf/hashtab.c                          | 104 +++++++++++++-----
 .../selftests/bpf/progs/map_ptr_kern.c        |   2 +-
 2 files changed, 76 insertions(+), 30 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index fed4b1db8b78..720766121ea2 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -100,6 +100,7 @@ struct bpf_htab {
 	struct percpu_counter pcount;
 	atomic_t count;
 	bool use_percpu_counter;
+	bool has_hash;
 	u32 n_buckets;	/* number of hash buckets */
 	u32 elem_size;	/* size of each element in bytes */
 	u32 key_offset;	/* offset of key in bytes */
@@ -123,15 +124,13 @@ struct htab_node {
 
 struct htab_elem {
 	struct htab_node node;
-	u32 hash __aligned(8);
-	char key[] __aligned(8);
+	u8 data[] __aligned(8);
 };
 
 struct htab_elem_lru {
 	struct htab_node node;
 	struct bpf_lru_node lru_node;
-	u32 hash __aligned(8);
-	char key[] __aligned(8);
+	u8 data[] __aligned(8);
 };
 
 /* Only for non-preallocated PCPU maps. Preallocated PCPU maps don't need
@@ -140,13 +139,13 @@ struct htab_elem_lru {
 struct htab_elem_pcpu {
 	struct htab_node node;
 	void *ptr_to_pptr;
-	u32 hash __aligned(8);
-	char key[] __aligned(8);
+	u8 data[] __aligned(8);
 };
 
 struct htab_btf_record {
 	struct btf_record *record;
 	u32 key_size;
+	u32 key_offset;
 };
 
 static inline bool htab_is_prealloc(const struct bpf_htab *htab)
@@ -247,6 +246,11 @@ static struct htab_elem *get_htab_elem(struct bpf_htab *htab, int i)
 	return (struct htab_elem *) (htab->elems + i * (u64)htab->elem_size);
 }
 
+static bool htab_has_hash(const struct bpf_htab *htab)
+{
+	return htab->has_hash;
+}
+
 static u32 htab_elem_hash(struct bpf_htab *htab, struct htab_elem *l)
 {
 	return *(u32 *)(htab_elem_key(htab, l) - 8);
@@ -254,7 +258,8 @@ static u32 htab_elem_hash(struct bpf_htab *htab, struct htab_elem *l)
 
 static void htab_elem_set_hash(struct bpf_htab *htab, struct htab_elem *l, u32 hash)
 {
-	*(u32 *)(htab_elem_key(htab, l) - 8) = hash;
+	if (htab_has_hash(htab))
+		*(u32 *)(htab_elem_key(htab, l) - 8) = hash;
 }
 
 /* Both percpu and fd htab support in-place update, so no need for
@@ -395,7 +400,7 @@ static int prealloc_init(struct bpf_htab *htab)
 	if (htab_is_lru(htab))
 		err = bpf_lru_init(&htab->lru,
 				   htab->map.map_flags & BPF_F_NO_COMMON_LRU,
-				   offsetof(struct htab_elem_lru, hash) -
+				   offsetof(struct htab_elem_lru, data) -
 				   offsetof(struct htab_elem_lru, lru_node),
 				   htab_lru_map_delete_node,
 				   htab);
@@ -522,7 +527,7 @@ static void htab_mem_dtor(void *obj, void *ctx)
 	if (IS_ERR_OR_NULL(hrec->record))
 		return;
 
-	map_value = (void *)elem + sizeof(struct htab_elem) + round_up(hrec->key_size, 8);
+	map_value = (void *)elem + hrec->key_offset + round_up(hrec->key_size, 8);
 	bpf_obj_free_fields(hrec->record, map_value);
 }
 
@@ -548,7 +553,7 @@ static void htab_dtor_ctx_free(void *ctx)
 }
 
 static int bpf_ma_set_dtor(struct bpf_map *map, struct bpf_mem_alloc *ma,
-			   void (*dtor)(void *, void *))
+			   void (*dtor)(void *, void *), u32 key_offset)
 {
 	struct htab_btf_record *hrec;
 	int err;
@@ -561,6 +566,7 @@ static int bpf_ma_set_dtor(struct bpf_map *map, struct bpf_mem_alloc *ma,
 	if (!hrec)
 		return -ENOMEM;
 	hrec->key_size = map->key_size;
+	hrec->key_offset = key_offset;
 	hrec->record = btf_record_dup(map->record);
 	if (IS_ERR(hrec->record)) {
 		err = PTR_ERR(hrec->record);
@@ -583,9 +589,9 @@ static int htab_map_check_btf(struct bpf_map *map, const struct btf *btf,
 	 * populated in htab_map_alloc(), so it will always appear as NULL.
 	 */
 	if (htab_is_percpu(htab))
-		return bpf_ma_set_dtor(map, &htab->pcpu_ma, htab_pcpu_mem_dtor);
+		return bpf_ma_set_dtor(map, &htab->pcpu_ma, htab_pcpu_mem_dtor, htab->key_offset);
 	else
-		return bpf_ma_set_dtor(map, &htab->ma, htab_mem_dtor);
+		return bpf_ma_set_dtor(map, &htab->ma, htab_mem_dtor, htab->key_offset);
 }
 
 static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
@@ -608,6 +614,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 
 	bpf_map_init_from_attr(&htab->map, attr);
 
+	/* Avoid hash memory use and comparisons where unnecessary.
+	 * u32 hash reads are always atomic. If we elide them, key comparisons must also be atomic
+	 * to avoid false positive key matches due to torn key reads / writes. This is only possible
+	 * when the key fits within a word, so check key_size.
+	 */
+	htab->has_hash = htab_is_lru(htab) || htab->map.key_size > sizeof(unsigned long);
+
 	if (percpu_lru) {
 		/* ensure each CPU's lru list has >=1 elements.
 		 * since we are at it, make each lru list has the same
@@ -630,11 +643,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	htab->n_buckets = roundup_pow_of_two(htab->map.max_entries);
 
 	if (htab_is_lru(htab))
-		htab->key_offset = offsetof(struct htab_elem_lru, key);
+		htab->key_offset = offsetof(struct htab_elem_lru, data) + 8;
 	else if (percpu && !prealloc)
-		htab->key_offset = offsetof(struct htab_elem_pcpu, key);
+		htab->key_offset = offsetof(struct htab_elem_pcpu, data) +
+				   (htab_has_hash(htab) ? 8 : 0);
 	else
-		htab->key_offset = offsetof(struct htab_elem, key);
+		htab->key_offset = offsetof(struct htab_elem, data) +
+				   (htab_has_hash(htab) ? 8 : 0);
 
 	htab->elem_size = htab->key_offset + round_up(htab->map.key_size, 8);
 	if (percpu)
@@ -743,22 +758,44 @@ static inline struct hlist_nulls_head *select_bucket(struct bpf_htab *htab, u32
 	return &__select_bucket(htab, hash)->head;
 }
 
-/* this lookup function can only be called with bucket lock taken */
-static struct htab_elem *lookup_elem_raw(struct bpf_htab *htab,
-					 struct hlist_nulls_head *head, u32 hash,
-					 void *key, u32 key_size)
+static struct htab_elem *__lookup_elem_raw(struct bpf_htab *htab,
+					   struct hlist_nulls_head *head,
+					   u32 hash, void *key, u32 key_size,
+					   struct hlist_nulls_node **out_n)
 {
 	struct hlist_nulls_node *n;
 	struct htab_elem *l;
 
-	hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node)
-		if (htab_elem_hash(htab, l) == hash &&
-		    !memcmp(htab_elem_key(htab, l), key, key_size))
-			return l;
+	if (htab_has_hash(htab)) {
+		hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node)
+			if (htab_elem_hash(htab, l) == hash &&
+			    !memcmp(htab_elem_key(htab, l), key, key_size))
+				return l;
+	} else {
+		/* When hash is omitted, key comparisons must be atomic. Zero extend
+		 * the caller's key to the word size to support an atomic compare.
+		 */
+		unsigned long k = 0;
 
+		memcpy(&k, key, key_size);
+		hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node)
+			if (READ_ONCE(*(unsigned long *)htab_elem_key(htab, l)) == k)
+				return l;
+	}
+
+	if (out_n)
+		*out_n = n;
 	return NULL;
 }
 
+/* this lookup function can only be called with bucket lock taken */
+static struct htab_elem *lookup_elem_raw(struct bpf_htab *htab,
+					 struct hlist_nulls_head *head, u32 hash,
+					 void *key, u32 key_size)
+{
+	return __lookup_elem_raw(htab, head, hash, key, key_size, NULL);
+}
+
 /* can be called without bucket lock. it will repeat the loop in
  * the unlikely event when elements moved from one bucket into another
  * while link list is being walked
@@ -772,10 +809,9 @@ static struct htab_elem *lookup_nulls_elem_raw(struct bpf_htab *htab,
 	struct htab_elem *l;
 
 again:
-	hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node)
-		if (htab_elem_hash(htab, l) == hash &&
-		    !memcmp(htab_elem_key(htab, l), key, key_size))
-			return l;
+	l = __lookup_elem_raw(htab, head, hash, key, key_size, &n);
+	if (l)
+		return l;
 
 	if (unlikely(get_nulls_value(n) != (hash & (n_buckets - 1))))
 		goto again;
@@ -1178,7 +1214,17 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 		}
 	}
 
-	memcpy(htab_elem_key(htab, l_new), key, key_size);
+	if (htab_has_hash(htab)) {
+		memcpy(htab_elem_key(htab, l_new), key, key_size);
+	} else {
+		/* Zero-extend key into k for an atomic write to support
+		 * lockless RCU readers.
+		 */
+		unsigned long k = 0;
+
+		memcpy(&k, key, key_size);
+		WRITE_ONCE(*(unsigned long *)htab_elem_key(htab, l_new), k);
+	}
 	if (percpu) {
 		if (prealloc) {
 			pptr = htab_elem_get_ptr(htab, l_new);
@@ -3181,7 +3227,7 @@ static int rhtab_map_check_btf(struct bpf_map *map, const struct btf *btf,
 {
 	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
 
-	return bpf_ma_set_dtor(map, &rhtab->ma, rhtab_mem_dtor);
+	return bpf_ma_set_dtor(map, &rhtab->ma, rhtab_mem_dtor, offsetof(struct rhtab_elem, data));
 }
 
 static void rhtab_map_free_internal_structs(struct bpf_map *map)
diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
index 373c8d17ea55..6bd4cb68c20c 100644
--- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
+++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
@@ -114,7 +114,7 @@ static inline int check_hash(void)
 	VERIFY(check_default_noinline(&hash->map, map));
 
 	VERIFY(hash->n_buckets == MAX_ENTRIES);
-	VERIFY(hash->elem_size == 64);
+	VERIFY(hash->elem_size == 32);
 
 	VERIFY(hash->count.counter == 0);
 	VERIFY(bpf_map_sum_elem_count(map) == 0);
-- 
2.55.0.691.gc56d675ccc-goog

