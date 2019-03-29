Return-Path: <SRS0=W4j7=SA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D133C43381
	for <bpf@archiver.kernel.org>; Fri, 29 Mar 2019 22:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1E0217F5
	for <bpf@archiver.kernel.org>; Fri, 29 Mar 2019 22:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbfC2Wu4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:50:56 -0400
Received: from www62.your-server.de ([213.133.104.62]:43618 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730495AbfC2Wu4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Mar 2019 18:50:56 -0400
Received: from [178.197.248.24] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hA0Kp-0005v1-1X; Fri, 29 Mar 2019 23:50:51 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: pull-request: bpf 2019-03-29
Date:   Fri, 29 Mar 2019 23:50:50 +0100
Message-Id: <20190329225050.8819-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25403/Fri Mar 29 08:55:56 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

The following pull-request contains BPF updates for your *net* tree.

The main changes are:

1) Bug fix in BTF deduplication that was mishandling an equivalence
   comparison, from Andrii.

2) libbpf Makefile fixes to properly link against libelf for the shared
   object and to actually export AF_XDP's xsk.h header, from Björn.

3) Fix use after free in bpf inode eviction, from Daniel.

4) Fix a bug in skb creation out of cpumap redirect, from Jesper.

5) Remove an unnecessary and triggerable WARN_ONCE() in max number
   of call stack frames checking in verifier, from Paul.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Thanks a lot!

----------------------------------------------------------------

The following changes since commit 27602e2c44da4091bef99e6c877e20c78b7f6e81:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2019-03-24 23:45:35 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 

for you to fetch changes up to 676e4a6fe703f2dae699ee9d56f14516f9ada4ea:

  xdp: fix cpumap redirect SKB creation bug (2019-03-29 12:15:02 -0700)

----------------------------------------------------------------
Alexei Starovoitov (2):
      Merge branch 'fix-verifier-warning'
      Merge branch 'fix-btf_dedup'

Andrii Nakryiko (2):
      libbpf: fix btf_dedup equivalence check handling of different kinds
      selftests/bpf: add btf_dedup test for VOID equivalence check

Björn Töpel (2):
      libbpf: add xsk.h to install_headers target
      libbpf: add libelf dependency to shared library build

Daniel Borkmann (2):
      bpf: fix use after free in bpf_evict_inode
      bpf, libbpf: fix quiet install_headers

Jesper Dangaard Brouer (2):
      bpf, doc: fix BTF docs reflow of bullet list
      xdp: fix cpumap redirect SKB creation bug

Paul Chaignon (2):
      bpf: remove incorrect 'verifier bug' warning
      selftests/bpf: test case for invalid call stack in dead code

 Documentation/bpf/btf.rst                    |  8 ++---
 kernel/bpf/cpumap.c                          | 13 ++++++--
 kernel/bpf/inode.c                           | 32 ++++++++++---------
 kernel/bpf/verifier.c                        |  5 +--
 tools/lib/bpf/Makefile                       |  7 +++--
 tools/lib/bpf/btf.c                          |  3 ++
 tools/testing/selftests/bpf/test_btf.c       | 47 ++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/verifier/calls.c | 38 ++++++++++++++++++++++
 8 files changed, 127 insertions(+), 26 deletions(-)
