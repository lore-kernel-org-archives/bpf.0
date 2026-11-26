Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698059;
	b=R4y5OfO55QiQESg9iPBD7xrVFDMSRTJtyr5Y8AYwsNjREiqEt8KyLrbAqs3n+ETxetP6
	 W9XiexaGFXJltpAESmceQOEiRVwizhHTmEFWrfPU8GwW+0G09pe1+dTLzHPgmz8pSYSfO
	 Em2uqxtFYiasXKm4atZNWO5LUua5rUsqqH1AbiBUeqoZSh/t1T07nBG5BEh/mPg+bg+CT
	 Pd1V8/ttxY/1BkZA9BJ+Aa9nT0Vp9t7G3/PhE5nhp9HzJQK/rfLTsyRPd4yrwOR4zNqZb
	 4kaKDcxXb/CQxtMJDShEtJUYeW5/penc6TcUh0Vwruy7JmxK7HZAAs3jp/nsJyuTx3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698059;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=zE0J4QpIwg5IzzFAu5Y4rWVJIQvYvQMiA6xWd26mo7U=;
	b=dTr0IeH2oVPbKErJVGLfy42tIVnjYdQgqNovriMSfkqMr8zdiJvjBnwW+SlICcEKBy+X
	 ++U1a4yL9QJXsmv6SzBledUD1dSMG7eXBgsBfEn5TptzDQ/ANrZNVCIxAYquOyTBkI+I9
	 Xb0nrcKBH52++Ymhpg/X8ZoQ0IxO/jse70yihoA9r+cz/zernxKWaHF3N3fj1uxrZCQF0
	 J5Pcs9GNGSeT++RF16xUgvFMeDUSBCtLeVQquZe8iCJAIdHm6a9HQb9nnpyfVZaS3nPuk
	 w3epTE2/XrwBIzpSSBaOz8wdmOwTG6MgtD73XPMEeIKSvfThR/DTPAHu4VoyZzBNyZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TjxVyHKJ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307BE606A329
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 307BE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TjxVyHKJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795698057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zE0J4QpIwg5IzzFAu5Y4rWVJIQvYvQMiA6xWd26mo7U=;
	b=TjxVyHKJ/cqiosfOmaCo0tqbH3FCohub1JH1Z5WnFgrnJ/Rsr70ngJ5XilQ8wcqymiXVJO
	9ybwyKAOuEuoLT3Ii/X+pgtPMliMyYTKusnFOhkuCSA7gPPOaw73tc/ivBZego61r/i4KF
	g7n+zLEKjq2RqcLf1trhnu57EEbf6IY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-yhw7V2xDPyeuUEFGcwh1bA-1; Thu,
 26 Nov 2026 13:00:53 +0000
X-MC-Unique: yhw7V2xDPyeuUEFGcwh1bA-1
X-Mimecast-MFC-AGG-ID: yhw7V2xDPyeuUEFGcwh1bA_1795698051
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 149051800984;
	Thu, 26 Nov 2026 13:00:51 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7B2DB1801A70;
	Thu, 26 Nov 2026 13:00:46 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	John Ogness <john.ogness@linutronix.de>
Subject: [PATCH v3 05/18] rv: Add generic monitor event tracepoints and BPF kfuncs
Date: Thu, 26 Nov 2026 13:59:51 +0100
Message-ID: <20261126130004.127155-6-gmonaco@redhat.com>
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

Add event_monitor and error_monitor tracepoints, carrying a monitor
name and a single formatted message. These tracepoints aim to replace
the per-monitor tracepoints for a set of monitors (now BPF only) and are
generic enough to allow reporting from different monitor classes.

Add also bpf_rv_event_monitor() / bpf_rv_error_monitor() kfuncs wrapping
them, so BPF monitors can emit similar events to in-kernel monitors.

Userspace callers need now to use ftrace filters to get the right events
but events and errors are separate channels to ease the most common
filtering and account for dramatically different volume (errors are
rare).

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/Makefile   |  1 +
 kernel/trace/rv/rv_bpf.c   | 76 ++++++++++++++++++++++++++++++++++++++
 kernel/trace/rv/rv_trace.h | 37 +++++++++++++++++++
 3 files changed, 114 insertions(+)
 create mode 100644 kernel/trace/rv/rv_bpf.c

diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index c895d81dfdad..588250ce3fa9 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -3,6 +3,7 @@
 ccflags-y += -I $(src)		# needed for trace events
 
 obj-$(CONFIG_RV) += rv.o
+obj-$(CONFIG_RV) += rv_bpf.o
 obj-$(CONFIG_RV_MON_WIP) += monitors/wip/wip.o
 obj-$(CONFIG_RV_MON_WWNR) += monitors/wwnr/wwnr.o
 obj-$(CONFIG_RV_MON_SCHED) += monitors/sched/sched.o
diff --git a/kernel/trace/rv/rv_bpf.c b/kernel/trace/rv/rv_bpf.c
new file mode 100644
index 000000000000..f39f33335c71
--- /dev/null
+++ b/kernel/trace/rv/rv_bpf.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BPF kfuncs for Runtime Verification (RV)
+ */
+
+#include <linux/init.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <rv_trace.h>
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_rv_event_monitor - emit an RV monitor event tracepoint
+ *
+ * @msg must be NULL-terminated, drop the event if it isn't. This happens by
+ * construction if using snprintf-like functions and passing the right @msg__sz
+ * to both.
+ *
+ * @mon__str: name of the monitor
+ * @msg: message string
+ * @msg__sz: message string size
+ *
+ * Return -EINVAL if @msg is not NULL-terminated, 0 otherwise.
+ */
+__bpf_kfunc int bpf_rv_event_monitor(const char *mon__str, const int *id__nullable,
+				     const char *msg, u32 msg__sz)
+{
+	if (strnlen(msg, msg__sz) == msg__sz)
+		return -EINVAL;
+
+	trace_event_monitor(mon__str, id__nullable, msg);
+	return 0;
+}
+
+/**
+ * bpf_rv_error_monitor - emit an RV monitor error tracepoint
+ *
+ * @msg must be NULL-terminated, drop the event if it isn't. This happens by
+ * construction if using snprintf-like functions and passing the right @msg__sz
+ * to both.
+ *
+ * @mon__str: name of the monitor
+ * @msg: message string
+ * @msg__sz: message string size
+ *
+ * Return -EINVAL if @msg is not NULL-terminated, 0 otherwise.
+ */
+__bpf_kfunc int bpf_rv_error_monitor(const char *mon__str, const int *id__nullable,
+				     const char *msg, u32 msg__sz)
+{
+	if (strnlen(msg, msg__sz) == msg__sz)
+		return -EINVAL;
+
+	trace_error_monitor(mon__str, id__nullable, msg);
+	return 0;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_rv_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_rv_event_monitor)
+BTF_ID_FLAGS(func, bpf_rv_error_monitor)
+BTF_KFUNCS_END(bpf_rv_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_rv_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &bpf_rv_kfunc_ids,
+};
+
+static int __init bpf_rv_kfunc_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_rv_kfunc_set);
+}
+late_initcall(bpf_rv_kfunc_init);
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 24d4b94a54a5..9fa9e1230e84 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -292,6 +292,43 @@ DECLARE_EVENT_CLASS(error_ltl_monitor_id,
 // Add new monitors based on CONFIG_LTL_MON_EVENTS_ID here
 #endif /* CONFIG_LTL_MON_EVENTS_ID */
 
+DECLARE_EVENT_CLASS(event_template_monitor,
+
+	TP_PROTO(const char *mon, const int *id, const char *msg),
+
+	TP_ARGS(mon, id, msg),
+
+	TP_STRUCT__entry(
+		__string(	mon,	mon	)
+		__field(	u8,	has_id	)
+		__field(	int,	id	)
+		__string(	msg,	msg	)
+	),
+
+	TP_fast_assign(
+		__assign_str(mon);
+		__entry->has_id = !!id;
+		__entry->id = id ? *id : 0;
+		__assign_str(msg);
+	),
+
+	/*
+	 * The id is used only for filters, if it is of interest in the format,
+	 * callers should pass it to the msg too.
+	 */
+	TP_printk("%s: %s",
+		__get_str(mon),
+		__get_str(msg))
+);
+
+DEFINE_EVENT(event_template_monitor, event_monitor,
+	TP_PROTO(const char *mon, const int *id, const char *msg),
+	TP_ARGS(mon, id, msg));
+
+DEFINE_EVENT(event_template_monitor, error_monitor,
+	TP_PROTO(const char *mon, const int *id, const char *msg),
+	TP_ARGS(mon, id, msg));
+
 #ifdef CONFIG_RV_MON_MAINTENANCE_EVENTS
 /* Tracepoint useful for monitors development, currenly only used in DA */
 TRACE_EVENT(rv_retries_error,
-- 
2.56.1

