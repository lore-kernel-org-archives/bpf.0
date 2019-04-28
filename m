Return-Path: <SRS0=Xozv=S6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0A0C43219
	for <bpf@archiver.kernel.org>; Sun, 28 Apr 2019 10:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF93B206BF
	for <bpf@archiver.kernel.org>; Sun, 28 Apr 2019 10:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfD1K7Q (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 28 Apr 2019 06:59:16 -0400
Received: from www62.your-server.de ([213.133.104.62]:38484 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfD1K7Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Apr 2019 06:59:16 -0400
Received: from [80.254.69.30] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hKhWY-0005ci-1h; Sun, 28 Apr 2019 12:59:10 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: pull-request: bpf-next 2019-04-28
Date:   Sun, 28 Apr 2019 12:59:09 +0200
Message-Id: <20190428105909.9248-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25433/Sun Apr 28 09:57:23 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

The following pull-request contains BPF updates for your *net-next* tree.

The main changes are:

1) Introduce BPF socket local storage map so that BPF programs can store
   private data they associate with a socket (instead of e.g. separate hash
   table), from Martin.

2) Add support for bpftool to dump BTF types. This is done through a new
   `bpftool btf dump` sub-command, from Andrii.

3) Enable BPF-based flow dissector for skb-less eth_get_headlen() calls which
   was currently not supported since skb was used to lookup netns, from Stanislav.

4) Add an opt-in interface for tracepoints to expose a writable context
   for attached BPF programs, used here for NBD sockets, from Matt.

5) BPF xadd related arm64 JIT fixes and scalability improvements, from Daniel.

6) Change the skb->protocol for bpf_skb_adjust_room() helper in order to
   support tunnels such as sit. Add selftests as well, from Willem.

7) Various smaller misc fixes.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

Thanks a lot!

----------------------------------------------------------------

The following changes since commit 7e6e185c74dd8a8dc539300c079adc6bc27045d6:

  net: systemport: Remove need for DMA descriptor (2019-04-22 22:20:15 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git 

for you to fetch changes up to 9076c49bdca2aa68c805f2677b2bccc4bde2bac1:

  Merge branch 'sk-local-storage' (2019-04-27 09:07:49 -0700)

----------------------------------------------------------------
Alexei Starovoitov (4):
      Merge branch 'libbpf-fixes'
      Merge branch 'btf-dump'
      Merge branch 'writeable-bpf-tracepoints'
      Merge branch 'sk-local-storage'

Andrew Hall (1):
      nbd: add tracepoints for send/receive timing

Andrii Nakryiko (4):
      bpftool: add ability to dump BTF types
      bpftool/docs: add btf sub-command documentation
      bpftool: add bash completions for btf command
      bpftool: fix indendation in bash-completion/bpftool

Benjamin Poirier (1):
      bpftool: Fix errno variable usage

Daniel Borkmann (6):
      Merge branch 'bpf-eth-get-headlen'
      Merge branch 'bpf-proto-fixes'
      bpf, libbpf: handle old kernels more graceful wrt global data sections
      bpf, libbpf: fix segfault in bpf_object__init_maps' pr_debug statement
      bpf, arm64: remove prefetch insn in xadd mapping
      bpf, arm64: use more scalable stadd over ldxr / stxr loop in xadd

Daniel T. Lee (2):
      libbpf: fix samples/bpf build failure due to undefined UINT32_MAX
      samples: bpf: add hbm sample to .gitignore

Martin KaFai Lau (7):
      bpf: Introduce bpf sk local storage
      bpf: Sync bpf.h to tools
      bpf: Support BPF_MAP_TYPE_SK_STORAGE in bpf map probing
      bpf: Refactor BTF encoding macro to test_btf.h
      bpf: Add verifier tests for the bpf_sk_storage
      bpf: Add BPF_MAP_TYPE_SK_STORAGE test to test_maps
      bpf: Add ene-to-end test for bpf_sk_storage_* helpers

Matt Mullins (4):
      bpf: add writable context for raw tracepoints
      nbd: trace sending nbd requests
      tools: sync bpf.h
      selftests: bpf: test writable buffers in raw tps

Stanislav Fomichev (11):
      flow_dissector: switch kernel context to struct bpf_flow_dissector
      bpf: when doing BPF_PROG_TEST_RUN for flow dissector use no-skb mode
      net: plumb network namespace into __skb_flow_dissect
      flow_dissector: handle no-skb use case
      net: pass net_device argument to the eth_get_headlen
      selftests/bpf: add flow dissector bpf_skb_load_bytes helper test
      selftests/bpf: run flow dissector tests in skb-less mode
      selftests/bpf: properly return error from bpf_flow_load
      bpf/flow_dissector: don't adjust nhoff by ETH_HLEN in BPF_PROG_TEST_RUN
      bpf: support BPF_PROG_QUERY for BPF_FLOW_DISSECTOR attach_type
      bpftool: show flow_dissector attachment status

Willem de Bruijn (2):
      bpf: update skb->protocol in bpf_skb_net_grow
      selftests/bpf: expand test_tc_tunnel with SIT encap

 MAINTAINERS                                        |   1 +
 arch/arm64/include/asm/insn.h                      |   8 +
 arch/arm64/kernel/insn.c                           |  40 +
 arch/arm64/net/bpf_jit.h                           |   8 +-
 arch/arm64/net/bpf_jit_comp.c                      |  29 +-
 drivers/block/nbd.c                                |  13 +
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |   3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_main.c      |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   3 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c        |   2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |   2 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   2 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |   2 +-
 drivers/net/tun.c                                  |   3 +-
 include/linux/bpf.h                                |   4 +
 include/linux/bpf_types.h                          |   2 +
 include/linux/etherdevice.h                        |   2 +-
 include/linux/skbuff.h                             |  36 +-
 include/linux/tracepoint-defs.h                    |   1 +
 include/net/bpf_sk_storage.h                       |  13 +
 include/net/flow_dissector.h                       |   7 +
 include/net/sch_generic.h                          |  11 +-
 include/net/sock.h                                 |   5 +
 include/trace/bpf_probe.h                          |  27 +-
 include/trace/events/bpf_test_run.h                |  50 ++
 include/trace/events/nbd.h                         | 107 +++
 include/uapi/linux/bpf.h                           |  45 +-
 kernel/bpf/syscall.c                               |  13 +-
 kernel/bpf/verifier.c                              |  58 +-
 kernel/trace/bpf_trace.c                           |  24 +
 net/bpf/test_run.c                                 |  54 +-
 net/core/Makefile                                  |   1 +
 net/core/bpf_sk_storage.c                          | 804 +++++++++++++++++++++
 net/core/filter.c                                  | 125 +++-
 net/core/flow_dissector.c                          | 129 ++--
 net/core/sock.c                                    |   5 +
 net/ethernet/eth.c                                 |   8 +-
 samples/bpf/.gitignore                             |   1 +
 tools/bpf/bpftool/Documentation/bpftool-btf.rst    | 222 ++++++
 tools/bpf/bpftool/Documentation/bpftool-cgroup.rst |   3 +-
 .../bpf/bpftool/Documentation/bpftool-feature.rst  |   3 +-
 tools/bpf/bpftool/Documentation/bpftool-map.rst    |   3 +-
 tools/bpf/bpftool/Documentation/bpftool-net.rst    |   3 +-
 tools/bpf/bpftool/Documentation/bpftool-perf.rst   |   3 +-
 tools/bpf/bpftool/Documentation/bpftool-prog.rst   |   3 +-
 tools/bpf/bpftool/Documentation/bpftool.rst        |   3 +-
 tools/bpf/bpftool/bash-completion/bpftool          |  68 +-
 tools/bpf/bpftool/btf.c                            | 586 +++++++++++++++
 tools/bpf/bpftool/main.c                           |   3 +-
 tools/bpf/bpftool/main.h                           |   1 +
 tools/bpf/bpftool/map.c                            |   3 +-
 tools/bpf/bpftool/net.c                            |  54 ++
 tools/include/uapi/linux/bpf.h                     |  54 +-
 tools/lib/bpf/bpf.h                                |   1 +
 tools/lib/bpf/libbpf.c                             | 106 ++-
 tools/lib/bpf/libbpf_probes.c                      |  75 +-
 tools/testing/selftests/bpf/Makefile               |  25 +-
 tools/testing/selftests/bpf/bpf_helpers.h          |   5 +
 tools/testing/selftests/bpf/config                 |   1 +
 tools/testing/selftests/bpf/flow_dissector_load.c  |   2 +-
 tools/testing/selftests/bpf/flow_dissector_load.h  |  24 +-
 .../selftests/bpf/map_tests/sk_storage_map.c       | 629 ++++++++++++++++
 .../selftests/bpf/prog_tests/flow_dissector.c      | 113 ++-
 .../bpf/prog_tests/flow_dissector_load_bytes.c     |  48 ++
 .../raw_tp_writable_reject_nbd_invalid.c           |  42 ++
 .../bpf/prog_tests/raw_tp_writable_test_run.c      |  80 ++
 tools/testing/selftests/bpf/progs/bpf_flow.c       |  79 +-
 .../selftests/bpf/progs/test_sock_fields_kern.c    |  53 ++
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c |  64 +-
 tools/testing/selftests/bpf/test_btf.c             |  63 +-
 tools/testing/selftests/bpf/test_btf.h             |  69 ++
 tools/testing/selftests/bpf/test_maps.c            |  18 +-
 tools/testing/selftests/bpf/test_maps.h            |  17 +
 tools/testing/selftests/bpf/test_sock_fields.c     | 115 ++-
 tools/testing/selftests/bpf/test_tc_tunnel.sh      |  20 +-
 tools/testing/selftests/bpf/test_verifier.c        |  55 +-
 .../selftests/bpf/verifier/raw_tp_writable.c       |  34 +
 tools/testing/selftests/bpf/verifier/sock.c        | 116 +++
 84 files changed, 4168 insertions(+), 361 deletions(-)
 create mode 100644 include/net/bpf_sk_storage.h
 create mode 100644 include/trace/events/bpf_test_run.h
 create mode 100644 include/trace/events/nbd.h
 create mode 100644 net/core/bpf_sk_storage.c
 create mode 100644 tools/bpf/bpftool/Documentation/bpftool-btf.rst
 create mode 100644 tools/bpf/bpftool/btf.c
 create mode 100644 tools/testing/selftests/bpf/map_tests/sk_storage_map.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/raw_tp_writable_reject_nbd_invalid.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/raw_tp_writable_test_run.c
 create mode 100644 tools/testing/selftests/bpf/test_btf.h
 create mode 100644 tools/testing/selftests/bpf/test_maps.h
 create mode 100644 tools/testing/selftests/bpf/verifier/raw_tp_writable.c
