Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2F434CFB3
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464956; cv=none; b=a9SBwHcEMV045+iR3WrlkdgIVAIFcPjD44s3i7sw4u1Thhe6rp1HBw6IYqg4Jy7ioj4m7DH4e+L0ar6h/REWXTMWo6IpQwoP/oIiY4B0Ps0U9tPYPQTP8uHYB/jVyg+OL5nA3630kW9Q39l2QxRDXFZfQaf2qAPWuxL0lblBh/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464956; c=relaxed/simple;
	bh=c4jOkoM3TNYwF2LRixYXqodVt+WyxgZZUE4eIz/YQW8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ogx8zCg6Tg6MXfplB6iViC1Y1BXbwQ0K9HLmJgAdvbAN2oECnZHq86M8NTs17J4Mae+c/aps75364WUU9dvhDikoN3v7Dz6hUgqvQBHiIcqJd5wk2ktFjNyXlDQtOprgxYdY7lB4oRJxP/lCqWXVoAzp7Xsxaszte6yb6/6vFM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qupb62TR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qupb62TR"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486fb439299so2115805e9.0
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 11:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774464952; x=1775069752; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BRsPS69I8aDtC+C+0LCZwvS7EPO8Nm4CBw7uSUeGEno=;
        b=qupb62TR0hFasYeuVOWon4kK9TwwclNNL4GOtrQmIFTqK5O5YI3t94bAoP+Bij2jBp
         Iy9LUQl+bnqJXzHFb1a4opS2GCI3CdfpkjdI0QPB0CodteWqLM8DGxInj/XXTdVKj/nj
         l6pmHr3w13KJg1qGcvb5SI2HNaQ60FpOOtCXpVCHm0YY2dNSiSEA9M3F03gVCbUitq7d
         Lk/HteTNgLBOSjxnKrQXM2E52xAfBHHmKp12+d28ljGx1czvcWZFQChERDAjNJN1jz51
         enbGTPz2TRFqbXFrKld+yXsyTvjz2f5IyknKp1zivtvu9/10haRG94TfnWp1T221RBbC
         VhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774464952; x=1775069752;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRsPS69I8aDtC+C+0LCZwvS7EPO8Nm4CBw7uSUeGEno=;
        b=EHe2oVbT2xnkvTM48N8ctwzIEB3EzxuxWCwVIEdK2VoC4mINfge4l8Ld5e4cb2tqyM
         fHwBrlya3NJkhBTKboUR2Ic0+Fk+vq4paQczUtA37xpMOboT+FCl9ryoNc5KTZZSK5Bq
         doDGpUrPf+R73ajQDC8LR3A4rbUfFvCMRGmRHJQXaZAQBntXPKNoKyfKV6u9ONbhT6JK
         2PvIl6t2wuIvsT0CKjeED957fIPt2I5v2krks/uRogSlniSNBYwjvcUNGvrW5veihVXd
         HDXRyMIUJdpUdnvfbwlMLVqoA+KTSKj0lCIFWfBfFlUdh222WVxsa50+Fz1GBO4Rxo/3
         Zbag==
X-Gm-Message-State: AOJu0YxDmKcZ5oOIarqzjOPYI9iVr2Gu87FvTco1LQv0NGREa7jyEBZ8
	T2VlAfVAame/nO5yENrTwY20C+x7l70OHI62uLa7963KZ8JHz3satQsti4bePsZN
X-Gm-Gg: ATEYQzzLauioNAP5ior1kfbe6aGggn6Sa6Do4GnCjQpE9hUkBsQs9uh1hGjGM1XfY/r
	PhZRDUq1cH72HrwsgWLwyPe1LI354zNWAtfzsWT+gR7uigwUgAeRPhlnV166OuZ1K/4FeTEjZ9i
	pwnxB9PIsvF8Zd/Ey/egzkN7v9lYDofSt3KmbukFarZeC2Lyh8va9H22dBBi5c2juciICktVjq2
	xW3SWPEZTIzfEnot9cyQT6oRE+QS1eyLN6oR+yhG9zQ3kfrJ2vWJedQHFFLuIqiy5qdJU/GG4Ks
	bUg872DADzbhOh2QhGn6Bc9U9tiuhpBKA67WKZvN/cMGBMHt3oqWHBb+Tqzjn9T/MMkBor93Z52
	Q8Tv/UgAuu8yZFEt0Vwoa14kvM4OJXw1uiSitKRZ7ApT+HRnM3BFS2dYE/k/p9xgqM0oaQaBckQ
	v8nrii3uI2w/Dz2+Oee97SBpc=
X-Received: by 2002:a05:600c:1f86:b0:486:fb5c:3b20 with SMTP id 5b1f17b1804b1-48715fef819mr72771335e9.13.1774464951932;
        Wed, 25 Mar 2026 11:55:51 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871fb333fbsm2072245e9.3.2026.03.25.11.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 11:55:51 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v6 0/6] bpf: Add support for sleepable tracepoint
 programs
Date: Wed, 25 Mar 2026 11:55:17 -0700
Message-Id: <20260325-sleepable_tracepoints-v6-0-2b182dacea13@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJcvxGkC/3XQ0WqEMBCF4VcJc+2USeKk1qu+RyklMWM3sKuSi
 GxZfPdSe1EreH3gO/A/oEhOUqBVD8iypJLGAVrlKgXdxQ+fgilCq8CQcWS0w3IVmXy4ysecfSf
 TmIa5oG20F11rYiaoFExZ+nTf3DcIU4+D3Gd4rxRcUpnH/LUdLmbbf23DJ/ZikJCspej76Jj61
 5vM/qkbbxu42D/Ean2GWCS08hJCFA7RmANS7xF7htRIGCV0rmm8c8EeEN4jZ6kWRsKG2XCUZx0
 NHxC3Q0x9hrgfRAcfrK9t/w9Z1/UbBSP88tcBAAA=
X-Change-ID: 20260216-sleepable_tracepoints-381ae1410550
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774464950; l=6059;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=c4jOkoM3TNYwF2LRixYXqodVt+WyxgZZUE4eIz/YQW8=;
 b=5M46ZgYVfWOnJhE6uZFsqvRezVGQyAjifA4Clry8d+2CUnCWnNPWl1TuJADmzGrgCR/G8PgCt
 LkDKzLvSROoByEmXvHTkxKZfizD8Ll20xoHYV1iVqfo5U6WaIz/FM+I
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

 include/linux/bpf.h                                |  24 +++-
 include/linux/trace_events.h                       |   6 +
 include/trace/bpf_probe.h                          |   2 -
 kernel/bpf/syscall.c                               |   5 +
 kernel/bpf/verifier.c                              |  13 ++-
 kernel/events/core.c                               |   9 ++
 kernel/trace/bpf_trace.c                           |  49 ++++++++-
 kernel/trace/trace_syscalls.c                      | 110 ++++++++++---------
 kernel/trace/trace_uprobe.c                        |   2 +-
 tools/lib/bpf/libbpf.c                             |  39 +++++--
 .../bpf/prog_tests/sleepable_tracepoints.c         | 121 +++++++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints.c         | 117 ++++++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints_fail.c    |  18 +++
 tools/testing/selftests/bpf/verifier/sleepable.c   |  17 ++-
 14 files changed, 459 insertions(+), 73 deletions(-)
---
base-commit: 6c8e1a9eee0fec802b542dadf768c30c2a183b3c
change-id: 20260216-sleepable_tracepoints-381ae1410550

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

