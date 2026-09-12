Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12C438E8CB
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789242731; cv=none; b=XUsZ+p0Ky8wmeOnl/FDYG0aU/UPrls5vYUtWfAtz1IjlFyHNURkEIE6J8xIu+WKx5zgCKZC9FVSQNxGdKtXYA2vXu6TWxFsuUPoSRqEqVgJa+QLlw1w9Z3wyp02KEIMXefTHcu9BAUuD2rZYf+IDd2Mk1HzoCzE6JQdBda0u+ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789242731; c=relaxed/simple;
	bh=ZGnEYXdqBiy4xgKC2uWIUsKu2uiMf70niQlniGxhLE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l7vvc5YFJZwuUsEZbpVsbpyYc2w/P+9CKzXSsg4PJBWDP1v/0D6jAIwRpT2zfCq/5wBgfcukfnJA8awyvgfTpqid/PxncMN8RyOdFVr/S9nMte3qchLjAKF1sByBHFTcd4OrRugFASoxwqSAUbk+cynVEp7/P7WbZ2vaVU2dD3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 5C9652A58A0AE4; Sat, 12 Sep 2026 12:51:56 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 00/15] bpf: Support by-value struct and __int128 arguments
Date: Sat, 12 Sep 2026 12:51:56 -0700
Message-ID: <20260912195156.980886-1-yonghong.song@linux.dev>
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

arm64 has some issues with trampolines due to certain 16-byte align
requirement, similar to 16-byte align for kfunc arguments. calc_arg_aux()=
,
save_args() and restore_args() all need changes to cope with 16-byte
alignment.

Patch 1 fixed a pre-existing bug in bpf_kfunc_stack_access_bytes().
Patch 2 records the __int128 failure as it stands today, which patch 6
turns into a success. Patches 3 to 6 rename some fields, index the
arguments of a global function by slot and accept a by-value struct and
an __int128. Patches 8 and 9 have the same for a kfunc call. Patches 10
to 12 place the arguments per the kernel calling convention in the
x86-64 and arm64 JITs. Patches 13 to 15 are the tests.

Tested on x86-64 and arm64 with test_progs. The by-value struct tests are
built with clang, as GCC passes an aggregate by invisible reference, and
some of them need __BPF_FEATURE_STACK_ARGUMENT.

Changelog:
  v3 -> v4:
    - v3: https://lore.kernel.org/bpf/20260911154914.2004336-1-yonghong.s=
ong@linux.dev/
    - Rebase on top master branch. Mostly no change except the commit
      "Recognize by-value struct and __int128 kfunc arguments" which need=
s
      some adjustment.
    - Commit "bpf, arm64: Place trampoline arguments by the arm64 calling=
 convention"
      is new. The commit intends to fix the bug when any argument has 16-=
byte alignment
      requirement.
  v2 -> v3:
    - v2: https://lore.kernel.org/bpf/20260909062522.4001896-1-yonghong.s=
ong@linux.dev/
    - Rename test name from verifier_int_arg to verifier_aggregate_arg.
    - Rename from arg_cnt to arg_slot_cnt to make codes easy to understan=
d.
    - Fix an issue for by-value struct arguments up to 16 bytes where the=
 bound check,
      e.g. number of slots is more than 5 or not, etc, is missing after a=
ll arguments
      are processed.
    - Increase local slot size from MAX_BPF_FUNC_ARGS to 2 * MAX_BPF_FUNC=
_ARGS to
      avoid out-of-bound write.
    - One codegen improvement for arm64 jit.
    - Added a not-to-merge patch (patch 15) to workaround some tests. The=
 pahole patch
        https://lore.kernel.org/bpf/20260911040955.339939-1-yonghong.song=
@linux.dev/
      is pending.
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20260904050957.3976119-1-yonghong.s=
ong@linux.dev/
    - Fix a few issues due to potential out of bound access.
    - Fix a few missed cases for kfunc with '> 8 byte' arguments.
    - Add jit support for x86_64 and arm64. Previously certain functions =
are rejected,
      and now these functions can succeed.

Yonghong Song (15):
  bpf: Read a kfunc's __sz argument only when it is in a register
  selftests/bpf: Add a test for an __int128 by-value argument
  bpf: Rename bpf_subprog_info::arg_cnt to arg_slot_cnt
  bpf: Index global function arguments by argument slot
  bpf: Support by-value struct arguments up to 16 bytes
  bpf: Support __int128 as a by-value function argument
  bpf: Rename bpf_call_summary::num_params to arg_slot_cnt
  bpf: Recognize by-value struct and __int128 kfunc arguments
  bpf: Prepare kfunc arguments for the JIT from an ABI description
  bpf, x86: Move kfunc arguments into the x86-64 calling convention
  bpf, arm64: Place trampoline arguments by the arm64 calling convention
  bpf, arm64: Move kfunc arguments into the arm64 calling convention
  selftests/bpf: Add C tests for by-value arguments up to 16 bytes
  selftests/bpf: Add inline-asm tests for by-value arguments
  selftests/bpf: Add tests for by-value kfunc arguments

 arch/arm64/net/bpf_jit_comp.c                 | 146 +++++++--
 arch/x86/net/bpf_jit_comp.c                   |  78 ++++-
 include/linux/bpf.h                           |  15 +
 include/linux/bpf_verifier.h                  |   9 +-
 include/linux/filter.h                        |  32 ++
 kernel/bpf/btf.c                              | 124 ++++++--
 kernel/bpf/core.c                             |  94 ++++++
 kernel/bpf/liveness.c                         |  10 +-
 kernel/bpf/verifier.c                         | 298 +++++++++++++++---
 .../selftests/bpf/prog_tests/aggregate_arg.c  |  11 +
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/aggregate_arg_func.c  | 188 +++++++++++
 .../selftests/bpf/progs/aggregate_arg_kfunc.c | 168 ++++++++++
 .../testing/selftests/bpf/progs/arena_kfunc.c |  15 +
 .../selftests/bpf/progs/stack_arg_fail.c      |  10 -
 .../bpf/progs/verifier_aggregate_arg.c        | 200 ++++++++++++
 .../bpf/progs/verifier_stack_arg_order.c      |   4 +-
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  59 +++-
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  27 ++
 19 files changed, 1348 insertions(+), 142 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/aggregate_arg.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_arg_func.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_arg_kfunc=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_aggregate_=
arg.c

--=20
2.53.0-Meta

