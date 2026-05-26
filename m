Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF68033FE33
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 19:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824255; cv=none; b=L4i93wmQvfS5rAl7FdbruNvCM238mblgn+zHw9Tbtaycd9Bx3G/B/TVzaRezk3EyoLtohRsFwyCCyd671X5pCRz4ZdJ30NjdKQUyNLmA4pwNNtClEFbPcktOkdY0882UH30+QZdFuMCZv/RRwM3kHwjY7yp7mP7DfES8e3iPeF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824255; c=relaxed/simple;
	bh=zweWelgF7OqUzU3q1xGKvPxSWxDyRVOYY7AAQp52YtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G77Gy88uDkRdEmkn3roZcD87aF2uVKfSmLlIjACafTMCqVHHP+Iq4+IOE9AyyG0Zx5VsJ+OZ7MPpv+N8nUoLa9AH4ZJ+WUZhDbRPJhWsG3Cum+cM9EZxtAD+UpsoX3VILtwyjvVRBw49mIvU+cDKNpVZpd0epRJdvIeKMZNaxG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4PVzzaU; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4PVzzaU"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3684a6f3b0bso5450440a91.1
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 12:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779824253; x=1780429053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=md2uP6TWkc+nCFlw3b5bLsdZ2L7ZjormopHq9oHVT0w=;
        b=D4PVzzaUfs0N5h4/ngkBRcOMH8xCXVSBEEHAsRZk+nM51k1IWw0K3OXa5LolwnqVKF
         TdduAwM21gU5CWnx6GMbxCololcX7UkkkxF5x5+86OiQ6Dx5vb3kNUxVQOH9KqSR0Vo4
         hvGuFi+WC/5/N3JEYcjx9NQwslwj4iQ0Cs9yD93yqGbVth+KEPLGiMDeF4+XMb1nODVd
         8c90Yd2IvWa2h5AHqFkAWZVByeg71VhsVvQ6EEmd9UD77t156a6gdcShaMqO0x0R/ZMz
         18FduCtiaxl0SImN7q9qESixd6TERM6gc7tkQ2XPFvS6mHYsqJNwge53LKlAewlCL0mP
         TE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779824253; x=1780429053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=md2uP6TWkc+nCFlw3b5bLsdZ2L7ZjormopHq9oHVT0w=;
        b=H35qLKEcAWg3wuDzhZVcwVWia5d3HcOqH7O9P9E7BiD1u4zxeJ8D2rQixVnXh5yygq
         7v1iuglwwvXR+xoV/x0f6JhG9NtZO5uxpXtR9XHdjPSWbsMZWBXHQ9JnieZXUZsm6pq3
         CozmnU+0eQDpr6x65PlakHQpuRB2yu73cizzmh6t0QnJLZfC8TkHL88yf6OvFOE65ZAN
         I438lOeASG/AjQtV5To0lI/KIz3DpngR5hKcTMioGNFCkO5MT92twin76vgAQP9ZpJRZ
         3FPi6oH8XSUO9njiaeMOB/Ub6oRbHZ9Olwh1QrA7jXja/moTgVMnFSYRc48cJHgzkWta
         5sXg==
X-Gm-Message-State: AOJu0YyRFWJCvQTKCc+BfH1BdwsZ3rOgVCQ8uT6P9qLaTkH4U2B19FQV
	L8fY7LMgm4IJodaAeevykY3URF2ROPfVrNQ2U9JoD8Ge36qdJ4SoLc1KSd0P9mrXx1s=
X-Gm-Gg: Acq92OGdqXfYdeWo5ZeKYmCqzaL7Gra5AlPmQ4S3Z7kw0W0euXznrmcxlG+sFXO9gNj
	VYDa68NhuWPE03uC01j2vYs94+sfn8lujB0KHaJfqO18rwK34yheRKyLW48p8YzQsdPj8Zx/v3g
	KdHpJRGoLSHyZbfkhCG3nmroIOZ8n4U+X8sNr86PKu8V7WtY+64PEuV14wLBa3hryK0R3BeMV3z
	k2RjMo23uN3AnmYAuJ6zRFwiyk/ibGyOx/vdR+XYB+HBIRyn3llZ0YH6quuc5k2sVscNiC9CHGI
	6CnBnKH6C0tRKGxg/4PGiC4q40dBF0Diy6YCIMQ50Uh2EtmVDCBGI8cYp5UO1Rko82rmkN5tNLB
	y059pDRox9hvznwjOFu6ncwP7gzy9m1AznaCXM/BgvzF9/CLdsEX2phQdI+IY/lsWz9lEMC0zXv
	2y/Zctj+pgaQLuVLDFdYpY+3+/T39hPowrSx5XXpuGMzQmXtE/iGHDLMKf7gmQ+Q0ilEs=
X-Received: by 2002:a17:90b:48c7:b0:368:3fa8:dbfa with SMTP id 98e67ed59e1d1-36a6bcba085mr12565217a91.7.1779824252924;
        Tue, 26 May 2026 12:37:32 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a72c913a1sm12617283a91.15.2026.05.26.12.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 12:37:32 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH RFC bpf-next v2 0/6] bpf: better error reporting when verifier hits 1M instructions limit
Date: Tue, 26 May 2026 12:37:14 -0700
Message-ID: <20260526-better-1m-reporting-v2-0-e7ec61c45d41@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260525-better-1m-reporting-1d795a21cf72
Content-Transfer-Encoding: 8bit

When the BPF verifier exceeds the 1M instruction budget, the current
error output shows a random execution trace that happens to be active
at the moment, which is not very helpful for debugging.

This series improves the error report using a profiler-inspired
approach: collect and count "callchain" stack traces that the verifier
visits during program validation, and report the top 3 hottest traces
when the budget is exhausted. To minimize performance an memory impact
of such profiling, only collect samples when verifier visits loop
headers, iterator next, may_goto and callback-calling instructions.

For callchains ending at iterator next, may_goto, or callback-calling
instructions, identify which registers or stack slots most frequently
differ between cached and current states.

Here is an example of the report for scx lavd_dispatch, with verifier
limited to 200K instructions to trigger the error:

  lavd_dispatch():
    ; void BPF_STRUCT_OPS(lavd_dispatch, s32 cpu, struct task_struct *prev) @ main.bpf.c:889
    ... disassembly ...

  consume_task():
    ; bool consume_task(u64 cpu_dsq_id, u64 cpdom_dsq_id) @ balance.bpf.c:410
    ... disassembly ...

  #1 most visited simulated stacktrace (visited 1807 times):
    lavd_dispatch/124 (.../scx/scheds/rust/scx_lavd/src/bpf/main.bpf.c:1107)
    consume_task/2715 (.../scx/scheds/rust/scx_lavd/src/bpf/balance.bpf.c:316)

  #2 most visited simulated stacktrace (visited 1682 times):
    lavd_dispatch/124 (.../scx/scheds/rust/scx_lavd/src/bpf/main.bpf.c:1107)
    consume_task/2994 (.../scx/scheds/rust/scx_lavd/src/bpf/balance.bpf.c:386)

  #3 most visited simulated stacktrace (visited 8 times):
    lavd_dispatch/255 (.../scx/scheds/rust/scx_lavd/src/bpf/main.bpf.c:1022)
      Most varying: R7 (frame 0)

  BPF program is too large. Processed 200001 insn

Changelog:
v1 -> v2 (bots):
  - Use kvfree() in bpf_compute_loops().
  - Adjust fwd_edges_no_loop test case to avoid dead code elimination
    converting 'if' to 'goto'.
  - Use GFP_KERNEL_ACCOUNT for callchain entry allocation in
    update_callchain_profile().
  - Zero-initialize 'cc' in update_callchain_profile() to avoid
    copying uninitialized stack memory to the heap.
  - Use %td instead of %ld for ptrdiff_t format specifier in
    print_callchain_entry() and disasm_subprog().
  - Size printed_subs bitmap as BPF_MAX_SUBPROGS + 2 to account for
    fake and exception subprograms.
  - Fix bpf_sample_state_diffs() inner loop to iterate from head
    instead of pos_i, avoiding container_of() on the dummy list head.
  - Add DIFF_OTHER to distinguish states that differ because of idmap
    or other inconsistencies.

v1: https://lore.kernel.org/bpf/20260526-better-1m-reporting-v1-0-51e4f2c59780@gmail.com/T/
---
Eduard Zingerman (6):
      bpf: move live registers and scc printout to a standalone function
      bpf: compute loops hierarchy
      selftests/bpf: test cases for loop hierarchy computation
      bpf: report hot simulated callchains when 1M instructions limit is met
      bpf: report register diff summary for hot callchains
      selftests/bpf: test budget exhaustion profiling report

 include/linux/bpf_verifier.h                       |  39 ++++
 kernel/bpf/Makefile                                |   2 +-
 kernel/bpf/fixups.c                                |   5 +
 kernel/bpf/liveness.c                              |  22 +-
 kernel/bpf/loops.c                                 | 184 ++++++++++++++++
 kernel/bpf/states.c                                | 180 ++++++++++++++--
 kernel/bpf/verifier.c                              | 233 +++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   4 +
 .../selftests/bpf/progs/verifier_budget_report.c   | 175 ++++++++++++++++
 .../selftests/bpf/progs/verifier_live_stack.c      |   2 +-
 .../selftests/bpf/progs/verifier_loop_hierarchy.c  | 233 +++++++++++++++++++++
 11 files changed, 1034 insertions(+), 45 deletions(-)
---
base-commit: 8496d9020ff37a33c2a7b2fc84350fd03ffbde78
change-id: 20260525-better-1m-reporting-1d795a21cf72
