Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808603;
	b=XWeHKUpTIQiBTftLMqH/XqxUiF9Wfy8VEg0cGLJT8mOJO24UbRxxC8AfF7LbB6UO4FpJ
	 SLnvfs0mfYVvsY89FUcoqpMCP/0glxPSw8BU1oxfxn/FxC8K5Ye5k4KLvCutfH4CsGCq9
	 huzHtlnEMb7B4qYtsTDbbNAVqYid8nxrE9GEk5H530ETM2DlG4Yu+XG5WqnWhJrJZbTyD
	 nGKEMyFSgq24UhG/C6vDSUf0v4xvXqbpFiTEgtvGkAoS+VFYYP8imdpC6hqF+IROnfIiY
	 5vu4qZHGM9YJr1oAC2vqYqYKQAc+IiLfrN8zjpCZn74OxeOd3+glL9IMtuYScVwBVfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808603;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zPBHUJ/Hzx39hcIPzz3nklb+JIQh0JAnRrB9DAkFVxI=;
	b=bNtzgDOtQHOu86Hbww1FzYrXdaUBI4ygjVBlid6eN7NtUC9LiWVL/Mq4g8nKA5aWgi46
	 JlRWp06mDs3caq/cYwpoJHGKZ0I1RZLZPn1uaoD3/UCEVZfYt0M7JGSLKWVmEXF4r+O3C
	 DYCVEqBbUjLwrPymYGUgzO3OnLPgC6/hHCSEC/raoccT0aL1hwRFnsX/oSHw8UHLUuvVb
	 OF6PR9+XIo4FYJhgPgedbsXWo3mLdH4kqD3LYFSoWml9HcOcOaXN+lUmkcReHwVtI4tmk
	 zxdkQaejeKl35aTEbb2p2d8wsiWOFmg6wZSrhuDZRgBVsar+2d/2lu7IqQobAzD6cXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aGDeNIUW;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF88606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 05:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDF88606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aGDeNIUW
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e9ae391a05so17147725ad.1
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 21:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794808602; x=1795413402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zPBHUJ/Hzx39hcIPzz3nklb+JIQh0JAnRrB9DAkFVxI=;
        b=aGDeNIUWIz2+vTds2q1UXSC7AfbetpLIruBMxC1okv1ub0LNxtLtzyYoSrXj59yAMV
         BPS+EXKG1FLmVD5haEbIWX3wPKVAjkUbU9C28N3kWNTbXETsrqo7iaP2DDD0AoSYCGUl
         dUM/A0qsJnxi62fJ6mZaOrTueVILVGpk84eTKQJMXDfAipJGxv0fQDzFKtC69GAzRMFd
         6UxHws6kPjjy1vLgttDCmY0Da07y3e0lPmWsXS0pye/PGCNLwb45FN6MR9qVEDPmkXeS
         6wnRi0wVKECJmePXrNbtNCdOzuVy1q7paHNSBP9ezt1Y21k22qoYM7UGI37fldneDbz+
         oY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794808602; x=1795413402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zPBHUJ/Hzx39hcIPzz3nklb+JIQh0JAnRrB9DAkFVxI=;
        b=iZpBnc8CJaFtC8xQT9ENSyqUoJrnugn6HMy3qhAH2hgIWuEbDfvW25uT08AluclBzx
         dfqai8B7hig73FrbZzr7AiL4/Hmb3bjXzJ3p1h98e/whD1tnYz+NAGinwZX24EjR0qMp
         D2V4K4FxvSOO6ybXD/tIo6xmPVtq5LcA1piIHdPQsqodvdkSBkIGr0ARZNHftatQKQDf
         v7nH9td8+ywvoqtSjwYeMYs+CEVM/WTAJ5t4OYsjapTBzhroiYxZ0TswAgyKXk1OHvlt
         bm8n1+Lp0Mn679+A3nu2ixsqd6Pf9yghAutpZ0zvQQdGv1Q4e1EhdoCc7NdNqT9bbGBq
         qtEQ==
X-Gm-Message-State: APuU4Z9DlHvAhv2vqFP9QXUkAM7EByfyJfXJy6wj0978ebBYv8itajeB
	UgG6sQYmq9k66VIX7gxNCNaC4Tu/DnwKE0JzoFbxI/XlTCNTHALLWPusMrXj3A==
X-Gm-Gg: AZFdTZdnKayiJ7sn7ffT5D9Hx5f+Vlx4A+pgXUz1SIFL+r7u3AmkzdJL+4gE9jmXk2L
	jpt6JHw2pS5S93SriDyP/f/8ix/wsC87kegJlND869U++1sSJvJZLHRfYXTi3Dt7vp97Hb70+G/
	8DV/nFjF3DJ3bD8vkY2VCaO4H1fdLYUuQ49HKmS6aOyJeC4vMaOaEhl5KIwYrDZsFj1xQaMzMsC
	5oKFikB/H/LsDP8Sc4WcVaLbXK9krUsQpa54lPi5z65ktEEy8jtNunlsCiZ/luy1TKcP24UEHLZ
	xkBpFDPdcb8HVruHkKFg+/ubUDKfQLsU1mCtQVk/3Rj6W2w/rbcPZnEFGEsAtkE/8ydw7kqQoTz
	Ya3AxhL8yVVi9+o/ZKV3Kky5pin+2+B7eGeSByzdbwPR0ebI/GdAPKCCIiC20LJDHWxwgATQ/pZ
	nDORDKhOiKysbAdAK6oCEuFBwMcx07OTAvkFLBr07lFFQfpVTS/DpzrwLWTwv+G28hRyU/4UfAB
	EE8TtYHB6plD9JexeazpZ4WUAhmJq/Wvi2aGVk0VsnYAwiHtvVyHPnvXRiKXH2XzlZIT9Q7ph8i
	TpeMlyCJ/LtEYb18TtxfEyX0nsODu/Y41hy8RXWGvz/baf3NT/TysEW12zDY1TnGl4ZWa/X0pet
	cOoPqngHnGkkHsa0T3ycvKvwHaUZREG+2zyKFWu0az9KmIycaXk4/j/GlWG05S32CTXRRflrzM7
	o3Ci5gj2xzdlKiNwZMyPc=
X-Received: by 2002:a17:903:1b27:b0:2e9:5313:8f7b with SMTP id d9443c01a7336-2edf1e7b4eemr96102805ad.9.1794808601767;
        Sun, 15 Nov 2026 21:56:41 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f75b45csm33101215ad.14.2026.11.15.21.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 21:56:41 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 00/21] bpf: Remove the limits on maps, kfuncs, subprogs and special fields
Date: Mon, 16 Nov 2026 05:56:17 +0000
Message-ID: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

In short: the verifier keeps the maps, kfuncs, subprogs and special fields
of a program in arrays of a fixed size. A safe program that needs one more
entry is rejected. With this series the arrays grow with the program. What
was quadratic or worse below a limit is linear or n log n now. Outside of
tools/ the kernel loses 302 lines.

                                                 today       new  patch
  maps of a program                                 64  no limit      7
  BTF objects of a program                          64  no limit      7
  entries of fd_array                             4096  no limit      7
  kfuncs of a program                              256     65536      9
  module BTFs of these kfuncs                      256  no limit      9
  tables of functions, for callx:
    pointers in all maps                       1048576  no limit     10
    pointers in the range of one read             4096  no limit     10
    functions that one read can give              1024  no limit     10
    sets of functions                             4096  no limit     10
  subprogs                                        1024  no limit     16
  special fields of a map value                     11  no limit     17
  special fields of an allocated object             11       512     17
  bytes of a name in BTF                           512      4096     18
  insns under a jump, with those that the
    verifier adds                                32767  no limit     12
  insns of a program that bpftool can dump      524288  no limit      5
  maps of a light skeleton                          64     see 7     11
  programs of a light skeleton                      32     see 7     11

A table of functions is an array of pointers to subprogs in a read-only
map. A program reads a pointer from it and calls it with callx.
A special field is a kptr, a bpf_spin_lock, a bpf_timer, a bpf_list_head
and the like.

1. Why?
None of these numbers protects the kernel at run time. Each is the size of
an array, or it hides an algorithm that does not scale. Such a limit is
raised when a real program hits it. Rust crates did that to two of them:
commit 70bcb39a7392 ("bpf: Bump BPF_MAX_SUBPROGS to 1024") and commit
3f4f430fa1b2 ("bpf: Allow BPF_MAX_SUBPROGS targets of a read from a table
of functions"). Real code is near the next ones:

  subprogs       777 of 1024   the program of rust-bpf [1] in the first
                               commit
  name in BTF    429 of 512    a struct of scx_lavd in rust-bpf
  maps            41 of 64     obi_continue_protocol_http() in OBI of
                               OpenTelemetry

And it is over the limits of a light skeleton:

  runtime-security.o of Datadog   627 programs   151 maps
  tracee.bpf.o of Tracee          169 programs    87 maps

The author of a program does not choose the number of its maps. Each
.data.X and .rodata.X section is a map. Each jump table that clang makes
from a switch is a map: with -mcpu=v4 bpf_generic_uprobe.o of Tetragon has
19 of them next to its 66 maps.

2. What bounds BPF_PROG_LOAD now?
  size     1000000 insns of a program and 16 MB of BTF, as today.
  memory   memory.max of the cgroup of the task. There bpf() returns
           -ENOMEM. Today the OOM killer ends the task (patch 2).
  time     A fatal signal ends each long loop. The freezer does not wait
           either: the task freezes, then bpf() starts again (patch 1).

A large program also has to get to the end of BPF_PROG_LOAD. Today each
signal ends it with -EAGAIN, and libbpf gives up after 5 tries. A task with
a profiling timer of 10 ms never gets through a BPF_PROG_LOAD of 11 ms.
With patch 1 a signal that does not kill waits for the end.

The limits that hold at run time do not change: the size of the stack,
32 frames, 33 tail calls.

3. What had to scale?
  patch  question                  today                 new
   8     dump: which map is in     look at all maps      maple tree
         this ld_imm64?
   9     is this kfunc known?      sort at each new one  hash table
  10     is this set of            look at all sets      hash table
         functions known?
  13     who calls whom, over      matrix of bits,       lists of edges,
         any number of calls?      n^3 / 64, two times   nodes + edges
  14     what does a table of      walk its pointers     one node of the
         functions call?           at each use           call graph
  15     which decl tags has       look at all types     a list per type
         this argument?
  17     which special fields      enter a struct for    enter it once,
         has this type?            each member of that   copy its fields
                                   type: members^depth
  18     is this name valid?       read it for each      read each byte
                                   type that has it      once
  19     which insns dominate      quadratic             n log n
         this insn?

Three small tools carry most of it:
  bpf_table_next()        an array that doubles                   patch 7
  struct bpf_index        hash table, key -> number of an entry   patch 7
  struct bpf_call_graph   lists of edges, sorted once: callees    patch 13
                          first, the nodes of a cycle in a row

4. Far jumps
A conditional jump has an offset of 16 bits. The verifier adds insns under
it: inlined map lookups, checks of divisions, may_goto, constant blinding.
Then a verified program fails with -ERANGE. 2979 map lookups under one
branch are enough. Patch 12 does what an assembler does:

  if r1 > r2 goto far    ->   if r1 > r2 goto +1
                              goto +1
                              gotol far

Where all jumps fit, no jump changes. The passes in fixups.c do not compute
offsets any more: bpf_patch_list_build() does it for all of them.

5. Fixes
  3  A syscall program and the target of its tail call get the same
     context. Its size is compared with the first program only.
  4  bpf_loop() is inlined with a call of its callback, also when the
     callback is removed as dead code.
  5  A program of more than 524288 insns loads and cannot be dumped.
  6  btf_resolve() does not see a type that holds itself through
     ptr -> typedef -> array. Only the limits of the later walks end that
     loop, and patch 17 removes one of them. With patch 6 such BTF is
     refused.

6. What else changes for users?
 - The rules on calls look only at insns that the main pass has seen. A
   call, a tail call, LD_ABS or bpf_throw() in dead code rejects nothing
   (patch 13).
 - A map value with 12 kptrs had no struct btf_record at all. It has one
   now. So the map needs CAP_BPF, and it cannot be mmaped or
   BPF_F_RDONLY_PROG (patch 17).
 - -ENOMEM in front of the JIT fails BPF_PROG_LOAD. There is no fall back
   to the interpreter (patch 2).
 - The loader program of a light skeleton gets -EINTR from bpf_sys_bpf().
   It got -EAGAIN (patch 1).
 - An extension that does tail calls cannot attach to a syscall program
   that does none (patch 3).
 - The tags of subprogs that make calls change, and so do their names in
   kallsyms (patch 16).
 - x86-32, riscv32, parisc and sparc64 have no gotol in the JIT. A program
   with a far jump is not JITed there, like a program that has gotol in
   its source (patch 12).

7. What stays?
  65536 kfuncs             JITs find a kfunc by insn->off: 16 bits.
  4096 bytes of a name     A search by name takes types x length.
  512 special fields       An allocated object has 4096 bytes at most.
  4096 entries of          For unprivileged programs. They have 4096 insns.
    fd_array
  10000 chains of calls    In the analysis of stack liveness.
  32 levels of types       In btf_resolve().
  64 KB of context         For the loader program of a light skeleton:
                           16 bytes for a map, 4 for a program.
  bpf_flow_reset()         It looks at all insns after each global subprog.
                           A fatal signal ends that loop.

The tests are in the patch that changes the behaviour (7, 10, 12, 13, 17)
and in patches 20 and 21. Where a program above an old limit can be unsafe,
an unsafe twin of it must fail.

[1] https://github.com/4ast/rust-bpf

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (21):
  bpf: Stop a load only when the loader is killed or has to freeze
  bpf: Fail the load when there is no memory
  bpf: Give a syscall program the largest context when it does tail
    calls
  bpf: Do not inline bpf_loop() when its callback is dead code
  bpf: Dump programs that have more than 524288 insns
  bpf: Resolve BTF structs and arrays first
  bpf: Remove the limits on maps, BTFs and fd_array of a program
  bpf: Do not scan all maps for each insn and each subprog
  bpf: Remove the limits on kfuncs of a program
  bpf: Remove the limits on tables of functions
  libbpf: Size the tables of the loader program from the object
  bpf: Relax jumps that patches push out of range
  bpf: Keep the call graph in lists of edges
  bpf: Find the effects of callees on the call graph
  bpf: Link the decl tags of a type
  bpf: Remove BPF_MAX_SUBPROGS
  bpf: Walk each type once when looking for special fields
  bpf: Raise the limit on the length of BTF names
  bpf: Find dominators in O(n log n)
  selftests/bpf: Test programs above the old limits
  selftests/bpf: Test limits of the load with raw programs

 arch/sparc/net/bpf_jit_comp_64.c              |    7 +-
 arch/x86/net/bpf_jit_comp.c                   |   12 +-
 include/linux/bpf.h                           |    5 -
 include/linux/bpf_verifier.h                  |  162 ++-
 kernel/bpf/btf.c                              |  503 +++----
 kernel/bpf/cfg.c                              |  428 +++---
 kernel/bpf/check_btf.c                        |   13 +-
 kernel/bpf/const_fold.c                       |    8 +-
 kernel/bpf/core.c                             |  368 +++---
 kernel/bpf/diagnostics.c                      |    8 +-
 kernel/bpf/fixups.c                           |  702 +++-------
 kernel/bpf/flow.c                             |   99 +-
 kernel/bpf/join.c                             |    2 +-
 kernel/bpf/liveness.c                         |   66 +-
 kernel/bpf/log.c                              |    2 +-
 kernel/bpf/loops.c                            |  189 +--
 kernel/bpf/scev.c                             |   32 +-
 kernel/bpf/syscall.c                          |  125 +-
 kernel/bpf/verifier.c                         | 1159 ++++++-----------
 net/bpf/test_run.c                            |   20 +-
 tools/lib/bpf/bpf_gen_internal.h              |    3 +-
 tools/lib/bpf/gen_loader.c                    |  157 +--
 tools/lib/bpf/libbpf.c                        |    8 +-
 tools/testing/selftests/bpf/Makefile.skel     |    2 +-
 .../{blinding_log.c => blinding_far_jump.c}   |   38 +-
 .../selftests/bpf/prog_tests/fd_array.c       |   36 +-
 .../selftests/bpf/prog_tests/no_limits.c      |  457 +++++++
 .../selftests/bpf/prog_tests/verifier.c       |    4 +
 .../selftests/bpf/progs/cpumask_common.h      |    3 -
 .../selftests/bpf/progs/cpumask_failure.c     |    5 +-
 .../testing/selftests/bpf/progs/many_progs.c  |   36 +
 .../bpf/progs/test_global_func_deep_stack.c   |   12 +-
 .../selftests/bpf/progs/verifier_and.c        |    2 +-
 .../selftests/bpf/progs/verifier_bounds.c     |   14 +-
 .../bpf/progs/verifier_callx_dead_cb.c        |   60 +
 .../selftests/bpf/progs/verifier_callx_many.c |   31 +-
 .../selftests/bpf/progs/verifier_movsx.c      |    4 +-
 .../selftests/bpf/progs/verifier_no_limits.c  |  223 ++++
 .../selftests/bpf/progs/verifier_patch_list.c |  137 +-
 .../selftests/bpf/progs/verifier_tailcall.c   |    4 +-
 .../selftests/bpf/progs/verifier_unpriv.c     |    2 +-
 .../selftests/bpf/progs/verifier_unwind.c     |   30 +
 tools/testing/selftests/bpf/verifier/calls.c  |    3 +-
 43 files changed, 2900 insertions(+), 2281 deletions(-)
 rename tools/testing/selftests/bpf/prog_tests/{blinding_log.c => blinding_far_jump.c} (51%)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/no_limits.c
 create mode 100644 tools/testing/selftests/bpf/progs/many_progs.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_callx_dead_cb.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_no_limits.c

-- 
2.55.0

