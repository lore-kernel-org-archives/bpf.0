Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DFF39449C
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175453; cv=none; b=lhfu5f8WC2PcBBhS5EZxKg3R8zDf4y8HOZDY74y6rKr/GzptT+IY3ayDybylT5vfSFQDcVRBVbCGJMbmOevU8tvoMFI+0KB4UjJKI4oRyFDjDt0HaZPh1HwsMxm34PWBCuYiRgPEQz7DLxLOTqXmPxS4SJ1zArcOv9BTPBom8p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175453; c=relaxed/simple;
	bh=SN7pmNV1Ffe9hqUEYftciwWiPZsVEA/wYBPEisdEOiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pio7C1xoY2Sz6lf61mU2iCc9y/+pY24e0y/gpsmtuqNrqdX1TZ3EHEaSRRx5Jk6csNMHutM73NEzcoD9YP5G2ApUUcJ5ChbkLOQPjsrNOLNMFU6Esp3dTU52CrG8hyhgJQIGAX+XojZY1nyyeHTYS+g4vOVRsjAl7HQV+wGqopE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 6EA5331A0D41EE; Fri, 16 Oct 2026 11:30:39 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 0/9] bpf: Follow up by-value struct and __int128 argument support
Date: Fri, 16 Oct 2026 11:30:39 -0700
Message-ID: <20261016183039.1132126-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a follow-up to the series "bpf: Support by-value struct and
__int128 arguments" [1], which placed kfunc arguments by the kernel
calling convention in the x86-64 and arm64 JITs, and made the arm64
trampoline place an argument aligned to 16 bytes: an __int128, or an
aggregate holding one. This series covers what was left, and a few
problems found on the way:

  - The x86-64 trampoline. x86-64 starts such an argument passed on the
    stack at a 16-byte aligned slot, which can leave an empty slot
    before it, but the trampoline copied the stack arguments as if
    there were none. A bpf program attached to such a function read the
    wrong values from the empty slot on, and with fexit, where the
    trampoline calls the traced function itself, that function got its
    stack arguments one slot off as well.

  - A trampoline on a BPF function. BPF code calls one with argument
    slot N where the kernel convention passes its Nth u64 argument, but
    the trampolines placed the arguments by their types: arm64 left a
    register empty before a 16-byte argument, x86-64 would not split one
    between r9 and the stack, and s390 took one as a pointer to it. Such
    a function is now described to its trampoline as one u64 per slot.

  - The x86-64 trampoline on a function of a program that can tail call
    pushed the tail call counter pointer between the stack arguments and
    the return address.

  - A static function whose BTF is unreliable could still take stack
    arguments, while its trampoline saved and restored only five
    registers. Attaching to such a function is now refused.

  - Tests with an __int128 at an odd slot, where arm64 leaves a register
    or a stack slot empty. On arm64 such a kfunc gets BTF only with the
    pahole patch [2], now in pahole master after v1.32, so these tests
    were not part of [1].

Patch 1 keeps the x86-64 trampoline's tail call counter pointer clear of
the stack arguments, and patch 2 tests it. Patch 3 adds the odd-slot
kfunc tests. Patch 4 describes a BPF function to its trampoline as one
u64 per slot, and patch 5 places the x86-64 trampoline arguments by the
calling convention. Patches 6 and 7 test trampolines on kernel functions
and on BPF functions with an argument after a 16-byte aligned one, the
latter on s390x as well. Patch 8 refuses a trampoline on an unreliable
static function with stack arguments, and patch 9 tests it, along with a
BPF function whose 16-byte argument x86-64 splits between r9 and the
stack.

  [1] https://lore.kernel.org/bpf/20260912195156.980886-1-yonghong.song@l=
inux.dev/
  [2] https://lore.kernel.org/dwarves/20260917164043.1577508-1-yonghong.s=
ong@linux.dev/

Changelogs:
  v3 -> v4:
    - v3: https://lore.kernel.org/bpf/20261013170910.2126673-1-yonghong.s=
ong@linux.dev/
    - Drop v3 patches 10 and 11 (16-byte aligned kfunc stack argument
      on x86-64); no kfunc in the tree needs it.
    - Drop byte-order based ctx indexing for the __int128 struct
      argument; tests on BPF functions use BPF_PROG2(). (patches 6, 7
      and 9)
    - Run the test on BPF functions on s390x too. The functions taking
      stack arguments are built only for x86 and arm64. (patch 7)
    - Say that patch 4 also fixes the s390 trampoline on a BPF function
      taking a 16-byte argument. (patch 4)
  v2 -> v3:
    - v2: https://lore.kernel.org/bpf/20261013003429.1853052-1-yonghong.s=
ong@linux.dev/
    - Index the two halves of a struct holding an __int128 in ctx by the
      byte order, so the tracing tests also hold on a big-endian
      kernel. (patches 6, 7 and 9)
    - Say that only x86-64 BPF code splits a 16-byte argument between r9
      and the stack; on arm64 nothing is split. (patches 4 and 9)
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20261009064206.1238047-1-yonghong.s=
ong@linux.dev/
    - Replace the bpf_tgt_prog flag of v1 patch 2, which only
      bpf_jit_place_args() looked at, with a model of one u64 per
      argument slot for a BPF function, built in
      bpf_check_attach_target(). This also fixes the arm64 trampoline,
      which took a 16-byte argument split between x7 and the stack as
      wholly in registers, without any arch change. (patch 4)
    - Refuse a trampoline on a static function whose BTF is unreliable
      but which takes stack arguments. (patches 8 and 9)
    - New: keep the x86-64 trampoline's tail call counter pointer in a
      slot of its frame instead of pushing it between the stack
      arguments and the return address. (patches 1 and 2)
    - New: pass a kfunc's 16-byte aligned stack argument 16-byte aligned
      in the x86-64 JIT, with bpf_jit_stack_slots_to_align() and
      bpf_jit_plan_slot_moves() in kernel/bpf/core.c. (patches 10 and
      11)
    - Reword the x86-64 placement patch and the BPF function test for
      the new model. (patches 5 and 7)

Yonghong Song (9):
  bpf, x86: Pass a trampoline's stack arguments by the calling
    convention
  selftests/bpf: Test trampoline stack args in a program that can tail
    call
  selftests/bpf: Test by-value __int128 kfunc arguments at an odd slot
  bpf: Describe a BPF function to its trampoline as one u64 per slot
  bpf, x86: Place trampoline arguments by the x86-64 calling convention
  selftests/bpf: Test trampoline args around a 16-byte aligned stack arg
  selftests/bpf: Test trampoline args of a BPF function at an odd slot
  bpf: Refuse a trampoline on an unreliable static function with stack
    args
  selftests/bpf: Test trampolines on more BPF functions with stack args

 arch/x86/net/bpf_jit_comp.c                   | 211 +++++++++--------
 kernel/bpf/verifier.c                         |  66 +++++-
 .../selftests/bpf/prog_tests/tracing_struct.c | 217 +++++++++++++++++-
 .../selftests/bpf/progs/aggregate_arg_kfunc.c |  71 ++++++
 .../progs/tracing_stack_arg_tailcall_tgt.c    |  59 +++++
 .../progs/tracing_stack_arg_tailcall_tracer.c |  23 ++
 .../bpf/progs/tracing_struct_int128.c         |  45 ++++
 .../bpf/progs/tracing_struct_int128_tgt.c     | 101 ++++++++
 .../bpf/progs/tracing_struct_int128_tracer.c  |  77 +++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  69 ++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  13 ++
 11 files changed, 848 insertions(+), 104 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_stack_arg_t=
ailcall_tgt.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_stack_arg_t=
ailcall_tracer.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct_int1=
28_tgt.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct_int1=
28_tracer.c

--=20
2.53.0-Meta

