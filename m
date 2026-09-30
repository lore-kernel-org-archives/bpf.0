Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649154028F7
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790796693; cv=none; b=X51q6ch2NVGrf0kidVZnRjupb8LtSuRRsDynyYWRgrFMgGo3T2W01VI3pKfW19GilDDmC0BzoF0dwCI9AVlgrCi0VJG1v5d20qyFOIGTE8Nw8G+jAh0aeuZ5NtG8wDNuk/XhNAy5UWuHg6sJCLf7z1I6M4SopbrFe+flpPJaD7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790796693; c=relaxed/simple;
	bh=LyOIunpq1WKYCm65PXgSPazW/Gbg+CBan8qjyR+o958=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o/Zt7Ei65/vDwRDlPUBhca8VC+f/hZPICBQ/thwWVFAgAdhojvSewaSm2Zte9Aumx7Yk6YY05BbSYAttz9lP+UoKbYkr3m+fTFXma7lGTl15f5luY2xlg5cnCKrRZvgf3Z9RulIkIlNdmBOln6QoFG6SZU8BOQUSNdbqgrEN6FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbDEWVpO; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbDEWVpO"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea4bfd1so2474709a12.0
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 12:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790796691; x=1791401491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZW7x4ZrdTWJRb7anx2N5+83pfnr9EHrxDJaC5HxmdNE=;
        b=AbDEWVpOZDZoQlRlU0ltJWCQpmDWEn5zBeT72OFcxqXCk/w4ZOmKohiZoOYZK0IPA6
         oS+U6BaQmLalMHzbRRAc/YvvOfGH+B9AShJUKTRZ68NcxR/DVkoM5Rd807DnWzgVTG99
         nqvV1xr/c4It8ATr5fq2f6+hboDys1+f4MxLT6kBv3s1ghlvofO4cBfLVwEsM+U9p/tM
         RDXqyJwSQxHlz2gXjYOdMtHnm0KCYPx1Z4JqeNZSFmSyXWZjcNiPGZ1Td8D3UxYO60TF
         E6nm25CMZYmdbOsPu5pDSke750Pon29dI3QCJl4upbDARbJh0j5LJ33/QsKnqnScHXTO
         vZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790796691; x=1791401491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZW7x4ZrdTWJRb7anx2N5+83pfnr9EHrxDJaC5HxmdNE=;
        b=wbZXIm7ywazOcY7DCLiK5Hb4KESwBbI7uPQfYxyGKHehZ/HS6JMhDMG5iRo4B92SrK
         d7lLdUZY3uCt22KML1WOt3onwKPOTWxnELoEGjy7Hj7DXgK9rSaPl+JwxXhPPSqWNMCr
         gUQTRxuyu6zJl0pn2t7ZDxi706UPN7ZVJvXyGauCbt0RIGLWvrcyO/651+MJClhgKLot
         lIRAqI/CnKx1q5+oYSltSjwk8Z5kZJ3ekF59wK5bkzGHoxXyKcRmvVHHS3zQWazs0Jfu
         0D+d747Fgl795w7gyPU11Ay88Lw1KJg2oChMLuko9skgAPsw7yYqmFR3i5aQHLP4WYA9
         M41A==
X-Gm-Message-State: AFq9FYKNoypE/pX6xt5bLpFd3SP/bkoe4RA97N8f6eMIlbzWwEgONHks
	4yZvRzjn2FPWk6Umv9HKYx/2VtCTFtVmDR1MvxZM8B8i78Bx/LYDFsRbeyRLg4J9
X-Gm-Gg: AYBFou1Zx2pxWsqPFxpE12HnBufnl2w01N3/IVNHvstBnuThx6rcZTaLk0ZDDPrIZQI
	7HNz1cwrxMIbGZ1dCPxqSo6lJvyjBoiI0KU3LhrNk6XfOA1WdPJZ1OO8Y8J2a3wwQTyqKD4q1uh
	Eli1LMO64x0wQv//ZYw2z4Hxx7BCVkBkRSYlZzC6N+UASfYGgSTsqTyqlYmCS1vWtpt1V8K5hW3
	4/FlgloOr9kNR4QPQEPnXNugS/5E0OOdt0LxGJxrs7DVqca9LCD94PjP00NKuj46Qxgolt47n39
	a8V62tbKa8/lbupYbHiOi/M84BkU3vqRmfIkSIiJ/n2ySPr0Wpt/stvtqpqrFqbAU1b7QJ2HnVR
	92nuvDsCI2h2y/R6Th/de/BON8SbX8vm/GofPFhb1ycPkr6+MwR/sZoMXMq1MrtHVskAZ7wkPL+
	kERZ98SjX/0aPH463gBNLVf/waOJVdhpQL0Y1bggH5UZJ1gQBC4zShxfLkoW3zBG4FF3xEQMgUy
	PJWUDxiWQaPNwlaoTkZ/SDtPilb2jRKorVZpZzFehFmSK2nu9mhHemCtZIEhyO3y6TElkvvpeFD
	FARgDYq8Aa/NUYWwnmM6REUJD3nKMVyLJXFNh3oR5FbK
X-Received: by 2002:a17:90b:2250:b0:3a4:cfc2:354a with SMTP id 98e67ed59e1d1-3a4d1956b93mr1046949a91.61.1790796691261;
        Wed, 30 Sep 2026 12:31:31 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f478e9c6sm626178a91.14.2026.09.30.12.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:31:30 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 00/14] bpf: Support programs compiled by rust-bpf
Date: Wed, 30 Sep 2026 19:31:13 +0000
Message-ID: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Rust programs compiled by rust-bpf keep all memory in arena and access
it through plain numbers, since there are no address spaces in Rust.
core tags pointers in the low bit. BTF of such program has names like
'Option<alloc::collections::btree::map::BTreeMap<u32, u32>>'.

Patches 1-2   Allow ALU on pointers with CAP_PERFMON. The result is
              a number.
Patches 3-4   Treat load and store through a number as arena access
              in programs loaded with BPF_F_ARENA_SCALAR.
Patches 5-10  Accept BTF of Rust programs in the kernel: names of types
              and functions that are not C identifiers, arguments of
              static functions without names, a variable in DATASEC
              that is smaller than its type.
Patches 11-13 libbpf: Keep .data, .bss and .rodata in arena when
              the object has .arena.data section and load its programs
              with BPF_F_ARENA_SCALAR. Format strings of bpf_printk() go
              to .rodata.str, which stays a map.
Patch 14      A program in Rust, built by upstream rustc, that shows why
              the data has to be in arena.

No changes for unprivileged programs. Without the flag a number is not
an address, whether the program has an arena or not.

Arena access through a number is for x86 and arm64: other JITs have to
say that they take BPF_REG_AX as the address, the flag is rejected with
-EOPNOTSUPP there. arm64 is compile tested only.

With the series the kernel loads BTF of scx_simple and scx_cosmos
schedulers written in Rust, of the unwind and of the immediate-abort
builds. The objects call bpf_alloc(), bpf_free(), bpf_arena_memcpy() and
bpf_arena_memcmp(), which are not in the series, so they don't load yet.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (14):
  bpf: Allow bitwise ops, shifts and mul/div on pointers with
    CAP_PERFMON
  selftests/bpf: Add tests for ALU on pointers with CAP_PERFMON
  bpf: Treat load and store through a number as arena access
  selftests/bpf: Add tests for arena access through numbers
  bpf: Allow names of Rust types and functions in BTF
  selftests/bpf: Add tests for names of Rust types and functions in BTF
  bpf: Allow arguments without names in static functions in BTF
  selftests/bpf: Add test for arguments without names in static
    functions
  bpf: Allow a variable in DATASEC that is smaller than its type
  selftests/bpf: Add tests for a variable that is smaller than its type
  libbpf: Keep global data in arena when the object has .arena.data
  libbpf: Keep format strings of bpf_printk() in .rodata.str
  selftests/bpf: Add test for global data in arena
  selftests/bpf: Add test for global data of a program in Rust

 arch/arm64/net/bpf_jit_comp.c                 |   5 +
 arch/x86/net/bpf_jit_comp.c                   |   6 +
 include/linux/bpf_verifier.h                  |   2 +
 include/linux/filter.h                        |   1 +
 include/uapi/linux/bpf.h                      |   6 +
 kernel/bpf/btf.c                              |  50 +-
 kernel/bpf/core.c                             |  11 +
 kernel/bpf/fixups.c                           |  39 +
 kernel/bpf/syscall.c                          |   4 +
 kernel/bpf/verifier.c                         |  74 +-
 tools/include/uapi/linux/bpf.h                |   6 +
 tools/lib/bpf/bpf_helpers.h                   |  18 +-
 tools/lib/bpf/libbpf.c                        | 415 +++++++-
 tools/testing/selftests/bpf/Makefile          |  12 +-
 .../testing/selftests/bpf/Makefile.buildvars  |  19 +
 tools/testing/selftests/bpf/Makefile.skel     |  17 +-
 .../bpf/prog_tests/arena_scalar_blinded.c     |  21 +
 tools/testing/selftests/bpf/prog_tests/btf.c  | 105 +-
 .../selftests/bpf/prog_tests/btf_rust.c       | 147 +++
 .../selftests/bpf/prog_tests/data_in_arena.c  | 171 ++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/data_in_arena.c       | 107 ++
 .../selftests/bpf/progs/data_in_arena_decl.c  |  37 +
 .../bpf/progs/data_in_arena_extern.c          |  20 +
 .../selftests/bpf/progs/data_in_arena_fail.c  |  20 +
 .../selftests/bpf/progs/data_in_arena_rust.rs |  70 ++
 .../bpf/progs/verifier_arena_scalar.c         | 912 ++++++++++++++++++
 .../bpf/progs/verifier_value_illegal_alu.c    | 173 +++-
 tools/testing/selftests/bpf/test_loader.c     |   2 +
 29 files changed, 2373 insertions(+), 99 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_scalar_blinded.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_rust.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/data_in_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_decl.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_extern.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_rust.rs
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_scalar.c


base-commit: acff58e305175df35985082b0e79103a2497f702
-- 
2.55.0

