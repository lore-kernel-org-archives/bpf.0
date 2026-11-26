Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698073;
	b=rka0PTSKyH/ZMZ+vpB7jkkK47B4+QQGW7xuF7jGNKn7sKvDSJMLVsMP84dlDJtdaKSUD
	 EBL5EOQmZ6vN7ZV+qLkughY9eDACz90IT7AhDC8M2jPrE0p5wUjOqZv2ae/lbY6pDdcxO
	 9ZVr6GH6pu7TpH04BhbORyJaJOWoXLvK1Ec+x1arcHrgQ6r32DdwqohO7AYR6GXBwGpeV
	 /rE79HGSlLoGYwVpO27faINRX+/VpfmGnXoKtV4swSesmhU6dxChbiajmVczb9JbooF8L
	 VN/Dpu+CrroDkX3ez4h7vyds7Hm6K8LWshxqkZyUb4yxXSGngx+9wP0VoIbO1jY/XQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698073;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=2QqdsVVnxP1jujQrs2DS5xI77bSGTC/XR9+5id+paCM=;
	b=w+YT+VkVou5qvM/7mjWkkkq3zsDvuBypgnZ0McUeW76Sbc2xqDuGQjgFVqn2gLiK0n3Q
	 qNSuTCwIAa3DcT5OJ9rQLoUBLY0Oh5T5nZzIct2dE1VGeydfs8HcsfswXcx317RKlNeXW
	 lGMs8Y0rVVYvtavqAWW3vnH+bFKd7j1fFevQ+CS/f+9JSPGpTIBZGEzJK2oIwN7jtwESp
	 OKUmCq6IMXTDroAfnbnsi4hmBwSmOCtnb+hV+qAoH782kfm4c1oMPa4AuwKHQ2uR6QmKy
	 K9zlN3BPS1HWscNDT5jGYqqQv+x6NHgayvCJbm16PPOX494lN33Zey5b5+F4ptQgEfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tv7qDRW6;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DC1606A321
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1DC1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tv7qDRW6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795698071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2QqdsVVnxP1jujQrs2DS5xI77bSGTC/XR9+5id+paCM=;
	b=Tv7qDRW6MCoUGX2KWF9Prh1PenxD1fNNSJf+prXqV5JBYxy2DWN8mpSAuKTsPTLJh3XXXN
	2QfJ5o+RHBNFd6bryhpUR+JfsmW/WXP4p0xhz+5jFo7mwBZ6QarLMfGgTNktGXRu+lzrfi
	3sqWtZkNVoIsB2yuZHkGAXdYdzeXLCI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-bx0tWmUlPmqzR7QYt8x05Q-1; Thu,
 26 Nov 2026 13:01:06 +0000
X-MC-Unique: bx0tWmUlPmqzR7QYt8x05Q-1
X-Mimecast-MFC-AGG-ID: bx0tWmUlPmqzR7QYt8x05Q_1795698064
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 899EB1800743;
	Thu, 26 Nov 2026 13:01:04 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 004D31801977;
	Thu, 26 Nov 2026 13:01:00 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	John Ogness <john.ogness@linutronix.de>
Subject: [PATCH v3 08/18] tools/rv: Move monitor trace handling to trace.c
Date: Thu, 26 Nov 2026 13:59:54 +0100
Message-ID: <20261126130004.127155-9-gmonaco@redhat.com>
In-Reply-To: <20261126130004.127155-1-gmonaco@redhat.com>
References: <20261126130004.127155-1-gmonaco@redhat.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Move the rv monitor tracing functions from in_kernel.c to trace.c so
it can be shared with other monitor backends, e.g. BPF monitors that
emit tracepoints.

No functional changes but minor simplifications:
- simplify ambiguous destruction path and use trace inst on stack
- more consistent argument order
- fix minor style issues

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/include/trace.h |   4 +-
 tools/verification/rv/src/in_kernel.c | 295 +-------------------------
 tools/verification/rv/src/trace.c     | 290 +++++++++++++++++++++++--
 3 files changed, 280 insertions(+), 309 deletions(-)

diff --git a/tools/verification/rv/include/trace.h b/tools/verification/rv/include/trace.h
index 8d89e8c303fa..e3d65ff3d544 100644
--- a/tools/verification/rv/include/trace.h
+++ b/tools/verification/rv/include/trace.h
@@ -9,8 +9,10 @@ struct trace_instance {
 };
 
 int trace_instance_init(struct trace_instance *trace, char *name);
-int trace_instance_start(struct trace_instance *trace);
 void trace_instance_destroy(struct trace_instance *trace);
 
 int collect_registered_events(struct tep_event *event, struct tep_record *record,
 			      int cpu, void *context);
+
+void trace_print_header(struct trace_seq *s);
+int trace_instance_setup(struct trace_instance *inst, char *name);
diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index 90c340a73c76..79f2d308e14d 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -9,7 +9,6 @@
 #include <string.h>
 #include <errno.h>
 #include <unistd.h>
-#include <dirent.h>
 
 #include <trace.h>
 #include <utils.h>
@@ -304,29 +303,6 @@ static char *ikm_get_current_reactor(char *monitor_name)
 	return curr_reactor;
 }
 
-static int ikm_has_id(char *monitor_name)
-{
-	char path[MAX_PATH];
-	char *format;
-	int has_id;
-
-	snprintf(path, MAX_PATH, "events/rv/event_%s/format", monitor_name);
-	format = tracefs_instance_file_read(NULL, path, NULL);
-	if (!format) {
-		err_msg("ikm: fail reading monitor's %s format event file\n", monitor_name);
-		return -1;
-	}
-
-	/* print fmt: "%d: %s x %s -> %s %s", REC->id, ... */
-	has_id = !!strstr(format, "REC->id");
-
-	debug_msg("ikm: monitor %s has id: %s\n", monitor_name, has_id ? "yes" : "no");
-
-	free(format);
-
-	return has_id;
-}
-
 /**
  * ikm_list_monitors - list all available monitors
  *
@@ -379,260 +355,6 @@ int ikm_list_monitors(char *container)
 	return 0;
 }
 
-static void ikm_print_header(struct trace_seq *s)
-{
-	trace_seq_printf(s, "%16s-%-8s %5s %5s ", "<TASK>", "PID", "[CPU]", "TYPE");
-	if (config.has_id)
-		trace_seq_printf(s, "%8s ", "ID");
-
-	trace_seq_printf(s, "%24s x %-24s -> %-24s %s\n",
-			 "STATE",
-			 "EVENT",
-			 "NEXT_STATE",
-			 "FINAL");
-
-	trace_seq_printf(s, "%16s %-8s %5s %5s ", " | ", " | ", " | ", " | ");
-
-	if (config.has_id)
-		trace_seq_printf(s, "%8s ", " | ");
-
-	trace_seq_printf(s, "%24s   %-24s    %-24s %s\n",
-			 " | ",
-			 " | ",
-			 " | ",
-			 "|");
-
-}
-
-/*
- * ikm_event_handler - callback to handle event events
- *
- * Called any time a rv:"monitor"_event events is generated.
- * It parses and prints event.
- */
-static int
-ikm_event_handler(struct trace_seq *s, struct tep_record *record,
-		  struct tep_event *trace_event, void *context)
-{
-	/* if needed: struct trace_instance *inst = context; */
-	char *state, *event, *next_state;
-	unsigned long long final_state;
-	unsigned long long pid;
-	unsigned long long id;
-	int val;
-	bool missing_id;
-
-	if (config.has_id)
-		missing_id = tep_get_field_val(s, trace_event, "id", record, &id, 1);
-
-	tep_get_common_field_val(s, trace_event, "common_pid", record, &pid, 1);
-
-	if (config.has_id && (config.my_pid == id))
-		return 0;
-	else if (config.my_pid == pid)
-		return 0;
-
-	tep_print_event(trace_event->tep, s, record, "%16s-%-8d [%.3d] ",
-			TEP_PRINT_COMM, TEP_PRINT_PID, TEP_PRINT_CPU);
-
-	if (config.is_container)
-		tep_print_event(trace_event->tep, s, record, "%s ", TEP_PRINT_NAME);
-	else
-		trace_seq_printf(s, "event ");
-
-	if (config.has_id) {
-		if (missing_id)
-			/* placeholder if we are dealing with a mixed-type container*/
-			trace_seq_printf(s, "        ");
-		else
-			trace_seq_printf(s, "%8llu ", id);
-	}
-
-	state = tep_get_field_raw(s, trace_event, "state", record, &val, 0);
-	event = tep_get_field_raw(s, trace_event, "event", record, &val, 0);
-	next_state = tep_get_field_raw(s, trace_event, "next_state", record, &val, 0);
-	tep_get_field_val(s, trace_event, "final_state", record, &final_state, 1);
-
-	trace_seq_printf(s, "%24s x %-24s -> %-24s %s\n",
-			 state,
-			 event,
-			 next_state,
-			 final_state ? "Y" : "N");
-
-	trace_seq_do_printf(s);
-	trace_seq_reset(s);
-
-	return 0;
-}
-
-/*
- * ikm_error_handler - callback to handle error events
- *
- * Called any time a rv:"monitor"_errors events is generated.
- * It parses and prints event.
- */
-static int
-ikm_error_handler(struct trace_seq *s, struct tep_record *record,
-		  struct tep_event *trace_event, void *context)
-{
-	unsigned long long pid, id;
-	int cpu = record->cpu;
-	char *state, *event;
-	int val;
-	bool missing_id;
-
-	if (config.has_id)
-		missing_id = tep_get_field_val(s, trace_event, "id", record, &id, 1);
-
-	tep_get_common_field_val(s, trace_event, "common_pid", record, &pid, 1);
-
-	if (config.has_id && config.my_pid == id)
-		return 0;
-	else if (config.my_pid == pid)
-		return 0;
-
-	trace_seq_printf(s, "%8lld [%03d] ", pid, cpu);
-
-	if (config.is_container)
-		tep_print_event(trace_event->tep, s, record, "%s ", TEP_PRINT_NAME);
-	else
-		trace_seq_printf(s, "error ");
-
-	if (config.has_id) {
-		if (missing_id)
-			/* placeholder if we are dealing with a mixed-type container*/
-			trace_seq_printf(s, "        ");
-		else
-			trace_seq_printf(s, "%8llu ", id);
-	}
-
-	state = tep_get_field_raw(s, trace_event, "state", record, &val, 0);
-	event = tep_get_field_raw(s, trace_event, "event", record, &val, 0);
-
-	trace_seq_printf(s, "%24s x %s\n", state, event);
-
-	trace_seq_do_printf(s);
-	trace_seq_reset(s);
-
-	return 0;
-}
-
-static int ikm_enable_trace_events(char *monitor_name, struct trace_instance *inst)
-{
-	char event[MAX_DA_NAME_LEN + 7]; /* max(error_,event_) + '0' = 7 */
-	int retval;
-
-	snprintf(event, sizeof(event), "event_%s", monitor_name);
-	retval = tracefs_event_enable(inst->inst, "rv",  event);
-	if (retval)
-		return -1;
-
-	tep_register_event_handler(inst->tep, -1, "rv", event,
-				   ikm_event_handler, NULL);
-
-	snprintf(event, sizeof(event), "error_%s", monitor_name);
-	retval = tracefs_event_enable(inst->inst, "rv", event);
-	if (retval)
-		return -1;
-
-	tep_register_event_handler(inst->tep, -1, "rv", event,
-				   ikm_error_handler, NULL);
-
-	/* set if at least 1 monitor has id in case of a container */
-	config.has_id = ikm_has_id(monitor_name);
-	if (config.has_id < 0)
-		return -1;
-
-
-	return 0;
-}
-
-static int ikm_enable_trace_container(char *monitor_name,
-				      struct trace_instance *inst)
-{
-	DIR *dp;
-	char *abs_path, rv_path[MAX_PATH];
-	struct dirent *ep;
-	int retval = 0;
-
-	snprintf(rv_path, MAX_PATH, "rv/monitors/%s", monitor_name);
-	abs_path = tracefs_instance_get_file(NULL, rv_path);
-	if (!abs_path)
-		return -1;
-	dp = opendir(abs_path);
-	if (!dp)
-		goto out_free;
-
-	while (!retval && (ep = readdir(dp))) {
-		if (ep->d_type != DT_DIR || ep->d_name[0] == '.')
-			continue;
-		retval = ikm_enable_trace_events(ep->d_name, inst);
-	}
-
-	closedir(dp);
-out_free:
-	free(abs_path);
-	return retval;
-}
-
-/*
- * ikm_setup_trace_instance - set up a tracing instance to collect data
- *
- * Create a trace instance, enable rv: events and enable the trace.
- *
- * Returns the trace_instance * with all set, NULL otherwise.
- */
-static struct trace_instance *ikm_setup_trace_instance(char *monitor_name)
-{
-	struct trace_instance *inst;
-	int retval;
-
-	if (!config.trace)
-		return NULL;
-
-	/* alloc data */
-	inst = calloc(1, sizeof(*inst));
-	if (!inst) {
-		err_msg("ikm: failed to allocate trace instance");
-		goto out_err;
-	}
-
-	retval = trace_instance_init(inst, monitor_name);
-	if (retval)
-		goto out_free;
-
-	if (config.is_container)
-		retval = ikm_enable_trace_container(monitor_name, inst);
-	else
-		retval = ikm_enable_trace_events(monitor_name, inst);
-	if (retval)
-		goto out_inst;
-
-	/* ready to enable */
-	tracefs_trace_on(inst->inst);
-
-	return inst;
-
-out_inst:
-	trace_instance_destroy(inst);
-out_free:
-	free(inst);
-out_err:
-	return NULL;
-}
-
-/**
- * ikm_destroy_trace_instance - destroy a previously created instance
- */
-static void ikm_destroy_trace_instance(struct trace_instance *inst)
-{
-	if (!inst)
-		return;
-
-	trace_instance_destroy(inst);
-	free(inst);
-}
-
 /*
  * ikm_usage_print_reactors - print all available reactors, one per line.
  */
@@ -669,7 +391,7 @@ void ikm_usage_print_reactors(void)
  */
 int ikm_run_monitor(char *monitor_name, int argc, char **argv)
 {
-	struct trace_instance *inst = NULL;
+	struct trace_instance inst = {0};
 	char *nested_name, full_name[2*MAX_DA_NAME_LEN];
 	int retval;
 
@@ -712,8 +434,7 @@ int ikm_run_monitor(char *monitor_name, int argc, char **argv)
 	}
 
 	if (config.trace) {
-		inst = ikm_setup_trace_instance(nested_name);
-		if (!inst)
+		if (trace_instance_setup(&inst, nested_name))
 			goto out_free_instance;
 	}
 
@@ -722,16 +443,16 @@ int ikm_run_monitor(char *monitor_name, int argc, char **argv)
 		goto out_free_instance;
 
 	if (config.trace)
-		ikm_print_header(inst->seq);
+		trace_print_header(inst.seq);
 
 	while (!should_stop()) {
 		if (config.trace) {
-			retval = tracefs_iterate_raw_events(inst->tep,
-							    inst->inst,
+			retval = tracefs_iterate_raw_events(inst.tep,
+							    inst.inst,
 							    NULL,
 							    0,
 							    collect_registered_events,
-							    inst);
+							    &inst);
 			if (retval) {
 				err_msg("ikm: error reading trace buffer\n");
 				break;
@@ -742,7 +463,7 @@ int ikm_run_monitor(char *monitor_name, int argc, char **argv)
 	}
 
 	ikm_disable(full_name);
-	ikm_destroy_trace_instance(inst);
+	trace_instance_destroy(&inst);
 
 	if (config.reactor && config.initial_reactor)
 		ikm_write_reactor(full_name, config.initial_reactor);
@@ -750,7 +471,7 @@ int ikm_run_monitor(char *monitor_name, int argc, char **argv)
 	return 1;
 
 out_free_instance:
-	ikm_destroy_trace_instance(inst);
+	trace_instance_destroy(&inst);
 	if (config.reactor && config.initial_reactor)
 		ikm_write_reactor(full_name, config.initial_reactor);
 	return -1;
diff --git a/tools/verification/rv/src/trace.c b/tools/verification/rv/src/trace.c
index 1b9f9bfa1893..aa4bb73624ec 100644
--- a/tools/verification/rv/src/trace.c
+++ b/tools/verification/rv/src/trace.c
@@ -5,34 +5,16 @@
  * Copyright (C) 2022 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
  */
 
-#include <sys/sendfile.h>
 #include <tracefs.h>
-#include <signal.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <dirent.h>
 #include <errno.h>
 
 #include <rv.h>
 #include <trace.h>
 #include <utils.h>
 
-/*
- * create_instance - create a trace instance with *instance_name
- */
-static struct tracefs_instance *create_instance(char *instance_name)
-{
-	return tracefs_instance_create(instance_name);
-}
-
-/*
- * destroy_instance - remove a trace instance and free the data
- */
-static void destroy_instance(struct tracefs_instance *inst)
-{
-	tracefs_instance_destroy(inst);
-	tracefs_instance_free(inst);
-}
-
 /**
  * collect_registered_events - call the existing callback function for the event
  *
@@ -64,8 +46,12 @@ collect_registered_events(struct tep_event *event, struct tep_record *record,
  */
 void trace_instance_destroy(struct trace_instance *trace)
 {
+	if (!trace)
+		return;
+
 	if (trace->inst) {
-		destroy_instance(trace->inst);
+		tracefs_instance_destroy(trace->inst);
+		tracefs_instance_free(trace->inst);
 		trace->inst = NULL;
 	}
 
@@ -101,7 +87,7 @@ int trace_instance_init(struct trace_instance *trace, char *name)
 
 	trace_seq_init(trace->seq);
 
-	trace->inst = create_instance(name);
+	trace->inst = tracefs_instance_create(name);
 	if (!trace->inst)
 		goto out_err;
 
@@ -131,3 +117,265 @@ int trace_instance_start(struct trace_instance *trace)
 {
 	return tracefs_trace_on(trace->inst);
 }
+
+static int monitor_has_id(char *name)
+{
+	char path[MAX_PATH];
+	char *format;
+	int has_id;
+
+	snprintf(path, MAX_PATH, "events/rv/event_%s/format", name);
+	format = tracefs_instance_file_read(NULL, path, NULL);
+	if (!format) {
+		err_msg("rv: fail reading monitor's %s format event file\n", name);
+		return -1;
+	}
+
+	/* print fmt: "%d: %s x %s -> %s %s", REC->id, ... */
+	has_id = !!strstr(format, "REC->id");
+
+	debug_msg("rv: monitor %s has id: %s\n", name, has_id ? "yes" : "no");
+
+	free(format);
+
+	return has_id;
+}
+
+/**
+ * trace_print_header - print the header of the monitor events output
+ *
+ * Print the column header of the rv monitor events output: task, pid,
+ * cpu and event type, followed by the state machine transition
+ * (state x event -> next state and final). The ID column is printed
+ * only if the monitor's events have an id field.
+ */
+void trace_print_header(struct trace_seq *s)
+{
+	trace_seq_printf(s, "%16s-%-8s %5s %5s ", "<TASK>", "PID", "[CPU]", "TYPE");
+	if (config.has_id)
+		trace_seq_printf(s, "%8s ", "ID");
+
+	trace_seq_printf(s, "%24s x %-24s -> %-24s %s\n",
+			 "STATE",
+			 "EVENT",
+			 "NEXT_STATE",
+			 "FINAL");
+
+	trace_seq_printf(s, "%16s %-8s %5s %5s ", " | ", " | ", " | ", " | ");
+
+	if (config.has_id)
+		trace_seq_printf(s, "%8s ", " | ");
+
+	trace_seq_printf(s, "%24s   %-24s    %-24s %s\n",
+			 " | ",
+			 " | ",
+			 " | ",
+			 "|");
+}
+
+/*
+ * da_event_handler - callback to handle event events
+ *
+ * Called any time a rv:"monitor"_event events is generated.
+ * It parses and prints event.
+ */
+static int da_event_handler(struct trace_seq *s, struct tep_record *record,
+			    struct tep_event *trace_event, void *context)
+{
+	char *state, *event, *next_state;
+	unsigned long long final_state;
+	unsigned long long pid;
+	unsigned long long id;
+	int val;
+	bool missing_id;
+
+	if (config.has_id)
+		missing_id = tep_get_field_val(s, trace_event, "id", record, &id, 1);
+
+	tep_get_common_field_val(s, trace_event, "common_pid", record, &pid, 1);
+
+	if (config.has_id && (config.my_pid == id))
+		return 0;
+	else if (config.my_pid == pid)
+		return 0;
+
+	tep_print_event(trace_event->tep, s, record, "%16s-%-8d [%.3d] ",
+			TEP_PRINT_COMM, TEP_PRINT_PID, TEP_PRINT_CPU);
+
+	if (config.is_container)
+		tep_print_event(trace_event->tep, s, record, "%s ", TEP_PRINT_NAME);
+	else
+		trace_seq_printf(s, "event ");
+
+	if (config.has_id) {
+		if (missing_id)
+			/* placeholder if we are dealing with a mixed-type container*/
+			trace_seq_printf(s, "        ");
+		else
+			trace_seq_printf(s, "%8llu ", id);
+	}
+
+	state = tep_get_field_raw(s, trace_event, "state", record, &val, 0);
+	event = tep_get_field_raw(s, trace_event, "event", record, &val, 0);
+	next_state = tep_get_field_raw(s, trace_event, "next_state", record, &val, 0);
+	tep_get_field_val(s, trace_event, "final_state", record, &final_state, 1);
+
+	trace_seq_printf(s, "%24s x %-24s -> %-24s %s\n",
+			 state,
+			 event,
+			 next_state,
+			 final_state ? "Y" : "N");
+
+	trace_seq_do_printf(s);
+	trace_seq_reset(s);
+
+	return 0;
+}
+
+/*
+ * da_error_handler - callback to handle error events
+ *
+ * Called any time a rv:"monitor"_errors events is generated.
+ * It parses and prints event.
+ */
+static int da_error_handler(struct trace_seq *s, struct tep_record *record,
+			    struct tep_event *trace_event, void *context)
+{
+	unsigned long long pid, id;
+	int cpu = record->cpu;
+	char *state, *event;
+	int val;
+	bool missing_id;
+
+	if (config.has_id)
+		missing_id = tep_get_field_val(s, trace_event, "id", record, &id, 1);
+
+	tep_get_common_field_val(s, trace_event, "common_pid", record, &pid, 1);
+
+	if (config.has_id && config.my_pid == id)
+		return 0;
+	else if (config.my_pid == pid)
+		return 0;
+
+	trace_seq_printf(s, "%8lld [%03d] ", pid, cpu);
+
+	if (config.is_container)
+		tep_print_event(trace_event->tep, s, record, "%s ", TEP_PRINT_NAME);
+	else
+		trace_seq_printf(s, "error ");
+
+	if (config.has_id) {
+		if (missing_id)
+			/* placeholder if we are dealing with a mixed-type container*/
+			trace_seq_printf(s, "        ");
+		else
+			trace_seq_printf(s, "%8llu ", id);
+	}
+
+	state = tep_get_field_raw(s, trace_event, "state", record, &val, 0);
+	event = tep_get_field_raw(s, trace_event, "event", record, &val, 0);
+
+	trace_seq_printf(s, "%24s x %s\n", state, event);
+
+	trace_seq_do_printf(s);
+	trace_seq_reset(s);
+
+	return 0;
+}
+
+/**
+ * trace_enable_monitor_events - enable a monitor's events in a trace instance
+ *
+ * Enable the rv:event_"monitor" and rv:error_"monitor" events in the
+ * given trace instance, and register the callbacks that parse and
+ * print these events.
+ *
+ * Returns 0 on success, -1 otherwise.
+ */
+static int trace_enable_monitor_events(struct trace_instance *inst, char *name)
+{
+	char event[MAX_DA_NAME_LEN + 7]; /* max(error_,event_) + '0' = 7 */
+	int retval;
+
+	snprintf(event, sizeof(event), "event_%s", name);
+	retval = tracefs_event_enable(inst->inst, "rv",  event);
+	if (retval)
+		return -1;
+
+	tep_register_event_handler(inst->tep, -1, "rv", event,
+				   da_event_handler, NULL);
+
+	snprintf(event, sizeof(event), "error_%s", name);
+	retval = tracefs_event_enable(inst->inst, "rv", event);
+	if (retval)
+		return -1;
+
+	tep_register_event_handler(inst->tep, -1, "rv", event,
+				   da_error_handler, NULL);
+
+	/* set if at least 1 monitor has id in case of a container */
+	config.has_id = monitor_has_id(name);
+	if (config.has_id < 0)
+		return -1;
+
+	return 0;
+}
+
+static int trace_enable_container_events(struct trace_instance *inst, char *name)
+{
+	DIR *dp;
+	char *abs_path, rv_path[MAX_PATH];
+	struct dirent *ep;
+	int retval = 0;
+
+	snprintf(rv_path, MAX_PATH, "rv/monitors/%s", name);
+	abs_path = tracefs_instance_get_file(NULL, rv_path);
+	if (!abs_path)
+		return -1;
+	dp = opendir(abs_path);
+	free(abs_path);
+	if (!dp)
+		return -1;
+
+	while (!retval && (ep = readdir(dp))) {
+		if (ep->d_type != DT_DIR || ep->d_name[0] == '.')
+			continue;
+		retval = trace_enable_monitor_events(inst, ep->d_name);
+	}
+
+	closedir(dp);
+	return retval;
+}
+
+/*
+ * trace_instance_setup - set up a tracing instance to collect data
+ *
+ * Create a trace instance, enable rv: events and enable the trace.
+ *
+ * Returns 0 on success, -1 otherwise.
+ */
+int trace_instance_setup(struct trace_instance *inst, char *name)
+{
+	int retval;
+
+	if (!config.trace)
+		return -1;
+
+	retval = trace_instance_init(inst, name);
+	if (retval)
+		return -1;
+
+	if (config.is_container)
+		retval = trace_enable_container_events(inst, name);
+	else
+		retval = trace_enable_monitor_events(inst, name);
+	if (retval) {
+		trace_instance_destroy(inst);
+		return -1;
+	}
+
+	/* ready to enable */
+	tracefs_trace_on(inst->inst);
+
+	return 0;
+}
-- 
2.56.1

