Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1313CC433E0
	for <bpf@archiver.kernel.org>; Wed, 20 Jan 2021 16:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0D92233F9
	for <bpf@archiver.kernel.org>; Wed, 20 Jan 2021 16:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbhATQiX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:38:23 -0500
Received: from www62.your-server.de ([213.133.104.62]:46586 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391326AbhATQf0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jan 2021 11:35:26 -0500
Received: from 30.101.7.85.dynamic.wline.res.cust.swisscom.ch ([85.7.101.30] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1l2GRM-000FPD-4A; Wed, 20 Jan 2021 17:34:40 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     davem@davemloft.net
Cc:     kuba@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        andrii@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: pull-request: bpf 2021-01-20
Date:   Wed, 20 Jan 2021 17:34:39 +0100
Message-Id: <20210120163439.8160-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26055/Wed Jan 20 13:29:54 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David, hi Jakub,

The following pull-request contains BPF updates for your *net* tree.

We've added 3 non-merge commits during the last 1 day(s) which contain
a total of 3 files changed, 6 insertions(+), 6 deletions(-).

The main changes are:

1) Fix wrong bpf_map_peek_elem_proto helper callback, from Mircea Cirjaliu.

2) Fix signed_{sub,add32}_overflows type truncation, from Daniel Borkmann.

3) Fix AF_XDP to also clear pools for inactive queues, from Maxim Mikityanskiy.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Alexei Starovoitov, Björn Töpel, De4dCr0w, John Fastabend

----------------------------------------------------------------

The following changes since commit f7b9820dbe1620a3d681991fc82774ae49c2b6d2:

  Merge branch 'sh_eth-fix-reboot-crash' (2021-01-19 12:02:23 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 

for you to fetch changes up to bc895e8b2a64e502fbba72748d59618272052a8b:

  bpf: Fix signed_{sub,add32}_overflows type handling (2021-01-20 17:19:40 +0100)

----------------------------------------------------------------
Daniel Borkmann (1):
      bpf: Fix signed_{sub,add32}_overflows type handling

Maxim Mikityanskiy (1):
      xsk: Clear pool even for inactive queues

Mircea Cirjaliu (1):
      bpf: Fix helper bpf_map_peek_elem_proto pointing to wrong callback

 kernel/bpf/helpers.c  | 2 +-
 kernel/bpf/verifier.c | 6 +++---
 net/xdp/xsk.c         | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)
