Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A56C4C33EF;
	Wed, 30 Sep 2026 23:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790812375; cv=none; b=Q0TYpznzJYGPF3ku6oREvvGHmN9k4HMTvxWVi/Rlkj9d5P56+QiIT8sACnR6NLS2Cl5CDIb4W7l4OfUJyoEWA5l/TdhUTreoJMEOtOBNfwL/9lqKHtqX/Fn2NAW8/DbnHPuGLd7q8vi9Cwkb7jYJzJb9usXdPvXbi8m+oBCwOb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790812375; c=relaxed/simple;
	bh=8GlVVUCgvvIZnBgeKp+SMPMwpZWbLngxqBFb+yFlrGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B5aw1bRZ2+ns08zGBerqPIwzwz6+8nYDBeJKVE3ClCmfCEcNalyHvohXpBxDZcdiuN7CVIzkelFwXohFUagfhjXzMFSrIYch17u6AQcafBRt8XZ43GXezjhtPaPl//rYWFlknzUhDPdnK4mGS/IFqerjmMYYtzYHW9jWDtA/8RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uy3BvdXi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uy3BvdXi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28CC1F0089E;
	Wed, 30 Sep 2026 23:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790812371;
	bh=F7RfdF16SM344EIlNKPyYShExnRYu4LAk2eQMzq0LDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uy3BvdXiZ99sg4WoIPo7qse1plGZOCT+gT2a8Qjq1/e30W9ZyvwKjm+s6VyQpxGKH
	 nu1kSys4ze/LtbahWdc869/gl7g5szZgn24/QqzBr3suXiu6+53jlklqh96JK18C2v
	 rkei0S/E0qh09KdQIFrX2gQbrKRM6hobh0WcfQeot2XS5L6bPqXg/XukQvrGGc2EB9
	 HDwUw3VcCZmkFjb0jxEdsL7ORYIjewe4KFa4FtMCwXSNaEhQ42VaBLs+GXFnegPLtt
	 GQxw8YZTk1Rxilil5Cv71ellfimlr4dACcpciOPCbvBLqy6wdCUWkgXiUpR3eEeTNw
	 iz+/yedWWs3Tw==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Petr Mladek <pmladek@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	David Gow <david@davidgow.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	nikitash.mariiaw@gmail.com,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 06/11] seq_buf: Add seq_buf_terminate()
Date: Wed, 30 Sep 2026 16:52:34 -0700
Message-Id: <20260930235247.157921-6-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930235231.out.387-kees@kernel.org>
References: <20260930235231.out.387-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6401; i=kees@kernel.org; h=from:subject; bh=8GlVVUCgvvIZnBgeKp+SMPMwpZWbLngxqBFb+yFlrGY=; b=owGbwMvMwCVmps19z/KJym7G02pJDFl7Fxxd8nRak4F6rfsl0W2brYKfPCwrf3Pez2p7cpkpU 9ctY5v4jlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIlwWjL8TyrfOkW/2epX86mL X7hrBYK3uP7x9blVHMpXs9CAJ6h8BiPDpPfq+6ev+lYoKi7qXXWY80P442tt7gl2Ph4me3ZFxrS yAAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Seven callers call seq_buf_str() only to NUL-terminate the buffer,
discarding the returned pointer. Two of them need a comment to say so.

Add seq_buf_terminate(), wrapping the __seq_buf_terminate() helper that
seq_buf_str() and seq_buf_strlen() already use, and convert those
callers. It returns void: returning the offset would just be
seq_buf_strlen() under another name. A zero-sized seq_buf is left
untouched, as in the other accessors.

Add tests for the three cases: room for the NUL after the data, an
overflowed buffer where it lands in the last byte, and a zero-sized
buffer that must not be written to.

Build tested ARCH=x86_64 defconfig with GCC 16.2.0, plus
CONFIG_HIST_TRIGGERS=y and CONFIG_BPF_SYSCALL=y to reach the converted
call sites in kernel/trace/trace_events_hist.c and
kernel/bpf/diagnostics.c. Tests run 24/24 passing on ARCH=um.

Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/seq_buf.h          | 23 +++++++++++++++++++++++
 kernel/bpf/diagnostics.c         |  6 +++---
 kernel/trace/trace_events.c      |  4 ++--
 kernel/trace/trace_events_hist.c |  6 ++----
 lib/tests/seq_buf_kunit.c        | 28 ++++++++++++++++++++++++++++
 5 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 87ccc62f1c62..195e612a212a 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -171,6 +171,29 @@ static inline size_t seq_buf_strlen(struct seq_buf *s)
 	return __seq_buf_terminate(s);
 }
 
+/**
+ * seq_buf_terminate - NUL-terminate the string in a seq_buf
+ * @s: the seq_buf handle
+ *
+ * Terminate @s->buffer exactly as seq_buf_str() and seq_buf_strlen() do,
+ * for callers that want neither the pointer nor the length and only need
+ * the buffer to be safe to read as a C string. A zero-sized seq_buf has
+ * nowhere to put a NUL and is left untouched.
+ *
+ * Nothing is returned on purpose: a caller that wants the length should
+ * use seq_buf_strlen(), which says so.
+ *
+ * After this function is called, s->buffer is safe to use
+ * in string operations.
+ */
+static inline void seq_buf_terminate(struct seq_buf *s)
+{
+	if (s->size == 0)
+		return;
+
+	__seq_buf_terminate(s);
+}
+
 /**
  * seq_buf_get_buf - get buffer to write arbitrary data to
  * @s: the seq_buf handle
diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 0abbbe177e31..594cf3c8b74c 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -351,7 +351,7 @@ static void diag_fmt_restore(struct bpf_verifier_env *env, struct diag_fmt_mark
 
 	if (mark.chunk) {
 		mark.chunk->seq.len = mark.len;
-		seq_buf_str(&mark.chunk->seq);
+		seq_buf_terminate(&mark.chunk->seq);
 	}
 }
 
@@ -631,11 +631,11 @@ static void format_disasm_line(struct bpf_verifier_env *env, int insn_idx,
 		return;
 
 	print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
-	seq_buf_str(&ctx.seq);
+	seq_buf_terminate(&ctx.seq);
 	ctx.seq.len = strnlen(line->text, sizeof(line->text));
 	while (ctx.seq.len && line->text[ctx.seq.len - 1] == '\n')
 		seq_buf_pop(&ctx.seq);
-	seq_buf_str(&ctx.seq);
+	seq_buf_terminate(&ctx.seq);
 
 	line->valid = true;
 }
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 9dbc2441763b..39bb391546de 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -4906,7 +4906,7 @@ static __init int event_trace_enable(void)
 	 */
 	__trace_early_add_events(tr);
 
-	seq_buf_str(&bootup_event_seq);
+	seq_buf_terminate(&bootup_event_seq);
 	early_enable_events(tr, bootup_event_buf, false);
 
 	trace_printk_start_comm();
@@ -4935,7 +4935,7 @@ static __init int event_trace_enable_again(void)
 	if (!tr)
 		return -ENODEV;
 
-	seq_buf_str(&bootup_event_seq);
+	seq_buf_terminate(&bootup_event_seq);
 	early_enable_events(tr, bootup_event_buf, true);
 
 	return 0;
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 963e0d6b61fd..57bd1cd5c657 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2988,8 +2988,7 @@ find_synthetic_field_var(struct hist_trigger_data *target_hist_data,
 	seq_buf_init(&s, synthetic_name, MAX_FILTER_STR_VAL);
 	seq_buf_printf(&s, "synthetic_%s", field_name);
 
-	/* Terminate synthetic_name with a NUL. */
-	seq_buf_str(&s);
+	seq_buf_terminate(&s);
 
 	if (seq_buf_has_overflowed(&s)) {
 		kfree(synthetic_name);
@@ -3106,8 +3105,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	if (saved_filter)
 		seq_buf_printf(&s, " if %s", saved_filter);
 
-	/* Terminate cmd with a NUL. */
-	seq_buf_str(&s);
+	seq_buf_terminate(&s);
 
 	if (seq_buf_has_overflowed(&s)) {
 		kfree(cmd);
diff --git a/lib/tests/seq_buf_kunit.c b/lib/tests/seq_buf_kunit.c
index 9859a44dd959..8e879a4082ad 100644
--- a/lib/tests/seq_buf_kunit.c
+++ b/lib/tests/seq_buf_kunit.c
@@ -635,6 +635,33 @@ static void seq_buf_strlen_zero_size_test(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, buf, "untouched");
 }
 
+static void seq_buf_terminate_test(struct kunit *test)
+{
+	char buf[16];
+	struct seq_buf s;
+
+	/* Terminates directly after the data when there is room. */
+	memset(buf, 'z', sizeof(buf));
+	seq_buf_init(&s, buf, sizeof(buf));
+	seq_buf_puts(&s, "ab");
+	seq_buf_terminate(&s);
+	KUNIT_EXPECT_STREQ(test, buf, "ab");
+
+	/* Terminates in the last byte once the buffer has overflowed. */
+	memset(buf, 'z', sizeof(buf));
+	seq_buf_init(&s, buf, 4);
+	seq_buf_puts(&s, "abcdef");
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
+	seq_buf_terminate(&s);
+	KUNIT_EXPECT_STREQ(test, buf, "abc");
+
+	/* A zero-sized seq_buf is left alone. */
+	strscpy(buf, "untouched", sizeof(buf));
+	seq_buf_init(&s, buf, 0);
+	seq_buf_terminate(&s);
+	KUNIT_EXPECT_STREQ(test, buf, "untouched");
+}
+
 static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_init_test),
 	KUNIT_CASE(seq_buf_declare_test),
@@ -658,6 +685,7 @@ static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_strlen_puts_overflow_test),
 	KUNIT_CASE(seq_buf_strlen_embedded_nul_test),
 	KUNIT_CASE(seq_buf_strlen_zero_size_test),
+	KUNIT_CASE(seq_buf_terminate_test),
 	KUNIT_CASE(seq_buf_do_printk_test),
 	{}
 };
-- 
2.34.1

