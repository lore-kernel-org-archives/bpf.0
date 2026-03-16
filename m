Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43F8366071
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 21:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773697614; cv=none; b=I3ZaIzKFCOS1XZ1WV6UsfbucgBHhqEjqCgJj6PIhwswTmBtoGNY3YVug3v5Gi2fP647debNGtKqJi3E3PoWpsFUK+fnzPpUFTDBG0vcJYPd6GxdEn2XIzBUGiqTrrfXDQqsbdq5Caw4PBQB/OF6ZWHRWhnQO6X1N6WEYzdqOSlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773697614; c=relaxed/simple;
	bh=rW3pX8ABXxUFvuBTbGpx7DuASUoi/90jTd0bhHCRgwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hZwJo1yRhzkZsvDkqPOmQkt8xt7FdYz6dSnuAOg852dnfNq+GYypXAAnJWsVcfvr4IhCSpKd1QhogONhWXspykeCab7cA53329Uhnl8hzr6zrbbUGIrTCjVu2gACfHnottP+9P6YYaYoxhf9JdDweZgA72P35GN9BxMUHtyeoYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4eaorRi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4eaorRi"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so34065465e9.3
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 14:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773697611; x=1774302411; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0TFmG+mQc6VesEsnrdBawPDckCAwynUlFgqq8JlGcog=;
        b=G4eaorRik82YNLny/0R6JKp7QBmXXvxgEees8xrHoTXrcUM1RGlOQ3G8TqADzIDhS2
         3F3weHeQqrbXnyO5JZXcISNlsQwlKU2yvJL3ev2aULHS9exadvE+b66R2+dvlAHpj1Kx
         EWyRuFL+3JzlNTfWkgur5XdJmg+yh5iJ3mrF+PeEgQBsyrESpnogobTTriuj/gUd7nSO
         XhD183XhbpOgD5ugi4zmUFkZU2cqg5Yu1iUWD0DSIYkfEaRynVGcUN157WSFNdj8Kuar
         KKN95zA2pkRhILj6jEsw2dfcaEcurS1TVMG5baDn92mCUt+KvyBAjxBzg7YDXtjoqDFF
         kF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773697611; x=1774302411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0TFmG+mQc6VesEsnrdBawPDckCAwynUlFgqq8JlGcog=;
        b=l87vnsIC4yelckEZ+GkvFUU9A3BhKONbHBkTayHub1ggUCSJtmIQXUih6q8UHposRH
         GbTt3+pFffUsccyvwndgYc2m3SH6OyJku7QqlpwNHcsZ7V4RvtP2EfAC6Z3AnViHXrCL
         No3ASGWkarHqx31cWyuTZopHorij97ep92hT+ecEi/D0uLJHtChd+UHACt7PjDmI2Jau
         19YpZMsXQnpLZ3c4eU1XHFQQTTtL40/1gH0WSeUVRJXntjdw6wCMV3u/y/eAVFcT3wle
         xRwCrE0sQ7DWXPAxojYKVGE6HbStxaDAbzoH58ohwJAog93htC+gPN38iwJVwmo5p6xn
         h7ag==
X-Gm-Message-State: AOJu0YxMec2VSNiv+dpigJ9MZ2OTVBG2lnkM92UgSQqNCVbT/3ZSuFYa
	2siAwQDi5r6YLP8bG8NuMn3bde2095nUNJzlcQ3DSJF5r+BiO5L7xwtV
X-Gm-Gg: ATEYQzzyzWpsTBQrqWdSfxaLXFrako0UbL13uk4KQUXRZ4Cs9HDgTUdUf8cwJZwJwuy
	QPmaL/3V+tkMCYrKWGI1tfMdm8PnVxtD6P6NXpQW+UKmCr0DgPBVD3o2+w71oaQZ/heicA10/DO
	u1PufiHZoECxxMRc8T2kcLlFHJdTAWD3HJnU4ltB8ZQgwqWJ0eLVdvD7zP4FCV6tmS3tUByPpoI
	nQLoDKf2bgnFGE4he2esK2lbF1znSygVEfR22BsGBV6UnlKXO9F9YMFP+ou7CP1yUL4seHJMknZ
	Lsa2IwGSlG3Jn9I4lAac13CtKBBUfcCkfGP0CE3yq5Ihq/+cE93RtKoH7hI1RcLvO67rSGpISKm
	7xoHw5UlWUDjix12Ogqrtg0ozYbXDlvzd9sIcdRBtkBakohE0HQQTGXCzIWOy+6rfZvi2gRl8dQ
	nUD9Ojqs9sy8CWbA==
X-Received: by 2002:a05:600c:8b46:b0:485:34b3:858a with SMTP id 5b1f17b1804b1-485566d2d66mr245186715e9.11.1773697610967;
        Mon, 16 Mar 2026 14:46:50 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm20028055e9.3.2026.03.16.14.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:46:50 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 16 Mar 2026 14:46:45 -0700
Subject: [PATCH bpf-next v5 2/5] bpf: Add sleepable support for classic
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-sleepable_tracepoints-v5-2-85525de71d25@meta.com>
References: <20260316-sleepable_tracepoints-v5-0-85525de71d25@meta.com>
In-Reply-To: <20260316-sleepable_tracepoints-v5-0-85525de71d25@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773697606; l=11953;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=rkWXhARkWVei0cbeBVmb91LAa5xHKo5cBtbriYNjKeg=;
 b=5wNhSWrT2n7pks/HOAtBNtPhtULcGLsWLI7dgQL6beiuBCSJheiOlUiT7vHDxKy0N0aWSkvF0
 pZ8ooDFduKQAA7qNquROZgLyNZGwwB9IWYn/a8JEBX3t/94sYIKxXbk
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add trace_call_bpf_faultable(), a variant of trace_call_bpf() for
faultable tracepoints that supports sleepable BPF programs. It uses
rcu_tasks_trace for lifetime protection and bpf_prog_run_array_uprobe()
for per-program RCU flavor selection, following the uprobe_prog_run()
pattern. Uses preempt-safe this_cpu_inc_return/this_cpu_dec for the
bpf_prog_active recursion counter since preemption is enabled in this
context.

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
as before.

Add an attach-time check in __perf_event_set_bpf_prog() to reject
sleepable BPF_PROG_TYPE_TRACEPOINT programs on non-syscall
tracepoints, since only syscall tracepoints run in faultable context.

This prepares the classic tracepoint runtime and attach paths for
sleepable programs. The verifier changes to allow loading sleepable
BPF_PROG_TYPE_TRACEPOINT programs are in a subsequent patch.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/trace_events.h  |   6 +++
 kernel/events/core.c          |   9 ++++
 kernel/trace/bpf_trace.c      |  39 ++++++++++++++++
 kernel/trace/trace_syscalls.c | 104 +++++++++++++++++++++++-------------------
 4 files changed, 110 insertions(+), 48 deletions(-)

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
index 1f5699b339ec..46b733d3dd41 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11647,6 +11647,15 @@ static int __perf_event_set_bpf_prog(struct perf_event *event,
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
index 35ed53807cfd..69c9a5539e65 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -152,6 +152,45 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 	return ret;
 }
 
+/**
+ * trace_call_bpf_faultable - invoke BPF program in faultable context
+ * @call: tracepoint event
+ * @ctx: opaque context pointer
+ *
+ * Variant of trace_call_bpf() for faultable tracepoints (e.g. syscall
+ * tracepoints). Supports sleepable BPF programs by using rcu_tasks_trace
+ * for lifetime protection and per-program rcu_read_lock for non-sleepable
+ * programs, following the uprobe_prog_run() pattern.
+ *
+ * Must be called from a faultable/preemptible context.
+ */
+unsigned int trace_call_bpf_faultable(struct trace_event_call *call, void *ctx)
+{
+	struct bpf_prog_array *prog_array;
+	unsigned int ret;
+
+	might_fault();
+
+	guard(rcu_tasks_trace)();
+	guard(migrate)();
+
+	if (unlikely(this_cpu_inc_return(bpf_prog_active) != 1)) {
+		scoped_guard(rcu) {
+			bpf_prog_inc_misses_counters(rcu_dereference(call->prog_array));
+		}
+		this_cpu_dec(bpf_prog_active);
+		return 0;
+	}
+
+	prog_array = rcu_dereference_check(call->prog_array,
+					   rcu_read_lock_trace_held());
+	ret = bpf_prog_run_array_uprobe(prog_array, ctx, bpf_prog_run);
+
+	this_cpu_dec(bpf_prog_active);
+
+	return ret;
+}
+
 #ifdef CONFIG_BPF_KPROBE_OVERRIDE
 BPF_CALL_2(bpf_override_return, struct pt_regs *, regs, unsigned long, rc)
 {
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 37317b81fcda..8a7677c15f93 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -1372,26 +1372,27 @@ static DECLARE_BITMAP(enabled_perf_exit_syscalls, NR_syscalls);
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
@@ -1411,12 +1412,7 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
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
@@ -1430,6 +1426,26 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 
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
 
@@ -1439,11 +1455,6 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
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
@@ -1459,13 +1470,6 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
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
@@ -1515,21 +1519,22 @@ static void perf_sysenter_disable(struct trace_event_call *call)
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
@@ -1543,12 +1548,7 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
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
@@ -1560,9 +1560,24 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
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
@@ -1576,13 +1591,6 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
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

