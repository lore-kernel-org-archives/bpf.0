Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698067;
	b=5Eef8Upl+wrHrJ4HwxLLYrbfrZCqyQy+Y+9S0s1WMKRmhmoOYy9Vwja9FR+d/NT126M9
	 +54A7pgkbM8aAXfqrsVKNSjyCMGfGoVEz0qvyg9dt2qAnhcgeoQw538QiH90kf5OUzSKj
	 Y920CfcVLxMn+3K+cwC31v2isFActk4gZ7NaJi4FBVs3vefVsJrVtaXizVuvfJevT0oxR
	 s3ckqGbLqQCbmrLKHNybJi0zzdxXQhI3iBwzwNGhdCbbT8bWbzPot2DeBR0Wr2fOo7/RE
	 ID5SOte8BUKif9wdwX+1XdHB93bnL3DrWdSeNhFeTHNDg7mCaIqY4KCqQY/bd++oLVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698067;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=YQSAwaT7aWkGr+FJwvbGp3oqWjkIITdqvbO9aes+vYs=;
	b=fuF+8NmIy5zVkTOCxed4ZfRy7CUKcAyuTjy2j8SgLWcaIac7VCXVGNNCL9HwB8qyMxR4
	 2LMUzfNmOqahA2Xv8fGrVtSMKta/maHJWMa1fnWbnQ0zuuriuxRNQOnnsrjru0q2ZnG2x
	 0vxGGDwhaP04FRsa2mMVa3gV8D8LCuMdzhWvnFVN4CTt5XP8Bb3EUTvjDPqUNU4LKyXwD
	 a2u8I4iPUvvjl6QB2L59givPQQQOoBW8sDAgjWFnXR7oOr90DC7QBde4DdvTC3Rt7GBcD
	 eSIVkKTzc0dSpbBTtKi3YNAWWqK/Z8SXs71/YJ6BlzH0uP8V2TchHZuiZy3Zdsj8mvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="IH/LRbf8";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37C1606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D37C1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IH/LRbf8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795698065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQSAwaT7aWkGr+FJwvbGp3oqWjkIITdqvbO9aes+vYs=;
	b=IH/LRbf8xNS6krOCkfPFPb3m0vsnJYFYmN+eh/UeD87uGWS/5welohI7n3F0Gw4c9PFDED
	O+r5ZkBF3pSdkXnaCoHO/c6VM4IWOn0DueleJt1gODvaXbpYfc9CvnpLJANrYi/7HyX9g1
	SSiLgxidbU0xdZrMRKhJk3vrfT8EgVk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-ZKTt5ZzSODmCZrxYnifkpw-1; Thu,
 26 Nov 2026 13:01:03 +0000
X-MC-Unique: ZKTt5ZzSODmCZrxYnifkpw-1
X-Mimecast-MFC-AGG-ID: ZKTt5ZzSODmCZrxYnifkpw_1795698059
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6A4519560AD;
	Thu, 26 Nov 2026 13:00:59 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 852731800543;
	Thu, 26 Nov 2026 13:00:56 +0000 (UTC)
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
Subject: [PATCH v3 07/18] tools/rv: Move argument parsing from in_kernel to utils
Date: Thu, 26 Nov 2026 13:59:53 +0100
Message-ID: <20261126130004.127155-8-gmonaco@redhat.com>
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

The configuration of the in-kernel RV monitor is relying on global
variables, some static and some extern and the argument parsing occurs
there. That's not scalable especially if the configuration needs to be
shared by other monitor implementations (e.g. BPF).

Move the common argument parsing in utils and use a global struct for
the configuration. Implementation-specific configuration such as the
reactors are still handled in the in-kernel source.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/include/utils.h |  17 ++-
 tools/verification/rv/src/in_kernel.c | 176 ++++++--------------------
 tools/verification/rv/src/utils.c     |  95 +++++++++++++-
 3 files changed, 149 insertions(+), 139 deletions(-)

diff --git a/tools/verification/rv/include/utils.h b/tools/verification/rv/include/utils.h
index f24ae8282bd2..61f77a72a1a2 100644
--- a/tools/verification/rv/include/utils.h
+++ b/tools/verification/rv/include/utils.h
@@ -1,8 +1,23 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <stdbool.h>
+
 #define MAX_PATH		1024
 
 void debug_msg(const char *fmt, ...);
 void err_msg(const char *fmt, ...);
+void mon_usage(int exit_val, char *monitor_name, const char *fmt, ...);
+int parse_arguments(char *monitor_name, int argc, char **argv);
+
+void ikm_usage_print_reactors(void);
 
-extern int config_debug;
+struct config {
+	bool debug;
+	bool is_container;
+	bool trace;
+	int has_id;
+	int my_pid;
+	char *initial_reactor;
+	char *reactor;
+};
+extern struct config config;
diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index e6dea4040f8f..90c340a73c76 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -4,7 +4,6 @@
  *
  * Copyright (C) 2022 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
  */
-#include <getopt.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
@@ -16,14 +15,6 @@
 #include <utils.h>
 #include <rv.h>
 
-static int config_has_id;
-static int config_is_container;
-static int config_my_pid;
-static int config_trace;
-
-static char *config_initial_reactor;
-static char *config_reactor;
-
 /*
  * __ikm_read_enable - reads monitor's enable status
  *
@@ -66,7 +57,7 @@ static int __ikm_find_monitor_name(char *monitor_name, char *out_name)
 	if (!available_monitors)
 		return -1;
 
-	config_is_container = 0;
+	config.is_container = 0;
 	cursor = available_monitors;
 	while ((line = strsep(&cursor, "\n"))) {
 		char *colon = strchr(line, ':');
@@ -83,7 +74,7 @@ static int __ikm_find_monitor_name(char *monitor_name, char *out_name)
 			/* If there are children, they are on the next line. */
 			line = strsep(&cursor, "\n");
 			if (line && !strncmp(line, monitor_name, len) && line[len] == ':')
-				config_is_container = 1;
+				config.is_container = 1;
 		}
 
 		found = 1;
@@ -391,7 +382,7 @@ int ikm_list_monitors(char *container)
 static void ikm_print_header(struct trace_seq *s)
 {
 	trace_seq_printf(s, "%16s-%-8s %5s %5s ", "<TASK>", "PID", "[CPU]", "TYPE");
-	if (config_has_id)
+	if (config.has_id)
 		trace_seq_printf(s, "%8s ", "ID");
 
 	trace_seq_printf(s, "%24s x %-24s -> %-24s %s\n",
@@ -402,7 +393,7 @@ static void ikm_print_header(struct trace_seq *s)
 
 	trace_seq_printf(s, "%16s %-8s %5s %5s ", " | ", " | ", " | ", " | ");
 
-	if (config_has_id)
+	if (config.has_id)
 		trace_seq_printf(s, "%8s ", " | ");
 
 	trace_seq_printf(s, "%24s   %-24s    %-24s %s\n",
@@ -431,25 +422,25 @@ ikm_event_handler(struct trace_seq *s, struct tep_record *record,
 	int val;
 	bool missing_id;
 
-	if (config_has_id)
+	if (config.has_id)
 		missing_id = tep_get_field_val(s, trace_event, "id", record, &id, 1);
 
 	tep_get_common_field_val(s, trace_event, "common_pid", record, &pid, 1);
 
-	if (config_has_id && (config_my_pid == id))
+	if (config.has_id && (config.my_pid == id))
 		return 0;
-	else if (config_my_pid == pid)
+	else if (config.my_pid == pid)
 		return 0;
 
 	tep_print_event(trace_event->tep, s, record, "%16s-%-8d [%.3d] ",
 			TEP_PRINT_COMM, TEP_PRINT_PID, TEP_PRINT_CPU);
 
-	if (config_is_container)
+	if (config.is_container)
 		tep_print_event(trace_event->tep, s, record, "%s ", TEP_PRINT_NAME);
 	else
 		trace_seq_printf(s, "event ");
 
-	if (config_has_id) {
+	if (config.has_id) {
 		if (missing_id)
 			/* placeholder if we are dealing with a mixed-type container*/
 			trace_seq_printf(s, "        ");
@@ -490,24 +481,24 @@ ikm_error_handler(struct trace_seq *s, struct tep_record *record,
 	int val;
 	bool missing_id;
 
-	if (config_has_id)
+	if (config.has_id)
 		missing_id = tep_get_field_val(s, trace_event, "id", record, &id, 1);
 
 	tep_get_common_field_val(s, trace_event, "common_pid", record, &pid, 1);
 
-	if (config_has_id && config_my_pid == id)
+	if (config.has_id && config.my_pid == id)
 		return 0;
-	else if (config_my_pid == pid)
+	else if (config.my_pid == pid)
 		return 0;
 
 	trace_seq_printf(s, "%8lld [%03d] ", pid, cpu);
 
-	if (config_is_container)
+	if (config.is_container)
 		tep_print_event(trace_event->tep, s, record, "%s ", TEP_PRINT_NAME);
 	else
 		trace_seq_printf(s, "error ");
 
-	if (config_has_id) {
+	if (config.has_id) {
 		if (missing_id)
 			/* placeholder if we are dealing with a mixed-type container*/
 			trace_seq_printf(s, "        ");
@@ -548,8 +539,8 @@ static int ikm_enable_trace_events(char *monitor_name, struct trace_instance *in
 				   ikm_error_handler, NULL);
 
 	/* set if at least 1 monitor has id in case of a container */
-	config_has_id = ikm_has_id(monitor_name);
-	if (config_has_id < 0)
+	config.has_id = ikm_has_id(monitor_name);
+	if (config.has_id < 0)
 		return -1;
 
 
@@ -596,7 +587,7 @@ static struct trace_instance *ikm_setup_trace_instance(char *monitor_name)
 	struct trace_instance *inst;
 	int retval;
 
-	if (!config_trace)
+	if (!config.trace)
 		return NULL;
 
 	/* alloc data */
@@ -610,7 +601,7 @@ static struct trace_instance *ikm_setup_trace_instance(char *monitor_name)
 	if (retval)
 		goto out_free;
 
-	if (config_is_container)
+	if (config.is_container)
 		retval = ikm_enable_trace_container(monitor_name, inst);
 	else
 		retval = ikm_enable_trace_events(monitor_name, inst);
@@ -645,7 +636,7 @@ static void ikm_destroy_trace_instance(struct trace_instance *inst)
 /*
  * ikm_usage_print_reactors - print all available reactors, one per line.
  */
-static void ikm_usage_print_reactors(void)
+void ikm_usage_print_reactors(void)
 {
 	char *reactors = tracefs_instance_file_read(NULL, "rv/available_reactors", NULL);
 	char *start, *end;
@@ -669,106 +660,6 @@ static void ikm_usage_print_reactors(void)
 
 	fprintf(stderr, "\n");
 }
-/*
- * ikm_usage - print usage
- */
-static void ikm_usage(int exit_val, char *monitor_name, const char *fmt, ...)
-{
-
-	char message[1024];
-	va_list ap;
-	int i;
-
-	static const char *const usage[] = {
-		"",
-		"	-h/--help: print this menu and the reactor list",
-		"	-r/--reactor 'reactor': enables the 'reactor'",
-		"	-s/--self: when tracing (-t), also trace rv command",
-		"	-t/--trace: trace monitor's event",
-		"	-v/--verbose: print debug messages",
-		"",
-		NULL,
-	};
-
-	va_start(ap, fmt);
-	vsnprintf(message, sizeof(message), fmt, ap);
-	va_end(ap);
-
-	fprintf(stderr, "  %s\n", message);
-
-	fprintf(stderr, "\n  usage: rv mon %s [-h] [-q] [-r reactor] [-s] [-v]", monitor_name);
-
-	for (i = 0; usage[i]; i++)
-		fprintf(stderr, "%s\n", usage[i]);
-
-	ikm_usage_print_reactors();
-	exit(exit_val);
-}
-
-/*
- * parse_arguments - parse arguments and set config
- */
-static int parse_arguments(char *monitor_name, int argc, char **argv)
-{
-	int c, retval;
-
-	config_my_pid = getpid();
-
-	while (1) {
-		static struct option long_options[] = {
-			{"help",		no_argument,		0, 'h'},
-			{"reactor",		required_argument,	0, 'r'},
-			{"self",		no_argument,		0, 's'},
-			{"trace",		no_argument,		0, 't'},
-			{"verbose",		no_argument,		0, 'v'},
-			{0, 0, 0, 0}
-		};
-
-		/* getopt_long stores the option index here. */
-		int option_index = 0;
-
-		c = getopt_long(argc, argv, "hr:stv", long_options, &option_index);
-
-		/* detect the end of the options. */
-		if (c == -1)
-			break;
-
-		switch (c) {
-		case 'h':
-			ikm_usage(0, monitor_name, "help:");
-			break;
-		case 'r':
-			config_reactor = optarg;
-			break;
-		case 's':
-			config_my_pid = -1;
-			break;
-		case 't':
-			config_trace = 1;
-			break;
-		case 'v':
-			config_debug = 1;
-			break;
-		}
-	}
-
-	if (config_reactor) {
-		config_initial_reactor = ikm_get_current_reactor(monitor_name);
-		if (!config_initial_reactor)
-			ikm_usage(1, monitor_name,
-				  "ikm: failed to read current reactor, are reactors enabled?");
-
-		retval = ikm_write_reactor(monitor_name, config_reactor);
-		if (retval <= 0)
-			ikm_usage(1, monitor_name,
-				  "ikm: failed to set %s reactor, is it available?",
-				  config_reactor);
-	}
-
-	debug_msg("ikm: my pid is %d\n", config_my_pid);
-
-	return 0;
-}
 
 /**
  * ikm_run_monitor - apply configs and run the monitor
@@ -805,9 +696,22 @@ int ikm_run_monitor(char *monitor_name, int argc, char **argv)
 	/* we should be good to go */
 	retval = parse_arguments(full_name, argc, argv);
 	if (retval)
-		ikm_usage(1, nested_name, "ikm: failed parsing arguments");
+		mon_usage(1, nested_name, "ikm: failed parsing arguments");
+
+	if (config.reactor) {
+		config.initial_reactor = ikm_get_current_reactor(full_name);
+		if (!config.initial_reactor)
+			mon_usage(1, full_name,
+				  "ikm: failed to read current reactor, are reactors enabled?");
+
+		retval = ikm_write_reactor(full_name, config.reactor);
+		if (retval <= 0)
+			mon_usage(1, full_name,
+				  "ikm: failed to set %s reactor, is it available?",
+				  config.reactor);
+	}
 
-	if (config_trace) {
+	if (config.trace) {
 		inst = ikm_setup_trace_instance(nested_name);
 		if (!inst)
 			goto out_free_instance;
@@ -817,11 +721,11 @@ int ikm_run_monitor(char *monitor_name, int argc, char **argv)
 	if (retval < 0)
 		goto out_free_instance;
 
-	if (config_trace)
+	if (config.trace)
 		ikm_print_header(inst->seq);
 
 	while (!should_stop()) {
-		if (config_trace) {
+		if (config.trace) {
 			retval = tracefs_iterate_raw_events(inst->tep,
 							    inst->inst,
 							    NULL,
@@ -840,14 +744,14 @@ int ikm_run_monitor(char *monitor_name, int argc, char **argv)
 	ikm_disable(full_name);
 	ikm_destroy_trace_instance(inst);
 
-	if (config_reactor && config_initial_reactor)
-		ikm_write_reactor(full_name, config_initial_reactor);
+	if (config.reactor && config.initial_reactor)
+		ikm_write_reactor(full_name, config.initial_reactor);
 
 	return 1;
 
 out_free_instance:
 	ikm_destroy_trace_instance(inst);
-	if (config_reactor && config_initial_reactor)
-		ikm_write_reactor(full_name, config_initial_reactor);
+	if (config.reactor && config.initial_reactor)
+		ikm_write_reactor(full_name, config.initial_reactor);
 	return -1;
 }
diff --git a/tools/verification/rv/src/utils.c b/tools/verification/rv/src/utils.c
index 5677b439dc2f..e19dd65ec789 100644
--- a/tools/verification/rv/src/utils.c
+++ b/tools/verification/rv/src/utils.c
@@ -5,11 +5,14 @@
  * Copyright (C) 2022 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
  */
 
+#include <getopt.h>
 #include <stdarg.h>
+#include <stdlib.h>
 #include <stdio.h>
+#include <unistd.h>
 #include <utils.h>
 
-int config_debug;
+struct config config;
 
 #define MAX_MSG_LENGTH	1024
 
@@ -36,7 +39,7 @@ void debug_msg(const char *fmt, ...)
 	char message[MAX_MSG_LENGTH];
 	va_list ap;
 
-	if (!config_debug)
+	if (!config.debug)
 		return;
 
 	va_start(ap, fmt);
@@ -45,3 +48,91 @@ void debug_msg(const char *fmt, ...)
 
 	fprintf(stderr, "%s", message);
 }
+
+/*
+ * mon_usage - print usage
+ */
+void mon_usage(int exit_val, char *monitor_name, const char *fmt, ...)
+{
+
+	char message[1024];
+	va_list ap;
+	int i;
+
+	static const char *const usage[] = {
+		"",
+		"	-h/--help: print this menu and the reactor list",
+		"	-r/--reactor 'reactor': enables the 'reactor'",
+		"	-s/--self: when tracing (-t), also trace rv command",
+		"	-t/--trace: trace monitor's event",
+		"	-v/--verbose: print debug messages",
+		"",
+		NULL,
+	};
+
+	va_start(ap, fmt);
+	vsnprintf(message, sizeof(message), fmt, ap);
+	va_end(ap);
+
+	fprintf(stderr, "  %s\n", message);
+
+	fprintf(stderr, "\n  usage: rv mon %s [-h] [-q] [-r reactor] [-s] [-v]", monitor_name);
+
+	for (i = 0; usage[i]; i++)
+		fprintf(stderr, "%s\n", usage[i]);
+
+	ikm_usage_print_reactors();
+	exit(exit_val);
+}
+
+/*
+ * parse_arguments - parse arguments and set config
+ */
+int parse_arguments(char *monitor_name, int argc, char **argv)
+{
+	int c;
+
+	config.my_pid = getpid();
+
+	while (1) {
+		static struct option long_options[] = {
+			{"help",		no_argument,		0, 'h'},
+			{"reactor",		required_argument,	0, 'r'},
+			{"self",		no_argument,		0, 's'},
+			{"trace",		no_argument,		0, 't'},
+			{"verbose",		no_argument,		0, 'v'},
+			{0, 0, 0, 0}
+		};
+
+		/* getopt_long stores the option index here. */
+		int option_index = 0;
+
+		c = getopt_long(argc, argv, "hr:stv", long_options, &option_index);
+
+		/* detect the end of the options. */
+		if (c == -1)
+			break;
+
+		switch (c) {
+		case 'h':
+			mon_usage(0, monitor_name, "help:");
+			break;
+		case 'r':
+			config.reactor = optarg;
+			break;
+		case 's':
+			config.my_pid = -1;
+			break;
+		case 't':
+			config.trace = 1;
+			break;
+		case 'v':
+			config.debug = 1;
+			break;
+		}
+	}
+
+	debug_msg("ikm: my pid is %d\n", config.my_pid);
+
+	return 0;
+}
-- 
2.56.1

