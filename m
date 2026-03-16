Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB591DFFB
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 21:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773697611; cv=none; b=Clwbg75xBGiwN7LRBFCM0IaBlhIb6jjm3VvS7a6tvHHsyws1HracAjpIgx9bAH0vRnvRTpl/U+sIzKuuL/ajoK9NBtdvuEHNBTRFDlp71uJkBIFwU5li6tKCE+6r5eRdUFMWXlJpGGhgqz67VyxgI1VnuBK8NEH4pyb7UGWexr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773697611; c=relaxed/simple;
	bh=0TCB1mRvNzUyaS6jYuSLUoxYGNL/GlndKNUm7PtPq24=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ug0ASTm5nNVLhoCnmWqFktw7b237aopcx48SXcfsH89hm8/nDdE4e6iRm7/ngi2JltUhad8nDbcz2X1OcCsUJvTIZADPip5Lhz3MIbLSLzkpa63TB30kp+tDsI/vYVzt3xUdBsFKw6jQ+uw/1NGcrQwDSV1lpLWhgBdE6isI7TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVtxvnpN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVtxvnpN"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43b49819938so194638f8f.0
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 14:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773697609; x=1774302409; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5LaowT57dXt6pN49sUmezwVmqnaftgEPYUZnOkWcf+Y=;
        b=ZVtxvnpNO8bqdIfVx+A7KkKS/7CLhL9JsdpEdg4tRet1r1be/lxXjunci0PV2Moyni
         PTn9BQtraMv+GCQc8EZz5hAv2/OPu+NlWTLRkUzuiivlLp/ZhLvAx8bsGi7e56CjA3Mt
         Urhp9IG/D7F0ZpuCQRgVCTYoqEb5LGKfWHkgnYjEhvPCkgoQsIRnVq93DayaQkp8pl8A
         5dEciicLpMlQIhva4FUcAYK0+8oY3hOR0/7+APMYNy0vOjlBTZWrG8s2n61yHDB72uqm
         MN+XuMzTQ7VDbypqiEQhv6pyOg7rkupCNHoqiLXpT3ddbdDesNTg+QkYJjd5NMNn8WX4
         NYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773697609; x=1774302409;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LaowT57dXt6pN49sUmezwVmqnaftgEPYUZnOkWcf+Y=;
        b=JlZkUEXty6VfHmAQlIFISXu/dmx4HplYEnHKLATSyofF606VfwFQXO0Z+DH/UJ5a+w
         x3yJ7lUTgxxcV67/sHd0ru7ndNOxcbKF9mD3csyOncJpCEi0jOmS+kCsS01r6dg+NFLt
         yJalPowJq3xKKIhjXQNJWv0VntbeyIOb1YP8eembdRFTo21DFQS2MXIaI4h9F84OOzR6
         RiOPtk7Smrp0wnMFderfYHaPcoTGn893ciJ0eggRV+Onji+a6D0dX+EzhrH00XggcDlY
         +kaCJ6Y5Qp6oiCjIWsEv7F941G5UYAf16Fw7V9BPgt34uaAsxXhIr+imLZLd1mDJ89pu
         +FXQ==
X-Gm-Message-State: AOJu0YwDZa0MZku8qP9g0JMcNGy0f/MI8jf5FGzWkvjx2rWrz2l6NaXB
	Ioamjg+yElJdEPr6KmKKP2rb+dg4aNp/uYkSs/MMyhej95RbvBgV5CT2
X-Gm-Gg: ATEYQzy7FmV7CKGxqrAcUne4naT7xVapypEAoaV2BIudxdkXl7ZSz7jICbSk6jT1POF
	ehV14ynlGQFs3JVzo7VXE7IVLfVv29oIF/LQBqnVTG+cbMEQMIyYX+l4atDUIY+omKLkz2VgM4/
	HhOBE8m3nYVDYeqYRaNFJb4fG5tuhw+nHP/jVvaqc7lnoHqMmUmgrFeXrKmERSVOB0dQexU3fWs
	EcYeZSXon1IZpQ/FW+XljxhgVUYxAK/IaQlTAs647rpE+3/7hOfb8pAHUjk4IWjr6khqfgAll5p
	F09Ucck2MKRkeRFymK05RumhtTeNBx7TzQKEHtgVmx9znkgCpNW9NyYuofUp3LEWVBdz7NVeAEF
	OOyNyalb1V0jLlpTahazd9r1KXvl82/DKwL/1HiXbIwnWaqRAGhFYRCqQU6RSpk+gPUOuiaaMwX
	LKxBdGh+IRWmrBltQbjOc/ERCG
X-Received: by 2002:a05:6000:2501:b0:439:ac8f:5da5 with SMTP id ffacd0b85a97d-43a04d7817emr26550335f8f.8.1773697608436;
        Mon, 16 Mar 2026 14:46:48 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:75::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b419270efsm14426942f8f.16.2026.03.16.14.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:46:48 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v5 0/5] bpf: Add support for sleepable tracepoint
 programs
Date: Mon, 16 Mar 2026 14:46:43 -0700
Message-Id: <20260316-sleepable_tracepoints-v5-0-85525de71d25@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAER6uGkC/3XN0QqDIBgF4FcJr+dQ/5S2q73HGEPzbwmVoRKN6
 N0n7WIx6PJwON9ZSMTgMJJrsZCAk4vODznIU0HqVg8vpM7mTAQTigmuaOwQR206fKagaxy9G1K
 kUHGNvORMSkbydgzYuHlz78SMDR1wTuSRm9bF5MN7O5zE1n9tIQ/sSVBGGQCzurFKsubWY9Ln2
 vcbOMEPAc6PEMgI4MUYi9JYIf6Qco/AEVJmxKKpVVVppQzskHVdP2pd/ypNAQAA
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773697606; l=4903;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=0TCB1mRvNzUyaS6jYuSLUoxYGNL/GlndKNUm7PtPq24=;
 b=pAVNnEut5geiyUk/PrFgXJGnXOUv1fJH7eWR2GLmrhw02pACWFH2mkLerzUWuv49J/HoG8w3j
 vthLcav9M06AGrhvx8Sce/kX5rjUxX+B1fyILqq1GyOR0Ys2x00ceno
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

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

Patch 2 adds sleepable support for classic tracepoints
(BPF_PROG_TYPE_TRACEPOINT) by introducing trace_call_bpf_faultable()
and restructuring perf_syscall_enter/exit() to run BPF programs in
faultable context before the preempt-disabled per-cpu buffer
allocation. trace_call_bpf_faultable() uses rcu_tasks_trace for
lifetime protection, following the uprobe pattern. This adds
rcu_tasks_trace overhead for all classic tracepoint BPF programs on
syscall tracepoints, not just sleepable ones.

Patch 3 allows BPF_TRACE_RAW_TP, BPF_PROG_TYPE_RAW_TRACEPOINT, and
BPF_PROG_TYPE_TRACEPOINT programs to be loaded as sleepable, with
load-time and attach-time checks to reject sleepable programs on
non-faultable tracepoints.

Patch 4 adds libbpf SEC_DEF handlers: tp_btf.s, raw_tp.s,
raw_tracepoint.s, tp.s, and tracepoint.s.

Patch 5 adds selftests covering tp_btf.s, raw_tp.s, and tp.s positive
cases using bpf_copy_from_user() on sys_enter nanosleep, plus negative
tests for non-faultable tracepoints.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
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
Mykyta Yatsenko (5):
      bpf: Add sleepable support for raw tracepoint programs
      bpf: Add sleepable support for classic tracepoint programs
      bpf: Verifier support for sleepable tracepoint programs
      libbpf: Add section handlers for sleepable tracepoints
      selftests/bpf: Add tests for sleepable tracepoint programs

 include/linux/trace_events.h                       |   6 ++
 include/trace/bpf_probe.h                          |   2 -
 kernel/bpf/syscall.c                               |   5 +
 kernel/bpf/verifier.c                              |  13 ++-
 kernel/events/core.c                               |   9 ++
 kernel/trace/bpf_trace.c                           |  60 +++++++++++-
 kernel/trace/trace_syscalls.c                      | 104 +++++++++++----------
 tools/lib/bpf/libbpf.c                             |  39 ++++++--
 .../bpf/prog_tests/sleepable_tracepoints.c         |  57 +++++++++++
 .../bpf/progs/test_sleepable_tracepoints.c         |  75 +++++++++++++++
 tools/testing/selftests/bpf/verifier/sleepable.c   |  17 +++-
 11 files changed, 323 insertions(+), 64 deletions(-)
---
base-commit: 6c8e1a9eee0fec802b542dadf768c30c2a183b3c
change-id: 20260216-sleepable_tracepoints-381ae1410550

Best regards,
-- 
Mykyta Yatsenko <yatsenko@meta.com>

