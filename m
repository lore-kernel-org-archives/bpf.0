Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C9A3D6470
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661053; cv=none; b=dhuv/yrFqNjVRTB+reIW5OggvdZUubLrOoG2FSSZuhkJUhcaBZEnIywge68UEsshx4viFlZ16hQnEHJJVomkhCLZnFtXeR7MVn0iBKagUXvjVuHCYfWqYAx+nI6HZqXCOi+VUd334318sTfUqSL8GOe45gPqs4utvYlma+Ii6+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661053; c=relaxed/simple;
	bh=fSGD6DV6FuEM6vAm2D1d6khBVKAYRU5LJDRCm2c1wFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M/TltXRqEH/kEhx/5Da6wcpy9HXXRuIWmM4x/lki0OEd5FcQDGPN+H/4iqK8VqI+RiRxl3Ty9MTLfoxHk6n7c6YdHJhnbGaAb05Beqv0RO8XnhqHOg2dJ2h9bzlTAq45xdW36LZhRibRwMmXRmABNnyL3FQQdtFXHevBnK2+fxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHOCUiir; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHOCUiir"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-483487335c2so66339215e9.2
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 08:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775661050; x=1776265850; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8K0BgN96yL05Umj7UCkS5/U1Ihm/YuX1KQ3qgy9q8jM=;
        b=IHOCUiirxU9CHOfGujaK3gLKbOlK5msrc7Qo7A5TkCeOtDuMqzYnjVdRWqMwAQNvLz
         EqzJ5lj+fTrrblQC98dO0bdAEwJ188watv8soHla6ZUtsrrBB9mIfWnG7Tqv7ryYjcgt
         q54uojsaMKo6mW+rchAkBnTKM2XSxsSiQ06dRn/Cv8zpuVPN74w2pDwela+dMRr4mdRP
         rsnA1vBM9GDm8F5HZ3QkNID3A2HOhiB+uwFOxm9WQuW5JDoJ8DUwk96Rd4CN0f0kNNFy
         QKJos5llpAg0BRYGvmrMynjUgGJF29PBS1w/TlOEK98qm7h+Rm7wm7BsynNaWT2D+nM3
         9DAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661050; x=1776265850;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8K0BgN96yL05Umj7UCkS5/U1Ihm/YuX1KQ3qgy9q8jM=;
        b=FyEG2F1cAjz4NQzFx8Vk8YN0K/4+DarD8PHtxl4YcqyT9aECD8CgFOOGZueDEwrnrR
         cwB7qMzLykzvmCVV8tpPOPyvDQWcFI5KFhABp0HLWGpC2VLglG3sMObQQr+8CTytqEd4
         V0PIFAHFa6QGjie+bgDXtR2pU3TPcO4rKGST9iS9bAYvWbTS5IoV1RAXhZ7iLKa0Z/6i
         FicoU1jgXZPQGh69vhAyGPXtwhVUWoTIrQTsHj0WG1b10+hxZNJe95Wf8IhKNrxMcsBu
         cAqJ0YuM2zEWM94NSuzluQhoy1leHYt2JQaPda747eKq9cZZulqFEoVzxpXYt77kvrMH
         ogww==
X-Gm-Message-State: AOJu0YwqN1+Bk1wZwfrbf5scd0tTvNyxC6suUa8u6tR3gCdz7kZ3XMJE
	2kiSpC/CgmeAn60JJpcMy61nrpJi7hE62PpQ65EoBt8XmA3qjJzKW44X
X-Gm-Gg: AeBDievERKHcb7sVBSVp0STzJ3nkdROkHY55Fv37KPjNNdG3KtO7zdMQEWmHHlWzNWW
	RmD7NBLshMdZNyt1BzeAQEHsF05qfI5+oDq3+eBncJWjW4Nl2lLV/DTUeCh1fnpAPBqa5WgxfDH
	J2dqeIfl8dZV2u+R0mJbuSHoOYk206+0n8xnBiJdgbTmcJ4ELsCGRmG3VPqZOi8970SjwzNuyAI
	bkYwHJK3V1N2mazZeQJqypQTu0ZqKeBpVmU83Y6wmDs6ijzEpUeujHiBGX7oc7BkfzuBA4wvFM2
	nA231xxVfQoWOIip5+x9wt2EtGH2/bDgLQepi8COhUUQiOwJ1I+GDOTfwSeNBxajPV6W7bSTKgb
	Gq6x4/aYjigrsL+GmtRnqz8sq0dgT10nFZoouHvPvh8HYT+y27qgGmov1j2pOIAkWuoCsHTr6NF
	KxEEvX0hbFRguVvQ==
X-Received: by 2002:a05:6000:400e:b0:43b:3d83:f04f with SMTP id ffacd0b85a97d-43d29276c45mr30498931f8f.9.1775661050162;
        Wed, 08 Apr 2026 08:10:50 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:41::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5468sm58018577f8f.13.2026.04.08.08.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:10:49 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 08 Apr 2026 08:10:15 -0700
Subject: [PATCH RFC bpf-next v2 10/18] bpf: Allow timers, workqueues and
 task_work in resizable hashtab
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260408-rhash-v2-10-3b3675da1f6e@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775661029; l=5266;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=dl1UWbLhEJcija50XlK6TqSvxTEFyobHTC3hBSZTAcE=;
 b=kkGk2KfB8zgPN0oIRaCYk/whk8/0Lm6xri6NorPnaeX1cHRTD9rdOPutSq5A1FEa5BmuXa02c
 4iGfPMdBUUFDkz+3WxZJ80IFHIcf9f5ReBk9AXfJ2s2aIDGboD2sRL6
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Without this, users needing deferred callbacks in a dynamically-sized
map have no option — fixed-size htab is the only map supporting these
field types. Resizable hashtab should offer the same capability.

Properly clean up BTF record fields on element delete and map
teardown by wiring up bpf_obj_free_fields through a memory allocator
destructor, matching the pattern used by htab for non-prealloc maps.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/hashtab.c | 53 +++++++++++++++++++++++++++++++++++++++++-----------
 kernel/bpf/syscall.c |  1 +
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index a62093d8d1ae..4a631651bc70 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -501,28 +501,26 @@ static void htab_dtor_ctx_free(void *ctx)
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
@@ -539,9 +537,9 @@ static int htab_map_check_btf(struct bpf_map *map, const struct btf *btf,
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
@@ -2814,12 +2812,43 @@ static int rhtab_map_alloc_check(union bpf_attr *attr)
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
+static int rhtab_map_check_btf(struct bpf_map *map, const struct btf *btf,
+			       const struct btf_type *key_type,
+			       const struct btf_type *value_type)
+{
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+
+	return bpf_ma_set_dtor(map, &rhtab->ma, rhtab_mem_dtor);
+}
+
 static void rhtab_free_elem(void *ptr, void *arg)
 {
 	struct bpf_rhtab *rhtab = arg;
 	struct rhtab_elem *elem = ptr;
 
-	bpf_map_free_internal_structs(&rhtab->map, rhtab_elem_value(elem, rhtab->map.key_size));
+	rhtab_check_and_free_fields(rhtab, elem);
 	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
 }
 
@@ -2857,7 +2886,7 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem)
 	if (err)
 		return err;
 
-	bpf_map_free_internal_structs(&rhtab->map, rhtab_elem_value(elem, rhtab->map.key_size));
+	rhtab_check_and_free_fields(rhtab, elem);
 	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
 	return 0;
 }
@@ -2951,6 +2980,7 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
 
 	memcpy(elem->data, key, map->key_size);
 	copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
+	check_and_init_map_value(map, rhtab_elem_value(elem, map->key_size));
 
 	tmp = rhashtable_lookup_get_insert_fast(&rhtab->ht, &elem->node, rhtab->params);
 	if (tmp) {
@@ -3403,6 +3433,7 @@ const struct bpf_map_ops rhtab_map_ops = {
 	.map_free = rhtab_map_free,
 	.map_get_next_key = rhtab_map_get_next_key,
 	.map_release_uref = rhtab_map_free_internal_structs,
+	.map_check_btf = rhtab_map_check_btf,
 	.map_lookup_elem = rhtab_map_lookup_elem,
 	.map_lookup_and_delete_elem = rhtab_map_lookup_and_delete_elem,
 	.map_update_elem = rhtab_map_update_elem,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0a5ec417638d..792dbe288093 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1302,6 +1302,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 			case BPF_WORKQUEUE:
 			case BPF_TASK_WORK:
 				if (map->map_type != BPF_MAP_TYPE_HASH &&
+				    map->map_type != BPF_MAP_TYPE_RHASH &&
 				    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
 				    map->map_type != BPF_MAP_TYPE_ARRAY) {
 					ret = -EOPNOTSUPP;

-- 
2.52.0

