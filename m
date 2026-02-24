Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9228F366579;
	Tue, 24 Feb 2026 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929568; cv=none; b=lRz5Jk4kIouTBJGT76D2Gop1UfH3YAuifh7VRiBKEIGGGrvOmMLsIfIyIAMBU9CneiSAyXSsEoq6FNGUKD7ToEqKJbbSJWGean/02dudazMf4+iACP7zCv74E/wIId+gFuq2W14XiBSfZp4rdSNWjJ2+/hED6L0czoXF1o3HY+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929568; c=relaxed/simple;
	bh=NiM3FisNn9MPxa2V6w5nf2T59GJEo/HCjV7OrWNeQn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XjwHg0WsNRUDYs+NWNWcYbWVeLVEwHdWtqR9YB7aDbzzVBgdCVNT8SiEXf6vCdCPsr3u1TQmGjENkK4KR7lILSzdRj+9GiLAXUMzi4neLCWRk6a3Bap0yJVqMUrCxeP43kErJVYSa6OF8UjMGPuCFbpVpoFs9j7UaGW2j6hogeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzGdffkm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzGdffkm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAE2C116D0;
	Tue, 24 Feb 2026 10:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771929568;
	bh=NiM3FisNn9MPxa2V6w5nf2T59GJEo/HCjV7OrWNeQn4=;
	h=From:To:Cc:Subject:Date:From;
	b=rzGdffkmQIAtkr9n3iuh4FlhM46mloWrj4cWE0YjD2RNlDVmexNCQyZcOXPlOepms
	 dM/R6C/NWoFyU6R4dxQYb/+ekyh71o9CIXCoPSmWQLbQy5Av8KUdMErevnswWCM4HL
	 iFx9nUwpTYEOM80UyXq1vDUyCGUYFKZDKIUj8C3oh17hyT9zbkbcGImts68LaeLfcd
	 +WQ/aET4jt23/bDMQ0pFeAgID7WBeSs/Qc2qaCUaodQe05UVcAoxWEkW5mXcYVlPiw
	 7HlCZ6jeLxmrYmU2hF5ZyqINNvgbGvaFKTl/4j/ugzGl7CtxAlr+3zapnOLYVnkQBC
	 YnJ6m/64eghRw==
From: Jiri Olsa <jolsa@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCHv5 bpf-next 0/5] libbpf: Make optimized uprobes backward compatible
Date: Tue, 24 Feb 2026 11:39:10 +0100
Message-ID: <20260224103915.1369690-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
we can currently optimize uprobes on top of nop5 instructions,
so application can define USDT_NOP to nop5 and use USDT macro
to define optimized usdt probes.

This works fine on new kernels, but could have performance penalty
on older kernels, that do not have the support to optimize and to
emulate nop5 instruction.

This patchset adds support to workaround the performance penalty
on older kernels that do not support uprobe optimization, please
see detailed description in patch 2.

v1: https://lore.kernel.org/bpf/20251117083551.517393-1-jolsa@kernel.org/
v2: https://lore.kernel.org/bpf/20260210133649.524292-1-jolsa@kernel.org/
v3: https://lore.kernel.org/bpf/20260211084858.750950-1-jolsa@kernel.org/T/#t
v4: https://lore.kernel.org/bpf/20260220104220.634154-1-jolsa@kernel.org/

v5 changes:
- keep nop_combo on stack and levae buf uninitialized
  in has_nop_combo function [David]

v4 changes:
- rebased on latest bpf-next/master
- use pread for nop combo read [Andrii]
- renamed usdt triger benchmark names [Andrii]
- added more ip address checks to tests [Andrii]

v3 changes:
- fix __x86_64 define and other typos [CI]
- add missing '?' to usdt trigger program [CI]

v2 changes:
- after more investigation we realized there are some versions of
  bpftrace and stap that does not work with solution suggested in
  version 1, so we decided to switch to following solution:

  - change USDT macro [1] emits nop,nop5 instructions combo by
    default
  - libbpf detects nop,nop5 instructions combo for USDT probe,
    if there is and if uprobe syscall is detected libbpf installs
    usdt probe on top of nop5 instruction to get it optimized

- added usdt trigger benchmarks [Andrii]
- several small fixes on uprobe syscall detection, tests and other places [Andrii]
- true usdt.h source [1] updated [Andrii]
- compile usdt_* objects unconditionally [Andrii]


thanks,
jirka


[1] https://github.com/libbpf/usdt
---
Jiri Olsa (5):
      libbpf: Add uprobe syscall feature detection
      libbpf: Add support to detect nop,nop5 instructions combo for usdt probe
      selftests/bpf: Emit nop,nop5 instructions combo for x86_64 arch
      selftests/bpf: Add test for checking correct nop of optimized usdt
      selftests/bpf: Add usdt trigger bench

 tools/lib/bpf/features.c                                | 24 ++++++++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h                         |  2 ++
 tools/lib/bpf/usdt.c                                    | 47 +++++++++++++++++++++++++++++++++++++++++++----
 tools/testing/selftests/bpf/.gitignore                  |  2 ++
 tools/testing/selftests/bpf/Makefile                    |  5 ++++-
 tools/testing/selftests/bpf/bench.c                     |  4 ++++
 tools/testing/selftests/bpf/benchs/bench_trigger.c      | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh |  2 +-
 tools/testing/selftests/bpf/prog_tests/usdt.c           | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_usdt.c           | 12 ++++++++++++
 tools/testing/selftests/bpf/progs/trigger_bench.c       | 10 +++++++++-
 tools/testing/selftests/bpf/usdt.h                      |  2 ++
 tools/testing/selftests/bpf/usdt_1.c                    | 18 ++++++++++++++++++
 tools/testing/selftests/bpf/usdt_2.c                    | 16 ++++++++++++++++
 14 files changed, 289 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/usdt_1.c
 create mode 100644 tools/testing/selftests/bpf/usdt_2.c
