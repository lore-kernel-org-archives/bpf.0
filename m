Return-Path: <SRS0=Mla6=7A=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A50C433DF
	for <bpf@archiver.kernel.org>; Mon, 18 May 2020 15:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CB1C205CB
	for <bpf@archiver.kernel.org>; Mon, 18 May 2020 15:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgERPfg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 18 May 2020 11:35:36 -0400
Received: from www62.your-server.de ([213.133.104.62]:34738 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgERPfg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 May 2020 11:35:36 -0400
Received: from 75.57.196.178.dynamic.wline.res.cust.swisscom.ch ([178.196.57.75] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jahnh-00028o-H7; Mon, 18 May 2020 17:35:33 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, rdna@fb.com,
        sdf@google.com, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 0/4] Add get{peer,sock}name cgroup attach types
Date:   Mon, 18 May 2020 17:35:11 +0200
Message-Id: <cover.1589813738.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25816/Mon May 18 14:17:08 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Trivial patch to add get{peer,sock}name cgroup attach types to the BPF
sock_addr programs in order to enable rewriting sockaddr structs from
both calls along with libbpf and bpftool support as well as selftests.

Thanks!

Daniel Borkmann (4):
  bpf: add get{peer,sock}name attach types for sock_addr
  bpf, libbpf: enable get{peer,sock}name attach types
  bpf, bpftool: enable get{peer,sock}name attach types
  bpf, testing: add get{peer,sock}name selftests to test_progs

 include/linux/bpf-cgroup.h                    |   1 +
 include/uapi/linux/bpf.h                      |   4 +
 kernel/bpf/syscall.c                          |  12 ++
 kernel/bpf/verifier.c                         |   6 +-
 net/core/filter.c                             |   4 +
 net/ipv4/af_inet.c                            |   8 +-
 net/ipv6/af_inet6.c                           |   9 +-
 .../bpftool/Documentation/bpftool-cgroup.rst  |  10 +-
 .../bpftool/Documentation/bpftool-prog.rst    |   3 +-
 tools/bpf/bpftool/bash-completion/bpftool     |  15 ++-
 tools/bpf/bpftool/cgroup.c                    |   7 +-
 tools/bpf/bpftool/main.h                      |   4 +
 tools/bpf/bpftool/prog.c                      |   6 +-
 tools/include/uapi/linux/bpf.h                |   4 +
 tools/lib/bpf/libbpf.c                        |   8 ++
 tools/testing/selftests/bpf/network_helpers.c |  11 +-
 tools/testing/selftests/bpf/network_helpers.h |   1 +
 .../bpf/prog_tests/connect_force_port.c       | 107 +++++++++++++-----
 .../selftests/bpf/progs/connect_force_port4.c |  59 +++++++++-
 .../selftests/bpf/progs/connect_force_port6.c |  70 +++++++++++-
 20 files changed, 295 insertions(+), 54 deletions(-)

-- 
2.21.0

