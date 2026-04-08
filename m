Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A1C3D5256
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661049; cv=none; b=h41u6Off6PqzqipLJGfIu4VgpXtnL5RJcvGrpsOXmPsQ7gd+w9BiFOUxiqL1JZA6Bb9U0VRUFXJL+24IQN2zp1kxavmzI/L9r7HJ3Jt9wVxNZzrSd2TrW5kRPz/iAKslkgqcVHXDLsqLAaqfiL0sjDTLOKJ7P+aDwoMRLNwYgF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661049; c=relaxed/simple;
	bh=E7cH7v360vkAW9JjDgRz+/o4Pj1dfN7ANiJCk5KD2v8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IYzhs9jwqdOg//XNUAO6hwD7jZj7cIvEsgRmbQV3N55ayMKj9fN8oImbvzxIm3dBxWFi3b1kgOpeHjiPb37KVWV77WpoPpugdv/ivKW9vsbOGNiAeylvqQntl/nOLeSmFT7du/rNVx25aBBMvjDxzzK3Za/0SNQKssTDV+J9PE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAmhveSu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAmhveSu"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488b00ed86fso35843045e9.3
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 08:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775661047; x=1776265847; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=892b1tc3BjJAyN03dRdp5zs01ZYlJJcb9paPjaaRp2k=;
        b=OAmhveSueXdgZlXmJolSERTZLH+GjAAQ2t3DGuIDoiJ2aleLCvdyJpXQVucMTqnl7C
         nzdwhEV5i7HBSFcs+DsKQTmft/Z0Mjs2LS70utgi9njlx46QoFr88AzTkLH+9Bci9H5q
         ec9IXYV5cHrR3Khk/aqgTkz2GTcx65nDzBFB8LBbv7CjPYllJ4IeTjsCCuhWhp0pWV97
         1m1nq/cioAOVWsSckFuImS3J7P7OlnP8L/1oneYgmmaJozf+uYXplFcbK0Fy77tVy0cA
         I0AkT9mHiXMLGthO8mXk/zs9/704uT9GtkgINZ9Q8VclIKd4UQ0N4ZxtZ3RQHEevETZE
         WSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661047; x=1776265847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=892b1tc3BjJAyN03dRdp5zs01ZYlJJcb9paPjaaRp2k=;
        b=jsosLWPlQEQE6qXVE8rT3vhEMVwlxTjtnoWX4p6OIa7dZD1cCMtvQQGhhFsU/8uuTU
         oP6TZo5Y9izyqN4FRG7LR3FZ6gnZUdUwcCANPHhGzr0WOdPJpc+GyV5++f6tv0RyxH3a
         Z7YrdChQ2NdyPaLGxwnfCpwqHdsE4imw7FWhn3jApmB4sED0tLVxwufXuhm/a2C6RBdW
         UvAEg328Y3tIY4AXzJe4mfHAb6+HtdnmyennLFsvz4ig/lntshUOkXF/hhv0+2PBkI5U
         3V0EexXwuD5+aVqEFbPBAGXAUp0AJQiARGt2SgGfbkjz3OhNfo0mMBlkujsEeZIcZWVh
         o0kw==
X-Gm-Message-State: AOJu0YxE37lYF5+1OumxTg2bm2NJNU3ENpVBsQQBemSBE06o6/HtkA3t
	bPgvhQ3VUXNQb1MN9q4cCypmcF/hc1H02plnC2TQaq1l8RdJTmnGG/Pr
X-Gm-Gg: AeBDiesRq/z4CjtyWm9Y0dZTXyMvifvBQYi0H9qGHiqhj+j4TgAGL61qqyJ4iOhPhug
	SHvUGENUVrBcWCW75POjbfrQUMFwwpJ6glTZBwcW0gJZeTiZmLbLGz3/dInq7gkhlRq9nlaRAEZ
	SkGu2ZxiN1ylhyFsJcAMZy/DwZwFzx/6VpnIaKZvQZVBsdqgPFD2cT+apC71J0OFZ1mC8PcGW7z
	j23q7nHqcpcGddx8gegpNRrLaxN9t4sADBGl7WB0fPgVWV8KBDVJH6/VqBBI8N9gWfb+YaBF5YV
	97Vw3zN9D1k/j5CF4wk2pVY8Kq9ar+E+6A73U2KKhGdCVhKXs1+ZzoWzfhMD26rVPLwlsloPmSY
	eChb1mqPulbk2P6zptK/abNIHcj3DPAkwZ9zzVa29a3QJFtXp9D5Zk7ZbV3LXeXMprz9Ym0UT2t
	2cy58ChAhHfqRirg==
X-Received: by 2002:a05:600c:8b30:b0:483:6d42:25c6 with SMTP id 5b1f17b1804b1-488cd053cb2mr753455e9.23.1775661044840;
        Wed, 08 Apr 2026 08:10:44 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:43::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a7165aasm654151965e9.14.2026.04.08.08.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:10:43 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 08 Apr 2026 08:10:12 -0700
Subject: [PATCH RFC bpf-next v2 07/18] bpf: Implement batch ops for
 resizable hashtab
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-rhash-v2-7-3b3675da1f6e@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775661029; l=5122;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=6ZxUVoh8s23ZIFaGeFtUWSS8X5bwxzpB0yV7560+eVk=;
 b=rtlW9CA1kxhpqVV6OIOR3qY+pVN7UHb1ITilzZdy4Y2sR8j8CxPhzqZJkj9EazmbsGvJZeS+9
 OpGM4ZFnYODAljkPxqjvnkKJiX4/G/yr9+Yaet7yTa8rlTTU6/AUPqU
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

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/hashtab.c | 137 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 134 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index e79c194e2779..a79d434dc626 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -3051,19 +3051,150 @@ static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
 
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

-- 
2.52.0

