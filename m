Return-Path: <SRS0=MJ0i=RT=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE2CC43381
	for <bpf@archiver.kernel.org>; Sat, 16 Mar 2019 00:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3F2218D4
	for <bpf@archiver.kernel.org>; Sat, 16 Mar 2019 00:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfCPAoA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Mar 2019 20:44:00 -0400
Received: from www62.your-server.de ([213.133.104.62]:40210 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfCPAoA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Mar 2019 20:44:00 -0400
Received: from [178.197.248.24] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h4xQa-0007hq-Ml; Sat, 16 Mar 2019 01:43:56 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: pull-request: bpf 2019-03-16
Date:   Sat, 16 Mar 2019 01:43:56 +0100
Message-Id: <20190316004356.9472-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25389/Fri Mar 15 08:52:25 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

The following pull-request contains BPF updates for your *net* tree.

The main changes are:

1) Fix a umem memory leak on cleanup in AF_XDP, from Björn.

2) Fix BTF to properly resolve forward-declared enums into their corresponding
   full enum definition types during deduplication, from Andrii.

3) Fix libbpf to reject invalid flags in xsk_socket__create(), from Magnus.

4) Fix accessing invalid pointer returned from bpf_tcp_sock() and
   bpf_sk_fullsock() after bpf_sk_release() was called, from Martin.

5) Fix generation of load/store DW instructions in PPC JIT, from Naveen.

6) Various fixes in BPF helper function documentation in bpf.h UAPI header
   used to bpf-helpers(7) man page, from Quentin.

7) Fix segfault in BPF test_progs when prog loading failed, from Yonghong.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Thanks a lot!

----------------------------------------------------------------

The following changes since commit 2a5ff07a0eb945f291e361aa6f6becca8340ba46:

  gro_cells: make sure device is up in gro_cells_receive() (2019-03-10 11:07:14 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 

for you to fetch changes up to 86be36f6502c52ddb4b85938145324fd07332da1:

  powerpc: bpf: Fix generation of load/store DW instructions (2019-03-16 01:28:22 +0100)

----------------------------------------------------------------
Alexei Starovoitov (3):
      Merge branch 'fix-fullsock-access-after-bpf_sk_release'
      Merge branch 'fix-fwd-enum-resolution'
      Merge branch 'fix-bpf-docs'

Andrii Nakryiko (3):
      libbpf: handle BTF parsing and loading properly
      btf: resolve enum fwds in btf_dedup
      selftests/bpf: add fwd enum resolution test for btf_dedup

Björn Töpel (1):
      xsk: fix umem memory leak on cleanup

Magnus Karlsson (1):
      libbpf: fix to reject unknown flags in xsk_socket__create()

Martin KaFai Lau (5):
      bpf: Fix bpf_tcp_sock and bpf_sk_fullsock issue related to bpf_sk_release
      bpf: Add bpf_get_listener_sock(struct bpf_sock *sk) helper
      bpf: Sync bpf.h to tools/
      bpf: Test ref release issue in bpf_tcp_sock and bpf_sk_fullsock
      bpf: Add an example for bpf_get_listener_sock

Naveen N. Rao (1):
      powerpc: bpf: Fix generation of load/store DW instructions

Quentin Monnet (3):
      bpf: fix documentation for eBPF helpers
      bpf: add documentation for helpers bpf_spin_lock(), bpf_spin_unlock()
      tools: bpf: synchronise BPF UAPI header with tools

Yonghong Song (1):
      selftests/bpf: fix segfault of test_progs when prog loading failed

 arch/powerpc/include/asm/ppc-opcode.h              |   2 +
 arch/powerpc/net/bpf_jit.h                         |  17 +-
 arch/powerpc/net/bpf_jit32.h                       |   4 +
 arch/powerpc/net/bpf_jit64.h                       |  20 +++
 arch/powerpc/net/bpf_jit_comp64.c                  |  12 +-
 include/linux/bpf.h                                |   1 -
 include/linux/bpf_verifier.h                       |  40 +++++
 include/net/xdp_sock.h                             |   1 -
 include/uapi/linux/bpf.h                           | 188 ++++++++++++++-------
 kernel/bpf/verifier.c                              | 131 +++++++-------
 net/core/filter.c                                  |  27 ++-
 net/xdp/xdp_umem.c                                 |  19 +--
 tools/include/uapi/linux/bpf.h                     | 188 ++++++++++++++-------
 tools/lib/bpf/btf.c                                |  51 ++++--
 tools/lib/bpf/libbpf.c                             |  13 +-
 tools/lib/bpf/xsk.c                                |  15 +-
 tools/testing/selftests/bpf/bpf_helpers.h          |   2 +
 tools/testing/selftests/bpf/prog_tests/map_lock.c  |   2 +-
 tools/testing/selftests/bpf/prog_tests/spinlock.c  |   2 +-
 .../selftests/bpf/progs/test_sock_fields_kern.c    |  88 ++++++++--
 tools/testing/selftests/bpf/test_btf.c             |  44 +++++
 tools/testing/selftests/bpf/test_sock_fields.c     | 134 ++++++++++++---
 .../testing/selftests/bpf/verifier/ref_tracking.c  | 168 ++++++++++++++++++
 tools/testing/selftests/bpf/verifier/sock.c        |   4 +-
 24 files changed, 883 insertions(+), 290 deletions(-)
