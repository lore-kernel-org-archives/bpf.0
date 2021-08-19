Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B9DC4338F
	for <bpf@archiver.kernel.org>; Thu, 19 Aug 2021 14:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 098F761151
	for <bpf@archiver.kernel.org>; Thu, 19 Aug 2021 14:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhHSOtn (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 19 Aug 2021 10:49:43 -0400
Received: from www62.your-server.de ([213.133.104.62]:56620 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238634AbhHSOtn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Aug 2021 10:49:43 -0400
Received: from 65.47.5.85.dynamic.wline.res.cust.swisscom.ch ([85.5.47.65] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mGjLs-000Dc7-Kv; Thu, 19 Aug 2021 16:49:04 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     davem@davemloft.net
Cc:     kuba@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        andrii@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: pull-request: bpf 2021-08-19
Date:   Thu, 19 Aug 2021 16:49:04 +0200
Message-Id: <20210819144904.20069-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26268/Thu Aug 19 10:20:50 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David, hi Jakub,

The following pull-request contains BPF updates for your *net* tree.

We've added 3 non-merge commits during the last 3 day(s) which contain
a total of 3 files changed, 29 insertions(+), 6 deletions(-).

The main changes are:

1) Fix to clear zext_dst for dead instructions which was causing invalid program
   rejections on JITs with bpf_jit_needs_zext such as s390x, from Ilya Leoshkevich.

2) Fix RCU splat in bpf_get_current_{ancestor_,}cgroup_id() helpers when they are
   invoked from sleepable programs, from Yonghong Song.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Thanks a lot!

----------------------------------------------------------------

The following changes since commit 519133debcc19f5c834e7e28480b60bdc234fe02:

  net: bridge: fix memleak in br_add_if() (2021-08-10 13:25:14 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 

for you to fetch changes up to 3776f3517ed94d40ff0e3851d7ce2ce17b63099f:

  selftests, bpf: Test that dead ldx_w insns are accepted (2021-08-13 17:46:26 +0200)

----------------------------------------------------------------
Ilya Leoshkevich (2):
      bpf: Clear zext_dst of dead insns
      selftests, bpf: Test that dead ldx_w insns are accepted

Yonghong Song (1):
      bpf: Add rcu_read_lock in bpf_get_current_[ancestor_]cgroup_id() helpers

 kernel/bpf/helpers.c                             | 22 ++++++++++++++++------
 kernel/bpf/verifier.c                            |  1 +
 tools/testing/selftests/bpf/verifier/dead_code.c | 12 ++++++++++++
 3 files changed, 29 insertions(+), 6 deletions(-)
