Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDAD3D5645
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661040; cv=none; b=D7ZRAFMr2CX64o4CXp71yAd99euxJ1zXEhIPGtHeSR11RvyVBPy/axjjTG3QoKh6OLecvMbvw4dYmb9hbishhmxRpQ6wqpeipBF1laUthkpHcy5nYdy4pPKdpiiq7ZzZH3rchZcI2Cz8a6s/MajVaWBg29Vw3Qose1wjnD15gu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661040; c=relaxed/simple;
	bh=vz7C8wWwHimiBpMm+CfGV4dBS51KECqvHA7hhOrUMWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a9J7/K1NxBpga/mgl8s7CO3xYK/FxIjYZb0D67uPK1Zj8pwAAdgFoL2HLsDkOPTKGRqwa5d9NqgHghZHs4ug2DZvGHWib/qFBm+vZp0GIyUquuLOzsRk6j+fHJEDazia79Nw0VkIc3rvlOzazts2JNqdxPbd5Fo34gbfbE9mwwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knKEXXvz; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knKEXXvz"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43b8982c2f4so3839093f8f.2
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 08:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775661037; x=1776265837; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QGVWEQwDCusaFjfdPmwKjVNH22iSkE62o24hbd8Vnyk=;
        b=knKEXXvzwJNS6DphrPc/Yu5C0G1LTYV5A1ePog39pUChX3pOqD5d7AZGe6ncDzCiEd
         X+a2BSH5FEU85sW3UrSp8HXu2jvv3bUGFggoOM849j8Q+SRCt0GmU7vW1cDSw3sDdcXQ
         yUfe2CkjG8SwxnL42oQfG6qOhcYAcndDPjWJs+XiITMDrbvec1THs5OKjBgoDhYpI6vf
         Fk2eSRhPXIkI1zDBLTZVM0+15u1cajAVDqjywL7L2j716kYkhepsjCU8tbLiBYLZBEbi
         ge0aMmQcQ2OKaaoqSes2Jz1KcPuW7iSbwdLoh/5Tw5cIR4Cy5lt2d6huVkld6xZOU69n
         PSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661037; x=1776265837;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QGVWEQwDCusaFjfdPmwKjVNH22iSkE62o24hbd8Vnyk=;
        b=FWGmHI4hA10bvam3ZJZBF6MgEEbd4gF3ERNwF7OEqsaYDGzUH/hucZ4oatOq/4FpGv
         oa+a6wwhz996ys5cBW4580ZOQEzFC2Pisz6nku5xXhCoRJolGRNH/My8jx5jsjdZ42kd
         bZmdQoXQHq1cYAfFbW+53xiHVmYrkShoMX1/QI8HEhDpW5jepRoPSFv1YIgwBqDff9Vm
         +VFyafQ5sK85yD65T88rbNcEnLJ32+ZTLSpkpqNmVhK5wjHvwdfM8oOxx2wfx6Xpqfp4
         hPnsl51JlZd1Mwy7jLB2UXoXlrVlfYL1iikfL3ulsOPMooBh3oZvwng9z4vyH/5sW2uJ
         S0lA==
X-Gm-Message-State: AOJu0YxBtDvQzn9YnayUVAyPm1aY4flXcQn7HAQZZB+styZCVjCwbBXW
	Q382TV4B/LeJN2iJ4kt6AbhcJoX/m1jI7LzMKLGh8oLZ1qYEXLeI+kDA
X-Gm-Gg: AeBDieu9KIKdD+s1qfI33zcp+Ij2FRrZ79Fq+sh1fjuEx9/Vr4HChysekrdPewNO7Vl
	Mgasq1QxkatRG3wuWw9TkOSLTuaWZHOPhDxoF9grUCgQe0G8ILAsLzc4Dd+A0fh5ChRjt4E8QT0
	sIUn/mp+OjaO+oW1VcD8ICW6sb1glZ1Pm11gKCzKFaseuVsaugCmi4CYJv/9uL2+1bxSvL8MiPM
	6QbanNPA/638wWG2Q89rkCq9YxpgY3Rgo3vcKmbNMj5XLhMD+KO3qaK17zQIP1CoptZ8zADiRs2
	/xIVVRJe8aBNRJNRdO/2fd6aVwo2cyO/UIbHVmULw4JTeiZ7svSwIvd7MAsaqzwRfTOv1YyWTPj
	TLwUHtb3rC7Z15mLEzxiZvcmAxU7t7BlyUV/+Wd3IalwcA2wRM36N7wjrVYPRafCCyQviwnQtOg
	yruALXlQfJBXwm0g==
X-Received: by 2002:a05:6000:310a:b0:43c:fc5c:a9fc with SMTP id ffacd0b85a97d-43d2929dcd9mr31799891f8f.21.1775661037042;
        Wed, 08 Apr 2026 08:10:37 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a71f7sm61107436f8f.1.2026.04.08.08.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:10:36 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 08 Apr 2026 08:10:08 -0700
Subject: [PATCH RFC bpf-next v2 03/18] bpf: Implement lookup, delete,
 update for resizable hashtab
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-rhash-v2-3-3b3675da1f6e@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775661028; l=5912;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=Pzw1V5xhpQElDYJRRHqoM3fgJEbx6ze/rivBVEB7FDw=;
 b=K1VA7KJQnmTEMtUk7TGtlR3sX4zia1G/KLqPgVFnXRoedf//NhwL5RKB5f8BuyJ2Y+wdmZc4H
 TBF9BztJMbCC9YBTh+K50jckGu0zLOXm5Mo1KTvVnvNQPNB/IlegdIj
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Use rhashtable_lookup_likely() for lookups, rhashtable_remove_fast()
for deletes, and rhashtable_lookup_get_insert_fast() for inserts.

Updates modify values in place under RCU rather than allocating a
new element and swapping the pointer (as regular htab does). This
trades read consistency for performance: concurrent readers may
see partial updates. Users requiring consistent reads should use
BPF_F_LOCK.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/hashtab.c | 141 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 134 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 9e7806814fec..ea7314cc3703 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2755,6 +2755,11 @@ struct bpf_rhtab {
 	u32 elem_size;
 };
 
+static inline void *rhtab_elem_value(struct rhtab_elem *l, u32 key_size)
+{
+	return l->data + round_up(key_size, 8);
+}
+
 static struct bpf_map *rhtab_map_alloc(union bpf_attr *attr)
 {
 	return ERR_PTR(-EOPNOTSUPP);
@@ -2769,33 +2774,155 @@ static void rhtab_map_free(struct bpf_map *map)
 {
 }
 
+static void *rhtab_lookup_elem(struct bpf_map *map, void *key)
+{
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	/* Using constant zeroed params to force rhashtable use inlined hashfunc */
+	static const struct rhashtable_params params = { 0 };
+
+	return rhashtable_lookup_likely(&rhtab->ht, key, params);
+}
+
 static void *rhtab_map_lookup_elem(struct bpf_map *map, void *key) __must_hold(RCU)
 {
-	return NULL;
+	struct rhtab_elem *l;
+
+	l = rhtab_lookup_elem(map, key);
+	return l ? rhtab_elem_value(l, map->key_size) : NULL;
+}
+
+static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem)
+{
+	int err;
+
+	err = rhashtable_remove_fast(&rhtab->ht, &elem->node, rhtab->params);
+	if (err)
+		return err;
+
+	bpf_map_free_internal_structs(&rhtab->map, rhtab_elem_value(elem, rhtab->map.key_size));
+	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
+	return 0;
 }
 
 static long rhtab_map_delete_elem(struct bpf_map *map, void *key)
 {
-	return -EOPNOTSUPP;
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	struct rhtab_elem *l;
+
+	guard(rcu)();
+	l = rhtab_lookup_elem(map, key);
+	return l ? rhtab_delete_elem(rhtab, l) : -ENOENT;
+}
+
+static void rhtab_read_elem_value(struct bpf_map *map, void *dst, struct rhtab_elem *elem,
+				  u64 flags)
+{
+	void *src = rhtab_elem_value(elem, map->key_size);
+
+	if (flags & BPF_F_LOCK)
+		copy_map_value_locked(map, dst, src, true);
+	else
+		copy_map_value(map, dst, src);
 }
 
 static int rhtab_map_lookup_and_delete_elem(struct bpf_map *map, void *key, void *value, u64 flags)
 {
-	return -EOPNOTSUPP;
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	struct rhtab_elem *l;
+	int err;
+
+	if ((flags & ~BPF_F_LOCK) ||
+	    ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK)))
+		return -EINVAL;
+
+	/* Make sure element is not deleted between lookup and copy */
+	guard(rcu)();
+
+	l = rhtab_lookup_elem(map, key);
+	if (!l)
+		return -ENOENT;
+
+	rhtab_read_elem_value(map, value, l, flags);
+	err = rhtab_delete_elem(rhtab, l);
+	if (err)
+		return err;
+
+	check_and_init_map_value(map, value);
+	return 0;
 }
 
-static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u64 map_flags)
+static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *elem, void *value,
+				      u64 map_flags)
 {
-	return -EOPNOTSUPP;
+	if (map_flags & BPF_NOEXIST)
+		return -EEXIST;
+
+	if (map_flags & BPF_F_LOCK)
+		copy_map_value_locked(map, rhtab_elem_value(elem, map->key_size), value, false);
+	else
+		copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
+	return 0;
 }
 
-static void rhtab_map_free_internal_structs(struct bpf_map *map)
+static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u64 map_flags)
 {
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	struct rhtab_elem *elem, *tmp;
+
+	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST))
+		return -EINVAL;
+
+	if ((map_flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK))
+		return -EINVAL;
+
+	guard(rcu)();
+	elem = rhtab_lookup_elem(map, key);
+	if (elem)
+		return rhtab_map_update_existing(map, elem, value, map_flags);
+
+	if (map_flags & BPF_EXIST)
+		return -ENOENT;
+
+	/* Check max_entries limit before inserting new element */
+	if (atomic_read(&rhtab->ht.nelems) >= map->max_entries)
+		return -E2BIG;
+
+	elem = bpf_mem_cache_alloc(&rhtab->ma);
+	if (!elem)
+		return -ENOMEM;
+
+	memcpy(elem->data, key, map->key_size);
+	copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
+
+	tmp = rhashtable_lookup_get_insert_fast(&rhtab->ht, &elem->node, rhtab->params);
+	if (tmp) {
+		bpf_mem_cache_free(&rhtab->ma, elem);
+		if (IS_ERR(tmp))
+			return PTR_ERR(tmp);
+
+		return rhtab_map_update_existing(map, tmp, value, map_flags);
+	}
+
+	return 0;
 }
 
 static int rhtab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 {
-	return -EOPNOTSUPP;
+	struct bpf_insn *insn = insn_buf;
+	const int ret = BPF_REG_0;
+
+	BUILD_BUG_ON(!__same_type(&rhtab_lookup_elem,
+				  (void *(*)(struct bpf_map *map, void *key)) NULL));
+	*insn++ = BPF_EMIT_CALL(rhtab_lookup_elem);
+	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 1);
+	*insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
+				offsetof(struct rhtab_elem, data) + round_up(map->key_size, 8));
+
+	return insn - insn_buf;
+}
+
+static void rhtab_map_free_internal_structs(struct bpf_map *map)
+{
 }
 
 static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)

-- 
2.52.0

