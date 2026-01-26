Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B69230DD34;
	Mon, 26 Jan 2026 23:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769469173; cv=none; b=uzQNaungSJ3JrwLOKA5KtuKM8H4JLOdULZhiWrXrqqjDkKfiImTrRg/VZTflnZ1L548I5O7zmS7ZB+H1U2lkjMK0+jJvn74WdqejGrj3myYsf6mtD0J/ldo4GFEs5eOtOlK1FibEaNQ9hPK1yGpywiVFu/4Hcc0mC6+A4Po+dKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769469173; c=relaxed/simple;
	bh=TRlEcpWkzD9Pl1RTO8PDInWuAWdUdhbBwrEj7z437Wk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=vAOSS3ixRn9C3EbwVAtl5SHlNcxI2zWpsdpFfnVlFDe3AzrvU3NAPUBQecs0phoWT7wU/P3ogChmi20G5+y9cNGp1S0F5dDoL5xPkrAxtgmlDnJFqduyDPV+aS57Kzc12te/4Emq2YyrrLpvE1/PoG2oluZytGORDopS9XR4nvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0QHj6TV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0QHj6TV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02AFC2BCB1;
	Mon, 26 Jan 2026 23:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769469173;
	bh=TRlEcpWkzD9Pl1RTO8PDInWuAWdUdhbBwrEj7z437Wk=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Q0QHj6TVKF99it5UcksXXz9k8z9BB9G/eeltc2ghhMiXnaXV38Efku+LcOJe0SF6P
	 XdPlN+l+BHdvLfFNd4w1yX5u3YI+6ftc6iuvu8wyC8J0l4kZc4VJLGxOgw3p6212IF
	 iFcnfh5Dn2zHvrGL+hVE8r1KZd3L3INrrVyvPNbiat6uYtOhIr15N5mnR8O4biOgd+
	 p70IT+pxGqHOdzs4rjPzad/NvW/wrL5FZ0gjUj5ktYHhS3AUL5GmuGFRbOSsmQB1+r
	 CCCItUogxtjDvbdgId94Q/GciySIW01v/dV1YbnBrJJ3PmbaUVbTSD99BkCZ3g14mB
	 gXCLrI7APQRsQ==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vkVlQ-00000000C1G-2gYn;
	Mon, 26 Jan 2026 18:12:56 -0500
Message-ID: <20260126231256.499701982@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 26 Jan 2026 18:11:48 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v6 3/3] tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with
 SRCU-fast
References: <20260126231145.728172709@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The current use of guard(preempt_notrace)() within __DECLARE_TRACE()
to protect invocation of __DO_TRACE_CALL() means that BPF programs
attached to tracepoints are non-preemptible.  This is unhelpful in
real-time systems, whose users apparently wish to use BPF while also
achieving low latencies.  (Who knew?)

One option would be to use preemptible RCU, but this introduces
many opportunities for infinite recursion, which many consider to
be counterproductive, especially given the relatively small stacks
provided by the Linux kernel.  These opportunities could be shut down
by sufficiently energetic duplication of code, but this sort of thing
is considered impolite in some circles.

Therefore, use the shiny new SRCU-fast API, which provides somewhat faster
readers than those of preemptible RCU, at least on Paul E. McKenney's
laptop, where task_struct access is more expensive than access to per-CPU
variables.  And SRCU-fast provides way faster readers than does SRCU,
courtesy of being able to avoid the read-side use of smp_mb().  Also,
it is quite straightforward to create srcu_read_{,un}lock_fast_notrace()
functions.

Link: https://lore.kernel.org/all/20250613152218.1924093-1-bigeasy@linutronix.de/

Co-developed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v5: https://patch.msgid.link/20260108220550.2f6638f3@fedora

- Just change from preempt_disable() to srcu_fast() always
  Do not do anything different for PREEMPT_RT.
  Now that BPF disables migration directly, do not have tracepoints
  disable migration in its code.

 include/linux/tracepoint.h   |  9 +++++----
 include/trace/trace_events.h |  4 ++--
 kernel/tracepoint.c          | 18 ++++++++++++++----
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 8a56f3278b1b..22ca1c8b54f3 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -108,14 +108,15 @@ void for_each_tracepoint_in_module(struct module *mod,
  * An alternative is to use the following for batch reclaim associated
  * with a given tracepoint:
  *
- * - tracepoint_is_faultable() == false: call_rcu()
+ * - tracepoint_is_faultable() == false: call_srcu()
  * - tracepoint_is_faultable() == true:  call_rcu_tasks_trace()
  */
 #ifdef CONFIG_TRACEPOINTS
+extern struct srcu_struct tracepoint_srcu;
 static inline void tracepoint_synchronize_unregister(void)
 {
 	synchronize_rcu_tasks_trace();
-	synchronize_rcu();
+	synchronize_srcu(&tracepoint_srcu);
 }
 static inline bool tracepoint_is_faultable(struct tracepoint *tp)
 {
@@ -275,13 +276,13 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		return static_branch_unlikely(&__tracepoint_##name.key);\
 	}
 
-#define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
+#define __DECLARE_TRACE(name, proto, args, cond, data_proto)			\
 	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto)) \
 	static inline void __do_trace_##name(proto)			\
 	{								\
 		TRACEPOINT_CHECK(name)					\
 		if (cond) {						\
-			guard(preempt_notrace)();			\
+			guard(srcu_fast_notrace)(&tracepoint_srcu);	\
 			__DO_TRACE_CALL(name, TP_ARGS(args));		\
 		}							\
 	}								\
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 4f22136fd465..fbc07d353be6 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -436,6 +436,7 @@ __DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
 static notrace void							\
 trace_event_raw_event_##call(void *__data, proto)			\
 {									\
+	guard(preempt_notrace)();					\
 	do_trace_event_raw_event_##call(__data, args);			\
 }
 
@@ -447,9 +448,8 @@ static notrace void							\
 trace_event_raw_event_##call(void *__data, proto)			\
 {									\
 	might_fault();							\
-	preempt_disable_notrace();					\
+	guard(preempt_notrace)();					\
 	do_trace_event_raw_event_##call(__data, args);			\
-	preempt_enable_notrace();					\
 }
 
 /*
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 62719d2941c9..fd2ee879815c 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -34,9 +34,13 @@ enum tp_transition_sync {
 
 struct tp_transition_snapshot {
 	unsigned long rcu;
+	unsigned long srcu_gp;
 	bool ongoing;
 };
 
+DEFINE_SRCU_FAST(tracepoint_srcu);
+EXPORT_SYMBOL_GPL(tracepoint_srcu);
+
 /* Protected by tracepoints_mutex */
 static struct tp_transition_snapshot tp_transition_snapshot[_NR_TP_TRANSITION_SYNC];
 
@@ -46,6 +50,7 @@ static void tp_rcu_get_state(enum tp_transition_sync sync)
 
 	/* Keep the latest get_state snapshot. */
 	snapshot->rcu = get_state_synchronize_rcu();
+	snapshot->srcu_gp = start_poll_synchronize_srcu(&tracepoint_srcu);
 	snapshot->ongoing = true;
 }
 
@@ -56,6 +61,8 @@ static void tp_rcu_cond_sync(enum tp_transition_sync sync)
 	if (!snapshot->ongoing)
 		return;
 	cond_synchronize_rcu(snapshot->rcu);
+	if (!poll_state_synchronize_srcu(&tracepoint_srcu, snapshot->srcu_gp))
+		synchronize_srcu(&tracepoint_srcu);
 	snapshot->ongoing = false;
 }
 
@@ -112,10 +119,13 @@ static inline void release_probes(struct tracepoint *tp, struct tracepoint_func
 		struct tp_probes *tp_probes = container_of(old,
 			struct tp_probes, probes[0]);
 
-		if (tracepoint_is_faultable(tp))
-			call_rcu_tasks_trace(&tp_probes->rcu, rcu_free_old_probes);
-		else
-			call_rcu(&tp_probes->rcu, rcu_free_old_probes);
+		if (tracepoint_is_faultable(tp)) {
+			call_rcu_tasks_trace(&tp_probes->rcu,
+					     rcu_free_old_probes);
+		} else {
+			call_srcu(&tracepoint_srcu, &tp_probes->rcu,
+				  rcu_free_old_probes);
+		}
 	}
 }
 
-- 
2.51.0


