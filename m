Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1903B71B1
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537717; cv=none; b=XZjRasKK28yYNRyLiGdOLO1QPhfOI4ToMLUvPau9fLQtygYdtk+lkz1Q1klEvl8Sx1/a2lziQINEJoWJ4V7Xx4r8M7pXhCa36KGLfCibVduOWrmUBayEtIIjWLFj3FNn6ZYIeXUGu1zrPK3+QxX7FYwSLpzhlLX21qL13ou2Hvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537717; c=relaxed/simple;
	bh=nq7rGnKX3a+oyE6ow8MKzs9oA8ssmCOoIOPI/7UJbQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6QI+L1iLoHBwMjoCCPosyk0lv09Q82NcVR79HO8LxE9i+cu7HHy0HOhTkzHTk1ZGAEI3kd8EMLxN5w+RWh3kUilNXtldzKgYVehyX1tP5ODSToLCvK6XXT5WQGxbjSteYmzp71ifZg3RTn5y6NkZorLif8vh2pr5RrJUlUw6Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGbwb6rb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGbwb6rb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D93A1F000E9;
	Mon, 20 Jul 2026 08:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784537716;
	bh=PN9kaf2Y/C+NT/RgCMBnfUxiG8getPm55G2Y8Yp4XG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DGbwb6rbwhlYr/A4VufetjcmR5H7litrsRaKyEdGPbC/noF6Ju/daUgTTpPfjIfJ+
	 k0yv1rYgZ4QkWcy1eudUE0manOedkyZHLGl/sezBvWstut1cymGqshjlxCwNCf4WAK
	 lRVFheY88RXrjfijrSF2O2x2FnTK/hZiPUJMWmRaMHZrp+OFhfCIKSflobEKSMlXcB
	 MJBgU45N19Wn+tIgD1asjTZRwODDrgIkbbPjTB/08niA1IdzUusyybb6rHoP9aUWuZ
	 jyIA7mmliHwLKvkF5CLXsmlVvGdaiCGY30R8o1eYnLuqRjPhzdBsYFQzgoh7Novnuu
	 /CsOTGG++/t3A==
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
Subject: [PATCH bpf-next 8/9] bpf: Remove trace_in argument from __bpf_get_stack
Date: Mon, 20 Jul 2026 10:53:50 +0200
Message-ID: <20260720085351.655075-9-jolsa@kernel.org>
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

Now with the new callchain_* helper functions we can process trace_in
case directly in bpf_get_stack_pe function and remove it from
__bpf_get_stack which makes things easier for preemption fix in
following change.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 50 +++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index eea7b781300c..57cd4c33403b 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -784,7 +784,6 @@ static long callchain_finalize(void *buf, u32 size, u32 trace_nr, u32 elem_size,
 }
 
 static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
-			    struct perf_callchain_entry *trace_in,
 			    void *buf, u32 size, u64 flags, bool may_fault)
 {
 	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
@@ -823,10 +822,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	if (may_fault)
 		rcu_read_lock(); /* need RCU for perf's callchain below */
 
-	if (trace_in) {
-		trace = trace_in;
-		trace->nr = min_t(u32, trace->nr, max_depth);
-	} else if (kernel && task) {
+	if (kernel && task) {
 		trace = get_callchain_entry_for_task(task, max_depth);
 	} else {
 		trace = get_perf_callchain(regs, kernel, user, max_depth,
@@ -857,7 +853,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 BPF_CALL_4(bpf_get_stack, struct pt_regs *, regs, void *, buf, u32, size,
 	   u64, flags)
 {
-	return __bpf_get_stack(regs, NULL, NULL, buf, size, flags, false /* !may_fault */);
+	return __bpf_get_stack(regs, NULL, buf, size, flags, false /* !may_fault */);
 }
 
 const struct bpf_func_proto bpf_get_stack_proto = {
@@ -873,7 +869,7 @@ const struct bpf_func_proto bpf_get_stack_proto = {
 BPF_CALL_4(bpf_get_stack_sleepable, struct pt_regs *, regs, void *, buf, u32, size,
 	   u64, flags)
 {
-	return __bpf_get_stack(regs, NULL, NULL, buf, size, flags, true /* may_fault */);
+	return __bpf_get_stack(regs, NULL, buf, size, flags, true /* may_fault */);
 }
 
 const struct bpf_func_proto bpf_get_stack_sleepable_proto = {
@@ -897,7 +893,7 @@ static long __bpf_get_task_stack(struct task_struct *task, void *buf, u32 size,
 
 	regs = task_pt_regs(task);
 	if (regs)
-		res = __bpf_get_stack(regs, task, NULL, buf, size, flags, may_fault);
+		res = __bpf_get_stack(regs, task, buf, size, flags, may_fault);
 	put_task_stack(task);
 
 	return res;
@@ -937,6 +933,33 @@ const struct bpf_func_proto bpf_get_task_stack_sleepable_proto = {
 	.arg4_type	= ARG_ANYTHING,
 };
 
+static int __bpf_get_stack_pe(struct perf_callchain_entry *trace, void *buf, u32 size,
+			      u64 flags)
+{
+	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
+	u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
+	bool user = flags & BPF_F_USER_STACK;
+	u32 elem_size, max_depth, nr_trace;
+	bool kernel = !user;
+
+	if (kernel && user_build_id)
+		return -EINVAL;
+
+	elem_size = user_build_id ? sizeof(struct bpf_stack_build_id) : sizeof(u64);
+	if (unlikely(size % elem_size))
+		return -EINVAL;
+
+	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
+	trace->nr = min_t(u32, trace->nr, max_depth);
+
+	if (trace->nr < skip)
+		return -EFAULT;
+
+	nr_trace = callchain_store(trace, buf, size, elem_size, flags);
+	return callchain_finalize(buf, size, nr_trace, elem_size, user_build_id,
+				  user, false /* !may_fault */);
+}
+
 BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
 	   void *, buf, u32, size, u64, flags)
 {
@@ -948,7 +971,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
 	__u64 nr_kernel;
 
 	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
-		return __bpf_get_stack(regs, NULL, NULL, buf, size, flags, false /* !may_fault */);
+		return __bpf_get_stack(regs, NULL, buf, size, flags, false /* !may_fault */);
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_USER_BUILD_ID)))
@@ -968,7 +991,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
 		__u64 nr = trace->nr;
 
 		trace->nr = nr_kernel;
-		err = __bpf_get_stack(regs, NULL, trace, buf, size, flags, false /* !may_fault */);
+		err = __bpf_get_stack_pe(trace, buf, size, flags);
 
 		/* restore nr */
 		trace->nr = nr;
@@ -978,14 +1001,13 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
 		skip += nr_kernel;
 		if (skip > BPF_F_SKIP_FIELD_MASK)
 			goto clear;
-
 		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
-		err = __bpf_get_stack(regs, NULL, trace, buf, size, flags, false /* !may_fault */);
+		err = __bpf_get_stack_pe(trace, buf, size, flags);
 	}
-	return err;
 
 clear:
-	memset(buf, 0, size);
+	if (err < 0)
+		memset(buf, 0, size);
 	return err;
 
 }
-- 
2.54.0

