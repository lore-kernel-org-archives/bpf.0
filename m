Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398FC3EBF3A
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227952; cv=none; b=SVJP2djM4JlZPhjspKhMjVjQbO4opoWIglH+NmR1A0NztuUQ1XRRRN7Taf9jj5qJsVXUSLaUJIN7Fft+IOgQyoPgW6gD4YGk5yQOF0Cp6ovA4ZKxz7kKtGLq21FAIiD0aa/tM+PY43W6FtGVOJY6q9S/gxKnlfeKEGQQnHHE0DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227952; c=relaxed/simple;
	bh=H5zf7hyY5jhHjLE/Um6PIp4ND2nSLp3EuddCQZIZAwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6+jmK0UoWJoQMaTRo93kuwx8kdcq3hkJMbEaKo6o0fIuUYkdiqZYVuf0NQDks079CvLUy1acd8FoBwNdeZ0lLva0iqLa57cRhGqGmfYURx1fU9gFPO5iG2VU9mveVmetmfx3RaIdjIerVh/wqQBKO75bZBoaeawUJf/q5aQx0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L2lOC/3/; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L2lOC/3/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779227948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/I6S8Kw28BAahmP437WtXsPWiDEg/SpJL4HlJOaL8M=;
	b=L2lOC/3/L8+LUVnPOV/TD7LY9UayHbWUq6pU7DrtaGzDgC2nnsccBjOZ9+2HhskbA23HCS
	PRX9ubEmN53EyK9VP0LSPs8sPLCtFV9tw2SmMvU4hC8ZQgNOhIYcBUFc94mmUNMNE3q0d+
	HGfZzy7jHqIXpVT/2h1M/LqHgZi9SPM=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	'Shakeel Butt ' <shakeel.butt@linux.dev>,
	'Roman Gushchin ' <roman.gushchin@linux.dev>,
	'Amery Hung ' <ameryhung@gmail.com>,
	netdev@vger.kernel.org
Subject: [RFC PATCH bpf-next 03/12] bpf: Add bpf_struct_ops accessor helpers
Date: Tue, 19 May 2026 14:58:10 -0700
Message-ID: <20260519215841.2984970-4-martin.lau@linux.dev>
In-Reply-To: <20260519215841.2984970-1-martin.lau@linux.dev>
References: <20260519215841.2984970-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

Add the helper functions bpf_struct_ops_map_kdata(),
bpf_struct_ops_kdata_map_id(), and bpf_struct_ops_map_cfi_stubs()
in bpf_struct_ops.c. They will be called from cgroup.c in the upcoming
patch to create a struct_ops to cgroup attachment link.

bpf_struct_ops_valid_to_reg() is also exposed for the upcoming caller
in cgroup.c.

The link update validation is also refactored into a new function
bpf_struct_ops_link_update_check() such that it can be reused by the caller
in cgroup.c in the upcoming patch.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf.h         | 28 +++++++++++++++++
 kernel/bpf/bpf_struct_ops.c | 63 ++++++++++++++++++++++++++++---------
 2 files changed, 77 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a276eada19c4..dbf98741f15b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2136,6 +2136,12 @@ int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *map);
 void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog);
 void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux);
 u32 bpf_struct_ops_id(const void *kdata);
+void *bpf_struct_ops_map_kdata(struct bpf_map *map);
+u32 bpf_struct_ops_kdata_map_id(void *kdata);
+void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map);
+bool bpf_struct_ops_valid_to_reg(struct bpf_map *map);
+int bpf_struct_ops_link_update_check(struct bpf_map *new_map, struct bpf_map *old_map,
+				     struct bpf_map *expected_old_map);
 
 #ifdef CONFIG_NET
 /* Define it here to avoid the use of forward declaration */
@@ -2200,6 +2206,28 @@ static inline void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struc
 static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc)
 {
 }
+static inline void *bpf_struct_ops_map_kdata(struct bpf_map *map)
+{
+	return NULL;
+}
+static inline u32 bpf_struct_ops_kdata_map_id(void *kdata)
+{
+	return 0;
+}
+static inline void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map)
+{
+	return NULL;
+}
+static inline bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
+{
+	return false;
+}
+static inline int bpf_struct_ops_link_update_check(struct bpf_map *new_map,
+						   struct bpf_map *old_map,
+						   struct bpf_map *expected_old_map)
+{
+	return -EOPNOTSUPP;
+}
 
 #endif
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 28eab24ef0ed..8650a3b88bf6 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1199,7 +1199,33 @@ u32 bpf_struct_ops_id(const void *kdata)
 }
 EXPORT_SYMBOL_GPL(bpf_struct_ops_id);
 
-static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
+void *bpf_struct_ops_map_kdata(struct bpf_map *map)
+{
+	struct bpf_struct_ops_map *st_map;
+
+	st_map = container_of(map, struct bpf_struct_ops_map, map);
+	return st_map->kvalue.data;
+}
+
+u32 bpf_struct_ops_kdata_map_id(void *kdata)
+{
+	struct bpf_struct_ops_value *kvalue =
+		container_of(kdata, struct bpf_struct_ops_value, data);
+	struct bpf_struct_ops_map *st_map =
+		container_of(kvalue, struct bpf_struct_ops_map, kvalue);
+
+	return st_map->map.id;
+}
+
+void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map)
+{
+	struct bpf_struct_ops_map *st_map;
+
+	st_map = container_of(map, struct bpf_struct_ops_map, map);
+	return st_map->st_ops_desc->st_ops->cfi_stubs;
+}
+
+bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
 {
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
 
@@ -1252,6 +1278,26 @@ static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
 	return 0;
 }
 
+int bpf_struct_ops_link_update_check(struct bpf_map *new_map,
+				     struct bpf_map *old_map,
+				     struct bpf_map *expected_old_map)
+{
+	struct bpf_struct_ops_map *st_map, *old_st_map;
+
+	if (!old_map)
+		return -ENOLINK;
+	if (expected_old_map && old_map != expected_old_map)
+		return -EPERM;
+
+	st_map = container_of(new_map, struct bpf_struct_ops_map, map);
+	old_st_map = container_of(old_map, struct bpf_struct_ops_map, map);
+	/* The new and old struct_ops must be the same type. */
+	if (st_map->st_ops_desc != old_st_map->st_ops_desc)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map *new_map,
 					  struct bpf_map *expected_old_map)
 {
@@ -1270,23 +1316,12 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 		return -EOPNOTSUPP;
 
 	mutex_lock(&update_mutex);
-
 	old_map = st_link->map;
-	if (!old_map) {
-		err = -ENOLINK;
-		goto err_out;
-	}
-	if (expected_old_map && old_map != expected_old_map) {
-		err = -EPERM;
+	err = bpf_struct_ops_link_update_check(new_map, old_map, expected_old_map);
+	if (err)
 		goto err_out;
-	}
 
 	old_st_map = container_of(old_map, struct bpf_struct_ops_map, map);
-	/* The new and old struct_ops must be the same type. */
-	if (st_map->st_ops_desc != old_st_map->st_ops_desc) {
-		err = -EINVAL;
-		goto err_out;
-	}
 
 	err = st_map->st_ops_desc->st_ops->update(st_map->kvalue.data, old_st_map->kvalue.data, link);
 	if (err)
-- 
2.53.0-Meta

