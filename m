Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6686926560B
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 04:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775537856; cv=none; b=jD+NO2SASASerfhGhou7W/p+aj6Ih+gI6QiRIkxBuBx36DVgiZ5EJTEdQdHhuVTkLhJ5/QwmaqJ/7LHtBDNIK7YswHmk08T3vUE2tjV3xXq1yfSvLxiz97OusKjze+nmD4ohumbLMxdHJtivMjMYH28V+x18nnkYx/Tn/uD+EvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775537856; c=relaxed/simple;
	bh=zgOYdh+eA4OnHn74WZRGwhrA/XfBthOoMkr5ztlyWuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H4G53OenVt0bL1HNvJAJ/sBe7NbosaqRp+2noX8gwhRLLCOBSyyzPzYT5v15gxRNP+vjKFsaHrOo6vkUmRCvMQffZWLc7qlAxBWmUzaIysfnSc06p/z1/Qp1nRZGcRpg/2u8a5HuVOnmUzCLXcvKEhIQc21ovzgf9j9dOTMWRJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=pZm2/m1A; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="pZm2/m1A"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-82cdb4ab547so2250196b3a.2
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 21:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775537853; x=1776142653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zI/upcNWTeoC+3lfCf4fN2TVd4UgsFneUtuVk64lfek=;
        b=pZm2/m1AzHZzNA8Qkjm2ecyjyZ3FOFMrgLZKUImRhG+3OrKlrrdUes4229LX/ecyDE
         ECOtUyrrIQm0VQCrmNnnSfdCkX0GZoh4WDRMDO1Zarupczt0ScKAb+BkMI9g1Om95Aod
         r+N9NSJBv4+uf2JhMNvjneKF3krbWPR49lr1ouoVxu3EPRdSMQsMR790ZGQFtdm3uKXq
         bsRrI4gTCZREWYRZwWopOo715IPekwXp/M8Jx7jCTTb/rbi6hTU2S/QbiliMZppoY4tj
         n1oQRd8bkv/XNzhfwt0L1XnXPEGQw5oRJDw8jwduDmyCqtTxwBjZvowUykUf3AVaqBHV
         tDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775537853; x=1776142653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zI/upcNWTeoC+3lfCf4fN2TVd4UgsFneUtuVk64lfek=;
        b=P5je9p7GBj6hBtVJSIOVwyrG3R9mG4sd6bwZxURChQlZDHo73VbIP/mWUDH461ufpx
         BinsFer3waXm1i3QVRuWN5OS1BzzVXuvrTdjluK5W0cXs6AssDjocwQrs+oia1JZzGLU
         RgtZ0mJYB0t3Skxz0BzVnpUfIKOeY6eK0vz/dhqx49/yZaIkKuIlnFy4LqYzZSQrk2gj
         C7Oj26gLjZUnGrus3B0J7RUnRb2HJmp3CBpcaiz2i0BLsR5TESHVRomGJQxc5VDVDncX
         aQ6fw+heLbV92ekc4PnoY2Ci9eMBKM4Z8ZXxWW5+IBmQMYSaPCS84gxsIHhAl7EVwS+A
         jXxw==
X-Gm-Message-State: AOJu0YyjngTAAe0EeOM7aJRgNSV5GPZkpJWU6x2LTHLKK4DUuC8XM3m7
	OUfeMwEBmwurv49J+dUEIDvbTDidT5gTD0ZfPcL8RPvO19nOKdXIHx4jDtICzD1wndxGt9PPUel
	fWOOfohvXC0cs
X-Gm-Gg: AeBDieuhLT2N4yn/gOP4BPTVyDIcTo1uvmDYtAXgPbNk0nm0nm+CM7ROe3MU8gAXp/O
	mCmwyHxaiJ5wdGMaajW3qBmmUs6hoCYQxWWdMbybG1pI2cnSTiWf9BKeNEFyfs+p94t5yxik7yq
	g9GpMbFfbV+8jlfG2CYq9lzPic2Lj7ZliYjIWRRZLotmN435AX5A93xE+veraDc7kUYuZx7Ycgq
	zG1TwR9QD/sLg0GE/pjssxcbUyLbcwNOdxO/AJlFlxFgEdI1SB0g7YwuNro87/Ba6hrFCk7LUbT
	3XeKQL0hBrJF88AHvEIBhT7aj+AnwitjCjgaPckQaMkIXKYCWcBuir1Lxvy8UkTu2cTuH2myVOp
	RyvjtlFcAPGqHebGaEsC/srxmtCuLNdYh7HQwtf4JElku0ca6CcU90V1wt6BsqIp4DansDtfl2s
	xnkg==
X-Received: by 2002:aa7:88c2:0:b0:82c:2205:507d with SMTP id d2e1a72fcca58-82d0db7338fmr15913902b3a.36.1775537853547;
        Mon, 06 Apr 2026 21:57:33 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b2694csm16156807b3a.2.2026.04.06.21.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 21:57:33 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 0/9] Introduce arena library and runtime
Date: Tue,  7 Apr 2026 00:57:21 -0400
Message-ID: <20260407045730.13359-1-emil@etsalapatis.com>
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
  bpf: Upgrade scalar to PTR_TO_ARENA on arena pointer addition
  selftests/bpf: Add test for scalar/arena pointer addition
  selftests/bpf: Move bpf_arena_spin_lock.h to the top level
  selftests/bpf: Deduplicate WRITE_ONCE macro between headers
  selftests/bpf: Add basic libarena scaffolding
  selftests/bpf: Add arena ASAN runtime to libarena
  selftests/bpf: Add ASAN support for libarena selftests
  selftests/bpf: Add buddy allocator for libarena
  selftests/bpf: Add selftests for libarena buddy allocator

 kernel/bpf/verifier.c                         |  27 +-
 tools/testing/selftests/bpf/.gitignore        |   2 +
 tools/testing/selftests/bpf/Makefile          |  28 +-
 .../testing/selftests/bpf/bpf_arena_common.h  |   4 -
 .../bpf/{progs => }/bpf_arena_spin_lock.h     |   4 +-
 tools/testing/selftests/bpf/bpf_atomic.h      |   4 -
 .../testing/selftests/bpf/bpf_experimental.h  |   3 +
 tools/testing/selftests/bpf/libarena/Makefile |  77 ++
 .../selftests/bpf/libarena/include/asan.h     | 124 +++
 .../selftests/bpf/libarena/include/buddy.h    |  64 ++
 .../selftests/bpf/libarena/include/common.h   |  50 +
 .../bpf/libarena/include/selftest_helpers.h   | 109 +++
 .../selftests/bpf/libarena/include/userapi.h  |  27 +
 .../bpf/libarena/selftests/selftest.c         | 190 ++++
 .../bpf/libarena/selftests/selftest.h         |  12 +
 .../libarena/selftests/st_asan_buddy.bpf.c    | 251 +++++
 .../bpf/libarena/selftests/st_asan_common.h   |  46 +
 .../bpf/libarena/selftests/st_buddy.bpf.c     | 230 +++++
 .../selftests/bpf/libarena/src/asan.bpf.c     | 539 +++++++++++
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 879 ++++++++++++++++++
 .../selftests/bpf/libarena/src/common.bpf.c   |  66 ++
 .../selftests/bpf/prog_tests/libarena.c       |  44 +
 .../selftests/bpf/progs/arena_spin_lock.c     |   2 +-
 .../selftests/bpf/progs/verifier_arena.c      |  85 ++
 24 files changed, 2853 insertions(+), 14 deletions(-)
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

