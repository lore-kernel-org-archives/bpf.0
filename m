Return-Path: <SRS0=g+Ex=4R=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B319C3F2CD
	for <bpf@archiver.kernel.org>; Sat, 29 Feb 2020 23:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0F120409
	for <bpf@archiver.kernel.org>; Sat, 29 Feb 2020 23:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgB2XyL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 29 Feb 2020 18:54:11 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37232 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgB2XyL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 29 Feb 2020 18:54:11 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D226215BC313B;
        Sat, 29 Feb 2020 15:54:10 -0800 (PST)
Date:   Sat, 29 Feb 2020 15:54:08 -0800 (PST)
Message-Id: <20200229.155408.1060654540270815027.davem@davemloft.net>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: pull-request: bpf-next 2020-02-28
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200228231354.3226583-1-ast@kernel.org>
References: <20200228231354.3226583-1-ast@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 29 Feb 2020 15:54:11 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>
Date: Fri, 28 Feb 2020 15:13:54 -0800

> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 41 non-merge commits during the last 7 day(s) which contain
> a total of 49 files changed, 1383 insertions(+), 499 deletions(-).
> 
> The main changes are:
> 
> 1) BPF and Real-Time nicely co-exist.
> 
> 2) bpftool feature improvements.
> 
> 3) retrieve bpf_sk_storage via INET_DIAG.
> 
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

Pulled, so nice to see the RT stuff get resolved full circle.

Thanks.
