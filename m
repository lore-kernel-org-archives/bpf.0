Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AFF3FADE2
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777060287; cv=none; b=V2KhanJx5tn2J05OikpfZ+YaX7xV2KS50rnlsPT6B6o0zTydlvRvTAb5pbzwrGX9MD9FJO2p4EezBdNQhjlgsWySYH5FzLtTKdUlYTqkW7kmXP92Dv1c1b8PumWaSbaLT3qi3h/+Ld9mz4O8iNVaECukhclTzG9n3D6kkXtLTco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777060287; c=relaxed/simple;
	bh=BD2ZQnFOgZEH58S3aduRZ8mLPx0GwVWkuGHu94SkLjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=irh14k877/bWUg0IWwRSN38dhXMS/nnjgho+PXHRcsRH+TGdBS0SCpmscGcosjjkcEiUyDg1NHbz/RPActgcwI8cOQkwU0XGGCO0KIkazRxQZCOqhZJ9IvULul1qPRItMgwgMD89FqsVEAW93sN7h49x84aC9VLGsIadawBf3G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQkz47Vu; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQkz47Vu"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38e97e73234so68735561fa.1
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 12:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777060273; x=1777665073; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MoyBnBGOD1ISCjYIhUA7jdQZ4YeAxNZu5mw1wKzqRBs=;
        b=RQkz47VuInsiuZzv00Yey7/tP7kU2gKTAyBC5mXv4/JT6qdHcSb21ov83MczeA5pVD
         zXqEs4Pv5YqdhPpQOVTpIYdJdgSYHBxhlK9OBzD47Z6bdOT185DJkMPj2WFFBJF8u5HF
         pzDc+YPfxYg5sxBNrNuFS4tcZuv0Z59WmGqMTz3htmk0L2/FlKEZOwY7fAdseioRPW4A
         rby3yF5JQgwBbuQu6ZNT6ZeLojF/XB9p09CyuhSNPCPvNPUkGIW6Zpbpr+UZwqBJkByt
         OUaCWSXVZfxtb8h/DtrTz48qUNZeva6c8BXNNo16RAOU+hm/p/2EIqRAFJ7i/QLhSzRx
         uBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777060273; x=1777665073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MoyBnBGOD1ISCjYIhUA7jdQZ4YeAxNZu5mw1wKzqRBs=;
        b=MJDtMtDBjCcaT1rhJC8LouO0lVC45Z5F4VhznY/Kj4ANnZi35PFit9qRtNqSFI0kCr
         ZDFsb2lxjFXIlvumsVp9lDXRr2zon/jNdxROTcK605kdx9thPaGVKZWkV4/Gq2dWxRFs
         FVkAaOeCvGc0BhC88q6QZ4ify9TTCs5J9X3agKytZbiMfUVg+LRXh/IKVTUUdID9A0Qr
         tdZiU/yCOFE4c5IG+X6rPbGpHbU1MufDByEuPne06VMdT6wknOH3mBNCyvf9u26Ueiep
         PQR2HY84DBqZWA00ugRP5vcHIA3banSNtfk/Bueinsh6NweZOxR57OEuVOuZ1PnOh5Wq
         7Fyw==
X-Gm-Message-State: AOJu0Yy/mQHLxZzf9DTchyNvGpQt3mW/roq8mAhNFUmInYOpqrKyRc7s
	5Wdkoww1HSCakHzSIY71DxGh4us/jwknY37KAXGlfsXrCOgitcLBK65L
X-Gm-Gg: AeBDievSQTPSPMsCOE75nwtyUljlxPfbKn+1PDFG1+3Zf2DIHQTRBMUCd/VXM6fzNmt
	o3778Z+Xe0J62tIdG19XEQlRwRVDXRISGmtTcQtXM/fNszYPpzYawmqQdJ3/yhGHlcrGgkwteb9
	JWVTxpxJKv9yf6kh04MH58F8//+YC7PMbElPK+S55hFsGlj+9tTSA4sNmu+5ZxB21CV/S480FUx
	pWoXb3P1+tSjtKT2TqdY3Aef82nm5tB6SxXTj4VLwuaNer093jmms6xuIPQdBjW8KcSXO1/fSb+
	8FvtH+G9NKjP4yWABtTbnKmanRantwSO7Ov4VreZlWaLHQRdBbPi8x2nd+jATA1ttk3ys9SOJyp
	iT1KUhCijnVy3pfhuFt4cWUaO952k49/s4DGFLlwQDUHymbJ/gIgmSIu7L61ZVOtE+QG9U71qu9
	UmwqA2+Lh6mEzUwhopcc8gzJraWQxXbqa0Sg==
X-Received: by 2002:a2e:a586:0:b0:385:9b50:91a8 with SMTP id 38308e7fff4ca-38ec783f350mr111167921fa.15.1777060272800;
        Fri, 24 Apr 2026 12:51:12 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb6f3a30sm49832541fa.24.2026.04.24.12.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 12:51:12 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 24 Apr 2026 12:50:47 -0700
Subject: [PATCH bpf-next v3 05/10] bpf: Allow timers, workqueues and
 task_work in resizable hashtab
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-rhash-v3-5-d0fa0ce4379b@meta.com>
References: <20260424-rhash-v3-0-d0fa0ce4379b@meta.com>
In-Reply-To: <20260424-rhash-v3-0-d0fa0ce4379b@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777060253; l=5407;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=xB6HOEXz+wMXvUvXOsJVnTTSnBTU0vfVT1uUU3NbMTs=;
 b=83VCz6Nod111dCKNME72xTrwzIIv8YYNpwaqYS1UHanJbMfqkioJ/l1njCcfKOMdmlZmkUuyZ
 68HrAZb4uB0BkLwZrJev15QGTajNHwsmPxVIkPOcKm2n0PQ65gSghFq
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Without this, users needing deferred callbacks in a dynamically-sized
map have no option - fixed-size htab is the only map supporting these
field types. Resizable hashtab should offer the same capability.

Properly clean up BTF record fields on element delete and map
teardown by wiring up bpf_obj_free_fields through a memory allocator
destructor, matching the pattern used by htab for non-prealloc maps.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/hashtab.c | 42 +++++++++++++++++++++++++++++++++---------
 kernel/bpf/syscall.c |  1 +
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 000caa2c7f4c..ba03797b8960 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -497,28 +497,26 @@ static void htab_dtor_ctx_free(void *ctx)
 	kfree(ctx);
 }
 
-static int htab_set_dtor(struct bpf_htab *htab, void (*dtor)(void *, void *))
+static int bpf_ma_set_dtor(struct bpf_map *map, struct bpf_mem_alloc *ma,
+			   void (*dtor)(void *, void *))
 {
-	u32 key_size = htab->map.key_size;
-	struct bpf_mem_alloc *ma;
 	struct htab_btf_record *hrec;
 	int err;
 
 	/* No need for dtors. */
-	if (IS_ERR_OR_NULL(htab->map.record))
+	if (IS_ERR_OR_NULL(map->record))
 		return 0;
 
 	hrec = kzalloc(sizeof(*hrec), GFP_KERNEL);
 	if (!hrec)
 		return -ENOMEM;
-	hrec->key_size = key_size;
-	hrec->record = btf_record_dup(htab->map.record);
+	hrec->key_size = map->key_size;
+	hrec->record = btf_record_dup(map->record);
 	if (IS_ERR(hrec->record)) {
 		err = PTR_ERR(hrec->record);
 		kfree(hrec);
 		return err;
 	}
-	ma = htab_is_percpu(htab) ? &htab->pcpu_ma : &htab->ma;
 	bpf_mem_alloc_set_dtor(ma, dtor, htab_dtor_ctx_free, hrec);
 	return 0;
 }
@@ -535,9 +533,9 @@ static int htab_map_check_btf(struct bpf_map *map, const struct btf *btf,
 	 * populated in htab_map_alloc(), so it will always appear as NULL.
 	 */
 	if (htab_is_percpu(htab))
-		return htab_set_dtor(htab, htab_pcpu_mem_dtor);
+		return bpf_ma_set_dtor(map, &htab->pcpu_ma, htab_pcpu_mem_dtor);
 	else
-		return htab_set_dtor(htab, htab_mem_dtor);
+		return bpf_ma_set_dtor(map, &htab->ma, htab_mem_dtor);
 }
 
 static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
@@ -2891,6 +2889,7 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem)
 	if (err)
 		return err;
 
+	rhtab_check_and_free_fields(rhtab, elem);
 	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
 	return 0;
 }
@@ -2945,11 +2944,15 @@ static int rhtab_map_lookup_and_delete_elem(struct bpf_map *map, void *key, void
 static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *elem, void *value,
 				      u64 map_flags)
 {
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
 	void *old_val = rhtab_elem_value(elem, map->key_size);
 
 	if (map_flags & BPF_NOEXIST)
 		return -EEXIST;
 
+	/* Free special fields, and reuse memory similar to arraymap */
+	rhtab_check_and_free_fields(rhtab, elem);
+
 	if (map_flags & BPF_F_LOCK)
 		copy_map_value_locked(map, old_val, value, false);
 	else
@@ -2986,6 +2989,7 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
 
 	memcpy(elem->data, key, map->key_size);
 	copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
+	check_and_init_map_value(map, rhtab_elem_value(elem, map->key_size));
 
 	tmp = rhashtable_lookup_get_insert_fast(&rhtab->ht, &elem->node, rhtab->params);
 	if (tmp) {
@@ -3033,6 +3037,25 @@ static struct rhtab_elem *rhtab_iter_next(struct rhashtable_iter *iter)
 
 static void rhtab_map_free_internal_structs(struct bpf_map *map)
 {
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	struct rhashtable_iter iter;
+	struct rhtab_elem *elem;
+
+	if (!bpf_map_has_internal_structs(map))
+		return;
+
+	/*
+	 * An element can be processed twice if rhashtable resized concurrently.
+	 * Special structs freeing handles duplicate cancel_and_free.
+	 */
+	rhashtable_walk_enter(&rhtab->ht, &iter);
+	rhashtable_walk_start(&iter);
+
+	for (elem = rhtab_iter_next(&iter); elem; elem = rhtab_iter_next(&iter))
+		bpf_map_free_internal_structs(map, rhtab_elem_value(elem, map->key_size));
+
+	rhashtable_walk_stop(&iter);
+	rhashtable_walk_exit(&iter);
 }
 
 static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
@@ -3414,6 +3437,7 @@ const struct bpf_map_ops rhtab_map_ops = {
 	.map_free = rhtab_map_free,
 	.map_get_next_key = rhtab_map_get_next_key,
 	.map_release_uref = rhtab_map_free_internal_structs,
+	.map_check_btf = rhtab_map_check_btf,
 	.map_lookup_elem = rhtab_map_lookup_elem,
 	.map_lookup_and_delete_elem = rhtab_map_lookup_and_delete_elem,
 	.map_update_elem = rhtab_map_update_elem,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6c4369691d87..fffca2f484eb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1295,6 +1295,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 			case BPF_WORKQUEUE:
 			case BPF_TASK_WORK:
 				if (map->map_type != BPF_MAP_TYPE_HASH &&
+				    map->map_type != BPF_MAP_TYPE_RHASH &&
 				    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
 				    map->map_type != BPF_MAP_TYPE_ARRAY) {
 					ret = -EOPNOTSUPP;

-- 
2.52.0

