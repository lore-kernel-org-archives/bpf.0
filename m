Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0793EBF35
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 19:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770836699; cv=none; b=FHk6xYWyrSi1QDt92kPHhmIdO2BEQldgB9g+s8b6gfQX/1zm1AXVIYxt+t6sZqi6WvR0aBlS2KLd6jW9UlTCECTfbMVxlsCCj0Dh4vklnS5aTpZ/ldif8m9HVjeiGiGWQ5pHDn8rvEb0VJyMzrCdmUrieDTf3jWGYRSP1Pn+sDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770836699; c=relaxed/simple;
	bh=SU+ZkV7tEKyOIWdqLooOmnyTOabBy1/MLq3hqu/wI1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dq/399X5AUo/jnW/ZF48AiF6U9NnHoIcGP6RItvH14Rl060CRLwLX6Ss0vh9NH6Llp5qi5xfdWFAR4+AixXIV3LVeWqUPEGjB2wEfCkhonwHCUWH4HPTcwX6SV82aE6UfGEph2/n9RpFUJ7mj7cQlqCNOb3rKISNLSnC4x4l86Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9IXtwW9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9IXtwW9"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so13201555e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 11:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770836696; x=1771441496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d59SANFE3hpm6oFn6wRf+OdKFNjjGShou9odejSdtso=;
        b=e9IXtwW9da7C/KjDtUQ5o0q7IskvgCkHNO8oM8umqL+dKrgZdclQ6QscHR3JXACLf+
         vgruSyjWHD8DGClw28HjmhOLil93YkilCDvpRXDQ/ZSMVJyxinYawSIiLZyzY/4hP5q2
         ymrhuEHX3YZwhJThJO1Y1TQlQIOy0/vwqmatuUjeR/Tft2RuLh7kHk/KzcqEgCMO9Sbn
         xPx6wojAFcN6ZfSwtGfECVpB7LI25ZzQhpQ8TGCtUnnwcD5WcOIzQcfgB00UFthUlgLU
         kbxAEMf6hfTDqIwcYXLVRSwUSOe20HmV9O/HAkse8tOrzhLSO/v8mUVp7bRCVtAW6Vao
         7Xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770836696; x=1771441496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d59SANFE3hpm6oFn6wRf+OdKFNjjGShou9odejSdtso=;
        b=iiTdBvZfbzQyODTfmMfqMuH4oLqtG8AZN1HIR5hNFS9JTqHSvLKtM5Jij9FEt5lamR
         6B9bYgpPBxrp5ats7x5R5VGTYqgJV6h+ldWuFDFTVyRmW7f4emVEcEcj2xBPvo2VmIki
         cvBqXFQwlK8DMuDMewmlKaEgsqrIbDcvKjP/nC8qemBzeJKleZzdj6k4fZBJO///YEwT
         oyQKG8RTwHu4KjICZg7CQ+MPIywioypxxsvgTuOoAQSoodbnh75wv3zqYBtUJOJOm3xo
         sOxXDPbRcdt7QkFC+anhlnozlbDY6Bd/RjMpvhfVwHhAytI/7BSf03uEeHoy2kT5jBv+
         zpfg==
X-Forwarded-Encrypted: i=1; AJvYcCUTCB5PKQ+4cWWYmNslLdPcQf0Yoz+HnTy7dnudeN6Xj8Zr2g8+l4jwO9GEQ/q4NMVjXF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGS+uYLTRs0eaytnWBJzetvwQ10d+f84sax/zKxVVS4y0Hw5wW
	sTg1dhMY4TTlU5+JGqU7KP+quGeHCalyswwIzMDMJKlHV4pKfG5ULb5A
X-Gm-Gg: AZuq6aIe16hqfzx1V8lr1iU19pLqbVBP3p1KogBKW/cwcRSOZ8XDfQ52x1enrJ4xT/Z
	6jYMDd1JmxrBtESpKTjmF58wg75IVvQSPnOXwXnTM14le7LT2pwi7M/zUXodu2fp7ZgBhOaEiP1
	Gj7PBIqdML3a58EBYXHZiQOQSckbMHKSOAm1YFHyOS9+QYZVKoq1N0QJ+BxcKo8x6gpASaxgVbC
	rrA91+PF8ChdRQz/st+GAdRK0eEaNQyKF+Foq6e25QxGbJbAZg09CgTDomoOQ7PEPh7rcFC7fig
	Sn+9j9Zj51QnbCVECEB+eDRaQZQ5Bpbdvvh2LcowkFSdIT9iwWcK3XnfZg92ILRP9FNbrDBQ21C
	5F++Udqy78I3s7yeAwK+voxWMafP0ATMhJycASKDMr3MbPztbet0iZta+N/X4L6D+TCkO2WuHdL
	y3khF5BDicCiAPT7fM0yX+TG6l1lqhNC5DX0jkKVwJAyOC2NGs8VPp85gfFpluht1TT6kjS3FbF
	K6yUcZJodiVCh3xvBoNvKefTNw5QQ==
X-Received: by 2002:a05:600c:c176:b0:481:a662:b3f3 with SMTP id 5b1f17b1804b1-48364fe0814mr6901115e9.7.1770836696485;
        Wed, 11 Feb 2026 11:04:56 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783dfc8b9sm6174169f8f.24.2026.02.11.11.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 11:04:55 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH io_uring-7.1 v6 0/5] BPF controlled io_uring
Date: Wed, 11 Feb 2026 19:04:51 +0000
Message-ID: <cover.1770836401.git.asml.silence@gmail.com>
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
 io_uring/io_uring.c                           |   8 +
 io_uring/loop.c                               |  97 +++++++
 io_uring/loop.h                               |  27 ++
 tools/testing/selftests/Makefile              |   3 +-
 tools/testing/selftests/io_uring/Makefile     | 162 +++++++++++
 tools/testing/selftests/io_uring/common.h     |   7 +
 .../selftests/io_uring/nops_loop.bpf.c        | 131 +++++++++
 tools/testing/selftests/io_uring/nops_loop.c  | 110 +++++++
 tools/testing/selftests/io_uring/unreg.bpf.c  |  26 ++
 tools/testing/selftests/io_uring/unreg.c      | 113 ++++++++
 15 files changed, 1000 insertions(+), 2 deletions(-)
 create mode 100644 io_uring/bpf-ops.c
 create mode 100644 io_uring/bpf-ops.h
 create mode 100644 io_uring/loop.c
 create mode 100644 io_uring/loop.h
 create mode 100644 tools/testing/selftests/io_uring/Makefile
 create mode 100644 tools/testing/selftests/io_uring/common.h
 create mode 100644 tools/testing/selftests/io_uring/nops_loop.bpf.c
 create mode 100644 tools/testing/selftests/io_uring/nops_loop.c
 create mode 100644 tools/testing/selftests/io_uring/unreg.bpf.c
 create mode 100644 tools/testing/selftests/io_uring/unreg.c

-- 
2.52.0

