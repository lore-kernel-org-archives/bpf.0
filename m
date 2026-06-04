Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FDA2EEE69
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 23:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780617024; cv=none; b=NNXVcPU4N9nB5cHRL/WWUV4xQzdts9FH+tohYXbBiMHufp8OeaN005GIPWAqslBZmw42HJAeaMEUb0m+o9Mez3A5zcFEUhvvNtNFyOGwjs/N0+ngtP6x7xnNfGtuyhqCrwJmvx2/RpfvgGQOy8yOIEZb5HiN1f3BjiEpDEmEMys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780617024; c=relaxed/simple;
	bh=+F7d1fDMNY1oUap9R1sfe8rXQ5nZ4OGZCttGyhE1Abw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pNHk+tksJ5mjEL9ZBWNklycHwNSskm7VE58+eNydLvV5vrKWiYSEBMhz1coFmG2mIIbSlGYNJLWIk28l+u2+vhzxtL9emfVoptIpz9BeXTsRbLa1VbbgFGNTRqv3E7GHlVINMl51E5kiQA7FxNu7pC88EvJet60/TbGC0JKXihQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=VE65XEo4; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="VE65XEo4"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-304fb780deaso1426889eec.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 16:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780617021; x=1781221821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bN1ColKPzZFtMYNVmFl/WmHgv9DfkMc0Vhw0JABEMn8=;
        b=VE65XEo4Aj+2LNYbLbzoqgeqgOl3Hi0EfIn2uOQnnljQQO/113DryhtNJoY0YI3GbS
         nkAS+h0n7HbEtgSofFnjkHnsFyCr7eDkF68W3kJRdTjsdKlMejX4j4jWu/8/LmS077hz
         pOzxJaP996vH0JsjhqeQ51EJ7lsYSA5MluJk4X4+Ssevcag9KH0riPv6f0IAzkJLuYRV
         Xnuk7PyQ3wpZ0NO+9kaV/8UZFEolKrA403fe4JmD2sCIrkWnHMt1J8K3eMSiYs4FqmCj
         4Go/hTo7Tjogh1U7WQopfEPr6YTwjLhH+WMZMexj6jLivzmVlNhjaTguhU0wteofmAl0
         tMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780617021; x=1781221821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bN1ColKPzZFtMYNVmFl/WmHgv9DfkMc0Vhw0JABEMn8=;
        b=ZRUOKcrrUrcDu/+NEfHFVcgQn+JjyWRnIDWE119ThzH8J8SfL9q2PGYl6NzMKbD+a2
         JuJ5AfGM0LnGOmLHA38K0zaOQBbY6IGSC/Hd591IrHsXz8hwvJqsa22okBx2mkXSCbX1
         H58QSVJFdNgQO9nF2Nk/XNPrBw0XRmIfoH97fVLny1no8tJETeAQr4lZYAMwc6VIC+Bk
         bG2cZu4nkwyAkviD+Xj+djaeURjqt8hcZiY+3MdwDCZqT4SNg3eWUvphpBOx8XHz4JFu
         irGdKRY8yTfnsrh8xNR+q4hnrQCinH2YPLbm4pigZgQYrjPs9jd95y3incZSUqrzaJ2o
         GMCQ==
X-Gm-Message-State: AOJu0Yy0QYCgO+pQ+r3o9ynljRWx/noOKZ9lJqzC3q+URMjpFtE/VSsd
	F7fTmZP6iPimTGuPR3x6ekUFIIlgEKFvDkk0D8zFqJTJfiB51XyGPYoRZh39s7UFVmm+8lDXEMK
	f2UBwzbOEmUvM3O4=
X-Gm-Gg: Acq92OHhWS3JOKNcgQwUVPZ4Efy3qN2LwPVU05VIS5lfugjx0AHaiwN+CaPD2DedkWS
	00yq2NXtLoeq6MKzaHEFFLI6nCAD9mjb1sjmgpshLpj1rXK+nzkH6O2W/FHTYVSqBI2GluJP8VS
	UN6bUMyBXYhUJnDHbetEzrIW2uyMvPdgKMOJu2Rpbl8u6eFgHWSKFfJIcuJ0f/uk/KJ78eDwlSs
	Tvlgk4eKi5nAEASGjQ7dpHDB4jyZwMpIsUsOo78NKdv2QG1zDzkRcP1dPUM9KNDHf8dOvLnBFy3
	0nr+MFOj4fbxApET1ZnKKq9pYeeBW3v3lxTDuTQ+9HqWazpBXVAWG1Sm7i01dmXsdT+ezXucPg9
	lioBFk7FrgwACxCGZZz4M+NrFi3v1N5f9zP6QEelbqTS+yfjs8sSMun68eESdupgBLItdI/PNkx
	KJGr7LoFDvFn/32Vugl9gMgn/ARUyvgQ==
X-Received: by 2002:a05:7300:fb87:b0:304:e587:5063 with SMTP id 5a478bee46e88-3077af54770mr443769eec.12.1780617021178;
        Thu, 04 Jun 2026 16:50:21 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::39a8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df48671sm6224412eec.24.2026.06.04.16.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 16:50:20 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 0/3] selftests/bpf: libarena: Add initial data structures
Date: Thu,  4 Jun 2026 19:50:13 -0400
Message-ID: <20260604235016.20856-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two new data structures to libarena. These data structures initially
resided in the sched-ext repo (https://github.com/sched-ext/scx) and
have been adapted to the internal libarena build system. The data
structures are:

- Red black tree: Fundamental tree data structure that can also serve
  as a base for more domain-specific data structures.

- Lev-Chase deque: Queue data structure that allows efficient work
  stealing, useful in scheduling scenarios.

The data structures are accompanied by selftests that are automatically
discovered by the existing libarena test_progs selftest and incorporated
in the CI.

CHANGELOG
=========

v2 -> v3 (https://lore.kernel.org/bpf/20260603182727.3922-1-emil@etsalapatis.com/)

- Add workaround to handle LLVM 21 and GCC 15 assignment-to-memset promotions
  that are causing verification failures for arena programs (CI)
- Incorporate Sashiko feedback for cleanup edge cases (Sashiko)
- properly enforce store-load dependency between writing bottom and reading top
ordering in owner_add() (Sashiko)
- Simplify some of the ordering semantics in spmc 

v1 -> v2 (https://lore.kernel.org/bpf/20260511214100.9487-1-emil@etsalapatis.com/):

- Rename tests from st_ to test_ (Alexei)
- Removed the freelist caches from the rbtrees, previously used to defer freeing (Alexei)
- Moved the type and function definitions to use the __arena identifier
- Removed the typecasts during function return and directly return __arena
  pointers (Alexei)
- Renamed queues to spmc queues to abstract away the algorithm (Alexei)
- Adjusted the memory barriers in the spmc queue
- Added multithreaded testing harness for libarena programs (Alexei)
- Added parallel selftest for queues (Alexei)
- Split least upper bound and exact find operations back into separate
  functions to prevent RB_DUPLICATE-related bug (AI)


Emil Tsalapatis (3):
  selftests/bpf: libarena: Add rbtree data structure
  selftests/bpf: libarena: Add spmc queue data structure
  selftests/bpf: libarena: parallel test harness and spmc parallel
    selftest

 .../bpf/libarena/include/libarena/rbtree.h    |   83 ++
 .../bpf/libarena/include/libarena/spmc.h      |   27 +
 .../bpf/libarena/include/libarena/userspace.h |    6 +
 .../selftests/test_parallel_spmc.bpf.c        |  664 +++++++++++
 .../bpf/libarena/selftests/test_rbtree.bpf.c  |  968 +++++++++++++++
 .../bpf/libarena/selftests/test_spmc.bpf.c    |  194 +++
 .../selftests/bpf/libarena/src/rbtree.bpf.c   | 1041 +++++++++++++++++
 .../selftests/bpf/libarena/src/spmc.bpf.c     |  234 ++++
 .../selftests/bpf/prog_tests/libarena.c       |  157 +++
 9 files changed, 3374 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/spmc.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_spmc.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/spmc.bpf.c

-- 
2.54.0

