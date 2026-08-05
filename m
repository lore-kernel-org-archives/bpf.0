Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117AA3F8EC4
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922238; cv=none; b=JsHEZEs0S3a6lTxwzap1w0K3QQKgZ3Pin7i+YaaBwN4nfuduHlnDQ6ogUrzUxT8g/j1IHOcpwq7Fxk6bx7FLmpzWtMaXIiDSLItBAtCm3K2Uda3zeu6i+LSDXnmI190xvgqX2xoYn5MyMrVfL6cb19SzJ3rjOWf3u9/WPgNrVRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922238; c=relaxed/simple;
	bh=6SoPAMi74tHwOylZXDFJkP+SPCoSA1Nh0d0mRRLmOeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlRKZoDuumRWnAO3dusFx/uLWFvR/o8CvpB+zZ9uZJkpHYNqnbLZhm8tt4n5ZZTCvuglIILsJHpVmuF3UozQnt4BctYlH1QY2DaHwf1ndf8MYwLgA9MFQJKsoMm3hwMPphNs1RuqNvGKECml2JcIndujR8dX9ImdWwa0bvxBdGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRcmmgXU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRcmmgXU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CA41F00A3A;
	Wed,  5 Aug 2026 09:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785922236;
	bh=S/TvWclAqG8qfqNXnmYnnnU9w4jcD0qCH4GZO0uCnGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hRcmmgXUvjcGkbwkIWcpQSEGR/jB7sSds8jS3G92rrGxw8OYaXKZPqnIY+Si9Ag4d
	 8/91dTbB2cXiqa+8b1oEc8TJW9VyyvIxeRiaKfW4lGAoKjJHmeO9s1B9jf/+C7vsfp
	 3z6YLz90xzyE103ZR379QiUvCWxRH9z82SYXfcoXZZs1v8hTE75KZcGRm8oF3HqJlA
	 CO+PV956DSest8QrxDs1LGGy5hBzn6GvDWLdRu77NmJPYR2aL8U6LauHAPLFDKTsfU
	 1dqrCK7nFrRFE5umvWhQxTnWTFgFQZX03YGNYGlaHuJjyvob1gf9D/w8Qf3KzIfJy6
	 Ptx3NIoIJhVrA==
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
Subject: [PATCHv4 bpf-next 11/12] bpf: Avoid changing callchain in bpf_get_stack_pe
Date: Wed,  5 Aug 2026 11:28:42 +0200
Message-ID: <20260805092843.516315-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805092843.516315-1-jolsa@kernel.org>
References: <20260805092843.516315-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no need to modify the trace object bpf_get_stack_pe, we just
need to pass the needed callchain length in separate argument.

This way we can have callchain pointers const and remove the trace->nr
modification and restoration.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 789fe35b893a..531c043d1aaa 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -661,7 +661,7 @@ const struct bpf_func_proto bpf_get_stackid_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
-static __u64 count_kernel_ip(struct perf_callchain_entry *trace)
+static __u64 count_kernel_ip(const struct perf_callchain_entry *trace)
 {
 	__u64 nr_kernel = 0;
 
@@ -741,15 +741,15 @@ const struct bpf_func_proto bpf_get_stackid_proto_pe = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
-static u32 callchain_store(struct perf_callchain_entry *trace, void *buf,
-			   u32 elem_size, u64 flags)
+static u32 callchain_store(const struct perf_callchain_entry *trace, u32 trace_nr,
+			   void *buf, u32 elem_size, u64 flags)
 {
 	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
-	u32 trace_nr, copy_len;
-	u64 *ips;
+	const u64 *ips;
+	u32 copy_len;
 
-	trace_nr = trace->nr - skip;
+	trace_nr = trace_nr - skip;
 	copy_len = trace_nr * elem_size;
 
 	ips = trace->ip + skip;
@@ -833,7 +833,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		goto err_fault;
 	}
 
-	trace_nr = callchain_store(trace, buf, elem_size, flags);
+	trace_nr = callchain_store(trace, trace->nr, buf, elem_size, flags);
 
 	/* trace should not be dereferenced after this point */
 	if (may_fault)
@@ -935,13 +935,13 @@ const struct bpf_func_proto bpf_get_task_stack_sleepable_proto = {
 	.arg4_type	= ARG_ANYTHING,
 };
 
-static int __bpf_get_stack_pe(struct perf_callchain_entry *trace, void *buf, u32 size,
-			      u64 flags)
+static int __bpf_get_stack_pe(const struct perf_callchain_entry *trace, u32 trace_nr,
+			      void *buf, u32 size, u64 flags)
 {
 	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
 	u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
 	bool user = flags & BPF_F_USER_STACK;
-	u32 elem_size, max_depth, trace_nr;
+	u32 elem_size, max_depth;
 	bool kernel = !user;
 
 	if (kernel && user_build_id)
@@ -952,12 +952,12 @@ static int __bpf_get_stack_pe(struct perf_callchain_entry *trace, void *buf, u32
 		return -EINVAL;
 
 	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
-	trace->nr = min_t(u32, trace->nr, max_depth);
+	trace_nr = min_t(u32, trace_nr, max_depth);
 
-	if (trace->nr < skip)
+	if (trace_nr < skip)
 		return -EFAULT;
 
-	trace_nr = callchain_store(trace, buf, elem_size, flags);
+	trace_nr = callchain_store(trace, trace_nr, buf, elem_size, flags);
 	return callchain_finalize(buf, size, trace_nr, elem_size, flags, false /* !may_fault */);
 }
 
@@ -965,8 +965,8 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
 	   void *, buf, u32, size, u64, flags)
 {
 	struct pt_regs *regs = (struct pt_regs *)(ctx->regs);
+	const struct perf_callchain_entry *trace;
 	struct perf_event *event = ctx->event;
-	struct perf_callchain_entry *trace;
 	bool kernel, user;
 	int err = -EINVAL;
 	__u64 nr_kernel;
@@ -989,13 +989,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
 	nr_kernel = count_kernel_ip(trace);
 
 	if (kernel) {
-		__u64 nr = trace->nr;
-
-		trace->nr = nr_kernel;
-		err = __bpf_get_stack_pe(trace, buf, size, flags);
-
-		/* restore nr */
-		trace->nr = nr;
+		err = __bpf_get_stack_pe(trace, nr_kernel, buf, size, flags);
 	} else { /* user */
 		u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
 
@@ -1003,7 +997,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
 		if (skip > BPF_F_SKIP_FIELD_MASK)
 			goto clear;
 		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
-		err = __bpf_get_stack_pe(trace, buf, size, flags);
+		err = __bpf_get_stack_pe(trace, trace->nr, buf, size, flags);
 	}
 
 clear:
-- 
2.54.0

