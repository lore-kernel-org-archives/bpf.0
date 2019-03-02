Return-Path: <SRS0=p5ic=RF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A662BC43381
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 05:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7772A20838
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 05:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfCBFs1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 2 Mar 2019 00:48:27 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:35006 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfCBFs1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Mar 2019 00:48:27 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4F1DD144DC6CC;
        Fri,  1 Mar 2019 21:48:26 -0800 (PST)
Date:   Fri, 01 Mar 2019 21:48:25 -0800 (PST)
Message-Id: <20190301.214825.903878252660564628.davem@davemloft.net>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: pull-request: bpf 2019-03-01
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190302053538.642410-1-ast@kernel.org>
References: <20190302053538.642410-1-ast@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 01 Mar 2019 21:48:26 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>
Date: Fri, 1 Mar 2019 21:35:38 -0800

> The following pull-request contains BPF updates for your *net* tree.
> 
> The main changes are:
> 
> 1) fix sanitation rewrite, from Daniel.
> 
> 2) fix error path on map_new_fd, from Peng.
> 
> 3) fix icache flush address, from Paul.
> 
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Pulled, thanks Alexei.
