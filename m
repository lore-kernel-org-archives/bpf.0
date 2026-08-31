Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FD43DE448
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167271; cv=none; b=NvG1xEcKN33KCj89k0+EtJYDmLS/sGVCj+8sKAN/Pwry7pdxYFMi/YQUtPy74pqkbSgUXNpQEUNaKQaysenAJCitst+3AaY8T/IgXCCyCrqaU1ykHp7ASX6eA7vRujRgXIflGI4FLFcM4pKbS8zdFW7gIwMqBe8X9M8prykF7MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167271; c=relaxed/simple;
	bh=LWVvoYDOjwXs2EC7A13p00+8P6+MboEh6Gx+JUd1pDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsZoa2NrG8Ti03AVt41uP+ZZYcSSpHufyG7I9agTSgwHNxY12YSCCanHAEwKk/LjMxbj6Bj/HrJYk2PR0F/VV6Cnukk4vCmjZy367fWjcFG93MZX1zfyc5D+Du5fUNeDkvR1TeKtKonueBK3fUkJ6fuvbDXKCgtqJ+HHEZzJHb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QpoTKszz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpoTKszz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788167268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48qH1PP4jCa06+axLa6Y0uRn+3AU5SUX8PUnznpl2do=;
	b=QpoTKszzSupZnxF59SRIJqJ4cwDuvrtBEadfpK/2AXGdzMygSjuvaW0qor4kF8OTARfmr3
	uSTAHqlC6cdZXRqUvgHtmQZ6xW0S3W5xPvvfCaEExC5MM6TR9evb1UJdG3F9RgCSokHFI2
	WLiP3I7dyeDKwRmkLU6ZYEnaklxPYG4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-VAhD7_5VO2ig7e2GI0AwHg-1; Mon,
 31 Aug 2026 05:07:46 -0400
X-MC-Unique: VAhD7_5VO2ig7e2GI0AwHg-1
X-Mimecast-MFC-AGG-ID: VAhD7_5VO2ig7e2GI0AwHg_1788167264
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3343193E889;
	Mon, 31 Aug 2026 09:07:44 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BEA8A180034F;
	Mon, 31 Aug 2026 09:07:41 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [RFC PATCH 12/20] tools/rv: Export functionality for in_kernel monitors
Date: Mon, 31 Aug 2026 11:05:16 +0200
Message-ID: <20260831090524.106845-13-gmonaco@redhat.com>
In-Reply-To: <20260831090524.106845-1-gmonaco@redhat.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Export enable/disable and reactor set/reset functionality from in-kernel
monitor to be used by other compatible monitor types (BPF).
Use helpers to simplify the reactor set/reset actions.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/include/in_kernel.h |  5 ++
 tools/verification/rv/src/in_kernel.c     | 61 ++++++++++++++++-------
 2 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/tools/verification/rv/include/in_kernel.h b/tools/verification/rv/include/in_kernel.h
index f3bfd3b9895f..16d68caa84bd 100644
--- a/tools/verification/rv/include/in_kernel.h
+++ b/tools/verification/rv/include/in_kernel.h
@@ -1,3 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 int ikm_list_monitors(char *container);
 int ikm_run_monitor(char *monitor, int argc, char **argv);
+int __ikm_read_enable(char *monitor_name);
+int ikm_enable(char *monitor_name);
+int ikm_disable(char *monitor_name);
+void ikm_set_reactor(char *monitor_name);
+void ikm_reset_reactor(char *monitor_name);
diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index 90c340a73c76..3e8272d55a3a 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -23,7 +23,7 @@
  * Returns the current status, or -1 if the monitor does not exist,
  * __hence not logging errors.
  */
-static int __ikm_read_enable(char *monitor_name)
+int __ikm_read_enable(char *monitor_name)
 {
 	char path[MAX_PATH];
 	long long enabled;
@@ -132,7 +132,7 @@ static int ikm_write_enable(char *monitor_name, char *enable_disable)
  *
  * Returns -1 on failure. Success otherwise.
  */
-static int ikm_enable(char *monitor_name)
+int ikm_enable(char *monitor_name)
 {
 	return ikm_write_enable(monitor_name, "1");
 }
@@ -142,7 +142,7 @@ static int ikm_enable(char *monitor_name)
  *
  * Returns -1 on failure. Success otherwise.
  */
-static int ikm_disable(char *monitor_name)
+int ikm_disable(char *monitor_name)
 {
 	return ikm_write_enable(monitor_name, "0");
 }
@@ -304,6 +304,42 @@ static char *ikm_get_current_reactor(char *monitor_name)
 	return curr_reactor;
 }
 
+/*
+ * ikm_set_reactor - set the configured reactor and store the initial one
+ *
+ * Do nothing if we should not set reactors.
+ */
+void ikm_set_reactor(char *monitor_name)
+{
+	int retval;
+
+	if (!config.reactor)
+		return;
+
+	config.initial_reactor = ikm_get_current_reactor(monitor_name);
+	if (!config.initial_reactor)
+		mon_usage(1, monitor_name,
+			  "ikm: failed to read current reactor, are reactors enabled?");
+
+	retval = ikm_write_reactor(monitor_name, config.reactor);
+	if (retval <= 0)
+		mon_usage(1, monitor_name,
+			  "ikm: failed to set %s reactor, is it available?",
+			  config.reactor);
+
+}
+
+/*
+ * ikm_reset_reactor - restore the initially stored reactor
+ *
+ * Do nothing if we should not set reactors.
+ */
+void ikm_reset_reactor(char *monitor_name)
+{
+	if (config.reactor && config.initial_reactor)
+		ikm_write_reactor(monitor_name, config.initial_reactor);
+}
+
 static int ikm_has_id(char *monitor_name)
 {
 	char path[MAX_PATH];
@@ -698,18 +734,7 @@ int ikm_run_monitor(char *monitor_name, int argc, char **argv)
 	if (retval)
 		mon_usage(1, nested_name, "ikm: failed parsing arguments");
 
-	if (config.reactor) {
-		config.initial_reactor = ikm_get_current_reactor(full_name);
-		if (!config.initial_reactor)
-			mon_usage(1, full_name,
-				  "ikm: failed to read current reactor, are reactors enabled?");
-
-		retval = ikm_write_reactor(full_name, config.reactor);
-		if (retval <= 0)
-			mon_usage(1, full_name,
-				  "ikm: failed to set %s reactor, is it available?",
-				  config.reactor);
-	}
+	ikm_set_reactor(full_name);
 
 	if (config.trace) {
 		inst = ikm_setup_trace_instance(nested_name);
@@ -744,14 +769,12 @@ int ikm_run_monitor(char *monitor_name, int argc, char **argv)
 	ikm_disable(full_name);
 	ikm_destroy_trace_instance(inst);
 
-	if (config.reactor && config.initial_reactor)
-		ikm_write_reactor(full_name, config.initial_reactor);
+	ikm_reset_reactor(full_name);
 
 	return 1;
 
 out_free_instance:
 	ikm_destroy_trace_instance(inst);
-	if (config.reactor && config.initial_reactor)
-		ikm_write_reactor(full_name, config.initial_reactor);
+	ikm_reset_reactor(full_name);
 	return -1;
 }
-- 
2.55.0

