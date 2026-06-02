Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6865B388873
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 20:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433178; cv=none; b=Jdk99SzgredcjqX/Kk7YF1k6abHoWHUbgiCeAh6Pq8mokOQFQ0d1k8ZZXx1WsqDDz8KnRfuyiJehAVaXlgo1o0sAwv1LzpdqrTQ3lT4RUzu/GT4+ik7Qabf/gZT3+U06AUN3vVxROG53irN9k2nex6kUniSVy+PbJnZYtF16tBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433178; c=relaxed/simple;
	bh=2Ur8BG1QiRNz1DlWoJrNZteP7MF4PS6ld+bIIaphP7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pcA3jg6iaTIC5Bj67MjOxy9fs9b+4f5EkUYcGCL1/IpZhTKuiMybLKpRs52PXUZHQnPS3TDBwkotFce9J/xpVTZ1vNz3MgHnyrhCZ/pGXT18g6SPlCMKUz+bpid+Lnxm0AK6EfuDMgmha+T7gCoOHOYct7/SMhNDm00wbgJqIlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+Pk4WnQ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+Pk4WnQ"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45ef82204c6so2252042f8f.3
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 13:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780433175; x=1781037975; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+YO3Vm4dXUqrddWNEHyQ6grF/d+cAc+C6LTVDvsvmh8=;
        b=P+Pk4WnQ6Fgl5dlAWh6UhCrdCLsr1zgpr97l524SxcJeR/OMXR6RrsFDnzkAl8I3v+
         OTpJsoKPzWHOrDKrK+IIqYdLsWe1jQNnPTyefBMePXBxJgOnclUi1UKEGkCmE0OK5OgV
         kOd0DEFePfwn43TYbeW7lKtlvILZvVErIXuS+xj3Y2y5avxAtYeg8kgbFKMp4LLtyZrI
         SU2wCvkof3o1RfX3e7SJ1MlwRDu6y29emxsxZfOFpKqwwN7j1h7egGBDYBOL5eesKGg2
         FVG9vMl4CsFk/hdoGjmL4GlduLSn1aj8/HuQebTJHmtyqXqFx1p7AW7KeOgqYVXyKe38
         szYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780433175; x=1781037975;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+YO3Vm4dXUqrddWNEHyQ6grF/d+cAc+C6LTVDvsvmh8=;
        b=e1T3sWZzWA6n6i6SZaBJU08cVILGA8ljjpp+aysVI0LjtiN/omFvkl0nGF/vPfkaLX
         KmcUiu/PbAGkN9QGsJYcNRxI4q6CKDuMDhqgAvihiZWjK17+Zqo86B4sTbjPyaz9ErEy
         C9fXBgjTY2AJPR6BnC8pGG1s7NtyoOAhoRrAxAshBkzIqUaEAy3R9aLsaAc2DTymglEs
         +ZEpyUk0QrN2Ctp7H8uNk0OrJNFHmuWBJxTZsBHOJ8d/Le8Sg2gWMg8il1w6cXOXYIyo
         hcSPzcUGLYMnen/o0TWUeCYYI7hQQhyZpsCx2PV5j0wS//EKt0fnGru3HEHZ5V2aRuEa
         5zMg==
X-Gm-Message-State: AOJu0YzCxO+FJg2re+3Q+12X3LuKkXSiOk1j11mi23TYrZUNqyJPiIQw
	TotcYQGRLZuiRsv4anWmuL4KeCnDTDoLQlZMLONyNivgvi8A52gNFlOL
X-Gm-Gg: Acq92OFNvN65PF96oO4Jdn33IaCaXJQaLPlfDKKTDXcRVy2wvoMKbeyZA1pMgribqox
	Bw3y8ibMtpZHo8Tr4NS3jYJd446uLufEvh7Egz8oSyuw+QakO3vYhNBLen+0rTSjIlAfLnL4K6h
	tPXJF0svh3XJWtscxcjUQjHYFLNEMbuSmSksTqfU5RuSwccGqR5kLybA1BKXWlysp8Cb9HiIk5r
	ngisFsMSbBGERZ2mDx/+FiAshOaqj52jTpAGJ0+d3J3aoso84+ErXepu2zEyMVKOe8Wz4aAK3+O
	UTialD3SWmlgHwREFCOcbokGZVK1MVgWexjIaKXySOJj66pmL9Tp6e54omKIi/6W0PTVgSJCGi8
	Q0NO6865LVPtu0JsSy4AuLjjEKHOOniJvpxY9Et4LX4V2N7GubPGo3nDmKEuEoEP7i4D/dwB/V2
	HkMT18O59z68pRucKdkFCUjlXvwITMDSY5OI0=
X-Received: by 2002:adf:f112:0:b0:460:c92:5b3d with SMTP id ffacd0b85a97d-46021791f88mr123415f8f.12.1780433174709;
        Tue, 02 Jun 2026 13:46:14 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc294sm3155130f8f.7.2026.06.02.13.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:46:14 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 02 Jun 2026 13:45:35 -0700
Subject: [PATCH bpf-next v6 06/11] bpf: Optimize word-sized keys for
 resizable hashtable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-rhash-v6-6-1bfd35a4184f@meta.com>
References: <20260602-rhash-v6-0-1bfd35a4184f@meta.com>
In-Reply-To: <20260602-rhash-v6-0-1bfd35a4184f@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780433165; l=6040;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=5Q7LV5QEKk8hJbE9z5gIEjlDQT3LxYddAg/iMIyT2BA=;
 b=EkrNC7xhrPvr9h4TZZkgNlEi9fvswwbzdkQWH3Ppo2CV5YtzmKeqIYNBV22MJBv3rwTZRbbO7
 RRZjSxzRTjPBfq1YrY6auM0DRjgAOa4wQv1KbQVUCrSGkbldquh27vP
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Specialize the lookup/update/delete/get_next_key/for_each callback/
batch paths for keys whose size matches sizeof(long) (4 bytes on
32-bit, 8 bytes on 64-bit). A static-const rhashtable_params lets
the compiler inline a custom XOR-fold hashfn and a single-word
equality cmpfn, eliminating the indirect jhash dispatch. The same
hashfn and cmpfn are installed into rhashtable's stored params so
the rehash worker and slow-path inserts agree with the inlined
fast paths.

Dispatch lives in a single rhtab_next_key() helper and inline branches
on map->key_size at the other callsites. The seq_file BPF iterator
uses rhashtable_walk_* and is unaffected.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/hashtab.c | 67 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 8686918dbc3e..600128c3e328 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2763,6 +2763,31 @@ static inline void *rhtab_elem_value(struct rhtab_elem *l, u32 key_size)
 	return l->data + round_up(key_size, 8);
 }
 
+/* Specialize hash function and objcmp for long sized key */
+static __always_inline int rhtab_key_cmp_long(struct rhashtable_compare_arg *arg,
+					      const void *ptr)
+{
+	const unsigned long key1 = *(const unsigned long *)arg->key;
+	const struct rhtab_elem *key2 = ptr;
+
+	return key1 != *(const unsigned long *)key2->data;
+}
+
+static __always_inline u32 rhtab_hashfn_long(const void *data, u32 len, u32 seed)
+{
+	u64 k = *(const unsigned long *)data;
+
+	return (u32)(k ^ (k >> 32)) ^ seed;
+}
+
+static const struct rhashtable_params rhtab_params_long = {
+	.head_offset = offsetof(struct rhtab_elem, node),
+	.key_offset  = offsetof(struct rhtab_elem, data),
+	.key_len     = sizeof(long),
+	.hashfn      = rhtab_hashfn_long,
+	.obj_cmpfn   = rhtab_key_cmp_long,
+};
+
 static struct bpf_map *rhtab_map_alloc(union bpf_attr *attr)
 {
 	struct rhashtable_params params;
@@ -2788,6 +2813,11 @@ static struct bpf_map *rhtab_map_alloc(union bpf_attr *attr)
 	params.nelem_hint = (u32)attr->map_extra;
 	params.automatic_shrinking = true;
 
+	if (rhtab->map.key_size == sizeof(long)) {
+		params.hashfn = rhtab_hashfn_long;
+		params.obj_cmpfn = rhtab_key_cmp_long;
+	}
+
 	err = rhashtable_init(&rhtab->ht, &params);
 	if (err)
 		goto free_rhtab;
@@ -2871,6 +2901,14 @@ static void rhtab_map_free(struct bpf_map *map)
 	bpf_map_area_free(rhtab);
 }
 
+static __always_inline struct rhtab_elem *
+rhtab_next_key(struct bpf_rhtab *rhtab, const void *prev_key)
+{
+	if (rhtab->map.key_size == sizeof(long))
+		return rhashtable_next_key(&rhtab->ht, prev_key, rhtab_params_long);
+	return rhashtable_next_key(&rhtab->ht, prev_key, rhtab_params);
+}
+
 static void *rhtab_lookup_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
@@ -2878,6 +2916,9 @@ static void *rhtab_lookup_elem(struct bpf_map *map, void *key)
 	/* Hold RCU lock in case sleepable program calls via gen_lookup */
 	guard(rcu)();
 
+	if (map->key_size == sizeof(long))
+		return rhashtable_lookup_likely(&rhtab->ht, key, rhtab_params_long);
+
 	return rhashtable_lookup_likely(&rhtab->ht, key, rhtab_params);
 }
 
@@ -2912,7 +2953,12 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, v
 	 * raw tracepoints, which we don't have in rhashtable.
 	 */
 	bpf_disable_instrumentation();
-	err = rhashtable_remove_fast(&rhtab->ht, &elem->node, rhtab_params);
+
+	if (rhtab->map.key_size == sizeof(long))
+		err = rhashtable_remove_fast(&rhtab->ht, &elem->node, rhtab_params_long);
+	else
+		err = rhashtable_remove_fast(&rhtab->ht, &elem->node, rhtab_params);
+
 	bpf_enable_instrumentation();
 
 	if (err)
@@ -3030,7 +3076,12 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
 
 	/* Prevent deadlock for NMI programs attempting to take bucket lock */
 	bpf_disable_instrumentation();
-	tmp = rhashtable_lookup_get_insert_fast(&rhtab->ht, &elem->node, rhtab_params);
+
+	if (map->key_size == sizeof(long))
+		tmp = rhashtable_lookup_get_insert_fast(&rhtab->ht, &elem->node, rhtab_params_long);
+	else
+		tmp = rhashtable_lookup_get_insert_fast(&rhtab->ht, &elem->node, rhtab_params);
+
 	bpf_enable_instrumentation();
 
 	if (tmp) {
@@ -3115,11 +3166,9 @@ static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key
 	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
 	struct rhtab_elem *elem;
 
-	elem = rhashtable_next_key(&rhtab->ht, key, rhtab_params);
-
-	/* if not found, return the first key */
+	elem = rhtab_next_key(rhtab, key);
 	if (PTR_ERR(elem) == -ENOENT)
-		elem = rhashtable_next_key(&rhtab->ht, NULL, rhtab_params);
+		elem = rhtab_next_key(rhtab, NULL);
 
 	if (IS_ERR(elem))
 		return PTR_ERR(elem);
@@ -3167,7 +3216,7 @@ static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
 	 * elements are deleted/inserted, there may be missed or duplicate
 	 * elements visited.
 	 */
-	while ((elem = rhashtable_next_key(&rhtab->ht, prev_key, rhtab_params))) {
+	while ((elem = rhtab_next_key(rhtab, prev_key))) {
 		if (IS_ERR(elem))
 			break;
 		num_elems++;
@@ -3270,7 +3319,7 @@ static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
 			goto free;
 		}
 	} else {
-		elem = rhashtable_next_key(&rhtab->ht, NULL, rhtab_params);
+		elem = rhtab_next_key(rhtab, NULL);
 	}
 
 	while (elem && !IS_ERR(elem) && total < max_count) {
@@ -3281,7 +3330,7 @@ static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
 		if (do_delete)
 			del_elems[total] = elem;
 
-		elem = rhashtable_next_key(&rhtab->ht, dst_key, rhtab_params);
+		elem = rhtab_next_key(rhtab, dst_key);
 		dst_key += key_size;
 		dst_val += value_size;
 		total++;

-- 
2.53.0-Meta

