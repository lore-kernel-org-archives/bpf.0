Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DD53F9F2F;
	Wed, 27 May 2026 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882003; cv=none; b=JG3zs5+Xcrn0joXs/9gs06KcDW8I2xbigITKrxMiKjnSAcqXGMOQua68zYtdOz9wiIo4ttuO96kI4/PW1CiF9mprGj+v4FEOOb5lGBUfluSP/zXmXU+NLrnW6XD3NgskFMy2w/VYhWJvCnikQEG37TOypFlseeiQjBj/j3OTJ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882003; c=relaxed/simple;
	bh=bWHC44uORdisGr89PoUg7lYmwQjRUU0LT5BCnWFWmK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EI48FtR4RC5EMLH9GQVPVeKMXMSfgLNO7UKGmVK1+dV2hl5bsCp/EFBPgkmegtVrIKvIVoazl2rUXsFjrk3zP0qbhBWgoQ2KYT3CrmHX9NbHgAmd57Fl9ck6kAaaHUjhWu6zIXyQ5H7t7qE8Xoqo1ukAyh/ANrJCZblsYN6HlZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lg3lCSIG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lg3lCSIG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28001F000E9;
	Wed, 27 May 2026 11:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779881999;
	bh=su3VKgiM974ITo/Vy2CAgrD9OJuG0jx63JT746dmwso=;
	h=From:To:Cc:Subject:Date;
	b=lg3lCSIGJUGRc63vuF0R5F0X1mXAVyiDvEkrG1oekadYk+ASosNmz9ZEa7JS6kgDN
	 +PBZZPg+iv/i1H+/6gcrUIcmsuvC1CwR0Pp9FeSU9vnS48YKEIYST/Iyf9p4Dx56bQ
	 S8XtHmEXcSxNUOawXseIqrdrx3xLPuCH666SkrjyDn/NhSFDVEbt+IT5dY8I3hvUEg
	 RbCeuXmp+v0W+E1IyjHogwx+cqXj3N8HbQ6NUE5hc0vcYtiPoWlMddxw7m6FhE+5Ag
	 +YEsyPkZOKQN9ozEyo5PyHR4gM4DLX3RWwh2SDvgmpd5Irr3qL9b4UbTDmx5qJpNIa
	 GLxjWp3wL8fdw==
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
Subject: [PATCHv6 bpf-next 00/29] bpf: tracing_multi link
Date: Wed, 27 May 2026 13:39:22 +0200
Message-ID: <20260527113951.46265-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hi,
adding tracing_multi link support that allows fast attachment
of tracing program to many functions.

RFC: https://lore.kernel.org/bpf/20260203093819.2105105-1-jolsa@kernel.org/
v1: https://lore.kernel.org/bpf/20260220100649.628307-1-jolsa@kernel.org/
v2: https://lore.kernel.org/bpf/20260304222141.497203-1-jolsa@kernel.org/
v3: https://lore.kernel.org/bpf/20260316075138.465430-1-jolsa@kernel.org/
v4: https://lore.kernel.org/bpf/20260324081846.2334094-1-jolsa@kernel.org/
v5: https://lore.kernel.org/bpf/20260417192502.194548-1-jolsa@kernel.org/

v6 changes:
- move ftrace_hash_count declaration under CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS [sashiko]
- fix ftrace_hash_remove check/deref [sashiko]
- disable context access for multi programs by using stub function with no arguments 
  for verification [sashiko]
- add __used for bpf_multi_func, and removed arguments, we do not allow direct access [sashiko]
- rebased on latest loongarch changes, fix ppc build
- guard update_ftrace_direct_del with ftrace_hash_count on rollback [sashiko]
- fix noreturn attachment condition in bpf_check_attach_btf_id_multi [sashiko]
- fail early on multiple same IDs provided by user [sashiko]
- fix selftests error paths [sashiko]
- add MAX_RESOLVE_DEPTH check to btf_get_type_size [sashiko]
- use btf__pointer_size [sashiko]
- fixed compilation on powerpc [sashiko]
- added verifier fails selftest
- after discussing with Song, it was determined that cleaning up FTRACE_OPS_CMD_DISABLE_SHARE_IPMODIFY_PEER
  is not strictly necessary — keeping the trampoline in the ipmodify_enabled state is acceptable.
  The race condition this introduces remains unlikely, so the concern raised in [1] will not be
  addressed at this time.
  [1] https://lore.kernel.org/bpf/aec7bAbGlnEo3R1g@krava/

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
Jiri Olsa (29):
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
      selftests/bpf: Add tracing multi verifier fails test
      selftests/bpf: Add tracing multi attach benchmark test
      selftests/bpf: Add tracing multi attach rollback tests

 arch/arm64/net/bpf_jit_comp.c                                      |  58 ++--
 arch/loongarch/net/bpf_jit.c                                       |  52 ++--
 arch/powerpc/net/bpf_jit_comp.c                                    |  54 ++--
 arch/riscv/net/bpf_jit_comp64.c                                    |  52 ++--
 arch/s390/net/bpf_jit_comp.c                                       |  44 +--
 arch/x86/net/bpf_jit_comp.c                                        |  54 ++--
 include/linux/bpf.h                                                | 117 ++++++--
 include/linux/bpf_types.h                                          |   1 +
 include/linux/bpf_verifier.h                                       |   4 +
 include/linux/btf_ids.h                                            |   1 +
 include/linux/ftrace.h                                             |   4 +
 include/linux/trace_events.h                                       |   6 +
 include/uapi/linux/bpf.h                                           |   9 +
 kernel/bpf/bpf_struct_ops.c                                        |  27 +-
 kernel/bpf/fixups.c                                                |   2 +
 kernel/bpf/syscall.c                                               |  83 +++---
 kernel/bpf/trampoline.c                                            | 670 ++++++++++++++++++++++++++++++++++----------
 kernel/bpf/verifier.c                                              | 179 +++++++++---
 kernel/trace/bpf_trace.c                                           | 186 ++++++++++++-
 kernel/trace/ftrace.c                                              |  35 ++-
 net/bpf/bpf_dummy_struct_ops.c                                     |  14 +-
 net/bpf/test_run.c                                                 |   3 +
 tools/include/uapi/linux/bpf.h                                     |  10 +
 tools/lib/bpf/bpf.c                                                |   9 +
 tools/lib/bpf/bpf.h                                                |   5 +
 tools/lib/bpf/libbpf.c                                             | 374 ++++++++++++++++++++++++-
 tools/lib/bpf/libbpf.h                                             |  15 +
 tools/lib/bpf/libbpf.map                                           |   1 +
 tools/lib/bpf/libbpf_internal.h                                    |   1 +
 tools/testing/selftests/bpf/Makefile                               |   9 +-
 tools/testing/selftests/bpf/prog_tests/tracing_multi.c             | 930 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/tracing_multi_attach.c           |  39 +++
 tools/testing/selftests/bpf/progs/tracing_multi_attach_module.c    |  25 ++
 tools/testing/selftests/bpf/progs/tracing_multi_bench.c            |  12 +
 tools/testing/selftests/bpf/progs/tracing_multi_check.c            | 214 ++++++++++++++
 tools/testing/selftests/bpf/progs/tracing_multi_fail.c             |  18 ++
 tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c |  41 +++
 tools/testing/selftests/bpf/progs/tracing_multi_rollback.c         |  43 +++
 tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c   |  47 ++++
 tools/testing/selftests/bpf/progs/tracing_multi_verifier.c         |  31 +++
 tools/testing/selftests/bpf/trace_helpers.c                        |   6 +-
 tools/testing/selftests/bpf/trace_helpers.h                        |   1 +
 42 files changed, 3057 insertions(+), 429 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_attach_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_check.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_rollback.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_verifier.c
