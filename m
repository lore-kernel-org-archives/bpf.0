Return-Path: <SRS0=XeSK=W2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4733C3A59B
	for <bpf@archiver.kernel.org>; Fri, 30 Aug 2019 23:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE2923430
	for <bpf@archiver.kernel.org>; Fri, 30 Aug 2019 23:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfH3XkN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 30 Aug 2019 19:40:13 -0400
Received: from www62.your-server.de ([213.133.104.62]:33810 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbfH3XkN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Aug 2019 19:40:13 -0400
Received: from [178.197.249.19] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1i3qUx-0005ai-D0; Sat, 31 Aug 2019 01:40:07 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: pull-request: bpf 2019-08-31
Date:   Sat, 31 Aug 2019 01:40:06 +0200
Message-Id: <20190830234006.31988-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25557/Fri Aug 30 10:30:29 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

The following pull-request contains BPF updates for your *net* tree.

The main changes are:

1) Fix 32-bit zero-extension during constant blinding which
   has been causing a regression on ppc64, from Naveen.

2) Fix a latency bug in nfp driver when updating stack index
   register, from Jiong.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Thanks a lot!

----------------------------------------------------------------

The following changes since commit f53a7ad189594a112167efaf17ea8d0242b5ac00:

  r8152: Set memory to all 0xFFs on failed reg reads (2019-08-25 19:52:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 

for you to fetch changes up to ede7c460b1da5be7b8ef4efe47f1687babf06408:

  bpf: handle 32-bit zext during constant blinding (2019-08-26 23:05:01 +0200)

----------------------------------------------------------------
Jiong Wang (1):
      nfp: bpf: fix latency bug when updating stack index register

Naveen N. Rao (1):
      bpf: handle 32-bit zext during constant blinding

 drivers/net/ethernet/netronome/nfp/bpf/jit.c | 17 +++++++++++++----
 kernel/bpf/core.c                            |  8 ++++++--
 2 files changed, 19 insertions(+), 6 deletions(-)
