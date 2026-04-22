Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C068279DC9
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871647; cv=none; b=p66PudTx7b8NuhISxXA5D4I3GdaT9l9SI15Ypb8xNdyQnGZ50bDXnRGXQ98j1GDjrrldeprFf9b3nBXsRTYy07UyuYaOcxfglk9ZR6rIrztolTjQvIvRqUNyULDzGLEm3Y6k4UUNUbMSK/MhBvrZVDH1yuZz354Ia0FeLwZ4pBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871647; c=relaxed/simple;
	bh=aPWShDH14HQxMJ8iA4Rk79fiAE8TWTCKBpmFbYoREsA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mHijJZQnUhuSktFvkqbZB1rjKwc/pnZsQzNiQejSWAp97cB3xO8e8FgufBH5JjgVahK3c4iCU/ZQJ/ZOyjlq6HHePKjiCQGu4MvZ6rwHg8z7RBMntxCFbysbs1eo2B5dOd9DYcTVnkPmzkqCV9QpHcpE8kxBx4cgV6/fKJESkSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhuhhc5K; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhuhhc5K"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so34549535e9.1
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 08:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776871644; x=1777476444; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zygoRxfQBmCSeTnzguZsVEzKKMzemsAdhmP9KVzh9mQ=;
        b=hhuhhc5KMScBpKpBYzwT8QFikLo+pTMW51c0SKtzXQ26m2bvRQYsRY9LGN1KR0+STK
         vu0/Bv8KqjJfOZtkcNswtVyXPxhWmCOCDzxBYWYPWM9hoq5viUD7BooYDODnCe7kt37m
         2QCBouTgLFqHdzTE3bSckwt4BJ/mKp9PuMljHgGH6yN4nUp/0RiVGJRmgrTka+JDxF9Q
         zede8K2kbEAzxhXUlF4hfbFM0rRALPult87Cyw3/JPGFVKJwo1mwe3UQtnKKP/2rsuT0
         0PFO3V2JfZf5XAkX+9SzmeqDojhoshgrrDgDMtHqwuQO869SvzPjSEBEq7IFQcctR2Oy
         P1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776871644; x=1777476444;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zygoRxfQBmCSeTnzguZsVEzKKMzemsAdhmP9KVzh9mQ=;
        b=CZ57LvCtwYFrXiI031MPVNo1A1JdWxfyh+79bZr4ivdx8MRMCvzUZ3JbHICKZdQGKE
         qyu2JwCRY8MQ96h11REEPLG8OdSbZeQzDaHZKMeHrPDedQR2g8uPoRTrgYXSCBlAYN0G
         /OiQujEXcmvXi5mUeVceOBcv/YeOCNscI8ZvFnZC7DMxZYGUh6Ie0wDw+M+2aSUub8yB
         87Ovz9/HoicEMMI9cJyuT3offU3+/whupn+Ke113PosdZofOu/LXJLKCSvEndr1n3wC9
         IuUi/mAm9kKIvGsGZXPhIpHvALnZDcrgIukrC9Bk99YbKPC9L/aDHEC1m8mQ1JtE5tJN
         W+WQ==
X-Gm-Message-State: AOJu0YzJoJa2+ju4nxtR5ilvvp9i3Dh4Z9E+Gc289CjI55UGX7XwQdT+
	fk7HB8nf3nTAGPvKFRRSKL3eIPGseX9Udmq0r3DEeGD55tbyUmkgcF4E
X-Gm-Gg: AeBDietMEIPkhhDWf18NRh0/MeVaDGY56DHGyNqUwPHCCGwNXCP1lFdEDGg/tHmDcoh
	ghsJfKQtYFkIMr8Pjy+H71+WmM5xPGIbw6JlVZWNEQbkpOxSrt94IM+RS2B3bMSmlCPDij2M5u8
	MBe1Ge7+DiCO8yjEiys9Jon8uTx/ax6GGcuN2IMrE+EEpzpQGzX0jP8QJ1+VmlqiscD7u6D3BCd
	ubGKcmBLC1cPH7f27ECZnnTgZ+/nEhknYFgX3JKjGoE3gdUfPEps5Hrp1vlujvMh9DSlH/fmPB9
	Yo2IwDaS0uCz/LNvdecDiHE1Doqlxb6fvC1mEYKVfjbohpbP/mEHWVdGgJ80NssneEjKJJITo90
	lbC1pvg+1qeY5dJ03FeiREEbruvB5Y5jEdaFPaI+qguqVyhkCBemkd1g+absQN3OPjBmoLVf4H4
	EzMxHTz7JlsSeekxoqowrNdYI=
X-Received: by 2002:a05:600c:8b84:b0:480:1c69:9d36 with SMTP id 5b1f17b1804b1-488fb76e4aamr359582885e9.17.1776871643830;
        Wed, 22 Apr 2026 08:27:23 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1cfbf2sm469654505e9.15.2026.04.22.08.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 08:27:23 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v12 0/6] bpf: Add support for sleepable tracepoint
 programs
Date: Wed, 22 Apr 2026 08:27:05 -0700
Message-Id: <20260422-sleepable_tracepoints-v12-0-744bf0e3b311@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMno6GkC/33SwWrDMAwG4FcJPldDsmzH7WnvMcawY3kNdElIQ
 ugofffR7NCQ4Z0Fn/h/6aYmGVuZ1Km6qVGWdmr7Tp0q0odKNefQfQq0SZ0qpVE71ORguogMIV7
 kYx5DI0PfdvME7CkIGUJrUR0qNYyS2+sKv6k4ZOjkOqv3Q6XO7TT34/e6cdHr/NfWtmAvGhCQG
 VPIyVnMr18yh5em/1rBhZ8IE5UQBgSWY4xJbExa7xCzRbiEGEBIEhvnfXAu8g6xW6RU1WIBwVu
 rbZKakrY7xG0QbUqIeyAUQ+RgOP9B6i1i/0N0JK9TaCTQPo7fIIwlxD8QYc3G1ZkD7pDjEzFUR
 I6AIDUdxTkj3jQ7hHCrFPMQAgI5ygYjc0r1nqENo4uvQvQ4s8+Z2CeXcVvu/X7/AQPwbLs1AwA
 A
X-Change-ID: 20260216-sleepable_tracepoints-381ae1410550
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776871642; l=7190;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=aPWShDH14HQxMJ8iA4Rk79fiAE8TWTCKBpmFbYoREsA=;
 b=118Z7V24Ha+H+g5jDyCftFU+i/5uGzjbCgmR9djL9FeSlf+zQ9GSDHUKxJIzasmMPI4BwDYYT
 aWnERdptjNqCNtsZQSH9bOHsFMUVaO0sHnglgCX5t2wDnXy7QUFYnxn
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

