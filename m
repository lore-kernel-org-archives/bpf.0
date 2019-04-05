Return-Path: <SRS0=rZCH=SH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1ACC4360F
	for <bpf@archiver.kernel.org>; Fri,  5 Apr 2019 00:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0335A217D7
	for <bpf@archiver.kernel.org>; Fri,  5 Apr 2019 00:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbfDEAFP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:05:15 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54640 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfDEAFP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Apr 2019 20:05:15 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CD9F11473497C;
        Thu,  4 Apr 2019 17:05:14 -0700 (PDT)
Date:   Thu, 04 Apr 2019 17:05:10 -0700 (PDT)
Message-Id: <20190404.170510.1437694563240301882.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     ast@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf 2019-04-04
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190404152141.19803-1-daniel@iogearbox.net>
References: <20190404152141.19803-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 04 Apr 2019 17:05:15 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Thu,  4 Apr 2019 17:21:41 +0200

> The following pull-request contains BPF updates for your *net* tree.
> 
> The main changes are:
> 
> 1) Batch of fixes to the existing BPF flow dissector API to support
>    calling BPF programs from the eth_get_headlen context (support for
>    latter is planned to be added in bpf-next), from Stanislav.
> 
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Pulled, thanks Daniel.
