Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F05B3D091A;
	Thu, 21 May 2026 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367457; cv=none; b=NZWXId3U7ZDLOx5YndkGb59BDkWYCUXFU1irss+fDWf778WFyKmkoITEzod8/+oricN6rvD7Y6JzfOzmt1mLfDbi5NOlWjkzCwQk8lpV2XZcIT7Mg+TW4X5vo9JFRGM0/h/YjoOoYz7VkTXk4jTF/3Ab+4LnP/b4Mqq6wOb2H/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367457; c=relaxed/simple;
	bh=jWbmflbuW6J4goEc79qlSSJZlQfBF+OG8cAoFFWXIWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sI9AExBjFdrbIlzNgiNLs1abWojN1TabNgYjrk1Qdy0sMHZQX/pkdBNCEZyg8rnCVmt45PJf3Sq96WfMRSTC8ptyuPTs8jFvUxDPsUzVhrOLJLwfZLaaCCcgWW3n54Ili9Bkov6K803ig5N8Uch2CJlN8EZlCwQHk9SWDW952os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+VaWYhI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+VaWYhI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D677F1F000E9;
	Thu, 21 May 2026 12:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779367456;
	bh=3sQdkXma8XObugrvw5mvb/DcW/CSIMcfVAbGtyiefsg=;
	h=From:To:Cc:Subject:Date;
	b=c+VaWYhIF/XuX9+ex4Gb8gp3J4VgWkl6HIBtrvWGRLQQ/mIEg71PIoi5db4ulX8Vn
	 7IThxM3Z4iF1s2cHwf07N/RCiiF2Vc8gTlcuqNT36kMYbxbTcYulhEdLUAail0Vgqd
	 EsoWf4zQb6W5KUphurzTBc3z+r9mGLPLVbpO1O3dp4VBx7eVZHifquELUES/we3Rci
	 J/3rIhFRZUuOo4F8IAb+RUGQoTtqqT6WFNXIvKtbwBkEUrTui6j4kfbQO5Mf7YnTBp
	 P3PBonH+LqOAzoMzQ7kNDkQWyc9v3Uy9ErCzWb5ZLhrEJx1v7nE6cBgoA9YgIagsyh
	 UyHpG6JztOlXQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv3 00/12] uprobes/x86: Fix red zone issue for optimized uprobes
Date: Thu, 21 May 2026 14:43:59 +0200
Message-ID: <20260521124411.31133-1-jolsa@kernel.org>
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

Jiri Olsa (11):
      uprobes/x86: Use proper mm_struct in __in_uprobe_trampoline
      uprobes/x86: Remove struct uprobe_trampoline object
      uprobes/x86: Allow to copy uprobe trampolines on fork
      uprobes/x86: Move optimized uprobe from nop5 to nop10
      libbpf: Change has_nop_combo to work on top of nop10
      libbpf: Detect uprobe syscall with new error
      selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch
      selftests/bpf: Change uprobe syscall tests to use nop10
      selftests/bpf: Change uprobe/usdt trigger bench code to use nop10
      selftests/bpf: Add reattach tests for uprobe syscall
      selftests/bpf: Add tests for forked/cloned optimized uprobes

 arch/x86/kernel/uprobes.c                               | 393 ++++++++++++++++++++++++++++++++++++++++++++----------------------------
 include/linux/uprobes.h                                 |   5 -
 kernel/events/uprobes.c                                 |  10 --
 kernel/fork.c                                           |   1 -
 tools/lib/bpf/features.c                                |   4 +-
 tools/lib/bpf/usdt.c                                    |  16 +--
 tools/testing/selftests/bpf/bench.c                     |  20 ++--
 tools/testing/selftests/bpf/benchs/bench_trigger.c      |  38 +++----
 tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh |   2 +-
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 307 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 tools/testing/selftests/bpf/prog_tests/usdt.c           |  74 ++++++++++++--
 tools/testing/selftests/bpf/progs/test_usdt.c           |  25 +++++
 tools/testing/selftests/bpf/usdt.h                      |   2 +-
 tools/testing/selftests/bpf/usdt_2.c                    |  15 ++-
 14 files changed, 670 insertions(+), 242 deletions(-)
