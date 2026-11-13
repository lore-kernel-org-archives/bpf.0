Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611340;
	b=VUqujqQsO2nva6BzdKI4dJf1geKZ4wdDE9OTnAsRgsEiaQTdx4nNPcWig4DnkOJugkWr
	 d02K560TPXHRLdPnbrmBkQ/eNz9fnWVECJ9B7bVpUtiG8D2Ob+GQfWQV86F97ap4QHxL0
	 dl6Y4Yc6GQ4RFXgDvsrO/HjKxkiKgvyhd883wu+CXCeBc6FibnKHmOQHoZ43lxhVnD8xS
	 S2X25DDwNdrKpB8YsRKr6a9yclfVwryM548I748udIXJGVxog7SjRAMCvpVgVhFOqhHCs
	 VtUwrnjPHy9plfy8cfbRM3OsBBQ4XqcPEHtAvbSa2SYEy6ElRoJK4i+27n5vrdhjGcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=koHAS1kxw4+RZOy5HKiNvlQJCowjePX6NSOH8g+MRpQ=;
	b=Bbma0/FGlntoFVfQR7heZwB3Oyru3Y5VAPIme9rcVR5ND98hVYxaw7Hkl7ef1xZYuzj4
	 LEoUqrxIuI0ZDKNXC7o8nSOtoBXhVpEcjq6hUJM/geCK+YCC0U8+5gmIPs41Rt8t7fjXj
	 bC07HOYBBUKZif9c8deEXJLYhQhF31TCJRT/90t95R74r6pHdQs7jiFTKalhA1r6U1GPN
	 DjAzjtw+14E3quA3i/B6TF9lTyYedVoO1wQ3/qQXQd/uOE0MZ/kcJvBMxRqpmX4lJN7XT
	 8rciEdoCFnOEnmmCBv1RqVgwZmVt8runw2b3oi1M6VJt0S166/nXwVlmvqtRdePUf0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DALwdOyX;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1821A606A329
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 23:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1821A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DALwdOyX
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b4a15c84c5so15150597b3.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 15:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794611336; x=1795216136; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=koHAS1kxw4+RZOy5HKiNvlQJCowjePX6NSOH8g+MRpQ=;
        b=DALwdOyX6hcntxU+DpVA48RU3WkicGcpBCgiYfxwe/jxbcrEcJPlrf5lnDrT5Y55wS
         BGfWFDuagv7udEwgHNrU/G67C8ox2/yusgCmZ8wetT+4H4ah4WKIIop3GQ7Mc+7eeuEh
         ov5X1XW9nGHtdlPXcwxfjS/WITleDS9NbhYVafrvw0YbGLcaPpxhRbN6jbDAgdk+5kVf
         ZEIJAp37I+gPDFmoWl9ihQplfKkKOgaq3IGChWuisgTnjuwVQxeSuLbmozzWmfrg14Fy
         wEJpatYNNvLgtTFcU3gr3Gk04QjsZ4+jSdm+PNEHfOCn9sOZf5y01zwSo4/vj9d9hvXV
         ZVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794611336; x=1795216136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=koHAS1kxw4+RZOy5HKiNvlQJCowjePX6NSOH8g+MRpQ=;
        b=pYOLtz6uHfJRNpAqSmMtaSYwip+O3ZCbVlU8VtZYqVMM+f4dcs70GBMqqJPJIZ5ede
         LkGQ1onn0E5ruJbplfyUYkzznCKEGVFG6YpxiCEh0IPfG96nMf4wQ32bePHmMOHIwqBX
         3nOjC3OjCPEtW3Lp6ZueXgdr9SDGON4hw98C3UtaS+w+1/VykDOSV8o3kvKydkOVCEv2
         8Lw8cEbhjZqv0Aj9ieEWjf29tzBzM+v04/JrwSghGXb9hhyXJwk1kp27O9rcefYjsMtx
         HPRS9tbqcQESa7IZj+9so6URg2mpuyeRZLNz3ZvJchjcdkAlUHzxFTBIOCqSWzEWl3qS
         VvKg==
X-Gm-Message-State: APuU4Z90uyKou5JLUJKwki2S1mZrdhnsp/7EyBJ0geoka8NKKojIUIrr
	4ahRC1oWZY8GdqFtLRVhwgXhjp5OTK0vJ3ULWWhQ6yjLT1iy12gjMbUIE6BDTnpH
X-Gm-Gg: AYBFou06D9NNDdvId4/D4yCxv3WWTOP14tj/QXXtUcbpfCYKdem28UpQ2w4a97pDhZm
	dOViO1EFrk/j5KYPYdca8xNwJRfF39UqqfLs9UCCFW9H6mDe6hz9svx/B2uI+xdF+Rfydq2xLTm
	ZQtf2f7LHTbPSDLs+bYU1JXUSHj8QWIg/B647VfhDBIZNLsKqUDYwrpgbTKGaxa3M3suvx+uamq
	AtruYkT0a19bo9KYqE6Ck8KHMMCIzGoqYZt9vzm12KefOAmpGF+fYUUplGiniVrJJIC0bPfjIxG
	MUf4VOj6Boxz8tnwzW74z9vhFfmetjWLaMvo+ljd8GpRZ+zfnFQV9X4dPzo7wCFB5U1Cw8CTjhM
	inVeTUhJ/F2L6h7kFmj5ZE+YLysz2l4y9Tkh/zPYYZaqziNnGlaUvzBXSPUAXTYvMUK3CwwcXPb
	Dj+Ia/LgIhPfr9L+Pv0ZPRz06ZOS9tS+YGOPMm6hRtt4hhsK10CWTidOQirdiF3fv8x7/i8F+SC
	zbWiSonK8od52+YdhTwwqRIpbJWOo7SmaVD0hN8MLxf4xUd5xkJ/dGVRdgbQlbNoaLWjFNEGp4z
	+IRaSPVLxfgX6Fdulk0=
X-Received: by 2002:a05:690c:7:b0:8b3:22c:b40c with SMTP id 00721157ae682-8b4aa0d0fb2mr26406697b3.7.1794611336070;
        Fri, 13 Nov 2026 15:08:56 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa987da8sm32172597b3.25.2026.11.13.15.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:08:55 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 13 Nov 2026 15:08:30 -0800
Subject: [PATCH RFC bpf-next 07/13] bpf: Keep values of BPF_F_INLINE_VALUE
 maps in the storage object
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-sls_f1-v1-7-1b9492bd3f97@meta.com>
References: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
In-Reply-To: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794611317; l=13716;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=G+r/fMVzjR2LFXCC8xrJCKYCyWyQkb01mF81k0Gftkg=;
 b=zQ1ZOFqsVEc+IxErxwRP8Ul26XZk9TTvS+mh8lMJsTRGp6fVdVDZFYqSMRSx9wxL+KXa5SyRk
 vTDGum0ItbUCRn9TGdvO31JY33MR91+wYOLsKGxEfI+1iGt2pJxM5Kn
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

A lookup of a normal map reads the storage object, a cache slot and
then the selem that holds the value. When the owner is cold, each read
can miss. A map with a slot finds its value at a fixed offset in the
object, with one tag compare, so a lookup has one dependent load less.

The tag is 8 bytes and comes from the claim number of the map, so old
value bytes rarely match it. It is written with a release store after
the value and read with an acquire load. 32-bit has no 8 byte acquire
and release, so slots are 64-bit only.

An update copies the value in place under the storage lock. Lockless
readers (programs, the syscall lookup, sk diag) can see a torn value, as
in array maps. KCSAN can report this race; it is intended.

A normal map pays one more test of a map field. There is no hint on
that test, so that inline maps do not pay for normal maps.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf_local_storage.h |  63 ++++++++++++++++++-
 kernel/bpf/bpf_local_storage.c    | 129 ++++++++++++++++++++++++++++++++++----
 net/core/bpf_sk_storage.c         |   9 ++-
 3 files changed, 180 insertions(+), 21 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 7a5f024622e6..d482ff6a1448 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -70,8 +70,16 @@ struct bpf_local_storage_data {
 	 *
 	 * Put it in the same cacheline as the data to minimize
 	 * the number of cachelines accessed during the cache hit case.
+	 *
+	 * An inline slot has the same layout, with a tag in place of smap:
+	 * the tag of the map whose value is in the slot. Any other tag (0
+	 * after a delete) means no value. A slot is not in an selem: never
+	 * apply SELEM() to it.
 	 */
-	struct bpf_local_storage_map __rcu *smap;
+	union {
+		struct bpf_local_storage_map __rcu *smap;
+		u64 inline_tag;
+	};
 	u8 data[] __aligned(8);
 };
 
@@ -195,6 +203,45 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
 				      struct bpf_local_storage_map *smap,
 				      struct bpf_local_storage_elem *selem);
+
+/*
+ * smap has an inline slot. The tag needs an 8 byte acquire and release, so
+ * slots are 64-bit only: on 32-bit, false lets the compiler drop the slot
+ * code. There is no hint on the inline_off test, so that inline maps do not
+ * pay for normal maps.
+ */
+static __always_inline bool
+bpf_local_storage_map_inline(const struct bpf_local_storage_map *smap)
+{
+	return IS_ENABLED(CONFIG_64BIT) && smap->inline_off;
+}
+
+/* The inline slot of smap, or NULL if local_storage does not hold it */
+static __always_inline struct bpf_local_storage_data *
+bpf_local_storage_inline(struct bpf_local_storage *local_storage,
+			 struct bpf_local_storage_map *smap)
+{
+	if (!bpf_local_storage_map_inline(smap) ||
+	    smap->inline_end > local_storage->obj_size)
+		return NULL;
+	return (void *)local_storage + smap->inline_off;
+}
+
+static inline u64 bpf_local_storage_inline_tag(const struct bpf_local_storage_map *smap)
+{
+	return (u64)~smap->inline_claim << 32 | smap->inline_claim;
+}
+
+/* The slot holds a value of smap */
+static __always_inline bool
+bpf_local_storage_inline_valid(struct bpf_local_storage_data *sdata,
+			       const struct bpf_local_storage_map *smap)
+{
+	/* Pairs with the tag release in an update: see the value */
+	return smp_load_acquire(&sdata->inline_tag) ==
+	       bpf_local_storage_inline_tag(smap);
+}
+
 /* If cacheit_lockit is false, this lookup function is lockless */
 static inline struct bpf_local_storage_data *
 bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
@@ -204,6 +251,15 @@ bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
 	struct bpf_local_storage_data *sdata;
 	struct bpf_local_storage_elem *selem;
 
+	/*
+	 * An object that holds the slot of smap never has an selem of smap:
+	 * the object size does not change, and a create puts the value in
+	 * the slot.
+	 */
+	sdata = bpf_local_storage_inline(local_storage, smap);
+	if (sdata)
+		return bpf_local_storage_inline_valid(sdata, smap) ? sdata : NULL;
+
 	/* Fast path (cache hit) */
 	sdata = rcu_dereference_check(local_storage->cache[smap->cache_idx],
 				      bpf_rcu_lock_held());
@@ -251,10 +307,11 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
 void bpf_selem_free(struct bpf_local_storage_elem *selem,
 		    bool reuse_now);
 
-int
+struct bpf_local_storage *
 bpf_local_storage_alloc(void *owner,
 			struct bpf_local_storage_map *smap,
-			struct bpf_local_storage_elem *first_selem);
+			struct bpf_local_storage_elem *first_selem,
+			void *value);
 
 struct bpf_local_storage_data *
 bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index b737b2e67c8a..31f62a2be62b 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -390,6 +390,8 @@ int bpf_local_storage_delete(void *owner, struct bpf_local_storage_map *smap)
 	struct bpf_local_storage __rcu **owner_ptr = owner_storage(smap, owner);
 	struct bpf_local_storage *local_storage;
 	struct bpf_local_storage_data *sdata;
+	unsigned long flags;
+	int err;
 
 	/* An inode can have no LSM blob, so no storage pointer */
 	local_storage = owner_ptr ? rcu_dereference_check(*owner_ptr, bpf_rcu_lock_held()) : NULL;
@@ -397,7 +399,24 @@ int bpf_local_storage_delete(void *owner, struct bpf_local_storage_map *smap)
 	if (!sdata)
 		return -ENOENT;
 
-	return bpf_selem_unlink(SELEM(sdata));
+	if (sdata != bpf_local_storage_inline(local_storage, smap))
+		return bpf_selem_unlink(SELEM(sdata));
+
+	/* As bpf_selem_unlink(): the result must not depend on the place */
+	if (in_nmi())
+		return -EOPNOTSUPP;
+
+	/* The value bytes stay: a program can still hold a pointer to them */
+	err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
+	if (err)
+		return err;
+	/* A racing delete can clear the tag before this one takes the lock */
+	if (sdata->inline_tag == bpf_local_storage_inline_tag(smap))
+		WRITE_ONCE(sdata->inline_tag, 0);
+	else
+		err = -ENOENT;
+	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
+	return err;
 }
 
 /*
@@ -565,20 +584,30 @@ static u32 bpf_local_storage_obj_size(struct bpf_local_storage_map *smap)
 	return end ? kmalloc_size_roundup(end) : sizeof(struct bpf_local_storage);
 }
 
-int bpf_local_storage_alloc(void *owner,
-			    struct bpf_local_storage_map *smap,
-			    struct bpf_local_storage_elem *first_selem)
+/*
+ * The first value for owner goes into first_selem or, if first_selem is NULL,
+ * into the inline slot of smap (value, or zeros if value is NULL). Return the
+ * new storage, so that the caller does not read the owner pointer again.
+ */
+struct bpf_local_storage *
+bpf_local_storage_alloc(void *owner, struct bpf_local_storage_map *smap,
+			struct bpf_local_storage_elem *first_selem, void *value)
 {
+	struct bpf_local_storage **owner_storage_ptr =
+		(struct bpf_local_storage **)owner_storage(smap, owner);
 	struct bpf_local_storage *prev_storage, *storage;
-	struct bpf_local_storage **owner_storage_ptr;
 	struct bpf_local_storage_map_bucket *b;
 	u32 size = bpf_local_storage_obj_size(smap);
+	struct bpf_local_storage_data *sdata;
 	unsigned long flags;
 	int err;
 
+	/* The new object holds the slot of an inline map: no selem for it */
+	WARN_ON_ONCE(first_selem && bpf_local_storage_map_inline(smap));
+
 	err = mem_charge(smap, owner, size);
 	if (err)
-		return err;
+		return ERR_PTR(err);
 
 	storage = bpf_map_kmalloc_nolock(&smap->map, size, __GFP_ZERO,
 					 NUMA_NO_NODE);
@@ -594,6 +623,24 @@ int bpf_local_storage_alloc(void *owner,
 	storage->mem_charge = size;
 	refcount_set(&storage->owner_refcnt, 1);
 
+	if (!first_selem) {
+		/*
+		 * Nobody can see storage before it is published, so fill the
+		 * slot with no lock. With no selem, nobody can find storage
+		 * through the map, so no bucket lock either. cmpxchg() orders
+		 * the slot before the pointer. sdata is not NULL:
+		 * bpf_local_storage_obj_size() covers the slot of smap.
+		 */
+		sdata = bpf_local_storage_inline(storage, smap);
+		if (value)
+			copy_map_value(&smap->map, sdata->data, value);
+		sdata->inline_tag = bpf_local_storage_inline_tag(smap);
+		if (likely(!cmpxchg(owner_storage_ptr, NULL, storage)))
+			return storage;
+		err = -EAGAIN;
+		goto uncharge;
+	}
+
 	bpf_selem_link_storage_nolock(storage, first_selem);
 
 	b = select_bucket(smap, storage);
@@ -601,8 +648,6 @@ int bpf_local_storage_alloc(void *owner,
 	if (err)
 		goto uncharge;
 
-	owner_storage_ptr =
-		(struct bpf_local_storage **)owner_storage(smap, owner);
 	/* Publish storage to the owner.
 	 * Instead of using any lock of the kernel object (i.e. owner),
 	 * cmpxchg will work with any kernel object regardless what
@@ -628,13 +673,53 @@ int bpf_local_storage_alloc(void *owner,
 	bpf_selem_link_map_nolock(b, first_selem);
 	raw_res_spin_unlock_irqrestore(&b->lock, flags);
 
-	return 0;
+	return storage;
 
 uncharge:
 	/* storage was never published: no reader can see it */
 	kfree_nolock(storage);
 	mem_uncharge(smap, owner, size);
-	return err;
+	return ERR_PTR(err);
+}
+
+/* Write the value of smap into its slot, in place */
+static struct bpf_local_storage_data *
+bpf_local_storage_update_inline(struct bpf_local_storage *local_storage,
+				struct bpf_local_storage_map *smap,
+				void *value, u64 map_flags)
+{
+	u64 tag = bpf_local_storage_inline_tag(smap);
+	struct bpf_local_storage_data *sdata;
+	unsigned long flags;
+	int err;
+
+	sdata = bpf_local_storage_inline(local_storage, smap);
+	err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
+	if (err)
+		return ERR_PTR(err);
+
+	/* As an empty list in the selem path: destroy() has started */
+	if (unlikely(bpf_local_storage_gone(local_storage)))
+		err = -EAGAIN;
+	else
+		err = check_flags(sdata->inline_tag == tag ? sdata : NULL, map_flags);
+	if (err)
+		goto unlock;
+
+	/*
+	 * Lockless readers (programs, the syscall lookup, sk diag) can see a
+	 * torn value. This race is intended, as in array maps. The init value
+	 * can be the old value in the slot: keep it.
+	 */
+	if (!value)
+		memset(sdata->data, 0, smap->map.value_size);
+	else if (value != sdata->data)
+		copy_map_value(&smap->map, sdata->data, value);
+	/* A reader that sees the tag must see the value */
+	smp_store_release(&sdata->inline_tag, tag);
+unlock:
+	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
+	return err ? ERR_PTR(err) : sdata;
 }
 
 /* sk cannot be going away because it is linking new elem
@@ -663,26 +748,44 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 
 	local_storage = rcu_dereference_check(*owner_storage(smap, owner),
 					      bpf_rcu_lock_held());
+	/* One gone() read decides slot or selem: a second read can differ */
 	if (!local_storage || bpf_local_storage_gone(local_storage)) {
 		/* Very first elem for the owner */
 		err = check_flags(NULL, map_flags);
 		if (err)
 			return ERR_PTR(err);
 
+		/* destroy() has started: no new object can be published */
+		if (local_storage && READ_ONCE(local_storage->dying))
+			return ERR_PTR(-EAGAIN);
+
+		if (bpf_local_storage_map_inline(smap)) {
+			/* Only destroy() frees the new object with the slot */
+			local_storage = bpf_local_storage_alloc(owner, smap, NULL,
+								value);
+			return IS_ERR(local_storage) ? ERR_CAST(local_storage) :
+			       bpf_local_storage_inline(local_storage, smap);
+		}
+
 		selem = bpf_selem_alloc(smap, owner, value, swap_uptrs);
 		if (!selem)
 			return ERR_PTR(-ENOMEM);
 
-		err = bpf_local_storage_alloc(owner, smap, selem);
-		if (err) {
+		local_storage = bpf_local_storage_alloc(owner, smap, selem, NULL);
+		if (IS_ERR(local_storage)) {
 			bpf_selem_free_unpublished(selem, smap);
 			mem_uncharge(smap, owner, smap->elem_size);
-			return ERR_PTR(err);
+			return ERR_CAST(local_storage);
 		}
 
 		return SDATA(selem);
 	}
 
+	/* An object without room for the slot keeps the value in an selem */
+	if (bpf_local_storage_inline(local_storage, smap))
+		return bpf_local_storage_update_inline(local_storage, smap,
+						       value, map_flags);
+
 	if ((map_flags & BPF_F_LOCK) && !(map_flags & BPF_NOEXIST)) {
 		/* Hoping to find an old_sdata to do inline update
 		 * such that it can avoid taking the local_storage->lock
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index a838be80ebbd..409213755feb 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -201,17 +201,16 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 			}
 			bpf_selem_link_storage_nolock(new_sk_storage, copy_selem);
 		} else {
-			ret = bpf_local_storage_alloc(newsk, smap, copy_selem);
-			if (ret) {
+			new_sk_storage = bpf_local_storage_alloc(newsk, smap,
+								 copy_selem, NULL);
+			if (IS_ERR(new_sk_storage)) {
+				ret = PTR_ERR(new_sk_storage);
 				bpf_selem_free(copy_selem, true);
 				atomic_sub(smap->elem_size,
 					   &newsk->sk_omem_alloc);
 				bpf_map_put(map);
 				goto out;
 			}
-
-			new_sk_storage =
-				rcu_dereference(copy_selem->local_storage);
 		}
 		bpf_map_put(map);
 	}

-- 
2.53.1-Meta

