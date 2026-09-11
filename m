Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D30648C8A3
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141770; cv=none; b=IrHTa+F/IUE44o3STeHmd/rPiVeSl5J7sdgIZpRhCcA+gAH0LviQ2pBJgmQM9F19LO5G3Rqzq2maPwgIF5K9N/OO5MIPiTEreTnEoONJ9x5uTscb3WkYDh1YM685lGH82/iUwHk9WF5ESiP7+drByUaJl/XylmWY4cM5ARc8LEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141770; c=relaxed/simple;
	bh=eqtgDzZABPgblT/cclDsM+FpUX7X/G4Jlc7Yvwx1Qkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KR6lxsifL0N1re+ATrbrtLPjHSTdcWRgtRoiE+P9xfNTBhC0jBlPFnHlYnB/twDwX36iF8TdP1vFbB5s6KhChjSFgPQrKg0Xt7O5KKoEHE2dj7Jq9kpwmx4jOShwaCl2zGaoNa1r5i7Wi1rBxWzMlOscUxRGeNuP8s2EoKDnlzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 3C6752A1842F50; Fri, 11 Sep 2026 08:49:14 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 00/15] bpf: Support by-value struct and __int128 arguments
Date: Fri, 11 Sep 2026 08:49:14 -0700
Message-ID: <20260911154914.2004336-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
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

Patch 1 fixed a pre-existing bug in bpf_kfunc_stack_access_bytes().
Patch 2 records the __int128 failure as it stands today, which patch 6
turns into a success. Patches 3 to 6 rename some fields, index the
arguments of a global function by slot and accept a by-value struct and
an __int128. Patches 8 and 9 have the same for a kfunc call. Patches 10
and 11 place the arguments per the kernel calling convention in the
x86-64 and arm64 JITs. Patches 12 to 14 are the tests. Patch 15 removes
some tests which requires pahole patch:
  https://lore.kernel.org/bpf/20260911040955.339939-1-yonghong.song@linux=
.dev/
Once pahole patch is merged, the patch 15 can be removed.

Tested on x86-64 and arm64 with test_progs. The by-value struct tests are
built with clang, as GCC passes an aggregate by invisible reference, and
some of them need __BPF_FEATURE_STACK_ARGUMENT.

Changelog:
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
  bpf, arm64: Move kfunc arguments into the arm64 calling convention
  selftests/bpf: Add C tests for by-value arguments up to 16 bytes
  selftests/bpf: Add inline-asm tests for by-value arguments
  selftests/bpf: Add tests for by-value kfunc arguments
  selftests/bpf: Temporary hack to disable register mismatch in arm64

 arch/arm64/net/bpf_jit_comp.c                 |  92 +++++-
 arch/x86/net/bpf_jit_comp.c                   |  73 ++++-
 include/linux/bpf.h                           |  15 +
 include/linux/bpf_verifier.h                  |   9 +-
 include/linux/filter.h                        |  32 ++
 kernel/bpf/btf.c                              | 124 ++++++--
 kernel/bpf/core.c                             |  94 ++++++
 kernel/bpf/liveness.c                         |  10 +-
 kernel/bpf/verifier.c                         | 287 ++++++++++++++----
 .../selftests/bpf/prog_tests/aggregate_arg.c  |  11 +
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/aggregate_arg_func.c  | 187 ++++++++++++
 .../selftests/bpf/progs/aggregate_arg_kfunc.c | 235 ++++++++++++++
 .../testing/selftests/bpf/progs/arena_kfunc.c |  15 +
 .../selftests/bpf/progs/stack_arg_fail.c      |  10 -
 .../bpf/progs/verifier_aggregate_arg.c        | 200 ++++++++++++
 .../bpf/progs/verifier_stack_arg_order.c      |   4 +-
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  81 +++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  34 +++
 19 files changed, 1396 insertions(+), 119 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/aggregate_arg.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_arg_func.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_arg_kfunc=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_aggregate_=
arg.c

--=20
2.52.0

