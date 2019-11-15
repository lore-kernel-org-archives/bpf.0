Return-Path: <SRS0=5OmT=ZH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F404C432C3
	for <bpf@archiver.kernel.org>; Fri, 15 Nov 2019 23:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F18020733
	for <bpf@archiver.kernel.org>; Fri, 15 Nov 2019 23:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKOXJL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Nov 2019 18:09:11 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42444 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfKOXJK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Nov 2019 18:09:10 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::642])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 344F314EC3979;
        Fri, 15 Nov 2019 15:09:10 -0800 (PST)
Date:   Fri, 15 Nov 2019 15:09:06 -0800 (PST)
Message-Id: <20191115.150906.1714221627473925259.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     jakub.kicinski@netronome.com, ast@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf 2019-11-15
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191115221855.27728-1-daniel@iogearbox.net>
References: <20191115221855.27728-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 15 Nov 2019 15:09:10 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Fri, 15 Nov 2019 23:18:55 +0100

> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 1 non-merge commits during the last 9 day(s) which contain
> a total of 1 file changed, 3 insertions(+), 1 deletion(-).
> 
> The main changes are:
> 
> 1) Fix a missing unlock of bpf_devs_lock in bpf_offload_dev_create()'s
>    error path, from Dan.
> 
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Pulled, thanks Daniel.
