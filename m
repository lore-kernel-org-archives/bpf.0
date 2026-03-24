Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DAB2F0C48
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 19:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379032; cv=none; b=Xb4a7ff+yh4Aig9cX1DajKx6BKasFWhlfJdnfPQNgwoR1ZI9XLr+bWAWqdX79ob2jBzbuJV9oW0Vdl7suDGeKKYgw8AZYZ5X75sVo//qsMj8lCFBsUNuCm4b1v9gv18CQGhvth6ESZUVj9kKhub92sCRd/2V6rDEZrD0Bk7bRFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379032; c=relaxed/simple;
	bh=qMafLFslBoAZIgi3n0NnnHOy+e9vNSlL9xGUb/r3qz8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SMfb56vR5PX/OzFBNXVkisAOfwX9MQKloOyGutBfxVvlzg4dSxIrksaTIVtoAqKXJmRCC9kya921uAOcPjgfbIk5oBUH2T6WhXRIa2Y41SXdqJcZGER6hTs7AUCTNnCGyNLsrUeNw80LkR6RG/DCrQ2bnxuP/xK1e8UkdESnQ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtPMYEsx; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtPMYEsx"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so1742645e9.1
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 12:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774379030; x=1774983830; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P7sMvSM0uzhTXusorax0MHfvfpOgqNJLFzFz/e0UbAY=;
        b=KtPMYEsxvRLjqezMfWCqgWdNSxdsictoZjvJcZLplRCgXksB8nPUFnOsYtAjptCdgS
         hryuNmnAGlZxramFWz0TRF1VmDuyheSU5FB3OrFwqNAStGxaZ5H2j7BC1IHteePoghBu
         Dip5Ni/2v9X/AsVu69d5qDot8K0eKCYT4bYbE5og4r/+Mi2ymZi+GjzMfRzqvhKBc1kn
         B+0zyk6FNpeI1EgJF0FPh1ug5hbhCTXjJhs67dxkHc0FREAeU753h+JiZt5cDdqLQl/X
         XSLSGpxpAGZ4EM6mTHhEZb9q8vA3XCEvLO16hfYB5Ccdjawzbk6GUfe8E49K+nGCH0ag
         t2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774379030; x=1774983830;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7sMvSM0uzhTXusorax0MHfvfpOgqNJLFzFz/e0UbAY=;
        b=dOl0bza22f9B3XikJf4V4ffzIitCmH4/Bdl7xUxoLxkBj47CkR83RJc2DUIEeSYrod
         k2WKcAWLFjGPBwFGfsuP6q3fQYt14EA1z3cMvRT+YEXR02LkKFk/2pSDxvvaU1MfATtj
         cQ0J6SFzL88Qv4SBzbagWJWDTgIV3tQjpZaUfvpT9aZzISfHoRlvDgulIPCm4+cZVcfo
         kTEId0NPqXWrPRbQgS8tr/x/nfzaf2QkqzZ1XLvUc4l4g0dLpFhF3dzHV28x3jokDOP/
         2A5Qp05Q9tz2VZyLTQNCN0MJtecgKPGz4teOU3UeJPSGCHf+FoaClS+py2c0u9fIpQhm
         yvmw==
X-Gm-Message-State: AOJu0YwpnJI777YHv5/ZVN2M0zaAZSDW6ibvSP35eUQNyO+4GcWVzLaE
	wH7B67ztj0OIRgBWWPVD2hLvTCE8cXA7RLbVSR1rNV6zjsCANN4/ykEv
X-Gm-Gg: ATEYQzwYkgLkICxvJmywAY9LcLw3/IBxTGTvt6ZCcX+7q40nyt89Lu73B9nmbXOuGGQ
	yBbBDYEKf3kOYFvKiOiqkrKrgzV5Un0Kn3idg+vPaHgDwwgHfo+Q0tyMBwLnhW9nWrCwbGtORN6
	pbrcap2tTeoS71Zga5so63OdBTP5WUXi4o1qrwyA8xQ+iVSLjRfuvXG6koULyjcpVh79LHaDQO6
	QA+w/V3VqgEqOf7Psh5zwwt0zDQ3dNfczNvd9RfF2xIbAGRkduYiCCOYHCnVUY1irD2wr0Thi9S
	yCzYoyXKRSjwnnKMOnT6Q6EZ0Lr3GSCF3YXKuzAToa4CXZ33KENti/LFDJTGQqwWr6lLg4elRB0
	UueEr4BdeKrEgNOvx+Y+pkDjqdRbaru7vqsgj0jExH5+GahsdM4O9pe4e43zZGVm5MRQH15n+9C
	YE8GpwkAHrjrB4Tcq8VmPz7JE=
X-Received: by 2002:a05:600c:4f89:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-48715fc75b2mr11728355e9.3.1774379029473;
        Tue, 24 Mar 2026 12:03:49 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116ac0a8sm124801175e9.6.2026.03.24.12.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:03:49 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v6 0/6] bpf: Add support for sleepable tracepoint
 programs
Date: Tue, 24 Mar 2026 12:03:38 -0700
Message-Id: <20260324-sleepable_tracepoints-v6-0-81bab3a43f25@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAvgwmkC/3XQ0WqEMBCF4VcJc+2USeKk1qu+RyklMWM3sKtiQ
 tiy+O4Fe1FZ8PrAd+B/QJY1SYZePWCVmnKaJ+iVaxQMFz99C6YIvQJDxpHRDvNVZPHhKl9l9YM
 sc5pKRttpL7rVxEzQKFhWGdN9dz8gLCNOci/w2Si4pFzm9Wc/rGbf/2zDJ3Y1SEjWUvRjdEzj+
 02Kfxnm2w5W+49Yrc8Qi4RW3kKIwiEa84S0R8SeIS0SRgmD6zrvXLBPCB+Rs1SVkbBjNhzlVUf
 DB2Tbtl/9QpnxkgEAAA==
X-Change-ID: 20260216-sleepable_tracepoints-381ae1410550
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774379027; l=5642;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=qMafLFslBoAZIgi3n0NnnHOy+e9vNSlL9xGUb/r3qz8=;
 b=sPG7yDBYDYGw1LkkTa0lB6/ZwyU10U3dd4BeCaCn7JXnA4HcEYo7/oMJlmgjDZ2Di3g/yR+1+
 J4vFu8+mCfKC58BM1eqsUJU/RgZPdKg8vz/3gPHX+5FmYAzxsLMWg7t
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

This series adds support for sleepable BPF programs attached to raw
tracepoints (tp_btf), classic raw tracepoints (raw_tp), and classic
tracepoints (tp). The motivation is to allow BPF programs on syscall
tracepoints to use sleepable helpers such as bpf_copy_from_user(),
enabling reliable user memory reads that can page-fault.

This series removes restriction for faultable tracepoints:

Patch 1 modifies __bpf_trace_run() to support sleepable programs
following the uprobe_prog_run() pattern: use explicit
rcu_read_lock_trace() for sleepable programs and rcu_read_lock() for
non-sleepable programs. Also removes preempt_disable from the faultable
tracepoint BPF callback wrapper, since migration protection and RCU
locking are now managed per-program inside __bpf_trace_run().

Patch 2 renames bpf_prog_run_array_uprobe() to
bpf_prog_run_array_sleepable() to support new usecase.

Patch 3 adds sleepable support for classic tracepoints
(BPF_PROG_TYPE_TRACEPOINT) by introducing trace_call_bpf_faultable()
and restructuring perf_syscall_enter/exit() to run BPF programs in
faultable context before the preempt-disabled per-cpu buffer
allocation. trace_call_bpf_faultable() uses rcu_tasks_trace for
lifetime protection, following the uprobe pattern. This adds
rcu_tasks_trace overhead for all classic tracepoint BPF programs on
syscall tracepoints, not just sleepable ones.

Patch 4 allows BPF_TRACE_RAW_TP, BPF_PROG_TYPE_RAW_TRACEPOINT, and
BPF_PROG_TYPE_TRACEPOINT programs to be loaded as sleepable, with
load-time and attach-time checks to reject sleepable programs on
non-faultable tracepoints.

Patch 5 adds libbpf SEC_DEF handlers: tp_btf.s, raw_tp.s,
raw_tracepoint.s, tp.s, and tracepoint.s.

Patch 6 adds selftests covering tp_btf.s, raw_tp.s, and tp.s positive
cases using bpf_copy_from_user() on sys_enter nanosleep, plus negative
tests for non-faultable tracepoints.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Changes in v6:
- Remove recursion check from trace_call_bpf_faultable(), sleepable
tracepoints are called from syscall enter/exit, no recursion is
possible.(Kumar)
- Refactor bpf_prog_run_array_uprobe() to support tracepoints
usecase cleanly (Kumar)
- Link to v5: https://lore.kernel.org/r/20260316-sleepable_tracepoints-v5-0-85525de71d25@meta.com

Changes in v5:
- Addressed AI review: zero initialize struct pt_regs in
perf_call_bpf_enter(); changed handling tp.s and tracepoint.s in
attach_tp() in libbpf.
- Updated commit messages
- Link to v4: https://lore.kernel.org/r/20260313-sleepable_tracepoints-v4-0-debc688a66b3@meta.com

Changes in v4:
- Follow uprobe_prog_run() pattern with explicit rcu_read_lock_trace()
  instead of relying on outer rcu_tasks_trace lock
- Add sleepable support for classic raw tracepoints (raw_tp.s)
- Add sleepable support for classic tracepoints (tp.s) with new
  trace_call_bpf_faultable() and restructured perf_syscall_enter/exit()
- Add raw_tp.s, raw_tracepoint.s, tp.s, tracepoint.s SEC_DEF handlers
- Replace growing type enumeration in error message with generic
  "program of this type cannot be sleepable"
- Use PT_REGS_PARM1_SYSCALL (non-CO-RE) in BTF test
- Add classic raw_tp and classic tracepoint sleepable tests
- Link to v3: https://lore.kernel.org/r/20260311-sleepable_tracepoints-v3-0-3e9bbde5bd22@meta.com

Changes in v3:
  - Moved faultable tracepoint check from attach time to load time in
    bpf_check_attach_target(), providing a clear verifier error message
  - Folded preempt_disable removal into the sleepable execution path
    patch
  - Used RUN_TESTS() with __failure/__msg for negative test case instead
    of explicit userspace program
  - Reduced series from 6 patches to 4
  - Link to v2: https://lore.kernel.org/r/20260225-sleepable_tracepoints-v2-0-0330dafd650f@meta.com

Changes in v2:
  - Address AI review points - modified the order of the patches
  - Link to v1: https://lore.kernel.org/bpf/20260218-sleepable_tracepoints-v1-0-ec2705497208@meta.com/

---
Mykyta Yatsenko (6):
      bpf: Add sleepable support for raw tracepoint programs
      bpf: Rename bpf_prog_run_array_uprobe() to bpf_prog_run_array_sleepable()
      bpf: Add sleepable support for classic tracepoint programs
      bpf: Verifier support for sleepable tracepoint programs
      libbpf: Add section handlers for sleepable tracepoints
      selftests/bpf: Add tests for sleepable tracepoint programs

 include/linux/bpf.h                                |   7 +-
 include/linux/trace_events.h                       |   6 +
 include/trace/bpf_probe.h                          |   2 -
 kernel/bpf/syscall.c                               |   5 +
 kernel/bpf/verifier.c                              |  13 ++-
 kernel/events/core.c                               |   9 ++
 kernel/trace/bpf_trace.c                           |  50 ++++++++-
 kernel/trace/trace_syscalls.c                      | 110 ++++++++++---------
 kernel/trace/trace_uprobe.c                        |   2 +-
 tools/lib/bpf/libbpf.c                             |  39 +++++--
 .../bpf/prog_tests/sleepable_tracepoints.c         | 121 +++++++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints.c         | 117 ++++++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints_fail.c    |  18 +++
 tools/testing/selftests/bpf/verifier/sleepable.c   |  17 ++-
 14 files changed, 444 insertions(+), 72 deletions(-)
---
base-commit: 6c8e1a9eee0fec802b542dadf768c30c2a183b3c
change-id: 20260216-sleepable_tracepoints-381ae1410550

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

