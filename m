Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FD137E310
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511260; cv=none; b=pHZrS5LQSmPXOPxPECzMyiG/439QrkYxdayMC/ZKcNXaOa/coxnRgwn3zJta75RgCveqMdVkWmjvpskb8f/Y9r7EVMW27w6qAoeVcYYnFAP0sWAB7zazZ4fFdKH+fohiEiv5m1J6g0Lz8PYTkgZsRG0omrapP6nalr2iMmTYyms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511260; c=relaxed/simple;
	bh=rGn/eo7rCF71sKqUSQC6YeO0v+VgtzuhafooVdQ1guo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lGxUPNXpsaAQgaveAD+3LT/MXLqCxn01P/x9kcUw+3Eeam+zMxKIjGVOawd8EK+MTO1GqAfJv5gt3Xm44tRnLt4HEx4mJJYn+gwxNwWyzhnVsaOw1qcCm1S4EPeswOeen+52taXvfsCMtKpgGkNcc4Lpj/WjPC53OhXFPXi3Pf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=D9x3oolk; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="D9x3oolk"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-137ed2e66faso2350172c88.0
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 11:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780511257; x=1781116057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l38JHjmsK0s9q3F7YTmWtCxLSCfus8KtE+aNbS4fBqM=;
        b=D9x3oolkd+M3VRp9mc/S5nv2keR6Ogz5IMiHV/Naj5ANlWyAWq80JCWbqJnqh1395n
         HklKNhht6hOE3XCII+CWkuDdH8ddQrvOJKYkK1qPzjZ0dPK9NzkXGA8X08V2lsWxL+Sv
         QT2MstenU54FFRSMWwc8EDvEkcPs3AAqYG7qsl7gyiG3ohnEwx4e2TxhUH1s90pUKc0G
         N/SipYY9uM6FkNd/UFvnEyXl0hW9sOTJZMr/cxYI2ABgI/2ZU/L0fPuN0ZyX43nwOzst
         eoijOzvfCXscEOFsjWYeZ5OzBOHPtS1z73PkUJymbO/y7zHSu+vRCBHC3+YUwriX0mUT
         QwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780511257; x=1781116057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l38JHjmsK0s9q3F7YTmWtCxLSCfus8KtE+aNbS4fBqM=;
        b=kBpz37Psm6XJ+0mEmkWUmNxXAnFnd5EbgzVNANg3wqw2yd/c0Ie40FmdDxkEmhh4LN
         jyIKds97jgHaERFtwy80yK7qgC/aV1ePiVHuFHLoLBcfsnIxvlO98qloAwL69gsNS0PE
         AnBPF/P3MSrARNy1nzj63YCyG+tR2T7nJDc8k9qnGwQJbjr3yuIxJ6CUZu8fkcqKWmF7
         wQXR20ofPlwyHdGXxCqBUYMjEJXwbSaqJcEsZ/SnRz58U/X3UKl5wz7xp9b5Vsn2J+LF
         l6kBJ6QlWr4KbGR0nJv+U3Xv1u6UQGycujX+Umq9mVT69QLxbbZhcxPVfSgSRCgtbCHI
         WuSA==
X-Gm-Message-State: AOJu0YyeUGzXWWuBgQCC/i9W5ZLdW1HTF6KxKCX/M/Mtfs06HgI4uN43
	/q+cVqE7FEXfL8jog7s/XOUdZmerMZEdv0vhMnGgM8L9ow3lwjLJ3ZwQ9iE2AkKNbfWbmxsKCmh
	aZzrfkWxIgrr4Slc=
X-Gm-Gg: Acq92OEbyksrbcxiBzsiB7DpOg+ExrD7y9ltpBK/8OTuJXkkQihZ04G45A8JbZ2KPMz
	j9d48mIQ6KSCs9njZ377T1XckmSNcXCd9l6bizpnxTmOFhqFM9DT34e8hxu11edXdGw8sxhVTEr
	I6XqFaCdiQEG+4qOO4ZdDKIc0fy3DihiTWpxnDJaLqfE9f/7qR9K4RBkco/w3Jy3hZ3mhDpWtMy
	IYuKsv6b50HoT/jAfcolliOmcPDEelh2KzP7oJbU1Pt2O9VmbKX4SBE9/9TiVBM+1EbXV67/X+G
	52MLtoAAVLUp7uuhW0HRTMJijJ+t0u6SYvbB9Ygh6MwHbvBRmT2WDU58FB52FowHSflwl29/rGl
	KbnIoNKNIccM4w9fHxVMHTDSoHo3Z3pvOsD3U/RinQ889oXr/6F5Knlz6VneG2A2ArKI9l7jRO3
	iP4PIo6aVo+z0DfubBXJHSEVo/TUH4Sg==
X-Received: by 2002:a05:7301:100b:b0:304:2eb0:2726 with SMTP id 5a478bee46e88-3074fbc1d68mr2033172eec.25.1780511257448;
        Wed, 03 Jun 2026 11:27:37 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::ea8f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db560d7sm4137860eec.5.2026.06.03.11.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:27:36 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 0/3] selftests/bpf: libarena: Add initial data structures
Date: Wed,  3 Jun 2026 14:27:24 -0400
Message-ID: <20260603182727.3922-1-emil@etsalapatis.com>
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
 .../selftests/test_parallel_spmc.bpf.c        |  659 +++++++++++
 .../bpf/libarena/selftests/test_rbtree.bpf.c  |  968 ++++++++++++++++
 .../bpf/libarena/selftests/test_spmc.bpf.c    |  194 ++++
 .../selftests/bpf/libarena/src/rbtree.bpf.c   | 1015 +++++++++++++++++
 .../selftests/bpf/libarena/src/spmc.bpf.c     |  232 ++++
 .../selftests/bpf/prog_tests/libarena.c       |  157 +++
 9 files changed, 3341 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/spmc.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_spmc.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/spmc.bpf.c

-- 
2.54.0

