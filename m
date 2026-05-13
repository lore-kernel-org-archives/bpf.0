Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A6D2DC76A
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778711832; cv=none; b=K7Zo9XrBnfq1AaCv+e55u/i+5yJm8RedRf/M8AeUe+QrNyRg1sRflt/ajveIfK963TDHIFbaeEX03H8CkG18VPr32mQG4eu0A7VbH+CQXsGh3MnlKthZInggcFrl8sg89PBsxE6nyamG1Kd1rK8igf0Eqp38fwdNsxyJlnreBZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778711832; c=relaxed/simple;
	bh=TYrX95/VlIN0CBFrMIh7mfaa1nN33o5ArYdIfqqIpis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UPIoFXrRQc35bi8L7lg9RQVSCZoCUEBPnjErNOomuGGDTHVU2nwC8I2GKE3gH3hDEDqjpBkvzVygJfEPWfMrfEORvPjPeUnEBC84VkqeyEwszSSB6TWqoC9zhdhDQ42zlMKnEYn4KgXNZR0hGdZFebKZpb6EbgyUOKmK5L0iAxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tATzNEeQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tATzNEeQ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso65123255e9.2
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778711829; x=1779316629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9eBaKFVskCqigYwuq5hh0wdGHybYwBy9AeODKSJ7Q38=;
        b=tATzNEeQWI8+dRRUAxrsPg1txyw9EBuu7UNL7fHWZL00k9PsGeAybeEebm71ZhXVr5
         A3itwPv2Yn/X5k+5kMm2WFCPhUgJb8l6dSa5Qk2WHhZ2OsUw/VIIfy5Mj0IxyvxAYsiL
         /Z9i/W6i0cAVkwxYyX1XKpeWOvAj4Ws8Wr+LHNeb6VVNe8IkGsyvA3ozx/j7pKaF0UI+
         RwAf8a8jwPqJ5nZvl2XhiGBZPa7NIYBUyILdjzA+HAL4TtcLEIYXeE4ZShcZ+DqVJykE
         2KQ1IvD5NxNJx/GpHKZdsf8b4TvkGfAGHV9mGerSe/5hJ5yliEThIY1Hpsj5AaGO09QV
         R+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778711829; x=1779316629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9eBaKFVskCqigYwuq5hh0wdGHybYwBy9AeODKSJ7Q38=;
        b=kdGCTz1cHIBpP/POlFMUXYC1SrjFj/yskKm5Yh7G4o8dRk97XdRKP5iC2IXuz08SNf
         /e43ZAOnI5t5QzslN7RKF2Br3dIkeS2/tNwiZ1o2zYnEr0wWg4BEDOiRRKRKmFzKh5CF
         1TaN42fdJCq02W8hYqv2cCT/GE9LYLA5n7A7jnr7NbGZpyagMi29oKVfm/6fKhJoEzUH
         TfLGbCybLgHG3Mk0s4Ol/SBgVSLsZuWX5SBbTPzi19ewcWl8hwQy6eTz19fTBoqNtmec
         Dch1Thnu43vxBvck3n/54xPhJ/YDRfjTgXpqdmjmUVxgW3JdqeH/nxYiQzCSZWIvCoAa
         b39Q==
X-Gm-Message-State: AOJu0YyfvulEumQpAm2v74xwZeTITlXCe7mEX6HWNeWkZywO71rJCoWf
	MYNq7VZ/Fg8/oZkTLq6iiOuB78sNgaK4uuSV2XjqWX/HMyP6Y7tmP9Kk
X-Gm-Gg: Acq92OF+Rqcg8w+qm9c77Y4s/8dpKFK/bfwMMK8sFveTak9xMBz+FAZURZzzRnI75SK
	HPRKV6CNgyThq0jmNB33oIert+rJ0D1WUmA1SHCGqU/YPJI7X3pdYPec1mADkat9c/KghD644mi
	87a7p3oodQpcf62uRg09I6I09AyjfDfn8zH1ZFB+ZCMoPmLKnqMfdEcAWJxKXYBHe74799/Ud3U
	IkyJBtHP1BXtnzuSYtkE50Iex96jMOHkgsP1ar0UUCUB2wSiTNSun3lkmOgXXX3dVFlKT8QPvRT
	j6Kd/rjN1b/w6yDqzhGpocW/kuY2sAbrNT5qvYOUUmKT3MEe/mBHD1jYNjgoRqnJnTqrD9F5Rgq
	lyi6zn7Sz+EtRUAq5A43LqVyJslgMSGdKwBESPCYffatJQJiN5TGdZcFBiCuB6R2NoLOD7kIOIz
	u0sjodYGMH14UU
X-Received: by 2002:a05:600c:468f:b0:48a:5339:ef0e with SMTP id 5b1f17b1804b1-48fc9a028bemr74290425e9.3.1778711829365;
        Wed, 13 May 2026 15:37:09 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19a0csm2027432f8f.20.2026.05.13.15.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 15:37:09 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 13 May 2026 15:36:09 -0700
Subject: [PATCH bpf-next v4 06/11] bpf: Optimize word-sized keys for
 resizable hashtable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-rhash-v4-6-dd3d541ccb0b@meta.com>
References: <20260513-rhash-v4-0-dd3d541ccb0b@meta.com>
In-Reply-To: <20260513-rhash-v4-0-dd3d541ccb0b@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778711817; l=6858;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=1vtFLPV5EtkI2BbtJRigPtdlnTZ33x1RxroRPTge3Fo=;
 b=SvEciDPd8tN3xrft8eLBWIVhwW0Q/5L+mH7Fdj8BLWITfpem344gyVn8+u94CoeKuP/WejioE
 h0dTbYalZSpDoEp1poxwkOyyjKI+kbsMWiLgNkWY+nqB4ULuZf5Qxbt
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
index 9cc41850dc79..b3ac6af11b2a 100644
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
@@ -3026,7 +3072,12 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
 
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
@@ -3111,11 +3162,9 @@ static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key
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
@@ -3168,7 +3217,7 @@ static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
 	 * elements are deleted/inserted, there may be missed or duplicate
 	 * elements visited.
 	 */
-	while ((elem = rhashtable_next_key(&rhtab->ht, prev_key, rhtab_params))) {
+	while ((elem = rhtab_next_key(rhtab, prev_key))) {
 		if (IS_ERR(elem))
 			break;
 		num_elems++;
@@ -3269,8 +3318,7 @@ static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
 	 * returns ERR_PTR(-ENOENT); the batch terminates with no elements
 	 * and userspace must restart from a NULL cursor.
 	 */
-	elem = rhashtable_next_key(&rhtab->ht, ubatch ? cursor : NULL,
-				   rhtab_params);
+	elem = rhtab_next_key(rhtab, ubatch ? cursor : NULL);
 	while (elem && !IS_ERR(elem) && total < max_count) {
 		memcpy(dst_key, elem->data, key_size);
 		rhtab_read_elem_value(map, dst_val, elem, elem_map_flags);
@@ -3279,7 +3327,7 @@ static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
 		if (do_delete)
 			del_elems[total] = elem;
 
-		elem = rhashtable_next_key(&rhtab->ht, dst_key, rhtab_params);
+		elem = rhtab_next_key(rhtab, dst_key);
 		dst_key += key_size;
 		dst_val += value_size;
 		total++;
@@ -3356,8 +3404,7 @@ static void *bpf_rhash_map_seq_start(struct seq_file *seq, loff_t *pos)
 	struct rhtab_elem *elem;
 
 	rcu_read_lock();
-	elem = rhashtable_next_key(&info->rhtab->ht, key,
-				   rhtab_params);
+	elem = rhtab_next_key(info->rhtab, key);
 	if (IS_ERR_OR_NULL(elem))
 		return NULL;
 	if (*pos == 0)
@@ -3375,8 +3422,7 @@ static void *bpf_rhash_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
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

