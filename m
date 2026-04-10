Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B72E3A169B
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775840989; cv=none; b=hDi14zOEkJNNNps8pS1hApxjovbPK8rhwfaygFQ2+BO2iqs/GayOgFy+7YS5AiJkSKlqcMgJ4LHo0CUHPcAOkZ2iqOrw9pEqZj4triYHM18lfrl792JPiXvIjR/v6dujzIlknzdnH1ucj/4XscB8m1gWdjkKUQaISfpe9DXwVMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775840989; c=relaxed/simple;
	bh=xkpeaqgTbohdCin9Jn+1+/U52/ki/5QAqbDxwDr8Imw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e4NnZ34ECC3MWemYCmqhl1HLRdymngezqL1EIrLXiEfEXsYGI0yzIgwbT4Xt++PttfAH78busMUl0IO2U4SihVmb8lpS3bhaR10Nj9EmcuQLDyFiKukWVAWWkV1JyzvGXeorcEVtNmOaZDR3SjKNhAZ6HjSBmq4RpuFl/rN60C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qgz2bDwz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qgz2bDwz"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ba840146so22624745e9.1
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 10:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775840986; x=1776445786; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=36OnR9cCkHMD/vNS7sXbreQiPhCBZsYmJ9iOjgFG9Ns=;
        b=Qgz2bDwz9QNML42g0ezAB/2WGp0rpY3zmzRFv8sDu8BWGiUBAEH7eOoF7tJdzS3YeE
         p78rolwY1fc4FP/os3WKOLBopUJxDvxyJ6E8BEpF8t4zMcAWAcdYOVhvJIEkkVkjBtXU
         bHoEdjNsvXdaf8+LO8dPfSxzzicUeTwB/6xGjVBcJgWNeF2lKJ6yk+JqHyiEhrfJBf/Y
         eJUdkzsXW1HIYSwr7TlEufC521D3HZUiwHFy6HxO8KjuzycFGKG4AZmZAoVBcsL5gwR5
         ua0rPZItAElyso4anuxEwR/wDYOh19dYK6Hq2ZINFoRZCWNgKNQA1Md8nFjLp95auFQp
         zMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775840986; x=1776445786;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36OnR9cCkHMD/vNS7sXbreQiPhCBZsYmJ9iOjgFG9Ns=;
        b=fOjgh4Thqady4y7KwbPc6W059jaiYfYfDW/zDTlhTOph/45w5YQRAAYVFAzJxXbRpA
         Ydb6+0jQvAcWHniHpLyUyJ3DSWvsNKoagSr3tpv/CwYL9C/D0qmxC2CQGUGOlrA5TuUH
         V9TAv9XxSWy/Mp6dSSlp/TwWSgwJvQo1yVLGuS/+A6g4DGbSYCUh0eT0b/sGx5vul/W6
         Mp55jM3WsfDTa0mif6Cvg9I3i+SW5w37btSckoNM5TRRduRNMsq11LErM6Xig3SRjZ8k
         ntJvDbe4Rn9l729O6FHA/DZtUu7vME/ZN33mUF5k77a3lOr45pn6OZf73VhdYmBHpJBI
         NE2g==
X-Gm-Message-State: AOJu0Yz2GTu7Ph81o0S9MlLjr73wqmc74NULQS97EpD4e+Xq5lWmFu2Y
	3l8mHPDEz/9hDK5rOYuHKY2FZCS2wtViELodsz0OP3T1WWIeomgMn0S4C1OrCSrK
X-Gm-Gg: AeBDiesaq5SzYRRi6BRn/K4nJZwDoLJeGixkCBaSI76HySKd4WITmfFqQHfqGziTUkk
	b4Ak6zAvY5pkre2zBkORSpwXrHNkxnAppaM1+wQM0WwjEWB9Mu2T+Ym5QAsJlF0Bx1SHbAQwuj8
	WMuJ/2ds+lRKNpVz80GLr9/bbeE9PGk0UVl+uD+tx0dXttRXxLLiS1G56nnrW9jG6OAh8ZRAWZV
	LPr60/YOI+rRyh6hsZdVeHi1s+IjP9+FpZtuJUPlVhPjK2oT+YZR70VNz14VZR5MmdKFAgzd64Y
	IXNUvXJsr2OSlhXBSXwrkXQBFuHx6maNOr3OZjGatgqgR8KRzq1OegprQCBk+zMlF1iDMcRPgS5
	tZdQIXrcndraCtEO4h/2W9H9hx5ZmJrCc/Coi2zhWq3cf3r7TFvaOI7FIIFIytWwFvqYs6zG9Ry
	YoAUZHMdX5tlWDQ2oxXc9r5kVI
X-Received: by 2002:a05:600c:3b0e:b0:487:20ee:bef6 with SMTP id 5b1f17b1804b1-488d67e65fdmr49883835e9.11.1775840985774;
        Fri, 10 Apr 2026 10:09:45 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:45::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d70315sm27024735e9.1.2026.04.10.10.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 10:09:44 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v9 0/6] bpf: Add support for sleepable tracepoint
 programs
Date: Fri, 10 Apr 2026 10:09:28 -0700
Message-Id: <20260410-sleepable_tracepoints-v9-0-e719e664e84c@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMku2WkC/33QwWrDMBAE0F8xOkdltSvJik/9j1KKZK0bQWIby
 5iU4H8vcQ8VLu554A0zD5F5SpxFUz3ExEvKaehFU51PlWgvvv9kmaJoKoGAFlBZma/Mow9X/pg
 n3/I4pH7OkpzyrLQCY0CcKjFO3KX75r6JMHay5/ss3k+VuKQ8D9PXVrjglv/YaA7sBSVIIILou
 2gNdK83nv1LO9w2cKFfhJQ6QkiCJD6HENmEiLhDdInQEaIlyMihtc55awPtEFMiR1ctRoJ0xqC
 JXKuIZofYAkF9hNgnooIP5DV1f5C6RMx/CAblMPqWvdrPcQVCcIS4J8KEpG3dkYcCWdf1G+dO8
 RthAgAA
X-Change-ID: 20260216-sleepable_tracepoints-381ae1410550
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775840982; l=6223;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=xkpeaqgTbohdCin9Jn+1+/U52/ki/5QAqbDxwDr8Imw=;
 b=NazDQdbkfYYpANUoFahkp6HSQW+FlQVkCu0uaoTPxFUQiN8zQhMjhTiObrw0lQ+3HpAXTAP6w
 Ij+LybLciGBBOykeXJcmSIs6mcROFXLQpC2uz+qpnGbKPFzGZskNhUy
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

This series adds support for sleepable BPF programs attached to raw
tracepoints (tp_btf, raw_tp) and classic tracepoints (tp).
The motivation is to allow BPF programs on syscall
tracepoints to use sleepable helpers such as bpf_copy_from_user(),
enabling reliable user memory reads that can page-fault.

This series removes restriction for faultable tracepoints:

Patch 1 modifies __bpf_trace_run() to support sleepable programs.
Patch 2 introduce bpf_prog_run_array_sleepable() to support new usecase.

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

 include/linux/bpf.h                                |  50 +++++++
 include/linux/trace_events.h                       |   6 +
 include/trace/bpf_probe.h                          |   2 -
 kernel/bpf/syscall.c                               |   5 +
 kernel/bpf/verifier.c                              |  13 +-
 kernel/events/core.c                               |   9 ++
 kernel/trace/bpf_trace.c                           |  48 ++++++-
 kernel/trace/trace_syscalls.c                      | 110 ++++++++-------
 net/bpf/test_run.c                                 |  65 +++++++--
 tools/lib/bpf/libbpf.c                             |  88 +++++++-----
 .../bpf/prog_tests/sleepable_tracepoints.c         | 154 +++++++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints.c         | 125 +++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints_fail.c    |  18 +++
 tools/testing/selftests/bpf/verifier/sleepable.c   |  17 ++-
 14 files changed, 603 insertions(+), 107 deletions(-)
---
base-commit: 869997746f5b022e51e6fe5225dcfa25baf6a8bc
change-id: 20260216-sleepable_tracepoints-381ae1410550

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

