Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509B03F8EC9
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 20:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785875740; cv=none; b=k+OqBgtBgVDSfyFMvWVZTXFNFf6QF860TAisXci9t4c30gEtGKbZu/fCJf7NbaeVBheKbSgn4XBbXolRIY873M/XX2Rx+YwezG8/Epi+xT0yxnYpfhPHAIjhKAIf90dE6f2c+42dfwoyDG6xeG89ZN9PtmSjkPqftksCSpn6prY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785875740; c=relaxed/simple;
	bh=lxfN5M5zIcuYrH9Sj+h7oKo+kh/92U1IVX+e3FdRfFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rhxxPWm5LBIHOx4rvyZrXxcvR48TxqUtbv1KeGdM8rNULkIm0CCavqYHO2SJvCEppgPPTvz05Knu7odIHg0Bdvk+J5FzTPDciCpJ83b72iosMa1ipP4f1OMvLouN/F/KAGqCMm934g0tRPZsXsbGp7XBmQhyruXPgM0RWd9CeVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id AD68721FBFEA5C; Tue,  4 Aug 2026 13:35:22 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH v2 00/13] bpf: Support aggregate return values up to 16 bytes
Date: Tue,  4 Aug 2026 13:35:22 -0700
Message-ID: <20260804203522.1869244-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

LLVM 23 can return an __int128, or a struct/union larger than 8 bytes and
no larger than 16 bytes, in the BPF R0:R2 register pair [1][2]. Before
that the BPF backend could not return such values at all: a by-value
aggregate return was rejected at compile time with "aggregate returns are
not supported", and an __int128 return failed in the backend with "unable
to allocate function return #1".

This series teaches the kernel the same convention, so that BPF programs
and kfuncs can return these values. The first 8 bytes of the value come
back in R0 and the second 8 bytes in R2. It applies to kfunc returns and
to BPF-to-BPF subprogram returns, both global and static. The main progra=
m
is unchanged: its return value is the program's exit code, so a return
larger than 8 bytes is still rejected at BPF_EXIT.

Patches 1-2 are preparation: patch 1 factors out the per-register check
used by the global return path, and patch 2 adds the shared helpers that
answer "does this subprogram return a register pair", so that the patches
which follow can be ordered independently. Patch 3 wires up the JIT side.
Patches 4-5 teach precision backtracking and live register analysis about
R2 as a second return register, ahead of the patch that starts modeling i=
t.
Patch 6 rejects callbacks returning more than 8 bytes, since neither
bpf_callback_t nor bpf_exception_cb has a second return register. Patch 7
adds the verifier support proper, patch 8 rejects a pair return once the
subprogram's BTF has been marked unreliable, and patch 9 relaxes
btf_distill_func_proto() and btf_validate_return_type(), which is what
makes the whole thing reachable. Patches 10-12 add selftests and patch 13
documents the convention.

Constraints worth calling out:

 - A by-value struct or union returned by a kfunc or by a global subprogr=
am
   must be composed only of scalars. The verifier models the returned
   register bits as an unknown scalar, so a pointer member would be
   laundered into one and escape provenance and reference tracking. A
   static subprogram is verified inline and is not restricted this way.

 - Returning the pair from a kfunc needs the JIT to place the second half
   into R2, which is architecture-specific work. Architectures opt in
   through bpf_jit_supports_kfunc_ret_reg_pair(); x86_64, arm64 and riscv=
64
   do so here, and elsewhere bpf_add_kfunc_call() rejects such a kfunc wi=
th
   -EOPNOTSUPP. A register-pair return from a BPF subprogram needs no suc=
h
   capability.

 - The interpreter propagates R0 alone out of a subprogram, so the JIT is
   forced wherever a caller can observe the pair.

 - The compiler side requires LLVM 23 or newer. The selftests written in =
C
   record which compiler built them in a read-only flag and report a skip
   rather than a pass when built by anything older; the inline-asm tests =
do
   not depend on the compiler and run everywhere.

  [1] https://github.com/llvm/llvm-project/pull/190894
  [2] https://github.com/llvm/llvm-project/pull/206876

Changelog:
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20260708200939.2153664-1-yonghong.s=
ong@linux.dev/
    - Split the R0:R2 helpers out of the verifier patch into their own
      preparation patch, and reordered the series so the core verifier pa=
tch
      comes after the infrastructure it depends on.
    - New patch rejecting callbacks that return more than 8 bytes, both
      helper/kfunc callbacks and exception callbacks, with selftests.
    - New patch rejecting a register-pair return once btf_check_subprog_c=
all()
      has marked the subprogram's BTF unreliable, rather than silently
      mistracking R2.
    - Folded "bpf: Force JIT for programs using the R0:R2 register pair" =
into
      the verifier patch.
    - Dropped "bpf: Reject >8 byte return values on return-reading trampo=
line
      paths" and its selftests; that went in separately as commit
      c48796aa6c39.
    - Described the register mapping as the first and second 8 bytes rath=
er
      than the low and high 64 bits, which is only correct on little-endi=
an,
      and reworded "16-byte" to "up to 16 bytes" where the range 9..16 wa=
s
      meant.

Yonghong Song (13):
  bpf: Factor check_global_ret_scalar_reg() out of the global return
    check
  bpf: Add helpers to describe the R0:R2 return register pair
  bpf: Wire up JIT support for 16-byte kfunc returns
  bpf: Track R2 of register-pair returns in precision backtracking
  bpf: Account R2 of register-pair returns in live register analysis
  bpf: Reject callbacks returning more than 8 bytes
  bpf: Add verifier support for 16-byte returns in R0:R2
  bpf: Reject register-pair returns when the subprog BTF is unreliable
  bpf: Enable aggregate return types up to 16 bytes
  selftests/bpf: Add C tests for 16-byte returns in R0:R2
  selftests/bpf: Add inline-asm and subprog tests for R0:R2 returns
  selftests/bpf: Add tests for callbacks returning more than 8 bytes
  Documentation/bpf: Document up to 16-byte kfunc return values in R0:R2

 Documentation/bpf/kfuncs.rst                  |  62 +++
 arch/arm64/net/bpf_jit_comp.c                 |   5 +
 arch/riscv/net/bpf_jit_comp64.c               |   5 +
 arch/x86/net/bpf_jit_comp.c                   |  21 +
 include/linux/bpf_verifier.h                  |  16 +
 include/linux/filter.h                        |   1 +
 kernel/bpf/backtrack.c                        |  59 ++-
 kernel/bpf/btf.c                              |  44 +-
 kernel/bpf/core.c                             |   5 +
 kernel/bpf/liveness.c                         |  25 +-
 kernel/bpf/verifier.c                         | 287 ++++++++++--
 .../selftests/bpf/prog_tests/aggregate_ret.c  | 176 ++++++++
 .../selftests/bpf/prog_tests/exceptions.c     |   2 +
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  |  15 +
 .../testing/selftests/bpf/prog_tests/timer.c  |   2 +
 .../selftests/bpf/progs/aggregate_ret_func.c  | 420 ++++++++++++++++++
 .../bpf/progs/aggregate_ret_int128_c.c        |  48 ++
 .../selftests/bpf/progs/aggregate_ret_kfunc.c | 127 ++++++
 .../bpf/progs/aggregate_ret_kfunc_c.c         |  66 +++
 .../selftests/bpf/progs/aggregate_ret_run.c   | 168 +++++++
 .../bpf/progs/aggregate_ret_struct_c.c        |  82 ++++
 .../bpf/progs/aggregate_ret_target.c          |  29 ++
 .../bpf/progs/aggregate_ret_union_c.c         |  58 +++
 .../bpf/progs/btf__exceptions_ret_pair_fail.c |  10 +
 .../bpf/progs/btf__timer_ret_pair_fail.c      |  10 +
 .../selftests/bpf/progs/exceptions_fail.c     |   2 +-
 .../bpf/progs/exceptions_ret_pair_fail.c      |  30 ++
 .../selftests/bpf/progs/freplace_ret_pair.c   |  20 +
 .../selftests/bpf/progs/timer_ret_pair_fail.c |  49 ++
 .../selftests/bpf/progs/verifier_arena.c      |  38 ++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  64 +++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  46 ++
 32 files changed, 1930 insertions(+), 62 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/aggregate_ret.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_func.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_int12=
8_c.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_kfunc=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_kfunc=
_c.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_run.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_struc=
t_c.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_targe=
t.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_union=
_c.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__exceptions_ret=
_pair_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__timer_ret_pair=
_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_ret_pair=
_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_ret_pair.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_ret_pair_fail=
.c


base-commit: 457d4ecb47aaf7a2cb46aaadd76e8c812e4f3c9e
--=20
2.53.0-Meta

