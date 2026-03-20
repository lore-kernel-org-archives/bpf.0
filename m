Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEB53A5E73;
	Fri, 20 Mar 2026 12:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774010039; cv=none; b=IU4kvxLkRqHPOut9KatbPhS8SEIXtyUxsKZbAumZkjYCBwkcNd4K9pWDYgclbua9ivGr+7hf1hjGNTDyt7w0UHf3xulMBPnwb8/x76eXfAoevX6E7HBLQB5P5wk7o2LWmV85iAdOSYOHebPK1KNCIHFraadAc72yxUxoOqcuqOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774010039; c=relaxed/simple;
	bh=W517fSuK7qIKfoSoz6yuhfj99SSpOcghQQhJDRTMM5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mfnuXs8JH6Sl6OiArQydNQMkF1ZBHNLPBW0CcniHl3vzVmpSsSBmRIbxad3pPS94VEqmsA0kBYKs0sZ14wa6Z6pjUXPcSKuGCrtg8h3T4o8bEf8WCRf22IT2lYjwUEYXjIPnlb2+suhGukufWY3yjsHooxPEbHW32faamGe8+5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=nQDB/FGl; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="nQDB/FGl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=pkZcwqjPdD2XzUzCM0n8fOxwlXP6XDppxgLEqdtgcNg=; b=nQDB/FGlTKHYHaEc4hnSR300X9
	X8wqdW7LSAukeTY174pls2+JD1e0rZrh0iDNM7ePsnp7KBR4yepypeNWI0OVpEpYngumJIBsj7llQ
	hi8BgklnMcNFPR1vQZBGcsBTzZcXprfcNgj9HtehLKBFh/MnUypHRx9a0kxjM5N2QOYiE8MUGShfm
	Yh3SWgTG1HOBCdSJVXVPxYNMkc/9Mb4M5icrbGIhXJNaQunp/GD3e57OXbzllGuB4ScXO+D+VrMNL
	5//rb/Ez7I+vyglv5l4surId2cUwGq44i9FupluBjY9lS7FX5V3uPwZkMhOpaGWTs7Syc/8J04gY2
	qoE5VX3Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w3Z32-005CqL-5o; Fri, 20 Mar 2026 12:33:51 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 20 Mar 2026 05:33:34 -0700
Subject: [PATCH] coredump: add tracepoint for coredump events
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-coredump_tracepoint-v1-1-34864746cbb3@debian.org>
X-B4-Tracking: v=1; b=H4sIAJ4+vWkC/yXMQQrCMBAF0KsMs24gTUuhuYqItJOvjmASklSE0
 ruLunybt3NFUVT2tHPBS6umyJ76jljuS7zBaGBP7Kyb7OCskVQQtme+tLIIctLYzBgwDvMs6Ne
 JO+JccNX3bz2d/67b+oC0b8XH8QHIsQMLdwAAAA==
X-Change-ID: 20260320-coredump_tracepoint-4de4399ce1b6
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 kernel-team@meta.com, Andrii Nakryiko <andrii@kernel.org>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-363b9
X-Developer-Signature: v=1; a=openpgp-sha256; l=4205; i=leitao@debian.org;
 h=from:subject:message-id; bh=W517fSuK7qIKfoSoz6yuhfj99SSpOcghQQhJDRTMM5k=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpvT6qGl8C1U+sBdXcjEGYInO3jwJDU/5bqvCF8
 HjnXiwL+8GJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCab0+qgAKCRA1o5Of/Hh3
 bQ9fD/9oujRZ6DOL6hNBBy3J8oe8ZTwZMl0BiVdAbic+F+KaS0rCQvqWLy9gxFie5CXJeDXnovr
 aNDIs4E6Y1A6ITtEwQlEnWB3eoPZFpFk2N45xDmqb3LIVPS+a9+VksUAuI3XpxHne6xRUBut308
 GfGUAcLfcv0JYuNTIJk8HFhQPxGV5fTUu5DuiimrSsA/MenNwxL3ryLMD+/b2+A1Jv1ZxRBtfts
 4CmnRZvsPVQxNefslIfzXGyWztsjKhCjgjuioV9md8OfeWt41RIilJJd86hWVBgoU+IqwsJSfLa
 zx1m1z1pfw0pucmnmNAOrE2vCkFEecPvLCGHlIKQbVASznM6x0ghSk1ekgvZB4xbMOylE+Gw8OH
 tn1HsDnHfjUwDFsHJrrSooaVh2X3NvyQUXuD4PMITT+YDZAKzWxdCJdDoKLTVtzfPIgNqWt4k7y
 nzGxAsAAK7PY9NEgf0BjPfbfjhQWWCQP7qIOWX0JNtq7zBgZt5mripP4Q9KU7eyMtHD2F+vAKE0
 kRcY9PIUrIFZ1lrSCbXpgY0kX3j5bDKVgl3ypu8KJ+o/OVXZrIARinXpygla52z06EJyeVpHQN6
 bfBw9CrLZtD67ovnB3mgjDk9YhaaODyDxhcRyAyMYylQe7ZkZ2ZARKxsxgA+ZgDWI7Pgsromhw9
 qIYpOS+BGz7ZnkA==
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
  - pid: process PID

Example output:

  $ echo 1 > /sys/kernel/tracing/events/coredump/coredump/enable
  $ sleep 999 &
  $ kill -SEGV $!
  $ cat /sys/kernel/tracing/trace
  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
  #              | |         |   |||||     |         |
             sleep-634     [036] .....   145.222206: coredump: sig=11 comm=sleep pid=634

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 fs/coredump.c                   |  5 +++++
 include/trace/events/coredump.h | 47 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

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
index 0000000000000..59617eba3dbcf
--- /dev/null
+++ b/include/trace/events/coredump.h
@@ -0,0 +1,47 @@
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
+		__field(pid_t, pid)
+	),
+
+	TP_fast_assign(
+		__entry->sig = sig;
+		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		__entry->pid = current->pid;
+	),
+
+	TP_printk("sig=%d comm=%s pid=%d",
+		  __entry->sig, __entry->comm, __entry->pid)
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

