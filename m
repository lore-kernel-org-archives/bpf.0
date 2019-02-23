Return-Path: <SRS0=Kw1S=Q6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16651C43381
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 00:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B7D207E0
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 00:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbfBWAg1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:36:27 -0500
Received: from www62.your-server.de ([213.133.104.62]:33132 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBWAg1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Feb 2019 19:36:27 -0500
Received: from [178.197.248.36] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gxLIn-0002mr-Cx; Sat, 23 Feb 2019 01:36:25 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: pull-request: bpf 2019-02-23
Date:   Sat, 23 Feb 2019 01:36:25 +0100
Message-Id: <20190223003625.32021-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25368/Fri Feb 22 11:32:58 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

The following pull-request contains BPF updates for your *net* tree.

The main changes are:

1) Fix a bug in BPF's LPM deletion logic to match correct prefix
   length, from Alban.

2) Fix AF_XDP teardown by not destroying umem prematurely as it
   is still needed till all outstanding skbs are freed, from Björn.

3) Fix unkillable BPF_PROG_TEST_RUN under preempt kernel by checking
   signal_pending() outside need_resched() condition which is never
   triggered there, from Stanislav.

4) Fix two nfp JIT bugs, one in code emission for K-based xor, and
   another one to explicitly clear upper bits in alu32, from Jiong.

5) Add bpf list address to maintainers file, from Daniel.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Thanks a lot!

----------------------------------------------------------------

The following changes since commit 21d2cb491b9e10bfdf10424673b43cd9eddc2da1:

  net/mlx4_en: fix spelling mistake: "quiting" -> "quitting" (2019-02-18 12:06:42 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 

for you to fetch changes up to b4b8bb69c104a9345c528692cde5aa520d885360:

  bpf, doc: add bpf list as secondary entry to maintainers file (2019-02-23 01:22:32 +0100)

----------------------------------------------------------------
Alban Crequy (1):
      bpf, lpm: fix lookup bug in map_delete_elem

Björn Töpel (1):
      Revert "xsk: simplify AF_XDP socket teardown"

Daniel Borkmann (2):
      Merge branch 'bpf-nfp-codegen-fixes'
      bpf, doc: add bpf list as secondary entry to maintainers file

Jiong Wang (2):
      nfp: bpf: fix code-gen bug on BPF_ALU | BPF_XOR | BPF_K
      nfp: bpf: fix ALU32 high bits clearance bug

Stanislav Fomichev (1):
      bpf/test_run: fix unkillable BPF_PROG_TEST_RUN

 MAINTAINERS                                  | 14 ++++++++-
 drivers/net/ethernet/netronome/nfp/bpf/jit.c | 17 ++++-------
 kernel/bpf/lpm_trie.c                        |  1 +
 net/bpf/test_run.c                           | 45 +++++++++++++++-------------
 net/xdp/xsk.c                                | 16 +++++++++-
 tools/testing/selftests/bpf/test_lpm_map.c   | 10 +++++++
 6 files changed, 69 insertions(+), 34 deletions(-)
