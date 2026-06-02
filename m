Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1601E224FA
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 00:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780360887; cv=none; b=ZkDxAmNVQygKzszuj+0mq4R+5DlgIJJiuIVdSc4Iq0rwAv6Fc8pw40Rdregop0LKdMlF48M/9O0YwjLvGAysTLdAHbFnB3oSwPtSBuoNIgqNrV5HBSsiqBzG6shtnXOEG9Awgf4gjCKUHY8vPNnrGl9/01qqixnN5VRgZUEEOoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780360887; c=relaxed/simple;
	bh=muWSf4o0IeqxPaNpjOjIgXABgnEE7IoB6iVQ/uUHVeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ihcSfCTSjQL2ROUO3zYdVz8+P1REJrA75gQoHC3Glc6bWjUX9SXGR0MnDB40cAcgw+Nwaw5eqchljfqTlfOJv/3cVnBwEbzJeGU1bkD9f20rGehae7FyRwBS4dT+D5XBY43DjiK83eu33iCJhePtl6XAdtAmUs0gZq3RZP3oWAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=exOoKd1/; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="exOoKd1/"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-304c520fe9aso11678565eec.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 17:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780360885; x=1780965685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c7NjKiivuazeTqpV34hOkrg6hHFBlYDrtgsZ9D9CcI0=;
        b=exOoKd1/ydlSZFVh4cRS8gZutTdaQ9Ugtda4MLtnUhmGTvBrs94wwT6Pz8S4jm33k2
         jho2EwzJI7S5o05UxdmFD2WldhTcCB7OwKkuQYM0n7B8qR48CazeEqLHIL5tjluwEYQF
         I0/kUthcTFsNW/c/pWgI4eS2WRdh9rji8894u7v9c0hwZiWDgpxgWygWi2MDfH3vXwxm
         KMhz4O5sqBckAvtMuwD3LibdlK3JP9CyKo/HaDn8PWauOyRq8zPO/pguMcEFcoLslW1W
         KCgDrfPHe8Zl5sabsBbB/2dy/Nv/ebTfl0OvXhAqc4s3Z4L339Sacj7XxjVxQe9+RDUT
         489A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780360885; x=1780965685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7NjKiivuazeTqpV34hOkrg6hHFBlYDrtgsZ9D9CcI0=;
        b=H6/9+qtvB/ENA4sqxYyMV5QWXVnWizvGJXcUQ7+2mlCI9D4Igq2IoUB9g9VtiIYGmZ
         tt7FvrM4oqTbUOcFUZRLqLeldXCTavjm7gAC+jNypw/QldPXCUeoDGE0KOTX8Ai8Te1Z
         tH6qk4u77naKv50B/6VOjVrIkzNcX5Of+LEun67iK4YghII2u7aqYhOhFfwDVpnjkVs0
         l23x6huQ7Tsgj5BtGWYm8y0Eq2YmT+sEWHjnydqS4iW1AvhoqQ8LBREb6XrhJttqjkBx
         S8O1Ow3xwS7B70Urg3GECHOa+sg7IwGk6mhlCcxPXXExyHVlAfucqszhlyt2ZfcE2/q2
         /QEQ==
X-Gm-Message-State: AOJu0YyQOs8INGpGMeMHZe87EbYp+T4Br15/DFhra8ZS89DsbHOwTuj+
	YSKQQtEREJ4h2HfzRSy5tiOulL1aDlOsj0RkXrCHowD6/2Eqbu50CW2yk4RVWZ2bv7JTiWnuHbX
	UsaFE0uEun4dqc5I=
X-Gm-Gg: Acq92OGGcDz3tkMKZW/B4oOzDESkJRpH3PiteGUd5lRkRdh29P5R2YkgCWQY8YjNg92
	tdmA4Pt3lEggeEcQeyEUGkZLA366XaA/r440/031OSh6blBmIGazIuoikHa0XnHu+GiV+6ajK1M
	qhRwopi8euITVwZv+NCXY1H2sMXen+Mgp/IiRPQCNIzdiQl3EzSc9DTDCYkFb6VvVqYNX6GySQ2
	pwxWz3BVCGrQ6uLeFX8lM20pyvNVj3OmKLwLTTBsG49b+8lQGq1ZUanGVpn8/EwEHgN6PEDskPu
	WvR1/Nazf+1ywt3hiobP8ifRX/p9pQgYjv2JFsIsUyducxYeR3htjt7w7idYSX8Sbnm1XJwXjdK
	55KF/1yVPRtSul43u4i2TE2H/sFJMURjIFPdoElg+B0ouIoHO9s5iOHyEXamWLx4JhhEyUNl1cR
	BGt7J5Gc6AhOm8hJ8AcXR7qwkVaMo5NzpZ4x+F7Gjr
X-Received: by 2002:a05:7300:72cc:b0:304:9b48:53d0 with SMTP id 5a478bee46e88-304fa4c81ebmr6831262eec.12.1780360885065;
        Mon, 01 Jun 2026 17:41:25 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::4f12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5d5385sm10172018eec.28.2026.06.01.17.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 17:41:24 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	mattbobrowski@google.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 0/6] Minimize annotations for arena programs
Date: Mon,  1 Jun 2026 20:41:14 -0400
Message-ID: <20260602004120.17087-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF programs must currently include code to address two limitations
of function signatures that include arena types. First, arena arguments
must be annotated with __arg_arena in the function signature in addition
to __arena. Second, it is currently not allowed to return an arena pointer
from a subprog, even though it is safe to do so. These limitations require
extra annotations and typecasts respectively, and have proven sources of
confusion to programmers.

The patchset improves arena-related function signatures in two ways.
First, it removes the need for __arg_arena in function signatures.
Second, it allows subprogs to directly return arena pointers to their
caller.

To do this we add a new type tag to the existing __arena annotation.
The annotation is currently an alias for __attribute__((address_space(1))),
which is not discoverable from BTF alone and so cannot be used to
determine whether a pointer variable is an arena pointer during
verification. With the new type tag, we can determine whether
either the arguments and or the return value of a function belong
in an arena.

We test the new code by modifying libarena to take advantage of these
relaxed limitations.

CHANGELOG
=========

v2 -> v3 (https://lore.kernel.org/bpf/20260530002259.4505-1-emil@etsalapatis.com/)

- Added Acks by Eduard
- Complete the __arg_arena removal by removing them from htab (Alexei)
- Add a test in verifier_arena_globals1.c to confirm the new __arena attribute
works as expected in function argument and return types
- Reject type tags on non-pointer types, currently only possible in handcrafted
  BTF (Eduard)
- Undo inaccurate change on verifier comment (AI)
- Fix error return value for invalid BTF return types during BTF parsing (Eduard)

v1 -> v2 (lore.kernel.org/bpf/20260527071457.4598-1-emil@etsalapatis.com/)

- Rebased to fix conflict
- Removed the typedef foo * foo_t typedefs. Those were necessary to avoid
annotating each instance of the type with __arena. The new version of the
patch instead removes typedefs and uses __arena everywhere directly (see
patch 4/5 for more details).
- Reorganized the patchset to frontload all kernel-side changes and place
the libarena changes at the end.

Emil Tsalapatis (6):
  selftests/bpf: libarena: Add "arena" BTF type tag to __arena qualifier
  verifier: parse BTF type tags for function arguments
  bpf: Allow subprogs to return arena pointers
  selftests/bpf: Remove __arg_arena from the codebase
  selftests/bpf: libarena: Directly return arena pointers from functions
  selftests/bpf: Add tests for the new type-tag based __arena identifier

 kernel/bpf/btf.c                              | 178 +++++++++++++-----
 kernel/bpf/verifier.c                         |   4 +
 tools/testing/selftests/bpf/bpf_arena_htab.h  |  11 +-
 .../selftests/bpf/bpf_arena_strsearch.h       |   4 +-
 .../bpf/libarena/include/bpf_arena_common.h   |   5 +-
 .../libarena/include/bpf_arena_spin_lock.h    |   6 +-
 .../bpf/libarena/include/libarena/asan.h      |   6 +-
 .../bpf/libarena/include/libarena/buddy.h     |  23 +--
 .../bpf/libarena/include/libarena/common.h    |   3 +-
 .../libarena/selftests/st_asan_buddy.bpf.c    |   4 +-
 .../bpf/libarena/selftests/st_asan_common.h   |   2 +-
 .../bpf/libarena/selftests/st_buddy.bpf.c     |   2 +-
 .../selftests/bpf/libarena/src/asan.bpf.c     |  38 ++--
 .../selftests/bpf/libarena/src/buddy.bpf.c    |  96 +++++-----
 .../selftests/bpf/libarena/src/common.bpf.c   |  10 +-
 .../selftests/bpf/progs/arena_spin_lock.c     |   1 +
 .../selftests/bpf/progs/verifier_arena.c      |  67 +++++++
 17 files changed, 298 insertions(+), 162 deletions(-)

-- 
2.54.0

