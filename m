Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AF52C11E2
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050888; cv=none; b=T1ABke2NQ5f6xzlpgx+8LtYsfg0Db+LBvFytn3bKqsb7/arWm4607pesavgyL9E6j2o+7684tVOTjNeTgEPIckveAYmMEPBDmfviMaQMeYuoeLBW+4M8hXv6cixfHxQ8HhvOf2AWJv0Cc1Qy3QxS9ERE8Qapw/AUOrxTyhURhUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050888; c=relaxed/simple;
	bh=9Z0pYyTxcWXJt96fEXC43JcK5ifuPuzmpLZbpKGAf/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gBUX143W+YLNeQeOAwIppuYJ3FyhSeo79Dr9XsKXhFllpHYwhhPyJwlB/CzGaZOOSaCkRQy9lM+N6KX3GRN0BQT9wUiv3KweM5hMzZ7497MCMzckDjRwmXjbugZhaZ0//jMeGU7IeFnhMsnbQV+XVPcwLd9ekTu/CKjZTDDyiLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id BB5A9474A6401; Fri, 24 Apr 2026 10:14:33 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 00/18] bpf: Support stack arguments for BPF functions and kfuncs
Date: Fri, 24 Apr 2026 10:14:33 -0700
Message-ID: <20260424171433.2034470-1-yonghong.song@linux.dev>
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

To support kfunc stack arguments, before doing any stack arguments,
existing codes are refactored/modified to use bpf_reg_state as much
as possible instead of using regno, and to pass a non-negative argno,
encoded to support both registers and stack arguments, as a single
variable.

Global subprogs and freplace progs with >5 args are not yet supported.
Only x86_64 and arm64 are supported for now. Same selftests are tested
by both x86_64 and arm64. Please see each individual patch for details.

  [1] https://github.com/llvm/llvm-project/pull/189060

Note:
  - The patch set is on top of the following commit:
    fd30cf86e1194 Merge branch 'bpf-prepare-to-support-stack-arguments'
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

Puranjay Mohan (3):
  bpf, arm64: Map BPF_REG_0 to x8 instead of x7
  bpf, arm64: Add JIT support for stack arguments
  selftests/bpf: Enable stack argument tests for arm64

Yonghong Song (15):
  bpf: Support stack arguments for bpf functions
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
  selftests/bpf: Add verifier tests for stack argument validation
  selftests/bpf: Add BTF fixup for __naked subprog parameter names
  selftests/bpf: Add precision backtracking test for stack arguments

 arch/arm64/net/bpf_jit_comp.c                 |  91 +++-
 arch/arm64/net/bpf_timed_may_goto.S           |   8 +-
 arch/x86/net/bpf_jit_comp.c                   | 154 +++++-
 include/linux/bpf.h                           |   2 +
 include/linux/bpf_verifier.h                  |  42 +-
 include/linux/filter.h                        |   1 +
 kernel/bpf/backtrack.c                        |  61 ++-
 kernel/bpf/btf.c                              |  20 +-
 kernel/bpf/const_fold.c                       |  13 +-
 kernel/bpf/core.c                             |   7 +-
 kernel/bpf/fixups.c                           |  28 +-
 kernel/bpf/liveness.c                         | 200 ++++++--
 kernel/bpf/states.c                           |  31 ++
 kernel/bpf/verifier.c                         | 347 +++++++++++--
 .../selftests/bpf/prog_tests/stack_arg.c      | 139 ++++++
 .../selftests/bpf/prog_tests/stack_arg_fail.c |  10 +
 .../bpf/prog_tests/stack_arg_precision.c      |  10 +
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   1 +
 .../bpf/progs/btf__stack_arg_precision.c      |  24 +
 tools/testing/selftests/bpf/progs/stack_arg.c | 253 ++++++++++
 .../selftests/bpf/progs/stack_arg_fail.c      | 114 +++++
 .../selftests/bpf/progs/stack_arg_kfunc.c     | 164 +++++++
 .../selftests/bpf/progs/stack_arg_precision.c | 122 +++++
 .../selftests/bpf/progs/verifier_jit_inline.c |   2 +-
 .../selftests/bpf/progs/verifier_ldsx.c       |   6 +-
 .../bpf/progs/verifier_private_stack.c        |  10 +-
 .../selftests/bpf/progs/verifier_stack_arg.c  | 457 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  72 +++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  26 +
 tools/testing/selftests/bpf/test_loader.c     | 136 +++++-
 31 files changed, 2448 insertions(+), 105 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_arg.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_arg_fail=
.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_arg_prec=
ision.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__stack_arg_prec=
ision.c
 create mode 100644 tools/testing/selftests/bpf/progs/stack_arg.c
 create mode 100644 tools/testing/selftests/bpf/progs/stack_arg_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/stack_arg_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/stack_arg_precision=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_stack_arg.=
c

--=20
2.52.0

