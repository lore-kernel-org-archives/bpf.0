Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41013FB060
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779990471; cv=none; b=Z6u4CWs3x8HveCNTwOWKy/C60FT7Ahe7C5jgsm5j+0PV5VpGdb5d34AccRGgTeE7PPgwGyoyfRJr7C/ZmxHIX97cLxdvXfO/iQvIwbzwiezEc5V04zvdyfT+PjA2Jj5fgAlE3QHLX1Epkz1rHMA8BTSOtfbnnlFsEzhC+aHxXtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779990471; c=relaxed/simple;
	bh=0RsVw+9rG+D04M/65LXzH+WbtyzL8HyaXvA5S5SYar0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MJr6td/TAd4RHxc+eR21RzBppjXVEMMj4XWmmFEJS3/SxEMu0hHCpuLg/lgijDe3owwkvMLmyWE18d/rz5aIL3AxCawTP6S7HRaxf15SdhxitR+x+clfYe3EkLhMzVSl/VEUxxVXB2zO1FMDzkaehfcQfjFoB7sowW29yFrGOF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1brTOaI; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1brTOaI"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45eecb8bf67so518758f8f.2
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 10:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779990461; x=1780595261; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ilK4tJu5K/dwWaTRSqEDWyrLUj1+ZqTpkdsO91ihexs=;
        b=f1brTOaI11j3roRX2P30L838hOwu6Kf4j26+TMi/rx6YOZc+OLxEPnP/srgPre3mFc
         SYCFFxS10z2EQqg4dpRtYmX16XhpCWxRaNokm2FMbFd1UxpXDjB9UyCqXmi01VRDKN0B
         BE/xHSgbJ/8VnR0tMqjwmZ3KVIpAK1YFi9gGz+3CnsaEqRoum7Uuzk3KaM9dzOZLTp1K
         m0F0hky6HFFME/eItcGNGoPd6u0u+TWxrKhkXHvSn8OgGajcBXYK3pCHSVF4LvYlafmv
         yQYljholdHrTIokblqeWt9t5i+8fIszr2w4XMzimF6GNhbxNG3Naf6EeOd1TEjS2bMCp
         3KDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779990461; x=1780595261;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ilK4tJu5K/dwWaTRSqEDWyrLUj1+ZqTpkdsO91ihexs=;
        b=ctZEykgKsnr73Ydanm7L1oUZuDce3z7QVvUgNHM1Vn3VDWv2//8+6Rv0mXtteYsvBp
         YeVP9xG/mdNFDtZq2PpG2/jaYWRsJ+j+G3kKw63mA2GBALKE+AXe7WqL8nySbVz/SxfG
         L7WkznW+zZeRHKVF9z2B1FxR20k4xARnZESXfmXOvQj0MzLlkdNST0cExPoV7cK23m/P
         oczmvI4kL2WD3RvrBB3RufaaqveRPU0G75E2GTReXxVUFBz4S0Gh6QF3sN0Sbf9p2Ygc
         83YLc8iA+nX4rKmOkK5BQMp/CCVANxfreeV1YGgIT9PrwCX3RHQKOlsyRaSG66UtBvQK
         s00w==
X-Gm-Message-State: AOJu0Yyqg8MPoNcTecKTOLLSeCDPMASWR7wRJ4JTREKi2kPzJXvx/mNK
	sSP+BBYbGAzjWN2qZXIAGJgjzPey69ELcG/VgUnPbbJlwGVHnNli0uOZ
X-Gm-Gg: Acq92OG0+8tn7l8BEbXhexYJuzgtaCRzlfs/MDYVuNEvw7Z5zwxSaOlAvgPRmsr9BUJ
	nuSVzZuMsBREFfxNhARkBsFfkbOS7MuYHZHMFYEX0jkXGmFXKreTEEY5Kew5qoT5457qdcFmGPX
	nx13P1Wv125HInMgRuVL7q2XrKbbck1AtxK7bzQ+cnTsKNeuUGkp19x1Oqi8t+UDdKwgFCzdfUv
	GpLJQtl29dVJBwnOEDUASLReiYZL9pOSfe2dL/tnUSKA3Vg4I0QXkR9QiThkZeBgiwUSkNubRFR
	phsy2JZVDWjKBWW0DikDWi/byElP+zlo1z3kRGExbchfO8M/VDICztJLZzcV9yJG6y6xAvskxYn
	viiUCHpHu5DimKj0667nc9fK/9lQjidD19iPY9sGiZeKsfsEblt8ydG0NWNFiuIuiKM794TJ3NB
	/7OFT1VYsN7t2deD/85KDGQaWw5YVSe5yOpCc=
X-Received: by 2002:a05:6000:4683:b0:43d:d037:d59c with SMTP id ffacd0b85a97d-45ef02ba38cmr242125f8f.16.1779990460900;
        Thu, 28 May 2026 10:47:40 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:75::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb549e79sm15858715f8f.7.2026.05.28.10.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 10:47:40 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 28 May 2026 10:47:15 -0700
Subject: [PATCH bpf-next v5 04/11] bpf: Implement iteration ops for
 resizable hashtab
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-rhash-v5-4-7205191b6c57@meta.com>
References: <20260528-rhash-v5-0-7205191b6c57@meta.com>
In-Reply-To: <20260528-rhash-v5-0-7205191b6c57@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779990451; l=12247;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=w25gEM2UkFJMfRfQqce7xGK6gWDuecBYvGBR6PCr2Bw=;
 b=pk5AcILHArNnhgmtl1nOFOjZlrN0MLYvfpdAYR2lkj7nR9gyN0mnq554EHvZC4yJlGwm2aI4Y
 hui56zOPYa6CDQcNmQZ6GQVWhMZyPtETHsRFmXD7505KvZax0t6QJ7N
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
 kernel/bpf/hashtab.c  | 361 +++++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/bpf/map_iter.c |   3 +-
 2 files changed, 362 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 8944c9f070ca..a03fa5fa6545 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -3021,10 +3021,363 @@ static void rhtab_map_free_internal_structs(struct bpf_map *map)
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
+}
+
+static u64 rhtab_map_mem_usage(const struct bpf_map *map)
+{
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
+	 * Cursor stores the key of the next-to-process element (stashed by
+	 * the previous batch). Look it up directly so the element is included
+	 * here rather than skipped by next_key(). If the cursor was deleted
+	 * concurrently (or by the previous do_delete batch), lookup returns
+	 * NULL and userspace must restart from a NULL cursor.
+	 */
+	if (ubatch)
+		elem = rhtab_lookup_elem(map, cursor);
+	else
+		elem = rhashtable_next_key(&rhtab->ht, NULL, rhtab_params);
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
 }
 
+struct bpf_iter_seq_rhash_map_info {
+	struct bpf_map *map;
+	struct bpf_rhtab *rhtab;
+	void *last_key;
+	bool last_key_valid;
+};
+
+static void *bpf_rhash_map_seq_start(struct seq_file *seq, loff_t *pos)
+	__acquires_shared(RCU)
+{
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
+}
+
+static void *bpf_rhash_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
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
+}
+
+static int bpf_rhash_map_seq_show(struct seq_file *seq, void *v)
+{
+	return __bpf_rhash_map_seq_show(seq, v);
+}
+
+static void bpf_rhash_map_seq_stop(struct seq_file *seq, void *v)
+	__releases_shared(RCU)
+{
+	if (!v)
+		(void)__bpf_rhash_map_seq_show(seq, NULL);
+
+	rcu_read_unlock();
+}
+
+static int bpf_iter_init_rhash_map(void *priv_data, struct bpf_iter_aux_info *aux)
+{
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
+	return 0;
+}
+
+static void bpf_iter_fini_rhash_map(void *priv_data)
+{
+	struct bpf_iter_seq_rhash_map_info *info = priv_data;
+
+	kfree(info->last_key);
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
@@ -3038,5 +3391,11 @@ const struct bpf_map_ops rhtab_map_ops = {
 	.map_update_elem = rhtab_map_update_elem,
 	.map_delete_elem = rhtab_map_delete_elem,
 	.map_gen_lookup = rhtab_map_gen_lookup,
+	.map_seq_show_elem = rhtab_map_seq_show_elem,
+	.map_set_for_each_callback_args = map_set_for_each_callback_args,
+	.map_for_each_callback = bpf_each_rhash_elem,
+	.map_mem_usage = rhtab_map_mem_usage,
+	BATCH_OPS(rhtab),
 	.map_btf_id = &rhtab_map_btf_ids[0],
+	.iter_seq_info = &rhash_iter_seq_info,
 };
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

