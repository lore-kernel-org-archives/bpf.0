Return-Path: <SRS0=MX+Z=CG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDF4C433E6
	for <bpf@archiver.kernel.org>; Fri, 28 Aug 2020 23:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A58C208D5
	for <bpf@archiver.kernel.org>; Fri, 28 Aug 2020 23:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgH1XNN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 28 Aug 2020 19:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgH1XNN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Aug 2020 19:13:13 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89802C061264;
        Fri, 28 Aug 2020 16:13:12 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D060511E44284;
        Fri, 28 Aug 2020 15:56:23 -0700 (PDT)
Date:   Fri, 28 Aug 2020 16:13:07 -0700 (PDT)
Message-Id: <20200828.161307.457342644292007498.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     kuba@kernel.org, ast@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: pull-request: bpf 2020-08-28
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200828211452.31342-1-daniel@iogearbox.net>
References: <20200828211452.31342-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 28 Aug 2020 15:56:24 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Fri, 28 Aug 2020 23:14:52 +0200

> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 4 non-merge commits during the last 4 day(s) which contain
> a total of 4 files changed, 7 insertions(+), 4 deletions(-).
> 
> The main changes are:
> 
> 1) Fix out of bounds access for BPF_OBJ_GET_INFO_BY_FD retrieval, from Yonghong Song.
> 
> 2) Fix wrong __user annotation in bpf_stats sysctl handler, from Tobias Klauser.
> 
> 3) Few fixes for BPF selftest scripting in test_{progs,maps}, from Jesper Dangaard Brouer.
> 
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Pulled, thanks Daniel.
