Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C493F9F25
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780086284; cv=none; b=VkqGFu67hYs/9Y2zBX66rftm63I9Ox5qsu6I6RK2A0UB8hoxcGuVf5ArdLHXiBU7iJRyPNTGDcDmyVEeSslUaKquswrsJNfopKVuPBiIfply+2lIASgY/1Av2B9kf6NBIpNtTzswdEoMoMEzsAbsHBx9+Y6CC++JO53e9Jnieno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780086284; c=relaxed/simple;
	bh=9n8i7MZ7o78TUE0nTxAtS8E8K61nzZThye2K8tr5gVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EvjAbiHQpxMrHd1rJ9IGgFjGsMSMLASFOFhXxh8yLugXU47RisECQ7RSYKD2lpX+x2uRkzQRMPu+01jLiuDZbupMfRo0mMPpB7ZldZt9+cNSY65UmefRUzw4y8jMWQTNbqDg6L/jJWWeyDypoYHCpypG3lZSVBZJGBKWI2+Z0PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAtbP0NP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAtbP0NP"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ba4a1a0325so96461215ad.0
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 13:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780086281; x=1780691081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mTfhntOxmFkuBVIN+P1OGqxgUDuhd3I9XKbqS4UoT2I=;
        b=YAtbP0NP9+1zhR4XFIgJzPUsvi0h/5+Glbtg8R0hxFZ19MoDHnhwGzY/QLFbclU044
         QCK0vZNTxFTqbTwDsQWvg6hi0xT/y7nOVB0ljymR+DWHD81U1OCoLcONfSMksShAeW4h
         IfePMI+awVNHqRNygy/q7dRVlOdVyJvA84YZJ4X8hCk3mBxF6Q0keW3CfYs/oEULv9nk
         ps6RU8pvEpKmfiImKCFXLt/23P6jCh7B8bWnR3ppX6SUL2E03Fa9E6q5LKl5C56ekvhC
         E2RZxJy6B2B6kEwQazY+nQX2Zf9t6+oXcG3QRlwAA0REDMvfRfkEUY67E3gF0SwkBTO3
         nYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780086281; x=1780691081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTfhntOxmFkuBVIN+P1OGqxgUDuhd3I9XKbqS4UoT2I=;
        b=AQ/0PP6mWfZeqs4D99cLg5Y54G+71IGmxmW4TalPTta/wTH1GWDQ9+LWm/gTt1dF1m
         +1syIHUIZDgb+DlpBXvSwGvmSyoTsJ/G9qLoafgbVyTLK4Du4LBmuVON5b4dbuBaUQDj
         Z46SEWLUZbcT33TGLAEui6wRgl+knXJMZC/PW8gZwTo7L62yCx0d4qsQgBWaf1kCjZin
         Evd1e8iXEI6NSaXP65gY1J+yoCJk7/DqlGpkSej6V9dh+qr6SaBqBF/tSl1CiIQyhYe6
         5za0e4P8H3oQ48TU/S7BjzASUOHMwPexAMVe7JScDFWT/NbwRxJa7Qm5AmiENuBF99/y
         Rb+w==
X-Gm-Message-State: AOJu0YzzXCtcVuzvJAzb+5KdJBo+XKvn5Q/duCEr9FSfQXys9O9UQcRF
	EazaxEOFQIJWO/ojnluoRZ/fQu/fHuLoNh9ws0N2Ib9YIWcrCjlBrFFgB57pvg==
X-Gm-Gg: Acq92OHuYlZCKP2kv8d5EiTb/W/ef5JesRdPUScJpqus8PgYz0tAYBpV3fKPHO4mksu
	bTgdPH8BQShPEgXcPQOIdA498RzxfemUoX12eSswOuU70OuTcVGqcGTRgpAcluIiX3rSv0Zh2cw
	lF+AXCdC3CA36PtE/PFFgAYRT8pkYdgrEQukncpuOitn2NtxAni68XUBc9MO4esG2AO594mvm/F
	Q+g+6+Ycxp2X+cjQiHKj0Sgl5QtFp5LLYhW5GZeqFEkHGv25kjpeceKl5zSgzw06OjieoaRju8c
	gpbm4bhXv85GBWBj7ktXGh0vjjJ0CGU8ZryyXr4Ru9vYTy5NZ/FxxpVF8mMG08p4g/zObbXyAMX
	2BpDqquiJLibsd3vcRrBgHw3DazAS9WidEE18gl29RKEDm7o0qxAo1iLxn0Fy/gU+uDBXDetRtQ
	7giY1TTHGMuo3IosQ/ZqcjW00BBC7mda7/wQvSz5WQJwGg7VVQbY8kx5K+JTdJxTEPm7tcioat9
	lcXRQGT+RMukRBNg6PYTrVOYhtgwx55fLvie4x+Ar5oIo0HraR2Nnap5ysnu9mMHoYHEQ5b
X-Received: by 2002:a17:902:e74d:b0:2bf:28e3:a5e7 with SMTP id d9443c01a7336-2bf36793522mr15387015ad.6.1780086281172;
        Fri, 29 May 2026 13:24:41 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e6fe9sm27740905ad.2.2026.05.29.13.24.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 13:24:40 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	vbabka@suse.cz,
	harry.yoo@oracle.com,
	david@kernel.org,
	tj@kernel.org,
	roman.gushchin@linux.dev,
	peterz@infradead.org,
	linux-mm@kvack.org
Subject: [PATCH bpf-next 0/4] bpf,slab: Introduce bpf_arena_alloc() kfuncs
Date: Fri, 29 May 2026 13:24:33 -0700
Message-ID: <20260529202438.16408-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Let BPF programs and kernel allocate objects in bpf arena via
kvmalloc-style API: bpf_arena_alloc() kfunc.

Currently sched-ext BPF programs implement various allocators
as BPF programs on top of bpf_arena_alloc_pages() kfunc. 
This is inefficient.

Recently sched-ext kernel core introduced scx_arena_alloc() backed
by gen_pool_alloc() to allocate arena memory too.
This is also inefficient and gen_pool_alloc() is not fast enough.

Hence adopt sheaves and slub as allocator.
See patch 3 for algorithm details.

Alexei Starovoitov (4):
  slab: Introduce kmem_cache_alloc_nolock()
  slub: Pass kmem_cache to alloc_slab_page()
  bpf,slab: Add slub-backed allocator for bpf_arena
  selftests/bpf: Add tests for arena slub-backed allocator

 include/linux/bpf_defs.h                      |  13 +
 include/linux/slab.h                          |  27 ++
 kernel/bpf/Kconfig                            |   3 +
 kernel/bpf/arena.c                            | 366 +++++++++++++++++-
 mm/slab.h                                     |   6 +-
 mm/slab_common.c                              |   2 +-
 mm/slub.c                                     | 201 +++++++++-
 .../selftests/bpf/prog_tests/arena_slab.c     |  59 +++
 .../prog_tests/arena_slab_freeptr_stale_pcs.c |  28 ++
 .../testing/selftests/bpf/progs/arena_slab.c  | 179 +++++++++
 .../bpf/progs/arena_slab_freeptr_stale_pcs.c  | 120 ++++++
 11 files changed, 977 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_slab.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_slab_freeptr_stale_pcs.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_slab.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_slab_freeptr_stale_pcs.c

-- 
2.53.0-Meta

