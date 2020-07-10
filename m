Return-Path: <SRS0=293s=AV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF04C433E2
	for <bpf@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EBAF20786
	for <bpf@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sr6ITStG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgGJCsd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgGJCs3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jul 2020 22:48:29 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9A5C08C5CE;
        Thu,  9 Jul 2020 19:48:28 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m9so1894313pfh.0;
        Thu, 09 Jul 2020 19:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P95UtldEouKDTAy10OaU4pEDBDGzQSR+nZFkOOzzimY=;
        b=sr6ITStG6tWbOZqzEsXXU99rOz2NF2cn37TAjtuD1vQAyEvQ/1w0CCXyZRem6ZPP13
         IlWGoyHaUPgUJdV8+T64CMShDosBXcxy6KQhm5hWHWlNg6vvbJ3lmhEqT49GXI92ZY/3
         RI9x/YMOVn2zcBYSF6OLJ/ZOT08Nw0W4voexosFib47WsRIbkmWFyfXWxGSGKPWWVwyD
         C5quamlGFnPH6QxH9o0CblFCbiHe1/PtTC/ajxYmBVg7N18NJp//eRb/qyLrIHZcHlKY
         oPZ43EXZztNWnYDcHdJFXYk9Rr3Uz4RwYvKfSW8onNsKPHDVZBiguse6svbe173GgNRz
         hH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P95UtldEouKDTAy10OaU4pEDBDGzQSR+nZFkOOzzimY=;
        b=KborWSgMeDOm2W5mI9z3JWYp7HLwXis5yd3nTbJijf+VhAVaMw7g2IdoQcSa+1Zz4s
         /dAvyXIReWM6s6TGd/NHev+5dg095LlZYHQpzx0xdHwCVEZMfDOHHEESzHp64bQsLpMY
         WerfKnlYjHQa1zqHp2n3QX7De8llmAL0jNCtrClBS1XjzlDk+LigKDAy40Nm2oVpXTLk
         0FOIWYd+Y6EgtmHwD1pgfb06DRWz93rQlk70WDshKeKBHVeXcSR2/Zse8+oQxS3tgMA4
         T6pzd+DjGbv5PGWameem57slf8QgKjQlGy5JkDKUR8mBHBm0UsSJYzOuPUxK3MSJMkJ0
         QHNg==
X-Gm-Message-State: AOAM531exftPjPJVJ9orHk7VP/eJo6FXUtG05S6K+PF0n4CYvEHjCfOP
        wBwgPLCojLOdY4h4YoykJlnOD+6C
X-Google-Smtp-Source: ABdhPJy55afd/4qoo5QXR1/6VT3dKEnTRFlm8EpJvfkZ3tb2BblYXX59ZztW7ahSaPY42uW1qVajrw==
X-Received: by 2002:a63:d944:: with SMTP id e4mr56237659pgj.376.1594349308279;
        Thu, 09 Jul 2020 19:48:28 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id u66sm4143509pfb.191.2020.07.09.19.48.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 19:48:26 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: pull-request: bpf 2020-07-09
Date:   Thu,  9 Jul 2020 19:48:24 -0700
Message-Id: <20200710024824.16936-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

The following pull-request contains BPF updates for your *net* tree.

We've added 4 non-merge commits during the last 1 day(s) which contain
a total of 4 files changed, 26 insertions(+), 15 deletions(-).

The main changes are:

1) fix crash in libbpf on 32-bit archs, from Jakub and Andrii.

2) fix crash when l2tp and bpf_sk_reuseport conflict, from Martin.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Jakub Sitnicki, James Chapman, Martin KaFai Lau

----------------------------------------------------------------

The following changes since commit 365f9ae4ee36037e2a9268fe7296065356840b4c:

  ethtool: fix genlmsg_put() failure handling in ethnl_default_dumpit() (2020-07-09 12:35:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 

for you to fetch changes up to b2f9f1535bb93ee5fa2ea30ac1c26fa0d676154c:

  libbpf: Fix libbpf hashmap on (I)LP32 architectures (2020-07-09 19:38:55 -0700)

----------------------------------------------------------------
Jakub Bogusz (1):
      libbpf: Fix libbpf hashmap on (I)LP32 architectures

Lorenz Bauer (1):
      selftests: bpf: Fix detach from sockmap tests

Martin KaFai Lau (2):
      bpf: net: Avoid copying sk_user_data of reuseport_array during sk_clone
      bpf: net: Avoid incorrect bpf_sk_reuseport_detach call

 include/net/sock.h                      |  3 ++-
 kernel/bpf/reuseport_array.c            | 14 ++++++++++----
 tools/lib/bpf/hashmap.h                 | 12 ++++++++----
 tools/testing/selftests/bpf/test_maps.c | 12 ++++++------
 4 files changed, 26 insertions(+), 15 deletions(-)
