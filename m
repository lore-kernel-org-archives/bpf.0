Return-Path: <SRS0=B1s+=5M=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6837FC2D0EC
	for <bpf@archiver.kernel.org>; Fri, 27 Mar 2020 15:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EBD2074F
	for <bpf@archiver.kernel.org>; Fri, 27 Mar 2020 15:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbgC0P7O (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:59:14 -0400
Received: from www62.your-server.de ([213.133.104.62]:50914 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbgC0P7O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Mar 2020 11:59:14 -0400
Received: from 98.186.195.178.dynamic.wline.res.cust.swisscom.ch ([178.195.186.98] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jHrO3-0007mt-Bk; Fri, 27 Mar 2020 16:59:11 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     alexei.starovoitov@gmail.com
Cc:     m@lambda.lt, joe@wand.net.nz, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 0/7] Various improvements to cgroup helpers
Date:   Fri, 27 Mar 2020 16:58:49 +0100
Message-Id: <cover.1585323121.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25764/Fri Mar 27 14:11:26 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds various straight-forward helper improvements and additions to BPF
cgroup based connect(), sendmsg(), recvmsg() and bind-related hooks which
would allow to implement more fine-grained policies and improve current load
balancer limitations we're seeing. For details please see individual patches.
I've tested them on Kubernetes & Cilium and also added selftests for the small
verifier extension. Thanks!

Daniel Borkmann (7):
  bpf: enable retrieval of socket cookie for bind/post-bind hook
  bpf: enable perf event rb output for bpf cgroup progs
  bpf: add netns cookie and enable it for bpf cgroup hooks
  bpf: allow to retrieve cgroup v1 classid from v2 hooks
  bpf: enable bpf cgroup hooks to retrieve cgroup v2 and ancestor id
  bpf: enable retrival of pid/tgid/comm from bpf cgroup hooks
  bpf: add selftest cases for ctx_or_null argument type

 include/linux/bpf.h                        |   2 +
 include/net/cls_cgroup.h                   |   7 +-
 include/net/net_namespace.h                |  10 ++
 include/uapi/linux/bpf.h                   |  35 ++++++-
 kernel/bpf/core.c                          |   1 +
 kernel/bpf/helpers.c                       |  18 ++++
 kernel/bpf/verifier.c                      |  16 ++--
 net/core/filter.c                          | 106 ++++++++++++++++++++-
 net/core/net_namespace.c                   |  15 +++
 tools/include/uapi/linux/bpf.h             |  35 ++++++-
 tools/testing/selftests/bpf/verifier/ctx.c | 105 ++++++++++++++++++++
 11 files changed, 336 insertions(+), 14 deletions(-)

-- 
2.21.0

