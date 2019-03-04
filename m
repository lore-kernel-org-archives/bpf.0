Return-Path: <SRS0=/NIo=RH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B01C43381
	for <bpf@archiver.kernel.org>; Mon,  4 Mar 2019 11:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D240220835
	for <bpf@archiver.kernel.org>; Mon,  4 Mar 2019 11:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfCDLTZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 4 Mar 2019 06:19:25 -0500
Received: from www62.your-server.de ([213.133.104.62]:60646 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfCDLTZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Mar 2019 06:19:25 -0500
Received: from [83.78.160.158] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h0lct-0007ZV-Rl; Mon, 04 Mar 2019 12:19:20 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: pull-request: bpf-next 2019-03-04
Date:   Mon,  4 Mar 2019 12:19:19 +0100
Message-Id: <20190304111919.28550-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25377/Sun Mar  3 11:37:14 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

The following pull-request contains BPF updates for your *net-next* tree.

The main changes are:

1) Add AF_XDP support to libbpf. Rationale is to facilitate writing
   AF_XDP applications by offering higher-level APIs that hide many
   of the details of the AF_XDP uapi. Sample programs are converted
   over to this new interface as well, from Magnus.

2) Introduce a new cant_sleep() macro for annotation of functions
   that cannot sleep and use it in BPF_PROG_RUN() to assert that
   BPF programs run under preemption disabled context, from Peter.

3) Introduce per BPF prog stats in order to monitor the usage
   of BPF; this is controlled by kernel.bpf_stats_enabled sysctl
   knob where monitoring tools can make use of this to efficiently
   determine the average cost of programs, from Alexei.

4) Split up BPF selftest's test_progs similarly as we already
   did with test_verifier. This allows to further reduce merge
   conflicts in future and to get more structure into our
   quickly growing BPF selftest suite, from Stanislav.

5) Fix a bug in BTF's dedup algorithm which can cause an infinite
   loop in some circumstances; also various BPF doc fixes and
   improvements, from Andrii.

6) Various BPF sample cleanups and migration to libbpf in order
   to further isolate the old sample loader code (so we can get
   rid of it at some point), from Jakub.

7) Add a new BPF helper for BPF cgroup skb progs that allows
   to set ECN CE code point and a Host Bandwidth Manager (HBM)
   sample program for limiting the bandwidth used by v2 cgroups,
   from Lawrence.

8) Enable write access to skb->queue_mapping from tc BPF egress
   programs in order to let BPF pick TX queue, from Jesper.

9) Fix a bug in BPF spinlock handling for map-in-map which did
   not propagate spin_lock_off to the meta map, from Yonghong.

10) Fix a bug in the new per-CPU BPF prog counters to properly
    initialize stats for each CPU, from Eric.

11) Add various BPF helper prototypes to selftest's bpf_helpers.h,
    from Willem.

12) Fix various BPF samples bugs in XDP and tracing progs,
    from Toke, Daniel and Yonghong.

13) Silence preemption splat in test_bpf after BPF_PROG_RUN()
    enforces it now everywhere, from Anders.

14) Fix a signedness bug in libbpf's btf_dedup_ref_type() to
    get error handling working, from Dan.

15) Fix bpftool documentation and auto-completion with regards
    to stream_{verdict,parser} attach types, from Alban.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

Thanks a lot!

----------------------------------------------------------------

The following changes since commit c9b747dbc2036c917b1067fbb78dc38b105c4454:

  bnx2x: Remove set but not used variable 'mfw_vn' (2019-02-18 16:47:32 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git 

for you to fetch changes up to 87dab7c3d54ce0f1ff6b54840bf7279d0944bc6a:

  bpf: add test cases for non-pointer sanitiation logic (2019-03-04 10:54:20 +0100)

----------------------------------------------------------------
Alban Crequy (1):
      bpf: bpftool, fix documentation for attach types

Alexei Starovoitov (9):
      seccomp, bpf: disable preemption before calling into bpf prog
      bpf: enable program stats
      bpf: expose program stats via bpf_prog_info
      tools/bpf: sync bpf.h into tools
      tools/bpftool: recognize bpf_prog_info run_time_ns and run_cnt
      Merge branch 'inner_map_spin_lock-fix'
      bpf: fix build without bpf_syscall
      Merge branch 'bpf_skb_ecn_set_ce'
      Merge branch 'split-test_progs'

Anders Roxell (1):
      bpf: test_bpf: turn off preemption in function __run_once

Andrii Nakryiko (8):
      selftests/bpf: fix btf_dedup testing code
      libbpf: fix formatting for btf_ext__get_raw_data
      btf: allow to customize dedup hash table size
      btf: fix bug with resolving STRUCT/UNION into corresponding FWD
      selftests/bpf: add btf_dedup test of FWD/STRUCT resolution
      docs/btf: fix typos, improve wording
      docs/btf: reflow text to fill up to 78 characters
      docs/bpf: minor casing/punctuation fixes

Dan Carpenter (1):
      tools/libbpf: signedness bug in btf_dedup_ref_type()

Daniel Borkmann (6):
      Merge branch 'bpf-libbpf-af-xdp'
      Merge branch 'bpf-prog-stats'
      Merge branch 'bpf-samples-improvements'
      Merge branch 'bpf-dedup-fixes'
      Merge branch 'bpf-doc-improvements'
      bpf: add test cases for non-pointer sanitiation logic

Daniel T. Lee (1):
      samples: bpf: fix: broken sample regarding removed function

Eric Dumazet (1):
      bpf: fix u64_stats_init() usage in bpf_prog_alloc()

Jakub Kicinski (5):
      samples: bpf: force IPv4 in ping
      samples: bpf: remove load_sock_ops in favour of bpftool
      tools: libbpf: add a correctly named define for map iteration
      samples: bpf: use libbpf where easy
      tools: libbpf: make sure readelf shows full names in build checks

Jesper Dangaard Brouer (1):
      bpf: add skb->queue_mapping write access from tc clsact

Magnus Karlsson (3):
      libbpf: add support for using AF_XDP sockets
      samples/bpf: convert xdpsock to use libbpf for AF_XDP access
      xsk: add FAQ to facilitate for first time users

Peter Zijlstra (1):
      bpf: check that BPF programs run with preemption disabled

Stanislav Fomichev (10):
      bpf/test_run: fix unkillable BPF_PROG_TEST_RUN for flow dissector
      selftests/bpf: make sure signal interrupts BPF_PROG_TEST_RUN
      selftests/bpf: use __bpf_constant_htons in test_prog.c for flow dissector
      selftests: bpf: break up test_progs - preparations
      selftests: bpf: break up test_progs - pkt access
      selftests: bpf: break up test_progs - xdp
      selftests: bpf: break up test_progs - stackmap
      selftests: bpf: break up test_progs - tracepoint
      selftests: bpf: break up test_progs - spinlock
      selftests: bpf: break up test_progs - misc

Toke Høiland-Jørgensen (1):
      samples/bpf: Fix dummy program unloading for xdp_redirect samples

Willem de Bruijn (1):
      bpf: add missing entries to bpf_helpers.h

Yonghong Song (4):
      bpf: set inner_map_meta->spin_lock_off correctly
      tools/bpf: selftests: add map lookup to test_map_in_map bpf prog
      selftests/bpf: set unlimited RLIMIT_MEMLOCK for test_sock_fields
      samples/bpf: silence compiler warning for xdpsock_user.c

brakmo (5):
      bpf: add bpf helper bpf_skb_ecn_set_ce
      bpf: sync bpf.h to tools and update bpf_helpers.h
      bpf: Sample HBM BPF program to limit egress bw
      bpf: User program for testing HBM
      bpf: HBM test script

 Documentation/bpf/bpf_design_QA.rst                |   24 +-
 Documentation/bpf/btf.rst                          |  316 ++--
 Documentation/networking/af_xdp.rst                |   36 +-
 Documentation/networking/filter.txt                |    2 +-
 include/linux/bpf.h                                |    9 +
 include/linux/filter.h                             |   20 +-
 include/linux/kernel.h                             |   14 +-
 include/uapi/linux/bpf.h                           |   12 +-
 kernel/bpf/core.c                                  |   37 +-
 kernel/bpf/map_in_map.c                            |    1 +
 kernel/bpf/syscall.c                               |   39 +-
 kernel/bpf/verifier.c                              |    7 +-
 kernel/sched/core.c                                |   28 +
 kernel/seccomp.c                                   |    2 +
 kernel/sysctl.c                                    |   37 +
 lib/test_bpf.c                                     |    2 +
 net/bpf/test_run.c                                 |   26 +-
 net/core/filter.c                                  |   44 +-
 samples/bpf/.gitignore                             |    1 -
 samples/bpf/Makefile                               |   14 +-
 samples/bpf/do_hbm_test.sh                         |  436 +++++
 samples/bpf/fds_example.c                          |   10 +-
 samples/bpf/hbm.c                                  |  441 +++++
 samples/bpf/hbm.h                                  |   31 +
 samples/bpf/hbm_kern.h                             |  137 ++
 samples/bpf/hbm_out_kern.c                         |  157 ++
 samples/bpf/load_sock_ops.c                        |   97 -
 samples/bpf/sock_example.c                         |    2 +-
 samples/bpf/sockex1_user.c                         |   25 +-
 samples/bpf/sockex2_user.c                         |   23 +-
 samples/bpf/sockex3_user.c                         |    2 +-
 samples/bpf/task_fd_query_kern.c                   |    2 +-
 samples/bpf/task_fd_query_user.c                   |    2 +-
 samples/bpf/tcp_basertt_kern.c                     |    2 +-
 samples/bpf/tcp_bpf.readme                         |   14 +-
 samples/bpf/tcp_bufs_kern.c                        |    2 +-
 samples/bpf/tcp_clamp_kern.c                       |    2 +-
 samples/bpf/tcp_cong_kern.c                        |    2 +-
 samples/bpf/tcp_iw_kern.c                          |    2 +-
 samples/bpf/tcp_rwnd_kern.c                        |    2 +-
 samples/bpf/tcp_synrto_kern.c                      |    2 +-
 samples/bpf/tcp_tos_reflect_kern.c                 |    2 +-
 samples/bpf/tracex2_user.c                         |    2 +-
 samples/bpf/tracex3_kern.c                         |    2 +-
 samples/bpf/xdp_redirect_map_user.c                |    2 +-
 samples/bpf/xdp_redirect_user.c                    |    2 +-
 samples/bpf/xdpsock.h                              |   11 -
 samples/bpf/xdpsock_kern.c                         |   56 -
 samples/bpf/xdpsock_user.c                         |  841 +++-----
 tools/bpf/bpftool/Documentation/bpftool-prog.rst   |    6 +-
 tools/bpf/bpftool/bash-completion/bpftool          |    4 +-
 tools/bpf/bpftool/prog.c                           |   13 +-
 tools/include/uapi/linux/bpf.h                     |   12 +-
 tools/include/uapi/linux/ethtool.h                 |   51 +
 tools/include/uapi/linux/if_xdp.h                  |   78 +
 tools/lib/bpf/Build                                |    2 +-
 tools/lib/bpf/Makefile                             |    9 +-
 tools/lib/bpf/README.rst                           |   15 +-
 tools/lib/bpf/btf.c                                |   76 +-
 tools/lib/bpf/btf.h                                |    3 +-
 tools/lib/bpf/libbpf.c                             |    8 +-
 tools/lib/bpf/libbpf.h                             |    3 +-
 tools/lib/bpf/libbpf.map                           |    6 +
 tools/lib/bpf/xsk.c                                |  723 +++++++
 tools/lib/bpf/xsk.h                                |  203 ++
 tools/perf/util/bpf-loader.c                       |    4 +-
 tools/testing/selftests/bpf/.gitignore             |    1 +
 tools/testing/selftests/bpf/Makefile               |   27 +-
 tools/testing/selftests/bpf/bpf_helpers.h          |   32 +
 tools/testing/selftests/bpf/prog_tests/.gitignore  |    1 +
 .../testing/selftests/bpf/prog_tests/bpf_obj_id.c  |  249 +++
 .../selftests/bpf/prog_tests/flow_dissector.c      |   72 +
 .../selftests/bpf/prog_tests/get_stack_raw_tp.c    |  139 ++
 tools/testing/selftests/bpf/prog_tests/l4lb_all.c  |   90 +
 tools/testing/selftests/bpf/prog_tests/map_lock.c  |   75 +
 tools/testing/selftests/bpf/prog_tests/obj_name.c  |   71 +
 .../testing/selftests/bpf/prog_tests/pkt_access.c  |   29 +
 .../selftests/bpf/prog_tests/pkt_md_access.c       |   24 +
 .../selftests/bpf/prog_tests/prog_run_xattr.c      |   49 +
 .../selftests/bpf/prog_tests/queue_stack_map.c     |  103 +
 .../selftests/bpf/prog_tests/reference_tracking.c  |   48 +
 .../selftests/bpf/prog_tests/signal_pending.c      |   48 +
 tools/testing/selftests/bpf/prog_tests/spinlock.c  |   29 +
 .../selftests/bpf/prog_tests/stacktrace_build_id.c |  165 ++
 .../bpf/prog_tests/stacktrace_build_id_nmi.c       |  150 ++
 .../selftests/bpf/prog_tests/stacktrace_map.c      |  103 +
 .../bpf/prog_tests/stacktrace_map_raw_tp.c         |   59 +
 .../selftests/bpf/prog_tests/task_fd_query_rawtp.c |   78 +
 .../selftests/bpf/prog_tests/task_fd_query_tp.c    |   82 +
 .../testing/selftests/bpf/prog_tests/tcp_estats.c  |   19 +
 .../selftests/bpf/prog_tests/tp_attach_query.c     |  132 ++
 tools/testing/selftests/bpf/prog_tests/xdp.c       |   46 +
 .../selftests/bpf/prog_tests/xdp_adjust_tail.c     |   31 +
 .../selftests/bpf/prog_tests/xdp_noinline.c        |   82 +
 .../testing/selftests/bpf/progs/test_map_in_map.c  |    4 +
 tools/testing/selftests/bpf/test_btf.c             |   49 +-
 tools/testing/selftests/bpf/test_libbpf_open.c     |    2 +-
 tools/testing/selftests/bpf/test_progs.c           | 1999 +-------------------
 tools/testing/selftests/bpf/test_progs.h           |   93 +
 tools/testing/selftests/bpf/test_sock_fields.c     |    1 +
 .../selftests/bpf/verifier/value_ptr_arith.c       |   44 +-
 101 files changed, 5395 insertions(+), 3029 deletions(-)
 create mode 100755 samples/bpf/do_hbm_test.sh
 create mode 100644 samples/bpf/hbm.c
 create mode 100644 samples/bpf/hbm.h
 create mode 100644 samples/bpf/hbm_kern.h
 create mode 100644 samples/bpf/hbm_out_kern.c
 delete mode 100644 samples/bpf/load_sock_ops.c
 delete mode 100644 samples/bpf/xdpsock.h
 delete mode 100644 samples/bpf/xdpsock_kern.c
 create mode 100644 tools/include/uapi/linux/ethtool.h
 create mode 100644 tools/include/uapi/linux/if_xdp.h
 create mode 100644 tools/lib/bpf/xsk.c
 create mode 100644 tools/lib/bpf/xsk.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/.gitignore
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/flow_dissector.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/l4lb_all.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_lock.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/obj_name.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pkt_access.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pkt_md_access.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/prog_run_xattr.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/reference_tracking.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/signal_pending.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/spinlock.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_fd_query_rawtp.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_estats.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_noinline.c
 create mode 100644 tools/testing/selftests/bpf/test_progs.h
