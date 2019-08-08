Return-Path: <SRS0=og6p=WE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46381C433FF
	for <bpf@archiver.kernel.org>; Thu,  8 Aug 2019 09:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9582173E
	for <bpf@archiver.kernel.org>; Thu,  8 Aug 2019 09:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731502AbfHHJuE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 8 Aug 2019 05:50:04 -0400
Received: from www62.your-server.de ([213.133.104.62]:34844 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731460AbfHHJuE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Aug 2019 05:50:04 -0400
Received: from [2a02:120b:2c12:c120:71a0:62dd:894c:fd0e] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hvf3W-0006Hx-VP; Thu, 08 Aug 2019 11:49:59 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, m@lambda.lt,
        edumazet@google.com, ast@kernel.org, willemb@google.com,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net 0/2] Fix collisions in socket cookie generation
Date:   Thu,  8 Aug 2019 11:49:35 +0200
Message-Id: <20190808094937.26918-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25535/Thu Aug  8 10:18:42 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change makes the socket cookie generator as a global counter
instead of per netns in order to fix cookie collisions for BPF use
cases we ran into. See main patch #1 for more details.

Given the change is small/trivial and fixes an issue we're seeing
my preference would be net tree (though it cleanly applies to
net-next as well). Went for net tree instead of bpf tree here given
the main change is in net/core/sock_diag.c, but either way would be
fine with me.

Thanks a lot!

Daniel Borkmann (2):
  sock: make cookie generation global instead of per netns
  bpf: sync bpf.h to tools infrastructure

 include/net/net_namespace.h    |  1 -
 include/uapi/linux/bpf.h       |  4 ++--
 net/core/sock_diag.c           |  3 ++-
 tools/include/uapi/linux/bpf.h | 11 +++++++----
 4 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.17.1

