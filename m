Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F4736607F
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 05:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778477597; cv=none; b=GKuEAZGWm5t3PcXH0kU0Nw9c86pxUxoNq+RlLMtmRnsRpuX6hsWdHZU+Oft0iyhrSW7tydAzbMrshTYJLs33wiQl1D0xAjTLWqN4NgGe51DUopllx/d1S05PpkTQO4M4hufJvwBJhQDVGvNese6zZEj3IojCZstXczLFHOEVALE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778477597; c=relaxed/simple;
	bh=R/ON2ImU89RZ31ghr82CFmg2nxy72NLL8i9abeLhQvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YLLxRwIsc9CxTFee/05wgH2aLXP/7Ed1BrXNXUhhLJ5UDZgTY6SXhOG1M9EKNdwX5dBAsv46rx9ttSDtnmrR8bj5Y60j/oQEo78jHKFtm8gzclReNFFxzhGYhTcsr50Tez6UqwMppI/a5O8cHjXou7w3MMvPJrwOaOOgQ0yhFCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id D856AA59D4FBE; Sun, 10 May 2026 22:33:01 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 00/24] bpf: Support stack arguments for BPF functions and kfuncs
Date: Sun, 10 May 2026 22:33:01 -0700
Message-ID: <20260511053301.1878610-1-yonghong.song@linux.dev>
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
after packing more parameters in that struct although it may have
some inconvenience. But there is no workaround for kfunc if more
than 5 parameters is needed.

This patch set lifts the 5-argument limit by introducing stack-based
argument passing for BPF functions and kfunc's, coordinated with
compiler support in LLVM [1]. The compiler emits loads/stores through
a new bpf register r11 (BPF_REG_PARAMS), to pass arguments beyond
the 5th, keeping the stack arg area separate from the r10-based program
stack. The current maximum number of arguments is capped at
MAX_BPF_FUNC_ARGS (12), which is sufficient for the vast majority of
use cases.

All kfunc/bpf-function arguments are caller saved, including stack
arguments. For register arguments (r1-r5), the verifier already marks
them as clobbered after each call. For stack arguments, the verifier
invalidates all outgoing stack arg slots immediately after a call,
requiring the compiler to re-store them before any subsequent call.
This follows the native calling convention where all function
parameters are caller saved.

The x86_64 JIT translates r11-relative accesses to RBP-relative
native instructions. Each function's stack allocation is extended
by 'max_outgoing' bytes to hold the outgoing arg area below the
callee-saved registers. This makes implementation easier as the r10
can be reused for stack argument access. At both BPF-to-BPF and kfunc
calls, outgoing args are pushed onto the expected calling convention
locations directly. The incoming parameters can directly get the value
from caller.

Global subprogs and freplace progs with >5 args are not yet supported.
Only x86_64 and arm64 are supported for now. Same selftests are tested
by both x86_64 and arm64. Please see each individual patch for details.

  [1] https://github.com/llvm/llvm-project/pull/189060

Changelogs:
  v2 -> v3:
    - v2: https://lore.kernel.org/bpf/20260507212942.1122000-1-yonghong.s=
ong@linux.dev/
    - In do_check_common() and for main prog, if btf does not match with =
actual
      parameter, the verification will continue and will ignore arg_cnt. =
Make
      arg_cnt=3D1 explictly to prevent any incoming stack arguments.
    - Remove the loop which clear current frame stack slot and set the up=
per level frame
      stack slot. This is not needed unless there is a bug. Add a verifie=
r_bug
      if the bug happens.
    - For liveness, avoid r11 based load/stores mixing with r10 based sta=
ck tracking.
      Also, print out stack arguments properly.
    - Pass bpf_subprog_info the JIT so we can avoid copy bpf_subprog_info=
 fields to
      bpf_prog_aux.
    - Fix the missed allocation free for test infra BTF fixup.
    - Remove selftest result for precision backtracking test since the re=
sult would
      be change (two possible output).
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20260424171433.2034470-1-yonghong.s=
ong@linux.dev/
    - Several refactoring (convert bpf_get_spilled_reg macro to static in=
line func,
      Remove copy_register_state(), Refactor jmp history, Refactor record=
_call_access(), etc),
      suggested by Eduard.
    - Use incoming_stack_arg_cnt/stack_arg_cnt instead of incoming_stack_=
arg_depth/stack_arg_depth,
      suggested by Eduard.
    - Fix a stack arg pruning bug, from Eduard.
    - Fix a bug for precision marking and backtracking, basically callee =
needs to get the
      stack arg value from callers, helped from Eduard.
    - Set sub->arg_cnt earlier in btf_prepare_func_args(), this will avoi=
d having
      incoming_stack_arg_cnt in bpf_subprog_info.
    - Do stack-arg liveness analysis together with r10 based liveness ana=
lysis,
      suggested by Eduard.
    - Fix a few tests to ensure that r11-based loads cannot be ahead of r=
11-based stores,
      and r11-based loads cannot be after kfunc/helper/bpf-function.

Puranjay Mohan (3):
  bpf, arm64: Map BPF_REG_0 to x8 instead of x7
  bpf, arm64: Add JIT support for stack arguments
  selftests/bpf: Enable stack argument tests for arm64

Yonghong Song (21):
  bpf: Convert bpf_get_spilled_reg macro to static inline function
  bpf: Remove copy_register_state wrapper function
  bpf: Add helper functions for r11-based stack argument insns
  bpf: Set sub->arg_cnt earlier in btf_prepare_func_args()
  bpf: Support stack arguments for bpf functions
  bpf: Refactor jmp history to use dedicated spi/frame fields
  bpf: Add precision marking and backtracking for stack argument slots
  bpf: Refactor record_call_access() to extract per-arg logic
  bpf: Extend liveness analysis to track stack argument slots
  bpf: Reject stack arguments in non-JITed programs
  bpf: Prepare architecture JIT support for stack arguments
  bpf: Enable r11 based insns
  bpf: Support stack arguments for kfunc calls
  bpf: Reject stack arguments if tail call reachable
  bpf: Pass bpf_subprog_info to bpf_int_jit_compile()
  bpf,x86: Implement JIT support for stack arguments
  selftests/bpf: Add tests for BPF function stack arguments
  selftests/bpf: Add tests for stack argument validation
  selftests/bpf: Add BTF fixup for __naked subprog parameter names
  selftests/bpf: Add verifier tests for stack argument validation
  selftests/bpf: Add precision backtracking test for stack arguments

 arch/arc/net/bpf_jit_core.c                   |   3 +-
 arch/arm/net/bpf_jit_32.c                     |   3 +-
 arch/arm64/net/bpf_jit_comp.c                 |  95 +++-
 arch/arm64/net/bpf_timed_may_goto.S           |   8 +-
 arch/loongarch/net/bpf_jit.c                  |   3 +-
 arch/mips/net/bpf_jit_comp.c                  |   3 +-
 arch/parisc/net/bpf_jit_core.c                |   3 +-
 arch/powerpc/net/bpf_jit_comp.c               |   3 +-
 arch/riscv/net/bpf_jit_core.c                 |   3 +-
 arch/s390/net/bpf_jit_comp.c                  |   3 +-
 arch/sparc/net/bpf_jit_comp_64.c              |   3 +-
 arch/x86/net/bpf_jit_comp.c                   | 163 ++++++-
 arch/x86/net/bpf_jit_comp32.c                 |   3 +-
 include/linux/bpf_verifier.h                  |  89 +++-
 include/linux/filter.h                        |  26 +-
 kernel/bpf/backtrack.c                        |  82 +++-
 kernel/bpf/btf.c                              |  20 +-
 kernel/bpf/const_fold.c                       |   8 +
 kernel/bpf/core.c                             |  16 +-
 kernel/bpf/fixups.c                           |  26 +-
 kernel/bpf/liveness.c                         | 178 +++++--
 kernel/bpf/states.c                           |  31 +-
 kernel/bpf/verifier.c                         | 387 ++++++++++++---
 .../selftests/bpf/prog_tests/stack_arg.c      | 139 ++++++
 .../selftests/bpf/prog_tests/stack_arg_fail.c |  10 +
 .../bpf/prog_tests/stack_arg_precision.c      |  10 +
 .../selftests/bpf/prog_tests/verifier.c       |   4 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   1 +
 .../bpf/progs/btf__stack_arg_precision.c      |  24 +
 .../bpf/progs/btf__verifier_stack_arg_order.c |  31 ++
 tools/testing/selftests/bpf/progs/stack_arg.c | 253 ++++++++++
 .../selftests/bpf/progs/stack_arg_fail.c      | 114 +++++
 .../selftests/bpf/progs/stack_arg_kfunc.c     | 164 +++++++
 .../selftests/bpf/progs/stack_arg_precision.c | 135 ++++++
 .../selftests/bpf/progs/verifier_jit_inline.c |   2 +-
 .../selftests/bpf/progs/verifier_ldsx.c       |   6 +-
 .../bpf/progs/verifier_private_stack.c        |  10 +-
 .../selftests/bpf/progs/verifier_stack_arg.c  | 445 ++++++++++++++++++
 .../bpf/progs/verifier_stack_arg_order.c      |  87 ++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  72 +++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  26 +
 tools/testing/selftests/bpf/test_loader.c     | 136 +++++-
 42 files changed, 2632 insertions(+), 196 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_arg.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_arg_fail=
.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_arg_prec=
ision.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__stack_arg_prec=
ision.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__verifier_stack=
_arg_order.c
 create mode 100644 tools/testing/selftests/bpf/progs/stack_arg.c
 create mode 100644 tools/testing/selftests/bpf/progs/stack_arg_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/stack_arg_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/stack_arg_precision=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_stack_arg.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_stack_arg_=
order.c

--=20
2.53.0-Meta

