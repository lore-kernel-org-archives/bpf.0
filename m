Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14BC1C3BF7;
	Wed,  1 Jul 2026 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913556; cv=none; b=lZLLA6+qdnmcGCEHx76N3Sotm3cexkThc+QMW0nbtlPVITcj3xf0jAwNTkqvwF/CNUwwys3qd9Oa7fMXadw2Knoc2YQWO4Spnh0iuciA5RKzLlrOV8Qarn+gJUPc6gpT1/H8mSiIt3MpYBKyYA2bhKwuaLdE6XRROSIAm+1/BVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913556; c=relaxed/simple;
	bh=ubJQfmstF66KYxLq0hJxS4KCx4raPJgpI6uR2Cpx1/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCP9bqnOYMFZdL6c6OHU9TYt1YHwd5l40UDIAXs1mQF2Dr0Ed2cwI6sI3YFvjw6TagrPu4mFPyLGoU6xYPJvmo9elR3P4qxJrzT1tRUNKFFEKOj2aEPbw+8M7UIFaKZTGHRYhByo6s6aLxjHh+/Xc/cMl1CI5Y+n3cyRLUlcxCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mwc14w6r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mwc14w6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD711F000E9;
	Wed,  1 Jul 2026 13:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782913555;
	bh=Q3X5n8EACXLoYwth4VEh1SlqF1hV5LwxxfHvBlRQlv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mwc14w6r5pqEImPcypaR7nwz4mtdph7e9gOfhC107R+/bbIs+hRmsMM52TRq5TRSN
	 j5wRSGKSFpMvZR+vH8moMHSTeEE94bk6JaNVNmNauzJbyoBZiXma8xDZojSZlKvf/C
	 V2U7yLPXMXkrbzXviAKBp3KDU+Z76txYt3KqdkpGr78KvwCZayM6t4o6wFzZ+TF11f
	 XmPe3tlNVdoGaf+DJJa7hu3mVOwk5nkM1v4C1MOlsXF30nAItPFXW8p0yvVnGDjSbF
	 dLNteDjSa87UHiLApXbY1nkOiY5OMyyGWqL8ehmjJ5Puabyux5ci7OfGNOTaRIQHEY
	 R0J/pyDSQfeqQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RFC PATCH 3/4] tracing: Add disable_bpf trace option to ignore eBPF for fetchargs
Date: Wed,  1 Jul 2026 22:45:51 +0900
Message-ID: <178291355107.1566898.16400808380207816368.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178291352217.1566898.14481561093843379745.stgit@devnote2>
References: <178291352217.1566898.14481561093843379745.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add a trace option "disable_bpf" to disable BPF execution for fetchargs,
forcing the execution to fallback to the interpreter loop. This is useful
for evaluating BPF compilation performance impact.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace.c            |    7 +++++++
 kernel/trace/trace.h            |    8 ++++++++
 kernel/trace/trace_probe_tmpl.h |    2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c9e182d40059..7c0f7b629fcb 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9940,6 +9940,13 @@ struct trace_array *trace_get_global_array(void)
 }
 #endif
 
+#ifdef CONFIG_BPF_SYSCALL
+bool trace_probe_bpf_disabled(void)
+{
+	return !!(global_trace.trace_flags & TRACE_ITER(DISABLE_BPF));
+}
+#endif
+
 void __init early_trace_init(void)
 {
 	if (tracepoint_printk) {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 80fe152af1dd..bf83680e0ba7 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1503,6 +1503,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		C(PAUSE_ON_TRACE,	"pause-on-trace"),	\
 		C(HASH_PTR,		"hash-ptr"),	/* Print hashed pointer */ \
 		C(BITMASK_LIST,		"bitmask-list"),	\
+		C(DISABLE_BPF,		"disable_bpf"),		\
 		FUNCTION_FLAGS					\
 		FGRAPH_FLAGS					\
 		STACK_FLAGS					\
@@ -2505,4 +2506,11 @@ static inline int rv_init_interface(void)
 		_args;							\
 	})
 
+#ifdef CONFIG_BPF_SYSCALL
+bool trace_probe_bpf_disabled(void);
+#else
+static inline bool trace_probe_bpf_disabled(void) { return false; }
+#endif
+
 #endif /* _LINUX_KERNEL_TRACE_H */
+
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 6ca2dfe59a0f..015208aefbaf 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -274,7 +274,7 @@ store_trace_args(void *data, struct trace_probe *tp, void *rec, void *edata,
 	int ret, i;
 
 #ifdef CONFIG_BPF_SYSCALL
-	if (tp->prog) {
+	if (tp->prog && !trace_probe_bpf_disabled()) {
 		struct fetch_bpf_ctx ctx = {
 			.rec = rec,
 			.edata = edata,

