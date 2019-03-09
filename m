Return-Path: <SRS0=imf1=RM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC40AC43381
	for <bpf@archiver.kernel.org>; Sat,  9 Mar 2019 00:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DECF20866
	for <bpf@archiver.kernel.org>; Sat,  9 Mar 2019 00:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfCIAIN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Mar 2019 19:08:13 -0500
Received: from www62.your-server.de ([213.133.104.62]:56850 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfCIAIM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Mar 2019 19:08:12 -0500
Received: from [178.197.249.29] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h2PX7-0004dq-Bw; Sat, 09 Mar 2019 01:08:09 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: pull-request: bpf 2019-03-09
Date:   Sat,  9 Mar 2019 01:08:08 +0100
Message-Id: <20190309000808.12713-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25382/Fri Mar  8 09:55:42 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

The following pull-request contains BPF updates for your *net* tree.

The main changes are:

1) Fix a crash in AF_XDP's xsk_diag_put_ring() which was passing
   wrong queue argument, from Eric.

2) Fix a regression due to wrong test for TCP GSO packets used in
   various BPF helpers like NAT64, from Willem.

3) Fix a sk_msg strparser warning which asserts that strparser must
   be stopped first, from Jakub.

4) Fix rejection of invalid options/bind flags in AF_XDP, from Björn.

5) Fix GSO in bpf_lwt_push_ip_encap() which must properly set inner
   headers and inner protocol, from Peter.

6) Fix a libbpf leak when kernel does not support BTF, from Nikita.

7) Various BPF selftest and libbpf build fixes to make out-of-tree
   compilation work and to properly resolve dependencies via fixdep
   target, from Stanislav.

8) Fix rejection of invalid ldimm64 imm field, from Daniel.

9) Fix bpf stats sysctl compile warning of unused helper function
   proc_dointvec_minmax_bpf_stats() under some configs, from Arnd.

10) Fix couple of warnings about using plain integer as NULL, from Bo.

11) Fix some BPF sample spelling mistakes, from Colin.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Thanks a lot!

----------------------------------------------------------------

The following changes since commit a10674bf2406afc2554f9c7d31b2dc65d6a27fd9:

  tcp: detecting the misuse of .sendpage for Slab objects (2019-03-06 10:48:31 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 

for you to fetch changes up to 71b91a506bb05f9aef3acd57af2e835d85721942:

  bpf: fix warning about using plain integer as NULL (2019-03-08 21:17:07 +0100)

----------------------------------------------------------------
Arnd Bergmann (1):
      bpf: fix sysctl.c warning

Björn Töpel (2):
      xsk: fix to reject invalid flags in xsk_bind
      xsk: fix to reject invalid options in Tx descriptor

Bo YU (1):
      bpf: fix warning about using plain integer as NULL

Colin Ian King (1):
      bpf: hbm: fix spelling mistake "deault" -> "default"

Daniel Borkmann (1):
      bpf: fix replace_map_fd_with_map_ptr's ldimm64 second imm field

Eric Dumazet (1):
      xsk: fix potential crash in xsk_diag_put_umem()

Jakub Sitnicki (1):
      bpf: Stop the psock parser before canceling its work

Nikita V. Shirokov (1):
      bpf, libbpf: fixing leak when kernel does not support btf

Peter Oskolkov (2):
      net: fix GSO in bpf_lwt_push_ip_encap
      selftests/bpf: test that GSO works in lwt_ip_encap

Stanislav Fomichev (3):
      selftests: bpf: fix compilation with out-of-tree $(OUTPUT)
      libbpf: force fixdep compilation at the start of the build
      selftests: bpf: test_progs: initialize duration in singal_pending test

Willem de Bruijn (1):
      bpf: only test gso type on gso packets

 include/linux/bpf-cgroup.h                         |  2 +-
 include/linux/skbuff.h                             |  4 +-
 kernel/bpf/verifier.c                              | 10 ++--
 kernel/sysctl.c                                    |  2 +-
 net/bpf/test_run.c                                 |  2 +-
 net/core/filter.c                                  |  8 ++--
 net/core/lwt_bpf.c                                 |  2 +
 net/core/skmsg.c                                   |  1 +
 net/xdp/xsk.c                                      |  5 +-
 net/xdp/xsk_diag.c                                 |  4 +-
 net/xdp/xsk_queue.h                                |  4 +-
 samples/bpf/hbm.c                                  |  4 +-
 tools/lib/bpf/Makefile                             |  3 +-
 tools/lib/bpf/libbpf.c                             |  2 +
 tools/testing/selftests/bpf/Makefile               | 33 +++++++++----
 .../selftests/bpf/prog_tests/signal_pending.c      |  2 +-
 tools/testing/selftests/bpf/test_lwt_ip_encap.sh   | 54 +++++++++++++++++++++-
 tools/testing/selftests/bpf/verifier/ld_imm64.c    | 15 +++++-
 18 files changed, 121 insertions(+), 36 deletions(-)
