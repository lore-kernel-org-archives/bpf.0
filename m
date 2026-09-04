Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117E73F928E
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 05:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788498612; cv=none; b=WDmMu/WEggumbDat8FDosfq4m4Wx9bNNfoDcb5fXAH6GqN5EL6KEgyF1fBeGsQE6pFJjluE3HlqOYj0i27rOwhw/wMONWxeBYi5n/iQ61lrNUYqzld8VgInyfxvIuzGFf4enhyo7wU+ST2pc+jBQyI56muogtza7HWyeGA4XdHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788498612; c=relaxed/simple;
	bh=Gznkp0qjUJd1rgFs7tiTsQkyKeKL3014HZbIsvVUwgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u4CczCQ6bS9hWsBiv2EWz56qP14eG3jdDjL6KY7ME7ShQeQMnRRABfVWI+cK+eepeHBJFyyetvQtqsEwC9vIEXW3It1Wd6O6EeUJdycXup1EjIDiidJYmqU8NREVOeIVbqeBdh1dtGrtQy9MV1r6a3lKAR0PdYAw2Yj9DGC8ZQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id B341A28813164B; Thu,  3 Sep 2026 22:09:57 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 00/12] bpf: Support by-value struct and __int128 arguments
Date: Thu,  3 Sep 2026 22:09:57 -0700
Message-ID: <20260904050957.3976119-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A global function or a kfunc taking a struct or union by value is rejecte=
d
today:

  Arg#1 type STRUCT in tar() is not supported yet.
  Unrecognized R2 type STRUCT

and an __int128 argument is accepted but mis-counted: the compiler passes
it in two registers while the verifier gives it one, so every argument
after it is checked against the wrong register and the program is rejecte=
d
for a register its source never names.

The compiler passes such a value in one argument register per eightbyte,
so a value of at most 16 bytes arrives in one or two consecutive
registers. This series teaches the verifier to describe that: sub->args[]
gains one entry per argument slot rather than one per BTF parameter, and
the kfunc argument walk counts slots the same way. A value may only be
composed of scalars, as a pointer would reach the callee as an opaque
scalar, losing the provenance and reference tracking that make it safe to
use. A global function still has no stack arguments, so all of its slots
have to fit in the argument registers.

For a kfunc the two calling conventions have to agree, and they do not
always. Where the BPF convention splits a value between the last argument
register and the stack, SysV moves the whole of it to the stack and gives
the register to the argument that follows, while AAPCS64 rounds the
register number up to an even one for a 16-byte aligned value and gives n=
o
register to anything once one has gone to the stack. The JITs move the
eightbytes the two conventions place differently, and
bpf_jit_supports_kfunc_arg_slot() asks the JIT whether it can, defaulting
to no, so such an argument is refused on an architecture that has not
implemented the placement:

  Function f arg#5 type STRUCT cannot be passed at argument slot 5 on thi=
s
  architecture

Patch 1 records the __int128 failure as it stands today, which patch 4
turns into a success. Patches 2 to 4 index the arguments of a global
function by slot and accept a by-value struct and an __int128. Patch 5
does the same for a kfunc call. Patches 6 to 9 place the arguments per th=
e
kernel calling convention in the x86-64 and arm64 JITs. Patches 10 to 12
are the tests.

Tested on x86-64 and arm64 with test_progs. The by-value struct tests are
built with clang, as GCC passes an aggregate by invisible reference, and
some of them need __BPF_FEATURE_STACK_ARGUMENT.

Yonghong Song (12):
  selftests/bpf: Add a test for an __int128 by-value argument
  bpf: Index global function arguments by argument slot
  bpf: Support by-value struct arguments up to 16 bytes
  bpf: Support __int128 as a by-value function argument
  bpf: Support by-value struct and __int128 kfunc arguments
  bpf: Add a JIT helper for the outgoing stack of kfunc calls
  bpf, x86: Place kfunc arguments per the SysV calling convention
  bpf: Record a 16-byte argument alignment in the function model
  bpf, arm64: Place kfunc arguments per AAPCS64
  selftests/bpf: Add C tests for by-value arguments up to 16 bytes
  selftests/bpf: Add inline-asm tests for by-value arguments
  selftests/bpf: Add tests for by-value kfunc arguments

 arch/arm64/net/bpf_jit_comp.c                 | 112 +++++++++-
 arch/x86/net/bpf_jit_comp.c                   | 185 +++++++++++++++-
 include/linux/bpf.h                           |   3 +
 include/linux/bpf_verifier.h                  |   1 +
 include/linux/filter.h                        |   3 +
 kernel/bpf/btf.c                              |  98 +++++++--
 kernel/bpf/core.c                             |  42 ++++
 kernel/bpf/verifier.c                         | 200 ++++++++++++++++--
 .../selftests/bpf/prog_tests/aggregate_arg.c  |  11 +
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/aggregate_arg_func.c  | 155 ++++++++++++++
 .../selftests/bpf/progs/aggregate_arg_kfunc.c | 106 ++++++++++
 .../testing/selftests/bpf/progs/arena_kfunc.c |  16 ++
 .../selftests/bpf/progs/stack_arg_fail.c      |  10 -
 .../selftests/bpf/progs/verifier_int128_arg.c | 195 +++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  40 ++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  22 ++
 17 files changed, 1151 insertions(+), 50 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/aggregate_arg.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_arg_func.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_arg_kfunc=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_int128_arg=
.c

--=20
2.53.0-Meta

