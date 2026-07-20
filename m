Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516DC3CDBC0
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537658; cv=none; b=sIHz36NLI9oJElcMCMdO4MaUPj/fyS8E8JZI5XLakMQgLDDTePUQiKNOxG5qx2SHtl8w8kIUBuja5TYrOeJwsu3BuXHbPaPi+6K6WP9ZEWSFc3sgJajWcJnf/oztMYbiYShg5MGJFmKGFlZBqr059phlO/eF/6ocKKG+u91ps+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537658; c=relaxed/simple;
	bh=ud7p5XMn+CjFZucK4hEAtcGu2qMs/97l3UkMG+KT9kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvPhQ6lzszI0hpwpFH5bnxIusaD+Cr+W7YP1DCNoL956U/lfh0NkeVNhh8CyrOM+MxQeYXiGVkaYMaR2dMA1rcxG1lFN90y2TPoPduvqTo+1ZIaSzW57vWktJyOKS994OVJs+lrYjzThWMGLYQyuFtSyLjK6NhsG84qTmgZageE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQDfetyM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQDfetyM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECD01F00A3A;
	Mon, 20 Jul 2026 08:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784537656;
	bh=e1l3oaVNPcAX+21+O86IkFMFmrZrej1wirxCJJLgxs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QQDfetyMbGFOM2vPmC1OyXAmVzlhNgWbQ7pl7aGLMli1BvdPFndn9UvwBGMNeDO/g
	 CrQ2t9pJFkVyCHiKHHMC295HsTXMv5VEGU2Mfu4F7irYcgGQijV9QvKBW+ctB+a7Xr
	 39st5oLiaMC48l/zaYoojW57l3zXOPlP/WOGmeYIWzezqB9CpX4LOsGScBdrX8ElWb
	 ljbwkRnBe8psGkRafs4HzpmXeFKjcme9AFslV29RaNdD06yOg0kXHVQ6QVz2Eudm1P
	 otTcsOwFZzZIM3+bT9JZ2v8xwZ6J+hzXtmADuQ32bfZWGhd4rp7uBbBfISEwCtw1sz
	 A0rrAZj2+p2iA==
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
	STAR Labs SG <info@starlabs.sg>
Subject: [PATCH bpf-next 2/9] bpf: Factor stackid_fastpath function from __bpf_get_stackid
Date: Mon, 20 Jul 2026 10:53:44 +0200
Message-ID: <20260720085351.655075-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720085351.655075-1-jolsa@kernel.org>
References: <20260720085351.655075-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new stackid_fastpath does the fast stack hash and trace check, that
does not need new bucket allocation. It covers both just-ip and buildid
code paths.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 0eafe55b1828..7bc2a966e3e8 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -511,6 +511,7 @@ struct stackid {
 	u32  len;
 	u32  hash;
 	u32  id;
+	bool hash_matches;
 };
 
 static int stackid_init(struct stackid *stackid, struct bpf_map *map,
@@ -531,28 +532,46 @@ static int stackid_init(struct stackid *stackid, struct bpf_map *map,
 	stackid->hash = jhash2((u32 *)stackid->ips, stackid->len / sizeof(u32), 0);
 	stackid->id = stackid->hash & (smap->n_buckets - 1);
 	stackid->bucket = READ_ONCE(smap->buckets[stackid->id]);
+	stackid->hash_matches = stackid->bucket && stackid->bucket->hash == stackid->hash;
 	return 0;
 }
 
+static int stackid_fastpath(struct stackid *stackid, struct bpf_map *map,
+			    struct perf_callchain_entry *trace, u64 flags)
+{
+	int err;
+
+	err = stackid_init(stackid, map, trace, flags);
+	if (err)
+		return err;
+
+	/* fast cmp */
+	if (stackid->hash_matches && flags & BPF_F_FAST_STACK_CMP)
+		return stackid->id;
+
+	if (stack_map_use_build_id(map))
+		return -ENOENT;
+	if (stackid->hash_matches && stackid->bucket->nr == stackid->nr &&
+	    memcmp(stackid->bucket->data, stackid->ips, stackid->len) == 0)
+		return stackid->id;
+	if (stackid->bucket && !(flags & BPF_F_REUSE_STACKID))
+		return -EEXIST;
+	return -ENOENT;
+}
+
 static long __bpf_get_stackid(struct stackid *stackid, struct bpf_map *map,
 			      struct perf_callchain_entry *trace, u64 flags)
 {
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
 	struct stack_map_bucket *new_bucket, *old_bucket;
 	bool user = flags & BPF_F_USER_STACK;
-	bool hash_matches;
 	u32 trace_len, i;
 	int err;
 
-	err = stackid_init(stackid, map, trace, flags);
-	if (err)
+	err = stackid_fastpath(stackid, map, trace, flags);
+	if (err != -ENOENT)
 		return err;
 
-	hash_matches = stackid->bucket && stackid->bucket->hash == stackid->hash;
-	/* fast cmp */
-	if (hash_matches && flags & BPF_F_FAST_STACK_CMP)
-		return stackid->id;
-
 	if (stack_map_use_build_id(map)) {
 		struct bpf_stack_build_id *id_offs;
 
@@ -567,7 +586,7 @@ static long __bpf_get_stackid(struct stackid *stackid, struct bpf_map *map,
 			id_offs[i].ip = stackid->ips[i];
 		stack_map_get_build_id_offset(id_offs, stackid->nr, user, false /* !may_fault */);
 		trace_len = stackid->nr * sizeof(struct bpf_stack_build_id);
-		if (hash_matches && stackid->bucket->nr == stackid->nr &&
+		if (stackid->hash_matches && stackid->bucket->nr == stackid->nr &&
 		    memcmp(stackid->bucket->data, new_bucket->data, trace_len) == 0) {
 			pcpu_freelist_push(&smap->freelist, &new_bucket->fnode);
 			return stackid->id;
@@ -577,12 +596,6 @@ static long __bpf_get_stackid(struct stackid *stackid, struct bpf_map *map,
 			return -EEXIST;
 		}
 	} else {
-		if (hash_matches && stackid->bucket->nr == stackid->nr &&
-		    memcmp(stackid->bucket->data, stackid->ips, stackid->len) == 0)
-			return stackid->id;
-		if (stackid->bucket && !(flags & BPF_F_REUSE_STACKID))
-			return -EEXIST;
-
 		new_bucket = (struct stack_map_bucket *)
 			pcpu_freelist_pop(&smap->freelist);
 		if (unlikely(!new_bucket))
-- 
2.54.0

