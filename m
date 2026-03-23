Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4047537F8AC;
	Mon, 23 Mar 2026 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266432; cv=none; b=Oh/XllPzqLyMbRdwwGLk3jPThAQj+fAX3FxUx77C8qx4nihaO8wPTJYvQt8sm931h5Z9MZRcxLHNxWgm0jiPzDzINgM5rtLeu+sKjomWgzY4UNmMVS7zfQOsDWM4tE+CNB6ywivTLVTh1oVRFKEddWV+gCrmmSdAHSCgZ36UrDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266432; c=relaxed/simple;
	bh=lZCVThDM3BRzRypb31rGuUdpQI1V8CmxbHfPeXSGayY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=knjxTvbvf9YoZeGBXyIXkyJ5eSz248kg96ZUK5+9sRz7p0ehqn5g1E8ZWLRpwh7YsL7ya9YprjbOKJApRtJ1MugsHBAZcU1I0diso9QwsS4NwtMv+tcHxizU2kr7uFwvwma2hFbcc4poTmBqb6wyOYqOHTL0VPNQMyUz2KH4oec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=oEU9xOum; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="oEU9xOum"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=zq/3dGnYBusKmmjNVvDaRg0ULStVV+ED9EfjGhr4+wo=; b=oEU9xOum35YSOD/0KH+rNTxxop
	Br3mPQ4ADG04W4RYayaK4LkEBUobGk4HlELj83jzYxI3u3McZ3PLER5kp6wb6CAl3mtdtJv3nOt1u
	zEkjl7/3kAVuW2o5ttKc1LZWuGXCbMyz8OGRLU19X6rJ3X6xsxNu+n/LplIU2oujgCg9bpHm+tlD/
	cnft2Uuab52H477awJDc3O2URKANpa0dO8RuGTfFiYCB9B+gOqzr769q1/7fXkrb7UsC9PzQXUaov
	tuvBV4/6PwGBNmRwbLACli80K9eaPFLjFZbZi/+AzO5TziskBMyo4wxhrpBYZ+ig18quXAeE4DS0U
	X8gx+4sQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w4dkQ-007VXT-Ut; Mon, 23 Mar 2026 11:47:06 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 23 Mar 2026 04:46:27 -0700
Subject: [PATCH v2] coredump: add tracepoint for coredump events
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-coredump_tracepoint-v2-1-afced083b38d@debian.org>
X-B4-Tracking: v=1; b=H4sIABMowWkC/32NSwqDMBQArxLe2hTzIa2ueo8ixSSv+gpNJInSI
 t69aPddDgwzK2RMhBlatkLChTLFAC2TFQM39mFATh5aBrKWplay5i4m9PNrupfUO5wihcK1R62
 axqGwBioGU8IHvY/qrftxnu0TXdlTuzFSLjF9ju0idu//YRFccKUvRp+1cdaqq0dLfTjFNEC3b
 dsXe/X/7skAAAA=
X-Change-ID: 20260320-coredump_tracepoint-4de4399ce1b6
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 kernel-team@meta.com, song@kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-3673a
X-Developer-Signature: v=1; a=openpgp-sha256; l=4327; i=leitao@debian.org;
 h=from:subject:message-id; bh=lZCVThDM3BRzRypb31rGuUdpQI1V8CmxbHfPeXSGayY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpwSg1HPrGxrfr/seGh+FXDPoCtNQ87qgBh3Wdz
 AryDGSagySJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCacEoNQAKCRA1o5Of/Hh3
 bR5FD/sGWRUetzAgEYMIxWLj5oeVglBvntz82YsMf8/9x1Z5pk72rfnoau+oUr2BLN9hqMaH+/3
 ADiTTa39cwJAckwoEkrE5zxCQ7a5R16P8UxamXJlQRA+/mowJIIDb95YUW97Tgv+6rwepveZiaN
 uj49ETDZvBGh7hpt2UW4wa4xuojgjptCSnt0o8fBq0/DRPn2wgnP38/jCyLMgpdWikZ/wCsK4fi
 tFZUVmFulJC97IkmigAW/RyzsvmW0we8GXUtLXKFrfA0XtMYLPVSzYDgS7X29coRpxXBk8SpnSC
 cUILKIlb1XCjC9kQE//11OOrdSHultoWonHk6Wf+lGQBRogKCGQQWCrX/HAK+sb5rF3KAgA2w+1
 VGbKeguNrj5hqlMonZJSqZJyancu7l/mXvJavaNNkUu8Le+QmJktt2P65CUYERxpVa7HKglaC5I
 LA+thD4Q0kqofg3oq5X7WIbLvcGi491BZbUzpDpV4Lck26p1vhIeblYBGIlFjKgqxitdz5aK07U
 +VWkUMP86FbhjH97uBnZqop4x4tdi16w1G2TKX/KXc+GzG7qtIg2TesHzhbaPVFqcps5/z4tJ3z
 qlJyy3a5CV3t8+GMPoca+Kpz+KIDhpwOS6NwzYKSJpqI2vAAAUFsxuwUaMBRkKjCXSytLNy1/nz
 /gbt3ClyPzDDOIg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Coredump is a generally useful and interesting event in the lifetime
of a process. Add a tracepoint so it can be monitored through the
standard kernel tracing infrastructure.

BPF-based crash monitoring is an advanced approach that
allows real-time crash interception: by attaching a BPF program at
this point, tools can use bpf_get_stack() with BPF_F_USER_STACK to
capture the user-space stack trace at the exact moment of the crash,
before the process is fully terminated, without waiting for a
coredump file to be written and parsed.

However, there is currently no stable kernel API for this use case.
Existing tools rely on attaching fentry probes to do_coredump(),
which is an internal function whose signature changes across kernel
versions, breaking these tools.

Add a stable tracepoint that fires at the beginning of
do_coredump(), providing BPF programs a reliable attachment point.
At tracepoint time, the crashing process context is still live, so
BPF programs can call bpf_get_stack() with BPF_F_USER_STACK to
extract the user-space backtrace.

The tracepoint records:
  - sig: signal number that triggered the coredump
  - comm: process name

Example output:

  $ echo 1 > /sys/kernel/tracing/events/coredump/coredump/enable
  $ sleep 999 &
  $ kill -SEGV $!
  $ cat /sys/kernel/tracing/trace
  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
  #              | |         |   |||||     |         |
             sleep-634     [036] .....   145.222206: coredump: sig=11 comm=sleep

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Remove the pid from the tracpoint message, given pid is saved in all
  trace events (Christian, Steven)
- Link to v1:
  https://patch.msgid.link/20260320-coredump_tracepoint-v1-1-34864746cbb3@debian.org
---
 fs/coredump.c                   |  5 +++++
 include/trace/events/coredump.h | 45 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 29df8aa19e2e7..bb6fdb1f458e9 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -63,6 +63,9 @@
 
 #include <trace/events/sched.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/coredump.h>
+
 static bool dump_vma_snapshot(struct coredump_params *cprm);
 static void free_vma_snapshot(struct coredump_params *cprm);
 
@@ -1090,6 +1093,8 @@ static inline bool coredump_skip(const struct coredump_params *cprm,
 static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
 			size_t **argv, int *argc, const struct linux_binfmt *binfmt)
 {
+	trace_coredump(cprm->siginfo->si_signo);
+
 	if (!coredump_parse(cn, cprm, argv, argc)) {
 		coredump_report_failure("format_corename failed, aborting core");
 		return;
diff --git a/include/trace/events/coredump.h b/include/trace/events/coredump.h
new file mode 100644
index 0000000000000..c7b9c53fc4986
--- /dev/null
+++ b/include/trace/events/coredump.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2026 Breno Leitao <leitao@debian.org>
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM coredump
+
+#if !defined(_TRACE_COREDUMP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_COREDUMP_H
+
+#include <linux/sched.h>
+#include <linux/tracepoint.h>
+
+/**
+ * coredump - called when a coredump starts
+ * @sig: signal number that triggered the coredump
+ *
+ * This tracepoint fires at the beginning of a coredump attempt,
+ * providing a stable interface for monitoring coredump events.
+ */
+TRACE_EVENT(coredump,
+
+	TP_PROTO(int sig),
+
+	TP_ARGS(sig),
+
+	TP_STRUCT__entry(
+		__field(int, sig)
+		__array(char, comm, TASK_COMM_LEN)
+	),
+
+	TP_fast_assign(
+		__entry->sig = sig;
+		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+	),
+
+	TP_printk("sig=%d comm=%s",
+		  __entry->sig, __entry->comm)
+);
+
+#endif /* _TRACE_COREDUMP_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>

---
base-commit: b5d083a3ed1e2798396d5e491432e887da8d4a06
change-id: 20260320-coredump_tracepoint-4de4399ce1b6

Best regards,
--  
Breno Leitao <leitao@debian.org>

