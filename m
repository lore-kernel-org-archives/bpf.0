Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9129F39526B
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264587; cv=none; b=um8wxn7v8DD9uAl9HtAaD5omTDVRxnOx3+qig8eQsytc3qgw7zuco5iFYY+trmKgZ01GwEAUWDkyNzDfzVk02dvIhISOo8CbrY3gVw+tnTQeD7BrgacSeGm6o2G08VcnGsUywn7IyAjMvJqwOzFG5HZ0bKYIrABrkfnuLQvZTY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264587; c=relaxed/simple;
	bh=XbPoOcv4ZQy165lbdHWeSzwhOtp9cSIT2g77RZRyrEc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uLzyMGw0OX8Cs2ptgDHmkHE1hmzhugDtJ12v1NiXwU2BbcZSHFpT72+njqyukGT5nSHYxS+Q0azAg1TQK2pSG5N8ffFaYfbjaWqWsu++EFJBQxVOatrQ7y2Z0bDXb3TOE0iIwhNAK8AGuHmBOEFcH5HKYvnvGXh3Pqte12svmX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmjR1WVp; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmjR1WVp"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-483487335c2so76199005e9.2
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 07:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776264584; x=1776869384; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hOaYRLWC5TuCldfaXpterNT2oJ9w7x/cz5kKDomHRLo=;
        b=LmjR1WVphdyGh9DbRZMqvf7Jl1dGkqHKYXooJZQduiL6mOkjhvQHn9Z1/aA1RfwLQQ
         s4JzC3AcWWKfXAg+Q388hWSMj9rgKUfV2XktVHMbEQUJ9RV/krz5mEbfsXTkXOKAYvwk
         i5EAvqtx7j3QLcOIDIiJ+XHkjCOZENAyZc8FiV4iz9IFX66GJSlCho8hRbm5P09kKeBF
         42LshQ5XBoYAHLNSoFT6uejQaYvGDOCvXJSSyQ/nmObKTxwjlgnpkSQ7ikKAjy0D2LUD
         WYQS9TLhb9fpuY10o8HEwP5Ew+0ZXIjY6hGQqS8qbC6Q0OMzI9ODIf2V2ISN2VXie30r
         S3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776264584; x=1776869384;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOaYRLWC5TuCldfaXpterNT2oJ9w7x/cz5kKDomHRLo=;
        b=UdBQxKbjGvjj35sIJ+o0yMaqSPo+AM79WTot07eyDj4WoWFRrb0g1RjmwlWfmoMJg8
         VWliJkcKOEds6RRx3q8SCxzBWCN7Ea2KrYuUBW6gJlJZhY0V+/MJpKXWhpGiZ0h0akXO
         CqliThIa0NzDgngAyqGG3pWqKm/pLvPU+sS6YkHGlHgWMPRIVh9QtPmGC0DrFwfReS0O
         WJb4NBPH+c8KuGb8CpN/vjKT/cOzFDsuYSgOGkbUjf2Pj1Sv+PBY/NV1vZgYtlB/ZIqQ
         qAu5hSbXUOn4FG5ChcMLr6dhSZ3TuifsK9jFc3pwGoejKM0HM5hGQEKnnkZDtNkql6bB
         hFng==
X-Gm-Message-State: AOJu0YxnpAoT96m1W2Nx3702WPY+RQnVZnddZ98Qa/8mMHueKNC8WnjG
	PTegO/kbMzl5N0B34Fnhr8yC5c5UhPLSIJ2rzy2/jX2x0OXgVI0Hrjtr
X-Gm-Gg: AeBDieuJDzZBTEl3ge1WTU6Qn+az+Q+u0wupnf5VEjESK9oc2uG0BU6bWxhB3p8x/da
	RBVe7KB4XC/PlIkck9or9H9htjswqzaBcarhDjRYyDtakj4pNJKDLbzgiSs6GNwMWZmS3EerPto
	k2ccFe7GzCk9sgZ1vY2CFE5GEL9TL9cxynTnnSUIkVWt4Rw+ktWO8h7P4Gr2Y2zsawK5PmjpIBE
	xS+TBcrZ2qHOHlU5T18rLAKpbVlo6C2x3hScRVyqGrbgnnDzAI65nyRDS8nVL9yC7/A6owse0zC
	QD0qwzmKQd2SK9NqGL4hgiMolu7paKTg104/YHvTIIS35pYY/k4zShECCelhkJ5d6BUkrUcLIHd
	UbbB//kmv7njWIUBAjOi6xfFVG4z2FLMpBlEdXqpsm6MlfbWoWv73ETMdcS830l+nUs5f5xWey/
	b9FInBzGnzQ0yt
X-Received: by 2002:a05:600c:c0c8:b0:488:af14:f1de with SMTP id 5b1f17b1804b1-488d67b8de8mr224985595e9.4.1776264583780;
        Wed, 15 Apr 2026 07:49:43 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3566b7sm5893850f8f.11.2026.04.15.07.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:49:42 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v10 0/6] bpf: Add support for sleepable tracepoint
 programs
Date: Wed, 15 Apr 2026 07:49:02 -0700
Message-Id: <20260415-sleepable_tracepoints-v10-0-161f40b33dd7@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF+l32kC/33QwWrDMBAE0F8xOmfLaleS5ZzyH6UUyVo3hsQ2t
 jEpIf9e4h5iXNTzwBtm7mqSsZVJHYu7GmVpp7bv1LHQeChUfQ7dl0Cb1LFQhOSQtIPpIjKEeJH
 PeQy1DH3bzROw10G00WgtqkOhhlGa9rbC7yoODXRym9XHoVDndpr78XttXGjNf22yGXshQEBmT
 KFJzmJzusoc3ur+uoILvxDWOocwILBUMSaxMRHtELNFOIcYQEgSa+d9cC7yDrFbJHfVYgHBW0s
 2SakT2R3iNgiZHOKeiI4hcjDc/EHKLWL/QyhqTynUEvR+jt8gjDnEPxFhYuPKhgPukOqFGJ1FK
 kCQUlfinBFv6g3yeDx+AOywqhunAgAA
X-Change-ID: 20260216-sleepable_tracepoints-381ae1410550
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776264581; l=6653;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=XbPoOcv4ZQy165lbdHWeSzwhOtp9cSIT2g77RZRyrEc=;
 b=XlJbYGh+gYh6Q/2z3oYo2FSVCilwhgG2cdHhO1cEGvJAO1xIcTOH3sJJbTYYgCmJxzaHtON9S
 VczCNNZxp7ADmtKOyZ+vy+q0llSR0ijQLSGodmeeg6T2FcThdolptAv
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

 include/linux/bpf.h                                |  58 +++++++++
 include/linux/trace_events.h                       |   6 +
 include/trace/bpf_probe.h                          |   2 -
 kernel/bpf/syscall.c                               |   5 +
 kernel/bpf/verifier.c                              |  13 +-
 kernel/events/core.c                               |   9 ++
 kernel/trace/bpf_trace.c                           |  48 ++++++-
 kernel/trace/trace_syscalls.c                      | 110 ++++++++--------
 net/bpf/test_run.c                                 |  65 +++++++---
 tools/lib/bpf/libbpf.c                             |  88 ++++++++-----
 .../bpf/prog_tests/sleepable_tracepoints.c         | 139 +++++++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints.c         | 115 +++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints_fail.c    |  18 +++
 tools/testing/selftests/bpf/verifier/sleepable.c   |  17 ++-
 14 files changed, 586 insertions(+), 107 deletions(-)
---
base-commit: c07eaaf1364df9f952bb2f691440270cc443e0bc
change-id: 20260216-sleepable_tracepoints-381ae1410550

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

