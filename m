Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB53C10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 23:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FAD20850
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 23:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfDKXZx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 19:25:53 -0400
Received: from www62.your-server.de ([213.133.104.62]:46186 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfDKXZx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 19:25:53 -0400
Received: from [178.197.249.32] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hEj4k-0004dW-DI; Fri, 12 Apr 2019 01:25:46 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: pull-request: bpf-next 2019-04-12
Date:   Fri, 12 Apr 2019 01:25:46 +0200
Message-Id: <20190411232546.15502-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25416/Thu Apr 11 09:55:16 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

The following pull-request contains BPF updates for your *net-next* tree.

The main changes are:

1) Improve BPF verifier scalability for large programs through two
   optimizations: i) remove verifier states that are not useful in pruning,
   ii) stop walking parentage chain once first LIVE_READ is seen. Combined
   gives approx 20x speedup. Increase limits for accepting large programs
   under root, and add various stress tests, from Alexei.

2) Implement global data support in BPF. This enables static global variables
   for .data, .rodata and .bss sections to be properly handled which allows
   for more natural program development. This also opens up the possibility
   to optimize program workflow by compiling ELFs only once and later only
   rewriting section data before reload, from Daniel and with test cases and
   libbpf refactoring from Joe.

3) Add config option to generate BTF type info for vmlinux as part of the
   kernel build process. DWARF debug info is converted via pahole to BTF.
   Latter relies on libbpf and makes use of BTF deduplication algorithm which
   results in 100x savings compared to DWARF data. Resulting .BTF section is
   typically about 2MB in size, from Andrii.

4) Add BPF verifier support for stack access with variable offset from
   helpers and add various test cases along with it, from Andrey.

5) Extend bpf_skb_adjust_room() growth BPF helper to mark inner MAC header
   so that L2 encapsulation can be used for tc tunnels, from Alan.

6) Add support for input __sk_buff context in BPF_PROG_TEST_RUN so that
   users can define a subset of allowed __sk_buff fields that get fed into
   the test program, from Stanislav.

7) Add bpf fs multi-dimensional array tests for BTF test suite and fix up
   various UBSAN warnings in bpftool, from Yonghong.

8) Generate a pkg-config file for libbpf, from Luca.

9) Dump program's BTF id in bpftool, from Prashant.

10) libbpf fix to use smaller BPF log buffer size for AF_XDP's XDP
    program, from Magnus.

11) kallsyms related fixes for the case when symbols are not present in
    BPF selftests and samples, from Daniel

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

Thanks a lot!

----------------------------------------------------------------

The following changes since commit 356d71e00d278d865f8c7f68adebd6ce4698a7e2:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2019-03-27 17:37:58 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git 

for you to fetch changes up to 947e8b595b82d3551750641445d0a97b8f29b536:

  bpf: explicitly prohibit ctx_{in, out} in non-skb BPF_PROG_TEST_RUN (2019-04-12 00:53:00 +0200)

----------------------------------------------------------------
Alan Maguire (4):
      selftests_bpf: extend test_tc_tunnel for UDP encap
      bpf: add layer 2 encap support to bpf_skb_adjust_room
      bpf: sync bpf.h to tools/ for BPF_F_ADJ_ROOM_ENCAP_L2
      selftests_bpf: add L2 encap to test_tc_tunnel

Alexei Starovoitov (13):
      Merge branch 'variable-stack-access'
      bpf: add verifier stats and log_level bit 2
      bpf: improve verification speed by droping states
      bpf: improve verification speed by not remarking live_read
      bpf: convert temp arrays to kvcalloc
      bpf: verbose jump offset overflow check
      bpf: increase complexity limit and maximum program size
      bpf: increase verifier log limit
      libbpf: teach libbpf about log_level bit 2
      selftests/bpf: add few verifier scale tests
      selftests/bpf: synthetic tests to push verifier limits
      samples/bpf: fix build with new clang
      Merge branch 'support-global-data'

Andrey Ignatov (11):
      bpf: Support variable offset stack access from helpers
      selftests/bpf: Test variable offset stack access
      bpf: Reject indirect var_off stack access in raw mode
      selftests/bpf: Test indirect var_off stack access in raw mode
      bpf: Reject indirect var_off stack access in unpriv mode
      selftests/bpf: Test indirect var_off stack access in unpriv mode
      bpf: Sanity check max value for var_off stack access
      selftests/bpf: Test unbounded var_off stack access
      bpf: Add missed newline in verifier verbose log
      libbpf: Ignore -Wformat-nonliteral warning
      libbpf: Fix build with gcc-8

Andrii Nakryiko (1):
      kbuild: add ability to generate BTF type info for vmlinux

Daniel Borkmann (20):
      Merge branch 'bpf-selftest-clang-fixes'
      Merge branch 'bpf-verifier-scalability'
      Merge branch 'bpf-varstack-fixes'
      bpf: implement lookup-free direct value access for maps
      bpf: do not retain flags that are not tied to map lifetime
      bpf: add program side {rd, wr}only support for maps
      bpf: add syscall side map freeze support
      bpf: allow . char as part of the object name
      bpf: add specification for BTF Var and DataSec kinds
      bpf: kernel side support for BTF Var and DataSec
      bpf: allow for key-less BTF in array map
      bpf: sync {btf, bpf}.h uapi header from tools infrastructure
      bpf, libbpf: support global data/bss/rodata sections
      bpf, libbpf: add support for BTF Var and DataSec
      bpf: bpftool support for dumping data/bss/rodata sections
      bpf, selftest: test {rd, wr}only flags and direct value access
      bpf, selftest: add test cases for BTF Var and DataSec
      mailmap: add entry for email addresses
      Merge branch 'bpf-l2-encap'
      tools: add smp_* barrier variants to include infrastructure

Daniel T. Lee (2):
      selftests/bpf: ksym_search won't check symbols exists
      samples, selftests/bpf: add NULL check for ksym_search

Joe Stringer (2):
      bpf, libbpf: refactor relocation handling
      bpf, selftest: test global data/bss/rodata sections

Luca Boccassi (1):
      tools/bpf: generate pkg-config file for libbpf

Magnus Karlsson (1):
      libbpf: fix crash in XDP socket part with new larger BPF_LOG_BUF_SIZE

Prashant Bhole (1):
      tools/bpftool: show btf id in program information

Stanislav Fomichev (9):
      selftests: bpf: tests.h should depend on .c files, not the output
      selftests: bpf: fix -Wformat-security warning for flow_dissector_load.c
      selftests: bpf: fix -Wformat-invalid-specifier for bpf_obj_id.c
      selftests: bpf: remove duplicate .flags initialization in ctx_skb.c
      bpf: support input __sk_buff context in BPF_PROG_TEST_RUN
      libbpf: add support for ctx_{size, }_{in, out} in BPF_PROG_TEST_RUN
      selftests: bpf: add selftest for __sk_buff context in BPF_PROG_TEST_RUN
      bpf: fix missing bpf_check_uarg_tail_zero in BPF_PROG_TEST_RUN
      bpf: explicitly prohibit ctx_{in, out} in non-skb BPF_PROG_TEST_RUN

Yonghong Song (2):
      bpf: add bpffs multi-dimensional array tests in test_btf
      bpf, bpftool: fix a few ubsan warnings

 .mailmap                                           |   9 +
 Documentation/bpf/btf.rst                          |  57 ++
 Makefile                                           |   3 +-
 include/linux/bpf.h                                |  75 ++-
 include/linux/bpf_verifier.h                       |  27 +
 include/linux/btf.h                                |   1 +
 include/uapi/linux/bpf.h                           |  37 +-
 include/uapi/linux/btf.h                           |  32 +-
 kernel/bpf/arraymap.c                              |  53 +-
 kernel/bpf/btf.c                                   | 419 ++++++++++++-
 kernel/bpf/core.c                                  |  14 +-
 kernel/bpf/disasm.c                                |   5 +-
 kernel/bpf/hashtab.c                               |   6 +-
 kernel/bpf/local_storage.c                         |   6 +-
 kernel/bpf/lpm_trie.c                              |   3 +-
 kernel/bpf/queue_stack_maps.c                      |   6 +-
 kernel/bpf/syscall.c                               | 144 ++++-
 kernel/bpf/verifier.c                              | 397 +++++++++---
 lib/Kconfig.debug                                  |   8 +
 net/bpf/Makefile                                   |   2 +-
 net/bpf/test_run.c                                 | 149 ++++-
 net/core/filter.c                                  |  12 +-
 samples/bpf/asm_goto_workaround.h                  |   1 +
 samples/bpf/offwaketime_user.c                     |   5 +
 samples/bpf/sampleip_user.c                        |   5 +
 samples/bpf/spintest_user.c                        |   7 +-
 samples/bpf/trace_event_user.c                     |   5 +
 scripts/link-vmlinux.sh                            |  20 +-
 tools/arch/arm64/include/asm/barrier.h             |  10 +
 tools/arch/x86/include/asm/barrier.h               |   7 +-
 tools/bpf/bpftool/btf_dumper.c                     |  59 ++
 tools/bpf/bpftool/map.c                            |  10 +-
 tools/bpf/bpftool/prog.c                           |   6 +
 tools/bpf/bpftool/xlated_dumper.c                  |   3 +
 tools/include/linux/filter.h                       |  21 +-
 tools/include/uapi/linux/bpf.h                     |  37 +-
 tools/include/uapi/linux/btf.h                     |  32 +-
 tools/lib/bpf/.gitignore                           |   1 +
 tools/lib/bpf/Makefile                             |  20 +-
 tools/lib/bpf/bpf.c                                |  36 +-
 tools/lib/bpf/bpf.h                                |   8 +-
 tools/lib/bpf/btf.c                                |  97 ++-
 tools/lib/bpf/btf.h                                |   3 +
 tools/lib/bpf/libbpf.c                             | 567 ++++++++++++++---
 tools/lib/bpf/libbpf.h                             |   6 +
 tools/lib/bpf/libbpf.map                           |   7 +
 tools/lib/bpf/libbpf.pc.template                   |  12 +
 tools/lib/bpf/xsk.c                                |   9 +-
 tools/testing/selftests/bpf/Makefile               |   4 +-
 tools/testing/selftests/bpf/bpf_helpers.h          |   8 +-
 tools/testing/selftests/bpf/config                 |   8 +
 tools/testing/selftests/bpf/flow_dissector_load.c  |   2 +-
 .../testing/selftests/bpf/prog_tests/bpf_obj_id.c  |   8 +-
 .../selftests/bpf/prog_tests/bpf_verif_scale.c     |  49 ++
 .../selftests/bpf/prog_tests/get_stack_raw_tp.c    |   4 +-
 .../testing/selftests/bpf/prog_tests/global_data.c | 157 +++++
 tools/testing/selftests/bpf/prog_tests/skb_ctx.c   |  89 +++
 .../testing/selftests/bpf/progs/test_global_data.c | 106 ++++
 tools/testing/selftests/bpf/progs/test_jhash.h     |  70 +++
 tools/testing/selftests/bpf/progs/test_skb_ctx.c   |  21 +
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c | 321 ++++++++--
 .../selftests/bpf/progs/test_verif_scale1.c        |  30 +
 .../selftests/bpf/progs/test_verif_scale2.c        |  30 +
 .../selftests/bpf/progs/test_verif_scale3.c        |  30 +
 tools/testing/selftests/bpf/test_btf.c             | 697 ++++++++++++++++++++-
 tools/testing/selftests/bpf/test_progs.c           |   6 +-
 tools/testing/selftests/bpf/test_progs.h           |   1 +
 tools/testing/selftests/bpf/test_tc_tunnel.sh      | 136 +++-
 tools/testing/selftests/bpf/test_verifier.c        |  86 ++-
 tools/testing/selftests/bpf/trace_helpers.c        |   4 +
 .../testing/selftests/bpf/verifier/array_access.c  | 159 +++++
 tools/testing/selftests/bpf/verifier/ctx_skb.c     |   1 -
 .../selftests/bpf/verifier/direct_value_access.c   | 347 ++++++++++
 tools/testing/selftests/bpf/verifier/ld_dw.c       |   9 +
 tools/testing/selftests/bpf/verifier/var_off.c     | 186 +++++-
 75 files changed, 4603 insertions(+), 425 deletions(-)
 create mode 100644 tools/lib/bpf/libbpf.pc.template
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/global_data.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/skb_ctx.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_jhash.h
 create mode 100644 tools/testing/selftests/bpf/progs/test_skb_ctx.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_verif_scale1.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_verif_scale2.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_verif_scale3.c
 create mode 100644 tools/testing/selftests/bpf/verifier/direct_value_access.c
