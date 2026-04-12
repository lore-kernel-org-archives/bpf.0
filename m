Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417742F12CF
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776015952; cv=none; b=Qjiw4gYMq4xKsauti43aQpzEdWLzJjRzb/X65Y2uuPgGfbWz17yQeHh9FobHg9JHADJ5WBc0yqggPkGSRfY+5OWpMjaJI73i84dPDX1wJU5F0uQ7xztSwYMDv5CWQibc8Lqu2C0j3BjRxIRhsN9xW7vKZFiBJGx3su2GjfYXVsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776015952; c=relaxed/simple;
	bh=wlzhMq9OF4v5U63IwJEIZSagMrISbIW2h8zQwRQHLK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ng6K/AOTKFgYOtBt7mB914sAxlGvGNNn84/l62oLIOzVe3+x00Qad1FPbs21gtkfhWl5sEdgMAmfNmWTF3BPshFlsY+uJrzKmP/apv8liNIcyp5y9UXidQdq8cEVoxT2X0IY3ouiwXqYZVEiC2WlE/oGAmsju0HlKryulwAgPOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=qzECqxtz; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="qzECqxtz"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-82cd70febc7so2447647b3a.2
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 10:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776015950; x=1776620750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dWC2mOXza/SkSwnCDLs+5ksMxy/vKU9jO8QO1/AHI/8=;
        b=qzECqxtzonDPct04usXbQulY5aayPhMvE6BHwKeYqlp5gGCaWAbdZarhfS1TIjyMd+
         r5/Q7vwss4vvObAFaVz1F7aMNT2CI8UEJUkW3LnJMpwzz9UEctpeYf/uIs+efwEWosY+
         O9gb276VssUzQ+6BTiSU2xzC+KwiXkOnttP3fHSxHZY2RCCmT0vpglFzjBNgV0atLdoj
         vCiH32VaE8Q85OCLyCVMT/Rw4oiGEpz1kOcuC1gJ0WcQEYaRs+q54flia/YfHXsxRjWK
         JVtqtKtON0xxR191dKqXQV1PRKEG7UR+LoGAZfPYBnVAiu5ChtrMFZAiPL4uaRsryCs9
         nrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776015950; x=1776620750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWC2mOXza/SkSwnCDLs+5ksMxy/vKU9jO8QO1/AHI/8=;
        b=Z5l5uPI5PrhRp6vavYqc+/RJKMN8V1ifTTP9s2DmE34NzW+7w+bI3bOJdMFkFgBjrQ
         ADhUpyucnK71RzPPHZasGILrJiqMakj5EqAeMDqesUx9hA0vf3QU5E1U78Hy+yW1S6Hw
         GPkMf6sgM22Hkn3at4k1tJeb6Rfns0rebRkyZe1AaY2bw/ycRxZYSr+q5Oj9tn6KCnCI
         A1IMJmHPZze5brclC/RlqY2aDZXDxlMwi4Ir4HYeQWHMjWnBBMhtgDxRS8qsXD8s2NKG
         Kqc3WXnkH6SE/NCfu0Rw2/nfduczX/qMDkDsTkxU7fnqhqYK0Hqwli+LrIRrtvGwc5tu
         PYcw==
X-Gm-Message-State: AOJu0YyBPu1N+GCDArIXLnwUwn0xlAyIXp6ZCQdP+1somiBMWTA4VKDa
	ri4tudO/Lk8TNZMbeeB9SMmRalLJuJWXMk/4eC50q4qh1nuZmUTsJq7Q0teEYQ5fXJ4NQHKb7Sn
	oErHhTtdVLg==
X-Gm-Gg: AeBDieuQCg4QvZuhUKZS8T2o+cqiGLYZ4zOQ8++MaFPFX9Vvb2CIY8VJ6RS5gBj5AS8
	nIDWLuCzZUXAwU4qAN0gQ/tfz/Wmfg64S3jM2hmaCKFEk0pnB5mqC7s78Mr+6NxsK5zv2WwXWdM
	0Z+Q152dk07RZss1HS2ng2qmdNwru0ObCsaRTbZ9ntoFJq3TVbW/GFMLnTPY/VbA8Km3ve5CzpG
	xl1jE/uEu1MRu7o7UL7i0JrPHkCRAs8SBlNjHBNixGtRE271sUumq6tE9LfcaLN1FKsYPoReptw
	8y4ASA9z0GTN/Urm1aekR+JA35pJv+ftIZIs33AqoifLBjAvlgtdehoo6jWEdW8BWz0ArvBp0Nw
	mN+SktJThee94uufkJt9Qh5ra0bHibD7CoxPaz7Rdsrdl2HQbUE8qHP5HgjjJzSBRObSjoZbEnh
	JyDw==
X-Received: by 2002:a05:6a00:7611:b0:82f:1b42:11d6 with SMTP id d2e1a72fcca58-82f1b4213b5mr6039028b3a.19.1776015950416;
        Sun, 12 Apr 2026 10:45:50 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0df08c09sm8524099b3a.9.2026.04.12.10.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 10:45:49 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v7 0/9]  Introduce arena library and runtime
Date: Sun, 12 Apr 2026 13:45:37 -0400
Message-ID: <20260412174546.18684-1-emil@etsalapatis.com>
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


Emil Tsalapatis (9):
  bpf: Allow instructions with arena source and non-arena dest registers
  selftests/bpf: Add tests for non-arena/arena operations
  selftests/bpf: Move bpf_arena_spin_lock.h to the top level
  selftests/bpf: Move READ_ONCE/WRITE_ONCE macros to bpf_experimental.h
  selftests/bpf: Add basic libarena scaffolding
  selftests/bpf: Add arena ASAN runtime to libarena
  selftests/bpf: Add ASAN support for libarena selftests
  selftests/bpf: Add buddy allocator for libarena
  selftests/bpf: Add selftests for libarena buddy allocator

 kernel/bpf/verifier.c                         |  14 +-
 tools/testing/selftests/bpf/.gitignore        |   2 +
 tools/testing/selftests/bpf/Makefile          |  28 +-
 .../testing/selftests/bpf/bpf_arena_common.h  |   4 -
 .../bpf/{progs => }/bpf_arena_spin_lock.h     |   4 +-
 tools/testing/selftests/bpf/bpf_atomic.h      |   4 -
 .../testing/selftests/bpf/bpf_experimental.h  |   3 +
 tools/testing/selftests/bpf/libarena/Makefile |  77 ++
 .../selftests/bpf/libarena/include/asan.h     | 118 +++
 .../selftests/bpf/libarena/include/buddy.h    |  92 ++
 .../selftests/bpf/libarena/include/common.h   |  67 ++
 .../bpf/libarena/include/selftest_helpers.h   | 121 +++
 .../bpf/libarena/selftests/selftest.c         | 188 ++++
 .../libarena/selftests/st_asan_buddy.bpf.c    | 241 +++++
 .../bpf/libarena/selftests/st_asan_common.h   |  47 +
 .../bpf/libarena/selftests/st_buddy.bpf.c     | 208 ++++
 .../selftests/bpf/libarena/src/asan.bpf.c     | 559 +++++++++++
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 903 ++++++++++++++++++
 .../selftests/bpf/libarena/src/common.bpf.c   |  74 ++
 .../bpf/prog_tests/arena_spin_lock.c          |   7 -
 .../selftests/bpf/prog_tests/libarena.c       |  62 ++
 .../selftests/bpf/progs/arena_spin_lock.c     |   2 +-
 .../selftests/bpf/progs/verifier_arena.c      | 130 +++
 23 files changed, 2934 insertions(+), 21 deletions(-)
 rename tools/testing/selftests/bpf/{progs => }/bpf_arena_spin_lock.h (99%)
 create mode 100644 tools/testing/selftests/bpf/libarena/Makefile
 create mode 100644 tools/testing/selftests/bpf/libarena/include/asan.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/buddy.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/common.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/selftest.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/asan.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/common.bpf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libarena.c

-- 
2.53.0

