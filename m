Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC956FC5
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219448; cv=none; b=gRJpOc8ZwrhMNaffR+06K8V0K1tUtvK1AxRrt5e4bqgrZCbkIokZGguQqb4JDaHTUreBCXXnlncgT5s4Xv+Psf6YhOV0c03n2EVE4F0+Jtq1NnQUleOUAtO3+1pi1QhdySGFFtYmXeVJHKEJ1QRo2srJrmbIRTVonXceXecd5Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219448; c=relaxed/simple;
	bh=U1ahZKa16hqOnDL3P+1aupgrE07yFaE70k1xYhVLHhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fRoivf7Hv+LuEUfr9phGsOwM3qUYNI2iIZjod16PCMniltwP2jSPtRxu/L7VPsyKqdPRX2l5lqiVOg4TAZI09tyRegkFHM7DvrU6PpjZD+38UHW9wpYZa+al7wKPMywplL4Mj0NV0LmADefKdPIxyzF2TW/TPQDbqYt9FV37nd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgJ5zCMq; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgJ5zCMq"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-86e6d007703so860811b3a.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790219446; x=1790824246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Ryb3DDC6Bknh6AQJMfPEpwBegzjeZoarmc4S5YO3Ro=;
        b=WgJ5zCMq/JfTNXa0VRFr7v7GLZD+DlTVjw+R8Uj9QQBBYTQ7nwGrkGhKHP52T6WwyJ
         CeXKwVMvY+v1af6nY8k6H8m7QgU9Lk2APTAHT/CRxhy49mO532IVsRKpkqJ1QR4pyaGB
         7hmHHFxLrCfJJBWKOuIjjd4joou3S1fHVWmReqveeyRfBOJxjx1X0sipWK/Gvv+PfjZp
         ZeumJPu15wE+i6vpjyr2/0ZZreFH/VspElpXZFPJfMctJLkHBF8pkkq4bDRPhV8gjcqT
         1hu03ahXvKkuHUoH3BeScKr8P4nLfdn5j0ZWEZQkpcQ0rgjvXoO/LZuZejaWnTwffLJp
         Ba7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790219446; x=1790824246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Ryb3DDC6Bknh6AQJMfPEpwBegzjeZoarmc4S5YO3Ro=;
        b=Rn+NAjOX2kJtV99CBbf1MudVxgMq6BfSr59h/UiRHO7FQ5JfWgnQPuAOZ+griGpnOb
         S1nIJwfTo/HbUrW+aNoKMgfmiCoDrUH9AKCkckrI4PYd/dM67UzdvnoH50BPnRo7/jrK
         WlApFuGYw+q9pa1aDuUduByKMRfEu7zXwojNFrQhXEdwJg8yteNnBLQg1DcYbkCbxEWd
         U5rPabH/3akckG9kHhPe1Ddsi/l9kHxOfos57/9rp9JK9Szze9+PcrRILcjXYTdE58O+
         q1pKd/NF1HIGPUWroApa2xjdVxiy7qgJMoYhKf6fKPz7gI2wp7BdreUxLv4bR8ti/Ejr
         Ekbw==
X-Gm-Message-State: AFuF++kEKNYt92xNJ5hM3/o7v3rMued21COfBAiq5QvjgRKWXiyNmT8j
	tJUwcFzKPWN6w3GPGmHR4iTtlpUDWjHyIRjRWWDrHehEfnozp5efjBkV/FvOeA==
X-Gm-Gg: AYBFou3hh3rQJJdIMHCT2cdVmsKgQvFEGGHRxG64ZMp0wuZhQorndabf3iiOx7Sd+cs
	ksfLA16Dl0WCkq9/dwzWyKcfiZZoxeob0R56HzfGpPixAsIqWf3nIYC0BJmSypF3doGKsBskE6k
	w1qoAKaBDYeTEN1cIq/ta99WsVNI2pa40NPQeFQr05CjtPLeWgMvY5sHe5bkiCz+DxFGZBhK7EN
	27uhoh46ilGFPCEpcqstQZD34sTvee6VJqv6CgDoiTncQVxlM2NaANH2DYMmDVVzvS+O3aZs9nD
	Dty9sqIk9DEhbdI6H5ROw3556GzpyDz1Qdk1oC13VAmrVF6GeVMepYXtXAmjrxoTOy8rSUUOqdo
	xaIzTpkyBhiOfOKufDEGChJEFnPmE4oUPtzrIcBCRfAvrkcf3gid+YYd0+04H7Y60Dxst5kVHgQ
	On2K13YdPqF13hyt8wcwOfH/VARu47H9UI+mSKQsv7Q5F106GhIswND0ZM62N5NaWx7yxGMSJ0G
	wgqfJ9BqlSlg2s5iPH2n312RZt8yoiRnEJDhwzmv4ni13rGJwouEwRcjrhr+2Wr/uu1QfDE+SnB
	8UbeLPcbjmg1tQ+YnbTGOJ2nrWKlRA5R7b+GLfmSlJ1Ll0YB8SHfUA==
X-Received: by 2002:a05:6a00:398a:b0:878:39ac:5a88 with SMTP id d2e1a72fcca58-87e9fe16914mr817815b3a.60.1790219446229;
        Wed, 23 Sep 2026 20:10:46 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1cfbfd11sm2158417b3a.11.2026.09.23.20.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 20:10:45 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 00/17] bpf: Indirect calls of bpf subprogs (callx)
Date: Thu, 24 Sep 2026 03:10:25 +0000
Message-ID: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

v1->v2:
- Dropped "bpf: Don't fold loads from insn_array maps into constants".
  bpf_map_direct_read() rejects insn_array already.
- patch 1: emit the same diag as sort_subprogs_topo() (bpf-ci).
- patch 3 is new: taking the address of a function that is never called
  hit verifier_bug() in jit_subprogs(). Not related to callx, but callx
  makes it likely.
- patch 4: BPF_OP() == BPF_CALL in liveness like in const_fold, explained
  in the comment why slots are live before callx callsite (Eduard).
- patch 5: moved !bpf_is_callx() into nested 'if' (Eduard). JIT support
  is checked before the type of the register.
- patch 6: sync callbacks are in the call graph too. Stack depth of
  a callback whose address is read from .rodata or taken in another
  subprog was not accounted.
- patch 10:
  . check_cfg() explores functions of a table one at a time. It was
    losing changes_pkt_data and other effects of the functions in
    a table that call each other.
  . no cmpxchg64(), it's not available on all 32-bit archs.
  . don't reject the prog that reads a pointer to a function that was
    removed as dead code (sashiko).
  . load of the pointer sets jit_required, so the prog that passes it to
    a helper as a callback can't run in the interpreter (bpf-ci).
  . tbl[i].data at variable offset is a regular load when none of
    the possible offsets overlaps with a pointer (bpf-ci).
- patch 12: append the functions and copy the map only for progs that
  have callx. The rest use .rodata as-is (bpf-ci). Pass token_fd to map
  create. Dropped dead bpf_map_lookup_elem() fallback.
- patch 14: light skeleton reserves fd_array slots only when the object
  has callx.
- selftests: anchored callx_retval_is_tracked to the caller, the tests
  of global func in a table and of const folding of the pointer test what
  they claim now, skip without JIT, fixed ASSERT_GT() of u32 and
  the comment, added tests for the above (bpf-ci). The table in
  callx_rodata_lskel test is volatile. clang was turning it into
  direct calls, so the test didn't test light skeleton.
- Added acks.
v1: https://lore.kernel.org/bpf/20260922011323.1298619-1-alexei.starovoitov@gmail.com/

Introduce BPF_JMP | BPF_CALL | BPF_X 'callx dst_reg' instruction: indirect
call of bpf subprog with address in a register. LLVM emits it for calls
via function pointer. The verifier rejected it as unknown opcode.

Only static subprogs can be called. The callee is verified in the context
of the caller like a direct call of static subprog. No callx into global
subprogs, helpers or kfuncs.

All callees are known before the main verifier pass. The address of
the callee comes from:

- ld_imm64 BPF_PSEUDO_FUNC, which is allowed for static subprogs only.
  add_subprogs() and check_cfg() see them already.

- 64-bit load from read-only data: tables of functions, struct ops,
  vtables, where pointers are mixed with other data. Rust needs that:

    r6 = vtable ll
    r1 = *(u64 *)(r6 + 0)      // data
    r2 = *(u64 *)(r6 + 8)      // pointer to a function
    callx r2

  libbpf keeps the data in a frozen read-only array map, one per prog
  that has callx, and stores byte offset of static function in the prog
  into the pointer. Progs without callx use .rodata as before.
  The kernel guesses pointers by that value before check_cfg() (patch 10).
  Wrong guess is safe. Functions referenced by data only are found via
  func_info (patch 9). After JIT the kernel replaces the offsets in
  the map with addresses. The prog must be the only user of the map,
  since other progs would have been verified with its old content. The
  prog reads addresses as data, so CAP_PERFMON is required.

Both produce PTR_TO_FUNC.

The passes before the main one don't know the callee and treat callx
conservatively (patch 4). The main pass records caller -> callee edges.
Recursion and stack depth checks use them afterwards (patch 6).

In C:

  static const struct shape_ops square_ops = { 1, area, 10, perimeter };
  ...
  return ops->area(x) * ops->scale + ops->perimeter(ops->id);

and

  static int (* const handlers[])(struct xdp_md *) = { foo, bar, baz };
  ...
  if (i < ARRAY_SIZE(handlers))
          return handlers[i](ctx);

plus what clang compiles without data: picking one of several functions,
passing a function pointer into another function.

Patches 1-3 are fixes I hit along the way: a prog without callx that
hangs bpf_prog_load() in check_max_stack_depth(), its test, and
verifier_bug() when the address of a function that is never called is
taken.

Not supported:
- JITs other than x86-64 and arm64. No interpreter support.
- x86-64 with FineIBT: bpf_jit_supports_callx() returns false.
- tail calls in callees of callx.
- pointers to functions in writable data, misaligned pointers.

Alexei Starovoitov (17):
  bpf: Fix infinite loop in check_max_stack_depth()
  selftests/bpf: Test recursion through a global function and a callback
  bpf: Keep functions with address taken when removing dead code
  bpf: Prepare static analysis passes for callx instruction
  bpf: Add callx instruction to call bpf subprogs indirectly
  bpf: Add callx calls to the call graph
  bpf, x86: Add JIT support for callx
  bpf, arm64: Add JIT support for callx
  bpf: Discover subprogs described by func_info
  bpf: Recognize pointers to functions in read-only maps
  libbpf: Support pointers to static functions in data when linking
  libbpf: Resolve pointers to functions in read-only data
  libbpf: Treat .data.rel.ro as read-only data
  libbpf: Support pointers to functions in read-only data in light
    skeleton
  selftests/bpf: Add tests for callx
  selftests/bpf: Add tests for callx through pointers in read-only data
  bpf, docs: Document callx instruction

 Documentation/bpf/clang-notes.rst             |    7 +-
 Documentation/bpf/linux-notes.rst             |   31 +-
 arch/arm64/net/bpf_jit_comp.c                 |   16 +
 arch/x86/net/bpf_jit_comp.c                   |   68 ++
 include/linux/bpf.h                           |   10 +
 include/linux/bpf_verifier.h                  |   42 +
 include/linux/filter.h                        |    1 +
 kernel/bpf/backtrack.c                        |   20 +-
 kernel/bpf/cfg.c                              |   76 ++
 kernel/bpf/const_fold.c                       |    6 +-
 kernel/bpf/core.c                             |   12 +
 kernel/bpf/disasm.c                           |    5 +-
 kernel/bpf/fixups.c                           |   94 +-
 kernel/bpf/liveness.c                         |   38 +-
 kernel/bpf/verifier.c                         |  714 ++++++++++-
 tools/lib/bpf/bpf_gen_internal.h              |   13 +-
 tools/lib/bpf/gen_loader.c                    |  172 ++-
 tools/lib/bpf/libbpf.c                        |  443 ++++++-
 tools/lib/bpf/linker.c                        |   18 +
 tools/testing/selftests/bpf/Makefile.skel     |    2 +-
 .../bpf/prog_tests/callx_func_ptr_map.c       |  202 ++++
 .../bpf/prog_tests/callx_rodata_lskel.c       |   63 +
 .../selftests/bpf/prog_tests/verifier.c       |   12 +
 .../selftests/bpf/progs/callx_rodata.c        |   51 +
 .../selftests/bpf/progs/verifier_callx.c      | 1039 +++++++++++++++++
 .../bpf/progs/verifier_callx_rodata.c         |  846 ++++++++++++++
 .../bpf/progs/verifier_global_subprogs.c      |   31 +
 .../selftests/bpf/verifier/basic_call.c       |    2 +-
 28 files changed, 3913 insertions(+), 121 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
 create mode 100644 tools/testing/selftests/bpf/progs/callx_rodata.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_callx.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_callx_rodata.c


base-commit: b4d936547f5a3ca5563f48ee81f153c928336027
-- 
2.55.0

