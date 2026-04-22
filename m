Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC58830DD30
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871651; cv=none; b=q2RqW5EdS0ZJ0l9MEkmaHMPsmSLdeRzEG2dNCulPg25EiMGLNauakE/ewRANDpnPMh6K7VzVLEkUI4YgpzYc15x7P2Ax2KeKaPNOWmWvHw81CTUFvjHFsi4+1xIs7ks/86gBSDpA9UxjzG95kA/MIhnnLuAHXi/XIXPy13PWDXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871651; c=relaxed/simple;
	bh=HLOLBa8FjcJW6ueXaRbaS9Fk4mNzAb+iGzT2YTAmWjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iwfPmaWVHRRo7B8komW2882Ay/XVgUN/Z34jprQndt51lMU8fnEeoKeG5wsYPK2hd+5FYC4QoV3JXQoUHosYjm4W/TFyr63Rvk/XWenFfebjsTNPTDF+fjJbMHBlsOIAf3mtXtezxi2mtkAWbQGQjHG9KM/fe4GnSHr2BLi2dbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPmTM+NA; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPmTM+NA"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d7213b6ebso3703676f8f.3
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 08:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776871648; x=1777476448; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C8n2OIeQYdhTXJs70CrKSCz47ySqyE3tOnYzbwz9QOA=;
        b=GPmTM+NAqMJD8AggDm8DZn8jX2ODq+3QUjhfcRjaeMVIbZVOf3D+ONNR3SRqWyxVWo
         KikdxVsJS9roaYm+c6iVB8u6o9jeNhtQb0h3CVpAgOTtzOITbJpBmIMjcZbF8BZoQF5y
         GYcIbfjdK1YB2xwtNG8ehtjVLEKvVuEJnrEnW0jJd4TPtHM83UrH5RcRXdPscwNVem4x
         cmxtsfc+W8uU2An3VYSXjV4xpxBOBLLnhfxho2pdBzcNwQl+gODP5L1m7RwDeRxW5NPz
         nQS2FMms+LTObuhJ3GhHHX3YJTBrfd7gML1eQUrf0rokgM3qNDfAVctTz6QJxEXHMFsn
         D/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776871648; x=1777476448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C8n2OIeQYdhTXJs70CrKSCz47ySqyE3tOnYzbwz9QOA=;
        b=l+iSbvoQizT+vIn2nlzy6gCfVV8//MWs+9USJuOhBYlTAI2078+GqDYoJ/iwgBlind
         qK/8Ss7gwTKOOYN7fBlPzirvI8hcSO43oEkZ/I/6bjtpnq6dE3SWI0GRRe2Fd2CqtswH
         MY6Zc0qtrUFpL8i8SYDkWYhVrrT/VJPP0D78k0KNK+9n4XTybz5wb3UbHYPlXa93ICiV
         fb1m4V6rBPedLdBPaM6bekj1Kuye4es9V+BF3kINYPcjhInM/ERTzDhktyWXJXMJ/stD
         2BXt9Nqh0ONCFL3+f8w2i/YKkKUFLpEJD6QvL8Rrs6cuAsktdHQ+g0//5owEYTXsy4Td
         7lNw==
X-Gm-Message-State: AOJu0YwIRZ4J/mqRMNBLIVCBYgS0AcdgIHA6aSfen4zHpQKYBGJDYDr5
	unXZxW+1Gyv6edFruEwDS9KMIY+TOS0cFMdGmSfmM8/s8WZmS3m0GLmG
X-Gm-Gg: AeBDiesJlJG1ay39blqMeuxlQa+qi+9i59GXnSTx5mZmxx0pUppampt8S0yyR0/uYvV
	SKkdp3FX4W9MrC4+crV/t7xmbtlc0A3+DciOd316RxzSGnxDDjGbiVb4c3K4bfAYfuzz9iq/kgN
	NHYxES9XR13gU3ul+kqb6Hm7SI+IxYvzv/tgv72uMRxOypSAI3ZTQSo8zpYcrDY7nfvSIUK724Z
	XvGLBbTg6As35Fx4SQu7CxZdzn43cMZybeBUgKcZre2VRe+2a7ff543pllx3INxijmJ6WYOHKgp
	Yykxilml7KQLptAvnmsp+Sq+MaE2NbNaDLQrr1tIka8phPvzeQgXIQ9VwMzxi6hjnbth5tlQTEj
	NL1wysSz+XSwvKB9SEBT0sBuqBe/pPdLl6QIc9QCnDALBWEFxkT0bWJk1df/1yZGmqTan6gqJNg
	YFSuh/XmisF2Sf6mfJKvEC2xhU
X-Received: by 2002:a05:600c:8b38:b0:487:59c:2bb8 with SMTP id 5b1f17b1804b1-488fb7925dcmr317283975e9.27.1776871648048;
        Wed, 22 Apr 2026 08:27:28 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:40::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5aa3ae83sm100501945e9.12.2026.04.22.08.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 08:27:27 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 22 Apr 2026 08:27:08 -0700
Subject: [PATCH bpf-next v12 3/6] bpf: Add sleepable support for classic
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-sleepable_tracepoints-v12-3-744bf0e3b311@meta.com>
References: <20260422-sleepable_tracepoints-v12-0-744bf0e3b311@meta.com>
In-Reply-To: <20260422-sleepable_tracepoints-v12-0-744bf0e3b311@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776871642; l=12558;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=7Ef41tyAq5LBRGRK6fScTcVgF1YSl5ZD83K/k3MLJs4=;
 b=F11cVvdC/bdexBlL0T1rVVM7cmR03c1psm73B/wqQaURs5fyfKzCWpl6QzzpzZQtmxUxOdX5Z
 zyKB0uosV7xD2YooZ36LBp/7BoJDzPF28HI6d4bp5biQTsId98pfBil
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
index 6d1f8bad7e1c..0f9cacfa7cb8 100644
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
index 7276c72c1d31..a822c589c9bd 100644
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
+ * Per-program recursion protection is provided by
+ * bpf_prog_run_array_sleepable(). Global bpf_prog_active is not
+ * needed because syscall tracepoints cannot self-recurse.
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

