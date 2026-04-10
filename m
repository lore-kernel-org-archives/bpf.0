Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3433DC4D9
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838654; cv=none; b=VxAKR8fINGIcU2iuVLs4mt3R3djOLRvSDLtfw5cIilO8zC8+mkonWEWwKU1Ki6GLfIbhyDJdi+mZblpFSI1HUj1wTS2PNHsPLCu2sp6BDb7kGp9rDjLrm0ctbTwjF1RwyX+aTAUcbH9jhGDZrZ7jSufxr8NOmZqmjFjszs2COao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838654; c=relaxed/simple;
	bh=NlFkOZRcedm2cIKQmMep9Y0rESn3hyM+XpIUNX39fVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hrrK3GAnjlAdmftivNws6cs64tpkCOU8u0tVHMshOC3MTZe2+VluskU3xVdyGIF7ML9MFabxOxXeW/+p+t5afleq7ig6qoB0WlI9ZZ4ZK8T0AVksp81tzOY6b208UzCAfp+jvZox9iQqRDk8cbPbBKsE8k0+2jxD71tQDf6uKXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=sL9RUoQV; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="sL9RUoQV"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so1918347eec.1
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 09:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775838651; x=1776443451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lzVzZ3a24PLLne+2eedhHgr+AOF69LnbB/qBv2TsW9Q=;
        b=sL9RUoQVYiBcJ4p/keFMqCiE4sThbf1ZcBwcBj+dDHYYRJHHXhYU9H1sW/U1n3U0Ma
         COn+rLpQRThC7UM3YhqNlFohBKHWsbCwqUaKA+5pscAoHlUheRLTFInAWEf4gMnM/ikw
         d1T+VMi8GWPTWyYAtjuGL3RqV4mMWoONlWSPNnNKKu4brB1s28whyheFlNhDF/te39dX
         9wKT1gohNP73+qiJnTpOTDPqnmrOnZ0Z17sZXoeRQxRp+nNN/0gCBZoerk4imBReYBbf
         xVAxgfUGmDxv1TcciLgzZZc31rCpCjRzD85wL7xt1vwJjBWQO2sNBJSjV8mVriUQ/Kba
         CjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775838651; x=1776443451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzVzZ3a24PLLne+2eedhHgr+AOF69LnbB/qBv2TsW9Q=;
        b=GMC9NFQp4ZYK0jZ8EnrZgo8pULt85EVkXt9yQKWVJKKq6MiH6Wi1QrJ+ZqPFKH3iXm
         LHOJRKOYk7ZQy/ml/zb3ugIMwu77/E1DvevZ8U4r/GvYufi7vM8By/hF/G5oLAMmpGiW
         RgWEn5An+ZnY5ELJOmyFIJKSqbUJFHtbtDbhY+UpQGgFjzIwImYOKbGhj1BldIphJme4
         kBD38ynSF82LsbTGEEKzepFHeXKY3EE6RK580vYW3Nrxd7lwcQkx1QKq3Hst4EyO6CQe
         nwAIb/8uYxJ2MjdPmVRd3UWe60TNrd9B306QXhtnm2oH4F98fqJK9ler8scLBu28VDRB
         0aSA==
X-Gm-Message-State: AOJu0YxOF+fLuXyDEBJNG9O8VKy/SCQk57Uy4v52G32S/xmERBKe76VI
	fwuDbiDbuHAaS0ebTOxJGvYKfPCqNUA8YbRPArcdTqNPH7aESCVv3nsG6u83/zgS1mQxEjwXNuE
	9fM28Czk=
X-Gm-Gg: AeBDieunZtbXZDp26Dro0SuC2XpmrmAvyUb/6ARjh5Kv8Rn9pUmRJgurQQBRhYw0g+9
	MjZDGZBbPkEUft4+P+sIAa0J4Otb0tAew1UVBVdpuPZL7+99fcFdwa2XStbXyo+eD44FIDG3nwy
	tLPSbZ6PYqBJSmNMbl3hwMh2TGYRsrv5/ODA0E2WkNXIlpaLwAOTIFVh5FdWXQ27xrE8XWeY53i
	JzTyZk6JZy/vIGcuxL952iUjMdNw3/dp1X1e2UsSo4soWsmsBTZaABmjXvhUqxzUPyIivpGN6Lg
	+w8D9vjA34kOHpF7H9GtL8LsfsTIIp3IXlA5c3BeTAcwjRDCQKDdD6pslY7mma35DUKG6UlrYlK
	HxHcyuFfLVYTbvxUCXXuYM8tjX7YsI9PBLf6R+eH3G/ieMZ2SuDI5zw8GrkW2TCOMXQAD/hwD1r
	YUm5R7lrZ4SyvLLO22FHY=
X-Received: by 2002:a05:7300:6d03:b0:2d2:fe3e:b763 with SMTP id 5a478bee46e88-2d589462e7bmr2224274eec.22.1775838651124;
        Fri, 10 Apr 2026 09:30:51 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::6eaf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55f5c69d5sm5642619eec.3.2026.04.10.09.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 09:30:50 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 0/9] Introduce arena library and runtime
Date: Fri, 10 Apr 2026 12:30:32 -0400
Message-ID: <20260410163041.8063-1-emil@etsalapatis.com>
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
  bpf: Upgrade scalar to PTR_TO_ARENA on arena pointer addition
  selftests/bpf: Add test for scalar/arena pointer addition
  selftests/bpf: Move bpf_arena_spin_lock.h to the top level
  selftests/bpf: Deduplicate WRITE_ONCE macro between headers
  selftests/bpf: Add basic libarena scaffolding
  selftests/bpf: Add arena ASAN runtime to libarena
  selftests/bpf: Add ASAN support for libarena selftests
  selftests/bpf: Add buddy allocator for libarena
  selftests/bpf: Add selftests for libarena buddy allocator

 kernel/bpf/verifier.c                         |  25 +-
 tools/testing/selftests/bpf/.gitignore        |   2 +
 tools/testing/selftests/bpf/Makefile          |  28 +-
 .../testing/selftests/bpf/bpf_arena_common.h  |   4 -
 .../bpf/{progs => }/bpf_arena_spin_lock.h     |   4 +-
 tools/testing/selftests/bpf/bpf_atomic.h      |   4 -
 .../testing/selftests/bpf/bpf_experimental.h  |   3 +
 tools/testing/selftests/bpf/libarena/Makefile |  77 ++
 .../selftests/bpf/libarena/include/asan.h     | 105 +++
 .../selftests/bpf/libarena/include/buddy.h    |  92 ++
 .../selftests/bpf/libarena/include/common.h   |  68 ++
 .../bpf/libarena/include/selftest_helpers.h   | 121 +++
 .../bpf/libarena/selftests/selftest.c         | 184 ++++
 .../libarena/selftests/st_asan_buddy.bpf.c    | 243 +++++
 .../bpf/libarena/selftests/st_asan_common.h   |  47 +
 .../bpf/libarena/selftests/st_buddy.bpf.c     | 211 +++++
 .../selftests/bpf/libarena/src/asan.bpf.c     | 550 +++++++++++
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 879 ++++++++++++++++++
 .../selftests/bpf/libarena/src/common.bpf.c   |  71 ++
 .../bpf/prog_tests/arena_spin_lock.c          |   7 -
 .../selftests/bpf/prog_tests/libarena.c       |  61 ++
 .../selftests/bpf/progs/arena_spin_lock.c     |   2 +-
 .../selftests/bpf/progs/verifier_arena.c      |  85 ++
 23 files changed, 2852 insertions(+), 21 deletions(-)
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

