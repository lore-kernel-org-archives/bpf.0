Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73474D90D7
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659702; cv=none; b=ibeh9CXC2XOwz0ZtYYk6dRC2b86Ba4dQrOlGkpaEmB87fNPdnCPxjZHhaGweI8gWjYv8CuZIg6WIfqjY4KYkEeSM7LQmLyTwVPqpZcm/iYn5SSDmWlbz8FMJreBH1sPKPcBPUl7SkbLkeGWYsoe+BrfSVpPErsYRCpkwMQZghGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659702; c=relaxed/simple;
	bh=TcXwXIfja2D3ywtL/9RK1K11MNz3OBXpjmaqVRvi7DE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PKFCDOEIibAASo6FO7W0BbbGkbhFR3KF9XA3PC65Z9YqzJQMwfTCwT865GH1W+v6jwOecxMwrH5s1hjkKXAHT5Jf5/Mr8jcScm5mjwfrIoCQHzQTihIM2pO5J9vY2+1U4zgQEERKgIfkZmEJP1zlHuMmgKYQZrzl28ea4cQTD1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJ+fLBqg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJ+fLBqg"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso21430845e9.3
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 04:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780659698; x=1781264498; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nwFCBaBURqas3MjWOAhvUrfGWLow6Q8yJBiAcC+Cr7E=;
        b=gJ+fLBqgdQ4G3qYwc3FM8weNnVRdQV4pD8mxKYJeAV4ipq8BgPmi2t9taMxnpy2+CY
         v/I1gnLciht13KVq1PNoDYUdXgyXUa1VC3IcHckT3V7cHF5C5adkQc6HucMXof24kNoD
         zciMTmFYDIFnTmLgDK776nrltiVKdb3VafTO+suEzf96I16nK7PBR4djKFXu+LCnD37p
         dNxAknsWGlID1L1qDxG7geMCRGVvGBUxD1tUr9i7vtWaz/VwO5G+Zd+VoKgSU7ufc+tO
         2ZGiwNMmdGgN4rzKG4+eA/acL3VxWTzso3Cq20uXiqUYX+w/I4LE5ey4fq82NWzifnp8
         it1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780659698; x=1781264498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nwFCBaBURqas3MjWOAhvUrfGWLow6Q8yJBiAcC+Cr7E=;
        b=W87WE4o8UXNVHuKPikIGlZ4TLQc8dTVoPrrvfbqa3T3IPGeCDQAK9hqYVmD2VUN02B
         xJqdBwbnQz/kG8HFU0UKGw22a72yj8l5xgzH5UeI2pnnRcDr1QeV1JkmJZ29Xk6Pbecj
         hpD7HbqTqG8HCEtpZyM6KhBVEfPCfGximYOAsqR2k66jQ/3xkT7/IXaa9GUbIZHbJWqZ
         R1xPEIpBN0Yce2XJ/dywy+B30u0RcdGJ85ZA+YK6SM6zl4pc7/y/IFuRnj5cdu6pUwun
         CuTeNakoFvV94ZyxdJQApUn25W5Pvx0iI0KufGTO5sE/TNQP4474mhywvIbxkhERjv31
         jXiQ==
X-Gm-Message-State: AOJu0YxlCdWpq65iElErPyCng0kcUL3EEDsmAvbcabbF3GA6FAjcR0Bj
	w0ynciztvTs5O6pZjmZiX/1GzGfuGwlRdTDHJUcs1UyOBSawDXXcX03L
X-Gm-Gg: Acq92OGjSH5KrEg5W2t4kf9rawhr1vetgfmPSVT0mJHJSlgBT5znseN6MUhWuCQBXhG
	cOXSfqugVqfjMiys04hJaUCKjrI0JZFgMxXp8tOFbmQqLT7/ogTp1FoC790XYl8/RlbutwrFZrq
	NyKzF10LXEpnI5soiPcFDr0XXPOwaa3lb+LMWvLytmhv+OZdlE99zYV+ik06TSv4oVg6vAUiAJ9
	RMJKluP5jIAxtAJqhVjCVISsF17z3CkStbcHWOLZEB2OUu6q4viXQeYNEgJVAac3nbTwIVSLFnz
	6pXzzOP4bxNnkEPFh4lRqKouDCPPeEaBZlav81kQqR36qcV+z8vWQZOWYHs6M1tlGruG+wW+DQJ
	1n54nXsq+mrSvP7RJ2BTDAn4Njdgfhgbp9x/t5W6KsuJ6m33usZoRUCpOesl9hthR3xDm81In+r
	UTyShjIv7Z+p+biLKKNkR0
X-Received: by 2002:a05:600c:3510:b0:490:ab8b:1bb3 with SMTP id 5b1f17b1804b1-490c25dd857mr45136115e9.18.1780659697908;
        Fri, 05 Jun 2026 04:41:37 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcb13sm24498006f8f.2.2026.06.05.04.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 04:41:37 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 05 Jun 2026 04:41:22 -0700
Subject: [PATCH bpf-next v7 05/12] bpf: Implement iteration ops for
 resizable hashtab
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-rhash-v7-5-5b8e05f8630d@meta.com>
References: <20260605-rhash-v7-0-5b8e05f8630d@meta.com>
In-Reply-To: <20260605-rhash-v7-0-5b8e05f8630d@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780659688; l=12123;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=ZPBPT8KjWFtZgDKN3UIzazjOTImEiThRtpMam3srnMk=;
 b=+G2cUsgE2yTaLVfyxsdl6tgk2/nYQP7wJ25RzwdlatN4rp8GM+C+inpcNPYcyZZLITH9ck7S1
 1O2XiAdTnqYDaMVGCea6rSXFyQGw5JgadZF75+jm8TkSX249+J1kmIf
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Implement get_next_key, batch lookup/lookup-and-delete, for_each_map_elem
callback, and the seq_file BPF iterator for BPF_MAP_TYPE_RHASH.

get_next_key() and batch use rhashtable_next_key() — stateless,
matches the syscall UAPI shape (no kernel-side iterator state).
get_next_key falls back to the first key when prev_key was
concurrently deleted (matches htab semantics). Batch reports
cursor loss as -EAGAIN so userspace can distinguish it from
end-of-iteration (-ENOENT) and restart from NULL.

The seq_file BPF iterator uses rhashtable_walk_* instead. It runs
only from read() syscall context, so the walker's spin_lock is
safe, and seq_file's per-fd state lets the walker handle rehash
correctly (retry on -EAGAIN) for stronger coverage than the
stateless API can provide.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/hashtab.c  | 347 +++++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/bpf/map_iter.c |   3 +-
 2 files changed, 348 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 10f3a058747b..a149713d0953 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -3020,8 +3020,79 @@ static void rhtab_map_free_internal_structs(struct bpf_map *map)
 }
 
 static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
+	__must_hold_shared(RCU)
 {
-	return -EOPNOTSUPP;
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	struct rhtab_elem *elem;
+
+	elem = rhashtable_next_key(&rhtab->ht, key);
+
+	/* if not found, return the first key */
+	if (PTR_ERR(elem) == -ENOENT)
+		elem = rhashtable_next_key(&rhtab->ht, NULL);
+
+	if (IS_ERR(elem))
+		return PTR_ERR(elem);
+	if (!elem)
+		return -ENOENT;
+
+	memcpy(next_key, elem->data, map->key_size);
+	return 0;
+}
+
+static void rhtab_map_seq_show_elem(struct bpf_map *map, void *key, struct seq_file *m)
+{
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
+}
+
+static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
+				void *callback_ctx, u64 flags)
+{
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	void *prev_key = NULL;
+	struct rhtab_elem *elem;
+	int num_elems = 0;
+	u64 ret = 0;
+
+	cant_migrate();
+
+	if (flags != 0)
+		return -EINVAL;
+
+	rcu_read_lock();
+	/*
+	 * Best-effort iteration: if rhashtable is concurrently resized or
+	 * elements are deleted/inserted, there may be missed or duplicate
+	 * elements visited.
+	 */
+	while ((elem = rhashtable_next_key(&rhtab->ht, prev_key))) {
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
+	}
+	rcu_read_unlock();
+
+	return num_elems;
 }
 
 static u64 rhtab_map_mem_usage(const struct bpf_map *map)
@@ -3034,6 +3105,275 @@ static u64 rhtab_map_mem_usage(const struct bpf_map *map)
 	return sizeof(struct bpf_rhtab) + rhtab->elem_size * num_entries;
 }
 
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
+	 * Cursor stores the key of the next-to-process element (stashed by
+	 * the previous batch). Look it up directly so the element is included
+	 * here rather than skipped by next_key(). If the cursor was deleted
+	 * concurrently (or by the previous do_delete batch), return -EAGAIN
+	 * so userspace can distinguish a lost cursor from end-of-iteration
+	 * (-ENOENT) and restart from a NULL cursor.
+	 */
+	if (ubatch) {
+		elem = rhtab_lookup_elem(map, cursor);
+		if (!elem) {
+			rcu_read_unlock();
+			ret = -EAGAIN;
+			goto free;
+		}
+	} else {
+		elem = rhashtable_next_key(&rhtab->ht, NULL);
+	}
+
+	while (elem && !IS_ERR(elem) && total < max_count) {
+		memcpy(dst_key, elem->data, key_size);
+		rhtab_read_elem_value(map, dst_val, elem, elem_map_flags);
+		check_and_init_map_value(map, dst_val);
+
+		if (do_delete)
+			del_elems[total] = elem;
+
+		elem = rhashtable_next_key(&rhtab->ht, dst_key);
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
+		/* Stash next-to-process key as cursor for the next batch. */
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
+	if (copy_to_user(ukeys, keys, (size_t)total * key_size) ||
+	    copy_to_user(uvalues, values, (size_t)total * value_size) ||
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
+}
+
+static int rhtab_map_lookup_batch(struct bpf_map *map, const union bpf_attr *attr,
+				  union bpf_attr __user *uattr)
+{
+	return __rhtab_map_lookup_and_delete_batch(map, attr, uattr, false);
+}
+
+static int rhtab_map_lookup_and_delete_batch(struct bpf_map *map, const union bpf_attr *attr,
+					     union bpf_attr __user *uattr)
+{
+	return __rhtab_map_lookup_and_delete_batch(map, attr, uattr, true);
+}
+
+struct bpf_iter_seq_rhash_map_info {
+	struct bpf_map *map;
+	struct bpf_rhtab *rhtab;
+	struct rhashtable_iter iter;
+};
+
+static void *bpf_rhash_map_seq_start(struct seq_file *seq, loff_t *pos)
+	__acquires(RCU)
+{
+	struct bpf_iter_seq_rhash_map_info *info = seq->private;
+	struct rhtab_elem *elem;
+
+	rhashtable_walk_start(&info->iter);
+	/*
+	 * Re-deliver the element returned by walk_next() at the end of the
+	 * previous read() — bpf_seq_read may have stopped before show()
+	 * consumed it. Rehash rewinds the walker; retry on -EAGAIN.
+	 */
+	do {
+		elem = rhashtable_walk_peek(&info->iter);
+	} while (PTR_ERR(elem) == -EAGAIN);
+
+	if (IS_ERR(elem))
+		return NULL;
+
+	if (elem && *pos == 0)
+		++*pos;
+	return elem;
+}
+
+static void *bpf_rhash_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct bpf_iter_seq_rhash_map_info *info = seq->private;
+	struct rhtab_elem *elem;
+
+	++*pos;
+
+	/* Rehash rewinds the walker; retry until it stops returning -EAGAIN. */
+	do {
+		elem = rhashtable_walk_next(&info->iter);
+	} while (PTR_ERR(elem) == -EAGAIN);
+
+	if (IS_ERR(elem))
+		return NULL;
+	return elem;
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
+}
+
+static int bpf_rhash_map_seq_show(struct seq_file *seq, void *v)
+{
+	return __bpf_rhash_map_seq_show(seq, v);
+}
+
+static void bpf_rhash_map_seq_stop(struct seq_file *seq, void *v)
+	__releases(RCU)
+{
+	struct bpf_iter_seq_rhash_map_info *info = seq->private;
+
+	if (!v)
+		(void)__bpf_rhash_map_seq_show(seq, NULL);
+
+	rhashtable_walk_stop(&info->iter);
+}
+
+static int bpf_iter_init_rhash_map(void *priv_data, struct bpf_iter_aux_info *aux)
+{
+	struct bpf_iter_seq_rhash_map_info *info = priv_data;
+	struct bpf_map *map = aux->map;
+
+	bpf_map_inc_with_uref(map);
+	info->map = map;
+	info->rhtab = container_of(map, struct bpf_rhtab, map);
+	rhashtable_walk_enter(&info->rhtab->ht, &info->iter);
+	return 0;
+}
+
+static void bpf_iter_fini_rhash_map(void *priv_data)
+{
+	struct bpf_iter_seq_rhash_map_info *info = priv_data;
+
+	rhashtable_walk_exit(&info->iter);
+	bpf_map_put_with_uref(info->map);
+}
+
+static const struct seq_operations bpf_rhash_map_seq_ops = {
+	.start = bpf_rhash_map_seq_start,
+	.next = bpf_rhash_map_seq_next,
+	.stop = bpf_rhash_map_seq_stop,
+	.show = bpf_rhash_map_seq_show,
+};
+
+static const struct bpf_iter_seq_info rhash_iter_seq_info = {
+	.seq_ops = &bpf_rhash_map_seq_ops,
+	.init_seq_private = bpf_iter_init_rhash_map,
+	.fini_seq_private = bpf_iter_fini_rhash_map,
+	.seq_priv_size = sizeof(struct bpf_iter_seq_rhash_map_info),
+};
+
 BTF_ID_LIST_SINGLE(rhtab_map_btf_ids, struct, bpf_rhtab)
 const struct bpf_map_ops rhtab_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -3047,6 +3387,11 @@ const struct bpf_map_ops rhtab_map_ops = {
 	.map_update_elem = rhtab_map_update_elem,
 	.map_delete_elem = rhtab_map_delete_elem,
 	.map_gen_lookup = rhtab_map_gen_lookup,
+	.map_seq_show_elem = rhtab_map_seq_show_elem,
+	.map_set_for_each_callback_args = map_set_for_each_callback_args,
+	.map_for_each_callback = bpf_each_rhash_elem,
 	.map_mem_usage = rhtab_map_mem_usage,
+	BATCH_OPS(rhtab),
 	.map_btf_id = &rhtab_map_btf_ids[0],
+	.iter_seq_info = &rhash_iter_seq_info,
 };
diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index ae0741a09c6d..c19b360bad9e 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -123,7 +123,8 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
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

