Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5A5388E52
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 20:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433175; cv=none; b=YFYnFbKgbYLfno3RS/ZTEQKhQMP3Y6mnuyuKVevBwvHNxGBYPgGfTgAf8QwO89D4cnZ6FzLdCg20BQV68QXRUTVekBVvabOzL7OeHZVK4r23y8DMxmMJUHi/xhO8nLgC1ScfcCBSpreV+PBJ7pM/wF89AQRuaHJ8AJy8EWlFm0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433175; c=relaxed/simple;
	bh=DGSkDs+vgtPKvyYJs0Xy1lAgtQghtGknPaRzxuygghM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hPpSfQYxzqf79UOXYuDzXm1HZoBE/3K9rm6U7Hf0nVoudFFz0xbvFlMM8ZtfYtPwRuK1EhkFy82B4YIWGOTxHO/MEix8HFdo/DR1L1jIJYooEcIbU8wl2OfpeHVy36lYdomNwWl0hZFP50ZOr212QW0bIHNTzTraI6ECwf1KRd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZ3ax9nM; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZ3ax9nM"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b12270b3so9222495e9.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 13:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780433172; x=1781037972; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RV8YGfmYINZvqQidmf49dMVqf6ZqMEaPOMkT4fDSMtI=;
        b=YZ3ax9nMUrphhR2lbpax70wB4zY6lUxEpCE1+7aGJvHK3sD7koWw350TpkFyHgUHO8
         cZ3rF0YHoJC0/BZm9PfpHhHJd6lmZu1m6oEeLVDGrbEUP5vLdtPa/UbVj4LyUGsmmcPE
         PLCDQsx0smGiKeRuBOiUpFsPIiyL/7XMM/eZD4uQ8ToZ2K0VzgsRnI/S17sTuKLFqkoE
         mo00rmcId/8C+IHNi0crAS/PD6w4WgewX9JSsA+Bp2jyVo/e75uab6/zZBCBp8B9/Dje
         apJ9qj3fIJIOMYVmD36eFWifcj27cudzaP4oiLfUgodEymmWvY9fXXfqxv6lDP4t18/v
         TO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780433172; x=1781037972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RV8YGfmYINZvqQidmf49dMVqf6ZqMEaPOMkT4fDSMtI=;
        b=jv6btDUGjE0vqw/aD+lCUdWekXYbBot84EW0g/nfvlUQeL2VwF7Js4sTlek7ez4VTS
         IUCge5rmMyMNS+2K5yYig0SiBaqgVrqpwnWy8Le8jqpVRwLK1NHOU2R2Tl+XB0gf3pUi
         xshVo0UM323HJ7O7IGLA5wvod7SDBBkHvHepErjZDMWBMxS+bvGCE+6JkFYQ0Y57ry2w
         DQ2FNsg4KG0T04WSotPbWWdiLxp2WVki8Gp3L7+5SL+OJOBXxwq9XLnw4e9Z5ztFeQpE
         x6Y9vPGVLFY11YCXl5eMoRE939f9TIVdoCNrCwXe67OIpq0auJgFHKDlRRrVPU9seSqZ
         h5vQ==
X-Gm-Message-State: AOJu0Yw7LRG5QvtxmmyjlFA61rG2mKThHO+qWiAVOpzakXUiiKeG+kCC
	/tHpe/CNgR4gkpysic2hVTLseSrCI1NaFQud4OiZqa2IM8WUDFf3Xbtl
X-Gm-Gg: Acq92OG/c4zQNz578VmB54Ktejn1ulG7DnnpfV8XbNI99elf0SmoGmvc78cUen4ghq8
	+cMiYthaUuEiOEDFauCq1Bwi9iJJMsNFDrrGp8nmJt+qkkBV9pjI7ch4Un8ubK9o6aXnGY3yzIR
	1v5of5jX3DPZ0h7clvzjOdmfiDLcGjQZxZQ9dKXdBp8w/7di6lo3KEttTwuvOtSdgal3wmq+aKq
	c/q0sOe1hO7PnrRIKYC8i1xsBK07UbFGHOSrO1Gsj6KCay91hD3+CqfufaNpR31ZqbDyLXNUtxu
	z+NDCGMlVDMUSx2+C4TLGMBiNqNdAj5lv6aeS+nhrY08yRbO6ZdQSWaBgL7hAwuINhE2AanP7uI
	0/pBMWIoPVHG+rBiTF9pVG0Kjmp1vR2YFcHbXEp0chyd6V5NGGf8qPE8BBZfTIAtDZ5B4ThHovg
	10dWchUR0eBOLRzyIpM9PF4dfxkO5hy5VZHis=
X-Received: by 2002:a05:600c:3150:b0:490:3cb4:f1b3 with SMTP id 5b1f17b1804b1-490b5fe958emr5500665e9.16.1780433172153;
        Tue, 02 Jun 2026 13:46:12 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:43::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b613ccf3sm1876995e9.21.2026.06.02.13.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:46:11 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 02 Jun 2026 13:45:33 -0700
Subject: [PATCH bpf-next v6 04/11] bpf: Implement iteration ops for
 resizable hashtab
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260602-rhash-v6-4-1bfd35a4184f@meta.com>
References: <20260602-rhash-v6-0-1bfd35a4184f@meta.com>
In-Reply-To: <20260602-rhash-v6-0-1bfd35a4184f@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780433165; l=12177;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=jXo4qd3HPl6WY2S4w3+q3lGl1ZFDV/2ph9DX0EreJQ8=;
 b=vRE8ee9MBNfjwhoxReVUdRQYPjxg53xNxVYOnEeo2WoMplYimTddcLcr45ADSiy3ftnoD/yn7
 J7OsmXo7dBLDRK3L7aGHM/dywZIPxMv6JFfjrUNa8Xle9nIvDWTgA0s
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
index 10f3a058747b..997f420d67e3 100644
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
+	elem = rhashtable_next_key(&rhtab->ht, key, rhtab_params);
+
+	/* if not found, return the first key */
+	if (PTR_ERR(elem) == -ENOENT)
+		elem = rhashtable_next_key(&rhtab->ht, NULL, rhtab_params);
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
+		elem = rhashtable_next_key(&rhtab->ht, NULL, rhtab_params);
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

