Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FD041C6A;
	Fri, 22 Mar 2024 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123408; cv=none; b=aVVoFQZBmsMTiuDZq4lbtAGubb1KvtvkMGvT21a89e8YE92zb/J0X7ABsNrevty4iZcsMRtZBcT2twkddTRw7rZq1Kgx0Vmu55IlDsVM7kKYVKIiTSGe2t5MbpRg+EDSoa7X5P+sO8FVmVFpFq5wkGMGRBK0oVW3dpOtg9dpT9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123408; c=relaxed/simple;
	bh=FwawSSLGma9rqFVtzEOwOd+Jpyi4D+35rkUKAFeN1EE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SBsbJQcEx0kh8bmMkd39ObZrq9TjZO/VQA8/xXGQYJoj5f7YQl1lllDrZfWU+0wvK1THs6kSYTi3Dyfy9RCaLXGGPrukcQ+HsT3hgYG9d0VM1LXV/0tlVD6EdlkJbuU0DThlt65i4C7mWdD7yTqanTCmKj/NLL9L0fey33C4cxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnm8Hhfw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnm8Hhfw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFBBC433C7;
	Fri, 22 Mar 2024 16:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711123408;
	bh=FwawSSLGma9rqFVtzEOwOd+Jpyi4D+35rkUKAFeN1EE=;
	h=From:To:Cc:Subject:Date:From;
	b=hnm8HhfwAxcPTfAl8Q3CR4cfJBU3l6hqVQyWnVUu8Oot3PY0Nsxxvi9ssdJgU4+YI
	 h2+46RsEhS/jrO5fgibsqFysfFwb6rc1ke5PAX79ILLChyDYhYQeBNTdXNGtOzsJLQ
	 WWjfvoIFS4Y0h8bfvGTDKlWLWWx7soY7gcW+kqMbaGo5vNjWphMUSLeZ7h61aaTkcW
	 3dQP1zvpJKRuhrwceflHe3llWwmMs2vtWSAHfy82ZG8MmeFSmO2+s00Fqw8kAsKUdX
	 2DAtFp+ihPO+Y0grJ6PNzT2ThLu7tj3xr09oIRCo6v89wGSnJrO13pyvYJr7EQvbXk
	 +ynaX6vchNt9w==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	jolsa@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH] ftrace: make extra rcu_is_watching() validation check optional
Date: Fri, 22 Mar 2024 09:03:23 -0700
Message-ID: <20240322160323.2463329-1-andrii@kernel.org>
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

This check is expected to never be true in practice and would be best
controlled with extra config to let users decide if they are willing to
pay the price.

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
index 61c541c36596..19bce4e217d6 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -974,6 +974,19 @@ config FTRACE_RECORD_RECURSION_SIZE
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
+	  This will add more overhead to all ftrace-based invocations.
+
+	  If unsure, say N
+
 config RING_BUFFER_RECORD_RECURSION
 	bool "Record functions that recurse in the ring buffer"
 	depends on FTRACE_RECORD_RECURSION
-- 
2.43.0

