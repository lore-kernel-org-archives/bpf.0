Return-Path: <SRS0=QYON=7E=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D61BC433E0
	for <bpf@archiver.kernel.org>; Fri, 22 May 2020 21:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43CD52073B
	for <bpf@archiver.kernel.org>; Fri, 22 May 2020 21:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbgEVVTY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 May 2020 17:19:24 -0400
Received: from www62.your-server.de ([213.133.104.62]:37146 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730976AbgEVVTY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 May 2020 17:19:24 -0400
Received: from 75.57.196.178.dynamic.wline.res.cust.swisscom.ch ([178.196.57.75] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jcF4T-0004pr-Ny; Fri, 22 May 2020 23:19:13 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     davem@davemloft.net
Cc:     kuba@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: pull-request: bpf 2020-05-22
Date:   Fri, 22 May 2020 23:19:13 +0200
Message-Id: <20200522211913.25281-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25820/Fri May 22 14:21:08 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

The following pull-request contains BPF updates for your *net* tree.

We've added 3 non-merge commits during the last 3 day(s) which contain
a total of 5 files changed, 69 insertions(+), 11 deletions(-).

The main changes are:

1) Fix to reject mmap()'ing read-only array maps as writable since BPF verifier
   relies on such map content to be frozen, from Andrii Nakryiko.

2) Fix breaking audit from secid_to_secctx() LSM hook by avoiding to use
   call_int_hook() since this hook is not stackable, from KP Singh.

3) Fix BPF flow dissector program ref leak on netns cleanup, from Jakub Sitnicki.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Alexei Starovoitov, James Morris, Jann Horn, Stanislav Fomichev

----------------------------------------------------------------

The following changes since commit 20a785aa52c82246055a089e55df9dac47d67da1:

  sctp: Don't add the shutdown timer if its already been added (2020-05-19 15:46:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 

for you to fetch changes up to 5cf65922bb15279402e1e19b5ee8c51d618fa51f:

  flow_dissector: Drop BPF flow dissector prog ref on netns cleanup (2020-05-21 17:52:45 -0700)

----------------------------------------------------------------
Andrii Nakryiko (1):
      bpf: Prevent mmap()'ing read-only maps as writable

Jakub Sitnicki (1):
      flow_dissector: Drop BPF flow dissector prog ref on netns cleanup

KP Singh (1):
      security: Fix hook iteration for secid_to_secctx

 kernel/bpf/syscall.c                          | 17 ++++++++++++++---
 net/core/flow_dissector.c                     | 26 +++++++++++++++++++++-----
 security/security.c                           | 16 ++++++++++++++--
 tools/testing/selftests/bpf/prog_tests/mmap.c | 13 ++++++++++++-
 tools/testing/selftests/bpf/progs/test_mmap.c |  8 ++++++++
 5 files changed, 69 insertions(+), 11 deletions(-)
