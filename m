Return-Path: <SRS0=8uh4=SB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0ECC43381
	for <bpf@archiver.kernel.org>; Sat, 30 Mar 2019 04:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B4420663
	for <bpf@archiver.kernel.org>; Sat, 30 Mar 2019 04:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfC3EAu convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Sat, 30 Mar 2019 00:00:50 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38424 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfC3EAu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 30 Mar 2019 00:00:50 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1940B106F2CD7;
        Fri, 29 Mar 2019 21:00:50 -0700 (PDT)
Date:   Fri, 29 Mar 2019 21:00:47 -0700 (PDT)
Message-Id: <20190329.210047.1352407250750665635.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     ast@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf 2019-03-29
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190329225050.8819-1-daniel@iogearbox.net>
References: <20190329225050.8819-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 29 Mar 2019 21:00:50 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Fri, 29 Mar 2019 23:50:50 +0100

> The following pull-request contains BPF updates for your *net* tree.
> 
> The main changes are:
> 
> 1) Bug fix in BTF deduplication that was mishandling an equivalence
>    comparison, from Andrii.
> 
> 2) libbpf Makefile fixes to properly link against libelf for the shared
>    object and to actually export AF_XDP's xsk.h header, from Björn.
> 
> 3) Fix use after free in bpf inode eviction, from Daniel.
> 
> 4) Fix a bug in skb creation out of cpumap redirect, from Jesper.
> 
> 5) Remove an unnecessary and triggerable WARN_ONCE() in max number
>    of call stack frames checking in verifier, from Paul.
> 
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Pulled, thanks Daniel.
