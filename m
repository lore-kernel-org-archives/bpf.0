Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99EB2D8795
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785791041; cv=none; b=NxUfWMPlqx2gkDT7k0NEsITtWSi070osC8J6BFWSHkReEBgKmmDsOlRxp//xU+vAIRpr3dauGtM6SJm3ztQ9qzLYsM56AZ2S9P8RYu/jHH5j6Bo8OlfBKZFW4Dpeo+9f0oFgpcBruR9WhPowXbzW+uZlFcUqjoUcJ96SFe0lvoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785791041; c=relaxed/simple;
	bh=W2cGqnusXD2LFqDYrdLnj0cewoGr0NYqM2L+7sGk158=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olVif98TSv8hHy0UIIhEkzH/q6ltfWSElEeB3/gXSD62JZL1Fg8D2Ya0CcOUm4KspkO3toBXi66+nOQ5GeYZfJJArZocJxgySEe78qsGAl0VdUrMMF8+nUnW/lOsjI30u1Tez6dkJ6iIVr+xG2fpWF7Ei+2MfXHIN5z08D/mtQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpqCRGvs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpqCRGvs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC8A1F000E9;
	Mon,  3 Aug 2026 21:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785791039;
	bh=+SX8NxUbZeYfjH43erTRUuQb/35jvvrPydgzwfAAIdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GpqCRGvsJfOOSg0f+NSxU/pqTBvU++6BwvXjiD8rDtGWpw5iPfBjizLrzE4JUMNNr
	 q0XZadVxARxSI6pS8u+UBtShp+C4m5GldZkLCKuhTjs+E5Of5L8qYq5GXbveaVfFIP
	 W3O8LkQjdXhMg3RoKpSeqpXzSd5MnYuFoCY9eUgGbUxitYajo0GjCVIW3P9KCiogdw
	 hzrkEKWPUD2vL0hO0La7uR32Xc3mR0XizKENoa8C87KkSp6R0ZPQ6lcA/y+uNIFTO7
	 yv5kvieoEDGNyAQIROvEMrzez+ovxOBfyZyQXU13U7EjdLWbulEOl71TE1haybQR0U
	 /1nHyzXW5VGJQ==
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
Subject: [PATCHv3 bpf-next 12/12] bpf: Avoid changing callchain in bpf_get_stackid_pe
Date: Mon,  3 Aug 2026 23:01:49 +0200
Message-ID: <20260803210149.296496-13-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803210149.296496-1-jolsa@kernel.org>
References: <20260803210149.296496-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no need to modify the trace object bpf_get_stackid_pe, we just
need to pass the needed callchain length in separate argument.

This way we can have callchain pointers const and remove the trace->nr
modification and restoration.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 19858e1562ce..da72efc8b774 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -506,7 +506,7 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
 
 struct stackid {
 	struct stack_map_bucket *bucket;
-	u64 *ips;
+	const u64 *ips;
 	u32  nr;
 	u32  len;
 	u32  hash;
@@ -515,21 +515,21 @@ struct stackid {
 };
 
 static int stackid_init(struct stackid *stackid, struct bpf_map *map,
-			struct perf_callchain_entry *trace, u64 flags)
+			const struct perf_callchain_entry *trace, u32 trace_nr, u64 flags)
 {
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
 	u32 max_depth;
 
-	if (trace->nr <= skip)
+	if (trace_nr <= skip)
 		/* skipping more than usable stack trace */
 		return -EFAULT;
 
 	max_depth = stack_map_calculate_max_depth(map->value_size, stack_map_data_size(map), flags);
-	stackid->nr = min_t(u32, trace->nr - skip, max_depth - skip);
+	stackid->nr = min_t(u32, trace_nr - skip, max_depth - skip);
 	stackid->len = stackid->nr * sizeof(u64);
 	stackid->ips = trace->ip + skip;
-	stackid->hash = jhash2((u32 *)stackid->ips, stackid->len / sizeof(u32), 0);
+	stackid->hash = jhash2((const u32 *)stackid->ips, stackid->len / sizeof(u32), 0);
 	stackid->id = stackid->hash & (smap->n_buckets - 1);
 	stackid->bucket = READ_ONCE(smap->buckets[stackid->id]);
 	stackid->hash_matches = stackid->bucket && stackid->bucket->hash == stackid->hash;
@@ -537,11 +537,12 @@ static int stackid_init(struct stackid *stackid, struct bpf_map *map,
 }
 
 static int stackid_fastpath(struct stackid *stackid, struct bpf_map *map,
-			    struct perf_callchain_entry *trace, u64 flags)
+			    const struct perf_callchain_entry *trace, u32 trace_nr,
+			    u64 flags)
 {
 	int err;
 
-	err = stackid_init(stackid, map, trace, flags);
+	err = stackid_init(stackid, map, trace, trace_nr, flags);
 	if (err)
 		return err;
 
@@ -640,7 +641,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 			/* couldn't fetch the stack trace */
 			return -EFAULT;
 
-		err = stackid_fastpath(&stackid, map, trace, flags);
+		err = stackid_fastpath(&stackid, map, trace, trace->nr, flags);
 		if (err != -ENOENT)
 			return err;
 
@@ -676,12 +677,13 @@ static __u64 count_kernel_ip(const struct perf_callchain_entry *trace)
 BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 	   struct bpf_map *, map, u64, flags)
 {
+	const struct perf_callchain_entry *trace;
 	struct perf_event *event = ctx->event;
 	struct stack_map_bucket *new_bucket;
-	struct perf_callchain_entry *trace;
 	struct stackid stackid;
 	bool kernel, user;
 	__u64 nr_kernel;
+	u32 trace_nr;
 	int ret;
 
 	/* perf_sample_data doesn't have callchain, use bpf_get_stackid */
@@ -701,13 +703,13 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 		return -EFAULT;
 
 	nr_kernel = count_kernel_ip(trace);
-	__u64 nr = trace->nr; /* save original */
 
 	if (kernel) {
-		trace->nr = nr_kernel;
+		trace_nr = nr_kernel;
 	} else { /* user */
 		u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
 
+		trace_nr = trace->nr;
 		skip += nr_kernel;
 		if (skip > BPF_F_SKIP_FIELD_MASK)
 			return -EFAULT;
@@ -715,21 +717,14 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
 	}
 
-	ret = stackid_fastpath(&stackid, map, trace, flags);
+	ret = stackid_fastpath(&stackid, map, trace, trace_nr, flags);
 	if (ret != -ENOENT)
-		goto out;
+		return ret;
 
 	new_bucket = stackid_new_bucket(&stackid, map);
-	if (new_bucket) {
-		trace->nr = nr;
+	if (new_bucket)
 		return stackid_install(&stackid, map, new_bucket, flags);
-	}
-	ret = -ENOMEM;
-
-out:
-	/* restore nr */
-	trace->nr = nr;
-	return ret;
+	return -ENOMEM;
 }
 
 const struct bpf_func_proto bpf_get_stackid_proto_pe = {
-- 
2.54.0

