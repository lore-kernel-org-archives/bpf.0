Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2A7276028
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770820382; cv=none; b=tsbNS0BE7nfeGPtRTucm9MAG/EXA4lPFqOyJLLXBSp4x83c9Exn+AP3ISqRD/MHB7/5sk5m3zTWF6BP27GTEjjFI+lM4hzG5k0obXQoyVarq9qG7OdnlfOxLvGzG/dbACXMEpvkVskBhNIUPaRD96x8HSmNfLN7qYPO+rCNCuOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770820382; c=relaxed/simple;
	bh=C/vFe3kP3KooC/TmOFBj2WXiog79aHaJOYYv/rT9B/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sRBRYsKZs9JUlR/FJzLcmQ3HIg2fCgCnDpIVBML+y+VoUiipFAlDxzhOsZiNpJ26+lIiXmdEM9uFEuaXigq3v5bm1IC/NVX0fEY8T2K+cNw6R8oW7BFCSBuzvV/iG1hK/TnC4MnPBIDXxg59d/32Csk/n5ZKy1eKFDoXtPUiZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfJ1Z+lF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfJ1Z+lF"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so10337405e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 06:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770820379; x=1771425179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a+ACQbMRmW1Q78x2xp/swFKuW80lioyh00YybAUgjDI=;
        b=MfJ1Z+lFxNU7FjGJ29H3zzZLFWu536Rfo+AfqA6HKT8Ni6D6EdREMLSJCkmi2GJ6wG
         I8b9H6Rq56te982z3aElNG65tA5gNaNc1u0PYU0i6p1heMmNRoCwPi64vWAuu+04Kshb
         GgP1huFHTJABmSAal2GcrJiXKJfUijCXfKGOueXYq1T7PuU3XM9fHjiSu/rqVESVVwgj
         WpQkBx/V4jo8z4evA/yzNC7raXd7V0HAqeRMcD/6bIXuLXqGssGQaP56ZzwDWZ74whNL
         OQrvNZ6Uia8+uyw872VdlEjZAGTq7vpEH/GoBD19NrH9l97wnVHgnT7iV1vyME1yKcK9
         YBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770820379; x=1771425179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+ACQbMRmW1Q78x2xp/swFKuW80lioyh00YybAUgjDI=;
        b=WvPKd5mArNB35WkYOt/jKu2XN2RZbPGD0jD8o2XnvyQtiMuxaY3I9BQsFRgmIpkOfW
         6rDKpZTlBeYmRfPXjibQDjpunRG17WUZQE3x6NCJ3H3DJtKYiPruKwiCaZQbX65PrZ5m
         AExARoEA8tEOvUQArcpyYVkGFD9TCXLRSdNFArDJ8EBm58ZiiI9V29frCjzr9hR+oFxy
         Wp44IVWFe5pW/CZszEbDmym/gQCb8D0O3cWq/4LCtUD2L8dSAWSzHUfm6oGGf6W1OTzh
         dzjJUJ58oyTOgmxXDN8sXCc0xwC7tmPXZMC7VyOVThtXOpkVeCRYa5T3+NQ1iaQZMDDP
         iltA==
X-Forwarded-Encrypted: i=1; AJvYcCUwrEQoJCv40gq5oyEanQhBB7L6fC9RG8cVsSDXnAzfsOoMqTDEERizoqaaeWp3Uppt21s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg6SsAU2yGmMfs0j31YtnQH75W0qqD43XewUA4nrDoJW4EUlua
	W3FtGhnhUq5Ween5XXGsryDkeuIJsQ9zZYdybwNI5d3IYTFuBL1TthyI
X-Gm-Gg: AZuq6aIUBdoqYjuO5yDdVo8bnHubBr8tm6ZN/yXqLKXwNM452LlUePV21koN3tPhj6M
	D10BZk3GFJ0YSC3zSfzFuE3DzqwFiMIcBCJ3XDiLFhjTLj8qq/1s6xJX8xcDUJqjF7yBgJkxqVe
	fnRjAlnl2FWd8RhZCDyWyX9t1HUWvHlER43ctMZm5mP4tezW8ASAxmic8Zst3qlS6aOZsFfXQX9
	3FNqqn7awQfwKJIqHiLW8/HZrqEHCTYuD49CHTMrnNw1OTZATGr9hg5IiAHaInFdz7cxH0Na0fh
	vLYD3kl0INZ0uPzKcUOeS8+QsxBZnwL9pdz2vkKlZCJZoG5t4Bp9KO4ouCgLSPMiDgrexMOijTj
	PE/FCnrF9SS5q6kEU7V+aroVNu4UNHhbAeNe9tUcDc+W6bZAt3KWapArL96AT/tyYUdOBSCdK/x
	4d2Zfao2T3z5K38HiP2lvSNxtarI4kEyh5xgiu3WRtj0WHTEbCpY6r3YwhtnvfO6/GrYe80uMZn
	iUtcU4ZIg==
X-Received: by 2002:a05:600c:1548:b0:479:1348:c63e with SMTP id 5b1f17b1804b1-4835052d123mr80635675e9.9.1770820379204;
        Wed, 11 Feb 2026 06:32:59 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:b997])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e39c75sm4973747f8f.29.2026.02.11.06.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 06:32:58 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH io_uring-7.1 v5 0/5] BPF controlled io_uring
Date: Wed, 11 Feb 2026 14:32:39 +0000
Message-ID: <cover.1770818588.git.asml.silence@gmail.com>
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

I've got ideas on how the user space part while writing toy programs,
mostly about simplifying life to BPF writers, but I want to turn it
into something more cohesive before posting.

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

 include/linux/io_uring_types.h               |  10 +
 io_uring/Kconfig                             |   5 +
 io_uring/Makefile                            |   3 +-
 io_uring/bpf-ops.c                           | 271 +++++++++++++++++++
 io_uring/bpf-ops.h                           |  28 ++
 io_uring/io_uring.c                          |   8 +
 io_uring/loop.c                              |  96 +++++++
 io_uring/loop.h                              |  27 ++
 tools/testing/selftests/Makefile             |   3 +-
 tools/testing/selftests/io_uring/Makefile    | 162 +++++++++++
 tools/testing/selftests/io_uring/basic.bpf.c | 131 +++++++++
 tools/testing/selftests/io_uring/common.h    |   6 +
 tools/testing/selftests/io_uring/runner.c    | 107 ++++++++
 13 files changed, 855 insertions(+), 2 deletions(-)
 create mode 100644 io_uring/bpf-ops.c
 create mode 100644 io_uring/bpf-ops.h
 create mode 100644 io_uring/loop.c
 create mode 100644 io_uring/loop.h
 create mode 100644 tools/testing/selftests/io_uring/Makefile
 create mode 100644 tools/testing/selftests/io_uring/basic.bpf.c
 create mode 100644 tools/testing/selftests/io_uring/common.h
 create mode 100644 tools/testing/selftests/io_uring/runner.c

-- 
2.52.0

