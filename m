Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4423A1691
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790997; cv=none; b=ao7wGaUDDsLaOfsxZ8xXJFP4ilivXSE7feQ9nDTeASiscCTtrOuC8Zr5EbGUR4keonjsFEMZkTqwVWcvWOesqLHCJ3GjbXLWBUUEwQPb7zc5sE4pFaRqvK8LuE4d4wzw3LSm7YLMuR4oxroSDwNZM9cOOSQESbZD2wl3hrnD3Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790997; c=relaxed/simple;
	bh=qqO+wxbTQGNIUlvBjSEveluNbJDg7KQifvRMJzzi5CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3snIAOGXPDLa6IubeBtUxHb3xtxQrqm+LVsgOm+9lk0XKd3T1R/W8yGWBBaDLZO3qVIfUU67tYQbsR5UTwMClVZ2I7vNPkuGzgKNLvRh6Iw2WaRuqxAE/tFTQVscbTrVz/udKphw2WQAhVj+fYbUZhDOqUkGEW+5AAufkKi2ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=disZ0/Og; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="disZ0/Og"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2331F000E9;
	Mon,  3 Aug 2026 21:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785790996;
	bh=Kj0CVM9+My26Aq/yYQLJ7z9jHJf+b4EDZ6EnMghIUzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=disZ0/OgN7sh0FbLonz0rRctyUIhQ6bSq9yuwOuyJqHbVojLo5+/7TY4Xhsf/VAXK
	 7OA0lU6DVnfsLeHmJB9wI6igGer4WivjJ/DzCAxjx8cnH+EBLf9Xzqe0cR43qmx+3K
	 CVPhGCN3RuPv/SQrc07YSFPVzDt9JyTluN2ZufeJ1lhOPg1PpND8KO6m9nSYV2XxqN
	 xN8JVCTkNVUCbwUQeqToQZyTpsXcPY82LOEHqFATXRCUDcqUfrbiVAN/NQDSev3k16
	 5OSK9RMcJ9ChZipmo7T9QQ25fOvGFiWyKrnqsR2fwsoR0bBvyqWkzDXh0VRpH96/io
	 9xJTmv+LPv/ag==
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
Subject: [PATCHv3 bpf-next 08/12] bpf: Remove trace_in argument from __bpf_get_stack
Date: Mon,  3 Aug 2026 23:01:45 +0200
Message-ID: <20260803210149.296496-9-jolsa@kernel.org>
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

Now with the new callchain_* helper functions we can process trace_in
case directly in bpf_get_stack_pe function and remove it from
__bpf_get_stack which makes things easier for preemption fix in
following change.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 49 ++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index cdeb6c2e50da..976c4e4c1af6 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -780,7 +780,6 @@ static long callchain_finalize(void *buf, u32 size, u32 trace_nr, u32 elem_size,
 }
 
 static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
-			    struct perf_callchain_entry *trace_in,
 			    void *buf, u32 size, u64 flags, bool may_fault)
 {
 	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
@@ -819,10 +818,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
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
@@ -853,7 +849,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 BPF_CALL_4(bpf_get_stack, struct pt_regs *, regs, void *, buf, u32, size,
 	   u64, flags)
 {
-	return __bpf_get_stack(regs, NULL, NULL, buf, size, flags, false /* !may_fault */);
+	return __bpf_get_stack(regs, NULL, buf, size, flags, false /* !may_fault */);
 }
 
 const struct bpf_func_proto bpf_get_stack_proto = {
@@ -869,7 +865,7 @@ const struct bpf_func_proto bpf_get_stack_proto = {
 BPF_CALL_4(bpf_get_stack_sleepable, struct pt_regs *, regs, void *, buf, u32, size,
 	   u64, flags)
 {
-	return __bpf_get_stack(regs, NULL, NULL, buf, size, flags, true /* may_fault */);
+	return __bpf_get_stack(regs, NULL, buf, size, flags, true /* may_fault */);
 }
 
 const struct bpf_func_proto bpf_get_stack_sleepable_proto = {
@@ -893,7 +889,7 @@ static long __bpf_get_task_stack(struct task_struct *task, void *buf, u32 size,
 
 	regs = task_pt_regs(task);
 	if (regs)
-		res = __bpf_get_stack(regs, task, NULL, buf, size, flags, may_fault);
+		res = __bpf_get_stack(regs, task, buf, size, flags, may_fault);
 	put_task_stack(task);
 
 	return res;
@@ -933,6 +929,32 @@ const struct bpf_func_proto bpf_get_task_stack_sleepable_proto = {
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
+	nr_trace = callchain_store(trace, buf, elem_size, flags);
+	return callchain_finalize(buf, size, nr_trace, elem_size, flags, false /* !may_fault */);
+}
+
 BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
 	   void *, buf, u32, size, u64, flags)
 {
@@ -944,7 +966,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
 	__u64 nr_kernel;
 
 	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
-		return __bpf_get_stack(regs, NULL, NULL, buf, size, flags, false /* !may_fault */);
+		return __bpf_get_stack(regs, NULL, buf, size, flags, false /* !may_fault */);
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_USER_BUILD_ID)))
@@ -964,7 +986,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
 		__u64 nr = trace->nr;
 
 		trace->nr = nr_kernel;
-		err = __bpf_get_stack(regs, NULL, trace, buf, size, flags, false /* !may_fault */);
+		err = __bpf_get_stack_pe(trace, buf, size, flags);
 
 		/* restore nr */
 		trace->nr = nr;
@@ -974,14 +996,13 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
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

