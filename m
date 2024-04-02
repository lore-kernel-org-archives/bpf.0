Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAD412E7C;
	Tue,  2 Apr 2024 02:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024882; cv=none; b=lvXQCX1/9JZEOk/avr5GbQgXTRa8+qo/4/OO3AeMV2/2HAH50LuQ2/HirDsGcR71rwGZ7lphGg5yNY/J9ou77n2jmeLjsi1h87tVhHS3UbtKgBizFdfVz5mJyl7wwZx4M7e/pWRfOljlckYG8uNY02C5JtfNSnGpCNdWEIPyGzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024882; c=relaxed/simple;
	bh=qwNkpmM8WRw+zaWZcf9YNyBOhG2fXojXPVR4mTZyac8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HgdF5dUFAoAtAsHvofZVFfJ5YLjOnf5rn2HFw+jFu57mmWaYoW+QLce8bn2jhzPpt4i8PhZTB6cqhtuCJKx7Ob8G2NGrlPiZ5/OEHhA0gPRbrq7Q3NO6FjVK/NNflwwVQeTHsfchOqBCz2FJZIX+2NY+3f3nEHx15KFlLk+rMPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zb2/uI7g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zb2/uI7g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D31C433F1;
	Tue,  2 Apr 2024 02:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712024881;
	bh=qwNkpmM8WRw+zaWZcf9YNyBOhG2fXojXPVR4mTZyac8=;
	h=From:To:Cc:Subject:Date:From;
	b=Zb2/uI7gXx1eE5YB8JPr3WaOiEIF7gNK0UrVUV13Rz+epHBrsvdXgDEbDUXThBTxE
	 yDUgLSe8wdrCg0Ggf9yCvNk+f/a0E1/S/xy3nxpPtyRuRqalR+I1zP6GqnGVkLhWGa
	 iFf037auPYZ69R2odpL+9FByUOlW5DNixsFe5WGIs4u5k4zB3H3D0tTWfkyonVSXz3
	 NhDSxg/7fZmrICj7aK4nc5ohXyt+PWWsoMZzIroLcUosgIwJyTZAx8WhjnR0XSMjLy
	 YmlPgH8KJn5AGjJanaiE9J2kVfyE0hLkLc2qUC2tuB7V3xziWqdzEzeBZWJxaDnYbt
	 jnqkIdc2XhQFw==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	jolsa@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2] ftrace: make extra rcu_is_watching() validation check optional
Date: Mon,  1 Apr 2024 19:27:57 -0700
Message-ID: <20240402022757.1067292-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING config option to
control whether ftrace low-level code performs additional
rcu_is_watching()-based validation logic in an attempt to catch noinstr
violations.

This check is expected to never be true and is mostly useful for
low-level debugging of ftrace subsystem. For most users it should
probably be kept disabled to eliminate unnecessary runtime overhead.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/trace_recursion.h |  2 +-
 kernel/trace/Kconfig            | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index d48cd92d2364..24ea8ac049b4 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -135,7 +135,7 @@ extern void ftrace_record_recursion(unsigned long ip, unsigned long parent_ip);
 # define do_ftrace_record_recursion(ip, pip)	do { } while (0)
 #endif
 
-#ifdef CONFIG_ARCH_WANTS_NO_INSTR
+#ifdef CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING
 # define trace_warn_on_no_rcu(ip)					\
 	({								\
 		bool __ret = !rcu_is_watching();			\
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 61c541c36596..fcf45d5c60cb 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -974,6 +974,20 @@ config FTRACE_RECORD_RECURSION_SIZE
 	  This file can be reset, but the limit can not change in
 	  size at runtime.
 
+config FTRACE_VALIDATE_RCU_IS_WATCHING
+	bool "Validate RCU is on during ftrace recursion check"
+	depends on FUNCTION_TRACER
+	depends on ARCH_WANTS_NO_INSTR
+	help
+	  All callbacks that attach to the function tracing have some sort
+	  of protection against recursion. This option performs additional
+	  checks to make sure RCU is on when ftrace callbacks recurse.
+
+	  This is a feature useful for debugging ftrace. This will add more
+	  overhead to all ftrace-based invocations.
+
+	  If unsure, say N
+
 config RING_BUFFER_RECORD_RECURSION
 	bool "Record functions that recurse in the ring buffer"
 	depends on FTRACE_RECORD_RECURSION
-- 
2.43.0

