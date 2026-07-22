Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D5B430781
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 20:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784752726; cv=none; b=Nrcc+iJGCkSlqUKtXr9Tvi1/z54dJnxnlKIeCG5bYGgvbGVsUfuzvjGnp04VJ0Pf+pub5XQoT/qLIxIzwjf/IEoTEyxxYmGLPexnpJ8notpF/6fI/XaMJt5YVPQYhVzEYweIAIcPSHlLKTCrU7SG9XmhnQJpXmyiR0JHsls0wVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784752726; c=relaxed/simple;
	bh=rUK40bARNxczgJ996whFU3NmgjvPa/s39yfxpjJVUqo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q8J89A55cADLFk7sOVGpyRv+AFObxrOzg3A84Sz1wh5X7RbgPrOT9fj04xfdW8XVh5vCU57RAJTPqNTcgoO2llrS9OMEL4iP6y6cs0i27TXh7sKdBNQDlkdFVBoByGO7S6d83Y4Z+2U/BeA7q5N5U5UQjrC2hb80QA+tZis4SYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U3rBxrWH; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U3rBxrWH"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cceabd70f5so259341055ad.1
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 13:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784752724; x=1785357524; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q56EpsIonIpKbN+joDw4ls0yr16ZYqeSmCoC1Wd1d9g=;
        b=U3rBxrWH/F3z6/gnZwTztGBQfMWmNloO1h0Pap98DooUhdNjh1vNp2AoxE8ZHA4PEQ
         r6KcVs8Y5HMNSnr2sJJJZJAqXF1p2NuTjLxn5xJoDI71UkXlaWBpOA6miwxBAUjdN1iz
         Tp+8wEx/RgpBDte18MX7bF2QfCeMRvQYLt1iSZgRP+rJcO1TnGW4q3fARUHsgnaUPvpe
         RSk5GcR97w2AcAcq/9f6F0+lxtpKMTPbf3f2SvK32q6M4kWTWaRkRtJcd9/9dmMXxufk
         Yq+dB76MEXCGe5lff2zYCCwEStTzSmF1Gz+X5YpWL1BDAhHtU7HAKnaQjukoZICo943g
         IDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784752724; x=1785357524;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q56EpsIonIpKbN+joDw4ls0yr16ZYqeSmCoC1Wd1d9g=;
        b=Ic1V50WMhMpEUxT6MUnq+tMFITs+eYZZrSo0v3WLjA4ZCMqtC5XpXf6uu8GjYZsOTn
         jLUveYwaUVDasnlTWA0fnOgiH9SQWm1Az7/vdwDZpmpC1P0eTtlToRPn7aW98skSmyXf
         w2nTTxr9tbJHC+3HV6xHARr6/nzK+1HEuqMumtC/x4kN5FzF8eNcXpQRy71r1aClah8V
         w7MOdzisyZUGe1S+I+OmIFhb1EQ11YczsNqsOb07yWh2xITtHXFYUVMb+eoTOnqgHBDb
         Cxh8cSxTyet992or4B0nKgjkDpFeF3PlanwGxb+KyfKSbLnOwWgo/wz42STF/WS0KKYf
         OqIg==
X-Gm-Message-State: AOJu0Yw37rCM62OLsuGR6GE9s1Oo/gZK2jKUA54WoffSKzmkXqN6Dqre
	tNzzZV39z1T3uhjsaSzB/tUuKdgdsvV5Fg7vNpRvevBQ17Qkh7OWORpPgHRZO6eHZs/o8eiNp0E
	9YsOsw41WduWub1RuMA==
X-Received: from plbkk7.prod.google.com ([2002:a17:903:707:b0:2cc:8a78:d849])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2449:b0:2cc:4c29:8221 with SMTP id d9443c01a7336-2cfa74d88b2mr3893655ad.45.1784752724215;
 Wed, 22 Jul 2026 13:38:44 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:38:01 -0700
In-Reply-To: <20260722203801.1854941-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722203801.1854941-1-tjmercier@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260722203801.1854941-3-tjmercier@google.com>
Subject: [PATCH 2/2] bpf: htab: Reduce elem_size by 8 bytes for small key sizes
From: "T.J. Mercier" <tjmercier@google.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"

For standard and PCPU (non-LRU) hash maps with small key sizes (<= 8
bytes), comparing keys requires only an 8 byte compare. Storing a cached
32-bit hash value to shortcut full key comparisons provides no
performance advantage for small keys, and consumes memory for every
element.

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
 kernel/bpf/hashtab.c                          | 35 +++++++++++++------
 .../selftests/bpf/progs/map_ptr_kern.c        |  2 +-
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 57729c3dff3d..b8c30d402958 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -118,7 +118,7 @@ struct htab_elem {
 			};
 		};
 	};
-	u32 hash;
+	u32 hash; /* Only when htab_has_hash() */
 } __aligned(8);
 
 struct htab_elem_lru {
@@ -151,12 +151,13 @@ struct htab_elem_pcpu {
 		};
 	};
 	void *ptr_to_pptr;
-	u32 hash;
+	u32 hash; /* Only when htab_has_hash() */
 } __aligned(8);
 
 struct htab_btf_record {
 	struct btf_record *record;
 	u32 key_size;
+	u32 key_offset;
 };
 
 static inline bool htab_is_prealloc(const struct bpf_htab *htab)
@@ -257,6 +258,11 @@ static struct htab_elem *get_htab_elem(struct bpf_htab *htab, int i)
 	return (struct htab_elem *) (htab->elems + i * (u64)htab->elem_size);
 }
 
+static inline bool htab_has_hash(const struct bpf_htab *htab)
+{
+	return htab_is_lru(htab) || htab->map.key_size > 8;
+}
+
 static inline u32 htab_elem_hash(struct bpf_htab *htab, struct htab_elem *l)
 {
 	if (htab_is_lru(htab))
@@ -269,6 +275,8 @@ static inline u32 htab_elem_hash(struct bpf_htab *htab, struct htab_elem *l)
 
 static inline void htab_elem_set_hash(struct bpf_htab *htab, struct htab_elem *l, u32 hash)
 {
+	if (!htab_has_hash(htab))
+		return;
 	if (htab_is_lru(htab))
 		((struct htab_elem_lru *)l)->hash = hash;
 	else if (htab_is_percpu(htab) && !htab_is_prealloc(htab))
@@ -561,7 +569,7 @@ static void htab_mem_dtor(void *obj, void *ctx)
 	if (IS_ERR_OR_NULL(hrec->record))
 		return;
 
-	map_value = (void *)elem + sizeof(struct htab_elem) + round_up(hrec->key_size, 8);
+	map_value = (void *)elem + hrec->key_offset + round_up(hrec->key_size, 8);
 	bpf_obj_free_fields(hrec->record, map_value);
 }
 
@@ -587,7 +595,7 @@ static void htab_dtor_ctx_free(void *ctx)
 }
 
 static int bpf_ma_set_dtor(struct bpf_map *map, struct bpf_mem_alloc *ma,
-			   void (*dtor)(void *, void *))
+			   void (*dtor)(void *, void *), u32 key_offset)
 {
 	struct htab_btf_record *hrec;
 	int err;
@@ -600,6 +608,7 @@ static int bpf_ma_set_dtor(struct bpf_map *map, struct bpf_mem_alloc *ma,
 	if (!hrec)
 		return -ENOMEM;
 	hrec->key_size = map->key_size;
+	hrec->key_offset = key_offset;
 	hrec->record = btf_record_dup(map->record);
 	if (IS_ERR(hrec->record)) {
 		err = PTR_ERR(hrec->record);
@@ -622,9 +631,9 @@ static int htab_map_check_btf(struct bpf_map *map, const struct btf *btf,
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
@@ -671,9 +680,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	if (htab_is_lru(htab))
 		htab->key_offset = sizeof(struct htab_elem_lru);
 	else if (percpu && !prealloc)
-		htab->key_offset = sizeof(struct htab_elem_pcpu);
+		htab->key_offset = round_up(htab_has_hash(htab) ?
+					    sizeof(struct htab_elem_pcpu) :
+					    offsetof(struct htab_elem_pcpu, hash), 8);
 	else
-		htab->key_offset = sizeof(struct htab_elem);
+		htab->key_offset = round_up(htab_has_hash(htab) ?
+					    sizeof(struct htab_elem) :
+					    offsetof(struct htab_elem, hash), 8);
 
 	htab->elem_size = htab->key_offset + round_up(htab->map.key_size, 8);
 	if (percpu)
@@ -791,7 +804,7 @@ static struct htab_elem *lookup_elem_raw(struct bpf_htab *htab,
 	struct htab_elem *l;
 
 	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
-		if (htab_elem_hash(htab, l) == hash &&
+		if ((!htab_has_hash(htab) || htab_elem_hash(htab, l) == hash) &&
 		    !memcmp(htab_elem_key(htab, l), key, key_size))
 			return l;
 
@@ -812,7 +825,7 @@ static struct htab_elem *lookup_nulls_elem_raw(struct bpf_htab *htab,
 
 again:
 	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
-		if (htab_elem_hash(htab, l) == hash &&
+		if ((!htab_has_hash(htab) || htab_elem_hash(htab, l) == hash) &&
 		    !memcmp(htab_elem_key(htab, l), key, key_size))
 			return l;
 
@@ -3219,7 +3232,7 @@ static int rhtab_map_check_btf(struct bpf_map *map, const struct btf *btf,
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
2.55.0.229.g6434b31f56-goog

