Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7433F9298
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922208; cv=none; b=fyGT4EsK7YTh+ZqBZOKhC72VuacIMrNhxRlYJpum3pzg2AFDtnc1sk8RwaQVn4xUVbLO7GSql3Wkx1aMfm66NTIHjt8dUYxN/yhWoLGZqBHXtffIizhq+YWgPlERYP976yhBJjwD6IYQQoG+iuJ3NZrt26TOg4hxgKjEeB8ezJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922208; c=relaxed/simple;
	bh=G0U7RI8OBwqh1iXbrFhU5q1brq3jtZXil8fMI93IXwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuklnPApdJ2ICVci8QvztrkYWNHnPsEe0DNlcymHbUu0bsNJbIZnujzjcV6K/uVpkjYjTpn+XTi+ip78+u4e9oZGeBsREAxIGN/Rb9MJmkrCQ/EDmpsosaWfwRSUAuU/fYoEr7Dd8B3dsO4Bw42a6tauo/ApEDX1EKDQOitEaew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odsryUlV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odsryUlV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698D91F000E9;
	Wed,  5 Aug 2026 09:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785922207;
	bh=8zAwsqU+MTKaK/Aw+1jq741kFRMC1sh3wwMY/1sz+pY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=odsryUlV/8TUU0t8+WNTWKTNWOkgiG/Yx5bKxxfpoPS8+Fq9LmVUcWLI+VMd5to+P
	 10vUpczZ7cTNhb2Ym72/OJkCdswTtg6IS7oNa8MICVezUY/yKYdD4jDPbrqCZdeQw5
	 vMsGSHnNLBZSYVQBYMFoGcowdds6DoM1pmn5vIfhMrnbeSaSYvOgcmuVb5mTaJyQgQ
	 yz/yC0nl5YFHdRdSU6cNf5W1qR3QUvnWAyR+tvQvyH8JV90NtsbqRXcMptLfcwebRt
	 eKOsBHvFlshTN7ev+SH/WzieDBQ/ESnoowQ0pjmt0bgq2htuzKmh0/AgLH4TvZCw8k
	 UwIJd5HpyKzXA==
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
Subject: [PATCHv4 bpf-next 08/12] bpf: Remove trace_in argument from __bpf_get_stack
Date: Wed,  5 Aug 2026 11:28:39 +0200
Message-ID: <20260805092843.516315-9-jolsa@kernel.org>
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

Now with the new callchain_* helper functions we can process trace_in
case directly in bpf_get_stack_pe function and remove it from
__bpf_get_stack which makes things easier for preemption fix in
following change.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 50 ++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index cdeb6c2e50da..b0e38e5b3738 100644
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
+	u32 elem_size, max_depth, trace_nr;
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
+	trace_nr = callchain_store(trace, buf, elem_size, flags);
+	return callchain_finalize(buf, size, trace_nr, elem_size, flags, false /* !may_fault */);
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
@@ -974,16 +996,14 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
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
-
 }
 
 const struct bpf_func_proto bpf_get_stack_proto_pe = {
-- 
2.54.0

