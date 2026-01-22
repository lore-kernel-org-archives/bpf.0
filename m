Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882A2392B81
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769095922; cv=none; b=P1173BaHtzs2CBUchPORJ839Bfd9eMZkgw1i2/IbpPJ/gVbPS1elJcD3Azg46WB8S04kBH3Gso1kkIrWRf8zN+3aGk3nmK1QNUwwA/6fwyh/fYQlkwkEjCGRuxzREJ+jZelHVIGs/sslO66DsgU8y3D1EeYbTQv5huk6+i4LKcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769095922; c=relaxed/simple;
	bh=pRa//8PzCcBD7X16JjPzDoiWbVbFV9R8qJmQeWgEkcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+3k1eQvSxoeXMtjd7EF3oFl3LsZ9aptjj25mwn80Lx2ym/a1OH/aVnqgZ8lGYctJEnoSbvZ+D5SBwgVNj4RpZh6jX5H91UWGwGj+3RVFu7VMBWyihD/jTsajAuoVN7vX9Kgj6njXrSlV88BbuGZHAmYvV5/43LQxS/c4EYK/W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D8BT5f9G; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D8BT5f9G"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769095915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zfS4wRyf/VRnjwnPX4tgHWNsIgrX88DqFs7Pj+omr4c=;
	b=D8BT5f9Gm42ACxpty+gumNX4BsodB+xW9AZamL4kiTmTus1d391WQtBJRgk84lQ/68Zl2I
	DkBI0uJG/In3afQy2hEVaU41Ush0RNT4Hecq4lOI19wkTFDUlwtgauMw7o10uxGhnwU3vf
	xRZ9CpjVZbBAC/2LLdV7kHE+0V82Q3M=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 1/2] bpf: Disallow BPF_F_LOCK with mixed special fields and centralize flag checks
Date: Thu, 22 Jan 2026 23:31:19 +0800
Message-ID: <20260122153120.69249-2-leon.hwang@linux.dev>
In-Reply-To: <20260122153120.69249-1-leon.hwang@linux.dev>
References: <20260122153120.69249-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Disallow combining BPF_F_LOCK with map values that contain special BTF
fields other than bpf_spin_lock (e.g. kptr or uptr). Such mixing may lead
to subtle or undefined behavior in map value updating. Reject these
combinations early by returning -EOPNOTSUPP.

Centralize map update flag validation in bpf_map_check_op_flags() and
reuse it across array, hash, local-storage, and task-storage map update
paths. Explicitly reject incompatible BPF_NOEXIST/BPF_EXIST combinations
and invalid BPF_F_LOCK usage to keep flag validation consistent and
eliminate duplicated per-map checks.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h            |  7 +++++++
 kernel/bpf/arraymap.c          | 11 ++++-------
 kernel/bpf/bpf_local_storage.c |  7 -------
 kernel/bpf/bpf_task_storage.c  |  3 ---
 kernel/bpf/hashtab.c           |  8 +++-----
 5 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5936f8e2996f..c5863487ee73 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3935,9 +3935,16 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
 	if ((u32)flags & ~allowed_flags)
 		return -EINVAL;
 
+	/* BPF_NOEXIST and BPF_EXIST are mutually exclusive. */
+	if ((flags & (BPF_NOEXIST | BPF_EXIST)) == (BPF_NOEXIST | BPF_EXIST))
+		return -EINVAL;
+
 	if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK))
 		return -EINVAL;
 
+	if ((flags & BPF_F_LOCK) && btf_record_has_field(map->record, ~BPF_SPIN_LOCK))
+		return -EOPNOTSUPP;
+
 	if (!(flags & BPF_F_CPU) && flags >> 32)
 		return -EINVAL;
 
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 67e9e811de3a..1cff40f109cd 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -366,10 +366,7 @@ static long array_map_update_elem(struct bpf_map *map, void *key, void *value,
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	u32 index = *(u32 *)key;
 	char *val;
-
-	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST))
-		/* unknown flags */
-		return -EINVAL;
+	int err;
 
 	if (unlikely(index >= array->map.max_entries))
 		/* all elements were pre-allocated, cannot insert a new one */
@@ -379,9 +376,9 @@ static long array_map_update_elem(struct bpf_map *map, void *key, void *value,
 		/* all elements already exist */
 		return -EEXIST;
 
-	if (unlikely((map_flags & BPF_F_LOCK) &&
-		     !btf_record_has_field(map->record, BPF_SPIN_LOCK)))
-		return -EINVAL;
+	err = bpf_map_check_op_flags(map, map_flags, BPF_EXIST | BPF_F_LOCK);
+	if (unlikely(err))
+		return err;
 
 	if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
 		val = this_cpu_ptr(array->pptrs[index & array->index_mask]);
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index e2fe6c32822b..80b50091cbbf 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -493,13 +493,6 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	unsigned long flags;
 	int err;
 
-	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
-	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
-	    /* BPF_F_LOCK can only be used in a value with spin_lock */
-	    unlikely((map_flags & BPF_F_LOCK) &&
-		     !btf_record_has_field(smap->map.record, BPF_SPIN_LOCK)))
-		return ERR_PTR(-EINVAL);
-
 	if (gfp_flags == GFP_KERNEL && (map_flags & ~BPF_F_LOCK) != BPF_NOEXIST)
 		return ERR_PTR(-EINVAL);
 
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index a1dc1bf0848a..21d84818e64e 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -125,9 +125,6 @@ static long bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
 	struct pid *pid;
 	int fd, err;
 
-	if ((map_flags & BPF_F_LOCK) && btf_record_has_field(map->record, BPF_UPTR))
-		return -EOPNOTSUPP;
-
 	fd = *(int *)key;
 	pid = pidfd_get_pid(fd, &f_flags);
 	if (IS_ERR(pid))
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 3b9d297a53be..2f6ed3e80308 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1093,9 +1093,9 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	u32 key_size, hash;
 	int ret;
 
-	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST))
-		/* unknown flags */
-		return -EINVAL;
+	ret = bpf_map_check_op_flags(map, map_flags, BPF_NOEXIST | BPF_EXIST | BPF_F_LOCK);
+	if (unlikely(ret))
+		return ret;
 
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
@@ -1107,8 +1107,6 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	head = &b->head;
 
 	if (unlikely(map_flags & BPF_F_LOCK)) {
-		if (unlikely(!btf_record_has_field(map->record, BPF_SPIN_LOCK)))
-			return -EINVAL;
 		/* find an element without taking the bucket lock */
 		l_old = lookup_nulls_elem_raw(head, hash, key, key_size,
 					      htab->n_buckets);
-- 
2.52.0

