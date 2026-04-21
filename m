Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C02430EF74
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791708; cv=none; b=sH/i+/WIRlTJjQapWmCQn0LeaDYWlOnvjgTwm6FtPQlgVH2fhwWKjW+TlX0pt0HFBhASo+j7t+mMGHJ1eKTzUQXYsDXkUabClN54e8NpByD6WCNCH1h7Lf6FcvkYrnj+LxeCtS2HhTkZ25rRnqFARFPJLaQLSLji9moISRrbHqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791708; c=relaxed/simple;
	bh=SzeMxIDCvQD8qqLsYT32FFT8PjKHPDKxBrUyAdUWqBg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nFFC7Mn4R101ejSKD+pGGc66fyGBb5prUtbnf2yDERMuYKQ5I6huB4g96Hbbwml0uoz99reERiXXq1QQhoqX3J/Tv+UMbSOKSE8Y/D7CE0K4kav56Kq3KoO8zWhY3dGJ/LZ6xSu90/ITfRS+kRBAbGNf/DuoFGcS9mhtFxZM/pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2AuHNZF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2AuHNZF"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488d2079582so52526425e9.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 10:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776791705; x=1777396505; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wa1XPUKV3CAdeCAan5K+EBxgE+CvMTXCrLvk9BGu/fQ=;
        b=I2AuHNZFk8pK7YqYJcDZ3f9o1L5OxPx1lG2EBnevEA9h9oklLJmR8G2q8CcrEqxeC+
         vcuOMhO9BaB4phhPNEPGrG/HcxQOwaUkZ+n8q94/MipgkllfFuk+A0c8lJSgCNnj8SPA
         79hrJHg8zJvihLehXbrju/SeNPVRGF86aprgtGmy2tnB4aYCXlVit7fuUQ8LK60JnkKB
         FsGuvj2E0Od3Z8/N3a882JE3dpOIW3IodVTk0Qn2pmsBhIl+TQXR797rU8nq68jYtceY
         9kjBV7ip0kJDgCeUs/ifHcYAwpi5Nlz8aS6U2Fs44nOdF7fztFMHL837Fb8aGfWLgYA5
         THBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776791705; x=1777396505;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wa1XPUKV3CAdeCAan5K+EBxgE+CvMTXCrLvk9BGu/fQ=;
        b=aNBW4FHRMEsOHzMDz/sXf1Z/kP6m5Ld5/Iy8O4z4EzjpPv+dIXmilw20yUkCoOFu01
         YqCq1koifRl0WH30NbiiVMQsXOC0pGDUVNLGBWsnvjX3y1i42gZUTuKC26rYBZ4kDmn9
         edb3VY9uPSp2PdH6Ux5H7ir2lfSB+FtJQOC/O2SduMYEPLc5rV2sh8nb3Fa+yBrWjDpx
         hoPLNZ6FBo0Q8UTel+6svNWVV3Ti5GZEx8Ic4VHDpWDPRG8jgW5Q4S57DBcB5q5q4fP6
         Xdtj9Fw/bPiyYbSNNojaEiOvF/zHCccyUijPfreN7GQCKj3u2y4Dzwo88QLpbsRbiZeY
         Ad5w==
X-Gm-Message-State: AOJu0YwcBWvWdR0VYuOzGavy512te5qV97HfeUvMh2mriODPImGjMEEQ
	PuVhvRbKeLHEKPRkuTGMb28i1oOvoy/m+ozlP34wyxKV+J3pBGB8XxTioIbBZuij
X-Gm-Gg: AeBDiev5mxo7JZ1oRUIek7vHyay27p1ztEd0EidPE6n8gAQeb3Nw0+qgRt4ml4bv0U9
	h5gZUd7mDnPuQkogC+61Z+tZ8RIlhT2kDvk8aeunr0dTqjcUhnXc4az/goMqk0rECsFF/V0z342
	3tXnvkmq3MemK2E0k8yFESdz/gVh93jmKUqzVVtVi5J6HYw0LQQtXKcLqG0fut2szDSHBXYrC3i
	4pjQomKtzyP5F4nloyWCmrjck86nCa5XWzvdb8E42bx4ip0/UEZyvaluTceTaaQbms3kuP/96UG
	lcYxhsFrIfHG0b+irfY9szjzfUXJwxcOjDb9vKqsVCZtHjCK04mgG0+OKmWBLV2T5D3HFz4evBE
	OH16EWLOX6VI9ys+4kjD7Z1ZKm06LK3mnDrMwU7hA2XnaAMtYM/HfsanSKFA7fMEkSltw8obLm8
	+mbW9Rt0q//qrMo+kFulYmS91/
X-Received: by 2002:a05:600c:4fc7:b0:485:40fd:8390 with SMTP id 5b1f17b1804b1-488fb78894bmr248819825e9.26.1776791704425;
        Tue, 21 Apr 2026 10:15:04 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:46::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb755938sm160313605e9.3.2026.04.21.10.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 10:15:03 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v11 0/6] bpf: Add support for sleepable tracepoint
 programs
Date: Tue, 21 Apr 2026 10:14:16 -0700
Message-Id: <20260421-sleepable_tracepoints-v11-0-d8ff138d6f05@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGiw52kC/33QwWrDMBAE0F8xOmfLrlaS5ZzyH6UUyVo3hsQ2t
 jEpIf9e4h5iXNTzwBtm7mqSsZVJHYu7GmVpp7bv1LEgOhSqPofuS6BN6lgojdqhJgfTRWQI8SK
 f8xhqGfq2mydgT0HIEFqL6lCoYZSmva3wu4pDA53cZvVxKNS5neZ+/F4bF73mv7a2GXvRgIDMm
 EKTnMXmdJU5vNX9dQUXfiFMlEMYEFiqGJPYmLTeIWaLcA4xgJAk1s774FzkHWK3SO6qxQKCt1b
 bJCUlbXeI2yDa5BD3RCiGyMFw8wcpt4j9D9GRvE6hlkD7OX6DMOYQ/0SENRtXNhxwh1QvxFAWq
 QBBSqrEOSPe1DuEcKtk9xACAjlqDEbmlMoN83g8fgCtX0qc7gIAAA==
X-Change-ID: 20260216-sleepable_tracepoints-381ae1410550
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776791702; l=6940;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=SzeMxIDCvQD8qqLsYT32FFT8PjKHPDKxBrUyAdUWqBg=;
 b=mUMTClPGXEttJc01udWlWGDgQLnQ965vWfz851/VFk9FrMhtQYy3/WQHpIDdSpvc94CWM4ekC
 471lx5rXiJ6APXDgReo+8MO7VYXM1C6xr9tmXPcYrlGV7PvPAbHYxoL
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

 include/linux/bpf.h                                |  55 ++++++++
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
 14 files changed, 583 insertions(+), 107 deletions(-)
---
base-commit: 05103382104b8ffc701f7b2c79379a0361ecad30
change-id: 20260216-sleepable_tracepoints-381ae1410550

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

