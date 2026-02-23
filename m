Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEEC24CEEA
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855843; cv=none; b=A+4HHg2uNWMLyx31zmQ3nDNl87qDKAyQj4zWwRe/j1dY6gejX1NBGouW5Di3fprW3JgpDZ06oun0Gu2J83OvqThyIlrOuMpTt0zxXpEUoMw+kPmt6dOXhQJXbYYsyWujpiZeerI5hRXC/TKWcRvmAXSc/JZJk8t9WrzTgcD2DpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855843; c=relaxed/simple;
	bh=GEHv6UTPDs7U6JZWh2slAu4F/RIDHo2FMG4BtNv8VD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hONNnhgCylWX+ziEKATGW0jWZMqBB/YDaKU82OdmF7Z3NsCbzvKK+frMrnJ+fYILN4EEqpJHEB7gumNe/wj/eWGphmQsMqFDw7lPxK/8Vtht3iFiGilkUsc4prE7yHs/A5Xk7zSFD+TC7s02H/7R3ZgmQ1amR6dmzvjT5BYoNqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0veLx0k; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0veLx0k"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4837584120eso31149625e9.1
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 06:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771855841; x=1772460641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+p7vc6g7z5/JbLqUE9J2fE+Vu0p8qksvLODFtbrmmng=;
        b=Y0veLx0kvuEmFmi/1RBDnVPL8FUGwf3rneRXGmRP9LdiHaLIHPo29ncumoJ/893Quc
         hp5GBeAgzsBfnL6BZ0ncqs9bwJY9h18qRd0XEggEJ4ykPmilHEWg+ON/WtiOZZT8S6tW
         rc1yS9mg32Pf57AGJHRKZFtjkhy644TFzXWCRp2GN4KScRxnL/1msXlb4sR0VpmW5b8F
         N3ykWds4I4U0VeeGPfLUvxyk+2R/PCQeJPbEgsLV26mq9peMgj6MLrl2sBOH6OeVWQhc
         fWKGAVEnjHi/sReiEjE4HMJwpUpmepBdLBdANv5bAfiNemOQNX17VAFaPLNjVbPDCtba
         cVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771855841; x=1772460641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+p7vc6g7z5/JbLqUE9J2fE+Vu0p8qksvLODFtbrmmng=;
        b=QpLk7xcE14i99vg7X8s82GjIhiGQrJJqeFmzxIf/9onaCdKWfRziQuNdL+M154XtZp
         budLVMAmhpP92KdaBvoq88Rr2GLyIoMJxFPEpjdsk16wHDC0K0fC5i4GqYMKoYtI2762
         wJEjKhTvLFMmSbAIuel6uFyce4A80vD8nOc7oemSgsE4x/Sg8dk4xXIY0N8sjFBWsBKr
         7yXkPYMdplPy8IoxJuIys2cSP6zXFQMH/LUZ3z+k9kKxz7tOQ4FhLd2C8LX7Yr6aAS3c
         3za4WEXggGTuAKQ3T6wfDWeFnOGeUG6945DRxtG7r46+uuhXjgbDn60R1c4C11pxO/bJ
         hXRA==
X-Forwarded-Encrypted: i=1; AJvYcCWPQXZeTHd36NmnVtVpXnVOsHOQMsjUDl+82lflGFS6rU++q8F5veuGhFsSBZHx8YoDIxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Zmo7jZRnzjwmq+ZEbPA2NoslIchh22UCFesVkijqh6h5cy51
	bqjgVXJdrlEWYk13mBeGR8m4rFLllxldeLI6/nyHfo/5KWP1TN58Yb9r
X-Gm-Gg: AZuq6aI9eiEM6NtivRYzLGUMjUVV1IVgbHfF8Y9XEuhE9E2ANkCB7HlRI91z0s0FA4K
	Hw2nF3cF/tObZ2uimg5LOcJirCAGhft7ysJT29LNoIv7DFJU/jbEXnj9Zcudcb3oVe/7R+hELIE
	CtxhS9tDqP/yex9EWOp/etCbeswKvZNLDAJdD4nQnsZTMO3en5nUTNeKTZX/OStrTAEbwVOLFT0
	e/CFZjfK1bcZfSUURjRBaQKkBM3ie7ZahJ6hh2RUIgWtNlB7s79oxB1XfqYy0bKxDUM/nTVFxeo
	OC8n4wQvWAWwCrfWPrpFkiHm+OSXPXNrju+Nn7G0oz2p+6GuIipsDsgyONYQa9dafgp7G4Iq+lF
	yZQGo5GVVCjRWaz3Kgahc1C7iYQMl9QH4GLsiXLXpqTNrSTulM1zUagQ06cjh8pqZ0JqTUFHPWQ
	NQcHZDrU5NsS27WNSUSxeB2kRkymKhBfUj4v+Gp3GVXTEx347WQaqUwMg6480n9+P+6oC1xgrJ4
	Tj7QiR8fg==
X-Received: by 2002:a05:600c:4f94:b0:480:6bef:63a0 with SMTP id 5b1f17b1804b1-483a95eb370mr141042675e9.21.1771855840267;
        Mon, 23 Feb 2026 06:10:40 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:36ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm19464640f8f.6.2026.02.23.06.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:10:39 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v9 00/10] BPF controlled io_uring
Date: Mon, 23 Feb 2026 14:10:11 +0000
Message-ID: <cover.1771855760.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces a way to override the standard io_uring_enter
syscall execution with an extendible event loop, which can be controlled
by BPF via new io_uring struct_ops or from within the kernel.

There are multiple use cases I want to cover with this:

- Syscall avoidance. Instead of returning to the userspace for
  CQE processing, a part of the logic can be moved into BPF to
  avoid excessive number of syscalls.

- Access to in-kernel io_uring resources. For example, there are
  registered buffers that can't be directly accessed by the userspace,
  however we can give BPF the ability to peek at them. It can be used
  to take a look at in-buffer app level headers to decide what to do
  with data next and issuing IO using it.

- Smarter request ordering and linking. Request links are pretty
  limited and inflexible as they can't pass information from one
  request to another. With BPF we can peek at CQEs and memory and
  compile a subsequent request.

- Feature semi-deprecation. It can be used to simplify handling
  of deprecated features by moving it into the callback out core
  io_uring. For example, it should be trivial to simulate
  IOSQE_IO_DRAIN. Another target could be request linking logic.

- It can serve as a base for custom algorithms and fine tuning.
  Often, it'd be impractical to introduce a generic feature because
  it's either niche or requires a lot of configuration. For example,
  there is support min-wait, however BPF can help to further fine tune
  it by doing it in multiple steps with different number of CQEs /
  timeouts. Another feature people were asking about is allowing
  to over queue SQEs but make the kernel to maintain a given QD.

- Smarter polling. Napi polling is performed only once per syscall
  and then it switches to waiting. We can do smarter and intermix
  polling with waiting using the hook.

It might need more specialised kfuncs in the future, but the core
functionality is implemented with just two simple functions. One
returns region memory, which gives BPF access to CQ/SQ/etc. And
the second is for submitting requests. It's also given a structure
as an argument, which is used to pass waiting parameters.

It showed good numbers in a test that sequentially executes N nop
requests, where BPF was more than twice as fast than a 2-nop
request link implementation.

v9: - Update mini_liburing
    - Clean up the nop test, bound the CQ processing by a separate
      constant and not CQ_ENTRIES.
    - Add helpers for sharing code b/w examples
    - Enable IORING_SETUP_SQ_REWIND
    - Use io_uring regions for parameter passing.

v8: - Remove an check that is "always true" to silence smatch
    - Kill unused variables from selftests

v7: - Fix CQ overflow flushing deadlock and add a selftest

v6: - Fix inversed check on ejection leaving function pointer and
      add a selftest checking that.
    - Add spdx headers
    - Remove sqe reassignment in selftests

v5: - Selftests are now using vmlinux.h
    - Checking for unexpected loop return codes
    - Remove KF_TRUSTED_ARGS (default)
    - Squashed one of the patches, it's more sensible this way

v4: - Separated the event loop from the normal waiting path.
    - Improved the selftest.

v3: - Removed most of utility kfuncs and replaced it with a single
      helper returning the ring memory.
    - Added KF_TRUSTED_ARGS to kfuncs
    - Fix ifdef guarding
    - Added a selftest
    - Adjusted the waiting loop
    - Reused the bpf lock section for task_work execution

Pavel Begunkov (10):
  io_uring: introduce callback driven main loop
  io_uring/bpf-ops: implement loop_step with BPF struct_ops
  io_uring/bpf-ops: add kfunc helpers
  io_uring/bpf-ops: implement bpf ops registration
  io_uring: update tools uapi headers
  io_uring/mini_liburing: add include guards
  io_uring/mini_liburing: add io_uring_register()
  selftests/io_uring: add BPF event loop example
  io_uring/selftests: check loop CQ overflow handling
  io_uring/selftests: test BPF [un]registration

 include/linux/io_uring_types.h                |  10 +
 io_uring/Kconfig                              |   5 +
 io_uring/Makefile                             |   3 +-
 io_uring/bpf-ops.c                            | 271 ++++++++++++++++++
 io_uring/bpf-ops.h                            |  28 ++
 io_uring/io_uring.c                           |  13 +
 io_uring/loop.c                               |  97 +++++++
 io_uring/loop.h                               |  27 ++
 io_uring/wait.h                               |   1 +
 tools/include/io_uring/mini_liburing.h        |  21 +-
 tools/include/uapi/linux/io_uring.h           |  96 ++++++-
 tools/testing/selftests/Makefile              |   3 +-
 tools/testing/selftests/io_uring/Makefile     | 162 +++++++++++
 .../testing/selftests/io_uring/common-defs.h  |  31 ++
 tools/testing/selftests/io_uring/helpers.h    |  95 ++++++
 .../selftests/io_uring/nops_loop.bpf.c        | 108 +++++++
 tools/testing/selftests/io_uring/nops_loop.c  |  89 ++++++
 .../testing/selftests/io_uring/overflow.bpf.c |  51 ++++
 tools/testing/selftests/io_uring/overflow.c   |  50 ++++
 tools/testing/selftests/io_uring/unreg.bpf.c  |  25 ++
 tools/testing/selftests/io_uring/unreg.c      |  92 ++++++
 21 files changed, 1270 insertions(+), 8 deletions(-)
 create mode 100644 io_uring/bpf-ops.c
 create mode 100644 io_uring/bpf-ops.h
 create mode 100644 io_uring/loop.c
 create mode 100644 io_uring/loop.h
 create mode 100644 tools/testing/selftests/io_uring/Makefile
 create mode 100644 tools/testing/selftests/io_uring/common-defs.h
 create mode 100644 tools/testing/selftests/io_uring/helpers.h
 create mode 100644 tools/testing/selftests/io_uring/nops_loop.bpf.c
 create mode 100644 tools/testing/selftests/io_uring/nops_loop.c
 create mode 100644 tools/testing/selftests/io_uring/overflow.bpf.c
 create mode 100644 tools/testing/selftests/io_uring/overflow.c
 create mode 100644 tools/testing/selftests/io_uring/unreg.bpf.c
 create mode 100644 tools/testing/selftests/io_uring/unreg.c

-- 
2.53.0

