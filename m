Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C3034C802
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770368861; cv=none; b=DHR22Dnq5CLopTISsaxMvTZYSSomv4UsmmTZ+4DXyw0PsvM/8F13ZiNJGlFoT0EJ2MDEVTN8kHCZxbx8JDlenLf5Kpt2MtipQ/jFHM8tL8jx9mpDrTSeTZXPkUzCyz6ifI4718nbivaw9qkZtnYUL6Z4N60X4zWIo8sdGnBONkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770368861; c=relaxed/simple;
	bh=+2yHBw6ac7SxT+X42kuM/2ICkoN7tjnGPgAGJln8W9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDo3wbAu1jnuna/aSbfoqiHuDaWHhhiOaGyORT9mx2f0y7fjYU9EmLrmMrbINTIFh6MEZ0l4jf8M3KNznG5tJ0rKJOyLBThnZXcGrJm9mz2kxL7rxAsBdbAMaK3+wJLz7rfx4VoBsIvJs03USIivvC1jIQy5NUuOuGDeJ6BJVMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gEBjN7UQ; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gEBjN7UQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770368859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+6dT+mhlCTmpUI46EFabQ09TR0b9pvo7v3d+5iOG28Y=;
	b=gEBjN7UQISk9a5e/cHGq/jpbv8TFVdBhVQwDmCZHT+0vc+UZrltJEDrpwD1KHunNjXyFJr
	C+4Q9Kj4dFcJ91CfJ5M2oZ60+r8AEHUQ1OgNSCH8vF4tjnBjLqwdz0uhEsIRBLPSESeXJ3
	cpiis+A1ugX8nMKlUntkor/JhIVyZHk=
From: Tao Chen <chen.dylane@linux.dev>
To: song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v2 2/2] bpf: Add preempt disable for bpf_get_stackid
Date: Fri,  6 Feb 2026 17:06:53 +0800
Message-ID: <20260206090653.1336687-2-chen.dylane@linux.dev>
In-Reply-To: <20260206090653.1336687-1-chen.dylane@linux.dev>
References: <20260206090653.1336687-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The get_perf_callchain() return values may be reused if a task is preempted
after the BPF program enters migrate disable mode, so we should add
preempt_disable.
The get build-id offset in __bpf_get_stackid may increase the length
of the preempt disabled section. Luckily, it is safe to enable preempt
after perf callchain ips copied to BPF map bucket memory, so we can enable
preempt before stack_map_get_build_id_offset.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/stackmap.c | 84 +++++++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 31 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 1b100a03ef2..d263f851f08 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -246,33 +246,50 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
 #endif
 }
 
-static long __bpf_get_stackid(struct bpf_map *map,
-			      struct perf_callchain_entry *trace, u64 flags)
+static long __bpf_get_stackid(struct bpf_map *map, struct pt_regs *regs,
+			      struct perf_callchain_entry *trace_in, u64 flags)
 {
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
 	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
 	u32 hash, id, trace_nr, trace_len, i, max_depth;
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
 	bool user = flags & BPF_F_USER_STACK;
+	bool kernel = !user;
+	long ret;
 	u64 *ips;
 	bool hash_matches;
+	struct perf_callchain_entry *trace;
+
+	max_depth = stack_map_calculate_max_depth(map->value_size, stack_map_data_size(map), flags);
+	if (trace_in) {
+		trace = trace_in;
+	} else {
+		preempt_disable();
+		trace = get_perf_callchain(regs, kernel, user, max_depth, false, false, 0);
+		if (unlikely(!trace)) {
+			ret = -EFAULT;
+			goto go_out;
+		}
+	}
 
-	if (trace->nr <= skip)
+	if (trace->nr <= skip) {
 		/* skipping more than usable stack trace */
-		return -EFAULT;
+		ret = -EFAULT;
+		goto go_out;
+	}
 
-	max_depth = stack_map_calculate_max_depth(map->value_size, stack_map_data_size(map), flags);
 	trace_nr = min_t(u32, trace->nr - skip, max_depth - skip);
 	trace_len = trace_nr * sizeof(u64);
 	ips = trace->ip + skip;
 	hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
 	id = hash & (smap->n_buckets - 1);
+	ret = id;
 	bucket = READ_ONCE(smap->buckets[id]);
 
 	hash_matches = bucket && bucket->hash == hash;
 	/* fast cmp */
 	if (hash_matches && flags & BPF_F_FAST_STACK_CMP)
-		return id;
+		goto go_out;
 
 	if (stack_map_use_build_id(map)) {
 		struct bpf_stack_build_id *id_offs;
@@ -280,12 +297,22 @@ static long __bpf_get_stackid(struct bpf_map *map,
 		/* for build_id+offset, pop a bucket before slow cmp */
 		new_bucket = (struct stack_map_bucket *)
 			pcpu_freelist_pop(&smap->freelist);
-		if (unlikely(!new_bucket))
-			return -ENOMEM;
+		if (unlikely(!new_bucket)) {
+			ret = -ENOMEM;
+			goto go_out;
+		}
 		new_bucket->nr = trace_nr;
 		id_offs = (struct bpf_stack_build_id *)new_bucket->data;
 		for (i = 0; i < trace_nr; i++)
 			id_offs[i].ip = ips[i];
+
+		/*
+		 * It is safe after perf callchain ips copied to bucket buffer
+		 * to reduce the length of preempt section, we can enable preempt here.
+		 */
+		if (!trace_in)
+			preempt_enable();
+
 		stack_map_get_build_id_offset(id_offs, trace_nr, user, false /* !may_fault */);
 		trace_len = trace_nr * sizeof(struct bpf_stack_build_id);
 		if (hash_matches && bucket->nr == trace_nr &&
@@ -300,14 +327,19 @@ static long __bpf_get_stackid(struct bpf_map *map,
 	} else {
 		if (hash_matches && bucket->nr == trace_nr &&
 		    memcmp(bucket->data, ips, trace_len) == 0)
-			return id;
-		if (bucket && !(flags & BPF_F_REUSE_STACKID))
-			return -EEXIST;
+			goto go_out;
+
+		if (bucket && !(flags & BPF_F_REUSE_STACKID)) {
+			ret = -EEXIST;
+			goto go_out;
+		}
 
 		new_bucket = (struct stack_map_bucket *)
 			pcpu_freelist_pop(&smap->freelist);
-		if (unlikely(!new_bucket))
-			return -ENOMEM;
+		if (unlikely(!new_bucket)) {
+			ret = -ENOMEM;
+			goto go_out;
+		}
 		memcpy(new_bucket->data, ips, trace_len);
 	}
 
@@ -317,31 +349,21 @@ static long __bpf_get_stackid(struct bpf_map *map,
 	old_bucket = xchg(&smap->buckets[id], new_bucket);
 	if (old_bucket)
 		pcpu_freelist_push(&smap->freelist, &old_bucket->fnode);
-	return id;
+
+go_out:
+	if (!trace_in)
+		preempt_enable();
+	return ret;
 }
 
 BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	   u64, flags)
 {
-	u32 elem_size = stack_map_data_size(map);
-	bool user = flags & BPF_F_USER_STACK;
-	struct perf_callchain_entry *trace;
-	bool kernel = !user;
-	u32 max_depth;
-
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
 		return -EINVAL;
 
-	max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
-	trace = get_perf_callchain(regs, kernel, user, max_depth,
-				   false, false, 0);
-
-	if (unlikely(!trace))
-		/* couldn't fetch the stack trace */
-		return -EFAULT;
-
-	return __bpf_get_stackid(map, trace, flags);
+	return __bpf_get_stackid(map, regs, NULL, flags);
 }
 
 const struct bpf_func_proto bpf_get_stackid_proto = {
@@ -395,7 +417,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 
 	if (kernel) {
 		trace->nr = nr_kernel;
-		ret = __bpf_get_stackid(map, trace, flags);
+		ret = __bpf_get_stackid(map, NULL, trace, flags);
 	} else { /* user */
 		u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
 
@@ -404,7 +426,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 			return -EFAULT;
 
 		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
-		ret = __bpf_get_stackid(map, trace, flags);
+		ret = __bpf_get_stackid(map, NULL, trace, flags);
 	}
 
 	/* restore nr */
-- 
2.48.1

