Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235FF320A0E;
	Mon, 16 Mar 2026 07:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773647512; cv=none; b=uLz4xgQ9n0ks2xP6XbFVDaBCY+k9qu0VVptYDHqu8R+5C7JOrdxBDQ6umn9xU9Wm4Yd0DT7fSFhuUjdklI1CI8vREXHytmuwDeGJsQnf0c5uSQBSEJjHmGC3HarxQgyEHtkQqdxHP1JdJrQJmq+Gg9a79verc5MJn/lKr7ri2YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773647512; c=relaxed/simple;
	bh=S0ccrYX+hnq8mcsxGneT9qk0yDFopasoWDV3kXaRa8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NtVG19Js9lKJHg7ZNeg/S8p/N0DdGyiQMr7jvLHwJetok0GAbwm/w3Chq1eWcqdZz+aHp4i0wpUskaJV6JRkHwIu8cMpMZxCXIUvN8Rw2juVZY7cOuhO2Q+L8NeF3MBsSLhOgckmhA5tJhT0KcPzC7d8X0/0t5cARZTsbVhonto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWzZWn3q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWzZWn3q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65F9C19421;
	Mon, 16 Mar 2026 07:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773647511;
	bh=S0ccrYX+hnq8mcsxGneT9qk0yDFopasoWDV3kXaRa8c=;
	h=From:To:Cc:Subject:Date:From;
	b=QWzZWn3qoEiWpnmGLbtzi9W9o5JSRnscahCAhfGy2oJ7q8PQuDax8eUKktFpR1owj
	 REd99OH/YydCJDwuHfO0S+mFWUQq0qRw2XTOW2D1piaWa7JIBsGa8GWwphLCdOxhvi
	 1h/el5gWjYzOMUO3ZzFGgfAjg/fMEFpC8X9IzHIDVc7qmSk3s5RYiMFZHarxtt8e4h
	 eZENcaOchVNW+wRJO+HRlB7Li662PSPKWbr1frlQkjMN+G75M1zi7PBFJ1++RzT06C
	 Ip8cMbHw/eOFCmjwcidciepEoMsQRkaH1eeGl5XBS+MZrWtFRL4xWBvo66o9DjVaOS
	 H5MZG1DnP6WzA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Hengqi Chen <hengqi.chen@gmail.com>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv3 bpf-next 00/24] bpf: tracing_multi link
Date: Mon, 16 Mar 2026 08:51:14 +0100
Message-ID: <20260316075138.465430-1-jolsa@kernel.org>
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

RFC: https://lore.kernel.org/bpf/20260203093819.2105105-1-jolsa@kernel.org/
v1: https://lore.kernel.org/bpf/20260220100649.628307-1-jolsa@kernel.org/
v2: https://lore.kernel.org/bpf/20260304222141.497203-1-jolsa@kernel.org/

v3 changes:
- fix module parsing [Leon Hwang]
- use function traceable check from libbpf [Leon Hwang]
- use ptr_to_u64 and fix/updated few comments [ci]
- display cookies as decimal numbers [ci]
- added link_create.flags check [ci]
- fix error path in bpf_trampoline_multi_detach [ci]
- make fentry/fexit.multi not extendable [ci]
- add missing OPTS_VALID to bpf_program__attach_tracing_multi [ci]

v2 changes:
- allocate data.unreg in bpf_trampoline_multi_attach for rollback path [ci]
  and fixed link count setup in rollback path [ci]
- several small assorted fixes [ci]
- added loongarch and powerpc changes for struct bpf_tramp_node change
- added support to attach functions from modules
- added tests for sleepable programs
- added rollback tests

v1 changes:
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


Note I plan to send linkinfo support separately, the patchset is big enough.

thanks,
jirka


Cc: Hengqi Chen <hengqi.chen@gmail.com>
---
Jiri Olsa (24):
      ftrace: Add ftrace_hash_count function
      bpf: Use mutex lock pool for bpf trampolines
      bpf: Add struct bpf_trampoline_ops object
      bpf: Add struct bpf_tramp_node object
      bpf: Factor fsession link to use struct bpf_tramp_node
      bpf: Add multi tracing attach types
      bpf: Move sleepable verification code to btf_id_allow_sleepable
      bpf: Add bpf_trampoline_multi_attach/detach functions
      bpf: Add support for tracing multi link
      bpf: Add support for tracing_multi link cookies
      bpf: Add support for tracing_multi link session
      bpf: Add support for tracing_multi link fdinfo
      libbpf: Add bpf_object_cleanup_btf function
      libbpf: Add bpf_link_create support for tracing_multi link
      libbpf: Add btf_type_is_traceable_func function
      libbpf: Add support to create tracing multi link
      selftests/bpf: Add tracing multi skel/pattern/ids attach tests
      selftests/bpf: Add tracing multi skel/pattern/ids module attach tests
      selftests/bpf: Add tracing multi intersect tests
      selftests/bpf: Add tracing multi cookies test
      selftests/bpf: Add tracing multi session test
      selftests/bpf: Add tracing multi attach fails test
      selftests/bpf: Add tracing multi attach benchmark test
      selftests/bpf: Add tracing multi attach rollback tests

 arch/arm64/net/bpf_jit_comp.c                                      |  58 +++---
 arch/loongarch/net/bpf_jit.c                                       |  44 ++---
 arch/powerpc/net/bpf_jit_comp.c                                    |  46 ++---
 arch/riscv/net/bpf_jit_comp64.c                                    |  52 +++---
 arch/s390/net/bpf_jit_comp.c                                       |  44 ++---
 arch/x86/net/bpf_jit_comp.c                                        |  54 +++---
 include/linux/bpf.h                                                |  91 ++++++---
 include/linux/bpf_types.h                                          |   1 +
 include/linux/bpf_verifier.h                                       |   3 +
 include/linux/btf_ids.h                                            |   1 +
 include/linux/ftrace.h                                             |   1 +
 include/linux/trace_events.h                                       |   6 +
 include/uapi/linux/bpf.h                                           |   9 +
 kernel/bpf/bpf_struct_ops.c                                        |  27 +--
 kernel/bpf/btf.c                                                   |   4 +
 kernel/bpf/syscall.c                                               |  88 +++++----
 kernel/bpf/trampoline.c                                            | 512 ++++++++++++++++++++++++++++++++++++++++----------
 kernel/bpf/verifier.c                                              | 124 +++++++++---
 kernel/trace/bpf_trace.c                                           | 149 ++++++++++++++-
 kernel/trace/ftrace.c                                              |   7 +-
 net/bpf/bpf_dummy_struct_ops.c                                     |  14 +-
 net/bpf/test_run.c                                                 |   3 +
 tools/include/uapi/linux/bpf.h                                     |  10 +
 tools/lib/bpf/bpf.c                                                |   9 +
 tools/lib/bpf/bpf.h                                                |   5 +
 tools/lib/bpf/libbpf.c                                             | 337 ++++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf.h                                             |  15 ++
 tools/lib/bpf/libbpf.map                                           |   1 +
 tools/lib/bpf/libbpf_internal.h                                    |   1 +
 tools/testing/selftests/bpf/Makefile                               |   9 +-
 tools/testing/selftests/bpf/prog_tests/tracing_multi.c             | 860 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/tracing_multi_attach.c           |  40 ++++
 tools/testing/selftests/bpf/progs/tracing_multi_attach_module.c    |  26 +++
 tools/testing/selftests/bpf/progs/tracing_multi_bench.c            |  13 ++
 tools/testing/selftests/bpf/progs/tracing_multi_check.c            | 213 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/tracing_multi_fail.c             |  19 ++
 tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c |  42 +++++
 tools/testing/selftests/bpf/progs/tracing_multi_rollback.c         |  38 ++++
 tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c   |  43 +++++
 tools/testing/selftests/bpf/trace_helpers.c                        |   6 +-
 tools/testing/selftests/bpf/trace_helpers.h                        |   1 +
 41 files changed, 2661 insertions(+), 365 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_attach_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_check.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_rollback.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c
