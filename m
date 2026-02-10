Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31C419EEC2;
	Tue, 10 Feb 2026 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770730619; cv=none; b=N/j/bx3EgyHFaXFDOynoqdVS7zH+v+N7DS9rkTAt8hhoX/3qwwqF99eAoEIk0QNX5R4/SFfV/pCos1Q9InBy6MBs9RbID/19HsnXCFd11agBljHmQ5zlt6gnj/ydy6io3QZBx3y01w6+yiNdx05HQVWqdGGyS/IQYogVyD6/Iak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770730619; c=relaxed/simple;
	bh=GOmRG864vY6D1kESbwlYap6WaTBduydOxPqdZeAjT0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b/rx3mOAHlkyQrGSO5AOYG8iQckSHmEaQfSasQstAHiKFk37VA7YyZw2t6guy1qQVpFCn2EUawNglpIV8Es+sMpacK5QD9OcE2lje7m7nSHpGTD/Kd83SRW2r8wmjmIbc2Ja8XocrtSeFdD4ydOMkfW78Bpwz2u9MPQh8GBZPxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kg2ktQKz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kg2ktQKz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6F7C116C6;
	Tue, 10 Feb 2026 13:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770730618;
	bh=GOmRG864vY6D1kESbwlYap6WaTBduydOxPqdZeAjT0E=;
	h=From:To:Cc:Subject:Date:From;
	b=kg2ktQKz46NlVdh6c9xC28x1MGfPXrueSd/nKViP1SVfld23AytZL6hT/N1kYEYvv
	 +rdLk+PSE92FpkQIUlcFXZ51nONGyxSnuv9H+1cTl87OlfpThwiiu6lJb0NM+eWizk
	 2Q42di9odcL6s2j/fAmEctCMyQgk/XO71SKRXOJ88aR/uiwN+Ffs+WIiWhX8Rz7+Uv
	 606XYl2LsBiUxXDyMLkBrwKdbGcj6OhbqE2tOCM5CdYMUGcb3V2Zk9y/uSS18Bfd9T
	 UEGt46JvNPEouM6NE/AySds0WzCUmB39E87XAMkdLk+/2umMP5o9DZlXHn14vkft8F
	 3v+wfnFKIAuEw==
From: Jiri Olsa <jolsa@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCHv2 bpf-next 0/5] libbpf: Make optimized uprobes backward compatible
Date: Tue, 10 Feb 2026 14:36:44 +0100
Message-ID: <20260210133649.524292-1-jolsa@kernel.org>
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
      selftests/bpf: Emit nop,no5 instructions combo for x86_64 arch
      selftests/bpf: Add test for checking correct nop of optimized usdt
      selftests/bpf: Add usdt trigger bench

 tools/lib/bpf/features.c                                | 24 ++++++++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h                         |  2 ++
 tools/lib/bpf/usdt.c                                    | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 tools/testing/selftests/bpf/.gitignore                  |  2 ++
 tools/testing/selftests/bpf/Makefile                    |  5 ++++-
 tools/testing/selftests/bpf/bench.c                     |  4 ++++
 tools/testing/selftests/bpf/benchs/bench_trigger.c      | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh |  2 +-
 tools/testing/selftests/bpf/prog_tests/usdt.c           | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_usdt.c           |  9 +++++++++
 tools/testing/selftests/bpf/progs/trigger_bench.c       | 10 +++++++++-
 tools/testing/selftests/bpf/usdt.h                      |  2 ++
 tools/testing/selftests/bpf/usdt_1.c                    | 18 ++++++++++++++++++
 tools/testing/selftests/bpf/usdt_2.c                    | 16 ++++++++++++++++
 14 files changed, 287 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/usdt_1.c
 create mode 100644 tools/testing/selftests/bpf/usdt_2.c
