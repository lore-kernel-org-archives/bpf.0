Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79563C2782
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 20:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541395; cv=none; b=uud8IuidHFX44EaLMvkiHaBn2GOoTNZIDQcowb6fqqsFxmIIxIVt13tC3cFfl4FbhX783yaJMiScDeeMRuhe2VruBTd8M4T5zKuEHktw/7sHoAu/ad0p5/l1pHrJcTVHt9jAZOl/kb7kihde+lzmmfjJgQNGf14FDtn6hC+Um5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541395; c=relaxed/simple;
	bh=qc+qY8t4QQcneDcu1o2CmLgHtshQc1S3+dM8YvJbmG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AkKi5VAk353wXdfaszzCVh/s0IhLKuj3zKnvP6b4OdNBlL1zEhaIVPoCdRcXn8exoCqbrAdWerq+K6xSzQzaEZGCAAHZPeGij7eUK2V/lIkCcT48h2MYqSIaX0cynjfaTyfnM4mO8SaNIqtuQ6KqFGXE/gAgDvig520vLmdSd1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id A99511D0B6F696; Wed,  8 Jul 2026 13:09:39 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 00/12] bpf: Support 16-byte return values in the R0:R2 register pair
Date: Wed,  8 Jul 2026 13:09:39 -0700
Message-ID: <20260708200939.2153664-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Until now a BPF subprogram or kfunc could only return a scalar value of u=
p to 8
bytes, passed back in R0. LLVM 23 added the ability to return a value in
two registers for the BPF target [1][2]: an __int128, or a struct/union
whose size is greater than 8 and up to 16 bytes, is returned in the
R0:R2 register pair, with the low 64 bits in R0 and the high 64 bits in
R2. (Before LLVM 23 the BPF backend could not return such values at all:
a by-value aggregate return was rejected with "aggregate returns are not
supported", and an __int128 return failed in the backend with "unable to
allocate function return #1".)

This series teaches the kernel about that convention so that a BPF-to-BPF
subprogram call and a kfunc call can return up to 16 bytes. A returned
struct or union must be composed only of scalars (recursively); the bytes
are handed back as the raw contents of R0:R2. Otherwise allowing pointer
members would launder a pointer into a scalar and escape the verifier's
provenance and reference tracking. A value larger than 16 bytes remains
unsupported, as does a <=3D8 byte return, which continues to use R0 alone=
.

Support is built up incrementally so each step is reviewable on its own,
and the feature is only turned on end to end by the last enabling patch.

  - Patch 1 refactors the global-subprog return check so the per-register
    scalar validation can be reused for R2.
  - Patch 2 to Patch 7 are preparation patches for core verifier handling
    of R0:R2 returns, JIT support, precision backtracking, liveness
    analysis, and limitation on trampoline bpf programs.
  - Patch 8 relaxes btf_distill_func_proto() and btf_validate_return_type=
()
    to accept <=3D16 byte aggregates, enabling the feature end to end.
  - Patches 9-11 add selftests including C and inline asm tests.
  - Patch 12 documents the kfunc return-value convention in kfuncs.rst.

Tested on x86 and arm64. The patch set is built on top of the following c=
ommit:
    Merge branch 'verify-bpf-signed-loader-at-load-time'

    [1] https://github.com/llvm/llvm-project/pull/190894
    [2] https://github.com/llvm/llvm-project/pull/206876

Yonghong Song (12):
  bpf: Factor check_global_ret_scalar_reg() out of the global return
    check
  bpf: Add verifier support for 16-byte returns in R0:R2
  bpf: Wire up JIT support for 16-byte kfunc returns
  bpf: Track R2 of register-pair returns in precision backtracking
  bpf: Account R2 of register-pair returns in live register analysis
  bpf: Force JIT for programs using the R0:R2 register pair
  bpf: Reject >8 byte return values on return-reading trampoline paths
  bpf: Enable 16-byte aggregate return types
  selftests/bpf: Add C tests for 16-byte returns in R0:R2
  selftests/bpf: Add inline-asm and subprog tests for R0:R2 returns
  selftests/bpf: Cover tracing on >8 and <=3D16 byte return targets
  Documentation/bpf: Document 16-byte kfunc return values in R0:R2

 Documentation/bpf/kfuncs.rst                  |  36 ++
 arch/arm64/net/bpf_jit_comp.c                 |   5 +
 arch/riscv/net/bpf_jit_comp64.c               |   5 +
 arch/x86/net/bpf_jit_comp.c                   |  19 +
 include/linux/bpf.h                           |   1 +
 include/linux/bpf_verifier.h                  |   4 +
 include/linux/filter.h                        |   1 +
 kernel/bpf/backtrack.c                        |  32 +-
 kernel/bpf/bpf_struct_ops.c                   |  12 +
 kernel/bpf/btf.c                              |  14 +-
 kernel/bpf/core.c                             |   7 +-
 kernel/bpf/liveness.c                         |  13 +-
 kernel/bpf/verifier.c                         | 179 ++++++++-
 .../selftests/bpf/prog_tests/aggregate_ret.c  | 249 ++++++++++++
 .../selftests/bpf/progs/aggregate_ret_func.c  | 361 ++++++++++++++++++
 .../bpf/progs/aggregate_ret_int128_c.c        |  48 +++
 .../selftests/bpf/progs/aggregate_ret_kfunc.c |  81 ++++
 .../selftests/bpf/progs/aggregate_ret_run.c   | 160 ++++++++
 .../bpf/progs/aggregate_ret_struct_c.c        |  98 +++++
 .../selftests/bpf/progs/aggregate_ret_trace.c |  44 +++
 .../bpf/progs/aggregate_ret_union_c.c         |  51 +++
 .../selftests/bpf/progs/exceptions_fail.c     |   2 +-
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  80 ++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |   5 +
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  38 ++
 25 files changed, 1517 insertions(+), 28 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/aggregate_ret.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_func.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_int12=
8_c.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_kfunc=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_run.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_struc=
t_c.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_trace=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_union=
_c.c

--=20
2.53.0-Meta

