Received: from out-zbxj-a65.jellyfish.systems (out-zbxj-a65.jellyfish.systems [198.54.127.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CFB388E6B
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714498; cv=none; b=qF/mZ1BfR7FZGnfd+4VmmYTsaBH9oDpORoE9jQH6rhSh13jx52+jZE4objWHCZya4cV04g3xMaRz6I88s+XvBe5kajh9iqetAcpXSxXlSHnho90qzEJTu18geUQw6Je5uFLaUhCwP50UhHQzBW8ldZi5Rf4mxOpm0Cmc9qhX/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714498; c=relaxed/simple;
	bh=nydjQrM/jPhzBmd3QXqLmoetOKKncMLZQ6nRWkykZgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WFzyf1QpCRV2Zj3hYR46URXu+GtlHqVA0EQUlTXplQsVjh43fAgaLui6lgOm9CFyZaPTzmmcQLOit+stBjzbX1eGUFA0zOnK1D3MeAB4qfg7iiN/2ih0wJYPdDy+wjd0K9onq4RrzFVhoX9mQTmOkQdaJd4Wd0HxD0hTI/vd3wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=oiImEnxc; arc=none smtp.client-ip=198.54.127.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="oiImEnxc"
Received: from fedora (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdGqJ4rTxz8sWx;
	Sun, 06 Sep 2026 17:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788714482;
	bh=vUB30T1B+ZR/3zA4XNFhBTtXazNF7a6OA7ytsuSmU0E=;
	h=From:To:Cc:Subject:Date:From;
	b=oiImEnxc9m98H9IIfNe7MXDMs0SgNzIBqEcj+1BY3Z8Dt1sGclbwC0gOGtGv+zIAi
	 HNk/HpElQyUCTJAe3qUPrVOo+c+dCG6IekrLVvC+bPFDqqmHl6or0nZzvwI4keiJo3
	 Ivw4Ah8Vwt1LD4Azmp4Qoy+QkJ1AzC5waDn6iL1pdqy3MgQfkQe94vHx4XlxmypOHk
	 5E3TFN2i+bUeb5AqNsl/kgKSTc/TI3ZqUfxAiLDXOZi6ehfR6R1koAp7l9kBTa//3N
	 0DQNvOEmJmnirLkn7hPqAX7S2hTqKqc5XENO1aoufVIXUsKT+GypdsC2BySgdOs+qc
	 qkB5wlXTuz2sQ==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 0/2] bpftool: Consume ring buffer maps with event_pipe
Date: Mon,  7 Sep 2026 01:07:45 +0800
Message-ID: <20260906170747.1212378-1-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

This series extends map event_pipe to BPF ring buffer maps through
libbpf's ring buffer manager. Records contain a size and raw bytes in
plain or JSON output. CPU/index selectors remain perf-array specific.
The documentation explains the shared, destructive consumer position.

The existing perf event array path is retained. Signal handlers only set
a stop flag; messages and JSON closure happen in the main path. Poll
and output errors return failure instead of silently ending a stream.

Related request:
https://github.com/libbpf/bpftool/issues/54

The series is based on bpf-next and is independent of the flags and
batch-dump series sent alongside it.

Validation:
- Full bpftool and focused BPF selftests builds with LLVM 20, plus
  bpftool-map man page generation and Bash completion syntax checks.
- All 12 bpftool_ringbuf subtests passed in an x86-64 KVM guest running
  Linux 7.3.0-rc1, against a bpftool built with only this series.
- The perf event array regression also passed against unmodified bpftool.
- Injecting EIO into epoll_wait returned failure with an errno diagnostic
  on stderr and a complete empty JSON array on stdout.

Only focused tests were run; this does not claim a full BPF selftest
suite run. Strict checkpatch has no errors or checks. Remaining warnings
are the userspace volatile sig_atomic_t signal flag, readable multiline
expected-output strings, and files covered by existing MAINTAINERS
patterns.


Integration check: these three independent series also applied and built
together with my previously posted recursive map-dump v2 series. The
combined 64 subtests passed with no skips or failures in the same guest.

Tianyi Chen (2):
  bpftool: Read ring buffer maps with event_pipe
  selftests/bpf: Cover bpftool ring buffer event_pipe

 .../bpf/bpftool/Documentation/bpftool-map.rst |  15 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   4 +-
 tools/bpf/bpftool/map_perf_ring.c             |  87 +++-
 .../bpf/prog_tests/bpftool_ringbuf.c          | 381 ++++++++++++++++++
 .../selftests/bpf/progs/bpftool_ringbuf.c     |  47 +++
 5 files changed, 510 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_ringbuf.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpftool_ringbuf.c

-- 
2.55.0

