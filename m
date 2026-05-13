Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C751739A815
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 22:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778711829; cv=none; b=cINHyiNEiOv5HDoYu5kVVQKKwnD1dooGtsfLbM1EOV/JecqFRyxZhS7mHsq+Aj3FFU2z67KLUQ6yxb+V0WgacCwMd13xyoOt7QK7Xsf6dMqswolunVBKPG8FN/L5OQUxIpMx2ihJk1kW+qfZBu3Us8GtjdX4BFtDCiBdf+p9PSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778711829; c=relaxed/simple;
	bh=P65hXMdphRiv3gNkM/7S08NwAcwSKhIX7EeY07Bv/Ck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iuz8SOv6m5mGkm+R5CBIa6PNVJEyVR8BN3GS1aXMDEwYa6B5hS709fuXAi1cfSqIpeY349Iru+lRJCtyczjDh8EitACHkzpM21qYwxlwS6BEkV4hpFV7Pcp+kqly5AgpgAcshJSxMWBv/J4/JcJP83YFIfjbcMU1NUq8e0UrEpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvJGXSe4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvJGXSe4"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48374014a77so64389195e9.3
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778711826; x=1779316626; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NO8TOFM8sdqvgefq82BgziP17uVcmHROGlllyuc1Sjo=;
        b=DvJGXSe4K0lRLvH2Ps5qaIrYdmXGuIPbWSo4qYB+c+/M17SnjSzqkBAPkpN5VmMo9+
         4O64tz0usglWNe1RLwHmeBjbXEnHM9Ae3ve8AjCKLIEyrYXKMhvivKuNUrsRu+5sU+Sx
         7FOoUmt78K62kUBR9eyoJAVbsH5eRzwuplysTHHKhTwt0qVV+L5qrybOnbkmLu41fRbA
         ZcErPSVeMvOwhYrjKR7TgnYO4VmgAkA7j8ny4RT6Ygx3o3b1mbIhT4BoU3TPRI6vDem9
         qBehLVKbYhGQITNL6uvGYmb+wPWW0Ij52Rx6BWN0KczmudATLbPO16otetzBF3QXjK3r
         XmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778711826; x=1779316626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NO8TOFM8sdqvgefq82BgziP17uVcmHROGlllyuc1Sjo=;
        b=ek6ZI6FpS60FWhARk9YGoVEnTZ+V7Y4aDzp4KoY7A13q7rJMUKF72zKMiVo9eWyvX/
         Kbk9rzlYTsVfXfoMnMzdPULxM3MfqiHeNW5Dj3OcsYuYwqNjKYmDSwPQoj4TLl0SPeC1
         0cIOzrfo20hAZxqBjodjoVaYcrYNBal51/MCau0uwSQ2cidsHSq7ylUFPH+yyjgtAeB+
         i6eoNaYMg79wwonbYtE8i1xAIWA+mvCw1r5ktwBpqLP9qDVRZXVqNOjvVsTsMqWfJrqV
         862B7zLOURmxzHxcEY5lifTIrquYi4w86J9zqRJ7izcs9aGR8Dzi3WOv1Gk0Er/JVifd
         J2lw==
X-Gm-Message-State: AOJu0YxV/KpcqYpTYgyEYCXuMfQJXx1tCNM/FqMqgA2EJBui0Rty4VZ3
	KxJZmIu8CGLZAHWcqNbv2whR8xZjAfTK6hJn+hLyi88/S2kEemn2zfrn
X-Gm-Gg: Acq92OFYxgV3GIZJP1eEQ4Mn6OeEgtBounHD/AqRyGCZcKSH4rejT3L4jDddrxUXC7i
	dctbwfeBxnA4y7WZgHmI6tAioudwL+aUmRJghTh4QjDfGx70u9FT0aHtyjKVAZ6hqyg1PW+l3/5
	BZs6wUgyYwQxuOiLe+xuEI9Q8hCWaG9+83EjbVsPsdZ2a7Ar94OAOqNpgbzNa3SDMgOyyT601eP
	NltVAZg+o8Pd6t77+IkyloETI2dEs8PK7sfmb3uQ7t5noEgsGa81hmeHPrJq90tl//VJ7wg+bEE
	EjVFUiuTo+DgS15val+uMDScbOdhSIfDJE/OjDtz/lc9Vb2yLLQR2D69xm45VrbGYRJ19gbNher
	c0Ll6god11H2gpWVD7xO9Spuvpvvlpny9qX2brM/XZBXWAtrWoedwxEAkUtpAHX8YUsY/2o+vRX
	eY3WSi8puH8/B3LxhnfB24DdQ=
X-Received: by 2002:a05:600c:138e:b0:489:e126:b757 with SMTP id 5b1f17b1804b1-48fc9a51304mr77784745e9.25.1778711826113;
        Wed, 13 May 2026 15:37:06 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd64cead5sm16578235e9.10.2026.05.13.15.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 15:37:05 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 13 May 2026 15:36:07 -0700
Subject: [PATCH bpf-next v4 04/11] bpf: Implement iteration ops for
 resizable hashtab
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-rhash-v4-4-dd3d541ccb0b@meta.com>
References: <20260513-rhash-v4-0-dd3d541ccb0b@meta.com>
In-Reply-To: <20260513-rhash-v4-0-dd3d541ccb0b@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778711817; l=11071;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=5K6t36E/LpCdyTaaAYpLEn0zP/fgVUFKuHhNXo3CiG4=;
 b=tmtqOuP4qqhVYv3sfaZ3DlyW5qHEuyF6jOUdaOPtmTtyZFYWQtE+zJ5jHA/7DxLNOt2aOWC6Z
 NFWfKePNq9rB7hQfnvm/yzpZQameCN/3ove4EBMQwh59tkr++E0DCYJ
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Implement rhtab_map_get_next_key(), batch lookup/lookup-and-delete,
and the seq_file BPF iterator for BPF_MAP_TYPE_RHASH.

All three use rhashtable_next_key() with the previous key as cursor.
This avoids the rhashtable walker state machine and its spinlock
acquisition per enter/exit, and lets callers stay stateless across
syscalls. ERR_PTR(-ENOENT) from rhashtable_next_key() (cursor was
concurrently deleted) is handled per callsite: get_next_key falls
back to the first key (matches BPF UAPI semantics of htab); the
seq_file iterator and batch terminate iteration.

Also implements rhtab_map_mem_usage() to report memory consumption.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/hashtab.c  | 290 ++++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/bpf/map_iter.c |   3 +-
 2 files changed, 284 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index da1754e1a525..61eb88cb9229 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -3021,68 +3021,342 @@ static void rhtab_map_free_internal_structs(struct bpf_map *map)
 }
 
 static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
+	__must_hold_shared(RCU)
 {
-	return -EOPNOTSUPP;
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	struct rhtab_elem *elem;
+
+	elem = rhashtable_next_key(&rhtab->ht, key, rhtab_params);
+
+	/* if not found, return the first key */
+	if (PTR_ERR(elem) == -ENOENT)
+		elem = rhashtable_next_key(&rhtab->ht, NULL, rhtab_params);
+
+	if (!elem)
+		return -ENOENT;
+
+	memcpy(next_key, elem->data, map->key_size);
+	return 0;
 }
 
 static void rhtab_map_seq_show_elem(struct bpf_map *map, void *key, struct seq_file *m)
 {
+	void *value;
+
+	/* Guarantee that hashtab value is not freed */
+	guard(rcu)();
+
+	value = rhtab_map_lookup_elem(map, key);
+	if (!value)
+		return;
+
+	btf_type_seq_show(map->btf, map->btf_key_type_id, key, m);
+	seq_puts(m, ": ");
+	btf_type_seq_show(map->btf, map->btf_value_type_id, value, m);
+	seq_putc(m, '\n');
 }
 
 static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
 				void *callback_ctx, u64 flags)
 {
-	return -EOPNOTSUPP;
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	void *prev_key = NULL;
+	struct rhtab_elem *elem;
+	int num_elems = 0;
+	void *key_buf = NULL;
+	u64 ret = 0;
+
+	if (flags != 0)
+		return -EINVAL;
+
+	/*
+	 * Buffer for stashing the cursor across rcu_read_unlock() in the
+	 * cond_resched path.
+	 */
+	key_buf = kmalloc_nolock(map->key_size, 0, NUMA_NO_NODE);
+	if (!key_buf)
+		return -ENOMEM;
+
+	rcu_read_lock();
+	/*
+	 * Best-effort iteration: if rhashtable is concurrently resized or
+	 * elements are deleted/inserted, there may be missed or duplicate
+	 * elements visited.
+	 */
+	while ((elem = rhashtable_next_key(&rhtab->ht, prev_key, rhtab_params))) {
+		if (IS_ERR(elem))
+			break;
+		num_elems++;
+		ret = callback_fn((u64)(long)map,
+				  (u64)(long)elem->data,
+				  (u64)(long)rhtab_elem_value(elem, map->key_size),
+				  (u64)(long)callback_ctx, 0);
+		if (ret)
+			break;
+
+		prev_key = elem->data;	/* valid while RCU held */
+
+		if (need_resched()) {
+			memcpy(key_buf, elem->data, map->key_size);
+			rcu_read_unlock();
+			cond_resched();
+			rcu_read_lock();
+			prev_key = key_buf;
+		}
+	}
+	rcu_read_unlock();
+
+	kfree_nolock(key_buf);
+	return num_elems;
 }
 
 static u64 rhtab_map_mem_usage(const struct bpf_map *map)
 {
-	return 0;
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	u64 num_entries;
+
+	/* Excludes rhashtable bucket overhead (~ nelems * sizeof(void *) at 75% load). */
+	num_entries = atomic_read(&rhtab->ht.nelems);
+	return sizeof(struct bpf_rhtab) + rhtab->elem_size * num_entries;
+}
+
+static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
+					       const union bpf_attr *attr,
+					       union bpf_attr __user *uattr,
+					       bool do_delete)
+{
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	void __user *uvalues = u64_to_user_ptr(attr->batch.values);
+	void __user *ukeys = u64_to_user_ptr(attr->batch.keys);
+	void __user *ubatch = u64_to_user_ptr(attr->batch.in_batch);
+	void *cursor = NULL, *keys = NULL, *values = NULL, *dst_key, *dst_val;
+	struct rhtab_elem **del_elems = NULL;
+	u32 max_count, total, key_size, value_size, i;
+	bool has_next_cursor = false;
+	struct rhtab_elem *elem;
+	u64 elem_map_flags, map_flags;
+	int ret = 0;
+
+	elem_map_flags = attr->batch.elem_flags;
+	ret = bpf_map_check_op_flags(map, elem_map_flags, BPF_F_LOCK);
+	if (ret)
+		return ret;
+
+	map_flags = attr->batch.flags;
+	if (map_flags)
+		return -EINVAL;
+
+	max_count = attr->batch.count;
+	if (!max_count)
+		return 0;
+
+	if (put_user(0, &uattr->batch.count))
+		return -EFAULT;
+
+	key_size = map->key_size;
+	value_size = map->value_size;
+
+	keys = kvmalloc_array(max_count, key_size, GFP_USER | __GFP_NOWARN);
+	values = kvmalloc_array(max_count, value_size, GFP_USER | __GFP_NOWARN);
+	if (do_delete)
+		del_elems = kvmalloc_array(max_count, sizeof(void *),
+					   GFP_USER | __GFP_NOWARN);
+	cursor = kmalloc(key_size, GFP_USER | __GFP_NOWARN);
+
+	if (!keys || !values || !cursor || (do_delete && !del_elems)) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	if (ubatch && copy_from_user(cursor, ubatch, key_size)) {
+		ret = -EFAULT;
+		goto free;
+	}
+
+	dst_key = keys;
+	dst_val = values;
+	total = 0;
+
+	rcu_read_lock();
+
+	/*
+	 * If the cursor key was concurrently deleted, rhashtable_next_key()
+	 * returns ERR_PTR(-ENOENT); the batch terminates with no elements
+	 * and userspace must restart from a NULL cursor.
+	 */
+	elem = rhashtable_next_key(&rhtab->ht, ubatch ? cursor : NULL,
+				   rhtab_params);
+	while (elem && !IS_ERR(elem) && total < max_count) {
+		memcpy(dst_key, elem->data, key_size);
+		rhtab_read_elem_value(map, dst_val, elem, elem_map_flags);
+		check_and_init_map_value(map, dst_val);
+
+		if (do_delete)
+			del_elems[total] = elem;
+
+		elem = rhashtable_next_key(&rhtab->ht, dst_key, rhtab_params);
+		dst_key += key_size;
+		dst_val += value_size;
+		total++;
+
+		/* Bail to userspace to avoid stalls. */
+		if (need_resched())
+			break;
+	}
+
+	if (elem && !IS_ERR(elem)) {
+		/* Stash next key as the cursor */
+		memcpy(cursor, elem->data, key_size);
+		has_next_cursor = true;
+	}
+
+	if (do_delete) {
+		for (i = 0; i < total; i++)
+			rhtab_delete_elem(rhtab, del_elems[i], NULL, 0);
+	}
+
+	rcu_read_unlock();
+
+	if (total == 0) {
+		ret = -ENOENT;
+		goto free;
+	}
+
+	/* No more elements after this batch. */
+	if (!has_next_cursor)
+		ret = -ENOENT;
+
+	if (copy_to_user(ukeys, keys, total * key_size) ||
+	    copy_to_user(uvalues, values, total * value_size) ||
+	    put_user(total, &uattr->batch.count) ||
+	    (has_next_cursor &&
+	     copy_to_user(u64_to_user_ptr(attr->batch.out_batch),
+			  cursor, key_size))) {
+		ret = -EFAULT;
+		goto free;
+	}
+
+free:
+	kfree(cursor);
+	kvfree(keys);
+	kvfree(values);
+	kvfree(del_elems);
+	return ret;
 }
 
 static int rhtab_map_lookup_batch(struct bpf_map *map, const union bpf_attr *attr,
 				  union bpf_attr __user *uattr)
 {
-	return -EOPNOTSUPP;
+	return __rhtab_map_lookup_and_delete_batch(map, attr, uattr, false);
 }
 
 static int rhtab_map_lookup_and_delete_batch(struct bpf_map *map, const union bpf_attr *attr,
 					     union bpf_attr __user *uattr)
 {
-	return -EOPNOTSUPP;
+	return __rhtab_map_lookup_and_delete_batch(map, attr, uattr, true);
 }
 
 struct bpf_iter_seq_rhash_map_info {
 	struct bpf_map *map;
 	struct bpf_rhtab *rhtab;
+	void *last_key;
+	bool last_key_valid;
 };
 
 static void *bpf_rhash_map_seq_start(struct seq_file *seq, loff_t *pos)
+	__acquires_shared(RCU)
 {
-	return NULL;
+	struct bpf_iter_seq_rhash_map_info *info = seq->private;
+	void *key = *pos > 0 && info->last_key_valid ? info->last_key : NULL;
+	struct rhtab_elem *elem;
+
+	rcu_read_lock();
+	elem = rhashtable_next_key(&info->rhtab->ht, key,
+				   rhtab_params);
+	if (IS_ERR_OR_NULL(elem))
+		return NULL;
+	if (*pos == 0)
+		++*pos;
+	return elem;
 }
 
 static void *bpf_rhash_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	return NULL;
+	struct bpf_iter_seq_rhash_map_info *info = seq->private;
+	struct rhtab_elem *elem = v;
+	void *next;
+
+	memcpy(info->last_key, elem->data, info->map->key_size);
+	info->last_key_valid = true;
+	++*pos;
+
+	next = rhashtable_next_key(&info->rhtab->ht, info->last_key,
+				   rhtab_params);
+	if (IS_ERR(next))
+		return NULL;
+	return next;
+}
+
+static int __bpf_rhash_map_seq_show(struct seq_file *seq,
+				    struct rhtab_elem *elem)
+{
+	struct bpf_iter_seq_rhash_map_info *info = seq->private;
+	struct bpf_iter__bpf_map_elem ctx = {};
+	struct bpf_iter_meta meta;
+	struct bpf_prog *prog;
+	int ret = 0;
+
+	meta.seq = seq;
+	prog = bpf_iter_get_info(&meta, elem == NULL);
+	if (prog) {
+		ctx.meta = &meta;
+		ctx.map = info->map;
+		if (elem) {
+			ctx.key = elem->data;
+			ctx.value = rhtab_elem_value(elem, info->map->key_size);
+		}
+		ret = bpf_iter_run_prog(prog, &ctx);
+	}
+
+	return ret;
 }
 
 static int bpf_rhash_map_seq_show(struct seq_file *seq, void *v)
 {
-	return 0;
+	return __bpf_rhash_map_seq_show(seq, v);
 }
 
 static void bpf_rhash_map_seq_stop(struct seq_file *seq, void *v)
+	__releases_shared(RCU)
 {
+	if (!v)
+		(void)__bpf_rhash_map_seq_show(seq, NULL);
+
+	rcu_read_unlock();
 }
 
 static int bpf_iter_init_rhash_map(void *priv_data, struct bpf_iter_aux_info *aux)
 {
+	struct bpf_iter_seq_rhash_map_info *info = priv_data;
+	struct bpf_map *map = aux->map;
+
+	info->last_key_valid = false;
+	info->last_key = kmalloc(map->key_size, GFP_USER);
+	if (!info->last_key)
+		return -ENOMEM;
+
+	bpf_map_inc_with_uref(map);
+	info->map = map;
+	info->rhtab = container_of(map, struct bpf_rhtab, map);
 	return 0;
 }
 
 static void bpf_iter_fini_rhash_map(void *priv_data)
 {
+	struct bpf_iter_seq_rhash_map_info *info = priv_data;
+
+	kfree(info->last_key);
+	bpf_map_put_with_uref(info->map);
 }
 
 static const struct seq_operations bpf_rhash_map_seq_ops = {
diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index 261a03ea73d3..4a2aafbe28b4 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -119,7 +119,8 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
 		is_percpu = true;
 	else if (map->map_type != BPF_MAP_TYPE_HASH &&
 		 map->map_type != BPF_MAP_TYPE_LRU_HASH &&
-		 map->map_type != BPF_MAP_TYPE_ARRAY)
+		 map->map_type != BPF_MAP_TYPE_ARRAY &&
+		 map->map_type != BPF_MAP_TYPE_RHASH)
 		goto put_map;
 
 	key_acc_size = prog->aux->max_rdonly_access;

-- 
2.53.0-Meta

