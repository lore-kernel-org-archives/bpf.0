Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A382BE7BE
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537678; cv=none; b=R8BHmZTeGHBBfIDlAgwsF6TUb19j8EUJpASO6vlnMFJ5mZ7wch9KfEkJfR7/bxWr4cIkLq7fER/WpQpOyXkGCRTikIdXMNhVpa/hWt/FsU8zEDqSMACmN2+IJJ5guuhVDagNeCzxJ8zkcZwa2TxQFgqZPIm9PWc2rgeWtSmuu94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537678; c=relaxed/simple;
	bh=XNlnREfHcYTheY4kcJ5CH8RUuNP7iSz9TBCabs/xRPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsuU8fh5sI+qzqi9bTg08R2ie/mBZr0WwXPjQV7BU45fa1y2KjBiUTNHFm171W7tbaOiRsxz4S+H2HDBrlPoFwLxokN/8CzESRrdeMiZbH78bmw/a1gCizYMBPmCoTVxX03rCHgj+ZK68L6rrtxbljojBrM4U4jkUjuT3VlLVr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCLYQwLw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCLYQwLw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD421F00A3A;
	Mon, 20 Jul 2026 08:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784537676;
	bh=luHXdK0ONN/kIETxNSUBhuj6n3kur92DmD1HIS4utoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lCLYQwLw7VW5Bo3bY3Zb4AqC+h77cu2nxW/r8bblBDTyVe+O3mKR5f4GElS4p7EY/
	 1hK4P8bq+Kq60wJxnK3r/QInX+dTbv5m3iqTOg4c6XhzbhjEqJ7GzIjL8TI6fbk/GR
	 cAnYr6xNs0BYN5+tBQ/L8g70AgRMsXetyuCTYOXolIDt+oaWIPHV4iPT4MgylaukpW
	 4Mr3XJDnN7y9nVaMNF1/F280W353AxbzN8SM0dolgW3u3Oxf8wl+V+7oFH+DFY2Q1q
	 GafQWZuNz9RYKe5aA+jcUZt5Mb1JtbE6NER+9SyH0WS6FHltclwKibBJMyE4wE10x9
	 aRAGIYlpT1V1Q==
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
Subject: [PATCH bpf-next 4/9] bpf: Use stack id functions instead of __bpf_get_stackid
Date: Mon, 20 Jul 2026 10:53:46 +0200
Message-ID: <20260720085351.655075-5-jolsa@kernel.org>
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

Replacing __bpf_get_stackid calls with sequence of following functions:

  stackid_fastpath
  stackid_new_bucket
  stackid_install

This makes code more structured and allows us to easily disable
preemption only in bpf_get_stackid in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 48a2e28f0c68..83efd5892d90 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -585,22 +585,13 @@ stackid_new_bucket(struct stackid *stackid, struct bpf_map *map,
 	return bucket;
 }
 
-static long __bpf_get_stackid(struct stackid *stackid, struct bpf_map *map,
-			      struct perf_callchain_entry *trace, u64 flags)
+static long stackid_install(struct stackid *stackid, struct bpf_map *map,
+			    struct stack_map_bucket *new_bucket, u64 flags)
 {
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
-	struct stack_map_bucket *new_bucket, *old_bucket;
 	bool user = flags & BPF_F_USER_STACK;
+	struct stack_map_bucket *old_bucket;
 	u32 trace_len;
-	int err;
-
-	err = stackid_fastpath(stackid, map, trace, flags);
-	if (err != -ENOENT)
-		return err;
-
-	new_bucket = stackid_new_bucket(stackid, map, trace, flags);
-	if (!new_bucket)
-		return -ENOMEM;
 
 	if (stack_map_use_build_id(map)) {
 		struct bpf_stack_build_id *id_offs;
@@ -630,10 +621,12 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 {
 	u32 elem_size = stack_map_data_size(map);
 	bool user = flags & BPF_F_USER_STACK;
+	struct stack_map_bucket *new_bucket;
 	struct perf_callchain_entry *trace;
 	struct stackid stackid;
 	bool kernel = !user;
 	u32 max_depth;
+	int err;
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
@@ -647,7 +640,15 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 		/* couldn't fetch the stack trace */
 		return -EFAULT;
 
-	return __bpf_get_stackid(&stackid, map, trace, flags);
+	err = stackid_fastpath(&stackid, map, trace, flags);
+	if (err != -ENOENT)
+		return err;
+
+	new_bucket = stackid_new_bucket(&stackid, map, trace, flags);
+	if (!new_bucket)
+		return -ENOMEM;
+
+	return stackid_install(&stackid, map, new_bucket, flags);
 }
 
 const struct bpf_func_proto bpf_get_stackid_proto = {
@@ -675,6 +676,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 	   struct bpf_map *, map, u64, flags)
 {
 	struct perf_event *event = ctx->event;
+	struct stack_map_bucket *new_bucket;
 	struct perf_callchain_entry *trace;
 	struct stackid stackid;
 	bool kernel, user;
@@ -702,7 +704,6 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 
 	if (kernel) {
 		trace->nr = nr_kernel;
-		ret = __bpf_get_stackid(&stackid, map, trace, flags);
 	} else { /* user */
 		u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
 
@@ -711,12 +712,22 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 			return -EFAULT;
 
 		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
-		ret = __bpf_get_stackid(&stackid, map, trace, flags);
 	}
 
+	ret = stackid_fastpath(&stackid, map, trace, flags);
+	if (ret != -ENOENT)
+		goto error;
+
+	new_bucket = stackid_new_bucket(&stackid, map, trace, flags);
+	if (new_bucket) {
+		trace->nr = nr;
+		return stackid_install(&stackid, map, new_bucket, flags);
+	}
+	ret = -ENOMEM;
+
+error:
 	/* restore nr */
 	trace->nr = nr;
-
 	return ret;
 }
 
-- 
2.54.0

