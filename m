Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E0126299
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776886949; cv=none; b=E3H0Wmns8/zC6lRCrQqWThSTPv2sG5aGoMpt8y/MmOVXkIJCstdZX4lVwZK82N7eH30Rw1L8gvghH6GfuHAWiACfTTOSdi600E2Gpws8olJdwhU8mq2D/8VUOCUfsgDEvkZOLjQ5H6PNooXWH7AyLFkNP5eULiIkrBlrQzBBTcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776886949; c=relaxed/simple;
	bh=na9W9joWQ4F18Q8aj4gshE/o9TRup0bFoZ9JF8QQse8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZVh1CHqkTb6K6OvzBkBzUF0aZWNTsG4t887oxoTT71Ba+VX5tVHsYvIc/+8S4y6P4wUzAs47tZx7zrwxpxm+kMIcpYI3YSTXALazFWLc3TcFpPOlaW58j2eU3LTphKziT2bPUWOePAB3qQOWEB9Z2Svt7gr9544AoRH84qHOAac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2aY+Shb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2aY+Shb"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso38570725e9.2
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 12:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776886946; x=1777491746; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3rxj5d+sjsfNqhQ/eswb1/whpxOAswI259Z6Dtwry2U=;
        b=e2aY+ShbZi4Cu7LhKk0GRfWqJiYUXzgw3zhUW3eBLjf9EB12D5Db7VQmJXKmwYQ6r2
         aa2YugCgnrDCdmzqC/WbYIbDujPM7Wj62W/f4k5pj2/EzjKopUrMbXb22NjfPFN/AJrg
         ZHEHyBOztpfgbSqTR3/6A0lIURFNPLqhNNeju/J4GdYObN4P4WKj8PuVxgEB5T420Ioe
         DPm4yfjxf/vtfLYL81fnwCNPMtRfRTw3VKYlmOYug83gryJeQDOc6hzD9E4czJKiPoVQ
         GvJyo/29xjscFbqd/y2OKMME9OQO0cu4z723ptwSC+KC7vvL61eX3TdURn2rBJiZy58h
         RnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776886946; x=1777491746;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rxj5d+sjsfNqhQ/eswb1/whpxOAswI259Z6Dtwry2U=;
        b=DndnCL9wsWmI6SKDCMggwJJoAxzhA+0nrQHCWvzapUeJlignClKfxie+6KIZX2nsD/
         FDWjZhzSq9xEKIjJoJovWxJyKgC5tptwl/BvJzUpqT0Qm6pB6JtXoEw1M1t/xH7p79is
         DogX4PjCxu9cT5sJDNkg9+uV5jy9PjkTuxUrIoWn7WiWGqlz7Ld5xKnWP/9OZgd0E9dH
         IVDNynR0Je4yYrymADUj5zzGN7n12f+C6lxq0wrOjfEY3z+hxlTczgjjwcVZ6NUkkYaA
         jBaDwGFxQsq4m9aleL9fMUgo/s8hying6Ru6JnHYTKroTxjB8VKTZebmZBIJ4mZztb9o
         vzxw==
X-Gm-Message-State: AOJu0Yzvur8QGBn438SzIRHMz4ndki0/aRsnpxWRzs7fHZqpjeX3eA0q
	yS5tIYRk4BsLmm2T4PIrX5QmjtslVVKLvKrpcytNYtQ09FRpl3ZSmoMe
X-Gm-Gg: AeBDiesOg7+YITmtKc6a3T4FgJfkwe+9sULz1AgiWpYkc+vKHqZDd1rTaY2u8MB7bEv
	D/qRuBkXxnbzfFqTM/sf1U13EhFUGRsiCxuN+dAwrssjU1H0SFkbileVQPq36ed8yvFNX9A6YBt
	cAdK0rDG9FXgXFuVNiewjFHGLQdf8MiTZySzVzR56pvmIwxGZ5bsKe+uADwdztrSoVQgVPc/KVa
	xSCaH6JTbvCIDX0MmrIn8UphJb6MNIchkf77aFN3hh8Uh+XAxn2eOuTBxNCaLk4ZGT+gkKnLGgd
	J45kkGrEFt29h+ijZCOoaD0KUWCtbYolAyKPaKWFKSA71hKwcJOaUDyF9B7R5gMBXUs4VVAK8g7
	M89nXMvdATa2IOZUpCd/qWlUjTR+LwG81+GEUCXLXjQ/MntSlmW9K0eTyfI/Ya6yO6dzD+6qraE
	ToUNTLy1SIJ2fwwjielqusJqlH
X-Received: by 2002:a05:600c:a30a:b0:48a:581c:ead with SMTP id 5b1f17b1804b1-48a581c113cmr81903155e9.10.1776886946313;
        Wed, 22 Apr 2026 12:42:26 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:41::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891bb3d121sm417549875e9.14.2026.04.22.12.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 12:42:25 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v13 0/6] bpf: Add support for sleepable tracepoint
 programs
Date: Wed, 22 Apr 2026 12:41:05 -0700
Message-Id: <20260422-sleepable_tracepoints-v13-0-99005dff21ef@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFEk6WkC/33STWrDMBAF4KsYraMyP5IsZ9V7lFIka9QY0iTYx
 qSE3L3EXUS4qOuBb3hv5qYmGQeZ1L65qVGWYRrOJ7VvkHeN6g/h9Cl6SGrfKAJyQOj0dBS5hHi
 Uj3kMvVzOw2meNHsMggbBWlC7Rl1GycN1hd9UvGR9kuus3neNOgzTfB6/140LrfNfm2zFXkiDB
 mZIISdnIb9+yRxe+vPXCi78RBixhrAGzdLFmMTGRLRBTIlwDTEadJLYO++Dc5E3iC2RWlWL1aC
 9tWSTtJjIbhBXIGRqiHsgGEPkYDj/QdoSsf8hFNFTCr0E3MbxBcJQQ/wDESY2rs0cYIN0T8RgF
 ek0aGmxE+eMeNNvEIRSqeZB0KDRYTYQmVNqtwwWDFVfBfFxZp8zsk8uw7ZcpJKhKvP429aYmEE
 4MmLB3O/3H/rqvhl8AwAA
X-Change-ID: 20260216-sleepable_tracepoints-381ae1410550
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776886944; l=7380;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=na9W9joWQ4F18Q8aj4gshE/o9TRup0bFoZ9JF8QQse8=;
 b=sXWNCuW3DWLkEV1fYQ6/uTcSVdx9lPj7YUisvBZTaYSgZILxWZ3Ux4/Og/V85sz3/ZqJz22iL
 m5IxGf3Kz9XDVX9QhzOPZMeJNXPKEsaKVy3SIO3qX7VxkurznLOlK68
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

This series adds support for sleepable BPF programs attached to raw
tracepoints (tp_btf, raw_tp) and classic tracepoints (tp).
The motivation is to allow BPF programs on syscall
tracepoints to use sleepable helpers such as bpf_copy_from_user(),
enabling reliable user memory reads that can page-fault.

This series removes restriction for faultable tracepoints:

Patch 1 modifies __bpf_trace_run() to support sleepable programs.

Patch 2 introduces bpf_prog_run_array_sleepable() to support new usecase.

Patch 3 adds sleepable support for classic tracepoints
(BPF_PROG_TYPE_TRACEPOINT) by introducing trace_call_bpf_faultable()
and restructuring perf_syscall_enter/exit() to run BPF programs in
faultable context.

Patch 4 allows BPF_TRACE_RAW_TP, BPF_PROG_TYPE_RAW_TRACEPOINT, and
BPF_PROG_TYPE_TRACEPOINT programs to be loaded as sleepable, with
load-time and attach-time checks to reject sleepable programs on
non-faultable tracepoints.

Patch 5 adds libbpf SEC_DEF handlers: tp_btf.s, raw_tp.s,
raw_tracepoint.s, tp.s, and tracepoint.s.

Patch 6 adds selftests covering tp_btf.s, raw_tp.s, and tp.s positive
cases using bpf_copy_from_user() plus negative tests for non-faultable
tracepoints.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Changes in v13:
- Invert if (prog->sleepable) check in bpf_prog_run_array_sleepable()
- Link to v12: https://patch.msgid.link/20260422-sleepable_tracepoints-v12-0-744bf0e3b311@meta.com

Changes in v12:
- Style improvement in the bpf_prog_run_array_sleepable(): use guard(rcu)(), remove
unnecessary defensive programming artifacts.
- Link to v11: https://patch.msgid.link/20260421-sleepable_tracepoints-v11-0-d8ff138d6f05@meta.com

Changes in v11:
- Avoid running dummy prog in the bpf_prog_run_array_sleepable()
- Migrate selftests from nanosleep() to getcwd() to avoid issues with the
different struct layouts.
- Link to v10: https://patch.msgid.link/20260415-sleepable_tracepoints-v10-0-161f40b33dd7@meta.com

Changes in v10:
- Guard per-prog recursion check in bpf_prog_run_array_sleepable()
  with prog->active NULL check, following the same pattern as
  commit 7dc211c1159d for prog->stats. dummy_bpf_prog has NULL
  active field and can appear in the array via
  bpf_prog_array_delete_safe() fallback on allocation failure.
- Link to v9: https://patch.msgid.link/20260410-sleepable_tracepoints-v9-0-e719e664e84c@meta.com

Changes in v9:
- Fixed "classic raw tracepoints" to "raw tracepoints (tp_btf, raw_tp)"
in commit message
- Added bpf_prog_get_recursion_context() guard to
__bpf_prog_test_run_raw_tp() to protect per-CPU private stack from
concurrent sleepable test runs
- Added new bpf_prog_run_array_sleepable() without is_uprobe parameter,
remove all changes in bpf_prog_run_array_uprobe()
- Refactored attach_tp() to use prefix array uniformly (matching
attach_raw_tp() pattern), removing hardcoded strcmp() bare-name checks.
- Recursion check in __bpf_prog_test_run_raw_tp()
- Refactored selftests
- Link to v8: https://patch.msgid.link/20260330-sleepable_tracepoints-v8-0-2e323467f3a0@meta.com

Changes in v8:
- Fix sleepable tracepoint support in bpf_prog_test_run() (Kumar, sashiko)
- Link to v7: https://patch.msgid.link/20260325-sleepable_tracepoints-v6-0-2b182dacea13@meta.com

Changes in v7:
- Add recursion check (bpf_prog_get_recursion_context()) to make sure
private stack is safe when sleepable program is preempted by itself
(Alexei, Kumar)
- Use combined rcu_read_lock_dont_migrate() instead of separate
rcu_read_lock()/migrate_disable() calls for non-sleepable path (Alexei)
- Link to v6: https://lore.kernel.org/bpf/20260324-sleepable_tracepoints-v6-0-81bab3a43f25@meta.com/

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
      bpf: Add bpf_prog_run_array_sleepable()
      bpf: Add sleepable support for classic tracepoint programs
      bpf: Verifier support for sleepable tracepoint programs
      libbpf: Add section handlers for sleepable tracepoints
      selftests/bpf: Add tests for sleepable tracepoint programs

 include/linux/bpf.h                                |  50 ++++++++
 include/linux/trace_events.h                       |   6 +
 include/trace/bpf_probe.h                          |   2 -
 kernel/bpf/syscall.c                               |   5 +
 kernel/bpf/verifier.c                              |  13 +-
 kernel/events/core.c                               |   9 ++
 kernel/trace/bpf_trace.c                           |  48 ++++++-
 kernel/trace/trace_syscalls.c                      | 110 ++++++++--------
 net/bpf/test_run.c                                 |  65 +++++++---
 tools/lib/bpf/libbpf.c                             |  88 ++++++++-----
 .../bpf/prog_tests/sleepable_tracepoints.c         | 142 +++++++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints.c         | 112 ++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints_fail.c    |  18 +++
 tools/testing/selftests/bpf/verifier/sleepable.c   |  17 ++-
 14 files changed, 578 insertions(+), 107 deletions(-)
---
base-commit: 05103382104b8ffc701f7b2c79379a0361ecad30
change-id: 20260216-sleepable_tracepoints-381ae1410550

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

