Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F4E2DAFB5
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537782; cv=none; b=HJfZDpR9gJMPJjCO0WpzTP03orfb8ODZcmG81H2uTL0A1GbjDFzapD0Cv6Xgig3LB3qzNjz+u3/itBZIkeRFlDR9YMFOe7WwOeZ801FqIEQiCol1iUcewpzewTxwqkmx5q9C4Ok8w3IXCRWXLLRe1NnP+7CUAaWTA6nBkiVQyl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537782; c=relaxed/simple;
	bh=Tx2tEhkz1/tA9bzsWdeEPRm1iy1JBZefNdlpFgvWCjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aYEyIy9XWLv0EO7rvwecNd/9pZWTXonRJLU2kCNS6kWnXkNGOCLH9BEBLjvMYk0XSnwY3AQlUFQG2ZyK1AWU55UYRvrkZLUNp6456wWbsaqPGNDw1/VHnxelS7kcTtipHt9lWWhnRR3ukenGCFR1BU+BXknY634417A94PE0ijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=QHB38TJU; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="QHB38TJU"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50331ac1fedso7904631cf.0
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 10:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769537779; x=1770142579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g3tgrcHUXZNLQ7+OCdl3TZObogCAFmS3kJIi97+zvSc=;
        b=QHB38TJUdyv7tg9Nu8CkAAN+MY2VmFyDC/wPuYSIlW9jEsCgw5M4HJA8CzGLhmCJDI
         YogSZT5iYileix72/9F50OH9rMLKUVMVNFPdmlnLfd0E2mLaJCsgnmpYJqbtryqSRoWU
         JqDWTt7rpYBJS8fwFHVoZddcCTcU2y4c0dkcFBCx6NHsZHnKXgSmMXiVYFc0/boGmX71
         1ZhT+9T/MwIYgB2DJVH+r5HFeRtdsJKLWZw0Ymd4WRcNwSGK+JI/DXP4PA6ZHooUgUFb
         vEpusinem3wNg27w6nk/css6LpsYOF3XvD5i6dko6F+jwVf4PCxO4ph/ryAOqwL4U86H
         KHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537779; x=1770142579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3tgrcHUXZNLQ7+OCdl3TZObogCAFmS3kJIi97+zvSc=;
        b=OQDY/Yc7NEsC6tGqVPClRcH4tDFPgzQgBXSv77+oAaF75gZzK3cfwBl4tGxSSWSThy
         egTPkoWQqEL6bOGhLDjgC2qZRn8aH7NzOTJHFqxPDOgA5GPoxD7P1K1Z8ghTIe6xnDMT
         3ldMPvoopAiwrFsiSZS9lpgp0vBl10wzjEvXFeMwjYTbbLBAm3l8+rAr0bv3+KdJzusJ
         jU34hXo1bDbsTebtgiZSQPlaUSsDD0WWEf1ojGQMg0+f6cd94hVfJeh9fdpR4I+RIBor
         r+xWYO6/RtcP8KDo8tbkF1oookjQ6rC849VAbEwSThZF3o7FWezU1e8HHCWsxQAO9KNf
         bMtw==
X-Gm-Message-State: AOJu0YwEn/tQ7lMbPY/aky749uMFfRXLvmzUPBmaNcp9YsVUuP9/+qlY
	+VsrTPqEWakThoy73EDEmpFQoEYDcV7TWTuWpcznuAZBoSZpbBaq/EfPUVWWCevwd2AmsiHJ/Xl
	gkoT8
X-Gm-Gg: AZuq6aIzQn/iA8E6zAad2qHatmUW6cUOdCWZK1nbSMUib8zBWxpG7U7ufX7qw4x++Sf
	Uov0vh9ebQORLWIHBZAdUSOAb3Kpet2ev4iRTe3Ziw5+tTHPI48pRCSqLXALigLiewohb1Fs9Vi
	am5gf9dxCVR3yPcrNZgNuZakmCrsRNKPiwTzLam4jenAyg5IlpRVzjrHFVr/SKKeA2xUIx0eRQH
	1a9yXA9qduemgEy1KXZuY6muf/nphV6WwrgV6xuubIUcm8NZrRAZSOK+XdkOEQ9F7FX7OvpLV/7
	SONcX7iTQ5sWI1Xk5O0V9o/sASQimgdLNUo9vtVSQ4aUF2q80+B230N3D6KJ9CKd3u/cSNWzU7P
	fZRQKTCMdXeKZmsVgOmXBr+fw7lUtOPZfT7PF+YAkUtJDJt4zCypLwsh1Wlh4fpxvx4QsUUDcwm
	yBSrZl4EoNdw==
X-Received: by 2002:a05:622a:612:b0:4f3:5812:7a30 with SMTP id d75a77b69052e-5032fc2b707mr33693151cf.79.1769537779276;
        Tue, 27 Jan 2026 10:16:19 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c4f0sm988181cf.1.2026.01.27.10.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:16:18 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	etsal@meta.com,
	ihor.solodrai@linux.dev,
	martin.lau@kernel.org,
	memxor@gmail.com,
	puranjay@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH v2 00/13] bpf: Add arena ASAN runtime and BPF library
Date: Tue, 27 Jan 2026 13:15:56 -0500
Message-ID: <20260127181610.86376-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
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
memory after it has been freed or if it out of bounds, making it more 
difficult to triage bugs combined to regular BPF. Use LLVM's recently added 
support for address-space based sanitization to selectively sanitize just 
the arena accesses.

3) A set of memory allocators that can be reused by BPF programs to handle 
memory allocation/deletion. The allocators use the ASAN runtime to add 
address sanitization if requested.

The patch includes testing for the new allocators and ASAN features that
can be built from the top directory using "make libarena_test" and
"make libarena_test_asan". The generated binaries reside in libarena/.

The structure of this patch is:

1-2: Add BPF Streams kfunc for dumping the current program stack, and
allow BPF Streams kfuncs to be callable while holding a lock.

3-4: Minor changes to the /testing/selftests/bpf directory headers to
prepare for the introduction of libarena.

5-7: Add the base libarena directory and testing scaffolding, and
introduce the ASAN runtime.

8-9: Add a arena memory bump allocator along with testing. This
allocator is used for permanent allocations during program init.

10-11: Add a stack page-oriented allocator along with testing. This 
allocator is used for repeated large allocations to avoid constant
bpf_arena_{alloc,free}_pages calls.

12-13: Add a buddy allocator along with testing. The allocator acts as a
general allocator for arena-based BPF programs.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>

v1->v2 (https://lore.kernel.org/bpf/20260122160131.2238331-1-etsal@meta.com/)

- Added missing format string argument (AI)
- Fix outdated selftests prog name check (AI)
- Fixed stack allocation check for segment creation (AI)
- Fix errors in non-ASAN bump allocator selftests (AI)
- Propagate error value from individual selftests in selftest.c
- Removed embedded metadata from bump allocator as it was needlessly
  complicating its behavior

Emil Tsalapatis (13):
  bpf: Add bpf_stream_print_stack stack dumping kfunc
  bpf: Allow BPF stream kfuncs while holding a lock
  selftests: bpf: Move bpf_arena_spin_lock.h to the top level
  selftests: bpf: Make WRITE_ONCE macro in bpf_atomic.h conditional
  selftests: bpf: Add basic libarena scaffolding
  selftests: bpf: Add arena ASAN runtime to libarena
  selftests: bpf: Add ASAN support for libarena selftests
  selftest: bpf: Add bump allocator for libarena
  selftests: bpf: Add libarena selftests for the bump allocator
  selftest: bpf: Add libarena stack allocator
  selftests: bpf: Add selftests for the libarena stack allocator
  selftests: bpf: Add buddy allocator for libarena
  selftests: bpf: Add selftests for the libarena buddy allocator

 kernel/bpf/helpers.c                          |   1 +
 kernel/bpf/stream.c                           |  13 +
 kernel/bpf/verifier.c                         |  13 +-
 tools/lib/bpf/bpf_helpers.h                   |   2 +
 tools/testing/selftests/bpf/.gitignore        |   2 +
 tools/testing/selftests/bpf/Makefile          |  24 +
 .../bpf/{progs => }/bpf_arena_spin_lock.h     |   4 +-
 tools/testing/selftests/bpf/bpf_atomic.h      |   2 +
 tools/testing/selftests/bpf/libarena/Makefile |  69 ++
 .../selftests/bpf/libarena/include/asan.h     | 133 +++
 .../selftests/bpf/libarena/include/buddy.h    |  62 ++
 .../selftests/bpf/libarena/include/bump.h     |  26 +
 .../selftests/bpf/libarena/include/common.h   | 118 +++
 .../selftests/bpf/libarena/include/stack.h    |  44 +
 .../selftests/bpf/libarena/include/userapi.h  |  23 +
 .../bpf/libarena/selftests/selftest.c         | 328 ++++++++
 .../bpf/libarena/selftests/selftest.h         |  17 +
 .../libarena/selftests/st_asan_buddy.bpf.c    | 238 ++++++
 .../bpf/libarena/selftests/st_asan_bump.bpf.c | 193 +++++
 .../bpf/libarena/selftests/st_asan_common.h   |  49 ++
 .../libarena/selftests/st_asan_stack.bpf.c    | 253 ++++++
 .../bpf/libarena/selftests/st_buddy.bpf.c     | 231 ++++++
 .../bpf/libarena/selftests/st_bump.bpf.c      | 281 +++++++
 .../selftests/bpf/libarena/src/asan.bpf.c     | 463 +++++++++++
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 784 ++++++++++++++++++
 .../selftests/bpf/libarena/src/bump.bpf.c     | 196 +++++
 .../selftests/bpf/libarena/src/stack.bpf.c    | 338 ++++++++
 .../selftests/bpf/progs/arena_spin_lock.c     |   2 +-
 28 files changed, 3905 insertions(+), 4 deletions(-)
 rename tools/testing/selftests/bpf/{progs => }/bpf_arena_spin_lock.h (99%)
 create mode 100644 tools/testing/selftests/bpf/libarena/Makefile
 create mode 100644 tools/testing/selftests/bpf/libarena/include/asan.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/buddy.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/bump.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/common.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/stack.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/userapi.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/selftest.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/selftest.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_bump.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_stack.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_bump.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/asan.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/bump.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/stack.bpf.c

-- 
2.49.0

