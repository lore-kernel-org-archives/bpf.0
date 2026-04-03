Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EB31AF4D5
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 04:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775190445; cv=none; b=ip90UYvnJkli+OkViSRBFTcJ3MoQCVD0BKRU0CtIwdCxOoGh6h0ypIYaBaWAHY0ZTamzBzrTS08Y9bCFYTXVQ1mz+D73LefrEp7KnU2DOlYqa48Fl/wnNuwiFrz9SjSGFPtScR9Y1CP1ndI4fiZMCfvBT9D8Vq7EHJMu4iWBUGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775190445; c=relaxed/simple;
	bh=zP5V0zFHmgypRo3IQYxrbohVDs3iX3fvd5yKgd+Tw3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=my1t//NpGOw/zTY+37ubRNSWHCOrsDI0WXUj9gawKZ2vQF7kDhFTXMjcqPzSVtqIZeiYiuNL+jwPXICoG7H5QrTrmFol+fC6Svv/RJi0Q7Hd9RKRIdS5eUKgOgPGNd/DrG2J3Lud3spUQXbn9EghGcERCTbFe1ZZ2Msqby8hnuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=hL8R8AVl; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="hL8R8AVl"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-35c238f1063so945636a91.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 21:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775190443; x=1775795243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wLMlfgEbHlrA9efay7Ul3rLEpDZ1ral/X6M/JlrJsxk=;
        b=hL8R8AVlBseCKozdsV7j+pc9J8gkuVXGj8A2+n0etXa9KUdEVmGUwCSxochQhck5XI
         wtqVduel2UHFaS6zVmuanmXF6cTdKX+fm9p03q02fKhCjzmrHAL4TaaEAhdN0djH2q3v
         RrrZI6jwMLtSSIx/SU2OfkgxXLBrxoVMIuxO/xSz0JTLVqR8ZXVfEA5FVrBWAG4TgZR+
         4rriC1sPA7UchXspsgupgk7bh/uWU8EguZbl5fDosYyxCpL5t0lZ7LFK/tirZg/4e+LR
         ssqw5s++wL5WlX5VmAD2v8nZR6IYt/pen5gWZAbw7hJoXz+07oitM0RcixB0Yc+bdwf5
         6gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775190443; x=1775795243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLMlfgEbHlrA9efay7Ul3rLEpDZ1ral/X6M/JlrJsxk=;
        b=TeaEk1yAxg/QfOb0ahwj8iFlDvUwuK5+LRBDdEjUS69eOk5oT0kRkLEjKeM03W0SdR
         c/BaCerWUZMD1XPG5WR45LqD1jUaoNfiaitGbyHhgzRu5K7qXrR466kDORglsI0nfEG3
         O77aJ/cXLy48GwqZI+Nqor2tv8bzeCAM8a+KLaF3kxTQ0GuEWAEn7oMaj+20aejAHIrS
         9WmPBUQzdYBTjedoznIZSATSihUScNAa5cY7MRQYL+QckjjDJEglJLPMgrqhd9yo1y9I
         0szr04sarTsL3DoYerjDpQZWnpKcJnSSyX+m3cWoyvTw+RjINnFlS15lZu5HBeFg7pmB
         97LA==
X-Gm-Message-State: AOJu0YwosvDxMkwDjHsNRBR8m/R+IvhKb+IP2D4mVgL3hfOAw3SUknKo
	8CloDuyMCLY5pyMZZ5F9tA8nytpkdzngdujTA+SZTgbJQ9Gl26p2usF0smwPgXyWCF9LcY/FPQY
	IE3NDVN8y9Ytl
X-Gm-Gg: AeBDieuVcxBbeMZEWGDqq5HOkTPWk9yPK5RbYhj2Hnn5dSejvq9wctb8XcHpHYe/RiN
	8fKEdFNc+pQcd2y7T2+VgTlyvymDxtQ4ov2xRx2mECQ1F+y+FFBy14Kr80Q+QeHoaRMNG+5h2XS
	+wjMOl2GWlgqL6JmydbGZplZbl2KduISxQactG9IXF0qrX0uq7146iDXZ6ZuCZAoKfXqhf4fRy+
	yT3yyUXVyGIJtK/ux6ta3fhaze2rM7dU47JMF5nIokSqc25k7S/gpU4UBkzU5AmH2xAi5Kix1sg
	Q8eJTO2x2zdCZYhTdISLM25sWWhkFaKavVuG3GLKdDHSQ5jNNo8CPZuZEG97HizGpWSznwJVZCW
	KBLoAreuwZVWHjshrhOHMJ6ZK5XX5FMcbFZQwlxeKnSNZWZ6aC3sFahlg+PVbQhUbMTr/R9xyLy
	IQbQ==
X-Received: by 2002:a17:90b:1e04:b0:35d:a2d3:5c31 with SMTP id 98e67ed59e1d1-35de6a01c54mr1329336a91.29.1775190443002;
        Thu, 02 Apr 2026 21:27:23 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe937925sm12970449a91.12.2026.04.02.21.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 21:27:22 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 0/9] Introduce arena library and runtime
Date: Fri,  3 Apr 2026 00:27:11 -0400
Message-ID: <20260403042720.18862-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new subdirectory to tools/testing/selftests/bpf called libarena,
along with programs useful for writing arena-based BPF code. This
patchset adds the following:

1) libarena, a subdirectory where arena BPF code that is generally useful 
to BPF arena programs can be easily added and tested.

2) An ASAN runtime for BPF arena programs. BPF arenas allow for accessing 
memory after it has been freed or if it is out of bounds, making it more 
difficult to triage bugs combined to regular BPF. Use LLVM's recently added 
support for address-space based sanitization to selectively sanitize just 
the arena accesses.

3) A buddy memory allocator that can be reused by BPF programs to handle
memory allocation/deletion. The allocator uses the ASAN runtime to add 
address sanitization if requested.

The patch includes testing for the new allocators and ASAN features that
can be built from the top directory using "make libarena_test" and
"make libarena_test_asan". The generated binaries reside in libarena/.
The patch also adds test-progs-based selftests to the codebase for the
libarena code, so the new tests are run by ./test_progs.

The patchset has the following stucture:

1-2: Addresses a verification failure triggered by SCALAR += PTR_TO_ARENA
instructions.

3-4: Minor changes to selftest headers to prepare for the introduction
of libarena.

5-7: Add the libarena directory and testing scaffolding, and introduce
the ASAN runtime.

8-9: Add the new buddy memory allocator along with self-contained and
prog-tests-based selftests.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

HISTORY
=======

v2->v3 (https://lore.kernel.org/bpf/20260127181610.86376-1-emil@etsalapatis.com)
Nonexhaustive due to significant patch rework.
- Do not duplicate WRITE_ONCE macro (Mykyta, Kumar)
- Add SPDX headers (Alexei)
- Remove bump/stack allocators (Alexei)
- Integrate testing with test_progs (Kumar)
- Add short description of ASAN algorithm at the top of the file (Alexei)

v1->v2 (https://lore.kernel.org/bpf/20260122160131.2238331-1-etsal@meta.com/)

- Added missing format string argument (AI)
- Fix outdated selftests prog name check (AI)
- Fixed stack allocation check for segment creation (AI)
- Fix errors in non-ASAN bump allocator selftests (AI)
- Propagate error value from individual selftests in selftest.c
- Removed embedded metadata from bump allocator as it was needlessly
  complicating its behavior

Emil Tsalapatis (9):
  bpf: Upgrade scalar to PTR_TO_ARENA on arena pointer addition
  selftests/bpf: Add test for scalar/arena pointer addition
  selftests/bpf: Move bpf_arena_spin_lock.h to the top level
  selftests/bpf: Deduplicate WRITE_ONCE macro between headers
  selftests/bpf: Add basic libarena scaffolding
  selftests/bpf: Add arena ASAN runtime to libarena
  selftests/bpf: Add ASAN support for libarena selftests
  selftests/bpf: Add buddy allocator for libarena
  selftests/bpf: Add selftests for libarena buddy allocator

 kernel/bpf/verifier.c                         |  18 +
 tools/testing/selftests/bpf/.gitignore        |   2 +
 tools/testing/selftests/bpf/Makefile          |  31 +-
 .../testing/selftests/bpf/bpf_arena_common.h  |   4 -
 .../bpf/{progs => }/bpf_arena_spin_lock.h     |   4 +-
 tools/testing/selftests/bpf/bpf_atomic.h      |   4 -
 .../testing/selftests/bpf/bpf_experimental.h  |   3 +
 tools/testing/selftests/bpf/libarena/Makefile |  77 ++
 .../selftests/bpf/libarena/include/asan.h     | 124 +++
 .../selftests/bpf/libarena/include/buddy.h    |  64 ++
 .../selftests/bpf/libarena/include/common.h   |  50 ++
 .../bpf/libarena/include/selftest_helpers.h   | 109 +++
 .../selftests/bpf/libarena/include/userapi.h  |  27 +
 .../bpf/libarena/selftests/selftest.c         | 190 +++++
 .../bpf/libarena/selftests/selftest.h         |  12 +
 .../libarena/selftests/st_asan_buddy.bpf.c    | 251 ++++++
 .../bpf/libarena/selftests/st_asan_common.h   |  46 +
 .../bpf/libarena/selftests/st_buddy.bpf.c     | 229 +++++
 .../selftests/bpf/libarena/src/asan.bpf.c     | 524 ++++++++++++
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 783 ++++++++++++++++++
 .../selftests/bpf/libarena/src/common.bpf.c   |  66 ++
 .../selftests/bpf/prog_tests/libarena.c       |  79 ++
 .../selftests/bpf/progs/arena_spin_lock.c     |   2 +-
 .../selftests/bpf/progs/verifier_arena.c      |  29 +
 24 files changed, 2716 insertions(+), 12 deletions(-)
 rename tools/testing/selftests/bpf/{progs => }/bpf_arena_spin_lock.h (99%)
 create mode 100644 tools/testing/selftests/bpf/libarena/Makefile
 create mode 100644 tools/testing/selftests/bpf/libarena/include/asan.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/buddy.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/common.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/userapi.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/selftest.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/selftest.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/asan.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/common.bpf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libarena.c

-- 
2.53.0

