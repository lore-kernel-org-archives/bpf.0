Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14CD413226
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086212; cv=none; b=CB+ZZVZvgeFW54XD6ty0g9AXq3kIqnzmKlIVoc1mhBghdhDOcTRJ+5mNOejcKUA+FX1xpHU8giHI1G3ha+YtZirSoIVdd2cXUaJy5WiD/EophlYGa36eSJqn+K4FUhhB4Hl1tFZVPVA5MaBOhQflsz8YGoFDooV+IE+pE/FHpY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086212; c=relaxed/simple;
	bh=25QRI58pZ1JTfSGcElEYgd7VnRw3AMhuvcJzOeSGTsQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbKD+ccm0TpMJ44ANpJRV6nbUQGCgwub9gZ2R635t/yF6u5QcFqzb5ZfvgTYqSQkgitfOnPGgPwqXcJVemAPPWwsEZXHObx1g4PAQ52Mm0wqt1nRfk1oRemSJ/a4+r8xPTNl62CPB/C3ZzzVZc5EamRS0QXGVeOvqQvTir7ag4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ftza+sHn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftza+sHn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773086210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RDq7zVRdZ8sP6j9D2aPFPVXMk92dd+FqieVgaPz5GP8=;
	b=ftza+sHnDC5bZog0urE7Irj4QQc+sPnA7obYT6o/xOzaK2eNIqI1WUmFe8+gFkpWJ1gPsh
	Z6lAUhzcx9txUV2AiF75uCaJ7urbTtldpcjXpm4DFacJr9/fvbBfLKBdEBawyQYtvw9Px6
	9/p5fCH2lmThE3TgREKY4KcfNBl2xzg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-R06WQcTAPiyl6XVz0u0gWw-1; Mon,
 09 Mar 2026 15:56:43 -0400
X-MC-Unique: R06WQcTAPiyl6XVz0u0gWw-1
X-Mimecast-MFC-AGG-ID: R06WQcTAPiyl6XVz0u0gWw_1773086200
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3BB971800365;
	Mon,  9 Mar 2026 19:56:40 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.81.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 71BD03002D0D;
	Mon,  9 Mar 2026 19:56:35 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v4 05/18] rtla: Replace magic number with MAX_PATH
Date: Mon,  9 Mar 2026 16:46:18 -0300
Message-ID: <20260309195040.1019085-6-wander@redhat.com>
In-Reply-To: <20260309195040.1019085-1-wander@redhat.com>
References: <20260309195040.1019085-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The trace functions use a buffer to manipulate strings that will be
written to tracefs files. These buffers are defined with a magic number
of 1024, which is a common source of vulnerabilities.

Replace the magic number 1024 with the MAX_PATH macro to make the code
safer and more readable. While at it, replace other instances of the
magic number with ARRAY_SIZE() when the buffer is locally defined.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/osnoise.c    |  2 +-
 tools/tracing/rtla/src/timerlat_u.c |  4 ++--
 tools/tracing/rtla/src/trace.c      | 20 ++++++++++----------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index ec074cd53dd84..9d1fd9981fe91 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -62,7 +62,7 @@ int osnoise_set_cpus(struct osnoise_context *context, char *cpus)
 	if (!context->curr_cpus)
 		return -1;
 
-	snprintf(buffer, 1024, "%s\n", cpus);
+	snprintf(buffer, ARRAY_SIZE(buffer), "%s\n", cpus);
 
 	debug_msg("setting cpus to %s from %s", cpus, context->orig_cpus);
 
diff --git a/tools/tracing/rtla/src/timerlat_u.c b/tools/tracing/rtla/src/timerlat_u.c
index ce68e39d25fde..efe2f72686486 100644
--- a/tools/tracing/rtla/src/timerlat_u.c
+++ b/tools/tracing/rtla/src/timerlat_u.c
@@ -32,7 +32,7 @@
 static int timerlat_u_main(int cpu, struct timerlat_u_params *params)
 {
 	struct sched_param sp = { .sched_priority = 95 };
-	char buffer[1024];
+	char buffer[MAX_PATH];
 	int timerlat_fd;
 	cpu_set_t set;
 	int retval;
@@ -83,7 +83,7 @@ static int timerlat_u_main(int cpu, struct timerlat_u_params *params)
 
 	/* add should continue with a signal handler */
 	while (true) {
-		retval = read(timerlat_fd, buffer, 1024);
+		retval = read(timerlat_fd, buffer, ARRAY_SIZE(buffer));
 		if (retval < 0)
 			break;
 	}
diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 211ca54b15b0e..e1af54f9531b8 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -313,7 +313,7 @@ void trace_event_add_trigger(struct trace_events *event, char *trigger)
 static void trace_event_disable_filter(struct trace_instance *instance,
 				       struct trace_events *tevent)
 {
-	char filter[1024];
+	char filter[MAX_PATH];
 	int retval;
 
 	if (!tevent->filter)
@@ -325,7 +325,7 @@ static void trace_event_disable_filter(struct trace_instance *instance,
 	debug_msg("Disabling %s:%s filter %s\n", tevent->system,
 		  tevent->event ? : "*", tevent->filter);
 
-	snprintf(filter, 1024, "!%s\n", tevent->filter);
+	snprintf(filter, ARRAY_SIZE(filter), "!%s\n", tevent->filter);
 
 	retval = tracefs_event_file_write(instance->inst, tevent->system,
 					  tevent->event, "filter", filter);
@@ -344,7 +344,7 @@ static void trace_event_save_hist(struct trace_instance *instance,
 {
 	int retval, index, out_fd;
 	mode_t mode = 0644;
-	char path[1024];
+	char path[MAX_PATH];
 	char *hist;
 
 	if (!tevent)
@@ -359,7 +359,7 @@ static void trace_event_save_hist(struct trace_instance *instance,
 	if (retval)
 		return;
 
-	snprintf(path, 1024, "%s_%s_hist.txt", tevent->system, tevent->event);
+	snprintf(path, ARRAY_SIZE(path), "%s_%s_hist.txt", tevent->system, tevent->event);
 
 	printf("  Saving event %s:%s hist to %s\n", tevent->system, tevent->event, path);
 
@@ -391,7 +391,7 @@ static void trace_event_save_hist(struct trace_instance *instance,
 static void trace_event_disable_trigger(struct trace_instance *instance,
 					struct trace_events *tevent)
 {
-	char trigger[1024];
+	char trigger[MAX_PATH];
 	int retval;
 
 	if (!tevent->trigger)
@@ -405,7 +405,7 @@ static void trace_event_disable_trigger(struct trace_instance *instance,
 
 	trace_event_save_hist(instance, tevent);
 
-	snprintf(trigger, 1024, "!%s\n", tevent->trigger);
+	snprintf(trigger, ARRAY_SIZE(trigger), "!%s\n", tevent->trigger);
 
 	retval = tracefs_event_file_write(instance->inst, tevent->system,
 					  tevent->event, "trigger", trigger);
@@ -444,7 +444,7 @@ void trace_events_disable(struct trace_instance *instance,
 static int trace_event_enable_filter(struct trace_instance *instance,
 				     struct trace_events *tevent)
 {
-	char filter[1024];
+	char filter[MAX_PATH];
 	int retval;
 
 	if (!tevent->filter)
@@ -456,7 +456,7 @@ static int trace_event_enable_filter(struct trace_instance *instance,
 		return 1;
 	}
 
-	snprintf(filter, 1024, "%s\n", tevent->filter);
+	snprintf(filter, ARRAY_SIZE(filter), "%s\n", tevent->filter);
 
 	debug_msg("Enabling %s:%s filter %s\n", tevent->system,
 		  tevent->event ? : "*", tevent->filter);
@@ -479,7 +479,7 @@ static int trace_event_enable_filter(struct trace_instance *instance,
 static int trace_event_enable_trigger(struct trace_instance *instance,
 				      struct trace_events *tevent)
 {
-	char trigger[1024];
+	char trigger[MAX_PATH];
 	int retval;
 
 	if (!tevent->trigger)
@@ -491,7 +491,7 @@ static int trace_event_enable_trigger(struct trace_instance *instance,
 		return 1;
 	}
 
-	snprintf(trigger, 1024, "%s\n", tevent->trigger);
+	snprintf(trigger, ARRAY_SIZE(trigger), "%s\n", tevent->trigger);
 
 	debug_msg("Enabling %s:%s trigger %s\n", tevent->system,
 		  tevent->event ? : "*", tevent->trigger);
-- 
2.53.0

