Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3758435A84
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 06:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791528141; cv=none; b=bK9HYsyod8tlbK1Oms9S+CiyUdN/b+4mPHrCn9A3Xi+HMxImjB8HlYD62Twt72SEYd+BqwxiT/2CMYcV725/C8bcse6kN1rgizkr9BeAB+Z5SnoidD6NS6ujEaETi7DGkSkt6wy9RfEseVuuk5ukL0LqxHrZQ0TJHnTAw6AEOok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791528141; c=relaxed/simple;
	bh=JcFgMTgLNxhIVgutjEwNLyy8GBt/Rbk57yQzJP9STyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n7Xmj6HTQQIIsRlaZFQ1+EOokCyMAxEAb8NhUdM5qq1CZGAMYUtLBz8I/+MkLXMI1JMTgiEgQFf7/LgFxfTGWB+o4dwvg0Hn/7zPoIZ8DxSRQCY8Ceh9psiRRfwvl94Or1knQbWjvR/Dlbe5gpAkArl24YdzTf7yR7zaOW6bNS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 70687300E25898; Thu,  8 Oct 2026 23:42:06 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 0/5] bpf: Follow up by-value struct and __int128 argument support
Date: Thu,  8 Oct 2026 23:42:06 -0700
Message-ID: <20261009064206.1238047-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a follow-up to the series "bpf: Support by-value struct and
__int128 arguments" [1], which placed kfunc arguments by the kernel
calling convention in the x86-64 and arm64 JITs, and made the arm64
trampoline place an argument aligned to 16 bytes: an __int128, or an
aggregate holding one. This series covers what was left:

  - The x86-64 trampoline. x86-64 starts such an argument passed on the
    stack at a 16-byte aligned slot, which can leave an empty slot
    before it, but the trampoline copied the stack arguments as if
    there were none. A bpf program attached to such a function read the
    wrong values from the empty slot on, and with fexit, where the
    trampoline calls the traced function itself, that function got its
    stack arguments one slot off as well.

  - A trampoline on a BPF function. BPF code calls one with the
    arguments in the BPF convention, one slot after another, but the
    arm64 trampoline placed them by the kernel convention, and the
    x86-64 fix above would have done the same.

  - Tests with an __int128 at an odd slot, where arm64 leaves a register
    or a stack slot empty. On arm64 such a kfunc gets BTF only with the
    pahole patch [2], now in pahole master after v1.32, so these tests
    were not part of [1].

Patch 1 adds the odd-slot kfunc tests. Patch 2 keeps a BPF function's
trampoline arguments in the BPF convention, and patch 3 places the
x86-64 trampoline arguments by the calling convention. Patches 4 and 5
test trampolines on kernel functions and on BPF functions with an
argument after a 16-byte aligned one.

Tested on x86-64 with test_progs.

  [1] https://lore.kernel.org/bpf/20260912195156.980886-1-yonghong.song@l=
inux.dev/
  [2] https://lore.kernel.org/dwarves/20260917164043.1577508-1-yonghong.s=
ong@linux.dev/

Yonghong Song (5):
  selftests/bpf: Test by-value __int128 kfunc arguments at an odd slot
  bpf: Keep the BPF calling convention for a trampoline on a BPF
    function
  bpf, x86: Place trampoline arguments by the x86-64 calling convention
  selftests/bpf: Test trampoline args around a 16-byte aligned stack arg
  selftests/bpf: Test trampoline args of a BPF function at an odd slot

 arch/x86/net/bpf_jit_comp.c                   | 189 +++++++++---------
 include/linux/bpf.h                           |   2 +
 kernel/bpf/btf.c                              |   1 +
 kernel/bpf/core.c                             |  12 ++
 kernel/bpf/verifier.c                         |   1 +
 .../selftests/bpf/prog_tests/tracing_struct.c |  96 ++++++++-
 .../selftests/bpf/progs/aggregate_arg_kfunc.c |  71 +++++++
 .../bpf/progs/tracing_struct_int128.c         |  45 +++++
 .../bpf/progs/tracing_struct_int128_tgt.c     |  68 +++++++
 .../bpf/progs/tracing_struct_int128_tracer.c  |  44 ++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  69 +++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  13 ++
 12 files changed, 515 insertions(+), 96 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct_int1=
28_tgt.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct_int1=
28_tracer.c

--=20
2.53.0-Meta

