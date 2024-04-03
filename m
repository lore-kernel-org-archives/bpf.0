Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B5A155A46;
	Wed,  3 Apr 2024 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712181813; cv=none; b=NYK0DIeHcjep1fc/KCymgQh68DzSuor6CH/GsNhgYXiisVs0v4LHF1V7jpI/gD9B7vuihC7wfULcW45aFpEqLeXFoQKEC9NHSF1YTwXhlqilsq9gkPLM+NGCzJ9w/aoTw0CnGgW/jF5H8IRHkyozRq+xYvEYKn7RdSQk2uZDOOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712181813; c=relaxed/simple;
	bh=5sP3DAGV0y7InFAl2knqhH/EQZOjd1FykDpAx3ilIVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aX8jZi/GlOb8K8INQXeJiVejavBBydmUdslhLuWRbjI6/p7UBiExmKcVOTFvjBf2axxkKj5zVR8D3ezqZ8UPwnXxO+tJ3NiJP5wpLF+Yk2BjVzYZfbDh2O1zU1fTlQpAcajmTz0TPQ/Buj2/6RlL5oaTn5T6ycB5XJlADEKf9OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoJ/hj0S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoJ/hj0S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EA4C433C7;
	Wed,  3 Apr 2024 22:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712181812;
	bh=5sP3DAGV0y7InFAl2knqhH/EQZOjd1FykDpAx3ilIVc=;
	h=From:To:Cc:Subject:Date:From;
	b=OoJ/hj0Sh1/Uqgm0SedOslB6ho9oQ5WsukOps17SwBqERToVF7DUJzp65clDN8X1a
	 7SVhsGcjmoWZEsWWl7NsG+6SwnCR7VkGjKwL56rOxsx7j+UgXPxmoXAUcvaMQd/hDW
	 /K+MtUdCfPoQiR3k8oPx1EnxKeJUSItJ7Sr71/EY/jXqIW9A+h5aa+zufQgBEg4T2O
	 H7+Z2UCjzdcu8I68mWDXh7zg5zdV2C/yErMNx7BkO9MofiZA0hTz2Ebz2rmhQA5XEo
	 5YapNsKaBVYKVlfpQW5KrLG8cfsw7Q7ssW6ayvUZEiETWqeIB8f6ysIOVXF7vhzVzd
	 ijizdZQHx9GpA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	jolsa@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 1/2] ftrace: make extra rcu_is_watching() validation check optional
Date: Wed,  3 Apr 2024 15:03:27 -0700
Message-ID: <20240403220328.455786-1-andrii@kernel.org>
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
low-level validation of ftrace subsystem invariants. For most users it
should probably be kept disabled to eliminate unnecessary runtime
overhead.

This improves BPF multi-kretprobe (relying on ftrace and rethook
infrastructure) runtime throughput by 2%, according to BPF benchmarks ([0]).

  [0] https://lore.kernel.org/bpf/CAEf4BzauQ2WKMjZdc9s0rBWa01BYbgwHN6aNDXQSHYia47pQ-w@mail.gmail.com/

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/trace_recursion.h |  2 +-
 kernel/trace/Kconfig            | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

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
index 61c541c36596..7aebd1b8f93e 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -974,6 +974,19 @@ config FTRACE_RECORD_RECURSION_SIZE
 	  This file can be reset, but the limit can not change in
 	  size at runtime.
 
+config FTRACE_VALIDATE_RCU_IS_WATCHING
+	bool "Validate RCU is on during ftrace execution"
+	depends on FUNCTION_TRACER
+	depends on ARCH_WANTS_NO_INSTR
+	help
+	  All callbacks that attach to the function tracing have some sort of
+	  protection against recursion. This option is only to verify that
+	  ftrace (and other users of ftrace_test_recursion_trylock()) are not
+	  called outside of RCU, as if they are, it can cause a race. But it
+	  also has a noticeable overhead when enabled.
+
+	  If unsure, say N
+
 config RING_BUFFER_RECORD_RECURSION
 	bool "Record functions that recurse in the ring buffer"
 	depends on FTRACE_RECORD_RECURSION
-- 
2.43.0

