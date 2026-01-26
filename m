Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9C3250BF2;
	Mon, 26 Jan 2026 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769462329; cv=none; b=jBKGjEYIvxuaZPkQNXcHc/LSTdcvXTVEXcbsirHdlvpIjnIyOoDJIqr3d3CDG6o5va1DdQbM4kk1zzC3AyDLLNETxQUSNW8noRcYeXAYcbp/dS05S9+/ER5/9bS0lI44/oU6tCG0irKY15f8zPgmMOM8AwGLKfLhNSLek5mFh28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769462329; c=relaxed/simple;
	bh=gqk8nOTGoaFO7+CQHiIr07UBbE0GctG9clfjuRMHMd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hRVvyl6RDinv3dd3kKKYYL1TQFbf48TnI48Nwqxmpn2Zqa73u4Tmr17JETgfG5NZVPgvmwgZTpCVQGkoACRC/n89KoaX3bmPeORxrbWkjAQ4l2CmKVntpbSSdyg7mMLdgb0JfygpJ/3WkIBMvW6qpFFBShZ3aAEYyrBv1bZZa9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gn86sPoa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gn86sPoa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16273C116C6;
	Mon, 26 Jan 2026 21:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769462328;
	bh=gqk8nOTGoaFO7+CQHiIr07UBbE0GctG9clfjuRMHMd8=;
	h=From:To:Cc:Subject:Date:From;
	b=Gn86sPoabPR5G2XKLXK7Nm/JQFYrZEH/e+fJP5y8KFpDFex6PQEjbNgYUUgDHzCYA
	 Vf8Cx0iMJA1X6frnJw0EZY2cbbcyPIMCDdV7t9EWBqpzBDBGep9BZXkkSj0sClf+nc
	 cfkRONAqQiFYmx0rjOGYjaLed6DkdFTHbM0xV+5SJQXsuERge6ia/bpvm+3wtOADu5
	 N4K9hmjDF2YYcOvEvgAO0W8dEVWIy65wGDyJ6qDjvxOQrzq/R4Bn4lJfC1oROhQjsv
	 a/Kg8ABG+1cI4/hjr4eJBTt5W6ZZL2S2tn0thqggTBJosKoPsCF0T5ihceHgJUSbEi
	 lSsdXjxaWO3CQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Yonghong Song <yhs@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCHv2 bpf-next 0/6] x86/fgraph,bpf: Fix ORC stack unwind from kprobe_multi
Date: Mon, 26 Jan 2026 22:18:31 +0100
Message-ID: <20260126211837.472802-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
Mahe reported missing function from stack trace on top of kprobe multi
program. It turned out the latest fix [1] needs some more fixing.

v2 changes:
- keep the unwind same as for kprobes, attached function
  is part of entry probe stacktrace, not kretprobe [Steven]
- several change in trigger bench [Andrii]
- added selftests for standard kprobes and fentry/fexit probes [Andrii]

Note I'll try to add similar stacktrace adjustment for fentry/fexit
in separate patchset to not complicate this change.

thanks,
jirka


[1] https://lore.kernel.org/bpf/20251104215405.168643-1-jolsa@kernel.org/
---
Jiri Olsa (6):
      x86/fgraph: Fix return_to_handler regs.rsp value
      x86/fgraph,bpf: Switch kprobe_multi program stack unwind to hw_regs path
      selftests/bpf: Fix kprobe multi stacktrace_ips test
      selftests/bpf: Add stacktrace ips test for kprobe/kretprobe
      selftests/bpf: Add stacktrace ips test for fentry/fexit
      selftests/bpf: Allow to benchmark trigger with stacktrace

 arch/x86/include/asm/ftrace.h                           |   2 +-
 arch/x86/kernel/ftrace_64.S                             |   5 +++-
 tools/testing/selftests/bpf/bench.c                     |   4 ++++
 tools/testing/selftests/bpf/bench.h                     |   1 +
 tools/testing/selftests/bpf/benchs/bench_trigger.c      |   1 +
 tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c | 120 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 tools/testing/selftests/bpf/progs/stacktrace_ips.c      |  27 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/trigger_bench.c       |  46 +++++++++++++++++++++++++++++--------
 8 files changed, 190 insertions(+), 16 deletions(-)
