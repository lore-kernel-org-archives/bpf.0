Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B4339526B
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264593; cv=none; b=fzdpS0tMCWY0h4lb0TZHvmZ1viauLoq1+xjm2rESqI7Eg5XpRbGacIxk1Qw6j2wthOXbQVA871eEbT9TjO1YMCdgputBMtYFrp4wabj5qOonDEFCUR6zfWDiHCbgrpm+XxhdMi75SUiFH+c34lKpLaB7ZS1OaBIbNzXx6z9eJus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264593; c=relaxed/simple;
	bh=mw/dL7qmBHmKvsz8E4GVsnVQW7zApeVE1UT0415hU5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qs1su/40O3xLATTwjG4VmGb9iczmsGeU8Dd2riYg3dlHDbAWtVDU8zzPg9M5Ris8GRncjqptLoLQJzu5yWO4TWCoiELz7xOCKkxm/uBJbnEjHef+AugqOnr8uJMWWTpKoe1IHyqY59Lk5BYPM7N62xnvjKQ1ppJjZC3aCdHDH7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pm3Fg+77; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pm3Fg+77"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so91816555e9.2
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 07:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776264589; x=1776869389; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=554x11FZnexyWKCsO7ngq0vuEZN39gEgHqpNaj9OB94=;
        b=pm3Fg+77rL+Tgp4KlnaoR20cY/ayWPORNbf/ZsW/f9fh7/b8bMZeu9wDecjo5gL14N
         f67F00XhRl+jRfMLLdEcaE8UMLlcAte0/KD66qdIE6tM4+P3XUbzbJbIygmdGVkDgicU
         2c4te42vG8ThD/OZP8gGNuUAYftD4U4sSHc/vgnRd0vcVSHYCXOuRyhYrMEZDZwXsS4n
         D49gH10lj8hq0CVM7f8LaxzT0bJ4Q8D6zW0jWWf3cEwYGNz6T4sO4n8RHfOfoNPkeGt8
         rstTF6S72W8QC82bXgEQijuG3ktEonWH720aIpuHg8Lt/UfhMtX4V/k1nG6LFMLmBcxT
         6zEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776264589; x=1776869389;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=554x11FZnexyWKCsO7ngq0vuEZN39gEgHqpNaj9OB94=;
        b=Si2aWzmGFx6BQ4anA2imDxIsmAS+eaqiRBiWCkj0KMcKsEQPwZVRrc587mSYddFpcQ
         6B3GZopqiD5TBBGxyWL4A2Dho39aLVcvWtDq5G3zl2+UaF2cbq1jwVgeEl2aSTi9ixT0
         KIzvudJzjEWdZJ/YuoZXnG4KhFL4zRZDgnkrNCYLh9h9yKAPHLhcFOZYlKA8OgM/Dw6e
         iVp70RRAtEq/HMN+ASpu04h2NJEQSq+ROaM3SUlBvynsHVn2NYIFUlB0JoxDNGgXYJmY
         NL/rZdwshionlmtGqXE2QwcJKWXdVyvloKf6Dm0jsHlDkNaxkVDPBTtM234yPxJsKfh/
         w+tg==
X-Gm-Message-State: AOJu0YzPBci1Tn0Fnc3HVDKS50j4db+VHhsd8sTNHEjBBmKHXEgAL4nF
	6TEg/GRk1lfYIHvNDk03VHo44Rafood5C1oNB3Ct7iIqKMmImpYqSLTb
X-Gm-Gg: AeBDies9Y/I7djQHY67ujSq/xdu8epj8K3QvNcSHuGlvlIhvBp3yXcoshaMvILVmNVb
	gK9tAOyVgPzTSm5QTWdZj8eY6UJtFeg7PxxN72g8v4FGU7qQr9K0OjaOKLffzPc7sCC1IgbNebL
	Pd8Xb61BldhIZA6dMzOXAy78lznKCuFfGmTLMmG0LEYdIFC8x2Lxg37bdgalhB5a5M0GhEYPELE
	tZIC3T9//3UHq9DPMgRxwuEko/vuo/Oy9+p9v/hZo4lVI5BEl+c2uQjyOC1dkny7C1JaOuRB1S1
	hWyktsw42XghOP4ADkigTBqjkRxu9GZTdjez8NJ0T4XnbBLGC/qIxPvxB/LqMjVPIFiJuN5zcs3
	4rYKrty4w3Zf9/YlzPQP5YyT72oRgmdWmo1NRsdfn34Rz22Vh05kPEOxVa6YCGKWQtCjPHJuK99
	9dLs6de3U/wcPWpQ==
X-Received: by 2002:a05:600c:528f:b0:488:a82f:bbb4 with SMTP id 5b1f17b1804b1-488d689d0b8mr296351125e9.26.1776264589330;
        Wed, 15 Apr 2026 07:49:49 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f092cffbsm42740015e9.1.2026.04.15.07.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:49:48 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 15 Apr 2026 07:49:05 -0700
Subject: [PATCH bpf-next v10 3/6] bpf: Add sleepable support for classic
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-sleepable_tracepoints-v10-3-161f40b33dd7@meta.com>
References: <20260415-sleepable_tracepoints-v10-0-161f40b33dd7@meta.com>
In-Reply-To: <20260415-sleepable_tracepoints-v10-0-161f40b33dd7@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776264581; l=12602;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=B6cjI0bv6e+ft99WxJFgQD6eRinSwNCjDWBLWRfVlgg=;
 b=AwlNS3Ro+VFQjPQDDlOiqHl+H7FiA6e/V7DcwiIdzCVRbPudO0khEDP0wRJ1vmzx6vnlTE7OJ
 pkTvbG61N+rCWreMo7Y0nuuM2fAB9gUKOJJODyTy2SqCGZCmlZVLUo6
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add trace_call_bpf_faultable(), a variant of trace_call_bpf() for
faultable tracepoints that supports sleepable BPF programs. It uses
rcu_tasks_trace for lifetime protection and
bpf_prog_run_array_sleepable() for per-program RCU flavor selection,
following the uprobe_prog_run() pattern.

Restructure perf_syscall_enter() and perf_syscall_exit() to run BPF
programs before perf event processing. Previously, BPF ran after the
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
 include/linux/trace_events.h  |   6 +++
 kernel/events/core.c          |   9 ++++
 kernel/trace/bpf_trace.c      |  28 +++++++++++
 kernel/trace/trace_syscalls.c | 110 ++++++++++++++++++++++--------------------
 4 files changed, 101 insertions(+), 52 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 40a43a4c7caf..d49338c44014 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -770,6 +770,7 @@ trace_trigger_soft_disabled(struct trace_event_file *file)
 
 #ifdef CONFIG_BPF_EVENTS
 unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx);
+unsigned int trace_call_bpf_faultable(struct trace_event_call *call, void *ctx);
 int perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 bpf_cookie);
 void perf_event_detach_bpf_prog(struct perf_event *event);
 int perf_event_query_prog_array(struct perf_event *event, void __user *info);
@@ -792,6 +793,11 @@ static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *c
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
index 9e66fbee37f0..e1cfe343c76f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11643,6 +11643,15 @@ static int __perf_event_set_bpf_prog(struct perf_event *event,
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
index 4e763dd2aa2b..487e56c04606 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -152,6 +152,34 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
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
+	return bpf_prog_run_array_sleepable(prog_array, ctx, bpf_prog_run);
+}
+
 #ifdef CONFIG_BPF_KPROBE_OVERRIDE
 BPF_CALL_2(bpf_override_return, struct pt_regs *, regs, unsigned long, rc)
 {
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 8ad72e17d8eb..e98ee7e1e66f 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -1371,33 +1371,33 @@ static DECLARE_BITMAP(enabled_perf_exit_syscalls, NR_syscalls);
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
@@ -1410,12 +1410,7 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
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
@@ -1429,6 +1424,26 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 
 	syscall_get_arguments(current, regs, args);
 
+	/*
+	 * Run BPF program in faultable context before per-cpu buffer
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
 
@@ -1438,17 +1453,12 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
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
 
@@ -1458,13 +1468,6 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
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
@@ -1514,40 +1517,35 @@ static void perf_sysenter_disable(struct trace_event_call *call)
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
@@ -1559,29 +1557,37 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
 	if (!sys_data)
 		return;
 
-	head = this_cpu_ptr(sys_data->exit_event->perf_events);
+	/*
+	 * Run BPF program in faultable context before per-cpu buffer
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

