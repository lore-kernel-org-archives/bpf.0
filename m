Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CBB3128BE
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775407994; cv=none; b=cwiu8F9mkDbzK16jccSA1X5d+38VbEWJUNPcobhVeDImVbavr3ukgZ2qPiCPu6esIUjbs8yv5U0RQAeFyosqdacRn+u8do9PUm0eVMt5G/A1ih6DV/MYYsaPGPqOElM7iRu8Yt9DORXiYApmReSpOa6CMDsOQyb4vk5TImvXCPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775407994; c=relaxed/simple;
	bh=dGDOJfOa7JdcE8+903OcPk6iO9GpJp951Tpk6hQa06A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fUUiP+XXCpThHLgcA8/QTXhGGDzf7qgC3KrkVZAlQTNWQaa8SxjCQrKmiay14uqkJJLg8upwVmuJHvyt2cps5/Pc9hLPDDhWyjk00scrj68hnfMJfdKgecBJoZAtBdu4e0yxkJHp5YcRAuLYBMU0y4pc7PW1rHPtLiqNFLnXKNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 7322C361CEEDD; Sun,  5 Apr 2026 09:53:00 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 00/11] bpf: Support stack arguments for BPF functions and kfuncs
Date: Sun,  5 Apr 2026 09:53:00 -0700
Message-ID: <20260405165300.826241-1-yonghong.song@linux.dev>
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
a new bpf register r12 (BPF_REG_STACK_ARG_BASE) to pass arguments beyond
the 5th, keeping the stack arg area separate from the r10-based program
stack. The maximum number of arguments is capped at MAX_BPF_FUNC_ARGS
(12), which is sufficient for the vast majority of use cases.

The x86_64 JIT translates r12-relative accesses to RBP-relative
native instructions. Each function's stack allocation is extended
by 'max_outgoing' bytes to hold the outgoing arg area below the
program stack. This makes implementation easier as the r10 can be
reused for stack argument access. At BPF-to-BPF call sites, outgoing
args are pushed onto the native stack before CALL. The incoming
parameters can directly get the value from pushed native stack from
caller. For kfunc calls, args are marshaled per the x86_64 C calling
convention (arg 6 in R9, args 7+ on the native stack).

Global subprogs with >5 args are not yet supported. Only x86_64
is supported for now.

For the rest of patches, patches 1-6 added verifier support of
stack arguments for bpf-to-bpf functions and kfunc's. Patch 7
enables x86_64 for stack arguments. Patch 8 implemented JIT for
x86_64. Patches 9-11 are some selftests.

  [1] https://github.com/llvm/llvm-project/pull/189060

Changelogs:
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

Yonghong Song (11):
  bpf: Introduce bpf register BPF_REG_STACK_ARG_BASE
  bpf: Reuse MAX_BPF_FUNC_ARGS for maximum number of arguments
  bpf: Support stack arguments for bpf functions
  bpf: Refactor process_iter_arg() to have proper argument index
  bpf: Support stack arguments for kfunc calls
  bpf: Reject stack arguments in non-JITed programs
  bpf: Enable stack argument support for x86_64
  bpf,x86: Implement JIT support for stack arguments
  selftests/bpf: Add tests for BPF function stack arguments
  selftests/bpf: Add negative test for greater-than-8-byte kfunc stack
    argument
  selftests/bpf: Add verifier tests for stack argument validation

 arch/x86/net/bpf_jit_comp.c                   | 140 +++++-
 include/linux/bpf.h                           |   6 +
 include/linux/bpf_verifier.h                  |  31 +-
 include/linux/filter.h                        |   4 +-
 kernel/bpf/btf.c                              |  21 +-
 kernel/bpf/core.c                             |  12 +-
 kernel/bpf/verifier.c                         | 474 ++++++++++++++++--
 .../selftests/bpf/prog_tests/stack_arg.c      | 132 +++++
 .../selftests/bpf/prog_tests/stack_arg_fail.c |  24 +
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/stack_arg.c | 212 ++++++++
 .../selftests/bpf/progs/stack_arg_fail.c      |  32 ++
 .../selftests/bpf/progs/stack_arg_kfunc.c     | 164 ++++++
 .../selftests/bpf/progs/verifier_stack_arg.c  | 302 +++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  72 +++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  26 +
 16 files changed, 1594 insertions(+), 60 deletions(-)
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

