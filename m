Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC9532B9A8
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 20:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770323231; cv=none; b=SSlAbH/Jtw591JicuvbOD3GXnDdlGpp6a2l3BJUnQs4zur98k8VlC2aFt8zi+0wdBOEWZzcBsR2DvERDJYIvGASHoFFqEa0wfFJjmDYzsjDkh10lhZ1mFCFs2O761IH2odaTfIE/g2Ft5zZXllha0AN7eAwD6LgJkrQlgeCELvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770323231; c=relaxed/simple;
	bh=NXPVrrbar7KKClIaCGj6vGKo1O+/LP59P5/qLyhMQ5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aPzKud65gzEK5tcA7fRx9gOE3Tq9oDn6udbagqqIK51fw+IO817lT9Vxdh7VViPhBBCdc/AtnUFQvU22HWrMW5beAiL8evdbl+3QVaMMebYspLhfRa+hTgEs4a2nhZhF1T6X+3XC2BUkANJOU/mv8JW3ocEJm7BsyCvRcOjs2kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mav8P+Rk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mav8P+Rk"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so13427845e9.0
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 12:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770323229; x=1770928029; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LqrMWRs+HiFDAYEEr3z6wE2RmB6K0ie3baGjNmaz8As=;
        b=Mav8P+Rkr2K+ilbuPpO7E9fKUItcbTlGolsoe1hSyLsTJdR8x+12E/YCfXcnbqth/Y
         I4xTOtFR1aQDxRxKBN5leTDJPz1952LqI+OjKRHuyK2zr0qPGQktrcp9+5wnxVUSu2Rn
         70dequBmrs9YbTaqSwzcmHmImj9fqokns92bKwV1nN62gIm8WO46lFmx2un/Gwq04hsA
         ZauuFSCq/la0rAV1TDtSq/TOQ5xCaRZIHhumMwm7BIVR4npcQzdC3wS2po3kNM+MQwSR
         OwZ7HP2ZsbPRjmJmXXALgZgQUd2YojZ/9YIdl8FM7I3zMEAaPOCZRXi3t0SVG8yiENjM
         fLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770323229; x=1770928029;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LqrMWRs+HiFDAYEEr3z6wE2RmB6K0ie3baGjNmaz8As=;
        b=xC1uSI7zknS7vmXFt0Hl8bM+56T/AS0eMC+doKpd0YFjcfrI0e3IagAnBnJ+dPzvut
         iR8bXy2R8+EbIhnksqjkJQsuY/THnNK9HLEtUFC2QiHImvZ8dbpLQG/g4Q6kawYKbU/P
         fltPaGBi/gAy/0M0TZhN4eTto5WpmPEH+xjOeIAFETR3etnYIplVIsLo0hmHTbuhgpIQ
         IKCDWLco25RJU8KoeAYJPfu/zEhhysvLsiEBgnQKesgMfliFt0bSZFqvwYuJkIhwEeUj
         nk1W6Z36RkIqDl+1VxZYnzzuiRgQ0N/AztKcLl4VhPKBSZQVVJSipTzOtC2ceXWNWDRG
         I13Q==
X-Gm-Message-State: AOJu0YyghR6L9pvd9cWjviOMmiUaw6uJKj6Ee8PSF/89JrdrZmO78INg
	PhBpzkG8XKw0fjdLHJNzzuJPmzE7jboCRzgVd4dZJzWQbjDhn62cJf7M
X-Gm-Gg: AZuq6aLNPB4k86yyEp/bTEExRtsrDu2oZFe89KUD7Rcmo5bP9MsiPOdfLAa+NX/6Nzy
	f46TQGkq7regAyWNUjH/G/j/Od4IcSVVjqOHVKiHT3dPRLhBJXD/pXI4ZX95QejB/ANDB4ijOov
	GJ3ODdCaqgldvJAnBnfGe+0STz8z41J0BQqFYESqazQ+ftss5jw5vPQP96W+BwDhYKPz3KZVX2H
	V6yBym1NutPOvTJFKAV4Xvkon0iNQJZ2OkYQ+6GEEaOCf7nLAF1TRLgTydpoqFO9Sys+/0Ua2Fo
	8fRX5ieNR44HAf8IO3G18EvpeNOGjBFgLrhDwmdTEnGtYWyToe5xZl0bcfETl3ElJHeg6VEwfs4
	jAdiBzozAEfQN794fS5IDeYgQJnuwhXWm9uAtD4mUkhAXMSbZ3anNIoxmmKHX7w84pceV2b0=
X-Received: by 2002:a7b:c3d5:0:b0:47e:e38b:a83 with SMTP id 5b1f17b1804b1-483178ebf8emr40156895e9.7.1770323229294;
        Thu, 05 Feb 2026 12:27:09 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::6:1325])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d7a924sm119968865e9.10.2026.02.05.12.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 12:27:08 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 05 Feb 2026 20:24:33 +0000
Subject: [PATCH RFC bpf-next 03/12] bpf: Implement batch ops and BPF
 iterator for resizable hashtab
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-rhash-v1-3-30dd6d63c462@meta.com>
References: <20260205-rhash-v1-0-30dd6d63c462@meta.com>
In-Reply-To: <20260205-rhash-v1-0-30dd6d63c462@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com, memxor@gmail.com, 
 puranjay@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770323224; l=8639;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=eDwgl3m7ea0XUzy67LG6XBPQcu5zc9PH6rdSirgndq4=;
 b=nsGY4Dz22x/fltt0jAN+BPr8KK+ZSu626Z5HobEtlJh2HpFVg2wmOOjsF+DlHic4OVm6TUhz/
 T0ne/1QxpPuCESM/Z1CnB1ik+HKYGLEeyOwE67UPrREwxpKOOxPKh18
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add batch operations and BPF iterator support for BPF_MAP_TYPE_RHASH.

Batch operations:
 * rhtab_map_lookup_batch: Bulk lookup of elements by bucket
 * rhtab_map_lookup_and_delete_batch: Atomic bulk lookup and delete

The batch implementation iterates through buckets under RCU protection,
copying keys and values to userspace buffers. When the buffer fills
mid-bucket, it rolls back to the bucket boundary so the next call can
retry that bucket completely.

BPF iterator:
 * Uses rhashtable_walk_* API for safe iteration
 * Handles -EAGAIN during table resize transparently
 * Tracks skip_elems to resume iteration across read() calls

Also implements rhtab_map_mem_usage() to report memory consumption.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/hashtab.c | 227 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 221 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 917f8f7d70c9ce265c13751e17e3b0bb4b598c45..142e5cf3be17c74d29ef1623be4ed3923c97dd2e 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -3065,19 +3065,159 @@ static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
 
 static u64 rhtab_map_mem_usage(const struct bpf_map *map)
 {
-	return 0;
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	struct bucket_table *tbl, *future_tbl;
+	u64 num_entries;
+	u64 usage = sizeof(struct bpf_rhtab);
+
+	num_entries = atomic_read(&rhtab->ht.nelems);
+	usage += rhtab->elem_size * num_entries;
+
+	/* Add rhashtable internal overhead: bucket_table + buckets array */
+	guard(rcu)();
+	tbl = rcu_dereference(rhtab->ht.tbl);
+	usage += sizeof(struct bucket_table) +
+		 sizeof(struct rhash_lock_head *) * tbl->size;
+
+	/* Account for future_tbl during resize */
+	future_tbl = rcu_dereference(tbl->future_tbl);
+	if (future_tbl)
+		usage += sizeof(struct bucket_table) +
+			 sizeof(struct rhash_lock_head *) * future_tbl->size;
+
+	return usage;
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
+	void *keys = NULL, *values = NULL, *dst_key, *dst_val;
+	struct rhtab_elem **del_elems = NULL;
+	u32 slot, max_count, total, key_size, value_size, i;
+	struct bucket_table *tbl;
+	struct rhtab_elem *elem;
+	struct rhash_head *he;
+	u64 elem_map_flags, map_flags;
+	int ret = 0;
+
+	elem_map_flags = attr->batch.elem_flags;
+	if ((elem_map_flags & ~BPF_F_LOCK) ||
+	    ((elem_map_flags & BPF_F_LOCK) &&
+	     !btf_record_has_field(map->record, BPF_SPIN_LOCK)))
+		return -EINVAL;
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
+	slot = 0;
+	if (ubatch && copy_from_user(&slot, ubatch, sizeof(slot)))
+		return -EFAULT;
+
+	key_size = map->key_size;
+	value_size = map->value_size;
+
+	keys = kvmalloc_array(max_count, key_size, GFP_USER | __GFP_NOWARN);
+	values = kvmalloc_array(max_count, value_size, GFP_USER | __GFP_NOWARN);
+	if (do_delete)
+		del_elems = kvmalloc_array(max_count, sizeof(void *), GFP_USER | __GFP_NOWARN);
+
+	if (!keys || !values || (do_delete && !del_elems)) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	dst_key = keys;
+	dst_val = values;
+	total = 0;
+
+	rcu_read_lock();
+	tbl = rht_dereference_rcu(rhtab->ht.tbl, &rhtab->ht);
+
+	if (slot >= tbl->size) {
+		rcu_read_unlock();
+		ret = -ENOENT;
+		goto out;
+	}
+
+	for (; slot < tbl->size; slot++) {
+		u32 bucket_start = total;
+
+		rht_for_each_rcu(he, tbl, slot) {
+			/*
+			 * If buffer is full mid-bucket, undo this partial bucket
+			 * so next call retries it. I this is the first bucket return -ENOSPC
+			 */
+			if (total >= max_count) {
+				if (bucket_start == 0)
+					ret = -ENOSPC;
+				dst_key -= (total - bucket_start) * key_size;
+				dst_val -= (total - bucket_start) * value_size;
+				total = bucket_start;
+				goto done;
+			}
+			elem = container_of(he, struct rhtab_elem, node);
+			memcpy(dst_key, elem->data, key_size);
+			rhtab_read_elem_value(map, dst_val, elem, elem_map_flags);
+			check_and_init_map_value(map, dst_val);
+
+			if (do_delete)
+				del_elems[total] = elem;
+
+			dst_key += key_size;
+			dst_val += value_size;
+			total++;
+		}
+	}
+done:
+
+	if (do_delete) {
+		for (i = 0; i < total; i++)
+			rhtab_delete_elem(rhtab, del_elems[i]);
+	}
+
+	rcu_read_unlock();
+
+	if (total == 0)
+		goto out;
+
+	ret = copy_to_user(ukeys, keys, total * key_size);
+	ret = ret ? : copy_to_user(uvalues, values, total * value_size);
+	ret = ret ? : put_user(total, &uattr->batch.count);
+	ret = ret ? : copy_to_user(u64_to_user_ptr(attr->batch.out_batch), &slot, sizeof(slot));
+	if (ret)
+		ret = -EFAULT;
+
+out:
+	kvfree(keys);
+	kvfree(values);
+	kvfree(del_elems);
+	return ret;
 }
 
 static int rhtab_map_lookup_batch(struct bpf_map *map, const union bpf_attr *attr,
 				  union bpf_attr __user *uattr)
 {
-	return 0;
+	return __rhtab_map_lookup_and_delete_batch(map, attr, uattr, false);
 }
 
 static int rhtab_map_lookup_and_delete_batch(struct bpf_map *map, const union bpf_attr *attr,
 					     union bpf_attr __user *uattr)
 {
-	return 0;
+	return __rhtab_map_lookup_and_delete_batch(map, attr, uattr, true);
 }
 
 struct bpf_iter_seq_rhash_map_info {
@@ -3090,30 +3230,105 @@ struct bpf_iter_seq_rhash_map_info {
 
 static void *bpf_rhash_map_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	return NULL;
+	struct bpf_iter_seq_rhash_map_info *info = seq->private;
+	struct rhtab_elem *elem;
+	u32 skip = info->skip_elems;
+
+	rhashtable_walk_enter(&info->rhtab->ht, &info->iter);
+	rhashtable_walk_start(&info->iter);
+	info->iter_active = true;
+
+	/* Skip elements we've already processed in previous read calls */
+	while (skip > 0) {
+		elem = rhtab_iter_next(&info->iter);
+		if (!elem)
+			return NULL;
+		skip--;
+	}
+
+	elem = rhtab_iter_next(&info->iter);
+	if (!elem)
+		return NULL;
+	/*
+	 * if *pos is not 0, previously iteration failed on this elem,
+	 * so we are restarting it. That's why no need to increment *pos.
+	 */
+	if (*pos == 0)
+		++*pos;
+	return elem;
 }
 
 static void *bpf_rhash_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	return NULL;
+	struct bpf_iter_seq_rhash_map_info *info = seq->private;
+
+	++*pos;
+	++info->skip_elems;
+
+	return rhtab_iter_next(&info->iter);
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
+			ctx.value = rhtab_elem_value(elem);
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
+	bpf_map_inc_with_uref(map);
+	info->map = map;
+	info->rhtab = container_of(map, struct bpf_rhtab, map);
+	info->skip_elems = 0;
+	info->iter_active = false;
 	return 0;
 }
 
 static void bpf_iter_fini_rhash_map(void *priv_data)
 {
+	struct bpf_iter_seq_rhash_map_info *info = priv_data;
+
+	bpf_map_put_with_uref(info->map);
 }
 
 static const struct seq_operations bpf_rhash_map_seq_ops = {

-- 
2.53.0

