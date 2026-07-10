Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EC5349CFE
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783707739; cv=none; b=rxO4Bpz6FqmEd/R5WPhoeqY+P/EykGP99P8WnXB+lOdqQ1lXQGQ4pqbDQMF2pMnG3Yf0dqxt6B5636Cbc5U85lkV3FRpOJjAWDtlJA011m3N+ePSsU37IUn98xh0jdiesvTtyjz0CJRejC5RiIujVNQh2sKPOOeWBe6QV3AwuGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783707739; c=relaxed/simple;
	bh=Y7GqXzN9wYS0n3bHlhrtx2Mo+hlUCgfdg6lfNoWPoo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QB/1HgEiPPYmPTZzJr2nJXt1dBsrYMxc1VVO15sJyJxM5AQQ7etGNYgV4xy9HGICRivRazk3SA66GLmpvdC1yDWH8DXo4pBWW46xYKCiyAuE7Sxo0HmvNXTtu0xCo/DrCzq5ZEGPb/l/QY7o6dmm7chYmNtDZUMdrijWGp9pHuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 480E01D718DA19; Fri, 10 Jul 2026 11:22:04 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf v2 0/3] bpf: Fix trampoline handling of 128-bit values
Date: Fri, 10 Jul 2026 11:22:04 -0700
Message-ID: <20260710182204.1085329-1-yonghong.song@linux.dev>
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
 .../bpf/prog_tests/tracing_failure.c          | 12 +++++++
 .../selftests/bpf/prog_tests/tracing_struct.c | 36 +++++++++++++++++++
 .../selftests/bpf/progs/tracing_failure.c     |  6 ++++
 .../bpf/progs/tracing_struct_int128.c         | 18 ++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 21 +++++++++++
 8 files changed, 132 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct_int1=
28.c

--=20
2.53.0-Meta

