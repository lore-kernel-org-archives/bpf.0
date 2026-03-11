Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC193E8662
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253380; cv=none; b=uK9wJY7T/lIIK2kPtSZ97E8JNNZe/xpa2A9UYoNYJGwMPKkstz9liR7xlOolLl+ae/4s88kTP5QUM69z5i9nMh01bHtuQg6E6bvoPU5h6XUlRnf0U6AqgUmd/fGxX5UbesQy1GdsI+uMw6XwsJJSSrQzaTGbVddV6SS7rD/YLkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253380; c=relaxed/simple;
	bh=mH3bM/ldtZ6UVhgJ6TlFp+titbWEzoXpNNq0FesPN60=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N9rMA6gk9nEI+gKtXIOioXvKGLnLG0VoDFQitksc6rNXdqr9FGzhc7dKDRl2P1F3HXU9TzdtYnlU9tTuRkRpT1cnDxL1AswLOV0c7LL6HNmiihxcKVee4vnK/+Rxy1HsoJVr5LJNAwIG0RrsZWgvOswYcKiQw+QaG7P6ctr/xPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmcUCwzF; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmcUCwzF"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439bcec8613so143206f8f.3
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 11:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773253378; x=1773858178; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aAZY7diBxt61UBSNSiMepYL8uRdePPNFU2y2RGhtpio=;
        b=UmcUCwzFsV2jbNUx1lQ1AgEqNjmFNdsAL8HLhTv2o1uVHH5UKbaCKx7yFwXuMxpzFZ
         ekB9Mbv+MhX0zS3C8jmx+SdAK/2ERWitT+SFBAk5lnRPLD0fJEHRvDbCt/7pF+ts0tVn
         M6zV4BYmEew9LsM5aiOfcNU37giotBsSQTCGdw1l0Wktqb6Igg2acnII2QVf3OB4hLfi
         lbon/LNUO4ikd2BSgKk/nOAU3wES6sTDoN6WGlFHqvte34i+MVm57ixTnM7go0oKFvcd
         cAJccCEjcm+SFlq4UaaemzsK6/AntC2VRCAMU2jCXIFaKn/N0Da1rrd5U8wkuJjNvhS8
         RFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773253378; x=1773858178;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAZY7diBxt61UBSNSiMepYL8uRdePPNFU2y2RGhtpio=;
        b=agO79ZpUW0u8tAHnMhAKUt4soUKl/vUH17I7xWqXrpOAOBe/+XCm6dFwGOZUXQW3Rf
         QYR/WuAqeMUe7jPy5daICh0HmwGHilSGbukujUdmvVgQR+pu4DQFc+ajQPhh7RwPgYam
         kpwQAkeyJs8mlFebYFJPmQZfHO9nqm+wQqRp+3ibcU0NkGhEYAk/8Na5+M4KUE7oQ0nT
         KSB78Es0K6td0l0Ox3TDjNA58a6b3M+maO2hgrV9THVSfj4+F0/9zWJd8KBKs4i+KMxy
         AbAQ35neq7jUrF73xcdaPEe+9SlRcSuIDmbO7p0RSqYgnSUA0uU8GE9ZCGXB1QLpVxEX
         yR6A==
X-Gm-Message-State: AOJu0Yy+a0lxaDSwV3OO6slpBi6FkE3tkeT30dbke8cBnn7S8yQC9dAx
	Fg2JHA8yba6eYecugZ6vKOGmDLFod1dkJfHBGhW94bAqHSDm2T5eflmQ
X-Gm-Gg: ATEYQzzc2IWKrZhx8PN+yZ92Kq9t6AaHLVL1LjVTNSdoKBWLf1KWDyOqbWmsnPqWzfg
	f+/UWzvGeHqrTQeHERYAcJggI9q1TzYu8vFtnBE7+X5cwOVSMSIKWF6VwKywLiUo3ZgnsBsSljF
	EymwuVjApewQ9RZTuuGFWpz2FmQurEdJnP5VDYWsAbaioyn0S97+iM8aZVslFLSB/w/HOx/F4Te
	igM4Uh5o5NEmNWkwwTXoi6oDpaYCZYlSnnaCNtGT5sNCShC9rXBilmrnxU2Vk5NyiFY8X2z5KXG
	AiZ1V+NZWQa3qxUjcHJaWvjrKAqu8rRUC9DpVJA+fl1aAZdXf0vJIAywpE7r+6s8SkphypoiJHP
	NRoh9y6b33JnlTY4mKbqQsNKszCfjI/dq8+c6wpRejyvGfF8OaVZQQrvhynRwHfRQT256u28az1
	QEfKBSowkIyjJevDXs
X-Received: by 2002:a05:6000:40c9:b0:436:3707:2bf0 with SMTP id ffacd0b85a97d-439f821b6f2mr7192753f8f.35.1773253377493;
        Wed, 11 Mar 2026 11:22:57 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20c0b4sm1172917f8f.25.2026.03.11.11.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 11:22:57 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v3 0/4] bpf: Add support for sleepable raw
 tracepoint programs
Date: Wed, 11 Mar 2026 11:22:48 -0700
Message-Id: <20260311-sleepable_tracepoints-v3-0-3e9bbde5bd22@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPmysWkC/3WNQQrCMBBFryKzNjJJTBFX3kOKpO3EDrRJSEKpl
 N7dUNcuH4///gaZElOG+2mDRAtnDr6CPp+gH61/k+ChMihUDSrZiDwRRdtN9CrJ9hQD+5KFvkl
 L8irRGIS6jYkcr0f3CV10wtNaoK1m5FxC+hyHizr8r63Mn/aiBArUGgfrhsage8xU7KUPM7T7v
 n8BtwQqYsMAAAA=
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773253375; l=3675;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=mH3bM/ldtZ6UVhgJ6TlFp+titbWEzoXpNNq0FesPN60=;
 b=+6wJUW6NghPI9nGdIMIjHP2p9wzNahNE6cZIfqKpP1QSd+jIvGszhmqH2OrDevqp9lA6Ymu6y
 B6Oh83h8C86BcFg+TCfFXIovgJxdYQ8Z2PIOScPNK7jD43Xnv9VG/dc
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

This series adds support for sleepable BPF programs attached to raw
tracepoints (tp_btf). The motivation is to allow BPF programs on
syscall tracepoints to use sleepable helpers such as
bpf_copy_from_user(), enabling reliable user memory reads that can
page-fault.

Currently, raw tracepoint BPF programs always run with RCU read lock
held inside __bpf_trace_run(), which prevents calling any helper that
might sleep. Faultable tracepoints (__DECLARE_TRACE_SYSCALL) already
run under rcu_tasks_trace protection in process context where sleeping
is safe.

This series removes that restriction for faultable tracepoints:

Patch 1 modifies __bpf_trace_run() to support sleepable programs:
use migrate_disable() for per-CPU data protection on both paths,
adding rcu_read_lock() only for non-sleepable programs. For sleepable
programs, call might_fault() to annotate faultable context and rely
on the outer rcu_tasks_trace lock from the faultable tracepoint
callback for program lifetime protection. Also removes
preempt_disable from the faultable tracepoint BPF callback wrapper,
since per-CPU protection and RCU locking are now managed per-program
inside __bpf_trace_run().

Patch 2 allows BPF_TRACE_RAW_TP programs to be loaded as sleepable,
and adds a load-time check in bpf_check_attach_target() to reject
sleepable programs targeting non-faultable tracepoints with a
verifier error message.

Patch 3 adds the tp_btf.s section handler in libbpf, following the
existing pattern of fentry.s/fexit.s/lsm.s.

Patch 4 adds selftests covering both the positive case (sleepable
program on sys_enter using bpf_copy_from_user() to read user memory)
and the negative case (sleepable program rejected on sched_switch
at load time via RUN_TESTS).

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
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
Mykyta Yatsenko (4):
      bpf: Add sleepable execution path for raw tracepoint programs
      bpf: Verifier support for sleepable raw tracepoint programs
      libbpf: Add tp_btf.s section handler for sleepable raw tracepoints
      selftests/bpf: Add tests for sleepable raw tracepoint programs

 include/trace/bpf_probe.h                          |  2 -
 kernel/bpf/verifier.c                              |  9 ++++-
 kernel/trace/bpf_trace.c                           | 13 +++++--
 tools/lib/bpf/libbpf.c                             |  1 +
 .../selftests/bpf/prog_tests/sleepable_raw_tp.c    | 40 ++++++++++++++++++++
 .../selftests/bpf/progs/test_sleepable_raw_tp.c    | 43 ++++++++++++++++++++++
 .../bpf/progs/test_sleepable_raw_tp_fail.c         | 18 +++++++++
 tools/testing/selftests/bpf/verifier/sleepable.c   | 17 ++++++++-
 8 files changed, 135 insertions(+), 8 deletions(-)
---
base-commit: bd2e02e3c9215305dfa344c050d5822f19929cf7
change-id: 20260216-sleepable_tracepoints-381ae1410550

Best regards,
-- 
Mykyta Yatsenko <yatsenko@meta.com>

