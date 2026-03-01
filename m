Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01CD22AE65
	for <bpf@vger.kernel.org>; Sun,  1 Mar 2026 01:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329544; cv=none; b=T4fuf4t3Pd+WeJKi/iRwmV39rFtSH/K8e4EF9hC5AMAJL39zOgh/rqPcmr2Dm2LB9w51Xasddgfh3AqXcJUpHHtNuxtuvXfjZ5yRu6RpKgB1E+2rqSwPwMnF2mcBFRq882THu5mwACb0XFkZNG9MQ3IMkzjb2O/Nzwc+VEaUS0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329544; c=relaxed/simple;
	bh=TsnTw1uRE4krWhVzaSdXcDSrsnxr3Pa2llJobpWe04Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ept8v/vCISmpaW8XdYe53djhYvf+dYpZVujv/szEkj2MTaww8hOy/SQ6L7z9j10eBYNcfDOqImFtCjhbNZdxM6gAGKwXhqR2fjc0VKBEscttHxOWICWMIrpH4+XQqxuGsDQQ1m85wH8o0x8OOeu3m2J77Kle9OAVqupSvMAO3uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSR3xcxS; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSR3xcxS"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so1869725a91.0
        for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 17:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772329542; x=1772934342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1x8irSC5N2RVcDxwn8wxBrJTNT5pdYqDzOAzBNde5LU=;
        b=DSR3xcxSgKyU41mh6fLOx+WfQXZsuzkjHjqdwwCTMdD4DUsmQdaxmR3t9utmFSaC5E
         9Adwrpy04m9IziQnkoQ1Py+M/MTSWL9nqpMGHz/suhw4GjzpEOoLAsQt9Je17snh8KJ/
         tXXxo+Co2okqrUn1BzvpJQKglVRJDpIDMxu9sMAmjvLqyx43uhdUcRh/RCNTKH7P7A3a
         jznJU7sXL5RXgbeaV1oh13d/XpKkRbSQtWRCZGgCtFzE9BkgOMpsByfoQziLGvsoJTRB
         wY9u4ly7KwmbYRAn7d2ukAshMMqBH8Bq13SmPGH9IQ03nz4LrxeozzSGV2Gs6O8H4pN4
         fhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772329542; x=1772934342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1x8irSC5N2RVcDxwn8wxBrJTNT5pdYqDzOAzBNde5LU=;
        b=u6Aa7oUfikA8JcZzfgRXTLTiY9elnQnIDjSO2fMhmuz6DnJvDYVgt3GIP+nDCou60d
         CueS29zyIHEBLa6D8f4L2HUedu0G9VlltjqhIeA3r0wEhF31QVQB07y6icbTjgezTnMx
         65mDMGHKmdtVBg9lT0NUyVd4cIwI81yUwM/CYsi5fgmPtBMMLecJisdsY1gqAJUAv0Q3
         I9MmqCN6xnY1J62ZcRaU+u4cyodPEiTQatLkeyGXfQ2Frf72Qp5R6De9lBeOAmwqrqZj
         Zzun6UQ7B1QYf2fcAAkiC+ouyhqXYISsIVtYK9l7F1qkmI2kHgo+ztkRFJnWejWnBTn4
         1/Pg==
X-Gm-Message-State: AOJu0YyouT/ykeZtGN61iM6P7But/+SEhtOUyl1xFvM3bJfhWF8WqqFm
	EReEG7Nd92Q06jOUt4K9ozBPU8VxsEvxpFryOMi4FlHV9RztymBTK/y2WLaTQw==
X-Gm-Gg: ATEYQzxehyQSGgbANEfEhVIQwwpFohES2BlrVlCJ63GKDMgcXFLdpgUZvQ5oXoWknhc
	BJnqeUcjSb0fzi/0R2j5k6DvoXyQHLDau9whpGGw9sTrM9Gr09l2jzLkWDpqRS9uOyMXOPajXuP
	GR1OwodPhjqPRUTFhi/lFqX0a1ZS43mWZ42LZLr6cEOGrIiMG/RaLwv/vGXi3fzcd/JuVauHkuJ
	34euaO3qKQwUjMD/j81DltVdLriCLmDnq00EwnEiAZ71tL8cxaXJUSFXhpr3R9cUiCUdyfJnMHG
	/ltIlMby+KmqWWi848txOFmWoUf96Xx6YQipEozRXmMEBQWDe0fKxsxYAPNcsgJKvr5B/2k8JO1
	iiy7rvAaJuX/ZxvyXi71jXMYBvPPFeLFRi4lx6M3BDMiEbbRUNuPsOd8CSsJXCKkEeYZETeL60c
	CDEBOGNc9/YfDF96tBpD4J4WcVTULWT09HPD7DeUBJd2TphyCqYtbfFs55nWA/frS+GzkOHndVx
	ncPdlsJXy1YcNtN+ql4ePnJbEMbNuT850/NbYVq2VI5t9pXIaYp9oBAsHrDXQ==
X-Received: by 2002:a17:90b:4d07:b0:353:6373:590b with SMTP id 98e67ed59e1d1-35965c27e71mr6750368a91.7.1772329542162;
        Sat, 28 Feb 2026 17:45:42 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359834ac606sm956240a91.6.2026.02.28.17.45.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Feb 2026 17:45:40 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] BPF fixes for 7.0-rc2
Date: Sat, 28 Feb 2026 17:45:38 -0800
Message-ID: <20260301014538.39958-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 7dff99b354601dd01829e1511711846e04340a69:

  Remove WARN_ALL_UNSEEDED_RANDOM kernel config option (2026-02-23 11:18:48 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to b9c0a5c48396aea4cde25fc701027ebbc5d78de1:

  Merge branch 'fix-invariant-violation-for-single-value-tnums' (2026-02-27 16:11:50 -0800)

----------------------------------------------------------------
- Fix alignment of arm64 JIT buffer to prevent atomic tearing (Fuad Tabba)

- Fix invariant violation for single value tnums in the verifier
  (Harishankar Vishwanathan, Paul Chaignon)

- Fix a bunch of issues found by ASAN in selftests/bpf (Ihor Solodrai)

- Fix race in devmpa and cpumap on PREEMPT_RT (Jiayuan Chen)

- Fix show_fdinfo of kprobe_multi when cookies are not present (Jiri Olsa)

- Fix race in freeing special fields in BPF maps to prevent
  memory leaks (Kumar Kartikeya Dwivedi)

- Fix OOB read in dmabuf_collector (T.J. Mercier)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (4):
      Merge branch 'selftests-bpf-fixes-for-userspace-asan'
      Merge branch 'close-race-in-freeing-special-fields-and-map-value'
      Merge branch 'bpf-cpumap-devmap-fix-per-cpu-bulk-queue-races-on-preempt_rt'
      Merge branch 'fix-invariant-violation-for-single-value-tnums'

Fuad Tabba (1):
      bpf, arm64: Force 8-byte alignment for JIT buffer to prevent atomic tearing

Harishankar Vishwanathan (1):
      bpf: Introduce tnum_step to step through tnum's members

Ihor Solodrai (21):
      selftests/bpf: Add simple strscpy() implementation
      selftests/bpf: Replace strcpy() calls with strscpy()
      selftests/bpf: Replace strncpy() with strscpy()
      selftests/bpf: Use strscpy in bpftool_helpers.c
      selftests/bpf: Use memcpy() for bounded non-NULL-terminated copies
      selftests/bpf: Pass through build flags to bpftool and resolve_btfids
      resolve_btfids: Fix memory leaks reported by ASAN
      selftests/bpf: Add DENYLIST.asan
      selftests/bpf: Refactor bpf_get_ksyms() trace helper
      selftests/bpf: Fix memory leaks in tests
      selftests/bpf: Fix cleanup in check_fd_array_cnt__fd_array_too_big()
      veristat: Fix a memory leak for preset ENUMERATOR
      selftests/bpf: Fix use-after-free in xdp_metadata test
      selftests/bpf: Fix double thread join in uprobe_multi_test
      selftests/bpf: Fix resource leaks caused by missing cleanups
      selftests/bpf: Free bpf_object in test_sysctl
      selftests/bpf: Fix array bounds warning in jit_disasm_helpers
      selftests/bpf: Fix out-of-bounds array access bugs reported by ASAN
      selftests/bpf: Check BPFTOOL env var in detect_bpftool_path()
      selftests/bpf: Don't override SIGSEGV handler with ASAN
      selftests/bpf: Fix a memory leak in xdp_flowtable test

Jiayuan Chen (2):
      bpf: Fix race in cpumap on PREEMPT_RT
      bpf: Fix race in devmap on PREEMPT_RT

Jiri Olsa (1):
      bpf: Fix kprobe_multi cookies access in show_fdinfo callback

Kohei Enju (1):
      bpf: Fix stack-out-of-bounds write in devmap

Kumar Kartikeya Dwivedi (5):
      bpf: Register dtor for freeing special fields
      bpf: Lose const-ness of map in map_check_btf()
      bpf: Delay freeing fields in local storage
      bpf: Retire rcu_trace_implies_rcu_gp() from local storage
      selftests/bpf: Add tests for special fields races

Paul Chaignon (3):
      bpf: Improve bounds when tnum has a single possible value
      selftests/bpf: Test refinement of single-value tnum
      selftests/bpf: Avoid simplification of crafted bounds test

T.J. Mercier (1):
      selftests/bpf: Fix OOB read in dmabuf_collector

 arch/arm64/net/bpf_jit_comp.c                      |   2 +-
 include/linux/bpf.h                                |   4 +-
 include/linux/bpf_local_storage.h                  |   2 +-
 include/linux/bpf_mem_alloc.h                      |   6 +
 include/linux/tnum.h                               |   3 +
 kernel/bpf/arena.c                                 |   2 +-
 kernel/bpf/arraymap.c                              |   2 +-
 kernel/bpf/bloom_filter.c                          |   2 +-
 kernel/bpf/bpf_insn_array.c                        |   2 +-
 kernel/bpf/bpf_local_storage.c                     |  75 +++----
 kernel/bpf/cpumap.c                                |  17 +-
 kernel/bpf/devmap.c                                |  47 ++++-
 kernel/bpf/hashtab.c                               |  86 ++++++++
 kernel/bpf/local_storage.c                         |   2 +-
 kernel/bpf/lpm_trie.c                              |   2 +-
 kernel/bpf/memalloc.c                              |  58 ++++--
 kernel/bpf/syscall.c                               |   2 +-
 kernel/bpf/tnum.c                                  |  56 ++++++
 kernel/bpf/verifier.c                              |  30 +++
 kernel/trace/bpf_trace.c                           |   4 +-
 tools/bpf/resolve_btfids/Makefile                  |   7 +-
 tools/bpf/resolve_btfids/main.c                    |  81 +++++---
 tools/include/linux/args.h                         |   4 +
 tools/testing/selftests/bpf/DENYLIST.asan          |   3 +
 tools/testing/selftests/bpf/Makefile               |  13 +-
 tools/testing/selftests/bpf/benchs/bench_trigger.c |  14 +-
 tools/testing/selftests/bpf/bpf_util.h             |  45 +++--
 tools/testing/selftests/bpf/bpftool_helpers.c      |  25 ++-
 tools/testing/selftests/bpf/cgroup_helpers.c       |   2 +-
 tools/testing/selftests/bpf/jit_disasm_helpers.c   |  18 +-
 tools/testing/selftests/bpf/network_helpers.c      |   5 +-
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c  |   3 +-
 .../testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  |   2 +-
 .../selftests/bpf/prog_tests/cgrp_local_storage.c  |   4 +-
 .../testing/selftests/bpf/prog_tests/ctx_rewrite.c |   6 +-
 tools/testing/selftests/bpf/prog_tests/dynptr.c    |   5 +-
 tools/testing/selftests/bpf/prog_tests/fd_array.c  |   4 +-
 .../selftests/bpf/prog_tests/flow_dissector.c      |   4 +-
 .../testing/selftests/bpf/prog_tests/htab_update.c |   1 +
 .../selftests/bpf/prog_tests/kmem_cache_iter.c     |   7 +-
 .../selftests/bpf/prog_tests/kprobe_multi_test.c   |  12 +-
 .../selftests/bpf/prog_tests/lwt_seg6local.c       |   2 +-
 .../selftests/bpf/prog_tests/map_kptr_race.c       | 218 +++++++++++++++++++++
 .../selftests/bpf/prog_tests/queue_stack_map.c     |   4 +-
 .../testing/selftests/bpf/prog_tests/reg_bounds.c  |   2 +-
 .../selftests/bpf/prog_tests/setget_sockopt.c      |   2 +-
 .../selftests/bpf/prog_tests/skc_to_unix_sock.c    |   2 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c       |  28 +--
 .../selftests/bpf/prog_tests/sockmap_listen.c      |   2 +-
 .../testing/selftests/bpf/prog_tests/sockopt_sk.c  |   2 +-
 .../bpf/prog_tests/struct_ops_private_stack.c      |   4 +-
 .../selftests/bpf/prog_tests/task_local_data.h     |   2 +-
 tools/testing/selftests/bpf/prog_tests/tc_opts.c   |   6 +-
 .../testing/selftests/bpf/prog_tests/tc_redirect.c |   2 +-
 .../testing/selftests/bpf/prog_tests/test_sysctl.c |   3 +
 .../selftests/bpf/prog_tests/test_tc_tunnel.c      |   5 +-
 .../selftests/bpf/prog_tests/test_veristat.c       |   4 +-
 tools/testing/selftests/bpf/prog_tests/test_xsk.c  |  24 ++-
 .../selftests/bpf/prog_tests/uprobe_multi_test.c   |   6 +-
 .../selftests/bpf/prog_tests/verifier_log.c        |   2 +-
 .../selftests/bpf/prog_tests/xdp_flowtable.c       |   3 +-
 .../selftests/bpf/prog_tests/xdp_metadata.c        |   4 +-
 tools/testing/selftests/bpf/progs/dmabuf_iter.c    |   2 +-
 tools/testing/selftests/bpf/progs/map_kptr_race.c  | 197 +++++++++++++++++++
 .../testing/selftests/bpf/progs/verifier_bounds.c  | 137 +++++++++++++
 tools/testing/selftests/bpf/test_progs.c           |  38 ++--
 tools/testing/selftests/bpf/test_verifier.c        |   2 +-
 tools/testing/selftests/bpf/testing_helpers.c      |   1 +
 tools/testing/selftests/bpf/trace_helpers.c        |  23 +--
 tools/testing/selftests/bpf/trace_helpers.h        |  11 +-
 tools/testing/selftests/bpf/veristat.c             |   2 +
 tools/testing/selftests/bpf/xdp_features.c         |   3 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |   4 +-
 73 files changed, 1180 insertions(+), 236 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/DENYLIST.asan
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_kptr_race.c
