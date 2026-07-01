Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B007B3624B3
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946239; cv=none; b=MyeN4EyrgyHRoNGG8T16LvszR+VkbYKBWkHMnt957iXBW53L4bGYUbqsuNx7Qw7doB5wF7bhiq2FTuCj67Rsts5Hw2DGOQPt1E8Z9F1MQMw+TJ6FLVLeDLWrWSCGI3tfPtduimkiJQ/6Zo/6SudIEHz9p28nwCp+PsyjonxqtEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946239; c=relaxed/simple;
	bh=wSUarZxLT5l/rn3QrbLzdq4xFXZkqD3mFBisx/UYOHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YEoamr8mm9cH/FG8K6XvPooU/L7fR8cUjcReU877QFhso2gFMDnyte7IufF+ozOsYlcmPicY2/FG2iRS8de9QcSfmlpJpuG6AHV90S977pHP7x1AJwmOk79ZKexlm0/n7CQHBW/J33zCvtFIBOn92tr3DhWzkAA6ZFSKKLWn2XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=vYjblRln; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="vYjblRln"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8f032b47e3cso7395346d6.0
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 15:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782946237; x=1783551037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3lVhVaQ0Z9tlzKRWgjAq400u60I7F8C/wdHnFkGdkoM=;
        b=vYjblRln39qhPzdWS8lW6Zd0nKZEjpJpd1tIwiyTh/Gy2QODwzchXvXBiAov+rgZjf
         uOM1CUZVxLxZpjeAMbAiEYOJ5lmvd6W9pLOjlze3Qw56x6DMHISmasqiw5N+zpnKK3Ew
         FEgJgtC6CbPIgtJFPSU+lEOBViLEiY8BbTYXIBEGqnbUMUxQJN7gRVrAGSIkqUEvZULE
         3XWKvKFTl3lDgkHTAWeTymN1BqnBE+rdF0BR65TeQIyot7pYpfn/ZZDX1prBDT7C3m6T
         r+/a/QcwvL5OBwZvfZjntJc154mUqoLscYWSzPBjWGctw9gth7c9QPfAmlYTMrMhLM6X
         /0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782946237; x=1783551037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lVhVaQ0Z9tlzKRWgjAq400u60I7F8C/wdHnFkGdkoM=;
        b=Deb/9ATDzrsik4EUVQE8LKeeOcotyIdnVxzE4ts4J/1RUULv1NorgnVKbmtt9UljC6
         YHauUCJPuBsNYuu9baIo0CIndBffz134gWSI5r1dVCB0ImbSDQWvrUuHi3iXIoh2/8cd
         AO6ktqdjYgasnruZuaF0bj9z/hVy3kmn7RIjrG76dVPrp4xPwxsJ/9FwLOZNhMc8+Zhi
         3lYwKt/0sPPdXJdCPipzGRuMsmV0d9vOOQ2P23I4H0jdxNcjPubdWvEV0/JAmH48d0mc
         DFh0QrACHlCh/2C56ilEaRdtANmD4q+YhrjuTYQ6xpWLNO1A+8KBk6Lgcty+O/nmvp4r
         ZgRA==
X-Gm-Message-State: AOJu0YxpNv9SnwMgxvKy4dNGd0J23BjSnPnz+Umg4/Qa3O/0JSH4FgZI
	NaHRTT/4C3ut3fQORsJVM1RMdYMJvdYRgwvJdffR3Xts2hr/54OHnDtzS/wJGcs5n1lrvDEt2BT
	3RZzqo8k=
X-Gm-Gg: AfdE7cnHj9B7uF/gnlsMxTQDk0TWe+NbryLpVxIVYTFeG+m7kxhRNPcYJyzofPp6maM
	7GHr+ZgSJZYsyBD6eiS3JlnVJRZQxxz1oj5sLfyUnAmyQMyNmNhytv2j2Yxwh0etJTgXlY5xsSm
	GjoEXci3jGs1RZ6QuGKBEcb7HQR3sZ/y1J7p+mvb2y4vqffF8B80Vh3CgqR5znGkxp5JYsCHz4k
	vx73XsQSqbSkNn5g4wlHSKgXQHtK6u/S4u8Igcp0ksx0PQfyGL+rdLYJBbiHd4hDLfsjGzEDA/B
	umMMEIQwkW80hrm7AAbVW8rfkP9NukGGBQXlgUGj1KKELzFkFEYMfK1MVJAso6mSa+q16ywPxHb
	OGCS2fiT3AtXirLF+9Hc+248F/a9gBKqK7HNraGTNaJH/saWdSdDkAZ+E/O6D8/9hPsC8m97aqt
	IstARG3cCEiCMeGoNIMgEHat7fttVA+0zMXjFncA==
X-Received: by 2002:a05:6214:2466:b0:8ef:76c:cb15 with SMTP id 6a1803df08f44-8f3c3021187mr50273986d6.0.1782946236717;
        Wed, 01 Jul 2026 15:50:36 -0700 (PDT)
Received: from krios.home.ca.int.haoyugu.com ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4724bad04sm12064736d6.44.2026.07.01.15.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 15:50:36 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mattbobrowski@google.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 0/5] selftests/bpf: libarena cleanup and bitmap struct
Date: Wed,  1 Jul 2026 18:50:29 -0400
Message-ID: <20260701225034.12628-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanup patches for libarena, along with a new bitmap data type that is
in use by sched-ext. Patch 1 is an NFC that properly renames the buddy
selftests for consistency. Patch 2 fixes the zero variable used in
libarena for can_loop based looping, and afterwrds removes all bpf_for()
instances from the code. Patch 3 fixes an (untriggered) edge case that 
could cause spurious selftest failures. Finally, patches 4 and 5
introduce the bitmap data structure along with selftests.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>


CHANGELOG
=========

v2 -> v3: (https://lore.kernel.org/bpf/20260701185235.4516-1-emil@etsalapatis.com)
- Remove unused macros and fix typo in commit message (AI)

v1 -> v2: (https://lore.kernel.org/bpf/20260618085626.19633-1-emil@etsalapatis.com)

- Added acks by Ihor and Eduard
- Fix missing commit message (Ihor)
- Enforce 64 bits per cell with BITS_TO_LONG_LONG (Sashiko)
- Add test for bmp_copy (Ihor)
- Add atomic versions of _set() and _clear() (Ihor) and add a parallel
  selftest for them.



Emil Tsalapatis (5):
  selftests/bpf: libarena: Fix can-loop zero variable definition
  selftests/bpf: libarena: Clean up allocation state before buddy tests
  selftests/bpf: Add arena-based bitmap data structure
  selftests/bpf: libarena: Add bitmap selftests
  selftests/bpf: libarena: Add parallel bitmap selftest

 .../bpf/libarena/include/libarena/bitmap.h    |  34 ++
 .../bpf/libarena/include/libarena/common.h    |   2 +-
 .../libarena/selftests/test_asan_buddy.bpf.c  |   8 +-
 .../bpf/libarena/selftests/test_bitmap.bpf.c  | 394 ++++++++++++++++++
 .../bpf/libarena/selftests/test_buddy.bpf.c   |   8 +-
 .../selftests/test_parallel_bitmap.bpf.c      | 190 +++++++++
 .../selftests/test_parallel_spmc.bpf.c        |   9 +-
 .../selftests/bpf/libarena/src/bitmap.bpf.c   | 245 +++++++++++
 .../selftests/bpf/libarena/src/common.bpf.c   |   9 +-
 .../selftests/bpf/prog_tests/libarena.c       |   8 +-
 .../selftests/bpf/prog_tests/libarena_asan.c  |   8 +-
 11 files changed, 899 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_bitmap.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitmap.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c

-- 
2.54.0

