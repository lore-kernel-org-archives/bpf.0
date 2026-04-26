Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DF036167F
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777230181; cv=none; b=Ku3Jef3mWxYAGENR/MIM+SAhseKTmWh/6IhNHEGnhI7f783xzl5+5mMrDL3JJquffFmRQvzXqDo8lJAZzlg+F+OqIn3nZqyVMHcrD04UYk0rKIjpdBkMun64CFBfZf4iOak5GX3Nx8N/9LSxCvlWhkTI8xVvi4g9gwiRqy7r5EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777230181; c=relaxed/simple;
	bh=1OdLl1p8VC7JIciLrqWAmD6o3bi1dNJg509424CvhhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nn8zMCzj1CPbUr0GS49RjdA3Fu2PRvyDHO7ocLqKaT17nAGEpaGK7PNQnY7hqNp4pEITtXRxtwvQd6/BMNDnff7J1UKOjwX+Vishu+uyxs/2TCdPhy5FA9OFwLXWe3Ni6QOcJXzmvShyMD+BXk1J6Uea4qyb+q0W0jfMJ4tJ1DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=0ufnJVYo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="0ufnJVYo"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b7adb38d65so33089185ad.2
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 12:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1777230174; x=1777834974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CjcoZRLiko4Hmx1ERKmB3pcEKAVC5GsgCnIFP5QzfEA=;
        b=0ufnJVYoVRvJK6E553sESbgKheCXDrVgLkH2ZEFoRFPZyoO3EMYRRtbPbARXXiis/8
         k0rsmn5a2sXUUy5tDZ0OGzHcHhma7GixUGZIT9Tu0pik3NTwuLaPpmm1DSLOGDvLxeSJ
         MVlCEy8ZO+Jq1ltG4jjSo9GXlGGpSnHIzyXDmcEFHu8jUmJAbmRkQlXw/I/XvIl+uYGn
         QkwBfu/0JX4a/zBknW+JvC1DL4n3nCmh0q8mQCeUmyGMw1/YkA5NOHl3CQDYvUtkd8Gs
         REhJfGHThWdG2luTNQ7w5x6nNkD0qcaMsBWRXhnOqnBtpfiTdwyTx98hDFfS6c9yeOdZ
         S5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777230174; x=1777834974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjcoZRLiko4Hmx1ERKmB3pcEKAVC5GsgCnIFP5QzfEA=;
        b=VRUuOX7mweTtq/RvKwjh2mcxqkfP/3HOWxEuBNNYEDSdsayp4D65u6LDZOPIgPLygB
         xoWStMXcJNJ/orFR2as6a7gx8E/E0+uqak3Iy/IRcUr3u3AszEV1Vrs9B6gvp+OpNToU
         jCufsG8/buvLEFpENe8RwuTXjWzjUatHg+D/JG3JwEbqKyUp343iZXWrHkVuNBX+9VKI
         B0iUZIyFNOnLV7R72KxfQZUExXkvp7aT/KOlpygkS8ia+NRBfHAGwr92zMOrC47ooQiT
         l+LAMxpzRAwXABVFaMqhxAhcXwFcjbsTV5QUgpHLBLN4j7LaCM7L7mON4wfljuEG99gI
         xsBw==
X-Gm-Message-State: AOJu0Ywx35108nZ9Ofad0nJW/JAI3Q3eVVF0s5279bX1tPu4aW51xomb
	rNx75hQOVOVQN5/k1f97tZxscJjEPunv9evRElcCPed8bsbJAnNNKWE/YG13lq5JKcGC7sUlbUL
	AD6hh87U=
X-Gm-Gg: AeBDiesTFKA/7Z1RuVSFk6GWR+VSX9cp6MRv/q30WScoEd4sSTQjmiKb1atA+aVJJjj
	9pwYoN9sEBIEj4LLw2Pyiym78rb9aUgWpyEhgO7axDfLwhVqegF2+w2DUeHmUxlwRss2qugFbjZ
	FXc/6kgMIJmG1wNrFW/DeqZV27FrYubSbaUJBkWHGA8mM80Dg/SB7//hJOzHjezJpEhqqJxpREp
	KTTLVjQqNuNWoqtfAPqM2Q0J+poaCo56pzcQY6+bC/cH7elwv7IHgPGIviPazJTGZoIdOSi7Cze
	gvA4tSL5/vkUWBuQE7sfJlscuAVvRs8E21iTIDBXqcMyXXdTjiU/jvSpCz0Y8B/pSSmcR+vp8o/
	9Z0BRQfd98CWVbM8Idvy73nDO7qZTjp/p4IEyOuey5cGy9OG1fnRBJDqQdEaBOZ+rEECx0W+ZPj
	Rs0+5Iilk79N4A
X-Received: by 2002:a17:903:3c67:b0:2ae:8272:deb0 with SMTP id d9443c01a7336-2b5f9ebd04amr418811935ad.15.1777230174207;
        Sun, 26 Apr 2026 12:02:54 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::2af6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0caf1sm298935875ad.42.2026.04.26.12.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 12:02:53 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	mattbobfrowski@google.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v9 0/8] Introduce arena library and runtime
Date: Sun, 26 Apr 2026 15:02:43 -0400
Message-ID: <20260426190251.4456-1-emil@etsalapatis.com>
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

1-3: Create basic libarena scaffolding and refactor existing headers.

4-5: Add the ASAN runtime and associated scaffolding.

6-8: Add the new buddy memory allocator along with selftests.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

HISTORY
=======

v8->v9 (https://lore.kernel.org/bpf/20260421165037.4736-1-emil@etsalapatis.com)
- Added Matt's Acked-by for Patch 1
- Replaced open coded fls with __builtin based calculation (Matt)
- Add comment explaining the reasoning behind the zero variable (Matt)
- Remove the self-contained runner and present selftests as examples (Kumar).
  The reasoning is that including selftests with the library is not
  effective because the library will be sync'ed outside the tree
  infrequently, so it would be ineffective in catching issues before
  they land.
- Adjust syscall API for clarity and forward compatibility (Matt)
- Reset asan_validate state after failed check (Sashiko)
- Fix printf format specifier (Sashiko)
- Rename syscall to be generic arena_info (Matt)
- Namespace libarena headers by moving them to their own directory
- Rename selftest_helpers to libarena/userspace.h to reflect it is not
  just for selftests.

v7->v8 (https://lore.kernel.org/bpf/20260412174546.18684-1-emil@etsalapatis.com)
- Duplicate READ_ONCE/WRITE_ONCE instead of moving it to
  bpf_experimental.h to keep libarena self-contained (Kumar)
- Add libarena_asan test to test_progs and conditionally compile it if
  suppported (Kumar)
- Add stderr parsing for buddy tests when run under test_progs (Kumar)
- Move all arena-related headers into libarena and add its include/
  subdirectory in the standard include path (Kumar)
- Remove silent-by-default ASAN, add help message on test_libarena
  explaining that -v emits the messages (Kumar)
- Add run_prog_args as a libarena helper
- Add explanation on the use of __weak for the spinlock qnodes

v6->v7 (https://lore.kernel.org/bpf/20260412011857.3387-1-emil@etsalapatis.com)
- Modify patch 1 to allow operations between PTR_TO_ARENA src_reg
and dst_reg of any type. Adjust selftests accordingly (Alexei)
- Remove unnecessary include in patch 5 (Song)
- Removed unused definitions/assignments in patches 8/9, update patch
  descriptions

v5->v6 (https://lore.kernel.org/bpf/20260410163041.8063-1-emil@etsalapatis.com)
- Fix subreg_def management for SCALAR += PTR_TO_ARENA operations (AI)
- Add more selftests for the SCALAR += PTR_TO_ARENA patch (Sashiko)
- Adjust fls() operation to be in line with the kernel version (Sashiko)
- Address Sashiko selftests and debugging nits
- Add ASAN loadN and storeN _noabort variants and associated BTF anchor
- Remove unnecessary bit freeing of buddies during block splitting

v4->v5 (https://lore.kernel.org/bpf/20260407045730.13359-1-emil@etsalapatis.com)
Omitting various nits and fixups.
- Properly adjust subreg_def for scalar += ptr_to_arena calls (Sashiko)
- Remove extraneous definition from prog_tests/arena_spin_lock.c (Song)
- Trim extraneous comments from ASAN and buddy (Alexei)
- Remove asan_dummy call and replace with function pointer array (Alexei)
- Remove usersapi.h header and merge it into common.h (Alexei)
- Replace ASAN macros with function calls (Alexei)
- Embed buddy lock into the struct and move the buddy allocator to __arena_global
  (Alexei)
- Add commenting for buddy allocator constants (Alexei)
- Add default buddy allocator directly in common.bpf.c, so that the user does
  not need to define it.
- Expand test harnesses to dynamically find individual selftests. Now the
  selftests also reports each test individually (e.g., 5 entries for the
  buddy allocator instead of 1). This brings them to par with the rest of
  the test_progs.

v3->v4 (https://lore.kernel.org/bpf/20260403042720.18862-1-emil@etsalapatis.com)
- Add Acks by Song to patches 1-4.
- Expand the verifier's handling of scalar/arena operations to
  include all 3-operand operations in Patch 1 (Alexei)
- Add additional tests for arena/arena (allowed) and arena/pointer (not allowed)
operations in Patch 2
- Remove ASAN version of the library from default compilation since it requires
LLVM 22 and up (CI)
- Rework buddy allocator locking for clarity and add comments
- Fix From: email to be consistent with SOB
- Address (most) Sashiko comments

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



Emil Tsalapatis (8):
  selftests/bpf: Add ifdef guard for WRITE_ONCE macro in bpf_atomic.h
  selftests/bpf: Add basic libarena scaffolding
  selftests/bpf: Move arena-related headers into libarena
  selftests/bpf: Add arena ASAN runtime to libarena
  selftests/bpf: Add ASAN support for libarena selftests
  selftests/bpf: Add buddy allocator for libarena
  selftests/bpf: Add selftests for libarena buddy allocator
  selftests/bpf: Reuse stderr parsing for libarena ASAN tests

 tools/testing/selftests/bpf/Makefile          |  53 +-
 tools/testing/selftests/bpf/bpf_arena_alloc.h |   2 +-
 tools/testing/selftests/bpf/bpf_arena_list.h  |   2 +-
 .../selftests/bpf/bpf_arena_strsearch.h       |   2 +-
 .../testing/selftests/bpf/bpf_experimental.h  |  84 +-
 tools/testing/selftests/bpf/default.profraw   | Bin 0 -> 160 bytes
 tools/testing/selftests/bpf/libarena/Makefile |  94 ++
 .../{ => libarena/include}/bpf_arena_common.h |   0
 .../include}/bpf_arena_spin_lock.h            |  11 +-
 .../bpf/{ => libarena/include}/bpf_atomic.h   |   4 +-
 .../bpf/libarena/include/bpf_may_goto.h       |  84 ++
 .../bpf/libarena/include/libarena/asan.h      | 103 ++
 .../bpf/libarena/include/libarena/buddy.h     |  92 ++
 .../bpf/libarena/include/libarena/common.h    |  94 ++
 .../bpf/libarena/include/libarena/userspace.h | 132 +++
 .../libarena/selftests/st_asan_buddy.bpf.c    | 258 +++++
 .../bpf/libarena/selftests/st_asan_common.h   |  52 +
 .../bpf/libarena/selftests/st_buddy.bpf.c     | 209 ++++
 .../libarena/selftests/test_progs_compat.h    |  15 +
 .../selftests/bpf/libarena/src/asan.bpf.c     | 553 +++++++++++
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 903 ++++++++++++++++++
 .../selftests/bpf/libarena/src/common.bpf.c   |  52 +
 .../bpf/prog_tests/arena_spin_lock.c          |   7 -
 .../selftests/bpf/prog_tests/libarena.c       |  66 ++
 .../selftests/bpf/prog_tests/libarena_asan.c  |  93 ++
 .../selftests/bpf/progs/arena_atomics.c       |   2 +-
 .../selftests/bpf/progs/arena_spin_lock.c     |   2 +-
 .../bpf/progs/compute_live_registers.c        |   2 +-
 .../selftests/bpf/progs/lpm_trie_bench.c      |   2 +-
 tools/testing/selftests/bpf/progs/stream.c    |   2 +-
 .../selftests/bpf/progs/verifier_arena.c      |   2 +-
 .../bpf/progs/verifier_arena_globals1.c       |   2 +-
 .../bpf/progs/verifier_arena_globals2.c       |   2 +-
 .../bpf/progs/verifier_arena_large.c          |   2 +-
 .../selftests/bpf/progs/verifier_ldsx.c       |   2 +-
 tools/testing/selftests/bpf/test_loader.c     |  51 +-
 tools/testing/selftests/bpf/test_progs.h      |   2 +
 37 files changed, 2917 insertions(+), 121 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/default.profraw
 create mode 100644 tools/testing/selftests/bpf/libarena/Makefile
 rename tools/testing/selftests/bpf/{ => libarena/include}/bpf_arena_common.h (100%)
 rename tools/testing/selftests/bpf/{progs => libarena/include}/bpf_arena_spin_lock.h (98%)
 rename tools/testing/selftests/bpf/{ => libarena/include}/bpf_atomic.h (98%)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/bpf_may_goto.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/asan.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/common.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/userspace.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_progs_compat.h
 create mode 100644 tools/testing/selftests/bpf/libarena/src/asan.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/common.bpf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libarena.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libarena_asan.c

-- 
2.53.0

