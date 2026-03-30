Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EF53DF01E
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 22:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909230; cv=none; b=LaG4N+MHPXeBan/MAYdJhe+4TdmInmTP3fIyVKK3un0oLimaNPcy8lKbIAhrMKfoyoNWxkKl51ZsNaX/3RZmxUZfurBJjw62KgYdIXUxJDhSmjVXXMkvguEvL0Zq1g5TwfgCTGdPyOyTwr4VT9d3lBYL+NOBaDlVjqETLtqHuEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909230; c=relaxed/simple;
	bh=n2NYavq5uwSifY+DNvnGVrbkgQ2/UH8Ww8vqbcwgwwI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EroZbhA0yAS5889Guq1sSirWYRD7VK+L+xx/bbYP79+L6nU9VzicFTnEbkag1/WPWJflMgaU3olII+eiYcZkJa1jQT8KaSnRWVwlpwP+Mo5mVXRwnDQBig6oOtah/NqTmEvNQ95oOw8HLBVNV9d93O5SyeHuGoA7HVsLfIg3mmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTIW4wUV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTIW4wUV"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-487035181a7so33364725e9.2
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 15:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774909222; x=1775514022; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xvn0UtqyJsAyjq+Aax90i8sPmQS8Ccv/d4xqp4mSp24=;
        b=TTIW4wUVz/T5Uuuc/pGr4U1iqX6uLNy0Y66yAOLNAsA44qAZfLJQfhSq8Sj9ifQNqR
         1MYQlbgDt6zTBXp2WMVClD/tKL9qpOX6Yf/fOshH9PsH0HXQzrgi36ePUaZDwjvFCcSt
         F5U8/G6FaWaSBM8oMtB4z3wjLPmbIX+jkF0VJkvHlYVQmj3PdwgjC//FulnnnP5a/3Qg
         moYOqUrv1sHRBelqQiOkIzJADd4FqIGGC6AGw8FQ4RIMOhj65ZEfJ9uQ62EFM8Ho40+f
         uGrwYZ0jDLwEP+gdBhgaGI1FyK1TnH2HRmW1myndbgBsvc4Fe7TGmYHZ5JMJqJXbo5gC
         u/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774909222; x=1775514022;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xvn0UtqyJsAyjq+Aax90i8sPmQS8Ccv/d4xqp4mSp24=;
        b=ZcInnvsdiZ4i/S7+A5iMFRM/CsbiMyi9ACNWxZdc0//CKqZfEt+/vwVtaJvE/3FDtR
         WMnAm47GMctycu/FpzB+20IkcCTJiEJI0mC6BfvP6GPnuiq7zCG1VagVgo37iUUVB+Og
         TYFUFqUnbxK8ojEAcZq1wi0hByjAa3kihVjC4kbw21mpotljswE12b3emIsHazEXJFDz
         Udm7VuLNLX3KxkUfFJ6cuW+7Bizug9SPDlP2SlRVL8jGd5/46Bfy9MRzTOKbB5L94xvP
         p0NW2NJnQXFONVjvkFFb5On7z3TGukXSur5+LlquP0RM8I50AGObu/Hx/XAYPP+oMS3b
         piAw==
X-Gm-Message-State: AOJu0YwIaEiACeAQp4ebD2K3pxlN0bDjKz30596Sj5fuggjq7e8Winj1
	HIL1nUAFcCBpWHTgrFBnJF+BlzsciMMhunk1YczQqlWh7666ZHqtAxsh
X-Gm-Gg: ATEYQzwTLv8DBXYmKUCm8v3tbja8iNgWvhvPvAkGzcgUu6TrBNlDQDtMNQtbMbmKWP+
	jZAMguxVFHK7uVzvtKS8DL+pdOwBThKBNF9sR9PWOEzdBxIHUQu3Mfnpx1ZV3UVEslfP6R1bkei
	J8O0nN5W9HVdxG8u/pt99VLd3+1bI5oxvOTfNS+TJRJ83YV4EOMjE7msmYBQenRWmBFIt6AjAPs
	lqi2H0awTx25F3yK26dbOVA4uKmAPvjkjjF6Lbc9tY4YXuijl9tljvIvVeOn4E7R1sr2jUyGNqf
	O/1EziSQutPShMJDhOxmPHqMUxtoA4VJ/8HwxROEt3lIX0s66+UFmM7BvjdTBzo4qdJlCiD0XC3
	2xIwyCTmuBPbsovGpsYqPIJ8Pf3e9z4z7YhqHSKh8BF4ZtMSUa/PoDIh2zKqDhPrgO3se1Yoiki
	65sSg+SUwKh3yXqg==
X-Received: by 2002:a05:6000:290e:b0:439:c661:3245 with SMTP id ffacd0b85a97d-43b9ea49d3bmr22614386f8f.34.1774909221926;
        Mon, 30 Mar 2026 15:20:21 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:75::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf330872asm20161268f8f.17.2026.03.30.15.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:20:21 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v8 0/6] bpf: Add support for sleepable tracepoint
 programs
Date: Mon, 30 Mar 2026 15:17:23 -0700
Message-Id: <20260330-sleepable_tracepoints-v8-0-2e323467f3a0@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHX2ymkC/33QwWrDMBAE0F8Re84WaeVVVJ/6H6UUyVo3gsQ2l
 jEpwf9e6h5qXNzzwBtmHlBkzFKgVg8YZc4l9x3Uyp8UNJfQfQjmBLUC0uQ0GYflKjKEeJX3aQy
 NDH3upoLWmyCmMppZw0nBMEqb76v7CnFosZP7BG8nBZdcpn78XAtnWvMfm/jAngk1amt1Cm1yr
 NuXm0zhqelvKzjbX8Qac4RY1GjlOcYkHBPRDqm2iD1CKtSYJDbO++BctDuEt8jRVTOjRs9MnOR
 sEvEOcRuEqiPEfSMmhmhDZds/yHmL8H8IReMphUaC2c5ZluULPrzuNxwCAAA=
X-Change-ID: 20260216-sleepable_tracepoints-381ae1410550
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774909220; l=6308;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=n2NYavq5uwSifY+DNvnGVrbkgQ2/UH8Ww8vqbcwgwwI=;
 b=G7ULJ/sEBaNrRDwRA9niyn+wDMxV+Rp7dxL/RUVT06dc8CJLQF6A5uzQJa6c7nVVZY5aPSDx8
 CcXfeG6OL+vCpvReBsUUcCX+k3t+i/zxIxjELa4cKngxIRtqguBMaua
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
      bpf: Rename bpf_prog_run_array_uprobe() to bpf_prog_run_array_sleepable()
      bpf: Add sleepable support for classic tracepoint programs
      bpf: Verifier support for sleepable tracepoint programs
      libbpf: Add section handlers for sleepable tracepoints
      selftests/bpf: Add tests for sleepable tracepoint programs

 include/linux/bpf.h                                |  25 +++-
 include/linux/trace_events.h                       |   6 +
 include/trace/bpf_probe.h                          |   2 -
 kernel/bpf/syscall.c                               |   5 +
 kernel/bpf/verifier.c                              |  13 +-
 kernel/events/core.c                               |   9 ++
 kernel/trace/bpf_trace.c                           |  49 ++++++-
 kernel/trace/trace_syscalls.c                      | 110 ++++++++-------
 kernel/trace/trace_uprobe.c                        |   2 +-
 net/bpf/test_run.c                                 |  55 ++++++--
 tools/lib/bpf/libbpf.c                             |  39 +++++-
 .../bpf/prog_tests/sleepable_tracepoints.c         | 153 +++++++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints.c         | 128 +++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints_fail.c    |  18 +++
 tools/testing/selftests/bpf/verifier/sleepable.c   |  17 ++-
 15 files changed, 543 insertions(+), 88 deletions(-)
---
base-commit: 596817673dc2d226bdacb72d7a03a328966f563b
change-id: 20260216-sleepable_tracepoints-381ae1410550

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

