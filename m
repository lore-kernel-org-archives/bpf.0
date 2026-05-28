Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42906401A3C
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779990471; cv=none; b=FAxhWCFzaWfnOZmSRzUOMgFBYH2txgUtebeK7hlGgl1urk8NJngZCeO/bx/PHZKc3HfFf8bYmtPgZ7WnszHJXQAe16LGDg2eLXDd4yW6qK8B23uRtLA+5/0a4LTZEFmGuo3+iYJQxT8rtwLhHYY0IUHLCV/G8wcdqH4rbnVF5Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779990471; c=relaxed/simple;
	bh=/hSG8Nrn5F1IgAE8PIDCTmF7eyOLysTdid5g/J/8Ie0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gWdnIrNN7BOyn3EfFvco+duYgAEKVrVfV7x3aOUy4cy6gf39FIIB2wXy7OPfq/UzivLm6pgHp8K2Ha2CueCEpi71T8o1dZ3cKle9FzEfHrw6nln8R8l0ainRf81Uyk0a2JTW9G+mNh+JwEqURMfx+JBhaMgby/PwB2AOO397BbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiW8JgL1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiW8JgL1"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so9160388f8f.0
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 10:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779990464; x=1780595264; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mBFSuNbpEBUTKm9Y+Hys4iMLo93IFdS2DI99Jg7XW7Q=;
        b=NiW8JgL1hPBDePUlPmMIharZ9IzxDaddmk3P1xxGfhA1Bqk1fD88HYxw04Czu6nwdP
         4OwtY8d3lidA3vtA9c4f4y5pUp21lDkzoRBcvCLQckCJ3El/dxjRea4nC0IDXllVL+5H
         B6qINqQTKzfnz5C4ofCSCp0GKoBN3brel2NqrrIepaosCc4dNrq8qD7INLQ9zLCtU8jZ
         1FsrsiMgllYF4x56EeJ7mRdKY9M4xgKU40e5gi9f6LnpyFJgDQlSxEL1NjQZZ8O4S6NP
         LOplqg2TNWo+Tfmp7ZGN+h+Vx1aiJS2xlidC+m1cYgETlzyZ2wU/8QLU8YU11lxzdetp
         v1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779990464; x=1780595264;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mBFSuNbpEBUTKm9Y+Hys4iMLo93IFdS2DI99Jg7XW7Q=;
        b=lor1Ped+x48VFS/z04fFMhUvTjUncoWYlVe6qU4/VPAH3CeVLRHXUMSQvlKW3dHtYj
         Or4WKJQhqpFvNwytJ3G+c9wnbtOwPnSo6z8TTmUmB8OViAB3jnDIzBogDfITAznXfG5Y
         gElCMxfehnnJyBRcTayXpiUjW4xXLRFDGZLU/a9ZrRQiXYyZ98yfv0hRJec/YwuEVLMP
         AabeTapCz64qS4g1Ef+BLMWTLKNh2NmwIgWlwv6394wsOyC8XD8RsRAKxBRyR2a0OZqf
         d8OvGzfHYwd/7ID8jufEXyJZnAtgu3Vo/JIPY1ierlOZH+ZSoJOv4yxaCUNosBcHCA9/
         wuLw==
X-Gm-Message-State: AOJu0Yw6AaKIbCl0B4D7jGWnhZnT1yCuKfHRwMWWzauNNMhIzO+6uRZ5
	D94oJJ+4kClai4kZrZZOhauVG1rY7VhrncTSgWSflnz/Lw3hlL4HMESS
X-Gm-Gg: Acq92OHpDuSflnQBRdA5u3/Uxnsr+AzOafQDHuqb2XNSW2zaTpQcvhK9h9DN0DtAXDM
	7/Kb1rbZCl1OMRicfAfqU62nH/Z6rl3wz30ovP26AfKkxBrmPSO67AK07Z0emXhzGrr+reh01BI
	tR/bmNPNFWIBjHs76Pvz2kyYNCFrtdHxvfarDNXlph5rxf2DplEWl+ki4SMlw+8IE0Uysa5SYNh
	AxihsGn08UqnG4H1oge2UaSsdv8uvSvysqp6pTaLHvTXwgpGOU5FNZn1u4mzKN6IplpgPkXa899
	9WH5E9xbMrxTwfqQnztLZ14hLLbKpZgQ4hxnKk3+X1wTliDvo0/0NEe/Fj6Rm+miZLT29VeXbD7
	Bv77+yYro7eyYoCPNObvxBR2GtvzBIyDVjdEwkcOZp9ImsmblPxqWLEO5RkQW6jlBOV8PX4Rs2K
	J0FJRMDPnVCCWpgR4bTKU1PBdN
X-Received: by 2002:a05:600c:8b8a:b0:48f:e044:927d with SMTP id 5b1f17b1804b1-490947adbd0mr36637025e9.10.1779990464390;
        Thu, 28 May 2026 10:47:44 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:44::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49091d57c0dsm84531295e9.0.2026.05.28.10.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 10:47:44 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 28 May 2026 10:47:17 -0700
Subject: [PATCH bpf-next v5 06/11] bpf: Optimize word-sized keys for
 resizable hashtable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-rhash-v5-6-7205191b6c57@meta.com>
References: <20260528-rhash-v5-0-7205191b6c57@meta.com>
In-Reply-To: <20260528-rhash-v5-0-7205191b6c57@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779990451; l=6754;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=sIiXTcFicublgrDq6AT1J4jUmgMP3VsAYPcwVeal7DM=;
 b=IHItRj5OpHA8ww422DOPE4bkrpM4j4LXnNsRgvhx1UuIEjQjVn4Nj6XUKY2JQfZjMCOLplb3/
 lARaKAUQ4MWB+MBnTSvqHOIjOUYZz7Z3DQnHw54iunk1w1gIvlLCKGB
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Specialize the lookup/update/delete/get_next_key/batch/iter paths for
keys whose size matches sizeof(long) (4 bytes on 32-bit, 8 bytes on
64-bit). A static-const rhashtable_params lets the compiler inline a
custom XOR-fold hashfn and a single-word equality cmpfn, eliminating
the indirect jhash dispatch. The same hashfn and cmpfn are installed
into rhashtable's stored params so the rehash worker and slow-path
inserts agree with the inlined fast paths.

Dispatch lives in a single rhtab_next_key() helper and inline branches
on map->key_size at the other callsites.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/hashtab.c | 74 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 60 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 50e9d57b2790..f141b69e3bb0 100644
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
 
 	if (!elem)
 		return -ENOENT;
@@ -3172,7 +3221,7 @@ static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
 	 * elements are deleted/inserted, there may be missed or duplicate
 	 * elements visited.
 	 */
-	while ((elem = rhashtable_next_key(&rhtab->ht, prev_key, rhtab_params))) {
+	while ((elem = rhtab_next_key(rhtab, prev_key))) {
 		if (IS_ERR(elem))
 			break;
 		num_elems++;
@@ -3278,8 +3327,7 @@ static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
 	if (ubatch)
 		elem = rhtab_lookup_elem(map, cursor);
 	else
-		elem = rhashtable_next_key(&rhtab->ht, NULL, rhtab_params);
-
+		elem = rhtab_next_key(rhtab, NULL);
 	while (elem && !IS_ERR(elem) && total < max_count) {
 		memcpy(dst_key, elem->data, key_size);
 		rhtab_read_elem_value(map, dst_val, elem, elem_map_flags);
@@ -3288,7 +3336,7 @@ static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
 		if (do_delete)
 			del_elems[total] = elem;
 
-		elem = rhashtable_next_key(&rhtab->ht, dst_key, rhtab_params);
+		elem = rhtab_next_key(rhtab, dst_key);
 		dst_key += key_size;
 		dst_val += value_size;
 		total++;
@@ -3365,8 +3413,7 @@ static void *bpf_rhash_map_seq_start(struct seq_file *seq, loff_t *pos)
 	struct rhtab_elem *elem;
 
 	rcu_read_lock();
-	elem = rhashtable_next_key(&info->rhtab->ht, key,
-				   rhtab_params);
+	elem = rhtab_next_key(info->rhtab, key);
 	if (IS_ERR_OR_NULL(elem))
 		return NULL;
 	if (*pos == 0)
@@ -3384,8 +3431,7 @@ static void *bpf_rhash_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	info->last_key_valid = true;
 	++*pos;
 
-	next = rhashtable_next_key(&info->rhtab->ht, info->last_key,
-				   rhtab_params);
+	next = rhtab_next_key(info->rhtab, info->last_key);
 	if (IS_ERR(next))
 		return NULL;
 	return next;

-- 
2.53.0-Meta

