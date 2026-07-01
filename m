Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50F03BBFD6;
	Wed,  1 Jul 2026 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904424; cv=none; b=SMjcgtEvcWw/I4Z/V7VR2KnkAgLSMSjzP0mA3EDVvTEtFvdbffPEL4AIsXILOJRLFfPJe1XA8J0fvgefb7GyT15ESb5V/8D8E2cHoY5lR8epOW9o/iI+FAegd2oyqNXakDd2hAyTb3pTEqByvcsHRcLhdw9R/dHD7zmigr+QQ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904424; c=relaxed/simple;
	bh=w7BZXpiX6j1jBMoTCwY//LZa/PpvBzmT2wbw2oqz5WM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oeh2KjrkFOcigKc3HMNagh2HiCbtAu2NQg8sk3RBZVfoBo4LFrkJQPXj40+i/epg9xjON3rJDkes8L/1a7++kbqP277+uxiERMUVhwBbSAESY5qrTnvytfqZj4h2Lfb3PAELE5RzNMwKJMYVfppHWg9GceYph7HYQgmxmPlHy4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vtiipsv5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vtiipsv5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DDF1F000E9;
	Wed,  1 Jul 2026 11:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782904423;
	bh=+Co8zecfs10HOpPAFm8PJ7PwtgLK1Qb8ixsmc08ICig=;
	h=From:To:Cc:Subject:Date;
	b=Vtiipsv57h0J+Zb7GL+28Ze5OWkhIQlR+Ro5CgO5h407+ObZu2+eiEL1dCSlf+Swh
	 4FL+sCbkWbjzz6eKZHkNr4q3aApe/B0rAWieKFe68VpS8kUiKf35X3TxDqWlqnRKpF
	 XH13c2N71IyCbPhD9Tzrja2/7UUL6nMoE6JIJarMwnUG24DbJRP/bbKsrWqjShuOp4
	 hRgOTFtY9w3sh41TFNJQ/Px170VT9MQiKR0E9pStBHLMF4jYrlPCXRkINgJi5Edwey
	 tby/iFmNC1Pc1XiEjHUUu0EkM+0cHxmilYkaEGW36v43QsADYS/cNyWK60toNVeB12
	 57BIYT7Qvhq3g==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv5 00/13] uprobes/x86: Fix red zone issue for optimized uprobes
Date: Wed,  1 Jul 2026 13:13:24 +0200
Message-ID: <20260701111337.53943-1-jolsa@kernel.org>
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
v4: https://lore.kernel.org/bpf/20260526205840.173790-1-jolsa@kernel.org/

v5 changes:
- several selftests changes and reviewed-by tags [Jakub]
- add more comments in int3_update_unoptimize [Andrii]
- several other minor changes and acks [Oleg]
- move insn_decode out of uprobe_init_insn to simplify the code
- align uprobe_red_zone_test to 64 to make sure nop10 is not on page boundary

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
      uprobes/x86: Do not leak trampoline vma mapping on optimization failure
      uprobes/x86: Allow to copy uprobe trampolines on fork
      uprobes/x86: Move optimized uprobe from nop5 to nop10
      libbpf: Change has_nop_combo to work on top of nop10
      libbpf: Detect uprobe syscall with new error
      selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch
      selftests/bpf: Change uprobe syscall tests to use nop10
      selftests/bpf: Change uprobe/usdt trigger bench code to use nop10
      selftests/bpf: Add reattach tests for uprobe syscall
      selftests/bpf: Add tests for forked/cloned optimized uprobes

 arch/x86/kernel/uprobes.c                               | 416 +++++++++++++++++++++++++++++++++++++++++++-----------------------------
 include/linux/uprobes.h                                 |   5 -
 kernel/events/uprobes.c                                 |  10 --
 kernel/fork.c                                           |   1 -
 tools/lib/bpf/features.c                                |   4 +-
 tools/lib/bpf/usdt.c                                    |  16 +--
 tools/testing/selftests/bpf/bench.c                     |  20 ++--
 tools/testing/selftests/bpf/benchs/bench_trigger.c      |  38 +++----
 tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh |   2 +-
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 326 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 tools/testing/selftests/bpf/prog_tests/usdt.c           |  74 +++++++++++--
 tools/testing/selftests/bpf/progs/test_usdt.c           |  25 +++++
 tools/testing/selftests/bpf/usdt.h                      |   2 +-
 tools/testing/selftests/bpf/usdt_2.c                    |  15 ++-
 14 files changed, 698 insertions(+), 256 deletions(-)
