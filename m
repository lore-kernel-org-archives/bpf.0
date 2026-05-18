Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094853093DF;
	Mon, 18 May 2026 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102003; cv=none; b=C/A8EnSwBDs3a3SU/TJob3WnozC7E99ktyP3ouR1PwNmyu9EgxYUPydzRAojOh+r0tyAHWNPkjbjlAXrcC4d/fvRVQwD2OVYcgG3jBcl5tjRmxrGtksRAmnDmRhMUd0e/howzZ1LM0FSUnjyYOOM7osMEzaPY72k6eVk6OFcvQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102003; c=relaxed/simple;
	bh=iUVRpDiX8CWHGTaEx8YIjLuaAEQxF+cSnkrjLYCFXk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BIx3pf98TqxBjiJaIFhBRog3/snLa5cMd3F1gX9iaxXGSzUaMS0DJoQr9SHgsMtQ9xaTKzW+FvJV6y2UCul6pltrWlAbCtc/8eyK7vxgI22uAeyfiV1gW2hdU1m0OVTdZk7w1EkBXQOKEShwV52dc0rUwa8WwP04mVVt3ouLN5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNi1gjcy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNi1gjcy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951EBC2BCB7;
	Mon, 18 May 2026 10:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779102002;
	bh=iUVRpDiX8CWHGTaEx8YIjLuaAEQxF+cSnkrjLYCFXk8=;
	h=From:To:Cc:Subject:Date:From;
	b=GNi1gjcyRRuWO2xqo72HoPq14ziVzaLaTY4AeKS2ffTr5ISFQ53oYcdHYO+P2XKc8
	 N+FC1m9RgsQtpakvs/Ek1lOiboQxyusfTVEhCBDkTcibGt1Xav27rJu/ZF0aa4dxxk
	 0SspKeEoNGrtuagvqBmfOZUThPd0h9NZ2NP1ZDrb+acOVpwniJp1tLD6qmx3I46gjw
	 aZSwuNqGTNg/0BNlN23j0BdyY7y9he/UHWVX3KtGYhoEFcrm4/TjKyRgIDWne63zK/
	 vTP+hrsTfjMSpwwF22ukrecuBs1lo/I0YOTxF6IPpvCFkftwQJ+RsiII/DEppztUXH
	 0qEY0J3Wd3/vQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv2 00/11] uprobes/x86: Fix red zone issue for optimized uprobes
Date: Mon, 18 May 2026 12:59:46 +0200
Message-ID: <20260518105957.123445-1-jolsa@kernel.org>
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
---
Andrii Nakryiko (1):
      selftests/bpf: Add tests for uprobe nop10 red zone clobbering

Jiri Olsa (10):
      uprobes/x86: Use proper mm_struct in __in_uprobe_trampoline
      uprobes/x86: Allow to copy uprobe trampolines on fork
      uprobes/x86: Move optimized uprobe from nop5 to nop10
      libbpf: Change has_nop_combo to work on top of nop10
      libbpf: Detect uprobe syscall with new error
      selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch
      selftests/bpf: Change uprobe syscall tests to use nop10
      selftests/bpf: Change uprobe/usdt trigger bench code to use nop10
      selftests/bpf: Add reattach tests for uprobe syscall
      selftests/bpf: Add tests for forked/cloned optimized uprobes

 arch/x86/kernel/uprobes.c                               | 144 ++++++++++++++++++++++------------
 tools/lib/bpf/features.c                                |   4 +-
 tools/lib/bpf/usdt.c                                    |  16 ++--
 tools/testing/selftests/bpf/bench.c                     |  20 ++---
 tools/testing/selftests/bpf/benchs/bench_trigger.c      |  38 ++++-----
 tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh |   2 +-
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 307 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 tools/testing/selftests/bpf/prog_tests/usdt.c           |  74 +++++++++++++++---
 tools/testing/selftests/bpf/progs/test_usdt.c           |  25 ++++++
 tools/testing/selftests/bpf/usdt.h                      |   2 +-
 tools/testing/selftests/bpf/usdt_2.c                    |  15 +++-
 11 files changed, 524 insertions(+), 123 deletions(-)
