Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2C12110B
	for <bpf@vger.kernel.org>; Fri,  8 Mar 2024 01:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860099; cv=none; b=MPYNDpaEfg0w6xNYM8uBujrloTV2wtJ+uelG6DQbpj3SUTwCN7ugNztY+G1dGo+apv9XA8sOc4XJaMEK95h+HCeg1oRtfBTKYirke/kRX6qH+tDMld2KAUxFQkYgxD8VumKvfFfXiWVTptUJZou7w57iFJFSCKg+O7o+MPy4z38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860099; c=relaxed/simple;
	bh=xZqPlP3S32CxUEAPdN2Exf86PEJzRygBPnK1nT0TM5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UnkOyyZh9STyRvk2bxYF5vX2CWeJqsszLBjqt64YYaIBqYy5vey3H4RIxCDxb/pRgg2T/wccSkliFQ13ubl8mGgUwwSkV4awKDqqsUn0DompaqYTGBpBtg7STPiO1ELY3Yp4HgyJDt8AlD9vwlUq5EkgQ8QQJwpPlx5Z7ncoDIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7Mu/w3b; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7Mu/w3b"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e5eb3dd2f8so1213099b3a.2
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 17:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709860096; x=1710464896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EI2QShqdFcXiHl5u5EKsbNDVVgl4AIdTHHFtnNkvCoY=;
        b=l7Mu/w3bn7iIRkHzVxx/eH0z+0l69yMNymLtf6KOyxPRSF7U0GoybvebXUj3SqxWGO
         xK0wI1GoVWKEhmDjk1ffuhTdu5eBFGAu+16QIML1QOsg2P/DvAuqMTML0xjWdBcn0Rhc
         6jiI8EI0ckr1TVMJJqPjcixKEEZxKLCM5Qhp3odw/WYWu+lK4R2VdjgZLoc/SpOP+r5u
         jOBY+Sqb85YeLuShM02kuioqHC97C21DjreayL4n8rE4s7LkuXm5lFH3RgRx5WE4pAAV
         FdG7Z3sPjlrDCFPjfNJKEEDrCUto9QIv87i5Yn4YY6irN1YfgMF8MLJJaxwPzRvNgQK4
         UYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709860096; x=1710464896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EI2QShqdFcXiHl5u5EKsbNDVVgl4AIdTHHFtnNkvCoY=;
        b=iHcsyfDKUODJOhQk25u4kIEf6Sp5yRnYfPlddhEKOvhBOk46AUVkXKD4A0TVNXyrLQ
         FqHX9StVhSFRxMNP//5/XUOFaYTgdC9tqNqYOPIJmfuFxJbZPHouu5T5GYA9z9k33Zqk
         LKTbUMl4IPs74yWHL8QD/DFYdSfjRNaUlpyhvD4PTh42jqnsWQy1bz3jjxv8IP8q3xfy
         dahp0PxGn8WgNFB1TgqJfQzityrayqATKnpUNuvOkq9I985w/fZjU4tTauTFOgPnBvhJ
         RDxKxZr6Egzg8eMseg0+kHmAQNuytPndAd1iUYO7MXH+9jKp08J80DnGkAxfmqdDRog9
         Raug==
X-Gm-Message-State: AOJu0YwHrR3LAiAnyB7gRLt51AA0SwPD2XCzv3ncN5XfDltDoi6OzEyj
	BSiTxg+nvXZBWi6ZdUdx5DSmZbbCy+0JRXDeiKhiCd6Q8Fq2k197QuUmbz8S
X-Google-Smtp-Source: AGHT+IHFzE8C3rcxRA/gDOYTjs8IvvLOGOaLMt5TUXLgWVuJqOBe4ezPITt4Y6mvt/NGvlPiGP2/+A==
X-Received: by 2002:a05:6a20:7488:b0:1a1:83be:8187 with SMTP id p8-20020a056a20748800b001a183be8187mr64431pzd.5.1709860096269;
        Thu, 07 Mar 2024 17:08:16 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:428c])
        by smtp.gmail.com with ESMTPSA id f4-20020a056a0022c400b006e510c61d49sm511287pfj.183.2024.03.07.17.08.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Mar 2024 17:08:15 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	torvalds@linux-foundation.org,
	brho@google.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 00/14] bpf: Introduce BPF arena.
Date: Thu,  7 Mar 2024 17:07:58 -0800
Message-Id: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

v2->v3:
- contains bpf bits only, but cc-ing past audience for continuity
- since prerequisite patches landed, this series focus on the main
  functionality of bpf_arena.
- adopted Andrii's approach to support arena in libbpf.
- simplified LLVM support. Instead of two instructions it's now only one.
- switched to cond_break (instead of open coded iters) in selftests
- implemented several follow-ups that will be sent after this set
  . remember first IP and bpf insn that faulted in arena.
    report to user space via bpftool
  . copy paste and tweak glob_match() aka mini-regex as a selftests/bpf
- see patch 1 for detailed description of bpf_arena

v1->v2:
- Improved commit log with reasons for using vmap_pages_range() in arena.
  Thanks to Johannes
- Added support for __arena global variables in bpf programs
- Fixed race conditions spotted by Barret
- Fixed wrap32 issue spotted by Barret
- Fixed bpf_map_mmap_sz() the way Andrii suggested

The work on bpf_arena was inspired by Barret's work:
https://github.com/google/ghost-userspace/blob/main/lib/queue.bpf.h
that implements queues, lists and AVL trees completely as bpf programs
using giant bpf array map and integer indices instead of pointers.
bpf_arena is a sparse array that allows to use normal C pointers to
build such data structures. Last few patches implement page_frag
allocator, link list and hash table as bpf programs.

v1:
bpf programs have multiple options to communicate with user space:
- Various ring buffers (perf, ftrace, bpf): The data is streamed
  unidirectionally from bpf to user space.
- Hash map: The bpf program populates elements, and user space consumes
  them via bpf syscall.
- mmap()-ed array map: Libbpf creates an array map that is directly
  accessed by the bpf program and mmap-ed to user space. It's the fastest
  way. Its disadvantage is that memory for the whole array is reserved at
  the start.

Alexei Starovoitov (13):
  bpf: Introduce bpf_arena.
  bpf: Disasm support for addr_space_cast instruction.
  bpf: Add x86-64 JIT support for PROBE_MEM32 pseudo instructions.
  bpf: Add x86-64 JIT support for bpf_addr_space_cast instruction.
  bpf: Recognize addr_space_cast instruction in the verifier.
  bpf: Recognize btf_decl_tag("arg:arena") as PTR_TO_ARENA.
  libbpf: Add __arg_arena to bpf_helpers.h
  libbpf: Add support for bpf_arena.
  bpftool: Recognize arena map type
  bpf: Add helper macro bpf_addr_space_cast()
  selftests/bpf: Add unit tests for bpf_arena_alloc/free_pages
  selftests/bpf: Add bpf_arena_list test.
  selftests/bpf: Add bpf_arena_htab test.

Andrii Nakryiko (1):
  libbpf: Recognize __arena global varaibles.

 arch/x86/net/bpf_jit_comp.c                   | 231 +++++++-
 include/linux/bpf.h                           |  10 +-
 include/linux/bpf_types.h                     |   1 +
 include/linux/bpf_verifier.h                  |   1 +
 include/linux/filter.h                        |   4 +
 include/uapi/linux/bpf.h                      |  14 +
 kernel/bpf/Makefile                           |   3 +
 kernel/bpf/arena.c                            | 558 ++++++++++++++++++
 kernel/bpf/btf.c                              |  19 +-
 kernel/bpf/core.c                             |  16 +
 kernel/bpf/disasm.c                           |  10 +
 kernel/bpf/log.c                              |   3 +
 kernel/bpf/syscall.c                          |  42 ++
 kernel/bpf/verifier.c                         | 123 +++-
 .../bpf/bpftool/Documentation/bpftool-map.rst |   2 +-
 tools/bpf/bpftool/gen.c                       |  13 +
 tools/bpf/bpftool/map.c                       |   2 +-
 tools/include/uapi/linux/bpf.h                |  14 +
 tools/lib/bpf/bpf_helpers.h                   |   1 +
 tools/lib/bpf/libbpf.c                        | 163 ++++-
 tools/lib/bpf/libbpf.h                        |   2 +-
 tools/lib/bpf/libbpf_probes.c                 |   7 +
 tools/testing/selftests/bpf/DENYLIST.aarch64  |   2 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |   2 +
 tools/testing/selftests/bpf/bpf_arena_alloc.h |  67 +++
 .../testing/selftests/bpf/bpf_arena_common.h  |  70 +++
 tools/testing/selftests/bpf/bpf_arena_htab.h  | 100 ++++
 tools/testing/selftests/bpf/bpf_arena_list.h  |  92 +++
 .../testing/selftests/bpf/bpf_experimental.h  |  43 ++
 .../selftests/bpf/prog_tests/arena_htab.c     |  88 +++
 .../selftests/bpf/prog_tests/arena_list.c     |  68 +++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../testing/selftests/bpf/progs/arena_htab.c  |  48 ++
 .../selftests/bpf/progs/arena_htab_asm.c      |   5 +
 .../testing/selftests/bpf/progs/arena_list.c  |  87 +++
 .../selftests/bpf/progs/verifier_arena.c      | 146 +++++
 tools/testing/selftests/bpf/test_loader.c     |   9 +-
 37 files changed, 2028 insertions(+), 40 deletions(-)
 create mode 100644 kernel/bpf/arena.c
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_alloc.h
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_common.h
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_htab.h
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_list.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_htab.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_list.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_htab.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_htab_asm.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_list.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena.c

-- 
2.43.0

