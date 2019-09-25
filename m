Return-Path: <SRS0=z77e=XU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164AEC432C2
	for <bpf@archiver.kernel.org>; Wed, 25 Sep 2019 23:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5E121D7B
	for <bpf@archiver.kernel.org>; Wed, 25 Sep 2019 23:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gmrYnfSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732369AbfIYXnU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 25 Sep 2019 19:43:20 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:35553 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732977AbfIYXnU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Sep 2019 19:43:20 -0400
Received: by mail-pf1-f201.google.com with SMTP id r7so394759pfg.2
        for <bpf@vger.kernel.org>; Wed, 25 Sep 2019 16:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=letqQmLXhJ26rePJwfyNH6mOlQABi2YzpNRsxYXK53E=;
        b=gmrYnfSyTw1f26hABnX/14Tb9gHphBFSw9ysWsgslFndsIS/thnap2A+ID8uNwvGyr
         F7l1E+w5g3Hr1Imb/26usjnR+JYI70d9JOEXVJz4ZMI/wCTVSWWtM7AXAD0TpMP+Z6XM
         ASQTuWmoxQxoN/2VnRYGrfqpewkdqCwkbBsmhFCWZnCbYu4jWNlMSCV+iLV8uW0Q0Lif
         Ik3IeqlI2VjdwTtVN60S+lOApHVsy6ljioP7tLO7E+d94Pe8dMcMQ7iCbSfTOXez8EYh
         ugWmWP4uscscHN/HxOLgxnwxQQKqIVsRMCdzmFiETn6bUHWpv3JptiifMAgF+TJqPenD
         tb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=letqQmLXhJ26rePJwfyNH6mOlQABi2YzpNRsxYXK53E=;
        b=txO3W1WrkDbEICLsdP9Yp04CjQS/m53twNGxF4T4ovvjHq9PhIsQ5n29yI7n8YUmzM
         Jhc+28q6vindn1aa490vYgB32dO2aXZTNJdqlZQ3v/2E/DNGX+KyBT5SgjKKnhNNQuc0
         MpFO6ES2Ssv3L0J9PVzEdyR6c0TtSEpwUWw0oR9Xl7DDodGg2bQZGE5mCsYEosq+Uhqk
         lJYlOyWsy1S8qoqtume298sMaEdUm0OLPkUuwrQi8iBhEnyJkCx2gJZNN0TpIkTIA6cc
         RD8/TTOEKDTT2GPeY4t7jUHYNqD5QnTGCnEpPiuiEikzIIeMm7dFj+kyjOryDSWWCfUB
         VSkQ==
X-Gm-Message-State: APjAAAXbRSzszkibPPvSlAfJnGQ+Oye6BmGDrwpS8rybFGZoVBFZZ067
        Ac2JH6bCRKmhfRxjWhgBsrdhAGoa6Zz4mcBv
X-Google-Smtp-Source: APXvYqxQVs372ouu+aLaaayQVqtcE03MHqaadSJn7DSgd+z9iXf12wBvc9lGG+0dcKkpCNi+16J0Keb/KJRGd+Aa
X-Received: by 2002:a63:2104:: with SMTP id h4mr428099pgh.295.1569454998771;
 Wed, 25 Sep 2019 16:43:18 -0700 (PDT)
Date:   Wed, 25 Sep 2019 16:43:11 -0700
Message-Id: <20190925234312.94063-1-allanzhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH 0/1] bpf: Fix bpf_event_output re-entry issue
From:   Allan Zhang <allanzhang@google.com>
To:     daniel@iogearbox.net, songliubraving@fb.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Allan Zhang <allanzhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF_PROG_TYPE_SOCK_OPS program can reenter bpf_event_output because it can
be called from atomic and non-atomic contexts since we don't have
bpf_prog_active to prevent it happen.

This patch enables 3 level of nesting to support normal, irq and nmi
context.

We can easily reproduce the issue by running neper crr mode with 100 flows
and 10 threads from neper client side.

Allan Zhang (1):
  bpf: Fix bpf_event_output re-entry issue

 kernel/trace/bpf_trace.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

-- 
2.23.0.351.gc4317032e6-goog

