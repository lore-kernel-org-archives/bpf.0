Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25573C433E0
	for <bpf@archiver.kernel.org>; Fri, 29 Jan 2021 00:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D91D064E00
	for <bpf@archiver.kernel.org>; Fri, 29 Jan 2021 00:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhA2AQu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Jan 2021 19:16:50 -0500
Received: from www62.your-server.de ([213.133.104.62]:35242 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhA2AQt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 19:16:49 -0500
Received: from 30.101.7.85.dynamic.wline.res.cust.swisscom.ch ([85.7.101.30] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1l5HSG-00049F-5w; Fri, 29 Jan 2021 01:16:04 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     davem@davemloft.net
Cc:     kuba@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        andrii@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: pull-request: bpf 2021-01-29
Date:   Fri, 29 Jan 2021 01:15:56 +0100
Message-Id: <20210129001556.6648-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26063/Thu Jan 28 13:28:06 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David, hi Jakub,

The following pull-request contains BPF updates for your *net* tree.

We've added 5 non-merge commits during the last 6 day(s) which contain
a total of 4 files changed, 27 insertions(+), 3 deletions(-).

The main changes are:

1) Fix two copy_{from,to}_user() warn_on_once splats for BPF cgroup getsockopt
   infra when user space is trying to race against optlen, from Loris Reiff.

2) Fix a missing fput() in BPF inode storage map update helper, from Pan Bian.

3) Fix a build error on unresolved symbols on disabled networking / keys LSM
   hooks, from Mikko Ylinen.

4) Fix preload BPF prog build when the output directory from make points to a
   relative path, from Quentin Monnet.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Andrii Nakryiko, David Gow, KP Singh, Stanislav Fomichev

----------------------------------------------------------------

The following changes since commit 35c715c30b95205e64311c3bb3525094cd3d7236:

  Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec (2021-01-21 11:05:10 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 

for you to fetch changes up to 150a27328b681425c8cab239894a48f2aeb870e9:

  bpf, preload: Fix build when $(O) points to a relative path (2021-01-26 23:13:25 +0100)

----------------------------------------------------------------
Loris Reiff (2):
      bpf, cgroup: Fix optlen WARN_ON_ONCE toctou
      bpf, cgroup: Fix problematic bounds check

Mikko Ylinen (1):
      bpf: Drop disabled LSM hooks from the sleepable set

Pan Bian (1):
      bpf, inode_storage: Put file handler if no storage was found

Quentin Monnet (1):
      bpf, preload: Fix build when $(O) points to a relative path

 kernel/bpf/bpf_inode_storage.c |  6 +++++-
 kernel/bpf/bpf_lsm.c           | 12 ++++++++++++
 kernel/bpf/cgroup.c            |  7 ++++++-
 kernel/bpf/preload/Makefile    |  5 ++++-
 4 files changed, 27 insertions(+), 3 deletions(-)
