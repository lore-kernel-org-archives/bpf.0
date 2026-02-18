Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A7C33373E
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771430501; cv=none; b=YEJtvDZeBU5fx+RswJZs35yUqKPaZUdF16rVUymUkNzXKWltkB3WiQ5AZHoXH9m/tBpSJht+rlfG+FZYZR/4/TehL4zYfu8haGY91oeVssc6N9Ff24jipB+8OYnxKKhKlziJ8+z32AEvfFra/9X36Ciy958MPtKV5K4louJfi7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771430501; c=relaxed/simple;
	bh=O4SG8s2YeegI+GuYYNLo9XdcivO1N6Wybawv+eZ8EZw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RIeFo6YyN855+uXrvWtdN3TXYMeVR+6qiieMa7k80itO5XLl3WfkgB3rlfTxIkC7cJqGuZStIWRHHyyL7Jies1p8rYV/vCzDzwCnjws4VN4DpAU799+mPvTt3wmdfCL7OPiq8E6ZRy+J1dBLOpWCqa/K3aFfmyWrVsNTixxlOGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXwVYrEW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXwVYrEW"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-435a11957f6so3059f8f.0
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 08:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771430498; x=1772035298; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=trnn5EjYxZSQ+ap9juU7XmeABR2xrLbkm0QLwArha+w=;
        b=aXwVYrEWJEphoaC5MUvCbrhH+LVBZXI5IJAoVTs2xMKbpu5uXYge5JLdDpj3h7mUaY
         +xcz8ptsODDCnvy6Q7KCQq6hKr+fxJEjHC74kud58W9YrEYKE5JNs8XHyh4CAWhJbe/H
         n9iFUi2Y1glj2bqtO2RmGevqvBoa4l4TZrD9+HRFQAIzaaODZPeT2r8Iaqa9uDM6SBK/
         uyj1cM2svrAbcpWIAB54gMhTc25kprsIf631am/FiM7wTxRXKHp0/o/VIoz/kxyNBO42
         U6j3tUPXGDVjR9/PpE407BH8gxHIeALGcjrs11Io92X+w5Cy1LMTXN6vMO4HN5s+a6TF
         gkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771430498; x=1772035298;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trnn5EjYxZSQ+ap9juU7XmeABR2xrLbkm0QLwArha+w=;
        b=xUk6cDxI5DnuxLr4ht96wr3NYgbbAbEOqcFz+NW3za26egERnNp5+/QgPFNv+UHlLq
         FAaVwcQPfjtzloe2D2taMq90SG6UCz7rLDZD02AVoCKI7tHwjxpx2VQUopiM2kjEpI9X
         bnA4jrymNorkgn8l4YBc3vhxpTGMG9a4txA22FjDsM1+t2HNBTbcdgh1DQfj60xB/H+5
         DoIzHFXlxVh1Z82R2XXxem4rYMHQQ8h27vp78YrwPgZp6kQHOAkQwV8Gqd7ABgNMP4cc
         TsqSHOUAQvd1Gmy6nxNEOK/S6rxuQMlJ4drPDCREXxGPWMxLdUMf22Cnin7J98cP5hzl
         E3Sg==
X-Gm-Message-State: AOJu0YzVF+8UE5y21qX4goIZf5zq2JGFRd5T1SrRwBC4UaJOp8uU934o
	YRm2w83XbaD27bmyP1y61IPumlMry4yCqpMDJWoozj3f7HMceI9RR4Ke
X-Gm-Gg: AZuq6aJM6jzDKm2e9yEbmvGqp2YZCJuq/OTjPRbh7vo98hnD/P4usApDQSyRc2TMCwT
	cvNh2plio4G/tg8x3FmvNexvc+t7ansrqf5dAclokEuI2TI2MeYgzwKNVMHrE9QAkKnQmsckE7D
	jNFAFNaw3EoomKJqZzpI3BMs29azrq5iMMSg8BtRHPNQ7P9UgA9z/WiT/k02jNCoS4/RZHrKdCt
	MnQkqruFpWtkzNkPSCvSXkGcNsQWHa6EV5XWIcZM0mG59sDnoWN9qhjGGHiP45FU2RKV5BgQHgs
	wQ/SYdrfb45L7GTpadC4/gYTbqWXWDy64BvbvMiFW3AoknpG+/+pqpDGmTKgPPJ0aG1/V9ZfsrK
	bdQkiQMYDwcBSQ0P/I6iZbvYmN3U7JYi/Y74IYw8v43JhWNRR8FRMyZyFhtXRlmWpIXKueZj2t1
	SckiBAfxo=
X-Received: by 2002:a05:6000:40e1:b0:430:fb00:108f with SMTP id ffacd0b85a97d-437978d515cmr30834189f8f.18.1771430496344;
        Wed, 18 Feb 2026 08:01:36 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::6:66e8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac800esm45558980f8f.27.2026.02.18.08.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 08:01:35 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH RFC bpf-next 0/6] bpf: Add support for sleepable raw
 tracepoint programs
Date: Wed, 18 Feb 2026 16:01:17 +0000
Message-Id: <20260218-sleepable_tracepoints-v1-0-ec2705497208@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQrCMBBG4auEWRvIRFvEreABupUiaf2rAyUNm
 VAKpXc3uPwW7+2kyAKlm9kpYxWVJVbwydD4DfEDK+9q8s63znNrdQZSGGa8Sg4j0iKxqD1fOYA
 v7JrGUW1TxiTb//uk7nE3Q5psxFaoP44f4Lb+BHUAAAA=
X-Change-ID: 20260216-sleepable_tracepoints-381ae1410550
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com, puranjay@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771430493; l=3068;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=O4SG8s2YeegI+GuYYNLo9XdcivO1N6Wybawv+eZ8EZw=;
 b=EefnT3wv8QKYIq6rb/a5q3UfIlbko2uoKPMXxloNziOdxh785P0LDW1UKzLB0GZYWQZk3iSMC
 EpQv4lJpN7cBNZNnD9ONdNhPh9B8QRc7FKs/ZhBIsxlcSDBnymKO+Om
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

This series adds support for sleepable BPF programs attached to raw
tracepoints (tp_btf). The motivation is to allow BPF programs on
syscall tracepoints to use sleepable helpers such as
bpf_copy_from_user(), enabling reliable user memory reads that can
page-fault.

Currently, raw tracepoint BPF programs always run with RCU read lock
held and preemption disabled, which prevents calling any helper that
might sleep. Faultable tracepoints (__DECLARE_TRACE_SYSCALL) already
run under rcu_tasks_trace protection in process context where sleeping
is safe.

This series removes that restriction for faultable tracepoints:

Patch 1 allows BPF_TRACE_RAW_TP programs to be loaded as sleepable.
The actual enforcement is deferred to attach time since the target
tracepoint is not known during load.

Patch 2 adds an attach-time check to reject sleepable programs on
non-faultable tracepoints (e.g., sched_switch) that may run in NMI
or other non-sleepable contexts.

Patch 3 modifies __bpf_trace_run() to support sleepable programs:
delete cant_sleep(), use migrate_disable() instead of rcu_read_lock(),
and rely on the outer rcu_tasks_trace lock from the faultable
tracepoint callback for program lifetime protection.

Patch 4 removes preempt_disable from the faultable tracepoint BPF
callback wrapper, since preemption management is now handled
per-program inside __bpf_trace_run().

Patch 5 adds the tp_btf.s section handler in libbpf, following the
existing pattern of fentry.s/fexit.s/lsm.s.

Patch 6 adds selftests covering both the positive case (sleepable
program on sys_enter using bpf_copy_from_user() to read user memory)
and the negative case (sleepable program rejected on sched_switch).

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Mykyta Yatsenko (6):
      bpf: Allow sleepable programs for BPF_TRACE_RAW_TP attach type
      bpf: Reject sleepable raw_tp programs on non-faultable tracepoints
      bpf: Remove preempt_disable from faultable tracepoint BPF callbacks
      bpf: Add sleepable execution path for raw tracepoint programs
      libbpf: Add tp_btf.s section handler for sleepable raw tracepoints
      selftests/bpf: Add tests for sleepable raw tracepoint programs

 include/trace/bpf_probe.h                          |  2 -
 kernel/bpf/syscall.c                               |  5 ++
 kernel/bpf/verifier.c                              |  3 +-
 kernel/trace/bpf_trace.c                           | 22 +++++++--
 tools/lib/bpf/libbpf.c                             |  1 +
 .../selftests/bpf/prog_tests/sleepable_raw_tp.c    | 56 ++++++++++++++++++++++
 .../selftests/bpf/progs/test_sleepable_raw_tp.c    | 43 +++++++++++++++++
 .../bpf/progs/test_sleepable_raw_tp_fail.c         | 16 +++++++
 tools/testing/selftests/bpf/verifier/sleepable.c   |  5 +-
 9 files changed, 143 insertions(+), 10 deletions(-)
---
base-commit: 4c51f90d45dca71e7974ed5a7c40b9c04a6c6762
change-id: 20260216-sleepable_tracepoints-381ae1410550

Best regards,
-- 
Mykyta Yatsenko <yatsenko@meta.com>

