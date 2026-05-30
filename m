Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92CB1A6814
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 01:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780103629; cv=none; b=kE5n8UscpWjCYma3lVoBzjZRtAjLrhq3NL2aEP2DSN+VbY0n7b+gUQq6MFZVN2HdKvoghZGj+0N+7wCKRF4xRQ/rUrjwoc4vIBzs+5p7q090zAmqUZfkT8iSSHrsNGLj04csFBo10b1S+Ak8huJNosEUzaUFvpI9+1Ar1nw57ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780103629; c=relaxed/simple;
	bh=itsVRfCaeU8qghA2nehYUq6rOIEjQ6CHRJuK6eVFQAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d2w3MRzbvtRxok99cBT/5IbS0YYTYW5FHTlIUNJifEboddfTjUKOEo0ZupxnzqzxkQzEZFcutco9jCny3C0O8sW+28I44rtiLfEv2PL9MsETFtgJOnht5GvalS4422mN3pzjDEFWUUVL286eMaNOSJj5CYqyA9u25lQjiaA4Yns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Md6402HQ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Md6402HQ"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8367df48711so6357870b3a.1
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 18:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780103628; x=1780708428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r/VOFkxmrFjmpK71zHKKmCYWDftYHpEtudi2FU9WHNI=;
        b=Md6402HQtQ4/adcBcRpBir/UVIZRXA7t9IC6hZHWKZxiTGQgPoQ/Bue/wkDcl7Uo3D
         ly1zCLysAYSRqmTC9bc3ndxuid2i+1oUiG5zBKCg5ZVRDRG0VJElsknRnEqrFX9vq7+e
         TSp7hpW5j6OmAY63eh0h0/xzPRSRTI23JepmwNl2kTv3SdlMtKdcn2Oj7bToWmPxjzCI
         Gh5MscZn1DkkTXMLtaUiucVLJ5vmbjIGLdjRM+kGEU2m1yGvi4af9o0tNKsU/o+bYg/J
         cal8ZR2f9m4wnJOgo9dlZQSX4RqTrsqKeu15jXd2TZ0xwvrtysckhw1y51L99DUlbVuP
         rGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780103628; x=1780708428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/VOFkxmrFjmpK71zHKKmCYWDftYHpEtudi2FU9WHNI=;
        b=HYvKwNNyPGb00Mw84mBtrr/BbrAGQLSlcXxApn1nr0csg8cZXHcgwExtVfthOtZJoM
         rfbiV/NF44jQ6pDDR0aoYegTFCOjrJs8605O2E4z42pof+/SnNpFTXh1cP3e19bk+cd3
         S2QW2KSLudWlQ3suQ1QtpL4LFF0cfsn/W5ONcumJMmfDNjTHxmzAKO7WaIRQUSpg9y/t
         3a8dC0C/AM1C82hchMCxFBBKlk4b5fdQMVwrN+keAsnqIoraFOZfbYM1eVzFuRzR7w7K
         qRQ+XzMQBbhbxMT3t7O6CwI3PopbNwV3MXK62jBfIBWltoy7du6RFri68Ut1aXqsLtBe
         owfw==
X-Gm-Message-State: AOJu0YwqBg0rKTBoMbb9+T4oqxlijNx7LOkN+XJO25rzBE4n9iluXKPR
	bqgFkwwRoF7PAFMz1PD0IZl/n5yJxY52X1SJH7p/SJFPTK3W3acm+6BMw2dDRg==
X-Gm-Gg: Acq92OFlArgHzbRUm3JQRv868Q4N0SfQiXMgsIjsYjq9Ywoj+C/z4FwQ1De54NBzffe
	ksgTbec/MvyXQt7hNHkfPRvkR+4VzLpPH0RjfY1MI2n3WFNFveprIH8SsXVoufUqLaFfmXJTDQZ
	u7GiSdkZ5RAEEbw4xBXY0aRDGrWAZXLewWSFztR+j5fhvAExaMRMh1WcXymZCPop2jm2QxGTpBj
	wvWdClh/oAyodT+eBORdo9EDOsbilu2URkHmFksgIlSRw+jkgno7IV4tapb61n9Fw7Jb+CJAYy0
	hUWzc7oWe5QuhDdvbSxyDdj5kshqSDcmbJ3XQDg8iBU/eviUIGleB+CAK8LG2/sC97VkJofWVce
	2Cr16dthlGmF7SeGOUknh2lYelN9Dy69Bi2Uou7GqxTcTl5KspHz/Xh584HfyicQre9YIcIZz1T
	J98fPEe9Fqxo7Dzc8KOILlCKPCGzDLj/pAjFEoodl9i5aoRr9OsOTOs9gLLh9uNa2G6LlEcCNTS
	zscrY6SRbT+GtSrrrg5nyP98BLWCTejpSra4Ph8/LKkeZDQZx8prYoFclbMfSTMCO99l5JX
X-Received: by 2002:a05:6a00:1822:b0:83e:f5d7:6e9a with SMTP id d2e1a72fcca58-8422575060emr1614931b3a.50.1780103627856;
        Fri, 29 May 2026 18:13:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8422b170f31sm431162b3a.33.2026.05.29.18.13.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 18:13:47 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 0/4] bpf,slab: Introduce bpf_arena_alloc() kfuncs
Date: Fri, 29 May 2026 18:13:40 -0700
Message-ID: <20260530011345.99342-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

v1->v2:
- disable kasan for slab-arena
  Note, patch 1 relies on patch 3 for correctness.
  I didn't squash them, since it's easier to review this way.
- fix issues found by sashiko
v1:
https://lore.kernel.org/bpf/20260529202438.16408-1-alexei.starovoitov@gmail.com/

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
  slab: Introduce kmem_cache_alloc_arena_nolock and kfree_arena_nolock
  slub: Pass kmem_cache to alloc_slab_page()
  bpf,slab: Add slub-backed allocator for bpf_arena
  selftests/bpf: Add tests for arena slub-backed allocator

 include/linux/bpf_defs.h                      |  13 +
 include/linux/slab.h                          |  25 ++
 kernel/bpf/Kconfig                            |   3 +
 kernel/bpf/arena.c                            | 425 +++++++++++++++++-
 mm/slab.h                                     |   6 +-
 mm/slab_common.c                              |   2 +-
 mm/slub.c                                     | 266 ++++++++++-
 .../selftests/bpf/prog_tests/arena_slab.c     |  59 +++
 .../prog_tests/arena_slab_freeptr_stale_pcs.c |  28 ++
 .../testing/selftests/bpf/progs/arena_slab.c  | 179 ++++++++
 .../bpf/progs/arena_slab_freeptr_stale_pcs.c  | 120 +++++
 11 files changed, 1088 insertions(+), 38 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_slab.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_slab_freeptr_stale_pcs.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_slab.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_slab_freeptr_stale_pcs.c

-- 
2.53.0-Meta

