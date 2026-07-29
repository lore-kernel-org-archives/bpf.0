Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5642736B93B
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 05:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785301336; cv=none; b=n+dMe0FcZmDf55umeDY3OQUTeo0yI8bKWw2QIMhXQPCHPFijjPiKnVxnt9oIhS1X40cyvdeMe357YBji5ELUeDkRECfTioUFamjhiBaFn8RNuVycftgDW3CQxcXQNTBFvWPdY36izmhRP/IWJ1RCh268kiXO1/fTeJl6FmeoY8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785301336; c=relaxed/simple;
	bh=dR7Ts5JBgCfm+8zGsPo71lP9Go0FU36eTcJU86qs3EA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NfOG+wrsb+rQl0tjOz8qL1VldfaLRdpGYM/qfiaq2Yn6na4ktk5DyTmZ7BIr98uQWqzNa1g/E/6DjvaqmeaJv6Vfq78pyic6QpVduG5UIzllqO6OvmINLeVFslCY5RhSxzTOzj0GALE6ZoKJJpEynd5lZD96e0Hrx1Exr2e8XCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 54FE920A174CCC; Tue, 28 Jul 2026 22:01:54 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 0/3] bpf: Fix trampoline handling of 128-bit values
Date: Tue, 28 Jul 2026 22:01:54 -0700
Message-ID: <20260729050154.2585468-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The BPF trampoline preserves only 8 bytes of a target function's return
value (R0), and its register save area under-allocates space for 128-bit
arguments for x86_64. These two problems lead to memory corruption or
incorrect values observed by BPF programs and the real caller.

This series fixes both issues and adds two selftests, otherwise, each of
them will fail if without the corresponding fix.

Changelogs:
  v4 -> v5:
    - v4: https://lore.kernel.org/bpf/1c4223ae-a5ba-48a4-95d3-57c8ff24105=
5@linux.dev/
    - For function test_fexit_int128_ret(), guard with __x86_64__ and __a=
arch64__
      to avoid s390x failure
  v3 -> v4:
    - v3: https://lore.kernel.org/bpf/20260710225206.4013062-1-yonghong.s=
ong@linux.dev/
    - Add Ack from Leon Hwang
  v2 -> v3:
    - v2: https://lore.kernel.org/bpf/20260710182204.1085329-1-yonghong.s=
ong@linux.dev/
    - Align __int128 argument at even position enforced by arm64.
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20260710144404.2579671-1-yonghong.s=
ong@linux.dev/
    - Also handle __int128 arguments for x86_64.

Yonghong Song (3):
  bpf: Reject >8 byte return values on return-reading trampoline paths
  bpf, x86: Fix trampoline stack size for 128-bit arguments
  selftests/bpf: Add tests for >8 byte return value and 128-bit
    arguments

 arch/x86/net/bpf_jit_comp.c                   |  7 ++--
 kernel/bpf/bpf_struct_ops.c                   | 12 +++++++
 kernel/bpf/verifier.c                         | 25 +++++++++++++
 .../bpf/prog_tests/tracing_failure.c          | 20 +++++++++++
 .../selftests/bpf/prog_tests/tracing_struct.c | 36 +++++++++++++++++++
 .../selftests/bpf/progs/tracing_failure.c     |  6 ++++
 .../bpf/progs/tracing_struct_int128.c         | 18 ++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 32 +++++++++++++++++
 8 files changed, 151 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct_int1=
28.c

--=20
2.53.0-Meta

