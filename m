Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6612882D6
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110129; cv=none; b=nDEScP+Y4EpgWM8iQHmEG/DVlivAhZ5YhU+79BGDMIhAnM/1/1h3e6sHUmGGQ+ZzOxLuYn12kfWh0YuJxeIa2oKf/5uGNkzVt4fI+b4UIdzsl5XvSsgBdSKxhUvqfej6fBOmELDZZAkdaw9X6PqOjTi6zHQk1S9XhflnLCvkomo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110129; c=relaxed/simple;
	bh=bioIdntw+EbiCH62mI8wKIHqsyEz1Z+mpV8qZpW6E7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QqpyYh2fS5z08t5LAHXegIRg5RxySowHYj6tLxwS9JgHTWVcN0xFWJJgCZT7kWBKUjKlARrqykPVTURUSk9iVbGyGxyGpMqnG6T34ZjdQd30xSO22afY+7AJYtCb4wfRlzqJQEIPlvRWjRSp6+3Qe0/GsPVAs40HLoukjHriotw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiqqvAQp; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiqqvAQp"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-483487335c2so7621335e9.2
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 04:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772110127; x=1772714927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zb02RlG515wD0Bxc0e7IkiTY4DFrs2fLfp44nwOveIE=;
        b=ZiqqvAQp/7a55IdN3FMXmgFdehWLdjKxM7ZOMzRrQKFDKAAVXRaQkE6DtRFdMC1nNq
         sEFMeHU0ej4l1bO9/gjcqW8c3kMbOWX43fNdbnY7xgvD9B5/W9hThvzKOuN8WSJJTqxV
         KDqXhGia9Ywy7FiRnLJ66KBBdpQH8CoPF18CxnaGxvwf5Kto9LlVHWTJ35f0KBzy1Daa
         EuCK6O4XBN3pnMPw/g5qWWnH7XJyMF6eXF3X72qGMJiRIqbwCi6oHMj9pYqrwXiITsaD
         nKI5GJURzz06Rq8PdDzyaNr/gmp0+tTpv6+4/nsdSQm4QwsfvuC6XF/gnXtBetyo80WS
         darw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772110127; x=1772714927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zb02RlG515wD0Bxc0e7IkiTY4DFrs2fLfp44nwOveIE=;
        b=i8+z8v7DYvZPT6PMBJRVhQBJaI+/KZKt2F8n4tlyMWTH1VGT3I6ySqN0L5DaEeN31I
         Q5xbYdLZdGWi34KToZMpgiVDS9fQP2lHUdJLK2h0OFtm37J+UcOLfbJRWbdN4ZJaZKDU
         iYmtVy7yS+Rfe01mgfS0rf39Ou8g0mttRq8XifFqGcwLxjqlZQwCkL7gzvNKPo3Aby8B
         w6PWYmCTp+tEI3e/3SS7JAhUnmCY+1ylcghDWHjDOVKdEvl4K3U39470l2lh+lBVE3zv
         edo/kyD5XPRBLJ5hfcHrT1PJkPNCmZbM7qyUGgFJs/syRfciStFD7m4ASyGq4hBvP/UA
         eNpg==
X-Forwarded-Encrypted: i=1; AJvYcCW3Pmne5V9PzgMi/x0Wr0HGmz2x8vwPELOULxl5x9DyZhKAgYDWmGJXvH8b4VIXqU6ayBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrhkCfSDobhdsxzvpMHzfuH5J+SvjgVXOBn3LmnW4JhLu0sWv9
	LRuWixCi6JwErx/SAI+lLlU5YDzz0+bMmObjXAGPerqx0cDPwQOeDprw
X-Gm-Gg: ATEYQzw9nIDib5kOzecwLD//ls75WDWOavvR/zLq3Eb9TCMjnCL2hJ6mMOa56+eFHEI
	q+KQL5UiktNCUzNCx6bh5vvDB0wb9QzHzjZo5bFeU03lOj7jnwelSqgNHot6976N9XODufSnjeN
	xa4lMHctShRrcI4QAjeUZHtB48EekXD66B7MCgNrpKLSoUYmXT5O+/yz9S5CJvCRxTYbgnpl2si
	EbGr4CtZvhG8QjYirsoUtRG1BP3rqJfp7cM8UbUIsDgr5W45oVWBXuLNjO/HccjreZQ9htV2Hjx
	y08p6+9p4gTWwDDdP7PO5BMJPmaQG0NsqxKAGKeeCuJrAhzbNLGTy8AWkKAGlrDLanF8dBuWXvW
	gxfeLAQvcDEwTGi+a325Wn202g3zq4aoymsMQ0KmgcVWoALnnSWdxeDmOvW+5BNS+dg/SC0295s
	ikhBMniN5wdt7nbHAqRN9BOFjNbMp7usnOLPHVx8EsmtTTHUaFovFQcwDnbZrZOCtLro1xx34Ux
	SpkxUe/XA5OnX2fdviS
X-Received: by 2002:a05:600c:1d15:b0:47e:e8c2:905f with SMTP id 5b1f17b1804b1-483a95bc0cbmr294148585e9.8.1772110126619;
        Thu, 26 Feb 2026 04:48:46 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:2ab0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c977sm43734576f8f.32.2026.02.26.04.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 04:48:46 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v10 0/4] BPF controlled io_uring
Date: Thu, 26 Feb 2026 12:48:37 +0000
Message-ID: <cover.1772109579.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduces a way to override the standard io_uring_enter syscall
execution with an extendible event loop, which can be controlled
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

v10:
    - Remove internal wrapper struct around loop params for now
    - Improve nr_wait checks
    - Kill selftests

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

Pavel Begunkov (4):
  io_uring: introduce callback driven main loop
  io_uring/bpf-ops: implement loop_step with BPF struct_ops
  io_uring/bpf-ops: add kfunc helpers
  io_uring/bpf-ops: implement bpf ops registration

 include/linux/io_uring_types.h |  10 ++
 io_uring/Kconfig               |   5 +
 io_uring/Makefile              |   3 +-
 io_uring/bpf-ops.c             | 270 +++++++++++++++++++++++++++++++++
 io_uring/bpf-ops.h             |  28 ++++
 io_uring/io_uring.c            |  13 ++
 io_uring/loop.c                |  91 +++++++++++
 io_uring/loop.h                |  27 ++++
 io_uring/wait.h                |   1 +
 9 files changed, 447 insertions(+), 1 deletion(-)
 create mode 100644 io_uring/bpf-ops.c
 create mode 100644 io_uring/bpf-ops.h
 create mode 100644 io_uring/loop.c
 create mode 100644 io_uring/loop.h

-- 
2.53.0

