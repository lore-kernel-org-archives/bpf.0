Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8AB40DFC5
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 01:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775093261; cv=none; b=ZKp0jhOa3dKE4iy9nPdi7HdTde1HGUL6dzQWVCUSZ7guUp0YYYlMzv2ofl3ID2W8YCV/IyL9n+9A+aiObJp221WdabMU23IsDFZoT2z0/p2hyzJkaAf4eWVE8/YaRYroXpTz+sER67vChTYPyRZOhERBlVfdu/NcAe2CKER3Nxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775093261; c=relaxed/simple;
	bh=+rFxdb5WWHn0fk1lCxXSU/zgenEc4cpe0R2wL4nGf1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QJOy849YGhhlk/QE4ChR0kM2rfPx2dbPjvWmVEDPPFqD4Tt5NmoXzc11RQ+pSHQqzPR2tu8ptpkCj9gKjMs0KPV+KT43+o6ITYGZqW0MCrYVETxpCsXMBcJRcRCjqc0nCt6r9AdjIIgappKzFyDWZMc0EpnDeu79gBbq4QeBI98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 3AF8C33280467; Wed,  1 Apr 2026 18:27:27 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 00/10] bpf: Support stack arguments for BPF functions and kfuncs 
Date: Wed,  1 Apr 2026 18:27:27 -0700
Message-ID: <20260402012727.3916819-1-yonghong.song@linux.dev>
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
compiler support in LLVM [1]. The compiler emits stores/loads through
a new bpf register r12 (BPF_REG_STACK_ARG_BASE) to pass arguments beyond
the 5th, keeping the stack arg area separate from the r10-based program
stack. The maximum number of arguments is capped at MAX_BPF_FUNC_ARGS
(12), which is sufficient for the vast majority of use cases.

The x86_64 JIT translates r12-relative accesses to RBP-relative
native instructions. Each function's stack allocation is extended
by (incoming + max_outgoing) bytes to hold the stack arg area below
the program stack. This makes implementation easier as the r10 can
be reused for stack argument access. At BPF-to-BPF call sites, outgoing
args are pushed onto the native stack before CALL and popped after
return. For kfunc calls, args are marshaled per the x86_64 C calling
convention (arg 6 in R9, args 7+ on the native stack).

Global subprogs with >5 args are not yet supported. Only x86_64
is supported for now.

For the rest of patches, patches 1-5 added verifier support of
stack arguments for bpf-to-bpf functions and kfunc's. Patch 6
enables x86_64 for stack arguments. Patch 7 implemented JIT for
x86_64. Patches 8-10 are some selftests.

  [1] https://github.com/llvm/llvm-project/pull/189060=20

Yonghong Song (10):
  bpf: Introduce bpf register BPF_REG_STACK_ARG_BASE
  bpf: Reuse MAX_BPF_FUNC_ARGS for maximum number of arguments
  bpf: Support stack arguments for bpf functions
  bpf: Support stack arguments for kfunc calls
  bpf: Reject stack arguments in non-JITed programs
  bpf: Enable stack argument support for x86_64
  bpf,x86: Implement JIT support for stack arguments
  selftests/bpf: Add tests for BPF function stack arguments
  selftests/bpf: Add negative test for oversized kfunc stack argument
  selftests/bpf: Add verifier tests for stack argument validation

 arch/x86/net/bpf_jit_comp.c                   | 150 +++++++-
 include/linux/bpf.h                           |   6 +
 include/linux/bpf_verifier.h                  |  15 +-
 include/linux/filter.h                        |   4 +-
 kernel/bpf/btf.c                              |  21 +-
 kernel/bpf/core.c                             |  12 +-
 kernel/bpf/verifier.c                         | 351 ++++++++++++++++--
 .../selftests/bpf/prog_tests/stack_arg.c      | 143 +++++++
 .../selftests/bpf/prog_tests/stack_arg_fail.c |  24 ++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/stack_arg.c | 111 ++++++
 .../selftests/bpf/progs/stack_arg_fail.c      |  32 ++
 .../selftests/bpf/progs/stack_arg_kfunc.c     |  59 +++
 .../selftests/bpf/progs/verifier_stack_arg.c  | 122 ++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  29 ++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  14 +
 16 files changed, 1045 insertions(+), 50 deletions(-)
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

