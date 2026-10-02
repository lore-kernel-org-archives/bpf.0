Received: from mail-pz2-f36.google.com (mail-pz2-f36.google.com [74.125.228.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF297E0E4
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945239; cv=none; b=EU/t7zngLyIiBKIbno81PR+fJJF7t0hCKcELXG/MiYWbMoftIS9qH0lW5965y+OyCD1BfXp3RBnxP3AZdR5/wguLSBju8Rdq9Sqejq8OUXFk9yz0xuBG8xsdA+IF4FxeLDEwLeJDCI1axXI5750jtSJRswY4kAwtnFJhQw/WqpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945239; c=relaxed/simple;
	bh=3R4uZR0oFwkdqtx1Z/4iaTOIJkIRsp7nqh5hSEgZJ+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TNRp925NYhrX5R2fazsXFUirmOtiEckyKzOMk7x9TfcZqrdvaJP98sijE2Ufeu5n3cEZyfLff4q/k4LRVLAE4y3wYFJkiRHF3S7rVgeelxKaORJe56badtbBaa26XbyaZPLjTP0cMTFQ9VRPm55dMJm8LtT8q+gSzy+GM9CRbsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8q93WUk; arc=none smtp.client-ip=74.125.228.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8q93WUk"
Received: by mail-pz2-f36.google.com with SMTP id d2e1a72fcca58-888caa81e9aso781177b3a.0
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 05:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790945237; x=1791550037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nSuTh2/u82i57CxX09LrjJWb8l4g7UjOFROGP7pqyGE=;
        b=G8q93WUkE+Irtk5EWJg42HVDzQClLfkBFBrFBYTXbGRE1JLfpjB/deN9s0KJbdzHwS
         SKijcQI6i+qsR/QREigbvPTKpRexBYx782Qy/gv2lGgpYZlq/tRvA1jUCXB1ztQGyRm/
         q4E5OW6XjZAB4XrJ1lXrABAEsQQ24RjyhM6gv0Tezq2i7i3qofb7PtUAPoXIyJa6JXcm
         iKPvGLwCkNI3ZmU8AwGwB8uFYWbyedIEexcdDfvwe6H3496PAWnmn2eRZdU02GAEkGdw
         ZIN9ofN6DD0NC9sHYmJYeOUIbVt94cvMya9rxEff+76eLDwNNe210LDkbPWaa4iyhO8S
         P/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790945237; x=1791550037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nSuTh2/u82i57CxX09LrjJWb8l4g7UjOFROGP7pqyGE=;
        b=ew0f3i/L+y+RlpKPbdxRYEY31jCmFM2cIKjlBGETE5cmdL85A6Aci1NclpMOxFqL8B
         u7I448MnmwCkSyLXuZ5wI0bZ4CaaSLb/7nWjvJUHl5XJBPBSjdeSe31OhfmefgmAzhwO
         j0Q6ymcyTSyaPBPqjUiZY94vy9lzCWZbuJ/sGTddDP6/paKZN9cbpbONEreg42u0X6jC
         GN9ul1V4lEr+0Dxe/9gi9wOmd+u57BSaHbrMTni07JpBZGsxCuIQviTcqL6HXe7DMeiB
         4wsw1e3UeEVyhGGKl6TphC0yEDZsWwcBbqA1XL8t697PSkXX7ki5sNqbr6vyENSZwJT2
         ENGQ==
X-Gm-Message-State: AFuF++n216udeE/x625YRSza4hxvZC053imXskrf+piyFR9KuPB5rUQ8
	H0RfV6S9DWiQ25Y7emo+3PeYUbwfF66J5W7VRqr4djZJ4FEVDVOj2dvROx3r2DOIdJE=
X-Gm-Gg: AYBFou0Tka7vqI67Y5nq6B4dMpkxQ+XreWny+943miXPHHb62iqmgMhKb+xAq4BzLUL
	BHxxB2jV99sbu8uKZES4nl5O1W9O5p09tad/heTGalPphk6ARm/K3PBKr5yrqNGH4p++k6dZJ4d
	eSLTn5S394+lGO7hB9Zv1PTtYa13DkjOxR+p5vmMEEZldPf3IElcn0RDd8GeZ6cjv91sG1RqXI2
	Grrjgv74sOJdr36YGYhc5TU/L5bWwFmH0lSvyyok7wGX5zLTAQvbRAe41ZNrTJlIDEFXJ+0AkHL
	9SaLeY0Cd+IJp1k/lZGRRVzjcQsDDWFwcm8T7sWspAvE7XBCSpDMdXxErNnSfhaq8VeZvj5pPxB
	+SJiXuY318ilnXCQWjERnVSyYDUv8dZJsYey0WItzuRPddfyKeXEv2PMWRQj7iS8lHK+PO69KdZ
	V7HBz7XQBpFz8mQGsufk4g6J/YpT3LBAUqaeQ2TASqpjDaSrIFnKk9v4OwWSw1Ff1LkHxV8bFHx
	9RbSZ/hRYS4llgt21vPRlMIDJ8PSkORI5+LStaX9GVV13KnuKFvd86Rv7TURaDI32Hn+uEMyUjQ
	mWAU2zSYIPuXt28DmZVN3cibLvrxR1IrDz0OjUApxyE=
X-Received: by 2002:a05:6a00:3388:b0:886:5938:cdd4 with SMTP id d2e1a72fcca58-88af5116b11mr2723872b3a.19.1790945236479;
        Fri, 02 Oct 2026 05:47:16 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0c3a3003sm845398b3a.29.2026.10.02.05.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:47:16 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 00/15] bpf: Support programs compiled by rust-bpf
Date: Fri,  2 Oct 2026 12:46:59 +0000
Message-ID: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
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
Patches 5-11  Accept BTF of Rust programs in the kernel: names of types
              and functions that are not C identifiers, arguments of
              static functions without names, a variable in DATASEC
              that is smaller than its type. bpftool doesn't read
              past such variable.
Patches 12-14 libbpf: Keep .data, .bss and .rodata in arena when
              the object has .arena.data section and load its programs
              with BPF_F_ARENA_SCALAR. Format strings of bpf_printk() go
              to .rodata.str, which stays a map.
Patch 15      A program in Rust, built by upstream rustc, that shows why
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

v1 -> v2:
- Rebased. Added Acked-by from Alan.
- Patch 6: the test is serial, since other tests set bpf_jit_harden and
  programs are not in kallsyms then. Use kallsyms_find().
- Patch 8: add comments and a test for vararg of a global function (Alan).
- Patch 10: new. bpftool map dump and bpftool prog show read past
  a variable in DATASEC that is smaller than its type.
- Patch 11: check bpftool map dump.
- Patch 12:
  . fix overflow in the check of r_offset of a pointer in data.
  . __arena variables in an object without .maps section were placed
    over .data in the arena that libbpf creates. Fail the open.
  . pin_path and bpf_map__reuse_fd() of the arena were ignored when
    there are pointers in data. Fail the load.
  . don't create the arena when its autocreate is off.
- Patch 14: tests for the above.
- Patch 15:
  . skip the test when rustc is older than 1.87 and when clang is older
    than LLVM of rustc, instead of breaking the build.
  . the exit status of rustc was lost in the pipe and clang made
    an empty object. Go through a file. Follow BPF_STRICT_BUILD=0.

v1: https://lore.kernel.org/bpf/20260930193127.2181684-1-alexei.starovoitov@gmail.com/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (15):
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
  bpftool: Skip pieces of variables in DATASEC
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
 tools/bpf/bpftool/btf_dumper.c                |  11 +
 tools/bpf/bpftool/main.h                      |   2 +
 tools/bpf/bpftool/prog.c                      |   4 +-
 tools/include/uapi/linux/bpf.h                |   6 +
 tools/lib/bpf/bpf_helpers.h                   |  18 +-
 tools/lib/bpf/libbpf.c                        | 433 ++++++++-
 tools/testing/selftests/bpf/Makefile          |  12 +-
 .../testing/selftests/bpf/Makefile.buildvars  |  25 +
 tools/testing/selftests/bpf/Makefile.skel     |  18 +-
 .../bpf/prog_tests/arena_scalar_blinded.c     |  21 +
 tools/testing/selftests/bpf/prog_tests/btf.c  | 132 ++-
 .../selftests/bpf/prog_tests/btf_rust.c       | 142 +++
 .../selftests/bpf/prog_tests/data_in_arena.c  | 216 +++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/data_in_arena.c       | 107 ++
 .../selftests/bpf/progs/data_in_arena_decl.c  |  37 +
 .../bpf/progs/data_in_arena_extern.c          |  20 +
 .../selftests/bpf/progs/data_in_arena_fail.c  |  20 +
 .../selftests/bpf/progs/data_in_arena_nomap.c |  20 +
 .../selftests/bpf/progs/data_in_arena_rust.rs |  70 ++
 .../bpf/progs/verifier_arena_scalar.c         | 912 ++++++++++++++++++
 .../bpf/progs/verifier_value_illegal_alu.c    | 173 +++-
 tools/testing/selftests/bpf/test_loader.c     |   2 +
 33 files changed, 2500 insertions(+), 101 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_scalar_blinded.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_rust.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/data_in_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_decl.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_extern.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_nomap.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_rust.rs
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_scalar.c


base-commit: b5a4aa31abd6fe90009b63e35dc18c67d041ec0c
-- 
2.55.0

