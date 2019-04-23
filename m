Return-Path: <SRS0=rV2l=SZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94685C10F11
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 03:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCED2075A
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 03:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555989218;
	bh=2wb3/yQqD/jIX7W+wtM3rTM5kkC1JvKYDOieFgeo9jQ=;
	h=From:To:CC:Subject:Date:List-ID:From;
	b=E17SCe18gD+N9alisJRAzQRAK6WRT34RUgrgItfXp51lUwmgbZ3iuzTuNUZ5fB9Df
	 Yz5wizk29J9GDsd28xsMQdYuk/mZudGtNQvPdH2SeK+qCkj8qtlKrsRLtAcxMXMovl
	 /x2Owa0lqnFApb/x23H3KT+RVL9+6Cj59EjLOx84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfDWDNh convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Mon, 22 Apr 2019 23:13:37 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50208 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728865AbfDWDNh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Apr 2019 23:13:37 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3N34GlC014371
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2019 20:13:36 -0700
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s1k6msjxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2019 20:13:36 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 22 Apr 2019 20:13:36 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id C49DA760DD0; Mon, 22 Apr 2019 20:13:35 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: pull-request: bpf-next 2019-04-22
Date:   Mon, 22 Apr 2019 20:13:35 -0700
Message-ID: <20190423031335.2153113-1-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-22_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

The following pull-request contains BPF updates for your *net-next* tree.

The main changes are:

1) allow stack/queue helpers from more bpf program types, from Alban.

2) allow parallel verification of root bpf programs, from Alexei.

3) introduce bpf sysctl hook for trusted root cases, from Andrey.

4) recognize var/datasec in btf deduplication, from Andrii.

5) cpumap performance optimizations, from Jesper.

6) verifier prep for alu32 optimization, from Jiong.

7) libbpf xsk cleanup, from Magnus.

8) other various fixes and cleanups.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

Thanks a lot!

----------------------------------------------------------------

The following changes since commit e0a092ebebf714c7b6723cae764fc865e2f8c2a7:

  Merge branch 'smc-next' (2019-04-12 10:50:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git 

for you to fetch changes up to f79b464fd6b56b6256de43bc4c7d5968c0e52968:

  Merge branch 'bpf-verifier-lock' (2019-04-23 01:51:49 +0200)

----------------------------------------------------------------
Alan Maguire (1):
      bpf: fix whitespace for ENCAP_L2 defines in bpf.h

Alban Crequy (1):
      bpf: add map helper functions push, pop, peek in more BPF programs

Alexei Starovoitov (7):
      Merge branch 'bpf-sysctl-hook'
      selftests/bpf: two scale tests
      Merge branch 'af_xdp-smp_mb-fixes'
      Merge branch 'bulk-cpumap-redirect'
      bpf: document the verifier limits
      bpf: remove global variables
      bpf: drop bpf_verifier_lock

Andrey Ignatov (24):
      bpf: Add base proto function for cgroup-bpf programs
      bpf: Sysctl hook
      bpf: Introduce bpf_sysctl_get_name helper
      bpf: Introduce bpf_sysctl_get_current_value helper
      bpf: Introduce bpf_sysctl_{get,set}_new_value helpers
      bpf: Add file_pos field to bpf_sysctl ctx
      bpf: Sync bpf.h to tools/
      libbpf: Support sysctl hook
      selftests/bpf: Test sysctl section name
      selftests/bpf: Test BPF_CGROUP_SYSCTL
      selftests/bpf: Test bpf_sysctl_get_name helper
      selftests/bpf: Test sysctl_get_current_value helper
      selftests/bpf: Test bpf_sysctl_{get,set}_new_value helpers
      selftests/bpf: Test file_pos field in bpf_sysctl ctx
      bpf: Introduce ARG_PTR_TO_{INT,LONG} arg types
      bpf: Introduce bpf_strtol and bpf_strtoul helpers
      bpf: Sync bpf.h to tools/
      selftests/bpf: Add sysctl and strtoX helpers to bpf_helpers.h
      selftests/bpf: Test ARG_PTR_TO_LONG arg type
      selftests/bpf: Test bpf_strtol and bpf_strtoul helpers
      selftests/bpf: C based test for sysctl and strtoX
      bpf: Fix distinct pointer types warning for ARCH=i386
      bpftool: Support sysctl hook
      bpf: Document BPF_PROG_TYPE_CGROUP_SYSCTL

Andrii Nakryiko (4):
      kbuild: handle old pahole more gracefully when generating BTF
      btf: add support for VAR and DATASEC in btf_dedup()
      selftests/btf: add VAR and DATASEC case for dedup tests
      libbpf: fix printf formatter for ptrdiff_t argument

Benjamin Poirier (2):
      bpftool: Use print_entry_error() in case of ENOENT when dumping
      bpftool: Improve handling of ENOSPC on reuseport_array map dumps

Daniel Borkmann (1):
      Merge branch 'bpf-verifier-lock'

Jesper Dangaard Brouer (4):
      bpf: cpumap use ptr_ring_consume_batched
      net: core: introduce build_skb_around
      bpf: cpumap do bulk allocation of SKBs
      bpf: cpumap memory prefetchw optimizations for struct page

Jiong Wang (4):
      bpf: refactor propagate_liveness to eliminate duplicated for loop
      bpf: refactor propagate_liveness to eliminate code redundance
      bpf: factor out reg and stack slot propagation into "propagate_liveness_reg"
      bpf: refactor "check_reg_arg" to eliminate code redundancy

Magnus Karlsson (6):
      xsk: fix XDP socket ring buffer memory ordering
      libbpf: fix XDP socket ring buffer memory ordering
      libbpf: remove likely/unlikely in xsk.h
      libbpf: remove dependency on barrier.h in xsk.h
      libbpf: optimize barrier for XDP socket rings
      libbpf: remove compile time warning from libbpf_util.h

Martin KaFai Lau (1):
      bpf: Increase MAX_NR_MAPS to 17 in test_verifier.c

McCabe, Robert J (1):
      libbpf: fix BPF_LOG_BUF_SIZE off-by-one error

Peter Oskolkov (1):
      selftests: bpf: add VRF test cases to lwt_ip_encap test.

Prashant Bhole (3):
      bpf: use BPF_CAST_CALL for casting bpf call
      tools/bpftool: re-organize newline printing for map listing
      tools/bpftool: show btf_id in map listing

Quentin Monnet (5):
      tools: bpftool: remove blank line after btf_id when listing programs
      tools: bpftool: reset errno for "bpftool cgroup tree"
      tools: bpftool: fix man page documentation for "pinmaps" keyword
      tools: bpftool: fix short option name for printing version in man pages
      tools: bpftool: add a note on program statistics in man page

Stanislav Fomichev (3):
      selftests/bpf: bring back (void *) cast to set_ipv4_csum in test_tc_tunnel
      selftests/bpf: make flow dissector tests more extensible
      bpf: move BPF_PROG_TYPE_FLOW_DISSECTOR documentation to a new common place

Viet Hoang Tran (1):
      bpf: allow clearing all sock_ops callback flags

Wang YanQing (1):
      selftests/bpf: fix compile errors due to unsync linux/in6.h and netinet/in.h

Willem de Bruijn (1):
      bpf: reserve flags in bpf_skb_net_shrink

Yonghong Song (1):
      selftests/bpf: fix a compilation error

 Documentation/bpf/bpf_design_QA.rst                |   29 +-
 Documentation/bpf/index.rst                        |   10 +
 Documentation/bpf/prog_cgroup_sysctl.rst           |  125 ++
 .../prog_flow_dissector.rst}                       |    6 +-
 Documentation/networking/index.rst                 |    1 -
 drivers/media/rc/bpf-lirc.c                        |    6 +
 fs/proc/proc_sysctl.c                              |   25 +-
 include/linux/bpf-cgroup.h                         |   21 +
 include/linux/bpf.h                                |    4 +
 include/linux/bpf_types.h                          |    1 +
 include/linux/bpf_verifier.h                       |    5 +
 include/linux/filter.h                             |   16 +
 include/linux/skbuff.h                             |    2 +
 include/uapi/linux/bpf.h                           |  154 +-
 kernel/bpf/cgroup.c                                |  370 ++++-
 kernel/bpf/cpumap.c                                |   53 +-
 kernel/bpf/helpers.c                               |  131 ++
 kernel/bpf/syscall.c                               |    7 +
 kernel/bpf/verifier.c                              |  134 +-
 kernel/trace/bpf_trace.c                           |    6 +
 net/core/filter.c                                  |    6 +-
 net/core/skbuff.c                                  |   71 +-
 net/xdp/xsk_queue.h                                |   56 +-
 scripts/link-vmlinux.sh                            |    2 +-
 tools/bpf/bpftool/Documentation/bpftool-cgroup.rst |    7 +-
 .../bpf/bpftool/Documentation/bpftool-feature.rst  |    2 +-
 tools/bpf/bpftool/Documentation/bpftool-map.rst    |    2 +-
 tools/bpf/bpftool/Documentation/bpftool-net.rst    |    2 +-
 tools/bpf/bpftool/Documentation/bpftool-perf.rst   |    2 +-
 tools/bpf/bpftool/Documentation/bpftool-prog.rst   |   15 +-
 tools/bpf/bpftool/Documentation/bpftool.rst        |    2 +-
 tools/bpf/bpftool/bash-completion/bpftool          |    7 +-
 tools/bpf/bpftool/cgroup.c                         |   10 +-
 tools/bpf/bpftool/main.h                           |    1 +
 tools/bpf/bpftool/map.c                            |   51 +-
 tools/bpf/bpftool/prog.c                           |    4 +-
 tools/include/uapi/linux/bpf.h                     |  145 +-
 tools/lib/bpf/bpf.h                                |    2 +-
 tools/lib/bpf/btf.c                                |   29 +-
 tools/lib/bpf/libbpf.c                             |    5 +-
 tools/lib/bpf/libbpf_probes.c                      |    1 +
 tools/lib/bpf/libbpf_util.h                        |   30 +
 tools/lib/bpf/xsk.h                                |   22 +-
 tools/testing/selftests/bpf/Makefile               |    3 +-
 tools/testing/selftests/bpf/bpf_helpers.h          |   19 +
 .../selftests/bpf/prog_tests/flow_dissector.c      |  199 ++-
 .../testing/selftests/bpf/progs/test_sysctl_prog.c |   70 +
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c |    2 +-
 .../testing/selftests/bpf/progs/test_tcpbpf_kern.c |    2 +-
 .../selftests/bpf/progs/test_tcpnotify_kern.c      |    2 +-
 tools/testing/selftests/bpf/test_btf.c             |   49 +
 tools/testing/selftests/bpf/test_lwt_ip_encap.sh   |  134 +-
 tools/testing/selftests/bpf/test_section_names.c   |    5 +
 tools/testing/selftests/bpf/test_sysctl.c          | 1567 ++++++++++++++++++++
 tools/testing/selftests/bpf/test_verifier.c        |   72 +-
 tools/testing/selftests/bpf/verifier/int_ptr.c     |  160 ++
 tools/testing/selftests/bpf/verifier/scale.c       |   18 +
 57 files changed, 3594 insertions(+), 288 deletions(-)
 create mode 100644 Documentation/bpf/prog_cgroup_sysctl.rst
 rename Documentation/{networking/bpf_flow_dissector.rst => bpf/prog_flow_dissector.rst} (98%)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sysctl_prog.c
 create mode 100644 tools/testing/selftests/bpf/test_sysctl.c
 create mode 100644 tools/testing/selftests/bpf/verifier/int_ptr.c
 create mode 100644 tools/testing/selftests/bpf/verifier/scale.c
