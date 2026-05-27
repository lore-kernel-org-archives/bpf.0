Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A343914EB
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779867007; cv=none; b=WoDV3GgNmmzfzXX6jxPs5l3VOmp7s68/72JhcT1UScEakhIxtQE5OIMWNydjL2RJtgEB+K5YpvEMLfrkdSAu0PssK2yJp3Zc42ICPmHRA+qFk4Ac2uUxuXlO4BAgL/HiY71wbPZzLrWtCS1GDb1ZlkJOX5yymvbMOZkjBgMUQeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779867007; c=relaxed/simple;
	bh=JekZNHK27OV2qfw8tweEz4qRmOqn5klLOdLH6TbWIvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IEqAxgyfgW/WOtd0T2pzbiJN2usebc4KsgAnTA6ZwywQWsHn9TMbAU5Z02TIkR0eZfcV1RAUpi8cJf3c117HAzllBT8aRPhWD3ABfLVdPlJ7oCng06EkNAzqHTiZ32AGcML4S1Ug3PLeAn5lSGpe0+E8CW0vgJxrumWZ56KaCRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itCf3/gI; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itCf3/gI"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2babfd18435so51257185ad.1
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 00:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779867005; x=1780471805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=71d3Zbk+EkoVNmUawh4eU+wTRPiNKxzex4RZfCeYnBg=;
        b=itCf3/gIXjAQ4jQTW3gb+YxTrxClqBt9fGSaj0e14AM87C5dK/M6rinCYw6FcG9YCk
         OV95PXZloJIGxIArNMCKAZ4W6Al0ciRF/f/0w1RgYnMlUarXLwnoIDWePIL9hJn+BQMP
         bg8tD4Xnc/P6/h5BeT+DbQC7gOC8tTkNz25F2v/Mgg26BpaERWV4quQnFMUnprNle4qw
         WOEXgXWiSi8ofk11m9tS4YsYv2KI8ihV+c/fU+xrnXweFjYXMXKF/j3JD82OBD9ZT5z1
         6bmzYgLEaqvGuBAfG7tmLcxrcQ0PS2cbKNT47CGuihG5XMpMneX4s5BlEUU6L69g+Lvp
         LIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779867005; x=1780471805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71d3Zbk+EkoVNmUawh4eU+wTRPiNKxzex4RZfCeYnBg=;
        b=ILrPvfyW4tgy+VASRBw2ZppLmdEzc04T+Vpd5lV2/mgrbEi6PIoYCl07kifxnAGrQd
         UeOl8l7NMd/03RxD3o85erqOxkopW+e6OFS5C391kPezhOD5m5Psyh2LRjXNvmYbqhoC
         lNb2N3Q5JCJUvVAuQswaZEdKPwhAvHbz6FOs6AmdVcxW/FD3955XCACDFSY5aHqmjZGT
         7vxG0Ho3OHqkOeYHqWuyc3mD//xwKZJkFlidMMau6P2Gu4eCcVWK7MrOZAW2f6/qARI6
         QMH3I4aidbX4E5AEXVZwH8uEM0sbYMftHcEhLMbGDUUxPknsRWtmvoR6ZhBBYNjrwVAb
         Afww==
X-Gm-Message-State: AOJu0YyY767U5hyp1CaTPLwJN1uvtEvwbVysEJ+52FZl2VMdI6fwXZp7
	5q6ze5qKS9vT4rdVCXeHVGFShv/4ln04ZyMqobvCHnVNjtFtwpSXysX3RNDOF2Qu
X-Gm-Gg: Acq92OEteVDA8LDfrNdYQet9kA3uBTCOWnfgPfZUc7WZ0ePBf2I8U8Pm2h3wWJ8Qcgp
	4Q51CNQ1xhhuAM7fRZeyOkW1PoX0pC0uwmRpiJyKMRGQTHZj/4/D0Q9cvSBkQ/xxFWEwSo45sxb
	qCw31KPZYLZmpFrM7Kq4MeVv2G728q6G/QWPAGzTk6xQo2VWfNZ7fU+HPodCDOiTPDKY+m9QUp/
	bhwivyulJoB5VI0iY1dqBVr0rz0rK8fG3oOfwKrhoNkLQ/KVl/BWp6MbXajDI87iLwMenjRbAv4
	zNNjFuP8qq0NwM+kTHBe3ddBpugGKAAKa4DHEGNZW4uxGlM6gVUiFvyq6n/PC9XaZS8fg2oxpdy
	qlXWeZ/Gb+k2FlwKsNthtdqjanCRl9v42H+k78BCkuMHmXA/Dc2oq3JLxp8y8CdrZAIBN8BVGwn
	5dJghItMmVJBlgqrdNGNxsyVlQVG+DOMzpLBkSvRxp
X-Received: by 2002:a17:903:46cb:b0:2bc:f3c5:ff0a with SMTP id d9443c01a7336-2beb060dda9mr234719925ad.30.1779867005283;
        Wed, 27 May 2026 00:30:05 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm89242325ad.2.2026.05.27.00.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 00:30:04 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH RFC bpf-next v3 0/6] bpf: better error reporting when verifier hits 1M instructions limit
Date: Wed, 27 May 2026 00:29:48 -0700
Message-ID: <20260527-better-1m-reporting-v3-0-b3ede0588a75@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Here is an example of the report for scx lavd_dispatch (an old
version), with verifier limited to 200K instructions to trigger the
error:

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
v2 -> v3 (bots):
  - Compare leaf instruction index in callchain_matches_state().
  - Use cmp_int() in stat_diff_cmp() to avoid overflow warnings.
  - Add a comment in bpf_sample_state_diffs() on why it can't stale.
  - Add cond_resched() call in bpf_compute_loops() to guard against
    pathological inputs.
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
v2: https://lore.kernel.org/bpf/20260526-better-1m-reporting-v2-0-e7ec61c45d41@gmail.com/T/
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
 kernel/bpf/loops.c                                 | 196 +++++++++++++++++
 kernel/bpf/states.c                                | 184 ++++++++++++++--
 kernel/bpf/verifier.c                              | 233 +++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   4 +
 .../selftests/bpf/progs/verifier_budget_report.c   | 175 ++++++++++++++++
 .../selftests/bpf/progs/verifier_live_stack.c      |   2 +-
 .../selftests/bpf/progs/verifier_loop_hierarchy.c  | 233 +++++++++++++++++++++
 11 files changed, 1050 insertions(+), 45 deletions(-)
---
base-commit: 8496d9020ff37a33c2a7b2fc84350fd03ffbde78
change-id: 20260525-better-1m-reporting-1d795a21cf72
