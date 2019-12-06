Return-Path: <SRS0=l/5z=Z4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CAAC43603
	for <bpf@archiver.kernel.org>; Fri,  6 Dec 2019 08:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D39B24685
	for <bpf@archiver.kernel.org>; Fri,  6 Dec 2019 08:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfLFIEh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 6 Dec 2019 03:04:37 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52648 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfLFIEh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Dec 2019 03:04:37 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3258514BA38AE;
        Fri,  6 Dec 2019 00:04:36 -0800 (PST)
Date:   Fri, 06 Dec 2019 00:04:31 -0800 (PST)
Message-Id: <20191206.000431.1823406760870683874.davem@davemloft.net>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: pull-request: bpf 2019-12-05
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191206061857.3660737-1-ast@kernel.org>
References: <20191206061857.3660737-1-ast@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 06 Dec 2019 00:04:36 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>
Date: Thu, 5 Dec 2019 22:18:57 -0800

> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 6 non-merge commits during the last 1 day(s) which contain
> a total of 14 files changed, 116 insertions(+), 37 deletions(-).
> 
> The main changes are:
> 
> 1) three selftests fixes, from Stanislav.
> 
> 2) one samples fix, from Jesper.
> 
> 3) one verifier fix, from Yonghong.
> 
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Pulled, thanks Alexei.
