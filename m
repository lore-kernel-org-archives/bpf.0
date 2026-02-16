Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2C41FF61E
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771260709; cv=none; b=WCFlLMq23lL+x6G85iHkOVAso1LAsJnXs14PB7sNXwEaKNz+PLCnBzVRgXghr95wKwuFslK3UldYFTMDJwhy7WLViW8anmQT1hJR/aQmUn+Z0x+u08Ia8xKwQfVjAMZ7pnlh4C5bfLnD93ao59sQIGUCMF8tYjYCxsLm1Fn9NMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771260709; c=relaxed/simple;
	bh=j9KUWJcfESA1mWLvPmWh6+nd7/OXBlZmzlO5YjHL3Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CTWHeJly+O8+iH398zS0Vf4QQrAftMEp02O+JT4T7QhbihmG6vlS//m1kXMegiWyTwG2JmkgsH2O82BRASUegDzsiRf3D4FgVGm+T1CBwJmBh8fHvKROlEUkQrOHGjRlMb4QaX861azWQ88CLut7EVCT4ujWhddyawnhId+iQaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbDr5IBl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbDr5IBl"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4806bf39419so38851725e9.1
        for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 08:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771260707; x=1771865507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NDCriHrzn/JYKG01GPjMsow2FFrJxeUjg2GZhuyFBCw=;
        b=CbDr5IBlgpa7qJEBDHoevFpIGWLQkp5j4dTcGtSy1SxrW1n/5bFJGwS9KWlBWG5+og
         47pqc3wYlwDL2cjXL15SBFsSL8zxtXp26dqeZdBMfLx1wxaGLWF9+RHJONDPQoz96V3p
         us8xbLBosoYHR1yCV3iSyNgLMqwXLF/lHHXzsnb7hOvQdiaGkJEA1weokyLxA6/rY0WQ
         kNVCfEFQL78LpD3brrUyIferLkYWq28zskiNK0/NjBjE6sYvvS4oNh97oTvuZCLq8N88
         R9YRejlVSirHPC9/mfRsn8ra0cizlY/76uMeGuh1SAfgu9FpxFX9M4y6I4D6V2L9+R7F
         PaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771260707; x=1771865507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDCriHrzn/JYKG01GPjMsow2FFrJxeUjg2GZhuyFBCw=;
        b=wWHCXS4OPki5jiL0gKOW17UqWyFlGZfVq3QwD0OzO3g7KiP0tWaaxqpEkyKktQGBUo
         Vtk3oDL00vM30dUfYkqNJ4ePuT7ymfEpyFq61rCyx/KcqJ2snPjIdLGsgfBDinVtSLoY
         xC69r7eZ4v+aeLmJQkLfr0/GRB36WesMXrushJIERwoCX1No3sfdXMaPjcSzOP5qWcdb
         5lwloHHPua6SbQPe1Xac5mAk4kdduKqKb9NfShvL1+dMO3in/aezNz2W/mWvAUFQBzKK
         ZbDFWEPl3loBmUoZShVIaJcARJjEBlRjGiDRjDmhzvzQ7T0RRRpD2uGU5153U/L7jZvy
         iYRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsAf++nBP+e32NVP6UsrOcXOvHteOklPyIEdVJ1stDqThEsEuoddHgMnqQ3Xlwi3YU7hU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy2DzNbPGj8x/BJ5iFRY531lDkk7nVUAm7Xbrdk1FiDCMYKbkA
	IDXYasZNc2mwOXUvpxT1cPzWf+R83W9VJX2QB8KDFzVr+/4YeFpYtI50
X-Gm-Gg: AZuq6aKapzv5DsGkBfi202JBJhXwnCTnwD3h38Yg41zD2jEmgqMxOE+JG5AxrgznDF6
	+SKjX9IkAW/0fTlTqNNKsQz2ty6qNbM/xys0VOagBdhpsRo5YqnQiXA/V4KhygUgySMXxQ3UAYF
	STTYpNd7oGWqb+BG58S7u5k8rSU/08SFPrJbH/ct+i8c9w5QlcfyxrtmX5n84li7Vu6tKIaa88X
	yHM/WPGz6DWreAu2IdL6Ay5+joSJNn8q7v6vge6aWTgI658KM+N6ERAsoxxmYTaeVizRCVZ8hnV
	Z99glfL0SEx4squv0Chq7SN5wxoE8JfYIry+aJ9tzccClvmsNdE30bDNpOKERu4onQezTye7Ucx
	aU6/9gynl7QiL6ntsOPE1ef0XttL/fYtm2pFJMRuoNONuj/Dvpv8vHs+fFU4AfClNWKERR4Pb3c
	kCqo0qCZJ6QNZLXqG0VPiDInIYL4D2zcLelyHDfq6eC9ds1et3sJhKkQsPrN4cvAFhioyteREHk
	JWXOAvY
X-Received: by 2002:a05:600c:40c4:b0:47d:403a:277 with SMTP id 5b1f17b1804b1-48378f062b0mr112443335e9.4.1771260706643;
        Mon, 16 Feb 2026 08:51:46 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:c3fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4837b64b08bsm76454255e9.6.2026.02.16.08.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 08:51:46 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v7 0/5] BPF controlled io_uring
Date: Mon, 16 Feb 2026 16:51:21 +0000
Message-ID: <cover.1771260487.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
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


Pavel Begunkov (5):
  io_uring: introduce callback driven main loop
  io_uring/bpf-ops: implement loop_step with BPF struct_ops
  io_uring/bpf-ops: add kfunc helpers
  io_uring/bpf-ops: implement bpf ops registration
  selftests/io_uring: add a bpf io_uring selftest

 include/linux/io_uring_types.h                |  10 +
 io_uring/Kconfig                              |   5 +
 io_uring/Makefile                             |   3 +-
 io_uring/bpf-ops.c                            | 272 ++++++++++++++++++
 io_uring/bpf-ops.h                            |  28 ++
 io_uring/io_uring.c                           |  13 +
 io_uring/loop.c                               |  97 +++++++
 io_uring/loop.h                               |  27 ++
 io_uring/wait.h                               |   1 +
 tools/testing/selftests/Makefile              |   3 +-
 tools/testing/selftests/io_uring/Makefile     | 162 +++++++++++
 tools/testing/selftests/io_uring/common.h     |   7 +
 .../selftests/io_uring/nops_loop.bpf.c        | 131 +++++++++
 tools/testing/selftests/io_uring/nops_loop.c  | 110 +++++++
 .../testing/selftests/io_uring/overflow.bpf.c |  52 ++++
 tools/testing/selftests/io_uring/overflow.c   |  82 ++++++
 tools/testing/selftests/io_uring/unreg.bpf.c  |  27 ++
 tools/testing/selftests/io_uring/unreg.c      | 113 ++++++++
 18 files changed, 1141 insertions(+), 2 deletions(-)
 create mode 100644 io_uring/bpf-ops.c
 create mode 100644 io_uring/bpf-ops.h
 create mode 100644 io_uring/loop.c
 create mode 100644 io_uring/loop.h
 create mode 100644 tools/testing/selftests/io_uring/Makefile
 create mode 100644 tools/testing/selftests/io_uring/common.h
 create mode 100644 tools/testing/selftests/io_uring/nops_loop.bpf.c
 create mode 100644 tools/testing/selftests/io_uring/nops_loop.c
 create mode 100644 tools/testing/selftests/io_uring/overflow.bpf.c
 create mode 100644 tools/testing/selftests/io_uring/overflow.c
 create mode 100644 tools/testing/selftests/io_uring/unreg.bpf.c
 create mode 100644 tools/testing/selftests/io_uring/unreg.c

-- 
2.52.0

