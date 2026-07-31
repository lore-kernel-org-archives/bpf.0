Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1658B2E738A
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 01:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460014; cv=none; b=DhXEpxz06EOqtJOjyUC0Q1sB4SguNf+uZEyyOQxmanmeeWhWn8b4CtK121/BGnFwu5FS1NjKEZX8Mmcr5Sw52XRizJq6pY0lww4iGk0YDN8uAwUlDWyiz6gcWIZzymIys7Qf1xfJKMMeMDgAa/uVrFHK+x4yJyngR3UKSmkrIYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460014; c=relaxed/simple;
	bh=aMN9K+ucJ9PqN9jP2AlMpp65oeD4EosnfNW8wUo+m90=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fr7zqrq8mEe9HPZjIm2WW02W1jRfsQqTRs+UMzluXAIh+xQLzv6k98O7N6UthmQzrTqeEORw7g5rR6tq/JDTc6VC96pOpTqJS//Jbx1UDW1EmDY9aZlcc4O6CrUGeqV85UU9VyApnzTrwhwwEpF0LO3X/m+MDrLXrgIq8xkyGVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TZprlr2g; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TZprlr2g"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dbf293831so996039a91.3
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 18:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785460012; x=1786064812; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=huo7f/j7IwCgJXmU/Er7HJwA0atRtiKEqfp2YGx3T7s=;
        b=TZprlr2gtpfN/+VuMWh8yhmZoM5adahTle0ASOXxhLT1WPiVRGCzMXXe5N++VFbwFR
         FHoNkcg7GpyK3WcMb9DO70kaPkDvdXSTr5VRKncwgFEa7bcqm283zx4yD+HUyb+tx18g
         gGUZScE3GbhLtY5swq++Pux7iQtOgPX8IoNB14CTdPMZvqEuvTkscQYpgNdICF2rvUFg
         MxcHGsHpYGMnNcxDONhxXSLEGoLsylCSAC3y+PCXVwkDVhpR15B0ker3DQznlWiyVC9/
         kST6RwnZ5iLIf132jMqNsL1W8nPTbCVWkBKmuIQIujmbRFxELjmjfO5ABqoZh3XjYER2
         P32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785460012; x=1786064812;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=huo7f/j7IwCgJXmU/Er7HJwA0atRtiKEqfp2YGx3T7s=;
        b=k284RN4bAZBN6nEgXa2YSGxQtdlGcw7do7AjqXILtEa7S9VCONVq3KDc4pCsxxvVyB
         822x/x68+cEGrBL8Yb7EmLiywPurIp+96RcGAGtseEtSh+Xsyjx0y6v47eVW87lXJlbI
         XE1bX+n7pTZIooOtBEfmWXNMC1Ijgti2be9enCPccdHAFWc3S2Hx8MlqCzGiwtDmFhT9
         BDhxXCKKcwc05zhLIt0kCF76QYQdxAhwGR7fSm7Ps7WruF01JDUVWwB+aW7UGw29Kow9
         V4og9LFowBEthw0afeN9sA1AXKfS6ma6uqGtA3mcEpnMsBNMaG9RJmYF7OZfY+Ht6YjF
         OoDQ==
X-Gm-Message-State: AOJu0YzAZREkWCoV9DYLxjeIzcFAu2iEko7DzcpwMalmE7yL6hbBWXlQ
	ggllv3OXr9kP115WvwQWy6sBLgQi/y7XyfwhhbBNJouc7JxWUYP1Zj1ojqJ8NP4fIiSVmXHr5FS
	g2yn1Z+Np01YN9bd6Mw==
X-Received: from pjbnb4.prod.google.com ([2002:a17:90b:35c4:b0:38e:c91c:3667])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5847:b0:38e:6c37:d95a with SMTP id 98e67ed59e1d1-38fb1197f1fmr80060a91.19.1785460012140;
 Thu, 30 Jul 2026 18:06:52 -0700 (PDT)
Date: Thu, 30 Jul 2026 18:06:44 -0700
In-Reply-To: <20260731010645.3965783-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731010645.3965783-1-tjmercier@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731010645.3965783-3-tjmercier@google.com>
Subject: [PATCH bpf-next v2 2/2] bpf: htab: Reduce elem_size by 8 bytes for
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
 kernel/bpf/hashtab.c                          | 85 ++++++++++++-------
 .../selftests/bpf/progs/map_ptr_kern.c        |  2 +-
 2 files changed, 57 insertions(+), 30 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index f54366da459f..82b19bd54310 100644
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
-	u32 hash;
-	char key[] __aligned(8);
+	u8 data[] __aligned(8);
 };
 
 struct htab_elem_lru {
 	struct htab_node node;
 	struct bpf_lru_node lru_node;
-	u32 hash;
-	char key[] __aligned(8);
+	u8 data[] __aligned(8);
 };
 
 /* Only for non-preallocated PCPU maps. Preallocated PCPU maps don't need
@@ -140,13 +139,13 @@ struct htab_elem_lru {
 struct htab_elem_pcpu {
 	struct htab_node node;
 	void *ptr_to_pptr;
-	u32 hash;
-	char key[] __aligned(8);
+	u8 data[] __aligned(8);
 };
 
 struct htab_btf_record {
 	struct btf_record *record;
 	u32 key_size;
+	u32 key_offset;
 };
 
 static inline bool htab_is_prealloc(const struct bpf_htab *htab)
@@ -247,24 +246,31 @@ static struct htab_elem *get_htab_elem(struct bpf_htab *htab, int i)
 	return (struct htab_elem *) (htab->elems + i * (u64)htab->elem_size);
 }
 
+static inline bool htab_has_hash(const struct bpf_htab *htab)
+{
+	return htab->has_hash;
+}
+
 static inline u32 htab_elem_hash(struct bpf_htab *htab, struct htab_elem *l)
 {
 	if (htab_is_lru(htab))
-		return ((struct htab_elem_lru *)l)->hash;
+		return *(u32 *)((struct htab_elem_lru *)l)->data;
 	else if (htab_is_percpu(htab) && !htab_is_prealloc(htab))
-		return ((struct htab_elem_pcpu *)l)->hash;
+		return *(u32 *)((struct htab_elem_pcpu *)l)->data;
 	else
-		return l->hash;
+		return *(u32 *)l->data;
 }
 
 static inline void htab_elem_set_hash(struct bpf_htab *htab, struct htab_elem *l, u32 hash)
 {
+	if (!htab_has_hash(htab))
+		return;
 	if (htab_is_lru(htab))
-		((struct htab_elem_lru *)l)->hash = hash;
+		*(u32 *)((struct htab_elem_lru *)l)->data = hash;
 	else if (htab_is_percpu(htab) && !htab_is_prealloc(htab))
-		((struct htab_elem_pcpu *)l)->hash = hash;
+		*(u32 *)((struct htab_elem_pcpu *)l)->data = hash;
 	else
-		l->hash = hash;
+		*(u32 *)l->data = hash;
 }
 
 /* Both percpu and fd htab support in-place update, so no need for
@@ -405,7 +411,7 @@ static int prealloc_init(struct bpf_htab *htab)
 	if (htab_is_lru(htab))
 		err = bpf_lru_init(&htab->lru,
 				   htab->map.map_flags & BPF_F_NO_COMMON_LRU,
-				   offsetof(struct htab_elem_lru, hash) -
+				   offsetof(struct htab_elem_lru, data) -
 				   offsetof(struct htab_elem_lru, lru_node),
 				   htab_lru_map_delete_node,
 				   htab);
@@ -532,7 +538,7 @@ static void htab_mem_dtor(void *obj, void *ctx)
 	if (IS_ERR_OR_NULL(hrec->record))
 		return;
 
-	map_value = (void *)elem + sizeof(struct htab_elem) + round_up(hrec->key_size, 8);
+	map_value = (void *)elem + hrec->key_offset + round_up(hrec->key_size, 8);
 	bpf_obj_free_fields(hrec->record, map_value);
 }
 
@@ -558,7 +564,7 @@ static void htab_dtor_ctx_free(void *ctx)
 }
 
 static int bpf_ma_set_dtor(struct bpf_map *map, struct bpf_mem_alloc *ma,
-			   void (*dtor)(void *, void *))
+			   void (*dtor)(void *, void *), u32 key_offset)
 {
 	struct htab_btf_record *hrec;
 	int err;
@@ -571,6 +577,7 @@ static int bpf_ma_set_dtor(struct bpf_map *map, struct bpf_mem_alloc *ma,
 	if (!hrec)
 		return -ENOMEM;
 	hrec->key_size = map->key_size;
+	hrec->key_offset = key_offset;
 	hrec->record = btf_record_dup(map->record);
 	if (IS_ERR(hrec->record)) {
 		err = PTR_ERR(hrec->record);
@@ -593,9 +600,9 @@ static int htab_map_check_btf(struct bpf_map *map, const struct btf *btf,
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
@@ -618,6 +625,12 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 
 	bpf_map_init_from_attr(&htab->map, attr);
 
+	/* Avoid hash memory use and comparisons where unnecessary.
+	 * u32 hash reads are always atomic. If we elide them, key comparisons must also be atomic
+	 * to avoid false positive key matches due to torn key reads / writes. So check key_size.
+	 */
+	htab->has_hash = htab_is_lru(htab) || htab->map.key_size > sizeof(unsigned long);
+
 	if (percpu_lru) {
 		/* ensure each CPU's lru list has >=1 elements.
 		 * since we are at it, make each lru list has the same
@@ -640,11 +653,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	htab->n_buckets = roundup_pow_of_two(htab->map.max_entries);
 
 	if (htab_is_lru(htab))
-		htab->key_offset = sizeof(struct htab_elem_lru);
+		htab->key_offset = offsetof(struct htab_elem_lru, data) + 8;
 	else if (percpu && !prealloc)
-		htab->key_offset = sizeof(struct htab_elem_pcpu);
+		htab->key_offset = offsetof(struct htab_elem_pcpu, data) +
+				   (htab_has_hash(htab) ? 8 : 0);
 	else
-		htab->key_offset = sizeof(struct htab_elem);
+		htab->key_offset = offsetof(struct htab_elem, data) +
+				   (htab_has_hash(htab) ? 8 : 0);
 
 	htab->elem_size = htab->key_offset + round_up(htab->map.key_size, 8);
 	if (percpu)
@@ -761,10 +776,16 @@ static struct htab_elem *lookup_elem_raw(struct bpf_htab *htab,
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
+		hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node)
+			if (!memcmp(htab_elem_key(htab, l), key, key_size))
+				return l;
+	}
 
 	return NULL;
 }
@@ -782,10 +803,16 @@ static struct htab_elem *lookup_nulls_elem_raw(struct bpf_htab *htab,
 	struct htab_elem *l;
 
 again:
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
+		hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node)
+			if (!memcmp(htab_elem_key(htab, l), key, key_size))
+				return l;
+	}
 
 	if (unlikely(get_nulls_value(n) != (hash & (n_buckets - 1))))
 		goto again;
@@ -3191,7 +3218,7 @@ static int rhtab_map_check_btf(struct bpf_map *map, const struct btf *btf,
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
2.55.0.508.g3f0d502094-goog

