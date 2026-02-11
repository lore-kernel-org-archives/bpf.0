Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4901552FD;
	Wed, 11 Feb 2026 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770799747; cv=none; b=R9TsJKBBNdOFHO/M3dAa3NV7Dt//UeHA4LxL0LI8kZ3St5sArQ9EY/dOkDKI1/UDtOOmCIOWMvhnptaP+T0W77TlJhzhiLsfpkgxFVTyp4Ds+Sgd7nPiiPFRp/g+SUM22+fPv4dQXIwOoB3DtHf6WgkUtxBc9rZAQ35GtUuNw4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770799747; c=relaxed/simple;
	bh=AG1lE/nPNEXvwJjxUefhIEczksu+rXBsxg44NxLTx/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LzYb2AK2J2WoAnHfbhA1ak7JM8Dll76Z2LF/NdV0trKWmJ3NFc0Wb4Ndpc+UXwp0g+yWsuueEBSvNqeaMCFDjL6FZJA/ZYP9Lt4qUB8FGC2Ap82XwR5x4QSuPvXKO/d/4fR6ZdEXjPPOrK/2ZhHmGYrF5sQlWxkmAdbh7gOKMrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh1z5wWq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh1z5wWq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BFEC19424;
	Wed, 11 Feb 2026 08:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770799747;
	bh=AG1lE/nPNEXvwJjxUefhIEczksu+rXBsxg44NxLTx/4=;
	h=From:To:Cc:Subject:Date:From;
	b=Dh1z5wWqF9CvpKT9dXrnp9YIL8lKtq6bwLKkyTMLqAwBKEmFo+uxvzvssJ7RTpjWH
	 5B8n+H8BXYX47UUWj5ZYnVK/9FxK+lAWWDQ1D8n04MlGMUbACVx7vnRR9f4F/cFnjk
	 l35O+/71ge+PUPBSQCXIvpUlaQmgwbkTuXIPurbPBaX2ovwnX5OXl0x/x5jEkQeJ9O
	 bseL+uPmfAUT4fL0mZ5pm8DFHRqMGbsV88mSy6qSRV8WfRo6gHgn6DRFAvNAhLt20q
	 Y86HR5kqc0IQtEmfYTMhR6AFUejT24f9vWN4AxlHR+tLKnAKKG15D4o4UaEI22ZYwF
	 ZurSI9u70dVTw==
From: Jiri Olsa <jolsa@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCHv3 bpf-next 0/5] libbpf: Make optimized uprobes backward compatible
Date: Wed, 11 Feb 2026 09:48:53 +0100
Message-ID: <20260211084858.750950-1-jolsa@kernel.org>
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
      selftests/bpf: Emit nop,no5 instructions combo for x86_64 arch
      libbpf: Add uprobe syscall feature detection
      libbpf: Add support to detect nop,nop5 instructions combo for usdt probe
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
