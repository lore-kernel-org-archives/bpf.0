Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCB5344DB4
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 21:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778189398; cv=none; b=C4Gac8dV++ALjjh4HCNzZBGVWwdnj/FHSOxnFH6Yc0asUNa2tufwYEc/suuldpeG78XepsZCQYKScqmKjeYRdYSa7KPkUKMT/L8Xp6kvN2Vd4f12xFtz6divyNCZl/j4QBp2/+VaWG6lBAjq2ORyNiZ4r1F8yuZVsfVHBAoLDZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778189398; c=relaxed/simple;
	bh=+nebBLt09ovmcGV6+NaGpMoAnIPKitWpRlwGq9wxWHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LLYO4kqamRFjkRPrtYzlQca0lTmb6KTx+8EnJ3Y957AvOO3P+McyNYAyASlgyc41Ovxw/tTkz3xTcF8fcS6eEB0MXaspKLJnXQyfF0pzf6oyZnIXDJvA4GaIjO1H3RSZ9jixRzEiN/TjJySTKCe+7qvsC0nCNSA9tO5nvyQyE8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id EAD3B92BA3C20; Thu,  7 May 2026 14:29:42 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 00/23] bpf: Support stack arguments for BPF functions and kfuncs
Date: Thu,  7 May 2026 14:29:42 -0700
Message-ID: <20260507212942.1122000-1-yonghong.song@linux.dev>
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

Note:
  - The patch set is on top of the following commit:
    2ca6723a5f7b6 selftests/bpf: Test insns processed breakdown
  - This patch set requires latest llvm23 compiler. It is possible that a=
 build
    failure may appear:
      /home/yhs/work/bpf-next/scripts/mod/modpost.c:59:13: error: variabl=
e 'extra_warn' set but not used [-Werror,-
Wunused-but-set-global]
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

Yonghong Song (20):
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
  bpf,x86: Implement JIT support for stack arguments
  selftests/bpf: Add tests for BPF function stack arguments
  selftests/bpf: Add tests for stack argument validation
  selftests/bpf: Add BTF fixup for __naked subprog parameter names
  selftests/bpf: Add verifier tests for stack argument validation
  selftests/bpf: Add precision backtracking test for stack arguments

 arch/arm64/net/bpf_jit_comp.c                 |  91 +++-
 arch/arm64/net/bpf_timed_may_goto.S           |   8 +-
 arch/x86/net/bpf_jit_comp.c                   | 155 +++++-
 include/linux/bpf.h                           |   2 +
 include/linux/bpf_verifier.h                  |  89 +++-
 include/linux/filter.h                        |  22 +
 kernel/bpf/backtrack.c                        |  87 +++-
 kernel/bpf/btf.c                              |  20 +-
 kernel/bpf/const_fold.c                       |   8 +
 kernel/bpf/core.c                             |   7 +-
 kernel/bpf/fixups.c                           |  29 +-
 kernel/bpf/liveness.c                         | 146 ++++--
 kernel/bpf/states.c                           |  31 +-
 kernel/bpf/verifier.c                         | 388 ++++++++++++---
 .../selftests/bpf/prog_tests/stack_arg.c      | 139 ++++++
 .../selftests/bpf/prog_tests/stack_arg_fail.c |  10 +
 .../bpf/prog_tests/stack_arg_precision.c      |  10 +
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   1 +
 .../bpf/progs/btf__stack_arg_precision.c      |  24 +
 .../bpf/progs/btf__verifier_stack_arg_order.c |  31 ++
 tools/testing/selftests/bpf/progs/stack_arg.c | 253 ++++++++++
 .../selftests/bpf/progs/stack_arg_fail.c      | 114 +++++
 .../selftests/bpf/progs/stack_arg_kfunc.c     | 164 +++++++
 .../selftests/bpf/progs/stack_arg_precision.c | 138 ++++++
 .../selftests/bpf/progs/verifier_jit_inline.c |   2 +-
 .../selftests/bpf/progs/verifier_ldsx.c       |   6 +-
 .../bpf/progs/verifier_private_stack.c        |  10 +-
 .../selftests/bpf/progs/verifier_stack_arg.c  | 445 ++++++++++++++++++
 .../bpf/progs/verifier_stack_arg_order.c      |  87 ++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  72 +++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  26 +
 tools/testing/selftests/bpf/test_loader.c     | 136 +++++-
 33 files changed, 2579 insertions(+), 174 deletions(-)
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

