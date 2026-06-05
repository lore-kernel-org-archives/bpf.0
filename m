Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0D94D90DA
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659702; cv=none; b=TQ1/m1Zhjeunk5rhCytRzp/llXuLLbAn0gkX4A+g32jaNQrxQsysiWUOIX3j69H/ZI7lpfkN9oUBKiR0ZYhKRu3l8irldndXgrTSgKwc5PLudQq635EV2KbQOs7SRLuDyHdu2IyDETrPpRB6JVNoRkDuq9ABbYNVMra3BGAYm48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659702; c=relaxed/simple;
	bh=gr7vX55Jq1Zmyk373oZv0CWy4e/izNb4DQjfyg39Gck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XfVaLMvoZpC4qQNHm4/9AU+4Qne1j/45WblPIzyGVjZyHWBjgPnEhVTvH5DNUiSSHfMqLEPNBYtQKIG+X5Hy18pJiP7cNW8En6JRkSl1lmTVl/I0eoDuWe3d6mj0EXLdJGRKwLMj31uBdZ3YDJEv7sQLvPE2usozpcDzjMKd4ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nth8xjgq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nth8xjgq"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b9318997so13473115e9.2
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 04:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780659699; x=1781264499; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sqCo31G19qIkfKSLST7ymSzkF+VAYrtN2P61/GULvaI=;
        b=Nth8xjgqYqcOkyHHEeciD+pNnoFq0+E3IgXIZfb3jZypjHVdLig/+xc3/lfOI6mboC
         NF6cOl/fjCOZe/0zVlru4tTwu9KGvgLxcWCvgGWOZdXWW8nRgbKJ/PBrJk4A361Nv2d1
         O4N/mjfMSMWsuV7WUw+sHJPky5EpnHPrqDl3JjmgWHHYg+mez+DblQVnJkhFDKgKCcut
         doSv8Bpuio7+AXd+wxMxlzucsQS1YXEkr4J5OqYJDvMXnnOwfPoUINFJHiCzJUL+lUzt
         FGDcAHiDJehTN2Y3DRjVHSQrQH9DvvBOy1o7R3ZJMHvjmhYzHvp1XknlSPoHdFWtxAkr
         5T4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780659699; x=1781264499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sqCo31G19qIkfKSLST7ymSzkF+VAYrtN2P61/GULvaI=;
        b=paDb0YXGYWa2F5bAMH1niOqxHCbxpX9w05P46G6+/joVTI5B04uTOrObAQ5uRO/axb
         CYldME6ZovHSSVnJJO+h2KCkiMOTXUuntsOVN7hP1Prqz+EL/5+CGQILBz6Rw4PWhAGz
         IkWdGuti0lT8pCcOwGT5SHGD0NzxIazA3ZUauVwfIbh4tz5chizWx5mG+pKI0KllaEzI
         FbItP3rtY9SfcWpFMXQq9je8NA2OY5YHjWz+uHrJwga/lffdCrqzBPerc/OT+6b0rwZb
         SJfqnONr02jP7dImM4XO48j3kNNnN89ZZAWpvzUrD5lIwIMZ0q+8MQEmq1UBjeGfIsKC
         kg8A==
X-Gm-Message-State: AOJu0Ywx2F49Lmi2KdoRhZTDLSeO1Z7l9l45/RfKylZ5LESOKPm6cLdg
	K2jKycTDSPkB4bszXctIk5ogKel/Mzrd1Ow/mRZlB6F240NVgn6fe7SW
X-Gm-Gg: Acq92OEFRb5/1mtMYiTfqKPAShbggNApgAI6gMqA5uIfHsX/MQX68xUUNjnDP41rrVc
	TbBbmrC1u+ea/Ch7z1rGtO+wnboJXbw4KHa8iVyCzeDfkT1vTHqzuMR8PMvnnJvo/wyAebe4Gqw
	TqwcyLSYgmf3IsaWOxQVNJMK52AduAVMbnxTNCAqsD531SoSgvHvUlNsDxTrqKRaJR5tEZpFrmj
	uKprudPYJPj7SJx3YL3X4nBBNF5YKzOCLgK8CpGdZWtpZzyaNCBqiCy2Iyf7hMsh0Gnwm7jMqg5
	9H8NlPgPtQhoc9puQp0ykbima9hqL/8U0HhKQbLdi2TSvxBH6iI0bugIanv0FI5ogme1ktJZsy8
	yQtd/yZA+UsY+VvVzwMSrTB+KmxBIMmhI+VPA1T47GUyw4nVuypLVuFGdhTqnXcg1UIPmkmy7XO
	ApE+Wg8B0IkHDip9VOsS455zNZ
X-Received: by 2002:a05:600c:4fc6:b0:48f:f7cc:f6f5 with SMTP id 5b1f17b1804b1-490c2614167mr49001965e9.31.1780659699346;
        Fri, 05 Jun 2026 04:41:39 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d2d11asm53674995e9.1.2026.06.05.04.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 04:41:38 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 05 Jun 2026 04:41:23 -0700
Subject: [PATCH bpf-next v7 06/12] bpf: Allow special fields in resizable
 hashtab
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-rhash-v7-6-5b8e05f8630d@meta.com>
References: <20260605-rhash-v7-0-5b8e05f8630d@meta.com>
In-Reply-To: <20260605-rhash-v7-0-5b8e05f8630d@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780659688; l=9507;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=SiMsAbp0NHpa8tKq7rCO7N8qVW35U0Ri1lf3dBvVCuI=;
 b=+JQU7Z/04vz5xF8G9rQanamBMrtr9nfpMtjPmpRFBdpz5heHlUal1RNrKD0rwe8ng4mJvWyKp
 1LIEd/ox7mGDZa+so2vRLXoI5bcXy5Yg2sYTgHSkEUH4NRNjKHEstx+
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add support for timers, workqueues, task work, spin locks and kptrs.
Without this, users needing deferred callbacks, BPF_F_LOCK, or
refcounted kernel pointers in a dynamically-sized map have no option -
fixed-size htab is the only map supporting these field types.
Resizable hashtab should offer the same capability.

kptr semantics under in-place updates are identical to array map.

Properly clean up BTF record fields on element delete and map
teardown by wiring up bpf_obj_free_fields through a memory allocator
destructor, matching the pattern used by htab for non-prealloc maps.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/hashtab.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++-----
 kernel/bpf/syscall.c |   3 ++
 2 files changed, 104 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index a149713d0953..7b9408b8320c 100644
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
@@ -2752,6 +2750,7 @@ struct bpf_rhtab {
 	struct rhashtable ht;
 	struct bpf_mem_alloc ma;
 	u32 elem_size;
+	bool freeing_internal;
 };
 
 static const struct rhashtable_params rhtab_params = {
@@ -2832,11 +2831,34 @@ static int rhtab_map_alloc_check(union bpf_attr *attr)
 	return htab_map_alloc_check(attr);
 }
 
+static void rhtab_check_and_free_fields(struct bpf_rhtab *rhtab,
+					struct rhtab_elem *elem)
+{
+	if (IS_ERR_OR_NULL(rhtab->map.record))
+		return;
+
+	bpf_obj_free_fields(rhtab->map.record,
+			    rhtab_elem_value(elem, rhtab->map.key_size));
+}
+
+static void rhtab_mem_dtor(void *obj, void *ctx)
+{
+	struct htab_btf_record *hrec = ctx;
+	struct rhtab_elem *elem = obj;
+
+	if (IS_ERR_OR_NULL(hrec->record))
+		return;
+
+	bpf_obj_free_fields(hrec->record,
+			    rhtab_elem_value(elem, hrec->key_size));
+}
+
 static void rhtab_free_elem(void *ptr, void *arg)
 {
 	struct bpf_rhtab *rhtab = arg;
 	struct rhtab_elem *elem = ptr;
 
+	bpf_map_free_internal_structs(&rhtab->map, rhtab_elem_value(elem, rhtab->map.key_size));
 	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
 }
 
@@ -2900,7 +2922,8 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, v
 		rhtab_read_elem_value(&rhtab->map, copy, elem, flags);
 		check_and_init_map_value(&rhtab->map, copy);
 	}
-
+	/* Release internal structs: kptr, bpf_timer, task_work, wq */
+	rhtab_check_and_free_fields(rhtab, elem);
 	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
 	return 0;
 }
@@ -2942,6 +2965,7 @@ static int rhtab_map_lookup_and_delete_elem(struct bpf_map *map, void *key, void
 static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *elem, void *value,
 				      u64 map_flags)
 {
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
 	void *old_val = rhtab_elem_value(elem, map->key_size);
 
 	if (map_flags & BPF_NOEXIST)
@@ -2951,6 +2975,17 @@ static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *el
 		copy_map_value_locked(map, old_val, value, false);
 	else
 		copy_map_value(map, old_val, value);
+
+	/*
+	 * Torn reads: a concurrent reader without BPF_F_LOCK may observe
+	 * the value mid-copy. Callers requiring consistent reads must use
+	 * BPF_F_LOCK, matching arraymap semantics.
+	 *
+	 * copy_map_value() skips special-field offsets, so old timers/
+	 * kptrs/etc. still sit in the slot. Cancel them after the copy
+	 * to match arraymap's update semantics.
+	 */
+	rhtab_check_and_free_fields(rhtab, elem);
 	return 0;
 }
 
@@ -2973,6 +3008,14 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
 	if (map_flags & BPF_EXIST)
 		return -ENOENT;
 
+	/*
+	 * Reject new insertions while map_release_uref cleanup walks the
+	 * table. Without this, new elements could keep triggering rehash
+	 * and prevent the walk from terminating.
+	 */
+	if (READ_ONCE(rhtab->freeing_internal))
+		return -EBUSY;
+
 	/* Check max_entries limit before inserting new element */
 	if (atomic_read(&rhtab->ht.nelems) >= map->max_entries)
 		return -E2BIG;
@@ -2983,6 +3026,7 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
 
 	memcpy(elem->data, key, map->key_size);
 	copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
+	check_and_init_map_value(map, rhtab_elem_value(elem, map->key_size));
 
 	/* Prevent deadlock for NMI programs attempting to take bucket lock */
 	bpf_disable_instrumentation();
@@ -3015,8 +3059,54 @@ static int rhtab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 	return insn - insn_buf;
 }
 
+static int rhtab_map_check_btf(struct bpf_map *map, const struct btf *btf,
+			       const struct btf_type *key_type,
+			       const struct btf_type *value_type)
+{
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+
+	return bpf_ma_set_dtor(map, &rhtab->ma, rhtab_mem_dtor);
+}
+
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
+	 * Block new insertions. Once observed, no new growth is triggered,
+	 * so any in-flight rehash will drain and the walker is guaranteed
+	 * to stop returning -EAGAIN. Treat -EAGAIN as "rehash in progress,
+	 * retry"; do not wait for the worker.
+	 */
+	WRITE_ONCE(rhtab->freeing_internal, true);
+
+	rhashtable_walk_enter(&rhtab->ht, &iter);
+	rhashtable_walk_start(&iter);
+
+	while ((elem = rhashtable_walk_next(&iter))) {
+		if (IS_ERR(elem)) {
+			if (PTR_ERR(elem) == -EAGAIN)
+				continue;
+			break;
+		}
+
+		bpf_map_free_internal_structs(map, rhtab_elem_value(elem, map->key_size));
+
+		if (need_resched()) { /* Avoid stalls on large maps */
+			rhashtable_walk_stop(&iter);
+			cond_resched();
+			rhashtable_walk_start(&iter);
+		}
+	}
+
+	rhashtable_walk_stop(&iter);
+	rhashtable_walk_exit(&iter);
+	WRITE_ONCE(rhtab->freeing_internal, false);
 }
 
 static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
@@ -3382,6 +3472,7 @@ const struct bpf_map_ops rhtab_map_ops = {
 	.map_free = rhtab_map_free,
 	.map_get_next_key = rhtab_map_get_next_key,
 	.map_release_uref = rhtab_map_free_internal_structs,
+	.map_check_btf = rhtab_map_check_btf,
 	.map_lookup_elem = rhtab_map_lookup_elem,
 	.map_lookup_and_delete_elem = rhtab_map_lookup_and_delete_elem,
 	.map_update_elem = rhtab_map_update_elem,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 1faae184de48..31a3b70a0b5d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1280,6 +1280,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 			case BPF_SPIN_LOCK:
 			case BPF_RES_SPIN_LOCK:
 				if (map->map_type != BPF_MAP_TYPE_HASH &&
+				    map->map_type != BPF_MAP_TYPE_RHASH &&
 				    map->map_type != BPF_MAP_TYPE_ARRAY &&
 				    map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE &&
 				    map->map_type != BPF_MAP_TYPE_SK_STORAGE &&
@@ -1294,6 +1295,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 			case BPF_WORKQUEUE:
 			case BPF_TASK_WORK:
 				if (map->map_type != BPF_MAP_TYPE_HASH &&
+				    map->map_type != BPF_MAP_TYPE_RHASH &&
 				    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
 				    map->map_type != BPF_MAP_TYPE_ARRAY) {
 					ret = -EOPNOTSUPP;
@@ -1305,6 +1307,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 			case BPF_KPTR_PERCPU:
 			case BPF_REFCOUNT:
 				if (map->map_type != BPF_MAP_TYPE_HASH &&
+				    map->map_type != BPF_MAP_TYPE_RHASH &&
 				    map->map_type != BPF_MAP_TYPE_PERCPU_HASH &&
 				    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
 				    map->map_type != BPF_MAP_TYPE_LRU_PERCPU_HASH &&

-- 
2.53.0-Meta

