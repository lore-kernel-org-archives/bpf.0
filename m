Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE1F492E22
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 06:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935138; cv=none; b=ESeU+6Uw53WGJOPfLFkQh3XiOqMagPbim9Lt63OIbAzO15BRdgUYrPaV2FPwVKgFSNTUTV/luZAvP9zLf6UxPqY3VHjkcioQnSShzn8+8yFMvR6vv73kvhneWH5T566HBijPYFBfbC89/YdrCFukPrUpCOymmqmry/nAL7mh5jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935138; c=relaxed/simple;
	bh=wT8rqemWx/1fzuGCBmEddV/xxQklLhPZKrXzYpd227U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=onGn9KmdpdVL46PiKlN6e77fHuJrC49rlVJDA8gOxqu0XZGdXnuB99QB2lte/eh5cHFPwXdgb1LtmEbKYkStxaoKbwOFtkdwasYbJXrYGwJ/Hm5aPvVTqnKL8FCNDD09eanvPEos8+XREhnqwGr/os8Pfy7+DEf+kzp+Tax4sYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id F2467299468AA0; Tue,  8 Sep 2026 23:25:22 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 00/12] bpf: Support by-value struct and __int128 arguments
Date: Tue,  8 Sep 2026 23:25:22 -0700
Message-ID: <20260909062522.4001896-1-yonghong.song@linux.dev>
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
register and the stack, x86_64 moves the whole of it to the stack and giv=
es
the register to the argument that follows, while arm64 rounds the
register number up to an even one for a 16-byte aligned value. For stack
arguments, both x86_64 and arm64 will have 16-byte alignment for those
16-byte aligned parameters. Otherwise the alignment will be 8-byte.
This is implemented in x86_64 and arm64 jit.

Patch 1 records the __int128 failure as it stands today, which patch 4
turns into a success. Patches 2 to 4 index the arguments of a global
function by slot and accept a by-value struct and an __int128. Patches 6
and 7 have the same for a kfunc call. Patches 8 and 9 place the arguments
per the kernel calling convention in the x86-64 and arm64 JITs.
Patches 10 to 12 are the tests.

Tested on x86-64 and arm64 with test_progs. The by-value struct tests are
built with clang, as GCC passes an aggregate by invisible reference, and
some of them need __BPF_FEATURE_STACK_ARGUMENT.

Changelog:
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20260904050957.3976119-1-yonghong.s=
ong@linux.dev/
    - Fix a few issues due to potential out of bound access.
    - Fix a few missed cases for kfunc with '> 8 byte' arguments.
    - Add jit support for x86_64 and arm64. Previously certain functions =
are rejected,
      and now these functions can succeed.

Yonghong Song (12):
  selftests/bpf: Add a test for an __int128 by-value argument
  bpf: Index global function arguments by argument slot
  bpf: Support by-value struct arguments up to 16 bytes
  bpf: Support __int128 as a by-value function argument
  bpf: Rename bpf_call_summary::num_params to arg_slot_cnt
  bpf: Recognize by-value struct and __int128 kfunc arguments
  bpf: Prepare kfunc arguments for the JIT from an ABI description
  bpf, x86: Move kfunc arguments into the x86-64 calling convention
  bpf, arm64: Move kfunc arguments into the arm64 calling convention
  selftests/bpf: Add C tests for by-value arguments up to 16 bytes
  selftests/bpf: Add inline-asm tests for by-value arguments
  selftests/bpf: Add tests for by-value kfunc arguments

 arch/arm64/net/bpf_jit_comp.c                 |  77 +++++-
 arch/x86/net/bpf_jit_comp.c                   |  73 +++++-
 include/linux/bpf.h                           |   8 +
 include/linux/bpf_verifier.h                  |   3 +-
 include/linux/filter.h                        |  32 +++
 kernel/bpf/btf.c                              |  94 +++++--
 kernel/bpf/core.c                             |  94 +++++++
 kernel/bpf/liveness.c                         |  10 +-
 kernel/bpf/verifier.c                         | 239 +++++++++++++++---
 .../selftests/bpf/prog_tests/aggregate_arg.c  |  11 +
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/aggregate_arg_func.c  | 155 ++++++++++++
 .../selftests/bpf/progs/aggregate_arg_kfunc.c | 221 ++++++++++++++++
 .../testing/selftests/bpf/progs/arena_kfunc.c |  16 ++
 .../selftests/bpf/progs/stack_arg_fail.c      |  10 -
 .../selftests/bpf/progs/verifier_int128_arg.c | 196 ++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  77 ++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  32 +++
 18 files changed, 1271 insertions(+), 79 deletions(-)
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

