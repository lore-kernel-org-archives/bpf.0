Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A01325B09E;
	Wed,  1 Jul 2026 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913566; cv=none; b=WKf1GEe4FAC8Zwe34VOHw3XO3KWc1wTtM0rFcuv6gQQzBKS67dbMqT/QwZ5DByny+rKcXYDBiGCQ75g+WEHFa7RapMy4Q+O+Mz3w/RuLegZuOxhtG2fF0ts6EozT0DHxJ3ytrw6H5zGr1bsNyolK+vUG7F7Q4fxg9Nt3Q2IAxSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913566; c=relaxed/simple;
	bh=HLU8OIArXV3mbsdJlZe5UUck7Pp5tiyeL9y3YxVzorg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CworTH6BQd3rCGzpA4kxfRb2BZoaA8ae7W6PmjC+mbWzbSnfvhw/3N/q9VAUQmwtS/DC57pwZNGpS5mHBdCQkuSeYGLXH9pdtiRe+Oz9HQD/9ZglFuiAEydSSYNzeyygyR98NyPUpi+0h4P36y2cNI/9G91RYaJpTiPA0Ub1K4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3wKxvRp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3wKxvRp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1F21F000E9;
	Wed,  1 Jul 2026 13:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782913564;
	bh=Qr809JcwYSpHxRXSCO3Q4RMwS8OcGyNKa91B91Dbwe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c3wKxvRpfXFvTI4OTLwLiLskSFkkqQDuMhBaIRwU1GTWRyVi3M4MN4+5Jo3wOpXRe
	 +6b+PzUWfqRREEWuHW7Tz1vEzphqUn05snPFiPbnnYZtT+lyxl+eaxYw7YbUT41ZYF
	 go4XU3jw/FU8SfvRpXNA7fL7jxdPbfucSeVR9hK0Z1UELznZxX3g32AnXYZLijXLKw
	 /EJAiFef3DPO6h1CAZhGN+tmmVh5JPZLCiHvD5lyKKsASed45FtHsF+ZiVRzTxiWH6
	 UST+QCG3KknLhwzY/8RWWWoVPoPHlOUzw/yJTewcVbb+5xEr95UUw6IIqcLTjAWGlf
	 ydP6XlruHlrgA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RFC PATCH 4/4] selftests/ftrace: Add a test for eBPF compiled fetchargs
Date: Wed,  1 Jul 2026 22:46:00 +0900
Message-ID: <178291356080.1566898.2303910167100203913.stgit@devnote2>
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

Add a selftest for trace probe BPF compilation to verify that BPF is
correctly compiled and executes properly for valid configurations,
and falls back to interpreter on unsupported cases.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/test_bpf_fetchargs.tc   |   51 ++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/test_bpf_fetchargs.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/test_bpf_fetchargs.tc b/tools/testing/selftests/ftrace/test.d/dynevent/test_bpf_fetchargs.tc
new file mode 100644
index 000000000000..6c6f4dd4517a
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/test_bpf_fetchargs.tc
@@ -0,0 +1,51 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Dynamic event - test eBPF compiled fetchargs for tprobe and fprobe
+# requires: dynamic_events "t[:[<group>/][<event>]] <tracepoint> [<args>]":README
+
+# Check if the sample module is loaded
+if ! lsmod | grep -q trace_events_sample; then
+  modprobe trace-events-sample || exit_unsupported
+fi
+
+echo 0 > events/enable
+echo > dynamic_events
+clear_trace
+
+# Add a tprobe to sample-trace:foo_bar
+# foo_bar args: const char *foo, int bar, ...
+# So $arg1 is char ptr (points to "hello"), $arg2 is int.
+# Let's test REG (arg2) and DEREF (+0($arg1))
+# "hello" in little-endian 32-bit: 'h'(0x68), 'e'(0x65), 'l'(0x6c), 'l'(0x6c) -> 0x6c6c6568 -> 1819043176
+echo "t:test_tprobe foo_bar mybar=\$arg2 myfoo=+0(\$arg1):u32" >> dynamic_events
+
+# Add an fprobe to __traceiter_foo_bar
+if grep -q "__traceiter_foo_bar" /proc/kallsyms; then
+  # __traceiter_foo_bar args: void *__data, const char *foo, int bar, ...
+  # $arg1 is __data, $arg2 is foo (points to "hello")
+  # "hello" in little-endian 32-bit: 'h'(0x68), 'e'(0x65), 'l'(0x6c), 'l'(0x6c) -> 0x6c6c6568 -> 1819043176
+  echo "f:test_fprobe __traceiter_foo_bar myfoo=\$arg2 myfmt=+0(\$arg2):u32" >> dynamic_events
+fi
+
+echo 1 > events/sample-trace/foo_bar/enable
+echo 1 > events/tracepoints/test_tprobe/enable
+if [ -d events/fprobes/test_fprobe ]; then
+  echo 1 > events/fprobes/test_fprobe/enable
+fi
+
+# Wait for 2 seconds to let the sample thread trigger the events
+sleep 2
+
+echo 0 > events/enable
+
+# Now verify the trace
+grep -q "test_tprobe.*myfoo=1819043176" trace || exit_fail
+
+if [ -d events/fprobes/test_fprobe ]; then
+  grep -q "test_fprobe.*myfmt=1819043176" trace || exit_fail
+fi
+
+echo > dynamic_events
+rmmod trace-events-sample
+
+exit 0

