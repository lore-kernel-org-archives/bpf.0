Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30AF32F77B
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771328035; cv=none; b=k5nJhOM/PoxAM3GhISfzVY/sGvvzNI6BL5EXfHGdoEWIQNUz9Y5maHpUkmj0bc0VIk8Cf7xEoVSK8fkZc1Wh/WhqdcE4UkBsL1yDSK7sU22N3U7fP6H/iur1JJBJoMxrb+WcOO5AkyUhbZ8C+B92oM6bYjTLOHxS+uf2DpRjhbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771328035; c=relaxed/simple;
	bh=wiqdQ0ogaikcpeYwtbNhgAlqC/mCmQjgsPHBNeJSXJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZT8Hpj52xpQD1PefWitxfrniaTtwVcl6pzHU3+STgTFq/M+3WRhzM28NmB3octCxbnaOc9InCz8rerxezce+AEX53TBm5yhWEVMryubvNo2mpfxbaSlEcFW4tUAibeZY/FUKJfdSCTly0usFMvmh9aK10GEJGpCdtR9WJXDxoh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1c34s+D; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1c34s+D"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-436263e31abso3965911f8f.1
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 03:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771328032; x=1771932832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R8Mjb2R5Fd9ejWzlBsoinpx5pR33b5ClXjbaNGQz1SI=;
        b=Z1c34s+DEzYqfz+wig5mUUysrxxkeh8mqRbmcprMS51+8ku94GIqrCrponvDSscvYZ
         67SUYGxUdz0QJkOmi7KDI2U5ZbqdUpd6o+HUdRmeSFu2HbApyXprb4fc6OSF3ThcTNux
         eW0lmNYd7ck/4glNuL4ORPkLRNmQxwPPVMkUVkZKkS2+SMQ32Ni52nsi8zhYJVHv86x1
         HQY5TvYiwiizEIIcSV5NHlnpnczoj2FJ1f+NGIvto4gAtp/qOYpNbZhP/AuCzdoELxnA
         dT1huUY6tYg6uyB5XviQDDpuaBPyVOh/7UOvHk+yqcDE2gqlE31u7evxYfElKL5wcebk
         M+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771328032; x=1771932832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8Mjb2R5Fd9ejWzlBsoinpx5pR33b5ClXjbaNGQz1SI=;
        b=pO29r+9h7h7WYPuS0gEVeH1zi+aR2BF/cFuLJHQg8o1BxnZQMWzHEmGGHp+td3A2M/
         6mMmiqlGEHEInksIOKa4P/FuRkc8kgE7xcIWzXj3v2pTqgJ4XAtYg20MifsZhnjuO9ZT
         S5jt+jOKb++tPoH0pqCyyHN8tAGlVldm754w6PYKZO5TaA6ortIOnFgEh5IVDgnl/Ol7
         g173iV5njqjBPL/wumhCZUk51OUY1+cOUe/bj8aUNe26sGivoCQ+CyojNqmAwdNo0cmR
         fXfTrLhvDxUQmQfm5RNAyRZmQEyQAcfFU6P8mjfI88NJ12XvVNrHZWcMcMZVYr3k8L4J
         UsIg==
X-Forwarded-Encrypted: i=1; AJvYcCUY8wqbanM0fH2ivMD9mBZ3iYk2r8vCK3CDHyS75wyK6ojjjLMVZktnqShp4PLV8WZ3NpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmoqzm9CsnTJhoearOLryNYn9l2IcH9hlYzh6XeVauwikvXsRs
	T3oyg72VbvEk2WHnVj8qD1R6ygsja7J/9BIUjl7q0pFlJfHP22O9h41EfdYVoQ==
X-Gm-Gg: AZuq6aLhfvEfQyAHxbKO6Kl1Y7ZTi/0wCPMMr5ExRhsHGjAHXGkDgLr88pThfv+huZA
	AVRT5E+hPR7CrqV8GmiqaeJfgvnt42HhqaZpaw5g+i77ocK4rqRpU0FzA0XdqL8zlPxDJJWwXgv
	i+hoGt8lsTEINto8paY7p8FFBO///p0QOLMnIYugeEb9wYy0isJrhw18UiD06wk3ro/Btpc4sOP
	zrYzrlzhRMDb1VgaUJKymBlmh3rw0A9RiEotxrCSY49bM/0KRRrD7LT8cVXxvNHaTUBR/MbmfDv
	oxgJUOFIl1ZlRPsxtFk4a7vk8XdgJW44rpOloiPuGJvVQ/WqiTxKQWTA4H+LudPBVnALf0FM+7i
	8SNZGGRZ1UT1SpvwoJOKlXCvTuK+xtgPzEAhJUd52N5GeyVCo82nBNRUcoG9bUlJY+sSLAU110X
	UkGXJkpcr9Tv/OdaDAvuajmg6n9asafje3IdmYJGzFbM0f+5DGRx1vqdvhaTE2iP4DMMtKJNTM9
	jLC33D/EWeErGZ+AUCRjnBQgk6SmA==
X-Received: by 2002:a05:6000:2881:b0:435:8aa0:a30c with SMTP id ffacd0b85a97d-4379791bbaemr26608747f8f.48.1771328031988;
        Tue, 17 Feb 2026 03:33:51 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac800esm36258343f8f.27.2026.02.17.03.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 03:33:51 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v8 0/5] BPF controlled io_uring
Date: Tue, 17 Feb 2026 11:33:42 +0000
Message-ID: <cover.1771327059.git.asml.silence@gmail.com>
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

Pavel Begunkov (5):
  io_uring: introduce callback driven main loop
  io_uring/bpf-ops: implement loop_step with BPF struct_ops
  io_uring/bpf-ops: add kfunc helpers
  io_uring/bpf-ops: implement bpf ops registration
  selftests/io_uring: add a bpf io_uring selftest

 include/linux/io_uring_types.h                |  10 +
 io_uring/Kconfig                              |   5 +
 io_uring/Makefile                             |   3 +-
 io_uring/bpf-ops.c                            | 271 ++++++++++++++++++
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
 .../testing/selftests/io_uring/overflow.bpf.c |  51 ++++
 tools/testing/selftests/io_uring/overflow.c   |  82 ++++++
 tools/testing/selftests/io_uring/unreg.bpf.c  |  27 ++
 tools/testing/selftests/io_uring/unreg.c      | 113 ++++++++
 18 files changed, 1139 insertions(+), 2 deletions(-)
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

