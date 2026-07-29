Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF22B38D3F4
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314304; cv=none; b=tnbt+wkMA76S8SbjUFjHeAyf2k7/LqjQSBPnWAi80iPPX+YWJACPLP6kFBYuHfmMRbalu2ddBqURU7V0KZ65wfxvu0Ac4+vg+1lm8CY34+ykSdCcs0BDTswU54YgNqHMtkJrMqvFADSLk2bR66o4Ek/LXl6mlmvPr5mYXYho/+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314304; c=relaxed/simple;
	bh=HE1ZOXpPJd79PrjzcwR7tKd4NbrNFHUu0PkGLHEJ9O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fp8RV9bsXeMTekuk2sqB8AGnsFid6efGOS0+7vha4hhtWMGa5VVweyZ5EnldiJT/k35QsTuQqyWUtanMBg9n0agYHVlOKoPW107ZWin55Qnx/TFwIw6zTwVJtAQasB8aiJ2+0hUcHf4P9OvoCHmO1andQkUV6NkwhDFXQpZIivA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2fp4SNQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2fp4SNQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AE21F000E9;
	Wed, 29 Jul 2026 08:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785314302;
	bh=VymZPR4sarBcVrcB+xAmgGnhFOqP+PHBZ1R+ypKWvVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i2fp4SNQKlyOyZlIXOQoJNyLPlSmOMtxd59HF89DVfBVMLUGJXsVc1J2E/7X6cQHR
	 kmV7V/CGK5a4Ssz4cOqPJyz7JRbIy9TK+6OZVsiI/o/1eH3KL0gbVALoV15rnFCKzl
	 hYGutltjuBi5FY+hNdb6azeoWdicgVFXb+wP3l7gsGFS7mSEpFxOgRVgkP3YPALuYP
	 R9GJorVVxYqmiHDl1NlIOqNvaCqEwaifeXxdS0GRapRUyvyJIliiHPy0RNLaL9z6Xr
	 vmw1+AcsoB5lx6sxVQufLqTyIWGCLpMsZsqnuU9gII6JgnE47hjisohkuK8UlIT5OF
	 UZJazHpGU07Sg==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>,
	Tao Chen <chen.dylane@linux.dev>,
	STAR Labs SG <info@starlabs.sg>,
	Arnaud Lecomte <contact@arnaud-lcm.com>
Subject: [PATCHv2 bpf-next 01/11] bpf: Factor stackid_init function from __bpf_get_stackid
Date: Wed, 29 Jul 2026 10:37:57 +0200
Message-ID: <20260729083807.1588544-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729083807.1588544-1-jolsa@kernel.org>
References: <20260729083807.1588544-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new stackid_init function stores all the necessary bits for stackid
trace and it will be used by other functions in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 95 +++++++++++++++++++++++++++----------------
 1 file changed, 59 insertions(+), 36 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 41fe87d7302f..0eafe55b1828 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -504,33 +504,54 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
 #endif
 }
 
-static long __bpf_get_stackid(struct bpf_map *map,
-			      struct perf_callchain_entry *trace, u64 flags)
+struct stackid {
+	struct stack_map_bucket *bucket;
+	u64 *ips;
+	u32  nr;
+	u32  len;
+	u32  hash;
+	u32  id;
+};
+
+static int stackid_init(struct stackid *stackid, struct bpf_map *map,
+			struct perf_callchain_entry *trace, u64 flags)
 {
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
-	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
-	u32 hash, id, trace_nr, trace_len, i, max_depth;
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
-	bool user = flags & BPF_F_USER_STACK;
-	u64 *ips;
-	bool hash_matches;
+	u32 max_depth;
 
 	if (trace->nr <= skip)
 		/* skipping more than usable stack trace */
 		return -EFAULT;
 
 	max_depth = stack_map_calculate_max_depth(map->value_size, stack_map_data_size(map), flags);
-	trace_nr = min_t(u32, trace->nr - skip, max_depth - skip);
-	trace_len = trace_nr * sizeof(u64);
-	ips = trace->ip + skip;
-	hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
-	id = hash & (smap->n_buckets - 1);
-	bucket = READ_ONCE(smap->buckets[id]);
+	stackid->nr = min_t(u32, trace->nr - skip, max_depth - skip);
+	stackid->len = stackid->nr * sizeof(u64);
+	stackid->ips = trace->ip + skip;
+	stackid->hash = jhash2((u32 *)stackid->ips, stackid->len / sizeof(u32), 0);
+	stackid->id = stackid->hash & (smap->n_buckets - 1);
+	stackid->bucket = READ_ONCE(smap->buckets[stackid->id]);
+	return 0;
+}
 
-	hash_matches = bucket && bucket->hash == hash;
+static long __bpf_get_stackid(struct stackid *stackid, struct bpf_map *map,
+			      struct perf_callchain_entry *trace, u64 flags)
+{
+	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
+	struct stack_map_bucket *new_bucket, *old_bucket;
+	bool user = flags & BPF_F_USER_STACK;
+	bool hash_matches;
+	u32 trace_len, i;
+	int err;
+
+	err = stackid_init(stackid, map, trace, flags);
+	if (err)
+		return err;
+
+	hash_matches = stackid->bucket && stackid->bucket->hash == stackid->hash;
 	/* fast cmp */
 	if (hash_matches && flags & BPF_F_FAST_STACK_CMP)
-		return id;
+		return stackid->id;
 
 	if (stack_map_use_build_id(map)) {
 		struct bpf_stack_build_id *id_offs;
@@ -540,42 +561,42 @@ static long __bpf_get_stackid(struct bpf_map *map,
 			pcpu_freelist_pop(&smap->freelist);
 		if (unlikely(!new_bucket))
 			return -ENOMEM;
-		new_bucket->nr = trace_nr;
+		new_bucket->nr = stackid->nr;
 		id_offs = (struct bpf_stack_build_id *)new_bucket->data;
-		for (i = 0; i < trace_nr; i++)
-			id_offs[i].ip = ips[i];
-		stack_map_get_build_id_offset(id_offs, trace_nr, user, false /* !may_fault */);
-		trace_len = trace_nr * sizeof(struct bpf_stack_build_id);
-		if (hash_matches && bucket->nr == trace_nr &&
-		    memcmp(bucket->data, new_bucket->data, trace_len) == 0) {
+		for (i = 0; i < stackid->nr; i++)
+			id_offs[i].ip = stackid->ips[i];
+		stack_map_get_build_id_offset(id_offs, stackid->nr, user, false /* !may_fault */);
+		trace_len = stackid->nr * sizeof(struct bpf_stack_build_id);
+		if (hash_matches && stackid->bucket->nr == stackid->nr &&
+		    memcmp(stackid->bucket->data, new_bucket->data, trace_len) == 0) {
 			pcpu_freelist_push(&smap->freelist, &new_bucket->fnode);
-			return id;
+			return stackid->id;
 		}
-		if (bucket && !(flags & BPF_F_REUSE_STACKID)) {
+		if (stackid->bucket && !(flags & BPF_F_REUSE_STACKID)) {
 			pcpu_freelist_push(&smap->freelist, &new_bucket->fnode);
 			return -EEXIST;
 		}
 	} else {
-		if (hash_matches && bucket->nr == trace_nr &&
-		    memcmp(bucket->data, ips, trace_len) == 0)
-			return id;
-		if (bucket && !(flags & BPF_F_REUSE_STACKID))
+		if (hash_matches && stackid->bucket->nr == stackid->nr &&
+		    memcmp(stackid->bucket->data, stackid->ips, stackid->len) == 0)
+			return stackid->id;
+		if (stackid->bucket && !(flags & BPF_F_REUSE_STACKID))
 			return -EEXIST;
 
 		new_bucket = (struct stack_map_bucket *)
 			pcpu_freelist_pop(&smap->freelist);
 		if (unlikely(!new_bucket))
 			return -ENOMEM;
-		memcpy(new_bucket->data, ips, trace_len);
+		memcpy(new_bucket->data, stackid->ips, stackid->len);
 	}
 
-	new_bucket->hash = hash;
-	new_bucket->nr = trace_nr;
+	new_bucket->hash = stackid->hash;
+	new_bucket->nr = stackid->nr;
 
-	old_bucket = xchg(&smap->buckets[id], new_bucket);
+	old_bucket = xchg(&smap->buckets[stackid->id], new_bucket);
 	if (old_bucket)
 		pcpu_freelist_push(&smap->freelist, &old_bucket->fnode);
-	return id;
+	return stackid->id;
 }
 
 BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
@@ -584,6 +605,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	u32 elem_size = stack_map_data_size(map);
 	bool user = flags & BPF_F_USER_STACK;
 	struct perf_callchain_entry *trace;
+	struct stackid stackid;
 	bool kernel = !user;
 	u32 max_depth;
 
@@ -599,7 +621,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 		/* couldn't fetch the stack trace */
 		return -EFAULT;
 
-	return __bpf_get_stackid(map, trace, flags);
+	return __bpf_get_stackid(&stackid, map, trace, flags);
 }
 
 const struct bpf_func_proto bpf_get_stackid_proto = {
@@ -628,6 +650,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 {
 	struct perf_event *event = ctx->event;
 	struct perf_callchain_entry *trace;
+	struct stackid stackid;
 	bool kernel, user;
 	__u64 nr_kernel;
 	int ret;
@@ -653,7 +676,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 
 	if (kernel) {
 		trace->nr = nr_kernel;
-		ret = __bpf_get_stackid(map, trace, flags);
+		ret = __bpf_get_stackid(&stackid, map, trace, flags);
 	} else { /* user */
 		u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
 
@@ -662,7 +685,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 			return -EFAULT;
 
 		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
-		ret = __bpf_get_stackid(map, trace, flags);
+		ret = __bpf_get_stackid(&stackid, map, trace, flags);
 	}
 
 	/* restore nr */
-- 
2.54.0

