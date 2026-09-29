Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D21F530E04
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707173; cv=none; b=so4mp2jZLhdkcLPCJy0gWFMcDBc68cByNWDHSi01E0jK1s4Gugek3ofsNVj57osCd6oq2+2OdsiBCMRKLpLWhxL/RhlEdrH/S3pAQIvhm6QfNdGLDJkIjV1IUjYnjrHMLJlhw7L1rqBvrhnicdjX1KPWICr8HqKMnRvBrKw0JlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707173; c=relaxed/simple;
	bh=Bj5s2/wCxRmLUQ6V+QFLYi+quMLf1D1vOUan9CSvXBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gpUhSw24Xk9JzC8RRTmALgkVDb+HFMZPYEJurR8u8JpRnwQTr2Tlj9JPGfSCp1RjIiF5X9xyD6MaLnvHc37MDEW6UKSFqfkHtuSxLecxj4cqaFWCu0qvEYC6yHG2v1DX3+YeKxQLkyhpTDW/nGdmEOx/u3onRJZuSIdOuEieIzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=UqK91Bmi; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="UqK91Bmi"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2df4aa80a73so28585175ad.3
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 11:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790707170; x=1791311970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OLqX/EKXjklb9YoBJoleNt6F0FcuE4eyz2eSSnifvUc=;
        b=UqK91BmiM/P1WPw1ukSMldaCFADJn2yr2d/rucHt7vCar5z+6j/uceyvtspdUEkmjf
         /HaxWlkM6AA5/WawPvU6Jh9iDAso5q/zFokQTfqLWkf62y6NA0iOZKBQuFBR4PBda158
         Quzi4poBJK8f/Xu1a8lACCh8sridhpjtTm8Dy0YC3/JPDhKkDb2F3692mIuVUPrP7UPG
         wEXq6TgWkAhdS3GnzY6YlZxUnt1077qNuIyYyzRBaq7KvZQiQcMKv8WUe1hCK4dvwyE+
         ZtiQ+C9l4Dz11r8i+zbXAhDFWCSUa9VjfO6fgNTLn6iQ1jo8j9o7QtvgeaFp9qHaqbyy
         wpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790707170; x=1791311970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OLqX/EKXjklb9YoBJoleNt6F0FcuE4eyz2eSSnifvUc=;
        b=JpztSTFJybfvho0CVV/7/X4emG2BGHGdM3nvLU+HEClx5SnRMOQdHwrrlQ104xp5bY
         9iVmZ0N59OfqA1inCyHpEx0lHEviO6Kv0ghlSm2M1Kt1t3OrROwG854453YfRFqtAaob
         4Fk4JKYMgKZCaBNxREXkpiap3u/siJt1yPRF4th673+vaR4M5T/jWhjja0qKjr9Y0pMr
         afJcuWdJjacDeJ1MneJQPBAezOMWapBiSnMI77P3DaAiT9CpOQW7hfvmm7B/LyvDI5sr
         ggJEwFiyH2A7XncysomJq3clCzG9zlOi/rJTIU4iILFo39ykDDHxMgwVX+Up+FnEf/1v
         HChA==
X-Gm-Message-State: AFq9FYJ1eVFicHDZqhCbYrmkXe6dDwxrhDBFUSQI4e4x6VDI/b3WLFk7
	+fu8/t6c1GXz+dTKzVqGjHp6+zDQjDLRduPUdFiauMN/r4LMFq8UiJPuZ4esKMRo9vzzyBW1d06
	/xOMz8J4=
X-Gm-Gg: AYBFou3nAVt89XwqyJkf31bsvLVbh/VlCWpJcMpwkMvA91KK2p8IHiUfc85JpNvuz3s
	UMk/SKBfh/4u+MwftV8Rdze3AbCDEE97F/d2IRsYENYxDyfY/TmSSp7PecY29i5r0FsmBZg8eiD
	zDt7ZQJlhrSK6ecLir2mFEABbztz6tsLaH0ao6OI4Ge60xoKxP9eDFzGk4xf6u7lg1Jaiy4SurP
	mqu5wkXdJR6Rlgl7Roo7ereDMy0lBCoqsAmmUnLojhL3jtgIOlZFN93CxzhHiynZpWd07iphDNI
	QtP0R0mWRN/jQA57okflFqicSDdXAZJ2f687IElFGc0tif0xc3RJtZUb1QeRU2nUwmOHJHI9IQE
	7cP4bmulgxhdhpEO5xrRIDXDT3IlRTuJC683hq53foM9DUyHEhI748IXxp0enWNPhcAu++2Yhu+
	q/NGOjUkygqChasKuO/2AEjCgSyWcnobrk8nNy6KJpHIA+LVG00Dy06D507qXdIaPbHithnO7XI
	ABT8toyvDzIO6lWdCHjNVeBAZ4e20HPMAsN/tKVXg==
X-Received: by 2002:a17:90b:4cc4:b0:3a4:b917:b391 with SMTP id 98e67ed59e1d1-3a4c000ed5fmr95529a91.57.1790707170439;
        Tue, 29 Sep 2026 11:39:30 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a49858bf27sm6796494a91.4.2026.09.29.11.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:39:29 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v6 0/7] Make sleepable arena paths use sleepable alloc_pages
Date: Tue, 29 Sep 2026 18:39:21 +0000
Message-ID: <20260929183928.4896-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arena_alloc_pages() call takes a sleepable argument based on whether
its caller is a sleepable BPF function. This flag, along with the context
the kfunc is called in, decides whether the call will try to fulfill the
allocation using the regular or the _nolock variant of the alloc_pages
API, by means of bpf_map_alloc_pages().

However, the arena_alloc_pages() call currently only makes allocations
inside an IRQ-disabled critical section. This forces all allocations to
use the _nolock() API, which may eagerly fail where the regular variant
would eventually succeed. There have been reports of this happening for
sched-ext schedulers.

Restructure arena_alloc_pages() to use the _nolock() page allocation API
only when necessary. This requires moving allocations outside of the 
spinlock critical section for sleepable calls, which in turn requires
slightly different logic in the allocation path. Replace the page list
allocation with logic that reuses pcp_llist to chain allocated pages
together, allowing us to merge the code paths for both sleepable and
nonsleepable arena allocations.

Also fix kfunc specialization to not unnecessarily force the nonsleepable version
of bpf_arena_alloc_pages() for call sites that do not need it. This requires
making specialization per-call site instead of overwriting the descriptor
during fixups. 

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

v1 -> v2 (https://lore.kernel.org/bpf/20260824082530.47553-1-emil@etsalapatis.com/)

- Keep the sleepable and non-sleepable allocation paths within
  arena_alloc_pages (Alexei)
- Incorporate bot feedback on selftests (bot-ci)

v2 -> v3 (https://lore.kernel.org/bpf/20260923191125.5311-1-emil@etsalapatis.com/)

- Remove the intermediate page array allocation in bpf_arena_alloc_pages() and
  use the pcp_llist pointer instead (Alexei)
- Fix function specialization to only specialize to the nonsleepable version
  when necessary

v3 -> v4 (https://lore.kernel.org/bpf/20260925203939.4105-1-emil@etsalapatis.com/)

- Remove in-flight pages tracking (Alexei)
- Remove stale split sleepable/nonsleepable error handling (Alexei)

v4 -> v5 (https://lore.kernel.org/bpf/20260925233538.5708-1-emil@etsalapatis.com/)

- Remove unnecessary imm-based sorting for kfunc desc table (Alexei)
- Skip all nonspecialized kfunc descs during the linear scan done by
  function specialization

v5 -> v6 (https://lore.kernel.org/bpf/20260928202643.9114-1-emil@etsalapatis.com/)

- Use verifier_bug_if() for diagnostics (bot)


Emil Tsalapatis (7):
  bpf: Use an llist for page allocations
  bpf: Add sleepable argument to bpf_alloc_pages()
  bpf: Add sleepable arena page allocation path
  selftests/bpf: Test large allocations for both sleepable/nonsleepable
    arena users
  bpf: Directly store kfunc desc index in instruction off field
  bpf: Support per-call-site kfunc specialization
  selftests/bpf: Test per-call site function specialization

 include/linux/bpf.h                           |  10 +-
 include/linux/bpf_verifier.h                  |  15 +-
 kernel/bpf/arena.c                            | 158 +++++++++---------
 kernel/bpf/fixups.c                           |  70 +-------
 kernel/bpf/syscall.c                          |  43 +++--
 kernel/bpf/verifier.c                         |  94 ++++++++++-
 .../selftests/bpf/prog_tests/file_reader.c    |  15 ++
 .../testing/selftests/bpf/progs/file_reader.c | 129 ++++++++++++++
 .../bpf/progs/verifier_arena_large.c          |  64 +++++--
 9 files changed, 410 insertions(+), 188 deletions(-)

-- 
2.52.0

