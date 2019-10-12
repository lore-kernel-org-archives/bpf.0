Return-Path: <SRS0=4NqM=YF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D92C4360C
	for <bpf@archiver.kernel.org>; Sat, 12 Oct 2019 18:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B94206A1
	for <bpf@archiver.kernel.org>; Sat, 12 Oct 2019 18:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfJLSWP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 12 Oct 2019 14:22:15 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60178 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729469AbfJLSWP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Oct 2019 14:22:15 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 85745150F0C4E;
        Sat, 12 Oct 2019 11:22:14 -0700 (PDT)
Date:   Sat, 12 Oct 2019 11:22:14 -0700 (PDT)
Message-Id: <20191012.112214.276286237936538961.davem@davemloft.net>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: pull-request: bpf 2019-10-12
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191012174534.931615-1-ast@kernel.org>
References: <20191012174534.931615-1-ast@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 12 Oct 2019 11:22:14 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>
Date: Sat, 12 Oct 2019 10:45:34 -0700

> The following pull-request contains BPF updates for your *net* tree.
> 
> The main changes are:
> 
> 1) a bunch of small fixes. Nothing critical.
> 
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Pulled, thanks Alexei.
