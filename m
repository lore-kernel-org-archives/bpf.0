Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795822387;
	b=2qE4KbiZkwI1WNCBWXDKIVY/2MJDFK3wiWcl3CF6Buyq2gK+jBN9eWJITzD8uFbNREUl
	 vseksn+MQ725Pm/t5AP+hI7RvGAjW4hbE5AA4Z6pyhk0LffeMORriyJfDSyzcy7mDBxqF
	 Piz97QR8bSgjljG4SeQlmGcu1uchN/ON9JenDRmNAUSQsqun5wYd1ueDelVeT1NQjcepF
	 C8UY4B8fzfOz+IhobPIuXvV20O9dWgphtEiC2GlO+kIF0d3i4ddWg7imfTg7Opm83n7Hh
	 Tv28MizMnE5gFopENwIVWRnBvY6RKOo3+Hk+d0RtLrPBJ/IPXydX/eu7zJ/dXPYpiHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795822387;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=Hgp2tkog+fmNuQ20vBF7F2LaDTU6lyjZR93nHU1ofUc=;
	b=32id67Bgo/FVxdcwzFEcdpLYTCxr2imOFyUnRjxUHmjjEoDqqPMKYkfOGVcF8ODVtNR6
	 V9HmDw2hRAheEzGKduqGkriQOvTmmUomcSfkhwhYYiyli21zp1tyK3o7mpOHuSDOgklJf
	 Eugl4TVIL84SI/c+C1SdENtd+mleltr3qSFjEGMIlNUBCaBC/Xaxu7hsuyH29419yeECM
	 gZnrK5KFkQGyC6Q9m+zJ3pBNfoa1KLjfzTQN/dNTDRSjMimwXEwWulgzBvTdOlHiervwm
	 9J6H9FUU8kRLkNgpjPkLbbPHFStmDoZiVP1cHPN0KE8I7bVF93AjPyiw9RBdldBLNMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dLplWFMh;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A1A606A31F
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 23:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25A1A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dLplWFMh
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so4222651b3a.0
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 15:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795822386; x=1796427186; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hgp2tkog+fmNuQ20vBF7F2LaDTU6lyjZR93nHU1ofUc=;
        b=dLplWFMhn5q/YrwEE01ZyG4IzSFVnYy6mbRwNzGE7tp9BPq2lMrFLxuA/Q8bJ8QxR6
         scV1e5ZDWT5xDpZITkXqVWP6dWPT88BOW9GsOrEjgKzVjovkEyEWElCJR5s0ex1D8GAr
         RJOVbNrRAM1N3KyLRCTt25pRL2pXCsBzCOThrgD3Thn3ALqznpNIkWdrtPjzjVBi0oy9
         WG+8AG8NVPrKtIR7ok1+s6WI+/MeUgWz8nFKFqui7FmrKmJCK3i/ZH+TSXNRDFJu1l05
         LEViSyWn4IJEa8c/MsjOd4F10sF+g85gaALoID3nAgBCNkWwCGAlfw00SKfVtl/WWrjh
         3OJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795822386; x=1796427186;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hgp2tkog+fmNuQ20vBF7F2LaDTU6lyjZR93nHU1ofUc=;
        b=ziicPaRn6ZIcJq+yt1E9MpRZZg4reAHgl6QHHK1tTndd3DM8luiwUTz9nmV3nMbsxG
         5PkAN7O15e0eW5R7+zeJ/Y+HdDuMNAOOPYi2pbtAqbiNfr7hOROeiP+U/7hr430QM5lI
         H/onV/G47wClz/OQgAE9BH1P/TQhL6pSNoUkk6OdBKYvbTz2mXz/9BX7SO+WfmeibzBi
         tPbRSsLFTIfShyQg3qG1Fw/NFEYXKh+omlAduU4vw5OBCyafMUQVwt0Jvoy4fe9MY5aQ
         FhjlvSr23pZQlo7q/Ah0I96Qu/ZEDzE2pHtGkj2D4HgTQDdDzFBtJNYZrrGSaib/Kg2V
         h37w==
X-Forwarded-Encrypted: i=1; AL+hErGPKTjKzi3JlCEoQvAqOovUV/3ojUc3vErRR2TKpPLARWM+UHoO2S17+xhO+3r0O0JMKL4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8MO+9Jld4vUaI5AF2u8F7Cl7Q8S6ohUPPZkoXnPGoJIEjgwdQs
	lrlt7yAb7TBx5LvaVvCtelQ+wC7ehuDZaw8U9knJoEmMZcHDDDbW8pD5
X-Gm-Gg: AZFdTZffuzMQTTqMtYgQOJUXTK+3qWXMjwRxMUwTxHXPNUMcy+erLzoqHzMjGBYQVK+
	FSM9gqF6fLB8NkqBn3NwMXJoAGfmgJLSLBL2+OmCP1S0h1ryVaq0aBjizHblk3Pq94SZ3kJLfuI
	vfy366dlWhL2PDKNI3B8IAPs3U5TAsM3BwBatqo9JQxJQGm0Jc8AxrSethJhZnqJPzGsiMvUQuK
	uRgPQCFNdBM+u8PVKp0MBRdqiu3xaHTMEpqcqTYdrmziNaaMTEsZGP7kbMfHuuK95S7P+pf/FAz
	D2q+jI26/gvz5fM6t98e2YaG+W6EoOtWl3zc99UmZvRQKszSiXqWQsCOICQu0WJ1PEjJIh0VOPD
	/x9pkJJJViOg1tArh5DaABZCsmT6hncIaqJmSoo5l4ozwih0Ev5+wLzwdukN46mAgsXt0WfBIHt
	9zIvPlylEVj9OhlN1AdHCi5KV4APaUlHZzWJHVhvANOKEs5Dn41TZ82TIH+N8GgnN687ApUvRP3
	ZlW+/WY+B3xfAAbuiaWJO9cF2HotQrPk8T7+59IJURjgBvG3kiAAly1qgJqmUuo/7snfaZLLTuO
	4nqRe7nk47YID9iNP5t0ebKjOyp12r2R7mAfoUZbJwumDLgyc67jzERnrrLBSWFCSkh87Mmf4Qe
	6QZ5JjhrxaZ0LE2/sn5LyJeP7Hjcgn6dPtA==
X-Received: by 2002:a05:6a20:734f:b0:3fb:3355:e440 with SMTP id adf61e73a8af0-4014ea47a6cmr28155512637.74.1795822385980;
        Fri, 27 Nov 2026 15:33:05 -0800 (PST)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cea7c38sm13857410a12.2.2026.11.27.15.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 15:33:05 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 23:33:05 +0000
Message-Id: <DN6DWMLNI044.39KJNBB9RWCQY@gmail.com>
Subject: Re: [PATCH v3 05/18] rv: Add generic monitor event tracepoints and
 BPF kfuncs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Gabriele Monaco" <gmonaco@redhat.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>
Cc: "Nam Cao" <namcao@linutronix.de>, "Wen Yang" <wen.yang@linux.dev>,
 "Tobias Schaffner" <tobias.schaffner@siemens.com>, "Viktor Malik"
 <vmalik@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>, "John Ogness"
 <john.ogness@linutronix.de>
In-Reply-To: <20261126130004.127155-6-gmonaco@redhat.com>
References: <20261126130004.127155-1-gmonaco@redhat.com> <20261126130004.127155-6-gmonaco@redhat.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, Nov 26, 2026 at 04:59 AM Gabriele Monaco <gmonaco@redhat.com> wrote:
> Add also bpf_rv_event_monitor() / bpf_rv_error_monitor() kfuncs wrapping
> them, so BPF monitors can emit similar events to in-kernel monitors.
>
> Userspace callers need now to use ftrace filters to get the right events
> but events and errors are separate channels to ease the most common
> filtering and account for dramatically different volume (errors are
> rare).

I thought we agreed that plain bpf_printk() works with glob filtering on top.
Why do you need these new kfuncs?
See below diff that illustrates the point.

> +	if (strnlen(msg, msg__sz) == msg__sz)
> +		return -EINVAL;
> +
> +	trace_event_monitor(mon__str, id__nullable, msg);

This will read out of bounds. msg can point to a map value.
Take a BPF_F_MMAPABLE array with one page size value. NUL is the last byte:

  prog                                  user space
  strnlen(msg, msg__sz) finds the NUL
                                        writes 'x' over the NUL
  __string(msg, msg) -> strlen(msg)
  runs into the vmalloc guard page

There is no limit on msg__sz either.
When perf is on the event, a msg above 8192 bytes hits WARN_ONCE() in
perf_trace_buf_alloc().


diff --git a/tools/verification/rv/bpf_monitors/da_monitor_bpf.h b/tools/verification/rv/bpf_monitors/da_monitor_bpf.h
index e9e673c..6996c01 100644
--- a/tools/verification/rv/bpf_monitors/da_monitor_bpf.h
+++ b/tools/verification/rv/bpf_monitors/da_monitor_bpf.h
@@ -24,8 +24,6 @@
 #define da_implicit_guard()
 #define IS_ENABLED(conf) 0
 
-#define DA_TRACE_MSG_MAX 128
-
 /*
  * Also used to filter out events higher values imply lower ones.
  * Userspace will parse this enum but expects EVENT to imply ERROR(s) and ERROR
@@ -328,10 +326,9 @@ static inline void da_reset_bpf(da_id_type id, monitor_target_bpf target)
 
 #endif /* RV_MON_TYPE */
 
-extern int bpf_rv_event_monitor(const char *mon, const int *id__nullable,
-				const char *msg, u32 msg__sz) __ksym;
-extern int bpf_rv_error_monitor(const char *mon, const int *id__nullable,
-				const char *msg, u32 msg__sz) __ksym;
+/* "rv: <type>: <monitor>: <text>" in bpf_trace:bpf_trace_printk */
+#define rv_printk(type, fmt, ...) \
+	bpf_printk("rv: " type ": " __stringify(MONITOR_NAME) ": " fmt, __VA_ARGS__)
 
 #if RV_MON_TYPE == RV_MON_GLOBAL || RV_MON_TYPE == RV_MON_PER_CPU
 /*
@@ -345,28 +342,22 @@ static inline void da_trace_event(struct da_monitor *da_mon,
 				  const char *next_state, bool is_final,
 				  da_id_type id)
 {
-	char msg[DA_TRACE_MSG_MAX];
-
 	if (trace_level < RV_TRACE_EVENT)
 		return;
 
-	BPF_SNPRINTF(msg, sizeof(msg), "%s x %s -> %s%s",
-		curr_state, event, next_state, is_final ? " (final)" : "");
-	bpf_rv_event_monitor(__stringify(MONITOR_NAME), NULL, msg, sizeof(msg));
+	rv_printk("event", "%s x %s -> %s%s",
+		  curr_state, event, next_state, is_final ? " (final)" : "");
 }
 
 static inline void da_trace_error(struct da_monitor *da_mon,
 				  const char *curr_state, const char *event,
 				  da_id_type id)
 {
-	char msg[DA_TRACE_MSG_MAX];
-
 	if (trace_level < RV_TRACE_ERROR)
 		return;
 
-	BPF_SNPRINTF(msg, sizeof(msg), "event %s not expected in the state %s",
-		 event, curr_state);
-	bpf_rv_error_monitor(__stringify(MONITOR_NAME), NULL, msg, sizeof(msg));
+	rv_printk("error", "event %s not expected in the state %s",
+		  event, curr_state);
 }
 
 #elif RV_MON_TYPE == RV_MON_PER_TASK || RV_MON_TYPE == RV_MON_PER_OBJ
@@ -379,28 +370,22 @@ static inline void da_trace_event(struct da_monitor *da_mon,
 				  const char *next_state, bool is_final,
 				  da_id_type id)
 {
-	char msg[DA_TRACE_MSG_MAX];
-
 	if (trace_level < RV_TRACE_EVENT)
 		return;
 
-	BPF_SNPRINTF(msg, sizeof(msg), "%d: %s x %s -> %s%s", id,
-		curr_state, event, next_state, is_final ? " (final)" : "");
-	bpf_rv_event_monitor(__stringify(MONITOR_NAME), &id, msg, sizeof(msg));
+	rv_printk("event", "%d: %s x %s -> %s%s", id,
+		  curr_state, event, next_state, is_final ? " (final)" : "");
 }
 
 static inline void da_trace_error(struct da_monitor *da_mon,
 				  const char *curr_state, const char *event,
 				  da_id_type id)
 {
-	char msg[DA_TRACE_MSG_MAX];
-
 	if (trace_level < RV_TRACE_ERROR)
 		return;
 
-	BPF_SNPRINTF(msg, sizeof(msg), "%d: event %s not expected in the state %s",
-		 id, event, curr_state);
-	bpf_rv_error_monitor(__stringify(MONITOR_NAME), &id, msg, sizeof(msg));
+	rv_printk("error", "%d: event %s not expected in the state %s",
+		  id, event, curr_state);
 }
 #endif /* RV_MON_TYPE */
 
diff --git a/tools/verification/rv/src/trace.c b/tools/verification/rv/src/trace.c
index 629b4f6..91f86bf 100644
--- a/tools/verification/rv/src/trace.c
+++ b/tools/verification/rv/src/trace.c
@@ -15,7 +15,7 @@
 #include <trace.h>
 #include <utils.h>
 
-#define FILTER_MAX 128
+#define FILTER_MAX 256
 
 /**
  * collect_registered_events - print an event collected from the trace buffer
@@ -176,20 +176,25 @@ static int enable_specific_event(struct trace_instance *inst, const char *event_
 }
 
 /*
- * enable_generic_event - enable a generic event with filters
+ * enable_bpf_events - collect the messages of a BPF monitor
+ *
+ * BPF monitors report via bpf_printk("rv: <event|error>: <monitor>: ...").
+ *
+ * Returns 0 on success, -1 otherwise.
  */
-static int enable_generic_event(struct trace_instance *inst, const char *event_name, char *name)
+static int enable_bpf_events(struct trace_instance *inst, char *name)
 {
-	struct tep_event *tevent = tep_find_event_by_name(inst->tep, "rv", event_name);
+	struct tep_event *tevent;
 	char filter[FILTER_MAX] = "";
 	size_t len;
 
+	tevent = tep_find_event_by_name(inst->tep, "bpf_trace", "bpf_trace_printk");
 	if (!tevent) {
-		err_msg("trace: fail finding the rv:%s event\n", event_name);
+		err_msg("trace: fail finding the bpf_trace_printk event\n");
 		return -1;
 	}
 
-	len = snprintf(filter, sizeof(filter), "mon == \"%s\"", name);
+	len = snprintf(filter, sizeof(filter), "bpf_string ~ \"rv: *: %s: *\"", name);
 	if (len >= sizeof(filter)) {
 		err_msg("trace: monitor name %s too long\n", name);
 		return -1;
@@ -197,31 +202,12 @@ static int enable_generic_event(struct trace_instance *inst, const char *event_n
 
 	if (config.my_pid > 0)
 		snprintf(filter + len, sizeof(filter) - len,
-			 " && common_pid != %d && !(has_id == 1 && id == %d)",
-			 config.my_pid, config.my_pid);
+			 " && common_pid != %d && !(bpf_string ~ \"rv: *: %s: %d: *\")",
+			 config.my_pid, name, config.my_pid);
 
 	return apply_filter_enable(inst, tevent, filter);
 }
 
-/*
- * enable_bpf_events - enable rv:event_monitor and rv:error_monitor for a monitor
- *
- * BPF monitors report via generic rv:event_monitor and rv:error_monitor events.
- * Enable the events and filter them to only collect the messages of the given monitor.
- *
- * Returns 0 on success, -1 otherwise.
- */
-static int enable_bpf_events(struct trace_instance *inst, char *name)
-{
-	if (!config.trace_errors_only && enable_generic_event(inst, "event_monitor", name))
-		return -1;
-
-	if (enable_generic_event(inst, "error_monitor", name))
-		return -1;
-
-	return 0;
-}
-
 /**
  * trace_enable_monitor_events - enable a monitor's events in a trace instance
  *
diff --git a/tools/verification/rv/tests/rv_mon.t b/tools/verification/rv/tests/rv_mon.t
index 30d1dda..f51f194 100644
--- a/tools/verification/rv/tests/rv_mon.t
+++ b/tools/verification/rv/tests/rv_mon.t
@@ -104,16 +104,16 @@ cpu="\[[0-9]\{3\}\][[:space:]]\+"
 state="[a-z_]\+ "
 id="[0-9]\+"
 selfid="\$pid"
-# BPF monitors report via the common rv:event_monitor/rv:error_monitor
-# events, which add a "<mon>: " prefix to the message.
+# BPF monitors report via bpf_printk()
+type_bpf="bpf_trace_printk: rv: \(event\|error\)"
 trace_task="${genpid}${cpu}${type}: ${id}: ${state}"
 trace_task_self="${genpid}${cpu}${type}: ${selfid}: ${state}"
 trace_cpu="${genpid}${cpu}${type}: ${state}"
 trace_cpu_self="${selfpid}${cpu}${type}: ${state}"
-trace_task_bpf="${genpid}${cpu}${type}: ${mon}: ${id}: ${state}"
-trace_task_bpf_self="${genpid}${cpu}${type}: ${mon}: ${selfid}: ${state}"
-trace_cpu_bpf="${genpid}${cpu}${type}: ${mon}: ${state}"
-trace_cpu_bpf_self="${selfpid}${cpu}${type}: ${mon}: ${state}"
+trace_task_bpf="${genpid}${cpu}${type_bpf}: ${mon}: ${id}: ${state}"
+trace_task_bpf_self="${genpid}${cpu}${type_bpf}: ${mon}: ${selfid}: ${state}"
+trace_cpu_bpf="${genpid}${cpu}${type_bpf}: ${mon}: ${state}"
+trace_cpu_bpf_self="${selfpid}${cpu}${type_bpf}: ${mon}: ${state}"
 
 check_if_exists "run per-task monitor with tracing" \
 	"$RV mon sssw -t" "$RVDIR/monitors/sched/sssw" \
@@ -154,10 +154,10 @@ check_if_exists "run per-task monitor tracing only errors" \
 
 check_if_exists "run per-task BPF monitor tracing only errors" \
 	"$RV mon tqueue -t -E" "$RVTOOL/bpf_monitors/tqueue.o" \
-	"$header" "event_monitor"
+	"$header" "rv: event"
 
 check_if_exists "run per-cpu BPF monitor tracing only errors" \
 	"$RV mon nohz -t -E" "$RVTOOL/bpf_monitors/nohz.o" \
-	"error_monitor" "event_monitor"
+	"rv: error" "rv: event"
 
 test_end

