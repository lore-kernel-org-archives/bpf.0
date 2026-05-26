Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF1B2264D6;
	Tue, 26 May 2026 20:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779829126; cv=none; b=WG1dP/rAQV25b2DmgD6IRvPYZ3g0QKmRMtv8oUNcINsZed5SgTCsYcoT+Ptf6yesvLxdWdOcVj4CnvJYxWh9gr2f5L7ngKl2sGFhgkqOnPPAsS0zgEMG0VhXTER1GuYWNO2zmIV4mvlRvyDhBLjXUaI373FeMrMfMGnGzNDUfNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779829126; c=relaxed/simple;
	bh=2/0AgAfIcE3K7jqkkNWZwz7Bm6ixy/m4uuTQoYZ8d8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XA2PYtOJpXi5TEgNX0944fCqGSgmwAABoMY9veh8DOmeRTc7Ca7i61JBvfnQ4nx1fv4Ee2vOaNjl8lW5vd06QbL93biRnB2jYo+iIzirTs90VDtAXLUXv6u5vDByXqw+LFywu/El6/hMJDReVgE25mj9sK1jDxIXwO9W7p0b+iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcInqzRJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcInqzRJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8C21F000E9;
	Tue, 26 May 2026 20:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779829125;
	bh=C9Ums9y0roCN9p7E4pmxIDMn0pbs8TMPD+4e21NSewI=;
	h=From:To:Cc:Subject:Date;
	b=JcInqzRJ/plUQLUdvHqWHbMFQl7WLQTFHV2jdQaLg0MhlMLWQiGOHTiyTRxaMK59U
	 kMs/OZubdQjhsPdSjIAw+GskbyVuxdPpJcpvpoBblRuk4YgVFB+OCTdyk1Cxmsab+3
	 fpHleL38tYcDAPsGw1eOiD4H3bl9avYSCErcNEFt/4qcRzBTGylZdgvpm7oTXzALtw
	 4rYA8Em1jbi74TRrpP5bBO4qzMVpyTgX9IyhqpNPymW4vIdJpx2KiU32fyjYjG9y4E
	 o4BkMwGD1QElnp8FMQdPOsbtlqDIgKJuFyZIx5aMH6EEHFyggLMGxn6Mg1rJFXZtJO
	 VjB7jZi5/RaWg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv4 00/13] uprobes/x86: Fix red zone issue for optimized uprobes
Date: Tue, 26 May 2026 22:58:27 +0200
Message-ID: <20260526205840.173790-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
Andrii reported an issue with optimized uprobes [1] that can clobber
redzone area with call instruction storing return address on stack
where user code may keep temporary data without adjusting rsp.

Fixing this by moving the optimized uprobes on top of 10-bytes nop
instruction, so we can squeeze another instruction to escape the
redzone area before doing the call.

Note we need upstream update first for patch 3 (github.com/libbpf/usdt),
if we decide to take this change.

thanks,
jirka


v1: https://lore.kernel.org/bpf/20260514135342.22130-1-jolsa@kernel.org/
v2: https://lore.kernel.org/bpf/20260518105957.123445-1-jolsa@kernel.org/
v3: https://lore.kernel.org/bpf/20260521124411.31133-1-jolsa@kernel.org/

v4 changes:
- do not use 2nd int3 (ont +5 offset) because the call instruction
  is allways the same for the given nop10 address [Andrii/Peter]
- unmap unused trampoline vma after unsuccesfull optimization [sashiko]
- small change to patch#2 moved user_64bit_mode earlier in the path
  and pass/use mm_struct pointer directly from arch_uprobe_optimize
  instead of gettting current->mm
  Andrii, keeping your ack, please shout otherwise

v3 changes:
- use nop10 update suggested by Peter in [2]
- remove struct uprobe_trampoline object, use vma objects directly instead
- selftests fixes [sashiko]
- ack from Andrii

v2 changes:
- several selftest fixes [sashiko]
- consolidate is_lea_insn and is_call_insn insto single check [Jakub Sitnicki]
- use proper mm_struct object in __in_uprobe_trampoline check [sashiko]
- allow to copy uprobe trampolines vma objects on fork [sashiko]
- change uprobe syscall detection error from -ENXIO to -EPROTO [Andrii]
- added fork/clone tests
- I kept the selftest changes and nop5->nop10 changes in separate
  commits for easier review, we can squash them later if we want to keep
  bisect working properly


[1] https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org/
[2] https://lore.kernel.org/bpf/20260518104306.GU3102624@noisy.programming.kicks-ass.net/#t
---
Andrii Nakryiko (1):
      selftests/bpf: Add tests for uprobe nop10 red zone clobbering

Jiri Olsa (12):
      uprobes/x86: Use proper mm_struct in __in_uprobe_trampoline
      uprobes/x86: Remove struct uprobe_trampoline object
      uprobes/x86: Allow to copy uprobe trampolines on fork
      uprobes/x86: Unmap trampoline vma object in case it's unused
      uprobes/x86: Move optimized uprobe from nop5 to nop10
      libbpf: Change has_nop_combo to work on top of nop10
      libbpf: Detect uprobe syscall with new error
      selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch
      selftests/bpf: Change uprobe syscall tests to use nop10
      selftests/bpf: Change uprobe/usdt trigger bench code to use nop10
      selftests/bpf: Add reattach tests for uprobe syscall
      selftests/bpf: Add tests for forked/cloned optimized uprobes

 arch/x86/kernel/uprobes.c                               | 379 +++++++++++++++++++++++++++++++++++++++++++-----------------------------
 include/linux/uprobes.h                                 |   5 -
 kernel/events/uprobes.c                                 |  10 --
 kernel/fork.c                                           |   1 -
 tools/lib/bpf/features.c                                |   4 +-
 tools/lib/bpf/usdt.c                                    |  16 +--
 tools/testing/selftests/bpf/bench.c                     |  20 ++--
 tools/testing/selftests/bpf/benchs/bench_trigger.c      |  38 ++++----
 tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh |   2 +-
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 307 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 tools/testing/selftests/bpf/prog_tests/usdt.c           |  74 ++++++++++++--
 tools/testing/selftests/bpf/progs/test_usdt.c           |  25 +++++
 tools/testing/selftests/bpf/usdt.h                      |   2 +-
 tools/testing/selftests/bpf/usdt_2.c                    |  15 ++-
 14 files changed, 653 insertions(+), 245 deletions(-)
