Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD243E1222
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 22:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909240; cv=none; b=XXOBdSyXvHl2hebZ3FK0HrotXZKXj+ZweBGiC8k0wA19jNvRshBbUH2+6J2B7CLgxP50eJDtF8Wz0+tFecSBKGNBKbpuIG8Lf3St6u7G/ZNbqWv3TsfUpNqhH1tv4RgBR+2Ze0voBPeI068a5HvNFxKug37K6CKyQvZ/JrojG+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909240; c=relaxed/simple;
	bh=mxzA716VX5iaiD1/OsitZC/XFQIsMv3Gdkvt5hhVbxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jmATcrssCYXDIOSVxDe83Xt/4dh/0ZTP/zbZ44XS/96qyyHuMB2yK/fsR5xyDZql2oAWOQO+CuUI0+rCFEWQ5IqZfNMvx6EIcMrLbPgr9K/FAt+0RxgGzH0O3askqK+Nl05SZE12Y3VgMARba05oHOk26ZDpOytxonvX7C4H5Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qAN13vEU; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAN13vEU"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d03db7f87so684375f8f.3
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 15:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774909229; x=1775514029; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6mRciPKBcydJPLLUKQj9+eUrXtp1fonopH6qUfX+CFU=;
        b=qAN13vEUNK74labjQDc5kiS4xO2wSNB9pkPcINZfPPO6FOatRa9xUTDZQ2JizVJ6mo
         /ZvV7COdswdjGwqMNgrA5XW0A84sHp4AeVBakpsPxnu777/EI0u0amEXz5i0EHe/Cu37
         vg+UZ7ZHYqGxkdWVgwsQyaCh9Cp24zNM218FXvozr+ZNjCWbRNfq6hZWYCSb/AEf/4iB
         oo3SnyKwv8MdnQa15DFCLCx8RlXZ/LLUAIlA+UjhJBNgxuOiq7gcXOBAgcQ/PzCsdN1V
         wJYXZQKG43PtMNnhUODsQ8LzR0NmizRsPJyyoQgkNGQqARM5s62/wN/AorwwmxHSvwrD
         HVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774909229; x=1775514029;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6mRciPKBcydJPLLUKQj9+eUrXtp1fonopH6qUfX+CFU=;
        b=kusIxgal8i+qwNtPZ2OMmURSHqaPjF9MjwW4+4Vt/dsYGMntDohiYTBsIOoFzEz/s2
         +Z1eFjIBBurgzlOnZq3HrotUHgJfkas5mp8BfttNipR4ybJBJBa1/nGm9e3EokSHaDRL
         XvpZ841ESCu4jbwTd5U6NrZHHWKae3GdXW41ngeSONRawwOxllQKE6ezi8k+smt9U6t6
         TQ4zNitWq76W1uzrPMdSOkoc5vEOzQLbeMlX/2NpHlJeBT4OGT7giqrGs2Rwe7oLfAjo
         0A3nIU97JO45zNJhBLa8cgCM93t+iIlYlbAjZuzRcoHl/QxJVlmLOYSg0pWlnSWeVrwN
         kvxw==
X-Gm-Message-State: AOJu0YxRpgcdsNW/I+xNfubC6ot+5DUfcoiPpvfh4SFEMPQsVFtrlgzL
	yPV6+gFziYsNImIipIkSD+0OpgG+kg6PM71c/4WM5+GyMw9sO1UnCRDn
X-Gm-Gg: ATEYQzxkYPebTo+zDxTKGuzOqsSOU2yrYweb5lvHvIFtIwdd/bSWpUFVKi3+rxlQmYl
	TUH4OleDZSg6AsQpKIbXJUAWA4kpJwhZ/IRPuQm8gZpjI6N54j8ideNO/7ibjm1Z0Q4SfH0XjD+
	5hlreTk2FdR0ikl1PfP8Vi1PVautdfZITa6BfJJqakjXPfuX4m4eRIRmyPRaJYsuJBzahxMSQOB
	Ekw37o1hOVVLpVwlk7VtaYGWRobA+6jChAH0YHTmyRak1FcFLW9MDQnml751j+XbFN/xJiz2nqK
	CBE8FgiKWl2gtQamo7M8NFBfyzBWs5C/Hj9Fz4DXNnpA63wnEXa7uOM70/tQKR5NmDfhb6592qY
	3FPd8T8XpEKYngnFfkLseqfTB49Yp+U+5Tzw9GjJ05M2o+CqU1KLqzVVlfMeaBwAkxnqyJGCp/u
	9TFhLVJb2SH9jH
X-Received: by 2002:a05:6000:112:b0:43c:fdd:ea96 with SMTP id ffacd0b85a97d-43c0fddeac7mr16614671f8f.26.1774909229142;
        Mon, 30 Mar 2026 15:20:29 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf245e4b9sm20094789f8f.20.2026.03.30.15.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:20:28 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 30 Mar 2026 15:17:26 -0700
Subject: [PATCH bpf-next v8 3/6] bpf: Add sleepable support for classic
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-sleepable_tracepoints-v8-3-2e323467f3a0@meta.com>
References: <20260330-sleepable_tracepoints-v8-0-2e323467f3a0@meta.com>
In-Reply-To: <20260330-sleepable_tracepoints-v8-0-2e323467f3a0@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774909220; l=14266;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=jMHcB/UMtBhlEh+nXOgFjDJjgKBvHzbZjh2Qmvdbw0U=;
 b=OwxoFCwjSYoR2emmj9CbItdBcY94lqjRiJhj0WrgN7C7zl9DTcJWJ7HsBeuq6BzVS2Jezrj8m
 fNu0GUZpBwBD2zNh6a1oXlid1xKmPZxS3X2YlAAGGVLylzFV0I1FClB
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add trace_call_bpf_faultable(), a variant of trace_call_bpf() for
faultable tracepoints that supports sleepable BPF programs. It uses
rcu_tasks_trace for lifetime protection and
bpf_prog_run_array_sleepable() for per-program RCU flavor selection,
following the uprobe_prog_run() pattern.

Add per-prog recursion check to bpf_prog_run_array_sleepable(),
skipped for uprobes via the is_uprobe flag, to allow sleepable
tracepoints to use private stack safely.

Restructure perf_syscall_enter() and perf_syscall_exit() to run BPF
filter before perf event processing. Previously, BPF ran after the
per-cpu perf trace buffer was allocated under preempt_disable,
requiring cleanup via perf_swevent_put_recursion_context() on filter.
Now BPF runs in faultable context before preempt_disable, reading
syscall arguments from local variables instead of the per-cpu trace
record, removing the dependency on buffer allocation. This allows
sleepable BPF programs to execute and avoids unnecessary buffer
allocation when BPF filters the event. The perf event submission
path (buffer allocation, fill, submit) remains under preempt_disable
as before. Since BPF no longer runs within the buffer allocation
context, the fake_regs output parameter to perf_trace_buf_alloc()
is no longer needed and is replaced with NULL.

Add an attach-time check in __perf_event_set_bpf_prog() to reject
sleepable BPF_PROG_TYPE_TRACEPOINT programs on non-syscall
tracepoints, since only syscall tracepoints run in faultable context.

This prepares the classic tracepoint runtime and attach paths for
sleepable programs. The verifier changes to allow loading sleepable
BPF_PROG_TYPE_TRACEPOINT programs are in a subsequent patch.

To: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com> # for BPF bits
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf.h           |  18 ++++++-
 include/linux/trace_events.h  |   6 +++
 kernel/events/core.c          |   9 ++++
 kernel/trace/bpf_trace.c      |  29 +++++++++++
 kernel/trace/trace_syscalls.c | 110 ++++++++++++++++++++++--------------------
 5 files changed, 119 insertions(+), 53 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9fe19ab21cfc..7547c830fcb8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2486,13 +2486,15 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
  * section and disable preemption for that program alone, so it can access
  * rcu-protected dynamically sized maps.
  */
+void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
+
 static __always_inline u32
 bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
 			     const void *ctx, bpf_prog_run_fn run_prog,
 			     bool is_uprobe)
 {
 	const struct bpf_prog_array_item *item;
-	const struct bpf_prog *prog;
+	struct bpf_prog *prog;
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_trace_run_ctx run_ctx;
 	u32 ret = 1;
@@ -2513,8 +2515,22 @@ bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
 		if (!prog->sleepable)
 			rcu_read_lock();
 
+		/* Per-prog recursion check to enable private stack. */
+		if (!is_uprobe &&
+		    unlikely(!bpf_prog_get_recursion_context(prog))) {
+			bpf_prog_inc_misses_counter(prog);
+			bpf_prog_put_recursion_context(prog);
+			if (!prog->sleepable)
+				rcu_read_unlock();
+			item++;
+			continue;
+		}
+
 		run_ctx.bpf_cookie = item->bpf_cookie;
 		ret &= run_prog(prog, ctx);
+
+		if (!is_uprobe)
+			bpf_prog_put_recursion_context(prog);
 		item++;
 
 		if (!prog->sleepable)
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 37eb2f0f3dd8..5fbbeb9ec4b9 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -767,6 +767,7 @@ trace_trigger_soft_disabled(struct trace_event_file *file)
 
 #ifdef CONFIG_BPF_EVENTS
 unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx);
+unsigned int trace_call_bpf_faultable(struct trace_event_call *call, void *ctx);
 int perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 bpf_cookie);
 void perf_event_detach_bpf_prog(struct perf_event *event);
 int perf_event_query_prog_array(struct perf_event *event, void __user *info);
@@ -789,6 +790,11 @@ static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *c
 	return 1;
 }
 
+static inline unsigned int trace_call_bpf_faultable(struct trace_event_call *call, void *ctx)
+{
+	return 1;
+}
+
 static inline int
 perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 bpf_cookie)
 {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 89b40e439717..054127525376 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11644,6 +11644,15 @@ static int __perf_event_set_bpf_prog(struct perf_event *event,
 		/* only uprobe programs are allowed to be sleepable */
 		return -EINVAL;
 
+	if (prog->type == BPF_PROG_TYPE_TRACEPOINT && prog->sleepable) {
+		/*
+		 * Sleepable tracepoint programs can only attach to faultable
+		 * tracepoints. Currently only syscall tracepoints are faultable.
+		 */
+		if (!is_syscall_tp)
+			return -EINVAL;
+	}
+
 	/* Kprobe override only works for kprobes, not uprobes. */
 	if (prog->kprobe_override && !is_kprobe)
 		return -EINVAL;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 8066249e4ba2..efe13995c38a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -152,6 +152,35 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 	return ret;
 }
 
+/**
+ * trace_call_bpf_faultable - invoke BPF program in faultable context
+ * @call: tracepoint event
+ * @ctx: opaque context pointer
+ *
+ * Variant of trace_call_bpf() for faultable tracepoints (syscall
+ * tracepoints). Supports sleepable BPF programs by using rcu_tasks_trace
+ * for lifetime protection and bpf_prog_run_array_sleepable() for per-program
+ * RCU flavor selection, following the uprobe pattern.
+ *
+ * Recursion protection is unnecessary here (hence not touching bpf_prog_active
+ * compared to trace_call_bpf()), because syscall tracepoints fire only at
+ * syscall entry/exit boundaries, self-recursion is impossible.
+ *
+ * Must be called from a faultable/preemptible context.
+ */
+unsigned int trace_call_bpf_faultable(struct trace_event_call *call, void *ctx)
+{
+	struct bpf_prog_array *prog_array;
+
+	might_fault();
+	guard(rcu_tasks_trace)();
+
+	prog_array = rcu_dereference_check(call->prog_array,
+					   rcu_read_lock_trace_held());
+	return bpf_prog_run_array_sleepable(prog_array, ctx, bpf_prog_run,
+					    false);
+}
+
 #ifdef CONFIG_BPF_KPROBE_OVERRIDE
 BPF_CALL_2(bpf_override_return, struct pt_regs *, regs, unsigned long, rc)
 {
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 37317b81fcda..fe46114c4b3b 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -1372,33 +1372,33 @@ static DECLARE_BITMAP(enabled_perf_exit_syscalls, NR_syscalls);
 static int sys_perf_refcount_enter;
 static int sys_perf_refcount_exit;
 
-static int perf_call_bpf_enter(struct trace_event_call *call, struct pt_regs *regs,
+static int perf_call_bpf_enter(struct trace_event_call *call,
 			       struct syscall_metadata *sys_data,
-			       struct syscall_trace_enter *rec)
+			       int syscall_nr, unsigned long *args)
 {
 	struct syscall_tp_t {
 		struct trace_entry ent;
 		int syscall_nr;
 		unsigned long args[SYSCALL_DEFINE_MAXARGS];
 	} __aligned(8) param;
+	struct pt_regs regs = {};
 	int i;
 
 	BUILD_BUG_ON(sizeof(param.ent) < sizeof(void *));
 
-	/* bpf prog requires 'regs' to be the first member in the ctx (a.k.a. &param) */
-	perf_fetch_caller_regs(regs);
-	*(struct pt_regs **)&param = regs;
-	param.syscall_nr = rec->nr;
+	/* bpf prog requires 'regs' to be the first member in the ctx */
+	perf_fetch_caller_regs(&regs);
+	*(struct pt_regs **)&param = &regs;
+	param.syscall_nr = syscall_nr;
 	for (i = 0; i < sys_data->nb_args; i++)
-		param.args[i] = rec->args[i];
-	return trace_call_bpf(call, &param);
+		param.args[i] = args[i];
+	return trace_call_bpf_faultable(call, &param);
 }
 
 static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 {
 	struct syscall_metadata *sys_data;
 	struct syscall_trace_enter *rec;
-	struct pt_regs *fake_regs;
 	struct hlist_head *head;
 	unsigned long args[6];
 	bool valid_prog_array;
@@ -1411,12 +1411,7 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	int size = 0;
 	int uargs = 0;
 
-	/*
-	 * Syscall probe called with preemption enabled, but the ring
-	 * buffer and per-cpu data require preemption to be disabled.
-	 */
 	might_fault();
-	guard(preempt_notrace)();
 
 	syscall_nr = trace_get_syscall_nr(current, regs);
 	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
@@ -1430,6 +1425,26 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 
 	syscall_get_arguments(current, regs, args);
 
+	/*
+	 * Run BPF filter in faultable context before per-cpu buffer
+	 * allocation, allowing sleepable BPF programs to execute.
+	 */
+	valid_prog_array = bpf_prog_array_valid(sys_data->enter_event);
+	if (valid_prog_array &&
+	    !perf_call_bpf_enter(sys_data->enter_event, sys_data,
+				 syscall_nr, args))
+		return;
+
+	/*
+	 * Per-cpu ring buffer and perf event list operations require
+	 * preemption to be disabled.
+	 */
+	guard(preempt_notrace)();
+
+	head = this_cpu_ptr(sys_data->enter_event->perf_events);
+	if (hlist_empty(head))
+		return;
+
 	/* Check if this syscall event faults in user space memory */
 	mayfault = sys_data->user_mask != 0;
 
@@ -1439,17 +1454,12 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 			return;
 	}
 
-	head = this_cpu_ptr(sys_data->enter_event->perf_events);
-	valid_prog_array = bpf_prog_array_valid(sys_data->enter_event);
-	if (!valid_prog_array && hlist_empty(head))
-		return;
-
 	/* get the size after alignment with the u32 buffer size field */
 	size += sizeof(unsigned long) * sys_data->nb_args + sizeof(*rec);
 	size = ALIGN(size + sizeof(u32), sizeof(u64));
 	size -= sizeof(u32);
 
-	rec = perf_trace_buf_alloc(size, &fake_regs, &rctx);
+	rec = perf_trace_buf_alloc(size, NULL, &rctx);
 	if (!rec)
 		return;
 
@@ -1459,13 +1469,6 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	if (mayfault)
 		syscall_put_data(sys_data, rec, user_ptr, size, user_sizes, uargs);
 
-	if ((valid_prog_array &&
-	     !perf_call_bpf_enter(sys_data->enter_event, fake_regs, sys_data, rec)) ||
-	    hlist_empty(head)) {
-		perf_swevent_put_recursion_context(rctx);
-		return;
-	}
-
 	perf_trace_buf_submit(rec, size, rctx,
 			      sys_data->enter_event->event.type, 1, regs,
 			      head, NULL);
@@ -1515,40 +1518,35 @@ static void perf_sysenter_disable(struct trace_event_call *call)
 		syscall_fault_buffer_disable();
 }
 
-static int perf_call_bpf_exit(struct trace_event_call *call, struct pt_regs *regs,
-			      struct syscall_trace_exit *rec)
+static int perf_call_bpf_exit(struct trace_event_call *call,
+			      int syscall_nr, long ret_val)
 {
 	struct syscall_tp_t {
 		struct trace_entry ent;
 		int syscall_nr;
 		unsigned long ret;
 	} __aligned(8) param;
-
-	/* bpf prog requires 'regs' to be the first member in the ctx (a.k.a. &param) */
-	perf_fetch_caller_regs(regs);
-	*(struct pt_regs **)&param = regs;
-	param.syscall_nr = rec->nr;
-	param.ret = rec->ret;
-	return trace_call_bpf(call, &param);
+	struct pt_regs regs = {};
+
+	/* bpf prog requires 'regs' to be the first member in the ctx */
+	perf_fetch_caller_regs(&regs);
+	*(struct pt_regs **)&param = &regs;
+	param.syscall_nr = syscall_nr;
+	param.ret = ret_val;
+	return trace_call_bpf_faultable(call, &param);
 }
 
 static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
 {
 	struct syscall_metadata *sys_data;
 	struct syscall_trace_exit *rec;
-	struct pt_regs *fake_regs;
 	struct hlist_head *head;
 	bool valid_prog_array;
 	int syscall_nr;
 	int rctx;
 	int size;
 
-	/*
-	 * Syscall probe called with preemption enabled, but the ring
-	 * buffer and per-cpu data require preemption to be disabled.
-	 */
 	might_fault();
-	guard(preempt_notrace)();
 
 	syscall_nr = trace_get_syscall_nr(current, regs);
 	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
@@ -1560,29 +1558,37 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
 	if (!sys_data)
 		return;
 
-	head = this_cpu_ptr(sys_data->exit_event->perf_events);
+	/*
+	 * Run BPF filter in faultable context before per-cpu buffer
+	 * allocation, allowing sleepable BPF programs to execute.
+	 */
 	valid_prog_array = bpf_prog_array_valid(sys_data->exit_event);
-	if (!valid_prog_array && hlist_empty(head))
+	if (valid_prog_array &&
+	    !perf_call_bpf_exit(sys_data->exit_event, syscall_nr,
+				syscall_get_return_value(current, regs)))
+		return;
+
+	/*
+	 * Per-cpu ring buffer and perf event list operations require
+	 * preemption to be disabled.
+	 */
+	guard(preempt_notrace)();
+
+	head = this_cpu_ptr(sys_data->exit_event->perf_events);
+	if (hlist_empty(head))
 		return;
 
 	/* We can probably do that at build time */
 	size = ALIGN(sizeof(*rec) + sizeof(u32), sizeof(u64));
 	size -= sizeof(u32);
 
-	rec = perf_trace_buf_alloc(size, &fake_regs, &rctx);
+	rec = perf_trace_buf_alloc(size, NULL, &rctx);
 	if (!rec)
 		return;
 
 	rec->nr = syscall_nr;
 	rec->ret = syscall_get_return_value(current, regs);
 
-	if ((valid_prog_array &&
-	     !perf_call_bpf_exit(sys_data->exit_event, fake_regs, rec)) ||
-	    hlist_empty(head)) {
-		perf_swevent_put_recursion_context(rctx);
-		return;
-	}
-
 	perf_trace_buf_submit(rec, size, rctx, sys_data->exit_event->event.type,
 			      1, regs, head, NULL);
 }

-- 
2.52.0

