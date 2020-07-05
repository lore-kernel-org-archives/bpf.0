Return-Path: <SRS0=q05f=AQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBAAC433E0
	for <bpf@archiver.kernel.org>; Sun,  5 Jul 2020 00:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5175A20771
	for <bpf@archiver.kernel.org>; Sun,  5 Jul 2020 00:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgGEAtU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 4 Jul 2020 20:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgGEAtU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Jul 2020 20:49:20 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2048C061794;
        Sat,  4 Jul 2020 17:49:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5C89D157A9A35;
        Sat,  4 Jul 2020 17:49:20 -0700 (PDT)
Date:   Sat, 04 Jul 2020 17:49:19 -0700 (PDT)
Message-Id: <20200704.174919.1981095496223719163.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     kuba@kernel.org, ast@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: pull-request: bpf-next 2020-07-04
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200704001505.10610-1-daniel@iogearbox.net>
References: <20200704001505.10610-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 04 Jul 2020 17:49:20 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Sat,  4 Jul 2020 02:15:05 +0200

> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 73 non-merge commits during the last 17 day(s) which contain
> a total of 106 files changed, 5233 insertions(+), 1283 deletions(-).
> 
> The main changes are:
...
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

Pulled, thanks a lot Daniel.
