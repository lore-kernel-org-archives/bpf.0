Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C4628AB0B
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773435897; cv=none; b=faT70BKYfn3J6CvyTaNpEpFZsoyZtYYbtwKQxpmf8W7+oBOgRppz1+yc/EzUNJ7gWZGPyewR5C2jkIFu2AmsVLlFT5MT6nZNyUyfdjiDsKxCBN28cc3SKJsigy1aEvIxtEYK5HfS0xPNjsu9ALyFScDS+FR5R9PlJbexETud0CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773435897; c=relaxed/simple;
	bh=UNeIpL8NXUxw4tHjCvcj9W9LiVp1qyd7R6QEqUvikGI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HTcEkJVZZF28B0JTHpgBoldxQf7IRJyk2VnXuqrHgN4J/W/qe5eGAdRpnEXRBV+53i2djTetYCWZzc10b23t7AehgT0MFy7dKXDKLeKw0Re98TD+JSjk7UnW1zzO8gQ33VgPTd7C2nQ/6ctb1SeLVCAqLW7fJEdN2wD2mFCqEdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7C0yPuW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7C0yPuW"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48532925a4bso13867455e9.1
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 14:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773435894; x=1774040694; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YpOrp33ZVwwVkVDJ6OFcHXsQNncr3+h0EO+3U+Hfs70=;
        b=R7C0yPuWhloRFkUCCOLe538mDKQETU7JsMoUy0/MGtXYPcVufl06oHmJvwLZb19C9V
         ZkQvMrKSjrShQyQ0IHt+WtcK2c2ZNqW7Wg3Gv0CIYbthissZesvxtfjw8jCLbsaLasjs
         EP2oYrZI7MtMB5IQQhN/xjlhJImSWz6dsAG1rbEk6q4Pka61qxElCrKXf0Yj3wOEpitZ
         2Z2FkASAWzZnlRoEIpYmyeo+ZPo3a9/aybF9oUsL7X/3tZ5F1AT+Z/1FUAdYI/wY5NqZ
         CDk4g0Y9oZKpGZxQp1lqpGsfC0sonIJvwcJv1QMYiPGK4UVsjYsuJK4P+loOfjvEqCdS
         A+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773435894; x=1774040694;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpOrp33ZVwwVkVDJ6OFcHXsQNncr3+h0EO+3U+Hfs70=;
        b=j4yls6yp7PEJe8Z+5lgreU+hqkiI+JRUbcB0D6eTUNslEOd8wzbPcEa5WOUGPrlO2W
         o380jA6CaeZxu/+gTmdQzhgSZstpn9gjlm4EVpIc39wLJU4D+dynJ/8xQYSPeK30zxH0
         LAOK9Ha76ublOGTrqz7zZOENWIJDBE3hKaotfqBxbqwk5NV1RzfC1ypxXgdzA0b34Aq9
         iM8kBs4hDV0bXCBRChk6F/WfI+ZrMu5xUCKjjpuBceJuk3Bam+bFfnMUzupVATARpo6x
         VFPpJMFcg9Xv059O74v9LjaUP/6b/zg/bBkk8onk2oZCV3GwcwjfDdqYFChBaavB+64W
         n/HQ==
X-Gm-Message-State: AOJu0YzC0DALbdxB4vgeI1QBcwIn867X0ghPemHRznb1bV8uWU+wGLgb
	l8bvr1GPATf35NUecX4558YW5Aa1ZG1m9pcFknrRv9D+ZcJLVeAgwui2
X-Gm-Gg: ATEYQzzRZxnEu+wDiRHroeBNR1NbhXu6TJVIz9kQcRC6AL9wGeAsb+8crZIp25E530v
	mpAfQyJDcp3VlWb+ramdb6tnssVokaXJNxHNq3SP+mnlHv0YRMU9eUsZKOl01DMcRXil2clWPdT
	pqxao9jvsViDY/ifqUFxd+/twcZJ5XDsNzpXA5jl16UMtRrXF3Kob6kwiJjHUaa3kNJU5J04YWS
	UCook6cOFpdXmtl0tiNV4hL7BzQHtxqlFCURnJXO0p0HYqQWLC81cIRifRmw8OBPGmsnjkZNMvi
	1uhh5WPd84S+q/pHkmZXNb5e/u0kTq6QjanWmRDHRL+TZ2hGtOSElPnR5Ulm+D9sHnVLJ7Wt76I
	A3Ex0uL1XKpMK2yoL6xE5Mv/cCUch0R9pm4mN/RWjIo1jxstM49I6AsfiTzJQwBa+RqfvpoGiab
	szm01XNrkvobeenh2opLHQdJNH1RJK
X-Received: by 2002:a05:600c:4f54:b0:485:3b5b:eb8 with SMTP id 5b1f17b1804b1-485567052b8mr77552495e9.26.1773435893884;
        Fri, 13 Mar 2026 14:04:53 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:40::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b66ffe2sm215626285e9.13.2026.03.13.14.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 14:04:53 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v4 0/5] bpf: Add support for sleepable tracepoint
 programs
Date: Fri, 13 Mar 2026 14:04:20 -0700
Message-Id: <20260313-sleepable_tracepoints-v4-0-debc688a66b3@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANV7tGkC/3XN3QrCIBwF8FcZXmf4MUd11XtEhM6/TVgqKrIYe
 /fELupml4fD+Z0VJYgWErp0K4pQbLLe1dAfOjRO0j0BW10zYoQNhNEBpxkgSDXDI0c5QvDW5YT
 5iUqgPSVCEFS3IYKxS3NvSAWDHSwZ3Wsz2ZR9fLfDwlr/tZnYsQvDBBPOiZZGD4KY6wuyPI7+1
 cDCfwindA/hFeFwVkqDUJqxP2Tbtg9ck+KOCAEAAA==
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773435891; l=4759;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=UNeIpL8NXUxw4tHjCvcj9W9LiVp1qyd7R6QEqUvikGI=;
 b=LJDXkcbPQ+xwTGeqFiqkB3mLCXrq6tHWmKmopNLVUPYkWsyS2T+Y6DjuUD+D2W5tEhX1YPOYQ
 d6qWkmSQhLSD+nWXx7baq81wv2RGC6POPNBkFSQ14fxHiXV1oz3MKgp
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

This series adds support for sleepable BPF programs attached to raw
tracepoints (tp_btf), classic raw tracepoints (raw_tp), and classic
tracepoints (tp). The motivation is to allow BPF programs on syscall
tracepoints to use sleepable helpers such as bpf_copy_from_user(),
enabling reliable user memory reads that can page-fault.

Currently, raw tracepoint BPF programs always run with RCU read lock
held inside __bpf_trace_run(), which prevents calling any helper that
might sleep. Faultable tracepoints (__DECLARE_TRACE_SYSCALL) already
run under rcu_tasks_trace protection in process context where sleeping
is safe.

This series removes that restriction for faultable tracepoints:

Patch 1 modifies __bpf_trace_run() to support sleepable programs
following the uprobe_prog_run() pattern: use explicit
rcu_read_lock_trace() for sleepable programs and rcu_read_lock() for
non-sleepable programs. Also removes preempt_disable from the faultable
tracepoint BPF callback wrapper, since per-CPU protection and RCU
locking are now managed per-program inside __bpf_trace_run().

Patch 2 adds sleepable support for classic tracepoints
(BPF_PROG_TYPE_TRACEPOINT) by introducing trace_call_bpf_faultable()
and restructuring perf_syscall_enter/exit() to run BPF programs in
faultable context before the preempt-disabled per-cpu buffer
allocation.

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
  - Removed cant_sleep() call from non-sleepable path in
    __bpf_trace_run()
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
 kernel/trace/bpf_trace.c                           |  59 +++++++++++-
 kernel/trace/trace_syscalls.c                      | 104 +++++++++++----------
 tools/lib/bpf/libbpf.c                             |  32 ++++++-
 .../bpf/prog_tests/sleepable_tracepoints.c         |  57 +++++++++++
 .../bpf/progs/test_sleepable_tracepoints.c         |  75 +++++++++++++++
 tools/testing/selftests/bpf/verifier/sleepable.c   |  17 +++-
 11 files changed, 317 insertions(+), 62 deletions(-)
---
base-commit: bd2e02e3c9215305dfa344c050d5822f19929cf7
change-id: 20260216-sleepable_tracepoints-381ae1410550

Best regards,
-- 
Mykyta Yatsenko <yatsenko@meta.com>

