Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D0C3CBE89;
	Fri, 17 Apr 2026 19:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776453913; cv=none; b=Ae7iTkXwWn3BIGjkpvCuvxsfFODayLXkIqtO+Ncogf1yIK0IN3u0VojESnmiqc16KYJG3jfxJMnh++57VroM4wlEpQoisfvj3V6b+oP2U8XYhM0xkIh9kAggU5USSxODi+aHAE/5FFLJxc7Hxi87nfE0fNI0ERaUNQlJB4WP5qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776453913; c=relaxed/simple;
	bh=Ib2FtQuD4UrUbzCKgq3w3SW/vbQpARm1QqO5+nrSwZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bnbnY5X3DnV7yLK193lOiiK969k8S1EkqTeMFvxNrYCbG26zEoqWBm5Q6gMy4aSTA1T/JQS6p6QCKkK5Ds+8AlNgfHU4GrQ3od7+cg80FJ0Ga7mn3Gq0uedwEnfHa9cK+DSDgPfzDk4F5wsvLDcPTWCBfvynQGZorcjVqUNq87Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEiP0JsX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEiP0JsX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18712C19425;
	Fri, 17 Apr 2026 19:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776453913;
	bh=Ib2FtQuD4UrUbzCKgq3w3SW/vbQpARm1QqO5+nrSwZc=;
	h=From:To:Cc:Subject:Date:From;
	b=pEiP0JsXcX7inZyE7WitpRBtDGMIlXkN8Guca/RLCwsFVE9FqfV3PSsdcHGZAh6gM
	 kXbxSevohDaksa3TR+Kzlf1Oi8OPiwYo0s81nUh89nYmOuFn7LRraPnF2tRY3dIcmS
	 1QCuL1zWi/QNsUjzbSVL44fhhRAPXrJWCEEoLU6CV1du8dBgqB4sWiCkjmtWI5Mp7z
	 0xNQbId0ZO1wMa1GOT2rzJKUHm8RB3u1D7rh1lZ2GY6G7FdIxd7UdpQAvWP+3ZaojC
	 wenbl0p6CapK9wSGeKnaiHqvzTBELoh6KiZZay12rmBvJZblOh87ZS7PffFzzKIzt0
	 /TH3dv4bltErg==
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
Subject: [PATCHv5 bpf-next 00/28] bpf: tracing_multi link
Date: Fri, 17 Apr 2026 21:24:34 +0200
Message-ID: <20260417192502.194548-1-jolsa@kernel.org>
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
v3: https://lore.kernel.org/bpf/20260316075138.465430-1-jolsa@kernel.org/
v4: https://lore.kernel.org/bpf/20260324081846.2334094-1-jolsa@kernel.org/

v5 changes:
- add dedicated hashes used for detach, so there's no need to allocate
  them on detach [sashiko]
- safely release old trampoline images [sashiko]
- add cond_resched() to couple of loops [sashiko]
- validate attr->link_create.target_fd [sashiko]
- allow only bpf_get_func_ret() for return value retrieval [sashiko]
- do not allow attachment of fexit/fsession_multi for noreturn functions [sashiko]
- fixed double free/close in libbpf btf cleanup, in separate patch [sashiko]
- make btf_type_is_traceable_func closer to btf_distill_func_proto [sashiko]
- add prog->attach_btf_obj_fd check to collect_func_ids_by_glob,
  to check we don't load module programs for kernel [sashiko]
- make sure program is loaded in bpf_program__attach_tracing_multi [sashiko]
- several selftests fixes [sashiko]
- add attach_type to fdinfo output [Leon Hwang]
- selftests cleanup fixes [Leon Hwang]

v4 changes:
- unlink rollback fix (added ftrace_hash_count) [bot]
- use const for some bpf_link_create_opts tracing_multi members [bot]
- adding missing comment for lockdep keys [bot]
- selftest error path fixes (leaks) and other assorted test fixes [Leon Hwang]
- several compile fixes wrt CONFIG_BPF_SYSCALL and CONFIG_BPF_JIT [kernel test robot]
- make ftrace_hash_clear global, because it's needed in rollback

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
Jiri Olsa (28):
      ftrace: Add ftrace_hash_count function
      ftrace: Add ftrace_hash_remove function
      ftrace: Add add_ftrace_hash_entry function
      bpf: Use mutex lock pool for bpf trampolines
      bpf: Add struct bpf_trampoline_ops object
      bpf: Move trampoline image setup into bpf_trampoline_ops callbacks
      bpf: Add bpf_trampoline_add/remove_prog functions
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
 arch/loongarch/net/bpf_jit.c                                       |  44 ++--
 arch/powerpc/net/bpf_jit_comp.c                                    |  50 ++---
 arch/riscv/net/bpf_jit_comp64.c                                    |  52 ++---
 arch/s390/net/bpf_jit_comp.c                                       |  44 ++--
 arch/x86/net/bpf_jit_comp.c                                        |  54 ++---
 include/linux/bpf.h                                                | 117 ++++++++---
 include/linux/bpf_types.h                                          |   1 +
 include/linux/bpf_verifier.h                                       |   4 +
 include/linux/btf_ids.h                                            |   1 +
 include/linux/ftrace.h                                             |   4 +
 include/linux/trace_events.h                                       |   6 +
 include/uapi/linux/bpf.h                                           |   9 +
 kernel/bpf/bpf_struct_ops.c                                        |  27 +--
 kernel/bpf/btf.c                                                   |   3 +
 kernel/bpf/fixups.c                                                |   2 +
 kernel/bpf/syscall.c                                               |  88 +++++---
 kernel/bpf/trampoline.c                                            | 668 ++++++++++++++++++++++++++++++++++++++++++++++--------------
 kernel/bpf/verifier.c                                              | 176 +++++++++++++---
 kernel/trace/bpf_trace.c                                           | 153 +++++++++++++-
 kernel/trace/ftrace.c                                              |  35 +++-
 net/bpf/bpf_dummy_struct_ops.c                                     |  14 +-
 net/bpf/test_run.c                                                 |   3 +
 tools/include/uapi/linux/bpf.h                                     |  10 +
 tools/lib/bpf/bpf.c                                                |   9 +
 tools/lib/bpf/bpf.h                                                |   5 +
 tools/lib/bpf/libbpf.c                                             | 367 ++++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf.h                                             |  15 ++
 tools/lib/bpf/libbpf.map                                           |   1 +
 tools/lib/bpf/libbpf_internal.h                                    |   1 +
 tools/testing/selftests/bpf/Makefile                               |   9 +-
 tools/testing/selftests/bpf/prog_tests/tracing_multi.c             | 927 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/tracing_multi_attach.c           |  39 ++++
 tools/testing/selftests/bpf/progs/tracing_multi_attach_module.c    |  25 +++
 tools/testing/selftests/bpf/progs/tracing_multi_bench.c            |  12 ++
 tools/testing/selftests/bpf/progs/tracing_multi_check.c            | 214 ++++++++++++++++++++
 tools/testing/selftests/bpf/progs/tracing_multi_fail.c             |  18 ++
 tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c |  41 ++++
 tools/testing/selftests/bpf/progs/tracing_multi_rollback.c         |  43 ++++
 tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c   |  47 +++++
 tools/testing/selftests/bpf/trace_helpers.c                        |   6 +-
 tools/testing/selftests/bpf/trace_helpers.h                        |   1 +
 42 files changed, 2980 insertions(+), 423 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_attach_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_check.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_rollback.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c
