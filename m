Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4EA3D3D04
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779787825; cv=none; b=inRqGlhicAS2o+GHA6cPmQp7wr/pFsdbaQhJWfaHtZ+c4jtHy/pUDeCIOoi67fzW8KeCDjbw8NIc843AUhUpinSQCf46rCP0HBNpBs2LlJ5SIgq1Qjl2Fta5HZtEyVAtunIJpfQCLKvx3Vseu6Rl9jwA/vVVw0H/yT3Iln7CjZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779787825; c=relaxed/simple;
	bh=AXJky1QoACDDb68uZ5uCmIz6Ju0I1AgtzRA8+26qn0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vc3T8nY321rG0za1zXeVy564vqtQi7ULXRnMyaWumHJtqaLXZfYFXduFJyHrjLfZRsBzKHdHjiG0uCc38uc+8mhqUwAAOqc1V+NrZvZJ6PSWBFz38H27cO5twXq9sbyQCZAkCO6P8QtF4HarJgpTOiamoMHBxfBf5gb/Q3KPAQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qrV3yblD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrV3yblD"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso4687329b3a.0
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 02:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779787823; x=1780392623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C65iGHccWWX2I68l9x2s+ZPDS6hSZ2qXCg63fi52C8g=;
        b=qrV3yblDs8XJyF871FEMslGL+IyaCXLKx76kniteTDqekKofMN12Lm6hcLoxEQdRVL
         C7VX6Hb5lTPWAVduayLDxwhNDSpP2RsV2A5NuuEBbwUeWIfyd89aZ3eMed32em4renx4
         qrV+v/HLV56hEvjAPACWzvEj0/SCvzhFdyhqBlu7knF9Dcg71qm+G1L4NDRTPobKxXmo
         zNnj8vtCB6xhQLFWZmF2yJcETQ6cbV3Fi+FnUXhRr5pHEM5h6NboZOp8Rk06B9n+Cs2H
         WyQCkx+M+FdLA1NZd/m1X6maM5te7X8YbCfPKn5ZTDOM6RcTpmyf/VCfa0pW0Z3yDBpz
         nseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779787823; x=1780392623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C65iGHccWWX2I68l9x2s+ZPDS6hSZ2qXCg63fi52C8g=;
        b=aiimlsKefKGyijCN4UpthnSemHsWmjDjm6nyMf9sIJnVETXWfxR6JFHGQLIAsskwZg
         lRoJ3e8Rkff1c3BEUDcMEVQ3IdtrQGeiU+0iZkrvng23u8NMbywaE3LzR/fynZO6cdFI
         wFmaG70z5VHTKuXe5dTklhNIgV47UnfgPQYQhxMR/QW3s4NnfLaHcqSRYBdZgeiP1eaK
         iBs+FENbtuwO2r1z3pPeGYq8dZWT+9i/XJHHiZ9NSEby7Y5IXq0y28Jyn6ByqIiqJJYI
         nRKudulAZWib0lS5lKXkyi8VKmYFMaVdf3ZMqgRMRtYcRJt8zFUbjMZEPLyY3TdVHr2z
         /uIw==
X-Gm-Message-State: AOJu0Ywcp7FocH2IhLcyL94d3ZVCcpDsklP8wruBQUIZwXN1Qt7dpm7E
	CcXbhHQn19eJ6aIrtIrbNOYlWgGtqBvtr3ZQPf54J8/GefrCswjPHDCxb1x8GyePRAA=
X-Gm-Gg: Acq92OFxvH4QOPmEr17FfJ7zwMcF2GDOL/+RCGwwOm6hgJNa0NzO4BJfhJ/CS09ar3T
	kzs1KWxCe7Ukxh5vDTi7XOhXPbxTtFcfYD/z2lnk7fW/VBNjBYdHA8jvKjQ98yjzsZP7XrbXo2c
	MQOwlMvPnVrTaEXOVFIK1sWF7zpa6dDBLWbTb2spDaYj4pqSPiUyEoCgfNOSjeQkI5Oq3z5xnau
	ujZl3A+L4Kb7+UpPEjCO2WWlK1AtV4t2sp/T2RmvdWZhZOoEBPS6rKks+dZRPteKukrfCz5c3KZ
	G7kWV9aXRgS9J1Y7hUDi4IPKvBeQny9V9Vq5+FDEY2SiJczG+37laLsDFl29kf7HyfYeKEM+bcV
	6NrHO+zHAOUbjL3r2qCBY6JcThdk7cvFVaYNnbM15bphEDbIotg/widPWhAaV0HPeM842jtqVQ3
	hh+InzdnjSphlb5VTUv2TjWR9307TpWNoFMXXOdCQlY0kX0/UltOk=
X-Received: by 2002:a05:6a00:4388:b0:839:9ad:ee33 with SMTP id d2e1a72fcca58-8415f2d934bmr16811973b3a.7.1779787822819;
        Tue, 26 May 2026 02:30:22 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ff3e00sm13729505b3a.54.2026.05.26.02.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 02:30:22 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH RFC bpf-next 0/6] bpf: better error reporting when verifier hits 1M instructions limit
Date: Tue, 26 May 2026 02:30:01 -0700
Message-ID: <20260526-better-1m-reporting-v1-0-51e4f2c59780@gmail.com>
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

---
Eduard Zingerman (6):
      bpf: move live registers and scc printout to a standalone function
      bpf: compute loops hierarchy
      selftests/bpf: test cases for loop hierarchy computation
      bpf: report hot simulated callchains when 1M instructions limit is met
      bpf: report register diff summary for hot callchains
      selftests/bpf: test budget exhaustion profiling report

 include/linux/bpf_verifier.h                       |  38 ++++
 kernel/bpf/Makefile                                |   2 +-
 kernel/bpf/fixups.c                                |   5 +
 kernel/bpf/liveness.c                              |  22 +-
 kernel/bpf/loops.c                                 | 184 +++++++++++++++++
 kernel/bpf/states.c                                | 174 ++++++++++++++--
 kernel/bpf/verifier.c                              | 230 +++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   4 +
 .../selftests/bpf/progs/verifier_budget_report.c   | 175 ++++++++++++++++
 .../selftests/bpf/progs/verifier_live_stack.c      |   2 +-
 .../selftests/bpf/progs/verifier_loop_hierarchy.c  | 223 ++++++++++++++++++++
 11 files changed, 1014 insertions(+), 45 deletions(-)
---
base-commit: 8496d9020ff37a33c2a7b2fc84350fd03ffbde78
change-id: 20260525-better-1m-reporting-1d795a21cf72
