Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.154.239.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300347;
	b=CorfllNirPEOcBD/DyEAO4JgLSexu1S71O4tLMl+13OWrH96z6IzJnbnmhHx1ECqyjCF
	 jrItctU429QwkOGvWGHphJLPJHOLiWPIdlEGZ+BI4uWWUPQe3CC9z0XWWp9yZgVt+koyU
	 FsCmxxe+mq57dJ+6UDnHqLdgPur7841QQQ9BBTG7XyZ8YAwGrJDUh4i8hZNUTT47fkiv8
	 7dvXRymhw3W/EMrb7oGv30WZvAycNAmBWTvfCs45QImVNZDico0M/89QNCUHtmx/7gr70
	 prV2oiFmTwaExPDm9u0Qjg9L7dcXeIGFE7z/v036a5v6MZSCQLVnyUcBJkpp+bNvQNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300347;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UfCr7SMBp2MWLVqMbTLms5eQnif5CMZeedqFoCGKq5U=;
	b=LE3PSVpnYwT7h3N65UaxqCZbgvdpOw6tkX18I4sVGRVJxCPgghQtdcaGpO/hGLTqo8TR
	 hrWCHR3QAygCFIksLaKPpm1TqT0AflKQ0Ysyj+tTzALyfmeFjREmairQsRhy5mKJ6Hw5Q
	 pYgH3HK9ZHqK4xLVIyoN2pqcF1Hak4l+7t05YfVsDjztycjJ3w7dAcnKvHmWCbUIn33iQ
	 sL97ZgNOooTV5fkNDl6qEmxvj/j++lUHiHqjm+oxJVwXPrpFaHQL0RY5XzQ6B4YAfCNT1
	 SOK3kUjT+fGWFME2lMzAWK2SVewT+L73LkgGj9IT2GGpvkqcQI7t/0tMNpIV55rYhJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.com;
	spf=pass smtp.mailfrom=yandex.com;
	dkim=pass header.d=yandex.com header.i=@yandex.com header.a=rsa-sha256 header.s=mail header.b=l84f8WVn;
	arc=none smtp.remote-ip=178.154.239.223
Received: from forward400d.mail.yandex.net (forward400d.mail.yandex.net [178.154.239.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFE7606A320;
	Thu, 29 Oct 2026 18:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDFE7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.com header.i=@yandex.com header.a=rsa-sha256 header.s=mail header.b=l84f8WVn
Received: from mail-nwsmtp-smtp-production-main-89 (unknown [IPv6:2a02:6b8:c0c:1f29:0:640:95da:0])
	by forward400d.mail.yandex.net (postfix) with ESMTPS id 3F3DE81375;
	Thu, 29 Oct 2026 21:58:56 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-89 with ESMTPSA id nwoaPAGntOs0-SbXmwiTF;
	Thu, 29 Oct 2026 21:58:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
	t=1793300334; bh=UfCr7SMBp2MWLVqMbTLms5eQnif5CMZeedqFoCGKq5U=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=l84f8WVnf0WHjjRwv2BsHGMCY32Tq9OY+zOcb7WWDKUREDKTCRetEM9eTAiV5mTi6
	 y4CEzvWJLMwIbTQH3jg6QlToyw2wtJO9noRgrTD+bLSzO1Bmwp9m8cBzJpa+zdSjqX
	 KARciJ392A+xPz93jkzx1cwIBtcRQz9IlOo5UBdU=
Authentication-Results: mail-nwsmtp-smtp-production-main-89; dkim=pass header.i=@yandex.com
From: Eneshan Karaca <Eneshan-Karaca@yandex.com>
To: brauner@kernel.org,
	kees@kernel.org,
	rostedt@goodmis.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	jkoolstra@xs4all.nl,
	farid.m.zakaria@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RFC PATCH v2] binfmt_misc: add binfmt_misc_select tracepoint
Date: Thu, 29 Oct 2026 21:58:49 +0300
Message-ID: <20261029185849.8016-1-Eneshan-Karaca@yandex.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Eneshan Erdoğan Karaca <BoxStrikesTeam@proton.me>

A binfmt_misc entry can select an interpreter for an exec.  With a BPF
'B' handler, that selection can be made by a BPF struct_ops program.
The kernel commits the decision in bprm->interp and bprm->flags, but it
does not emit an event at the selection point.

Existing observers have to reconstruct the decision from
/proc/PID/exe, AT_EXECFD, AT_FLAGS, or /proc/PID/maps.  These sources
are mode-dependent: a transparent dispatch still reports the original
binary in /proc/PID/exe, and a short-lived process can exit before the
observer reads it.  A classic dispatch reports the interpreter, but
not which handler selected it or which invocation flags were used.

Add a tracepoint after the interpreter and the invocation flags are
selected.  The caller passes the matched entry and the raw flags; the
trace event resolves the handler name and masks the flags with
MISC_FMT_INVOCATION_FLAGS.  The event reports the binary filename, the
selected interpreter, the handler name, the invocation flags, and the
pid.

The tracepoint is observability only; it does not change exec
behavior.

Assisted-by: LLM
Signed-off-by: Eneshan Erdoğan Karaca <BoxStrikesTeam@proton.me>
---
v2:
 - Pass the matched entry and the raw flags to the tracepoint.
 - Resolve the handler name and mask the flags in the trace event.

Thanks to Steven Rostedt for the review and the claws-mail tip.  The
PoC and A/B results are available on request.

 fs/binfmt_misc.c                   |  9 +++++
 include/trace/events/binfmt_misc.h | 55 ++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 include/trace/events/binfmt_misc.h

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 620da85..58a8283 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -118,6 +118,13 @@ struct binfmt_misc_entry {
        char buf[];                     /* register string, fields point in here */
 };

+/*
+ * The trace event needs struct binfmt_misc_entry and the MISC_FMT_*
+ * flags, so include it after they are defined.
+ */
+#define CREATE_TRACE_POINTS
+#include <trace/events/binfmt_misc.h>
+
 /*
  * Max length of the register string.  Determined by:
  *  - 7 delimiters
@@ -644,6 +651,8 @@ static int load_misc_binary(struct linux_binprm *bprm)

        flags = entry_invocation_flags(fmt, bprm);

+       trace_binfmt_misc_select(bprm, fmt, interpreter, flags);
+
        /* No argv is built for a staged argument to land in. */
        if ((flags & (MISC_FMT_LOADER | MISC_FMT_TRANSPARENT)) &&
            bprm->bpf_interp_arg)
diff --git a/include/trace/events/binfmt_misc.h b/include/trace/events/binfmt_misc.h
new file mode 100644
index 0000000..61a0de0
--- /dev/null
+++ b/include/trace/events/binfmt_misc.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Tracepoint for binfmt_misc binary type handler dispatch.
+ *
+ * Fires once for every exec a binfmt_misc entry matches, after the
+ * interpreter and the invocation flags have been selected. Unlike
+ * sched_process_exec (which reports bprm->filename) and /proc/PID/exe
+ * (which a transparent dispatch sets to the binary), this reports the
+ * interpreter that actually runs, so observers can see through a
+ * transparent dispatch.
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM binfmt_misc
+
+#if !defined(_TRACE_BINFMT_MISC_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_BINFMT_MISC_H
+
+#include <linux/tracepoint.h>
+#include <linux/binfmts.h>
+#include <linux/binfmt_misc.h>
+#include <linux/bitops.h>
+
+TRACE_EVENT(binfmt_misc_select,
+
+       TP_PROTO(struct linux_binprm *bprm, const struct binfmt_misc_entry *fmt,
+                const char *interp, unsigned long flags),
+
+       TP_ARGS(bprm, fmt, interp, flags),
+
+       TP_STRUCT__entry(
+               __string(filename,      bprm->filename)
+               __string(interp,        interp)
+               __string(handler,       test_bit(MISC_FMT_BPF_BIT, &fmt->flags) ?
+                                       fmt->bpf_ops->name : "")
+               __field(unsigned long,  flags)
+               __field(pid_t,          pid)
+       ),
+
+       TP_fast_assign(
+               __assign_str(filename);
+               __assign_str(interp);
+               __assign_str(handler);
+               __entry->flags = flags & MISC_FMT_INVOCATION_FLAGS;
+               __entry->pid = current->pid;
+       ),
+
+       TP_printk("pid=%d filename=%s interp=%s handler=%s flags=%#lx",
+                 __entry->pid, __get_str(filename), __get_str(interp),
+                 __get_str(handler), __entry->flags)
+);
+
+#endif /* _TRACE_BINFMT_MISC_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
--
2.53.0
