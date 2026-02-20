Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731B33126D0;
	Fri, 20 Feb 2026 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582022; cv=none; b=OS9g1JzSqTUTIrH0DlB8BMhlvedvony8u156MwYms+mEGY1NFvtLmszCUxOJX0V6+prT7FgGB+b4/OmV/qBfbhWldnZbPuMbdWLgvTlX59MCZJJVfeNsGo43Jwl4a3IPydNcRPyAFff/RYjyGv5ef/cPt8qHf6yaLKEYm8+Ed/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582022; c=relaxed/simple;
	bh=dyLfv74ffFlC0iRJbIq2TYh3KF7JEMQDAIfx0yKdH80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L7XqrtuAVcU96Yxtf28VEbZD8ZmVhAO4GstZVTElcmSVFbfW6014d0oWShLPBAD9mVqUtWA24VLtz+LXiRxnBPOEuqWMVI3fixO3LypX4tA59Fa1d1KU/WOEbOfYQhWKlWIl86V48+UkCOvhkppK6sbYRVH5CGAoGYDFcjUXdNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWostxBf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWostxBf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBD1C116C6;
	Fri, 20 Feb 2026 10:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771582022;
	bh=dyLfv74ffFlC0iRJbIq2TYh3KF7JEMQDAIfx0yKdH80=;
	h=From:To:Cc:Subject:Date:From;
	b=lWostxBfQeNo1CwfVALgU3K1/zbfvVP1yakJB7/pPz3rO2x76OZrPhh3uUQ/r8EdK
	 seVT+Ogo44wCYkOLAtN2AWoktpvGxw6EsF+nlaMaFGKFpFrPZjcI3lXRV6OB8rvNe+
	 OWsXBDHbd0x27xKmN5/nn6R6oGYWW1yK3DBR2AUTtsWcT3FfN09v+2XKOSvKDcqwXQ
	 enhaPmBgvWSEW1beRHLpq9F5gENaNytSPfGCKoyYgCZlzT7RUnu1KqzcyAvY3jX5T3
	 c5e2dGKIzF4Y7xY81dSFigNB9h2lNF8DLaU3uWaxWdY19XoQYwo3OcvVhno3IiOA4O
	 +gWUCQc8Q4Z+g==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCH bpf-next 00/17] bpf: tracing_multi link
Date: Fri, 20 Feb 2026 11:06:32 +0100
Message-ID: <20260220100649.628307-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
adding tracing_multi link support that allows fast attachment
of tracing program to many functions.

RFC version: https://lore.kernel.org/bpf/20260203093819.2105105-1-jolsa@kernel.org/

Changes to RFC:
- added ftrace_hash_count as wrapper for hash_count [Steven]
- added trampoline mutex pool [Andrii]
- reworked 'struct bpf_tramp_node' separatoin [Andrii]
  - the 'struct bpf_tramp_node' now holds pointer to bpf_link,
    which is similar to what we do for uprobe_multi;
    I understand it's not a fundamental change compared to previous
    version which used bpf_prog pointer instead, but I don't see better
    way of doing this.. I'm happy to discuss this further if there's
    better idea
- reworked 'struct bpf_fsession_link' based on bpf_tramp_node
- made btf__find_by_glob_kind function internal helper [Andrii]
- many small assorted fixes [Andrii,CI]
- added session support [Leon Hwang]
- added cookies support
- added more tests

Note I plan to send linkinfo/fdinfo support separately.

TODO: add rollback tests, add f*.multi.s tests, add trigger bench

---
Jiri Olsa (17):
      ftrace: Add ftrace_hash_count function
      bpf: Use mutex lock pool for bpf trampolines
      bpf: Add struct bpf_trampoline_ops object
      bpf: Add struct bpf_tramp_node object
      bpf: Factor fsession link to use struct bpf_tramp_node
      bpf: Add multi tracing attach types
      bpf: Add bpf_trampoline_multi_attach/detach functions
      bpf: Add support for tracing multi link
      bpf: Add support for tracing_multi link cookies
      bpf: Add support for tracing_multi link session
      libbpf: Add support to create tracing multi link
      selftests/bpf: Add tracing multi skel/pattern/ids attach tests
      selftests/bpf: Add tracing multi intersect tests
      selftests/bpf: Add tracing multi cookies test
      selftests/bpf: Add tracing multi session test
      selftests/bpf: Add tracing multi attach fails test
      selftests/bpf: Add tracing multi attach benchmark test

 arch/arm64/net/bpf_jit_comp.c                                      |  58 ++++-----
 arch/s390/net/bpf_jit_comp.c                                       |  42 +++---
 arch/x86/net/bpf_jit_comp.c                                        |  54 ++++----
 include/linux/bpf.h                                                |  87 +++++++++----
 include/linux/bpf_types.h                                          |   1 +
 include/linux/ftrace.h                                             |   1 +
 include/linux/trace_events.h                                       |   6 +
 include/uapi/linux/bpf.h                                           |   9 ++
 kernel/bpf/bpf_struct_ops.c                                        |  27 ++--
 kernel/bpf/btf.c                                                   |   4 +
 kernel/bpf/syscall.c                                               |  91 ++++++++-----
 kernel/bpf/trampoline.c                                            | 457 ++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 kernel/bpf/verifier.c                                              |  26 +++-
 kernel/trace/bpf_trace.c                                           | 120 ++++++++++++++++-
 kernel/trace/ftrace.c                                              |   7 +-
 net/bpf/bpf_dummy_struct_ops.c                                     |  14 +-
 net/bpf/test_run.c                                                 |   3 +
 tools/include/uapi/linux/bpf.h                                     |  10 ++
 tools/lib/bpf/bpf.c                                                |   9 ++
 tools/lib/bpf/bpf.h                                                |   5 +
 tools/lib/bpf/libbpf.c                                             | 200 ++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h                                             |  15 +++
 tools/lib/bpf/libbpf.map                                           |   1 +
 tools/testing/selftests/bpf/Makefile                               |   7 +-
 tools/testing/selftests/bpf/prog_tests/tracing_multi.c             | 595 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/tracing_multi_attach.c           |  26 ++++
 tools/testing/selftests/bpf/progs/tracing_multi_bench.c            |  13 ++
 tools/testing/selftests/bpf/progs/tracing_multi_check.c            | 165 ++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c |  42 ++++++
 tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c   |  27 ++++
 30 files changed, 1874 insertions(+), 248 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_check.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c
