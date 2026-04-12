Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F3636405E
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 04:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775969920; cv=none; b=Se1n/ttpAwR7F2NcHh0mBe1Lx5lhcwLebJSQ/pctpWjXlUqF2QOYhvhNOnJKSihxZV7gU+IaPT+TYH/aQvQnyrv7RAK89/eK/3NKS79lRFVrAiCWg3Fm8XVlFOzBQjC95U/OopP91dQtsbuOWTS/74rttv0fNUVXyP4AlSp4lIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775969920; c=relaxed/simple;
	bh=FJwV/3YIiXsDMc6FCg2kHYyfX3nDGLXkrNn8uTHxDls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f0swGTL0AgXkqJqxLEMO/DC0KZN7svcEQtzq6r03YbEGxR68HK9r8EpFpWpS+6K6R8rKTeomNtlcI6SLmq6a94GSK+z2bKAHlMIgsNNhCAHt/lH4uyvyC6d1NjWfzercvjoJJ9lXiJb6XBVllwz1Wlpq8EU5nA6C2ytnjgCidbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id AE7723B02193A; Sat, 11 Apr 2026 21:58:26 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 00/18] bpf: Support stack arguments for BPF functions and kfuncs
Date: Sat, 11 Apr 2026 21:58:26 -0700
Message-ID: <20260412045826.254200-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently, bpf function calls and kfunc's are limited by 5 reg-level
parameters. For function calls with more than 5 parameters,
developers can use always inlining or pass a struct pointer
after packing more parameters in that struct. But there is
no workaround for kfunc if more than 5 parameters is needed.

This patch set lifts the 5-argument limit by introducing stack-based
argument passing for BPF functions and kfunc's, coordinated with
compiler support in LLVM [1]. The compiler emits loads/stores through
a new bpf register r12 (BPF_REG_STACK_ARG_BASE) to pass arguments beyond
the 5th, keeping the stack arg area separate from the r10-based program
stack. The maximum number of arguments is capped at MAX_BPF_FUNC_ARGS
(12), which is sufficient for the vast majority of use cases.

The x86_64 JIT translates r12-relative accesses to RBP-relative
native instructions. Each function's stack allocation is extended
by 'max_outgoing' bytes to hold the outgoing arg area below the
callee-saved registers. This makes implementation easier as the r10 can b=
e
reused for stack argument access. At both BPF-to-BPF and kfunc calls,
outgoing args are pushed onto the expected calling convention locations
directly. The incoming parameters can directly get the value from
caller.

To support kfunc stack arguments, before doing any stack arguments,
existing codes are refactored/modified to use bpf_reg_state as much
as possible instead of using regno, and to pass regno/argno in a
single variable where non-negative means regno and negative means argno.

Global subprogs with >5 args are not yet supported. Only x86_64
is supported for now.

For the rest of patches, patches 1-6 make changes to make it
easy for future stack arguments for kfuncs. Patches 7-10
supports bpf-to-bpf stack arguments. Patch 11 rejects interpreter
for stack arguments. Patch 12 rejects subprogs if tailcall reachable.
Patch 13 adds stack argument support for kfuncs. Patch 14 enables
stack arguments for x86_64 and Patch 15 implements the x86_64 JIT.
Patches 16-18 are some test cases.

  [1] https://github.com/llvm/llvm-project/pull/189060

Note:
  - The patch set is on top of the following commit:
    2ec74a053611  bpf: Simplify do_check_insn()
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
=20
       KBUILD_USERHOSTCFLAGS :=3D -Wall -Wmissing-prototypes -Wstrict-pro=
totypes \
      -                        -O2 -fomit-frame-pointer -std=3Dgnu11
      +                        -O2 -fomit-frame-pointer -std=3Dgnu11 -Wno=
-unused-but-set-global
       KBUILD_USERCFLAGS  :=3D $(KBUILD_USERHOSTCFLAGS) $(USERCFLAGS)
       KBUILD_USERLDFLAGS :=3D $(USERLDFLAGS)

Changelogs:
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

Yonghong Song (18):
  bpf: Remove unused parameter from check_map_kptr_access()
  bpf: Change from "arg #%d" to "arg#%d" in verifier log
  bpf: Refactor to avoid redundant calculation of bpf_reg_state
  bpf: Refactor to handle memory and size together
  bpf: Change some regno type from u32 to int type
  bpf: Use argument index instead of register index in kfunc verifier
    logs
  bpf: Introduce bpf register BPF_REG_STACK_ARG_BASE
  bpf: Reuse MAX_BPF_FUNC_ARGS for maximum number of arguments
  bpf: Support stack arguments for bpf functions
  bpf: Fix interaction between stack argument PTR_TO_STACK and dead slot
    poisoning
  bpf: Reject stack arguments in non-JITed programs
  bpf: Reject stack arguments if tail call reachable
  bpf: Support stack arguments for kfunc calls
  bpf: Enable stack argument support for x86_64
  bpf,x86: Implement JIT support for stack arguments
  selftests/bpf: Add tests for BPF function stack arguments
  selftests/bpf: Add negative test for greater-than-8-byte kfunc stack
    argument
  selftests/bpf: Add verifier tests for stack argument validation

 arch/x86/net/bpf_jit_comp.c                   |  177 ++-
 include/linux/bpf.h                           |    6 +
 include/linux/bpf_verifier.h                  |   32 +-
 include/linux/filter.h                        |    4 +-
 kernel/bpf/btf.c                              |   21 +-
 kernel/bpf/core.c                             |   12 +-
 kernel/bpf/verifier.c                         | 1038 ++++++++++++-----
 .../selftests/bpf/prog_tests/cb_refs.c        |    2 +-
 .../selftests/bpf/prog_tests/linked_list.c    |    4 +-
 .../selftests/bpf/prog_tests/stack_arg.c      |  132 +++
 .../selftests/bpf/prog_tests/stack_arg_fail.c |   24 +
 .../selftests/bpf/prog_tests/verifier.c       |    2 +
 .../selftests/bpf/progs/cpumask_failure.c     |    4 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |   26 +-
 .../selftests/bpf/progs/file_reader_fail.c    |    4 +-
 .../selftests/bpf/progs/iters_state_safety.c  |   14 +-
 .../selftests/bpf/progs/iters_testmod.c       |    6 +-
 .../selftests/bpf/progs/iters_testmod_seq.c   |    4 +-
 .../bpf/progs/local_kptr_stash_fail.c         |    2 +-
 .../selftests/bpf/progs/map_kptr_fail.c       |    4 +-
 .../bpf/progs/mem_rdonly_untrusted.c          |    2 +-
 .../bpf/progs/nested_trust_failure.c          |    2 +-
 .../selftests/bpf/progs/res_spin_lock_fail.c  |    2 +-
 tools/testing/selftests/bpf/progs/stack_arg.c |  212 ++++
 .../selftests/bpf/progs/stack_arg_fail.c      |   32 +
 .../selftests/bpf/progs/stack_arg_kfunc.c     |  164 +++
 .../testing/selftests/bpf/progs/stream_fail.c |    2 +-
 .../selftests/bpf/progs/task_kfunc_failure.c  |    4 +-
 .../selftests/bpf/progs/verifier_bits_iter.c  |    4 +-
 .../bpf/progs/verifier_cgroup_storage.c       |    4 +-
 .../selftests/bpf/progs/verifier_ctx.c        |    2 +-
 .../bpf/progs/verifier_ref_tracking.c         |    2 +-
 .../selftests/bpf/progs/verifier_sock.c       |    6 +-
 .../selftests/bpf/progs/verifier_stack_arg.c  |  316 +++++
 .../selftests/bpf/progs/verifier_unpriv.c     |    4 +-
 .../selftests/bpf/progs/verifier_vfs_reject.c |    8 +-
 .../testing/selftests/bpf/progs/wq_failures.c |    4 +-
 .../selftests/bpf/test_kmods/bpf_testmod.c    |   73 ++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   26 +
 tools/testing/selftests/bpf/verifier/calls.c  |    6 +-
 .../testing/selftests/bpf/verifier/map_kptr.c |   10 +-
 41 files changed, 1996 insertions(+), 407 deletions(-)
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

