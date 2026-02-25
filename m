Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B312798E5
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036637; cv=none; b=hRBm6G6Q6VSzUh4uOQd3iEC5ZP4JSZX36SL5S3TbbNJGd+sNeLUeBkWYkIx2pyLoJ5rq2VrcUitNLhxsvF9y1gi01E6RxMQ+5fwr7nS+IUdKfMHXM1pRRGLvR+niorCr4+t443iVwzCfLECMOkYmzrUJei++Sbu3svUSMmLZ2ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036637; c=relaxed/simple;
	bh=gsvUc/wnNO0M/csOUZ1gRAf96GWjGH5xm/B7l+BzW6w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AvbbjuayjCnYJ2lMO0cKnMofw4tdaiJz1vPLczB7FgjVISWTWM4yzh1rClDZ7mNTkRUOuuXumNcBYKCa6aRbBklVSxybKEC+BfDkuYiSQFpb/RF+3JmzipTb1KIUtn08m4WjW+Mm6pqLBZOBvZ7WNNdmVBVIhkwqPSeU6q+e3wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9yAN1vt; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9yAN1vt"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48336a6e932so42213315e9.3
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 08:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772036634; x=1772641434; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pUfzA6e/ymOWN+UIP0/6NI8B4wcYKwtSJz5+KSlm07g=;
        b=f9yAN1vt75VylLywuOTnLMNkfkrkiZ1fneaAbLxbpfIJLf3g7lA8wa+SxsHOPWH3l7
         KKWw9NGXFMX3vBF//oYvYspFCtr2iwdyXfW5FO+gfGpKsrLimaJZHVcBf5Tr1Ts5cZo2
         vbYb2uk5U1y+5Sy0FUr86svEjoCjpS2xg5qVd+8GfZLgqvnuC+LGc+jsp9Fcqm1g0+yL
         jWD7Sn8t0pkrguwYaWtCY3197kWRX6VJJLT89wRdTNGJ+7wMvangKGm9Ux4U1PJhsFg5
         QZ67gJLuvuKlkhgwK7StBvgDka52BCejnjiZgGewP6b8qyYMeGE+3eLub12JGRcWn+W5
         39tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772036634; x=1772641434;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUfzA6e/ymOWN+UIP0/6NI8B4wcYKwtSJz5+KSlm07g=;
        b=bNnrob6wXLe+eW7ySZHprq32MwKUYFynxApw/wgu/uJxOlCC6V9TMfzhjOxi1z23lU
         sVOYPvHHwI38wGBovzLmIMGaczK6s8iCBTvH/mzqG5ZvdC7/S2oIP4wwPmtMY+tutC51
         WX/bFqHeabIhuNzRiMr0oWQhiXTZezsVfFDYpHf4tIdVHV9fX/1ndir4pSPo4WhwXg1U
         BjWo9Oe02AJrvbCVxa23wpDWlHBEoLouKCF/CnT08XT1H2Cxm8HK5IfEQ6uzG6W/4rGk
         b5FYZifkckIVd9Rl9gB7I7hPIPSbvmaG0t+sL++iRkeMG4IwPwc1J4r7HWJTWbaLlSMD
         5hIw==
X-Gm-Message-State: AOJu0YwPwCtSZnIY5fTzdV5YfCQ5aVzgCU5eh6Z++YbkHYo5rBbPCUf6
	eoYyVLia2Fi25gC+hsYJfTNcuLQNeka0F5yeclXHKiaq8VJTYm28mX3t
X-Gm-Gg: ATEYQzyCJ0IG9y+CayUOF/sZSKtb7cBHqx7nkG8Gu6jcgSYvyiZA4Nxl1nUF4iLTbK3
	WXy1SHfUOO3FPutpbdIRZbrhPh6qZMZxMsJYI7lALWcNABvqsTPi6ZBatqcrGFs75MwZgbIFmu/
	sbeCr248VwaL1HoM6AE1TjldFJzFaTT0wLPQlCaxjZJqc+wcuXaFTwMsbht0zzpl4M1GE6pvsVH
	DJqMVhrFpDR0M9MZ5cJq6Kb3Q887qlqiOPZFfY3uvT91D698b0xglBixqvc5js2qCkqp9O2Hv9A
	n4N5I/9om9tf8SqjDeV5qfc21j80CCfjLehO874VTc04O/K/ykwfiH7KO9FAAvJd+fGGfWXTDsl
	YHL8Ij/UXShbHG5+vi6qmtPhBOXydPd3fz8nfoXP5Qi23fdon8yMwDXSbTXWCANF5qIKuDj/9AV
	mzFD6cIwocokcW+PiwPg==
X-Received: by 2002:a05:600c:6815:b0:483:a21:7744 with SMTP id 5b1f17b1804b1-483c21a1195mr17797055e9.26.1772036633889;
        Wed, 25 Feb 2026 08:23:53 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:54::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfbb465bsm37411215e9.3.2026.02.25.08.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 08:23:53 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v2 0/6] bpf: Add support for sleepable raw
 tracepoint programs
Date: Wed, 25 Feb 2026 08:23:48 -0800
Message-Id: <20260225-sleepable_tracepoints-v2-0-0330dafd650f@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABQin2kC/x3MSwqEMBBF0a1IjTuQxA/SW2kaifrUAokhFUQI7
 t3g8AzuzSSIDKFvlSniZOHDF9hPRdPm/ArFczFZbTttTadkB4IbdwwpugnhYJ9E1b1xMI3Rbau
 ptCFi4ev9/mgMi/K4Ev3v+wG8SdDvcQAAAA==
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772036632; l=3366;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=gsvUc/wnNO0M/csOUZ1gRAf96GWjGH5xm/B7l+BzW6w=;
 b=FrIOY8bDuGvbWQjFVUROqoHAUMhkexGxrLnSIfMaeZU0PPX7HfwAnZKryBCUmRWLV0ux8aG5/
 1M7h1YfP6lFDagEGEmPYAAFHJJSmRUyLUh6KpmyUscvsKRTXq8tPx7k
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

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

Patch 1 adds an attach-time check to reject sleepable programs on
non-faultable tracepoints (e.g., sched_switch) that may run in NMI
or other non-sleepable contexts. This is a no-op until the verifier
allows sleepable raw_tp programs.

Patch 2 modifies __bpf_trace_run() to support sleepable programs:
use migrate_disable() instead of rcu_read_lock() for sleepable
programs, call might_fault() to annotate faultable context, and rely
on the outer rcu_tasks_trace lock from the faultable tracepoint
callback for program lifetime protection.

Patch 3 removes preempt_disable from the faultable tracepoint BPF
callback wrapper, since preemption management is now handled
per-program inside __bpf_trace_run().

Patch 4 allows BPF_TRACE_RAW_TP programs to be loaded as sleepable.
All runtime infrastructure is in place at this point, ensuring no
bisectability issues.

Patch 5 adds the tp_btf.s section handler in libbpf, following the
existing pattern of fentry.s/fexit.s/lsm.s.

Patch 6 adds selftests covering both the positive case (sleepable
program on sys_enter using bpf_copy_from_user() to read user memory)
and the negative case (sleepable program rejected on sched_switch).

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Changes in v2:
  - Address AI review points - modified the order of the patches
  - Link to v1: https://lore.kernel.org/bpf/20260218-sleepable_tracepoints-v1-0-ec2705497208@meta.com/

---
Mykyta Yatsenko (6):
      bpf: Reject sleepable raw_tp programs on non-faultable tracepoints
      bpf: Add sleepable execution path for raw tracepoint programs
      bpf: Remove preempt_disable from faultable tracepoint BPF callbacks
      bpf: Allow sleepable programs for BPF_TRACE_RAW_TP attach type
      libbpf: Add tp_btf.s section handler for sleepable raw tracepoints
      selftests/bpf: Add tests for sleepable raw tracepoint programs

 include/trace/bpf_probe.h                          |  2 -
 kernel/bpf/syscall.c                               |  5 ++
 kernel/bpf/verifier.c                              |  3 +-
 kernel/trace/bpf_trace.c                           | 20 ++++++--
 tools/lib/bpf/libbpf.c                             |  1 +
 .../selftests/bpf/prog_tests/sleepable_raw_tp.c    | 56 ++++++++++++++++++++++
 .../selftests/bpf/progs/test_sleepable_raw_tp.c    | 43 +++++++++++++++++
 .../bpf/progs/test_sleepable_raw_tp_fail.c         | 16 +++++++
 tools/testing/selftests/bpf/verifier/sleepable.c   |  5 +-
 9 files changed, 142 insertions(+), 9 deletions(-)
---
base-commit: f620af11c27b8ec9994a39fe968aa778112d1566
change-id: 20260216-sleepable_tracepoints-381ae1410550

Best regards,
-- 
Mykyta Yatsenko <yatsenko@meta.com>

