Return-Path: <SRS0=5TR3=DF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8938C2D0A8
	for <bpf@archiver.kernel.org>; Mon, 28 Sep 2020 14:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2608221E8
	for <bpf@archiver.kernel.org>; Mon, 28 Sep 2020 14:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgI1OjD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 28 Sep 2020 10:39:03 -0400
Received: from www62.your-server.de ([213.133.104.62]:59206 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgI1OjD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Sep 2020 10:39:03 -0400
Received: from 75.57.196.178.dynamic.wline.res.cust.swisscom.ch ([178.196.57.75] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1kMuIv-0002dJ-CU; Mon, 28 Sep 2020 16:39:01 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, john.fastabend@gmail.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 0/6] Various BPF helper improvements
Date:   Mon, 28 Sep 2020 16:38:51 +0200
Message-Id: <cover.1601303057.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25940/Sun Sep 27 15:51:36 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series adds two BPF helpers, that is, one for retrieving the classid
of an skb and another one to redirect via the neigh subsystem, and improves
also the cookie helpers by removing the atomic counter. I've also added
the bpf_tail_call_static() helper to the libbpf API that we've been using
in Cilium for a while now, and last but not least the series adds a few
selftests. For details, please check individual patches, thanks!

v1 -> v2:
  - Rework cookie generator to support nested contexts (Eric)
  - Use ip_neigh_gw6() and container_of() (David)
  - Rename __throw_build_bug() and improve comments (Andrii)
  - Use bpf_tail_call_static() also in BPF samples (Maciej)

Daniel Borkmann (6):
  bpf: add classid helper only based on skb->sk
  bpf, net: rework cookie generator as per-cpu one
  bpf: add redirect_neigh helper as redirect drop-in
  bpf, libbpf: add bpf_tail_call_static helper for bpf programs
  bpf, selftests: use bpf_tail_call_static where appropriate
  bpf, selftests: add redirect_neigh selftest

 include/linux/cookie.h                        |  50 +++
 include/linux/skbuff.h                        |   5 +
 include/linux/sock_diag.h                     |  14 +-
 include/net/net_namespace.h                   |   2 +-
 include/uapi/linux/bpf.h                      |  24 ++
 kernel/bpf/reuseport_array.c                  |   2 +-
 net/core/filter.c                             | 286 ++++++++++++++++--
 net/core/net_namespace.c                      |   9 +-
 net/core/sock_diag.c                          |   9 +-
 net/core/sock_map.c                           |   4 +-
 samples/bpf/sockex3_kern.c                    |  20 +-
 tools/include/uapi/linux/bpf.h                |  24 ++
 tools/lib/bpf/bpf_helpers.h                   |  46 +++
 tools/testing/selftests/bpf/progs/bpf_flow.c  |  12 +-
 tools/testing/selftests/bpf/progs/tailcall1.c |  28 +-
 tools/testing/selftests/bpf/progs/tailcall2.c |  14 +-
 tools/testing/selftests/bpf/progs/tailcall3.c |   4 +-
 .../selftests/bpf/progs/tailcall_bpf2bpf1.c   |   4 +-
 .../selftests/bpf/progs/tailcall_bpf2bpf2.c   |   6 +-
 .../selftests/bpf/progs/tailcall_bpf2bpf3.c   |   6 +-
 .../selftests/bpf/progs/tailcall_bpf2bpf4.c   |   6 +-
 .../selftests/bpf/progs/test_tc_neigh.c       | 144 +++++++++
 tools/testing/selftests/bpf/test_tc_neigh.sh  | 168 ++++++++++
 23 files changed, 807 insertions(+), 80 deletions(-)
 create mode 100644 include/linux/cookie.h
 create mode 100644 tools/testing/selftests/bpf/progs/test_tc_neigh.c
 create mode 100755 tools/testing/selftests/bpf/test_tc_neigh.sh

-- 
2.21.0

