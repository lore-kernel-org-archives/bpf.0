Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40C73D810D
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 09:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649416; cv=none; b=DkpJ3jXIC51Tr8glDYtXwzmWGe5GqN3ab8LqbPTqIanfYWTzD3fwpHW3pFuLy44TZYoiM4P2eJvME9i9ZKwCgFMr9UJCU0TYgFKyyd8/TLjaw2ZCNRAs4qwABzfojsju0xAJOSOx0gFr5MfdZZ7J7hAV60KLuaIlb7ox22/tcHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649416; c=relaxed/simple;
	bh=onzt1MDyA9EtiJwGG5noGiBqSlaH45MOzdzaSiO0aH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j+ybovK79EKwdOmlBvW+QIkNvcj6UHNDL1ZvUsN0tqHoce6v/SmEYlZfNCgh42wGDReCbU5XT3cNq60xu7hSNCQAg5CREQby+p3ACIDv4DqkOatG3oPwYBSoKFRLOS85TnZkVgZHU9FKnwxRDtVGayZABQnH4ECPKLCwudMABAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0jW6IEY; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0jW6IEY"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso3272921a12.1
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 02:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787649414; x=1788254214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NdVs0psAAYMPIsm8VVdXRYhgSPw6xWjVPwFXpfHN+sw=;
        b=D0jW6IEYl2LC9KwoQBHC2ngfTmClWgQaBlwJ6oqthGaRnL3AwdeSBx55I8uMCbp/GO
         cLfshYxGh8K0xT+SBTWJFgxAe6YW09fo4GnhwGAxEaUU2fWHCrleT7a7B3krsAGrN1Gv
         nFw1xR9GiAaCBEdCcpo+BE28vwP1lodKfrzofWkAiZrl0iwfnUgNSNpv5cohTNGLU2A6
         IKzH6IiKv3508OiZ/nO9MzV+bWvqSiEFo8BTJt4t4eimh0mFp4uDUDXwUYlXR/lB1emw
         6gCJs1uvBdxVgTXt7O6+wCdBPZ3yE4rJqZ2pgQM5arprQKv9bl2WiE3o7rsB+TrLn9sY
         MSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787649414; x=1788254214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NdVs0psAAYMPIsm8VVdXRYhgSPw6xWjVPwFXpfHN+sw=;
        b=Gc5VtVGVGc0hhYUrmCIZ5r6/oJTGJQtNSbKmsqaP8rKxmXyyKkwPwrqEQQS++msLEo
         MAL47oU98Q2cT97AF90FsUydItfmZKFPyQo9IqZW4L/oSV2sOUn1srOKObgzMEc54EPI
         6lR4AKujl21+m44LjdG5RC1Ch9BHfKWJn8UnvY5DA03BeDGoRz8HAxVgk2zBhHx0vEl/
         qXmst2LFB9BvpA3ejH1Nt0HR7YUl9f0hmxZSP7dx2T7hXfrnG/7aUyAXVYvRxGTdHgp2
         T++WH/mPQF0dDgXxnJIfYFdeWpu6pTVzLzai9RZw59GItIMgkQ8p2aZiFzYhP7a8796M
         ZyFw==
X-Gm-Message-State: AFuF++mUxEGa3Mah13jx55TwVw/mvAA+81CpyfGuNgIvnRXNZWSE6kuf
	ORjg0hFSjYE8RoTTAsa0syDeYcoGhqOONK2scelvLUWD4Hik29PeifsPONOeKZYJTWs=
X-Gm-Gg: AR+sD13sHyS0ZLYmKsd1CaXPfS6+Ci3qdmj+Ezj5XyeOeLJZ2w81QkOo1CeAEvBapRa
	8SCiKyE6yaPxjpZLdqKG1T/hopLZuRLpU2uAdV3VytPeewLekO3ukAOyS69wtyCxmPEfh1mr9u1
	F1pEbfEMWQPkDA4Jk2zwReFGNe12DVQyxpJEEYuQqAk7RUQbAzlALtZvqcU/WbJySjaZEHLcEIV
	6EZddSdG94l+aPInfAxpGpCqWogTpH1yGNRaWFX0jMPFBKMq668Qxlgoh+mQ446my8e6BFv5nI3
	8Qnlc+4ASDC32T18c3Ygwe5q63Nu/C0M2IvYCRQjdlIAojce05pnbwYBFDTXx7vx6fxRa+N0Vwv
	WVRnm1VUIDs5VRHGMzLr95Z8brTS8JEPw40XLgeR1HrUtuA0IYRmuFbQvjialEz/ugP8AY0mZVo
	gz+YNEwjXnN6kt3PIy6U4+PAiFe4iwaRaOOy6VRWe2hcG9FDMyr+sg5nWWx+89V7o124Pfg0tIz
	wwPxIEDCn6U6j43JeEQhv2Vk65g1w==
X-Received: by 2002:a17:90a:d44d:b0:38f:bbc:6a0f with SMTP id 98e67ed59e1d1-395dee7e2eamr47953016a91.1.1787649414168;
        Tue, 25 Aug 2026 02:16:54 -0700 (PDT)
Received: from localhost.localdomain ([103.120.31.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141860fe08csm52122658c88.8.2026.08.25.02.16.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 02:16:53 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	jiayuan.chen@linux.dev,
	emil@etsalapatis.com
Subject: [PATCH bpf-next v6 0/4] bpf: arena: handle memory.max on fault-in with reclaim/OOM
Date: Tue, 25 Aug 2026 14:46:43 +0530
Message-ID: <20260825091647.81632-1-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes an issue where accessing a valid BPF arena page under
memory pressure (e.g. hitting a cgroup's memory.max limit) incorrectly
results in a SIGSEGV crash rather than invoking memory reclaim or the
memcg OOM killer.

Problem:
========
arena_vm_fault() previously performed page allocation while holding
arena->spinlock (with interrupts disabled). This restricted the allocation
path to the non-blocking alloc_pages_nolock() path, which cannot sleep,
reclaim memory, or invoke the memcg OOM killer. When the cgroup's
memory.max limit was reached, the allocation returned -ENOMEM, which
arena_vm_fault() converted to VM_FAULT_SIGSEGV, killing the process on a
valid virtual address.

Solution:
=========
1. Introduce bpf_map_alloc_page_sleepable() using BPF_PAGE_GFP
   (GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT | __GFP_NOWARN) for sleepable
   contexts.
2. Rework arena_vm_fault() to preallocate the page outside arena->spinlock
   with bpf_map_alloc_page_sleepable(), allowing reclaim and OOM handling.
3. Use a lockless probe (vmalloc_to_page) before allocation to avoid
   redundant allocations in the hot path.
4. Replace misleading VM_FAULT_SIGSEGV returns with VM_FAULT_SIGBUS for
   non-recoverable internal errors, reserving SIGSEGV strictly for true
   addressing violations under BPF_F_SEGV_ON_FAULT.
5. Add a BPF selftest (arena_memcg) to validate fault-in behavior and
   proper OOM handling under cgroup memory.max constraints.

Jiayuan Chen (4):
  bpf: Add a sleepable page allocator for map memory
  bpf: arena: allocate the fault-in page outside the lock
  selftests/bpf: Add read_cgroup_file() to cgroup_helpers
  selftests/bpf: Add a test for arena fault-in under memory.max

 include/linux/bpf.h                           |   1 +
 kernel/bpf/arena.c                            |  90 +++++++---
 kernel/bpf/syscall.c                          |  21 ++-
 tools/testing/selftests/bpf/cgroup_helpers.c  |  67 ++++++++
 tools/testing/selftests/bpf/cgroup_helpers.h  |   4 +
 .../selftests/bpf/prog_tests/arena_memcg.c    | 158 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_memcg.c |  24 +++
 7 files changed, 340 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_memcg.c

-- 
2.54.0 (Apple Git-157)

