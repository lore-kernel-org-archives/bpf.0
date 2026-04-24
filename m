Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D763F23AC
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777060281; cv=none; b=BPFOj9r8mi4l+KOiaJiAKxXDxu/v4Zpac5443g6r/G1vSIf/qVyWb4TDbCnWZnz0VTUzdlekJ0szXCYOFmDMrKDis4UbwgXBQfRvSrnMWyaoFvETxqxSvyJaMaW22cvd3ANVyJposoqUXzmtvnZ9qSl9sKy6njV8NWEOkC0T5so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777060281; c=relaxed/simple;
	bh=G4K75dwHDBzvY5CYMFhQDKIrhJQbF6h1qHPNYlPz+tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nVuCnM+MXuhGYIphs2cYeCvDQEqhTAaTj5QXDeuzRixFnJ1WTiTHjOj5qR5WSrNdaHExlLh6dH3BNaeoI/ego8X1k8OvWmflyfQ0zleehAUTsmsOMZcUDOpHK17jbwDs1Wf65hpq8Q4udtZhXM8oL6VEtHcFbQNkSZTPBitCpzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4QCmVXu; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4QCmVXu"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a3af1b7549so10302130e87.1
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 12:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777060271; x=1777665071; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/hawEXru2xmGu4N667oDkmKOzajJdJSzy2NHSPm3n3Q=;
        b=H4QCmVXuhzfnKjakQ9aa7mQeQaM2Pro73gDIN7Ug7VieAYDOXL2b1cSAVa5y+VQY3t
         wC0kC6n3hTI0Ym7iMc9Lf8+Jst6ZJBZhl4okktlAmAPQzXDtCzpQszqFrONxHP6AyT9f
         VAvgsaEjnEKCJMgSo7zXxH5ejTicQSoTRb6baHGjphDlwp8ShKNH4rV4SLKUuvJjJQI+
         4IVjfDXiy33h0KcF+M1edRdbgdwLdiOHH7uMwPNQgRzLpEUgXB6K0LEPfrfxXddIxGNF
         3gYhVpTmQP8Ha14nSP6Sc3cbxsWr4swJLtTWFVG9+r9aZyl+eX7ym3ndXb8PZ+JWHBTx
         Eh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777060271; x=1777665071;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/hawEXru2xmGu4N667oDkmKOzajJdJSzy2NHSPm3n3Q=;
        b=Hb1JmPrVuEVfzlQmvgaG9nVdqP6uRi97ABHOkpoXSusgrtMxp2OVPpdV5qQZvJ/y61
         Zmizyl1PkSzfMsN99QwPZaCaeXSBl2WXiTBety6DeaYJidhblVrjn42TdrwPLwts+DVm
         QVSJ49vXUsCybLXzxyE8aaj7wurSlWzVLll5+XYNodOmWf344/tULwlqllu38KicYGD4
         tZ078nmxAeMH9soIg1V7sfMt/dMUS6kT9+ttuqDZYiR6Kzeejh5SeWogeEo4gkgdPMVt
         XO++52NdvLoCBJ3WDgsvS/Zpw2FVuGsTyU6eDTDHLflr+dyhrbofF9UuPVr3VUrklki9
         7dfw==
X-Gm-Message-State: AOJu0Yx7qYndZZ5TnHuIPpFb1XvxkfTdgRiuPqVlAsswHFF9lXjbpOhH
	ycwM2OkXm9/TafOYSwDi7le8JHFhKK7r+gsbLU3hYnpr9xE/2ragDdt3
X-Gm-Gg: AeBDiesRGkDCVHXGoJ9VR7BXAlRj+27b/SpsHC3tVls8ppgMKaAzQ8NUbk+0SKpBZwk
	m/2Z/8PyxB7QvvTlGiNIPJBSfqYi5P0X4l3nubgAweOyCoRY0orrr8A6KW5shl0lN7NIML7/pe3
	qvfxd45gVY4ydfJjjVYNnV08qbIuoI022luC7fGgr+XUSjn5Ak2YlGkMVB/XQfSVf1GHbtq4aL4
	+XdkKuS+HQ0CWhbH8seKnWfQR6Kc/n7EPOKtpzIP6fXiSUn2KWJ0GmnoBHSk/hM9ql1lYQeCXkS
	ANpHeorvhTnGvLQ2MVau3mWx1IzWpqL0fYpMUpCovy4J31LhI9zR4PdJEgErXTO7QIOjTtlFzXV
	72Me1fQCIYQbtLfo4H6ebJ1Y9j33eGZ/ShKn+NeVndT1W2SXebR3SfFcT3Ys/unXTUeVBxBAuOB
	wl9gC7V6GtPuMm2vvkP3N0+r2N
X-Received: by 2002:a05:6512:3d25:b0:5a4:1365:5fe3 with SMTP id 2adb3069b0e04-5a4172f612bmr10318801e87.37.1777060270806;
        Fri, 24 Apr 2026 12:51:10 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:41::])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a41a238563sm6029370e87.55.2026.04.24.12.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 12:51:09 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 24 Apr 2026 12:50:46 -0700
Subject: [PATCH bpf-next v3 04/10] bpf: Implement batch ops and iterators
 for resizable hashtab
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-rhash-v3-4-d0fa0ce4379b@meta.com>
References: <20260424-rhash-v3-0-d0fa0ce4379b@meta.com>
In-Reply-To: <20260424-rhash-v3-0-d0fa0ce4379b@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777060253; l=10023;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=i/BjknTjC1yHVyx5awcT5tc+u1zl4UVmP6gwIK2+9TA=;
 b=mtWbGFMl+fWzXQXv+joNrq3bV8rRaath7pYWCHq9vxKRjg15nY/IKYNnwyPsBj56ibq52f+eF
 0G4cfEwDvAbDYRx5meKG9r92eJJAAqDLe9xGPgS32tn7X1iiTwmOeRz
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add batch operations for BPF_MAP_TYPE_RHASH.
Batch operations:
 * rhtab_map_lookup_batch: Bulk lookup of elements by bucket
 * rhtab_map_lookup_and_delete_batch: Atomic bulk lookup and delete

The batch implementation uses rhashtable_walk_enter_from() to resume
iteration from the last collected key. When the buffer fills, the last
key becomes the cursor for the next batch call.

Also implements rhtab_map_mem_usage() to report memory consumption.

Wire up seq_file BPF iterator for BPF_MAP_TYPE_RHASH so that
bpf_iter and bpftool map dump work with resizable hash maps.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/hashtab.c | 280 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 273 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index d37f3d548d36..000caa2c7f4c 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -3066,64 +3066,330 @@ static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key
 
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
+	struct rhashtable_iter iter;
+	struct rhtab_elem *elem;
+	int num_elems = 0;
+	u64 ret = 0;
+
+	if (flags != 0)
+		return -EINVAL;
+
+	/*
+	 * The rhashtable walk API uses spin_lock in rhashtable_walk_start/stop,
+	 * which is not safe in NMI or soft/hard IRQ context.
+	 */
+	if (in_nmi() || in_hardirq() || in_softirq())
+		return -EOPNOTSUPP;
+
+	rhashtable_walk_enter(&rhtab->ht, &iter);
+	rhashtable_walk_start(&iter);
+
+	while ((elem = rhashtable_walk_next(&iter))) {
+		/* rhashtable_walk_next returns -EAGAIN on resize, abort */
+		if (IS_ERR(elem)) {
+			num_elems = -EBUSY;
+			break;
+		}
+		num_elems++;
+		ret = callback_fn((u64)(long)map,
+				  (u64)(long)elem->data,
+				  (u64)(long)rhtab_elem_value(elem, map->key_size),
+				  (u64)(long)callback_ctx, 0);
+		if (ret)
+			break;
+	}
+
+	rhashtable_walk_stop(&iter);
+	rhashtable_walk_exit(&iter);
+
+	return num_elems;
 }
 
 static u64 rhtab_map_mem_usage(const struct bpf_map *map)
 {
-	return 0;
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	u64 num_entries;
+
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
+	void *buf = NULL, *keys = NULL, *values = NULL, *dst_key, *dst_val;
+	struct rhtab_elem **del_elems = NULL;
+	u32 max_count, total, key_size, value_size, i;
+	struct rhashtable_iter iter;
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
+
+	if (!keys || !values || (do_delete && !del_elems)) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	/*
+	 * Use the last key from the previous batch as cursor.
+	 * enter_from positions at that key's bucket, walk_next
+	 * returns the successor in O(1).
+	 * First call (ubatch == NULL): starts from bucket 0.
+	 */
+	if (ubatch) {
+		buf = kmalloc(key_size, GFP_USER | __GFP_NOWARN);
+		if (!buf) {
+			ret = -ENOMEM;
+			goto free;
+		}
+		if (copy_from_user(buf, ubatch, key_size)) {
+			ret = -EFAULT;
+			goto free;
+		}
+	}
+
+	scoped_guard(rcu) {
+		rhashtable_walk_enter_from(&rhtab->ht, &iter, buf, rhtab->params);
+		rhashtable_walk_start(&iter);
+	}
+
+	dst_key = keys;
+	dst_val = values;
+	total = 0;
+
+	while (total < max_count) {
+		elem = rhtab_iter_next(&iter);
+		if (!elem)
+			break;
+
+		memcpy(dst_key, elem->data, key_size);
+		rhtab_read_elem_value(map, dst_val, elem, elem_map_flags);
+		check_and_init_map_value(map, dst_val);
+
+		if (do_delete)
+			del_elems[total] = elem;
+
+		dst_key += key_size;
+		dst_val += value_size;
+		total++;
+	}
+
+	if (do_delete) {
+		for (i = 0; i < total; i++)
+			rhtab_delete_elem(rhtab, del_elems[i]);
+	}
+
+	rhashtable_walk_stop(&iter);
+	rhashtable_walk_exit(&iter);
+
+	if (total == 0) {
+		ret = -ENOENT;
+		goto free;
+	}
+
+	/* Signal end of table when we collected fewer than requested */
+	if (total < max_count)
+		ret = -ENOENT;
+
+	/* Write last key as cursor for the next batch call */
+	if (copy_to_user(ukeys, keys, total * key_size) ||
+	    copy_to_user(uvalues, values, total * value_size) ||
+	    put_user(total, &uattr->batch.count) ||
+	    copy_to_user(u64_to_user_ptr(attr->batch.out_batch),
+			 dst_key - key_size, key_size)) {
+		ret = -EFAULT;
+		goto free;
+	}
+
+free:
+	kfree(buf);
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
 	struct rhashtable_iter iter;
+	void *last_key;
+	bool last_key_valid;
 	bool iter_active;
 };
 
 static void *bpf_rhash_map_seq_start(struct seq_file *seq, loff_t *pos)
+	__acquires(RCU)
 {
-	return NULL;
+	struct bpf_iter_seq_rhash_map_info *info = seq->private;
+	struct rhtab_elem *elem;
+	void *key = *pos > 0 && info->last_key_valid ? info->last_key : NULL;
+
+	scoped_guard(rcu) {
+		rhashtable_walk_enter_from(&info->rhtab->ht, &info->iter,
+					   key, info->rhtab->params);
+		rhashtable_walk_start(&info->iter);
+	}
+	info->iter_active = true;
+
+	elem = rhashtable_walk_next(&info->iter);
+	/* rhashtable_walk_next returns -EAGAIN on resize, abort */
+	if (IS_ERR(elem))
+		return ERR_PTR(-EBUSY);
+	if (!elem)
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
+
+	memcpy(info->last_key, elem->data, info->map->key_size);
+	info->last_key_valid = true;
+
+	++*pos;
+
+	elem = rhashtable_walk_next(&info->iter);
+	/* rhashtable_walk_next returns -EAGAIN on resize, abort */
+	if (IS_ERR(elem))
+		return ERR_PTR(-EBUSY);
+
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
 }
 
 static int bpf_rhash_map_seq_show(struct seq_file *seq, void *v)
 {
-	return 0;
+	return __bpf_rhash_map_seq_show(seq, v);
 }
 
 static void bpf_rhash_map_seq_stop(struct seq_file *seq, void *v)
+	__releases(RCU)
 {
+	struct bpf_iter_seq_rhash_map_info *info = seq->private;
+
+	if (!v)
+		(void)__bpf_rhash_map_seq_show(seq, NULL);
+
+	if (info->iter_active) {
+		rhashtable_walk_stop(&info->iter);
+		rhashtable_walk_exit(&info->iter);
+		info->iter_active = false;
+	}
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
+	info->iter_active = false;
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

-- 
2.52.0

