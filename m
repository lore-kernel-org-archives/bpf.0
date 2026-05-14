Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6876F3DDDD6;
	Thu, 14 May 2026 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766827; cv=none; b=O325tgnjH4lnYEwn1yY95Dvhbr6jfNqM0HIecakWjUBvwLdkKADl57Ec6HIK3K8VCdEpi8pPpn5xagScDsfjHSD/NKj0uq9GtFu4LFJc4+w8YhPI+/0DmUY5JZHV7jkMrUdFEXR/DIvxvYViZqVD1PXylr7/4IJJRKUcBuhL4lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766827; c=relaxed/simple;
	bh=yRz0VotZO1MTWkgihIfWzYs7Ururjg5M+dNgTyOv36U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IRR0M/uhMKF9nsvoKNs50mUApVgEMr0GYOzQtdzXebAArXq6mqgJxIqzWDSn92oz6UVin+KPp0WTbiRF9b3Ehaco2AYs+kLVrRiRNFcYcQsaCME/fsoSIjRt1VqwmBdJtY8hifdrVA9uumuTPHmFW0sfB5nncs9RJ/PGb/RjahA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGvk410h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGvk410h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33062C2BCB3;
	Thu, 14 May 2026 13:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778766827;
	bh=yRz0VotZO1MTWkgihIfWzYs7Ururjg5M+dNgTyOv36U=;
	h=From:To:Cc:Subject:Date:From;
	b=HGvk410hDCQfcoNapy+tCUf3J3yyF056JvDwEL3QtgQcwwmDyvNtHorJKwfjHDVBE
	 /ZJUSQ7dUxcAVi+vkn325SZDv8mau1HZGgagDHqPMETKwsgewCRJxIJxZSWFkLRrda
	 qc94TWRei69LKwitkBjPnC0HX9AdZHCaMx4Hxd1tDxEYuuEtIeF7JvDo6Q9pucR9Kc
	 cJ9KQAQLK7X+Er9BUEntsx4+ML6kU0dqXZUmwaQ7Kh5IY0HwklNnx+Cxjte7MLRrqb
	 CPPHxG/hlDTmCyWdUR5861vs4qq2KJ/pEEoRjKv9OHWh2g1yJLTzpKa7wEZV57INzs
	 CEe75pAuqdVBg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/7] uprobes/x86: Fix red zone issue for optimized uprobes
Date: Thu, 14 May 2026 15:53:35 +0200
Message-ID: <20260514135342.22130-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
Andrii reported an issue with optimized uprobes [1] that can clobber
redzone area with call instruction storing return address on stack
where user code may keep temporary data without adjusting rsp.

Fixing this by moving the optimized uprobes on top of 10-bytes nop
instruction, so we can squeeze another instruction to escape the
redzone area before doing the call.

Note we need upstream update first for patch 3 (github.com/libbpf/usdt),
if we decide to take this change.

thanks,
jirka


[1] https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org/
---
Andrii Nakryiko (1):
      selftests/bpf: Add tests for uprobe nop10 red zone clobbering

Jiri Olsa (6):
      uprobes/x86: Move optimized uprobe from nop5 to nop10
      libbpf: Change has_nop_combo to work on top of nop10
      selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch
      selftests/bpf: Change uprobe syscall tests to use nop10
      selftests/bpf: Change uprobe/usdt trigger bench code to use nop10
      selftests/bpf: Add reattach tests for uprobe syscall

 arch/x86/kernel/uprobes.c                               | 121 ++++++++++++++++++++++++++++------------
 tools/lib/bpf/usdt.c                                    |  16 +++---
 tools/testing/selftests/bpf/bench.c                     |  20 +++----
 tools/testing/selftests/bpf/benchs/bench_trigger.c      |  38 ++++++-------
 tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh |   2 +-
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 217 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 tools/testing/selftests/bpf/prog_tests/usdt.c           |  74 +++++++++++++++++++++----
 tools/testing/selftests/bpf/progs/test_usdt.c           |  25 +++++++++
 tools/testing/selftests/bpf/usdt.h                      |   2 +-
 tools/testing/selftests/bpf/usdt_2.c                    |  15 ++++-
 10 files changed, 423 insertions(+), 107 deletions(-)
