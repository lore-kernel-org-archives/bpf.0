Return-Path: <SRS0=D/lL=2J=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482E4C43603
	for <bpf@archiver.kernel.org>; Thu, 19 Dec 2019 22:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 246B12467B
	for <bpf@archiver.kernel.org>; Thu, 19 Dec 2019 22:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfLSWXs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:23:48 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:43198 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfLSWXs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Dec 2019 17:23:48 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 18F89153CA20C;
        Thu, 19 Dec 2019 14:23:48 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:23:47 -0800 (PST)
Message-Id: <20191219.142347.1602689351712386301.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     jakub.kicinski@netronome.com, ast@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf 2019-12-19
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191219215812.20451-1-daniel@iogearbox.net>
References: <20191219215812.20451-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 19 Dec 2019 14:23:48 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Thu, 19 Dec 2019 22:58:12 +0100

> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 10 non-merge commits during the last 8 day(s) which contain
> a total of 21 files changed, 269 insertions(+), 108 deletions(-).
> 
> The main changes are:
> 
> 1) Fix lack of synchronization between xsk wakeup and destroying resources
>    used by xsk wakeup, from Maxim Mikityanskiy.
> 
> 2) Fix pruning with tail call patching, untrack programs in case of verifier
>    error and fix a cgroup local storage tracking bug, from Daniel Borkmann.
> 
> 3) Fix clearing skb->tstamp in bpf_redirect() when going from ingress to
>    egress which otherwise cause issues e.g. on fq qdisc, from Lorenz Bauer.
> 
> 4) Fix compile warning of unused proc_dointvec_minmax_bpf_restricted() when
>    only cBPF is present, from Alexander Lobakin.

Pulled, thanks Daniel.
