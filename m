Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793502314;
	b=KJgvRLtBBIG+SEVGLklO58MJo98vjD4pGLIVTN8bw9w8g/GBQGkBns0dqBgNdW0vld4l
	 grpmwSRuf8ld6NO9FOPfuX4a3aALnysF/8DnBMIHpOcRfsuWNu0R12HaFdtOXEX0UrqJY
	 IxJgkTzszCheacBCIdkPlRMgLc5joIqxgz/hfO44kKmWI+HcPP0oxB27QI6l1iF0vDFRp
	 859nXL303HtIgYxT8g7RF+7m09uEw7Vs/sNL/DZMZvGrbQDEkoNOPwwqEB8A4gHpGKpU/
	 plV0QLMgEGpUy7YHIIjSIbAjQiU+zOkEu6ID0Yn/UOxDQTPCyrZ5SuNgp/qLUm94+2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793502314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zCoRIXzh+QRcYajYEJShNAnBrjzLbTk3SnZKwcVdPz0=;
	b=cl7BBePBkpJk3yNFogC0xH7Vp5Bs0vYbDyyS1IHiniCbmEbfhHqb77rK2t3AY7OUtNVv
	 gjpRonH3nVWYhtUJi6U/T/tWAm35zYKR3qs75dbHxi5L8ZEZ2xcBtjHo1Z2EJu/Rol3o+
	 FIac+995rUUbxR4qXS+XfOIu/MuKg4Y/CcC2sUmQij8LssqZ0IdxlQSZXdC8D62GDnPrW
	 cL6kBrnoEBUsYvPVEBQ+xE3Qj2Ipr66jTO05K8drbvRhmAZJCgNdJ9W96YNRcbXWlj1G6
	 YwwDdVEKQghEDDh74nhHKEN/0xqdTnoqPcB4zoiZnt2lwAO6dG2HSDb3qkfbcjak1yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M76gLLx+;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF1A606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 03:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAF1A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M76gLLx+
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdaefe02d5dso1030708a12.1
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 20:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793502313; x=1794107113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zCoRIXzh+QRcYajYEJShNAnBrjzLbTk3SnZKwcVdPz0=;
        b=M76gLLx+MzINGk1awe+InNqtbZD0PoVL8nUo03Wser5nfDfFfwsyGKXjQjWRigTTlf
         puoI34gi86esxdspRSx1LnqoNvY1OJGk5fL6F7x4aPVIxji2nABVtFN54vxe3nOBzjfN
         08g3AwulOmDdZL0Cy2128enuF3CqfL1EVUSYr/+sawau8z35Q4GbJ/JusZoe3b6FrZsJ
         sWXddO3aIhz2OVxn25c7QBQMEJa6rgsg4qNcqeP7Y35AvBBKAq4+Ypz33B3ovP206zED
         iEn3di9vUEf7oCE4ryk+mEdBv8BR/EMMChH4L5GNiThQfT7T2UrwOf3pzNojBSMbtyMH
         veug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793502313; x=1794107113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zCoRIXzh+QRcYajYEJShNAnBrjzLbTk3SnZKwcVdPz0=;
        b=rIKLRjPFMKd2EVW2E6nHJmKgajdjPQBJ70QKQu86SwrhdEuukOC11xDwpfYA90gsIz
         HAM/2TaA+Wh+R0YOIv5OSIUNdJ+67TqZSuA3JT8D5y23MD41xk59koKu/g09tnfyB6Gb
         Re++FaSITGR46hXGJUE4kVgUOKRqWgmrJMh8/hkK25nO4YRcS35KZ5RTB9CuuCBxvDfP
         rMWvI2WxMtkSVCGed5ytR/YVajmJJr/nF3zVFWPYhyQCIneJaifxPKJH1CQLA97gGAmC
         n3FRi2LsPLZMePZMvXnOKb8TNmHny/fsiCSlou8anvf4FKrG0m7Lu1RByTK//+nmUa/B
         TzOQ==
X-Gm-Message-State: APuU4Z8zbQSCmOn4G5ZJ4pg3oRl8xL6NC+SPH69MawWbvGjF2tRhrtG3
	fmvg4VAvYA98vxmkIz5GVekiUIREQhPU2ib+yE/TaI4l04IyBZv7hzsHfUqXMQ==
X-Gm-Gg: AYBFou02F6Blf0pG1ZTkJ14ngJcJPzxL6+nXiDRgVy9zzxU9uhFGIUnHLlLQ3RqVase
	xo3FNDh3h6Cq5RhYwDINfBI03C6HFGUI08FSvet12evalsz4ATtXfYZzJFA+p7ryd22ziqcWyBb
	vmfwveoNKEBDj7rXpO/33HqwHy41y7RSkt+NPHnYZBLHGsCWNdR75Yqhll5WLXZYm0e7lKp1Ilc
	wg4jwE7XEIMQNNj64gRnal9qX/sSTNzXlyr6AQiD3mcXQmMQwg4ZgDyyULcuMRJbIK1AiSJDuXl
	nkdbgWY6fiYBwj9ddTW9rYnlRAqiJrg4GYJ0sgmTkiwK050g/yoNmGr7aS83nXNu3PVmzrFk9/J
	90KnYjKh12TrEw0/bTBW1A3oSxMOid8KNewQBx2MIpeN/L12N6CACS6susqgzmKIy3x8nb8HE0Z
	cLPWZyyxQCIwconfnx4FeRSv/qZKws/uubmoUQMU9s1Cod3qa+Phqf9rTYG50KEixxuWZoTDwBP
	uoac91YJVlowWUF3x8Dy1XaUFlucH8WJSI74m3mITI5PHXFvla7nsuRke0GVIMhGlaI7t5NVo9j
	YXbh4RuwnqJH6IHpSQi2h2UvnKsSaEjHf6yd2zlES9i8Q9bBlaTOB+ukdLBO8C8RDP5sjR8OzIp
	eoXr3VHwwusfnjYjPciLbWLC16aY1nbMQdE9ojl8o7qtVrJ+cHWHys9g7sPr4dmhJf2lNajsbLA
	==
X-Received: by 2002:a17:90b:2805:b0:3ad:adfe:5854 with SMTP id 98e67ed59e1d1-3ae89817e7amr5604105a91.40.1793502312772;
        Sat, 31 Oct 2026 20:05:12 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9583c1sm14389907a91.10.2026.10.31.20.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 20:05:12 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 00/14] bpf: A stack in arena
Date: Sun,  1 Nov 2026 03:04:56 +0000
Message-ID: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
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

The goal is to load Rust programs as rustc and LLVM compile them. The test
programs are in https://github.com/4ast/rust-bpf

This is part 2 of "bpf: Stack in arena and a verifier that joins states"
[1], as a series of its own. Part 1 is merged. This series does not depend
on part 3, and it does not change the main pass of the verifier.

The problem
===========

A Rust reference does not say where the object is:

  struct Node<'a> { val: u32, next: Option<&'a Node<'a>> }

  static IN_RODATA: Node = Node { val: 3, next: None };

  fn sum(mut node: Option<&Node>) -> u32 {
      let mut sum = 0;
      while let Some(n) = node { sum += n.val; node = n.next; }
      sum
  }

  let heap = Box::new(Node { val: 20, next: Some(&IN_RODATA) });
  let local = Node { val: 100, next: Some(&*heap) };
  sum(Some(&local));

sum() reads the three nodes with the same two insns:

     local            heap          IN_RODATA
  +---------+      +---------+      +---------+
  | next  --+----->| next  --+----->| None    |
  | 100     |      | 20      |      | 3       |
  +---------+      +---------+      +---------+
       ^                ^                ^
       +----------------+----------------+
                        |
          w0 = *(u32 *)(r1 + 8)      n.val
          r1 = *(u64 *)(r1 + 0)      n.next

These two insns must work for the three areas. Hence the decisions:

  step  memory               where  why
  ----  -------------------  -----  ---------------------------------------
  1     heap                 arena  The prog allocates it and links it with
                                    plain pointers.
  2     .data .bss .rodata   arena  heap.next is a load from arena, so it's
                                    a number. A number can be an address in
                                    arena and nothing else.
  3     address-taken local  arena  r1 is &local, then heap.next. One insn
                                    has one form in JIT.
  4     the rest of the      r10    The verifier doesn't track arena, and
        stack                       user space writes to it.

The size is the second reason. Rust progs routinely need 32 Kbyte of stack.
The kernel stack cannot supply them. The private stack has one frame for
each function and cpu. Thus it supports neither recursion nor a second run
on the same cpu.

The patterns in real code that the tracking of the r10 stack cannot handle:

 1. One insn, two kinds of memory.

      sum(&local_array)     r1 = fp-64    --+
                                            +-->  r2 = *(u64 *)(r1 + 0)
      sum(&vec)             r1 = arena    --+

    A copy of the function for each kind of memory does not help:

      case                               why
      ---------------------------------  ----------------------------------
      the pointer comes from memory      no kind for the compiler, a number
                                         for the verifier
      an indirect call: &dyn Trait, fmt  one function for the two kinds
      if c { &local } else { &*boxed }   one pointer, two kinds
      n pointer arguments                up to 2^n copies

    For example, core::fmt::num writes the digits to a local array. It
    passes a part of the array as &str to Formatter::pad_integral(), which
    calls write_str() of a &mut dyn Write. The same write_str() gets
    strings from .rodata and from the heap.

 2. The address of a local goes to memory. A load gives a number.

The design
==========

The series adds a second stack, in arena. A new register, r12
(BPF_REG_ARENA_SP), points to it.

      kernel memory                     arena
  +---------------------+      +--------------------------+
  | BPF stack    <- r10 |      | heap, statics            |
  |                     |      +--------------------------+
  |  spilled registers  |      | stack in arena    <- r12 |
  |  other locals       |      |                          |
  |                     |      |  locals whose address    |
  +---------------------+      |  the prog takes          |
                               +--------------------------+
  The verifier tracks          The verifier tracks nothing.
  each slot.                   An access cannot leave arena.

 - The compiler selects the stack for each local.
 - Each run of a prog takes a stack at its start and gives it back at its
   exit. The usual case is 8 and 4 insns without a call.
 - The verifier accepts r12 in four insns only: 'r12 += N' as the first
   insn of a function, a load, a store, and 'rX = r12'.
 - x86 and arm64 JITs support r12.

The other places for an address-taken local that were tried:

  where the local is                      what breaks it
  --------------------------------------  ---------------------------------
  structs by value, more inlining         an optimization. Pattern 2 stays
  a second vm area or arena, a map value  a different base: pattern 1
  arena, a fixed frame for each function  recursion, a second run on the
  and cpu, as in the private stack        same cpu
  arena stack, the kernel supplies it     this series

The logs of patches 8, 9, 11 and 12 give the reasons for the other
choices: where the stack pointer is, how a run gets a stack, what the
verifier accepts, and which x86 register r12 is.

The compiler
============

The compiler selects the stack by use, after all IR optimizations, for the
full local and its full life:

  rule 1   r10   The function that owns the local passes its address to
                 a helper or a kfunc: iterator, irq flag, dynptr, map key.
  rule 2   r10   The prog stores a kernel pointer in it and loads it again.
                 Also a local that holds the address of such a local.
  else     r12

Thus open coded iterators, bpf_local_irq_save() and dynptrs work as today.

  what      clang for C today     with the flag, for Rust
  --------  --------------------  -----------------------------------------
  statics   __arena variables:    statics: .addr_space.1 and
            .addr_space.1         .bss.addr_space.1
  locals    r10                   r10 or r12
  casts     by type: __arena      by origin: one cast for each pointer that
            pointers              doesn't come from the kernel

  data in .rodata                  where
  -------------------------------  -------------
  statics of Rust                  arena
  tables of functions              read-only map
  strings for helpers and kfuncs   read-only map

The price: .rodata in arena is writable, and its values are not constants
for the verifier.

No released compiler emits this code. The change to the BPF backend of LLVM
is in review: https://github.com/llvm/llvm-project/pull/235577

The patches
===========

  patches 1-2    The default size of arena.
  patches 3-4    addr_space_cast of a pointer that is not in arena. The
                 compiler casts a pointer when it does not know its origin.
  patches 5-7    Statics: .bss.addr_space.1, and pointers that are stored
                 in arena.
  patches 8-14   r12: the register, the stacks, the verifier, the JITs, the
                 tests.

The series applies on top of three fixes that are posted separately:
 - bpf: Fix the join of fp+0 in the analysis of stack arguments
 - bpf: Don't trust pointers spilled in slots that a callee can write
 - bpf, x86: Fix bpf_throw() in a prog with a private stack
Patch 3 needs the first one. Patch 12 changes a line of the third one.

Patches 8-14 do not change the code of progs without r12. A prog with r12
pays 0.3 to 2.3 nsec in each run on x86-64 (Zen 5) with hot caches. Loads,
stores and calls cost the same as with r10. Patches 9-12 have the tables.
Patch 3 changes the code of a prog in C only where it casts a pointer that
is not in arena.

v1 -> v2:
 - A series of its own, on bpf-next.
 - The default size of arena is 4 Gbyte (Andrii, Kumar).
 - The cover letter and the logs give the reasons for the design (Kumar).
 - A cast that is a move has 64 bits. JITs that need explicit zero
   extension lost the upper half of the pointer (Ihor, CI on s390x).
 - callx of a callback that takes a stack is rejected, as a call is.
 - For the analysis of live stack slots the result of a cast is never
   a certain pointer to a slot. A store to arena counted as a write to the
   stack, and a prog with an access out of bounds loaded.
 - The code that takes a stack is added before gen_prologue() and
   gen_epilogue(). A BPF qdisc without a stack skipped the two.
 - BPF_LD_ABS and BPF_LD_IND are rejected in progs with r12.
 - gotox to the first insn of a function does not take a stack again.
   A call as the first insn of a callback keeps its target.
 - x86: bpf_throw() in a function with stack arguments restored the
   callee saved registers of the kernel from incorrect slots.
 - A slot for a stack does not name pages that are freed.
 - The static linker accepts pointers in arena to static variables.
 - arm64 is tested in QEMU.
 - bpf_alloc(), bpf_free(), bpf_arena_memcmp() and bpf_arena_memcpy() are
   not in the series.

[1] https://lore.kernel.org/bpf/20261026025943.404450-1-alexei.starovoitov@gmail.com/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (14):
  libbpf: Make arena 4 Gbyte when max_entries is not set
  selftests/bpf: Test the default size of arena
  bpf: Treat addr_space_cast of a pointer that is not in arena as a move
  selftests/bpf: Test addr_space_cast of pointers that are not in arena
  libbpf: Support .bss.addr_space.1 section
  libbpf: Relocate pointers that are stored in arena
  selftests/bpf: Test pointers in arena and .bss.addr_space.1
  bpf: Introduce bpf register BPF_REG_ARENA_SP
  bpf: Add stacks for programs to arena
  bpf, x86: Add BPF_ATOMIC_LOCAL
  bpf: Support BPF_REG_ARENA_SP in the verifier
  bpf, x86: Support BPF_REG_ARENA_SP
  bpf, arm64: Support BPF_REG_ARENA_SP
  selftests/bpf: Add tests for BPF_REG_ARENA_SP

 arch/arm64/net/bpf_jit_comp.c                 |   12 +
 arch/x86/net/bpf_jit_comp.c                   |  150 ++-
 include/linux/bpf.h                           |   32 +
 include/linux/bpf_verifier.h                  |   16 +
 include/linux/filter.h                        |   57 +-
 kernel/bpf/arena.c                            |  142 +++
 kernel/bpf/backtrack.c                        |    2 +-
 kernel/bpf/const_fold.c                       |    7 +
 kernel/bpf/core.c                             |   34 +-
 kernel/bpf/disasm.c                           |    7 +
 kernel/bpf/fixups.c                           |  246 +++-
 kernel/bpf/liveness.c                         |   23 +-
 kernel/bpf/scev.c                             |    9 +-
 kernel/bpf/verifier.c                         |  247 +++-
 tools/lib/bpf/libbpf.c                        |  132 ++-
 tools/lib/bpf/linker.c                        |   21 +-
 tools/testing/selftests/bpf/Makefile.skel     |    3 +-
 .../bpf/prog_tests/arena_data_ptrs.c          |   70 ++
 .../bpf/prog_tests/arena_default_size.c       |   22 +
 .../selftests/bpf/prog_tests/arena_stack.c    |  323 +++++
 .../selftests/bpf/prog_tests/ctx_rewrite.c    |   14 +-
 .../selftests/bpf/prog_tests/pro_epilogue.c   |    2 +
 .../prog_tests/test_struct_ops_refcounted.c   |    2 +
 .../selftests/bpf/prog_tests/verifier.c       |    4 +
 .../selftests/bpf/progs/arena_data_ptrs.c     |  135 +++
 .../bpf/progs/arena_data_ptrs_fail.c          |   25 +
 .../selftests/bpf/progs/arena_default_size.c  |   21 +
 .../selftests/bpf/progs/arena_noarena.c       |   14 +
 .../testing/selftests/bpf/progs/arena_stack.c |  334 ++++++
 .../selftests/bpf/progs/arena_stack_fentry.c  |   13 +
 .../selftests/bpf/progs/arena_stack_grow.c    |  151 +++
 .../selftests/bpf/progs/arena_stack_loop.c    |   77 ++
 .../selftests/bpf/progs/arena_stack_nomem.c   |   41 +
 .../selftests/bpf/progs/arena_stack_throw.c   |  110 ++
 .../bpf/progs/pro_epilogue_arena_stack.c      |  199 ++++
 .../struct_ops_refcounted_fail__arena_stack.c |   61 +
 .../selftests/bpf/progs/verifier_arena_cast.c |  762 ++++++++++++
 .../bpf/progs/verifier_arena_stack.c          | 1043 +++++++++++++++++
 .../bpf/progs/verifier_bpf_fastcall.c         |   24 +-
 .../selftests/bpf/progs/verifier_may_goto_1.c |   12 +-
 .../selftests/bpf/progs/verifier_sdiv.c       |   64 +-
 .../selftests/bpf/verifier/basic_stx_ldx.c    |    4 +-
 42 files changed, 4561 insertions(+), 106 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_data_ptrs.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_default_size.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_data_ptrs.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_data_ptrs_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_default_size.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_stack_fentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_stack_grow.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_stack_loop.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_stack_nomem.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_stack_throw.c
 create mode 100644 tools/testing/selftests/bpf/progs/pro_epilogue_arena_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__arena_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_cast.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_stack.c


base-commit: eaae576c34d7e001767b6845a5950b0b8db3e68a
prerequisite-patch-id: d1ee323f716bd2f2339c814bf670f801432f5b15
prerequisite-patch-id: 0cc5798286d30e27e5fbd131af57beaaa5d701ba
prerequisite-patch-id: 8812117758539ebd074517eb958a1aed68a6f063
prerequisite-patch-id: c604f827ab62cf2305b93cbb7c385e250b8113a9
prerequisite-patch-id: 6acc47f4d69a25e2d3b469a0f10114df899eab8f
prerequisite-patch-id: 60c4ea0efb004695874a07bc011f9c099193b1dd
-- 
2.55.0

