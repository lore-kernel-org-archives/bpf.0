Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9DE2BDC1C
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 01:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153301; cv=none; b=MnZkx4u4R3ySQ8mFBzoOrYcjJJDYcDcmAL3GjEosnVzxVTRgXaDf+yvig+dCFvsZCvFEF0/9zX69WDp2tNaJE/Y1sBY6kxyG5l9XiRkb1yhFs9IxGo9kyEh3MP9qY8X36ED4YnjjKFXtY45a4G0R5jps/PjREqgBTj0VgKBs0gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153301; c=relaxed/simple;
	bh=JSKVOPSagD55A9gb/cBGZPxLxhujJDx/XUrq6J27PK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j06v5esxuxZ0yqtGUgxOdzMpI8cd2/uD9DTJnCQIBdJ5t1ul/TYatL2i4E2CDXyjkUBp/DMGI5LUjRmGK1T9rMpaGcYCJ2znciSIVGmHX93vl6AEG5LMIBolnxu8jPn6JMNkFkeUexUPd8k0Fq0BSuZt1uMsO7eLO8OqtAeUaIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxP4HHT0; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxP4HHT0"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-651b4d09141so2886062d50.1
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 18:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779153299; x=1779758099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuDRRJPPxsOG54TlqJyF6K+H0kfBBHpE9DokbD8VtyI=;
        b=PxP4HHT0u+T3xPMouz6p+KC/U8c5N85qCY7dYgNKJFHyHz/hVX5jXYTXDGtQwGQHAm
         VTZZrb/kpJCS43aLf6B5mCc+wHqtsCnU4HUxDJL6dH/szLE2XUTW4M0KRc44xqIopwSd
         YRUhtqTk/owe7lzVo8QWHni52puHP5FGsn4qDHuNnwAVbBcbRNqdk5Mc/o07qSUucjM4
         UYMDWXLNR7vasW8v+ESYovVSPlSiszDurq6BiJQQxJxMniMRJ4uUj30aZnEr6Mmrp475
         FzLdYST1ct8FIC8zB0X7CXtRdAmG/khL5JjvgTK+LxLk1KOeW4VYMdiF/uWk1WF3GWc5
         7r9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779153299; x=1779758099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PuDRRJPPxsOG54TlqJyF6K+H0kfBBHpE9DokbD8VtyI=;
        b=a1g6sKVAF+DlFCteTxPF6OABH6P5o9G4yxNUQm7ljdPVishvCzOmKvtv33ZxuFIX1B
         FTXjX47zhBivD69+V7x4OQVprvQ06jg5qj7jL2yCVtOS6aWFS+afEQIt+eUxS6z1Clqp
         1zd7SO2yK3IAV3tiNaLOLEUpT7mhN6DH1W2kPYtpHuEr24uDqoB5XDhb2auOUaOpK3Dn
         aC9lC1qAjpQlzws+kZq+MDhooaBmNtRzg1hz1ray/jBFKQtWukNSOZRcZw2fnTUtsMKO
         zXZm8ffW1Kuw9D4Wiv+hoM7f6lIyWaiKrVfSIWfP5YQ/tWi/10vgev5Pn060kTwkUrut
         Irgw==
X-Forwarded-Encrypted: i=1; AFNElJ9F7jdWinuLUS3GqpOVpAMx1xhQS+vFb1UcYV4olc73wx8tgFrD4Tk3qPeUeQNTLbjcE/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUVT6QgAP/+348wdj9LL04UnjxzBlMzhnJ9k2kNJ8aWLWb7Fz9
	XTvBRoyNfWPAufY3tIQdWSUIJqiXqXetXboWRsECUWge85avBULcstwE
X-Gm-Gg: Acq92OE+2EqNroecWqud6+JYjfvK1DPa6vDQhX48h1tONMdNPpPsPS9yuhKhUhV75go
	/CMv5tOB9RrsirS/vY+T8SAsDIvXs8iYCfb6IcynFUJJMIsaub0UsNE2d77vYI+s8hXW7f/QEru
	bfxv3bPY7IjawRxPvkRUt0gc/10FlovvBbOGAGryG/4sHC013+bdG31wAeBDR4EC10gk7/t6uQj
	hWdMkPYcyOmyzE0h3xU/4Emsv9HzV0SKj+mMaPhjwx7klD4PVvmPmAXz8CprFNLwIOYiksMKDQq
	T6Lbvi6OG0NKhlNAwubtdEXBSz8jMy5BeZXx/nREW2tXy4Lg6ZxIQIhEK0upTBoXOZ6+rM4c2i8
	sa2ECYNgC6s00ndiXPfaLakPLyha9IQ72rgYJSMCo2QgKVbCARf8c9kd3Nz+uypvlMDINSORZlz
	kp5VkuSpMNa2AoUOt0jtrR/H2Iuu0iCXrJtJHKEbKp/0N7JXvd1aTQxPnnSfLyhu5HvZ99YAK/v
	QMznkA6U6Y=
X-Received: by 2002:a05:690e:4294:20b0:654:fd9:2e8c with SMTP id 956f58d0204a3-65e215f8938mr11401298d50.15.1779153298622;
        Mon, 18 May 2026 18:14:58 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:ab86:dbf9:c4df:2e70])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0db0b11esm7118675d50.11.2026.05.18.18.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:14:58 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	mic@digikod.net,
	Justin Suess <utilityemal77@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next 1/1] bpf: fix deadlock in special field destruction in NMI
Date: Mon, 18 May 2026 21:14:50 -0400
Message-ID: <20260519011450.1144935-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519011450.1144935-1-utilityemal77@gmail.com>
References: <20260519011450.1144935-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Relax bpf_obj_free_fields to only cancel/free async work in irq_disabled
contexts and defer unsafe free operations such as kptr dtors, list head
and rb root destruction to a later non-irq_disabled call driven by the
allocator or map free.

Detect fields that are unsafe to free under irqs_disabled at htab
creation time. When creating a hashtab with these fields, forcibly set
BPF_F_NO_PREALLOC and use the bpf memory allocator instead.

This must happen after the fields are checked, so convert the map to a
non-prealloc one if the special fields are present, but before the map
has been fully initialized.

Enable this fix for regular, percpu, and lru hashtabs.

This fixes a deadlock caused by updating/deleting map elements in an
NMI context by shifting the responsibility of freeing fields that are
unsafe to free in contexts like NMI to the memory allocators existing
mechanism for handling this.

Fixes: 14a324f6a67e ("bpf: Wire up freeing of referenced kptr")
Reported-by: Justin Suess <utilityemal77@gmail.com>
Closes: https://lore.kernel.org/bpf/20260421201035.1729473-1-utilityemal77@gmail.com/
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Link: https://lore.kernel.org/bpf/DIG0ONMVOP0L.3QFYUPWFSKWI4@gmail.com/
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 kernel/bpf/hashtab.c | 93 +++++++++++++++++++++++++++++++++++++++-----
 kernel/bpf/syscall.c |  8 +++-
 2 files changed, 89 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 3dd9b4924ae4..0db1dc8ae0be 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -130,6 +130,16 @@ struct htab_btf_record {
 	u32 key_size;
 };
 
+static inline bool htab_has_nmi_special_fields(const struct bpf_htab *htab)
+{
+	const struct btf_record *rec = htab->map.record;
+
+	if (IS_ERR_OR_NULL(rec))
+		return false;
+	return rec->field_mask & (BPF_KPTR_REF | BPF_KPTR_PERCPU | BPF_UPTR |
+				  BPF_LIST_HEAD | BPF_RB_ROOT);
+}
+
 static inline bool htab_is_prealloc(const struct bpf_htab *htab)
 {
 	return !(htab->map.map_flags & BPF_F_NO_PREALLOC);
@@ -522,13 +532,53 @@ static int htab_set_dtor(struct bpf_htab *htab, void (*dtor)(void *, void *))
 	return 0;
 }
 
+static int htab_convert_to_non_prealloc(struct bpf_htab *htab)
+{
+	bool percpu = htab_is_percpu(htab);
+	int err;
+
+	htab_free_prealloced_fields(htab);
+	free_percpu(htab->extra_elems);
+	htab->extra_elems = NULL;
+	prealloc_destroy(htab);
+	htab->map.map_flags |= BPF_F_NO_PREALLOC;
+
+	err = bpf_mem_alloc_init(&htab->ma, htab->elem_size, false);
+	if (err)
+		return err;
+	if (percpu) {
+		err = bpf_mem_alloc_init(&htab->pcpu_ma,
+					 round_up(htab->map.value_size, 8),
+					 true);
+		if (err) {
+			bpf_mem_alloc_destroy(&htab->ma);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 static int htab_map_check_btf(struct bpf_map *map, const struct btf *btf,
 			      const struct btf_type *key_type, const struct btf_type *value_type)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
+	int err;
+
+	if (!htab_has_nmi_special_fields(htab)) {
+		if (htab_is_prealloc(htab))
+			return 0;
+	} else {
+		if (htab_is_lru(htab))
+			return 0;
+
+		if (htab_is_prealloc(htab)) {
+			err = htab_convert_to_non_prealloc(htab);
+			if (err)
+				return err;
+		}
+	}
 
-	if (htab_is_prealloc(htab))
-		return 0;
 	/*
 	 * We must set the dtor using this callback, as map's BTF record is not
 	 * populated in htab_map_alloc(), so it will always appear as NULL.
@@ -1355,7 +1405,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 					  bool percpu, bool onallcpus)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
-	struct htab_elem *l_new, *l_old;
+	struct htab_elem *l_new = NULL, *l_old;
 	struct hlist_nulls_head *head;
 	void *old_map_ptr = NULL;
 	unsigned long flags;
@@ -1387,8 +1437,17 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 		goto err;
 
 	if (l_old) {
-		/* Update value in-place */
-		if (percpu) {
+		if (htab_has_nmi_special_fields(htab)) {
+			l_new = alloc_htab_elem(htab, key, value, key_size,
+						hash, percpu, onallcpus,
+						l_old, map_flags);
+			if (IS_ERR(l_new)) {
+				ret = PTR_ERR(l_new);
+				goto err;
+			}
+			hlist_nulls_add_head_rcu(&l_new->hash_node, head);
+			hlist_nulls_del_rcu(&l_old->hash_node);
+		} else if (percpu) {
 			pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
 					value, onallcpus, map_flags);
 		} else {
@@ -1408,6 +1467,8 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 	}
 err:
 	htab_unlock_bucket(b, flags);
+	if (l_old && htab_has_nmi_special_fields(htab) && !ret)
+		free_htab_elem(htab, l_old);
 	if (old_map_ptr)
 		map->ops->map_fd_put_ptr(map, old_map_ptr, true);
 	return ret;
@@ -1443,7 +1504,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	 * to remove older elem from htab and this removal
 	 * operation will need a bucket lock.
 	 */
-	if (map_flags != BPF_EXIST) {
+	if (map_flags != BPF_EXIST || htab_has_nmi_special_fields(htab)) {
 		l_new = prealloc_lru_pop(htab, key, hash);
 		if (!l_new)
 			return -ENOMEM;
@@ -1460,11 +1521,21 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 		goto err;
 
 	if (l_old) {
-		bpf_lru_node_set_ref(&l_old->lru_node);
+		if (htab_has_nmi_special_fields(htab)) {
+			pcpu_init_value(htab,
+					htab_elem_get_ptr(l_new, key_size),
+					value, onallcpus, map_flags);
+			hlist_nulls_add_head_rcu(&l_new->hash_node, head);
+			hlist_nulls_del_rcu(&l_old->hash_node);
+			bpf_lru_node_set_ref(&l_new->lru_node);
+			l_new = NULL;
+		} else {
+			bpf_lru_node_set_ref(&l_old->lru_node);
 
-		/* per-cpu hash map can update value in-place */
-		pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
-				value, onallcpus, map_flags);
+			/* per-cpu hash map can update value in-place */
+			pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
+					value, onallcpus, map_flags);
+		}
 	} else {
 		pcpu_init_value(htab, htab_elem_get_ptr(l_new, key_size),
 				value, onallcpus, map_flags);
@@ -1479,6 +1550,8 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 		bpf_map_dec_elem_count(&htab->map);
 		bpf_lru_push_free(&htab->lru, &l_new->lru_node);
 	}
+	if (l_old && !ret && htab_has_nmi_special_fields(htab))
+		htab_lru_push_free(htab, l_old);
 	return ret;
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6600e126fbfb..1f52453d5a2f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -839,6 +839,8 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 			break;
 		case BPF_KPTR_REF:
 		case BPF_KPTR_PERCPU:
+			if (irqs_disabled())
+				break;
 			xchgd_field = (void *)xchg((unsigned long *)field_ptr, 0);
 			if (!xchgd_field)
 				break;
@@ -854,16 +856,18 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 			}
 			break;
 		case BPF_UPTR:
+			if (irqs_disabled())
+				break;
 			/* The caller ensured that no one is using the uptr */
 			unpin_uptr_kaddr(*(void **)field_ptr);
 			break;
 		case BPF_LIST_HEAD:
-			if (WARN_ON_ONCE(rec->spin_lock_off < 0))
+			if (irqs_disabled() || WARN_ON_ONCE(rec->spin_lock_off < 0))
 				continue;
 			bpf_list_head_free(field, field_ptr, obj + rec->spin_lock_off);
 			break;
 		case BPF_RB_ROOT:
-			if (WARN_ON_ONCE(rec->spin_lock_off < 0))
+			if (irqs_disabled() || WARN_ON_ONCE(rec->spin_lock_off < 0))
 				continue;
 			bpf_rb_root_free(field, field_ptr, obj + rec->spin_lock_off);
 			break;
-- 
2.53.0

