Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B9F33710E
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508876; cv=none; b=oNF1hnIQTh4TE5/fyXOoA8pNdkgdrP6NjeoLYBngzSUDt+5GVRhshVhbq6M9a5kj/IIWd0f2HHpHZKP3YEf/DiN08/qZp8NmZNfqibtk2iKg1b91v1nbZ24et6P3XSSee8at3HVT3dR0EgdyyWbaCQ59143UIbu1ymi3eYiQPU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508876; c=relaxed/simple;
	bh=XWK1oThC0G1bvogR6IPv7QqDq36y7THv6q7Ut2sS4Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XSzT7cDIyLXnnz2ahWTEgPwm24l/rJAwwp10DBOIp3knW19bN2FWAa0L+IF3znEtFTwSVipLc6c0bhZZMDKOiJsJWyNovwoR5bxI5Ib/HPnbC8+NmxYJnfqwSxMpgpDG9uLq4xkpGzuhcNyYVKkFd4Vfx2VXEDkCfUS8iLzkPSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpcI1XBN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpcI1XBN"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48049955f7fso47193555e9.0
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 02:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769508873; x=1770113673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/4FvQHRBiEhUoBzRtCERgLc1sLFVyEqoxyKjPKRtz5A=;
        b=fpcI1XBNemcUWQuhNS0nozTC5nkFU41tKcu63cnLofjHQEYQPpvVXDGEi/EwUM5r+0
         OBVw5w4dmX8uXj4kYruaNcLqhe2mBRBjUsikixNKJXHpp88x4c+d3iHqHPe53win2z4Z
         iw0RrqDC/Lj+fCquFNyrH4/uiq3cPxJKqzry6HLbO7xKHVLYH+VXWvsRsPkOkL+JzkOs
         Bv5NBeyJoft49NM20GstmaShEahpuxryBMJECslA/RqdGLOQRXuxA7YZOrl/pTM+KCvD
         2bb40CAqNPDzb8wQ21g0r5xvpTIjb/fgL2z9pToB0wKFmcxGDH6r4g63XfJ4reD8hoNg
         aLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769508873; x=1770113673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4FvQHRBiEhUoBzRtCERgLc1sLFVyEqoxyKjPKRtz5A=;
        b=NP5AYUyPAhIIwzB22wlp/PnZcHbw53BSVWNxXs8AQEG2cUhB26a0AsYhhGP9bK27gJ
         hhObK+MjUD4hyEcjtiAKDAKqKlFkuWovMI9BIlSeLeRSXOFNqFRvOBai5RuhPTQEnAEq
         +hT1XF+Q9soHdFznvi6lIVvzd/xbecbUaKQF6+Wv0yI3vKN+sgLaFOY5QmvyQbng3J0n
         xGU0QTNwjckRkeuhIBs1ocpAN57GS6sy8i6iw62v9QqF/8AHmiBrcNdrBdlgvstKtD/x
         jLKOjyv7K/Z6Uni8wWj7eZGhmHSSTSVXPYFiqDMZnStsSTNogeOOD6yCioItjYetdEMR
         hmeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvEygznvh8UCl30SYM7Jd/Tk7Y9/nSTQ2Q7ixgBTrJ2AZ9XIwJec2veCPfSQEVMRs/kAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpq1HPRFxM2doxxz1QAp0a+hAc6Aq3LVXs15r9BSNavWjwU5Fr
	RG0WmxqXRSFA/Bz2OZuaGAdR34QMN5krKrIw6BWiCm734LWOZPDFyxSa
X-Gm-Gg: AZuq6aJ9PiKxFwPWfCW728YDXxgexNDCTw1wi0O8xatvynY5yFAuGFSo9wbRhURJ3KW
	5NpDCyXgkugRZlyM32tghRstZhu2KPSIsVRbblD+ecEDj41qlK8CGZXotCaG0aL9jM6/Poj1/n2
	EAZL+eSGG7iBYytte4lWjb6bUZNjA+k+5B/32i4/oOZHE5Eg7/kQ5XtfF8IYuas8yNa5viNK+Jh
	GWjvNRjzW4+TVhvPbewpRd6r0MlTDL8Vymz5XLYOUxTJQplxOponGZa7O6LIMdtPh1MJstjhgI5
	9axAA7EV9/6OBrFamAmnCZgn1YGwNE3zzh3KuC80vzawW5T9HGcEwRbn4C02SPTLmPBmevriuDS
	I5i574F6T+F+fK6QGMTEcGmTb0A+GYLLfjaq++V7FsSwozqp1WvYnaeq9j84lOj4jzGGnwK0jqc
	zYuN6kJOik0mLRxI8Z/WSdbRdl/y1ag2aCq0xlI6Q0xXZkmFI8acWFPZgw48kPWGjsi5dKmHd1U
	YkFiAsIpy2b66bcig==
X-Received: by 2002:a05:600c:3113:b0:480:1c75:407c with SMTP id 5b1f17b1804b1-48069bfaaf6mr15553245e9.2.1769508872871;
        Tue, 27 Jan 2026 02:14:32 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24acdsm38190407f8f.13.2026.01.27.02.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 02:14:32 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH v4 0/6] BPF controlled io_uring
Date: Tue, 27 Jan 2026 10:14:04 +0000
Message-ID: <cover.1769470552.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Note: I'll be targeting 7.1 as it's rc7 and it can use some
time to settle down.

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

Pavel Begunkov (6):
  io_uring: introduce callback driven main loop
  io_uring/bpf-ops: add basic bpf struct_ops boilerplate
  io_uring/bpf-ops: add loop_step struct_ops callback
  io_uring/bpf-ops: add kfunc helpers
  io_uring/bpf-ops: add bpf struct ops registration
  selftests/io_uring: add a bpf io_uring selftest

 include/linux/io_uring_types.h               |  10 +
 io_uring/Kconfig                             |   5 +
 io_uring/Makefile                            |   3 +-
 io_uring/bpf-ops.c                           | 265 +++++++++++++++++++
 io_uring/bpf-ops.h                           |  28 ++
 io_uring/io_uring.c                          |   8 +
 io_uring/loop.c                              |  88 ++++++
 io_uring/loop.h                              |  27 ++
 tools/testing/selftests/Makefile             |   3 +-
 tools/testing/selftests/io_uring/Makefile    | 143 ++++++++++
 tools/testing/selftests/io_uring/basic.bpf.c | 116 ++++++++
 tools/testing/selftests/io_uring/common.h    |   6 +
 tools/testing/selftests/io_uring/runner.c    | 107 ++++++++
 tools/testing/selftests/io_uring/types.bpf.h | 131 +++++++++
 14 files changed, 938 insertions(+), 2 deletions(-)
 create mode 100644 io_uring/bpf-ops.c
 create mode 100644 io_uring/bpf-ops.h
 create mode 100644 io_uring/loop.c
 create mode 100644 io_uring/loop.h
 create mode 100644 tools/testing/selftests/io_uring/Makefile
 create mode 100644 tools/testing/selftests/io_uring/basic.bpf.c
 create mode 100644 tools/testing/selftests/io_uring/common.h
 create mode 100644 tools/testing/selftests/io_uring/runner.c
 create mode 100644 tools/testing/selftests/io_uring/types.bpf.h

-- 
2.52.0

