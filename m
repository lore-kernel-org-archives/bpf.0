Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755444;
	b=aDNQIXkXxyVp6Z8gLZ8aHveTOaNMJFRJP0MH3caZEs6efOb8WEuQLE5/InCI9z6teOH0
	 mhsYQH/cnIYyHBou6v+4sISVOmho/eJAghBz3DEUa7DKmwDX4+kfEnkgW3J/4Do3oPe7u
	 JRtx0R6Sqfnzmyaj3WYCp/JAfRBVMfHL97a2P5mtveS466RoYhslkJSQZh2hfh6sAHEbh
	 WOy4AQjjBKGc2Y2hCLwscI9sdeXJbL+kNLZHbLXbqqveMBjNPqEB0/TqdugCPf7E2hA9I
	 IuxYk491Gxmpd4DCcLc8lE3jI4MQUbJ+0zh1gvhO69EhmZ56qKYUtXmef1o53bGXiew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=kUiq7FTwT7mmzWIZfMwBM7OcdDdwBHGLRgW3h/0Drb8=;
	b=mIN7oBDlnfoGv78ym4ptdiIguM4GsKd6oP2HxoC29pZHiwk/zRgvXyZfbuSZ7nXoZlgS
	 bpS1TxnYUHrv1cfjKQLwpsk3lWYaqqjEBGMkgl+l3yD0xRktHdBJH7YPJnh0urtrm1VFm
	 twuZViefG5KKULgfkttVEZZllpoWj+AHi5xW9nJ6jVJ3y/b/pbLlbtuFc39td1Z196JBn
	 PJsuhF4T9jNaVsdhBAQFqTDZuTRP4qus8v5pIjwwS/1Y1t3uko/RrwDyag5njvx4j8Q9n
	 q/Qy7c2RuVAibzrfdsJhgNCTjkcLDUu2a/jQ/meCnUWJQkq+Xp/WceFshXVknHEXJmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="YVj9/ZX7";
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37431606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 01:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37431606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YVj9/ZX7
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e5378b281aso961605ad.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 17:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793755443; x=1794360243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kUiq7FTwT7mmzWIZfMwBM7OcdDdwBHGLRgW3h/0Drb8=;
        b=YVj9/ZX7KhkdYbeZ0kuYh/n67C52dMv/+/TGR1nlycDBH8blezBt/e5ffSKGriNVNP
         R3eAfjCgERqEGKkdMnJn6DshC2QuOxnCjlBPJsjISzM2BVXw9NQJUQXaexU2jCg2H45c
         CovuRoyKu2X/Li3jI92X0INhrTjq6mGdu7sMY4LtaCBp8tkuQ6o2bGVm147yP2q3N8My
         2AXYwoondMpm4pwb7AxzmBQFHLR26mlg4lByCvnAxKj5PXLbFWvs1QuMVrroU2GobYCk
         ywcQ+SLAJU/XMmUlrk0OHAW2iXO4LtGr5LFPmTBYm6dD4NUvJ7hJGCZt8RFbOV5HfdTO
         pnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793755443; x=1794360243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kUiq7FTwT7mmzWIZfMwBM7OcdDdwBHGLRgW3h/0Drb8=;
        b=SK1lz9R4aOGg+jjtw6kyhoMWJ0Gob1pthbQbXkgIM+fEXfPFik+jQk5yf+k3lZzCEA
         0hYlV+gvO1hkXVR+YmQa49fAuzyQAVN03lXl3SxJHbc1MZPGCT1vlanP7okwjSfLO6fm
         +1COepCEZjAFfo71oRXO2NS/daLdfHyhYGBeYANydaZJGHalrcmuDNGJ0wayIaIThaxq
         5gUMlHpqQNjsuBrIObZhtMUMqIw6mqjnpbK33c3S6d+QhFkYdJjjt6U5bM8+IskPJ6MH
         XaSctoLM6J0jVeXGcfEebpxexxXUNsKyy946cLGxoGPAFuL7gsB+97RV2+oXx+gU6PoC
         Lenw==
X-Gm-Message-State: APuU4Z8f2VD9TNnm60HCsi1px+LSFQAO1ZfqoMOlQjeXnC0r2ZFdg241
	quGT5LL2Ns7unPj9qyU1gx/+/0u2drHc1gIZ0P5BoLwBkAEDN/ISJ/BB3f/fTw==
X-Gm-Gg: AYBFou3iobxxuI4NKBxslCs83c75mLvTS0oqwRml5tA3CfGTWKpOEedUuCEBDT4p/Q5
	HW5r4m8PTDnuOk12XqEYa3D68/LSUvH2AnPOA+rxsyv/6YeK8vIt85VMXbg8019JGdOn9cmHOVv
	E59fhtn95wY5AiZ2qFwo0DTzv7N/DrvFewoQHQFBptptbftV55x66Z2UNjRyYvMXKOsGko6Bsgb
	Ku24EDyy+9vBDJsA+kIZ96Q5rNuOLQqnTpCT7dphPihtR9CTicUIZRxmYSt0YVJGdt11iHPQ/U6
	QfHz6p0Rn9HA/yfnzNDy0/Sc+qsbg3YiixBKmWt1H6nIUomJj3fXbA1drltA1jFQUOB/EzF0Fjx
	bBLnFoF+9l2TGT5Pv4HK7B740sAJICMPCXwt9yiQ9cfP5JgxoQ5guguLOn7kVvyzc6o/FWXoaNJ
	xdG+gxMXCbP+G2XK2MLJ9HQg51uDUTuM5eIyBjOVghU/o/N2A8LeqQwfwTvQqsZ4SCkMJq5bPky
	/6+qdT3vrc1z5nRLfhPCrz1QLMUenPD5EskMUxVo5ZuSWwXUbXZkjEaVnJpoFyQzzC/NouE0t6P
	cCqTORJZv75ekM6uSh1ZHLZCyh2URv7G7xDIXZ4p+1muAeh3yRF3F7wQHpC9YYocPfZmc4OyP1y
	l5A0ZkwrILng+hGNiRhvZ71+VnpUU+FhOy8vILrMIjgPBHGDCBXBTWaRxiZEh7UiCu/2kFR7r/w
	==
X-Received: by 2002:a17:90b:1b12:b0:39e:3713:c2e4 with SMTP id 98e67ed59e1d1-3ae896f51e5mr12899853a91.14.1793755443143;
        Tue, 03 Nov 2026 17:24:03 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c8329afsm6626329a91.8.2026.11.03.17.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 17:24:02 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 00/14] bpf: A stack in arena
Date: Wed,  4 Nov 2026 01:23:46 +0000
Message-ID: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
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

 2. The address of a local goes to memory. A load gives a number. The
    memory can be the heap, when the object in the heap is dropped first:

      let x = [1, 2, 3];
      let v: Vec<&i32> = x.iter().collect();

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
When the compiler puts such a local in r12 by mistake, the prog does not
load: its address and what is loaded from it are numbers for the verifier.
It is not a memory error.

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

Patches 8-14 do not change the code of progs without r12. A prog with r12
pays 0.3 to 2.3 nsec in each run on x86-64 (Zen 5) with hot caches. Loads,
stores and calls cost the same as with r10. Patches 9-12 have the tables.
Patch 3 changes the code of a prog in C only where the verifier finds a
kernel pointer at a cast.

v2 -> v3:
 - Rebased. The three fixes that v2 needed are merged. BPF CI could not
   apply v2 without them.
 - Patch 11: bpf_patch_insn_data() is gone. The code that takes a stack and
   gives it back goes through the list of deferred patches. A call that the
   verifier emits is marked in the insn (BPF_EMIT_KERNEL_CALL), not in
   insn_aux_data.
 - Patch 11: "bpf: End bpf_loop() when the time of may_goto is up" added
   is_called to struct bpf_subprog_info, for functions that BPF code calls
   and for callbacks of other helpers. A callback of another helper can
   take a stack, a function that BPF code calls cannot. The callbacks have
   a bit of their own now, is_other_cb.
 - Patch 8: BPF_REG_AX is r13 also in the tests of may_goto and of the
   patch list that were merged after v2.
 - Patch 14: three tests of may_goto in progs with r12. The test of callx
   is built when CAN_USE_CALLX is defined.
 - Patch 4: two tests: the cast of an untrusted kernel pointer is a move.
 - Patch 11: a call of the main prog is rejected, as a call of a callback
   that takes a stack.
 - Patches 2, 7 and 14: arena_default_size, arena_data_ptrs and arena_stack
   are serial, as the other tests in prog_tests/arena_*.c.
 - Patch 7: the test fails when .bss.addr_space.1 is not aligned.
 - Corrections in the logs of patches 3, 9, 11 and 14.
 - The log of patch 1 says why libbpf needs the default also when the
   kernel accepts 0 (Andrii, Kumar).
 - The cover letter has an example for pattern 2, and it says what happens
   when the compiler selects r12 by mistake (Kumar).
 - The code of patches 1, 3, 5, 6, 9, 10, 12 and 13 is the same.

v2: https://lore.kernel.org/bpf/20261101030511.1578690-1-alexei.starovoitov@gmail.com/

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
 include/linux/bpf_verifier.h                  |   17 +-
 include/linux/filter.h                        |   72 +-
 kernel/bpf/arena.c                            |  142 ++
 kernel/bpf/backtrack.c                        |    2 +-
 kernel/bpf/const_fold.c                       |    7 +
 kernel/bpf/core.c                             |   34 +-
 kernel/bpf/disasm.c                           |    7 +
 kernel/bpf/fixups.c                           |  222 +++-
 kernel/bpf/liveness.c                         |   23 +-
 kernel/bpf/scev.c                             |    9 +-
 kernel/bpf/verifier.c                         |  248 +++-
 tools/lib/bpf/libbpf.c                        |  132 +-
 tools/lib/bpf/linker.c                        |   21 +-
 tools/testing/selftests/bpf/Makefile.skel     |    3 +-
 .../bpf/prog_tests/arena_data_ptrs.c          |   70 +
 .../bpf/prog_tests/arena_default_size.c       |   22 +
 .../selftests/bpf/prog_tests/arena_stack.c    |  323 +++++
 .../selftests/bpf/prog_tests/ctx_rewrite.c    |   14 +-
 .../selftests/bpf/prog_tests/pro_epilogue.c   |    2 +
 .../prog_tests/test_struct_ops_refcounted.c   |    2 +
 .../selftests/bpf/prog_tests/verifier.c       |    4 +
 .../selftests/bpf/progs/arena_data_ptrs.c     |  138 ++
 .../bpf/progs/arena_data_ptrs_fail.c          |   25 +
 .../selftests/bpf/progs/arena_default_size.c  |   21 +
 .../selftests/bpf/progs/arena_noarena.c       |   14 +
 .../testing/selftests/bpf/progs/arena_stack.c |  334 +++++
 .../selftests/bpf/progs/arena_stack_fentry.c  |   13 +
 .../selftests/bpf/progs/arena_stack_grow.c    |  151 +++
 .../selftests/bpf/progs/arena_stack_loop.c    |   77 ++
 .../selftests/bpf/progs/arena_stack_nomem.c   |   41 +
 .../selftests/bpf/progs/arena_stack_throw.c   |  110 ++
 .../bpf/progs/pro_epilogue_arena_stack.c      |  199 +++
 .../struct_ops_refcounted_fail__arena_stack.c |   61 +
 .../selftests/bpf/progs/verifier_arena_cast.c |  800 +++++++++++
 .../bpf/progs/verifier_arena_stack.c          | 1169 +++++++++++++++++
 .../bpf/progs/verifier_bpf_fastcall.c         |   24 +-
 .../selftests/bpf/progs/verifier_may_goto_1.c |   12 +-
 .../selftests/bpf/progs/verifier_patch_list.c |    6 +-
 .../selftests/bpf/progs/verifier_sdiv.c       |   64 +-
 .../selftests/bpf/verifier/basic_stx_ldx.c    |    4 +-
 43 files changed, 4721 insertions(+), 112 deletions(-)
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


base-commit: 7b8b803c3ce6e961e9c32a166c7169fcb17da6d4
-- 
2.55.0

