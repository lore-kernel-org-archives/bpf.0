Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA25169AD2
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 03:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776397633; cv=none; b=RjHwL9ARqHKzTcl8YFSyLCDPp+WzzWLiq8Cm4S/p5zCZ3snExr5o07GhglqfDdkkMOFGfwIJXu+cihH23qH4h5pOXVKt+PxJHaEN4/owvJ8jcAi+HnwSTnOnVjbE+u+ZMIlQ8I95e2C7tOFb8/A3nal8+ZZHC8quB8ZV9fMUjJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776397633; c=relaxed/simple;
	bh=0s7wQJNDhbSAqB9hj+5UaVmT0JsbJzPmDzo/9EYAQVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=evnTp94eDkw3VRoO1cqOmIgIn14GWHqEmCtlDGB/UgHoPvnwlrpfI7GDd0wUtBMESMqtxLtLBDi/yOsyzLrLAUv/dqIFuXegVjjdyXGfpxK1IF3usSQa9sj6+LflM6OHMUfqzsxJ+aaxSCVK4x0I4Pj/R/s1SPaqwMAjV35RUWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id A88CA403C22E1; Thu, 16 Apr 2026 20:46:58 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 00/16] bpf: Support stack arguments for BPF functions and kfuncs
Date: Thu, 16 Apr 2026 20:46:58 -0700
Message-ID: <20260417034658.2625353-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Currently, bpf function calls and kfunc's are limited by 5 reg-level
parameters. For function calls with more than 5 parameters,
developers can use always inlining or pass a struct pointer
after packing more parameters in that struct. But there is
no workaround for kfunc if more than 5 parameters is needed.

This patch set lifts the 5-argument limit by introducing stack-based
argument passing for BPF functions and kfunc's, coordinated with
compiler support in LLVM [1]. The compiler emits loads/stores through
a new bpf register r11 (BPF_REG_PARAMS) to pass arguments beyond
the 5th, keeping the stack arg area separate from the r10-based program
stack. The maximum number of arguments is capped at MAX_BPF_FUNC_ARGS
(12), which is sufficient for the vast majority of use cases.

In verifier, r11 based stores can survive bpf-to-bpf and kfunc
calls. For example
      *(u64 *)(r11 - 8) =3D r6;
      *(u64 *)(r11 - 16) =3D r7;
      call bar1;                // arg6 =3D r6, arg7 =3D r7
      call bar2;                // reuses same arg6, arg7 without re-stor=
ing

If users want to have a different parameter for bar2(), it can have
a store after bar1() and before bar2().
      *(u64 *)(r11 - 8) =3D r6;
      *(u64 *)(r11 - 16) =3D r7;
      call bar1;                // arg6 =3D r6, arg7 =3D r7
      *(u64 *)(r11 - 16) =3D r8;
      call bar2;                // arg6 =3D r6, arg7 =3D r8

The x86_64 JIT translates r11-relative accesses to RBP-relative
native instructions. Each function's stack allocation is extended
by 'max_outgoing' bytes to hold the outgoing arg area below the
callee-saved registers. This makes implementation easier as the r10
can be reused for stack argument access. At both BPF-to-BPF and kfunc
calls, outgoing args are pushed onto the expected calling convention
locations directly. The incoming parameters can directly get the value
from caller.

To support kfunc stack arguments, before doing any stack arguments,
existing codes are refactored/modified to use bpf_reg_state as much
as possible instead of using regno, and to pass a non-negative argno,
encoded to support both registers and stack arguments, as a single
variable.

Global subprogs with >5 args are not yet supported. Only x86_64
is supported for now.

For the rest of patches, patches 1-4 make changes to make it
easy for future stack arguments for kfuncs. Patches 5-8
supports bpf-to-bpf stack arguments. Patch 9 rejects interpreter
for stack arguments. Patch 10 rejects subprogs if tailcall reachable.
Patch 11 adds stack argument support for kfuncs. Patch 12 enables
stack arguments for x86_64 and Patch 13 implements the x86_64 JIT.
Patches 14-16 are some test cases.

  [1] https://github.com/llvm/llvm-project/pull/189060

Note:
  - The patch set is on top of the following commit:
    1f5ffc672165  Fix mismerge of the arm64 / timer-core interrupt handli=
ng changes
  - This patch set requires latest llvm23 compiler. It is possible that a=
 build
    failure may appear:
      /home/yhs/work/bpf-next/scripts/mod/modpost.c:59:13: error: variabl=
e 'extra_warn' set but not used [-Werror,-Wunused-but-set-global]
             59 | static bool extra_warn;
                |             ^
          1 error generated.
    In this case, the following hack can workaround the build issue:
      --- a/Makefile
      +++ b/Makefile
      @@ -467,7 +467,7 @@ KERNELDOC       =3D $(srctree)/tools/docs/kerne=
l-doc
       export KERNELDOC

       KBUILD_USERHOSTCFLAGS :=3D -Wall -Wmissing-prototypes -Wstrict-pro=
totypes \
      -                        -O2 -fomit-frame-pointer -std=3Dgnu11
      +                        -O2 -fomit-frame-pointer -std=3Dgnu11 -Wno=
-unused-but-set-global
       KBUILD_USERCFLAGS  :=3D $(KBUILD_USERHOSTCFLAGS) $(USERCFLAGS)
       KBUILD_USERLDFLAGS :=3D $(USERLDFLAGS)

Changelogs:
  v4 -> v5:
    - v4: https://lore.kernel.org/bpf/20260412045826.254200-1-yonghong.so=
ng@linux.dev/
    - Use r11 instead of r12, llvm also updated with r11.
    - Change int type 'reg_or_arg' to u32 'argno' where 'argno' encodes t=
o support
      both bpf registers and stack arguments.
    - Track per-state bitmask 'out_stack_arg_mask' for r11 based stores, =
so at any
      particular call, it knows what stores are available. This is import=
ant since
      stores may be in different basic block.
    - Previously after each call, all store slots are invalidated. This p=
atches
      disabled such invalidation.
    - Ensure r11 reg only appearing in allowed insns. Also avoid r11 for =
reg tracking
      purpose.
    - Make stack_arg_regs more similar to regular reg's (struct bpf_reg_s=
tate *)..
    - Reorder r11 based stores from 'arg6:off:-24, arg7:off:-16, arg8:off=
:-8" to
      "arg6:off:-8, arg7:off:-16, arg8:off:-24".
    - Add a few more tests, including e.g., two callee's with different n=
umber of
      stack arguments, shared r11-stores in different branches, etc.
    =20
  v3 -> v4:
    - v3: https://lore.kernel.org/bpf/20260405172505.1329392-1-yonghong.s=
ong@linux.dev/
    - Refactor/Modify codes to make it easier for later kfunc stack argum=
ent support
    - Invalidate outgoing slots immediately after the call to prevent reu=
se
    - Fix interaction between stack argument PTR_TO_STACK and dead slot p=
oisoning
    - Reject stack arguments if tail call reachable
    - Disable private stack if stack argument is used
    - Allocate outgoing stack argument region after callee saved register=
s, and this
      simplifies the JITed code a lot.
  v2 -> v3:
    - v2: https://lore.kernel.org/bpf/20260405165300.826241-1-yonghong.so=
ng@linux.dev/
    - Fix selftest stack_arg_gap_at_minus8().
    - Fix a few 'UTF-8' issues.
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20260402012727.3916819-1-yonghong.s=
ong@linux.dev/
    - Add stack_arg_safe() to do pruning for stack arguments.
    - Fix an issue with KF_ARG_PTR_TO_MEM_SIZE. Since a faked register is
      used, added verification log to indicate the start and end of such
      faked register usage.
    - For x86_64 JIT, copying incoming parameter values directly from cal=
ler's stack.
    - Add test cases with stack arguments e.g. mem, mem+size, dynptr, ite=
r, etc.

Yonghong Song (16):
  bpf: Remove unused parameter from check_map_kptr_access()
  bpf: Refactor to avoid redundant calculation of bpf_reg_state
  bpf: Refactor to handle memory and size together
  bpf: Prepare verifier logs for upcoming kfunc stack arguments
  bpf: Introduce bpf register BPF_REG_PARAMS
  bpf: Limit the scope of BPF_REG_PARAMS usage
  bpf: Reuse MAX_BPF_FUNC_ARGS for maximum number of arguments
  bpf: Support stack arguments for bpf functions
  bpf: Reject stack arguments in non-JITed programs
  bpf: Reject stack arguments if tail call reachable
  bpf: Support stack arguments for kfunc calls
  bpf: Enable stack argument support for x86_64
  bpf,x86: Implement JIT support for stack arguments
  selftests/bpf: Add tests for BPF function stack arguments
  selftests/bpf: Add negative test for greater-than-8-byte kfunc stack
    argument
  selftests/bpf: Add verifier tests for stack argument validation

 arch/x86/net/bpf_jit_comp.c                   |  154 ++-
 include/linux/bpf.h                           |    6 +
 include/linux/bpf_verifier.h                  |   29 +-
 include/linux/filter.h                        |    6 +-
 kernel/bpf/btf.c                              |   20 +-
 kernel/bpf/const_fold.c                       |    9 +-
 kernel/bpf/core.c                             |   11 +-
 kernel/bpf/fixups.c                           |   32 +-
 kernel/bpf/liveness.c                         |    9 +-
 kernel/bpf/states.c                           |   41 +
 kernel/bpf/verifier.c                         | 1200 +++++++++++------
 .../testing/selftests/bpf/prog_tests/bpf_nf.c |   22 +-
 .../selftests/bpf/prog_tests/cb_refs.c        |    2 +-
 .../selftests/bpf/prog_tests/ctx_rewrite.c    |   14 +-
 .../selftests/bpf/prog_tests/kfunc_call.c     |    2 +-
 .../selftests/bpf/prog_tests/linked_list.c    |    4 +-
 .../selftests/bpf/prog_tests/stack_arg.c      |  133 ++
 .../selftests/bpf/prog_tests/stack_arg_fail.c |   24 +
 .../selftests/bpf/prog_tests/verifier.c       |    2 +
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  |   14 +-
 .../selftests/bpf/progs/cpumask_failure.c     |   10 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |   22 +-
 .../selftests/bpf/progs/file_reader_fail.c    |    4 +-
 tools/testing/selftests/bpf/progs/irq.c       |    4 +-
 tools/testing/selftests/bpf/progs/iters.c     |    6 +-
 .../selftests/bpf/progs/iters_state_safety.c  |   14 +-
 .../selftests/bpf/progs/iters_testmod.c       |    4 +-
 .../selftests/bpf/progs/iters_testmod_seq.c   |    4 +-
 .../selftests/bpf/progs/map_kptr_fail.c       |    2 +-
 .../selftests/bpf/progs/percpu_alloc_fail.c   |    4 +-
 .../testing/selftests/bpf/progs/rbtree_fail.c |    6 +-
 .../bpf/progs/refcounted_kptr_fail.c          |    2 +-
 tools/testing/selftests/bpf/progs/stack_arg.c |  254 ++++
 .../selftests/bpf/progs/stack_arg_fail.c      |   32 +
 .../selftests/bpf/progs/stack_arg_kfunc.c     |  164 +++
 .../testing/selftests/bpf/progs/stream_fail.c |    2 +-
 .../selftests/bpf/progs/task_kfunc_failure.c  |   18 +-
 .../selftests/bpf/progs/task_work_fail.c      |    6 +-
 .../selftests/bpf/progs/test_bpf_nf_fail.c    |    8 +-
 .../bpf/progs/test_kfunc_dynptr_param.c       |    2 +-
 .../bpf/progs/test_kfunc_param_nullable.c     |    2 +-
 .../selftests/bpf/progs/verifier_bits_iter.c  |    4 +-
 .../bpf/progs/verifier_bpf_fastcall.c         |   24 +-
 .../selftests/bpf/progs/verifier_may_goto_1.c |   12 +-
 .../bpf/progs/verifier_ref_tracking.c         |    6 +-
 .../selftests/bpf/progs/verifier_sdiv.c       |   64 +-
 .../selftests/bpf/progs/verifier_stack_arg.c  |  463 +++++++
 .../selftests/bpf/progs/verifier_vfs_reject.c |    8 +-
 .../testing/selftests/bpf/progs/wq_failures.c |    2 +-
 .../selftests/bpf/test_kmods/bpf_testmod.c    |   73 +
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   26 +
 tools/testing/selftests/bpf/verifier/calls.c  |   14 +-
 52 files changed, 2442 insertions(+), 558 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_arg.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_arg_fail=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/stack_arg.c
 create mode 100644 tools/testing/selftests/bpf/progs/stack_arg_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/stack_arg_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_stack_arg.=
c

--=20
2.52.0

