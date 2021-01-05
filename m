Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F8DC433DB
	for <bpf@archiver.kernel.org>; Tue,  5 Jan 2021 21:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82EE822D71
	for <bpf@archiver.kernel.org>; Tue,  5 Jan 2021 21:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbhAEVoe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 5 Jan 2021 16:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731481AbhAEVod (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Jan 2021 16:44:33 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6945EC061574
        for <bpf@vger.kernel.org>; Tue,  5 Jan 2021 13:43:53 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a206so1377034ybg.0
        for <bpf@vger.kernel.org>; Tue, 05 Jan 2021 13:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=zFlZd2FCdj4URr5IwdL8bLtNPFRrSCuL2Fz9hv3TV9Q=;
        b=PR0Kx2vejPRGBbXBkX0wV+Q3OFtv7S9o7CVyHXVclwc94kBXMJLEsO81NRMueXiC0z
         iBl20Xf1ycRS5/j8U4kbpBEeYcMVn5KmMWhvZ685v+60SMj5IqfhH8LRAv0Xp/nzImsn
         1uG0WV9iLQLmIHpbi7sHMgmOU2mOhZHkC7GW6onNwZqwV8znWLMnsm5tEbwuHlv+HSFA
         kArF30C8XLcZj8g/82BrT251vklRMs4vFlKvmspmZQ5sb5Cmeqi0Mq0cRKTYnsj0Ea8L
         pDVJClVaINNkVMx3XXKh5Qflou9sBb+JOyoW33rJfjamRVH1L+cXV+8vGq8+Y7KNusSZ
         W7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=zFlZd2FCdj4URr5IwdL8bLtNPFRrSCuL2Fz9hv3TV9Q=;
        b=rE7cba66hFQYNjA377rslYFj6khXnsAA/jK8CGDXzoVGof4cOc4dM+xudNTnP44BXf
         VbGU3ie8ePbkMbfpU9lRni9Tn7QcU51eiXiBKAn/dxJ5EiDkIgW4m0R6WXchSFXUw4nA
         /aP3kJEC+57KiqDp0M4bxl5CUFUjtRZljph2olwXf5xZ3qSWdznAidIm0JD/CvHAX5l6
         NvmS68N9oSWF1U5HNvWPGYgWc7fKFQMOJQs3VW6OT0UIig87Tiwz/aa9oNWKoIY033VG
         IwmksriuT9GOdvT63u6ksSk3L+vVlTXF9Di2V/hyswnCy38QidBGV4cgoNsuiYph7xVv
         va/A==
X-Gm-Message-State: AOAM533sBokbgD6hsaUepGV8+WLmmXlcvsaZRRRgCNg7dNNTHM1Gu39M
        LRbLEjf3TcKo7mNQe3Bt3BIGptU=
X-Google-Smtp-Source: ABdhPJz2VYMe6EErrRJgW3fqXkoWhVZ1QPnGFOYbheJnEv8sGl5mSoYc4VwqfwxYhuuDxoUg2z28sYo=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a25:5303:: with SMTP id h3mr2179167ybb.58.1609883032626;
 Tue, 05 Jan 2021 13:43:52 -0800 (PST)
Date:   Tue,  5 Jan 2021 13:43:47 -0800
Message-Id: <20210105214350.138053-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH bpf-next v3 0/3] bpf: misc performance improvements for cgroup hooks
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

First patch tries to remove kzalloc/kfree from getsockopt for the
common cases.

Second patch switches cgroup_bpf_enabled to be per-attach to
to add only overhead for the cgroup attach types used on the system.

No visible user-side changes.

v3:
- remove extra newline, add comment about sizeof tcp_zerocopy_receive
  (Martin KaFai Lau)
- add another patch to remove lock_sock overhead from
  TCP_ZEROCOPY_RECEIVE; technically, this makes patch #1 obsolete,
  but I'd still prefer to keep it to help with other socket
  options

v2:
- perf numbers for getsockopt kmalloc reduction (Song Liu)
- (sk) in BPF_CGROUP_PRE_CONNECT_ENABLED (Song Liu)
- 128 -> 64 buffer size, BUILD_BUG_ON (Martin KaFai Lau)

Stanislav Fomichev (3):
  bpf: try to avoid kzalloc in cgroup/{s,g}etsockopt
  bpf: split cgroup_bpf_enabled per attach type
  bpf: remove extra lock_sock for TCP_ZEROCOPY_RECEIVE

 include/linux/bpf-cgroup.h                    |  52 ++++---
 include/linux/filter.h                        |   5 +
 kernel/bpf/cgroup.c                           | 132 +++++++++++++++---
 net/ipv4/af_inet.c                            |   9 +-
 net/ipv4/tcp.c                                |   2 +
 net/ipv4/udp.c                                |   7 +-
 net/ipv6/af_inet6.c                           |   9 +-
 net/ipv6/udp.c                                |   7 +-
 .../selftests/bpf/prog_tests/sockopt_sk.c     |  22 +++
 .../testing/selftests/bpf/progs/sockopt_sk.c  |  15 ++
 10 files changed, 205 insertions(+), 55 deletions(-)

-- 
2.29.2.729.g45daf8777d-goog

