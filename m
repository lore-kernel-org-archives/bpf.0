Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36EF37F009;
	Wed,  4 Mar 2026 22:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662913; cv=none; b=LN91ib8O7mWyttN4t8SewVIYZytao6M9Nw2IBf+P+BgiwSTZTTZlUwskqJefKWGGBU2wI5OX6tCFXo9Qd5McC3wrBpg0Op0zTAT/sGzHwP4fyE2LfIHJ4n2S6PyjiY2TrZfeHob+kbr6qCCiuPt56/PHYaxBanbkuZo4COuwVjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662913; c=relaxed/simple;
	bh=JfS77rOtFa5ybmacU3LE0NGtfwCh/P4CeXZV7AgDMY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SIQqg6J2Z3XrgLFbXIr6Y730EUM8pOo/XyJEhLN+lkh8BfqmvDBJh7+snEFPWFbGGfTGkl1u7/HvsfgEcIrF3lJdMDYqZ5y05WSfOjl7tnU7M4Fe9ffHl3xoVC9BtIgz6PI4ObkBu0xQEnJbduM7ZPq5ifqd+7DRK9/5h2zmYqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhTN2S4g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhTN2S4g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57DEC2BC86;
	Wed,  4 Mar 2026 22:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772662912;
	bh=JfS77rOtFa5ybmacU3LE0NGtfwCh/P4CeXZV7AgDMY8=;
	h=From:To:Cc:Subject:Date:From;
	b=uhTN2S4ggWAnZitX3q2VgUWvciaZ9Y1DnwQxzrl3/Yk86+GqMKSKo3K3SlegVFlQs
	 CVDc3mbQ4E7mglsc6uWKpcSqqbgebglZpcpTR9jSSwPDoIEKOd815D1sOvPm46GSmZ
	 lOQb8DuoeWPQlNkLBpovCHUMfx47sCZa+lgDgbrLkMM3ax/3fF50S3K556TGbHnh0S
	 VazkKuKPwPX+yWsOCClkWxcu2ANAkRlXJGc8aA3LNyMStQeRTCGsR2MpgM6Gn5aMJP
	 Gxvpd0i/+u0SoSeeHo9RkONxWLukM6IdqixcFLrqrbGgk+iCRaQ0FEod/34zA9PjsN
	 0XxuJXFrRYOCw==
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
Subject: [PATCHv2 bpf-next 00/23] bpf: tracing_multi link
Date: Wed,  4 Mar 2026 23:21:18 +0100
Message-ID: <20260304222141.497203-1-jolsa@kernel.org>
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
v1: https://lore.kernel.org/bpf/20260220100649.628307-1-jolsa@kernel.org/

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


---
Jiri Olsa (23):
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
      libbpf: Add support to create tracing multi link
      selftests/bpf: Add tracing multi skel/pattern/ids attach tests
      selftests/bpf: Add tracing multi skel/pattern/ids module attach tests
      selftests/bpf: Add tracing multi intersect tests
      selftests/bpf: Add tracing multi cookies test
      selftests/bpf: Add tracing multi session test
      selftests/bpf: Add tracing multi attach fails test
      selftests/bpf: Add tracing multi attach benchmark test
      selftests/bpf: Add tracing multi rollback tests

 arch/arm64/net/bpf_jit_comp.c                                      |  58 +++---
 arch/loongarch/net/bpf_jit.c                                       |  44 ++---
 arch/powerpc/net/bpf_jit_comp.c                                    |  46 ++---
 arch/riscv/net/bpf_jit_comp64.c                                    |  52 ++---
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
 kernel/bpf/syscall.c                                               |  88 ++++++---
 kernel/bpf/trampoline.c                                            | 511 +++++++++++++++++++++++++++++++++++++++---------
 kernel/bpf/verifier.c                                              | 116 +++++++----
 kernel/trace/bpf_trace.c                                           | 147 +++++++++++++-
 kernel/trace/ftrace.c                                              |   7 +-
 net/bpf/bpf_dummy_struct_ops.c                                     |  14 +-
 net/bpf/test_run.c                                                 |   3 +
 tools/include/uapi/linux/bpf.h                                     |  10 +
 tools/lib/bpf/bpf.c                                                |   9 +
 tools/lib/bpf/bpf.h                                                |   5 +
 tools/lib/bpf/libbpf.c                                             | 329 ++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf.h                                             |  15 ++
 tools/lib/bpf/libbpf.map                                           |   1 +
 tools/testing/selftests/bpf/Makefile                               |   9 +-
 tools/testing/selftests/bpf/prog_tests/tracing_multi.c             | 896 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/tracing_multi_attach.c           |  40 ++++
 tools/testing/selftests/bpf/progs/tracing_multi_attach_module.c    |  26 +++
 tools/testing/selftests/bpf/progs/tracing_multi_bench.c            |  13 ++
 tools/testing/selftests/bpf/progs/tracing_multi_check.c            | 215 ++++++++++++++++++++
 tools/testing/selftests/bpf/progs/tracing_multi_fail.c             |  19 ++
 tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c |  42 ++++
 tools/testing/selftests/bpf/progs/tracing_multi_rollback.c         |  25 +++
 tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c   |  27 +++
 38 files changed, 2642 insertions(+), 366 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_attach_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_check.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_rollback.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c
